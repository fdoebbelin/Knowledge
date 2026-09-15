---
aliases: 
tags: 
title: 5D1F OOP verwenden
---

## Einführung in die OOP mit Python

### 1. Vorbereitung

Zuerst erstellen wir eine neue Python-Datei namens `auto.py` und öffnen die IDLE-Shell. In der Shell führen wir folgende Befehle aus:

```python
import auto
from importlib import reload
```

### 2. Eine einfache Klasse definieren

Wir beginnen mit der Definition einer einfachen Klasse `Auto` in der Datei `auto.py`:

```python
class Auto:
    def __init__(self, marke, modell, baujahr):
        self.marke = marke
        self.modell = modell
        self.baujahr = baujahr
```

In diesem Schritt haben wir eine Klasse `Auto` mit einem Konstruktor (__init__) definiert. Der Konstruktor initialisiert drei Attribute: `marke`, `modell` und `baujahr`.

In der IDLE-Shell testen wir die Klasse:

```python
reload(auto)
mein_auto = auto.Auto("VW", "Golf", 2020)
(mein_auto.marke, mein_auto.modell, mein_auto.baujahr)
```

### 3. Objekte erstellen und verwenden

Wir haben bereits ein Objekt erstellt und seine Attribute ausgegeben. Lasst uns die Klasse um eine Methode erweitern, die Informationen über das Auto ausgibt:

```python
class Auto:
    def __init__(self, marke, modell, baujahr):
        self.marke = marke
        self.modell = modell
        self.baujahr = baujahr
    
    def info(self):
        return f"{self.marke} {self.modell} ({self.baujahr})"
```

Testen wir die neue Methode in der IDLE-Shell:

```python
reload(auto)
mein_auto = auto.Auto("VW", "Golf", 2020)
mein_auto.info()
```

### 4. Methoden implementieren

Fügen wir eine weitere Methode hinzu, die das Alter des Autos berechnet:

```python
import datetime

class Auto:
    def __init__(self, marke, modell, baujahr):
        self.marke = marke
        self.modell = modell
        self.baujahr = baujahr
    
    def info(self):
        return f"{self.marke} {self.modell} ({self.baujahr})"
    
    def alter(self):
        aktuelles_jahr = datetime.datetime.now().year
        return aktuelles_jahr - self.baujahr
```

Testen wir die neue Methode:

```python
reload(auto)
mein_auto = auto.Auto("VW", "Golf", 2020)
mein_auto.info()
f"Alter des Autos: {mein_auto.alter()} Jahre"
```

### 5. Datenkapselung einführen

Nun führen wir Datenkapselung ein, indem wir ein Attribut mit Name Mangling schützen und Properties verwenden:

```python
import datetime

class Auto:
    def __init__(self, marke, modell, baujahr):
        self.marke = marke
        self.modell = modell
        self.__baujahr = baujahr
        self.__kilometerstand = 0
    
    @property
    def baujahr(self):
        return self.__baujahr
    
    @property
    def kilometerstand(self):
        return self.__kilometerstand
    
    @kilometerstand.setter
    def kilometerstand(self, wert):
        if wert >= 0:
            self.__kilometerstand = wert
        else:
            print("Fehler: Kilometerstand kann nicht negativ sein.")
    
    def info(self):
        return f"{self.marke} {self.modell} ({self.__baujahr})"
    
    def alter(self):
        aktuelles_jahr = datetime.datetime.now().year
        return aktuelles_jahr - self.__baujahr
```

In diesem Schritt haben wir:

- Das `baujahr`-Attribut mit Name Mangling geschützt (__baujahr)
- Ein neues geschütztes Attribut `__kilometerstand` hinzugefügt
- Properties für `baujahr` (nur Getter) und `kilometerstand` (Getter und Setter) implementiert, `baujahr` kann so nur bei der Initialisierung gesetzt werden.

Testen wir die Änderungen in der IDLE-Shell:

```python
reload(auto)
mein_auto = auto.Auto("VW", "Golf", 2020)
mein_auto.info()
f"Alter des Autos: {mein_auto.alter()} Jahre"

# Testen der Properties
mein_auto.baujahr
mein_auto.kilometerstand
mein_auto.kilometerstand = 5000
mein_auto.kilometerstand
mein_auto.kilometerstand = -100  # Dies sollte einen Fehler ausgeben

# Versuchen, auf das geschützte Attribut zuzugreifen
try:
    print(mein_auto.__baujahr)
except AttributeError:
    print("Zugriff auf __baujahr nicht möglich")
```

## Fortgeschrittene OOP-Konzepte in Python

### 6. Vererbung anwenden

Wir erweitern unser Beispiel um eine Unterklasse `Elektroauto`, die von `Auto` erbt:

```python
import datetime

class Auto:
    def __init__(self, marke, modell, baujahr):
        self.marke = marke
        self.modell = modell
        self.__baujahr = baujahr
        self.__kilometerstand = 0
    
    @property
    def baujahr(self):
        return self.__baujahr
    
    @property
    def kilometerstand(self):
        return self.__kilometerstand
    
    @kilometerstand.setter
    def kilometerstand(self, wert):
        if wert >= 0:
            self.__kilometerstand = wert
        else:
            print("Fehler: Kilometerstand kann nicht negativ sein.")
    
    def info(self):
        return f"{self.marke} {self.modell} ({self.baujahr})"
    
    def alter(self):
        aktuelles_jahr = datetime.datetime.now().year
        return aktuelles_jahr - self.__baujahr

class Elektroauto(Auto):
    def __init__(self, marke, modell, baujahr, batteriekapazitaet):
        super().__init__(marke, modell, baujahr)
        self.batteriekapazitaet = batteriekapazitaet
    
    def info(self):
        return f"{super().info()} - Batteriekapazität: {self.batteriekapazitaet} kWh"
```

Testen wir die Vererbung in der IDLE-Shell:

```python
reload(auto)
mein_eauto = auto.Elektroauto("Tesla", "Model 3", 2022, 75)
mein_eauto.info()
f"Alter des E-Autos: {mein_eauto.alter()} Jahre"
```

### 7. Polymorphismus nutzen

Wir fügen eine weitere Klasse `Lastwagen` hinzu, um Polymorphismus zu demonstrieren:

```python
import datetime

class Auto:
    # ... (vorheriger Code bleibt unverändert)

class Elektroauto(Auto):
    # ... (vorheriger Code bleibt unverändert)

class Lastwagen(Auto):
    def __init__(self, marke, modell, baujahr, ladekapazitaet):
        super().__init__(marke, modell, baujahr)
        self.ladekapazitaet = ladekapazitaet
    
    def info(self):
        return f"{super().info()} - Ladekapazität: {self.ladekapazitaet} Tonnen"
```

Testen wir den Polymorphismus:

```python
reload(auto)
fahrzeuge = [
    auto.Auto("VW", "Golf", 2020),
    auto.Elektroauto("Tesla", "Model 3", 2022, 75),
    auto.Lastwagen("MAN", "TGX", 2021, 20)
]

for fahrzeug in fahrzeuge:
    print(fahrzeug.info())
```

### 8. Spezielle Methoden kennenlernen

Fügen wir einige spezielle Methoden zur `Auto`-Klasse hinzu:

```python
import datetime

class Auto:
    def __init__(self, marke, modell, baujahr):
        self.marke = marke
        self.modell = modell
        self.__baujahr = baujahr
        self.__kilometerstand = 0
    
    # ... (vorherige Methoden bleiben unverändert)
    
    def __str__(self):
        return self.info()
    
    def __repr__(self):
        return f"Auto('{self.marke}', '{self.modell}', {self.__baujahr})"
    
    def __eq__(self, other):
        if isinstance(other, Auto):
            return (self.marke, self.modell, self.__baujahr) == (other.marke, other.modell, other.baujahr)
        return False

# ... (Elektroauto und Lastwagen Klassen bleiben unverändert)
```

Testen wir die speziellen Methoden:

```python
reload(auto)
auto1 = auto.Auto("VW", "Golf", 2020)
auto2 = auto.Auto("VW", "Golf", 2020)
auto3 = auto.Auto("BMW", "X3", 2021)

str(auto1)
repr(auto1)
auto1 == auto2
auto1 == auto3
```

### 9. Klassenattribute und -methoden verwenden

Fügen wir ein Klassenattribut und eine Klassenmethode zur `Auto`-Klasse hinzu:

```python
import datetime

class Auto:
    anzahl_autos = 0  # Klassenattribut
    
    def __init__(self, marke, modell, baujahr):
        self.marke = marke
        self.modell = modell
        self.__baujahr = baujahr
        self.__kilometerstand = 0
        Auto.anzahl_autos += 1
    
    # ... (vorherige Methoden bleiben unverändert)
    
    @classmethod
    def get_anzahl_autos(cls):
        return cls.anzahl_autos

# ... (Elektroauto und Lastwagen Klassen bleiben unverändert)
```

Testen wir das Klassenattribut und die Klassenmethode:

```python
reload(auto)
auto1 = auto.Auto("VW", "Golf", 2020)
auto2 = auto.Auto("BMW", "X3", 2021)
eauto = auto.Elektroauto("Tesla", "Model 3", 2022, 75)

f"Anzahl der Autos: {auto.Auto.get_anzahl_autos()}"
```

### 10. Fortgeschrittene Konzepte erkunden

Zum Abschluss implementieren wir eine abstrakte Basisklasse und demonstrieren Mehrfachvererbung:

```python
from abc import ABC, abstractmethod
import datetime

class Fahrzeug(ABC):
    @abstractmethod
    def fahren(self):
        pass

class Auto(Fahrzeug):
    anzahl_autos = 0
    
    def __init__(self, marke, modell, baujahr):
        self.marke = marke
        self.modell = modell
        self.__baujahr = baujahr
        self.__kilometerstand = 0
        Auto.anzahl_autos += 1
    
    # ... (vorherige Methoden bleiben unverändert)
    
    def fahren(self):
        return f"{self.marke} {self.modell} fährt auf der Straße."

class Elektrofahrzeug:
    def laden(self):
        return "Fahrzeug wird geladen."

class Elektroauto(Auto, Elektrofahrzeug):
    def __init__(self, marke, modell, baujahr, batteriekapazitaet):
        super().__init__(marke, modell, baujahr)
        self.batteriekapazitaet = batteriekapazitaet
    
    def info(self):
        return f"{super().info()} - Batteriekapazität: {self.batteriekapazitaet} kWh"
    
    def fahren(self):
        return f"{super().fahren()} Es ist leise und umweltfreundlich."

# ... (Lastwagen Klasse bleibt unverändert)
```

Testen wir die fortgeschrittenen Konzepte:

```python
reload(auto)
normales_auto = auto.Auto("VW", "Golf", 2020)
eauto = auto.Elektroauto("Tesla", "Model 3", 2022, 75)

normales_auto.fahren()
eauto.fahren()
eauto.laden()

# Überprüfen der abstrakten Methode
try:
    fahrzeug = auto.Fahrzeug()
except TypeError as e:
    print(f"Fehler beim Erstellen eines Fahrzeugs: {e}")
```
