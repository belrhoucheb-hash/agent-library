---
name: seo-audit
description: Gebruik bij een technische of inhoudelijke SEO-audit van een site, "waarom rankt deze pagina niet" of vóór en na een SEO-ronde. Crawl met gestripte scripts, snelheid via PageSpeed of lokale Lighthouse, Search Console via de ingelogde browser, en elke kritieke vondst eerst tegen de bron verifiëren.
---

# Skill: seo-audit

Een SEO-audit levert per pagina bevindingen met bewijs. Het grootste risico
is een instrument dat iets anders meet dan je denkt: een crawler die
scriptinhoud als pagina leest, of een site-breed cijfer dat voor één pagina
wordt aangenomen.

## Wanneer

- "Doe een SEO-audit", "waarom rankt X niet", "check de site technisch".
- Vóór een SEO-ronde als nulmeting, en erna als effectmeting.

## Stappen

1. **Scope en hypothese.** Welke pagina's, welke zoektermen. Formuleer elke
   hypothese als paar: zoekterm plus pagina.
2. **Crawl.** Haal de HTML per pagina op. Strip `<script>`, `<style>` en
   `<noscript>` vóór je title, meta description, H1 en H2, links, canonical
   en JSON-LD eruit haalt. Een regex op ruwe HTML ziet templates in scripts
   als pagina-inhoud en meldt dan valse dubbele H1's en kapotte links.
3. **Snelheid, via een meetladder.** Eerst de PageSpeed Insights-API. Is de
   quota op of wordt de site geblokkeerd, draai dan Lighthouse lokaal
   (`npx lighthouse <url>`) met de Chromium van Playwright via
   `CHROME_PATH`. Pas daarna meld je "data nodig".
4. **Search Console zonder API-token.** Lees via de ingelogde browser:
   Prestaties met de metrics voor positie aangezet, gefilterd op pagina;
   de pagina's per zoekterm; de indexering met de drilldown per reden.
   Neem nooit een site-brede positie over voor één pagina.
5. **Verifieer elke kritieke vondst** tegen de bron of de gerenderde DOM
   voordat hij als P0 in het rapport komt.
6. **Rapport.** Per pagina: bevinding, bewijs, ernst, voorstel. Apart: wat
   niet gemeten kon worden en waarom.

## Output

Een tabel per pagina met bevinding, bewijs en ernst, plus de nulmeting per
paar zoekterm en pagina voor de volgende effectmeting.

## Rode vlaggen

- Een P0 in het rapport die niemand tegen de bron heeft gecontroleerd.
- Een dubbele H1 of kapotte link die alleen in een scriptblok staat.
- Een positie zonder paginafilter als bewijs voor één pagina.
- "Snelheid onbekend" terwijl lokale Lighthouse kon draaien.
