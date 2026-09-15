# M02 – Sketcher Grundlagen

> [!info] Modulinfo
> **Workbench:** *Sketcher* | **Dauer:** 90 min | **Voraussetzung:** [[M01 – FreeCAD Grundlagen]]
> Dieses Modul führt in die Erstellung von 2D-Skizzen ein – der Basis für jede 3D-Operation in FreeCAD.

---

## Lernziel

2D-Skizzen mit geometrischen Grundelementen erstellen, auf der richtigen Bezugsebene anlegen und das Farb-Feedback des Sketchers deuten können.

---

## 1 – Konzept: Was ist eine Skizze?

Eine **Skizze** (Sketch) ist eine 2D-Zeichnung auf einer definierten Ebene. Sie beschreibt die *Form* einer geplanten 3D-Operation – zum Beispiel das Profil eines Bauteils, das anschließend extrudiert wird. Erst in M04 wird aus der Skizze ein Volumenkörper; hier geht es ausschließlich um das Zeichnen.

Skizzen leben in der *Sketcher*-Workbench. Jede Skizze liegt auf einer **Bezugsebene** – einer flächigen Referenz im Raum. FreeCAD stellt drei Standardebenen bereit:

| Bezugsebene | Liegt in der Ebene | Typische Verwendung |
|---|---|---|
| XY | Grundriss (Draufsicht) | Bodenprofile |
| XZ | Frontansicht | Seitenprofile |
| YZ | Seitenansicht | Querschnitte |

> [!info] Parametrisches Prinzip
> Skizzen sind parametrisch: Maße und Beziehungen zwischen Elementen werden als **Randbedingungen (Constraints)** gespeichert, nicht als feste Koordinaten. Dadurch lässt sich die Skizze später jederzeit ändern, ohne von vorn zu beginnen. Constraints sind Thema von [[M03 – Sketcher Constraints]].

---

## 2 – Skizze erstellen und schließen

### 2.1 Skizze öffnen

1. *Sketcher*-Workbench wählen (Auswahlmenü oben links).
2. `Skizze → Skizze erstellen` aufrufen – oder in der Symbolleiste: ![[Sketcher_NewSketch.svg]] **Skizze erstellen**.
3. Im Dialog **Bezugsebene wählen**: für den Einstieg **XY_Plane** auswählen → **OK**.
4. Die 3D-Ansicht wechselt in die Skizzieransicht (Draufsicht). Der **Aufgabenbereich** links zeigt Werkzeuge und den DOF-Zähler (Freiheitsgrade).

> [!tip] Schneller Einstieg
> Alternativ: im Modellbaum die gewünschte Standardebene (`XY_Plane`, `XZ_Plane` oder `YZ_Plane`) anklicken, dann `Skizze → Skizze erstellen`. FreeCAD übernimmt die Ebene automatisch.

### 2.2 Skizze schließen

Skizze schließen mit einem der folgenden Wege:
- Schaltfläche **Skizze schließen** im Aufgabenbereich, oder
- `Skizze → Skizze schließen` im Menü, oder
- Taste `Esc` (zweimal, wenn ein Werkzeug aktiv ist).

Die Skizze erscheint danach als Eintrag `Sketch` im Modellbaum unter dem Body.

### 2.3 Skizze nachträglich bearbeiten

Doppelklick auf den Skizzeneintrag im Modellbaum öffnet sie erneut zur Bearbeitung.

---

## 3 – Farb-Feedback im Sketcher

Der Sketcher kommuniziert den Bestimmtheitszustand der Skizze über Farben:

| Farbe | Bedeutung |
|---|---|
| **Weiß** | Vollständig bestimmt – alle Elemente eindeutig positioniert (DOF = 0) |
| **Gelb** | Unterbeschränkt – noch Freiheitsgrade vorhanden (DOF > 0) |
| **Rot** | Überbeschränkt oder Fehler – widersprüchliche Constraints |
| **Blau gestrichelt** | Konstruktionsgeometrie – Hilfslinie, kein Bestandteil der Kontur |
| **Lila** | Externe Geometrie – projizierte Kante aus dem 3D-Körper (nicht editierbar) |

> [!warning] Ziel vor der 3D-Operation
> Vor dem Verlassen der Skizze sollten alle Elemente **weiß** sein (DOF = 0). Eine gelbe Skizze kann zwar für Pad/Pocket verwendet werden, führt aber bei späteren Parameteränderungen zu unerwarteten Verschiebungen.

---

## 4 – Zeichenwerkzeuge

Die wichtigsten Werkzeuge im Überblick. Jedes Werkzeug bleibt nach dem ersten Element aktiv (Kettenmodus) – `Esc` oder Rechtsklick beendet es.

### 4.1 Linie

`Skizze → Sketcher-Geometrien → Linie erstellen` | Kürzel: `G`, `L` | ![[Sketcher_CreateLine.svg]] **Linie erstellen**

- Linksklick setzt den Startpunkt, zweiter Klick den Endpunkt.
- Im Kettenmodus wird der Endpunkt automatisch zum neuen Startpunkt.
- `Esc` beendet die letzte Linie ohne weiteren Punkt.

### 4.2 Rechteck

`Skizze → Sketcher-Geometrien → Rechteck erstellen` | Kürzel: `G`, `R` | ![[Sketcher_CreateRectangle.svg]] **Rechteck erstellen**

- Erster Klick: eine Ecke. Zweiter Klick: gegenüberliegende Ecke.
- Erzeugt automatisch vier Linien mit vier Eckpunkten.

> [!tip] Varianten
> ![[Sketcher_CreateRectangle_Center.svg]] **Zentriertes Rechteck** (`Skizze → Sketcher-Geometrien → Zentriertes Rechteck erstellen`) definiert das Rechteck über Mittelpunkt und Eckpunkt – praktisch für symmetrische Profile.

### 4.3 Kreis

`Skizze → Sketcher-Geometrien → Kreis erstellen` | Kürzel: `G`, `C` | ![[Sketcher_CreateCircle.svg]] **Kreis erstellen**

- Erster Klick: Mittelpunkt. Zweiter Klick: Punkt auf dem Kreisumfang (definiert den Radius).

### 4.4 Bogen

`Skizze → Sketcher-Geometrien → Bogen erstellen` | Kürzel: `G`, `A` | ![[Sketcher_CreateArc.svg]] **Bogen erstellen**

- Erster Klick: Mittelpunkt. Zweiter Klick: Startpunkt. Dritter Klick: Endpunkt.
- Der Bogen wird gegen den Uhrzeigersinn aufgespannt.

### 4.5 Polylinie

`Skizze → Sketcher-Geometrien → Polylinie erstellen` | Kürzel: `G`, `M` | ![[Sketcher_CreatePolyline.svg]] **Polylinie erstellen**

- Wie Linie, aber der Endpunkt jedes Segments ist automatisch mit dem nächsten Startpunkt koinzident verbunden.
- Ideal für zusammenhängende Konturen aus mehreren Linien.

### 4.6 Punkt

`Skizze → Sketcher-Geometrien → Punkt erstellen` | Kürzel: `G`, `P` | ![[Sketcher_CreatePoint.svg]] **Punkt erstellen**

- Setzt einen einzelnen Punkt – nützlich als Referenz für Constraints oder Symmetrieachsen.

### 4.7 Regelmäßige Polygone

Sechseck: `Skizze → Sketcher-Geometrien → Sechseck erstellen` | Kürzel: `G`, `O` | ![[Sketcher_CreateHexagon.svg]] **Sechseck erstellen**

- Erster Klick: Mittelpunkt. Zweiter Klick: Mittelpunkt einer Seite (definiert Umkreisradius und Orientierung).
- Weitere Polygone (Dreieck, Quadrat, Fünfeck …) über `Skizze → Sketcher-Geometrien → …`.

---

## 5 – Konstruktionsgeometrie

**Konstruktionsgeometrie** sind Hilfslinien innerhalb einer Skizze, die bei der 3D-Operation (Pad, Pocket) ignoriert werden. Sie dienen als Referenz für Constraints, Symmetrieachsen oder Hilfsmaße.

Umschalten: ausgewählte Geometrie markieren, dann `Skizze → Sketcher-Geometrien → Konstruktionsmodus umschalten` | ![[Sketcher_ToggleConstruction.svg]] **Konstruktionsmodus umschalten**

- Normale Geometrie → Konstruktionsgeometrie: Element wird blau gestrichelt.
- Konstruktionsgeometrie → normale Geometrie: umgekehrt.

> [!example] Anwendungsfall
> Eine Mittellinie als Konstruktionsgeometrie anlegen, um zwei Punkte später mit dem Symmetrie-Constraint zu spiegeln.

---

## 6 – Demonstration: Profilskizze eines L-Profils

**Ziel:** Skizze eines L-förmigen Profils auf der XZ-Ebene anlegen.

**Schritt 1 – Skizze öffnen**
1. *Sketcher*-Workbench aktivieren.
2. Im Modellbaum `XZ_Plane` anklicken.
3. `Skizze → Skizze erstellen` → Skizze öffnet sich in der Frontansicht.

**Schritt 2 – Kontur zeichnen**
1. `G`, `M` (Polylinie) aktivieren.
2. Klicks in dieser Reihenfolge setzen (grobe Positionen, Maße egal):
   - Punkt 1: Ursprung (0, 0) – am Schnittpunkt der roten/grünen Achsen einrasten
   - Punkt 2: rechts, auf gleicher Höhe (z. B. bei x=40)
   - Punkt 3: senkrecht nach oben (z. B. bei z=10)
   - Punkt 4: zurück nach links (z. B. bei x=10)
   - Punkt 5: weiter nach oben (z. B. bei z=40)
   - Punkt 6: zurück zum Ursprung (Startpunkt) – FreeCAD schnappt auf den ersten Punkt ein und schließt die Kontur
3. `Esc` – Polylinie-Werkzeug beenden.

**Schritt 3 – Ergebnis prüfen**
- Alle Linien sollten **gelb** sein (unterbeschränkt) – das ist korrekt, da noch keine Maße vergeben wurden.
- Im DOF-Zähler steht ein Wert > 0.
- Im Modellbaum: `Sketch` ist angelegt.

**Schritt 4 – Skizze schließen**
- **Skizze schließen** im Aufgabenbereich klicken.

> [!info] Nächster Schritt
> Maße und Beziehungen werden in [[M03 – Sketcher Constraints]] ergänzt. Die Skizze wird dann vollständig weiß (DOF = 0).

---

## Übungen

### Übung 1 – Rechteck auf der XY-Ebene ⬜

**Ziel:** Einfache geschlossene Kontur anlegen und das Farb-Feedback beobachten.

**Aufgabe:**
1. Neues FreeCAD-Dokument anlegen (`Strg+N`).
2. *Sketcher*-Workbench wählen, Skizze auf **XY_Plane** öffnen.
3. Mit ![[Sketcher_CreateRectangle.svg]] **Rechteck erstellen** ein beliebig großes Rechteck zeichnen.
4. Skizze schließen.

**Erwartetes Ergebnis:**
- Skizze enthält vier Linien, alle **gelb** (unterbeschränkt, noch keine Maße).
- Der Modellbaum zeigt `Sketch` als Eintrag.
- DOF-Zähler zeigt einen Wert > 0.

---

### Übung 2 – Kreis und Hilfslinie ⭕

**Ziel:** Kreis zeichnen und eine Linie als Konstruktionsgeometrie markieren.

**Aufgabe:**
1. Neue Skizze auf **XY_Plane**.
2. Mit `G`, `C` (Kreis) einen Kreis mit Mittelpunkt nahe dem Ursprung zeichnen.
3. Mit `G`, `L` (Linie) eine Linie quer durch den Ursprung zeichnen (horizontale Hilfslinie).
4. Die Linie auswählen → ![[Sketcher_ToggleConstruction.svg]] **Konstruktionsmodus umschalten** → Linie wird blau gestrichelt.
5. Skizze schließen.

**Erwartetes Ergebnis:**
- Kreis: gelb (unterbeschränkt).
- Hilfslinie: blau gestrichelt (Konstruktionsgeometrie).
- Im nächsten Modul wird der Kreis durch Constraints positioniert.

---

### Übung 3 – T-Profil mit Polylinie ✏️

**Ziel:** Zusammengesetzte Kontur aus einer Polylinie zeichnen; das Schließen der Kontur üben.

**Aufgabe:**
1. Neue Skizze auf **XZ_Plane**.
2. Mit der **Polylinie** (`G`, `M`) eine T-förmige Kontur zeichnen:
   - Horizontaler Balken oben: Breite ca. 60 mm, Höhe ca. 15 mm
   - Vertikaler Steg mittig: Breite ca. 20 mm, Höhe ca. 40 mm
   - Kontur vollständig schließen (letzter Klick auf Startpunkt einrasten lassen)
3. Prüfen, ob die Kontur geschlossen ist: FreeCAD zeigt keinen offenen Endpunkt.
4. Skizze schließen.

**Erwartetes Ergebnis:**
- Alle Linien gelb, Kontur vollständig geschlossen.
- DOF-Zähler > 0 (wird in M03 auf 0 reduziert).

> [!tip] Kontur schließen
> Beim letzten Punkt der Polylinie nahe an den Startpunkt heranfahren – FreeCAD zeigt einen gelben Punkt als Einrastindikator. Ein Klick auf diesen Punkt verbindet Endpunkt und Startpunkt mit einer Koinzidenz-Constraint automatisch.

> [!warning] Offene Kontur
> Eine nicht geschlossene Kontur führt in M04 beim Pad-Befehl zu einem Fehler. Falls die Skizze rot wird, mit `Skizze → Skizze überprüfen` (![[Sketcher_ValidateSketch.svg]]) fehlende Koinzidenzen aufspüren.

---

### Übung 4 – Sechseck mit Bohrungskreis 🔩

**Ziel:** Kombination aus Polygon und Kreisen; Konstruktionsgeometrie sinnvoll einsetzen.

**Aufgabe:**
1. Neue Skizze auf **XY_Plane**.
2. Mit ![[Sketcher_CreateHexagon.svg]] **Sechseck erstellen** (`G`, `O`) ein Sechseck mit Mittelpunkt im Ursprung zeichnen.
3. Mit `G`, `C` (Kreis) sechs kleine Kreise zeichnen – je einen nahe jedem Eckpunkt des Sechsecks (grobe Position, keine exakten Maße nötig).
4. Mit `G`, `C` einen weiteren Kreis **konzentrisch** über den Ursprung legen (Mittelpunkt auf Ursprung einrasten).
5. Den zentrierten Kreis auswählen → ![[Sketcher_ToggleConstruction.svg]] **Konstruktionsmodus umschalten** (er dient nur als Referenz für den Bohrungskreis).
6. Skizze schließen.

**Erwartetes Ergebnis:**
- Sechseck und sechs kleine Kreise: gelb.
- Zentrierter Hilfskreis: blau gestrichelt.
- DOF-Zähler > 0.

> [!info] Ausblick
> In [[M03 – Sketcher Constraints]] wird der Hilfskreis genutzt, um alle sechs Bohrungen mit dem Symmetrie- oder Punkt-auf-Objekt-Constraint gleichmäßig auf dem Lochkreis zu verteilen.

---

## Zusammenfassung

| Thema | Kernaussage |
|---|---|
| Skizze | 2D-Profil auf einer Bezugsebene; Basis jeder 3D-Operation |
| Bezugsebene | XY, XZ oder YZ – wählen nach gewünschter Orientierung im Raum |
| Farben | Gelb = unterbeschränkt, Weiß = fertig, Rot = Fehler |
| Polylinie | Effizienteste Methode für zusammengesetzte Konturen |
| Konstruktionsgeometrie | Blaue Hilfslinien – gehören nicht zur Kontur |
| Kontur schließen | Pflicht vor jeder Pad/Pocket-Operation |

---

## Querverweise

- [[M01 – FreeCAD Grundlagen]] – Navigation und Benutzeroberfläche
- [[M03 – Sketcher Constraints]] – Nächster Schritt: Skizze vollständig bestimmen
- [[Sketcher – Symbolleistenreferenz]] – Alle Sketcher-Werkzeuge im Überblick
- [[Cheat Sheet – Tastenkürzel]] – Kürzel für Geometriewerkzeuge (`G`, `L` usw.)
- [[Cheat Sheet – Sketcher Constraints]] – Vorbereitung auf M03
- [[Glossar FreeCAD#Skizze]] | [[Glossar FreeCAD#Bezugsebene (Datum Plane)]] | [[Glossar FreeCAD#Konstruktionsgeometrie]]
