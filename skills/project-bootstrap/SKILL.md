---
name: project-bootstrap
description: Gebruik bij het starten van een nieuw project — repo opzetten, config aanmaken, project-layer toevoegen aan de agent-library, eerste commit.
---

# Skill: project-bootstrap

Gebruik dit wanneer je een nieuw project vanaf nul opzet. Zorgt ervoor
dat elk project dezelfde basis heeft en meteen klaar is voor
gestructureerd werk.

## Wanneer

- Je begint een nieuw project of prototype.
- Je neemt een bestaand project over dat nog geen structuur heeft.
- Je maakt een repo aan voor iets dat langer dan een dag gaat duren.

## Stappen

1. **Doel vastleggen.** Eén zin: wat doet dit project, voor wie?
2. **Repo aanmaken.**
   - `git init` of repo aanmaken op GitHub.
   - Kies een duidelijke naam (lowercase, hyphens).
3. **Basis-bestanden aanmaken:**

   | Bestand | Inhoud |
   |---|---|
   | `.gitignore` | Taal-specifiek + `.env`, `node_modules/`, etc. |
   | `.env.example` | Alle benodigde env vars met placeholder waarden |
   | `README.md` | Projectnaam, één zin beschrijving, setup-instructies |
   | `package.json` / equivalent | Minimale config, geen onnodige deps |

4. **Project-layer aanmaken.**
   - Kopieer `layers/projects/_template.md` naar
     `layers/projects/<naam>.md`.
   - Vul in: stack, kritieke modules (voor zover bekend), commando's.
   - Voeg `depends_on` toe met relevante stack-layers.
5. **library.yaml bijwerken.** Voeg entry toe:
   ```yaml
   - name: <naam>
     source: layers/projects/<naam>.md
     target: ~/<project-pad>/CLAUDE.md
     scope: "~/<project-pad>/*"
     depends_on: [repos-shared, <stack-layers>]
   ```
6. **Backlog aanmaken.** Maak `backlog/<naam>.md` met eerste
   openstaande punten.
7. **setup.sh draaien.** Zodat de symlinks/CLAUDE.md op hun plek staan.
8. **Eerste commit.**
   ```
   feat(<naam>): initial project setup
   ```

## Output

Een werkende repo met basis-bestanden, een project-layer in de
agent-library, en een eerste commit.

## Rode vlaggen

- Je begint code te schrijven voor de basis-bestanden er zijn.
- `.env` met echte secrets staat in de repo.
- Geen `.gitignore` — alles wordt getrackt inclusief node_modules.
- Project-layer ontbreekt — Claude heeft geen context bij volgende sessie.
- Je installeert 10 dependencies voor je één regel code hebt.
