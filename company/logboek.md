# Logboek

Nieuwste bovenaan. Elke regel: probleem → hypothese → wijziging → resultaat → regel. Kop: `## <datum> | <Afdeling>:<kleur> | ...`

## 4 sep 2026 | Development:warn | Finance:info
probleem: AI-kosten waren onmeetbaar (usage werd weggegooid); elk los tekstbericht ging met 3,3k tokens systeemprompt naar Haiku; een losse Sonnet-4-call dubbelde met de classifier; een foto kostte bij twijfel twee calls; JSON werd met een regex uit de tekst gevist; alle cache_control-markers stonden onder het Haiku-minimum van 4096 tokens en deden stil niets.
hypothese: Meten plus een woordenlijst vóór de classifier, schema-gegarandeerde JSON en één foto-ingang maken de bot goedkoper én betrouwbaarder: van ~$0,40 naar ~$0,20 per actieve gebruiker per maand bij 100 gebruikers (E4).
wijziging: Branch feature/ai-cost-steps in de bot-repo, 14 commits door drie agents plus review: ai_call- en ai_parse_failed-events met tokens en telefoonnummer, AI-verbruik in het zondagdigest, keyword-laag (services/intent-keywords.js), Sonnet-4-call weg, structured outputs op alle extractie-calls, analyzeDocumentImage (bon, opbrengst, boete, anders), gesaneerde handelaar-voorbeelden uit de leer-lus. Code-review vond 15 punten (6 regressies), verwerkt in 6 fix-commits. Bewijs: npm test 1211 groen na merge van main (1 al-falende test: alerts, ontbrekende test-key); smoke tegen de echte API door Badr op 4 sep: classify, extract, naam en foto geven geldige JSON, 0 parse-fouten, $0,012 voor 4 calls. De lokale key in ~/Whatsapp-bot/.env bleek ongeldig (401).
resultaat: open: nog niet gedeployed; meten 1 okt (E4)
regel: Prompt-caching op Haiku 4.5 loont pas boven 4096 tokens én ±12 calls per 5 minuten per schema, want output_config.format geeft elk schema een eigen cache; eerst meten via ai_call-events, dan markers. En: agent-werk altijd door een review vóór de merge, zes van de vijftien punten waren regressies.

## 3 sep 2026 | Platform:warn | Klant:crit
probleem: Aanname "de instantie slaapt" verklaarde het uitblijven van het statusrapport, maar om 20:00 vuurden drie crons zestien minuten na het laatste bezoek: de zelf-ping houdt hem wakker.
hypothese: Het statusrapport wordt wel verstuurd maar geweigerd: vrije tekst buiten het WhatsApp-venster van 24 uur vereist een goedgekeurde template (Twilio 63016), en de code gebruikt nergens templates. Dat zou ook elk proactief bericht aan chauffeurs raken, dus E1.
wijziging: Geen; Twilio-API vanuit de repo-omgeving weigert (creds lokaal ongeldig). Test vastgezet: audit_log `daily-status` 4 sep 06:00Z (completed of failed met foutcode) en de Twilio-berichtenlog.
resultaat: 4 sep: 56 cron-runs in de nacht, geen gefaald; `daily-status` completed om 06:00Z en Badr ontving het rapport om 08:00. Beide hypotheses (slapen, templates) vervallen. Waarom het eerder uitbleef blijft onbekend, want vóór de fix schreef geen cron iets.
regel: Eén verklaring is geen bewijs. Twee symptomen met één oorzaak verklaren, pas na de eerste meting de tweede oorzaak schrappen.

## 3 sep 2026 | Leren:acc | Development:ok
probleem: De bedrijfsopzet bestond alleen als pagina; afdelingen, rituelen en skills waren nergens werkend.
hypothese: Afdelingen als markdown-bron, drie Product-skills en een gegenereerde pagina maken de lus uitvoerbaar zonder dubbele bronnen.
wijziging: `company/afdelingen/*.md`, `experimenten.md`, `nulmeting.md`, `logboek.md`, `besluiten.md`; `build-page.js` genereert de pagina; skills `zondag-triage`, `effectmeting`, `afdeling-update`; hook meldt het ritueel van de dag; dubbele skills teruggebracht tot huisregels; `scripts/metrics.js` in de bot (live via commit d16f202, CI groen).
resultaat: `test-setup.sh` groen (8 tests, incl. pagina-sync), drie skills zichtbaar in de skill-lijst, hook toont ritueel en verstreken meetdata. Eerste echte `zondag-triage`: zo 7 sep.
regel: Eén bron per feit. De pagina wordt gegenereerd, nooit met de hand bewerkt.

## 3 sep 2026 | Platform:crit
probleem: Nul `cron_run_*` rijen in productie sinds de monitoring op 11 april werd gebouwd. De health-check die elke twee uur stilgevallen jobs moet melden, had dus nooit iets om op te bouwen.
hypothese: Twee oorzaken naast elkaar: de audit-insert faalt stil (schema), en de Render-instantie slaapt zodat crons niet vuren.
wijziging: Oorzaak 1 bevestigd: `audit_log.phone_number` is NOT NULL, cron-events schreven null, `writeAuditEvent` slikte de fout. Fix met regressietest gedeployed 19:13 (CI-run 33782914859). Oorzaak 2 bevestigd door Badr: geen statusrapport om 08:00.
resultaat: Om 19:15 schreef `sumup-hint` de eerste `cron_run_completed` ooit in productie. Wekker voor het slapen uitgesteld tot de eerste betalende klant.
regel: Monitoring die zijn eigen schrijffouten inslikt is geen monitoring. Een audit-insert die faalt moet minstens één keer hard alarmeren.

## 3 sep 2026 | Product:acc
probleem: Het logboek bewees technische kwaliteit, niet of het product voor de chauffeur beter werd. Nulmeting gedaan: 11 bonnen ooit, laatste op 2 mei; 0 betalend; 0 nieuwe chauffeurs in 8 weken.
hypothese: Zonder gebruik ontbreekt de meetbasis voor elk experiment.
wijziging: Product-afdeling en verbeterlus toegevoegd; experimenten E0 tot E3 met succescriteria; twee Product-tickets in de ideeënbus (signalen-digest Top 5, automatische effectmeting).
resultaat: Badr bevestigde de productiedatabase en koos de acquisitielijn voor E0.
regel: Meet vóór je bouwt. De features van 2 en 3 september hadden ná een nulmeting gepland moeten worden, niet ervoor.

## 3 sep 2026 | Klant:ok | Finance:ok
probleem: Geen skills voor support en finance.
hypothese: De Anthropic knowledge-work-plugins dekken het meeste voor beide afdelingen.
wijziging: Marketplace toegevoegd; customer-support en finance geïnstalleerd (user-scope). Bewijs: `claude plugin list`.
resultaat: open: meten 17 sep (E3)
regel: open: volgt na meting

## 3 sep 2026 | Leren:ok
probleem: Onbekend of de eigen skillset toereikend was per afdeling.
hypothese: Voor generieke afdelingen bestaan betere skills dan de eigen; voor Nederlandse btw en Wwft bestaat niets.
wijziging: Vergelijking met Anthropic-plugins, superpowers, marketingskills, SRE-lijsten, finance- en GDPR-packs.
resultaat: Bevestigd: vier eigen skills dubbelden met superpowers en waren dunner; Nederlandse btw- en Wwft-skills bestaan nergens open.
regel: Eigen skills alleen waar niets bestaat. Anders installeren en er Nederlandse huisregels overheen leggen.

## 3 sep 2026 | Development:ok
probleem: Blanket 21% btw bij een onleesbare bon verborg fouten; prompt kende twaalf categorieën, validatie negen; chauffeur-specifieke kosten ontbraken.
hypothese: Eerlijke btw plus een gerichte vraag geeft meer correcte bonnen met minder correcties (E2).
wijziging: Categorie-tabel met 37 categorieën als enige bron; fallback weg; gerichte twijfelvraag "21, 9 of geen btw?". Review vond twee weggevallen regex-backslashes, gefixt met regressietest. Live 08:57. Bewijs: 1005 tests groen, CI-run 33735882896 groen, health 200.
resultaat: open: meten 17 sep en 1 okt, pas mogelijk bij gebruik
regel: Technisch: de Bash-tool eet backslashes; unicode-inhoud via Write, regexes na een edit nalezen. Productmatig: volgt na meting.

## 3 sep 2026 | Development:ok
probleem: Chauffeurs pinnen bij Shell of Q-Park zonder bon te sturen; dat geld blijft liggen.
hypothese: Een bankafschrift (MT940 of CAMT.053) omkeren naar "pin zonder bon" en dat als gerichte vraag stellen, levert bonnen terug.
wijziging: In de ideeënbus gezet met meetlat (teruggevonden bonnen per week, btw daarvan). Niet gebouwd.
resultaat: open: wacht op triage
regel: n.v.t.

## 2 sep 2026 | Klant:ok
probleem: De chauffeur voelt de waarde van ZendIQ twee keer per jaar: bij de aangifte en bij een boete.
hypothese: Geld per bon en per week zichtbaar maken geeft meer bonnen per actieve chauffeur en minder afhaken (E1).
wijziging: Btw-terug-regel achter elke bon-bevestiging; weekbericht dat toont wat ZendIQ deed, met kwartaalteller en nudge bij een stille week. Gemerged 3 sep. Bewijs: 969 tests groen op branch; eerste weekbericht ma 7 sep 08:00.
resultaat: open: meten 17 sep en 1 okt
regel: open: volgt na meting
