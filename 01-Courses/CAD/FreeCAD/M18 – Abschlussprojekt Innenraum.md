# M18 – Abschlussprojekt Innenraum

> [!info] Modulinfo
> **Workbenches:** *BIM*, *Draft*, *Sketcher*, *Part Design*, *Spreadsheet*, *TechDraw*
> **Dauer:** 120 min
> **Voraussetzung:** [[M11 – BIM-Workbench & Projektstruktur]] bis [[M17 – Raumpläne & Schnitte mit TechDraw]]
> **Kurs:** [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]

---

## Einführung

Dieses Abschlussprojekt integriert alle Fertigkeiten des Aufbaukurses in einer zusammenhängenden Aufgabe. Ausgangspunkt ist eine vorgegebene Raumgeometrie; von dort wird das Modell schrittweise durch Öffnungen, Möblierung, Flächennachweis und schließlich einen druckfertigen Raumplan vervollständigt.

Das Projekt folgt dem realen Planungsablauf:

```
Raumstruktur → Öffnungen → Grundriss → Möblierung → Flächennachweis → Plan
```

Jede Phase baut auf der vorherigen auf. Zwischenstände nach jeder Phase speichern (`Strg+S`), damit bei Problemen zurückgekehrt werden kann.

> [!tip] Arbeitsweise
> Nicht versuchen, alle Phasen ohne Pause durchzuarbeiten. Nach jeder Phase kurz prüfen, ob das Ergebnis mit den Angaben übereinstimmt – Korrekturen jetzt sind einfacher als am Ende.

---

## Aufgabenstellung

**Raum:** Wohnzimmer mit angrenzender Essecke  
**Außenmaß:** 5,20 m × 3,80 m (Außenkante Wand)  
**Raumhöhe:** 2,60 m  
**Wandstärke:** 12 cm durchgehend  
**Einheit:** Zentimeter (`Bearbeiten → Voreinstellungen → Allgemein → Einheiten → Architektur (cm)`)

**Öffnungen:**

| Bauteil | Breite | Höhe | Brüstung | Position (Außenkante Wand) |
|---|---|---|---|---|
| Eingangstür | 90 cm | 210 cm | 0 cm | Nordwand, 80 cm vom linken Eck |
| Terrassentür | 180 cm | 220 cm | 0 cm | Südwand, zentriert |
| Fenster links | 100 cm | 120 cm | 90 cm | Westwand, 60 cm vom Nordeck |
| Fenster rechts | 100 cm | 120 cm | 90 cm | Westwand, 60 cm vom Südeck |

**Möblierung (Mindestanforderung):**

| Objekt | Quelle | Richtwert Abmessung |
|---|---|---|
| Sofa (L-Form oder 3-Sitzer) | BIM-Bibliothek | ca. 220 × 90 cm |
| Esstisch mit 4 Stühlen | BIM-Bibliothek | Tisch ca. 140 × 80 cm |
| TV-Lowboard | selbst modelliert | ca. 150 × 45 × 50 cm (B×T×H) |

**Planausgabe:**
- Zeichnungsblatt A3, Querformat
- Grundriss Maßstab 1:50
- Eine Schnittansicht (Schnitt A–A, Südwand als Schnittebene)
- Vollständige Bemaßung (Raummaße, Wandstärken, alle Öffnungen)
- Schriftfeld ausgefüllt

---

## Phase 1 – Raumstruktur

**Ziel:** Vollständiger Raumkörper mit vier Wänden, Boden, Decke und allen vier Öffnungen.  
**Workbenches:** *BIM*  
**Richtwert:** 35 min

### Schritt 1 – Projektrahmen anlegen

1. Neues FreeCAD-Dokument anlegen: `Datei → Neu`
2. Workbench *BIM* wählen
3. Einheiten prüfen: `Bearbeiten → Voreinstellungen → Allgemein → Einheiten → Architektur (cm)`
4. Gebäude-Container erstellen: `BIM → Gebäude erstellen`
5. Ebene erstellen: `BIM → Ebene erstellen` – Höhe: 0 cm, Name: „EG"
6. Arbeitsebene auf XY setzen: `BIM → Arbeitsebene setzen → XY`
7. Raster aktivieren: `Draft → Hilfsmittel → Raster umschalten`, Rasterabstand 10 cm

### Schritt 2 – Wände zeichnen

Alle vier Wände mit `BIM → Wand` erzeugen. Wandparameter für jede Wand:
- Höhe: 260 cm
- Stärke: 12 cm
- Ausrichtung: Mittellinie

Außenmaß 520 × 380 cm – Wände von Außenkante zu Außenkante zeichnen und anschließend über die Eigenschaften (Properties Panel) auf korrekte Lage prüfen.

> [!tip] Fangpunkte nutzen
> Endpunkte der Wände mit aktiviertem Endpunkt-Fang setzen – der Cursor rastet exakt auf den Startpunkt der ersten Wand ein, wenn der geschlossene Wandring fertig ist.

> [!warning] Wandverbund prüfen
> Nach dem Zeichnen alle vier Eckpunkte im Modellbaum kontrollieren. Koinzidente Endpunkte erzeugen automatisch einen Wandverbund; ein kleiner Spalt im Grundriss verhindert den Ausschnitt bei Türen und Fenstern.

### Schritt 3 – Boden und Decke

1. Bodenplatte: Skizze auf XY-Ebene (0 cm) – Rechteck 520 × 380 cm, dann `BIM → Platte`, Stärke: 20 cm, Richtung: nach unten
2. Deckenplatte: Skizze auf Höhe 260 cm – gleiches Rechteck, dann `BIM → Platte`, Stärke: 20 cm, Richtung: nach oben

### Schritt 4 – Öffnungen einfügen

Für jede Öffnung `BIM → Fenster` aufrufen, das passende Preset wählen und auf der Zielfläche platzieren:

- **Eingangstür:** Preset „Einfache Drehtür", Wandfläche Nordwand anklicken, Position 80 cm vom linken Eck
- **Terrassentür:** Preset „Zweiflügelige Drehtür" oder „Einfaches Fenster" (manuell zentrieren), Südwand
- **Fenster links / rechts:** Preset „Einfaches Fenster", Westwand, Brüstungshöhe 90 cm

Nach jeder Platzierung Wandausschnitt in der 3D-Ansicht visuell bestätigen.

**Zwischenspeichern:** `Strg+S`

---

## Phase 2 – 2D-Grundriss ableiten

**Ziel:** Sauberer 2D-Grundriss als Basis für TechDraw und als eigenständige Zeichnungsebene.  
**Workbenches:** *BIM*, *Draft*  
**Richtwert:** 15 min

### Schritt 1 – Schnittebene setzen

1. Workbench *BIM* aktiv lassen
2. Schnittebene anlegen: `BIM → Schnittebene` – Ebene auf ca. 100 cm über Boden positionieren (erfasst alle Öffnungen)
3. Schnittebene im Modellbaum umbenennen: „Grundriss EG"

### Schritt 2 – 2D-Ansicht ableiten

1. Schnittebene im Modellbaum selektieren
2. `BIM → 2D-Ansicht` – FreeCAD erzeugt eine flache Draft-Geometrie des Schnitts
3. Ergebnis: 2D-Grundriss-Objekt im Modellbaum, sichtbar in der Draufsicht (`Num 7`)

> [!info]
> Das 2D-Ansicht-Objekt ist verknüpft – ändert sich das 3D-Modell, aktualisiert sich die 2D-Ansicht nach erneutem Ausführen von `BIM → 2D-Ansicht`.

**Zwischenspeichern:** `Strg+S`

---

## Phase 3 – Möblierung

**Ziel:** Drei Möbelobjekte platziert; TV-Lowboard selbst modelliert.  
**Workbenches:** *BIM*, *Part Design*  
**Richtwert:** 25 min

### Schritt 1 – Sofa und Esstisch aus Bibliothek

1. `BIM → Bibliothek` öffnen
2. Sofa suchen (Suchbegriff „sofa" oder „couch"), passendes Objekt per Doppelklick in die Szene laden
3. Position anpassen: Properties Panel → Placement → Position (X/Y in cm)
4. Ausrichtung anpassen: Properties Panel → Placement → Angle

Gleiches Vorgehen für Esstisch und Stühle (4× gleicher Stuhl, als verknüpfte Kopien platzieren).

> [!tip] Stuhl-Kopien
> Ersten Stuhl platzieren → im Modellbaum selektieren → `Strg+C`, `Strg+V` erzeugt eine unabhängige Kopie. Für verknüpfte Kopien stattdessen `BIM → Komponente erstellen` verwenden.

### Schritt 2 – TV-Lowboard selbst modellieren

Das Lowboard (150 × 45 × 50 cm, B×T×H) in einem separaten Dokument modellieren:

1. Neues Dokument: `Datei → Neu` – Workbench *Part Design*
2. Body erstellen: `Part Design → Body`
3. Skizze auf XZ-Ebene: Rechteck 150 × 50 cm (Breite × Höhe)
4. Aufmaß: `Part Design → Aufmaß`, Tiefe 45 cm
5. Wandstärke 2 cm: Auf Vorderfläche neue Skizze, Rechteck-Offset 2 cm einwärts, `Part Design → Tasche` → „Durch alles"
6. Dokument speichern als `TV_Lowboard.FCStd`
7. Zurück im Raumprojekt: `BIM → Bibliothek → Lokale Datei → TV_Lowboard.FCStd` laden und positionieren

**Zwischenspeichern im Raumprojekt:** `Strg+S`

---

## Phase 4 – Flächennachweis

**Ziel:** Raumobjekt mit korrekter Nettofläche, Stückliste als Spreadsheet.  
**Workbenches:** *BIM*, *Spreadsheet*  
**Richtwert:** 15 min

### Schritt 1 – Raumobjekt anlegen

1. `BIM → Raum` – Raumkontur durch Klick auf die vier Wandinnenkanten oder Polylinie entlang der Innenkanten ziehen
2. Innenkante = Außenmaß minus 2× Wandstärke: (520 − 24) × (380 − 24) = **496 × 356 cm**
3. Raumobjekt im Modellbaum umbenennen: „Wohnzimmer"
4. Properties Panel prüfen: **Nettofläche** sollte ca. **17,66 m²** betragen

> [!info] Handrechnung als Gegenprobe
> 4,96 m × 3,56 m = 17,6576 m² ≈ 17,66 m². Weicht der angezeigte Wert um mehr als 2 % ab, liegt die Raumkontur nicht exakt an den Innenkanten – Raumobjekt löschen und neu zeichnen.

### Schritt 2 – Stückliste erzeugen

1. `BIM → Stückliste` – Dialog öffnet sich
2. Exportformat: „In Spreadsheet einfügen"
3. Spreadsheet-Workbench öffnet automatisch eine neue Tabelle mit allen BIM-Objekten, Typen und Flächen
4. Tabelle überprüfen: Wände (4×), Platten (2×), Fenster (2×), Türen (2×), Möbel (3×), Raum (1×) müssen erscheinen
5. Spreadsheet-Dokument speichern: `Strg+S`

**Zwischenspeichern im Raumprojekt:** `Strg+S`

---

## Phase 5 – Raumplan

**Ziel:** Druckfertiger A3-Plan mit Grundriss, Schnittansicht und vollständiger Bemaßung.  
**Workbench:** *TechDraw*  
**Richtwert:** 30 min

### Schritt 1 – Zeichnungsseite anlegen

1. Workbench *TechDraw* wählen
2. `TechDraw → Seite einfügen → Seite aus Vorlage einfügen` – Vorlage: A3 Querformat (ISO 7200)
3. Seite im Modellbaum umbenennen: „Raumplan EG"

### Schritt 2 – Grundrissansicht einfügen

1. Das 2D-Ansicht-Objekt aus Phase 2 im Modellbaum selektieren
2. `TechDraw → Ansichten → Draft-Ansicht einfügen` – Maßstab: 1:50
3. Ansicht auf der linken Blatthälfte positionieren

> [!tip] Maßstab einstellen
> Maßstab 1:50 bedeutet: 1 cm auf dem Plan = 50 cm in der Realität. Bei A3 (420 × 297 mm nutzbarer Bereich ca. 380 × 260 mm) passt der Raum (520 × 380 cm → 10,4 × 7,6 cm im Plan) problemlos.

### Schritt 3 – Schnittansicht einfügen (Schnitt A–A)

1. Grundrissansicht selektieren
2. `TechDraw → Ansichten → Schnittansicht einfügen`
3. Schnittlinie: horizontal durch Südwand (erfasst Terrassentür vollständig)
4. Blickrichtung: nach Norden
5. Schnittansicht rechts neben dem Grundriss positionieren, Maßstab 1:50

### Schritt 4 – Bemaßung

Folgende Maßketten setzen (`TechDraw → Bemaßung → Längenmaß einfügen`):

**Im Grundriss:**
- Außenmaß gesamt: 520 cm (Breite) und 380 cm (Tiefe) – je eine Maßkette außen
- Wandstärken: je eine Bemaßung an Nord- und Westwand (12 cm)
- Öffnungsbreiten: alle vier Öffnungen bemaßen
- Einbauposition Eingangstür: 80 cm Abstand vom linken Eck
- Raumstempel: `BIM → Raumbeschriftung` einbinden oder als Textanmerkung „WZ 17,66 m²" (`TechDraw → Anmerkungen → Anmerkung einfügen`)

**In der Schnittansicht:**
- Raumhöhe: 260 cm
- Wandhöhe gesamt (inkl. Deckenplatte)
- Sturzmaß Terrassentür: 260 − 220 = 40 cm
- Brüstungshöhe Fenster: 90 cm (wenn sichtbar)

> [!warning] Maßreferenzen
> Maße immer auf Geometriekanten klicken – nicht auf den Zeichnungsrahmen. Verliert ein Maß nach einer Modelländerung seine Referenz, mit `TechDraw → Bemaßung → Maß reparieren` wiederherstellen.

### Schritt 5 – Schriftfeld ausfüllen

`TechDraw → Vorlagenfelder ausfüllen` – Mindestfelder:

| Feld | Inhalt |
|---|---|
| Titel | Wohnzimmer EG – Grundriss und Schnitt |
| Maßstab | 1:50 |
| Datum | aktuelles Datum |
| Gezeichnet | eigener Name |
| Blatt | 1/1 |

### Schritt 6 – Export

`Datei → Exportieren → PDF` – Datei öffnen und Druckbild prüfen: Linien lesbar, Maßzahlen nicht überlappend, Schriftfeld vollständig sichtbar.

**Abschließend speichern:** `Strg+S`

---

## Selbstkontrolle-Checkliste

### Phase 1 – Raumstruktur
- [ ] Alle vier Wände verbunden (kein Spalt sichtbar, Draufsicht `Num 7`)
- [ ] Wandhöhe 260 cm, Wandstärke 12 cm überall korrekt
- [ ] Boden und Decke vorhanden, schließen bündig mit Wandober- bzw. -unterkante ab
- [ ] Alle vier Öffnungen mit sichtbarem Wandausschnitt in der 3D-Ansicht

### Phase 2 – Grundriss
- [ ] 2D-Ansicht-Objekt im Modellbaum vorhanden
- [ ] Schnittebene auf ca. 100 cm Höhe – alle Öffnungen erscheinen im Grundriss

### Phase 3 – Möblierung
- [ ] Sofa und Esstisch aus Bibliothek geladen und positioniert (kein Möbel außerhalb des Raums)
- [ ] TV-Lowboard als eigenes FCStd-Dokument gespeichert und im Raumprojekt eingebunden
- [ ] Keine Kollision zwischen Möbeln und Wänden (visuelle Prüfung)

### Phase 4 – Flächennachweis
- [ ] Raumobjekt vorhanden, Kontur exakt an Wandinnenkanten
- [ ] Nettofläche im Properties Panel: 17,66 m² ± 0,35 m² (2 %-Toleranz)
- [ ] Stückliste im Spreadsheet: alle erwarteten Objekte aufgelistet

### Phase 5 – Plan
- [ ] Grundrissansicht Maßstab 1:50, korrekte Ausrichtung (Norden oben)
- [ ] Schnittansicht Schnitt A–A vorhanden, Schnittlinie im Grundriss eingezeichnet
- [ ] Maßkette außen geschlossen: Summe der Teilmaße = Gesamtmaß (520 cm bzw. 380 cm)
- [ ] Alle Öffnungen bemaßt (Breite + Position)
- [ ] Raumstempel mit Bezeichnung und Fläche vorhanden
- [ ] Schriftfeld vollständig ausgefüllt
- [ ] PDF exportiert und Druckbild geprüft

---

## Häufige Probleme & Lösungen

> [!warning] Wandausschnitt fehlt bei Tür/Fenster
> Ursache: Fenster/Tür wurde nicht exakt auf der Wandfläche platziert. Lösung: Objekt löschen, erneut `BIM → Fenster` aufrufen und diesmal direkt auf die Wandfläche klicken (Wandfläche muss beim Klicken hervorgehoben sein).

> [!warning] 2D-Ansicht zeigt Möbel
> Ursache: BIM-Objekte (Möbel) erscheinen im Schnitt, wenn sie die Schnittebene kreuzen. Lösung: Möbel im Modellbaum selektieren → Properties Panel → Visibility auf False setzen, bevor `BIM → 2D-Ansicht` ausgeführt wird. Oder Schnittebene über Oberkante der Möbel anheben.

> [!warning] Nettofläche weicht stark ab
> Ursache: Raumkontur liegt auf Außen- statt Innenkanten. Lösung: Raumobjekt löschen, neue Schnittebene auf Bodenhöhe (0 cm) anlegen, Raumkontur mit aktiviertem Endpunkt-Fang neu an den Innenkanten zeichnen.

> [!warning] Maße im Plan überlappen
> Lösung: Maßlinien manuell verschieben – in der TechDraw-Seite die Maßzahl per Klick selektieren und mit der Maus in Position ziehen. Maßstab ggf. auf 1:75 reduzieren, wenn der Plan zu eng wird.

---

## Querverweise

- [[M11 – BIM-Workbench & Projektstruktur]]
- [[M12 – Wände, Böden & Decken]]
- [[M13 – Türen & Fenster]]
- [[M14 – 2D-Grundriss mit Draft]]
- [[M15 – Innenausstattung & Möblierung]]
- [[M16 – Räume, Flächen & Stücklisten]]
- [[M17 – Raumpläne & Schnitte mit TechDraw]]
- [[Glossar FreeCAD]]
- [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]
