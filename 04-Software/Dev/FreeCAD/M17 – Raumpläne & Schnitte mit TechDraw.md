# M17 – Raumpläne & Schnitte mit TechDraw

> [!info] Modulübersicht
> **Workbench:** *BIM*, *TechDraw*
> **Dauer:** 90 min
> **Voraussetzung:** [[M14 – 2D-Grundriss mit Draft]], [[M16 – Räume, Flächen & Stücklisten]]
> **Lernziel:** Aus dem 3D-Raummodell normgerechte Grundriss- und Schnittzeichnungen ableiten, bemaßen und als PDF exportieren.

---

## Einführung & Demonstration

### Konzept: Vom 3D-Modell zum Plan

*TechDraw* übernimmt im Aufbaukurs dieselbe Rolle wie in M07 – jedoch ist die Quelle kein Part-Design-Einzelteil, sondern ein BIM-Raummodell aus mehreren Objekten. Daraus folgen zwei Besonderheiten:

**Besonderheit 1 – Grundriss als Schnittebene:** Ein Grundriss ist definitionsgemäß ein horizontaler Schnitt auf 1,0 m Höhe über dem Fertigfußboden. Dieser Schnitt existiert im 3D-Modell bereits als `BIM → Schnittebene`. *TechDraw* bindet die Schnittebene direkt als Ansicht ein – kein manuelles Projizieren nötig.

**Besonderheit 2 – Zwei Ansichtstypen:** BIM-Objekte (Wände, Platten, Türen) werden über ![[TechDraw_ArchView.svg]] `Arch-Schnittebene einfügen` in *TechDraw* übernommen. Für vertikale Schnitte durch das 3D-Modell kommt die bekannte ![[TechDraw_SectionView.svg]] `Schnittansicht einfügen` zum Einsatz.

### Übersicht: Workflow M17

```
BIM-Modell (3D)
  └─ BIM → Schnittebene (auf 1,0 m Höhe)          ← Grundrissschnitt
       └─ TechDraw → Arch-Schnittebene einfügen    ← Grundriss-Ansicht
  └─ TechDraw → Ansicht einfügen (3D-Objekte)      ← Basis für Schnittansicht
       └─ TechDraw → Schnittansicht einfügen        ← Vertikalschnitt
  └─ Bemaßung, Schriftfeld, PDF-Export
```

---

### Demonstration: Grundriss-Plan A3 aus einem Raummodell

Ausgangssituation: BIM-Modell mit vier Wänden, Boden, Decke, einer Tür und einem Fenster (aus M12–M13), Raumobjekt aus M16.

#### Schritt 1 – Schnittebene im BIM-Modell setzen

1. Workbench *BIM* aktivieren.
2. Im Modellbaum den Level des Raums auswählen.
3. `BIM → Schnittebene` aufrufen.
4. Im Aufgabenbereich erscheint der Dialog **Schnittebene**:
   - **Methode:** `Orthogonal`
   - **Richtung:** `Von oben` (Draufsicht = Grundriss)
5. Die Schnittebene im 3D-Viewport auf **1000 mm** über dem Boden positionieren – entweder durch Klick auf die Bodenfläche und anschließende Eingabe im Properties Panel (`Z = 1000 mm`) oder durch direktes Eingeben beim Platzieren.
6. Bestätigen. Im Modellbaum erscheint `Section`.

> [!info] Normhöhe Grundrissschnitt
> DIN 1356 schreibt keine feste Höhe vor, der übliche Wert ist **1,0 m über Fertigfußboden** – hoch genug, um Fensterbrüstungen und Türöffnungen zu schneiden, aber unterhalb der Türstürze.

> [!tip] Schnittebene nachträglich verschieben
> Position und Richtung der Schnittebene lassen sich jederzeit im Properties Panel ändern. Die *TechDraw*-Ansicht aktualisiert sich nach `TechDraw → Seite neu zeichnen` automatisch.

#### Schritt 2 – TechDraw-Seite anlegen

1. Workbench *TechDraw* aktivieren.
2. `TechDraw → Seite einfügen → Seite aus Vorlage einfügen`.
3. Im Dateidialog Vorlage wählen: `A3_Landscape_ISO7200_Pstep.svg` (A3 quer, ISO-Schriftfeld).
4. Die leere Zeichenseite öffnet sich im Ansichtsfenster.

> [!info] Liniengewichte vorab einstellen
> Vor dem Einfügen der ersten Ansicht Liniengewichte nach DIN 1356 setzen:
> `Bearbeiten → Voreinstellungen → TechDraw → Linien`
> - Schnittlinie: **0,50 mm**
> - Sichtbare Kante: **0,35 mm**
> - Verdeckte Kante: **0,18 mm**
> Nachträgliches Anpassen ist aufwändig.

#### Schritt 3 – Grundrissansicht aus Schnittebene einfügen

1. Im Modellbaum die Schnittebene `Section` auswählen.
2. `TechDraw → Ansichten → Arch-Schnittebene einfügen` (`![[TechDraw_ArchView.svg]]`).
3. Im Aufgabenbereich:
   - **Maßstab:** `0.02` (entspricht 1:50 – für A3 und einen 4×3-m-Raum gut geeignet)
   - **Linienstärke:** entsprechend den voreingestellten Werten
4. Bestätigen. Die Grundrissansicht erscheint auf der Seite.
5. Ansicht per Drag & Drop auf der Seite positionieren (linksseitig, Platz für Schnittansicht rechts lassen).

> [!tip] Maßstab wählen
> Faustformel: Raumbreite in mm ÷ nutzbare Blattbreite in mm = Maßstabsfaktor.
> Beispiel: 4000 mm Raum, ~300 mm nutzbare Blattbreite → 4000 / 300 ≈ 13 → Maßstab 1:20 (Faktor 0,05) oder 1:50 (Faktor 0,02).

#### Schritt 4 – Vertikale Schnittansicht einfügen

Die vertikale Schnittansicht zeigt Wandhöhen, Sturzmaße und Deckenstärke.

1. Im Modellbaum alle Wände, Boden und Decke per `Strg+Klick` auswählen.
2. `TechDraw → Ansichten → Ansicht einfügen` (`![[TechDraw_View.svg]]`) – erzeugt eine 3D-Basisansicht der ausgewählten Objekte.
3. **Maßstab** auf `0.02` setzen, **Richtung** auf Vorderansicht (`Num 1`). Bestätigen.
4. Diese Basisansicht in der *TechDraw*-Seite anklicken (blauer Rahmen).
5. `TechDraw → Ansichten → Schnittansicht einfügen` (`![[TechDraw_SectionView.svg]]`).
6. Im Dialog:
   - **Schnittebene:** per Klick zwei Punkte setzen – quer durch den Raum, mittig durch eine Türöffnung.
   - **Richtung:** Pfeil nach rechts oder links (Blickrichtung des Betrachters).
7. Bestätigen. Schnittansicht rechts neben dem Grundriss platzieren.

> [!info] **Sturzmaß** – neuer Begriff
> Das **Sturzmaß** ist die Höhe der Wandfläche über einer Tür- oder Fensteröffnung bis zur Deckenunterkante. Im vertikalen Schnitt direkt ablesbar und zu bemaßen.

> [!warning] Basisansicht nicht löschen
> Die unter Schritt 4 erzeugte Basisansicht (Vorderansicht) ist die Elternansicht der Schnittansicht. Wird sie gelöscht, verschwindet die Schnittansicht ebenfalls. Sie kann auf der Seite ausgeblendet werden (`Leertaste`), muss aber im Modellbaum erhalten bleiben.

#### Schritt 5 – Bemaßung setzen

Ziel: vollständige Maßkette für Raumbreite und -tiefe im Grundriss, Raumhöhe und Sturz im Schnitt.

**Grundriss bemaßen:**

1. Grundrissansicht anklicken.
2. `TechDraw → Bemaßung → Horizontales Maß einfügen` (`![[TechDraw_HorizontalDimension.svg]]`).
3. Nacheinander linke und rechte Außenkante der Wände anklicken → Maß erscheint. Position durch Ziehen anpassen.
4. Für Wandstärke: dieselbe Operation auf Außen- und Innenkante einer Wand → Teilmaß entsteht.
5. Raumtiefe analog mit `TechDraw → Bemaßung → Vertikales Maß einfügen` (`![[TechDraw_VerticalDimension.svg]]`).
6. Türbreite bemaßen: Öffnungskanten im Grundriss anklicken → Horizontales Maß.

**Schnittansicht bemaßen:**

1. Schnittansicht anklicken.
2. Raumhöhe: `TechDraw → Bemaßung → Vertikales Maß einfügen` – Oberkante Boden bis Unterkante Decke.
3. Sturzhöhe: Oberkante Türöffnung bis Deckenunterkante – ebenfalls vertikales Maß.
4. Wandstärke im Schnittbild: horizontales Maß auf die schraffierte Wandfläche.

> [!tip] Maßtext nachträglich bearbeiten
> Doppelklick auf ein Maß öffnet den Formelassistenten. Hier lassen sich Präfixe (`∅`, `R`) und Toleranzangaben ergänzen, ohne das Maß neu zu setzen.

> [!warning] Referenzverlust nach Modelländerung
> Wird das 3D-Modell nach dem Bemaßen geändert (z. B. Wandhöhe angepasst), können Maße ihre Referenz verlieren (orangefarbener Rahmen). `![[TechDraw_DimensionRepair.svg]] Maß reparieren` (`TechDraw → Bemaßung → Maß reparieren`) stellt die Verknüpfung wieder her.

#### Schritt 6 – Raumstempel aus BIM darstellen

Der in M16 angelegte Raum (`Space`) trägt Name und Fläche als Eigenschaften. Diese lassen sich als Annotation in den Grundriss übernehmen:

1. In der *TechDraw*-Seite in den Bereich der Grundrissansicht klicken.
2. `TechDraw → Anmerkungen → Anmerkung einfügen` (`![[TechDraw_Annotation.svg]]`).
3. Text eingeben: Raumname und Fläche manuell eintragen (z. B. `Wohnzimmer\n20,14 m²`).
4. Schriftgröße auf planübliche 2,5 mm (bei Maßstab 1:50 entspricht das 125 mm in der Zeichnung) einstellen.

> [!info] Automatische Raumstempel
> Eine vollautomatische Übernahme des Raumnamens und der berechneten Fläche aus dem BIM-Modell in TechDraw ist in FreeCAD 1.0 noch nicht über eine dedizierte Funktion gelöst. Der manuelle Weg über `Anmerkung einfügen` ist der zuverlässigste Ansatz im Kurskontext.

#### Schritt 7 – Schriftfeld ausfüllen

1. `TechDraw → Vorlagenfelder ausfüllen` (`![[TechDraw_FillTemplateFields.svg]]`).
2. Felder befüllen:

| Feld | Beispielwert |
|---|---|
| Titel | `Wohnzimmer – Grundriss und Schnitt` |
| Maßstab | `1:50` |
| Datum | `17.03.2026` |
| Bearbeiter | Eigener Name |
| Blattnummer | `1` |

3. Bestätigen. Schriftfeld wird aktualisiert.

#### Schritt 8 – Export als PDF

`Datei → Exportieren` → Dateityp `PDF (*.pdf)` wählen → Speichern.

Alternativ über `TechDraw → Exportieren → Seite als SVG exportieren` für eine skalierbare Vektorgrafik.

> [!tip] Druckbild vor Export prüfen
> `TechDraw → Alle Seiten drucken` öffnet den Druckdialog ohne sofortiges Drucken. Dort Seitenvorschau aufrufen und prüfen, ob alle Elemente innerhalb des Druckbereichs liegen.

---

## Übungsteil

### Aufgabe 1 – Grundriss auf A3 ableiten ⬜ leicht

**Ziel:** Einen vollständigen Grundriss des BIM-Raums aus M12/M13 auf einer A3-Seite darstellen.

**Voraussetzung:** BIM-Modell mit Wänden, Boden, Decke, mindestens einer Tür und einem Fenster.

**Schritte:**
1. *BIM*-Workbench: Schnittebene auf 1000 mm Höhe setzen (`BIM → Schnittebene`).
2. *TechDraw*-Workbench: A3-Seite mit ISO-Vorlage anlegen.
3. Liniengewichte in den Voreinstellungen setzen (Schnittlinie 0,50 mm, sichtbare Kante 0,35 mm).
4. Schnittebene im Modellbaum auswählen → `TechDraw → Ansichten → Arch-Schnittebene einfügen`, Maßstab 1:50.
5. Ansicht linksseitig auf der Seite positionieren.

**Erwartetes Ergebnis:** Grundrissansicht mit Wandkonturen (schraffiert), Türöffnung und Fenster-Symbol auf A3-Seite, Maßstab 1:50.

---

### Aufgabe 2 – Vollständige Bemaßung des Grundrisses ⬜ mittel

**Ziel:** Den Grundriss aus Aufgabe 1 mit einer vollständigen, geschlossenen Maßkette versehen.

**Schritte:**
1. Außenmaß Raumbreite: horizontales Maß über die gesamte Außenwandbreite.
2. Außenmaß Raumtiefe: vertikales Maß über die gesamte Außenwandtiefe.
3. Wandstärken: je eine Teilmaß-Kette für Außenwand-links, lichte Weite und Außenwand-rechts (Summe = Außenmaß).
4. Türbreite: horizontales Maß zwischen den Öffnungskanten.
5. Fensterbreite und Fensterposition zur nächsten Wand bemaßen.
6. Prüfen: Gesamtmaß = Summe der Teilmaße (geschlossene Maßkette).

**Erwartetes Ergebnis:** Grundriss mit drei Maßketten (Außenmaß, Wandstärken/Lichtweiten, Öffnungsmaße). Alle Maße stimmen numerisch überein.

> [!tip] Maßkette effizient setzen
> Für gestaffelte Kettenmaße statt Einzelmaßen: `TechDraw → Erweiterungen → Bemaßung → Horizontale Kettenmaße` (`![[TechDraw_ExtensionCreateHorizChainDimension.svg]]`) – wählt man mehrere Punkte nacheinander, erzeugt FreeCAD die gesamte Maßkette automatisch.

---

### Aufgabe 3 – Vertikaler Schnitt mit Höhenmaßen ⬜ mittel

**Ziel:** Einen vertikalen Längsschnitt erstellen, der Raumhöhe, Sturzhöhe und Bodenaufbau zeigt.

**Schritte:**
1. Alle Wände, Boden und Decke im Modellbaum auswählen.
2. `TechDraw → Ansichten → Ansicht einfügen`, Richtung Vorderansicht, Maßstab 1:50. Ansicht außerhalb des Blattsichtbereichs platzieren (wird später ausgeblendet).
3. Basisansicht anklicken → `TechDraw → Ansichten → Schnittansicht einfügen`. Schnittlinie mittig durch den Raum, durch die Türöffnung legen.
4. Bemaßung:
   - Raumhöhe lichte (Oberkante Fertigboden bis Unterkante Decke)
   - Sturzhöhe (Oberkante Türöffnung bis Deckenunterkante)
   - Deckendicke
   - Bodendicke (falls modelliert)
5. Basisansicht im Modellbaum markieren → `Leertaste` → ausblenden (Ansicht unsichtbar, aber erhalten).

**Erwartetes Ergebnis:** Vertikale Schnittansicht mit vier Höhenkoten, Türöffnung mit Sturzkote, schraffierte Schnittflächen in Wänden, Boden und Decke.

---

### Aufgabe 4 – Raumstempel und Schriftfeld ⬜ leicht

**Ziel:** Raumbezeichnung und Fläche in den Grundriss eintragen, Schriftfeld vollständig ausfüllen.

**Schritte:**
1. Raumfläche aus M16 ablesen (Properties Panel des Space-Objekts oder Spreadsheet).
2. In *TechDraw*: Anmerkung mittig im Raumbereich des Grundrisses platzieren, Text:
   ```
   Wohnzimmer
   20,14 m²
   ```
3. Schriftfeld via `TechDraw → Vorlagenfelder ausfüllen` befüllen (Titel, Maßstab 1:50, Datum, Name).
4. Export als PDF, Datei öffnen und Druckbild prüfen.

**Erwartetes Ergebnis:** Fertiger Plan auf A3, Raumstempel lesbar im Grundriss, Schriftfeld vollständig, PDF korrekt exportiert.

---

### Aufgabe 5 – Detailansicht Wandanschluss ⬜ anspruchsvoll

**Ziel:** Einen vergrößerten Ausschnitt des Wandanschlusses (Ecke Wand–Boden) als Detailansicht erstellen und Wandstärke sowie Bodenaufbau bemaßen.

**Schritte:**
1. In der bestehenden Grundrissansicht eine Raumecke als Detailbereich auswählen.
2. `TechDraw → Ansichten → Detailansicht einfügen` (`![[TechDraw_DetailView.svg]]`): Kreis um die Raumecke ziehen, Maßstab `0.10` (1:10).
3. Detailansicht auf der Seite positionieren (z. B. rechts unten).
4. Wandstärke, Bodendicke und Wandinnenkante bemaßen.
5. Hinweislinie von der Detailansicht zur Hauptansicht: `TechDraw → Anmerkungen → Hinweislinie einfügen` (`![[TechDraw_LeaderLine.svg]]`).

**Erwartetes Ergebnis:** Detailkreis in der Grundrissansicht, separate Detailansicht M 1:10 mit drei Maßen, Hinweislinie zum Detailbereich.

---

## Neue Begriffe

- **Grundriss:** Horizontale Schnittdarstellung eines Raums oder Gebäudes in einer definierten Höhe (Norm: 1,0 m über Fertigfußboden). Zeigt Wandverläufe, Öffnungen und Möblierung.
- **Sturzmaß:** Höhe der Wandfläche über einer Tür- oder Fensteröffnung bis zur Deckenunterkante – in der Schnittansicht als vertikales Maß ablesbar.
- **Maßkette:** Folge von Teilmaßen, die zusammen ein Gesamtmaß ergeben. Korrekte Maßkette: Summe der Teilmaße = Gesamtmaß.
- **Arch-Schnittebene (TechDraw):** Spezieller Ansichtstyp in *TechDraw*, der eine BIM-Schnittebene (Wände, Platten, Türen) als 2D-Grundriss darstellt – im Unterschied zur normalen Ansicht, die 3D-Geometrie projiziert.

---

## Zusammenfassung

| Aufgabe | Werkzeug |
|---|---|
| Schnittebene im BIM anlegen | `BIM → Schnittebene` |
| Grundriss in TechDraw einfügen | `TechDraw → Ansichten → Arch-Schnittebene einfügen` |
| Basisansicht für Vertikalschnitt | `TechDraw → Ansichten → Ansicht einfügen` |
| Vertikaler Schnitt | `TechDraw → Ansichten → Schnittansicht einfügen` |
| Kettenmaße automatisch | `TechDraw → Erweiterungen → Bemaßung → Horizontale Kettenmaße` |
| Detailausschnitt | `TechDraw → Ansichten → Detailansicht einfügen` |
| Schriftfeld | `TechDraw → Vorlagenfelder ausfüllen` |
| PDF-Export | `Datei → Exportieren → PDF` |

---

## Querverweise

- [[M14 – 2D-Grundriss mit Draft]] – Schnittebene und 2D-Ansicht in BIM
- [[M16 – Räume, Flächen & Stücklisten]] – Raumobjekt mit Flächenwert
- [[M07 – Technische Zeichnung]] – TechDraw-Grundlagen aus dem Grundkurs
- [[TechDraw – Symbolleistenreferenz]] – Vollständige Befehlsreferenz
- [[Glossar FreeCAD#Schnittansicht (Section View)]]
- [[Glossar FreeCAD#Bemaßung]]
- [[Glossar FreeCAD#Schriftfeld (Title Block)]]
- [[M18 – Abschlussprojekt Innenraum]]
