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

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Ritueel van vandaag (company/README.md) — zondag = triage
case "$(date +%u)" in
  7) echo ""; echo "Ritueel vandaag: zondag-triage (Product) — daarna afdeling-update" ;;
  1) echo ""; echo "Ritueel vandaag: maandag — weekbericht en maandagbericht steekproef" ;;
esac

# Experimenten over hun meetdatum (company/experimenten.md, kolom Meten, datums YYYY-MM-DD)
EXPERIMENTEN="$SCRIPT_DIR/../company/experimenten.md"
if [ -f "$EXPERIMENTEN" ]; then
  TODAY=$(date +%F)
  OVERDUE=$(grep -E '^\| E[0-9]+ ' "$EXPERIMENTEN" | while IFS='|' read -r _ nr naam _ _ _ meten status _; do
    for d in $(echo "$meten" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}'); do
      if [[ "$d" < "$TODAY" || "$d" == "$TODAY" ]] && ! echo "$status" | grep -qiE 'behouden|teruggedraaid|afgerond'; then
        echo "  $(echo "$nr" | tr -d ' ') $(echo "$naam" | sed 's/^ *//;s/ *$//') — meetdatum $d"
        break
      fi
    done
  done)
  if [ -n "$OVERDUE" ]; then
    echo ""
    echo "Experimenten over hun meetdatum → effectmeting:"
    echo "$OVERDUE"
  fi
fi

# Toon openstaande backlog items — resolve relatief aan dit script
BACKLOG_DIR="$SCRIPT_DIR/../backlog"
if [ -d "$BACKLOG_DIR" ]; then
  OPEN_ITEMS=$(grep -r "\- \[ \]" "$BACKLOG_DIR" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$OPEN_ITEMS" -gt 0 ]; then
    echo ""
    echo "Openstaande backlog items: $OPEN_ITEMS"
    grep -r "\- \[ \]" "$BACKLOG_DIR" 2>/dev/null | head -5
  fi
fi

echo "==="
