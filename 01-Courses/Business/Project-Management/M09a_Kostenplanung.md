## Lernziele

Nach Abschluss dieses Moduls können Sie:

- **Kostenestimationstechniken** anwenden und deren Vor- und Nachteile bewerten
- Eine **Budgetstruktur** entwickeln, die Transparenz und Kontrolle ermöglicht
- Die **Earned-Value-Analyse (EVA)** durchführen und Leistungsindikatoren interpretieren
- **Kostentrends** erkennen und realistische Prognosen ableiten
- Typische **Kostenkontrollprozesse** etablieren und dokumentieren
- YouTrack als Werkzeug zur Verfolgung von Aufgaben und Budgetzuweisungen einsetzen

---

## Themenstruktur und Schwerpunkte

### A. Kostenestimation: Grundlagen und Methoden

#### A1. Bedeutung der Kostenestimation im PM

Die Kostenestimation ist eine der frühesten und gleichzeitig kritischsten Aktivitäten im Projektmanagement. Sie bestimmt:
- **Machbarkeit** eines Projekts (wirtschaftlich sinnvoll oder nicht)
- **Investitionsentscheidungen** auf Geschäftsleitungsebene
- **Budgetvorgaben** für die gesamte Projektlaufzeit
- **Risikoabsicherung** durch Puffer und Reserve

**Typische Herausforderungen bei der Kostenestimation:**
- Unvollständige oder sich ändernde Anforderungen (Scope Creep)
- Unsicherheit über Ressourcenverfügbarkeit
- Externe Faktoren (Lieferketten, Rohstoffpreise, Energiekosten)
- Unrealistische Vorgaben vom Management
- Mangelhafte historische Daten

#### A2. Drei Hauptmethoden der Kostenestimation

**1. Top-Down-Schätzung (Analogieschätzung)**

- **Prinzip:** Kostenerfahrung aus ähnlichen abgeschlossenen Projekten auf das aktuelle Projekt übertragen
- **Anwendung:** Frühe Projektphase, verfügbare historische Daten
- **Vorteil:** Schnell, benötigt weniger Detail-Planung
- **Nachteil:** Kann ungenau sein, wenn Projekte nicht wirklich vergleichbar sind
- **Formel (vereinfacht):** 
  - Aktuelle Kosten ≈ Historische Kosten × (Skalierungsfaktor oder Ähnlichkeitsgrad)

**Beispiel:**
- Ähnliches Projekt vor 2 Jahren: 150.000 EUR
- Bereinigung um Inflation (+4%): 156.000 EUR
- Bereinigung um Komplexitätszuschlag (+10%): **171.600 EUR**

**2. Bottom-Up-Schätzung (analytische Schätzung)**

- **Prinzip:** Jede Aktivität/Komponente einzeln schätzen, dann aggregieren
- **Anwendung:** Mittlere bis späte Planungsphase, detailliertes WBS (Projektstrukturplan)
- **Vorteil:** Höhere Genauigkeit, bessere Nachvollziehbarkeit
- **Nachteil:** Zeitaufwändig, erfordert fundierte Expertise
- **Ablauf:**
  1. WBS in Arbeitspakete zerlegen
  2. Für jedes Arbeitspaket Material-, Personal-, und Gerätekosten ermitteln
  3. Alle Einzelkosten summieren
  4. Gemeinkosten und Reserve hinzurechnen

**Beispiel (vereinfacht):**

| Arbeitspaket | Arbeitstage | Stundensatz | Materialkosten | Gesamt |
|---|---|---|---|---|
| Anforderungsanalyse | 20 | 75 EUR | 500 EUR | 2.000 EUR |
| Designphase | 30 | 80 EUR | 1.200 EUR | 3.600 EUR |
| Implementierung | 60 | 70 EUR | 5.000 EUR | 9.200 EUR |
| Testing | 25 | 65 EUR | 2.000 EUR | 3.625 EUR |
| **Summe direkter Kosten** | – | – | – | **18.425 EUR** |

**3. Parametrische Schätzung**

- **Prinzip:** Mathematische Modelle basierend auf Parametern/Metriken nutzen
- **Anwendung:** Für standardisierte, wiederholbare Projekttypen
- **Vorteil:** Objektiv, automatisierbar, gute Skalierbarkeit
- **Nachteil:** Benötigt valide Datengrundlage
- **Formel (allgemein):** 
  - Kosten = Basis-Parameter × Kostenindex × Korrekturfaktoren

**Beispiel (Softwareprojekt):**
- Erfahrungswert: 1.500 EUR pro Function Point (FP)
- Geschätzte Komplexität: 85 FP
- Kosten = 85 × 1.500 EUR = **127.500 EUR**

#### A3. Kombination der Methoden – Drei-Punkt-Schätzung (PERT)

Für unsichere Projekte wird häufig die **Drei-Punkt-Schätzung** verwendet:
- **Optimistische Schätzung (O):** Best-Case-Szenario
- **Wahrscheinlichste Schätzung (M):** Realistische Annahme
- **Pessimistische Schätzung (P):** Worst-Case-Szenario

**PERT-Formel:**
$$\text{Erwartungswert} = \frac{O + 4M + P}{6}$$

**Beispiel:**
- O = 80.000 EUR (alles läuft optimal)
- M = 120.000 EUR (realistische Annahme)
- P = 160.000 EUR (viele Probleme und Verzögerungen)
- Erwartungswert = (80.000 + 4×120.000 + 160.000) / 6 = **120.000 EUR**
- Standardabweichung ≈ (P – O) / 6 ≈ 13.333 EUR

---

### B. Budgetstruktur und Budgetkontrolle

#### B1. Kostenarten im Projekt

**Direkte Kosten:**
- Löhne und Gehälter von Projektmitarbeitern
- Externe Dienstleistungen und Beratung
- Materialien und Rohstoffe
- Spezialgeräte und Software
- **Charakteristikum:** Lassen sich eindeutig dem Projekt zuordnen

**Indirekte Kosten (Gemeinkosten):**
- Gemietete Bürofläche für das Projekt
- Verwaltungs- und Organisationsoverhead
- Energiekosten, Versicherungen
- Allgemeine IT-Infrastruktur
- **Charakteristikum:** Werden über einen Verteilschlüssel dem Projekt zugeordnet (z. B. 15% der direkten Kosten)

**Opportunitätskosten:**
- Entgangener Ertrag durch Ressourcengebundenheit
- Weniger relevant für interne Projekte, aber wichtig bei Entscheidungen

#### B2. Budgetierungsprozess

**Schritt 1: Kostenschätzung verfeinern**
- Für jedes Arbeitspaket des WBS eine realistische Kostenschätzung durchführen
- Mehrere Schätzrunden, Abstimmung mit Experten

**Schritt 2: Budgetstruktur entwickeln**
- Budget hierarchisch aufbauen, parallel zur WBS-Struktur
- Klare Zuordnung: Jedes Arbeitspaket = ein Budgetposten

**Schritt 3: Kontingentbudget festlegen**
- **Projektpuffer (Reserve):** 5–15% der direkten Kosten für unvorhergesehene Ereignisse
- **Managementreserve:** Zusätzliche 5–10% für strategische Risiken (oft nicht detailliert geplant)

**Beispiel einer Budgetstruktur:**

```
Projekt "Website-Redesign" – Gesamtbudget 250.000 EUR

├─ Projekt-Management (25.000 EUR)
│  ├─ PM-Koordination (15.000 EUR)
│  └─ Stakeholder-Management (10.000 EUR)
│
├─ Analyse & Design (50.000 EUR)
│  ├─ Anforderungsanalyse (20.000 EUR)
│  ├─ UX/UI-Design (25.000 EUR)
│  └─ Design-Reviews (5.000 EUR)
│
├─ Entwicklung (120.000 EUR)
│  ├─ Frontend-Entwicklung (60.000 EUR)
│  ├─ Backend-Entwicklung (50.000 EUR)
│  └─ Integrationstests (10.000 EUR)
│
├─ Testing & QA (30.000 EUR)
│  ├─ Funktionaltests (15.000 EUR)
│  ├─ Performance-Tests (8.000 EUR)
│  └─ UAT (User Acceptance Testing) (7.000 EUR)
│
├─ Deployment & Schulung (15.000 EUR)
│  ├─ Produktivgang (8.000 EUR)
│  └─ Schulung & Dokumentation (7.000 EUR)
│
└─ Puffer (Reserve) (10.000 EUR)
```

#### B3. Budgetkontrolle und Freigabeprozess

- **Baseline-Budget:** Nach Genehmigung durch Auftraggeber eingefroren
- **Kostenveränderungen:** Nur durch Change-Request-Prozess möglich
- **Durchsichtige Verfolgung:** Regelmäßige Berichte über Budget-Verbrauch
- **Eskalationspfade:** Bei Budget-Überschreitungen > 10% eskalieren

---

### C. Earned-Value-Analyse (EVA) – Die Kernmethode

#### C1. Konzept und Grundidee

Die Earned-Value-Analyse (Verdientwertanalyse) ist eine Integrationsmethode, die **Umfang (Scope), Zeit und Kosten** kombiniert. Sie beantwortet die kritische Frage:

> **„Wo steht das Projekt WIRKLICH – zeitlich und finanziell?"**

Ohne EVA sehen Sie nur: „Wir haben X Euro ausgegeben und Y% der Zeit verbraucht." Mit EVA sehen Sie: „Wir haben Leistung im Wert von Z Euro erbracht – das ist über/unter Budget und vor/hinter Plan."

#### C2. Die drei Kerngrößen der EVA

**1. Planned Value (PV) – Geplanter Umfang (Budgetierter Kostenbetrag)**
- Was war zum geplanten Stichtag **geplant** zu leisten?
- Kumulativer Kostenrahmen der geplanten Aktivitäten bis zu einem Stichtag
- Wird aus dem Kostenplan und Zeitplan abgeleitet
- **Synonym:** Budgeted Cost of Work Scheduled (BCWS)

**2. Earned Value (EV) – Erbrachte Leistung (Verdientwert)**
- Welche Leistung wurde **tatsächlich** erbracht (gemessen in Kosten)?
- Bewertung der abgeschlossenen Arbeit zu ihren geplanten Budgetkosten
- Beispiel: Ein Arbeitspaket mit Budget 10.000 EUR ist zu 60% abgeschlossen → EV = 6.000 EUR
- **Synonym:** Budgeted Cost of Work Performed (BCWP)
- **Herausforderung:** Objektive Messung des Fertigstellungsgrads

**3. Actual Cost (AC) – Tatsächliche Kosten**
- Was wurde **wirklich** ausgegeben?
- Alle tatsächlich in der Abrechnung erfassten Kosten bis zum Stichtag
- **Synonym:** Actual Cost of Work Performed (ACWP)

#### C3. Visualisierung der EVA-Logik

```
Zeitstrahl:
│
├─ PV (Geplant): „Das SOLLTE bis jetzt erledigt sein"
├─ EV (Verdient): „Das IST tatsächlich erledigt"
└─ AC (Ausgegeben): „Das hat uns GEKOSTET"

Mögliche Szenarien:
─────────────────────────────────────────
PV = 100.000 EUR (geplant)
EV = 90.000 EUR  (erbracht)  → 10.000 EUR HINTER PLAN
AC = 95.000 EUR  (ausgegeben) → 5.000 EUR ÜBER BUDGET

Interpretation:
- Zeitrückstand: 10.000 EUR Leistung nicht erbracht (Verzögerung)
- Kostenüberschuss: 5.000 EUR mehr ausgegeben als für die erbrachte Leistung geplant
```

#### C4. Wichtige Indikatoren aus der EVA

**1. Schedule Variance (SV) – Zeitabweichung**
$$\text{SV} = EV - PV$$
- **Positiv:** Projekt läuft zeitlich VORAUS
- **Negativ:** Projekt läuft zeitlich HINTER PLAN
- **Interpretation:** Zeigt nur relative Verzögerung, keine Tage/Wochen!

**Beispiel:**
- PV = 200.000 EUR, EV = 180.000 EUR
- SV = 180.000 – 200.000 = **–20.000 EUR** → Zeitrückstand

**2. Schedule Performance Index (SPI) – Termineffizienz**
$$\text{SPI} = \frac{EV}{PV}$$
- **> 1,0:** Projekt läuft SCHNELLER als geplant
- **= 1,0:** Projekt verläuft PÜNKTLICH
- **< 1,0:** Projekt läuft LANGSAMER als geplant

**Beispiel:**
- SPI = 180.000 / 200.000 = **0,9** → Projekt 10% langsamer (Effizienz bei 90%)

**3. Cost Variance (CV) – Kostenabweichung**
$$\text{CV} = EV - AC$$
- **Positiv:** Projekt läuft UNTER BUDGET
- **Negativ:** Projekt läuft ÜBER BUDGET
- **Interpretation:** Absolute Kostenabweichung in EUR/Dollar

**Beispiel:**
- EV = 180.000 EUR, AC = 200.000 EUR
- CV = 180.000 – 200.000 = **–20.000 EUR** → Kostenüberschuss

**4. Cost Performance Index (CPI) – Kosteneffizienz**
$$\text{CPI} = \frac{EV}{AC}$$
- **> 1,0:** Projekt ist KOSTENGÜNSTIGER als geplant
- **= 1,0:** Projekt verläuft im Budget
- **< 1,0:** Projekt ist TEURER als geplant

**Beispiel:**
- CPI = 180.000 / 200.000 = **0,9** → 90% Kosteneffizienz, d. h. 10% Überaufwand pro EUR verdient

#### C5. Prognosen und Trendanalyse

**Estimate at Completion (EAC) – Kostenprognose**

Verschiedene Ansätze, je nach Annahmen:

**Szenario 1: Fehler ist systematisch (wird sich wiederholen)**
$$\text{EAC} = \frac{\text{Budget at Completion (BAC)}}{\text{CPI}}$$

**Szenario 2: Fehler war einmalig (wird sich nicht wiederholen)**
$$\text{EAC} = AC + \frac{BAC - EV}{1.0}$$
(vereinfacht: EAC = AC + verbleibender Plan)

**Estimate to Complete (ETC) – Restkosten**
$$\text{ETC} = EAC - AC$$

**Variance at Completion (VAC) – Kostenabweichung am Ende**
$$\text{VAC} = BAC - EAC$$

**Beispiel (fortgesetzt):**
- BAC (Gesamtbudget) = 500.000 EUR
- AC (bereits ausgegeben) = 200.000 EUR
- CPI = 0,9
- EAC = 500.000 / 0,9 = **555.556 EUR**
- ETC = 555.556 – 200.000 = **355.556 EUR** (verbleibend)
- VAC = 500.000 – 555.556 = **–55.556 EUR** (Überschuss erwartet)

**Interpretation:** Das Projekt wird voraussichtlich 55.556 EUR über Budget sein, wenn die aktuelle Kosteneffizienz anhält.

#### C6. EVA Dashboard und Reporting

Ein typisches EVA-Dashboard zeigt:

```
╔════════════════════════════════════════════╗
║  EVA-Zusammenfassung (Stand 31.10.2025)    ║
╠════════════════════════════════════════════╣
║ PV (Geplant)           250.000 EUR         ║
║ EV (Verdient)          220.000 EUR         ║
║ AC (Ausgegeben)        235.000 EUR         ║
║                                            ║
║ Schedule Variance      –30.000 EUR (–12%)  ║
║ SPI                    0,88 (88%)          ║
║ Cost Variance          –15.000 EUR (–7%)   ║
║ CPI                    0,94 (94%)          ║
║                                            ║
║ BAC (Gesamtbudget)     500.000 EUR         ║
║ EAC (Prognose)         532.000 EUR         ║
║ VAC (Abweichung)       –32.000 EUR         ║
╚════════════════════════════════════════════╝
```

---

### D. Kostensteuerung und Integration mit YouTrack

#### D1. Kostensteuerungsprozess

**Schritt 1: Baseline festlegen**
- Genehmigtes Budget und Zeitplan als Referenz einfrieren
- YouTrack: Baseline-Informationen in Projekt-Metadaten speichern

**Schritt 2: Fortschritt wöchentlich/monatlich messen**
- Arbeitspakete als abgeschlossen markieren
- Tatsächliche Kosten erfassen (aus Rechnungen, Timesheets)
- EVA-Indikatoren berechnen

**Schritt 3: Abweichungen analysieren**
- Abweichung > 5% → Ursachenanalyse erforderlich
- Root-Cause-Analyse (Warum ist das Projekt über/unter Budget?)

**Schritt 4: Korrekturmaßnahmen einleiten**
- Change-Requests bei Scope-Änderungen
- Ressourcenoptimierung bei Kostendrift
- Kommunikation an Stakeholder

**Schritt 5: Trend überwachen**
- SPI/CPI-Trends erkannt? Wird es besser oder schlechter?
- Prognosen anpassen und kommunizieren

#### D2. YouTrack Integration für Kostenmanagement

**YouTrack** ist ein modernes Issue- und Projekt-Tracking-System. Es kann für Kostenmanagement wie folgt genutzt werden:

**Aufgabenstruktur:**
- **Issues = Arbeitspakete:** Jedes Arbeitspaket als Issue anlegen
- **Custom Fields für Kosten:**
  - `Budgetiert` (in EUR/Stunden)
  - `Tatsächlich` (aufgezeichnete Zeit/Kosten)
  - `Fertigstellung %` (zur EVA-Berechnung)

**Beispiel-Workflow in YouTrack:**

```yaml
Issue: "Frontend-Komponenten entwickeln"
  Status: In Arbeit
  Assignee: Entwickler Team
  Budget: 12.000 EUR
  Time Spent: 80 h (Stundensatz 75 EUR = 6.000 EUR)
  Completion: 65%
  Earned Value: 12.000 × 0,65 = 7.800 EUR
  
  Comment: "Komplexere Validierungen als erwartet, 
           aber im Plan noch zu schaffen"
```

**Automatisierte Auswertungen:**
- **Board-View:** Alle Aufgaben mit Budget-Status sichtbar
- **Reports:** Burndown-Chart der Kosten
- **Agile Metrics:** Geschwindigkeit und Kostentrends über Sprints

**YouTrack-Features für Budgetierung:**
- **Time-Tracking:** Integrierte Zeiterfassung pro Issue
- **Custom Workflows:** „Freigabe ausstehend" → Kostenabweichung? → Eskalation
- **Notifications:** Benachrichtigung bei Budget-Überschreitung
- **API-Integration:** Daten für externe BI-Tools (Tableau, Power BI)

---

## Wichtige Begriffe und Definitionen

| Begriff | Deutsche Übersetzung | Erklärung |
|---------|---|---|
| Planned Value (PV) | Geplanter Kostenumfang | Budgetiert für die bis zu einem Stichtag geplante Arbeit |
| Earned Value (EV) | Verdientwert | Bewertete Arbeit, die tatsächlich fertiggestellt wurde |
| Actual Cost (AC) | Tatsächliche Kosten | Tatsächlich aus der Tasche gezahlte Kosten bis zum Stichtag |
| Cost Variance (CV) | Kostenabweichung | EV – AC; negativ = über Budget |
| Cost Performance Index (CPI) | Kosteneffizienz-Index | EV/AC; < 1 = ineffizient, > 1 = effizient |
| Schedule Variance (SV) | Zeitabweichung | EV – PV; negativ = zeitlich hinter Plan |
| Budget at Completion (BAC) | Gesamtbudget | Genehmigte Gesamtbudget für das Projekt |
| Estimate at Completion (EAC) | Kostenprognose | Erwartete Gesamtkosten am Projektende |
| Contingency Reserve | Projektpuffer | Reserve für unvorhergesehene Ereignisse innerhalb des Plans |
| Management Reserve | Managementreserve | Reserve für strategische Risiken, außerhalb detaillierter Planung |
| Change Request | Änderungsantrag | Formaler Antrag zur Änderung von Scope, Zeit oder Budget |
| Scope Creep | Umfangsausweitung | Unkontrollierte Erweiterung des Projektumfangs |

---

## Häufige Fehler und Best Practices

### Fehler bei Kostenestimation
- ❌ **Zu optimistische Schätzungen:** Manager drängen auf günstige Zahlen
- ✅ **Lösung:** Unabhängige Schätzung durch erfahrene Experten; PERT-Methode für Unsicherheit
- ❌ **Fehlende Puffer:** Alle Schätzungen sind optimistische „Best Cases"
- ✅ **Lösung:** 5–15% Kontingentbudget + 5–10% Managementreserve einplanen
- ❌ **Keine historischen Daten:** Jedes Mal „von vorne" schätzen
- ✅ **Lösung:** Projektabschluss-Dokumentation mit Lessons Learned speichern

### Fehler bei EVA-Anwendung
- ❌ **Falsche Fertigstellungsgradmessung:** „Ich schätze, es ist zu 50% fertig"
- ✅ **Lösung:** Objektive Kriterien (20-80-Regel: 0% oder 80% bis Abschluss)
- ❌ **Keine regelmäßige EVA-Berechnung:** Erst am Ende des Jahres
- ✅ **Lösung:** Wöchentlich oder monatlich EVA berechnen und berichten
- ❌ **EVA-Zahlen ohne Kontext:** „CPI = 0,92, und nun?"
- ✅ **Lösung:** Ursachen-Analyse und Trend-Monitoring durchführen

---

## Verbindung zu anderen Modulen

- **Modul 5 (WBS):** Kostenstruktur folgt der WBS-Hierarchie
- **Modul 6–7 (Zeitmanagement):** Kosten und Zeit sind durch die EVA eng verflochten
- **Modul 8 (Ressourcenplanung):** Ressourcenkosten sind der Haupttreiber der Projektkosten
- **Modul 15 (Projektsteuerung):** EVA ist die Kernmethode für Soll-Ist-Vergleich
- **Modul 16 (Änderungsmanagement):** Kostenauswirkungen von Changes bewerten

---

## Zusammenfassung der Lernziele (Checkliste)

Am Ende dieses Moduls sollten Sie:

- [ ] Die drei Kostenestimationsmethoden (Top-Down, Bottom-Up, Parametrisch) unterscheiden können
- [ ] Eine PERT-Schätzung mit O, M, P durchführen können
- [ ] Eine hierarchische Budgetstruktur parallel zur WBS aufbauen können
- [ ] PV, EV und AC erklären und voneinander unterscheiden können
- [ ] CV, CPI, SV und SPI berechnen und interpretieren können
- [ ] EAC und ETC prognostizieren können
- [ ] Ein EVA-Dashboard lesen und Maßnahmen ableiten können
- [ ] YouTrack für Zeit- und Kostentracking konfigurieren können
- [ ] Kostenabweichungen analysieren und Trends erkennen können
