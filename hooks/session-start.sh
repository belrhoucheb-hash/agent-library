#!/bin/bash
# Hook: context laden bij start van een sessie
# Wordt aangeroepen door Claude Code als SessionStart hook

echo "=== Sessie gestart ==="

# Toon huidige git status als we in een repo zitten
if git rev-parse --is-inside-work-tree &>/dev/null; then
  BRANCH=$(git branch --show-current 2>/dev/null)
  UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  LAST_COMMIT=$(git log --oneline -1 2>/dev/null)
  echo "Branch: $BRANCH"
  echo "Uncommitted files: $UNCOMMITTED"
  echo "Laatste commit: $LAST_COMMIT"
fi

# Toon openstaande backlog items als agent-library beschikbaar is
BACKLOG_DIR="$HOME/repos/agent-library/backlog"
if [ -d "$BACKLOG_DIR" ]; then
  OPEN_ITEMS=$(grep -r "\- \[ \]" "$BACKLOG_DIR" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$OPEN_ITEMS" -gt 0 ]; then
    echo ""
    echo "Openstaande backlog items: $OPEN_ITEMS"
    grep -r "\- \[ \]" "$BACKLOG_DIR" 2>/dev/null | head -5
  fi
fi

echo "==="
