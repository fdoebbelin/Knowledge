## Lösung zu Aufgabe 1: Ressourcentypen klassifizieren

### Musterlösung

| **Nr.** | **Ressource** | **Kategorie** | **Qualifikation (bei HR)** | **Besonderheiten** |
|---|---|---|---|---|
| 1 | Projektleiter | **HR** | PM-Qualifikation, Erfahrung in ähnlichen Projekten | Kritische Ressource; höchste Kosten |
| 2 | Zwei iOS-Entwickler | **HR** | iOS/Swift-Entwicklung, Mobile Development | Spezialisiert; schwer zu beschaffen |
| 3 | Figma Professional | **MR** | — (Tool) | Verbrauchsmaterial/Lizenz |
| 4 | Cloud-Server | **MR** | — (Infrastructure) | Infrastruktur; variable Kosten |
| 5 | Vier Senior-Developer | **HR** | Hohe Expertise, Architektur-Kenntnisse | Teuer, aber notwendig für Qualität |
| 6 | Security-Audit (€ 15.000) | **FR** | — (Externe Dienstleistung) | Budgetposten; externe Expertise |
| 7 | Laptops (2 × MacBook) | **MR** | — (Hardwareausstattung) | Kapitalinvestition; Verschleiß |
| 8 | QA-Tester (3 Personen) | **HR** | QA-Expertise, Testmethoden | Notwendig für Qualitätssicherung |
| 9 | Agile-Training (€ 8.000) | **FR** | — (Qualifizierungsbudget) | Investition in Kompetenz; indirekt |
| 10 | API-Lizenz | **MR** | — (Externe Software/Service) | Lizenzgebühr; Abhängigkeit |
| 11 | Büroräume & Infrastruktur | **MR** | — (Organisationsstruktur) | Overhead; oft unterschätzt |
| 12 | Junior-Developer | **HR** | Grundkenntnisse, Lernwilligkeit | Günstiger; benötigt Anleitung |

---

### Kommentar

> **Kommentar:** Diese Klassifizierung zeigt ein typisches Projekt-Portfolio: **Humanressourcen (HR)** sind der größte Kostenfaktor (ca. 60–70%), gefolgt von Materialien (Infrastruktur, Tools, Hardware) und Finanzbudgets für Externe/Training. 
>
> **Wichtig für Anfänger:** 
> - HR-Ressourcen sind schwer austauschbar und längerfristig verhandelbar (Verträge, Verfügbarkeit)
> - MR (Material) sind oft bestellbar, haben aber Lieferzeiten
> - FR (Finance) sind begrenzt – hier wird oft zuerst gespart, was riskant ist!
>
> **Häufiger Fehler:** Anfänger vergessen, dass auch Overhead wie Büroraum, Hardware, Lizenzen gemanagt werden müssen. "Ich brauche 6 Entwickler" reicht nicht – "Ich brauche 6 Entwickler + 6 Laptops + Lizenzen + Büroraum" ist realistischer.

---

**Reflexionsfrage – Musterbeantwortung:**

*Welche Ressourcen sind kritisch für Projekterfolg?*

**Antwort:**
1. **iOS-Entwickler** – Spezialisiert; schwer zu finden
2. **Projektleiter** – Ohne gutes PM kann das Projekt scheitern
3. **Senior-Developer** – Für Qualität und Architektur essentiell
4. **Cloud-Server** – Ohne Test-Infrastruktur kein Testen möglich
5. **QA-Tester** – Qualität ist entscheidend vor Go-Live

Weniger kritisch: Büroraum, Trainings (können nachgelagert sein).

---

## Lösung zu Aufgabe 2: Kapazitätsplanung

### Musterlösung

**Schritt 1: Verfügbare Kapazität berechnen**

- **Max:** 40h/Woche × 12 Wochen × 100% = **480h verfügbar**
- **Anna:** 40h/Woche × 12 Wochen × 50% = **240h verfügbar**
- **Tom:** 
  - Wochen 1–6: 40h × 6 = 240h
  - Wochen 7–12: 20h × 6 = 120h (nur noch 50% = 20h/Woche)
  - **Gesamt: 360h verfügbar**

---

**Schritt 2: Erforderliche Kapazität pro Aktivität**

| **Aktivität** | **Wochen** | **h/Woche** | **Anzahl Wochen** | **Gesamt** | **Ressource** |
|---|---|---|---|---|---|
| Anforderungen | 1–2 | 10h | 2 | 20h | Anna |
| Design Desktop | 2–4 | 30h | 3 | 90h | Tom |
| Design Mobile | 5–6 | 25h | 2 | 50h | Tom |
| Frontend | 5–8 | 35h | 4 | 140h | Max |
| Backend | 7–10 | 40h | 4 | 160h | Max |
| Testing | 10–11 | 15h | 2 | 30h | Anna |
| Deployment | 12 | 10h | 1 | 10h | Anna |

**Summe erforderlich:**
- Max: 140h + 160h = **300h** (von 480h verfügbar)
- Anna: 20h + 30h + 10h = **60h** (von 240h verfügbar)
- Tom: 90h + 50h = **140h** (von 360h verfügbar)

---

**Schritt 3: Wochenbelastungs-Tabelle**

| **Woche** | **Max verfügbar** | **Max geplant** | **Status** | **Anna verfügbar** | **Anna geplant** | **Status** | **Tom verfügbar** | **Tom geplant** | **Status** |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 40h | 0h | ✅ OK | 20h | 10h | ✅ OK | 40h | 0h | ✅ OK |
| 2 | 40h | 0h | ✅ OK | 20h | 10h | ✅ OK | 40h | 30h | ✅ OK |
| 3 | 40h | 0h | ✅ OK | 20h | 0h | ✅ OK | 40h | 30h | ✅ OK |
| 4 | 40h | 0h | ✅ OK | 20h | 0h | ✅ OK | 40h | 30h | ✅ OK |
| 5 | 40h | 35h | ✅ OK | 20h | 0h | ✅ OK | 40h | 25h | ✅ OK |
| 6 | 40h | 35h | ✅ OK | 20h | 0h | ✅ OK | 40h | 25h | ✅ OK |
| 7 | 40h | 75h | ⚠️ **ENGPASS** | 20h | 0h | ✅ OK | 20h | 0h | ✅ OK |
| 8 | 40h | 75h | ⚠️ **ENGPASS** | 20h | 0h | ✅ OK | 20h | 0h | ✅ OK |
| 9 | 40h | 40h | ✅ OK | 20h | 0h | ✅ OK | 20h | 0h | ✅ OK |
| 10 | 40h | 40h | ✅ OK | 20h | 15h | ✅ OK | 20h | 0h | ✅ OK |
| 11 | 40h | 0h | ✅ OK | 20h | 15h | ✅ OK | 20h | 0h | ✅ OK |
| 12 | 40h | 0h | ✅ OK | 20h | 10h | ✅ OK | 20h | 0h | ✅ OK |

---

**Schritt 4: Engpässe identifiziert**

🚨 **Kritische Engpässe:**

**Woche 7:**
- **Max:** Geplant 75h (35h Frontend + 40h Backend), verfügbar nur 40h
- **Differenz:** 35h Überbelastung!

**Woche 8:**
- **Max:** Geplant 75h (35h Frontend + 40h Backend), verfügbar nur 40h
- **Differenz:** 35h Überbelastung!

**Gesamt fehlende Kapazität:** 35h + 35h = **70 Stunden fehlen bei Max!**

---

### Kommentar

> **Kommentar:** Der Plan zeigt einen **kritischen Engpass bei Max in den Wochen 7 und 8**. Das liegt daran, dass:
>
> 1. **Frontend (Wochen 5–8)** und **Backend (Wochen 7–10)** sich überlappen
> 2. In den Wochen 7–8 laufen beide Aktivitäten parallel: 35h + 40h = 75h/Woche
> 3. Max hat aber nur 40h/Woche verfügbar → **35h Überbelastung pro Woche!**
>
> **Das ist eine realistische Problemstellung für Aufgabe 3 (Ressourcen-Leveling).**
>
> **Positive Aspekte:**
> - Anna und Tom sind gut ausgelastet, aber nicht überlastet
> - Die meisten Wochen sind konfliktfrei
> - Es gibt nur einen klar definierten Engpass (2 Wochen, 1 Person)
>
> **Häufiger Fehler bei Anfängern:** 
> - Sie sehen "Max ist zu 75h geplant" und denken "Das ist halt so, er soll mehr arbeiten"
> - Das ist NICHT nachhaltig! Überbelastung führt zu Burnout, Fehlern, Qualitätsproblemen
> - Oder sie vergessen, die Überlappung zu erkennen: "Frontend und Backend können doch parallel laufen!" – Ja, aber nicht mit derselben Person!

---

**Reflexionsfragen – Musterbeantwortung:**

*In welcher Woche gibt es die größte Überbelastung?*

**Antwort:** **Wochen 7 und 8** – Max hat jeweils 75h geplant, aber nur 40h verfügbar. Das sind **35h Überbelastung pro Woche** (87,5% über Kapazität!).

*Welche Person ist der Bottleneck (Engpass) im Projekt?*

**Antwort:** **Max** ist der Bottleneck. Er ist der einzige Entwickler und muss sowohl Frontend als auch Backend durchführen. Wenn er ausfällt oder die Überlappung nicht aufgelöst wird, verzögert sich das Projekt massiv.

*Wie viele Stunden fehlen insgesamt?*

**Antwort:** **70 Stunden** fehlen bei Max (35h in Woche 7 + 35h in Woche 8).

---

## Lösung zu Aufgabe 3: Ressourcen-Leveling

### Musterlösung

**Schritt 1: Engpass-Analyse**

Aus Aufgabe 2:
- **Wochen 7–8:** Max hat 75h geplant, aber nur 40h verfügbar
- **Fehlende Kapazität:** 70h gesamt (35h pro Woche)

---

**Schritt 2: Leveling-Strategien entwickeln**

| **Engpass** | **Gewählte Strategie** | **Begründung** | **Konkrete Umsetzung** |
|---|---|---|---|
| **Woche 7–8: Max (75h geplant, 40h verfügbar)** | **Option A: Backend später starten** | Backend hat keine harte Abhängigkeit zu Frontend; kann zeitlich verschoben werden | Backend startet in Woche 9 statt Woche 7. Damit läuft Frontend allein in Wochen 7–8 (35h), Backend allein in Wochen 9–12 (40h). |
| | **Alternative: Frontend/Backend aufteilen** | Wenn ein Junior-Developer verfügbar ist, könnte dieser einfache Backend-Aufgaben übernehmen | Felix (Junior) übernimmt in Wochen 7–8 einfache Backend-Tasks (10h/Woche), Max macht komplexe Backend-Architektur (30h) + Frontend (35h) = passt nicht! Zu kompliziert. |
| | **Empfehlung: Option A** | Einfachste Lösung; kein neuer Mitarbeiter nötig; Projekt bleibt im Zeitrahmen | Backend wird um 2 Wochen nach hinten verschoben. |

---

**Schritt 3: Neuer Wochenbelastungsplan (nach Leveling mit Option A)**

**Änderung:** Backend startet in Woche 9 (statt Woche 7) und läuft bis Woche 12 (statt Woche 10).

| **Woche** | **Max verfügbar** | **Max geplant (neu)** | **Status** | **Aktivitäten** |
|---|---|---|---|---|
| 1 | 40h | 0h | ✅ OK | — |
| 2 | 40h | 0h | ✅ OK | — |
| 3 | 40h | 0h | ✅ OK | — |
| 4 | 40h | 0h | ✅ OK | — |
| 5 | 40h | 35h | ✅ OK | Frontend |
| 6 | 40h | 35h | ✅ OK | Frontend |
| 7 | 40h | **35h** | ✅ OK | **Frontend (Backend verschoben!)** |
| 8 | 40h | **35h** | ✅ OK | **Frontend (Backend verschoben!)** |
| 9 | 40h | **40h** | ✅ OK | **Backend startet** |
| 10 | 40h | **40h** | ✅ OK | **Backend** |
| 11 | 40h | **40h** | ✅ OK | **Backend** |
| 12 | 40h | **40h** | ✅ OK | **Backend** |

**Problem:** Testing sollte in Woche 10–11 starten, aber Backend läuft jetzt bis Woche 12!

**Weitere Anpassung erforderlich:**
- Testing verschiebt sich auf Wochen 12–13 (1 Woche Projektverlängerung)
- **ODER:** Testing läuft parallel zu Backend-Finalisierung in Wochen 11–12 (Anna macht Testing, während Max Backend fertigstellt)

**Empfehlung:** Testing parallel in Wochen 11–12, Deployment in Woche 13.

---

**Finaler Plan (optimiert):**

| **Woche** | **Max** | **Anna** | **Tom** | **Kommentar** |
|---|---|---|---|---|
| 1 | 0h | 10h (Anforderungen) | 0h | |
| 2 | 0h | 10h (Anforderungen) | 30h (Design Desktop) | |
| 3 | 0h | 0h | 30h (Design Desktop) | |
| 4 | 0h | 0h | 30h (Design Desktop) | |
| 5 | 35h (Frontend) | 0h | 25h (Design Mobile) | |
| 6 | 35h (Frontend) | 0h | 25h (Design Mobile) | |
| 7 | 35h (Frontend) | 0h | 0h | Engpass behoben! |
| 8 | 35h (Frontend) | 0h | 0h | Engpass behoben! |
| 9 | 40h (Backend) | 0h | 0h | |
| 10 | 40h (Backend) | 0h | 0h | |
| 11 | 40h (Backend) | 15h (Testing) | 0h | Parallel! |
| 12 | 40h (Backend) | 15h (Testing) | 0h | Parallel! |
| 13 | 0h | 10h (Deployment) | 0h | **+1 Woche Projektverlängerung** |

---

**Schritt 4: Bewertung des neuen Plans**

✅ **Ist die Auslastung gleichmäßiger?** Ja! Max hat keine Überbelastung mehr. Alle Wochen sind ≤ 40h.

⚠️ **Bleibt das Projekt im Zeitplan?** Nein, das Projekt verlängert sich um **1 Woche** (von 12 auf 13 Wochen). Das ist der Preis für die Engpass-Auflösung.

✅ **Risiken durch Umplanung:**
- **Positiv:** Keine Überbelastung → bessere Qualität, weniger Stress
- **Negativ:** 1 Woche Verzögerung → muss mit Sponsor abgestimmt werden
- **Alternativ:** Testing könnte in Woche 10 beginnen (parallel zu Backend), dann bleibt Woche 12 als Endtermin

---

### Kommentar

> **Kommentar:** Ressourcen-Leveling ist immer ein **Trade-off (Kompromiss)**:
>
> - **Option A (Backend verschieben):** Einfach, keine neuen Ressourcen, aber +1 Woche Projektverlaufzeit
> - **Option B (Junior hinzuziehen):** Keine Zeitverzögerung, aber Kosten + Onboarding-Aufwand + Qualitätsrisiko
> - **Option C (Scope reduzieren):** Frontend oder Backend vereinfachen → Weniger Features, aber Zeitplan bleibt
>
> **Für Anfänger wichtig:**
> - Es gibt KEINE perfekte Lösung – nur verschiedene Abwägungen
> - Transparent kommunizieren: "Wir haben einen Engpass, hier sind die Optionen, was entscheidet der Sponsor?"
> - Dokumentieren: Warum wurde welche Entscheidung getroffen?
>
> **In YouTrack:** Die verschobenen Aktivitäten würden im Gantt-Chart oder Roadmap sichtbar. Issues für Backend würden neue Start-/End-Daten bekommen. Dependencies ("Frontend blocks Backend") helfen, die Logik zu visualisieren.

---

## Lösung zu Aufgabe 4: Konflikt-Auflösung

### Musterlösung

**Schritt 1: Konflikt-Typ identifizieren**

☑️ **Double-Booking** ← Richtig! Max soll in denselben Wochen (7–8) auf zwei Projekten gleichzeitig arbeiten (80h/Woche, aber nur 40h verfügbar).

---

**Schritt 2: Optionen zur Konfliktauflösung**

| **Option** | **Beschreibung** | **Kosten** | **Risiken** | **Termin** | **Bewertung** |
|---|---|---|---|---|---|
| **Option 1: Priorisierung** | Website-Relaunch hat Priorität; Max arbeitet komplett am Relaunch (Wochen 7–8). Mobile-App startet versetzt in Woche 9. | 0 € (intern) | Mobile-App verzögert sich; Sponsor Mobile-App unzufrieden | Website: pünktlich, Mobile: +2 Wochen | ⭐⭐⭐ OK |
| **Option 2: 50/50 Aufteilung** | Max arbeitet 50/50: 20h Website, 20h Mobile. | 0 € (intern) | Viel Kontextwechsel → ineffizient; beide Projekte verzögern sich | Beide +1–2 Wochen | ⭐⭐ Nicht ideal |
| **Option 3: Externe Contractor** | Einen Mid-Level-Developer extern für Mobile-App engagieren (Wochen 7–10). Max bleibt voll bei Website. | €3.000–5.000 | Onboarding-Zeit; Qualitätsrisiko | Beide Projekte pünktlich | ⭐⭐⭐⭐ Beste Lösung |
| **Option 4: Scope-Reduktion** | Mobile-App: Features in Phase 2 verschieben → weniger Entwicklungsarbeit. | 0 € (intern) | Stakeholder-Enttäuschung | Mobile: pünktlich mit reduziertem Scope | ⭐⭐ Akzeptabel |

**Empfehlung:** **Option 3 (Externe Contractor)** – kostet Geld, aber beide Projekte laufen pünktlich und Max wird nicht überlastet.

---

**Schritt 3: Empfehlung**

**Meine Empfehlung: Option 3**

**Begründung:**
1. **Kosten:** €3.000–5.000 sind gering im Vergleich zu Projekt-Verspätungen oder Qualitätsproblemen
2. **Risiken:** Onboarding dauert ~1 Woche, aber dann produktiv; Code-Review durch Max sichert Qualität
3. **Stakeholder-Management:** Beide Projekt-Sponsoren sind zufrieden
4. **Teamdynamik:** Max wird nicht überbelastet; kein Burnout-Risiko
5. **Qualität:** Max kann sich voll auf Website konzentrieren

---

**Schritt 4: E-Mail an Max**

```
Betreff: Ressourcenplanung Anpassung – Wochen 7–8 | Website-Relaunch Priorität

Lieber Max,

in den Wochen 7–8 entsteht eine Ressourcen-Kollision: 
- Website-Relaunch braucht Dich für Frontend-Entwicklung (40h/Woche)
- Das neue Mobile-Projekt soll starten und braucht Backend-Developer (40h/Woche)
- Problem: Du kannst nicht 80h/Woche arbeiten.

Nach Abwägung aller Optionen haben wir folgende Entscheidung getroffen:

**Website-Relaunch hat Priorität.** Das bedeutet konkret für Dich in den Wochen 7–8:

- **Website-Relaunch Frontend:** 40h/Woche (Vollgas!)
- **Mobile-Projekt:** Wir engagieren einen externen Developer (Contractor)
- Du machst für Mobile nur **Code-Review und Architektur-Beratung** (~3–5h/Woche, nicht in Deiner Kern-Auslastung)

**Vorteile für Dich:**
- Du schließt Website pünktlich ab
- Weniger Stress, klare Priorität
- Mobile-Projekt läuft parallel, ohne dass Du überlastet wirst

**Nächste Schritte:**
- Externe Developer-Suche läuft bis 25.11.2025
- Woche 7: Onboarding des Contractors, Du gibst Architektur-Briefing
- Wochen 7–10: Contractor implementiert, Du machst Code-Review

Bitte bestätige bis morgen 12:00, dass das für Dich passt.

Falls Fragen oder Bedenken: Lass uns heute noch telefonieren.

Danke!
Anna
```

---

### Kommentar

> **Kommentar:** Diese Konflikt-Auflösung zeigt:
>
> 1. **Problem klar benennen** – Keine Schuldzuweisungen, sondern sachliche Darstellung
> 2. **Lösung transparent erklären** – Max versteht, warum diese Entscheidung getroffen wurde
> 3. **Vorteile für die betroffene Person** – "Das ist besser für Dich"
> 4. **Nächste Schritte konkret** – Keine vagen Aussagen
> 5. **Feedback einholen** – Max hat die Möglichkeit, Bedenken zu äußern
>
> **Häufige Fehler:**
> - ❌ "Max, Du musst halt 80h arbeiten" – Nicht nachhaltig, unprofessionell
> - ❌ "Wir schauen mal, wie wir das hinbekommen" – Zu vage, keine Klarheit
> - ✅ Richtig: Klare Entscheidung, transparente Kommunikation, Respekt für die Person

---

## Lösung zu Aufgabe 5: RACI-Matrix

### Musterlösung

| **Aktivität** | **Anna (PL)** | **Max (Tech-Lead)** | **Tom (Designer)** | **Lisa (QA)** | **Klaus (Sponsor)** |
|---|---|---|---|---|---|
| **1. Anforderungen erheben** | **A/R** | C | I | I | C |
| **2. Design-Konzept erstellen** | C | C | **R/A** | I | I |
| **3. Frontend-Entwicklung** | I | **R/A** | C | I | I |
| **4. Backend-Entwicklung** | I | **R/A** | I | I | I |
| **5. Testplanung** | C | C | I | **R/A** | I |
| **6. Tests durchführen** | I | C | I | **R/A** | I |
| **7. Go-Live planen** | **R/A** | C | I | C | **C** |
| **8. Stakeholder-Meetings** | **R/A** | C | I | I | C |

---

**Erklärung der Eintragungen:**

### 1. Anforderungen erheben
- **Anna (A/R):** Projektmanagerin führt durch und trägt Verantwortung
- **Max (C):** Tech-Lead wird konsultiert (technische Machbarkeit)
- **Klaus (C):** Sponsor wird konsultiert (Business-Anforderungen)
- **Tom, Lisa (I):** Werden informiert

### 2. Design-Konzept erstellen
- **Tom (R/A):** Designer führt durch und trägt Verantwortung
- **Max (C):** Tech-Lead wird konsultiert (Umsetzbarkeit)
- **Anna (C):** PM wird konsultiert (Timeline)

### 3. Frontend-Entwicklung
- **Max (R/A):** Tech-Lead führt durch
- **Tom (C):** Designer berät bei Design-Fragen
- **Andere (I):** Werden informiert

### 4. Backend-Entwicklung
- **Max (R/A):** Tech-Lead führt durch
- **Andere (I):** Nur Information

### 5. Testplanung
- **Lisa (R/A):** QA-Manager plant und verantwortet
- **Max, Anna (C):** Werden konsultiert (Was testen? Timeline?)

### 6. Tests durchführen
- **Lisa (R/A):** QA-Team führt durch
- **Max (C):** Developer wird bei Bugs konsultiert

### 7. Go-Live planen
- **Anna (R/A):** PM koordiniert und verantwortet
- **Max, Lisa (C):** Tech und QA werden konsultiert
- **Klaus (C):** Sponsor gibt finale Freigabe

### 8. Stakeholder-Meetings
- **Anna (R/A):** PM moderiert
- **Max, Klaus (C):** Fachexperten geben Input

---

### Kommentar

> **Kommentar:** Eine gute RACI-Matrix vermeidet Konflikte durch:
>
> 1. **Klare Verantwortung (A):** Genau eine Person pro Aktivität
> 2. **Fokus auf Execution (R):** Wer macht es tatsächlich?
> 3. **Minimale Consultation (C):** Nur die wirklich Notwendigen
> 4. **Breite Information (I):** Alle, die es wissen müssen
>
> **Häufige Fehler:**
> - ❌ Zu viele "A" pro Aktivität → Verantwortungsdiffusion
> - ❌ Jeder ist überall "C" → Meeting-Marathon
> - ✅ Richtig: Lean, klar, nur nötige Beteiligung
>
> **In YouTrack:** 
> - "Assignee" = R (wer macht es)
> - "Reporter" = A (wer verantwortet)
> - "Watchers" = I (wer wird benachrichtigt)

---

## Lösung zu Aufgabe 6: YouTrack praktisch

### Musterlösung (konzeptuell)

**YouTrack Issue erstellt:**

```
┌─────────────────────────────────────────────────────────────┐
│ Frontend-Entwicklung - Seite /home                           │
│ ID: WEBSITE-024                                              │
├─────────────────────────────────────────────────────────────┤
│ Beschreibung:                                                 │
│ Umsetzung der Designvorlage als responsive HTML/CSS          │
│ mit React. Responsive für Desktop, Tablet, Mobile.           │
│                                                               │
│ Abhängigkeiten:                                              │
│ - Depends on: WEBSITE-015 "Design-Konzept Desktop"          │
│                                                              │
│ Details:                                                     │
│ ├─ Assignee: Max                                             │
│ ├─ Status: Assigned                                          │
│ ├─ Priority: High                                            │
│ ├─ Estimation: 35h (Wochen 5–8)                            │
│ ├─ Start Date: Woche 5, Montag                             │
│ ├─ Due Date: Woche 8, Freitag                              │
│ ├─ Custom: Ressourcentyp = "Senior Developer"              │
│ ├─ Custom: Kapazität = "35h/Woche"                          │
│                                                               │
│ Time Tracking:                                               │
│ ├─ Geplant: 35h/Woche × 4 Wochen = 140h                    │
│ ├─ Geloggt (Woche 5): 5h                                    │
│ │   └─ "5h - Header-Komponente implementiert"              │
│ ├─ Verbleibend: 135h                                         │
│ └─ Status: On Track (4% done)                              │
└─────────────────────────────────────────────────────────────┘

Workload Max (Woche 5):
- WEBSITE-024 Frontend: 35h
- Admin/Meetings: 5h
- GESAMT: 40h ✅ (100% Auslastung OK)
```

---

### Kommentar

> **Kommentar:** YouTrack hilft bei Ressourcenplanung durch:
>
> 1. **Transparenz:** Alle sehen, wer was macht
> 2. **Tracking:** Geplant vs. Aktuell vergleichbar
> 3. **Workload-Monitoring:** Überlastung sofort sichtbar
> 4. **Abhängigkeiten:** "Depends on" zeigt Blockierungen
> 5. **Reports:** Burndown, Velocity für Prognosen
>
> **Best Practices:**
> - Issues nicht zu groß (max 40h)
> - Zeit täglich oder 2×/Woche loggen
> - Workload wöchentlich reviewen
> - Custom Fields für Ressourcentyp nutzen

---

## Lösung zu Aufgabe 7: Fallstudie – Ressourcen-Krise

### Musterlösung

**Schritt 1: Analyse**

| **Frage** | **Antwort** |
|---|---|
| Welche Aktivitäten betroffen? | **Entwicklung System-Kern (Wochen 8–9)** – Max ist hauptverantwortlich |
| Konsequenz für Endtermin? | **Go-Live Woche 16 in Gefahr.** Entwicklung verzögert sich um mindestens 3 Wochen (Maxs Ausfall). Integration und Testing müssen ebenfalls verschoben werden. **Neuer Termin: frühestens Woche 19.** |
| Risiko-Level | 🔴 **KRITISCH** |

---

**Schritt 2: Optionen entwickeln**

| **Option** | **Beschreibung** | **Kosten** | **Zeit zur Umsetzung** | **Qualitätsrisiko** | **Risiko Go-Live** |
|---|---|---|---|---|---|
| **Option 1: Externe Senior-Developer** | 1–2 erfahrene Contractor für Wochen 8–10 | €15.000–25.000 | 3–5 Tage Rekrutierung, 1 Woche Onboarding | Mittel | Minimal (+1 Woche) |
| **Option 2: Scope-Reduktion** | Must-Have vs. Nice-to-Have; Nice-to-Have in Phase 2 | 0 € | Sofort | Keine (geplant) | 0 Wochen (aber Features fehlen) |
| **Option 3: Kai + Felix übernehmen** | Existierende Juniors arbeiten weiter, Max berät telefonisch | 0 € | Sofort | **HOCH** (Juniors überfordert) | +2–4 Wochen |
| **Option 4: Hybrid (Contractor + Scope)** | 1 Mid-Level-Contractor + leichte Scope-Reduktion | €8.000–12.000 | 3–5 Tage | Mittel | +1 Woche |
| **Option 5: Termin verschieben** | Go-Live später (Woche 19 statt 16) | 0 € (aber Opportunity Cost) | N/A | Keine | +3 Wochen |

---

**Schritt 3: Empfehlung**

**Empfehlung: Option 4 (Hybrid)**

**Begründung:**
- **Kosten:** Moderat (€8–12K)
- **Schnell umsetzbar** (3–5 Tage)
- **Risiko-Balance:** Contractor für kritische Tasks, Scope-Reduktion für Zeitpolster
- **Go-Live:** Nur +1 Woche Verzögerung
- **Qualität:** Code-Review durch Max (telefonisch) sichert Standards

---

**Schritt 4: Aktionsplan (nächste 48h)**

**Heute:**
1. **Sponsor informieren (Klaus):**
   - Problem: Max fällt aus
   - Vorschlag: Hybrid (Contractor + Scope)
   - Budget: €8–12K
   - Entscheidung bis morgen 10:00

2. **Contractor-Suche starten:**
   - Anforderung: CRM-Erfahrung, Mid-Level, 3 Wochen
   - Kanäle: Recruiter, LinkedIn
   - Candidate bis Mittwoch

3. **Scope-Prüfung:**
   - Must-Have vs. Nice-to-Have Liste
   - Entscheidung mit Product-Owner

**Morgen:**
4. Entscheidung Sponsor
5. Interview Contractor
6. Team-Briefing

**Woche 8:**
7. Contractor Onboarding
8. Tägliches Standup (Max telefonisch)
9. Wöchentliches Monitoring

---

### Kommentar

> **Kommentar:** Krisenmanagement erfordert:
>
> 1. **Schnelle Analyse:** Was ist das Problem? Wie kritisch?
> 2. **Mehrere Optionen:** Nicht nur eine Lösung
> 3. **Bewertung:** Kosten vs. Zeit vs. Risiko
> 4. **Entscheidung:** Mit Sponsor, transparent
> 5. **Aktion:** Konkrete Schritte, nicht vage
>
> **Häufige Fehler:**
> - ❌ "Hoffen, dass Max schnell gesund wird" – Passiv
> - ❌ "Juniors sollen es machen" – Überforderung
> - ✅ Richtig: Proaktiv, mehrere Wege, schnell entscheiden

---

## Zusammenfassung: Häufige Fehler und Best Practices

### ❌ Häufige Fehler

| **Fehler** | **Folgen** | **Vermeidung** |
|---|---|---|
| **Überbuchung** | Burnout, Qualität sinkt | Puffer 10–20%, realistische Schätzung |
| **Bottleneck ignorieren** | Projekt stoppt bei Ausfall | Redundanz, Cross-Training |
| **Overhead vergessen** | Unrealistische Pläne | 20–30% für Meetings/Admin einplanen |
| **Keine Rückmeldung** | Probleme zu spät erkannt | Wöchentliches Monitoring |

### ✅ Best Practices

| **Best Practice** | **Nutzen** |
|---|---|
| **Frühzeitige Planung** | Zeit für Maßnahmen |
| **Kapazitäts-Reserve** | Flexibilität |
| **Wöchentliches Monitoring** | Früh gegensteuern |
| **Klare Rollen (RACI)** | Keine Konflikte |
| **Tool-Nutzung (YouTrack)** | Transparenz |

---

## Abschließende Reflexionsfragen

1. **Ihr Projekt:** Gibt es Bottleneck-Ressourcen? Wie absichern?
2. **Qualifikationen:** Haben Sie alle benötigten Fähigkeiten im Team?
3. **Verfügbarkeit:** Mit wie viel % sind Teammitglieder realistisch verfügbar?
4. **Konflikte:** Welche Ressourcen-Konflikte sehen Sie kommen?
5. **Tools:** Nutzen Sie YouTrack? Wenn nein: Warum nicht?

---

**Ende von Modul 8c: Lösungen und Kommentare**

**Vielen Dank für die Arbeit mit Modul 8!**

*Ihre erworbenen Kompetenzen: Sie können jetzt Ressourcen planen, Engpässe erkennen, Konflikte konstruktiv lösen und Tools wie YouTrack für Ressourcen-Tracking nutzen.*
