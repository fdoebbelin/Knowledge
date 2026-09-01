Hier ist eine umfassende Aufgabenstellung zum Thema **Grundlegende Ausnahmebehandlung in OOP (M23)** für das Projekt **Py2Rust** (Fritz), inklusive einer ausführbaren Lösung. Die Beispiele orientieren sich an typischen Py2Rust-Klassendesigns (siehe beigefügte Klassenübersicht) und greifen Use Cases rund um Fehlererkennung, Logging und Robustheit im Migrations-Workflow auf.[^1][^2]

***

## Aufgabenstellung (Fritz – Py2Rust-Projekt)

**1. Aufgabe:**
Erweitere die Klasse `MigrationEngine`, sodass bei der Migration folgende Fehlerfälle sauber behandelt und protokolliert werden:

- Wenn die übergebene Analyse keine Klassen enthält, soll eine eigene Exception `NoClassesFoundError` ausgelöst werden.
- Schlägt die Migration aus technischen Gründen fehl (z.B. fehlerhafter AST), soll ein generischer Fehler abgefangen und ein Hinweis geloggt werden.
- Ergänze eine Wiederherstellungsaktion im `finally`-Block, die einen Status-Log hinterlässt ("Migration abgeschlossen – Fehler oder Erfolg").

**2. Aufgabe:**
Implementiere eine Exception-Hierarchie für den Migrationsteil:

- Erstelle `MigrationException` als Basisklasse.
- Leite davon `NoClassesFoundError` und `MigrationFailedError` ab.

**3. Aufgabe:**
Passe den `FeedbackLogger` so an, dass alle Exception-Nachrichten automatisch geloggt werden.

**4. Aufgabe:**
Schreibe ein Test-Skript, das die Migration mit verschiedenen Eingaben (Klassen vorhanden/fehlerhafter AST/kein Python-Code) simuliert und die Exception-Logik demonstriert.

***

## Hinweis zur Umsetzung

- Nutze die empfohlenen Klassennamen und deren Zusammenspiel gemäß beigefügter Struktur.[^2]
- Zeige alle try/except/else/finally-Blöcke in ausführlicher Praxisanwendung.
- Die Lösung muss direkt lauffähig und schrittweise erklärbar sein.

***

## Lösung für den Dozenten (ausführbare Demo inkl. Logging)

```python
# Exception-Hierarchie für Migration
class MigrationException(Exception):
    """Basis-Exception für Migrationsfehler."""
    pass

class NoClassesFoundError(MigrationException):
    """Ausgelöst, wenn keine zu konvertierenden Python-Klassen gefunden wurden."""
    pass

class MigrationFailedError(MigrationException):
    """Generischer Fehler während der Migration."""
    pass

# FeedbackLogger erweitert mit auto-logging für Exceptions
class FeedbackLogger:
    def __init__(self):
        self.logs = []
    def log(self, msg):
        self.logs.append(msg)
        print("Log:", msg)
    def log_exception(self, exception):
        msg = f"Exception: {type(exception).__name__} - {exception}"
        self.log(msg)

# MigrationEngine mit robuster Fehlerbehandlung
class MigrationEngine:
    def __init__(self, analyzer, logger):
        self.analyzer = analyzer
        self.logger = logger

    def migrate(self):
        try:
            classes = self.analyzer.list_classes()
            if not classes:
                raise NoClassesFoundError("Keine Klassen für Migration gefunden.")

            # Simulierter Migrationsfehler für Demonstration
            if hasattr(self.analyzer, "force_fail") and self.analyzer.force_fail:
                raise MigrationFailedError("Technischer Fehler beim AST-Processing!")

            # Erfolgsfall
            rust_code = f"// Rust-Klassen: {', '.join(classes)}"
            self.logger.log(f"Migration OK für Klassen: {classes}")
            return rust_code

        except MigrationException as e:
            self.logger.log_exception(e)
        except Exception as e:
            self.logger.log_exception(MigrationFailedError("Unbekannter Fehler: " + str(e)))
        else:
            self.logger.log("Migration erfolgreich, keine Fehler erkannt.")
        finally:
            self.logger.log("Migration abgeschlossen – Fehler oder Erfolg.")

        return None

# Mock-PythonAnalyzer zur Simulation verschiedener Fälle
class PythonAnalyzer:
    def __init__(self, classes=None, force_fail=False):
        self._classes = classes or []
        self.force_fail = force_fail

    def list_classes(self):
        return self._classes

# Demo: Verschiedene Testfälle für die Migration
logger = FeedbackLogger()

print("\n--- Testfall: Erfolgreiche Migration ---")
analyzer_ok = PythonAnalyzer(classes=["MyClass"])
engine_ok = MigrationEngine(analyzer_ok, logger)
result_ok = engine_ok.migrate()

print("\n--- Testfall: Keine Klassen ---")
analyzer_empty = PythonAnalyzer(classes=[])
engine_empty = MigrationEngine(analyzer_empty, logger)
result_empty = engine_empty.migrate()

print("\n--- Testfall: Technischer Migrationsfehler ---")
analyzer_fail = PythonAnalyzer(classes=["BrokenClass"], force_fail=True)
engine_fail = MigrationEngine(analyzer_fail, logger)
result_fail = engine_fail.migrate()
```


***

### Was lernt das Team/Fritz hierbei?

- **Exception-Hierarchien sorgen für gezielte Fehlerdiskriminierung** (z.B. domänenspezifisch für Migration).
- **Logging und Feedback werden in jedem Ablauf garantiert** – egal ob Erfolg oder Fehler („finally“).
- **Sämtliche Fehlerfälle – inkl. „edge cases“ – sind reproduzierbar und verständlich dokumentiert.**
- **Das System bleibt robust, erweiterbar und lässt sich didaktisch ideal Schritt für Schritt im Kurs besprechen.**

***

Diese Aufgabenstellung und Lösung sind direkt auf das Py2Rust-Projekt anwendbar und bereichern sowohl die praktische als auch die didaktische Perspektive optimal.[^1][^2]
<span style="display:none">[^3]</span>

<div style="text-align: center">⁂</div>

[^1]: 01-Projekt-Fritz-Py2Rust.md

[^2]: 01a-Vorschlag-Klassenubersicht-Py2Rust.md

[^3]: 01b-Py2Rust-README.md

