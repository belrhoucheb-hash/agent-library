# Skill: verify-before-done

Gebruik dit voor je "klaar", "werkt", "fixed" of "gedeployed" zegt.
Bewijs gaat altijd vóór claims.

## Wanneer

- Je staat op het punt een taak als voltooid te markeren.
- Je gaat commiten of een PR openzetten.
- Iemand vraagt "is het af?"

## Stappen

1. **Wat is de claim?** Schrijf op wat je beweert: "de bug is weg",
   "de test slaagt", "de endpoint werkt", "de deploy is live".
2. **Kies bewijs per claim.** Elke claim heeft een eigen soort bewijs:

   | Claim | Bewijs |
   |---|---|
   | Bug is weg | Reproductie-stappen → nu slaagt ze |
   | Test slaagt | Output van `npm test` / `node test-X.js` |
   | Endpoint werkt | `curl` respons met status en body |
   | UI werkt | Browser-check van happy path én één edge case |
   | Deploy is live | `curl` naar prod URL of zichtbare statuscode |
   | Database update | `select` die het nieuwe record toont |

3. **Draai het bewijs.** Daadwerkelijk. Niet "dit zou moeten werken".
4. **Plak of vat het resultaat samen.** In je antwoord aan de gebruiker.
   Niet alleen "klaar" — toon wat je zag.
5. **Bij geen toegang:** zeg dat expliciet. "Ik kan dit niet verifiëren
   vanaf hier — draai jij even `X` en stuur de output?"

## Rode vlaggen

- Je gebruikt "zou moeten", "waarschijnlijk", "ik denk dat" in een
  afrondende uitspraak.
- Je hebt de test-output niet gezien.
- Je claimt dat iets live is zonder een HTTP-respons gezien te hebben.
- Je vinkt een taak af omdat de code er logisch uitziet.
- Type-check slaagt en jij noemt dat "getest" — type-checks testen
  types, niet gedrag.
