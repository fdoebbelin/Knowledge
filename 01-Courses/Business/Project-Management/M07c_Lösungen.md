## Aufgabe 1: Gantt-Diagramme – Theorie und Praxis

### Aufgabenteil A: Grundlagen – Lösungen

**Frage 1: Nennen Sie mindestens drei Gründe, warum Gantt-Diagramme im Projektmanagement verwendet werden.**

**Lösung:**
1. **Visualisierung der Zeitabläufe**: Gantt-Diagramme machen zeitliche Abläufe auf einen Blick verständlich
2. **Abhängigkeitserkennung**: Logische Abhängigkeiten zwischen Aktivitäten werden deutlich
3. **Fortschrittskontrolle**: Durch die "Heute-Linie" ist der aktuellen Status erkennbar
4. **Ressourcenplanung**: Parallele Aktivitäten zeigen Ressourcenbelastung
5. **Stakeholder-Kommunikation**: Einfache, verständliche Darstellung für Laien
6. **Terminkontrolle**: Meilensteine und Endtermine sind sofort erkennbar

> **Kommentar:** Teilnehmer sollten mindestens drei nennen. Die Antwort zeigt Verständnis für den praktischen Nutzen von Gantt-Diagrammen jenseits der reinen Darstellung. Häufiger Fehler: Verwirrung mit Netzplänen (zu technisch, weniger visuelle Klarheit).

---

**Frage 2: Welche fünf Hauptelemente gehören zu einem professionellen Gantt-Diagramm?**

**Lösung:**
1. **Aktivitätenliste** (linke Spalte): Namen und Nummern der Aufgaben
2. **Zeitachse** (oben): Zeitintervalle (Tage, Wochen, Monate)
3. **Balken/Balkenelemente**: Länge = Dauer, Position = zeitliche Lage
4. **Abhängigkeitslinien**: Pfeile/Linien zwischen Balken zur Kennzeichnung von Abhängigkeiten
5. **Meilensteine**: Symbole (Rauten, Diamanten) für wichtige Ereignisse
6. **Heute-Linie** (optional, aber wichtig): Vertikale Markierung des aktuellen Datums
7. **Legende**: Erklärung von Symbolen und Farben

> **Kommentar:** Einige dieser Elemente sind essenziell, andere optional. Die Kern-Elemente (1–4) müssen genannt werden. Professionelle Diagramme enthalten auch Legende und Datum. Typischer Fehler: Verwechslung mit Netzplan-Symbolen (Knoten, Kanten statt Balken).

---

**Frage 3: Erklären Sie den Unterschied zwischen einer Ende-Anfang-Abhängigkeit (EA) und einer Anfang-Anfang-Abhängigkeit (AA).**

**Lösung:**

| Aspekt | Ende-Anfang (EA) | Anfang-Anfang (AA) |
|--------|---|---|
| **Definition** | Aktivität B startet frühestens nach Beendigung von A | Aktivität B startet zeitgleich mit A (oder mit Verzögerung) |
| **Zeitliche Abfolge** | Sequenziell (nacheinander) | Parallel (überlappend) |
| **Grafik** | Pfeil von Ende von A zum Anfang von B | Pfeil von Anfang von A zum Anfang von B |
| **Beispiel** | Fundament fertig → Mauern beginnen | Design beginnt → Prototypentwicklung beginnt (mit 2-Tage-Versatz) |
| **Häufigkeit** | Sehr häufig (~80% aller Abhängigkeiten) | Häufig bei parallelen Prozessen (~15%) |
| **Risiko** | Gering (klare Abhängigkeit) | Höher (mangelnde Information kann zu Rework führen) |

> **Kommentar:** Dies ist ein konzeptuelles Verständnis. Schwache Antworten unterscheiden nur oberflächlich (z.B. „nacheinander" vs. „gleichzeitig"). Starke Antworten erklären auch die praktischen Implikationen und Risiken. Häufiger Fehler: Verwechslung mit EE oder AE Abhängigkeiten, die in der Praxis selten vorkommen.

---

### Aufgabenteil B: Praktische Anwendung – Gantt-Diagramm erstellen

**Szenario: IT-Projekt Website-Redesign**

**Schritt 1: Zeitleisten berechnen (Vorwärtsrechnung)**

| Aktivität | Dauer | Abhängigkeit | Früher Start (FAS) | Früher Ende (FES) |
|-----------|---|---|---|---|
| A: Anforderungsanalyse | 5 | — | 0 | 5 |
| B: Design-Konzept | 7 | Nach A | 5 | 12 |
| C: Technisches Setup | 4 | Nach A | 5 | 9 |
| D: Frontend-Entwicklung | 10 | Nach B, C | 12 | 22 |
| E: Backend-Entwicklung | 12 | Nach C | 9 | 21 |
| F: Integration | 5 | Nach D, E | 22 | 27 |
| G: Testing | 8 | Nach F | 27 | 35 |
| H: Deployment | 2 | Nach G | 35 | 37 |

**Schritt 2: Zeitpuffer berechnen (Rückwärtsrechnung)**

| Aktivität | Dauer | Später Ende (SES) | Später Start (SAS) | Puffer |
|-----------|---|---|---|---|
| A | 5 | 5 | 0 | 0 (kritisch) |
| B | 7 | 12 | 5 | 0 (kritisch) |
| C | 4 | 9 | 5 | 0 (kritisch) |
| D | 10 | 22 | 12 | 0 (kritisch) |
| E | 12 | 21 | 9 | 0 (kritisch) |
| F | 5 | 27 | 22 | 0 (kritisch) |
| G | 8 | 35 | 27 | 0 (kritisch) |
| H | 2 | 37 | 35 | 0 (kritisch) |

**Schritt 3: Grafische Darstellung (Gantt-Diagramm)**

```
Website-Redesign Projekt – Gantt-Diagramm

Aktivität          |  0  | 5  | 10 | 15 | 20 | 25 | 30 | 35 | 37
                   |_____|____|____|____|____|____|____|____|___
A: Anforderungen   |█████|    |    |    |    |    |    |    |   
B: Design          |     |███████|    |    |    |    |    |    |   
C: Techn. Setup    |     |████|    |    |    |    |    |    |   
D: Frontend        |     |    |          ██████████|    |    |   
E: Backend         |     |    |     ████████████|    |    |   
F: Integration     |     |    |    |    |    |█████|    |    |   
G: Testing         |     |    |    |    |    |    |████████|   
H: Deployment      |     |    |    |    |    |    |    |  ██|   
                   |_____|____|____|____|____|____|____|____|___
"Heute" (Tag 15):                            ↓

Legende:
█ = Aktivität | → = Abhängigkeit | ◆ = Meilenstein
```

**Schritt 4: Meilensteine**

| Meilenstein | Datum | Status |
|---|---|---|
| Projekt-Start | Tag 0 | Grün ✓ |
| Anforderungen & Setup fertig | Tag 9 | Grün ✓ |
| Design-Phase abgeschlossen | Tag 12 | Grün ✓ |
| Entwicklung abgeschlossen | Tag 22 | Grün ✓ (bei Tag 15 noch laufend) |
| Testing beendet | Tag 35 | Gelb (noch 20 Tage bis dahin) |
| Go-Live / Deployment | Tag 37 | Gelb (noch 22 Tage bis dahin) |

**Status bei Tag 15 (Heute-Linie):**
- ✓ A, B, C sind fertig
- → D und E laufen parallel
- → Projekt läuft **im Plan**
- → Kritischer Pfad ist A → B → D → F → G → H (37 Tage insgesamt)

> **Kommentar:** Dies ist ein sehr realistisches Projekt. Die Besonderheit: Aktivitäten E und C laufen teilweise parallel, was typisch für IT-Projekte ist. Häufige Fehler: Abhängigkeiten falsch interpretieren (z.B. D sollte nach B UND C starten, nicht nur nach einem). YouTrack würde solche Abhängigkeiten automatisch berücksichtigen.

---

## Aufgabe 2: Kritischer Pfad (CPM) berechnen

### Aufgabenteil A: CPM-Berechnung mit Zahlen – Lösung

**Projekttabelle (vollständig gefüllt):**

| Aktivität | Dauer | FAS | FES | SAS | SES | Puffer | Kritisch? |
|-----------|---|---|---|---|---|---|---|
| A | 3 | 0 | 3 | 0 | 3 | 0 | **JA** |
| B | 5 | 3 | 8 | 3 | 8 | 0 | **JA** |
| C | 2 | 3 | 5 | 6 | 8 | 3 | NEIN |
| D | 4 | 8 | 12 | 8 | 12 | 0 | **JA** |
| E | 6 | 5 | 11 | 6 | 12 | 1 | NEIN |
| F | 3 | 12 | 15 | 12 | 15 | 0 | **JA** |

**Berechnungsschritte erklärt:**

**Vorwärtsrechnung (FAS, FES):**
- A: FAS=0, FES=0+3=3 (kein Vorgänger)
- B: FAS=3 (nach A), FES=3+5=8
- C: FAS=3 (nach A), FES=3+2=5
- D: FAS=max(8,5)=8 (nach B und C), FES=8+4=12
- E: FAS=5 (nach C), FES=5+6=11
- F: FAS=max(12,11)=12 (nach D und E), FES=12+3=15

**Rückwärtsrechnung (SAS, SES):**
- F: SES=15 (Endtermin), SAS=15-3=12
- D: SES=12 (zu F), SAS=12-4=8
- E: SES=12 (zu F), SAS=12-6=6
- B: SES=8 (zu D), SAS=8-5=3
- C: SES=8 (zu D), SAS=8-2=6
- A: SES=3 (zu B und C), SAS=3-3=0

**Pufferberechnung:**
- A: 0 - 0 = 0 ✓ **Kritisch**
- B: 3 - 3 = 0 ✓ **Kritisch**
- C: 6 - 3 = 3 (hat Puffer)
- D: 8 - 8 = 0 ✓ **Kritisch**
- E: 6 - 5 = 1 (hat Puffer)
- F: 12 - 12 = 0 ✓ **Kritisch**

---

**Antworten auf die Fragen:**

**1. Wie lange dauert das Projekt insgesamt?**

**Lösung:** **15 Tage**

> Der Projektendtermin ist Tag 15 (FES von Aktivität F), also 15 Tage Gesamtdauer.

---

**2. Welche Aktivitäten liegen auf dem kritischen Pfad?**

**Lösung:** **A → B → D → F**

> Diese vier Aktivitäten haben Puffer = 0. Aktivitäten C und E haben freien Spielraum. Der kritische Pfad bestimmt die minimale Projektdauer von 15 Tagen.

---

**3. Welche Aktivität hat den größten Zeitpuffer und um wie viele Tage könnte sie verzögert werden?**

**Lösung:** **Aktivität C mit 3 Tagen Puffer** (alternativ: E mit 1 Tag, aber C hat mehr)

> Aktivität C könnte um maximal 3 Tage verzögert werden (SAS = 6, aktuell FAS = 3), ohne den Gesamtprojekttermin zu gefährden.

---

**4. Was passiert, wenn Aktivität B um 2 Tage verzögert wird?**

**Lösung:** **Das Gesamtprojekt verzögert sich um 2 Tage.**

**Begründung:**
- Aktivität B liegt auf dem kritischen Pfad (Puffer = 0)
- Neue FES von B: 8 + 2 = 10
- Neue FES von D: 10 + 4 = 14
- Neue FES von F: 14 + 3 = 17 (statt 15)
- **Neue Projektdauer: 17 Tage (Verzögerung um 2 Tage)**

> **Kommentar:** Dies ist ein fundamentales Konzept: Verzögerungen auf dem kritischen Pfad wirken sich 1:1 auf den Gesamttermin aus. Verzögerungen auf Aktivitäten mit Puffer können absorbiert werden. Teilnehmer sollten diesen Mechanismus verstanden haben.

---

### Aufgabenteil B: Netzplan-Netzwerk zeichnen

**Lösung: PDM-Netzwerk (Precedence Diagramming Method)**

```
                    ┌─────────────┐
                    │ Aktivität A │
                    │   3 Tage    │
                    └──────┬──────┘
                           │
                    ┌──────▼────────────┐
                    │                   │
            ┌───────▼────────┐   ┌──────▼─────────┐
            │ Aktivität B    │   │ Aktivität C    │
            │   5 Tage       │   │   2 Tage       │
            └────────┬────────┘   └────────┬───────┘
                     │                     │
                     │ (Aktivität E:6T)    │
                     │        ┌────────────┘
                     │        │
            ┌────────▼────────▼──┐
            │  Aktivität D       │
            │   4 Tage           │
            └─────────┬──────────┘
                      │
                      │ (Puffer: E hat 1 Tag)
            ┌─────────▼──────────┐
            │  Aktivität F       │
            │   3 Tage           │
            │  (Projektende)     │
            └────────────────────┘

Start: Tag 0 | Ende: Tag 15
Kritischer Pfad: A → B → D → F (durchgehend in Rot/Fett)
```

> **Kommentar:** Dieses Netzwerk zeigt die logischen Abhängigkeiten deutlicher als das Gantt-Diagramm. Es ist besonders hilfreich zur Berechnung des kritischen Pfades. Beachte: Aktivität E hat ein nicht-kritisches Fenster von Tag 5–11.

---

## Aufgabe 3: Zeitpuffer verstehen und anwenden

### Aufgabenteil A: Puffer-Konzepte – Lösungen

**1. Definition: Freier Puffer (Free Float)**

**Lösung:**

Der **freie Puffer** ist die Zeitreserve, um die eine Aktivität verzögert werden kann, ohne die **frühestmögliche Start-Zeit ihrer unmittelbaren Nachfolger** zu beeinflussen.

**Formel:** Freier Puffer = (Frühes Ende des Nachfolgers) − (Frühes Ende dieser Aktivität)

**Beispiel:** Wenn Aktivität C um 2 Tage verzögert wird (statt Tag 5 endet sie Tag 7), aber Aktivität D frühestens Tag 8 starten kann (wegen Aktivität B), dann hat C einen freien Puffer von mindestens 1 Tag.

> **Kommentar:** Freier Puffer ist oft schwer zu verstehen, weil er nur auf unmittelbare Nachfolger wirkt. Starke Antwort verbindet die Definition mit einem praktischen Beispiel.

---

**2. Definition: Gesamtzeitpuffer (Total Float)**

**Lösung:**

Der **Gesamtzeitpuffer** ist die Zeitreserve, um die eine Aktivität verzögert werden kann, ohne den **Projektendtermin** zu verschieben.

**Formel:** Gesamtzeitpuffer = Später Start (SAS) − Früher Start (FAS) = Später Ende (SES) − Frühes Ende (FES)

**Beispiel:** Aktivität C mit FAS=3, SAS=6 hat einen Gesamtzeitpuffer von 3 Tagen. Sie kann also bis Tag 6 starten und die Gesamtprojektdauer bleibt 15 Tage.

> **Kommentar:** Der Gesamtzeitpuffer ist das wichtigere Konzept für Projektmanager. Er zeigt, wie viel Flexibilität bei der Ressourcenplanung möglich ist.

---

**3. Frage: Warum ist der Unterschied zwischen freiem und Gesamtzeitpuffer praktisch wichtig?**

**Lösung:**

| Aspekt | Bedeutung |
|--------|-----------|
| **Freier Puffer klein, Gesamtzeitpuffer groß** | Die Aktivität kann verschoben werden, ohne ihre unmittelbaren Nachfolger zu beeinflussen, aber wenn zu lange verzögert, wirkt es auf den Gesamttermin |
| **Beide Puffer = 0** | Die Aktivität liegt auf dem kritischen Pfad; jede Verzögerung ist kritisch |
| **Praktische Implication** | Beim Ressourcen-Leveling sollten Aktivitäten mit hohem Gesamtzeitpuffer verschoben werden. Der freie Puffer hilft, lokale Ressourcenkonflikte zu erkennen. |
| **Beispiel aus YouTrack** | Ein Issue mit hohem Gesamtzeitpuffer kann zu einer späteren Sprint verschoben werden, ohne den Release-Termin zu gefährden. Ein Issue mit hohem freien Puffer kann auch verschoben werden, ohne abhängige Issues zu blockieren. |

> **Kommentar:** Dies ist eine tiefgreifende Frage für Projektmanager. Die beste Antwort verbindet Theorie mit praktischer Anwendung im Ressourcenmanagement.

---

### Aufgabenteil B: Szenario-Analyse

**Annahme:** Aktivität C (geplant: 2 Tage) dauert tatsächlich 3 Tage (+1 Tag Überschuss)

**Frage:** Muss der Projektendtermin verschoben werden?

**Lösung: NEIN**

**Begründung:**

Aktivität C hat einen Gesamtzeitpuffer von **3 Tagen** (SAS=6, FAS=3).

Wenn C tatsächlich 3 Tage dauert (statt 2):
- Neue FES von C: 3 + 3 = 6 (statt 5)
- Neue FAS von D: max(8, 6) = 8 (unverändert, weil B früher endet)
- Neue FES von F: 12 + 3 = 15 (unverändert)
- **Projektendtermin bleibt Tag 15** ✓

Der neue Gesamtzeitpuffer von C ist nur noch 2 Tage (SAS=6, neue FAS=3, Überschuss=1).

**Fazit:** Die Verzögerung wird vom Puffer absorbiert. Das Projekt bleibt im Plan, aber der Spielraum für weitere Verzögerungen von C ist gesunken.

> **Kommentar:** Dies zeigt den praktischen Wert von Zeitpuffern: Sie sind "Versicherung" gegen kleine Verzögerungen. Häufiger Fehler: Teilnehmer denken, dass jede Verzögerung direkt zu Projektverzögerung führt. Das ist nur wahr für Aktivitäten auf dem kritischen Pfad.

---

## Aufgabe 4: Ressourcen-Leveling

### Aufgabenteil A: Ressourcenkonflikt-Identifikation – Lösung

**Aufgabe 1: In welcher Woche liegt ein Ressourcenkonflikt vor?**

**Lösung: Woche 2**

> In Woche 2 sind Backend und Frontend geplant mit insgesamt 50 Stunden. Die Kapazität beträgt 40 Stunden/Woche = **ÜBERAUSLASTUNG**.

---

**Aufgabe 2: Wie hoch ist die Überauslastung in Prozent?**

**Lösung: 25%**

**Berechnung:**
- Geplanter Aufwand: 50 Stunden
- Verfügbare Kapazität: 40 Stunden
- Überauslastung: (50 − 40) / 40 = 10 / 40 = 0,25 = **25%**

> Das bedeutet: Der Entwickler würde in Woche 2 um 25% überlastet sein, wenn beide Aktivitäten wie geplant durchgeführt werden. Dies führt typischerweise zu Qualitätsproblemen, Ermüdung und Verzögerungen.

---

**Aufgabe 3: Welche Strategien würden Sie zur Konfliktlösung vorschlagen?**

**Lösung (Multiple Strategien):**

| Strategie | Beschreibung | Vor- und Nachteile |
|-----------|---|---|
| **Strategie 1: Frontend-Entwicklung verschieben** | Frontend von Woche 2 auf Woche 3 verschieben | ✓ Nutzt Puffer von Frontend; ✗ Integrationsphase verzögert sich |
| **Strategie 2: Backend in Woche 1 beginnen** | Backend früher starten (wenn möglich) | ✓ Parallele Entwicklung; ✗ Abhängigkeiten prüfen nötig |
| **Strategie 3: Externe Ressource für Frontend** | Junior-Entwickler oder Subunternehmer für Frontend-Woche 2 | ✓ Keine Verzögerung; ✗ Zusatzkosten, Onboarding nötig |
| **Strategie 4: Aktivitätsaufteilen** | Frontend in Woche 2 auf 20h reduzieren, Rest Woche 3 | ✓ Reduziert Spitze; ✗ Kontextwechsel ineffizient |
| **Strategie 5: Testing früher beginnen** | Testing parallel zu Entwicklung (wenn möglich) | ✓ Verkürzt Gesamtdauer; ✗ Höheres Fehlerrisiko |

**Empfehlung:** **Strategie 1** (Frontend verschieben) oder **Strategie 2** (Backend früher starten), da kostenneutral und Puffer vorhanden.

> **Kommentar:** Dies zeigt praktisches Ressourcenmanagement-Denken. Teilnehmer sollten mehrere Optionen nennen und bewerten können. Häufiger Fehler: Nur eine Lösung nennen oder zu schnell zur kostengünstigen Option greifen, ohne Abhängigkeiten zu prüfen.

---

### Aufgabenteil B: Ressourcen-Leveling durchführen – Lösung

**Optimierter Ressourcenplan (eine mögliche Lösung):**

| Woche | Aktivität 1 | Aufwand 1 | Aktivität 2 | Aufwand 2 | GESAMT | Nutzenkommentar |
|---|---|---|---|---|---|---|
| 1 | Backend (B) | 35h | — | — | 35h (87%) | Normal |
| 2 | Backend (B) | 35h | — | — | 35h (87%) | Backend läuft weiter |
| 3 | Frontend (D) | 20h | Testing (G) | 20h | 40h (100%) | Optimal ausgeglichen |
| 4 | Frontend (D) | 20h | Testing (G) | 5h | 25h (62%) | Frontend abgeschlossen |
| 5 | Testing (G) | 20h | — | — | 20h (50%) | Testing abgeschlossen |

**Oder Alternative: Backend vorverlegen**

| Woche | Aktivität 1 | Aufwand 1 | Aktivität 2 | Aufwand 2 | GESAMT |
|---|---|---|---|---|---|
| 1 | Backend (B) | 35h | — | — | 35h (87%) |
| 2 | Backend (B) | 5h | Frontend (D) | 35h | 40h (100%) |
| 3 | Frontend (D) | 15h | Testing (G) | 20h | 35h (87%) |
| 4 | Testing (G) | 20h | — | — | 20h (50%) |

**Analyse:**
- **Keine Woche über 100%** ✓
- **Gesamtaufwand unverändert** (Backend 40h, Frontend 35h, Testing 45h) ✓
- **Verlängerung:** 5 Wochen statt 4 Wochen (1 Woche länger) – akzeptabel bei Ressourcenbegrenzung

> **Kommentar:** Es gibt mehrere gültige Lösungen. Das Wichtigste: Kein Puffer übersteigt 100%, und die Sequenz respektiert logische Abhängigkeiten. Häufiger Fehler: Aktivitäten verschieben, ohne Abhängigkeiten zu prüfen (z.B. Testing vor Entwicklung verschieben).

---

## Aufgabe 5: Terminverzögerungen managen

### Aufgabe 1: Verzögerungserkennung – Lösung

**Welche Aktivitäten bereiten Probleme?**

**Lösung:**

| Aktivität | Problem | Schweregrad | Begründung |
|-----------|---------|---|---|
| **C (Puffer: 4 Tage)** | **KRITISCH** | 🔴 Hoch | Ursprüngliche Dauer: 2 Tage; tatsächlich 3 Tage nach Tag 30. Verzögerung = 1 Tag. Puffer sinkt von 4 auf 3 Tage. |
| **B (Kritisch)** | **WARNUNG** | 🟡 Mittel | Geplant: 5 Tage bis Tag 10 (Ende); nach Tag 30 noch laufend (4 Tage fertig). Liegt hinter Plan? Muss klären, ob Verzögerung besteht. |
| **D (Kritisch)** | **WARNUNG** | 🟡 Mittel | Noch nicht gestartet. Abhängig von B. Wenn B nicht fertig ist, kann D nicht starten → kaskadierende Verzögerung. |

**Fokus-Problem:** Aktivität C hat nur noch 3 Tage Puffer statt 4. Wenn weitere kleine Verzögerungen auftreten, könnte C kritisch werden.

> **Kommentar:** Dies zeigt Früherkennung von Risiken. Die Best Practice: Prüfen nicht nur, ob Plan überschritten ist, sondern ob Puffer schwindet. Häufiger Fehler: Nur abgeschlossene Aktivitäten beachten, nicht laufende.

---

### Aufgabe 2: Risikoanalyse – Lösung

**1. Wie wirkt sich die Verzögerung in Aktivität C auf den Gesamtprojekttermin aus?**

**Lösung:**

**Direkte Auswirkung: KEINE (noch), aber Risiko steigt.**

**Begründung:**
- Aktivität C hat Puffer von 4 Tagen (ursprünglich)
- Die 1-Tage-Verzögerung reduziert Puffer auf 3 Tage
- Solange Puffer > 0, hat Verzögerung keine Auswirkung auf Gesamttermin
- **ABER:** Bei weiteren kleinen Verzögerungen (noch 3 Tage möglich) wird C kritisch

**Szenario-Analyse:**
- Wenn C noch weitere 3+ Tage verzögert: **Projektendtermin verschiebt sich**
- Aktivität E (Puffer: 6 Tage) ist stabil, aber sollte überwacht werden

**Risiko-Level:** 🟡 **MITTEL** (noch nicht kritisch, aber nachlassen des Puffers beobachten)

---

**2. Welche Aktivität ist am kritischsten in der aktuellen Situation?**

**Lösung: Aktivität B (und abhängig davon D)**

**Begründung:**
- Aktivität B liegt auf dem **kritischen Pfad** (Puffer = 0)
- Aktivität B muss noch fertig werden (läuft nach Tag 30)
- Wenn B verzögert wird → D muss warten → Gesamtprojekt verzögert sich
- D ist abhängig von B und hat keinen eigenen Puffer

**Monitoring-Priorität:**
1. 🔴 **Aktivität B** – täglich überwachen (kritischer Pfad)
2. 🟡 **Aktivität C** – wöchentlich überwachen (Puffer schrumpft)
3. 🟡 **Aktivität D** – prüfen, ob Ressourcen bereit sind für sofortigen Start nach B

> **Kommentar:** Dies zeigt Priorisierung im Monitoring. Kritische Aktivitäten bekommen tägliche Aufmerksamkeit, nicht-kritische wöchentlich. In YouTrack würde man B als "Blocker" markieren.

---

### Aufgabe 3: Beschleunigungsmaßnahmen – Lösung

**Szenario: Sie müssen das Projekt um 10 Tage beschleunigen.**

**Crashing-Ansatz (Ressourcen + Kosten erhöhen):**

**Maßnahmen:**
1. **Zusätzliche Entwickler für B einsetzen**: Dauer von 5 auf 3 Tage reduzieren (kostet +20% Budget)
2. **Überstunden für Testing (G) autorisiern**: Dauer von 8 auf 5 Tage (kostet Überstundenzuschlag)
3. **Paralleles Deployment**: Manche Tests parallel mit Entwicklung durchführen
4. **Externe QA-Unterstützung**: Zusätzliche Testressourcen einkaufen
5. **Priorisierung von Features**: Kernfeatures im ursprünglichen Zeitplan, Rest nach Launch

**Kosten-Nutzen:** -10 Tage kostet ca. +30–50% Zusatzbudget. Sinnvoll nur bei kritischem Geschäftsdatum.

---

**Fast-Tracking-Ansatz (Parallelisierung):**

**Maßnahmen:**
1. **Testing früher beginnen**: Sobald erste Module von Entwicklung verfügbar, beginnt Unit-Testing (statt Sequential)
2. **Design & Entwicklung parallel**: Backend-Entwicklung startet parallel zu Frontend-Design (mit Risiko)
3. **Integration & Testing parallel**: Integrierte Komponenten werden sofort getestet (kürzere Warteschlange)
4. **Deployment vorbereiten**: Infrastruktur-Setup läuft parallel zu letztem Testing (nicht hintereinander)
5. **Dokumentation agil**: Dokumentation wird während Entwicklung geschrieben, nicht nach Projekt-Ende

**Risiken:** Fehlerquote steigt (~15–25%), Rework erhöht sich, Kommunikation intensiver nötig.

**Resultat:** Möglicherweise -5 bis -8 Tage ohne massive Kostenerhöhung, aber mit höherem Qualitätsrisiko.

---

**Empfehlung:** **Hybrid-Ansatz**
- **Crashing für kritischen Pfad (B, D, F):** Kleine, kontrollierte Beschleunigung
- **Fast-Tracking für parallele Aktivitäten (C, E, G):** Early Testing
- **Erwartung:** -7 bis -10 Tage möglich mit moderater Kostenerhöhung und managedebarem Risiko

> **Kommentar:** Gute Antworten zeigen beide Ansätze und deren Kompromisse. Häufiger Fehler: Beide als gleich gut darstellen, ohne Risiken zu beachten. In der Praxis: Crashing ist teuer, Fast-Tracking ist risikoreicher.

---

## Aufgabe 6: YouTrack-Praktikum – Lösung

**Aufgabe (Praktische Umsetzung, wenn YouTrack verfügbar):**

**Erstellte Issues mit Abhängigkeiten:**

```
YOUTRACK PROJEKT-STRUKTUR:

Issue-1: Anforderungsanalyse
- Fälligkeitsdatum: +5 Tage (z.B. 22.11.2025)
- Aufwandsschätzung: 5 Tage
- Status: Open

Issue-2: Design
- Fälligkeitsdatum: +12 Tage (z.B. 29.11.2025)
- Aufwandsschätzung: 7 Tage
- Abhängigkeit: "blockiert von" Issue-1
- Status: Open (wartet auf Issue-1)

Issue-3: Entwicklung
- Fälligkeitsdatum: +22 Tage (z.B. 09.12.2025)
- Aufwandsschätzung: 10 Tage
- Abhängigkeit: "blockiert von" Issue-2
- Status: Open (wartet auf Issue-2)

Issue-4: Testing
- Fälligkeitsdatum: +27 Tage (z.B. 14.12.2025)
- Aufwandsschätzung: 5 Tage
- Abhängigkeit: "blockiert von" Issue-3
- Status: Open (wartet auf Issue-3)

Meilenstein: "Launch"
- Fälligkeitsdatum: +27 Tage
- Zugeordnete Issues: Issue-4
```

**Gantt-View in YouTrack:**
- Zeigt automatisch Balkendiagramm mit Abhängigkeitslinien
- Issue-1 startet Tag 0, endet Tag 5
- Issue-2 startet Tag 5, endet Tag 12
- Issue-3 startet Tag 12, endet Tag 22
- Issue-4 startet Tag 22, endet Tag 27
- Meilenstein "Launch" bei Tag 27 als Raute

---

**Ressourcenauslastung überprüfen:**

Wenn Sie drei Entwickler zuordnen (Dev-A für Issue-1, Dev-B für Issue-2 & 3, Dev-C für Issue-4), zeigt YouTrack:
- **Auslastungs-Heatmap**: Wer ist in welcher Woche busy/free
- **Überauslastung-Warnung**: Wenn eine Person zu viele Issues parallel hat
- **Kapazitäts-Matrix**: Gesamte Teamauslastung

---

**Durchführung: Issue-1-Dauer ändern von 5 auf 7 Tage**

**Beobachtung in YouTrack:**
1. Issue-1 endet jetzt Tag 7 (statt Tag 5)
2. Issue-2 startet automatisch Tag 7 (statt Tag 5) – **aktualisiert automatisch!**
3. Issue-2 endet Tag 14 (statt Tag 12)
4. Issue-3 startet Tag 14 (statt Tag 12) – **Kaskadeneffekt!**
5. Alle nachfolgenden Termine verschieben sich um 2 Tage
6. **Neuer Projektendtermin: Tag 29** (statt Tag 27)
7. YouTrack-Warnung: "Meilenstein 'Launch' ist 2 Tage überfällig"

---

**Besonderheiten von YouTrack-Gantt vs. klassischen Tools:**

| Aspekt | YouTrack | MS Project | Vorteil YouTrack |
|--------|----------|-----------|---|
| **Automatische Abhängigkeitsberechnung** | ✓ Ja, Echtzeit | ✓ Ja | YouTrack aktualisiert während Sie arbeiten |
| **Ressourcenkonflikt-Erkennung** | ~ Teilweise | ✓ Ja | Project ist besser, aber YouTrack reicht für agile Projekte |
| **Integriert mit Issue-Tracking** | ✓ Ja, native | ~ Add-on | YouTrack verbindet Planung mit Tasks |
| **Skalierbarkeit (100+ Issues)** | ✓ Ja | ~ Langsamer | YouTrack besser für große agile Projekte |
| **Benutzerfreundlichkeit** | ✓ Modern UI | ~ Komplex | YouTrack intuitiver für Team-Collaboration |
| **Kosten** | $ Moderat (Cloud) | $$ Teuer (lizenziert) | YouTrack billiger für Teams |

**Fazit:** YouTrack ist ideal für **agile und iterative Projekte** mit vielen Issues. Für **klassische Wasserfall-Projekte mit komplexer CPM** ist MS Project noch besser.

> **Kommentar:** Dies zeigt praktisches Tool-Verständnis. Gute Antworten kennen Vor- und Nachteile verschiedener Werkzeuge. Ein Projektmanager sollte beide beherrschen.

---

## Häufige Fehler und deren Vermeidung

| Fehler | Auswirkung | Vermeidung |
|--------|-----------|-----------|
| **Abhängigkeiten falsch verstehen** (z.B. D nur nach B, nicht nach C) | Falscher kritischer Pfad, Planungsfehler | Checkliste: Alle Vorgänger prüfen |
| **Zeitpuffer vergessen** | Unrealistische Planung, übermäßige Stress | Puffer proaktiv einplanen (10–15% je Phase) |
| **Ressourcenkonflikte ignorieren** | Qualitätsabfall, versteckte Verzögerungen | Ressourcenhistogramm vor Plan-Freigabe prüfen |
| **Crashing ohne Risiko-Analyse** | Qualitätseinbußen, höhere Fehlerquote | Erst Risk-Bewertung, dann Beschleunigung |
| **Zu viel Parallelisierung (Fast-Tracking)** | Rework, zusätzliche Kosten | Nur bei niedrigem Risiko parallelisieren |
| **Gantt-Diagramm veraltet lassen** | Team arbeitet nach falschem Plan | Wöchentliche Updates etablieren |
| **Meilensteine nicht überwachen** | Zu späte Früherkennung von Verzögerungen | Meilenstein-Checks in regelmäßigen Meetings |

---

## Zusammenfassung der Lernziele (Selbstevaluierung)

Nach diesem Modul sollten Sie **JA** antworten können auf:

- [ ] Kann ich ein professionelles Gantt-Diagramm mit allen Elementen erstellen?
- [ ] Verstehe ich den kritischen Pfad und kann ihn berechnen?
- [ ] Kann ich Zeitpuffer (frei & gesamt) unterscheiden und anwenden?
- [ ] Kenne ich die Strategien für Ressourcen-Leveling?
- [ ] Kann ich Terminverzögerungen früh erkennen und Maßnahmen einleiten?
- [ ] Weiß ich, wann Crashing und wann Fast-Tracking sinnvoll ist?
- [ ] Kann ich YouTrack zur Zeitplanung nutzen?
- [ ] Verstehe ich die Wechselwirkung zwischen Zeit, Kosten und Qualität?
