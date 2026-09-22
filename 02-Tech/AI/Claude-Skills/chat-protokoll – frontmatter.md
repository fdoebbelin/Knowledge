# Frontmatter für Chat-Protokolle

Vorgabe für YAML-Frontmatter von Protokollen, die in einem Obsidian-Vault abgelegt werden. Ziel ist, dass Protokolle in denselben Abfragen und Dataview-Tabellen auftauchen wie alle anderen Notizen. Alle Schlüssel sind englisch und kleingeschrieben.

## Vorlage

```yaml
---
title: Kurzer Titel des Chats, ohne Datum
created: 2026-09-22
type: chat-protokoll
source: claude.ai
model: Claude Opus 5
tags:
  - chat-protokoll
  - thema-1
  - thema-2
status: active
---
```

Diese Reihenfolge beibehalten: `title`, `created`, `type`, `source`, `model`, `tags`, `status`.

## Schlüssel

| Schlüssel | Pflicht | Inhalt |
| --- | --- | --- |
| `title` | ja | Thema des Chats als Aussage, ohne Datum und ohne Anführungszeichen, sofern kein Doppelpunkt vorkommt. Beispiel: `Netzwerkdrucker unter Fedora Sway Atomic einbinden` |
| `created` | ja | Datum des Chats als `YYYY-MM-DD`, unquotiert. Nicht `date` verwenden. |
| `type` | ja | immer `chat-protokoll` |
| `source` | ja | Herkunft, z. B. `claude.ai`, `claude-code`, `chatgpt.com` |
| `model` | ja | verwendetes Modell im Klartext, z. B. `Claude Opus 5` |
| `tags` | ja | Liste, erster Eintrag immer `chat-protokoll`, danach 2 bis 6 Themen-Tags |
| `status` | ja | `draft`, `active` oder `done` |
| `updated` | nein | `YYYY-MM-DD`, nur wenn das Protokoll später überarbeitet wird |
| `description` | nein | ein Satz, worum es geht, falls der Titel allein zu knapp ist |
| `system` | nein | Zielsystem, wenn das Protokoll systemgebunden ist, z. B. `Fedora Sway Atomic` |
| `aliases` | nein | alternative Namen für Verweise |

Keine weiteren Schlüssel erfinden. Was nicht in die Tabelle passt, gehört in den Text.

## Werte für `status`

| Wert | Bedeutung |
| --- | --- |
| `draft` | Protokoll noch unvollständig, wird noch ergänzt |
| `active` | Protokoll fertig, es gibt aber offene Punkte |
| `done` | Protokoll fertig, nichts offen |

Faustregel: Enthält der Abschnitt „Offene Punkte" mindestens einen unerledigten Eintrag, ist der Status `active`, sonst `done`.

## Tags

- kleingeschrieben, ohne Umlaute im Tag selbst (`fedora-atomic`, nicht `Fedora Atomic`)
- Bindestrich statt Leerzeichen
- Werkzeuge und Systeme als Tag (`nushell`, `cups`, `ddrescue`), keine Verben, keine Satzfragmente
- alphabetisch sortiert nach `chat-protokoll`

## Dateiname

`YYYY-MM-TT Thema.md`, das Thema entspricht sinngemäß dem `title`. Beispiel: `2026-09-22 Netzwerkdrucker Fedora Sway Atomic.md`. Der Name muss im gesamten Vault eindeutig sein.

## Vollständiges Beispiel

```yaml
---
title: Netzwerkdrucker unter Fedora Sway Atomic einbinden
created: 2026-09-22
type: chat-protokoll
source: claude.ai
model: Claude Opus 5
tags:
  - chat-protokoll
  - cups
  - drucker
  - fedora-atomic
  - nushell
status: active
---
```

## Nicht mehr verwenden

Frühere deutsche Schlüssel und ihre Entsprechung:

| alt | neu |
| --- | --- |
| `date` | `created` |
| `quelle` | `source` |
| `modell` | `model` |
| `status: offen` | `status: active` |
| `status: erledigt` | `status: done` |
