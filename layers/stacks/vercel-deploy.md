# Vercel — deploy conventies

Deze layer is actief voor projecten die op Vercel gehost worden.

## Configuratie

- `vercel.json` in de repo root. Minimaal: routes/rewrites als nodig.
- Environment variables in Vercel dashboard, niet in `vercel.json`.
- Onderscheid Production / Preview / Development env vars waar nodig.

## Deploy flow

- Push naar main = productie deploy (tenzij anders geconfigureerd).
- Push naar feature-branch = preview deploy met eigen URL.
- Controleer preview deploy vóór merge naar main.

## Serverless Functions

- Cold starts: houd functies klein. Geen zware imports op module-level
  die je niet in elke invocation nodig hebt.
- Timeout: standaard 10s (hobby) / 60s (pro). Lange taken afsplitsen
  naar background jobs of cron.
- Geen file system writes — serverless is stateless. Gebruik een
  database of object store.

## Pre-deploy checklist

- [ ] Tests draaien groen lokaal
- [ ] Environment variables aanwezig in Vercel dashboard
- [ ] `vercel.json` routes kloppen (test met `vercel dev` als mogelijk)
- [ ] Geen hardcoded localhost URLs in productie-code
- [ ] Build succeeds: `npm run build` of equivalent

## Rollback

- Vercel houdt alle deploys bij. Rollback via dashboard of
  `vercel rollback` als CLI beschikbaar is.
- Bij kritieke bug: rollback eerst, debug daarna. Niet fixen op
  productie.
