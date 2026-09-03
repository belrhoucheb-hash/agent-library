# Product
strip: crit | geen gebruik sinds mei
meta: de verbeterlus; nulmeting bevestigd
lead: true

## Doel
ZendIQ wordt iedere week aantoonbaar makkelijker, betrouwbaarder of waardevoller voor chauffeurs.

## Meetlat
Activatie (eerste bon binnen 48 uur), tijd tot eerste waarde, handmatige correcties, supportvragen per actieve klant, retentie en churn, gebruik van kernfuncties.

## Ritme
`dagelijks` signalen verzamelen · `zo` verbetertriage · `max 2` experimenten per week · `na 7, 14, 30 dagen` effectmeting

## Regel
Geen feature is klaar na deploy. Hij is klaar nadat gemeten is of hij het gewenste resultaat heeft opgeleverd.

## Lus
- Klantgedrag | chauffeur | bonnen, vragen, afhaken
- Data | platform | receipts, corrections, exceptions, audit_log, helpdesk
- ! AI-analyse | product | Top 5 problemen per week: gepland
- Verbeteridee | ideeënbus | backlog, zondag-triage
- Prioriteit | product | impact × gebruikers × zekerheid / inspanning
- Development | development | plan met succescriterium
- Test | development | suite, review, verifier
- Productie | platform | CI, deploy-gate, health
- ! Effectmeting | product | 7/14/30 dagen: skill `effectmeting`
- Leren | leren | regel in memory, skill of test

## Bevinding
**Eerste bevinding van de lus, 3 sep.** Badr bevestigde dat dit de productiedatabase is. Dus: geen bon sinds 2 mei, geen betalende chauffeur, niemand die het product gebruikt. Zonder gebruik zijn er geen signalen, en zonder signalen draait de lus leeg. Besluit: E0 via een acquisitielijn. Tweede bevinding: de cron-monitoring was sinds 11 april blind, zie Platform.

## Skills
| Skill | Detail | Bron | Status | Beoordelen |
|---|---|---|---|---|
| zondag-triage | signalen, ranglijst, max twee experimenten met succescriterium | agent-library | own: eigen | zondag |
| effectmeting | na de meetdatum: behouden, terugdraaien of langer meten | agent-library | own: eigen | per experiment |
| scripts/metrics.js | kerncijfers als totalen, basis voor nulmeting en effectmeting | Whatsapp-bot | own: eigen code | per meting |
