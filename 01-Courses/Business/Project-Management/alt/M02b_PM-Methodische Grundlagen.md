## Lernziele des Moduls

Nach Abschluss dieses Moduls verstehen Sie:

✓ Die **drei Hauptansätze** des Projektmanagements (klassisch, agil, hybrid) und deren Vor-/Nachteile

✓ Internationale **PM-Standards und Frameworks** (PMBOK, PRINCE2, IPMA) und ihre Anwendungskontexte

✓ Die **Rollen und Verantwortlichkeiten** im Projektumfeld (PM, Sponsor, PO, Team, Stakeholder)

✓ Wie Sie **Methodenwahl nach Kontext treffen** und begründen

✓ Ihre eigenen **PM-Kompetenzen reflektieren** und weiterentwickeln

---

## 1. Klassisches (Wasserfall-) Projektmanagement

### 1.1 Definition und Charakteristika

Das **klassische Projektmanagement** folgt einem **sequenziellen, phasenorientierten Ansatz**. Die Grundidee: Anforderungen werden am Anfang vollständig definiert, dann arbeitet das Team phasenbezogen vor Implementierung Richtung Abschluss.

**Phasenlogik (Typisches Beispiel)**:

```
Anforderungen → Design → Implementierung → Test → Abschluss
     (fix)      (fix)        (fix)         (fix)   (final)
```

**Kernprinzipien**:
- **Vorhersagbarkeit**: Umfang ist früh definiert und wird geschützt
- **Dokumentation**: Umfassende Spezifikationen vor Coding
- **Sequenziell**: Eine Phase nach der anderen (begrenzte Parallelisierung)
- **Wasserfallprinzip**: Rücksprünge zu früheren Phasen sind teuer und unerwünscht

### 1.2 Typische Instrumente und Werkzeuge

| Instrument | Zweck | Beispiel |
|---|---|---|
| **Anforderungsspezifikation** | Vollständige Sammlung aller funktional & nicht-funktionalen Anforderungen | Business Requirement Document (BRD) |
| **Projektplan (Gantt-Diagramm)** | Lineare Zeitplanung aller Aktivitäten | MS Project Gantt-View |
| **Risikoregister** | Statische Erfassung bekannter Risiken zu Projektstart | Risikomatrix mit Mitigations-Plans |
| **Budget- und Kostenplan** | Top-Down oder Bottom-Up Kostenschätzung für gesamtes Projekt | Annual Cost Plan |
| **Statusbericht** | Regelmäßige (z. B. monatliche) Fortschrittsberichte | Forecast vs. Actual KPIs |

### 1.3 Stärken des klassischen Ansatzes

✅ **Geeignet für stabile, vorhersehbare Anforderungen**  
   → Infrastruktur, Bauprodukte, Manufaktur

✅ **Klare Struktur und Governance**  
   → Alle kennen die Phasen, Verantwortlichkeiten sind explizit

✅ **Budgetplanungssicherheit**  
   → Durch detaillierte frühe Kalkulationen bessere Vorhersagbarkeit

✅ **Regulatorische & vertragliche Compliance**  
   → Dokumentation leichter nachzuvollziehen (Audits, Verträge)

✅ **Große, verteilt arbeitende Teams**  
   → Zentrale Koordination über Plan möglich

### 1.4 Grenzen und typische Probleme

❌ **Späte Fehlererkennung**  
   → Fehler früher Phasen entdecken sich erst am Ende (Testphase) → sehr teuer

❌ **Geringe Flexibilität**  
   → Änderungen im Laufe des Projekts sind Scope Creep und Change-Request-würdig

❌ **"Analyse-Lähmung"**  
   → Lange Planungsphase verzögert Wertschöpfung; Kunden frustriert

❌ **Wenig Kundenfeedback**  
   → Kundeneinbindung primär am Anfang (Requirements) und Ende (Abnahme)

❌ **Technologie-Veralterung**  
   → In langen Projekten kann die Technologie veralten, bevor das Projekt endet

**Faustregel**: Klassisches PM funktioniert, wenn Anforderungen **fix und vorhersehbar** sind. Es scheitert bei **volatilen, unklar definierten Anforderungen**.

---

## 2. Agiles Projektmanagement

### 2.1 Die Agile Denkweise – Das Agile Manifest (2001)

Das **Agile Manifest** priorisiert folgende Werte:

> **Individuals and interactions** over processes and tools  
> **Working software** over comprehensive documentation  
> **Customer collaboration** over contract negotiation  
> **Responding to change** over following a plan

**Was bedeutet das konkret?**

1. **Menschen statt Prozesse**: Gute Kommunikation ist wichtiger als starre Prozessregeln
2. **Funktionierende Software statt Dokumentation**: Iterativ liefern, was funktioniert
3. **Kundenpartnerschaft statt Verträge**: Ständig zusammenarbeiten, nicht nach Vertragstext arbeiten
4. **Flexibilität statt starrer Planung**: Anforderungsänderungen sind willkommen, nicht Fehler

### 2.2 Scrum – Das populärste Agile Framework

**Scrum** ist ein Rahmenwerk für iterativ-inkrementelle Projektarbeit. Es strukturiert die Arbeit in **2–4 Wochen lange Iterationen** (Sprints).

**Rollen in Scrum**:

| Rolle                  | Verantwortung                                               |
| ---------------------- | ----------------------------------------------------------- |
| **Product Owner (PO)** | Vertritt die Kundenperspektive; priorisiert das Backlog     |
| **Scrum Master**       | Facilitator & Coach; entfernt Hindernisse; schützt das Team |
| **Dev Team**           | Selbstorganisierendes Entwicklungsteam; macht die Arbeit    |

**Artefakte (Produkte) in Scrum**:

| Artefakt            | Beschreibung                                                     |
| ------------------- | ---------------------------------------------------------------- |
| **Product Backlog** | Priorisierte Liste ALLER Anforderungen (User Stories)            |
| **Sprint Backlog**  | Items, die das Team in DIESEM Sprint umsetzen wird               |
| **Increment**       | Das Produktergebnis nach einem Sprint (funktionsfähige Software) |
|                     |                                                                  |

**Ereignisse (Events) in Scrum**:

| Ereignis | Takt | Dauer | Zweck |
|---|---|---|---|
| **Sprint Planning** | Start jedes Sprints | ~4 Std (für 2-Wo-Sprint) | Team wählt Items aus Product Backlog |
| **Daily Standup** | Täglich | 15 Min | Synchronisation: Wer macht was? Hindernisse? |
| **Sprint Review** | Ende jedes Sprints | ~2 Std | Increment präsentieren, Feedback sammeln |
| **Sprint Retrospektive** | Ende jedes Sprints | ~1,5 Std | Team reflektiert: Was lief gut? Was besser? |

**Scrum-Zyklus (visuell)**:

```
          ┌─────────────────────────────────────┐
          │   Product Backlog (priorisiert)     │
          └────────────┬────────────────────────┘
                       │
          ┌────────────▼────────────┐
          │  Sprint Planning        │
          │  (Team wählt aus)       │
          └────────────┬────────────┘
                       │
          ┌────────────▼────────────────────────────────┐
          │           Sprint (2–4 Wochen)               │
          │  ┌──────────────────────────────────────┐   │
          │  │ Daily Standup (tägl. 15 Min)         │   │
          │  └──────────────────────────────────────┘   │
          │  Team arbeitet an Sprint Backlog Items      │
          └────────────┬────────────────────────────────┘
                       │
          ┌────────────▼───────────-───┐
          │  Sprint Review (Demo)      │
          │  + Sprint Retrospektive    │
          └────────────┬───────────────┘
                       │
          ┌────────────▼───────────────────────┐
          │   Increment (fertiges Produkt)     │
          │   für nächsten Sprint verfügbar    │
          └────────────────────────────────────┘
```

### 2.3 Kanban – Alternative Agile Methode

**Kanban** ist flexibler und weniger strukturiert als Scrum. Es fokussiert auf **kontinuierlichen Durchsatz** statt fester Sprints.

**Kernprinzipien**:

1. **Visualisierung**: Machen Sie den Workflow sichtbar
   ```
   To Do  │  In Progress  │  Done
   ──────────────────────────────
   [ 5]   │     [ 2]      │  [17]
   ```

2. **Limitierung von WIP (Work-In-Progress)**: Max. X Items gleichzeitig bearbeiten
   → Verhindert, dass Team überfordert ist

3. **Durchsatzfokus**: Wie viele Items pro Woche / Monat werden fertig?
   → Velocity / Durchsatz messbar

4. **Kontinuierliche Verbesserung**: Regelmäßige Retrospektiven, ständiges Optimieren

**Kanban vs. Scrum**:

| Aspekt | Kanban | Scrum |
|---|---|---|
| **Struktur** | Kontinuierlich, flexible | Sprintbasiert, strukturiert |
| **WIP-Limit** | Ja, zentral | Implizit (durch Sprint Capacity) |
| **Geschwindigkeit** | Laufende Auslieferung | Sprint-Ende Auslieferung |
| **Rollen** | Optional, flexibel | Streng: PO, SM, Dev Team |
| **Meetings** | Wenige (optionale Retro) | Regelmäßig: Daily, Review, Retro |
| **Geeignet für** | Wartung, Support, laufende Arbeit | Neue Feature-Entwicklung |

### 2.4 Stärken des agilen Ansatzes

✅ **Schnelle Wertschöpfung**  
   → Erste, funktionierende Inkremente nach 2–4 Wochen

✅ **Hohe Kundenzufriedenheit**  
   → Regelmäßiges Feedback und Anpassung an echte Kundenwünsche

✅ **Motivierte Teams**  
   → Autonomie, schnelle Erfolgserlebnisse, sichtbarer Impact

✅ **Frühe Risikenerkennung**  
   → Probleme offenbaren sich schnell durch wiederholte Iterationen

✅ **Flexibilität gegenüber Anforderungsänderungen**  
   → Backlog-Priorisierung kann jederzeit neu justiert werden

✅ **Geringere Dokumentationslast**  
   → Fokus auf funktionierende Software, nicht auf Wälzer

### 2.5 Herausforderungen und Grenzen

❌ **Skalierbarkeit**  
   → Scrum mit 7 Personen → super. Mit 100 Personen → braucht Zusätze (SAFe, LeSS)

❌ **Vertragliche und regulatorische Anforderungen**  
   → Fixed-Price-Verträge schwierig; strenge Compliance-Anforderungen passen nicht gut

❌ **Unklare finale Kosten & Timeline**  
   → Nicht immer planbar (problematisch für Budget-Pflichtige)

❌ **Reife des Teams erforderlich**  
   → Self-Organization funktioniert nur mit erfahrenen, motivierten Entwicklern

❌ **Abhängigkeit vom Product Owner**  
   → Muss ständig verfügbar und klare Prioritäten setzen können

❌ **Große, heterogene Stakeholder-Basis**  
   → Schwer zu managen; wer gibt den Ton an?

**Faustregel**: Agil funktioniert, wenn Anforderungen **volatil und unklar** sind und **schnelle Wertschöpfung** wichtig. Es scheitert bei **Compliance-zentrierten, großen oder stark regulierten Projekten**.

---

## 3. Hybrid und Tailoring

### 3.1 Hybride Ansätze – Kombination der Besten aus beiden Welten?

Ein **hybrider Ansatz** kombiniert klassische Stabilität mit agiler Flexibilität. Es ist eine pragmatische Lösung, wenn:

- Anforderungen teilweise stabil, teilweise volatil sind
- Große Teams mit klassischer Governance vorhanden sind
- Regulierung etwas Dokumentation braucht, aber nicht lähmend wirken soll

**Hybrid-Spektrum**:

```
100% Klassisch ─────────────────────────────── 100% Agil
(Wasserfall)                                    (Scrum/Kanban)
                    ↑ Hybrid-Zone
            (viele mögliche Mix-Varianten)
```

**Hybrid-Beispiele in der Praxis**:

1. **Phase-Gate mit agiler Innenentwicklung**
   - Klassische Gates (Go/No-Go) zwischen Phasen
   - Aber jede Phase wird agil (mit Sprints) durchgeführt

2. **Klassischer Plan + Kanban Execution**
   - Top-Level-Plan klassisch (Meilensteine, Budget fixiert)
   - Operative Ausführung in Kanban-Boards

3. **Scaled Agile Framework (SAFe)**
   - Agile Teams arbeiten mit Scrum/Kanban
   - Portfolio-Ebene oben bleibt klassisch/strukturiert

### 3.2 Tailoring – Methodenwahl nach Kontext

**Tailoring** bedeutet: **Es gibt keine One-Size-Fits-All-Methode!**

Wähle den Ansatz (klassisch, agil, hybrid) und die Tools, die für DEIN Projekt und Deine Organisation passen.

**Kontextfaktoren, die die Methodenwahl beeinflussen**:

| Faktor                         | Frage                                                       | Klassisch eher | Agil eher              |
| ------------------------------ | ----------------------------------------------------------- | -------------- | ---------------------- |
| **Anforderungsstabilität**     | Sind die Anforderungen am Anfang klar? Ändern sie sich oft? | Ja, stabil     | Nein, volatil          |
| **Projektgröße & Team**        | Wie viele Personen?                                         | >50 Personen   | 5–10 Personen          |
| **Geografische Verteilung**    | Arbeitet das Team am selben Ort?                            | Nein, verteilt | Ja, co-located         |
| **Stakeholder-Komplexität**    | Wie viele Stakeholder mit unterschiedlichen Wünschen?       | Viele          | Wenige, klar           |
| **Regulierung**                | Muss ich viel dokumentieren & nachweisen?                   | Ja, strict     | Nein, flexibel         |
| **Technologische Komplexität** | Ist die Technologie neu / Learning Curve?                   | Nein, bewährt  | Ja, neu, experimentell |
| **Budget- & Zeitsicherheit**   | Muss Budget und Deadline fix sein?                          | Ja, fix        | Nein, variabel         |
| **Organisationskultur**        | Hat die Org Agile Erfahrung?                                | Nein           | Ja                     |

**Entscheidungshilfe – Einfache Logik**:

```
IF Anforderungen stabil + Budget fixiert + Risiken bekannt + großes Team
    THEN klassisch (oder Phase-Gate)

ELSE IF Anforderungen volatil + schnelle Wertschöpfung wichtig + kleine Teams + co-located
    THEN agil (Scrum / Kanban)

ELSE
    THEN hybrid (tailored Mix)
```

**Übung: Checkliste – Bin ich klassisch oder agil?**

Füllen Sie für Ihr Projekt aus:

- Anforderungsstabilität: Klassisch (1) ← → (5) Agil
- Team-Größe: Klassisch (1) ← → (5) Agil
- Co-location: Klassisch (1) ← → (5) Agil
- Stakeholder-Einfachheit: Klassisch (1) ← → (5) Agil
- Regulierung: Klassisch (1) ← → (5) Agil
- Tech-Neuheit: Klassisch (1) ← → (5) Agil
- Budget-Flexibilität: Klassisch (1) ← → (5) Agil
- Org-Agile-Reife: Klassisch (1) ← → (5) Agil

**Auswertung**: Gesamtscore < 20 = klassisch, 20–36 = hybrid, > 36 = agil

---

## 4. PM-Standards und Rollen

### 4.1 Internationale PM-Standards im Überblick

Es gibt mehrere etablierte **Standards und Frameworks** für Projektmanagement. Jeder hat Stärken für bestimmte Kontexte:

| Standard                 | Ursprung      | Fokus                                        | Zielgruppe                               | Besonderheit                              |
| ------------------------ | ------------- | -------------------------------------------- | ---------------------------------------- | ----------------------------------------- |
| **PMBOK®**               | USA (PMI)     | 10 Knowledge Areas, prozessorientiert        | große Organisationen, IT, klassisches PM | "Bibel" in USA, global weit verbreitet    |
| **PRINCE2®**             | UK            | 7 Prozesse + Governance, Rollen-fokussiert   | Government, UK/EU, IT-Projekte           | Sehr strukturiert, gute Change-Governance |
| **IPMA ICB**             | International | 4 Kompetenzbereiche, PM-Kompetenz-fokussiert | Europa, globale Organisationen           | Ganzheitliche Kompetenzbetrachtung        |
| **Agile Practice Guide** | USA (PMI)     | Agile & Hybrid-Guidance                      | Teams, agile Transformation              | Neueres PMI-Angebot für Agile             |
| **Scrum Guide**          | International | Scrum-Framework konkret                      | Agile Teams                              | De-facto Standard für Agile               |

**Welchen Standard soll ich wählen?**

- **USA / global / große Org**: PMBOK → PMI-Zertifikation (PMP)
- **UK / Europa / Government**: PRINCE2 → PRINCE2-Zertifikation
- **Europa / Kompetenzfokus**: IPMA → IPMA Level-Zertifikation
- **Agile Teams**: Scrum Guide → Certified Scrum Master (CSM)

### 4.2 PMBOK® – Die 10 Knowledge Areas (Überblick)

Der **PMBOK® (Project Management Body of Knowledge)** organisiert alle PM-Themen in **10 Knowledge Areas**. Dieses Modul-Programm (Module 1–19) deckt alle 10 ab:

| Knowledge Area | Fokus | Zugeordnete Module |
|---|---|---|
| **1. Integration Mgmt** | Koordination aller PM-Prozesse, Gesamtplan | Alle Module |
| **2. Scope Mgmt** | Definition & Kontrolle des Umfangs (Was ist IN/OUT?) | Modul 3, 5 |
| **3. Schedule Mgmt** | Zeitplanung & -kontrolle (Wann?) | Modul 6, 7 |
| **4. Cost Mgmt** | Kostenplanung & Controlling (Wie viel?) | Modul 9 |
| **5. Quality Mgmt** | Standards, Tests, Verbesserung (Wie gut?) | Modul 12 |
| **6. Resource Mgmt** | Team, Kapazität, Skills (Wer? Mit welcher Kraft?) | Modul 8, 14 |
| **7. Communications Mgmt** | Information & Reporting (Wer erfährt was wann?) | Modul 13 |
| **8. Risk Mgmt** | Erkennung & Reaktion auf Risiken | Modul 10, 11 |
| **9. Procurement Mgmt** | Beschaffung & Verträge (Make or Buy?) | (Modul 19) |
| **10. Stakeholder Mgmt** | Analyse, Engagement, Konflikt | Modul 3, 13–14 |

### 4.3 Rollen und Verantwortlichkeiten im Projektumfeld

**Die vier Hauptrollen** in einem typischen Projekt:

#### **1. Der Sponsor (Executive Sponsor)**

**Wer?** Meist C-Level, Geschäftsführer oder Vorstand

**Verantwortung**:
- Budget freigeben & genehmigen
- Erfolgskriterien definieren
- Strategische Alignierung sicherstellen
- Bei Eskalation letzte Entscheidungsinstanz

**Fragen die der Sponsor stellt**:
- "Lohnt sich dieses Projekt wirtschaftlich?"
- "Passt es zu unserer Strategie?"
- "Bekommen wir den erwarteten Nutzen?"

---

#### **2. Der Projektmanager (PM)**

**Wer?** PM (1–5 Jahre Erfahrung) oder Senior PM (5+ Jahre)

**Verantwortung**:
- Operative Planung & Durchführung aller PM-Prozesse
- Tägliche Koordination des Teams
- Risiko- und Change-Management
- Reporting an Sponsor & Stakeholder
- Hindernisentfernung

**Fragen die der PM stellt**:
- "Sind wir im Plan (Zeit, Budget, Qualität)?"
- "Welche Risiken drohen?"
- "Wer macht was bis wann?"

---

#### **3. Product Owner (agil) / Business Analyst (klassisch)**

**Wer?** Fachexperte aus dem Business, ggf. Kundenseite

**Verantwortung**:
- Anforderungen sammeln & priorisieren
- Akzeptanzkriterien definieren (Was ist "fertig"?)
- Feedback geben auf Inkrement / Lieferscheine
- Kundenperspektive vertreten

**Fragen die der PO stellt**:
- "Erfüllt das Ergebnis unsere Anforderungen?"
- "Welche Features sind WIRKLICH wichtig?"

---

#### **4. Das Team (Entwicklung / Umsetzung)**

**Wer?** Entwickler, Tester, Designer, Handwerker – je nach Projekttyp

**Verantwortung**:
- Umsetzen der Anforderungen
- Technische Entscheidungen treffen
- Schätzung von Aufwand & Risiken
- Selbstorganisation & kontinuierliche Verbesserung (in Agil)

**Fragen die das Team stellt**:
- "Wie machen wir das technisch?"
- "Wie lange brauchen wir dafür?"
- "Welche Risiken sehen wir?"

---

**Vereinfachte Verantwortlichkeitsmatrix (RACI)**:

| Aktivität                    | Sponsor         | PM            | PO/Analyst | Team  |
| ---------------------------- | --------------- | ------------- | ---------- | ----- |
| **Strategiealignement**      | **A**ccountable | R             | -          | -     |
| **Anforderungen definieren** | -               | **C**onsulted | **R**      | -     |
| **Plan erstellen**           | -               | **A**         | **C**      | **R** |
| **Risiken bewerten**         | **C**           | **A**         | **C**      | **R** |
| **Umsetzung durchführen**    | -               | **C**         | **C**      | **A** |
| **Qualität abnehmen**        | **C**           | **C**         | **A**      | **R** |

*A = Accountable (trägt Verantwortung), R = Responsible (macht es), C = Consulted (wird befragt), - = nicht beteiligt*

### 4.4 Kompetenzbereiche eines guten Projektmanagers

Ein erfolgreicher PM braucht drei Kompetenz-Säulen:

#### **Säule 1: Technische Kompetenzen** (40%)

- **Methoden & Standards**: PMBOK, Scrum, Hybrid verstehen
- **Werkzeugkompetenz**: MS Project, Jira, Trello, etc.
- **Domänenwissen**: Branchen- und Projekttyp-spezifisches Wissen
- **PM-Prozesse**: Alle 10 Knowledge Areas anwenden können

**Frage**: "Kenne ich die Methoden und Tools?"

---

#### **Säule 2: Verhaltens-Kompetenzen** (40%)

- **Kommunikation**: Klar, verständlich, zuhören
- **Konfliktlösung**: Mediation, Verhandlung, faire Entscheidungen
- **Führung & Motivation**: Teams inspirieren & motivieren
- **Stressresistenz**: Unter Druck ruhig bleiben, zielorientiert
- **Kreativität & Problemlösung**: Neue Lösungen finden unter Druck

**Frage**: "Kann ich mit Menschen arbeiten und Konflikte lösen?"

---

#### **Säule 3: Kontext-Kompetenz** (20%)

- **Geschäftsverständnis**: Was ist das Business-Modell? Wie verdient die Org Geld?
- **Organisationskultur**: Wie funktioniert diese Org? Wer hat Macht?
- **Regulierung & Compliance**: Was sind die gesetzlichen Anforderungen?
- **Stakeholder-Landschaft**: Wer sind Interessensgruppen? Wer könnte blockieren?

**Frage**: "Verstehe ich den Kontext und die politische Situation?"

**Selbstbewertung – Ihre Kompetenzen**:

| Kompetenz | Mein Level (1–5) |
|---|---|
| Technisches PM-Wissen (Methoden) | _ |
| Werkzeugkompetenz (Tools) | _ |
| Kommunikationsfähigkeit | _ |
| Konfliktlösung | _ |
| Geschäftsverständnis | _ |
| Organisationsverständnis | _ |
| **Durchschnitt** | **_** |

*1 = Anfänger, 3 = Praktizierend, 5 = Expert*

---

## 5. Aufgaben und Übungen

### **Übung 1: Methodenwahl für Projektszenarien**

**Szenario A: SAP-Rollout in großem Konzern**
- Anforderungen: Hart definiert, Customizing-fest
- Team: 80 Personen, verteilt global
- Budget: Fixiert (€5 Mio), Verzögerungen kostspielig
- Dauer: 18 Monate

**Aufgabe**: Würde ich klassisch oder agil vorgehen? Begründen Sie.

**Ihre Antwort**:
```
[Platz für Ihre Antwort]
```

---

**Szenario B: Startup-App Entwicklung**
- Anforderungen: Unklar, MVP muss schnell am Markt sein
- Team: 5 Entwickler, ein Büro
- Budget: Variabel (Investoren stellen zur Verfügung), schneller Markteintritt wichtig
- Dauer: 8 Wochen bis MVP

**Aufgabe**: Würde ich klassisch oder agil vorgehen? Begründen Sie.

**Ihre Antwort**:
```
[Platz für Ihre Antwort]
```

---

### **Übung 2: Rollen-Klärungs-Workshop**

Stellen Sie sich ein Projekt vor (z. B. Website-Relaunch).

**Aufgabe**: Füllen Sie folgende Matrix aus – wer macht was?

| Aktivität | Sponsor | PM | PO | Team |
|---|---|---|---|---|
| Strategie definieren | | | | |
| Anforderungen sammeln | | | | |
| Zeitplan erstellen | | | | |
| Technisches Design | | | | |
| Code schreiben | | | | |
| Quality Assurance | | | | |
| Abnahme & Go-Live | | | | |

*Nutzen Sie: A = Accountable, R = Responsible, C = Consulted, I = Informed*

---

### **Übung 3: Tailoring-Checkliste für Ihr Projekt**

**Projekt-Name**: _________________

Füllen Sie die folgende Checkliste für Ihr aktuelles oder ein Ihrer bekanntes Projekt aus:

| Faktor | Klassisch (1) | Agil (5) | Ihr Score (1–5) |
|---|---|---|---|
| Anforderungsstabilität (stabil = 1, volatil = 5) | 1 | 5 | __ |
| Team-Größe (>50 = 1, 5–10 = 5) | 1 | 5 | __ |
| Co-location (verteilt = 1, co-located = 5) | 1 | 5 | __ |
| Stakeholder-Einfachheit (viele = 1, wenige klar = 5) | 1 | 5 | __ |
| Regulierung (strict = 1, flexibel = 5) | 1 | 5 | __ |
| Tech-Neuheit (bewährt = 1, neu/experimentell = 5) | 1 | 5 | __ |
| Budget-Flexibilität (fix = 1, variabel = 5) | 1 | 5 | __ |
| Org-Agile-Reife (keine = 1, fortgeschritten = 5) | 1 | 5 | __ |
| **Gesamt-Score** | **8** | **40** | **__** |

**Interpretation**:
- Score 8–16 → **Klassisches PM** empfohlen
- Score 17–31 → **Hybrid** empfohlen
- Score 32–40 → **Agiles PM** empfohlen

**Mein Projekt braucht daher**: _________________

**Begründung**: _________________

---

## 6. Zusammenfassung und Checklisten

### **Klassisch vs. Agil – Kurz-Vergleich**

| Aspekt | Klassisch | Agil |
|---|---|---|
| **Anforderungsklarheit** | Am Anfang klar | Entsteht iterativ |
| **Timeline** | Vorhersagbar, Plan-getrieben | Iterativ, adaptive |
| **Kunde/PO** | Am Anfang & Ende beteiligt | Täglich / Sprint-weise beteiligt |
| **Dokumentation** | Umfangreich, detailliert | Minimal, fokussiert |
| **Fehlerkosten** | Spät = sehr teuer | Früh = gering |
| **Team-Struktur** | Hierarchisch, spezialisiert | Flach, cross-funktional |
| **Geeignet für** | Stabile, größere Projekte | Volatile, innovative Projekte |

---

### **Fünf kritische Erfolgsfaktoren**

✓ **Richtige Methodenwahl**: Nicht dogmatisch – kontext-adaptiv

✓ **Klar definierte Rollen**: Jeder weiß, wer was macht

✓ **Sponsor-Engagement**: Buy-in von oben ist essentiell

✓ **Kontinuierliche Kommunikation**: Keine Überraschungen am Ende

✓ **Offenheit für Anpassung**: Flexibilität zwischen Plan und Pragmatismus

---

### **Checkliste: Bin ich PM-reif?**

Am Ende des Moduls können Sie diese Fragen mit JA beantworten?

- ☐ Ich kann die Unterschiede zwischen klassisch, agil und hybrid erklären
- ☐ Ich kann für ein gegebenes Projekt die geeignete Methode wählen
- ☐ Ich kenne die 10 Knowledge Areas des PMBOK
- ☐ Ich kann die Rollen (Sponsor, PM, PO, Team) unterscheiden
- ☐ Ich reflektiere meine eigenen PM-Kompetenzen kritisch
- ☐ Ich weiß, wo meine Entwicklungschancen liegen

**Falls Sie 4–6 Ja anhaken**: Sie haben Module 2 verstanden! ✓

---

## Notizen & Platz für Eigene Gedanken

```
[Freier Platz für Ihre Notizen während des Moduls]


```

---

## Weiterführende Ressourcen

- **Bücher**: "The Phoenix Project" (Klasisch vs. Agil), "Scrum: The Art of Doing Twice the Work in Half the Time"
- **Standards**: PMBOK Guide (PMI), Scrum Guide (Scrum.org), PRINCE2 Manual
- **Online**: PMI.org, Scrum.org, Project Management Institute, IPMA
- **Zertifikationen**: PMP (PMI), PRINCE2, CSM (Certified Scrum Master)