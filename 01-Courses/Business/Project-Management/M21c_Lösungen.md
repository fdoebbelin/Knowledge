## Block 1: Projektgrundlagen, SMART, Lasten-/Pflichtenheft

### 1.1 Projektmerkmale

**Lösung:**

| Nr. | Vorhaben | Projekt | Routineaufgabe |
|-----|----------|---------|----------------|
| a) | Wöchentliche Datensicherung aller Server | ☐ | ☒ |
| b) | Migration der gesamten IT-Infrastruktur in die Cloud | ☒ | ☐ |
| c) | Monatliche Erstellung von Verbrauchsstatistiken | ☐ | ☒ |
| d) | Entwicklung einer neuen mobilen App für Kunden | ☒ | ☐ |
| e) | Tägliche Beantwortung von Helpdesk-Anfragen | ☐ | ☒ |

**Begründung (kurz):**
- Projekte: einmalig, zeitlich begrenzt, komplex, mit definiertem Ziel (b, d)
- Routineaufgaben: wiederkehrend, standardisiert (a, c, e)

---

### 1.2 SMART-Prinzip

**Lösung:**

| Nr. | Projektziel | SMART | Nicht SMART |
|-----|-------------|-------|-------------|
| a) | Die Website soll schneller werden. | ☐ | ☒ |
| b) | Ladezeit Startseite bis 30.06.2025 von 5 auf < 2 Sekunden | ☒ | ☐ |
| c) | IT-Supportanfragen um 20% in 6 Monaten senken | ☒ | ☐ |
| d) | Verbesserung der Kundenzufriedenheit durch besseren Service. | ☐ | ☒ |
| e) | DSGVO-Anforderungen bis Stichtag mit vollständiger Doku umsetzen | ☒ | ☐ |

**Kriterien:**
- a, d fehlen konkrete Messwerte und/oder Terminierung → nicht SMART
- b, c, e sind konkret, messbar, realistisch und terminiert

---

### 1.3 Lasten- und Pflichtenheft

**Lösung:**

| Nr. | Inhalt | L oder P |
|-----|--------|----------|
| a) | "System muss 1000 Benutzer gleichzeitig verwalten." | L |
| b) | "Wir setzen eine PostgreSQL-Datenbank Version 15.2 ein." | P |
| c) | "Benutzeroberfläche soll intuitiv und barrierefrei sein." | L |
| d) | "Implementierung mit Framework React 18 und TypeScript." | P |
| e) | "Projektende bis 31.12.2025, max. 80.000 € Kosten." | L |

**Merksatz:**
- Lastenheft = Anforderungen und Rahmenbedingungen (WAS)
- Pflichtenheft = technische Umsetzung (WIE)

---

## Block 2: Vorgehensmodelle – Wasserfall & Scrum

### 2.1 Wasserfall vs. Scrum

**Lösung:**

| Nr. | Aussage | W oder S |
|-----|---------|----------|
| a) | Anforderungen zu Beginn vollständig festgelegt. | W |
| b) | Regelmäßiges Kundenfeedback. | S |
| c) | Arbeit in kurzen Iterationen (Sprints). | S |
| d) | Phasen werden nacheinander abgearbeitet. | W |
| e) | Rollen Product Owner, Scrum Master, Entwicklungsteam. | S |
| f) | Änderungen sind schwierig und teuer. | W |
| g) | Tägliche Kurzbesprechungen zur Synchronisation. | S |
| h) | Geeignet bei stabilen Anforderungen. | W |
| i) | Nach jedem Zyklus ein potenziell auslieferbares Inkrement. | S |
| j) | Phasen: Analyse, Design, Implementierung, Test, Wartung. | W |

---

### 2.2 Scrum-Rollen

**Lösung:**

| Nr. | Aufgabe | Rolle |
|-----|---------|-------|
| a) | Priorisiert das Product Backlog. | PO |
| b) | Moderiert das Daily Scrum, beseitigt Hindernisse. | SM |
| c) | Entwickelt das Produktinkrement. | ET |
| d) | Entscheidet über Inhalte des nächsten Sprints. | PO |
| e) | Schützt das Team vor Störungen. | SM |

---

## Block 3: Netzplantechnik (KORRIGIERT)

### 3.1 Netzplan, Zeiten, Puffer, kritischer Pfad

**KORRIGIERTE Ergebnisse:**

#### Vorwärtsrechnung (FAZ/FEZ):

| Vorgang | Dauer | FAZ | FEZ |
|---------|-------|-----|-----|
| A | 5 | 0 | 5 |
| B | 3 | 5 | 8 |
| C | 4 | 5 | 9 |
| D | 2 | 8 | 10 |
| E | 6 | **10** | **16** |
| F | 3 | 10 | 13 |
| G | 4 | **16** | **20** |
| H | 1 | **20** | **21** |

**Minimale Projektdauer: 21 Tage** ✅

---

**Erklärung der Berechnung:**

- **A:** FAZ = 0 (Start), FEZ = 0 + 5 = 5
- **B, C:** FAZ = FEZ(A) = 5 (parallele Vorgänge)
  - B: FEZ = 5 + 3 = 8
  - C: FEZ = 5 + 4 = 9
- **D:** FAZ = FEZ(B) = 8, FEZ = 8 + 2 = 10
- **E:** FAZ = max(FEZ(C), FEZ(D)) = max(9, 10) = **10** ← WICHTIG: OHNE +1!
  - FEZ = 10 + 6 = **16** ✅ (nicht 17!)
- **F:** FAZ = FEZ(D) = 10, FEZ = 10 + 3 = 13
- **G:** FAZ = max(FEZ(E), FEZ(F)) = max(16, 13) = **16** ✅ (nicht 17!)
  - FEZ = 16 + 4 = **20** ✅ (nicht 21!)
- **H:** FAZ = FEZ(G) = 20, FEZ = 20 + 1 = **21** ✅ (nicht 22!)

---

#### Rückwärtsrechnung (SAZ/SEZ):

| Vorgang | Dauer | SAZ | SEZ |
|---------|-------|-----|-----|
| A | 5 | 0 | 5 |
| B | 3 | 5 | 8 |
| C | 4 | 6 | 10 |
| D | 2 | 8 | 10 |
| E | 6 | 10 | 16 |
| F | 3 | 13 | 16 |
| G | 4 | 16 | 20 |
| H | 1 | 20 | 21 |

**Erklärung der Rückwärtsrechnung:**

- **H (letzter):** SEZ = 21 (Projektende), SAZ = 21 - 1 = 20
- **G:** SEZ = SAZ(H) = 20, SAZ = 20 - 4 = 16
- **E:** SEZ = SAZ(G) = 16, SAZ = 16 - 6 = 10
- **F:** SEZ = SAZ(G) = 16, SAZ = 16 - 3 = 13
- **D:** SEZ = min(SAZ(E), SAZ(F)) = min(10, 13) = 10, SAZ = 10 - 2 = 8
- **B:** SEZ = SAZ(D) = 8, SAZ = 8 - 3 = 5
- **C:** SEZ = SAZ(E) = 10, SAZ = 10 - 4 = 6
- **A:** SEZ = min(SAZ(B), SAZ(C)) = min(5, 6) = 5, SAZ = 5 - 5 = 0

---

#### Gesamtpuffer (GP):

| Vorgang | GP |
|---------|-----|
| A | 0 |
| B | 0 |
| C | 1 |
| D | 0 |
| E | 0 |
| F | 3 |
| G | 0 |
| H | 0 |

**Berechnung:** GP = SAZ – FAZ

- A: 0 - 0 = **0**
- B: 5 - 5 = **0**
- C: 6 - 5 = **1** ✅ (nicht 2!)
- D: 8 - 8 = **0**
- E: 10 - 10 = **0**
- F: 13 - 10 = **3** ✅ (nicht 4!)
- G: 16 - 16 = **0**
- H: 20 - 20 = **0**

---

#### Kritischer Pfad:

**Kritischer Pfad:** **A → B → D → E → G → H**

*(Alle Vorgänge mit GP = 0)*

---

### Wichtige Hinweise zum Fehler:

**Problem in der ursprünglichen Musterlösung:**

Die ursprüngliche Lösung verwendete die Formel:
- FAZ(E) = max(FEZ(C), FEZ(D)) **+ 1**

Das ist **falsch**. Die korrekte Formel lautet:
- FAZ(E) = max(FEZ(C), FEZ(D))

Es gibt **keine automatische Wartezeit** zwischen Vorgängen. Ein Nachfolger kann am selben Zeitpunkt (Tag) beginnen, an dem sein Vorgänger endet.

---

## Block 4: Gantt-Diagramm

### 4.1 Gantt-Diagramm (Ergebnisbeschreibung)

- Start: Montag, 03.03.2025
- Es werden nur Werktage gerechnet.
- Vorgang A: 5 Tage → Mo 3.3. bis Fr 7.3.
- Vorgang B: 3 Tage → Mo 10.3. bis Mi 12.3.
- Vorgang C: 4 Tage → Mo 10.3. bis Do 13.3.
- Vorgang D: 2 Tage → Do 13.3. bis Fr 14.3.
- Vorgang E: 6 Tage → Mo 17.3. bis Mo 24.3.
- Vorgang F: 3 Tage → Mo 17.3. bis Mi 19.3.
- Vorgang G: 4 Tage → Di 25.3. bis Fr 28.3.
- Vorgang H: 1 Tag → Mo 31.3.

**Kritischer Pfad im Gantt-Balkenplan:** A, B, D, E, G, H besonders kennzeichnen.

---

### 4.2 Vor- und Nachteile

**Mögliche Musterantworten:**

- **Vorteil:** Zeitliche Abfolge und Parallelität der Vorgänge sind leicht verständlich und gut visualisiert.
- **Nachteil:** Pufferzeiten und der kritische Pfad sind nicht so eindeutig erkennbar wie im Netzplan.

---

## Block 5: Wirtschaftlichkeit

### 5.1 ROI und Amortisation

**Gegeben:**
- Investition: 15.000 + 3.000 + 2.000 = 20.000 €
- Jährlicher Nutzen: 7.000 €
- Zeitraum: 5 Jahre

**Lösungen:**

1. Gesamtnutzen über 5 Jahre: 7.000 × 5 = **35.000 €**
2. Gesamtgewinn: 35.000 – 20.000 = **15.000 €**
3. ROI: (15.000 / 20.000) × 100% = **75%**
4. Amortisationszeit: 20.000 / 7.000 ≈ **2,86 Jahre**

---

### 5.2 Angebotsvergleich

**Angebot A:**
- Laufende Kosten: 500 × 36 = 18.000 €
- Einrichtungsgebühr: 1.000 €
- **Gesamtkosten A: 19.000 €**

**Angebot B:**
- Lizenz: 12.000 €
- Installation: 2.000 €
- Wartung: 1.500 × 3 = 4.500 €
- **Gesamtkosten B: 18.500 €**

**Rechnerisch günstiger:** Angebot B (18.500 € < 19.000 €)

**Zusatzaspekte (Beispiele):**
- Flexibilität (z.B. Kündbarkeit vs. hohe Einmalinvestition)
- Interner Administrationsaufwand
- Datenschutz und Datensicherheit
- Planbarkeit der Kosten

---

## Block 6: Risikomanagement

### 6.1 Risikobewertung

**Risikowerte:**

| Risiko | W | A | Risikowert |
|--------|---|---|------------|
| R1 | 2 | 4 | 8 |
| R2 | 3 | 5 | 15 |
| R3 | 2 | 3 | 6 |
| R4 | 1 | 4 | 4 |
| R5 | 4 | 3 | 12 |

**Höchste Priorität:** R2 (Wert 15)

**Begründung (kurz):**
- Hohe Auswirkung (Sicherheit, rechtliche Risiken, Image)
- Mittlere Wahrscheinlichkeit

---

### 6.2 Maßnahmenstrategien

**Lösung:**

| Nr. | Maßnahme | Strategie |
|-----|----------|-----------|
| a) | Einsatz erprobter Standardsoftware | V (Vermeiden) |
| b) | Abschluss einer Versicherung | Ü (Übertragen) |
| c) | Regelmäßige Code- und Sicherheitsaudits | M (Mindern) |
| d) | Kleine Risiken bewusst in Kauf nehmen | A (Akzeptieren) |

---

## Block 7: Stakeholder & RACI

### 7.1 Stakeholder-Matrix

**Lösung:**

| | Geringes Interesse | Hohes Interesse |
|-------------------|------------------|-----------------|
| **Hoher Einfluss** | 3 (Rechtsabteilung) | 1 (Geschäftsführung) |
| **Geringer Einfluss** | 4 (externer Datenschutzberater) | 2 (IT-Abteilung) |

---

### 7.2 RACI-Matrix (eine sinnvolle Beispiel-Lösung)

| Aufgabe | Projektleiter | Entwickler | Kunde | Qualitätssicherung |
|---------|--------------|------------|-------|-------------------|
| Anforderungsanalyse | A | C | R | I |
| Entwicklung der Software | A | R | I | C |
| Testing | A | C | I | R |
| Abnahme | C | I | A/R | I |

**Hinweis:** In der Praxis kann man auch Kunde = A, Projektleiter = R setzen – wichtig ist: **pro Aufgabe nur ein "A"**.

---

## Block 8: Agile Grundlagen (Scrum)

### 8.1 Kurzantworten

1. **Sprint:** Ein fester Zeitraum (meist 1–4 Wochen), in dem ein Produktinkrement entwickelt wird.
2. **Daily Scrum:** Tägliches, kurzes Meeting (max. 15 Min.), um den aktuellen Stand und Hindernisse im Entwicklungsteam zu besprechen.
3. **Verantwortlich für das Product Backlog:** Product Owner.
4. **Produktinkrement:** Das am Ende eines Sprints entstehende, potenziell auslieferbare, fertige Teilprodukt.
5. **Aufgabe der Sprint-Retrospektive:** Das Team reflektiert den Prozess und überlegt, wie die Zusammenarbeit und Arbeitsweise im nächsten Sprint verbessert werden kann.

---

## Zusammenfassung der Korrekturen

| Punkt | Fehler in Original | Korrigiert zu |
|-------|-------------------|---------------|
| FAZ(E) | 11 | **10** |
| FEZ(E) | 17 | **16** |
| FAZ(G) | 17 | **16** |
| FEZ(G) | 21 | **20** |
| FAZ(H) | 21 | **20** |
| FEZ(H) | 22 | **21** |
| GP(C) | 2 | **1** |
| GP(F) | 4 | **3** |
| **Projektdauer** | **22 Tage** | **21 Tage** |

**Ursache:** In der Originalversion wurde fälschlicherweise FAZ(E) = max(FEZ(C), FEZ(D)) **+ 1** berechnet. Die korrekte Formel lautet FAZ(E) = max(FEZ(C), FEZ(D)) **ohne additive Wartezeit**.

---

**Mit diesen korrigierten Lösungen können Lernende sicher trainieren! ✅**
