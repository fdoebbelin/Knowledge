## Erfassung von Planning, Timesheet und Tickets

---

### 1. **PLANNING (Projektplanung)**

**Begriff:** Das Planning-Modul ist das Herzstück von ProjeQtor und ermöglicht die grafische Darstellung und Verwaltung der Projektplanung über Gantt-Charts und verschiedene Planungsansichten.

**Menüpfad:** `Planning` > `Gantt Planning view`

#### 1.1 Gantt Planning View öffnen:
```
Navigation: Planning > Gantt Planning view
Komponenten der Ansicht:
- Toolbar (Werkzeugleiste)
- Task List (WBS-Struktur)
- Gantt Chart View (Grafische Darstellung)
- Timeline (Zeitstrahl)
- Details Area (Detailbereich)
- Context Menu (Kontextmenü)
```

#### 1.2 Planning-Berechnungen starten:
```
Automatische Berechnung:
- Button: "Auto Run Plan" aktivieren
- Bei Änderungen wird automatisch neu berechnet

Manuelle Berechnung:
- Button: 🔄 "Planning Calculation"
- Popup: Projekte zur Neuberechnung auswählen
- Berechnungsdatum festlegen
- Berechnung starten
```

#### 1.3 Planning-Modi verwalten:
```
Verfügbare Modi:
- As soon as possible: So früh wie möglich
- Fixed duration: Feste Dauer
- Must start at validated date: Muss zu festem Datum starten
- Work together: Ressourcen arbeiten zusammen
- Regular between dates: Gleichmäßig zwischen Terminen
- Manual planning: Manuelle Planung

Änderung Planning-Modi:
1. Aktivität in Gantt-Chart auswählen
2. Details Area öffnen
3. Planning Mode ändern
4. Speichern und neu berechnen
```

#### 1.4 Abhängigkeiten (Dependencies) erstellen:
```
Dependency-Typen:
- Start to Start (SS): Start zu Start
- Start to Finish (SF): Start zu Ende
- Finish to Start (FS): Ende zu Start
- Finish to Finish (FF): Ende zu Ende

Erstellen im Gantt-Chart:
1. Vorgänger-Aktivität anklicken
2. Shift + Klick auf Nachfolger-Aktivität
3. Dependency-Typ auswählen
4. Verzögerung (Delay) definieren

Oder via Details Area:
1. Aktivität auswählen
2. Dependencies Section öffnen
3. Predecessor/Successor hinzufügen
```

**Praktisches Beispiel - Software Development Planning:**
```
Projekt: E-Commerce Platform

WBS-Struktur im Gantt:
├── 1.0 Requirements Analysis (5 Tage)
├── 2.0 Database Design (3 Tage) ←─FS─ 1.0
├── 3.0 Backend Development (15 Tage) ←─FS─ 2.0
├── 4.0 Frontend Development (12 Tage) ←─SS─ 3.0 (kann parallel starten)
├── 5.0 Integration Testing (5 Tage) ←─FS─ 3.0 + 4.0
└── 6.0 Deployment (2 Tage) ←─FS─ 5.0

Dependencies:
- 1.0 → 2.0: FS (Anforderungen müssen vor Design fertig sein)
- 2.0 → 3.0: FS + 1 Tag Delay (DB-Design Review-Zeit)
- 3.0 → 4.0: SS (Frontend kann mit Backend-APIs parallel starten)
```

---

### 2. **TIMESHEET (Zeiterfassung)**

**Begriff:** Das Timesheet ermöglicht die Erfassung der tatsächlich geleisteten Arbeitszeit (Real Work) auf Aktivitäten und Tickets. Dies ist essentiell für Projektcontrolling und Kostenberechnung.

**Menüpfad:** `Follow-up` > `Real work allocation` > `Timesheet`

#### 2.1 Timesheet öffnen und konfigurieren:
```
Menüpfad: Follow-up > Real work allocation > Timesheet

Interface-Bereiche:
- Selection and Filters (Auswahl und Filter)
- Switch Display (Ansicht umschalten)
- Tools (Werkzeuge)
- Task Zone (Aufgabenbereich)
- Entry Fields (Eingabefelder)
```

#### 2.2 Zeiterfassung durchführen:
```
Wöchentliche Ansicht (Standard):
1. Ressource auswählen (standardmäßig eigene Person)
2. Woche auswählen (aktuelle Woche vorselektiert)
3. Arbeitszeit pro Tag und Aktivität eingeben
4. Left Work (verbleibende Arbeit) aktualisieren
5. Speichern mit 💾 Button

Monatliche Ansicht:
- Button "Switch to month view" klicken
- Eingabe erfolgt pro Tag des Monats

Eingabe-Optionen:
- Stunden: Dezimal (z.B. 7.5 für 7,5 Stunden)
- Tage: Ganzzahlig (abhängig von Konfiguration)
- "Enter real as planned": Geplante Zeiten übernehmen
```

#### 2.3 Timesheet-Validierung:
```
Validierungsprozess:
1. Zeiterfassung komplett ausfüllen
2. Prüfung auf Plausibilität
3. Submit/Speichern
4. Automatische Benachrichtigungen:
   - An Projektleiter
   - An Team Manager
   - An Organisations-Manager

Status-Updates:
- Automatischer Statuswechsel zu "In Progress" bei erster Zeiterfassung
- Automatischer Statuswechsel zu "Done" wenn Left Work = 0
```

#### 2.4 Erweiterte Timesheet-Funktionen:
```
Filter-Optionen:
☑ Closed items: Abgeschlossene Aufgaben anzeigen
☑ Done items: Erledigte Aufgaben anzeigen
☑ Items not started: Noch nicht begonnene Aufgaben
☑ Paused items: Pausierte Aufgaben
☑ Weekly meetings only: Nur wöchentliche Meetings
☑ ID: Aufgaben-IDs anzeigen
☑ Planned work: Geplante Arbeitszeit anzeigen

Automatisierungen:
- Auto-Update Left Work on Pool: Bei Pool-Ressourcen
- Alert bei vorzeitiger Zeiterfassung
- Sperrung bei Überschreitung max. Stunden pro Tag
```

**Praktisches Beispiel - Timesheet Eingabe:**
```
Woche: 15.03.2025 - 21.03.2025
Ressource: Max Mustermann (Backend Developer)

Zeiterfassung:
                Mon  Tue  Wed  Thu  Fri
Database Design  2.0  3.0  1.5   -    -   (6.5h real, 1.5h left)
User API Dev     4.0  5.0  6.5  7.0  4.0  (26.5h real, 8h left)  
Code Review      1.0   -   1.0  1.0  2.0  (5h real, 0h left)
Bug Fixing       1.0  0.5   -    -   2.0  (3.5h real, 2h left)
Meeting          0.5  0.5  0.5  0.5  0.5  (2.5h real, 0h left)
---
Total:          8.5  9.0  9.5  8.5  8.5  = 44h/Woche
```

---

### 3. **TICKETS (Issue-Management)**

**Begriff:** Tickets sind ungeplante oder nicht planbare Aufgaben wie Bugs, Change Requests oder Support-Anfragen. Sie können optional mit Planning Activities verknüpft werden.

**Menüpfad:** `Ticketing` > `Ticket` > `New Element` (+)

#### 3.1 Ticket erstellen:
```
Grunddaten:
Ticket Name: Kurze Beschreibung des Problems
Ticket Type: Bug, Enhancement, Support Request, etc.
Priority: Critical, High, Medium, Low
Status: New, Assigned, In Progress, Resolved, Closed
Project: Zugehöriges Projekt
```

#### 3.2 Ticket-Zuweisungen:
```
Responsible: Hauptverantwortlicher für Ticket-Bearbeitung
Requestor: Person, die das Ticket erstellt/angefordert hat
Product: Betroffenes Produkt/Komponente
Version: Betroffene/Ziel-Version
Category: Kategorisierung (funktional, technisch, etc.)
```

#### 3.3 Ticket-Bearbeitung:
```
Work-Buttons:
🟢 "Start Work": Arbeit am Ticket beginnen
   - Startet automatische Zeiterfassung
   - Setzt Status auf "In Progress"

🔴 "Stop Work": Arbeit beenden
   - Stoppt Zeiterfassung
   - Überträgt Zeit in Timesheet
   - Verringert Left Work

⏸️ "Pause": Ticket pausieren
   - Automatisches Stoppen der Zeiterfassung
   - Status wechselt zu "Paused"

📊 "Show Periods": Bearbeitungszeiten anzeigen
   - Zeigt Start/End-Zeiten aller Bearbeitungsperioden
   - Berechnung der Netto-Arbeitszeit
```

#### 3.4 Verknüpfung mit Planning Activities:
```
Planning Activity Link:
1. Planning Activity Field im Ticket ausfüllen
2. Aktivität muss "Planning activity" Flag haben
3. Automatische Assignment-Erstellung bei Zeiterfassung
4. Real Work wird automatisch ins Timesheet übertragen

Vorteile:
- Ticket-Zeit wird von geplanter Aktivität abgezogen
- Bessere Integration in Projektplanung
- Automatisierte Kostenverfolgung
```

#### 3.5 Ticket-Workflow:
```
Standard-Workflow:
New → Assigned → In Progress → Resolved → Closed

Makro-Zustände:
- Idle: New, Assigned (nicht aktiv)
- Active: In Progress (aktive Bearbeitung)
- Paused: Pausiert (temporär unterbrochen)
- Done: Resolved, Closed (abgeschlossen)

Automatismen:
- Status-Wechsel bei Start/Stop Work
- E-Mail-Benachrichtigungen
- Eskalation bei Überschreitung SLA
```

**Praktisches Beispiel - Bug Ticket:**
```
Ticket: "Login-Button funktioniert nicht in Chrome"

Ticket-Daten:
Name: Login Button not working in Chrome Browser
Type: Bug
Priority: High
Status: New → Assigned → In Progress → Resolved
Project: E-Commerce Platform
Product: Web Frontend
Version: v1.2.3
Responsible: Anna Schmidt (Frontend Dev)
Requestor: QA Team

Planning Activity Link: "Frontend Bug Fixes" (Activity 4.3)
Estimated Work: 4 hours
Priority: High (SLA: 24h Response Time)

Bearbeitungsverlauf:
09:00 - Start Work (Status: In Progress)
09:00-12:00 - Problem-Analyse (3h)
12:00-13:00 - Mittagspause (Paused)
13:00-15:30 - Bug-Fix Implementation (2.5h)
15:30 - Stop Work (Status: Resolved)

Total Real Work: 5.5 hours
Planning Activity Update: 5.5h von geplanten 8h verbraucht
```

---

### **Workflow-Integration aller drei Bereiche:**

#### **Täglicher Arbeitsablauf:**
```
1. Planning prüfen:
   - Gantt-Chart für aktuelle Woche öffnen
   - Eigene Assignments prüfen
   - Prioritäten und Abhängigkeiten beachten

2. Arbeit beginnen:
   - Geplante Aktivitäten bearbeiten
   - Bei Tickets: "Start Work" verwenden
   - Zeiterfassung laufend oder am Ende

3. Timesheet ausfüllen:
   - Täglich oder am Wochenende
   - Real Work und Left Work aktualisieren
   - Abweichungen dokumentieren

4. Status Updates:
   - Aktivitäten-Status aktualisieren
   - Tickets bearbeiten und Status ändern
   - Probleme/Verzögerungen melden
```

#### **Projekt-Controlling-Zyklus:**
```
Wöchentlich:
- Timesheet-Validierung
- Planning-Neuberechnung
- Ticket-Review
- Status-Reporting

Monatlich:
- Earned Value Analyse
- Ressourcen-Auslastung
- Ticket-Trend-Analyse
- Planning-Baseline-Vergleich
```

Die Integration dieser drei Bereiche ermöglicht ein vollständiges Projektmanagement mit realistischer Planung, detaillierter Zeiterfassung und effizientem Issue-Management.​​​​​​​​​​​​​​​​