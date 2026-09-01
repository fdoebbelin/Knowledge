# M06 – Baugruppen & Assembly

> [!info] Modulübersicht
> **Workbench:** *Assembly* | **Dauer:** 60 min | **Voraussetzung:** [[M05 – Part Design Vertiefung]]
> 
> **Lernziel:** Mehrere Einzelteile zu einer Baugruppe zusammenfügen, über Joints positionieren und eine Explosionsansicht erzeugen.

> [!warning] Versionshinweis
> Die *Assembly*-Workbench ist seit FreeCAD 1.0 nativ integriert. Ältere Tutorials verwenden externe Addons (A2plus, Assembly4) – diese sind mit FreeCAD 1.0 **nicht kompatibel** und dürfen nicht verwendet werden.

---

## Teil 1 – Einführung & Demonstration

### Konzept: Baugruppe und Joints

Eine **Baugruppe** (Assembly) fasst mehrere Einzelteile (**Komponenten**) in einem gemeinsamen Dokument zusammen und definiert ihre räumliche Lage zueinander. Jede Komponente ist eine **Verknüpfung** auf ein externes Part-Design-Dokument – keine Kopie. Ändert sich das Original, aktualisiert sich die Baugruppe automatisch.

Die räumliche Beziehung zwischen zwei Komponenten wird durch **Joints** (Verbindungen) festgelegt. Ein Joint reduziert die Freiheitsgrade ([[Glossar FreeCAD#Freiheitsgrad (DOF)]]) eines Bauteilpaares. Jede frei im Raum schwebende Komponente hat 6 DOF (3× Translation, 3× Rotation).

| Joint | DOF verbleibend | Erlaubte Bewegung |
|---|---|---|
| Feste Verbindung | 0 | keine |
| Drehgelenk | 1 | Rotation um eine Achse |
| Schieber | 1 | Translation entlang einer Achse |
| Zylindrisch | 2 | Rotation + Translation (dieselbe Achse) |
| Kugelgelenk | 3 | Rotation um alle drei Achsen |

> [!tip] Strategie
> Erste Komponente immer **fixieren** – sie ist der Bezugspunkt für alle weiteren Teile.

---

### Demonstration: Scharnier (Sockel + Klappe)

Als Demonstrationsbeispiel dient ein zweiteiliges Scharnier: ein feststehender **Sockel** und eine daran drehbar angelenkte **Klappe**. Die Teile werden als separate Part-Design-Dokumente vorausgesetzt (`sockel.FCStd`, `klappe.FCStd`).

#### Schritt 1 – Assembly-Dokument anlegen

1. `Datei → Neu` – leeres Dokument öffnen.
2. Workbench-Auswahlmenü oben links → *Assembly* wählen.
3. `Datei → Speichern unter` → `scharnier_assembly.FCStd`.

#### Schritt 2 – Sockel einfügen und fixieren

1. ![[Assembly_InsertLink.svg]] `Assembly → Komponente einfügen` → `sockel.FCStd` auswählen → **OK**.
   - Der Sockel erscheint im Ursprung (Position 0, 0, 0) und im Modellbaum als `sockel`.
2. Sockel im Modellbaum auswählen.
3. ![[Assembly_ToggleGrounded.svg]] `Assembly → Fixierung umschalten` – ein Schloss-Symbol erscheint beim Eintrag. Der Sockel ist jetzt im Raum fixiert (0 DOF).

> [!info] Fixierung
> Nur **eine** Komponente pro Baugruppe fixieren. Sie dient als unveränderlicher Bezugspunkt. Alle anderen Teile werden durch Joints relativ dazu positioniert.

#### Schritt 3 – Klappe einfügen

1. ![[Assembly_InsertLink.svg]] `Assembly → Komponente einfügen` → `klappe.FCStd` → **OK**.
   - Die Klappe erscheint zunächst überlappend mit dem Sockel (6 DOF, noch ohne Joint).

#### Schritt 4 – Drehgelenk zwischen Sockel und Klappe setzen

Ein **Drehgelenk** (Revolute Joint) koppelt zwei zylindrische Flächen oder Achsen und erlaubt nur Rotation um die gemeinsame Achse.

1. ![[Assembly_CreateJointRevolute.svg]] `Assembly → Verbindung erstellen → Drehgelenk`.
   - Der Aufgabenbereich öffnet sich und fragt nach zwei Referenzgeometrien.
2. **Referenz 1:** Zylindrische Fläche der Scharnierhülse am **Sockel** anklicken.
3. **Referenz 2:** Zylindrische Fläche des Scharnierbolzens an der **Klappe** anklicken.
4. **OK** – FreeCAD positioniert die Klappe auf dem Sockel; beide Achsen fluchten.

> [!example] Referenzauswahl
> Als Referenzen eignen sich zylindrische **Flächen** (FreeCAD leitet die Achse automatisch ab) oder explizit erstellte **Bezugsachsen** aus *Part Design*. Flächen sind im Normalfall einfacher zu selektieren.

#### Schritt 5 – Baugruppe lösen

1. ![[Assembly_SolveAssembly.svg]] `Assembly → Baugruppe lösen`.
   - FreeCAD berechnet die Positionen aller Komponenten anhand der Joints und zeigt die Baugruppe in korrekter Lage.
2. Ergebnis prüfen: Klappe sitzt am Sockel, lässt sich in der 3D-Ansicht durch Ziehen am Modell um die Scharnierachse drehen (kinematische Vorschau).

#### Schritt 6 – Speichern

`Strg+S`

---

## Teil 2 – Übungen

### Aufgabe 1 – Stift in Bohrung (Feste Verbindung) ⬜

**Ziel:** Zwei Teile starr miteinander verbinden – ein zylindrischer Stift soll bündig in einer Bohrung sitzen.

**Voraussetzung:** Zwei Dokumente vorab modellieren (je ca. 5 min):
- `platte.FCStd` – Quader (60 × 40 × 10 mm) mit einer Durchgangsbohrung ∅ 8 mm mittig
- `stift.FCStd` – Zylinder ∅ 8 mm, Höhe 20 mm

**Teilschritte:**

1. Neues Assembly-Dokument `stift_assembly.FCStd` anlegen, Workbench *Assembly* wählen.
2. `platte.FCStd` einfügen und fixieren (![[Assembly_ToggleGrounded.svg]]).
3. `stift.FCStd` einfügen.
4. ![[Assembly_CreateJointFixed.svg]] `Assembly → Verbindung erstellen → Feste Verbindung` setzen:
   - Referenz 1: Kreisfläche (oben) der Bohrung in der Platte.
   - Referenz 2: Kreisfläche (unten) des Stifts.
5. ![[Assembly_SolveAssembly.svg]] Lösen → Stift sitzt in der Bohrung.
6. Speichern.

**Erwartetes Ergebnis:** Stift ragt mittig durch die Bohrung; keine Relativbewegung möglich. Im Modellbaum erscheint `Joint (Fixed)`.

> [!tip] Flächen vs. Achsen
> Beim Feste-Verbindung-Joint empfiehlt sich die Auswahl **planarer Flächen**, die aufeinanderliegen sollen (hier: Unterseite Stift auf Oberseite Platte). FreeCAD richtet die Flächen automatisch aus.

---

### Aufgabe 2 – Schublade (Schieber-Joint) ⬜

**Ziel:** Eine Schublade soll sich linear in einem Rahmen vor- und zurückbewegen können.

**Voraussetzung:**
- `rahmen.FCStd` – U-Profil (80 × 60 × 10 mm, Wandstärke 5 mm, oben offen)
- `schublade.FCStd` – Quader (70 × 50 × 30 mm), passend in den Rahmen

**Teilschritte:**

1. Neues Assembly-Dokument `schublade_assembly.FCStd`, Workbench *Assembly*.
2. `rahmen.FCStd` einfügen, fixieren.
3. `schublade.FCStd` einfügen.
4. ![[Assembly_CreateJointSlider.svg]] `Assembly → Verbindung erstellen → Schieber`:
   - Referenz 1: Längsfläche (Innenseite) des Rahmens.
   - Referenz 2: Seitenfläche der Schublade (parallel zur Rahmenfläche).
5. ![[Assembly_SolveAssembly.svg]] Lösen.
6. Schublade in der 3D-Ansicht entlang der Achse ziehen → nur lineare Bewegung erlaubt.
7. Speichern.

**Erwartetes Ergebnis:** Schublade gleitet entlang der Y-Achse (oder der gewählten Richtung); Rotation ist gesperrt. Im Modellbaum: `Joint (Slider)`.

> [!warning] Richtungskontrolle
> Sitzt die Schublade nach dem Lösen außerhalb des Rahmens, stimmt die Ausrichtung der Referenzflächen nicht überein. Joint löschen, Flächen neu wählen – diesmal auf **gegenüberliegenden** Seiten.

---

### Aufgabe 3 – Explosionsansicht & Stückliste ⬜

**Ziel:** Aus dem Scharnier-Assembly (Demonstration) eine Explosionsansicht erzeugen und eine Stückliste ausgeben.

**Teilschritte:**

**Explosionsansicht:**

1. `scharnier_assembly.FCStd` öffnen.
2. ![[Assembly_ExplodedView.svg]] `Assembly → Explosionsansicht erstellen`.
   - Ein neuer Eintrag `ExplodedView` erscheint im Modellbaum.
3. Im Aufgabenbereich jede Komponente auswählen und mit dem **Versatz**-Eingabefeld entlang einer Achse auseinanderziehen:
   - Klappe: Z-Versatz +50 mm.
4. **OK** – Explosionsansicht ist gespeichert und kann über den Modellbaum ein-/ausgeschaltet werden (`Leertaste`).

**Stückliste:**

5. ![[Assembly_BillOfMaterials.svg]] `Assembly → Stückliste erstellen`.
   - FreeCAD erzeugt eine Tabelle im Modellbaum (`BillOfMaterials`) mit Teilename, Anzahl und (falls hinterlegt) Material.
6. Tabelle im Modellbaum doppelklicken → Inhalte prüfen.
7. Speichern.

**Erwartetes Ergebnis:** In der 3D-Ansicht sind Sockel und Klappe räumlich getrennt dargestellt. Die Stückliste zeigt zwei Einträge: `sockel × 1`, `klappe × 1`.

> [!example] Verwendung in TechDraw
> Die Explosionsansicht kann in *TechDraw* als reguläre Ansicht eingefügt werden (`TechDraw → Ansicht einfügen`). Damit lässt sich eine normgerechte Montageanleitung mit Positionsnummern erstellen – sinnvoll im [[M07 – Technische Zeichnung|Modul 07]] und im [[M08 – Abschlussprojekt]].

---

## Zusammenfassung

| Konzept | Kern |
|---|---|
| Komponente | Verknüpfung auf externes Dokument – kein eigenständiges Modell |
| Fixierung | Erste Komponente fixieren, alle weiteren per Joint positionieren |
| Joint-Wahl | Entspricht der realen Bewegungsfreiheit des Bauteils |
| Lösen | Immer nach dem Setzen von Joints ausführen – prüft Konsistenz |
| Explosionsansicht | Separates Feature im Modellbaum, nicht destruktiv |

---

## Querverweise

- [[Assembly – Symbolleistenreferenz]]
- [[M05 – Part Design Vertiefung]]
- [[M07 – Technische Zeichnung]]
- [[M08 – Abschlussprojekt]]
- [[Glossar FreeCAD#Baugruppe]]
- [[Glossar FreeCAD#Joint (Verbindung)]]
- [[Glossar FreeCAD#Freiheitsgrad (DOF)]]
- [[Glossar FreeCAD#Explosionsansicht]]
