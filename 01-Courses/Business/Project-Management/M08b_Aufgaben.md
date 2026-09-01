
## Aufgabe 1: Ressourcentypen identifizieren und klassifizieren

### Aufgabenstellung

Für das folgende Projekt sind die benötigten Ressourcen aufgelistet. Klassifizieren Sie diese in die Kategorien **Human Resources (HR)**, **Material Resources (MR)** und **Financial Resources (FR)**.

**Ressourcenliste für Projekt „Mobile App Entwicklung":**

1. Ein Projektleiter (6 Monate Vollzeit)
2. Zwei iOS-Entwickler (9 Monate à 40h/Woche)
3. Ein Design-Tool-Abonnement (Figma Professional)
4. Ein Cloud-Server für die Testumgebung
5. Vier Senior-Developer für Code Review und Architektur
6. Budget für externes Security-Audit (€ 15.000)
7. Laptops für die Entwickler (2 × neue MacBook Pro)
8. QA-Tester (3 Personen, 4 Monate)
9. Training und Schulung für Agile-Methoden (€ 8.000)
10. API-Lizenz für Third-Party-Service
11. Büroräume und Infrastruktur für das Team
12. Junior-Developer für Dokumentation und Support

---

**Tabelle zum Ausfüllen:**

| **Nr.** | **Ressource** | **Kategorie (HR/MR/FR)** | **Qualifikation (bei HR)** | **Besonderheiten** |
|---|---|---|---|---|
| 1 | Projektleiter | | | |
| 2 | Zwei iOS-Entwickler | | | |
| 3 | Figma Professional | | | |
| 4 | Cloud-Server | | | |
| 5 | Senior-Developer | | | |
| 6 | Security-Audit | | | |
| 7 | Laptops | | | |
| 8 | QA-Tester | | | |
| 9 | Agile-Training | | | |
| 10 | API-Lizenz | | | |
| 11 | Büroräume | | | |
| 12 | Junior-Developer | | | |

---

**Reflexionsfrage:**
- Welche Ressourcen sind kritisch für den Projekterfolg? Warum?

---

## Aufgabe 2: Kapazitätsplanung durchführen

### Aufgabenstellung

Sie sind Projektleiter des Projektes "Website-Relaunch". Das Projekt läuft über 12 Wochen. Ihre verfügbaren Ressourcen sind:

- **Max** (Entwickler): 40h/Woche, 100% verfügbar
- **Anna** (Projektmanagerin): 40h/Woche, 50% verfügbar (Parallel-Projekt!) = 20h/Woche
- **Tom** (Designer): 40h/Woche, 100% verfügbar für Wochen 1–6, dann nur noch 50% = 20h/Woche

**Geplante Aktivitäten (aus dem Zeitplan):**

| **Aktivität** | **Woche(n)** | **Erforderlich (h/Woche)** | **Ressource** |
|---|---|---|---|
| Anforderungen erheben | 1–2 | 10h | Anna |
| Design (Desktop) | 2–4 | 30h | Tom |
| Design (Mobile) | 5–6 | 25h | Tom |
| Frontend-Entwicklung | 5–8 | 35h | Max |
| Backend-Entwicklung | 7–10 | 40h | Max |
| Testing | 10–11 | 15h | Anna |
| Deployment-Vorbereitung | 12 | 10h | Anna |

---

**Arbeitsschritte:**

1. **Berechnen Sie für jede Person die verfügbare Kapazität für die gesamte Projektdauer:**
   - Formel: Wochenarbeitszeit × Anzahl Wochen × Verfügbarkeitsquote
   - Beispiel für Anna: 40h × 12 Wochen × 0,5 = 240h verfügbar

2. **Erstellen Sie eine Wochenbelastungs-Tabelle**:
   - Zeilen: Wochen 1–12
   - Spalten: Max (verfügbar/geplant), Anna (verfügbar/geplant), Tom (verfügbar/geplant)

3. **Identifizieren Sie Engpässe:**
   - In welchen Wochen ist **geplant > verfügbar**?
   - Für welche Person(en)?

4. **Notieren Sie potenzielle Probleme.**

---

**Lösungsvorlage:**

```
Verfügbare Kapazität insgesamt:
- Max: _____ h
- Anna: _____ h
- Tom: _____ h

Wochenbelastung (Beispiel für Woche 1):

Woche 1:
- Max: verfügbar 40h, geplant ___h → Status: ___
- Anna: verfügbar 20h, geplant ___h → Status: ___
- Tom: verfügbar 40h, geplant ___h → Status: ___

[Wochen 2–12 analog ausfüllen]

Engpässe erkannt in:
- Woche __: [Person] (geplant: __h, verfügbar: __h, Differenz: __h)
- Woche __: [Person] (geplant: __h, verfügbar: __h, Differenz: __h)
```

---

**Reflexionsfragen:**
- In welcher Woche gibt es die größte Überbelastung?
- Welche Person ist der Bottleneck (Engpass) im Projekt?
- Wie viele Stunden fehlen insgesamt?

---

## Aufgabe 3: Ressourcen-Leveling durchführen

### Aufgabenstellung

Basierend auf Aufgabe 2 haben Sie Engpässe identifiziert. Nun führen Sie **Ressourcen-Leveling** durch, um diese zu beheben.

**Szenario:**
- Sie können keine neuen Mitarbeiter kurzfristig beschaffen.
- Alle Aktivitäten müssen durchgeführt werden.
- Der Projekt-Endtermin (Woche 12) sollte möglichst nicht verschoben werden.

**Hinweise zu Abhängigkeiten:**
- Design (Desktop) muss fertig sein, bevor Frontend startet
- Design (Mobile) muss fertig sein, bevor Frontend startet
- Frontend + Backend müssen weitgehend fertig sein, bevor Testing beginnt

**Aufgaben:**

1. **Analysieren Sie die Engpässe aus Aufgabe 2:**
   - Welche Wochen sind betroffen?
   - Um wie viele Stunden wird die Kapazität überschritten?

2. **Entwickeln Sie Leveling-Strategien für jeden Engpass:**

| **Engpass** | **Gewählte Strategie** | **Begründung** | **Konkrete Umsetzung** |
|---|---|---|---|
| Woche X: [Person] | z.B. Aktivität verschieben / Arbeit aufteilen | Warum diese Strategie? | Was genau ändern Sie? |
| | | | |

3. **Erstellen Sie den neuen Wochenbelastungsplan nach Leveling:**
   - Zeigen Sie, dass keine Engpässe mehr auftreten (oder minimiert sind)

4. **Bewerten Sie den neuen Plan:**
   - Ist die Auslastung gleichmäßiger?
   - Bleibt das Projekt im Zeitplan?
   - Welche Risiken entstehen durch die Umplanung?

---

**Mögliche Strategien (Beispiele):**

- **Option A:** Backend-Entwicklung später starten (Woche 9 statt 7)
- **Option B:** Frontend-Entwicklung aufteilen (z.B. Anna unterstützt mit einfachen Tasks)
- **Option C:** Externen Junior-Developer für Testing-Vorbereitung einbinden
- **Option D:** Scope reduzieren (Mobile-Design vereinfachen)
- **Option E:** Projektende auf Woche 13 verschieben

---

## Aufgabe 4: Ressourcen-Konflikte erkennen und auflösen

### Aufgabenstellung

Szenario: Sie verwalten zwei parallele Projekte:

**Projekt A: Website-Relaunch**
- Max soll 40h/Woche Frontend-Entwicklung machen (Wochen 7–8)

**Projekt B: Mobile-App**
- Max soll 40h/Woche Backend-Entwicklung machen (Wochen 7–10)

**Überschneidung:** Wochen 7–8 → Max soll 80h arbeiten, hat aber nur 40h/Woche!

---

**Aufgaben:**

1. **Konflikt-Typ identifizieren:** Welche Art von Konflikt liegt vor?
   - [ ] Double-Booking
   - [ ] Engpass-Konflikt
   - [ ] Kompetenz-Lücke
   - [ ] Budget-Engpass
   - [ ] Zeitzone-Problem

2. **Optionen zur Konfliktauflösung entwickeln:**

Nutzen Sie die Strategien aus Modul 8a, Abschnitt 6.2. Entwickeln Sie mindestens 3 Optionen:

| **Option** | **Beschreibung** | **Kosten (€/Aufwand)** | **Risiken** | **Auswirkung auf Termine** | **Bewertung (1-5 Sterne)** |
|---|---|---|---|---|---|
| **Option 1:** | | | | | |
| **Option 2:** | | | | | |
| **Option 3:** | | | | | |

3. **Empfehlung abgeben:**
   - Welche Option würden Sie Ihrem Sponsor empfehlen?
   - Begründung?

4. **Entscheidung kommunizieren:**
   - Schreiben Sie eine kurze E-Mail an Max (Inhalt: Situation erklären, Lösung darstellen, erwartete Kapazität, nächste Schritte)

---

**E-Mail-Vorlage:**

```
Betreff: Ressourcenplanung Anpassung – Wochen 7–8

Lieber Max,

[Kontext zur Konfliktsituation]

Aufgrund dieser Situation haben wir folgende Entscheidung getroffen:

[Maßnahme beschreiben: Priorität, Aufteilung, Verschiebung, etc.]

Das bedeutet konkret für Dich in den Wochen 7–8:
- [Wochenaufwand für Projekt A]: ___h
- [Wochenaufwand für Projekt B]: ___h
- Gesamt: ___h (im Rahmen Deiner 40h/Woche)

Bitte bestätige bis [Datum].

Viele Grüße,
[Name]
```

---

## Aufgabe 5: RACI-Matrix für Ressourcenzuordnung erstellen

### Aufgabenstellung

Eine RACI-Matrix legt Rollen und Verantwortungen klar fest. Erstellen Sie eine RACI-Matrix für das Projekt "Website-Relaunch" mit folgenden Aktivitäten und Stakeholdern:

**Stakeholder:**
- Projektleiter: Anna
- Tech-Lead (Entwicklung): Max
- Designer: Tom
- QA-Manager: Lisa
- Business-Owner (Auftraggeber): Klaus

**Aktivitäten:**
1. Anforderungen erheben
2. Design-Konzept erstellen
3. Frontend-Entwicklung
4. Backend-Entwicklung
5. Testplanung
6. Tests durchführen
7. Go-Live planen
8. Stakeholder-Meetings

---

**RACI-Matrix Legende:**

- **R (Responsible)** = Wer führt die Arbeit durch?
- **A (Accountable)** = Wer trägt die Verantwortung? (meist nur eine Person pro Aktivität)
- **C (Consulted)** = Wer wird um Rat gefragt?
- **I (Informed)** = Wer wird informiert?

---

**Tabelle zum Ausfüllen:**

| **Aktivität** | **Anna (PL)** | **Max (Tech-Lead)** | **Tom (Designer)** | **Lisa (QA)** | **Klaus (Business Owner)** |
|---|---|---|---|---|---|
| 1. Anforderungen erheben | | | | | |
| 2. Design-Konzept erstellen | | | | | |
| 3. Frontend-Entwicklung | | | | | |
| 4. Backend-Entwicklung | | | | | |
| 5. Testplanung | | | | | |
| 6. Tests durchführen | | | | | |
| 7. Go-Live planen | | | | | |
| 8. Stakeholder-Meetings | | | | | |

---

**Regeln beim Ausfüllen:**

- Pro Aktivität **genau ein A (Accountable)** – die letzte Verantwortung
- **R sollte mit A koordinieren**
- Nicht jede Person sollte in jeder Aktivität vorkommen (sonst wird es zu komplex)
- "I" ist die häufigste Eintragung für Menschen, die die Info später brauchen

---

**Reflexionsfragen:**

- Gibt es Aktivitäten mit zu vielen Beteiligten?
- Gibt es Aktivitäten, bei denen unklar ist, wer letztlich verantwortlich ist?
- Könnten Sie durch diese Matrix Konflikte früher erkennen?

---

## Aufgabe 6: Ressourcenplan mit YouTrack erstellen (praktisch)

### Aufgabenstellung

Sie werden in dieser Übung in **YouTrack** arbeiten (oder Sie bereiten diese vor, wenn YouTrack noch nicht verfügbar ist).

**Szenario:** Projekt "Website-Relaunch", Aktivität "Frontend-Entwicklung"

**Schritte:**

1. **Issue in YouTrack erstellen:**
   - Titel: "Frontend-Entwicklung - Seite /home"
   - Beschreibung: "Umsetzung der Designvorlage als responsive HTML/CSS mit React"
   - Projektname: "Website-Relaunch"

2. **Ressourcen-Informationen eintragen:**
   - **Assignee:** Max (Entwickler)
   - **Estimation:** 20 Story Points oder 40 Stunden
   - **Start Date:** [Woche 5, Montag]
   - **Due Date:** [2 Wochen später, Freitag]
   - **Priority:** High
   - **Custom Fields (falls konfiguriert):**
     - Ressourcentyp: "Senior Developer"
     - Kapazität: "35h/Woche"

3. **Abhängigkeiten eintragen:**
   - Link zu Issue "Design-Konzept erstellen": "Depends on"
   - Das bedeutet: Frontend kann erst starten, wenn Design fertig ist

4. **Time Tracking einrichten:**
   - Für die kommende Woche: Plan, dass Max 35h an diesem Issue arbeitet
   - Loggen Sie die ersten 5 Stunden (Beispiel: "5h - Startseite Header-Komponente")

5. **Workload prüfen (im Agile Board oder Reports):**
   - Zeigen Sie, wie viele Issues Max in der aktuellen Woche zugeordnet hat
   - Ist die Gesamtbelastung realistisch?

---

**Vorlage zur Dokumentation (wenn Sie nur theoretisch arbeiten):**

```
Issue-Details in YouTrack:

Feld | Wert
---  | ---
Titel | Frontend-Entwicklung - Seite /home
Beschreibung | Umsetzung der Designvorlage als responsive HTML/CSS mit React
Assignee | Max
Estimation | 40h (oder 20 Story Points)
Projekt | Website-Relaunch
Priority | High
Custom Field "Ressourcentyp" | Senior Developer
Custom Field "Kapazität" | 35h/Woche
Status | Assigned / Open

Abhängigkeiten:
- Depends on: Design-Konzept erstellen (Issue #123)

Time Tracking (Beispiel Woche 5):
- Geplant: 35h
- Geloggt bisher: 5h
- Verbleibend: 30h
- Status: On Track

Workload Max (gesamte Woche 5):
- Frontend-Entwicklung: 35h
- Code-Review Projekt B: 3h
- Meeting/Admin: 2h
- TOTAL: 40h (100% Auslastung) ✓ Akzeptabel
```

---

**Reflexionsfragen:**

- Wie hilft YouTrack, Ressourcen-Engpässe früh zu erkennen?
- Welche Informationen aus dem Time Tracking könnten Sie wöchentlich mit Max besprechen?

---

## Aufgabe 7: Fallstudie – Ressourcen-Krise im Projekt

### Aufgabenstellung

**Szenario:**

Sie sind Projektleiter des Projektes "CRM-System Implementierung". Das Projekt ist in Woche 8 von 16 Wochen. Der Plan sah folgende Aktivitäten vor:

- Wochen 1–5: Anforderungen & Design
- Wochen 4–9: Entwicklung (System-Kern)
- Wochen 8–12: Integration (Schnittstellen zu alten Systemen)
- Wochen 12–16: Testing & Go-Live

**Aktuelle Situation:**

1. **Max** (Senior-Developer, Kern-Team): Erkrankt sich in Woche 8 für 3 Wochen
2. **Parallel-Projekt** startet in Woche 9 und braucht auch 2 Entwickler aus Ihrem Team
3. **Budget:** Extern können Sie noch € 10.000 aufbringen
4. **Qualifikation:** Es braucht erfahrene Entwickler; Anfänger sind für die kritischen Aufgaben nicht einsetzbar

**Aktuelle Kapazitäts-Situation (Woche 8–10):**

| **Ressource** | **Verfügbar/Woche** | **Geplant (Projekt CRM)** | **Status** |
|---|---|---|---|
| Max | 40h | 40h (Entwicklung Kern) | 🚨 FÄLLT AUS |
| Kai (Dev) | 40h | 30h (Integration) | OK |
| Felix (Dev) | 40h | 35h (Testing-Vorbereitung) | OK |
| **Fehlende Kapazität** | — | — | **40h/Woche × 3 Wochen = 120h!** |

---

**Ihre Aufgabe: Krisenmanagement durch Ressourcenplanung**

1. **Analyse:**
   - Welche Aktivitäten sind durch Maxs Ausfall direkt betroffen?
   - Was sind die Konsequenzen für den Projekt-Endtermin (Woche 16)?

2. **Optionen entwickeln** (mindestens 3 realistische Optionen):

| **Option** | **Beschreibung** | **Kosten** | **Zeit zur Umsetzung** | **Qualitätsrisiko** | **Risiko für Go-Live** |
|---|---|---|---|---|---|
| **Option 1:** | z.B. "Externe Contractor" | | | | |
| **Option 2:** | z.B. "Scope reduzieren" | | | | |
| **Option 3:** | z.B. "Parallel-Projekt verschieben" | | | | |

3. **Bewertung und Empfehlung:**
   - Welche Option würden Sie wählen?
   - Begründung (mit Argumenten: Zeit, Kosten, Risiken)

4. **Aktionsplan:**
   - Wenn Sie sich für einen Weg entscheiden: Welche konkreten Maßnahmen in den nächsten 48 Stunden?
   - Wer muss informiert werden?
   - Wer trifft die Entscheidung (Sponsor, PMO)?

---

## Zusammenfassung und Lernhilfen

### Checkliste: Ressourcenplan überprüfen

Nutzen Sie diese Checkliste, um Ihren Ressourcenplan zu validieren:

- [ ] Alle Aktivitäten aus dem Zeitplan haben eine zugeordnete Ressource
- [ ] Jede Ressource hat eine klare Qualifikation angegeben
- [ ] Verfügbarkeitsinformationen sind aktuell (Krankheit, Urlaub, Parallel-Projekte)
- [ ] Kapazitätsplanung durchgeführt: Keine Überallokation (>100% in einer Woche)
- [ ] Puffer eingeplant (mind. 10–20% Reserve pro Person)
- [ ] Engpässe identifiziert und Lösungsstrategien definiert
- [ ] RACI-Matrix ist erstellt (Rollen klar)
- [ ] Ressourcenplan mit Stakeholdern abgestimmt
- [ ] YouTrack (oder anderes Tool) für Tracking konfiguriert
- [ ] Team hat verstanden, wer wofür verantwortlich ist

### Platz für Ihre Notizen

```
Notizen zu Modul 8:

[Hier können Sie wichtige Erkenntnisse, Fragen oder eigene Beobachtungen notieren]

Fragen an den Trainer:
- ?
- ?
- ?

Lernpunkte zum Mitnehmen:
- 
- 
- 

Anwendung im eigenen Projekt:
- 
- 
```

---

**Ende von Modul 8b: Aufgaben und Übungen**

Weiter zu Modul 8c: Lösungen und Kommentare
