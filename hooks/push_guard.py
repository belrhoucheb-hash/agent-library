#!/usr/bin/env python3
"""Push-guard voor de PreToolUse-hook op Bash.

Regel 1: een push naar main of master in een productie-repo (marker
.claude/production-repo in de repo) vraagt DEPLOY_OK=1 vóór het commando,
want CI deployt direct.
Regel 2: een push naar een branch waarvan de PR al gemerged is, wordt
geweigerd tenzij MERGED_PR_OK=1 vóór het commando staat. Zulke commits
bereiken de doelbranch nooit.

Beslist op het doel van de push, niet op woorden elders in het commando.
Exit 2 blokkeert; de melding op stderr gaat naar Claude.
"""
import json
import os
import re
import shlex
import subprocess
import sys

PROTECTED = {"main", "master"}
ALL_BRANCHES = "*alle branches*"
SPLIT = re.compile(r"&&|\|\||;|\||\n")
ASSIGN = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*=")
PUSH_OPTS_WITH_VALUE = {"-o", "--push-option", "--repo", "--receive-pack", "--exec"}
GIT_OPTS_WITH_VALUE = {"-C", "-c", "--git-dir", "--work-tree", "--namespace"}


def to_native(path):
    m = re.match(r"^/([a-zA-Z])(/.*)?$", path)
    if os.name == "nt" and m:
        return m.group(1).upper() + ":" + (m.group(2) or "/")
    return path


def git(args, cwd):
    try:
        r = subprocess.run(["git", *args], cwd=cwd, capture_output=True, text=True, timeout=10)
    except (OSError, subprocess.SubprocessError):
        return None
    return r.stdout.strip() if r.returncode == 0 else None


def split_words(segment):
    try:
        return shlex.split(segment, posix=True)
    except ValueError:
        return segment.split()


def resolve_dir(base, target):
    target = to_native(os.path.expandvars(os.path.expanduser(target)))
    path = target if os.path.isabs(target) else os.path.join(base, target)
    return path if os.path.isdir(path) else base


def pushes(command, start_dir):
    """Levert per push in het commando: (env-toewijzingen, map, argumenten)."""
    cwd = start_dir
    for segment in SPLIT.split(command):
        words = split_words(segment.strip())
        env = {}
        while words and ASSIGN.match(words[0]):
            key, _, value = words.pop(0).partition("=")
            env[key] = value
        if not words:
            continue
        if words[0] == "cd" and len(words) > 1:
            cwd = resolve_dir(cwd, words[1])
            continue
        if words[0] != "git":
            continue
        rest, run_dir = words[1:], cwd
        while rest and rest[0].startswith("-"):
            flag = rest.pop(0)
            if flag in GIT_OPTS_WITH_VALUE and rest:
                value = rest.pop(0)
                if flag == "-C":
                    run_dir = resolve_dir(run_dir, value)
        if rest and rest[0] == "push":
            yield env, run_dir, rest[1:]


def strip_prefix(ref, prefix):
    return ref[len(prefix):] if ref.startswith(prefix) else ref


def targets(args, run_dir):
    """Doelbranches van een push, en of het om verwijderen gaat."""
    flags, positional = set(), []
    it = iter(args)
    for arg in it:
        if arg in PUSH_OPTS_WITH_VALUE:
            next(it, None)
        elif arg.startswith("-"):
            flags.add(arg.split("=", 1)[0])
        else:
            positional.append(arg)
    deleting = bool(flags & {"-d", "--delete"})
    if flags & {"--all", "--mirror", "--branches"}:
        return {ALL_BRANCHES}, deleting
    refspecs = positional[1:]
    if not refspecs:
        if "--tags" in flags:
            return set(), deleting
        current = git(["branch", "--show-current"], run_dir)
        return ({current} if current else set()), deleting
    dests = set()
    for spec in refspecs:
        spec = spec.lstrip("+")
        if spec.startswith(":"):
            deleting = True
            spec = spec[1:]
        dest = spec.split(":", 1)[1] if ":" in spec else spec
        if dest == "HEAD":
            dest = git(["branch", "--show-current"], run_dir) or dest
        dests.add(strip_prefix(dest, "refs/heads/"))
    return dests, deleting


def production_repo(run_dir):
    roots = set()
    top = git(["rev-parse", "--show-toplevel"], run_dir)
    if top:
        roots.add(top)
    common = git(["rev-parse", "--git-common-dir"], run_dir)
    if common:
        if not os.path.isabs(common):
            common = os.path.join(run_dir, common)
        roots.add(os.path.dirname(os.path.normpath(common)))
    if not roots and os.environ.get("CLAUDE_PROJECT_DIR"):
        roots.add(to_native(os.environ["CLAUDE_PROJECT_DIR"]))
    return any(os.path.isfile(os.path.join(r, ".claude", "production-repo")) for r in roots)


def merged_pr(branch, run_dir):
    """PR-nummer als de branch alleen gemergde PR's heeft, anders None."""
    try:
        r = subprocess.run(
            ["gh", "pr", "list", "--head", branch, "--state", "all",
             "--json", "number,state", "--limit", "20"],
            cwd=run_dir, capture_output=True, text=True, timeout=20)
    except (OSError, subprocess.SubprocessError):
        return None
    if r.returncode != 0:
        return None
    try:
        prs = json.loads(r.stdout or "[]")
    except ValueError:
        return None
    if any(p.get("state") == "OPEN" for p in prs):
        return None
    merged = [p.get("number") for p in prs if p.get("state") == "MERGED"]
    return merged[0] if merged else None


def main():
    try:
        sys.stderr.reconfigure(encoding="utf-8")
    except AttributeError:
        pass
    raw = sys.stdin.buffer.read().decode("utf-8", "replace")
    try:
        data = json.loads(raw)
    except ValueError:
        return 0
    command = (data.get("tool_input") or {}).get("command") or ""
    start = to_native(data.get("cwd") or os.environ.get("CLAUDE_PROJECT_DIR") or os.getcwd())
    for env, run_dir, args in pushes(command, start):
        dests, deleting = targets(args, run_dir)
        if env.get("DEPLOY_OK") != "1" and production_repo(run_dir):
            hit = sorted(d for d in dests if d in PROTECTED or d == ALL_BRANCHES)
            if hit:
                print("Productie-repo: een push naar " + ", ".join(hit) + " deployt direct via CI.", file=sys.stderr)
                print("Vraag eerst expliciet akkoord aan Badr en zet daarna DEPLOY_OK=1 vóór het push-commando.", file=sys.stderr)
                return 2
        if deleting or env.get("MERGED_PR_OK") == "1":
            continue
        for dest in sorted(dests):
            if dest in PROTECTED or dest == ALL_BRANCHES:
                continue
            number = merged_pr(dest, run_dir)
            if number:
                print(f"PR #{number} van branch {dest} is al gemerged; nieuwe commits op deze branch bereiken de doelbranch nooit.", file=sys.stderr)
                print("Maak een nieuwe branch vanaf de doelbranch, cherry-pick de commits en open een nieuwe PR. Bewust toch pushen: zet MERGED_PR_OK=1 vóór het commando.", file=sys.stderr)
                return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
