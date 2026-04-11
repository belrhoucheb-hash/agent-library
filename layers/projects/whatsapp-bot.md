# Whatsapp-bot (ZendIQ) — project context

Deze layer is alleen actief binnen `~/Whatsapp-bot/*`.

## Wat is dit project

WhatsApp-bot voor ZendIQ: Node.js backend die bonnetjes van taxichauffeurs
scant via de Anthropic API, opslaat in Supabase, en een BTW-module bedient.
Bevat ook een marketing-module die ads genereert en via Telegram publiceert.

## Stack

- Node.js + Express — entrypoint `index.js`
- Supabase — database + auth (service key via env)
- Twilio — WhatsApp berichten
- Anthropic API — bon-analyse en ad-generatie
- Vercel — hosting (zie `vercel.json`)

## Kritieke modules

| Module | Verantwoordelijkheid |
|---|---|
| `services/marketing.js` | Ad generatie, combinatie-selectie, approval flow |
| `services/publishers.js` | Centrale registry van publicatiekanalen — enige plek waar kanalen gedefinieerd worden |
| `services/vat-classifier.js` | Single source of truth voor BTW-classificatie |
| `services/cron.js` | Alle scheduled jobs, met locking via `withLock()` |
| `index.js` | WhatsApp webhook + state machine voor approval flows |

## Harde regels

### BTW-module
1. Labels in code, niet in database.
2. Kleine whitelist van toegestane classificaties.
3. Harde circuit-breaker bij onzekerheid.
4. Audit trail verplicht: `classification_reason` + `classifier_version`.
5. Classifier-first: nooit parallelle classificatie-paden.
6. `filing_periods` heeft 5-staps status-machine.

### Marketing
- `services/publishers.js` is de *enige* plek voor kanaal-definities.
  Nooit een kanaal hardcoderen in `index.js`.
- Nieuwe kanalen: handler in eigen `services/<kanaal>-publisher.js`,
  daarna één entry in `PUBLISHERS` array.
- UTM-injectie doet de publisher zelf, niet `index.js`.

### Data
- `services/ZendIQ.json` staat in `.gitignore` — gebruik `.example` als template.
- Secrets altijd via env vars, nooit in code.

## Commando's

- Tests: `node test-full-suite.js`, `node test-chaos-chauffeur.js`
- Site deploy: vanuit `zendiq-site/`, `node deploy.js`
- Lokaal draaien: `node index.js`

## Openstaande punten (uit memory)

- `subscription_tier` kolom moet nog toegevoegd worden in Supabase.
  Herinner Badr hieraan wanneer subscription-code geraakt wordt.
