# Open besluiten aan Badr

1. Afgesloten 4 sep: geen wekker en geen templates nodig. Instantie blijft wakker (56 cron-runs in één nacht) en het statusrapport van 08:00 kwam aan.
2. Auto-aftrek-whitelist verruimen? Nu 13 categorieën; Software, Boekhouding en Bankkosten staan op review. Eén woord in de tabel.
3. Tweede reviewer in de boekhouder-rol vóór de Q3-sprint van 1 oktober, zodra er aangiftes zijn.
4. Nog te bewijzen door jou: echte foto-bon (btw-regel) en parkeerticket (tariefvraag) in productie.
5. Branch feature/ai-cost-steps (14 commits, 1210 tests groen) deployen? Vooraf in een externe terminal met ANTHROPIC_API_KEY: `node tmp/smoke-2a.js` in de bot-repo (bewijst structured outputs op Haiku 4.5, kost minder dan $0,05). Daarna push naar main is deploy via CI.
