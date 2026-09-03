# Company — Zendiq als bedrijf van één mens plus agents

De afdelingen zijn de bron van waarheid voor hoe Zendiq gerund wordt.
Elke afdeling heeft een doel, een meetlat, een ritme en skills. Product is
de motor: de verbeterlus gebruik → meten → probleem → hypothese →
verbetering → deploy → opnieuw meten → regel.

## Waar wat staat

| Bestand | Inhoud |
|---|---|
| `afdelingen/<afdeling>.md` | Eén afdeling: doel, meetlat, ritme, skills. Skelet in `_template.md`. |
| `experimenten.md` | Lopende experimenten met succescriterium en meetdatum. |
| `nulmeting.md` | De laatste meting van de kerncijfers, alleen totalen. |
| `logboek.md` | Wat er gedaan is, als probleem → hypothese → wijziging → resultaat → regel. |
| `besluiten.md` | Open besluiten voor Badr. |
| `build-page.js` | Genereert `zendiq-afdelingen.html` uit bovenstaande. Niet de HTML bewerken. |

## Regels

- Geen feature is klaar na deploy. Hij is klaar nadat gemeten is of hij het
  succescriterium haalde (`experimenten.md`).
- Elk experiment heeft vooraf een concreet succescriterium en een meetdatum.
- Maximaal twee experimenten per week, gerangschikt op
  impact × aantal gebruikers × zekerheid / inspanning.
- Ideeën gaan in de ideeënbus: `backlog/<project>.md`, sectie "Ideeën / later",
  in de vorm `**<Afdeling> — <titel>** (<datum>). ... Meetlat: ...`.

## Rituelen en de skills die ze uitvoeren

| Wanneer | Skill | Afdeling |
|---|---|---|
| zondag | `zondag-triage` | Product |
| na elke meetdatum | `effectmeting` | Product |
| na elk afgerond stuk werk | `afdeling-update` | Leren |

De sessie-start-hook meldt welk ritueel vandaag geldt en welke experimenten
over hun meetdatum zijn.

## Publiceren

```
node company/build-page.js          # markdown → zendiq-afdelingen.html
```

Daarna de HTML als artifact publiceren op de bestaande URL (staat in
`afdeling-update`), en committen. De URL staat in de memory van Claude.
