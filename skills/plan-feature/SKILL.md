---
name: plan-feature
description: Gebruik vóór elke niet-triviale wijziging (feature, refactor, bugfix met onduidelijke oorzaak), vóór je code aanraakt — intent, context, plan, akkoord, dan pas uitvoeren.
---

# Skill: plan-feature

Gebruik dit voor elke niet-triviale wijziging: nieuwe feature, grotere
refactor, of bugfix met onduidelijke oorzaak.

## Wanneer

- Taak raakt meer dan één bestand of module.
- Intent is niet 100% helder uit de vraag.
- Er zijn meerdere redelijke aanpakken.

## Stappen

1. **Intent uitdiepen.** Stel 1-3 korte vragen die scope en succes
   vastleggen. Wat moet er kunnen? Wat expliciet niet?
2. **Context lezen.** Open de relevante bestanden. Begrijp hoe het
   vandaag werkt voor je iets verandert.
3. **Aanpak kiezen.** Schrijf 2-4 stappen op die samen de oplossing
   vormen. Per stap: welk bestand, welke verandering.
4. **Risico's noemen.** Wat kan breken? Welke tests dekken het?
   Welke niet?
5. **Bevestiging vragen.** Leg het plan voor. Start pas met code zodra
   er akkoord is.
6. **Uitvoeren in de volgorde van het plan.** Bij afwijking: pauzeer,
   leg uit, vraag akkoord.

## Output

Een kort plan (5-15 regels) met genummerde stappen, niet een essay.
Eindig met één vraag: "Akkoord?"

## Rode vlaggen

- Je begint met code schrijven voor je de intent helder hebt.
- Het plan telt meer dan 10 stappen — splits de taak.
- Je weet niet welke test de verandering zou dekken.
- De gebruiker heeft niet bevestigd en je bent al aan het typen.
