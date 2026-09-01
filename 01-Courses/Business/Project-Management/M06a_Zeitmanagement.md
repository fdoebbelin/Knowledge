# Modul 6a: Zeitmanagement I – Grundlagen

## Modulübersicht

Zeitmanagement ist eine der Kernaufgaben des Projektmanagements. In Modul 6 werden die **grundlegenden Konzepte und Methoden des Zeitmanagements** behandelt. Dieses Modul bildet die Basis für die Vertiefung in Modul 7 und legt den Fokus auf die systematische Planung von Aktivitäten, die Darstellung von Abhängigkeiten sowie die Berechnung realistischer Zeitpläne.

### Lernziele

Nach Abschluss dieses Moduls können die Teilnehmer:

- **Meilensteine und Aktivitäten** korrekt definieren und voneinander unterscheiden
- **Aktivitätssequenzierung** durchführen und Abhängigkeiten erkennen
- **Netzplantechniken** (CPM, PERT) anwenden und interpretieren
- Den **kritischen Pfad** ermitteln und dessen Bedeutung für Terminplanung verstehen
- **Schätzverfahren** für Aktivitätsdauern anwenden
- Die Grundlagen für YOUTRACK-basierte Zeitplanverwaltung verstehen

---

## 1. Meilensteine und Aktivitäten

### 1.1 Konzeptionelle Grundlagen

#### Meilensteine (Milestones)

Ein **Meilenstein** ist ein besonderer Projektereignis mit Bezug auf ein Termin, das:

- **Einen Punkt in der Zeit** darstellt (keine Dauer)
- **Bedeutende Ereignisse** markiert (z. B. Projektstart, Phase-Ende, Deliverable-Übergabe)
- **Keine Ressourcen verbraucht**, aber häufig **Abhängigkeiten erzeugt**
- **Stakeholder-Kommunikation** vereinfacht (leicht merkbare Termine)
- **Kontrollpunkte** für das Projektsteuerung bietet

**Typische Meilensteine:**
- Kick-Off
- Anforderungs-Release
- Design-Review (Design Review abgeschlossen)
- Testbeginn
- Go-Live (Produktivstart)
- Projektabschluss

#### Aktivitäten (Activities / Tasks)

Eine **Aktivität** ist eine diskrete, ausführbare Arbeitseinheit, die:

- **Eine zeitliche Dauer** hat (gemessen in Tagen, Wochen oder Stunden)
- **Ressourcen verbraucht** (Personal, Material, Budget)
- **Ergebnisse / Deliverables** produziert
- **Abhängigkeiten** zu anderen Aktivitäten haben kann
- **Geschätzte Dauer** auf Basis von Erfahrung und Aufwandsschätzung erhält

**Charakteristiken guter Aktivitäten:**
- Eindeutig definiert und verständlich
- Unabhängig prüfbar und nachverfolgbar
- Mit realistischen Ressourcen planbar
- Mit messbaren Anfang und Ende
- Angemessen granular (nicht zu klein, nicht zu groß)

### 1.2 Unterscheidung und Abgrenzung

| Aspekt | Meilenstein | Aktivität |
|--------|-----------|-----------|
| **Dauer** | 0 (Punkt in der Zeit) | > 0 (zeitlicher Umfang) |
| **Ressourcen** | Keine | Ja, definiert |
| **Ergebnis** | Markiert ein Ereignis | Produziert Deliverable |
| **Abhängigkeiten** | Häufig Vorgänger/Nachfolger | Kann Vor- und Nachgänger haben |
| **Aufwand** | Kein Aufwand | Messbarer Aufwand |
| **Beispiel** | „Design genehmigt" | „Designdokumentation erstellen" |

### 1.3 Best Practices zur Definition

1. **Meilensteine sparsam setzen**: 5–15 Meilensteine für durchschnittliche Projekte (nicht zu viele!)
2. **Verständlichkeit sichern**: Begriffe, die alle Stakeholder verstehen
3. **Messbarkeit gewährleisten**: Klare Kriterien für Erreicht/Nicht-erreicht
4. **Kritische Momente markieren**: Risk-Gates, Gated-Phase-Modelle (Stage-Gate)
5. **Aktivitäten konkret**: „SQL-Datenbankschema implementieren" statt „Datenbank"

---

## 2. Aktivitätssequenzierung und Abhängigkeiten

### 2.1 Arten von Abhängigkeiten

**Logische Abhängigkeiten (Sequenzen)**

| Abhängigkeitstyp | Notation | Erklärung | Beispiel |
|-----------------|----------|-----------|---------|
| **Ende-Anfang (Finish-to-Start, FS)** | A → B | Aktivität B kann erst nach A enden beginnen | Design abschließen → Entwicklung beginnen |
| **Anfang-Anfang (Start-to-Start, SS)** | A ↗ B | Aktivität B kann beginnen, wenn A begonnen hat | Anforderungsanalyse → Design kann parallel starten |
| **Ende-Ende (Finish-to-Finish, FF)** | A ↘ B | Aktivität B muss zeitgleich oder später mit A enden | Entwicklung → Testing |
| **Anfang-Ende (Start-to-Finish, SF)** | A ↙ B | Eher selten; z. B. Übergabe von Legacy auf Neusystem | Altsystem läuft → Neusystem muss übernehmen |

**Versätze (Lags und Leads)**

- **Lag (Verzögerung)**: Nach FS-Abhängigkeit 2 Tage warten (z. B. Trocknungszeit)
- **Lead (Vorlauf)**: Aktivität kann 3 Tage vor Vorgänger-Ende beginnen (z. B. Überlappung)

### 2.2 Sequenzierungsprozess (YOUTRACK-Integration)

1. **Aktivitätsliste** aus WBS ableiten (vgl. Modul 5)
2. **Vorgänger und Nachfolger** identifizieren (Workflow-Logik)
3. **Abhängigkeitstyp** festlegen (meist FS, selten andere)
4. **Lags/Leads** dokumentieren (wenn nicht-trivial)
5. **In Netzplan visualisieren** (Netzdiagramm oder Gantt)
6. **In YOUTRACK abbilden**: Issue-Links setzen (Blocker, verknüpft mit, hängt ab von)

**YOUTRACK-Praktik:**
- Jede Aktivität = Issue (mit Komponente, Label, Priorität)
- Abhängigkeiten = Issue-Links (Beziehungen)
- Zeitschätzung = Estimate-Feld
- Kritischer Pfad = Issue-Filter nach Abhängigkeitstiefe

---

## 3. Netzplantechnik (Critical Path Method – CPM)

### 3.1 Grundkonzept

Die **Netzplantechnik** (auch **CPM – Critical Path Method**, deutsch: **Methode des kritischen Pfades**) ist eine Methode zur:

- **Visualisierung** aller Aktivitäten und ihrer Abhängigkeiten
- **Bestimmung der Projektdauer** (längster Pfad durch das Netzwerk)
- **Identifikation des kritischen Pfads** (Aktivitäten ohne Puffer)
- **Ressourcen- und Zeitoptimierung**

### 3.2 Netzplan-Darstellungsformen

#### Vorgangsknoten-Netzplan (Activity-on-Node, AoN)

```
       ┌─────────────────┐
       │    Design       │
       │   (5 Tage)      │
       │   FAZ=0  FEZ=5  │
       └────────┬────────┘
                │
       ┌────────▼────────┐
       │  Implementierung│
       │   (8 Tage)      │
       │   FAZ=5  FEZ=13 │
       └────────┬────────┘
                │
       ┌────────▼────────┐
       │     Testing     │
       │   (4 Tage)      │
       │   FAZ=13 FEZ=17 │
       └─────────────────┘
```

**Knoten-Attribute (deutsche Begriffe):**
- **FAZ (Frühester Anfangszeitpunkt)**: Frühestmöglicher Startzeitpunkt (Earliest Start)
- **FEZ (Frühester Endzeitpunkt)**: Frühestmöglicher Endzeitpunkt (Earliest End)
- **SAZ (Spätester Anfangszeitpunkt)**: Spätestmöglicher Startzeitpunkt (Latest Start)
- **SEZ (Spätester Endzeitpunkt)**: Spätestmöglicher Endzeitpunkt (Latest End)
- **Dauer**: FEZ = FAZ + Dauer

#### Vorgangspfeil-Netzplan (Activity-on-Arrow, AoA)

Seltener verwendet, Aktivität ist der Pfeil, Knoten sind Ereignisse.

### 3.3 Kritischer Pfad (Critical Path)

**Definition:**

Der **kritische Pfad** ist der längste Pfad durch das Netzwerk von Projektstart bis -end. Er bestimmt die **minimale Projektdauer**.

**Merkmale von Aktivitäten auf dem kritischen Pfad:**
- **Puffer = 0** (keine Zeitreserve)
- **Verzögerung** führt direkt zu Projektüberziehung
- Erfordern **besondere Überwachung** und Steuerung
- **Priorisierung** für Ressourcenzuteilung

**Berechnung (Beispiel: 3 serielle Aktivitäten):**

| Aktivität | Dauer | FAZ | FEZ | SAZ | SEZ | Puffer (Gesamtpuffer) |
|-----------|-------|-----|-----|-----|-----|------|
| A | 5 | 0 | 5 | 0 | 5 | 0 |
| B | 8 | 5 | 13 | 5 | 13 | 0 |
| C | 4 | 13 | 17 | 13 | 17 | 0 |

**Kritischer Pfad:** A → B → C (Dauer: 17 Tage)

### 3.4 Puffer und Reserven

**Gesamtpuffer (Total Slack/Float, GP)**
- Wie viel Verzögerung ist möglich, ohne das Projekt zu gefährden?
- Formel: **GP = SAZ – FAZ** (oder SEZ – FEZ)

**Freier Puffer (Free Slack/Float, FP)**
- Verzögerung ohne Einfluss auf Nachfolger
- Formel: **FP = FAZ_Nachfolger – FEZ_Vorgänger – Lag**

---

## 4. PERT-Methode (Program Evaluation and Review Technique)

### 4.1 Hintergrund

**PERT** wird verwendet, wenn **Unsicherheit bei Dauer-Schätzungen** besteht (z. B. Forschung, Innovation, wenig Erfahrung).

### 4.2 Drei-Punkt-Schätzung

Statt einer einzelnen Schätzung werden **drei Szenarien** bestimmt:

| Szenario | Notation | Bedeutung |
|----------|----------|-----------|
| **Optimistisch** | o | Beste Bedingungen, keine Probleme |
| **Wahrscheinlich** | m | Realistische Erwartung (Modus) |
| **Pessimistisch** | p | Ungünstige Bedingungen, Risiken treten auf |

**PERT-Formel (Gewichtung):**

$$\text{Erwartungswert} = \frac{o + 4m + p}{6}$$

**Standardabweichung (Varianz):**

$$\sigma = \frac{p - o}{6}$$

### 4.3 Beispiel

| Aktivität | o | m | p | PERT-Dauer | Unsicherheit |
|-----------|---|---|---|-----------|--------------|
| Design | 3 | 5 | 9 | (3+20+9)/6 = 5,3 | Hoch |
| Test | 2 | 4 | 6 | (2+16+6)/6 = 4 | Mittel |

---

## 5. Schätzverfahren für Aktivitätsdauern

### 5.1 Top-Down-Schätzung (Experten-Judgment)

- **Erfahrener Projektmanager** schätzt gesamte Phase
- Schnell, aber **anfällig für Bias**
- Einsatz: Frühe Projektphase, grobe Schätzung

### 5.2 Bottom-Up-Schätzung (Detailschätzung)

- **Ressourcen/Entwickler** schätzen einzelne Aktivitäten
- Akkurat, aber **zeitaufwendig**
- Einsatz: Detaillierte Planung, Verbindlichkeit

### 5.3 Analogieschätzung (Analogy Estimating)

- Vergleich mit **ähnlichen Projekten/Aktivitäten** der Vergangenheit
- Einsatz: Fehlende Daten, historische DB vorhanden
- Genauigkeit: Mittelmäßig (abhängig von Ähnlichkeit)

### 5.4 Parametrische Schätzung (Parametric Estimating)

- **Mathematische Modelle** (z. B. Lines of Code → Stunden)
- Beispiel: 100 Codezeilen = 5 Stunden Implementierung
- Einsatz: Wiederholbare Arbeitstypen (z. B. QA, Datenmigration)

---

## 6. Zeitplan-Darstellungen

### 6.1 Gantt-Diagramm (kurz eingeführt)

- **Horizontale Balkendiagramm** (Zeit auf x-Achse)
- Aktivitäten auf y-Achse mit zeitlicher Ausdehnung
- Zeigt Überlappungen, Meilensteine, Abhängigkeiten (mit Pfeilen)
- Vorteil: Intuitiv verständlich, populär in MS Project
- Detaillerte Behandlung in Modul 7

### 6.2 Netzdiagramm (CPM-Diagramm)

- Fokus auf **Abhängigkeitslogik**, nicht auf Kalender
- Vorgangsknoten oder Vorgangspfeile
- Zeigt kritischen Pfad deutlich
- Vorteil: Optimierungspotenziale sichtbar

---

## 7. Integration in YOUTRACK

### 7.1 Struktur in YOUTRACK

- **Projekt**: Übergeordnetes Projekt (z. B. „Website-Relaunch")
- **Issue**: Einzelne Aktivität oder Meilenstein
- **Komponente**: Entspricht WBS-Element (vgl. Modul 5)
- **Links**: Abhängigkeiten zwischen Issues
- **Milestone**: Meilenstein in YOUTRACK abbilden
- **Estimate**: Geschätzte Dauer (in Stunden/Tagen)

### 7.2 Best Practices

1. **Nomenklatur**: Eindeutige, aussagekräftige Namen für Issues
2. **Hierarchie**: Eltern-Child-Beziehung für WBS-Struktur
3. **Abhängigkeiten**: Systematisch als Issue-Links dokumentieren
4. **Aktualisierung**: Regelmäßiges Tracking (Actual Time)
5. **Zeitplan-Review**: Wöchentlich kritischen Pfad prüfen

---

## 8. Didaktische Hinweise zur Durchführung

### Zeitliche Aufteilung (4 UE à 45 min)

| UE | Inhalte | Dauer |
|----|---------|-------|
| 1 | Meilensteine, Aktivitäten, Abhängigkeiten (Grundlagen) | 45 min |
| 2 | Netzplantechnik, CPM, kritischer Pfad (Theorie + Beispiel) | 45 min |
| 3 | PERT, Schätzverfahren, Praktische Übungen | 45 min |
| 4 | YOUTRACK-Praxis, Zeitplan-Erstellung Fallprojekt | 45 min |

### Methodische Empfehlungen

1. **Interaktive Diskussion**: Teilnehmer bringen Projekterfahrungen ein
2. **Fallstudien**: Realistische Projektbeispiele (z. B. IT-Projekt, Bauprojekt)
3. **Hands-on-Übung**: Netzplan mit Stift und Papier zeichnen (Verständnis)
4. **Software-Einsatz**: Anschließend in YOUTRACK oder MS Project abbilden
5. **Fehleranalyse**: Häufige Fehler bei Sequenzierung durchgehen

---

## 9. Wichtige Begriffe und Definitionen

| Begriff | Definition |
|---------|-----------|
| **Aktivität (Task)** | Diskrete, ausführbare Arbeitseinheit mit Dauer, Ressourcen und Ergebnis |
| **Meilenstein** | Projektereignis ohne Dauer, markiert bedeutsame Momente |
| **Abhängigkeit** | Beziehung zwischen Aktivitäten, die deren Reihenfolge bestimmt |
| **Kritischer Pfad** | Längster Pfad im Netzwerk, bestimmt minimale Projektdauer |
| **Puffer / Slack** | Zeitliche Reserve einer nicht-kritischen Aktivität ohne Verzögerung des Projekts |
| **Gesamtpuffer (GP)** | Maximale Verzögerung ohne Gefährdung des Projektendtermins |
| **Freier Puffer (FP)** | Verzögerung ohne Einfluss auf nachfolgende Aktivitäten |
| **CPM (Critical Path Method)** | Netzplantechnik zur Bestimmung der Projektdauer und Optimierung |
| **PERT** | Methode mit Drei-Punkt-Schätzung für unsichere Dauer |
| **Netzplan** | Grafische Darstellung aller Aktivitäten und Abhängigkeiten |
| **Gantt-Diagramm** | Balkendiagramm zur Zeitplanvisualisierung (kalenderbasiert) |
| **FAZ** | Frühester Anfangszeitpunkt (Earliest Start) |
| **FEZ** | Frühester Endzeitpunkt (Earliest End) |
| **SAZ** | Spätester Anfangszeitpunkt (Latest Start) |
| **SEZ** | Spätester Endzeitpunkt (Latest End) |

---

## 10. Checkliste zur Vorbereitung von Zeitplänen

- [ ] WBS aus Modul 5 vorliegend und aktuell?
- [ ] Alle Aktivitäten mit Verantwortung hinterlegt?
- [ ] Abhängigkeiten mit Stakeholdern validiert?
- [ ] Schätzungen mit Ressourcen abgestimmt?
- [ ] Meilensteine mit Stakeholdern vereinbart?
- [ ] Kritischer Pfad identifiziert und dokumentiert?
- [ ] Risikozuschläge (Contingency) berücksichtigt?
- [ ] Zeitplan in YOUTRACK abgebildet und verlinkt?
- [ ] Ressourcenverfügbarkeit (Modul 8) vorgeprüft?

---

## Ausblick auf Modul 7

Modul 7 vertieft die Zeitmanagement-Inhalte um:
- **Gantt-Diagramme** im Detail (MS Project, alternative Tools)
- **Ressourcenabhängige Neuplanung** (Was wenn...)
- **Parallelisierung und Komprimierung** (Fast-Tracking, Crashing)
- **Puffer-Management** und Monte-Carlo-Simulation
- **Praktisches Erstellen** komplexer Zeitpläne