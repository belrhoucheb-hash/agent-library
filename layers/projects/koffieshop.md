# Koffieshop (SMEULWERK) — project context

Deze layer is alleen actief binnen `~/repos/koffieshop/*`.

## Wat is dit project

Specialty-koffie-webshop onder de merknaam SMEULWERK (definitief;
smeulwerk.nl bij TransIP). Fase 1 = statisch prototype in `prototype/`
(af); fase 2 = Shopify. Zie `README.md` voor de paginastructuur.

## Stack

- Statische HTML/CSS/JS in `prototype/` — index, shop, finder, product
- Cart via localStorage (`smeulwerk_cart`); checkout is bewust een stub
- Design-systeem: Abetterlou-tokens + SMEULWERK-uitbreidingen — zie
  `DESIGN.md` (espresso-zwart, warm cream, één amber accent,
  pill-controls, geen schaduwen, Fraunces display-serif)

## Harde regels

1. `DESIGN.md` is leidend voor elk visueel besluit — geen
   default-Tailwind-look, geen extra accentkleuren, geen schaduwen.
2. De checkout-stub niet "afmaken" in fase 1 — echte checkout komt
   met Shopify in fase 2.

## Wat Claude hier fout doet

<!-- Twee-keer-fout-regel: zelfde fout twee keer → correctie hier, of
     een hook als hij zonder uitzondering moet gelden. -->

- <!-- Correctie -->

## Commando's

- Lokaal draaien: `cd prototype && python -m http.server 4317` →
  http://localhost:4317

## SEO

- `seo/SEO-AUDIT.md`, `SEO-KEYWORD-MAP.md`, `SEO-CONTENT-ROADMAP.md`,
  `SEO-INTERNAL-LINKING.md`, `SEO-CHANGES.md` (logboek, nieuwste bovenaan).
  Bij vervolgwerk: roadmap volgen, niet opnieuw auditen.
- Het theme bouwt titels/omschrijvingen/schema zelf (`layout/theme.liquid`);
  eigen SEO-velden in Shopify winnen altijd.
- Productkaarten worden server-side gerenderd via
  `snippets/product-card.liquid`; theme.js vult alleen notities/brandgraad aan.
- Concept-artikelen voor de Shopify-blog staan in `content/blog/`. Geen
  nieuwe herkomst- of smaakcontent schrijven zolang de productdata niet door
  de branderij-partner is bevestigd; alleen content uit echte activiteit.
- Shopify-live-acties (`theme push --allow-live`, `theme publish`, DNS,
  admin-wijzigingen) blokkeert de classifier: altijd als stap voor Badr
  formuleren, wijzigingen naar een ongepubliceerd theme pushen.

## Git

- Repo is sinds 6 sep 2026 een git-repo (`main` = baseline, werk op
  feature-branches). `outreach/` is een eigen repo en staat in `.gitignore`.

## Openstaande punten

- [ ] BOIP-merkcheck SMEULWERK
- [ ] Theme "SMEULWERK SEO 6 sep" (#194824831302) publiceren na preview
- [x] Store-taal Nederlands (6 sep)
- [ ] Shopify-admin (P0/P1 in `seo/SEO-CONTENT-ROADMAP.md`, plakteksten in
      `content/*-2026-09-06.md`): beleidspagina's, productclaims weghalen,
      huisblend → 205, proefpakket, collecties espressobonen/filterkoffie,
      SEO-velden, blog hernoemen. Claude kan niet klikken in de admin
      (classifier), wel voorbereiden en verifiëren.

## Vault (Obsidian)

Kennisbank: `~/Obsidian/smeulwerk`. Bij sessiestart: lees `00 Start.md` en de
nieuwste notitie in `Sessies/` — niet de hele vault. Bij sessie-einde:
schrijf `Sessies/<datum>.md` volgens `Templates/Sessie.md` (max 15
regels: gedaan, stand, volgende stap, open vragen). Besluiten in
`Besluiten.md`, key-locaties in `Keys.md`, open punten in
`Backlog/koffieshop.md` (dat is `agent-library/backlog`, live gekoppeld).
