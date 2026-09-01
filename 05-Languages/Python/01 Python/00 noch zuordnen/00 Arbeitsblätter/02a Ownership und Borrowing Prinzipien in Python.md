## Einführung

Dieses Arbeitsblatt zeigt, wie die Ownership- und Borrowing-Prinzipien aus Rust die Python-Codequalität und -Robustheit verbessern können. Obwohl Python diese Konzepte nicht nativ erzwingt, kann ihre bewusste Anwendung zu sichererem, wartbarerem Code führen.

## Was sind Ownership und Borrowing?

### Ownership (Besitz)
- **Definition**: Jede Datenstruktur hat zu jedem Zeitpunkt einen eindeutigen "Besitzer"
- **Prinzip**: Nur der Besitzer darf die Daten ändern
- **Vorteil**: Verhindert ungewollte Seiteneffekte und Datenkorruption

### Borrowing (Ausleihen)
- **Definition**: Temporärer Zugriff auf Daten ohne Besitzübertragung
- **Regel**: Entweder mehrere unveränderliche ODER eine veränderliche Referenz
- **Vorteil**: Kontrollierter Zugriff ohne Besitzverlust

## Schlechte Beispiele (Anti-Patterns)

### 1. Unerlaubte mehrfache Veränderung

**Problem**: Mehrere Komponenten ändern gleichzeitig dieselben Daten

```python
def process_data(data_list, processor1, processor2):
    # Beide Funktionen können gleichzeitig die Liste ändern
    processor1.modify(data_list)  # Verändert data_list
    processor2.modify(data_list)  # Verändert dieselbe data_list
    return data_list

class DataProcessor:
    def modify(self, data):
        data.append("modified")
        data[0] = "changed"

# Problem: Zwei Prozessoren verändern gleichzeitig dieselben Daten
data = [1, 2, 3]
proc1 = DataProcessor()
proc2 = DataProcessor()
result = process_data(data, proc1, proc2)
print("Ergebnis:", result)  # Unvorhersagbares Ergebnis: ['changed', 2, 3, 'modified', 'modified']
```

**Warum schlecht?**
- Unvorhersagbare Ergebnisse durch Race Conditions
- Schwer zu debuggen
- Keine klaren Verantwortlichkeiten
- Verletzt das Single Responsibility Principle

### 2. Unklare Besitzverhältnisse

**Problem**: Geteilte Veränderung ohne klaren Besitzer

```python
class SharedResource:
    def __init__(self):
        self.data = []
    
    def add_item(self, item):
        self.data.append(item)

# Problem: Mehrere Komponenten teilen sich Ressource ohne klaren Besitz
shared = SharedResource()

def component_a(resource):
    resource.add_item("A")
    # Komponente A weiß nicht, ob andere die Ressource auch ändern

def component_b(resource):
    resource.add_item("B") 
    # Komponente B weiß nicht, ob andere die Ressource auch ändern

component_a(shared)
component_b(shared)
print("Shared data:", shared.data)  # ['A', 'B'] - aber in welcher Reihenfolge?
```

**Warum schlecht?**
- Unklare Zuständigkeiten
- Schwer zu testen
- Komponenten können sich gegenseitig beeinflussen
- Fehleranfälligkeit steigt

### 3. Seiteneffekte durch geteilte Referenzen

**Problem**: Ungewollte Änderungen an ursprünglichen Daten

```python
def dangerous_function(user_data):
    # Funktion verändert die übergebenen Daten direkt
    user_data["processed"] = True
    user_data.pop("temp_data", None)  # Löscht Daten
    return user_data

# Problem: Ursprüngliche Daten werden ungewollt verändert
original_data = {"name": "Alice", "temp_data": "important"}
result = dangerous_function(original_data)
print("Original nach Verarbeitung:", original_data)  # {'name': 'Alice', 'processed': True}
print("Result:", result)  # Zeigt auf dasselbe Objekt
```

**Warum schlecht?**
- Verlust wichtiger Daten
- Seiteneffekte sind schwer vorhersagbar
- Verletzt das Principle of Least Surprise
- Macht Code schwer testbar

## Gute Beispiele (Best Practices)

### 1. Exklusiver Besitz und kontrollierte Änderung

**Lösung**: Klare Besitzverhältnisse mit kontrollierten Zugriffsmethoden

```python
class DataOwner:
    def __init__(self, data):
        self._data = data.copy()  # Besitzt eine Kopie der Daten
        
    def borrow_readonly(self):
        # Gibt unveränderliche Sicht auf die Daten zurück
        return tuple(self._data)  # Immutable View
    
    def borrow_for_processing(self, processor_func):
        # Kontrollierte Änderung durch Callback
        temp_copy = self._data.copy()
        result = processor_func(temp_copy)
        if result is not None:
            self._data = result
        return self.borrow_readonly()

def safe_processor(data):
    # Arbeitet mit einer Kopie, verändert Original nicht direkt
    data.append("processed")
    return data

# Verwendung: Klare Besitzverhältnisse
original = [1, 2, 3]
owner = DataOwner(original)
readonly_view = owner.borrow_readonly()
print("Readonly view:", readonly_view)  # (1, 2, 3)

result = owner.borrow_for_processing(safe_processor)
print("Nach Verarbeitung:", result)     # (1, 2, 3, 'processed')
print("Original unverändert:", original) # [1, 2, 3]
```

**Warum gut?**
- Klare Besitzverhältnisse
- Kontrollierte Zugriffe
- Keine ungewollten Seiteneffekte
- Testbar und vorhersagbar

### 2. Immutable-First Ansatz

**Lösung**: Bevorzugung unveränderlicher Datenstrukturen

```python
from dataclasses import dataclass
from typing import Tuple

@dataclass(frozen=True)  # Immutable Dataclass
class UserRecord:
    name: str
    age: int
    tags: Tuple[str, ...]  # Immutable statt List
    
    def with_new_tag(self, tag: str) -> 'UserRecord':
        # Erstelle neue Instanz statt Änderung der bestehenden
        return UserRecord(
            name=self.name,
            age=self.age,
            tags=self.tags + (tag,)
        )
    
    def with_updated_age(self, new_age: int) -> 'UserRecord':
        return UserRecord(
            name=self.name,
            age=new_age,
            tags=self.tags
        )

# Verwendung: Keine Seiteneffekte möglich
user = UserRecord("Alice", 25, ("python", "rust"))
updated_user = user.with_new_tag("golang")

print("Original:", user)         # UserRecord(name='Alice', age=25, tags=('python', 'rust'))
print("Updated:", updated_user)  # UserRecord(name='Alice', age=25, tags=('python', 'rust', 'golang'))
print("Keine Seiteneffekte auf Original")
```

**Warum gut?**
- Unveränderliche Daten sind Thread-sicher
- Keine Seiteneffekte möglich
- Einfacher zu verstehen und zu testen
- Funktionale Programmierung wird gefördert

### 3. Defensive Kopierung und klare Ownership

**Lösung**: Defensive Programmierung mit expliziten Kopiervorgängen

```python
class SafeDataProcessor:
    def __init__(self):
        self._internal_state = []
    
    def process_data(self, external_data: list) -> list:
        # Defensive Kopie - schützt vor externen Änderungen
        working_copy = external_data.copy()
        
        # Verarbeitung auf Kopie
        working_copy.append("processed")
        working_copy = [str(item).upper() for item in working_copy]
        
        # Rückgabe einer neuen Liste (kein geteilter Zustand)
        return working_copy
    
    def safe_borrow_state(self) -> tuple:
        # Gibt unveränderliche Sicht auf internen Zustand zurück
        return tuple(self._internal_state)
    
    def update_internal_state(self, new_item):
        # Klare Methode für Zustandsänderung
        self._internal_state = self._internal_state + [new_item]

# Verwendung: Keine ungewollten Seiteneffekte
processor = SafeDataProcessor()
my_data = [1, 2, 3]

result = processor.process_data(my_data)
print("Original data:", my_data)      # [1, 2, 3] - unverändert!
print("Processed:", result)           # ['1', '2', '3', 'PROCESSED']

processor.update_internal_state("item1")
state_view = processor.safe_borrow_state()
print("Internal state:", state_view)  # ('item1',)
```

**Warum gut?**
- Defensive Kopierung verhindert Seiteneffekte
- Klare API für Zustandsänderungen
- Unveränderliche Views auf interne Daten
- Vorhersagbares Verhalten

## Praktische Richtlinien

### DO's (Empfohlene Praktiken)

1. **Verwende immutable Datentypen wo möglich**
   ```python
   # Gut: Tuple statt List für unveränderliche Daten
   coordinates = (x, y, z)
   
   # Gut: frozenset statt set
   allowed_operations = frozenset(['read', 'write'])
   ```

2. **Erstelle defensive Kopien**
   ```python
   def process_list(data: list) -> list:
       working_copy = data.copy()  # Defensive Kopie
       # Verarbeitung...
       return working_copy
   ```

3. **Verwende klare Besitz-APIs**
   ```python
   class DataContainer:
       def __init__(self, data):
           self._data = data.copy()
       
       def get_readonly_view(self):
           return tuple(self._data)
       
       def update_with_function(self, func):
           self._data = func(self._data.copy())
   ```

4. **Bevorzuge funktionale Ansätze**
   ```python
   # Gut: Funktionale Transformation
   def transform_data(data: list) -> list:
       return [item.upper() for item in data]
   
   # Anstatt: Mutable Änderungen
   def bad_transform(data: list):
       for i, item in enumerate(data):
           data[i] = item.upper()  # Ändert Original
   ```

### DON'Ts (Vermeidende Praktiken)

1. **Verwende keine mutable Default-Parameter**
   ```python
   # Schlecht
   def add_to_list(item, target_list=[]):
       target_list.append(item)
       return target_list
   
   # Gut
   def add_to_list(item, target_list=None):
       if target_list is None:
           target_list = []
       return target_list + [item]
   ```

2. **Vermeide geteilte mutable Zustände**
   ```python
   # Schlecht: Geteilter Zustand
   shared_config = {"debug": True}
   
   # Gut: Immutable Konfiguration
   from types import MappingProxyType
   config = MappingProxyType({"debug": True})
   ```

3. **Ändere nicht übergebene Parameter**
   ```python
   # Schlecht
   def process_user(user_dict):
       user_dict["processed"] = True  # Seiteneffekt
       return user_dict
   
   # Gut
   def process_user(user_dict):
       return {**user_dict, "processed": True}  # Neue Instanz
   ```
## Zusammenfassung

Die Anwendung von Ownership- und Borrowing-Prinzipien in Python führt zu:

- **Höhere Codequalität**: Weniger Bugs durch klarere Datenbesitzverhältnisse
- **Bessere Wartbarkeit**: Vorhersagbares Verhalten und weniger Seiteneffekte
- **Einfachere Tests**: Isolierte Komponenten sind leichter zu testen
- **Robustere Software**: Defensive Programmierung verhindert viele Laufzeitfehler
- **Vorbereitung für Rust**: Code wird leichter nach Rust portierbar

**Kernprinzip**: *Explizite Kontrolle über Datenbesitz und -zugriff führt zu sichererem, robusterem Code.*
