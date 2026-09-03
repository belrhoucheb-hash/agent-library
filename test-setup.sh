#!/usr/bin/env bash
# test-setup.sh — valideert de agent-library integriteit.
# Draai dit voor je commit om regressies te voorkomen.
# Exit code 0 = alles OK, 1 = fouten gevonden.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$REPO_DIR/library.yaml"
errors=0
warnings=0

echo "🧪 Agent library tests"
echo "   Repo: $REPO_DIR"
echo

# ─── Helper ───
pass() { echo "  ✅ $1"; }
fail() { echo "  ❌ $1"; errors=$((errors+1)); }
warn() { echo "  ⚠️  $1"; warnings=$((warnings+1)); }

# ─── Test 1: Manifest bestaat ───
echo "── Manifest ──"
if [[ -f "$MANIFEST" ]]; then
  pass "library.yaml bestaat"
else
  fail "library.yaml ontbreekt"
  echo ""; echo "❌ Kan niet verder zonder manifest."; exit 1
fi

# ─── Test 2: Alle source bestanden in manifest bestaan ───
echo "── Source bestanden ──"
grep "source:" "$MANIFEST" | while IFS= read -r line; do
  src="${line#*source:}"
  src="${src#"${src%%[![:space:]]*}"}"  # trim
  if [[ -f "$REPO_DIR/$src" ]]; then
    pass "$src"
  else
    fail "$src ontbreekt"
  fi
done

# ─── Test 3: Alle depends_on referenties bestaan als layers ───
echo "── depends_on referenties ──"

# Verzamel alle layer-namen
layer_names=()
while IFS= read -r line; do

  line="${line%$'\r'}"
  trimmed="${line#"${line%%[![:space:]]*}"}"
  if [[ "$trimmed" == "- name:"* ]]; then
    name="${trimmed#*- name:}"
    name="${name#"${name%%[![:space:]]*}"}"
    layer_names+=("$name")
  fi
done < <(sed -n '/^layers:/,/^skills:/p' "$MANIFEST")

# Check elke depends_on referentie
grep "depends_on:" "$MANIFEST" | grep -v "^#" | grep -v "^  #" | while IFS= read -r line; do
  deps="${line#*depends_on:}"
  deps="${deps#"${deps%%[![:space:]]*}"}"
  deps="${deps#[}"; deps="${deps%]}"

  IFS=',' read -ra dep_array <<< "$deps"
  for dep in "${dep_array[@]}"; do
    dep="${dep#"${dep%%[![:space:]]*}"}"  # trim leading
    dep="${dep%"${dep##*[![:space:]]}"}"  # trim trailing

    found=false
    for name in "${layer_names[@]}"; do
      if [[ "$name" == "$dep" ]]; then found=true; break; fi
    done

    if $found; then
      pass "depends_on: $dep → gevonden"
    else
      fail "depends_on: $dep → bestaat niet als layer"
    fi
  done
done

# ─── Test 4: Alle SKILL.md bestanden hebben geldige frontmatter ───
echo "── Skills frontmatter ──"
find "$REPO_DIR/skills" -name "SKILL.md" -type f | sort | while read -r skill_file; do
  rel="${skill_file#"$REPO_DIR/"}"
  has_name=false
  has_desc=false
  in_fm=false

  while IFS= read -r line; do


    line="${line%$'\r'}"
    if [[ "$line" == "---" && "$in_fm" == false ]]; then in_fm=true; continue; fi
    if [[ "$line" == "---" && "$in_fm" == true ]]; then break; fi
    if $in_fm; then
      [[ "$line" == name:* ]] && has_name=true
      [[ "$line" == description:* ]] && has_desc=true
    fi
  done < "$skill_file"

  if $has_name && $has_desc; then
    pass "$rel"
  else
    $has_name || fail "$rel: mist 'name' in frontmatter"
    $has_desc || fail "$rel: mist 'description' in frontmatter"
  fi
done

# ─── Test 5: setup.sh draait succesvol in een temp-directory ───
echo "── setup.sh droogloop ──"
TEMP_HOME=$(mktemp -d)
if HOME="$TEMP_HOME" bash "$REPO_DIR/setup.sh" > /dev/null 2>&1; then
  # Tel gegenereerde bestanden
  claude_md="$TEMP_HOME/.claude/CLAUDE.md"
  settings="$TEMP_HOME/.claude/settings.json"

  if [[ -f "$claude_md" ]]; then
    pass "~/.claude/CLAUDE.md gegenereerd ($(wc -l < "$claude_md") regels)"
  else
    fail "~/.claude/CLAUDE.md niet gegenereerd"
  fi

  if [[ -f "$settings" ]]; then
    pass "~/.claude/settings.json gegenereerd"
  else
    fail "~/.claude/settings.json niet gegenereerd"
  fi

  # Tel project CLAUDE.md bestanden
  project_count=$(find "$TEMP_HOME" -name "CLAUDE.md" ! -path "*/.claude/*" 2>/dev/null | wc -l | tr -d ' ' || true)
  pass "$project_count project CLAUDE.md bestanden gegenereerd"

  # Tel skills
  skill_count=$(find "$TEMP_HOME/.claude/skills" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ' || true)
  pass "$skill_count skills gelinkt"
else
  fail "setup.sh crashed"
fi
rm -rf "$TEMP_HOME"

# ─── Test 6: SKILLS-INDEX.md is in sync ───
echo "── SKILLS-INDEX.md sync ──"
INDEX_FILE="$REPO_DIR/SKILLS-INDEX.md"
if [[ -f "$INDEX_FILE" ]]; then
  skill_count=$(find "$REPO_DIR/skills" -name "SKILL.md" -type f | wc -l | tr -d ' ')
  index_count=$(grep -c "^| \*\*" "$INDEX_FILE" 2>/dev/null || echo 0)
  if [[ "$skill_count" == "$index_count" ]]; then
    pass "SKILLS-INDEX.md heeft $index_count entries (= $skill_count skills)"
  else
    warn "SKILLS-INDEX.md heeft $index_count entries maar er zijn $skill_count skills — draai setup.sh"
  fi
else
  warn "SKILLS-INDEX.md ontbreekt — draai setup.sh om te genereren"
fi

# ─── Test 7: Geen secrets in de repo ───
echo "── Security ──"
if grep -rq "sk-[a-zA-Z0-9]\{20,\}\|AKIA[A-Z0-9]\{16\}\|ghp_[a-zA-Z0-9]\{36\}" \
  --include="*.md" --include="*.yaml" --include="*.json" --include="*.sh" \
  "$REPO_DIR" 2>/dev/null; then
  fail "Mogelijke secrets gevonden in repo-bestanden"
else
  pass "Geen secrets gedetecteerd"
fi

# ─── Test 8: company-pagina in sync met de markdown ───
echo "── Company ──"
if command -v node >/dev/null 2>&1; then
  if node "$REPO_DIR/company/build-page.js" --check >/dev/null 2>&1; then
    pass "zendiq-afdelingen.html in sync met company/*.md"
  else
    fail "zendiq-afdelingen.html loopt achter — draai node company/build-page.js"
  fi
else
  warn "node niet gevonden — company-pagina niet gecontroleerd"
fi

# ─── Resultaat ───
echo
if [[ $errors -eq 0 && $warnings -eq 0 ]]; then
  echo "✅ Alle tests geslaagd."
  exit 0
elif [[ $errors -eq 0 ]]; then
  echo "⚠️  $warnings waarschuwing(en), geen fouten."
  exit 0
else
  echo "❌ $errors fout(en), $warnings waarschuwing(en)."
  exit 1
fi
