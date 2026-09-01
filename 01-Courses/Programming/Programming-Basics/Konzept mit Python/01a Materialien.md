
## 1. Beispielcodes

**a) "Hello World"-Programm (Python):**

```python
# Hello World Beispielprogramm
print("Hello World!")
```

**b) Programm mit Eingabe und Ausgabe:**

```python
# Programm zur Begrüßung des Benutzers
name = input("Wie heißt du? ")
print(f"Hallo, {name}!")
```

**c) Variablen-Beispiel (mit Datentypen):**

```python
# Verschiedene Datentypen
alter = 25  # Ganzzahl (int)
name = "Anna"  # Zeichenkette (string)
ist_volljaehrig = alter >= 18  # Boolean (bool)
print(f"{name} ist volljährig: {ist_volljaehrig}")
```

**d) Taschenrechner (einfache Addition):**

```python
# Einfacher Taschenrechner
zahl1 = float(input("Gib die erste Zahl ein: "))
zahl2 = float(input("Gib die zweite Zahl ein: "))
ergebnis = zahl1 + zahl2
print(f"Das Ergebnis ist: {ergebnis}")
```

**e) Erweiterter Taschenrechner (Nutzer wählt Rechenoperation):**

```python
# Erweiterter Taschenrechner
zahl1 = float(input("Gib die erste Zahl ein: "))
zahl2 = float(input("Gib die zweite Zahl ein: "))
operation = input("Welche Operation möchtest du durchführen? (+, -, *, /): ")

if operation == "+":
    ergebnis = zahl1 + zahl2
elif operation == "-":
    ergebnis = zahl1 - zahl2
elif operation == "*":
    ergebnis = zahl1 * zahl2
elif operation == "/":
    if zahl2 != 0:
        ergebnis = zahl1 / zahl2
    else:
        ergebnis = "Fehler: Division durch Null!"
else:
    ergebnis = "Ungültige Operation!"

print(f"Das Ergebnis ist: {ergebnis}")
```

## 2. Checkliste zur Installation der IDE (z. B. Visual Studio Code)

1. **Download:**
    - Besuchen Sie die offizielle Webseite von Visual Studio Code:  
        [https://code.visualstudio.com/](https://code.visualstudio.com/)
    - Laden Sie die Installationsdatei für Ihr Betriebssystem herunter (Windows, macOS, Linux).
2. **Installation:**
    - Öffnen Sie die heruntergeladene Installationsdatei.
    - Folgen Sie dem Installationsassistenten:
        - Standardverzeichnis wählen.
        - Option „Code in Rechtsklick-Menü hinzufügen“ aktivieren.
3. **Erste Einrichtung:**
    - Starten Sie Visual Studio Code.
    - Installieren Sie die Python-Erweiterung:
        - Gehen Sie zu „Erweiterungen“ (Symbol links: Viereck).
        - Suchen Sie nach „Python“ und klicken Sie auf „Installieren“.
4. **Python-Interpreter einrichten:**
    - Stellen Sie sicher, dass Python auf dem System installiert ist.
    - Laden Sie ggf. Python herunter: [https://www.python.org/](https://www.python.org/).
    - In Visual Studio Code:
        - Drücken Sie `Strg + Shift + P` und wählen Sie „Python: Interpreter auswählen“.
        - Wählen Sie die passende Python-Version aus.
5. **Testlauf:**
    - Erstellen Sie eine neue Datei (`Dateiname.py`).
    - Fügen Sie den Code ein:
        
        ```python
        print("Installation erfolgreich!")
        ```
        
    - Starten Sie das Programm über das „Play“-Symbol oben rechts oder mit `F5`.

## 3. Liste möglicher Aufgaben und Fehlersimulationen

**a) Aufgaben:**

1. **"Hello World":**
    - Schreiben Sie ein Programm, das "Hello World!" auf der Konsole ausgibt.
    - Erweiterung: Lassen Sie den Benutzer einen Text eingeben und geben Sie diesen zurück.
2. **Begrüßung mit Eingabe:**
    - Ein Programm, das den Benutzer nach seinem Namen fragt und ihn begrüßt.
    - Erweiterung: Erweitern Sie das Programm, um Alter oder Lieblingsfarbe einzulesen.
3. **Berechnung des Flächeninhalts:**
    - Schreiben Sie ein Programm, das die Länge und Breite eines Rechtecks einliest und die Fläche berechnet.
    - Erweiterung: Fügen Sie eine Abfrage für die Maßeinheit hinzu (z. B. Meter oder Zentimeter).
4. **Einfacher Taschenrechner:**
    - Ein Programm, das zwei Zahlen einliest und deren Summe ausgibt.
    - Erweiterung: Lassen Sie den Benutzer die Rechenoperation auswählen (Addition, Subtraktion, Multiplikation, Division).

**b) Fehlersimulationen:**

1. **Syntaxfehler:**
    - Vergessen eines Doppelpunktes:
        
        ```python
        if zahl1 > 10
            print("Zahl ist größer als 10")
        ```
        
        **Erwartetes Ergebnis:** `SyntaxError`.
2. **Typfehler:**
    - Versuch, eine Zeichenkette mit einer Zahl zu addieren:
        
        ```python
        zahl = 5
        text = "Hallo"
        print(zahl + text)
        ```
        
        **Erwartetes Ergebnis:** `TypeError`.
3. **Division durch Null:**
    - Falsche Eingabe, z. B.:
        
        ```python
        ergebnis = 10 / 0
        ```
        
        **Erwartetes Ergebnis:** `ZeroDivisionError`.
4. **Falscher Variablenname:**
    - Referenz auf eine nicht existierende Variable:
        
        ```python
        zahl = 10
        print(zahl2)
        ```
        
        **Erwartetes Ergebnis:** `NameError`.
5. **Logischer Fehler:**
    - Falsches Vergleichszeichen:
        
        ```python
        zahl = 5
        if zahl < 10:
            print("Zahl ist größer als 10")
        ```
        
        **Erwartetes Ergebnis:** Logischer Fehler (keine Fehlermeldung, aber falsches Verhalten).

**Lösungen der Fehlersimulationen:**

- Syntaxfehler: Doppelpunkt hinzufügen.
- Typfehler: `str(zahl) + text` nutzen.
- Division durch Null: Überprüfung einbauen (`if zahl2 != 0:`).
- Variablenname: Existierende Variable referenzieren.
- Logischer Fehler: Vergleichszeichen ändern (`if zahl > 10:`).