## Aufgabe 1: Methodenwahl für Projektszenarien

### Szenario A: SAP-Rollout in großem Konzern

**Projekt-Parameter**:
- Anforderungen: Hart definiert, Customizing-Konfiguration
- Team: 80 Personen, global verteilt
- Budget: €5 Mio fixiert
- Dauer: 18 Monate

---

### Lösung A

**Antwort: Klassisches Projektmanagement (evtl. mit hybriden Elementen)**

**Begründung nach Kontextfaktoren**:

| Faktor | Analyse | Bewertung |
|---|---|---|
| **Anforderungsstabilität** | SAP-Best-Practices sind vordefiniert. Anforderungen sind STABIL. | ✅ Klassisch |
| **Team-Größe** | 80 Personen = zu groß für Scrum (max. 9–10). Zentrale Governance nötig. | ✅ Klassisch |
| **Budget-Fixierheit** | €5 Mio fixiert. Abweichungen sehr teuer. Budget MUSS geschützt sein. | ✅ Klassisch |
| **Timeline** | 18 Monate, Go-Live ist festes Datum (oft Geschäftsjahreswechsel). | ✅ Klassisch |
| **Regulierung** | SAP-Rollouts haben Audit- & Compliance-Anforderungen. Dokumentation nötig. | ✅ Klassisch |
| **Org-Struktur** | Konzern = hierarchisch, klassisch-reif. Agile-Erfahrung niedrig. | ✅ Klassisch |

**Empfohlene Phasen**:

```
Phase 1: Anforderungen (Requirements)
  → Business Requirements Document (BRD)
  
Phase 2: Design & Konfiguration
  → SAP-Design-Document, Customizing-Liste
  
Phase 3: Test
  → Test-Protokolle, UAT (User Acceptance Testing)
  
Phase 4: Go-Live & Cutover
  → Formaler Go-Live, parallel running evtl. 1–2 Wochen
```

---

> **Kommentar: Typische Anfängerfehler vermeiden**
>
> ❌ **Fehler 1**: „SAP ist technisch, also agil!" 
> → **Realität**: Anforderungen sind hart definiert (Best Practices). Nur Konfiguration ist variabel.
>
> ❌ **Fehler 2**: Scrum mit 80 Personen versuchen
> → **Realität**: Mit 80 Personen funktioniert reines Scrum nicht. Braucht zentrale Koordination (SAFe oder klassisches Phase-Gate).
>
> ❌ **Fehler 3**: Wenig Dokumentation, viel Experimentation
> → **Realität**: SAP-Rollouts brauchen präzise Dokumentation (Audit, Change Management, Knowledge Transfer).
>
> ✅ **Best Practice**: **Phase-Gate-Modell** mit Gate-Reviews nach jeder Phase. Teams arbeiten in klassischen Workstreams (Finanzen, HR, Materialwirtschaft), nicht in Sprints. Innerhald jeder Phase könnte man Kanban nutzen (kontinuierliche Testabdeckung), aber Grundstruktur bleibt klassisch.

---

---

### Szenario B: Startup-App Entwicklung

**Projekt-Parameter**:
- Anforderungen: Unklar, MVP muss schnell entstehen
- Team: 5 Entwickler, co-located
- Budget: Variabel (Investoren finanzieren)
- Dauer: 8 Wochen bis MVP

---

### Lösung B

**Antwort: Agiles Projektmanagement (Scrum mit 2-Wochen-Sprints)**

**Begründung nach Kontextfaktoren**:

| Faktor | Analyse | Bewertung |
|---|---|---|
| **Anforderungsstabilität** | Startup = unklar, Pivot-Risiko. MVP wird iterativ verstanden. | ✅ Agil |
| **Team-Größe** | 5 Entwickler = ideal für Scrum. Klein genug für tägliche Sync. | ✅ Agil |
| **Budget-Flexibilität** | Variabel; schneller Markteintritt > Kostenplan. | ✅ Agil |
| **Timeline** | 8 Wochen kurz; warum klassisch planen statt schnell iterieren? | ✅ Agil |
| **Org-Kultur** | Startups sind meist agil-native, schnelle Decisions möglich. | ✅ Agil |
| **Stakeholder** | Klein & klar: CEO = PO, Team = Dev Team. Wenig Bureaucracy. | ✅ Agil |

**Empfohlener Sprint-Plan** (8 Wochen = 4 Sprints à 2 Wochen):

```
Sprint 1–2: MVP-Kernfunktionalität
  - User Registration & Login
  - Core Feature (z.B. Produkt-Katalog)
  - Payment Integration Basic
  
Sprint 3–4: Erweiterte Features + QA
  - Erweiterte Such- und Filterfunktionen
  - Performance-Optimierung
  - Bug-Fixes, Stress-Testing
  
Woche 7–8: Polish, Launch-Vorbereitung, Beta-Feedback

Go-Live: Woche 9 (Buffer-Woche für Notfall-Fixes)
```

---

> **Kommentar: Typische Anfängerfehler vermeiden**
>
> ❌ **Fehler 1**: „Wir brauchen perfekte Planung für 8 Wochen"
> → **Realität**: MVP = Minimum Viable Product. 80% Features, 20% Zeit/Budget. Perfektionismus = Tod des Startups.
>
> ❌ **Fehler 2**: Keine Iterationen mit Investoren/Usern
> → **Realität**: Nach jedem Sprint feedback einholen. Nach 2–3 Wochen solltest du schon mit realen Usern testen.
>
> ❌ **Fehler 3**: Scrum-Prozess zu streng, nicht agil genug
> → **Realität**: Scrum ist ein Rahmen. Ändere ihn! Wenn täglich Standup nicht hilft → weglassen. Wenn Retrospektive zu lang → kürzen. Agile ist pragmatisch.
>
> ✅ **Best Practice**: **Scrum mit täglichem Standup (15 Min), Sprint Planning (Montag 1 Std), Sprint Review (Freitag 1 Std), Retrospektive (Freitag 30 Min)**. Product Owner sollte Founder sein oder einen Senior Product Manager. Nach jedem Sprint: echtes Feedback von Beta-Usern einholen und Backlog anpassen.

---

---

## Aufgabe 2: Rollen-Klärungs-Workshop – RACI-Matrix

**Kontext**: Website-Relaunch für E-Commerce-Unternehmen

---

### Lösung – RACI-Matrix ausgefüllt

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

---

### Erklärung der Zuweisungen

**Strategie definieren**
- **Sponsor (A)**: Trägt Verantwortung für strategische Alignierung
- **PM (C)**: Wird konsultiert, ob strategische Ziele machbar sind
- **PO (C)**: Gibt Kundenperspektive ein
- **Team (I)**: Wird später informiert über Strategic Priorities

**Business Case / Budget**
- **Sponsor (A)**: Trägt Verantwortung (es ist SEIN Budget!)
- **PM (R)**: Erstellt Business Case, kalkuliert Kosten & Nutzen
- **PO (C)**: Gibt Kundenperspektive ein
- **Team (I)**: Wird informiert über verfügbares Budget

**Anforderungen sammeln**
- **PO (A)**: Trägt Verantwortung für Anforderungen (Kundenperspektive)
- **PM (C)**: Wird konsultiert zu Priorisierung & Machbarkeit
- **Sponsor (I)**: Wird informiert, was geplant ist
- **Team (C)**: Gibt technisches Input (ist das möglich? Aufwand?)

**User Stories schreiben**
- **PO (A)**: Trägt Verantwortung (Story-Qualität, Akzeptanzkriterien)
- **Team (R)**: Schreibt technische Details, fragt Rückfragen
- **PM (C)**: Wird konsultiert zur Priorisierung
- **Sponsor (I)**: Wird informiert

**Zeitplan erstellen**
- **PM (A)**: Trägt Verantwortung für Planung
- **Team (R)**: Erstellt Schätzungen, definiert Tasks
- **PO (C)**: Wird konsultiert zu Priorisierungen (was ist wichtig zuerst?)
- **Sponsor (C)**: Wird konsultiert zu externen Constraints

**Technisches Design**
- **Team (A)**: Trägt Verantwortung für Architektur & Tech Decisions
- **PM (C)**: Wird konsultiert zu Blockers & Risks
- **PO (C)**: Wird konsultiert zu Non-Funktionalen Requirements
- **Sponsor (I)**: Wird informiert

**Code schreiben & Build**
- **Team (A)**: Trägt Verantwortung für Code-Qualität & Delivery
- **PM (C)**: Wird konsultiert zu Blockers & Risks
- **PO & Sponsor (I)**: Werden regelmäßig informiert über Fortschritt

**Quality Assurance / Test**
- **Team (A)**: Trägt Verantwortung für Testabdeckung & Bug-Fixing
- **PO (C)**: Wird konsultiert zu User-Szenarien & Akzeptanzkriterien
- **PM (C)**: Wird konsultiert zu Test-Planung & -Coverage
- **Sponsor (I)**: Wird informiert über Test-Status

**Abnahme & Freigabe**
- **Sponsor (A)**: Trägt Verantwortung (Go/No-Go-Decision liegt bei ihm!)
- **PO (A)**: Trägt Verantwortung für Akzeptanzkriterien erfüllt
- **PM (R)**: Organisiert Abnahme-Prozess, koordiniert Stakeholder
- **Team (C)**: Wird konsultiert zu offenen Bugs, Tech-Risks

---

> **Kommentar: Typische Anfängerfehler vermeiden**
>
> ❌ **Fehler 1**: Zu viele **A**s in einer Aktivität
> → **Problem**: Verantwortlichkeit diffus. Wenn alle verantwortlich sind, ist niemand verantwortlich.
> → **Best Practice**: Pro Aktivität max. 1–2 Accountables.
>
> ❌ **Fehler 2**: RACI nicht kommuniziert
> → **Problem**: Konflikte entstehen, weil Rollen unklar sind.
> → **Best Practice**: RACI-Matrix zu Projektstart allen zeigen. Diskutieren, ggf. anpassen.
>
> ❌ **Fehler 3**: RACI zu starr
> → **Realität**: RACI kann sich während des Projekts ändern! Z. B. wenn Sponsor weniger verfügbar ist → PM übernimmt mehr Accountability.
> → **Best Practice**: RACI ist lebend, wird regelmäßig reflektiert.
>
> ✅ **Best Practice**: RACI-Matrix in Confluence/Wiki dokumentieren. Mit Erklärung nach Aktivität. Bei Unklarheiten: Kurze 1-on-1 mit Stakeholder klären, statt rumzurätseln.

## Aufgabe 3: Tailoring-Checkliste – Cloud-Migration

**Kontext**: Cloud-Migration-Projekt (12 Monate, €800k, 15 Personen verteilt, 3 Geschäftsbereiche, DSGVO + Audit)

---

### Lösung – Ausgefüllte Checkliste

| Faktor | Klassisch (1) | Agil (5) | Score Cloud-Projekt | Begründung |
|---|---|---|---|---|
| **Anforderungsstabilität** | 1 (stabil) | 5 (volatil) | **2** | Technische Anforderungen stabil (Cloud-Infrastruktur), aber Geschäftsprozesse adaptierungsbedürftig |
| **Team-Größe** | 1 (>50) | 5 (5–10) | **3** | 15 Personen = mittel; können in 3er-Agile-Pods arbeiten, aber zentrale Koordination nötig |
| **Co-location** | 1 (verteilt) | 5 (co-located) | **2** | 2 Standorte = etwas verteilt; nicht ideal für tägliche Standups |
| **Stakeholder-Einfachheit** | 1 (viele) | 5 (wenige, klar) | **2** | 3 Geschäftsbereiche mit unterschiedlichen Prioritäten = komplex |
| **Regulierung** | 1 (strict) | 5 (flexibel) | **1** | DSGVO + Audit = dokumentations-intensiv, wenig Spielraum für experimentelle Agile |
| **Tech-Neuheit** | 1 (bewährt) | 5 (neu) | **3** | Cloud ist bewährt (AWS, Azure), aber für diese Org neu → Learning Curve |
| **Budget-Flexibilität** | 1 (fix) | 5 (variabel) | **2** | €800k mit 10% Kontingenz = eher fix, wenig Spielraum |
| **Org-Agile-Reife** | 1 (keine) | 5 (fortgeschritten) | **2** | Klassische IT-Org, geringe Agile-Erfahrung |
| **Gesamt-Score** | **8** | **40** | **17** | **→ HYBRID empfohlen** |

---

### Empfehlung: HYBRID-Ansatz (Phase-Gate mit agilen Elementen)

**Begründung** (Auszug):

Der Score 17 fällt in den Hybrid-Bereich (17–31). Dies ist optimal, da:

1. **Stabile technische Anforderungen** brauchen klassische Planung (Architektur, Security, Compliance)
2. **Volatile Geschäftsprozesse** brauchen agile Flexibilität (Sprint-basierte Anpassung)
3. **3 Geschäftsbereiche** mit unterschiedlichen Prioritäten brauchen zentrale Governance (klassisch) + operative Selbstorganisation (agil)
4. **DSGVO + Audit** brauchen Dokumentation und Gateways (klassisch)
5. **Multi-Standort-Team** kann nicht vollständig agil arbeiten; braucht Struktur

**Konkrete Hybrid-Struktur**:

```
Phase 1: ASSESSMENT & PLANNING (2 Mo) – klassisch
├─ Anforderungserfassung Alle 3 Geschäftsbereiche
├─ Cloud-Architektur & Security-Design
├─ Compliance-Audit (DSGVO)
└─ Master-Projekt-Plan + Budget Freeze
├─ GATE-REVIEW (Go/No-Go)

Phase 2: BUILD (6 Mo) – hybrid (agil intern)
├─ 3 Agile Teams pro Geschäftsbereich
│  ├─ Team Finance: Sprint 1–6 (2-Wo-Sprints)
│  ├─ Team HR: Sprint 1–6
│  └─ Team Operations: Sprint 1–6
├─ Zentrale Architektur-Governance (klassisch)
├─ Wöchentliche Sync-Meetings (klassisch)
└─ Bi-wöchentliche Integrations-Reviews (hybrid)
├─ GATE-REVIEW (Readiness for Pilot)

Phase 3: PILOT (2 Mo) – klassisch mit Tests
├─ Pilot in einer Geschäftseinheit
├─ Parallel Running (Alt + Neu läuft parallel)
├─ Change Management & Training
└─ Full Readiness Assessment
├─ GATE-REVIEW (Go/No-Go for Full Migration)

Phase 4: PRODUCTION-ROLLOUT (2 Mo) – klassisch
├─ Staggered Migration (Phase für Phase)
├─ Contingency Planning
└─ Go-Live Cutover + Support
```

**Governance-Modell**:
- **Monatliche Phase-Gate-Reviews** (klassisch, Sponsor/Lenkungsausschuss) → Go/No-Go
- **Wöchentliche Steering-Meetings** (klassisch, PM + POs + Sponsor) → Statuscheck
- **Tägliche Team Standups** (agil, pro Team) → Synchronisation
- **Bi-wöchentliche Integrations-Syncs** (hybrid) → Abhängigkeiten klären

**Tool-Auswahl**:
- **Master-Plan**: MS Project (klassisch)
- **Team-Sprints**: Jira (agil)
- **Architektur-Docs**: Confluence (klassisch)
- **Compliance-Tracking**: Excel-Register (klassisch)

---

> **Kommentar: Typische Anfängerfehler vermeiden**
>
> ❌ **Fehler 1**: "Wir sind jetzt agil – daher KEIN Plan, KEINE Governance!"
> → **Problem**: Mit 3 Geschäftsbereichen + Regulierung funktioniert das nicht.
> → **Best Practice**: Hybrid = Struktur an kritischen Gates (klassisch), Flexibilität in der Ausführung (agil).
>
> ❌ **Fehler 2**: "ALLE Teams parallel in Sprints – wir checken am Ende ab"
> → **Problem**: Integrations-Fehler werden spät entdeckt (teuer).
> → **Best Practice**: Bi-wöchentliche Integrations-Syncs = frühe Fehler-Erkennung.
>
> ❌ **Fehler 3**: "Agile braucht keine Dokumentation"
> → **Problem**: DSGVO + Audit brauchen Dokumentation. Punkt.
> → **Best Practice**: Agile Teams dokumentieren kontinuierlich (Definition of Done: "Code + Doc + Test").
>
> ❌ **Fehler 4**: Zu starre oder zu lockere Phasen-Gates
> → **Problem**: Zu streng = Waterfall-Lähmung. Zu locker = keine Kontrolle.
> → **Best Practice**: Gate-Kriterien klar, aber Einspruchsprozess möglich (z. B. „Wenn Tech-Risiko neu auftaucht → Welle verlängern, aber nur mit Sponsor-Approval").
>
> ✅ **Best Practice**: Hybrid-Modell erlaubt klassische Stabilität + agile Flexibilität. Zentrale Governance schützt Compliance & Budget. Operative Teams haben Freiraum. Regelmäßige Gate-Reviews halten Projekt auf Kurs.

---

---

## Zusammenfassung – Häufige Anfängerfehler & Quick-Fixes

### Fehler 1: Dogmatismus statt Pragmatismus

**Fehler**: „Wir sind Agile – daher NO Pläne, NO Governance, NO Dokumentation!"

**Problem**: Funktioniert nur in kleinen, erfahrenen Startups, nicht in Konzernen oder regulierten Umgebungen.

**Quick-Fix**: Tailoring nach Kontext, nicht nach Dogma. Hybrid ist oft die Lösung.

---

### Fehler 2: Rollen-Verwirrung

**Fehler**: „Der PM ist auch der PO ist auch der Sponsor..."

**Problem**: Interessenskonflikte, keine klare Verantwortlichkeit.

**Quick-Fix**: RACI-Matrix aufstellen. Klare Rollen. In kleinen Teams OK, dass eine Person mehrere Rollen trägt – aber dann explizit!

---

### Fehler 3: Methodenwahl vor Analyse

**Fehler**: „Scrum ist trendy, also machen wir Scrum!" (ohne zu checken, ob es passt)

**Problem**: Scheitern garantiert, wenn Anforderungen fix und Budget zu klein sind.

**Quick-Fix**: Zuerst Kontext analysieren (Checkliste nutzen), dann Methode wählen.

---

### Fehler 4: Zu viele Standards zur selben Zeit

**Fehler**: „Wir lernen PMBOK UND PRINCE2 UND Scrum UND SAFe..."

**Problem**: Verwirrung, keine Tiefe.

**Quick-Fix**: Eins lernen gründlich. Danach gezielt Hybride kombinieren.

---

## Quick-Entscheidung: Klassisch vs. Agil vs. Hybrid?

**Wenn du 2 Min Zeit hast**:

| Frage | Klassisch | Agil | Hybrid |
|---|---|---|---|
| Anforderungen klar? | JA | NEIN | TEILWEISE |
| Budget fix? | JA | NEIN | TEILWEISE |
| Team klein (5–10)? | NEIN | JA | TEILWEISE |
| Regulierung strict? | JA | NEIN | TEILWEISE |
| Schnell Feedback nötig? | NEIN | JA | TEILWEISE |

**Dominiert „Klassisch"** → klassisches PM  
**Dominiert „Agil"** → agiles PM  
**Gemischt oder viel „Teilweise"** → HYBRID

---

## Glossar – Fachbegriffe

| Begriff                | Definition                                      |
| ---------------------- | ----------------------------------------------- |
| **Accountability (A)** | Trägt Verantwortung für das Ergebnis            |
| **Agil**               | Flexibel, adaptiv, iterativ; schnelle Anpassung |
| **Backlog**            | Priorisierte Liste von Anforderungen            |
| **Hybrid**             | Kombination klassischer + agiler Elemente       |
| **Kanban**             | Agile Methode mit kontinuierlichem Durchsatz    |
| **Klassisch**          | Sequenzielle, phasenweise Abarbeitung           |
| **PMBOK**              | Project Management Body of Knowledge (PMI)      |
| **RACI**               | Responsibility Matrix (R/A/C/I)                 |
| **Scrum**              | Agiles Framework (2–4 Wo Sprints)               |
| **Tailoring**          | Anpassung von PM-Methoden an Kontext            |
| **User Story**         | Anforderung aus Kundenperspektive               |
