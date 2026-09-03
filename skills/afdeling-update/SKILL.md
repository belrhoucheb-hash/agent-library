---
name: afdeling-update
description: Gebruik na elk afgerond stuk Zendiq-werk (feature live, meting, besluit, skill) — schrijf de logboek-regel als probleem → hypothese → wijziging → resultaat → regel, werk de bronnen in company/ bij, genereer de pagina en publiceer op de bestaande URL.
---

# Skill: afdeling-update

De pagina "Zendiq Afdelingen" is een afgeleide van `company/*.md`. Werk
altijd de markdown bij en genereer; bewerk nooit de HTML.

## Wanneer

- Iets is live, gemeten, besloten of geleerd.
- Als afsluiting van `zondag-triage` en `effectmeting`.

## Stappen

1. **Logboek.** Voeg bovenaan in `company/logboek.md` een blok toe:
   `## <datum> | <Afdeling>:<kleur>` en de vijf regels `probleem:`,
   `hypothese:`, `wijziging:` (met bewijs: tests, CI-run, health, commando),
   `resultaat:` (of `open: meten <datum>` als nog niet gemeten), `regel:`
   (of `open: volgt na meting`). Kleuren: ok, warn, crit, info, own, acc.
2. **Bronnen.** Werk bij wat veranderde: statusrijen in
   `company/afdelingen/<afdeling>.md`, `experimenten.md`, `nulmeting.md`
   (alleen na een echte meting), `besluiten.md`.
3. **Bouwen.** `node company/build-page.js` in `~/repos/agent-library`.
   `node company/build-page.js --check` moet daarna "pagina in sync" zeggen.
4. **Publiceren.** Artifact-tool met het bestand
   `company/zendiq-afdelingen.html` én de bestaande `url`:
   `https://claude.ai/code/artifact/4377020a-e400-41b4-a43e-07a0a37d78ac`.
   Zonder `url` ontstaat een tweede artifact.
5. **Committen.** Eerst `git pull --ff-only` (gedeelde branch), dan expliciet
   stagen en `docs(company): <wat>` committen. Niet `git add .`.

## Output

Een logboek-regel met bewijs, een pagina die in sync is, één commit.

## Rode vlaggen

- HTML met de hand bewerkt.
- Publiceren zonder `url`.
- Een logboek-regel zonder bewijs, of een resultaat ingevuld zonder meting.
- Nulmeting aangepast zonder dat er gemeten is.
