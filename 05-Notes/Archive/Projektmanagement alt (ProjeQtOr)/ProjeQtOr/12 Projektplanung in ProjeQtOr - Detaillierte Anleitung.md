## Phase 4: Work Breakdown Structure (WBS) erstellen

### **Schritt 1: Aktivitäten-Hierarchie aufbauen**

#### **1.1 Hauptphasen definieren**

**Navigation: Planning and Follow-up → Projects → [Ihr Projekt öffnen]**

```
WBS Level 1 - Hauptphasen:
1.0 Projektmanagement
2.0 Analyse & Konzeption  
3.0 Design & Prototyping
4.0 Entwicklung
5.0 Testing & QA
6.0 Deployment & Go-Live
7.0 Projektabschluss
```

#### **1.2 Activities erstellen**

**Navigation: Planning and Follow-up → Activities**

**Phase 1: Projektmanagement**

```
1.1 Projektinitiierung
    - Name: "Projektinitiierung und Setup"
    - Activity type: "Management"
    - Planning mode: "As soon as possible"
    - Priority: 500
    - Description: "Projektstart, Team-Setup, initiale Planung"
    
1.2 Projektsteuerung
    - Name: "Laufende Projektsteuerung"
    - Activity type: "Management" 
    - Planning mode: "Recurring (weekly)"
    - Description: "Wöchentliche Steuerung, Reporting, Meetings"

1.3 Risikomanagement
    - Name: "Risikomanagement"
    - Activity type: "Management"
    - Planning mode: "Regular between dates"
```

**Phase 2: Analyse & Konzeption**

```
2.1 Stakeholder-Analyse
    - Name: "Stakeholder-Analyse und Interviews"
    - Activity type: "Analysis"
    - Validated duration: 5 Tage
    - Planning mode: "Fixed duration"

2.2 Anforderungsanalyse
    - Name: "Business Requirements Analysis"
    - Activity type: "Analysis"
    - Planning mode: "As soon as possible"
    - Predecessor: 2.1 (End-Start)

2.3 Technische Konzeption
    - Name: "System Architecture & Technical Concept"
    - Activity type: "Design"
    - Dependencies: 2.2 (End-Start)

2.4 Konzept-Review
    - Name: "Konzept Review & Approval"
    - Activity type: "Review"
    - Planning mode: "Fixed duration"
    - Validated duration: 2 Tage
```

### **Schritt 2: Sub-Aktivitäten detaillieren**

#### **2.1 Entwicklungsphase aufgliedern**

```
4.0 Entwicklung (Parent Activity)
├── 4.1 Backend Development
│   ├── 4.1.1 API Design & Setup
│   ├── 4.1.2 User Management Module
│   ├── 4.1.3 Content Management System
│   ├── 4.1.4 Learning Progress Tracking
│   └── 4.1.5 Reporting & Analytics
├── 4.2 Frontend Development
│   ├── 4.2.1 UI Framework Setup
│   ├── 4.2.2 User Interface Implementation
│   ├── 4.2.3 Navigation & Routing
│   └── 4.2.4 Responsive Design
├── 4.3 Mobile App Development
│   ├── 4.3.1 iOS App Development
│   ├── 4.3.2 Android App Development
│   └── 4.3.3 Cross-Platform Integration
└── 4.4 Integration & API
    ├── 4.4.1 Third-Party Integrations
    └── 4.4.2 Payment Gateway Integration
```

#### **2.2 WBS in ProjeQtOr eingeben**

**Navigation: Planning and Follow-up → Planning View (Gantt)**

1. **Parent Activity erstellen:**
    
    ```
    - Name: "4.0 Entwicklung"
    - Activity type: "Phase"
    - Planning mode: "Parent activity"
    - Show WBS: ✓
    ```
    
2. **Sub-Activities hinzufügen:**
    
    ```
    Über "+" Button neue Activities erstellen
    Per Drag & Drop unter Parent einordnen
    WBS-Nummerierung wird automatisch generiert
    ```
    

## Phase 5: Meilensteine definieren

### **Schritt 3: Milestone-Planung**

#### **3.1 Projekt-Meilensteine erstellen**

**Navigation: Planning and Follow-up → Milestones**

```
Meilenstein-Plan:
M1: Projektstart
    - Name: "Project Kickoff"
    - Type: "Project Start"
    - Planning mode: "Fixed milestone"
    - Validated due date: [Projektstart]

M2: Konzept-Freigabe  
    - Name: "Concept Approval"
    - Type: "Approval"
    - Planning mode: "Floating milestone"
    - Target product version: "v1.0"

M3: Design-Freeze
    - Name: "Design Freeze"
    - Type: "Design Milestone"
    - Dependencies: M2 (End-Start, +5 days)

M4: Development Complete
    - Name: "Development Completion"
    - Type: "Development"
    - Planning mode: "Floating milestone"

M5: User Acceptance Test
    - Name: "UAT Approval"
    - Type: "Test Milestone"
    - Dependencies: M4 (End-Start)

M6: Go-Live
    - Name: "Production Deployment"
    - Type: "Deployment"
    - Planning mode: "Fixed milestone"
    - Validated due date: [Zieldatum]

M7: Projektabschluss
    - Name: "Project Closure"
    - Type: "Project End"
    - Dependencies: M6 (End-Start, +14 days)
```

### **Schritt 4: Dependencies (Abhängigkeiten) definieren**

#### **4.1 Abhängigkeiten zwischen Activities**

**Im Gantt Chart oder in Activity Details → Predecessor/Successor section**

```
Typische Abhängigkeiten:
1. Sequenzielle Abhängigkeiten:
   - 2.1 Stakeholder-Analyse → 2.2 Anforderungsanalyse (End-Start)
   - 2.2 Requirements → 2.3 Technical Concept (End-Start)
   - 3.2 UI Design → 4.2 Frontend Development (End-Start)

2. Parallele Abhängigkeiten:
   - 4.1 Backend Development || 4.2 Frontend Development (Start-Start)
   - 4.3.1 iOS Development || 4.3.2 Android Development (Start-Start)

3. Meilenstein-Abhängigkeiten:
   - 2.4 Concept Review → M2 Concept Approval (End-Start)
   - M3 Design Freeze → 4.0 Development (End-Start)

4. Abhängigkeiten mit Verzögerungen:
   - 5.2 Integration Test → 6.1 Deployment Prep (End-Start, +3 days)
   - M6 Go-Live → 7.1 Post-Launch Support (End-Start, +1 day)
```

#### **4.2 Dependencies in ProjeQtOr eingeben**

```
Methode 1: Gantt Chart
- Linke Maustaste auf Vorgänger-Balken
- Ziehen zum Nachfolger-Balken
- Dependency-Type auswählen

Methode 2: Activity Details
- Predecessor/Successor Section
- "+" Button → Dependency hinzufügen
- Type und Delay definieren
```

## Phase 6: Ressourcenplanung

### **Schritt 5: Resources zu Activities zuweisen**

#### **5.1 Assignment-Strategie definieren**

```
Ressourcen-Matrix:
┌─────────────────────┬──────────┬─────────┬─────────┬──────────┐
│ Activity            │ PM       │ Dev     │ Design  │ QA       │
├─────────────────────┼──────────┼─────────┼─────────┼──────────┤
│ 1.1 Projektinit.    │ 5d (100%)│ 1d (25%)│ -       │ -        │
│ 2.1 Stakeholder     │ 2d (50%) │ -       │ -       │ -        │
│ 2.2 Requirements    │ 3d (30%) │ 5d (80%)│ 1d (20%)│ -        │
│ 3.1 System Design   │ 1d (20%) │ 8d (100%)│ -      │ -        │
│ 3.2 UI Design       │ 1d (10%) │ -       │ 10d (100%)│ -      │
│ 4.1 Backend Dev     │ 2d (20%) │ 15d (100%)│ -     │ 2d (25%) │
│ 4.2 Frontend Dev    │ 1d (10%) │ 12d (80%)│ 8d (60%)│ 2d (25%)│
│ 5.1 Unit Testing    │ -        │ 5d (50%)│ -       │ 8d (100%)│
└─────────────────────┴──────────┴─────────┴─────────┴──────────┘
```

#### **5.2 Assignments in ProjeQtOr eingeben**

**In Activity → Assignment section**

```
Beispiel: "2.2 Business Requirements Analysis"
┌─────────────────────────────────────────────────────────────┐
│ Assignment Details:                                         │
├─────────────────────────────────────────────────────────────┤
│ Resource: Anna Müller (PM)                                  │
│ Function: Project Manager                                   │
│ Assigned work: 3.0 days                                     │
│ Assignment rate: 30%                                        │
│ Period: [Start date] to [End date]                          │
├─────────────────────────────────────────────────────────────┤
│ Resource: Max Richter (Developer)                           │
│ Function: Senior Developer                                  │
│ Assigned work: 5.0 days                                     │
│ Assignment rate: 80%                                        │
│ Period: [Start date] to [End date]                          │
└─────────────────────────────────────────────────────────────┘
```

### **Schritt 6: Kapazitätsplanung und Ressourcenkonflikte**

#### **6.1 Resource Planning View nutzen**

**Navigation: Planning and Follow-up → Resource Planning**

```
Ressourcenauslastung prüfen:
1. Alle Resources anzeigen
2. Zeitraum definieren (Projektlaufzeit)
3. Überbelastungen identifizieren (rote Balken)
4. Konflikte lösen durch:
   - Verschiebung von Tasks
   - Anpassung Assignment Rates
   - Additional Resources
   - Task-Splitting
```

#### **6.2 Critical Resources identifizieren**

**Navigation: Planning and Follow-up → Critical Resources**

```
Analyse der kritischen Ressourcen:
- Bottleneck-Ressourcen identifizieren
- Überlastungsperioden erkennen
- Alternative Szenarien durchspielen
- Mitigation-Strategien entwickeln
```

## Phase 7: Zeitplanung und Planungsoptimierung

### **Schritt 7: Planning Calculation durchführen**

#### **7.1 Planning Modes optimieren**

```
Planning Mode Strategy:
- Kritischer Pfad: "As soon as possible"
- Fixe Termine: "Must start at validated date"
- Puffer-Tasks: "Should end before validated end date"
- Regelmäßige Tasks: "Regular between dates"
- Management: "Recurring (weekly)"
```

#### **7.2 Gantt-Optimierung**

**Navigation: Planning and Follow-up → Planning View**

```
Planning Calculation Steps:
1. [Calculate] Button klicken
2. Projekte auswählen
3. Berechnungsoptionen:
   - ✓ Calculate with critical path
   - ✓ Overuse (für initiale Analyse)
   - Start date: [Projektstart]

4. Ergebnisse analysieren:
   - Grüne Balken: OK
   - Rote Balken: Verzögerungen
   - Lila Balken: Ressourcenkonflikte

5. Anpassungen vornehmen:
   - Dependencies optimieren
   - Planning Modes anpassen
   - Ressourcen umverteilen
```

## 📋 Übung für Kursteilnehmer: "Projektplanung Workshop"

### **Praktische Aufgabe: Vollständige Projektplanung**

#### **Szenario-Erweiterung:**

_"Die Mobile Learning App 'EduConnect' soll in 4 Monaten live gehen. Der Kunde hat spezifische Anforderungen und ein fixes Budget. Erstellen Sie eine detaillierte Projektplanung."_

### **Teil A: WBS-Erstellung (90 Min)**

**Aufgaben:**

1. ✅ **Phasen-Struktur aufbauen**
    
    ```
    - 7 Hauptphasen definieren
    - Mind. 20 Sub-Activities erstellen
    - 3-Level WBS-Hierarchie aufbauen
    - Aktivitäts-Typen zuweisen
    ```
    
2. ✅ **Planning Modes zuweisen**
    
    ```
    - Verschiedene Planning Modes ausprobieren
    - Begründung für Mode-Auswahl dokumentieren
    ```
    
3. ✅ **Meilensteine definieren**
    
    ```
    - 7 strategische Meilensteine
    - Floating vs. Fixed Milestones
    - Milestone-Types verwenden
    ```
    

### **Teil B: Dependencies & Zeitplanung (75 Min)**

**Aufgaben:** 4. ✅ **Abhängigkeiten modellieren**

```
- Mind. 15 Dependencies zwischen Activities
- Verschiedene Dependency-Types nutzen:
  * End-Start (Standard)
  * Start-Start (Parallele Tasks)
  * End-End (Synchrone Fertigstellung)
- Delays wo sinnvoll (+2 days, +1 week, etc.)
```

5. ✅ **Critical Path analysieren**
    
    ```
    - Planning Calculation durchführen- Kritischen Pfad identifizieren- Optimierungspotential erkennen
    ```
    

### **Teil C: Ressourcenplanung (60 Min)**

**Aufgaben:** 6. ✅ **Team-Assignments**

```
Team-Setup:
- 1 Project Manager (Sie selbst)
- 2 Developers (andere Teilnehmer)
- 1 Designer (anderer Teilnehmer)
- 1 QA Tester (anderer Teilnehmer)
- 1 Business Analyst (anderer Teilnehmer)
```

7. ✅ **Workload Distribution**
    
    ```
    - Realistische Arbeitszeiten zuweisen
    - Assignment Rates definieren (nicht alle 100%)
    - Urlaubszeiten berücksichtigen
    - Parallel- vs. Sequential Work planen
    ```
    
8. ✅ **Ressourcenkonflikt-Analyse**
    
    ```
    - Resource Planning View nutzen
    - Überbelastungen identifizieren
    - Lösungsstrategien entwickeln
    ```
    

### **Erwartete Deliverables:**

```
1. Vollständiger WBS (Excel Export)
2. Gantt Chart (PDF Export)
3. Resource Planning Overview
4. Critical Path Analysis
5. Milestone Plan
6. Risk Register (erste Einträge)
```

### **Bewertungskriterien:**

|Kriterium|Gewichtung|Bewertung|
|---|---|---|
|WBS-Vollständigkeit|25%|Struktur, Detailgrad, Logik|
|Dependencies-Qualität|20%|Realismus, Vollständigkeit|
|Ressourcenplanung|25%|Realistisch, ausbalanciert|
|Zeitplanung|20%|Machbarkeit, Critical Path|
|Tool-Nutzung|10%|ProjeQtOr Features genutzt|

### **Häufige Herausforderungen & Lösungen:**

```
Problem: "Planning Calculation schlägt fehl"
Lösung: 
- Dependencies auf Zirkelbezüge prüfen
- Ressourcen-Allocations überprüfen
- Planning Modes validieren

Problem: "Ressourcen sind überbelastet"
Lösung:
- Assignment Rates reduzieren
- Tasks parallelisieren
- Additional Resources hinzufügen
- Task-Splitting anwenden

Problem: "Projekt wird zu lang"
Lösung:
- Critical Path verkürzen
- Fast Tracking anwenden
- Scope reduzieren
- Mehr Ressourcen zuweisen
```

### **Lessons Learned Session (30 Min):**

**Diskussionspunkte:**

- Welche Planning Modes waren am hilfreichsten?
- Wo entstanden die meisten Ressourcenkonflikte?
- Wie realistisch sind die erstellten Pläne?
- Welche ProjeQtOr-Features waren besonders nützlich?

### **Hausaufgabe für nächste Session:**

```
1. Baseline des Plans erstellen
2. 3 Risiken identifizieren und in ProjeQtOr eingeben
3. Erste Test Cases für kritische Features definieren
4. Change Request vorbereiten (simulierte Änderung)
```

**Nächste Session Vorschau:** _"Projektdurchführung: Timesheet, Progress Tracking, Meetings & Communication Management"_

Soll ich als nächstes die **Projektdurchführungsphase** mit Timesheet-Management, Progress Tracking und Meeting-Verwaltung ausarbeiten?