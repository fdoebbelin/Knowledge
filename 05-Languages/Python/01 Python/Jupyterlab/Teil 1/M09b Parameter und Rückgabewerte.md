Parameter sind Variablen, die beim Funktionsaufruf übergeben werden können. Rückgabewerte sind die Daten, die eine Funktion nach ihrer Ausführung zurückgibt. In diesem Abschnitt werden verschiedene Konzepte und Techniken zu Parametern und Rückgabewerten in Python vorgestellt.

## Grundlegende Parameter

Eine einfache Funktion mit zwei Parametern, die eine Berechnung durchführt:

```python
def berechne_summe(a, b):
    """Berechnet die Summe zweier Zahlen."""
    summe = a + b
    return summe
```

```python
# Aufruf mit zwei Argumenten
berechne_summe(5, 7)
```

Eine Funktion, die mit benannten Parametern arbeitet:

```python
def formatiere_name(vorname, nachname):
    """Formatiert Vor- und Nachname in einem standardisierten Format."""
    formatierter_name = f"{nachname}, {vorname}"
    return formatierter_name
```

```python
# Aufruf mit benannten Parametern
formatiere_name(vorname="Max", nachname="Mustermann")
```

## Standardparameter (Default-Parameter)

Standardparameter haben einen vordefinierten Wert, der verwendet wird, wenn bei einem Funktionsaufruf kein Wert für diesen Parameter angegeben wird.

```python
def gruesse_person(name, grusstxt="Hallo"):
    """Begrüßt eine Person mit einem Grußtext.
    
    Args:
        name: Name der zu begrüßenden Person
        grusstxt: Der zu verwendende Grußtext (Standard: "Hallo")
    """
    return f"{grusstxt}, {name}!"
```

```python
# Aufruf mit allen Parametern
gruesse_person("Maria", "Guten Tag")
```

```python
# Aufruf mit nur dem Pflichtparameter
gruesse_person("Thomas")
```

```python
# Aufruf von print()
print(1,2,3)
print(1,2,3,sep=',')
```

## Variable Anzahl von Positionsparametern (*args)

Mit `*args` können beliebig viele Positionsargumente an eine Funktion übergeben werden. Diese werden als Tupel zugänglich gemacht.

```python
def summiere_alle(*zahlen):
    """Summiert alle übergebenen Zahlen.
    
    Args:
        *zahlen: Beliebig viele Zahlen, die summiert werden sollen
    """
    summe = 0
    for zahl in zahlen:
        summe += zahl
    return summe
```

```python
# Aufruf mit verschiedener Anzahl von Argumenten
summiere_alle(1, 2, 3)
```

```python
summiere_alle(10, 20, 30, 40, 50)
```

```python
# Aufruf ohne Argumente
summiere_alle()
```

## Variable Anzahl von Schlüsselwortparametern (**kwargs)

Mit `**kwargs` können beliebig viele benannte Argumente an eine Funktion übergeben werden. Diese werden als Dictionary zugänglich gemacht.

```python
def erstelle_person(**eigenschaften):
    """Erstellt ein Personenobjekt mit den angegebenen Eigenschaften.
    
    Args:
        **eigenschaften: Beliebig viele Eigenschaften als Schlüssel-Wert-Paare
    """
    person = {"id": id(eigenschaften)}  # Generiere eine eindeutige ID
    person.update(eigenschaften)  # Füge alle übergebenen Eigenschaften hinzu
    return person
```

```python
# Aufruf mit verschiedenen benannten Argumenten
erstelle_person(name="Anna", alter=28, beruf="Ingenieurin")
```

```python
# Aufruf mit anderen Eigenschaften
erstelle_person(vorname="Max", nachname="Mustermann", hobbys=["Lesen", "Sport"])
```

## Kombination verschiedener Parameterarten

Es ist möglich, verschiedene Arten von Parametern in einer Funktion zu kombinieren. Dabei muss folgende Reihenfolge eingehalten werden:
1. Normale Positionsparameter
2. Standardparameter
3. Variable Positionsparameter (*args)
4. Variable Schlüsselwortparameter (**kwargs)

```python
def zeige_parameter_arten(standard_param="Standardwert", 
                          *args, 
                          **kwargs):
    """
    Demonstriert verschiedene Arten von Parametern.
    
    Args:
        standard_param: Ein Parameter mit Standardwert
        *args: Variable Anzahl von Positionsargumenten
        **kwargs: Variable Anzahl von Schlüsselwortargumenten
    """
    ergebnis = []
    
    # Standardparameter
    ergebnis.append(f"Standardparameter: {standard_param}")
    
    # Variable Positionsargumente (args)
    if args:
        ergebnis.append(f"Positionsargumente (*args): {args}")
    
    # Variable Schlüsselwortargumente (kwargs)
    if kwargs:
        ergebnis.append("Schlüsselwortargumente (**kwargs):")
        for key, value in kwargs.items():
            ergebnis.append(f"  {key}: {value}")
    
    return "\n".join(ergebnis)
```

```python
# Aufruf mit verschiedenen Parameterarten
print(zeige_parameter_arten("Benutzerwert", 1, 2, 3, name="Python", version=3.9))
```

```python
# Aufruf mit nur dem Standardparameter
zeige_parameter_arten()
```

## Einfache Rückgabewerte

Die `return`-Anweisung gibt einen Wert zurück und beendet die Funktion sofort.

```python
def ist_volljährig(alter):
    """Prüft, ob jemand volljährig ist.
    
    Args:
        alter: Das zu prüfende Alter
        
    Returns:
        bool: True, wenn das Alter mindestens 18 ist, sonst False
    """
    return alter >= 18
```

```python
# Test mit verschiedenen Werten
ist_volljährig(16)
```

```python
ist_volljährig(21)
```

## Bedingte Rückgabewerte

Abhängig von Bedingungen kann eine Funktion unterschiedliche Werte zurückgeben.

```python
def note_zu_text(note):
    """Konvertiert eine Notenzahl in einen beschreibenden Text.
    
    Args:
        note: Eine Notenzahl von 1 bis 6
        
    Returns:
        str: Eine textuelle Beschreibung der Note oder eine Fehlermeldung
    """
    if note == 1:
        return "Sehr gut"
    elif note == 2:
        return "Gut"
    elif note == 3:
        return "Befriedigend"
    elif note == 4:
        return "Ausreichend"
    elif note == 5:
        return "Mangelhaft"
    elif note == 6:
        return "Ungenügend"
    else:
        return "Ungültige Note"
```

```python
# Test mit verschiedenen Noten
print(note_zu_text(1))
print(note_zu_text(3))
print(note_zu_text(7))
```

## Verschiedene Rückgabetypen

Eine Funktion kann auch unterschiedliche Typen zurückgeben, abhängig vom Eingabewert.

```python
def demonstriere_rueckgabewerte(wert):
    """
    Demonstriert verschiedene Rückgabewerte basierend auf dem Eingabewert.
    
    Args:
        wert: Ein Integer-Wert der bestimmt, was zurückgegeben wird
        
    Returns:
        Abhängig vom Wert unterschiedliche Typen oder Strukturen
    """
    if wert == 1:
        return "Ein String"
    elif wert == 2:
        return 42
    elif wert == 3:
        return [1, 2, 3, 4]
    elif wert == 4:
        return {"name": "Max", "alter": 30}
    elif wert == 5:
        # Mehrere Werte werden als Tupel zurückgegeben
        return "Max", 30, "Python"
    else:
        # Kein Return gibt None zurück
        pass
```

```python
# Aufruf mit wert=1 (gibt einen String zurück)
demonstriere_rueckgabewerte(wert=1)
```

```python
# Aufruf mit wert=3 (gibt eine Liste zurück)
demonstriere_rueckgabewerte(wert=3)
```

```python
# Aufruf mit wert=5 (gibt ein Tupel mit mehreren Werten zurück)
demonstriere_rueckgabewerte(wert=5)
```

```python
# Aufruf mit wert=6 (gibt None zurück)
demonstriere_rueckgabewerte(wert=6)
```

## Mehrere Rückgabewerte

Python erlaubt es, mehrere Werte auf einmal zurückzugeben. Intern werden diese als Tupel zurückgegeben.

```python
def berechne_statistik(zahlen):
    """Berechnet verschiedene statistische Werte für eine Liste von Zahlen.
    
    Args:
        zahlen: Eine Liste von Zahlen
        
    Returns:
        tuple: (Minimum, Maximum, Durchschnitt) der übergebenen Zahlen
    """
    minimum = min(zahlen)
    maximum = max(zahlen)
    durchschnitt = sum(zahlen) / len(zahlen)
    
    return minimum, maximum, durchschnitt
```

```python
# Die Rückgabewerte können einzeln zugewiesen werden
min_wert, max_wert, avg = berechne_statistik([4, 7, 2, 9, 5])
print(f"Minimum: {min_wert}, Maximum: {max_wert}, Durchschnitt: {avg}")
```

```python
# Oder als Tupel behandelt werden
ergebnis = berechne_statistik([10, 20, 30, 40])
print(f"Ergebnis-Tupel: {ergebnis}")
print(f"Erstes Element: {ergebnis[0]}")
```

## Generatoren als Rückgabewerte

Generatoren erzeugen Werte auf Anfrage und sind effizient für große Datenmengen. Sie werden mit `yield` statt `return` erstellt oder als Generator-Expressions.

```python
def fibonacci_generator(n):
    """
    Erzeugt die ersten n Fibonacci-Zahlen.
    
    Args:
        n: Anzahl der zu generierenden Fibonacci-Zahlen
        
    Yields:
        int: Die nächste Fibonacci-Zahl in der Sequenz
    """
    a, b = 0, 1
    for _ in range(n):
        yield a
        a, b = b, a + b
```

```python
# Verwendung des Generators in einer Schleife
for zahl in fibonacci_generator(10):
    print(zahl, end=" ")
```

Eine alternative Methode ist die Verwendung von Generator-Expressions:

```python
def erzeuge_generator(max_wert):
    """
    Erzeugt einen Generator für Zahlen bis max_wert.
    
    Args:
        max_wert: Die Obergrenze für den Generator
        
    Returns:
        Ein Generator-Objekt
    """
    return (x for x in range(1, max_wert + 1))
```

```python
# Aufruf und Umwandlung des Ergebnisses in eine Liste
print(erzeuge_generator(max_wert=5))
print(list(erzeuge_generator(max_wert=5)))
```

## None als Rückgabewert

Wenn eine Funktion kein explizites `return` oder ein `return` ohne Wert enthält, gibt sie automatisch `None` zurück.

```python
def verarbeite_daten(daten):
    """
    Verarbeitet Daten ohne etwas zurückzugeben.
    
    Args:
        daten: Die zu verarbeitenden Daten
    """
    # Führt Operationen aus, gibt aber nichts zurück
    print(f"Verarbeite: {daten}")
    # Implizites return None am Ende
```

```python
# Die Funktion gibt None zurück
ergebnis = verarbeite_daten("Beispieldaten")
print(f"Rückgabewert: {ergebnis}")
```

## Weiterführende Ressourcen

- [Python-Dokumentation zu Funktionen](https://docs.python.org/3/tutorial/controlflow.html#defining-functions)
- [Python Parameter Passing](https://realpython.com/python-pass-by-reference/)
- [Real Python: Return Statement in Python](https://realpython.com/python-return-statement/)
- [Python Generators](https://realpython.com/introduction-to-python-generators/)

```python

```
