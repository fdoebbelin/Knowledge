---
id: 202611271320
title: Ein Skill ist ein Ordner mit einer SKILL.md, die der Agent erst bei Bedarf lädt
type: zettel
tags:
  - ki/agenten
created: 2026-11-27
herkunft: 02-Tech/AI/Claude-Skills
---

Ein **Skill** bringt einem Agenten ein Verfahren bei, etwa „Chat-Protokoll für Obsidian erstellen“. Er ist schlicht ein Ordner:

```text
chat-protokoll/
├── SKILL.md            # Frontmatter mit name und description, dann Anweisungen
└── references/
    └── frontmatter.md  # Detailvorgabe, nur bei Bedarf gelesen
```

Der Clou ist das gestufte Laden. In jedem Gespräch kennt der Agent nur Name und Beschreibung aus dem Frontmatter – wenige Zeilen je Skill. Passt eine Aufgabe zur Beschreibung, lädt er den Text der `SKILL.md`. Begleitdateien liest er erst, wenn die `SKILL.md` ausdrücklich auf sie verweist und er sie gerade braucht.

So kann ein Agent viele Skills haben, ohne dass sie den Kontext füllen. Daraus folgen zwei Regeln:

- **Die Beschreibung entscheidet**, ob der Skill überhaupt zum Zug kommt. Sie muss sagen, *wann* er passt, nicht nur, was er tut.
- **Details gehören in Begleitdateien.** Eine lange Vorgabe in der `SKILL.md` kostet bei jedem Aufruf Platz; als eigene Datei kostet sie nur, wenn sie gebraucht wird, und lässt sich ändern, ohne die Anweisungen anzufassen.

Das Format stammt von Anthropic; OpenCode liest Skills im selben Aufbau aus `.opencode/skills/`.

## Verbindungen

- [[AGENTS.md ist das Projektgedächtnis eines Coding-Agenten]] – immer geladen, im Gegensatz zum Skill
- [[Das Kontextfenster begrenzt ein Gespräch, das Nutzungslimit die Zeit]] – der Grund für das gestufte Laden
- [[Einen Skill mit Nebenwirkungen startet nur der Mensch]] – wann der Agent nicht selbst entscheiden soll
- [[Ein fremder Skill ist ungeprüfter Code mit den Rechten des Agenten]] – warum man einen Skill vor dem Aktivieren liest
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema
