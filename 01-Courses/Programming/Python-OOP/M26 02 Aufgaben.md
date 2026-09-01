## Aufgaben \& Lösungen für das Projekt "Py2Rust" (Dozent/Demonstration)

### Aufgabe 1: Basisklasse und abgeleitete Klasse

**Auftrag:**
Implementiere eine Basisklasse `TranspilerTool` mit dem Attribut `name` und einer Methode `beschreibung()`. Leite davon je ein Unterklasse für "PyCrust" und "Depyler" ab, die die Beschreibungsmethode überschreiben.

```python
class TranspilerTool:
    def __init__(self, name):
        self.name = name
    def beschreibung(self):
        return f"{self.name}: Allgemeines Transpiler-Tool"

class PyCrust(TranspilerTool):
    def __init__(self):
        super().__init__("PyCrust")
    def beschreibung(self):
        return f"{self.name}: ChatGPT-basierter Python-zu-Rust-Transpiler"

class Depyler(TranspilerTool):
    def __init__(self):
        super().__init__("Depyler")
    def beschreibung(self):
        return f"{self.name}: Energieeffizienter Python-zu-Rust-Transpiler mit Verifikationsmodus"

# Test:
tools = [PyCrust(), Depyler()]
for tool in tools:
    print(tool.beschreibung())
```

_Erwartete Ausgabe:_
PyCrust: ChatGPT-basierter Python-zu-Rust-Transpiler
Depyler: Energieeffizienter Python-zu-Rust-Transpiler mit Verifikationsmodus

***

### Aufgabe 2: Erweiterung und Anwendung von super()

**Auftrag:**
Erweitere die Basisklasse um ein Attribut `version` und demonstriere die Initialisierung per `super()`.

```python
class TranspilerTool:
    def __init__(self, name, version):
        self.name = name
        self.version = version

class PyCrust(TranspilerTool):
    def __init__(self, version):
        super().__init__("PyCrust", version)

tool = PyCrust("2.0")
print(tool.name, tool.version)  # Ausgabe: PyCrust 2.0
```

_Dieses Muster kann auf alle weiteren spezialisierten Tools aus dem Projekt angewendet werden._

***

## Aufgabenstellungen für Teilnehmer-Projekte

### WetterWeiser (Projekt Christian)

- **Aufgabe:** Entwickle eine Basisklasse `Messdaten` mit einer Methode `mittelwert()`, davon abgeleitet die Klasse `Temperaturdaten`, die das Verhalten überschreibt und explizit "Temperatur-Mittelwert" berechnet.
**Hinweis:** Nutze pandas für numerische Statistiken und teste mit echten CSV-Daten.

***

### PersonalPrinz (Projekt Christopher)

- **Aufgabe:** Implementiere ein Vererbungsschema für Arbeitszeitmodelle: Erstelle eine Basisklasse `Arbeitsmodell` und mindestens zwei abgeleitete Spezialklassen (`Vollzeit`, `Teilzeit`). Jede Modellklasse soll die Methode `urlaubsanspruch()` passend überschreiben.
**Hinweis:** Der Konstruktor der Basisklasse sollte via `super()` in den Kindklassen aufgerufen werden.

***

### KeyRecognition (Projekt Tristan)

- **Aufgabe:** Ergänze das OOP-Modell um eine neue abgeleitete Klasse von `KeySignal`, zum Beispiel `TestKeySignal`, die neben den Basisfunktionen eine zusätzliche Methode zur automatischen Fehlerkennzeichnung einführt.
**Hinweis:** Achte auf sinnvolle Nutzung von Vererbung und, falls sinnvoll, auf Überschreiben bestehender Methoden.
