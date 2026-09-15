### **Projekt:** E-Commerce Platform Development

**Menüpfad:** `Planning` > `Activity` > `New Element` (+)

---

## **1.0 Backend Development** (Hauptaktivität)

```
Activity Name: Backend Development
Activity Type: Phase
WBS-Code: 1.0
Top Activity: [None - Hauptebene]
Project: E-Commerce Platform Development
Priority: 1
Planning Mode: As soon as possible
Status: New

Termine:
Planned Start: 15.03.2025
Planned End: 15.06.2025
Duration: 65 Arbeitstage (13 Wochen)

Aufwand:
Initial Work: 960 Stunden
Planned Work: 960 Stunden
Left Work: 960 Stunden

Costs:
Budget: 76.800 € (960h × 80€/h Durchschnitt)
Planned Cost: 76.800 €

Resources (Zugewiesene Teams):
- Backend Team Lead: 200h × 95€/h = 19.000 €
- Senior Backend Developer: 350h × 85€/h = 29.750 €  
- Junior Backend Developer: 300h × 65€/h = 19.500 €
- Database Administrator: 110h × 90€/h = 9.900 €
```

---

## **1.1 Database Design** (Level 2)

```
Activity Name: Database Design
Activity Type: Work Package
WBS-Code: 1.1
Top Activity: 1.0 Backend Development
Priority: 1
Planning Mode: Fixed duration

Termine:
Planned Start: 15.03.2025
Planned End: 29.03.2025
Duration: 10 Arbeitstage (2 Wochen)

Aufwand:
Initial Work: 120 Stunden
Planned Work: 120 Stunden
Left Work: 120 Stunden

Costs:
Budget: 10.200 € 
Planned Cost: 10.200 €

Dependencies:
- Predecessor: Requirements Analysis (FS)
- Successor: 1.2 API Development (FS, 2 Tage Delay)

Deliverables:
- ER-Diagramm
- Datenbankschema
- Performance-Optimierungsplan
```

### **1.1.1 Entity Relationship Design** (Level 3)

```
Activity Name: Entity Relationship Design
Activity Type: Task
WBS-Code: 1.1.1
Top Activity: 1.1 Database Design
Priority: 1
Planning Mode: Must start at validated date

Termine:
Validated Start: 15.03.2025
Planned Start: 15.03.2025
Planned End: 19.03.2025
Duration: 3 Arbeitstage

Aufwand:
Initial Work: 32 Stunden
Planned Work: 32 Stunden
Left Work: 32 Stunden

Assignment Details:
Resource: Database Administrator
Function: Data Architect
Assignment Rate: 100%
Planned Work: 24 Stunden
Daily Allocation: 8h/Tag

Resource: Backend Team Lead
Function: Technical Lead
Assignment Rate: 50%
Planned Work: 8 Stunden
Daily Allocation: 2.67h/Tag

Costs:
- DBA: 24h × 90€/h = 2.160 €
- Team Lead: 8h × 95€/h = 760 €
- Total: 2.920 €

Deliverables:
- ER-Diagramm (Conceptual Model)
- Entity-Attribut-Definition
- Beziehungsmatrix
- Domain-Modell-Dokumentation

Quality Gates:
- Review durch Senior Backend Developer
- Approval durch Technical Lead
- Stakeholder-Freigabe
```

### **1.1.2 Database Schema Creation** (Level 3)

```
Activity Name: Database Schema Creation
Activity Type: Task
WBS-Code: 1.1.2
Top Activity: 1.1 Database Design
Priority: 1
Planning Mode: As soon as possible

Termine:
Planned Start: 20.03.2025
Planned End: 26.03.2025
Duration: 5 Arbeitstage

Dependencies:
- Predecessor: 1.1.1 Entity Relationship Design (FS)
- Successor: 1.1.3 Database Performance Optimization (FS)

Aufwand:
Initial Work: 48 Stunden
Planned Work: 48 Stunden
Left Work: 48 Stunden

Assignment Details:
Resource: Database Administrator
Function: Database Developer
Assignment Rate: 100%
Planned Work: 40 Stunden
Daily Allocation: 8h/Tag

Resource: Senior Backend Developer
Function: Code Reviewer
Assignment Rate: 20%
Planned Work: 8 Stunden
Daily Allocation: 1.6h/Tag

Costs:
- DBA: 40h × 90€/h = 3.600 €
- Senior Dev: 8h × 85€/h = 680 €
- Total: 4.280 €

Deliverables:
- Physical Database Schema (DDL)
- Table Creation Scripts
- Index-Definitionen
- Constraint-Definitionen
- Migration Scripts

Technical Requirements:
- PostgreSQL 14+
- JSON-Support für Produktkatalog
- Partitionierung für Order-Tables
- Full-Text-Search Setup
```

### **1.1.3 Database Performance Optimization** (Level 3)

```
Activity Name: Database Performance Optimization
Activity Type: Task
WBS-Code: 1.1.3
Top Activity: 1.1 Database Design
Priority: 2
Planning Mode: As soon as possible

Termine:
Planned Start: 27.03.2025
Planned End: 29.03.2025
Duration: 2 Arbeitstage

Dependencies:
- Predecessor: 1.1.2 Database Schema Creation (FS)
- Successor: 1.2.1 User Management API (SS, 3 Tage Delay)

Aufwand:
Initial Work: 40 Stunden
Planned Work: 40 Stunden
Left Work: 40 Stunden

Assignment Details:
Resource: Database Administrator
Function: Performance Tuner
Assignment Rate: 100%
Planned Work: 16 Stunden
Daily Allocation: 8h/Tag

Resource: Backend Team Lead
Function: Performance Architect
Assignment Rate: 75%
Planned Work: 24 Stunden
Daily Allocation: 6h/Tag

Costs:
- DBA: 16h × 90€/h = 1.440 €
- Team Lead: 24h × 95€/h = 2.280 €
- Total: 3.720 €

Deliverables:
- Index-Optimierungsplan
- Query-Performance-Analyse
- Caching-Strategien
- Monitoring-Setup
- Performance-Baseline-Dokumentation

Performance Targets:
- Query Response Time: < 100ms (95% Perzentil)
- Concurrent Users: 1000+ gleichzeitige Verbindungen
- Throughput: 10.000 Transaktionen/Minute
```

---

## **1.2 API Development** (Level 2)

```
Activity Name: API Development
Activity Type: Work Package
WBS-Code: 1.2
Top Activity: 1.0 Backend Development
Priority: 1
Planning Mode: As soon as possible

Termine:
Planned Start: 01.04.2025
Planned End: 15.05.2025
Duration: 32 Arbeitstage (6,4 Wochen)

Dependencies:
- Predecessor: 1.1 Database Design (FS, 2 Tage Delay)
- Successor: 1.3 Backend Testing (FS)

Aufwand:
Initial Work: 640 Stunden
Planned Work: 640 Stunden
Left Work: 640 Stunden

Costs:
Budget: 48.000 €
Planned Cost: 48.000 €

Resource Allocation:
- Senior Backend Developer: 280h × 85€/h = 23.800 €
- Junior Backend Developer: 320h × 65€/h = 20.800 €
- Backend Team Lead: 40h × 95€/h = 3.800 €

Technology Stack:
- Framework: Spring Boot 3.0
- Language: Java 17
- API Style: REST + GraphQL
- Documentation: OpenAPI 3.0
- Testing: JUnit 5, Mockito
```

### **1.2.1 User Management API** (Level 3)

```
Activity Name: User Management API
Activity Type: Task
WBS-Code: 1.2.1
Top Activity: 1.2 API Development
Priority: 1
Planning Mode: Work together

Termine:
Planned Start: 01.04.2025
Planned End: 08.04.2025
Duration: 6 Arbeitstage

Dependencies:
- Predecessor: 1.1.3 Database Performance Optimization (SS, 3 Tage Delay)
- Successor: 1.2.2 Product Catalog API (FS)

Aufwand:
Initial Work: 120 Stunden
Planned Work: 120 Stunden
Left Work: 120 Stunden

Assignment Details:
Resource: Senior Backend Developer
Function: API Developer
Assignment Rate: 100%
Planned Work: 80 Stunden
Daily Allocation: 7h/Tag

Resource: Junior Backend Developer
Function: Assistant Developer
Assignment Rate: 100%
Planned Work: 40 Stunden
Daily Allocation: 4h/Tag

Costs:
- Senior Dev: 80h × 85€/h = 6.800 €
- Junior Dev: 40h × 65€/h = 2.600 €
- Total: 9.400 €

API Specifications:
Endpoints zu entwickeln:
- POST /api/v1/users/register
- POST /api/v1/users/login
- GET /api/v1/users/profile
- PUT /api/v1/users/profile
- DELETE /api/v1/users/account
- POST /api/v1/users/password-reset
- GET /api/v1/users/verify-email

Features:
- JWT-Token-Authentication
- Role-Based Access Control (RBAC)
- Email-Verification
- Password-Reset-Flow
- Rate Limiting (100 req/min)
- Input Validation & Sanitization

Testing Requirements:
- Unit Test Coverage: > 90%
- Integration Tests für alle Endpoints
- Security Test Suite
- Performance Tests (< 50ms Response Time)
```

### **1.2.2 Product Catalog API** (Level 3)

```
Activity Name: Product Catalog API
Activity Type: Task
WBS-Code: 1.2.2
Top Activity: 1.2 API Development
Priority: 1
Planning Mode: As soon as possible

Termine:
Planned Start: 09.04.2025
Planned End: 18.04.2025
Duration: 8 Arbeitstage

Dependencies:
- Predecessor: 1.2.1 User Management API (FS)
- Successor: 1.2.3 Order Processing API (FS)

Aufwand:
Initial Work: 160 Stunden
Planned Work: 160 Stunden
Left Work: 160 Stunden

Assignment Details:
Resource: Senior Backend Developer
Function: Lead API Developer
Assignment Rate: 75%
Planned Work: 96 Stunden
Daily Allocation: 6h/Tag

Resource: Junior Backend Developer
Function: API Developer
Assignment Rate: 100%
Planned Work: 64 Stunden
Daily Allocation: 8h/Tag

Costs:
- Senior Dev: 96h × 85€/h = 8.160 €
- Junior Dev: 64h × 65€/h = 4.160 €
- Total: 12.320 €

API Specifications:
Endpoints zu entwickeln:
- GET /api/v1/products (mit Pagination, Filtering, Sorting)
- GET /api/v1/products/{id}
- POST /api/v1/products (Admin only)
- PUT /api/v1/products/{id}
- DELETE /api/v1/products/{id}
- GET /api/v1/categories
- GET /api/v1/products/search?q={query}
- POST /api/v1/products/{id}/reviews

Features:
- Full-Text-Search mit Elasticsearch
- Category-Tree-Navigation
- Product Variants Management
- Inventory Tracking
- Image Upload & Management
- SEO-Friendly URLs
- Multi-Language Support

Performance Requirements:
- Search Response: < 100ms
- Product List Load: < 200ms
- Support for 10.000+ Products
- Caching mit Redis (TTL: 5min)
```

### **1.2.3 Order Processing API** (Level 3)

```
Activity Name: Order Processing API
Activity Type: Task
WBS-Code: 1.2.3
Top Activity: 1.2 API Development
Priority: 1
Planning Mode: As soon as possible

Termine:
Planned Start: 21.04.2025
Planned End: 02.05.2025
Duration: 10 Arbeitstage

Dependencies:
- Predecessor: 1.2.2 Product Catalog API (FS)
- Successor: 1.2.4 Payment Integration API (FS)

Aufwand:
Initial Work: 200 Stunden
Planned Work: 200 Stunden
Left Work: 200 Stunden

Assignment Details:
Resource: Senior Backend Developer
Function: Order System Architect
Assignment Rate: 100%
Planned Work: 120 Stunden
Daily Allocation: 8h/Tag

Resource: Junior Backend Developer
Function: Order Developer
Assignment Rate: 100%
Planned Work: 80 Stunden
Daily Allocation: 8h/Tag

Costs:
- Senior Dev: 120h × 85€/h = 10.200 €
- Junior Dev: 80h × 65€/h = 5.200 €
- Total: 15.400 €

API Specifications:
Endpoints zu entwickeln:
- POST /api/v1/cart/items
- GET /api/v1/cart
- PUT /api/v1/cart/items/{id}
- DELETE /api/v1/cart/items/{id}
- POST /api/v1/orders
- GET /api/v1/orders
- GET /api/v1/orders/{id}
- PUT /api/v1/orders/{id}/status
- POST /api/v1/orders/{id}/cancel

Business Logic:
- Shopping Cart Management
- Order State Machine (New → Confirmed → Processing → Shipped → Delivered)
- Inventory Reservation
- Order Validation & Business Rules
- Tax Calculation (based on location)
- Shipping Cost Calculation
- Order History & Tracking

Data Consistency:
- ACID-Transactions für Order Creation
- Distributed Locking für Inventory
- Event Sourcing für Order History
- Saga Pattern für Multi-Step Processes
```

### **1.2.4 Payment Integration API** (Level 3)

```
Activity Name: Payment Integration API
Activity Type: Task
WBS-Code: 1.2.4
Top Activity: 1.2 API Development
Priority: 1
Planning Mode: As soon as possible

Termine:
Planned Start: 05.05.2025
Planned End: 15.05.2025
Duration: 9 Arbeitstage

Dependencies:
- Predecessor: 1.2.3 Order Processing API (FS)
- Successor: 1.3.1 Unit Tests (SS)

Aufwand:
Initial Work: 160 Stunden
Planned Work: 160 Stunden
Left Work: 160 Stunden

Assignment Details:
Resource: Senior Backend Developer
Function: Payment Integration Specialist
Assignment Rate: 100%
Planned Work: 120 Stunden
Daily Allocation: 8h/Tag

Resource: Backend Team Lead
Function: Security Reviewer
Assignment Rate: 25%
Planned Work: 40 Stunden
Daily Allocation: 2.5h/Tag

Costs:
- Senior Dev: 120h × 85€/h = 10.200 €
- Team Lead: 40h × 95€/h = 3.800 €
- Total: 14.000 €

API Specifications:
Endpoints zu entwickeln:
- POST /api/v1/payments/methods
- GET /api/v1/payments/methods
- POST /api/v1/payments/process
- GET /api/v1/payments/{id}/status
- POST /api/v1/payments/{id}/refund
- POST /api/v1/webhooks/stripe
- POST /api/v1/webhooks/paypal

Payment Providers:
- Stripe Integration (Credit Cards)
- PayPal Integration
- SEPA Direct Debit
- Bank Transfer
- Buy Now Pay Later (Klarna)

Security Requirements:
- PCI DSS Compliance
- No card data storage (tokenization only)
- 3D Secure Support
- Fraud Detection Integration
- SSL/TLS Encryption
- Webhook Signature Verification

Error Handling:
- Retry Mechanisms
- Idempotency Keys
- Payment Failure Recovery
- Automatic Refund Processing
```

---

## **1.3 Backend Testing** (Level 2)

```
Activity Name: Backend Testing
Activity Type: Work Package
WBS-Code: 1.3
Top Activity: 1.0 Backend Development
Priority: 2
Planning Mode: As soon as possible

Termine:
Planned Start: 16.05.2025
Planned End: 15.06.2025
Duration: 23 Arbeitstage (4,6 Wochen)

Dependencies:
- Predecessor: 1.2 API Development (FS)
- Successor: Frontend Integration (FS)

Aufwand:
Initial Work: 200 Stunden
Planned Work: 200 Stunden
Left Work: 200 Stunden

Costs:
Budget: 18.600 €
Planned Cost: 18.600 €

Resource Allocation:
- QA Engineer: 120h × 75€/h = 9.000 €
- Senior Backend Developer: 60h × 85€/h = 5.100 €
- Junior Backend Developer: 20h × 65€/h = 1.300 €

Testing Strategy:
- Test Pyramid: 70% Unit, 20% Integration, 10% E2E
- Automated Testing Pipeline
- Code Coverage Target: > 90%
- Performance Testing
- Security Testing
```

### **1.3.1 Unit Tests** (Level 3)

```
Activity Name: Unit Tests
Activity Type: Task
WBS-Code: 1.3.1
Top Activity: 1.3 Backend Testing
Priority: 1
Planning Mode: Work together

Termine:
Planned Start: 16.05.2025
Planned End: 26.05.2025
Duration: 8 Arbeitstage

Dependencies:
- Predecessor: 1.2.4 Payment Integration API (SS)
- Successor: 1.3.2 Integration Tests (FS)

Aufwand:
Initial Work: 80 Stunden
Planned Work: 80 Stunden
Left Work: 80 Stunden

Assignment Details:
Resource: Senior Backend Developer
Function: Test Developer
Assignment Rate: 75%
Planned Work: 48 Stunden
Daily Allocation: 6h/Tag

Resource: QA Engineer
Function: Test Architect
Assignment Rate: 50%
Planned Work: 32 Stunden
Daily Allocation: 4h/Tag

Costs:
- Senior Dev: 48h × 85€/h = 4.080 €
- QA Engineer: 32h × 75€/h = 2.400 €
- Total: 6.480 €

Test Scope:
Unit Tests für:
- User Management Service (20 Tests)
- Product Catalog Service (25 Tests)
- Order Processing Service (30 Tests)
- Payment Service (15 Tests)
- Database Repositories (35 Tests)
- Utility Classes (10 Tests)

Coverage Targets:
- Service Layer: > 95%
- Repository Layer: > 90%
- Utility Classes: > 85%
- Overall Coverage: > 90%

Testing Tools:
- JUnit 5 für Test Framework
- Mockito für Mocking
- TestContainers für Database Tests
- WireMock für API Mocking
```

### **1.3.2 Integration Tests** (Level 3)

```
Activity Name: Integration Tests
Activity Type: Task
WBS-Code: 1.3.2
Top Activity: 1.3 Backend Testing
Priority: 1
Planning Mode: As soon as possible

Termine:
Planned Start: 27.05.2025
Planned End: 05.06.2025
Duration: 8 Arbeitstage

Dependencies:
- Predecessor: 1.3.1 Unit Tests (FS)
- Successor: 1.3.3 Performance Tests (FS)

Aufwand:
Initial Work: 80 Stunden
Planned Work: 80 Stunden
Left Work: 80 Stunden

Assignment Details:
Resource: QA Engineer
Function: Integration Test Lead
Assignment Rate: 100%
Planned Work: 64 Stunden
Daily Allocation: 8h/Tag

Resource: Junior Backend Developer
Function: Test Support
Assignment Rate: 100%
Planned Work: 16 Stunden
Daily Allocation: 2h/Tag

Costs:
- QA Engineer: 64h × 75€/h = 4.800 €
- Junior Dev: 16h × 65€/h = 1.040 €
- Total: 5.840 €

Test Scenarios:
API Integration Tests:
- User Registration → Login → Profile Update Flow
- Product Search → Add to Cart → Checkout Flow
- Order Creation → Payment → Order Confirmation
- Admin Product Management Workflow

Database Integration:
- CRUD Operations für alle Entities
- Complex Queries mit Joins
- Transaction Rollback Scenarios
- Concurrent Access Testing

External Service Integration:
- Payment Provider APIs (Stripe, PayPal)
- Email Service Integration
- File Storage Service
- Search Engine (Elasticsearch)

Test Environment:
- Docker Compose Setup
- Test Database (PostgreSQL)
- Mock External Services
- CI/CD Pipeline Integration
```

### **1.3.3 Performance Tests** (Level 3)

```
Activity Name: Performance Tests
Activity Type: Task
WBS-Code: 1.3.3
Top Activity: 1.3 Backend Testing
Priority: 2
Planning Mode: As soon as possible

Termine:
Planned Start: 06.06.2025
Planned End: 15.06.2025
Duration: 7 Arbeitstage

Dependencies:
- Predecessor: 1.3.2 Integration Tests (FS)
- Successor: Deployment Preparation (FS)

Aufwand:
Initial Work: 40 Stunden
Planned Work: 40 Stunden
Left Work: 40 Stunden

Assignment Details:
Resource: QA Engineer
Function: Performance Test Specialist
Assignment Rate: 75%
Planned Work: 30 Stunden
Daily Allocation: 4.3h/Tag

Resource: Senior Backend Developer
Function: Performance Optimization
Assignment Rate: 25%
Planned Work: 10 Stunden
Daily Allocation: 1.4h/Tag

Costs:
- QA Engineer: 30h × 75€/h = 2.250 €
- Senior Dev: 10h × 85€/h = 850 €
- Total: 3.100 €

Performance Test Cases:
Load Testing:
- Normal Load: 100 concurrent users
- Peak Load: 500 concurrent users
- Stress Test: 1000+ concurrent users
- Endurance Test: 2h continuous load

API Performance Targets:
- Authentication: < 100ms (95% Perzentil)
- Product Search: < 200ms (95% Perzentil)
- Order Creation: < 500ms (95% Perzentil)
- Payment Processing: < 1000ms (95% Perzentil)

Database Performance:
- Query Response Times < 50ms
- Connection Pool Efficiency
- Index Performance Validation
- Concurrent Transaction Handling

Tools & Infrastructure:
- JMeter für Load Testing
- Grafana + InfluxDB für Monitoring
- Application Performance Monitoring (APM)
- AWS CloudWatch Integration

Deliverables:
- Performance Test Report
- Bottleneck Analysis
- Optimization Recommendations
- Performance Baseline Documentation
```

---

## **Gesamtübersicht Backend Development:**

### **Zusammenfassung der Kosten:**

```
1.1 Database Design:     10.200 €
1.2 API Development:     48.000 €
1.3 Backend Testing:     18.600 €
---
Total Backend:           76.800 €

Ressourcen-Auslastung:
- Backend Team Lead:     264h (6,6 Wochen)
- Senior Backend Dev:    784h (19,6 Wochen)  
- Junior Backend Dev:    520h (13 Wochen)
- Database Admin:        80h (2 Wochen)
- QA Engineer:          126h (3,15 Wochen)
```

### **Kritischer Pfad:**

```
1.1.1 → 1.1.2 → 1.1.3 → 1.2.1 → 1.2.2 → 1.2.3 → 1.2.4 → 1.3.1 → 1.3.2 → 1.3.3
Gesamtdauer: 65 Arbeitstage
```

### **Risiken & Mitigation:**

```
Hohes Risiko:
- Payment Integration Komplexität
- Performance Requirements
- External API Dependencies

Mitigation:
- Early Prototyping
- Continuous Performance Testing
- Fallback Payment Methods
```

Diese detaillierte WBS-Struktur zeigt, wie in ProjeQtor eine vollständige Backend-Entwicklung mit allen relevanten Daten (Zeit, Kosten, Ressourcen, Abhängigkeiten) strukturiert und verwaltet werden kann.