#!/usr/bin/env bash
# setup.sh — leest library.yaml en maakt symlinks naar ~/.claude/ en project-layers.
# Ondersteunt depends_on: concateneert dependency-layers vóór de project-layer.
# Genereert SKILLS-INDEX.md automatisch uit SKILL.md frontmatter.
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

linked=0
skipped=0

# ─── Helper: resolve een layer-naam naar zijn source-bestand ───
resolve_source() {
  local name="$1"
  local current_name="" current_source="" in_layers=false

  while IFS= read -r line; do
    local trimmed="${line#"${line%%[![:space:]]*}"}"
    if [[ "$trimmed" == "layers:" ]]; then in_layers=true; continue; fi
    if [[ "$trimmed" == "skills:" || "$trimmed" == "hooks:" ]]; then in_layers=false; fi

    if $in_layers; then
      if [[ "$trimmed" == "- name:"* ]]; then
        current_name="${trimmed#*- name:}"; current_name="${current_name#"${current_name%%[![:space:]]*}"}"
        current_source=""
      elif [[ "$trimmed" == "source:"* ]]; then
        current_source="${trimmed#*source:}"; current_source="${current_source#"${current_source%%[![:space:]]*}"}"
      fi
      if [[ "$current_name" == "$name" && -n "$current_source" ]]; then
        echo "$current_source"
        return 0
      fi
    fi
  done < "$MANIFEST"
  return 1
}

# ─── Helper: verwerk één entry (source, target, depends_on) ───
process_entry() {
  local source="$1" target="$2" depends_on="$3"

  # Composable layers (geen target) worden overgeslagen
  if [[ -z "$target" ]]; then return; fi

  target="${target/#\~/$HOME_DIR}"
  local src_abs="$REPO_DIR/$source"

  if [[ ! -f "$src_abs" ]]; then
    echo "  ⚠️  SKIP: bron ontbreekt: $source"
    skipped=$((skipped+1))
    return
  fi

  mkdir -p "$(dirname "$target")"

  if [[ -n "$depends_on" ]]; then
    # Verwijder eventuele oude symlink — anders overschrijft cp de bronfile
    if [[ -L "$target" ]]; then
      rm -f "$target"
    fi

    # Concateneer dependency layers + eigen source naar target
    local tmp_file
    tmp_file=$(mktemp)

    IFS=',' read -ra deps <<< "$depends_on"
    for dep in "${deps[@]}"; do
      dep="${dep#"${dep%%[![:space:]]*}"}"  # trim leading
      dep="${dep%"${dep##*[![:space:]]}"}"  # trim trailing
      local dep_source
      dep_source=$(resolve_source "$dep") || true
      if [[ -n "$dep_source" && -f "$REPO_DIR/$dep_source" ]]; then
        cat "$REPO_DIR/$dep_source" >> "$tmp_file"
        printf '\n---\n\n' >> "$tmp_file"
      fi
    done

    cat "$src_abs" >> "$tmp_file"
    cp -f "$tmp_file" "$target"
    rm -f "$tmp_file"
    echo "  ✅ $source → $target (+ depends_on)"
    linked=$((linked+1))
  else
    # Gewone symlink
    if ln -sfn "$src_abs" "$target" 2>/dev/null; then
      echo "  ✅ $source → $target"
      linked=$((linked+1))
    else
      cp -f "$src_abs" "$target"
      echo "  📋 $source → $target (kopie)"
      linked=$((linked+1))
    fi
  fi
}

# ─── Stap 1: Parse entries en verwerk ze per blok ───
# We lezen entry-voor-entry: bij elke "- name:" verwerken we de vorige entry.

current_source=""
current_target=""
current_depends=""
in_section=false  # true als we in layers: of skills: zitten

while IFS= read -r line; do
  trimmed="${line#"${line%%[![:space:]]*}"}"

  # Track secties
  if [[ "$trimmed" == "layers:" || "$trimmed" == "skills:" ]]; then
    in_section=true
    continue
  fi
  if [[ "$trimmed" == "hooks:" ]]; then
    # Verwerk laatste entry voor hooks-sectie
    if [[ -n "$current_source" ]]; then
      process_entry "$current_source" "$current_target" "$current_depends"
    fi
    in_section=false
    current_source="" ; current_target="" ; current_depends=""
    continue
  fi

  if ! $in_section; then continue; fi

  # Nieuwe entry begint
  if [[ "$trimmed" == "- name:"* ]]; then
    # Verwerk vorige entry als die bestond
    if [[ -n "$current_source" ]]; then
      process_entry "$current_source" "$current_target" "$current_depends"
    fi
    current_source="" ; current_target="" ; current_depends=""
    continue
  fi

  # Velden lezen
  if [[ "$trimmed" == source:* ]]; then
    current_source="${trimmed#source:}"
    current_source="${current_source#"${current_source%%[![:space:]]*}"}"
  elif [[ "$trimmed" == target:* ]]; then
    current_target="${trimmed#target:}"
    current_target="${current_target#"${current_target%%[![:space:]]*}"}"
  elif [[ "$trimmed" == depends_on:* ]]; then
    current_depends="${trimmed#depends_on:}"
    current_depends="${current_depends#"${current_depends%%[![:space:]]*}"}"
    current_depends="${current_depends#[}"
    current_depends="${current_depends%]}"
  fi
done < "$MANIFEST"

# Verwerk allerlaatste entry
if [[ -n "$current_source" ]]; then
  process_entry "$current_source" "$current_target" "$current_depends"
fi

echo
echo "Gelinkt: $linked, Overgeslagen: $skipped"

# ─── Stap 2: Genereer SKILLS-INDEX.md uit SKILL.md frontmatter ───
echo
echo "📝 SKILLS-INDEX.md genereren..."

INDEX_FILE="$REPO_DIR/SKILLS-INDEX.md"

cat > "$INDEX_FILE" <<'HEADER'
# Skills Index

> Auto-generated by `setup.sh` — niet handmatig bewerken.

| Skill | Beschrijving | Bestand |
|---|---|---|
HEADER

find "$REPO_DIR/skills" -name "SKILL.md" -type f | sort | while read -r skill_file; do
  skill_name=""
  skill_desc=""
  in_frontmatter=false

  while IFS= read -r line; do
    if [[ "$line" == "---" && "$in_frontmatter" == false ]]; then
      in_frontmatter=true; continue
    elif [[ "$line" == "---" && "$in_frontmatter" == true ]]; then
      break
    fi

    if $in_frontmatter; then
      if [[ "$line" == name:* ]]; then
        skill_name="${line#name:}"
        skill_name="${skill_name#"${skill_name%%[![:space:]]*}"}"
      elif [[ "$line" == description:* ]]; then
        skill_desc="${line#description:}"
        skill_desc="${skill_desc#"${skill_desc%%[![:space:]]*}"}"
        # Korte versie: eerste komma of dash
        skill_desc="${skill_desc%%—*}"
      fi
    fi
  done < "$skill_file"

  rel_path="${skill_file#"$REPO_DIR/"}"

  if [[ -n "$skill_name" ]]; then
    echo "| **$skill_name** | ${skill_desc} | [$rel_path]($rel_path) |" >> "$INDEX_FILE"
  fi
done

echo "  ✅ SKILLS-INDEX.md gegenereerd"

# ─── Stap 3: Hooks installeren ───
echo
echo "🔗 Hooks setup..."

chmod +x "$REPO_DIR/hooks/"*.sh 2>/dev/null || true
echo "  ✅ Hook-scripts executable gemaakt"

SETTINGS_FILE="$HOME_DIR/.claude/settings.json"
TEMPLATE_FILE="$REPO_DIR/hooks/settings-template.json"

if [[ -f "$TEMPLATE_FILE" ]]; then
  if [[ ! -f "$SETTINGS_FILE" ]]; then
    mkdir -p "$(dirname "$SETTINGS_FILE")"
    cp "$TEMPLATE_FILE" "$SETTINGS_FILE"
    echo "  ✅ settings.json aangemaakt vanuit template"
  else
    echo "  ℹ️  ~/.claude/settings.json bestaat al."
    echo "     Merge hooks handmatig vanuit: hooks/settings-template.json"
  fi
fi

echo
echo "✅ Setup compleet."
echo
echo "Volgende stappen:"
echo "  1. Check of CLAUDE.md bestaat in je project-mappen"
echo "  2. Merge hooks/settings-template.json in ~/.claude/settings.json als nodig"
echo "  3. Open een Claude Code sessie en verifieer dat de context geladen wordt"
