# M12 – Wände, Böden & Decken

> [!info] Modulinfo
> **Workbench:** *BIM* | **Dauer:** 90 min | **Voraussetzung:** [[M11 – BIM-Workbench & Projektstruktur]]
> **Lernziel:** Einen vollständigen Raumkörper aus vier Wänden, Boden und Decke parametrisch modellieren und Wandparameter nachträglich ändern.

---

## Einführung

### Wand (Wall)

Eine **Wand** ist in der *BIM*-Workbench kein generischer Volumenkörper, sondern ein semantisches Bauteilobjekt: Sie kennt Höhe, Stärke und Ausrichtung als editierbare Parameter und lässt sich mit Türen, Fenstern und anderen Wänden verknüpfen.

FreeCAD erzeugt die Wandgeometrie intern aus einer Basislinie (Linie oder Polylinie) plus den Parametern Höhe und Stärke. Die Basislinie kann direkt durch Klicken in die 3D-Ansicht gesetzt oder aus einer vorhandenen Draft-/Sketcher-Geometrie abgeleitet werden.

> [!info] Ausrichtung der Wand
> Der Parameter **Ausrichtung** bestimmt, auf welcher Seite der Basislinie die Wandmasse liegt:
> - **Mitte** – Wandmasse beidseitig der Basislinie (Standard)
> - **Links** – Wandmasse links der Zeichenrichtung
> - **Rechts** – Wandmasse rechts der Zeichenrichtung
>
> Für Innenmauern ist Mitte üblich; für Außenwände, bei denen die Innenkante maßgeblich ist, empfiehlt sich Links oder Rechts.

### Platte (Slab)

Eine **Platte** (Slab) ist ein horizontales Flächenbauteil mit definierter Stärke – verwendet für Böden und Decken. FreeCAD leitet die Grundfläche entweder aus ausgewählten Wänden ab (automatische Umrisserkennung) oder aus einer Skizzen- bzw. Draft-Kontur.

---

## Demonstration: Raum 4 × 3 m

Ziel dieser Demonstration: ein rechteckiger Raum mit den Außenmaßen 4,00 × 3,00 m, Wandstärke 24 cm, Raumhöhe 2,60 m, mit Boden und Decke.

> [!tip] Vorbereitung
> - Datei aus M11 öffnen (Gebäude + Erdgeschoss-Ebene bereits vorhanden)
> - Arbeitsebene auf **XY (Bodenniveau)** setzen: `BIM → Arbeitsebene setzen → XY`
> - Raster aktiv, Fang auf **Endpunkt** und **Rechtwinklig** eingestellt

### Schritt 1 – Erste Wand zeichnen

1. `BIM → Wand` aufrufen.
2. Im **Aufgabenbereich** vor dem ersten Klick einstellen:
   - Höhe: `2600 mm`
   - Stärke: `240 mm`
   - Ausrichtung: `Mitte`
3. Ersten Punkt setzen: Klick auf den Ursprung **(0, 0, 0)**.
4. Zweiten Punkt setzen: Klick auf **(4000, 0, 0)** – Raster oder Koordinateneingabe (`@4000,0` in der Koordinatenzeile unten).
5. Rechtsklick oder `Esc` → Wand abschließen.

Im Modellbaum erscheint **Wall** unter der Erdgeschoss-Ebene.

### Schritt 2 – Restliche drei Wände

Wand 2, 3 und 4 analog erzeugen. Entscheidend: Endpunkte müssen **exakt** auf den Endpunkten der vorherigen Wand liegen – Fang auf Endpunkt muss aktiv sein (Statusleiste zeigt „Endpunkt" beim Überfahren).

| Wand | Von | Bis |
|------|-----|-----|
| W1 | (0, 0) | (4000, 0) |
| W2 | (4000, 0) | (4000, 3000) |
| W3 | (4000, 3000) | (0, 3000) |
| W4 | (0, 3000) | (0, 0) |

> [!warning] Lücken im Wandverbund
> Liegen zwei Endpunkte auch nur wenige Millimeter auseinander, verbindet FreeCAD die Wände nicht – im späteren Grundriss entsteht eine sichtbare Lücke. Koordinateneingabe ist zuverlässiger als freies Klicken. Bei Fehlern: Wand im Modellbaum auswählen → `Daten`-Tab im Properties Panel → `Start` und `End` manuell korrigieren.

### Schritt 3 – Wandverbund prüfen

Alle vier Wände auswählen (`Strg`+Klick im Modellbaum), dann `BIM → Wände verbinden`. FreeCAD bereinigt überlappende Ecken zu sauberen Gehrungsschnitten.

### Schritt 4 – Boden als Platte

1. Alle vier Wände im Modellbaum auswählen.
2. `BIM → Platte` aufrufen.
3. Im Aufgabenbereich: Stärke `150 mm`, Versatz `0 mm`.
4. Bestätigen → FreeCAD leitet den Außenumriss der Wände als Plattengrundfläche ab.

Die Platte liegt auf Z = 0 (Bodenebene). Im Properties Panel (`Daten`-Tab) ist der Wert **Placement → Position → z** = 0 zu sehen.

> [!tip] Plattenkontur manuell definieren
> Wenn die automatische Umrisserkennung nicht das gewünschte Ergebnis liefert (z. B. bei L-förmigen Räumen), zuerst mit `Draft → Polylinie` oder dem *Sketcher* eine geschlossene Kontur zeichnen, diese auswählen und dann `BIM → Platte` aufrufen.

### Schritt 5 – Decke

1. Die soeben erstellte Bodenplatte im Modellbaum auswählen.
2. `Strg+C` → `Strg+V` (Kopieren/Einfügen) oder `BIM → Objekt duplizieren`.
3. Duplikat auswählen → Properties Panel → `Daten` → `Placement → Position → z` auf `2600` setzen.
4. Objekt im Modellbaum umbenennen: Rechtsklick → **Umbenennen** → `Decke_EG`.

### Schritt 6 – Modellbaum aufräumen

Alle acht Objekte (4 Wände, Boden, Decke) per Drag & Drop unter die **Erdgeschoss-Ebene** ziehen, falls noch nicht automatisch zugeordnet. Das Gebäude im Modellbaum jetzt aufklappen: `Gebäude → EG → Wall, Wall001 … Boden_EG, Decke_EG`.

---

## Parametrik: Maße nachträglich ändern

Wandhöhe und Raumhöhe lassen sich jederzeit anpassen – alle abhängigen Features (Deckenposition) müssen dabei manuell nachgeführt werden, da BIM-Objekte keine automatische Propagation wie Part-Design-Features haben.

**Wandhöhe ändern:**
1. Wand im Modellbaum oder 3D-Ansicht auswählen.
2. Properties Panel → `Daten`-Tab → `Height` → neuen Wert eingeben.
3. Alle vier Wände einzeln anpassen (oder Mehrfachauswahl → gemeinsame Eigenschaften im Panel erscheinen grau, aber editierbar).

**Stärke ändern:**
Properties Panel → `Daten` → `Width` → Wert ändern. Die Wandmasse wächst entsprechend der eingestellten Ausrichtung.

> [!info] Kein Feature-Baum wie in Part Design
> BIM-Objekte haben keinen verketteten Feature-Baum. Ändert man die Wandhöhe, bewegt sich die Deckenplatte **nicht automatisch** mit – sie muss manuell neu positioniert werden. Für vollautomatische Propagation: Deckenplatte über eine `Draft → B-Spline`-Formel oder das *Spreadsheet* parametrisch verknüpfen (Vertiefungsthema M16).

---

## Sichtbarkeit steuern

Beim Arbeiten an Boden und Decke stören die Wandkörper oft die Sicht. Schnelle Lösung:

- Einzelnes Objekt ein-/ausblenden: auswählen → `Leertaste`
- Alle Wände auf einmal: Erdgeschoss-Ebene im Modellbaum auswählen → `Leertaste` blendet die gesamte Ebene aus
- Decke dauerhaft transparent schalten: Objekt auswählen → Properties Panel → `Ansicht`-Tab → `Transparency` auf `70`

---

## Übungen

### Aufgabe 1 – Grundraum erstellen ✦

**Ziel:** Rechteckigen Raum nach Vorgabe vollständig modellieren.

**Vorgabe:** Außenmaße 5,00 × 4,00 m, Wandstärke 30 cm, Raumhöhe 3,00 m.

**Teilschritte:**
1. Neues FreeCAD-Dokument anlegen, Gebäude und Erdgeschoss-Ebene aus M11 anlegen (oder Vorlage öffnen).
2. Arbeitsebene auf XY setzen.
3. Vier Wände mit den Eckkoordinaten (0,0) → (5000,0) → (5000,4000) → (0,4000) → (0,0) erzeugen. Koordinaten direkt eingeben, nicht klicken.
4. `BIM → Wände verbinden` ausführen.
5. Bodenplatte aus den vier Wänden ableiten, Stärke 200 mm.
6. Deckenplatte als Duplikat der Bodenplatte auf Z = 3000 positionieren.
7. Alle Objekte der Erdgeschoss-Ebene zuordnen.

**Erwartetes Ergebnis:** Geschlossener Quader in der Isometrieansicht, keine sichtbaren Lücken in den Ecken, Modellbaum mit 6 Objekten unter EG.

---

### Aufgabe 2 – Raummaße parametrisch ändern ✦✦

**Ziel:** Den in Aufgabe 1 erstellten Raum auf neue Maße anpassen, ohne neu zu modellieren.

**Neue Vorgabe:** Raumhöhe 2,50 m, Wandstärke 24 cm (Innenwandqualität).

**Teilschritte:**
1. Alle vier Wände auswählen → `Height` auf `2500` ändern.
2. Alle vier Wände → `Width` auf `240` ändern. Prüfen: Wandausrichtung korrekt? Innenmaß hat sich verändert – notieren, um wie viel (Außenmaß bleibt gleich, Innenmaß wächst).
3. Deckenplatte auswählen → `Placement → z` auf `2500` setzen.
4. Isometrieansicht und Vorderansicht (`Num 1`) vergleichen – Decke sitzt bündig auf Wandoberkante?

**Erwartetes Ergebnis:** Modell zeigt 2,50 m Höhe in der Seitenansicht; Decke liegt auf Wandoberkante; keine schwebenden Flächen.

> [!tip] Innenmaß berechnen
> Bei Ausrichtung **Mitte** und Wandstärke 240 mm beträgt der Überstand je Seite 120 mm. Innenmaß = Außenmaß − 2 × 120 mm = 5000 − 240 = 4760 mm (Länge) bzw. 4000 − 240 = 3760 mm (Breite).

---

### Aufgabe 3 – L-förmiger Raum ✦✦✦

**Ziel:** Einen L-förmigen Grundriss mit sechs Wänden und passend zugeschnittenem Boden modellieren.

**Vorgabe:** Gesamtgrundriss 6,00 × 5,00 m, Einschnitt 2,00 × 2,00 m an der hinteren rechten Ecke (ergibt ein L mit 5 + 4 + 2 + 2 + 3 + 6 m Wandlängen im Außenumriss). Wandstärke 24 cm, Höhe 2,60 m.

**Eckpunkte Außenumriss (im Uhrzeigersinn):**
`(0,0) → (6000,0) → (6000,3000) → (4000,3000) → (4000,5000) → (0,5000) → (0,0)`

**Teilschritte:**
1. Sechs Wände entlang des Außenumrisses erzeugen – Koordinateneingabe Pflicht.
2. `BIM → Wände verbinden` für alle sechs Wände.
3. **Bodenplatte:** Automatische Ableitung aus den Wänden versuchen. Falls das Ergebnis nicht korrekt ist (Platte füllt das gesamte Bounding-Box-Rechteck), alternativ: mit `Draft → Polylinie` den L-Umriss manuell nachzeichnen und als Basis verwenden.
4. Deckenplatte aus Bodenplatte duplizieren, auf Z = 2600 setzen.
5. Sichtbarkeit der Decke auf 70 % Transparenz setzen, Ergebnis in Isometrieansicht prüfen.

**Erwartetes Ergebnis:** L-förmiger Grundriss ohne Überschneidungen in den sechs Ecken; Boden und Decke folgen exakt dem L-Umriss; kein Boden im eingeschnittenen Bereich.

> [!warning] Automatische Plattenkontur bei Nicht-Rechtecken
> Die Umrisserkennung von `BIM → Platte` funktioniert zuverlässig nur bei konvexen, rechteckigen Grundrissen. Bei L-, T- oder U-Formen ist die manuelle Kontur per Draft-Polylinie die sicherere Methode.

---

## Zusammenfassung

| Operation | Menüpfad | Wichtigste Parameter |
|---|---|---|
| Wand erstellen | `BIM → Wand` | Höhe, Stärke, Ausrichtung |
| Wände verbinden | `BIM → Wände verbinden` | – (Auswahl vorher) |
| Platte erstellen | `BIM → Platte` | Stärke, Versatz |
| Wandhöhe ändern | Properties Panel → `Daten → Height` | Wert in mm |
| Wandstärke ändern | Properties Panel → `Daten → Width` | Wert in mm |
| Decke positionieren | Properties Panel → `Daten → Placement → z` | = Raumhöhe in mm |

---

## Querverweise

- [[M11 – BIM-Workbench & Projektstruktur]] – Voraussetzung: Gebäude- und Ebenenstruktur
- [[M13 – Türen & Fenster]] – Öffnungen in die hier erzeugten Wände einsetzen
- [[M14 – 2D-Grundriss mit Draft]] – Alternativweg: erst 2D-Kontur, dann Wände
- [[M16 – Räume, Flächen & Stücklisten]] – Raumobjekte und Flächenberechnung
- [[Glossar FreeCAD]] – BIM-Begriffe werden dort ergänzt
