#!/usr/bin/env bash
# setup.sh — leest library.yaml en maakt symlinks naar ~/.claude/ en project-layers.
# Geen externe dependencies (geen yq, geen python). Pure bash + grep/sed.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$REPO_DIR/library.yaml"
HOME_DIR="${HOME:-$USERPROFILE}"

if [[ ! -f "$MANIFEST" ]]; then
  echo "ERROR: library.yaml niet gevonden op $MANIFEST" >&2
  exit 1
fi

echo "📚 Agent library setup"
echo "   Repo:   $REPO_DIR"
echo "   Home:   $HOME_DIR"
echo

# Parse de manifest: we zoeken paren van (source, target) binnen elke entry.
# Dit is een simpele parser die alleen werkt als library.yaml de conventie
# aanhoudt: één source: en één target: per entry, in die volgorde of
# gescheiden door lege regels.

linked=0
skipped=0

parse_and_link() {
  local source=""
  local target=""
  while IFS= read -r line; do
    # Trim leidende spaties
    local trimmed="${line#"${line%%[![:space:]]*}"}"

    if [[ "$trimmed" == source:* ]]; then
      source="${trimmed#source:}"
      source="${source#"${source%%[![:space:]]*}"}"
    elif [[ "$trimmed" == target:* ]]; then
      target="${trimmed#target:}"
      target="${target#"${target%%[![:space:]]*}"}"
    fi

    # Als we beide hebben, link ze en reset
    if [[ -n "$source" && -n "$target" ]]; then
      # Expand ~
      target="${target/#\~/$HOME_DIR}"
      local src_abs="$REPO_DIR/$source"

      if [[ ! -f "$src_abs" ]]; then
        echo "  ⚠️  SKIP: bron ontbreekt: $source"
        skipped=$((skipped+1))
      else
        mkdir -p "$(dirname "$target")"
        if ln -sfn "$src_abs" "$target" 2>/dev/null; then
          echo "  ✅ $source → $target"
          linked=$((linked+1))
        else
          # Fallback voor Windows zonder developer mode: kopieer
          cp -f "$src_abs" "$target"
          echo "  📋 $source → $target (kopie, geen symlink)"
          linked=$((linked+1))
        fi
      fi
      source=""
      target=""
    fi
  done < "$MANIFEST"
}

parse_and_link

echo
echo "Klaar. $linked gelinkt, $skipped overgeslagen."
echo
echo "Test: open een shell in ~/Whatsapp-bot en kijk of CLAUDE.md bestaat."
