---
id: 202611270938
title: Eine Lernumgebung muss die Daten zeigen, nicht den Code
type: zettel
tags:
  - programmieren/didaktik
created: 2026-11-27
herkunft: 01-Courses/Programming/JavaScript-STEM
---

Code ist eine Beschreibung von Veränderungen an Daten. Wer nur den Code sieht, muss diese Veränderungen im Kopf nachspielen – genau das können Anfänger noch nicht. Eine Umgebung, die beim Programmierenlernen hilft, zeigt deshalb die Werte der Variablen, wie sie sich Schritt für Schritt ändern, und macht damit sichtbar, was eine Zeile tatsächlich bewirkt.

Dazu gehören zwei verwandte Forderungen: den **Ablauf sichtbar machen** (welche Zeile läuft gerade, wie oft wurde die Schleife durchlaufen) und **verborgenen Zustand vermeiden oder anzeigen**. Processing etwa merkt sich eine „aktuelle“ Füllfarbe, die nirgends zu sehen ist – ein Rechteck wird rot, weil zwanzig Zeilen weiter oben `fill(255, 0, 0)` stand.

Werkzeuge wie Python Tutor oder der Variablenbereich und Einzelschritt-Debugger von Thonny setzen diese Idee um: Sie stellen den Speicherzustand neben den Code.

## Verbindungen

- [[Abstraktion lernt man, indem man konkreten Code schrittweise verallgemeinert]] – die zweite Forderung desselben Essays, diesmal an das Vorgehen beim Schreiben
- [[Ein Bug ist ein technischer Fehler und ein falsches Bild im Kopf zugleich]] – wer die Daten sieht, kann sein Bild vom Programm korrigieren
- [[Programmieren lernen]] – Strukturzettel zu diesem Thema

## Quellen

- [[Learnable Programming]]
