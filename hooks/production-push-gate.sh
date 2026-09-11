#!/bin/bash
# Hook: bewaakt pushes via git (PreToolUse op Bash). De regels staan in
# push_guard.py: naar main of master in een productie-repo alleen met
# DEPLOY_OK=1, en niet naar een branch waarvan de PR al gemerged is
# (MERGED_PR_OK=1 om dat bewust te omzeilen). Beslist op het doel van de
# push, niet op woorden elders in het commando. Test: test-push-guard.sh.
# Exit 2 = blokkeren; de melding op stderr gaat naar Claude.

input=$(cat)
case "$input" in
  *git*push*) ;;
  *) exit 0 ;;
esac

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
guard="$here/push_guard.py"
command -v cygpath >/dev/null 2>&1 && guard="$(cygpath -w "$guard")"

for py in python3 python; do
  if command -v "$py" >/dev/null 2>&1 && "$py" -c "import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)" 2>/dev/null; then
    printf '%s' "$input" | "$py" "$guard"
    exit $?
  fi
done

# Terugval zonder Python: de oude, grove regel op de projectmap.
proj="${CLAUDE_PROJECT_DIR:-.}"
[[ -f "$proj/.claude/production-repo" ]] || exit 0
[[ "$input" == *DEPLOY_OK=1* ]] && exit 0
if [[ "$input" == *main* || "$input" == *master* ]]; then
  echo "Productie-repo: push naar main/master deployt direct via CI (Python ontbreekt, grove controle)." >&2
  echo "Vraag eerst expliciet akkoord aan Badr en zet DEPLOY_OK=1 vóór het push-commando." >&2
  exit 2
fi
exit 0
