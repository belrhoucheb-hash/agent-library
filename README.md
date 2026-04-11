# agent-library

Eén generieke agent-library met **layers** (pad-scoped context) en
**skills** (herbruikbare procedures). Geïnspireerd op het
[agentic-infrastructure-bootstrap](https://github.com/Sarony11/agentic-infrastructure-bootstrap)
patroon, maar geminimaliseerd voor solo-gebruik.

## Mentaal model

- **Layers** = markdown-context die Claude automatisch laadt op een
  specifieke locatie. Bijvoorbeeld `global.md` overal, `whatsapp-bot.md`
  alleen binnen `~/Whatsapp-bot/*`.
- **Skills** = herbruikbare procedures (plan, debug, review…) die
  overal beschikbaar zijn.
- **`library.yaml`** = manifest. Single source of truth over wat er
  bestaat en waar de symlinks heen wijzen.
- **`setup.sh`** = leest de manifest, maakt de symlinks. Geen
  dependencies.

## Mapstructuur

```
agent-library/
├── library.yaml              # manifest
├── setup.sh                  # installer
├── SKILLS-INDEX.md           # leesbare skills-index
├── layers/
│   ├── global.md             # werkstijl, kwaliteit, verificatie
│   ├── repos-shared.md       # git/security conventies
│   └── projects/
│       └── whatsapp-bot.md   # ZendIQ-specifieke context
└── skills/
    ├── plan-feature.md
    ├── systematic-debug.md
    ├── code-review.md
    ├── verify-before-done.md
    └── commit-netjes.md
```

## Installatie

```bash
git clone <deze-repo> ~/repos/agent-library
cd ~/repos/agent-library
bash setup.sh
```

Disaster recovery: bovenstaande twee commando's op een nieuwe machine
herstellen je volledige setup.

## Nieuwe skill of layer toevoegen

1. Schrijf het markdown-bestand in `skills/` of `layers/`.
2. Voeg een entry toe in `library.yaml` met `source`, `target`, `scope`.
3. Draai `bash setup.sh` om de symlink aan te maken.
4. Werk `SKILLS-INDEX.md` bij als het om een skill gaat.
5. Commit.

## Nieuwe project-layer toevoegen

Als je een nieuw project hebt met eigen conventies:

1. Maak `layers/projects/<naam>.md` met de project-context
   (stack, kritieke modules, harde regels, commando's).
2. Voeg in `library.yaml` toe:
   ```yaml
   - name: <naam>
     source: layers/projects/<naam>.md
     target: ~/<project-pad>/CLAUDE.md
     scope: "~/<project-pad>/*"
   ```
3. Draai `bash setup.sh`.

## Windows

`ln -sfn` werkt alleen in Git Bash als developer mode aan staat
(Windows-instellingen → Voor ontwikkelaars → Developer Mode). Zonder
dat valt `setup.sh` terug op kopiëren — wijzigingen in de library
worden dan pas live na opnieuw `setup.sh` draaien.

## Niet in scope (voor nu)

- Aparte `agent-setup/` repo per tool — pas nodig bij meerdere tools.
- `resource-catalog/` met Backstage YAML — pas nodig bij meerdere teams.
- Uitvoerbare skills (bash/python) — pas nodig als een skill écht iets
  moet draaien in plaats van instrueren.
- Slash-commands — toe te voegen wanneer je merkt dat je dezelfde
  skill vaak handmatig aanroept.
