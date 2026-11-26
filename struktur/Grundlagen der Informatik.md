---
id: 202611262034
title: Grundlagen der Informatik
type: struktur
tags:
  - informatik
created: 2026-11-26
---

Begriffe, Geschichte und Grundmechanismen der Informatik – das, was unter den Werkzeugen liegt. Die Abschnitte lassen sich unabhängig voneinander lesen.

## Was Informatik ist

- [[Informatik fragt nach dem Warum, IT nach dem Betrieb]] – die Abgrenzung zur IT, mit der vieles andere leichter einzuordnen ist

## Geschichte

- [[Die Turing-Maschine beschreibt, was überhaupt berechenbar ist]] – das theoretische Fundament, noch vor jedem elektronischen Rechner
- [[Die Von-Neumann-Architektur legt Programm und Daten in denselben Speicher]] – wie aus dem Modell ein gebauter Rechner wurde
- [[Die Rechnergenerationen sind nach ihrem Schaltelement benannt]] – wie die Bauteiltechnik den Takt vorgab
- [[Programmieren galt anfangs als wenig angesehene Frauenarbeit]] – wer anfangs programmierte und warum sich das änderte

## Speicherverwaltung

- [[Ein Garbage Collector gibt frei, was von den Wurzeln aus nicht erreichbar ist]] – das Kriterium: erreichbar oder nicht
- [[Mark-Sweep markiert erst alles Erreichbare und räumt dann den Rest weg]] – das Grundverfahren mit der Dreifarben-Abstraktion
- [[Wann ein Garbage Collector läuft, ist ein Tausch zwischen Durchsatz und Latenz]] – wann gesammelt wird und was es kostet

## Koordinaten in der Grafik

- [[Der Bildschirm-Ursprung oben links stammt aus der Abtastreihenfolge der Bildröhre]] – woher der Ursprung oben links kommt
- [[Die Richtung der y-Achse hängt von der Domäne ab, nicht von der Epoche]] – warum beide Richtungen bis heute nebeneinander bestehen
- [[OpenGL-Texturen stehen auf dem Kopf, weil Bilddateien oben beginnen]] – das klassische Beispiel für die Reibung zwischen beiden

## Quellen

- [[Geschichte der Informatik – Abriss]] – die Zeittafel, aus der der Abschnitt Geschichte stammt
- [[Crafting Interpreters – Garbage Collection]] – ein Garbage Collector Schritt für Schritt in C
