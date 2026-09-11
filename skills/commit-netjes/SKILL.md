---
name: commit-netjes
description: Gebruik bij elke `git commit` — één doel per commit, expliciete staging (geen `git add .`), conventional message gefocust op waarom. Ook vóór elke push naar een branch met een PR.
---

# Skill: commit-netjes

Gebruik dit bij elke commit. Een commit is een reviewbare eenheid, geen
dump van een werkdag.

## Wanneer

- Net voor je `git commit` draait.
- Wanneer de werkdirectory veel ongerelateerde wijzigingen heeft.
- Vóór elke push naar een branch waar al een PR bij hoort.

## Regels

### Scope
- Eén doel per commit. Als je "en" nodig hebt in de message, splits hem.
- Formatting-only en logica-wijzigingen niet mengen.
- Een bugfix is geen opruimactie — houd refactors apart.

### Staging
- Stage bestanden expliciet op naam: `git add path/to/file.js`.
- Vermijd `git add .` en `git add -A`. Die pakken per ongeluk secrets,
  logs, binaries, backup-bestanden.
- Check wat je staged hebt: `git diff --staged` voor commit.
- Commit pas na een testrun die zelf slaagt. Koppel de commit met `&&` aan
  het testcommando, niet aan een pipeline met `grep` of `tail`: dan telt de
  exitcode van dat laatste commando en gaat de commit door bij een falende test.

### Push naar een bestaande branch
- Check vóór elke push naar een branch met een PR of die PR nog open is:
  `gh pr view <branch> --json state --jq .state`.
- Staat hij op `MERGED`: maak een nieuwe branch vanaf de doelbranch
  (`git switch -c <nieuwe-branch> origin/<doel>`), cherry-pick je commits en
  open een nieuwe PR. Anders bereiken ze de doelbranch nooit.
- De push-gate-hook in de agent-library blokkeert zo'n push ook. Omzeil hem
  alleen bewust, met `MERGED_PR_OK=1` vóór het push-commando.

### Message

Conventional format:

```
type(scope): korte beschrijving in tegenwoordige tijd

Optioneel: wat er feitelijk verandert en waarom.
Focus op waarom — het wat staat in de diff.
```

**Types:** `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `security`

**Voorbeelden:**
- `fix(btw): circuit-breaker faalde bij onbekend btw-tarief`
- `feat(marketing): telegram publisher met UTM-injectie`
- `refactor(publishers): kanalen via registry in plaats van hardcoded`

### Wat NIET in de message

- Geen "WIP", "misc", "updates", "fixes" als enige beschrijving.
- Geen lijst van bestanden die je veranderde — dat staat in de diff.
- Geen uitleg van *wat* de code doet — dat hoort in de code.

## Rode vlaggen

- Diff bevat meerdere onderwerpen → splits met `git add -p` of aparte
  commits.
- `.env`, `credentials.json`, `*.key`, grote binaries in de staging →
  stop, check `.gitignore`.
- Commit-message eindigt met "…" of "etc" → je weet niet wat je commit.
- Je gebruikt `--no-verify` → er draaide een hook met reden, fix de
  oorzaak.
- Je amendt een commit die al gepusht is → maak een nieuwe commit.
- Je pusht vervolgcommits naar een branch zonder de PR-status te checken.
- De commit volgt op een testpipeline waarvan de exitcode niet van de test komt.
