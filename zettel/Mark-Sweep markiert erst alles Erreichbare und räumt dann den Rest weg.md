---
id: 202611262043
title: Mark-Sweep markiert erst alles Erreichbare und räumt dann den Rest weg
type: zettel
tags:
  - informatik/speicherverwaltung
created: 2026-11-26
herkunft: 01-Courses/Programming/CS-Basics/Garbage Collection.md
---

Mark-Sweep ist das älteste Verfahren der automatischen Speicherbereinigung; John McCarthy beschrieb es 1960 für Lisp. Es arbeitet in zwei Phasen:

1. **Markieren:** Von den Wurzeln aus folgt der Collector allen Verweisen und markiert jedes Objekt, das er erreicht – eine Traversierung des Objektgraphen.
2. **Fegen:** Er geht alle Objekte des Heaps durch und gibt jedes unmarkierte frei. Die Markierungen der übrigen werden für den nächsten Lauf zurückgesetzt.

Für das Markieren hat sich die **Dreifarben-Abstraktion** eingebürgert. *Weiß* heißt: noch nicht erreicht. *Grau*: erreicht, aber die eigenen Verweise sind noch nicht verfolgt – die grauen Objekte bilden die Arbeitsliste. *Schwarz*: erreicht und vollständig verfolgt.

Der Ablauf: Alle Wurzeln werden grau. Solange es graue Objekte gibt, nimmt man eines, färbt die weißen Objekte, auf die es verweist, grau und es selbst schwarz. Am Ende sind alle erreichbaren Objekte schwarz, alles Weiße ist Müll. Weil nur weiße Objekte grau werden, bleibt der Collector auch bei zyklischen Verweisen nicht hängen – anders als bei reiner Referenzzählung sind Zyklen hier kein Problem.

Die Farben müssen nicht als Feld im Objekt stehen: Schwarz ist, was markiert und nicht mehr in der Arbeitsliste ist. Wichtig wird die Abstraktion bei inkrementellen Collectoren, die das Markieren unterbrechen und später fortsetzen.

## Verbindungen

- [[Ein Garbage Collector gibt frei, was von den Wurzeln aus nicht erreichbar ist]] – das Kriterium, nach dem markiert wird
- [[Wann ein Garbage Collector läuft, ist ein Tausch zwischen Durchsatz und Latenz]] – wie oft dieser Durchlauf sich lohnt
- [[Grundlagen der Informatik]] – Strukturzettel zu diesem Thema

## Quellen

- [[Crafting Interpreters – Garbage Collection]]
