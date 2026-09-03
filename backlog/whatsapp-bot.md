# Backlog — whatsapp-bot (ZendIQ)

Openstaande punten voor het whatsapp-bot project. Houd dit bij als
centraal overzicht — niet verspreid over project-layers of comments.

## Prioriteit

- [ ] `subscription_tier` kolom toevoegen in Supabase — blocker zodra
  subscription-code geraakt wordt.

## Ideeën / later

- [ ] **Development — bankafschrift → ontbrekende-bon-detectie** (idee Badr, 3 sep 2026).
  Chauffeur uploadt MT940 of CAMT.053; wij keren het om: elke pin bij een
  bekende kostenpartij (Shell, Q-Park, wasstraat) zonder bon binnen ±3 dagen
  en ±€0,50 wordt een gerichte WhatsApp-vraag: "Donderdag €58 bij Shell,
  geen bon. Stuur hem, anders mis je €10." Bouwt voort op
  `services/bank-import.js` (CAMT.053 bestaat; MT940-parser toevoegen),
  winkelgeheugen (merchant_profiles) en de categorie-tabel. Meetlat:
  teruggevonden bonnen per week en btw-bedrag daarvan.
