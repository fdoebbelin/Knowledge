## Einführung

Diese Übung wurde entwickelt, um Teilnehmern ein umfassendes Verständnis aller Arten von Zellbezügen in Microsoft Excel zu vermitteln. Die Übung basiert auf einem realistischen Geschäftsszenario und führt die Teilnehmer Schritt für Schritt durch die verschiedenen Bezugsarten.

### Lernziele

Nach Abschluss dieser Übung können die Teilnehmer:
- Relative Zellbezüge erkennen und anwenden
- Absolute Zellbezüge korrekt einsetzen
- Gemischte Zellbezüge situationsgerecht verwenden
- 3D-Bezüge für Berechnungen über mehrere Arbeitsblätter nutzen
- Bezüge über Arbeitsmappen hinweg erstellen und verstehen

### Zeitaufwand
- Einführung und Aufbau der Arbeitsmappe: 15 Minuten
- Durchführung der Übungen: 45-60 Minuten
- Besprechung und Fragen: 15 Minuten
- **Gesamt**: ca. 90 Minuten

---

## Übungsaufbau

### Szenario
Die Teilnehmer arbeiten für die Firma "TechVision GmbH", ein mittelständisches Unternehmen mit drei Abteilungen (Vertrieb, Marketing, Entwicklung). Die Übung umfasst die Erstellung und Auswertung von Quartalszahlen.

### Benötigte Arbeitsblätter

#### Hauptarbeitsmappe: "TechVision_Quartalsbericht.xlsx"

1. **Tabelle "Grunddaten"**
   - Enthält Konstanten wie MwSt-Satz, Wechselkurs, Rabatte

2. **Tabelle "Q1_Vertrieb"**
   - Verkaufsdaten für das erste Quartal

3. **Tabelle "Q2_Vertrieb"**
   - Verkaufsdaten für das zweite Quartal

4. **Tabelle "Q3_Vertrieb"**
   - Verkaufsdaten für das dritte Quartal

5. **Tabelle "Jahresübersicht"**
   - Aggregation aller Quartale

6. **Tabelle "Preisliste"**
   - Produktpreise und Berechnungen

#### Zusätzliche Arbeitsmappe: "Vorjahresvergleich.xlsx"
- Für arbeitsmappenübergreifende Bezüge

---

## Aufgabe 1: Relative Zellbezüge

### Vorbereitung (Dozent führt vor)

**Arbeitsblatt "Q1_Vertrieb" erstellen:**

| A | B | C | D | E |
|---|---|---|---|---|
| **Produkt** | **Stückzahl** | **Einzelpreis** | **Zwischensumme** | **Provision (10%)** |
| Laptop Pro | 15 | 1200 | | |
| Desktop PC | 8 | 950 | | |
| Tablet X | 25 | 450 | | |
| Monitor 4K | 30 | 280 | | |

### Aufgabenstellung für Teilnehmer

Die Teilnehmer sollen:
1. In Zelle D2 die Formel `=B2*C2` eingeben
2. Diese Formel nach unten bis D5 kopieren
3. In Zelle E2 die Formel `=D2*0,1` eingeben
4. Diese Formel nach unten bis E5 kopieren

### Lernziel
Verstehen, dass sich relative Bezüge automatisch anpassen (B2→B3, C2→C3 usw.)

### Lösung

Die Formeln passen sich wie folgt an:
- D2: `=B2*C2` → 18.000 €
- D3: `=B3*C3` → 7.600 €
- D4: `=B4*C4` → 11.250 €
- D5: `=B5*C5` → 8.400 €

---

## Aufgabe 2: Absolute Zellbezüge

### Vorbereitung (Dozent führt vor)

**Arbeitsblatt "Grunddaten" erstellen:**

| A | B |
|---|---|
| **Bezeichnung** | **Wert** |
| MwSt-Satz | 0,19 |
| Rabatt Großkunden | 0,15 |
| Wechselkurs EUR→USD | 1,10 |
| Zielkommission | 0,05 |

**Im Arbeitsblatt "Q1_Vertrieb" neue Spalte hinzufügen:**

| F |
|---|
| **Brutto (inkl. MwSt)** |
| |

### Aufgabenstellung für Teilnehmer

Die Teilnehmer sollen:
1. In Zelle F2 eine Formel erstellen, die die Zwischensumme (D2) mit der MwSt multipliziert
2. Die MwSt soll aus dem Arbeitsblatt "Grunddaten" (Zelle B2) kommen
3. Der Bezug auf die MwSt muss absolut sein, damit er beim Kopieren gleich bleibt
4. Formel: `=D2*(1+Grunddaten!$B$2)`
5. Formel nach unten kopieren

### Lernziel
Verstehen, dass absolute Bezüge ($B$2) beim Kopieren konstant bleiben

### Lösung

- F2: `=D2*(1+Grunddaten!$B$2)` → 21.420 €
- F3: `=D3*(1+Grunddaten!$B$2)` → 9.044 €
- F4: `=D4*(1+Grunddaten!$B$2)` → 13.387,50 €
- F5: `=D5*(1+Grunddaten!$B$2)` → 9.996 €

Alle Formeln beziehen sich auf die konstante Zelle Grunddaten!B2

---

## Aufgabe 3: Gemischte Zellbezüge

### Vorbereitung (Dozent führt vor)

**Arbeitsblatt "Preisliste" erstellen:**

Eine Rabattstaffel, bei der unterschiedliche Mengen zu unterschiedlichen Rabatten führen:

|   | A | B | C | D | E |
|---|---|---|---|---|---|
| 1 | **Produkt** | **10 Stück** | **25 Stück** | **50 Stück** | **100 Stück** |
| 2 | **Basispreis** | 0% | 5% | 10% | 15% |
| 3 | Laptop Pro | | | | |
| 4 | Desktop PC | | | | |
| 5 | Tablet X | | | | |

In Spalte A zusätzlich die Basispreise eintragen:
- Zeile 3: füge in einer neuen Spalte (z.B. Spalte F) den Wert 1200 hinzu
- Oder integriere direkt in die Formel

**Besseres Layout:**

|   | A | B | C | D | E |
|---|---|---|---|---|---|
| 1 | **Produkt/Rabatt** | **0% (10 St.)** | **5% (25 St.)** | **10% (50 St.)** | **15% (100 St.)** |
| 2 | Laptop Pro (1200€) | | | | |
| 3 | Desktop PC (950€) | | | | |
| 4 | Tablet X (450€) | | | | |

### Aufgabenstellung für Teilnehmer

Die Teilnehmer sollen:
1. Die Basispreise in einer Hilfsspalte (F2:F4) eintragen: 1200, 950, 450
2. In Zelle B2 eine Formel erstellen: `=$F2*(1-B$1)`
3. Diese Formel sowohl nach rechts als auch nach unten kopieren
4. Beobachten, wie sich die Bezüge anpassen

### Lernziel
Verstehen, dass:
- `$F2` die Spalte F fixiert, aber die Zeile variabel lässt (beim Kopieren nach unten ändert sich F2→F3)
- `B$1` die Zeile 1 fixiert, aber die Spalte variabel lässt (beim Kopieren nach rechts ändert sich B$1→C$1)

### Lösung

Die Formel `=$F2*(1-B$1)` passt sich an:
- B2: `=$F2*(1-B$1)` → 1200 * (1-0) = 1200 €
- C2: `=$F2*(1-C$1)` → 1200 * (1-0,05) = 1140 €
- D2: `=$F2*(1-D$1)` → 1200 * (1-0,10) = 1080 €
- E2: `=$F2*(1-E$1)` → 1200 * (1-0,15) = 1020 €
- B3: `=$F3*(1-B$1)` → 950 * (1-0) = 950 €
- usw.

---

## Aufgabe 4: 3D-Bezüge

### Vorbereitung (Dozent führt vor)

**Arbeitsblätter Q1_Vertrieb, Q2_Vertrieb und Q3_Vertrieb erstellen**

Alle drei Blätter haben die gleiche Struktur (aus Aufgabe 1), aber unterschiedliche Zahlen:

**Q2_Vertrieb:**

|Produkt|Stückzahl|Einzelpreis|
|---|---|---|
|Laptop Pro|18|1200|
|Desktop PC|10|950|
|Tablet X|30|450|
|Monitor 4K|35|280|

---

**Q3_Vertrieb:**


|Produkt|Stückzahl|Einzelpreis|
|---|---|---|
|Laptop Pro|22|1200|
|Desktop PC|12|950|
|Tablet X|28|450|
|Monitor 4K|40|280|

Falls du weitere Anpassungen oder Analysen zu diesen Daten brauchst, lass es mich wissen!

**Arbeitsblatt "Jahresübersicht" erstellen:**

| A           | B                            | C                         |
| ----------- | ---------------------------- | ------------------------- |
| **Produkt** | **Gesamt Stückzahl (Q1-Q3)** | **Gesamt Umsatz (Q1-Q3)** |
| Laptop Pro  |                              |                           |
| Desktop PC  |                              |                           |
| Tablet X    |                              |                           |
| Monitor 4K  |                              |                           |

### Aufgabenstellung für Teilnehmer

Die Teilnehmer sollen:
1. In Zelle B2 der "Jahresübersicht" die Gesamtstückzahl für Laptop Pro berechnen
2. Formel verwenden: `=SUMME(Q1_Vertrieb:Q3_Vertrieb!B2)`
3. Diese Formel nach unten kopieren
4. In Zelle C2 den Gesamtumsatz berechnen: `=SUMME(Q1_Vertrieb:Q3_Vertrieb!D2)`
5. Diese Formel nach unten kopieren

### Lernziel
Verstehen, dass 3D-Bezüge dieselbe Zelle aus mehreren aufeinanderfolgenden Arbeitsblättern referenzieren

### Lösung

**Stückzahlen:**
- B2: `=SUMME(Q1_Vertrieb:Q3_Vertrieb!B2)` → 15+18+22 = 55 Stück
- B3: `=SUMME(Q1_Vertrieb:Q3_Vertrieb!B3)` → 8+10+12 = 30 Stück
- B4: `=SUMME(Q1_Vertrieb:Q3_Vertrieb!B4)` → 25+30+28 = 83 Stück
- B5: `=SUMME(Q1_Vertrieb:Q3_Vertrieb!B5)` → 30+35+40 = 105 Stück

**Hinweis für Dozenten:** Betonen Sie, dass die Arbeitsblätter zwischen dem Doppelpunkt (Q1_Vertrieb:Q3_Vertrieb) im Arbeitsmappen-Tab nebeneinander liegen müssen!

---

## Aufgabe 5: Bezüge über Arbeitsmappen hinweg

### Vorbereitung (Dozent führt vor)

**Neue Arbeitsmappe "Vorjahresvergleich.xlsx" erstellen**

Diese Arbeitsmappe enthält ein Arbeitsblatt "2024_Daten":

| A | B |
|---|---|
| **Produkt** | **Verkäufe 2024** |
| Laptop Pro | 48 |
| Desktop PC | 25 |
| Tablet X | 70 |
| Monitor 4K | 85 |

Speichern Sie diese Datei im gleichen Ordner wie die Hauptarbeitsmappe.

**In der Hauptarbeitsmappe "TechVision_Quartalsbericht.xlsx"**

Im Arbeitsblatt "Jahresübersicht" neue Spalten hinzufügen:

| D | E |
|---|---|
| **Vorjahr (2024)** | **Veränderung in %** |
| | |

### Aufgabenstellung für Teilnehmer

Die Teilnehmer sollen:
1. In Zelle D2 der Jahresübersicht einen Bezug auf die andere Arbeitsmappe erstellen
2. Formel: `=[Vorjahresvergleich.xlsx]2024_Daten!B2`
3. Diese Formel nach unten kopieren
4. In Zelle E2 die prozentuale Veränderung berechnen: `=(B2-D2)/D2`
5. Diese Formel nach unten kopieren und als Prozent formatieren

### Lernziel
Verstehen, wie Bezüge über Arbeitsmappen funktionieren und dass Excel automatisch den Pfad hinzufügt, wenn die Datei verschoben wird

### Lösung

- D2: `=[Vorjahresvergleich.xlsx]2024_Daten!B2` → 48
- E2: `=(B2-D2)/D2` → (55-48)/48 = 14,58%

**Wichtiger Hinweis für Dozenten:**
- Wenn die Datei Vorjahresvergleich.xlsx geschlossen ist, zeigt Excel den vollständigen Pfad an
- Wenn sie geöffnet ist, zeigt Excel nur den Dateinamen
- Teilnehmer sollten beide Dateien öffnen, um die Übung durchzuführen

---

## Zusatzaufgabe: Kombination aller Bezugsarten

### Aufgabenstellung

Erstellen Sie im Arbeitsblatt "Jahresübersicht" eine erweiterte Analyse:

1. **Spalte F**: Durchschnittspreis pro Produkt (über alle drei Quartale)
   - Verwenden Sie 3D-Bezüge auf Spalte C (Einzelpreis)
   - Formel: `=MITTELWERT(Q1_Vertrieb:Q3_Vertrieb!C2)`

2. **Spalte G**: Umsatz mit Großkundenrabatt
   - Verwenden Sie einen absoluten Bezug auf den Rabatt aus "Grunddaten"
   - Formel: `=C2*(1-Grunddaten!$B$3)`

3. **Spalte H**: Umsatz in USD
   - Verwenden Sie einen absoluten Bezug auf den Wechselkurs aus "Grunddaten"
   - Formel: `=C2*Grunddaten!$B$4`

### Lernziel
Die Teilnehmer sollen alle erlernten Bezugsarten in einer komplexen Analyse kombinieren

---

## Tipps für die Durchführung

### Häufige Fehler
1. **Dollarzeichen vergessen**: Teilnehmer vergessen oft das $ bei absoluten Bezügen
2. **Falsche Position der $**: `$A1` vs. `A$1` vs. `$A$1` verwechseln
3. **3D-Bezüge**: Arbeitsblätter müssen in der richtigen Reihenfolge sein
4. **Externe Bezüge**: Datei muss geöffnet sein oder Pfad muss stimmen

### Diskussionsfragen
- Wann würden Sie in der Praxis welchen Bezugstyp verwenden?
- Was passiert, wenn Sie ein Arbeitsblatt umbenennen, das in 3D-Bezügen verwendet wird?
- Wie können externe Bezüge problematisch werden, wenn Dateien verschoben werden?

### Erweiterungsmöglichkeiten
- Bedingte Formatierung auf Basis der Berechnungen
- Diagramme aus den aggregierten Daten erstellen
- Pivot-Tabellen zur weiteren Analyse

---

## Lösungsdatei

Es wird empfohlen, eine vollständige Lösungsdatei für Teilnehmer bereitzustellen, die Schwierigkeiten haben. Diese sollte alle Formeln und korrekten Bezüge enthalten.

---

## Lernerfolgskontrolle

### Verständnisfragen zur Besprechung:

1. Was passiert mit der Formel `=A1+B1`, wenn Sie sie von C1 nach C2 kopieren?
2. Wie würden Sie einen Bezug auf Zelle B5 schreiben, der sich beim Kopieren nie ändert?
3. Wie erstellen Sie einen Bezug, der die Spalte fixiert, aber die Zeile variabel lässt?
4. Nennen Sie ein praktisches Beispiel, wo 3D-Bezüge sinnvoll sind.
5. Was ist der Vorteil und der Nachteil von arbeitsmappenübergreifenden Bezügen?

### Erwartete Antworten:

1. Die Formel wird zu `=A2+B2` (relative Bezüge passen sich an)
2. `=$B$5` (absolute Bezüge mit $ vor Spalte und Zeile)
3. `=$B5` (gemischter Bezug, $ nur vor der Spalte)
4. Konsolidierung von Monatsdaten, Quartalszahlen, Filialdaten etc.
5. Vorteil: Zentrale Datenhaltung; Nachteil: Dateipfade können problematisch sein

---

## Zusammenfassung

Diese Übung führt strukturiert durch alle Zellbezugsarten in Excel:
- **Relativ**: Für wiederkehrende Berechnungen, die sich anpassen
- **Absolut**: Für Konstanten wie Steuersätze oder Umrechnungsfaktoren
- **Gemischt**: Für Tabellen mit festen Zeilen oder Spalten
- **3D**: Für Konsolidierung gleichartiger Daten aus mehreren Blättern
- **Extern**: Für Vergleiche mit anderen Datenquellen
