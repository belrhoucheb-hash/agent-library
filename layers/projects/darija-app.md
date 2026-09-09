# Darija-app (Yallah Zaza) — project context

Deze layer is alleen actief binnen `~/repos/darija-app/*`.

## Wat is dit project

Speelse web-app waarmee jonge kinderen (<6) Darija leren: wereldkaart →
drie werelden (Dār: tik-en-hoor + luisterspel; Sūq: koopspel-ritueel;
Ḥdiqa: dieren + TPR-beweegspel). Mascotte "Zaza" is een Marokkaans kindje
in djellaba met **stip-ogen** (aniconisme-voorkeur — geen uitgewerkte
gezichten, geldt voor alle figuren). Prototype live als Claude-artifact
(link in `README.md`). Audio is Badrs eigen ingesproken stem — AI-stem is
beoordeeld en afgekeurd.

## Stack

- Eén-bestands web-app: `yallah-zaza.html` (bron, met `/*__AUDIO__*/{}`
  marker) → `tools/inject_audio.py` → `yallah-zaza-audio.html` (build
  met alle mp3's als data-URI's; dit bestand wordt gepubliceerd)
- Deep-links: `#dar` / `#suq` / `#hdiqa`; voortgang in localStorage ('yz')
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

- Audio-build: `python tools/inject_audio.py` — leest `audio_app/` (warm-lage
  stem) als die bestaat, anders `audio/`. Nieuwe opname? Eerst verwerken naar
  `audio/`, dan `ffmpeg -af rubberband=pitch=0.90` naar `audio_app/`.
- Opnamestudio: `python tools/opname_server.py` → localhost:8123
- Publiceren: `yallah-zaza-audio.html` als artifact republishen

## Openstaande punten

- [x] Fase 2: souk-wereld met koopspel (7 sep, clips ingesproken)
- [x] Fase 3: ḥdiqa-wereld met TPR-beweegspel (7 sep)
- [x] Audio compleet: 86 clips eigen stem, warm-laag toegepast (8 sep)
- [ ] Fase 4-kandidaten: l-bḥar, praatpapegaai, liedjes

## Vault (Obsidian)

Kennisbank: `~/Obsidian/yallah-zaza`. Bij sessiestart: lees `00 Start.md` en de
nieuwste notitie in `Sessies/` — niet de hele vault. Bij sessie-einde:
schrijf `Sessies/<datum>.md` volgens `Templates/Sessie.md` (max 15
regels: gedaan, stand, volgende stap, open vragen). Besluiten in
`Besluiten.md`, key-locaties in `Keys.md`, open punten in
`Backlog/darija-app.md` (dat is `agent-library/backlog`, live gekoppeld).
