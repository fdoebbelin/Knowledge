---
id: 202611281413
title: Git speichert gleichen Inhalt nur einmal
type: zettel
tags:
  - git
created: 2026-11-28
---

Git legt Dateiinhalte als Objekte ab, die es über eine **Prüfsumme des Inhalts** anspricht. Dateiname und Pfad gehören nicht dazu; sie stehen getrennt davon in den Verzeichnisobjekten (*trees*), die auf die Inhalte verweisen.

Daraus folgt: Liegt dieselbe Datei an zwei Stellen oder unter zwei Namen im Repository, gibt es nur ein Inhaltsobjekt. Dieselbe PDF in drei Ordnern lässt das Repository kaum stärker wachsen als einmal – im Arbeitsverzeichnis liegen allerdings drei Kopien. Auch Umbenennen und Verschieben kosten fast keinen Platz.

Das gilt nur für **exakt** gleichen Inhalt. Schon ein geändertes Byte ergibt eine andere Prüfsumme und damit ein neues Objekt.

Die Prüfsumme, unter der Git eine Datei ablegen würde, berechnet `git hash-object`:

```sh
git hash-object bericht.pdf
```

## Verbindungen

- [[Binärdateien lassen ein Git-Repository schnell wachsen]] – die Kehrseite: Jede geänderte Fassung ist ein neues Objekt
- [[Eine Quelle löscht man erst, wenn die Kopie geprüft ist]] – dieselbe Prüfsumme taugt zum Vergleich von Dateien
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]
