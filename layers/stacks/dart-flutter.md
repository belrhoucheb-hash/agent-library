# Dart + Flutter — stack conventies

Deze layer is actief voor projecten die Dart/Flutter gebruiken.

## Structuur

- Entrypoint is `lib/main.dart`.
- Feature-based mapstructuur: `lib/features/<feature>/` met eigen
  models, screens, widgets, en services.
- Gedeelde code in `lib/core/` (theme, routing, constants, utils).
- Geen business logic in widgets — gebruik providers, blocs, of
  riverpod.

## State management

- Kies één state management aanpak per project en houd je eraan.
  Niet mixen (geen Provider + BLoC + Riverpod in dezelfde app).
- State hoort niet in widgets. Widgets bouwen UI, providers/blocs
  beheren state.

## Dependencies

- `pubspec.yaml` is de single source of truth.
- `pubspec.lock` committen.
- Minimale packages — check of Flutter/Dart standaard APIs het
  al kunnen.
- Geen deprecated packages. Check pub.dev score en last published.

## Platform & build

- Test op zowel Android als iOS als het project beide target.
- `flutter analyze` moet schoon zijn voor commit.
- `flutter test` draaien voor commit.
- Build-specifieke config (signing, flavors) in platform-mappen,
  niet in Dart-code.

## Assets & lokalisatie

- Assets in `assets/` map, geregistreerd in `pubspec.yaml`.
- Geen hardcoded strings in widgets als het project meertalig is.

## Veelgemaakte fouten

- `setState()` in een widget dat een provider zou moeten gebruiken.
- Zware compute in `build()` — gebruik `const` constructors en
  memoize waar mogelijk.
- Geen `dispose()` op controllers en streams — memory leaks.
- API keys in Dart-code — gebruik `--dart-define` of `.env` via
  `flutter_dotenv`.
