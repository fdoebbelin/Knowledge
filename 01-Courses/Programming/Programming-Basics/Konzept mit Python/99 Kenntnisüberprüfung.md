## Grundlagen der Programmierung

1. **Was ist die Hauptaufgabe eines Compilers?**  
    a) Den Quellcode zur Laufzeit interpretieren  
    b) Den Quellcode in Maschinencode übersetzen  
    c) Den Quellcode in Assemblersprache übersetzen  
    d) Den Quellcode auf Fehler prüfen
    
    **Richtige Antwort: b) Den Quellcode in Maschinencode übersetzen**
    
2. **Welche Programmiersprache ist am nächsten an der Maschinensprache?**  
    a) Python  
    b) Java  
    c) C++  
    d) Assembler
    
    **Richtige Antwort: d) Assembler**
    
3. **Was charakterisiert einen Interpreter?**  
    a) Er übersetzt den gesamten Code vor der Ausführung  
    b) Er erzeugt eine ausführbare Datei  
    c) Er führt den Code Zeile für Zeile aus  
    d) Er ist schneller als ein Compiler
    
    **Richtige Antwort: c) Er führt den Code Zeile für Zeile aus**
## Assembler und Maschinencode

4. **Was ist ein Assembler?**  
    a) Eine Hochsprache  
    b) Ein Programm, das Assemblercode in Maschinencode übersetzt  
    c) Ein Betriebssystem  
    d) Ein Hardware-Bauteil
    
    **Richtige Antwort: b) Ein Programm, das Assemblercode in Maschinencode übersetzt**
    
5. **Maschinencode besteht aus:**  
    a) Englischen Wörtern  
    b) Mnemonischen Codes  
    c) Binären Zahlen  
    d) Hexadezimalen Zahlen
    
    **Richtige Antwort: c) Binären Zahlen**
    
6. **Was ist ein Vorteil der Assemblerprogrammierung?**  
    a) Einfache Lesbarkeit  
    b) Plattformunabhängigkeit  
    c) Hohe Ausführungsgeschwindigkeit  
    d) Einfache Wartbarkeit
    
    **Richtige Antwort: c) Hohe Ausführungsgeschwindigkeit**

## Strukturierte Programmierung

7. **Welches ist kein Grundelement der strukturierten Programmierung?**  
    a) Sequenz  
    b) Selektion  
    c) Iteration  
    d) Rekursion
    
    **Richtige Antwort: d) Rekursion**
    
8. **Was ist ein Merkmal der strukturierten Programmierung?**  
    a) Verwendung von GOTO-Anweisungen  
    b) Unterteilung des Programms in überschaubare Funktionen  
    c) Vermeidung von Schleifen  
    d) Ausschließliche Verwendung globaler Variablen
    
    **Richtige Antwort: b) Unterteilung des Programms in überschaubare Funktionen**
## Programmierkonzepte

9. **Was ist ein Just-In-Time-Compiler (JIT)?**  
    a) Ein Compiler, der den Code vor der Ausführung vollständig übersetzt  
    b) Ein Interpreter, der den Code Zeile für Zeile ausführt  
    c) Ein Compiler, der den Code zur Laufzeit in Maschinencode übersetzt  
    d) Ein Assembler für moderne Prozessoren
    
    **Richtige Antwort: c) Ein Compiler, der den Code zur Laufzeit in Maschinencode übersetzt**
    
10. **Welche Aussage über Hochsprachen ist korrekt?**  
    a) Sie sind immer interpretiert  
    b) Sie sind immer kompiliert  
    c) Sie sind näher an der menschlichen Sprache als Assembler  
    d) Sie erzeugen immer den effizientesten Maschinencode
    
    **Richtige Antwort: c) Sie sind näher an der menschlichen Sprache als Assembler**

## Python-Code in deutschen Pseudocode übertragen:

Formulieren Sie den folgenden Python-Code in **deutschem Pseudocode** um, ergänzt durch **aussagekräftige Kommentare**, zur Erklärung der Funktionsweise des Programms.

```python
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
### Lösung:

**Deutscher Pseudocode mit Kommentaren:**

```plaintext
# Zufallszahl zwischen 1 und 100 generieren
Zufallszahl = Zufallswert(1 bis 100)

# Zähler für die Anzahl der Versuche initialisieren
Versuch = 0

# Wiederhole solange, bis der Benutzer die richtige Zahl errät
solange wahr:
    # Eingabe des Benutzers abfragen
    Eingabe = KonvertiereEingabeZuZahl("Rate die Zahl (zwischen 1 und 100): ")
    
    # Zähler für Versuche erhöhen
    Versuch = Versuch + 1

    # Überprüfen, ob die Eingabe der Zufallszahl entspricht
    wenn Eingabe gleich Zufallszahl:
        # Erfolgsmeldung ausgeben und Schleife beenden
        Ausgabe("Richtig! Du hast die Zahl in " + Versuch + " Versuchen erraten.")
        beenden
    
    # Überprüfen, ob die Eingabe kleiner als die Zufallszahl ist
    sonst wenn Eingabe kleiner als Zufallszahl:
        # Hinweis ausgeben, dass die Zahl größer ist
        Ausgabe("Die Zahl ist größer.")
    
    # Falls die Eingabe größer als die Zufallszahl ist
    sonst:
        # Hinweis ausgeben, dass die Zahl kleiner ist
        Ausgabe("Die Zahl ist kleiner.")
```

**Erklärung:**

1. Die Zufallszahl wird zu Beginn generiert und liegt im Bereich von 1 bis 100.
2. Ein Versuchszähler wird initialisiert.
3. Eine Endlosschleife wird verwendet, um dem Benutzer wiederholt Eingaben zu ermöglichen.
4. Der Benutzer wird aufgefordert, eine Zahl einzugeben, die konvertiert wird.
5. Die Eingabe wird mit der Zufallszahl verglichen:
    - Bei Übereinstimmung wird der Benutzer informiert und die Schleife beendet.
    - Andernfalls erhält der Benutzer Hinweise, ob die gesuchte Zahl größer oder kleiner ist.
6. Der Versuchszähler wird nach jedem Durchlauf erhöht.