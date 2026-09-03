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
   | Feature is klaar (Zendiq) | Gemeten tegen het succescriterium via `effectmeting` |

3. **Toon het resultaat** in je antwoord. Niet "klaar", maar wat je zag.
4. **Geen toegang?** Zeg dat expliciet en vraag om het commando en de output.

## Rode vlaggen

- "Zou moeten", "waarschijnlijk", "ik denk dat" in een afrondende zin.
- Type-check slaagt en jij noemt dat "getest".
- "Live" zonder HTTP-respons; "klaar" zonder meting.
