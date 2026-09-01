## 1. Ziel des Moduls

Dieses Modul fasst die **für die AP1 der Fachinformatiker besonders relevanten Projektmanagement-Themen** kompakt zusammen und bietet dazu **prüfungsnahe Übungsaufgaben mit Lösungen**.

Alle Hinweise auf konkrete Softwarewerkzeuge wurden bewusst weggelassen – der Fokus liegt auf den **Konzepten, Begriffen und Rechenverfahren**, wie sie typischerweise in der IHK-Prüfung abgefragt werden.

---

## 2. Themenüberblick (was in der AP1 typischerweise drankommt)

1. **Projektgrundlagen**
   - Merkmale eines Projekts
   - Abgrenzung zu Routineaufgaben
2. **Vorgehensmodelle**
   - Wasserfallmodell (klassisch)
   - Scrum (agil)
   - Vergleich klassisch vs. agil
3. **Zielformulierung**
   - SMART-Prinzip
4. **Projektplanung**
   - Projektstrukturplan (PSP / WBS)
   - Netzplantechnik (FAZ, FEZ, SAZ, SEZ, Puffer, kritischer Pfad)
   - Gantt-Diagramm (Balkenplan)
5. **Anforderungsmanagement**
   - Lastenheft vs. Pflichtenheft
6. **Stakeholder & Verantwortung**
   - Stakeholder-Analyse (Einfluss/Interesse)
   - RACI-Matrix
7. **Risikomanagement**
   - Risikoidentifikation
   - Risikobewertung (Risikowert, Risikomatrix)
   - Risiko-Reaktionsstrategien (Vermeiden, Mindern, Übertragen, Akzeptieren)
8. **Qualitätsmanagement (kurz)**
   - Grundidee, Testarten, einfache Metriken
9. **Wirtschaftlichkeit**
   - ROI (Return on Investment)
   - Amortisationszeit
   - einfacher Angebotsvergleich
10. **Projektcontrolling (Grundlagen)**
    - Earned Value Management (PV, EV, AC, CV, SV, CPI, SPI – einfache Aufgaben)

---

## 3. Kompakte Merkkarten zu den Kernthemen

### 3.1 Projekt vs. Routineaufgabe

**Projekt =**
- zeitlich begrenzt (Start/Ende)
- einmalig
- definiertes Ziel
- komplex (mehrere Aufgaben/Beteiligte)
- benötigt Ressourcen (Zeit, Geld, Personal)

**Routineaufgabe =**
- wiederkehrend (täglich, wöchentlich, monatlich)
- gleichartige Abläufe
- keine einmalige Besonderheit

**Typische Prüfungsfrage:** "Ist X ein Projekt oder eine Routineaufgabe? Begründen Sie."

---

### 3.2 SMART-Ziele

**SMART:**
- **S**pezifisch – eindeutig formuliert
- **M**essbar – Kennzahlen, Prozent, Anzahl
- **A**kzeptiert/Attraktiv – von Beteiligten gewollt
- **R**ealistisch – mit Ressourcen erreichbar
- **T**erminiert – klare Frist/Datum

**Beispiel (SMART):**
„Die Ladezeit der Startseite wird bis zum 30.06.2025 von 5 auf unter 2 Sekunden reduziert.“

---

### 3.3 Wasserfallmodell vs. Scrum

**Wasserfallmodell (klassisch):**
- Phasen nacheinander: Analyse → Design → Implementierung → Test → Wartung
- Anforderungen zu Beginn möglichst vollständig
- Änderungen später schwierig und teuer
- Geeignet bei stabilen Anforderungen

**Scrum (agil):**
- Arbeit in kurzen Sprints (1–4 Wochen)
- Rollen: Product Owner, Scrum Master, Entwicklungsteam
- Regelmäßiges Feedback (Review, Retrospektive)
- Änderungen sind eingeplant

**Merksatz:** "Wasserfall = einmal planen, dann abarbeiten. Scrum = in kleinen Schritten planen, bauen, prüfen, anpassen."

---

### 3.4 Projektstrukturplan (PSP)

**Projektstrukturplan (PSP / WBS)**
- Zerlegt das Projekt **hierarchisch** in Teilprojekte und Arbeitspakete
- Ziel: Übersicht, klare Verantwortlichkeiten, Grundlage für Zeit- und Kostenplanung

**Zerlegungsarten:**
- phasenorientiert (Planung, Umsetzung, Test, Abschluss)
- objektorientiert (Server, Clients, Software, Schulung)
- funktionsorientiert (Analyse, Entwicklung, Test, Einführung)

---

### 3.5 Netzplantechnik – Formeln & Begriffe

**Begriffe:**
- Vorgang = Arbeitsschritt mit Dauer
- FAZ = Frühester Anfangszeitpunkt
- FEZ = Frühester Endzeitpunkt
- SAZ = Spätester Anfangszeitpunkt
- SEZ = Spätester Endzeitpunkt
- GP = Gesamtpuffer

**Formeln:**
- FEZ = FAZ + Dauer
- SAZ = SEZ – Dauer
- GP = SAZ – FAZ = SEZ – FEZ

**Regeln:**
- Vorwärtsrechnung: FAZ/FEZ → **Maximum** der Vorgänger-FEZ
- Rückwärtsrechnung: SAZ/SEZ → **Minimum** der Nachfolger-SAZ
- Kritischer Pfad: alle Vorgänge mit **GP = 0**

---

### 3.6 Gantt-Diagramm (Balkenplan)

- Zeitliche Darstellung der Vorgänge als Balken
- X-Achse: Zeit, Y-Achse: Vorgänge
- Gut für Übersicht und Kommunikation
- Abhängigkeiten und Puffer weniger deutlich als im Netzplan

Prüfungsaufgaben: einfacher Balkenplan zeichnen / Vor- und Nachteile nennen.

---

### 3.7 Lastenheft vs. Pflichtenheft

- **Lastenheft** (vom Auftraggeber):
  - "Was" soll erreicht werden?
  - Ziele, Anforderungen, Rahmenbedingungen
- **Pflichtenheft** (vom Auftragnehmer):
  - "Wie" wird es umgesetzt?
  - Technische Umsetzung, detaillierte Spezifikation

Merksatz: **Lasten = Wünsche des Kunden, Pflichten = Lösung des Auftragnehmers.**

---

### 3.8 Stakeholder & RACI

**Stakeholder:** alle, die vom Projekt betroffen sind oder Einfluss haben.

**Einfluss/Interesse-Matrix:**
- Hoher Einfluss + Hohes Interesse → intensiv managen
- Hoher Einfluss + Geringes Interesse → zufrieden halten
- Geringer Einfluss + Hohes Interesse → informiert halten
- Geringer Einfluss + Geringes Interesse → beobachten

**RACI-Matrix:**
- **R**esponsible – führt aus
- **A**ccountable – trägt Gesamtverantwortung (genau eine Person!)
- **C**onsulted – wird konsultiert (Mitspracherecht)
- **I**nformed – wird informiert

---

### 3.9 Risikomanagement

**Risikowert:**
- Risiko = Ereignis + Unsicherheit + mögliche negative Auswirkung
- Risikowert = Eintrittswahrscheinlichkeit × Auswirkung (z.B. Skala 1–5)

**Strategien:**
- Vermeiden – Ursache ausschalten
- Mindern – Eintrittswahrscheinlichkeit/Auswirkung reduzieren
- Übertragen – z.B. Versicherungen, Verträge
- Akzeptieren – bewusst in Kauf nehmen

---

### 3.10 Wirtschaftlichkeit

**ROI (Return on Investment):**
- ROI = (Gewinn / Investition) × 100%

**Amortisationszeit:**
- Amortisationszeit = Investition / jährlicher Nutzen

**Typische Prüfung:**
- Gesamtgewinn ausrechnen
- ROI in % berechnen
- Amortisationszeit bestimmen
- Zwei Angebote wirtschaftlich vergleichen

---

### 3.11 Earned Value Management (Grundbegriffe)

**Begriffe:**
- **PV (Planned Value)** – geplanter Wert (Soll-Kosten zum Stichtag)
- **EV (Earned Value)** – erarbeiteter Wert (Ist-Leistung in Geldeinheiten)
- **AC (Actual Cost)** – Ist-Kosten

**Kennzahlen:**
- Kostenabweichung: CV = EV – AC
- Terminabweichung: SV = EV – PV
- Kostenindex: CPI = EV / AC
- Terminindex: SPI = EV / PV

Interpretation:
- CV > 0 / CPI > 1 → unter Budget
- SV > 0 / SPI > 1 → vor Plan

---

## 4. Prüfungsnahe Aufgaben (kompakte Fassung)

Die Aufgaben wurden leicht gekürzt, der Kern blieb erhalten.

### Block 1: Grundlagen & SMART & Lasten/Pflichten (ca. 15 Punkte)
- Projekt vs. Routineaufgabe (5 kurze Fälle)
- Welche Ziele sind SMART? (5 Beispiele ankreuzen)
- Inhalte Lastenheft vs. Pflichtenheft zuordnen

### Block 2: Vorgehensmodelle (ca. 10–15 Punkte)
- Aussagen Wasserfall vs. Scrum zuordnen
- Scrum-Rollen passenden Aufgaben zuordnen

### Block 3: Netzplan (ca. 20–25 Punkte)
- Tabelle mit Vorgängen, Dauern, Vorgängern
- Netzplan zeichnen (Vorgangsknoten)
- FAZ/FEZ, SAZ/SEZ berechnen
- Puffer berechnen
- kritischen Pfad bestimmen

### Block 4: Gantt (ca. 8–10 Punkte)
- Einfachen Balkenplan aus Vorgangs- und Datentabelle erzeugen
- Einen Vorteil und einen Nachteil nennen

### Block 5: Wirtschaftlichkeit (ca. 12–15 Punkte)
- ROI und Amortisationszeit aus Szenario berechnen
- Zwei Angebote vergleichen und begründet entscheiden

### Block 6: Risiko (ca. 8–10 Punkte)
- Risikowerte berechnen
- Risiko mit höchster Priorität bestimmen
- Maßnahmen Strategien (V, M, Ü, A) zuordnen

### Block 7: Stakeholder & RACI (ca. 8–10 Punkte)
- Stakeholder in Einfluss/Interesse-Matrix eintragen
- RACI-Matrix mit R, A, C, I vervollständigen

### Block 8: Begriffe aus agilen Vorgehensweisen (ca. 5–8 Punkte)
- Kurzfragen zu: Product Owner, Sprint, Daily Scrum, Inkrement

Die **vollständigen Aufgaben und Lösungen** habe ich in zwei separaten, bereits erstellten Dateien kompakt und ohne Tool-Bezug gehalten:
- **M21b_Pruefungsvorbereitung-AP1-Aufgaben.md**
- **M21c_Pruefungsvorbereitung-AP1-Loesungen.md**

---

## 5. Nutzung im Unterricht / Selbststudium

Empfohlene Reihenfolge:
1. Dieses **kompakte Skript (M21a)** einmal komplett durchlesen.
2. **Aufgaben (M21b)** in 90 Minuten wie eine echte Prüfung bearbeiten.
3. Mit den **Lösungen (M21c)** vergleichen und die Kommentare intensiv lesen.
4. Themen mit vielen Fehlern nochmals gezielt wiederholen.

---

## 6. Dateien in der Übersicht

- **M21a_Pruefungsvorbereitung-AP1.md** – kompakte Einführung und Merkkarten (aktuell überarbeitet, ohne Tool-Bezug)
- **M21b_Pruefungsvorbereitung-AP1-Aufgaben.md** – prüfungsnahe Aufgaben (unabhängig von Software)
- **M21c_Pruefungsvorbereitung-AP1-Loesungen.md** – Musterlösungen mit ausführlichen Kommentaren
