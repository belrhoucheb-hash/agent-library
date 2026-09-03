# Platform
strip: warn | instantie slaapt; wekker later
meta: cron-monitoring hersteld 3 sep

## Doel
Het draait en herstelt zichzelf.

## Meetlat
Uptime, hersteltijd, rode CI-runs, cron-runs per dag in audit_log.

## Ritme
`elke 2 uur` cron-health-check · `zo 09:00` observability-digest · `elke push naar main` CI met audit-gate

## Skills
| Skill | Detail | Bron | Status | Beoordelen |
|---|---|---|---|---|
| cron-audit hersteld | phone_number NOT NULL brak elke cron-insert sinds 11 april; fix live 3 sep 19:13, eerste cron_run_completed 19:15 | Whatsapp-bot | ok: bewezen | 17 sep |
| slapende instantie | gratis Render-plan; zonder bezoek vuurt geen cron. Betaald plan pas bij eerste betalende klant; wekker (externe pinger) later | taak | warn: uitgesteld | bij eerste klant |
| incident-response, deploy-checklist | eigen | agent-library | own: eigen | houden |
