## Beispiel \& Lösung für das Projekt "Py2Rust" (Dozentenbeispiel)

### Aufgabe 1: Unit Tests für den ProjectLoader

**Aufgabe:**
Schreiben Sie Unit Tests für die Klasse `ProjectLoader`, die Python-Dateien aus einem Verzeichnis einliest.

**Lösung (ausführlich kommentiert):**

```python
# test_projectloader.py
import os
import tempfile
import pytest
from py2rust.projectloader import ProjectLoader

def test_init_sets_path_empty_files():
    """Initialisierung: Pfad wird korrekt gesetzt, Datei-Liste ist leer."""
    loader = ProjectLoader("/my/path")
    assert loader.pfad == "/my/path"
    assert loader.files == []

def test_loadfiles_collects_py_files():
    """Prüft, ob alle .py-Dateien im Verzeichnis rekursiv geladen werden."""
    with tempfile.TemporaryDirectory() as tmpdir:
        # Testdateien anlegen
        pyfile = os.path.join(tmpdir, "main.py")
        txtfile = os.path.join(tmpdir, "ignore.txt")
        with open(pyfile, "w") as f:
            f.write("print('Hallo')")
        with open(txtfile, "w") as f:
            f.write("nichts")
        loader = ProjectLoader(tmpdir)
        loader.loadfiles()
        assert pyfile in loader.files
        assert all(f.endswith(".py") for f in loader.files)
        assert not any(f.endswith(".txt") for f in loader.files)
```

**Erläuterung:**

- Es wird ein Testverzeichnis mit einer .py- und einer .txt-Datei angelegt.
- Nach dem Laden dürfen nur Python-Dateien in der List auftauchen.
- Die Tests sind unabhängig und verwenden keine Produktivdaten.

***

### Aufgabe 2: Test für PythonAnalyzer (AST-Erkennung)

**Aufgabe:**
Testen Sie, ob der `PythonAnalyzer` korrekt alle Klassen in einer Pythondatei findet.

**Lösung (ausführlich, mit Pytest-Pattern):**

```python
# test_pythonanalyzer.py
import tempfile
from py2rust.pythonanalyzer import PythonAnalyzer

def test_list_classes_detects_classes():
    """Prüft die Erkennung von Klassen in einem Python-File."""
    code = "class Alpha:\n    pass\nclass Beta:\n    pass\n"
    with tempfile.NamedTemporaryFile(mode='w', suffix=".py", delete=False) as f:
        f.write(code)
        f.flush()
        analyzer = PythonAnalyzer(f.name)
        classes = analyzer.listclasses()
        assert "Alpha" in classes
        assert "Beta" in classes

def test_list_functions_detects_functions():
    """Prüft die Erkennung von Funktionen."""
    code = "def foo():\n    pass\ndef bar():\n    pass\n"
    with tempfile.NamedTemporaryFile(mode='w', suffix=".py", delete=False) as f:
        f.write(code)
        f.flush()
        analyzer = PythonAnalyzer(f.name)
        functions = analyzer.listfunctions()
        assert "foo" in functions
        assert "bar" in functions
```


***

## Teilnehmeraufgaben: Projektbezogene Übungen (mit Lösungshinweisen)

### Für Projekt WetterWeiser

**Aufgabe 1:**
Schreiben Sie Unit Tests für die Methode `jahresstatistik()` aus der Klasse `WetterAnalyse`. Überlegen Sie, wie Sie Testdaten so gestalten, dass Durchschnitt, Maximal- und Minimalwerte sowie Gesamtniederschlag klar testbar sind.

**Lösungshinweis:**

- Erstellen Sie einen kleinen DataFrame mit festen Wetterdaten (Temperatur, Niederschlag).
- Testen Sie, ob die berechneten Werte den Sollwerten entsprechen.
- Tipp: Nutzen Sie Fixtures zur Erzeugung von Beispieldaten.

***

### Für Projekt PersonalPrinz

**Aufgabe 1:**
Schreiben Sie Unit Tests für die Methode `urlaubbuchen(tage)` der Klasse `Mitarbeiter`. Überprüfen Sie, dass Urlaub nur abgezogen werden kann, wenn genug Kontingent vorhanden ist, und dass der Saldo korrekt angepasst wird.

**Lösungshinweis:**

- Lege ein Mitarbeiter-Objekt mit Initialwerten an.
- Rufe die Methode mehrmals mit unterschiedlichen Werten auf (gültig/ungültig).
- Verwenden Sie `assert`, um den aktuellen Status zu prüfen.

***

### Für Projekt KeyRecognition

**Aufgabe 1:**
Testen Sie die Methode `extract_features()` der Klasse `KeySignal`. Stellen Sie sicher, dass für ein simuliertes Signal die Mittelwerte und Standardabweichungen korrekt als Features geliefert werden.

**Lösungshinweis:**

- Simuliere ein einfaches IQ-Datenarray (z. B. mit NumPy).
- Erzeuge ein Signalobjekt, lasse die Feature-Extraktion laufen.
- Vergleichen Sie die Ergebnisse mit den erwarteten Mittelwerten/Standardabweichungen.
