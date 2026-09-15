# M07 – Technische Zeichnung

> [!info] Modulübersicht
> **Workbench:** *TechDraw* | **Dauer:** 90 min | **Voraussetzung:** [[M04 – Part Design Grundlagen]]
> **Lernziel:** Aus einem 3D-Modell eine normgerechte technische Zeichnung mit Ansichten, Schnitt und Bemaßung ableiten.

---

## 1 – Konzept: Von 3D zu 2D

Eine **technische Zeichnung** (engl. *engineering drawing*) ist die normierte 2D-Darstellung eines 3D-Modells. Sie enthält alle fertigungsrelevanten Informationen: Form, Maße, Toleranzen, Oberflächen.

*TechDraw* übernimmt die Geometrie direkt aus dem 3D-Modell – Maße sind mit den Sketcher-Constraints verknüpft und aktualisieren sich automatisch, wenn das Modell geändert wird.

### Projektionsnorm

Technische Zeichnungen folgen einer von zwei Normen:

| Norm | Verbreitung | Prinzip |
|---|---|---|
| **Europäische Projektion (E)** | Europa, ISO/DIN | Ansicht erscheint auf der Seite, von der man schaut |
| **Amerikanische Projektion (A)** | USA, ANSI | Ansicht erscheint gegenüber der Schaurichtung |

> [!tip] Kursstandard
> Im Kurs verwenden wir die **Europäische Projektion** (DIN-Norm). Einstellung: `Bearbeiten → Einstellungen → TechDraw → Allgemein → Projektionsmethode → Europäisch`.

### Arbeitsreihenfolge in *TechDraw*

```
Seite anlegen → Hauptansicht → weitere Ansichten → Schnitt → Bemaßung → Schriftfeld → Export
```

---

## 2 – Demonstration: Zeichnung eines Flanschteils

Als Ausgangsmaterial dient ein einfacher Flansch: ein zylindrischer Körper mit Bohrungen auf einem Lochkreis, modelliert mit *Part Design*.

### 2.1 Zeichnungsseite anlegen

1. Workbench zu *TechDraw* wechseln.
2. `TechDraw → Seite einfügen → Seite aus Vorlage einfügen` ausführen.
3. Im Dialog eine A3-Querformat-Vorlage wählen (z. B. `A3_Landscape_ISO7200.svg`).
4. Die leere Seite mit Schriftfeld erscheint in der 3D-Ansicht und im Modellbaum unter `Page`.

> [!info] Seitenvorlagen
> FreeCAD liefert fertige SVG-Vorlagen für A0–A4 im ISO-7200-Format (mit Schriftfeld). Die Vorlagen enthalten editierbare Felder für Teilename, Zeichnungsnummer, Maßstab, Bearbeiter und Datum.

### 2.2 Projektionsgruppe einfügen

Eine **Projektionsgruppe** erzeugt automatisch mehrere orthogonale Ansichten aus einer Hauptansicht heraus und hält deren Ausrichtung zueinander synchron.

1. Im Modellbaum das 3D-Modell (Body) auswählen.
2. `TechDraw → Ansichten → Projektionsgruppe einfügen` ausführen.
3. Im Aufgabenbereich:
   - **Primäre Ansicht:** `Vorne` wählen
   - **Projektionsmethode:** Europäisch
   - Zusätzliche Ansichten aktivieren: `Oben`, `Rechts`
   - Maßstab: `1:1` (oder `1:2` bei großen Teilen)
4. Mit **OK** bestätigen.

Die drei Ansichten erscheinen auf der Seite und sind als Gruppe verknüpft – Verschieben der Hauptansicht repositioniert alle anderen automatisch.

> [!tip] Ansichten nachträglich hinzufügen
> Weitere Ansichten lassen sich über `TechDraw → Ansichten → Ansicht einfügen` an eine bestehende Projektionsgruppe koppeln: Projektionsgruppe im Modellbaum markieren, dann Ansicht einfügen.

### 2.3 Schnittansicht erzeugen

Eine **Schnittansicht** (engl. *section view*) legt das Modell entlang einer Ebene auf und zeigt innere Strukturen. Schnittflächen werden schraffiert dargestellt.

1. Die **Vorderansicht** auf der Zeichenseite anklicken (wird markiert).
2. `TechDraw → Ansichten → Schnittansicht einfügen` ausführen.
3. Im Aufgabenbereich:
   - **Schnittlinie:** Position durch Klick auf die Vorderansicht festlegen (z. B. durch die Mittelachse des Flansches)
   - **Richtung:** `Rechts` (Schnitt wird von rechts betrachtet)
   - Maßstab übernehmen: `Aus Gruppe`
4. Mit **OK** bestätigen.

Die Schnittansicht erscheint neben der Vorderansicht. Die Schnittlinie ist in der Quellansicht als gestrichelte Linie mit Pfeilen sichtbar.

> [!warning] Schraffur
> Schraffurmuster erscheinen standardmäßig als 45°-Linien. Für die Darstellung kann das Muster über Rechtsklick → `Fläche bearbeiten` angepasst werden.

### 2.4 Mittellinien hinzufügen

Rotationssymmetrische Teile erhalten Mittellinien (strichpunktierte Linie, Linientyp `Center`).

1. Kreisfläche oder Bohrung in einer Ansicht anklicken.
2. ![[TechDraw_ExtensionCircleCenterLines.svg]] `TechDraw → Erweiterungen → Mittellinien → Kreismittellinien` ausführen.
3. Für alle Bohrungen des Lochkreises: mehrere Bohrungen mit `Strg`+Klick auswählen, dann ![[TechDraw_ExtensionHoleCircle.svg]] `TechDraw → Erweiterungen → Mittellinien → Lochkreis-Mittellinien` ausführen.

### 2.5 Bemaßung setzen

Bemaßungen werden durch Anklicken von Kanten oder Punkten in einer Ansicht gesetzt. Die Maßzahlen stammen direkt aus der 3D-Geometrie.

**Längenmaß (Gesamthöhe des Flansches):**
1. Obere und untere Kante in der Vorderansicht mit `Strg`+Klick auswählen.
2. ![[TechDraw_LengthDimension.svg]] `TechDraw → Bemaßung → Längenmaß einfügen`.
3. Maßlinie durch Ziehen positionieren.

**Durchmessermaß (Außendurchmesser):**
1. Den Außenkreis in der Draufsicht anklicken.
2. ![[TechDraw_DiameterDimension.svg]] `TechDraw → Bemaßung → Durchmessermaß einfügen`.

**Radiusmaß (Verrundung):**
1. Den Bogen anklicken.
2. ![[TechDraw_RadiusDimension.svg]] `TechDraw → Bemaßung → Radiusmaß einfügen`.

> [!warning] Maßreferenz prüfen
> Maße sollten immer mit der 3D-Geometrie verknüpft sein. Bei gelber Anzeige einer Maßzahl: Maß anklicken → ![[TechDraw_DimensionRepair.svg]] `TechDraw → Bemaßung → Maß reparieren`.

### 2.6 Schriftfeld ausfüllen

1. `TechDraw → Vorlagenfelder ausfüllen` ausführen.
2. Im Dialog die Felder befüllen:

| Feld | Inhalt (Beispiel) |
|---|---|
| `TITLE` | Flansch DN50 |
| `DRAWING_NUMBER` | 001 |
| `SCALE` | 1:1 |
| `AUTHOR` | Eigener Name |
| `DATE` | Aktuelles Datum |

3. Mit **OK** bestätigen. Die Felder im Schriftfeld aktualisieren sich sofort.

### 2.7 Als PDF exportieren

`Datei → Exportieren` → Dateityp `PDF (*.pdf)` wählen → Speichern.

---

## 3 – Übungen

### Übung 1 – Erste Zeichnung (Grundstufe)

**Ziel:** Eine vollständige Dreifach-Ansicht eines einfachen Körpers erstellen.

**Ausgangslage:** Ein quaderförmiger Körper mit einer zentrischen Bohrung (aus M04 oder selbst modelliert: 60 × 40 × 25 mm, Bohrung Ø12 mm, zentrisch).

**Aufgabe:**

1. Neues TechDraw-Dokument: Seite A4 Querformat mit ISO-Vorlage anlegen.
2. Projektionsgruppe mit Vorder-, Drauf- und Seitenansicht einfügen, Maßstab 1:1.
3. Folgende Maße setzen:
   - Gesamtlänge 60 mm
   - Gesamtbreite 40 mm
   - Gesamthöhe 25 mm
   - Bohrungsdurchmesser Ø12
4. Mittellinie der Bohrung in der Draufsicht einfügen.
5. Schriftfeld ausfüllen (Titel, Maßstab, Datum).

**Erwartetes Ergebnis:** A4-Zeichnung mit drei korrekt ausgerichteten Ansichten, 4 Maßen, Mittellinie und ausgefülltem Schriftfeld.

---

### Übung 2 – Schnittansicht (Mittelstufe)

**Ziel:** Innenliegende Geometrie durch eine Schnittansicht sichtbar machen und bemaßen.

**Ausgangslage:** Ein Hohlzylinder: Außen-Ø 60 mm, Innen-Ø 40 mm, Höhe 50 mm, mit einer Fase 2×45° an der Öffnung (aus M04/M05 oder selbst modellieren).

**Aufgabe:**

1. A3-Zeichnung anlegen, Projektionsgruppe mit Vorder- und Draufsicht (Maßstab 1:1).
2. Axiale Schnittansicht durch die Mittelachse erzeugen (von rechts betrachtet).
3. Bemaßungen setzen:
   - Außendurchmesser Ø60 und Innendurchmesser Ø40 in der Schnittansicht
   - Gesamthöhe 50 mm
   - Fase 2×45° (Längenmaß 2 mm an der abgeschrägten Kante)
4. Mittellinien für Außen- und Innenkreis in der Draufsicht einfügen.
5. Schriftfeld ausfüllen.

**Hinweis:** Die Schnittansicht zeigt die Wandstärke direkt. Maße dort setzen, wo sie am klarsten lesbar sind.

**Erwartetes Ergebnis:** Schnittansicht mit sichtbarer Wandstärke, schraffiertem Schnittbereich, 5 Maßen und Mittellinien.

---

### Übung 3 – Vollständige Fertigungszeichnung (Vertiefung)

**Ziel:** Eine fertigungsreife Zeichnung mit allen notwendigen Informationen erstellen.

**Ausgangslage:** Das Drehteil aus [[M05 – Part Design Vertiefung]] (oder ein eigenes Drehteil mit mindestens einer Bohrung, einer Verrundung und einer Fase).

**Aufgabe:**

1. A3-Zeichnung anlegen.
2. Ansichten planen und erzeugen:
   - Hauptansicht (Vorderansicht, zeigt Rotationsprofil)
   - Axiale Schnittansicht (zeigt Innenkontur vollständig)
   - Draufsicht (zeigt Lochbild / Bohrungsanordnung)
3. Vollständige Bemaßung: alle Maße, die zur eindeutigen Fertigung notwendig sind (kein Maß redundant, kein Maß fehlend).
   - Längen- und Durchmessermaße im Schnitt
   - Bohrungsmaße in der Draufsicht mit Wiederholungszeichen (![[TechDraw_ExtensionInsertRepetition.svg]] `n×`) falls mehrfach vorhanden
4. Mittellinien an allen Kreisen und Bohrungen.
5. Schriftfeld vollständig ausfüllen.
6. Als PDF exportieren.

**Selbstkontrolle:**
- Ist jedes Feature (Bohrung, Fase, Verrundung) bemaßt?
- Sind Mittellinien an allen rotationssymmetrischen Elementen vorhanden?
- Ist die Schnittlinie in der Quellansicht beschriftet?
- Stimmen Maßstabsangabe im Schriftfeld und tatsächlicher Maßstab der Ansichten überein?

> [!example] Gute Bemaßungspraxis
> Jedes Maß genau einmal – entweder in der Ansicht, wo es am deutlichsten lesbar ist, oder im Schnitt, wenn es innere Geometrie betrifft. Maße nie doppelt setzen, auch nicht in verschiedenen Ansichten.

---

## Zusammenfassung

| Schritt | Operation | Menüpfad |
|---|---|---|
| Seite anlegen | ![[TechDraw_PageTemplate.svg]] Seite aus Vorlage | `TechDraw → Seite einfügen → Seite aus Vorlage einfügen` |
| Ansichten | ![[TechDraw_ProjectionGroup.svg]] Projektionsgruppe | `TechDraw → Ansichten → Projektionsgruppe einfügen` |
| Schnitt | ![[TechDraw_SectionView.svg]] Schnittansicht | `TechDraw → Ansichten → Schnittansicht einfügen` |
| Mittellinien | ![[TechDraw_ExtensionCircleCenterLines.svg]] Kreismittellinien | `TechDraw → Erweiterungen → Mittellinien → Kreismittellinien` |
| Bemaßung | ![[TechDraw_LengthDimension.svg]] Längenmaß | `TechDraw → Bemaßung → Längenmaß einfügen` |
| Schriftfeld | ![[TechDraw_FillTemplateFields.svg]] Vorlagenfelder | `TechDraw → Vorlagenfelder ausfüllen` |
| Export | – | `Datei → Exportieren → PDF` |

---

## Querverweise

- [[TechDraw – Symbolleistenreferenz]] – Vollständige Befehlsreferenz
- [[Glossar FreeCAD#Schnittansicht (Section View)]]
- [[Glossar FreeCAD#Bemaßung]]
- [[Glossar FreeCAD#Schriftfeld (Title Block)]]
- [[Glossar FreeCAD#Normprojektion]]
- [[M04 – Part Design Grundlagen]] – Voraussetzung
- [[M06 – Baugruppen & Assembly]] – Parallelmodul
- [[M08 – Abschlussprojekt]] – Verwendung dieses Moduls
