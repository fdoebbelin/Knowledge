## Kursprojekt: Py2Rust

### Aufgabe: Klassenhierarchie erweitern und Methode überschreiben

**Aufgabenstellung:**
Implementieren Sie eine Klasse `TestableMigrationEngine`, die die Klasse `MigrationEngine` erweitert.

- Überschreiben Sie die Methode `migrate`, so dass nach der Migration automatisch eine Testmethodik angestoßen wird (`run_tests()`).
- Fügen Sie die Methode `run_tests` hinzu, die einen Funktionsaufruf und eine Konsolenausgabe für das Testen simuliert.

**Lösung:**

```python
class MigrationEngine:
    def __init__(self, analyzer):
        self.analyzer = analyzer

    def migrate(self):
        print("Migration läuft für:", self.analyzer.listclasses())
        # ... weitere Migration hier ...
        return "Rust-Code..."

# Erweiterte Klasse mit Überschreibung und Ergänzung
class TestableMigrationEngine(MigrationEngine):
    def migrate(self):
        rust_code = super().migrate()
        self.run_tests()
        return rust_code

    def run_tests(self):
        print("Testausführung für migrierten Rust-Code gestartet ...")
        # Simulierter Test:
        print("Alle Tests bestanden!")

# Demonstration:
analyzer = type("Analyzer", (), {"listclasses": lambda self: ["ProjectLoader", "MigrationEngine"]})()
engine = TestableMigrationEngine(analyzer)
engine.migrate()
```

**Erklärung:**
Die neue Klasse übernimmt alles von `MigrationEngine`, ergänzt jedoch automatische Testlogik nach jedem Migrationsschritt und zeigt den Mehrwert der Erweiterung und des Überschreibens direkt.

***

## Teilnehmerprojekt: WetterWeiser

### Aufgabe: Methoden erweitern und anpassen

**Aufgabenstellung:**

- Erweitern Sie die Klasse `WetterAnalyse` um eine neue Methode `extremwerte()`, welche die heißesten und kältesten Tage als Ausgabe liefert.
- Überschreiben Sie (optional) die Methode `jahresstatistik`, sodass zusätzlich die Tage mit Höchst- und Tiefsttemperatur angezeigt werden.

**Lösungshinweis:**

- Verwenden Sie `self.df['Temperatur'].idxmax()` und `.idxmin()`, um die betreffenden Indizes zu erhalten, und geben Sie mit Datum und Temperaturnennung aus.
- Überschreiben Sie die Methode, indem Sie mit `super().jahresstatistik()` arbeiten und die Zusatzinfos ausgeben.

***

## Teilnehmerprojekt: PersonalPrinz

### Aufgabe: Arbeitszeitmodell flexibel gestalten

**Aufgabenstellung:**

- Erstellen Sie ausgehend von der Klasse `Mitarbeiter` eine Unterklasse `SchichtMitarbeiter`, die ein neues Attribut `schichttyp` erhält.
- Überschreiben Sie die Methode `__repr__`, sodass die Ausgabe neben Name und Personalnummer auch den Schichttyp enthält.

**Lösungshinweis:**

- Konstruktor-Erweiterung mit `super().__init__` aufrufen.
- Die Methode `__repr__` für die eigene Darstellung verwenden – nutzen Sie die Elternklasse-Ausgabe als Basis mit `super().__repr__()`.

***

## Teilnehmerprojekt: KeyRecognition

### Aufgabe: Erweiterung und Überschreibung in Signal-Klassen

**Aufgabenstellung:**

- Leiten Sie die Klasse `LabeledKeySignal` ab und fügen Sie ein Attribut `herkunft` (z. B. "Labor", "Feldtest") hinzu.
- Überschreiben Sie die Methode `__repr__` so, dass die Herkunft zusätzlich erscheint.
- Fügen Sie eine Methode `is_production_sample()` hinzu, die prüft, ob das Signal aus der echten Produktion stammt (herkunft == "Produktiv").

**Lösungshinweis:**

- Attribut beim Initialisieren ergänzen (Konstruktor erweitern).
- Logik für die neue Methode und die angepasste Ausgabe direkt im Objekt zeigen.
