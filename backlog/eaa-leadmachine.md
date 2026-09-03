# Backlog — eaa-leadmachine

## Fase 1: testronde (meten of het aanbod gesprekken oplevert)

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
