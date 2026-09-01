> Hinweis: Alle Aufgaben sind **softwareunabhängig** formuliert und konzentrieren sich auf Inhalte, wie sie typischerweise in der AP1 im Themenbereich Projektmanagement vorkommen.

## Block 1: Projektgrundlagen, SMART, Lasten-/Pflichtenheft

### 1.1 Projektmerkmale (5 Punkte)

Kreuzen Sie an, ob es sich um ein **Projekt** oder eine **Routineaufgabe** handelt.

| Nr. | Vorhaben | Projekt | Routineaufgabe |
|-----|----------|---------|----------------|
| a) | Wöchentliche Datensicherung aller Server | ☐ | ☐ |
| b) | Migration der gesamten IT-Infrastruktur in die Cloud | ☐ | ☐ |
| c) | Monatliche Erstellung von Verbrauchsstatistiken | ☐ | ☐ |
| d) | Entwicklung einer neuen mobilen App für Kunden | ☐ | ☐ |
| e) | Tägliche Beantwortung von Helpdesk-Anfragen | ☐ | ☐ |

---

### 1.2 SMART-Prinzip (5 Punkte)

Welche Projektziele sind SMART formuliert?

| Nr. | Projektziel | SMART | Nicht SMART |
|-----|-------------|-------|-------------|
| a) | Die Website soll schneller werden. | ☐ | ☐ |
| b) | Die Ladezeit der Startseite wird bis zum 30.06.2025 von 5 auf unter 2 Sekunden reduziert. | ☐ | ☐ |
| c) | Reduzierung der IT-Supportanfragen um 20% innerhalb von 6 Monaten durch Einführung eines Self-Service-Portals. | ☐ | ☐ |
| d) | Verbesserung der Kundenzufriedenheit durch besseren Service. | ☐ | ☐ |
| e) | Umsetzung der DSGVO-Anforderungen bis zum gesetzlichen Stichtag mit vollständiger Dokumentation. | ☐ | ☐ |

---

### 1.3 Lasten- und Pflichtenheft (5 Punkte)

Tragen Sie **L** für Lastenheft oder **P** für Pflichtenheft ein.

| Nr. | Inhalt | L oder P |
|-----|--------|----------|
| a) | "Das System muss in der Lage sein, 1000 Benutzer gleichzeitig zu verwalten." | |
| b) | "Wir setzen eine PostgreSQL-Datenbank mit Version 15.2 ein." | |
| c) | "Die Benutzeroberfläche soll intuitiv und barrierefrei gestaltet sein." | |
| d) | "Für die Implementierung verwenden wir das Framework React 18 mit TypeScript." | |
| e) | "Das Projekt soll bis zum 31.12.2025 abgeschlossen sein und darf maximal 80.000 € kosten." | |

---

## Block 2: Vorgehensmodelle – Wasserfall & Scrum

### 2.1 Vergleich Wasserfallmodell vs. Scrum (10 Punkte)

Ordnen Sie die Aussagen dem passenden Vorgehensmodell zu. Tragen Sie **W** für Wasserfallmodell oder **S** für Scrum ein.

| Nr. | Aussage | W oder S |
|-----|---------|----------|
| a) | Alle Anforderungen werden zu Beginn möglichst vollständig festgelegt. | |
| b) | Kundenfeedback wird in regelmäßigen Abständen eingeholt und umgesetzt. | |
| c) | Die Arbeit ist in kurze Iterationen (Sprints) von 1–4 Wochen eingeteilt. | |
| d) | Jede Phase wird vollständig abgeschlossen, bevor die nächste beginnt. | |
| e) | Es gibt feste Rollen: Product Owner, Scrum Master, Entwicklungsteam. | |
| f) | Änderungen während der Umsetzung sind eher schwierig und teuer. | |
| g) | Kurze tägliche Besprechungen zur Synchronisation des Teams sind üblich. | |
| h) | Besonders gut geeignet bei stabilen, klar definierten Anforderungen. | |
| i) | Nach jedem Zyklus entsteht ein potenziell auslieferbares Produktinkrement. | |
| j) | Typische Phasen: Anforderungsanalyse, Design, Implementierung, Test, Wartung. | |

---

### 2.2 Scrum-Rollen (5 Punkte)

Ordnen Sie die Aufgaben den Scrum-Rollen zu. Tragen Sie **PO** (Product Owner), **SM** (Scrum Master) oder **ET** (Entwicklungsteam) ein.

| Nr. | Aufgabe | Rolle |
|-----|---------|-------|
| a) | Priorisiert die Einträge im Product Backlog. | |
| b) | Moderiert das Daily Scrum und beseitigt Hindernisse. | |
| c) | Entwickelt die Software und erstellt das Produktinkrement. | |
| d) | Entscheidet, welche Anforderungen im nächsten Sprint umgesetzt werden. | |
| e) | Schützt das Team vor Störungen von außen. | |

---

## Block 3: Netzplantechnik (KORRIGIERT)

### 3.1 Netzplan mit kritischem Pfad (25 Punkte)

Gegeben ist ein Projekt zur Einführung eines neuen Ticketsystems mit folgenden Vorgängen:

| Vorgang | Bezeichnung | Dauer (Tage) | Vorgänger |
|---------|-------------|--------------|-----------|
| A | Anforderungsanalyse | 5 | - |
| B | Systemauswahl | 3 | A |
| C | Datenbank-Design | 4 | A |
| D | Installation und Konfiguration | 2 | B |
| E | Datenmigration | 6 | C, D |
| F | Schulung der Mitarbeiter | 3 | D |
| G | Testphase | 4 | E, F |
| H | Go-Live und Abnahme | 1 | G |

**Aufgaben:**

#### a) Netzplan zeichnen (8 Punkte)

Zeichnen Sie einen Netzplan (Vorgangsknotennetz) für dieses Projekt. Nutzen Sie folgende Struktur pro Knoten:

```
┌─────────────────────────────┐
│   FAZ   │   D   │   FEZ     │
├─────────┼───────┼───────────┤
│   Vorgang-Bezeichnung       │
├─────────┼───────┼───────────┤
│   SAZ   │   GP  │   SEZ     │
└─────────────────────────────┘
```

*(Zeichnung auf separatem Blatt)*

---

#### b) Vorwärtsrechnung: FAZ und FEZ (4 Punkte)

Berechnen Sie für jeden Vorgang FAZ (Frühester Anfangszeitpunkt) und FEZ (Frühester Endzeitpunkt).

| Vorgang | FAZ | FEZ |
|---------|-----|-----|
| A | | |
| B | | |
| C | | |
| D | | |
| E | | |
| F | | |
| G | | |
| H | | |

---

#### c) Minimale Projektdauer (2 Punkte)

**Minimale Projektdauer:** __________ Tage

---

#### d) Rückwärtsrechnung: SAZ und SEZ (4 Punkte)

Berechnen Sie für jeden Vorgang SAZ (Spätester Anfangszeitpunkt) und SEZ (Spätester Endzeitpunkt).

| Vorgang | SAZ | SEZ |
|---------|-----|-----|
| A | | |
| B | | |
| C | | |
| D | | |
| E | | |
| F | | |
| G | | |
| H | | |

---

#### e) Gesamtpuffer (GP) berechnen (4 Punkte)

Berechnen Sie den Gesamtpuffer für jeden Vorgang. Formel: **GP = SAZ – FAZ = SEZ – FEZ**

| Vorgang | GP |
|---------|-----|
| A | |
| B | |
| C | |
| D | |
| E | |
| F | |
| G | |
| H | |

---

#### f) Kritischer Pfad bestimmen (3 Punkte)

**Kritischer Pfad:** ______________________________________

*(Welche Vorgänge liegen auf dem kritischen Pfad? Hinweis: Das sind alle mit GP = 0)*

---

## Block 4: Gantt-Diagramm

### 4.1 Gantt-Diagramm erstellen (7 Punkte)

Nutzen Sie die Vorgänge aus **Aufgabe 3.1**.

- Projektstart: **Montag, 03.03.2025**
- Es wird nur an **Werktagen (Mo–Fr)** gearbeitet.

**Aufgabe:**

1. Erstellen Sie ein Gantt-Diagramm mit den Vorgängen A–H.
2. Berücksichtigen Sie Wochenenden.
3. Markieren Sie die Vorgänge des kritischen Pfads besonders.

*(Zeichnung auf separatem Blatt oder in Tabellenform)*

---

### 4.2 Vor- und Nachteile (3 Punkte)

1. Nennen Sie **einen Vorteil** eines Gantt-Diagramms gegenüber einem Netzplan.

   _________________________________________________________________

2. Nennen Sie **einen Nachteil** eines Gantt-Diagramms gegenüber einem Netzplan.

   _________________________________________________________________

---

## Block 5: Wirtschaftlichkeit

### 5.1 ROI und Amortisation (7 Punkte)

Ein Unternehmen plant ein automatisiertes Backup-System.

**Kosten:**
- Anschaffung: 15.000 €
- Installation und Konfiguration: 3.000 €
- Schulung: 2.000 €

**Jährlicher Nutzen:**
- Zeitersparnis IT-Personal: 4.000 €
- Vermeidung von Datenverlusten: 3.000 €

**Betrachtungszeitraum:** 5 Jahre

**Aufgaben:**
1. Berechnen Sie den **Gesamtnutzen** über 5 Jahre.
2. Berechnen Sie den **Gesamtgewinn** über 5 Jahre.
3. Berechnen Sie den **ROI in %**.
4. Berechnen Sie die **Amortisationszeit**.

---

### 5.2 Angebotsvergleich (8 Punkte)

Ein Unternehmen vergleicht zwei Angebote für ein Projektmanagement-Tool (rein rechnerisch, toolunabhängig):

**Angebot A (Mietmodell):**
- Monatliche Kosten: 500 €
- Einrichtungsgebühr (einmalig): 1.000 €
- Laufzeit: 3 Jahre

**Angebot B (Kaufmodell):**
- Lizenzkosten (einmalig): 12.000 €
- Installation (einmalig): 2.000 €
- Jährliche Wartung: 1.500 €
- Betrachtungszeitraum: 3 Jahre

**Aufgaben:**
1. Berechnen Sie die **Gesamtkosten von Angebot A** über 3 Jahre.
2. Berechnen Sie die **Gesamtkosten von Angebot B** über 3 Jahre.
3. Welches Angebot ist **rein rechnerisch** günstiger?
4. Nennen Sie **mindestens einen weiteren Aspekt**, der in der Praxis bei der Entscheidung eine Rolle spielen könnte (ohne konkrete Produktnamen zu nennen).

---

## Block 6: Risikomanagement

### 6.1 Risikobewertung (7 Punkte)

In einem Webshop-Projekt wurden folgende Risiken identifiziert:

| Nr. | Risiko | W (1–5) | A (1–5) |
|-----|--------|---------|---------|
| R1 | Ausfall eines Entwicklers durch Krankheit | 2 | 4 |
| R2 | Sicherheitslücken in der Software | 3 | 5 |
| R3 | Verzögerung bei der Lieferung von Server-Hardware | 2 | 3 |
| R4 | Änderung gesetzlicher Anforderungen | 1 | 4 |
| R5 | Überschreitung des Projektbudgets | 4 | 3 |

**Aufgaben:**
1. Berechnen Sie für jedes Risiko den **Risikowert** (W × A).
2. Welches Risiko hat die **höchste Priorität**?
3. Begründen Sie kurz, warum dieses Risiko kritisch ist.

---

### 6.2 Maßnahmenstrategien (3 Punkte)

Ordnen Sie die Maßnahmen den Strategien **Vermeiden (V)**, **Mindern (M)**, **Übertragen (Ü)**, **Akzeptieren (A)** zu.

| Nr. | Maßnahme | Strategie |
|-----|----------|-----------|
| a) | Einsatz erprobter Standardsoftware statt experimenteller Eigenentwicklung. | |
| b) | Abschluss einer Versicherung für bestimmte Schadensfälle. | |
| c) | Einführung regelmäßiger Code- und Sicherheitsaudits. | |
| d) | Kleine Risiken werden bewusst hingenommen, es wird nur eine finanzielle Rücklage gebildet. | |

---

## Block 7: Stakeholder & RACI

### 7.1 Stakeholder einordnen (5 Punkte)

Ordnen Sie die Stakeholder in die Einfluss/Interesse-Matrix ein.

**Stakeholder:**
1. Geschäftsführung (hoher Einfluss, hohes Interesse)
2. IT-Abteilung (geringer Einfluss, hohes Interesse)
3. Rechtsabteilung (hoher Einfluss, geringes Interesse)
4. Externer Datenschutzberater (geringer Einfluss, geringes Interesse)

**Matrix:**

| | Geringes Interesse | Hohes Interesse |
|-------------------|------------------|-----------------|
| **Hoher Einfluss** | | |
| **Geringer Einfluss** | | |

---

### 7.2 RACI-Matrix (5 Punkte)

Vervollständigen Sie die RACI-Matrix. Achten Sie darauf, dass pro Aufgabe **genau ein A** eingetragen ist.

| Aufgabe | Projektleiter | Entwickler | Kunde | Qualitätssicherung |
|---------|--------------|------------|-------|-------------------|
| Anforderungsanalyse | A | C | | I |
| Entwicklung der Software | | | I | |
| Testing | | C | I | |
| Abnahme | C | I | | I |

Tragen Sie R, A, C, I so ein, dass die Rollen realistisch verteilt sind.

---

## Block 8: Agile Grundlagen (Scrum)

### 8.1 Kurzfragen zu Scrum (5 Punkte)

1. Was ist ein **Sprint**?

   _________________________________________________________________

2. Was ist der Zweck des **Daily Scrum**?

   _________________________________________________________________

3. Wer ist hauptsächlich verantwortlich für den Inhalt des **Product Backlogs**?

   _________________________________________________________________

4. Was versteht man unter einem **Produktinkrement**?

   _________________________________________________________________

5. Nennen Sie **eine Aufgabe** der **Sprint-Retrospektive**.

   _________________________________________________________________

---

## Platz für eigene Notizen

*(frei für Teilnehmerinnen und Teilnehmer zur Nutzung im Unterricht)*
