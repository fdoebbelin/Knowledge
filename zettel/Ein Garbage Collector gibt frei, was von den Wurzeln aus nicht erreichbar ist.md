---
id: 202611262042
title: Ein Garbage Collector gibt frei, was von den Wurzeln aus nicht erreichbar ist
type: zettel
tags:
  - informatik/speicherverwaltung
created: 2026-11-26
herkunft: 01-Courses/Programming/CS-Basics/Garbage Collection.md
---

Ein Garbage Collector kann nicht wissen, welche Objekte ein Programm künftig noch braucht. Er nutzt eine sichere Annäherung: Worauf das Programm auf keinem Weg mehr zugreifen kann, das wird es auch nie wieder brauchen.

Erreichbar ist ein Objekt in zwei Fällen. Entweder das Programm erreicht es direkt – dann ist es eine **Wurzel** (root). Oder ein erreichbares Objekt verweist darauf. Wurzeln sind vor allem globale Variablen und alles auf dem Stack, also lokale Variablen und Zwischenergebnisse. Dazu kommen Verweise, die die Laufzeitumgebung selbst hält, etwa Objekte, die der Compiler gerade erzeugt.

```
a = "erster Wert"
a = "zweiter Wert"   # "erster Wert" ist ab hier unerreichbar
```

Die Annäherung ist vorsichtig: Ein erreichbares Objekt, das das Programm nie wieder anfasst, bleibt trotzdem liegen. Der Fehler in die andere Richtung wäre fatal. Übersieht der Collector eine Wurzel, gibt er ein Objekt frei, das noch benutzt wird. Viele GC-Fehler sind genau das – etwa ein frisch angelegtes Objekt, das noch nirgends verankert ist, wenn die nächste Speicheranforderung eine Sammlung auslöst.

## Verbindungen

- [[Mark-Sweep markiert erst alles Erreichbare und räumt dann den Rest weg]] – das Verfahren, das diese Erreichbarkeit praktisch bestimmt
- [[Wann ein Garbage Collector läuft, ist ein Tausch zwischen Durchsatz und Latenz]] – wann die Prüfung auf Erreichbarkeit überhaupt läuft
- [[Grundlagen der Informatik]] – Strukturzettel zu diesem Thema

## Quellen

- [[Crafting Interpreters – Garbage Collection]]
