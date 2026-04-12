# Backlog — driver-acquisition

Openstaande punten voor het driver-acquisition project.

## Prioriteit

- [ ] Project opzetten: repo, tsconfig, package.json, .env.example
- [ ] Supabase tabellen aanmaken: drivers, outreach_log, pipeline_runs
- [ ] KvK scraper: Zoeken API + Basisprofiel API + upsert
- [ ] Google Maps scraper: Nearby Search per stad + upsert
- [ ] Deduplicatie service: filter op outreach_log (30 dagen window)
- [ ] Email service: template-based, Nodemailer/Resend switch
- [ ] Scheduler: node-cron dagelijks 09:00 Amsterdam
- [ ] Voice module: Bland AI integratie (optioneel, feature flag)

## Ideeën / later

- [ ] Dashboard met pipeline-statistieken
- [ ] Webhook voor bounce/complaint handling
- [ ] A/B testing op email subject lines
