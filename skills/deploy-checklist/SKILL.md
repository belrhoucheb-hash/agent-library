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
5. **Handmatige SQL voor productie.** Schrijf hem als één blok dat afbreekt
   bij een onverwachte rijtelling (`get diagnostics` met `row_count`, dan
   `raise exception`). Draai hem eerst tegen een wegwerp-Postgres, zoals
   PGlite in een scratchmap of de test-DB: een normale run, een herhaalde run
   en een run met afwijkende data. Leg de uitkomst naast de SQL. Match bij
   tekstvervanging op platte tekst, niet op opgemaakte HTML. Geef zulke SQL
   nooit als terminaltekst om te kopiëren: lange regels breken dan af. Zet
   het bestand op het klembord (`Set-Clipboard` of `pbcopy`) en controleer
   de overdracht met een hash. Hangt de code af van zo'n stap, toon dan vóór
   de merge met één live probe aan dat hij gedraaid is, bijvoorbeeld de
   nieuwe rij via de publieke API. Geen bewijs, geen merge.
6. **Breaking changes.** Zijn er API-wijzigingen die bestaande clients
   breken? Zo ja: communiceer of versie.
7. **Rollback-plan.** Weet je hoe je terugdraait als het misgaat?
   (vorige deploy, feature flag, database rollback)

### Deploy

8. **Voer de deploy uit.** Gebruik het project-specifieke commando
   (zie project-layer → Commando's).
9. **Wacht op bevestiging.** Deploy-log, status check, of dashboard
   dat "live" toont.

### Post-deploy

10. **Smoke test.** Draai de kritieke paden handmatig:
   - Kan een gebruiker inloggen / het hoofdproces doorlopen?
   - Retourneert de API correcte responses?
   - Test in een echte browser met de cache omzeild, via een harde
     herlaadactie of een vers profiel. Een warme cache toont de vorige versie.
   - Controleer met één HEAD-request (`curl -sI <url>`) de cache-headers van
     gewijzigde HTML, JS en CSS. Ontbreekt revalidatie, meld dat als risico:
     terugkerende bezoekers draaien dan nog de oude code.
11. **Logs checken.** Geen nieuwe errors of warnings in de eerste
    minuten na deploy?
12. **Meld het.** Kort bericht: wat is gedeployed, wanneer, en of de
    smoke test slaagde.

## Output

Bevestiging met bewijs: deploy-log of status URL, smoke test resultaat.

## Rode vlaggen

- Je deployt zonder tests gedraaid te hebben.
- Nieuwe env vars ontbreken in productie → app crasht bij opstarten.
- Je deployt op vrijdagmiddag zonder rollback-plan.
- Je zegt "het is live" zonder een HTTP-request naar productie gedaan
  te hebben.
- Handmatige productie-SQL die niet eerst op een wegwerp-database draaide.
- Een merge die leunt op een handmatige datastap, zonder live bewijs dat die stap gedraaid is.
- SQL die iemand uit de terminal moet overtypen of kopiëren.
- Smoke test in een browser met warme cache.
- Migration faalt maar je pusht de code toch — data en code lopen uit
  sync.
