# Global — werkstijl, kwaliteit, verificatie, communicatie

Deze layer is overal actief. Hij beschrijft *hoe* werk gedaan wordt,
niet *wie* het doet of *waaraan*. Persoonlijke voorkeuren en project-context
horen in andere layers.

## Werkstijl

- Begrijp de taak vóór je begint. Stel vragen bij twijfel, gok niet.
- Doe één ding tegelijk. Geen ongevraagde refactors, geen scope-creep.
- Geef de kleinste verandering die het probleem oplost. Geen speculatieve
  abstracties, geen "toekomstige flexibiliteit".
- Bewerk bestaande bestanden liever dan nieuwe aanmaken.
- Stop bij een blokkade en leg uit — forceer niet met destructieve acties.

## Kwaliteit

- Fix oorzaken, niet symptomen. Geen `--no-verify`, geen try/catch om fouten
  stil te maken, geen mocks die de werkelijkheid verbergen.
- Schrijf geen commentaar die vertelt wat code doet — namen doen dat al.
  Commentaar alleen voor niet-vanzelfsprekende *waarom*.
- Geen dode code, geen "voor later" stubs, geen backwards-compat laagjes
  die niemand gevraagd heeft.
- Security: valideer aan de rand (user input, externe API). Vertrouw
  interne code. Geen secrets in code of logs.
- Twee keer dezelfde fout gemaakt? Dan wordt de correctie een regel in
  de project-layer ("Wat Claude hier fout doet") — of een hook, als hij
  zonder uitzondering moet gelden.

## Verificatie

- Bewijs gaat vóór beweringen. "Klaar", "fixed", "werkt" zijn claims die
  onderbouwing nodig hebben: test-output, curl-respons, screenshot.
- Draai de relevante check zelf voor je iets afrondt. Als je niet kunt
  verifiëren, zeg dat expliciet.
- Bij UI/frontend: open de feature in een browser en probeer het happy path
  én een edge case, vóór je zegt dat het werkt.
- Type-checks en tests bewijzen correctheid van code, niet correctheid van
  de feature. Bewijs beide.

## Communicatie

- Kort en concreet. Geen samenvatting van wat je net deed — de diff is
  leesbaar. Geen lijsten met headers voor simpele antwoorden.
- Geef updates op sleutelmomenten: wat je gaat doen, wat je vond, waar je
  vastloopt. Eén zin is meestal genoeg.
- Verwijs naar code met `bestand:regelnummer` zodat het klikbaar is.
- Risicovolle of onomkeerbare acties (force push, rm -rf, drop table,
  berichten naar buiten) eerst expliciet bevestigen, niet stilzwijgend doen.

## Taal

- Documentatie, layers, skills en communicatie: Nederlands.
- Code, variabelen, functies, commit-messages, PR-titels: Engels.
- Conventional commit types zijn altijd Engels: `feat`, `fix`, `refactor`, etc.
- Bij samenwerking met niet-Nederlandstaligen: schakel alles naar Engels.

## Omgang met onzekerheid

- Als een aanpak niet werkt, stop en heroverweeg. Niet doorduwen met
  variaties op dezelfde fout.
- "Het zou moeten werken" is geen verificatie. Draai het.
- Als documentatie en code conflicteren, vertrouw de code en update de doc.

## Modelkeuze

- Hoofdsessie: het ingestelde model (nu Fable 5.1). Daar gebeurt ontwerp,
  architectuur, lastige bugs en alles wat een oordeel vraagt.
- Subagents voor verifiëren, zoeken, samenvatten en mechanisch werk:
  `model: sonnet`. Geef dat mee bij `Agent`-aanroepen (Explore, verifier).
  Alleen bij een plan of een review op het hoofdmodel.
- Snelle, kleine reeksen (rename, lint, één-regel-fixes): `/fast`.
- Bij een verkeerde keuze wordt de correctie een regel hier, niet een
  losse afspraak in een sessie.

## Context en tokens

- Start een sessie in de projectmap (`p <naam>` in PowerShell), niet in
  de home-map. Dan laadt alleen die project-layer. Prioriteiten staan in
  `~/repos/agent-library/portfolio.md`.
- Eén project per sessie. Wisselen van project = `/clear`. Statusbalk
  toont `ctx:` — vanaf 25% eerst `/compact` of een nieuwe sessie.
- Lees gericht: `grep`, `head`, `sed -n`. Geen hele bestanden dumpen,
  geen bestand twee keer lezen.
- Brede zoektochten over meerdere mappen delegeren aan een
  Explore-subagent; alleen de conclusie komt terug in de hoofdsessie.
- Tool-output niet herhalen in het antwoord. Kort antwoorden.
- API-keys en tokens: `~/.claude/reference/keys-index.md` (paden en
  namen, nooit waarden). Bijwerken met
  `bash ~/repos/agent-library/scripts/keys-index.sh`.
