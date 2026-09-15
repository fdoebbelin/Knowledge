## Sprint-basierte WBS-Struktur

### **Projekt-Transformation: Von klassisch zu agil**

**Projekt:** 
E-Commerce Platform Development (Agile) 
**Methodologie:** Scrum mit 2-Wochen-Sprints 
## **Product Backlog - User Stories erstellen**

### **Epic 1: Benutzer-Management**

```
Epic Name: User Management System
Description: Als System möchte ich eine sichere Benutzerverwaltung, 
            damit Kunden sich registrieren und anmelden können.
Story Points: 21 (Summe aller User Stories)
Priority: Must Have
Business Value: High
```

#### **User Stories für Epic 1:**

**US-001: Benutzerregistrierung**

```
User Story: Als neuer Kunde möchte ich mich registrieren können, 
           damit ich ein Konto erstellen kann.

Story Points: 8
Priority: Must Have
Sprint: Sprint 1

Akzeptanzkriterien:
- Registrierungsformular mit E-Mail, Passwort, Name
- E-Mail-Validierung erforderlich
- Passwort-Sicherheitsrichtlinien
- Bestätigungs-E-Mail versenden
- Doppelte E-Mail-Adressen verhindern

Technical Tasks:
- User Entity erstellen (2h)
- Registration API Endpoint (6h)
- Password Hashing implementieren (4h)
- E-Mail Service Integration (8h)
- Validation Logic (4h)
- Unit Tests (8h)
Total: 32h
```

**US-002: Benutzeranmeldung**

```
User Story: Als registrierter Kunde möchte ich mich anmelden können,
           damit ich auf mein Konto zugreifen kann.

Story Points: 5
Priority: Must Have  
Sprint: Sprint 1

Akzeptanzkriterien:
- Login mit E-Mail und Passwort
- JWT Token Generation
- "Remember Me" Funktionalität
- Fehlende Credentials abfangen
- Account Lockout nach 5 Fehlversuchen

Technical Tasks:
- Authentication Service (8h)
- JWT Token Management (6h)
- Login API Endpoint (4h)
- Session Management (6h)
- Security Middleware (4h)
- Unit Tests (4h)
Total: 32h
```

**US-003: Passwort zurücksetzen**

```
User Story: Als Kunde möchte ich mein Passwort zurücksetzen können,
           wenn ich es vergessen habe.

Story Points: 8
Priority: Should Have
Sprint: Sprint 2

Akzeptanzkriterien:
- "Forgot Password" Link
- Reset-Token per E-Mail
- Temporärer Link (24h gültig)
- Neues Passwort setzen
- Alte Tokens invalidieren

Technical Tasks:
- Password Reset API (8h)
- Token Generation Service (6h)
- E-Mail Template (4h)
- Reset Form Validation (4h)
- Security Testing (6h)
- Unit Tests (4h)
Total: 32h
```

---

## **Epic 2: Produktkatalog**

```
Epic Name: Product Catalog System
Description: Als Kunde möchte ich Produkte durchsuchen und finden können,
            damit ich Artikel zum Kaufen auswählen kann.
Story Points: 34
Priority: Must Have
Business Value: High
```

#### **User Stories für Epic 2:**

**US-004: Produktsuche**

```
User Story: Als Kunde möchte ich nach Produkten suchen können,
           damit ich schnell finde was ich brauche.

Story Points: 13
Priority: Must Have
Sprint: Sprint 2

Akzeptanzkriterien:
- Volltextsuche über Produktname und Beschreibung
- Autocomplete-Vorschläge
- Filter nach Kategorie, Preis, Bewertung
- Sortierung nach Relevanz, Preis, Beliebtheit
- Paginierung (20 Artikel pro Seite)
- "Keine Ergebnisse" Behandlung

Technical Tasks:
- Elasticsearch Integration (16h)
- Search API Endpoint (8h)
- Filter Implementation (12h)
- Sorting Logic (6h)
- Pagination Service (4h)
- Performance Optimization (8h)
- Unit/Integration Tests (12h)
Total: 66h
```

**US-005: Produktdetails anzeigen**

```
User Story: Als Kunde möchte ich detaillierte Produktinformationen sehen,
           damit ich eine Kaufentscheidung treffen kann.

Story Points: 8
Priority: Must Have
Sprint: Sprint 3

Akzeptanzkriterien:
- Vollständige Produktbeschreibung
- Preis und Verfügbarkeit
- Produktbilder (mehrere)
- Kundenbewertungen anzeigen
- Ähnliche Produkte vorschlagen
- Technische Spezifikationen

Technical Tasks:
- Product Detail API (8h)
- Image Management (6h)
- Reviews Integration (8h)
- Related Products Algorithm (10h)
- Caching Implementation (4h)
- Unit Tests (8h)
Total: 44h
```

**US-006: Produktkategorien verwalten**

```
User Story: Als Administrator möchte ich Produktkategorien verwalten,
           damit Kunden Produkte leichter finden können.

Story Points: 13
Priority: Should Have
Sprint: Sprint 3

Akzeptanzkriterien:
- Hierarchische Kategoriestruktur
- Kategorie CRUD Operationen
- Kategorie-zu-Produkt Zuordnung
- SEO-freundliche URLs
- Kategorie-Bilder
- Reihenfolge der Kategorien

Technical Tasks:
- Category Entity Design (8h)
- Category Management API (12h)
- Tree Structure Implementation (16h)
- URL Slug Generation (4h)
- Admin Interface Backend (8h)
- Unit Tests (8h)
Total: 56h
```

---

## **Epic 3: Warenkorb & Bestellungen**

```
Epic Name: Shopping Cart & Orders
Description: Als Kunde möchte ich Produkte in den Warenkorb legen und bestellen,
            damit ich Einkäufe abschließen kann.
Story Points: 55
Priority: Must Have
Business Value: Critical
```

#### **User Stories für Epic 3:**

**US-007: Warenkorb-Management**

```
User Story: Als Kunde möchte ich Produkte in meinen Warenkorb legen,
           damit ich sie später kaufen kann.

Story Points: 21
Priority: Must Have
Sprint: Sprint 4

Akzeptanzkriterien:
- Produkte zum Warenkorb hinzufügen
- Menge ändern
- Artikel aus Warenkorb entfernen
- Warenkorb persistieren (angemeldete User)
- Warenkorb-Übersicht mit Gesamtpreis
- Verfügbarkeit prüfen

Technical Tasks:
- Cart Entity Design (6h)
- Add to Cart API (8h)
- Update Quantity API (6h)
- Remove from Cart API (4h)
- Cart Persistence (8h)
- Inventory Checking (10h)
- Session Cart (anonymous users) (12h)
- Unit Tests (16h)
Total: 70h
```

**US-008: Checkout-Prozess**

```
User Story: Als Kunde möchte ich den Checkout-Prozess durchlaufen,
           damit ich meine Bestellung abschließen kann.

Story Points: 21
Priority: Must Have
Sprint: Sprint 5

Akzeptanzkriterien:
- Lieferadresse eingeben/auswählen
- Versandoptionen wählen
- Steuerberechnung (basierend auf Standort)
- Bestellübersicht vor Bestätigung
- Bestellbestätigung
- Lagerbestand reservieren

Technical Tasks:
- Checkout API Design (12h)
- Address Management (10h)
- Shipping Calculation (8h)
- Tax Calculation Service (10h)
- Order Creation Logic (16h)
- Inventory Reservation (8h)
- Order Confirmation (6h)
- Unit/Integration Tests (18h)
Total: 88h
```

**US-009: Zahlungsabwicklung**

```
User Story: Als Kunde möchte ich sicher bezahlen können,
           damit meine Bestellung verarbeitet wird.

Story Points: 13
Priority: Must Have
Sprint: Sprint 6

Akzeptanzkriterien:
- Multiple Zahlungsmethoden (Kreditkarte, PayPal, SEPA)
- Sichere Zahlungsabwicklung (PCI DSS)
- 3D Secure Support
- Zahlungsbestätigung
- Fehlerbehandlung bei fehlgeschlagenen Zahlungen
- Refund-Funktionalität

Technical Tasks:
- Stripe Integration (16h)
- PayPal Integration (12h)
- SEPA Direct Debit (10h)
- 3D Secure Implementation (8h)
- Payment Status Handling (10h)
- Refund Service (8h)
- Security Audit (6h)
- Unit Tests (16h)
Total: 86h
```

---

## **Sprint-Planung in ProjeQtor**

### **Sprint 1: User Management Foundation (2 Wochen)**

**Menüpfad:** `Planning` > `Activity` > `New Element` (+)

```
Activity Name: Sprint 1 - User Management Foundation
WBS-Code: 1.1 (automatisch)
Activity Type: Sprint
Planning Mode: Fixed duration
Duration: 10 Arbeitstage

Sprint Goals:
- Benutzerregistrierung funktionsfähig
- Benutzeranmeldung mit JWT
- Grundlegende Sicherheitsfeatures

Sprint Backlog:
- US-001: Benutzerregistrierung (32h)
- US-002: Benutzeranmeldung (32h)
- Database Setup & Migration (16h)
- Security Framework Setup (16h)
- API Documentation (8h)

Total Sprint Effort: 104 Stunden
Team Capacity: 120 Stunden (3 Entwickler × 8h × 10 Tage)
Buffer: 16 Stunden (13%)

Sprint Team:
- Senior Backend Developer (Scrum Master): 40h
- Backend Developer 1: 40h  
- Backend Developer 2: 40h

Sprint Ceremonies in ProjeQtor:
```

#### **Sprint 1 - Detailed Activities:**

**1.1.1 Sprint Planning Meeting**

```
Activity Name: Sprint 1 Planning
WBS-Code: 1.1.1
Activity Type: Meeting
Duration: 4 Stunden
Participants: Gesamtes Scrum Team
Deliverables: Sprint Backlog, Sprint Goal Definition
```

**1.1.2 User Registration Development**

```
Activity Name: User Registration Implementation
WBS-Code: 1.1.2  
Activity Type: Task
Duration: 4 Tage
Effort: 32 Stunden

Assignment:
- Senior Backend Developer: 16h (API Design & Security)
- Backend Developer 1: 16h (Implementation & Testing)

Dependencies: Database Setup (FS)
```

**1.1.3 User Authentication Development**

```
Activity Name: User Authentication Implementation
WBS-Code: 1.1.3
Activity Type: Task  
Duration: 4 Tage
Effort: 32 Stunden

Assignment:
- Senior Backend Developer: 16h (JWT & Security)
- Backend Developer 2: 16h (Session Management)

Dependencies: User Registration (SS, 1 Tag Overlap)
```

**1.1.4 Daily Scrums**

```
Activity Name: Daily Scrum Meetings
WBS-Code: 1.1.4
Activity Type: Recurring Meeting
Frequency: Täglich 15 Min
Total Effort: 7.5 Stunden (15 min × 10 Tage × 3 Personen)
```

**1.1.5 Sprint Review**

```
Activity Name: Sprint 1 Review
WBS-Code: 1.1.5
Activity Type: Meeting
Duration: 2 Stunden
Participants: Scrum Team + Product Owner + Stakeholder
Deliverables: Demo der entwickelten Features
```

**1.1.6 Sprint Retrospective**

```
Activity Name: Sprint 1 Retrospective  
WBS-Code: 1.1.6
Activity Type: Meeting
Duration: 1.5 Stunden
Participants: Scrum Team
Deliverables: Action Items für Verbesserungen
```

---

### **Sprint 2: Search & Password Reset (2 Wochen)**

**Menüpfad:** `Planning` > `Activity` > `New Element` (+)

```
Activity Name: Sprint 2 - Search & Password Reset
WBS-Code: 1.2
Activity Type: Sprint  
Duration: 10 Arbeitstage

Sprint Goals:
- Produktsuche mit Elasticsearch
- Passwort-Reset-Funktionalität
- Performance-Optimierung

Sprint Backlog:
- US-003: Passwort zurücksetzen (32h)
- US-004: Produktsuche (66h) 
- Elasticsearch Setup (16h)
- Performance Testing (8h)

Total Sprint Effort: 122 Stunden
Team Capacity: 120 Stunden
Überladung: 2 Stunden (Überstunden oder nächster Sprint)
```

---

### **Sprint 3: Product Management (2 Wochen)**

```
Activity Name: Sprint 3 - Product Management
WBS-Code: 1.3
Activity Type: Sprint
Duration: 10 Arbeitstage

Sprint Goals:
- Produktdetails vollständig anzeigen
- Kategorieverwaltung implementieren
- Admin-Interface Backend

Sprint Backlog:
- US-005: Produktdetails anzeigen (44h)
- US-006: Produktkategorien verwalten (56h)
- Image Upload Service (16h)

Total Sprint Effort: 116 Stunden
Team Capacity: 120 Stunden
```

---

### **Sprint 4: Shopping Cart (2 Wochen)**

```
Activity Name: Sprint 4 - Shopping Cart
WBS-Code: 1.4
Activity Type: Sprint
Duration: 10 Arbeitstage

Sprint Goals:
- Vollständiges Warenkorb-Management
- Session-basierte Carts für anonyme User
- Inventory-Management

Sprint Backlog:
- US-007: Warenkorb-Management (70h)
- Inventory Service (24h)
- Cart Synchronization (16h)

Total Sprint Effort: 110 Stunden
Team Capacity: 120 Stunden
```

---

### **Sprint 5: Checkout Process (2 Wochen)**

```
Activity Name: Sprint 5 - Checkout Process
WBS-Code: 1.5
Activity Type: Sprint
Duration: 10 Arbeitstage

Sprint Goals:
- Kompletter Checkout-Workflow
- Address Management
- Tax & Shipping Calculation

Sprint Backlog:
- US-008: Checkout-Prozess (88h)
- Address Validation Service (16h)
- Order Management System (16h)

Total Sprint Effort: 120 Stunden
Team Capacity: 120 Stunden
```

---

### **Sprint 6: Payment Integration (2 Wochen)**

```
Activity Name: Sprint 6 - Payment Integration
WBS-Code: 1.6
Activity Type: Sprint
Duration: 10 Arbeitstage

Sprint Goals:
- Sichere Zahlungsintegration
- Multiple Payment Methods
- PCI DSS Compliance

Sprint Backlog:
- US-009: Zahlungsabwicklung (86h)
- Security Audit (16h)
- Payment Testing (18h)

Total Sprint Effort: 120 Stunden
Team Capacity: 120 Stunden
```

---

## **Agile Artifacts in ProjeQtor**

### **Product Backlog Management**

**Menüpfad:** `Agile` > `User Stories` > `Product Backlog View`

```
Product Backlog (priorisiert):
1. US-001: Benutzerregistrierung (8 SP) - Sprint 1
2. US-002: Benutzeranmeldung (5 SP) - Sprint 1  
3. US-003: Passwort zurücksetzen (8 SP) - Sprint 2
4. US-004: Produktsuche (13 SP) - Sprint 2
5. US-005: Produktdetails (8 SP) - Sprint 3
6. US-006: Produktkategorien (13 SP) - Sprint 3
7. US-007: Warenkorb-Management (21 SP) - Sprint 4
8. US-008: Checkout-Prozess (21 SP) - Sprint 5
9. US-009: Zahlungsabwicklung (13 SP) - Sprint 6

Total: 110 Story Points über 6 Sprints
Velocity Target: 18-22 Story Points pro Sprint
```

### **Sprint Boards (Kanban)**

**Menüpfad:** `Agile` > `Kanban` > `Create New Board`

```
Kanban Board: Sprint 1 - User Management
Type: Activities (Sprint Tasks)
Columns:
├── To Do
├── In Progress  
├── Code Review
├── Testing
└── Done

WIP Limits:
- In Progress: 3
- Code Review: 2  
- Testing: 2
```

### **Velocity Tracking**

```
Sprint Velocity (Story Points completed):
Sprint 1: 13 SP (US-001: 8 + US-002: 5)
Sprint 2: 21 SP (US-003: 8 + US-004: 13)
Sprint 3: 21 SP (US-005: 8 + US-006: 13)
Sprint 4: 21 SP (US-007: 21)
Sprint 5: 21 SP (US-008: 21)  
Sprint 6: 13 SP (US-009: 13)

Average Velocity: 18.3 SP/Sprint
Project Duration: 12 Wochen (6 × 2-Wochen-Sprints)
```

### **Definition of Done (DoD)**

```
Story ist "Done" wenn:
✅ Code entwickelt und getestet (Unit Tests >90% Coverage)
✅ Code Review durch Senior Developer abgeschlossen
✅ Integration Tests erfolgreich
✅ API Dokumentation aktualisiert
✅ Security Review durchgeführt (bei sicherheitsrelevanten Features)
✅ Performance Tests bestanden
✅ Product Owner Acceptance erhalten
✅ Code in main branch gemerged
```

Diese agile Struktur verwandelt das klassische Backend Development in ein flexibles, iteratives Projekt mit klaren Sprint-Zielen, regelmäßigen Feedback-Zyklen und messbarem Fortschritt durch Story Points und Velocity Tracking.