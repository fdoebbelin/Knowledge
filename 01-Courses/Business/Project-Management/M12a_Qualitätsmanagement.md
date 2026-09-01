## Überblick über das Modul

Das Modul **Qualitätsmanagement im Projekt** vermittelt die systematische Planung, Umsetzung und Kontrolle von Qualitätsanforderungen während der gesamten Projektlaufzeit. Es befähigt Projektmanager, Qualitätsstandards festzulegen, Prozesse zu etablieren und sicherzustellen, dass Projektergebnisse die vereinbarten Anforderungen erfüllen.

Qualität im Projekt ist nicht optional – sie ist ein zentraler Erfolgsfaktor. Sie verhindert kostspielige Nacharbeiten, stärkt das Vertrauen der Stakeholder und trägt maßgeblich zur Wirtschaftlichkeit bei.

---

## Lernziele

Nach Abschluss dieses Moduls können Sie:

- **Qualitätsbegriffe** im Projektkontext definieren und von reiner Prüfung abgrenzen
- **Qualitätspläne** systematisch entwickeln und umsetzen
- **Metriken und KPIs** zur Qualitätsmessung auswählen und anwenden
- **Inspektions- und Teststrategien** für verschiedene Projekttypen konzipieren
- **Qualitätsstandards und -prozesse** (intern und extern) in Projekte integrieren
- **YouTrack-Integration** nutzen, um Qualitätsaufgaben zu tracken und zu dokumentieren

---

## Teil 1: Qualitätsbegriffe und Grundlagen

### Was ist Qualität?

**Definition nach DIN EN ISO 9000:**
> Qualität ist die Gesamtheit von Merkmalen und Eigenschaften eines Produkts oder einer Dienstleistung, die sich auf ihre Eignung zur Erfüllung festgestellter und vorausgesetzter Bedürfnisse beziehen.

Im Projektmanagement bedeutet das: **Erfüllung der vereinbarten Anforderungen und Erwartungen des Auftraggebers**.

### Unterscheidung: Qualität vs. Qualitätssicherung vs. Prüfung

| Aspekt | Erklärung | Beispiel |
|--------|-----------|---------|
| **Qualität** | Das Merkmal, dass etwas die Anforderungen erfüllt | Ein Softwaremodul funktioniert fehlerfrei |
| **Qualitätssicherung (QS)** | Prozesse & Prozeduren, um Qualität sicherzustellen | Testpläne, Code-Reviews, Standards |
| **Qualitätsprüfung (QP)** | Aktive Überprüfung, ob Anforderungen erfüllt sind | Testfälle durchführen, Inspektionen |

### Warum Qualitätsmanagement im Projekt?

1. **Kosteneffizienz**: Fehler früh erkennen ist günstiger als Nacharbeiten
2. **Stakeholder-Zufriedenheit**: Anforderungen erfüllen = Akzeptanz erhöhen
3. **Risikominderung**: Qualitätsmängel führen zu Projektrisiken
4. **Compliance**: Viele Branchen (Medizin, Luftfahrt, Finanzen) erfordern Standards
5. **Reputation**: Qualitätsprodukte stärken Markenimage

### Qualität in verschiedenen Projekttypen

- **IT-Projekte**: Funktionalität, Performance, Sicherheit, Benutzerfreundlichkeit
- **Bauprojekte**: Materialqualität, handwerkliche Ausführung, Sicherheit
- **Produktentwicklung**: Zuverlässigkeit, Ästhetik, Langlebigkeit
- **Service-Projekte**: Pünktlichkeit, Zuverlässigkeit, Kundenservice

---

## Teil 2: QS-Planung und Qualitätsmetriken

### Der Qualitätsplan – zentrale Komponente

Der **Qualitätsplan** definiert:

- **Was** wird überprüft? (Qualitätskriterien)
- **Wie** wird überprüft? (Methoden, Verfahren)
- **Wann** wird überprüft? (Inspektionspunkte, Meilensteine)
- **Wer** ist verantwortlich? (Rollen, Verantwortlichkeiten)
- **Welche Standards** gelten? (Normen, interne Richtlinien)

### Komponenten eines Qualitätsplans

#### 1. Qualitätsziele und Erfolgskriterien

Beispiele:
- Verfügbarkeit der Software: ≥ 99,5%
- Fehlerquote: ≤ 2 Fehler pro 1.000 Zeilen Code
- Kundenzufriedenheit: ≥ 8/10 Punkte
- Termin-Treue: ≥ 95% pünktliche Lieferung

#### 2. Qualitätskriterien und Anforderungen

Diese basieren auf:
- Projektvertrag und Anforderungsspezifikation
- Kundenerwartungen
- Branchenstandards
- Best Practices

#### 3. Inspektions- und Testpunkte

| Inspektionspunkt | Zeitpunkt | Verantwortung |
|------------------|-----------|---------------|
| **Anforderungsvalidierung** | Nach Anforderungserfassung | Requirements Engineer |
| **Design-Review** | Nach Designphase | Architektur-Team |
| **Code-Inspektion** | Während Entwicklung | Entwickler + Reviewer |
| **Komponententest** | Nach Unit-Entwicklung | Entwickler |
| **Integrationtest** | Nach Integration | QA-Team |
| **UAT** (User Acceptance Test) | Vor Go-Live | Kunde / Business User |
| **Performance-Test** | Vor Produktion | QA + Ops |

#### 4. Rollen und Verantwortlichkeiten

| Rolle                 | Aufgabe im QM                                 |
| --------------------- | --------------------------------------------- |
| **Projektmanager**    | Qualitätsplan verabschieden, Monitoring       |
| **Qualitätsleiter**   | QM-Strategie, Standards, Audits               |
| **Entwickler**        | Einhaltung Standards, eigene Qualitätsprüfung |
| **Tester**            | Testfallentwicklung, Testausführung           |
| **QA-Analyst**        | Metriken, Auswertungen, Reportings            |
| **Kunde/Stakeholder** | Anforderungsvorbereitung, Abnahmetests        |

---

## Teil 3: Inspektions- und Teststrategien

### Unterschied: Inspektion vs. Test

| Eigenschaft | Inspektion | Test |
|-------------|-----------|------|
| **Ziel** | Systematische Überprüfung durch Prüfung | Überprüfung durch Ausführung |
| **Methode** | Statisch (ohne Ausführung) | Dynamisch (mit Ausführung) |
| **Beispiele** | Code-Reviews, Dokument-Audits | Unit Tests, Integrationstests |
| **Vorteil** | Frühe Fehlererkennung, kostengünstig | Realistische Abbildung |

### Inspektionsmethoden

#### 1. Code Review / Peer Review
- Zwei Entwickler überprüfen den Code eines Dritten
- Checkliste mit Qualitätskriterien
- Ziel: Logikfehler, Sicherheitslücken, Standards-Abweichungen finden

#### 2. Walkthrough
- Autor führt das Artefakt (Code, Design, Dokument) vor
- Gruppe stellt Fragen und gibt Feedback
- Informal, weniger strukturiert

#### 3. Formale Inspektion (nach Fagan)
- Strukturierter Prozess mit definierten Rollen
- Vorbereitungsphase, Inspektionsmeeting, Nachverfolgung
- Hocheffizienz bei Standards-Einhaltung

#### 4. Audit
- Unabhängige Überprüfung der Compliance
- Prüfung von Dokumentation, Prozessen, Einhaltung von Richtlinien
- Oft durch externe Prüfer

### Teststrategie – Das V-Modell

Das **V-Modell** zeigt den Zusammenhang zwischen Entwicklungs- und Testphasen:

```
        Anforderungen ──────────────────── UAT (User Acceptance Test)
             ↓                                ↑
        Design ─────────────────── Systemtest
             ↓                        ↑
        Architektur ───────── Integrationstest
             ↓                    ↑
        Detaildesign ──── Komponententest (Unit Test)
             ↓                ↑
        Implementierung ────────→
```

### Testarten und Ebenen

| Test-Ebene | Fokus | Verantwortung | Beispiel |
|-----------|-------|--------------|---------|
| **Unit Test** | Einzelne Funktion/Klasse | Entwickler | Test einer Berechnung |
| **Komponententest** | Zusammenspiel mehrerer Module | Entwickler-Team | Test eines Feature |
| **Integrationstest** | Zusammenarbeit von Systemen | QA-Team | Datenfluss zwischen Systemen |
| **Systemtest** | Gesamtsystem gegen Anforderungen | QA-Team | Alle Features zusammen |
| **UAT** | Geschäftsprozesse aus Kundensicht | Kunde/Business User | Echte Workflows testen |

### Testtypen

- **Funktionaltests**: Erfüllt das System die Anforderungen?
- **Performance-Tests**: Wie schnell reagiert das System unter Last?
- **Sicherheitstests**: Sind Daten und Zugang geschützt?
- **Usability-Tests**: Ist die Bedienung intuitiv?
- **Regressionstests**: Wurden alte Funktionen durch neue Änderungen beschädigt?

---

## Teil 4: Qualitätsstandards und -prozesse

### Interne Qualitätsstandards

Diese werden vom Unternehmen oder Projekt selbst definiert:

- **Coding Standards**: Namenkonventionen, Einrückung, Dokumentation
- **Dokumentationsstandards**: Format, Vollständigkeit, Aktualität
- **Designrichtlinien**: Architektur-Patterns, Schnittstellen-Design
- **Test-Standards**: Testfall-Format, Coverage-Ziele, Namenkonvention

### Externe Standards und Normen

| Standard | Bereich | Anwendung |
|----------|---------|-----------|
| **ISO 9001** | Allgemeines QM | Alle Branchen |
| **ISO/IEC 27001** | IT-Sicherheit | IT-Projekte |
| **ISO/IEC/IEEE 29119** | Softwaretesting | Software-Entwicklung |
| **CMMI** (Capability Maturity Model Integration) | Prozessreife | Software & Services |
| **V-Modell XT** | IT-Projektmanagement | Besonders in Deutschland, Behörden |
| **Agile Manifesto** | Agile Entwicklung | Agile Teams |

### Qualitätssicherungsprozesse

#### Phase 1: Planung
- Anforderungen klären und dokumentieren
- Qualitätskriterien definieren
- Inspektions- und Testplan erstellen
- Ressourcen und Zeitplan allocieren

#### Phase 2: Umsetzung
- Standards und Prozesse communicieren
- Inspektionen und Reviews durchführen
- Tests planmäßig durchführen
- Fehler dokumentieren und tracken

#### Phase 3: Überwachung und Kontrolle
- Qualitätsmetriken erfassen (z. B. Fehlerrate, Test-Coverage)
- Abweichungen analysieren
- Trends erkennen (Fehlentwicklungen frühzeitig?)
- Qualitätsbericht erstellen

#### Phase 4: Abschluss
- Finale Abnahmetests durchführen
- Qualitätsdokumentation abschließen
- Lessons Learned festhalten
- Archivieren

---

## Teil 5: Qualitätsmetriken und KPIs

### Wichtige Qualitätsmetriken

| Metrik | Definition | Zielwert (Beispiel) |
|--------|-----------|-------------------|
| **Defect Density** | Anzahl Fehler pro 1.000 Zeilen Code | ≤ 2 |
| **Test Coverage** | % des Codes, der durch Tests überprüft wird | ≥ 80% |
| **Defect Escape Rate** | % der Fehler, die in Produktion gehen | ≤ 1% |
| **Mean Time To Fix (MTTF)** | Durchschnittl. Zeit zur Fehlerbehebung | ≤ 3 Tage |
| **Acceptance Rate** | % der Anforderungen, die erfolgreich getestet | ≥ 95% |
| **Customer Satisfaction** | Kundenzufriedenheit (Umfrage/Rating) | ≥ 8/10 |

### Fehlerklassifikation und -priorisierung

| Severity | Beschreibung | Beispiel |
|----------|-------------|---------|
| **Critical** | System funktioniert nicht, Datenverlust | Crash bei Dateneingabe |
| **High** | Wichtige Funktion fehlerhaft | Kalkulation falsch |
| **Medium** | Nebengewalt beeinträchtigt, User kann workaround nutzen | Falsche Fehlermeldung |
| **Low** | Kosmetischer Fehler, keine Auswirkung auf Funktion | Typo in Label |

---

## Teil 6: Integration mit YouTrack

**YouTrack** ist ein Projektmanagement- und Issue-Tracking-System, das perfekt für Qualitätsverwaltung genutzt werden kann.

### YouTrack-Integration für Qualitätsmanagement

#### 1. Defect-Tracking
- **Issue-Typ**: Bug
- **Custom Fields**: Severity, Test Phase, Root Cause
- **Workflow**: Neu → In Analyse → In Behebung → Testing → Closed

#### 2. Test-Case-Management
- **Issue-Typ**: Test Case
- **Fields**: Test Description, Preconditions, Expected Result, Actual Result
- **Link**: Verknüpfung zu Requirements (Rückverfolgbarkeit)

#### 3. Qualitätsmetriken und Dashboards
- **Burn-Down Chart**: Fehlerreduktion über Zeit
- **Filter**: z. B. alle offenen "High Severity Bugs"
- **Reports**: Fehlerentwicklung nach Phase, nach Komponente

#### 4. Traceability Matrix
- **Link** Test Cases zu Requirements
- **Link** Requirements zu Defects
- Vollständige Rückverfolgbarkeit gewährleisten

---

## Häufige Fehler und Best Practices

### Fehler im Qualitätsmanagement

1. **Qualität wird als optional behandelt** → Nacharbeiten kosten mehr
2. **Zu späte Testung** → Fehler spät erkannt = teuer zu beheben
3. **Keine klaren Qualitätskriterien** → Akzeptanz unklar
4. **Mangelnde Dokumentation** → Keine Nachvollziehbarkeit
5. **Qualität als Test-Team-Aufgabe verstanden** → Jeder ist verantwortlich!

### Best Practices

1. **Qualität früh einplanen** – vom Projektstart an
2. **Inspektionen nutzen** – statische Analyse ist kostengünstig
3. **Metriken verfolgen** – Daten treiben Entscheidungen
4. **Feste Standards** – einheitliche Kriterien
5. **Kontinuierliche Kommunikation** – zwischen Entwicklung, QA und Stakeholdern
6. **Tool-Unterstützung** – YouTrack, Jira, TestRail, etc.
7. **Feedback-Schleifen** – schnelle Korrektur bei Abweichungen

---

## Zusammenfassung und Merksätze

- **Qualität = Erfüllung von Anforderungen** – nicht "besser als nötig"
- **Qualität ist Prävention** – nicht Reparatur
- **Qualitätsmetriken sind objektiv** – keine Bauchentscheidungen
- **Jeder ist verantwortlich** – nicht nur QA
- **YouTrack dokumentiert alles** – für Compliance und Lessons Learned
- **Früh testen, häufig testen** – je früher ein Fehler erkannt, desto billiger die Behebung

---

## Weiterführende Ressourcen

- **DIN EN ISO 9000**: Qualitätsmanagementsysteme
- **PMBOK Guide**: Kapitel Quality Management
- **V-Modell XT**: Vorgehensmodell mit QS-Aktivitäten
- **YouTrack Documentation**: https://www.jetbrains.com/help/youtrack/
- **Code Review Best Practices**: Google's Engineering Practices