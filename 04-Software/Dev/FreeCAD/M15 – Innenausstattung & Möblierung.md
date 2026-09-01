# M15 – Innenausstattung & Möblierung

> [!info] Modulübersicht
> **Workbench:** *BIM*, *Part Design*
> **Dauer:** 90 min
> **Abhängigkeit:** [[M12 – Wände, Böden & Decken]]
> **Lernziel:** Standardmöbel aus der BIM-Bibliothek einsetzen und eigene Möbelobjekte mit *Part Design* modellieren, als BIM-Komponente einbinden und im Raum positionieren.

---

## Neue Begriffe

- **BIM-Bibliothek:** Sammlung parametrischer Standardobjekte (Möbel, Leuchten, Sanitär) im FCC- oder STEP-Format, direkt aus FreeCAD abrufbar über `BIM → Bibliothek`
- **Komponente (Component):** BIM-Objekt mit IFC-Typ, Material und Beschreibung; erscheint in Stücklisten und Flächenberechnungen (→ [[M16 – Räume, Flächen & Stücklisten]])
- **Verknüpfte Kopie (App::Link):** Referenz auf ein bestehendes Objekt – keine eigenständige Geometriekopie; Änderungen am Original wirken sich auf alle Verknüpfungen aus

---

## Teil 1 – Einführung & Demonstration

### 1.1 BIM-Bibliothek aufrufen

Die BIM-Bibliothek stellt parametrische Standardmöbel bereit, die direkt ins Raumprojekt geladen werden können.

**Bibliothek öffnen:**

```
BIM → Bibliothek
```

Im Bibliotheksfenster:
1. Kategorie auswählen, z. B. `Furniture` → `Seating`
2. Objekt per Doppelklick in die 3D-Ansicht laden
3. Position durch Klick in die Ansicht festlegen – das Objekt landet auf der aktiven Arbeitsebene

> [!tip] Arbeitsebene prüfen
> Vor dem Einsetzen sicherstellen, dass die Arbeitsebene auf Bodenhöhe (Z = 0) liegt: `BIM → Arbeitsebene setzen` → „XY-Ebene (Boden)".

**Demo: Stuhl aus Bibliothek laden**

Ziel: Einen Stuhl auf dem Boden des Raums aus M12 platzieren.

1. Workbench *BIM* aktivieren
2. `BIM → Bibliothek` öffnen
3. `Furniture → Seating → Chair` per Doppelklick auswählen
4. In der 3D-Ansicht auf den Boden klicken → Stuhl wird eingefügt
5. Im **Properties Panel** unter `Placement → Position` die exakten Koordinaten eintragen, z. B. `x = 500 mm`, `y = 800 mm`, `z = 0 mm`
6. Rotation um Z-Achse: `Placement → Angle = 90°`, `Axis = (0, 0, 1)`

> [!info] Objektursprung
> Bibliotheksobjekte haben ihren Ursprung typischerweise an der Unterseite der Hauptfläche (z. B. Sitzmitte). Die Fußpunkte können je nach Objekt leicht versetzt sein – ggf. Z-Offset in `Placement` korrigieren.

---

### 1.2 Eigenes Möbelstück modellieren

Einfache Möbel lassen sich schnell mit *Part Design* erstellen. Für Wiederverwendbarkeit werden sie in einem **separaten Dokument** modelliert.

**Demo: Couchtisch (800 × 450 × 420 mm)**

#### Schritt 1 – Neues Dokument anlegen

```
Datei → Neu
```

Workbench auf *Part Design* wechseln, dann:

```
Part Design → Body
```

#### Schritt 2 – Tischplatte

1. Body im Modellbaum auswählen → `Skizze → Skizze erstellen` → Ebene **XY** wählen
2. Rechteck zeichnen: `G`, `R` → von Ursprung aus 800 × 450 mm
3. Constraints setzen: Horizontaler Abstand `C`, `I` → `800 mm`, Vertikaler Abstand `C`, `J` → `450 mm`
4. Skizze symmetrisch zum Ursprung: beide Achsen mit `C`, `S` und der jeweiligen Achslinie symmetrieren
5. Skizze schließen → `Part Design → Aufmaß` → Tiefe `25 mm`

> [!info] Symmetrisch zum Ursprung
> Durch Symmetrie liegt der Tischursprung in der Mitte der Tischplatte – das erleichtert späteres Positionieren im Raum.

#### Schritt 3 – Tischbeine (alle vier auf einmal)

1. Unterseite der Tischplatte anklicken → `Skizze → Skizze erstellen`
2. Vier Rechtecke (40 × 40 mm) zeichnen, je eines an jeder Ecke mit 50 mm Einzug von den Kanten:
   - Position Bein vorne-links: Mittelpunkt bei (−355 mm, −177,5 mm)
   - Übrigen drei Beine durch `C`, `S` (Symmetrisch) spiegeln: zuerst links↔rechts, dann vorne↔hinten
3. Alle vier Rechtecke vollständig bestimmen (Farbe: weiß)
4. Skizze schließen → `Part Design → Aufmaß` → Richtung **umkehren** (weg vom Körper) → Tiefe `395 mm`

> [!tip] Richtung prüfen
> Im Pad-Dialog die Vorschau kontrollieren: die Beine müssen nach **unten** extrudieren, nicht in die Tischplatte hinein.

#### Schritt 4 – Speichern und exportieren

```
Datei → Speichern unter → couchtisch.FCStd
Datei → Exportieren → STEP (*.step) → couchtisch.step
```

---

### 1.3 Eigenmöbel als BIM-Komponente einbinden

Zurück im Raumprojekt (M12-Dokument öffnen oder aktivieren):

1. `BIM → Bibliothek` öffnen → Schaltfläche **„Lokale Datei laden"** unten im Bibliotheksfenster
2. `couchtisch.step` auswählen → Objekt wird in die 3D-Ansicht eingefügt
3. Objekt im Modellbaum auswählen → `BIM → Komponente erstellen`
4. Im Dialog:
   - **IFC-Typ:** `IfcFurniture`
   - **Bezeichnung:** `Couchtisch`
   - **Material:** optional, z. B. `Wood`
5. Mit **OK** bestätigen

Das Objekt erscheint nun als `Couchtisch (IfcFurniture)` im Modellbaum und wird in Stücklisten erfasst.

---

### 1.4 Verknüpfte Kopien erstellen

Statt dasselbe Möbel mehrfach zu importieren, arbeitet man mit **verknüpften Kopien** – alle Instanzen zeigen auf dieselbe Geometrie.

1. Komponente im Modellbaum auswählen (z. B. `Couchtisch`)
2. Rechtsklick → **„Verknüpfung erstellen"**
3. Die neue Verknüpfung (`Couchtisch__Link`) im Properties Panel an die gewünschte Position verschieben

Alternativ: `BIM → Bibliothek` → dieselbe lokale Datei erneut laden; FreeCAD erstellt automatisch eine Verknüpfung auf das bereits vorhandene Objekt.

> [!warning] Datei nicht verschieben
> Verknüpfungen referenzieren den Pfad der STEP-Datei. Wird `couchtisch.step` verschoben oder umbenannt, verlieren alle Instanzen ihre Geometrie. Dateien deshalb in einem stabilen Projektordner ablegen.

---

### 1.5 Objekte positionieren und ausrichten

Nach dem Einsetzen liegen Objekte oft am Koordinatenursprung. Präzise Positionierung erfolgt über:

**Methode A – Properties Panel (empfohlen für exakte Maße):**

Im Properties Panel → Reiter **Data** → `Placement`:
- `Position x / y / z`: absolute Koordinaten in mm
- `Angle`: Drehwinkel in Grad
- `Axis`: Drehachse, z. B. `(0, 0, 1)` für Rotation um Z

**Methode B – Draft-Verschieben (empfohlen für interaktives Ausrichten):**

```
Draft → Verschieben
```

1. Objekt auswählen
2. Basispunkt klicken (z. B. Ecke des Objekts, Fangpunkt `Endpunkt`)
3. Zielpunkt klicken (z. B. Wandinnenkante)

> [!tip] Fang nutzen
> Während des Draft-Verschiebens Fang (`S` zum Umschalten) auf **Endpunkt** und **Rechtwinklig** setzen, um Möbel sauber an Wände anzulegen.

---

## Teil 2 – Übungen

### Aufgabe 1 – Sofa aus Bibliothek platzieren *(einfach)*

**Ziel:** Ein Sofa aus der BIM-Bibliothek an die Nordwand des Raums aus M12 stellen.

**Teilschritte:**
1. `BIM → Bibliothek` → `Furniture → Seating` → Sofa-Objekt laden
2. Arbeitsebene auf Boden (Z = 0) prüfen
3. Sofa so positionieren, dass die Rückenlehne 50 mm von der Nordwand entfernt ist:
   - Wandinnenkante in Y-Richtung ermitteln (z. B. Y = 2 740 mm bei 3 000 mm Raumtiefe mit 12 cm Wandstärke)
   - `Placement → Position y` = Wandinnenkante − Sofatiefe − 50 mm
4. Sofa parallel zur Wand ausrichten: `Placement → Angle = 0°` oder `180°` je nach Bibliotheksobjekt-Orientierung

**Erwartetes Ergebnis:** Sofa steht bündig und mit 50 mm Abstand zur Nordwand, ohne in die Wand hineinzuragen.

---

### Aufgabe 2 – Couchtisch modellieren und einbinden *(mittel)*

**Ziel:** Den Couchtisch aus der Demonstration in einem separaten Dokument fertigstellen, als STEP exportieren und als `IfcFurniture`-Komponente vor dem Sofa platzieren.

**Teilschritte:**
1. Couchtisch nach Anleitung aus 1.2 modellieren (falls noch nicht vorhanden)
2. Als `couchtisch.step` exportieren
3. Im Raumprojekt über `BIM → Bibliothek → Lokale Datei laden` einbinden
4. `BIM → Komponente erstellen` → IFC-Typ `IfcFurniture`, Bezeichnung `Couchtisch 800×450`
5. Tisch 300 mm vor der Sofavorderkante zentriert positionieren (X-Mitte des Sofas = X-Mitte des Tisches)
6. Im Modellbaum prüfen: Komponente erscheint mit dem vergebenen Namen

**Erwartetes Ergebnis:** Couchtisch steht zentriert vor dem Sofa, kein Objekt überlappt ein anderes, IFC-Typ ist korrekt gesetzt.

---

### Aufgabe 3 – Essbereich einrichten mit verknüpften Kopien *(anspruchsvoll)*

**Ziel:** Einen Esstisch mit vier Stühlen einrichten. Die Stühle sollen als verknüpfte Kopien eines einzigen Bibliotheksobjekts realisiert werden.

**Teilschritte:**

1. **Esstisch** aus der BIM-Bibliothek laden (`Furniture → Tables → Dining Table`) und in der Raummitte platzieren
2. **Ersten Stuhl** laden (`Furniture → Seating → Chair`) und an einer Längsseite des Tisches positionieren:
   - Abstand Stuhllehne zur Tischkante: 150 mm
   - Stuhl auf Tischmitte zentrieren (X-Koordinate = X-Mitte des Tisches)
3. Drei **verknüpfte Kopien** des Stuhls erstellen:
   - Rechtsklick auf Stuhl im Modellbaum → „Verknüpfung erstellen" (3×)
4. Kopien positionieren:
   - Stuhl 2: gegenüberliegende Längsseite, um 180° gedreht
   - Stuhl 3 + 4: je eine Schmalseite, um ±90° gedreht, zentriert auf die Schmalseite
5. Alle fünf Objekte (Tisch + 4 Stühle) im Modellbaum in eine **Gruppe** zusammenfassen:
   - Alle auswählen (`Strg` + Linksklick) → Rechtsklick → „Zur Gruppe hinzufügen" → neue Gruppe `Essbereich`
6. Sichtprüfung: In der Isometrischen Ansicht (`Num 0` oder `Num 9`) kontrollieren, dass kein Stuhl in den Tisch oder in eine Wand ragt

**Erwartetes Ergebnis:** Symmetrischer Essbereich mit vier Stühlen um den Tisch; alle Stühle sind Verknüpfungen auf dasselbe Quellobjekt; Gruppe `Essbereich` im Modellbaum vorhanden.

> [!tip] Symmetriecheck
> Zur schnellen Kollisionsprüfung `Ansicht → Standardansichten → Draufsicht` (`Num 7`) nutzen – Überschneidungen sind im Grundriss besonders leicht erkennbar.

---

## Zusammenfassung

| Aktion | Methode |
|---|---|
| Bibliotheksobjekt laden | `BIM → Bibliothek` → Doppelklick |
| Eigenmöbel einbinden | Als STEP exportieren → `BIM → Bibliothek → Lokale Datei` |
| BIM-Komponente definieren | `BIM → Komponente erstellen` → IFC-Typ setzen |
| Verknüpfte Kopie erstellen | Rechtsklick im Modellbaum → „Verknüpfung erstellen" |
| Exakte Positionierung | Properties Panel → `Placement → Position / Angle` |
| Interaktive Positionierung | `Draft → Verschieben` mit Fangpunkten |

---

## Querverweise

- [[M12 – Wände, Böden & Decken]] – Raum, in den möbliert wird
- [[M16 – Räume, Flächen & Stücklisten]] – BIM-Komponenten erscheinen in der Stückliste
- [[Glossar FreeCAD#Body]] – Part-Design-Grundlage für Eigenmöbel
- [[Glossar FreeCAD#Aufmaß (Pad)]] – Hauptoperation beim Möbelmodellieren
- [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]
