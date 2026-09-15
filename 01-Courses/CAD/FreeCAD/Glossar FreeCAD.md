# Glossar FreeCAD

> [!info] Über dieses Dokument
> Alphabetisches Nachschlagewerk aller Fachbegriffe des Kurses. Begriffe beim ersten Auftreten in einem Modul kurz erklären und auf diesen Eintrag verweisen. Dieses Dokument wächst mit dem Kurs.

**FreeCAD-Version:** 1.0 | **Kurse:** [[M00 FreeCAD Intensivkurs – Kursstruktur]] · [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]

---

## A

### Abhängigkeit (Constraint)
→ siehe [[#Constraint (Randbedingung)]]

### Ansicht
Darstellung des 3D-Modells aus einer bestimmten Richtung. FreeCAD unterscheidet Standardansichten (Vorne, Hinten, Links, Rechts, Oben, Unten, Isometrisch) und benutzerdefinierte Ansichten. Steuerung über Numpad oder `Ansicht → Standardansichten`.

### Arbeitsebene (Working Plane)
Aktive 2D-Zeichenebene im 3D-Raum, auf der neue *Draft*- und *BIM*-Objekte entstehen. Muss vor dem Zeichnen explizit gesetzt werden. Aufruf: `BIM → Arbeitsebene setzen`. Tastenkürzel: `W` (Draft/BIM).

> [!warning] Häufiger Anfängerfehler
> Wenn Wände oder andere BIM-Objekte an der falschen Position entstehen, ist meist die Arbeitsebene nicht korrekt gesetzt. Als Arbeitsritual etablieren: erst Arbeitsebene prüfen, dann zeichnen.

### Assembly (Baugruppe)
→ siehe [[#Baugruppe]]

### Aufmaß (Pad)
Extrusion einer geschlossenen 2D-Skizze entlang einer Achse (meist Z) zu einem Volumenkörper. Grundoperation der *Part Design*-Workbench. Aufruf: `Part Design → Aufmaß`. Gegenstück: [[#Tasche (Pocket)]].

### Ausrichtung
Positionierung eines Objekts im Raum relativ zu einem Referenzelement (Ebene, Achse, Punkt). In der *Assembly*-Workbench über Joints gesteuert.

---

## B

### Baugruppe (Assembly)
Zusammenschluss mehrerer Einzelteile (Bodies) in einem gemeinsamen Dokument. In FreeCAD 1.0 über die native *Assembly*-Workbench verwaltet. Teile werden über [[#Joint (Verbindung)]] zueinander positioniert.

> [!warning] Versionshinweis
> Vor FreeCAD 1.0 wurden externe Addons (A2plus, Assembly4) verwendet. Diese sind mit FreeCAD 1.0 nicht kompatibel.

### Bemaßung
Maßangabe in einer technischen Zeichnung (Länge, Radius, Winkel, Durchmesser). In der *TechDraw*-Workbench über `TechDraw → Bemaßung` eingefügt. Nicht zu verwechseln mit [[#Constraint (Randbedingung)]] im Sketcher.

### Bezugsachse (Datum Axis)
Virtuelle Linie ohne Masse oder Volumen, die als Rotations- oder Spiegelachse für Features dient. Erstellt über `Part Design → Bezugselemente → Bezugsachse erstellen`.

### Bezugselement (Datum Feature)
Oberbegriff für virtuelle Referenzgeometrie: [[#Bezugsebene (Datum Plane)]], [[#Bezugsachse (Datum Axis)]] und [[#Bezugspunkt (Datum Point)]]. Bezugselemente haben kein Volumen und erscheinen nicht in der Fertigung.

### Bezugsebene (Datum Plane)
Virtuelle Fläche, die als Skizzenbasis oder Spiegelebene für Features dient. Erstellt über `Part Design → Bezugselemente → Bezugsebene erstellen`. Standardebenen (XY, XZ, YZ) sind immer vorhanden.

### Bezugspunkt (Datum Point)
Virtueller Punkt im Raum als Referenz für Bezugselemente oder Constraints. Erstellt über `Part Design → Bezugselemente → Bezugspunkt erstellen`.

### BIM (Building Information Modeling)
Methode der digitalen Gebäudeplanung, bei der 3D-Geometrie mit strukturierten Sachinformationen verknüpft wird: Ein Wandobjekt kennt nicht nur seine Form, sondern auch seinen Typ (tragend/nicht tragend), sein Material und seine Fläche. In FreeCAD über die *BIM*-Workbench umgesetzt. Gegensatz: reine Geometriemodellierung wie in *Part Design*.

> [!info] BIM-Workbench in FreeCAD 1.0
> Die frühere *Arch*-Workbench wurde in FreeCAD 1.0 vollständig in die *BIM*-Workbench überführt. Ältere Tutorials mit `Arch →` als Menüpfad sind veraltet – im Kurs wird ausschließlich `BIM →` verwendet.

### BIM-Bibliothek
Sammlung parametrischer Standardobjekte (Möbel, Leuchten, Sanitärobjekte, Bauelemente) im FCC- oder STEP-Format, die direkt aus FreeCAD abrufbar sind. Aufruf: `BIM → Bibliothek`. Objekte können nach dem Laden in Abmessungen und Eigenschaften angepasst werden.

### Body
Container-Objekt der *Part Design*-Workbench, das alle Features eines zusammenhängenden Volumenkörpers enthält. Jedes Part-Design-Modell braucht genau einen Body. Erstellt über `Part Design → Body`.

### Brüstungshöhe
Vertikaler Abstand zwischen dem Rohboden und der Unterkante eines Fensters. Relevant bei der Platzierung von Fenstern in *BIM*: wird im Parameterdialog des Fensterobjekts als eigener Wert gesetzt und bestimmt die Einbauposition in der Wand.

---

## C

### CAD (Computer-Aided Design)
Computergestützter Entwurf technischer Bauteile. FreeCAD implementiert **parametrisches CAD**: Modelle werden durch Parameter (Maße, Abhängigkeiten) definiert und können nachträglich geändert werden. Gegensatz: direkte Modellierung (z. B. Mesh-Editoren).

### Constraint (Randbedingung)
Geometrische oder maßliche Einschränkung, die Freiheitsgrade einer Skizze reduziert. Zwei Typen:
- **Geometrische Constraints:** Legen Beziehungen fest (z. B. Parallel, Rechtwinklig, Koinzident)
- **Maßliche Constraints:** Legen Werte fest (z. B. Abstand = 20 mm, Radius = 5 mm)

Eine vollständig bestimmte Skizze hat 0 verbleibende [[#Freiheitsgrad (DOF)]].

---

## D

### DOF (Degrees of Freedom)
→ siehe [[#Freiheitsgrad (DOF)]]

### Draft
Workbench für präzises 2D-Zeichnen im 3D-Raum. Bietet Linien, Polylinien, Rechtecke, Kreise sowie Beschriftungs- und Bemaßungswerkzeuge. Im Aufbaukurs Innenarchitektur als Basis für Grundrissgeometrie und als Quelle für BIM-Wandkonturen eingesetzt. Ergänzt die *BIM*-Workbench um freie Zeichenwerkzeuge.

### Drehteil (Revolution)
Volumenkörper, der durch Rotation einer Profilskizze um eine Achse entsteht. Typisch für rotationssymmetrische Teile (Wellen, Scheiben, Flaschen). Aufruf: `Part Design → Drehteil`.

---

## E

### Ebene (Level / BuildingPart)
Horizontaler Schnitt durch ein Gebäude, der als Container für alle Bauteile eines Geschosses dient (entspricht einem Stockwerk). BIM-Objekte wie Wände, Böden und Decken werden einer Ebene zugeordnet. Erstellt über `BIM → Ebene erstellen`. Im Modellbaum ergibt sich die Hierarchie: Gebäude → Ebene → Objekte.

### Explosionsansicht
Darstellung einer Baugruppe, bei der alle Einzelteile entlang ihrer Montageachsen auseinandergezogen dargestellt werden. Dient der Übersicht über Teileanzahl und Montagereihenfolge. Verfügbar in der *Assembly*-Workbench.

### Extrusion
→ siehe [[#Aufmaß (Pad)]]

---

## F

### Fang (Snap)
Magnetisches Einrasten des Cursors auf exakt definierten Geometriepunkten (Endpunkt, Mittelpunkt, Schnittpunkt, rechtwinkliger Punkt u. a.) beim Zeichnen in *Draft* und *BIM*. Verhindert Ungenauigkeiten beim Klicken. Ein-/Ausschalten: `S` oder `Draft → Hilfsmittel → Fang umschalten`. Temporär deaktivieren: `Strg` gedrückt halten.

### Fase (Chamfer)
Abschrägung einer Kante um einen definierten Winkel (meist 45°). Aufruf: `Part Design → Fase`. Häufig für Einführhilfen oder Entgratung. Gegenstück: [[#Verrundung (Fillet)]].

### Feature
Einzelne Modellierungsoperation im parametrischen Modellbaum eines *Part Design*-Bodys (z. B. Pad, Pocket, Fillet, Revolution). Features werden sequenziell aufgebaut – jedes Feature baut auf dem vorherigen auf.

### Freiheitsgrad (DOF – Degree of Freedom)
Mögliche unabhängige Bewegung eines geometrischen Elements. Eine Linie in 2D hat 4 DOF (2× Position Endpunkt A, 2× Position Endpunkt B). Jeder Constraint reduziert die DOF. Ziel im Sketcher: DOF = 0 (vollständig bestimmt).

---

## G

### Gespiegeltes Objekt (Mirrored)
Feature, das ein bestehendes Feature oder eine Feature-Gruppe an einer Ebene spiegelt. Aufruf: `Part Design → Gespiegeltes Objekt`. Reduziert den Modellieraufwand bei symmetrischen Bauteilen.

### Grundriss
Horizontale Schnittdarstellung eines Gebäudes oder Raums in einer definierten Höhe. Norm: Schnitt auf ca. 1,0 m über dem Fertigfußboden, damit Türen, Fenster und Wandöffnungen sichtbar werden. In FreeCAD über eine [[#Schnittebene (Section Plane)]] erzeugt und anschließend in *TechDraw* bemaßt.

---

## H

### Hilfslinie
→ siehe [[#Konstruktionsgeometrie]]

---

## J

### Joint (Verbindung)
Mechanische Verbindung zwischen zwei Bauteilen in der *Assembly*-Workbench. Definiert, welche Relativbewegungen erlaubt sind. Typen in FreeCAD 1.0:
- **Fest:** Keine Relativbewegung
- **Drehgelenk:** Rotation um eine Achse
- **Schieber:** Translation entlang einer Achse

Aufruf: `Assembly → Verbindung erstellen`.

---

## K

### Koinzidenz (Coincident)
Geometrischer Constraint, der zwei Punkte auf dieselbe Position zwingt. Häufigste Constraint-Art im Sketcher, um Konturelemente zu verbinden. Aufruf: `Skizze → Sketcher-Randbedingungen → Koinzidenz festlegen`.

### Komponente
Begriff mit workbench-spezifischer Bedeutung:

- **In der *Assembly*-Workbench:** Einzelteil (Body oder Sub-Assembly) innerhalb einer Baugruppe. Wird über `Assembly → Komponente einfügen` eingebunden.
- **In der *BIM*-Workbench:** BIM-Objekt mit definierten semantischen Eigenschaften (IFC-Typ, Material, Beschreibung), das in [[#Stückliste (Bill of Materials)]]n und Flächenberechnungen erscheint. Erstellt über `BIM → Komponente erstellen`.

### Konstruktionsgeometrie (Construction Geometry)
Hilfselemente in einer Skizze, die nicht zur Kontur gehören und bei der 3D-Operation ignoriert werden. Dargestellt als blaue gestrichelte Linie. Umschalten: `Skizze → Sketcher-Geometrien → Konstruktionsmodus umschalten`. Nützlich als Referenz für Constraints oder Symmetrieachsen.

### Kontur
Geschlossener Linienzug in einer Skizze, der die Form einer 3D-Operation (Aufmaß, Tasche) definiert. Für Pad und Pocket muss die Kontur geschlossen sein.

---

## L

### Lineares Muster (Linear Pattern)
Feature, das ein bestehendes Feature in einer Richtung mit festem Abstand vervielfältigt. Aufruf: `Part Design → Lineares Muster`. Gegenstück: [[#Polares Muster (Polar Pattern)]].

---

## M

### Modellbaum (Model Tree)
Hierarchische Darstellung aller Objekte, Features und Parameter eines FreeCAD-Dokuments im linken Seitenbereich. Zeigt die Entstehungsgeschichte des Modells (parametrischer Baum). Features können im Baum ausgewählt und nachträglich bearbeitet werden. Im BIM-Kontext spiegelt der Baum die Gebäudehierarchie wider: Gebäude → [[#Ebene (Level / BuildingPart)]] → Bauteile.

---

## N

### Normprojektion
Standard für die Darstellung von 3D-Körpern in technischen Zeichnungen:
- **Europäische Projektion (E):** Ansicht erscheint auf der Seite, von der man schaut (DIN/ISO-Norm, in Europa Standard)
- **Amerikanische Projektion (A):** Ansicht erscheint gegenüber der Schaurichtung

Eingestellt in den TechDraw-Einstellungen.

---

## O

### Origin (Ursprung)
Koordinatenursprung (0, 0, 0) mit den drei Standardebenen XY, XZ, YZ und den Achsen X, Y, Z. Jeder Body hat seinen eigenen Ursprung. Sichtbar im Modellbaum unter `Origin`.

### Überbeschränkt (Over-Constrained)
Zustand einer Skizze, bei dem widersprüchliche oder redundante Constraints vorliegen. Anzeige: rote Elemente im Sketcher. FreeCAD löst überbeschränkte Skizzen nicht auf – Constraints müssen manuell entfernt werden.

---

## P

### Parametrisches Modell
CAD-Modell, dessen Geometrie durch editierbare Parameter (Maße, Constraints) definiert ist. Änderungen an einem Parameter propagieren automatisch durch alle abhängigen Features. Grundprinzip von FreeCAD *Part Design*.

### Part Design
Workbench für die feature-basierte, parametrische Modellierung von Volumenkörpern. Arbeitet mit einem [[#Body]] und einer Folge von [[#Feature]]s. Geeignet für Einzelteile aus der Fertigung. Im Aufbaukurs auch für selbst modellierte Möbel und Sonderformen in BIM-Projekten eingesetzt.

### Platte (Slab)
Horizontales Flächenbauteil für Boden oder Decke, definiert durch eine Kontur und eine Stärke. BIM-Objekt der *BIM*-Workbench. Aufruf: `BIM → Platte`. Die Kontur wird meist aus den Wandinnenkanten oder einer Sketcher-Skizze abgeleitet.

### Pocket
→ siehe [[#Tasche (Pocket)]]

### Polares Muster (Polar Pattern)
Feature, das ein bestehendes Feature kreisförmig um eine Achse vervielfältigt. Aufruf: `Part Design → Polares Muster`. Nützlich für Bohrungskreise, Kühlrippen etc. Gegenstück: [[#Lineares Muster (Linear Pattern)]].

### Preset
Vordefiniertes Parameterschema für ein Standardbauteil in der *BIM*-Workbench (z. B. „Einfaches Fenster", „Drehtür"). Die Preset-Werte (Breite, Höhe, Öffnungsrichtung) werden beim Platzieren oder nachträglich im Properties Panel überschrieben. Beschleunigt das Einsetzen normierter Bauteile.

### Projektion
→ siehe [[#Normprojektion]]

---

## R

### Randbedingung
→ siehe [[#Constraint (Randbedingung)]]

### Raum (Space)
BIM-Objekt, das ein abgeschlossenes Raumvolumen repräsentiert und automatisch Fläche, Umfang und Volumen berechnet. Die Raumkontur wird an den Wandinnenkanten ausgerichtet, um Nettoflächen (lichte Maße) zu erhalten. Aufruf: `BIM → Raum`. Bildet die Grundlage für [[#Stückliste (Bill of Materials)|Stücklisten]] und Flächennachweise.

> [!info] Brutto- vs. Nettofläche
> FreeCAD unterscheidet Bruttofläche (inkl. Wandstärken) und Nettofläche (lichte Maße). Für Wohnflächenberechnungen nach WoFlV ist stets die Nettofläche relevant.

### Revolution
→ siehe [[#Drehteil (Revolution)]]

---

## S

### Schnittansicht (Section View)
Technische Zeichnungsansicht, bei der das Modell entlang einer Schnittebene aufgetrennt dargestellt wird, um innere Strukturen sichtbar zu machen. Schnittflächen werden schraffiert. Aufruf in *TechDraw*: `TechDraw → Ansicht einfügen → Schnittansicht`. Nicht zu verwechseln mit [[#Schnittebene (Section Plane)]].

### Schnittebene (Section Plane)
Virtueller Schnitt durch das 3D-Modell, aus dem eine 2D-Ansicht abgeleitet wird. In der *BIM*-Workbench für Grundrisse (horizontaler Schnitt, ca. 1,0 m über Boden) und Wandschnitte (vertikaler Schnitt) eingesetzt. Aufruf: `BIM → Schnittebene`. Aus der Schnittebene wird anschließend über `BIM → 2D-Ansicht` eine 2D-Darstellung erzeugt.

### Schriftfeld (Title Block)
Tabellenbereich am Rand einer technischen Zeichnung mit Metadaten: Teilename, Maßstab, Zeichnungsnummer, Bearbeiter, Datum, Werkstoff. In *TechDraw* als Teil der Seitenvorlage definiert.

### Sketch
→ siehe [[#Skizze]]

### Sketcher
Workbench für die Erstellung und Bearbeitung von 2D-Skizzen. Basis für alle *Part Design*-Operationen. Skizzen werden auf einer [[#Bezugsebene (Datum Plane)]] erstellt.

### Skizze (Sketch)
2D-Zeichnung auf einer Bezugsebene, die als Profil für 3D-Operationen (Aufmaß, Tasche, Drehteil) dient. Eine Skizze besteht aus Geometrieelementen (Linien, Kreise, Bögen) und [[#Constraint (Randbedingung)|Constraints]]. Aufruf: `Skizze → Skizze erstellen`.

**Farb-Feedback im Sketcher:**
| Farbe | Bedeutung |
|---|---|
| Weiß | Vollständig bestimmt (DOF = 0) |
| Gelb | Unterbeschränkt (DOF > 0) |
| Rot | Überbeschränkt oder Fehler |
| Blau (gestrichelt) | Konstruktionsgeometrie |

### STEP (Standard for the Exchange of Product Data)
Herstellerneutrales Austauschformat für 3D-CAD-Daten (Dateiendung `.step` oder `.stp`). Empfohlenes Format für den Datenaustausch zwischen verschiedenen CAD-Systemen sowie zum Einbinden selbst modellierter Möbel in BIM-Projekte. Export in FreeCAD: `Datei → Exportieren → STEP`.

### Stückliste (Bill of Materials, BOM)
Tabellarische Auflistung aller Bauteile eines Projekts mit Typ, Anzahl, Fläche oder Volumen. In der *BIM*-Workbench automatisch aus allen Komponenten generiert. Aufruf: `BIM → Stückliste`. Export als CSV oder direkt in die *Spreadsheet*-Workbench. Grundlage für Materialmengenberechnungen und Kostenabschätzungen.

### Sturzmaß
Höhe der Wandfläche über einer Türöffnung bis zur Deckenunterkante. Relevant für Schnittdarstellungen in *TechDraw*, um die konstruktive Situation über Öffnungen zu dokumentieren. Wird aus dem 3D-Modell direkt ablesbar, wenn Wand- und Deckenhöhe parametrisch definiert sind.

### Symmetrie (Symmetric)
Geometrischer Constraint, der zwei Elemente spiegelbildlich zu einer Linie oder Achse positioniert. Aufruf: `Skizze → Sketcher-Randbedingungen → Symmetrisch festlegen`.

---

## T

### Tangential
Geometrischer Constraint, der zwei Kurven (Kreis, Bogen, Linie) glatt aneinanderfügt, ohne Knick. Aufruf: `Skizze → Sketcher-Randbedingungen → Tangential festlegen`.

### Tasche (Pocket)
Operation, die Material aus einem bestehenden Volumenkörper entfernt, indem eine Skizzenkontur in den Körper hinein extrudiert wird. Aufruf: `Part Design → Tasche`. Gegenstück: [[#Aufmaß (Pad)]].

### TechDraw
Workbench zur Ableitung normgerechter technischer Zeichnungen aus 3D-Modellen. Erzeugt 2D-Ansichten (Haupt-, Hilfs-, Schnittansicht) mit Bemaßungen und Schriftfeld. Im Grundkurs für Bauteilzeichnungen, im Aufbaukurs für Grundrisse und Raumpläne eingesetzt.

---

## U

### Unterbeschränkt (Under-Constrained)
Zustand einer Skizze, bei dem noch Freiheitsgrade verbleiben (DOF > 0). Anzeige: gelbe Elemente im Sketcher. Unterbeschränkte Skizzen können für 3D-Operationen verwendet werden, sind aber nicht empfehlenswert, da Änderungen unerwartete Geometrieverschiebungen verursachen können.

---

## V

### Verrundung (Fillet)
Abrundung einer Kante mit einem definierten Radius. Aufruf: `Part Design → Verrundung`. Typisch für Entlastungskerben, ergonomische Formen und Gusskonstruktionen. Gegenstück: [[#Fase (Chamfer)]].

### Vollständig bestimmt (Fully Constrained)
Zustand einer Skizze mit genau 0 verbleibenden Freiheitsgraden. Alle Geometrieelemente sind durch [[#Constraint (Randbedingung)|Constraints]] eindeutig positioniert. Anzeige: weiße Elemente im Sketcher. Ziel jeder Skizze vor der 3D-Operation.

### Volumenkörper (Solid)
3D-Objekt mit definiertem Volumen und geschlossener Oberfläche. Gegensatz: Flächen- oder Drahtgittermodell. *Part Design* arbeitet ausschließlich mit Volumenkörpern.

---

## W

### Wand (Wall)
BIM-Objekt der *BIM*-Workbench mit parametrischer Geometrie (Länge, Höhe, Stärke) und semantischen Eigenschaften (Wandtyp, Material). Aufruf: `BIM → Wand`. Wände können aus einem Klick-Verlauf, einer *Draft*-Polylinie oder einem *Sketcher*-Profil erstellt werden. Eingesetzte Fenster und Türen schneiden die Wand automatisch aus.

**Wichtige Wandparameter:**
| Parameter | Bedeutung |
|---|---|
| Höhe | Wandhöhe in mm/cm |
| Stärke | Wanddicke |
| Ausrichtung | Mittellinie, Innenkante oder Außenkante als Basis |
| Verbindungstyp | Wie angrenzende Wände geometrisch verbunden werden |

### Workbench (Arbeitsumgebung)
Kontext-abhängige Benutzeroberfläche in FreeCAD, die Werkzeuge für einen bestimmten Aufgabenbereich bündelt. Wechsel über das Workbench-Auswahlmenü oben links. Wichtige Workbenches im Kurs:

| Workbench | Zweck |
|---|---|
| *Sketcher* | 2D-Skizzen erstellen |
| *Part Design* | Parametrische 3D-Volumenkörper |
| *Assembly* | Baugruppen aus Einzelteilen |
| *TechDraw* | Technische Zeichnungen ableiten |
| *BIM* | Gebäude, Räume und Bauteile (Aufbaukurs) |
| *Draft* | 2D-Hilfsgeometrie und Grundrisse (Aufbaukurs) |
| *Spreadsheet* | Flächenberechnungen und Stücklisten (Aufbaukurs) |

---

## Z

### Zeichnungsansicht (View)
Einzelne Projektion eines 3D-Modells in einer technischen Zeichnung (z. B. Vorderansicht, Draufsicht, Seitenansicht). In *TechDraw* über `TechDraw → Ansicht einfügen` hinzugefügt.

---

## Querverweise

- [[M00 FreeCAD Intensivkurs – Kursstruktur]]
- [[M10 FreeCAD Aufbaukurs – Innenarchitektur & Innenraumgestaltung]]
- [[Cheat Sheet – Tastenkürzel]]
- [[Cheat Sheet – Sketcher Constraints]]
