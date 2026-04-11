---
name: systematic-debug
description: Gebruik bij elke bug, test-failure of onverwacht gedrag, vóór je een fix voorstelt — reproduceer, observeer, één hypothese per keer.
---

# Skill: systematic-debug

Gebruik dit bij elke bug, test-failure of onverwacht gedrag — voor je
een fix voorstelt.

## Wanneer

- Code doet iets dat je niet verwacht.
- Een test faalt en je weet niet zeker waarom.
- Een eerdere fix heeft het probleem niet opgelost.

## Stappen

1. **Reproduceer.** Vind het kleinste commando, invoer of klik-pad dat
   de bug betrouwbaar oproept. Zonder reproductie geen fix.
2. **Observeer, niet gok.** Kijk naar de echte output: logs, stack
   trace, response body. Niet naar wat je *denkt* dat er gebeurt.
3. **Stel één hypothese op.** In één zin: "Ik denk dat X gebeurt omdat Y."
4. **Test die hypothese.** Verander één ding. Draai opnieuw. Klopt de
   uitkomst?
5. **Ja → fix de oorzaak.** Nee → hypothese was fout, terug naar 3 met
   nieuwe informatie. Niet stapelen.
6. **Verifieer de fix.** Draai de reproductie opnieuw. Draai ook een
   brede test om regressies te vangen.
7. **Noteer wat je leerde.** Één zin in de commit-message: *waarom*
   de bug ontstond, niet alleen *wat* je veranderde.

## Rode vlaggen

- Je verandert meerdere dingen tegelijk — je weet niet welke hielp.
- Je voegt try/catch of `|| true` toe zonder de oorzaak te begrijpen.
- Je past de test aan in plaats van de code — alleen doen als de test
  aantoonbaar fout was.
- Je "fixt" een symptoom dieper in de stack terwijl de oorzaak hoger
  zit.
- Je hebt drie pogingen gedaan zonder reproductie — stop, stel
  hypothese opnieuw.
