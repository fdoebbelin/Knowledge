---
id: 202611281655
title: UML-Diagramme beschreiben Struktur oder Verhalten
type: zettel
tags:
  - uml
created: 2026-11-28
herkunft: 01-Courses/Business/UML-Basics
---

Die erste Frage bei der Wahl eines UML-Diagramms lautet: Will ich zeigen, **woraus** ein System besteht, oder **was in ihm geschieht**? UML 2.5.1 teilt seine 14 Diagrammarten in diese zwei Hauptgruppen.

**Strukturdiagramme** zeigen den statischen Aufbau, unabhängig vom zeitlichen Ablauf:

- Klassendiagramm
- Objektdiagramm
- Paketdiagramm
- Komponentendiagramm
- Kompositionsstrukturdiagramm
- Verteilungsdiagramm
- Profildiagramm

**Verhaltensdiagramme** zeigen, wie sich das System verhält und über die Zeit verändert:

- Anwendungsfalldiagramm
- Aktivitätsdiagramm
- Zustandsdiagramm
- **Interaktionsdiagramme** als Untergruppe: Sequenzdiagramm, Kommunikationsdiagramm, Zeitverlaufsdiagramm und Interaktionsübersichtsdiagramm

Die Einteilung ordnet, sie ist aber keine strenge Grenze. Die Spezifikation lässt ausdrücklich zu, Elemente zu mischen, etwa einen Zustandsautomaten in einer inneren Struktur zu zeigen.

## Verbindungen

- [[Komposition bindet die Teile an das Ganze, Aggregation nicht]] – eine Beziehung aus den Strukturdiagrammen
- [[include bindet Verhalten immer ein, extend ergänzt es unter Bedingungen]] – zwei Beziehungen aus dem Anwendungsfalldiagramm
- [[Software modellieren mit UML]] – Strukturzettel zu diesem Thema

## Quellen

- OMG: [Unified Modeling Language 2.5.1](https://www.omg.org/spec/UML/2.5.1/), Anhang A „Diagrams“
