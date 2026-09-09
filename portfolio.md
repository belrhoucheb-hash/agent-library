# Portfolio — waar de tijd heen gaat

Peildatum 9 sep 2026. Bron: sessies (history.jsonl sinds 1 jul),
commits per repo (30 dagen), memory. Bijwerken bij elke zondag-triage.

## Kernbevinding

- 14 projecten, 8 actief. Te veel voor één persoon naast elkaar.
- 75% van alle prompts (810 van 1078) draait vanuit de home-map: geen
  project-layer, alle projecten door elkaar in één sessie. Dat is de
  grootste token-lekkage: elke beurt leest de hele geschiedenis opnieuw.
- Zendiq heeft 17 open worktrees. Meer dan 3 tegelijk = verlies van overzicht.

## Actief — in prioriteitsvolgorde

| # | Project | Map | Signaal 30 dagen | Waarom deze plek |
|---|---------|-----|------------------|------------------|
| 1 | Zendiq (Whatsapp-bot) | `~/Whatsapp-bot` | 232 commits, 278 prompts | Live business, omzet, klanten. |
| 2 | DLX Mobility | `~/repos/motorverhuur` | 49 commits, 23 prompts | Live site, MVP-platform in aanbouw. |
| 3 | EAA-leadmachine | `~/repos/eaa-leadmachine` | 96 commits, 30 prompts | Leadgeneratie voor betaalde dienst. |
| 4 | By Amina's Honing | `~/repos/honey-shop` (Shopify) | 39 prompts | Live shop, ads-plan loopt. |
| 5 | SMEULWERK koffieshop | `~/repos/koffieshop` | 5 commits, 13 prompts | Prototype af; wacht op Badr (theme, BOIP). |
| 6 | Yallah Zaza (darija-app) | `~/repos/darija-app` | 8 prompts, geen git | Creatief; opnamebatch wacht in studio. |
| 7 | QD Chauffeur | `~/repos/qdchauffeur` | 6 commits | Live 9 sep. Alleen onderhoud. |
| 8 | Maison Laméya agenda | `~/Desktop/DevBadr/agenda-wimperlash` | 4 commits | Live 3 sep. DNS/cert checken, verder onderhoud. |

Focus-advies: 1 t/m 3 krijgen werktijd. 4 t/m 8 alleen op concrete vraag.

## Geparkeerd — geen sessies of commits sinds mei

- OrderFlow Suite (`~/Desktop/DevBadr/orderflow-suite`, laatste commit 20 mei)
- Dashboard-AI (laatste commit 11 mei)
- Dayn / Addayn (on hold sinds april)
- driver-acquisition (april; 5 backlog-items horen bij Zendiq Groei)
- driveadmin-bot, sales, honey-theme, miel-theme (klaar of stil)

Geparkeerd = niet openen in een sessie, niet in de backlog-teller.

## Regels die hieruit volgen

1. Sessie starten in de projectmap (`p <naam>` in PowerShell), niet in `~`.
2. Eén project per sessie. Wisselen = `/clear`.
3. Zendiq-worktrees terugbrengen naar maximaal 3 open.
