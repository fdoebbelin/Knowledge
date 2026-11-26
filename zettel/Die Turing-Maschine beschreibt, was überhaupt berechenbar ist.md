---
id: 202611262037
title: Die Turing-Maschine beschreibt, was überhaupt berechenbar ist
type: zettel
tags:
  - informatik/geschichte
  - informatik/theorie
created: 2026-11-26
herkunft: 01-Courses/Programming/CS-Basics/Geschichte-Informatik.md
---

Alan Turing entwarf 1936 ein gedachtes Gerät, um zu klären, was „mechanisch berechnen“ eigentlich heißt: ein unendlich langes Band aus Feldern, ein Schreib-Lese-Kopf, eine endliche Menge von Zuständen und eine Tabelle von Regeln. Jede Regel sagt: Liest der Kopf im Zustand Z das Zeichen a, dann schreibe b, bewege dich ein Feld nach links oder rechts und wechsle in den Zustand Z′.

Das Modell ist absichtlich primitiv, und gerade das macht es stark. Alles, was ein heutiger Computer berechnen kann, kann im Prinzip auch eine Turing-Maschine – nur unvorstellbar langsamer. Die Church-Turing-These besagt, dass damit der Begriff der Berechenbarkeit vollständig erfasst ist: Was sich überhaupt durch ein Verfahren berechnen lässt, berechnet auch eine Turing-Maschine. Eine Programmiersprache, die ebenso viel kann, heißt **turingvollständig**.

Das Modell zeigt auch Grenzen. Turing bewies, dass keine Turing-Maschine für jedes beliebige Programm entscheiden kann, ob es irgendwann anhält (Halteproblem). Manche Fragen sind also grundsätzlich nicht berechenbar, gleich wie schnell die Hardware wird.

Die Turing-Maschine ist ein Modell, kein Bauplan. Wie man einen solchen universellen Rechner tatsächlich baut, beschrieb wenig später die Von-Neumann-Architektur.

## Verbindungen

- [[Informatik fragt nach dem Warum, IT nach dem Betrieb]] – die Frage nach dem Berechenbaren ist der Kern der Informatik
- [[Die Von-Neumann-Architektur legt Programm und Daten in denselben Speicher]] – vom gedachten Modell zum gebauten Rechner
- [[Grundlagen der Informatik]] – Strukturzettel zu diesem Thema

## Quellen

- [[Geschichte der Informatik – Abriss]]
