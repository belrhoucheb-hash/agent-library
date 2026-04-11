# Repos-shared — conventies voor alle code-repositories

Deze layer is actief in elke repository onder `~/repos/*`. Hij bevat
conventies die gelden ongeacht taal of framework.

## Git

- Werk op een feature-branch, niet direct op main.
- Eén doel per commit. Als de boodschap "and" bevat, splits de commit.
- Commit-messages in conventional style: `type(scope): beschrijving`.
  Types: feat, fix, refactor, test, docs, chore, security.
- Stage bestanden expliciet op naam. Vermijd `git add .` en `git add -A` —
  dat neemt per ongeluk secrets, logs en binaries mee.
- Nooit force-pushen naar main. Nooit hooks skippen met `--no-verify`
  zonder uitdrukkelijke reden.
- Amend alleen op commits die nog niet gepusht zijn. Daarna: nieuwe commit.

## Tests

- Als er een testsuite is, draai hem voor je commit. Niet "ik denk dat
  het werkt".
- Een falende test is informatie, geen obstakel. Repareer de oorzaak,
  niet de test.
- Nieuwe functionaliteit = nieuwe test waar redelijk. Nieuwe bugfix =
  regressietest die de bug vangt.

## Security

- Secrets (API keys, service keys, tokens) staan in `.env` of een
  secret store, nooit in code of commit-history.
- `.env` en soortgelijke bestanden staan in `.gitignore`.
- Bij het vinden van een gecommitte secret: markeer het, roteer de key,
  meld het — verwijder niet stilletjes.
- Valideer user input op het punt waar het binnenkomt, niet diep in de
  stack.

## Dependencies

- Geen package toevoegen zonder reden. Check of iets al in de repo zit.
- Lockfiles committen. Geen mix van npm en yarn of pnpm in één repo.
- Geen downgrades "om een probleem te omzeilen" zonder root-cause.

## Omgang met bestaande code

- Lees voor je schrijft. Volg de stijl die er al is, ook als je hem
  persoonlijk anders zou doen.
- Raak niets aan dat buiten de taak valt. Een bugfix is geen
  opruimactie.
- Bij onbekende bestanden of branches: eerst onderzoeken, niet deleten.
  Het kan werk-in-uitvoering zijn.
