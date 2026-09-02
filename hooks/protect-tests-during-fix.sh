#!/bin/bash
# Hook: blokkeer edits aan test-bestanden zolang een bugfix loopt.
# PreToolUse op Edit|Write. Actief wanneer .claude/fix-in-progress
# bestaat in de project-root (systematic-debug maakt die aan nadat de
# falende test is vastgelegd, en verwijdert hem na verificatie).
# Exit 2 = blokkeren; de melding op stderr gaat naar Claude.

marker="${CLAUDE_PROJECT_DIR:-.}/.claude/fix-in-progress"
[[ -f "$marker" ]] || exit 0

input=$(cat)
file_path=$(printf '%s' "$input" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
[[ -n "$file_path" ]] || exit 0

# Windows-backslashes normaliseren zodat de globs hieronder matchen
file_path="${file_path//\\//}"

case "$file_path" in
  *.test.*|*.spec.*|*/__tests__/*|*/test/*|*/tests/*|*/test_*|*_test.go|*_test.py)
    echo "Bugfix loopt (.claude/fix-in-progress bestaat): fix de code, niet de test." >&2
    echo "Is de test zelf aantoonbaar fout? Verwijder dan eerst de marker en leg uit waarom." >&2
    exit 2
    ;;
esac
exit 0
