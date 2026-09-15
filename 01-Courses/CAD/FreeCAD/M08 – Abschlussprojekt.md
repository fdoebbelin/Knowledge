# M08 – Abschlussprojekt: Scharnier

> [!info] Modulübersicht
> **Workbenches:** *Sketcher* · *Part Design* · *Assembly* · *TechDraw*
> **Dauer:** ca. 120 min | **Abhängigkeiten:** [[M02 – Sketcher Grundlagen]] bis [[M07 – Technische Zeichnung]]
> **Lernziel:** Eigenständiges Modellieren eines zweiteiligen Scharniers – von der Skizze bis zur technischen Zeichnung.

---

## Projektbeschreibung

Das Abschlussprojekt ist ein einachsiges Scharnier aus zwei identischen Laschen. Jede Lasche besteht aus einer flachen Grundplatte mit einem zylindrischen Scharnierauge. In der Baugruppe werden beide Laschen über ihre Scharnieraugen zu einem drehbeweglichen Gelenk verbunden.

```
Seitenansicht (Baugruppe, offen):

     Lasche B
      ╱
Auge─●
      ╲
     Lasche A
```

**Modellplan:**

| Datei | Inhalt | benötigte Operationen |
|---|---|---|
| `Lasche.FCStd` | Einzelteil (für beide Laschen) | Aufmaß × 2, Tasche × 1 |
| `Scharnier.FCStd` | Baugruppe (2 × Lasche) | Drehgelenk |
| TechDraw-Seite | Zeichnung der Lasche | 3 Ansichten, 6 Maße |

---

## Maßzeichnung Lasche

```
                25 mm
        ┌───────────────┐
        │               │ 50 mm
        │               │
        │               │
        └───────┬───────┘
                │  ← Gelenkkante (Skizzen-y = 0)
               ╔╩╗
               ║ ║  Scharnierauge
               ║ ║  Ø16 außen / Ø6 Bohrung / H = 14 mm
               ╚╤╝
              [Pin]

Plattendicke: 3 mm
```

**Alle Maße in mm:**

| Merkmal | Wert |
|---|---|
| Plattenlänge | 50 |
| Plattenbreite | 25 |
| Plattendicke | 3 |
| Auge Außendurchmesser | 16 |
| Auge Bohrungsdurchmesser | 6 |
| Augenhöhe | 14 |
| Auge X-Position (Mitte) | 12,5 (zentriert) |
| Auge Y-Position (Mitte) | 0 (Gelenkkante) |

---

## Aufgabe A – Lasche modellieren

> [!tip] Neue Datei anlegen
> `Strg+N` → Workbench *Part Design* wählen → `Part Design → Body` → Datei als `Lasche.FCStd` speichern.

### A1 – Grundplatte

**Ziel:** Flache Platte 25 × 50 × 3 mm.

1. Im Modellbaum: `Body` → `Skizze → Skizze erstellen` → Bezugsebene **XY_Plane** wählen.
2. Rechteck zeichnen (`G`, `R`): ersten Eckpunkt auf den Ursprung (`C`, `O` Koinzidenz auf Ursprung), zweiten Eckpunkt frei setzen.
3. Constraints setzen:
   - `C`, `H` auf untere Kante (Horizontal)
   - `C`, `V` auf linke Kante (Vertikal)
   - `C`, `D` Breite = **25 mm**
   - `C`, `D` Höhe = **50 mm**
4. DOF-Anzeige prüfen → **0 DOF**, alle Elemente weiß → Skizze schließen.
5. `Part Design → Aufmaß` → Tiefe: **3 mm** → OK.

> [!example] Erwartetes Ergebnis
> Quaderförmige Platte im 3D-Fenster. Im Modellbaum: `Body → Sketch → Pad`.

---

### A2 – Scharnierauge

**Ziel:** Zylindrischer Vorsprung Ø16, H=14 mm, mittig an der Gelenkkante.

1. Oberfläche der Platte (Oberseite, z = 3) anklicken → `Skizze → Skizze erstellen`.
2. Kreis zeichnen (`G`, `C`): Mittelpunkt ungefähr auf die **untere Kante** der Oberfläche setzen (Gelenkkante, entspricht y = 0 in der Skizzierebene).
3. Constraints:
   - `C`, `I` Horizontaler Abstand vom linken Rand zum Kreismittelpunkt = **12,5 mm** (Mitte der 25 mm Breite)
   - `Skizze → Sketcher-Randbedingungen → Punkt auf Objekt festlegen`: Kreismittelpunkt auf die untere Kante der Oberfläche legen (y = 0).
   - `C`, `N` Radius = **8 mm** (= Ø16)
4. Skizze schließen → DOF = 0.
5. `Part Design → Aufmaß` → Tiefe: **14 mm** → OK.

> [!info] Geometrie-Hinweis
> Der Kreis ist mittig auf der Gelenkkante zentriert: Die Hälfte des Auges steht über die Plattengelenkkante vor. Das ist die korrekte Geometrie – der Bolzen verläuft entlang dieser Kante.

---

### A3 – Bolzenbohrung

**Ziel:** Axiale Durchgangsbohrung Ø6 durch das Scharnierauge.

1. Oberseite des Scharnierauges (z = 17) anklicken → `Skizze → Skizze erstellen`.
2. Kreis zeichnen (`G`, `C`): Mittelpunkt auf denselben Punkt wie das Auge setzen.
3. Constraints:
   - `C`, `I` Horizontaler Abstand = **12,5 mm** (wie beim Auge)
   - `Skizze → Sketcher-Randbedingungen → Punkt auf Objekt festlegen`: Mittelpunkt auf die untere Kante
   - `C`, `N` Radius = **3 mm** (= Ø6)
4. Skizze schließen → DOF = 0.
5. `Part Design → Tasche` → Tiefe: **14 mm** (= Augenhöhe) → OK.

> [!warning] Taschetiefe beachten
> Tiefe exakt **14 mm** angeben – nicht „Durch alles". Die Bohrung soll nur durch das Auge gehen, nicht durch die Grundplatte.

> [!example] Erwartetes Ergebnis
> Die Lasche ist fertig: flache Platte mit einem zylindrischen Auge an der Gelenkkante, Ø6-Bohrung axial durch das Auge. Modellbaum: `Pad → Pad001 → Pocket`. Datei speichern (`Strg+S`).

---

## Aufgabe B – Baugruppe erstellen

> [!tip] Neue Datei anlegen
> `Strg+N` → Workbench *Assembly* wählen → speichern als `Scharnier.FCStd`.

### B1 – Komponenten einfügen und fixieren

1. `Assembly → Komponente einfügen` → `Lasche.FCStd` wählen → erste Instanz erscheint als **Lasche** im Baum.
2. Erste Instanz im Baum auswählen → `Assembly → Fixierung umschalten` → Lasche ist jetzt fixiert (Schloss-Symbol im Baum).
3. `Assembly → Komponente einfügen` → erneut `Lasche.FCStd` wählen → zweite Instanz erscheint als **Lasche001**.

> [!info] Verknüpfte Komponenten
> Beide Instanzen verweisen auf dieselbe Datei `Lasche.FCStd`. Änderungen an der Lasche wirken sich automatisch auf beide aus.

---

### B2 – Drehgelenk definieren

**Ziel:** Beide Scharnieraugen auf dieselbe Achse legen; Lasche001 kann um diese Achse rotieren.

1. Zylindrische **Innenfläche der Bohrung** von Lasche (fixiert) anklicken.
2. `Strg` gedrückt halten → zylindrische **Innenfläche der Bohrung** von Lasche001 anklicken.
3. `Assembly → Verbindung erstellen → Drehgelenk` → Joint wird erzeugt.
4. `Assembly → Baugruppe lösen` → FreeCAD positioniert Lasche001 so, dass die Bohrungsachsen fluchten.

> [!tip] Grobe Vorpositionierung
> Falls der Solver in eine ungünstige Lage springt: Lasche001 im 3D-Fenster grob mit der Maus auf die Bohrungsseite von Lasche ziehen, dann erneut `Assembly → Baugruppe lösen`.

---

### B3 – Öffnungswinkel prüfen

1. Im Modellbaum das Joint-Objekt (**Revolute**) doppelklicken → Aufgabenbereich öffnet sich.
2. Optionalen Winkelwert eingeben (z. B. **90°**) → `Assembly → Baugruppe lösen` → Scharnier steht im rechten Winkel.
3. Winkel auf **0°** zurücksetzen → Lasche001 liegt parallel zu Lasche (geschlossene Position).

> [!example] Erwartetes Ergebnis
> Zwei Laschen, deren Scharnieraugen übereinander sitzen und um eine gemeinsame Achse drehbar sind. Datei speichern.

---

## Aufgabe C – Technische Zeichnung

> [!tip] Datei vorbereiten
> `Lasche.FCStd` öffnen (oder im offenen Scharnier-Dokument belassen). Workbench *TechDraw* wählen.

### C1 – Seite und Ansichten anlegen

1. `TechDraw → Seite einfügen → Seite aus Vorlage einfügen` → **A4_LandscapeISO7200** wählen → Seite erscheint.
2. Im Modellbaum: `Pad` (die Grundplatte, erstes Feature) auswählen.
3. `TechDraw → Ansichten → Projektionsgruppe einfügen` → Häkchen setzen bei **Vorne**, **Oben**, **Links** → OK.
4. Ansichten auf der Seite sinnvoll positionieren (Drag & Drop).
5. Schnittansicht (Längsschnitt durch Bohrung):
   - Vorderansicht auswählen → `TechDraw → Ansichten → Schnittansicht einfügen`
   - Schnittlinie durch Mitte der Bohrung (x = 12,5) legen → Richtung nach rechts → OK.

---

### C2 – Bemaßen und exportieren

**Mindestmaße:** Plattenlänge, Plattenbreite, Plattendicke, Augenhöhe, Außen-Ø Auge, Bohrung-Ø.

1. Erste Maßlinie: Kante der Plattenlänge in der Vorderansicht anklicken → `TechDraw → Bemaßung → Längenmaß einfügen` → Maßlinie positionieren.
2. Analog für Plattenbreite (Draufsicht), Plattendicke (Seitenansicht).
3. Augenhöhe: Oberkante und Unterkante des Auges in der Vorderansicht → `TechDraw → Bemaßung → Längenmaß einfügen`.
4. Außen-Ø: Kreisbogen des Auges in der Draufsicht → `TechDraw → Bemaßung → Durchmessermaß einfügen`.
5. Bohrung-Ø: inneren Kreis in der Schnittansicht → `TechDraw → Bemaßung → Durchmessermaß einfügen`.
6. Schriftfeld ausfüllen: `TechDraw → Vorlagenfelder ausfüllen` → Teilename: **Scharnier-Lasche**, Maßstab: **1:1**, Datum eintragen.
7. Export: `Datei → Exportieren` → Format **PDF** → speichern.

> [!example] Erwartetes Ergebnis
> A4-Zeichnung mit Vorder-, Drauf-, Seitenansicht und Längsschnitt; 6 Maße; ausgefülltes Schriftfeld; PDF-Export.

---

## Selbstkontrolle-Checkliste

> [!info] Alle Punkte vor Abgabe abhaken

**Modellierung (Lasche.FCStd)**
- [ ] Platte: 25 × 50 × 3 mm, keine losen DOF in den Skizzen
- [ ] Scharnierauge: Ø16, H=14 mm, zentriert auf Gelenkkante
- [ ] Bohrung: Ø6, tief 14 mm (nur durch das Auge, nicht durch die Platte)
- [ ] Modellbaum: `Pad → Pad001 → Pocket` (3 Features, kein Fehler-Symbol)
- [ ] Alle Skizzen vollständig bestimmt (weiß, DOF = 0)

**Baugruppe (Scharnier.FCStd)**
- [ ] Beide Laschen-Instanzen eingefügt
- [ ] Lasche (erste Instanz) fixiert
- [ ] Drehgelenk auf Bohrungsachse definiert
- [ ] Baugruppe lässt sich auf 0° und 90° lösen ohne Fehler

**Zeichnung**
- [ ] 3 Normalansichten + 1 Schnittansicht
- [ ] 6 Maße gesetzt und lesbar positioniert
- [ ] Schriftfeld vollständig ausgefüllt
- [ ] PDF-Export vorhanden

---

## Erweiterungsaufgaben (optional)

> [!tip] Für schnelle Teilnehmer

**E1 – Bolzen modellieren**
Erstelle einen zylindrischen Bolzen (`Bolzen.FCStd`): Ø6, L=32 mm (= 2 × Augenhöhe + 4 mm Überstand je Seite). Füge ihn als dritte Komponente in die Baugruppe ein; verbinde ihn mit einer **Festen Verbindung** mit einer der Laschen.

**E2 – Polares Muster**
Ergänze die Grundplatte um 2 Befestigungsbohrungen Ø4: Mittelpunkte bei (6,5 | 38) und (18,5 | 38). Nutze dafür **Lineares Muster** oder zwei einzelne Taschen. Aktualisiere die Zeichnung.

**E3 – Explosionsansicht**
Öffne `Scharnier.FCStd` → `Assembly → Explosionsansicht erstellen` → ziehe die Komponenten auseinander → dokumentiere die Montagereihenfolge.

---

## Querverweise

- [[M02 – Sketcher Grundlagen]] – Geometrie zeichnen
- [[M03 – Sketcher Constraints]] – Skizzen vollständig bestimmen
- [[M04 – Part Design Grundlagen]] – Aufmaß und Tasche
- [[M05 – Part Design Vertiefung]] – Muster und Bezugselemente
- [[M06 – Baugruppen & Assembly]] – Joints und Baugruppen
- [[M07 – Technische Zeichnung]] – TechDraw-Workflow
- [[Glossar FreeCAD]] – Alle Fachbegriffe
- [[Cheat Sheet – Tastenkürzel]]
- [[Cheat Sheet – Sketcher Constraints]]
