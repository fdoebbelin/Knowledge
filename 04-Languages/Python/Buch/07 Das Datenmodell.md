In diesem Notebook werden die Grundlagen des Python-Datenmodells erklärt, insbesondere wie Python Daten zur Laufzeit verwaltet und welche Besonderheiten sich daraus ergeben.

## 1. Referenzen und Instanzen

- In Python sind Variablen Referenzen, die auf Datenobjekte (Instanzen) verweisen
- Eine Instanz ist ein konkretes Datenobjekt im Speicher
- Eine Referenz ermöglicht den Zugriff auf eine Instanz

```python
def einfache_referenz_erstellen():
    """Erstellt eine Referenz auf eine einfache Instanz."""
    a = 1337
    return f"a referenziert die Instanz mit dem Wert {a}"
```

```python
# Beispielaufruf
einfache_referenz_erstellen()
```

### 1.1 Mehrere Referenzen auf dieselbe Instanz

```python
def mehrere_referenzen_auf_eine_instanz():
    """Demonstriert mehrere Referenzen auf eine Instanz."""
    referenz1 = 1337
    referenz2 = referenz1
    
    return f"referenz1: {referenz1}, referenz2: {referenz2}"
```

```python
# Beispielaufruf
mehrere_referenzen_auf_eine_instanz()
```

### 1.2 Unabhängigkeit von Referenzen

```python
def unabhaengigkeit_von_referenzen():
    """Zeigt, dass Referenzen voneinander unabhängig sind."""
    referenz1 = 1337
    referenz2 = referenz1
    referenz1 = 2674
    
    return {
        "referenz1": referenz1,
        "referenz2": referenz2
    }
```

```python
# Beispielaufruf
unabhaengigkeit_von_referenzen()
```

## 2. Die Struktur von Instanzen

Jede Instanz in Python umfasst drei Komponenten:
- Datentyp
- Wert
- Identität

### 2.1 Datentyp

```python
def datentypen_bestimmen():
    """Bestimmt die Datentypen verschiedener Instanzen."""
    ergebnis = {}
    
    # Direkter Typabruf
    ergebnis["Typ von 1337"] = type(1337)
    ergebnis["Typ von 'Hallo Welt'"] = type("Hallo Welt")
    
    # Über Referenz
    v1 = 2674
    ergebnis["Typ von v1"] = type(v1)
    
    return ergebnis
```

```python
# Beispielaufruf
datentypen_bestimmen()
```

### 2.2 Datentypen vergleichen

```python
def datentypen_vergleichen():
    """Vergleicht Datentypen verschiedener Instanzen."""
    v1 = 1337
    
    ergebnisse = {
        "v1 und 2674 haben gleichen Typ": type(v1) == type(2674),
        "v1 hat Typ int": type(v1) == int,
        "v1 hat Typ str": type(v1) == str
    }
    
    return ergebnisse
```

```python
# Beispielaufruf
datentypen_vergleichen()
```

### 2.3 Flexible Referenzen

```python
def referenzen_sind_flexibel():
    """Zeigt, dass Referenzen keinen festen Typ haben."""
    zuerst_ein_string = "Ich bin ein String"
    typ_vorher = type(zuerst_ein_string)
    
    zuerst_ein_string = 1789
    typ_nachher = type(zuerst_ein_string)
    
    return {
        "Typ vorher": typ_vorher,
        "Typ nachher": typ_nachher
    }
```

```python
# Beispielaufruf
referenzen_sind_flexibel()
```

### 2.4 Wert

```python
def werte_vergleichen():
    """Vergleicht Werte verschiedener Instanzen."""
    v1 = 1337
    v2 = 1337
    
    ergebnisse = {
        "v1 == v2": v1 == v2,
        "v1 == 2674": v1 == 2674
    }
    
    return ergebnisse
```

```python
# Beispielaufruf
werte_vergleichen()
```

### 2.5 Typenübergreifende Wertevergleiche

```python
def typenubergreifende_vergleiche():
    """Zeigt typenübergreifende Wertevergleiche."""
    gleitkommazahl = 1987.0
    ganzzahl = 1987
    string = "1234"
    
    ergebnisse = {
        "Typ von gleitkommazahl": type(gleitkommazahl),
        "Typ von ganzzahl": type(ganzzahl),
        "gleitkommazahl == ganzzahl": gleitkommazahl == ganzzahl,
        "string == 1234": string == 1234
    }
    
    return ergebnisse
```

```python
# Beispielaufruf
typenubergreifende_vergleiche()
```

### 2.6 Identität

```python
def identitaeten_bestimmen():
    """Bestimmt die Identitäten verschiedener Instanzen."""
    ergebnisse = {
        "Identität von 1337": id(1337)
    }
    
    v1 = "Hallo Welt"
    ergebnisse["Identität von v1"] = id(v1)
    
    return ergebnisse
```

```python
# Beispielaufruf
identitaeten_bestimmen()
```

### 2.7 Identitäten vergleichen

```python
def identitaeten_vergleichen():
    """Vergleicht Identitäten verschiedener Instanzen."""
    v1 = [1, 2, 3]
    v2 = v1          # Gleiche Instanz
    v3 = [1, 2, 3]   # Neue Instanz mit gleichem Wert
    
    ergebnisse = {
        "Typen gleich (v1 und v3)": type(v1) == type(v3),
        "Werte gleich (v1 == v3)": v1 == v3,
        "Identitäten gleich (v1 is v3)": v1 is v3,
        "Identitäten gleich (v1 is v2)": v1 is v2
    }
    
    return ergebnisse
```

```python
# Beispielaufruf
identitaeten_vergleichen()
```

## 3. Referenzen löschen

```python
def referenz_loeschen():
    """Demonstriert das Löschen von Referenzen."""
    v1 = 1337
    wert_vor_loeschung = f"Wert von v1: {v1}"
    
    del v1
    
    # Dieser Code wird nicht ausgeführt, da v1 nicht mehr existiert
    # und einen NameError verursachen würde
    # wert_nach_loeschung = f"Wert von v1: {v1}"
    
    return {
        "Vor der Löschung": wert_vor_loeschung,
        "Nach der Löschung": "v1 existiert nicht mehr (würde NameError verursachen)"
    }
```

```python
# Beispielaufruf
referenz_loeschen()
```

### 3.1 Mehrere Referenzen löschen

```python
def mehrere_referenzen_loeschen():
    """Demonstriert das Löschen mehrerer Referenzen."""
    v1 = 1337
    v2 = 2674
    v3 = 4011
    
    werte_vor_loeschung = {
        "v1": v1,
        "v2": v2,
        "v3": v3
    }
    
    del v1, v2, v3
    
    return {
        "Vor der Löschung": werte_vor_loeschung,
        "Nach der Löschung": "v1, v2 und v3 existieren nicht mehr"
    }
```

```python
# Beispielaufruf
mehrere_referenzen_loeschen()
```

## 4. Mutable vs. immutable Datentypen

### 4.1 Identitätsuntersuchung bei immutable Datentypen

```python
def optimierung_bei_immutable_typen():
    """Zeigt Optimierungen bei immutable Datentypen wie Zahlen."""
    a = 1
    b = 1
    
    ergebnisse = {
        "Identität von a": id(a),
        "Identität von b": id(b),
        "a is b": a is b
    }
    
    return ergebnisse
```

```python
# Beispielaufruf
optimierung_bei_immutable_typen()
```

### 4.2 Mutable Datentypen und Seiteneffekte mit dem += Operator

```python
def seiteneffekte_vergleichen():
    """Vergleicht das Verhalten von += bei mutable und immutable Datentypen."""
    # Test mit immutable Datentyp (String)
    a_string = "Wasser"
    b_string = a_string
    a_string += "flasche"
    
    string_ergebnisse = {
        "a_string": a_string,
        "b_string": b_string
    }
    
    # Test mit mutable Datentyp (Liste)
    a_liste = [1, 2]
    b_liste = a_liste
    a_liste += [3, 4]
    
    listen_ergebnisse = {
        "a_liste": a_liste,
        "b_liste": b_liste
    }
    
    return {
        "String (immutable)": string_ergebnisse,
        "Liste (mutable)": listen_ergebnisse
    }
```

```python
# Beispielaufruf
seiteneffekte_vergleichen()
```

### 4.3 String-Verkettung

```python
def string_verkettung():
    """Demonstriert die Verkettung von Strings mit +=."""
    a = "Wasser"
    a += "flasche"
    return a
```

```python
# Beispielaufruf
string_verkettung()
```

### 4.4 Listen-Verkettung

```python
def listen_verkettung():
    """Demonstriert die Verkettung von Listen mit +=."""
    a = [1, 2]
    a += [3, 4]
    return a
```

```python
# Beispielaufruf
listen_verkettung()
```
