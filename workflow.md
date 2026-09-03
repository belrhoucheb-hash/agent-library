# Workflow — skill-volgorde per scenario

Dit document beschrijft welke skills in welke volgorde gebruikt worden
per type taak. Het is een referentie, geen rigide protocol — gebruik je
oordeel voor triviale taken.

Sinds sept 2026 triggeren de skills vanzelf (allemaal gedeployed) en
blokkeren hooks wat niet mag; de mens zit op de akkoord-momenten:
plan goedkeuren, deploy vrijgeven.

## Nieuwe feature (hoofdroute)

```
context-resume → plan-feature → bouwen → /code-review → verifier → commit-netjes
```

1. **context-resume**: bij hervatten — git log, backlog, staat inlezen.
   De project-CLAUDE.md laadt vanzelf bij sessiestart in de repo.
2. **plan-feature**: intent uitdiepen, plan, akkoord. Bij >3 bestanden
   of meerdere sessies: plan als `plan.md` in de repo (Files/Order/
   Risks/Proof), het waarom eventueel als `intent.md`.
3. Bouwen volgens het plan. Wijkt het af → `plan.md` bijwerken in
   dezelfde commit; de gemergde diff moet matchen met het plan.
4. **/code-review**: het *ingebouwde* commando (de library-skill
   code-review is bewust niet gedeployed — het ingebouwde is sterker).
   Default-niveau volstaat; `high` bij risicovol werk.
5. **verifier-agent**: "laat de verifier het checken" — verse context
   draait app/tests plus de twee aangrenzende flows, rapporteert
   letterlijke output. **verify-before-done** is daarna het laatste
   slot vóór "klaar".
6. **commit-netjes**: expliciete staging, conventional message,
   `plan.md` mee in de commit.

**Kleine wijziging** (diff in één zin te beschrijven): plan overslaan,
gewoon doen — dan stap 4-6 in lichte vorm.

## Bugfix

```
systematic-debug (met test-lock) → fix → verify-before-done → commit-netjes
```

1. **systematic-debug**: reproduceer als falende test, zet
   `.claude/fix-in-progress` — de hook blokkeert test-edits zolang de
   marker bestaat (fix de code, niet de test).
2. Fix de root cause; verifieer; marker weg.
3. **commit-netjes**: beschrijf *waarom* de bug ontstond.
4. Kwam de bug uit productie → de reproductie blijft staan als
   permanente regressietest.

## Deploy (productie-repos)

```
verify-before-done → deploy-checklist → akkoord → DEPLOY_OK=1 git push
```

1. **verify-before-done**: alle claims onderbouwd (tests groen,
   code reviewed).
2. **deploy-checklist**: pre-deploy checks, deploy, post-deploy
   verificatie.
3. In repos met `.claude/production-repo` blokkeert de hook de push
   naar main; na expliciet akkoord van Badr: `DEPLOY_OK=1 git push`.

## Productie-incident

```
incident-response → systematic-debug → deploy-checklist
```

1. **incident-response**: triage, mitigeer, communiceer.
2. **systematic-debug**: root cause vinden.
3. **deploy-checklist**: fix deployen.
4. De les gaat naar "Wat Claude hier fout doet" in de project-layer,
   of wordt een hook als hij zonder uitzondering moet gelden.

## Nieuw project starten

```
research-spike (optioneel) → project-bootstrap → plan-feature
```

1. **research-spike**: als technologie/aanpak nog onbekend is.
2. **project-bootstrap**: repo, config, project-layer, eerste commit.
3. **plan-feature**: eerste feature plannen.

## Lanceren / voortgang

- **launch-checklist**: bij livegang of promotie van een project.
- **project-status**: voortgang bekijken, volgende stap kiezen.

## Technologie-evaluatie

```
research-spike → plan-feature (als besluit positief)
```

## Gewoontes (de loop eromheen)

- **Twee keer dezelfde fout** → correctie in de project-layer
  ("Wat Claude hier fout doet"), of een hook. Fouten worden één keer
  gemaakt.
- **Twee mislukte correcties** → niet doorduwen: `/clear`, betere
  prompt, opnieuw.
- **`/clear` tussen ongerelateerde taken** — geen kitchen-sink-sessies.
- **Meerdere projecten** → aparte sessie per repo; elke sessie laadt
  zijn eigen layer.
- **Zondag** → `zondag-triage`: signalen, ranglijst, max twee experimenten
  met succescriterium en meetdatum. Na elke meetdatum → `effectmeting`.
- **Na elk afgerond stuk Zendiq-werk** → `afdeling-update`: logboek-regel
  (probleem → hypothese → wijziging → resultaat → regel), pagina genereren
  en publiceren. Geen feature is klaar vóór de effectmeting.
