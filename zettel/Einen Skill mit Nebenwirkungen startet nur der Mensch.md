---
id: 202611281421
title: Einen Skill mit Nebenwirkungen startet nur der Mensch
type: zettel
tags:
  - ki/agenten
  - ki/sicherheit
created: 2026-11-28
---

Normalerweise entscheidet ein Agent anhand der Beschreibung selbst, wann er einen Skill lädt. Für Nachschlagewissen ist das gewollt. Verschiebt ein Skill aber Dateien, pusht er Commits oder veröffentlicht er etwas, soll nicht eine passend klingende Formulierung im Gespräch genügen, um ihn auszulösen.

In Claude Code regelt das ein Feld im Frontmatter der `SKILL.md`:

```yaml
---
name: zustellen
description: Stellt Sendungen in die Zielprojekte zu.
disable-model-invocation: true
argument-hint: "[ziel | alle]"
---
```

Mit `disable-model-invocation: true` lädt Claude den Skill nicht von sich aus; man ruft ihn mit `/zustellen` auf. Die Beschreibung steht dann auch nicht im Kontext. Der Skill wird außerdem nicht vorab in Subagents geladen und nicht von geplanten Aufgaben ausgeführt.

`argument-hint` zeigt beim Eintippen, welche Eingabe erwartet wird; im Text des Skills steht sie als `$ARGUMENTS` zur Verfügung.

Das Feld regelt nur, **wer den Skill startet**. Was der Agent währenddessen darf, bestimmen weiterhin die Berechtigungen.

Stand: Dokumentation vom November 2026.

## Verbindungen

- [[Ein Skill ist ein Ordner mit einer SKILL.md, die der Agent erst bei Bedarf lädt]] – das Laden bei Bedarf, das hier abgeschaltet wird
- [[Je weniger umkehrbar eine Aktion ist, desto eher braucht ein Agent eine Freigabe]] – der ausdrückliche Aufruf ist die erste Freigabe
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]
- Claude-Code-Dokumentation: [Skills](https://code.claude.com/docs/en/skills)
