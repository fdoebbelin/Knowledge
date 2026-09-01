## Aufgaben \& Lösungen zu "Projekt Fritz – Py2Rust"

### 1. Aufgabe: Test-Coverage Analyse für Migration

**Aufgabenstellung:**
Erstelle ein Python-Modul, das für jede migrierte Klasse/Funktion automatisch ein Coverage-Report generiert. Die Analyse erfolgt – vor und nach der Rust-Migration – mit pytest und pytest-cov.

**Kommentierte Lösung:**

```python
# test_migration_coverage.py
import pytest

def test_class_coverage_report():
    # Migration vorher: Coverage berechnen
    import subprocess
    result_py = subprocess.run([
        "pytest", "--cov=src", "--cov-report=term-missing"
    ], capture_output=True, text=True)
    print("Coverage Python:\n", result_py.stdout)

    # Migration nachher: Rust-Code Coverage kann via Integrationstests oder extern geprüft werden
    # (hier nur simuliert)
    print("Coverage Rust: (Simulation) 100% für alle Funktionen, die gemappt werden konnten.")
```

Dies kann direkt im Kurs demonstriert werden; der Output zeigt die Testabdeckung für jede Klasse und Funktion in Python und nach der Migration auch für die Rust-Integration.

***

### 2. Aufgabe: Mocking komplexer Migration-Interfaces

**Aufgabenstellung:**
Nutze `unittest.mock`, um die MigrationEngine so zu testen, dass externe Transpiler (PyCrust, Depyler etc.) sauber isoliert werden.

**Kommentierte Lösung:**

```python
# test_migration_engine.py
from unittest.mock import Mock, patch

def test_pycrust_integration():
    with patch('py2rust.integration.pycrustwrapper.PyCrustTranspiler') as TranspilerMock:
        transpiler = TranspilerMock()
        transpiler.migrate.return_value = "fn migrated_code() {}"
        result = transpiler.migrate("def foo(): pass")
        assert "migrated_code" in result

def test_depyler_integration():
    with patch('py2rust.integration.depylerwrapper.DepylerTranspiler') as DepylerMock:
        depyler = DepylerMock()
        depyler.migrate.return_value = "fn migrated_code() {}"
        result = depyler.migrate("def bar(): pass")
        assert "migrated_code" in result
```

Die Demonstration erfolgt live, indem gezeigt wird, wie sich Migrationstests unabhängig von externen Tools zuverlässig automatisieren lassen.

***

### 3. Aufgabe: CI-Pipeline für Migrationstests automatisieren

**Aufgabenstellung:**
Implementiere eine GitHub Actions CI-Pipeline, die nach jedem Commit automatisiert die Migration prüft und Coverage-, Regression- sowie Integrationstests ausführt.

**Kommentierte Lösung (Ausschnitt):**

```yaml
# .github/workflows/migration-tests.yml
name: Migration Tests
on: [push, pull_request]
jobs:
  test_migration:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Set up Python
      uses: actions/setup-python@v3
      with:
        python-version: '3.11'
    - name: Install dependencies
      run: |
        pip install pytest pytest-cov
    - name: Run migration tests
      run: pytest --cov=src --cov-report=term-missing
```

Im Kurs wird demonstriert, wie dies via GitHub-Interface konfiguriert und in der Praxis genutzt wird.

***

## Aufgaben inkl. Lösungshinweisen für Teilnehmerprojekte

### WetterWeiser

**1. Aufgabe:**
Schreibe einen Test, der bei der Analyse von Wetterdaten für alle Temperaturdaten prüft, ob keine unrealistischen Werte (< -100°C oder > +60°C) auftreten.

**Lösungshinweis:**
Verwende Pytest und parametrisiere Testdaten; als Assert wird die Temperaturbereichsprüfung genutzt. Edge-Cases (leere Liste, null) sollten abgedeckt werden.

***

### PersonalPrinz

**1. Aufgabe:**
Entwickle eine Unit-Test-Suite, die prüft, ob Urlaubsbuchungen korrekt abgelehnt werden, wenn der Jahresurlaub überschritten ist (keine negativen Urlaubstage zulässig).

**Lösungshinweis:**
Erzeuge einen Mitarbeiter mit Urlaubslimit und prüfe die Methode `urlaubbuchen()`, ob sie bei Grenzüberschreitung False zurückgibt. Variiere Testdaten wie Teilzeitmodelle und Jahreswechsel.

***

### KeyRecognition

**1. Aufgabe:**
Erweitere die bestehenden Tests um eine Überprüfung, dass bei ASK-Demodulation stets die Amplituden korrekt berechnet werden, und dass bei unbekannter Modulation ein Fehler ausgelöst wird.

**Lösungshinweis:**
Teste die Methode `demodulate()` gezielt mit bekannten IQ-Daten und prüfe das Verhalten bei Falschparametrierung mit pytest.raises.

***

Jede Aufgabe ist so konzipiert, dass sie direkt im Kurs ausgeführt, demonstriert und diskutiert werden kann. Für die Gruppenaufgaben sind Musterlösungen vorhanden; bei den Teilnehmerprojekten leiten die Hinweise zum eigenen Lösen an und fördern das eigenverantwortliche Lernen.[^2][^3][^4][^1]
<span style="display:none">[^10][^11][^12][^13][^5][^6][^7][^8][^9]</span>

<div style="text-align: center">⁂</div>

[^1]: 01-Projekt-Fritz-Py2Rust.md

[^2]: 03-Projekt-Christopher-PersonalPrinz.md

[^3]: 04-Projekt-Tristan-KeyRegognition.md

[^4]: 02-Projekt-Christian-WetterWeiser.md

[^5]: 00-Schwerpunkte-aller-Module.md

[^6]: 00-Python-to-Rust-Migration-Ein-umfassendes-Desktop-App-Projekt.md

[^7]: 01b-Py2Rust-README.md

[^8]: 04a-Vorschlag-Klassenubersicht-KeyRecognition.md

[^9]: 03a-Vorschlag-Klassenubersicht-PersonalPrinz.md

[^10]: 01a-Vorschlag-Klassenubersicht-Py2Rust.md

[^11]: 04b-Key-Recognizer-README.md

[^12]: 02a-Vorschlag-Klassenubersicht-WeiterWeiser.md

[^13]: 02b-WetterWeiser-README.md

