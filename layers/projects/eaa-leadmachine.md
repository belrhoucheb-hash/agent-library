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
| `src/seeds.json` | Handmatig gecureerde lijst middelgrote NL-webshops |

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

- Alles: `node src/run.js`
- Alleen scannen (evt. met domeinen als filter): `node src/scan.js [domein ...]`
- KvK-verrijking: `node src/leads.js`
- Rescan van één shop: verwijder `data/scans/<domein>.json` en draai scan

## Openstaande punten

Zie backlog/eaa-leadmachine.md.
