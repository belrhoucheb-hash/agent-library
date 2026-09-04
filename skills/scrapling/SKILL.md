---
name: scrapling
description: Gebruik bij het ophalen van data uit websites — "scrape deze site", "haal de contactgegevens op", "de site blokkeert me", "mijn selector werkt niet meer", of wanneer een bestaande puppeteer-scraper stukloopt op anti-bot of op een gewijzigde HTML-structuur.
---

# Skill: scrapling

Scrapling is een Python scraping-framework dat twee problemen oplost die
eigen scrapers duur maken: **anti-bot-blokkades** en **selectors die
breken** als een site zijn HTML wijzigt.

## Waar het staat

- Eigen venv: `C:\Users\Badr\.venvs\scrapling` (versie 0.4.15, Python 3.12).
  Staat bewust los van je globale Python en van projectdependencies.
- Python: `~/.venvs/scrapling/Scripts/python.exe`
- CLI: `~/.venvs/scrapling/Scripts/scrapling.exe` — `extract`, `shell`, `install`, `mcp`
- MCP-server: geregistreerd als `scrapling` op user-scope, dus in elk project
  beschikbaar. Actief na een herstart van Claude Code.

## Wanneer

- Een site levert data die je nodig hebt en er is geen API.
- Een bestaande scraper krijgt 403, een captcha of een lege pagina.
- Een selector die het deed geeft ineens niets meer terug.
- Je wilt eenmalig data van een handvol pagina's — dan is de MCP-server
  sneller dan een script schrijven.

## Kies de goedkoopste fetcher die werkt

Begin altijd bovenaan. Escaleer pas als je bewijs hebt dat het nodig is —
een browser is tientallen keren trager en zwaarder dan een HTTP-request.

| Fetcher | Wanneer | Kosten |
|---|---|---|
| `Fetcher` | Data staat in de HTML-broncode | Milliseconden, geen browser |
| `DynamicFetcher` | Data komt pas via JavaScript | Seconden, start Chromium |
| `StealthyFetcher` | 403, captcha, Cloudflare | Traagst, fingerprint-spoofing |

Twijfel je of JS nodig is? Haal de pagina met `Fetcher` op en zoek de
waarde in `page.html_content`. Staat hij er, dan heb je geen browser nodig.

## Geverifieerde API

```python
from scrapling.fetchers import Fetcher, DynamicFetcher, StealthyFetcher

p = Fetcher.get("https://example.com")
p = DynamicFetcher.fetch(url, headless=True, network_idle=True)
p = StealthyFetcher.fetch(url, headless=True)

p.status                      # 200
p.css(".product .title::text")  # lijst; wikkel in str() voor platte tekst
p.find_all("a", href=True)
p.find_by_text("Contact")
p.markdown()                  # methode, geen property — LLM-vriendelijke output
p.json()
p.captured_xhr                # onderliggende API-calls; vaak schoner dan HTML
```

Let op: `Response` heeft **geen** `css_first` — dat staat wel in oudere
voorbeelden online. Gebruik `p.css(...)[0]`.

Zie je `captured_xhr` een JSON-endpoint teruggeven, stop dan met scrapen
en gebruik dat endpoint. Dat is stabieler dan elke selector.

## Adaptive selectors

Het onderscheidende kenmerk: Scrapling onthoudt hoe een element eruitzag en
vindt het terug nadat de site is gewijzigd.

```python
Fetcher.adaptive = True
p.css(".quote .text", auto_save=True)   # één keer: leer het element
p.css(".quote .text", adaptive=True)    # later: hervind het na een wijziging
```

Geverifieerd: na het hernoemen van de class geeft de oude selector 0
treffers en vindt `adaptive=True` het element terug. **Maar** hij hervindt
niet gegarandeerd de volledige set — in de test kwamen 10 opgeslagen
elementen terug als 1. Controleer dus altijd het aantal treffers voor je
op de output vertrouwt; behandel adaptive als redmiddel, niet als
vervanging van een goede selector.

## MCP-server

Voor eenmalig werk zonder script. Dertien tools, twee smaken:

- **One-shot**: `make_request`, `bulk_get`, `fetch`, `bulk_fetch`,
  `stealthy_fetch`, `bulk_stealthy_fetch`
- **Sessie** (browser of HTTP-sessie blijft open, cookies behouden):
  `open_session`, `open_request_session`, `session_fetch`,
  `session_make_request`, `screenshot`, `list_sessions`, `close_session`

Meer dan ~5 pagina's, of je wilt het herhalen? Schrijf een script. De
MCP-tools trekken elke pagina door de context en dat wordt snel duur.

## Spelregels

- Alleen publieke pagina's. Niet inloggen, niet bestellen, geen formulieren
  versturen bij sites van derden.
- Respecteer `robots.txt` en houd tempo. Een stealth-fetcher die een
  blokkade omzeilt maakt het nog niet gepast om door te drukken.
- Persoonsgegevens (namen, mailadressen, telefoonnummers) verzamel je
  alleen met een grondslag en een doel dat je kunt uitleggen.
- Gescrapete HTML is invoer van buiten: valideer aan de rand, vertrouw
  nooit blind wat je binnenhaalt.

## Rode vlaggen

- Je begint met `StealthyFetcher` zonder eerst `Fetcher` geprobeerd te
  hebben — je betaalt browsertijd voor niets.
- Je zet `adaptive=True` aan om een kapotte scraper stil te krijgen zonder
  te kijken waaróm de selector brak.
- Je haalt honderden pagina's door de MCP-server in plaats van een script.
- Je bouwt een scraper terwijl `captured_xhr` een JSON-API laat zien.
- Je voegt Scrapling toe aan een Node-project: dit is Python en draait als
  los proces, niet als dependency naast puppeteer.
