## Aufgabenblock A: Kontextanalyse und Tailoring-Entscheidungen

### Lösung A1: Kontext-Analyse durchführen

#### Schritt 1: Kontext-Merkmale bewerten

**Beispiel-Lösung für das Payment-Migration-Projekt:**

| Faktor | Bewertung | Begründung |
|--------|-----------|-----------|
| Anforderungsklarheit | **3 / 10** | 70% regulatorische Anforderungen sind stabil, 30% Customizing sind explorativ. Deutlich klassisch geprägt. |
| Organisationskultur | **4 / 10** | Unternehmenskultur ist klassisch hierarchisch, nur IT experimentiert. Insgesamt klassisch-orientiert. |
| Teamgröße | **4 / 10** | 15 Personen sind mittelgroß. Klassische Ansätze empfohlen, aber noch klein genug für etwas Agilität. |
| Regulatorische Anforderungen | **2 / 10** | Finanzbranche = hohes Regulatorium. Nicht verhandelbar. Stark klassisch. |
| Komplexität | **6 / 10** | Moderate Komplexität: Bekannte Plattform-Migration + neue Cloud-Anforderungen. Technisch komplex, aber nicht exploratativ. |
| Time-to-Market-Druck | **2 / 10** | 12 Monate sind ausreichend Zeit. Kein großer Time-to-Market-Druck. Klassisch orientiert. |

**Durchschnittswert:** (3+4+4+2+6+2) / 6 = **3,5 / 10** → **Überwiegend klassischer Ansatz mit agilen Elementen**

> **Kommentar:** Die Bewertung ist bewusst konservativ, da Regulatorium und externe Abhängigkeiten nicht verhandelbar sind. Es ist besser, mit einem klassischen Rückgrat zu starten und agile Sprints zu integrieren, als umgekehrt.

---

#### Schritt 2: Tailoring-Empfehlung

**Empfehlung für das Payment-Projekt:**

| Aspekt | Prozentsatz |
|--------|-----------|
| **Klassische Elemente** | 65% |
| **Agile Elemente** | 35% |

**Begründung:**
- **Klassisch 65%**: Regulatorium, Compliance-Gates, externe Abhängigkeiten erfordern klare Phasenstruktur und formale Genehmigungsprozesse
- **Agil 35%**: Cloud-Migration und Customizing können iterativ erkundet werden. Team-Autonomie in Sprints fördert Produktivität und Qualität

**Hybrid-Mix:**
```
Anforderungsphase (klassisch) → Cloud-Design (klassisch) → 
Implementierung (hybrid: 2-3 Sprints, dann Gate) → 
Test (klassisch mit agilen Testzyklen) → 
GoLive (klassisch)
```

> **Kommentar:** Ein 65/35-Split ist typisch für stark regulierte Branchen mit technischen Modernisierungsvorhaben. Zu agil würde Compliance-Anforderungen ignorieren. Zu klassisch würde Modernisierungspotenzial verschenken.

---

#### Schritt 3: Methoden-Mix nach Phase

**Empfehlung für Payment-Projekt:**

| Phase | Klassische Methode | Agile Methode | Begründung |
|-------|------------------|---------------|-----------|
| **Anforderungen** | Anforderungsanalyse + Compliance-Review (3 Monate) | Stakeholder-Workshops iterativ | Regulatorische Anforderungen sind stabil; Business-Customizing kann iterativ erforscht werden |
| **Design** | Architektur-Review + Security-Gate | Cloud-Design-Sprints (2-3 Wochen) mit Prototyping | Architektur-Entscheidungen sind kritisch und müssen formell genehmigt werden. Implementation kann agil erfolgen. |
| **Entwicklung** | Konfiguration Meilensteine nach Modul | 2-wöchentliche Sprints mit Daily Standups | Standard-Cloud-Features sind klar. Customizing in Sprints; Firmware-Komponenten ebenfalls sprintbasiert. |
| **Test** | Testplan + UAT-Gates + Compliance-Checklist | Kontinuierliche Integration + Automated Tests | Manuelle UAT ist erforderlich für Compliance. Automationen beschleunigen Zyklus. |
| **GoLive** | Formal genehmigt + Cutover-Plan + Rollback-Plan | Go-Live Rehearsal in Sprints vor Produktion | Klassisches Sicherheitsdenken; agile Vorbereitung minimiert Risiken. |

> **Kommentar:** Häufiger Fehler: Teams machen die gesamte Entwicklung agil und vergessen Design-Gates. Das führt zu nicht-erwartungskonformen Architekturen. **Besser:** Design klassisch mit Genehmigung, dann agile Umsetzung.

---

### Lösung A2: Tailoring-Matrix anwenden

**Szenarien auf der Tailoring-Matrix positioniert:**

```
                        Anforderungsklarheit hoch →
                        ↑
         Klassisch       │      Hybrid (verschiedene Ausprägungen)      │    Agil
         bevorzugt       │                                               │ bevorzugt
                         │                                               │
                         │  [S3: ERP]                                    │
                         │  Stage-Gate +        [S1: Infrastructure] │    [S2: Startup]
                         │  Agile Sprints       Kanban + Gates       │ Agile Exploration
                         │                                               │
                         │                      │                       │
                         │                      │                       │
                    Klassische               Hybrid                   Agile
                    Governance             Governance               Governance
                         │                      │                       │
                         ↓                      ↓                       ↓
      Organisationskultur klassisch   |   gemischt   |   agil

Szenario 1: (3/10, 4/10) → Empfehlter Ansatz: **Stage-Gate + Agile Sprints für Customizing**
Szenario 2: (9/10, 8/10) → Empfehlter Ansatz: **Pure Agile (Kanban/Scrum) mit Light Governance**
Szenario 3: (5/10, 5/10) → Empfehlter Ansatz: **Hybrid: Stage-Gate mit Pilot-Ansatz + Scrum für Customizing**
```

**Detaillierte Begründungen:**

**Szenario 1 (Infrastructure Migration):**
- Anforderungsklarheit: 3/10 (Regulatorium stabil, Customizing offen)
- Organisationskultur: 4/10 (Klassisch, aber IT experimentiert)
- → **Empfehlung: Stage-Gate + Agile Sprints**
  - Design-Gate sichert Architektur
  - Agile Sprints für Cloud-Customizing (3–4 Sprints à 2 Wochen)
  - GoLive-Gate vor Produktion
  - Governance: Monatliches Steering + wöchentliche Sprint-Syncs

**Szenario 2 (Startup – Neues Produkt):**
- Anforderungsklarheit: 9/10 (Unklar, Markt-getrieben)
- Organisationskultur: 8/10 (Agil, flach, experimentierfreudig)
- → **Empfehlung: Pure Agile (Kanban/Scrum)**
  - Sprint-basiert, 1–2 Wochen
  - Product Owner treibt Backlog
  - Continuous Deployment möglich
  - Leichte Governance (eher selbstorganisierend)

**Szenario 3 (ERP-Implementierung):**
- Anforderungsklarheit: 5/10 (Prozesse bekannt 80%, Customizing 20%)
- Organisationskultur: 5/10 (Etabliertes Unternehmen, öffnet sich für Agile)
- → **Empfehlung: Hybrid – Stage-Gate mit Pilot-Ansatz**
  - Anforderungsphase (2 Monate) klassisch
  - 3–4 Pilot-Sprints mit Early-Adopter-Gruppe (3 Monate)
  - Roll-Out-Planung nach Pilot-Learnings (1 Monat)
  - Rollout-Phasen klassisch, aber mit Agile-Lessons
  - Governance: Steering Quarterly + Sprint-Reviews mit Geschäft

> **Kommentar:** Die Tailoring-Matrix ist ein **Heuristik-Werkzeug**, keine exakte Wissenschaft. Lokale Faktoren (z.B. „Wer ist der Sponsor?" oder „Gibt es ein Top-Risiko?") können die Positionierung verschieben. Nutzen Sie die Matrix als Ausgangspunkt für Diskussionen.

---

## Aufgabenblock B: Governance-Design

### Lösung B1: Governance-Struktur gestalten

#### Schritt 1: Rollen definieren

**Lösung für Payment-Migration (Hybrid-Projekt):**

| Rolle | Klassisches Projekt | Hybrid-Projekt | Beschreibung der Aufgabe |
|-------|------------------|-----------------|--------------------------|
| **Sponsor** | Strateg, Entscheidungsträger | Strateg + Feedback-Provider | Genehmigt Gates, gibt Business-Priorisierung vor, eskaliert Risiken |
| **Projektmanager** | Plan-Verantwortlicher, Kontrolle | Governance-Orchestrator, Schnittstellenmanager | Steuert klassische Phasen, koordiniert mit Scrum Master, moderiert Change Control |
| **Product Owner** | Nicht typisch (oder minimal) | Backlog-Owner, Priorisierungsbefugnis | Verwaltet Sprint-Backlog, gibt Stories frei, akzeptiert Increments |
| **Scrum Master** | Nicht typisch | Process Facilitator, Impediment Resolver | Schützt Sprint-Rhythmus, moderiert Standups, coacht Team |
| **Steering Committee** | Entscheidungsgremium | Entscheidungsgremium (angepasste Frequenz) | Genehmigt Phase-Übergänge, bewilligt Budgets/Ressourcen, eskaliert strategische Risiken |
| **Change Control Board** | Änderungen bewilligen | Bewilligt große Changes, triviale Changes über Backlog | Prüft Impact von Anforderungsänderungen, kalibriert Plan- und Ressourcenauswirkungen |

> **Kommentar zum Rollen-Design:** In Hybrid-Projekten ist es wichtig, dass **Projektmanager und Scrum Master nicht konkurrieren, sondern komplementär arbeiten**. Der PM kümmert sich um Governance, externe Schnittstellen und Stakeholder-Kommunikation. Der SM kümmert sich um die interne Teamarbeit, Prozess und Impediments.

---

#### Schritt 2: Governance-Events planen

**Empfohlene Struktur für Payment-Projekt (12 Monate, Hybrid):**

| Meeting | Frequenz | Teilnehmer | Ziele | Dauer |
|---------|----------|-----------|-------|--------|
| **Steering Committee** | Monatlich | Sponsor, Geschäftsführung, PM, PO, Risiko-Owner | Phase-Freigabe, Budget-Kontrolle, Risiken escalieren, Priorisierung | 90 Min |
| **Sprint Planning** | 2-wöchentlich (vor Sprint) | Team, PO, SM, Arch-Lead | Backlog-Refinement, Sprint-Ziele, Kapazitäts-Planung | 2–4 Std (abhängig Teamgröße) |
| **Sprint Review** | 2-wöchentlich (Ende Sprint) | Team, PO, Geschäft-Reps, Steering (optional) | Demo von Increments, Feedback sammeln, nächste Prioritäten | 60–90 Min |
| **Daily Standup** | Täglich | Team, SM, Tech-Lead | Impediments identifizieren, Koordination, Blocker-Auflösung | 15 Min |
| **Product Backlog Refinement** | Wöchentlich | Team, PO, Tech-Lead | User Stories klären, Acceptance Criteria definieren | 60 Min |
| **Change Control Board** | Ad hoc (bei Bedarf) | PM, PO, Tech-Lead, Sponsor | Change-Request bewerten, Impact-Analyse, Entscheidung genehmigt/abgelehnt | 60 Min (je Change) |
| **Phase-Review (Gate)** | Vier Gates: Nach Design, nach Impl., nach Test, vor GoLive | Steering, Arch-Board, Compliance | Audit of Compliance-Checklist, Architektur-Freigabe, Test-Readiness, GoLive-Approvel | 120 Min |

> **Kommentar – Häufiger Fehler:** Zu viele Meetings! Teams berichten von 8–10 regelmäßigen Meetings pro Woche. **Lösungsansätze:**
> - Steering + Sprint Review kombinieren (z.B. „Steering-Sprint-Review" alle 4 Wochen)
> - Change Control nicht als separates Meeting, sondern als Workflow in YouTrack
> - Backlog Refinement mit Sprint Planning verbinden (extended Planning)

---

#### Schritt 3: Entscheidungsmatrix (RACI)

**RACI-Matrix für Payment-Projekt:**

| Entscheidung | Verantwortlich (R) | Rechenschaft (A) | Konsultiert (C) | Informiert (I) |
|-------------|----------------|--------------|-----------  |-----------|
| **Phase-Freigabe** (z.B. nach Design-Gate) | Steering Committee | Sponsor | PM, Arch-Board, Compliance | Team, PO |
| **Sprint-Planung** | Scrum Master | Product Owner | Team, Tech-Lead | PM, Steering |
| **Change Request (regulatorisch/Scope)** | Change Control Board | PM + Sponsor | PO, Arch, Compliance | Team, Steering |
| **Change Request (klein, technisch)** | Product Owner | Product Owner | Team, Tech-Lead | PM |
| **Risiko-Eskalation** | Project Manager | Sponsor | Steering, Risk Owner | Team |
| **Sprint-Ziele anpassen** | Product Owner | Scrum Master | Team | PM, Steering |
| **Architektur-Entscheidung** | Architektur-Board | Arch-Lead | Team, PM, Compliance | Steering |
| **Mitglied-Ressourcen freigeben** | Sponsor (Line Manager) | Sponsor | PM | Team |

**Legende:**
- **R (Verantwortlich)**: Führt die Aufgabe durch
- **A (Rechenschaft/Accountable)**: Trägt die Gesamtverantwortung, kann der R sein oder nicht
- **C (Konsultiert)**: Beratung vor Entscheidung
- **I (Informiert)**: Benachrichtigung nach Entscheidung

> **Kommentar – Häufiger Fehler:** RACI-Matrix ist zu klassisch und wird oft nicht eingehalten in Hybrid-Projekten. **Besser:** Ergänzen Sie RACI um agile Rollen (PO, SM) und nutzen Sie es nicht als starres Dokument, sondern als Orientierungsrahmen. Überprüfen Sie die RACI in Retrospektiven.

---

### Lösung B2: Governance-Konflikt lösen

#### Ursachenanalyse

**Was Geschäftsseite braucht:**
- Monatliche **Übersicht über Fortschritt gegen Plan**
- **Finanzielle und zeitliche Kontrolle**: Sind wir im Budget? Im Plan?
- **Eskalations-Früherkennung**: Wann müssen wir reagieren?
- **Stakeholder-Reporting**: Geschäftsführung, Auditoren wollen Sicherheit sehen

**Was Tech-Team braucht:**
- **Kontinuierliche Produktivität**: Ständige Unterbrechungen durch Meetings sind Gift für Sprints
- **Klare Sprint-Grenzen**: Nach Sprint-End die Ergebnisse zeigen, nicht mittendrin über Plan-Status berichten
- **Feedback-Schleifen**: Schnelle Anpassungen in nächsten Sprints statt Approval-Zyklen
- **Autonomie**: Selbstorganisiertes Team arbeitet produktiver als ständig überprüftes

#### Hybrid-Lösung designen

**Empfohlene Lösung: „Steering-Sprint-Review" (Hybrid-Governance-Event)**

**Format:**
- **Frequenz:** Alle 4 Wochen (nach jedem 2. Sprint)
- **Dauer:** 90 Minuten
- **Teilnehmer:** Sponsor, PM, PO, Tech-Lead + beliebige Geschäfts-Stakeholder
- **Struktur:**
  1. **Sprint-Ergebnisse präsentieren** (20 Min): Was wurde gemacht? Welche Qualität?
  2. **Plan-Status analysieren** (20 Min): Sind wir im Budget/Zeitplan? Burndown-Chart & Gantt im Vergleich
  3. **Hindernisse und Risiken** (20 Min): Was blockiert Progress? Eskalations-Bedarf?
  4. **Priorisierung für nächste Sprints** (20 Min): PO trifft Entscheidungen mit Sponsorship
  5. **Aktionen & Abschluss** (10 Min): Clear Action Items

**Zusätzliche Maßnahmen:**
- **Automatisierte YouTrack-Reports:** Monatliche Snapshot-Reports für Steering (Burndown, Phase-Status, Change-Log)
- **Daily Standup (gekürzt):** Nur 10 Minuten, PM nimmt optional teil (nicht zwingend)
- **Weekly Sync (kleiner Kreis):** PM + PO + Tech-Lead (20 Min) zu deren Koordination

> **Kommentar:** Dieses Modell **reduziert Overhead deutlich** (monatlich 2 x 90 Min statt 4 x 60 Min Steering) und **liefert bessere Informationen** (echte Sprintergebnisse statt Statusberichte).

---

#### YouTrack-Integration

| Element | YouTrack-Umsetzung |
|---------|-------------------|
| **Steering-Berichte** | Custom Report: Burndown (agil) + Gantt by Phase (klassisch) auf einer Seite; Template für monatliche Reports |
| **Sprint-Tracking** | Agile Board mit Sprint-Selector; Burndown autom. generiert |
| **Automatische Reports** | Scheduled Emails alle 4 Wochen: Sprintergebnisse (Issues closed in last 14 days), Plan-Status, Top 5 Blockers |
| **Change-Log** | Custom Report: Alle Changes (Typ, Impact, Status) mit Entscheidungs-Trail |
| **Compliance-Checklist** | Custom Issue-Type oder separate Dokument mit Traceability-Links zu betroffenen Issues |

---

## Aufgabenblock C: Praktische Hybrid-Muster

### Lösung C1: Hybrid-Muster vergleichen

**Vergleichstabelle – gefüllt:**

| Kriterium | Stage-Gate + Agile Sprints | Kanban + Gates | Inkrementelle Delivery | Agile Exploration + klassisches Rollout |
|-----------|----------------------------|----------------|----------------------|----------------------------------------|
| **Best für:** | Regulierte Branchen, große Syst., klare Gates nötig | Kontinuierliche Releases, kontinuierliche Integration | Große verteilte Teams, mehrere Module parallel | Innovation/Produktentwicklung vor standardisiertem Rollout |
| **Anforderungen** | 60–80% stabil, 20–40% explorativ | 40–60% stabil, 40–60% evolving | Modulare, teil-unabhängige Anforderungen | <20% Anforderungen bekannt initial, evolving |
| **Planung** | Wasserfallphasen + Sprint-Planung nested | Kontinuierliche Backlog-Planung, Meilensteine als Releases | Work-Breakdown je Team/Modul; synchronisierte Sprint-Gates | Initial rapid prototyping; dann klassische Roll-Out-Planung |
| **Kontrolle** | Phase-Gates + Sprint-Burndown parallel | WIP-Limits, Durchsatz (Throughput), Lead-Time | Inkrementelle Integration-Gates + Cross-Team Sync | Agile Velocity (MVP), dann klassisches Budget/Plan-Tracking |
| **Team-Struktur** | Ein großes Team oder mehrere Teams mit PM + Scrum Master | Eher kontinuierlich arbeitend, nicht unbedingt Sprints | Mehrere Teams parallel mit gemeinsamer Architektur | Agiles MVP-Team; dann klassische Roll-Out-Teams |
| **Risiko** | Geringer (Gates geben Kontrollpunkte); aber potentiell Overhead | Höher (kontinuierliche Auslieferung = kontinuierliches Risiko); aber frühe Fehlererkennung | Komplex (Koordination mehrerer Teams), aber inkrementelle Risiko-Reduktion | Höher initial (MVP-Risiko), niedriger bei Rollout (validated Product) |
| **Beispiel-Projekt** | Bankensystem-Migration, ERP-Implementierung | SaaS-Produktentwicklung mit regelmäßigen Feature-Releases | Große Infrastruktur (Datenbank + Apps + APIs parallel) | Marktvalidierung eines Produkts, dann Enterprise-Implementierung |

> **Kommentar:** 
> - **Stage-Gate + Sprints:** Beste Option für High-Compliance-Umgebungen; aber Komplexität ist hoch (zwei Prozessmodelle parallel)
> - **Kanban + Gates:** Leaner, aber erfordert reife Organisation mit guter Story-Definition
> - **Inkrementelle Delivery:** Skaliert gut, aber Koordination ist Herausforderung
> - **Agile → Klassisch:** Ideal für neue Produkte; aber kultureller Übergang ist hart

---

### Lösung C2: Hybrid-Muster für Szenarien wählen

#### Szenario A: IoT-Gerätentwicklung

**Gewähltes Muster: Klassische Hardware + Parallel Agile Firmware/Backend + Integrations-Gate**

**Begründung:**
- Hardware-Design hat lange, unverrückbare Vorlaufzeiten
- Firmware und Cloud können parallel entwickelt werden
- Integration ist kritischer Synchronisations-Punkt
- Time-to-Market ist moderat (nicht als Startup unter Druck)

**Ablauf-Skizze:**

```
Month 1–3: Hardware-Anforderungen & Design (klassisch)
   ├─ Anforderungsanalyse → Design-Review → Prototyp-Bestellung
   
Month 4–6: PARALLEL:
   ├─ Hardware-Fertigung & Qualifikation (klassisch)
   └─ Firmware + Backend-Sprints (agil, 2-wöchentlich)
      ├─ Sprint-1: User-Authentication-Backend
      ├─ Sprint-2: Device-Communication-Protocol (Firmware)
      ├─ Sprint-3: Data-Collection-APIs
      └─ Hardware-Prototyp-Verfügbar: Integration-Testbed
      
Month 7–8: Integration-Phase (hybrid)
   ├─ Firmware-Team: Integration-Tests gegen echte Hardware
   ├─ Backend-Team: Anbindung echter Geräte
   └─ Integration-Gate: Alle Komponenten funktionieren
   
Month 9: GoLive (klassisch)
   ├─ Finale Zertifizierung, Firmware-Signing
   ├─ Backend-Deployment
   └─ Launch
```

**Synchronisations-Events:**
- **Bi-wöchentlich:** Firmware-Team + Backend-Team + Hardware-Lead treffen sich (30 Min)
  - Status: Welche APIs braucht Hardware? Sind sie ready?
  - Impediments: Was blockiert Beide?
  - Planning: Nächste Sprint sollte Interface-Kompatibilität haben
- **Monatlich:** Steering-Sync (PM, Hardware-Lead, Dev-Lead, PO)
  - Budget, Timeline, Risks

> **Kommentar:** Das Muster heißt „**Klassische Parallele + Agile Integration**". Es ist ideal, wenn Sie ein breites Team haben, das beide Welten versteht. Häufiger Fehler: Firmware-/Backend-Teams arbeiten zu isoliert und entdecken Integrations-Probleme erst zu spät.

---

#### Szenario B: Enterprise ERP-Implementierung

**Gewähltes Muster: Klassische Anforderungsanalyse + Iterative Konfiguration mit Pilot + Phasierter klassischer Rollout**

**Begründung:**
- 80% Anforderungen sind stabil (Standardprozesse)
- 20% Customizing braucht Exploration
- Große, verteilte Organisation erfordert klassische Rollout-Phasen
- Hohe Compliance- und Change-Management-Anforderungen

**Ablauf-Skizze:**

```
Month 1–3: Anforderungsanalyse (klassisch)
   ├─ Business-Prozess-Mapping
   ├─ Gaps-Analyse (Standard SAP-Funktionen vs. Wunsch)
   ├─ Customizing-Liste (priorisiert)
   └─ Pilot-Auswahl: 2 Business-Units als Early Adopter

Month 4–7: Konfiguration + Pilot (hybrid – Stage-Gate mit Sprints)
   ├─ Configuration-Team: 2-wöchentliche Sprints
   │  ├─ Sprint-1: Standard-Module (Master Data, Finance Basics)
   │  ├─ Sprint-2: Customizing-Module (Custom Reports, Interfaces)
   │  └─ Sprint-3: Integration mit Legacy-Systemen
   ├─ Pilot-Phase: Parallel zu Sprints
   │  ├─ Week 4–5: Sprint-1-Konfiguration in Pilot-Umgebung, Early Users testen
   │  ├─ Week 6–7: Feedback-Integration, Sprint-2 basiert auf Lessons
   │  ├─ Week 8–9: Sprint-2/3 in Pilot, UAT intensiv
   │  └─ Go/No-Go-Entscheidung nach 4 Sprints
   
Month 8–10: Go-Live Planning + Training (klassisch)
   ├─ If Go-Decision nach Pilot: Rollout-Phasen definieren (3 Wellen à 2 Wochen)
   ├─ Training: Online + Classroom für jede Welle
   ├─ Cutover-Plan: Klassischer Change-Over, Data-Migration, Rollback-Plan

Month 11–14: Phased Rollout (klassisch)
   ├─ Welle 1 (Week 11–12): Finance + Controlling
   ├─ Welle 2 (Week 12–13): Supply Chain
   ├─ Welle 3 (Week 13–14): HR + Payroll
   
Month 15+: Stabilisierung & Lessons Learned (klassisch)
   ├─ Post-Go-Live-Support
   ├─ Retrospektive
   └─ Dokumentation von Best Practices
```

**Integration klassisch/agil:**

| Phase | Klassische Elemente | Agile Elemente | Governance |
|-------|------------------|-----------------|-----------|
| **Anforderungen (Monat 1–3)** | Prozess-Mapping, Gap-Analyse, Scope-Definition | Iterative Stakeholder-Workshops | Steering: 2x Monatlich |
| **Konfiguration (Monat 4–7)** | Configuration-Standards, Test-Plans | 2-wöchentliche Config-Sprints mit Pilot-Feedback | Steering-Sprint-Review: Monatlich |
| **Rollout (Monat 8–14)** | Wellen-Plan, Cutover-Planung, Training-Program | Parallel-Run mit kontinuierlichem Feedback pro Welle | Gate vor jeder Welle |

**Change-Control-Prozess:**

- **Kleine Customizing-Requests während Config:** → Backlog-Item für nächsten Sprint (PO entscheidet)
- **Große Change-Requests:** → Change Control Board → Budget/Time-Impact → Go/No-Go
- **Post-Go-Live-Changes:** → Klassisches Change-Control mit formaler Dokumentation (Compliance/Audit)

> **Kommentar:** Dieses Muster ist **sehr verbreitet in der Praxis**. Der Schlüssel zum Erfolg:
> 1. **Pilot ist nicht optional** – Es ist Ihre beste Lern-Chance
> 2. **Agile Sprints sollten kurzfristig sein** (2 Wochen), nicht lange (4+ Wochen)
> 3. **Phasen-Rollout reduziert Risiko** – Go-Live auf allen Systems gleichzeitig ist zu riskant
> 4. **Change Control bleibt klassisch, aber schneller** – 48–72h Entscheidung statt Wochen

---

## Aufgabenblock D: YouTrack-Praktikum

### Lösung D1: Hybrid-Projekt in YouTrack einrichten

#### Schritt 1: Workflows definieren

**Lösung für Payment-Projekt in YouTrack:**

**Workflow-States und Transitionen:**

```
┌─────────────────────────────────────────────────────────────────┐
│                   HYBRID WORKFLOW: Payment Migration             │
└─────────────────────────────────────────────────────────────────┘

Klassische Phase:
  [New] → [Requirement-Analysis] → [Requirement-Review]
                                           ↓ Approved
                                    [Ready for Design]

Klassische Phase + Gate:
  [Design-Phase] → [Arch-Review] → [Arch-Approved]
                                       ↓
                                  [Ready for Dev]

Agile Phase (Sprints):
  [Sprint-Backlog] → [In-Sprint-Dev] → [Sprint-Review]
                                           ↓ Approved
                                      [Ready for Test]

Klassische Phase:
  [Testing-Phase] → [UAT-Testing] → [Test-Gate]
                                        ↓ Passed
                                   [Ready for GoLive]

Klassische Phase + Gate:
  [Pre-GoLive] → [Compliance-Check] → [GoLive-Approved]
                                           ↓
                                         [Done]

Parallel-Workflow für Issues/Bugs:
  [New-Issue] → [Triage] → [In-Development] → [Testing] → [Resolved] → [Closed]
```

**YouTrack States definieren (konkret):**
1. `New` – Neu erstellt
2. `Requirement-Analysis` – In klassischer Anforderungsanalyse
3. `Requirement-Review` – Anforderungs-Review (Gate-Entscheidung)
4. `Ready for Design` – Freigegeben für Design-Phase
5. `Design-Phase` – In Design (klassisch)
6. `Arch-Review` – Architektur wird reviewt (Gate)
7. `Arch-Approved` – Design freigegeben
8. `Ready for Dev` – Vorbereitet für Sprint-Planung
9. `Sprint-Backlog` – In aktuelles Sprint-Backlog
10. `In-Sprint-Dev` – In aktuellem Sprint in Development
11. `Sprint-Review` – Demonstriert in Sprint-Review
12. `Ready for Test` – Freigegeben für Test (nach Sprint-Approval)
13. `Testing-Phase` – In UAT/Integration-Test
14. `Test-Gate` – Test-Gate durchlaufen
15. `Ready for GoLive` – Bestätigt für Go-Live
16. `Pre-GoLive` – Final checks (Compliance, Cutover)
17. `Compliance-Check` – Compliance-Review (Gate)
18. `GoLive-Approved` – Final Approval
19. `Done` – Abgeschlossen

> **Kommentar:** Das ist relativ granular. Sie können auch "vereinfachen" zu:
> `New → Analysing → Design → Development → Testing → GoLive-Ready → Done`
> Je nach Bedarf. Wichtig ist, dass **Gates sichtbar sind** als explizite States, nicht versteckt in Transitions.

---

#### Schritt 2: Custom Fields definieren

**Empfohlene Custom Fields für Payment-Hybrid-Projekt:**

| Custom Field | Type | Werte/Optionen | Zweck |
|--------------|------|----------------|-------|
| **Phase** | List (Single) | Anforderungen, Design, Development, Testing, GoLive, Abschluss | Zuordnung zu klassischen Phasen |
| **Sprint** | Link (to other issue) | Sprint-1, Sprint-2, Sprint-3, ... oder (none) | Zuordnung zu Agile-Sprints |
| **Regulatory-Status** | List (Single) | Compliant, Pending-Review, Non-Applicable, Rejected | Compliance-Tracking |
| **Priority-Business** | Integer (1–5) | 1 (Critical) bis 5 (Low) | Business-Priorität (klassisch) |
| **Story-Points** | Integer | 1, 2, 3, 5, 8, 13, 21 | Agile-Schätzung |
| **Change-Type** | List (Single) | Enhancement, Defect, Regulatory-Change, Technical-Debt, Infrastructure | Art der Change |
| **Impact-Assessment** | Text (Long) | Freitext | Impact-Analyse (für Change Control) |
| **Risk-Level** | List (Single) | Low, Medium, High, Critical | Assoziiertes Risiko |
| **External-Dependency** | Link (to other issue) | Links zu externen Integrationen (z.B. Payment-Partner-Issues) | Tracking von Abhängigkeiten |
| **Compliance-Checklist** | List (Multi) | Security-Review, Audit-Trail, Data-Protection, Interface-Testing, Backup-Plan | Multiple Compliance-Items pro Issue |

**Custom Fields – Rollen-Sichtbarkeit:**
- **Sponsor sieht:** Phase, Priority-Business, Risk-Level, Change-Type, Impact
- **Scrum Master sieht:** Sprint, Story-Points, Compliance-Status
- **Compliance-Officer sieht:** Regulatory-Status, Compliance-Checklist, Impact-Assessment
- **Tech-Team sieht:** Alles

---

#### Schritt 3: Issue-Strukturierung (Epics, Stories, Tasks)

**Beispiel-Struktur für Payment-Projekt in YouTrack:**

```
Epic: Payment-Flow Implementation (Phase: Development)
├─ User Story: [Sprint-1] Card Payment Initiation
│  ├─ Task: Database Schema Design (Phase: Design, Story-Points: 3)
│  ├─ Task: API Endpoint Implementation (Phase: Development, Sprint-1, Story-Points: 5)
│  ├─ Task: Unit Tests (Phase: Development, Sprint-1, Story-Points: 3)
│  ├─ Task: Integration Tests with Partner (Phase: Testing, Story-Points: 5)
│  └─ Task: Compliance Review (Phase: GoLive, Regulatory-Status: Pending)
│
├─ User Story: [Sprint-2] Payment Confirmation & Callback
│  ├─ Task: Callback-API Design (Phase: Design, Story-Points: 3)
│  ├─ Task: Callback Handler Implementation (Phase: Development, Sprint-2, Story-Points: 5)
│  └─ Task: Error-Handling Tests (Phase: Testing, Story-Points: 3)
│
├─ User Story: [Sprint-3] Payment Cancellation & Refund
│  └─ ...
│
├─ Task: Architecture Review (Phase: Design, nicht in Sprint)
├─ Task: Security Assessment (Phase: Design → GoLive, Regulatory-Status: Critical)
├─ Task: Performance Testing (Phase: Testing, Story-Points: 8)
│
└─ Epic-dependent: Regulatory Approval (Phase: GoLive, Risk-Level: Critical)
   ├─ Task: PCI-DSS Certification Review (Regulatory-Status: In-Review)
   ├─ Task: Audit-Trail Validation (Regulatory-Status: Pending)
   └─ Checklist-Items: Data-Protection ✓, Interface-Testing ✓, Backup-Plan ⏳
```

> **Kommentar:** 
> - **Epics = Geschäfts-Features** (wasserfallmäßig)
> - **User Stories = Agile Anforderungen**, gehören zu Sprints
> - **Tasks = Techische Subtasks**, können zu Stories oder als standalone existieren
> - **Compliance-Tasks** sind CROSS-CUTTING und sollten explizit sichtbar sein
> - **External Dependency** nutzen, um Partner-Integrationen zu tracken

---

#### Schritt 4: Reporting-Beispiele

**Report 1: Steering-Dashboard (Klassisch-fokussiert)**

**Name:** Monthly Phase Status Report
**Zielgruppe:** Steering Committee, Sponsor, PMO
**Inhalt:**
- Phase-Completion % (Gantt-View): Anforderungen 100%, Design 60%, Development 20%, Testing 0%
- Phase-Gate-Status: Design-Gate grün (approved), nächstes Gate: Dev→Test (planned für Woche 15)
- Budget-Burn: Kosten vs. Plan (klassisch)
- Top 5 Open Issues/Risks: Priorisiert, mit Owner und Target-Resolutions-Date
- Change Requests (genehmigt, pending, rejected)

**Query in YouTrack:**
```sql
project = PAYMENT 
AND customField(Phase) in (Anforderungen, Design, Development, Testing, GoLive)
GROUP BY customField(Phase)
ORDER BY Phase-Sequenz
```

**Häufigkeit:** Monatlich

---

**Report 2: Agile Sprint-Dashboard (Agil-fokussiert)**

**Name:** Sprint Status & Burndown
**Zielgruppe:** Team, Scrum Master, PO
**Inhalt:**
- Sprint Burndown Chart: Stories/Points geplant vs. abgeschlossen
- Work Item Status: [In-Sprint-Dev: 5 Issues], [Sprint-Review: 3 Issues], [Ready: 2]
- Velocity Trend: Letzten 3 Sprints (Ziel: Stabilität)
- Blockers & Impediments: Offene Impediments mit Owner
- Forecast: Werden Sprint-Goals erreicht?

**Query in YouTrack:**
```sql
project = PAYMENT
AND customField(Sprint) = CURRENT_SPRINT
ORDER BY State (In-Dev first)
```

**Häufigkeit:** Täglich oder nach Sprint-Event

---

**Report 3: Hybrid-Governance-Report (Kombiniert)**

**Name:** Steering-Sprint-Review Summary (Alle 4 Wochen)
**Zielgruppe:** Steering, PM, PO, Tech-Lead
**Inhalt:**
- **Geschäfts-Seite:**
  - Phase-Fortschritt (Gantt): aktuelle Phase % done
  - Gate-Status: Letzte Gate-Entscheidung + nächste Gates geplant
  - Budget-Trend: Spend vs. Plan
- **Tech-Seite:**
  - Sprint-Ergebnisse: Punkte abgeschlossen, Qualität (Defect-Rate)
  - Velocity: Ist Team schneller oder langsamer?
  - Tech-Risks/Debt: Neu identifiziert in letztem Sprint
- **Governance:**
  - Changes: Neue CR, genehmigte CR, rejected CR (mit Rationale)
  - Compliance-Status: Regulatory-Items done/pending
  - Top 3 Risks: Mit Mitigation-Plan

**Query in YouTrack (kombiniert mehrere Reports):**
```sql
# Phase-Status (klassisch)
project = PAYMENT 
AND customField(Phase) is not EMPTY
GROUP BY Phase, ORDER BY Phase-Sequence

# Sprint-Status (agil, letzte 4 Wochen)
project = PAYMENT 
AND updated >= -4w
AND Type in (Story, Task)
GROUP BY State

# Changes & Risks
project = PAYMENT 
AND customField(ChangeType) is not EMPTY OR customField(RiskLevel) != Low
ORDER BY updated DESC
```

**Häufigkeit:** 4-wöchentlich (nach jedem 2. Sprint)

> **Kommentar:** Die **Hybrid-Governance-Report ist der Schlüssel** zum Erfolg. Sie verbindet klassische (Phase, Budget, Gates) mit agilen (Sprint, Velocity) Metriken in einer Ansicht. Dadurch verstehen beide Seiten (Steering + Tech) was los ist.

---

### Lösung D2: Change-Request-Prozess abbilden

#### Schritt 1: Change-Request-Workflow in YouTrack

**Workflow-Design für Changes:**

```
┌─────────────────────────────────────────────────────────┐
│             CHANGE-REQUEST-WORKFLOW                      │
└─────────────────────────────────────────────────────────┘

[New CR] 
  ↓ (Creator füllt aus: Description, Business-Reason, Affected Items)
  
[Triage]
  ↓ (PM oder PO macht Quick-Review)
  ├─→ Too Vague? → [Request More Info] → (back to Creator)
  └─→ Clear? → [Impact-Analysis]

[Impact-Analysis]
  ↓ (Tech-Lead, PO, Arch schätzen Aufwand)
  ├─→ Aufwand < 5 Tage → [Small-Change-Branch]
  └─→ Aufwand ≥ 5 Tage → [Large-Change-Branch]

━━━━━━━━━ SMALL CHANGE BRANCH ━━━━━━━━━━━━━
[Small-Change-Review]
  ↓ (PO: Genehmigung based on Priority & Sprint-Capacity)
  ├─→ Approved → [Ready for Sprint-Backlog]
  │    ↓
  │    [Into Next Sprint] → [Done]
  │
  └─→ Deferred → [In-Backlog] (next Prioritization-Chance)

━━━━━━━━━ LARGE CHANGE BRANCH ━━━━━━━━━━━━
[CCB-Review]
  ↓ (Change Control Board: Sponsor, PM, Arch, Compliance review)
  ├─ Impact Score = (Effort + Risk + Scope-Change)
  ├─→ Approved → [Ready for Planning]
  │    ↓ (PM adds to Roadmap/Future Phase)
  │    [Into Roadmap] → [Done]
  │
  ├─→ Approved with Mitigation → [Ready for Planning] (mit Risk-Items)
  │
  └─→ Rejected → [Rejected] (document Reason)

[Done / Closed]
```

**YouTrack-Implementation:**

**Issue-Type: ChangeRequest**

**States:**
1. `New` – Gerade erstellt
2. `Triage` – PM/PO prüft Vollständigkeit
3. `More-Info-Requested` – Zurück an Creator für Details
4. `Impact-Analysis` – Tech-Team schätzt Aufwand
5. `Small-Change-Review` – Schnelle PO-Genehmigung (< 5 Tage)
6. `Large-Change-CCB-Review` – Formales Change-Control-Board
7. `Approved` – Genehmigt (Small oder Large)
8. `Deferred` – In Backlog, nicht sofort
9. `Ready-for-Sprint-Backlog` – (Small) Kann nächsten Sprint eingeplant
10. `Ready-for-Roadmap` – (Large) Wird in Roadmap aufgenommen
11. `Rejected` – Abgelehnt (mit Grund)
12. `Done` – Implementiert (linked Issue wurde closed)

**Transitions & Rules:**

| Transition | Trigger | Validator | Automatisierung |
|-----------|---------|-----------|-----------------|
| New → Triage | Manuell | (keiner) | (keiner) |
| Triage → More-Info-Requested | PM sieht Lücken | PM | Notification an Creator |
| More-Info-Requested → Impact-Analysis | Creator antwortet | (keiner) | Notification an PM |
| Impact-Analysis → Small-Change-Review | Effort < 5d | Tech-Lead | Auto-Routing zu PO |
| Impact-Analysis → Large-Change-CCB-Review | Effort ≥ 5d | Tech-Lead | Auto-Routing zu CCB; Calendar-Invite für nächstes CCB-Meeting |
| Small-Change-Review → Approved | PO entscheidet | PO | Notification an Team |
| Large-Change-CCB-Review → Approved | CCB entscheidet | CCB-Chair | Formal documented |
| Approved → Ready-for-Sprint-Backlog | (Small) | PO | Link zu zukünftigem Sprint |
| Approved → Ready-for-Roadmap | (Large) | PM | Verschiebung in Roadmap-Epic |
| Approved → Rejected | (bei Mitigation-Plan) | Sponsor | Dokumentation |
| Ready-for-Sprint-Backlog → Done | Zugehörige User Story closed | (auto) | Auto-Close CR |

> **Kommentar:** Das Wichtigste ist, **Small Changes schnell durchzuprüfen** (PO-Only), während **Large Changes formales CCB durchlaufen**. So balancieren Sie Geschwindigkeit (agil) mit Governance (klassisch).

---

#### Schritt 2: Entscheidungslogik

**Wer entscheidet was?**

**Small Change (< 5 Tage Aufwand):**
- **Entscheidung durch:** Product Owner (allein, mit Sponsor als Observer optional)
- **Kriterien:** Passt in aktuelle/nächste Sprint? Höhere Priorität verschieben?
- **Dokumentation:** CR-Issue mit Link zu genehmigter Story, Sprint-Zuweisung
- **Durchlaufzeit:** 1–2 Tage

**Large Change (≥ 5 Tage Aufwand):**
- **Entscheidung durch:** Change Control Board
  - **Mitglieder:** Sponsor, Project Manager, Technical Architect, Compliance Officer
  - **Chair:** Sponsor (hat letzte Entscheidungsbefugnis)
- **Kriterien:** Business-Value vs. Aufwand, Risiken, Compliance-Impact, Zeitplan-Impact
- **Dokumentation:** Formales Change-Request-Dokument mit Impact-Analysis, Risk-Assessment, Approval-Signature (digital)
- **Durchlaufzeit:** 5–7 Tage (bis nächstes CCB-Meeting)

---

#### Schritt 3: Integration mit Sprint-Planung

**Wie werden genehmigte Small Changes in Sprint-Planung integriert?**

**Prozess:**

1. **Small-Change genehmigt** → State = `Ready-for-Sprint-Backlog`
   - PO erstellt korrespondierende User Story: „Implement Change-Request XYZ"
   - Link: Story ← CR

2. **Sprint Planning (vor neuem Sprint):**
   - Team & PO sehen: 
     - Bereits geplante Stories
     - **+ Ready-for-Sprint-Backlog Items** (neue Small Changes)
   - PO re-priorisiert oder nimmt Small Changes auf
   - Wenn genug Kapazität: In Sprint aufgenommen
   - Falls nicht: Bleibt in Backlog

3. **Alternativer Flow (urgent Small Change mid-Sprint):**
   - Change wird genehmigt **während aktiven Sprint läuft**
   - PO entscheidet: 
     - **Option A:** In nächsten Sprint (bevorzugt)
     - **Option B:** Sprint-Scope ausnahmsweise erweitern (wenn low-risk)
     - **Option C:** Andere Story rausnehmen und ersetzen

**Large Change:**
- Nie mid-Sprint eingeplant
- Wird Teil von zukünftiger Roadmap
- Nächster Gates-Point = Planung der Phase mit Large Change

**YouTrack Workflow (Automation):**
```sql
# Trigger: Small-Change approved
IF Status = Approved AND customField(ChangeSize) = Small THEN
  - Create linked User Story (Template: "Implement {ChangeRequest.Title}")
  - Set Story Status = Ready-for-Sprint-Backlog
  - Move Story to Product Backlog (not in any Sprint yet)
  - Send Notification to PO: "New Small Change ready for Sprint-Planning"
  
# Trigger: Large-Change approved
IF Status = Approved AND customField(ChangeSize) = Large THEN
  - Update linked Roadmap-Epic
  - Send Notification to PM: "Large Change approved, add to Roadmap"
```

> **Kommentar:** Der kritische Punkt: **Small Changes sollten nicht das Sprint-Backlog überfluten**. Wenn zu viele CRs pro Sprint, ist ein Symptom, dass Anforderungen nicht stabil sind. Dann müssen Sie Ursache beheben (z.B. besseres Stakeholder-Management), nicht einfach mehr CRs zulassen.

---

## Aufgabenblock E: Fallstudien & Reflexion

### Lösung E1: Fallstudie Finanzbranche analysieren

#### 1. Kontext-Analyse

**Bewertungen (1–10, wobei 1 = klassisch, 10 = agil):**

| Aspekt | Bewertung | Begründung |
|--------|-----------|-----------|
| **Anforderungsklarheit** | **3 / 10** | 60% regulatorische Anforderungen sind stabil und nicht verhandelbar. 40% technische Modernisierung hat Explorations-Potential. Deutlich klassisch. |
| **Organisationskultur** | **2 / 10** | Großbank mit klassischer Struktur. Wenig Agilität. Hierarchische Entscheidungsfindung. |
| **Regulatorium** | **1 / 10** | Basel III, Compliance, Audit-Trail sind nicht verhandelbar. Höchste Klassik-Anforderung. |
| **Team-Größe & Verteilung** | **3 / 10** | 50 Personen über 3 Standorte = große Komplexität, erfordert klassische Strukturen. |
| **Budget & Timeline** | **3 / 10** | €5M über 24 Monate = moderate Ressourcen, ausreichend Zeit. Kein extremer Druck → klassisches Denken. |
| **Technische Modernisierung (Upside Potential)** | **6 / 10** | Mainframe → Modern Architecture = explorative, komplexe Technische Arbeit. Hier könnte Agile Mehrwert bringen. |

**Durchschnitt:** (3+2+1+3+3+6) / 6 = **3 / 10** → **Deutlich klassischer Hybrid-Ansatz**

---

#### 2. Tailoring-Empfehlung

**Hybrid-Mix für Kreditvergabe-Modernisierung:**

| Aspekt | Empfehlung | % |
|--------|-----------|-----|
| **Klassische Elemente** | Gates, Phasen, Change-Control, Compliance-Dokumentation | **70%** |
| **Agile Elemente** | Iterative Entwicklung, Sprints, Kontinuierliche Integration | **30%** |

**Hybrid-Muster:** **Stage-Gate + Agile Sprints mit Compliance-Overlay**

**Begründung:**
- **70% klassisch**, weil Regulatorium, Größe, Risikoaversion dominieren
- **30% agil**, weil technische Komplexität (Mainframe→Cloud) iterative Lernzyklen braucht
- **Compliance-Overlay** = alle agilen Outputs werden documented für Audit-Trail

---

#### 3. Governance-Struktur

**Empfohlenes Governance-Modell:**

**Rollen:**
- **Sponsor:** Vorstandsmitglied (Bank-intern); trägt Verantwortung gegenüber Aufsichtsrat
- **Steering Committee:** 
  - Vorsitz: Sponsor
  - CFO/CRO (Chief Risk Officer)
  - Head of IT
  - Head of Compliance
  - Project Manager
- **Product Owner:** Geschäftsseite (Business Analyst + Risk-Officer komplementär)
- **Scrum Master:** Tech-Lead (moderiert Entwickler-Arbeit)
- **Architecture Review Board (ARB):** Externe oder intern erfahrene Architekten (Mainframe + Cloud)
- **Change Control Board (CCB):**
  - Sponsor
  - PM
  - Architect
  - Compliance Officer
  - Business Owner

**Governance-Events:**

| Meeting | Frequenz | Teilnehmer | Zweck | Dauer |
|---------|----------|-----------|-------|--------|
| **Steering Committee** | Monatlich | Sponsor, CFO, CRO, CIO, PM, Compliance | Phase-Freigabe, Budget-Control, Risiken, Regulatory Status | 120 Min |
| **Architecture Review Board** | Am Ende Design-Phase, dann nach Phase 1 agil | ARB-Members, PM, Arch | Design-Approval, Technology Risk Assessment | 60 Min |
| **Sprint Planning & Sprint Review (combined)** | 2-wöchentlich | Dev-Team, Scrum Master, Product Owner, Tech-Lead | Sprint-Ziele, Priorität, Impediments | 3–4 Std |
| **Daily Standup** | Täglich (optional für PM) | Dev-Team, Scrum Master | Koordination, Blocker-Auflösung | 15 Min |
| **Change Control Board** | Ad hoc (wenn CR ansteht), mindestens wöchentlich | CCB-Members | Änderungen genehmigen/ablehnen, Impact-Analyse | 60 Min |
| **Compliance Review** | Vor GoLive, dann Quartalsweise | Compliance Officer, Arch, PM, Ops | Audit-Trail-Validierung, Regulatory-Checklist | 90 Min |
| **Post-Implementation Review** | 3 Monate nach GoLive | Sponsor, PM, PO, Arch, Operations | Lessons Learned, Stabilität, Issues | 60 Min |

**Schnittstellen zwischen klassisch/agil:**

```
Steering ← (Monatliche Synchronisation) ← Sprint-Ergebnisse
    ↓                                          ↑
  Gates                                    Sprints
    ↓                                          ↑
  Phasen-Milestones ← (Zielobjekte) ← Feature-Implementations
```

---

#### 4. Risiken beim Hybrid-Ansatz

| Risiko | Eintrittswahrscheinlichkeit | Auswirkung | Mitigation |
|--------|---------------------------|-----------|-----------|
| **„Hybrid als Ausrede für Chaos"** | Mittel | Hoch | Strikte Tailoring-Dokumentation, regelmäßige Governance-Audits |
| **Kulturelle Reibung Klassisch/Agil** | Hoch (Großbank!) | Hoch | Change-Management Investment, Schulungen, Coaching |
| **Compliance-Lücken durch Agile-Tempo** | Mittel-Hoch | Sehr Hoch (reguliert!) | Compliance-Officer in jedem Sprint, Audit-Trails-by-Design |
| **Zu viel Overhead (zu viele Meetings)** | Hoch | Mittel | Klare Frequenzen, Nur-als-nötig-Basis für CCB |
| **Technische Schulden wegen Agile-Druck** | Mittel | Hoch | Tech-Debt-Budgeting (z.B. jeder 4. Sprint für Refactoring) |
| **Externe Abhängigkeiten blockieren Sprints** | Hoch (3 Partner!) | Hoch | Frühzeitige Partner-Integration, Test-Doubles während Sprints |
| **Team-Burnout (beides zu viel)** | Hoch (50 Personen!) | Hoch | Realistische Velocity-Schätzung, Scope-Management |
| **Mainframe-Legacy-Komplexität unterschätzt** | Mittel-Hoch | Sehr Hoch | Explizite Legacy-Integration-Phase (Weeks 1–8 klassisch) |

**Top 3 Mitigation-Maßnahmen:**
1. **Compliance-Einbettung in Sprints:** Nicht nach Development, sondern parallele Compliance-Review
2. **Pilot-Phase:** Erst 2–3 Module mit Hybrid testen, dann skalieren
3. **Executive Coaching:** Sponsor und Steering verstehen hybrid-Denken (nicht mehr „klassisch besser", sondern Kontext-abhängig)

---

#### 5. YouTrack-Setup

**Workflows:**

```
Klassisch:
  New → Requirements-Analysis (Regulatory) → Compliance-Review → Design → ARB-Review

Hybrid:
  Design → Sprint-Planning → [Sprint 1–n: Dev] → [Compliance-Validation nach jeder 2 Sprints] → UAT → GoLive-Readiness

Parallel:
  Mainframe-Integration-Phase (1–2 Sprints, klassisch) + Cloud-Development (Sprints)
```

**Custom Fields:**

| Field | Type | Purpose |
|-------|------|---------|
| `Phase` | List | Requirements, Design, Dev, Test, Integration, GoLive |
| `Sprint` | Link | Sprint-1, Sprint-2, ... |
| `Regulatory-Status` | List | Compliant, Pending-Review, Non-Compliant, Waived |
| `Module` | List | Payments, Loans, Deposits, Reporting, Integration |
| `Compliance-Checklist` | Multi-List | Audit-Trail, Data-Protection, Segregation-of-Duties, Encryption, ... |
| `Legacy-Dependency` | Link | Links zu Mainframe-Integration-Issues |
| `External-Partner` | List | Partner-A, Partner-B, Partner-C |
| `Tech-Debt-Item` | Boolean | Ist das technische Schuld? |

**Reports:**

1. **Steering-Dashboard (monatlich):** Phase-Status, Budget-Burn, Top 10 Risks, Regulatory-Items-Pending
2. **Sprint-Dashboard (bi-weekly):** Burndown, Compliance-Validation-Status, External-Partner-Dependencies, Tech-Debt-Trend
3. **Compliance-Dashboard (continuous):** Regulatory-Checklist-Progress, Audit-Trail-Items-Confirmed, Policy-Deviations

---

### Lösung E2: Eigenes Projekt reflektieren (Beispiel-Antwort)

#### Projekt-Beschreibung

**Titel:** Marketing-Automation-Plattform-Implementierung (Finanzdienstleister)
- **Dauer:** 8 Monate
- **Team:** 8 Personen (2 x Business, 3 x IT, 2 x Ops, 1 x PM)
- **Aktueller Ansatz:** Klassi-Wasserfall (Anforderungen → Design → Dev → Test → GoLive)
- **Status:** In Phase 3 (Development), 4 Monate laufen

#### Aktuelle Situation analysieren

**Was funktioniert gut:**
- Anforderungen sind klar definiert (Geschäft weiß, was es braucht)
- Compliance-Anforderungen sind dokumentiert und trackbar
- Stakeholder-Kommunikation läuft über formale Status-Meetings

**Was funktioniert nicht:**
- Development dauert länger als geplant (Customizing-Anforderungen tauchen auf, die nicht erwartet waren)
- Test-Phase wird verkürzt (zeitliche Verschiebungen in Dev)
- Team ist demotiviert (3–4 Monate Plan-Arbeit ohne sichtbare Ergebnisse)
- Feedback von Endnutzern kommt zu spät (erst in UAT)

#### Hybrid-Potenzial analysieren

**Kontext-Bewertung:**

| Faktor | Bewertung | Grund |
|--------|-----------|-------|
| Anforderungsklarheit | 6 / 10 | 70% Standardprozesse, 30% Customizing |
| Organisationskultur | 4 / 10 | Finance-Branche, klassisch, aber offene IT-Gruppe |
| Regulatorium | 4 / 10 | Mittel (Marketing-Daten müssen GDPR-konform) |
| Team | 5 / 10 | Klein, aber gemischte Erfahrung (1 hat Agile-Erfahrung) |
| Time-to-Market | 3 / 10 | Nicht extrem drängend |

**Tailoring-Empfehlung:** **60% klassisch / 40% agil**

**Hybrid-Muster:** Stage-Gate + Agile Development Sprint + Continuous User-Feedback

---

#### Konkrete Hybrid-Adaption

**Geplante Veränderungen:**

| Veränderung | Was | Wie | Nutzen |
|-------------|-----|-----|--------|
| **1. Iteratives Customizing** | Statt großes Customizing am Ende, iterativ machen | 2-wöchentliche Dev-Sprints statt 4-Monate am Stück | Team-Motivation ↑, frühe Fehler-Erkennung, echte Velocity sichtbar |
| **2. Nutzer-Feedback früh** | Nicht warten bis UAT, sondern User-Stories mit Geschäft validieren | Bi-wöchentliche Sprint-Reviews mit Business-Representative | Anforderungs-Klarheit ↑, Rework ↓, Zufriedenheit ↑ |
| **3. Kleine Gates statt großes GoLive-Gate** | Gate nach jeder 3. Sprint (nicht erst am Ende) | Micro-Gate: Können wir diesen Teil deployen? | Risiko verteilt, nicht alles hängt vom GoLive-Tag ab |
| **4. Governance-Light** | Steering monatlich (nicht wöchentlich) | Steering sieht Sprint-Ergebnisse statt nur Statusberichte | Weniger overhead, echte Governance (nicht nur Controlling) |

**3 konkrete Implementierungs-Maßnahmen:**

1. **Sofort:** Nächste Dev-Phase (noch 4 Monate) in 2-wöchentliche Sprints aufteilen (8 Sprints)
   - Sprint-Planung: Was sind Top-Prioritäts-Customizing?
   - Sprint-Review: Business sieht nach 2 Wochen Ergebnis
   - Rückkopplung in Sprint-Planung nutzen
   - Risiko: Aktueller Plan muss angepasst werden. Aber das ist okay.

2. **In 3 Monaten:** Micro-Gate nach Sprint 3: Können wir Module X produzieren?
   - Nicht alle Customizing müssen bis GoLive perfekt sein
   - MVP-Release: Core-Funktionen nach Monat 4 live, Rest folgt in Phase-2
   - Risiko: Governance muss zustimmen (Steering-Entscheidung)

3. **In 6 Monaten:** Retrospektive: Hybrid-Ansatz evaluieren
   - War der Mix 60/40 richtig? Oder 70/30 besser?
   - Welche agilen Praktiken sollen wir beibehalten?
   - Was war overhead?

---

## Checkliste für erfolgreiche Hybrid-Implementierung

✓ **Planung & Tailoring:**
- [ ] Kontext analysiert (6 Faktoren bewertet)
- [ ] Hybrid-Mix % begründet und dokumentiert
- [ ] Hybrid-Muster konkret gewählt (nicht nur „hybrid")
- [ ] Team versteht das „Warum"

✓ **Governance:**
- [ ] Rollen & RACI-Matrix definiert
- [ ] Governance-Events mit Frequenz geplant
- [ ] Klassische Gates und agile Zyklen integriert (nicht Silos)
- [ ] Eskalationswege klar

✓ **Prozesse:**
- [ ] Workflows in YouTrack (oder Tool) implementiert
- [ ] Custom Fields für Hybrid-Tracking
- [ ] Change-Control-Prozess (Small vs. Large Changes)
- [ ] Reporting kombiniert klassisch + agil

✓ **Team & Kultur:**
- [ ] Schulungen für beide Methodiken
- [ ] Mentoring/Coaching für Hybrid-Denken
- [ ] Retrospektiven für laufende Optimierung
- [ ] Erfolgsgeschichten kommunizieren (Early Wins)

---

## Tipps & Häufige Fehler

| Fehler | Ursache | Lösung |
|--------|--------|--------|
| Zu viele Meetings | Alle Prozesse bleiben, nur Hybrid hinzugefügt | Meetings konsolidieren (z.B. Steering + Sprint Review) |
| Compliance-Lücken | Agile Speed ohne Dokumentation | Compliance-Officer im Sprint, Audit-Trail-by-Design |
| Klassisch/Agil konkurrieren | Rollen unklar | RACI-Matrix, klare Schnittstellen |
| „Hybrid ist Chaos" | Keine klare Tailoring-Entscheidung | Tailoring-Dokument BEVOR Projekt startet |
| Team-Burnout | Zu viel Arbeit, nicht weniger | Realistische Velocity, Scope-Management |
| Keine Verbesserung sichtbar | Hybrid nicht wirklich gelebt | Retrospektiven, Metrics, Lessons Learned |

---

## Abschluss: Erfolgsfaktoren zusammengefasst

**Ein erfolgreiches Hybrid-Projekt braucht:**

1. **Transparente Tailoring-Entscheidungen:** Stakeholder verstehen, warum dieser Mix
2. **Klare Governance-Spielregeln:** Wer entscheidet wann? (nicht verhandelbar)
3. **Tool-Unterstützung:** YouTrack/Jira/ähnlich zur Integration
4. **Team-Schulung:** Beide Welten verstehen (nicht nur „wir sind Wasserfall")
5. **Regelmäßige Reflexion:** Retrospektiven, Metrics, Lessons Learned
6. **Executive Commitment:** Sponsor muss dahinter stehen (nicht „wir versuchen")
7. **Realistische Erwartungen:** Hybrid ist komplexer, nicht einfacher (am Anfang)

---

**Viel Erfolg mit Ihren Hybrid-Projekten!**

