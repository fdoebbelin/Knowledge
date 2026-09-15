# Sketcher – Symbolleistenreferenz

> [!info] Über dieses Dokument
> Referenz aller Symbolleistenbefehle der *Sketcher*-Workbench (FreeCAD 1.0, deutsche Lokalisierung).
> SVG-Dateien in den Obsidian-Vault-Ordner `_assets/icons/` legen.
> Kurs: [[M00 FreeCAD Intensivkurs – Kursstruktur]]

---

## Skizze verwalten

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Sketcher_NewSketch.svg]] | Skizze erstellen | `Skizze → Skizze erstellen` | Neue 2D-Skizze auf einer Bezugsebene oder Körperfläche anlegen |
| ![[Sketcher_MapSketch.svg]] | Skizze anhängen | `Skizze → Skizze anhängen` | Bestehende Skizze einer anderen Fläche oder Ebene zuweisen |
| ![[Sketcher_ReorientSketch.svg]] | Skizze neu ausrichten | `Skizze → Skizze neu ausrichten` | Bezugsebene einer vorhandenen Skizze ändern |
| ![[Sketcher_ValidateSketch.svg]] | Skizze überprüfen | `Skizze → Skizze überprüfen` | Skizze auf fehlende Koinzidenzen und Fehler prüfen |
| ![[Sketcher_MergeSketch.svg]] | Skizzen zusammenführen | `Skizze → Skizzen zusammenführen` | Zwei Skizzen zu einer vereinen |
| ![[Sketcher_MirrorSketch.svg]] | Skizze spiegeln | `Skizze → Skizze spiegeln` | Gesamte Skizze an einer Achse spiegeln |

---

## Geometrie zeichnen

### Punkte & Linien

| Symbol | Name | Kürzel | Menüpfad | Beschreibung |
|---|---|---|---|---|
| ![[Sketcher_CreatePoint.svg]] | Punkt erstellen | `G`, `P` | `Skizze → Sketcher-Geometrien → Punkt erstellen` | Einzelnen Punkt setzen |
| ![[Sketcher_CreateLine.svg]] | Linie erstellen | `G`, `L` | `Skizze → Sketcher-Geometrien → Linie erstellen` | Linie durch zwei Punkte zeichnen |
| ![[Sketcher_CreatePolyline.svg]] | Polylinie erstellen | `G`, `M` | `Skizze → Sketcher-Geometrien → Polylinie erstellen` | Zusammenhängenden Linienzug zeichnen (Endpunkt = neuer Startpunkt) |

### Rechtecke & Polygone

| Symbol | Name | Kürzel | Menüpfad | Beschreibung |
|---|---|---|---|---|
| ![[Sketcher_CreateRectangle.svg]] | Rechteck erstellen | `G`, `R` | `Skizze → Sketcher-Geometrien → Rechteck erstellen` | Achsenparalleles Rechteck durch zwei Eckpunkte |
| ![[Sketcher_CreateRectangle_Center.svg]] | Zentriertes Rechteck | – | `Skizze → Sketcher-Geometrien → Zentriertes Rechteck erstellen` | Rechteck durch Mittelpunkt und Eckpunkt |
| ![[Sketcher_CreateOblong.svg]] | Abgerundetes Rechteck | – | `Skizze → Sketcher-Geometrien → Abgerundetes Rechteck erstellen` | Rechteck mit verrundeten Ecken |
| ![[Sketcher_CreateTriangle.svg]] | Dreieck erstellen | – | `Skizze → Sketcher-Geometrien → Dreieck erstellen` | Gleichseitiges Dreieck |
| ![[Sketcher_CreateSquare.svg]] | Quadrat erstellen | – | `Skizze → Sketcher-Geometrien → Quadrat erstellen` | Regelmäßiges Viereck |
| ![[Sketcher_CreatePentagon.svg]] | Fünfeck erstellen | – | `Skizze → Sketcher-Geometrien → Fünfeck erstellen` | Regelmäßiges Fünfeck |
| ![[Sketcher_CreateHexagon.svg]] | Sechseck erstellen | `G`, `O` | `Skizze → Sketcher-Geometrien → Sechseck erstellen` | Regelmäßiges Sechseck |
| ![[Sketcher_CreateHeptagon.svg]] | Siebeneck erstellen | – | `Skizze → Sketcher-Geometrien → Siebeneck erstellen` | Regelmäßiges Siebeneck |
| ![[Sketcher_CreateOctagon.svg]] | Achteck erstellen | – | `Skizze → Sketcher-Geometrien → Achteck erstellen` | Regelmäßiges Achteck |
| ![[Sketcher_CreateRegularPolygon.svg]] | Regelmäßiges Polygon | – | `Skizze → Sketcher-Geometrien → Regelmäßiges Polygon erstellen` | Polygon mit beliebiger Eckenanzahl |

### Kreise & Ellipsen

| Symbol | Name | Kürzel | Menüpfad | Beschreibung |
|---|---|---|---|---|
| ![[Sketcher_CreateCircle.svg]] | Kreis erstellen | `G`, `C` | `Skizze → Sketcher-Geometrien → Kreis erstellen` | Kreis durch Mittelpunkt und Radius |
| ![[Sketcher_Create3PointCircle.svg]] | Kreis durch 3 Punkte | – | `Skizze → Sketcher-Geometrien → Kreis durch drei Punkte erstellen` | Kreis durch drei Punkte auf der Peripherie |
| ![[Sketcher_CreateEllipseByCenter.svg]] | Ellipse (Mittelpunkt) | `G`, `E` | `Skizze → Sketcher-Geometrien → Ellipse durch Mittelpunkt erstellen` | Ellipse durch Mittelpunkt, Haupt- und Nebenachse |
| ![[Sketcher_CreateEllipse_3points.svg]] | Ellipse (3 Punkte) | – | `Skizze → Sketcher-Geometrien → Ellipse durch drei Punkte erstellen` | Ellipse durch drei Punkte |

### Bögen

| Symbol | Name | Kürzel | Menüpfad | Beschreibung |
|---|---|---|---|---|
| ![[Sketcher_CreateArc.svg]] | Bogen erstellen | `G`, `A` | `Skizze → Sketcher-Geometrien → Bogen erstellen` | Kreisbogen durch Mittelpunkt, Startpunkt und Endpunkt |
| ![[Sketcher_Create3PointArc.svg]] | Bogen durch 3 Punkte | – | `Skizze → Sketcher-Geometrien → Bogen durch drei Punkte erstellen` | Kreisbogen durch drei Punkte |
| ![[Sketcher_CreateElliptical_Arc.svg]] | Ellipsenbogen | – | `Skizze → Sketcher-Geometrien → Ellipsenbogen erstellen` | Bogen einer Ellipse |
| ![[Sketcher_CreateHyperbolic_Arc.svg]] | Hyperbelbogen | – | `Skizze → Sketcher-Geometrien → Hyperbelbogen erstellen` | Bogen einer Hyperbel |
| ![[Sketcher_CreateParabolic_Arc.svg]] | Parabelbogen | – | `Skizze → Sketcher-Geometrien → Parabelbogen erstellen` | Bogen einer Parabel |

### B-Splines

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Sketcher_CreateBSpline.svg]] | B-Spline erstellen | `Skizze → Sketcher-Geometrien → B-Spline erstellen` | Freikurve durch Kontrollpunkte |
| ![[Sketcher_Create_Periodic_BSpline.svg]] | Periodischer B-Spline | `Skizze → Sketcher-Geometrien → Periodischen B-Spline erstellen` | Geschlossene B-Spline-Kurve |
| ![[Sketcher_CreateBSplineByInterpolation.svg]] | B-Spline (Interpolation) | `Skizze → Sketcher-Geometrien → B-Spline durch Interpolation erstellen` | B-Spline, der exakt durch die Stützpunkte verläuft |
| ![[Sketcher_CreatePeriodicBSplineByInterpolation.svg]] | Periodischer B-Spline (Interpolation) | `Skizze → Sketcher-Geometrien → Periodischen B-Spline durch Interpolation erstellen` | Geschlossener interpolierter B-Spline |

---

## Geometrie bearbeiten

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Sketcher_CreateFillet.svg]] | Verrundung erstellen | `Skizze → Sketcher-Geometrien → Verrundung erstellen` | Kreisbogenverrundung zwischen zwei Linien an einem gemeinsamen Eckpunkt |
| ![[Sketcher_CreatePointFillet.svg]] | Punktverrundung | `Skizze → Sketcher-Geometrien → Punktverrundung erstellen` | Verrundung unter Beibehaltung des Eckpunkts als Hilfspunkt |
| ![[Sketcher_CreateChamfer.svg]] | Fase erstellen | `Skizze → Sketcher-Geometrien → Fase erstellen` | Geradlinige Abschrägung zwischen zwei Linien |
| ![[Sketcher_Trimming.svg]] | Kante trimmen | `Skizze → Sketcher-Geometrien → Kante trimmen` | Kantenabschnitt zwischen zwei Schnittpunkten entfernen |
| ![[Sketcher_Split.svg]] | Kante teilen | `Skizze → Sketcher-Geometrien → Kante teilen` | Kante an einem Punkt in zwei Segmente aufteilen |
| ![[Sketcher_Extend.svg]] | Kante verlängern | `Skizze → Sketcher-Geometrien → Kante verlängern` | Linie oder Bogen bis zu einem Zielobjekt verlängern |

---

## Externe Geometrie & Konstruktion

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Sketcher_Projection.svg]] | Externe Geometrie | `Skizze → Sketcher-Geometrien → Externe Geometrie` | Kanten des 3D-Körpers als Referenz in die Skizze projizieren (nicht editierbar, lila) |
| ![[Sketcher_CarbonCopy.svg]] | Kohlenstoffkopie | `Skizze → Sketcher-Geometrien → Kohlenstoffkopie` | Geometrie einer anderen Skizze als Referenz übernehmen |
| ![[Sketcher_ToggleConstruction.svg]] | Konstruktionsmodus umschalten | `Skizze → Sketcher-Geometrien → Konstruktionsmodus umschalten` | Ausgewählte Geometrie zwischen Normal (weiß) und Konstruktion (blau gestrichelt) wechseln |

---

## Geometrische Randbedingungen

| Symbol | Name | Kürzel | Menüpfad | Beschreibung |
|---|---|---|---|---|
| ![[Constraint_Coincident.svg]] | Koinzidenz festlegen | `C`, `O` | `Skizze → Sketcher-Randbedingungen → Koinzidenz festlegen` | Zwei Punkte auf dieselbe Position zwingen |
| ![[Constraint_PointOnObject.svg]] | Punkt auf Objekt | – | `Skizze → Sketcher-Randbedingungen → Punkt auf Objekt festlegen` | Punkt auf Linie, Kreis oder Bogen fixieren |
| ![[Constraint_HorVer.svg]] | Horizontal/Vertikal | – | `Skizze → Sketcher-Randbedingungen → Horizontal oder vertikal festlegen` | Linie automatisch horizontal oder vertikal ausrichten (je nach Neigung) |
| ![[Constraint_Horizontal.svg]] | Horizontal festlegen | `C`, `H` | `Skizze → Sketcher-Randbedingungen → Horizontal festlegen` | Linie exakt waagerecht ausrichten |
| ![[Constraint_Vertical.svg]] | Vertikal festlegen | `C`, `V` | `Skizze → Sketcher-Randbedingungen → Vertikal festlegen` | Linie exakt senkrecht ausrichten |
| ![[Constraint_Parallel.svg]] | Parallel festlegen | `C`, `P` | `Skizze → Sketcher-Randbedingungen → Parallel festlegen` | Zwei Linien parallel zueinander ausrichten |
| ![[Constraint_Perpendicular.svg]] | Rechtwinklig festlegen | `C`, `R` | `Skizze → Sketcher-Randbedingungen → Rechtwinklig festlegen` | Zwei Linien im 90°-Winkel zueinander |
| ![[Constraint_Tangent.svg]] | Tangential festlegen | `C`, `T` | `Skizze → Sketcher-Randbedingungen → Tangential festlegen` | Kurven knickfrei aneinanderfügen |
| ![[Constraint_EqualLength.svg]] | Gleiche Beschränkung | – | `Skizze → Sketcher-Randbedingungen → Gleiche Beschränkungen festlegen` | Zwei Linien auf gleiche Länge oder zwei Kreise/Bögen auf gleichen Radius zwingen |
| ![[Constraint_Symmetric.svg]] | Symmetrisch festlegen | `C`, `S` | `Skizze → Sketcher-Randbedingungen → Symmetrisch festlegen` | Zwei Punkte spiegelbildlich zu einer Achse positionieren |
| ![[Constraint_Block.svg]] | Sperren (Fixiert) | `C`, `B` | `Skizze → Sketcher-Randbedingungen → Sperren` | Element vollständig an seiner aktuellen Position fixieren (alle DOF = 0) |

---

## Maßliche Randbedingungen

| Symbol | Name | Kürzel | Menüpfad | Beschreibung |
|---|---|---|---|---|
| ![[Constraint_Lock.svg]] | Fixieren | – | `Skizze → Sketcher-Randbedingungen → Fixieren` | Punkt durch absolute X/Y-Koordinaten positionieren |
| ![[Constraint_Length.svg]] | Abstand festlegen | `C`, `D` | `Skizze → Sketcher-Randbedingungen → Abstand festlegen` | Länge einer Linie oder Abstand zweier Punkte |
| ![[Constraint_HorizontalDistance.svg]] | Horizontalen Abstand | `C`, `I` | `Skizze → Sketcher-Randbedingungen → Horizontalen Abstand festlegen` | Abstand zweier Punkte in X-Richtung |
| ![[Constraint_VerticalDistance.svg]] | Vertikalen Abstand | `C`, `J` | `Skizze → Sketcher-Randbedingungen → Vertikalen Abstand festlegen` | Abstand zweier Punkte in Y-Richtung |
| ![[Constraint_Radiam.svg]] | Radius/Durchmesser | `C`, `N` | `Skizze → Sketcher-Randbedingungen → Radius oder Gewicht festlegen` | Radius oder Durchmesser eines Kreises oder Bogens (Umschalten im Dialog) |
| ![[Constraint_InternalAngle.svg]] | Winkel festlegen | `C`, `A` | `Skizze → Sketcher-Randbedingungen → Winkel festlegen` | Winkel zwischen zwei Linien |
| ![[Constraint_SnellsLaw.svg]] | Snellsches Gesetz | – | `Skizze → Sketcher-Randbedingungen → Snellsches Gesetz festlegen` | Brechungsgesetz für optische Simulationen (Spezialanwendung) |

---

## Randbedingungen umschalten

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Sketcher_Toggle_Constraint_Driving.svg]] | Treibend/Referenz umschalten | `Skizze → Sketcher-Randbedingungen → Treibende Randbedingung umschalten` | Maßliche Randbedingung zwischen treibend (bestimmt Geometrie) und referenzierend (zeigt Maß nur an) umschalten |
| ![[Sketcher_ToggleActiveConstraint.svg]] | Randbedingung aktivieren | `Skizze → Sketcher-Randbedingungen → Aktive Randbedingung umschalten` | Einzelne Randbedingung temporär deaktivieren ohne zu löschen |

---

## Skizze bearbeiten & transformieren

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Sketcher_Symmetry.svg]] | Symmetrie | `Skizze → Sketcher-Geometrien → Symmetrie` | Ausgewählte Geometrie an einer Linie spiegeln und kopieren |
| ![[Sketcher_Clone.svg]] | Klonen | `Skizze → Sketcher-Geometrien → Klonen` | Geometrie klonen – Klon bleibt mit Original über Constraints verknüpft |
| ![[Sketcher_Copy.svg]] | Kopieren | `Skizze → Sketcher-Geometrien → Kopieren` | Geometrie unabhängig kopieren |
| ![[Sketcher_Move.svg]] | Verschieben | `Skizze → Sketcher-Geometrien → Verschieben` | Ausgewählte Geometrie verschieben |
| ![[Sketcher_RectangularArray.svg]] | Rechteckige Anordnung | `Skizze → Sketcher-Geometrien → Rechteckige Anordnung` | Geometrie in einem rechteckigen Raster vervielfältigen |

---

## Hinweise zur Verwendung

> [!tip] SVG-Dateien einbinden
> Alle SVG-Dateien mit dem Python-Skript `collect_icons.py` aus dem FreeCAD-Quellverzeichnis extrahieren und in den Obsidian-Ordner `_assets/icons/` kopieren. Obsidian bindet sie dann über `![[Dateiname.svg]]` automatisch ein.

> [!info] Namenskonventionen
> Geometrie-Icons folgen dem Schema `Sketcher_Create….svg`. Constraint-Icons verwenden das Schema `Constraint_….svg` (ohne `Sketcher_`-Präfix). Beide Gruppen liegen nach dem Extrahieren im selben Zielordner.

> [!info] Externe Geometrie (lila)
> Über ![[Sketcher_Projection.svg]] Externe Geometrie projizierte Kanten erscheinen lila und sind nicht editierbar. Sie dienen nur als Referenz für Constraints und werden bei der 3D-Operation ignoriert.

> [!warning] Kohlenstoffkopie
> ![[Sketcher_CarbonCopy.svg]] Kohlenstoffkopie übernimmt Geometrie und Constraints einer anderen Skizze. Änderungen in der Quellskizze wirken sich auf die Kopie aus – mit Bedacht einsetzen.

---

## Querverweise

- [[Cheat Sheet – Sketcher Constraints]]
- [[Cheat Sheet – Tastenkürzel]]
- [[M02 – Sketcher Grundlagen]]
- [[M03 – Sketcher Constraints]]
- [[Glossar FreeCAD#Skizze]]
- [[Glossar FreeCAD#Constraint (Randbedingung)]]
