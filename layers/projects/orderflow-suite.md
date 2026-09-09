# orderflow-suite (OrderFlow Suite) — project context

Deze layer is alleen actief binnen `~/Desktop/DevBadr/orderflow-suite/*`.

## Wat is dit project

Multi-tenant TMS voor B2B cargo: AI-inbox (Gemini) → orders → planning →
chauffeur-app → factuur. Ook "cargo-systeem" genoemd. Geparkeerd sinds
20 mei 2026; herstartvoorwaarden staan in de vault.

## Stack

- Vite + React 18 + TypeScript, Tailwind/shadcn, React Query
- Supabase Postgres (project `mdcfqircyxltiwfnmjsj`), RLS per tenant,
  pg_cron + Vault; 56 edge functions in Deno (`supabase/functions/`),
  161 migraties
- Hosting: Vercel (orderflow-suite.vercel.app, git-integratie) + Supabase

## Harde regels

1. `VISION.md` wint bij conflicten; `AGENT_BRIEF.md` bepaalt
   groen/geel/rood-zones voor wijzigingen.
2. Docs gaan niet naar git. Geen em-dashes in Nederlandse tekst.
3. Alleen de hoofdrepo bewerken; `orderflow-suite-neworder-warehouse-flow`
   en `orderflow-suite-push-fix` zijn worktrees, `Projects/royalty-cargo`
   is een oude kopie. `~/orderflow-suite/` is een lege, verkeerde
   deploy-restant.

## Wat Claude hier fout doet

<!-- Twee-keer-fout-regel: zelfde fout twee keer → correctie hier, of
     een hook als hij zonder uitzondering moet gelden. -->

- <!-- Correctie -->

## Commando's

- Install: `npm ci --legacy-peer-deps` · Dev: `npm run dev` · Build: `npm run build`
- Tests: `npm test` (vitest), `npm run test:security`, `npm run test:e2e`
  (Playwright), `npm run lint`
- Vóór push: `npm run check:secret-leaks`, `npm run lint:migrations`,
  `npm run check:release`

## Openstaande punten

Zie `backlog/orderflow-suite.md`. Bekend bij herstart: 7 migraties en
4 edge functions sinds 12 mei niet gedeployd; Azure/Google OAuth-registratie
niet gedaan; ~70 remote `auto/review-*` branches zonder opvolging.

## Vault (Obsidian)

Kennisbank: `~/Obsidian/orderflow`. Bij sessiestart: lees `00 Start.md` en de
nieuwste notitie in `Sessies/` — niet de hele vault. Bij sessie-einde:
schrijf `Sessies/<datum>.md` volgens `Templates/Sessie.md` (max 15
regels: gedaan, stand, volgende stap, open vragen). Besluiten in
`Besluiten.md`, key-locaties in `Keys.md`, open punten in
`Backlog/orderflow-suite.md` (dat is `agent-library/backlog`, live gekoppeld).
