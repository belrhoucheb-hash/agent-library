# Node.js + Express — stack conventies

Deze layer is actief voor projecten die Node.js met Express gebruiken.

## Structuur

- Entrypoint is `index.js` of `src/index.js` — niet verspreiden over
  meerdere startbestanden.
- Routes in aparte bestanden of een `routes/` map, niet allemaal in
  de entrypoint.
- Services/business logic in `services/` — niet in route handlers.

## Error handling

- Express error middleware als vangnet: `app.use((err, req, res, next) => …)`.
- Async route handlers altijd wrappen of `express-async-errors` gebruiken.
- Geen `process.exit()` in request handlers — laat het framework crashes
  afhandelen.

## Environment

- Config via `process.env`, geladen uit `.env` (met `dotenv` of platform).
- `.env` staat in `.gitignore`. `.env.example` in de repo als template.
- Geen hardcoded poorten, URLs, of keys in code.

## Dependencies

- `package-lock.json` committen. Geen mix van npm/yarn/pnpm.
- `node_modules/` staat in `.gitignore`.
- Minimale dependencies — standaard Node.js APIs waar mogelijk.

## Logging

- Gebruik `console.error` voor fouten, `console.log` voor info.
- Geen secrets in logs. Geen request bodies met PII loggen.
- Bij productie: structured logging (JSON) als het project dat ondersteunt.
