---
name: deploy-checklist
description: Gebruik bij elke deploy naar staging of productie — pre-deploy checks, deploy uitvoeren, post-deploy verificatie.
---

# Skill: deploy-checklist

Gebruik dit bij elke deploy. Een deploy zonder checklist is een gok.

## Wanneer

- Je gaat code deployen naar staging of productie.
- Iemand vraagt "kun je dit live zetten?"
- Na een hotfix die naar productie moet.

## Stappen

### Pre-deploy

1. **Tests groen?** Draai de volledige testsuite. Niet "ze waren
   gisteren groen".
2. **Code reviewed?** Is de code-review checklist doorlopen?
   Zo niet: eerst `code-review`.
3. **Environment variables.** Zijn alle nieuwe env vars aanwezig in de
   deploy-omgeving? Check `.env.example` tegen de werkelijke config.
4. **Migrations.** Zijn er database-wijzigingen? Zo ja: migration
   eerst draaien of bevestigen dat de deploy dat automatisch doet.
5. **Breaking changes.** Zijn er API-wijzigingen die bestaande clients
   breken? Zo ja: communiceer of versie.
6. **Rollback-plan.** Weet je hoe je terugdraait als het misgaat?
   (vorige deploy, feature flag, database rollback)

### Deploy

7. **Voer de deploy uit.** Gebruik het project-specifieke commando
   (zie project-layer → Commando's).
8. **Wacht op bevestiging.** Deploy-log, status check, of dashboard
   dat "live" toont.

### Post-deploy

9. **Smoke test.** Draai de kritieke paden handmatig:
   - Kan een gebruiker inloggen / het hoofdproces doorlopen?
   - Retourneert de API correcte responses?
10. **Logs checken.** Geen nieuwe errors of warnings in de eerste
    minuten na deploy?
11. **Meld het.** Kort bericht: wat is gedeployed, wanneer, en of de
    smoke test slaagde.

## Output

Bevestiging met bewijs: deploy-log of status URL, smoke test resultaat.

## Rode vlaggen

- Je deployt zonder tests gedraaid te hebben.
- Nieuwe env vars ontbreken in productie → app crasht bij opstarten.
- Je deployt op vrijdagmiddag zonder rollback-plan.
- Je zegt "het is live" zonder een HTTP-request naar productie gedaan
  te hebben.
- Migration faalt maar je pusht de code toch — data en code lopen uit
  sync.
