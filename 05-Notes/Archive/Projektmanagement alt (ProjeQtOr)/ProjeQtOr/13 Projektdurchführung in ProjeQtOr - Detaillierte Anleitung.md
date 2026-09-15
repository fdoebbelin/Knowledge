## Phase 8: Arbeitszeit-Management mit Timesheet

### **Schritt 1: Timesheet-Grundlagen verstehen**

#### **1.1 Timesheet-Konfiguration**

**Navigation: Planning and Follow-up → Timesheet**

```
Timesheet-Einstellungen verstehen:
- Period: Wöchentlich (Standard) oder täglich
- Show: Projekte, Activities, Tickets
- Week: Kalenderwoche auswählen
- Mode: Input (Eingabe) vs. Display (Anzeige)
```

#### **1.2 Arbeitszeit erfassen**

**Praktisches Beispiel für "EduConnect" Projekt:**

```
Timesheet-Eingaben für Woche 15/2025:
┌─────────────────────┬────┬────┬────┬────┬────┬─────┬─────┐
│ Activity            │ Mo │ Di │ Mi │ Do │ Fr │Total│Left │
├─────────────────────┼────┼────┼────┼────┼────┼─────┼─────┤
│ 1.1 Projektinit.    │ 3h │ 2h │ -  │ -  │ -  │ 5h  │ 0h  │
│ 2.1 Stakeholder     │ 4h │ 4h │ -  │ -  │ -  │ 8h  │ 0h  │
│ 2.2 Requirements    │ -  │ 2h │ 6h │ 4h │ -  │12h  │ 8h  │
│ Meeting: Kickoff    │ 2h │ -  │ -  │ -  │ -  │ 2h  │ 0h  │
│ Ticket: Bug#001     │ -  │ -  │ 1h │ -  │ 2h │ 3h  │ 1h  │
├─────────────────────┼────┼────┼────┼────┼────┼─────┼─────┤
│ Daily Total         │ 9h │ 8h │ 7h │ 4h │ 2h │30h  │ 9h  │
└─────────────────────┴────┴────┴────┴────┴────┴─────┴─────┘
```

### **Schritt 2: Progress Tracking und Status Updates**

#### **2.1 Aktivitäten-Status aktualisieren**

**Navigation: Planning and Follow-up → Activities → [Activity öffnen]**

```
Status-Update Beispiel für "2.2 Requirements Analysis":
┌─────────────────────────────────────────────────────────────┐
│ Progress Section:                                           │
├─────────────────────────────────────────────────────────────┤
│ Status: In progress                                         │
│ Progress: 60% (manual update)                               │
│ Planned work: 20.0 days                                     │
│ Real work: 12.0 days                                        │
│ Left work: 8.0 days (ursprünglich auto-calculated)         │
│ Planned cost: €4,000                                        │
│ Real cost: €2,400                                           │
│ Left cost: €1,600                                           │
├─────────────────────────────────────────────────────────────┤
│ Result Section:                                             │
│ Description: "Stakeholder-Interviews abgeschlossen.        │
│ Business Requirements dokumentiert. Technical Requirements │
│ in Bearbeitung. Risiko: Unklarheiten bei API-Schnitts."   │
│                                                             │
│ Quality level: Standard → Good (Verbesserung)              │
│ Health status: Good                                         │
│ Trend: Up (positiver Trend)                                │
└─────────────────────────────────────────────────────────────┘
```

#### **2.2 Automatic Progress Calculation**

```
ProjeQtOr berechnet automatisch:
- Progress = Real Work / (Real Work + Left Work) * 100
- Wenn Left Work manuell angepasst wird, ändert sich Progress
- Status-Automatik: "In progress" wenn Real Work > 0
- Status-Automatik: "Done" wenn Left Work = 0
```

### **Schritt 3: Real Work Allocation Management**

#### **3.1 Assignment-Tracking**

**In Activity → Assignment section**

```
Assignment-Updates für "Requirements Analysis":
┌─────────────────────────────────────────────────────────────┐
│ Resource: Anna Müller (PM)                                  │
│ Assigned work: 3.0 days                                     │
│ Real work allocation: 2.5 days                              │
│ Left work: 0.5 days                                         │
│ Assignment rate: 30% → 25% (angepasst)                      │
├─────────────────────────────────────────────────────────────┤
│ Resource: Max Richter (Developer)                           │
│ Assigned work: 5.0 days                                     │
│ Real work allocation: 6.5 days                              │
│ Left work: 3.5 days (Scope Increase!)                       │
│ Assignment rate: 80% → 90% (erhöht)                         │
└─────────────────────────────────────────────────────────────┘

⚠️ Alert: Max Richter hat mehr Zeit gebraucht als geplant!
→ Investigate: Scope Creep? Technical Complexity?
→ Action: Update estimates für ähnliche Activities
```

## Phase 9: Meeting Management & Kommunikation

### **Schritt 4: Meeting-Planung und -Durchführung**

#### **4.1 Meeting erstellen**

**Navigation: Steering → Meetings**

```
Beispiel: Wöchentliches Projektstatusmeeting
┌─────────────────────────────────────────────────────────────┐
│ Meeting Details:                                            │
├─────────────────────────────────────────────────────────────┤
│ Name: "EduConnect Weekly Status #3"                         │
│ Type: "Project Status Meeting"                              │
│ Project: "Mobile Learning App - EduConnect"                 │
│ Manager: "Anna Müller"                                      │
│ Planned date: 2025-04-15                                    │
│ Start time: 09:00                                           │
│ End time: 10:00                                             │
│ Location: "Konferenzraum A / Teams"                         │
├─────────────────────────────────────────────────────────────┤
│ Description (Agenda):                                       │
│ 1. Roundtable (10 min)                                      │
│ 2. Milestone Review (15 min)                                │
│ 3. Risk & Issues (15 min)                                   │
│ 4. Next Week Planning (15 min)                              │
│ 5. Decisions & Actions (5 min)                              │
│                                                             │
│ Status: Planned                                             │
│ Is recurring: ✓ (weekly, Fridays)                          │
└─────────────────────────────────────────────────────────────┘
```

#### **4.2 Attendees Management**

**Im Meeting → Attendees section**

```
Teilnehmer-Liste:
┌─────────────────────────────────────────────────────────────┐
│ Required Attendees:                                         │
│ ✓ Anna Müller (Project Manager) - Moderator                │
│ ✓ Max Richter (Lead Developer) - Status Reports            │
│ ✓ Lisa Chen (UI/UX Designer) - Design Updates              │
│ ✓ Thomas Schmidt (Business Owner) - Requirements           │
│                                                             │
│ Optional Attendees:                                         │
│ ? Dr. Maria Weber (Sponsor) - bei Bedarf                   │
│ ? Quality Manager - bei Issues                             │
│                                                             │
│ Meeting Assignment:                                         │
│ Planned work: 4.0 hours (alle Teilnehmer)                  │
│ Real work: [nach Meeting eintragen]                        │
│ Cost: €200 (Meeting-Kosten)                                │
└─────────────────────────────────────────────────────────────┘
```

### **Schritt 5: Live Meeting Management**

#### **5.1 Live Meeting durchführen**

**Meeting öffnen → "Start meeting" Button**

```
Live Meeting Interface:
┌─────────────────────────────────────────────────────────────┐
│ EduConnect Weekly Status #3                                 │
│ Time: 09:05 - Running | Remaining: 55 min                  │
├─────────────────────────────────────────────────────────────┤
│ Speaking Time Counter:                                      │
│ Anna Müller: ████████░░ 8:30 min (17%)                     │
│ Max Richter: ██████░░░░ 6:45 min (14%)                     │
│ Lisa Chen:   ████░░░░░░ 4:20 min (9%)                      │
│ Thomas:      ██░░░░░░░░ 2:15 min (5%)                      │
├─────────────────────────────────────────────────────────────┤
│ Live Minutes:                                               │
│ 09:05 Meeting Start                                         │
│ 09:07 Max: Requirements Phase 85% complete                 │
│ 09:12 Lisa: UI Mockups ready for review                    │
│ 09:15 ⚠️ ISSUE: API Documentation delayed                   │
│ 09:18 💡 DECISION: Move API Review to next week             │
│ 09:20 📋 ACTION: Max updates technical spec by Wed         │
├─────────────────────────────────────────────────────────────┤
│ Quick Actions:                                              │
│ [+ Add Decision] [+ Add Action] [+ Add Issue]              │
│ [Kanban Board] [Screen Share] [Record]                     │
└─────────────────────────────────────────────────────────────┘
```

#### **5.2 Kanban Integration im Live Meeting**

**Live Meeting → Kanban Button**

```
Sprint Board - Current Week:
┌─────────────┬─────────────┬─────────────┬─────────────┐
│ TODO        │ IN PROGRESS │ REVIEW      │ DONE        │
├─────────────┼─────────────┼─────────────┼─────────────┤
│ API Testing │ UI Mockups  │ Tech Spec   │ Requirements│
│ (Max)       │ (Lisa)      │ (Max)       │ (Team)      │
│             │             │             │             │
│ User Guide  │ Logo Design │ Wireframes  │ Kickoff     │
│ (Thomas)    │ (Lisa)      │ (Lisa)      │ (All)       │
│             │             │             │             │
│ [Drag Tasks in Real-Time during Meeting]               │
└─────────────┴─────────────┴─────────────┴─────────────┘
```

### **Schritt 6: Decisions & Actions Management**

#### **6.1 Decisions tracking**

**Navigation: Steering → Decisions**

```
Decision Log aus Meeting:
┌─────────────────────────────────────────────────────────────┐
│ Decision #DE-001                                            │
├─────────────────────────────────────────────────────────────┤
│ Title: "API Documentation Timeline Extension"               │
│ Description: "Due to complexity in third-party integration,│
│ API documentation deadline extended by 1 week"             │
│                                                             │
│ Decided by: Anna Müller (Project Manager)                  │
│ Decision date: 2025-04-15                                   │
│ Meeting: "EduConnect Weekly Status #3"                      │
│ Project: "Mobile Learning App - EduConnect"                 │
│                                                             │
│ Context: "Technical complexity higher than estimated"       │
│ Alternative considered: "Reduce API scope"                  │
│ Rationale: "Quality over speed, stakeholder aligned"       │
│                                                             │
│ Impact on budget: +€800                                     │
│ Impact on timeline: +5 days                                 │
│ Risk level: Medium                                          │
│                                                             │
│ Who was present:                                            │
│ ✓ Anna Müller, Max Richter, Lisa Chen, Thomas Schmidt      │
└─────────────────────────────────────────────────────────────┘
```

#### **6.2 Actions Management**

**Navigation: Steering → Actions**

```
Action Items aus Meeting:
┌─────────────────────────────────────────────────────────────┐
│ Action #AC-015                                              │
├─────────────────────────────────────────────────────────────┤
│ Title: "Update Technical Specification Document"            │
│ Description: "Incorporate API changes and third-party      │
│ integration details into technical specification"          │
│                                                             │
│ Assigned to: Max Richter                                    │
│ Created date: 2025-04-15                                    │
│ Due date: 2025-04-17 (Wednesday)                           │
│ Meeting: "EduConnect Weekly Status #3"                      │
│ Priority: High                                              │
│                                                             │
│ Status: Assigned                                            │
│ % Complete: 0%                                              │
│                                                             │
│ Success criteria:                                           │
│ "- API endpoints documented                                 │
│  - Integration flow diagrams updated                        │
│  - Error handling specified                                 │
│  - Technical review completed"                              │
│                                                             │
│ Impact: Blocks development start for API module            │
│ Dependencies: Decision #DE-001                              │
└─────────────────────────────────────────────────────────────┘
```

### **Schritt 7: Periodic Meetings einrichten**

#### **7.1 Recurring Meetings konfigurieren**

**Navigation: Steering → Periodic meetings**

```
Recurring Meeting Setup:
┌─────────────────────────────────────────────────────────────┐
│ Periodic Meeting Configuration                              │
├─────────────────────────────────────────────────────────────┤
│ Name: "EduConnect Weekly Status"                            │
│ Type: "Project Status Meeting"                              │
│ Project: "Mobile Learning App - EduConnect"                 │
│ Manager: "Anna Müller"                                      │
│                                                             │
│ Recurrence Pattern:                                         │
│ Frequency: Weekly                                           │
│ Day: Friday                                                 │
│ Time: 09:00 - 10:00                                         │
│ Start date: 2025-04-01                                      │
│ End date: 2025-07-31                                        │
│                                                             │
│ Auto-generation: ✓ Enabled                                  │
│ Lead time: 1 week (Meeting created 1 week in advance)      │
│                                                             │
│ Standard Agenda Template:                                   │
│ "1. Team Roundtable (10 min)                               │
│  2. Progress Review (15 min)                               │
│  3. Issues & Risks (15 min)                                │
│  4. Next Steps (15 min)                                     │
│  5. Actions & Decisions (5 min)"                           │
└─────────────────────────────────────────────────────────────┘
```

## Phase 10: Progress Monitoring & Reporting

### **Schritt 8: Project Dashboard nutzen**

#### **8.1 Today Dashboard verwenden**

**Navigation: Dashboard → Today**

```
Today Dashboard für "EduConnect":
┌─────────────────────────────────────────────────────────────┐
│ Project Health Status                    📊 □□□■■           │
├─────────────────────────────────────────────────────────────┤
│ Overall Progress: 35% (▲ +5% since last week)              │
│ Budget Consumption: 28% (✓ aligned with progress)          │
│ Schedule Performance: 2 days ahead                         │
│ Quality Index: 85% (✓ target: >80%)                        │
├─────────────────────────────────────────────────────────────┤
│ Critical Items:                                             │
│ ⚠️ API Documentation delayed (5 days)                       │
│ ⚠️ Risk #R-003 materialized → create Issue                 │
│ ✓ Milestone M2 achieved on time                            │
│ ✓ No resource conflicts this week                          │
├─────────────────────────────────────────────────────────────┤
│ This Week Focus:                                            │
│ □ Complete Requirements Phase (Milestone M3)               │
│ □ Start UI Design Phase                                     │
│ □ Stakeholder Review Meeting (Thursday)                    │
│ □ Update Risk Register                                      │
├─────────────────────────────────────────────────────────────┤
│ Next Week Preview:                                          │
│ • Design Phase Kickoff                                     │
│ • Technical Architecture Review                            │
│ • First UI Prototypes                                      │
└─────────────────────────────────────────────────────────────┘
```

### **Schritt 9: Reports für Stakeholder**

#### **9.1 Status Reports generieren**

**Navigation: Reports → Project reports**

```
Weekly Status Report Template:
┌─────────────────────────────────────────────────────────────┐
│ PROJECT STATUS REPORT - Week 15/2025                       │
│ Project: Mobile Learning App - EduConnect                   │
│ Report Date: 2025-04-15                                     │
│ Project Manager: Anna Müller                               │
├─────────────────────────────────────────────────────────────┤
│ EXECUTIVE SUMMARY:                                          │
│ ✓ Requirements phase 85% complete                          │
│ ⚠️ Technical specification delayed by 5 days               │
│ ✓ Budget within target (28% consumed, 35% progress)        │
│ ✓ Stakeholder satisfaction: high                           │
├─────────────────────────────────────────────────────────────┤
│ MILESTONE STATUS:                                           │
│ M1 ✓ Project Kickoff (completed 2025-04-01)               │
│ M2 ✓ Concept Approval (completed 2025-04-10)              │
│ M3 🔄 Requirements Complete (due 2025-04-20, 85% done)     │
│ M4 📅 Design Freeze (due 2025-05-15)                       │
├─────────────────────────────────────────────────────────────┤
│ KEY ACCOMPLISHMENTS:                                        │
│ • Stakeholder interviews completed                         │
│ • Business requirements documented                         │
│ • UI/UX concept approved                                   │
│ • Technical architecture defined                           │
├─────────────────────────────────────────────────────────────┤
│ ISSUES & RISKS:                                             │
│ ⚠️ Issue: API complexity higher than estimated             │
│ 📋 Action: Extended timeline by 1 week                     │
│ 🎯 Risk: Third-party integration challenges                │
│ 📋 Mitigation: Technical spike planned                     │
├─────────────────────────────────────────────────────────────┤
│ NEXT WEEK FOCUS:                                            │
│ • Complete requirements documentation                      │
│ • Start UI design phase                                    │
│ • Technical spike for API integration                      │
│ • Stakeholder review meeting                              │
└─────────────────────────────────────────────────────────────┘
```

## 📋 Übung für Kursteilnehmer: "Projektdurchführung Workshop"

### **Praktische Aufgabe: Erste Projektwochen simulieren**

#### **Szenario-Fortsetzung:**

_"Sie sind in Woche 3 des EduConnect-Projekts. Die ersten Activities laufen, das Team arbeitet, und Sie müssen den Projektfortschritt verfolgen und steuern."_

### **Teil A: Timesheet & Progress Management (60 Min)**

**Aufgaben:**

1. ✅ **Timesheet-Eingaben simulieren**
    
    ```
    Woche 1-3 für alle Teammitglieder:
    - Realistische Arbeitszeiten eintragen
    - Verschiedene Activities bearbeiten
    - Meetings berücksichtigen
    - Tickets für kleine Bugfixes
    ```
    
2. ✅ **Progress Updates durchführen**
    
    ```
    Für mind. 5 Activities:
    - Status von "Planned" auf "In progress" 
    - Real work vs. Left work anpassen
    - Progress % berechnen lassen
    - Result-Beschreibungen hinzufügen
    ```
    
3. ✅ **Varianzen analysieren**
    
    ```
    Simulation verschiedener Szenarien:
    - Activity dauert länger als geplant
    - Activity wird schneller fertig
    - Scope-Änderung während Bearbeitung
    - Ressource fällt krankheitsbedingt aus
    ```
    

### **Teil B: Meeting Management (45 Min)**

**Aufgaben:** 4. ✅ **Projektstatusmeeting planen**

```
- Meeting für kommenden Freitag erstellen
- Agenda definieren
- Teilnehmer einladen
- Periodic Meeting für wöchentliche Wiederholung
```

5. ✅ **Live Meeting simulieren**
    
    ```
    Live Meeting Simulation (15 Min):
    - Start meeting Button klicken
    - Speaking time tracken
    - 2 Decisions dokumentieren
    - 3 Action Items erstellen
    - Kanban Board nutzen
    - Minutes automatisch speichern
    ```
    
6. ✅ **Follow-up verwalten**
    
    ```
    Nach dem Meeting:
    - Action Items verfolgen
    - Decisions in separater Liste
    - Next Meeting vorbereiten
    - Meeting Minutes exportieren
    ```
    

### **Teil C: Monitoring & Reporting (45 Min)**

**Aufgaben:** 7. ✅ **Dashboard konfigurieren**

```
Today Dashboard anpassen:
- Relevante KPIs auswählen
- Critical Items identifizieren
- Health Status bewerten
- Trends erkennen
```

8. ✅ **Status Report erstellen**
    
    ```
    Wöchentlichen Projektbericht generieren:- Progress-Daten automatisch übernehmen- Milestones-Status aktualisieren- Issues & Risks beschreiben- Next Steps definieren
    ```
    

### **Realistische Szenarien einbauen:**

**Szenario 1: Zeitverzögerung**

```
"Max Richter braucht für die Requirements-Analyse 8 statt 5 Tage. 
Wie erfassen Sie das in ProjeQtOr und welche Auswirkungen hat das?"

Lernziele:
- Left work anpassen
- Planning recalculation verstehen
- Dependencies-Impact analysieren
- Mitigation-Maßnahmen planen
```

**Szenario 2: Ungeplante Arbeit**

```
"Ein kritischer Bug wird entdeckt, der sofort behoben werden muss. 
3 Tage Zusatzaufwand für das gesamte Entwicklungsteam."

Lernziele:
- Tickets für ungeplante Arbeit
- Activities vs. Tickets unterscheiden
- Timesheet-Flexibilität nutzen
- Impact auf Planung verstehen
```

**Szenario 3: Scope-Änderung**

```
"Der Kunde möchte spontan eine zusätzliche Funktion. 
Das Team schätzt 2 Wochen zusätzlichen Aufwand."

Lernziele:
- Change Request Prozess
- WBS erweitern
- Dependencies anpassen
- Stakeholder-Kommunikation
```

### **Erwartete Lernergebnisse:**

```
Nach dieser Übung können Teilnehmer:
✓ Arbeitszeiten korrekt erfassen
✓ Projektfortschritt realistisch bewerten
✓ Meetings effizient durchführen und dokumentieren
✓ Action Items und Decisions verfolgen
✓ Dashboard für Projekt-Monitoring nutzen
✓ Status Reports automatisch generieren
✓ Varianzen erkennen und darauf reagieren
✓ Live Meeting Features für agile Kommunikation nutzen
```

### **Diskussionspunkte für Abschluss:**

```
1. Realitätsnähe: Wie nah sind unsere Simulationen an echten Projekten?
2. Tool-Effizienz: Welche ProjeQtOr-Features sparen am meisten Zeit?
3. Kommunikation: Wie unterstützt das Tool die Projektsteuerung?
4. Monitoring: Welche KPIs sind für verschiedene Stakeholder wichtig?
5. Lessons Learned: Was würden Sie beim nächsten Projekt anders machen?
```

### **Häufige Herausforderungen & Lösungen:**

```
Problem: "Timesheet-Eingaben sind mühsam"
Lösung: 
- Batch-Eingabe nutzen
- Templates für wiederkehrende Tätigkeiten
- Mobile App für unterwegs
- Erinnerungen aktivieren

Problem: "Progress-Updates sind nicht aktuell"
Lösung:
- Regelmäßige Review-Termine
- Automatische Progress-Calculation
- Team-Agreements für Update-Frequenz
- Dashboard-Monitoring

Problem: "Meetings werden nicht nachverfolgt"
Lösung:
- Live Meeting Tool nutzen
- Automatic Action Item Creation
- Periodic Meeting Setup
- Follow-up Tracking einbauen
```

**Nächste Session Vorschau:** _"Risikomanagement, Änderungscontrolling und Qualitätssicherung: Wie ProjeQtOr bei der Projektsteuerung hilft"_

Soll ich als nächstes die **Risikomanagement- und Controlling-Phase** mit Risk Management, Change Requests und Quality Assurance ausarbeiten?