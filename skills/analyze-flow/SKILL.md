---
name: analyze-flow
description: Gebruik bij webhook flows, API chains, async processen of state-based flows — maak de flow expliciet stap-voor-stap, identificeer kwetsbare punten, vóór je een fix of wijziging voorstelt.
---

# Skill: analyze-flow

Maak de flow expliciet, stap-voor-stap, zonder aannames.
Identificeer waar het kan breken en hoe je dat verifieert.

## Wanneer

- Webhook flows (Twilio, Stripe, Mollie, etc.)
- API chains / backend pipelines
- Async processen
- State-based flows
- Bugs waarbij de oorzaak niet direct zichtbaar is

Gebruik dit **vóór** je een fix voorstelt.

## 3-Rule (altijd toepassen)

1. **Begrijp het doel van de flow** — wat probeert deze flow te bereiken?
2. **Maak de flow concreet** — geen aannames, stap voor stap uitschrijven.
3. **Optimaliseer pas daarna** — eerst correctheid, dan verbetering.

## Stappen

### 1. Entry point
- Waar start de flow? (webhook / functie / endpoint)

### 2. Input
- Welke data komt binnen?
- Validatie aanwezig? (ja/nee)

### 3. Flow stappen (lineair maken)
- Stap 1 → Stap 2 → Stap 3 →
- Ook bij async: expliciet maken, geen impliciete sprongen.

### 4. State & side effects
- Wat wordt opgeslagen? Wat verandert?
- (DB, cache, externe calls)

### 5. Exit points
- Wat is de output? (response / message / DB write)

### 6. Failure points
- Waar kan het misgaan?
- Denk aan: ontbrekende data, race conditions, timeouts, externe
  afhankelijkheden.

### 7. Observability
- Hoe zie je dat het werkt? (logs / output / metrics)

## Output (verplicht format)

1. **Doel van de flow**
2. **Stap-voor-stap flow**
3. **Kwetsbare punten**
4. **Concrete verbeteringen**
5. **Hoe te verifiëren**

## Rode vlaggen

- Je gebruikt "waarschijnlijk" of "zou moeten" — alles expliciet maken.
- Je stelt een fix voor zonder de flow eerst uitgeschreven te hebben.
- Je slaat stappen over omdat ze "vanzelfsprekend" lijken.
- Je mist een failure point bij een externe afhankelijkheid.
