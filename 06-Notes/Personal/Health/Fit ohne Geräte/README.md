# Workout Video Generator

Erzeugt MP4-Videos direkt aus Obsidian-Markdown-Dateien.
Kein JSON, kein separater Player – die Markdown-Dateien sind die einzige Datenquelle.

---

## Installation

```bash
uv init --name fog --no-package .
uv venv
uv pip install moviepy pillow python-frontmatter
```

---

## Vault-Struktur

```
Vault/
├── Zirkel 1.md                  ← Sequenz-Definition
├── Zirkel 2.md
├── Y-Handschellen.md            ← Übungs-Datei
├── Kniender Ausfallschritt.md
└── _resources/
    ├── 000204.jpg
    └── 000203.jpg
```

---

## Verwendung

```bash
# Einzelner Zirkel → Zirkel 1.mp4
python workout_video.py "Zirkel 1.md"

# Mehrere Zirkel zu einer Session
python workout_video.py "Zirkel 1.md" "Zirkel 3.md" --output montag.mp4

# Vault-Pfad explizit (wenn Script woanders liegt)
python workout_video.py "Zirkel 1.md" --vault ~/Obsidian/Workout

# Schneller Test-Render
python workout_video.py "Zirkel 1.md" --preset ultrafast
```

| Option | Standard | Bedeutung |
|---|---|---|
| `--output` | `<zirkel>.mp4` | Ausgabedatei |
| `--vault` | Ordner der MD-Datei | Wo liegen Übungs-Dateien und Bilder? |
| `--fps` | `30` | Frames pro Sekunde |
| `--preset` | `fast` | ffmpeg-Preset |

---

## Dateiformat

### Zirkel-Datei (`Zirkel 1.md`)

```yaml
---
title: "Zirkel 1"
rounds: 3
training_duration: 40
rest_duration: 20
sequenz:
  - uebung: "Y-Handschellen"     # → lädt Y-Handschellen.md
    seite: ~                      # ~ = beidseitig
  - uebung: "Kniender Ausfallschritt"
    seite: links
  - uebung: "Kniender Ausfallschritt"
    seite: rechts
---
```

- `rounds` wiederholt die gesamte Sequenz
- `seite` wird an den Titel angehängt (z. B. „Kniender Ausfallschritt (links)")
- `training_duration`/`rest_duration` können pro Eintrag überschrieben werden

### Übungs-Datei (`Y-Handschellen.md`)

```yaml
---
title: "Y-Handschellen"
typ: bilateral
fokus: ["Schultern", "Brustwirbelsäule"]
muskeln: ["Trapezius", "Rhomboiden"]
image: "_resources/000204.jpg"
---
```

Das Script sucht Bilder automatisch in:
1. Pfad relativ zur MD-Datei
2. `_resources/`-Unterordner
3. Vault-Wurzelverzeichnis

---

## Video-Layout

```
┌──────────────────────────────────────────┐
│                                          │
│            Übungsbild                    │
│                                          │
│  Titel                                   │  ← immer sichtbar
│  Fokus · Muskeln                         │  ← blendet nach 3s aus
├══════════════════════════════════════════╡
│████████████████░░░░░░░░░░░░░░░░░░░░░░░░░░│  ← Fortschrittsbalken
└──────────────────────────────────────────┘
  orange = Übung  ·  gelb = Pause
```
