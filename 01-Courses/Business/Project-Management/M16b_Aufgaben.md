## Aufgabe 1: Change-Request-Formulierung und Impact-Analyse

### Szenario
Sie sind Projektmanager eines E-Commerce-Systementwicklungsprojekts (Budget: 500.000 €, Laufzeit: 6 Monate). Der Kunde (Onlineshop) fragt im 4. Monat:

> **Kundenwunsch:** „Wir hätten gerne noch eine Integration mit dem Lagerverwaltungssystem (LVS) unseres Lieferanten hinzugefügt. Das LVS sendet Bestandsupdates per API. Kann das noch eingebaut werden?"

### Aufgabenteile

#### A1.1: Change-Request schreiben
Füllen Sie einen **formalen Change-Request** aus. Nutzen Sie folgende Vorlage:

```
╔════════════════════════════════════════════════════════════════╗
║               CHANGE REQUEST FORMULAR                          ║
╠════════════════════════════════════════════════════════════════╣
║ CR-Nummer:              [ Ihre CR-Nummer, z.B. CR-2025-120 ]   ║
║ Änderungstitel:         [ ________________________________ ]   ║
║ Eingangsdatum:          [ ________________________________ ]   ║
║ Initiator:              [ ________________________________ ]   ║
║ Priorität (1–5):        [ ________________________________ ]   ║
╠════════════════════════════════════════════════════════════════╣
║ BESCHREIBUNG DER ÄNDERUNG                                      ║
╠════════════════════════════════════════════════════════════════╣
║ Änderungstyp (Scope/Schedule/Budget/Quality/Risk):             ║
║ [ __________________________________________________________]  ║
║                                                                ║
║ Detaillierte Beschreibung:                                     ║
║ ______________________________________________________________ ║
║ ______________________________________________________________ ║
║ ______________________________________________________________ ║
║                                                                ║
║ Begründung/Geschäftlicher Nutzen:                              ║
║ ______________________________________________________________ ║
║ ______________________________________________________________ ║
╠════════════════════════════════════════════════════════════════╣
║ IMPACT-ANALYSE                                                 ║
╠════════════════════════════════════════════════════════════════╣
║ Scope-Impact (betroffene Module):                              ║
║ ______________________________________________________________ ║
║                                                                ║
║ Schedule-Impact (Tage):      [ _________ ]                     ║
║ Budget-Impact (EUR):         [ _________ ]                     ║
║ Quality-Impact:              [ _________ ]                     ║
║ Risiken:                     [ _________ ]                     ║
╠════════════════════════════════════════════════════════════════╣
║ BEWERTUNG GESAMTAUSWIRKUNG                                     ║
╠════════════════════════════════════════════════════════════════╣
║ Gesamtauswirkung:  [ ] Niedrig  [ ] Mittel  [ ] Hoch [ ] K.    ║
║ Machbarkeit:       [ ] Ja       [ ] Mit Auflagen [ ] Nein      ║
╚════════════════════════════════════════════════════════════════╝
```

**Ihre Aufgabe:**
Füllen Sie den CR aus, basierend auf dem Szenario oben. Machen Sie realistische Schätzungen!

---

#### A1.2: Impact-Analyse durchführen
Erstellen Sie eine detaillierte **Impact-Analyse** für die CR. Durchdenken Sie:

| Aspekt | Ihre Analyse |
|--------|-------------|
| **Scope** | Welche neuen Komponenten sind erforderlich? |
| **Schedule** | Wie lange dauert Entwicklung, Test, Integration? |
| **Budget** | Kosten für Entwicklung, externe APIs, Testing? |
| **Quality** | Welche Testfälle sind neu? |
| **Risk** | Technische Risiken der API-Integration? |

**Hinweis:** Überlegen Sie sich konkrete Zahlen (z.B. 8 Tage Entwicklung, 2.000 € Kosten).

---

### Lösungshinweise

Die CR sollte folgende Elemente enthalten:
- Klare, prägnante Änderungsbeschreibung (nicht zu allgemein)
- Begründung der Geschäftswertigkeit (Warum will der Kunde das?)
- Realistische Impact-Schätzungen (nicht zu optimistisch)
- Machbarkeitsaussage mit Vorbehalten

---

## Aufgabe 2: Change-Control-Board-Simulation

### Szenario
Stellen Sie sich vor, Sie sind das Change Control Board des E-Commerce-Projekts. Sie bekommen 4 CRs eingereicht:

| CR | Typ | Beschreibung | Impact |
|----|-----|-------------|--------|
| **CR-025** | Scope | LVS-Integration | Schedule: +10 Tage; Budget: +5.000 € |
| **CR-026** | Quality | Neuer Sicherheits-Audit erforderlich | Schedule: +3 Tage; Budget: +1.500 € |
| **CR-027** | Scope | SMS-Benachrichtigungen für Kunden | Schedule: +5 Tage; Budget: +3.000 € |
| **CR-028** | UI | Layout-Redesign der Startseite | Schedule: +7 Tage; Budget: +2.500 € |

### Aufgabenteile

#### A2.1: Entscheidungsmatrix ausfüllen
Füllen Sie für jede CR eine **Bewertungsmatrix** aus:

```
╔════════════════════════════════════════════════════════════════════╗
║ CR-025: LVS-Integration – BEWERTUNGSMATRIX                         ║
╠════════════════════════════════════════════════════════════════════╣
║ Kriterium              │ Gewicht │ Bewertung │ Gewichtet           ║
╠════════════════════════╪═════════╪═══════════╪═════════════════════╣
║ Geschäftlicher Nutzen  │  30%    │ [ ]       │ [ ] Punkte          ║
║ Dringlichkeit          │  20%    │ [ ]       │ [ ] Punkte          ║
║ Technische Machbarkeit │  20%    │ [ ]       │ [ ] Punkte          ║
║ Budget-Verfügbarkeit   │  15%    │ [ ]       │ [ ] Punkte          ║
║ Ressourcen-Verf.       │  15%    │ [ ]       │ [ ] Punkte          ║
╠════════════════════════╧═════════╧═══════════╧═════════════════════╣
║ GESAMTPUNKTE:                              [ ] / 100 Punkte        ║
║ ENTSCHEIDUNG: [ ] Genehmigt (≥60)  [ ] Aufgeschoben  [ ] Abgelehnt ║
╚════════════════════════════════════════════════════════════════════╝
```

**Bewertungs-Skala für jedes Kriterium:**
- **10** = Ausgezeichnet / Hoch
- **7** = Gut / Mittel-Hoch
- **5** = Befriedigend / Mittel
- **3** = Schwach / Mittel-Niedrig
- **1** = Sehr schwach / Niedrig

**Annahmen zur Bewertung:**
- Das Budget ist zu 100% aufgebraucht; **keine Budgetreserve vorhanden**
- Das Team ist zu 95% ausgelastet; **geringe Ressourcen-Puffer**
- Der Sponsor möchte das Projekt zum geplanten Termin abschließen
- Geschäftlicher Nutzen: LVS (hoch), SMS (mittel), Redesign (niedrig), Audit (hoch)

#### A2.2: Entscheidungsprotokoll schreiben
Nachdem Sie alle 4 CRs bewertet haben, schreiben Sie ein kurzes **Entscheidungsprotokoll**:

```
╔════════════════════════════════════════════════════════════════╗
║              CHANGE CONTROL BOARD - PROTOKOLL                  ║
╠════════════════════════════════════════════════════════════════╣
║ Datum:                     [ _________________________ ]       ║
║ Teilnehmer:                [ _________________________ ]       ║
║ Projektname:               E-Commerce-System                   ║
║ Projektmanager:            [ Sie ]                             ║
╠════════════════════════════════════════════════════════════════╣
║                    DECISIONS SUMMARY                           ║
╠════════════════════════════════════════════════════════════════╣
║ CR-025: LVS-Integration                                        ║
║   Entscheidung: [ ] Genehmigt [ ] Aufgeschoben [ ] Abgelehnt   ║
║   Begründung: ________________________________________________ ║
║                                                                ║
║ CR-026: Sicherheits-Audit                                      ║
║   Entscheidung: [ ] Genehmigt [ ] Aufgeschoben [ ] Abgelehnt║
║   Begründung: ________________________________________________ ║
║                                                                ║
║ CR-027: SMS-Benachrichtigungen                                 ║
║   Entscheidung: [ ] Genehmigt [ ] Aufgeschoben [ ] Abgelehnt   ║
║   Begründung: ________________________________________________ ║
║                                                                ║
║ CR-028: UI-Redesign                                            ║
║   Entscheidung: [ ] Genehmigt [ ] Aufgeschoben [ ] Abgelehnt   ║
║   Begründung: ________________________________________________ ║
║                                                                ║
║ GESAMTIMPACT der genehmigten CRs:                              ║
║   Schedule-Verschiebung insgesamt:  [ _____ ] Tage             ║
║   Budget-Überlauf insgesamt:        [ _____ ] EUR              ║
║                                                                ║
║ NÄCHSTE SCHRITTE:                                              ║
║ ______________________________________________________________ ║
║ ______________________________________________________________ ║
╚════════════════════════════════════════════════════════════════╝
```

### Lösungshinweise
- **LVS-Integration (CR-025):** Wahrscheinlich hoch prioritär (geschäftlicher Nutzen), aber Budget/Ressourcen sind eng. Aufgeschoben oder verhandelt?
- **Sicherheits-Audit (CR-026):** Compliance-Anforderung → sollte genehmigt werden
- **SMS-Benachrichtigungen (CR-027):** Schöne Funktion, aber weniger kritisch
- **UI-Redesign (CR-028):** Visuell schön, aber wenig geschäftlicher Nutzen in dieser Phase

---

## Aufgabe 3: Scope-Creep-Erkennung und -Management

### Szenario
Ein Webentwicklungsprojekt (Website-Relaunch) startet. Hier ist der Verlauf der Anforderungen über 3 Monate:

**Monat 1 (Planung):**
- Anforderung: „Moderne Responsive Website mit News-Bereich und Kontaktformular"
- Geplanter Umfang: 800 Story-Points
- Geplante Dauer: 12 Wochen

**Monat 2 (in Entwicklung):**
- Woche 5: Kunde: „Kann die News automatisch in unser Social-Media-Profil gepostet werden?"
- Woche 6: Intern erkannt: „Mobile App würde auch Sinn machen" (nicht in der CR, aber diskutiert)
- Woche 7: Kunde: „Können wir einen Live-Chat Chatbot integrieren?"
- Woche 8: Design-Team: „Das Layout braucht noch ein Video-Hero-Element oben"

**Monat 3 (bisher):**
- Kumulierte Story-Points: 1.200 (+50%)
- Bisher abgegebene CRs: 0 (alles wurde „schnell besprochen")
- Team ist überlastet, Qualitätsdefekte steigen

### Aufgabenteile

#### A3.1: Scope-Creep identifizieren
**Aufgabe:** Identifizieren Sie alle Scope-Creep-Symptome in diesem Szenario.

Machen Sie eine Tabelle:

| Symptom | Ursache | Folge |
|---------|--------|-------|
| Beispiel: Social-Media-Posting | Mündliche Anfrage des Kunden, nicht dokumentiert | Unklare Schätzung, Integration mit Social-Media-API vergessen |
| [ ] | [ ] | [ ] |
| [ ] | [ ] | [ ] |
| [ ] | [ ] | [ ] |

#### A3.2: Gegenmaßnahmen entwickeln
**Aufgabe:** Entwickeln Sie für jedes Scope-Creep-Symptom **eine konkrete Maßnahme** zur Vermeidung:

| Symptom | Gegenmaßnahme |
|---------|--------------|
| Mündliche Anfragen ohne Dokumentation | z.B.: „Alle Änderungswünsche müssen formale CRs sein. Mündliche Anfragen werden in CCB-Meetings dokumentiert." |
| [ ] | [ ] |
| [ ] | [ ] |
| [ ] | [ ] |

#### A3.3: Scope-Recovery-Plan
**Aufgabe:** Das Projekt befindet sich bereits in Scope-Creep. Erstellen Sie einen **Scope-Recovery-Plan**:

```
╔════════════════════════════════════════════════════════════════╗
║          SCOPE-RECOVERY-PLAN – WEBSITE-RELAUNCH                ║
╠════════════════════════════════════════════════════════════════╣
║ AKTUELLER STATUS                                               ║
╠════════════════════════════════════════════════════════════════╣
║ Geplanter Umfang:       800 Story-Points                       ║
║ Aktueller Umfang:       1.200 Story-Points (+50%)              ║
║ Überschuss:             [ ________ ] Story-Points              ║
║ Verbleibende Zeit:      4 Wochen (von 12 geplant)              ║
╠════════════════════════════════════════════════════════════════╣
║ RECOVERY-OPTIONEN                                              ║
╠════════════════════════════════════════════════════════════════╣
║ Option 1: Scope reduzieren (MoSCoW-Priorisierung)              ║
║ - Must-Have Features:   [ _________ ] Story-Points             ║
║ - Should-Have Features: [ _________ ] Story-Points             ║
║ - Could-Have Features:  [ _________ ] Story-Points (gestrichen)║
║ - Won't-Have (Phase 2): [ _________ ] Story-Points             ║
║                                                                ║
║ Option 2: Zeitplan verschieben                                 ║
║ - Neue Deadline: [ ___/___/_____ ]                             ║
║ - Verschiebung um: [ _________ ] Wochen                        ║
║                                                                ║
║ Option 3: Team/Budget erhöhen                                  ║
║ - Zusätzliche Developer: [ _________ ]                         ║
║ - Zusätzliches Budget: [ _____ EUR ]                           ║
║                                                                ║
║ EMPFEHLUNG:                                                    ║
║ ______________________________________________________________ ║
║ ______________________________________________________________ ║
╚════════════════════════════════════════════════════════════════╝
```

---

### Lösungshinweise
1. **Scope-Creep-Symptome:** Mündliche Anfragen, fehlende Dokumentation, undiskutierte „Quick Wins", Feature-Diskussionen ohne offizielle CRs
2. **Gegenmaßnahmen:** Formale Change-Control, tägliche Scope-Überprüfung, klare Kommunikation an Stakeholder
3. **Recovery:** Priorisierung, Stakeholder-Gespräche, ggf. Deadline verschieben oder Scope reduzieren

---

## Aufgabe 4: YOUTRACK-Praktikum – Change-Management-Workflow

### Aufgabe
Sie haben Zugriff auf ein YOUTRACK-Projekt (oder ein Test-Projekt). Konfigurieren Sie einen **Change-Request-Workflow** im Tool.

### Schritte

#### A4.1: Custom Fields definieren
Erstellen Sie folgende Custom Fields für Change Requests:

| Field-Name | Typ | Werte/Beschreibung |
|-----------|-----|-------------------|
| CR-Nummer | Text | z.B. CR-2025-001 |
| Impact-Typ | Dropdown | Scope, Schedule, Budget, Quality, Risk, Documentation |
| Impact-Bewertung | Dropdown | Niedrig, Mittel, Hoch, Kritisch |
| Schedule-Impact-Tage | Zahl | Anzahl der Tage Verzögerung |
| Budget-Impact-EUR | Zahl | Zusätzliche Kosten |
| Change-Board-Entscheidung | Dropdown | Genehmigt, Abgelehnt, Aufgeschoben, Neu |

#### A4.2: Workflow-Status definieren
Erstellen Sie folgende Status mit Übergängen:

```
[Neue CR]
    ↓
[In Analyse] (Projektmanager arbeitet)
    ↓
[Zur Entscheidung] (Change-Board bereit)
    ↓
[Genehmigt] → [In Umsetzung] → [Abgeschlossen]
[Abgelehnt] (Endstatus)
[Aufgeschoben] → [Neu] (später neu bewerten)
```

#### A4.3: Workflow-Regeln konfigurieren
Definieren Sie Regeln (z.B. Automations-Rules):

| Bedingung | Aktion |
|-----------|--------|
| Status wird zu „Genehmigt" | Benachrichtige: Projektmanager, Entwickler-Lead |
| Status wird zu „In Umsetzung" | Setze Feld: „Umsetzungs-Startdatum" = heute |
| Feld „Impact-Bewertung" wird zu „Kritisch" | Benachrichtige: Sponsor |

#### A4.4: Dashboard-Abfragen (Queries) erstellen
Erstellen Sie folgende YOUTRACK-Queries zum Filtern/Überblicken von CRs:

1. **Offene CRs (zur Entscheidung):**
   ```
   project = PROJEKT AND type = "Change Request" AND status = "Zur Entscheidung"
   ```

2. **Budget-Impact-Übersicht:**
   ```
   project = PROJEKT AND type = "Change Request" AND status = "Genehmigt"
   ORDER BY "Budget-Impact-EUR" DESC
   ```

3. **Kritische Risiken:**
   ```
   project = PROJEKT AND type = "Change Request" AND "Impact-Bewertung" = "Kritisch"
   ```

### Aufgabe
**Erstellen Sie einen Screenshot oder eine textuelle Beschreibung, wie Sie diese Struktur in YOUTRACK aufbauen würden.**

---

### Lösungshinweise
- Custom Fields müssen vor Workflow-Regeln definiert werden
- Workflow-Status sollten linear sein (keine zirkulären Übergänge, außer bei „Aufgeschoben")
- Automations-Rules sparen Zeit und reduzieren manualen Overhead
- JQL-Queries sollten für regelmäßige Berichte verwendbar sein

---

## Aufgabe 5: Dokumentation und Traceability

### Szenario
Ein Projekt hat folgende Elemente:
- **Anforderung:** REQ-042: „Der Benutzer kann sein Passwort zurücksetzen, indem er auf ‚Passwort vergessen' klickt."
- **Change Request:** CR-2025-089: „Zusätzlich sollte ein SMS-Bestätigungscode versendet werden statt nur E-Mail."
- **WBS-Element:** 3.5 Passwort-Reset-Funktion
- **Aktivität:** GA-3.5.2 SMS-Versand-Integration implementieren
- **Test-Case:** TC-089 „Passwort-Reset mit SMS-Bestätigung testen"

### Aufgabe: Traceability-Matrix erstellen
Erstellen Sie eine **Requirements Traceability Matrix (RTM)**, die diese Elemente verknüpft:

```
╔═════════════════════════════════════════════════════════════════╗
║        TRACEABILITY MATRIX – PASSWORT-RESET-FUNKTION            ║
╠═════════════════════════════════════════════════════════════════╣
║ REQ-ID │ CR-ID   │ WBS-Element │ Aktivität │ Test-Case │ Status ║
╠════════╪═════════╪═════════════╪═══════════╪═══════════╪════════╣
║ REQ-042│ CR-025  │ 3.5         │ GA-3.5.2  │ TC-089    │ ✓      ║
║        │         │             │           │           │        ║
║        │         │             │           │           │        ║
║        │         │             │           │           │        ║
╚════════╧═════════╧═════════════╧═══════════╧═══════════╧════════╝
```

**Zusätzliche Aufgabe:** Dokumentieren Sie, wo diese Verknüpfung in YOUTRACK, Confluence oder Excel zu finden ist. (Textuelle Beschreibung genügt.)

---

### Lösungshinweise
- Traceability ist die **Rückverfolgbarkeit** von der Anforderung bis zur Abnahme
- Jedes Element sollte mit dem Vorgänger und dem Nachfolger verlinkt sein
- Dies ermöglicht es, die Auswirkungen von Änderungen zu verfolgen

---

## Persönliche Notizen und Zusammenfassung

### Meine Key-Learnings aus Modul 16:

**1. Was habe ich gelernt?**
```
___________________________________________________________________
___________________________________________________________________
___________________________________________________________________
```

**2. Welche Fehler möchte ich in meinen Projekten vermeiden?**
```
___________________________________________________________________
___________________________________________________________________
___________________________________________________________________
```

**3. Wie werde ich Scope-Creep in meinem nächsten Projekt vermeiden?**
```
___________________________________________________________________
___________________________________________________________________
___________________________________________________________________
```

**4. Welche YOUTRACK-Features werde ich nutzen?**
```
___________________________________________________________________
___________________________________________________________________
```

---

## Checkliste: Änderungsmanagement – Bin ich bereit?

| Kompetenz | Ja | Teilweise | Nein |
|-----------|----|-----------|----|
| Ich kann einen CR schreiben | [ ] | [ ] | [ ] |
| Ich verstehe Impact-Analyse | [ ] | [ ] | [ ] |
| Ich kann ein CCB-Meeting leiten | [ ] | [ ] | [ ] |
| Ich erkenne Scope-Creep | [ ] | [ ] | [ ] |
| Ich kann Traceability dokumentieren | [ ] | [ ] | [ ] |
| Ich kann YOUTRACK für Change-Mgmt nutzen | [ ] | [ ] | [ ] |
