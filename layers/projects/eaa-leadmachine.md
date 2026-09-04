# eaa-leadmachine — project context

Deze layer is alleen actief binnen `~/repos/eaa-leadmachine/*`.

## Wat is dit project

Leadmachine voor een EAA-webshopdienst (European Accessibility Act,
verplicht sinds juni 2025, ACM-toezicht). Scant Nederlandse webshops op
WCAG 2.1 A/AA-overtredingen, genereert per shop een rapport in mensentaal
en een mailconcept voor koude outreach. Doel van fase 1: meten of het
aanbod gesprekken oplevert — 50 shops scannen, mails handmatig keuren en
versturen, respons tellen.

## Stack

- Node.js zonder framework — pipeline via `src/run.js`
- puppeteer-core + lokale Chrome (`C:\Program Files\Google\Chrome\Application\chrome.exe`)
- axe-core voor de WCAG-scan (alleen violations, tags wcag2a/aa + wcag21a/aa)
- KvK API (Zoeken v2 + Vestigingsprofiel v1) voor micro-filter — key in `.env`

## Kritieke modules

| Module | Verantwoordelijkheid |
|---|---|
| `src/scan.js` | Scant homepage + productpagina + winkelwagen per shop, resume via bestaande JSON in `data/scans/` |
| `src/regels.js` | Vertaling axe-regel-ids naar Nederlands — gebruikt door rapport én mail |
| `src/report.js` | HTML-rapport per shop naar `reports/` |
| `src/mail.js` | Mailconcept per shop naar `mails/` |
| `src/leads.js` | KvK-verrijking seeds → `data/leads.json` |
| `src/seeds.json` | Shoplijst (handgecureerd + Thuiswinkel-scrape) |
| `src/inbox.js` | Classificeert inbox: echt antwoord / auto / bounce, plus contactpersoon uit handtekening |
| `src/contact.js` | Telefoon- en functie-extractie; nummers als +31 + 9 cijfers |
| `contacten.js` | Scrapet algemene telefoonnummers → `data/contacten.json` |
| `outreach.js` | Dagelijkse batch mails (limiet + pauze + blokkade uit `data/`) |
| `followup.js` | Rapport-PDF na echt antwoord, eenmalig per shop |
| `boekingscan.js` | Agenda-boeking → verse scan van die shop |
| `acties.js` | Haalt dashboard-acties op en past ze lokaal toe |
| `stats.js` | Bouwt `site/admin/data.js` (funnel, KPI's, shops, wachtrij) |
| `check.js` | Tweeuurlijkse runner: acties → followup → boeking → stats |
| `deploy.js` | SFTP-deploy van `site/` incl. `/admin` |

## Harde regels

1. Outreach loopt via `outreach.js` (expliciete instructie Badr, 4 sept
   2026): maximaal 20 shops per dag, zwaarste eerst, gespreid 90-180s,
   nooit dezelfde shop twee keer (`data/outreach-log.json` is de
   waarheid). Buiten dit script om nooit mailen zonder keuring, nooit de
   daglimiet verhogen zonder expliciete opdracht.
2. Rapporten en mails claimen nooit "compliant" of "volledige audit" —
   de scan vindt ~de helft; het woord "ondergrens" blijft staan.
3. Shops met `werkzamePersonen < 10` (micro, vrijgesteld van EAA) niet
   mailen zonder handmatige beoordeling.
4. Alleen publieke pagina's laden, nooit bestellen/inloggen/formulieren
   versturen bij gescande shops.

## Commando's

- Scan-pipeline (scan → rapport → mail): `node src/run.js`
- Alleen scannen (evt. met domeinen als filter): `node src/scan.js [domein ...]`
- Seeds aanvullen: `node seeds-scraper.js [aantal]` (Thuiswinkel-leden)
- Dagbatch handmatig: `node outreach.js` (`--dry` toont alleen)
- Losse mail: `node send.js <domein> <ontvanger>` / `--test <eigen adres>`
- Controle-run: `node check.js`; publiceren: `node stats.js --publiceer`
- Rescan van één shop: verwijder `data/scans/<domein>.json` en draai scan

## Geplande taken (Windows)

- `GeenDrempels outreach` — dagelijks 09:30, `outreach.js`
- `GeenDrempels followup` — elke 2 uur, `check.js`

## Dashboard

`https://www.geendrempels.nl/admin/` achter basic auth (user + wachtwoord
in `.env`: GD_ADMIN_USER/GD_ADMIN_PASS). Stuurknoppen schrijven via
`actie.php` naar `admin/acties.json`; `acties.js` haalt die op en schrijft
`data/funnel-handmatig.json`, `data/blokkade.json`, `data/instellingen.json`.
Wijzigingen zijn dus pas actief na de eerstvolgende check-run.

## Openstaande punten

Zie backlog/eaa-leadmachine.md.
