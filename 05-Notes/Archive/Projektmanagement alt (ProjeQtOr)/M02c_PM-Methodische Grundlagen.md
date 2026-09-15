# Modul 2: PM-Methodische Grundlagen
## Lösungen der Aufgaben mit Kommentaren

---

## Aufgabe 1: Methodenwahl für Projektszenarien

### **Szenario A: SAP-Rollout in großem Konzern**

**Projekt-Parameter**:
- Anforderungen: Hart definiert, Customizing-Konfiguration
- Team: 80 Personen, global verteilt
- Budget: €5 Mio fixiert
- Dauer: 18 Monate
- Risiko: Verzögerungen = hohe Kosten

---

**Aufgabenstellung**: Würde ich klassisch oder agil vorgehen? Begründen Sie.

---

### **Lösungsansatz**

**Antwort: Klassisches Projektmanagement (evtl. mit hybriden Elementen)**

**Begründung**:

| Faktor | Analyse | Gewichtung |
|---|---|---|
| **Anforderungsstabilität** | SAP ist konfigurierbar, aber die Kernprozesse sind vor Projektstart definiert. Die Anforderungen sind STABIL. | ✅ Klassisch |
| **Team-Größe** | 80 Personen = zu groß für Scrum (max. 9–10). Braucht zentrale Koordination & Governance. | ✅ Klassisch |
| **Budget-Fixierheit** | €5 Mio ist klar definiert, Abweichungen sehr teuer. Budget muss geschützt sein. | ✅ Klassisch |
| **Timeline** | 18 Monate ist ein fester Milestone. Go-Live ist ein festes Datum (oft Geschäftsjahreswechsel). | ✅ Klassisch |
| **Regulierung** | SAP-Rollouts haben oft interne Compliance & Audit-Anforderungen → dokumentieren-schwer. | ✅ Klassisch |
| **Org-Struktur** | Konzerne haben oft klassische, hierarchische Strukturen; Agile-Reife ist niedrig. | ✅ Klassisch |

**Fazit**: **Klassisches Phasenmodell** (Anforderungen → Design → Konfiguration → Test → Go-Live)

---

### **Kommentar zur Lösung**

> **Typischer Fehler**: Manche denken, "SAP-Projekte sind technisch, also agil". Das stimmt nicht! Die Anforderungen sind hart definiert (Best Practices), nur die Konfiguration ist variabel. Zudem: Mit 80 Personen funktioniert Agile nicht.

> **Best Practice**: Klassisches Phase-Gate-Modell mit Gate-Reviews nach jeder Phase (Anforderungen-Gate, Design-Gate, Test-Gate). Teams arbeiten in klassischen Arbeitspaketen, nicht in Sprints. Dokumentation ist zentral (für Audit, Compliance, Knowledge Transfer).

> **Hybrid-Elemente möglich**: Innerhalb der Test-Phase könnte man Kanban für Testfälle nutzen (kontinuierliche Testabdeckung statt sequenzielle). Aber grundsätzlich klassisch.

---

---

### **Szenario B: Startup-App Entwicklung**

**Projekt-Parameter**:
- Anforderungen: Unklar, MVP muss schnell entstehen
- Team: 5 Entwickler, co-located
- Budget: Variabel (Investoren), Markteintritt wichtiger als Kostenoptimierung
- Dauer: 8 Wochen bis MVP
- Ziel: Schnell Live, schnell Feedback

---

**Aufgabenstellung**: Würde ich klassisch oder agil vorgehen? Begründen Sie.

---

### **Lösungsansatz**

**Antwort: Agiles Projektmanagement (Scrum / Kanban)**

**Begründung**:

| Faktor | Analyse | Gewichtung |
|---|---|---|
| **Anforderungsstabilität** | Startup = unklare Anforderungen, Pivot-Risiko. MVP wird iterativ verstanden. | ✅ Agil |
| **Team-Größe** | 5 Entwickler = ideal für Scrum. Klein genug für tägliche Synchronisation. | ✅ Agil |
| **Budget-Flexibilität** | Variabel; schneller Markteintritt wichtiger als Kostenplan. | ✅ Agil |
| **Timeline** | 8 Wochen kurz; Warum nicht schnell iterieren & Feedback holen? | ✅ Agil |
| **Org-Reife** | Startups sind meist agil-native; schnelle Entscheidungen möglich. | ✅ Agil |
| **Stakeholder** | Kleiner, klar: CEO = Product Owner, Team = Dev Team. Wenig Bureaucracy. | ✅ Agil |

**Fazit**: **Scrum mit 2-Wochen-Sprints**

*Sprint-Plan*:
- Sprint 1–2: MVP-Kernfunktionalität (User Registration, Core Feature)
- Sprint 3–4: Erweiterte Features + QA
- Sprint 5: Polish, Bug-Fixes, Go-Live-Vorbereitung

---

### **Kommentar zur Lösung**

> **Typischer Fehler**: Startups denken manchmal, sie brauchen „perfekte Planung". Nein! MVP = Minimum Viable Product. 80% der Features, 20% der Zeit/Budget.

> **Best Practice**: Scrum mit Daily Standup (15 Min), Sprint Planning (je Sprint Montag), Sprint Review (freitags), Retrospektive (freitags). Product Owner sollte der Founder oder ein Senior sein, nicht entfernt.

> **Agile Vorteile hier**: Nach jeder 2-Wochen-Sprint gibt es Feedback von Beta-Usern/Investoren. Das Team lernt schnell, was tatsächlich gebraucht wird. Pivots sind billig, weil nie lange an falschen Features gebaut wird.

> **Tipp**: Auch mit 8 Wochen Zeit sollten MVP & Launch einen Buffer von 1 Woche haben. 4 Sprints = 8 Wochen + 1 Woche Launch-Reserve.

---

---

## Aufgabe 2: Rollen-Klärungs-Workshop

**Kontext**: Website-Relaunch eines mittelgroßen E-Commerce-Unternehmens (50 Personen Gesamt, davon 8 in Projekt-Team)

**Aufgabenstellung**: Füllen Sie die RACI-Matrix aus – wer trägt welche Verantwortung?

---

### **Lösungsansatz – RACI-Matrix**

| Aktivität | Sponsor (CEO) | PM (Projektleiter) | PO (Produkt-Manager) | Tech-Team (Dev, QA) |
|---|---|---|---|---|
| **Strategie definieren** | **A** | **C** | **C** | **I** |
| **Business Case / Budget** | **A** | **R** | **C** | **I** |
| **Anforderungen sammeln** | **I** | **C** | **A** | **C** |
| **User Stories schreiben** | **I** | **C** | **A** | **R** |
| **Zeitplan erstellen** | **C** | **A** | **C** | **R** |
| **Technisches Design** | **I** | **C** | **C** | **A** |
| **Code schreiben & Build** | **I** | **C** | **C** | **A** |
| **Quality Assurance / Test** | **I** | **C** | **C** | **A** |
| **Abnahme & Freigabe** | **A** | **R** | **A** | **C** |

**Legende**:
- **A** (Accountable) = Trägt die Verantwortung, ist accountable für das Ergebnis
- **R** (Responsible) = Macht die Arbeit / führt die Aktivität durch
- **C** (Consulted) = Wird befragt / gibt Input
- **I** (Informed) = Wird informiert über Ergebnisse (später)

---

### **Erklärung der Rollen und Zuständigkeiten**

#### **Strategie definieren**
- **Sponsor (A)**: Trägt Verantwortung für strategische Alignierung
- **PM (C)**: Wird konsultiert, ob strategische Ziele mit Projekt machbar sind
- **PO (C)**: Vertritt Customer-Perspektive
- **Team (I)**: Wird später informiert, welche Strategic Priorities gelten

#### **Business Case / Budget**
- **Sponsor (A)**: Trägt Verantwortung (es ist SEIN Budget)
- **PM (R)**: Erstellt den Business Case, kalkuliert Kosten & Nutzen
- **PO (C)**: Gibt ein für Markt & Kunde
- **Team (I)**: Wird informiert über verfügbares Budget

#### **Anforderungen sammeln**
- **PO (A)**: Trägt Verantwortung für Anforderungen (Kundenperspektive)
- **PM (C)**: Wird konsultiert zur Machbarkeit & Priorisierung
- **Sponsor (I)**: Wird informiert, was geplant ist
- **Team (C)**: Gibt technisches Input (ist das möglich? Aufwand?)

#### **Zeitplan erstellen**
- **PM (A)**: Trägt Verantwortung für Planung
- **Team (R)**: Erstellt Schätzungen, definiert Tasks
- **PO (C)**: Wird konsultiert zu Priorisierungen (was ist wichtig zuerst?)
- **Sponsor (C)**: Wird konsultiert zu Abhängigkeiten / externen Constraints

#### **Code schreiben & Build**
- **Team (A)**: Trägt Verantwortung für Qualität & Delivery
- **PM (C)**: Wird konsultiert zu Blockers & Risks
- **PO & Sponsor (I)**: Werden regelmäßig informiert über Fortschritt

#### **Abnahme & Freigabe**
- **Sponsor (A)**: Trägt Verantwortung (Go/No-Go-Decision liegt bei ihm)
- **PO (A)** (gemeinsam mit Sponsor): Trägt Verantwortung für Akzeptanzkriterien erfüllt
- **PM (R)**: Organisiert Abnahme-Prozess, koordiniert Stakeholder
- **Team (C)**: Wird konsultiert zu offenen Bugs, Tech-Risks

---

### **Kommentar zur Lösung**

> **Wichtig**: RACI ist nicht starr! Je nach Org-Kultur kann das variieren. Manche Orgs haben:
> - **Sehr hierarchisch**: Sponsor hat mehr Accountability
> - **Sehr agil**: Team hat mehr Accountability
> - **Hybrid**: Mix wie oben

> **Häufiger Fehler**: Zu viele **A**'s = Verantwortlichkeit diffus ("alle sind verantwortlich" = niemand ist verantwortlich). Idealerweise 1–2 Accountable pro Aktivität.

> **Best Practice**: Die Matrix sollte zu Projektstart kommuniziert werden. Konflikte entstehen oft, weil Rollen nicht klar sind. Mit expliziter RACI-Matrix: klare Erwartungen.

> **Tool-Tipp**: RACI-Matrix oft als Excel-Sheet oder Confluence-Seite dokumentiert. Sollte für alle Projektbeteiligten zugänglich sein.

---

---

## Aufgabe 3: Tailoring-Checkliste für Ihr Projekt

**Kontext**: Angenommen, Sie arbeiten an einem **Cloud-Migration-Projekt** (Umzug von lokaler Infrastruktur in die Cloud)

**Projekt-Parameter**:
- Anforderungen: Teilweise stabil (technisch), teilweise volatil (Geschäftsprozesse)
- Team: 15 Personen (teils IT, teils Business Analysten), über 2 Standorte verteilt
- Budget: €800k fixiert, aber mit 10% Kontingenzen
- Dauer: 12 Monate
- Stakeholder: 3 Geschäftsbereiche mit unterschiedlichen Anforderungen
- Regulierung: Datenschutz (DSGVO) und Audit-Anforderungen

---

**Aufgabenstellung**: Füllen Sie die Tailoring-Checkliste aus und entscheiden: Klassisch, Hybrid oder Agil?

---

### **Lösungsansatz – Ausgefüllte Checkliste**

| Faktor | Klassisch (1) | Agil (5) | Cloud-Migration Score | Begründung |
|---|---|---|---|---|
| **Anforderungsstabilität** | 1 (stabil) | 5 (volatil) | **2** | Technische Infrastruktur-Anforderungen stabil, aber Geschäftsprozesse müssen adaptiert werden |
| **Team-Größe** | 1 (>50 = klassisch) | 5 (5–10 = agil) | **3** | 15 Personen = mittel; klassische Struktur möglich, aber könnten auch in 3er-Agile-Pods arbeiten |
| **Co-location** | 1 (verteilt) | 5 (co-located) | **2** | 2 Standorte = etwas verteilt; nicht ideal für Agile |
| **Stakeholder-Einfachheit** | 1 (viele, konfliktreich) | 5 (wenige, klar) | **2** | 3 Geschäftsbereiche mit unterschiedlichen Prioritäten = komplex, eher klassisch |
| **Regulierung** | 1 (strict) | 5 (flexibel) | **1** | DSGVO + Audit = dokumentations-intensiv, wenig Spielraum für Agile Experimente |
| **Tech-Neuheit** | 1 (bewährt) | 5 (neu, experimentell) | **3** | Cloud ist bewährt (AWS, Azure), aber für diese Org neu → Learning Curve |
| **Budget-Flexibilität** | 1 (fix) | 5 (variabel) | **2** | €800k mit 10% Kontingenz = eher fix, wenig Spielraum |
| **Org-Agile-Reife** | 1 (keine) | 5 (fortgeschritten) | **2** | Klassische IT-Org, geringe Agile-Erfahrung |
| **Gesamt-Score** | **8** | **40** | **17** | **→ HYBRID** |

---

### **Interpretation und Empfehlung**

**Score 17 fällt in den Hybrid-Bereich (17–31).**

**Empfehlung: HYBRID-Ansatz (Phase-Gate mit agilen Elementen)**

---

### **Konkrete Hybrid-Umsetzung für Cloud-Migration**

```
Phase 1: ASSESSMENT & PLANNING (2 Monate) – klassisch
├─ Anforderungserfassung Alle 3 Geschäftsbereiche
├─ Cloud-Architektur Design
├─ Sicherheits- & Compliance-Audit
└─ Master-Projekt-Plan + Budget Freeze

↓ Gate-Review (Go/No-Go)

Phase 2: BUILD (6 Monate) – hybrid (agil intern)
├─ Agile Teams pro Geschäftsbereich
│  ├─ Team A (Finanzen): Sprint-basiert
│  ├─ Team B (HR): Sprint-basiert
│  └─ Team C (Operations): Sprint-basiert
├─ Zentrale Architektur-Governance (klassisch)
└─ Wöchentliche Sync-Meetings (klassisch)

↓ Gate-Review (Readiness for Pilot)

Phase 3: PILOT (2 Monate) – klassisch mit Tests
├─ Pilot in einer Geschäftseinheit
├─ Change Management & Training
└─ Full Readiness Assessment

↓ Gate-Review (Go/No-Go for Full Migration)

Phase 4: PRODUCTION-ROLLOUT (2 Monate) – klassisch
├─ Staggered Migration (Phase für Phase)
├─ Parallel Running (Alt + Neu läuft parallel)
└─ Go-Live Cutover

Gesamt: 12 Monate
```

**Warum Hybrid hier besser ist als rein Klassisch oder Agil**:

✅ **Klassische Gate-Phase**: Anforderungen & Architektur brauchen Stabilität (Foundations)  
✅ **Agile Build-Phase**: Teams können ihre Arbeit selbst organisieren, schneller innovieren  
✅ **Klassische Pilot-Phase**: Audit & Compliance brauchen Dokumentation & Struktur  
✅ **Klassiche Go-Live**: Risiko zu hoch für experimentelle Agile-Dynamik  

---

### **Kommentar zur Lösung**

> **Typischer Fehler #1**: "Wir machen ALLES agil!" → Problem: Compliance-Anforderungen + Multi-Stakeholder-Konflikt passen nicht zu 2-Wochen-Sprints ohne klare Governance.

> **Typischer Fehler #2**: "Wir machen ALLES klassisch wie immer!" → Problem: Teams sind blockiert durch hierarchische Entscheidungsprozesse; Innovationen dauern lang.

> **Best Practice**: Hybrid = Struktur an den kritischen Gates (klassisch), Flexibilität in der Ausführung (agil). Zentrale Architektur-Governance (klassisch), aber operative Teams arbeiten selbstorganisiert (agil).

> **Governance-Modell**:
> - Wöchentliche **Steering-Meetings** (klassisch, klassische Rollen)
> - Tägliche **Team Standups** (agil, pro Team)
> - Bi-wöchentliche **Integrations-Syncs** zwischen Teams (klassisch-agil Mix)
> - Monatliche **Phase-Gate-Reviews** (klassisch, Sponsor/Lenkungs ausschuss)

> **Tool-Auswahl**: MS Project für Master-Plan (klassisch), Jira für Team-Sprints (agil), Confluence für Architektur-Docs (klassisch).

---

---

## Zusammenfassung – Häufige Fehler & Best Practices

### **Fehler 1: Dogmatismus statt Pragmatismus**

**Fehler**: "Wir sind jetzt agil – daher KEIN Plan, KEINE Dokumentation, KEINE Governance!"

**Reality-Check**: Auch Agile Teams brauchen Planung. Es ist nur weniger dokumentiert und mehr emergent.

**Best Practice**: Tailoring nach Kontext, nicht nach Dogma.

---

### **Fehler 2: Rollen-Verwirrung**

**Fehler**: "Der PM ist auch der PO ist auch der Sponsor..."

**Problem**: Interessenskonflikte, keine klare Verantwortlichkeit

**Best Practice**: RACI-Matrix aufstellen. Klare Rollen. In kleinen Teams OK, dass eine Person mehrere Rollen trägt – aber dann explizit machen!

---

### **Fehler 3: Keine Anpassung an Org-Reife**

**Fehler**: "Agile für ein konservatives Versicherungsunternehmen einführen, das noch nie Agile gemacht hat."

**Problem**: Kulturschock, Widerstände, Misserfolg

**Best Practice**: Agile-Transformation braucht Zeit (12–24 Monate). Hybrid-Phasen helfen beim Übergang.

---

### **Fehler 4: Zu viele Standards / Frameworks zur selben Zeit**

**Fehler**: "Wir lernen PMBOK UND PRINCE2 UND Scrum UND SAFe..."

**Problem**: Verwirrung, keine Tiefe

**Best Practice**: Eins lernen gründlich (z. B. PMBOK oder Scrum). Danach Hybrid-Kombinationen. Standards sind Werkzeuge, nicht Religion.

---

### **Best Practice: Methodenwahl nach Kontext (Checkliste)**

Bevor Sie eine Methode wählen, fragen Sie:

1. **Anforderungs-Klarheit?** Klar (klassisch) oder unklar (agil)?
2. **Größe & Struktur?** Viele Leute (klassisch) oder Team (agil)?
3. **Budget sicher?** Fix (klassisch) oder Variabel (agil)?
4. **Regulierung?** Strict (klassisch) oder flexibel (agil)?
5. **Org-Reife?** Neue Org (klassisch/hybrid) oder Agile-erfahren (agil)?

**Wenn 3+ "klassisch"**: → Klassisch  
**Wenn 3+ "agil"**: → Agil  
**Gemischt**: → Hybrid

---

## Glossar – Wichtige Begriffe

| Begriff | Definition |
|---|---|
| **Accountability (A)** | Trägt Verantwortung für das Ergebnis; wird verantwortlich gemacht |
| **Agil** | Flexibel, adaptiv, iterativ; schnelle Anpassung an Veränderungen |
| **Backlog** | Priorisierte Liste aller Anforderungen / User Stories |
| **Change Management** | Prozess, Änderungen im Projekt kontrolliert umzusetzen |
| **Kanban** | Agile Methode mit kontinuierlichem Durchsatz, WIP-Limitierung |
| **Klassisch / Wasserfall** | Sequenzielle, phasenweise Abarbeitung; Plan vor Execution |
| **Hybrid** | Kombination aus klassischen und agilen Elementen |
| **IPMA** | International Project Management Association (europäischer Standard) |
| **PMBOK** | Project Management Body of Knowledge (Standard der PMI, 10 Knowledge Areas) |
| **PRINCE2** | UK-Standard für Projektmanagement (stark Governance- und Prozess-fokussiert) |
| **Product Owner (PO)** | Agile Rolle; vertritt Kundenperspektive, priorisiert Backlog |
| **RACI** | Verantwortlichkeits-Matrix (Responsible, Accountable, Consulted, Informed) |
| **Scrum** | Agiles Framework mit 2–4 Wochen Sprints, tägliche Standups, Reviews |
| **Scope Creep** | Unkontrolliertes Hinzufügen von Anforderungen |
| **Sprint** | Iterationszyklus in Agil (üblicherweise 2–4 Wochen) |
| **Stakeholder** | Personen mit Interesse am Projekt (Kunden, Sponsor, Team, Partner) |
| **Tailoring** | Anpassung von PM-Methoden an den konkreten Projektkontext |
| **User Story** | Anforderung aus Kundenperspektive ("Als Kunde möchte ich X, damit Y") |

---

*Zusammengestellt von: Projektmanagement-Team*  
*Stand: November 2025*