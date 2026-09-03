---
name: effectmeting
description: Gebruik zodra een experiment in company/experimenten.md over zijn meetdatum is — meet tegen het succescriterium en besluit: behouden, terugdraaien of langer meten; leg resultaat en geleerde regel vast.
---

# Skill: effectmeting

Geen feature is klaar na deploy. Hij is klaar nadat gemeten is of hij het
gewenste resultaat opleverde. Deze skill is dat moment.

## Wanneer

- Een E-rij in `company/experimenten.md` heeft een meetdatum die vandaag of
  eerder is (de sessie-start-hook meldt dit).
- Badr vraagt "heeft het gewerkt?".

## Stappen

1. **Lees het experiment.** Probleem, hypothese, succescriterium, meetdatum,
   en de nulmeting in `company/nulmeting.md`.
2. **Meet.** Draai `node -r dotenv/config scripts/metrics.js` in
   `~/Whatsapp-bot`, of de specifieke query die het criterium vraagt. Alleen
   totalen, geen persoonsgegevens. Zet het cijfer naast het criterium.
3. **Oordeel, één van drie.**
   - **Behouden**: criterium gehaald. Status `info: behouden <datum>`.
   - **Terugdraaien of aanpassen**: niet gehaald en geen zicht op halen.
     Start `plan-feature` voor de revert of de aanpassing.
   - **Langer meten**: te weinig gebruik om iets te zeggen. Nieuwe meetdatum,
     maximaal één keer verlengen; daarna is het "niet gehaald".
4. **Leg vast** via `afdeling-update`: in het logboek het resultaat met het
   gemeten cijfer en de geleerde regel (wat weten we nu dat we eerst niet
   wisten); in `experimenten.md` de nieuwe status.

## Output

Per experiment één regel: criterium, gemeten waarde, oordeel, regel.

## Rode vlaggen

- "Het werkt vast wel" zonder cijfer.
- Verlengen zonder reden of meer dan één keer.
- Een experiment dat eeuwig op "loopt" blijft staan.
- Resultaat invullen op basis van tests of CI in plaats van gebruik.
