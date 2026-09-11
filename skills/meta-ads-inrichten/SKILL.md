---
name: meta-ads-inrichten
description: Gebruik bij het inrichten van Meta-advertenties (Facebook en Instagram) voor een bedrijf. Accounts en portfolio's in kaart, juridische naam uit het handelsregister, advertentieaccount, pixel achter cookie-akkoord, domein- en bedrijfsverificatie, eventcontrole in een echte browser.
---

# Skill: meta-ads-inrichten

Advertenties draaien pas goed als de basis klopt: de juiste login, het
juiste portfolio, de juridische naam en een pixel die meet wat telt. Een
fout in het begin kost later het meeste herstelwerk, want verificatie en
koppelingen bouwen erop voort.

## Wanneer

- "Ik wil Meta ads gaan draaien", "richt Facebook-advertenties in".
- Vóór de eerste campagne van een nieuw bedrijf of merk.
- Bij twijfel welk account of portfolio ergens bij hoort.

## Stappen

1. **Inventaris.** Welke persoonlijke Facebook-logins zijn er, welke
   bedrijfsportfolio's, en waar hangen pagina, Instagram, WhatsApp-account en
   advertentieaccounts? Bekijk dit via het Accountcentrum en de
   bedrijfsinstellingen. Noteer de ID's in de kennisbank, nooit wachtwoorden.
2. **Juridische identiteit.** Haal de statutaire naam en het adres uit het
   uittreksel van het handelsregister. De handelsnaam is niet de officiële
   naam; die gaat in het veld voor een alternatieve naam.
3. **Portfolio kiezen en invullen.** Werk in het portfolio waar pagina en
   Instagram in zitten. Vul de bedrijfsgegevens exact zoals op het
   uittreksel.
4. **Advertentieaccount.** Valuta en tijdzone van het land, gebruik voor het
   eigen bedrijf. Een prepaid saldo is meteen de bestedingsgrens. Start
   klein, bijvoorbeeld tien euro per dag gedurende twee weken, en optimaliseer
   eerst op klikken.
5. **Pixel.** Maak een gegevensset en koppel die aan het advertentieaccount.
   In de site: laad de pixel pas na cookie-akkoord, voeg de hosts van Meta
   toe aan de CSP, noem Meta in de cookiebanner en de privacyverklaring, en
   vuur een conversie-event op de belangrijkste knop.
6. **Domeinverificatie.** Zet de metatag van Meta in de head van de
   homepage, deploy, en klik daarna op "Domein verifiëren".
7. **Eventcontrole.** Een headless test bewijst alleen dat de pixel laadt.
   Aankomst bewijs je in een echte browser met een harde herlaadactie, via
   het netwerkverzoek naar Meta met status 200. Het eventoverzicht loopt
   vaak achter.
8. **Bedrijfsverificatie.** Start die in het Beveiligingscentrum. Kies de
   registermatch die Meta zelf vindt. De connectie bevestigt de gebruiker
   met een code per sms of telefoon naar het nummer uit het register.
9. **Beveiliging.** Tweestapsverificatie voor het portfolio op "Iedereen".

## Akkoord van de gebruiker nodig

Voorwaarden van Meta accepteren, betaalmethoden, codes invoeren,
identiteitsdocumenten uploaden en beveiligingsinstellingen wijzigen doet of
bevestigt de gebruiker zelf, per stap.

## Output

Een lijst met ID's van portfolio, pagina, advertentieaccount, pixel en
domein, de verificatiestatus, en het bewijs dat events aankomen.

## Rode vlaggen

- De handelsnaam als officiële bedrijfsnaam.
- Een pixel die laadt vóór het cookie-akkoord.
- "De pixel werkt" op basis van een headless test.
- Advertenties naar WhatsApp terwijl het WhatsApp-account in een ander
  portfolio zit dan de pagina.
