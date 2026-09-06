# Backlog — orderflow-suite

Openstaande punten voor het orderflow-suite project.

## Prioriteit

<!-- Vul aan zodra er concrete taken zijn -->

## Ideeën / later

- [ ] **Parse-order: thread-aggregatie in caller** — huidige `parse-order` edge function ziet alleen 1 mail-body. In `supabase/functions/import-email` (en `poll-inbox`) alle thread-berichten concateneren voordat `parse-order` wordt aangeroepen, zodat cumulatieve instructies (bv. AMS.06494 case met 5 mails over 2 dagen) samengevoegd worden. Voeg ook ondersteuning toe voor `threadContext.allMessages[]` i.p.v. alleen `parentOrder`.
- [ ] **Parse-order: requirements-enum uitbreiden** — huidige enum `["Koeling","ADR","Laadklep","Douane"]` dekt DG en team-drivers niet. Voorstel: `"DG"` (los van ADR, want luchtvracht-specifiek met UN/SDS), `"Team"` (2 chauffeurs / duo-ritten), `"Temperatuurgecontroleerd"` (fijner dan alleen "Koeling", bv. bloedzendingen met dry-ice). Schema-change in `extractionSchema`, UI-badges in `OrderInfoRequestsCard`/filters, en DB-migratie als requirements een enum-kolom is.
