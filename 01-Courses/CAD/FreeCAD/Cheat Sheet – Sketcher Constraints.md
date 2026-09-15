# Cheat Sheet – Sketcher Constraints

> [!info]
> Übersicht aller Randbedingungen im *Sketcher* (FreeCAD 1.0, deutsche Lokalisierung). Kurs: [[M00 FreeCAD Intensivkurs – Kursstruktur]]

---

## Geometrische Constraints

Legen Beziehungen zwischen Geometrieelementen fest – ohne konkrete Maßangabe.

| Constraint | Kürzel | Menüpfad | Wirkung |
|---|---|---|---|
| Koinzidenz | `C`, `O` | `Skizze → Sketcher-Randbedingungen → Koinzidenz festlegen` | Zwei Punkte auf dieselbe Position zwingen |
| Horizontal | `C`, `H` | `Skizze → Sketcher-Randbedingungen → Horizontal festlegen` | Linie exakt waagerecht ausrichten |
| Vertikal | `C`, `V` | `Skizze → Sketcher-Randbedingungen → Vertikal festlegen` | Linie exakt senkrecht ausrichten |
| Parallel | `C`, `P` | `Skizze → Sketcher-Randbedingungen → Parallel festlegen` | Zwei Linien parallel zueinander |
| Rechtwinklig | `C`, `R` | `Skizze → Sketcher-Randbedingungen → Rechtwinklig festlegen` | Zwei Linien im 90°-Winkel |
| Tangential | `C`, `T` | `Skizze → Sketcher-Randbedingungen → Tangential festlegen` | Kurven knickfrei verbinden |
| Gleiche Länge | – | `Skizze → Sketcher-Randbedingungen → Gleiche Beschränkungen festlegen` | Zwei Linien auf gleiche Länge zwingen |
| Gleicher Radius | – | `Skizze → Sketcher-Randbedingungen → Gleiche Beschränkungen festlegen` | Zwei Kreise/Bögen auf gleichen Radius |
| Symmetrisch | `C`, `S` | `Skizze → Sketcher-Randbedingungen → Symmetrisch festlegen` | Zwei Punkte spiegelbildlich zu einer Achse |
| Punkt auf Objekt | – | `Skizze → Sketcher-Randbedingungen → Punkt auf Objekt festlegen` | Punkt liegt auf Linie, Kreis oder Bogen |
| Fixiert (Block) | `C`, `B` | `Skizze → Sketcher-Randbedingungen → Sperren` | Element vollständig fixieren (alle DOF = 0) |
| Kollinear | – | `Skizze → Sketcher-Randbedingungen → Kollinear festlegen` | Zwei Linien auf derselben Geraden |

---

## Maßliche Constraints

Legen konkrete Zahlenwerte fest und reduzieren damit Freiheitsgrade.

| Constraint | Kürzel | Menüpfad | Wirkung |
|---|---|---|---|
| Abstand | `C`, `D` | `Skizze → Sketcher-Randbedingungen → Abstand festlegen` | Länge einer Linie oder Abstand zweier Punkte |
| Horizontaler Abstand | `C`, `I` | `Skizze → Sketcher-Randbedingungen → Horizontalen Abstand festlegen` | Abstand in X-Richtung |
| Vertikaler Abstand | `C`, `J` | `Skizze → Sketcher-Randbedingungen → Vertikalen Abstand festlegen` | Abstand in Y-Richtung |
| Radius | `C`, `N` | `Skizze → Sketcher-Randbedingungen → Radius oder Gewicht festlegen` | Radius eines Kreises oder Bogens |
| Durchmesser | `C`, `N` | `Skizze → Sketcher-Randbedingungen → Radius oder Gewicht festlegen` | Durchmesser (Umschalten im Dialog) |
| Winkel | `C`, `A` | `Skizze → Sketcher-Randbedingungen → Winkel festlegen` | Winkel zwischen zwei Linien |

---

## Freiheitsgrade verstehen

| DOF | Farbe im Sketcher | Bedeutung |
|---|---|---|
| 0 | Weiß | Vollständig bestimmt – bereit für 3D-Operation |
| > 0 | Gelb | Unterbeschränkt – noch Constraints nötig |
| Konflikt | Rot | Überbeschränkt – widersprüchliche Constraints entfernen |
| – | Blau gestrichelt | Konstruktionsgeometrie (kein Beitrag zur Kontur) |

---

## Strategie: Constraints effizient setzen

> [!tip] Empfohlene Reihenfolge
> 1. **Geometrie zeichnen** – grobe Form, Maße egal
> 2. **Geometrische Constraints** setzen (Horizontal, Vertikal, Koinzidenz, Tangential …)
> 3. **Maßliche Constraints** setzen (Abstand, Radius, Winkel)
> 4. DOF-Anzeige prüfen → Ziel: **0 DOF**, alle Elemente weiß

> [!warning] Häufige Fehler
> - Constraints in falscher Reihenfolge → unnötige Überbeschränkung
> - Koinzidenz vergessen → Kontur nicht geschlossen → Pad/Pocket schlägt fehl
> - Redundante Constraints (z. B. Horizontal + fester Winkel 0°) → rot, muss gelöscht werden

---

## DOF-Beispiele

| Element | Ohne Constraints | Typische Constraints zum Fixieren |
|---|---|---|
| Punkt | 2 DOF | Position X + Position Y |
| Linie | 4 DOF | 2× Koinzidenz an Endpunkten oder Länge + Winkel + 1 Punkt |
| Kreis | 3 DOF | Mittelpunkt X + Y + Radius |
| Bogen | 5 DOF | Mittelpunkt X + Y + Radius + 2 Winkel |

---

## Querverweise

- [[Glossar FreeCAD#Constraint (Randbedingung)]]
- [[Glossar FreeCAD#Freiheitsgrad (DOF)]]
- [[Cheat Sheet – Tastenkürzel]]
- [[M03 – Sketcher Constraints]]
