## Modulübersicht und Lernziele

### Überblick
Änderungsmanagement (Change Management) ist ein strukturierter Prozess zur Steuerung von Änderungen im Projektumfang (Scope), zeitlichen Ablauf, Ressourcen oder Qualität. Es schützt das Projekt vor unkontrolliertem Scope-Creep (schleichender Umfangserweiterung) und gewährleistet, dass alle Änderungen dokumentiert, bewertet und genehmigt werden.

In der Praxis zeigt sich häufig: **Projekte scheitern nicht an unvorhergesehenen Problemen, sondern an unkontrollierten Änderungen.** Dieses Modul vermittelt die Werkzeuge und Prozesse, um Änderungen professionell zu managen.

### Lernziele
Nach diesem Modul können Sie:
- Den Change-Request-Prozess strukturiert durchführen
- Auswirkungen von Änderungen systematisch analysieren (Impact-Analyse)
- Scope-Creep erkennen und gezielt vermeiden
- Change-Requests dokumentieren und rückverfolgbar machen (Traceability)
- Entscheidungen über Änderungen professionell treffen
- Die Integration mit YOUTRACK für Change-Management nutzen

---

## Thema 1: Grundlagen des Änderungsmanagements

### 1.1 Was ist eine Änderung (Change)?
Eine **Änderung** ist eine bewusste Abweichung von den genehmigten Projektplänen (Umfang, Zeit, Kosten, Qualität). Sie kann:
- **Geplant** sein (antizipierte Risiken, bekannte Anforderungsänderungen)
- **Ungeplant** sein (Fehler, externe Ereignisse, Stakeholder-Wünsche)
- **Von innen** kommen (Projektteam, Auftraggeber)
- **Von außen** kommen (Kunden, Regulierung, Marktänderungen)

### 1.2 Warum ist Änderungsmanagement kritisch?
Ohne strukturiertes Änderungsmanagement tritt häufig **Scope-Creep** auf – der schleichende Anstieg von Anforderungen ohne entsprechende Zeit- oder Kostensteigerung. Folgen:
- Terminüberschreitungen (Time Overrun)
- Budgetüberschreitungen (Cost Overrun)
- Qualitätsverschlechterung
- Demotivation im Team
- Erhöhte Fehlerquoten

**Beispiel Scope-Creep:**
Ein Softwareprojekt soll ein einfaches Verwaltungstool mit Benutzerverwaltung und Berichtsfunktion entwickeln. Im Verlauf:
- „Können wir auch ein Exportformat hinzufügen?" (+2 Tage)
- „Das Dashboard sollte Echtzeit-Updates haben." (+5 Tage)
- „Wir brauchen auch eine mobile App-Version." (+10 Tage)
- Ergebnis: 6 Wochen mehr Arbeit, ohne dass das Projekt offiziell umgeplant wurde.

### 1.3 Ziele des Änderungsmanagements
| Ziel                   | Erläuterung                                                          |
| ---------------------- | -------------------------------------------------------------------- |
| **Kontrolle**          | Alle Änderungen werden erfasst und genehmigt                         |
| **Transparenz**        | Alle Stakeholder wissen, welche Änderungen geplant sind              |
| **Traceability**       | Jede Änderung ist rückverfolgbar (von der Anfrage bis zur Umsetzung) |
| **Impact-Bewusstsein** | Auswirkungen auf Zeit, Kosten, Qualität werden bewusst gemacht       |
| **Priorisierung**      | Änderungen werden nach Nutzen und Aufwand bewertet                   |
| **Kontinuität**        | Projektplan bleibt aktuell und konsistent                            |

---

## Thema 2: Der Change-Request-Prozess

### 2.1 Prozessübersicht
Der typische Change-Request-Prozess durchläuft folgende Phasen:

```
1. INITIIERUNG → 2. ERFASSUNG → 3. BEWERTUNG → 4. ENTSCHEIDUNG → 5. UMSETZUNG → 6. DOKUMENTATION
```

### 2.2 Phase 1: Initiierung – Änderung erkennen
**Wer meldet Änderungen?**
- Projektmanager (selbst erkannt)
- Projektteam (neue Erkenntnisse)
- Stakeholder/Kunden (neue Anforderungen)
- Risikoowner (Risiken werden wirksam)

**Dokumentation in YOUTRACK:**
- Erstellen Sie ein **Issue** mit Label `change-request`
- Beschreibung: Was hat sich geändert? Warum?
- Priority: Bewerten Sie die Dringlichkeit
- Zuordnung: An den Change-Manager oder Projektmanager

### 2.3 Phase 2: Erfassung – Change-Request dokumentieren
Ein vollständiger Change-Request muss folgende Informationen enthalten:

| Feld               | Beschreibung                                       | Beispiel                                                       |
| ------------------ | -------------------------------------------------- | -------------------------------------------------------------- |
| **CR-Nummer**      | Eindeutige Kennung                                 | CR-2025-048                                                    |
| **Änderungstitel** | Kurzbeschreibung                                   | „Zusätzliche Sicherheitsfeatures für Datenexport"              |
| **Beschreibung**   | Detaillierte Erläuterung der Änderung              | „Kunde möchte verschlüsselten Export und Audit-Log"            |
| **Initiator**      | Wer hat die Änderung eingereicht?                  | Projektmanager Thomas Müller                                   |
| **Begründung**     | Warum ist die Änderung notwendig?                  | „Compliance-Anforderung, Kunde hat neue Sicherheitsrichtlinie" |
| **Änderungstyp**   | Scope, Schedule, Budget, Quality, Risk             | Scope (Umfang)                                                 |
| **Priorität**      | Niedrig, Mittel, Hoch, Kritisch                    | Hoch                                                           |
| **Eingangsdatum**  | Wann wurde die CR eingereicht?                     | 2025-11-21                                                     |
| **Status**         | Neu, In Bewertung, Genehmigt, Abgelehnt, Umgesetzt | Neu                                                            |

**YOUTRACK-Nutzung:**
- Alle Change-Requests als Issues mit Custom Fields dokumentieren
- Workflow-Status nutzen: `Neue CR` → `In Analyse` → `Entscheidung` → `Genehmigt` → `In Umsetzung` → `Abgeschlossen`
- Labels für schnelle Filterung: `scope-change`, `budget-impact`, `schedule-risk`

### 2.4 Phase 3: Bewertung (Impact-Analyse)
Die **Impact-Analyse** untersucht, welche Auswirkungen die Änderung hat:

**3.1 Umfang-Analyse (Scope Impact)**
- Welche Projektkomponenten sind betroffen?
- Müssen andere Anforderungen angepasst werden?
- Gibt es Abhängigkeiten zu anderen Funktionen?

**Beispiel:** Eine neue Export-Funktion könnte die Datenbankstruktur, die Benutzeroberfläche und die Sicherheitsmodule beeinflussen.

**3.2 Zeit-Analyse (Schedule Impact)**
- Wie viele Stunden/Tage Zusatzarbeit?
- Kritischer Pfad betroffen?
- Neue Meilensteine verschoben?

**Einschätzung:**
- Aufwandsschätzung: 5–10 Arbeitstage
- Auswirkung auf kritischen Pfad: Ja, Freigabe verzögert sich um 1 Woche

**3.3 Kosten-Analyse (Budget Impact)**
- Zusätzliche Ressourcen erforderlich?
- Externe Kosten (Tools, Lizenzen, externe Berater)?
- Impact auf Gesamtbudget?

**Berechnung:**
- Entwicklung: 60 Stunden × 85 €/h = 5.100 €
- Testing: 20 Stunden × 75 €/h = 1.500 €
- Gesamt: 6.600 € → Budget überschreitbar

**3.4 Qualitäts-Analyse (Quality Impact)**
- Können neue Features getestet werden?
- Regressions-Testing notwendig?
- Standards einhaltbar?

**3.5 Risiko-Analyse (Risk Impact)**
- Neue Risiken entstehen?
- Bestehende Risiken beeinflussen?

**Impact-Bewertungs-Matrix:**

| Kriterium | Beurteilung | Gewicht |
|-----------|-----------|---------|
| Scope | Mittel – 3–5 neue Story-Points | 30% |
| Schedule | Hoch – kritischer Pfad betroffen | 25% |
| Budget | Hoch – 6.600 € zusätzlich | 20% |
| Quality | Niedrig – mit zusätzlichem Testing machbar | 15% |
| Risk | Mittel – Sicherheitsrisiko bei fehlerhafter Umsetzung | 10% |
| **Gesamt-Impact** | **HOCH** | |

### 2.5 Phase 4: Entscheidung – Change-Board-Prozess
Ein **Change-Board** (Change Control Board, CCB) trifft die Entscheidung über jede CR:

**Zusammensetzung des Change-Boards:**
- Projektmanager (Vorsitz)
- Auftraggeber/Sponsor
- Technischer Lead
- QA-Lead
- Finanzverantwortlicher (bei Budget-Auswirkungen)

**Entscheidungskriterien:**
1. **Geschäftlicher Nutzen:** Überwiegt der Nutzen die Kosten?
2. **Machbarkeit:** Kann die Änderung technisch umgesetzt werden?
3. **Auswirkungen:** Sind die Auswirkungen akzeptabel?
4. **Priorisierung:** Passt sie in die aktuelle Roadmap?

**Mögliche Entscheidungen:**
- ✅ **Genehmigt** – Change wird umgesetzt
- ❌ **Abgelehnt** – Change wird nicht umgesetzt
- ⏸️ **Aufgeschoben** – Später entscheiden (z.B. in nächster Phase)
- 🔄 **Überarbeitungs-Anforderung** – CR muss präzisiert werden

**YOUTRACK-Workflow:**
- Issue-Status auf `Entscheidung` setzen
- Kommentar: Rationale für Entscheidung
- Label hinzufügen: `approved`, `rejected` oder `deferred`
- Zuordnung aktualisieren (bei Genehmigung: an Entwickler)

### 2.6 Phase 5: Umsetzung – Integration in Projektplan
Falls die CR genehmigt wird:

1. **Plan anpassen:**
   - Projektstruktur (WBS) aktualisieren
   - Zeitplan (Gantt) ändern
   - Ressourcen umplanen
   - Budget erhöhen

2. **Stakeholder informieren:**
   - Status-Update mit Impact
   - Neue Termine kommunizieren
   - Kompensationen erklären (z.B. Feature-Verzicht)

3. **Traceability dokumentieren:**
   - Verknüpfung CR → WBS-Element
   - Verknüpfung CR → Gantt-Aktivitäten
   - Verknüpfung CR → Budget-Zeilen

**YOUTRACK-Integration:**
- Erstellen Sie einen Subtask oder neues Epic für die Umsetzung
- Link: CR-2025-048 → DEV-345 (Umsetzungs-Task)
- Aktualisieren Sie den Burn-Down-Chart

### 2.7 Phase 6: Dokumentation und Traceability
Jeder Change muss vollständig dokumentiert sein:

**Change-Log (Beispiel):**

| CR-ID | Titel | Status | Entscheidung | Auswirkung |
|-------|-------|--------|-------------|-----------|
| CR-2025-048 | Zusätzliche Sicherheitsfeatures | Genehmigt | Ja | +1 Woche, +6.600 € |
| CR-2025-047 | Layout-Verbesserung | Abgelehnt | Nein | Verschiebung auf Phase 2 |


**Rückverfolgbarkeit (Traceability):**
```
Anforderung → CR → WBS → Aktivität → Test-Case → Abnahme
```

Beispiel:
- Anforderung: „Export mit Verschlüsselung"
- CR-2025-048 referenziert diese Anforderung
- WBS-Element: „5.3 Verschlüsselte Export-Funktion"
- Aktivität: „5.3.1 Backend-Entwicklung Verschlüsselung"
- Test-Case: „TC-045: Export mit AES-256 testen"
- Abnahmekriterium: „Exported file contains AES-256 encryption"

---

## Thema 3: Scope-Creep-Vermeidung und -Management

### 3.1 Was ist Scope-Creep?
**Scope-Creep** ist die unkontrollierte Erweiterung des Projektumfangs, typischerweise durch:
- Kleine, scheinbar unbedeutende Änderungen
- Fehlende Dokumentation von Änderungen
- Mangelnde Kontrolle durch Change-Board
- Zu großzügige Interpretation von Anforderungen

**Syndrome des Scope-Creep:**
- „Das ist doch nur ein kleines Feature …" (unterschätzte Komplexität)
- „Der Kunde hat es nicht explizit ausgeschlossen …" (Interpretations-Spielraum)
- „Wir können das im Durchgang noch schnell machen …" (Hidden Work)
- Unbemerkte Zusatzarbeit im Team

### 3.2 Strategien zur Scope-Creep-Vermeidung

#### Strategie 1: Klare Anforderungsdefinition
**Problem:** Vage oder unvollständige Anforderungen laden zu Interpretationen ein.

**Lösung:**
- **SMART-Kriterien** für jede Anforderung anwenden (Specific, Measurable, Achievable, Relevant, Time-bound)
- **Akzeptanzkriterien** für User Stories definieren
- **Ausgrenzung** explizit dokumentieren: „Was ist NICHT Umfang?"

**Beispiel ungünstig:**
- Anforderung: „Das System soll benutzerfreundlich sein."
- Problem: Zu vage, jeder versteht etwas anderes.

**Beispiel gut:**
- Anforderung: „Benutzer können sich in max. 3 Clicks in das System einloggen."
- Akzeptanzkriterium: „Login-Dialog öffnet sich innerhalb 2 Sekunden."

#### Strategie 2: Formale Change-Control
**Problem:** Mündliche Änderungswünsche werden nicht dokumentiert.

**Lösung:**
- **Alle Änderungswünsche müssen formale CRs sein** – keine Ausnahmen
- Klare Eskalationswege etablieren
- „Nein" auch sagen können

**YOUTRACK-Implementierung:**
- Arbeitsablauf (Workflow) für CRs einrichten
- Automatische Benachrichtigungen bei neuen CRs
- Regelmäßige Change-Board-Meetings (z.B. wöchentlich)

#### Strategie 3: Regelmäßige Scope-Reviews
**Problem:** Scope-Creep erfolgt oft unbewusst, wenn nicht aktiv überwacht.

**Lösung:**
- Wöchentliche oder bi-wöchentliche Scope-Review-Meetings
- Fragen stellen:
  - Welche neuen Anforderungen sind eingegangen?
  - Welche Anforderungen wurden interpretiert oder expandiert?
  - Gibt es Hidden Work, die nicht geplant war?

#### Strategie 4: Priorisierung und Feature-Auswahl
**Problem:** Zu viele Anforderungen für eine Phase.

**Lösung:**
- **MoSCoW-Priorisierung:** Must (essentiell), Should (wichtig), Could (schön zu haben), Won't (nicht in dieser Phase)
- **Feature-Auswahl:** Bewusst auswählen, welche Features in die aktuelle Phase
- **Backlog-Management:** Abgelehnte CRs in ein Backlog für künftige Phasen

#### Strategie 5: Kommunikation und Stakeholder-Engagement
**Problem:** Stakeholder verstehen nicht, warum bestimmte Änderungen abgelehnt werden.

**Lösung:**
- Regelmäßige Kommunikation über Status und Scope
- **Entscheidungslogik transparent machen:** Warum wurde eine CR genehmigt/abgelehnt?
- Alternativen anbieten: „Diese Feature kann in Phase 2 realisiert werden."

---

## Thema 4: Dokumentation und Traceability

### 4.1 Change-Log-Struktur
Ein **Change-Log** ist das zentrale Nachschlagewerk für alle Änderungen:

| Feld | Bedeutung |
|------|----------|
| **CR-ID** | Eindeutige Nummer (z.B. CR-2025-048) |
| **Änderungstitel** | Kurzbeschreibung der Änderung |
| **Beschreibung** | Detaillierte Erläuterung |
| **Typ** | Scope, Schedule, Budget, Quality, Risk, Dokumentation |
| **Initiator** | Wer hat die CR eingereicht? |
| **Eingangsdatum** | Wann wurde die CR erfasst? |
| **Begründung** | Warum ist die Änderung notwendig? |
| **Impact (Scope)** | Welche neuen Features/Anforderungen? |
| **Impact (Schedule)** | Wie viele Tage/Wochen Verzögerung? |
| **Impact (Budget)** | Wie viele EUR zusätzlich? |
| **Impact (Quality)** | Qualitätsrisiken oder Verbesserungen? |
| **Impact (Risk)** | Neue Risiken oder bestehende Risiken beeinflussend? |
| **Entscheidung** | Genehmigt, Abgelehnt, Aufgeschoben |
| **Entscheidungsdatum** | Wann wurde die Entscheidung getroffen? |
| **Begründung Entscheidung** | Warum diese Entscheidung? |
| **Umsetzungsstatus** | Offen, In Umsetzung, Abgeschlossen |
| **Abschlussdatum** | Wann wurde die CR vollständig umgesetzt? |

### 4.2 Traceability-Matrix (Requirements Traceability Matrix – RTM)
Die RTM verknüpft Anforderungen mit CRs, Implementierung und Tests:

```
Anforderung (REQ-001)
  ↓ (Basis für)
Change Request (CR-2025-048)
  ↓ (implementiert durch)
WBS-Element (5.3 Verschlüsselte Export-Funktion)
  ↓ (realisiert in)
Projektplan (Aktivität GA-5.3.1)
  ↓ (validiert durch)
Test-Cases (TC-045, TC-046)
  ↓ (freigegeben via)
Abnahmeprotokoll (Unterschrift Kunde)
```

### 4.3 YOUTRACK-Konfiguration für Change-Management

**Custom Fields hinzufügen:**
- `CR-Nummer` (Text)
- `Impact-Type` (Dropdown: Scope, Schedule, Budget, Quality, Risk)
- `Impact-Bewertung` (Dropdown: Niedrig, Mittel, Hoch)
- `Schedule-Impact-Tage` (Zahl)
- `Budget-Impact-EUR` (Zahl)
- `Change-Board-Entscheidung` (Dropdown: Genehmigt, Abgelehnt, Aufgeschoben)

**Workflow erstellen:**
```
Neue CR
  ↓ (Assign to PM)
In Analyse
  ↓ (Impact-Analyse abgeschlossen)
Zur Entscheidung
  ↓ (CCB-Meeting)
Genehmigt / Abgelehnt / Aufgeschoben
  ↓ (ggf.)
In Umsetzung
  ↓
Abgeschlossen / Nicht umgesetzt
```

**Dashboard-Queries:**
```
# Offene CRs
project = "PROJEKT" AND type = "Change Request" AND status = "Zur Entscheidung"

# Impact-Übersicht (Budget)
project = "PROJEKT" AND type = "Change Request" AND status = "Genehmigt" 
ORDER BY "Budget-Impact-EUR" DESC

# Scope-Creep-Warnung
project = "PROJEKT" AND type = "Change Request" AND status = "Genehmigt" 
AND "Impact-Type" = "Scope" 
LIMIT 10
```

---

## Thema 5: Entscheidungsprozesse und Change-Board

### 5.1 Change-Board Setup
Das **Change Control Board (CCB)** ist das verantwortliche Gremium, das über Änderungen entscheidet.

**Zusammensetzung (typisch):**

| Rolle                    | Verantwortung                             |
|--------------------------|-------------------------------------------|
| **Projektmanager (Vorsitz)** | Prozessleitung, Terminplanung             |
| **Sponsor/Auftraggeber**     | Geschäftliche Bewertung, Budget-Freigabe |
| **Technischer Lead**         | Machbarkeitsbeurteilung, Risiken         |
| **QA-Lead**                  | Qualitätsauswirkungen, Testaufwand       |
| **HR/Ressourcen**            | Ressourcen-Verfügbarkeit                 |
| (Optional) **Kunde**         | Bei Anforderungs-CRs                     |

### 5.2 Entscheidungslogik
Das Change-Board nutzt folgende Bewertungsmatrix:

| Kriterium | Gewichtung | Bewertung |
|-----------|-----------|----------|
| **Geschäftlicher Nutzen** | 30% | Hoch (10), Mittel (5), Niedrig (1) |
| **Geschäftliche Dringlichkeit** | 20% | Kritisch (10), Hoch (7), Normal (3) |
| **Technische Machbarkeit** | 20% | Hoch (10), Mittel (5), Niedrig (1) |
| **Budget-Verfügbarkeit** | 15% | Ja (10), Teilweise (5), Nein (0) |
| **Ressourcen-Verfügbarkeit** | 15% | Ja (10), Teilweise (5), Nein (0) |

**Gesamtpunkte = Summe (Bewertung × Gewichtung)**

**Entscheidung:**
- **Genehmigt:** ≥ 60 Punkte
- **Aufgeschoben:** 40–60 Punkte (später neu bewerten)
- **Abgelehnt:** < 40 Punkte

### 5.3 Meeting-Struktur
Ein typisches Change-Board-Meeting läuft nach folgendem Schema ab:

1. **Eröffnung (5 Min)**
   - Agendaübersicht
   - Ausstehende CRs der Woche

2. **Besprechung je CR (15–20 Min je CR)**
   - Initiator stellt Änderung vor (3 Min)
   - PM/Techniker stellen Impact-Analyse vor (5 Min)
   - Diskussion (5 Min)
   - Abstimmung (2 Min)

3. **Zusammenfassung (5 Min)**
   - Entscheidungen zusammenfassen
   - Nächste Schritte definieren
   - Kommunikation planen

**YOUTRACK-Integration:**
- Vor dem Meeting: Alle offenen CRs in YOUTRACK als `Zur Entscheidung`
- Während Meeting: Status aktualisieren, Kommentare hinzufügen
- Nach Meeting: Entscheidungen dokumentieren, Benachrichtigungen versenden

---

## Thema 6: Häufige Fehler und Best Practices

### 6.1 Häufige Fehler

| Fehler | Problem | Lösung |
|--------|---------|--------|
| **Keine Change-Control** | Änderungen werden ohne Kontrolle umgesetzt | Formales Change-Board etablieren |
| **Vage CRs** | Impact kann nicht bewertet werden | CR-Template mit Pflichtfeldern nutzen |
| **Fehlende Dokumentation** | Rückverfolgbarkeit verloren | Alles in YOUTRACK dokumentieren |
| **Zu permissive CCB** | Zu viele Änderungen genehmigt → Scope-Creep | Strenge Priorisierungskriterien anwenden |
| **Keine Stakeholder-Kommunikation** | Frustration über Entscheidungen | Transparent kommunizieren, Begründung erklären |
| **Mangelnde Ressourcen-Planung** | Genehmigt, aber nicht umsetzbar | Ressourcen vor Freigabe sichern |
| **Fehlerhafte Impact-Analyse** | Überraschungen während Umsetzung | Konservativ schätzen, Puffer einplanen |

### 6.2 Best Practices

1. **Kategorisieren Sie Änderungen:**
   - **Trivial:** < 4 Stunden Arbeit → schnelle Freigabe durch PM
   - **Standard:** 4–40 Stunden → CCB-Entscheidung
   - **Major:** > 40 Stunden → Eskalation an Sponsor

2. **Implementieren Sie einen Änderungs-Threshold:**
   - CRs unter 1% des Projektbudgets: schnelle Freigabe
   - CRs über 1% des Projektbudgets: CCB-Entscheidung
   - CRs über 5% des Budgets: Sponsor-Freigabe erforderlich

3. **Nutzen Sie ein Agile-Hybrid-Modell:**
   - **Klassische Phase:** Striktes Change-Management
   - **Agile Sprints:** Flexiblere Änderungen, aber mit Backlog-Verwaltung

4. **Dokumentieren Sie Scope Baselines:**
   - Nach Anforderungs-Phase: Baseline v1.0
   - Nach Design-Phase: Baseline v2.0
   - Jede CR modifiziert die aktuelle Baseline

5. **Kommunizieren Sie regelmäßig:**
   - Wöchentlich: Change-Summary im Status-Report
   - Monatlich: Scope-Change-Trend (wie viele Änderungen pro Woche?)
   - Projektabschluss: Analyse von Scope-Creep-Lessons-Learned

---

### Wichtige Fachbegriffe
- **Change Request (CR):** Formale Änderungsanfrage
- **Scope-Creep:** Unkontrollierte Umfangserweiterung
- **Impact-Analyse:** Bewertung der Auswirkungen einer Änderung
- **Change Control Board (CCB):** Gremium zur Änderungs-Genehmigung
- **Traceability:** Rückverfolgbarkeit vom Bedarf bis zur Umsetzung
- **Baseline:** Genehmigter Referenzpunkt des Projektplans

---

## Lernresourcen und Verweise

### Literatur
- PMBOK Guide (Project Management Body of Knowledge): Kapitel „Change Management"
- PRINCE2: Change Management in PRINCE2-Methodologie
- Stakeholder-Fokus: Wie Änderungen die Stakeholder beeinflussen

### Software & Tools
- **YOUTRACK:** Issue-Tracking und Workflow-Management
- **MS Project:** Baseline-Management und Plan-Vergleiche
- **Confluence:** Dokumentation von Change-Logs und Entscheidungsprotokollen

### Häufig gestellte Fragen (FAQ)
**F: Wie schnell sollte auf eine CR reagiert werden?**
A: Triage innerhalb von 24 Stunden; CCB-Entscheidung innerhalb 1 Woche (abhängig von Dringlichkeit).

**F: Was tun, wenn der Sponsor eine nicht-geplante Änderung erzwingt?**
A: Änderung dokumentieren, Impact-Analyse durchführen, Kompensation erklären (andere Features verzögern oder Budget erhöhen).

**F: Können agile Projekte Scope-Creep haben?**
A: Ja! Agile Projekte haben flexiblere Scopes, aber auch hier muss das Backlog-Wachstum kontrolliert werden (z.B. durch Sprint-Commitments).