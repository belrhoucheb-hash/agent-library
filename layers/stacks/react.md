# React — stack conventies

Deze layer is actief voor React frontend-projecten (CRA, Next.js, Vite).

## Structuur

- Components in `src/components/`, pages in `src/pages/` of
  `src/app/` (Next.js App Router).
- Eén component per bestand. Bestandsnaam = componentnaam (PascalCase).
- Gedeelde utilities in `src/lib/` of `src/utils/`.
- Styles naast hun component: `Button.tsx` + `Button.module.css`
  of styled-components in hetzelfde bestand.

## State management

- Lokale state (`useState`) voor UI-state die niet gedeeld wordt.
- Context of een state library (Zustand, Redux) alleen voor
  echt gedeelde state. Niet alles in global state duwen.
- Server state via React Query / SWR / Next.js server components —
  niet handmatig fetchen in `useEffect`.

## Performance

- `React.memo` alleen bij gemeten performance-problemen, niet
  preventief.
- Geen zware berekeningen in render — gebruik `useMemo` met
  duidelijke dependency array.
- Lazy loading voor routes en zware componenten: `React.lazy()`
  of Next.js dynamic imports.
- Images: gebruik `next/image` (Next.js) of expliciete
  width/height attributen.

## TypeScript (als van toepassing)

- Props als interface of type, niet als inline object.
- Geen `any` — gebruik `unknown` als type onbekend is en narrow
  daarna.
- Event handlers typen: `React.MouseEvent<HTMLButtonElement>`.

## Testing

- Component tests met React Testing Library, niet Enzyme.
- Test gedrag, niet implementatie — klik, vul in, controleer output.
- `npm test` / `vitest` draaien voor commit.

## Veelgemaakte fouten

- `useEffect` als event handler — effect is voor synchronisatie,
  niet voor user-acties.
- Missing dependency array in `useEffect` — infinite re-renders.
- Inline objecten/functies als props → onnodige re-renders van
  child components.
- API keys in client-side code — gebruik server-side routes of
  environment variables die NIET met `NEXT_PUBLIC_` beginnen voor
  secrets.
- `index.tsx` voor alles — maakt imports en debugging ondoorzichtig.
