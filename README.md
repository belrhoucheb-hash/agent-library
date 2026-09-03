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
│   ├── verify-before-done/SKILL.md
│   ├── commit-netjes/SKILL.md
│   ├── project-bootstrap/SKILL.md
│   ├── deploy-checklist/SKILL.md
│   ├── context-resume/SKILL.md
│   ├── research-spike/SKILL.md
│   ├── incident-response/SKILL.md
│   ├── zondag-triage/SKILL.md    # Product: wekelijkse triage
│   ├── effectmeting/SKILL.md     # Product: meten tegen criterium
│   └── afdeling-update/SKILL.md  # Leren: logboek + pagina
├── hooks/
│   ├── session-start.sh          # context laden bij sessie-start
│   ├── pre-commit-reminder.sh    # review/verify herinnering
│   └── settings-template.json    # Claude Code hooks-configuratie
├── agents/
│   └── verifier.md               # onafhankelijke verificatie (handmatig deployen)
├── company/                      # bedrijfsopzet Zendiq: afdelingen, experimenten, logboek
│   ├── README.md                 # model en rituelen
│   ├── afdelingen/*.md           # één bestand per afdeling
│   └── build-page.js             # genereert zendiq-afdelingen.html
└── backlog/
    └── <project>.md              # openstaande punten + ideeënbus per project
```

## Company (bedrijfsopzet Zendiq)

Zendiq wordt gerund als bedrijf met negen afdelingen; `company/` is daarvan
de bron: doel, meetlat, ritme en skills per afdeling, lopende experimenten
met succescriterium, nulmeting en logboek. `node company/build-page.js`
genereert de pagina. Rituelen: `zondag-triage`, `effectmeting`,
`afdeling-update`. Zie `company/README.md`.

## Installatie (volledig automatisch)

```bash
git clone <deze-repo> ~/repos/agent-library
cd ~/repos/agent-library
bash setup.sh
```

Dat is alles. Geen handmatige stappen. `setup.sh` doet:

1. Linkt `global.md` + `repos-shared.md` → `~/.claude/CLAUDE.md` (overal actief)
2. Concateneert project-layers met hun stacks → `~/project/CLAUDE.md`
3. Linkt alle skills → `~/.claude/skills/`
4. Genereert `SKILLS-INDEX.md`
5. Installeert hooks in `~/.claude/settings.json` (met backup)

Disaster recovery: bovenstaande twee commando's op een nieuwe machine
herstellen je volledige setup.

## Dekking: wat krijgt elk project?

| Project type | Wat Claude laadt |
|---|---|
| **Elk project, overal** | global + repos-shared (via `~/.claude/CLAUDE.md`) |
| **Project met eigen layer** | global + repos-shared + stacks + project-specifiek |
| **Project zonder layer** | global + repos-shared (git, tests, security) |

Je hoeft niet voor elk project een layer aan te maken. De basis
(werkstijl, git-conventies, security) werkt altijd. Een project-layer
voeg je alleen toe als er project-specifieke regels zijn (harde
constraints, stack-keuzes, kritieke modules).

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
triggert. `setup.sh` installeert ze automatisch in
`~/.claude/settings.json` (met backup van een bestaand bestand).

| Hook | Trigger | Wat het doet |
|---|---|---|
| `session-start.sh` | Begin van sessie | Toont branch, uncommitted changes, backlog items |
| `pre-commit-reminder.sh` | Bij git commit | Herinnering aan review/verify/commit-netjes checklist |

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
2. Voeg een entry toe in `library.yaml` onder `skills:` (alleen `name`,
   `description`, `source` — target/scope/type worden automatisch afgeleid).
3. Draai `bash setup.sh` — SKILLS-INDEX.md wordt automatisch bijgewerkt.
4. Commit (inclusief de gegenereerde SKILLS-INDEX.md).

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
