#!/bin/bash
# Hook: herinnering voor commit-kwaliteit
# Wordt aangeroepen door Claude Code als PreToolUse hook bij git commit

echo "--- Pre-commit check ---"
echo "Heb je doorlopen:"
echo "  - code-review checklist (correctheid, leesbaarheid, security, tests, scope)"
echo "  - verify-before-done (bewijs dat het werkt, niet 'zou moeten werken')"
echo "  - commit-netjes (één doel, expliciete staging, conventional message)"
echo "---"
