---
name: context-resume
description: Gebruik bij het hervatten van werk na een pauze of nieuwe sessie — lees git log, openstaande taken, en huidige staat in voordat je verder gaat.
---

# Skill: context-resume

Gebruik dit wanneer je werk hervat na een onderbreking. Voorkomt dat je
opnieuw moet inlezen of context verliest tussen sessies.

## Wanneer

- Begin van een nieuwe Claude Code sessie op een bestaand project.
- Je pakt werk op dat je gisteren of langer geleden hebt neergelegd.
- Je switcht tussen projecten en moet de draad oppakken.

## Stappen

1. **Git status checken.**
   ```bash
   git status
   git log --oneline -10
   git diff --stat
   ```
   Wat is de huidige branch? Zijn er uncommitted changes? Wat waren
   de laatste commits?

2. **Backlog lezen.** Open `backlog/<projectnaam>.md` in de
   agent-library. Wat staat er open? Wat was de prioriteit?

3. **Project-layer scannen.** Lees de project-layer voor openstaande
   punten en harde regels die relevant zijn.

4. **Lopend werk identificeren.** Is er een half-af feature branch?
   Een gefaalde test? Een TODO in de code?
   ```bash
   git branch -a
   grep -r "TODO\|FIXME\|HACK" --include="*.js" --include="*.ts" -l
   ```

5. **Samenvatten.** Geef een korte status aan de gebruiker:
   - **Branch:** `feature/x` — 3 commits voor op main
   - **Laatste actie:** feat(marketing): telegram publisher
   - **Openstaand:** 2 items in backlog, 1 uncommitted change
   - **Volgende stap:** [concrete actie]

6. **Bevestig.** Vraag: "Wil je hier verder, of is er iets anders?"

## Output

5-10 regels status-overzicht met een concrete suggestie voor de
volgende stap.

## Rode vlaggen

- Je begint code te schrijven zonder te weten wat de huidige staat is.
- Er zijn uncommitted changes die je niet herkent — onderzoek eerst.
- Je negeert de backlog en begint aan iets nieuws.
- Je vergeet te vragen of de prioriteit veranderd is.
