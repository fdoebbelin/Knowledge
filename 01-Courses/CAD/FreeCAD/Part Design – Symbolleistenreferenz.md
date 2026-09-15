# Part Design – Symbolleistenreferenz

> [!info] Über dieses Dokument
> Referenz aller Symbolleistenbefehle der *Part Design*-Workbench (FreeCAD 1.0, deutsche Lokalisierung).
> SVG-Dateien in den Obsidian-Vault-Ordner `_assets/icons/` legen.
> Kurs: [[M00 FreeCAD Intensivkurs – Kursstruktur]]

---

## Body & Bezugselemente

### Body verwalten

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_Body.svg]] | Body erstellen | `Part Design → Body` | Neuen Body-Container für ein Part-Design-Modell anlegen |
| ![[PartDesign_Clone.svg]] | Klon erstellen | `Part Design → Klon erstellen` | Abhängige Kopie eines Bodies erstellen |
| ![[PartDesign_Migrate.svg]] | Migrieren | `Part Design → Migrieren` | Älteres FreeCAD-Modell in das Body-Konzept überführen |

### Bezugselemente (Datum Features)

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_Plane.svg]] | Bezugsebene erstellen | `Part Design → Bezugselemente → Bezugsebene erstellen` | Virtuelle Referenzebene für Skizzen oder Spiegeloperationen |
| ![[PartDesign_Line.svg]] | Bezugsachse erstellen | `Part Design → Bezugselemente → Bezugsachse erstellen` | Virtuelle Achse als Rotations- oder Musterreferenz |
| ![[PartDesign_Point.svg]] | Bezugspunkt erstellen | `Part Design → Bezugselemente → Bezugspunkt erstellen` | Virtueller Referenzpunkt im Raum |
| ![[PartDesign_CoordinateSystem.svg]] | Lokales Koordinatensystem | `Part Design → Bezugselemente → Lokales Koordinatensystem erstellen` | Benutzerdefiniertes Koordinatensystem als Referenz |

### Shape Binder

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_ShapeBinder.svg]] | Shape Binder | `Part Design → Shape Binder erstellen` | Geometrie eines anderen Bodies als Referenz einbinden |
| ![[PartDesign_SubShapeBinder.svg]] | Sub-Shape Binder | `Part Design → Sub-Shape Binder erstellen` | Einzelne Flächen oder Kanten eines anderen Bodies referenzieren |

---

## Additive Operationen (Material hinzufügen)

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_Pad.svg]] | Aufmaß (Pad) | `Part Design → Aufmaß` | Skizze entlang einer Achse zu einem Volumenkörper extrudieren |
| ![[PartDesign_Revolution.svg]] | Drehteil (Revolution) | `Part Design → Drehteil` | Skizze um eine Achse zu einem Rotationskörper drehen |
| ![[PartDesign_AdditiveLoft.svg]] | Additives Loft | `Part Design → Additives Loft` | Volumenkörper durch Verbinden mehrerer Profilskizzen erzeugen |
| ![[PartDesign_AdditivePipe.svg]] | Additives Rohr | `Part Design → Additives Rohr` | Profilskizze entlang eines Pfades extrudieren |
| ![[PartDesign_AdditiveHelix.svg]] | Additive Helix | `Part Design → Additive Helix` | Schraubenförmigen Körper entlang einer Achse erzeugen |

### Additive Grundkörper

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_AdditiveBox.svg]] | Additiver Quader | `Part Design → Grundkörper erstellen → Additiver Quader` | Quader direkt ohne Skizze hinzufügen |
| ![[PartDesign_AdditiveCylinder.svg]] | Additiver Zylinder | `Part Design → Grundkörper erstellen → Additiver Zylinder` | Zylinder direkt ohne Skizze hinzufügen |
| ![[PartDesign_AdditiveSphere.svg]] | Additive Kugel | `Part Design → Grundkörper erstellen → Additive Kugel` | Kugel direkt ohne Skizze hinzufügen |
| ![[PartDesign_AdditiveCone.svg]] | Additiver Kegel | `Part Design → Grundkörper erstellen → Additiver Kegel` | Kegel direkt ohne Skizze hinzufügen |
| ![[PartDesign_AdditiveTorus.svg]] | Additiver Torus | `Part Design → Grundkörper erstellen → Additiver Torus` | Torus direkt ohne Skizze hinzufügen |
| ![[PartDesign_AdditivePrism.svg]] | Additives Prisma | `Part Design → Grundkörper erstellen → Additives Prisma` | Prisma mit regelmäßigem Querschnitt hinzufügen |
| ![[PartDesign_AdditiveEllipsoid.svg]] | Additives Ellipsoid | `Part Design → Grundkörper erstellen → Additives Ellipsoid` | Ellipsoid direkt ohne Skizze hinzufügen |
| ![[PartDesign_AdditiveWedge.svg]] | Additiver Keil | `Part Design → Grundkörper erstellen → Additiver Keil` | Keil direkt ohne Skizze hinzufügen |

---

## Subtraktive Operationen (Material entfernen)

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_Pocket.svg]] | Tasche (Pocket) | `Part Design → Tasche` | Skizzenkontur in Körper hineinextrudieren und Material entfernen |
| ![[PartDesign_Hole.svg]] | Bohrung (Hole) | `Part Design → Bohrung` | Normgerechte Bohrung mit Gewinde, Senkung und Toleranz erzeugen |
| ![[PartDesign_Groove.svg]] | Nut (Groove) | `Part Design → Nut` | Skizze um eine Achse drehen und Material entfernen |
| ![[PartDesign_SubtractiveLoft.svg]] | Subtraktives Loft | `Part Design → Subtraktives Loft` | Material durch Verbinden mehrerer Profilskizzen entfernen |
| ![[PartDesign_SubtractivePipe.svg]] | Subtraktives Rohr | `Part Design → Subtraktives Rohr` | Material entlang eines Pfades entfernen |
| ![[PartDesign_SubtractiveHelix.svg]] | Subtraktive Helix | `Part Design → Subtraktive Helix` | Schraubenförmiges Material entfernen (z. B. für Gewinde) |

### Subtraktive Grundkörper

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_SubtractiveBox.svg]] | Subtraktiver Quader | `Part Design → Grundkörper erstellen → Subtraktiver Quader` | Quader direkt aus Körper herausschneiden |
| ![[PartDesign_SubtractiveCylinder.svg]] | Subtraktiver Zylinder | `Part Design → Grundkörper erstellen → Subtraktiver Zylinder` | Zylinder direkt aus Körper herausschneiden |
| ![[PartDesign_SubtractiveSphere.svg]] | Subtraktive Kugel | `Part Design → Grundkörper erstellen → Subtraktive Kugel` | Kugel direkt aus Körper herausschneiden |
| ![[PartDesign_SubtractiveCone.svg]] | Subtraktiver Kegel | `Part Design → Grundkörper erstellen → Subtraktiver Kegel` | Kegel direkt aus Körper herausschneiden |
| ![[PartDesign_SubtractiveTorus.svg]] | Subtraktiver Torus | `Part Design → Grundkörper erstellen → Subtraktiver Torus` | Torus direkt aus Körper herausschneiden |
| ![[PartDesign_SubtractivePrism.svg]] | Subtraktives Prisma | `Part Design → Grundkörper erstellen → Subtraktives Prisma` | Prisma direkt aus Körper herausschneiden |
| ![[PartDesign_SubtractiveEllipsoid.svg]] | Subtraktives Ellipsoid | `Part Design → Grundkörper erstellen → Subtraktives Ellipsoid` | Ellipsoid direkt aus Körper herausschneiden |
| ![[PartDesign_SubtractiveWedge.svg]] | Subtraktiver Keil | `Part Design → Grundkörper erstellen → Subtraktiver Keil` | Keil direkt aus Körper herausschneiden |

---

## Kantenbearbeitung

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_Fillet.svg]] | Verrundung | `Part Design → Verrundung` | Ausgewählte Kanten mit einem definierten Radius abrunden |
| ![[PartDesign_Chamfer.svg]] | Fase | `Part Design → Fase` | Ausgewählte Kanten mit einem definierten Winkel abschrägen |
| ![[PartDesign_Draft.svg]] | Formschräge | `Part Design → Formschräge` | Flächen für Entformung (Guss/Spritzguss) schräg stellen |
| ![[PartDesign_Thickness.svg]] | Wandstärke | `Part Design → Wandstärke` | Volumenkörper in eine dünnwandige Schale umwandeln |

---

## Muster & Transformationen

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_Mirrored.svg]] | Gespiegeltes Objekt | `Part Design → Gespiegeltes Objekt` | Feature oder Feature-Gruppe an einer Ebene spiegeln |
| ![[PartDesign_LinearPattern.svg]] | Lineares Muster | `Part Design → Lineares Muster` | Feature in einer Richtung mit festem Abstand vervielfältigen |
| ![[PartDesign_PolarPattern.svg]] | Polares Muster | `Part Design → Polares Muster` | Feature kreisförmig um eine Achse vervielfältigen |
| ![[PartDesign_MultiTransform.svg]] | Mehrfachtransformation | `Part Design → Mehrfachtransformation` | Mehrere Transformationen (Muster, Spiegeln) kombinieren |
| ![[PartDesign_Scaled.svg]] | Skaliert | `Part Design → Skaliert` | Feature innerhalb einer Mehrfachtransformation skalieren |

---

## Boolesche Operationen

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_Boolean.svg]] | Boolesche Operation | `Part Design → Boolesche Operation` | Zwei Bodies durch Vereinigung, Schnitt oder Differenz verknüpfen |

---

## Spezialgeometrie

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_Sprocket.svg]] | Kettenrad | `Part Design → Kettenrad` | Normgerechtes Kettenrad nach Zähnezahl und Teilung erzeugen |
| ![[PartDesign_InternalExternalGear.svg]] | Zahnrad | `Part Design → Evolventenverzahnung` | Innen- oder Außenverzahnung nach Modul und Zähnezahl erzeugen |

---

## Modellbaum verwalten

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[PartDesign_MoveTip.svg]] | Tip setzen | `Part Design → Tip setzen` | Aktives End-Feature des Bodies festlegen (bestimmt sichtbaren Modellzustand) |
| ![[PartDesign_MoveFeature.svg]] | Feature in anderen Body verschieben | `Part Design → Feature in anderen Body verschieben` | Feature aus aktuellem Body in einen anderen Body übertragen |
| ![[PartDesign_MoveFeatureInTree.svg]] | Feature im Baum verschieben | `Part Design → Feature im Baum verschieben` | Reihenfolge der Features im Modellbaum ändern |

---

## Hinweise zur Verwendung

> [!info] Additive vs. subtraktive Operationen
> Alle Operationen in *Part Design* sind entweder **additiv** (Material hinzufügen) oder **subtraktiv** (Material entfernen). Das Gegenstückprinzip gilt durchgehend: ![[PartDesign_Pad.svg]] Aufmaß ↔ ![[PartDesign_Pocket.svg]] Tasche, ![[PartDesign_Revolution.svg]] Drehteil ↔ ![[PartDesign_Groove.svg]] Nut.

> [!tip] Grundkörper vs. Skizzenoperationen
> Additive und subtraktive Grundkörper (Quader, Zylinder …) benötigen keine Skizze – sie werden direkt parametrisch definiert. Für komplexe Formen immer den Skizzen-basierten Weg (Pad, Pocket) verwenden.

> [!warning] Ein Body – ein zusammenhängender Körper
> Jeder *Part Design*-Body muss zu jedem Zeitpunkt einen zusammenhängenden Volumenkörper ergeben. Operationen, die den Körper in mehrere Teile aufteilen würden, schlagen fehl. Für Mehrkörper-Modelle separate Bodies anlegen und über ![[PartDesign_Boolean.svg]] Boolesche Operationen oder die *Assembly*-Workbench verbinden.

---

## Querverweise

- [[Sketcher – Symbolleistenreferenz]]
- [[Cheat Sheet – Tastenkürzel]]
- [[M04 – Part Design Grundlagen]]
- [[M05 – Part Design Vertiefung]]
- [[Glossar FreeCAD#Body]]
- [[Glossar FreeCAD#Feature]]
- [[Glossar FreeCAD#Aufmaß (Pad)]]
- [[Glossar FreeCAD#Tasche (Pocket)]]
