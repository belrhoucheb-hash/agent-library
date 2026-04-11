---
name: commit-netjes
description: Gebruik bij elke `git commit` — één doel per commit, expliciete staging (geen `git add .`), conventional message gefocust op waarom.
---

# Skill: commit-netjes

Gebruik dit bij elke commit. Een commit is een reviewbare eenheid, geen
dump van een werkdag.

## Wanneer

- Net voor je `git commit` draait.
- Wanneer de werkdirectory veel ongerelateerde wijzigingen heeft.

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
