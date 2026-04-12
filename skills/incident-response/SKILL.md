---
name: incident-response
description: Gebruik bij een productie-probleem of onverwachte outage — triage, mitigeer, communiceer, root cause, postmortem.
---

# Skill: incident-response

Gebruik dit wanneer er iets mis is in productie. De volgorde is cruciaal:
eerst stabiliseren, dan begrijpen, dan voorkomen.

## Wanneer

- Gebruikers melden dat iets niet werkt.
- Monitoring of logs tonen onverwachte errors.
- Een deploy heeft iets gebroken.
- Een externe service is down en je applicatie hangt eraan.

## Stappen

### Fase 1: Triage (eerste 5 minuten)

1. **Wat is de impact?** Wie is geraakt, hoeveel gebruikers, welke
   functionaliteit?
2. **Sinds wanneer?** Check deploy-log, git log, of monitoring. Is het
   gekoppeld aan een recente wijziging?
3. **Ernst bepalen:**

   | Ernst | Betekenis | Actie |
   |---|---|---|
   | Kritiek | Kernfunctie down, alle gebruikers | Direct mitigeren |
   | Hoog | Belangrijke functie down, deel van gebruikers | Mitigeren binnen uur |
   | Medium | Niet-kritieke functie, workaround mogelijk | Plannen |

### Fase 2: Mitigeer (stabiliseer eerst)

4. **Kun je rollbacken?** Als het aan een deploy ligt: rollback naar
   de vorige werkende versie. Dat is sneller dan debuggen.
5. **Kun je de schade beperken?** Feature flag uit, rate limit aan,
   fallback activeren, of de kapotte route tijdelijk uitschakelen.
6. **Communiceer.** Kort bericht aan wie het moet weten: wat is er aan
   de hand, wat doe je eraan, wanneer is de volgende update.

### Fase 3: Root cause

7. **systematic-debug skill.** Pas nu ga je debuggen — niet eerder.
   De productie is gestabiliseerd, je hebt tijd om het goed te doen.
8. **Fix implementeren.** Met tests die de bug vangen.
9. **Deploy via deploy-checklist.** Geen haast-deploy zonder checks.

### Fase 4: Postmortem (binnen 24 uur)

10. **Documenteer.** Kort:
    - Wat ging er mis?
    - Wanneer gedetecteerd, wanneer gemitigeerd, wanneer opgelost?
    - Root cause.
    - Wat doen we om herhaling te voorkomen?
11. **Actiepunten.** Concrete taken in de backlog. Niet "we moeten
    beter testen" maar "voeg health-check endpoint toe" of "stel
    alerting in op error rate > 5%".

## Rode vlaggen

- Je begint met debuggen terwijl productie nog down is — mitigeer eerst.
- Je deployt een fix zonder tests — je introduceert mogelijk een tweede
  incident.
- Je communiceert niet — stakeholders horen het van gebruikers in
  plaats van van jou.
- Geen postmortem — dezelfde fout zal zich herhalen.
- Je blame't een persoon in het postmortem — focus op systeem, niet
  op schuld.
