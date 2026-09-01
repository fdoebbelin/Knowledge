## 1. Comprehensions (List, Dict, Set)
> Das Herzstück von pythonischem Code
### List Comprehensions
```python
# ❌ Nicht pythonisch
result = []
for i in range(10):
    if i % 2 == 0:
        result.append(i ** 2)

# ✅ Pythonisch
result = [i ** 2 for i in range(10) if i % 2 == 0]
```
### Dictionary & Set Comprehensions
```python
# Dictionary Comprehension
word_lengths = {word: len(word) for word in words}

# Set Comprehension
unique_lengths = {len(word) for word in words}
```
## 2. Context Manager (`with`-Statement)
> Automatisches Ressourcen-Management
```python
# ❌ Nicht pythonisch
file = open('data.txt', 'r')
content = file.read()
file.close()

# ✅ Pythonisch
with open('data.txt', 'r') as file:
    content = file.read()
```
## 3. Unpacking und Multiple Assignment
> Elegante Datenextraktion
```python
# Tupel Unpacking
name, age, city = ("Anna", 25, "Berlin")

# Extended Unpacking
first, *middle, last = [1, 2, 3, 4, 5]

# Swap Variables
a, b = b, a

# Function Arguments
def process_data(*args, **kwargs):
    pass
```
## 4. Enumerate und Zip
> Iterationen mit Index und Kombinationen
```python
# ❌ Nicht pythonisch
for i in range(len(items)):
    print(i, items[i])

# ✅ Pythonisch
for i, item in enumerate(items):
    print(i, item)

# Parallele Iteration
for name, age in zip(names, ages):
    print(f"{name} ist {age} Jahre alt")
> ```
## 5. Generator Expressions und yield
> Memory-effiziente Datenverarbeitung
```python
# Generator Expression
squares = (x ** 2 for x in range(1000000))

# Generator Function
def fibonacci():
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b
```
## 6. String Formatting
> Moderne String-Verarbeitung
```python
# ❌ Alte Methoden
name = "Anna"
age = 25
text = "Hallo " + name + ", du bist " + str(age) + " Jahre alt"

# ✅ f-Strings (Python 3.6+)
text = f"Hallo {name}, du bist {age} Jahre alt"

# Mit Formatierung
price = 12.3456
formatted = f"Preis: {price:.2f}€"
```
## 7. Default Parameter und Keyword Arguments
> Flexible Funktionsdefinitionen
```python
def create_user(name, age=None, city="Berlin", **kwargs):
    user = {"name": name, "age": age, "city": city}
    user.update(kwargs)
    return user

# Aufruf
user = create_user("Anna", email="anna@email.com")
```
## 8. Lambda Functions und Higher-Order Functions
> Funktionale Programmierung
```python
# Lambda mit map, filter, sorted
numbers = [1, 2, 3, 4, 5]
squares = list(map(lambda x: x ** 2, numbers))
evens = list(filter(lambda x: x % 2 == 0, numbers))

# Sorting mit key
students = [("Anna", 2.1), ("Bob", 1.8), ("Charlie", 2.4)]
sorted_by_grade = sorted(students, key=lambda x: x[1])
```
## 9. Collections Module
> Spezialisierte Datenstrukturen
```python
from collections import defaultdict, Counter, namedtuple

# defaultdict
word_count = defaultdict(int)
for word in words:
    word_count[word] += 1

# Counter
letter_count = Counter("hello world")

# namedtuple
Person = namedtuple('Person', ['name', 'age', 'city'])
anna = Person('Anna', 25, 'Berlin')
```
## 10. Pathlib (für Dateipfade)
> Moderne Pfad-Verarbeitung
```python
from pathlib import Path

# ❌ os.path
import os
path = os.path.join("data", "files", "input.txt")

# ✅ pathlib
path = Path("data") / "files" / "input.txt"
if path.exists():
    content = path.read_text()
```
## 11. Decorators
> Funktionalität erweitern ohne Code-Änderung
```python
def timer(func):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        print(f"{func.__name__} took {time.time() - start:.2f}s")
        return result
    return wrapper

@timer
def slow_function():
    time.sleep(1)
    return "Done"
```
## 12. Exception Handling mit spezifischen Exceptions
> Präzise Fehlerbehandlung
```python
# ❌ Zu allgemein
try:
    value = int(user_input)
except Exception:
    print("Fehler")

# ✅ Spezifisch
try:
    value = int(user_input)
except ValueError:
    print("Ungültige Zahl")
except KeyboardInterrupt:
    print("Abgebrochen")
```
## 13. EAFP vs LBYL
> "Easier to Ask for Forgiveness than Permission"
```python
# ❌ LBYL (Look Before You Leap)
if key in dictionary:
    value = dictionary[key]
else:
    value = default_value

# ✅ EAFP
try:
    value = dictionary[key]
except KeyError:
    value = default_value

# Oder noch besser:
value = dictionary.get(key, default_value)
```
## 14. Boolean Logic und Truthiness
> Pythonische Wahrheitswerte
```python
# ❌ Explizite Vergleiche
if len(items) != 0:
    process(items)

if user_name != "":
    greet(user_name)

# ✅ Truthiness nutzen
if items:
    process(items)

if user_name:
    greet(user_name)
```
## 15. Chaining von Vergleichen und Operatoren
> Natürliche Ausdrücke
```python
# Chained Comparisons
if 18 <= age <= 65:
    print("Erwerbsfähig")

# Conditional Expressions (Ternary)
status = "adult" if age >= 18 else "minor"

# and/or für Default Values
name = user_input or "Anonymous"
```
## 16. Class Definition Patterns
> Moderne Klassen-Features
```python
from dataclasses import dataclass
from typing import Optional

@dataclass
class Person:
    name: str
    age: int
    email: Optional[str] = None
    
    def __post_init__(self):
        if self.age < 0:
            raise ValueError("Age cannot be negative")
```
## 17. Type Hints
> Code-Dokumentation und Tools
```python
from typing import List, Dict, Optional, Union

def process_data(
    items: List[str], 
    config: Dict[str, Union[str, int]]
) -> Optional[str]:
    if not items:
        return None
    return items[0].upper()
```
## 18. Slots für Memory-Optimierung
> Effiziente Klassen

```python
class OptimizedClass:
    __slots__ = ['name', 'age', 'email']
    
    def __init__(self, name: str, age: int, email: str):
        self.name = name
        self.age = age
        self.email = email
```
## 19. Property Decorators
> Kontrollierte Attributzugriffe
```python
class Temperature:
    def __init__(self, celsius: float = 0):
        self._celsius = celsius
    
    @property
    def celsius(self) -> float:
        return self._celsius
    
    @celsius.setter
    def celsius(self, value: float):
        if value < -273.15:
            raise ValueError("Temperature below absolute zero")
        self._celsius = value
    
    @property
    def fahrenheit(self) -> float:
        return self._celsius * 9/5 + 32
```
## 20. Itertools für effiziente Iterationen
> Mächtige Iterator-Tools
```python
from itertools import chain, cycle, combinations, product

# Flattening
nested = [[1, 2], [3, 4], [5, 6]]
flattened = list(chain.from_iterable(nested))

# Combinations
for pair in combinations(['A', 'B', 'C', 'D'], 2):
    print(pair)

# Infinite cycles
colors = cycle(['red', 'green', 'blue'])
```
## Zusammenfassung: Die "Zen of Python" Prinzipien
```python
import this  # Zeigt die Zen of Python
```
**Wichtigste idiomatische Prinzipien:**
1. **Readability counts** 
	 - Code wird öfter gelesen als geschrieben
2. **Explicit is better than implicit** 
	- Klarheit vor Cleverness
3. **Simple is better than complex** 
	- Einfache Lösungen bevorzugen
4. **Flat is better than nested** 
	- Tiefe Verschachtelung vermeiden
5. **There should be one obvious way to do it** 
	- Konsistente Patterns

**Für den Kurs relevante Konstrukte:**
- List/Dict/Set Comprehensions
- with-Statement
- f-Strings
- enumerate/zip
- Unpacking
- Exception Handling
- Boolean Truthiness
- Generator Expressions (Einführung)