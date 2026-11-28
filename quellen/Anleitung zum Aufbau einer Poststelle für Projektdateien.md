---
id: 202611281423
title: Anleitung zum Aufbau einer Poststelle für Projektdateien
type: quelle
tags:
  - git
  - dateiablage
  - ki/agenten
created: 2026-11-28
art: doku
---

## Worum es geht

Eine Schritt-für-Schritt-Anleitung für ein privates GitHub-Repository, das Chatprotokolle, PDFs und andere Dateien annimmt, nach Zielprojekt sortiert und in die Projekte zustellt. Claude Code übernimmt das mit zwei Skills zum Einliefern und Zustellen. Der Volltext – eine Übersicht, zehn Schritte und vier Konzeptnotizen – liegt im privaten Repository `00-Poststelle` unter `docs/anleitung/` und hat deshalb keinen öffentlichen Link.

## Kernaussagen

- Die Poststelle transportiert nur; Inhalte bearbeitet das Zielprojekt.
- Der Weg hat zwei Stufen, Eingang und Ausgang, damit Annahme und Zustellung auf verschiedenen Rechnern stattfinden können.
- Eine kurze `CLAUDE.md` enthält die Regeln, die immer gelten; die Abläufe stehen in den Skills.
- Git-Befehle in der Poststelle sind vorab erlaubt, das Schreiben in Zielprojekte bleibt ohne Vorabfreigabe.
- Eine Sendung wird erst gelöscht, wenn die Kopie per `git hash-object` geprüft und die Zustellung im Journal vermerkt ist.

## Abweichungen bei der Einrichtung

Die erste Zustellung war die Anleitung selbst. Gegenüber ihrem Text wurde laut Historie des Poststellen-Repositorys geändert:

- **Berechtigungen:** Neben den `Bash(…)`-Regeln für die Git-Befehle stehen gleichlautende `PowerShell(…)`-Regeln. Die Claude-Code-Dokumentation führt PowerShell-Regeln in derselben Form wie Bash-Regeln auf.
- **`.obsidian/`:** Die Ordner mit den Obsidian-Einstellungen sind in `.gitignore` ausgeschlossen und gehören nie zu einer Sendung.
- **Zugangsdaten:** Die Prüfung reagiert auf echte Werte, nicht mehr auf Wörter wie `token` oder `password`.
- **Commit-Nachricht:** Die Hausordnung nennt für Zustellungen jetzt dasselbe Format wie der Skill.
- **Eingang im Zielprojekt:** Für diese Wissensbasis ist es `inbox/`, nicht `_eingang/` wie in der Anleitung.

## Bei der Übernahme berichtigt

- Dass jede neue Fassung als eigenes Objekt gespeichert wird, gilt auch für Textdateien. Binärdateien unterscheiden sich darin, dass sie sich beim Packen schlecht als Unterschied speichern lassen.
- In der Sortierung des Windows-Explorers stehen `_` und `!` noch vor den Ziffern.
- `--add-dir` und `/add-dir` laden außer Skills und Befehlen auch Subagents.

## Nicht übernommen

Die Einrichtungsschritte mit allen Dateiinhalten (aus dem Anlegen des Repositorys stammt nur die Nutzung von `gh repo create` und `gh repo view`), die Liste der Zielprojekte, Angaben zu den eigenen Rechnern, der Probelauf, die Pflegeroutine und die offenen Aufgabenlisten.

## Daraus entstandene Zettel

- [[Ein Austausch-Repository stellt Dateien zu, ohne sie zu bearbeiten]]
- [[Eine Quelle löscht man erst, wenn die Kopie geprüft ist]]
- [[Ein Ziffernpräfix sortiert Namen vor die Buchstaben]]
- [[Git speichert gleichen Inhalt nur einmal]]
- [[Binärdateien lassen ein Git-Repository schnell wachsen]]
- [[Eine gelöschte Datei bleibt in der Git-Historie]]
- [[Ein gepushtes Geheimnis muss man austauschen]]
- [[Ein Geheimnis-Check sucht nach echten Werten statt nach Wörtern]]
- [[additionalDirectories gibt Claude Code nur Dateizugriff]]
- [[Einen Skill mit Nebenwirkungen startet nur der Mensch]]
- [[gh repo create legt ein neues Repository an und klont es sofort]]
