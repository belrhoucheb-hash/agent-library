#!/bin/bash
# Test van production-push-gate.sh met echte commando's als controle.
# Draai: bash hooks/test-push-guard.sh
# Vereist: python, gh ingelogd, ~/Whatsapp-bot met .claude/production-repo,
# en branch feat/meta-pixel met gemergde PR 83 in driveadmin-bot.
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
hook="$here/production-push-gate.sh"
G=git; P=push
win() { cygpath -w "$1" 2>/dev/null || echo "$1"; }
mkjson() {
  MSYS_NO_PATHCONV=1 python -c 'import json,sys; print(json.dumps({"cwd":sys.argv[1],"hook_event_name":"PreToolUse","tool_name":"Bash","tool_input":{"command":sys.argv[2],"description":sys.argv[3]}}))' "$1" "$2" "${3:-}"
}
pass=0; fail=0
check() { # naam verwachte-exit cwd commando [beschrijving]
  local out code
  out=$(mkjson "$3" "$4" "${5:-}" | CLAUDE_PROJECT_DIR="$bot" bash "$hook" 2>&1); code=$?
  if [ "$code" = "$2" ]; then pass=$((pass+1)); echo "ok   $1 (exit $code)"
  else fail=$((fail+1)); echo "FOUT $1: verwacht $2, kreeg $code: $out"; fi
}
bot=$(win ~/Whatsapp-bot); lib=$(win ~/repos/agent-library)
fixture=$(mktemp -d); $G -C "$fixture" init -q -b main
mkdir -p "$fixture/.claude"; : > "$fixture/.claude/production-repo"; fx=$(win "$fixture")

# Regel 1: productie-repo, doel main of master
check "prod: naar main" 2 "$bot" "$G $P origin main"
check "prod: HEAD naar main" 2 "$bot" "$G $P origin HEAD:main"
check "prod: kale push terwijl main uitgecheckt is" 2 "$fx" "$G $P"
check "prod: met DEPLOY_OK" 0 "$bot" "DEPLOY_OK=1 $G $P origin main"
# Negatieve controles: de vorm van de valse blokkade van 11 sep 2026
check "prod: featurebranch met origin/main in de regel" 0 "$bot" "cd ~/Whatsapp-bot && $G fetch -q origin && $G log --oneline -1 origin/main && $G $P -u origin feat/push-guard-zelftest" "Push branch met domain en main in de tekst"
check "geen push, wel main in het commando" 0 "$bot" "$G log origin/main --oneline -3"
check "repo zonder marker: naar main" 0 "$lib" "$G $P origin main"
# Regel 2: branch met gemergde PR (feat/meta-pixel, PR 83)
check "gemergde PR: vorm van het incident van 11 sep" 2 "$bot" "cd ~/Whatsapp-bot-wt-meta && $G add public/index.html && $G commit -q -m \"feat(site): tag\" && $G $P origin feat/meta-pixel"
check "gemergde PR: met MERGED_PR_OK" 0 "$bot" "MERGED_PR_OK=1 $G $P origin feat/meta-pixel"
check "gemergde PR: branch verwijderen mag" 0 "$bot" "$G $P origin --delete feat/meta-pixel"

rm -rf "$fixture"
echo "---"; echo "geslaagd: $pass, gefaald: $fail"; [ "$fail" -eq 0 ]
