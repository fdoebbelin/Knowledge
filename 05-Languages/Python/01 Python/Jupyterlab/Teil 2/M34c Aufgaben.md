## Dozentenvorlage: Aufgaben \& kommentierte Lösungen zum Projekt „Py2Rust“

### Aufgabe 1: Assertion-Strategien und Fehlerfälle testen

**Aufgabenstellung:**
Implementieren Sie für die MigrationEngine-Klasse der Py2Rust-Projektstruktur einen Satz Unit-Tests mit pytest, die folgende Aspekte validieren:

- Erfolgreiche Migration gibt ein String-Objekt zurück, das „Rust-Modul“ enthält.
- Fehlerhafte Analyse führt zu einer Exception, die spezifisch geprüft wird.
- Fügen Sie parametrisierte Tests für verschiedene Eingabetypen hinzu.

**Beispielhafte Lösung (vollständig kommentiert):**

```python
import pytest
from py2rust.migrationengine import MigrationEngine

class DummyAnalyzer:
    def listclasses(self):
        return ["Foo", "Bar"]

def test_migration_success():
    engine = MigrationEngine(DummyAnalyzer())
    result = engine.migrate()
    assert isinstance(result, str)
    assert "Rust-Modul" in result

def test_migration_error():
    class BrokenAnalyzer:
        def listclasses(self):
            raise ValueError("Analyse fehlgeschlagen")

    engine = MigrationEngine(BrokenAnalyzer())
    with pytest.raises(ValueError, match="Analyse fehlgeschlagen"):
        engine.migrate()

@pytest.mark.parametrize("classes,expected", [
    (["Foo"], "Rust-Modul"),
    ([], "Rust-Modul"),
])
def test_parametrized_migrate(monkeypatch, classes, expected):
    class ParamAnalyzer:
        def listclasses(self):
            return classes
    engine = MigrationEngine(ParamAnalyzer())
    result = engine.migrate()
    assert expected in result
```


***

## Teilnehmeraufgaben mit Lösungshinweisen

### Projekt WetterWeiser

**Aufgabe:**

- Schreibe Unit-Tests für die Methode `jahresstatistik` der Klasse WetterAnalyse.
- Simuliere verschiedene Eingabedatensätze (z.B. mit Pandas DataFrames und Fixtures).
- Überprüfe die Korrektheit der Mittelwert- und Summenberechnung.

**Lösungshinweis:**

- Erzeuge mit pytest-fixtures kleine DataFrames mit typischen und Grenzwerten.
- Setze die DataFrames in der WetterAnalyse-Instanz ein und prüfe mit Assertions die Rückgabewerte.
- Nutze `pytest.approx` für Vergleiche mit Fließkommazahlen.

***

### Projekt PersonalPrinz

**Aufgabe:**

- Schreibe Tests für die Methode `urlaubbuchen` der Klasse Mitarbeiter, inklusive:
    - Standardbuchung,
    - Überbuchung,
    - Randfälle (z.B. genau verbleibende Tage).

**Lösungshinweis:**

- Instanziiere Mitarbeiter mit bewusst gewählten Urlaubswerten.
- Prüfe sowohl korrekte Rückgaben (`True`/`False`) als auch den internen `urlaubgenommen`-Status.

***

### Projekt KeyRecognition

**Aufgabe:**

- Entwickle Tests für die Methode `demodulate` in der Klasse KeySignal.
- Berücksichtige mindestens zwei Modulationsarten (ASK und PSK).
- Prüfe auch, dass bei unbekannter Modulation ein Fehler ausgelöst wird.

**Lösungshinweis:**

- Erzeuge NumPy-Arrays mit typischen IQ-Daten als Dummy-Signale.
- Teste Rückgabedaten (Amplitude/Phase) und erwarte eine Exception mittels `pytest.raises` bei ungültiger Modulation.

***

Alle Aufgaben sind so konzipiert, dass sie mit pytest und standardmäßigen Mitteln ausgeführt und als Kursdemo diskutiert werden können.[^1]

<div style="text-align: center">⁂</div>

[^1]: 00-Schwerpunkte-aller-Module.md

