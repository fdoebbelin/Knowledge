---
id: 202611270720
title: Python-Aufbaukurs zu OOP, Debugging und Testing
type: quelle
tags:
  - python/kurs
created: 2026-11-27
herkunft: 01-Courses/Programming/Python-OOP
autor: Fritz-Rainer Döbbelin
url: https://github.com/fdoebbelin/Python-OOP
art: kurs
draft: true
---

## Worum es geht

Ein Python-Aufbaukurs, der an den Grundlagenkurs anschließt und dessen Modulzählung fortsetzt (M21–M40, M37–M39 fehlen). Er beginnt mit objektorientierter Programmierung und führt dann zu Debugging, Unit-Tests, Git im Team und Codequalität. Die Module sind in Lerneinheit, Vertiefung und Aufgaben gegliedert, dazu kommen Projektaufgaben der Teilnehmer.

## Kernaussagen

- OOP wird mit der funktionalen Programmierung verglichen statt isoliert eingeführt. Klassen, Attribute und Methoden bauen auf den Funktionen aus dem Grundlagenkurs auf.
- Fehlerbehandlung gehört in die Klassen selbst. Eigene Exceptions sowie `else` und `finally` machen eine Klasse robust.
- Vererbung reicht bis zur Mehrfachvererbung. Die Reihenfolge der Methodensuche (MRO) wird über das C3-Linearisierungsverfahren erklärt, abstrakte Basisklassen über `abc`.
- Polymorphismus zeigt sich in Python vor allem als Duck Typing. Überschreiben ist üblich, Überladen im klassischen Sinn gibt es nicht.
- Debugging ist eigener Lernstoff in drei Stufen: von Print-Debugging über `pdb` mit Breakpoints und Post-Mortem bis zur systematischen Fehlersuche in der Praxis.
- Testen folgt ebenfalls drei Stufen mit pytest: Grundlagen und TDD, dann Fixtures, Mocking und parametrisierte Tests, zuletzt CI, Property-Based Testing mit Hypothesis und Benchmarks.
- Zum Abschluss kommen Teamarbeit mit Git (Pull Requests, Code Reviews, Hooks) und Schnittstellendokumentation mit Docstrings und Linting-Werkzeugen wie pylint, flake8 und mypy.

## Verwandte Quellen

- [[Python-Grundlagenkurs in 20 Modulen]] – der vorausgehende Kurs, dessen Module M01–M20 hier fortgesetzt werden

## Daraus entstandene Zettel

Noch keine.
