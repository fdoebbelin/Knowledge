## 1. Grundlagen zu Funktionen

### 1.1 Einfache Funktionen und ihre Parameter

- Funktionen kapseln häufig benötigte Funktionalität
- Der Aufruf erfolgt über den Funktionsnamen gefolgt von Klammern mit Parametern
- Rückgabewerte können weiterverwendet werden

```python
def max_in_liste(liste):
    """
    Verwendet die eingebaute Funktion max, um das größte Element einer Liste zu finden.
    
    Args:
        liste: Eine Liste mit Werten
        
    Returns:
        Das größte Element in der Liste
    """
    ergebnis = max(liste)
    return ergebnis

# Aufruf der Funktion mit einer Beispielliste
max_in_liste([3, 6, 2, 1, 9])
```

```python
def rueckgabewert_verwenden(zahlen):
    """
    Demonstriert die Weiterverwendung eines Funktionsrückgabewerts.
    
    Args:
        zahlen: Eine Liste von Zahlen
        
    Returns:
        Ein Dictionary mit dem Maximum und dem halbierten Maximum
    """
    wert = max(zahlen)
    halbiert = wert / 2
    
    return {
        "maximum": wert,
        "halbiertes_maximum": halbiert
    }

# Aufruf der Funktion
rueckgabewert_verwenden([3, 6, 2, 1, 9])
```

### 1.2 Methodenaufrufe

- Methoden sind Funktionen, die im Kontext einer Instanz ausgeführt werden
- Der Aufruf erfolgt über die Instanz, gefolgt von Punkt und Methodenname

```python
def liste_sortieren(liste):
    """
    Sortiert eine Liste mit der sort()-Methode.
    
    Args:
        liste: Eine Liste mit Werten
        
    Returns:
        Die sortierte Liste
    """
    liste_kopie = liste.copy()  # Kopie erstellen, da sort() die Liste in-place ändert
    liste_kopie.sort()
    return liste_kopie

# Aufruf der Funktion
liste_sortieren([4, 6, 2, 1, 8, 5, 9])
```

## 2. Parameter von Funktionen und Methoden

### 2.1 Positionsbezogene Parameter

- Parameter werden durch ihre Position in der Parameterliste identifiziert
- Die Reihenfolge der übergebenen Werte ist entscheidend

```python
def positions_parameter(parameter1, parameter2, parameter3):
    """
    Demonstriert die Verwendung von positionsbezogenen Parametern.
    
    Args:
        parameter1: Der erste Parameter
        parameter2: Der zweite Parameter
        parameter3: Der dritte Parameter
        
    Returns:
        Ein Dictionary mit den übergebenen Werten
    """
    return {
        "parameter1": parameter1,
        "parameter2": parameter2,
        "parameter3": parameter3
    }

# Aufruf der Funktion mit positionsbezogenen Parametern
positions_parameter(1, 45, -7)
```

### 2.2 Schlüsselwortparameter

- Parameter können auch über ihren Namen zugewiesen werden
- Die Reihenfolge spielt dann keine Rolle mehr

```python
def schluesselwort_parameter(parameter1, parameter2, parameter3):
    """
    Demonstriert die Verwendung von Schlüsselwortparametern.
    
    Args:
        parameter1: Der erste Parameter
        parameter2: Der zweite Parameter
        parameter3: Der dritte Parameter
        
    Returns:
        Ein Dictionary mit den übergebenen Werten
    """
    return {
        "parameter1": parameter1,
        "parameter2": parameter2,
        "parameter3": parameter3
    }

# Aufruf der Funktion mit Schlüsselwortparametern
schluesselwort_parameter(parameter2=2, parameter1=1, parameter3=3)
```

```python
def gemischte_parameter(parameter1, parameter2, parameter3):
    """
    Demonstriert die Verwendung von positions- und schlüsselwortbezogenen Parametern.
    
    Args:
        parameter1: Der erste Parameter
        parameter2: Der zweite Parameter
        parameter3: Der dritte Parameter
        
    Returns:
        Ein Dictionary mit den übergebenen Werten
    """
    return {
        "parameter1": parameter1,
        "parameter2": parameter2,
        "parameter3": parameter3
    }

# Aufruf der Funktion mit gemischten Parametern
gemischte_parameter(1, parameter3=3, parameter2=2)
```

### 2.3 Optionale Parameter

- Optionale Parameter müssen nicht übergeben werden
- Sie haben einen Standardwert, der verwendet wird, wenn kein Wert übergeben wird

```python
def optionale_parameter(parameter1, parameter2=None, parameter3=None):
    """
    Demonstriert die Verwendung von optionalen Parametern.
    
    Args:
        parameter1: Ein erforderlicher Parameter
        parameter2: Ein optionaler Parameter (Standard: None)
        parameter3: Ein optionaler Parameter (Standard: None)
        
    Returns:
        Ein Dictionary mit den übergebenen Werten
    """
    return {
        "parameter1": parameter1,
        "parameter2": parameter2,
        "parameter3": parameter3
    }

# Aufruf der Funktion mit allen Parametern
optionale_parameter(1, 2, 3)
```

```python
# Aufruf der Funktion mit nur dem erforderlichen Parameter
optionale_parameter(1)
```

```python
# Aufruf der Funktion mit dem erforderlichen und einem optionalen Parameter
optionale_parameter(1, 2)
```

### 2.4 Reine Schlüsselwortparameter

- Reine Schlüsselwortparameter können nur über ihren Namen übergeben werden
- Sie können nicht positionsbezogen übergeben werden

```python
def reine_schluesselwort_parameter(parameter1, parameter2, *, parameter3=None):
    """
    Demonstriert die Verwendung von reinen Schlüsselwortparametern.
    
    Args:
        parameter1: Ein positionsbezogener Parameter
        parameter2: Ein positionsbezogener Parameter
        parameter3: Ein reiner Schlüsselwortparameter (optional)
        
    Returns:
        Ein Dictionary mit den übergebenen Werten
    """
    return {
        "parameter1": parameter1,
        "parameter2": parameter2,
        "parameter3": parameter3
    }

# Aufruf der Funktion mit reinem Schlüsselwortparameter
reine_schluesselwort_parameter(1, 2, parameter3=3)
```

```python
# Aufruf der Funktion ohne den optionalen Schlüsselwortparameter
reine_schluesselwort_parameter(1, 2)
```

## 3. Attribute

- Attribute sind benannte Teile des Gesamtwerts einer Instanz
- Der Zugriff erfolgt über die Punktnotation: instanz.attribut

```python
def komplexe_zahl_attribute():
    """
    Demonstriert den Zugriff auf Attribute einer komplexen Zahl.
    
    Returns:
        Ein Dictionary mit den Attributen der komplexen Zahl
    """
    zahl = 5 + 6j
    
    return {
        "zahl": zahl,
        "real_teil": zahl.real,
        "imaginaer_teil": zahl.imag
    }

# Aufruf der Funktion
komplexe_zahl_attribute()
```

```python
def attribute_in_berechnungen():
    """
    Demonstriert die Verwendung von Attributen in Berechnungen.
    
    Returns:
        Ein Dictionary mit Berechnungsergebnissen
    """
    zahl = 5 + 6j
    
    berechnung = zahl.real * zahl.real + 5 * zahl.imag
    liste = [1, zahl.imag, zahl.real]
    
    return {
        "berechnung": berechnung,
        "liste": liste
    }

# Aufruf der Funktion
attribute_in_berechnungen()
```

### 3.1 Verschachtelte Attribut- und Methodenzugriffe

- Attribute können selbst wieder Attribute oder Methoden haben
- Der Zugriff erfolgt durch Verkettung mit der Punktnotation

```python
def verschachtelte_zugriffe():
    """
    Demonstriert verschachtelte Attribut- und Methodenzugriffe.
    
    Returns:
        Ein Dictionary mit den Ergebnissen der verschachtelten Zugriffe
    """
    zahl = 5 + 6j
    
    # Zugriff auf die Methode is_integer() des real-Attributs
    ist_ganzzahl = zahl.real.is_integer()
    
    return {
        "zahl": zahl,
        "ist_realteil_ganzzahl": ist_ganzzahl
    }

# Aufruf der Funktion
verschachtelte_zugriffe()
```
