---
id: 202611271321
title: Aider macht jede Änderung zu einem Git-Commit
type: zettel
tags:
  - ki/agenten
created: 2026-11-27
herkunft: 02-Tech/AI/Aider
---

**Aider** ist ein quelloffener Coding-Agent für das Terminal, der mit fast jedem Modell arbeitet – über die API eines Anbieters oder lokal über Ollama. Seine Eigenheit: Er setzt Git voraus und committet jede Änderung, die er vornimmt, sofort mit einer selbst formulierten Commit-Nachricht.

Dadurch wird Git zum Sicherheitsnetz für die Arbeit mit der KI:

- **Nachvollziehbar:** `git log` zeigt, was der Agent wann geändert hat, getrennt von den eigenen Commits.
- **Umkehrbar:** Ein misslungener Schritt lässt sich mit `/undo` in Aider oder mit Git selbst zurücknehmen, ohne von Hand aufzuräumen.
- **Prüfbar:** `git diff` vor dem Weiterarbeiten zeigt genau, was sich geändert hat.

Wer das nicht will, schaltet es in der `.aider.conf.yml` mit `auto-commits: false` ab und committet selbst. Sinnvoll ist es, vor der Sitzung einen sauberen Stand zu committen, damit die eigenen und die fremden Änderungen nicht durcheinandergeraten.

Der Gedanke gilt über Aider hinaus: Ein Agent, der Dateien ändert, sollte in einem Repository arbeiten, in dem jeder Schritt zurückgenommen werden kann.

## Verbindungen

- [[Je weniger umkehrbar eine Aktion ist, desto eher braucht ein Agent eine Freigabe]] – Git macht Dateiänderungen umkehrbar und senkt so die Schwelle für Freigaben
- [[Versionsverzeichnis und Symlink machen Updates umkehrbar]] – dieselbe Idee bei Installationen
- [[Eine gelöschte Datei bleibt in der Git-Historie]] – warum sich auch Gelöschtes zurückholen lässt
- [[Lokale Modellserver sprechen die OpenAI-API]] – so lässt sich Aider an ein lokales Modell hängen
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema
