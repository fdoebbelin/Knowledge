## Projekttypen in Projeqtor

### **1. Operational Project (OPE)**

- **Code:** OPE
- **Zweck:** Standard-Projekttyp für operative Projekte
- **Eigenschaften:**
    - Häufigster Projekttyp zur Verfolgung von Aktivitäten
    - Kann sowohl fakturierbare als auch nicht-fakturierbare Projekte sein
    - Unterstützt verschiedene Billing Types: Manual Billed, Fixed Price, Capped Time, Time & Materials, Internal
    - Alle neuen Projekttypen werden standardmäßig mit OPE-Code erstellt
    - Vollständige Funktionalität verfügbar

### **2. Administrative Project (ADM)**

- **Code:** ADM
- **Zweck:** Verwaltung nicht-produktiver Arbeiten
- **Eigenschaften:**
    - Für Urlaub, Krankheit, Schulungen etc.
    - **Automatischer Zugang:** Alle Ressourcen können Real Work eingeben ohne Projekt-Zuweisung oder Activity-Assignment
    - Automatische Assignments für alle Projektaufgaben werden erstellt
    - **Nicht sichtbar in Gantt-Charts**
    - Einige Bereiche und Felder sind nicht verfügbar (Paused, Fix Planning, Minimum Threshold)
    - Alle neuen Admin-Typen erhalten ADM-Code

### **3. Template Project (TMP)**

- **Code:** TMP
- **Zweck:** Projektvorlagen
- **Eigenschaften:**
    - **Keine Arbeitsverfolgung** - nur für Template-Definitionen
    - Können als operative Projekte kopiert werden
    - **Jeder Project Leader** kann solche Projekte kopieren ohne Zuweisung
    - Alle neuen Template-Typen erhalten TMP-Code
    - Nicht in der Planung berücksichtigt, auch bei vorhandenen Assignments
    - Keine Planungsdetails anzeigbar

### **4. Proposal Project (PRP)**

- **Code:** PRP
- **Zweck:** Strategische Projektbewertung
- **Eigenschaften:**
    - **Keine Arbeitsverfolgung** - strategische Bewertung
    - Bestimmt ob ein Projekt strategisch interessant ist
    - **4 zusätzliche Felder verfügbar:**
        - Strength (Stärken)
        - Weakness (Schwächen)
        - Opportunity (Chancen)
        - Threat (Bedrohungen)
    - **Strategic Value ist Pflichtfeld**
    - Automatisch als "Under Construction" gespeichert und Read-Only
    - Alle neuen Proposal-Typen erhalten PRP-Code

## Konfiguration von Projekttypen

### **Menüpfad:** `Settings` > `List of Types` > `Projects types`

### **Pflichtfelder für Projekttypen:**

- **Id:** Eindeutige ID für den Typ
- **Name:** Name des Typs
- **Code:** Code des Projekttyps (OPE, ADM, TMP, PRP)
- **Workflow:** Definiert Workflow für Statusübergänge
- **Sort order:** Reihenfolge in Listen
- **Billing type:** Abrechnungsverhalten (siehe Incomes)
- **Closed:** Checkbox für archivierte Typen
- **Description:** Beschreibung des Typs

### **Wichtige Hinweise:**

1. **Code-Abhängigkeit:** Das Verhalten der Projekte hängt stark vom **Code** ab, nicht nur vom Namen
2. **Anpassbar:** Sie können eigene Projekttypen erstellen, aber der Code bestimmt das Grundverhalten
3. **Workflow:** Jeder Projekttyp kann einen eigenen Workflow für Statusübergänge haben
4. **Billing:** Verschiedene Abrechnungsarten können projekttyp-spezifisch konfiguriert werden

Die vier Grundtypen decken die häufigsten Anwendungsfälle ab: operative Projekte, administrative Tätigkeiten, Vorlagen und strategische Bewertungen.