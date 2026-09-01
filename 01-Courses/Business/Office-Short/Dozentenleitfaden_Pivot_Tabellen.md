# Dozentenleitfaden: Pivot-Tabellen und Pivot-Diagramme in Excel

## Inhaltsverzeichnis

1. [Überblick und Lernziele](#überblick-und-lernziele)
2. [Vorbereitung und Voraussetzungen](#vorbereitung-und-voraussetzungen)
3. [Theoretische Grundlagen](#theoretische-grundlagen)
4. [Schritt-für-Schritt-Anleitung](#schritt-für-schritt-anleitung)
5. [Praktische Übung mit Datensatz](#praktische-übung-mit-datensatz)
6. [Erweiterte Funktionen](#erweiterte-funktionen)
7. [Häufige Fehler und Lösungen](#häufige-fehler-und-lösungen)
8. [Tipps für die Durchführung](#tipps-für-die-durchführung)
9. [Diskussionsfragen](#diskussionsfragen)
10. [Bewertungskriterien](#bewertungskriterien)

---

## Überblick und Lernziele

### Was sind Pivot-Tabellen?

Pivot-Tabellen sind **interaktive Auswertungstabellen**, die es ermöglichen, große Datenmengen schnell zu analysieren, zusammenzufassen und aus verschiedenen Perspektiven zu betrachten – ohne die Ausgangsdaten zu verändern.

### Zeitbedarf
- **Einführung und Theorie**: 20 Minuten
- **Demonstration**: 30 Minuten
- **Praktische Übung**: 45 Minuten
- **Besprechung und Vertiefung**: 25 Minuten
- **Gesamt**: ca. 2 Stunden

### Lernziele

Nach Abschluss dieser Unterrichtseinheit können die Teilnehmer:

**Grundlagen:**
- ✓ Den Zweck und Nutzen von Pivot-Tabellen erklären
- ✓ Geeignete Datenstrukturen für Pivot-Tabellen erkennen
- ✓ Eine einfache Pivot-Tabelle erstellen

**Aufbau:**
- ✓ Felder in Zeilen, Spalten, Werte und Filter richtig zuordnen
- ✓ Berechnungen (Summe, Durchschnitt, Anzahl) in Pivot-Tabellen durchführen
- ✓ Pivot-Tabellen filtern und sortieren

**Fortgeschritten:**
- ✓ Pivot-Diagramme aus Pivot-Tabellen erstellen
- ✓ Gruppierungen (Datum, Zahlen) anwenden
- ✓ Berechnete Felder hinzufügen

**Analyse:**
- ✓ Geschäftsfragen mit Pivot-Tabellen beantworten
- ✓ Daten aus verschiedenen Perspektiven betrachten
- ✓ Professionelle Berichte erstellen

---

## Vorbereitung und Voraussetzungen

### Vorwissen der Teilnehmer

**Erforderlich:**
- Grundlegende Excel-Kenntnisse (Zellen, Formeln, Formatierung)
- Verständnis von Tabellen und Datenstrukturen
- Erfahrung mit Excel-Funktionen (SUMME, MITTELWERT)

**Hilfreich, aber nicht erforderlich:**
- Erfahrung mit Filtern und Sortieren
- Kenntnisse über Datenbanken (Konzept von Datensätzen)

### Technische Vorbereitung

**Für Dozenten:**
1. Excel-Datei mit Beispieldaten vorbereiten (siehe unten)
2. Beamer und große Bildschirmdarstellung testen
3. Beispiel-Pivot-Tabelle als Musterlösung vorbereiten
4. Handouts ausdrucken oder digital bereitstellen

**Für Teilnehmer:**
- Excel 2010 oder neuer (empfohlen: Excel 2016+)
- Übungsdatei mit Rohdaten
- Optional: Zwei Monitore für Demonstration und eigene Arbeit

### Beispiel-Datensatz vorbereiten

Die Teilnehmer benötigen einen Übungsdatensatz. Empfohlenes Szenario: **Verkaufsdaten eines Online-Shops**

**Struktur der Daten:**

| Bestelldatum | Region | Produktkategorie | Produkt | Verkäufer | Menge | Einzelpreis | Gesamt |
|--------------|--------|------------------|---------|-----------|-------|-------------|---------|
| 01.01.2024 | Nord | Elektronik | Laptop | Müller | 2 | 899 | 1798 |
| 01.01.2024 | Süd | Bücher | Roman | Schmidt | 5 | 15 | 75 |
| ... | ... | ... | ... | ... | ... | ... | ... |

**Wichtige Merkmale:**
- Mindestens 100-200 Datensätze
- Mehrere Kategorien (Produkte, Regionen, Verkäufer)
- Zeitraum über mehrere Monate
- Mix aus Zahlen- und Textdaten
- Keine Leerzeilen oder Spalten
- Klare Spaltenüberschriften in der ersten Zeile

---

## Theoretische Grundlagen

### Wann sind Pivot-Tabellen sinnvoll?

Erklären Sie den Teilnehmern, dass Pivot-Tabellen besonders nützlich sind für:

✅ **Große Datenmengen analysieren**
- Hunderte oder tausende Zeilen zusammenfassen
- Schnelle Übersichten erstellen

✅ **Verschiedene Perspektiven**
- Gleiche Daten aus unterschiedlichen Blickwinkeln betrachten
- "Was wäre wenn"-Szenarien durchspielen

✅ **Aggregationen**
- Summen, Durchschnitte, Anzahlen berechnen
- Nach Kategorien gruppieren

✅ **Vergleiche**
- Zeiträume vergleichen (Monat, Quartal, Jahr)
- Regionen, Produkte, Mitarbeiter vergleichen

### Die Anatomie einer Pivot-Tabelle

Zeichnen Sie an die Tafel oder zeigen Sie visuell:

```
┌─────────────────────────────────────────┐
│        PIVOT-TABELLEN-FELDER            │
├─────────────────────────────────────────┤
│                                         │
│  □ FILTER (optional)                    │
│    └─ Filtert die gesamte Tabelle       │
│                                         │
│  □ SPALTEN                              │
│    └─ Horizontale Gruppierung           │
│                                         │
│  ┌──────────┬──────────┬──────────┐    │
│  │          │ Spalte 1 │ Spalte 2 │    │
│  ├──────────┼──────────┼──────────┤    │
│  │ Zeile 1  │  WERTE   │  WERTE   │    │
│  │ Zeile 2  │  WERTE   │  WERTE   │    │
│  └──────────┴──────────┴──────────┘    │
│    ↑                      ↑             │
│  ZEILEN               WERTE             │
│  (Vertikale           (Berechnungen)    │
│   Gruppierung)                          │
└─────────────────────────────────────────┘
```

### Die vier Bereiche einer Pivot-Tabelle

Erklären Sie jeden Bereich detailliert:

#### 1. **Filter** (oben)
- Filtert die **gesamte** Pivot-Tabelle
- Optional, aber sehr nützlich
- Beispiel: "Zeige nur Daten für 2024"

#### 2. **Spalten** (horizontal)
- Kategorien, die als **Spaltenüberschriften** erscheinen
- Horizontale Aufteilung der Daten
- Beispiel: Monate (Jan, Feb, März...)

#### 3. **Zeilen** (vertikal)
- Kategorien, die als **Zeilenbeschriftungen** erscheinen
- Vertikale Gruppierung
- Beispiel: Produktkategorien (Elektronik, Bücher, Kleidung)

#### 4. **Werte** (Zentrum)
- Die **Berechnungen** (Summen, Durchschnitte, etc.)
- Das "Herzstück" der Pivot-Tabelle
- Beispiel: Summe des Umsatzes

### Die richtige Datenstruktur

**Zeigen Sie den Unterschied zwischen guter und schlechter Datenstruktur:**

❌ **SCHLECHT - Breite Tabelle:**
```
Verkäufer | Jan 2024 | Feb 2024 | Mrz 2024
Müller    | 5000     | 6000     | 5500
Schmidt   | 4500     | 4800     | 5200
```

✅ **GUT - Lange Tabelle (Listenformat):**
```
Verkäufer | Monat    | Jahr | Umsatz
Müller    | Januar   | 2024 | 5000
Müller    | Februar  | 2024 | 6000
Müller    | März     | 2024 | 5500
Schmidt   | Januar   | 2024 | 4500
Schmidt   | Februar  | 2024 | 4800
Schmidt   | März     | 2024 | 5200
```

**Grundregeln für Pivot-geeignete Daten:**
1. Jede Zeile = ein Datensatz
2. Jede Spalte = ein Attribut
3. Keine zusammengefassten Daten
4. Keine Leerzeilen oder -spalten
5. Klare Spaltenüberschriften

---

## Schritt-für-Schritt-Anleitung

### Phase 1: Erste Pivot-Tabelle erstellen (15 Min)

#### Schritt 1: Daten vorbereiten

**Demonstration:**
1. Öffnen Sie die Beispieldatei
2. Zeigen Sie die Datenstruktur
3. Erklären Sie jede Spalte

**Prüfpunkte für Teilnehmer:**
- [ ] Alle Spalten haben Überschriften
- [ ] Keine Leerzeilen in den Daten
- [ ] Daten sind als Tabelle erkennbar

#### Schritt 2: Pivot-Tabelle einfügen

**Demonstration am Beamer:**

1. **Klicken Sie in eine beliebige Zelle** innerhalb der Daten
   - Excel erkennt automatisch den Datenbereich
   - Zeigen Sie den markierten Bereich (gestrichelte Linie)

2. **Gehen Sie zu: Einfügen → Pivot-Tabelle**
   - Zeigen Sie, wo dieser Button ist
   - Erklären Sie den Dialog, der erscheint

3. **Dialog "PivotTable erstellen":**
   ```
   ┌─────────────────────────────────────┐
   │ Tabelle/Bereich auswählen           │
   │ ● Tabelle oder Bereich              │
   │   [Tabelle1!$A$1:$H$201]            │
   │                                     │
   │ Wo soll der PivotTable-Bericht      │
   │ platziert werden?                   │
   │ ● Neues Arbeitsblatt                │
   │ ○ Vorhandenes Arbeitsblatt          │
   │                                     │
   │         [OK]    [Abbrechen]         │
   └─────────────────────────────────────┘
   ```

4. **Wählen Sie "Neues Arbeitsblatt"**
   - Empfehlung: Immer neues Blatt (übersichtlicher)
   - Klicken Sie **OK**

5. **Was passiert:**
   - Neues Arbeitsblatt wird erstellt
   - Leere Pivot-Tabelle auf der linken Seite
   - **PivotTable-Felder** auf der rechten Seite

#### Schritt 3: Die PivotTable-Felder verstehen

**Zeigen Sie die rechte Seitenleiste:**

```
┌────────────────────────────────┐
│    PivotTable-Felder           │
├────────────────────────────────┤
│ Zu analysierende Felder        │
│ auswählen:                     │
│                                │
│ □ Bestelldatum                 │
│ □ Region                       │
│ □ Produktkategorie             │
│ □ Produkt                      │
│ □ Verkäufer                    │
│ □ Menge                        │
│ □ Einzelpreis                  │
│ □ Gesamt                       │
│                                │
├────────────────────────────────┤
│ Ziehen Sie Felder in die       │
│ unten aufgeführten Bereiche:   │
│                                │
│ ▼ FILTER                       │
│   [                          ] │
│                                │
│ ▼ SPALTEN                      │
│   [                          ] │
│                                │
│ ▼ ZEILEN                       │
│   [                          ] │
│                                │
│ ▼ WERTE                        │
│   [                          ] │
└────────────────────────────────┘
```

**Wichtiger Hinweis:**
Falls die Felder nicht sichtbar sind:
- Rechtsklick auf die Pivot-Tabelle
- "Feldliste anzeigen" wählen

### Phase 2: Erste Auswertung erstellen (15 Min)

#### Beispielaufgabe: "Umsatz nach Region"

**Zielfrage:** "Wie hoch ist der Gesamtumsatz in jeder Region?"

**Schritt-für-Schritt am Beamer demonstrieren:**

1. **Ziehen Sie "Region" in den Bereich ZEILEN**
   - Klicken, halten und ziehen
   - Loslassen, wenn der Bereich hellblau markiert ist
   - Ergebnis: Regionen erscheinen als Zeilen

2. **Ziehen Sie "Gesamt" in den Bereich WERTE**
   - Ergebnis: Summen werden automatisch berechnet
   - Excel wählt standardmäßig "Summe" für Zahlen

**Resultat:**
```
Zeilenbeschriftungen | Summe von Gesamt
---------------------|------------------
Nord                 | 125.450 €
Ost                  | 98.750 €
Süd                  | 145.200 €
West                 | 112.300 €
Gesamtergebnis       | 481.700 €
```

**Diskussionspunkt:** 
- "Welche Erkenntnisse können wir daraus ziehen?"
- "Welche Region ist am stärksten?"

#### Beispielaufgabe 2: "Umsatz nach Region UND Produktkategorie"

**Zielfrage:** "Wie verteilt sich der Umsatz nach Region und Produktkategorie?"

**Demonstration:**

1. **Ziehen Sie "Produktkategorie" in den Bereich SPALTEN**
   - Jetzt haben wir eine **Kreuztabelle**
   - Regionen in Zeilen, Kategorien in Spalten

**Resultat:**
```
                | Bücher  | Elektronik | Kleidung | Gesamtergebnis
----------------|---------|------------|----------|----------------
Nord            | 25.400  | 68.050     | 32.000   | 125.450
Ost             | 18.750  | 55.000     | 25.000   | 98.750
Süd             | 35.200  | 75.000     | 35.000   | 145.200
West            | 22.300  | 60.000     | 30.000   | 112.300
Gesamtergebnis  | 101.650 | 258.050    | 122.000  | 481.700
```

**Diskussionspunkte:**
- "Was fällt auf?"
- "Welche Kombination ist am erfolgreichsten?"
- "Gibt es Schwachstellen?"

### Phase 3: Berechnungen ändern (10 Min)

#### Verschiedene Berechnungsarten zeigen

**Demonstration:**

1. **Rechtsklick auf "Summe von Gesamt"** im Wertebereich
2. **Wertfeldeinstellungen** wählen
3. **Dialog zeigen:**

```
┌─────────────────────────────────┐
│ Wertfeldeinstellungen           │
├─────────────────────────────────┤
│ Benutzerdefinierter Name:       │
│ [Summe von Gesamt           ]   │
│                                 │
│ Werte zusammenfassen nach:      │
│ ● Summe                         │
│ ○ Anzahl                        │
│ ○ Mittelwert                    │
│ ○ Max                           │
│ ○ Min                           │
│ ○ Produkt                       │
│ ○ Anzahl (Zahlen)               │
│ ○ StAbw                         │
│ ○ ...                           │
│                                 │
│         [OK]    [Abbrechen]     │
└─────────────────────────────────┘
```

**Zeigen Sie verschiedene Optionen:**

1. **Mittelwert:**
   - Ändert "Summe" zu "Mittelwert"
   - Zeigt durchschnittlichen Bestellwert

2. **Anzahl:**
   - Zählt, wie viele Bestellungen es gibt
   - Nützlich für Häufigkeiten

3. **Max/Min:**
   - Zeigt höchsten/niedrigsten Wert

**Praktische Übung für Teilnehmer:**
"Ändern Sie die Berechnung zu 'Anzahl' und interpretieren Sie das Ergebnis."

### Phase 4: Filtern und Sortieren (10 Min)

#### Filter anwenden

**Demonstration:**

1. **Zeigen Sie die Dropdown-Pfeile** in der Pivot-Tabelle
   - Neben "Zeilenbeschriftungen"
   - Neben "Spaltenbeschriftungen"

2. **Klicken Sie auf den Pfeil bei "Zeilenbeschriftungen"**
   - Zeigen Sie die Filteroptionen
   - Deaktivieren Sie z.B. "Nord"
   - Ergebnis: Nord wird ausgeblendet

3. **Mehrfachfilter:**
   - Nur "Nord" und "Süd" auswählen
   - Zeigen Sie die Auswirkung auf die Summen

#### Berichtsfilter verwenden

**Demonstration:**

1. **Ziehen Sie "Verkäufer" in den Bereich FILTER** (ganz oben)

2. **Oben in der Pivot-Tabelle erscheint:**
   ```
   Verkäufer | (Alle)  ▼
   ```

3. **Klicken Sie auf den Dropdown**
   - Wählen Sie z.B. "Müller"
   - Die gesamte Pivot-Tabelle zeigt nur Müllers Daten

**Nutzen:** "Schnelles Wechseln zwischen verschiedenen Perspektiven"

#### Sortieren

**Demonstration:**

1. **Rechtsklick auf eine Region** (z.B. "Nord")
2. **Sortieren → Sortieren von A bis Z**
3. **Alternative:** Sortieren nach Wert (höchster Umsatz zuerst)

**Bessere Methode:**
1. Rechtsklick auf eine Summe
2. "Sortieren → Nach Größe sortieren (absteigend)"
3. Zeigt Regionen nach Umsatz sortiert

### Phase 5: Pivot-Diagramm erstellen (15 Min)

#### Warum Pivot-Diagramme?

Erklären Sie:
- Visualisierungen sind oft verständlicher als Zahlen
- Pivot-Diagramme sind mit der Pivot-Tabelle verbunden
- Änderungen in der Tabelle aktualisieren automatisch das Diagramm

#### Schritt-für-Schritt: Pivot-Diagramm erstellen

**Demonstration:**

1. **Klicken Sie in die Pivot-Tabelle**
   - Irgendeine Zelle innerhalb der Pivot-Tabelle

2. **Gehen Sie zu: PivotTable-Analyse → PivotChart**
   - (In älteren Versionen: "Optionen" → "PivotChart")

3. **Dialog "Diagramm einfügen" erscheint:**
   ```
   ┌─────────────────────────────────────┐
   │ Diagrammtyp wählen:                 │
   │                                     │
   │ ● Säule                             │
   │ ○ Balken                            │
   │ ○ Linie                             │
   │ ○ Kreis                             │
   │ ○ Fläche                            │
   │ ...                                 │
   │                                     │
   │         [OK]    [Abbrechen]         │
   └─────────────────────────────────────┘
   ```

4. **Wählen Sie "Säulendiagramm" (Standard)**
   - Klicken Sie OK

5. **Ergebnis:**
   - Diagramm erscheint auf dem Arbeitsblatt
   - Hat die gleichen Filter wie die Pivot-Tabelle
   - Rechts erscheinen "PivotChart-Felder"

#### Diagramm anpassen

**Demonstration der Anpassungen:**

1. **Diagrammtitel ändern:**
   - Doppelklick auf "Diagrammtitel"
   - Eingeben: "Umsatz nach Region und Produktkategorie"

2. **Diagrammtyp ändern:**
   - Rechtsklick auf das Diagramm
   - "Diagrammtyp ändern"
   - Zeigen Sie verschiedene Optionen:
     - **Gestapeltes Säulendiagramm**: Produktkategorien übereinander
     - **Gruppiertes Säulendiagramm**: Produktkategorien nebeneinander
     - **Kreisdiagramm**: Nur eine Dimension (z.B. nur Regionen)

3. **Farben anpassen:**
   - Diagrammtools → Entwurf → Farben ändern
   - Zeigen Sie verschiedene Farbschemata

4. **Achsenbeschriftungen:**
   - Diagrammelemente hinzufügen (+)
   - Achsentitel aktivieren
   - Horizontal: "Region"
   - Vertikal: "Umsatz in €"

#### Interaktivität demonstrieren

**Das Besondere an Pivot-Diagrammen:**

1. **Ändern Sie Filter in der Pivot-Tabelle**
   - Diagramm passt sich automatisch an

2. **Ändern Sie Filter im Diagramm selbst**
   - Diagramm hat eigene Filter-Buttons
   - Zeigen Sie die Interaktivität

3. **Verschieben Sie Felder in der Pivot-Tabelle**
   - Z.B. Region von Zeilen nach Spalten
   - Diagramm wird automatisch umstrukturiert

**Wow-Moment:** "Gleiche Daten, verschiedene Ansichten – ohne neu zu rechnen!"

---

## Praktische Übung mit Datensatz

### Übungsszenario: Online-Shop-Auswertung

**Ausgangssituation:**
Die Teilnehmer sind Analysten für einen Online-Shop. Der Geschäftsführer hat folgende Fragen:

#### Aufgabe 1: Basisanalyse (15 Min)

**Fragen:**
1. Wie hoch ist der Gesamtumsatz pro Region?
2. Welche Region hat die meisten Bestellungen?
3. Was ist der durchschnittliche Bestellwert pro Region?

**Lösung für Dozenten:**

```
Pivot-Tabelle 1:
- ZEILEN: Region
- WERTE: Summe von Gesamt

Pivot-Tabelle 2:
- ZEILEN: Region
- WERTE: Anzahl von Bestellungen

Pivot-Tabelle 3:
- ZEILEN: Region
- WERTE: Mittelwert von Gesamt
```

**Erwartete Erkenntnisse:**
- Region mit höchstem Umsatz identifizieren
- Unterschied zwischen Anzahl und Durchschnitt verstehen
- Erkennen, dass hoher Umsatz ≠ viele Bestellungen

#### Aufgabe 2: Produktanalyse (15 Min)

**Fragen:**
1. Welche Produktkategorie generiert den höchsten Umsatz?
2. Wie verteilt sich der Umsatz über die Monate?
3. Welche Produktkategorie verkauft sich in welchem Monat am besten?

**Lösung für Dozenten:**

```
Pivot-Tabelle 1:
- ZEILEN: Produktkategorie
- WERTE: Summe von Gesamt
- Sortierung: Nach Wert absteigend

Pivot-Tabelle 2:
- SPALTEN: Bestelldatum (nach Monaten gruppiert)
- ZEILEN: Produktkategorie
- WERTE: Summe von Gesamt
```

**Hinweis für Gruppierung nach Monaten:**
1. Rechtsklick auf ein Datum in der Pivot-Tabelle
2. "Gruppieren" wählen
3. "Monate" auswählen

#### Aufgabe 3: Verkäuferanalyse (15 Min)

**Fragen:**
1. Welcher Verkäufer hat den höchsten Umsatz?
2. In welcher Region ist jeder Verkäufer am erfolgreichsten?
3. Erstellen Sie ein Pivot-Diagramm, das die Top 5 Verkäufer zeigt.

**Lösung für Dozenten:**

```
Pivot-Tabelle:
- ZEILEN: Verkäufer
- SPALTEN: Region
- WERTE: Summe von Gesamt
- FILTER: Top 10 anzeigen (Wertfilter)

Pivot-Diagramm:
- Typ: Gruppiertes Säulendiagramm
- Zeigt Verkäufer auf X-Achse
- Verschiedene Farben für Regionen
```

#### Aufgabe 4: Zeitanalyse mit Diagramm (15 Min)

**Fragen:**
1. Wie entwickelt sich der Umsatz über die Monate?
2. Gibt es saisonale Trends?
3. Erstellen Sie ein Liniendiagramm zur Visualisierung.

**Lösung für Dozenten:**

```
Pivot-Tabelle:
- SPALTEN: Bestelldatum (gruppiert nach Monaten)
- WERTE: Summe von Gesamt

Pivot-Diagramm:
- Typ: Liniendiagramm
- X-Achse: Monate
- Y-Achse: Umsatz
- Optional: Mehrere Linien für verschiedene Produktkategorien
```

---

## Erweiterte Funktionen

### Gruppierung von Daten

#### Datums-Gruppierung

**Demonstration:**

1. **Ausgangssituation:** Bestelldatum in Zeilen → zu viele einzelne Tage

2. **Rechtsklick auf ein Datum** in der Pivot-Tabelle

3. **"Gruppieren" wählen**

4. **Dialog zeigt Optionen:**
   ```
   ┌─────────────────────────────┐
   │ Gruppierung                 │
   ├─────────────────────────────┤
   │ Nach:                       │
   │ □ Sekunden                  │
   │ □ Minuten                   │
   │ □ Stunden                   │
   │ □ Tage                      │
   │ ☑ Monate                    │
   │ ☑ Quartale                  │
   │ ☑ Jahre                     │
   │                             │
   │     [OK]    [Abbrechen]     │
   └─────────────────────────────┘
   ```

5. **Wählen Sie z.B. "Monate" und "Jahre"**
   - Excel erstellt hierarchische Gruppierung
   - Jahr → Monat → (Tag)

**Nutzen:** 
- Übersichtlichere Zeitanalysen
- Trends über Monate/Quartale erkennen

#### Zahlen-Gruppierung

**Beispiel: Preiskategorien**

1. **Ausgangssituation:** Einzelpreis in Zeilen → zu viele verschiedene Werte

2. **Rechtsklick auf einen Preis** in der Pivot-Tabelle

3. **"Gruppieren" wählen**

4. **Dialog zeigt Optionen:**
   ```
   ┌─────────────────────────────┐
   │ Gruppierung                 │
   ├─────────────────────────────┤
   │ Von: [0]                    │
   │ Bis: [1000]                 │
   │ Schrittweite: [100]         │
   │                             │
   │     [OK]    [Abbrechen]     │
   └─────────────────────────────┘
   ```

5. **Eingabe:**
   - Von: 0
   - Bis: 1000
   - Schrittweite: 100

6. **Ergebnis:**
   ```
   Preisklasse     | Anzahl
   ----------------|--------
   0-100           | 45
   100-200         | 32
   200-300         | 28
   ...             | ...
   ```

**Nutzen:**
- Preissegmente analysieren
- Altersgruppen bilden
- Umsatzklassen erstellen

### Berechnete Felder

#### Was sind berechnete Felder?

**Erklärung:** 
Berechnete Felder sind **neue Spalten**, die Sie direkt in der Pivot-Tabelle erstellen, ohne die Ausgangsdaten zu ändern.

**Beispiel:** "Durchschnittlicher Verkaufspreis" = Gesamt / Menge

#### Schritt-für-Schritt: Berechnetes Feld erstellen

**Demonstration:**

1. **Klicken Sie in die Pivot-Tabelle**

2. **Gehen Sie zu: PivotTable-Analyse → Felder, Elemente und Gruppen → Berechnetes Feld**

3. **Dialog "Feld einfügen":**
   ```
   ┌─────────────────────────────────┐
   │ Berechnetes Feld einfügen       │
   ├─────────────────────────────────┤
   │ Name: [Durchschnittspreis    ]  │
   │                                 │
   │ Formel: =Gesamt/Menge           │
   │                                 │
   │ Verfügbare Felder:              │
   │ - Bestelldatum                  │
   │ - Region                        │
   │ - Produktkategorie              │
   │ - Gesamt                        │
   │ - Menge                         │
   │                                 │
   │  [Feld einfügen] [Abbrechen]    │
   └─────────────────────────────────┘
   ```

4. **Eingabe:**
   - Name: "Durchschnittspreis"
   - Formel: `=Gesamt/Menge`
   - Felder per Doppelklick einfügen

5. **Ergebnis:**
   - Neues Feld erscheint in der Feldliste
   - Kann wie jedes andere Feld verwendet werden
   - Berechnung erfolgt automatisch

**Weitere Beispiele für berechnete Felder:**
- Gewinnmarge: `=(Umsatz-Kosten)/Umsatz`
- Rabatt in Euro: `=Listenpreis-Verkaufspreis`
- Stückkosten: `=Gesamtkosten/Menge`

### Bedingte Formatierung in Pivot-Tabellen

**Demonstration:**

1. **Markieren Sie die Wertzellen** in der Pivot-Tabelle

2. **Start → Bedingte Formatierung → Farbskalen**

3. **Wählen Sie z.B. "Grün-Gelb-Rot"**
   - Höchste Werte = Grün
   - Niedrigste Werte = Rot

4. **Alternative: Datenbalken**
   - Visualisiert Werte als Balken in Zellen
   - Sehr intuitiv verständlich

**Nutzen:**
- Schnelles Erkennen von Ausreißern
- Visuelle Hervorhebung von Top/Flop
- Professionellere Darstellung

### Layout-Optionen

**Zeigen Sie verschiedene Layouts:**

1. **Entwurf → Berichtslayout**
   - Kompaktform (Standard)
   - Gliederungsform
   - Tabellenform

2. **Unterschiede demonstrieren:**
   - **Kompakt**: Alles in einer Spalte, mit Einrückungen
   - **Gliederung**: Jede Ebene in eigener Spalte
   - **Tabelle**: Wie eine klassische Datenbanktabelle

3. **Teilergebnisse:**
   - Entwurf → Teilergebnisse → Oben/Unten/Keine

**Empfehlung:** 
Tabellenform für Export und Weiterverarbeitung, Kompaktform für Präsentationen

---

## Häufige Fehler und Lösungen

### Fehler 1: "Feldname ist ungültig"

**Symptom:** Fehlermeldung beim Erstellen der Pivot-Tabelle

**Ursachen:**
- Leere Spaltenüberschriften
- Doppelte Spaltenüberschriften
- Leerzeilen zwischen Überschrift und Daten

**Lösung:**
1. Prüfen Sie die erste Zeile (Überschriften)
2. Jede Spalte muss einen eindeutigen Namen haben
3. Keine Leerzeilen unter den Überschriften

### Fehler 2: Daten werden nicht aktualisiert

**Symptom:** Neue Daten in der Quelltabelle erscheinen nicht in der Pivot-Tabelle

**Ursache:** Pivot-Tabelle muss manuell aktualisiert werden

**Lösung:**
1. Rechtsklick auf die Pivot-Tabelle
2. "Aktualisieren" wählen
3. Oder: **Alt + F5** drücken

**Profi-Tipp:** 
- Datei → Optionen → Daten
- "Beim Öffnen der Datei aktualisieren" aktivieren

### Fehler 3: Falsche Berechnung (Anzahl statt Summe)

**Symptom:** Excel zeigt "Anzahl von Umsatz" statt "Summe von Umsatz"

**Ursache:** Excel erkennt die Spalte als Text, nicht als Zahl

**Lösung:**
1. Prüfen Sie die Quelldaten
2. Entfernen Sie Text aus Zahlenspalten
3. Konvertieren Sie Text zu Zahlen
4. Aktualisieren Sie die Pivot-Tabelle

**Prüfung:** 
In der Quellspalte: Wenn Zahlen linksbündig sind = Text! (Sollten rechtsbündig sein)

### Fehler 4: Zu viele Zeilen in der Pivot-Tabelle

**Symptom:** Tausende Zeilen, unübersichtlich

**Ursache:** Falsches Feld in Zeilen gezogen (z.B. Bestellnummer statt Region)

**Lösung:**
1. Entfernen Sie das Feld aus dem Zeilenbereich
2. Verwenden Sie aggregierte Kategorien (Region statt Ort)
3. Nutzen Sie Filter, um Details auszublenden

### Fehler 5: Pivot-Tabelle ändert sich beim Filtern nicht

**Symptom:** Filter wird gesetzt, aber Tabelle bleibt gleich

**Ursache:** Falsches Feld gefiltert oder Caché-Problem

**Lösung:**
1. Rechtsklick → Aktualisieren
2. Prüfen Sie, ob der Filter korrekt gesetzt ist
3. Entfernen Sie alle Filter und setzen Sie neu

### Fehler 6: Gruppierung nach Monaten funktioniert nicht

**Symptom:** "Auswahl kann nicht gruppiert werden"

**Ursache:** Datumsspalte enthält keine echten Daten oder gemischte Formate

**Lösung:**
1. Prüfen Sie die Quelldaten
2. Alle Einträge müssen echte Excel-Daten sein
3. Format der Spalte auf "Datum" setzen
4. Entfernen Sie leere Zellen oder Texte aus der Datumsspalte

### Fehler 7: Pivot-Diagramm zeigt nicht alle Daten

**Symptom:** Diagramm zeigt nur einen Teil der Pivot-Tabelle

**Ursache:** Filter in der Pivot-Tabelle oder im Diagramm aktiv

**Lösung:**
1. Prüfen Sie Filter in der Pivot-Tabelle
2. Klicken Sie auf Filter-Buttons im Diagramm
3. Wählen Sie "(Alle)"

---

## Tipps für die Durchführung

### Didaktische Empfehlungen

#### 1. Live-Demonstration ist essentiell

**DO:**
- Zeigen Sie jeden Schritt am Beamer
- Gehen Sie langsam vor
- Erklären Sie, warum Sie etwas tun

**DON'T:**
- Nur theoretisch erklären
- Zu schnell durchklicken
- Schritte überspringen

#### 2. "Ich zeige - Du machst" Methode

**Ablauf:**
1. **Dozent demonstriert** einen Schritt
2. **Teilnehmer wiederholen** den Schritt
3. **Dozent prüft**, ob alle mitkommen
4. Erst dann: Nächster Schritt

**Vorteil:** Alle bleiben auf dem gleichen Stand

#### 3. Häufige Pausen für Fragen

**Nach jedem Hauptschritt:**
- "Gibt es Fragen bis hierhin?"
- "Ist bei allen die Tabelle sichtbar?"
- "Hat jemand eine Fehlermeldung?"

**Typische Problemstellen:**
- Beim Einfügen der Pivot-Tabelle
- Beim ersten Ziehen von Feldern
- Bei der Gruppierung von Daten

#### 4. Fehler bewusst machen

**Zeigen Sie typische Fehler:**
- "Was passiert, wenn ich das falsche Feld in Werte ziehe?"
- "Wie sieht es aus, wenn ich Region in Spalten statt Zeilen ziehe?"

**Vorteil:** Teilnehmer lernen, Fehler zu erkennen und zu korrigieren

#### 5. Business-Kontext betonen

**Immer fragen:**
- "Was bedeutet diese Zahl für das Geschäft?"
- "Welche Entscheidung könnten wir daraus ableiten?"
- "Welche weiteren Fragen wirft dieses Ergebnis auf?"

**Vorteil:** Teilnehmer verstehen den praktischen Nutzen

### Zeitmanagement

**Wenn Sie vor der Zeit sind:**
- Zeigen Sie erweiterte Funktionen (berechnete Felder)
- Lassen Sie Teilnehmer eigene Analysen erstellen
- Diskutieren Sie Best Practices

**Wenn Sie in Zeitnot geraten:**
- Kürzen Sie bei erweiterten Funktionen
- Gruppierung und berechnete Felder als "Hausaufgabe"
- Fokus auf Grundlagen und ein gutes Pivot-Diagramm

### Gruppendynamik

**Bei unterschiedlichem Niveau:**
- **Schnelle Teilnehmer:** Zusatzaufgaben bereithalten
- **Langsame Teilnehmer:** Nachbarn helfen lassen
- **Technische Probleme:** Nicht die ganze Gruppe aufhalten

**Partnerarbeit:**
- Je zwei Teilnehmer arbeiten zusammen
- Einer erstellt Pivot-Tabelle, einer Pivot-Diagramm
- Dann Rollen tauschen

### Technische Vorbereitung

**Für Beamer-Präsentation:**
- Zoom auf 150% für bessere Lesbarkeit
- Zeiger-Tool verwenden (Windows: Strg + P)
- Rechte Bildschirmseite zeigen (Feldliste!)

**Für Teilnehmer:**
- USB-Sticks mit Datei vorbereiten
- Alternative: Datei per Mail/Cloud vor der Session
- Notfall-Laptops für technische Probleme

### Motivation aufbauen

**Einstieg:**
"Heute lernen Sie ein Tool kennen, das Ihnen Stunden an Arbeit spart und aus Ihnen einen Excel-Hero macht!"

**Zwischendurch:**
"Sehen Sie, wie schnell wir jetzt verschiedene Auswertungen erstellen können? Ohne Pivot-Tabelle würden wir dafür Stunden brauchen!"

**Abschluss:**
"Sie können jetzt Daten analysieren wie ein Profi. Diese Fähigkeit wird Sie in Ihrer Karriere weiterbringen!"

---

## Diskussionsfragen

### Verständnisfragen (nach Grundlagen)

1. **Was ist der Hauptvorteil von Pivot-Tabellen gegenüber normalen Tabellen?**
   - Erwartete Antwort: Schnelle Zusammenfassungen, verschiedene Perspektiven, keine Veränderung der Rohdaten

2. **Warum müssen Daten in Listenform vorliegen?**
   - Erwartete Antwort: Jede Zeile = ein Datensatz, Excel kann nur so die Daten richtig gruppieren

3. **Was ist der Unterschied zwischen Zeilen und Spalten in einer Pivot-Tabelle?**
   - Erwartete Antwort: Zeilen = vertikale Kategorien, Spalten = horizontale Kategorien

4. **Wann verwende ich Summe, wann Anzahl?**
   - Erwartete Antwort: Summe für Umsätze/Mengen, Anzahl für Häufigkeiten/Bestellungen

### Anwendungsfragen (nach Übung)

5. **Welche Geschäftsfragen können Sie mit den gerade erstellten Pivot-Tabellen beantworten?**
   - Diskussion anregen: Umsatzentwicklung, Stärken/Schwächen, Trends

6. **Wie würden Sie dem Geschäftsführer die wichtigsten 3 Erkenntnisse präsentieren?**
   - Übung in Zusammenfassung und Präsentation

7. **Welche zusätzlichen Daten würden helfen, bessere Analysen zu erstellen?**
   - Kritisches Denken: Kundensegmente, Kosten, Gewinnmargen

### Transferfragen (für Fortgeschrittene)

8. **In welchen Situationen in Ihrem Arbeitsalltag könnten Sie Pivot-Tabellen einsetzen?**
   - Transfer in eigenen Kontext

9. **Was sind die Grenzen von Pivot-Tabellen?**
   - Kritische Reflexion: Nur für strukturierte Daten, keine komplexen Berechnungen, etc.

10. **Pivot-Tabelle vs. Formeln (SUMMEWENN, etc.) - wann was verwenden?**
    - Verständnis von Einsatzgebieten

---

## Bewertungskriterien

### Lernerfolgskontrolle

**Am Ende der Session sollten Teilnehmer:**

#### Grundkompetenzen (Minimum)
- [ ] Eine einfache Pivot-Tabelle erstellen können
- [ ] Felder in Zeilen, Spalten und Werte ziehen können
- [ ] Zwischen Summe und Anzahl wechseln können
- [ ] Einen Filter anwenden können
- [ ] Ein einfaches Pivot-Diagramm erstellen können

#### Fortgeschrittene Kompetenzen
- [ ] Daten nach Datum gruppieren können
- [ ] Mehrere Wertfelder gleichzeitig verwenden
- [ ] Berichtsfilter sinnvoll einsetzen
- [ ] Diagrammtyp situationsgerecht wählen
- [ ] Pivot-Tabelle aktualisieren und anpassen

#### Expertenkompetenzen (optional)
- [ ] Berechnete Felder erstellen können
- [ ] Komplexe Kreuztabellen mit mehreren Ebenen erstellen
- [ ] Bedingte Formatierung in Pivot-Tabellen anwenden
- [ ] Layout professionell anpassen
- [ ] Business-Erkenntnisse aus Pivot-Tabellen ableiten

### Praktische Prüfungsaufgabe

**Abschlussübung (20 Min):**

"Erstellen Sie eine Pivot-Tabelle und ein Pivot-Diagramm, die folgende Frage beantworten:

**'Wie hat sich der Umsatz der verschiedenen Produktkategorien über die Quartale entwickelt und welche Kategorie zeigt den stärksten Wachstumstrend?'**

**Anforderungen:**
1. Pivot-Tabelle mit Quartalen und Produktkategorien
2. Passende Berechnungen (Summen)
3. Pivot-Diagramm zur Visualisierung
4. Professionelle Beschriftungen
5. Kurze schriftliche Interpretation (3-5 Sätze)"

**Bewertung:**
- Technische Umsetzung: 60%
- Visualisierung: 20%
- Interpretation: 20%

---

## Nachbereitung und Weiterführendes

### Hausaufgabe (optional)

"Bringen Sie einen eigenen Datensatz aus Ihrem Arbeitsalltag mit und erstellen Sie:
1. Eine Pivot-Tabelle zur Beantwortung einer relevanten Geschäftsfrage
2. Ein aussagekräftiges Pivot-Diagramm
3. Eine kurze Präsentation (3 Slides) Ihrer Erkenntnisse"

### Weiterführende Themen

**Für interessierte Teilnehmer:**
- **Power Pivot**: Für große Datenmengen (Millionen Zeilen)
- **Mehrere Tabellen verbinden**: Mit Datenmodell
- **Zeitintelligenz**: Vergleiche zum Vorjahr, laufende Summen
- **DAX-Formeln**: Erweiterte Berechnungen in Power Pivot
- **Makros**: Automatisierung von Pivot-Tabellen-Updates

### Ressourcen für Teilnehmer

**Empfohlene Lernmaterialien:**
- Microsoft Learn: "Pivot-Tabellen in Excel"
- YouTube-Kanäle: ExcelIsFun, MrExcel
- Online-Kurse: LinkedIn Learning, Udemy
- Buch: "Excel Pivot Tables & Pivot Charts" von Paul McFedries

### Follow-Up Session (optional)

**Themen für eine Vertiefungssession:**
- Power Query zur Datenaufbereitung
- Kombination mehrerer Datenquellen
- Automatisierung mit VBA
- Dashboard-Erstellung mit Pivot-Tabellen
- Best Practices für große Datasets

---

## Checkliste für Dozenten

### Vor der Session

- [ ] Beispieldatei mit 100-200 Datensätzen vorbereitet
- [ ] Musterlösung erstellt
- [ ] Beamer und Excel getestet
- [ ] Handouts ausgedruckt oder digital bereit
- [ ] USB-Sticks mit Übungsdateien
- [ ] Zeitplan erstellt
- [ ] Zusatzaufgaben für schnelle Teilnehmer vorbereitet

### Während der Session

- [ ] Zoom auf 150% für Beamer eingestellt
- [ ] Jeder Schritt langsam demonstriert
- [ ] Regelmäßig gefragt: "Sind alle soweit?"
- [ ] Fehler bewusst gemacht und korrigiert
- [ ] Pausen für Fragen eingebaut
- [ ] Business-Kontext immer betont

### Nach der Session

- [ ] Feedback der Teilnehmer eingeholt
- [ ] Übungsdateien per E-Mail verschickt
- [ ] Probleme und Verbesserungen notiert
- [ ] Musterlösungen zur Verfügung gestellt
- [ ] Optional: Follow-Up Termin vereinbart

---

## Zusammenfassung

### Die wichtigsten Botschaften

1. **Pivot-Tabellen sparen enorm Zeit** - Stunden an manueller Arbeit in Minuten erledigt

2. **Flexibilität ist der Schlüssel** - Gleiche Daten, verschiedene Perspektiven

3. **Keine Angst vor Fehlern** - Man kann immer Felder verschieben oder entfernen

4. **Visualisierung verstärkt Verständnis** - Pivot-Diagramme machen Daten greifbar

5. **Praxis, Praxis, Praxis** - Je mehr man übt, desto schneller wird man

### Erfolgsformel

```
Gute Datenstruktur
+
Klare Fragestellung
+
Richtige Felder in richtigen Bereichen
+
Passende Visualisierung
=
Aussagekräftige Analyse
```

---

**Viel Erfolg bei der Durchführung! 📊✨**

*Denken Sie daran: Der "Aha-Moment", wenn Teilnehmer zum ersten Mal eine funktionierende Pivot-Tabelle erstellt haben, ist unbezahlbar!*
