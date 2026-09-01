## Python-Syntax Grundlagen

* Python verwendet eine klare, lesbare Syntax, die auf Einrückungen basiert
* Keine geschweiften Klammern oder Semikolons wie in anderen Sprachen
* [Weitere Informationen zur Python-Syntax](https://docs.python.org/3/reference/lexical_analysis.html)

## Einrückung und Zeilenumbrüche

* Einrückungen definieren Codeblöcke (meist 4 Leerzeichen pro Ebene)
* Konsistente Einrückung ist **zwingend erforderlich**
* Zeilenumbrüche beenden Anweisungen automatisch
* [PEP 8 Richtlinien zur Einrückung](https://peps.python.org/pep-0008/#indentation)

```python
# Beispiel für Einrückung
if True:
    print("Dies ist eingerückt")
    print("Dies auch")
print("Dies nicht mehr")
```

* Lange Zeilen können mit einem Backslash (`\`) oder innerhalb von Klammern umgebrochen werden

```python
# Lange Zeile umbrechen
summe = 1 + 2 + 3 + \
        4 + 5 + 6
summe
```

```python
# Oder innerhalb von Klammern (bevorzugt)
summe = (1 + 2 + 3 +
         4 + 5 + 6)
summe
```

## Kommentare und Codestruktur

* Einzeilige Kommentare beginnen mit `#`
* Mehrzeilige Kommentare werden mit dreifachen Anführungszeichen umschlossen
* Sinnvolle Kommentare erklären das "Warum", nicht das "Was"
* [Best Practices für Kommentare](https://realpython.com/python-comments-guide/)

```python
# Dies ist ein einzeiliger Kommentar

"""
Dies ist ein mehrzeiliger Kommentar.
Er kann über mehrere Zeilen gehen.
Wird auch für Docstrings verwendet.
"""
```

* Strukturieren Sie Ihren Code logisch mit Leerzeilen zwischen Funktionen und logischen Abschnitten
* Gruppieren Sie zusammengehörigen Code

## Grundlagen der Funktionsstruktur

* Funktionen sind wiederverwendbare Codeblöcke
* Sie helfen, Code zu organisieren und Wiederholungen zu vermeiden
* [Offizielle Python-Dokumentation zu Funktionen](https://docs.python.org/3/tutorial/controlflow.html#defining-functions)

### Einfache Funktionsdefinition mit `def`

* Funktionen werden mit dem Schlüsselwort `def` definiert
* Jede Funktion braucht einen eindeutigen Namen
* Namen sollten beschreiben, was die Funktion tut

```python
def begruessung():
    """Gibt eine einfache Begrüßung aus."""
    print("Hallo, willkommen zum Python-Kurs!")
```

```python
# Funktion ohne Parameter aufrufen
begruessung()
```

### Unterschied zwischen Argumenten und Parametern

- **Parameter** sind die Variablen, die in der Funktionsdefinition deklariert werden. Sie sind Platzhalter, die angeben, welche Daten die Funktion beim Aufruf erwartet.

- **Argumente** sind die tatsächlichen Werte, die beim Funktionsaufruf übergeben werden. Sie sind die konkreten Daten, die an die Parameter gebunden werden.

Hier ein einfaches Beispiel:

```python
# Funktionsdefinition mit dem PARAMETER "name"
def grüße(name):
    print(f"Hallo, {name}!")
```

```python
# Funktionsaufruf mit dem ARGUMENT "Maria"
grüße("Maria")
```

In diesem Beispiel:

- `name` ist der Parameter (der Platzhalter in der Funktionsdefinition)
- `"Maria"` ist das Argument (der konkrete Wert, der beim Aufruf übergeben wird)

Man kann es sich so merken: Parameter stehen in der Funktionsdefinition, Argumente werden bei der Ausführung übergeben. Die Parameter sind wie leere Behälter, die durch die Argumente mit Inhalt gefüllt werden.

```python
def vorstellen(name, alter):
    """
    Stellt eine Person mit Namen und Alter vor.
    
    Args:
        name (str): Der Name der Person
        alter (int): Das Alter der Person in Jahren
    
    Returns:
        str: Ein formatierter Vorstellungstext
    """
    vorstellung = f"Hallo, ich heiße {name} und bin {alter} Jahre alt."
    return vorstellung
```

```python
# Funktion mit mehreren Parametern aufrufen
vorstellen("Thomas", 28)
```

### Rückgabewerte mit `return`

* Funktionen können Werte zurückgeben mit dem Schlüsselwort `return`
* Nach einem `return` wird die Funktion sofort beendet
* Ohne `return` geben Funktionen `None` zurück
* [Mehr über Rückgabewerte](https://docs.python.org/3/reference/simple_stmts.html#the-return-statement)

```python
def quadrat(zahl):
    """Berechnet das Quadrat einer Zahl und gibt es zurück."""
    ergebnis = zahl * zahl
    return ergebnis
```

```python
# Rückgabewerte verwenden
ergebnis = quadrat(5)
print(f"Das Quadrat von 5 ist {ergebnis}")
```

* Funktionen können auch mehrere Werte zurückgeben

```python
def rechnen(zahl):
    """Berechnet Quadrat und Wurzel einer Zahl."""
    quadrat = zahl * zahl
    wurzel = zahl ** 0.5
    return quadrat, wurzel  # Gibt ein Tupel zurück
```

```python
# Mehrere Rückgabewerte empfangen
q, w = rechnen(9)
print(f"Quadrat: {q}, Wurzel: {w}")
```

### Funktionsaufrufe

* Funktionen werden durch ihren Namen gefolgt von Klammern aufgerufen
* Argumente werden in den Klammern übergeben
* [Funktion aufrufen erklärt](https://realpython.com/defining-your-own-python-function/#calling-functions)


## Erstes Python-Programm in Funktionsform

* Ein vollständiges Programm besteht aus mehreren Funktionen
* Die Hauptfunktion wird oft `main()` genannt
* [Struktur eines Python-Programms](https://realpython.com/python-main-function/)

```python
def eingabe_sammeln():
    """Sammelt Benutzereingaben."""
    name = input("Wie heißen Sie? ")
    alter = input("Wie alt sind Sie? ")
    return name, alter

def alter_in_tagen(alter_in_jahren):
    """Konvertiert Alter von Jahren in Tage."""
    try:
        alter_als_zahl = int(alter_in_jahren)
        tage = alter_als_zahl * 365
        return tage
    except ValueError:
        return None

def ergebnis_ausgeben(name, alter_in_tagen):
    """Gibt das Ergebnis formatiert aus."""
    if alter_in_tagen is not None:
        print(f"Hallo {name}! Sie sind ungefähr {alter_in_tagen} Tage alt.")
    else:
        print(f"Hallo {name}! Das eingegebene Alter ist keine gültige Zahl.")

def main():
    """Hauptfunktion des Programms."""
    print("Willkommen zum Altersrechner!")
    
    # Eingabe sammeln
    name, alter = eingabe_sammeln()
    
    # Berechnung durchführen
    tage = alter_in_tagen(alter)
    
    # Ergebnis ausgeben
    ergebnis_ausgeben(name, tage)
    
    print("Danke für die Nutzung des Programms!")

# Programmausführung starten
main()
```

## Programmierkonstrukte in Funktionen einbetten

* Alle Python-Konstrukte (Bedingungen, Schleifen usw.) können in Funktionen verwendet werden
* Funktionen sollten idealerweise einen Zweck erfüllen (Single Responsibility Principle)
* [Clean Code in Python](https://testdriven.io/blog/clean-code-python/)

```python
def ist_volljährig(alter):
    """Prüft, ob jemand volljährig ist."""
    if alter >= 18:
        return True
    else:
        return False
```

```python
ist_volljährig(67)
```

```python
def zahlen_addieren(zahlen_liste):
    """Addiert alle Zahlen in einer Liste."""
    summe = 0
    for zahl in zahlen_liste:
        summe += zahl
    return summe
```

```python
zahlen_addieren([1,2])
```

```python
def zähle_bis(limit):
    """Zählt von 1 bis zum angegebenen Limit."""
    zaehler = 1
    while zaehler <= limit:
        print(zaehler)
        zaehler += 1
```

```python
zähle_bis(10)
```

## Vorteile funktionsbasierten Codes

* **Wiederverwendbarkeit**: Code muss nicht mehrfach geschrieben werden
* **Lesbarkeit**: Funktionen mit beschreibenden Namen machen Code selbsterklärend
* **Wartbarkeit**: Fehler müssen nur an einer Stelle behoben werden
* **Testbarkeit**: Funktionen können isoliert getestet werden
* [Warum funktionsbasierter Code wichtig ist](https://www.geeksforgeeks.org/functional-programming-in-python/)

## Best Practices für Funktionen

* Funktionen sollten einen einzelnen Zweck erfüllen
* Namen sollten beschreiben, was die Funktion tut, nicht wie sie es tut
* Parameter sollten klar definiert sein
* Rückgabewerte sollten konsistent sein
* Docstrings zur Dokumentation verwenden
* [Python-Funktionen Best Practices](https://towardsdatascience.com/python-clean-code-6-best-practices-to-make-your-python-functions-more-readable-7ea4c6171d60)

```python
# Beispiel für eine gut gestaltete Funktion
def berechne_netto_gehalt(brutto_gehalt, steuer_prozent=19):
    """
    Berechnet das Nettogehalt nach Abzug der Steuern.
    
    Args:
        brutto_gehalt (float): Das Bruttogehalt in Euro
        steuer_prozent (float, optional): Der Steuersatz in Prozent. Standard ist 19%.
        
    Returns:
        float: Das berechnete Nettogehalt in Euro
        
    Raises:
        ValueError: Wenn brutto_gehalt negativ ist
    """
    if brutto_gehalt < 0:
        raise ValueError("Bruttogehalt kann nicht negativ sein")
    
    steuer_betrag = brutto_gehalt * (steuer_prozent / 100)
    netto_gehalt = brutto_gehalt - steuer_betrag
    
    return netto_gehalt
```

## Funktionen im Hinblick auf testgetriebene Entwicklung (TDD)

* Funktionen eignen sich hervorragend für testgetriebene Entwicklung
* Jede Funktion sollte einen klar definierten Input und Output haben
* Nebenwirkungen sollten minimiert werden
* [Einführung in Test-Driven Development](https://www.freecodecamp.org/news/learning-to-test-with-python-997ace2d8abe/)

```python
# Eine gut testbare Funktion
def ist_palindrom(text):
    """
    Prüft, ob ein Text ein Palindrom ist (vorwärts und rückwärts gleich).
    
    Args:
        text (str): Der zu prüfende Text
        
    Returns:
        bool: True wenn Palindrom, sonst False
    """
    # Leerzeichen entfernen und alles kleinschreiben
    bereinigter_text = text.replace(" ", "").lower()
    
    # Prüfen, ob der Text vorwärts und rückwärts gleich ist
    return bereinigter_text == bereinigter_text[::-1]
```

```python
# Diese Funktion kann einfach getestet werden:
# assert ist_palindrom("Anna") == True
# assert ist_palindrom("Python") == False

def assert_and_show(ausdruck, erwarteter_wert, name):
    """Testet einen Ausdruck und zeigt dessen Wert an."""
    ergebnis = ausdruck
    print(f"{name} = {ergebnis}")
    
    if ergebnis == erwarteter_wert:
        print(f"✓ Korrekt! {ergebnis} entspricht dem erwarteten Wert {erwarteter_wert}")
    else:
        print(f"✗ Fehler! {ergebnis} ist nicht gleich {erwarteter_wert}")
        assert ergebnis == erwarteter_wert, f"Test fehlgeschlagen"

# Anwendung
assert_and_show(ist_palindrom("Anna"), True, "ist_palindrom('Anna')")
assert_and_show(ist_palindrom("Python"), False, "ist_palindrom('Python')")
```

## Übungen

1. Schreiben Sie eine Funktion `celsius_zu_fahrenheit(celsius)`, die Celsius in Fahrenheit umrechnet
2. Erstellen Sie eine Funktion `durchschnitt(zahlen)`, die den Durchschnitt einer Liste von Zahlen berechnet
3. Schreiben Sie eine Funktion `ist_primzahl(zahl)`, die prüft, ob eine Zahl eine Primzahl ist
4. Entwickeln Sie ein kleines Programm mit mehreren Funktionen, das den Benutzer nach seinem Namen und Geburtsjahr fragt und dann sein Alter in Jahren, Monaten, Wochen und Tagen ausgibt

## Weiterführende Ressourcen

* [Python Dokumentation zu Funktionen](https://docs.python.org/3/tutorial/controlflow.html#defining-functions)
* [Real Python: Defining Your Own Python Function](https://realpython.com/defining-your-own-python-function/)
* [Python Function Arguments](https://www.programiz.com/python-programming/function-argument)
* [Functional Programming in Python](https://docs.python.org/3/howto/functional.html)
* [Python Testing with pytest](https://pragprog.com/titles/bopytest/python-testing-with-pytest/)
