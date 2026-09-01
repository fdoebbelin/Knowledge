In diesem Dokument werden die verschiedenen Kontrollstrukturen in Python demonstriert. Alle Beispiele sind als Funktionen implementiert, die ihre Ergebnisse zurückgeben.

## 1. Fallunterscheidungen

### 1.1 Die if-Anweisung

- Einfachste Form der Fallunterscheidung 
- Führt Code nur aus, wenn eine Bedingung erfüllt ist
- Bedingung muss einen Wahrheitswert (True oder False) ergeben

```python
def einfache_if_anweisung(x):
    """
    Demonstriert eine einfache if-Anweisung, die nur ausgeführt wird,
    wenn die Variable x den Wert 1 hat.
    """
    resultat = ""
    if x == 1:
        resultat = "x hat den Wert 1"
    return resultat

# Demonstration mit x = 1
einfache_if_anweisung(1)
```

- if-Anweisungen können komplexere Bedingungen enthalten
- Der Anweisungskörper kann mehrere Anweisungen enthalten

```python
def if_mit_komplexer_bedingung(x):
    """
    Demonstriert eine if-Anweisung mit einer komplexeren Bedingung
    und mehreren Anweisungen im Körper.
    """
    resultat = []
    if x < 1 or x > 5:
        resultat.append("x ist kleiner als 1 ...")
        resultat.append("... oder größer als 5")
    return resultat

# Demonstration mit x = 0
if_mit_komplexer_bedingung(0)
```

### 1.2 Mehrere if-Anweisungen nacheinander

- Mehrere if-Anweisungen können nacheinander verwendet werden
- Jede Bedingung wird unabhängig ausgewertet

```python
def mehrere_if_anweisungen(x):
    """
    Demonstriert die Verwendung mehrerer aufeinanderfolgender if-Anweisungen.
    Beide Bedingungen werden unabhängig voneinander ausgewertet.
    """
    resultat = []
    if x == 1:
        resultat.append("x hat den Wert 1")
    if x == 2:
        resultat.append("x hat den Wert 2")
    return resultat

# Demonstration mit x = 1
mehrere_if_anweisungen(1)
```

### 1.3 if-elif-Konstrukt

- Mit elif können mehrere Bedingungen effizienter geprüft werden
- Eine elif-Bedingung wird nur geprüft, wenn alle vorherigen Bedingungen falsch waren

```python
def if_elif_konstrukt(x):
    """
    Demonstriert die Verwendung von elif zur effizienten Prüfung mehrerer Bedingungen.
    Die elif-Bedingung wird nur geprüft, wenn die if-Bedingung nicht erfüllt ist.
    """
    resultat = []
    if x == 1:
        resultat.append("x hat den Wert 1")
    elif x == 2:
        resultat.append("x hat den Wert 2")
    return resultat

# Demonstration mit x = 2
if_elif_konstrukt(2)
```

- Es können beliebig viele elif-Zweige verwendet werden

```python
def mehrere_elif_zweige(x):
    """
    Demonstriert die Verwendung mehrerer elif-Zweige.
    """
    resultat = []
    if x == 1:
        resultat.append("x hat den Wert 1")
    elif x == 2:
        resultat.append("x hat den Wert 2")
    elif x == 3:
        resultat.append("x hat den Wert 3")
    return resultat

# Demonstration mit x = 3
mehrere_elif_zweige(3)
```

### 1.4 if-elif-else-Konstrukt

- Mit else kann ein Standardfall definiert werden, der ausgeführt wird, 
  wenn keine der vorherigen Bedingungen zutrifft

```python
def if_elif_else_konstrukt(x):
    """
    Demonstriert die Verwendung von else für den Fall,
    dass keine der vorherigen Bedingungen zutrifft.
    """
    resultat = []
    if x == 1:
        resultat.append("x hat den Wert 1")
    elif x == 2:
        resultat.append("x hat den Wert 2")
    else:
        resultat.append("Fehler: Der Wert von x ist weder 1 noch 2")
    return resultat

# Demonstration mit x = 3
if_elif_else_konstrukt(3)
```

### 1.5 Bedingte Ausdrücke (Conditional Expressions)

- Ermöglichen eine kompaktere Schreibweise für einfache if-else-Konstrukte
- Syntax: `Wert_wenn_wahr if Bedingung else Wert_wenn_falsch`

```python
def bedingter_ausdruck_zuweisung(x):
    """
    Demonstriert einen bedingten Ausdruck bei einer Zuweisung.
    """
    # Mit bedingtem Ausdruck
    var = 20 if x == 1 else 30
    
    return {
        "x": x,
        "var": var
    }

# Demonstration mit x = 1
bedingter_ausdruck_zuweisung(1)
```

```python
def bedingter_ausdruck_ausgabe(x):
    """
    Demonstriert einen bedingten Ausdruck bei einer Ausgabe.
    """
    # Wir geben den String zurück, den wir sonst ausgeben würden
    return "x hat den Wert 1" if x == 1 else "x ist ungleich 1"

# Demonstration mit x = 2
bedingter_ausdruck_ausgabe(2)
```

```python
def komplexer_bedingter_ausdruck(a, b):
    """
    Demonstriert einen komplexeren bedingten Ausdruck.
    """
    xyz = a * 2 if (a > 10 and b < 5) else b * 2
    
    return {
        "a": a,
        "b": b,
        "xyz": xyz
    }

# Demonstration mit a = 5, b = 3
komplexer_bedingter_ausdruck(5, 3)
```

## 2. Schleifen

### 2.1 Die while-Schleife

- Führt einen Codeblock aus, solange eine Bedingung erfüllt ist
- Die Bedingung wird vor jedem Schleifendurchlauf geprüft

```python
def einfache_while_schleife(geheimnis):
    """
    Demonstriert eine einfache while-Schleife anhand eines vereinfachten Zahlenraten-Spiels.
    In einer echten Implementierung würde input() für die Benutzereingabe verwendet werden.
    
    Hier simulieren wir das Spiel mit vordefinierten Rateversuchen [500, 1000, 1337].
    """
    versuch = -1
    rateversuche = [500, 1000, 1337]  # Vordefinierte Rateversuche für die Simulation
    versuche_index = 0
    protokoll = []
    
    while versuch != geheimnis and versuche_index < len(rateversuche):
        versuch = rateversuche[versuche_index]
        protokoll.append(f"Raten Sie: {versuch}")
        versuche_index += 1
    
    protokoll.append("Sie haben es geschafft!")
    
    return protokoll

# Demonstration mit geheimnis = 1337
einfache_while_schleife(1337)
```

### 2.2 Abbruch einer Schleife mit break

- Die break-Anweisung beendet eine Schleife vorzeitig
- Nützlich, um die Schleife bei bestimmten Bedingungen zu verlassen

```python
def while_schleife_mit_break(geheimnis):
    """
    Demonstriert die Verwendung von break zum vorzeitigen Beenden einer Schleife.
    """
    versuch = -1
    rateversuche = [500, 1000, 0, 1337]  # 0 soll das Spiel abbrechen
    versuche_index = 0
    protokoll = []
    
    while versuch != geheimnis and versuche_index < len(rateversuche):
        versuch = rateversuche[versuche_index]
        protokoll.append(f"Raten Sie: {versuch}")
        
        if versuch == 0:
            protokoll.append("Das Spiel wird beendet")
            break
            
        versuche_index += 1
    
    if versuch == geheimnis:
        protokoll.append("Sie haben es geschafft!")
    
    return protokoll

# Demonstration mit geheimnis = 1337
while_schleife_mit_break(1337)
```

### 2.3 Erkennen eines Schleifenabbruchs mit else

- Der else-Block einer Schleife wird ausgeführt, wenn die Schleife normal beendet wird
- Er wird nicht ausgeführt, wenn die Schleife durch break beendet wird

```python
def while_schleife_mit_else(geheimnis, abbruch_aktivieren=False):
    """
    Demonstriert die Verwendung eines else-Blocks bei einer while-Schleife.
    Der else-Block wird nur ausgeführt, wenn die Schleife normal beendet wird.
    
    Args:
        geheimnis: Die zu erratende Zahl
        abbruch_aktivieren: Wenn True, wird die Schleife vorzeitig mit break beendet
    """
    versuch = -1
    rateversuche = [500, 1000, 1337]  # Vordefinierte Rateversuche
    versuche_index = 0
    protokoll = []
    
    while versuch != geheimnis and versuche_index < len(rateversuche):
        versuch = rateversuche[versuche_index]
        protokoll.append(f"Raten Sie: {versuch}")
        
        # Bei Bedarf Schleife abbrechen
        if abbruch_aktivieren and versuche_index == 1:
            protokoll.append("Das Spiel wird beendet")
            break
            
        versuche_index += 1
    else:
        protokoll.append("Sie haben es geschafft!")
    
    return protokoll

# Demonstration ohne Abbruch
while_schleife_mit_else(1337, False)
```

```python
# Demonstration mit Abbruch
while_schleife_mit_else(1337, True)
```

### 2.4 Abbruch eines Schleifendurchlaufs mit continue

- Die continue-Anweisung bricht den aktuellen Schleifendurchlauf ab
- Die Schleife wird mit dem nächsten Durchlauf fortgesetzt

```python
def fakultaet_berechnen_mit_continue(zahlen):
    """
    Berechnet die Fakultät für eine Liste von Zahlen.
    Negative Zahlen werden übersprungen.
    
    Args:
        zahlen: Liste von Zahlen, für die die Fakultät berechnet werden soll
    """
    ergebnisse = []
    
    for zahl in zahlen:
        if zahl < 0:
            ergebnisse.append(f"Negative Zahlen sind nicht erlaubt: {zahl}")
            continue
            
        ergebnis = 1
        for i in range(2, zahl + 1):
            ergebnis *= i
            
        ergebnisse.append(f"Die Fakultät von {zahl} ist {ergebnis}")
    
    return ergebnisse

# Demonstration mit verschiedenen Zahlen
fakultaet_berechnen_mit_continue([4, 5, -10, 6])
```

### 2.5 Die for-Schleife

- Die for-Schleife wird verwendet, um über iterierbare Objekte zu iterieren
- Iterierbare Objekte sind z.B. Listen, Strings, Dictionaries

```python
def for_schleife_liste():
    """
    Demonstriert die Verwendung einer for-Schleife mit einer Liste.
    """
    ergebnisse = []
    
    for x in [1, 2, 3]:
        ergebnisse.append(x)
        
    return ergebnisse

# Demonstration
for_schleife_liste()
```

```python
def for_schleife_string():
    """
    Demonstriert die Verwendung einer for-Schleife mit einem String.
    """
    ergebnisse = []
    
    for c in "Python":
        ergebnisse.append(c)
        
    return ergebnisse

# Demonstration
for_schleife_string()
```

#### 2.5.1 Die for-Schleife als Zählschleife mit range()

- Die Funktion range() erzeugt eine Sequenz von Zahlen
- range(start, stop, step) erzeugt Zahlen von start bis stop-1 mit Schrittweite step

```python
def for_schleife_mit_range():
    """
    Demonstriert die Verwendung einer for-Schleife mit range().
    """
    ergebnisse = []
    
    # range(1, 10, 2) erzeugt die Zahlen 1, 3, 5, 7, 9
    for i in range(1, 10, 2):
        ergebnisse.append(i)
        
    return ergebnisse

# Demonstration
for_schleife_mit_range()
```

```python
def for_schleife_mit_range_rueckwaerts():
    """
    Demonstriert die Verwendung einer for-Schleife mit range() in umgekehrter Reihenfolge.
    """
    ergebnisse = []
    
    # range(10, 1, -2) erzeugt die Zahlen 10, 8, 6, 4, 2
    for i in range(10, 1, -2):
        ergebnisse.append(i)
        
    return ergebnisse

# Demonstration
for_schleife_mit_range_rueckwaerts()
```

```python
def fakultaet_mit_for_schleife(zahl):
    """
    Berechnet die Fakultät einer Zahl mit einer for-Schleife.
    """
    ergebnis = 1
    
    for i in range(2, zahl + 1):
        ergebnis *= i
        
    return ergebnis

# Demonstration mit zahl = 5
fakultaet_mit_for_schleife(5)
```

### 2.6 break, continue und else in for-Schleifen

- break und continue funktionieren in for-Schleifen genauso wie in while-Schleifen
- Der else-Block wird ausgeführt, wenn die Schleife normal beendet wird

```python
def for_schleife_mit_break_und_else(liste, suchwert):
    """
    Sucht in einer Liste nach einem Wert.
    Wenn der Wert gefunden wird, wird die Schleife mit break beendet.
    
    Args:
        liste: Die Liste, in der gesucht wird
        suchwert: Der gesuchte Wert
    """
    ergebnis = ""
    
    for element in liste:
        if element == suchwert:
            ergebnis = f"Wert {suchwert} gefunden!"
            break
    else:
        ergebnis = f"Wert {suchwert} nicht gefunden."
        
    return ergebnis

# Demonstration - Wert wird gefunden
for_schleife_mit_break_und_else([1, 2, 3, 4, 5], 3)
```

```python
# Demonstration - Wert wird nicht gefunden
for_schleife_mit_break_und_else([1, 2, 3, 4, 5], 6)
```

## 3. Die pass-Anweisung

- Die pass-Anweisung ist ein Platzhalter, der nichts tut
- Nützlich während der Entwicklung oder für leere Blöcke

```python
def pass_anweisung_beispiel(x):
    """
    Demonstriert die Verwendung der pass-Anweisung.
    """
    resultat = "Keine Aktion ausgeführt"
    
    if x == 1:
        pass  # Hier passiert nichts
    elif x == 2:
        resultat = "x hat den Wert 2"
        
    return resultat

# Demonstration mit x = 1
pass_anweisung_beispiel(1)
```

## 4. Zuweisungsausdrücke (Walrus-Operator)

- Der Walrus-Operator `:=` ermöglicht Zuweisungen innerhalb von Ausdrücken
- Eingeführt in Python 3.8

```python
def zuweisungsausdruck_demo(y):
    """
    Demonstriert die Verwendung des Walrus-Operators `:=`.
    """
    # Normale Zuweisung
    quadrat = y * y
    
    # Zuweisung und Verwendung in einem Ausdruck
    resultat = (z := y * y)
    
    return {
        "y": y,
        "quadrat (normale Zuweisung)": quadrat,
        "z (mit Walrus-Operator)": z,
        "resultat": resultat
    }

# Demonstration mit y = 10
zuweisungsausdruck_demo(10)
```

```python
def zuweisungsausdruck_in_bedingung(y):
    """
    Demonstriert die Verwendung des Walrus-Operators in einer Bedingung.
    """
    # Die Zuweisung erfolgt innerhalb der Bedingung
    if (z := y * y) >= 100:
        return f"Quadratzahl {z} ist größer oder gleich 100"
    else:
        return f"Quadratzahl {z} ist kleiner als 100"

# Demonstration mit y = 10
zuweisungsausdruck_in_bedingung(10)
```

### 4.1 Anwendungsbeispiel: Listenverarbeitung

- Vermeiden von doppelten Berechnungen

```python
def zuweisungsausdruck_listenpruefung(lst):
    """
    Prüft, ob eine Liste zu lang ist, und gibt eine Meldung mit der Länge aus.
    
    Args:
        lst: Die zu prüfende Liste
    """
    # Mit Zuweisungsausdruck - Länge wird nur einmal berechnet
    if (length := len(lst)) > 10:
        return f"Liste ist zu lang ({length} Elemente)"
    else:
        return f"Liste hat akzeptable Länge ({length} Elemente)"

# Demonstration mit einer Liste
zuweisungsausdruck_listenpruefung([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
```

### 4.2 Zahlenraten-Spiel mit Zuweisungsausdruck

- Eingabe und Überprüfung in einem Schritt

```python
def zahlenraten_mit_zuweisungsausdruck(geheimnis):
    """
    Implementiert das Zahlenraten-Spiel mit einem Zuweisungsausdruck.
    
    Args:
        geheimnis: Die zu erratende Zahl
    """
    rateversuche = [500, 1000, 0, 1337]  # Vordefinierte Rateversuche
    versuche_index = 0
    protokoll = []
    
    # Simulieren der Schleife mit vordefinierten Eingaben
    while versuche_index < len(rateversuche) and (versuch := rateversuche[versuche_index]) != geheimnis:
        protokoll.append(f"Raten Sie: {versuch}")
        
        if versuch == 0:
            protokoll.append("Das Spiel wird beendet")
            break
            
        elif versuch < geheimnis:
            protokoll.append("Zu klein")
        elif versuch > geheimnis:
            protokoll.append("Zu groß")
            
        versuche_index += 1
    else:
        if versuche_index < len(rateversuche):
            protokoll.append(f"Raten Sie: {versuch}")
            protokoll.append("Sie haben es geschafft!")
    
    return protokoll

# Demonstration
zahlenraten_mit_zuweisungsausdruck(1337)
```
