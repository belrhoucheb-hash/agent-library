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
| `src/seeds.json` | Shoplijst (handgecureerd + Thuiswinkel-scrape + kanalen) |
| `kanalen.js` | Nieuwe leads via de Hermes-agent, kanaal voor kanaal; verifieert elk domein voor het een seed wordt |
| `linkedin.js` | Importeert Apify-dumps van LinkedIn Company Search; alleen hoofdkantoor NL, verifieert domein en winkelsignaal; `--keur` na de scan (bron linkedin en ads) |
| `advertenties.js` | Importeert Google-adverteerders (Apify google-search-scraper op `src/zoekwoorden.json`); `data/adverteerders.json` telt 12 punten in de doelgroepscore |
| `lusha.js` | Contactpersoon per shop via de Lusha-API naar `data/adressen.json` (proef contactpersoon); vereist `LUSHA_API_KEY` |
| `src/inbox.js` | Classificeert inbox: echt antwoord / auto / bounce, plus contactpersoon uit handtekening |
| `src/verzonden-check.js` | Leest de Verzonden-map (IMAP) en beslist of een shop de eerste mail al kreeg |
| `src/contact.js` | Telefoon- en functie-extractie; nummers als +31 + 9 cijfers |
| `contacten.js` | Scrapet algemene telefoonnummers → `data/contacten.json` |
| `outreach.js` | Dagelijkse batch mails (limiet + pauze + blokkade uit `data/`) |
| `followup.js` | Rapport-PDF na echt antwoord, eenmalig per shop |
| `boekingscan.js` | Agenda-boeking → verse scan van die shop |
| `acties.js` | Haalt dashboard-acties op en past ze lokaal toe |
| `notities.js` | Mailadres in een dashboardnotitie → rapport naar die persoon, na een nacht, binnen kantooruren, één keer per adres (`data/notitie-log.json`) |
| `stats.js` | Bouwt `site/admin/data.js` (vandaag-lijsten, KPI's, shops, wachtrij) |
| `check.js` | Tweeuurlijkse runner: outreach → opvolg → acties → notities → followup → boeking → stats |
| `deploy.js` | SFTP-deploy van `site/` incl. `/admin` |
| `antwoord.js` | Handgeschreven reply in bestaand draadje |
| `personen.js` | Zakelijke ingang zoeken in eigen publicaties (robots.txt-proof) |
| `BEZWAREN.md` | Geverifieerde antwoorden op klantbezwaren |

## Harde regels

1. Outreach loopt via `outreach.js` (expliciete instructie Badr, 4 sept
   2026): maximaal 100 shops per dag (op zijn verzoek verhoogd: 20 -> 45 op
   7 sept, 45 -> 100 op 8 sept 2026), zwaarste eerst, gespreid 90-180s,
   nooit dezelfde shop twee keer (`data/outreach-log.json` is de
   waarheid). Buiten dit script om nooit mailen zonder keuring, nooit de
   daglimiet verhogen zonder expliciete opdracht.
2. Rapporten en mails claimen nooit "compliant" of "volledige audit" —
   de scan vindt ~de helft; het woord "ondergrens" blijft staan.
2b. Nooit een technische bewering doen die de klant kan weerleggen: eerst
   nameten, dan schrijven. Antwoorden op bekende bezwaren (PageSpeed-score,
   webbouwer, "te klein", "nog nooit beboet") staan in `BEZWAREN.md`.
   Elke pagina wordt op desktop én mobiel gemeten; bij de mobiele meting
   moet de user-agent mee wisselen, anders meet je een hybride die niet
   bestaat.
3. Shops met `werkzamePersonen < 10` (micro, vrijgesteld van EAA) niet
   mailen zonder handmatige beoordeling.
4. Alleen publieke pagina's laden, nooit bestellen/inloggen/formulieren
   versturen bij gescande shops.
5. Hermes-opdrachten blijven klein: één kanaal, één variant, maximaal ~12
   bedrijven per aanroep. Het gratis model (`upstage/solar-pro4:free`) kapt
   bij een brede opdracht zijn tool-call af en blijft in retries hangen.
   Wat Hermes noemt is een vermoeden, geen lead: `kanalen.js` verifieert
   elk domein zelf voordat het in `seeds.json` komt.
6. Leads met `sector: 'dienst'` (bank, telecom, vervoer, reizen, media)
   krijgen niet de webshop-mail — die tekst gaat over productpagina en
   winkelwagen. Ze wachten in `data/kanalen/kandidaten.json` tot er eigen
   tekst is; `--alles` zet ze pas in de wachtrij als dat besloten is.

## Commando's

- Scan-pipeline (scan → rapport → mail): `node src/run.js`
- Alleen scannen (evt. met domeinen als filter): `node src/scan.js [domein ...]`
- Seeds aanvullen: `node seeds-scraper.js [aantal]` (Thuiswinkel-leden)
- Leads uit meer kanalen: `node kanalen.js` (`--lijst`, `--kanaal <id>`,
  `--rondes n`, `--dry`, `--alles`)
- Leads uit LinkedIn: `node linkedin.js <apify-dump.json> [...]` (`--dry`,
  `--alles`); dumps komen uit de Apify-actor `harvestapi/linkedin-company-search`.
  Na de scan `node linkedin.js --keur`: zonder productpagina of winkelwagen
  terug naar de wachtlijst, KvK-micro's in de blokkade tot beoordeling
- Adverteerders: Apify-actor `apify/google-search-scraper` (NL, alleen advertenties)
  op `src/zoekwoorden.json`, dan `node advertenties.js <dump.json>` (`--dry`, `--alles`)
- Contactpersoon (proef, `data/experimenten/contactpersoon.json`): `node lusha.js --groep lusha`
  (`--dry` zoekt zonder credits); `data/adressen.json` met `naam` geeft "Beste {voornaam}" in `src/mail.js`
- Dagbatch handmatig: `node outreach.js` (`--dry` toont alleen en raakt niets aan)
- Notitie-opvolging: `node notities.js --dry` toont welke notities een adres
  bevatten en wanneer de mail gaat
- Dubbelcheck toetsen: `node test/delta.js`; overige toetsen: `node test/linkedin.js`,
  `node test/notities.js`, `node test/advertenties.js`
- Losse mail: `node send.js <domein> <ontvanger>` / `--test <eigen adres>`
- Controle-run: `node check.js`; publiceren: `node stats.js --publiceer`
- Rescan van één shop: verwijder `data/scans/<domein>.json` en draai scan

## Geplande taken (Windows)

Eén taak: `GeenDrempels followup` draait `check.js` elke 2 uur (start
11:34). Die runner doet outreach → opvolg → acties → notities → followup →
boekingscan → stats. De losse dagelijkse outreach-taak is op 6 sept verwijderd: twee
taken die dezelfde batch startten leverden dubbele mails op.

Let op twee valkuilen die we hier tegenkwamen:
- Windows zet standaard `DisallowStartIfOnBatteries`; de taak sloeg
  daardoor uren over. Staat nu uit, net als `StopIfGoingOnBatteries`,
  met `StartWhenAvailable` aan zodat gemiste runs worden ingehaald.
- Alle scripts nemen een slot via `src/slot.js` (atomair, `flag: 'wx'`)
  en schrijven logs regel voor regel opnieuw ingelezen weg. Kijken-en-
  dan-schrijven en een in-geheugen logkopie waren precies de twee fouten
  achter de dubbele verzending van 6 sept.
- Bovenop het logboek controleert `outreach.js` de Verzonden-map zelf.
  Die twee bronnen dekken elkaars gat: het logboek kan overschreven
  raken, en de map begint pas op 6 sept (daarvoor werden geen kopieën
  bewaard). Is de mailbox onleesbaar, dan breekt de ronde af in plaats
  van door te gaan op halve informatie. Toets: `node test/delta.js`.

## Dashboard

`https://www.geendrempels.nl/admin/` achter basic auth (user + wachtwoord
in `.env`: GD_ADMIN_USER/GD_ADMIN_PASS). Stuurknoppen schrijven via
`actie.php` naar `admin/acties.json`; `acties.js` haalt die op en schrijft
`data/funnel-handmatig.json`, `data/blokkade.json`, `data/instellingen.json`.
Wijzigingen zijn dus pas actief na de eerstvolgende check-run.

## Openstaande punten

Zie backlog/eaa-leadmachine.md.
