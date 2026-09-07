# Platform
strip: ok | wakker, crons lopen, site met headers
meta: 7 sep: headers op zendiq.nl, server opgeruimd, DMARC fase 1; templates pending

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
| WhatsApp-templates en parkeren | buiten het 24-uursvenster een template plus de tekst in deferred_messages; afgeleverd bij het volgende inkomende bericht; zonder SID alleen parkeren (docs/whatsapp-templates.md) | Whatsapp-bot | own: live 4 sep; vier templates ingediend 4 sep, pending bij Meta; SID's daarna op Render | bij goedkeuring, dan 1 okt (E5) |
| CI audit-gate | leest het JSON-rapport, drie pogingen bij een registry-storing, blokkeert alleen op high of critical | Whatsapp-bot | ok: live 4 sep (82778ba) | bij de volgende rode run |
| incident-response, deploy-checklist | eigen | agent-library | own: eigen | houden |
| security-headers zendiq.nl | HSTS, CSP uit een inventaris van alle pagina's, X-Frame-Options, nosniff, Referrer-Policy, Permissions-Policy via public/.htaccess in IfModule; TransIP heeft mod_headers; 0 CSP-overtredingen in headless Chrome. Een nieuwe externe bron op een pagina vraagt een CSP-aanvulling | Whatsapp-bot | ok: live 7 sep (PR #41) | bij elke nieuwe externe bron |
| deploy ruimt de server op | deploy.js slaat _-bestanden en .vercel/ over en verwijdert _preview.html, _mobile-test.html en test-api.html op de server; serverlisting 7 sep schoon | Whatsapp-bot | ok: live 7 sep (PR #41) | 17 sep |
| DMARC | fase 1 (p=none, rua naar info@) gezet 7 sep in het TransIP-paneel; DKIM via transip-a/b/c; fase 2 p=quarantine na een week rapporten, send.zendiq.nl (SES) meenemen | TransIP DNS | warn: fase 2 open | 14 sep |
| Dependabot-alerts | aan sinds 7 sep; secret scanning en branch protection niet beschikbaar op het gratis plan, gitleaks in de gate dekt de secrets | GitHub | ok: aan | bij de eerste alert |
