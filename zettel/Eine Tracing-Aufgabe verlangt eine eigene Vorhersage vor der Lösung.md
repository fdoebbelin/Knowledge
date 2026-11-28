---
id: 202611281530
title: Eine Tracing-Aufgabe verlangt eine eigene Vorhersage vor der Lösung
type: zettel
tags:
  - programmieren/didaktik
created: 2026-11-28
herkunft: 01-Courses/Programming/PythonAugmentedDevelopment
---

Beim **Tracing** verfolgt man ein kurzes Programm Zeile für Zeile von Hand und notiert, welche Werte die Variablen haben, ob eine Bedingung zutrifft und was ausgegeben wird. Geübt wird die Vorstellung davon, wie der Rechner den Code ausführt.

```python
x = 5
y = x + 3
x = x * 2
print(y)    # was wird ausgegeben, 8 oder 13?
```

Lernen kann man daran nur, wenn man sich **vorher festlegt**. Wer den Code einfach ausführt oder nach jeder Eingabe sofort „richtig“ oder „falsch“ sieht, kann raten und korrigieren, ohne den Ablauf selbst durchzuspielen. Deshalb wird hier bewusst nicht laufend geprüft: Erst wenn die Tabelle ausgefüllt ist, kommt die Lösung zum Vergleich. Wo beide abweichen, zeigt sich das falsche Bild vom Ablauf.

Beim selbst geschriebenen Code ist das anders. Dort helfen sofortige Rückmeldungen, etwa durch Tests, weil sie zum Verbessern anregen.

## Verbindungen

- [[Eine Lernumgebung muss die Daten zeigen, nicht den Code]] – eine Spannung dazu: Dort soll die Umgebung Werte sichtbar machen, hier hält man sie zunächst bewusst zurück
- [[Ein Bug ist ein technischer Fehler und ein falsches Bild im Kopf zugleich]] – Tracing deckt das falsche Bild auf
- [[Wer KI-Code prüfen soll, braucht ein eigenes Programmverständnis]] – wozu diese Fähigkeit später gebraucht wird
- [[Parsons-Puzzles üben den Programmaufbau ohne die Hürde der Syntax]] – die zweite Übungsform
- [[Programmieren lernen]] – Strukturzettel zu diesem Thema
