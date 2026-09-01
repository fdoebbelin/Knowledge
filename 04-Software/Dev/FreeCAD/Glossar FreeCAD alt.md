# Glossar FreeCAD

> [!info] Über dieses Dokument
> Alphabetisches Nachschlagewerk aller Fachbegriffe des Kurses. Begriffe beim ersten Auftreten in einem Modul kurz erklären und auf diesen Eintrag verweisen. Dieses Dokument wächst mit dem Kurs.

**FreeCAD-Version:** 1.0 | **Kurs:** [[M00 FreeCAD Intensivkurs – Kursstruktur]]

---

## A

### Abhängigkeit (Constraint)
→ siehe [[Glossar FreeCAD#Constraint (Randbedingung)]]

### Ansicht
Darstellung des 3D-Modells aus einer bestimmten Richtung. FreeCAD unterscheidet Standardansichten (Vorne, Hinten, Links, Rechts, Oben, Unten, Isometrisch) und benutzerdefinierte Ansichten. Steuerung über Numpad oder `Ansicht → Standardansichten`.

### Assembly (Baugruppe)
→ siehe [[Glossar FreeCAD#Baugruppe]]

### Aufmaß (Pad)
Extrusion einer geschlossenen 2D-Skizze entlang einer Achse (meist Z) zu einem Volumenkörper. Grundoperation der *Part Design*-Workbench. Aufruf: `Part Design → Aufmaß`. Gegenstück: [[Glossar FreeCAD#Tasche (Pocket)]].

### Ausrichtung
Positionierung eines Objekts im Raum relativ zu einem Referenzelement (Ebene, Achse, Punkt). In der *Assembly*-Workbench über Joints gesteuert.

---

## B

### Baugruppe (Assembly)
Zusammenschluss mehrerer Einzelteile (Bodies) in einem gemeinsamen Dokument. In FreeCAD 1.0 über die native *Assembly*-Workbench verwaltet. Teile werden über [[Glossar FreeCAD#Joint (Verbindung)]] zueinander positioniert.

> [!warning] Versionshinweis
> Vor FreeCAD 1.0 wurden externe Addons (A2plus, Assembly4) verwendet. Diese sind mit FreeCAD 1.0 nicht kompatibel.

### Bemaßung
Maßangabe in einer technischen Zeichnung (Länge, Radius, Winkel, Durchmesser). In der *TechDraw*-Workbench über `TechDraw → Bemaßung` eingefügt. Nicht zu verwechseln mit [[Glossar FreeCAD#Constraint (Randbedingung)]] im Sketcher.

### Bezugsachse (Datum Axis)
Virtuelle Linie ohne Masse oder Volumen, die als Rotations- oder Spiegelachse für Features dient. Erstellt über `Part Design → Bezugselemente → Bezugsachse erstellen`.

### Bezugselement (Datum Feature)
Oberbegriff für virtuelle Referenzgeometrie: [[Glossar FreeCAD#Bezugsebene (Datum Plane)]], [[Glossar FreeCAD#Bezugsachse (Datum Axis)]] und [[Glossar FreeCAD#Bezugspunkt (Datum Point)]]. Bezugselemente haben kein Volumen und erscheinen nicht in der Fertigung.

### Bezugsebene (Datum Plane)
Virtuelle Fläche, die als Skizzenbasis oder Spiegelebene für Features dient. Erstellt über `Part Design → Bezugselemente → Bezugsebene erstellen`. Standardebenen (XY, XZ, YZ) sind immer vorhanden.

### Bezugspunkt (Datum Point)
Virtueller Punkt im Raum als Referenz für Bezugselemente oder Constraints. Erstellt über `Part Design → Bezugselemente → Bezugspunkt erstellen`.

### Body
Container-Objekt der *Part Design*-Workbench, das alle Features eines zusammenhängenden Volumenkörpers enthält. Jedes Part-Design-Modell braucht genau einen Body. Erstellt über `Part Design → Body`.

---

## C

### CAD (Computer-Aided Design)
Computergestützter Entwurf technischer Bauteile. FreeCAD implementiert **parametrisches CAD**: Modelle werden durch Parameter (Maße, Abhängigkeiten) definiert und können nachträglich geändert werden. Gegensatz: direkte Modellierung (z. B. Mesh-Editoren).

### Constraint (Randbedingung)
Geometrische oder maßliche Einschränkung, die Freiheitsgrade einer Skizze reduziert. Zwei Typen:
- **Geometrische Constraints:** Legen Beziehungen fest (z. B. Parallel, Rechtwinklig, Koinzident)
- **Maßliche Constraints:** Legen Werte fest (z. B. Abstand = 20 mm, Radius = 5 mm)

Eine vollständig bestimmte Skizze hat 0 verbleibende [[Glossar FreeCAD#Freiheitsgrad (DOF)]].

---

## D

### DOF (Degrees of Freedom)
→ siehe [[Glossar FreeCAD#Freiheitsgrad (DOF)]]

### Drehteil (Revolution)
Volumenkörper, der durch Rotation einer Profilskizze um eine Achse entsteht. Typisch für rotationssymmetrische Teile (Wellen, Scheiben, Flaschen). Aufruf: `Part Design → Drehteil`.

---

## E

### Explosionsansicht
Darstellung einer Baugruppe, bei der alle Einzelteile entlang ihrer Montageachsen auseinandergezogen dargestellt werden. Dient der Übersicht über Teileanzahl und Montagereihenfolge. Verfügbar in der *Assembly*-Workbench.

### Extrusion
→ siehe [[Glossar FreeCAD#Aufmaß (Pad)]]

---

## F

### Fase (Chamfer)
Abschrägung einer Kante um einen definierten Winkel (meist 45°). Aufruf: `Part Design → Fase`. Häufig für Einführhilfen oder Entgratung. Gegenstück: [[Glossar FreeCAD#Verrundung (Fillet)]].

### Feature
Einzelne Modellierungsoperation im parametrischen Modellbaum eines *Part Design*-Bodys (z. B. Pad, Pocket, Fillet, Revolution). Features werden sequenziell aufgebaut – jedes Feature baut auf dem vorherigen auf.

### Freiheitsgrad (DOF – Degree of Freedom)
Mögliche unabhängige Bewegung eines geometrischen Elements. Eine Linie in 2D hat 4 DOF (2× Position Endpunkt A, 2× Position Endpunkt B). Jeder Constraint reduziert die DOF. Ziel im Sketcher: DOF = 0 (vollständig bestimmt).

---

## G

### Gespiegeltes Objekt (Mirrored)
Feature, das ein bestehendes Feature oder eine Feature-Gruppe an einer Ebene spiegelt. Aufruf: `Part Design → Gespiegeltes Objekt`. Reduziert den Modellieraufwand bei symmetrischen Bauteilen.

---

## H

### Hilfslinie
→ siehe [[Glossar FreeCAD#Konstruktionsgeometrie]]

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
Einzelteil (Body oder Sub-Assembly) innerhalb einer Baugruppe. Wird über `Assembly → Komponente einfügen` in das Assembly-Dokument eingebunden.

### Konstruktionsgeometrie (Construction Geometry)
Hilfselemente in einer Skizze, die nicht zur Kontur gehören und bei der 3D-Operation ignoriert werden. Dargestellt als blaue gestrichelte Linie. Umschalten: `Skizze → Sketcher-Geometrien → Konstruktionsmodus umschalten`. Nützlich als Referenz für Constraints oder Symmetrieachsen.

### Kontur
Geschlossener Linienzug in einer Skizze, der die Form einer 3D-Operation (Aufmaß, Tasche) definiert. Für Pad und Pocket muss die Kontur geschlossen sein.

---

## L

### Lineares Muster (Linear Pattern)
Feature, das ein bestehendes Feature in einer Richtung mit festem Abstand vervielfältigt. Aufruf: `Part Design → Lineares Muster`. Gegenstück: [[Glossar FreeCAD#Polares Muster (Polar Pattern)]].

---

## M

### Modellbaum (Model Tree)
Hierarchische Darstellung aller Objekte, Features und Parameter eines FreeCAD-Dokuments im linken Seitenbereich. Zeigt die Entstehungsgeschichte des Modells (parametrischer Baum). Features können im Baum ausgewählt und nachträglich bearbeitet werden.

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
Workbench für die feature-basierte, parametrische Modellierung von Volumenkörpern. Arbeitet mit einem [[Glossar FreeCAD#Body]] und einer Folge von [[Glossar FreeCAD#Feature]]s. Geeignet für Einzelteile aus der Fertigung.

### Pocket
→ siehe [[Glossar FreeCAD#Tasche (Pocket)]]

### Polares Muster (Polar Pattern)
Feature, das ein bestehendes Feature kreisförmig um eine Achse vervielfältigt. Aufruf: `Part Design → Polares Muster`. Nützlich für Bohrungskreise, Kühlrippen etc. Gegenstück: [[Glossar FreeCAD#Lineares Muster (Linear Pattern)]].

### Projektion
→ siehe [[Glossar FreeCAD#Normprojektion]]

---

## R

### Randbedingung
→ siehe [[Glossar FreeCAD#Constraint (Randbedingung)]]

### Revolution
→ siehe [[Glossar FreeCAD#Drehteil (Revolution)]]

---

## S

### Schnittansicht (Section View)
Technische Zeichnungsansicht, bei der das Modell entlang einer Schnittebene aufgetrennt dargestellt wird, um innere Strukturen sichtbar zu machen. Schnittflächen werden schraffiert. Aufruf in *TechDraw*: `TechDraw → Ansicht einfügen → Schnittansicht`.

### Schriftfeld (Title Block)
Tabellenbereich am Rand einer technischen Zeichnung mit Metadaten: Teilename, Maßstab, Zeichnungsnummer, Bearbeiter, Datum, Werkstoff. In *TechDraw* als Teil der Seitenvorlage definiert.

### Sketch
→ siehe [[Glossar FreeCAD#Skizze]]

### Sketcher
Workbench für die Erstellung und Bearbeitung von 2D-Skizzen. Basis für alle *Part Design*-Operationen. Skizzen werden auf einer [[Glossar FreeCAD#Bezugsebene (Datum Plane)]] erstellt.

### Skizze (Sketch)
2D-Zeichnung auf einer Bezugsebene, die als Profil für 3D-Operationen (Aufmaß, Tasche, Drehteil) dient. Eine Skizze besteht aus Geometrieelementen (Linien, Kreise, Bögen) und [[Glossar FreeCAD#Constraint (Randbedingung)|Constraints]]. Aufruf: `Skizze → Skizze erstellen`.

**Farb-Feedback im Sketcher:**
| Farbe | Bedeutung |
|---|---|
| Weiß | Vollständig bestimmt (DOF = 0) |
| Gelb | Unterbeschränkt (DOF > 0) |
| Rot | Überbeschränkt oder Fehler |
| Blau (gestrichelt) | Konstruktionsgeometrie |

### STEP (Standard for the Exchange of Product Data)
Herstellerneutrales Austauschformat für 3D-CAD-Daten (Dateiendung `.step` oder `.stp`). Empfohlenes Format für den Datenaustausch zwischen verschiedenen CAD-Systemen. Export in FreeCAD: `Datei → Exportieren → STEP`.

### Symmetrie (Symmetric)
Geometrischer Constraint, der zwei Elemente spiegelbildlich zu einer Linie oder Achse positioniert. Aufruf: `Skizze → Sketcher-Randbedingungen → Symmetrisch festlegen`.

---

## T

### Tangential
Geometrischer Constraint, der zwei Kurven (Kreis, Bogen, Linie) glatt aneinanderfügt, ohne Knick. Aufruf: `Skizze → Sketcher-Randbedingungen → Tangential festlegen`.

### Tasche (Pocket)
Operation, die Material aus einem bestehenden Volumenkörper entfernt, indem eine Skizzenkontur in den Körper hinein extrudiert wird. Aufruf: `Part Design → Tasche`. Gegenstück: [[Glossar FreeCAD#Aufmaß (Pad)]].

### TechDraw
Workbench zur Ableitung normgerechter technischer Zeichnungen aus 3D-Modellen. Erzeugt 2D-Ansichten (Haupt-, Hilfs-, Schnittansicht) mit Bemaßungen und Schriftfeld.

---

## U

### Unterbeschränkt (Under-Constrained)
Zustand einer Skizze, bei dem noch Freiheitsgrade verbleiben (DOF > 0). Anzeige: gelbe Elemente im Sketcher. Unterbeschränkte Skizzen können für 3D-Operationen verwendet werden, sind aber nicht empfehlenswert, da Änderungen unerwartete Geometrieverschiebungen verursachen können.

---

## V

### Verrundung (Fillet)
Abrundung einer Kante mit einem definierten Radius. Aufruf: `Part Design → Verrundung`. Typisch für Entlastungskerben, ergonomische Formen und Gusskonstruktionen. Gegenstück: [[Glossar FreeCAD#Fase (Chamfer)]].

### Vollständig bestimmt (Fully Constrained)
Zustand einer Skizze mit genau 0 verbleibenden Freiheitsgraden. Alle Geometrieelemente sind durch [[Glossar FreeCAD#Constraint (Randbedingung)|Constraints]] eindeutig positioniert. Anzeige: weiße Elemente im Sketcher. Ziel jeder Skizze vor der 3D-Operation.

### Volumenkörper (Solid)
3D-Objekt mit definiertem Volumen und geschlossener Oberfläche. Gegensatz: Flächen- oder Drahtgittermodell. *Part Design* arbeitet ausschließlich mit Volumenkörpern.

---

## W

### Workbench (Arbeitsumgebung)
Kontext-abhängige Benutzeroberfläche in FreeCAD, die Werkzeuge für einen bestimmten Aufgabenbereich bündelt. Wechsel über das Workbench-Auswahlmenü oben links. Wichtige Workbenches im Kurs:
| Workbench | Zweck |
|---|---|
| *Sketcher* | 2D-Skizzen erstellen |
| *Part Design* | Parametrische 3D-Volumenkörper |
| *Assembly* | Baugruppen aus Einzelteilen |
| *TechDraw* | Technische Zeichnungen ableiten |

---

## Z

### Zeichnungsansicht (View)
Einzelne Projektion eines 3D-Modells in einer technischen Zeichnung (z. B. Vorderansicht, Draufsicht, Seitenansicht). In *TechDraw* über `TechDraw → Ansicht einfügen` hinzugefügt.

---

## Querverweise

- [[M00 FreeCAD Intensivkurs – Kursstruktur]]
- [[Cheat Sheet – Tastenkürzel]]
- [[Cheat Sheet – Sketcher Constraints]]
