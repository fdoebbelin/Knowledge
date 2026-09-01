---
aliases: 
tags: 
title: 5D5C Testen
---

## Vorbereitung: Erstellung der Taschenrechner-App

Zunächst erstellen wir eine einfache Python-Datei namens `calculator.py` mit grundlegenden arithmetischen Operationen:

```python
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def multiply(a, b):
    return a * b

def divide(a, b):
    if b == 0:
        raise ValueError("Division durch Null ist nicht erlaubt")
    return a / b
```

## Schritt 1: Erstellung der Testdatei

1. Rechtsklicken Sie im Projektexplorer auf den Ordner, der `calculator.py` enthält.
2. Wählen Sie "New" > "Python File".
3. Benennen Sie die Datei `test_calculator.py`.

## Schritt 2: Implementierung der Unit-Tests

Öffnen Sie `test_calculator.py` und fügen Sie folgenden Code ein:

```python
import unittest
from calculator import add, subtract, multiply, divide

class TestCalculator(unittest.TestCase):

    def test_add(self):
        self.assertEqual(add(2, 3), 5)
        self.assertEqual(add(-1, 1), 0)

    def test_subtract(self):
        self.assertEqual(subtract(5, 3), 2)
        self.assertEqual(subtract(1, 5), -4)

    def test_multiply(self):
        self.assertEqual(multiply(2, 3), 6)
        self.assertEqual(multiply(-2, 4), -8)

    def test_divide(self):
        self.assertEqual(divide(6, 3), 2)
        self.assertEqual(divide(5, 2), 2.5)
        with self.assertRaises(ValueError):
            divide(5, 0)

if __name__ == '__main__':
    unittest.main()
```

## Schritt 3: Ausführung der Tests

1. Rechtsklicken Sie auf `test_calculator.py` im Projektexplorer.
2. Wählen Sie "Run 'Unittests in test_calculator.py'".

PyCharm wird nun den Test-Runner starten und die Ergebnisse im unteren Bereich des Fensters anzeigen.

## Schritt 4: Analyse der Testergebnisse

- Grüne Häkchen zeigen erfolgreiche Tests an.
- Rote X-Symbole weisen auf fehlgeschlagene Tests hin.
- Klicken Sie auf einzelne Tests, um detaillierte Informationen zu erhalten.

## Schritt 5: Code-Abdeckung analysieren

1. Klicken Sie mit der rechten Maustaste auf `test_calculator.py`.
2. Wählen Sie "Run 'Unittests in test_calculator.py' with Coverage".
3. PyCharm zeigt nun die Code-Abdeckung in Prozent an und markiert getestete Zeilen grün, nicht getestete rot.

## Schritt 6: Kontinuierliche Testausführung

1. Öffnen Sie die Datei `calculator.py`.
2. Ändern Sie eine der Funktionen, z.B. `add`:

```python
def add(a, b):
    return a + b + 1  # Absichtlicher Fehler
```

1. PyCharm wird automatisch die Tests im Hintergrund ausführen und Fehler anzeigen.

## Schritt 7: Debugging fehlgeschlagener Tests

1. Setzen Sie einen Breakpoint in der `add`-Funktion.
2. Rechtsklicken Sie auf den fehlgeschlagenen Test in der Testansicht.
3. Wählen Sie "Debug 'test_add'".
4. Verwenden Sie die Debug-Werkzeuge, um den Fehler zu analysieren.

## Schritt 8: Refactoring und erneutes Testen

1. Korrigieren Sie den Fehler in der `add`-Funktion.
2. Führen Sie die Tests erneut aus, um sicherzustellen, dass alle Tests bestanden werden.

## Schritt 9: Erweiterung der Testabdeckung

1. Fügen Sie weitere Testfälle hinzu, um Randfälle abzudecken.
2. Führen Sie die Code-Abdeckungsanalyse erneut aus, um die verbesserte Abdeckung zu sehen.
