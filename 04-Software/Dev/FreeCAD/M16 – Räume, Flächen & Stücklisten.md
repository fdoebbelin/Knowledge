# M16 – Räume, Flächen & Stücklisten

> [!info] Modulinfo
> **Workbenches:** *BIM*, *Spreadsheet* | **Dauer:** 60 min | **Voraussetzung:** [[M13 – Türen & Fenster]], [[M15 – Innenausstattung & Möblierung]]

**Lernziel:** Raumobjekte definieren, Nettoflächen automatisch berechnen und eine Stückliste mit Flächenwerten im Spreadsheet ausgeben.

---

## Einführung

### Warum Raumobjekte?

Wände, Böden und Möbel sind reine Geometrie – FreeCAD weiß nicht, welcher Bereich davon ein „Zimmer" ist. Das **Raum-Objekt** (Space) schließt diese Lücke: Es umspannt ein Raumvolumen, berechnet Nettofläche und Volumen automatisch und trägt eine Bezeichnung, die später im Grundrissplan als Raumstempel erscheint.

Zusammen mit der **Stückliste** entsteht so aus dem 3D-Modell direkt ein vollständiger Flächennachweis – ohne manuelles Abmessen.

> [!info] Brutto- vs. Nettofläche
> FreeCAD unterscheidet **Bruttofläche** (inkl. Wandstärken) und **Nettofläche** (lichte Maße). Für Wohnflächenberechnungen nach WoFlV ist stets die Nettofläche relevant. Das Raum-Objekt muss deshalb exakt an den **Wandinnenkanten** ausgerichtet sein.

---

## Teil 1 – Einführung & Demonstration

### 1.1 Raum anlegen

Ein Raum wird durch eine horizontale Kontur definiert, die die lichte Grundrissfläche umschließt.

**Methode A – Automatisch aus Wandinnenkanten (empfohlen):**

1. Alle Innenwandflächen des Raums auswählen (Linksklick + `Strg`)
2. `BIM → Raum` aufrufen
3. FreeCAD erkennt die umschlossene Fläche und erzeugt das Raum-Objekt automatisch

**Methode B – Manuell über Polylinie:**

1. Arbeitsebene auf den Boden des Geschosses setzen: `BIM → Arbeitsebene setzen`
2. Mit `Draft → Zeichnen → Polylinie` die Raumkontur entlang der Wandinnenseiten nachzeichnen – Fangpunkte (`S`) nutzen
3. Polylinie auswählen, dann `BIM → Raum` aufrufen

> [!tip] Methode wählen
> Methode A funktioniert zuverlässig bei rechteckigen Räumen mit sauber verbundenen Wänden. Für L-förmige Räume oder Räume mit schrägen Wänden ist Methode B präziser.

### 1.2 Raumparameter einstellen

Nach dem Anlegen das Raum-Objekt im Modellbaum auswählen und im **Properties Panel** (unten links) die Reiter *Daten* und *Ansicht* öffnen:

| Eigenschaft | Bedeutung | Typischer Wert |
|---|---|---|
| `Label` | Interner Name im Modellbaum | `Wohnzimmer` |
| `SpaceName` | Angezeigter Raumname (Stempel) | `Wohnzimmer` |
| `SpaceNumber` | Raumnummer für den Plan | `1.01` |
| `Area` | Berechnete Nettofläche (nur lesen) | automatisch |
| `FinishFloor` | Bodenbelag-Dicke (wird von lichten Maßen abgezogen) | `0 mm` oder `10 mm` |

> [!warning] Höhenparameter
> Das Raum-Objekt erbt die Höhe aus dem übergeordneten Level-Objekt. Weicht die lichte Raumhöhe davon ab (z. B. wegen abgehängter Decke), den Wert `Height` im Reiter *Daten* manuell überschreiben.

### 1.3 Raumstempel einfügen

Der Raumstempel zeigt Name und Fläche direkt im 3D-Modell – und später im Grundrissplan.

1. Raum-Objekt im Modellbaum auswählen
2. `BIM → Raumbeschriftung` aufrufen
3. Klick in die Raummitte platziert den Stempel
4. Dargestellte Informationen über Eigenschaften anpassbar: Name, Fläche, Nummer

### 1.4 Flächenwert ablesen und prüfen

Raum-Objekt auswählen → Properties Panel → Reiter *Daten* → Feld `Area`.

**Plausibilitätsprüfung:** Raumbreite × Raumlänge (lichte Maße) händisch nachrechnen. Abweichung > 2 % deutet auf einen Modellierungsfehler hin (Wandinnenkante nicht korrekt getroffen).

---

### 1.5 Spreadsheet anlegen und Flächen einlesen

Die *Spreadsheet*-Workbench ermöglicht es, Eigenschaften von Modellobjekten direkt per Formel in eine Tabelle zu ziehen.

**Spreadsheet erstellen:**

1. Workbench wechseln: *Spreadsheet* aus dem Workbench-Menü wählen
2. `Spreadsheet → Tabelle erstellen` – eine neue Tabelle erscheint im Modellbaum
3. Doppelklick auf die Tabelle öffnet den Tabelleneditor

**Raumfläche per Formel einlesen:**

In eine Zelle klicken und folgende Formel eingeben:

```
=Wohnzimmer.Area
```

`Wohnzimmer` ist dabei der `Label`-Name des Raum-Objekts im Modellbaum (exakte Schreibweise). FreeCAD aktualisiert den Wert automatisch, wenn das Modell geändert wird.

> [!tip] Label-Namen mit Leerzeichen
> Enthält der Label-Name ein Leerzeichen, muss er in spitzen Klammern geschrieben werden:
> ```
> =<<Raum 1.01>>.Area
> ```

**Einheit umrechnen:** FreeCAD gibt Flächen intern in mm² aus. Für m²-Anzeige:

```
=Wohnzimmer.Area / 1000000
```

Eine Hilfsspalte mit der Bezeichnung und eine Ergebnisspalte in m² ergibt eine sauber lesbare Flächenübersicht.

---

### 1.6 Automatische Stückliste erzeugen

Die BIM-Stückliste erfasst alle BIM-Objekte des Modells (Wände, Böden, Fenster, Türen, Möbel) und gibt Typ, Anzahl, Fläche oder Volumen aus.

1. In der *BIM*-Workbench: `BIM → Stückliste`
2. Im Dialog Felder auswählen, die in die Liste aufgenommen werden sollen (Typ, Bezeichnung, Fläche, Volumen, Anzahl)
3. Ziel wählen:
   - **In Spreadsheet ausgeben** – Tabelle wird im Modell gespeichert und bleibt verknüpft
   - **Als CSV exportieren** – für externe Auswertung in Excel o. Ä.
4. `OK` – Stückliste wird erzeugt

> [!info] Stückliste aktuell halten
> Die über `BIM → Stückliste` erzeugte Tabelle ist eine **Momentaufnahme**. Nach Modelländerungen erneut aufrufen oder die Spreadsheet-Formelmethode (1.5) für Live-Updates bevorzugen.

---

## Teil 2 – Übungen

### Aufgabe 1 – Raum anlegen und prüfen ✦

**Ausgangssituation:** Das Raummodell aus M13 (Wände, Boden, Decke, Tür, Fenster) ist geöffnet.

**Ziel:** Ein Raum-Objekt anlegen, das die lichte Grundrissfläche korrekt erfasst.

**Teilschritte:**

1. Arbeitsebene auf den Boden setzen: `BIM → Arbeitsebene setzen` → Klick auf die Bodenfläche
2. Alle vier Innenwandflächen auswählen (`Strg`+Klick)
3. `BIM → Raum` aufrufen – Raum-Objekt entsteht im Modellbaum
4. Im Properties Panel den `Label` auf `Wohnzimmer` und `SpaceNumber` auf `1.01` setzen
5. Nettofläche in `Area` ablesen
6. Händisch prüfen: lichte Breite × lichte Länge (Wandinnenkanten nachmessen mit `BIM → Messen` oder Skizze)

**Erwartetes Ergebnis:** `Area` weicht weniger als 2 % vom Handrechenmaß ab. Raum-Objekt erscheint als farbige Fläche im 3D-Modell.

---

### Aufgabe 2 – Raumstempel und Spreadsheet ✦✦

**Ziel:** Raumstempel im Modell platzieren und Nettofläche in ein Spreadsheet einlesen.

**Teilschritte:**

1. Raum-Objekt auswählen → `BIM → Raumbeschriftung` → Stempel in die Raummitte setzen
2. Workbench auf *Spreadsheet* wechseln
3. `Spreadsheet → Tabelle erstellen`
4. Tabelle durch Doppelklick öffnen
5. Tabellenstruktur aufbauen:

   | Zelle | Inhalt |
   |---|---|
   | A1 | `Raum` |
   | B1 | `Bezeichnung` |
   | C1 | `Fläche (m²)` |
   | A2 | `1.01` |
   | B2 | `Wohnzimmer` |
   | C2 | `=Wohnzimmer.Area / 1000000` |

6. Tabelle schließen – Wert in C2 prüfen
7. **Kontrolle:** Eine Wandstärke im Modell ändern (`Properties → Width`) → Wert in C2 aktualisiert sich automatisch → Wandstärke zurücksetzen

**Erwartetes Ergebnis:** C2 zeigt die Nettofläche in m² mit zwei Nachkommastellen. Wert ändert sich live bei Modelländerungen.

---

### Aufgabe 3 – Mehrere Räume und Stückliste ✦✦✦

**Ziel:** Für ein Zwei-Raum-Modell (z. B. Wohnzimmer + Flur) eine vollständige Stückliste mit Flächennachweis erzeugen.

**Vorbereitung:** Zweiten Raum (Flur, ca. 4 m²) mit Trennwand zum bestehenden Raum ergänzen – Tür in die Trennwand einsetzen (Kenntnisse aus M13).

**Teilschritte:**

1. Für jeden Raum ein eigenes Raum-Objekt anlegen (Aufgabe 1 sinngemäß wiederholen)
2. Raumstempel für beide Räume setzen
3. Spreadsheet um eine dritte Zeile für den Flur erweitern:
   - C3: `=Flur.Area / 1000000`
   - C4 (Summe): `=C2 + C3` – Gesamtfläche
4. Stückliste erzeugen: `BIM → Stückliste`
   - Felder: Typ, Label, Fläche, Anzahl
   - Ausgabe: In neues Spreadsheet
5. Stückliste sichten: Sind alle Wände, Böden, Türen, Fenster und Räume erfasst?
6. Stückliste als CSV exportieren: Im Stücklisten-Dialog `Als CSV exportieren` wählen

**Erwartetes Ergebnis:** Spreadsheet zeigt beide Raumflächen und deren Summe. CSV-Datei enthält alle BIM-Objekte mit korrekten Typen und Flächen. Summe beider Raumflächen entspricht plausibel der Gesamtgrundfläche (Differenz durch Wandquerschnittsflächen erklärbar).

> [!tip] Flächendifferenz verstehen
> Die Summe der Nettoflächen ist immer kleiner als die Brutto-Grundfläche des Gebäudes – die Differenz entspricht den Wandquerschnittsflächen. Diese Differenz als Kontrollrechnung dokumentieren: `Brutto − Σ Netto = Wandflächen`.

---

## Zusammenfassung

| Schritt | Werkzeug | Ergebnis |
|---|---|---|
| Raum definieren | `BIM → Raum` | Raum-Objekt mit `Area`-Eigenschaft |
| Raumstempel | `BIM → Raumbeschriftung` | Bezeichnung + Fläche im Modell sichtbar |
| Live-Fläche einlesen | `=RaumLabel.Area` im Spreadsheet | Automatisch aktualisierter Flächenwert |
| Einheit umrechnen | `/ 1000000` in der Formel | Ausgabe in m² statt mm² |
| Alle Bauteile erfassen | `BIM → Stückliste` | Tabelle aller BIM-Objekte |
| Datenexport | CSV aus Stücklisten-Dialog | Weitergabe an externe Tools |

---

## Querverweise

- [[M13 – Türen & Fenster]] – Vorausgesetztes Modell
- [[M15 – Innenausstattung & Möblierung]] – Möbelobjekte erscheinen in der Stückliste
- [[M17 – Raumpläne & Schnitte mit TechDraw]] – Raumstempel wird im Grundrissplan dargestellt
- [[Glossar FreeCAD]] – Begriffe: Raum, Stückliste
