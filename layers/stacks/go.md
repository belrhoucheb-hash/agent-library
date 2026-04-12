# Go — stack conventies

Deze layer is actief voor Go-projecten (APIs, CLI tools, services).

## Structuur

- Standaard Go project layout: `cmd/`, `internal/`, `pkg/`.
- `cmd/<app>/main.go` als entrypoint per binary.
- `internal/` voor code die niet geïmporteerd mag worden door
  externe packages.
- Geen `src/` map — dat is geen Go conventie.

## Error handling

- Errors altijd afhandelen: `if err != nil { return err }`.
  Nooit `_` voor errors tenzij je expliciet documenteert waarom.
- Wrap errors met context: `fmt.Errorf("parse config: %w", err)`.
- Geen panics in library code — alleen in `main()` als laatste
  redmiddel.

## Dependencies

- `go.mod` en `go.sum` committen.
- Minimale externe dependencies — Go standaard library is uitgebreid.
- `go mod tidy` draaien voor commit.

## Testing

- Tests in `_test.go` bestanden naast de code die ze testen.
- Table-driven tests als standaard patroon.
- `go test ./...` draaien voor commit.
- `go vet ./...` voor statische analyse.

## Concurrency

- Geen goroutine starten zonder plan voor hoe die stopt.
- Channels voor communicatie, mutexes voor gedeelde state.
- `context.Context` als eerste parameter voor cancellation.
- `sync.WaitGroup` of `errgroup` voor goroutine lifecycle.

## Code style

- `gofmt` / `goimports` — niet-onderhandelbaar, altijd draaien.
- Exporteer alleen wat nodig is (PascalCase = public).
- Interfaces klein houden: 1-3 methoden. Definieer ze bij de
  consumer, niet bij de implementatie.
- Geen `init()` functies tenzij strikt noodzakelijk.

## Veelgemaakte fouten

- Goroutine leak: goroutine die nooit stopt omdat niemand het
  channel sluit of de context cancelt.
- `defer` in een loop — defers stapelen tot functie-einde.
- Pointer vs value receiver mixen op hetzelfde type.
- JSON tags vergeten: `json:"fieldName"` op struct fields.
