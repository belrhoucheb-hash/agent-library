# Whatsapp-bot (ZendIQ) — project context

Deze layer is alleen actief binnen `~/Whatsapp-bot/*`.

## Wat is dit project

WhatsApp-bot voor ZendIQ: Node.js backend die bonnetjes van taxichauffeurs
scant via de Anthropic API, opslaat in Supabase, en een BTW-module bedient.
Bevat ook een marketing-module die ads genereert en via Telegram publiceert,
en sinds aug 2026 de boekhouddienst (drie sloten op elke aangifte,
leer-lus voor bonnetjes).

## Stack

- Node.js + Express — entrypoint `index.js`
- Supabase — database + auth (service key via env)
- Twilio — WhatsApp berichten
- Anthropic API — bon-analyse en ad-generatie
- Render — hosting; deploy via CI (push naar main → audit-gate → tests →
  Render deploy hook + TransIP-SFTP voor de site)

## Kritieke modules

| Module | Verantwoordelijkheid |
|---|---|
| `services/marketing.js` | Ad generatie, combinatie-selectie, approval flow |
| `services/publishers.js` | Centrale registry van publicatiekanalen — enige plek waar kanalen gedefinieerd worden |
| `services/vat-classifier.js` | Single source of truth voor BTW-classificatie |
| `services/cron.js` | Alle scheduled jobs, met locking via `withLock()` |
| `routes/webhook.js` | WhatsApp webhook-dispatch (`handleIncomingMessage`) + state machine voor approval flows; `index.js` is alleen entrypoint |

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

### Deploy
- Dit is een productie-repo (`.claude/production-repo`): push naar main
  deployt direct via CI. Eerst expliciet akkoord van Badr, dan
  `DEPLOY_OK=1 git push`.

## Wat Claude hier fout doet

<!-- Twee-keer-fout-regel: zelfde fout twee keer → correctie hier, of
     een hook als hij zonder uitzondering moet gelden. -->

- Aanbiedingen zonder handler: alles wat de bot aanbiedt (menu's,
  "typ x") moet een handler hebben, per rol én state — check dit bij
  elke flow-wijziging.
- Pushen naar een PR-branch: eerst `gh pr view <nr> --json state`. Is de PR
  al gemerged, dan een nieuwe branch vanaf `origin/HEAD`; anders belandt de
  commit nooit op main (gebeurde bij PR #48 en #57).

## Commando's

- Tests: `npm test` (node --test, unit + integration; integration skipt
  zonder `SUPABASE_TEST_URL`/`SUPABASE_TEST_KEY`)
- Site deploy: `npm run deploy:website`
- Lokaal draaien: `npm run dev` (nodemon) of `npm start`
- UI-controle: `node scripts/screenshot.js <url> <png> [--mobile] [--full]`
  (Playwright); desktop én mobiel schieten en de PNG bekijken vóór "klaar".
- Pre-push: `.husky/pre-push` draait npm audit en de testsuite vóór elke
  push. In een nieuwe worktree eerst `npx husky` (of `npm install`), anders
  slaat git de hook stil over. Nooit `SKIP_PREPUSH=1` zonder reden.

## Openstaande punten

Zie `backlog/whatsapp-bot.md` in de agent-library voor het volledige
overzicht. Belangrijkste blocker:

- `subscription_tier` kolom in Supabase — nodig zodra subscription-code
  geraakt wordt.

## Vault (Obsidian)

Kennisbank: `~/Obsidian/zendiq`. Bij sessiestart: lees `00 Start.md` en de
nieuwste notitie in `Sessies/` — niet de hele vault. Bij sessie-einde:
schrijf `Sessies/<datum>.md` volgens `Templates/Sessie.md` (max 15
regels: gedaan, stand, volgende stap, open vragen). Besluiten in
`Besluiten.md`, key-locaties in `Keys.md`, open punten in
`Backlog/whatsapp-bot.md` (dat is `agent-library/backlog`, live gekoppeld).
