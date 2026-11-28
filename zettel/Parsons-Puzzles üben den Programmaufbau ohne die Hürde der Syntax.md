---
id: 202611281529
title: Parsons-Puzzles üben den Programmaufbau ohne die Hürde der Syntax
type: zettel
tags:
  - programmieren/didaktik
created: 2026-11-28
herkunft: 01-Courses/Programming/PythonAugmentedDevelopment
---

Bei einem **Parsons-Puzzle** bekommen Lernende die Zeilen eines Programms in gemischter Reihenfolge und setzen sie richtig zusammen. Weil die Zeilen schon geschrieben sind, fallen Tippfehler und vergessene Zeichen weg. Die Aufmerksamkeit gilt dem Aufbau: Was muss zuerst geschehen, was gehört in welchen Zweig oder in welche Schleife?

Ein Beispiel in richtiger Reihenfolge, das man gemischt vorlegt:

```python
zahl = int(input('Zahl: '))
if zahl > 0:
    print('positiv')
else:
    print('nicht positiv')
```

Schwerer wird die Aufgabe mit **Distraktoren**, also zusätzlichen Zeilen, die nicht hineingehören, etwa `if zahl >= 0:` neben der richtigen Bedingung. Dann reicht Sortieren nicht, man muss sich auch entscheiden. Dazu sollte die Aufgabenstellung eindeutig sagen, was das Programm leisten soll, sonst sind beide Zeilen vertretbar. Ebenso ist zu bedenken, ob mehrere Reihenfolgen richtig sind, besonders bei einer automatischen Prüfung.

Das Puzzle liegt zwischen Lesen und freiem Schreiben und eignet sich als Zwischenschritt.

## Verbindungen

- [[Eine Tracing-Aufgabe verlangt eine eigene Vorhersage vor der Lösung]] – die zweite Übungsform: Abläufe nachvollziehen statt zusammensetzen
- [[Wer KI-Code prüfen soll, braucht ein eigenes Programmverständnis]] – wozu das Üben ohne KI dient
- [[Abstraktion lernt man, indem man konkreten Code schrittweise verallgemeinert]] – ein weiterer Zwischenschritt zum eigenen Programm
- [[Programmieren lernen]] – Strukturzettel zu diesem Thema
