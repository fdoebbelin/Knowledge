---
id: 202611271319
title: AGENTS.md ist das Projektgedächtnis eines Coding-Agenten
type: zettel
tags:
  - ki/agenten
created: 2026-11-27
herkunft: 02-Tech/AI/OpenCode
---

Ein Coding-Agent beginnt jede Sitzung ohne Erinnerung an die letzte. Was er über ein Projekt wissen muss – Aufbau, Konventionen, Befehle, Verbote –, steht deshalb in einer Markdown-Datei im Projektstamm, die er bei jedem Start selbst liest.

Den Namen bestimmt das Werkzeug: OpenCode und viele andere Agenten lesen `AGENTS.md`, Claude Code liest `CLAUDE.md`. Wer mehrere Agenten nutzt, schreibt die Regeln an **eine** Stelle und verweist von der anderen darauf. Dieses Repository macht es so: Die Regeln stehen in `AGENTS.md`, und `CLAUDE.md` enthält nur die Zeile `@AGENTS.md`, mit der Claude Code die andere Datei einbindet.

In die Datei gehört, was der Agent nicht selbst aus dem Code ablesen kann:

- wie man baut, testet und prüft
- Konventionen, die nirgends erzwungen werden (Dateinamen, Sprache, Commit-Stil)
- was er nicht tun darf („nicht löschen“, „kein Push ohne Freigabe“)
- wo was liegt, wenn die Struktur nicht offensichtlich ist

Nicht hinein gehört, was sich ändert oder nur eine Sitzung betrifft – dafür ist ein Übergabeprotokoll da. Und die Datei sollte kurz bleiben: Sie wird in jedem Gespräch mitgeladen und belegt dort Platz.

Die Werkzeuge suchen meist auch global (etwa `~/.config/opencode/AGENTS.md`) und in Unterordnern; nähere Dateien ergänzen die allgemeineren.

## Verbindungen

- [[Das Kontextfenster begrenzt ein Gespräch, das Nutzungslimit die Zeit]] – warum die Datei knapp bleiben muss
- [[Ein Skill ist ein Ordner mit einer SKILL.md, die der Agent erst bei Bedarf lädt]] – das Gegenstück für Wissen, das nur manchmal gebraucht wird
- [[Ein Agenten-Prompt nennt Ziel, Kontext, Werkzeuge, Grenzen und Stoppbedingung]] – AGENTS.md liefert Kontext und Grenzen dauerhaft, der Prompt das Ziel
- [[Ein Agentengedächtnis aus Markdown-Dateien wird durch einen Suchindex nutzbar]] – die Ausbaustufe, in der der Agent selbst Erinnerungen schreibt und sucht
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema
