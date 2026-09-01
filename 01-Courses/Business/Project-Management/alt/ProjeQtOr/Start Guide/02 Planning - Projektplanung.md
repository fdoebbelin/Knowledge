## Erfassung von Projects, Allocation to Projects und Activities

---

### 1. **PROJECTS (Projekte)**

**Begriff:** Das Project ist das Hauptelement in ProjeQtor und definiert das höchste Level für Sichtbarkeits- und Zugriffsrechte. Es ist ein plannbares Element, das Unterprojekte enthalten kann.

**Menüpfad:** `Planning` > `Project` > `New Element` (+)

#### 1.1 Grunddaten erfassen:
```
Project Name: Name des Projekts
Project Type: Projekttyp (aus vordefinierter Liste)
Project Code: Eindeutiger Projektcode/Kürzel
Status: Aktueller Projektstatus
Manager: Projektleiter (aus Ressourcenliste)
Sponsor: Auftraggeber/Sponsor
Client: Kunde/Auftraggeber
```

#### 1.2 Termine und Budget:
```
Start Date: Projektstartdatum
End Date: Geplantes Projektende
Initial Duration: Ursprünglich geplante Dauer
Budget: Projektbudget
Validated Start/End: Bestätigte Termine
```

#### 1.3 Organisationsstruktur:
```
Top Project: Übergeordnetes Projekt (für Unterprojekte)
Organization: Zugehörige Organisation
Color: Farbe für Gantt-Chart Darstellung
```

**Praktisches Beispiel - E-Commerce Projekt:**
```
Project Name: E-Commerce Platform Development
Project Code: ECP-2025
Project Type: Fixed Price
Manager: Max Mustermann
Client: TechCorp Solutions GmbH
Start Date: 01.03.2025
End Date: 31.08.2025
Budget: 150.000 €
```

#### 1.4 Sub-Projekte erstellen:
```
Menüpfad: Planning > Project > New Element (+)
Top Project: [Hauptprojekt auswählen]

Beispiel-Struktur:
├── E-Commerce Platform Development (Hauptprojekt)
    ├── Backend Development (Unterprojekt)
    ├── Frontend Development (Unterprojekt)
    ├── Testing & QA (Unterprojekt)
    └── Deployment (Unterprojekt)
```

---

### 2. **ALLOCATION TO PROJECTS (Projekt-Allokationen)**

**Begriff:** Allocation definiert, welche Ressourcen welchen Projekten zugewiesen sind und in welchem Umfang. Nur allokierte Ressourcen können Aktivitäten zugewiesen werden.

**Menüpfad:** `Planning` > `Project` > [Projekt auswählen] > `Allocations Section`

#### 2.1 Ressourcen-Allokation erstellen:
```
Resource: Ressource auswählen
Function: Funktion/Rolle im Projekt
Start Date: Beginn der Allokation
End Date: Ende der Allokation
Allocation Rate: Prozentsatz der Verfügbarkeit (z.B. 50% = halbe Arbeitszeit)
Profile: Berechtigungsprofil für das Projekt
```

#### 2.2 Allokations-Parameter:
```
Daily Cost: Tagessatz für diese Allokation
Planned Work: Geplanter Arbeitsaufwand
Real Work: Tatsächlich geleistete Arbeit
Left Work: Verbleibender Arbeitsaufwand
```

**Praktisches Beispiel:**
```
E-Commerce Projekt Allokationen:

1. Resource: Max Mustermann
   Function: Project Manager
   Period: 01.03.2025 - 31.08.2025
   Allocation Rate: 100%
   Profile: Project Leader

2. Resource: Anna Schmidt
   Function: Frontend Developer
   Period: 15.03.2025 - 15.07.2025
   Allocation Rate: 80%
   Profile: Project Member

3. Resource: Java Team
   Function: Backend Developer
   Period: 01.03.2025 - 31.07.2025
   Allocation Rate: 100% (FTE = 3.0 für 3-Personen-Team)
   Profile: Project Member
```

#### 2.3 Multi-Allokation verwalten:
```
Konflikt-Erkennung:
- Ressource kann mehreren Projekten zugewiesen sein
- System warnt bei Überallokation (>100%)
- Grafische Darstellung von Konflikten

Konflikt-Lösung:
- Allokations-Zeiträume anpassen
- Allokations-Rate reduzieren
- Alternative Ressourcen einsetzen
```

---

### 3. **ACTIVITIES (Aktivitäten/Aufgaben)**

**Begriff:** Eine Activity ist eine planbare Aufgabe, die Ressourcen zugewiesen werden kann. Activities bilden die Work Breakdown Structure (WBS) und können hierarchisch strukturiert werden.

**Menüpfad:** `Planning` > `Activity` > `New Element` (+)

#### 3.1 Aktivität erstellen:
```
Activity Name: Name der Aktivität
Activity Type: Typ (Task, Phase, Delivery, etc.)
Top Activity: Übergeordnete Aktivität (für WBS-Struktur)
Project: Zugehöriges Projekt
Priority: Planungspriorität (1-999)
```

#### 3.2 Planung und Aufwand:
```
Planning Mode: Planungsmodus
- As soon as possible: So früh wie möglich
- Fixed duration: Feste Dauer
- Must start at validated date: Muss zu festem Datum starten
- Work together: Zusammen arbeiten

Initial Work: Ursprünglich geschätzter Aufwand
Planned Work: Geplanter Aufwand
Real Work: Tatsächlicher Aufwand
Left Work: Verbleibender Aufwand

Duration: Dauer der Aktivität
```

#### 3.3 Termine und Abhängigkeiten:
```
Planned Start/End: Geplante Termine
Real Start/End: Tatsächliche Termine
Validated Start/End: Bestätigte Termine

Dependencies (Abhängigkeiten):
- Predecessor: Vorgänger-Aktivität
- Successor: Nachfolger-Aktivität
- Dependency Type:
  * Start to Start (SS)
  * Start to Finish (SF)
  * Finish to Start (FS)
  * Finish to Finish (FF)
- Delay: Verzögerung zwischen Aktivitäten
```

**Praktisches Beispiel - E-Commerce WBS:**
```
1.0 Backend Development
├── 1.1 Database Design
    ├── 1.1.1 Entity Relationship Design
    ├── 1.1.2 Database Schema Creation
    └── 1.1.3 Database Performance Optimization

├── 1.2 API Development
    ├── 1.2.1 User Management API
    ├── 1.2.2 Product Catalog API
    ├── 1.2.3 Order Processing API
    └── 1.2.4 Payment Integration API

└── 1.3 Backend Testing
    ├── 1.3.1 Unit Tests
    ├── 1.3.2 Integration Tests
    └── 1.3.3 Performance Tests

Dependencies Beispiel:
- 1.1.2 (Schema Creation) → Finish to Start → 1.2.1 (User API)
- 1.2.1 (User API) → Start to Start → 1.2.2 (Product API)
```

---

### 4. **ASSIGNMENT (Zuweisungen)**

**Begriff:** Assignment weist Ressourcen konkreten Aktivitäten zu. Nur Ressourcen, die dem Projekt allokiert sind, können Aktivitäten zugewiesen werden.

**Menüpfad:** `Planning` > `Activity` > [Aktivität auswählen] > `Assignment Section`

#### 4.1 Ressourcen-Zuweisung:
```
Resource: Verfügbare Ressource (nur allokierte)
Function: Funktion bei dieser Aufgabe
Assignment Rate: Prozentsatz der Ressourcen-Kapazität
Planned Work: Geplanter Arbeitsaufwand
Left Work: Verbleibender Aufwand
Assignment Start/End: Zuweisungs-Zeitraum
```

**Praktisches Beispiel:**
```
Activity: 1.2.1 User Management API

Assignment 1:
- Resource: Anna Schmidt
- Function: Backend Developer
- Assignment Rate: 100%
- Planned Work: 40 hours
- Period: 15.03.2025 - 22.03.2025

Assignment 2:
- Resource: QA Team
- Function: Tester
- Assignment Rate: 50%
- Planned Work: 16 hours
- Period: 20.03.2025 - 24.03.2025
```

---

### **Ablauf der kompletten Projekt-Einrichtung:**

#### **Schritt 1: Projekt erstellen**
```
1. Grunddaten erfassen (Name, Code, Manager, Kunde)
2. Termine und Budget definieren
3. Sub-Projekte bei Bedarf erstellen
```

#### **Schritt 2: Ressourcen allokieren**
```
1. Benötigte Ressourcen identifizieren
2. Allokations-Zeiträume definieren
3. Verfügbarkeits-Prozentsätze festlegen
4. Profile und Berechtigungen zuweisen
```

#### **Schritt 3: WBS erstellen**
```
1. Hauptaktivitäten definieren
2. Hierarchische Struktur aufbauen
3. Aktivitäts-Typen zuweisen
4. Aufwandsschätzungen vornehmen
```

#### **Schritt 4: Abhängigkeiten definieren**
```
1. Logische Reihenfolge bestimmen
2. Dependency-Typen festlegen
3. Verzögerungen definieren
4. Kritischen Pfad identifizieren
```

#### **Schritt 5: Ressourcen zuweisen**
```
1. Aktivitäten-spezifische Zuweisungen
2. Arbeitsaufwand verteilen
3. Funktionen und Rollen klären
4. Zeiträume abstimmen
```

#### **Schritt 6: Planung berechnen**
```
1. Automatische Terminberechnung
2. Ressourcen-Konflikte prüfen
3. Gantt-Chart generieren
4. Baseline setzen
```

**Wichtige Hinweise:**
- Nur allokierte Ressourcen können Aktivitäten zugewiesen werden
- WBS-Nummerierung wird automatisch verwaltet
- Assignments können nach Arbeitsbeginn nicht mehr gelöscht werden
- Planning-Modi beeinflussen die automatische Terminberechnung​​​​​​​​​​​​​​​​