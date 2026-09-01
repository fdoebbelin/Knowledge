## 1. Was ist Debugging?
Debugging bedeutet:

- **Fehler finden**: Identifizieren, wo Ihr Programm nicht wie erwartet funktioniert.
- **Fehler verstehen**: Analysieren, warum der Fehler auftritt.
- **Fehler beheben**: Korrigieren des Codes.
## 2. Die Debugging-Tools in Thonny
Thonny bietet verschiedene Werkzeuge für das Debugging:

- **Debugging-Modus**: Aktivieren Sie Debugging mit dem Käfer-Symbol in der Werkzeugleiste.
- **Breakpoints**: Setzen Sie Stopppunkte, an denen das Programm angehalten wird.
- **Schrittweises Debugging**: Durchlaufen Sie den Code Zeile für Zeile.
- **Variablen-Fenster**: Überprüfen Sie die Werte von Variablen in Echtzeit.
- **Stack-Fenster**: Verfolgen Sie die Aufrufhierarchie von Funktionen.
## 3. Einfache Debugging-Schritte
### Beispielprogramm:

Speichern Sie den folgenden Code in Thonny als `debug_beispiel.py`:

```python
def addiere(a, b):
    return a + b

def multipliziere(a, b):
    return a * b

x = 5
y = "10"  # Fehler: y sollte eine Zahl sein, kein String
ergebnis = addiere(x, y)
print("Ergebnis der Addition:", ergebnis)
```
## 4. Debugging-Modus starten
1. **Debugging aktivieren**:
    
    - Klicken Sie auf das **Käfer-Symbol** in der Werkzeugleiste.
    - Alternativ: `Ansicht > Debugging anzeigen`, um die Debugging-Funktionen einzublenden.
2. **Breakpoints setzen**:
    
    - Klicken Sie links neben die Zeilennummer (im Editor), um einen roten Punkt zu setzen. Das Programm stoppt an dieser Stelle, wenn es ausgeführt wird.
3. **Programm starten**:
    
    - Klicken Sie auf den grünen "Start"-Button, um das Debugging zu starten.
## 5. Schrittweises Debugging
Sobald das Programm gestoppt wurde (z. B. an einem Breakpoint), können Sie den Code Zeile für Zeile durchgehen:

1. **Nächster Schritt**:
    
    - Klicken Sie auf die Schaltfläche „Nächster Schritt“ (Pfeil-Icon) oder drücken Sie `F6`. Dies führt die aktuelle Zeile aus und geht zur nächsten Zeile.
2. **Variablen überwachen**:
    
    - Öffnen Sie das Variablen-Fenster (`Ansicht > Variablen`), um die aktuellen Werte der Variablen zu sehen. Beispielsweise sehen Sie, dass `y` ein String ist, was später zum Fehler führt.
3. **Funktionsaufrufe verfolgen**:
    
    - Bei einem Funktionsaufruf (z. B. `addiere(x, y)`) können Sie mit `F7` in die Funktion eintreten, um deren Ausführung zu verfolgen.
    - Mit `F8` können Sie die Funktion überspringen und direkt zur nächsten Zeile außerhalb der Funktion springen.
4. **Programm beenden**:
    
    - Wenn Sie den Debugging-Prozess abbrechen möchten, klicken Sie auf den roten „Stop“-Button.
## 6. Fehlermeldungen verstehen
In unserem Beispiel tritt ein Fehler auf, da `y` ein String ist. Die Debugging-Sitzung zeigt:

- Die fehlerhafte Zeile: `ergebnis = addiere(x, y)`.
- Die Fehlermeldung im Shell-Fenster: `TypeError: unsupported operand type(s) for +: 'int' and 'str'`.

**Lösung**: Ändern Sie `y = "10"` zu `y = 10`, um den Fehler zu beheben.
## 7. Debugging von Schleifen
Bei der Fehlersuche in Schleifen ist Thonny besonders hilfreich:

#### Beispielcode:

```python
for i in range(5):
    print(f"i = {i}")
    if i == 3:
        print(10 / (3 - i))  # Fehler: Division durch Null
```

1. Setzen Sie einen Breakpoint in der Zeile `if i == 3:`.
2. Starten Sie das Debugging.
3. Überwachen Sie den Wert von `i` im Variablen-Fenster.
4. Sobald der Fehler auftritt, zeigt Thonny die fehlerhafte Zeile und die entsprechende Fehlermeldung (`ZeroDivisionError`).
## 8. Variablen und Speicher verfolgen
- Thonny visualisiert die Variablen und deren Werte im **Variablen-Fenster**.
- Änderungen an Variablenwerten können Sie in Echtzeit beobachten, während Sie den Code Zeile für Zeile durchgehen.
## 9. Funktionen und Aufruf-Stack
Im **Stack-Fenster** können Sie die Hierarchie von Funktionsaufrufen sehen:

- Wer hat diese Funktion aufgerufen?
- Welche Argumente wurden übergeben?
- Was ist der Rückgabewert?
## 10. Debugging-Tipps
- **Kleine Abschnitte debuggen**: Setzen Sie Breakpoints in Schlüsselzeilen, anstatt das gesamte Programm auf einmal zu debuggen.
- **Variablen-Fenster verwenden**: Überprüfen Sie, ob die Variablen die erwarteten Werte haben.
- **Funktionsweise verstehen**: Treten Sie in Funktionen ein (`F7`), um ihre Funktionsweise nachzuvollziehen.
- **Iterationen überwachen**: Debuggen Sie Schleifen Schritt für Schritt, um Fehler bei der Iteration zu finden.
## Zusammenfassung
Mit Thonny ist Debugging einfach und visuell verständlich:

- Nutzen Sie Breakpoints und schrittweises Debuggen, um Fehler einzugrenzen.
- Beobachten Sie Variablen und Speicherzustände in Echtzeit.
- Analysieren Sie Funktionsaufrufe und Fehlerquellen im Stack-Fenster.