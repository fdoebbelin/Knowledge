> Schleifen (`for`, `while`) und deren Anwendungen
## Block 1: Einführung in Schleifen

> Verständnis der Schleifenarten und deren Syntax.

1. **Rückblick auf Modul 2:**
    
    - Kurze Wiederholung der Inhalte von Modul 2:
        - „Was sind Kontrollstrukturen?“
        - „Wie unterscheiden sich `if`-Bedingungen von `match-case`?“
    - Teilnehmer haben die Möglichkeit, Fragen zu stellen.
2. **Theorie: Schleifenarten:**
    
    - **`for`-Schleife:** Wird verwendet, wenn die Anzahl der Durchläufe bekannt ist.
        
        ```python
        for i in range(5):
            print(f"Durchlauf {i}")
        ```
        
    - **`while`-Schleife:** Wird verwendet, wenn die Anzahl der Durchläufe von einer Bedingung abhängt.
        
        ```python
        zahl = 0
        while zahl < 5:
            print(f"Zahl: {zahl}")
            zahl += 1
        ```
        
    - Unterschied:
        - `for`: Zählt durch eine definierte Range oder Datenstruktur.
        - `while`: Läuft, solange eine Bedingung wahr ist.
3. **Praxis: Erste Schleifen schreiben:**
    
    - Teilnehmer erstellen eine einfache `for`-Schleife, die die Zahlen von 1 bis 10 ausgibt.
    - Erweiterung: Mit einer `while`-Schleife dasselbe Ziel erreichen.

## Block 2: Anwendungen von Schleifen

> Verständnis der praktischen Anwendung von Schleifen.

1. **Verschachtelte Schleifen:**
    
    - Einführung in verschachtelte Schleifen: Eine Schleife innerhalb einer anderen.
        
        ```python
        for i in range(3):
            for j in range(3):
                print(f"i: {i}, j: {j}")
        ```
        
    - Anwendung: Multiplikationstabellen programmieren.
2. **Praxis: Schleifenaufgaben:**
    
    - Aufgabe 1: Schreibe ein Programm, das eine Multiplikationstabelle (z. B. 1 bis 10) ausgibt.
    - Aufgabe 2: Finde alle Primzahlen zwischen 1 und 100 mit einer Schleife.
    - Erweiterung: Lasse den Benutzer die Obergrenze der Tabelle oder der Primzahlen angeben.
3. **`Break`- und `Continue`-Anweisungen:**
    
    - Einführung:
        - **`break`:** Beendet die Schleife vorzeitig.
        - **`continue`:** Überspringt den aktuellen Schleifendurchlauf.
    - Beispiele:
        
        ```python
        for i in range(10):
            if i == 5:
                break
            print(i)
        ```
        
        ```python
        for i in range(10):
            if i % 2 == 0:
                continue
            print(i)
        ```
        
    - Praxis: Teilnehmer schreiben Programme mit `break` und `continue`.

## Block 3: Schleifen und Datenstrukturen

> Iteration über Listen, Tupel und Strings mit Schleifen.

1. **Listen und Schleifen:**
    
    - Einführung: Iteration über Elemente einer Liste.
        
        ```python
        namen = ["Anna", "Ben", "Chris"]
        for name in namen:
            print(f"Hallo {name}!")
        ```
        
    - Praxis: Teilnehmer schreiben ein Programm, das die Elemente einer Liste ausgibt und bearbeitet.
2. **Strings und Schleifen:**
    
    - Einführung: Iteration über Zeichen in einem String.
        
        ```python
        text = "Hallo"
        for buchstabe in text:
            print(buchstabe)
        ```
        
    - Praxis: Teilnehmer schreiben ein Programm, das die Zeichen eines eingegebenen Textes rückwärts ausgibt.
3. **Praxis: Erweiterte Aufgaben:**
    
    - Aufgabe 1: Iteriere über eine Liste mit Zahlen und berechne deren Summe.
    - Aufgabe 2: Iteriere über eine Liste mit Texten und prüfe, ob ein bestimmter Text enthalten ist.

## Block 4: Abschlussaufgabe – Mini-Projekt

> Anwendung der erlernten Schleifen in einer komplexeren Aufgabe.

### Aufgabe:
    
- Schreibe ein Programm, das ein Ratespiel implementiert:
	- Der Computer wählt eine zufällige Zahl zwischen 1 und 100 aus.
	- Der Nutzer muss die Zahl erraten.
	- Nach jedem Versuch gibt das Programm Feedback, ob die Zahl größer oder kleiner ist.
	- Die Schleife endet, wenn die Zahl korrekt erraten wurde.

**Hinweis:**

```python
# Bereitstellen einer Zufallszahl
import random
zufallszahl = random.randint(1, 100)
```