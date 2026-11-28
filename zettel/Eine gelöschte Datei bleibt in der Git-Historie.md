---
id: 202611281415
title: Eine gelöschte Datei bleibt in der Git-Historie
type: zettel
tags:
  - git
created: 2026-11-28
---

Wer eine Datei mit `git rm` löscht und committet, entfernt sie aus dem aktuellen Stand, nicht aus dem Repository. Die früheren Commits enthalten sie weiter.

Den passenden Commit findet das Protokoll, auch über alle Branches:

```sh
git log --oneline --all -- pfad/zur/datei
```

Der oberste Treffer ist meist der Commit, der die Datei gelöscht hat. Zurückholen muss man sie aus einem Stand, der sie noch enthält, etwa dem davor:

```sh
git restore --source <commit> -- pfad/zur/datei
```

Das hat zwei Seiten:

- **Aufräumen ist gefahrlos.** Ein Verzeichnis, durch das Dateien nur durchlaufen, darf man leer halten. Was committet war, lässt sich zurückholen, solange die Historie nicht umgeschrieben wird.
- **Löschen verkleinert das Repository nicht.** Dafür müsste man die Historie umschreiben, etwa mit `git filter-repo`. Das betrifft jeden vorhandenen Klon.

Was nie committet wurde, kennt die Historie nicht.

## Verbindungen

- [[Ein gepushtes Geheimnis muss man austauschen]] – die unangenehme Folge, wenn Zugangsdaten in der Historie liegen
- [[Binärdateien lassen ein Git-Repository schnell wachsen]] – dort wird das dauerhafte Aufbewahren zum Platzproblem
- [[Aider macht jede Änderung zu einem Git-Commit]] – nutzt die Historie, um Schritte zurückzunehmen
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]
