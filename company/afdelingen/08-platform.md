# Platform
strip: ok | wakker, crons lopen, berichten komen aan
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
| blijft de instantie wakker? | Bewezen: 56 cron-runs in de nacht van 3 op 4 sep, geen gefaald; de zelf-ping van elke 10 min houdt hem wakker. Geen wekker nodig | Whatsapp-bot | ok: bewezen 4 sep | 17 sep |
| komen cron-berichten aan? | Statusrapport van 4 sep 08:00 is bij Badr aangekomen; `daily-status` completed in audit_log. Template-verdenking vervalt. Waarom het eerder uitbleef is niet meer te achterhalen (geen audit vóór de fix); vanaf nu ziet de health-check het | Whatsapp-bot | ok: bewezen 4 sep | 17 sep |
| incident-response, deploy-checklist | eigen | agent-library | own: eigen | houden |
