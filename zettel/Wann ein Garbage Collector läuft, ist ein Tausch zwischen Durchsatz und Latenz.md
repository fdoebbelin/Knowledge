---
id: 202611262044
title: Wann ein Garbage Collector läuft, ist ein Tausch zwischen Durchsatz und Latenz
type: zettel
tags:
  - informatik/speicherverwaltung
created: 2026-11-26
herkunft: 01-Courses/Programming/CS-Basics/Garbage Collection.md
---

Ein Garbage Collector kostet Zeit, und diese Kosten misst man mit zwei Kennzahlen. Der **Durchsatz** ist der Anteil der Laufzeit, in dem das eigentliche Programm arbeitet: Verbringt ein Programm von zehn Sekunden eine im Collector, liegt er bei 90 %. Die **Latenz** ist die längste ununterbrochene Pause. Einmal eine Sekunde oder fünfmal eine Fünftelsekunde ergibt denselben Durchsatz, aber nur ein Fünftel der Latenz.

Ein Stop-the-World-Collector hält das Programm während der Sammlung an. Läuft er selten, häuft sich Müll, und die Pausen werden lang. Läuft er oft, besucht er immer wieder dieselben lebenden Objekte, ohne etwas freizugeben, und der Durchsatz sinkt. Welche Seite zählt, hängt vom Programm ab: Ein nächtlicher Batch-Job will Durchsatz, eine App unter dem Finger des Benutzers kurze Pausen.

Eine einfache, verbreitete Strategie ist der **selbstanpassende Heap**: Gesammelt wird, sobald der verwaltete Speicher eine Schwelle überschreitet. Danach setzt man die Schwelle auf ein Vielfaches des noch belegten Speichers, in clox auf das Doppelte bei einem Startwert von 1 MiB. So folgt die Häufigkeit der Menge lebender Daten.

Generationale Collectoren gehen weiter. Sie nutzen die Beobachtung, dass die meisten Objekte jung sterben (Generationenhypothese): Neue Objekte landen in einem kleinen Bereich, der oft gesammelt wird. Wer einige Sammlungen überlebt, wandert in einen großen Bereich, der selten an die Reihe kommt.

## Verbindungen

- [[Mark-Sweep markiert erst alles Erreichbare und räumt dann den Rest weg]] – das Verfahren, dessen Pausen hier abgewogen werden
- [[Ein Garbage Collector gibt frei, was von den Wurzeln aus nicht erreichbar ist]] – was bei jedem Lauf erneut bestimmt werden muss
- [[Grundlagen der Informatik]] – Strukturzettel zu diesem Thema

## Quellen

- [[Crafting Interpreters – Garbage Collection]]
