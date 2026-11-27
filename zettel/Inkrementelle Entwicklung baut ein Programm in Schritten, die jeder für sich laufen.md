---
id: 202611270940
title: Inkrementelle Entwicklung baut ein Programm in Schritten, die jeder für sich laufen
type: zettel
tags:
  - programmieren/didaktik
created: 2026-11-27
herkunft: 01-Courses/Programming/JavaScript-STEM
---

Ein größeres Vorhaben wird nicht in einem Zug programmiert, sondern in Teile zerlegt und diese wieder in so kleine Schritte, dass jeder Schritt ein lauffähiges Programm ergibt. *Learning Processing* zeigt das an einem Space-Invaders-Spiel: erst das Raumschiff, dann die Angreifer, dann die Punktzählung. Allein das Raumschiff entsteht in sechs Schritten:

1. Ein Dreieck zeichnen.
2. Es an den unteren Rand setzen.
3. Es etwas nach rechts verschieben.
4. Es von links nach rechts wandern lassen.
5. Es nur bewegen, solange die Pfeiltaste nach rechts gedrückt ist.
6. Dasselbe nach links.

Der Gewinn liegt in der Fehlersuche: Geht nach einem Schritt etwas schief, kommt fast nur die letzte Änderung als Ursache in Frage. Der Haken: Um die Schritte so zu wählen, braucht man schon eine Vorstellung davon, wie das Ziel technisch aussieht – für echte Anfänger ist gerade das Zerlegen die schwerste Aufgabe.

## Verbindungen

- [[Ein Bug ist ein technischer Fehler und ein falsches Bild im Kopf zugleich]] – kleine Schritte halten die Lücke zwischen Bild und Programm klein
- [[Abstraktion lernt man, indem man konkreten Code schrittweise verallgemeinert]] – dieselbe Schrittfolge im Kleinen, innerhalb einer Funktion
- [[Programmieren lernen]] – Strukturzettel zu diesem Thema

## Quellen

- [[Learning p5.js – Notizen zu Learning Processing]]
