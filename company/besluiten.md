# Open besluiten aan Badr

1. Afgesloten 4 sep: geen wekker nodig, wel templates voor chauffeurs die langer dan 24 uur stil zijn (Twilio 63016). Gebouwd in PR #21, de vier templates zijn op 4 sep ingediend bij Meta (status pending). 9 sep: alle zes templates staan op approved (admin_alert, fleet_invite, btw, overzicht, actie_nodig, receipt_reviewed). Open actie voor jou: de zes regels TWILIO_TEMPLATE_* op Render zetten; `node -r dotenv/config scripts/submit-whatsapp-templates.js` print ze kant-en-klaar. Zonder SID's blijven alle cron-berichten buiten het 24-uursvenster geparkeerd.
2. Auto-aftrek-whitelist verruimen? Nu 13 categorieën; Software, Boekhouding en Bankkosten staan op review. Eén woord in de tabel.
3. Tweede reviewer in de boekhouder-rol vóór de Q3-sprint van 1 oktober, zodra er aangiftes zijn.
4. Nog te bewijzen door jou: echte foto-bon (btw-regel) en parkeerticket (tariefvraag) in productie.
5. Afgesloten 4 sep: feature/ai-cost-steps gemerged via PR #20 en live. Nog open: één bericht en één bonfoto sturen en `ai_call` in audit_log controleren.
6. Verwerkersovereenkomst: twaalf van de dertien punten zijn op 4 sep ingevuld uit openbare bronnen. Open: de Render-regio (Render-dashboard, Settings, Region), en Supabase staat in AWS Londen (VK, adequaatheidsbesluit); wil je alles binnen de EU, dan is dat een migratie naar Frankfurt. Jurist-check blijft aan te raden vóór de eerste fleet owner tekent.
7. Afgesloten 4 sep: de chauffeur lost een onleesbare bon zelf op door hem binnen twee uur te typen of in te spreken (PR #23); de admin blijft het vangnet.
8. Afgesloten 4 sep: token gezet, templates ingediend (zie 1).
9. Afgesloten 4 sep ("ga"): her-uitnodiging gebouwd op feat/dashboard-chauffeurs, zie E12. Open voor jou: zendiq_fleet_invite is goedgekeurd (gezien 9 sep); SID op Render zetten (zie 1), dan eerst één chauffeur uitnodigen en het audit-event fleet_invite_sent plus de rij in deferred_messages controleren, daarna pas "Nodig iedereen uit".
10. Dagronde blind (9 sep): de lokale SUPABASE_KEY in ~/Whatsapp-bot/.env is een publishable key en ziet sinds RLS (PR #39) geen enkele tabel; de Supabase-MCP heeft geen SUPABASE_ACCESS_TOKEN. Kies: een SUPABASE_SERVICE_KEY lokaal in .env (alleen voor metrics.js en de dagcheck), of het access-token voor de MCP. Tot dan zijn nulmeting en effectmeting alleen mogelijk op de Render-instantie.
11. Dependabot 7 sep, medium: @anthropic-ai/sdk 0.88.0, gefixt in 0.91.1 (bestandsrechten van de lokale memory-tool). De bot gebruikt die tool niet, dus geen live risico; één bump-PR volstaat.
12. PR #51 (Wwft-dossier in de admin) en PR #45 (site Compleet €65) staan groen en wachten op jouw review. Let op: #45 laat de site pas vooruitlopen als de bot Compleet kan leveren.
