# CLAUDE.md – RGB Color Mixer (Godot 4)

## Projektübersicht

Interaktives Farbauswahlsystem mit einem kreisförmigen RGB-Mischer.
Der Benutzer wählt Farben durch Tippen oder Ziehen (Maus/Touch) aus.
Die ausgewählte Mischfarbe färbt eine Zielfläche (ColorRect) in Echtzeit ein.

---

## Bedienkonzept: Radiales Helligkeitsmodell
```
        Grün
       /
Rot --[Schwarz-Kern]-- Blau
       \
        (Weiß-Ring außen)
```

| Zone | Radius (normiert) | Bedeutung |
|---|---|---|
| Kern | 0.0 – 0.15 | Schwarz |
| Farbring | 0.15 – 0.85 | Satte RGB-Mischfarbe |
| Außenring | 0.85 – 1.0 | Weiß |

- **Winkel** = Farbton (Rot/Grün/Blau + alle Mischungen)
- **Radius** = Helligkeit (innen=dunkel, außen=hell)
- Jeder Farbton hat seine vollständige Schwarz→Farbe→Weiß-Achse direkt erreichbar

### Interaktionstabelle

| Aktion | Ergebnis |
|---|---|
| Tap Rot-Sektor, mittlerer Ring | `#FF0000` |
| Tap Grün-Sektor, mittlerer Ring | `#00FF00` |
| Tap Blau-Sektor, mittlerer Ring | `#0000FF` |
| Ziehen Rot→Grün (gleicher Radius) | Gelb |
| Ziehen Grün→Blau | Cyan |
| Ziehen Blau→Rot | Magenta |
| Beliebige Farbe → Kern | → Schwarz |
| Beliebige Farbe → Außenring | → Weiß |
| Diagonaler Wisch Rot-innen → Grün-außen | Dunkles Rot → Helles Gelb |

### Formel
```gdscript
if brightness <= 0.5:
    final_color = Color.BLACK.lerp(hue_color, brightness * 2.0)
else:
    final_color = hue_color.lerp(Color.WHITE, (brightness - 0.5) * 2.0)
```

---

## Szenenstruktur
```
Main (Node2D)
├── ColorWheelUI (Control)
│   ├── ColorWheel (Control)       ← _draw() + Shader + _gui_input()
│   │   └── CursorIndicator (ColorRect)
│   └── ZoneLabels (Control)
├── PreviewRect (ColorRect)
├── HexLabel (Label)
└── UI (CanvasLayer)
    └── ResetButton (Button)
```

## Dateien

| Datei | Zweck |
|---|---|
| `scripts/color_math.gd` | Winkel→RGB, Radius→Helligkeit, to_color() |
| `scripts/color_wheel.gd` | Input-Handling, Signal color_changed |
| `scripts/main.gd` | Signal → PreviewRect + HexLabel |
| `shaders/color_wheel.gdshader` | HSL-Farbverlauf im Kreis |

## Kerncode: color_math.gd
```gdscript
static func angle_to_rgb_weights(angle_deg: float) -> Vector3:
    var r := max(0.0, cos(deg_to_rad(angle_deg)))
    var g := max(0.0, cos(deg_to_rad(angle_deg - 120.0)))
    var b := max(0.0, cos(deg_to_rad(angle_deg - 240.0)))
    var total := r + g + b
    if total > 0.0:
        return Vector3(r, g, b) / total
    return Vector3(1.0/3.0, 1.0/3.0, 1.0/3.0)

static func to_color(angle_deg: float, norm_dist: float) -> Color:
    var w := angle_to_rgb_weights(angle_deg)
    var hue := Color(w.x, w.y, w.z)
    var b := clamp(norm_dist, 0.0, 1.0)
    if b <= 0.5:
        return Color.BLACK.lerp(hue, b * 2.0)
    else:
        return hue.lerp(Color.WHITE, (b - 0.5) * 2.0)
```

## TODO (Reihenfolge für Claude Code)

- [ ] 1. color_math.gd implementieren
- [ ] 2. color_wheel.gdshader (HSL-Kreis)
- [ ] 3. color_wheel.gd mit _gui_input + Signal
- [ ] 4. main.tscn: PreviewRect + HexLabel verbinden
- [ ] 5. CursorIndicator (folgt Maus, zeigt Farbe)
- [ ] 6. ResetButton
- [ ] 7. Touch-Support

## Godot 4 Regeln

- Strikt typisiert, @export, signal mit Typen
- Keine Godot 3 Syntax (kein yield, kein connect mit String-Methoden)
- Nach Szenen-Generierung: `godot --headless --import`
- Syntax-Check: `godot --headless --check-only --script scripts/color_math.gd`
- Git-Commit nach jeder TODO-Stufe