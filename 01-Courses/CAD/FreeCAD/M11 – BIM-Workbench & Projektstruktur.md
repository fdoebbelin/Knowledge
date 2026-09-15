# M11 – BIM-Workbench & Projektstruktur

> [!info] Modulübersicht
> **Kurs:** [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]
> **Workbench:** *BIM*
> **Dauer:** 60 min
> **Voraussetzung:** [[M00 FreeCAD Intensivkurs – Kursstruktur]] M01–M04 (Grundlagen, Sketcher, Part Design)
> **Lernziel:** Die *BIM*-Workbench kennenlernen, ein Projekt strukturieren und die grundlegenden Containerelemente (Gebäude, Ebene) anlegen.

---

## Einführung & Demonstration

### Paradigmenwechsel: Part Design vs. BIM

Im Grundkurs wurden Objekte als geometrische Körper modelliert – ein Aufmaß (Pad) ist eine Extrusion, eine Tasche (Pocket) ist eine Vertiefung. Die Geometrie trägt keine Bedeutung über ihre Form hinaus.

**BIM (Building Information Modeling)** ergänzt die Geometrie um semantische Information: Eine Wand ist nicht nur ein Quader, sondern ein Objekt vom Typ „Wand" mit Eigenschaften wie Stärke, Material und Tragfähigkeit. Diese Information fließt automatisch in Stücklisten, Flächenberechnungen und Exportformate (z. B. IFC) ein.

| Aspekt | *Part Design* | *BIM* |
|---|---|---|
| Basiseinheit | Body + Features | Bauteil-Objekte (Wand, Platte, Raum …) |
| Geometriequelle | Sketcher-Skizze | Direkte BIM-Befehle oder Draft-Profil |
| Maßstab | Einzelteil (mm–cm) | Raum / Gebäude (cm–m) |
| Ziel-Output | Technische Zeichnung | Raumplan, Flächennachweis, IFC |
| Modellbaum | Building → Level → Objekte | Body → Features |

> [!warning] Keine Vermischung
> BIM-Wände sind **keine** Part-Design-Bodies und können nicht mit Pad oder Pocket bearbeitet werden. Für Sonderformen die Wandkontur als Sketcher-Profil definieren oder einen separaten Body als Booleschen Subtrahanden verwenden.

---

### Die BIM-Projektstruktur

Jedes BIM-Projekt folgt einer festen Hierarchie im Modellbaum:

```
Dokument
└── Gebäude (Building)
    └── Erdgeschoss (Level / BuildingPart)
        ├── Wand Nord
        ├── Wand Süd
        ├── Wand Ost
        ├── Wand West
        ├── Bodenplatte
        └── …
```

- **Gebäude** ist der oberste Container – entspricht einem realen Bauwerk.
- **Ebene (Level / BuildingPart)** repräsentiert ein Geschoss. Alle Bauteile dieses Stockwerks werden ihr zugeordnet.
- Bauteile, die keiner Ebene zugeordnet sind, erscheinen zwar in der 3D-Ansicht, fehlen aber in Stücklisten und Flächenberechnungen.

> [!info] BIM-Workbench in FreeCAD 1.0
> Die frühere *Arch*-Workbench ist vollständig in *BIM* aufgegangen. Ältere Tutorials mit `Arch →` als Menüpfad sind veraltet – im Kurs wird ausschließlich `BIM →` verwendet.

---

### Demonstration: Neues BIM-Projekt anlegen

#### Schritt 1 – Einheiten auf Architekturmaß umstellen

Vor dem ersten BIM-Objekt die Einheiten anpassen – FreeCAD rechnet intern immer in mm, die Anzeige lässt sich jedoch auf cm umstellen:

`Bearbeiten → Voreinstellungen → Allgemein → Einheiten`

Empfohlene Einstellung: **Architektur (cm)**, Dezimalstellen: **2**.

> [!tip]
> Diese Einstellung gilt nur für das aktuelle FreeCAD-Profil, nicht pro Dokument. Einmalig setzen, dann nicht mehr ändern müssen.

#### Schritt 2 – *BIM*-Workbench aktivieren

Workbench-Auswahlmenü oben links → **BIM** wählen.

Die Symbolleiste wechselt; es erscheinen die BIM-spezifischen Werkzeuge.

#### Schritt 3 – Neues Dokument anlegen und speichern

`Strg+N` → sofort `Strg+S` → Dateiname z. B. `wohnzimmer_v01.FCStd`

#### Schritt 4 – Gebäude erstellen

`BIM → Gebäude erstellen`

Im Modellbaum erscheint **Building**. Den Eintrag durch Doppelklick auf den Namen in **Wohnprojekt** umbenennen.

#### Schritt 5 – Ebene (Geschoss) erstellen

`BIM → Ebene erstellen`

Im Dialog: Name `Erdgeschoss`, Höhe `0 cm`. Bestätigen.

Im Modellbaum erscheint **BuildingPart** unterhalb von **Building**.

> [!tip] Ebene aktiv setzen
> Doppelklick auf **Erdgeschoss** im Modellbaum → der Eintrag wird fett dargestellt. Alle neu erstellten BIM-Objekte werden jetzt automatisch dieser Ebene zugeordnet.

#### Schritt 6 – Arbeitsebene setzen

Die **Arbeitsebene** bestimmt, auf welcher 2D-Fläche im 3D-Raum neue Objekte entstehen.

`BIM → Arbeitsebene setzen` → **XY (Draufsicht)** wählen → Bestätigen.

Alternativ: Taste `9` öffnet den Arbeitsebenen-Dialog direkt.

Die Statusleiste unten zeigt die aktive Arbeitsebene an.

#### Schritt 7 – Raster aktivieren

`Draft → Hilfsmittel → Raster umschalten`

Das Raster erscheint als graues Gitter in der 3D-Ansicht. Standardrasterweite: 10 cm.

Rasterweite anpassen: `Draft → Hilfsmittel → Rastereinstellungen` → Feldgröße z. B. `5 cm`.

> [!tip] Raster als Orientierungshilfe
> Das Raster richtet sich an der aktiven Arbeitsebene aus. Ist die Arbeitsebene korrekt gesetzt (XY), liegt das Raster automatisch auf Fußbodenhöhe des Erdgeschosses.

#### Schritt 8 – Modellbaum-Ordnung prüfen

Der Modellbaum sollte jetzt zeigen:

```
Wohnprojekt (Building)
└── Erdgeschoss (BuildingPart)
```

Objekte, die versehentlich außerhalb der Ebene entstehen, lassen sich per **Drag & Drop** in den Modellbaum an die richtige Stelle ziehen.

---

## Neue Begriffe

| Begriff | Bedeutung |
|---|---|
| **BIM (Building Information Modeling)** | Methode, bei der 3D-Geometrie mit Sachinformationen (Typ, Material, Fläche) verknüpft wird |
| **Gebäude (Building)** | Oberster Container im Modellbaum; entspricht einem realen Bauwerk |
| **Ebene (Level / BuildingPart)** | Container für alle Bauteile eines Geschosses; trägt die Höhenposition des Stockwerks |
| **Arbeitsebene (Working Plane)** | Aktive 2D-Zeichenebene im 3D-Raum; bestimmt, wo neue Draft- und BIM-Objekte entstehen |
| **Fang (Snap)** | Magnetisches Einrasten des Cursors auf exakt definierten Geometriepunkten |

---

## Tastenkürzel

| Kürzel | Aktion |
|---|---|
| `9` | Arbeitsebene auswählen (*Draft* / *BIM*) |
| `S` | Fang ein/aus (*Draft*) |
| `Leertaste` | Sichtbarkeit des ausgewählten Objekts umschalten |
| `Strg+G` | Ausgewählte Objekte gruppieren |
| `Strg+S` | Speichern |

---

## Übungsteil

### Aufgabe 1 – Einheiten und Voreinstellungen prüfen ✦

**Ziel:** FreeCAD für die Architekturarbeit korrekt konfigurieren.

**Schritte:**

1. Öffne `Bearbeiten → Voreinstellungen → Allgemein → Einheiten`.
2. Stelle auf **Architektur (cm)** um, Dezimalstellen auf **2**.
3. Bestätige und starte FreeCAD neu (Voreinstellungen werden erst nach Neustart vollständig übernommen).
4. Lege ein neues Dokument an (`Strg+N`) und kontrolliere in der Statusleiste, ob die Einheit **cm** angezeigt wird.

**Erwartetes Ergebnis:** Neues Dokument zeigt Maße in cm. Koordinatenanzeige in der Statusleiste lautet z. B. `(0,00 cm, 0,00 cm, 0,00 cm)`.

---

### Aufgabe 2 – Projektstruktur aufbauen ✦✦

**Ziel:** Ein vollständig strukturiertes BIM-Dokument mit Gebäude und zwei Ebenen anlegen.

**Schritte:**

1. Neues Dokument anlegen, sofort speichern als `kurs_m11.FCStd`.
2. *BIM*-Workbench aktivieren.
3. Gebäude anlegen: `BIM → Gebäude erstellen` → im Modellbaum in **Einfamilienhaus** umbenennen.
4. Erste Ebene anlegen: `BIM → Ebene erstellen` → Name `Erdgeschoss`, Höhe `0 cm`.
5. Zweite Ebene anlegen: `BIM → Ebene erstellen` → Name `Obergeschoss`, Höhe `260 cm`.
6. Kontrolliere im Modellbaum: Beide Ebenen müssen als Unterobjekte von **Einfamilienhaus** erscheinen.
7. Setze **Erdgeschoss** als aktive Ebene (Doppelklick → Eintrag wird fett).

**Erwartetes Ergebnis:**

```
Einfamilienhaus (Building)
├── Erdgeschoss (BuildingPart)   ← fett (aktiv)
└── Obergeschoss (BuildingPart)
```

> [!tip]
> Falls eine Ebene nicht unterhalb des Gebäudes erscheint: Ebene per Drag & Drop im Modellbaum unter das Gebäude-Objekt ziehen.

---

### Aufgabe 3 – Arbeitsebene und Raster einrichten ✦✦✦

**Ziel:** Arbeitsebene auf das Erdgeschoss ausrichten und das Raster für präzises Arbeiten konfigurieren.

**Schritte:**

1. Öffne das Dokument aus Aufgabe 2 (oder lege ein neues an).
2. Wechsle in die Draufsicht: `Num 7`.
3. Setze die Arbeitsebene: `BIM → Arbeitsebene setzen` → **XY** wählen → Bestätigen.
4. Aktiviere das Raster: `Draft → Hilfsmittel → Raster umschalten`.
5. Passe die Rasterweite an: `Draft → Hilfsmittel → Rastereinstellungen` → Feldgröße `25 cm`, Hauptlinie alle `4` Felder (= 1 m). Bestätigen.
6. Bewege die Maus über die 3D-Ansicht und beobachte das Fang-Verhalten: Der Cursor rastet auf Rasterpunkten ein.
7. Teste das Abschalten des Fangs mit `S` – der Cursor gleitet nun frei.
8. Wechsle in die isometrische Ansicht (`Num 0`) und überprüfe, dass das Raster auf der XY-Ebene liegt (nicht senkrecht).

**Erwartetes Ergebnis:** Raster mit 25-cm-Feldern und hervorgehobenen 1-m-Linien liegt flach in der XY-Ebene. Fang lässt sich per `S` ein- und ausschalten.

> [!example] Warum 25 cm?
> Ein 25-cm-Raster entspricht dem halben Ziegelmaß (Richtmaß 12,5 cm wäre zu fein für Raumplanung). Es erlaubt präzises Arbeiten bei Wandstärken von 12,5 cm oder 25 cm sowie Raummaßen im 25-cm-Raster, wie sie im Wohnbau üblich sind.

---

## Zusammenfassung

- BIM ergänzt Geometrie um **semantische Information** – Bauteile kennen ihren Typ.
- Die Projektstruktur lautet immer: **Gebäude → Ebene → Bauteile**.
- Vor dem ersten Bauteil: **Einheiten** prüfen, **Ebene aktiv setzen**, **Arbeitsebene** korrekt ausrichten.
- Das **Raster** (Draft) ist das wichtigste Präzisionswerkzeug beim BIM-Zeichnen.

---

## Querverweise

- [[M12 – Wände, Böden & Decken]] – Nächstes Modul
- [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]] – Kursübersicht
- [[Glossar FreeCAD]] – Fachbegriffe
- [[Cheat Sheet – Tastenkürzel]] – Shortcuts
