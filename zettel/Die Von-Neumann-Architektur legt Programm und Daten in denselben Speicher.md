---
id: 202611262038
title: Die Von-Neumann-Architektur legt Programm und Daten in denselben Speicher
type: zettel
tags:
  - informatik/geschichte
  - informatik/rechnerarchitektur
created: 2026-11-26
herkunft: 01-Courses/Programming/CS-Basics/Geschichte-Informatik.md
---

John von Neumann beschrieb 1945 im Entwurf zum Rechner EDVAC ein Prinzip, das bis heute fast alle Computer prägt: Das Programm wird nicht mehr von außen gesteckt oder per Lochstreifen eingespeist, sondern liegt als Daten im selben Speicher wie die Werte, mit denen es rechnet. Das ist der **speicherprogrammierte Rechner**.

Die Bausteine sind Rechenwerk, Steuerwerk, Speicher sowie Ein- und Ausgabe, verbunden über einen gemeinsamen Bus. Das Steuerwerk holt Befehl für Befehl aus dem Speicher, dekodiert ihn und führt ihn aus.

Daraus folgt zweierlei. Ein Programm lässt sich laden, austauschen und sogar von einem anderen Programm erzeugen – Lader, Compiler und Betriebssysteme beruhen darauf. Zugleich teilen sich Befehle und Daten den Weg zum Speicher. Weil der Prozessor schneller rechnet, als der Speicher liefert, wartet er oft; das nennt man den **Von-Neumann-Flaschenhals**. Caches mildern ihn.

Das Gegenstück ist die **Harvard-Architektur** mit getrennten Speichern für Befehle und Daten, benannt nach dem Harvard Mark I. Sie ist heute vor allem in Mikrocontrollern und digitalen Signalprozessoren verbreitet.

## Verbindungen

- [[Die Turing-Maschine beschreibt, was überhaupt berechenbar ist]] – das theoretische Modell, das ein speicherprogrammierter Rechner verwirklicht
- [[Die Rechnergenerationen sind nach ihrem Schaltelement benannt]] – die Bauteile, mit denen diese Architektur über die Jahrzehnte umgesetzt wurde
- [[Grundlagen der Informatik]] – Strukturzettel zu diesem Thema

## Quellen

- [[Geschichte der Informatik – Abriss]]
