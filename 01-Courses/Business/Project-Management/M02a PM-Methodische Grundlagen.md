## Lernziele

Nach Abschluss dieses Moduls können die Teilnehmer:

- **Unterschiede** zwischen klassischen, agilen und hybriden PM-Ansätzen erklären und bewerten
- **PM-Standards** (PMBOK, PRINCE2, IPMA) in ihren Anwendungskontexten einordnen
- **Rollen und Verantwortlichkeiten** im Projektteam klar definieren
- **Methodenwahl begründen** basierend auf Projektkontext und -anforderungen
- **Eigene Kompetenzbereiche** reflektieren und einen Entwicklungsplan skizzieren

---

## Unit 1: Klassisches (Wasserfall-) Projektmanagement

### Charakteristika des klassischen Ansatzes

**Definition**: Sequenzielle, phasenorientierte Vorgehensweise mit Vorhersagbarkeit und umfassender Dokumentation.

**Kernprinzipien**:
- **Phasenorientierung** – Anforderungen → Design → Implementierung → Test → Abschluss
- **Vorhersagbarkeit** – Umfang (Scope) früh definiert und geschützt
- **Dokumentationsfokus** – Umfassende Spezifikationen vor Implementierung
- **Sequenzielles Timing** – Eine Phase nach der anderen, begrenzte Parallelisierung
- **Wasserfallprinzip** – Rücksprünge zu früheren Phasen sind teuer und unerwünscht

### Typische Instrumente und Werkzeuge

| Instrument | Zweck |
|---|---|
| **Anforderungsspezifikation** | Vollständige, detaillierte Anforderungserfassung |
| **Gantt-Diagramm (MS Project)** | Lineare Zeitplanung aller Aktivitäten |
| **Risikoregister** | Statische Erfassung bekannter Risiken |
| **Budget- und Kostenplan** | Top-Down oder Bottom-Up Kalkulation |
| **Statusbericht** | Monatliche oder wöchentliche Fortschrittberichte mit KPIs |

### Stärken des klassischen Ansatzes

✅ Geeignet für **stabile, vorhersehbare Anforderungen** (Infrastruktur, Bau, Manufaktur)

✅ **Klare Struktur und Governance** – Alle Phasen und Verantwortlichkeiten sind explizit

✅ **Budgetplanungssicherheit** – Durch detaillierte frühe Kalkulationen

✅ **Regulatorische & vertragliche Compliance** – Dokumentation ist nachvollziehbar

✅ **Große, verteilte Teams** – Zentrale Koordination über Plan möglich

### Grenzen und typische Probleme

❌ **Späte Fehlererkennung** – Fehler früher Phasen teuer am Ende entdeckt

❌ **Geringe Flexibilität** – Änderungen sind Scope Creep und teuer

❌ **"Analyse-Lähmung"** – Lange Planungsphase verzögert Wertschöpfung

❌ **Wenig Kundenfeedback** – Einbindung primär am Anfang und Ende

❌ **Technologie-Veralterung** – Tech kann veralten vor Projektende


---

## Unit 2: Agiles Projektmanagement

### Agile Werte und Prinzipien

Das **Agile Manifest** (2001) priorisiert:

> **Individuals and interactions** over processes and tools  
> **Working software** over comprehensive documentation  
> **Customer collaboration** over contract negotiation  
> **Responding to change** over following a plan

### Scrum – Das populärste Agile Framework

**Rollen in Scrum**:

| Rolle | Verantwortung |
|---|---|
| **Product Owner (PO)** | Vertritt Kundenperspektive, priorisiert Backlog |
| **Scrum Master** | Facilitator & Coach, entfernt Hindernisse |
| **Dev Team** | Selbstorganisierendes Entwicklungsteam |

**Hauptartefakte**:
- **Product Backlog** – Priorisierte Liste aller Anforderungen
- **Sprint Backlog** – Items für den aktuellen Sprint
- **Increment** – Funktionsfähiges Produktergebnis

**Hauptereignisse**:
- **Sprint Planning** – Team wählt Items aus
- **Daily Standup** – 15-Min tägliche Synchronisation
- **Sprint Review** – Präsentation des Increments
- **Sprint Retrospektive** – Team-Reflexion über Verbesserungen

### Kanban – Alternative Agile Methode

**Kernprinzipien**:
- **Visualisierung** – Workflow sichtbar (To Do → In Progress → Done)
- **WIP-Limitierung** – Max. gleichzeitig bearbeitete Items
- **Durchsatzfokus** – Items pro Woche messbar
- **Kontinuierliche Verbesserung** – Ständiges Optimieren

### Stärken des agilen Ansatzes

✅ **Schnelle Wertschöpfung** – Erste Inkremente nach 2–4 Wochen

✅ **Hohe Kundenzufriedenheit** – Regelmäßiges Feedback & Anpassung

✅ **Motivierte Teams** – Autonomie, schnelle Erfolgserlebnisse

✅ **Frühe Risikenerkennung** – Probleme offenbaren sich schnell

✅ **Flexibilität** – Anforderungsänderungen willkommen, nicht Fehler

✅ **Weniger Dokumentation** – Fokus auf funktionierende Software

### Herausforderungen und Grenzen

❌ **Skalierbarkeit** – Scrum mit 7 Personen super, mit 100 Personen schwierig

❌ **Vertragliche Anforderungen** – Fixed-Price-Verträge schwierig

❌ **Unklare finale Kosten** – Nicht immer planbar

❌ **Team-Reife erforderlich** – Self-Organization braucht erfahrene Entwickler

❌ **Abhängigkeit vom Product Owner** – Muss ständig verfügbar sein

❌ **Große Stakeholder-Basis** – Schwer zu managen mehrere Interessensgruppen

---

## Unit 3: Hybrid und Tailoring

### Hybride Ansätze

Ein **hybrider Ansatz** kombiniert klassische Stabilität mit agiler Flexibilität.

**Hybrid-Spektrum**:

| Dimension | Klassisch | Hybrid | Agil |
|---|---|---|---|
| **Planungstiefe initial** | sehr hoch | mittel | niedrig |
| **Anforderungsstabilität** | sehr stabil | teilweise stabil | volatil |
| **Änderungshäufigkeit** | selten, teuer | regelmäßig | ständig, normal |
| **Stakeholder-Anzahl** | viele, formell | viele, mixed | wenige, direkt |

**Hybrid-Beispiele**:
- **Phase-Gate-Hybrid** – Klassische Gates, aber Phasen intern agil
- **Kanban im klassischen Umfeld** – Klassischer Plan + agile Kanban-Ausführung
- **SAFe (Scaled Agile Framework)** – Agile Teams mit klassischem Portfolio-Management

### Tailoring – Methodenwahl nach Kontext

**Tailoring** bedeutet: Es gibt keine One-Size-Fits-All-Methode!

**Kontextfaktoren für Methodenwahl**:

1. **Anforderungsstabilität** – Stabil (klassisch) oder volatil (agil)?
2. **Projektgröße & Team** – Große Orgas (klassisch) oder kleine Teams (agil)?
3. **Geografische Verteilung** – Verteilt (klassisch) oder co-located (agil)?
4. **Stakeholder-Komplexität** – Viele (klassisch) oder wenige, klar (agil)?
5. **Regulierung** – Strict (klassisch) oder flexibel (agil)?
6. **Tech-Neuheit** – Bewährt (klassisch) oder neu (agil)?
7. **Budget-Flexibilität** – Fix (klassisch) oder variabel (agil)?
8. **Org-Agile-Reife** – Keine Erfahrung (klassisch) oder fortgeschritten (agil)?

**Entscheidungslogik**:

```
IF Anforderungen stabil + Budget fix + großes Team + Regulierung
  THEN klassisch (oder Phase-Gate)
ELSE IF Anforderungen volatil + schnelle Wertschöpfung + kleine Teams
  THEN agil (Scrum/Kanban)
ELSE
  THEN hybrid (tailored Mix)
```

---

## Unit 4: PM-Standards und Rollen

### Überblick Internationale PM-Standards

| Standard | Ursprung | Fokus | Zielgruppe |
|---|---|---|---|
| **PMBOK®** | USA (PMI) | 10 Knowledge Areas, prozessorientiert | große Orgas, klassisches PM |
| **PRINCE2®** | UK | 7 Prozesse, Governance-fokussiert | Government, UK/EU, IT |
| **IPMA ICB** | International | 4 Kompetenzbereiche, ganzheitlich | Europa, globale Orgas |
| **Agile Practice Guide** | USA (PMI) | Agile & Hybrid-Guidance | Agile Teams |
| **Scrum Guide** | International | Scrum-Framework | Agile Teams |

### PMBOK® – Die 10 Knowledge Areas (Überblick)

1. **Integration Management** – Koordination aller PM-Prozesse
2. **Scope Management** – Definition & Kontrolle des Umfangs
3. **Schedule Management** – Zeitplanung & -kontrolle
4. **Cost Management** – Kostenplanung & Controlling
5. **Quality Management** – Standards, Tests, Verbesserung
6. **Resource Management** – Team, Kapazität, Skills
7. **Communications Management** – Information & Reporting
8. **Risk Management** – Erkennung & Reaktion auf Risiken
9. **Procurement Management** – Beschaffung & Verträge
10. **Stakeholder Management** – Analyse, Engagement, Konflikt

### Rollen und Verantwortlichkeiten

**Die vier Hauptrollen**:

| Rolle | Verantwortung | Besetzung |
|---|---|---|
| **Sponsor** | Budget, Erfolgskriterien, strategische Alignierung | meist C-Level |
| **Projekt Manager** | Operative Planung & Kontrolle, tägliche Koordination | PM (1–5 Jahre) oder Senior |
| **Product Owner / Analyst** | Anforderungen, Priorisierung, Akzeptanzkriterien | Fachexperte aus Business |
| **Team** | Umsetzung, technische Decisions, Schätzung | Entwickler, Tester, Designer |

### Kompetenzbereiche eines Projektmanagers

**Säule 1: Technische Kompetenzen** (40%)
- Methoden & Standards (PMBOK, Scrum, etc.)
- Werkzeugkompetenz (MS Project, Jira, etc.)
- Domänenwissen (branchenspezifisch)

**Säule 2: Verhaltensmäßige Kompetenzen** (40%)
- Kommunikationsfähigkeit
- Konfliktlösung & Mediation
- Führung & Motivation
- Stressresistenz & Zielorientierung
- Kreativität & Problemlösung

**Säule 3: Kontext-Kompetenz** (20%)
- Geschäftsverständnis
- Organisationskultur
- Regulatorische Anforderungen
- Stakeholder-Landschaft verstehen

---
### Häufige Anfängerfehler

1. **„Agil ist immer besser"** – Dogmatismus vermeiden, Kontext zählt
2. **Scrum und Agil gleichsetzen** – Scrum ist ein Framework von vielen
3. **Rollen vermischen** – Klare Verantwortlichkeit essentiell
4. **Keine Tailoring** – Copy-Paste schlecht, Adaptation gut
5. **Zu viel Dokumentation** – Dokumentation dient dem Projekt, nicht sich selbst
## Wichtige Begriffserklärungen (Glossar)

| Begriff              | Erklärung                                                            |
| -------------------- | -------------------------------------------------------------------- |
| **Agil**             | Flexibel, adaptiv, iterativ; schnelle Anpassung an Veränderungen     |
| **Backlog**          | Priorisierte Liste von Anforderungen / User Stories                  |
| **Klassisch**        | Sequenzielle, phasenweise Abarbeitung; Plan vor Execution            |
| **Hybrid**           | Kombination aus klassischen und agilen Elementen                     |
| **IPMA**             | International Project Management Association (europäischer Standard) |
| **Knowledge Areas**  | 10 Wissensgebiete des PMBOK                                          |
| **PMI**              | Project Management Institute (US-Verband, PMBOK-Urheber)             |
| **PMBOK**            | Project Management Body of Knowledge (Standard der PMI)              |
| **PRINCE2**          | UK-Standard für Projektmanagement                                    |
| **Product Owner**    | Rolle in Scrum; vertritt Kundenperspektive                           |
| **Scrum**            | Agiles Framework mit Sprints, Daily Standups, Retrospektiven         |
| **Scope Creep**      | Unkontrolliertes Hinzufügen von Anforderungen                        |
| **Sprint**           | Iterationszyklus in Agil (meist 2–4 Wochen)                          |
| **Stakeholder**      | Personen mit Interesse am Projekt                                    |
| **Tailoring**        | Anpassung von PM-Methoden an Projektkontext                          |
| **Wasserfallmodell** | Klassisches sequenzielles PM-Modell                                  |
