---
name: plan-feature
description: Gebruik vóór elke niet-triviale wijziging — huisregels bovenop superpowers brainstorming en writing-plans: Nederlands plan met succescriterium, akkoord vóór code, plan.md bij groter werk.
---

# Skill: plan-feature

Het denkwerk doet superpowers (`brainstorming` voor de intent,
`writing-plans` voor het plan). Dit zijn de huisregels die daar bovenop
gelden.

## Huisregels

1. **Eerst het probleem met een cijfer, dan de hypothese.** Bij Zendiq-werk:
   welk signaal of welke meting zegt dat dit het probleem is? Geen cijfer,
   dan eerst meten (`scripts/metrics.js`) of het als idee in de ideeënbus.
2. **Succescriterium en meetdatum vooraf.** Als getal, van → naar, en
   wanneer we meten. Zet het experiment in `company/experimenten.md`.
3. **Plan in het Nederlands, 5 tot 15 regels, genummerd**, per stap bestand
   en verandering. Eindig met één vraag: "Akkoord?" Geen code vóór akkoord.
4. **Groter werk (meerdere sessies of meer dan drie bestanden):** schrijf het
   goedgekeurde plan naar `plan.md` in de repo-root met de secties
   *Files that change*, *Order of work*, *Risks*, *Proof*. Proof benoemt
   vooraf welk bewijs "klaar" aantoont. Wijk je af, werk `plan.md` bij in
   dezelfde commit.
5. **Feature-branch, één doel per commit** (zie `commit-netjes`), deploy
   alleen via `deploy-checklist` en met expliciet akkoord.

## Rode vlaggen

- Bouwen zonder nulmeting of criterium: "we zien wel of het helpt".
- Meer dan 10 stappen: splits.
- Je typt al code en de gebruiker heeft nog niet bevestigd.
