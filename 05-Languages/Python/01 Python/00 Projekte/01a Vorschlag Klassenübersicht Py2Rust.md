## Übersicht aller zentralen Klassen

- **ProjectLoader** – Kümmert sich um das Einlesen und die Initialisierung von Python-Projekten und deren Verzeichnissen.
- **PythonAnalyzer** – Analysiert Quelltexte: Strukturerkennung von Modulen, Klassen und Funktionen per AST und weitere Code-Inspektionen.
- **MigrationEngine** – Verantwortlich für die eigentliche Transpilation/Migration des Python-Codes nach Rust inklusive Dependency-Mapping.
- **ResultRenderer** – Visualisiert und vergleicht Original und transplierten Code, unterstützt Syntax-Highlighting und Differenzanzeige.
- **FeedbackLogger** – Protokolliert Fehler, Hinweise und manuelle Anpassungen, unterstützt iterative Migration und Nachbearbeitung.

Weitere Module können für Datei-Management, Rust-Kompilierung, Testautomatisierung oder Benutzerverwaltung angebunden werden.

***

## Beispielhafte Implementierung und Zusammenspiel

### Klasse ProjectLoader

```python
class ProjectLoader:
    def __init__(self, pfad):
        self.pfad = pfad
        self.files = []
        
    def load_files(self):
        import os
        for root, dirs, files in os.walk(self.pfad):
            for file in files:
                if file.endswith(".py"):
                    self.files.append(os.path.join(root, file))
        print("Geladene Dateien:", self.files)
```

**Praxisdemo**: Projektstruktur einlesen

```python
loader = ProjectLoader("meineskriptmappe/")
loader.load_files()
```

*Ideal für den Einstieg in größere Codebasen*.

***

### Klasse PythonAnalyzer

```python
import ast

class PythonAnalyzer:
    def __init__(self, file_path):
        with open(file_path, "r", encoding="utf-8") as f:
            self.tree = ast.parse(f.read())
    
    def list_classes(self):
        return [node.name for node in ast.walk(self.tree) if isinstance(node, ast.ClassDef)]
    
    def list_functions(self):
        return [node.name for node in ast.walk(self.tree) if isinstance(node, ast.FunctionDef)]
```

**Praxisdemo**: Klassen und Funktionen erkennen

```python
analyzer = PythonAnalyzer(loader.files)
print("Klassen:", analyzer.list_classes())
print("Funktionen:", analyzer.list_functions())
```

*Im Kurs kann mit echten Beispieldateien iterativ getestet werden*.

***

### Klasse MigrationEngine

```python
class MigrationEngine:
    def __init__(self, analyzer):
        self.analyzer = analyzer
    
    def migrate(self):
        # Platzhalter für eine echte AST-zu-Rust-Transformation.
        print("Migration läuft für:", self.analyzer.list_classes())
        # Rückgabe eines (simulierten) Rust-Codes ...
        return "// Rust-Modul: ...\n"
```

**Praxisdemo**: Migration anstoßen und Resultat ausgeben

```python
engine = MigrationEngine(analyzer)
rust_code = engine.migrate()
print(rust_code)
```

*Erlaubt die didaktische Schritt-für-Schritt-Erklärung von Migrationsregeln und Herausforderungen*.

***

### Klasse ResultRenderer

```python
class ResultRenderer:
    def __init__(self, python_code, rust_code):
        self.python_code = python_code
        self.rust_code = rust_code
    
    def show_diff(self):
        import difflib
        diff = difflib.unified_diff(
            self.python_code.splitlines(), self.rust_code.splitlines(),
            fromfile='python', tofile='rust')
        print('\n'.join(diff))
```

**Praxisdemo**: Unterschiede anzeigen

```python
renderer = ResultRenderer("def foo(): pass", "// fn foo() {}")
renderer.show_diff()
```

*Wichtig für Migrationsevaluierung und für den Kursvergleich OOP/AST-Praxis*.

***

### Klasse FeedbackLogger

```python
class FeedbackLogger:
    def __init__(self):
        self.logs = []
    
    def log(self, msg):
        self.logs.append(msg)
        print("Log:", msg)
```

**Praxisdemo**: Fehler, Hinweise und Nachbearbeitung protokollieren

```python
logger = FeedbackLogger()
logger.log("Klasse konnte nicht automatisch übertragen werden!")
```

*Unterstützt im Kurs iterative Verbesserung und Dokumentation*.

***

## Zusammenspiel der Klassen

- **ProjectLoader** liest die Projektquellen ein, **PythonAnalyzer** verarbeitet diese für die Migration.
- **MigrationEngine** überträgt analysierte Strukturen nach Rust, **ResultRenderer** visualisiert den Unterschied und **FeedbackLogger** dokumentiert alle Schritte.
- Erweiterungen für Mapping-Datenbanken, Fehlertests, GUI, Rust-Kompilierung oder Nutzerinteraktion können modular eingeführt werden.