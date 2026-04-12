# Supabase — stack conventies

Deze layer is actief voor projecten die Supabase gebruiken als database
en/of auth provider.

## Connectie

- Supabase client initialiseren op één plek, niet per bestand opnieuw.
- Service key (volledige toegang) alleen server-side, nooit in
  client-code of frontend.
- Anon key voor client-side, met Row Level Security (RLS) als guard.

## Database

- Schema-wijzigingen via migrations, niet handmatig in de dashboard.
  Als migrations nog niet opgezet zijn, documenteer de wijziging als
  SQL in een comment of `migrations/` map.
- Gebruik `select()` met expliciete kolommen, niet `select('*')` —
  voorkomt data-leaks bij schema-uitbreiding.
- Foreign keys en constraints in de database, niet alleen in code.

## Row Level Security

- RLS altijd aan voor tabellen die user-data bevatten.
- Policies testen met een niet-geauthenticeerde client — als je data
  ziet die je niet zou moeten zien, is de policy fout.

## Realtime & Edge Functions

- Realtime subscriptions opruimen bij unmount/disconnect.
- Edge Functions: zelfde secret-handling als backend — env vars, geen
  hardcoded keys.

## Veelgemaakte fouten

- `upsert` zonder `onConflict` specificeren — leidt tot dubbele rijen.
- `.single()` zonder `limit(1)` — crasht bij 0 of >1 resultaten.
- Service key in client-side code — volledige database-toegang gelekt.
