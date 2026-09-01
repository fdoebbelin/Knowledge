## Aufgabenblock A: Kontextanalyse und Tailoring-Entscheidungen

### Aufgabe A1: Kontext-Analyse durchführen (30 Minuten)

**Szenario:**

Sie sind Projektmanager für ein mittleres Infrastruktur-Projekt in einem Finanzdienstleister:

**Projektbeschreibung:**
- **Titel:** Migration der Payment-Verarbeitung auf neue Cloud-Plattform
- **Dauer:** 12 Monate geplant
- **Team-Größe:** 15 Personen (IT, Business Analyst, Test)
- **Anforderungen:** 70% klar vorgegeben (Regulatorische Vorgaben), 30% offen (Customizing-Optionen)
- **Abhängigkeiten:** Externe Integration mit 3 Zahlungs-Partnern; Compliance-Genehmigung notwendig
- **Unternehmenskultur:** Klassisch hierarchisch, aber IT-Abteilung experimentiert mit Agile
- **Risiko:** Hoch (Finanzbranche, Go-Live verursacht keine Ausfallzeiten zulässig)

**Aufgabenstellung:**

1. **Kontext-Merkmale sammeln**: Erstellen Sie eine Tabelle mit den wichtigsten Kontext-Faktoren und bewerten Sie diese auf einer Skala von 1 (= klassisch) bis 10 (= agil):

| Faktor | Bewertung | Begründung |
|--------|-----------|-----------|
| Anforderungsklarheit | ___ / 10 | ________________ |
| Organisationskultur | ___ / 10 | ________________ |
| Teamgröße | ___ / 10 | ________________ |
| Regulatorische Anforderungen | ___ / 10 | ________________ |
| Komplexität | ___ / 10 | ________________ |
| Time-to-Market-Druck | ___ / 10 | ________________ |

2. **Tailoring-Empfehlung ableiten**: Auf Basis Ihrer Bewertung, welcher Hybrid-Mix ist sinnvoll?
   - Anteil Klassisch: _____ %
   - Anteil Agil: _____ %
   - Begründung: _________________________________________________

3. **Methoden-Mix skizzieren**: Welche klassischen und agilen Methoden würden Sie für diese Phase kombinieren?

| Phase | Klassische Methode | Agile Methode | Begründung |
|-------|------------------|---------------|-----------|
| Anforderungen | _____ | _____ | _______ |
| Design | _____ | _____ | _______ |
| Entwicklung | _____ | _____ | _______ |
| Test | _____ | _____ | _______ |
| GoLive | _____ | _____ | _______ |

**Lösungshinweis:** Denken Sie daran, dass Regulatorium und externe Abhängigkeiten klassische Kontrolle erfordern, während technische Umsetzung von Customizing vom agilen Ansatz profitiert.

---

### Aufgabe A2: Tailoring-Matrix anwenden (20 Minuten)

**Aufgabenstellung:**

Geben Sie folgende Szenarien auf der unten stehenden **Tailoring-Matrix** ein und empfehlen Sie jeweils ein Hybrid-Muster:

**Szenario 1:** Große Infrastruktur-Migration mit klaren Anforderungen, regulierter Branche
**Szenario 2:** Entwicklung eines neuen Produkts mit unsicheren Anforderungen, kleine Startup
**Szenario 3:** Mittelgroßes ERP-Implementierungs-Projekt, etabliertes mittelständisches Unternehmen

**Tailoring-Matrix:**

```
                        Anforderungsklarheit hoch →
                         ↑
         Klassisch       │      Hybrid (verschiedene Ausprägungen)      │    Agil
         bevorzugt       │                                              │ bevorzugt
                         │                                              │
                         │  Stage-Gate + Agile │  Kanban + Gates        │
                         │  Sprints             │                       │
                         │                      │                       │
                    Klassische               Hybrid                   Agile
                    Governance             Governance               Governance
                         │                      │                       │
                         ↓                      ↓                       ↓
      Organisationskultur klassisch   |   gemischt   |   agil

Szenario 1: (..., ...) → Empfehlter Ansatz: _______________________
Szenario 2: (..., ...) → Empfehlter Ansatz: _______________________
Szenario 3: (..., ...) → Empfehlter Ansatz: _______________________
```

**Lösungshinweis:** Die beiden Dimensionen sind Anforderungsklarheit (X-Achse) und Organisationskultur (Y-Achse).

---

## Aufgabenblock B: Governance-Design

### Aufgabe B1: Governance-Struktur gestalten (40 Minuten)

**Aufgabenstellung:**

Sie haben sich in Aufgabe A1 für einen hybriden Ansatz entschieden. Nun designen Sie die **Governance-Struktur** für dieses Payment-Migration-Projekt:

1. **Rollen definieren**: Wer hat welche Verantwortung?

| Rolle | Klassisches Projekt | Hybrid-Projekt | Beschreibung der Aufgabe |
|-------|------------------|-----------------|--------------------------|
| **Sponsor** | _____ | _____ | ______________ |
| **Projektmanager** | _____ | _____ | ______________ |
| **Product Owner** | _____ | _____ | ______________ |
| **Scrum Master** | _____ | _____ | ______________ |
| **Steering Committee** | _____ | _____ | ______________ |
| **Change Control Board** | _____ | _____ | ______________ |

2. **Governance-Events planen**: Welche Meetings/Zeremonie sind sinnvoll?

| Meeting | Frequenz | Teilnehmer | Ziele | Dauer |
|---------|----------|-----------|-------|--------|
| Steering | _____ | _____ | _____ | _____ |
| Sprint Planning | _____ | _____ | _____ | _____ |
| Sprint Review | _____ | _____ | _____ | _____ |
| Daily Standup | _____ | _____ | _____ | _____ |
| Product Backlog Refinement | _____ | _____ | _____ | _____ |
| Change Control | _____ | _____ | _____ | _____ |

3. **Entscheidungsmatrix (RACI) erstellen**: Wer ist verantwortlich, rechenschaftspflichtig, konsultiert, informiert?

| Entscheidung | Verantwortlich | Rechenschaft | Konsultiert | Informiert |
|-------------|----------------|--------------|-----------  |-----------|
| Phase-Freigabe | _____ | _____ | _____ | _____ |
| Sprint-Planung | _____ | _____ | _____ | _____ |
| Change Request (regulatorisch) | _____ | _____ | _____ | _____ |
| Change Request (klein, technisch) | _____ | _____ | _____ | _____ |
| Risiko-Eskalation | _____ | _____ | _____ | _____ |

**Lösungshinweis:** In hybriden Projekten sind oft PM und Scrum Master komplementär, nicht konkurrierend. PM kümmert sich um Governance und externe Kommunikation, Scrum Master um Team-Prozess.

---

### Aufgabe B2: Governance-Konflikt lösen (25 Minuten)

**Szenario:**

Im Payment-Projekt entsteht Spannung:
- **Geschäftsseite** (Sponsor) verlangt monatliche Steering-Meetings mit detaillierten Status-Reports
- **Tech-Team** (Scrum Master) sagt: „Wir arbeiten in 2-wöchentlichen Sprints mit täglichen Standups. Ein monatliches Meeting macht keinen Sinn."
- **Resultat:** Unklarheit, doppelte Arbeit, Frustration

**Aufgabenstellung:**

1. **Ursachenanalyse**: Was sind die legitimen Gründe beider Seiten?

**Geschäftsseite braucht:**
- _______________________________________________
- _______________________________________________

**Tech-Team braucht:**
- _______________________________________________
- _______________________________________________

2. **Hybrid-Lösung designen**: Wie können Sie beide Anforderungen erfüllen, ohne Overhead zu schaffen?

**Mögliche Lösung:**
- _______________________________________________
- _______________________________________________
- _______________________________________________

3. **YouTrack-Integration**: Wie würde diese Lösung in YouTrack umgesetzt?

| Element | YouTrack-Umsetzung |
|---------|-------------------|
| Steering-Berichte | _____ |
| Sprint-Tracking | _____ |
| Automatische Reports | _____ |

**Lösungshinweis:** Oft hilft ein „Steering-Sprint-Review" (z.B. alle 4 Wochen nach Sprint 2), das beide Forderungen verbindet: Sprint-Ergebnisse für Steering-Review, detailliertes Tracking durch automatisierte YouTrack-Reports.

---

## Aufgabenblock C: Praktische Hybrid-Muster

### Aufgabe C1: Hybrid-Muster vergleichen (35 Minuten)

**Aufgabenstellung:**

Vergleichen Sie vier klassische Hybrid-Muster für unterschiedliche Szenarien. Füllen Sie die Vergleichstabelle aus:

| Kriterium | Stage-Gate + Agile Sprints | Kanban + Gates | Inkrementelle Delivery | Agile Exploration + klassisches Rollout |
|-----------|----------------------------|----------------|----------------------|----------------------------------------|
| **Best für:** | __________ | __________ | __________ | __________ |
| **Anforderungen** | __________ | __________ | __________ | __________ |
| **Planung** | __________ | __________ | __________ | __________ |
| **Kontrolle** | __________ | __________ | __________ | __________ |
| **Team-Struktur** | __________ | __________ | __________ | __________ |
| **Risiko** | __________ | __________ | __________ | __________ |
| **Beispiel-Projekt** | __________ | __________ | __________ | __________ |

**Lösungshinweis:** Jedes Muster hat Stärken und Schwächen. Z.B. ist Stage-Gate + Agile robust für regulierte Umgebungen, aber kann overhead-lastig sein. Kanban + Gates ist effizienter, erfordert aber gute Story-Definition.

---

### Aufgabe C2: Wählen Sie ein Muster für ein Szenario (20 Minuten)

**Szenario A: IoT-Gerätentwicklung**
- Hardware-Design: 6 Monate, sehr viel Vorlaufzeit
- Firmware-Entwicklung: Parallel möglich, experimentell
- Cloud-Backend: Kann agilweise entwickelt werden
- Integration: Muss koordiniert sein

**Aufgabenstellung:**
1. Welches Hybrid-Muster ist hier passend? Begründung:

   _______________________________________________

2. Skizzieren Sie den Ablauf:
   ```
   [Hardware-Phase 1] → [Parallel: Firmware-Sprints + Backend-Sprints] → [Integration] → [GoLive]
   ```

3. Welche Synchronisations-Events sind notwendig?

   _______________________________________________

**Szenario B: Enterprise ERP-Implementierung**
- Business-Anforderungen: 80% bekannt (Standardprozesse), 20% Custom
- Team: 25 Personen, verteilt
- Organisationskultur: Klassisch hierarchisch
- Compliance: Hoch (Audit-Trail, Change-Dokumentation)
- Timeline: 18 Monate, schrittweise Rollout

**Aufgabenstellung:**
1. Welches Hybrid-Muster ist hier passend? Begründung:

   _______________________________________________

2. Skizzieren Sie die Phasen:
   ```
   [Anforderungsanalyse] → [Konfiguration in Sprints] → [Testcycles] → [Schrittweiser Rollout]
   ```

3. Wie integrieren Sie klassische Change-Control mit agilen Sprints?

   _______________________________________________

---

## Aufgabenblock D: YouTrack-Praktikum

### Aufgabe D1: Hybrid-Projekt in YouTrack einrichten (45 Minuten)

**Aufgabenstellung:**

Sie richten für das Payment-Migrations-Projekt eine **YouTrack-Projekt-Struktur** ein:

1. **Workflows definieren:**

   Beschreiben Sie den Workflow mit klassischen UND agilen States:

   ```
   New → [Klassisch: Requirement-Review → Approved] → [Agil: Sprint-Planning → In Development → Sprint-Review → Ready for Deploy] → [Klassisch: Pre-GoLive-Review] → Done
   ```

   **Ihre Workflow-Definition:**
   ```
   State 1: _________________ → Übergang 1: __________________
   State 2: _________________ → Übergang 2: __________________
   ...
   ```

2. **Custom Fields einführen:**

   Welche zusätzlichen Metadaten sind für die Hybrid-Verwaltung sinnvoll?

| Custom Field      | Type | Werte/Optionen                           | Zweck               |
| ----------------- | ---- | ---------------------------------------- | ------------------- |
| Phase             | List | Anforderungen, Design, Dev, Test, GoLive | Phase-Zuordnung     |
| Sprint            | Link | Sprint-1, Sprint-2, ...                  | Sprint-Zuordnung    |
| Regulatory-Status | List | ____, ____, ____                         | Compliance-Tracking |
| ____              | ____ | ____                                     | ____                |

3. **Issue-Strukturierung:**

   - **Epics**: Geschäfts-Anforderungen (z.B. „Payment-Flow implementieren")
   - **User Stories**: Agile Anforderungen unter Epics (z.B. „Als Admin möchte Transaktionen genehmigen")
   - **Tasks**: Klassische Aufgaben (z.B. „Design-Dokument schreiben", „Compliance-Checkliste prüfen")
   - **Bugs/Issues**: Ad-hoc Probleme

   **Beispiel-Struktur in YouTrack:**

   ```
   Epic: Payment-Flow Implementation
     ├─ User Story: [Sprint-1] Card Payment Support
     │   ├─ Task: Database Schema (Phase: Design)
     │   ├─ Task: API Implementation (Sprint-1, Phase: Development)
     │   └─ Task: Test Cases (Sprint-2, Phase: Testing)
     ├─ User Story: [Sprint-2] Card Validation
     └─ Task: Regulatory Review (Phase: GoLive, Regulatory-Status: Pending)
   ```

   **Ihre Struktur für ein Beispiel-Epic:**
   ```
   Epic: ___________________
     ├─ Story: _____________________
     ├─ Story: _____________________
     └─ Task: _____________________
   ```

4. **Reporting-Beispiele:**

   - **Klassisches Reporting**: Gantt-Diagramm nach Phase, Milestone-Tracking
   - **Agiles Reporting**: Sprint Burndown, Velocity, Work-Item-Trend
   - **Hybrid-Reporting**: Fase-Status (klassisch) + Sprint-Progress (agil) im selben Dashboard

   **Beschreiben Sie 2 Reports für Ihr Projekt:**

| Report        | Zielgruppe    | Inhalt        | Frequenz      |
| ------------- | ------------- | ------------- | ------------- |
| _____________ | _____________ | _____________ | _____________ |
| _____________ | _____________ | _____________ | _____________ |

**Lösungshinweis:** YouTrack erlaubt sehr flexible Workflows. Der Trick ist, klare „Gateway-States" zu definieren (z.B. „Ready for Approval", „Sprint Ready"), wo klassische und agile Prozesse sich synchronisieren.

---

### Aufgabe D2: Change-Request-Prozess abbilden (30 Minuten)

**Szenario:**

Ein Geschäftsanwender möchte Anforderung ändern (z.B. zusätzliche Zahlungsmethode):
- **Kleine Änderung** (aufwand <5 Tage): Sollte als User Story ins nächste Sprint
- **Große Änderung** (>5 Tage): Muss durch Change Control Board

**Aufgabenstellung:**

1. **Change-Request-Workflow in YouTrack:**

   Definieren Sie einen Workflow für Change Requests:

   ```
   Change Request (New)
   ├─ [Impact-Analyse] → Impact Score berechnen
   ├─ [Small Change (< 5d)] → Approval durch PO → Sprint-Backlog
   ├─ [Large Change (> 5d)] → CCB Review → Approval/Rejection
   └─ [Done] oder [Rejected]
   ```

2. **Entscheidungslogik:**

   - **Wer** trifft die Entscheidung?
   - **Wann** wird es überprüft?
   - **Wie** wird Dokumentation sichergestellt?

   **Ihre Antworten:**
   - Small Change: Entscheidung durch _______, Dokumentation: _______
   - Large Change: Entscheidung durch _______, Dokumentation: _______

3. **Integration mit Sprint-Planung:**

   Wie werden genehmigte Changes in Sprint-Planning integriert?

   _______________________________________________

**Lösungshinweis:** Custom Workflow-Transitions mit Automationen (z.B. "Wenn Impact < 5d, dann Add To Sprint Backlog") können den Prozess vereinfachen.

---

## Aufgabenblock E: Fallstudien & Reflexion

### Aufgabe E1: Fallstudie analysieren (40 Minuten – Gruppenarbeit)

**Fallstudie: Finanzbranche – Kreditvergabe-System Modernisierung**

**Kontext:**
- Großbank mit klassischer Organisationsstruktur
- Altes Mainframe-System (30 Jahre alt) muss modernisiert werden
- Regulatorische Anforderungen sehr hoch (Basel III, Compliance, Audit-Trail)
- 50 Personen Team über 3 Standorte verteilt
- Budget: €5M, Timeline: 24 Monate
- Anforderungen: 60% stabil (regulatorisch), 40% offen (Technische Modernisierung)

**Fragen:**

1. **Kontext-Analyse:**
   - Bewerten Sie Anforderungsklarheit, Organisationskultur, Regulatorium (Skala 1–10)
   - Begründung für jede Bewertung

2. **Tailoring-Empfehlung:**
   - Welcher Hybrid-Mix ist sinnvoll? (% Klassisch vs. Agil)
   - Welche Hybrid-Muster könnten funktionieren?

3. **Governance-Struktur:**
   - Wie viele Steering-Meetings? In welcher Frequenz?
   - Agile Events sinnvoll? Welche?
   - Wie wird Change Control durchgeführt?

4. **Risiken:**
   - Was könnte schiefgehen bei diesem Hybrid-Ansatz?
   - Wie mitigiert man diese Risiken?

5. **YouTrack-Setup:**
   - Skizzieren Sie kurz die Custom Fields und Workflows

**Dokumentation:**
Schreiben Sie ein **1–2-seitiges Tailoring-Dokument** mit Ihren Empfehlungen.

---

### Aufgabe E2: Eigenes Projekt reflektieren (30 Minuten – Einzelarbeit)

**Aufgabenstellung:**

Wählen Sie ein **bekanntes Projekt aus Ihrer Praxis oder Erfahrung** (oder nutzen Sie das Übungsprojekt aus dem Kurs):

1. **Kontext analysieren:** Wenden Sie die Tailoring-Matrix an
2. **Aktueller Ansatz:** Ist das Projekt aktuell klassisch oder agil? Funktioniert das gut?
3. **Hybrid-Potenzial:** Könnte ein Hybrid-Ansatz besser funktionieren? Wie?
4. **Konkrete Maßnahmen:** Welche 3 Veränderungen würden Sie implementieren?

**Dokumentation:**
Schreiben Sie ein **persönliches Reflexions-Papier** (1–2 Seiten):
- Projekt-Beschreibung
- Analyse des aktuellen Ansatzes
- Empfohlene Hybrid-Adaption
- Implementierungs-Roadmap

---

## Checkliste für Hybrid-Projekte

Nutzen Sie diese Checkliste, um zu überprüfen, ob Ihr Hybrid-Projekt gut strukturiert ist:

### Planung & Tailoring
- [ ] Kontext analysiert (Anforderungen, Kultur, Regulatorium, Größe)
- [ ] Tailoring-Entscheidungen dokumentiert
- [ ] Methoden-Mix begründet
- [ ] Hybrid-Muster gewählt und beschrieben
- [ ] Team versteht das „Warum" des Hybrid-Ansatzes

### Governance
- [ ] Rollen und Verantwortlichkeiten klar (RACI-Matrix)
- [ ] Governance-Events definiert (Frequenz, Teilnehmer, Ziele)
- [ ] Entscheidungswege festgelegt (Wer entscheidet wann?)
- [ ] Eskalationsprozess definiert
- [ ] Klassische und agile Elemente integriert (keine Silos)

### Prozesse & Workflows
- [ ] Workflows in YouTrack abgebildet (klassisch + agil)
- [ ] Custom Fields für Hybrid-Management definiert
- [ ] Issue-Struktur (Epics, Stories, Tasks) klar
- [ ] Change-Control-Prozess implementiert
- [ ] Reporting integriert (klassisch + agil)

### Team & Kultur
- [ ] Team geschult in beiden Methodiken
- [ ] Klare Kommunikation zwischen klassisch/agil arbeitenden Teilen
- [ ] Retrospektiven eingebaut (Hybrid-Ansatz reflektieren)
- [ ] Widerstand/Konflikte aktiv gemanagt
- [ ] Erfolgsfaktoren und Learnings dokumentiert

---

## Persönliche Notizen & Lernfelder

Nutzen Sie diesen Bereich, um Ihre persönlichen Erkenntnisse zu dokumentieren:

### Was habe ich gelernt?
- _______________________________________________
- _______________________________________________

### Welche Fragen bleiben offen?
- _______________________________________________
- _______________________________________________

### Wo kann ich Hybrid-Ansätze in meiner Praxis einsetzen?
- _______________________________________________
- _______________________________________________

### Welche Herausforderungen erwarte ich?
- _______________________________________________
- _______________________________________________

---

## Zusammenfassung der Aufgabenblöcke

| Block | Thema | Methode | Dauer | Ergebnis |
|-------|-------|---------|-------|----------|
| **A** | Kontext & Tailoring | Analyse & Diskussion | 75 Min | Tailoring-Empfehlung |
| **B** | Governance-Design | Gruppenarbeit, Entscheidungsmatrizen | 65 Min | Governance-Struktur |
| **C** | Hybrid-Muster | Vergleich & Fallstudien | 55 Min | Pattern-Auswahl |
| **D** | YouTrack-Praktikum | Hands-on-Demo & Setup | 75 Min | Konfiguriertes Projekt |
| **E** | Fallstudien & Reflexion | Analyse & persönliche Reflexion | 70 Min | Tailoring-Dokument |

**Gesamtzeit: ca. 5–6 Stunden Bearbeitungszeit (kann auf Schulungsmodul oder Hausaufgabe verteilt werden)**

