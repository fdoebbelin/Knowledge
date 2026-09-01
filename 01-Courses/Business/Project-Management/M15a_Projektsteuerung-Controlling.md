## Modulübersicht und Lernziele

Dieses Modul behandelt die **Überwachung und Steuerung von Projekten während der Durchführungsphase**. Nach Abschluss dieses Moduls sind Sie in der Lage:

- **Soll-Ist-Vergleiche** systematisch durchzuführen und Abweichungen zu erkennen
- **Fortschrittsmessungen** objektiv zu ermitteln und zu dokumentieren
- **Kennzahlen (KPIs)** für Projekte zu definieren und regelmäßig zu tracken
- **Statusberichte** aussagekräftig zu verfassen und an Stakeholder zu kommunizieren
- **Trendanalysen** durchzuführen und Frühwarnsysteme aufzubauen
- **Projekt-Dashboards** zu entwickeln und zu pflegen
- **Korrekturmaßnahmen** basierend auf Datenanalyse einzuleiten

Diese Kompetenzen sind essentiell für die **aktive Projektsteuerung** und ermöglichen es Ihnen, Projekte proaktiv in die richtige Richtung zu lenken, bevor Probleme kritisch werden.

---

## Abgrenzung und Kontext

**Projektsteuerung (Controlling) vs. verwandte Begriffe:**

| Begriff | Definition | Fokus |
|---------|-----------|-------|
| **Monitoring** | Regelmäßige Erfassung von Ist-Daten (z. B. Aufwand, Zeit, Kosten) | Informationsbeschaffung |
| **Controlling** | Soll-Ist-Vergleich, Analyse, Bewertung und Ableitung von Maßnahmen | Entscheidungsunterstützung |
| **Steuerung** | Umsetzung von Korrektur- und Anpassungsmaßnahmen auf Basis der Controlling-Erkenntnisse | Handlung und Anpassung |
| **Reporting** | Aufbereitung und Kommunikation von Projektfortschritt an Stakeholder | Transparenz und Kommunikation |

Im Praxisalltag werden diese Begriffe oft zusammengefasst als **„Projektcontrolling"** oder **„Projektsteuerung"**, meinen aber einen integrierten Prozess.

---

## Thematische Schwerpunkte

### 1. Soll-Ist-Vergleich und Fortschrittsmessung

#### Grundkonzept
Die **Fortschrittsmessung** beantwortet die zentrale Frage: *"Wo stehen wir aktuell im Projekt, und wo sollten wir sein?"*

**Drei Dimensionen der Fortschrittsmessung:**

- **Zeitfortschritt**: Sind wir im Zeitplan? (geplante vs. tatsächliche Dauer von Aktivitäten und Meilensteinen)
- **Leistungsfortschritt (Scope)**: Haben wir die vereinbarten Inhalte erbracht? (fertiggestellte Deliverables, Umfangsabweichungen)
- **Kostenfortschritt**: Sind wir im Budget? (geplante vs. tatsächliche Kosten, Abweichungen)

#### Methoden der Fortschrittsmessung

**a) Prozentuale Fertigstellung (Fertigstellungsgrad)**
- Einfachste Methode, aber oft subjektiv
- Beispiel: „Die Softwareentwicklung ist zu 75 % abgeschlossen"
- **Vorsicht**: Häufige Verzerrung gegen Ende (z. B. letzten 10 % dauern länger)

**b) Meilenstein-basierte Messung**
- Ein Meilenstein gilt als erreicht oder nicht (0–100 %)
- Objektiver und nachvollziehbarer
- Beispiel: Meilenstein „Testfreigabe" ist entweder erreicht oder nicht

**c) Earned Value Messung (wird in Modul 9 tiefgehend behandelt)**
- Verbindet Zeit, Umfang und Kosten in einer integrierten Metrik
- Earned Value (EV) = geplante Kosten für die bis dato fertiggestellten Arbeiten
- Ermöglicht frühe Trendprognosen

**d) Aktivitäts- und Phasen-basierte Messung**
- Nachverfolgung abgeschlossener Aktivitäten im Netzplan
- Pufferprogress (verbleibende Puffer vs. geplante Puffer)

#### Soll-Ist-Vergleich durchführen

**Schritt-für-Schritt-Prozess:**

1. **Sollwerte definieren**: Projektzeitplan, Budget, Scope-Statement als Referenz festlegen
2. **Istwerte erfassen**: Aktuelle Meldungen vom Team sammeln (Aufwand, Fertigstellung, Kosten)
3. **Abweichungen berechnen**: Differenzen quantifizieren (absolut und prozentual)
4. **Abweichungen bewerten**: Sind Abweichungen tolerierbar (Toleranzbereich)?
5. **Ursachen analysieren**: Root-Cause-Analyse für signifikante Abweichungen
6. **Maßnahmen ableiten**: Korrekturmaßnahmen oder Change Requests entwickeln

**Beispiel: Zeitabweichung**
```
Geplante Fertigstellung: 15.11.2025
Aktuelle Prognose: 25.11.2025
Zeitabweichung: +10 Tage (66 % über Plan)
```

---

### 2. KPI-Definition und Performance-Tracking

#### Was sind KPIs? (Key Performance Indicators)

KPIs sind **messbare Größen**, die den Erfolg oder die Leistung eines Projekts abbilden. Sie sind:

- **Spezifisch**: Klar definiert und eindeutig verständlich
- **Messbar**: Quantitativ erfassbar oder zumindest objektivierbar
- **Relevant**: Direkt verbunden mit Projektzielen
- **Zeitgebunden**: Mit konkretem Zeitraum und Messhäufigkeit
- **Actionable**: Leiten konkrete Maßnahmen ab, wenn Schwellenwerte über- oder unterschritten werden

#### Typische Projekt-KPIs

| KPI-Kategorie            | Beispiele                                                                        | Zielwert / Toleranzbereich    |
| ------------------------ | -------------------------------------------------------------------------------- | ----------------------------- |
| **Zeit (Schedule)**      | Schedule Performance Index (SPI), Meilenstein-Pünktlichkeit, verbleibende Puffer | SPI ≥ 1,0 oder Toleranz ±5 %  |
| **Kosten (Budget)**      | Cost Performance Index (CPI), Budget Variance, Burn-Rate                         | CPI ≥ 1,0 oder Toleranz ±10 % |
| **Scope**                | Anforderungsänderungen pro Woche, Scope-Creep-Rate, Anforderungserfüllung        | <2 Changes/Woche              |
| **Qualität**             | Defectrate, Test-Coverage, Fehlerquote, Rework-%                                 | <5 % Fehlerquote              |
| **Ressourcen**           | Ressourcenauslastung, Fluktuation, Kapazitätsengpässe                            | 85–95 % Auslastung            |
| **Risiken**              | Offene Risikoanzahl, Risikoexposition (Wert), Maßnahmenumsetzung                 | Alle Hochrisiken adressiert   |
| **Team & Kommunikation** | Meeting-Beteiligung, Dokumentations-Vollständigkeit, Stakeholder-Zufriedenheit   | >90 % Zufriedenheit           |

#### KPIs festlegen: Praktische Vorgehensweise

1. **Projektspezifische Ziele** identifizieren (aus Charter und Anforderungen)
2. **Kritische Erfolgsfaktoren (CSFs)** ableiten: Welche Faktoren sind entscheidend?
3. **Pro CSF 1–2 KPIs** definieren: Zu viele KPIs führen zu Überlastung
4. **Messbarkeit sichern**: Klare Formeln, Datenquellen, Verantwortlichkeiten
5. **Toleranzbereiche** setzen: Was ist akzeptabel (Grün), was warnt (Gelb), was ist kritisch (Rot)?
6. **Reporting-Rhythmus** festlegen: Wöchentlich, täglich, oder bedarfsgerecht?

**Beispiel: KPI für ein IT-Projekt**
```
KPI: Schedule Performance Index (SPI)
Definition: EV / PV (Earned Value / Planned Value)
Zielwert: 1,0 (exakt im Plan)
Grüner Bereich: 0,95 – 1,05 (±5 % Toleranz)
Gelber Bereich: 0,90 – 0,94 oder 1,06 – 1,10
Roter Bereich: < 0,90 oder > 1,10
Gemessen: Wöchentlich, jeden Freitag 14:00 Uhr
Verantwortlich: Projektmanager
```

#### KPI-Tracking in der Praxis

- **Messpunkte definieren**: Zeitliche Abstände (täglich, wöchentlich, monatlich)
- **Datenquellen**: Woher kommen die Daten? (Zeiterfassung, Bug-Tracker, Finanz-System, Umfragen)
- **Visuelle Darstellung**: Trend-Charts, Ampel-Dashboards
- **Automatisierung**: Tools verwenden (z. B. Jira für Defects, SAP für Kosten, Timesheet-Systeme)
- **Schwellenwerte und Alerts**: Automatische Benachrichtigungen bei Grenzwertüberschreitung

---

### 3. Trendanalyse und Frühwarnsysteme

#### Wozu Trendanalyse?

Eine **Trendanalyse** extrapoliert historische Daten in die Zukunft, um frühzeitig Probleme zu erkennen:

- *"Wenn die Entwicklung so weitergeht, wann werden wir das Budget überschritten haben?"*
- *"Wie wird der aktuelle Verzug bis zum Projektende auswirken?"*

#### Methoden der Trendanalyse

**1. Grafische Trend-Darstellung**
- Zeitreihen-Plot: Kumulative Earned Value vs. Geplante Value (S-Kurven-Vergleich)
- Burn-Down-Chart: Verbleibende Aufgaben vs. Zeit
- Burn-Rate: Kostenabbrand pro Woche/Monat

**2. Lineare Regression / Trendlinie**
- Einfache mathematische Extrapolation: `y = ax + b`
- Zeigt grafisch, wo die Trendlinie endet (Prognose der Fertigstellung)

**3. Earned Value Prognosen**
- **Estimate at Completion (EAC)**: Prognostizierte Gesamtkosten am Ende
- **Estimate to Complete (ETC)**: Noch erforderliche Kosten bis Abschluss
- **Schedule Estimate at Completion (SEAC)**: Prognostiziertes Enddatum

**Formeln (vereinfacht):**
```
EAC = BAC / CPI  (wenn derzeitiger CPI konstant bleibt)
ETC = EAC – AC   (Remaining costs)
```

#### Frühwarnsysteme aufbauen

Ein **Frühwarnsystem** erkennt potenziellen Probleme rechtzeitig, bevor sie kritisch werden.

**Elemente eines Frühwarnsystems:**

| Element | Beschreibung | Beispiel |
|---------|-------------|---------|
| **Indikator** | Messgröße, die ein Problem signalisiert | SPI < 0,95, 3 Tage Verzug hintereinander |
| **Schwellenwert** | Grenzwert, ab dem Warnung ausgelöst wird | SPI ≤ 0,90 = Rot |
| **Reaktion** | Automatische oder manuelle Aktion | Alert an PM, automatische Email |
| **Verursacher** | Wer wird benachrichtigt? | Projektmanager, Lenkungsausschuss |
| **Maßnahmen** | Was tun bei Warnung? | Eskalation, Change-Request, Ressourcenumverteilung |

**Praktisches Frühwarnsystem für Time-Box:**
```
Regel: Wenn ein Meilenstein 5 Tage hintereinander nicht erreicht wird → GELB
Regel: Wenn ein Meilenstein 10 Tage hintereinander nicht erreicht wird → ROT (Eskalation)
```

---

### 4. Projekt-Dashboards und Reporting

#### Was ist ein Projekt-Dashboard?

Ein **Dashboard** ist eine **visuelle, kompakte Zusammenfassung** der wichtigsten Projektmetriken. Es ermöglicht einen Überblick auf einen Blick.

**Zweck:**
- Schnelle Erfassung des Projektstatus
- Identifikation von Problemfeldern
- Unterstützung von Entscheidungsfindung in Meetings

#### Dashboard-Elemente und Design

**1. Ampel-Status (Traffic Light)**
- Grün: Alles im Plan, keine Maßnahmen nötig
- Gelb: Abweichungen, aber unter Kontrolle; Monitoring verstärken
- Rot: Kritische Abweichung; Korrekturmaßnahmen erforderlich

**2. Metriken und Kennzahlen**
- KPI-Boxes mit Istwert, Sollwert, Abweichung, Trend (Pfeil ↑ ↓ →)
- Beispiel:
  ```
  ╔═══════════════════════╗
  ║ Kostenfortschritt     ║
  ║ 450.000 € / 500.000 € ║
  ║ 90 % ↓ (Grün)         ║
  ╚═══════════════════════╝
  ```

**3. Trend-Charts**
- S-Kurven-Vergleich (Earned Value vs. Planned Value)
- Burn-Down-Charts
- Zeitliche Entwicklung von Risiken

**4. Milestone-Tracking**
- Übersicht geplanter vs. tatsächlicher Meilenstein-Termine
- Status-Anzeige (Erreicht / In Progress / Verzögert)

**5. Risiko-Übersicht**
- Anzahl offener Risiken nach Priorität
- Top-3 Risiken mit Maßnahmenstatus

**6. Ressourcen-Auslastung**
- Grafische Darstellung der geplanten vs. aktuellen Auslastung

**7. Änderungen und Probleme**
- Offene Change Requests
- Offene Issues und deren Status

#### Dashboard-Design Best Practices

| Best Practice | Erklärung |
|--------------|-----------|
| **„One Page"** | Dashboard sollte auf eine Seite passen, ohne zu scrollen |
| **Farb-Effizienz** | Max. 3 Farben (Grün, Gelb, Rot); ausreichend Kontrast für Farbenblinde |
| **Aussagekräftige Titel** | Überschriften klar, keine Mehrdeutigkeit |
| **Zeitstempel** | Wann wurde das Dashboard zuletzt aktualisiert? |
| **Drill-Down-Möglichkeit** | Verlinkt zu detaillierten Reports für Interessierte |
| **Konsistenz** | Gleiche KPIs in jedem Weekly Report; Zeitreihe vergleichbar |

#### Statusberichte (Status Reports)

Ein **Statusbericht** ist die **textlich-narrative Ergänzung** zum Dashboard.

**Struktur eines wöchentlichen Statusberichts:**

```
1. Zusammenfassung (Executive Summary)
   - Projektstatus in 3–5 Sätzen
   - Kritische Issues oder Änderungen

2. Fortschritt (Progress)
   - Zeitfortschritt (% abgeschlossene Aktivitäten, Meilenstein-Status)
   - Leistung in dieser Woche (Was wurde erreicht?)
   - Geplante Aktivitäten für nächste Woche

3. Kennzahlen & Metriken
   - Tabelle oder Grafik mit KPIs und Trends
   - Vergleich zu Baseline

4. Risiken & Probleme (Issues)
   - Neue Risiken, die diese Woche identifiziert wurden
   - Offene Issues und deren Auswirkungen
   - Aktueller Stand von Hochrisiken

5. Änderungen & Change Requests
   - Neu eingegangene Change Requests
   - Genehmigte Änderungen dieser Woche

6. Personalressourcen
   - Auslastung, geplante Abgänge/Neueinsteiger
   - Engpässe

7. Nächste Schritte & Ausblick
   - Kritische Aktivitäten der nächsten 2 Wochen
   - Geplante Meilensteine
   - Verbesserungsmaßnahmen aus der letzten Woche

8. Anhang (optional)
   - Detaillierte Grafiken
   - Risikoregister (Auszug)
```

**Tipps für aussagekräftige Statusberichte:**
- **Konzise**: Max. 2–3 Seiten; Details in Anlagen
- **Zahlen statt Bauchgefühl**: Datengestützte Aussagen
- **Sprechende Überschriften**: z. B. „Zeitverzug von 5 Tagen gefährdet Q4-Meilenstein"
- **Leicht lesbar**: Absätze, Bullets, Tabellen
- **Zielgruppe beachten**: Technische vs. Management-Berichte unterscheiden

---

## Integrierte Projektsteuerung: Der Regelkreis

Projektsteuerung ist ein **kontinuierlicher Prozess**, kein einmaliges Ereignis:

```
┌─────────────────────────────────────────────────────┐
│         PROJEKTSTEUERUNG – REGELKREIS               │
├─────────────────────────────────────────────────────┤
│                                                     │
│  1. DATENERFASSUNG (Monitoring)                     │
│     ↓ Ist-Daten sammeln (Aufwand, Kosten, Zeit)     │
│                                                     │
│  2. ANALYSE (Controlling)                           │
│     ↓ Soll-Ist-Vergleich, KPI-Berechnung,           │
│       Trend- und Root-Cause-Analyse                 │
│                                                     │
│  3. BEWERTUNG (Controlling)                         │
│     ↓ Abweichungen bewerten, Kritikalität           │
│       (Grün/Gelb/Rot), Entscheidungsbedarf          │
│                                                     │
│  4. BERICHTERSTATTUNG (Reporting)                   │
│     ↓ Dashboard, Statusbericht, Eskalation          │
│                                                     │
│  5. STEUERUNG (Steering)                            │
│     ↓ Korrekturmaßnahmen einleiten                  │
│       (z. B. Ressourcenumverteilung, Scope-         │
│       Anpassung, Verzögerungsausgleich)             │
│                                                     │
│  6. UMSETZUNG (Execution)                           │
│     ↓ Team setzt Maßnahmen um                       │
│                                                     │
│  → Zurück zu Schritt 1 (Monitoring)                 │
│                                                     │
└─────────────────────────────────────────────────────┘
```

**Typischer Rhythmus:**
- **Tägliches Monitoring**: Kurzes Standup, Statuserfassung
- **Wöchentliche Kontrolle**: Vollständiger Soll-Ist-Vergleich, Statusbericht
- **Monatliche Lenkungssitzung**: Strategische Anpassungen, Change-Entscheidungen
- **Ad-hoc-Eskalation**: Bei kritischen Abweichungen sofort reagieren

---

## Praktische Hinweise

### Häufige Anfängerfehler

1. **Zu subjektive Fortschrittsschätzung**
   - Falsch: „Ich schätze, die Entwicklung ist 80 % fertig"
   - Richtig: „Von den 15 geplanten Komponenten sind 12 fertiggestellt und getestet (80 %)"

2. **Zu viele KPIs**
   - Falsch: 30 verschiedene Kennzahlen tracken
   - Richtig: 5–7 kritische KPIs pro Projekt

3. **Dashboards ohne Konsequenz**
   - Falsch: Schöne Grafiken, aber keine Maßnahmen ableiten
   - Richtig: Bei Rot-Status erfolgt sofort Reaktion

4. **Lagging vs. Leading Indicators verwechseln**
   - Lagging: Zeigen Problem (zu spät): z. B. Verzug ist da
   - Leading: Vorhersagen Problem (rechtzeitig): z. B. Burndown-Rate sinkt

5. **Stakeholder nicht eingebunden**
   - Falsch: Statusbericht nur an PM
   - Richtig: Regelmäßige Reports an Lenkungsausschuss, Kunde, Team

### Tipps zum Einstieg

- **Mit wenigen Metriken starten**: Z. B. Zeit, Kosten, Qualität
- **Einfache Tools nutzen**: Spreadsheet (Excel) reicht zu Anfang; später speziale PM-Tools
- **Automatisieren**: Zeiterfassungssysteme, Bug-Tracker liefern Daten
- **Regelmäßig reflektieren**: „Nutzen die Stakeholder meine Reports? Sind die KPIs aussagekräftig?"
- **Mit dem Team kommunizieren**: KPIs und Maßnahmen transparent machen

---

## YOUTRACK-Integration

**YouTrack** ist ein **Projekt- und Issue-Tracking-System**, das zur Unterstützung der Projektsteuerung herangezogen werden kann:

- **Automatische Erfassung**: Aufgabenstatus, Zeitschätzungen, tatsächlicher Aufwand → automatische Datenerfassung
- **Kennzahlen**: Burn-Down-Charts, Velocity-Tracking, Defect-Raten basierend auf Issues
- **Berichte**: Automatisierte Statusreports aus Issue-Daten
- **Frühwarnung**: Custom-Workflows für Schwellenwertüberschreitung (z. B. Red-Issue nach 5 Tagen offen)

Im praktischen Projektbeispiel dieses Kurses werden Sie YouTrack nutzen, um:
1. Projekttasks zu erfassen und zu tracken
2. Automated Reports zu Fortschritt und KPIs zu generieren
3. Frühe Warnungen bei abweichenden Metriken zu konfigurieren

---

## Wichtige Begriffe (Glossar)

| Begriff | Definition |
|---------|-----------|
| **Soll-Ist-Abweichung** | Differenz zwischen geplanten (Sollwert) und tatsächlichen (Istwert) Metriken |
| **Schedule Variance (SV)** | Zeitabweichung im Earned Value Management (EV – PV) |
| **Cost Variance (CV)** | Kostenabweichung im EVM (EV – AC) |
| **KPI** | Kennzahl, die die Leistung eines Projekts misst |
| **Burn-Down-Chart** | Grafik, die verbleibende Arbeit vs. Zeit darstellt (abnehmender Trend gewünscht) |
| **Trend** | Entwicklungsrichtung über Zeit (ansteigend, fallend, konstant) |
| **Frühwarnsystem** | Prozess, der potenzielle Probleme vor deren Eintritt signalisiert |
| **Dashboard** | Visuelle, kompakte Zusammenfassung von Projektmetriken |
| **Statusbericht** | Schriftliche Zusammenfassung des Projektstatus für Stakeholder |
| **Eskalation** | Weitergabe eines kritischen Problems an höhere Managementebene |
| **Root-Cause-Analyse** | Methode, um die Grundursache eines Problems zu ermitteln |
| **Earned Value (EV)** | Bewertung der bis dato geleisteten Arbeit zu Plankosten |
| **Performance Index** | Verhältnis (Index) zwischen tatsächlicher und geplanter Leistung (SPI, CPI) |
| **Baseline** | Genehmigter Plan (Zeit, Kosten, Scope) als Vergleichsmaßstab |

---

## Weiterführende Ressourcen

- **PMBOK Guide (Project Management Institute)**: Kapitel „Monitoring & Controlling Process Group"
- **PRINCE2 (OGC)**: Concept of „Progress Control"
- **Earned Value Management**: Standard-Methode für integriertes Projektcontrolling
- **Branchenstandards**: Agile Boards (Jira, Trello) vs. klassische Methoden (MS Project, Smartsheet)

---

## Reflexionsfragen

1. Welche zwei Dimensionen der Fortschrittsmessung sind in Ihrem Projekt am kritischsten?
2. Welche KPIs würden Sie für ein IT-Implementierungsprojekt definieren?
3. Wie würden Sie ein Frühwarnsystem für Kostenüberschreitungen aufbauen?
4. Welche Informationen sollten in einem monatlichen Statusbericht an den Lenkungsausschuss enthalten sein?
5. Wie unterscheidet sich die Steuerung von klassischen vs. agilen Projekten?

