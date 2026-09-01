## 1. Projekt erstellen

**Menü:** Projects → Projects **Aktion:** Neues Projekt anlegen

**Neue Projekterstellung:**

- Klick auf `New` Button (grünes Plus-Symbol)
- Projektdaten eingeben:

### Grunddaten (Description Section):

- **Name:** 25-jähriges Firmenjubiläum - Festveranstaltung für 200 Gäste
- **Project code:** JUBIL-2025
- **Project type:** Operational project (OPE)
- **Description:** Planung und Durchführung einer Festveranstaltung zum 25-jährigen Firmenjubiläum mit 200 Gästen

### Termine (Progress Section):

- **Validated start date:** 01.01.2025
- **Validated end date:** 30.06.2025
- **Duration:** 180 Tage

### Team (Treatment Section):

- **Manager:** Sarah M.
- **Status:** Under construction

**Speichern:** Strg+S oder Save Button

## 2. Team-Ressourcen anlegen

**Menü:** Environmental parameters → Resource

**Für jede Person eine neue Ressource erstellen:**

### Sarah M. (Projektleiterin):

- **Real name:** Sarah M.
- **Initials:** SM
- **Email address:** sarah.m@firma.de
- **Capacity (FTE):** 1.0
- **Main function:** Project Manager
- **Team:** Team Alpha

### Michael K.:

- **Real name:** Michael K.
- **Initials:** MK
- **Email address:** michael.k@firma.de
- **Capacity (FTE):** 1.0
- **Main function:** Event Coordinator
- **Team:** Team Alpha

### Anna L.:

- **Real name:** Anna L.
- **Initials:** AL
- **Email address:** anna.l@firma.de
- **Capacity (FTE):** 1.0
- **Main function:** Catering Manager
- **Team:** Team Alpha

### Tom R.:

- **Real name:** Tom R.
- **Initials:** TR
- **Email address:** tom.r@firma.de
- **Capacity (FTE):** 1.0
- **Main function:** Technical Manager
- **Team:** Team Alpha

### Lisa P.:

- **Real name:** Lisa P.
- **Initials:** LP
- **Email address:** lisa.p@firma.de
- **Capacity (FTE):** 1.0
- **Main function:** Marketing Manager
- **Team:** Team Alpha

## 3. Ressourcen dem Projekt zuweisen

**Zurück zu:** Projects → Projects → JUBIL-2025

**Allocations Section:**

- Klick auf `Allocate new resource` Button
- Für jede Ressource:
    - **Resource:** Entsprechende Person auswählen
    - **Profile:** Project member
    - **Rate:** 100%
    - **Start date:** 01.01.2025
    - **End date:** 30.06.2025

## 4. Arbeitspakete als Aktivitäten anlegen

**Menü:** Planning and Follow-up → Activity

### AP 1: Konzeption und Planung

- **Name:** Konzeption und Planung
- **Project:** JUBIL-2025
- **Type:** Analysis
- **Priority:** 500
- **Planning mode:** As soon as possible

**Progress Section:**

- **Validated start date:** 01.01.2025
- **Validated end date:** 22.01.2025
- **Validated work:** 15 Tage

**Assignment Section:**

- Klick auf `Assign resource`
- **Resource:** Sarah M.
- **Function:** Project Manager
- **Assigned work:** 15 Tage
- **Assignment rate:** 100%

### AP 2: Location-Suche und Buchung

- **Name:** Location-Suche und Buchung
- **Project:** JUBIL-2025
- **Type:** Organization
- **Priority:** 500
- **Planning mode:** Must not start before validated start date

**Progress Section:**

- **Validated start date:** 23.01.2025 (nach AP 1)
- **Validated end date:** 28.02.2025
- **Validated work:** 20 Tage

**Assignment Section:**

- **Resource:** Michael K.
- **Function:** Event Coordinator
- **Assigned work:** 20 Tage

**Predecessor Section:**

- Klick auf `Add dependency`
- **Predecessor:** AP 1 (Konzeption und Planung)
- **Type:** End-Start
- **Delay:** 0

### AP 3: Catering-Organisation

- **Name:** Catering-Organisation
- **Project:** JUBIL-2025
- **Type:** Organization
- **Priority:** 500

**Progress Section:**

- **Validated start date:** 01.03.2025
- **Validated end date:** 21.03.2025
- **Validated work:** 15 Tage

**Assignment Section:**

- **Resource:** Anna L.
- **Function:** Catering Manager
- **Assigned work:** 15 Tage

**Predecessor Section:**

- **Predecessor:** AP 2 (Location-Suche)
- **Type:** End-Start

### AP 4: Programm und Entertainment

- **Name:** Programm und Entertainment
- **Project:** JUBIL-2025
- **Type:** Development
- **Priority:** 500

**Progress Section:**

- **Validated start date:** 23.01.2025
- **Validated end date:** 21.03.2025
- **Validated work:** 30 Tage

**Assignment Section:**

- **Resource:** Tom R.
- **Function:** Technical Manager
- **Assigned work:** 30 Tage

**Predecessor Section:**

- **Predecessor:** AP 1 (Konzeption und Planung)
- **Type:** End-Start

### AP 5: Marketing und Einladungen

- **Name:** Marketing und Einladungen
- **Project:** JUBIL-2025
- **Type:** Communication
- **Priority:** 500

**Progress Section:**

- **Validated start date:** 01.04.2025
- **Validated end date:** 30.04.2025
- **Validated work:** 20 Tage

**Assignment Section:**

- **Resource:** Lisa P.
- **Function:** Marketing Manager
- **Assigned work:** 20 Tage

**Predecessor Section:**

- **Predecessor:** AP 1 (Konzeption und Planung)
- **Type:** End-Start
- **Predecessor:** AP 2 (Location-Suche)
- **Type:** End-Start

### AP 6: Dekoration und Ausstattung

- **Name:** Dekoration und Ausstattung
- **Project:** JUBIL-2025
- **Type:** Implementation
- **Priority:** 500

**Progress Section:**

- **Validated start date:** 16.06.2025
- **Validated end date:** 27.06.2025
- **Validated work:** 10 Tage

**Assignment Section:**

- **Resource:** Michael K.
- **Function:** Event Coordinator
- **Assigned work:** 10 Tage

**Predecessor Section:**

- **Predecessor:** AP 2 (Location-Suche)
- **Type:** End-Start

### AP 7: Technik und AV-Equipment

- **Name:** Technik und AV-Equipment
- **Project:** JUBIL-2025
- **Type:** Technical
- **Priority:** 500

**Progress Section:**

- **Validated start date:** 16.06.2025
- **Validated end date:** 27.06.2025
- **Validated work:** 10 Tage

**Assignment Section:**

- **Resource:** Tom R.
- **Function:** Technical Manager
- **Assigned work:** 10 Tage

**Predecessor Section:**

- **Predecessor:** AP 2 (Location-Suche)
- **Type:** End-Start
- **Predecessor:** AP 4 (Programm und Entertainment)
- **Type:** End-Start

### AP 8: Durchführung der Veranstaltung

- **Name:** Durchführung der Veranstaltung
- **Project:** JUBIL-2025
- **Type:** Execution
- **Priority:** 500

**Progress Section:**

- **Validated start date:** 30.06.2025
- **Validated end date:** 30.06.2025
- **Validated work:** 8 Tage (ganzes Team)

**Assignment Section:**

- **Resource:** Sarah M., **Assigned work:** 1 Tag
- **Resource:** Michael K., **Assigned work:** 1 Tag
- **Resource:** Anna L., **Assigned work:** 1 Tag
- **Resource:** Tom R., **Assigned work:** 1 Tag
- **Resource:** Lisa P., **Assigned work:** 1 Tag

**Predecessor Section:**

- Alle vorherigen APs als Vorgänger

## 5. Meilensteine anlegen

**Menü:** Planning and Follow-up → Milestone

### Meilenstein 1: Konzept finalisiert

- **Name:** Konzept finalisiert und genehmigt
- **Project:** JUBIL-2025
- **Type:** Key date
- **Validated due date:** 31.01.2025
- **Planning mode:** Fixed milestone

**Linked Elements:**

- AP 1 (Konzeption und Planung) verknüpfen

### Meilenstein 2: Location gebucht

- **Name:** Location gebucht und Verträge unterzeichnet
- **Project:** JUBIL-2025
- **Validated due date:** 28.02.2025

### Meilenstein 3: Dienstleister beauftragt

- **Name:** Alle Dienstleister beauftragt
- **Project:** JUBIL-2025
- **Validated due date:** 31.03.2025

### Meilenstein 4: Einladungen versendet

- **Name:** Einladungen versendet - 200 Gäste erreicht
- **Project:** JUBIL-2025
- **Validated due date:** 30.04.2025

### Meilenstein 5: Finale Vorbereitung

- **Name:** Finale Vorbereitung abgeschlossen
- **Project:** JUBIL-2025
- **Validated due date:** 27.06.2025

### Meilenstein 6: Veranstaltung erfolgreich

- **Name:** Veranstaltung erfolgreich durchgeführt
- **Project:** JUBIL-2025
- **Validated due date:** 30.06.2025

## 6. Risiken dokumentieren

**Menü:** Risk Management & Ticketing → Risks

### Risiko 1: Location nicht verfügbar

- **Name:** Wunsch-Location nicht verfügbar
- **Project:** JUBIL-2025
- **Type:** Planning Risk
- **Severity:** High (Auswirkung: 2-3 Wochen Verzug)
- **Likelihood:** Medium
- **Impact:** Verzögerung des Gesamtprojekts
- **Description:** Beliebte Event-Locations sind oft früh ausgebucht

**Linked Elements:**

- AP 2 (Location-Suche) verknüpfen

### Risiko 2: Caterer-Ausfall

- **Name:** Caterer sagt kurzfristig ab
- **Project:** JUBIL-2025
- **Severity:** Medium
- **Likelihood:** Low
- **Impact:** 1-2 Wochen Verzug

### Risiko 3: Schlechtes Wetter

- **Name:** Schlechtes Wetter am Veranstaltungstag
- **Project:** JUBIL-2025
- **Severity:** Medium
- **Likelihood:** Medium
- **Impact:** Event-Qualität leidet

## 7. Gegenmaßnahmen als Actions anlegen

**Menü:** Risk Management & Ticketing → Actions

### Action 1: Alternative Locations

- **Name:** Alternative Locations vorselektieren
- **Project:** JUBIL-2025
- **Type:** Preventive
- **Due date:** 15.01.2025
- **Responsible:** Michael K.
- **Description:** 3 Alternative Locations bereits identifizieren und bewerten

**Linked Elements:**

- Risiko 1 verknüpfen

### Action 2: Backup-Caterer

- **Name:** Backup-Caterer in Reserve
- **Project:** JUBIL-2025
- **Type:** Preventive
- **Due date:** 20.02.2025
- **Responsible:** Anna L.
- **Description:** Backup-Liste mit 5 alternativen Caterern erstellen

### Action 3: Indoor-Alternative

- **Name:** Indoor-Alternative vorbereiten
- **Project:** JUBIL-2025
- **Type:** Preventive
- **Due date:** 01.06.2025
- **Responsible:** Michael K.
- **Description:** Indoor-Backup in derselben Location organisieren

## 8. Budget und Kosten einrichten

**Menü:** Financial → Budget

### Hauptbudget erstellen:

- **Name:** Firmenjubiläum 25 Jahre - Gesamtbudget
- **Project:** JUBIL-2025
- **Budget type:** Event Budget
- **Target amount:** 50.000 € (Beispielwert)

### Unterbudgets:

- **Catering:** 20.000 €
- **Location:** 10.000 €
- **Dekoration:** 8.000 €
- **Technik:** 7.000 €
- **Marketing:** 3.000 €
- **Sonstiges:** 2.000 €

## 9. Überwachung und Reporting einrichten

**Menü:** Settings → Automation → Unit indicators

### Indikator für Terminüberwachung:

- **Name:** Meilenstein-Verzug Firmenjubiläum
- **Element:** Milestone
- **Project:** JUBIL-2025
- **Type:** Respect of validated due date
- **Warning value:** 3 Tage
- **Alert value:** 7 Tage

**Mail receivers:** Sarah M., Geschäftsführung

## 10. Gantt-Planung überprüfen

**Menü:** Planning and Follow-up → Planning view

**Aktionen:**

1. **Project selector:** JUBIL-2025 auswählen
2. **Planning calculation:** Klick auf `Calculate planning`
3. **Baseline speichern:** Klick auf `Save baseline` → "Ursprungsplanung"
4. **Abhängigkeiten überprüfen:** Alle Predecessor/Successor-Beziehungen kontrollieren
5. **Kritischen Pfad anzeigen:** Option "Critical path" aktivieren
6. **Ressourcen-Auslastung prüfen:** Resource planning öffnen

## 11. Dashboard konfigurieren

**Menü:** Planning and Follow-up → Today

**Konfiguration:**

- **Projects section:** Firmenjubiläum-Projekt prominent anzeigen
- **Task list:** Offene Aufgaben für alle Teammitglieder
- **Milestone-Übersicht:** Nächste anstehende Meilensteine

## 12. Regelmäßige Reviews einrichten

**Menü:** Steering → Meetings

### Wöchentliche Team-Meetings:

- **Name:** Firmenjubiläum - Wöchentliches Team-Meeting
- **Project:** JUBIL-2025
- **Meeting type:** Progress Meeting
- **Start date:** 06.01.2025
- **Recurrence:** Weekly (Montags, 10:00 Uhr)
- **Duration:** 1 Stunde

**Attendees:**

- Alle Team-Mitglieder zuweisen

### Monatliche Stakeholder-Updates:

- **Name:** Firmenjubiläum - Monatliches Stakeholder-Update
- **Project:** JUBIL-2025
- **Meeting type:** Steering Committee
- **Recurrence:** Monthly (erster Freitag im Monat)

## 13. Finale Projekteinstellungen

**Zurück zu:** Projects → Projects → JUBIL-2025

**Treatment Section:**

- **Status:** In progress (von "Under construction" ändern)
- **Priority:** 300 (hoch)
- **Health status:** Green
- **Overall progress:** 0%

**Notes Section:**

- Notiz hinzufügen: "Projektstart: Team Alpha bereitet 25-jähriges Firmenjubiläum vor. Veranstaltung für 200 Gäste geplant."

**Speichern:** Strg+S

---

## Nächste Schritte nach Eingabe:

1. **Gantt-Chart exportieren** (PDF) für Stakeholder-Präsentation
2. **Baseline als Referenz** für spätere Abweichungsanalysen
3. **Weekly Reports** für Fortschrittsverfolgung einrichten
4. **Resource planning** regelmäßig überwachen
5. **Risk register** wöchentlich aktualisieren

Das Projekt ist nun vollständig in ProjeQtOr abgebildet und kann über die verschiedenen Ansichten (Gantt, Kanban, Today Dashboard) überwacht und gesteuert werden.