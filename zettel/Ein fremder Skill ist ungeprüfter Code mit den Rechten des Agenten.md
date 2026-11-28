---
id: 202611281505
title: Ein fremder Skill ist ungeprüfter Code mit den Rechten des Agenten
type: zettel
tags:
  - ki/agenten
  - ki/sicherheit
created: 2026-11-28
herkunft: 02-Tech/AI/OpenClaw
---

Ein Skill besteht oft vor allem aus Text: eine `SKILL.md` mit Anweisungen, was der Agent wann tun soll. Das sieht harmloser aus als ein Programm. Der Agent folgt diesen Anweisungen aber mit seinen eigenen Werkzeugen. Wer den Text schreibt, steuert also mit, was auf dem System geschieht. Dazu kann ein Skill weitere Dateien mitbringen und Programme oder Zugangsschlüssel voraussetzen.

Die Dokumentation von OpenClaw sagt es deutlich: Skills von Dritten sind als **nicht vertrauenswürdiger Code** zu behandeln. Praktisch heißt das:

- vor dem Aktivieren lesen, was darin steht
- nur aktivieren, was man wirklich braucht
- Voraussetzungen prüfen: Programme auf dem Rechner, Umgebungsvariablen, Zugangsschlüssel
- bei heiklen Werkzeugen oder fremden Eingaben möglichst in einer Sandbox ausführen

Eine Sandbox deckt nicht alles ab: Bei OpenClaw werden die für einen Skill eingetragenen Umgebungsvariablen und API-Schlüssel in den Prozess auf dem Host gesetzt, nicht in die Sandbox. Prüfhinweise eines Skill-Verzeichnisses ersetzen das eigene Lesen nicht.

Dasselbe Misstrauen gilt für die Bezugsquelle des Agenten selbst. Gerade nach Umbenennungen kann ein nachgemachtes Repository oder eine ähnlich geschriebene Adresse echt wirken. Schadcode muss darin nicht von Anfang an stecken, er kann mit einer späteren Änderung kommen.

## Verbindungen

- [[Ein Skill ist ein Ordner mit einer SKILL.md, die der Agent erst bei Bedarf lädt]] – wie ein Skill aufgebaut ist
- [[Einen Skill mit Nebenwirkungen startet nur der Mensch]] – begrenzt, wann ein Skill läuft, prüft aber nicht seinen Inhalt
- [[Ein KI-Agent bekommt nur die Rechte, die seine Aufgabe braucht]] – die Rechte des Agenten sind die Obergrenze für den Schaden
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- [[IT-Administrator – OpenClaw-Agenten übernehmen das Ruder]]
- [[Golem – OpenClaw nach Namensänderungen unter Beschuss]]
- OpenClaw-Dokumentation: [Skills](https://docs.openclaw.ai/tools/skills)
