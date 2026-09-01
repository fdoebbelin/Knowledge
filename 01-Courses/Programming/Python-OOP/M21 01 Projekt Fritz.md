## Aufgabenstellungen für Py2Rust (M21)

### 1. Klasse zum Einlesen und Parsen von Python-Code

- Entwickle eine Klasse `PythonScript`, die beim Initialisieren Python-Code als String entgegennehmen kann.
- Baue eine Methode, die den Code benutzt, um einen Abstract Syntax Tree (AST) via `ast`-Modul zu erzeugen.
- Ergänze eine Methode, die Funktionsdefinitionen im AST als Liste ausgibt.

***

### 2. Klasse für die Transformation nach Rust

- Entwickle eine Klasse `Py2RustTranspiler`, der ein `PythonScript`-Objekt übergeben wird.
- Schreibe eine Methode, die Funktionsdefinitionen nach Rust-Syntax übersetzt (nur Prototyp, ohne komplexes Typ-Mapping).

***

### 3. Kurzes Beispiel: Demonstriere mit einem einfachen Python-Skript die Funktionsweise des Parsings und der Übersetzung.


***

## Komplette Lösung: OOP-Struktur im Py2Rust-Beispiel

```python
import ast

class PythonScript:
    def __init__(self, code):
        self.code = code
        self.tree = ast.parse(code)
    
    def get_function_defs(self):
        return [node for node in ast.walk(self.tree) if isinstance(node, ast.FunctionDef)]

    def list_functions(self):
        return [f.name for f in self.get_function_defs()]

class Py2RustTranspiler:
    def __init__(self, script):
        self.script = script

    def transpile_functions(self):
        rust_functions = []
        for func in self.script.get_function_defs():
            fn_name = func.name
            args = [a.arg for a in func.args.args]
            # Typen dynamisch, werden hier als i32 angenommen (nur zu Demonstrationszwecken)
            rust_args = ', '.join([f"{a}: i32" for a in args])
            body = "// ... Funktionskörper übersetzt ..."  # Platzhalter
            rust_func = f"fn {fn_name}({rust_args}) -> i32 {{\n    {body}\n}}"
            rust_functions.append(rust_func)
        return '\n\n'.join(rust_functions)

# Beispiel: Einfaches Python-Skript
py_code = '''
def addiere(a, b):
    return a + b

def quadriere(x):
    return x * x
'''

# Anwendung der OOP-Lösung
script = PythonScript(py_code)
print("Gefundene Funktionen:", script.list_functions())
transpiler = Py2RustTranspiler(script)
print("Rust-Version:\n", transpiler.transpile_functions())
```


***

### Ergebnis beim Ausführen des Beispiels

```
Gefundene Funktionen: ['addiere', 'quadriere']
Rust-Version:
 fn addiere(a: i32, b: i32) -> i32 {
    // ... Funktionskörper übersetzt ...
}

fn quadriere(x: i32) -> i32 {
    // ... Funktionskörper übersetzt ...
}
```


***

## Weiterer didaktischer Nutzen

- Die Lösung illustriert schrittweise das Kapseln von Verhalten und Daten.
- Sie zeigt, wie aus einem funktionsorientierten Python-Programm durch OOP-Ansatz einfach test- und erweiterbarer Code wird.
- Eine Übertragung Richtung Rust (vgl. „00 Python to Rust Migration“) kann für Fortgeschrittene als Transferaufgabe angefügt werden.
