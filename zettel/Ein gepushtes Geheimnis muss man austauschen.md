---
id: 202611281416
title: Ein gepushtes Geheimnis muss man austauschen
type: zettel
tags:
  - git
  - sicherheit
created: 2026-11-28
---

Wurde ein Passwort, Token oder privater Schlüssel committet und gepusht, gilt es als offengelegt. Der erste Schritt ist deshalb, es **zu widerrufen oder zu ersetzen**. Die Datei zu löschen und erneut zu committen hilft nicht, denn die alten Commits enthalten den Wert weiter.

Auch das Umschreiben der Historie mit anschließendem Force-Push reicht allein nicht. GitHub weist darauf hin, dass die Daten anderswo erreichbar bleiben können:

- in Klonen und Forks des Repositorys
- auf GitHub selbst über die direkte Commit-Prüfsumme in zwischengespeicherten Ansichten

Ein ausgetauschtes Geheimnis ist dagegen wertlos, egal wo noch Kopien liegen. Ob man danach zusätzlich die Historie bereinigt, ist eine zweite Entscheidung.

Auch bei einem privaten Repository sollte man so verfahren: Wer Zugriff hat oder später bekommt, kann die ganze Historie lesen, und aus privat kann öffentlich werden.

## Verbindungen

- [[Eine gelöschte Datei bleibt in der Git-Historie]] – der Grund, warum Löschen nicht reicht
- [[Ein Geheimnis-Check sucht nach echten Werten statt nach Wörtern]] – besser, das Geheimnis kommt gar nicht erst hinein
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]
- GitHub-Dokumentation: [Removing sensitive data from a repository](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)
