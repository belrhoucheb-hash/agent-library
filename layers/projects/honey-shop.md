# Honey-shop (By Amina's Honing) — project context

Deze layer is alleen actief binnen `~/repos/honey-shop/*`.

## Wat is dit project

Statisch site-prototype ("Aurum — Raw Honey, Single Origin") voor de
honingverkoop. De échte verkoop loopt via de Shopify-store By Amina's
Honing; dit prototype is design-/experimenteerruimte. De Shopify-themes
staan in aparte repos (`~/repos/honey-theme`, `~/repos/miel-theme`).

## Stack

- Statische HTML/CSS/JS — `index.html`, `assets/js/main.js`
- Productdata in `assets/data/products.json`
- Shopify (los van deze repo) — de productiewinkel

## Harde regels

1. Shopify CLI-commando's altijd tegen `by-aminas-honing.myshopify.com` —
   níet `byaminashoning` (dat is alleen het .nl vanity-domein).
2. Metafields (herkomst_verhaal, past_bij, origin, bron) zijn af —
   niet opnieuw aanmaken of hernoemen.

## Wat Claude hier fout doet

<!-- Twee-keer-fout-regel: zelfde fout twee keer → correctie hier, of
     een hook als hij zonder uitzondering moet gelden. -->

- <!-- Correctie -->

## Commando's

- Lokaal bekijken: `index.html` openen in de browser (geen build-stap)

## Openstaande punten

- [ ] GTIN's ontbreken in Shopify (blokkeert Google Shopping)
- Ads-plan loopt: nulmeting 19 aug 2026, CAPI actief — zie memory/backlog
