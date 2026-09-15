## Installation (Zelle 1)
```python
!pip install rope
```

## Setup und Imports (Zelle 2)
```python
from rope.base.project import Project
from rope.refactor.extract import ExtractMethod
from rope.refactor.rename import Rename
import os

# Erstelle ein Rope-Projekt im aktuellen Verzeichnis
project = Project('.')
print("Rope-Projekt erstellt ✅")
```

## Beispielcode erstellen (Zelle 3)
```python
# Erstelle eine Datei mit einer zu großen Funktion
example_code = """def calculate_order_total(items, customer_type, discount_code=None):
    # [Hier der große Funktionscode...]
"""

with open('example.py', 'w') as f:
    f.write(example_code)

print("Beispieldatei erstellt ✅")
```

## Schritt-für-Schritt Refactoring (Zelle 4)
```python
# Öffne die Datei
resource = project.get_resource('example.py')
original_code = resource.read()

print("Ursprünglicher Code:")
print("=" * 50)
print(original_code)
```

## Extract Method anwenden (Zelle 5)
```python
# Beispiel: Extrahiere Subtotal-Berechnung
# Wichtig: Genaue Positionen im Code bestimmen
lines = resource.read().split('\n')

# Finde Start- und Endposition für die Extraktion
start_pos = # Berechne Position
end_pos = # Berechne Position

# Führe Extract Method durch
extract = ExtractMethod(project, resource, start_pos, end_pos)
changes = extract.get_changes('calculate_subtotal')

# Zeige Vorschau der Änderungen
print("Vorschau der Änderungen:")
print(changes.get_description())
```

## Änderungen anwenden (Zelle 6)
```python
# Wende die Änderungen an
project.do(changes)

# Zeige den aktualisierten Code
updated_code = resource.read()
print("Aktualisierter Code:")
print("=" * 50)
print(updated_code)
```

## Weitere Refactorings (Zelle 7)
```python
# Wiederhole den Prozess für andere Code-Bereiche:
# - Steuerberechnung
# - Rabattberechnung  
# - Versandkostenberechnung
# [Weitere Extract Method Aufrufe...]
```

## Test der refactorierten Funktionen (Zelle 8)
```python
# Teste die refactorierten Funktionen
exec(open('example.py').read())

test_data = [{'price': 29.99, 'quantity': 2}]
result = calculate_order_total(test_data, 'private')
print(f"Test erfolgreich: {result}")
```

## Projekt schließen (Zelle 9)
```python
# Schließe das Rope-Projekt
project.close()
print("Refactoring abgeschlossen ✅")
```

## Tipps für die Praxis

### 1. Positionsbestimmung
```python
def find_code_positions(code, start_text, end_text):
    lines = code.split('\n')
    start_line = None
    end_line = None

    for i, line in enumerate(lines):
        if start_text in line and start_line is None:
            start_line = i
        if end_text in line and start_line is not None:
            end_line = i + 1
            break

    if start_line is not None and end_line is not None:
        start_pos = sum(len(line) + 1 for line in lines[:start_line])
        end_pos = sum(len(line) + 1 for line in lines[:end_line])
        return start_pos, end_pos
    return None, None
```

### 2. Sichere Refactorings
```python
# Erstelle immer ein Backup vor Refactorings
import shutil
shutil.copy('original.py', 'original_backup.py')

# Verwende try-except für sicherere Refactorings
try:
    changes = extract.get_changes('new_function_name')
    project.do(changes)
    print("Refactoring erfolgreich ✅")
except Exception as e:
    print(f"Fehler beim Refactoring: {e}")
    # Backup wiederherstellen falls nötig
```

### 3. Validierung nach Refactoring
```python
# Überprüfe die Syntax nach jedem Refactoring
import ast

def validate_syntax(filename):
    try:
        with open(filename, 'r') as f:
            ast.parse(f.read())
        print(f"✅ {filename} hat gültige Syntax")
        return True
    except SyntaxError as e:
        print(f"❌ Syntaxfehler in {filename}: {e}")
        return False

validate_syntax('example.py')
```
