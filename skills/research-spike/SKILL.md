---
name: research-spike
description: Gebruik bij het evalueren van een technologie, library, of aanpak voordat je commit aan een implementatie — timeboxed onderzoek, opties vergelijken, conclusie met trade-offs.
---

# Skill: research-spike

Gebruik dit wanneer je een technologie of aanpak wilt evalueren voordat
je begint met bouwen. Een spike levert een besluit op, geen code.

## Wanneer

- Je overweegt een nieuwe library, service, of framework.
- Er zijn meerdere redelijke aanpakken en je weet niet welke het beste past.
- Je gaat iets bouwen dat je nog niet eerder hebt gedaan.
- Iemand vraagt "zullen we X gebruiken?" en je hebt geen gefundeerd antwoord.

## Stappen

1. **Vraag formuleren.** Eén concrete vraag die het onderzoek stuurt.
   Niet "wat is de beste database?" maar "past Supabase bij een project
   met X gebruikers en Y schrijfoperaties per seconde?"

2. **Timebox instellen.** Spreek af hoeveel tijd het onderzoek mag
   kosten. Standaard: maximaal 1 uur. Als je na de timebox geen
   antwoord hebt, is dat ook een antwoord (te complex, te onbekend).

3. **2-3 opties identificeren.** Niet meer. Inclusief "niets doen" of
   "zelf bouwen" als dat realistisch is.

4. **Per optie evalueren:**

   | Criterium | Vraag |
   |---|---|
   | Fit | Lost het de concrete vraag op? |
   | Complexiteit | Hoeveel leercurve / setup / config? |
   | Onderhoud | Actief onderhouden? Community? Documentatie? |
   | Kosten | Gratis / betaald? Vendor lock-in? |
   | Risico's | Wat kan misgaan? Wat als de library verdwijnt? |

5. **Conclusie schrijven.** In 5-10 regels:
   - Welke optie win en waarom.
   - Welke trade-offs je accepteert.
   - Wat de volgende concrete stap is.

6. **Besluit vastleggen.** Noteer de conclusie in de project-layer of
   een ADR (Architecture Decision Record) als het project dat
   ondersteunt.

## Output

Kort rapport: vraag, opties, evaluatie-tabel, conclusie, volgende stap.
Geen essay — het doel is een besluit, niet een whitepaper.

## Rode vlaggen

- Je onderzoekt meer dan 3 opties — analysis paralysis.
- Je schrijft code tijdens een spike — dat is een prototype, geen
  onderzoek.
- Je hebt geen concrete vraag — je browst rond zonder richting.
- De timebox is voorbij en je hebt geen conclusie — forceer een
  voorlopig besluit of eskaleer.
- Je kiest een technologie "omdat het nieuw is" zonder fit-analyse.
