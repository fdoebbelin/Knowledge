## Lösung Aufgabe 1: Soll-Ist-Vergleich durchführen

### Aufgabenstellung (Wiederholung)
Website-Redesign-Projekt mit Soll-Ist-Vergleich durchführen.

### Lösung

**Berechnungen pro Aktivität:**

#### 1. Design-Phase
- **Zeitabweichung (absolut):** 2,5 Wochen – 2 Wochen = +0,5 Wochen = +3,5 Tage (bei 7 Tagen/Woche)
- **Zeitabweichung (%):** (2,5 – 2) / 2 × 100 = 0,5 / 2 × 100 = **+25 %** ➜ **KRITISCH**
- **Kostenabweichung (absolut):** € 12.500 – € 10.000 = **+€ 2.500**
- **Kostenabweichung (%):** (12.500 – 10.000) / 10.000 × 100 = 2.500 / 10.000 × 100 = **+25 %** ➜ **KRITISCH**

#### 2. Frontend-Entwicklung
- **Zeitabweichung (absolut):** 2 Wochen – 3 Wochen = –1 Woche = –7 Tage
- **Zeitabweichung (%):** (2 – 3) / 3 × 100 = –1 / 3 × 100 = **–33 %** ➜ **POSITIV** (schneller als geplant!)
- **Kostenabweichung (absolut):** € 10.000 – € 15.000 = **–€ 5.000**
- **Kostenabweichung (%):** (10.000 – 15.000) / 15.000 × 100 = –5.000 / 15.000 × 100 = **–33 %** ➜ **POSITIV** (günstiger!)

#### 3. Backend-Integration
- Status: Noch laufend, daher nur Teilkosten verfügbar
- **Geplante Gesamtkosten:** € 8.000
- **Bisherige tatsächliche Kosten:** € 3.000 (erst teilweise abgewickelt)
- **Bisherige Kostenabweichung:** € 3.000 – € 4.000 (50 % von € 8.000) = **–€ 1.000** (besser als erwartet)
- **Bewertung:** Noch nicht abgeschlossen → genaue Zeitabweichung noch nicht bestimmbar

#### 4. QA & Testing
- Status: Noch nicht begonnen
- **Bewertung:** Potenzielles Risiko, da nur noch 1 Woche Zeit eingeplant für diese kritische Phase

### Zusammenfassende Tabelle

| Aktivität | Zeitabw. (absolut) | Zeitabw. (%) | Kritikalität | Kostenabw. (absolut) | Kostenabw. (%) | Kritikalität |
|-----------|:------------------:|:----------:|:----------:|:-------------------:|:----------:|:----------:|
| **Design-Phase** | +3,5 Tage | +25 % | 🔴 KRITISCH | +€ 2.500 | +25 % | 🔴 KRITISCH |
| **Frontend-Entw.** | –7 Tage | –33 % | 🟢 POSITIV | –€ 5.000 | –33 % | 🟢 POSITIV |
| **Backend-Integ.** | TBD | TBD | 🟡 GELB | –€ 1.000 (bisher) | –25 % (bisher) | 🟢 POSITIV |
| **QA & Testing** | – | – | 🔴 KRITISCH | – | – | ⏳ NICHT GESTARTET |

### Gesamtprojekt-Analyse

**Bisher ausgegeben:** € 12.500 + € 10.000 + € 3.000 = **€ 25.500** (von € 25.000 geplant für 3 Aktivitäten)
- **Abweichung:** +€ 500 / € 25.000 = **+2 %** (noch im grünen Bereich)

**Zeitfortschritt:**
- Design + Frontend geplant: 2 + 3 = 5 Wochen
- Tatsächlich: 2,5 + 2 = 4,5 Wochen
- **Einsparung: –0,5 Wochen** → Teilweise Kompensation der Verzögerung in Design

### Beantwortung der Fragen

**1. Wo sind die größten Abweichungen?**

> **Antwort:** 
> - **Design-Phase**: Beide Zeit UND Kosten um 25 % über Plan (KRITISCH). Dies ist die größte Abweichung bisher.
> - **QA & Testing**: Noch nicht gestartet, obwohl bereits in der Ausführungsphase. Mit nur 1 Woche geplant könnte dies ein Engpass werden.

**2. Welche Aktivitäten führen zu Einsparungen, welche zu Überschreitungen?**

> **Antwort:**
> - **Überschreitungen (negativ):**
>   - Design-Phase: +€ 2.500 und +3,5 Tage
> - **Einsparungen (positiv):**
>   - Frontend-Entwicklung: –€ 5.000 und –7 Tage (Netto-Einsparung bisher!)
> - **Neutral/TBD:**
>   - Backend-Integration: Aktuell unter Budget, aber Status noch offen

**3. Welche Risiken sehen Sie für die noch ausstehenden Aktivitäten (Backend, QA)?**

> **Antwort:**
> - **Backend-Integration Risiko:**
>   - Die bisherige Kostenquote von 37,5 % (€ 3.000 von € 8.000) ist positiv, aber die Aktivität muss noch 2 Wochen weiterlaufen
>   - Wenn die Kostentendenz anhält: EAC ca. € 8.000 (aktuell OK)
>   - Aber: Wurde die geplante Dauer von 2 Wochen bereits überschritten? (Daten nicht klar)
> 
> - **QA & Testing Risiko (KRITISCH):**
>   - NICHT GESTARTET, obwohl Timeline vorgesehen
>   - Mit nur 1 Woche Puffer und bisherigen Verzögerungen könnte dies zum Engpass werden
>   - **Empfehlung**: QA-Startermine überprüfen, evtl. in Parallel mit Backend starten (überlappende Phasen)
>   - Budget-Reserve: € 5.000 für 1 Woche sollte gerade reichen
> 
> - **Übergeordnetes Risiko:**
>   - Gesamtverzug durch Design könnte über gesamten Projektplan kaschkadieren
>   - Frontend-Einsparung könnte diese Verzögerung nicht vollständig kompensieren

---

> **KOMMENTAR:**
> 
> Diese Aufgabe zeigt ein typisches Szenario im Projektmanagement: **Lokale Einsparungen können globale Verzögerungen nicht verbergen.** Die Design-Phase verschuldet eine 25 %-ige Verzögerung, die nachfolgende Phasen unter Druck setzt. Obwohl Frontend schneller war, wird die QA-Phase möglicherweise unter Zeitdruck geraten.
> 
> **Typische Anfängerfehler zu vermeiden:**
> 1. ❌ Zu optimistisch: „Das 2-Wochen-Puffer für QA reicht noch" – Oft nicht!
> 2. ❌ Zu lokal denken: Nur auf einzelne Aktivitäten fokussieren, statt Kaskade zu sehen
> 3. ❌ Zu spät handeln: Erst bei der letzten Aktivität reagieren statt frühzeitig eingreifen
> 
> **Richtige Handlung nach dieser Analyse:**
> - Weekly Status für Lenkungsausschuss eskalieren: Design >20 % über Plan
> - Change-Control-Sitzung einberufen: QA-Phase starten oder Scope reduzieren?
> - Entscheidung: Deadline verschieben, QA-Budget erhöhen, oder Funktionen reduzieren?

---

## Lösung Aufgabe 2: KPIs definieren

### Aufgabenstellung (Wiederholung)
Definieren Sie 5–7 KPIs für ein mobiles App-Projekt (6 Monate, € 300.000, 8 Dev + 2 Designer).

### Lösung

#### KPI 1: Schedule Performance Index (SPI) – ZEIT

```
KPI-Name: Schedule Performance Index (SPI)

Definition/Formel: 
  SPI = Earned Value (EV) / Planned Value (PV)
  
  Wobei:
  - PV = Geplante Kosten für alle bis heute geplanten Arbeiten
  - EV = Bewertung der bis heute tatsächlich geleisteten Arbeiten zu Plankosten

Zielwert: 1,0 (exakt im Plan)

Grüner Bereich: 0,95 – 1,05 (±5% Toleranz → Projekt im Plan)
Gelber Bereich: 0,90 – 0,94 oder 1,06 – 1,10 (5–10% Abweichung → Monitoring)
Roter Bereich: < 0,90 oder > 1,10 (>10% Abweichung → Reaktion nötig)

Messhäufigkeit: Wöchentlich, jeden Freitag 16:00 Uhr

Datenquelle: Timesheet-System, Jira/YouTrack Issue-Status, Meilenstein-Tracking

Verantwortlich: Projektmanager

Interpretation:
  - SPI = 0,93 bedeutet: Nur 93% der geplanten Arbeit ist bis heute erledigt (= 7% Verzug)
  - Trend ist wichtig: Verbessert sich SPI oder verschlechtert es sich?
```

#### KPI 2: Cost Performance Index (CPI) – KOSTEN

```
KPI-Name: Cost Performance Index (CPI)

Definition/Formel:
  CPI = Earned Value (EV) / Actual Cost (AC)
  
  Wobei:
  - AC = Tatsächlich ausgegeben Kosten (Gehälter, Third-Party Services, Tools)

Zielwert: 1,0 (exakt im Budget)

Grüner Bereich: 0,95 – 1,05 (±5% Toleranz → OK)
Gelber Bereich: 0,90 – 0,94 oder 1,06 – 1,10 (5–10% Abweichung)
Roter Bereich: < 0,90 oder > 1,10 (>10% Abweichung → Kostenüberprüfung)

Messhäufigkeit: Wöchentlich, jeden Montag (nach finanziellem Wochenabschluss)

Datenquelle: SAP/Buchhaltungssystem, Freelancer-Rechnungen, Lizenzkosten

Verantwortlich: Projektmanager + Finanzcontroller

Interpretation:
  - CPI = 1,05 bedeutet: Wir bekommen 5% mehr geleistete Arbeit pro € ausgegeben → sehr gut!
  - CPI = 0,88 bedeutet: Wir geben zu viel aus für die bisher geleistete Arbeit → Abweichung negativ
```

#### KPI 3: Defect Rate / Quality Index – QUALITÄT

```
KPI-Name: Defect Rate (kritische + mittlere Defekte)

Definition/Formel:
  Defect Rate (%) = (Kritische Defekte + Mittlere Defekte) / Getestete User Stories × 100

Zielwert: < 3% (maximal 3 Defekte pro 100 getesteten User Stories)

Grüner Bereich: 0–3% (Akzeptabel)
Gelber Bereich: 3–7% (Erhöhtes Testvolumen nötig)
Roter Bereich: > 7% (QA-Phase muss verlängert werden; mögl. Sprint-Stop)

Messhäufigkeit: Nach jeder QA-Testphase (täglich/wöchentlich ab Woche 4)

Datenquelle: Jira Test-Cases, Bug-Tracker, Test-Reports

Verantwortlich: QA-Lead, Testmanager

Alternative: Test Coverage (% Code abgedeckt) = Mindestens 80%
```

#### KPI 4: Team Velocity – RESSOURCEN & LEISTUNG

```
KPI-Name: Sprint Velocity (für agile Entwicklung)

Definition/Formel:
  Velocity = Story Points abgeschlossen in einem Sprint / Sprint-Dauer (1–2 Wochen)
  
  Beispiel:
  - Sprint 1: 45 Story Points geplant, 42 SP abgeschlossen → Velocity = 42 SP/Sprint
  - Sprint 2: Ziel: 42+ SP (oder Trend zeigen)

Zielwert: Konsistente Velocity über Sprints (Variabilität < ±15%)

Grüner Bereich: Velocity ±10% zum 3-Sprint-Durchschnitt
Gelber Bereich: Velocity ±10–20% Schwankung (könnte Ressourcenprobleme andeuten)
Roter Bereich: Velocity –30% zum vorherigen Sprint (Warnsignal: Blockaden, Krankheit, Scope-Creep)

Messhäufigkeit: Nach jedem Sprint (Sprint-Retrospektive)

Datenquelle: Jira Sprint Board, Burndown-Chart

Verantwortlich: Scrum Master, Projektmanager

Interpretation:
  - Stabile Velocity = Planbarkeit
  - Fallende Velocity = Problem (technische Schulden, zu viele Störungen)
  - Steigende Velocity = Gutes Zeichen (Team wird effizienter)
```

#### KPI 5: Scope Creep Rate – ANFORDERUNGSMANAGEMENT

```
KPI-Name: Scope Creep Rate

Definition/Formel:
  Scope Creep Rate (%) = Neue/geänderte User Stories pro Woche / Geplante User Stories gesamt × 100

Zielwert: < 1% pro Woche (maximal 1–2 neue Anforderungen pro Woche bei 200 Gesamt-US)

Grüner Bereich: 0–1% (Änderungen unter Kontrolle)
Gelber Bereich: 1–2% (Zu beobachten; mögl. Stakeholder-Kommunikation)
Roter Bereich: > 2% (Unkontrolliertes Scope-Wachstum; Change-Control nötig)

Messhäufigkeit: Wöchentlich

Datenquelle: Jira, Change-Request-Log, Product Backlog

Verantwortlich: Produktmanager, Requirements-Engineer

Zusätzliche Regel:
  - Neue Features nach Woche 12 (von 26) nicht mehr akzeptiert ohne Deadline-Verschiebung
  - "Feature Freeze" ab Woche 18
```

#### KPI 6: Team Auslastung / Resource Utilization

```
KPI-Name: Team Utilization Rate

Definition/Formel:
  Utilization (%) = Stunden auf Projekt / Verfügbare Stunden pro Person pro Woche × 100

Zielwert: 80–90% (100% ist unrealistisch und führt zu Burnout)

Grüner Bereich: 75–90% (Gesunde Auslastung, Raum für Unerwartetes)
Gelber Bereich: 90–100% (Knapp, aber OK kurzfristig)
Roter Bereich: > 100% oder < 70% (Überbelastung oder Unterbeschäftigung; Rebalancing nötig)

Messhäufigkeit: Wöchentlich (aus Timesheet-System)

Datenquelle: Timesheet, HR-System

Verantwortlich: Projektmanager, Linienmanager

Zusätzliche Regel:
  - Wenn > 100% für > 3 Wochen: Change-Request zur Ressourcen-Aufstockung
  - Wenn < 60% für 2 Wochen: Möglicher Ressourcen-Abbau oder Umverteilung
```

#### KPI 7 (Optional): Stakeholder Satisfaction / NPS

```
KPI-Name: Net Promoter Score (NPS) / Stakeholder-Zufriedenheit

Definition/Formel:
  NPS = (% Promoters – % Detractors)
  
  Berechnung über Umfrage:
  "Wie wahrscheinlich ist es, dass Sie dieses Projekt Ihren Kollegen empfehlen?"
  (0 = sehr unwahrscheinlich, 10 = sehr wahrscheinlich)
  
  - Promoters: 9–10 → positiv
  - Neutral: 7–8 → neutral
  - Detractors: 0–6 → negativ

Zielwert: NPS > 50 (= 50% Promoters – 10% Detractors = 40 Punkte)

Grüner Bereich: NPS > 50 (Sehr gut)
Gelber Bereich: NPS 30–50 (Okish; Verbesserung möglich)
Roter Bereich: NPS < 30 (Problem; Stakeholder-Workshop nötig)

Messhäufigkeit: Monatlich oder nach großen Meilensteinen

Datenquelle: Anonyme Umfrage (SurveyMonkey, Jira Feedback)

Verantwortlich: Projektmanager
```

### Zusammenfassende KPI-Scorecard

| KPI-Nr. | KPI-Name | Zielwert | Grün | Gelb | Rot | Messhäufigkeit |
|---------|----------|----------|------|------|-----|----------------|
| 1 | Schedule Performance Index (SPI) | 1,0 | 0,95–1,05 | 0,90–0,94 / 1,06–1,10 | <0,90 / >1,10 | Wöchentlich |
| 2 | Cost Performance Index (CPI) | 1,0 | 0,95–1,05 | 0,90–0,94 / 1,06–1,10 | <0,90 / >1,10 | Wöchentlich |
| 3 | Defect Rate | <3% | 0–3% | 3–7% | >7% | Nach Test-Phase |
| 4 | Team Velocity | Stabil | ±10% zu Avg | ±10–20% Schwankung | –30% Fall | Nach Sprint |
| 5 | Scope Creep Rate | <1%/Woche | 0–1% | 1–2% | >2% | Wöchentlich |
| 6 | Team Utilization | 80–90% | 75–90% | 90–100% | >100% / <70% | Wöchentlich |
| 7 | NPS (optional) | >50 | >50 | 30–50 | <30 | Monatlich |

---

> **KOMMENTAR:**
> 
> **Was macht diese KPI-Definition praktisch und sinnvoll?**
> 
> 1. **Vollständigkeit**: Die 7 KPIs decken alle kritischen Dimensionen ab (Zeit, Kosten, Qualität, Team, Scope, Zufriedenheit).
> 
> 2. **Ampel-Logik**: Jeder KPI hat klare Grenzen für Grün/Gelb/Rot – keine Interpretationsspielraum.
> 
> 3. **Automatisierbarkeit**: Die meisten KPIs können aus Jira/YouTrack automatisch berechnet werden (z. B. SPI aus EV-Daten).
> 
> 4. **Action-Orientierung**: Jede Grün/Gelb/Rot-Kategorisierung leitet eine Aktion ab:
>    - Grün: Weiter so, Monitoring fortsetzen
>    - Gelb: Genauer beobachten, ggf. präventive Maßnahmen
>    - Rot: Sofortige Eskalation und Korrekturmaßnahmen
> 
> **Häufige Anfängerfehler zu vermeiden:**
> 
> ❌ **Zu viele KPIs** (>10): Überwältigend, niemand trackt alle
> ✅ **Richtig**: 5–7 KPIs, fokussiert auf kritische Erfolgsfaktoren
> 
> ❌ **Zu subjektive Zielwerte** („Projekt läuft gut"): Nicht messbar
> ✅ **Richtig**: Konkrete Zahlen und Formeln
> 
> ❌ **Keine Eskalationslevel**: Dashboard ohne Konsequenz sinnlos
> ✅ **Richtig**: Bei Rot sofort Aktion + Eskalation definieren
> 
> ❌ **Falsche Messhäufigkeit**: Zu oft = Lärm, zu selten = zu spät
> ✅ **Richtig**: Wöchentlich für schnelle Indikatoren (SPI, CPI), Monatlich für strategische (NPS)

---

## Lösung Aufgabe 3: Trendanalyse und Prognose

### Aufgabenstellung (Wiederholung)
Burn-Down-Chart eines IT-Projekts analysieren, Trend extrapolieren, Prognose für Woche 8 erstellen.

### Lösung

#### Schritt 1: Burn-Down-Chart zeichnen

```
Burn-Down-Chart: IT-Projekt Sprint (8 Wochen)

Verbl. Story Points
│
250 │                        ▲ Tatsächlich (Trend negativ!)
    │                       ╱ ╲
200 │ ●─────────────────────   ╲ Geplant (ideal)
    │  ●                        ╲
150 │   ●     ●                  ╲
    │    ●───●──●───●────────────╲
100 │                 ●─────────   ╲
    │                              ●───────
 50 │                                      ╲
    │                                       ╲
  0 │__________________________________ ____●
    └────┬────┬────┬────┬────┬────┬────┬────┬
      W1  W2  W3  W4  W5  W6  W7  W8(geplant)

● = Geplante verbleibende SP
◼ = Tatsächliche verbleibende SP
```

#### Schritt 2: Numerische Daten analysieren

| Woche | Geplant SP | Tatsächlich SP | Differenz | Interpretation |
|:-----:|:----------:|:-------------:|:---------:|----------------|
| 1 | 200 | 180 | –20 | ✅ Gut: 20 SP abgeschlossen |
| 2 | 170 | 165 | –5 | ✅ OK: Nur 15 SP abgeschlossen diese Woche |
| 3 | 140 | 155 | **+15** | 🟡 PROBLEM: Aufwand größer als erwartet! |
| 4 | 110 | 140 | **+30** | 🔴 KRITISCH: Aufwand nochmal gestiegen! |
| 5 | 80 | 135 | **+55** | 🔴 WORST: Aufwand explodiert! |
| 6 | 50 | 145 | **+95** | 🔴 WORST: Sind wir rückwärts gegangen?? |
| 7 | 20 | 150 | **+130** | 🔴 FATAL: Kein Fortschritt, neg. Trend |
| 8 | 0 (Ziel) | **? (Prognose)** | ? | ⚠️ Was passiert hier? |

#### Schritt 3: Trend extrapolieren

**Beobachtung: Die tatsächliche Linie geht kontinuierlich nach OBEN (statt nach unten) – das ist das Gegenteil von gewünscht!**

**Burn-Rate-Analyse:**
```
Wochen 1–2 (positive Phase):
  - Burnrate: (200 – 165) / 2 = 17,5 SP/Woche ✅

Wochen 3–7 (negative Phase – aufsteigend):
  - Woche 3: +15 SP (gegen Plan)
  - Woche 4: +30 SP (gegen Plan)
  - Woche 5: +55 SP (gegen Plan)
  - Woche 6: +95 SP (gegen Plan) – warum so groß??
  - Woche 7: +5 SP (weniger schlecht)
  
  Durchschnittliche Drift (Wochen 3–7): (15+30+55+95+5) / 5 = +40 SP/Woche (drift nach oben!)
```

**Extrapolation zu Woche 8:**

Methode 1: Lineare Fortschreibung des letzten Trends
```
Wenn die Drift von Woche 7 zu Woche 6 (145 → 150 = +5 SP) anhält:
Woche 8 Prognose = 150 + 5 = 155 SP verbleibend

→ Projekt NICHT pünktlich fertig bis Woche 8!
```

Methode 2: Durchschnittliche Drift (letzte 4 Wochen)
```
Wochen 4–7 durchschnittliche Drift: (30+55+95+5) / 4 = +46 SP/Woche
Woche 8 Prognose = 150 + 46 = 196 SP verbleibend

→ Noch schlimmer!
```

Methode 3: Konservativ (Hoffnung auf Besserung)
```
Annahme: Ab Woche 8 wird es besser (z. B. Team wird schneller)
Annahme: Burnrate = –20 SP (statt +40 SP Drift)
Woche 8 Prognose = 150 – 20 = 130 SP verbleibend

→ Immer noch nicht fertig!
```

**Beste Schätzung für Woche 8: 150–160 SP verbleibend** (nicht 0!)

#### Schritt 4: Wann wird das Projekt tatsächlich fertig?

**Berechnung der realen Fertigstellungsdauer:**

Wenn die Burnrate sich ab Woche 8 verbessert:

```
Szenario A (optimistisch): Burnrate = –30 SP/Woche ab Woche 8
  Woche 8: 150 – 30 = 120 SP
  Woche 9: 120 – 30 = 90 SP
  Woche 10: 90 – 30 = 60 SP
  Woche 11: 60 – 30 = 30 SP
  Woche 12: 30 – 30 = 0 SP ✓

→ Prognose: Fertig in Woche 12 (4 Wochen Verzug!)

Szenario B (realistisch): Burnrate bleibt bei –20 SP/Woche
  Woche 8–15: 150 / 20 = 7,5 Wochen
  
→ Prognose: Fertig in Woche 15 (7 Wochen Verzug!)

Szenario C (pessimistisch): Burnrate bleibt bei –10 SP/Woche
  Woche 8–23: 150 / 10 = 15 Wochen
  
→ Prognose: Fertig in Woche 23 (15 Wochen Verzug!) – PROJEKT GESCHEITERT
```

#### Schritt 5: Frühwarnsignale – Hätten wir das früher erkennen können?

**JA! Sehr deutlich sogar:**

| Woche | Signal | Hätte man reagiert? |
|:-----:|--------|-------------------|
| **1** | Guter Start, 20 SP abgeschlossen | – Nein, zu früh |
| **2** | Burnrate fällt (nur 15 SP diese Woche) | 🟡 Vorsicht! Erste Warnung |
| **3** | **+15 SP statt –** 🔴 WARNUNG! | **Ja! Hier sofort reagieren!** |
| **4** | **+30 SP – Trend bestätigt negativ** | **Spätester Punkt für Eskalation** |
| **5–7** | Zu spät – Projekt im freien Fall | Nur noch Schadensbekämpfung |

**Empfohlenes Frühwarnsystem für Burn-Down:**

```
RULE 1: Wenn in Woche 2 Burnrate < –10 SP/Woche → GELB (neuen Burnrate tracken)

RULE 2: Wenn 3 Wochen in Folge verbleibende SP ansteigen (statt zu sinken) 
        → ROT (Sofortige Eskalation!)

RULE 3: Wenn SPI (tatsächliche SP abg. / geplante SP abg.) < 0,80 über 2 Wochen 
        → ROT (Scope Review, mögl. Sprint-Stop)

Woche 3: Hätte Rule 2 getriggert → Eskalation nötig gewesen!
```

#### Schritt 6: Empfehlungen und Maßnahmen

**Was sollte die PM-Aktion sein?**

```
FRAGE: "Warum steigen die verbl. Story Points statt zu sinken?"

Mögliche Root Causes:
  1. Scope-Creep: Während der Arbeit wurden neue Anforderungen hinzugefügt
  2. Schätzung falsch: Die SP-Schätzung war zu niedrig (Aufwand unterschätzt)
  3. Blockaden / Defekte: Arbeit wird gemacht, aber nicht als "fertig" gezählt
  4. Qualitätsprobleme: Code muss überarbeitet werden (Tech Debt, Rework)
  5. Team-Kapazität: Abgänge, Krankheit, fehlende Ressourcen
  6. Tech Stack-Probleme: Unerwartete technische Komplexität
  7. Falsche Metrik: Sind die Zahlen richtig gemessen?

MASSNAHMEN (für Woche 8+):
  ✓ Sofort: Daily Standup intensivieren (15 Min → 30 Min)
  ✓ Sofort: Blockaden aufräumen (was hindert uns?)
  ✓ Dringlich: Scope-Review (weniger Features für Deadline?)
  ✓ Dringlich: Team-Kapazität prüfen (können wir Ressourcen erhöhen?)
  ✓ Eskalation: "Projekt kann Deadline NICHT halten" – an Lenkungsausschuss
  ✓ Entscheidung: Deadline verschieben, Scope reduzieren, oder Kosten erhöhen?
```

---

> **KOMMENTAR:**
> 
> **Was war die Kernfehlentwicklung dieses Projekts?**
> 
> Das **klassische "Burndown-Desaster"** liegt vor:
> - Wochen 1–2: Alles OK, aber Burnrate zu niedrig
> - Woche 3: Erste Anzeichen von Schätzungsfehlern
> - Woche 4: Definitiver Trend: Das wird nicht passen
> - Wochen 5–7: Keine Korrekturen eingeleitet → Projekt unrettbar
> 
> **Lehren für die Praxis:**
> 
> 1. **Früh reagieren**: Bei Woche 3 hätte ein Scope Review + Ressourcen-Boost noch geholfen
> 
> 2. **Trend nicht ignorieren**: Wenn 2 Wochen hintereinander der Trend negativ ist → ALERT
> 
> 3. **Root-Cause finden**: Ist es Schätzfehler, Scope-Creep oder Tech-Schulden? Die Aktion hängt davon ab!
> 
> 4. **Transparenz**: Ein schönes Burn-Down-Chart ist nutzlos, wenn man nicht danach handelt
> 
> 5. **Realistic Re-Forecasting**: In Woche 4 sollte man dem Lenkungsausschuss sagen:
>    - "Wir können NICHT in Woche 8 fertig sein"
>    - "Realistische Prognose: Woche 12 (oder mehr)"
>    - "Optionen: Deadline verschieben, Scope reduzieren, oder Kosten erhöhen"
> 
> **Häufige Anfängerfehler:**
> 
> ❌ Zu optimistisch: "Nächste Woche wird es besser" – (zu oft falsch!)
> ✅ **Richtig**: Datengestützte Prognose, konservative Annahmen
> 
> ❌ Zu spät reagieren: Erst in Woche 7 handeln
> ✅ **Richtig**: In Woche 3–4 bereits Massnahmen einleiten
> 
> ❌ Keine Alternativen: "Wir müssen durchboxen"
> ✅ **Richtig**: Optionen aufzeigen (Deadline, Scope, Kosten)

---

## Lösung Aufgabe 4: Statusbericht verfassen

### Aufgabenstellung (Wiederholung)
Wöchentlicher Statusbericht für ein Bauprojekt (Woche 8 von 24, Verzögerung vorhanden).

### Lösung – Musterstatusber icht

```
═════════════════════════════════════════════════════════════════════════════
                    PROJEKTSTATUSBE RICHT
                    Projekt: Gebäudeanbau (Erweiterungsbau)
                    Woche: 8 von 24 (33 %)
                    Berichtsperiode: 18.11.2025 – 24.11.2025
                    Verfasser: Max Müller, Projektmanager
                    Gültig ab: 25.11.2025
═════════════════════════════════════════════════════════════════════════════

1. EXECUTIVE SUMMARY (Zusammenfassung für eilige Leser)
─────────────────────────────────────────────────────────

Status: 🟡 GELB – Zeitlich leicht hinter Plan, aber unter Kontrolle

Das Projekt liegt im Zeitplan LEICHT HINTER mit aktuell 28 % Fertigstellung 
(geplant: 33 %). Die Verzögerung ist auf die verspätete Baugenehmigung 
und Probleme bei der Ausgrabung zurückzuführen. ALLE Meilensteine wurden 
trotzdem ERREICHT, allerdings mit minimalen Zeitpuffern.

Kostenstatus ist stabil bei € 155.000 ausgegeben (€ 150.000 geplant = +3,3 % 
Überschreitung, GRÜN).

Kritisches Risiko: Regenvorhersage könnte 2–3 Tage Verzug verursachen. 
Maßnahmen: Personalaufstockung um 2 Arbeiter nächste Woche geplant.

Empfehlung: WEITER SO, aber Puffer-Management verstärken.

═════════════════════════════════════════════════════════════════════════════

2. FORTSCHRITT UND TERMINE (Zeitmanagement)
─────────────────────────────────────────────────────

Geplanter Fortschritt (Ende Woche 8):  33 % = 8 Wochen von 24
Tatsächlicher Fortschritt (Messung):   28 % = ca. 6,7 von 24 Wochen
Abweichung:                            –5 % Verzug = etwa 1,3 Wochen Verzug

Detail-Phasen:

  Phase 1 – Vorbereitung & Ausgrabung (Wochen 1–3)
    Geplant:       3 Wochen
    Tatsächlich:   4 Wochen ← Verzögerung durch:
                              • Verspätete Baugenehmigung (–1 Woche)
                              • Archäologische Funde (–0,5 Wochen)
                              • Schwierige Bodenverhältnisse (–0,5 Wochen)
    Status:        ✓ ABGESCHLOSSEN (wenn auch verzögert)
    
  Phase 2 – Grundlagen & Fundamente (Wochen 4–8)
    Geplant:       5 Wochen
    Tatsächlich:   ca. 3 Wochen bis jetzt (noch laufend)
    Status:        🔵 IN PROGRESS – im Plan (oder sogar schneller)
    
  Phase 3 – Rohbau & Statik (Wochen 9–15) 
    Geplant:       7 Wochen
    Status:        ⏳ NOCH NICHT GESTARTET (beginnt nächste Woche, MS3)
    Puffer:        Gering – nur 1–2 Tage Spielraum bei Verzögerungen

Meilensteine:

| Meilenstein | Geplant | Tatsächlich | Status | Notiz |
|-------------|---------|-------------|--------|-------|
| MS1: Baugenehmigung erhalten | W2 | W3 | ✓ | –1 Wo Verzug |
| MS2: Ausgrabung fertig | W3 | W4 | ✓ | –1 Wo Verzug |
| MS3: Fundamente fertig (geplant W8) | W8 | W8-9 | 🟡 AT RISK | Grenzfall |
| MS4: Rohbau-Start | W9 | W10 | – | Abhängig von MS3 |
| MS5: Dach-Aufbau | W16 | ? | – | Bisher OK |

Nächste geplante Aktivitäten (nächste 2 Wochen):

  • W9: Betonarbeiten für Fundamente (Wetter-abhängig!)
  • W9: Rohbau-Vorbereitung + Stahlarmierung
  • W10: Rohbau-Phase startet (wenn Fundamente fertig)
  • Personalaufstockung um 2 Arbeiter ab Montag (26.11.2025)

═════════════════════════════════════════════════════════════════════════════

3. FINANZEN & BUDGET (Kostenmanagement)
─────────────────────────────────────────

Geplante Kosten (bisher):      € 150.000 (33 % von € 450.000 Gesamtbudget)
Tatsächliche Kosten (bisher):  € 155.000
Kostenabweichung:             +€ 5.000 (+3,3 %) → 🟡 GELB (akzeptabel, <5%)

Detaillierte Kostenaufschlüsselung:

| Kostenart | Budget W1–W8 | Tatsächlich | Abweichung | Status |
|-----------|:----------:|:----------:|:-------:|--------|
| Arbeitskräfte (Lohn) | € 90.000 | € 92.000 | +€ 2.000 (+2,2%) | 🟢 |
| Material (Beton, Stahl) | € 40.000 | € 42.000 | +€ 2.000 (+5,0%) | 🟡 |
| Miete Baugeräte | € 15.000 | € 15.500 | +€ 500 (+3,3%) | 🟢 |
| Sonstige (Versicherung, Admin) | € 5.000 | € 5.500 | +€ 500 (+10%) | 🟡 |
| **SUMME** | **€ 150.000** | **€ 155.000** | **+€ 5.000** | **🟡** |

Budget-Reserven:

  Gesamtbudget:              € 450.000
  Bisher ausgegeben:         € 155.000
  Verbleibend verfügbar:     € 295.000 (65,6% des Budgets)
  
  Prognose für Gesamtprojekt (Extrapolation):
    Wenn +3,3% Überschreitung andauert:
    Prognose Gesamtkosten = € 450.000 × 1,033 = € 465.000
    → Überschreitung: € 15.000 (3,3 %) – AKZEPTABEL
    
Rückstellungen / Eventualbudget:

  Budgetierte Rückstellung:   € 30.000 (Notfallpuffer)
  Bisher angetastet:          € 0
  Verbleibend:                € 30.000 ✓

Finanzielle Entscheidung: GRÜNER BEREICH – kein Handlungsbedarf

═════════════════════════════════════════════════════════════════════════════

4. RISIKEN & PROBLEME
──────────────────────

Neue Risiken diese Woche:
  Keine neuen Risiken identifiziert

Offene / Hochrisiko-Risiken:

| # | Risiko | Wahrscheinlichkeit | Auswirkung | Risikowert | Status | Maßnahme |
|---|--------|:--:|:--:|:--:|--------|----------|
| 1 | 🔴 Schlechtwetter / Regen (2–3 Tage Verzug) | 60 % | Hoch | ROT | Active | Schutzdächer, Tagesplanung flexibel |
| 2 | 🟡 Lieferverzug bei Stahlträgern | 30 % | Mittel | GELB | Monitor | Alternative Lieferant aktivieren |
| 3 | 🟢 Arbeiterunfälle / Sicherheit | 10 % | Sehr Hoch | GELB | Prevent | Tägliche Sicherheitsunterweisung |

**KRITISCHES RISIKO im Detail – Regenvorhersage:**

  Meteorologische Vorhersage für nächste 2 Wochen:
  • Freitag 28.11.: Regen, 40 mm/Tag möglich
  • Wochenende: Weitere Regentage
  • Auswirkung: Betonarbeiten können nicht durchgeführt werden (Qualität leidet)
  
  Geplante Maßnahmen:
  ✓ Schutzdächer aufbauen (Donnerstag)
  ✓ Tagesplanung: Arbeiten nach Wetter ausrichten
  ✓ Notfall-Szenario: Wenn Verzug >3 Tage → Notfall-Personalaufstockung aktivieren
  ✓ Lenkungsausschuss wird informiert, falls Verzug > 1 Woche droht

Offene Issues (Probleme, nicht strategische Risiken):

  1. Baustelle-Zufahrt: Nachbargrundstück-Eigentümer blockiert manchmal die Zufahrt
     Lösung: Gespräch mit Nachbar angesetzt für Mittwoch
  
  2. Entsorgung von Aushubmaterial: Deponie-Gebühren gestiegen um 15 %
     Lösung: Alternative Entsorgungsmöglichkeit suchen (kostet ca. € 1.000 mehr)

═════════════════════════════════════════════════════════════════════════════

5. RESSOURCEN & TEAM
──────────────────────

Aktuelle Besetzung:

  • Projektmanager (Vollzeit):        Max Müller ✓
  • Bauleiter (Vollzeit):             Peter Schmidt ✓
  • Arbeiter (Tagelöhner):            8 Personen ✓
  • Spezialist Statik (Teilzeit):     Dr. Wagner (1 Tag/Woche) ✓

Personaländerungen nächste Woche:

  ✓ +2 zusätzliche Arbeiter ab 26.11. (Überzeit-Reduktion, Effizienz)
  ✓ Spezialist Statik: 2 Tage/Woche (ab W9, für Rohbau-Phase)

Ressourcen-Auslastung:

  Arbeiter: 8 → 10 Personen = ca. 95 % Auslastung (gesund)
  Bauleiter: 100 % (vollausgelastet)
  Projektmanager: 80 % (PM-Aufgaben)

Keine Engpässe erkannt. Team-Zufriedenheit: Gut (mündliches Feedback).

═════════════════════════════════════════════════════════════════════════════

6. ÄNDERUNGEN & CHANGE REQUESTS
─────────────────────────────────

Neue Change Requests diese Woche:   KEINE

Bereits genehmigt & umgesetzt:

  • CR-001: Archäologische Grabung erweitern (Fundstücke freigelegt)
    Status: ✓ ABGESCHLOSSEN (Kosten: +€ 3.000, genehmigt)
    
  • CR-002: Drainage-System verbessern (aufgrund Bodenverhältnisse)
    Status: ✓ UMGESETZT (Kosten: +€ 2.000, genehmigt)

Geplante Änderungen (vorausschauend):

  • Eventuell: Fassaden-Material-Upgrade (kostenpflichtig, noch nicht genehmigt)
    Auswirkung: +€ 5.000 (wird bei nächster Lenkungssitzung besprochen)

═════════════════════════════════════════════════════════════════════════════

7. KOMMUNIKATION & STAKEHOLDER
────────────────────────────────

Letzte Meetings:

  ✓ W8 Montag: Wöchentliches Team-Standup (12 Teilnehmer, 45 Min)
  ✓ W8 Mittwoch: Lenkungsausschuss-Meeting (3 Std.)
  ✓ W8 Donnerstag: Nachbar-Gespräch (Zufahrts-Thema)

Stakeholder-Feedback:

  • Bauherr: Zufrieden mit Kommunikation, leicht besorgt wegen Regen
  • Finanzleiter: Budget-Status OK, aber Material-Kosten beobachten
  • Architekt: Rohbau-Planung läuft, alle Designs finalisiert

Geplante Kommunikation nächste Woche:

  • Mittwoch 26.11.: Nachbar-Besuch (Zufahrts-Regelung)
  • Freitag 28.11.: Lenkungsausschuss-Update (falls Regen kritisch wird)

═════════════════════════════════════════════════════════════════════════════

8. NÄCHSTE SCHRITTE & AUSBLICK (2-Wochen-Fenster)
────────────────────────────────────────────────────

Woche 9 (25.–31.11.2025):

  KRITISCH – Betonarbeiten für Fundamente:
  ✓ Beton-Lieferung bestellen (Lieferdatum: Montag 25.11.)
  ✓ Schutzmaßnahmen gegen Regen vorbereiten
  ✓ Inspekteur der Baubehörde anfordern (Abnahme nach Betonieren)
  ✓ Personalaufstockung (+2 Arbeiter) integrieren
  → Meilenstein: MS3 „Fundamente fertig" soll bis Ende Woche 9 erreicht sein

Woche 10 (02.–07.12.2025):

  ✓ Rohbau-Phase vorbereiten (Stahlbau-Elemente)
  ✓ Statiker-Inspektionen durchführen
  ✓ Baugenehmigungs-Korrekturen (falls nötig)
  → Meilenstein: MS4 „Rohbau-Start" (geplant)

Kritische Abhängigkeiten:

  • Wetter (Regen) – kann 2–3 Tage Verzug verursachen
  • Stahlbau-Lieferung – erwartet KW 50 (10.12.)
  • Inspektionen der Baubehörde – Termine müssen eingehalten werden

Risiko-Minderung für nächste 2 Wochen:

  ✓ Schutzdächer aufbauen (Mittwoch 26.11.)
  ✓ Mit Stahlbau-Lieferant bestätigen (heute noch)
  ✓ Notfall-Szenarien mit Team durchsprechen (Montag-Standup)

═════════════════════════════════════════════════════════════════════════════

APPENDIX: Kennzahlen & KPIs im Überblick

Schedule Performance Index (SPI) = 28% / 33% = 0,85 → 🟡 GELB (5 % unter Plan)

Cost Performance Index (CPI) = 155.000 / 155.000 = 1,0 → 🟢 GRÜN (exakt)

Budget Variance (BV) = Earned Value – Actual Cost = 150.000 – 155.000 = –€ 5.000

═════════════════════════════════════════════════════════════════════════════

Verfasser:          Max Müller, Projektmanager
Datum:              25.11.2025
Gültig für:         Lenkungsausschuss, Bauherr, Finanzleiter
Verteilung:         4 Kopien (2x Papier, 2x Digital)
Freigegeben durch:  [Unterschrift Projektmanager]
Nächster Bericht:   02.12.2025

═════════════════════════════════════════════════════════════════════════════
```

---

> **KOMMENTAR:**
> 
> **Warum ist dieser Statusbericht gut?**
> 
> 1. **Aussagekräftige Zusammenfassung**: In der Executive Summary weiß der eilige CEO sofort: Grüner Bereich, aber Zeit leicht verzögert.
> 
> 2. **Konkrete Zahlen**: Nicht „Projekt läuft gut" sondern „28% vs. 33%, Differenz –5%".
> 
> 3. **Ampel-Logik**: Jede Sektion hat Grün/Gelb/Rot-Status.
> 
> 4. **Root-Cause-Erklärung**: Nicht nur „5% Verzug" sondern „Weil Baugenehmigung 1 Woche später kam".
> 
> 5. **Forward-Looking**: Nicht nur Rückblick, sondern klare Planung für die nächsten 2 Wochen.
> 
> 6. **Actionable Insights**: 
>    - Regen-Risiko → konkrete Maßnahmen (Schutzdächer)
>    - Material-Lieferverzug → Notfall-Lieferant vorbereitet
> 
> 7. **Verantwortlichkeit**: Wer macht was (Bauleiter, Materialbestellung, etc.)
> 
> 8. **Adressatengerecht**: 
>    - Für CFO: Fokus auf Budget und Kosten
>    - Für Bauherr: Zeitplan und Qualität
>    - Für Team: Nächste Schritte und Verantwortlichkeiten
> 
> **Häufige Anfängerfehler zu vermeiden:**
> 
> ❌ Zu lang und detailliert (5–10 Seiten): Niemand liest's
> ✅ Richtig: 2–3 Seiten für Management, Details in Anlagen
> 
> ❌ Zu vago: „Projekt läuft, kein Problem"
> ✅ Richtig: Konkrete Zahlen und Begründungen
> 
> ❌ Negative Überschreibung: Probleme verstecken
> ✅ Richtig: Transparent kommunizieren, aber mit Lösungsansätzen
> 
> ❌ Keine Maßnahmen: Status zeigen, ohne Handlung
> ✅ Richtig: „Hier ist das Problem, das tun wir dagegen"

---

## Lösung Aufgabe 5: Dashboard erstellen

### Aufgabenstellung (Wiederholung)
One-Page-Dashboard für e-Commerce-Projekt erstellen (Woche 6 von 16, Daten gegeben).

### Lösung – Muster-Dashboard

```
╔════════════════════════════════════════════════════════════════════════════╗
║           E-COMMERCE SHOP – PROJEKTDASHBOARD (WEEK 6 / 16)                 ║
║                     Status: Woche 6 (25.11.2025)                           ║
║                     Projekt: Online-Shop Relaunch 2025                     ║
╚════════════════════════════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────────────────────────────┐
│ PROJEKT-STATUS ÜBERSICHT                            Gesamtstatus: 🟡 GELB   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ╔═══════════════════╗  ╔═══════════════════╗  ╔═══════════════════╗        │
│  ║  ZEITPLAN         ║  ║  BUDGET           ║  ║  QUALITÄT         ║        │
│  ║  ─────────────    ║  ║  ──────────────   ║  ║  ──────────────   ║        │
│  ║  Fortschritt:     ║  ║  Fortschritt:     ║  ║  Defekt-Rate:     ║        │
│  ║  35%  (Ist)       ║  ║  38.5 % (Ist)     ║  ║  2,8% (Ist)       ║        │
│  ║  37,5% (Soll)     ║  ║  37,5% (Soll)     ║  ║  <3,0% (Soll)     ║        │
│  ║                   ║  ║                   ║  ║                   ║        │
│  ║  SPI: 0,933       ║  ║  CPI: 0,909       ║  ║  Kritisch: 2      ║        │
│  ║  Trend: ↓         ║  ║  Trend: ↓         ║  ║  Normal: 12       ║        │
│  ║                   ║  ║                   ║  ║  Niedrig: 25      ║        │
│  ║  Status: 🟡 GELB  ║  ║  Status: 🟡 GELB  ║  ║                   ║        │
│  ║  –7% unter Plan   ║  ║  –9% über Budget  ║  ║  Status: 🟢 GRÜN  ║        │
│  ║                   ║  ║                   ║  ║  OK               ║        │
│  ╚═══════════════════╝  ╚═══════════════════╝  ╚═══════════════════╝        │
│                                                                             │
│  ╔═══════════════════╗  ╔═══════════════════╗                               │
│  ║  MEILENSTEINE     ║  ║  RISIKEN          ║                               │
│  ║  ──────────────   ║  ║  ──────────────   ║                               │
│  ║                   ║  ║                   ║                               │
│  ║  MS1: Req. ✓      ║  ║  Rot:  1  (API)   ║                               │
│  ║  MS2: Design ✓    ║  ║  Gelb: 2          ║                               │
│  ║  MS3: Dev → IN    ║  ║                   ║                               │
│  ║  MS4: Test (W10)  ║  ║  Top Risk:        ║                               │
│  ║                   ║  ║  🔴 API-Integration║                              │
│  ║  Status: 🟢 GRÜN  ║  ║                   ║                               │
│  ║  On Track         ║  ║  Status: 🔴 ROT   ║                               │
│  ║                   ║  ║  Intervention nötig║                              │
│  ╚═══════════════════╝  ╚═══════════════════╝                               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│ EARNED VALUE – TREND (Schedule Performance)                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Earned Value (€)                                                           │
│  200k │                          ▲ Geplant (Planned Value)                  │
│       │                         ╱ ╲                                         │
│  150k │ ●●●●●●                ╱   ╲                                         │
│       │      ╲              ╱       ╲                                       │
│  100k │       ●────●────●──╱────────╲                                       │
│       │                              ╲                                      │
│   50k │                               ╲                                     │
│       │                                ╲                                    │
│    0k ├────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬─────┬─────┤       │
│       └  W1   W2   W3  W4   W5   W6  W7   W8  W9  W10  W11  W12  W16  ┘     │
│                                                                             │
│  ◼ Tatsächlich (Earned Value):  € 175.000 (35 %)                            │
│  ─ Geplant (Planned Value):     € 187.500 (37,5 %)                          │
│  ⚠ Differenz (Schedule Variance): –€ 12.500 (–7 %)                          │
│                                                                             │
│  Prognose:  Wenn SPI = 0,933 beibehalten: Enddatum +2–3 Wochen Verzug       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│ KOSTENENTWICKLUNG (Cost Performance)                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Geplante Kosten (PV):        € 187.500                                     │
│  Tatsächliche Kosten (AC):    € 192.000  🟡 +€ 4.500 Überschreitung         │
│  Earned Value (EV):           € 175.000                                     │
│                                                                             │
│  CPI = EV/AC = 175.000/192.000 = 0,911 → 91 % (–9 % unter Budget) 🟡        │
│                                                                             │
│  Budget Remaining: € 500.000 – € 192.000 = € 308.000 (61,6 % verfügbar)     │
│  Prognose EAC: € 500.000 / 0,911 = € 548.700 (Überschreitung: +€ 48.700)    │
│                                                                             │
│  ⚠ WARNUNG: Wenn CPI = 0,911 beibehalten → Projekt ca. € 49k über Budget!   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────────────────┐
│ DETAILLIERTE METRIKEN                                                      │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                            │
│  Metrik                           │ Wert      │ Ziel  │ Status  │ Trend    │
│  ─────────────────────────────────┼───────────┼───────┼─────────┼──────────│
│  Schedule Performance Index (SPI) │ 0,933     │ ≥1,0  │ 🟡 GELB │ ↓ Fällt  │
│  Cost Performance Index (CPI)     │ 0,911     │ ≥1,0  │ 🟡 GELB │ ↓ Fällt  │
│  Defect Rate                      │ 2,8%      │ <3%   │ 🟢 GRÜN │ → Stabil │
│  Team Utilization                 │ 87%       │ 80–90%│ 🟢 GRÜN │ → OK     │
│  Scope Creep Rate                 │ 1,5%/Wo   │ <1%   │ 🟡 GELB │ ↑ Trend  │
│  Offene kritische Issues          │ 2         │ <1    │ 🟡 GELB │ → Stabil │
│  ─────────────────────────────────┼───────────┼───────┼─────────┼──────────│
│                                                                            │
└────────────────────────────────────────────────────────────────────────────┘

┌───────────────────────────────────────────────────────────────────────────┐
│ HANDLUNGSEMPFEHLUNGEN & NÄCHSTE SCHRITTE                                  │
├───────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  🔴 KRITISCH (RED):                                                       │
│     • API-Integration blockiert → Tägliches Standup mit API-Partner       │
│     • Externe Abhängigkeit muss geklärt werden (heute noch!)              │
│     → Eskalation an Lenkungsausschuss wenn bis morgen nicht gelöst        │
│                                                                           │
│  🟡 WARNUNG (YELLOW):                                                     │
│     • Schedule 7% unter Plan → RCA durchführen, Root-Cause ermitteln      │
│     • Kostenüberscreitung 9% → Ressourcen überprüfen (Überstunden?)       │
│     • Scope-Creep 1,5% → Striktere Change-Control-Prozesse                │
│                                                                           │
│  🟢 OK (GREEN):                                                           │
│     • Qualität im Ziel → Testprozess fortsetzten wie bisher               │
│     • Meilensteine im Plan → Team performt gut                            │
│                                                                           │
│  NÄCHSTE MEETINGS:                                                        │
│     ✓ Heute (25.11.): API-Partner-Telefonat (15:00 Uhr)                   │
│     ✓ Morgen (26.11.): Team RCA – „Warum SPI = 0,93?" (10:00 Uhr)         │
│     ✓ Freitag (28.11.): Lenkungsausschuss Update (falls API nicht gelöst) │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘

         Bericht erstellt: 25.11.2025, 14:30 Uhr
         Projektmanager: Sarah Klein
         Nächster Report: 02.12.2025
         Verteilung: Lenkungsausschuss, Team-Leads, Stakeholder

╚════════════════════════════════════════════════════════════════════════════╝
```

---

> **KOMMENTAR:**
> 
> **Warum ist dieses Dashboard effektiv?**
> 
> 1. **One-Page Rule**: Alles passt auf eine Seite, keine Scrollerei
> 
> 2. **Ampel-Logik sofort erkennbar:**
>    - Grün, Gelb, Rot sind visuell klar
>    - Farbenblinde können auch Symbole erkennen (✓, !, ⚠)
> 
> 3. **Kritische Metriken prominent:**
>    - SPI und CPI oben (wichtigste KPIs zuerst)
>    - API-Problem rot gekennzeichnet (HOCHSTe Priorität)
> 
> 4. **Kontext + Aktion:**
>    - Nicht nur „SPI = 0,933" sondern auch: „Was bedeutet das? Was tun?"
>    - „RCA durchführen" → konkrete nächste Aktion
> 
> 5. **Trend-Pfeile:**
>    - ↓ (SPI fällt) = Problem wird schlimmer
>    - → (Defect Rate stabil) = OK
>    - ↑ (Scope-Creep steigt) = Problem wächst
> 
> 6. **Earned Value Grafik:**
>    - Visuelle Darstellung besser als reine Zahlen
>    - Prognose sichtbar (noch ca. 2–3 Wochen Verzug)
> 
> 7. **Actionable Insights:**
>    - Nicht nur Status zeigen, sondern: „Was müssen wir TUN?"
>    - Konkrete Meetings + Zeiten
> 
> **Häufige Dashboard-Fehler zu vermeiden:**
> 
> ❌ Zu viele Farben (Rainbow-Effekt)
> ✅ **Richtig**: Max. 3 Farben (Grün/Gelb/Rot)
> 
> ❌ Zu viele Metriken (20+)
> ✅ **Richtig**: 5–7 Kernmetriken, Detai ls in Anlagen
> 
> ❌ Statische Snapshots ohne Trend
> ✅ **Richtig**: Pfeile/Trend-Linien zeigen Entwicklung
> 
> ❌ Schöne Grafiken ohne Konsequenz
> ✅ **Richtig**: Dashboard führt zu Aktion/Meeting

---

## Lösung Aufgabe 6 & 7 (Gekürzt)

Aufgrund der Länge fokussiere ich hier auf die Kernpunkte:

### Lösung Aufgabe 6: Frühwarnsystem

**Beispiel-Frühwarnsystem für SaaS-Projekt:**

| Bereich | Leading Indicator | Schwellenwert GELB | Schwellenwert ROT | Reaktion GELB | Reaktion ROT |
|---------|-------------------|:--:|:--:|---|---|
| **Zeit** | Burndown-Trend (2 Wo.) | SPI <0,95 | SPI <0,90 | Weekly Review | Tägliches Standup + Scope-Anpassung |
| **Zeit** | Puffer-Verbrauch | Puffer <50% | Puffer <20% | Risikoanalyse | Change-Control + Deadline-Verschiebung |
| **Kosten** | CPI-Trend | CPI <0,97 | CPI <0,90 | Budget-Review | Ressourcen-Reallokation |
| **Kosten** | Burn-Rate Anstieg | +15% zu Baseline | +30% zu Baseline | Kostenanalyse | Financial Alert an CFO |
| **Qualität** | Defect-Anstieg pro Sprint | +50% zum Avg | +100% zum Avg | QA-Ressourcen erhöhen | Sprint-Stop, massive QA-Maßnahmen |
| **Team** | Overtime >15%/Woche | 15–20 Std. | >20 Std. | Workload-Review | Ressourcen-Aufstockung notwendig |
| **Team** | Krankenstand | >10% Team | >20% Team | HR-Support anfordern | Notfall-Ressourcen-Plan |

**Automatisierter Workflow in YouTrack:**

```
TRIGGER: Custom Field "Weekly Burn Rate" updated
  ↓
IF Burnrate_Current / Burnrate_Baseline < 0,95
  AND Duration > 2 weeks
  ↓ THEN
  Set Issue Status = "FLAG – YELLOW"
  Assign to Projectmanager
  Email Alert: "SPI < 0,95 für 2 Wochen"
  
IF Burnrate_Current / Burnrate_Baseline < 0,90
  ↓ THEN
  Set Issue Status = "FLAG – RED"
  Escalate to Program Manager
  Create Jira Ticket: "SPI RED – RCA erforderlich"
  Trigger Daily Standup Notification
```

---

### Lösung Aufgabe 7: YouTrack-Integration

**YouTrack-Konfiguration für Projektsteuerung:**

**Custom Fields:**
- `Effort_Estimate` (Story Points)
- `Time_Spent` (tatsächliche Stunden)
- `Burn_Priority` (Critical / High / Medium / Low)
- `KPI_Category` (Schedule / Cost / Quality / Team)

**Reports & Dashboards:**
1. **Burn-Down-Chart** (Auto): Tägliche Aktualisierung basierend auf Issue-Abschlüssen
2. **Velocity-Tracking**: SP/Sprint über die Zeit
3. **Defect-Dashboard**: Offene Bugs nach Priorität
4. **Resource-Report**: Time-Spent pro Person vs. Estimate

**Workflow für Frühwarnung:**
- Rule: IF Issue offen > 10 Tage AND Time_Spent > 2× Estimate → TAG = "AT_RISK"
- Dashboard-Widget zeigt "AT_RISK"-Issues prominent an (Rot)

---

## Zusammenfassung: Lern-Checkliste

Nach Abschluss aller Lösungen beherrschen Sie:

✓ **Soll-Ist-Vergleiche** durchführen und Abweichungen quantifizieren  
✓ **KPIs** mit Toleranzbereichen definieren und tracken  
✓ **Trends** extrapolieren und Prognosen erstellen  
✓ **Statusberichte** strukturiert verfassen  
✓ **Dashboards** mit Ampel-Logik gestalten  
✓ **Frühwarnsysteme** konzipieren  
✓ **YouTrack** zur automatisierten Datenerfassung nutzen  

---

