# driver-acquisition — project context

Deze layer is alleen actief binnen `~/driver-acquisition/*`.

## Wat is dit project

ZendIQ Driver Acquisition Workflow: een Node.js/TypeScript automation
pipeline die Nederlandse taxichauffeurs vindt via externe bronnen
(KvK API, Google Maps), opslaat in Supabase, dedupliceert, dagelijks
outreach-emails verstuurt, en optioneel AI voice calls doet.

## Stack

- Node.js + TypeScript — entrypoint `src/index.ts`
- Supabase (Postgres) — drivers, outreach_log, pipeline_runs
- KvK API (developers.kvk.nl) — primaire databron (SBI code 49330)
- Google Maps Places API — secundaire databron
- Nodemailer / Resend — email outreach (schakelen via env var)
- Bland AI / ElevenLabs + Twilio — voice calls (optioneel)
- node-cron — dagelijkse scheduling (09:00 Amsterdam tijd)

## Kritieke modules

| Module | Verantwoordelijkheid |
|---|---|
| `src/scrapers/kvkScraper.ts` | KvK Zoeken + Basisprofiel API, upsert naar drivers |
| `src/scrapers/googleMapsScraper.ts` | Google Maps Places Nearby Search, upsert naar drivers |
| `src/services/deduplication.ts` | Filter drivers die al gecontacteerd zijn (<30 dagen) |
| `src/services/emailService.ts` | Personalized Dutch email outreach, log naar outreach_log |
| `src/services/voiceService.ts` | Bland AI outbound calls (optioneel via ENABLE_VOICE_CALLS) |
| `src/scheduler.ts` | Dagelijkse pipeline: scrape → dedup → email → voice |
| `src/index.ts` | Entrypoint, config laden, scheduler starten |

## Database schema

### drivers
- id, kvk_number, business_name, first_name, last_name, email, phone
- city, postal_code, source (kvk | google_maps), created_at

### outreach_log
- id, driver_id (FK), channel (email | call), status (sent | failed | no_contact), sent_at

### pipeline_runs (optioneel)
- id, started_at, finished_at, drivers_scraped, emails_sent, calls_made

## Harde regels

### Data & privacy
1. Geen persoonlijke data loggen naar console of bestanden — alleen
   aantallen en statussen.
2. KvK API key en alle credentials via env vars, nooit in code.
3. Deduplicatie ALTIJD draaien vóór outreach — nooit twee keer dezelfde
   chauffeur mailen op dezelfde dag.
4. Rate limiting op externe APIs: KvK (check hun fair use policy),
   Google Maps (respecteer quotas).

### Outreach
5. Email-inhoud is Nederlands. Subject en body staan in een template,
   niet hardcoded in de service.
6. Voice calls alleen als `ENABLE_VOICE_CALLS=true` — standaard uit.
7. Elke outreach-actie (email of call) MOET gelogd worden in
   `outreach_log` voordat de volgende begint.

### Pipeline
8. Pipeline-volgorde is heilig: scrape → dedup → email → voice.
   Nooit stappen overslaan of herordenen.
9. Bij falen van één stap: log de error, ga door met volgende stap.
   Niet de hele pipeline stoppen voor één gefaalde email.

## Commando's

- Build: `npm run build` (tsc)
- Dev: `npm run dev` (tsx watch)
- Tests: `npm test`
- Lokaal draaien: `npm start`
- Eenmalige pipeline run: `npm run pipeline`

## Openstaande punten

Zie `backlog/driver-acquisition.md` in de agent-library.
