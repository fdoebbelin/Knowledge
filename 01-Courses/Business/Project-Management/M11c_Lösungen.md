## Aufgabenbereich 1: Reaktionsstrategien verstehen und anwenden

### Aufgabe 1.1: Strategieauswahl für Risiken – LÖSUNG

**Szenario:** Vier Risiken im IT-Modernisierungsprojekt

#### Lösungstabelle:

| Risiko | Strategie | Begründung |
|--------|-----------|-----------|
| A – ERP-Legacy-Kompatibilität (6/10) | **Mindern** | Vermeidung würde Projekt gefährden; Kompatibilität ist aber teilweise erreichbar durch Schnittstellen, Middleware-Lösungen oder phased Migration. Dies ist kostenwirksamer als Vermeiden. |
| B – Oracle-DBA-Ausfallrisiko (7/10) | **Mindern** (primär) + **Abwälzen** (sekundär) | Hohes Risiko erfordert mehrgleisiger Ansatz: Primär Mentoringplan für Juniors (Mindern); sekundär Versicherung oder Service-Level-Agreement mit externem DBA-Service (Abwälzen). |
| C – Hardware-Lieferverzögerung (4/10) | **Abwälzen** (primär) + **Akzeptieren** (sekundär) | Lieferketten-Risiken liegen außerhalb Projektkontrolle. Primär: SLA mit Lieferant, Backup-Lieferanten vertraglich regeln. Sekundär: Zeitbuffer im Plan akzeptieren. |
| D – Stakeholder-Akzeptanzrisiko (4/10) | **Mindern** | Proaktive Stakeholder-Kommunikation, regelmäßige Demos, User-Acceptance-Testing (UAT), Change-Management. Dies sind typische Minderungs-Maßnahmen für Akzeptanzrisiken. |

---

#### Kommentar zu Aufgabe 1.1:

> **Kommentar:** Diese Lösung zeigt ein typisches Szenario, in dem nicht alle Risiken gleich behandelt werden. **Risiko A und D** sind typerweise durch **Minderung** zu bearbeiten, da sie Teil der normalen Projektausführung sind. **Risiko B** erfordert mehrgleisigen Ansatz – ein kritisches Personalrisiko sollte niemals nur durch Akzeptanz gehandhabt werden. **Risiko C** ist ein klassisches **Abwälzungs-Szenario**, da extern verursacht. 
>
> **Häufige Fehler:**
> - Alle Risiken uniform mit einer Strategie behandeln
> - Personalrisiken nur „akzeptieren" statt zu mindern
> - Lieferantenunsicherheiten nicht vertraglich abwälzen
> - Zu viel „Vermeidung" planen (oft unrealistisch)

---

#### Lösungstabelle zu Aufgabe 1.1b – Konkrete Maßnahmen für Risiko A:

| # | Maßnahme | Wirkmechanismus |
|---|----------|-----------------|
| 1 | **Integrations-Architektur-Review in Woche 2** – Externe Experten prüfen Kompatibilität | Frühzeitige Erkennung von Inkompatibilitäten, statt erst in UAT zu merken |
| 2 | **Middleware/Schnittstellen-Layer** – ETL-Tools oder APIs zwischen ERP und Legacy | Reduziert Daten-/Prozess-Inkompatiblität ohne vollständigen Legacy-Austausch |
| 3 | **Phased Migration mit Parallel-Run** – Alte und neue Systeme laufen 2-4 Wochen parallel | Rollback-Möglichkeit, getestete Datenmigration, schrittweise Umstellung |
| 4 | **Legacy-System-Dokumentation & Mapping** – Detaillierte Analyse der Legacy-Schnittstellen | Verhindert Überraschungen, Data-Mapping wird sachlich korrekt |

---

#### Kommentar zu Aufgabe 1.1b:

> **Kommentar:** Die beste Mitigation für Legacy-Kompatibilität ist **frühe Klärung** (Point 1) + **technische Entkopplung** (Point 2) + **schrittweise Einführung** (Point 3). Diese Kombinationen sind in der Praxis bewährt. Point 4 ist eher eine Basis-Vorbereitung als echte Risiko-Reduktion.
>
> **Typischer Fehler:** Mit Vermeidung zu kalkulieren (z. B. „kaufen wir Legacy-Replacement-Produkt") – das ist oft teurer und riskanter als intelligente Mitigation.

---

### Aufgabe 1.2: Chancenmanagement – LÖSUNG

| Chance | Strategie | Maßnahmen |
|--------|-----------|----------|
| **Chance A – Kostenersparnis durch schnellen Abschluss (€50k)** | **Nutzen** (Exploit) | 1. Agile Daily Standups zur Beschleunigung etablieren 2. Early-Wins-Planung: Priorisieren Sie MVP (Minimum Viable Product) in Sprint 1 3. Performance-Bonus für Team bei Meilenstein-Einhaltung |
| **Chance B – Zusätzliche Funktionen durch neue Tech** | **Verstärken** (Enhance) | 1. Dedicated Innovation-Session zur Identifikation von Use-Cases 2. Proof-of-Concept (POC) in Sprint 2, um Machbarkeit zu zeigen 3. Roadmap für Phase 2 vorbereiten, um schnell umzusetzen |

---

#### Kommentar zu Aufgabe 1.2:

> **Kommentar:** Chancenmanagement wird oft vernachlässigt! **Chance A** ist klassisch eine **Exploit**-Strategie: Wir tun gezielt etwas, um die Kostenersparnis zu realisieren (Daily Standups, Priorisierung, Incentives). **Chance B** ist **Enhance**: Wir investieren Zeit in Verstärkung (Innovation-Session, POC), um die Wahrscheinlichkeit zu erhöhen, dass die Chance sich manifestiert.
>
> **Häufiger Fehler:** Chancen werden identifiziert, aber dann passiert nichts. Sie müssen genauso konkrete Maßnahmen bekommen wie Risiken!

---

## Aufgabenbereich 2: Risikomaßnahmen planen und priorisieren

### Aufgabe 2.1: Risikomaßnahmen konkretisieren – LÖSUNGSBEISPIELE

#### Beispiel: Risiko 1 (Schlechtwetter-Verzögerung)

```
MASSNAHMENPLAN – RISIKO: Schlechtwetter-Baustelle-Verzögerung

Reaktionsstrategie: MINDERN

Maßnahmenbeschreibung:
- Bereitstellung von Wetterschutzplanen und beheizten Arbeitszelten für kritische 
  Außenarbeiten (Fundament, Dacharbeiten)
- Innenarbeiten zeitlich vorziehen und optimal parallel planen, um Wetterfenster zu nutzen
- Maschinen und Bagger langfristig (mit Puffer) reservieren statt ad-hoc
- Wöchentliche Wetter-Analyse und flexible Ablaufplanung (nicht starre Folgeleistungen)

Erfolgs- / Wirkindikatoren:
- Schlechtwetter-bedingte Verzögerung auf max. 1 Woche reduzieren (statt 3-4 Wochen)
- Plan-Ist-Vergleich der Meilensteine monatlich
- Wetter-Puffer wird nicht aufgebraucht (KPI: Buffer-Ausnützung < 30%)

Start- und Enddatum:
- Start: Woche 2 (Schutzeinrichtungen bestellen/aufbauen)
- Ende: Projektende (kontinuierliche Anwendung)

Ressourcen erforderlich:
- Personal: Bauleiter (2 Tage für Planung), 2 Arbeitskräfte für Schutzaufbau, Logistik
- Budget: €8.000 (Schutzplanen, Heizzelte, Verwaltungsaufwand)
- Werkzeuge: Wetter-API-Abonnement (€200/Monat), Planbeschleunigungssoftware

Risikoowner:
Bauleiter Thomas Müller (thomas.mueller@baugesellschaft.de)

Geschätzter ROI / Verhältnis Aufwand zu Nutzen:
€8.000 Aufwand → verhindert 3 Wochen Verzögerung → ~€120.000 Kosten-/Zeitverlust
ROI: 1 : 15 (sehr gute Investition)
```

---

#### Beispiel: Risiko 2 (Lieferketten-Engpass Bagger/Krane)

```
MASSNAHMENPLAN – RISIKO: Bagger/Kran-Lieferengpass Q3 2026

Reaktionsstrategie: ABWÄLZEN + MINDERN

Maßnahmenbeschreibung:
- Mit Vermieterfirmen (z. B. Caterpillar Rental, Leica Equipment) schriftliche Kapazitätsreservierung 
  für Q3 2026 etablieren, mit Strafzahlungen bei Nichtlieferung (SLA)
- Backup-Vermieterfirmen regional identifizieren (Preisvergleich durchführen)
- Maschinen-Ersatzteilpool aufbauen (häufige Defekte vorab mit Vermietern kalkulieren)
- Projekt-Ablauf so planen, dass Maschinen-Nutzung zeitlich gestaffelt ist 
  (nicht alle gleichzeitig nötig)

Erfolgs- / Wirkindikatoren:
- Schriftliche Kapazitätsbestätigung der Vermieter bis Woche 4
- Backup-Vermieter identifiziert und unter Druck gesetzt
- Maschinen-Engpass-Wochen in Planung sichtbar und mit Puffern versehen

Start- und Enddatum:
- Start: Woche 1 (Verhandlung)
- Ende: Woche 12 (Verträge unterzeichnet)
- Kontinuierliches Monitoring bis Q3 2026

Ressourcen erforderlich:
- Personal: Projektmanager (5 Tage Verhandlung), Logistiker (2 Tage Backup-Koordination)
- Budget: €2.000 (Vertrags-/Recherche-Aufwand, ggf. höhere Vermiet-Gebühren für SLA)
- Werkzeuge: Vertrags-Templates, Lieferanten-DB, YouTrack zur Verfolgung

Risikoowner:
Projektlogistiker Sylvia Berg (sylvia.berg@baugesellschaft.de)

Geschätzter ROI:
€2.000 Aufwand → verhindert 2 Wochen Verzögerung + Mehrkosten (€50.000)
ROI: 1 : 25 (ausgezeichneter ROI)
```

---

#### Kommentar zu Aufgabe 2.1:

> **Kommentar:** Die beiden Beispiele zeigen die praktische Konkretisierung von Risiko-Maßnahmen. Wichtig ist, dass alle Felder der Vorlage ausgefüllt werden – besonders die **Erfolgs-Indikatoren** (wie gemessen?) und der **Risikoowner** (wer verantwortet?). 
>
> **Typische Fehler:**
> - Maßnahme zu vage: „Bessere Planung" statt konkreter
> - Kein Owner zugeordnet = Maßnahme wird nicht umgesetzt
> - KPIs fehlen = Nicht nachvollziehbar, ob Maßnahme wirkt
> - ROI unterschätzt (zu viel Aufwand für zu wenig Nutzen akzeptiert)

---

### Aufgabe 2.2: Priorisierung von Maßnahmen – LÖSUNG

#### Analysetabelle mit ROI und Prioritäten:

| ID | Maßnahme | Restrisiko-Reduktion | Aufwand (Tage) | Abhängigkeiten | ROI-Score | Priorität |
|----|----------|-------------------|----|---|---|---|
| M1 | Schulung Team | Hoch→Mittel = 3 Punkte | 15 | Keine | 3/15 = 0,20 | **1** |
| M2 | Backup-Lieferanten | Mittel→Niedrig = 2 Punkte | 8 | Keine | 2/8 = 0,25 | **1** |
| M4 | Risk Reserve | Mittel→Niedrig = 2 Punkte | 3 | Keine | 2/3 = 0,67 | **2** |
| M7 | Stakeholder-Plan | Mittel→Niedrig = 2 Punkte | 6 | Keine | 2/6 = 0,33 | **2** |
| M3 | Prototyping | Hoch→Mittel-Niedrig = 4 Punkte | 25 | Keine | 4/25 = 0,16 | **3** |
| M5 | Versicherer | Mittel→Niedrig = 2 Punkte | 10 | M2 (Abhängig!) | 2/10 = 0,20 | **4** |
| M6 | Dokumentation | Niedrig→Sehr Niedrig = 1 Punkt | 12 | M1 (Abhängig!) | 1/12 = 0,08 | **5** |
| M8 | Hardware-Testing | Mittel→Mittel-Niedrig = 1 Punkt | 20 | M3 (Abhängig!) | 1/20 = 0,05 | **6** |

---

#### **Top-5-Auswahl für Q1 (max. 100 Arbeitstage):**

| Priorität | Maßnahmen-ID | Maßnahme | Aufwand | Begründung |
|-----------|---|----------|--------|-----------|
| 1 | **M2** | Backup-Lieferanten | 8 Tage | Höchster ROI (0,25), keine Abhängigkeiten, kritisch für Projekt-Stabilität |
| 2 | **M1** | Schulung Team | 15 Tage | Hoher ROI (0,20), keine Abhängigkeiten, enables M6 später |
| 3 | **M4** | Risk Reserve | 3 Tage | Bester ROI (0,67), sehr schnell zu machen, auch bei anderen Risiken wertvoll |
| 4 | **M7** | Stakeholder-Plan | 6 Tage | Guter ROI (0,33), keine Abhängigkeiten, oft unterbewertet in Projekten |
| 5 | **M3** | Prototyping | 25 Tage | Verbleibend ca. 43 Tage (von 100) reichen für Prototyping; enables M8 |

**Summe:** 8 + 15 + 3 + 6 + 25 = **57 Tage** (von 100 verfügbar)

---

#### **Verschiebung nach Q2:**

| Maßnahmen-ID | Grund für Verschiebung |
|---|---|
| **M5** – Versicherer | Abhängig von M2 (Backup-Lieferanten), daher logisch erst nach Q1 zu verhandeln. Zudem: ROI nur 0,20, nicht dringend. |
| **M6** – Dokumentation | Abhängig von M1 (Schulung), daher nach Q1 möglich. Auch: Sehr niedriger ROI (0,08), kann später erfolgen. |
| **M8** – Hardware-Testing | Abhängig von M3 (Prototyping). Logische Reihenfolge: Erst Prototyp testen, dann Hardware-Testing. |

---

#### Kommentar zu Aufgabe 2.2:

> **Kommentar:** Diese Priorisierung zeigt **realistische Priorisierungskriterien im PM:**
>
> 1. **ROI-Ansatz:** Welche Maßnahme bringt pro investiertem Tag die meiste Risikovermeidung?
> 2. **Abhängigkeiten respektieren:** M2 vor M5, M1 vor M6, M3 vor M8
> 3. **Ressourcen-Realismus:** Nicht einfach alles planen, sondern bewusst auswählen
>
> **Häufige Fehler:**
> - Alle Maßnahmen in Parallel planen (überlastet Ressourcen)
> - Abhängigkeiten ignorieren (z. B. M5 verhandeln, ohne M2 zu haben = schwach in Verhandlung)
> - Zu optimistisch mit Aufwandsschätzung → Maßnahmen werden nicht umsetzt

---

## Aufgabenbereich 3: Risikoowner und Verantwortlichkeiten

### Aufgabe 3.1: Risikoowner definieren – LÖSUNG

| Maßnahme | Risikoowner | Begründung |
|----------|-------------|-----------|
| **1. Code-Review-Prozess (Qualitätsminderung)** | **Alice** (Lead Developer) | Alice hat höchste technische Fachkompetenz und Autorität bei Entwicklern. Sie kann Code-Review-Standards definieren und durchsetzen. Ein prozessuales QS-Ritual braucht technische Glaubwürdigkeit. |
| **2. Schulung neues Framework (Technologie-Risiko)** | **Alice** (Lead Developer) ODER **David** (Scrum Master) | Alice könnte technische Schulungen durchführen. Aber: David als Scrum Master ist prozessverantwortlich und organisiert Lernformate besser. **Empfehlung:** David koordiniert, Alice ist Fachexperte. |
| **3. SLA mit Cloud-Provider (Verfügbarkeitsrisiko)** | **Bob** (Projektmanager) | Bob hat übergeordnete Verantwortung und Stakeholder-Kontakt. Vertragsverhandlung ist Projektmanagement-Aufgabe, nicht technisch. |
| **4. Stakeholder-Updates (Akzeptanzrisiko)** | **Eva** (Business Analyst) | Eva hat direkten Kundenkontakt und kennt Stakeholder-Bedürfnisse. Sie versteht die Anforderungen und kann diese kommunizieren. Bob koordiniert, aber Eva führt Meetings durch. |

---

#### Kommentar zu Aufgabe 3.1:

> **Kommentar:** Diese Zuordnung zeigt das **wichtige PM-Prinzip: Risikoowner = fachlich kompetent + prozessverantwortlich + motiviert**. 
>
> - **Alice** (Tech) passt zu technischen Problemen (Code-Review, teilweise Schulung)
> - **Bob** (PM) passt zu Stakeholder/Vertrags-Themen (SLA)
> - **Eva** (BA) passt zu Anforderungs-/Akzeptanz-Themen
> - **David** (Scrum) passt zu Prozess-/Organisations-Themen
>
> **NICHT:** Alles dem Projektmanager (Bob) geben. Das ist **Bottleneck!** Jeder Owner sollte in seinem Bereich zuständig sein.
>
> **Häufige Fehler:**
> - Alle Risiken zum Projektmanager → Bob ist überfordert
> - Owner, der keine Fachkompetenz hat → Maßnahme wird dilettantisch
> - Owner, der nicht motiviert ist → Maßnahme scheitert still und heimlich

---

## Aufgabenbereich 4: Risikomonitoring und Risikoregister

### Aufgabe 4.1: Frühindikatoren identifizieren – LÖSUNG

| Risiko | Mögliche Frühindikatoren |
|--------|--------------------------|
| **Zeitverzögerung im Projekt** | • Verzögerung in aktuellen Task-Fertigstellen (Burndown-Abweichung +10%)<br>• Häufiges Verschieben von Meilenstein-Terminen (mehr als 2× im Quartal)<br>• Anstieg von offenen Blockers/Dependencies (nicht gelöst > 3 Tage)<br>• Abnahme von Velocity (Leistung pro Sprint rückläufig)<br>• Stakeholder-Meetings mehrfach verschoben<br>• Scope Creep: Anforderungen hinzugefügt ohne Zeit-Puffer bereinigt |
| **Budget-Überläufer** | • Kostenabweichung (Cost Variance) > 5% in beliebigen Kostenart<br>• Rework-Rate steigt (mehr Fehler/Nacharbeiten als geplant)<br>• Ressourcen-Overtime über-durchschnittlich (> 3 Stunden/Woche)<br>• Material-/Lieferkosten steigen unerwartet (Preisindizes, Wechselkurse)<br>• Invoices liegen über Plan ohne erkennbaren Grund<br>• Earned Value (EV) sinkt bei gleichen oder höheren Ausgaben |
| **Personalfluktuation** | • Mitarbeiter äußert Jobsuche/Unzufriedenheit (auch indirekt via Gespräche)<br>• Abnahme von Motivation, Engagement (geringere Meeting-Teilnahme, Passive)<br>• Erhöhte Krankheitsrate oder „Fluchtausreißer" (ungeplante Tage off)<br>• Linkedin-Profil aktualisiert, ist Recruiter kontaktiert<br>• Gehalts-/Karriere-Unzufriedenheit wird geäußert<br>• Mitarbeiter lehnt neue Herausforderungen/Tasks ab |
| **Akzeptanzrisiko** | • Stakeholder-Feedback in Reviews wird kritischer, Enttäuschung spürbar<br>• Meetings zur Anforderungs-Validierung werden abgesagt/zeitlich verschoben<br>• Genehmigungsrate sinkt (Approvals dauern länger, häufiger zurückgewiesen)<br>• Testabbruch-Rate steigt (UAT-Funde nicht reproduzierbar, unklar)<br>• Negative Kommentare in Prototypen-Reviews (soziale Hinweise)<br>• Finanzfreigaben verzögern sich ohne erklärten Grund |

---

#### Kommentar zu Aufgabe 4.1:

> **Kommentar:** **Frühindikatoren sind der Schlüssel zu gutem Risikomonitoring.** Sie zeigen, dass ein Risiko **bevor es zu spät ist** auf uns zukommt.
>
> - **Zeitverzögerung:** Frühindikatoren sind **Burndown, Velocity-Abfall, häufiges Verschieben** (sichtbar in Projekt-Tools)
> - **Budget:** Frühindikatoren sind **Cost Variance im EV, Overtime-Raten, Rework** (sichtbar in HR/Finance)
> - **Personal:** Frühindikatoren sind **Motivation, Jobsuche-Signale, Engagement-Abfall** (HR + Gespräche)
> - **Akzeptanz:** Frühindikatoren sind **kritisches Feedback, verzögerte Approvals, UAT-Probleme**
>
> **Häufiger Fehler:** Erst zu reagieren, wenn Risiko manifesthiert ist (z. B. Personalabgang passiert), statt Frühindikatoren zu nutzen.

---

### Aufgabe 4.2: Risikoregister führen – LÖSUNG

Hier die **vollständig ausgefüllte Risikoregister-Vorlage:**

| R-ID | Risiko | Ursache | Mögliche Auswirkung | Wahrscheinlichkeit | Auswirkung | Risikowert | Strategie | Maßnahmen | Owner | Status | Restrisiko |
|------|--------|--------|-------------------|-------------------|-----------|-----------|-----------|----------|-------|--------|-----------|
| **R01** | **Blockchain-Technologie-Unerfahrenheit** | Neue Technologie erstmalig im Unternehmen, kein internes Know-how | Architektur-Fehler, lange Debug-Zeiten, Rework, Verzögerung (4+ Wochen), Qualitätsprobleme | Hoch (70%) | Hoch (€100k+ Mehrkosten, 6 Wochen Verzögerung) | **7/10** | **Mindern** | 1. Externe Blockchain-Spezialisten für Architektur-Review (Woche 1-2)<br>2. POC (2-3 Wochen) vor Hauptentwicklung<br>3. Team-Schulung durch Externen (3 Tage)<br>4. Code-Review-Prozess mit Blockchain-Audit | Tech Lead / CTO | Geplant | 4/10 |
| **R02** | **Personalrisiko – Schlüsselmitarbeiter-Abgang** | Mitarbeiter hat Kündigungsabsicht nach Projektende signalisiert, Motivationsverlust möglich | Wissensabfluss, Projektdelay, Qualitätsverlust, Team-Unruhe | Mittel (40%) | Sehr Hoch (€200k Recruitment/Einarbeitung, 8+ Wochen Verzögerung) | **8/10** | **Mindern** + **Abwälzen** | 1. Umfassendes Mentoring-Programm für 2 Junior-Entwickler (Start Woche 2)<br>2. Dokumentation kritischer Funktionen (parallel zur Entwicklung)<br>3. Retention-Gespräche mit HR-Leitung<br>4. Versicherung oder Bonus-Vereinbarung für Projektende | HR-Manager + Tech Lead | In Bearbeitung | 3/10 |
| **R03** | **Lieferanten-Finanzrisiko** | Zulieferer ist in finanzielle Schwierigkeiten geraten (Pressebericht), könnte Insolvenz anmelden | Lieferketten-Unterbruch, teure Alternativ-Beschaffung, Verzögerung (2-3 Wochen) | Mittel-Hoch (50%) | Hoch (€60k+ Mehrkosten, 3 Wochen Verzögerung) | **6/10** | **Abwälzen** + **Mindern** | 1. Sofort Backup-Lieferanten identifizieren & anfragen (Woche 1)<br>2. SLA mit Backup-Lieferant verhandeln (3-5 Tage Puffer-Sicherheit)<br>3. Payment-Bedingungen mit Hauptlieferant klären (Prepay-Risiko prüfen)<br>4. Lagerbestände erhöhen für kritische Komponenten (€5k Budget) | Procurement Manager | In Bearbeitung | 3/10 |
| **R04** | **Anforderungs-Volatilität / Scope Creep** | Kundenunternehmen sehr kurzfristig, ändert Anforderungen häufig | Unklare Ziele, wiederholte Entwicklung, Budget-Überläufer (€50k+), Verzögerung (2-3 Wochen) | Hoch (70%) | Mittel (€80k+ Rework, 4 Wochen Verzögerung) | **6/10** | **Mindern** | 1. Strikte Change-Control-Prozess etablieren (Review Board mit Kundenverantwortlichem)<br>2. Wöchentliche Requirement-Baseline-Reviews (Stakeholder-Alignment)<br>3. Detailliertes Kick-Off & Anforderungs-Workshop mit allen Stakeholdern (Woche 1)<br>4. Change-Request-Impact-Analyse (Zeit, Budget, Scope) | Business Analyst / PM | Geplant | 3/10 |

---

#### Kommentar zu Aufgabe 4.2:

> **Kommentar:** Ein gutes **Risikoregister** enthält:
>
> 1. **Konkrete Risikobeschreibungen** (nicht: „technisches Risiko", sondern: „Blockchain-Unerfahrenheit")
> 2. **Ursache-Wirkung-Verständnis** (warum tritt das Risiko auf? Was sind die Konsequenzen?)
> 3. **Quantifizierte Bewertung** (Wahrscheinlichkeit × Auswirkung)
> 4. **Klare Strategien** (nicht alles = „akzeptieren")
> 5. **Konkrete Maßnahmen** (nicht: „bessere Planung", sondern: „Change-Control mit Review-Board")
> 6. **Owner** (wer trägt Verantwortung?)
> 7. **Status-Tracking** (geplant, in Bearbeitung, abgeschlossen)
> 8. **Restrisiko** (wie gut wirkt die Maßnahme?)
>
> **Häufige Fehler:**
> - Risikoregister wird einmal erstellt, dann nicht gepflegt
> - Maßnahmen zu vage / unrealistisch
> - Kein Owner = Maßnahme wird nicht umgesetzt
> - Restrisiko wird nicht bewertet (daher keine Erfolgskontrolle)

---

### Aufgabe 4.3: Risikoregister-Review durchführen – LÖSUNG

#### a) Analysen & Interpretationen:

```
POSITIVE ENTWICKLUNGEN:
- R01 (Technologie): 6/10 → 5/10 (Reduktion um 1 Punkt)
  Grund: Schulung läuft an, erstes Verständnis aufgebaut
  Wirkung: Externe Schulung und POC beginnen zu wirken

- R04 (Anforderungs-Volatilität): 4/10 → 4/10 (stabil, gut gemanagt)
  Grund: Change-Control-Prozess wurde früh etabliert, wirkt präventiv
  Wirkung: Scope Creep wurde bisher verhindert

NEGATIVE ENTWICKLUNGEN:
- R03 (Lieferantenrisiko): 5/10 → 8/10 (Verschlimmerung um 3 Punkte!)
  Grund: Lieferanten-Finanzprobleme haben sich verschärft, Backup-Verhandlungen sind schwierig
  Interpretation: ALARM! Risk hat sich materialisiert, Backup-Lieferanten verlangen höhere Preise
  
- R02 (Personalrisiko): 7/10 → 7/10 (keine Reduktion)
  Grund: Mentoring startet erst, wirkt noch nicht. Mitarbeiter signalisiert immer noch Abgangspläne
  Interpretation: Zu früh zu sagen, ob Retention-Strategie funktioniert. Vigilance required.

MÖGLICHE URSACHEN & INTERPRETATIONEN:
- R01 positiv: Maßnahmen wirken (Schulung, POC greifen)
- R03 massiv negativ: Lieferanten-Situatio hat sich verschärft, Backup-Strategie schlägt fehl
  → Potentieller Grund: Alternative Lieferanten sind auch beschäftigt oder teurer
  → Sekundäre Strategie: Komponenten-Vorrat oder Alternate-Technologie prüfen
- R02 stabil: Mentoring-Effekt braucht Zeit (Hoffnung, dass Maßnahmen greifen)
- R04 gut: Change-Control wirkt präventiv
```

---

#### b) Eskalationen und Maßnahmen:

```
ESKALATIONEN:

1. **R03 (Lieferanten) – KRITISCH**
   Eskalation zu: Steering Committee / Geschäftsführung
   Begründung: Risk stieg um 3 Punkte, ist jetzt 8/10 (kritisch)
   Entscheidung erforderlich: 
   - Sind wir bereit, höhere Backup-Lieferanten-Preise zu zahlen (+€20-30k)?
   - Oder: Projektstart verschieben um 4 Wochen (um Lieferanten-Krise zu umgehen)?
   Timing: Sofort (Woche 12, noch 6 Wochen bis Lieferfrist in Woche 18)

2. **R02 (Personalrisiko) – ERHÖHT MONITORED**
   Eskalation zu: HR-Manager + Tech Lead
   Begründung: Risk ist noch Hoch (7/10), keine Verbesserung in 2 Wochen
   Frage: Sind Retention-Maßnahmen wirksam? Brauchen wir Gehalt-Anpassung?
   Timing: Nächste 2 Wochen intensiv monitoren, dann erneut Review

SOFORTMASSNAHMEN:

1. **R03 – Lieferantenrisiko (sofort in Woche 12):**
   - [ ] CFO + Procurement Manager: Preisverhandlung mit Backup-Lieferanten (bis Donnerstag)
   - [ ] Alternative Komponenten-Suppliers recherchieren (24h)
   - [ ] Steering Committee Meeting zur Genehmigung Budget-Mehrausgaben (bis Freitag)
   - [ ] Falls Backup-Verhandlungen scheitern: Projektstart-Verschiebung kalkulieren

2. **R02 – Personalrisiko (diese Woche):**
   - [ ] HR-Manager: Retention-Gespräch mit Mitarbeiter (klären: Was bräuchte es für Bleiben?)
   - [ ] Tech Lead: Intensives Mentoring-Pairing starten (ab nächster Woche täglich)
   - [ ] Ggf. Leistungs-Bonus für Projektende anbieten (bis Freitag genehmigen lassen)

3. **R01 & R04 – Monitoring (regelmäßig):**
   - [ ] Schulungs-Erfolge überprüfen (Quiz, Code-Review)
   - [ ] Change-Control-Effektivität prüfen (Wie viele Changes wurden verhindert/genehmigt?)
```

---

#### Kommentar zu Aufgabe 4.3:

> **Kommentar:** Diese Review zeigt **realistisches Risikomonitoring im Projektalltag:**
>
> 1. **R01 positiv:** Externe Schulung funktioniert – **Strategie wirkt**, aber noch Restrisiko
> 2. **R03 Alarm:** Risk ist **gestiegen** statt gesunken – Backup-Strategie schlägt fehl
>    → Eskalation + alternative Maßnahmen nötig
> 3. **R02 stabil:** Retention-Maßnahme braucht Zeit – **noch zu früh zu sagen**, ob wirkt
> 4. **R04 gut:** Change-Control **wirkt präventiv**
>
> **Häufige Fehler im Monitoring:**
> - Nur gute News verbreiten, schlechte unter den Tisch kehren (R03!)
> - Zu lange reagieren (warte bis Risk = 10, dann eskalieren) – statt früh
> - Maßnahmen-Effektivität nicht bewerten (Sind die Maßnahmen wirklich wirksam?)
> - Keine Eskalations-Pfade (wer entscheidet, wenn Risk steigt?)

---

## Aufgabenbereich 5: Integration in YouTrack

### Aufgabe 5.1: Risikomaßnahmen in YouTrack konfigurieren – LÖSUNG

#### a) Struktur für YouTrack:

```
ISSUE-TYPEN & KATEGORIEN:

Issue-Typen:
- Risk (für Risikoidentifikation & Dokumentation)
- Risk Mitigation (für Maßnahmen-Implementierung)
- Risk Review (für periodische Reviews)
- Opportunity (für Chancen-Management)

Custom Fields (Fields):
- Risikoowner (User-Feld): Wer verantwortet diese Risiko/Maßnahme?
- Risk_Level (Select): High / Medium / Low
- Likelihood (Percent): 0-100%
- Impact (Monetary): €0-€1.000.000
- Risk_Value (Calculated): Likelihood × Impact
- Reaction_Strategy (Select): Avoid / Mitigate / Transfer / Accept
- Mitigation_Status (Select): Not Started / In Progress / Complete
- Target_Completion (Date): Wann soll Maßnahme fertig sein?
- Related_Risk (Link): Verknüpfung zwischen Risk und Mitigation-Issues
- Restrisiko (Percent): Residual Risk nach Maßnahme
- Business_Owner (User): Wer trägt Verantwortung auf Geschäfts-Seite?

STATUS-WORKFLOW für Risiken:
Open → Under Review → Mitigation In Progress → Monitored → Closed / Transferred

STATUS-WORKFLOW für Maßnahmen:
Planned → In Progress → On Track → Complete → Verified

Labels / Tags zur Kategorisierung:
- Risiko-Kategorien: #Technical #Personnel #Financial #External #Vendor #Scope
- Priorität: #HighPriority #MediumPriority #LowPriority
- Phase: #Planning #Execution #Closing
- Owner-Tags: #PM #DevLead #HR #Finance
- Status: #Active #Monitoring #Escalated
```

---

#### b) Issue-Template für Datenmigrations-Risiko:

```
YOUTRACK ISSUE – DATENMIGRATION

Projektname: ERP-Modernisierungsprojekt
Issue-Typ: Risk
Titel: R-DM-01: Datenmigrationsfehler – 500M Legacy-Datensätze

Priorität: High
Owner: Tom Schmidt (Data Manager, tom.schmidt@company.de)
Status: Open
Labels: #Technical #DataManagement #HighPriority #Critical_Path #Week18

═══════════════════════════════════════════════════════════════

**RISK DESCRIPTION**

**Risiko-Kategorie:** Technisch / Datenqualität

**Ausgangslage:**
- Legacy-System enthält 500 Millionen Datensätze
- Datenqualität unstrukturiert, Duplikate wahrscheinlich
- Mapping von Alt-zu-Neu-System komplex
- Migration ist kritischer Meilenstein (Woche 18)

**Risikobezeichnung:**
Datenmigration kann Fehler/Verluste enthalten → Geschäftsbetrieb gefährdet

**Mögliche Ursachen:**
- Unvollständige Anforderungs-Analyse der Legacy-Daten
- Datenformat-Inkompatibilität zwischen Systemen
- Zeitdruck in letzter Minute
- Unzureichende Test-Abdeckung

**Potenzielle Auswirkungen:**
- Datenverlust oder -Korruption (kritisch für Geschäftsbetrieb)
- Unvollständige Geschäftsinformationen im neuen System
- Notwendige Rollback/Reparatur → 2-3 Wochen Verzögerung
- Geschätzte Kosten: €150k (Reparatur, Downtime, Reputations-Schaden)

═══════════════════════════════════════════════════════════════

**RISK ASSESSMENT**

Eintrittswahrscheinlichkeit: 35% (Medium)
Auswirkung: €150k / 3 Wochen Verzögerung (High)
Risikowert: 35% × High = **7/10 (High Risk)**

Restrisiko nach Maßnahmen (geschätzt): 2/10 (Low)

═══════════════════════════════════════════════════════════════

**REACTION STRATEGY**

Strategie: MINDERN (Mitigate)

Begründung:
- Vermeiden = Projekt ist nicht möglich (Daten MÜSSEN migriert werden)
- Abwälzen = Nicht möglich (interne Legacy-Daten)
- Akzeptieren = Zu hoch-risiko (Geschäftsbetrieb kritisch)
→ Mitigation durch gründliche Vorbereitung + Testing

═══════════════════════════════════════════════════════════════

**SUB-TASKS / MITIGATION MEASURES**

[ ] **DMIT-01: Legacy-Daten-Analyse durchführen**
    Assignee: Tom Schmidt
    Due Date: 2026-01-15
    Description: Vollständige Bestandsaufnahme Legacy-Daten
    - Datenvolumen-Inventar
    - Duplikaten-Check
    - Datenqualitäts-Report
    - Mapping-Vorschlag (Alt → Neu)
    KPI: Report mit 100% Coverage abgeschlossen

[ ] **DMIT-02: ETL-Tool konfigurieren + Test-Run (small batch)**
    Assignee: Tom Schmidt
    Due Date: 2026-02-15
    Description: 
    - ETL-Tool (z. B. Talend, Informatica) installieren
    - Transformation-Rules definieren
    - Test mit 10% der Daten (50M Datensätze)
    - Fehlerquote messen
    KPI: Fehlerquote < 0,1%; Datenverlust = 0

[ ] **DMIT-03: Rollback-Prozess dokumentieren**
    Assignee: Tom Schmidt
    Due Date: 2026-02-28
    Description:
    - Backup-Strategie für Alt-System
    - Rollback-Playbook (bei Fehler: Wie stellen wir wieder her?)
    - Restore-Zeit kalkulieren
    KPI: Rollback in <1h machbar

[ ] **DMIT-04: Staging-Environment parallel Setup**
    Assignee: Tom Schmidt + Infrastructure Team
    Due Date: 2026-03-15
    Description:
    - Paralleles Staging-System für Full Migration Test
    - UAT von Datenqualität durch Business User
    - Sign-Off auf Datengenauigkeit
    KPI: Business-User geben Freigabe

[ ] **DMIT-05: Go-Live Migration durchführen (Woche 18)**
    Assignee: Tom Schmidt
    Due Date: 2026-04-21
    Description:
    - Vollständige Migration durchführen
    - Parallel-Run (Alt + Neu System 2 Wochen)
    - Fehler-Monitoring & Quick-Fix
    - Final Sign-Off
    KPI: 0 Datenverluste; alle kritischen Geschäftsdaten verfügbar

═══════════════════════════════════════════════════════════════

**MONITORING & CONTROL**

Weekly Status Check:
- Sind Sub-Tasks im Plan?
- Neue Erkenntnisse zur Legacy-Datenqualität?
- Fehlerquote im Test-Run akzeptabel?

Escalation Triggers:
- Fehlerquote > 1% → Escalate to IT-Director
- Datenverlust-Fall → Immediate Escalate to CIO
- Rollback-Prozess unvollständig → Risk reclassify as CRITICAL

Related Issues:
- Data Validation Test Plan (siehe Data_Validation_Strategy)
- Backup & Disaster Recovery Setup (siehe Infrastructure)

═══════════════════════════════════════════════════════════════

**HISTORY**

- **2026-01-05:** Risk created (Tom Schmidt)
- **2026-01-10:** Risk Review: High Priority confirmed (Data Manager Team)
```

---

#### Kommentar zu Aufgabe 5.1:

> **Kommentar:** YouTrack oder ähnliche Tools sind **ideal für Risikotracking**, weil sie:
>
> 1. **Zentrale Dokumentation** bieten (alle Risiken an einer Stelle)
> 2. **Workflows** durchsetzen (Open → Mitigation → Monitoring → Closed)
> 3. **Sub-Tasks** ermöglichen (Maßnahmen konkret planen)
> 4. **Verknüpfungen** erlauben (Risiko A löst Maßnahme M1 aus)
> 5. **Reports** ermöglichen (Trend-Analyse, Prioritäts-Verteilung)
> 6. **Zuständigkeiten** klar machen (Owner-Feld)
>
> **Best Practice:**
> - Jede Woche Review von offenen Risk-Issues
> - Completed Sub-Tasks = Maßnahmen-Fortschritt sichtbar
> - Labels helfen bei Filterung (z. B. #HighPriority #Vendor#Week18)
> - Reports zeigen: Wie viele Risiken gelöst? Wie viele offen?

---

## Aufgabenbereich 6: Checklisten und Zusammenfassungen

### Checkliste: Risikomanagementplan überprüfen – BEISPIEL-AUDIT

```
AUDIT-CHECKLISTE RISIKOMANAGEMENTPLAN

Projekt: ERP-Modernisierungsprojekt | Audit-Datum: 2026-01-15 | Auditor: Risk Manager

═══════════════════════════════════════════════════════════════

[X] Alle identifizierten Risiken haben eine Reaktionsstrategie
    ✓ R01 (Technologie) → Mindern
    ✓ R02 (Personal) → Mindern + Abwälzen
    ✓ R03 (Lieferant) → Abwälzen
    ✓ R04 (Scope) → Mindern
    ✓ R05 (Budget) → Mindern
    Status: GREEN (5/5)

[X] Jede Risikomaßnahme hat einen eindeutigen Owner
    ✓ M1 (Schulung) → Alice (Tech Lead)
    ✓ M2 (SLA) → Bob (PM)
    ✓ M3 (Change-Control) → Eva (BA)
    ✓ M4 (Mentoring) → HR Manager
    Status: GREEN (4/4)

[X] Maßnahmen sind konkret (nicht vage)
    ✗ Alte Formulierung: "Bessere Kommunikation"
    ✓ Neue Formulierung: "Wöchentliche Stakeholder-Updates mit schriftlicher Agenda"
    ✓ Alle Maßnahmen konkretisiert (Wer, Wann, Wie, Ergebnis)
    Status: GREEN (nach Überarbeitung)

[X] Erfolgs-Indikatoren sind definiert
    ✓ M1 Schulung: "Team besteht Blockchain-Quiz mit 80%+"
    ✓ M2 SLA: "Schriftliche Vereinbarung bis Woche 4"
    ✓ M3 Change-Control: "Max. 3 unkontrollierte Scope-Changes pro Monat"
    ✓ M4 Mentoring: "Junior-Dev kann nach 4 Wochen 50% von Senior-Tasks übernehmen"
    Status: GREEN (4/4)

[X] Zeitrahmen sind realistisch
    ✓ M1 Schulung: 3 Tage extern (ok, angefordert in Woche 1)
    ✓ M2 SLA: 1 Woche Verhandlung (ok, zeitig)
    ✓ M3 Change-Control: 3 Tage Setup (ok)
    ✓ M4 Mentoring: 8 Wochen Programm (ok, beginn Woche 1)
    Status: GREEN (alle realistic)

[X] Ressourcen sind kalkuliert
    ✓ M1: Schulungs-Budget €5k, Zeit 3 Tage pro Mitarbeiter (2 Mitarbeiter = 6 PT)
    ✓ M2: PM-Zeit 5 Tage Verhandlung
    ✓ M3: BA-Zeit 10 Tage für Prozess-Design
    ✓ M4: HR-Zeit 2 Stunden/Woche Koordination + Senior-Dev 10h/Woche Mentoring
    Status: GREEN (alle kalkuliert)

[X] Chancen sind identifiziert und mit Strategien versehen
    ✓ Chance A: "Kostenersparnis durch agiles Tempo" → Strategie: Exploit
    ✓ Chance B: "Zusätzliche Features durch neue Tech" → Strategie: Enhance
    Status: GREEN (2 Chancen mit Strategie)

[X] Risikoregister wird regelmäßig aktualisiert
    ✓ Review-Rhythmus: Wöchentlich (freitags 14 Uhr)
    ✓ Letzte Aktualisierung: 2026-01-15 (aktuell)
    ✓ Stakeholder erhalten Weekly Risk Report
    Status: GREEN (etablierter Rhythmus)

[X] Frühindikatoren sind definiert und werden gemessen
    ✓ Zeitverzögerung: Burndown-Abweichung >10% → Trigger
    ✓ Budget: Cost Variance >5% → Trigger
    ✓ Personal: Krankheits-Tage >5/Monat → Flag
    ✓ Akzeptanz: UAT-Abnahme-Rate <70% → Trigger
    Status: GREEN (4 Frühindikatoren aktiv)

[X] Schwellwerte für Eskalation sind dokumentiert
    ✓ Risk Value 8-10 → Eskalation to Steering Committee
    ✓ Risk Value 5-7 → Eskalation to Project Manager
    ✓ Risk Value <5 → Operational Level
    ✓ "Restrisiko nicht reduzierbar" → Escalation
    Status: GREEN (klare Schwellwerte)

[X] YouTrack oder ähnliches Tool ist konfiguriert
    ✓ Project "Risk Management" angelegt
    ✓ Custom Fields definiert (Risk_Value, Owner, Mitigation_Status)
    ✓ Sub-Tasks für Maßnahmen strukturiert
    ✓ Reports für Trend-Analyse konfiguriert
    Status: GREEN (Tool ready)

═══════════════════════════════════════════════════════════════

AUDIT-ERGEBNIS: 

🟢 GREEN – Risikomanagement ist gut strukturiert und wird aktiv verwaltet

Empfehlungen für Optimierung:
1. Chancen-Maßnahmen noch konkreter planen (z. B. "Wer führt Innovation-Session durch?")
2. Automatisierte Alerts in YouTrack für Schwellwert-Überschreitungen einrichten
3. Monthly Lessons Learned aus Risk-Erfahrungen dokumentieren (für Lessons Learned DB)

Nächster Audit: 2026-04-15 (Quartals-Review)
```

---

### Reflexionsfragen – BEISPIEL-ANTWORTEN

**Frage 1: Welche Reaktionsstrategie ist in meinen Projekten am häufigsten?**

```
BEISPIEL-ANTWORT:
In meinen bisherigen Projekten war "Akzeptieren" mit ~40% die häufigste Strategie.
Das ist wahrscheinlich nicht optimal, da es reaktiv ist.

Analyse:
- "Vermeiden" = 10% (meist nicht möglich bei laufenden Projekten)
- "Mindern" = 30% (aktive Maßnahmen, aber oft zeitlich aufwendig)
- "Abwälzen" = 20% (Lieferketten, externe Partner)
- "Akzeptieren" = 40% (zu viel! Oft Resignation statt Bewusstsein)

Ziel für nächste Projekte:
→ Mehr "Mindern" anstreben (50%) durch proaktive Planung
→ "Akzeptieren" auf 20% reduzieren (nur echte Low-Risk-Items)
→ Chancen-Management systematisch einführen (bisher ignoriert)

Konkrete Maßnahme:
- PM-Team Schulung: "Proaktives Risk Assessment" statt "Wait and See"
```

**Frage 2: Wie gut funktioniert mein aktuelles Risikomonitoring?**

```
BEISPIEL-ANTWORT:
Aktuell eher schwach (3/10 Punkten):

Probleme:
- Risikoregister wird 1× pro Quartal aktualisiert (zu selten!)
- Keine Frühindikatoren definiert → Risiken manifestieren sich überraschend
- Kein klares Eskalations-System → bei Problemen unsicher, an wen eskalieren

Positive Punkte:
- Risikoidentifikation beim Projekt-Start wird durchgeführt
- Owner sind grundsätzlich benannt

Was bräuchte es zur Verbesserung:
- Wöchentliche Risk Review in Steering Meetings (statt quartalsweise)
- Frühindikatoren definieren pro Risiko (Burndown-Abweichung, Cost Variance, etc.)
- Klare Eskalations-Pfade dokumentieren
- YouTrack-Tool einführen (statt Excel-Sheet)

Ziel: 8/10 Punkte in 3 Monaten
```

**Frage 3: Chancenmanagement in unserer Organisation?**

```
BEISPIEL-ANTWORT:
Systematisches Chancenmanagement ist bei uns praktisch nicht vorhanden.

Aktueller Stand:
- Chancen werden gelegentlich erwähnt, aber nicht strukturiert erfasst
- Keine Strategien definiert (Exploit, Enhance, Share, Accept)
- Keine Maßnahmen-Planung (im Unterschied zu Risiken)

Warum das Problem:
- Fokus liegt auf Risiken (Vermeidung von Schaden)
- Chancen werden als "Nice-to-have" gesehen, nicht als "Must-do"
- Keine Zeit/Ressourcen für Chancen-Maßnahmen eingeplant

Wie einführen:
1. Chancen-Workshop in Kickoff-Phase (parallel zu Risikoidentifikation)
2. Chancen-Register ähnlich wie Risikoregister führen
3. Für Top-3-Chancen konkrete Maßnahmen planen
4. Quarterly Review für Chancen (ähnlich Risiken)

Erwarteter Nutzen:
- Zusätzliche Kosteneinsparungen €20-50k pro Projekt
- Bessere Qualität durch Innovationen
- Höhere Stakeholder-Zufriedenheit
```

**Frage 4: Hürden bei Risikoowner-Festlegung?**

```
BEISPIEL-ANTWORT:
Ja, wir haben einige Hürden bei der Owner-Festlegung:

Hürden:
1. Unklare Verantwortlichkeit ("Ist das meine Aufgabe oder des PMs?")
2. Owner lehnen ab, weil "zusätzliche Arbeit ohne Budget"
3. Hierarchie-Probleme (Risikoowner ist nicht am höchsten, kann aber nicht delegieren)
4. Zeitmangel (Owner sagen: "Keine Zeit für Risikomaßnahmen")

Lösungsansätze:
1. Matrix: Klare Definitionen wer Owner für welche Risikokategorie ist
   - Technische Risiken → Tech Lead
   - Personalrisiken → HR
   - Budgetrisiken → CFO/Finance
   - Stakeholder-Risiken → Business Analyst

2. Ressourcen-Budgetierung: PM plant 10-15% der Projekt-Zeit für Risikomaßnahmen ein
   → Owner haben Zeit eingeplant

3. Anreize: "Risk Management Excellence" als Performance-Kriterium aufnehmen

4. Klare Eskalation: "Wenn Risikomaßnahme nicht umgesetzt wird → eskalieren"

Erfolgs-Messung:
- 95% der Risikomaßnahmen werden eingeplant
- 80% werden im Plan umgesetzt
- Risiken-Reduktion um 30% in laufenden Projekten
```

---

#### Kommentar zu den Reflexionsfragen:

> **Kommentar:** Diese Reflexionsfragen dienen der **Selbstbewertung und Handlungsplanung.** Sie helfen Teilnehmenden:
> 
> 1. **Ihre aktuelle Praxis zu evaluieren** (Ist mein PM gut? Nicht so gut?)
> 2. **Lücken zu erkennen** (Chancenmanagement = ignoriert!)
> 3. **Konkrete Verbesserungen zu planen** (nicht: "besseres Risk Management", sondern: "Weekly Risk Review + Frühindikatoren")
> 4. **Übertragung in die Praxis** (Die Learnings sofort im nächsten Projekt anwenden)
>
> **Wichtig:** Reflexion ohne Aktion = nichts. Die beste Praxis ist, diese Punkte im nächsten Projekt umzusetzen.

---

## Zusammenfassung – Kernel Learning

### **Warum Reaktionsplanung wichtig ist:**

Risikoidentifikation allein bringt nichts → **Maßnahmen müssen konkret geplant und umgesetzt werden.**

### **Die 4 Reaktionsstrategien (Negative Risiken):**

| Strategie | Wann | Wirkung | Beispiel |
|-----------|------|--------|---------|
| **Vermeiden** | Existenz-Risiken | Risiko weg, aber oft teuer/unmöglich | Neue Technologie weglassen |
| **Mindern** | Häufigste Strategie | Risiko kleiner, pragmatisch | Schulung, Redundanz, Puffer |
| **Abwälzen** | Externe Risiken | Verantwortung auf Dritte | Versicherung, SLA, Outsourcing |
| **Akzeptieren** | Low-Risk oder unvermeidbar | Kontingency Budget planen | Kleine Verzögerungen |

### **Chancenmanagement (4 Strategien):**

Nutzen → Verstärken → Teilen → Akzeptieren

### **Risikomaßnahmen-Qualitätsmerkmale:**

✓ Konkret (nicht vage)
✓ Owner benannt (Wer verantwortet?)
✓ Erfolgs-Indikatoren definiert (Wie gemessen?)
✓ Zeitlich geplant (Start, Ende, Abhängigkeiten)
✓ Ressourcen kalkuliert (Budget, Personen, Tools)
✓ ROI bewertet (Aufwand vs. Nutzen)

### **Monitoring & Controlling:**

→ **Frühindikatoren** tracken (nicht erst reagieren, wenn Risiko manifesthiert)
→ **Risikoregister** regelmäßig pflegen (wöchentlich oder 2-wöchentlich)
→ **Eskalationspfade** klar definieren (wer muss wann informiert werden?)
→ **Restrisiko** nach Maßnahmen bewerten (Wirkt die Maßnahme?)

### **YouTrack & Tools:**

Zentrale Dokumentation aller Risiken, Maßnahmen, Owner, Status, Trends → **Transparenz + Nachverfolgung**

---

## Empfehlung für die Praxis

1. **Im nächsten Projekt:** Etablieren Sie ein Risikoregister mit wöchentlicher Review
2. **Frühindikatoren:** Definieren Sie 3-5 Frühindikatoren pro Risikokategorie
3. **Risikoowner:** Klare Zuordnung, nicht alles beim PM
4. **Chancen:** Mindestens die Top-3-Chancen mit Maßnahmen planen
5. **Tool:** YouTrack oder Excel-Sheet mit strukturiertem Aufbau
6. **Rhythmus:** Wöchentliche Risk Review (15-20 Min), Quarterly In-Depth Review

