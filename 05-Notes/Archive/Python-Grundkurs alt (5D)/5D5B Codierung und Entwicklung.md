---
aliases: 
tags: 
title: 5D5B Codierung und Entwicklung
---

## Code schreiben

1. Öffnen Sie PyCharm und erstellen Sie eine neue Python-Datei (z.B. `konsolen_app.py`).
2. Beginnen Sie mit dem Schreiben des Codes für die Konsolen-App:

```python
def begruessung(name):
    return f'Hallo, {name}!'

def addiere(a, b):
    return a + b

def main():
    name = input("Bitte geben Sie Ihren Namen ein: ")
    print(begruessung(name))
    
    a = int(input("Geben Sie die erste Zahl ein: "))
    b = int(input("Geben Sie die zweite Zahl ein: "))
    ergebnis = addiere(a, b)
    print(f"Das Ergebnis der Addition ist: {ergebnis}")

if __name__ == "__main__":
    main()
```

1. Nutzen Sie während des Schreibens PyCharm's intelligente Autovervollständigung. Zum Beispiel, wenn Sie `def` tippen, schlägt PyCharm automatisch die Funktionsstruktur vor.
2. Verwenden Sie die Code-Formatierung von PyCharm (Tastenkombination: Strg+Alt+L), um den Code sauber und einheitlich zu gestalten.
3. Beachten Sie die Code-Inspektion von PyCharm, die potenzielle Probleme oder Verbesserungsmöglichkeiten hervorhebt. Zum Beispiel könnte es vorschlagen, f-Strings zu verwenden, wie in der `begruessung`-Funktion gezeigt.

## Debugging

1. Setzen Sie einen Breakpoint in der `main`-Funktion, indem Sie links neben die Zeilennummer klicken.
2. Starten Sie den Debugger, indem Sie auf den grünen "Debug"-Button klicken oder Umschalt+F9 drücken.
3. Wenn der Breakpoint erreicht wird, können Sie:
	 - Den Code schrittweise durchlaufen (F8 für "Step Over", F7 für "Step Into")
	 - Variablenwerte in der "Variables"-Ansicht inspizieren
	 - Den Programmzustand in der "Debugger"-Konsole überprüfen

4. Nutzen Sie die "Evaluate Expression"-Funktion (Alt+F8), um Ausdrücke während des Debugging zu testen.

## Testen

1. Erstellen Sie eine separate Testdatei, z.B. `test_konsolen_app.py`.
2. Schreiben Sie Unit-Tests für Ihre Funktionen:

```python
import unittest
from konsolen_app import begruessung, addiere

class TestKonsolenApp(unittest.TestCase):
    def test_begruessung(self):
        self.assertEqual(begruessung("Test Nutzer"), "Hallo, Test Nutzer!")

    def test_addiere(self):
        self.assertEqual(addiere(5, 7), 12)

if __name__ == '__main__':
    unittest.main()
```

1. Führen Sie die Tests direkt in PyCharm aus, indem Sie mit der rechten Maustaste auf die Testdatei klicken und "Run 'Unittests in test_konsolen_app.py'" wählen.
2. Analysieren Sie die Testergebnisse im "Run"-Fenster von PyCharm.

## Refactoring

1. Nutzen Sie PyCharm's Refactoring-Tools, um den Code zu verbessern. Zum Beispiel:
	 - Umbenennen einer Variablen oder Funktion (Umschalt+F6)
	 - Extrahieren einer Methode (Strg+Alt+M)

2. Verwenden Sie die "Find Usages"-Funktion (Alt+F7), um alle Verwendungen einer Variablen oder Funktion zu finden und sicherzustellen, dass Änderungen konsistent sind.
