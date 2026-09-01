## 1. Beispielprogramme

### a) Einfache Bedingung (`if-else`):

```python
alter = int(input("Wie alt bist du? "))
if alter >= 18:
    print("Du bist volljährig.")
else:
    print("Du bist minderjährig.")
```

### b) Logische Operatoren (`AND`, `OR`, `NOT`):

```python
alter = int(input("Wie alt bist du? "))
student = input("Bist du Student? (ja/nein): ").lower() == "ja"

if alter >= 18 and student:
    print("Du bist ein volljähriger Student.")
if alter < 18 or student:
    print("Du bist entweder minderjährig oder Student.")
if not student:
    print("Du bist kein Student.")
```
### c) Ampelschaltung

```python
ampel = input("Welche Farbe hat die Ampel? (rot/gelb/grün): ").lower()

if ampel == "rot":
    print("Halt!")
elif ampel == "gelb":
    print("Vorsicht!")
elif ampel == "grün":
    print("Los!")
else:
    print("Ungültige Eingabe.")
```

### d) Verschachtelte Bedingungen (Wahlberechtigung):

```python
alter = int(input("Wie alt bist du? "))
nationalitaet = input("Welche Nationalität hast du? (deutsch/andere): ").lower()

if alter >= 18:
    if nationalitaet == "deutsch":
        print("Du darfst in Deutschland wählen.")
    else:
        print("Du bist volljährig, aber möglicherweise nicht wahlberechtigt.")
else:
    print("Du bist noch nicht wahlberechtigt.")
```

### e) `match-case` (ab Python 3.10):

```python
def wochenplan(tag):
    match tag:
        case "Montag":
            return "Start in die Arbeitswoche"
        case "Freitag":
            return "Fast Wochenende!"
        case "Samstag" | "Sonntag":
            return "Wochenende!"
        case _:
            return "Ein normaler Arbeitstag."

tag = input("Welcher Tag ist heute? ")
print(wochenplan(tag))
```

### f) Ternärer Operator:

```python
alter = int(input("Wie alt bist du? "))
status = "Volljährig" if alter >= 18 else "Minderjährig"
print(f"Du bist: {status}")
```

### g) Abschlussaufgabe – Komplexes Programm:

```python
name = input("Wie heißt du? ")
alter = int(input("Wie alt bist du? "))
wohnort = input("Wo wohnst du? ")

if alter >= 18:
    fahren = input("Möchtest du Auto fahren? (ja/nein): ").lower()
    if fahren == "ja":
        print(f"Hallo {name}! Du bist {alter} Jahre alt, wohnst in {wohnort} und darfst Auto fahren.")
    else:
        print(f"Hallo {name}! Du bist {alter} Jahre alt, wohnst in {wohnort} und möchtest kein Auto fahren.")
else:
    print(f"Hallo {name}! Du bist {alter} Jahre alt, wohnst in {wohnort} und darfst noch kein Auto fahren.")
```

## 2. Checkliste für die Gruppenarbeit und Fehlersuche

1. **Gruppenaufgaben vorbereiten:**
    
    - Klare Aufgabenstellung formulieren (z. B. Ampelschaltung, Wahlberechtigung).
    - Gruppen aufteilen (falls gewünscht).
    - Zeitrahmen kommunizieren (z. B. 30 Minuten für die Gruppenarbeit).
2. **Typische Fehler simulieren:**
    
    - **Syntaxfehler:**
        
        ```python
        if alter >= 18
            print("Du bist volljährig.")
        # Fehlermeldung: SyntaxError: expected ':'
        ```
        
    - **Typfehler:**
        
        ```python
        zahl = 5
        text = "Hallo"
        print(zahl + text)
        # Fehlermeldung: TypeError: unsupported operand type(s) for +: 'int' and 'str'
        ```
        
    - **Logischer Fehler:**
        
        ```python
        alter = 20
        if alter < 18:
            print("Volljährig")
        # Falsches Verhalten, da die Bedingung falsch definiert ist.
        ```
        
    - **Ungültige Eingabe:**
        
        ```python
        ampel = input("Welche Farbe hat die Ampel? ")
        if ampel == "rot" or "gelb" or "grün":
            print("Gültige Farbe")
        # Falsches Verhalten: Jede Eingabe wird als gültig betrachtet.
        ```
        
3. **Lösungen für die Fehlersimulationen:**
    
    - **Syntaxfehler:** Fehlenden Doppelpunkt hinzufügen.
    - **Typfehler:** `str(zahl) + text` verwenden oder sicherstellen, dass Datentypen übereinstimmen.
    - **Logischer Fehler:** Bedingungen korrekt definieren (z. B. `if alter >= 18:`).
    - **Ungültige Eingabe:** Bedingung korrigieren:
        
        ```python
        if ampel in ["rot", "gelb", "grün"]:
            print("Gültige Farbe")
        else:
            print("Ungültige Farbe")
        ```