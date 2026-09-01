## Willkommen bei TechVision GmbH!

In dieser Übung arbeiten Sie mit Quartalszahlen eines mittelständischen Technologie-Unternehmens. Sie werden alle wichtigen Arten von Zellbezügen in Excel kennenlernen und praktisch anwenden.

### Was Sie lernen werden:
- ✓ Relative Zellbezüge für flexible Berechnungen
- ✓ Absolute Zellbezüge für konstante Werte
- ✓ Gemischte Zellbezüge für Tabellen
- ✓ 3D-Bezüge für die Arbeit mit mehreren Arbeitsblättern
- ✓ Arbeitsmappenübergreifende Bezüge für externe Datenquellen

---

## Vorbereitung

### Schritt 1: Arbeitsmappen erstellen

Erstellen Sie zwei Excel-Arbeitsmappen:
1. **TechVision_Quartalsbericht.xlsx** (Hauptarbeitsmappe)
2. **Vorjahresvergleich.xlsx** (für die letzte Aufgabe)

Speichern Sie beide Dateien im gleichen Ordner!

---

## Aufgabe 1: Relative Zellbezüge verstehen

### Ziel
Lernen Sie, wie sich Formeln automatisch anpassen, wenn Sie sie kopieren.

### Schritt-für-Schritt-Anleitung

1. **Erstellen Sie ein neues Arbeitsblatt** in der Datei "TechVision_Quartalsbericht.xlsx"
2. **Benennen Sie es um** in "Q1_Vertrieb"
3. **Geben Sie folgende Daten ein:**

| A | B | C | D | E |
|---|---|---|---|---|
| **Produkt** | **Stückzahl** | **Einzelpreis** | **Zwischensumme** | **Provision (10%)** |
| Laptop Pro | 15 | 1200 | | |
| Desktop PC | 8 | 950 | | |
| Tablet X | 25 | 450 | | |
| Monitor 4K | 30 | 280 | | |

4. **Berechnen Sie die Zwischensumme:**
   - Klicken Sie in Zelle **D2**
   - Geben Sie die Formel ein: `=B2*C2`
   - Drücken Sie **Enter**
   - Kopieren Sie die Formel nach unten bis **D5** (Doppelklick auf das Ausfüllkästchen)

5. **Berechnen Sie die Provision:**
   - Klicken Sie in Zelle **E2**
   - Geben Sie die Formel ein: `=D2*0,1`
   - Drücken Sie **Enter**
   - Kopieren Sie die Formel nach unten bis **E5**

### ✍️ Beobachtungsaufgabe
- Klicken Sie auf Zelle D3 und schauen Sie sich die Formel in der Bearbeitungsleiste an
- Was hat sich im Vergleich zu D2 geändert?
- **Notieren Sie Ihre Beobachtung:**

```
_________________________________________________________________

_________________________________________________________________
```

### 💡 Reflexion
Warum ist diese automatische Anpassung nützlich?

---

## Aufgabe 2: Absolute Zellbezüge einsetzen

### Ziel
Lernen Sie, wie Sie feste Werte in Berechnungen verwenden, die sich beim Kopieren nicht ändern.

### Schritt-für-Schritt-Anleitung

1. **Erstellen Sie ein neues Arbeitsblatt** namens "Grunddaten"
2. **Geben Sie folgende Daten ein:**

| A | B |
|---|---|
| **Bezeichnung** | **Wert** |
| MwSt-Satz | 0,19 |
| Rabatt Großkunden | 0,15 |
| Wechselkurs EUR→USD | 1,10 |
| Zielkommission | 0,05 |

3. **Wechseln Sie zurück zum Arbeitsblatt "Q1_Vertrieb"**
4. **Fügen Sie eine neue Spaltenüberschrift hinzu:**
   - In Zelle **F1**: "Brutto (inkl. MwSt)"

5. **Berechnen Sie den Bruttopreis mit MwSt:**
   - Klicken Sie in Zelle **F2**
   - Geben Sie die Formel ein: `=D2*(1+Grunddaten!$B$2)`
   - ⚠️ **Wichtig:** Achten Sie auf die Dollarzeichen vor B und vor 2!
   - Drücken Sie **Enter**
   - Kopieren Sie die Formel nach unten bis **F5**

### ✍️ Beobachtungsaufgabe
- Klicken Sie auf Zelle F3 und schauen Sie sich die Formel an
- Welcher Teil der Formel hat sich geändert?
- Welcher Teil ist gleich geblieben?
- **Notieren Sie Ihre Beobachtung:**

```
Geändert: ________________________________________________________

Gleich geblieben: ________________________________________________
```

### 💡 Reflexion
In welchen Situationen würden Sie in Ihrer Arbeit absolute Bezüge benötigen?

---

## Aufgabe 3: Gemischte Zellbezüge anwenden

### Ziel
Lernen Sie, wie Sie nur die Spalte ODER nur die Zeile fixieren können.

### Schritt-für-Schritt-Anleitung

1. **Erstellen Sie ein neues Arbeitsblatt** namens "Preisliste"

2. **Geben Sie folgende Struktur ein:**

|   | A | B | C | D | E | F |
|---|---|---|---|---|---|---|
| **1** | **Produkt/Rabatt** | **0%** | **5%** | **10%** | **15%** | **Basispreis** |
| **2** | Laptop Pro | | | | | 1200 |
| **3** | Desktop PC | | | | | 950 |
| **4** | Tablet X | | | | | 450 |

3. **Erstellen Sie die Rabattberechnung:**
   - Klicken Sie in Zelle **B2**
   - Geben Sie die Formel ein: `=$F2*(1-B$1)`
   - ⚠️ **Wichtig:** 
     - Das $ steht nur vor dem **F** (fixiert die Spalte)
     - Das $ steht nur vor der **1** (fixiert die Zeile)
   - Drücken Sie **Enter**
   
4. **Kopieren Sie die Formel:**
   - Markieren Sie Zelle B2
   - Kopieren Sie die Formel sowohl **nach rechts** (bis E2) als auch **nach unten** (bis B4)
   - Tipp: Markieren Sie B2:E4 und drücken Sie **Strg+D** (nach unten) und **Strg+R** (nach rechts)

### ✍️ Beobachtungsaufgabe
- Klicken Sie auf verschiedene Zellen (z.B. C3, D4) und schauen Sie sich die Formeln an
- Füllen Sie die Tabelle aus:

| Zelle | Formel | Ergebnis |
|-------|--------|----------|
| B2 | =$F2*(1-B$1) | 1200 |
| C2 | | |
| B3 | | |
| D4 | | |

### 💡 Reflexion
Warum ist `$F2` sinnvoll? Was würde passieren, wenn Sie nur `F2` schreiben würden?

---

## Aufgabe 4: 3D-Bezüge für mehrere Arbeitsblätter

### Ziel
Lernen Sie, wie Sie Daten aus mehreren Arbeitsblättern gleichzeitig auswerten können.

### Schritt-für-Schritt-Anleitung

1. **Erstellen Sie zwei weitere Arbeitsblätter:**
   - **Q2_Vertrieb** mit folgenden Daten:

| A | B | C |
|---|---|---|
| **Produkt** | **Stückzahl** | **Einzelpreis** |
| Laptop Pro | 18 | 1200 |
| Desktop PC | 10 | 950 |
| Tablet X | 30 | 450 |
| Monitor 4K | 35 | 280 |

   - **Q3_Vertrieb** mit folgenden Daten:

| A | B | C |
|---|---|---|
| **Produkt** | **Stückzahl** | **Einzelpreis** |
| Laptop Pro | 22 | 1200 |
| Desktop PC | 12 | 950 |
| Tablet X | 28 | 450 |
| Monitor 4K | 40 | 280 |

2. **Berechnen Sie die Zwischensummen** in beiden neuen Blättern:
   - Fügen Sie Spalte D "Zwischensumme" hinzu
   - Verwenden Sie die Formel `=B2*C2` und kopieren Sie nach unten

3. **Erstellen Sie ein neues Arbeitsblatt** namens "Jahresübersicht"

4. **Geben Sie folgende Struktur ein:**

| A | B | C |
|---|---|---|
| **Produkt** | **Gesamt Stückzahl (Q1-Q3)** | **Gesamt Umsatz (Q1-Q3)** |
| Laptop Pro | | |
| Desktop PC | | |
| Tablet X | | |
| Monitor 4K | | |

5. **Berechnen Sie die Gesamtstückzahl:**
   - Klicken Sie in Zelle **B2**
   - Geben Sie die Formel ein: `=SUMME(Q1_Vertrieb:Q3_Vertrieb!B2)`
   - ⚠️ **Wichtig:** Der Doppelpunkt zwischen den Arbeitsblattnamen bedeutet "von Q1 bis Q3"
   - Drücken Sie **Enter**
   - Kopieren Sie die Formel nach unten bis **B5**

6. **Berechnen Sie den Gesamtumsatz:**
   - Klicken Sie in Zelle **C2**
   - Geben Sie die Formel ein: `=SUMME(Q1_Vertrieb:Q3_Vertrieb!D2)`
   - Kopieren Sie die Formel nach unten

### ✍️ Beobachtungsaufgabe
Überprüfen Sie Ihre Ergebnisse:
- Laptop Pro Gesamtstückzahl: _______ (sollte 55 sein)
- Desktop PC Gesamtumsatz: _______ (berechnen Sie 8+10+12 = 30, dann 30×950 = ?)

### 💡 Reflexion
In welchen Situationen sind 3D-Bezüge in der Praxis besonders hilfreich?

---

## Aufgabe 5: Arbeitsmappenübergreifende Bezüge

### Ziel
Lernen Sie, wie Sie Daten aus einer anderen Excel-Datei referenzieren können.

### Schritt-für-Schritt-Anleitung

1. **Öffnen Sie die Datei "Vorjahresvergleich.xlsx"** (oder erstellen Sie sie)

2. **Erstellen Sie ein Arbeitsblatt** namens "2024_Daten" mit folgenden Daten:

| A | B |
|---|---|
| **Produkt** | **Verkäufe 2024** |
| Laptop Pro | 48 |
| Desktop PC | 25 |
| Tablet X | 70 |
| Monitor 4K | 85 |

3. **Speichern Sie die Datei** und **lassen Sie sie geöffnet**

4. **Wechseln Sie zurück zu "TechVision_Quartalsbericht.xlsx"**

5. **Im Arbeitsblatt "Jahresübersicht"** fügen Sie neue Spalten hinzu:
   - Spalte D: "Vorjahr (2024)"
   - Spalte E: "Veränderung in %"

6. **Erstellen Sie den externen Bezug:**
   - Klicken Sie in Zelle **D2**
   - Geben Sie die Formel ein: `=[Vorjahresvergleich.xlsx]2024_Daten!B2`
   - ⚠️ **Wichtig:** Die eckigen Klammern [ ] umschließen den Dateinamen
   - **Tipp:** Sie können auch auf die andere Datei klicken und die Zelle auswählen - Excel erstellt die Formel automatisch
   - Drücken Sie **Enter**
   - Kopieren Sie die Formel nach unten

7. **Berechnen Sie die prozentuale Veränderung:**
   - Klicken Sie in Zelle **E2**
   - Geben Sie die Formel ein: `=(B2-D2)/D2`
   - Drücken Sie **Enter**
   - Kopieren Sie die Formel nach unten
   - Formatieren Sie die Spalte als **Prozent** (Rechtsklick → Zellen formatieren → Prozent)

### ✍️ Beobachtungsaufgabe
- Schließen Sie die Datei "Vorjahresvergleich.xlsx"
- Schauen Sie sich die Formel in D2 erneut an
- Was hat sich verändert?

```
_________________________________________________________________

_________________________________________________________________
```

### 💡 Reflexion
Was sind die Vor- und Nachteile von arbeitsmappenübergreifenden Bezügen?

**Vorteile:**
```
_________________________________________________________________
```

**Nachteile:**
```
_________________________________________________________________
```

---

## 🎯 Zusatzaufgabe für Schnelle: Alle Bezugsarten kombinieren

Wenn Sie alle Aufgaben abgeschlossen haben, versuchen Sie Folgendes:

### Im Arbeitsblatt "Jahresübersicht" neue Spalten hinzufügen:

1. **Spalte F: Durchschnittspreis**
   - Berechnen Sie den Durchschnitt der Einzelpreise aus Q1-Q3
   - Verwenden Sie 3D-Bezüge
   - Formel: `=MITTELWERT(Q1_Vertrieb:Q3_Vertrieb!C2)`

2. **Spalte G: Umsatz mit Großkundenrabatt**
   - Wenden Sie den Großkundenrabatt aus "Grunddaten" an
   - Verwenden Sie absolute Bezüge
   - Formel: `=C2*(1-Grunddaten!$B$3)`

3. **Spalte H: Umsatz in USD**
   - Rechnen Sie den Umsatz in US-Dollar um
   - Verwenden Sie den Wechselkurs aus "Grunddaten"
   - Formel: `=C2*Grunddaten!$B$4`

4. **Erstellen Sie ein Diagramm**
   - Vergleichen Sie die Gesamtumsätze der vier Produkte visuell

---

## ✅ Checkliste: Haben Sie alles verstanden?

Beantworten Sie für sich selbst:

- [ ] Ich kann erklären, was ein relativer Zellbezug ist
- [ ] Ich weiß, wann ich absolute Bezüge ($B$2) verwenden muss
- [ ] Ich verstehe den Unterschied zwischen $B2, B$2 und $B$2
- [ ] Ich kann 3D-Bezüge verwenden, um mehrere Arbeitsblätter auszuwerten
- [ ] Ich kann Daten aus anderen Excel-Dateien referenzieren
- [ ] Ich kann alle Bezugsarten in praktischen Situationen anwenden

---

## 📝 Notizen und Fragen

Nutzen Sie diesen Bereich für eigene Notizen oder Fragen:

```
_________________________________________________________________

_________________________________________________________________

_________________________________________________________________

_________________________________________________________________

_________________________________________________________________
```

---

## 🎓 Zusammenfassung

### Die 5 Arten von Zellbezügen

| Typ | Syntax | Beispiel | Wann verwenden? |
|-----|--------|----------|-----------------|
| **Relativ** | A1 | =A1+B1 | Wenn sich Bezüge beim Kopieren anpassen sollen |
| **Absolut** | $A$1 | =$A$1*0,19 | Für konstante Werte (Steuern, Wechselkurse) |
| **Gemischt (Spalte fixiert)** | $A1 | =$A1*B1 | Für Tabellen mit festen Spalten |
| **Gemischt (Zeile fixiert)** | A$1 | =A$1*B2 | Für Tabellen mit festen Zeilen |
| **3D-Bezug** | Blatt1:Blatt3!A1 | =SUMME(Jan:Dez!A1) | Für gleiche Zellen über mehrere Blätter |
| **Extern** | [Datei.xlsx]Blatt!A1 | =[Budget.xlsx]Q1!B5 | Für Daten aus anderen Arbeitsmappen |

---

## 💾 Speichern nicht vergessen!

Speichern Sie Ihre Arbeitsmappe regelmäßig ab:
- **Strg + S** (Windows)
- **Cmd + S** (Mac)

**Viel Erfolg bei der Übung! 🎉**
