## Phase 1: Grundstrukturen anlegen

### **Schritt 1: Organisationsstruktur erstellen**

#### **1.1 Organization anlegen**
**Navigation: Environmental Parameters → Organizations**

```
Beispiel-Organisation:
- Name: "InnoTech Solutions GmbH"
- Organization type: "Headquarters"
- Manager: [Kursleiter als Manager]
- Description: "Technologieunternehmen für innovative Lösungen"
```

#### **1.2 Teams erstellen**
**Navigation: Environmental Parameters → Teams**

```
Team-Struktur:
├── Management Team
├── Development Team  
├── Marketing Team
└── Quality Assurance Team
```

### **Schritt 2: Stakeholder und Kontakte einrichten**

#### **2.1 Client anlegen**
**Navigation: Environmental Parameters → Clients**

```
Beispiel-Kunde:
- Client name: "Digital Future AG"
- Type: "External Customer"
- Client code: "DF-001"
- Payment deadline: "30 days"
- Tax: 19%

Adresse:
- Street: "Innovationsstraße 15"
- City: "München"
- Zip: "80333"
- Country: "Deutschland"
```

#### **2.2 Contacts erstellen**
**Navigation: Environmental Parameters → Contacts**

```
Wichtige Kontakte:
1. Kunde - Projektsponsors:
   - Name: "Dr. Maria Weber"
   - Function: "Head of Digital Transformation"
   - Email: "m.weber@digitalfuture.de"
   - Client: Digital Future AG

2. Interner Auftraggeber:
   - Name: "Thomas Schmidt"
   - Function: "Business Development Manager"
   - Is a user: ✓
   - Is a resource: ✓
```

### **Schritt 3: Ressourcen und Benutzer einrichten**

#### **3.1 Resources erstellen**
**Navigation: Environmental Parameters → Resources**

```
Beispiel-Ressourcen für Kurs:
1. Projektleiter:
   - Real name: "Anna Müller"
   - Initials: "AM"
   - Capacity (FTE): 1.0
   - Profile: "Project Leader"
   - Team: "Management Team"
   - Calendar: "Default"
   - Is a user: ✓

2. Entwickler:
   - Real name: "Max Richter"
   - Initials: "MR"  
   - Capacity (FTE): 1.0
   - Profile: "Project Member"
   - Team: "Development Team"
   - Is a user: ✓

3. Designer:
   - Real name: "Lisa Chen"
   - Initials: "LC"
   - Capacity (FTE): 0.8
   - Profile: "Project Member"
   - Team: "Development Team"
```

#### **3.2 Kalender anpassen**
**Navigation: Environmental Parameters → Calendars**

```
Standard-Kalender überprüfen:
- Arbeitszeiten: Mo-Fr
- Feiertage hinzufügen
- Betriebsferien eintragen
```

## Phase 2: Projektinitiierung

### **Schritt 4: Proposal Project erstellen**

#### **4.1 Projektantrag anlegen**
**Navigation: Planning and Follow-up → Projects**

```
Projekt-Grunddaten:
- Name: "Mobile Learning App - EduConnect"
- Project code: "EDU-2024-001"
- Project type: "Proposal project (PRP)"
- Client: "Digital Future AG"
- Sponsor: "Dr. Maria Weber"
- Manager: "Anna Müller"

Strategische Bewertung (SWOT):
- Strength: "Erfahrenes Entwicklungsteam, bewährte Technologie"
- Weakness: "Begrenzte Mobile-App Erfahrung"
- Opportunity: "Wachsender E-Learning Markt"
- Threat: "Starke Konkurrenz durch etablierte Anbieter"
- Strategic value: 85
```

#### **4.2 Erste Dokumentation erstellen**
**Navigation: Document Management → Documents**

```
Projektinitiierungsdokumente:
1. Projektauftrag
   - Name: "Projektauftrag EduConnect"
   - Type: "Contract"
   - Author: "Anna Müller"
   - Project: "Mobile Learning App - EduConnect"
   - Product: [Falls Product Management aktiviert]

2. Stakeholder-Register
   - Name: "Stakeholder Analysis EduConnect"
   - Type: "Analysis"
   - Versionierung: "Evolutive"

3. Anforderungsdokument (Initial)
   - Name: "Initial Requirements EduConnect"
   - Type: "Specification"
```

### **Schritt 5: Document Directory Structure**

#### **5.1 Verzeichnisstruktur anlegen**
**Navigation: Document Management → Document Directory**

```
Projekt-Dokumentenstruktur:
📁 01_Projektmanagement
   📁 01.1_Projektauftrag
   📁 01.2_Pläne
   📁 01.3_Berichte
   📁 01.4_Meetings
📁 02_Anforderungen
   📁 02.1_Business_Requirements
   📁 02.2_Functional_Requirements
   📁 02.3_Technical_Requirements
📁 03_Design
   📁 03.1_UI_UX_Design
   📁 03.2_System_Architecture
📁 04_Entwicklung
   📁 04.1_Code_Documentation
   📁 04.2_API_Documentation
📁 05_Test
   📁 05.1_Test_Plans
   📁 05.2_Test_Results
📁 06_Deployment
📁 07_Abnahme
```

## Phase 3: Projekt-Setup in ProjeQtOr

### **Schritt 6: Operatives Projekt erstellen**

#### **6.1 Proposal zu operativem Projekt kopieren**
```
1. Proposal Project öffnen
2. Copy-Button klicken
3. Auswählen:
   - Copy to: "Project"
   - Project type: "Operational project (OPE)"
   - Project status: "Recorded"
   - ✓ Copy structure
   - ✓ Copy linked documents
```

#### **6.2 Projekt-Konfiguration**
```
Operative Projekt-Einstellungen:
- Billing type: "Fixed price" oder "Time & Materials"
- Health status: "Good"
- Quality level: "Standard"
- Trend: "Stable"
- Under construction: ✓ (Initial)
```

### **Schritt 7: Erste Stakeholder-Zuweisungen**

#### **7.1 Project Allocations**
**In Projekt → Allocations section**

```
Benutzer-Zuweisungen:
1. Dr. Maria Weber (Contact)
   - Profile: "Project Guest"
   - Rate: 10%
   - Role: "Sponsor"

2. Thomas Schmidt (User/Resource)
   - Profile: "Project Leader"
   - Rate: 25%
   - Role: "Business Owner"

3. Anna Müller (Resource)
   - Profile: "Project Leader" 
   - Rate: 100%
   - Role: "Project Manager"

4. Entwicklungsteam
   - Alle Entwickler mit "Project Member"
   - Verschiedene Raten je nach Verfügbarkeit
```

## 📋 Übung für Kursteilnehmer

### **Praktische Aufgabe: "Projektstart-Workshop"**

#### **Szenario:**
*"Sie sind Projektleiter bei InnoTech Solutions und sollen eine mobile Lern-App für Digital Future AG entwickeln. Der Kunde möchte eine innovative Lösung für Corporate Learning."*

#### **Aufgaben für Teilnehmer:**

**Teil A: Strukturen anlegen (45 Min)**
1. ✅ Eigene Organisation erstellen
2. ✅ Client "Digital Future AG" anlegen
3. ✅ Minimum 3 Kontakte erstellen (Sponsor, Fachbereich, IT)
4. ✅ Sich selbst als Resource/User einrichten

**Teil B: Projektinitiierung (60 Min)**
1. ✅ Proposal Project erstellen mit vollständiger SWOT-Analyse
2. ✅ Dokumentenverzeichnis aufbauen
3. ✅ Projektauftrag als Dokument hochladen
4. ✅ Erste Stakeholder zuweisen

**Teil C: Diskussion & Review (30 Min)**
- Ergebnisse präsentieren
- Best Practices besprechen
- Typische Fallstricke identifizieren

### **Checkliste für Kursleiter:**

```
Vorbereitung:
□ ProjeQtOr-Instanz mit Admin-Rechten vorbereitet
□ Standard-Profile konfiguriert
□ Beispiel-Dokumente erstellt
□ Backup der leeren Umgebung

Während der Übung:
□ Teilnehmer beim Setup unterstützen
□ Häufige Fragen sammeln
□ Screenshots für Dokumentation machen

Nach der Übung:
□ Lessons Learned sammeln
□ Nächste Schritte erklären
□ Hausaufgaben vergeben
```

### **Erwartete Lernergebnisse:**
- Verständnis der ProjeQtOr-Grundstruktur
- Praktische Erfahrung mit Benutzer- und Rechteverwaltung
- Erste Berührung mit Dokumentenmanagement
- Verständnis für Stakeholder-Management

### **Häufige Herausforderungen:**
1. **Berechtigungsprobleme**: Profile richtig zuweisen
2. **Navigation**: Menüstruktur verstehen
3. **Datenqualität**: Vollständige Eingaben sicherstellen

Soll ich als nächstes die **Projektplanungsphase** mit WBS-Erstellung und Terminplanung detailliert ausarbeiten?