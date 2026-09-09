#!/bin/bash
# Genereert ~/.claude/reference/keys-index.md: waar API-keys en tokens
# staan (pad + variabelnaam). Nooit waarden. Draai na elke nieuwe key.
set -e
OUT="$HOME/.claude/reference/keys-index.md"
mkdir -p "$(dirname "$OUT")"

service_for() {
  case "$1" in
    ANTHROPIC*) echo "Anthropic — console.anthropic.com" ;;
    OPENAI*) echo "OpenAI — platform.openai.com" ;;
    *SUPABASE*) echo "Supabase — supabase.com/dashboard" ;;
    TWILIO*) echo "Twilio — console.twilio.com" ;;
    MOLLIE*) echo "Mollie — my.mollie.com" ;;
    SUMUP*) echo "SumUp — developer.sumup.com" ;;
    TRANSIP*) echo "TransIP — controlpanel.transip.nl" ;;
    KVK*) echo "KvK API — developers.kvk.nl" ;;
    OVERHEID_IO*) echo "Overheid.io — overheid.io" ;;
    RESEND*) echo "Resend — resend.com" ;;
    VAPI*) echo "Vapi — dashboard.vapi.ai" ;;
    *GOOGLE_MAPS*) echo "Google Cloud — console.cloud.google.com" ;;
    TELEGRAM*) echo "Telegram — @BotFather" ;;
    SENTRY*) echo "Sentry — sentry.io" ;;
    GD_*) echo "GoDaddy hosting/mail — dcc.godaddy.com" ;;
    JWT_SECRET|SESSION_SECRET|ADMIN_PASSWORD|INTERNAL_API_KEY) echo "eigen secret — roteren in .env + deploy-env" ;;
    *) echo "" ;;
  esac
}

{
  echo "# Keys-index — waar staan API-keys en tokens"
  echo
  echo "Gegenereerd $(date +%F) door \`scripts/keys-index.sh\`. Alleen paden en namen."
  echo "Waarden staan in de .env zelf; nooit in chat, code of git."
  echo
  echo "## Per project (.env-bestanden)"
  echo
  find "$HOME" -maxdepth 4 \( -name node_modules -o -name .git -o -name AppData -o -name '.claude' \) -prune -o \
       \( -name ".env" -o -name ".env.local" -o -name ".env.production" \) -print 2>/dev/null | sort | while read -r f; do
    rel="${f#$HOME/}"
    echo "### ~/$rel"
    grep -oE '^[A-Za-z_][A-Za-z0-9_]*=' "$f" 2>/dev/null | tr -d '=' | sort -u | while read -r v; do
      svc=$(service_for "$v")
      if [ -n "$svc" ]; then echo "- \`$v\` — $svc"; else echo "- \`$v\`"; fi
    done
    echo
  done
  echo "## Service-account- en sleutelbestanden"
  echo
  find "$HOME" -maxdepth 4 \( -name node_modules -o -name .git -o -name AppData \) -prune -o \
       \( -name "*service-account*.json" -o -name "*.pem" -o -name "id_*" \) -print 2>/dev/null | grep -v '\.pub$' | sort | sed "s|^$HOME/|- ~/|"
  echo
  echo "## Buiten bestanden"
  echo
  echo "- Claude Code login: \`~/.claude/.credentials.json\` (OAuth, beheerd door Claude Code)"
  echo "- claude.ai-connectors (Gmail, Supabase, Higgsfield, Apify): OAuth op claude.ai → Instellingen → Connectors; geen lokale key"
  echo "- Zendiq CI-secrets: GitHub → repo-settings → Secrets (o.a. TransIP SFTP-key \`transip_key_2026\`)"
  echo "- Render env-vars (Zendiq app, DLX): dashboard.render.com → service → Environment"
  echo "- Vercel env-vars (QD Chauffeur, OrderFlow): vercel.com → project → Settings → Environment Variables"
  echo "- Shopify: \`shopify\` CLI-login per store (by-aminas-honing.myshopify.com, smeulwerk)"
  echo "- Hermes Agent: \`~/AppData/Local/hermes/.env\`"
} > "$OUT"
echo "Geschreven: $OUT ($(wc -l < "$OUT") regels)"
