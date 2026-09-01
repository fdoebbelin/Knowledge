- Unit Testing als grundlegender Bestandteil moderner Softwareentwicklung
- Automatisierte Überprüfung einzelner Code-Bausteine auf korrektes Verhalten
- Einführung in **pytest** zur Umsetzung von Unit Tests in Python
- Bedeutung und Vorgehen von Test-Driven Development (**TDD**)
- Systematisches Testen und Verbessern von Funktionen und Klassen
## Was ist Unit Testing?

**Unit Tests** testen einzelne Code-Einheiten (Funktionen, Methoden, Klassen) isoliert von anderen Teilen des Programms und stellen sicher, dass diese kleine Bestandteile nach Plan funktionieren.

- Sie werden automatisiert ausgeführt, häufig schon beim Programmieren (z. B. via `pytest`)
- Sie dienen der Früherkennung von Fehlern und sichern die spätere Wartbarkeit
- Jede Code-Änderung kann sofort mit bestehenden Tests auf Fehler überprüft werden

Beispiel einer einfachen Funktion mit zugehörigem Test:

```python
# funktion.py
def quadriere(x):
    return x * x

# test_funktion.py
def test_quadriere():
    assert quadriere(3) == 9
    assert quadriere(0) == 0
    assert quadriere(-2) == 4
```

Tests werden einfach mit dem Befehl `pytest` ausgeführt.

## Test-Driven Development (TDD)

**TDD** ist eine Entwicklungsmethodik, bei der zuerst ein fehlschlagender Test geschrieben wird, dann der minimale funktionsfähige Code, damit dieser Test erfolgreich läuft, und anschließend der Code sauber (refactored) wird – das sogenannte „Red-Green-Refactor“-Prinzip:[^1]

1. **Red:** Test für eine neue Funktion schreiben, der zunächst fehlschlägt.
2. **Green:** Den Code so implementieren, dass der Test besteht.
3. **Refactor:** Code aufräumen, Tests müssen weiterhin bestehen.

Praktisches Beispiel:

```python
# Schritt 1: Test schreiben
def test_invertiere():
    assert invertiere("abc") == "cba"

# Schritt 2: Funktion so bauen, dass Test erfüllt wird
def invertiere(s):
    return s[::-1]
```

Die Funktion wird nach und nach mit weiteren Tests robust gemacht.

## Grundlegende pytest-Konventionen

- Testdateien: immer mit `test_` beginnen, z.B. `test_berechnung.py`
- Testfunktionen: immer mit `test_` beginnen
- Testklassen: mit `Test` beginnen, keine `__init__`-Methode

Test starten (im Verzeichnis der Tests):

```bash
pytest
pytest -v # für ausführliche Darstellung
```

Beispiele für unterschiedliche Assertions:

```python
assert sum([1, 2, 3]) == 6
assert "ab" in "abc"
assert not []  # prüft auf False
```


## Unit Tests für Funktionen und Klassen

### Funktionen testen

```python
def ist_ganzzahlig(x):
    return isinstance(x, int)

def test_ist_ganzzahlig():
    assert ist_ganzzahlig(5)
    assert not ist_ganzzahlig(3.2)
    assert not ist_ganzzahlig("hallo")
```


### Klassen testen

```python
class Konto:
    def __init__(self, start=0):
        if start < 0:
            raise ValueError("Kein negativer Kontostand erlaubt")
        self.betrag = start

    def einzahlen(self, wert):
        if wert < 0:
            raise ValueError("Keine negative Einzahlung")
        self.betrag += wert

def test_konto_einzahlen():
    k = Konto(100)
    k.einzahlen(50)
    assert k.betrag == 150

def test_konto_negativer_startwert():
    import pytest
    with pytest.raises(ValueError):
        Konto(-20)
```


## TDD in der Praxis – Schritt für Schritt

```python
# Schritt 1: Test schreiben
def test_fakultaet():
    assert fakultaet(3) == 6
    assert fakultaet(0) == 1

# Schritt 2: Implementierung
def fakultaet(n):
    if n < 0:
        raise ValueError("Nur für n>=0")
    if n == 0:
        return 1
    return n * fakultaet(n-1)
```

Jeden Schritt prüfen! Nach jedem Refactoring: Tests ausführen.

## Best Practices und Zusammenfassung

- Schreibe kleine, unabhängige Tests mit klarer Aussage
- Nutze aussagekräftige Namen (z. B. `test_ueberziehung_nicht_erlaubt`)
- Teste auch Grenzfälle und Fehlerfälle (z. B. mit `pytest.raises`)
- Tests sind ein Sicherheitsnetz für alle künftigen Änderungen

Mit konsequenten Unit Tests und TDD sichern Sie die Qualität und Weiterentwicklung Ihrer Python-Projekte nachhaltig ab.
