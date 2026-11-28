---
id: 202611281414
title: Binärdateien lassen ein Git-Repository schnell wachsen
type: zettel
tags:
  - git
created: 2026-11-28
---

Git hält jede Fassung einer Datei als eigenes Objekt fest – bei Text wie bei Binärdateien. Beim Packen speichert es ähnliche Objekte aber platzsparend als Unterschied zueinander. Bei Quelltext funktioniert das gut. PDFs, Bilder und Office-Dateien sind meist schon komprimiert: Eine kleine Änderung wirbelt große Teile der Datei durcheinander, und es bleibt wenig Gemeinsames. Werden solche Dateien oft geändert, wächst das Repository fast um jede ganze Fassung. Außerdem zeigt Git für sie keinen lesbaren Diff.

In der `.gitattributes` markiert man sie als `binary`. Git wandelt dann keine Zeilenenden um und versucht weder Text-Diff noch Text-Merge, auch wenn seine automatische Erkennung danebenläge:

```gitattributes
* text=auto eol=lf
*.pdf  binary
*.png  binary
*.docx binary
```

Kleiner wird das Repository dadurch nicht. GitHub setzt Grenzen:

- ab 50 MiB je Datei eine Warnung beim Push
- über 100 MiB je Datei wird der Push abgelehnt
- für das ganze Repository empfohlen: möglichst unter 1 GB, dringend unter 5 GB

Wird es zu groß, gibt es zwei Auswege: **Git LFS** lagert große Dateien aus der Historie aus und speichert im Repository nur einen Verweis, muss aber auf jedem Rechner eingerichtet sein. Oder man überträgt die Dateien **außerhalb von Git**, etwa über eine Dateifreigabe, und legt nur eine Notiz mit dem Link ab.

## Verbindungen

- [[Git speichert gleichen Inhalt nur einmal]] – Kopien derselben Datei kosten dagegen kaum Platz
- [[Eine gelöschte Datei bleibt in der Git-Historie]] – warum Löschen ein gewachsenes Repository nicht verkleinert
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]
- GitHub-Dokumentation: [About large files on GitHub](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github)
