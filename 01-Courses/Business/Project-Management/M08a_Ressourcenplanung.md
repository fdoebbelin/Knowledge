## Überblick und Lernziele

Dieses Modul befasst sich mit der systematischen Planung und Verwaltung von Ressourcen (Mitarbeitern, Material, Finanzmitteln) im Projektkontext. Nach Abschluss dieses Moduls werden Sie in der Lage sein:

- **Ressourcentypen** zu identifizieren und zu klassifizieren
- **Kapazitätsplanung** durchzuführen und Engpässe zu erkennen
- **Ressourcenallokation** (Zuweisung von Ressourcen) durchzuführen
- **Ressourcen-Leveling** (Kapazitätsausgleich) durchzuführen und Konflikte zu lösen
- **Engpässe und Konflikte** zu erkennen und konstruktiv zu bearbeiten
- **Ressourcenpläne** zu erstellen und zu überwachen
- **YouTrack** zur Ressourcenverfolgung einzusetzen

---

## 1. Grundlagen der Ressourcenplanung

### 1.1 Definition: Was ist Ressourcenplanung?

Die **Ressourcenplanung (Resource Planning)** ist der Prozess der systematischen Identifikation, Zuteilung und Verwaltung aller Ressourcen, die ein Projekt benötigt, um die geplanten Aktivitäten durchzuführen und Ziele zu erreichen. Sie beantwortet die Frage: *Wer macht was, wann, mit welchem Material und welchem Budget?*

### 1.2 Warum ist Ressourcenplanung wichtig?

**Schlüsselbedeutung für Projekterfolg:**

- **Termine realistisch machen:** Aktivitäten können oft nur so schnell ablaufen, wie die Ressourcen verfügbar sind
- **Kosten kontrollieren:** Überallokation (Überauslastung) führt zu Ineffizienz und höheren Kosten
- **Qualität sichern:** Überarbeitete oder mangelnd ausgebildete Ressourcen produzieren Fehler
- **Risiken minimieren:** Engpässe frühzeitig erkennen und gegensteuern
- **Stakeholder-Erwartungen managen:** Klare Zuständigkeiten reduzieren Missverständnisse

**Häufige Probleme ohne gute Ressourcenplanung:**

- Mitarbeiter sind überbelastet oder unterbeschäftigt
- Termine rutschen aus, weil die rechtzeitige Verfügbarkeit nicht geplant wurde
- Qualität leidet durch Zeitmangel und Stress
- Ressourcen-Konflikte zwischen mehreren Projekten
- Finanzbudgets werden überschritten

---

## 2. Ressourcentypen und -kategorien

### 2.1 Die drei Hauptressourcentypen

| **Ressourcentyp** | **Beschreibung** | **Beispiele** |
|---|---|---|
| **Humanressourcen (Human Resources)** | Mitarbeiter mit spezifischen Qualifikationen und Fähigkeiten | Projektleiter, Entwickler, Designer, Tester, Consultant |
| **Materialressourcen (Material Resources)** | Sachgüter, Ausrüstung, Verbrauchsmaterial | Büromaterial, Maschinen, Werkzeuge, Rohstoffe, Hardware |
| **Finanzressourcen (Financial Resources)** | Budgetmittel für direkte und indirekte Projektkosten | Gehälter, Material, externe Dienstleistungen, Betriebskosten |

### 2.2 Spezifikation von Humanressourcen

Humanressourcen erfordern besondere Aufmerksamkeit, da sie den größten Kostenfaktor in den meisten Projekten ausmachen:

**Klassifikation nach Qualifikation:**

- **Senior-Entwickler:** Höchste Expertise, höchste Kosten, aber effizienter
- **Mid-Level-Entwickler:** Mittlere Expertise und Kosten
- **Junior-Entwickler:** Niedrigere Kosten, benötigt aber Anleitung und braucht länger
- **Praktikant/Auszubildender:** Niedrigste Kosten, höchster Betreuungsaufwand

**Klassifikation nach Verfügbarkeit:**

- **Dediziert:** 100% im Projekt eingesetzt
- **Teilzeit:** 50%, 25% oder andere Quoten im Projekt
- **Beratung/On-Demand:** Nur bei Bedarf verfügbar, z. B. für Spezialaufgaben

---

## 3. Kapazitätsplanung

### 3.1 Definition und Ziel

**Kapazitätsplanung (Capacity Planning)** ist die Analyse der verfügbaren Ressourcen im Hinblick auf die geplanten Arbeitsmengen. Sie beantwortet:

- **Wie viele Ressourcen brauchen wir?**
- **Wann werden sie benötigt?**
- **Sind die Ressourcen verfügbar?**
- **Müssen wir externe Ressourcen beschaffen?**

### 3.2 Kapazität: Konzept und Berechnung

**Kapazität** ist die verfügbare Arbeitszeit einer Ressource (Stunden, Tage, Wochen).

**Berechnung der verfügbaren Kapazität einer Person:**

```
Verfügbare Kapazität (in Stunden) = Wochenarbeitszeit × Anzahl Wochen × Verfügbarkeitsquote

Beispiel:
- Wochenarbeitszeit: 40 Stunden
- Projektdauer: 10 Wochen
- Verfügbarkeitsquote: 80% (weil die Person auch in anderen Projekten arbeitet)
- Verfügbare Kapazität = 40 × 10 × 0,8 = 320 Stunden
```

### 3.3 Erforderliche vs. verfügbare Kapazität

**Erforderliche Kapazität** = Summe der Aktivitätsdauern, die eine Ressource durchführen muss

**Verfügbare Kapazität** = realistische Arbeitszeit, die eine Ressource zur Verfügung hat

**Engpass-Situation:**
```
Wenn: Erforderliche Kapazität > Verfügbare Kapazität
Dann: ENGPASS - Maßnahmen erforderlich!
```

### 3.4 Kapazitätsanalyse durchführen

**Schritt-für-Schritt-Prozess:**

1. **Alle Aktivitäten mit Ressourcenbedarf erfassen** (aus dem Zeitplan)
2. **Für jede Person die verfügbare Kapazität berechnen**
3. **Aktivitäten pro Person pro Zeitperiode (z. B. pro Woche) aufsummieren**
4. **Vergleich: Erforderlich vs. Verfügbar**
5. **Engpässe identifizieren**
6. **Maßnahmen planen**

**Beispiel-Kapazitätstabelle:**

| **Woche** | **Max. verfügbar (Stunden)** | **Geplant (Stunden)** | **Status** | **Auslastung** |
|---|---|---|---|---|
| Woche 1 | 40 | 32 | OK | 80% |
| Woche 2 | 40 | 48 | ⚠️ ENGPASS | 120% |
| Woche 3 | 40 | 40 | OK | 100% |
| Woche 4 | 40 | 20 | Unterauslastung | 50% |

---

## 4. Ressourcenallokation

### 4.1 Definition

**Ressourcenallokation (Resource Allocation)** ist die konkrete Zuweisung von Ressourcen zu Aktivitäten. Sie legt fest: *Wer führt welche Aktivität durch?*

### 4.2 Kriterien für Allokationsentscheidungen

Bei der Zuweisung von Ressourcen zu Aktivitäten beachten Sie:

| **Kriterium** | **Beschreibung** | **Beispiel** |
|---|---|---|
| **Qualifikation & Fachkompetenz** | Die Ressource muss die erforderlichen Fähigkeiten haben | JavaScript-Entwicklung nur an Entwickler mit JS-Kenntnissen |
| **Verfügbarkeit** | Ist die Ressource zum benötigten Zeitpunkt frei? | Nicht mehrfach überbuchen |
| **Erfahrung** | Senior vs. Junior – Effizienz und Lernbedarf | Komplexe Aufgaben: Senior; Routineaufgaben: Junior mit Anleitung |
| **Entwicklung** | Können Junior-Mitarbeiter hier lernen und wachsen? | Ausbildungsaufgaben gezielt zuteilen |
| **Verteilung & Motivation** | Gerechte Verteilung, Vermeidung von Langeweile/Burnout | Abwechslungsreiche Aufgaben, Engagement |
| **Kosten** | Kostenoptimal: Junior für einfach Aufgaben, Senior für Knifflige | Kosteneffizienz ohne Qualitätseinbußen |
| **Zeitzone & Ortsunabhängigkeit** | Bei verteilten Teams: Arbeitszeit-Überlaps, Koordination | Remote-Arbeit erfordert asynchrone Kommunikation |

### 4.3 Ressourcen-Allokations-Matrix

Eine **Ressourcen-Allokations-Matrix** zeigt die Zuordnung auf einen Blick:

| **Aktivität** | **Verantwortung** | **Unterstützung** | **Dauer** | **Kapazität** |
|---|---|---|---|---|
| Anforderungen sammeln | Anna (Senior PM) | Michael (Analyst) | 2 Wochen | 20h/Woche |
| Datenbankdesign | Tom (DBA) | Felix (Junior Dev) | 3 Wochen | 30h/Woche |
| UI-Design | Lisa (Designer) | --- | 2 Wochen | 40h/Woche |
| Frontend-Entwicklung | Felix, Kai (Devs) | Lisa (Design-Support) | 4 Wochen | 30h/Woche je |

---

## 5. Ressourcen-Leveling (Kapazitätsausgleich)

### 5.1 Definition und Ziel

**Ressourcen-Leveling (oder Resource Leveling)** ist ein Verfahren zur Vermeidung oder Auflösung von Ressourcen-Engpässen, indem die zeitliche Anordnung von Aktivitäten so angepasst wird, dass eine gleichmäßigere Auslastung der Ressourcen erreicht wird.

**Ziele:**

- Keine Überallokation (über 100%) der Ressourcen
- Möglichst gleichmäßige Auslastung erhalten (ideal: 75–95%)
- Termine oder Qualität nicht gefährden

### 5.2 Szenarien und Strategien

**Szenario 1: Ressourcen-Engpass ohne Reserve-Kapazität**

Problem: Es sind nicht genug Kapazitäten vorhanden.

Lösungsstrategien:
- **Neue Ressourcen beschaffen** (neue Mitarbeiter, externe Contractor)
- **Aufgaben extern vergeben** (Outsourcing)
- **Projektumfang (Scope) reduzieren** (weniger Aktivitäten, weniger Qualität? – Vorsicht!)
- **Zeitplan verlängern** – Aktivitäten später verschieben, um gleichmäßigere Last
- **Prioritäten neu bewerten** – Was ist wirklich essentiell?

**Szenario 2: Ressourcen ungleich verteilt (Peaks und Täler)**

Problem: Einige Wochen völlig überbelastet, andere unterlastet.

Lösungsstrategien:
- **Pufferaktivitäten verschieben** – Aktivitäten ohne kritischen Pfad zeitlich flexibel anordnen
- **Aktivitäten umstrukturieren** – Phasen umgestalten, um Last zu verteilen
- **Mitarbeiter wechseln** – Ressourcen zwischen Aktivitäten umverteilen (sofern möglich)
- **Parallelisierung reduzieren** – Weniger parallel, mehr sequenziell (aber: vorsichtig mit Terminplan!)

**Szenario 3: Zu viele gute Optionen, zu wenig Zeit**

Problem: Mehrere hochwertige Aktivitäten konkurrieren um knappe Ressourcen.

Lösungsstrategien:
- **Prioritätsmatrix nutzen** (Impact vs. Effort)
- **Sequenzierung nach Abhängigkeiten** – Was muss zuerst fertig sein?
- **Ressourcen-Sharing** – Personen teilweise umverteilen (z. B. 60%/40%)

### 5.3 Praktisches Beispiel: Resource Leveling durchführen

**Ausgangssituation:**

Projekt „Website-Relaunch". Ein Entwickler (Max) brauchen wird für:
- Woche 1: Frontend (30h) + Datenbank (20h) = 50h (⚠️ Engpass!)
- Woche 2: Frontend (40h) = 40h (OK)
- Woche 3: Datenbank (50h) = 50h (⚠️ Engpass!)
- Woche 4: Testing (10h) = 10h (OK)

Verfügbarkeit Max: 40h/Woche

**Leveling-Maßnahmen:**

| **Original** | **Problem** | **Maßnahme** | **Neu** | **Status** |
|---|---|---|---|---|
| Woche 1: FE+DB (50h) | Engpass | Datenbank auf Woche 0 vorbereiten; Felix unterstützt | Max W1: FE (30h), Felix W0: DB (20h) | ✅ Gelöst |
| Woche 3: DB (50h) | Engpass | Datenbank-Phase in W2–W3 splitten | Max W2: DB (20h), W3: DB (30h) | ✅ Gelöst |

**Ergebnis nach Leveling:**
- Woche 0: Felix 20h
- Woche 1: Max 30h (FE)
- Woche 2: Max 40h (20h DB + 20h FE) – Gleichmäßige Last
- Woche 3: Max 30h (30h DB)
- Woche 4: Max 10h (Testing)

---

## 6. Ressourcen-Konflikte und deren Auflösung

### 6.1 Arten von Ressourcen-Konflikten

**Konflikt 1: Mehrfachzuteilung (Double-Booking)**

Eine Ressource soll gleichzeitig in zwei Projekten arbeiten – unmöglich.

Beispiel: Max soll Montag 9–12 Uhr an Projekt A und 10–13 Uhr an Projekt B arbeiten.

**Konflikt 2: Engpass-Konflikt**

Mehrere Aktivitäten brauchen gleichzeitig die gleiche Spezialist-Ressource.

Beispiel: Der einzige DBA ist in drei Projekten eingeplant, hat aber nur 40h/Woche.

**Konflikt 3: Kompetenz-Lücke**

Aktivitäten brauchen Fähigkeiten, die niemand hat.

Beispiel: Python-Entwicklung erforderlich, aber nur C#-Programmierer im Team.

**Konflikt 4: Budget-Engpass**

Ausgeplante Ressourcen sind verfügbar, aber nicht im Budget.

Beispiel: Senior-Entwickler würde 4 Wochen kosten, Budget nur für 2 Wochen.

**Konflikt 5: Zeitzone- und Koordinationsprobleme**

In verteilten Teams: Unterschiedliche Arbeitszeiten erschweren Abstimmung.

Beispiel: Team in Indien (IST), Team in Deutschland (CET) – 5,5 Stunden Unterschied.

### 6.2 Konfliktauflösungs-Strategien

| **Strategie** | **Beschreibung** | **Wann sinnvoll?** | **Risiken** |
|---|---|---|---|
| **Priorisierung** | Aktivitäten nach Wichtigkeit ordnen; höhere Priorität erhält Ressource | Klar definierte Prioritäten | Andere Projekte leiden |
| **Umverteilung** | Ressourcen zwischen Projekten verschieben | Gewisse Flexibilität vorhanden | Kann andere Projekte gefährden |
| **Beschaffung** | Neue interne oder externe Ressourcen | Budget vorhanden | Zeitverzögerung durch Onboarding |
| **Outsourcing** | Aufgaben an externe Partner vergeben | Spezialisierte, hochpreisige Aufgaben | Kontrolle, Qualität, Abhängigkeit |
| **Terminverschiebung** | Aktivitäten zeitlich verschieben | Puffer verfügbar, Abhängigkeiten erlauben | Projektende verzögert sich |
| **Scope-Reduktion** | Aktivitäten oder Features reduzieren | Nicht-kritische Features, Akzeptanz vorhanden | Qualität/Features sinken |
| **Skill-Entwicklung** | Junior-Mitarbeiter durch Training aufbauen | Zeit vorhanden, längerfristiges Engagement | Kurzfristig: langsamere Bearbeitung |
| **Kooperation & Sharing** | Ressourcen teilweise teilen oder übergeben | Aufgaben teilbar, gute Dokumentation | Koordinationsaufwand |

### 6.3 Konfliktauflösungs-Prozess

**Systematischer Ablauf:**

```
1. KONFLIKT IDENTIFIZIEREN
   ↓
2. URSACHE ANALYSIEREN
   ↓
3. OPTIONEN ENTWICKELN (mehrere Lösungen)
   ↓
4. AUSWIRKUNGEN BEWERTEN
   (Kosten, Zeit, Risiken, Qualität)
   ↓
5. ENTSCHEIDUNG TREFFEN
   (mit Stakeholder, Sponsor)
   ↓
6. MAßNAHME UMSETZEN
   ↓
7. WIRKSAMKEIT ÜBERWACHEN
```

---

## 7. Ressourcen-Monitoring und Tracking

### 7.1 Warum Monitoring wichtig ist

Ressourcenpläne sind Vorhersagen. Die Realität kann abweichen:

- Mitarbeiter werden krank
- Unerwartete Prioritätsänderungen
- Aufgaben dauern länger als geplant
- Neue Anforderungen tauchen auf
- Ressourcen sind nicht wie geplant verfügbar

**Regelmäßiges Monitoring** hilft, früh gegenzusteuern.

### 7.2 Monitoring-Indikatoren

| **Indikator** | **Bedeutung** | **Zielwert** | **Maßnahme bei Abweichung** |
|---|---|---|---|
| **Ressourcen-Auslastung** | % der geplanten vs. verfügbaren Kapazität | 75–95% | >95%: Überbelastung → Reduzierung; <50%: Unterbelastung → Umverteilung |
| **Verfügbarkeitsgrad** | Sind Ressourcen tatsächlich verfügbar? | 100% wie geplant | Wenn nicht: Alternativressourcen; Prioritätsanpassung |
| **Kompetenz-Match** | Sind Qualifikationen vorhanden? | 100% | Weiterbildung; Coaching; Replacement |
| **Turnover-Rate** | Wie viele Mitarbeiter verlassen das Projekt/Team? | 0–10%/Jahr | Zu hoch: Anreize; Arbeitsklima verbessern |
| **Produktivität** | Output pro Ressource und Stunde | Basierend auf historischen Daten | Abweichung → Analyse: Blockierungen? Training? Prozess? |
| **Burndown (Agile)** | Noch verbleibende Arbeit vs. Zeit | Ideal: Linear Abfall | Zu steil: Scope-Creep; Zu flach: Blockierungen |

### 7.3 Tracking mit YouTrack

**YouTrack** ist ein Issue-Management- und Projekt-Tracking-Tool, das Sie kursbegleitend kennenlernen. Zur Ressourcenverwaltung nutzen Sie:

**Wichtige YouTrack-Features für Ressourcen-Tracking:**

1. **Issues/Tickets erstellen und zuweisen**
   - Jede Aktivität = ein Issue
   - Issue → Assignee (Verantwortung zuweisen)
   - Schätzung (Estimation) in Story Points oder Stunden
   - Status: Open, In Progress, Done

2. **Time Tracking**
   - Zeit pro Issue loggen (z. B. "4h" für Task erledigt)
   - Vergleich: Geplant vs. Aktuell
   - Erkennung von Überschreitungen

3. **Workload-View**
   - Übersicht, wie viele Issues pro Person ausstehen
   - Belastungsbalance erkennen

4. **Reports & Dashboards**
   - Auslastungsdiagramme
   - Burndown-Charts
   - Velocity-Tracking (Agile)

5. **Prioritäten & Abhängigkeiten**
   - Issues mit Priorität versehen
   - Abhängigkeiten zwischen Issues definieren
   - "Blocks", "Depends on" Relationen

---

## 8. Best Practices und häufige Fehler

### 8.1 Best Practices

| **Best Practice** | **Beschreibung** | **Vorteil** |
|---|---|---|
| **Frühzeitige Planung** | Ressourcenplanung beginnt in der Initialisierung, nicht erst bei Risiken | Proaktiv statt reaktiv; Zeit für Maßnahmen |
| **Puffer einkalkulieren** | Nicht jede verfügbare Stunde verplanen; 10–20% Reserve | Flexibilität bei Unvorhergesehenem |
| **Regelmäßige Abstimmung** | Wöchentliche/monatliche Ressourcen-Reviews | Probleme früh erkennen |
| **Klare Verantwortung (RACI)** | Eindeutige Rollenverteilung; keine Doppelzuständigkeit | Keine Missverständnisse; klare Accountability |
| **Dokumentation** | Alle Allokationen, Konflikte, Entscheidungen dokumentieren | Nachvollziehbarkeit; Learning |
| **Kommunikation mit HR** | Abstimmung mit Personalabteilung wegen Verfügbarkeit | Realistischere Planung; weniger Ausfälle |
| **Kontinuierliche Optimierung** | Nach Projekt: Lektionen sammeln (Was klappte? Was nicht?) | Verbesserung für nächste Projekte |

### 8.2 Häufige Fehler (und wie man sie vermeidet)

| **Fehler** | **Symptom** | **Ursache** | **Wie vermeiden** |
|---|---|---|---|
| **Zu aggressive Planung** | "Alle brauchen 150% ihrer Zeit" | Optimismus; Druck durch Sponsor | Realistische Schätzungen; Puffer |
| **Unberücksichtigte Nebenaufgaben** | "Wir haben nur 20h eingeplant, aber 30h Meetings!" | Overhead nicht kalkuliert | 20–30% Overhead für Admin, Meetings einrechnen |
| **Keine Verfügbarkeitsdaten** | "Max ist 100% im Projekt eingeplant, arbeitet aber auch noch für den HOL-Support" | Keine Abstimmung mit anderen Stakeholdern | Verfügbarkeit klären: Wie viel % wirklich frei? |
| **Ignorieren von Kompetenzen** | "Assign an irgendjemand, der Zeit hat" | Oberflächliche Ressourcenplanung | Qualifikation checken; evtl. Training planen |
| **Keine Flexibilität** | "Das ist der Plan – abweichen ist nicht möglich" | Starre Denke | Szenarioplanung; mehrere Optionen |
| **Zu viele Kontextwechsel** | Person arbeitet mit 10% Attention an 10 verschiedenen Projekten | Zu feinkörnige Verteilung | Blocks von mind. 1–2 Wochen; weniger Projekte gleichzeitig |
| **Vernachlässigung von Teamfähigkeit** | "Er kann programmieren, aber sabotiert das Teamgefüge" | Nur Hard Skills beachtet | Auch Soft Skills, Teamfähigkeit einschätzen |

---

## 9. Praktisches Vorgehen: Ressourcenplan erstellen

### 9.1 Schritt-für-Schritt (für Anfänger)

**Phase 1: Vorbereitung**

1. **Alle Aktivitäten aus dem Zeitplan auflisten**
   - Quelle: Netzplan oder Gantt-Diagramm aus Modul 6–7
   - Jede Aktivität mit Dauer, Abhängigkeiten

2. **Verfügbare Ressourcen inventarisieren**
   - Wer gehört zum Team?
   - Kapazität pro Person (% für Projekt)
   - Qualifikationen, Erfahrung
   - Verfügbarkeitszeiträume

**Phase 2: Allokation**

3. **Aktivitäten auf Ressourcen zuordnen**
   - Kriterium 1: Qualifikation (kann diese Person das?)
   - Kriterium 2: Verfügbarkeit (ist sie zeitlich frei?)
   - Kriterium 3: Balance (nicht überlasten)
   - Werkzeug: RACI-Matrix oder Zuordnungstabelle

4. **Zeitliche Details klären**
   - Start und Ende pro Zuordnung
   - Kapazität (% oder Stunden pro Woche)
   - Abhängigkeiten berücksichtigen

**Phase 3: Analyse & Balancierung**

5. **Kapazitätsdiagramm erstellen**
   - X-Achse: Zeit (Wochen/Monate)
   - Y-Achse: Stunden/% Auslastung
   - Pro Person pro Zeitraum: Summe der geplanten Stunden

6. **Engpässe identifizieren** (>100% in einer Woche)

7. **Leveling durchführen**
   - Engpässe auflösen
   - Strategie wählen (neue Ressourcen? Termin verschieben? Scope reduzieren?)

**Phase 4: Dokumentation & Kommunikation**

8. **Ressourcenplan dokumentieren**
   - Tabellen, Diagramme, Zuordnungen

9. **Mit dem Team besprechen**
   - Sind die Erwartungen klar?
   - Ist die Belastung realistisch?
   - Gibt es Bedenken?

10. **Mit Stakeholdern (Sponsor, PMO) abstimmen**
    - Genehmigung
    - Ressourcenreserven/Kontingente

---

## 10. Übersicht: Ressourcenplanung in YouTrack

Während Sie die kommenden Module durcharbeiten, werden Sie sehen, wie YouTrack die Ressourcenverwaltung unterstützt:

| **YouTrack-Feature** | **Nutzen für Ressourcenplanung** |
|---|---|
| **Assignees** | Klare Zuordnung: Wer bearbeitet welches Issue |
| **Time Tracking/Spent Time** | Tatsächliche Arbeitszeit vs. Schätzung; Engpässe erkennen |
| **Custom Fields** | "Ressourcentyp", "Qualifikation", "Verfügbarkeit" hinzufügen |
| **Agile Board (Sprints)** | In Sprints: Workload pro Person übersichtlich |
| **Reports** | Auslastungsberichte, Kapazitätsanalysen |
| **Notifications & Reminders** | Team bleibt auf dem Laufenden |

---

## 11. Zusammenfassung der Kernkonzepte

| **Konzept** | **Kurzerklärung** |
|---|---|
| **Ressourcenplanung** | Systematische Planung von Human-, Material- und Finanzressourcen |
| **Kapazität** | Verfügbare Arbeitszeit einer Ressource (Stunden, Tage, Wochen) |
| **Allokation** | Konkrete Zuweisung von Ressourcen zu Aktivitäten |
| **Leveling** | Anpassung der Zeitpläne zur gleichmäßigeren Auslastung |
| **Engpass** | Situation, in der die erforderliche Kapazität die verfügbare übersteigt |
| **Konflikt** | Widerspruch bei der Ressourcenzuteilung (z. B. doppelte Zuweisung) |
| **Workload** | Gesamtbelastung einer Person durch alle zugeordneten Aktivitäten |
| **Overhead** | Zeit für Meetings, Admin, Kommunikation (oft unterschätzt) |
| **RACI** | Matrix für klare Rollenverteilung (Responsible, Accountable, Consulted, Informed) |

---

## 12. Lernhilfen und Glossar

**Wichtige englische Begriffe (mit deutscher Übersetzung):**

- **Resource Leveling** = Ressourcen-Leveling / Kapazitätsausgleich
- **Capacity Planning** = Kapazitätsplanung
- **Resource Allocation** = Ressourcenallokation / Ressourcenzuweisung
- **Overallocation** = Überallokation / Überbelastung
- **Double-Booking** = Mehrfachbuchung
- **Workload** = Arbeitsbelastung
- **Burndown** = Abbau der offenen Aufgaben
- **Velocity** = Geschwindigkeit (Agile: verrichtete Arbeit pro Sprint)
- **Time Tracking** = Zeiterfassung
- **Assignee** = Verantwortliche Person