---
id: 202611271322
title: Das Kontextfenster begrenzt ein Gespräch, das Nutzungslimit die Zeit
type: zettel
tags:
  - ki/werkzeuge
created: 2026-11-27
herkunft: 02-Tech/AI/Claude-Code/Nutzungs- und Längenbeschränkungen verstehen.md
---

Wer mit einem KI-Dienst arbeitet, stößt auf zwei Grenzen, die leicht verwechselt werden:

- **Das Kontextfenster** ist die Textmenge, die das Modell in einem Gespräch auf einmal verarbeiten kann – gemessen in Token. Alles zählt hinein: Systemanweisungen, Projektregeln, die bisherigen Nachrichten, gelesene Dateien, Werkzeugausgaben. Ist das Fenster voll, muss Älteres weichen oder zusammengefasst werden. Es ist eine Eigenschaft des **Modells**.
- **Das Nutzungslimit** ist ein Budget über die Zeit: wie viel man in einigen Stunden oder einer Woche verbrauchen darf, bevor man warten muss. Es ist eine Eigenschaft des **Tarifs**.

Beide hängen zusammen, weil jede Nachricht den gesamten bisherigen Kontext erneut verarbeitet. Ein langes Gespräch wird also mit jeder Runde teurer, auch wenn die neue Frage kurz ist.

Daraus folgen einfache Regeln:

- Für eine neue Aufgabe ein neues Gespräch beginnen, statt ein altes fortzusetzen.
- Werkzeuge und Konnektoren abschalten, die man gerade nicht braucht – ihre Beschreibungen belegen Kontext.
- Dauerhafte Regeln knapp halten, weil sie in jedem Gespräch mitgeladen werden.
- In Coding-Agenten den Verlauf bei Bedarf zusammenfassen lassen (in Claude Code mit `/compact`).

## Verbindungen

- [[AGENTS.md ist das Projektgedächtnis eines Coding-Agenten]] – Projektregeln stehen in jedem Gespräch im Kontext und sollten deshalb kurz sein
- [[Ein Skill ist ein Ordner mit einer SKILL.md, die der Agent erst bei Bedarf lädt]] – Wissen nur dann in den Kontext holen, wenn es gebraucht wird
- [[RAG gibt dem Modell passende Textstellen aus den eigenen Dokumenten mit]] – statt ganzer Dokumente nur die passenden Stellen
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- [[Claude-Hilfe – Nutzungs- und Längengrenzen]]
