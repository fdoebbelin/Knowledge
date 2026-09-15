# M03 – Sketcher Constraints

> [!info] Modulinfo
> **Workbench:** *Sketcher* | **Dauer:** 90 min | **Voraussetzung:** [[M02 – Sketcher Grundlagen]]
> Kurs: [[M00 FreeCAD Intensivkurs – Kursstruktur]]

---

## Lernziel

Skizzen durch geometrische und maßliche Randbedingungen vollständig bestimmen (DOF = 0), häufige Fehlerquellen erkennen und Konstruktionsgeometrie als Hilfsmittel einsetzen.

---

## 1. Einführung

### Freiheitsgrade und Constraints

Eine neu gezeichnete Skizze ist **unterbeschränkt** – ihre Elemente können sich noch frei verschieben oder drehen. Ein **Constraint (Randbedingung)** schränkt genau diese Freiheitsgrade (Degrees of Freedom, DOF) ein.

| DOF | Farbe im Sketcher | Bedeutung |
|---|---|---|
| 0 | Weiß | Vollständig bestimmt – bereit für 3D-Operation |
| > 0 | Gelb | Unterbeschränkt – weitere Constraints nötig |
| Konflikt | Rot | Überbeschränkt – widersprüchliche Constraints entfernen |
| – | Blau gestrichelt | Konstruktionsgeometrie – kein Beitrag zur Kontur |

Die aktuelle DOF-Anzahl zeigt FreeCAD im **Aufgabenbereich** links oben an (`Freiheitsgrade: n`). Ziel jeder Skizze vor einer 3D-Operation: **0 DOF**.

> [!tip] Empfohlene Reihenfolge
> 1. Geometrie grob zeichnen (Maße egal)
> 2. Geometrische Constraints setzen (Horizontal, Vertikal, Koinzidenz …)
> 3. Maßliche Constraints setzen (Abstand, Radius, Winkel)
> 4. DOF-Anzeige prüfen → Ziel: 0

---

### Geometrische Constraints

Legen **Beziehungen** zwischen Elementen fest – ohne konkreten Zahlenwert.

| Constraint | Kürzel | Wirkung |
|---|---|---|
| Koinzidenz | `C`, `O` | Zwei Punkte auf dieselbe Position zwingen – schließt Konturen |
| Horizontal | `C`, `H` | Linie exakt waagerecht ausrichten |
| Vertikal | `C`, `V` | Linie exakt senkrecht ausrichten |
| Parallel | `C`, `P` | Zwei Linien parallel zueinander |
| Rechtwinklig | `C`, `R` | Zwei Linien im 90°-Winkel |
| Tangential | `C`, `T` | Kurven knickfrei aneinanderfügen |
| Gleiche Länge/Radius | – | Zwei Linien gleich lang oder zwei Kreise/Bögen gleich groß |
| Symmetrisch | `C`, `S` | Zwei Punkte spiegelbildlich zu einer Achse |
| Punkt auf Objekt | – | Punkt liegt auf Linie, Kreis oder Bogen |

> [!info] Shortcuts im Sketcher sind zweiteilig
> Erst `C` (Constraint), dann den Buchstaben – kurz nacheinander drücken, nicht gleichzeitig.

---

### Maßliche Constraints

Legen **konkrete Zahlenwerte** fest. Der Eingabedialog öffnet sich automatisch.

| Constraint | Kürzel | Menüpfad |
|---|---|---|
| Abstand (Länge oder Punktabstand) | `C`, `D` | `Skizze → Sketcher-Randbedingungen → Abstand festlegen` |
| Horizontaler Abstand | `C`, `I` | `Skizze → Sketcher-Randbedingungen → Horizontalen Abstand festlegen` |
| Vertikaler Abstand | `C`, `J` | `Skizze → Sketcher-Randbedingungen → Vertikalen Abstand festlegen` |
| Radius / Durchmesser | `C`, `N` | `Skizze → Sketcher-Randbedingungen → Radius oder Gewicht festlegen` |
| Winkel | `C`, `A` | `Skizze → Sketcher-Randbedingungen → Winkel festlegen` |

> [!tip] Radius vs. Durchmesser
> Beim Setzen von `C`, `N` auf einen Kreis öffnet sich ein Dialog mit einem Umschalter zwischen Radius und Durchmesser. Für technische Zeichnungen ist Durchmesser üblich (ø-Bemaßung).

---

### Konstruktionsgeometrie

**Konstruktionsgeometrie** sind Hilfslinien innerhalb einer Skizze, die bei Pad, Pocket und anderen 3D-Operationen ignoriert werden. Sie erscheinen blau gestrichelt und dienen als Referenz für Constraints – z. B. als Symmetrieachse oder Hilfskreis für Lochkreise.

Umschalten für ausgewählte Elemente: `Skizze → Sketcher-Geometrien → Konstruktionsmodus umschalten`

---

### Demonstration: Rechteck vollständig bestimmen

**Ausgangssituation:** Offene *Sketcher*-Skizze auf der XY-Ebene, ein grob gezeichnetes Rechteck (gelb, DOF > 0).

**Schritt 1 – Koinzidenz prüfen:**
Vier Linien eines per Hand gezeichneten Rechtecks teilen sich die Eckpunkte nicht automatisch. Jeden Eckpunkt der angrenzenden Linien auswählen (Endpunkte nacheinander anklicken) und `C`, `O` drücken. Nach vier Koinzidenzen ist das Rechteck geschlossen.

> [!info]
> Ein mit `G`, `R` (Rechteck-Werkzeug) erzeugtes Rechteck ist bereits geschlossen – Koinzidenzen werden automatisch gesetzt.

**Schritt 2 – Lage am Ursprung fixieren:**
Unteren linken Eckpunkt und den Ursprung (0, 0) auswählen → `C`, `O`. Damit ist der Eckpunkt auf den Koordinatenursprung gezwungen (2 DOF entfernt).

**Schritt 3 – Ausrichtung fixieren:**
Untere Linie auswählen → `C`, `H` (Horizontal). Linke Linie auswählen → `C`, `V` (Vertikal). Die übrigen Linien sind damit implizit ausgerichtet (Koinzidenzen übertragen die Constraints).

**Schritt 4 – Maße setzen:**
Untere Linie auswählen → `C`, `D` → `80` eingeben → `Enter`. Linke Linie auswählen → `C`, `D` → `50` eingeben → `Enter`.

**Ergebnis:** DOF = 0, alle Linien weiß. Das Rechteck hat die Maße 80 × 50 mm und seinen Ursprung in der linken unteren Ecke.

---

### Demonstration: Konstruktionsgeometrie als Symmetrieachse

**Ziel:** Kreis auf der Symmetrieachse eines Rechtecks positionieren, ohne die X-Position explizit zu bemaßen.

1. Vertikale Mittellinie des Rechtecks mit `G`, `L` zeichnen (von Mittelpunkt Oberkante zu Mittelpunkt Unterkante, grob).
2. Mittellinie auswählen → `Skizze → Sketcher-Geometrien → Konstruktionsmodus umschalten` → Linie wird blau gestrichelt.
3. `C`, `V` auf die Hilfslinie setzen.
4. Mittelpunkte der Ober- und Unterkante je mit einem Endpunkt der Hilfslinie koinzident setzen (`C`, `O`).
5. Kreis mit `G`, `C` zeichnen, Mittelpunkt auf der Hilfslinie platzieren.
6. `Skizze → Sketcher-Randbedingungen → Punkt auf Objekt festlegen` – Kreismittelpunkt auf die Hilfslinie zwingen.
7. Vertikalen Abstand des Kreismittelpunkts zur Unterkante bemaßen: Kreismittelpunkt und untere Linie auswählen → `C`, `J` → Wert eingeben.
8. Radius setzen: Kreis auswählen → `C`, `N` → Wert eingeben.

**Ergebnis:** Der Kreis sitzt exakt mittig, ohne dass ein horizontales Maß gesetzt wurde – die Symmetrie ist durch die Konstruktionslinie erzwungen.

---

## 2. Übungen

### Aufgabe 1 – Profilskizze: T-Profil *(Grundniveau)*

**Ziel:** Ein T-förmiges Profil vollständig bestimmen (0 DOF).

**Vorgabe:** Die Skizze soll folgendes T-Profil abbilden:
- Gesamtbreite: 60 mm, Gesamthöhe: 50 mm
- Steg: 20 mm breit, 30 mm hoch (mittig)
- Flansch (oberer Querbalken): 60 mm breit, 20 mm hoch

**Teilschritte:**

1. Neue Skizze auf der XY-Ebene anlegen: `Skizze → Skizze erstellen`.
2. T-Kontur mit dem Linienwerkzeug (`G`, `L`) grob zeichnen – 8 Liniensegmente, die das T umschließen. Maße ignorieren.
3. Alle Eckpunkte durch Koinzidenz verbinden (`C`, `O`), sodass die Kontur geschlossen ist. Die DOF-Anzeige sinkt mit jedem gesetzten Constraint.
4. Horizontale Linien mit `C`, `H`, vertikale mit `C`, `V` ausrichten.
5. Ursprungspunkt (0, 0) mit dem unteren linken Eckpunkt koinzident setzen (`C`, `O`).
6. Maße setzen:
   - Gesamtbreite 60 mm (`C`, `D` auf untere Linie)
   - Gesamthöhe 50 mm (`C`, `D` auf linke Außenlinie)
   - Stegbreite 20 mm (`C`, `D`)
   - Flanshhöhe 20 mm (`C`, `D`)
   - Steg horizontal zentrieren: Symmetrie-Constraint (`C`, `S`) zwischen linkem und rechtem Stegpunkt mit der Y-Achse als Symmetrieachse, *oder* horizontalen Abstand des Stegs von der linken Außenkante mit 20 mm bemaßen.
7. DOF-Anzeige prüfen → muss 0 sein, alle Linien weiß.
8. Skizze schließen: `Skizze → Skizze schließen`.

**Erwartetes Ergebnis:** T-Profil, weiß, 0 DOF, Ursprung in der unteren linken Ecke.

> [!tip]
> Wenn einzelne Linien nach dem Ausrichten noch gelb bleiben, fehlt meist eine Koinzidenz an einem Eckpunkt – mit der Maus über die Endpunkte fahren, um zu prüfen, ob sie wirklich zusammenliegen.

---

### Aufgabe 2 – Lochkreis mit Konstruktionsgeometrie *(mittleres Niveau)*

**Ziel:** Einen Flansch mit vier gleichmäßig angeordneten Bohrungen als Skizze erstellen.

**Vorgabe:**
- Außenkreis: ø 80 mm, Mittelpunkt im Ursprung
- Vier Bohrungen: ø 8 mm, auf einem Lochkreis ø 60 mm, je 90° versetzt

**Teilschritte:**

1. Neue Skizze auf der XY-Ebene anlegen.
2. Außenkreis zeichnen (`G`, `C`), Mittelpunkt auf den Ursprung setzen (`C`, `O`), Radius mit `C`, `N` auf 40 mm (= ø 80 mm) setzen.
3. Hilfskreis für den Lochkreis zeichnen (`G`, `C`), Mittelpunkt ebenfalls auf den Ursprung (`C`, `O`), Radius mit `C`, `N` auf 30 mm setzen.
4. Hilfskreis zur Konstruktionsgeometrie machen: Hilfskreis auswählen → `Skizze → Sketcher-Geometrien → Konstruktionsmodus umschalten`.
5. Hilfslinie vertikal und horizontal durch den Ursprung zeichnen (je eine Linie, Konstruktionsmodus). Diese definieren die 0°/90°/180°/270°-Positionen.
6. Vier Bohrungskreise (`G`, `C`) zeichnen, Mittelpunkte grob auf den Hilfskreis platzieren.
7. Jeden Bohrungsmittelpunkt mit `Skizze → Sketcher-Randbedingungen → Punkt auf Objekt festlegen` auf den Hilfskreis zwingen.
8. Je zwei gegenüberliegende Bohrungsmittelpunkte mit `C`, `S` (Symmetrisch) zur X-Achse bzw. Y-Achse spiegeln.
9. Alle vier Bohrungskreise auf denselben Radius zwingen: alle vier Kreise auswählen → `Skizze → Sketcher-Randbedingungen → Gleiche Beschränkungen festlegen`. Dann einen Kreis auswählen und Radius 4 mm setzen (`C`, `N`).
10. DOF prüfen → 0.

**Erwartetes Ergebnis:** Flanskizze mit Außenkreis und vier gleichen Bohrungen auf dem Lochkreis, vollständig weiß.

> [!warning]
> Den Hilfskreis und die Hilfslinien **vor** dem Setzen der Punkt-auf-Objekt-Constraints in den Konstruktionsmodus schalten. Andernfalls werden sie als Konturelemente interpretiert, was das spätere Pad fehlschlagen lässt.

---

### Aufgabe 3 – Kontur mit Tangentialübergängen *(erhöhtes Niveau)*

**Ziel:** Ein langlochähnliches Profil (Oblong) aus zwei Halbkreisen und zwei Geraden vollständig bestimmen, ohne redundante Constraints zu erzeugen.

**Vorgabe:**
- Gesamtlänge: 70 mm, Breite: 30 mm (= Bogendurchmesser)
- Mittelachse horizontal, Mittelpunkt im Ursprung

**Teilschritte:**

1. Neue Skizze auf der XY-Ebene anlegen.
2. Geometrie zeichnen:
   - Obere Linie (`G`, `L`), untere Linie, linken Halbkreis (`G`, `A`), rechten Halbkreis grob platzieren.
3. Tangentialübergänge setzen:
   - Linkes Linienende + linker Bogenendpunkt → `C`, `O` (Koinzidenz).
   - Linie + Bogen → `C`, `T` (Tangential). Gleiche Schritte für alle vier Übergänge.
4. Ausrichtung:
   - Obere Linie → `C`, `H`, untere Linie → `C`, `H`.
   - Mittelpunkt des linken Bogens und Mittelpunkt des rechten Bogens → `C`, `H` (beide auf gleicher Höhe).
5. Symmetrie zur X-Achse: Mittelpunkt des linken Bogens mit dem Ursprung koinzident setzen (`C`, `O`) geht **nicht** direkt, da der Mittelpunkt dann auf 0,0 läge. Stattdessen: Mittelpunkt des linken Bogens auf die X-Achse zwingen (`Skizze → Sketcher-Randbedingungen → Punkt auf Objekt festlegen`, X-Achse als Objekt wählen). Gleich für rechten Bogen.
6. Symmetrie der Bögen zur Y-Achse: Beide Bogenmittelpunkte auswählen + Y-Achse → `C`, `S`.
7. Maße:
   - Abstand der beiden Bogenmittelpunkte: `C`, `I` → 40 mm (ergibt Gesamtlänge 40 + 30 = 70 mm).
   - Radius beider Bögen mit Gleiche Beschränkungen angleichen, dann einen Radius setzen: `C`, `N` → 15 mm.
8. DOF prüfen → 0.

**Erwartetes Ergebnis:** Symmetrisches Oblong, vollständig weiß, Gesamtlänge 70 mm, Breite 30 mm.

> [!warning] Häufige Fehler bei Tangentialübergängen
> - Koinzidenz **und** Tangential müssen gesetzt werden – Tangential allein reicht nicht, um die Punkte zu verbinden.
> - Horizontal-Constraint auf eine Linie **und** einen Winkel-Constraint von 0° auf dieselbe Linie → Überbeschränkung (rot). Immer nur einen der beiden verwenden.

---

## Zusammenfassung

| Constraint-Typ | Wann einsetzen |
|---|---|
| Koinzidenz | Immer zuerst – Kontur schließen |
| Horizontal / Vertikal | Ausrichtung achsenparalleler Elemente |
| Tangential | Knickfreie Kurvenübergänge |
| Symmetrisch | Spiegelsymmetrische Geometrie ohne zweifache Bemaßung |
| Gleiche Länge / Gleicher Radius | Gleichartige Elemente ohne individuelle Bemaßung |
| Abstand / Radius / Winkel | Alle verbleibenden Freiheitsgrade durch Maße schließen |

> [!info] Reihenfolge schlägt Vollständigkeit
> Eine strukturierte Reihenfolge (erst geometrische, dann maßliche Constraints) erzeugt weniger Überbeschränkungen als das ungeordnete Setzen aller Constraints auf einmal.

---

## Querverweise

- [[Cheat Sheet – Sketcher Constraints]] – Vollständige Constraint-Referenz mit allen Kürzeln
- [[Cheat Sheet – Tastenkürzel]] – Alle Sketcher-Shortcuts
- [[Sketcher – Symbolleistenreferenz]] – Symbolreferenz mit Icons
- [[Glossar FreeCAD#Constraint (Randbedingung)]]
- [[Glossar FreeCAD#Freiheitsgrad (DOF)]]
- [[Glossar FreeCAD#Konstruktionsgeometrie]]
- [[Glossar FreeCAD#Vollständig bestimmt]]
- [[M02 – Sketcher Grundlagen]] ← Vorheriges Modul
- [[M04 – Part Design Grundlagen]] → Nächstes Modul
