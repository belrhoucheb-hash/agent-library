# Backlog — driver-acquisition (Zendiq acquisitielijn, experiment E0)

Doel: tien chauffeurs die vier weken op rij minstens één bon per week
sturen, vóór 1 oktober 2026. Zie `company/experimenten.md` (E0) en
`company/afdelingen/05-groei.md` (regel over opt-in).

## Prioriteit

- [ ] **Groei — plan acquisitielijn** (3 sep 2026). Doelgroep eerst fleet
  owners (bv/vof, SBI 49.32): zakelijke e-mail met opt-out en telefoon zijn
  toegestaan; zzp-eenmanszaken alleen via kanalen met toestemming (partners,
  referral, standplaatsen, ads). KvK non-mailing-indicator respecteren.
  Meetlat: plan met succescriterium goedgekeurd door Badr.
- [ ] **Development — KvK-prospectlijst** hergebruikt de KvK-module uit
  `~/repos/eaa-leadmachine/src/leads.js` (Zoeken v2 + Vestigingsprofiel).
  Filter: SBI 49.32, rechtsvorm bv/vof, NMI uit. Meetlat: lijst van ≥ 200
  fleet owners met website.
- [ ] **Development — outreach-tabellen in Supabase**: prospects,
  outreach_log, pipeline_runs (eigen tabellen, zelfde project). Meetlat:
  elke mail en elk antwoord herleidbaar.
- [ ] **Groei — 20 persoonlijke mails per dag** vanuit een apart subdomein
  (SPF, DKIM, DMARC), één opvolging na vijf dagen, antwoord landt als
  WhatsApp-onboarding in de bot. Meetlat: antwoordpercentage en gestarte
  onboardings per week.
- [ ] **Platform — dagelijkse run 09:00 via GitHub Actions** (niet op de
  slapende Render-instantie). Meetlat: run per dag zichtbaar in
  pipeline_runs.
- [ ] **Badr** — KvK-API-account, subdomein in TransIP, afzender kiezen, de
  eerste drie tot vijf chauffeurs uit eigen netwerk vragen om vanaf maandag
  bonnen te sturen.

## Ideeën / later

- [ ] Referral-flow vanuit actieve chauffeurs als tweede kanaal voor zzp'ers.
- [ ] Partners: verhuurbedrijven en taxicentrales als introductiekanaal.
