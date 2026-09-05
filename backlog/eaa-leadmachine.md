# Backlog — eaa-leadmachine

## Status 3 sept 2026

Scanronde af: 58 van 60 shops gescand (bristol.nl en devrijbuiter.nl
hangen op bot-wering — losgelaten), 58 rapporten, 56 mailconcepten.
Merknaam gekozen: GeenDrempels; landingspagina staat in `site/index.html`
(axe-schoon, geverifieerd). Domein geendrempels.nl was vrij op 3 sept.

## Fase 1: testronde (meten of het aanbod gesprekken oplevert)

- [x] geendrempels.nl geregistreerd + webhosting (pakket "geends") — 4 sept
- [x] Landingspagina live op https://www.geendrempels.nl (SFTP-deploy via
      SSH-key geendrempels_deploy, `node deploy.js`) — 4 sept, live axe 0
- [x] Mailbox info@geendrempels.nl actief; versturen via send.js/outreach.js werkt — 4 sept
- [x] Geplande taak "GeenDrempels outreach" dagelijks 09:30 — 4 sept
- [x] Admin-dashboard live op /admin met basic auth (user badr, wachtwoord in .env) — 4 sept
- [x] SEO on-page: OG + JSON-LD + sitemap + robots live — 4 sept
- [x] Seeds aanvullen kan nu doorlopend: `node kanalen.js` zoekt via Hermes
      per kanaal (keurmerk, reviews, ranglijst, niche, marktplaats) en
      verifieert elk domein voor het een seed wordt — 5 sept
- [ ] Na elke kanalen-run: `node src/run.js` draaien zodat de nieuwe shops
      gescand worden en de wachtrij weer vult
- [ ] Besluiten wat te doen met de niet-webshops (bank, telecom, vervoer,
      reizen, media) in `data/kanalen/kandidaten.json`: eigen mailtekst
      schrijven of laten liggen. Ze vallen wel onder de EAA, maar de
      huidige mail gaat over productpagina en winkelwagen.
- [ ] Replies op info@ dagelijks checken (webmail) + geen-interesse-reacties op een blokkadelijst
- [ ] Google-account voor info@ + profielfoto (logo-avatar.png) + agenda-afsprakenpagina (Badr)
- [ ] ACM-informatiegesprek aanvragen (concept-mail door Claude, verzenden Badr)

- [x] KvK-verrijking werkt (`node kvk.js`), 138 van 167 bedrijven gevonden — 5 sept
- [x] Micro-filter op KvK-personeel losgelaten: veld is onbetrouwbaar (60%
      staat op 1-9, 15% op nul, ook grote webshops). Telt nu alleen
      positief mee in de doelgroepscore.
- [ ] Mailconcepten in `mails/` handmatig keuren en versturen (klein beginnen: 10-15, respons meten)
- [ ] Contactadressen per shop opzoeken (nu nog geen e-mailadressen in de pipeline)
- [ ] Respons bijhouden: verstuurd / geopend gesprek / rapport gestuurd / afspraak

## Later (pas na bewijs uit fase 1)

- [ ] Checkout-stap scannen (nu alleen homepage/product/winkelwagen; checkout vereist items in mandje)
- [ ] Cookie-banners wegklikken vóór de scan zodat de echte pagina gescand wordt
- [ ] Handmatige-testchecklist (toetsenbord, screenreader) als vast onderdeel van het betaalde rapport
- [ ] Merknaam/afzender kiezen voor rapporten en mails (nu neutraal/Badr)
