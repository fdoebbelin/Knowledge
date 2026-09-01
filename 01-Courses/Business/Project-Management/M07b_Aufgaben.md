## Lernzielkontrolle – Verständnisfragen

### Aufgabe 1: Gantt-Diagramme – Theorie und Praxis

**Aufgabenteil A: Grundlagen**

Beantworten Sie folgende Fragen zum Gantt-Diagramm:

1. Nennen Sie mindestens drei Gründe, warum Gantt-Diagramme im Projektmanagement verwendet werden.
2. Welche fünf Hauptelemente gehören zu einem professionellen Gantt-Diagramm?
3. Erklären Sie den Unterschied zwischen einer Ende-Anfang-Abhängigkeit (EA) und einer Anfang-Anfang-Abhängigkeit (AA).

**Aufgabenteil B: Praktische Anwendung**

Erstellen Sie ein einfaches Gantt-Diagramm für ein **IT-Projekt: Website-Redesign** mit folgenden Aktivitäten:

| Aktivität               | Dauer (Tage) | Abhängigkeit |     |
| ----------------------- | ------------ | ------------ | --- |
| A: Anforderungsanalyse  | 5            | —            |     |
| B: Design-Konzept       | 7            | Nach A       |     |
| C: Technisches Setup    | 4            | Nach A       |     |
| D: Frontend-Entwicklung | 10           | Nach B, C    |     |
| E: Backend-Entwicklung  | 12           | Nach C       |     |
| F: Integration          | 5            | Nach D, E    |     |
| G: Testing              | 8            | Nach F       |     |
| H: Deployment           | 2            | Nach G       |     |

**Aufgabe:**
- Zeichnen Sie die Aktivitäten als horizontale Balken auf eine Zeitachse (Sie können Millimeterpapier, Excel oder ein Online-Tool verwenden)
- Tragen Sie die Abhängigkeitslinien ein
- Markieren Sie Meilensteine (z.B. Projektstart, Design fertig, Testing beendet, Go-Live)
- Tragen Sie eine „Heute"-Linie ein (angenommen: Tag 15 des Projekts)

**Lösungsraum:**
```
[Ihre Zeichnung hier]


Meilensteine:
- Start: Tag 0
- Design-Phase abgeschlossen: Tag ___
- Testing beendet: Tag ___
- Projektende: Tag ___
```

---

### Aufgabe 2: Kritischer Pfad (CPM) berechnen

**Aufgabenteil A: CPM-Berechnung mit Zahlen**

Berechnen Sie für das folgende Projekt den kritischen Pfad:

**Projekttabelle:**

| Aktivität | Dauer | Abhängigkeit |
|-----------|---|---|
| A | 3 Tage | — |
| B | 5 Tage | Nach A |
| C | 2 Tage | Nach A |
| D | 4 Tage | Nach B |
| E | 6 Tage | Nach C |
| F | 3 Tage | Nach D, E |

**Aufgabe:**

Füllen Sie folgende Tabelle aus:

| Aktivität | Dauer | FAS | FES | SAS | SES | Puffer | Kritisch? |
|-----------|---|---|---|---|---|---|---|
| A | 3 | ___ | ___ | ___ | ___ | ___ | JA/NEIN |
| B | 5 | ___ | ___ | ___ | ___ | ___ | JA/NEIN |
| C | 2 | ___ | ___ | ___ | ___ | ___ | JA/NEIN |
| D | 4 | ___ | ___ | ___ | ___ | ___ | JA/NEIN |
| E | 6 | ___ | ___ | ___ | ___ | ___ | JA/NEIN |
| F | 3 | ___ | ___ | ___ | ___ | ___ | JA/NEIN |

**Fragen:**

1. Wie lange dauert das Projekt insgesamt?
2. Welche Aktivitäten liegen auf dem kritischen Pfad?
3. Welche Aktivität hat den größten Zeitpuffer und um wie viele Tage könnte sie verzögert werden?
4. Was passiert, wenn Aktivität B um 2 Tage verzögert wird?

**Lösungsraum:**

Gesamtprojektdauer: _____ Tage

Kritischer Pfad: A → ____ → ____ (oder andere Sequenz)

Aktivität mit größtem Puffer: _____, Puffer: _____ Tage

Auswirkung einer 2-Tage-Verzögerung von B:
_________________________________________________________________________

**Aufgabenteil B: Netzplan-Netzwerk zeichnen**

Zeichnen Sie das Projekt-Netzwerk (PDM – Precedence Diagramming Method) als Kästen mit Pfeilen:

```
Vorlage:

┌─────────────┐
│  Aktivität  │
│  Dauer      │
└─────────────┘
      │
      ↓
    [Abhängigkeit]
```

**Ihr Netzwerk:**

[Hier Ihr Netzwerk zeichnen]

---

### Aufgabe 3: Zeitpuffer verstehen und anwenden

**Aufgabenteil A: Puffer-Konzepte**

1. Definieren Sie mit eigenen Worten:
   - **Freier Puffer (Free Float)**:
   
   _________________________________________________________________________
   
   - **Gesamtzeitpuffer (Total Float)**:
   
   _________________________________________________________________________

2. Warum ist der Unterschied zwischen freiem und Gesamtzeitpuffer praktisch wichtig?

_________________________________________________________________________

**Aufgabenteil B: Szenario-Analyse**

Nehmen Sie Ihr Projekt aus Aufgabe 2. Angenommen, Aktivität C (Dauer 2 Tage, Puffer 4 Tage) wird tatsächlich 3 Tage dauern (1 Tag Überschuss).

**Frage:** Muss der Projektendtermin verschoben werden? Begründen Sie!

_________________________________________________________________________

_________________________________________________________________________

---

### Aufgabe 4: Ressourcen-Leveling

**Aufgabenteil A: Ressourcenkonflikt-Identifikation**

Folgende Ressourcentabelle zeigt die Kapazitätsauslastung eines Entwicklers (Max. 100% = 40 Stunden/Woche):

| Woche | Aktivität | Aufwand | Aktivität 2 | Aufwand 2 | GESAMT |
|---|---|---|---|---|---|
| 1 | Backend (B) | 35h | — | — | 35h (87%) |
| 2 | Backend (B) | 35h | Frontend (D) | 15h | 50h (**ÜBERAUSLASTUNG!**) |
| 3 | Frontend (D) | 20h | Testing (G) | 20h | 40h (100%) |
| 4 | Testing (G) | 25h | — | — | 25h (62%) |

**Aufgabe:**

1. In welcher Woche liegt ein Ressourcenkonflikt vor?
2. Wie hoch ist die Überauslastung in Prozent?
3. Welche Strategien würden Sie zur Konfliktlösung vorschlagen?

**Lösungsraum:**

Konflikt-Woche: Woche ____

Überauslastung: ______ %

Lösungsstrategien:
- Strategy 1: _________________________________________________________________
- Strategy 2: _________________________________________________________________
- Strategy 3: _________________________________________________________________

**Aufgabenteil B: Ressourcen-Leveling durchführen**

Planen Sie die Aktivitäten so um, dass keine Woche über 100% Auslastung geht:

| Woche | Aktivität 1 | Aufwand 1 | Aktivität 2 | Aufwand 2 | GESAMT |
|---|---|---|---|---|---|
| 1 | | | | | __ % |
| 2 | | | | | __ % |
| 3 | | | | | __ % |
| 4 | | | | | __ % |
| 5 | | | | | __ % |

**Anmerkung:** Die Gesamtaufwände bleiben gleich, nur die Reihenfolge ändert sich!

---

### Aufgabe 5: Terminverzögerungen managen

**Szenario:** Ein Projekt ist in der Durchführung. Der ursprüngliche Endtermin ist Tag 45.

**Status Tag 30:**

| Aktivität | Plan-Dauer | Tatsächliche Dauer bis Tag 30 | Status |
|---|---|---|---|
| A (kritisch) | 3 Tage | 3 Tage ✓ | Fertig |
| B (kritisch) | 5 Tage | 4 Tage | Läuft noch |
| C (Puffer: 4 Tage) | 2 Tage | 3 Tage | Läuft noch |
| D (kritisch) | 4 Tage | — | Nicht gestartet |
| E (Puffer: 6 Tage) | 6 Tage | — | Nicht gestartet |

**Aufgabe 1: Verzögerungserkennung**

Welche Aktivitäten bereiten Probleme? Begründen Sie!

_________________________________________________________________________

_________________________________________________________________________

**Aufgabe 2: Risikoanalyse**

1. Wie wirkt sich die Verzögerung in Aktivität C auf den Gesamtprojekttermin aus?

_________________________________________________________________________

2. Welche Aktivität ist am kritischsten in der aktuellen Situation?

_________________________________________________________________________

**Aufgabe 3: Beschleunigungsmaßnahmen**

Angenommen, Sie müssen das Projekt noch um 10 Tage beschleunigen. Skizzieren Sie:

- **Crashing-Ansatz** (Ressourcen + Kosten erhöhen):

_________________________________________________________________________

- **Fast-Tracking-Ansatz** (Parallelisierung):

_________________________________________________________________________

---

### Aufgabe 6: YouTrack-Praktikum

**Szenario:** Sie verwalten ein Softwareprojekt in YouTrack und müssen einen Zeitplan erstellen.

**Aufgabe (Optional – nur mit Zugang zu YouTrack):**

1. Erstellen Sie folgende Issues mit Abhängigkeiten:
   - **Issue 1:** Anforderungsanalyse (5 Tage, Fälligkeitsdatum: +5 Tage)
   - **Issue 2:** Design (7 Tage, Abhängigkeit: blockiert von Issue 1)
   - **Issue 3:** Entwicklung (10 Tage, Abhängigkeit: blockiert von Issue 2)
   - **Issue 4:** Testing (5 Tage, Abhängigkeit: blockiert von Issue 3)

2. Rufen Sie die **Gantt-View** auf und überprüfen Sie die automatische Planung

3. Fügen Sie einen **Meilenstein** hinzu: "Launch" zum Ende der Issue 4

4. Ordnen Sie Issues verschiedenen Teamangehörigen zu und überprüfen Sie die **Ressourcenauslastung**

5. Ändern Sie die Dauer von Issue 1 auf 7 Tage und beobachten Sie, wie sich die nachfolgenden Issues automatisch verschieben

**Dokumentation:**

Screenshots oder Notizen:
```
[Hier notieren, was Sie beobachtet haben]


Besonderheiten von YouTrack-Gantt im Vergleich zu klassischen Tools:
_________________________________________________________________
```

---

## Checklisten und Zusammenfassungen

### Checkliste: Gantt-Diagramm erstellen

- [ ] Alle Aktivitäten aus der WBS identifiziert
- [ ] Dauer für jede Aktivität geschätzt
- [ ] Abhängigkeiten zwischen Aktivitäten geklärt
- [ ] Abhängigkeitstypen korrekt definiert (EA, AA, EE, AE)
- [ ] Start- und Enddaten berechnet
- [ ] Meilensteine eingetragen
- [ ] Zeitpuffer visualisiert (z.B. durch gestrichelte Linien)
- [ ] Balkendiagramm auf Zeitskala gezeichnet
- [ ] Gantt-Diagramm mit dem Team validiert
- [ ] Diagramm regelmäßig aktualisiert

### Checkliste: CPM-Berechnung durchführen

- [ ] Alle Aktivitäten und ihre Abhängigkeiten dokumentiert
- [ ] Dauer jeder Aktivität realistisch geschätzt
- [ ] Vorwärtsrechnung durchgeführt (FAS, FES berechnet)
- [ ] Rückwärtsrechnung durchgeführt (SAS, SES berechnet)
- [ ] Gesamtzeitpuffer für jede Aktivität berechnet
- [ ] Aktivitäten mit Puffer = 0 identifiziert
- [ ] Kritischer Pfad markiert
- [ ] Ergebnis dokumentiert und kommuniziert
- [ ] Sensitivitätsanalyse für kritische Aktivitäten durchgeführt

### Checkliste: Ressourcen-Leveling

- [ ] Ressourcentabelle mit verfügbaren Kapazitäten erstellt
- [ ] Ressourcenauslastung für jeden Zeitraum berechnet
- [ ] Überauslastung-Perioden identifiziert
- [ ] Aktivitäten mit Zeitpuffer gekennzeichnet
- [ ] Verschiebungsoptionen geprüft (ohne kritischen Pfad zu gefährden)
- [ ] Leveling-Plan erstellt
- [ ] Auswirkungen auf den kritischen Pfad überprüft
- [ ] Team über Ressourcen-Umdisposition informiert
- [ ] Plan mit Ressourcenhistogramm visualisiert
- [ ] Überwachung etabliert (regelmäßige Kapazitätsprüfung)

---

## Persönliche Notizen und Reflexion

### Notizen zum kritischen Pfad verstehen:

Häufige Fragen und meine Antworten:

1. _________________________________________________________________

2. _________________________________________________________________

3. _________________________________________________________________

### Meine größten Herausforderungen in diesem Modul:

_________________________________________________________________________

_________________________________________________________________________

### Praktische Tipps, die ich für mein Projekt mitnehme:

_________________________________________________________________________

_________________________________________________________________________

### Fragen für den nächsten Kurs/Trainer:

1. _________________________________________________________________

2. _________________________________________________________________

3. _________________________________________________________________

---

## Anwendungsszenarien aus der Praxis

### Szenario A: Bauprojekt (Einfamilienhaus)

Ein Bauunternehmen muss ein Einfamilienhaus innerhalb von 6 Monaten fertigstellen.

**Aktivitäten (vereinfacht):**
- Fundamentarbeiten: 3 Wochen
- Mauerwerk: 4 Wochen (nach Fundament)
- Dachstuhl: 2 Wochen (nach Mauerwerk)
- Installation (Wasser, Strom): 2 Wochen (parallel zu Dachstuhl)
- Verputz & Farbe: 3 Wochen (nach Dachstuhl & Installation)
- Bodenbelag & Türen: 2 Wochen (nach Verputz)
- Endkontrolle: 1 Woche (nach Bodenbelag)

**Aufgabe:** Berechnen Sie den kritischen Pfad und die Gesamtdauer!

**Lösung (Stichwort):**

_________________________________________________________________________

### Szenario B: Marketingkampagne

Eine Werbeagentur plant eine Produktlaunch-Kampagne.

**Ressourcen:**
- Art Director: maximal 30h/Woche
- Texter: maximal 25h/Woche
- Media-Planer: maximal 20h/Woche

**Geplante Aktivitäten:**
- Brief & Ideenfindung: 3 Tage (Art Director 15h, Texter 10h)
- Konzept & Design: 5 Tage (Art Director 25h)
- Copy & Werbetexte: 4 Tage (Texter 20h)
- Media-Planung: 3 Tage (Media-Planer 15h)
- Produktion (Druck/Digital): 5 Tage (Art Director 10h)
- Finalisierung & Go-Live: 2 Tage (alle 5h)

**Aufgabe:** Erstellen Sie einen Ressourcenplan und ein Gantt-Diagramm!

---

## Weiterführende Fragen

1. Wie würde sich das Projekt ändern, wenn eine Aktivität nach dem Start neu entdeckt wird?

_________________________________________________________________________

2. Welche Alternativen gibt es zur CPM bei agilen Projekten?

_________________________________________________________________________

3. Wie messe ich während der Projektausführung, ob der Zeitplan noch realistisch ist?

_________________________________________________________________________

---

**Bearbeitungszeit für alle Aufgaben:** ca. 3–4 Unterrichtseinheiten (120–180 Minuten)

**Empfohlene Reihenfolge:** Aufgaben 1 → 2 → 3 → 4 → 5 → (6 optional)