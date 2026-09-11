---
name: verify-before-done
description: Gebruik vóór je "klaar", "werkt", "fixed" of "live" zegt — bewijs per claim, gedraaid en getoond; bij Zendiq geldt bovendien: pas klaar na effectmeting.
---

# Skill: verify-before-done

Bewijs gaat vóór claims. Superpowers `verification-before-completion`
geeft het principe; dit is de bewijstabel die hier geldt.

## Stappen

1. **Benoem de claim.** "De bug is weg", "de test slaagt", "de deploy is live".
2. **Kies het bewijs dat bij de claim past en draai het echt.**

   | Claim | Bewijs |
   |---|---|
   | Bug is weg | Reproductie-stappen slagen nu |
   | Test slaagt | Output van `npm test` |
   | Endpoint werkt | `curl` met status en body |
   | UI werkt | Browser-check van happy path én één edge case |
   | Deploy is live | HTTP-respons van de productie-URL |
   | Database update | `select` die het nieuwe record toont |
   | Tracking van derden werkt | Laden: headless test. Aankomst: netwerkverzoek in een echte browser plus het eventoverzicht van de leverancier |
   | Feature is klaar (Zendiq) | Gemeten tegen het succescriterium via `effectmeting` |

3. **Meet op de juiste basis.** Een telling of stand over code meet je op de
   branch waar het werk heen gaat (`git show origin/main:<pad>` of een verse
   worktree), niet in de gedeelde werkmap. Die staat op een willekeurige
   branch van een andere sessie. Noem de basis bij het getal.
4. **Rapport van een andere agent of sessie?** Behandel het als een lijst
   losse claims. Zet elke regel om in een eigen check: een SHA met
   `git rev-parse`, de CI-status, een testaantal uit een echte testrun, een
   schema met een DB-probe. Meld per regel of hij klopt. Bij nummeringen
   zoals H1 of M5: stel eerst vast welk document de bron van de nummering is.
5. **Tracking van derden** (pixel, analytics): leveranciers negeren vaak
   geautomatiseerd verkeer. Een headless test bewijst dus alleen dat het
   script op het juiste moment laadt en start. Aankomst bewijs je in een
   echte browser met een harde herlaadactie, via het netwerkverzoek naar de
   leverancier. Omzeil de detectie van geautomatiseerd verkeer niet. Laat de
   gebruiker die stap doen als het niet anders kan, en zeg welk deel nog
   onbewezen is.
6. **Toon het resultaat** in je antwoord. Niet "klaar", maar wat je zag.
7. **Geen toegang?** Zeg dat expliciet en vraag om het commando en de output.

## Rode vlaggen

- "Zou moeten", "waarschijnlijk", "ik denk dat" in een afrondende zin.
- Type-check slaagt en jij noemt dat "getest".
- "Live" zonder HTTP-respons; "klaar" zonder meting.
- Een getal over code zonder de branch waarop het gemeten is.
- Een rapport van een andere agent doorgeven als "klopt" zonder per regel te checken.
- "De pixel werkt" op basis van een headless test.
