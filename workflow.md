# Workflow — skill-volgorde per scenario

Dit document beschrijft welke skills in welke volgorde gebruikt worden
per type taak. Het is een referentie, geen rigide protocol — gebruik je
oordeel voor triviale taken.

## Nieuwe feature

```
plan-feature → code schrijven → code-review → verify-before-done → commit-netjes
```

1. **plan-feature**: intent uitdiepen, context lezen, plan maken, akkoord.
2. Code schrijven volgens het plan.
3. **code-review**: checklist langs correctheid, leesbaarheid, security.
4. **verify-before-done**: bewijs dat het werkt (test, curl, browser).
5. **commit-netjes**: expliciete staging, conventional message.

## Bugfix

```
systematic-debug → fix → verify-before-done → commit-netjes
```

1. **systematic-debug**: reproduceer, observeer, één hypothese per keer.
2. Fix de root cause.
3. **verify-before-done**: reproductie-stappen slagen nu, regressietest.
4. **commit-netjes**: beschrijf *waarom* de bug ontstond.

## Deploy

```
verify-before-done → deploy-checklist
```

1. **verify-before-done**: alle claims onderbouwd (tests groen, code reviewed).
2. **deploy-checklist**: pre-deploy checks, deploy, post-deploy verificatie.

## Nieuw project starten

```
research-spike (optioneel) → project-bootstrap → plan-feature
```

1. **research-spike**: als technologie/aanpak nog onbekend is.
2. **project-bootstrap**: repo, config, layer, eerste commit.
3. **plan-feature**: eerste feature plannen.

## Werk hervatten na pauze

```
context-resume → (verder met lopende workflow)
```

1. **context-resume**: git log, openstaande taken, huidige staat inlezen.
2. Verder met de workflow waar je gebleven was.

## Productie-incident

```
incident-response → systematic-debug → deploy-checklist
```

1. **incident-response**: triage, mitigeer, communiceer.
2. **systematic-debug**: root cause vinden.
3. **deploy-checklist**: fix deployen.

## Technologie-evaluatie

```
research-spike → plan-feature (als besluit positief)
```

1. **research-spike**: timeboxed onderzoek, opties vergelijken.
2. **plan-feature**: implementatieplan als je besluit door te gaan.
