---
name: zondag-triage
description: Gebruik elke zondag of als de sessie-start-hook het meldt — signalen verzamelen, problemen met cijfer benoemen, rangschikken op impact × gebruikers × zekerheid / inspanning, maximaal twee experimenten kiezen met succescriterium en meetdatum.
---

# Skill: zondag-triage

De motor van de afdeling Product. Verbetering komt uit gemeten
klantgedrag, niet uit wat toevallig opvalt. Eén keer per week, een kwartier.

## Wanneer

- Zondag, of wanneer de sessie-start-hook "ritueel: zondag-triage" toont.
- Nooit meer dan één keer per week; tussendoor gaan ideeën in de ideeënbus.

## Stappen

1. **Eerst effectmeting.** Staan er experimenten in `company/experimenten.md`
   met een verstreken meetdatum? Draai dan eerst `effectmeting`. Geen nieuw
   experiment zolang een oud experiment onbeoordeeld is.
2. **Signalen verzamelen.** Draai `node -r dotenv/config scripts/metrics.js`
   in `~/Whatsapp-bot` (alleen totalen). Lees de ideeënbus
   (`backlog/*.md`, sectie "Ideeën / later"), de laatste logboek-regels in
   `company/logboek.md`, en wat Badr aandraagt.
3. **Problemen benoemen met een cijfer.** "18% van de nieuwe chauffeurs
   stuurt binnen 48 uur geen bon." Geen cijfer, geen probleem; dan eerst
   meten. Bij een funnelcijfer: check of de query filtert op een veld dat pas
   ná de gemeten stap gevuld wordt, anders zie je de uitvallers niet.
4. **Rangschikken.** Per probleem: impact (1 t/m 5) × geraakte gebruikers ×
   zekerheid (0,3 / 0,6 / 0,9) / inspanning in dagen. Toon de tabel.
5. **Kies maximaal twee.** Per gekozen experiment: probleem, hypothese,
   succescriterium als getal (van → naar), meetdatum (7, 14 of 30 dagen),
   eigenaar-afdeling. Een ranking-meetlat noemt altijd zoekterm én pagina,
   en de nulmeting gebruikt datzelfde paginafilter. Schrijf ze als E-rij in
   `company/experimenten.md`.
6. **Afgewezen ideeën** blijven in de ideeënbus met één regel waarom nu niet.
7. **Afsluiten met `afdeling-update`**: logboek-regel, pagina bouwen,
   publiceren, committen.

## Output

Een gerangschikte tabel, hoogstens twee nieuwe E-rijen met criterium en
datum, en een logboek-regel. Wat Development deze week bouwt, staat daarmee
vast.

## Rode vlaggen

- Een succescriterium zonder getal ("onboarding verbeteren").
- Meer dan twee experimenten, of een experiment zonder meetdatum.
- Triage zonder `metrics.js` gedraaid: "ik denk dat" is geen signaal.
- Een oud experiment dat onbeoordeeld blijft staan terwijl er nieuwe komen.
- Een nulmeting uit een site-breed rapport voor een hypothese over één pagina.
