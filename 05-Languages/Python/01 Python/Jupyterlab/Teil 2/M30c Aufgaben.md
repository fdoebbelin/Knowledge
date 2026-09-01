## Aufgaben \& Lösungen für das Dozentenprojekt „Fritz - Py2Rust“

### Aufgabe 1: Debugging eines fehlerhaften Python-Skripts

**Arbeitsanweisung:**
Ein Python-Skript zur Dateianalyse liefert an einer Stelle eine unerwartete Ausnahme.

```python
def read_file_lines(pfad):
    with open(pfad, "r") as f:
        lines = f.readlines()
        print("Anzahl gelesener Zeilen:", len(lines))  # Debug-Ausgabe
        return lines

dateipfad = "nicht_existente_datei.txt"
read_file_lines(dateipfad)
```

**Kommentierte Lösung:**

```python
def read_file_lines(pfad):
    try:
        with open(pfad, "r") as f:
            lines = f.readlines()
            print("Anzahl gelesener Zeilen:", len(lines))  # Debug-Ausgabe
            return lines
    except Exception as e:
        print("Fehler beim Öffnen der Datei:", e)  # Fehlerdetails ausgeben
        return []

# Test: Erzeugt bewusst einen Fehler – jetzt wird er gefangen!
dateipfad = "nicht_existente_datei.txt"
read_file_lines(dateipfad)
# Ergebnis: Fehler wird erkannt, Ursache angezeigt, Ablauf bleibt stabil.
```


***

## Aufgaben für die Teilnehmerprojekte

### WetterWeiser (Projekt Christian)

**Aufgabe:**
Implementiere eine Debugging-Funktion, die den Importvorgang von Wetterdaten prüft, Fehler ausgibt und bei fehlerhaften Daten eine Warnung erzeugt.

**Lösungshinweis:**

- Nutze try-except beim Einlesen der CSV-Datei.
- Gib vor und nach dem Laden Info-Prints aus.
- Warne bei fehlenden oder ungültigen Spalten.

***

### PersonalPrinz (Projekt Christopher)

**Aufgabe:**
Erweitere die Personalverwaltung um eine Debugging-Methode, die prüft, ob alle Mitarbeiterdaten vollständig geladen wurden.

**Lösungshinweis:**

- Zähle nach dem Import die geladenen Objekte.
- Gib Info über fehlerhafte Datensätze aus (z.B. fehlende Personalnummer).
- Nutze print-Statements zur Auswertung.

***

### KeyRecognition (Projekt Tristan)

**Aufgabe:**
Debugge eine Funktion, die Funksignale verarbeitet, und gib dabei die Werte der wichtigsten Parameter aus.

**Lösungshinweis:**

- Platziere Prints zu Signal-Länge, statistischen Kennwerten und bearbeiteten Modulationsarten.
- Nutze try-except, um Fehler bei der Signalverarbeitung oder beim Zugriff auf nicht unterstützte Modulationen auszugeben.
