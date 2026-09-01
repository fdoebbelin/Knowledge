## Überblick und Lernziele

Dieses Modul führt Sie in die agilen Arbeitsmethoden im Projektmanagement ein. Agile Methoden sind eine Alternative zu klassischen, plangesteuerten Ansätzen und zeichnen sich durch **Flexibilität, iterative Entwicklung und enge Zusammenarbeit mit dem Kunden** aus.

### Lernziele des Moduls

Nach diesem Modul werden Sie in der Lage sein:

- Die **agilen Werte und Prinzipien** (Agiles Manifest) zu verstehen und zu erklären
- **Scrum** als führendes agiles Framework mit seinen Rollen, Ereignissen (Events) und Artefakten anzuwenden
- **Kanban** als kontinuierliche Workflow-Methode zu nutzen und Work-In-Progress (WIP) zu steuern
- Zu verstehen, **wann agile Methoden sinnvoll sind** und wo Grenzen liegen
- **Skalierungsmodelle** (SAFe, LeSS, Spotify) zu kennen und deren Anwendungsfelder zu erkennen
- Agile **Projekte in der Praxis** zu planen und umzusetzen, insbesondere mit YouTrack oder ähnlichen Tools

---

## 1. Agile Werte und Prinzipien

### 1.1 Das Agile Manifest – Die vier Kernwerte

Das **Agile Manifest** wurde 2001 von 17 Softwareentwicklern formuliert und bildet die Grundlage aller agilen Methoden. Es betont vier Kernwerte:

#### **Wert 1: Individuen und Interaktionen vor Prozessen und Werkzeugen**

- **Bedeutung**: Menschen sind wichtiger als starre Abläufe. Direkte Kommunikation und Zusammenarbeit werden bevorzugt.
- **Praktische Folge**: Daily Standups statt umfangreicher Statusberichte; direkte Gespräche statt E-Mails.
- **Beispiel**: Ein Entwickler fragt den Produkteigentümer direkt nach einer Anforderung, anstatt ein formales Anforderungsdokument zu erstellen.

#### **Wert 2: Funktionierende Software vor umfassender Dokumentation**

- **Bedeutung**: Das **Arbeitsergebnis** (das Produkt) steht im Fokus, nicht die Verwaltung von Dokumenten.
- **Praktische Folge**: Iterative Lieferung von Zwischenergebnissen (Inkremente); minimalistische Dokumentation, die gerade ausreicht.
- **Beispiel**: Nach jedem Sprint gibt es eine **Produktinkrement** (ein lauffähiger Teil der Software), den der Kunde nutzen und bewerten kann.

#### **Wert 3: Kundenzusammenarbeit vor Vertragsverhandlung**

- **Bedeutung**: Der Kunde ist aktiv beteiligt, nicht nur Auftraggeber. Gemeinsames Lernen und Anpassen stehen im Vordergrund.
- **Praktische Folge**: Der Kunde nimmt an Sprint Reviews teil und gibt direktes Feedback. Bei Anforderungsänderungen wird flexibel reagiert.
- **Beispiel**: Statt eines unterschriebenen Lastenhefts zu Beginn wird das Produkt gemeinsam in Zyklen entwickelt und verfeinert.

#### **Wert 4: Reagieren auf Veränderung vor Befolgen eines Plans**

- **Bedeutung**: Pläne sind notwendig, aber **Flexibilität und Anpassung** sind wertvoll, wenn sich der Markt, die Anforderungen oder die Technologie ändert.
- **Praktische Folge**: Product Backlog wird laufend priorisiert und angepasst; Sprints richten sich nach aktuellen Erkenntnissen.
- **Beispiel**: Neue Kundenanforderung oder technische Erkenntnis führt zu Anpassung im nächsten Sprint.

### 1.2 Die zwölf agilen Prinzipien

Die zwölf Prinzipien konkretisieren die vier Werte:

| Prinzip | Erläuterung |
|---------|-------------|
| **Kundenzufriedenheit** | Frühe und kontinuierliche Lieferung von Wert |
| **Anforderungsänderungen** | Änderungen sind willkommen, auch spät in der Entwicklung |
| **Häufige Lieferung** | Inkremente im 1–4-Wochen-Rhythmus ausliefern |
| **Zusammenarbeit** | Geschäft und Entwicklung arbeiten täglich zusammen |
| **Selbstmotivierte Teams** | Teams mit Vertrauen und Unterstützung sind produktiver |
| **Face-to-Face-Kommunikation** | Direkte Gespräche sind am effektivsten |
| **Funktionierendes Produkt** | Ist das primäre Erfolgskriterium |
| **Nachhaltige Pace** | Teams arbeiten im stabilen, langfristig haltbaren Tempo |
| **Technische Exzellenz** | Aufmerksamkeit auf Handwerk und Design verbessert Agilität |
| **Einfachheit** | Maximiere die Menge nicht geleisteter Arbeit |
| **Selbstorganisation** | Die besten Architekturen entstehen in selbstorganisierten Teams |
| **Reflexion** | Regelmäßige Anpassung von Prozess und Verhalten |

### 1.3 Abgrenzung: Klassisch vs. Agil vs. Hybrid

| Kriterium | Klassisch (Wasserfall) | Agil (Scrum/Kanban) | Hybrid |
|-----------|----------------------|-----------------|--------|
| **Planungshorizont** | Vollständig zu Beginn | Rolling Wave, fortlaufend | Teilweise geplant, teilweise iterativ |
| **Anforderungen** | Fest, dokumentiert | Emergent, flexible Priorisierung | Grobe Anforderungen + Details iterativ |
| **Lieferrhythmus** | Ein großer Schlusslieferung | Regelmäßige Inkremente (Sprints) | Mischung aus längeren Phasen und Sprints |
| **Kunde** | Briefing + Abnahme | Aktiv in jedem Sprint | Im Review und an Meilensteinen |
| **Dokumentation** | Umfangreich | Minimal, just-enough | Moderate, zielgerichtet |
| **Fehlerkosten** | Hoch am Ende | Niedrig, früh erkannt | Je nach Kontext |
| **Sinnvoll für** | Stabile, klare Projekte | Innovative, neue Produkte | Große Projekte mit stabilen + neuen Teilen |

---

## 2. Scrum – Das agile Framework

### 2.1 Scrum: Die Definition

**Scrum** ist ein **Rahmenwerk (Framework)** zur Verwaltung komplexer Produktentwicklung. Es ist nicht eine Sammlung von Techniken, sondern eine Struktur mit definierten Rollen, Events und Artefakten.

> **Merksatz**: Scrum ist wie ein Rugbyspiel – eine Mannschaft arbeitet in kurzen, intensiven Phasen (Sprints) zusammen, um das "Spielfeld" (das Ziel) zu erreichen.

### 2.2 Die drei Scrum-Rollen

#### **Role 1: Product Owner (Produkteigentümer)**

- **Aufgabe**: Vertritt den Kunden/die Stakeholder; definiert und priorisiert die **Product-Backlog-Einträge**.
- **Verantwortung**:
  - Backlog erstellen, verfeinern und priorisieren (basierend auf Geschäftswert)
  - Mit Team und Stakeholdern kommunizieren
  - Akzeptanzkriterien definieren
  - Sprint Review durchführen und Feedback verarbeiten
- **Kompetenzen**: Geschäftsverständnis, Kommunikation, Entscheidungskompetenz
- **Hinweis**: Es kann nur **einen** Product Owner pro Team geben; sonst entstehen Konflikte in der Priorisierung.

#### **Role 2: Scrum Master (Agile Coach)**

- **Aufgabe**: Hilft dem Team, Scrum zu verstehen und zu nutzen. **Kein Projektleiter, kein Vorgesetzter!**
- **Verantwortung**:
  - Scrum-Prozess im Team etablieren und schützen
  - Impedimente (Blockaden) erkennen und eskalieren
  - Das Team coachen, selbstorganisiert zu werden
  - Scrum-Events moderieren (Daily Standup, Sprint Review, Retrospektive)
  - Mit Product Owner zusammenarbeiten bei der Backlog-Verwaltung
- **Kompetenzen**: Prozessverständnis, Coaching, Moderation, Konfliktlösung
- **Hinweis**: Nicht "verwaltet" das Team, sondern **befähigt** es.

#### **Role 3: Development Team (Entwicklungsteam)**

- **Aufgabe**: Setzt die Backlog-Einträge um und liefert das **Produktinkrement** am Ende des Sprints.
- **Verantwortung**:
  - Aufgaben schätzen und übernehmen
  - Täglich zusammenarbeiten (Daily Standup)
  - Qualität sichern (Test, Code Review)
  - Hindernisse selbst lösen oder dem Scrum Master melden
  - Am Sprint Review und der Retrospektive teilnehmen
- **Kompetenzen**: Technisch vielfältig, selbstorganisierend, eigenverantwortlich
- **Größe**: Üblicherweise 5–9 Personen; Klein genug für enge Kommunikation, groß genug für Vielfalt
- **Hinweis**: "T-förmige Fähigkeiten" sind wertvoll: Tiefenwissen in einem Fachbereich + Grundwissen in anderen Bereichen.

### 2.3 Die Scrum-Artefakte

Artefakte sind die **Arbeitsergebnisse und Informationsspeicher** in Scrum.

#### **Artefakt 1: Product Backlog**

Ein **priorisierte Liste aller Anforderungen, Wünsche und Verbesserungen** für das Produkt.

- **Eigenschaften**:
  - Geordnet nach **Geschäftswert** (oben: höchste Priorität)
  - Verfeinert: Obere Items sind detaillierter, untere skizzenhaft
  - Lebendig: Wird laufend hinzugefügt, gelöscht, priorisiert
  - Besitz: Verantwortung des Product Owner
- **Einträge (Items)**: User Stories, Defekte, Verbesserungen, technische Schulden
- **Beispiel-Format**:
  ```
  Als Kunde möchte ich Produkte filtern nach Kategorie, 
  um schneller das Gesuchte zu finden.
  Akzeptanzkriterien:
  - Filter zeigt alle verfügbaren Kategorien
  - Mehrfachauswahl möglich
  ```

#### **Artefakt 2: Sprint Backlog**

Die **Teilmenge des Product Backlog**, die das Team im aktuellen Sprint umsetzt.

- **Eigenschaften**:
  - Gewählt vom Team zusammen mit Product Owner in **Sprint Planning**
  - Zerlegt in konkrete Aufgaben
  - Sichtbar und transparent (on Board, in YouTrack, etc.)
  - Nur das Development Team darf Sprint Backlog ändern
- **Zweck**: Selbstorganisiertes Tracking; jeder sieht, wer woran arbeitet

#### **Artefakt 3: Produktinkrement (Product Increment)**

Das **funktionierende, potentiell auslieferbare Produkt** am Ende eines Sprints.

- **Eigenschaften**:
  - Alle fertiggestellten Backlog-Einträge des Sprints
  - Erfüllt die **"Definition of Done"** (s. u.)
  - Kann sofort zum Kunde gehen (muss aber nicht)
  - Addiert sich zu vorherigen Inkremente
- **Wichtig**: Nicht jedes "technisch fertig" ist auch "fertig" – es muss den Qualitätsstandards genügen.

#### **Definition of Done (DoD)**

Die **gemeinsame Regel**, was "fertig" bedeutet. Beispiele:

- Code geschrieben und überprüft
- Unit Tests vorhanden und grün
- In Testumgebung getestet
- Dokumentation aktualisiert
- Akzeptanzkriterien erfüllt
- Security-Check bestanden

### 2.4 Die Scrum-Events (Zeremonien)

**Scrum nutzt regelmäßige, zeitgebundene Events** zur Struktur und Transparenz.

#### **Event 1: Sprint Planning (2–4 Stunden für 2-Wochen-Sprint)**

- **Ziel**: Gemeinsam den Sprint vorbereiten
- **Teilnehmer**: Product Owner, Scrum Master, Development Team
- **Ablauf**:
  - **Teil 1**: Product Owner präsentiert die **Top-Prioritäten** des Product Backlog. Team stellt Fragen.
  - **Teil 2**: Team bespricht **"Wie machen wir das?"** und zerlegt Items in Aufgaben (Task Breakdown)
  - **Teil 3**: Team **committed** sich zu einem realistischen Sprintziel
- **Ergebnis**: Neuer Sprint Backlog, Sprint Goal (z. B. "Benutzer können sich anmelden und Profile anlegen")

#### **Event 2: Daily Standup (15 Minuten, täglich)**

- **Ziel**: Schnelle Synchronisierung und Hindernis-Erkennung
- **Ort & Zeit**: Immer zur gleichen Zeit, am gleichen Ort (oder virtuell)
- **Format**: Jeder beantwortet drei Fragen:
  - Was habe ich gestern fertiggestellt?
  - Was bearbeite ich heute?
  - Gibt es Hindernisse, die mich blockieren?
- **Wichtig**: Keine Problemlösung im Standup selbst; nur Hindernis-Sammlung. Probleme werden danach gelöst.
- **Dauer**: Hart 15 Minuten! Andernfalls ist es ineffizient.

#### **Event 3: Sprint Review (1–2 Stunden)**

- **Ziel**: Das fertige Produktinkrement **zeigen und Feedback einholen**
- **Teilnehmer**: Scrum Team, Stakeholder, Kunde
- **Ablauf**:
  - Team **präsentiert** das, was im Sprint fertig wurde
  - Feedback von Stakeholdern einholen (z. B. "Das gefällt mir, aber...")
  - Diskussion über nächste Prioritäten
- **Ergebnis**: Gesammeltes Feedback für Product Backlog-Verfeinerung

#### **Event 4: Sprint Retrospektive (45 Minuten – 1,5 Stunden)**

- **Ziel**: Team reflektiert über den Sprint und verbessert seinen **Prozess**
- **Teilnehmer**: Development Team, Scrum Master (nicht unbedingt Product Owner dabei)
- **Ablauf**: Verschiedene Formate möglich:
  - **Start-Stop-Continue**: Was anfangen? Was stoppen? Was weitermachen?
  - **Ampel-Modell**: Was war Grün (gut), Gelb (okay), Rot (verbessern)?
  - **Rosy-Thorn-Wish**: Was war schön? Was war schwierig? Was wünsche ich mir?
- **Ergebnis**: Konkrete **Verbesserungsmaßnahmen** für nächsten Sprint (z. B. "Weniger Meeting-Unterbrechungen"; "Bessere Code Reviews")
- **Wichtig**: Psychologisch sicher Raum; es geht um Lernkultur, nicht um Schuldzuweisung.

---

## 3. Kanban – Das Workflow-Management

### 3.1 Kanban: Die Definition und Herkunft

**Kanban** (日本語: 看板, "Signaltafel") kommt aus der **Lean-Manufacturing** (Toyota). Es ist eine **Methode zur Visualisierung und Optimierung von Workflows**.

> **Kernidee**: Arbeit wird **visualisiert**, **limitiert** und **durchflossen**, anstatt in großen Chargen geplant zu werden.

### 3.2 Die fünf Grundprinzipien von Kanban

1. **Visualisierung des Workflows**: Alle Aufgaben sind sichtbar (auf Board oder Tool)
2. **Limitierung von Work-In-Progress (WIP)**: Nicht zu viel gleichzeitig in Bearbeitung
3. **Handhabung von Durchsatzfluss**: Fokus auf kontinuierliche Lieferung, nicht auf Projekte
4. **Explizite Richtlinien**: Klare Regeln, wann etwas "fertig" und "in den nächsten Schritt" geht
5. **Implementierung von Feedback-Schleifen**: Regelmäßige Metriken und Anpassungen

### 3.3 Das Kanban Board

Ein typisches **Kanban Board** hat mehrere Spalten, die den **Workflow** darstellen:

```
┌─────────────┬─────────────┬─────────────┬─────────────┐
│   To Do     │  In Progress│ In Review   │   Done      │
│  (WIP: ∞)   │  (WIP: 3)   │  (WIP: 2)   │  (WIP: ∞)   │
├─────────────┼─────────────┼─────────────┼─────────────┤
│             │             │             │             │
│ [Task A]    │ [Task D]    │ [Task F]    │ [Task G]    │
│             │             │ [Task E]    │             │
│ [Task B]    │ [Task H]    │             │             │
│             │             │             │             │
│ [Task C]    │             │             │             │
│             │             │             │             │
└─────────────┴─────────────┴─────────────┴─────────────┘
```

**Work-In-Progress (WIP) Limits**: Jede Spalte hat ein Maximum an gleichzeitigen Aufgaben, um Überlastung zu vermeiden.

### 3.4 Kanban vs. Scrum

| Kriterium | Kanban | Scrum |
|-----------|--------|-------|
| **Iterationen** | Kontinuierlicher Fluss (keine Sprints) | Zeitfestgelegte Sprints (meist 2 Wochen) |
| **WIP-Limit** | Zentral; pro Spalte | Implizit; pro Sprint |
| **Planungshorizont** | Rollen Sie auf (Rolling Wave) | Sprint-Plan + Produktinkrement |
| **Rollen** | Optional/flexibel | Fest (PO, SM, Team) |
| **Metriken** | Lead Time, Cycle Time, Durchsatz | Velocity (Geschwindigkeit) |
| **Change-Anfälligkeit** | Hoch; passt sich sofort an | Mittel; wird im nächsten Sprint berücksichtigt |
| **Beste Einsatzfälle** | Support, Betrieb, wartungsorientierte Arbeit | Produkt-Innovation, Feature-Entwicklung |

### 3.5 Kanban-Metriken

#### **Lead Time (Durchlaufzeit)**

Zeit vom Eingang einer Anforderung bis zur Lieferung.

**Formel**: Lead Time = Lieferdatum − Erstellungsdatum

#### **Cycle Time (Bearbeitungszeit)**

Zeit von Beginn der Bearbeitung bis zum Abschluss.

**Formel**: Cycle Time = Abschluss-Datum − Start-Datum

#### **Durchsatz (Throughput)**

Anzahl der fertiggestellten Items pro Zeitraum (z. B. pro Woche).

**Beispiel**: "Wir liefern durchschnittlich 5 Features pro Woche"

#### **Cumulative Flow Diagram (CFD)**

Ein **Diagramm**, das zeigt, wie viele Items sich in welchem **Status** befinden über die Zeit hinweg.

**Nutzen**: Erkennung von Engpässen (z. B. "In Review" staut sich immer auf)

---

## 4. Praktische Anwendung: Agile Tools im Projektmanagement

### 4.1 YouTrack – Agile Projektmanagement-Software

**YouTrack** ist ein **Issue-Tracking- und Agile-Planungs-Tool** von JetBrains.

#### **Kernfeatures in YouTrack**:

- **Issues/Tasks**: Einträge mit ID, Beschreibung, Assignee, Status, Labels
- **Agile Boards**: Kanban-ähnliche Visualisierung des Workflows
- **Sprints**: Zeitfestgelegte Iterationen mit Sprint-Zielen
- **Workflows**: Benutzerdefinierte Status-Übergänge (z. B. To Do → In Progress → Done)
- **Reporting**: Burn-Down-Charts, Reports zu Durchsatz und Lead Time
- **Integration**: Mit VCS (Git), Slack, andere Tools

#### **Anwendungsbeispiel**: Sprint-Planung in YouTrack

1. **Issue erstellen**: "Als Benutzer möchte ich..."
2. **Zur Sprint hinzufügen**: "Sprint 1" auswählen
3. **Estimation**: Punkte eingeben (Story Points)
4. **Board anschauen**: Agile Board zeigt Status
5. **Daily**: Issues verschieben von To Do → In Progress → Done
6. **Sprint abschließen**: Report anschauen, nächsten Sprint planen

---

## 5. Skalierung agiler Methoden

### 5.1 Das Problem: Scrum für größere Teams?

**Scrum funktioniert gut für kleine Teams (5–9 Personen)**. Aber was, wenn Sie 50–200 Personen haben?

**Skalierungsprobleme**:
- Zu viele Meetings
- Abhängigkeiten zwischen Teams
- Nicht klare Architektur
- Priorisierungs-Konflikte

### 5.2 Skalierungsmodelle

#### **SAFe (Scaled Agile Framework)**

- **Struktur**: Mehrere Scrum-Teams in einem **"Agile Release Train (ART)"**
- **Cadence**: 2-Wochen-Sprints, 8-10 Wochen-Inkremente (PI Planning)
- **Rollen**: Zusätzlich zu Scrum: Release Train Engineer, Product Manager
- **Best für**: Große, hierarchische Organisationen
- **Kritik**: Komplex, viel Dokumentation (nicht immer "agil")

#### **LeSS (Large-Scale Scrum)**

- **Struktur**: Mehrere Scrum-Teams teilen sich einen Product Backlog
- **Rollen**: Ein Product Owner für alle Teams
- **Vorteil**: Einfacher als SAFe, bleiben nah am Original-Scrum
- **Best für**: Organisationen, die Scrum scalieren wollen, ohne kompliziert zu werden

#### **Spotify Model**

- **Struktur**: Squads (kleine Scrum-Teams), Tribes (Sammlung von Squads), Kapitel (Fachgruppen)
- **Kultur**: Autonomie + Alignment (Selbstständigkeit mit Richtung)
- **Best für**: Tech-Startups, schnelle Iteration, dezentrale Entscheidungen

---

## 6. Agile Best Practices und Häufige Fehler

### 6.1 Best Practices

- **Daily Standup auch online**: Mit verteilten Teams Zoom/Slack nutzen, aber kurz halten
- **Sichtbare Metriken**: Burndown, Velocity, Lead Time im Team-Raum oder auf Dashboard
- **Psychologische Sicherheit**: Fehler sind ok; Lernen > Blame
- **Enge Zusammenarbeit mit PO**: Nicht "Anforderungen werfen und verschwinden"
- **Regelmäßige Retrospektiven**: Mit echtem Follow-Up auf Verbesserungen
- **Definition of Done schriftest**: Alle kennen die Standards

### 6.2 Häufige Fehler

| Fehler | Problem | Lösung |
|--------|---------|--------|
| **"Agil" ohne echte Kommunikation** | Teams arbeiten isoliert | Tägliche Standups, gemeinsame Zeiten |
| **Zu viele WIP** | Aufgaben stapeln sich | WIP-Limits erzwingen |
| **Ignorieren von Technischer Schuld** | System wird instabil | Backlog für Tech-Schuld freigeben |
| **Scrum Master ist Projektleiter** | Keine Selbstorganisation | Scrum Master ist Coach, nicht Chef |
| **Product Owner abwesend** | Keine klare Priorisierung | PO muss verfügbar sein |
| **Sprint Review ist Theater** | Kein echtes Feedback | Echte Demo mit echtem Stakeholder-Feedback |

---

### Wichtige Begriffe und Definitionen

| Begriff | Definition |
|---------|-----------|
| **Agile** | Flexible, iterative Arbeitsweise mit regelmäßigem Feedback |
| **Scrum** | Rahmenwerk mit Sprints, Rollen und Events |
| **Kanban** | Workflow-Methode mit WIP-Limits und kontinuierlichem Fluss |
| **Sprint** | Zeitfestgelegte Iteration (meist 1–4 Wochen) |
| **User Story** | Anforderung aus Nutzersicht: "Als X möchte ich Y, um Z..." |
| **Story Point** | Relative Größenschätzung, nicht Stunden |
| **Burndown** | Diagramm, das verbleibende Arbeit zeigt |
| **Definition of Done** | Qualitätskriterien, um Aufgaben als "fertig" zu erklären |
| **WIP (Work-in-Progress)** | Anzahl der gleichzeitig in Bearbeitung befindlichen Aufgaben |
| **Retrospektive** | Reflexions-Meeting über Prozess und Verbesserungen |

---

## Zusammenfassung

Agile Methoden sind ein **Mindset, nicht nur Prozesse**. Scrum gibt Struktur mit Rollen, Events und Artefakten. Kanban fokussiert auf Workflow-Optimierung und kontinuierliche Lieferung. Beide können kombiniert werden (Scrumban) oder mit klassischem PM vermischt werden (Hybrid). Die Auswahl hängt ab von **Projektkontext, Kundenwünschen und Organisationskultur**. Im nächsten Modul (18) lernen Sie, diese Methoden noch besser zu tailoren und zu kombinieren.