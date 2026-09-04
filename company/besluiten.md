# Open besluiten aan Badr

1. Afgesloten 4 sep: geen wekker nodig, wel templates voor chauffeurs die langer dan 24 uur stil zijn (Twilio 63016). Gebouwd in PR #21, de vier templates zijn op 4 sep ingediend bij Meta (status pending). Open actie voor jou zodra de status approved is: de vier regels TWILIO_TEMPLATE_* op Render zetten (zie logboek 4 sep). Status checken: `node -r dotenv/config scripts/submit-whatsapp-templates.js` (dient niets opnieuw in zolang de status pending is).
2. Auto-aftrek-whitelist verruimen? Nu 13 categorieën; Software, Boekhouding en Bankkosten staan op review. Eén woord in de tabel.
3. Tweede reviewer in de boekhouder-rol vóór de Q3-sprint van 1 oktober, zodra er aangiftes zijn.
4. Nog te bewijzen door jou: echte foto-bon (btw-regel) en parkeerticket (tariefvraag) in productie.
5. Afgesloten 4 sep: feature/ai-cost-steps gemerged via PR #20 en live. Nog open: één bericht en één bonfoto sturen en `ai_call` in audit_log controleren.
6. Verwerkersovereenkomst: twaalf van de dertien punten zijn op 4 sep ingevuld uit openbare bronnen. Open: de Render-regio (Render-dashboard, Settings, Region), en Supabase staat in AWS Londen (VK, adequaatheidsbesluit); wil je alles binnen de EU, dan is dat een migratie naar Frankfurt. Jurist-check blijft aan te raden vóór de eerste fleet owner tekent.
7. Afgesloten 4 sep: de chauffeur lost een onleesbare bon zelf op door hem binnen twee uur te typen of in te spreken (PR #23); de admin blijft het vangnet.
8. Afgesloten 4 sep: token gezet, templates ingediend (zie 1).
9. Her-uitnodiging voor de 54 chauffeurs van de test-fleet-owner: ze staan sinds mei op onboarding-stap new en hebben nooit een bericht ontvangen; de wagenpark-uitnodiging gaat alleen op het moment van toevoegen en er is geen knop om opnieuw uit te nodigen. Bouwen als onderdeel van het dashboard-werk (E11), zodat het eerste bericht pas gaat als jij erop drukt? Voorwaarde: template zendiq_fleet_invite approved.
