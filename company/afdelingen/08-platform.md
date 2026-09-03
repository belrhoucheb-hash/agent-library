# Platform
strip: warn | slaapt niet; verzending onder verdenking
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
| blijft de instantie wakker? | Bewezen 3 sep 20:00: crons vuurden 16 min na het laatste bezoek; de zelf-ping van elke 10 min houdt hem wakker. Wekker waarschijnlijk onnodig | Whatsapp-bot | ok: wakker | 4 sep 08:00 |
| komen cron-berichten aan? | Statusrapport bereikt Badr niet. Verdenking: vrije tekst buiten het WhatsApp-venster van 24 uur (Twilio-fout 63016), geen templates in de code. Test: audit_log `daily-status` op 4 sep 06:00Z en de Twilio-log | taak | crit: hypothese | 4 sep 08:00 |
| incident-response, deploy-checklist | eigen | agent-library | own: eigen | houden |
