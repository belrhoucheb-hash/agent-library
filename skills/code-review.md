# Skill: code-review

Checklist om langs te lopen vóór een commit, merge, of PR — je eigen
code of die van iemand anders.

## Wanneer

- Net voor een commit van een niet-triviale wijziging.
- Voor je een PR openzet of als klaar markeert.
- Wanneer een ander expliciet om review vraagt.

## Checklist

### Correctheid
- Doet de code wat de taak vraagt? Niet meer, niet minder.
- Edge cases: lege input, null, grote input, gelijktijdige calls.
- Error paths: wat gebeurt er als de externe call faalt?

### Leesbaarheid
- Namen beschrijven intent, niet implementatie.
- Geen commentaar die herhaalt wat de code doet.
- Functies doen één ding. Als de naam "en" bevat, splits hem.

### Simplificatie
- Kan dit met minder regels? Zonder helperfunctie die alleen hier
  gebruikt wordt?
- Is er dode code, ongebruikte imports, `console.log` restjes?
- Speculatieve flexibiliteit (feature flags, config voor 1 scenario)
  die weg kan?

### Security
- User input gevalideerd aan de rand?
- Geen secrets in code of logs?
- SQL/shell/template injection mogelijkheden?

### Tests
- Dekt een test de nieuwe logica? Draait de suite groen?
- Bij bugfix: is er een regressietest die de bug vangt?

### Scope
- Raakt de diff bestanden die niets met de taak te maken hebben?
  Splitsen of terugdraaien.

## Output

Kort rapport: wat is goed, wat moet veranderen, wat mag optioneel beter.
Geen vage opmerkingen — wijs naar `bestand:regel`.

## Rode vlaggen

- Diff > 400 regels — review wordt onbetrouwbaar, splits de wijziging.
- Meerdere onderwerpen in één commit — splits voor je reviewt.
- "Werkt op mijn machine" zonder draaiende tests.
