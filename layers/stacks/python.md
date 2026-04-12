# Python — stack conventies

Deze layer is actief voor Python-projecten (API's, scripts, data, ML).

## Structuur

- Entrypoint duidelijk: `main.py`, `app.py`, of `src/<package>/__main__.py`.
- Package-structuur met `__init__.py` waar nodig.
- Geen business logic in het entrypoint — importeer en roep aan.
- Tests in `tests/` map, spiegelend aan de source-structuur.

## Environment

- Virtual environment verplicht: `venv/`, `.venv/`, of via `poetry`/`uv`.
- `venv/` en `.venv/` staan in `.gitignore`.
- Dependencies in `requirements.txt` (met pinned versions) of
  `pyproject.toml`. Geen losse `pip install` zonder vastleggen.
- `.env` voor secrets, geladen via `python-dotenv` of platform.
  Nooit hardcoded in code.

## Code style

- Type hints gebruiken voor functie-signatures en publieke interfaces.
- f-strings boven `.format()` of `%`.
- Geen bare `except:` — altijd specifieke exceptions vangen.
- `pathlib.Path` boven `os.path` voor bestandspaden.

## Testing

- `pytest` als test-runner (tenzij project al `unittest` gebruikt).
- Draai `pytest` voor commit.
- Geen `print()` debugging in committed code — gebruik `logging`.

## Veelgemaakte fouten

- Mutable default arguments: `def f(items=[])` — gebruik `None` +
  toewijzing in de body.
- `import *` — maakt dependencies ondoorzichtig.
- Geen `if __name__ == "__main__":` guard — module wordt onbedoeld
  uitgevoerd bij import.
- Secrets in f-strings die naar logs gaan.
- `requirements.txt` zonder versions — niet reproduceerbaar.
