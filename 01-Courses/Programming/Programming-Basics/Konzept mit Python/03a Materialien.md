## 1. Beispielcodes für Demonstrationen

##### **a) Einfache `for`-Schleife**

```python
# For-Schleife: Ausgabe der Zahlen von 1 bis 10
for i in range(1, 11):
    print(f"Zahl: {i}")
```
##### **b) Einfache `while`-Schleife**

```python
# While-Schleife: Zählen bis 10
zahl = 1
while zahl <= 10:
    print(f"Zahl: {zahl}")
    zahl += 1
```
##### **c) Verschachtelte Schleifen**

```python
# Verschachtelte Schleifen: Multiplikationstabelle
for i in range(1, 11):
    for j in range(1, 11):
        print(f"{i} x {j} = {i * j}")
    print("-" * 20)
```
##### **d) `break`- und `continue`-Anweisungen**

```python
# Beispiel mit `break`: Schleife bei 5 abbrechen
for i in range(10):
    if i == 5:
        break
    print(i)

# Beispiel mit `continue`: Nur ungerade Zahlen ausgeben
for i in range(10):
    if i % 2 == 0:
        continue
    print(i)
```
##### **e) Iteration über Listen**

```python
# Iteration über eine Liste
namen = ["Anna", "Ben", "Chris"]
for name in namen:
    print(f"Hallo {name}!")

# Iteration über eine Liste mit Zahlen
zahlen = [1, 2, 3, 4, 5]
summe = 0
for zahl in zahlen:
    summe += zahl
print(f"Die Summe der Zahlen ist: {summe}")
```
##### **f) Iteration über einen String**

```python
# Iteration über die Zeichen eines Strings
text = "Programmierung"
for buchstabe in text:
    print(buchstabe)

# Rückwärtsausgabe eines Strings
text = input("Gib einen Text ein: ")
for buchstabe in reversed(text):
    print(buchstabe)
```
##### **g) Mini-Projekt: Ratespiel**

```python
# Ratespiel: Der Nutzer errät eine zufällige Zahl
import random

zufallszahl = random.randint(1, 100)
versuch = 0

while True:
    eingabe = int(input("Rate die Zahl (zwischen 1 und 100): "))
    versuch += 1
    if eingabe == zufallszahl:
        print(f"Richtig! Du hast die Zahl in {versuch} Versuchen erraten.")
        break
    elif eingabe < zufallszahl:
        print("Die Zahl ist größer.")
    else:
        print("Die Zahl ist kleiner.")
```

#### **2. Checkliste für die Theorie**

- **Was ist eine Schleife?**
    
    - Wiederholte Ausführung eines Codesegments, solange eine Bedingung erfüllt ist.
    - Reduziert Redundanz im Code.
- **Schleifenarten:**
    
    - **`for`-Schleife:**
        - Wird verwendet, wenn die Anzahl der Durchläufe bekannt ist.
        - Syntax:
            
            ```python
            for variable in range(start, stop, step):
                # Anweisungen
            ```
        
    - **`while`-Schleife:**
        - Läuft, solange eine Bedingung wahr ist.
        - Syntax:
            
            ```python
            while bedingung:
                # Anweisungen
            ```
            
- **Sonderbefehle in Schleifen:**
    
    - **`break`:** Beendet die Schleife vorzeitig.
    - **`continue`:** Überspringt den aktuellen Schleifendurchlauf und macht mit dem nächsten weiter.

---

#### **3. Aufgaben für die Praxis**

##### **Aufgabe 1: Einfache Schleifen**

- Schreibe eine `for`-Schleife, die die Zahlen von 1 bis 10 ausgibt.
- Schreibe eine `while`-Schleife, die dieselbe Aufgabe erfüllt.
##### **Aufgabe 2: Multiplikationstabelle**

- Schreibe ein Programm, das eine Multiplikationstabelle (1 bis 10) ausgibt.
- Erweiterung: Lasse den Nutzer die Obergrenze der Tabelle eingeben.
##### **Aufgabe 3: Primzahlen finden**

- Schreibe ein Programm, das alle Primzahlen zwischen 1 und 100 ausgibt.
- Erweiterung: Lasse den Nutzer die Obergrenze der Suche eingeben.
##### **Aufgabe 4: Iteration über Listen**

- Erstelle eine Liste mit fünf Zahlen und berechne deren Summe mit einer Schleife.
- Erweiterung: Gib die größte Zahl in der Liste aus.
##### **Aufgabe 5: Iteration über Strings**

- Schreibe ein Programm, das die Zeichen eines eingegebenen Textes rückwärts ausgibt.
- Erweiterung: Prüfe, ob der Text ein Palindrom ist (z. B. "otto" oder "anna").
##### **Abschlussaufgabe: Ratespiel**

- Implementiere ein Ratespiel, bei dem der Nutzer eine zufällige Zahl errät.
- Erweiterung: Begrenze die Anzahl der Versuche und gib am Ende die Anzahl der benötigten Versuche aus.
#### **4. Typische Fehlersimulationen**

- **Endlosschleife:**
    
    ```python
    zahl = 0
    while zahl < 5:
        print("Unendliche Schleife!")
    # Ursache: Variable `zahl` wird nicht verändert.
    ```
    
    **Lösung:** Variable in der Schleife anpassen:
    
    ```python
    while zahl < 5:
        print("Endliche Schleife!")
        zahl += 1
    ```
    
- **Falsche Bedingung in einer Schleife:**
    
    ```python
    zahl = 10
    while zahl > 10:
        print("Diese Schleife wird nie ausgeführt.")
    ```
    
    **Lösung:** Bedingung anpassen:
    
    ```python
    while zahl >= 10:
        print("Jetzt wird die Schleife ausgeführt.")
        zahl -= 1
    ```


    - **Endlosschleifen:**
        
        ```python
        while True:
            print("Endlosschleife!")
        ```
        
        Lösung: Bedingung definieren oder `break` hinzufügen.
        
    - **Falsche Schleifenbedingung:**
        
        ```python
        zahl = 0
        while zahl > 10:
            print("Das wird nie ausgeführt.")
        ```
        
        Lösung: Bedingung korrigieren (`while zahl < 10`).

## Vergleich der Schleifenarten

| Schleifentyp | Wann verwenden?              | Besonderheiten                 |     |
| ------------ | ---------------------------- | ------------------------------ | --- |
| `for`        | Wenn Durchläufe bekannt sind | Nutzt `range()` oder Iteration |     |
| `while`      | Bedingungsbasiert            | Läuft, solange Bedingung wahr  | .   |
