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
- [ ] Mailbox info@geendrempels.nl aanmaken in TransIP e-mailbeheer (Badr)

- [ ] KVK_API_KEY in `.env` zetten (Badr, niet via chat) en `node src/leads.js` draaien — code is nog ongetest tegen de echte API
- [ ] Micro-shops (<10 werkzame personen) uit de maillijst halen na KvK-run
- [ ] Mailconcepten in `mails/` handmatig keuren en versturen (klein beginnen: 10-15, respons meten)
- [ ] Contactadressen per shop opzoeken (nu nog geen e-mailadressen in de pipeline)
- [ ] Respons bijhouden: verstuurd / geopend gesprek / rapport gestuurd / afspraak

## Later (pas na bewijs uit fase 1)

- [ ] Checkout-stap scannen (nu alleen homepage/product/winkelwagen; checkout vereist items in mandje)
- [ ] Cookie-banners wegklikken vóór de scan zodat de echte pagina gescand wordt
- [ ] Handmatige-testchecklist (toetsenbord, screenreader) als vast onderdeel van het betaalde rapport
- [ ] Merknaam/afzender kiezen voor rapporten en mails (nu neutraal/Badr)
