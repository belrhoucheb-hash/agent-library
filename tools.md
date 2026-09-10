# Tools: welke gereedschappen de agent heeft en waarvoor

Eén overzicht van MCP-servers, connectors en scripts. Geen waarden van
keys; die staan in `~/.claude/reference/keys-index.md` (paden en namen).

## MCP-servers (lokaal, `~/.claude.json`, user-scope)

| Server | Wat | Wanneer inzetten | Let op |
|---|---|---|---|
| supabase | Postgres, migraties, logs, advisors | Schema, RLS, queries, debuggen op een Supabase-project | Read-only geregistreerd; project-ref in `.claude.json` is niet de Zendiq-prod-ref, check `00 Start.md` in de vault |
| playwright | Browser besturen, screenshots | UI-controle: happy path en randgeval vóór "klaar" | Voor Zendiq liever `node scripts/screenshot.js` (desktop en mobiel) |
| scrapling | Fetchen met anti-bot en adaptive selectors | Prospectlijsten, sites die blokkeren, kapotte selectors | Sessies sluiten met `close_session`; skill `scrapling` beschrijft de escalatie |
| perplexity | Web-zoeken, research, redeneren met bronnen | Feiten, recente wijzigingen (btw, platforms), research-spike | Werkt pas met `PERPLEXITY_API_KEY` als Windows-env-var |
| mobbin | UI-referenties (flows, schermen) | Design-pass, benchmark van onboarding of dashboards | Alleen inspiratie, geen kopie |

## Connectors via claude.ai (in de sessie zichtbaar als `mcp__claude_ai_*`)

| Connector | Wanneer inzetten |
|---|---|
| Claude in Chrome | Pagina's lezen die WebFetch niet kan (Instagram, GA4), formulieren, screenshots |
| Gmail | Replies en drafts lezen; versturen alleen met expliciet akkoord |
| Google Drive, Calendar | Documenten en agenda lezen; pas na authenticatie |
| Higgsfield | Beeld en video voor socialposts (skill `higgsfield-content-factory`) |
| Apify | Scrapers uit de store als Scrapling niet volstaat |

## Scripts

| Script | Doet |
|---|---|
| `scripts/keys-index.sh` | Herbouwt `~/.claude/reference/keys-index.md` uit alle `.env`-bestanden (namen, geen waarden) |
| `setup.sh` | Symlinkt layers, skills en hooks vanuit deze library; genereert `SKILLS-INDEX.md` |
| `test-setup.sh` | Controleert of `setup.sh` alles op de juiste plek heeft gezet |
| `company/build-page.js` | Genereert de afdelingen-pagina uit `company/` |
| `hooks/*.sh` | Sessiestart-briefing, pre-commit-herinnering, productie-push-gate, testbescherming tijdens een fix |
| `~/Whatsapp-bot/scripts/screenshot.js` | Playwright-screenshot van een URL, desktop of mobiel |

## Regels

- Nieuw gereedschap (MCP, connector, script) krijgt eerst een regel hier,
  daarna pas gebruik in een skill of layer.
- Een tool die drie sessies niet gebruikt is, hoort in `## Geparkeerd`
  in dit bestand of weg uit `.claude.json`.
- Schrijvende acties naar buiten (mail, post, publish, geld) altijd
  eerst bevestigen, ongeacht welke tool.
