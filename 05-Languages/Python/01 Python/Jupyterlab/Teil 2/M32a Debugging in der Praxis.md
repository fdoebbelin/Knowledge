- vermittelt die strukturierte und praktische Anwendung von Fehlersuche und -behebung im Python-Alltag,
- im Fokus stehen Fallstudien, typische Fehlerquellen, systematische Suchstrategien und der Umgang mit Debugging-Tools – sowohl 
	- im funktionalen als auch 
	- im objektorientierten Code.

## Bedeutung und Ziele des Debuggings

Praktisches Debugging ist ein zentraler Bestandteil jedes Softwareprojekts. Es befähigt, Fehler systematisch zu erkennen, zu klassifizieren und nachhaltig zu beheben. Ziel ist nicht nur das Beheben von Bugs, sondern das Ergründen von Ursachen für robuste, wartbare Programme. Im Kurs wird der professionelle Umgang mit typischen Problemfällen gezielt eingeübt.

**Beispiel:**

```python
def beispiel_division(a, b):
    # Fehlerquelle: Division durch Null
    return a / b

try:
    beispiel_division(5, 0)
except ZeroDivisionError as err:
    print("Fehler gefunden:", err)
```


## Systematische Fehlersuche in der Praxis

### Debugging-Phasen und Methodik

Eine strukturierte Fehlersuche umfasst:

- Fehler reproduzieren und exakt beschreiben
- Ursache lokalisieren (z.B. über Tests, print, Logging, Debugger)
- Ursache beheben und Lösung validieren

**Beispiel – systematische Analyse:**

```python
def durchschnitt(werte):
    if not werte:
        raise ValueError("Liste darf nicht leer sein!")
    return sum(werte) / len(werte)

try:
    print(durchschnitt([]))
except Exception as e:
    print("Fehlerprotokoll:", e)
```


### Debugging-Werkzeuge im Python-Alltag

Typische Tools:

- print()-Ausgaben für Werte \& Kontrolle
- Logging für strukturierte Fehlerprotokolle
- Schrittweises Durchlaufen mit dem Debugger (z. B. `pdb`)
- IDE-Tools (Breakpoints, Watch/Inspect)

**Beispiel – klassisches Print-Debugging:**

```python
def fehlerhafte_funktion(x):
    print("DEBUG: x =", x)
    return 10 / x

fehlerhafte_funktion(0)   # Läuft auf ZeroDivisionError!  
```

**Beispiel – Einsatz von Logging:**

```python
import logging
logging.basicConfig(level=logging.INFO)

def log_division(a, b):
    logging.info(f"Teile {a} durch {b}")
    return a / b

log_division(12, 3)
```


## Debugging in funktions- und klassenbasiertem Code

### Typische Fehlerquellen erkennen

- Falsche Funktionsparameter
- Methodenaufrufe mit inkorrekten Objektreferenzen (`self`)
- Seiteneffekte und veränderliche Objekte
- Vererbung und Überschreibung in OOP

**Beispiel OOP-Debugging:**

```python
class Konto:
    def __init__(self, inhaber, start=0):
        self.saldo = start
    def einzahlen(self, betrag):
        self.saldo += betrag
    def abheben(self, betrag):
        if betrag > self.saldo:
            raise ValueError("Nicht genügend Guthaben!")
        self.saldo -= betrag

konto = Konto("Max", 100)
try:
    konto.abheben(200)
except Exception as e:
    print("Fehler:", e)
```


### Fallstudien: Debugging-Taktiken im Projektkontext

- Analyse von Stack-Traces
- Überprüfung von edge cases mit gezielten Tests
- Einsatz von assert-Anweisungen zur Fehlerprävention
- Fehlerprotokolle und Kommentierung für Team-Debugging

**Beispiel – Stack Trace Analyse:**

```python
def a(): b()
def b(): c()
def c(): 1 / 0

try:
    a()
except Exception as e:
    import traceback
    print("Stack Trace:")
    traceback.print_exc()
```


## Best Practices und Tipps für nachhaltiges Debugging

- Fehler klein isolieren und gezielt reproduzieren
- Defensive Programmiertechniken (Input prüfen, Ausnahmen abfangen)
- Ergebnis- und Grenzfalltests (Unit Tests kombinieren)
- Fehler und Learnings dokumentieren
- Professionelle Tools und Logging konsequent nutzen

**Zusammenfassung:**
Debugging ist kein Zufallsverfahren, sondern ein methodischer, wiederholbarer Prozess. Im Rahmen des Moduls werden Tools und Techniken vorgestellt, mit denen Fehlerquellen im Python-Code – sowohl funktional als auch objektorientiert – zuverlässig erkannt und nachhaltig behoben werden können. Die praktische Anwendung an typischen Kursprojekten festigt das methodische Vorgehen.
