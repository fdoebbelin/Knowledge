## Übersicht und Zielstellung

Im Fokus stehen die Vertiefung von Unit Testing in produktionsreifen Python-Projekten, die Integration in Continuous-Integration-Pipelines (CI), Testen komplexer OOP-Strukturen und die Anwendung von Test-Driven Development (TDD) beim Refactoring. Ziel ist es, Sicherheit, Skalierbarkeit und Wartbarkeit des Codes systematisch zu erhöhen.[^1]

***

## CI-Integration: Tests im Team- und Produktivworkflow

Automatisierte Tests werden in Git-Workflows oder CI-Umgebungen wie GitHub Actions integriert. So laufen Tests bei jedem Code-Commit oder Pull-Request automatisch ab. Die Einrichtung erfolgt durch Konfigurationsdateien, z.B. für pytest und coverage.

```yaml
# .github/workflows/tests.yml
name: Run Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Set up Python
      uses: actions/setup-python@v3
      with:
        python-version: '3.11'
    - name: Install dependencies and run tests
      run: |
        pip install pytest pytest-cov
        pytest --cov=src --cov-report=term-missing
```

Tests werden typischerweise so strukturiert, dass sie verschiedene Ebenen (Unit, Integration, Regression) in separaten Testdateien markieren:

```ini
# pytest.ini
[pytest]
markers =
    unit: schnelle Modultests
    integration: komplexere Systemtests
addopts =
    --cov=src --cov-report=term-missing
```


***

## Komplexe OOP-Strukturen testen

Der Prüfbereich umfasst die Vererbung, Polymorphie und das Zusammenspiel komplexer Klassen und Mixins. Hier ist der Entwurf sauberer Interfaces und die Abdeckung aller Codewege zentral.

```python
# src/shapes.py
class Shape:
    def __init__(self, name):
        self.name = name

    def get_area(self):
        raise NotImplementedError("Implementierung erforderlich!")

class Circle(Shape):
    def __init__(self, radius):
        super().__init__("Circle")
        self.radius = radius

    def get_area(self):
        from math import pi
        return pi * self.radius ** 2

# Testfälle
import pytest

def test_circle_area():
    c = Circle(2)
    assert abs(c.get_area() - 12.566) < 0.01

def test_shape_not_implemented():
    s = Shape("Test")
    with pytest.raises(NotImplementedError):
        s.get_area()
```

Mixins und Decorator-basierte Erweiterungen werden mit gezielten Tests (Mocking, Patchen) abgesichert.

***

## TDD beim Refactoring

Refactoring beginnt stets mit umfassender Testabdeckung des Ist-Zustands. Danach wird der Code Schritt für Schritt verbessert, wobei die Tests unverändert bestehen müssen – der sogenannte „Red-Green-Refactor“-Zyklus.

```python
# BEFORE:
class DataProcessor:
    def process(self, data):
        result = []
        for x in data:
            if x > 0:
                result.append(x)
        return result

def test_process_returns_positive():
    dp = DataProcessor()
    assert dp.process([-1, 0, 2, 5, -7]) == [2, 5]
```

Beim Refactoring können Identitäts- und Regressionstests (Vergleich Alt/Neu) helfen, Korrektheit zu sichern. Nach jedem Schritt werden die Tests neu ausgeführt.

```python
# AFTER (Refactored):
class DataProcessor:
    def filter_positive(self, data):
        return [x for x in data if x > 0]
```


***

## Property-Based Testing mit Hypothesis

Statt nur mit festen Beispielen zu testen, werden mit Bibliotheken wie Hypothesis automatisch viele verschiedene Testdaten erzeugt. So lassen sich auch Grenzfälle systematisch prüfen.

```python
from hypothesis import given, strategies as st

@given(st.lists(st.integers()))
def test_positive_count(data):
    dp = DataProcessor()
    filtered = dp.filter_positive(data)
    assert all(x > 0 for x in filtered)
```


***

## Mocking und Isolierte Tests

Für externe Abhängigkeiten (z.B. Datenbankzugriffe, Webservices) kommen Mocks oder Stubs zum Einsatz, z.B. mit unittest.mock. Dadurch laufen Tests schnell und unabhängig.

```python
from unittest.mock import Mock

class Database:
    def save(self, record): pass

def test_database_save_called():
    db = Mock(Database)
    db.save("TestRecord")
    db.save.assert_called_once_with("TestRecord")
```


***

## Performance- und Benchmark-Tests

Auch Laufzeiten und Speicherverbrauch lassen sich in Unit-Testformen prüfen und benchmarken, etwa mit pytest-benchmark oder memory_profiler.

```python
import time

def test_runtime():
    start = time.time()
    sum([i for i in range(1000000)])
    duration = time.time() - start
    assert duration < 0.5
```


***

## Zusammenfassung

Modul 35 vermittelt alle fortgeschrittenen Techniken, die für Testing in professionellen Python-Projekten relevant sind: CI-Integration, komplexe OOP-Tests, TDD für Refactoring, Property-based Testing, Mocking und Performance-Checks. Praxisbeispiele zeigen, wie ein robustes Test-Setup aussieht, und wie die einzelnen Methoden ineinandergreifen. Diese Fähigkeiten befähigen zur Entwicklung und Wartung skalierbarer, fehlerarmer Software.[^1]

***

Alle Beispielscripte sind so gestaltet, dass sie im Kurskontext direkt ausgeführt, angepasst und erweitert werden können. Sie sollen zum Mitmachen, Testen und Diskutieren anregen und geben eine solide Basis für vertiefende praktische Aufgabenstellungen.
<span style="display:none">[^10][^11][^12][^13][^14][^2][^3][^4][^5][^6][^7][^8][^9]</span>

<div style="text-align: center">⁂</div>

[^1]: 00-Schwerpunkte-aller-Module.md

[^2]: 00-Python-to-Rust-Migration-Ein-umfassendes-Desktop-App-Projekt.md

[^3]: 01b-Py2Rust-README.md

[^4]: 01-Projekt-Fritz-Py2Rust.md

[^5]: 02b-WetterWeiser-README.md

[^6]: 04-Projekt-Tristan-KeyRegognition.md

[^7]: 04b-Key-Recognizer-README.md

[^8]: 04a-Vorschlag-Klassenubersicht-KeyRecognition.md

[^9]: 01a-Vorschlag-Klassenubersicht-Py2Rust.md

[^10]: 02a-Vorschlag-Klassenubersicht-WeiterWeiser.md

[^11]: 03b-Personalprinz-README.md

[^12]: 03-Projekt-Christopher-PersonalPrinz.md

[^13]: 02-Projekt-Christian-WetterWeiser.md

[^14]: 03a-Vorschlag-Klassenubersicht-PersonalPrinz.md

