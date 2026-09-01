## 1. For-Schleifen und range()-Funktion

- Eine `for`-Schleife in Python durchläuft eine festgelegte Sequenz von Elementen
- Die Syntax lautet: `for element in sequenz:`
- Die `range()`-Funktion generiert eine Sequenz von Zahlen für Iterationen
- Weitere Informationen zu `for`-Schleifen: [Python for Loops](https://docs.python.org/3/tutorial/controlflow.html#for-statements)
- Weitere Informationen zur `range()`-Funktion: [Python range()](https://docs.python.org/3/library/functions.html#func-range)

### Beispiel: Einfache for-Schleife mit range()

```python
def summe_berechnen(n):
    """
    Berechnet die Summe der Zahlen von 0 bis n-1 mit einer for-Schleife.
    
    Args:
        n: Obergrenze der Summation (exklusiv)
        
    Returns:
        Summe der Zahlen von 0 bis n-1
    """
    summe = 0
    for i in range(n):
        summe += i
    return summe
```

```python
# Funktionsaufruf mit n=10
summe_berechnen(10)
```

### Beispiel: Iteration über eine Liste

```python
def durchschnitt_berechnen(zahlen_liste):
    """
    Berechnet den Durchschnitt einer Liste von Zahlen.
    
    Args:
        zahlen_liste: Liste von Zahlen
        
    Returns:
        Durchschnitt der Zahlen in der Liste
    """
    if not zahlen_liste:
        return 0
    
    summe = 0
    for zahl in zahlen_liste:
        summe += zahl
    
    return summe / len(zahlen_liste)
```

```python
# Funktionsaufruf mit einer Liste von Zahlen
durchschnitt_berechnen([4, 8, 15, 16, 23, 42])
```

### Übung 1: Fakultät mit for-Schleife

- Implementiere eine Funktion, die die Fakultät n! mit einer for-Schleife berechnet

```python
def fakultaet(n):
    """
    Berechnet die Fakultät n! mit einer for-Schleife.
    
    Args:
        n: Positive ganze Zahl
        
    Returns:
        Fakultät n!
    """
    ergebnis = 1
    for i in range(1, n + 1):
        ergebnis *= i
    return ergebnis
```

```python
# Funktionsaufruf mit n=5
fakultaet(5)
```

## 2. While-Schleifen

- Eine `while`-Schleife führt einen Block Code aus, solange eine Bedingung wahr ist
- Die Syntax lautet: `while bedingung:`
- Besonders nützlich, wenn die Anzahl der Iterationen nicht im Voraus bekannt ist
- Wichtig: Die Abbruchbedingung muss irgendwann erfüllt werden, um Endlosschleifen zu vermeiden
- Weitere Informationen zu `while`-Schleifen: [Python while Loops](https://docs.python.org/3/reference/compound_stmts.html#the-while-statement)

### Beispiel: Einfache while-Schleife

```python
def countdown(start):
    """
    Generiert eine Liste mit einem Countdown von start bis 0.
    
    Args:
        start: Startwert des Countdowns
        
    Returns:
        Liste mit dem Countdown von start bis 0
    """
    countdown_liste = []
    zaehler = start
    
    while zaehler >= 0:
        countdown_liste.append(zaehler)
        zaehler -= 1
    
    return countdown_liste
```

```python
# Funktionsaufruf mit start=5
countdown(5)
```

### Beispiel: Zahlenraten mit while-Schleife (Simulation)

```python
def zahlenraten_simulation(geheimzahl, rateversuche):
    """
    Simuliert ein Zahlenratespiel, bei dem die Rateversuche nacheinander geprüft werden.
    
    Args:
        geheimzahl: Die zu erratende Zahl
        rateversuche: Liste mit Rateversuchen
        
    Returns:
        Tupel mit (erfolgreich erraten?, Anzahl benötigter Versuche)
    """
    versuche = 0
    gefunden = False
    index = 0
    
    while index < len(rateversuche) and not gefunden:
        versuch = rateversuche[index]
        versuche += 1
        
        if versuch == geheimzahl:
            gefunden = True
        else:
            index += 1
    
    return gefunden, versuche
```

```python
# Funktionsaufruf mit geheimzahl=42 und einer Liste von Rateversuchen
zahlenraten_simulation(42, [10, 20, 30, 40, 42, 50])
```

### Übung 2: Collatz-Folge mit while-Schleife

- Implementiere eine Funktion für die Collatz-Folge: Wenn n gerade ist, teile durch 2; wenn n ungerade ist, multipliziere mit 3 und addiere 1
- Die Folge endet, wenn n = 1 erreicht wird

```python
def collatz_folge(start):
    """
    Berechnet die Collatz-Folge für einen Startwert.
    
    Args:
        start: Positive ganze Zahl als Startwert
        
    Returns:
        Liste mit der Collatz-Folge
    """
    if start < 1:
        return []
    
    folge = [start]
    n = start
    
    while n != 1:
        if n % 2 == 0:  # n ist gerade
            n = n // 2
        else:  # n ist ungerade
            n = 3 * n + 1
        folge.append(n)
    
    return folge
```

```python
# Funktionsaufruf mit start=27
collatz_folge(27)
```

## 3. Break, Continue und Pass Statements

- `break`: Beendet die Schleife vollständig und fährt mit dem Code nach der Schleife fort
- `continue`: Überspringt den aktuellen Durchlauf und setzt mit dem nächsten Durchlauf fort
- `pass`: Platzhalter, der nichts tut - nützlich für leere Codeblöcke
- Weitere Informationen: [Python break and continue](https://docs.python.org/3/tutorial/controlflow.html#break-and-continue-statements-and-else-clauses-on-loops)

### Beispiel: Verwendung von break

```python
def finde_erste_primzahl(zahlen):
    """
    Findet die erste Primzahl in einer Liste von Zahlen.
    
    Args:
        zahlen: Liste von Zahlen
        
    Returns:
        Die erste gefundene Primzahl oder None, wenn keine Primzahl gefunden wurde
    """
    for zahl in zahlen:
        if zahl < 2:
            continue
            
        ist_primzahl = True
        for teiler in range(2, int(zahl**0.5) + 1):
            if zahl % teiler == 0:
                ist_primzahl = False
                break
                
        if ist_primzahl:
            return zahl
    
    return None
```

```python
# Funktionsaufruf mit einer Liste von Zahlen
finde_erste_primzahl([4, 6, 8, 9, 11, 12, 15])
```

### Beispiel: Verwendung von continue

```python
def summe_gerader_zahlen(zahlen):
    """
    Berechnet die Summe aller geraden Zahlen in einer Liste.
    
    Args:
        zahlen: Liste von Zahlen
        
    Returns:
        Summe der geraden Zahlen
    """
    summe = 0
    for zahl in zahlen:
        if zahl % 2 != 0:  # Ungerade Zahl
            continue
        summe += zahl
    return summe
```

```python
# Funktionsaufruf mit einer Liste von Zahlen
summe_gerader_zahlen([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
```

### Übung 3: Filterung mit break und continue

- Implementiere eine Funktion, die Zahlen aus einer Liste filtert, die durch 3 teilbar sind, aber abbricht, wenn eine Zahl größer als 50 gefunden wird

```python
def filtere_teilbar_durch_drei(zahlen):
    """
    Filtert Zahlen, die durch 3 teilbar sind, bricht ab, wenn eine Zahl > 50 gefunden wird.
    
    Args:
        zahlen: Liste von Zahlen
        
    Returns:
        Liste der durch 3 teilbaren Zahlen bis zum Abbruch
    """
    ergebnis = []
    
    for zahl in zahlen:
        if zahl > 50:
            break
        
        if zahl % 3 != 0:
            continue
            
        ergebnis.append(zahl)
    
    return ergebnis
```

```python
# Funktionsaufruf mit einer Liste von Zahlen
filtere_teilbar_durch_drei([3, 7, 9, 12, 15, 20, 51, 30, 60])
```

## 4. Schleifenoptimierung

- Die Effizienz von Schleifen kann die Leistung eines Programms erheblich beeinflussen
- Vermeidung unnötiger Berechnungen innerhalb von Schleifen
- Nutzung von Listenkomprehensionen für einfachere und schnellere Iteration
- Weitere Informationen zu Performanceoptimierung: [Python Performance Tips](https://wiki.python.org/moin/PythonSpeed/PerformanceTips)

### Beispiel: Optimierung durch Berechnung außerhalb der Schleife

```python
def quadratsumme_optimiert(n):
    """
    Berechnet die Summe der Quadrate von 1 bis n mit einer optimierten Schleife.
    
    Args:
        n: Obergrenze (inklusiv)
        
    Returns:
        Summe der Quadrate von 1 bis n
    """
    # Schlechtes Beispiel (zur Veranschaulichung)
    summe_schlecht = 0
    for i in range(1, n + 1):
        summe_schlecht += i * i
    
    # Optimiertes Beispiel
    summe_optimiert = 0
    for i in range(1, n + 1):
        summe_optimiert += i * i
    
    # Mathematische Formel (am effizientesten)
    summe_formel = n * (n + 1) * (2 * n + 1) // 6
    
    return {
        "iterativ": summe_optimiert,
        "formel": summe_formel
    }
```

```python
# Funktionsaufruf mit n=100
quadratsumme_optimiert(100)
```

### Beispiel: Listenkomprehension vs. for-Schleife

```python
def vergleiche_listenerzeugung(n):
    """
    Vergleicht verschiedene Methoden zur Erzeugung einer Liste mit Quadratzahlen.
    
    Args:
        n: Anzahl der Quadratzahlen
        
    Returns:
        Dictionary mit Ergebnissen beider Methoden
    """
    # Mit for-Schleife
    quadrate_for = []
    for i in range(1, n + 1):
        quadrate_for.append(i * i)
    
    # Mit Listenkomprehension
    quadrate_komprehension = [i * i for i in range(1, n + 1)]
    
    return {
        "for_schleife": quadrate_for,
        "listenkomprehension": quadrate_komprehension
    }
```

```python
# Funktionsaufruf mit n=10
vergleiche_listenerzeugung(10)
```

### Übung 4: Optimierung mit Listenkomprehension

- Implementiere eine Funktion, die alle Primzahlen bis n mit einer Listenkomprehension und dem Sieb des Eratosthenes berechnet

```python
def primzahlen_bis_n(n):
    """
    Berechnet alle Primzahlen bis n mit dem Sieb des Eratosthenes.
    
    Args:
        n: Obergrenze (inklusiv)
        
    Returns:
        Liste aller Primzahlen bis n
    """
    if n < 2:
        return []
    
    # Initialisiere ein Array mit True-Werten (potentielle Primzahlen)
    ist_prim = [True] * (n + 1)
    ist_prim[0] = ist_prim[1] = False
    
    # Sieb des Eratosthenes
    for i in range(2, int(n**0.5) + 1):
        if ist_prim[i]:
            # Markiere alle Vielfachen von i als keine Primzahlen
            for j in range(i*i, n + 1, i):
                ist_prim[j] = False
    
    # Listenkomprehension für die Erstellung der Primzahlenliste
    primzahlen = [i for i in range(2, n + 1) if ist_prim[i]]
    
    return primzahlen
```

```python
# Funktionsaufruf mit n=50
primzahlen_bis_n(50)
```

## 5. Schleifen in Funktionen kapseln

- Kapselung von Schleifen in Funktionen verbessert die Wiederverwendbarkeit
- Funktionen mit Schleifen können komplexe Berechnungen abstrahieren
- Ermöglicht bessere Strukturierung und Lesbarkeit des Codes
- Weitere Informationen zu Funktionen in Python: [Python Functions](https://docs.python.org/3/tutorial/controlflow.html#defining-functions)

### Beispiel: Mehrere verschachtelte Schleifen in Funktionen

```python
def multiplikationstabelle(n):
    """
    Erzeugt eine n x n Multiplikationstabelle.
    
    Args:
        n: Größe der Tabelle
        
    Returns:
        Zweidimensionale Liste mit der Multiplikationstabelle
    """
    tabelle = []
    
    for i in range(1, n + 1):
        zeile = []
        for j in range(1, n + 1):
            zeile.append(i * j)
        tabelle.append(zeile)
    
    return tabelle
```

```python
# Funktionsaufruf mit n=5
multiplikationstabelle(5)
```

### Beispiel: Rekursive Funktion mit Schleife kombiniert

```python
def fibonacci_optimiert(n):
    """
    Berechnet die n-te Fibonacci-Zahl iterativ.
    
    Args:
        n: Position in der Fibonacci-Folge (beginnend bei 0)
        
    Returns:
        Die n-te Fibonacci-Zahl
    """
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    
    fib_prev = 0
    fib_curr = 1
    
    for _ in range(2, n + 1):
        fib_next = fib_prev + fib_curr
        fib_prev = fib_curr
        fib_curr = fib_next
    
    return fib_curr
```

```python
# Funktionsaufruf mit n=10
fibonacci_optimiert(10)
```

### Übung 5: Verschachtelte Schleifen in einer Funktion

- Implementiere eine Funktion, die ein Pascalsches Dreieck mit n Zeilen erzeugt

```python
def pascalsches_dreieck(n):
    """
    Erzeugt ein Pascalsches Dreieck mit n Zeilen.
    
    Args:
        n: Anzahl der Zeilen
        
    Returns:
        Liste von Listen, die das Pascalsche Dreieck darstellen
    """
    dreieck = []
    
    for i in range(n):
        zeile = []
        for j in range(i + 1):
            # Erste und letzte Zahl in jeder Zeile ist 1
            if j == 0 or j == i:
                zeile.append(1)
            else:
                # Sonst ist es die Summe der beiden Zahlen darüber
                zeile.append(dreieck[i-1][j-1] + dreieck[i-1][j])
        dreieck.append(zeile)
    
    return dreieck
```

```python
# Funktionsaufruf mit n=6
pascalsches_dreieck(6)
```

## 6. Rückgabewerte aus schleifenbasierten Funktionen

- Schleifen können verschiedene Arten von Rückgabewerten erzeugen
- Eine Schleife kann vorzeitig mit `return` verlassen werden
- Oft werden Aggregationen (Listen, Dictionaries, Summen, etc.) zurückgegeben
- Weitere Informationen zu Funktionsrückgabewerten: [Python Return Statement](https://docs.python.org/3/reference/simple_stmts.html#the-return-statement)

### Beispiel: Frühzeitige Rückgabe aus einer Schleife

```python
def finde_element(liste, element):
    """
    Sucht ein Element in einer Liste und gibt seinen Index zurück.
    
    Args:
        liste: Die zu durchsuchende Liste
        element: Das gesuchte Element
        
    Returns:
        Index des Elements oder -1, wenn nicht gefunden
    """
    for i, item in enumerate(liste):
        if item == element:
            return i  # Frühzeitige Rückgabe bei Fund
    
    return -1  # Element nicht gefunden
```

```python
# Funktionsaufruf mit einer Liste und einem gesuchten Element
finde_element(["Apfel", "Banane", "Kirsche", "Dattel"], "Kirsche")
```

### Beispiel: Rückgabe unterschiedlicher Datenstrukturen

```python
def analysiere_zahlen(zahlen):
    """
    Analysiert eine Liste von Zahlen und gibt verschiedene Statistiken zurück.
    
    Args:
        zahlen: Liste von Zahlen
        
    Returns:
        Dictionary mit verschiedenen statistischen Kennwerten
    """
    if not zahlen:
        return {
            "summe": 0,
            "durchschnitt": 0,
            "minimum": None,
            "maximum": None,
            "gerade": [],
            "ungerade": []
        }
    
    summe = 0
    minimum = zahlen[0]
    maximum = zahlen[0]
    gerade = []
    ungerade = []
    
    for zahl in zahlen:
        summe += zahl
        
        if zahl < minimum:
            minimum = zahl
        if zahl > maximum:
            maximum = zahl
            
        if zahl % 2 == 0:
            gerade.append(zahl)
        else:
            ungerade.append(zahl)
    
    return {
        "summe": summe,
        "durchschnitt": summe / len(zahlen),
        "minimum": minimum,
        "maximum": maximum,
        "gerade": gerade,
        "ungerade": ungerade
    }
```

```python
# Funktionsaufruf mit einer Liste von Zahlen
analysiere_zahlen([3, 7, 2, 8, 5, 10, 4, 1])
```

### Übung 6: Komplexe Rückgabewerte

- Implementiere eine Funktion, die einen Text auf Buchstabenhäufigkeit analysiert und ein nach Häufigkeit sortiertes Dictionary zurückgibt

```python
def buchstabenhaeufigkeit(text):
    """
    Analysiert die Häufigkeit jedes Buchstabens in einem Text.
    
    Args:
        text: Der zu analysierende Text
        
    Returns:
        Dictionary mit Buchstaben als Schlüssel und Häufigkeiten als Werte,
        sortiert nach Häufigkeit (absteigend)
    """
    haeufigkeit = {}
    
    # Nur Buchstaben berücksichtigen und Groß-/Kleinschreibung ignorieren
    for zeichen in text.lower():
        if zeichen.isalpha():
            if zeichen in haeufigkeit:
                haeufigkeit[zeichen] += 1
            else:
                haeufigkeit[zeichen] = 1
    
    # Sortiere nach Häufigkeit (absteigend)
    sortiert = dict(sorted(
        haeufigkeit.items(),
        key=lambda item: item[1],
        reverse=True
    ))
    
    return sortiert
```

```python
# Funktionsaufruf mit einem Text
buchstabenhaeufigkeit("Python ist eine tolle Programmiersprache!")
```

## Zusammenfassung

- `for`-Schleifen eignen sich für Iterationen über bekannte Sequenzen
- `while`-Schleifen sind nützlich bei unbekannter Iterationsanzahl
- `break`, `continue` und `pass` dienen der Schleifensteuerung
- Optimierte Schleifen verbessern die Programmleistung
- Das Kapseln von Schleifen in Funktionen erhöht die Wiederverwendbarkeit
- Funktionen mit Schleifen können vielfältige Rückgabewerte liefern

## Weiterführende Ressourcen

- [Python Official Documentation on Control Flow](https://docs.python.org/3/tutorial/controlflow.html)
- [Real Python: Python for Loops](https://realpython.com/python-for-loop/)
- [Real Python: Python while Loops](https://realpython.com/python-while-loop/)
- [Python Optimierung und Best Practices](https://docs.python-guide.org/writing/style/)
