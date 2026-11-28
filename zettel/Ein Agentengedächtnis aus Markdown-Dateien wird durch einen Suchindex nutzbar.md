---
id: 202611281508
title: Ein Agentengedächtnis aus Markdown-Dateien wird durch einen Suchindex nutzbar
type: zettel
tags:
  - ki/agenten
created: 2026-11-28
herkunft: 02-Tech/AI/OpenClaw
---

Ein Sprachmodell behält zwischen Sitzungen von sich aus nichts. OpenClaw löst das mit gewöhnlichen Markdown-Dateien im Arbeitsordner des Agenten, in der Vorgabe `~/.openclaw/workspace`. Gemerkt ist nur, was dort gespeichert wird. Die Dateien kann man lesen, bearbeiten und sichern.

Nicht alles gehört in jeden Kontext, deshalb ist das Gedächtnis gestuft (Stand November 2026):

| Datei | Inhalt | wann geladen |
|---|---|---|
| `USER.md` (optional) | Profil und feste Vorlieben | beim Sitzungsstart |
| `MEMORY.md` | dauerhafte Fakten und Entscheidungen | beim Sitzungsstart |
| `memory/JJJJ-MM-TT.md` | Tagesnotizen | nicht bei jeder Anfrage; die von heute und gestern nach einem `/new` oder `/reset` ohne weiteren Text, sonst bei Bedarf |

Was nicht im Kontext steht, holt sich der Agent mit Such- und Lesewerkzeugen wie `memory_search` und `memory_get`. Die Suche ist **hybrid**: Ähnlichkeit der Bedeutung über Vektoren findet auch anders formulierte Stellen, die Wortsuche findet genaue Begriffe wie Kennungen oder Namen im Code. Der Index liegt in der Vorgabe in SQLite. Er ist nur der Zugang, die Quelle bleiben die Dateien.

Bevor ein langes Gespräch zusammengefasst und gekürzt wird, bekommt der Agent in der Vorgabe einen stillen Zwischenschritt, um Wichtiges zu sichern.

**Lokale Dateien heißen nicht automatisch lokale Verarbeitung:** Für die Vektoren ist in der Vorgabe ein Dienst von OpenAI eingestellt. Wer die Inhalte auf dem Rechner behalten will, muss den Anbieter ändern (`memory.search.provider`) und auch das Sprachmodell lokal betreiben.

## Verbindungen

- [[RAG gibt dem Modell passende Textstellen aus den eigenen Dokumenten mit]] – dasselbe Prinzip, angewendet auf eigene Notizen
- [[AGENTS.md ist das Projektgedächtnis eines Coding-Agenten]] – die einfachere Form: eine Datei, die immer geladen wird
- [[Das Kontextfenster begrenzt ein Gespräch, das Nutzungslimit die Zeit]] – der Grund, warum nicht alles geladen wird
- [[Ein dauerhaftes Gedächtnis macht aus einer Prompt Injection ein bleibendes Problem]] – die Kehrseite des Behaltens
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- OpenClaw-Dokumentation: [Memory](https://docs.openclaw.ai/concepts/memory)
