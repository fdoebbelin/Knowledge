# M05 – Part Design Vertiefung

> [!info] Modulinfo
> **Workbench:** *Part Design* | **Dauer:** 90 min | **Voraussetzung:** [[M04 – Part Design Grundlagen]]
> Themen: Drehteil, Bezugselemente, Lineares Muster, Polares Muster, Gespiegeltes Objekt, Parametrik

---

## 1 · Drehteil (Revolution)

### Konzept

Ein **Drehteil** (Revolution) entsteht, wenn eine Profilskizze um eine Achse rotiert wird. Das Ergebnis ist immer rotationssymmetrisch – typische Anwendungen sind Wellen, Scheiben, Flaschen oder Unterlegscheiben.

Die Profilskizze muss **einseitig** zur Rotationsachse liegen – sie darf die Achse nicht schneiden. Die Achse selbst wird entweder aus der Skizze (Konstruktionsgeometrie) oder aus dem Body-Ursprung gewählt.

> [!tip] Konstruktionsgeometrie als Achse
> Eine Linie in der Skizze, die als Rotationsachse dienen soll, in den Konstruktionsmodus umschalten: Linie auswählen → `Skizze → Sketcher-Geometrien → Konstruktionsmodus umschalten`. Konstruktionsgeometrie erscheint blau gestrichelt und wird bei der 3D-Operation ignoriert – aber als Achse erkannt.

### Demonstration: Unterlegscheibe

**Ziel:** Unterlegscheibe ∅30 mm, Innen-∅10 mm, Höhe 3 mm.

**Schritt 1 – Skizze auf XY-Ebene erstellen**

1. Body anlegen (`Part Design → Body`), Workbench *Part Design* aktiv.
2. `Skizze → Skizze erstellen` → XY-Ebene wählen → bestätigen.

**Schritt 2 – Profil zeichnen**

3. `G`, `L` – Linie zeichnen: vertikale Linie auf der Y-Achse als Rotationsachse (von (0, 0) nach (0, 3)).
4. Linie auswählen → `Skizze → Sketcher-Geometrien → Konstruktionsmodus umschalten` → Linie wird blau gestrichelt.
5. Profil als Rechteck zeichnen: Punkte bei (5, 0), (15, 0), (15, 3), (5, 3) – grobe Lage, Maße folgen.
6. Rechteck schließen (Koinzidenz-Constraints setzen, falls nötig).

**Schritt 3 – Profil vollständig bestimmen**

7. Untere Linie des Rechtecks: `C`, `O` Koinzidenz mit X-Achse (DOF reduzieren).
8. Linke Seite: horizontalen Abstand von Y-Achse = 5 mm → `C`, `I`, Wert `5`.
9. Breite des Rechtecks = 10 mm → `C`, `D`, Wert `10`.
10. Höhe des Rechtecks = 3 mm → `C`, `D`, Wert `3`.
11. DOF-Anzeige: 0 → alle Elemente weiß → Skizze schließen.

**Schritt 4 – Drehteil erzeugen**

12. `Part Design → Drehteil` → Dialog öffnet sich.
13. **Achse:** `Vertikale Skizzenachse` wählen (oder die gezeichnete Konstruktionslinie).
14. **Winkel:** 360°.
15. OK → Unterlegscheibe erscheint im Modellbaum als `Revolution`.

> [!info] Drehteil vs. Nut
> ![[PartDesign_Revolution.svg]] Drehteil fügt Material hinzu. ![[PartDesign_Groove.svg]] Nut entfernt Material durch Rotation – das Gegenstückprinzip gilt wie bei Pad ↔ Pocket.

---

## 2 · Bezugselemente

### Konzept

**Bezugselemente** sind virtuelle Referenzgeometrien ohne Volumen oder Masse: Bezugsebenen, Bezugsachsen und Bezugspunkte. Sie werden benötigt, wenn die vorhandenen Standardebenen (XY, XZ, YZ) oder vorhandene Körperflächen als Skizzenbasis oder Musterreferenz nicht ausreichen – z. B. für geneigte Skizzenebenen oder Musterachsen an beliebiger Position.

| Operation | Menüpfad | Zweck |
|---|---|---|
| ![[PartDesign_Plane.svg]] Bezugsebene | `Part Design → Bezugselemente → Bezugsebene erstellen` | Skizzenbasis oder Spiegelebene |
| ![[PartDesign_Line.svg]] Bezugsachse | `Part Design → Bezugselemente → Bezugsachse erstellen` | Rotations- oder Musterachse |
| ![[PartDesign_Point.svg]] Bezugspunkt | `Part Design → Bezugselemente → Bezugspunkt erstellen` | Referenzpunkt für weitere Elemente |

### Demonstration: Bezugsebene mit Offset

**Ziel:** Bezugsebene 20 mm oberhalb der XY-Ebene anlegen, um eine zweite Skizze darauf zu platzieren.

1. `Part Design → Bezugselemente → Bezugsebene erstellen` → Dialog öffnet sich.
2. Im Aufgabenbereich: **Referenz** → XY-Ebene im Modellbaum anklicken.
3. **Offset:** Z = 20 mm eingeben.
4. OK → `DatumPlane` erscheint im Modellbaum, sichtbar als gelb-transparente Fläche.
5. `DatumPlane` im Modellbaum auswählen → `Skizze → Skizze erstellen` → Skizze liegt nun 20 mm über XY.

> [!tip] Bezugselemente nachträglich bearbeiten
> Doppelklick auf `DatumPlane` im Modellbaum öffnet den Dialog erneut. Offset-Wert ändern → alle Skizzen und Features auf dieser Ebene verschieben sich mit.

---

## 3 · Lineares Muster

### Konzept

Das **Lineare Muster** vervielfältigt ein oder mehrere Features in einer Richtung mit festem Abstand. Es erzeugt keine Kopien im Modellbaum, sondern ein einziges parametrisches Muster-Feature – Änderungen am Quell-Feature propagieren in alle Instanzen.

### Demonstration: Schlitzreihe

**Voraussetzung:** Body mit einem Quader (60 × 20 × 10 mm, aus M04) und einer Tasche (Schlitz 8 × 10 mm, zentriert an einer Stirnseite).

1. `Pocket`-Feature im Modellbaum auswählen.
2. `Part Design → Lineares Muster` → Dialog öffnet sich.
3. **Feature:** `Pocket` (bereits ausgewählt, da im Schritt 1 markiert).
4. **Richtung:** `Horizontale Skizzenachse` oder `X-Achse des Body-Ursprungs`.
5. **Länge:** 40 mm (Gesamtausdehnung des Musters).
6. **Anzahl:** 3.
7. Vorschau zeigt 3 Schlitze im Abstand von 20 mm → OK.

> [!warning] Richtung und Gesamtlänge
> Der Parameter „Länge" ist die **Gesamtausdehnung** vom ersten bis zum letzten Element – nicht der Abstand zwischen zwei Elementen. Abstand = Länge ÷ (Anzahl − 1).

---

## 4 · Polares Muster

### Konzept

Das **Polare Muster** vervielfältigt Features kreisförmig um eine Achse. Typische Anwendungen: Bohrungskreise, Kühlrippen, Lüfterschaufeln.

### Demonstration: Bohrungskreis

**Voraussetzung:** Runde Scheibe (∅60 mm, Höhe 8 mm, aus Pad oder Revolution) mit einer Bohrung (∅6 mm, auf einem Radius von 20 mm von der Mittelachse).

1. `Pocket`-Feature (die Bohrung) im Modellbaum auswählen.
2. `Part Design → Polares Muster` → Dialog öffnet sich.
3. **Feature:** `Pocket`.
4. **Achse:** `Z-Achse des Body-Ursprungs` (Mittelachse der Scheibe).
5. **Winkel:** 360°.
6. **Anzahl:** 6.
7. Vorschau zeigt 6 Bohrungen gleichmäßig verteilt → OK.

> [!tip] Achse aus dem Body-Ursprung
> Im Dialog „Achse" → `Body-Ursprungsachse` → Z-Achse wählen. Wenn eine Bezugsachse benötigt wird (z. B. außerhalb des Ursprungs), vorher eine ![[PartDesign_Line.svg]] Bezugsachse anlegen und diese hier referenzieren.

---

## 5 · Gespiegeltes Objekt

### Konzept

**Gespiegeltes Objekt** spiegelt ein Feature oder eine Feature-Gruppe an einer Ebene. Geeignet für symmetrische Bauteile, bei denen nur eine Hälfte modelliert wird.

### Demonstration: Symmetrische Nuten

**Voraussetzung:** Quader (50 × 30 × 15 mm) mit einer Nut (Tasche, 8 × 15 mm, links von der Mittelebene).

1. `Pocket`-Feature im Modellbaum auswählen.
2. `Part Design → Gespiegeltes Objekt` → Dialog öffnet sich.
3. **Feature:** `Pocket`.
4. **Ebene:** `Vertikale Skizzenachse` oder `YZ-Ebene` (Symmetrieebene des Quaders).
5. Vorschau zeigt gespiegelte Nut auf der rechten Seite → OK.

> [!info] Mehrere Features spiegeln
> Im Dialog können mehrere Features gleichzeitig ausgewählt werden. Reihenfolge beachten: alle zusammenhängenden Features einer Seite auswählen, bevor das Muster angelegt wird.

---

## 6 · Parametrik: Maße nachträglich ändern

### Konzept

Parametrisches CAD bedeutet: alle Maße bleiben editierbar. Eine Änderung an einem frühen Feature propagiert automatisch durch alle abhängigen Features. Das ist der Kernvorteil gegenüber direkter Modellierung.

### Demonstration: Maß nachträglich ändern

1. Im Modellbaum das Feature doppelklicken, dessen Skizze geändert werden soll (z. B. das erste `Pad`).
2. Die Skizze öffnet sich im Sketcher.
3. Maßliche Constraint doppelklicken (z. B. Länge 60 mm) → Wert auf 80 mm ändern → Enter.
4. Skizze schließen.
5. FreeCAD berechnet alle abhängigen Features neu: Muster, Spiegelung und Taschen passen sich automatisch an.

> [!warning] Topologisches Benennungsproblem
> Wenn Features auf bestimmte Flächen oder Kanten referenzieren (z. B. eine Skizze auf einer Körperfläche) und sich die Geometrie durch eine Parameteränderung stark verändert, können Referenzen verloren gehen (Fehlermeldung im Modellbaum, gelbes Ausrufezeichen). In diesem Fall: betroffene Features doppelklicken und Referenzen neu zuweisen.

---

## Übungen

### Übung 1 – Drehteil: Drehknopf ⬜⬜⬜

**Ziel:** Rotationssymmetrischen Drehknopf als Drehteil modellieren.

**Profil (Skizze auf YZ-Ebene, Rotation um Y-Achse):**

```
Y-Achse (Rotationsachse, als Konstruktionslinie)
  |
  |   ┌──────────────────── 25 mm ────────────────────┐
  |   │                                               │ 20 mm
  |   └──────────────────────────────────────────────────
  |        └─── 5 mm ──┘ (Absatz, Höhe 5 mm, ∅ 15 mm)
```

**Teilschritte:**

1. Skizze auf YZ-Ebene erstellen.
2. Y-Achse als Konstruktionslinie einzeichnen (Rotationsachse).
3. Profil zeichnen: Stufenkontur mit zwei Rechtecken.
   - Unterer Zylinder: Breite (Radius) 12,5 mm, Höhe 5 mm.
   - Oberer Zylinder: Breite (Radius) 7,5 mm, Höhe 20 mm.
   - Beide über Koinzidenz-Constraints verbunden.
4. Alle Maße als Constraints setzen (DOF = 0).
5. `Part Design → Drehteil` → Achse: vertikale Skizzenachse → 360°.
6. Verrundung `Part Design → Verrundung` an der Außenkante oben: R 2 mm.

**Erwartetes Ergebnis:** Stufenzylinder, unterer Bund ∅25 mm / H5 mm, oberer Schaft ∅15 mm / H20 mm.

---

### Übung 2 – Bezugsebene + Lineares Muster: Lochreihe ⬜⬜⬜⬜

**Ziel:** Flachstab mit gleichmäßiger Lochreihe.

**Ausgangskörper:** Pad 100 × 20 × 5 mm (Skizze auf XY-Ebene).

**Teilschritte:**

1. Skizze auf der Oberseite des Pads erstellen.
2. Kreis ∅8 mm zeichnen, Mittelpunkt: X = 10 mm von der linken Kante, Y = 10 mm (Mitte der Breite).
3. Kreis vollständig bestimmen (Koinzidenz Mittelpunkt zur Mittelachse in Y, Abstand 10 mm in X).
4. Skizze schließen → `Part Design → Tasche` → „Durch alles" → OK.
5. `Pocket`-Feature auswählen → `Part Design → Lineares Muster`.
6. Richtung: X-Achse, Länge: 80 mm, Anzahl: 5 → OK.

**Erwartetes Ergebnis:** 5 Bohrungen ∅8 mm im Abstand von 20 mm, symmetrisch auf dem Flachstab.

**Parametrik-Aufgabe:** Abstand der ersten Bohrung von der Kante auf 15 mm ändern. Beobachten, wie das Muster neu berechnet wird.

---

### Übung 3 – Polares Muster + Gespiegeltes Objekt: Flansch ⬜⬜⬜⬜⬜

**Ziel:** Runder Flansch mit Bohrungskreis und zentraler Durchgangsbohrung.

**Teilschritte:**

**Teil A – Grundkörper:**
1. Skizze auf XY-Ebene: Kreis ∅80 mm, zentriert im Ursprung.
2. `Part Design → Aufmaß` → 12 mm → `Flansch_Basis`.

**Teil B – Zentralbohrung:**
3. Skizze auf Oberseite des Flansches: Kreis ∅30 mm, zentriert.
4. `Part Design → Tasche` → „Durch alles" → `Bohrung_Zentrum`.

**Teil C – Befestigungsbohrung (eine):**
5. Skizze auf Oberseite: Kreis ∅8 mm, Mittelpunkt bei X = 30 mm, Y = 0 mm (auf Lochkreis R30).
6. `Part Design → Tasche` → „Durch alles" → `Bohrung_BK`.

**Teil D – Polares Muster:**
7. `Bohrung_BK` auswählen → `Part Design → Polares Muster`.
8. Achse: Z-Achse des Ursprungs, Winkel: 360°, Anzahl: 6 → OK.

**Teil E – Fase und Verrundung:**
9. Obere Außenkante: `Part Design → Fase` → 1 mm.
10. Kante der Zentralbohrung oben: `Part Design → Verrundung` → R 2 mm.

**Erwartetes Ergebnis:** Flansch ∅80 mm / H12 mm mit Zentralbohrung ∅30 mm und 6× Bohrung ∅8 mm auf Lochkreis ∅60 mm.

**Parametrik-Aufgabe:** Anzahl der Befestigungsbohrungen auf 4 ändern (im Polares-Muster-Feature doppelklicken). Flanschdicke von 12 auf 16 mm ändern (Pad-Feature doppelklicken).

---

## Zusammenfassung

| Operation | Menüpfad | Wann einsetzen |
|---|---|---|
| ![[PartDesign_Revolution.svg]] Drehteil | `Part Design → Drehteil` | Rotationssymmetrische Teile |
| ![[PartDesign_Plane.svg]] Bezugsebene | `Part Design → Bezugselemente → Bezugsebene erstellen` | Skizze außerhalb von Standardebenen/Flächen |
| ![[PartDesign_Line.svg]] Bezugsachse | `Part Design → Bezugselemente → Bezugsachse erstellen` | Muster- oder Rotationsachse an beliebiger Stelle |
| ![[PartDesign_LinearPattern.svg]] Lineares Muster | `Part Design → Lineares Muster` | Feature in einer Richtung vervielfältigen |
| ![[PartDesign_PolarPattern.svg]] Polares Muster | `Part Design → Polares Muster` | Feature kreisförmig vervielfältigen |
| ![[PartDesign_Mirrored.svg]] Gespiegeltes Objekt | `Part Design → Gespiegeltes Objekt` | Symmetrische Geometrie ohne doppelten Modellieraufwand |

> [!tip] Parametrik gezielt nutzen
> Maße in Skizzen, Muster-Parameter (Anzahl, Abstand) und Bezugselement-Offsets sind alle nachträglich editierbar. Beim ersten Entwurf bewusst mit runden, leicht änderbaren Werten arbeiten.

---

## Neue Begriffe in diesem Modul

- **Drehteil (Revolution):** Volumenkörper, der durch Rotation einer Profilskizze um eine Achse entsteht. → [[Glossar FreeCAD#Drehteil (Revolution)]]
- **Bezugselement:** Virtuelle Referenzgeometrie (Ebene, Achse, Punkt) ohne Volumen, als Hilfskonstruktion für Skizzen und Muster. → [[Glossar FreeCAD#Bezugselement (Datum Feature)]]

---

## Querverweise

- [[M04 – Part Design Grundlagen]] – Pad, Pocket, Fase, Verrundung
- [[M06 – Baugruppen & Assembly]] – nächstes Modul
- [[Part Design – Symbolleistenreferenz]] – alle Part-Design-Symbole
- [[Glossar FreeCAD]] – Fachbegriffe
- [[Cheat Sheet – Tastenkürzel]] – Shortcuts
