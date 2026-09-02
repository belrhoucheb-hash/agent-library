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

## Openstaande punten

- [ ] BOIP-merkcheck SMEULWERK
- [ ] Fase 2: Shopify-migratie
