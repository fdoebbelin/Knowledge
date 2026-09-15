Basierend auf der Projeqtor-Dokumentation können Sie angemeldete Benutzer über die **Audit Connections** Funktion ermitteln:

## Audit Connections - "Who is online"

### **Menüpfad:**

`Settings` > `Audit connections`

### **Funktionen der Audit Connections:**

#### **Anzeige angemeldeter Benutzer:**

- **Übersicht:** "Who is online" - zeigt alle aktuell angemeldeten Benutzer
- **Plattform-Info:** Welche Plattform der Benutzer verwendet
- **Browser-Info:** Welchen Browser der Benutzer nutzt
- **Zeitstempel:**
    - Datum und Zeit des ersten Zugriffs
    - Datum und Zeit des letzten Zugriffs
- **Verbindungsdauer:** Wie lange der Benutzer verbunden ist

#### **Administrator-Funktionen:**

- **Zwangsabmeldung:** Administrator kann jeden Benutzer abmelden (außer seiner eigenen aktuellen Verbindung)
- **Verbindungsmanagement:** Kontrolle über aktive Sitzungen

## Zusätzliche Verwaltungsfunktionen

### **Administration Console - Manage Connections**

**Menüpfad:** `Administration Console` > `Manage connections`

#### **Erweiterte Verbindungsverwaltung:**

- **Disconnect all users:** Alle Benutzer abmelden (außer eigener Verbindung)
- **Application status:** Anzeige des Anwendungsstatus
- **Open/Close application:** Anwendung für neue Verbindungen öffnen/schließen
- **Verzögerung:** Abmeldung wird wirksam, wenn Browser nach Alerts prüft (abhängig vom Parameter "delay to check alerts")

### **Automatische Bereinigung**

**Menüpfad:** `Administration Console` > `Maintenance of Data`

#### **Verbindungshistorie verwalten:**

- **Delete history of connections:** Alte Verbindungsdaten löschen
- **Automatisierung:** Bereinigung kann automatisiert werden
- **Archivierung:** Verbindungshistorie kann archiviert werden

## Monitoring und Benachrichtigungen

### **Alert-System:**

- **Internal Alerts:** Administrator kann Benutzer über geplante Wartungen informieren
- **Message Pop-ups:** Direkte Benachrichtigung angemeldeter Benutzer
- **SSO-Integration:** Bei Single Sign-On verschiedene Abmeldeoptionen

### **Berichtswesen:**

- **Report #123:** "Connections audit" - Detaillierte Verbindungsberichte
- **Zeitbasierte Auswertungen:** Analyse der Benutzeraktivität

## Praktische Anwendung

### **Für Administratoren:**

1. **Wartung planen:** Vor Updates prüfen, wer online ist
2. **Sicherheit:** Verdächtige Verbindungen überwachen
3. **Performance:** Bei Performance-Problemen aktive Sessions prüfen
4. **Support:** Bei Benutzerproblemen Verbindungsstatus überprüfen

### **Informationen pro Benutzer:**

- **Aktuelle Aktivität:** Ist der Benutzer wirklich aktiv oder nur eingeloggt?
- **Browser/Plattform:** Hilft bei technischen Problemen
- **Sitzungsdauer:** Erkennung von "hängenden" Sessions
- **Letzter Zugriff:** Wann war der Benutzer zuletzt aktiv?

Die **Audit Connections** Funktion ist somit das zentrale Tool in Projeqtor, um zu ermitteln, welche Benutzer aktuell angemeldet sind und deren Verbindungsdetails zu überwachen.