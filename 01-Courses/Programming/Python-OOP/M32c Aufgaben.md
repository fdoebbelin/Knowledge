## Aufgabenstellungen \& kommentierte Lösungen (Demo für die Gruppe/Py2Rust)

### Aufgabe 1: Fehler systematisch eingrenzen und mit Logging beheben

**Aufgabenstellung:**
Im Python-Projekt wird ein komplexer Fehler im Migrationsprozess gemeldet. Entwickle einen Debugging-Workflow, um diesen reproduzierbar zu finden, zu analysieren und zu beheben. Nutze Logging zur Protokollierung.

**Lösung:**

```python
import logging

# Logging-Konfiguration
logging.basicConfig(level=logging.DEBUG)

def fehlerhafte_migration(code):
    logging.info("Starte Migration für Code: %s", code)
    try:
        # Fehler: int statt str, kann Fehler hervorrufen
        if not isinstance(code, str):
            raise TypeError("Code muss ein String sein!")
        # Simulierter Fehler: Syntax prüfen
        if 'def' not in code:
            raise SyntaxError("Fehlende Funktionsdefinition!")
        # Simulation - Migration läuft erfolgreich
        migrated = code.replace("def", "fn")
        logging.info("Migration erfolgreich: %s", migrated)
        return migrated
    except Exception as e:
        logging.exception("Fehler im Migrationsprozess")
        return None

# Beispielhafte Nutzung mit gezielten Fehlerfällen:
fehlerhafte_migration(123)   # TypeError wird protokolliert
fehlerhafte_migration("print('Hallo')")  # SyntaxError wird protokolliert
fehlerhafte_migration("def foo(): pass") # Erfolgreich
```


### Aufgabe 2: Debugging in klassenbasiertem Code (OOP)

**Aufgabenstellung:**
Eine Klasse gibt bei bestimmten Eingabewerten einen nicht erklärbaren Fehler aus. Ermittle die Ursache mit gezieltem Debugging und verbessere die Klasse nachhaltig.

**Lösung:**

```python
class Rechner:
    def teile(self, a, b):
        # Debug-Info ausgeben
        print(f"Eingabe: a={a}, b={b}")
        if b == 0:
            print("Warnung: Division durch Null erkannt!")
            raise ZeroDivisionError("b darf nicht 0 sein!")
        return a / b

# Testfälle
calc = Rechner()
try:
    calc.teile(8, 0)
except Exception as e:
    print("Fehler aufgefangen:", e)
# Erwartetes Verhalten: Fehler wird klar angezeigt und abgefangen
```


### Aufgabe 3: Fehleranalyse mit Stacktrace und Assertions

**Aufgabenstellung:**
Führe eine systematische Fehlersuche mit assert-Anweisungen und Stacktrace-Ausgaben durch.

**Lösung:**

```python
def durchschnitt(liste):
    assert isinstance(liste, list), "Eingabe muss eine Liste sein!"
    assert len(liste) > 0, "Liste darf nicht leer sein!"
    return sum(liste) / len(liste)

try:
    durchschnitt("keine_liste")
except Exception as e:
    import traceback
    print("Fehler und Stacktrace:")
    traceback.print_exc()
```


***

## Aufgabenideen mit Lösungshinweisen für Teilnehmerprojekte

### WetterWeiser (Datenanalyse \& Visualisierung)

**Aufgaben:**

- Analysiere einen Fehler beim Import einer CSV-Datei mit Pandas. Was passiert, wenn eine Spalte fehlt oder das Datumsformat nicht stimmt?
    - **Hinweis:** Nutze `.info()` und `.head()` zur Überprüfung des DataFrames. Teste mit `try-except` und gebe Problemspalten gezielt aus.
- Implementiere Debugging-Ausgaben für Ausreißer im Temperatur-Array.
    - **Hinweis:** Verwende Schleifen mit `print` oder Logging, um ungewöhnliche Werte zu markieren und abzufangen.


### PersonalPrinz (Mitarbeiterverwaltung)

**Aufgaben:**

- Teste die `urlaubbuchen`-Methode für Extremsituationen, etwa wenn Urlaub bereits voll verbraucht wurde.
    - **Hinweis:** Prüfe Rückgabewert, gebe Warnungen aus, und fange fehlerhafte Aufrufe mit `try-except` auf.
- Analysiere den Ablauf beim Laden einer CSV-Datei mit fehlerhaften oder fehlenden Feldern.
    - **Hinweis:** Setze Breakpoints in der Schleife oder lasse alle Felder protokollieren, bevor Instanzen erzeugt werden.


### KeyRecognition (Signalverarbeitung)

**Aufgaben:**

- Simuliere einen Fehlerfall bei der Demodulation: Übergebe Daten mit falschem Typ (keine komplexen Werte). Wie erkennt und behandelt man diesen Fehler sauber?
    - **Hinweis:** Nutze `isinstance`-Prüfungen und gib im Fehlerfall eine aussagekräftige Fehlermeldung aus.
- Untersuche, wie falsche Samplingraten in der Visualisierung zu „unrealistischen“ Darstellungen führen.
    - **Hinweis:** Füge Validierungen für Samplingrate hinzu, protokolliere Warnungen und entwickle kleine Tests mit absichtlich falschen Werten.
