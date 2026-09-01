## Aufgabe A: Stakeholder-Analyse und Power-Interest-Matrix

### Aufgabenstellung

Du arbeitest als Projektmanager an einem Software-Migrationsprojekt in einem Mittelstandsunternehmen. Die Migration von Legacy-System zu Cloud-Lösung dauert 18 Monate, betrifft 150 Mitarbeiter und kostet 2,5 Mio. €.

**Aufgabe 1a:**
Identifiziere mindestens 12 verschiedene Stakeholder-Gruppen für dieses Projekt. Nutze die folgende Vorlage:

| Lfd. | Stakeholder-Gruppe | Beschreibung / Rolle | Power (H/M/L) | Interest (H/M/L) | Engagement-Ziel | Kommunikationsformat |
|---|---|---|---|---|---|---|
| 1 | Geschäftsführer | Authorisiert, trägt Verantwortung | **H** | **H** | Aktive Unterstützung | Wöchentliches Executive-Briefing |
| 2 | | | | | | |
| 3 | | | | | | |
| ... | | | | | | |

**Aufgabe 1b:**
Zeichne eine **Power-Interest-Matrix** mit allen 12 Stakeholdern. Nutze ein einfaches Grid:
- X-Achse: Interest (Niedrig → Hoch)
- Y-Achse: Power (Niedrig → Hoch)
- Jeden Stakeholder als einen Punkt/Kreis mit Label eintragen

**Leitfragen:**
- Welche Stakeholder haben hohe Power UND hohes Interest? (Manage Closely)
- Welche könnten zu Blockern werden?
- Wer wird am stärksten betroffen sein?
- Wer hat wenig Interesse, könnte aber kritisch werden?

---

## Aufgabe B: Kommunikationsplan erstellen

### Aufgabenstellung

Basierend auf Deiner Stakeholder-Analyse aus Aufgabe A erstelle einen **vollständigen Kommunikationsplan** für das Migrationsprojekt.

**Der Plan muss enthalten:**

### B1: Kommunikationsmatrix (Haupttabelle)

Fülle die folgende Tabelle aus:

| Stakeholder-Gruppe | Kommunikationsinhalte | Kanal/Format | Häufigkeit | Verantwortung | Eskalation bei | Zielgruppe-Größe |
|---|---|---|---|---|---|---|
| Geschäftsführung | – Projekt-Status (Rot/Gelb/Grün) <br/> – Top-Risiken <br/> – Finanzielle Abweichungen <br/> – Strategische Blockers | Executive Summary (1-pager, visuell) + ggf. Telefonanruf | Wöchentlich (jeden Montag 8 Uhr) | Projektleiter + Projektassistent | Rote Ampel oder > 100k € Abweichung | 3 Personen |
| IT-Teams | | | | | | |
| Endnutzer / Mitarbeiter | | | | | | |
| Fachbereiche (HR, Finance, etc.) | | | | | | |
| ... | | | | | | |

**Tipp:** Nutze unterschiedliche Kanäle für unterschiedliche Adressaten:
- Executive Level: Kurze, visuelle Updates (1-2 Seiten)
- Team Level: Detaillierte technische Updates, Daily Standup
- Betroffene Mitarbeiter: Newsletter, Trainings-Ankündigungen, FAQ
- Externe: Nur notwendige Informationen, über formale Kanäle

### B2: Kommunikationskalender (Wochenplan)

Erstelle einen wöchentlichen Meeting-Kalender für die nächsten 2 Wochen. Beispiel:

| Wochentag | Uhrzeit | Meeting | Teilnehmer | Moderator | Dauer | Ort/Medium |
|---|---|---|---|---|---|---|
| Montag | 08:00–08:15 | Daily Standup | Team (5–8 Pers.) | Tech Lead | 15 Min | MS Teams |
| Montag | 09:00–10:00 | Steering Committee | Geschäftsführung, Projektleiter, Lenkungsrat | Projektleiter | 60 Min | Präsenz Konferenzraum |
| Dienstag | 10:00–11:00 | Arbeitsgruppe: DB-Migration | Datenbank-Team + Architekten | DBA-Lead | 60 Min | MS Teams |
| Mittwoch | 14:00–14:15 | Daily Standup | (wie oben) | Tech Lead | 15 Min | MS Teams |
| ... | ... | ... | ... | ... | ... | ... |

**Hinweis:** Vermeide Meeting-Kollisionen, plane Puffer zwischen wichtigen Besprechungen.

### B3: Meeting-Agenden-Templates

Erstelle 2 beispielhafte Agenden:

**Template 1: Daily Standup (15 Min)**
```
AGENDA – Daily Standup | Migration Project
Datum: [TT.MM.JJJJ] | Uhrzeit: 08:00–08:15
Moderator: Tech Lead

1. Reihum 2 Min pro Person:
   - Was habe ich gestern fertig gemacht?
   - Was mache ich heute?
   - Welche Blocker habe ich?

2. Blocker-Diskussion (max. 5 Min) – wenn nötig, Follow-Up-Meeting vereinbaren
3. Ankündigung für heute (z. B. geplante Ausfallzeiten)

Nächster Termin: [Morgen gleiche Zeit]
```

**Template 2: Wöchentliches Steering-Meeting (60 Min)**
```
AGENDA – Steering Committee | Migration Project
Datum: [TT.MM.JJJJ] | Uhrzeit: 09:00–10:00
Teilnehmer: [Namen] | Moderator: Projektleiter | Ort: [Raum/Teams]

1. Status-Ampel & Executive Summary (10 Min)
   – Grün/Gelb/Rot – warum?
   – Abweichungen Scope/Zeit/Kosten/Qualität
   
2. Meilenstein-Erreichte (5 Min)
   – Was wurde seit letztem Meeting abgeschlossen?

3. Risiken & Chancen (10 Min)
   – Neue Risiken?
   – Top 3 Risiken und deren Mitigations-Status
   – Chancen für Optimierung?

4. Offene Probleme & Eskalationen (15 Min)
   – Blockers aus täglichen Standups
   – Entscheidungen erforderlich?
   – Ressourcen-Probleme?

5. Nächste Schritte & Ausblick (15 Min)
   – Was kommt nächste Woche?
   – Abhängigkeiten?
   – Alle erreichbar/verfügbar?

6. Aufgaben & Action Items (5 Min)
   – Owner + Deadline für jede Aktion

Entscheidungen/Protokoll wird per E-Mail verteilt bis 17:00 Uhr.
```

### B4: Dokumentation und YOUTRACK-Integration

**Frage:** Wie wollen Sie die Kommunikationspläne und Meeting-Notizen in **YOUTRACK** abbilden?

Vorschlag-Struktur (fülle aus):

```
Epic: "Communications & Stakeholder Management"
├─ Issue 1: "Create Stakeholder Register" (Owner: ..., Deadline: ...)
├─ Issue 2: "Finalize Communications Plan" (Owner: ..., Deadline: ...)
├─ Issue 3: "Set up Meeting Templates in Teams" (Owner: ..., Deadline: ...)
├─ Recurring Task: "Weekly Status Report" (Owner: ..., Every Friday 16:00)
└─ Recurring Task: "Executive Summary for Steering" (Owner: ..., Every Monday 08:00)
```

---

## Aufgabe C: Effektives Meeting planen

### Aufgabenstellung

Dein Team hat folgendes Problem: Meetings dauern oft zu lange, Teilnehmer verlassen vorzeitig den Raum, und am Ende ist keine klare Entscheidung getroffen worden.

**Aufgabe C1: Meeting-Analyse**

Schaue dir folgende schlecht durchgeführte Meeting-Szene an (oder stelle sie dir vor):

**Szenario:**
- Meeting: „Anforderungs-Review für neue Datenbankstruktur"
- Geplante Dauer: 60 Min
- Tatsächliche Dauer: 120 Min (weit überschritten)
- Teilnehmer (12 Personen): Projektmanager, Datenbankadmin, Entwickler (3), Testmanager, Geschäftsanalyst, zwei Stakeholder aus Fachbereichen, IT-Leiter, zwei User-Vertreter
- Problem: Diskussionen schweiften ab, alle reden durcheinander, keine Moderation
- Ergebnis: Keine Decisions getroffen, Folgemeetings wurden gebucht

**Aufgaben:**
a) Identifiziere **5 konkrete Fehler** in diesem Meeting
b) Erkläre zu jedem Fehler, welche negativen Folgen entstanden
c) Gib eine konkrete Lösung an

**Beispiel:**
| Fehler | Negative Folge | Lösung |
|---|---|---|
| **1. Zu viele Teilnehmer (12 statt optimal 5–7)** | Viele Stimmen, schwer zu moderieren, Dominante Sprachreicher sprechen mehr | Kernteam (5–7 Pers.) laden: PL, DB-Admin, 1–2 Dev, Tester, 1 Stakeholder. Fachbereich-Vertreter nur zu bestimmten Teilen oder zu Einzelmeeting |
| **2.** | | |
| ... | ... | ... |

### Aufgabe C2: Meeting-Plan für ein kritisches Projekt-Meeting

Du sollst ein wichtiges Meeting für Dein Migrationsprojekt planen: **„Risiko-Assessment: Datenmigration"**

**Aufgabe: Schreibe einen detaillierten Meeting-Plan aus:**

```
MEETING-PLAN
=============

📅 Termin: [Wann? Begründung für Zeit-Wahl]
⏱️  Dauer: [Wie lange? Warum diese Dauer?]
🎯 Ziel: [Was soll am Ende erreicht sein? (max. 3 Bullet-Points)]

TEILNEHMER-LISTE:
─────────────────
Name | Rolle | Grund der Teilnahme | Position im Meeting
[...] | [...] | [...] | [...]
(BEGRÜNDUNG: Warum diese Personen und nicht mehr/weniger?)

AGENDA MIT ZEITEN:
──────────────────
1. [00:00–00:05] Opening & Zielabstimmung
   – Wer spricht? Kurze Recap des Ziels
   – Agenda bestätigen, offene Fragen?

2. [00:05–00:25] Ist-Situation Datenmigration
   – Wer spricht? DBA
   – Was? Status, kritische Punkte
   – Wie lang? Präsentation 15 Min + 5 Min Verständnisfragen

3. [00:25–00:40] Identifizierte Risiken (Brainstorming)
   – Moderation: Projektleiter
   – Frage an alle: "Welche Risiken seht ihr?"
   – Dokumentation auf Whiteboard / in YOUTRACK live

4. [00:40–00:50] Priorisierung & Maßnahmen
   – Die Top 5 Risiken: Für jedes – wer übernimmt Owner-schaft?
   – Wer mitigation-action definieren?

5. [00:50–00:55] Decisions & Nächste Schritte
   – Was wird aus diesem Meeting entschieden?
   – Wer hat bis wann welche Aufgabe?

6. [00:55–01:00] Closing
   – Protokoll wird versendet bis 17:00 Uhr
   – Nächster Termin zum Follow-Up?

VORBEREITUNG (1 Woche vorher):
──────────────────────────────
- [ ] Einladung mit Agenda versenden
- [ ] Vorinformationen mitteilen (z. B. Schnittstelle zum letzten Meeting)
- [ ] Raum / Video-Meeting-Link buchen
- [ ] Moderations-Material vorbereiten (Whiteboard, Beamer, etc.)
- [ ] Teilnehmern sagen, was sie vorbereiten/mitbringen sollen

NACHBEREITUNG (< 24 Std. nach Meeting):
─────────────────────────────────────────
- [ ] Protokoll schreiben mit:
  - [ ] Decisions & Beschlüsse
  - [ ] Alle genannten Risiken dokumentieren
  - [ ] Action Items mit Owner + Deadline
- [ ] Protokoll an alle verteilen
- [ ] Tasks in YOUTRACK anlegen
```

---

## Aufgabe D: Statusbericht schreiben

### Aufgabenstellung

Es ist **Freitag, 13. Uhr** – Dein Statusbericht ist fällig. Dein Migrationsprojekt steht in Woche 8 von 72 Wochen.

**Aktueller Stand:**

| KPI | Plan | Ist | Abweichung |
|---|---|---|---|
| **Scope** | 100% Requirements erhoben | 85% Requirements erhoben | -15% |
| **Zeit** | Woche 8, Meilenstein 1 done | Woche 8, aber MS1 wird 1 Woche verspätet | -1 Woche |
| **Kosten** | 350.000 € budgetiert (Weeks 1–8) | 380.000 € ausgegeben | +30.000 € (+8,6%) |
| **Team-Kapazität** | 15 Personen geplant | 14 Personen (1 x krank, noch nicht ersetzt) | -1 FTE |
| **Qualität** | Anforderungs-Verständnis dokumentiert | 70% dokumentiert, noch 30% unklar | -30% |
| **Risiken** | 0 Risiken eskaliert | 2 Risiken wurden zu Problemen | +2 Escal. |

**Zu behebende Probleme:**
- Requirements-Meetings dauern länger als geplant (Stakeholder betonen ihre speziellen Bedarfe)
- Ein Entwickler ist krankheitsbedingt ausgefallen; kein Replacement verfügbar
- Kostenüberschuss durch Overheads und ungeplante IT-Infrastruktur-Kosten
- Datenschutz-Bedenken sind neu hinzugekommen (datenschutzbeauftragter wartet noch auf Info)

### Aufgabe D1: Executive Summary (für Sponsor)

Schreibe eine **1-seitige Executive Summary** in diesem Format:

```
═══════════════════════════════════════════════════════════════
                  PROJECT STATUS REPORT
           Software Migration | KW XX | Status: [ROT/GELB/GRÜN]
═══════════════════════════════════════════════════════════════

📊 PROJEKT-GESAMT-STATUS: 🟡 GELB (Abweichungen, aber managebar)

TOP 3 ABWEICHUNGEN:
───────────────────
1. ⏰ Zeitverzug von 1 Woche
   – Grund: Requirements-Phase dauert länger (Stakeholder-Alignment schwierig)
   – Auswirkung: Meilenstein 1 wird eine Woche verspätet (akzeptabel im Puffer)
   – Maßnahme: Requirements-Workshops verdichtet nächste Woche

2. 💰 Kostenüberschuss +30 k€ (8,6%)
   – Grund: Ungeplante IT-Infrastruktur-Investments + Overheads
   – Auswirkung: Budget-Varranz nach 8 Wochen bereits +8,6%
   – Maßnahme: Finance-Review geplant; ggf. Umbudgetierung erforderlich

3. 👥 Ressourcen-Engpass (1 FTE krank)
   – Grund: Entwickler langfristig krank (prognose: 4 Wochen)
   – Auswirkung: Development-Kapazität -7% → wird schlecht Puffer aufzehren
   – Maßnahme: Contractor-Anfrage wird eingeleitet

TOP 3 RISIKEN (mit Trend):
──────────────────────────
🔴 Risk 1: Datenschutz-Compliance nicht geklärt
   – Neue Erkenntnis aus dieser Woche
   – Wahrscheinlichkeit: Hoch | Auswirkung: Sehr Hoch (könnte Projekt blockieren)
   – Maßnahme: Datenschutzbeauftragter kommt Montag zur Kick-Off-Besprechung

🟡 Risk 2: Scope Creep – Stakeholder wünschen mehr Features
   – Trend: Steigende Anforderungen (war erwartet)
   – Wahrscheinlichkeit: Hoch | Auswirkung: Mittel (Zeit/Kosten)
   – Maßnahme: Strenge Change-Control; Requirements-Freeze bis KW 12

🟢 Risk 3: Technische Integrations-Komplexität
   – Trend: Risiko gesunken durch frühe Spikes durchgeführt
   – Status: Unter Kontrolle

ERFORDERLICHE DECISIONS / ESKALATIONEN:
──────────────────────────────────────
❓ Decision 1: Sollen wir Contractor für fehlende FTE einstellen? (Kosten +15k€)
   → Antwort erbeten bis Montag

❓ Decision 2: Requirement-Freeze bei aktuellen 85% oder 100% fordern?
   → Risiko vs. Zeitplan-Einhaltung
   
NÄCHSTE MEILENSTEINE / OUTLOOK:
────────────────────────────────
✅ KW 9: Datenschutz-Clearance
✅ KW 10–11: Requirements-Finalization & Freeze
✅ KW 12: Design Phase Kickoff (falls Requirements fertig)

KONTAKT / RÜCKFRAGEN:
─────────────────────
Projektmanager: [Name], [E-Mail], [Tel.]
Aktualisiert: [TT.MM.JJJJ hh:mm]

```

### Aufgabe D2: Detaillierter Statusbericht (für Projektleiter-Team)

Schreibe einen **5–7seitigen detaillierten Report** mit folgenden Kapiteln:

1. **Zusammenfassung** (1/2 Seite)
   – Kurze Recap des Status, wie oben, aber etwas ausführlicher

2. **Scope-Status** (1 Seite)
   – Welche Anforderungen sind geklärt, welche offen?
   – Scope-Änderungen diese Woche?
   – Tabelle: Top 10 Anforderungen, Status (Approved/Draft/Open)

3. **Zeit-Status** (1 Seite)
   – Gantt-Diagramm Ausschnitt (oder Text-Beschreibung)
   – Termine vs. Plan
   – Kritischer Pfad: wo sind Engpässe?

4. **Kosten-Status** (1 Seite)
   – Spent to Date vs. Budget
   – Kostenvarianzen pro Team/Bereich
   – Prognose für Projektende (Hochrechnung)

5. **Ressourcen** (1/2 Seite)
   – Kapazitätsauslastung
   – Engpässe / Probleme
   – Turnover, Urlaubstage etc.

6. **Qualität & Risiken** (1 Seite)
   – Fehler/Defects-Trend
   – Top 5 Risiken mit Maßnahmen
   – Neue Risiken identifiziert?

7. **Anhang** (1 Seite)
   – Offene Tickets in YOUTRACK (Anzahl, Prioritäten)
   – Meeting-Termine nächste Woche

---

## Aufgabe E: Kommunikationsprobleme analysieren und lösen

### Aufgabenstellung

Im Projekt entstehen regelmäßig Probleme durch schlechte Kommunikation. Hier sind drei **realistische Fallstudien**:

### Fallstudie 1: „Der vergessene Stakeholder"

**Situation:**
Die Geschäftsleitung möchte eine neue Finanz-Software einführen (Projekt: 6 Monate, 1,5 Mio. €). Der Projektplan ist erstellt, die IT wurde informiert, die Business-Unit-Leiter kennen das Ziel. Aber: die **Datenschutzbeauftragte** wurde nie gezielt informiert. Sie erfährt in KW 4 zufällig vom Projekt und hat sofort Bedenken – die Software erfasst Gehaltsdaten, was Datenschutz-relevant ist. Sie fordert Compliance-Prüfung an, was das Projekt um 4 Wochen verzögert.

**Aufgaben:**
a) Was war der Fehler in der Kommunikations-Planung?
b) Welcher Stakeholder-Kategorie hätte die Datenschutzbeauftragte zugeordnet werden sollen?
c) Wie hätte das verhindert werden können?
d) Schreibe eine Gelesenheits-Checkliste mit **5 Fragen**, die bei der Stakeholder-Identifikation helfen, solche Fehler zu vermeiden

**Lösung (Beispiel-Format):**
```
ANALYSE – Fallstudie 1
─────────────────────

a) Der Fehler:
   → Unvollständige Stakeholder-Identifikation
   → Keine strukturierte Analyse von Compliance/Regulatory-Funktionen
   → Datenschutz als "nice-to-have" statt "must-have" behandelt

b) Stakeholder-Kategorisierung:
   → Power: HOCH (kann Projekt blockieren)
   → Interest: HOCH (Datenschutz ist direkter Handlungsbereich)
   → Quadrant: "Manage Closely" → hätte im Kickoff dabei sein sollen

c) Prävention:
   – Stakeholder-Workshop in Woche 1 mit Geschäftsleitung + IT + Compliance
   – Checkliste: "Welche Regulatory/Compliance-Funktionen gibt es?"
   – Kommunikationsplan hätte Datenschutzbeauftragte als separate Zeile gehabt

d) Gelesenheits-Checkliste:
   ☐ Frage 1: Welche Funktionen/Abteilungen werden DIREKT beeinflusst?
   ☐ Frage 2: Welche Funktionen/Abteilungen müssen ZUSTIMMEN (Legal, Compliance, Sicherheit)?
   ☐ Frage 3: Wer FINANZIERT das Projekt oder muss Budgets freigeben?
   ☐ Frage 4: Wer könnte das Projekt BLOCKIEREN (Unions, Betriebsrat, etc.)?
   ☐ Frage 5: Wer muss TRAINIERT oder UNTERSTÜTZT werden (Support, Help Desk)?
```

---

### Fallstudie 2: „Zu viele E-Mails, keine Klarheit"

**Situation:**
Ein globales IT-Infrastruktur-Projekt läuft über 3 Zeitzonen (Europa, USA, Asien). Der Projektmanager und sein Team versenden täglich 50–100 E-Mails mit Statusupdates, Fragen, Diskussionen. 
- Einige E-Mails werden übersehen
- Wichtige Decisions gehen in der E-Mail-Flut unter
- Meetings sind kaum möglich wegen Zeitzonen
- Ein kritisches Risiko wird übersehen und wird zu einem Problem

**Aufgaben:**
a) Identifiziere **3 Kommunikations-Probleme** in dieser Situation
b) Schlage **3 konkrete Lösungen** vor (z. B. Tools, Prozesse, Meeting-Rhythmen)
c) Schreibe einen **Mini-Kommunikationsplan** (1 Seite) für ein globales Projekt:
   – Wer kommuniziert mit wem, wann, wie?
   – Wie werden Decisions dokumentiert?
   – Wo ist die "Single Source of Truth"?

---

### Fallstudie 3: „Die unzufriedene User-Community"

**Situation:**
Ein CRM-System wird eingeführt. Die Projektleitung arbeitet eng mit IT und Geschäftsbereiche-Leadern zusammen. Aber die **End-User** (ca. 200 Sales- und Support-Mitarbeiter) sind nicht regelmäßig informiert. Sie erfahren erst 2 Wochen vor Go-Live, dass sich ihre Arbeitsweise ändert. 
- Change-Resistance wächst
- Trainings sind kurzfristig geplant
- Go-Live wird fraglich, weil User nicht vorbereitet sind
- Projektmanager bekommt massive Beschwerden

**Aufgaben:**
a) Wo war die Kommunikation unzureichend?
b) Schreibe einen **Kommunikationsplan für End-User** (ab Projektstart bis 1 Monat nach Go-Live):
   – Wann informieren (Meilensteine)?
   – Was kommunizieren?
   – Welche Kanäle?
   – Wie Build-Up der Unterstützung (Trainer, Champions)?

---

## Aufgabe F: Zusammenfassung und Checklisten

### Aufgabenstellung

Erstelle zwei praktische Checklisten für Deinen Berufsalltag:

### F1: Kommunikationsplan-Checkliste

Nutze diese Vorlage und ergänze Sie:

```
CHECKLISTE: Kommunikationsplan erstellen
═════════════════════════════════════════

□ FASE 1: STAKEHOLDER-ANALYSE (Woche 1)
  ☐ Alle Stakeholder identifiziert? (mind. 10-Gruppen)
  ☐ Power-Interest-Matrix erstellt?
  ☐ Engagement-Strategie für jeden Quadranten definiert?
  ☐ Vorlage in Projekt-Wiki hochgeladen?

□ FASE 2: KANÄLE & FORMATE DEFINIEREN (Woche 1-2)
  ☐ Welche Kanäle nutzen wir? (E-Mail, Teams, Meetings, Dashboard, etc.)
  ☐ Wer darf auf welchen Kanal Inhalte posten?
  ☐ Eskalations-Kanäle definiert? (z. B. Problem → Projektleiter → Sponsor)
  ☐ Technische Voraussetzungen? (z. B. Dashboard-Zugang für alle)

□ FASE 3: MEETING-STRUKTUR PLANEN (Woche 2)
  ☐ Daily Standup? (Uhrzeit, Teilnehmer, Moderator)
  ☐ Wöchentliche Meetings? (z. B. Team, Steering, Working Groups)
  ☐ Spezial-Meetings? (z. B. Workshops, Kick-Off, Retro)
  ☐ Zeitmanagement: keine Überschneidungen?
  ☐ Meeting-Agenden als Template im Wiki hinterlegt?

□ FASE 4: REPORTING AUFBAUEN (Woche 2-3)
  ☐ Welche KPIs reportieren wir?
  ☐ Wie oft? (täglich, wöchentlich, monatlich)
  ☐ Wer schreibt die Reports?
  ☐ Wer genehmigt / verteilt?
  ☐ Template erstellt und geteilt?
  ☐ YOUTRACK integriert für Automation?

□ FASE 5: DOKUMENTATION & ARCHIVIERUNG (Woche 3)
  ☐ Zentraler Projektbereich-Wiki / Sharepoint erstellt?
  ☐ Namenskonvention definiert? (z. B. YYY-MM-DD_Dokument-Name)
  ☐ Versionskontrolle etabliert?
  ☐ Access-Regeln festgelegt? (Wer darf lesen / schreiben / genehmigen?)
  ☐ Rückspeicherungs-Richtlinie? (Wie lange werden Dokumente aufbewahrt?)

□ FASE 6: KOMMUNIKATIONSPLAN VERABSCHIEDEN (KW 4)
  ☐ Plan mit Projektteam abgestimmt?
  ☐ Plan mit Sponsor abgestimmt?
  ☐ Plan in Kickoff-Meeting präsentiert?
  ☐ Alle haben den Link zum Plan?
  ☐ Update-Rhythmus für Plan selbst definiert? (z. B. monatlich überprüfen)

NOTIZEN / OFFENE PUNKTE:
───────────────────────
_________________________________
_________________________________
_________________________________
```

### F2: Meeting-Moderations-Checkliste

```
CHECKLISTE: Meeting professionell durchführen
═════════════════════════════════════════════

VOR DEM MEETING (ca. 1 Woche):
┌─────────────────────────────┐
│ □ Ziel klar formuliert?     │
│   (Max. 3 Bullet-Points)    │
│                             │
│ □ Richtige Teilnehmer?      │
│   (5–9 Personen optimal)    │
│                             │
│ □ Agenda erstellt & verteilt│
│   (mindestens 3 Tage vorher)│
│                             │
│ □ Vorinformationen mitgegeben│
│   (Papers, Reports, etc.)   │
│                             │
│ □ Ort/Link reserviert       │
│ □ Technik getestet (Beamer, │
│   Kamera, Mikro)            │
│ □ Materialien vorbereitet   │
│   (Whiteboard, Flip-Chart)  │
└─────────────────────────────┘

WÄHREND DES MEETINGS (max. +5 Min Verspätung):
┌──────────────────────────────┐
│ □ Pünktlich starten (mit   │
│   10% der Teilnehmer)      │
│                            │
│ □ Moderation klar:         │
│   "Das ist die Agenda..."  │
│                            │
│ □ Klarheit:                │
│   "Was machen wir hier?"   │
│                            │
│ □ Fokus halten: Abschweifer│
│   gently stoppen ("Off-Topic│
│   = Parking Lot")          │
│                            │
│ □ Alle einbeziehen         │
│   (nicht nur Lautsprecher) │
│                            │
│ □ Decisions dokumentieren  │
│   (live auf Whiteboard)    │
│                            │
│ □ Aktionen mit Owner/Deadline│
│                            │
│ □ Pünktlich enden          │
└──────────────────────────────┘

NACH DEM MEETING (< 24 Std):
┌──────────────────────────┐
│ □ Protokoll geschrieben  │
│                          │
│ □ Decisions nochmal      │
│   überprüft (waren alle  │
│   verstanden?)           │
│                          │
│ □ Action Items mit       │
│   Owner, Deadline in     │
│   YOUTRACK eingegeben    │
│                          │
│ □ Protokoll an alle      │
│   versendet              │
│                          │
│ □ Reminder für nächstes  │
│   Meeting eingestellt    │
│   (falls regelmäßig)     │
│                          │
│ □ Follow-Up-Kontrolle    │
│   für Action Items geplant│
│   (Wann checkst du nach? )│
└──────────────────────────┘

TYPISCHE FEHLER VERMEIDEN:
──────────────────────────
❌ Zu viele Teilnehmer   → Immer nur Core-Team + benötigte Stakeholder
❌ Zu lange Dauer        → Max. 60 Min, dann Pause oder nächst Termin
❌ Keine Moderation      → Immer einen Moderator benennen
❌ Keine Protokollierung → Live-Dokumentation (Whiteboard + Foto)
❌ Offene Diskussionen   → Decisions brauchen klar definierten Weg
❌ Keine Follow-Ups      → Wer überprüft, ob Aktionen erledigt sind?
```

---

## Persönliche Notizen & Reflexion

Nutze diese Fläche für Deine Gedanken, Fragen und Erkenntnisse:

### Was habe ich verstanden?

_____________________________________________________________________________

_____________________________________________________________________________

### Was ist noch unklar?

_____________________________________________________________________________

_____________________________________________________________________________

### Wie kann ich das in meinem aktuellen Projekt anwenden?

_____________________________________________________________________________

_____________________________________________________________________________

### Welche 3 Maßnahmen nehme ich bis nächste Woche mit?

1. _________________________________________________________________________

2. _________________________________________________________________________

3. _________________________________________________________________________
