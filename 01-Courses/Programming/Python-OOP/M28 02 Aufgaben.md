## Aufgaben \& kommentierte Lösungen (für das Dozentenprojekt „Py2Rust“)

### Aufgabe 1: Polymorphes AST-Rendering

**Aufgabenstellung:**
Implementieren Sie eine Basisklasse `AstNodeRenderer` mit einer Methode `render(node)` und leiten Sie mindestens zwei spezialisierte Renderer davon ab: einen für Python-Knoten und einen für Rust-Knoten. Demonstrieren Sie Polymorphismus durch eine gemeinsame Funktionsschnittstelle.

**Lösung:**

```python
class AstNodeRenderer:
    def render(self, node):
        raise NotImplementedError("Muss in Unterklasse implementiert werden.")

class PythonAstRenderer(AstNodeRenderer):
    def render(self, node):
        print(f"Python-Node: {node}")

class RustAstRenderer(AstNodeRenderer):
    def render(self, node):
        print(f"Rust-Node: {node}")

def zeige_node(renderer: AstNodeRenderer, node):
    renderer.render(node)

# Test
py_renderer = PythonAstRenderer()
rs_renderer = RustAstRenderer()
zeige_node(py_renderer, "def foo(): pass")  # Python-Node: def foo(): pass
zeige_node(rs_renderer, "fn foo() {}")      # Rust-Node: fn foo() {}
```

**Kommentierung:**
Hier sorgen die Klassen für unterschiedliche Renderings, je nach Objekttyp: Der Funktionsaufruf bleibt universell, das Verhalten unterscheidet sich polymorph.

***

### Aufgabe 2: Migrationseinträge unterschiedlich protokollieren

**Aufgabenstellung:**
Erstellen Sie eine Basisklasse `MigrationLogger` mit einer Methode `log_entry(entry)`. 
Leiten Sie zwei Varianten ab: eine protokolliert nach Konsole, eine nach Datei. 
Wenden Sie Polymorphismus beim Logging innerhalb eines Migrations-Durchlaufs an.

**Lösung:**

```python
class MigrationLogger:
    def log_entry(self, entry):
        raise NotImplementedError()

class ConsoleLogger(MigrationLogger):
    def log_entry(self, entry):
        print("[Konsole]", entry)

class FileLogger(MigrationLogger):
    def __init__(self, filename):
        self.filename = filename
    def log_entry(self, entry):
        with open(self.filename, "a", encoding="utf-8") as f:
            f.write(entry + "\n")

def laufen_lassen(logger: MigrationLogger, entries):
    for entry in entries:
        logger.log_entry(entry)

# Test
konsole = ConsoleLogger()
datei = FileLogger("migration.log")
laufen_lassen(konsole, ["Start", "Analyse", "Fertig"])
laufen_lassen(datei, ["Start", "Analyse", "Fertig"])
```

**Kommentierung:**
Beide Logger-Objekte werden über die gleiche Schnittstelle gesteuert. Die konkrete Ausführung wird erst zur Laufzeit entschieden – ein klassischer Anwendungsfall für Polymorphismus.

***

### Aufgabe 3: Unterschiedliche Migrations-Strategien anwenden

**Aufgabenstellung:**
Definieren Sie eine abstrakte Klasse `MigrationStrategy` mit einer Methode `migrate(code)`. Implementieren Sie mindestens zwei Strategieklassen (z. B. für automatische und manuelle Migration) und zeigen Sie den Einsatz durch Polymorphismus.

**Lösung:**

```python
class MigrationStrategy:
    def migrate(self, code):
        raise NotImplementedError()

class AutoMigration(MigrationStrategy):
    def migrate(self, code):
        print("Automatische Migration:", code)

class ManualMigration(MigrationStrategy):
    def migrate(self, code):
        print("Manuelle Migration, Eingriff nötig:", code)

def migration_durchfuehren(strategy: MigrationStrategy, code):
    strategy.migrate(code)

# Test
auto = AutoMigration()
manuell = ManualMigration()
migration_durchfuehren(auto, "print('hello')")
migration_durchfuehren(manuell, "eval('code')")  
```


***

## Aufgaben für Teilnehmerprojekte

### WetterWeiser

- **Aufgabe:** Entwickeln Sie eine Klasse `Messinstrument`, die eine Methode `messe()` bereitstellt. Implementieren Sie davon abgeleitete Klassen für unterschiedliche Messgeräte (z.B. `Thermometer`, `Regenmesser`), die jeweils `messe()` verschieden umsetzen.
*Lösungshinweis:* Verwenden und demonstrieren Sie Polymorphismus, indem verschiedene Messgeräte in einer gemeinsamen Schleife ausgelesen werden.


### PersonalPrinz

- **Aufgabe:** Fügen Sie der Klasse `Mitarbeiter` alternative Arbeitszeiterfasser hinzu, indem Sie eine gemeinsame Basisklasse oder Schnittstelle für Zeiterfassungsarten entwerfen (z. B. `ZeiterfassungManuell`, `ZeiterfassungAutomatisch`). Simulieren Sie das polymorphe Verhalten in einer Auswertungsfunktion.
*Lösungshinweis:* Zeigen Sie, wie eine Liste von Zeiterfassungsobjekten über eine gemeinsame Methode abgefragt werden kann.


### KeyRecognition

- **Aufgabe:** Erweitern Sie die Signalverarbeitung um unterschiedliche Demodulator-Klassen (`AskDemodulator`, `PskDemodulator`), die eine gemeinsame Schnittstelle bereitstellen. Nutzen Sie Polymorphismus, um beliebige Demodulatoren in eine Analysepipeline einzufügen.
*Lösungshinweis:* Schreiben Sie eine Funktion, die ein beliebiges Demodulatorobjekt verwendet, ohne seinen genauen Typ zu kennen.
