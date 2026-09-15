### **Regel 1: Nur auf unterster Ebene (Tasks) eingeben**

```
❌ FALSCH: Kosten bei 1.0 Backend Development eingeben
❌ FALSCH: Kosten bei 1.1 Database Design eingeben  
✅ RICHTIG: Kosten nur bei 1.1.1, 1.1.2, 1.1.3 eingeben
```

### **Regel 2: Parent Activities berechnen automatisch**

```
Parent Activities (1.0, 1.1, 1.2, 1.3) = Summe aller Child Activities
```

## **Konkrete Kosteneingabe-Anleitung:**

### **Schritt 1: Task-Level Activity erstellen (1.1.1)**

**Menüpfad:** `Planning` > `Activity` > `New Element` (+)

```
Activity Details:
Activity Name: Entity Relationship Design
WBS-Code: 1.1.1
Top Activity: 1.1 Database Design
Activity Type: Task
Planning Mode: As soon as possible

Aufwand & Kosten:
Initial Work: 32 Stunden
Left Work: 32 Stunden
Duration: 3 Tage
```

### **Schritt 2: Ressourcen zuweisen (Assignment)**

**Im gleichen Activity-Screen:** `Assignment Section`

```
Assignment 1:
Resource: Database Administrator
Function: Data Architect
Assignment Rate: 100%
Planned Work: 24 Stunden
Daily Cost: 90 €/Stunde
Calculated Cost: 24h × 90€ = 2.160€

Assignment 2:  
Resource: Backend Team Lead
Function: Technical Lead
Assignment Rate: 50%
Planned Work: 8 Stunden
Daily Cost: 95 €/Stunde
Calculated Cost: 8h × 95€ = 760€

Total Activity Cost: 2.920€ (automatisch berechnet)
```

### **Schritt 3: Materialkosten hinzufügen (optional)**

**Wenn materielle Kosten anfallen:**

```
Menüpfad: Planning > Activity > [Activity auswählen] > Cost Section

Material Cost Entry:
Description: Database Design Software Lizenz
Cost Type: Material
Amount: 500€
Date: 15.03.2025

Total Activity Cost wird automatisch auf: 3.420€ erhöht
```

## **Kostenarten in ProjeQtor:**

### **1. Resource Costs (Personalkosten)**

```
Automatische Berechnung:
Planned Work × Resource Daily Cost = Geplante Kosten
Real Work × Resource Daily Cost = Ist-Kosten

Beispiel:
24h × 90€/h = 2.160€ (geplant)
26h × 90€/h = 2.340€ (tatsächlich, wenn Überstunden)
```

### **2. Material Costs (Materialkosten)**

```
Manuelle Eingabe über Cost Section:
- Software-Lizenzen
- Hardware-Anschaffungen  
- Externe Dienstleistungen
- Reisekosten
```

### **3. Overhead Costs (Gemeinkosten)**

```
Option A: Als Prozentsatz in Global Parameters
Option B: Als separate Cost Entry
Option C: In Resource Daily Cost bereits enthalten
```

## **Vollständiges Beispiel - Kosteneingabe für 1.1.1:**

### **Task erstellen:**

```
Planning > Activity > New Element

General Information:
- Name: Entity Relationship Design
- WBS-Code: 1.1.1 (automatisch)
- Top Activity: 1.1 Database Design
- Type: Task
- Priority: 1

Dates & Duration:
- Planned Start: 15.03.2025  
- Planned End: 19.03.2025
- Duration: 3 Tage

Work:
- Initial Work: 32 Stunden
- Planned Work: 32 Stunden  
- Left Work: 32 Stunden
```

### **Assignments hinzufügen:**

```
Assignment Section > Add Assignment (+)

Assignment 1:
- Resource: Database Administrator
- Function: Data Architect  
- Rate: 100%
- Planned Work: 24h
- Period: 15.03.-19.03.2025

Assignment 2:
- Resource: Backend Team Lead
- Function: Technical Review
- Rate: 25% 
- Planned Work: 8h
- Period: 15.03.-19.03.2025
```

### **Kosten-Berechnung (automatisch):**

```
Resource Costs:
- DBA: 24h × 90€/h = 2.160€
- Team Lead: 8h × 95€/h = 760€
- Subtotal: 2.920€

Material Costs (optional):
- ER-Tool Lizenz: 200€
- Total: 3.120€
```

## **Was passiert automatisch:**

### **Parent Activity Update (1.1 Database Design):**

```
Nach Eingabe aller Child-Tasks (1.1.1, 1.1.2, 1.1.3):

Automatische Berechnung:
- Total Work: 32h + 48h + 40h = 120h
- Total Cost: 2.920€ + 4.280€ + 3.720€ = 10.920€  
- Duration: Von earliest start bis latest end
- Resource Summary: Alle verwendeten Ressourcen
```

### **Grandparent Activity Update (1.0 Backend Development):**

```
Nach allen Child-Packages (1.1, 1.2, 1.3):

Automatische Berechnung:
- Total Work: 120h + 640h + 200h = 960h
- Total Cost: 10.920€ + 48.000€ + 18.600€ = 77.520€
- Duration: Gesamter Zeitraum aller Packages
```

## **Wichtige Hinweise:**

### **❌ Häufige Fehler:**

```
1. Kosten auf Parent Level eingeben
   → Führt zu doppelter Kostenrechnung

2. Nur Gesamtkosten ohne Assignment  
   → Keine Ressourcenplanung möglich

3. Unrealistische Stundensätze
   → Budget-Planung unbrauchbar
```

### **✅ Best Practices:**

```
1. Immer Bottom-Up kostenschätzen
2. Realistische Stundensätze verwenden  
3. Materialkosten separat erfassen
4. Risikopuffer einplanen (10-20%)
5. Regelmäßig Ist-Kosten vs. Plan vergleichen
```

### **Kosten-Controlling:**

```
Follow-up > Real work allocation > Timesheet
→ Ist-Arbeitszeiten erfassen
→ Automatische Ist-Kosten-Berechnung
→ Earned Value Analyse möglich
```

**Die korrekte Kosteneingabe erfolgt also immer auf der untersten Task-Ebene über Ressourcen-Assignments, während die höheren Ebenen automatisch aggregiert werden.**