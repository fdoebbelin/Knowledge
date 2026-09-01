## Bedingte Anweisungen (if, elif, else)

- Ermöglichen die Ausführung von Code nur unter bestimmten Bedingungen
- Grundstruktur: `if` für die erste Bedingung, `elif` für weitere Bedingungen, `else` für den Fall, dass keine Bedingung zutrifft
- [Offizielle Python-Dokumentation zu Kontrollstrukturen](https://docs.python.org/3/tutorial/controlflow.html)

```python
def pruefe_alter(alter):
    if alter < 18:
        ergebnis = "Minderjährig"
    elif alter < 21:
        ergebnis = "Volljährig, aber unter 21"
    else:
        ergebnis = "Volljährig und 21 oder älter"
    
    return ergebnis
```

```python
# Funktionsaufruf mit alter = 16
pruefe_alter(16)
```

```python
# Funktionsaufruf mit alter = 19
pruefe_alter(19)
```

```python
# Funktionsaufruf mit alter = 25
pruefe_alter(25)
```

## Vergleichsoperatoren (==, !=, <, >, <=, >=)

- Werden in Bedingungen verwendet, um Werte zu vergleichen
- `==`: Gleichheit, `!=`: Ungleichheit
- `<`: Kleiner als, `>`: Größer als
- `<=`: Kleiner oder gleich, `>=`: Größer oder gleich
- [Python-Dokumentation zu Vergleichsoperatoren](https://docs.python.org/3/library/stdtypes.html#comparisons)

```python
def vergleiche_zahlen(a, b):
    ergebnisse = {}
    
    ergebnisse["a == b"] = a == b
    ergebnisse["a != b"] = a != b
    ergebnisse["a < b"] = a < b
    ergebnisse["a > b"] = a > b
    ergebnisse["a <= b"] = a <= b
    ergebnisse["a >= b"] = a >= b
    
    return ergebnisse
```

```python
# Vergleich von a=5 und b=10
vergleiche_zahlen(5, 10)
```

```python
# Vergleich von a=7 und b=7
vergleiche_zahlen(7, 7)
```

```python
# Vergleich von a=10 und b=5
vergleiche_zahlen(10, 5)
```

## Logische Operatoren (and, or, not)

- Verbinden mehrere Bedingungen miteinander
- `and`: Beide Bedingungen müssen wahr sein
- `or`: Mindestens eine der Bedingungen muss wahr sein
- `not`: Kehrt den Wahrheitswert einer Bedingung um
- [Python-Dokumentation zu Booleschen Operatoren](https://docs.python.org/3/library/stdtypes.html#boolean-operations-and-or-not)

```python
def pruefe_logische_operatoren(bedingung1, bedingung2):
    ergebnisse = {}
    
    ergebnisse["bedingung1 and bedingung2"] = bedingung1 and bedingung2
    ergebnisse["bedingung1 or bedingung2"] = bedingung1 or bedingung2
    ergebnisse["not bedingung1"] = not bedingung1
    ergebnisse["not bedingung2"] = not bedingung2
    
    return ergebnisse
```

```python
# Beispiel mit True und False
pruefe_logische_operatoren(True, False)
```

```python
# Beispiel mit True und True
pruefe_logische_operatoren(True, True)
```

```python
# Beispiel mit False und False
pruefe_logische_operatoren(False, False)
```

## Verschachtelte Bedingungen

- Bedingungen können ineinander verschachtelt werden
- Verbessert die Lesbarkeit durch Verwendung logischer Operatoren
- [Artikel über verschachtelte Bedingungen](https://realpython.com/python-conditional-statements/)

```python
def kategorisiere_person(alter, student):
    if alter < 18:
        if student:
            kategorie = "Minderjähriger Student"
        else:
            kategorie = "Minderjährige Person"
    else:
        if student:
            kategorie = "Volljähriger Student"
        else:
            kategorie = "Volljährige Person"
    
    return kategorie
```

```python
# Person: 16 Jahre alt, Student
kategorisiere_person(16, True)
```

```python
# Person: 16 Jahre alt, kein Student
kategorisiere_person(16, False)
```

```python
# Person: 25 Jahre alt, Student
kategorisiere_person(25, True)
```

```python
# Person: 25 Jahre alt, kein Student
kategorisiere_person(25, False)
```

```python
def kategorisiere_person_logisch(alter, student):
    # Alternative mit logischen Operatoren statt verschachtelten Bedingungen
    if alter < 18 and student:
        kategorie = "Minderjähriger Student"
    elif alter < 18 and not student:
        kategorie = "Minderjährige Person"
    elif alter >= 18 and student:
        kategorie = "Volljähriger Student"
    else:  # alter >= 18 and not student
        kategorie = "Volljährige Person"
    
    return kategorie
```

```python
# Person: 16 Jahre alt, Student
kategorisiere_person_logisch(16, True)
```

## Ternäre Operatoren

- Kompakte Schreibweise für einfache bedingte Anweisungen
- Syntax: `wert_wenn_wahr if bedingung else wert_wenn_falsch`
- Verbessert die Lesbarkeit bei einfachen Bedingungen
- [Python-Dokumentation zu bedingten Ausdrücken](https://docs.python.org/3/reference/expressions.html#conditional-expressions)

```python
def status_mit_if_else(punkte):
    if punkte >= 50:
        return "Bestanden"
    else:
        return "Nicht bestanden"
```

```python
# Prüfung mit 65 Punkten
status_mit_if_else(65)
```

```python
# Prüfung mit 40 Punkten
status_mit_if_else(40)
```

```python
def status_mit_ternaer(punkte):
    # Gleiche Funktion mit ternärem Operator
    return "Bestanden" if punkte >= 50 else "Nicht bestanden"
```

```python
# Prüfung mit 65 Punkten
status_mit_ternaer(65)
```

```python
# Prüfung mit 40 Punkten
status_mit_ternaer(40)
```

```python
def max_mit_ternaer(a, b):
    # Maximum zweier Zahlen mit ternärem Operator
    return a if a > b else b
```

```python
# Maximum von 8 und 12
max_mit_ternaer(8, 12)
```

```python
# Maximum von 15 und 7
max_mit_ternaer(15, 7)
```

## Bedingte Anweisungen in Funktionen

- Ermöglichen flexibles Verhalten von Funktionen basierend auf Eingabeparametern
- Können für Validierung, verschiedene Berechnungsmethoden oder Fehlerbehebung verwendet werden
- [Artikel über Funktionen mit bedingten Anweisungen](https://realpython.com/defining-your-own-python-function/)

```python
def berechne_preis(grundpreis, alter, student=False):
    rabatt = 0
    
    # Rabatt für Studenten
    if student:
        rabatt += 0.1  # 10% Rabatt
    
    # Altersrabatt
    if alter < 12:
        rabatt += 0.5  # 50% Rabatt
    elif alter >= 65:
        rabatt += 0.2  # 20% Rabatt
    
    # Begrenzung des Gesamtrabatts auf 60%
    if rabatt > 0.6:
        rabatt = 0.6
        
    endpreis = grundpreis * (1 - rabatt)
    return endpreis
```

```python
# Grundpreis: 100, Alter: 25, kein Student
berechne_preis(100, 25)
```

```python
# Grundpreis: 100, Alter: 25, Student
berechne_preis(100, 25, student=True)
```

```python
# Grundpreis: 100, Alter: 10, kein Student
berechne_preis(100, 10)
```

```python
# Grundpreis: 100, Alter: 10, Student
berechne_preis(100, 10, student=True)
```

```python
# Grundpreis: 100, Alter: 70, kein Student
berechne_preis(100, 70)
```

```python
def validiere_eingabe(wert, typ, minimum=None, maximum=None):
    # Überprüft, ob der Wert vom gewünschten Typ ist
    if not isinstance(wert, typ):
        return False
    
    # Überprüft, ob der Wert im gewünschten Bereich liegt (falls angegeben)
    if minimum is not None and wert < minimum:
        return False
    
    if maximum is not None and wert > maximum:
        return False
    
    return True
```

```python
# Validierung: Zahl vom Typ int zwischen 1 und 10
validiere_eingabe(5, int, 1, 10)
```

```python
# Validierung: Zahl vom Typ int zwischen 1 und 10 (außerhalb des Bereichs)
validiere_eingabe(15, int, 1, 10)
```

```python
# Validierung: Text vom Typ str mit Mindestlänge 3
validiere_eingabe("Python", str, 3)
```

## Übungen und Aufgaben

1. Schreiben Sie eine Funktion `noten_umrechner`, die Punktzahlen (0-100) in deutsche Schulnoten (1-6) umrechnet:
   - 90-100 Punkte: Note 1
   - 75-89 Punkte: Note 2
   - 60-74 Punkte: Note 3
   - 45-59 Punkte: Note 4
   - 15-44 Punkte: Note 5
   - 0-14 Punkte: Note 6

2. Erstellen Sie eine Funktion `ist_schaltjahr`, die prüft, ob ein Jahr ein Schaltjahr ist. Die Regeln sind:
   - Ein Jahr ist ein Schaltjahr, wenn es durch 4 teilbar ist
   - Ausnahme: Jahre, die durch 100 teilbar sind, sind keine Schaltjahre
   - Ausnahme der Ausnahme: Jahre, die durch 400 teilbar sind, sind doch Schaltjahre

3. Implementieren Sie eine Funktion `taschenrechner`, die zwei Zahlen und einen Operator ('+', '-', '*', '/') als Parameter erhält und das Ergebnis der entsprechenden Operation zurückgibt. Bei Division durch Null soll die Funktion einen Text mit einem Fehlerhinweis zurückgeben.

4. Schreiben Sie eine Funktion `pruefe_passwort`, die die Stärke eines Passworts bewertet. Das Passwort sollte:
   - Mindestens 8 Zeichen lang sein
   - Mindestens einen Großbuchstaben enthalten
   - Mindestens einen Kleinbuchstaben enthalten
   - Mindestens eine Zahl enthalten
   Die Funktion soll "Stark", "Mittel" oder "Schwach" zurückgeben, je nachdem, wie viele der Kriterien erfüllt sind.

5. Entwickeln Sie eine Funktion `berechne_bmi`, die Gewicht (in kg) und Größe (in m) als Parameter erhält und den Body Mass Index (BMI) berechnet und eine Kategorisierung zurückgibt:
   - Untergewicht: BMI < 18.5
   - Normalgewicht: 18.5 <= BMI < 25
   - Übergewicht: 25 <= BMI < 30
   - Adipositas: BMI >= 30

```python
# Musterlösung für Aufgabe 1
def noten_umrechner(punkte):
    if punkte >= 90 and punkte <= 100:
        return 1
    elif punkte >= 75 and punkte <= 89:
        return 2
    elif punkte >= 60 and punkte <= 74:
        return 3
    elif punkte >= 45 and punkte <= 59:
        return 4
    elif punkte >= 15 and punkte <= 44:
        return 5
    elif punkte >= 0 and punkte <= 14:
        return 6
    else:
        return "Ungültige Punktzahl"
```

```python
# Test der Musterlösung mit 95 Punkten
noten_umrechner(95)
```

```python
# Test der Musterlösung mit 65 Punkten
noten_umrechner(65)
```

```python
# Test der Musterlösung mit 10 Punkten
noten_umrechner(10)
```
