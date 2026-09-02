# Darija-app (Yallah Zaza) — project context

Deze layer is alleen actief binnen `~/repos/darija-app/*`.

## Wat is dit project

Speelse web-app waarmee jonge kinderen (<6) Darija leren: wereldkaart →
de Dār → tik-en-hoor woorden → luisterspel met kameeltje Zaza. Prototype
live als Claude-artifact (link in `README.md`). Audio is Badrs eigen
ingesproken stem (31 aug 2026) — AI-stem is beoordeeld en afgekeurd.

## Stack

- Eén-bestands web-app: `yallah-zaza.html` (bron, met `/*__AUDIO__*/{}`
  marker) → `tools/inject_audio.py` → `yallah-zaza-audio.html` (build
  met 29 mp3's als data-URI's; dit bestand wordt gepubliceerd)
- `audio/*.mp3` — bewerkte clips; `audio_raw/*.webm` — ruwe opnames
- `tools/opname.html` + `opname_server.py` — lokale opnamestudio
  (localhost:8123) voor nieuwe opnames

## Harde regels

1. **Nooit** `yallah-zaza-audio.html` met de hand bewerken — dat is een
   gegenereerde build. Bewerk `yallah-zaza.html` en draai de injector.
2. `audio_raw/` bewaren — dat zijn de originele opnames van Badrs stem.
3. Geen AI-gegenereerde stem gebruiken (afgekeurd wegens uitspraak);
   nieuwe woorden gaan via de opnamestudio.

## Wat Claude hier fout doet

<!-- Twee-keer-fout-regel: zelfde fout twee keer → correctie hier, of
     een hook als hij zonder uitzondering moet gelden. -->

- <!-- Correctie -->

## Commando's

- Audio-build: `python tools/inject_audio.py` (draaien vanuit de map
  waar bron en `audio/` naast het script staan — zie README)
- Opnamestudio: `python tools/opname_server.py` → localhost:8123
- Publiceren: `yallah-zaza-audio.html` als artifact republishen

## Openstaande punten

- [ ] Fase 2: souk-wereld, TPR-beweegspel, praatpapegaai
