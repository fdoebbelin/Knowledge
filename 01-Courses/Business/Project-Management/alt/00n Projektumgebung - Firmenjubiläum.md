
## Komplette Einrichtungsanleitung für UE 2 Übungen (Module 4-10)

---

## 1. PROJEKT ERSTELLEN

### Schritt 1.1: Neues Projekt anlegen
**Menüpfad:** `Projekt` > `Projekte` > `Neues Element erstellen` (+)

**Projektdaten eingeben:**
```
Projektname: Firmenjubiläum 25 Jahre
Projektcode: FJ25
Projekttyp: Event-Management
Projektstatus: Initialisierung
Projektleiter: [Ihr Name]
Beschreibung: Organisation der 25-Jahr-Feier des Unternehmens mit Festakt, 
             Kundenevent und Mitarbeiterfeier
```

**Projektlaufzeit:**
```
Projektstart: 01.07.2025
Geplantes Ende: 15.10.2025
Gesamtdauer: 15 Wochen
Budget: 85.000 €
```

### Schritt 1.2: Projektstruktur definieren
**Menüpfad:** `Projekt` > `Projektstruktur` > `WBS definieren`

---

## 2. ARBEITSPAKET-STRUKTUR (WBS) ERSTELLEN

### Menüpfad: `Planung` > `Aktivitäten` > `Neue Aktivität`

#### 2.1 Hauptarbeitspakete (Level 1)

**AP 1: Projektplanung und Konzeption**
```
WBS-Code: 1.0
Typ: Arbeitspaket
Dauer: 3 Wochen
Aufwand: 120 Stunden
Verantwortlicher: Projektleiter
```

**AP 2: Location und Catering**
```
WBS-Code: 2.0
Typ: Arbeitspaket
Dauer: 4 Wochen
Aufwand: 80 Stunden
Verantwortlicher: Event-Manager
```

**AP 3: Marketing und Kommunikation**
```
WBS-Code: 3.0
Typ: Arbeitspaket
Dauer: 6 Wochen
Aufwand: 160 Stunden
Verantwortlicher: Marketing-Lead
```

**AP 4: Programm und Entertainment**
```
WBS-Code: 4.0
Typ: Arbeitspaket
Dauer: 5 Wochen
Aufwand: 100 Stunden
Verantwortlicher: Programm-Manager
```

**AP 5: Technik und Ausstattung**
```
WBS-Code: 5.0
Typ: Arbeitspaket
Dauer: 3 Wochen
Aufwand: 60 Stunden
Verantwortlicher: Technik-Lead
```

**AP 6: Durchführung Event**
```
WBS-Code: 6.0
Typ: Arbeitspaket
Dauer: 1 Woche
Aufwand: 200 Stunden
Verantwortlicher: Event-Koordinator
```

#### 2.2 Unterarbeitspakete (Level 2) - Beispiel für AP 1

**AP 1.1: Kick-off und Stakeholder-Analyse**
```
WBS-Code: 1.1
Übergeordnet: 1.0
Dauer: 1 Woche
Aufwand: 40 Stunden
```

**AP 1.2: Konzepterstellung**
```
WBS-Code: 1.2
Übergeordnet: 1.0
Dauer: 1,5 Wochen
Aufwand: 60 Stunden
```

**AP 1.3: Budget- und Ressourcenplanung**
```
WBS-Code: 1.3
Übergeordnet: 1.0
Dauer: 0,5 Wochen
Aufwand: 20 Stunden
```

---

## 3. MEILENSTEINE DEFINIEREN

### Menüpfad: `Planung` > `Meilensteine` > `Neuer Meilenstein`

```
M1: Projektfreigabe
Datum: 22.07.2025
Abhängig von: AP 1.3

M2: Location bestätigt
Datum: 19.08.2025
Abhängig von: AP 2.0

M3: Marketing-Material freigegeben
Datum: 02.09.2025
Abhängig von: AP 3.0

M4: Technik-Setup abgeschlossen
Datum: 30.09.2025
Abhängig von: AP 5.0

M5: Event erfolgreich durchgeführt
Datum: 15.10.2025
Abhängig von: AP 6.0
```

---

## 4. RESSOURCEN EINRICHTEN

### Schritt 4.1: Personelle Ressourcen
**Menüpfad:** `Ressourcen` > `Personen` > `Neue Person`

```
1. Max Mustermann - Projektleiter
   Kostensatz: 85 €/h
   Verfügbarkeit: 100%
   Skills: Projektmanagement, Event-Management

2. Lisa Schmidt - Event-Manager
   Kostensatz: 65 €/h
   Verfügbarkeit: 80%
   Skills: Location-Management, Catering

3. Tom Weber - Marketing-Lead
   Kostensatz: 70 €/h
   Verfügbarkeit: 60%
   Skills: Marketing, Design, Kommunikation

4. Anna Klein - Programm-Manager
   Kostensatz: 60 €/h
   Verfügbarkeit: 50%
   Skills: Entertainment, Moderation

5. Peter Müller - Technik-Lead
   Kostensatz: 75 €/h
   Verfügbarkeit: 40%
   Skills: Veranstaltungstechnik, AV-Equipment
```

### Schritt 4.2: Materielle Ressourcen
**Menüpfad:** `Ressourcen` > `Material` > `Neues Material`

```
1. Event-Location
   Typ: Externe Ressource
   Kosten: 15.000 €
   Verfügbarkeit: Nach Buchung

2. Catering-Service
   Typ: Externe Dienstleistung
   Kosten: 25.000 €
   Für: 500 Personen

3. AV-Equipment
   Typ: Miete
   Kosten: 8.000 €
   Dauer: 3 Tage

4. Marketing-Material
   Typ: Produktionskosten
   Kosten: 12.000 €
   Umfang: Print + Digital
```

---

## 5. KOSTENPLANUNG ERSTELLEN

### Menüpfad: `Kontrolle` > `Kosten` > `Kostenplanung`

#### 5.1 Kostenschätzung nach Arbeitspaketen

**AP 1: Projektplanung**
```
Personalkosten: 120h × 85 €/h = 10.200 €
Materialkosten: 800 €
Gesamt: 11.000 €
```

**AP 2: Location und Catering**
```
Personalkosten: 80h × 65 €/h = 5.200 €
Location: 15.000 €
Catering: 25.000 €
Gesamt: 45.200 €
```

**AP 3: Marketing**
```
Personalkosten: 160h × 70 €/h = 11.200 €
Material/Produktion: 12.000 €
Gesamt: 23.200 €
```

**AP 4: Programm**
```
Personalkosten: 100h × 60 €/h = 6.000 €
Entertainment-Kosten: 8.000 €
Gesamt: 14.000 €
```

**AP 5: Technik**
```
Personalkosten: 60h × 75 €/h = 4.500 €
Equipment-Miete: 8.000 €
Gesamt: 12.500 €
```

**AP 6: Durchführung**
```
Personalkosten: 200h × Mischsatz 65 €/h = 13.000 €
Gesamt: 13.000 €
```

**Gesamtkosten: 118.900 €**
**Budget: 85.000 €**
**Überschreitung: 33.900 € (40%)**

---

## 6. ABHÄNGIGKEITEN DEFINIEREN

### Menüpfad: `Planung` > `Abhängigkeiten` > `Neue Abhängigkeit`

```
AP 1.3 → AP 2.0 (Ende-Anfang)
AP 2.0 → AP 3.0 (Ende-Anfang, Verzögerung: 1 Woche)
AP 1.0 → AP 4.0 (Ende-Anfang)
AP 4.0 → AP 5.0 (Ende-Anfang, Verzögerung: 2 Wochen)
AP 2.0, AP 3.0, AP 4.0, AP 5.0 → AP 6.0 (Ende-Anfang)
```

---

## 7. RISIKOMANAGEMENT EINRICHTEN

### Menüpfad: `Kontrolle` > `Risiken` > `Neues Risiko`

#### 7.1 Top-5 Projektrisiken

**Risiko 1: Wetterabhängigkeit**
```
Kategorie: Externe Risiken
Eintrittswahrscheinlichkeit: 30%
Schadenshöhe: 15.000 €
Risikostufe: Mittel
Maßnahme: Alternative Indoor-Location buchen
Verantwortlicher: Event-Manager
```

**Risiko 2: Key-Speaker Ausfall**
```
Kategorie: Personelle Risiken
Eintrittswahrscheinlichkeit: 20%
Schadenshöhe: 8.000 €
Risikostufe: Mittel
Maßnahme: Backup-Speaker identifizieren
Verantwortlicher: Programm-Manager
```

**Risiko 3: Budgetüberschreitung**
```
Kategorie: Finanzielle Risiken
Eintrittswahrscheinlichkeit: 70%
Schadenshöhe: 20.000 €
Risikostufe: Hoch
Maßnahme: Kostenkontrolle verschärfen, Sponsor suchen
Verantwortlicher: Projektleiter
```

**Risiko 4: Niedrige Teilnehmerzahl**
```
Kategorie: Marketing-Risiken
Eintrittswahrscheinlichkeit: 40%
Schadenshöhe: 12.000 €
Risikostufe: Mittel
Maßnahme: Verstärktes Marketing, Incentivierung
Verantwortlicher: Marketing-Lead
```

**Risiko 5: Technik-Ausfall**
```
Kategorie: Technische Risiken
Eintrittswahrscheinlichkeit: 25%
Schadenshöhe: 10.000 €
Risikostufe: Mittel
Maßnahme: Backup-Equipment, Vor-Ort-Techniker
Verantwortlicher: Technik-Lead
```

---

## 8. RACI-MATRIX ERSTELLEN

### ⚠️ WICHTIG: ProjeQtor hat keine native RACI-Matrix Funktion

**Empfohlene Umsetzung:**

#### Option A: Als Projektdokument
**Menüpfad:** `Planning` > `Projekte` > `[Firmenjubiläum]` > `Documents` > `New Document`

1. Excel-Vorlage der RACI-Matrix erstellen
2. Als Dokument im Projekt speichern
3. Versionierung über ProjeQtor-Dokumentenmanagement

#### Option B: Über Aktivitäten-Zuordnung
**Menüpfad:** `Planning` > `Activity` > `[Arbeitspaket auswählen]`

Für jedes Arbeitspaket in den Details definieren:
- **Responsible:** Hauptverantwortlicher
- **Assigned to:** Weitere Beteiligte
- **Notes:** Zusätzliche RACI-Informationen

#### RACI-Matrix Tabelle (als Excel/PDF-Dokument ins Projekt einbinden):

| Arbeitspaket | Projektleiter | Event-Mgr | Marketing | Programm | Technik |
|--------------|---------------|-----------|-----------|----------|---------|
| AP 1.1 Kick-off | A | R | C | C | I |
| AP 1.2 Konzept | A | C | C | C | I |
| AP 1.3 Budget | R | C | I | I | I |
| AP 2.1 Location | A | R | I | C | C |
| AP 2.2 Catering | A | R | I | C | I |
| AP 3.1 Marketing-Plan | C | I | A/R | I | I |
| AP 3.2 Material | I | C | A/R | I | I |
| AP 4.1 Programm | C | C | I | A/R | I |
| AP 4.2 Speaker | I | C | C | A/R | I |
| AP 5.1 AV-Technik | C | C | I | C | A/R |
| AP 6.1 Event-Tag | A | R | C | R | R |

**Legende:** R=Responsible, A=Accountable, C=Consulted, I=Informed

#### Praktische Umsetzung in ProjeQtor:
1. **Excel-Datei erstellen** mit obiger Tabelle
2. **Upload:** `Documents` > `Add Document` > RACI-Matrix.xlsx
3. **Verknüpfung:** Bei jedem Arbeitspaket im Feld "Responsible" den Hauptverantwortlichen eintragen

---

## 9. KOMMUNIKATIONSPLAN

### Menüpfad: `Kommunikation` > `Kommunikationsplan` > `Neuer Plan`

#### 9.1 Stakeholder definieren

```
1. Geschäftsführung
   Interesse: Hoch
   Einfluss: Hoch
   Kommunikation: Monatlicher Statusbericht

2. Mitarbeiter
   Interesse: Mittel
   Einfluss: Niedrig
   Kommunikation: Newsletter, Intranet

3. Kunden/Partner
   Interesse: Mittel
   Einfluss: Mittel
   Kommunikation: Einladungen, Website

4. Externe Dienstleister
   Interesse: Hoch
   Einfluss: Mittel
   Kommunikation: Wöchentliche Abstimmung

5. Medien
   Interesse: Niedrig
   Einfluss: Hoch
   Kommunikation: Pressemitteilung
```

#### 9.2 Kommunikationsmatrix

| Stakeholder | Was | Wann | Wie | Wer |
|-------------|-----|------|-----|-----|
| Geschäftsführung | Statusbericht | Monatlich | Präsentation | Projektleiter |
| Projektteam | Team-Updates | Wöchentlich | Meeting | Projektleiter |
| Mitarbeiter | Event-Info | Bi-wöchentlich | Newsletter | Marketing |
| Dienstleister | Koordination | Wöchentlich | E-Mail/Tel | Event-Manager |
| Kunden | Einladung | 6 Wochen vorher | Post/E-Mail | Marketing |

---

## 10. QUALITÄTSKRITERIEN DEFINIEREN

### Menüpfad: `Qualität` > `Qualitätskriterien` > `Neue Kriterien`

#### 10.1 Qualitätsziele

```
1. Teilnehmerzufriedenheit ≥ 4,5/5,0
   Messung: Feedback-Fragebogen
   Verantwortlich: Event-Manager

2. Budgeinhaltung ± 5%
   Messung: Kostencontrolling
   Verantwortlich: Projektleiter

3. Termingerechte Fertigstellung
   Messung: Meilenstein-Tracking
   Verantwortlich: Projektleiter

4. Medienresonanz > 10 Artikel
   Messung: Medien-Monitoring
   Verantwortlich: Marketing-Lead

5. Null Sicherheitsvorfälle
   Messung: Incident-Report
   Verantwortlich: Event-Manager
```

#### 10.2 Prüfpunkte

```
Gate 1: Konzeptfreigabe (nach AP 1.2)
Gate 2: Location-Bestätigung (nach AP 2.1)
Gate 3: Marketing-Freigabe (nach AP 3.2)
Gate 4: Technik-Abnahme (vor AP 6.0)
Gate 5: Post-Event-Review (nach AP 6.0)
```

---

## 11. PROJEKT-DASHBOARD KONFIGURIEREN

### Menüpfad: `Dashboard` > `Projekt-Dashboard` > `Konfigurieren`

#### 11.1 KPI-Auswahl

```
1. Projektfortschritt (%)
2. Budgetverbrauch vs. Fortschritt
3. Anzahl offene Risiken
4. Anzahl überfällige Aufgaben
5. Teammitglieder-Auslastung
6. Meilenstein-Status
7. Qualitätskennzahlen
8. Stakeholder-Zufriedenheit
```

#### 11.2 Dashboard-Widgets

```
- Gantt-Chart (Übersicht)
- Kosten-Trend-Diagramm
- Risiko-Matrix
- Aufgaben-Kanban-Board
- Ressourcen-Kalender
- Meilenstein-Timeline
```

---

## 12. CHANGE MANAGEMENT PROZESS

### Menüpfad: `Kontrolle` > `Änderungsanträge` > `Prozess definieren`

#### 12.1 Change Request Workflow

```
1. Antragstellung
   - Formular ausfüllen
   - Auswirkungsanalyse
   - Begründung

2. Bewertung
   - Kosten-Nutzen-Analyse
   - Risikobewertung
   - Ressourcenimpact

3. Entscheidung
   - Entscheidungsträger: Projektleiter
   - Bei >5.000€: Geschäftsführung
   - Dokumentation der Entscheidung

4. Umsetzung
   - Projektplan-Update
   - Stakeholder-Information
   - Monitoring
```

---

## 13. BERICHTSWESEN EINRICHTEN

### Menüpfad: `Berichte` > `Projektberichte` > `Templates erstellen`

#### 13.1 Statusbericht-Template

```
1. Executive Summary
2. Projektfortschritt (Meilensteine)
3. Kostenübersicht
4. Risiken und Issues
5. Nächste Schritte
6. Entscheidungsbedarf
```

#### 13.2 Automatische Berichte

```
- Wöchentlicher Team-Status
- Monatlicher Managementbericht
- Meilenstein-Report
- Risiko-Update
- Budget-Controlling
```

---

## 14. AGILE ELEMENTE INTEGRIEREN

### Schritt 14.1: User Stories definieren
**Menüpfad:** `Agile` > `User Stories` > `Neue Story`

```
Story 1: "Als Mitarbeiter möchte ich eine Einladung zum Firmenjubiläum 
         erhalten, damit ich teilnehmen kann."
Akzeptanzkriterien:
- Einladung 6 Wochen vor Event
- Alle relevanten Informationen enthalten
- RSVP-Möglichkeit vorhanden

Story 2: "Als Geschäftsführung möchte ich den Projektfortschritt 
         jederzeit einsehen können, damit ich rechtzeitig steuern kann."
Akzeptanzkriterien:
- Dashboard mit aktuellen KPIs
- Wöchentliche Status-Updates
- Frühwarnsystem bei Abweichungen
```

### Schritt 14.2: Kanban-Board erstellen
**Menüpfad:** `Agile` > `Kanban` > `Neues Board`

```
Spalten:
1. Backlog
2. In Planung
3. In Bearbeitung
4. Review
5. Abgeschlossen

WIP-Limits:
- In Planung: 3
- In Bearbeitung: 5
- Review: 2
```

---

## 15. PROJEKTABSCHLUSS VORBEREITEN

### Menüpfad: `Projektabschluss` > `Lessons Learned` > `Template erstellen`

#### 15.1 Lessons Learned Framework

```
1. Was lief gut?
   - Erfolgreiche Praktiken
   - Positive Überraschungen
   - Gut funktionierende Prozesse

2. Was lief schlecht?
   - Problembereiche
   - Verzögerungsursachen
   - Kostenüberschreitungen

3. Was haben wir gelernt?
   - Neue Erkenntnisse
   - Verbesserungsmöglichkeiten
   - Zukünftige Empfehlungen

4. Maßnahmen für nächste Projekte
   - Best Practices
   - Prozessverbesserungen
   - Checklisten-Updates
```

---

## 16. ÜBUNGSAUFGABEN FÜR UE 2 MODULE

### Modul 4 UE 2: Integrierte Projektplanung

**Aufgabe 1 (15 min): Ressourcenplanung**
- Ressourcen aus WBS ableiten
- Kapazitätsengpässe identifizieren
- Alternative Ressourcen planen

**Aufgabe 2 (15 min): Kostenplanung**
- 3-Punkt-Schätzung für AP 2 und AP 3
- Kostenoptimierung um 20%
- Risikopuffer berechnen

**Aufgabe 3 (10 min): RACI-Matrix**
- RACI für restliche Arbeitspakete
- Konfliktpotentiale identifizieren

**Aufgabe 4 (5 min): Integration**
- Konsistenzprüfung aller Pläne

### Modul 5 UE 2: Risikomanagement

**Aufgabe 1 (15 min): Risikoidentifikation**
- Brainstorming weitere Risiken
- Kategorisierung nach Risikotypen

**Aufgabe 2 (15 min): Risikobewertung**
- 5x5-Matrix für alle Risiken
- Top-10 Risiken priorisieren

**Aufgabe 3 (10 min): Maßnahmenplanung**
- Maßnahmen für Top-5 Risiken
- Verantwortlichkeiten zuweisen

**Aufgabe 4 (5 min): Monitoring**
- Frühindikatoren definieren

### Modul 6 UE 2: Projektcontrolling

**Aufgabe 1 (20 min): Status-Dashboard**
- KPIs für Firmenjubiläum definieren
- Dashboard-Design erstellen

**Aufgabe 2 (15 min): Earned Value Analyse**
- EVA-Berechnung für Woche 8
- Trend-Analyse erstellen

**Aufgabe 3 (10 min): Change Request**
- Änderungsantrag: "VIP-Area hinzufügen"
- Auswirkungsanalyse durchführen

### Modul 7 UE 2: Kommunikation

**Aufgabe 1 (15 min): Kommunikationsmatrix**
- Erweiterte Stakeholder-Analyse
- Kommunikationsplan detaillieren

**Aufgabe 2 (15 min): Konfliktlösung**
- Rollenspiel: Budget vs. Qualität
- Lösungsoptionen erarbeiten

**Aufgabe 3 (15 min): Meeting-Simulation**
- Projektstatusmeeting moderieren
- Entscheidungen dokumentieren

### Modul 8 UE 2: Agiles PM

**Aufgabe 1 (15 min): User Stories**
- Stories für alle Stakeholder
- Priorisierung nach Business Value

**Aufgabe 2 (20 min): Sprint-Simulation**
- 20-Min Sprint für "Marketing-Phase"
- Daily Scrum durchführen

**Aufgabe 3 (10 min): Retrospektive**
- Start-Stop-Continue für Projektteam

### Modul 9 UE 2: Projektabschluss

**Aufgabe 1 (20 min): Lessons Learned**
- Workshop-Moderation
- Erkenntnisse dokumentieren

**Aufgabe 2 (20 min): Abschlussbericht**
- Struktur für Abschlussbericht
- Erfolgsmessung definieren

**Aufgabe 3 (5 min): Reflexion**
- Persönliche Learnings

### Modul 10 UE 2: Präsentation

**Aufgabe 1 (45 min): Projekt präsentieren**
- 10-Min Präsentation des Firmenjubiläums
- Storytelling-Ansatz verwenden
- Lessons Learned integrieren

---

## 17. TIPPS FÜR PROJEQTOR-NUTZUNG

### Navigation
```
- Immer über Hauptmenü navigieren
- Breadcrumb-Navigation nutzen
- Suchfunktion für schnelles Finden
- Favoriten für häufig genutzte Ansichten
```

### Datenqualität
```
- Regelmäßige Daten-Updates
- Konsistente Namenskonventionen
- Vollständige Abhängigkeiten pflegen
- Status regelmäßig aktualisieren
```

### Performance
```
- Filter bei großen Datenmengen
- Archivierung alter Projekte
- Regelmäßige Datenbank-Wartung
- Optimierte Abfragen verwenden
```

### Backup & Sicherheit
```
- Regelmäßige Projekt-Exports
- Rollenbasierte Zugriffsrechte
- Passwort-Richtlinien beachten
- Audit-Trail aktivieren
```

---

**Hinweis:** Diese Projektumgebung ist als Übungsszenario für die praktischen Aufgaben der Module 4-10 konzipiert und enthält bewusst Herausforderungen (wie Budgetüberschreitung), um realistische Projektmanagement-Situationen zu simulieren.