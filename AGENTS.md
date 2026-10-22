---
title: AGENTS
tags:
  - meta
created: 2026-10-22
status: active
---

# Knowledge-Vault – Projektregeln für KI-Agenten

Dieses Repository ist die öffentliche Wissensbasis `fdoebbelin/Knowledge` (Obsidian-Vault) mit rund 1.380 Notizen zu Linux, Softwareentwicklung, Virtualisierung und Kursmaterial. OpenCode liest diese Datei bei jedem Sitzungsstart automatisch – hier stehen die Regeln, die beim Bearbeiten immer gelten.

> [!info] Verhält zu Claude Code
> OpenCode V2 erkennt **nur `AGENTS.md`**, nicht `CLAUDE.md`. Wer wieder mit Claude Code arbeitet, braucht zusätzlich eine `CLAUDE.md` (z. B. per `/init`) – oder symmetrisch eine `AGENTS.md` mit dem Inhalt von `CLAUDE.md`.

Die vollständige Übersicht mit Zählern, Frontmatter-Tabelle und Historie steht in [[Struktur-Übersicht]]. Diese Datei fasst nur die Regeln zusammen, nicht das Bild.

## Arbeitsweise

1. **Erst lesen, dann schreiben.** Vor dem Anlegen oder Ändern einer Notiz `Struktur-Übersicht.md`, `00-Inbox/Eingang.md` und die Nachbarnotizen des Zielordners lesen.
2. **Nichts erfinden.** Fehlt eine Notiz, auf die verwiesen werden soll, lieber eine Stichwortnotiz anlegen oder den Verweis weglassen – keine Links ins Leere.
3. **Nicht löschen.** Dateien nur mit ausdrücklicher Freigabe entfernen. Abgelöste Fassungen wandern nach `05-Notes/Archive`, nicht in den Papierkorb.
4. **Kleine Schritte.** Nach jedem logischen Schritt `git status` und `git diff` prüfen, nicht alles auf einmal umbauen.
5. **Nachfragen statt raten.** Unklare Zielordner, Dateinamen oder Frontmatter-Konflikte klären, bevor geschrieben wird.

## Ordnerlogik

| Ordner | Inhalt |
|---|---|
| `00-Inbox` | Eingang: noch nicht eingeordnete Dokumente. Keine Dauerablage. |
| `01-Courses` | Kurs- und Schulungsmaterial mit Modulstruktur (M01 …, K0 …, Block-01 …) |
| `02-Tech` | Technische Referenz, Anleitungen, Runbooks – nach Themen |
| `03-Projects` | Eigene Projekte, je ein Ordner pro Projekt |
| `04-Languages` | Sprachreferenz (OCaml, Python, Rust) |
| `05-Notes` | Allgemeine Notizen, `Clippings/`, `Archive/` |
| `_resources` | Anhänge: Bilder, PDF, Skripte |

- **Ein Thema, ein Ort.** Ein Werkzeug (Helix, Yazi, KVM-QEMU …) hat genau einen Ordner unter `02-Tech/<Thema>/`. Kursmaterial dazu bleibt beim Kurs, Referenznotizen unter `02-Tech`.
- **Kurs vs. Referenz.** `01-Courses` enthält Lehrmaterial mit Modulstruktur. Alles Nachschlagewissen gehört nach `02-Tech` oder `04-Languages`.
- **Projektbezogenes** – Recherchen und Clippings zu einem Projekt – liegt in `03-Projects/<Name>/`, nicht in den Notizen.
- **Anhänge** liegen in `_resources` neben der Notiz. Ein Unterordner bleibt nur bestehen, wenn er mehr als eine Handvoll Notizen hat.
- **Nummernpräfix `nn-`**, wenn ein Ordner eine sinnvolle Lesereihenfolge hat (Beispiel `02-Tech/Terminal/Helix/01-…` bis `03-…`). Der frühere Name bleibt als `aliases`-Eintrag, damit ältere Verweise weiter aufgehen.
- **Dateinamen sind vault-weit eindeutig.** Keine „Unbenannt“, keine „(1)“-Kopien, keine „alt“-Version neben der aktuellen.

## Frontmatter

Nur für Notizen, die es brauchen (Leitfäden, Kursbausteine, Clippings, Protokolle). Schlüssel auf Englisch, kleingeschrieben, keine erfundenen Schlüssel.

```yaml
---
title: Kurzer Titel
tags:
  - thema
created: 2026-10-22
status: active
---
```

| Schlüssel | Inhalt |
| --- | --- |
| `title` | Anzeigename |
| `tags` | Liste, kleingeschrieben |
| `created` | YYYY-MM-DD |
| `updated` | YYYY-MM-DD, nur bei gepflegten Notizen |
| `status` | `draft` \| `active` \| `done` \| `archived` |
| `type` | `anleitung` \| `leitfaden` \| `runbook` \| `referenz` \| `chat-protokoll` |
| `description` | ein Satz, worum es geht |
| `source` | URL oder Herkunft (Clippings, Protokolle) |
| `author`, `published` | bei Clippings der Originalautor und das Veröffentlichungsdatum |
| `aliases` | alternative Namen für Wikilinks |
| `system` | Zielsystem, z. B. `Fedora Sway Atomic` |

- Deutsche `status`-Werte sind umgestellt – `draft`, `active`, `done`, `archived` verwenden.
- `tag` (Singular) ist für Obsidian-Tags reserviert und wird nicht als Kurstag verwendet.
- Fachspezifische Schlüssel stehen in [[Struktur-Übersicht#Frontmatter-Konvention]].

## Wikilinks

- `[[Notizname]]` löst über den **Dateinamen** auf – deshalb müssen Dateinamen vault-weit eindeutig sein.
- Mit Alias: `[[02-Legacy-zu-UEFI bei Fedora Atomic|Schritt 3]]`.
- Mit Anker: `[[Struktur-Übersicht#Frontmatter-Konvention]]`.
- Nur auf Notizen verweisen, die existieren oder im selben Zug angelegt werden. **Keine Links ins Leere.**
- Anhänge als `![[Schritt-3-ESP-anlegen.pdf]]` einbinden.

## Keine Geheimnisse

**Keine Zugangsdaten, Schlüssel, Kontodaten, IP-Adressen, Hostnamen oder Seriennummern** in diesem Vault – er ist ein öffentliches Git-Repository. Vor dem Ablegen prüfen, durch Platzhalter ersetzen und die Ersetzung im Chat-Protokoll unter „Hinweise zur Vollständigkeit“ vermerken.

## Einordnen aus der Inbox

Ablauf in vier Schritten:

1. **Ablegen** – Datei nach `00-Inbox/`. Chat-Protokolle heißen `JJJJ-MM-TT Thema.md`.
2. **Einordnen** – Zielordner, Dateiname, Frontmatter und Verweise auf vorhandene Notizen klären.
3. **Verschieben** – mit `git mv`, damit die Historie erhalten bleibt.
4. **Verlinken** – Ziel-Ordner und verwandte Notizen gegenseitig verbinden; bei neuen Ordnern `Struktur-Übersicht.md` ergänzen; `00-Inbox/Eingang.md` unter „Aktuell im Eingang“ nachtragen.

Danach alle geänderten Notizen auf Wikilinks und Anker prüfen.

## Git

- Eine logische Änderung = ein Commit. Nachricht auf Deutsch, mit Bezug zum Thema, z. B. `UEFI-Boot: Runbook aus Chat-Protokoll verdichtet`.
- Vor dem Commit `git status` und `git diff` ansehen.
- `git push` erst nach ausdrücklicher Freigabe.
- Nach größeren Arbeiten `HANDOFF.md` aktualisieren – Gliederung siehe dort.

## Chat-Protokolle

Protokolle tragen `type: chat-protokoll` und den Tag `chat-protokoll`, damit sie vault-weit auffindbar sind. Aufbau und Frontmatter-Vorgabe: [[chat-protokoll – frontmatter]] und [[chat-protokoll – Skill einbinden]].

## Weiterführende Dateien

- `Struktur-Übersicht.md` – Aufbau, Frontmatter-Tabelle, Historie
- `00-Inbox/Eingang.md` – Eingangsablauf im Detail
- `HANDOFF.md` – Übergabe zwischen Sitzungen
- [[00 OpenCode]] – das Werkzeug, das diese Regeln ausführt
