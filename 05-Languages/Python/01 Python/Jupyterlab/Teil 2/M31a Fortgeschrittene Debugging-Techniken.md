- behandelt die fortgeschrittenen Debugging-Techniken in Python, insbesondere die systematische Fehlersuche mit dem Debugger pdb, 
- den Einsatz von Breakpoints sowie die schrittweise Code-Durchführung. 
- Ziel ist ein professioneller Umgang mit Fehlerquellen und eine präzise Analyse des Programmflusses.

## Grundlagen: Was bedeutet fortgeschrittenes Debugging?

Fortgeschrittenes Debugging umfasst alle Werkzeuge und Methoden, die über das einfache Einfügen von `print()`-Anweisungen hinausgehen. Dazu zählen der Einsatz des Python-Debuggers `pdb`, gezielte Breakpoints und systematische Analyse komplexer Funktionsabläufe.

## Der Python Debugger pdb

Der native Python-Debugger (`pdb`) ermöglicht eine interaktive Untersuchung laufender Programme. Mit pdb lassen sich Variablen inspizieren, der Programmfluss steuern und Fehler im Kontext nachvollziehen.

```python

import pdb

def rechnung(a, b):
    pdb.set_trace()  # Debugger-Breakpoint
    return a / b

print(rechnung(12, 4))
```

Mit Befehlen wie `n` (next), `s` (step), `c` (continue) und `p variable` kann ein Entwickler gezielt durch den Code navigieren.

## Breakpoints: Programmfluss gezielt steuern

Ein Breakpoint stoppt die Programmausführung an einer festgelegten Stelle, sodass man Variablen und den Status direkt überprüfen kann. Besonders praktisch sind bedingte Breakpoints, die nur unter bestimmten Umständen aktiviert werden.

```python
for i in range(10):
    if i == 5:
        pdb.set_trace()  # Breakpoint bei i=5
    print(i)
```


## Schrittweises Debugging komplexer Strukturen

Mit pdb kann man Funktionen, Schleifen, Methoden und komplette Objektstrukturen schrittweise durchlaufen. Besonders bei Fehlern in komplexen Abläufen hilft die Kombination aus Breakpoints und Call-Stack-Analyse (`w`, `u`, `d`).

```python
class Konto:
    def __init__(self, saldo):
        self.saldo = saldo
    
    def einzahlen(self, betrag):
        pdb.set_trace()
        self.saldo += betrag

konto = Konto(100)
konto.einzahlen(50)
```


## Fehlerquellen finden mit Post-Mortem Debugging

Im Fehlerfall lässt sich mit `pdb.post_mortem()` nach einem Crash direkt in die Debugging-Session springen und den Zustand zum Absturzzeitpunkt analysieren.

```python
import pdb
import sys

def fehler():
    return 1 / 0

try:
    fehler()
except Exception:
    pdb.post_mortem()
```


## Best Practices für fortgeschrittenes Debugging

- Breakpoints gezielt und auch bedingt einsetzen.
- Den Call-Stack mit `where`, `up`, `down` nachvollziehen.
- Debugging mit Logging und sinnvoller Struktur kombinieren.
- Fehlerquellen durch schrittweise Analyse und Variableninspektion aufdecken.

```python
class Konto:
    def __init__(self, saldo):
        self.saldo = saldo
    
    def einzahlen(self, betrag):
        self.saldo += betrag

konto = Konto(100)
konto.einzahlen(50)
```

```python

```
