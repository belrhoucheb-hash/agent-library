#!/bin/bash
# Hook: git push naar main/master in een productie-repo triggert de
# CI-deploy (Render/TransIP). Vereist daarom expliciete bevestiging.
# PreToolUse op Bash. Actief wanneer .claude/production-repo bestaat
# in de project-root. Bypass: zet DEPLOY_OK=1 vóór het push-commando
# nadat Badr expliciet akkoord heeft gegeven.
# Exit 2 = blokkeren; de melding op stderr gaat naar Claude.

proj="${CLAUDE_PROJECT_DIR:-.}"
[[ -f "$proj/.claude/production-repo" ]] || exit 0

input=$(cat)
cmd=$(printf '%s' "$input" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\(.*\)".*/\1/p')
[[ "$cmd" == *"git push"* ]] || exit 0
[[ "$cmd" == *"DEPLOY_OK=1"* ]] && exit 0

branch=$(git -C "$proj" branch --show-current 2>/dev/null)
if [[ "$cmd" == *main* || "$cmd" == *master* || "$branch" == "main" || "$branch" == "master" ]]; then
  echo "Productie-repo: push naar main/master deployt direct via CI." >&2
  echo "Vraag eerst expliciet akkoord aan Badr; push daarna met: DEPLOY_OK=1 git push ..." >&2
  exit 2
fi
exit 0
