## Thonny kennenlernen

### Installation
`thonny` kann gang einfach über `pip` installiert werden, wenn es eine aktive Python-Installation gibt:

```sh
pip install thonny
```

Gibt es noch kein `python` auf dem Computer kann von der Webseite https://thonny.org ein Installer heruntergeladen werden, der eine eigene `python`-Umgebung mitbringt.
### Teil 1: Die Benutzeroberfläche kennenlernen

**1. Programmstart und Orientierung**

Die Hauptbereiche der Thonny-Oberfläche sind:
- Oben: **Editor-Bereich**
  * Hier wird der Python-Code geschrieben
  * Unterstützt Syntax-Highlighting und automatische Einrückung
  * Zeigt Zeilennummern (falls aktiviert)

- Unten: **Shell-Bereich**
  * Zeigt Programmausgaben
  * Ermöglicht direkte Python-Befehle
  * Zeigt Fehlermeldungen in rot

- Links: **Dateibrowser**
  * Zeigt Projektordner und Dateien
  * Ermöglicht schnelle Navigation
  * Unterstützt Drag & Drop

**2. Erste Schritte mit dem Editor**

Beispielcode mit Erklärung:
```python
# Einfaches Begrüßungsprogramm
print("Hallo Welt!")  # Erste Ausgabe
name = input("Wie heißt du? ")  # Benutzereingabe wird in Variable gespeichert
print("Schön dich kennenzulernen,", name)  # Personalisierte Ausgabe
```

Speichern:
- Datei → Speichern unter... (Strg + S)
- Empfohlene Namenskonvention: Kleinbuchstaben, Unterstriche für Leerzeichen
- Dateiendung `.py` wird automatisch ergänzt

**3. Code ausführen**

Verschiedene Möglichkeiten zum Starten des Programms (Lösung):
1. Grüner "Play"-Button in der Werkzeugleiste
2. Tastenkombination F5
3. Menü → Run → Run current script
4. Rechtsklick im Editor → Run current script

### Teil 2: Debug-Funktionen im Detail

**4. Debugging-Werkzeuge**

Wichtige Debug-Buttons und ihre Funktionen:
- Step Over (F7)
  * Führt aktuelle Zeile aus und stoppt bei der nächsten
  * Nützlich um Programmablauf zu verfolgen
  
- Step Into (F6)
  * Geht in Funktionen hinein
  * Zeigt detaillierte Ausführung
  
- Step Out
  * Verlässt aktuelle Funktion
  * Springt zurück zur aufrufenden Stelle

Beispiel für Debugging-Session:
```python
# Code zum Üben des Debuggings
name = input("Wie heißt du? ")  # Breakpoint hier setzen
alter = int(input("Wie alt bist du? "))
jahr = 2024 - alter
print(f"Hallo {name}, du bist vermutlich im Jahr {jahr} geboren.")
```

Breakpoint setzen:
1. Klick links neben die Zeilennummer → roter Punkt erscheint
2. Debugging mit Bug-Symbol oder F5 starten
3. Programm hält an Breakpoint an
4. Variables-View zeigt aktuelle Werte

**5. Hilfreiche Features im Detail**

Lösung - Wo finde ich wichtige Features:
- Automatische Code-Vervollständigung: 
  * Erscheint automatisch nach Eingabe von "." oder nach Strg+Leertaste
  * Zeigt verfügbare Methoden und Attribute

- Syntax-Highlighting:
  * Automatisch aktiv im Editor
  * Verschiedene Farben für:
    - Schlüsselwörter (z.B. if, for, while)
    - Strings (in Anführungszeichen)
    - Zahlen
    - Kommentare

- Variablen-Inspektor:
  * View → Variables
  * Zeigt alle aktuellen Variablen und ihre Werte
  * Aktualisiert sich während des Debuggings

### Teil 3: Praktische Übungen mit Lösungen

**6. Code-Experiment: Altersüberprüfung**

Vollständiger Code mit Erklärungen:
```python
# Eingabe des Namens und Alters
name = input("Wie heißt du? ")
alter = int(input("Wie alt bist du? "))

# Altersüberprüfung
if alter < 18:
    print(f"Hallo {name}, du bist noch minderjährig.")
    jahre_bis_18 = 18 - alter
    print(f"In {jahre_bis_18} Jahren bist du volljährig!")
else:
    print(f"Hallo {name}, du bist volljährig.")
    print(f"Du bist seit {alter - 18} Jahren volljährig.")
```

**7. Fehlersuche und -behebung**

Häufige Fehler und ihre Lösung:

1. Syntaxfehler:
```python
# Fehler
print "Hallo Welt"
# Fehlermeldung: SyntaxError: Missing parentheses in call to 'print'
# Lösung
print("Hallo Welt")
```

2. Typfehler:
```python
# Fehler
alter = input("Alter: ")
jahre_bis_18 = 18 - alter
# Fehlermeldung: TypeError: unsupported operand type(s) for -: 'int' and 'str'
# Lösung
alter = int(input("Alter: "))
jahre_bis_18 = 18 - alter
```

### Teil 4: Fortgeschrittene Funktionen

**8. Einstellungen anpassen**

Wichtige Einstellungsoptionen (Werkzeuge → Einstellungen):
- Theme: 
  * Light (Standard)
  * Dark (augenschonend)
  * Custom (benutzerdefiniert)

- Editor:
  * Font size: Empfohlen 12-14pt
  * Show line numbers: Aktivieren
  * Highlight current line: Aktivieren

- Assistance:
  * Code completion: Aktivieren
  * Highlight matching names: Aktivieren
  * Highlight syntax errors: Aktivieren

**9. Shell-Bereich effektiv nutzen**

Beispiele für Shell-Nutzung:
```python
# Direkte Berechnungen
>>> 2 + 2
4
>>> 50 * 1.19  # MwSt. berechnen
59.5
>>> "Python" * 3
'PythonPythonPython'

# Variablen testen
>>> name = "Max"
>>> f"Hallo {name}"
'Hallo Max'
```

Unterschied Editor vs. Shell:
- Editor: 
  * Für längere Programme
  * Speichert Code permanent
  * Ermöglicht Debugging
  
- Shell:
  * Für schnelle Tests
  * Sofortige Ausführung
  * Temporäre Ausführung

### Häufige Probleme und Lösungen

1. Programm startet nicht:
   - Prüfen ob alle Dateien gespeichert sind
   - Auf Syntaxfehler achten (rote Unterstreichungen)
   - Shell-Ausgaben auf Fehlermeldungen prüfen

2. Debugging funktioniert nicht:
   - Breakpoint richtig gesetzt? (roter Punkt muss sichtbar sein)
   - Programm mit Debug-Button starten
   - Variables-View öffnen für Variablenübersicht

3. Code-Vervollständigung erscheint nicht:
   - Strg+Leertaste drücken
   - Einstellungen prüfen
   - Python-Pfad in Thonny korrekt?

### Tipps für Lehrkräfte

**Unterrichtsgestaltung:**
1. Erste Stunde:
   - Installation und Grundfunktionen
   - Einfache print()-Befehle
   - Speichern und Ausführen

2. Zweite Stunde:
   - Variablen und Eingaben
   - Einfache Berechnungen
   - Debug-Funktionen einführen

3. Dritte Stunde:
   - Kontrollstrukturen (if/else)
   - Fehlerbehandlung
   - Erste kleine Programme

**Übungsaufgaben für Schüler:**
1. "Zahlenraten":
```python
# Einfaches Zahlenratespiel
import random
zahl = random.randint(1, 100)
versuche = 0

while True:
    versuche += 1
    tipp = int(input("Rate eine Zahl zwischen 1 und 100: "))
    
    if tipp == zahl:
        print(f"Richtig! Du hast {versuche} Versuche gebraucht.")
        break
    elif tipp < zahl:
        print("Die gesuchte Zahl ist größer!")
    else:
        print("Die gesuchte Zahl ist kleiner!")
```

2. "Notenschnitt":
```python
# Notendurchschnitt berechnen
noten = []
while True:
    eingabe = input("Note eingeben (oder 'fertig' zum Beenden): ")
    if eingabe.lower() == 'fertig':
        break
    noten.append(float(eingabe))

durchschnitt = sum(noten) / len(noten)
print(f"Notendurchschnitt: {durchschnitt:.2f}")
```

### Abschluss

**Reflexionsfragen und Musterlösungen:**

1. Was findest du besonders hilfreich an Thonny?
   - Mögliche Antworten:
     * Übersichtliche Benutzeroberfläche
     * Hilfreiche Fehlermeldungen
     * Schrittweise Ausführung
     * Variables-View beim Debugging

2. Welche Funktionen sollten vertieft werden?
   - Typische Bereiche:
     * Debugging-Funktionen
     * Variablen-Inspektor
     * Code-Vervollständigung
     * Fehlerbehebung

3. Häufige Schwierigkeiten:
   - Bekannte Hürden:
     * Unterschied Editor/Shell
     * Debugging-Konzepte
     * Fehlermeldungen verstehen
     * Syntaxregeln beachten