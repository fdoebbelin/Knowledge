# M14 – 2D-Grundriss mit Draft

> [!info] Modulinfo
> **Workbenches:** *Draft*, *BIM*
> **Dauer:** ca. 90 min
> **Voraussetzung:** [[M12 – Wände, Böden & Decken]]
> **Kurs:** [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]

**Lernziel:** Einen präzisen 2D-Grundriss mit der *Draft*-Workbench zeichnen, das Fang-System für genaue Geometrie einsetzen, den Grundriss zu einem 3D-Raummodell hochziehen **oder** aus einem bestehenden 3D-Modell ableiten – und das Ergebnis als DXF exportieren.

---

## Teil 1 – Einführung & Demonstration

### 1.1 Die Draft-Workbench im Überblick

*Draft* ist FreeCADs 2D-Zeichenwerkzeug. Anders als der *Sketcher* (der immer an einen Body gebunden ist) erzeugt *Draft* eigenständige 2D-Objekte im 3D-Raum – positioniert auf der aktuellen **Arbeitsebene**.

**Arbeitsebene prüfen und setzen** – immer zuerst:

```
BIM → Arbeitsebene setzen
```

oder Taste `W` → Dialog: XY-Ebene (Grundriss) wählen und mit **OK** bestätigen.  
Die Statusleiste unten zeigt die aktive Arbeitsebene: `Plane: XY`.

> [!warning] Arbeitsebene vergessen
> Alle Draft-Geometrie entsteht auf der aktuellen Arbeitsebene. Ist diese falsch, entstehen Linien „schwebend" im Raum. Vor jedem Zeichenstart prüfen.

**Raster aktivieren** für präzises Arbeiten:

```
Draft → Hilfsmittel → Raster umschalten
```

Rasterabstand (z. B. 10 cm) unter `Bearbeiten → Voreinstellungen → Draft → Raster` einstellen.

---

### 1.2 Fang-System (Snapping)

Das **Fang-System** lässt den Cursor magnetisch auf exakt definierten Geometriepunkten einrasten – das wichtigste Präzisionswerkzeug in *Draft*.

**Fang ein-/ausschalten:** `S`  
**Einzelnen Fang temporär deaktivieren:** `Strg` (während Mausklick)

Aktive Fangarten werden in der Symbolleiste „Draft-Fang" als gedrückte Schaltflächen angezeigt. Für den Grundriss relevant:

| Fangart | Symbol | Wirkung |
|---|---|---|
| Endpunkt | ![[Draft_Snap_Endpoint.svg]] | Einrasten auf Linienenden |
| Mittelpunkt | ![[Draft_Snap_Midpoint.svg]] | Einrasten auf Kantenmitte |
| Schnittpunkt | ![[Draft_Snap_Intersection.svg]] | Einrasten auf Kreuzungspunkten |
| Rechtwinklig | ![[Draft_Snap_Perpendicular.svg]] | Senkrechte Verbindung zur nächsten Kante |
| Raster | ![[Draft_Snap_Grid.svg]] | Einrasten auf Rasterpunkte |

> [!tip] Nur nötige Fangarten aktiv halten
> Zu viele aktive Fangarten konkurrieren miteinander. Für den Grundriss-Workflow reichen Endpunkt + Raster + Schnittpunkt.

---

### 1.3 Weg A – Grundriss direkt zeichnen, dann zu 3D extrudieren

Dieser Weg eignet sich, wenn das Raumprojekt noch keine 3D-Geometrie hat.

#### Schritt 1 – Raumkontur als Polylinie zeichnen

```
Draft → Zeichnen → Polylinie
```

Eine **Polylinie** (Linienzug) ist eine Folge verbundener Linien als ein Objekt – ideal für Wandmittellinien.

1. Ersten Eckpunkt klicken (z. B. Koordinaten `0, 0` im Eingabefeld)
2. Weitere Eckpunkte im Uhrzeigersinn setzen (Fang auf Raster aktiv)
3. Letzten Punkt auf den Startpunkt fangen → Polylinie schließt sich automatisch
4. `Schließen`-Schaltfläche im Aufgabenpanel klicken **oder** letzten Punkt auf Startpunkt fangen

> [!example] Beispielraum 4 × 3 m
> Eckpunkte: `(0,0)` → `(400,0)` → `(400,300)` → `(0,300)` → `Schließen`
> Einheit: cm (bei Einstellung „Architektur (cm)")

#### Schritt 2 – Polylinie zu BIM-Wänden machen

Polylinie im Modellbaum auswählen, dann:

```
BIM → Wand
```

FreeCAD erkennt die Polylinie als Wandprofil und fragt nach Wandstärke und Höhe. Ergebnis: vier verbundene Wände als BIM-Objekte, vollständig parametrisch.

> [!info] Wandausrichtung
> Standardmäßig wird die Polylinie als Wandmittellinie interpretiert. Im Properties Panel → `Align` auf `Left` oder `Right` umstellen, um die Linie als Innen- oder Außenkante zu verwenden.

---

### 1.4 Weg B – Grundriss aus bestehendem 3D-Modell ableiten

Dieser Weg greift auf ein Raummodell aus M12/M13 zurück und erzeugt daraus eine 2D-Ansicht.

#### Schritt 1 – Schnittebene setzen

```
BIM → Schnittebene
```

Im Dialog Höhe angeben: **100 cm** über Erdgeschossboden (Norm: 1,0 m über FFBK – Fertigfußbodenkante).  
Die Schnittebene erscheint als gelber Rahmen im Modell, positionierbar per Drag.

#### Schritt 2 – 2D-Ansicht ableiten

Schnittebene im Modellbaum auswählen, dann:

```
BIM → 2D-Ansicht
```

FreeCAD projiziert alle Bauteile, die die Schnittebene schneidet, auf die XY-Ebene. Das Ergebnis ist ein **Shape2DView-Objekt** mit:
- **Schnittlinien** (Wandquerschnitte) – werden als dicke Linien dargestellt
- **Projektierten Kanten** (Boden, sichtbare Unterkanten) – dünne Linien

> [!tip] Schnittliniendarstellung
> Im Properties Panel des Shape2DView-Objekts unter `Projection Mode` zwischen `Solid` (alle Kanten) und `Cut Lines` (nur Schnittkanten) wechseln. Für einen sauberen Grundriss: `Cut Lines`.

---

### 1.5 Bemaßung und Beschriftung in Draft

**Maßlinie einfügen:**

```
Draft → Anmerkungen → Bemaßung
```

1. Ersten Messpunkt klicken (Fang auf Endpunkt)
2. Zweiten Messpunkt klicken
3. Maßlinie durch dritten Klick positionieren

**Textstempel (Raumbeschriftung):**

```
Draft → Anmerkungen → Text
```

Einfügeposition klicken, Text eingeben, `Enter` zum Abschließen.

> [!info] Draft-Bemaßung vs. TechDraw-Bemaßung
> Draft-Bemaßungen sind 3D-Objekte auf der Arbeitsebene – sichtbar im 3D-Viewport. Für normgerechte Pläne werden sie in M17 durch TechDraw-Bemaßungen ersetzt. Draft-Maße dienen hier als Konstruktionshilfe.

---

### 1.6 DXF-Export

Fertige Draft-Geometrie für externe Bearbeitung (AutoCAD, LibreCAD, Planer) exportieren:

```
Datei → Exportieren
```

Format: **DXF** wählen, Zielordner und Dateinamen angeben.

> [!warning] Exportinhalt prüfen
> Vor dem Export nur die gewünschten Objekte im Modellbaum auswählen – sonst exportiert FreeCAD alle sichtbaren Objekte des Dokuments, inklusive 3D-Geometrie.

---

## Teil 2 – Übungen

### Aufgabe 1 – Einfachen Grundriss zeichnen ⬜

**Ziel:** Einen rechteckigen Raum als 2D-Grundriss mit Draft zeichnen und zu BIM-Wänden extrudieren.

**Voraussetzung:** Neues FreeCAD-Dokument, Workbench *BIM*, Einheiten auf cm.

**Teilschritte:**

1. Arbeitsebene auf XY setzen (`W`), Raster aktivieren (10 cm Rasterabstand)
2. Fangarten: Endpunkt und Raster einschalten, alle anderen ausschalten
3. `Draft → Zeichnen → Polylinie` – Raum **500 × 350 cm** zeichnen, Polylinie schließen
4. Polylinie auswählen → `BIM → Wand` – Wandstärke **12 cm**, Höhe **260 cm**
5. Ergebnis in isometrischer Ansicht (`Num 0`) prüfen: vier verbundene Wände

**Erwartetes Ergebnis:** Quaderförmiger Raum, Innenmaß ca. 476 × 326 cm (500 cm minus 2 × 12 cm), Wandhöhe 260 cm sichtbar im 3D-Viewport.

> [!tip]
> Polylinie-Eckpunkte durch direkte Koordinateneingabe im Aufgabenpanel setzen (X/Y-Felder): präziser als Mausklick.

---

### Aufgabe 2 – L-förmiger Grundriss mit Fang ⬜

**Ziel:** Eine nicht-rechteckige Raumkontur als Polylinie zeichnen und dabei das Fang-System für Winkelgenauigkeit nutzen.

**Teilschritte:**

1. Neues Dokument, Arbeitsebene XY, Raster 10 cm
2. L-förmigen Grundriss zeichnen (Maße frei wählen, Beispiel: Gesamtrahmen 600 × 400 cm, Einsprung 200 × 200 cm oben rechts) – 6 Eckpunkte, Polylinie schließen
3. Auf rechte Winkel achten: Fang `Rechtwinklig` aktivieren, um Orthogonalität sicherzustellen
4. `BIM → Wand` anwenden (Stärke 15 cm, Höhe 260 cm)
5. Zwei Draft-Bemaßungen (`Draft → Anmerkungen → Bemaßung`) für Gesamtlänge und Gesamtbreite einfügen

**Erwartetes Ergebnis:** L-förmiger Grundriss mit sechs Wandsegmenten, zwei Maßlinien sichtbar.

> [!warning] Offene Polylinie
> `BIM → Wand` funktioniert auch auf offenen Polylinien – dann entstehen keine geschlossenen Wandecken. Polylinie vor dem Schritt immer auf `Closed: true` im Properties Panel prüfen.

---

### Aufgabe 3 – Grundriss aus 3D-Modell ableiten und exportieren ⬜

**Ziel:** Aus dem in M12/M13 erstellten Raummodell einen 2D-Grundriss ableiten und als DXF exportieren.

**Voraussetzung:** Fertige FCStd-Datei aus M12 oder M13 (Raum mit Wänden, Boden, Tür, Fenster).

**Teilschritte:**

1. M12/M13-Datei öffnen, Workbench *BIM* wählen
2. `BIM → Schnittebene` – Höhe **100 cm**, Rahmen über den gesamten Raum aufziehen
3. Schnittebene im Modellbaum auswählen → `BIM → 2D-Ansicht`
4. Im Properties Panel des Shape2DView: `Projection Mode → Cut Lines`
5. Türöffnung und Fensteröffnung im abgeleiteten Grundriss überprüfen (müssen als Lücken sichtbar sein)
6. Shape2DView-Objekt auswählen → `Datei → Exportieren → DXF` → Datei speichern
7. DXF in einem Texteditor öffnen und Struktur grob nachvollziehen (Layer, Entities)

**Erwartetes Ergebnis:** DXF-Datei mit Wandquerschnitten als Linien, Tür- und Fensteröffnungen als Unterbrechungen. Datei öffnet sich korrekt in einem zweiten CAD-Viewer oder LibreCAD.

> [!example] Kontrollfrage
> Wie viele Wandsegmente erscheinen im abgeleiteten Grundriss, wenn der Raum 4 Wände, 1 Tür und 1 Fenster hat?
> → 6 Segmente (jede Öffnung teilt ihre Wand in zwei Abschnitte).

---

## Neue Begriffe

| Begriff | Erklärung |
|---|---|
| **Fang (Snap)** | Magnetisches Einrasten des Cursors auf exakt definierten Geometriepunkten – verhindert Ungenauigkeiten |
| **Polylinie** | Zusammenhängender Linienzug aus mehreren Segmenten als ein Draft-Objekt |
| **Schnittebene (Section Plane)** | Virtueller horizontaler Schnitt durch das 3D-Modell, aus dem eine 2D-Ansicht abgeleitet wird |
| **Shape2DView** | FreeCAD-Objekt, das eine projizierte 2D-Darstellung eines 3D-Körpers oder einer Schnittebene enthält |
| **FFBK** | Fertigfußbodenkante – Norm-Bezugshöhe für den Grundrissschnitt (1,0 m über FFBK) |

---

## Tastenkürzel-Kurzreferenz

| Kürzel | Aktion |
|---|---|
| `W` | Arbeitsebene auswählen |
| `S` | Fang ein/aus |
| `Strg` (beim Zeichnen) | Fang temporär deaktivieren |
| `Leertaste` | Sichtbarkeit des ausgewählten Objekts umschalten |
| `Esc` | Aktuelles Werkzeug abbrechen |

---

## Querverweise

- [[M12 – Wände, Böden & Decken]] – Voraussetzung (3D-Modell für Weg B)
- [[M13 – Türen & Fenster]] – Öffnungen erscheinen im abgeleiteten Grundriss
- [[M17 – Raumpläne & Schnitte mit TechDraw]] – Weiterverarbeitung des abgeleiteten Grundrisses zur normierten Zeichnung
- [[Glossar FreeCAD]] – Fachbegriffe
- [[Cheat Sheet – Tastenkürzel]] – Ergänzende Shortcuts
