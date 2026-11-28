---
id: 202611281420
title: additionalDirectories gibt Claude Code nur Dateizugriff
type: zettel
tags:
  - ki/agenten
created: 2026-11-28
---

Claude Code arbeitet in dem Verzeichnis, in dem es gestartet wurde. Weitere Verzeichnisse kommen auf drei Wegen hinzu:

| Weg | Zeitpunkt |
| --- | --- |
| `claude --add-dir <pfad>` | beim Start |
| `/add-dir <pfad>` | in der laufenden Sitzung |
| `permissions.additionalDirectories` | dauerhaft, in einer Einstellungsdatei |

Für die Dateien gilt in allen Fällen: Lesen wie im Arbeitsverzeichnis ohne Rückfrage (für Netzwerkpfade gibt es eine zusätzliche Prüfung), Schreiben je nach Berechtigungsmodus.

Der Unterschied liegt in der Konfiguration. Aus Ordnern, die mit `--add-dir` oder `/add-dir` hinzukommen, lädt Claude Code auch Skills, Befehle und Subagents unter `.claude/`; eine dortige `CLAUDE.md` nur, wenn die Umgebungsvariable `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1` gesetzt ist. Die Einstellung `additionalDirectories` lädt nichts davon. Soll eine Sitzung nur in Nachbarordnern lesen und schreiben, ist sie deshalb der sparsamere Weg.

Zwei Dinge sind beim Eintragen zu beachten:

- **Vertrauen:** Steht der Eintrag in der committeten `.claude/settings.json`, wirkt er – wie `allow`-Regeln – erst, nachdem man dem Ordner im Vertrauensdialog zugestimmt hat. Eine `.claude/settings.local.json`, die Git nicht verfolgt, wartet in der Regel nicht darauf.
- **Rechnerabhängige Pfade** gehören in die lokale Datei, die man in `.gitignore` einträgt.

Welche Einstellungsdateien geladen wurden, zeigt `/status` in der Zeile *Setting sources*.

Stand: Dokumentation vom November 2026.

## Verbindungen

- [[Ein KI-Agent bekommt nur die Rechte, die seine Aufgabe braucht]] – nur die Ordner freigeben, die gebraucht werden
- [[Ein Skill ist ein Ordner mit einer SKILL.md, die der Agent erst bei Bedarf lädt]] – was `--add-dir` zusätzlich mitbringt
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]
- Claude-Code-Dokumentation: [Permissions](https://code.claude.com/docs/en/permissions), [Settings](https://code.claude.com/docs/en/settings), [Skills](https://code.claude.com/docs/en/skills)
