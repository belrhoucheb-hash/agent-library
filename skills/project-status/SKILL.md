---
name: project-status
description: Gebruik om de voortgang van een project te bekijken — backlog, git activiteit, open werk, milestones, en volgende stap.
---

# Skill: project-status

Gebruik dit om een helder overzicht te krijgen van waar een project
staat. Combineert backlog, git log, en code-staat tot een dashboard.

## Wanneer

- Je wilt weten "hoe staat project X ervoor?"
- Begin van de week: prioriteiten bepalen over meerdere projecten.
- Voor een meeting of update aan iemand anders.
- Je twijfelt of een project achterloopt of op schema ligt.

## Stappen

1. **Backlog lezen.** Open `backlog/<projectnaam>.md`:
   - Tel open items per categorie (prioriteit vs ideeën/later)
   - Welke items zijn blockers?

2. **Git activiteit.** Bekijk de afgelopen periode:
   ```bash
   git log --oneline --since="2 weeks ago"
   git shortlog --since="2 weeks ago" -s
   ```
   - Hoeveel commits? Op welke onderdelen?
   - Is er recent activiteit of staat het project stil?

3. **Branch-staat.**
   ```bash
   git branch -a
   git status
   ```
   - Open feature-branches die niet gemerged zijn?
   - Uncommitted werk?

4. **Code-gezondheid.** Snelle check:
   - Draait de testsuite groen?
   - Zijn er TODO/FIXME/HACK items in de code?
   - Zijn dependencies up to date? (`npm outdated` / `pip list --outdated`)

5. **Milestones bepalen.** Wat zijn de volgende concrete doelen?
   - Wat is de volgende release / deploy / launch?
   - Welke backlog-items moeten daarvoor af?
   - Schatting: hoeveel werk is dat?

6. **Samenvatting genereren.** Format:

   ```
   ## Project: <naam>
   **Status:** actief / on hold / launch-ready
   **Laatste activiteit:** <datum> — <laatste commit>
   **Backlog:** X open (Y prioriteit, Z ideeën)
   **Branches:** X open, Y uncommitted changes
   **Tests:** groen / rood / geen
   **Volgende milestone:** <wat> — geschatte items: N
   **Blocker:** <indien van toepassing>
   **Aanbevolen volgende stap:** <concrete actie>
   ```

## Multi-project overzicht

Als je meerdere projecten wilt vergelijken, geef een tabel:

```
| Project | Status | Laatste activiteit | Open items | Volgende stap |
|---|---|---|---|---|
| whatsapp-bot | actief | vandaag | 1 | subscription_tier kolom |
| driver-acquisition | nieuw | - | 8 | project opzetten |
| Addayn | on hold | 3 dagen | 0 | TBD |
```

## Output

Een kort, scanbaar statusrapport — geen essay. Feiten, niet meningen.
Eindig altijd met één concrete aanbevolen volgende stap per project.

## Rode vlaggen

- Je geeft een status zonder de backlog en git log gelezen te hebben.
- Je zegt "op schema" zonder meetbare milestone te benoemen.
- Je vergeet blockers te benoemen — die bepalen de echte voortgang.
- Je geeft status over een project waar je niet recent in gewerkt hebt
  zonder de code te checken — de staat kan veranderd zijn.
