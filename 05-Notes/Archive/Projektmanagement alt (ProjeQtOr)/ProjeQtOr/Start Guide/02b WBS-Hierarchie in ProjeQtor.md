### **Automatische Ebenen-Struktur:**

```
Level 0: Projekt
└── Level 1: Hauptaktivitäten (Phasen)
    └── Level 2: Unteraktivitäten (Arbeitspakete)
        └── Level 3: Tasks (Aufgaben)
            └── Level 4: Sub-Tasks (optional)
```

### **Konkrete Darstellung Backend Development:**

**Projekt-Ebene (Level 0):**

```
E-Commerce Platform Development
├── [Weitere Hauptbereiche]
└── 1.0 Backend Development
```

**Hauptaktivitäten-Ebene (Level 1):**

```
1.0 Backend Development
├── 1.1 Database Design
├── 1.2 API Development
└── 1.3 Backend Testing
```

**Arbeitspaket-Ebene (Level 2):**

```
1.1 Database Design
├── 1.1.1 Entity Relationship Design
├── 1.1.2 Database Schema Creation
└── 1.1.3 Database Performance Optimization

1.2 API Development
├── 1.2.1 User Management API
├── 1.2.2 Product Catalog API
├── 1.2.3 Order Processing API
└── 1.2.4 Payment Integration API

1.3 Backend Testing
├── 1.3.1 Unit Tests
├── 1.3.2 Integration Tests
└── 1.3.3 Performance Tests
```

## **Eigenschaften der WBS-Hierarchie:**

### **1. Automatische Nummerierung:**

```
ProjeQtor generiert automatisch:
- 1.0 (Level 1)
  - 1.1 (Level 2)
    - 1.1.1 (Level 3)
    - 1.1.2 (Level 3)
  - 1.2 (Level 2)
    - 1.2.1 (Level 3)
```

### **2. Vererbung von Eigenschaften:**

```
Parent Activity (1.0 Backend Development):
- Start Date: 15.03.2025
- End Date: 15.06.2025
- Total Work: 960h
- Total Cost: 76.800€

Child Activities erben und beeinflussen:
- 1.1 Database Design: 15.03. - 29.03. (120h, 10.200€)
- 1.2 API Development: 01.04. - 15.05. (640h, 48.000€)
- 1.3 Backend Testing: 16.05. - 15.06. (200h, 18.600€)

= Parent wird automatisch berechnet!
```

### **3. Aggregation nach oben:**

```
Bottom-Up Calculation:
1.1.1 + 1.1.2 + 1.1.3 = 1.1 Database Design
1.2.1 + 1.2.2 + 1.2.3 + 1.2.4 = 1.2 API Development
1.3.1 + 1.3.2 + 1.3.3 = 1.3 Backend Testing

1.1 + 1.2 + 1.3 = 1.0 Backend Development
```

## **Praktische Umsetzung in ProjeQtor:**

### **Schritt 1: Hauptaktivität erstellen**

```
Menüpfad: Planning > Activity > New Element

Activity Name: Backend Development
WBS-Code: 1.0
Top Activity: [leer lassen für Level 1]
Activity Type: Phase
Planning Mode: As soon as possible
```

### **Schritt 2: Unteraktivitäten erstellen**

```
Activity Name: Database Design
WBS-Code: 1.1
Top Activity: 1.0 Backend Development ← Hier wird die Hierarchie definiert!
Activity Type: Work Package
```

### **Schritt 3: Tasks erstellen**

```
Activity Name: Entity Relationship Design
WBS-Code: 1.1.1
Top Activity: 1.1 Database Design ← Nächste Ebene
Activity Type: Task
```

## **Gantt-Chart Darstellung:**

```
E-Commerce Platform Development
├─ 1.0 Backend Development                    [████████████████████████████████] 65 Tage
│  ├─ 1.1 Database Design                     [████████] 10 Tage
│  │  ├─ 1.1.1 Entity Relationship Design    [███] 3 Tage
│  │  ├─ 1.1.2 Database Schema Creation      [█████] 5 Tage
│  │  └─ 1.1.3 Database Performance Opt.     [██] 2 Tage
│  │
│  ├─ 1.2 API Development                     [████████████████████████] 32 Tage
│  │  ├─ 1.2.1 User Management API           [██████] 6 Tage
│  │  ├─ 1.2.2 Product Catalog API           [████████] 8 Tage
│  │  ├─ 1.2.3 Order Processing API          [██████████] 10 Tage
│  │  └─ 1.2.4 Payment Integration API       [█████████] 9 Tage
│  │
│  └─ 1.3 Backend Testing                     [███████████████████████] 23 Tage
│     ├─ 1.3.1 Unit Tests                     [████████] 8 Tage
│     ├─ 1.3.2 Integration Tests              [████████] 8 Tage
│     └─ 1.3.3 Performance Tests             [███████] 7 Tage
```

## **Automatische Berechnungen:**

### **Roll-Up von Daten:**

```
Level 3 (Tasks) definieren:
- Aufwand (Initial Work)
- Dauer (Duration)
- Kosten (Costs)
- Ressourcen (Assignments)

Level 2 & 1 (Packages/Phases) berechnen automatisch:
- Summe aller Child-Aufwände
- Min(Start) bis Max(End) aller Children
- Summe aller Child-Kosten
- Aggregierte Ressourcen-Zuweisungen
```

### **Beispiel automatische Berechnung:**

```
1.1.1 Entity Relationship Design:    32h,  3 Tage,  2.920€
1.1.2 Database Schema Creation:      48h,  5 Tage,  4.280€
1.1.3 Database Performance Opt.:     40h,  2 Tage,  3.720€
─────────────────────────────────────────────────────────
1.1 Database Design (automatisch):  120h, 10 Tage, 10.920€
```

## **Vorteile der Hierarchie:**

### **1. Detaillierung nach Bedarf:**

```
Projektleitung: Sieht nur Level 1 (Phasen)
Team Leads: Sehen Level 2 (Arbeitspakete)  
Entwickler: Arbeiten auf Level 3 (Tasks)
```

### **2. Flexible Planung:**

```
Top-Down: Grobe Schätzung auf hoher Ebene
Bottom-Up: Detaillierte Planung auf Task-Ebene
Hybrid: Kombination beider Ansätze
```

### **3. Monitoring auf allen Ebenen:**

```
Level 1: Projekt-Dashboard für Management
Level 2: Team-Status für Leads
Level 3: Task-Tracking für Entwickler
```

**Die WBS-Hierarchie in ProjeQtor ermöglicht es, komplexe Projekte strukturiert zu verwalten, während gleichzeitig die automatische Aggregation und Berechnung auf allen Ebenen funktioniert.**