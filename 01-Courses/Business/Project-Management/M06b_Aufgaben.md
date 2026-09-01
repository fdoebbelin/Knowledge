# Modul 6b: Zeitmanagement I – Aufgaben und Übungen

## Aufgabe 1: Unterscheidung Meilensteine und Aktivitäten

### Aufgabenstellung

Klassifizieren Sie die folgenden Projektpunkte als **Meilenstein (M)** oder **Aktivität (A)**:

1. Datenbankschema entwerfen
2. Testphase abgeschlossen
3. Anforderungsspezifikation vom Kunden genehmigt
4. Benutzerhandbuch erstellen
5. Server in Produktivumgebung migrieren
6. Go-Live des Systems
7. Code-Review durchführen
8. Sicherheitszertifizierung erhalten
9. Wöchentliche Entwickler-Meetings abhalten
10. Projektabschlussbericht erstellen

### Lösungshinweise

> **Entscheidungshilfe:**
> 
> **Eine Aktivität erkennen Sie daran, dass:**
> - Sie eine **Tätigkeit beschreibt** (Verb wie „entwerfen", „erstellen", „durchführen")
> - Sie **Zeit und Aufwand** benötigt
> - Sie **Ressourcen** verbraucht (Personen, Material)
> - Sie ein **Arbeitsergebnis** produziert
> - Sie **messbar** ist (z. B. in Stunden/Tagen)
> 
> **Einen Meilenstein erkennen Sie daran, dass:**
> - Er einen **Zustand** oder **Zeitpunkt** markiert (kein Verb oder passiv formuliert)
> - Er **keine Dauer** hat (Momentaufnahme)
> - Er ein **Ereignis** darstellt („abgeschlossen", „genehmigt", „erhalten")
> - Er als **Entscheidungspunkt** oder **Kontrollpunkt** dient
> - Er für **Stakeholder** relevant ist

### Persönliche Notizen

```
Meine Klassifizierung:
1. ________  2. ________  3. ________  4. ________  5. ________
6. ________  7. ________  8. ________  9. ________  10. ________

Begründung für schwierige Fälle:



```

---

## Aufgabe 2: Abhängigkeitstypen erkennen und festlegen

### Aufgabenstellung

Für das Projekt **„Website-Relaunch"** wurden folgende Aktivitäten identifiziert:

- A: Anforderungsanalyse durchführen (4 Tage)
- B: Design-Konzept erstellen (5 Tage)
- C: Frontend-Entwicklung (8 Tage)
- D: Backend-Entwicklung (10 Tage)
- E: Integration durchführen (3 Tage)
- F: User Acceptance Testing (UAT) durchführen (5 Tage)
- G: Production-Deployment (1 Tag)

**Aufgaben:**

1. **Bestimmen Sie die logischen Abhängigkeiten** zwischen den Aktivitäten
2. **Geben Sie den Abhängigkeitstyp** an (EA = Ende-Anfang, AA = Anfang-Anfang, EE = Ende-Ende, AE = Anfang-Ende)
3. **Dokumentieren Sie Lags/Leads**, falls notwendig (z. B. 2 Tage Wartezeit für Genehmigung)

### Struktur für die Antwort

| Von | Nach | Abhängigkeitstyp | Lag/Lead | Begründung |
|-----|------|------------------|----------|------------|
| A | B | | | |
| A | D | | | |
| B | C | | | |
| B | D | | | |
| C | E | | | |
| D | E | | | |
| E | F | | | |
| F | G | | | |

### Lösungshinweise

> **Tipps zur Abhängigkeitsfestlegung:**
> - **Ende-Anfang (EA/FS)** ist der Standard – nutze diesen, wenn eine Aktivität vollständig abgeschlossen sein muss
> - **Anfang-Anfang (AA/SS)** nutzen, wenn Aktivitäten parallel laufen können, sobald die erste begonnen hat
> - **Ende-Ende (EE/FF)** nutzen, wenn beide Aktivitäten zeitgleich enden sollen
> - **Lags** dokumentieren, wenn zwischen Aktivitäten Wartezeit erforderlich ist (z. B. Genehmigung, Trocknungszeit)
> - Häufiger Fehler: Zu wenig Parallelisierung (alles EA) führt zu unnötiger Verlängerung

### Persönliche Notizen

```
Meine Überlegungen zur Sequenzierung:

Welche Aktivitäten können parallel laufen? 


Welche müssen streng hintereinander erfolgen?


Wo sehe ich Optimierungspotenziale?


```

---

## Aufgabe 3: Netzplan zeichnen und kritischen Pfad bestimmen

### Aufgabenstellung

Gegeben ist folgende Aktivitätsliste für Projekt **„CRM-System-Implementierung"**:

| Aktivität | Dauer (Tage) | Vorgänger |
|-----------|--------------|-----------|
| A: Anforderungs-Workshop | 3 | — |
| B: Systemkonfiguration | 5 | A |
| C: Datenbank-Design | 4 | A |
| D: Datenbank-Implementierung | 6 | C |
| E: Benutzerverwaltung konfigurieren | 2 | B |
| F: Integration mit Systemen | 8 | B, D |
| G: UAT-Planung und Durchführung | 5 | E, F |
| H: Deployment | 2 | G |

**Aufgaben:**

1. **Zeichnen Sie einen Vorgangsknoten-Netzplan** (AoN) mit Meilenstein „Go-Live" am Ende
2. **Berechnen Sie FAZ, FEZ, SAZ, SEZ** für jede Aktivität
3. **Bestimmen Sie den kritischen Pfad** und die Projektdauer
4. **Berechnen Sie den Gesamtpuffer (GP)** für jede Aktivität
5. **Identifizieren Sie kritische Aktivitäten** (GP = 0)

### Struktur für die Antwort

```
Netzplan-Skizze:

[A: 3]
   ↓
[B: 5]  ←→ [C: 4]
   ↓          ↓
[E: 2]    [D: 6]
   ↓          ↓
   └─→ [F: 8] ←
        ↓
      [G: 5]
        ↓
      [H: 2]
        ↓
    [Go-Live]
```

#### Detailberechnung

| Aktivität | Dauer | FAZ | FEZ | SAZ | SEZ | GP | Kritisch? |
|-----------|-------|-----|-----|-----|-----|----|-----------| 
| A | 3 | | | | | | |
| B | 5 | | | | | | |
| C | 4 | | | | | | |
| D | 6 | | | | | | |
| E | 2 | | | | | | |
| F | 8 | | | | | | |
| G | 5 | | | | | | |
| H | 2 | | | | | | |

### Lösungshinweise

> **Berechnungsschritte:**
> 
> **1. Vorwärtsrechnung (Forward Pass)** – FAZ und FEZ bestimmen
> - Beginnen Sie bei der ersten Aktivität mit FAZ = 0
> - FAZ einer Aktivität = max(FEZ aller Vorgänger)
> - FEZ einer Aktivität = FAZ + Dauer
> - Arbeiten Sie sich von links nach rechts durch den Netzplan
> 
> **2. Rückwärtsrechnung (Backward Pass)** – SAZ und SEZ bestimmen
> - Beginnen Sie bei der letzten Aktivität: SEZ = FEZ (Projektende)
> - SEZ einer Aktivität = min(SAZ aller Nachfolger)
> - SAZ einer Aktivität = SEZ − Dauer
> - Arbeiten Sie sich von rechts nach links durch den Netzplan
> 
> **3. Gesamtpuffer berechnen**
> - GP = SAZ − FAZ (oder SEZ − FEZ)
> - GP = 0 bedeutet: Aktivität ist kritisch
> 
> **4. Kritischer Pfad identifizieren**
> - Alle Aktivitäten mit GP = 0 bilden den kritischen Pfad
> - Der kritische Pfad ist der längste Weg durch das Netzwerk

### Persönliche Notizen

```
Meine Erkenntnisse:

Projektdauer (kritischer Pfad):


Kritische Aktivitäten:


Nicht-kritische Aktivitäten (mit Puffer):


Wo könnte ich Parallelisierung optimieren?


```

---

## Aufgabe 4: PERT-Schätzung durchführen

### Aufgabenstellung

Sie planen eine **Cloud-Migration** mit unsicheren Dauer-Schätzungen. Ihr Team hat folgende Drei-Punkt-Schätzungen gegeben:

| Aktivität | Optimistisch (o) | Wahrscheinlich (m) | Pessimistisch (p) |
|-----------|------------------|--------------------|--------------------|
| Infrastruktur-Design | 2 Tage | 4 Tage | 10 Tage |
| Virtualisierung Setup | 3 Tage | 5 Tage | 8 Tage |
| Datenmigration | 5 Tage | 8 Tage | 15 Tage |
| Testing & Validierung | 4 Tage | 6 Tage | 12 Tage |

**Aufgaben:**

1. **Berechnen Sie die PERT-Erwartungswerte** (gewichtete Durchschnitte) für jede Aktivität
2. **Berechnen Sie die Standardabweichung (σ)** für jede Aktivität
3. **Bestimmen Sie die Gesamtprojektdauer** (Summe PERT-Werte)
4. **Interpretieren Sie die Ergebnisse** (Wo ist die höchste Unsicherheit?)

### Formeln

$$\text{PERT-Dauer} = \frac{o + 4m + p}{6}$$

$$\sigma = \frac{p - o}{6}$$

**Varianz der Gesamtdauer:**
$$\sigma_{\text{Projekt}}^2 = \sum \sigma_i^2$$

### Struktur für die Antwort

| Aktivität | o | m | p | PERT-Dauer | σ | σ² |
|-----------|---|---|---|------------|---|-----|
| Infrastruktur-Design | 2 | 4 | 10 | | | |
| Virtualisierung | 3 | 5 | 8 | | | |
| Datenmigration | 5 | 8 | 15 | | | |
| Testing | 4 | 6 | 12 | | | |
| **Summe** | | | | | | |

**Gesamtstandardabweichung:** σ_Projekt = √(Summe σ²) = ________

### Wahrscheinlichkeitsverteilung

| Bereich | Formel | Intervall (Tage) | Wahrscheinlichkeit |
|---------|--------|------------------|---------------------|
| Wahrscheinlich | PERT-Dauer ± 1σ | | ca. 68 % |
| Sehr wahrscheinlich | PERT-Dauer ± 2σ | | ca. 95 % |
| Extrem unwahrscheinlich | PERT-Dauer ± 3σ | | ca. 99,7 % |

### Lösungshinweise

> **Verständnis der Gewichtung:**
> - Der **wahrscheinlichste Wert (m)** wird mit 4 multipliziert (höchste Gewichtung)
> - **Optimistisch** und **pessimistisch** erhalten je Faktor 1
> - Dies repräsentiert eine Beta-Verteilung
>
> **Unsicherheit interpretieren:**
> - Höheres σ = Höhere Unsicherheit = Höheres Risiko
> - **Kontingenzreserve**: Oft 5–10% der PERT-Gesamtdauer zur Pufferung
> - Aktivitäten mit hohem σ benötigen besondere Aufmerksamkeit und Risikomaßnahmen

### Persönliche Notizen

```
Beobachtungen zur Unsicherheit:

Welche Aktivität ist am unsichersten?


Sollte ich für diese Aktivität ein Risk-Mitigation planen?


Kontingenzreserve (5% der Gesamtdauer):


Empfohlene Projektdauer für 95% Sicherheit:


```

---

## Aufgabe 5: Zeitplan in YOUTRACK abbilden

### Aufgabenstellung

Sie haben den Netzplan aus Aufgabe 3 erstellt. Nun sollen Sie die **CRM-System-Implementierung** in YOUTRACK strukturieren:

**Aufgaben:**

1. **Erstellen Sie eine Hierarchie** (Parent-Child-Issues):
   - Übergeordnetes Epic oder Task
   - Subtasks für jede Aktivität (A, B, C, D, E, F, G, H)

2. **Hinterlegen Sie Eigenschaften**:
   - Estimate (geschätzte Dauer in Tagen oder Stunden)
   - Labels oder Tags (z. B. „kritischer-pfad", „testing", „deployment")
   - Priorität (höher für kritische Aktivitäten)

3. **Definieren Sie Abhängigkeiten** als Issue-Links:
   - Link-Typ: z. B. „Blocker", „Related to", „Depends on"
   - Beispiel: C (Datenbank-Design) ist Blocker für D (Datenbank-Implementierung)

4. **Dokumentieren Sie einen Meilenstein**:
   - Milestone: „Go-Live"
   - Zuordnung der relevanten Issues

### Struktur für die Antwort

**Hierarchie:**

```
[Epic] CRM-System-Implementierung
  ├─ [Task] A: Anforderungs-Workshop (3d, Normal)
  ├─ [Task] B: Systemkonfiguration (5d, Normal)
  ├─ [Task] C: Datenbank-Design (4d, High)
  │   └─ Blocker für: D
  ├─ [Task] D: Datenbank-Impl. (6d, High)
  │   └─ Blocker für: F
  ├─ [Task] E: Benutzerverwaltung (2d, Normal)
  │   └─ Blocker für: G
  ├─ [Task] F: Integration (8d, High)
  │   └─ Blocker für: G
  ├─ [Task] G: UAT (5d, High)
  │   └─ Blocker für: H
  ├─ [Task] H: Deployment (2d, Critical)
  └─ [Milestone] Go-Live (H abgeschlossen)
```

**Issue-Link-Struktur:**

| Von | Zu | Link-Typ | Begründung |
|-----|-----|----------|-----------|
| C | D | Blocker | D kann erst starten, wenn C fertig |
| A | B | Blocker | B braucht Ergebnisse von A |
| B | E | Blocker | E braucht Systemkonfiguration |
| D | F | Blocker | Integration braucht DB |
| B | F | Blocker | Integration braucht Systemkonfiguration |
| E | G | Blocker | UAT braucht Benutzerverwaltung |
| F | G | Blocker | UAT braucht Integration |
| G | H | Blocker | Deployment nach UAT |

### Lösungshinweise

> **YOUTRACK Best Practices:**
> - **Estimate korrekt** in Tagen/Stunden eingeben (konsistent mit Team-Standards)
> - **Blocker-Relationship** für echte Ende-Anfang-Abhängigkeiten nutzen
> - **Labels/Tags** verwenden für bessere Filterung (z. B. alle Aufgaben des kritischen Pfads)
> - **Milestone-Feature**: Nutzen für große Kontrollpunkte (nicht für jede Aktivität)
> - **Timeline-View**: Nach Erstellung alle Issues überprüfen (visuell validieren)
> - **Priorität**: Kritische Pfad-Aktivitäten erhalten höhere Priorität (High oder Critical)

### Persönliche Notizen

```
Meine Struktur in YOUTRACK:

Hauptkomponenten (Komponente-Struktur):


Critical-Path-Issues (Blocker-Kette):


Labels/Tags die ich verwenden werde:


Fragen/Unsicherheiten:


```

---

## Aufgabe 6: Häufige Fehler erkennen und korrigieren

### Aufgabenstellung

Analysieren Sie die folgenden **Sequenzierungsszenarien** und identifizieren Sie Fehler:

#### Szenario A: Online-Shop-Redesign

```
Aktivitäten:
- A: Homepage-Design (3d)
- B: Checkout-Design (2d)
- C: Homepage-Entwicklung (5d)
- D: Checkout-Entwicklung (4d)
- E: Integrationstest (3d)
- F: Go-Live (1d Meilenstein)

Sequenzierung:
A → B → C → D → E → F

Kritischer Pfad: A → B → C → D → E → F = 18 Tage
```

**Fragen:**
- Ist diese Sequenzierung optimal?
- Welche Aktivitäten könnten parallel laufen?
- Welcher verbesserte Pfad würde entstehen?
- Welche Projektdauer ist realistisch möglich?

#### Szenario B: Datenmigration

```
Aktivitäten:
- A: Datenanalyse (4d)
- B: Quellsystem-Export (2d)
- C: Datentransformation (5d)
- D: Zielsystem-Vorbereitung (3d)
- E: Datenladen (1d)
- F: Validierung (2d)

Sequenzierung (aktuell):
A → B → C → D → E → F (alle hintereinander)

Projektdauer: 17 Tage
```

**Fragen:**
- Welche Aktivitäten sind wirklich voneinander abhängig?
- Wo kann parallelisiert werden?
- Was ist der neue kritische Pfad?
- Wie ändert sich die Projektdauer?

### Lösungshinweise

> **Typische Fehler bei Sequenzierung:**
> 1. **Übermäßige Serialisierung**: Alles wird hintereinander geplant, obwohl Parallelisierung möglich ist
> 2. **Zu enge Abhängigkeiten**: Falsche Annahmen zu Blockaden (nicht validiert mit Ressourcen)
> 3. **Fehlende Anfang-Anfang-Abhängigkeiten**: Oft können Aktivitäten schon während Vorgänger-Durchführung starten
> 4. **Keine Lags**: Vergessene Wartezeiten für Genehmigungen, Lieferungen etc.
> 5. **Falsche Reihenfolge**: Anforderungsanalyse nicht vor Design/Entwicklung
> 6. **Ressourcen nicht berücksichtigt**: Parallelisierung nur möglich, wenn verschiedene Personen/Teams verfügbar

### Persönliche Notizen

```
Szenario A – Meine Optimierungen:

Parallele Aktivitäten:


Neue Sequenzierung:


Neue Projektdauer:


Szenario B – Meine Analyse:

Unabhängige Aktivitäten:


Parallele Aktivitäten:


Kritischer Pfad:


Einsparung gegenüber Serialisierung:


```

---

## Zusammenfassung und Selbstevaluierung

### Checkliste: Habe ich verstanden?

- [ ] Ich kann **Meilensteine von Aktivitäten unterscheiden** (Zustand vs. Tätigkeit)
- [ ] Ich erkenne **Abhängigkeitstypen** (EA, AA, EE, AE)
- [ ] Ich kann einen **Netzplan zeichnen** und Vorwärts-/Rückwärtsrechnung durchführen
- [ ] Ich bestimme **kritischen Pfad und Gesamtpuffer** korrekt
- [ ] Ich wende **PERT-Schätzungen** mit Drei-Punkt-Schätzung an
- [ ] Ich **strukturiere Zeitpläne in YOUTRACK** mit Links und Milestones
- [ ] Ich erkenne **Optimierungspotenziale** in Sequenzierungen
- [ ] Ich verstehe die **deutschen Begriffe** (FAZ, FEZ, SAZ, SEZ, GP, FP)

### Offene Fragen an den Trainer

```
Fragen, die ich noch klären möchte:

1.


2.


3.


```

### Zusätzliche Lernressourcen

- **Video-Links**: CPM-Netzplan-Erklärvideos (z. B. Project Management Institute)
- **Fallstudien**: Reale Projektbeispiele aus verschiedenen Branchen
- **Tools-Tutorials**: YOUTRACK Issue-Linking, MS Project Netzplan
- **Austausch**: Projektbeispiele aus Teilnehmer-Praxis diskutieren

---

## Platz für Notizen und Vertiefung

```
Themen, die ich vertiefen möchte:



Verbindung zu anderen Modulen (z. B. Ressourcenplanung Modul 8):



Meine wichtigsten Erkenntnisse heute:



```