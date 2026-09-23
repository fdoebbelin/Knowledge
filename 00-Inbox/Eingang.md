---
title: Eingang
aliases:
  - Inbox
tags:
  - meta
created: 2026-09-22
updated: 2026-09-22
---

# Eingang (00-Inbox)

Durchgangsstation für Dokumente, die noch keinen Platz in der Wissensbasis haben: Chat-Protokolle, exportierte Unterlagen, Entwürfe, Fundstücke. Hier liegt nichts dauerhaft.

> [!info] Unterschied zu `05-Notes/Clippings`
> `Clippings` sind Web-Artikel, die beim Lesen anfallen. In `00-Inbox` landet alles, was **gemeinsam mit Claude Code** eingeordnet werden soll.

## Ablauf

1. **Ablegen:** Datei nach `00-Inbox/` legen. Dateiname frei, bei Protokollen bewährt: `JJJJ-MM-TT Thema.md`.
2. **Einordnen:** In Claude Code sagen, was eingeordnet werden soll. Dabei wird geklärt: Zielordner, Dateiname, Frontmatter, Verweise auf vorhandene Notizen.
3. **Verschieben:** mit `git mv`, damit die Historie erhalten bleibt.
4. **Verlinken:** Ziel-Ordner und verwandte Notizen gegenseitig verbinden, Struktur-Übersicht bei neuen Ordnern ergänzen.

## Wohin es danach geht

| Inhalt | Ziel |
| --- | --- |
| Anleitung zu Werkzeug oder System | `02-Tech/<Thema>/` |
| Arbeit an einem eigenen Projekt | `03-Projects/<Name>/` |
| Kursmaterial | `01-Courses/<Bereich>/<Kurs>/` |
| Sprachreferenz | `04-Languages/<Sprache>/` |
| Nicht mehr aktuell | `05-Notes/Archive/` |
| Persönliches, Zugangsdaten | Vault **Personal** |

Ausführlich: [[Struktur-Übersicht]].

## Konventionen für Chat-Protokolle

Erzeugt mit dem Skill `chat-protokoll`. Erkennbar am Frontmatter `type: chat-protokoll` und am Tag `chat-protokoll`; darüber lassen sich alle Protokolle finden, unabhängig davon, wo sie liegen.

```yaml
title:    # Thema des Chats
created:  # YYYY-MM-DD, Datum des Chats
type:     chat-protokoll
source:   # z. B. claude.ai
model:    # z. B. Claude Opus 5
tags:     # chat-protokoll + Themen-Tags
status:   # draft | active | done
```

> [!note] Englische Schlüssel seit 22.09.2026
> Frühere Protokolle trugen `date`, `quelle`, `modell` und `status: offen`; die beiden vorhandenen sind umgestellt. Zuordnung: [[Struktur-Übersicht#Chat-Protokolle (Skill chat-protokoll)]]. Vorgabe für den Skill: [[chat-protokoll – frontmatter]], Einbau: [[chat-protokoll – Skill einbinden]].

Aufbau: Zusammenfassung, Hinweise zur Vollständigkeit, Ausgangslage, Problemlösungen, Artefakte & Prompts, Entscheidungen, Nützliche Befehle & Snippets, Offene Punkte.

> [!warning] Keine Zugangsdaten
> Der Vault ist ein Git-Repository. Protokolle vor dem Ablegen auf IP-Adressen, Hostnamen, Schlüssel und Kontodaten durchsehen; der Skill ersetzt sie üblicherweise durch Platzhalter.

## Aktuell im Eingang

Nichts. Eingeordnet wurden bisher:

- [[2026-09-21 Lexikothek CD-Archivierung]] → `03-Projects/Lexikothek/`
- [[2026-09-22 Netzwerkdrucker Fedora Sway Atomic]] → `02-Tech/Linux/Fedora/`
- [[2026-09-22 Obsidian Ordner als PDF exportieren]] → `02-Tech/Obsidian/`
- [[2026-09-22 Vim Helix Spickzettel Tutorial]] → `02-Tech/Terminal/Helix/`, PDFs nach `_resources/`
