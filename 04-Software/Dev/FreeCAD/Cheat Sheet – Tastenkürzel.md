# Cheat Sheet – Tastenkürzel

> [!info]
> Schnellreferenz aller relevanten Shortcuts in FreeCAD 1.0 (deutsche Lokalisierung). Kurse: [[M00 FreeCAD Intensivkurs – Kursstruktur]] · [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]

---

## Allgemein

| Kürzel | Aktion |
|---|---|
| `Strg+N` | Neues Dokument |
| `Strg+O` | Dokument öffnen |
| `Strg+S` | Speichern |
| `Strg+Shift+S` | Speichern unter |
| `Strg+Z` | Rückgängig |
| `Strg+Y` | Wiederholen |
| `Strg+Q` | FreeCAD beenden |
| `Leertaste` | Sichtbarkeit ein/aus (ausgewähltes Objekt) |
| `Strg+G` | Objekte gruppieren |

---

## 3D-Navigation & Ansicht

| Kürzel | Aktion |
|---|---|
| `Num 0` | Kameraansicht |
| `Num 1` | Vorderansicht |
| `Num 2` | Ansicht nach unten kippen |
| `Num 3` | Rechte Seitenansicht |
| `Num 4` | Ansicht nach links drehen |
| `Num 5` | Perspektive / Orthogonal umschalten |
| `Num 6` | Ansicht nach rechts drehen |
| `Num 7` | Draufsicht |
| `Num 8` | Ansicht nach oben kippen |
| `Num 9` | Rückansicht |
| `V`, `F` | Ansicht auf Auswahl einpassen |
| `V`, `A` | Alle Objekte einpassen |
| `V`, `H` | Ansicht auf Heim-Position |

### Maussteuerung (Standard-Navigation)

| Aktion | Maus |
|---|---|
| Drehen | Mitteltaste gedrückt + Bewegen |
| Zoomen | Scrollrad |
| Verschieben | Mitteltaste + Rechtstaste gedrückt + Bewegen |
| Objekt auswählen | Linksklick |
| Mehrfachauswahl | `Strg` + Linksklick |

---

## Modellbaum & Auswahl

| Kürzel | Aktion |
|---|---|
| `Strg+A` | Alles auswählen |
| `Entf` | Ausgewähltes Objekt löschen |
| `Leertaste` | Sichtbarkeit des Objekts umschalten |

---

## Sketcher

| Kürzel | Aktion |
|---|---|
| `G`, `L` | Linie zeichnen |
| `G`, `R` | Rechteck zeichnen |
| `G`, `C` | Kreis zeichnen |
| `G`, `A` | Bogen zeichnen |
| `G`, `P` | Punkt setzen |
| `G`, `O` | Polygon zeichnen |
| `Q` | Constraint-Wert ändern (maßliche Randbedingung) |
| `Esc` | Aktuelles Werkzeug beenden |
| `Strg+Z` | Letzten Schritt rückgängig |

### Constraints im Sketcher

| Kürzel | Constraint |
|---|---|
| `C`, `O` | Koinzidenz (Coincident) |
| `C`, `H` | Horizontal |
| `C`, `V` | Vertikal |
| `C`, `P` | Parallel |
| `C`, `R` | Rechtwinklig (Perpendicular) |
| `C`, `T` | Tangential |
| `C`, `S` | Symmetrisch |
| `C`, `B` | Fixiert (Block) |
| `C`, `D` | Abstand (Distance) |
| `C`, `I` | Horizontaler Abstand |
| `C`, `J` | Vertikaler Abstand |
| `C`, `A` | Winkel (Angle) |
| `C`, `N` | Radius / Durchmesser |

> [!tip]
> Shortcuts im Sketcher sind zweiteilig: erst `G` (Geometry) oder `C` (Constraint), dann der Buchstabe. Kurz nacheinander drücken, nicht gleichzeitig.

---

## Part Design

| Kürzel | Aktion |
|---|---|
| `P` | Aufmaß (Pad) |
| `Q` | Tasche (Pocket) |

> [!info]
> Part Design hat deutlich weniger Tastenkürzel als der Sketcher – die meisten Operationen werden über das Menü `Part Design → …` aufgerufen.

---

## TechDraw

| Kürzel | Aktion |
|---|---|
| *keine Standard-Shortcuts* | Operationen über `TechDraw → …` |

---

## BIM & Draft

> [!info]
> Diese Shortcuts gelten im Kontext des [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]. *BIM*- und *Draft*-Workbench teilen sich das Fang- und Arbeitsebenen-System.

### Arbeitsebene & Projekt

| Kürzel | Aktion |
|---|---|
| `W` | Arbeitsebene auswählen |
| `9` | Arbeitsebene auswählen (alternativ, Draft) |
| `Strg+G` | Objekte gruppieren (z. B. Ebene befüllen) |

> [!warning]
> `W` und `9` öffnen beide den Arbeitsebenen-Dialog – je nach aktiver Workbench kann einer der beiden nicht reagieren. Im Zweifel beide probieren.

### Fang-System (Snap)

| Kürzel | Aktion |
|---|---|
| `S` | Fang ein/aus |
| `Strg` (gehalten) | Fang temporär deaktivieren während Zeichnen |

> [!tip]
> Das Fang-System ist der wichtigste Präzisionshelfer in *Draft* und *BIM*. Standardmäßig eingeschaltet lassen und nur mit `Strg` kurzzeitig deaktivieren, wenn ein Freihandpunkt benötigt wird.

---

## Querverweise

- [[Glossar FreeCAD]]
- [[Cheat Sheet – Sketcher Constraints]]
- [[M00 FreeCAD Intensivkurs – Kursstruktur]]
- [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]
