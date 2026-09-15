---
title: Struktur-Übersicht
aliases:
  - README
  - Vault-Übersicht
tags:
  - meta
created: 2026-09-15
updated: 2026-09-15
---

# Knowledge Vault – Struktur-Übersicht

Stand: 15. September 2026, nach der Reorganisation (Phasen 1–3). Rund 1.340 Notizen in fünf Bereichen. Persönliches, Geschäftliches und Zugangsdaten liegen im separaten Vault **Personal**.

## Grundregeln

- **Ein Thema, ein Ort.** Ein Werkzeug (Helix, JupyterLab, WSL …) hat genau einen Ordner. Kursmaterial dazu bleibt beim Kurs, Referenznotizen liegen unter 02-Tech.
- **Kurse vs. Referenz.** `01-Courses` enthält Lehrmaterial mit Modulstruktur (M01 …, K0 …, Block-01 …). Alles, was Nachschlagewissen ist, gehört nach `02-Tech` oder `04-Languages`.
- **Projekte** haben eigene Ordner unter `03-Projects`; projektbezogene Recherchen und Clippings liegen dort, nicht in den Notizen.
- **Anhänge** liegen im `_resources`-Ordner neben der Notiz (Obsidian-Einstellung). Ein Unterordner bleibt nur bestehen, wenn er mehr als eine Handvoll Notizen hat.
- **Keine Zugangsdaten, Schlüssel oder Kontodaten** in diesem Vault; der Vault ist ein Git-Repository.
- **Dateinamen** sind eindeutig im gesamten Vault (Wikilinks lösen über den Namen auf). Keine „Unbenannt“, keine „(1)“-Kopien, keine „alt“-Versionen neben der aktuellen; Altes wandert nach `05-Notes/Archive`.

## Ordnerstruktur

```
Knowledge/
├── 01-Courses/            Lehrmaterial mit Modulstruktur (704)
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
├── 02-Tech/               Technische Referenz, nach Themen (301)
│   ├── AI/                Aider, Claude-Code, Foundry Local, LM-Studio, Ollama,
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
├── 03-Projects/           Eigene Projekte (101)
│   ├── Agrail, AtomicLinux, BlockPy, BookScanner, Godot, JuliDESK,
│   ├── MetaRow-Player, o++o-Interpreter, Py2Rust
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
| Neuer Kurs oder neues Kursmodul | `01-Courses/<Bereich>/<Kursname>/` |
| Anleitung zu einem Werkzeug oder System | `02-Tech/<Thema>/` (vorhandenen Ordner nutzen) |
| Neues Projekt | `03-Projects/<Name>/` |
| Sprachreferenz, Idiome, Arbeitsblatt | `04-Languages/<Sprache>/` |
| Web-Clipping, noch nicht eingeordnet | `05-Notes/Clippings/` – monatlich einsortieren |
| Abgelöste Version einer Notiz | `05-Notes/Archive/` mit Datum im Namen |
| Rezepte, Gesundheit, UG, Zugangsdaten | Vault **Personal** |

## Frontmatter-Konvention

Nur für Notizen, die es brauchen (Leitfäden, Kursbausteine, Clippings). Schlüssel auf Englisch:

```yaml
title:        # Anzeigename
aliases:      # alternative Namen für Wikilinks
tags:         # Liste, kleingeschrieben
created:      # YYYY-MM-DD
updated:      # YYYY-MM-DD
source:       # URL oder Herkunft bei Clippings
status:       # draft | active | done | archived
```

Kursbausteine nutzen zusätzlich `modul`, `baustein`, `kurstag`, `ue`, `typ`, `ort`, `phase`. Leitfäden zu Geräten nutzen `system` und `teil_von`. Der Schlüssel `tag` (Singular) ist reserviert für Obsidian-Tags und wird nicht als Kurstag verwendet.

## Wartung

- Monatlich: `05-Notes/Clippings` durchsehen und einordnen oder löschen.
- Quartalsweise: Ordner mit nur einer Notiz prüfen (aktuell `02-Tech/macOS`, `03-Projects/BookScanner`) und ggf. auflösen.
- Bekannte offene Punkte (Stand 2026-09-15):
  - 29 kaputte Links, vor allem eine nie angelegte `docs/`-Reihe in den XPS-13-Notizen und externe Bildpfade in JavaScript-STEM.
  - 16 verwaiste Bilder in der Root-`_resources`.
  - `04-Languages/Python/Buch` enthält vier Fassungen von „Kapitel 19“, bewusst als Entwürfe belassen.
  - Zugangsdaten stecken noch in der Git-Historie vor Commit `245d60a`; Schlüssel wurden nicht rotiert.

## Historie der Reorganisation

- **2026-02-11** Migration aus Vault „Research“ per Skript (siehe `05-Notes/Archive/README-Migration (2026-02)`).
- **2026-09-15 Phase 1** (`245d60a`): Dubletten, leere Dateien, Secrets, Root-Dateien, FreeCAD-Iconset.
- **2026-09-15 Phase 2** (`dea4de0`): fünf Bereiche, 04-Software und Important aufgelöst, 1.151 Dateien verschoben.
- **2026-09-15 Phase 3**: Fast-Dubletten zusammengeführt (SDDM, bootc, Drupal Paragraphs, Sprachmaschinen, IOPaint, aider, Geschichte der Informatik, Python-Buch), Frontmatter vereinheitlicht, diese Übersicht.
