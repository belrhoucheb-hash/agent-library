---
name: systematic-debug
description: Gebruik bij elke bug of onverwacht gedrag — huisregels bovenop superpowers systematic-debugging: reproductie als falende test, test-lock via .claude/fix-in-progress, oorzaak in de commit-message.
---

# Skill: systematic-debug

Het proces staat in superpowers `systematic-debugging` (vier fasen,
één hypothese per keer). Dit zijn de huisregels die daar bovenop gelden.

## Huisregels

1. **Reproductie eerst, als falende test waar het kan.** Maak daarna
   `.claude/fix-in-progress` aan in de project-root: zolang die bestaat
   blokkeert een hook edits aan test-bestanden. Fix de code, niet de test.
2. **Kijk naar echte output**: logs, stack trace, response body, databaserij.
   Bij productie: eerst `incident-response` (stabiliseren), dan debuggen.
3. **Eén verandering per poging.** Drie pogingen zonder reproductie: stop en
   formuleer de hypothese opnieuw.
4. **Verifieer met de reproductie én de brede suite.** Verwijder daarna
   `.claude/fix-in-progress`.
5. **De commit-message zegt waaróm de bug ontstond**, niet alleen wat er
   veranderde. Twee keer dezelfde fout: regel in de project-layer of hook.

## Rode vlaggen

- try/catch of `|| true` zonder de oorzaak te kennen.
- De test aanpassen in plaats van de code.
- Een symptoom fixen dieper in de stack terwijl de oorzaak hoger zit.
