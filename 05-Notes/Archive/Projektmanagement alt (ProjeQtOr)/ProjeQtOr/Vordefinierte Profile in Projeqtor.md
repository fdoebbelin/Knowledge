### **Administrator**

- **Zweck**: Vollständige Systemverwaltung
- **Berechtigung**: Uneingeschränkter Zugriff auf alle Daten und Funktionen
- **Besonderheiten**:
    - Kann die Anwendung verwalten und konfigurieren
    - Sieht alle Daten ohne Einschränkungen
    - Der Benutzer "admin" ist bereits vordefiniert
    - Nur für Administrator-Profile sichtbar: CRON-Button zur Überwachung von Hintergrundprozessen

### **Supervisor (Projektüberwacher)**

- **Zweck**: Projektüberwachung und -kontrolle
- **Berechtigung**: Sichtbarkeit über alle Projekte
- **Besonderheiten**:
    - Ermöglicht das Monitoring aller Projekte
    - Übergreifende Sicht auf Projektportfolio

### **Project Leader (Projektleiter)**

- **Zweck**: Führung und Management eigener Projekte
- **Berechtigung**: Vollständiger Zugriff auf zugewiesene Projekte
- **Besonderheiten**:
    - Komplette Kontrolle über eigene Projekte
    - Kann Ressourcen in Projekten zuweisen
    - Hierarchie beachten: Ein Projektleiter kann nur Profile zuweisen, die in der Sortierreihenfolge unter seinem eigenen Profil stehen

### **Project Member (Projektmitglied)**

- **Zweck**: Aktive Mitarbeit in Projekten
- **Berechtigung**: Arbeitet an zugewiesenen Projekten
- **Besonderheiten**:
    - Standardprofil für Teammitglieder
    - Zugriff auf Projektdaten entsprechend der Zuweisung

### **Project Guest (Projektgast)**

- **Zweck**: Eingeschränkte Projektsicht
- **Berechtigung**: Begrenzte Sichtbarkeit auf zugewiesene Projekte
- **Besonderheiten**:
    - Minimale Rechte für externe Stakeholder
    - Der Benutzer "guest" ist bereits vordefiniert

## Wichtige Eigenschaften des Profilsystems

### **Flexible Zuweisungen**

- Eine Ressource kann unterschiedliche Profile in verschiedenen Projekten haben
- Profile können sowohl Benutzern als auch Kontakten zugewiesen werden
- Mehrere Benutzer können dasselbe Profil teilen

### **Zugriffskontrolle**

- **CRUD-Rechte**: Create (Erstellen), Read (Lesen), Update (Ändern), Delete (Löschen)
- **Sichtbarkeitsstufen**:
    - Keine Elemente
    - Nur eigene Elemente
    - Nur Elemente, für die man verantwortlich ist
    - Nur Elemente eigener Projekte
    - Alle Elemente aller Projekte

### **Spezifische Funktionen**

- Reports-Zugriff je Profil konfigurierbar
- Dokumentenrechte nach Verzeichnisstruktur
- Workflow-Übergänge profilabhängig steuerbar
- Planungsrechte und Kostenzugriff differenziert

Das Profilsystem in Projeqtor ermöglicht eine sehr granulare Rechteverwaltung und unterstützt verschiedene Organisationsstrukturen und Projekttypen.