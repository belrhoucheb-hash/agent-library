# Logboek

Nieuwste bovenaan. Elke regel: probleem → hypothese → wijziging → resultaat → regel. Kop: `## <datum> | <Afdeling>:<kleur> | ...`

## 4 sep 2026 | Klant:ok | Compliance:ok
probleem: Na een onleesbare foto hing de chauffeur af van een medewerker die de alerts-tab opent, en de verwerkersovereenkomst had dertien onbevestigde feiten over subverwerkers.
hypothese: Laat de chauffeur de bon zelf typen of inspreken en koppel die binnen twee uur aan de bewaarde foto, dan hoeft niemand op de admin te letten; en de feiten over subverwerkers zijn uit openbare bronnen te halen zonder jurist.
wijziging: PR #23: attachStoredImageToReceipt, findSelfResolvableAlert (jongste open ocr_failed met foto, hooguit 2 uur), koppeling na tekst- en spraakbon met audit-event actor user, regel "Gekoppeld aan je foto van zojuist" met alleen het bestaande commando *verwijder*. PR #22: twaalf van de dertien [controleren]-punten ingevuld (Supabase in AWS Londen via de IP-reeksen, DPF-certificeringen van Twilio, Meta, Anthropic, OpenAI, Supabase en Sentry, SCC's bij Render, geen training op API-data, Wwft vijf jaar); alleen de Render-regio staat open. Plus scripts/submit-whatsapp-templates.js dat de vier templates via de Content API indient. Bewijs: 1302 tests groen na merge van main; CI-run 33854296527 groen (PR #22); CI-run 33857253168 voor PR #23; verwerkersovereenkomst 200 met de nieuwe feiten.
resultaat: open: meten 1 okt (E6, criterium aangescherpt: ≥ 50% zelf opgelost binnen 2 uur). Templates nog niet ingediend: de Twilio-token lokaal is ongeldig en de browser-extensie rendert niets.
regel: Wie wacht op een mens, wacht te lang bij een bedrijf van één mens: geef de gebruiker eerst een weg om het zelf af te maken, en laat de mens het vangnet zijn. En: feiten over leveranciers staan in hun DPF-verklaring, DPA en IP-reeksen; alleen de eigen accountinstellingen (regio) vragen een login.

## 4 sep 2026 | Platform:ok | Klant:ok | Compliance:warn
probleem: Drie gaten uit de livegang-analyse: (1) buiten het 24-uursvenster van Meta weigert Twilio vrije tekst (fout 63016) en de code kende geen templates, dus cron-berichten aan stille chauffeurs vielen weg zonder spoor; (2) bij een OCR-fout werd de foto weggegooid en kreeg de chauffeur alleen "kon het bonnetje niet lezen"; (3) er was geen verwerkersovereenkomst voor fleet owners (AVG art. 28).
hypothese: Template plus parkeren tot het volgende inkomende bericht levert elk cron-bericht af; foto bewaren plus invullen door een medewerker geeft nul verloren bonnen; een pagina met aanvaarding bij het fleet-account volstaat als overeenkomst (E5 t/m E7).
wijziging: PR #21 (drie commits, elk één gat) plus merge met de ai-cost-PR van dezelfde ochtend: services/whatsapp-templates.js en tabel deferred_messages (migratie 036, door Badr gedraaid), registerUnreadableReceipt in de webhook plus admin-route en alert-kaart met foto, public/verwerkersovereenkomst.html met 13 [controleren]-punten. Bewijs: npm test 1269 groen na de merge; CI-run 33852438417 groen (test en deploy); health 200 na herstart; nieuwe admin-route antwoordt 401; verwerkersovereenkomst 200 op zendiq.nl, gelinkt vanuit privacy, voorwaarden en fleet. Onderweg: het npm-audit-endpoint gaf urenlang 400 en 503 en blokkeerde elke deploy; de audit-stap leest nu het JSON-rapport (scripts/ci-audit-check.js), probeert drie keer en blokkeert alleen op high of critical (commit 82778ba, door Badr gepusht omdat de auto-mode-classifier CI-wijzigingen weigert).
resultaat: open: meten 1 okt (E5, E6); E7 na jurist-check en de eerste fleet owner. Templates werken pas na goedkeuring door Meta: vier teksten in docs/whatsapp-templates.md, SID's in TWILIO_TEMPLATE_* op Render.
regel: Besluit 1 van 4 sep ("geen templates nodig") was te snel: één aangekomen rapport bewijst niet dat het venster nooit dicht is. De bot parkeert nu elk bericht dat buiten het venster valt en de rij met reason no_template maakt zichtbaar welke template ontbreekt. En: een beveiligingsgate moet een storing bij de leverancier onderscheiden van een echte bevinding, anders blokkeert hij op het verkeerde moment.

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
