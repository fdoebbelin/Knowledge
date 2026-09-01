Testbare Funktionen sind ein wichtiger Bestandteil von wartbarem Code. In diesem Dokument lernen Sie die Grundlagen kennen, wie Sie Funktionen in Python schreiben können, die leicht zu testen sind.

## Grundprinzipien testbarer Funktionen

- **Klar definierte Ein- und Ausgaben**: Testbare Funktionen haben eine präzise Definition, was hineingeht und was herauskommt
- **Einzelverantwortlichkeit (Single Responsibility Principle)**: Jede Funktion sollte nur einen Zweck erfüllen
- **Vermeidung von Seiteneffekten**: Funktionen sollten keine globalen Zustände ändern
- **Determinismus**: Gleiche Eingabe sollte immer zur gleichen Ausgabe führen
- **Eingabevalidierung**: Ungültige Werte sollten frühzeitig erkannt werden

## Beispiel: Temperaturumrechnung mit Validierung

```python
def celsius_zu_fahrenheit(celsius):
    """
    Rechnet Temperatur von Celsius in Fahrenheit um.
    
    Args:
        celsius (float): Temperatur in Grad Celsius
        
    Returns:
        float: Temperatur in Grad Fahrenheit
        
    Raises:
        TypeError: Wenn celsius kein numerischer Wert ist
        ValueError: Wenn celsius unter dem absoluten Nullpunkt (-273.15°C) liegt
    """
    # Typvalidierung
    if not isinstance(celsius, (int, float)):
        raise TypeError("Die Temperatur muss eine Zahl sein")
    
    # Bereichsvalidierung
    if celsius < -273.15:
        raise ValueError("Die Temperatur kann nicht unter dem absoluten Nullpunkt liegen")
    
    # Umrechnung
    fahrenheit = (celsius * 9/5) + 32
    
    return fahrenheit
```

```python
# Test mit gültigem Wert: Gefrierpunkt
celsius_zu_fahrenheit(celsius=0)
```

```python
# Test mit gültigem Wert: Siedepunkt
celsius_zu_fahrenheit(celsius=100)
```

```python
# Test mit ungültigem Typ
try:
    celsius_zu_fahrenheit(celsius="20")
except TypeError as e:
    print(str(e))
```

```python
# Test mit Wert unter dem absoluten Nullpunkt
try:
    celsius_zu_fahrenheit(celsius=-300)
except ValueError as e:
    print(str(e))
```

Diese Funktion zeigt mehrere wichtige Aspekte testbarer Funktionen:

1. Sie validiert die Eingabedaten (Typ und Wertebereich)
2. Sie wirft aussagekräftige Ausnahmen bei ungültigen Eingaben
3. Sie erledigt genau eine Aufgabe (Umrechnung von Celsius in Fahrenheit)
4. Sie ist deterministisch (gleiche Eingabe führt immer zur gleichen Ausgabe)

## Reine vs. unreine Funktionen

Eine besonders wichtige Eigenschaft testbarer Funktionen ist, dass sie **keine Seiteneffekte** haben. 
Solche Funktionen werden als "**reine Funktionen**" bezeichnet.

```python
# Unreine Funktion mit Seiteneffekt
ergebnis_liste = []

def addiere_mit_seiteneffekt(a, b):
    """Diese Funktion hat einen Seiteneffekt auf eine globale Variable."""
    summe = a + b
    ergebnis_liste.append(summe)  # Seiteneffekt
    return summe
```

```python
# Aufruf der unreinen Funktion
resultat_unrein = addiere_mit_seiteneffekt(3, 4)
print(f"Rückgabewert: {resultat_unrein}")
print(f"Seiteneffekt auf globale Liste: {ergebnis_liste}")
```

```python
# Reine Funktion ohne Seiteneffekt
def addiere_rein(a, b):
    """Diese Funktion ist rein und hat keine Seiteneffekte."""
    return a + b
```

```python
# Aufruf der reinen Funktion
resultat_rein = addiere_rein(3, 4)
print(f"Rückgabewert: {resultat_rein}")
# Keine Seiteneffekte, keine Änderung globaler Variablen
```

Der Unterschied zwischen diesen beiden Funktionen ist, dass `addiere_mit_seiteneffekt` eine globale Variable verändert, während `addiere_rein` nur einen Wert zurückgibt, ohne andere Teile des Programms zu beeinflussen.

## Unit Tests für Funktionen

Testbare Funktionen lassen sich gut mit Unit Tests überprüfen. Im folgenden Beispiel sehen wir eine Palindrom-Prüffunktion und einige Testfälle dafür.

```python
def ist_palindrom(text):
    """
    Prüft, ob ein Text ein Palindrom ist.
    
    Ein Palindrom liest sich vorwärts und rückwärts gleich.
    Leerzeichen und Groß-/Kleinschreibung werden ignoriert.
    
    Args:
        text (str): Der zu prüfende Text
        
    Returns:
        bool: True, wenn der Text ein Palindrom ist, sonst False
        
    Raises:
        TypeError: Wenn text kein String ist
    """
    if not isinstance(text, str):
        raise TypeError("Der Text muss ein String sein")
    
    # Entferne Leerzeichen und konvertiere zu Kleinbuchstaben
    text = text.replace(" ", "").lower()
    
    # Vergleiche den Text mit seiner umgekehrten Version
    return text == text[::-1]
```

```python
# Einfache Testfälle
testfälle = [
    {"input": "Anna", "expected": True},
    {"input": "Ein Neger mit Gazelle zagt im Regen nie", "expected": True},
    {"input": "Hello World", "expected": False},
    {"input": "A man a plan a canal Panama", "expected": True},
    {"input": "", "expected": True},  # Leerer String ist ein Palindrom
    {"input": "ab ba", "expected": True}
]

# Tests ausführen und Ergebnisse anzeigen
for i, test in enumerate(testfälle, 1):
    versuch = test["input"]
    erwartet = test["expected"]
    
    try:
        ergebnis = ist_palindrom(versuch)
        erfolg = ergebnis == erwartet
        print(f"Test {i}: '{versuch}'")
        print(f"  Erwartet: {erwartet}")
        print(f"  Erhalten: {ergebnis}")
        print(f"  Bestanden: {erfolg}")
    except Exception as e:
        print(f"Test {i}: '{versuch}'")
        print(f"  Fehler: {str(e)}")
        print(f"  Bestanden: False")
    print()
```

```python
# Sonderfälle testen
try:
    ist_palindrom(12345)
    print("Test mit Nicht-String: Fehlgeschlagen - Es wurde keine TypeError-Ausnahme ausgelöst")
except TypeError:
    print("Test mit Nicht-String: Bestanden - TypeError korrekt ausgelöst")
```

In diesem Beispiel testen wir die `ist_palindrom`-Funktion mit verschiedenen Eingaben, um zu überprüfen, ob sie korrekt funktioniert.

## Zusammenfassung

Testbare Funktionen zeichnen sich durch folgende Eigenschaften aus:

1. **Klarheit**: Eindeutige Ein- und Ausgabeparameter
2. **Einzelverantwortlichkeit**: Eine Funktion, eine Aufgabe
3. **Keine Seiteneffekte**: Funktionen ändern keinen externen Zustand
4. **Validierung**: Überprüfung der Eingabedaten
5. **Deterministisches Verhalten**: Gleiche Eingabe = gleiche Ausgabe
6. **Testbarkeit**: Leicht mit automatisierten Tests zu überprüfen

Diese Prinzipien führen zu robusterem, wartbarerem Code und erleichtern das Debugging erheblich.

## Weiterführende Ressourcen

- [Python Testing Documentation](https://docs.python.org/3/library/unittest.html)
- [Real Python: Python Testing](https://realpython.com/python-testing/)
- [Test-Driven Development with Python](https://www.obeythetestinggoat.com/)
