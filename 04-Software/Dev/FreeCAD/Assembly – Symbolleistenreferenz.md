# Assembly – Symbolleistenreferenz

> [!info] Über dieses Dokument
> Referenz aller Symbolleistenbefehle der *Assembly*-Workbench (FreeCAD 1.0, deutsche Lokalisierung).
> SVG-Dateien in den Obsidian-Vault-Ordner `_assets/icons/` legen.
> Kurs: [[M00 FreeCAD Intensivkurs – Kursstruktur]]

> [!warning] Versionshinweis
> Die *Assembly*-Workbench ist seit FreeCAD 1.0 nativ integriert. Ältere Tutorials verwenden externe Addons (A2plus, Assembly4) – diese sind mit FreeCAD 1.0 nicht kompatibel und sollten nicht verwendet werden.

---

## Baugruppe verwalten

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Assembly_ActivateAssembly.svg]] | Baugruppe aktivieren | `Assembly → Baugruppe aktivieren` | Aktives Assembly-Dokument für die Bearbeitung aktivieren |
| ![[Assembly_InsertLink.svg]] | Komponente einfügen | `Assembly → Komponente einfügen` | Einzelteil oder Sub-Assembly als verknüpfte Komponente einbinden |
| ![[Assembly_ToggleGrounded.svg]] | Fixierung umschalten | `Assembly → Fixierung umschalten` | Komponente im Raum fixieren (keine Relativbewegung möglich) |
| ![[Assembly_SolveAssembly.svg]] | Baugruppe lösen | `Assembly → Baugruppe lösen` | Joints auflösen und Komponenten entsprechend positionieren |
| ![[Assembly_ExportASMT.svg]] | Als ASMT exportieren | `Assembly → Als ASMT exportieren` | Baugruppe im ASMT-Austauschformat speichern |

---

## Joints (Verbindungen)

Joints definieren die erlaubten Relativbewegungen zwischen zwei Komponenten. Jeder Joint reduziert die Freiheitsgrade des Bauteilpaars.

### Grundlegende Joints

| Symbol | Name | Menüpfad | DOF | Beschreibung |
|---|---|---|---|---|
| ![[Assembly_CreateJointFixed.svg]] | Feste Verbindung | `Assembly → Verbindung erstellen → Feste Verbindung` | 0 | Keine Relativbewegung – Komponenten starr verbunden |
| ![[Assembly_CreateJointRevolute.svg]] | Drehgelenk | `Assembly → Verbindung erstellen → Drehgelenk` | 1 | Rotation um eine gemeinsame Achse |
| ![[Assembly_CreateJointSlider.svg]] | Schieber | `Assembly → Verbindung erstellen → Schieber` | 1 | Translation entlang einer Achse |
| ![[Assembly_CreateJointCylindrical.svg]] | Zylindrisch | `Assembly → Verbindung erstellen → Zylindrische Verbindung` | 2 | Rotation und Translation entlang derselben Achse |
| ![[Assembly_CreateJointBall.svg]] | Kugelgelenk | `Assembly → Verbindung erstellen → Kugelgelenk` | 3 | Rotation um alle drei Achsen (kein Translationsfreiheitsgrad) |
| ![[Assembly_CreateJointPlanar.svg]] | Planare Verbindung | `Assembly → Verbindung erstellen → Planare Verbindung` | 3 | Translation in einer Ebene und Rotation um die Normale |
| ![[Assembly_CreateJointDistance.svg]] | Abstandsverbindung | `Assembly → Verbindung erstellen → Abstandsverbindung` | – | Festen Abstand zwischen zwei Geometrieelementen erzwingen |

### Ausgerichtete Joints

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Assembly_CreateJointParallel.svg]] | Parallele Achsen | `Assembly → Verbindung erstellen → Parallele Achsen` | Zwei Achsen parallel zueinander ausrichten |
| ![[Assembly_CreateJointPerpendicular.svg]] | Senkrechte Achsen | `Assembly → Verbindung erstellen → Senkrechte Achsen` | Zwei Achsen im 90°-Winkel zueinander halten |
| ![[Assembly_CreateJointAngle.svg]] | Winkelverbindung | `Assembly → Verbindung erstellen → Winkelverbindung` | Festen Winkel zwischen zwei Achsen oder Flächen festlegen |
| ![[Assembly_CreateJointTangent.svg]] | Tangentiale Verbindung | `Assembly → Verbindung erstellen → Tangentiale Verbindung` | Zwei Flächen tangential aneinanderlegen |

### Kinematische Joints

| Symbol                                  | Name                | Menüpfad                                                | Beschreibung                                                       |
| --------------------------------------- | ------------------- | ------------------------------------------------------- | ------------------------------------------------------------------ |
| ![[Assembly_CreateJointGears.svg]]      | Zahnradverbindung   | `Assembly → Verbindung erstellen → Zahnradverbindung`   | Kopplung zweier Drehgelenke mit definiertem Übersetzungsverhältnis |
| ![[Assembly_CreateJointPulleys.svg]]    | Riemenverbindung    | `Assembly → Verbindung erstellen → Riemenverbindung`    | Kopplung zweier Drehgelenke über einen Riemen (gleichsinnig)       |
| ![[Assembly_CreateJointRackPinion.svg]] | Zahnstange/Ritzel   | `Assembly → Verbindung erstellen → Zahnstange/Ritzel`   | Kopplung von Rotation und Translation (Ritzel treibt Zahnstange)   |
| ![[Assembly_CreateJointScrew.svg]]      | Schraubenverbindung | `Assembly → Verbindung erstellen → Schraubenverbindung` | Kopplung von Rotation und Translation entlang derselben Achse      |

---

## Explosionsansicht

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Assembly_ExplodedView.svg]] | Explosionsansicht erstellen | `Assembly → Explosionsansicht erstellen` | Neue Explosionsansicht anlegen und Bauteile entlang der Montageachsen auseinanderziehen |

---

## Stückliste

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Assembly_BillOfMaterials.svg]] | Stückliste erstellen | `Assembly → Stückliste erstellen` | Automatische Stückliste aller Komponenten der Baugruppe erzeugen |

---

## Simulation

| Symbol | Name | Menüpfad | Beschreibung |
|---|---|---|---|
| ![[Assembly_CreateSimulation.svg]] | Simulation erstellen | `Assembly → Simulation erstellen` | Bewegungssimulation auf Basis der definierten Joints anlegen |

---

## Hinweise zur Verwendung

> [!tip] Empfohlene Arbeitsreihenfolge
> 1. Neues Assembly-Dokument anlegen (`Datei → Neu`)
> 2. Workbench *Assembly* wählen
> 3. Erste Komponente einfügen und mit ![[Assembly_ToggleGrounded.svg]] fixieren
> 4. Weitere Komponenten mit ![[Assembly_InsertLink.svg]] einfügen
> 5. Joints zwischen den Komponenten definieren
> 6. Mit ![[Assembly_SolveAssembly.svg]] lösen und Positionen prüfen

> [!info] Freiheitsgrade (DOF) in der Baugruppe
> Jede nicht fixierte Komponente hat 6 DOF (3× Translation, 3× Rotation). Jeder Joint reduziert die DOF. Ziel einer vollständig bestimmten Baugruppe: alle beweglichen Komponenten haben nur die gewünschten Freiheitsgrade.

> [!info] Verknüpfte Komponenten
> Über ![[Assembly_InsertLink.svg]] eingefügte Teile sind **Verknüpfungen** auf externe Dokumente – keine Kopien. Änderungen am Originalteil wirken sich automatisch auf die Baugruppe aus.

> [!warning] Sub-Assemblies
> Baugruppen können als Komponente in übergeordnete Baugruppen eingebunden werden. Die Joints des Sub-Assemblys bleiben intern erhalten; nach außen verhält sich das Sub-Assembly wie ein starres Teil, sofern es vollständig bestimmt ist.

---

## Querverweise

- [[PartDesign – Symbolleistenreferenz]]
- [[M06 – Baugruppen & Assembly]]
- [[Glossar FreeCAD#Baugruppe]]
- [[Glossar FreeCAD#Joint (Verbindung)]]
- [[Glossar FreeCAD#Explosionsansicht]]
