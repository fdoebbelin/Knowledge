## Core Immutable Data Structures

### `tuple`
**Zweck**: Unveränderliche Sequenz von Elementen  
**Ownership/Borrowing-Vorteil**: Einmal erstellt, können Inhalte nicht mehr geändert werden
```python
# Gut: Unveränderliche Datensammlung
coordinates = (10, 20, 30)  # Keine Änderung möglich
# coordinates[0] = 15  # TypeError!

# Anwendung: Sichere Rückgabe ohne Kopieraufwand
def get_position():
    return (self._x, self._y, self._z)  # Caller kann nichts ändern
```
**Erklärung**: Tupel sind die einfachste Form der Unveränderlichkeit in Python. Sie verhindern versehentliche Änderungen und können als Hash-Schlüssel verwendet werden.

### `frozenset`
**Zweck**: Unveränderliche Menge einzigartiger Elemente  
**Ownership/Borrowing-Vorteil**: Set-Operationen ohne Seiteneffekte
```python
# Gut: Unveränderliche Konfiguration
allowed_operations = frozenset(['read', 'write', 'delete'])
# allowed_operations.add('admin')  # AttributeError!

# Anwendung: Sichere Berechtigungsprüfung
def has_permission(user_perms, required_perm):
    return required_perm in user_perms  # Keine Änderung möglich
```
**Erklärung**: Frozensets sind hashbar und können in anderen Sets oder als Dictionary-Schlüssel verwendet werden. Ideal für unveränderliche Sammlungen[web:84][web:87][web:90].

### `MappingProxyType`
**Zweck**: Unveränderliche Sicht auf ein Dictionary  
**Ownership/Borrowing-Vorteil**: Schützt interne Dictionaries vor externer Manipulation
```python
from types import MappingProxyType

class ConfigManager:
    def __init__(self):
        self._config = {"debug": True, "timeout": 30}
    
    def get_config(self):
        # Rückgabe einer unveränderlichen Sicht
        return MappingProxyType(self._config)

# Anwendung
config = ConfigManager()
readonly_config = config.get_config()
# readonly_config["debug"] = False  # TypeError!
print(readonly_config["debug"])  # Lesen ist erlaubt
```
**Erklärung**: MappingProxyType erstellt eine unveränderliche Sicht auf ein Dictionary, ohne das Original zu kopieren. Sehr effizient für große Dictionaries[web:95][web:98][web:101].

## Advanced Immutability Tools

### `@dataclass(frozen=True)`
**Zweck**: Automatisch generierte, unveränderliche Datenklassen  
**Ownership/Borrowing-Vorteil**: Komplette Objektunveränderlichkeit mit minimalem Code
```python
from dataclasses import dataclass

@dataclass(frozen=True)
class Point:
    x: float
    y: float
    
    def distance_from_origin(self):
        return (self.x ** 2 + self.y ** 2) ** 0.5

# Anwendung
p1 = Point(3.0, 4.0)
# p1.x = 5.0  # FrozenInstanceError!

# Neue Instanz für Änderungen
p2 = Point(p1.x + 1, p1.y)  # Unveränderliche Transformation
```
**Erklärung**: `frozen=True` macht alle Attribute unveränderlich und generiert automatisch `__hash__()`, wodurch die Objekte als Dictionary-Schlüssel verwendbar werden[web:83][web:86][web:89].

### `@property` Decorator
**Zweck**: Kontrollierter Zugriff auf Attribute  
**Ownership/Borrowing-Vorteil**: Ermöglicht unveränderliche oder validierte Attribute
```python
class BankAccount:
    def __init__(self, balance):
        self._balance = balance
        self._transactions = []
    
    @property
    def balance(self):
        """Nur lesbar - kein Setter definiert"""
        return self._balance
    
    @property  
    def transaction_history(self):
        """Defensive Kopie als Tuple"""
        return tuple(self._transactions)
    
    def deposit(self, amount):
        if amount > 0:
            self._balance += amount
            self._transactions.append(f"Deposit: {amount}")

# Anwendung
account = BankAccount(100)
print(account.balance)  # 100 - lesbar
# account.balance = 200  # AttributeError - nicht änderbar!

history = account.transaction_history  # Unveränderliche Kopie
# history.append("hack")  # AttributeError!
```
**Erklärung**: `@property` ermöglicht Attribute, die wie normale Eigenschaften aussehen, aber kontrollierten Zugriff haben. Ideal für read-only Properties oder validierte Setter[web:96][web:99][web:102][web:105][web:107].

## Memory and Performance Optimizations

### `__slots__`
**Zweck**: Begrenzt Attribute und optimiert Speicher  
**Ownership/Borrowing-Vorteil**: Verhindert dynamische Attribute, verbessert Performance
```python
class Vector:
    __slots__ = ['x', 'y', 'z']  # Nur diese Attribute erlaubt
    
    def __init__(self, x, y, z):
        self.x = x
        self.y = y  
        self.z = z

# Anwendung
v = Vector(1, 2, 3)
# v.w = 4  # AttributeError - nicht erlaubt!
# v.__dict__  # AttributeError - keine __dict__ vorhanden!
```
**Erklärung**: `__slots__` verhindert die Erstellung von `__dict__` und begrenzt Attribute auf eine feste Liste. Spart Speicher und macht Attributzugriff schneller[web:97][web:100][web:103][web:106].

## Defensive Programming Patterns

### Defensive Copying
**Zweck**: Schutz vor ungewollten externen Änderungen  
**Ownership/Borrowing-Vorteil**: Klare Trennung zwischen internen und externen Daten
```python
import copy

class DataProcessor:
    def __init__(self):
        self._data = []
    
    def add_data(self, external_data):
        # Defensive Kopie beim Empfangen
        self._data.extend(copy.deepcopy(external_data))
    
    def get_data(self):
        # Defensive Kopie beim Ausgeben
        return copy.deepcopy(self._data)
    
    def get_data_readonly(self):
        # Noch besser: Unveränderliche Sicht
        return tuple(self._data)

# Anwendung
processor = DataProcessor()
my_list = [1, 2, 3]
processor.add_data(my_list)

my_list.append(4)  # Ändert nicht die internen Daten!
internal_copy = processor.get_data()
internal_copy.append(5)  # Ändert nicht die internen Daten!
```
**Erklärung**: Defensive Kopierung trennt interne Daten von externen Referenzen und verhindert ungewollte Seiteneffekte[web:85][web:88][web:94].

### Context Managers für Ownership
**Zweck**: Temporäre, kontrollierte Zugriffe auf Ressourcen  
**Ownership/Borrowing-Vorteil**: Automatische Ressourcenverwaltung
```python
from contextlib import contextmanager

class ManagedResource:
    def __init__(self, data):
        self._data = data.copy()
        self._locked = False
    
    @contextmanager
    def borrow_for_modification(self):
        """Temporärer, exklusiver Zugriff"""
        if self._locked:
            raise RuntimeError("Resource already borrowed")
        
        self._locked = True
        try:
            yield self._data  # "Leihe" die Daten aus
        finally:
            self._locked = False  # Automatische Freigabe

# Anwendung
resource = ManagedResource([1, 2, 3])

with resource.borrow_for_modification() as data:
    data.append(4)  # Erlaubte Änderung
    # Nach dem with-Block wird automatisch "zurückgegeben"

# resource.borrow_for_modification()  # Würde funktionieren
```
**Erklärung**: Context Managers ermöglichen zeitlich begrenzte, kontrollierte Zugriffe auf Ressourcen mit automatischer Aufräumung.

## Validation and Type Safety

### Custom Descriptors
**Zweck**: Erweiterte Attributkontrolle  
**Ownership/Borrowing-Vorteil**: Validierung und Zugriffskontrolle auf Feld-Ebene
```python
class ValidatedField:
    def __init__(self, validator):
        self.validator = validator
        self.name = None
    
    def __set_name__(self, owner, name):
        self.name = f'_{name}'
    
    def __get__(self, instance, owner):
        if instance is None:
            return self
        return getattr(instance, self.name)
    
    def __set__(self, instance, value):
        if self.validator(value):
            setattr(instance, self.name, value)
        else:
            raise ValueError(f"Invalid value: {value}")

class Person:
    age = ValidatedField(lambda x: isinstance(x, int) and x >= 0)
    
    def __init__(self, age):
        self.age = age

# Anwendung
person = Person(25)
# person.age = -5  # ValueError!
# person.age = "old"  # ValueError!
```
**Erklärung**: Custom Descriptors bieten feingranulare Kontrolle über Attributzugriff und ermöglichen komplexe Validierungs- und Zugriffsmuster.

## Summary Table

| Sprachmittel | Zweck | Ownership-Vorteil | Performance | Komplexität |
|--------------|--------|-------------------|-------------|-------------|
| `tuple` | Unveränderliche Sequenz | Keine Seiteneffekte | ⭐⭐⭐ | ⭐ |
| `frozenset` | Unveränderliche Menge | Sichere Set-Operationen | ⭐⭐⭐ | ⭐ |
| `MappingProxyType` | Unveränderliche Dict-Sicht | Schutz vor Manipulation | ⭐⭐⭐ | ⭐⭐ |
| `@dataclass(frozen=True)` | Unveränderliche Datenklasse | Komplette Objektsicherheit | ⭐⭐ | ⭐⭐ |
| `@property` | Kontrollierter Attributzugriff | Validierung & Read-Only | ⭐⭐ | ⭐⭐ |
| `__slots__` | Begrenzte Attribute | Speicheroptimierung | ⭐⭐⭐ | ⭐⭐ |
| Defensive Copying | Datenisolation | Vollständiger Schutz | ⭐ | ⭐⭐⭐ |
| Context Managers | Temporärer Zugriff | Automatische Ressourcenverwaltung | ⭐⭐ | ⭐⭐⭐ |
| Custom Descriptors | Erweiterte Attributkontrolle | Feingranulare Kontrolle | ⭐⭐ | ⭐⭐⭐ |

**Legende**: ⭐ = Niedrig, ⭐⭐ = Mittel, ⭐⭐⭐ = Hoch

## Empfohlene Kombinationen

### Für einfache Datenstrukturen:
```python
@dataclass(frozen=True)
class Point:
    x: float
    y: float
    tags: tuple = ()  # Statt list
```

### Für komplexe Klassen:
```python
class ManagedContainer:
    __slots__ = ['_data', '_metadata']
    
    def __init__(self, data):
        self._data = tuple(data)  # Unveränderlich
        self._metadata = {}
    
    @property
    def data(self):
        return self._data  # Bereits unveränderlich
    
    @property  
    def metadata(self):
        return MappingProxyType(self._metadata)  # Unveränderliche Sicht
```

Diese Sprachmittel ermöglichen es, Ownership- und Borrowing-Konzepte effektiv in Python umzusetzen und dabei sowohl Sicherheit als auch Performance zu optimieren.