# Modul 9: Kostenplanung & Budgetierung – Lösungen mit Kommentaren (KORRIGIERT)

## Aufgabe 1: Kostenestimation – Musterlösung

### 1.1 Top-Down-Schätzung (Lösung)

- Historisches Projekt: 185.000 EUR
- × Inflation (1.045): 185.000 × 1.045 = **193.325 EUR**
- × Komplexitätsfaktor (1.12): 193.325 × 1.12 = **216.524 EUR**
- × Integrationsfaktor (0.92): 216.524 × 0.92 = **199.202 EUR**

**Top-Down-Schätzung:** **199.202 EUR**

---

### 1.2 Bottom-Up-Schätzung (Lösung)

| Arbeitspaket           | Personal               | Material | Extern | Gesamt         |
|------------------------|------------------------|----------|--------|----------------|
| Anforderungsanalyse    | 12×8×90 = 8.640        | 800      | 0      | 9.440          |
| UI/UX-Design           | 18×8×95 = 13.680       | 2.000    | 3.000  | 18.680         |
| Backend-Entwicklung    | 40×8×85 = 27.200       | 1.500    | 5.000  | 33.700         |
| Frontend-Entwicklung   | 35×8×80 = 22.400       | 1.200    | 0      | 23.600         |
| Datenbank-Setup        | 8×8×95 = 6.080         | 500      | 2.000  | 8.580          |
| Testing & QA           | 20×8×75 = 12.000       | 1.000    | 0      | 13.000         |
| Deployment & Schulung  | 10×8×85 = 6.800        | 0        | 4.000  | 10.800         |
|                       |                        |          |        | **117.800**    |

**Zusätzliche Overhead-Kosten:**
- PM-Koordination (5%): 5.890 EUR
- Stakeholder-Management (2%): 2.356 EUR
- Integrationstests: 1.320 EUR
- Performance-Tests: 1.500 EUR
- Overhead gesamt: 11.066 EUR

**Direktkosten gesamt:** 128.866 EUR

---

### 1.3 PERT-Schätzung (Lösung)

- Erwartungswert = (35.000 + 4×45.000 + 65.000) / 6 = (35.000 + 180.000 + 65.000) / 6 = 280.000 / 6 = **46.667 EUR**
- Standardabweichung = (65.000 – 35.000) / 6 = 30.000 / 6 = **5.000 EUR**
- Konfidenzintervall (68%): [46.667 ± 5.000] = **[41.667 – 51.667] EUR**

---

## Aufgabe 2: Budgetstruktur und Kontrolle (Lösung)

### 2.1 Kontingentbudget

- Direktkosten:     128.866 EUR
- + Projektpuffer (8%):        10.309 EUR
- = Subtotal:      139.175 EUR
- + Managementreserve (7%):    9.743 EUR
- = Gesamtbudget (BAC): **148.918 EUR**

---

### 2.2 Hierarchische Budgetstruktur (Musterwerte)

CRM-App Projekt – Gesamtbudget: **148.918 EUR**

├─ 1. Projekt-Management (Gesamt: 8.246 EUR)
│  ├─ 1.1 PM-Koordination: 5.890 EUR (5%)
│  └─ 1.2 Stakeholder-Management: 2.356 EUR (2%)
│
├─ 2. Analyse & Design (28.120 EUR)
│  ├─ 2.1 Anforderungsanalyse: 9.440 EUR
│  └─ 2.2 UI/UX-Design: 18.680 EUR
│
├─ 3. Entwicklung (65.880 EUR)
│  ├─ 3.1 Backend-Entwicklung: 33.700 EUR
│  ├─ 3.2 Frontend-Entwicklung: 23.600 EUR
│  ├─ 3.3 Datenbank-Setup: 8.580 EUR
│  └─ 3.4 Integrationstests: 1.320 EUR
│
├─ 4. Testing & QA (14.500 EUR)
│  ├─ 4.1 Funktionaltests: 13.000 EUR
│  └─ 4.2 Performance-Tests: 1.500 EUR
│
├─ 5. Deployment & Schulung (10.800 EUR)
│  ├─ 5.1 Produktivgang
│  └─ 5.2 Schulung & Doku
│
└─ 6. Puffer (Reserve) (Gesamt: 20.052 EUR)
   ├─ 6.1 Projektpuffer: 10.309 EUR
   └─ 6.2 Managementreserve: 9.743 EUR

---

### 2.3 Prozessbeschreibung

1. **Budget-Freeze:**
   Das Budget wird nach Abschluss der detaillierten Kostenplanung und Freigabe im Steuerkreis „eingefroren".
2. **Change-Request-Prozess:**
   Jede Kostenänderung > 5% initiiert einen Change-Request. Dieser wird in YouTrack dokumentiert und dem Steuerkreis vorgelegt.
3. **Eskalation:**
   Übernimmt das Steering Committee bzw. die Geschäftsleitung.

---

## Aufgabe 3: EVA – Rechenweg und Interpretation

### 3.1 EVA-Rechnung

| AP                    | BAC     | PV        | EV        | AC       |
|-----------------------|---------|-----------|-----------|----------|
| Anforderungsanalyse   | 9.440   | 9.440     | 9.440     | 9.600    |
| UI/UX-Design          | 18.680  | 14.944    | 11.208    | 13.200   |
| Backend-Entwicklung   | 33.700  | 13.480    | 10.110    | 12.800   |
| Frontend-Entwicklung  | 23.600  | 4.720     | 3.540     | 4.500    |
| Datenbank-Setup       | 8.580   | 2.574     | 1.716     | 2.100    |
| Testing & QA          | 13.000  | 0         | 0         | 0        |
| Deployment & Schulung | 10.800  | 0         | 0         | 0        |
| PM-Koordination       | 5.890   | 2.945     | 2.356     | 3.000    |
| Stakeholder-Mgmt      | 2.356   | 1.178     | 1.060     | 1.200    |
| Integrationstests     | 1.320   | 0         | 0         | 0        |
| Performance-Tests     | 1.500   | 0         | 0         | 0        |
| **SUMME**             |128.866  |54.281     |39.430     |46.400    |

---

### 3.2 EVA-Indikatoren

- PV = **54.281 EUR**
- EV = **39.430 EUR**
- AC = **46.400 EUR**
- Cost Variance (CV): 39.430 – 46.400 = **–6.970 EUR**
- CPI: 39.430 / 46.400 = **0,85**
- Schedule Variance (SV): 39.430 – 54.281 = **–14.851 EUR**
- SPI: 39.430 / 54.281 = **0,73**

Interpretation:
- CV negativ: Projekt über Budget.
- CPI < 1: schlechte Kosteneffizienz.
- SV negativ: Projekt zeitlich hinter Plan.
- SPI < 1: Zeitlich langsam.

---

### 3.3 EAC & Prognose (zwei Szenarien)

- Szenario 1: Fehler systematisch: EAC = BAC / CPI = 128.866 / 0,85 = **151.607 EUR**
- Szenario 2: Fehler einmalig: EAC = AC + (BAC – EV) = 46.400 + (128.866 – 39.430) = 46.400 + 89.436 = **135.836 EUR**
- ETC = EAC – AC = 151.607 – 46.400 = **105.207 EUR**
- VAC = BAC – EAC = 128.866 – 151.607 = **–22.741 EUR**

---

### 3.4 Trendanalyse & Maßnahmen (Musterlösung)

- CPI fällt von 1,07 (Sept) auf 0,85 (Okt.) → deutlicher Verlust an Kosteneffizienz
- SPI sinkt von 0,96 (Sept.) auf 0,73 (Okt.) → starker Zeitverzug

Empfehlung:
- Ursachenanalysen durchführen
- Personal- und Zeitressourcen nachsteuern
- Stärkere Kommunikation mit Stakeholdern
- Regelmäßige EVA-Trendanalyse

---

## Aufgabe 4: EVA-Szenarien und Change-Request (Lösung)

### 4.1 Kostenprognose

- Ursprüngliche EAC (aus 3.3): 151.607 EUR
- Neue Backend-Kosten: +43.900 – 33.700 = +10.200 EUR → **EAC = 161.807 EUR**
- Neue VAC: BAC – EAC = 128.866 – 161.807 = **–32.941 EUR**

### 4.2 Change-Request in YouTrack

Typ: Change Request
Titel: „Mehraufwand Backend-Entwicklung durch Performanceprobleme“
Impact-Analyse:
- Auswirkung Budget: +10.200 EUR
- Zeitverzug: +12 Arbeitstage
- Risiko: mittel
- Stakeholder: spätere Markteinführung
Entscheidung: Genehmigt nach Abstimmung mit Auftraggeber

---

## Aufgabe 5: Dashboard & EVA-Bericht (Muster)

# EVA-Statusbericht CRM-App Projekt
Berichtsdatum: 31.10.2025

## Executive Summary
Das Projekt liegt sowohl kosten- als auch zeitmäßig hinter Plan. Hauptursache sind ungeplante technische Probleme im Backend.

## Metriken-Übersicht

| Metrik | Wert | Status |
|--------|------|--------|
| PV     | 54.281 EUR | – |
| EV     | 39.430 EUR | – |
| AC     | 46.400 EUR | – |
| CPI    | 0,85       | Rot |
| SPI    | 0,73       | Rot |
| EAC    | 151.607 EUR | – |
| VAC    | –22.741 EUR | Rot |

## Trend-Grafik

CPI-Trend:
Sept: [████████████] 1,07 (grün)
Okt:  [██████      ] 0,85 (rot)
SPI-Trend:
Sept: [███████████ ] 0,96 (gelb)
Okt:  [█████       ] 0,73 (rot)

## Probleme & Risiken
- **Kostenüberschuss:** Backend-Aufwand höher als geplant
- **Zeitverzug:** Fertigstellung verschoben

## Empfehlungen
- Ursachenanalyse
- Ressourcen nachsteuern
- Trendsteuerung intensivieren

---

## Aufgabe 6: YouTrack-Einbindung (Musterlösung)

- Arbeitspakete als Issues
- Custom Fields: Budget_EUR, Aktuell_EUR, Fertigstellung_%
- Bericht: EVA-Indikatoren automatisch berechnet

---

## Checkliste (Lösung)
- Berechnungen stimmen mit Aufgaben überein
- Werte sind im gesamten Modul konsistent
- Darstellung ist für Einsteiger verständlich