# agent-library

Eén generieke agent-library met **layers** (pad-scoped context),
**stacks** (composable tech-conventies), **skills** (herbruikbare
procedures), en **hooks** (automatische triggers). Geïnspireerd op het
[agentic-infrastructure-bootstrap](https://github.com/Sarony11/agentic-infrastructure-bootstrap)
patroon, maar geminimaliseerd voor solo-gebruik.

## Mentaal model

- **Layers** = markdown-context die Claude automatisch laadt op een
  specifieke locatie. Bijvoorbeeld `global.md` overal, `whatsapp-bot.md`
  alleen binnen `~/Whatsapp-bot/*`.
- **Stacks** = composable tech-specifieke conventies (Node+Express,
  Supabase, Vercel). Worden via `depends_on` aan project-layers
  gekoppeld — geen duplicatie.
- **Skills** = herbruikbare procedures (plan, debug, review, deploy…).
  Elke skill is een `SKILL.md` met YAML frontmatter in een eigen map.
- **Hooks** = shell-scripts die Claude Code automatisch triggert bij
  events (sessie-start, pre-commit). Zorgen voor discipline zonder
  handmatige aanroep.
- **Workflow** = `workflow.md` beschrijft welke skills in welke
  volgorde per type taak (feature, bugfix, deploy, incident).
- **Backlog** = gecentraliseerde openstaande punten per project in
  `backlog/`. Eén plek om te kijken, niet verspreid over layers.
- **`library.yaml`** = manifest. Single source of truth over wat er
  bestaat, waar symlinks heen wijzen, en welke dependencies er zijn.
- **`setup.sh`** = leest de manifest, maakt symlinks, concateneert
  depends_on layers, genereert SKILLS-INDEX.md, installeert hooks.
  Geen dependencies.

## Mapstructuur

```
agent-library/
├── library.yaml                  # manifest (v2.0)
├── setup.sh                      # installer + index-generator
├── workflow.md                   # skill-volgorde per scenario
├── SKILLS-INDEX.md               # auto-generated door setup.sh
├── layers/
│   ├── global.md                 # werkstijl, kwaliteit, verificatie, taal
│   ├── repos-shared.md           # git/security conventies
│   ├── stacks/
│   │   ├── node-express.md       # Node.js + Express conventies
│   │   ├── supabase.md           # Supabase conventies
│   │   └── vercel-deploy.md      # Vercel deploy conventies
│   └── projects/
│       ├── _template.md          # template voor nieuwe projecten
│       └── whatsapp-bot.md       # ZendIQ-specifieke context
├── skills/
│   ├── plan-feature/SKILL.md
│   ├── systematic-debug/SKILL.md
│   ├── code-review/SKILL.md
│   ├── verify-before-done/SKILL.md
│   ├── commit-netjes/SKILL.md
│   ├── project-bootstrap/SKILL.md
│   ├── deploy-checklist/SKILL.md
│   ├── context-resume/SKILL.md
│   ├── research-spike/SKILL.md
│   └── incident-response/SKILL.md
├── hooks/
│   ├── session-start.sh          # context laden bij sessie-start
│   ├── pre-commit-reminder.sh    # review/verify herinnering
│   └── settings-template.json    # Claude Code hooks-configuratie
└── backlog/
    └── whatsapp-bot.md           # openstaande punten ZendIQ
```

## Installatie

```bash
git clone <deze-repo> ~/repos/agent-library
cd ~/repos/agent-library
bash setup.sh
```

Disaster recovery: bovenstaande twee commando's op een nieuwe machine
herstellen je volledige setup.

## Hoe depends_on werkt

Project-layers kunnen `depends_on` declareren in `library.yaml`:

```yaml
- name: whatsapp-bot
  source: layers/projects/whatsapp-bot.md
  target: ~/Whatsapp-bot/CLAUDE.md
  scope: "~/Whatsapp-bot/*"
  depends_on: [repos-shared, node-express, supabase, vercel-deploy]
```

`setup.sh` concateneert dan alle dependency-layers **vóór** de
project-layer in het target-bestand. Zo krijgt elk project automatisch
de conventies mee van zijn stack, zonder dat die in de project-layer
herhaald worden.

Stack-layers met `scope: "composable"` worden niet zelfstandig
gelinkt — ze bestaan alleen als dependency.

## Workflow

`workflow.md` beschrijft de skill-volgorde per scenario:

| Scenario | Volgorde |
|---|---|
| Nieuwe feature | plan-feature → code → code-review → verify-before-done → commit-netjes |
| Bugfix | systematic-debug → fix → verify-before-done → commit-netjes |
| Deploy | verify-before-done → deploy-checklist |
| Nieuw project | research-spike → project-bootstrap → plan-feature |
| Werk hervatten | context-resume → (lopende workflow) |
| Productie-incident | incident-response → systematic-debug → deploy-checklist |

## Hooks

Hooks zijn shell-scripts in `hooks/` die Claude Code automatisch
triggert. Na `setup.sh` staan de scripts klaar; de configuratie staat
in `hooks/settings-template.json`.

| Hook | Trigger | Wat het doet |
|---|---|---|
| `session-start.sh` | Begin van sessie | Toont branch, uncommitted changes, backlog items |
| `pre-commit-reminder.sh` | Bij git commit | Herinnering aan review/verify/commit-netjes checklist |

Om hooks te activeren: merge `hooks/settings-template.json` in
`~/.claude/settings.json`, of kopieer het als je nog geen
settings-bestand hebt.

## Backlog

Openstaande punten staan per project in `backlog/<projectnaam>.md`.
Project-layers verwijzen naar hun backlog-bestand. De `context-resume`
skill leest de backlog bij het hervatten van werk.

## Nieuwe skill toevoegen

1. Maak `skills/<naam>/SKILL.md`. Begin met YAML frontmatter:
   ```markdown
   ---
   name: <naam>
   description: Gebruik wanneer… — korte zin die triggert wanneer Claude
     de skill moet oppakken.
   ---

   # Skill: <naam>
   ...
   ```
2. Voeg een entry toe in `library.yaml` onder `skills:`.
3. Draai `bash setup.sh` — SKILLS-INDEX.md wordt automatisch bijgewerkt.
4. Commit.

## Nieuwe layer toevoegen

1. Schrijf het markdown-bestand in `layers/`.
2. Voeg een entry toe in `library.yaml` met `source`, `target`, `scope`.
3. Draai `bash setup.sh`.
4. Commit.

## Nieuwe stack-layer toevoegen

1. Maak `layers/stacks/<naam>.md` met tech-specifieke conventies.
2. Voeg in `library.yaml` toe met `scope: "composable"`.
3. Voeg de stack toe aan `depends_on` van relevante project-layers.
4. Draai `bash setup.sh`.

## Nieuw project opzetten

1. Kopieer `layers/projects/_template.md` naar
   `layers/projects/<naam>.md` en vul in.
2. Maak `backlog/<naam>.md` aan.
3. Voeg in `library.yaml` een entry toe met `depends_on` voor
   relevante stacks.
4. Draai `bash setup.sh`.
5. Of gebruik de `project-bootstrap` skill die dit allemaal begeleidt.

## Taalconventie

- Documentatie, layers, skills, communicatie: **Nederlands**
- Code, variabelen, commits, PR-titels: **Engels**
- Bij samenwerking met niet-Nederlandstaligen: alles Engels

## Windows

`ln -sfn` werkt alleen in Git Bash als developer mode aan staat
(Windows-instellingen → Voor ontwikkelaars → Developer Mode). Zonder
dat valt `setup.sh` terug op kopiëren — wijzigingen in de library
worden dan pas live na opnieuw `setup.sh` draaien.
