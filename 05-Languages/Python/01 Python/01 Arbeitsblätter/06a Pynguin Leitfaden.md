## Was ist Pynguin?

- **PY**tho**N** **G**eneral **U**n**I**t test ge**N**erator
- Automatisierte Unit-Test-Generierung für Python-Code
- Nutzt evolutionäre Algorithmen und Bytecode-Instrumentation
- Forschungsprototyp, nicht für Produktionsumgebungen gedacht
- Erreicht hohe Code-Coverage durch suchbasierte Testgenerierung
## Installation mit uv

```bash
# uv installieren (falls noch nicht vorhanden)
# ohne Python
# macOS + Linux
curl -LsSf https://astral.sh/uv/install.sh | sh
# Windows
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
# als Python-Paket
pip install uv

# Virtual Environment erstellen
uv venv pynguin_env
source pynguin_env/bin/activate  # Linux/Mac
# oder: pynguin_env\Scripts\activate  # Windows

# Pynguin installieren
uv pip install pynguin
```
## Kritische Sicherheitshinweise

- **⚠️ Pynguin führt den zu testenden Code aus!**
- Potentielles Sicherheitsrisiko durch Codeausführung
- Pflicht-Umgebungsvariable setzen:

```bash
export PYNGUIN_DANGER_AWARE=1  # Linux/Mac
set PYNGUIN_DANGER_AWARE=1     # Windows
```
## Konkrete Beispiele für verschiedene Code-Typen

### Beispiel 1: Einfache Funktionen (triangle.py)

**Eingabe-Code:**

```python
# triangle.py
def triangle(x: int, y: int, z: int) -> str:
    """Bestimmt den Typ eines Dreiecks basierend auf Seitenlängen."""
    if x <= 0 or y <= 0 or z <= 0:
        return "Invalid triangle"
    if x == y == z:
        return "Equilateral triangle"
    if x in {y, z} or y == z:
        return "Isosceles triangle"
    return "Scalene triangle"

def calculate_area(base: float, height: float) -> float:
    """Berechnet die Fläche eines Dreiecks."""
    if base <= 0 or height <= 0:
        raise ValueError("Base and height must be positive")
    return 0.5 * base * height
```

**Pynguin-Kommando:**

```bash
# macOS
export PYNGUIN_DANGER_AWARE=1
# oder für die PowerShell
$env:PYNGUIN_DANGER_AWARE=1 
pynguin --project-path . --module-name triangle --output-path ./tests -v
```

**Generierter Test (Beispiel):**

```python
# test_triangle.py
import unittest
from triangle import triangle, calculate_area

class TestTriangle(unittest.TestCase):
    def test_triangle_0(self):
        # Test für gleichseitiges Dreieck
        result = triangle(5, 5, 5)
        self.assertEqual(result, "Equilateral triangle")
    
    def test_triangle_1(self):
        # Test für gleichschenkliges Dreieck
        result = triangle(3, 3, 4)
        self.assertEqual(result, "Isosceles triangle")
    
    def test_triangle_2(self):
        # Test für unregelmäßiges Dreieck
        result = triangle(3, 4, 5)
        self.assertEqual(result, "Scalene triangle")
    
    def test_calculate_area_0(self):
        # Test normale Berechnung
        result = calculate_area(10.0, 5.0)
        self.assertEqual(result, 25.0)
    
    def test_calculate_area_raises(self):
        # Test Exception
        with self.assertRaises(ValueError):
            calculate_area(-1.0, 5.0)
```

**Unittests ausführen**

```sh
PYTHONPATH=. pytest tests
# oder PowerShell, 2 Zeilen und Verzeichnis als String
$env:PYTHONPATH = "."
pytest
```

### Beispiel 2: Klassen mit Zustand (calculator.py)

**Eingabe-Code:**

```python
# calculator.py
class Calculator:
    def __init__(self, precision: int = 2):
        self.precision = precision
        self.history = []
        self.memory = 0.0
    
    def add(self, a: float, b: float) -> float:
        result = round(a + b, self.precision)
        self.history.append(f"{a} + {b} = {result}")
        return result
    
    def divide(self, a: float, b: float) -> float:
        if b == 0:
            raise ValueError("Division by zero")
        result = round(a / b, self.precision)
        self.history.append(f"{a} / {b} = {result}")
        return result
    
    def store_memory(self, value: float) -> None:
        self.memory = value
    
    def recall_memory(self) -> float:
        return self.memory
    
    def clear_history(self) -> None:
        self.history.clear()
    
    def get_history(self) -> list[str]:
        return self.history.copy()
```

**Pynguin-Kommando mit erweiterten Optionen:**

```bash
pynguin --project-path . \
        --module-name calculator \
        --output-path ./tests \
        --algorithm MIO \
        --max-time 300 \
        --coverage-metrics BRANCH LINE \
        --create-coverage-report true \
        --verbose
```

**Generierter Test (Beispiel):**

```python
# test_calculator.py
import unittest
from calculator import Calculator

class TestCalculator(unittest.TestCase):
    def test_calculator_0(self):
        # Test Initialisierung
        calc = Calculator()
        self.assertEqual(calc.precision, 2)
        self.assertEqual(calc.memory, 0.0)
        self.assertEqual(len(calc.history), 0)
    
    def test_add_0(self):
        # Test Addition mit History
        calc = Calculator(precision=1)
        result = calc.add(2.5, 3.7)
        self.assertEqual(result, 6.2)
        self.assertEqual(len(calc.get_history()), 1)
        self.assertIn("2.5 + 3.7 = 6.2", calc.get_history())
    
    def test_divide_raises(self):
        # Test Division durch Null
        calc = Calculator()
        with self.assertRaises(ValueError):
            calc.divide(10.0, 0.0)
    
    def test_memory_operations(self):
        # Test Memory-Funktionen
        calc = Calculator()
        calc.store_memory(42.5)
        recalled = calc.recall_memory()
        self.assertEqual(recalled, 42.5)
```
### Beispiel 3: Komplexe Datenstrukturen (queue.py)

**Eingabe-Code:**

```python
# queue.py
from typing import Optional, Any

class Queue:
    def __init__(self, max_size: int = 10):
        self.max_size = max_size
        self.items = []
        self.head = 0
        self.tail = 0
        self.size = 0
    
    def enqueue(self, item: Any) -> bool:
        if self.is_full():
            return False
        self.items.append(item)
        self.tail += 1
        self.size += 1
        return True
    
    def dequeue(self) -> Optional[Any]:
        if self.is_empty():
            return None
        item = self.items[self.head]
        self.head += 1
        self.size -= 1
        return item
    
    def peek(self) -> Optional[Any]:
        if self.is_empty():
            return None
        return self.items[self.head]
    
    def is_empty(self) -> bool:
        return self.size == 0
    
    def is_full(self) -> bool:
        return self.size >= self.max_size
    
    def clear(self) -> None:
        self.items.clear()
        self.head = 0
        self.tail = 0
        self.size = 0
```

**Pynguin-Kommando mit TOML-Konfiguration:**

```toml
# pynguin.toml
[algorithm]
algorithm = "DYNAMOSA"
max_time = 180
seed = 42

[coverage]
coverage_metrics = ["BRANCH", "LINE"]
create_coverage_report = true
report_dir = "./coverage-reports"

[output]
test_case_output = "PYTEST"
maximum_length_test_case = 15
```

```bash
pynguin @pynguin.toml --module-name queue
```

**Generierter Test (Beispiel):**

```python
# test_queue.py
import pytest
from queue import Queue

def test_queue_initialization():
    q = Queue(5)
    assert q.max_size == 5
    assert q.is_empty() == True
    assert q.is_full() == False

def test_enqueue_dequeue_sequence():
    q = Queue(3)
    # Enqueue Tests
    assert q.enqueue("first") == True
    assert q.enqueue("second") == True
    assert q.size == 2
    
    # Dequeue Tests
    item = q.dequeue()
    assert item == "first"
    assert q.size == 1
    
    item = q.dequeue()
    assert item == "second"
    assert q.is_empty() == True

def test_queue_overflow():
    q = Queue(2)
    assert q.enqueue(1) == True
    assert q.enqueue(2) == True
    assert q.is_full() == True
    assert q.enqueue(3) == False  # Should fail

def test_peek_functionality():
    q = Queue()
    assert q.peek() == None
    q.enqueue("test")
    assert q.peek() == "test"
    assert q.size == 1  # Peek shouldn't change size
```
## Praktische Workflows mit Beispielen

### Workflow 1: Legacy Code Bootstrap

**Szenario:** Existierender Code ohne Tests

```python
# legacy_math.py - Alter Code ohne Tests
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

def factorial(n):
    if n <= 1:
        return 1
    result = 1
    for i in range(2, n + 1):
        result *= i
    return result

def prime_check(n):
    if n < 2:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True
```

**Kommando:**

```bash
export PYNGUIN_DANGER_AWARE=1
pynguin --project-path . --module-name legacy_math --output-path ./tests --algorithm RANDOM --max-time 120 -v
```
### Workflow 2: Batch-Verarbeitung für Projekt

**Projektstruktur:**

```
myproject/
├── utils.py
├── database.py
├── validators.py
└── tests/ (wird erstellt)
```

**Batch-Script:**

```bash
#!/bin/bash
export PYNGUIN_DANGER_AWARE=1

MODULES=("utils" "database" "validators")
for MODULE in "${MODULES[@]}"; do
    echo "🔍 Generiere Tests für $MODULE..."
    pynguin --project-path . \
            --module-name $MODULE \
            --output-path ./tests \
            --algorithm DYNAMOSA \
            --max-time 180 \
            --create-coverage-report true \
            --verbose
    echo "✅ Tests für $MODULE abgeschlossen"
done

echo "🎯 Alle Tests generiert. Coverage-Reports in ./pynguin-report/"
```
### Workflow 3: CI/CD Integration

**GitHub Actions Beispiel:**

```yaml
# .github/workflows/pynguin-tests.yml
name: Pynguin Test Generation
on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  generate-tests:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install uv and dependencies
      run: |
        pip install uv
        uv venv .venv
        source .venv/bin/activate
        uv pip install pynguin pytest pytest-cov
    
    - name: Generate tests for core module
      env:
        PYNGUIN_DANGER_AWARE: 1
      run: |
        source .venv/bin/activate
        pynguin --project-path . \
                --module-name src.core \
                --output-path ./generated_tests \
                --max-time 300 \
                --algorithm DYNAMOSA \
                --create-coverage-report true
    
    - name: Run generated tests
      run: |
        source .venv/bin/activate
        pytest generated_tests/ -v --cov=src.core
    
    - name: Upload coverage reports
      uses: actions/upload-artifact@v3
      with:
        name: pynguin-coverage
        path: pynguin-report/
```
## Debugging und Troubleshooting mit Beispielen

### Problem: Keine Tests generiert

**Problematischer Code:**

```python
# broken_module.py
import requests  # Externe Abhängigkeit
import numpy as np  # Native Library

def download_data():
    response = requests.get("https://api.example.com/data")
    return response.json()

def process_array(data):
    arr = np.array(data)
    return arr.mean()
```

**Lösung - Refactored Code:**

```python
# fixed_module.py
from typing import List, Dict, Any

def download_data(url: str = "https://api.example.com/data") -> Dict[str, Any]:
    """Downloadfunktion - besser testbar mit Dependency Injection"""
    # In Tests kann URL überschrieben werden
    pass

def process_array(data: List[float]) -> float:
    """Verarbeitung ohne numpy - Pynguin-freundlich"""
    if not data:
        raise ValueError("Empty data list")
    return sum(data) / len(data)

def validate_data(data: List[float]) -> bool:
    """Validierungsfunktion mit klaren Type Hints"""
    return all(isinstance(x, (int, float)) for x in data)
```

**Pynguin-Kommando mit Debug-Output:**

```bash
pynguin --project-path . \
        --module-name fixed_module \
        --output-path ./tests \
        -vv \
        --log-file debug.log \
        --create-coverage-report true
```
### Verbose Output Interpretation

**Beispiel Console Output:**

```
🐧 Pynguin v0.40.0
📁 Project path: /home/user/project
🎯 Module: fixed_module
⚙️  Algorithm: DYNAMOSA
⏱️  Time budget: 600s

Generation 1/100:
  Tests created: 5
  Coverage: 45% (9/20 lines)
  
Generation 25/100:
  Tests created: 12
  Coverage: 78% (15/20 lines)
  
Generation 67/100:
  Tests created: 18
  Coverage: 95% (19/20 lines)
  
✅ Final result:
   Generated tests: 18
   Line coverage: 95%
   Branch coverage: 89%
   Time used: 245s
```
## Performance-Optimierung mit konkreten Zeitmessungen

### Algorithmus-Vergleich am Beispiel

**Test-Modul (complex_logic.py):**

```python
def complex_calculator(a: int, b: int, operation: str) -> float:
    """Komplexe Berechnungsfunktion mit vielen Zweigen"""
    if operation == "add":
        return float(a + b)
    elif operation == "subtract":
        return float(a - b)
    elif operation == "multiply":
        if a == 0 or b == 0:
            return 0.0
        return float(a * b)
    elif operation == "divide":
        if b == 0:
            raise ValueError("Division by zero")
        return float(a / b)
    elif operation == "power":
        if a < 0 and b < 0:
            return float(1 / (abs(a) ** abs(b)))
        return float(a ** b)
    else:
        raise ValueError(f"Unknown operation: {operation}")
```

**Performance-Vergleich:**

```bash
# Schnell (30s) - RANDOM
time pynguin --project-path . --module-name complex_logic --output-path ./tests_random --algorithm RANDOM --max-time 30
# Ergebnis: ~60% Coverage in 25s

# Standard (120s) - DYNAMOSA  
time pynguin --project-path . --module-name complex_logic --output-path ./tests_dynamosa --algorithm DYNAMOSA --max-time 120
# Ergebnis: ~85% Coverage in 95s

# Intensiv (300s) - MIO
time pynguin --project-path . --module-name complex_logic --output-path ./tests_mio --algorithm MIO --max-time 300
# Ergebnis: ~95% Coverage in 275s
```
## Integration mit bestehenden Projekten

### Beispiel: Django Model Testing

**Django Model:**

```python
# models.py
from django.db import models
from typing import Optional

class User:
    """Vereinfachtes User-Model ohne Django Dependencies für Pynguin"""
    def __init__(self, username: str, email: str, age: int):
        self.username = username
        self.email = email
        self.age = age
        self.is_active = True
    
    def activate(self) -> None:
        self.is_active = True
    
    def deactivate(self) -> None:
        self.is_active = False
    
    def is_adult(self) -> bool:
        return self.age >= 18
    
    def update_email(self, new_email: str) -> bool:
        if "@" not in new_email:
            return False
        self.email = new_email
        return True
```

**Generierter Test:**

```python
def test_user_initialization():
    user = User("testuser", "test@example.com", 25)
    assert user.username == "testuser"
    assert user.is_active == True

def test_user_activation():
    user = User("user", "email@test.com", 20)
    user.deactivate()
    assert user.is_active == False
    user.activate()
    assert user.is_active == True

def test_email_validation():
    user = User("user", "old@example.com", 30)
    assert user.update_email("invalid-email") == False
    assert user.update_email("new@example.com") == True
    assert user.email == "new@example.com"
```
## Nachbearbeitung generierter Tests

### Vor der Bearbeitung (Roh-Output):

```python
def test_case_0(self):
    var_0 = Calculator()
    var_1 = var_0.add(542.324234, -234.234)
    self.assertEqual(var_1, 308.09)
```
### Nach der Bearbeitung (Lesbarer Test):

```python
def test_calculator_addition_with_negative_number(self):
    """Test addition of positive and negative numbers with default precision."""
    calculator = Calculator()
    result = calculator.add(542.32, -234.23)
    self.assertEqual(result, 308.09)
    
    # Verify operation was logged in history
    history = calculator.get_history()
    self.assertEqual(len(history), 1)
    self.assertIn("542.32 + -234.23 = 308.09", history[^0])
```
## Fazit mit konkreten Empfehlungen

### Wann Pynguin nutzen:

- **Legacy-Code ohne Tests:** Schneller Bootstrap von Testabdeckung
- **Komplexe Algorithmen:** Entdeckung von Edge Cases
- **Regressions-Tests:** Schutz vor ungewollten Änderungen
- **CI/CD Integration:** Automatische Testgenerierung bei Code-Änderungen
### Wann nicht nutzen:

- **Produktions-kritischer Code:** Manuelle Tests sind präziser
- **UI/Frontend Code:** Pynguin arbeitet nur mit Backend-Logic
- **Code mit externen Dependencies:** Schwierig zu isolieren
- **Sicherheits-kritische Anwendungen:** Risiko durch Code-Ausführung
### Typischer Workflow:

1. **Bootstrap:** Pynguin für initiale 70-80% Coverage
2. **Review:** Generierte Tests prüfen und bereinigen
3. **Extend:** Manuelle Tests für kritische Pfade hinzufügen
4. **Maintain:** Pynguin regelmäßig für neue Features nutzen

## Quellen
### Software Analysis SS2025
This repository collects examples from the Software Analysis lecture in Jupyter notebooks.
https://github.com/se2p/sa2025
### Software Engineering SS2025
In diesem Repository werden die Beispiele aus der Vorlesung gesammelt. Um die Inhalte einfacher zugaenglich zu machen, werden sie dazu in [Jupyter Notebooks](https://jupyter.org/) verpackt. Es wird nicht zu jeder Vorlesung ein eigenes Notebook geben, sondern nur dort wo tatsaechlich benoetigt.
https://github.com/se2p/se2025