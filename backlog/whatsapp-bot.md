# Backlog — whatsapp-bot (ZendIQ)

Openstaande punten voor het whatsapp-bot project. Houd dit bij als
centraal overzicht — niet verspreid over project-layers of comments.

## Prioriteit

- [ ] `subscription_tier` kolom toevoegen in Supabase — blocker zodra
  subscription-code geraakt wordt.

## Ideeën / later

- [ ] **Product — wekelijkse signalen-digest "Top 5 productproblemen"** (3 sep 2026).
  Uitbreiding van `weekly-observability-digest.js` (zo 09:00): signalen uit
  drivers (activatie binnen 48u), receipts (Overig-aandeel, btw null,
  twijfelvragen onbeantwoord), receipt_corrections (correctie-%),
  exceptions (per check), helpdesk-vragen (herhaling) en support-escalaties.
  Rangschik op impact × aantal chauffeurs × zekerheid / inspanning, stuur
  Top 5 met aanbevolen verbetering naar het CEO-nummer als input voor de
  zondag-triage. Meetlat: elke week een ranglijst; 2 experimenten gekozen.
- [ ] **Product — effectmeting per experiment** (3 sep 2026). Bij elk
  experiment succescriterium + meetdatum (7/14/30 dagen) vastleggen; cron
  meet automatisch en meldt: behouden, terugdraaien of langer meten.
- [ ] **Development — bankafschrift → ontbrekende-bon-detectie** (idee Badr, 3 sep 2026).
  Chauffeur uploadt MT940 of CAMT.053; wij keren het om: elke pin bij een
  bekende kostenpartij (Shell, Q-Park, wasstraat) zonder bon binnen ±3 dagen
  en ±€0,50 wordt een gerichte WhatsApp-vraag: "Donderdag €58 bij Shell,
  geen bon. Stuur hem, anders mis je €10." Bouwt voort op
  `services/bank-import.js` (CAMT.053 bestaat; MT940-parser toevoegen),
  winkelgeheugen (merchant_profiles) en de categorie-tabel. Meetlat:
  teruggevonden bonnen per week en btw-bedrag daarvan.
