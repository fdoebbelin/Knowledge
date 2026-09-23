---
title: Struktur-Übersicht
aliases:
  - README
  - Vault-Übersicht
tags:
  - meta
created: 2026-09-15
updated: 2026-09-23
---

# Knowledge Vault – Struktur-Übersicht

Stand: 23. September 2026. Rund 1.360 Notizen in fünf Bereichen, dazu der Eingang `00-Inbox`. Persönliches, Geschäftliches und Zugangsdaten liegen im separaten Vault **Personal**.

## Grundregeln

- **Ein Thema, ein Ort.** Ein Werkzeug (Helix, JupyterLab, WSL …) hat genau einen Ordner. Kursmaterial dazu bleibt beim Kurs, Referenznotizen liegen unter 02-Tech.
- **Kurse vs. Referenz.** `01-Courses` enthält Lehrmaterial mit Modulstruktur (M01 …, K0 …, Block-01 …). Alles, was Nachschlagewissen ist, gehört nach `02-Tech` oder `04-Languages`.
- **Projekte** haben eigene Ordner unter `03-Projects`; projektbezogene Recherchen und Clippings liegen dort, nicht in den Notizen.
- **Anhänge** liegen im `_resources`-Ordner neben der Notiz (Obsidian-Einstellung). Ein Unterordner bleibt nur bestehen, wenn er mehr als eine Handvoll Notizen hat.
- **Keine Zugangsdaten, Schlüssel oder Kontodaten** in diesem Vault; der Vault ist ein Git-Repository.
- **Eingang.** Neues, das noch einzuordnen ist, liegt in `00-Inbox` und wird von dort mit Claude Code einsortiert, siehe [[Eingang]]. Der Ordner bleibt leer, wenn nichts offen ist.
- **Dateinamen** sind eindeutig im gesamten Vault (Wikilinks lösen über den Namen auf). Keine „Unbenannt“, keine „(1)“-Kopien, keine „alt“-Versionen neben der aktuellen; Altes wandert nach `05-Notes/Archive`.

## Ordnerstruktur

```
Knowledge/
├── 00-Inbox/              Eingang: noch nicht eingeordnete Dokumente (0)
│
├── 01-Courses/            Lehrmaterial mit Modulstruktur (702)
│   ├── AI/                KI-Agenten-Workshop
│   ├── Business/          Office-Basics, Office-Short, Project-Management, UML-Basics
│   ├── CAD/               FreeCAD-Intensivkurs, Civil 3D
│   ├── Databases/         Database-Intro, SQL-Course, SQL-Tools
│   ├── Programming/       Python-Basics (M01–M20), Python-OOP (M21–M40),
│   │                      Programming-Basics, CS-Basics, JavaScript-STEM,
│   │                      Tauri-Kurs, Tauri-Kompaktkurs, PythonAugmentedDevelopment
│   ├── STEM/              MINT-Einführungskurs (Informatik, Physik/p5.js, CAD)
│   └── Training/          BFD-Programs, IT-Career, Military
│
├── 02-Tech/               Technische Referenz, nach Themen (320)
│   ├── AI/                Aider, Claude-Code, Claude-Skills, Foundry Local, LM-Studio, Ollama,
│   │                      OpenClaw, IOPaint, LLM-Basics (Modelle, Hardware, Grundlagen)
│   ├── Git/
│   ├── Hardware/          AI-Workstation, Lenovo Yoga 920, Dell XPS 13 9345, Arduino
│   ├── Linux/             Fedora (Hyprland, Noctalia, bootc-nah), Wine, Allgemeines
│   ├── macOS/
│   ├── Obsidian/
│   ├── PDF-Tools/
│   ├── Python-Tooling/    JupyterLab, uv, Pixi, PyCharm, Conda
│   ├── Terminal/          Nushell (mit nu-scripts), Helix, Zellij, Yazi
│   ├── Virtualization/    Docker, Podman, KVM-QEMU, Incus, Marktüberblick
│   ├── Web/               Drupal, Flask, Grav CMS, NextCloud, Opigno, Hosting
│   ├── Windows/           PowerShell, Scoop, RDP, Systemeinstellungen
│   └── WSL/               WSL-Distributionen, XPS-13-Reihe (Sway/Noctalia unter WSLg)
│
├── 03-Projects/           Eigene Projekte (103)
│   ├── Agrail, AtomicLinux, BlockPy, BookScanner, Godot, JuliDESK,
│   ├── Lexikothek (CD-Archivierung), MetaRow-Player, o++o-Interpreter, Py2Rust
│   └── Python-Projects/   Kursprojekte, Mastermind, Ladder, Sokoban
│
├── 04-Languages/          Sprachreferenz (109)
│   ├── OCaml/
│   ├── Python/            Referenz, Arbeitsblätter, Buch (Notebook-Entwürfe)
│   └── Rust/              Dioxus, SurrealDB, Tauri, Rustlings, Playground, Windsurf
│
└── 05-Notes/              (122)
    ├── Archive/           Projektmanagement alt (ProjeQtOr), Python-Grundkurs alt (5D),
    │                      Migrationsdokumente 2026-02, abgelöste Leitfäden
    └── Clippings/         Unsortierte Artikel (Eingang), Clippings/AI
```

## Wo kommt Neues hin?

| Was | Wohin |
|---|---|
| Noch nicht eingeordnet, soll mit Claude Code sortiert werden | `00-Inbox/` – siehe [[Eingang]] |
| Chat-Protokoll (Skill `chat-protokoll`) | nach Thema, wie jede andere Notiz; Tag `chat-protokoll` macht sie auffindbar |
| Neuer Kurs oder neues Kursmodul | `01-Courses/<Bereich>/<Kursname>/` |
| Anleitung zu einem Werkzeug oder System | `02-Tech/<Thema>/` (vorhandenen Ordner nutzen) |
| Neues Projekt | `03-Projects/<Name>/` |
| Sprachreferenz, Idiome, Arbeitsblatt | `04-Languages/<Sprache>/` |
| Web-Clipping, noch nicht eingeordnet | `05-Notes/Clippings/` – monatlich einsortieren |
| Abgelöste Version einer Notiz | `05-Notes/Archive/` mit Datum im Namen |
| Rezepte, Gesundheit, UG, Zugangsdaten | Vault **Personal** |

## Frontmatter-Konvention

Nur für Notizen, die es brauchen (Leitfäden, Kursbausteine, Clippings, Protokolle). Schlüssel auf Englisch. Zahlen in Klammern: Verwendungen im Vault am 22.09.2026 (220 von 1.349 Notizen haben überhaupt Frontmatter).

### Allgemein

| Schlüssel | Verw. | Inhalt |
| --- | --- | --- |
| `title` | 212 | Anzeigename |
| `tags` | 207 | Liste, kleingeschrieben |
| `created` | 136 | YYYY-MM-DD |
| `status` | 89 | `draft` (65) \| `active` (19) \| `done` (5) \| `archived` (0) |
| `source` | 73 | URL oder Herkunft (Clippings, Chats) |
| `author` | 69 | Verfasser, bei Clippings der Originalautor |
| `published` | 68 | Veröffentlichungsdatum der Quelle |
| `description` | 68 | ein Satz, worum es geht |
| `aliases` | 56 | alternative Namen für Wikilinks |
| `system` | 28 | Zielsystem, z. B. `Fedora Sway Atomic` |
| `updated` | 22 | YYYY-MM-DD, nur bei gepflegten Notizen |
| `type` | 10 | Notiztyp: `anleitung`, `leitfaden`, `runbook`, `referenz`, `chat-protokoll` |

### Fachspezifisch

- **Kursbausteine:** `modul`, `baustein`, `kurstag`, `ue`, `typ`, `phase`, `ort`, `dauer`, `zielgruppe` – deutsche Schlüssel, gewachsen mit dem Kursmaterial.
- **Geräte- und Systemleitfäden:** `system`, `teil_von`, `zielgeraet`, `shell`, `verifiziert_gegen`.
- **Werkzeugleitfäden:** Versionsschlüssel wie `yazi_version`.
- Der Schlüssel `tag` (Singular) ist für Obsidian-Tags reserviert und wird nicht als Kurstag verwendet.

### Chat-Protokolle (Skill chat-protokoll)

Zielbild mit englischen Schlüsseln, damit Protokolle in denselben Abfragen auftauchen wie der Rest:

```yaml
title:        # Thema des Chats
created:      # YYYY-MM-DD, Datum des Chats
type:         chat-protokoll
source:       # z. B. claude.ai
model:        # z. B. Claude Opus 5
tags:         # chat-protokoll + Themen-Tags
status:       # draft | active | done
```

Die beiden vorhandenen Protokolle sind am 22.09.2026 umgestellt worden. Vorgabe für den Skill: [[chat-protokoll – frontmatter]], Einbau in den Skill: [[chat-protokoll – Skill einbinden]].

| vorher (deutsch) | jetzt (englisch) | Begründung |
| --- | --- | --- |
| `date` | `created` | `created` ist der etablierte Datums-Schlüssel (136×), `date` kommt nur vereinzelt vor |
| `quelle` | `source` | bereits 73× im Vault für Herkunft |
| `modell` | `model` | englische Entsprechung, bisher kein Schlüssel dafür vorhanden |
| `status: offen` | `status: active` | offene Punkte sind noch in Arbeit |
| `status: erledigt` | `status: done` | abgeschlossen |

### Bedeutung der `status`-Werte

| Wert | Bedeutung |
| --- | --- |
| `draft` | Entwurf, noch nicht belastbar |
| `active` | in Gebrauch und gepflegt |
| `done` | abgeschlossen, keine Pflege vorgesehen |
| `archived` | überholt, liegt in `05-Notes/Archive` |

> [!info] Vereinheitlicht am 22.09.2026
> Zuvor standen dort deutsche Werte (`entwurf` 53×, `aktiv` 6×, `fertig`, `erledigt`, `konsolidiert`, `verifiziert` …). 78 Notizen wurden umgestellt. Wo im `status` der Notiztyp stand (`anleitung`, `Leitfaden`, `Setup-Guide`, `Referenz`, `Leitfaden + Demo-Runbook`), steht er jetzt in `type`, der Status ist `active`. Prüfangaben blieben in `verifiziert_am` und `verifiziert_gegen` erhalten.

## Wartung

- Laufend: `00-Inbox` leeren; der Ordner ist keine Ablage.
- Monatlich: `05-Notes/Clippings` durchsehen und einordnen oder löschen.
- Quartalsweise: Ordner mit nur einer Notiz prüfen (aktuell `02-Tech/macOS`, `03-Projects/BookScanner`) und ggf. auflösen.
- Bekannte offene Punkte (Stand 2026-09-15):
  - 29 kaputte Links, vor allem eine nie angelegte `docs/`-Reihe in den XPS-13-Notizen und externe Bildpfade in JavaScript-STEM.
  - 16 verwaiste Bilder in der Root-`_resources`.
  - `04-Languages/Python/Buch` enthält vier Fassungen von „Kapitel 19“, bewusst als Entwürfe belassen.
  - Git-Historie am 2026-09-15 mit git filter-repo bereinigt (Commit-IDs seitdem: Phase 1 `dfa3938`, Phase 2 `f39369b`, Phase 3 `63e61ab`); Schlüssel wurden noch nicht rotiert.

## Historie der Reorganisation

- **2026-02-11** Migration aus Vault „Research“ per Skript (siehe `05-Notes/Archive/README-Migration (2026-02)`).
- **2026-09-15 Phase 1** (`dfa3938`): Dubletten, leere Dateien, Secrets, Root-Dateien, FreeCAD-Iconset.
- **2026-09-15 Phase 2** (`f39369b`): fünf Bereiche, 04-Software und Important aufgelöst, 1.151 Dateien verschoben.
- **2026-09-22**: Eingang `00-Inbox` eingeführt; erste zwei Chat-Protokolle eingeordnet (Lexikothek → `03-Projects/Lexikothek`, Netzwerkdrucker → `02-Tech/Linux/Fedora`); sieben Stichwortnotizen für offene Verweise angelegt; Frontmatter vereinheitlicht: englische Schlüssel in den Protokollen, `status` in 78 Notizen auf `draft`/`active`/`done` umgestellt.
- **2026-09-23**: Helix-Spickzettel um editierbare SVG/PDF-Quelldateien und Schriften ergänzt, dazu Inkscape-Anleitung eingeordnet (`02-Tech/Terminal/Helix/`). Yazi-Spickzettel von HTML- auf SVG-Erzeugung umgestellt (neue PDF + zwei SVG-Seiten), `Yazi-Leitfaden.md` analog zu `Helix-Leitfaden.md` neu angelegt.
- **2026-09-15 Phase 3**: Fast-Dubletten zusammengeführt (SDDM, bootc, Drupal Paragraphs, Sprachmaschinen, IOPaint, aider, Geschichte der Informatik, Python-Buch), Frontmatter vereinheitlicht, diese Übersicht.
