> [!info] Über dieses Dokument
> Konzeptdokument für den Aufbaukurs Innenarchitektur. Enthält alle Module mit Lernzielen, Zeitaufwand und Abhängigkeiten. Setzt den [[M00 FreeCAD Intensivkurs – Kursstruktur]] voraus.

## Kursziel

Teilnehmer des Grundkurses (M01–M08) erlernen die Planung und Visualisierung von Innenräumen in FreeCAD. Sie können Raumstrukturen modellieren, Grundrisse ableiten, Möblierungen platzieren und normgerechte Raumpläne mit Flächenberechnungen erstellen.

**FreeCAD-Version:** 1.0  
**Gesamtdauer:** ca. 10–12 Stunden (Intensivformat)  
**Voraussetzung:** [[M00 FreeCAD Intensivkurs – Kursstruktur]] (M01–M08) oder gleichwertige Kenntnisse  
**Sprache:** Deutsch (UI-Begriffe gemäß deutscher Lokalisierung)

---

## Workbench-Überblick für den Aufbaukurs

| Workbench | Zweck im Kurs |
|---|---|
| *BIM* | Hauptworkbench: Wände, Böden, Decken, Türen, Fenster, Räume |
| *Draft* | 2D-Hilfsgeometrie, Grundrissraster, Beschriftungen |
| *Sketcher* | Grundriss-Konturen, Sonderformen (Vorkenntnis aus Grundkurs) |
| *Arch* | In FreeCAD 1.0 in *BIM* integriert – kein separater Wechsel nötig |
| *TechDraw* | Normgerechte Pläne, Schnitte, Beschriftungen (Vorkenntnis aus M07) |
| *Spreadsheet* | Flächenberechnungen, Materialmengen, Stücklisten |

> [!info] BIM-Workbench in FreeCAD 1.0
> In FreeCAD 1.0 wurde die frühere *Arch*-Workbench vollständig in die *BIM*-Workbench überführt. Ältere Tutorials, die noch `Arch →` als Menüpfad zeigen, sind veraltet. Im Kurs wird ausschließlich `BIM →` verwendet.

---

## Modulübersicht

| #   | Modul                                       | Workbench            | Dauer   | Abhängigkeit |
| --- | ------------------------------------------- | -------------------- | ------- | ------------ |
| M11 | [[M11 – BIM-Workbench & Projektstruktur]]   | *BIM*                | 60 min  | M01–M04      |
| M12 | [[M12 – Wände, Böden & Decken]]             | *BIM*                | 90 min  | M11          |
| M13 | [[M13 – Türen & Fenster]]                   | *BIM*                | 60 min  | M12          |
| M14 | [[M14 – 2D-Grundriss mit Draft]]            | *Draft*, *BIM*       | 90 min  | M12          |
| M15 | [[M15 – Innenausstattung & Möblierung]]     | *BIM*, *Part Design* | 90 min  | M12          |
| M16 | [[M16 – Räume, Flächen & Stücklisten]]      | *BIM*, *Spreadsheet* | 60 min  | M13, M15     |
| M17 | [[M17 – Raumpläne & Schnitte mit TechDraw]] | *TechDraw*           | 90 min  | M14, M16     |
| M18 | [[M18 – Abschlussprojekt Innenraum]]        | alle                 | 120 min | M11–M17      |

---

## Detaillierte Modulbeschreibungen

### M11 – BIM-Workbench & Projektstruktur

**Lernziel:** Die *BIM*-Workbench kennenlernen, ein BIM-Projekt strukturieren und die grundlegenden Containerelemente (Building, Level, Space) anlegen.

**Inhalte:**
- Unterschied parametrisches CAD (*Part Design*) vs. BIM-Modellierung: Bauteile tragen semantische Information (Wand, Boden, Raum)
- BIM-Projektstruktur: `BIM → Gebäude erstellen`, `BIM → Ebene erstellen` (Building → Level → Objekte)
- Koordinatensystem und Maßeinheiten für Architektur einstellen (mm vs. m, Dezimalstellen)
- Arbeitsebene (Working Plane) setzen: `BIM → Arbeitsebene setzen`
- Raster aktivieren und konfigurieren: `Draft → Hilfsmittel → Raster umschalten`
- Modellbaum-Konventionen: Objekte per Drag & Drop den richtigen Ebenen zuordnen

**Neue Begriffe:**
- **BIM (Building Information Modeling):** Methode, bei der 3D-Geometrie mit Sachinformationen (Typ, Material, Fläche) verknüpft wird
- **Ebene (Level/BuildingPart):** Horizontaler Schnitt durch ein Gebäude (Stockwerk), der als Container für alle Bauteile eines Geschosses dient
- **Arbeitsebene:** Aktive 2D-Zeichenebene im 3D-Raum; bestimmt, wo neue Draft- und BIM-Objekte entstehen

**Tastenkürzel (Auswahl):**
- `9` – Arbeitsebene auswählen (Draft)
- `Leertaste` – Sichtbarkeit umschalten
- `Strg+G` – Objekte gruppieren

---

### M12 – Wände, Böden & Decken

**Lernziel:** Einen vollständigen Raumkörper (vier Wände, Boden, Decke) parametrisch modellieren und Wandparameter nachträglich ändern.

**Inhalte:**
- Wand erstellen: `BIM → Wand` – Wandverlauf durch Klicken oder über Sketcher-Profil
- Wandparameter: Höhe, Stärke, Ausrichtung (Mittellinie, Innen- oder Außenkante), Verbindungstyp
- Mehrere Wände verbinden: Koinzidenzpunkte und automatischer Wandverbund
- Boden (Slab) erstellen: `BIM → Platte` – aus Skizzenkontur oder Wandkontur ableiten
- Decke als Platte auf Wandoberkante
- Wandhöhe und Raumhöhe parametrisch ändern – Propagation beobachten
- Sichtbarkeit einzelner Bauteile für die Konstruktionsübersicht steuern

**Neue Begriffe:**
- **Wand (Wall):** BIM-Objekt mit Geometrie (Länge, Höhe, Stärke) und semantischer Eigenschaft (tragend, nicht tragend, Außen-/Innenwand)
- **Platte (Slab):** Horizontales Flächenbauteil für Boden oder Decke, definiert durch eine Kontur und eine Stärke

**Typisches Ergebnis:** Quaderförmiger Raum 4 × 3 m, 2,60 m Höhe, Wandstärke 12 cm, mit Boden und Decke

---

### M13 – Türen & Fenster

**Lernziel:** Normierte Öffnungen (Türen, Fenster) in Wände einsetzen, parametrisieren und variieren.

**Inhalte:**
- Fenster/Tür aus Bibliothek einfügen: `BIM → Fenster` – Preset wählen (Einfachfenster, Drehtür, Schiebetür)
- Platzierung: Klick auf Wandfläche, Einbauposition durch Bemaßung fixieren
- Parameter nachträglich anpassen: Breite, Höhe, Brüstungshöhe, Öffnungsrichtung
- Wandöffnung wird automatisch ausgeschnitten (parametrisch verknüpft)
- Eigenes Fenster aus Sketcher-Profil ableiten (Sonderform)
- Öffnungsdarstellung: 2D-Symbol vs. 3D-Geometrie umschalten

**Neue Begriffe:**
- **Preset:** Vordefiniertes Parameterschema für ein Standardbauteil (z. B. „Einfaches Fenster") – Werte werden bei der Platzierung überschrieben
- **Brüstungshöhe:** Vertikaler Abstand zwischen Rohboden und Fensterunterkante

> [!warning] Wandverknüpfung
> Fenster und Türen müssen beim Einfügen exakt auf der Wandfläche platziert werden, sonst erfolgt kein automatischer Wandausschnitt. Bei Fehlpositionierung: Objekt löschen und neu platzieren.

---

### M14 – 2D-Grundriss mit Draft

**Lernziel:** Einen präzisen 2D-Grundriss als eigenständige Zeichnung erstellen und als Basis für die 3D-Modellierung oder als Plan exportieren.

**Inhalte:**
- *Draft*-Workbench: Linie, Rechteck, Polylinie, Kreis, Bogen (`Draft → Zeichnen → …`)
- Fang-System (Snapping): Endpunkt, Mittelpunkt, Schnittpunkt, rechtwinklig – `Draft → Hilfsmittel → Fang umschalten`
- Maßhilfslinien und Beschriftungen: `Draft → Anmerkung`, `Draft → Bemaßung`
- Grundriss aus 2D-Draft-Geometrie zu 3D-Wänden extrudieren: `BIM → Wand` auf Polylinie anwenden
- Alternativweg: Grundriss aus bestehendem 3D-Modell ableiten: `BIM → Schnittebene` + `BIM → 2D-Ansicht`
- Exportieren als DXF für externe Nutzung: `Datei → Exportieren → DXF`

**Neue Begriffe:**
- **Fang (Snap):** Magnetisches Einrasten des Cursors auf exakt definierten Geometriepunkten – verhindert Ungenauigkeiten beim Zeichnen
- **Schnittebene (Section Plane):** Virtueller Schnitt durch das 3D-Modell, aus dem eine 2D-Ansicht abgeleitet wird

**Tastenkürzel (Auswahl):**
- `Strg` (beim Zeichnen) – Fang temporär deaktivieren
- `W` – Arbeitsebene auswählen
- `S` – Fang ein/aus (Draft)

---

### M15 – Innenausstattung & Möblierung

**Lernziel:** Standardmöbel aus der BIM-Bibliothek einsetzen und eigene Möbelobjekte mit *Part Design* modellieren und einpassen.

**Inhalte:**
- BIM-Bibliothek aufrufen: `BIM → Bibliothek` – Möbel, Leuchten, Sanitär aus der FreeCAD-Objektbibliothek laden
- Objekt positionieren und ausrichten: `BIM → Objekt verschieben`, Rotation über Properties Panel
- Einfaches Möbelstück selbst modellieren (Beispiel: Regal oder Tisch) mit *Part Design* Pad/Pocket
- Modelliertes Objekt als BIM-Komponente definieren: `BIM → Komponente erstellen`
- Mehrfaches Einsetzen desselben Objekts als verknüpfte Kopie (kein Datei-Overhead)
- Kollisionsprüfung: visuelle Kontrolle von Überschneidungen

**Neue Begriffe:**
- **BIM-Bibliothek:** Sammlung parametrischer Standardobjekte (Möbel, Einbauten, Sanitär) im FCC- oder STEP-Format, direkt aus FreeCAD abrufbar
- **Komponente (Component):** BIM-Objekt mit definierten Eigenschaften (IFC-Typ, Material, Beschreibung), das in Stücklisten und Flächenberechnungen erscheint

> [!tip] Workflow: Eigenmöbel
> Möbel in einem separaten FreeCAD-Dokument modellieren, als STEP exportieren und über `BIM → Bibliothek → Lokale Datei` ins Raumprojekt einbinden. So bleibt das Raumprojekt schlank und Möbel sind wiederverwendbar.

---

### M16 – Räume, Flächen & Stücklisten

**Lernziel:** Raumobjekte definieren, Nettoflächen automatisch berechnen und eine einfache Stückliste im Spreadsheet ausgeben.

**Inhalte:**
- Raum anlegen: `BIM → Raum` – Raumkontur durch Wandinnenkanten oder manuelle Polylinie
- Automatische Flächenberechnung: Raumeigenschaften im Properties Panel (Nettofläche, Raumvolumen)
- Raumbezeichnung und Raumstempel: `BIM → Raumbeschriftung`
- Spreadsheet-Workbench: `Spreadsheet → Tabelle erstellen`
- Raumflächen per Formel aus dem Modell auslesen: `=object.Area`
- Stückliste aller BIM-Objekte: `BIM → Stückliste` – Export als CSV oder in Spreadsheet

**Neue Begriffe:**
- **Raum (Space):** BIM-Objekt, das ein abgeschlossenes Raumvolumen repräsentiert und automatisch Fläche, Umfang und Volumen berechnet
- **Stückliste (Bill of Materials, BOM):** Tabellarische Auflistung aller Bauteile mit Typ, Anzahl, Fläche oder Volumen

> [!info] Flächenberechnung
> FreeCAD unterscheidet Bruttofläche (inkl. Wandstärken) und Nettofläche (lichte Maße). Für Wohnflächenberechnungen nach WoFlV ist stets die Nettofläche relevant – Raumobjekt immer an den Wandinnenkanten ausrichten.

---

### M17 – Raumpläne & Schnitte mit TechDraw

**Lernziel:** Aus dem 3D-Raummodell normgerechte Grundriss- und Schnittzeichnungen ableiten und bemaßen.

**Inhalte:**
- Grundrissschnitt erzeugen: `BIM → Schnittebene` auf Höhe ca. 1,0 m über Boden
- 2D-Ansicht aus Schnittebene ableiten: `BIM → 2D-Ansicht`
- 2D-Ansicht in TechDraw übernehmen: `TechDraw → Ansicht einfügen → Draft-Ansicht einfügen`
- Raumstempel und Beschriftungen aus BIM in TechDraw darstellen
- Schnittansicht (vertikal) für Wandhöhen und Sturzhöhen: `TechDraw → Schnittansicht einfügen`
- Bemaßung: Raummaße, Wandstärken, Türöffnungen (`TechDraw → Bemaßung → Längenmaß`)
- Maßstab wählen und Schriftfeld ausfüllen
- Export als PDF: `Datei → Exportieren → PDF`

**Neue Begriffe:**
- **Grundriss:** Horizontale Schnittdarstellung eines Gebäudes oder Raums in einer definierten Höhe (Norm: 1,0 m über Fertigfußboden)
- **Sturzmaß:** Höhe der Wandfläche über einer Türöffnung bis zur Deckenunterkante – relevant für die Schnittdarstellung

> [!tip] Saubere Liniengewichte
> In *TechDraw* → Einstellungen Liniengewichte für Schnittlinien (0,5 mm), sichtbare Kanten (0,35 mm) und verdeckte Kanten (0,18 mm) nach DIN 1356 einstellen, bevor Bemaßungen gesetzt werden.

---

### M18 – Abschlussprojekt Innenraum

**Lernziel:** Eigenständiger Entwurf und vollständige Dokumentation eines Innenraums vom Grundriss bis zum maßstäblichen Plan.

**Aufgabenstellung:** Planung eines Wohnzimmers oder Küche (ca. 20 m²) inklusive Möblierung, Öffnungen und Flächennachweis.

**Teilaufgaben:**

1. **Raumstruktur** (M12–M13): Vier Wände, Boden, Decke, mindestens eine Tür und ein Fenster – vollständig parametrisch
2. **Grundriss** (M14): 2D-Grundriss aus Schnittebene ableiten, Raster und Fangpunkte nutzen
3. **Möblierung** (M15): Mindestens 3 Möbelstücke – davon 1 aus der Bibliothek und 1 selbst modelliert
4. **Flächennachweis** (M16): Raum anlegen, Nettofläche berechnen, Stückliste aller Bauteile exportieren
5. **Plan** (M17): TechDraw-Seite A3, Grundriss 1:50, eine Schnittansicht, vollständige Bemaßung, Schriftfeld

**Selbstkontrolle-Checkliste:**
- [ ] Alle Wände verbunden (kein Spalt im Grundriss)
- [ ] Türen und Fenster mit korrektem Wandausschnitt
- [ ] Raumobjekt zeigt plausible Nettofläche (Abweichung < 2 % vom Handrechenmaß)
- [ ] Grundriss-Maßkette geschlossen (Gesamtmaß = Summe der Teilmaße)
- [ ] Schriftfeld vollständig ausgefüllt
- [ ] PDF exportiert und geöffnet (Druckbild prüfen)

> [!tip] Referenzmodell
> Ein Referenz-FreeCAD-Dokument als FCStd-Datei im Kursprojekt hinterlegen, damit Teilnehmer ihr Ergebnis mit der Musterlösung vergleichen können. Separate Dateien für Raumstruktur und Möblierung empfehlenswert.

---

## Didaktische Hinweise

### Abgrenzung zum Grundkurs

| Aspekt | Grundkurs (M01–M08) | Aufbaukurs (M11–M18) |
|---|---|---|
| Modellierungsparadigma | Feature-basiert (Skizze → Volumenkörper) | Bauteil-basiert (semantische BIM-Objekte) |
| Primäre Geometriequelle | Sketcher-Skizzen | Direkte BIM-Befehle + Draft |
| Maßstab | Einzelteil (mm–cm) | Raum / Gebäude (m) |
| Ziel-Output | Technische Zeichnung eines Bauteils | Raumplan, Flächennachweis |
| Datenstruktur | Body → Features | Building → Level → Spaces → Objekte |

### Empfohlene Einheiteneinstellung

Vor dem ersten Arbeiten in *BIM* Einheiten auf **Meter** oder **Zentimeter** umstellen:  
`Bearbeiten → Voreinstellungen → Allgemein → Einheiten → Architektur (cm)`.  
Die Anzeige in cm ist praxisnah; intern rechnet FreeCAD immer in mm.

### Bekannte Stolpersteine

> [!warning] Arbeitsebene vergessen
> Der häufigste Anfängerfehler in *BIM*: Wände entstehen auf der falschen Ebene, weil die Arbeitsebene nicht gesetzt wurde. Als Einstiegsritual etablieren: *immer erst Arbeitsebene prüfen, dann zeichnen*.

> [!warning] BIM-Objekte in Part Design bearbeiten
> BIM-Wände sind **keine** Part-Design-Bodies. Sie können nicht mit Pad/Pocket bearbeitet werden. Für Sonderformen (Nischen, Wandschrägungen) entweder die Wandkontur als Sketcher-Profil definieren oder einen separaten Part-Design-Body als Booleschen Subtrahanden verwenden.

> [!warning] Alte Arch-Tutorials
> Viele Online-Ressourcen zeigen noch `Arch → Wand` (FreeCAD < 1.0). Der Menüpfad lautet in FreeCAD 1.0 `BIM → Wand`. Funktionsumfang ist identisch oder erweitert.

---

## Querverweise & Ressourcen

- [[M00 FreeCAD Intensivkurs – Kursstruktur]] – Voraussetzungskurs
- [[Glossar FreeCAD]] – Bestehende Fachbegriffe (wird um BIM-Begriffe ergänzt)
- [[Cheat Sheet – Tastenkürzel]] – Ergänzung um Draft- und BIM-Shortcuts geplant
- [FreeCAD BIM Dokumentation](https://wiki.freecad.org/BIM_Workbench) – Offizielle Referenz (EN)
- [FreeCAD BIM Tutorial](https://wiki.freecad.org/BIM_ingame_tutorial) – Offizielles Einsteiger-Tutorial (EN)
- [NativeIFC in FreeCAD](https://wiki.freecad.org/NativeIFC) – Weiterführend: IFC-Export für Datenaustausch mit ArchiCAD, Revit

---

## Konventionen (identisch zum Grundkurs)

| Element | Format | Beispiel |
|---|---|---|
| Menüoperation | Pfad in Backticks | `BIM → Wand` |
| Nur-Symbolleisten-Operation | Bild + Name | `![[BIM_Wall.svg]] Wand` |
| Tastenkürzel | Backticks | `S` |
| Workbench | Kursiv | *BIM* |
| Interner Link | Doppelklammer | `[[M12 – Wände, Böden & Decken]]` |
| Hinweis | Obsidian-Callout | `> [!warning]` |

---

## Offene Punkte / Erweiterungsoptionen

> [!info] Optionale Zusatzmodule (nicht im Intensivformat)
> - **M19 – Materialien & Visualisierung:** Flächen mit Texturen versehen, einfaches Rendering mit dem integrierten Renderer
> - **M20 – IFC-Export & Datenaustausch:** Modell als IFC exportieren, Kompatibilität mit ArchiCAD / Revit / BIM-Viewer
> - **M21 – Licht & Kamera:** Szenenbeleuchtung, Kamerafahrt für Präsentation
> Diese Module sprengen das Intensivformat (je 90+ min) und sind als eigenständiger Vertiefungskurs gedacht.
