# Open besluiten aan Badr

1. Heropend en afgesloten 4 sep: geen wekker nodig, maar templates wél voor chauffeurs die langer dan 24 uur stil zijn (Twilio 63016). Gebouwd in PR #21. Open actie voor jou: de vier templates indienen in Twilio Content Template Builder (docs/whatsapp-templates.md) en de SID's als TWILIO_TEMPLATE_* op Render zetten.
2. Auto-aftrek-whitelist verruimen? Nu 13 categorieën; Software, Boekhouding en Bankkosten staan op review. Eén woord in de tabel.
3. Tweede reviewer in de boekhouder-rol vóór de Q3-sprint van 1 oktober, zodra er aangiftes zijn.
4. Nog te bewijzen door jou: echte foto-bon (btw-regel) en parkeerticket (tariefvraag) in productie.
5. Afgesloten 4 sep: feature/ai-cost-steps gemerged via PR #20 en live. Nog open: één bericht en één bonfoto sturen en `ai_call` in audit_log controleren.
6. Verwerkersovereenkomst: twaalf van de dertien punten zijn op 4 sep ingevuld uit openbare bronnen. Open: de Render-regio (Render-dashboard, Settings, Region), en Supabase staat in AWS Londen (VK, adequaatheidsbesluit); wil je alles binnen de EU, dan is dat een migratie naar Frankfurt. Jurist-check blijft aan te raden vóór de eerste fleet owner tekent.
7. Afgesloten 4 sep: de chauffeur lost een onleesbare bon zelf op door hem binnen twee uur te typen of in te spreken (PR #23); de admin blijft het vangnet.
8. Twilio-templates indienen: de lokale Twilio-token is ongeldig (401). Zet een geldige TWILIO_AUTH_TOKEN in .env en draai `node -r dotenv/config scripts/submit-whatsapp-templates.js`, of laat Claude dat doen zodra de token staat.
