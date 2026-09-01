## Übersicht des Moduls

Die **Projektstrukturplanung (Work Breakdown Structure, WBS)** ist eine der fundamentalsten Planungsaktivitäten im klassischen Projektmanagement. Sie bildet das Fundament für alle nachfolgenden Planungstätigkeiten – von der Zeitplanung über die Ressourcenallokation bis zur Kostenplanung. Das Modul vermittelt die theoretischen Grundlagen der WBS, zeigt verschiedene Zerlegungslogiken und Gestaltungsvarianten auf und vermittelt Best Practices zur fehlerfreien Erstellung.

---
## Lernziele

Nach Abschluss dieses Moduls sind die Teilnehmer in der Lage, …

- die **konzeptionelle Bedeutung und Funktion** einer WBS im Projektablauf zu beschreiben
- eine WBS nach **verschiedenen Zerlegungslogiken** (prozessual, komponentenorientiert, phasenorientiert) zu strukturieren
- **Gestaltungsvarianten** und deren Vor- und Nachteile beurteilen zu können
- **Hierarchien und Verantwortlichkeiten** durch RACI- und RAM-Matrizen abzubilden
- **häufige Fehler** zu erkennen und auszuschließen
- eine **praktische WBS** für unterschiedliche Projekttypen (IT, Bau, Marketing, Produktion) zu erstellen
- die WBS in **Werkzeugen wie YouTrack, MS Project, oder Asana** zu implementieren
- die WBS als **Referenzrahmen für nachfolgende Planungsphasen** nutzen zu können

---

## Thematische Gliederung und Schwerpunkte

### 1. Grundlagen und Konzept der WBS

#### 1.1 Definition und Zweck
Die **Work Breakdown Structure (WBS)** ist eine hierarchisch strukturierte, vollständige Zerlegung des Gesamtprojekts in kleinere, managebare Arbeitspakete (Work Packages). Sie beantwortet die Frage: *Aus welchen einzelnen Komponenten, Prozessen oder Phasen besteht das Projekt?*

**Charakteristische Merkmale einer WBS:**
- **Vollständigkeit**: Das Projekt wird vollständig in alle relevanten Komponenten zerlegt
- **Granularität**: Zerlegung bis auf die Ebene von Arbeitspaketen, die sich kontrollieren und dokumentieren lassen
- **Hierarchie**: Jede höhere Ebene setzt sich aus ihren untergeordneten Elementen zusammen (100%-Regel)
- **Eindeutigkeit**: Keine Überschneidungen zwischen den Arbeitspaketen
- **Eindeutige Zuordnung**: Jedes Paket kann einer Verantwortung zugeordnet werden

#### 1.2 Die 100%-Regel
Ein fundamentales Prinzip der WBS ist die **100%-Regel**: Ein übergeordnetes Element umfasst exakt 100% seiner untergeordneten Elemente. Umgekehrt dürfen Arbeitspakete sich nicht überschneiden – jede Aktivität gehört genau zu einem Paket.

**Achtung:** 
- Nicht berücksichtigte Tätigkeiten (z.B. Projektmanagement, QS, Schulung) müssen dennoch explizit als Arbeitspakete aufgeführt werden
- Der Begriff „100%-Regel" bezieht sich auf Vollständigkeit, nicht auf die Anzahl der Ebenen

#### 1.3 Funktionen und Nutzen der WBS

| Funktion | Nutzen |
|----------|--------|
| **Navigationsrahmen** | Schafft Klarheit über den Umfang (Scope) des Projekts |
| **Kommunikationsmittel** | Ermöglicht ein gemeinsames Verständnis aller Stakeholder |
| **Planungsgrundlage** | Basis für Zeit-, Kosten-, Ressourcen- und Risikomanagement |
| **Kontrollrahmen** | Definiert die Struktur für Statusverfolgung und Earned Value Management |
| **Zuweisung von Verantwortung** | Klare Zuordnung von Arbeitspaketen zu Personen/Teams |
| **Konfigurationsmanagement** | Dient als Referenz bei Änderungen und Scope-Adjustments |

---

### 2. Zerlegungslogiken und Gestaltungsvarianten

Die Art, wie ein Projekt zerlegt wird, hängt stark vom **Projektkontext, der Branche und den Anforderungen** ab. Es gibt verschiedene bewährte Ansätze:

#### 2.1 Phasenorientierte WBS
**Struktur:** Aufteilung nach zeitlichen Projektphasen (z.B. Initiierung, Planung, Durchführung, Abschluss)

**Beispiel – Software-Projekt:**
```
Projekt: E-Commerce-Portal
├── Phase 1: Anforderungsanalyse
│   ├── Stakeholder-Interviews
│   ├── Anforderungsdokumentation
│   └── Konzepterstellung
├── Phase 2: Entwicklung
│   ├── Frontend-Entwicklung
│   ├── Backend-Entwicklung
│   └── Integration
├── Phase 3: Test & QA
│   ├── Funktionale Tests
│   ├── Lasttest
│   └── Abnahmetest
└── Phase 4: Deployment & Go-Live
    ├── Datenmigration
    ├── Schulung
    └── Live-Unterstützung
```

**Vorteile:**
- Zeitliche Abfolge deutlich
- Gut für Stakeholder-Kommunikation
- Einfache Meilensteinsetzung

**Nachteile:**
- Phasengrenzen oft unscharf
- Kann zu Phasensilo-Denken führen
- Weniger granular für Ressourcenallokation

#### 2.2 Komponentenorientierte WBS
**Struktur:** Aufteilung nach Deliverables oder technischen/fachlichen Komponenten

**Beispiel – Bauprojekt Umbau Bürogebäude:**
```
Projekt: Bürogebäude-Umbau
├── Rohbau
│   ├── Wand-/Trennwand-Arbeiten
│   ├── Estrich und Bodenbelag
│   └── Deckenarbeiten
├── Elektrik & Technik
│   ├── Stromversorgung
│   ├── Beleuchtung
│   └── Netzwerk & IT-Infrastruktur
├── Sanitär & Heizung
│   ├── Sanitäranlagen
│   ├── Heizungs-/Kühlsystem
│   └── Lüftung
├── Innenausbau
│   ├── Fenster & Türen
│   ├── Malerei & Oberflächenfinish
│   └── Einbaumöbel
└── Projektmanagement & QS
    ├── Bauleitung
    ├── Inspektionen
    └── Dokumentation
```

**Vorteile:**
- Klare Verantwortlichkeiten pro Komponente
- Gut für Lieferanten-Zuordnung (z.B. Subunternehmer)
- Hohe Kontrollierbarkeit einzelner Komponenten
- Förderliches für Modularisierung

**Nachteile:**
- Zeitliche Abhängigkeiten weniger deutlich
- Phasenskizze notwendig als Zusatz
- Kann bei interfacebezogenen Projekten komplex werden

#### 2.3 Prozessorientierte WBS
**Struktur:** Aufteilung nach funktionalen Prozessen oder Wertströmen

**Beispiel – Prozessoptimierungs-Projekt:**
```
Projekt: Lieferketten-Optimierung
├── Prozess: Beschaffung
│   ├── Lieferanten-Evaluation
│   ├── Kontrakt-Verhandlung
│   └── Bestellsystem-Setup
├── Prozess: Logistik & Lagerung
│   ├── Lagerbestands-Optimierung
│   ├── Transport-Planung
│   └── IT-System-Integration
├── Prozess: Verkauf & Distribution
│   ├── Verkaufs-Forecast-Modell
│   ├── Distributionskanal-Optimierung
│   └── Kundenauftrags-Prozess
└── Querschnitts-Aktivitäten
    ├── Change Management
    ├── Schulung & Training
    └── Kommunikation
```

**Vorteile:**
- Business-Logik ist nachvollziehbar
- Gut für organisatorische Veränderungsprojekte
- Klarheit über Prozessschnittstellen

**Nachteile:**
- Abgrenzung von Prozessen oft schwierig
- Overlaps möglich
- Weniger geeignet für technische Projekte

#### 2.4 Hybrid: Kombination mehrerer Logiken
Besonders bei komplexen Projekten ist eine **Mischform sinnvoll**. Beispiel:
- **Obere Ebene:** Phasen
- **Mittlere Ebene:** Komponenten
- **Untere Ebene:** Prozesse

---

### 3. Hierarchie und Verantwortlichkeitsmatrizen

#### 3.1 WBS-Ebenen und Detaillierungsgrad

Eine WBS sollte typischerweise **3–5 Hierarchieebenen** umfassen:

| Ebene | Name | Beispiel |
|-------|------|---------|
| 1 | Projekt | E-Commerce-Portal |
| 2 | Hauptkomponente/Phase | Frontend-Entwicklung |
| 3 | Unterkomponente | Benutzer-Login-Modul |
| 4 | Arbeitspakete | Login-Formular-Design |
| 5 | (Optional) Aktivitäten | HTML-Layout erstellen |

**Faustregel:**
- **Zu tief**: WBS wird unübersichtlich, Verwaltungsaufwand steigt unnötig
- **Zu flach**: Mangelnde Kontrolle, vage Verantwortlichkeiten
- **Richtige Balance**: Arbeitspakete sollten in 1–3 Wochen bearbeitbar sein und einer Person/einem Team zuweisbar sein

#### 3.2 RACI-Matrix (Responsibility Assignment Matrix)

Die **RACI-Matrix** verbindet WBS-Elemente mit Rollen und Verantwortlichkeiten. Sie beantwortet: *Wer ist wofür verantwortlich?*

**RACI-Definitionen:**

| Kürzel | Bedeutung | Beschreibung |
|--------|-----------|-------------|
| **R** | **Responsible** | Derjenige, der die Arbeit ausführt; kann mehrere geben |
| **A** | **Accountable** | Derjenige, der für das Endergebnis antwortet; sollte eindeutig sein |
| **C** | **Consulted** | Derjenige, der beratend hinzugezogen wird; bidirektionale Kommunikation |
| **I** | **Informed** | Derjenige, der informiert wird; unidirektionale Information |

**Beispiel RACI-Matrix – Marketing-Kampagne:**

| Arbeitspakete | PM | Marketing-Manager | Designer | Copywriter | Kunde |
|---|---|---|---|---|---|
| Kampagnen-Strategie | A | R | C | C | I |
| Designkonzept | C | A | R | C | C |
| Texterstellung | I | C | C | R | A |
| Media-Planung | I | R | I | I | I |
| Genehmigung | C | A | C | C | A |

**RACI Best Practices:**
- Jedes Arbeitspakete sollte **genau eine R und eine A haben**
- Übertriebenes C und I aufräumen – sonst wird es unhandlich
- Regelmäßig überprüfen und anpassen, wenn Rollen sich ändern

#### 3.3 RAM (Resource Assignment Matrix)

Alternative zu RACI, wenn **Ressourcen und deren Kapazität** im Vordergrund stehen. Zeigt prozentuale Allokation:

| Arbeitspakete | Developer 1 | Developer 2 | QA-Tester | PM |
|---|---|---|---|---|
| API-Entwicklung | 100% | 50% | — | 10% |
| Frontend | 50% | 100% | — | 10% |
| Testing | — | — | 100% | 5% |

---

### 4. Häufige Fehler und Best Practices

#### 4.1 Typische Fehler bei der WBS-Erstellung

| Fehler | Beschreibung | Auswirkung | Prävention |
|--------|-------------|-----------|-----------|
| **Unvollständigkeit** | Wesentliche Phasen/Komponenten fehlen (z.B. QS, Dokumentation, Schulung) | Unerwartete Kosten/Zeit | Stakeholder-Review & Lessons Learned |
| **Verstoß gegen 100%-Regel** | Überschneidung oder Lücken in der Zerlegung | Doppelarbeit oder vergessene Aufgaben | Hierarchisch überprüfen |
| **Zu viel/zu wenig Detail** | WBS ist entweder zu flach oder zu tief strukturiert | Kontrollverlust oder Verwaltungsüberflutung | Daumenregel: 1–3 Wochen pro Paket |
| **Keine Verantwortlichkeit** | Arbeitspakete nicht zugeordnet | Unklarheit, wer was macht | RACI-Matrix nutzen |
| **Inkonsistente Nomenklatur** | Mischung aus Phasen, Komponenten, Prozessen | Verwirrung | Einheitliche Konventionen |
| **Statische WBS** | WBS wird nach Initiierung nicht angepasst | Abweichungen, Kontrollverlust | Regelmäßige Reviews; Change-Prozess |
| **Zu abstrakt** | Zu allgemeine Beschreibung von Paketen | Missverständnisse | Detaillierte, konkrete Namen & Beschreibungen |

#### 4.2 Best Practices

1. **WBS sollte einfach und klar sein**  
   Verwende prägnante, konsistente Namensgebung (z.B. Verb + Objekt: "Login-Modul entwickeln")

2. **Mit Stakeholderbeteiligung erstellen**  
   WBS im Team erarbeiten, nicht alleine; ermöglicht Vollständigkeit und Akzeptanz

3. **Scope & nicht-Scope klären**  
   Explizit festhalten, was *nicht* zur WBS gehört (Scope Management)

4. **Arbeitspakete mit User Stories / Anforderungen verknüpfen**  
   Traceability zum Anforderungsmanagement

5. **WBS als „Gedächtnis" des Projekts nutzen**  
   Lessons Learned und Erkenntnisse für zukünftige Projekte speichern

6. **Regelmäßige Überprüfung und Validation**  
   Beim Kickoff mit dem Team, während der Planung, und vor Durchführung

7. **WBS in Projektmanagementsoftware implementieren**  
   Nutzung von Tools (YouTrack, MS Project, Asana, OpenProject) für Verfolgung und Reporting

---

### 5. Umsetzung der WBS in Werkzeugen

#### 5.1 WBS in YouTrack (Agile Tool mit hierarchischer Struktur)

**YouTrack**-Struktur (hierarchisch über Komponenten und Epics):
- **Epic** = WBS Hauptkomponente
- **Issue** = WBS Arbeitspakete
- **Subtasks** = Detailanforderungen

Beispiel:
```
Epic: Frontend-Entwicklung
  ├── Story: Login-Formular implementieren
  │   ├── Task: HTML-Struktur
  │   ├── Task: CSS-Styling
  │   └── Task: JavaScript-Logik
  ├── Story: Dashboard-View erstellen
  │   ├── Task: Daten-Abruf-Logik
  │   └── Task: UI-Layout
  └── Story: Fehlerbehandlung
      └── Task: Error-Message-System
```

**Vorteil:** Enge Integration mit Agile-Prozessen; gute Verfolgung in iterativen Projekten

#### 5.2 WBS in MS Project

**MS Project**-Struktur (hierarchisch über Gliederungscodes):
- Ebene 1: Projektname
- Ebene 2–n: Hierarchische Einrückung der Aufgaben (Task Outline)

Beispiel:
```
1. E-Commerce-Portal
   1.1 Anforderungsanalyse
       1.1.1 Interviews führen
       1.1.2 Anforderungsdokumentation
   1.2 Entwicklung
       1.2.1 Frontend
           1.2.1.1 Login-Modul
           1.2.1.2 Dashboard
   ...
```

**Vorteil:** Klassisches PM-Tool mit sehr feingranularer Kontrolle; Verknüpfung mit Ressourcen und Kosten einfach

---
## Wichtige Begriffserklärungen

| Begriff | Definition |
|---------|-----------|
| **Work Breakdown Structure (WBS)** | Hierarchische Zerlegung eines Projekts in Komponenten, Phasen oder Prozesse |
| **Arbeitspakete (Work Packages)** | Kleinste, eigenständige Einheiten auf der untersten WBS-Ebene; kontrollier- und zuweisbar |
| **Scope** | Der Umfang des Projekts; definiert durch die WBS-Grenzen |
| **Deliverable** | Ein materieller oder immaterieller Output eines Arbeitspaketes |
| **100%-Regel** | Jedes übergeordnete Element ist die Summe seiner untergeordneten Elemente |
| **Granularität** | Der Detaillierungsgrad einer WBS; wie tief die Zerlegung geht |
| **Verantwortlichkeitsmatrix** | Systematische Zuordnung von Aufgaben zu Rollen (RACI, RAM) |
| **Scope Creep** | Unkontrollierte Ausweitung des Projektumfangs über die WBS hinaus |

## Weiterführende Ressourcen

- **PMBOK Guide** (Project Management Institute): Abschnitt 4 – Project Integration Management & 5 – Scope Management
- **PRINCE2** – Product Breakdown Structure (PBS) als Alternative
- **ISO 21500** – Guidance on project management
- **YouTube**: „How to Create a Work Breakdown Structure" (verschiedene Vorträge)

---
## Reflexion und Transfer

Nach diesem Modul werdet ihr in der Lage sein, …
- ... eigene Projekte in klare, verständliche Strukturen zu zerlegen
- ... die WBS als Kontrollinstrument über den gesamten Projektablauf einzusetzen
- ... Missverständnisse über Projektgrenzen und Verantwortlichkeiten zu vermeiden
- ... mit standardisierten Werkzeugen eine WBS umzusetzen

Diese Fähigkeiten sind **unverzichtbar** für erfolgreiche Projektplanung und -control!