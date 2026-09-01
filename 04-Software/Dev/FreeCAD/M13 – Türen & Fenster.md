# M13 – Türen & Fenster

> [!info] Modulinfo
> **Workbench:** *BIM* | **Dauer:** 60 min | **Abhängigkeit:** [[M12 – Wände, Böden & Decken]]
> **Kurs:** [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]

---

## Lernziel

Normierte Öffnungen (Türen, Fenster) in Wände einsetzen, ihre Parameter anpassen und das Prinzip des automatischen Wandausschnitts verstehen.

---

## 1. Einführung & Demonstration

### Konzept: Fenster und Türen als BIM-Objekte

In FreeCAD sind Türen und Fenster keine einfachen Volumenkörper, sondern **parametrische BIM-Objekte**: Sie sind mit der Wand verknüpft, in die sie eingesetzt werden, und schneiden deren Geometrie automatisch aus. Ändert man Höhe oder Breite einer Tür, passt sich der Wandausschnitt sofort an.

Beide Objekttypen – Tür und Fenster – werden über denselben Befehl `BIM → Fenster` erzeugt. Der Typ wird durch das gewählte **Preset** bestimmt: ein vordefiniertes Parameterschema (z. B. „Einfache Tür", „Flügelfenster"), dessen Werte bei der Platzierung überschrieben werden.

**Neue Begriffe:**
- **Preset:** Vordefiniertes Parameterschema für ein Standardbauteil – legt Typ, Geometrieform und verfügbare Parameter fest. Werte (Breite, Höhe usw.) werden beim Einfügen angepasst.
- **Brüstungshöhe:** Vertikaler Abstand zwischen Rohboden (Fußboden) und Fensterunterkante. Türen haben Brüstungshöhe 0.
- **Wandausschnitt:** Die Öffnung, die FreeCAD automatisch in die Wandgeometrie schneidet, sobald ein Fenster oder eine Tür korrekt auf einer Wandfläche platziert wird.

> [!warning] Wandverknüpfung
> Fenster und Türen müssen beim Einfügen **exakt auf der Wandfläche** platziert werden – der Cursor muss die Wand gelb hervorheben, bevor geklickt wird. Ohne korrekte Verknüpfung wird kein Wandausschnitt erzeugt. Bei Fehlpositionierung: Objekt löschen (`Entf`) und neu platzieren.

---

### Demonstration: Tür aus Preset einfügen

**Ausgangslage:** Raum aus M12 – vier Wände, Boden, Decke, Maße ca. 4 × 3 m.

#### Schritt 1 – Befehl starten

`BIM → Fenster`

Der Aufgabenbereich öffnet sich mit der Preset-Auswahl.

#### Schritt 2 – Preset wählen

Im Aufgabenbereich unter **Preset** den Eintrag **Simple door** (Einfache Tür) wählen.

Parameter direkt im Dialog einstellen:

| Parameter | Wert | Bedeutung |
|---|---|---|
| Breite | 900 mm | Lichte Breite der Türöffnung |
| Höhe | 2100 mm | Lichte Höhe der Türöffnung |
| Brüstungshöhe | 0 mm | Tür beginnt am Boden |

#### Schritt 3 – Auf Wandfläche platzieren

Cursor auf die gewünschte Wandfläche bewegen – die Wand hebt sich gelb hervor. Klicken, um die Tür einzusetzen.

> [!tip] Einbauposition festlegen
> Die horizontale Position der Tür wird zunächst durch den Klickpunkt bestimmt. Im Properties Panel (Reiter **Daten**) kann der Wert **Offset** (horizontaler Versatz von der linken Wandkante) nachträglich präzise eingegeben werden.

#### Schritt 4 – Wandausschnitt prüfen

3D-Ansicht kontrollieren: Die Wand zeigt jetzt eine Öffnung in der eingestellten Größe. Im Modellbaum erscheint das Objekt **Door** (oder **Window**) als Kind-Objekt der zugehörigen Wand.

#### Schritt 5 – Parameter nachträglich ändern

Tür im Modellbaum doppelklicken → Aufgabenbereich öffnet sich erneut. Breite oder Höhe anpassen → **OK** → Wandausschnitt aktualisiert sich automatisch.

---

### Demonstration: Fenster mit Brüstung einfügen

#### Schritt 1 – Preset wählen

`BIM → Fenster` → Preset: **Simple window** (Einfaches Fenster).

| Parameter | Wert |
|---|---|
| Breite | 1200 mm |
| Höhe | 1000 mm |
| Brüstungshöhe | 900 mm |

#### Schritt 2 – Auf Außenwand platzieren

Cursor auf die Außenwandfläche – gelbe Hervorhebung abwarten – klicken.

#### Schritt 3 – Position per Offset korrigieren

Im Properties Panel → Reiter **Daten** → Feld **Offset** auf den gewünschten Abstand von der linken Wandkante setzen, z. B. `600 mm` (Fenster mittig in einer 2400 mm breiten Wandfläche zwischen zwei Ecken).

---

### Darstellungsmodus umschalten

BIM-Fenster können wahlweise als vollständiges 3D-Objekt oder als vereinfachtes 2D-Symbol dargestellt werden (für Grundrisspläne üblich).

Fenster oder Tür auswählen → Properties Panel → Reiter **Ansicht** → Eigenschaft **Display Mode**:
- `Solid` – vollständige 3D-Geometrie
- `Wireframe` – Drahtgitter

Für den Grundriss wird die 2D-Darstellung in TechDraw automatisch aus dem 3D-Objekt abgeleitet (→ [[M17 – Raumpläne & Schnitte mit TechDraw]]).

---

### Exkurs: Eigenes Fenster aus Sketcher-Profil

Für Sonderformen (Rundbogenfenster, Dachfenster, nicht-rechteckige Öffnungen) kann ein eigenes Preset über eine Sketcher-Skizze definiert werden.

**Kurzablauf:**

1. Skizze auf der Wandfläche anlegen: `Skizze → Skizze erstellen` → Wandfläche auswählen
2. Kontur der Öffnung zeichnen und vollständig bestimmen (→ [[M03 – Sketcher Constraints]])
3. Skizze schließen
4. Skizze auswählen → `BIM → Fenster` → Preset: **Custom** – FreeCAD erzeugt die Öffnung aus der Skizzenkontur

> [!info]
> Bei Custom-Fenstern entfällt der automatische Preset-Dialog. Die Öffnungsgeometrie ergibt sich direkt aus der Skizze. Parameter werden über die Skizze geändert, nicht über ein Properties-Feld.

---

## 2. Übungen

### Übung 1 – Eingangstür einsetzen ⬜

**Ziel:** Eine Außentür korrekt in eine Wand einsetzen und positionieren.

**Ausgangslage:** Raum aus M12 (4 × 3 m, Wandstärke 12 cm, Raumhöhe 2,60 m).

**Teilschritte:**

1. `BIM → Fenster` aufrufen → Preset **Simple door** wählen
2. Parameter einstellen: Breite 900 mm, Höhe 2100 mm, Brüstungshöhe 0 mm
3. Tür auf die 4 m lange Südwand klicken (Wand muss gelb leuchten)
4. Im Properties Panel → **Offset** auf `550 mm` setzen (Tür bündig mit 550 mm Abstand von der linken Wandecke)
5. 3D-Ansicht kontrollieren: Wandausschnitt vorhanden, Türblatt sichtbar
6. Modellbaum prüfen: **Door** als Unterobjekt der Wand

**Erwartetes Ergebnis:** Wand zeigt 900 × 2100 mm Öffnung. Türblatt liegt bündig in der Wandebene.

> [!example] Kontrollfrage
> Warum hat die Tür Brüstungshöhe 0 – und nicht z. B. −50 mm für eine Bodenabsenkung? Was würde ein negativer Wert bewirken?

---

### Übung 2 – Fenster platzieren und Parameter variieren ⬜

**Ziel:** Zwei Fenster mit unterschiedlichen Parametern einsetzen und den Einfluss von Brüstungshöhe und Breite nachvollziehen.

**Teilschritte:**

1. **Erstes Fenster** (Wohnzimmerfenster):
   - `BIM → Fenster` → Preset **Simple window**
   - Breite 1500 mm, Höhe 1200 mm, Brüstungshöhe 800 mm
   - Auf die 4 m lange Nordwand platzieren, Offset `1250 mm` (Fenster mittig)

2. **Zweites Fenster** (kleines Seitenfenster):
   - `BIM → Fenster` → Preset **Simple window**
   - Breite 600 mm, Höhe 600 mm, Brüstungshöhe 1500 mm
   - Auf die 3 m lange Ostwand platzieren, Offset `1200 mm`

3. **Parameter ändern:** Erstes Fenster doppelklicken → Breite auf 1800 mm erhöhen → OK
4. 3D-Ansicht: Wandausschnitte beider Fenster prüfen, Höhenlage des kleinen Fensters in der Seitenansicht (`Num 3`) kontrollieren

**Erwartetes Ergebnis:** Nordwand mit 1800 × 1200 mm Öffnung (Oberkante auf 2000 mm), Ostwand mit 600 × 600 mm Öffnung (Unterkante auf 1500 mm).

> [!example] Kontrollfrage
> Auf welcher Höhe liegt die Oberkante des kleinen Seitenfensters? Berechne händisch: Brüstungshöhe + Fensterhöhe = ?

---

### Übung 3 – Rundbogentür aus Sketcher-Profil ⬜

**Ziel:** Eine nicht-rechteckige Öffnung (Rundbogen) über ein eigenes Sketcher-Profil in eine Wand einschneiden.

**Teilschritte:**

1. Raum-Innenwand auswählen (oder neue 3 m lange Wand anlegen: `BIM → Wand`, Höhe 2600 mm, Stärke 120 mm)

2. Skizze auf Wandinnenfläche anlegen:
   - `Skizze → Skizze erstellen` → Wandfläche anklicken → Ausrichtung bestätigen
   - Profilgeometrie zeichnen (Koordinaten vom Wandursprung aus):
     - Linie von `(300, 0)` nach `(300, 1800)` – linke Seite
     - Bogen: Mittelpunkt `(750, 1800)`, von `(300, 1800)` nach `(1200, 1800)` – Rundbogen oben
     - Linie von `(1200, 1800)` nach `(1200, 0)` – rechte Seite
     - Linie von `(1200, 0)` nach `(300, 0)` – Unterkante (geschlossen)
   - Constraints setzen: Breite des Bogens per `C`, `D` auf 900 mm, Bogenhöhe auf 450 mm (Radius = 450 mm, `C`, `N`)
   - Skizze schließen

3. Skizze im Modellbaum auswählen → `BIM → Fenster` → Preset: **Custom** → auf Wandfläche klicken

4. 3D-Ansicht: Wandausschnitt mit Rundbogen prüfen

**Erwartetes Ergebnis:** Wand zeigt Öffnung mit geradem unteren Teil (Breite 900 mm, Höhe 1800 mm) und halbkreisförmigem Bogensturz (Radius 450 mm). Gesamtöffnungshöhe: 2250 mm.

> [!tip]
> Falls der Wandausschnitt nicht entsteht: Sicherstellen, dass die Skizzenkontur **geschlossen** ist (0 DOF, alle Elemente weiß) und die Skizze exakt auf der Wandfläche liegt – nicht auf einer Bezugsebene daneben.

> [!example] Kontrollfrage
> Wie müsste die Skizze angepasst werden, um aus dem Rundbogen einen Spitzbogen (gotischer Bogen) zu machen? Welcher Sketcher-Geometrietyp wäre nötig?

---

## Zusammenfassung

| Aktion | Befehl |
|---|---|
| Tür oder Fenster einfügen | `BIM → Fenster` |
| Preset wählen | Im Aufgabenbereich: Simple door / Simple window / Custom |
| Einbauposition korrigieren | Properties Panel → Daten → **Offset** |
| Parameter nachträglich ändern | Objekt doppelklicken → Dialog |
| Sonderform einschneiden | Sketcher-Profil auf Wandfläche → `BIM → Fenster` → Preset Custom |

---

## Querverweise

- [[M12 – Wände, Böden & Decken]] – Wandgeometrie als Voraussetzung
- [[M14 – 2D-Grundriss mit Draft]] – Türen und Fenster erscheinen im Grundrissschnitt
- [[M17 – Raumpläne & Schnitte mit TechDraw]] – 2D-Darstellung von Öffnungen im Plan
- [[Glossar FreeCAD]] – Begriffe nachschlagen
- [[M03 – Sketcher Constraints]] – Constraints für Custom-Profile
