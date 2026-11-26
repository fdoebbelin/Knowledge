---
id: 202611262041
title: Crafting Interpreters – Garbage Collection
type: quelle
tags:
  - informatik/speicherverwaltung
created: 2026-11-26
herkunft: 01-Courses/Programming/CS-Basics/Garbage Collection.md
autor: Robert Nystrom
url: https://craftinginterpreters.com/garbage-collection.html
art: buch
---

## Worum es geht

Kapitel 26 des frei online lesbaren Buchs *Crafting Interpreters*. Für die Lehrsprache Lox und ihre Implementierung in C (clox) wird Schritt für Schritt ein Mark-Sweep-Garbage-Collector gebaut: Wurzeln finden, Verweise verfolgen, Unerreichbares freigeben, den richtigen Zeitpunkt wählen und die typischen Fehler vermeiden.

## Kernaussagen

- Freigegeben wird, was von den Wurzeln – Stack, globale Variablen, interne Verweise der Laufzeitumgebung – nicht mehr erreichbar ist.
- Mark-Sweep markiert erst alle erreichbaren Objekte und fegt dann den Rest weg. Die Dreifarben-Abstraktion mit einer Arbeitsliste grauer Objekte macht das Markieren nachvollziehbar und robust gegen Zyklen.
- Die Arbeitsliste selbst darf nicht vom Collector verwaltet werden, sonst könnte ihr Wachsen eine Sammlung mitten in der Sammlung auslösen.
- Schwach gehaltene Verweise wie ein Pool internierter Zeichenketten müssen vor dem Fegen bereinigt werden.
- Der Zeitpunkt der Sammlung ist ein Tausch zwischen Durchsatz und Latenz; clox nutzt einen Heap, dessen Schwelle mit dem lebenden Speicher wächst.
- Die meisten GC-Fehler entstehen, wenn ein neues Objekt noch nirgends verankert ist, während eine Speicheranforderung die Sammlung auslöst.

## Daraus entstandene Zettel

- [[Ein Garbage Collector gibt frei, was von den Wurzeln aus nicht erreichbar ist]]
- [[Mark-Sweep markiert erst alles Erreichbare und räumt dann den Rest weg]]
- [[Wann ein Garbage Collector läuft, ist ein Tausch zwischen Durchsatz und Latenz]]
