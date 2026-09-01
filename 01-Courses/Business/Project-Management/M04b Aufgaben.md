## Übersicht

Dieses Dokument enthält praxisorientierte Aufgaben zur Vertiefung der Business-Case-Erstellung, Kostenrechnung und Rentabilitätsberechnung. Die Aufgaben können in Gruppen oder einzeln bearbeitet werden und beziehen sich auf fiktive wie auch realistische Projektszenarien.

---

## Aufgabe 1: Kostenestimation – Top-Down vs. Bottom-Up

**Szenario:**
Ein Technologieunternehmen plant die **Einführung eines neuen CRM-Systems (Customer Relationship Management)**. Das verfügbare Gesamtbudget beträgt 500.000 EUR. Das Projekt wird auf 12 Monate geschätzt.

### 1a) Top-Down-Schätzung

Verteilen Sie das Gesamtbudget von 500.000 EUR auf folgende Kostengruppen nach prozentualem Anteil:

| Kostengruppe | Anteil (%) | Betrag (EUR) |
|--------------|-----------|--------------|
| Softwarelizenz und Implementierung | 40% | ___ |
| Personalkosten (interne Teams) | 35% | ___ |
| Hardware und Infrastruktur | 10% | ___ |
| Schulung und Change Management | 10% | ___ |
| Unvorhergesehenes (Reserve) | 5% | ___ |
| **Gesamtbudget** | **100%** | **500.000** |

**Aufgabe:** Berechnen Sie die Einzelbeträge für jede Kostengruppe.

### 1b) Bottom-Up-Schätzung

Ermitteln Sie die Kosten durch Detailplanung:

| Position | Einheit | Menge | EUR/Einheit | Gesamtkosten |
|----------|---------|--------|-------------|--------------|
| Softwarelizenz (3 Jahre) | Lizenz | 1 | 120.000 | ___ |
| Implementierungsberatung (50 Tage) | Tage | 50 | 1.200 | ___ |
| Projektmanagement (12 Monate) | PM (50% FTE) | 12 | 6.000 | ___ |
| Systemadministrator (6 Monate full-time) | Monate | 6 | 8.000 | ___ |
| Hardware (20 Workstations) | Workstations | 20 | 2.500 | ___ |
| Schulung (2 Trainer, 5 Tage) | Trainer-Tage | 10 | 1.500 | ___ |
| **Summe Direkte Kosten** | | | | ___ |
| Overhead (15% von direkte Kosten) | | | | ___ |
| **Geschätztes Gesamtbudget** | | | | ___ |

**Aufgabe:** Berechnen Sie die Gesamtkosten Bottom-Up. Vergleichen Sie mit Top-Down-Schätzung (500.000 EUR). Wo liegen mögliche Unterschiede?

### 1c) Reserve und Puffer

Fügen Sie zu Ihrer Bottom-Up-Gesamtsumme eine **Eventualreserve von 10%** (für erkannte Risiken) und eine **Managemenreserve von 5%** (für unerkannte Unsicherheiten) hinzu.

**Berechnen Sie:**
- Eventualreserve (10% × Gesamtkosten) = EUR ___
- Managemenreserve (5% × Gesamtkosten) = EUR ___
- **Finales Projektbudget** = EUR ___

**Notizen und Anmerkungen:**

---

## Aufgabe 2: ROI und Rentabilitätskennzahlen – Fallstudie Produktionsoptimierung

**Szenario:**
Ein Fertigungsunternehmen investiert in **Automatisierung der Lagerverwaltung**, um Bestandsverwaltung und Logistikkosten zu senken. 

**Gegebene Daten:**
- Initialinvestition: 800.000 EUR (einmalig)
- Nutzungsdauer: 5 Jahre
- Jährliche Kosteneinsparungen ab Jahr 1: 250.000 EUR
- Jährliche Betriebskosten (OPEX) für das System: 30.000 EUR
- Weitere monetäre Vorteile (Qualitätsverbesserungen, Zeitersparnisse) ab Jahr 2: 50.000 EUR pro Jahr
- Diskontrate (Kapitalkosten): 8% p.a.

### 2a) Berechnung des ROI (einfaches Modell, keine Diskontierung)

**Berechnen Sie:**

1. **Gesamter Nutzen über 5 Jahre:**
   - Kosteneinsparungen: 250.000 EUR × 5 Jahre = EUR ___
   - Zusätzliche Vorteile (ab Jahr 2): 50.000 EUR × 4 Jahre = EUR ___
   - Zwischensumme Nutzen = EUR ___

2. **Gesamte Betriebskosten über 5 Jahre:**
   - OPEX: 30.000 EUR × 5 Jahre = EUR ___

3. **Nettonutzen (5 Jahre):**
   - Nettonutzen = Gesamtnutzen – Betriebskosten = EUR ___

4. **ROI-Berechnung:**
   - ROI = (Nettonutzen – Initialinvestition) / Initialinvestition × 100%
   - ROI = (___ – 800.000) / 800.000 × 100% = **___ %**

**Interpretation:** Ist das Projekt rentabel? Begründen Sie.

### 2b) Payback-Period

Berechnen Sie, nach wie vielen Jahren sich die Initialinvestition amortisiert hat.

| Jahr | Jährlicher Nettofluss (EUR) | Kumuliert (EUR) |
|------|---------------------------|-----------------|
| 0 | -800.000 | -800.000 |
| 1 | 220.000 | ___ |
| 2 | 270.000 | ___ |
| 3 | 270.000 | ___ |
| 4 | 270.000 | ___ |
| 5 | 270.000 | ___ |

**Aufgabe:** Bestimmen Sie das Jahr, in dem der kumulierte Cashflow positiv wird (Break-even).

**Payback-Period:** ___ Jahre und ___ Monate

### 2c) Net Present Value (NPV) mit Diskontierung

Diskontieren Sie die Cashflows mit 8% pro Jahr:

| Jahr | Nominaler Cashflow (EUR) | Diskontfaktor [1/(1.08)^t] | Discounted Cashflow (EUR) |
|------|--------------------------|---------------------------|--------------------------|
| 0 | -800.000 | 1,0000 | ___ |
| 1 | 220.000 | ___ | ___ |
| 2 | 270.000 | ___ | ___ |
| 3 | 270.000 | ___ | ___ |
| 4 | 270.000 | ___ | ___ |
| 5 | 270.000 | ___ | ___ |
| | | **NPV = Summe** | **___ EUR** |

**Interpretation:** NPV > 0 = Projekt rentabel? NPV < 0 = Projekt nicht empfohlen?

### 2d) Profitability Index (PI)

$$
\text{PI} = \frac{\text{Gegenwartswert zukünftiger Cashflows (Nutzen)}}{\text{Initialinvestition}}
$$

Berechnen Sie PI anhand der Discounted Cashflows aus 2c):

- Summe discounted Cashflows (Jahre 1–5): EUR ___
- PI = EUR ___ / 800.000 = ___ 

**Interpretation:** PI > 1 bedeutet Rentabilität?

---

## Aufgabe 3: Szenarioanalyse – Best Case, Base Case, Worst Case

**Szenario (Fortsetzung Aufgabe 2):**
Aufgrund von Markt- und Technologierisiken führen Sie eine Szenarioanalyse durch.

### Annahmen für drei Szenarien:

| Annahme | Base Case | Best Case | Worst Case |
|---------|-----------|-----------|-----------|
| Jährliche Kosteneinsparungen | 250.000 EUR | 300.000 EUR | 180.000 EUR |
| Jährliche Zusatzbeneefits (ab Jahr 2) | 50.000 EUR | 80.000 EUR | 20.000 EUR |
| Jährliche OPEX | 30.000 EUR | 25.000 EUR | 50.000 EUR |
| Initialinvestition | 800.000 EUR | 750.000 EUR | 900.000 EUR |

### 3a) Berechnen Sie für alle drei Szenarien:

**Base Case:**
- Nettonutzen über 5 Jahre: EUR ___
- ROI: ___ %
- Payback-Period: ___ Jahre

**Best Case:**
- Nettonutzen über 5 Jahre: EUR ___
- ROI: ___ %
- Payback-Period: ___ Jahre

**Worst Case:**
- Nettonutzen über 5 Jahre: EUR ___
- ROI: ___ %
- Payback-Period: ___ Jahre

### 3b) Sensitivitätsanalyse – Kritische Einflussfaktoren

**Frage:** Welche Annahme hat den größten Einfluss auf den ROI? Durchrechnung:

Halten Sie alle Base-Case-Annahmen, variieren Sie aber einen Parameter um ±20%:

| Parameter | Variation | Auswirkung auf ROI |
|-----------|-----------|-------------------|
| Kosteneinsparungen | +20%: 300.000 EUR | ROI = ___ % |
| Kosteneinsparungen | -20%: 200.000 EUR | ROI = ___ % |
| Initialinvestition | +20%: 960.000 EUR | ROI = ___ % |
| Initialinvestition | -20%: 640.000 EUR | ROI = ___ % |

**Schlussfolgerung:** Welcher Parameter ist kritisch für den Projekterfolg?

---

## Aufgabe 4: Business-Case-Erstellung – Strukturiertes Dokument

**Szenario:**
Sie sind Projektmanager und sollen einen **Business Case für die Einführung einer mobilen App zur Kundenverwaltung** vorbereiten. Das Projekt ist für einen mittelständischen Handel gedacht.

### 4a) Alternativenanalyse – Do Nothing vs. Eigenentwicklung vs. Kauf

Erstellen Sie eine vergleichende Übersicht:

| Kriterium | Do Nothing | Eigenentwicklung | Kauf + Anpassung |
|-----------|-----------|------------------|------------------|
| **Kosten (EUR)** | 0 | 400.000 | 150.000 |
| **Time-to-Market** | – | 18 Monate | 4 Monate |
| **Wartungsaufwand** | niedrig | hoch | mittel |
| **Innovationsfähigkeit** | keine | hoch | mittel |
| **Empfehlung** | ❌ | ? | ? |

**Aufgabe:** Welche Alternative würden Sie empfehlen und warum?

### 4b) Nutzen-Dimensionen qualitativ beschreiben

Identifizieren Sie für das App-Projekt **tangible und intangible Nutzen:**

**Tangible Nutzen (quantifizierbar):**
- Zeitersparnis in Kundenbetreuung: ___ Stunden/Jahr
- Monetärer Wert: EUR ___ pro Jahr
- Weitere Nutzen: ___

**Intangible Nutzen (strategisch wertvoll):**
- Verbesserte Kundentreue / NPS-Steigerung
- Wettbewerbsvorteil durch Mobile-First-Ansatz
- Weitere: ___

### 4c) Executive Summary (kurze Zusammenfassung)

Schreiben Sie eine 10–15-zeilige Executive Summary für ein Business-Case-Dokument:

**Gliederung:**
1. Problem / Ausgangssituation (2–3 Zeilen)
2. Empfehlung (1–2 Zeilen)
3. Key Figures: Investition, ROI, Payback-Period (1–2 Zeilen)
4. Nächste Schritte (1 Zeile)

**Ihr Text:**

---

## Aufgabe 5: YouTrack-Integration – Business-Case-Tracking

**Szenario:**
Sie nutzen YouTrack zur Verfolgung des Business-Case-Erstellungsprozesses. Skizzieren Sie die Struktur:

### 5a) Epic und Issues aufgliedern

**Epic: Business Case for Mobile App**

**Definieren Sie folgende Issues:**

| Issue-ID | Titel | Typ | Verantwortung | Status | Linked To |
|----------|-------|------|--------------|--------|-----------|
| BC-001 | Anforderungsanalyse für Alternatives | Task | Product Owner | ⚪ To Do | – |
| BC-002 | Kostenestimation durchführen | Task | ___ | ⚪ To Do | BC-001 |
| BC-003 | Nutzenanalyse durchführen | Task | ___ | ⚪ To Do | BC-001 |
| BC-004 | ROI & NPV berechnen | Task | ___ | ⚪ To Do | BC-002, BC-003 |
| BC-005 | Stakeholder-Review durchführen | Task | ___ | ⚪ To Do | BC-004 |
| BC-006 | Business Case finalisieren | Task | ___ | ⚪ To Do | BC-005 |

### 5b) Custom Fields in YouTrack definieren

Welche zusätzlichen Custom Fields würden Sie für Business-Case-Tracking einführen?

**Beispiel:**

| Field-Name | Datentyp | Beispielwert |
|-----------|----------|-------------|
| Estimated Investment | Number | 150.000 |
| Expected Annual ROI | Percentage | 45% |
| Payback Period (months) | Number | 18 |
| Approval Status | Enum (Proposed/Approved/Rejected) | Proposed |
| Realization Owner | User | ___ |

**Ihre Ideen für weitere Fields:**
- ___
- ___
- ___

---

## Aufgabe 6: Fehleranalyse – Typische Business-Case-Fehler erkennen

**Szenario:**
Ein Junior-Projektmanager hat folgende Business-Case-Zahlen eingereicht:

**Ausgangsdaten:**
- Investition: 500.000 EUR
- Geschätzte Einsparungen: 500.000 EUR pro Jahr
- ROI-Berechnung: ROI = 500.000 / 500.000 × 100% = **100% pro Jahr**
- Payback-Period: **1 Jahr**
- Nutzen nur im Operating-Geschäft berücksichtigt, initiale Schulungs- und Einführungskosten nicht aufgeführt
- Keine Szenarioanalyse durchgeführt
- Indirekte Kosten (Overhead, Support) ignoriert

### 6a) Fehleridentifikation

Identifizieren Sie die **mindestens 5 Fehler** in der Business-Case-Analyse:

| Fehler | Ursache | Auswirkung | Korrektur |
|--------|--------|-----------|----------|
| ROI zu optimistisch | Einsparungen brutto, nicht netto | Stakeholder unrealistische Erwartungen | ___ |
| ___ | ___ | ___ | ___ |
| ___ | ___ | ___ | ___ |

### 6b) Korrigierte Berechnung

Korrigieren Sie die Berechnung mit folgenden **realistischen Annahmen:**
- Schulungs- und Änderungsmanagement-Kosten: 150.000 EUR
- Jährliche Support- und Wartungskosten (OPEX): 80.000 EUR
- Reale Einsparungen (konservativ): 400.000 EUR pro Jahr (statt 500.000)
- Einsparungen treten zeitverzögert auf: Jahr 1: 200.000 EUR, ab Jahr 2: 400.000 EUR

**Berechnen Sie korrigierten ROI und Payback-Period:**

| Jahr | Einsparungen | OPEX | Nettofluss | Kumuliert |
|------|-------------|------|-----------|-----------|
| 0 | 0 | 0 | -500.000 - 150.000 = -650.000 | -650.000 |
| 1 | 200.000 | 80.000 | ___ | ___ |
| 2 | 400.000 | 80.000 | ___ | ___ |
| 3 | 400.000 | 80.000 | ___ | ___ |
| 4 | 400.000 | 80.000 | ___ | ___ |
| 5 | 400.000 | 80.000 | ___ | ___ |

**Korrigierter ROI (über 5 Jahre):** ___ %
**Korrigierte Payback-Period:** ___ Jahre

---

## Zusammenfassung & Checkliste

Verwenden Sie diese Checkliste zur Qualitätssicherung Ihres Business Case:

- ☐ Problemdarstellung und strategische Relevanz klar dargestellt
- ☐ Ziele SMART definiert
- ☐ Mindestens 2 Alternativen verglichen
- ☐ Kosten Bottom-Up geschätzt und mit Reserve (10–15%) versehen
- ☐ Tangible und Intangible Nutzen erfasst
- ☐ ROI, Payback-Period und NPV berechnet
- ☐ Szenarioanalyse (Base / Best / Worst Case) durchgeführt
- ☐ Kritische Erfolgsfaktoren und Risiken dokumentiert
- ☐ Go/No-Go-Kriterien klar definiert
- ☐ Stakeholder-Reviews durchgeführt
- ☐ Annahmen und Datenquellen transparent dokumentiert
- ☐ YouTrack-Struktur für kontinuierliches Tracking vorgesehen

---

## Notizen für die Bearbeitung

**Platz für persönliche Anmerkungen, offene Fragen und Erkenntnisse:**

---

---
