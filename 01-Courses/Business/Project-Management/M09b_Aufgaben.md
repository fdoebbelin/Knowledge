## Überblick

Dieses Aufgabenblatt begleitet die Einführung in Kostenplanung und Budgetierung. Alle Übungen beziehen sich auf ein durchgehendes **Fallprojekt** (Website-Redesign), das Sie parallel zu den anderen Modulen bearbeiten. Die Aufgaben sind progressiv aufgebaut – von einfacher Kostenestimation bis zu komplexer Earned-Value-Analyse.

---

## Aufgabe 1: Kostenestimation – Drei Methoden anwenden

### Hintergrund

Sie sind Projektmanager für das Projekt **„Mobile App für Kundenverwaltung"** (CRM-App für mittelständisches Unternehmen). Das Projekt hat eine geplante Laufzeit von 5 Monaten. Die Geschäftsleitung fragt: **„Wie viel wird die App kosten?"**

### Aufgaben

#### 1.1 Top-Down-Schätzung

Ein ähnliches CRM-Projekt ist vor 18 Monaten mit **185.000 EUR** abgeschlossen worden. 

**Bereinigungsfaktoren:**
- Inflation seit damals: +3% pro Jahr → +4,5% Gesamtinflation
- Die aktuelle App ist **komplexer**: +12% Komplexitätszuschlag
- Die aktuelle App hat **weniger externe Integrationen**: –8% Reduktion

**Aufgabe:**
Berechnen Sie die Top-Down-Schätzung für die neue App.

```
Historisches Projekt:           185.000 EUR
× Inflation (1,045):            ________ EUR
= Nach Inflationsbereinigung:   ________ EUR
× Komplexitätsfaktor (1,12):    ________ EUR
× Integrationsfaktor (0,92):    ________ EUR
= Top-Down-Schätzung:          [IHRE ANTWORT] EUR
```

#### 1.2 Bottom-Up-Schätzung

Im Projekt wurden folgende Arbeitspakete identifiziert:

| Arbeitspaket | Arbeitstage | Stundensatz | Materialkosten | Externe Kosten |
|---|---|---|---|---|
| Anforderungsanalyse | 12 | 90 EUR/h | 800 EUR | 0 EUR |
| UI/UX-Design | 18 | 95 EUR/h | 2.000 EUR | 3.000 EUR |
| Backend-Entwicklung | 40 | 85 EUR/h | 1.500 EUR | 5.000 EUR |
| Frontend-Entwicklung | 35 | 80 EUR/h | 1.200 EUR | 0 EUR |
| Datenbank-Setup | 8 | 95 EUR/h | 500 EUR | 2.000 EUR |
| Testing & QA | 20 | 75 EUR/h | 1.000 EUR | 0 EUR |
| Deployment & Schulung | 10 | 85 EUR/h | 0 EUR | 4.000 EUR |

**Hinweis:** 1 Arbeitstag = 8 Stunden

**Aufgabe:**
Berechnen Sie für jedes Arbeitspaket die Gesamtkosten (Personal + Material + Extern). Summieren Sie dann alle Kosten.


| Arbeitspaket          | Personal-Kosten | Material | Extern | Gesamt   |
| --------------------- | --------------- | -------- | ------ | -------- |
| Anforderungsanalyse   | [12 × 8 × 90] = | 800      | 0      |          |
| UI/UX-Design          | [18 × 8 × 95] = | 2.000    | 3.000  |          |
| Backend-Entwicklung   | [40 × 8 × 85] = | 1.500    | 5.000  |          |
| Frontend-Entwicklung  | [35 × 8 × 80] = | 1.200    | 0      |          |
| Datenbank-Setup       | [8 × 8 × 95] =  | 500      | 2.000  |          |
| Testing & QA          | [20 × 8 × 75] = | 1.000    | 0      |          |
| Deployment & Schulung | [10 × 8 × 85] = | 0        | 4.000  |          |
| SUMME                 |                 |          |        | ________ |
|                       |                 |          |        |          |


**Ergebnis Bottom-Up (Zwischensumme):** ________ EUR

**Zusätzliche Overhead-Kosten:**
- PM-Koordination (5% der Zwischensumme): ________ EUR
- Stakeholder-Management (2% der Zwischensumme): ________ EUR
- Integrationstests (pauschal geschätzt): 1.320 EUR
- Performance-Tests (pauschal geschätzt): 1.500 EUR
- **Overhead gesamt:** ________ EUR

**Gesamte Direktkosten (für Budgetplanung):** ________ EUR

#### 1.3 Drei-Punkt-Schätzung (PERT)

Aufgrund der Unsicherheit bei der neuen Technologie werden Drei-Punkt-Schätzungen für die kritischsten Arbeitspakete durchgeführt:

**Backend-Entwicklung:**
- Optimistisch (O): 35.000 EUR (alles läuft glatt)
- Wahrscheinlich (M): 45.000 EUR (realistische Annahme)
- Pessimistisch (P): 65.000 EUR (viele technische Probleme)

**Aufgabe:**
Berechnen Sie die PERT-Schätzung und die Standardabweichung.

$$\text{Erwartungswert} = \frac{O + 4M + P}{6}$$

$$\text{Standardabweichung} = \frac{P - O}{6}$$

```
Erwartungswert = (35.000 + 4 × 45.000 + 65.000) / 6 = ________ EUR

Standardabweichung = (65.000 - 35.000) / 6 = ________ EUR

Konfidenzintervall (68%):  
[Erwartungswert ± 1 σ] = [________, ________] EUR
```

### Lösungshinweise

- **Top-Down:** Multiplikative Anpassung nacheinander anwenden
- **Bottom-Up:** Personal-Kosten = Arbeitstage × 8 h/Tag × Stundensatz
- **Overhead:** Prozentsätze auf die Zwischensumme anwenden
- **PERT:** Standardformel anwenden; Konfidenzintervall für Risikoanalyse nutzen

---

## Aufgabe 2: Budgetstruktur und -kontrolle

### Aufgabenstellung

Die Bottom-Up-Kostenestimation aus Aufgabe 1.2 ergibt eine Summe von **ca. 128.900 EUR** (inklusive Overhead). Nun muss das Projekt-Budget genehmigt und strukturiert werden.

### 2.1 Kontingentbudget festlegen

**Aufgabe:**
- Addieren Sie ein **Projektpuffer** von 8% (für unvorhergesehene Ereignisse innerhalb des geplanten Scopes)
- Addieren Sie zusätzlich eine **Managementreserve** von 7% (für strategische Risiken, nicht detailliert geplant)

```
Direktkosten (aus Bottom-Up):        128.900 EUR
+ Projektpuffer (8%):                ________ EUR
= Subtotal (mit Projektpuffer):      ________ EUR

+ Managementreserve (7%):            ________ EUR
= Gesamtbudget (BAC):               ________ EUR
```

### 2.2 Hierarchische Budgetstruktur

Entwickeln Sie eine **Budgetstruktur**, die der WBS entspricht. Nutzen Sie folgende Struktur als Vorlage und füllen Sie die Beträge ein:

```
CRM-App Projekt – Gesamtbudget: ________ EUR

├─ 1. Projekt-Management (ca. 8.250 EUR)
│  ├─ 1.1 PM-Koordination (5% der direkten Projektkosten)
│  └─ 1.2 Stakeholder-Management (2% der direkten Projektkosten)
│
├─ 2. Analyse & Design (ca. 28.100 EUR)
│  ├─ 2.1 Anforderungsanalyse
│  └─ 2.2 UI/UX-Design
│
├─ 3. Entwicklung (ca. 67.500 EUR)
│  ├─ 3.1 Backend-Entwicklung
│  ├─ 3.2 Frontend-Entwicklung
│  ├─ 3.3 Datenbank-Setup
│  └─ 3.4 Integrationstests (pauschal 1.320 EUR)
│
├─ 4. Testing & QA (ca. 14.500 EUR)
│  ├─ 4.1 Funktionaltests
│  └─ 4.2 Performance-Tests (pauschal 1.500 EUR)
│
├─ 5. Deployment & Schulung (ca. 10.800 EUR)
│  ├─ 5.1 Produktivgang
│  └─ 5.2 Schulung & Dokumentation
│
└─ 6. Puffer (Reserve) (ca. 20.050 EUR)
   ├─ 6.1 Projektpuffer (8%)
   └─ 6.2 Managementreserve (7%)
```

**Aufgabe:** Füllen Sie diese Struktur mit den genauen Kostenangaben (aus den Arbeitspaketkosten und Zuschlägen).

### 2.3 Budget-Freeze und Change-Request-Prozess

Beschreiben Sie in wenigen Sätzen:
1. **Wann wird das Budget „eingefroren"** (Baseline)?
2. **Wie wird mit Kostenänderungen umgegangen?** (Welcher Prozess?)
3. **Wer entscheidet über Kostenänderungen > 5%?**

```
1. Budget-Freeze:
___________________________________________________________________

2. Change-Request-Prozess:
___________________________________________________________________

3. Eskalationspfad:
___________________________________________________________________
```

---

## Aufgabe 3: Earned-Value-Analyse Schritt für Schritt (40 Min)

### Hintergrund

Das CRM-App-Projekt ist jetzt 2 Monate (10 Wochen) alt. Sie möchten einen **EVA-Statusbericht** erstellen. Hier sind die aktuellen Daten zum Stichtag 31.10.2025:

| Arbeitspaket | Budget (BAC) | Geplanter Abschluss % | Aktueller Fertigstellungsgrad % | Tatsächliche Ausgaben |
|---|---|---|---|---|
| Anforderungsanalyse | 9.440 EUR | 100% | 100% | 9.600 EUR |
| UI/UX-Design | 18.680 EUR | 80% | 60% | 13.200 EUR |
| Backend-Entwicklung | 33.700 EUR | 40% | 30% | 12.800 EUR |
| Frontend-Entwicklung | 23.600 EUR | 20% | 15% | 4.500 EUR |
| Datenbank-Setup | 8.580 EUR | 30% | 20% | 2.100 EUR |
| Testing & QA | 13.000 EUR | 0% | 0% | 0 EUR |
| Deployment & Schulung | 10.800 EUR | 0% | 0% | 0 EUR |
| PM-Koordination | 5.890 EUR | 50% | 40% | 3.000 EUR |
| Stakeholder-Management | 2.360 EUR | 50% | 45% | 1.200 EUR |
| Integrationstests | 1.320 EUR | 0% | 0% | 0 EUR |
| Performance-Tests | 1.500 EUR | 0% | 0% | 0 EUR |

**Gesamtbudget (BAC): 128.870 EUR** (Direktkosten ohne Puffer/Reserve)

### 3.1 Berechnung der EVA-Indikatoren

**Definitionen (Erinnerung):**
- **PV (Planned Value):** ∑(BAC × geplanter Fertigstellungsgrad)
- **EV (Earned Value):** ∑(BAC × aktueller Fertigstellungsgrad)
- **AC (Actual Cost):** ∑(tatsächlich ausgegeben)

**Aufgabe:**

Berechnen Sie für jeden Zeilen-Eintrag:
1. **PV** = BAC × Geplanter Abschluss %
2. **EV** = BAC × Aktueller Fertigstellungsgrad %
3. **AC** = (gegeben)

Nutzen Sie nachfolgende Tabelle:

| Arbeitspaket | BAC | Geplant % | PV | Aktuell % | EV | AC |
|---|---|---|---|---|---|---|
| Anforderungsanalyse | 9.440 | 100% | ? | 100% | ? | 9.600 |
| UI/UX-Design | 18.680 | 80% | ? | 60% | ? | 13.200 |
| Backend-Entwicklung | 33.700 | 40% | ? | 30% | ? | 12.800 |
| Frontend-Entwicklung | 23.600 | 20% | ? | 15% | ? | 4.500 |
| Datenbank-Setup | 8.580 | 30% | ? | 20% | ? | 2.100 |
| Testing & QA | 13.000 | 0% | ? | 0% | ? | 0 |
| Deployment & Schulung | 10.800 | 0% | ? | 0% | ? | 0 |
| PM-Koordination | 5.890 | 50% | ? | 40% | ? | 3.000 |
| Stakeholder-Mgmt | 2.360 | 50% | ? | 45% | ? | 1.200 |
| Integrationstests | 1.320 | 0% | ? | 0% | ? | 0 |
| Performance-Tests | 1.500 | 0% | ? | 0% | ? | 0 |
| **SUMME** | **128.870** | | **? (PV)** | | **? (EV)** | **? (AC)** |

### 3.2 Berechnung der EVA-Indikatoren

Nutzen Sie die Summen aus 3.1 und berechnen Sie:

**1. Cost Variance (CV)**
$$CV = EV - AC$$

**2. Cost Performance Index (CPI)**
$$CPI = \frac{EV}{AC}$$

**3. Schedule Variance (SV)**
$$SV = EV - PV$$

**4. Schedule Performance Index (SPI)**
$$SPI = \frac{EV}{PV}$$

```
Gesamtes PV (geplant): ________ EUR
Gesamtes EV (verdient): ________ EUR
Gesamtes AC (ausgegeben): ________ EUR

Cost Variance (CV) = EV - AC = ________ EUR
→ Interpretation: 
   [Über/Unter Budget; um wie viel prozentual?]
___________________________________________________________________

Cost Performance Index (CPI) = EV / AC = ________
→ Interpretation:
   [Kosteneffizienz: Wie viel EUR verdient pro EUR ausgegeben?]
___________________________________________________________________

Schedule Variance (SV) = EV - PV = ________ EUR
→ Interpretation:
   [Zeitlich im Plan / vor / hinter?]
___________________________________________________________________

Schedule Performance Index (SPI) = EV / PV = ________
→ Interpretation:
   [Zeitliche Effizienz: wie schnell laufen wir im Vergleich zum Plan?]
___________________________________________________________________
```

### 3.3 Kostenprognose (EAC und EAC-Szenarios)

**Szenario 1: Fehler ist systematisch (wird sich wiederholen)**

Annahme: Die niedrige CPI wird sich bis zum Projektende fortsetzen.

$$\text{EAC}_1 = \frac{\text{BAC}}{\text{CPI}}$$

**Szenario 2: Der Fehler war einmalig**

Annahme: Ab jetzt wird das Projekt wieder effizienter laufen.

$$\text{EAC}_2 = AC + (BAC - EV)$$

**Aufgabe:**

```
Szenario 1 (systematischer Fehler):
EAC₁ = BAC / CPI = ________ / ________ = ________ EUR

Szenario 2 (Fehler war einmalig):
EAC₂ = AC + (BAC - EV) = ________ + (________ - ________) = ________ EUR

Estimate to Complete (ETC):
ETC = EAC - AC = ________ - ________ = ________ EUR
(Wie viel Geld bleibt für den Rest des Projekts?)

Variance at Completion (VAC):
VAC = BAC - EAC = ________ - ________ = ________ EUR
(Erwartete Gesamtabweichung)
```

### 3.4 Trendanalyse und Maßnahmen

**Aufgabe:**

Analysieren Sie die folgenden Trenddaten (monatlich) und beschreiben Sie, wie sich die Situation entwickelt:

| Monat | PV | EV | AC | CPI | SPI |
|---|---|---|---|---|---|
| Sept. | 35.000 | 33.500 | 31.200 | 1,07 | 0,96 |
| Okt. | 51.000 | 40.300 | 46.400 | 0,87 | 0,79 |
| Nov. (Prognose) | 75.000 | ? | ? | ? | ? |

**Fragen:**
1. Wie entwickelt sich die Kosteneffizienz (CPI)? Wird das Projekt besser oder schlechter?
2. Welche Maßnahmen würden Sie empfehlen?

```
Trend-Analyse:
___________________________________________________________________
___________________________________________________________________

Empfehlung:
___________________________________________________________________
___________________________________________________________________
```

---

## Aufgabe 4: EVA-Szenarien und Was-wäre-wenn-Analysen (25 Min)

### Szenario: Probleme im Backend

Während des Treffens mit dem Entwicklungsteam wird klar, dass die **Backend-Entwicklung länger dauert als geplant**. Das Team hatte mit Performanceproblemen zu kämpfen, die sie unterschätzt haben.

**Neue Schätzung für Backend:**
- Ursprünglich geplant: 40 Arbeitstage à 85 EUR = 27.200 EUR (Personal) + 1.500 EUR Material + 5.000 EUR Extern = **33.700 EUR**
- **Neue Schätzung:** 55 Arbeitstage à 85 EUR = 37.400 EUR + 1.500 + 5.000 = **43.900 EUR** (+ 30% Mehrkosten)

### Aufgaben

**4.1: Auswirkung auf die Gesamtkostenprognose**

```
Ursprüngliche EAC (aus 3.3):        ________ EUR
Zusatzkosten Backend:               +43.900 - 33.700 = +10.200 EUR
= Neue EAC:                         ________ EUR
= Gesamte Kostenabweichung (VAC):   ________ EUR
```

**4.2: Change-Request-Prozess (YouTrack)**

Beschreiben Sie, wie Sie diesen Mehraufwand **in YouTrack dokumentieren** würden:

```
1. Issue-Typ: Change Request / Task
   Titel: [Ihr Vorschlag]
   ___________________________________________________________________

2. Impact-Analyse:
   - Auswirkung auf Budget: ________ EUR
   - Auswirkung auf Zeitplan: ________ Tage
   - Auswirkung auf Risiko: [niedrig/mittel/hoch]
   - Stakeholder-Impact: [Beschreibung]
   ___________________________________________________________________

3. Entscheidung: [Genehmigt / Abgelehnt / Überarbeitung]
   Begründung:
   ___________________________________________________________________
```

---

## Aufgabe 5: Dashboard-Erstellung und Visualisierung (20 Min)

### Hintergrund

Sie müssen für die nächste Lenkungsausschusssitzung einen **EVA-Status-Report** präsentieren.

### Aufgabe

Erstellen Sie einen **Bericht** in folgender Struktur:

```markdown
# EVA-Statusbericht CRM-App Projekt
Berichtsdatum: 31.10.2025 (Ende Woche 10)

## Executive Summary
[1-2 Sätze zum aktuellen Status: Ist das Projekt über/unter Budget und zeitlich im Plan?]

## Metriken-Übersicht

| Metrik | Wert | Status |
|--------|------|--------|
| PV (geplant) | ? | |
| EV (verdient) | ? | |
| AC (ausgegeben) | ? | |
| CPI | ? | [Status: Grün/Gelb/Rot] |
| SPI | ? | [Status: Grün/Gelb/Rot] |
| EAC (Prognose) | ? | |
| VAC (Abweichung) | ? | |

## Trend-Grafik (Text-Darstellung)

Entwicklung der Effizienz-Indizes über Zeit:

CPI-Trend (Kosteneffizienz):
Sept:  [████████████] 1,07  ← Effizient
Okt:   [████████    ] 0,87  ← Schwach
Nov:   [██████      ] ? (erwartend)

SPI-Trend (Zeitliche Effizienz):
Sept:  [████████████] 0,96  ← Fast pünktlich
Okt:   [███████     ] 0,79  ← Verzögert
Nov:   [███████     ] ? (erwartet)

## Probleme & Risiken

1. **Kostenüberschuss:** Projekt läuft über Budget
   - Grund: Backend-Komplexität unterschätzt
   - Maßnahmen: [Ihre Empfehlung]

2. **Zeitverzug:** Projekt läuft zeitlich hinter Plan
   - Grund: [Analyse aus Daten]
   - Maßnahmen: [Ihre Empfehlung]

## Empfehlungen

[Kurze, prägnante Empfehlungen für Lenkungsausschuss]
```

### Bewertungskriterien

- ✅ Alle EVA-Indikatoren korrekt berechnet
- ✅ Klare Interpretation der Zahlen (nicht nur Zahlen, sondern „Was bedeutet das?")
- ✅ Konkrete Handlungsempfehlungen
- ✅ Professionelle Formatierung und Lesbarkeit

---

## Aufgabe 6: YouTrack-Praktikum (30 Min)

### Ziel

Sie lernen, **YouTrack** für die Kostenplanung und -kontrolle zu konfigurieren.

### Schritt 1: Projekt-Setup

1. Öffnen Sie YouTrack (kostenlos unter www.jetbrains.com/youtrack)
2. Erstellen Sie ein neues Projekt: `CRM-APP`
3. Definieren Sie folgende **Custom Fields**:
   - `Budget_EUR` (Typ: Dezimal)
   - `Aktuell_EUR` (Typ: Dezimal)
   - `Fertigstellung_%` (Typ: Integer, 0–100)

### Schritt 2: Arbeitspakete als Issues erfassen

Erstellen Sie für jedes Arbeitspaket einen **Issue**:

```
Issue 1: Anforderungsanalyse
- Type: Task
- Budget_EUR: 9.440
- Fertigstellung: 100%
- Status: Done
- Assignee: [Ihr Name oder Placeholder]
```

Wiederholen Sie dies für alle 11 Arbeitspakete.

### Schritt 3: Automatische EVA-Berechnung

Erstellen Sie im YouTrack-Dashboard ein **Custom Report**, das automatisch berechnet:

```
EVA-Indikatoren:
- Gesamt PV = ∑(Budget × Fertigstellung% geplant)
- Gesamt EV = ∑(Budget × Fertigstellung% aktuell)
- Gesamt AC = ∑(Aktuell_EUR)
```

(Hinweis: Die genaue Implementierung hängt vom YouTrack-Plan ab; ggf. nutzen Sie ein Excel-Export oder API-Integration)

### Schritt 4: Dokumentation

Machen Sie einen **Screenshot** Ihres YouTrack-Projekt-Dashboards und dokumentieren Sie:
- Wie haben Sie die Issues strukturiert?
- Welche Custom Fields haben Sie definiert?
- Welche Workflows wurden eingerichtet?

---

## Checkliste zur Selbstkontrolle

Nach Bearbeitung aller Aufgaben sollten Sie folgende Punkte abhaken können:

### Kostenestimation
- [ ] Ich kann die Formel für Top-Down-Schätzung anwenden
- [ ] Ich kann Bottom-Up-Schätzungen aus einem WBS ableiten
- [ ] Ich verstehe die PERT-Methode und kann Erwartungswert + Standardabweichung berechnen
- [ ] Ich kann die drei Methoden bewerten und weiß, wann welche sinnvoll ist

### Budgetierung
- [ ] Ich kann eine hierarchische Budgetstruktur entwickeln
- [ ] Ich verstehe die Rolle von Kontingent- und Managementreserve
- [ ] Ich kenne den Change-Request-Prozess für Kostenänderungen
- [ ] Ich kann ein Budget freigeben und eine Baseline setzen

### Earned-Value-Analyse
- [ ] Ich kann PV, EV, AC berechnen und erklären
- [ ] Ich kann CV und CPI berechnen und interpretieren
- [ ] Ich kann SV und SPI berechnen und interpretieren
- [ ] Ich kann EAC in mindestens zwei Szenarien berechnen
- [ ] Ich verstehe, was die EVA-Indikatoren über die Projektgesundheit aussagen

### Trendanalyse & Kostensteuerung
- [ ] Ich kann CPI/SPI-Trends erkennen und bewerten
- [ ] Ich kann Ursachenanalysen für Kostenabweichungen durchführen
- [ ] Ich weiß, wann ich eskalieren muss (> 5–10% Abweichung)
- [ ] Ich kann konkrete Korrekturmaßnahmen empfehlen

### YouTrack-Integration
- [ ] Ich habe ein YouTrack-Projekt aufgesetzt
- [ ] Ich kann Arbeitspakete als Issues mit Budget-Feldern erfassen
- [ ] Ich kann automatisierte Reports für EVA-Tracking konfigurieren

---

## Persönliche Notizen und Reflexion

### Fragen zur Selbstreflexion

1. **Was war die größte Erkenntnis für Sie in diesem Modul?**
   
   ___________________________________________________________________
   
   ___________________________________________________________________

2. **Bei welcher Methode (Top-Down, Bottom-Up, PERT) fühlen Sie sich noch unsicher?**
   
   ___________________________________________________________________
   
   ___________________________________________________________________

3. **In Ihren aktuellen Projekten: Wird EVA bereits genutzt? Wenn nein, warum nicht?**
   
   ___________________________________________________________________
   
   ___________________________________________________________________

4. **Wie werden Sie die EVA-Methode in Ihrem nächsten Projekt einführen?**
   
   ___________________________________________________________________
   
   ___________________________________________________________________

---

## Zusammenfassung der Aufgaben

| Aufgabe | Thema | Dauer | Format |
|---------|-------|-------|--------|
| 1 | Kostenestimation (3 Methoden) | 20 Min | Berechnung |
| 2 | Budgetstruktur & -kontrolle | 25 Min | Struktur + Prozess |
| 3 | EVA-Analyse (PV/EV/AC, Indikatoren, Prognose) | 40 Min | Berechnung + Interpretation |
| 4 | Change-Request & Szenarien | 25 Min | Dokumentation + Analyse |
| 5 | Dashboard-Report | 20 Min | Bericht |
| 6 | YouTrack-Setup | 30 Min | Praktische Übung |
| **Gesamt** | | **160 Min** | **Gemischte Formate** |
