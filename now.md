# Nu: waar sta ik vandaag

Peildatum 10 sep 2026. Eén scherm, alle projecten. Bijwerken bij
sessie-einde, tegelijk met de vault-sessienotitie. Detail staat in
`portfolio.md` (prioriteit), `backlog/` (open punten) en de Obsidian-vault
(`~/Obsidian/zendiq/00 Start.md`).

## Deze week

1. Zendiq: chauffeurs werven (E0, doel tien actieve chauffeurs vóór 1 okt).
2. Zendiq: PR voor `fix/grok-review-ronde` mergen, #78, #79, #80 sluiten, #77 mergen.
3. Zendiq: E5 template-SID's op Render zetten.

## Stand per actief project

| Project | Stand | Volgende stap |
|---|---|---|
| Zendiq (`~/Whatsapp-bot`) | Bot en boekhouddienst live; geen betalende klanten | Grok-PR's afhandelen, daarna E5 |
| DLX Mobility (`~/repos/motorverhuur`) | Site live, MVP-platform in aanbouw | Zie `backlog/` en project-layer |
| EAA-leadmachine (`~/repos/eaa-leadmachine`) | Kanalen-run draait | Na elke run `node src/run.js`; replies op info@ dagelijks |
| By Amina's Honing (Shopify) | Live, ads-plan loopt | Alleen op concrete vraag |
| SMEULWERK koffieshop | Prototype af | Badr: theme #194824831302 publiceren, BOIP-check |
| Yallah Zaza (darija-app) | 115 nieuwe clips van 8 sep wachten | Clips injecteren, build publiceren; besluit: onder git? |
| QD Chauffeur, Maison Laméya | Live, onderhoud | Niets gepland |

## Blockers

- `subscription_tier`-kolom ontbreekt in Supabase (Zendiq).
- Uber Driver API: scopes wachten op Uber BD; alternatief Rollee.
- Perplexity MCP werkt pas na `PERPLEXITY_API_KEY` als Windows-env-var.

## Open beslissingen voor Badr

- Eerste echte Uber Tax Summary-export als fixture vóór live CSV-import.
- Darija-app onder git zetten (stemopnames staan alleen op deze schijf).
- DMARC fase 2 (quarantine) rond 14 sep.
