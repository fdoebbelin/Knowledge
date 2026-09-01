## Aufgaben \& Lösungen für das Dozentenprojekt "Py2Rust"

### 1. Aufgabe: Debugging beim Bibliotheks-Mapping

**Aufgabe:**
Implementieren Sie eine Python-Funktion zum automatischen Mapping von Bibliotheksnamen (z.B. `"pandas"` zu `"polars"`) und nutzen Sie `pdb` gezielt, um Fehler beim Mapping zu lokalisieren.
Lösung:

```python
import pdb

def python_to_rust_crate(python_lib):
    pdb.set_trace()  # Start Debugging
    mapping = {
        "numpy": "ndarray",
        "pandas": "polars",
        "requests": "reqwest",
        "sqlalchemy": "diesel",
    }
    try:
        return mapping[python_lib]
    except KeyError:
        print(f"Kein Mapping für {python_lib}")
        return None

# Testfälle
libs = ["pandas", "unknown", "requests"]
for lib in libs:
    print(f"{lib} --> {python_to_rust_crate(lib)}")
```

*Kommentierte Lösung zeigt Fehlerbehandlung und Breakpoints für didaktische Demonstration.*

### 2. Aufgabe: AST-Analyse debuggen

**Aufgabe:**
Nutzen Sie einen Breakpoint bei der Strukturerkennung (Klassen/Funktionen) in einem Python-Projekt.
Lösung (Auszug):

```python
import ast
import pdb

def list_classes_and_functions(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        tree = ast.parse(f.read())
    pdb.set_trace()  # Analysepunkt
    return [node.name for node in ast.walk(tree) if isinstance(node, ast.ClassDef)], \
           [node.name for node in ast.walk(tree) if isinstance(node, ast.FunctionDef)]
```

*Kursdemonstration: Das Verhalten bei unterschiedlichen Dateiinhalten kann schrittweise erläutert werden.*

***

## Teilnehmeraufgaben zu den Modulen

### Für "WetterWeiser" (Projekt Christian)

- **Praxisaufgabe:** Setzen Sie einen bedingten Breakpoint, um fehlerhafte Werte beim Import von Wetterdaten zu identifizieren.
- **Lösungshinweis:** In der Einlesemethode per `pdb.set_trace()` unterbrechen, wenn Werte außerhalb der erlaubten Grenzen liegen (z.B. Temperatur < -50 oder > 60).


### Für "PersonalPrinz" (Projekt Christopher)

- **Praxisaufgabe:** Debuggen Sie eine Methode zur Urlaubsbuchung. Setzen Sie einen Breakpoint, der nur ausgelöst wird, wenn der Resturlaub unter 0 fällt.
- **Lösungshinweis:** `[pdb.set_trace()]` innerhalb der Methode platzieren und die Bedingungen prüfen.


### Für "KeyRecognition" (Projekt Tristan)

- **Praxisaufgabe:** Fügen Sie einen Breakpoint in die Demodulationsmethode ein, der automatisch ausgelöst wird, wenn der Signalwert `NaN` enthält oder eine NotImplementedError entsteht.
- **Lösungshinweis:** Überprüfen Sie im Code, ob `np.isnan()` für Daten zutrifft und setzen Sie dann den Debugger.
