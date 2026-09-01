## Aufgabe 1: Lösungen – Change-Request und Impact-Analyse

### Aufgabe 1.1: Change-Request-Lösung

```
╔════════════════════════════════════════════════════════════════╗
║               CHANGE REQUEST FORMULAR – LÖSUNG                 ║
╠════════════════════════════════════════════════════════════════╣
║ CR-Nummer:              CR-2025-120                            ║
║ Änderungstitel:         LVS-Integration für Bestands-Updates  ║
║ Eingangsdatum:          2025-11-18                            ║
║ Initiator:              Kunde / Projektmanager                 ║
║ Priorität (1–5):        4 (Hoch)                              ║
╠════════════════════════════════════════════════════════════════╣
║ BESCHREIBUNG DER ÄNDERUNG                                     ║
╠════════════════════════════════════════════════════════════════╣
║ Änderungstyp:           Scope (Umfang)                         ║
║                                                                ║
║ Detaillierte Beschreibung:                                    ║
║ Das E-Commerce-System soll mit dem Lagerverwaltungssystem     ║
║ (LVS) des Lieferanten integriert werden. Das LVS sendet über  ║
║ eine REST-API Bestandsupdates in Echtzeit. Das E-Shop-System ║
║ soll diese empfangen und den Lagerbestand automatisch         ║
║ aktualisieren. Falls Produkte ausverkauft sind, werden diese  ║
║ als „nicht verfügbar" markiert.                              ║
║                                                                ║
║ Betroffene Komponenten:                                       ║
║ - Produkten-Verwaltungsmodul (Bestandsfeld aktualisieren)    ║
║ - API-Integrations-Layer (neue Schnittstelle zu LVS)         ║
║ - Datenbankschema (Sync-Status und Timestamps)               ║
║ - Dashboard für Admin (Sync-Monitoring)                       ║
║                                                                ║
║ Begründung/Geschäftlicher Nutzen:                            ║
║ Der Kunde will manuelle Bestandsupdates vermeiden. Bisher     ║
║ werden Bestände täglich manuell eingegeben, was zu           ║
║ Fehlverkäufen und Retouren führt. Mit Live-Bestandsupdates  ║
║ werden diese Probleme eliminiert und die Kundenzufriedenheit ║
║ erhöht sich. Geschätzter ROI: Reduktion von Retouren um 15 %. ║
╠════════════════════════════════════════════════════════════════╣
║ IMPACT-ANALYSE                                                ║
╠════════════════════════════════════════════════════════════════╣
║ Scope-Impact:                                                  ║
║ - Neue Komponente: „LVS-Adapter" (ca. 5 neue Dateien/Module) ║
║ - Datenbankmigrationen erforderlich                           ║
║ - API-Dokumentation Lieferant benötigt (externe Dependencies) ║
║ - Umfang: ca. 25–30 neue Story-Points                        ║
║                                                                ║
║ Schedule-Impact:        10 Arbeitstage (2 Kalenderwochen)    ║
║ Begründung: Entwicklung (5d), Integration (2d), Testing (3d) ║
║                                                                ║
║ Budget-Impact:          EUR 8.500                             ║
║ Berechnung:                                                    ║
║   - Backend-Entwicklung: 50 h × 85 €/h = 4.250 €            ║
║   - API-Testing: 15 h × 75 €/h = 1.125 €                     ║
║   - Datenbankadmin: 10 h × 95 €/h = 950 €                    ║
║   - Externe API-Dokumentation: 1 Tag = 850 €                 ║
║   - Buffer (10%): 1.325 €                                     ║
║   - SUMME: 8.500 €                                            ║
║                                                                ║
║ Quality-Impact:                                                ║
║ - Neue Test-Cases erforderlich (ca. 8–10):                   ║
║   • Happy Path: LVS sendet Update → Bestand wird aktualisiert ║
║   • Error Handling: LVS API antwortet nicht                   ║
║   • Retry-Logik: Fehlgeschlagene Updates werden wiederholt    ║
║   • Datentyp-Validierung: Nicht-numerische Werte abgelehnt   ║
║   • Timestamp-Konsistenz: Reihenfolge von Updates              ║
║ - Regressions-Testing für bestehende Bestandsverwaltung      ║
║ - Belastungstest: Kann die API 100+ Requests/Minute?         ║
║                                                                ║
║ Risk-Impact:                                                   ║
║ - R1 (Mittel): LVS-API ist nicht dokumentiert/instabil       ║
║   Mitigation: Early Spike mit Lieferant, Test-Account anfragen ║
║ - R2 (Niedrig): Datenbankmigrationen fehlgeschlagen           ║
║   Mitigation: Backup vor Migration, Staging-Test              ║
║ - R3 (Mittel): Performance-Problem bei vielen Sync-Vorgängen  ║
║   Mitigation: Caching, Batch-Processing, Metriken überwachen  ║
╠════════════════════════════════════════════════════════════════╣
║ BEWERTUNG GESAMTAUSWIRKUNG                                    ║
╠════════════════════════════════════════════════════════════════╣
║ Gesamtauswirkung:  [ ✓ ] Hoch (2 Wochen, 8.500 €)           ║
║ Machbarkeit:       [ ✓ ] Ja, aber mit technischen Klärungen  ║
║ Kritikalität:      [ ✓ ] Geschäftlich sinnvoll, aber spät    ║
║                         in Projekt (Monat 4 von 6)             ║
║                                                                ║
║ EMPFEHLUNGEN:                                                 ║
║ - Vor Genehmigung: Klärung mit LVS-Lieferant (API-Stabilität) ║
║ - Sponsor muss Budget + Termin akzeptieren                    ║
║ - Kompensation: Können andere Features der Phase 2 zugeteilt? ║
║ - Zieltermin Freigabe verschiebt sich um 2 Wochen             ║
╚════════════════════════════════════════════════════════════════╝
```

> **Kommentar zu A1.1:**
> 
> Eine gut geschriebene CR sollte:
> - ✓ Konkrete, messbare Angaben enthalten (nicht: „viel Aufwand", sondern: „10 Tage")
> - ✓ Geschäftlichen Nutzen aufzeigen (warum investiert man das Geld?)
> - ✓ Realistische Schätzungen machen (nicht zu optimistisch: 3 Tage für Integration ist unrealistisch)
> - ✓ Risiken benennen (was könnte schiefgehen?)
> - ✓ Den Projektkontext berücksichtigen (Monat 4 von 6 → kritisch!)
> 
> **Häufige Fehler vermeiden:**
> - ❌ Vage Beschreibungen („System-Verbesserung") – Zu allgemein
> - ❌ Unrealistische Schätzungen („macht 2 Tage") – zu optimistisch
> - ❌ Nur die Kosten nennen, ohne Nutzen zu erklären – Entscheidungsgrundlage fehlt
> - ❌ Anforderungen in die CR schreiben, die bereits Scope waren – verschleiert Creep

---

## Aufgabe 2: Lösungen – Change Control Board

### Aufgabe 2.1: Entscheidungsmatrix-Lösungen

#### CR-025: LVS-Integration

```
╔═══════════════════════════════════════════════════════════════╗
║ CR-025: LVS-Integration – BEWERTUNGSMATRIX (LÖSUNG)          ║
╠═══════════════════════════════════════════════════════════════╣
║ Kriterium              │ Gewicht │ Bewertung │ Gewichtet     ║
╠════════════════════════╪═════════╪═══════════╪═══════════════╣
║ Geschäftlicher Nutzen  │  30%    │    10     │   3,0 Pkte  ║
║ Dringlichkeit          │  20%    │     7     │   1,4 Pkte  ║
║ Technische Machbarkeit │  20%    │     7     │   1,4 Pkte  ║
║ Budget-Verfügbarkeit   │  15%    │     1     │   0,15 Pkte ║
║ Ressourcen-Verfügbarkeit│ 15%    │     3     │   0,45 Pkte ║
╠════════════════════════╧═════════╧═══════════╧═══════════════╣
║ GESAMTPUNKTE:                              6,4 / 10 Pkte  ║
║ Normalisiert (bis 100): 6,4 × 10 = 64 Punkte              ║
║ ENTSCHEIDUNG: [ ✓ ] Genehmigt (≥60)  [ ] Aufgeschoben     ║
╚═══════════════════════════════════════════════════════════════╝
```

**Begründung der Bewertung:**
- **Geschäftlicher Nutzen (10):** ROI-sichtbar (Retour-Reduktion), direkte Kundenbenefit
- **Dringlichkeit (7):** Hoch, aber nicht kritisch – könnte auch Phase 2 sein
- **Machbarkeit (7):** Technisch machbar, aber mit Abhängigkeit vom LVS-Lieferanten
- **Budget (1):** PROBLEM! Budget ist aufgebraucht → Müsste neuer Etat oder Kompensation sein
- **Ressourcen (3):** Team zu 95% ausgelastet → schwierig ohne externe Ressourcen

**Gesamtpunkte: 64 → knapp genehmigt, aber kritisch!**

---

#### CR-026: Sicherheits-Audit

```
╔═══════════════════════════════════════════════════════════════╗
║ CR-026: Sicherheits-Audit – BEWERTUNGSMATRIX (LÖSUNG)       ║
╠═══════════════════════════════════════════════════════════════╣
║ Kriterium              │ Gewicht │ Bewertung │ Gewichtet     ║
╠════════════════════════╪═════════╪═══════════╪═══════════════╣
║ Geschäftlicher Nutzen  │  30%    │    10     │   3,0 Pkte  ║
║ Dringlichkeit          │  20%    │    10     │   2,0 Pkte  ║
║ Technische Machbarkeit │  20%    │     7     │   1,4 Pkte  ║
║ Budget-Verfügbarkeit   │  15%    │     5     │   0,75 Pkte ║
║ Ressourcen-Verfügbarkeit│ 15%    │     5     │   0,75 Pkte ║
╠════════════════════════╧═════════╧═══════════╧═══════════════╣
║ GESAMTPUNKTE:                              7,9 / 10 Pkte  ║
║ Normalisiert (bis 100): 7,9 × 10 = 79 Punkte              ║
║ ENTSCHEIDUNG: [ ✓ ] Genehmigt (≥60)  [ ] Aufgeschoben     ║
╚═══════════════════════════════════════════════════════════════╝
```

**Begründung:**
- **Geschäftlicher Nutzen (10):** Compliance-Anforderung (nicht optional!)
- **Dringlichkeit (10):** Sehr dringend – Sicherheits-Audit vor Go-Live essentiell
- **Machbarkeit (7):** Outsourcebar, externe Auditor kann eingebunden werden
- **Budget (5):** 1.500 € ist verkraftbar aus Contingency Reserve
- **Ressourcen (5):** Keine internen Ressourcen nötig, externe Auditor

**Gesamtpunkte: 79 → klare Genehmigung!**

---

#### CR-027: SMS-Benachrichtigungen

```
╔═══════════════════════════════════════════════════════════════╗
║ CR-027: SMS-Benachrichtigungen – BEWERTUNGSMATRIX (LÖSUNG)  ║
╠═══════════════════════════════════════════════════════════════╣
║ Kriterium              │ Gewicht │ Bewertung │ Gewichtet     ║
╠════════════════════════╪═════════╪═══════════╪═══════════════╣
║ Geschäftlicher Nutzen  │  30%    │     5     │   1,5 Pkte  ║
║ Dringlichkeit          │  20%    │     3     │   0,6 Pkte  ║
║ Technische Machbarkeit │  20%    │     7     │   1,4 Pkte  ║
║ Budget-Verfügbarkeit   │  15%    │     1     │   0,15 Pkte ║
║ Ressourcen-Verfügbarkeit│ 15%    │     3     │   0,45 Pkte ║
╠════════════════════════╧═════════╧═══════════╧═══════════════╣
║ GESAMTPUNKTE:                              4,1 / 10 Pkte  ║
║ Normalisiert (bis 100): 4,1 × 10 = 41 Punkte              ║
║ ENTSCHEIDUNG: [ ] Genehmigt  [ ✓ ] Aufgeschoben  [ ] Abgelehnt║
╚═══════════════════════════════════════════════════════════════╝
```

**Begründung:**
- **Geschäftlicher Nutzen (5):** Nett zu haben, aber nicht essentiell – Email reicht aus
- **Dringlichkeit (3):** Niedrig – Feature kann nach Go-Live nachgelagert werden
- **Machbarkeit (7):** Technisch einfach (3rd-Party SMS-API)
- **Budget (1):** Keine Mittel vorhanden
- **Ressourcen (3):** Team zu 95% ausgelastet

**Gesamtpunkte: 41 → Aufgeschoben auf Phase 2 oder spätere Version**

---

#### CR-028: UI-Redesign

```
╔═══════════════════════════════════════════════════════════════╗
║ CR-028: UI-Redesign – BEWERTUNGSMATRIX (LÖSUNG)            ║
╠═══════════════════════════════════════════════════════════════╣
║ Kriterium              │ Gewicht │ Bewertung │ Gewichtet     ║
╠════════════════════════╪═════════╪═══════════╪═══════════════╣
║ Geschäftlicher Nutzen  │  30%    │     3     │   0,9 Pkte  ║
║ Dringlichkeit          │  20%    │     1     │   0,2 Pkte  ║
║ Technische Machbarkeit │  20%    │     7     │   1,4 Pkte  ║
║ Budget-Verfügbarkeit   │  15%    │     1     │   0,15 Pkte ║
║ Ressourcen-Verfügbarkeit│ 15%    │     1     │   0,15 Pkte ║
╠════════════════════════╧═════════╧═══════════╧═══════════════╣
║ GESAMTPUNKTE:                              2,8 / 10 Pkte  ║
║ Normalisiert (bis 100): 2,8 × 10 = 28 Punkte              ║
║ ENTSCHEIDUNG: [ ] Genehmigt  [ ] Aufgeschoben  [ ✓ ] Abgelehnt║
╚═══════════════════════════════════════════════════════════════╝
```

**Begründung:**
- **Geschäftlicher Nutzen (3):** Kosmetik, funktional nicht notwendig
- **Dringlichkeit (1):** Sehr niedrig – Go-Live mit bestehendem Design möglich
- **Machbarkeit (7):** Machbar, aber zeitintensiv
- **Budget (1):** Keine Mittel
- **Ressourcen (1):** Team kritisch überlastet

**Gesamtpunkte: 28 → Klare Ablehnung, Verschiebung auf Phase 2 oder Version 1.1**

---

### Aufgabe 2.2: Change Control Board Protokoll – LÖSUNG

```
╔════════════════════════════════════════════════════════════════╗
║              CHANGE CONTROL BOARD - PROTOKOLL                 ║
╠════════════════════════════════════════════════════════════════╣
║ Datum:                     2025-11-21                         ║
║ Teilnehmer:                PM (Vorsitz), Sponsor, Tech-Lead,  ║
║                            QA-Lead, Finanzverantwortlicher    ║
║ Projektname:               E-Commerce-System Relaunch         ║
║ Projektmanager:            [Name PM]                          ║
╠════════════════════════════════════════════════════════════════╣
║                    DECISIONS SUMMARY                          ║
╠════════════════════════════════════════════════════════════════╣
║ CR-025: LVS-Integration                                       ║
║   Score: 64 Punkte                                            ║
║   Entscheidung: [✓] Genehmigt mit Auflagen                   ║
║   Begründung: Hoher geschäftlicher Nutzen (ROI), technisch   ║
║   machbar. ABER: Budget-Problem. Auflage: Sponsor genehmigt  ║
║   zusätzliche EUR 8.500 ODER es wird eine andere CR abgelehnt║
║   oder zeitlich verschoben.                                  ║
║   Entscheidungslogik: Business-Nutzen überwiegt, aber Risiko ║
║   der Überlastung muss gemanagt werden.                      ║
║   Nächste Schritte:                                          ║
║   1. Sponsor-Freigabe für Budget-Erhöhung oder Kompensation  ║
║   2. Early-Spike mit LVS-Lieferant (API-Dokumentation)      ║
║   3. Resource-Planning: Externe Entwickler? Internals?        ║
║   4. Geplantes Start-Datum: 2025-12-01                        ║
║                                                                ║
║ CR-026: Sicherheits-Audit                                    ║
║   Score: 79 Punkte                                            ║
║   Entscheidung: [✓] Genehmigt (klare Freigabe)              ║
║   Begründung: Compliance-Anforderung, essentiell vor Go-Live.║
║   Kein Portfolio-Konflikt (externe Auditor).                ║
║   Nächste Schritte:                                          ║
║   1. RFQ an externe Security-Auditor aussenden              ║
║   2. Termin vor Phase-Ende (ca. 2025-12-15)                 ║
║   3. Ergebnisse in Freigabe-Kriterien integrieren           ║
║                                                                ║
║ CR-027: SMS-Benachrichtigungen                               ║
║   Score: 41 Punkte                                            ║
║   Entscheidung: [✓] Aufgeschoben auf Phase 2                ║
║   Begründung: Schöne Funktion, aber nicht kritisch. Team ist║
║   überlastet. Email-Notifikationen sind ausreichend.         ║
║   Nächste Schritte:                                          ║
║   1. CR in Backlog-Feature-Liste für v1.1 aufnehmen         ║
║   2. Nach Go-Live neu bewerten (abhängig von Kunde)          ║
║   3. Stakeholder informieren: „geplant für Herbst 2026"      ║
║                                                                ║
║ CR-028: UI-Redesign                                          ║
║   Score: 28 Punkte                                            ║
║   Entscheidung: [✓] Abgelehnt (mit Begründung)              ║
║   Begründung: Kosmetische Verbesserung, funktional nicht    ║
║   notwendig. Team-Kapazität ist kritisch. Go-Live mit        ║
║   bestehendem Layout erfolgt pünktlich.                      ║
║   Alternative: Post-Go-Live Look-and-Feel Refresh als       ║
║   optionales Projekt (2026).                                 ║
║   Nächste Schritte:                                          ║
║   1. Stakeholder-Kommunikation: Warum abgelehnt?            ║
║   2. Screenshot / Mockup für Kunden senden → Feedback       ║
║   3. Backlog-Option für zukünftige Version dokumentieren    ║
║                                                                ║
╠════════════════════════════════════════════════════════════════╣
║ GESAMTIMPACT DER GENEHMIGTEN CRs:                            ║
╠════════════════════════════════════════════════════════════════╣
║                                                                ║
║ Genehmigt:      CR-025 (LVS) + CR-026 (Audit)               ║
║ Aufgeschoben:   CR-027 (SMS)                                 ║
║ Abgelehnt:      CR-028 (Redesign)                            ║
║                                                                ║
║ Schedule-Verschiebung insgesamt:  10 (LVS) + 3 (Audit)      ║
║                                  = 13 Arbeitstage            ║
║                                  ≈ 2,5 Kalenderwochen        ║
║                                                                ║
║ Neuer Projektfertigstellungstermin:                          ║
║   Alt: 2026-01-15                                            ║
║   Neu: 2026-01-31 (+16 Tage)                                 ║
║                                                                ║
║ Budget-Impact insgesamt:  EUR 8.500 (LVS) + EUR 1.500 (Audit)║
║                          = EUR 10.000 zusätzlich             ║
║                                                                ║
║ Budget-Status nach CRs:                                      ║
║   Ursprung:    EUR 500.000                                    ║
║   + Genehmigt: EUR 10.000                                    ║
║   Neu:         EUR 510.000                                   ║
║                                                                ║
║ HINWEIS: Diese Kosten müssen vom Sponsor genehmigt werden!  ║
║                                                                ║
╠════════════════════════════════════════════════════════════════╣
║ NÄCHSTE SCHRITTE & KOMMUNIKATION:                            ║
╠════════════════════════════════════════════════════════════════╣
║                                                                ║
║ 1. KOMMUNIKATION                                             ║
║    - Projektteam (heute): Neuer Termin, neue Prioritäten     ║
║    - Sponsor (heute): Budget-Genehmigung anfragen             ║
║    - Kunde (morgen): CR-Entscheidungen begründet erklären    ║
║    - Stakeholder (Woche): Scope-Update im nächsten Status     ║
║                                                                ║
║ 2. PLANUNG                                                    ║
║    - Gantt-Diagramm anpassen (CR-025, CR-026 einbauen)      ║
║    - WBS aktualisieren (LVS-Integration als neuer Ast)       ║
║    - Ressourcenplan überprüfen (externe Unterstützung?)      ║
║    - Baseline v2.0 erstellen (Dokumentation der Änderungen)  ║
║                                                                ║
║ 3. TRACKING                                                   ║
║    - Alle genehmigten CRs in YOUTRACK mit Status „Genehmigt" ║
║    - Aufgeschobene/Abgelehnte CRs mit Begründung labeln      ║
║    - Change-Log aktualisieren                                ║
║    - Stakeholder-Meetings zur Umsetzungs-Planung             ║
║                                                                ║
║ 4. NÄCHSTES CCB-MEETING                                      ║
║    Datum: 2025-11-28 (eine Woche später)                    ║
║    Agenda:                                                    ║
║    - Sponsor-Freigabe Status                                 ║
║    - LVS-Lieferant Spike-Ergebnisse                         ║
║    - Neue CRs (falls eingegangen)                            ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
```

> **Kommentar zu Aufgabe 2:**
> 
> Ein effektives CCB-Meeting berücksichtigt:
> 1. **Quantitative Bewertung** (Scoring-Matrix) → Objektivität
> 2. **Qualitative Bewertung** (Business-Nutzen, Strategisches Fit) → Kontext
> 3. **Transparente Entscheidungslogik** → Stakeholder verstehen, warum
> 4. **Verbindliche nächste Schritte** → nicht nur „ja/nein", sondern auch „wer, wann, wie?"
> 
> **Typische Fehler vermeiden:**
> - ❌ Zu permissiv: Alle CRs genehmigen → Scope-Creep (besonders CR-027, CR-028!)
> - ❌ Zu restriktiv: Sogar LVS ablehnen → Customer Dissatisfaction
> - ❌ Keine klaren Ausstiegsszenarien: Was tun, wenn Budget überschritten?
> - ❌ Vage Begründungen: „Das ist zu aufwendig" statt concrete Zahlen

---

## Aufgabe 3: Lösungen – Scope-Creep

### Aufgabe 3.1: Scope-Creep-Symptome identifizieren – LÖSUNG

| Symptom | Ursache | Folge |
|---------|--------|-------|
| **Mündliche Anfrage: Social-Media-Posting** | Kundenwunsch in Call, nicht dokumentiert | Unklare Schätzung, API-Integration vergessen, versteckte Arbeit |
| **Mobile App „wäre auch cool"** | Interne Diskussion ohne Formalisierung | Feature creep, nicht geplant, Team nicht informiert |
| **Live-Chat Chatbot anfrage** | Direkte Kundenfrage in Projektmeeting | Keine Impact-Analyse, Ressourcen nicht geplant |
| **Video-Hero-Element** | Design-Team Eigeninitiative | Nicht mit Anforderungen abgestimmt, Timeline unbekannt |
| **50% Umfangsanstieg (800 → 1.200 SP)** | Alle obigen Items zusammen | Überlastung, versteckte Arbeit, keine Dokumentation, Qualität leidet |
| **Keine CRs eingereicht** | Fehlendes Change-Management | Keine Traceability, unkontrollierter Prozess |

---

### Aufgabe 3.2: Gegenmaßnahmen – LÖSUNG

| Symptom | Gegenmaßnahme |
|---------|--------------|
| Mündliche Anfragen ohne Dokumentation | **Prozess etablieren:** Alle Änderungswünsche müssen formale CRs sein. In Projektmeetings: „Das ist ein interessanter Punkt – bitte als CR einreichen." Keine Ausnahmen. |
| Interne Feature-Diskussionen werden Teil des Scope | **Scope-Review-Meetings:** Wöchentlich 30 Min mit Team: „Welche neuen Anforderungen sind eingegangen?" → schnelle Triage (CR, Backlog, oder Ablehnung) |
| Unklare Schätzungen für Features | **Schätzungs-Standard:** Kein Feature ohne Aufwandsschätzung und Impact-Analyse. Teams müssen überschlagen (z.B. mit Story-Points oder Tage). |
| Fehlende Ressourcen-Planung | **Resource-Gate:** Vor Genehmigung einer CR müssen Ressourcen reserviert sein. „Kapazität nicht verfügbar" ist ein legitimer Ablehnungsgrund. |
| Keine Kommunikation über Entscheidungen | **Stakeholder-Kommunikation:** Nach jedem CCB-Meeting ein Summary versenden: „Diese CRs wurden genehmigt/abgelehnt. Begründung: …" |

---

### Aufgabe 3.3: Scope-Recovery-Plan – LÖSUNG

```
╔═══════════════════════════════════════════════════════════════╗
║          SCOPE-RECOVERY-PLAN – WEBSITE-RELAUNCH              ║
╠═══════════════════════════════════════════════════════════════╣
║ AKTUELLER STATUS                                             ║
╠═══════════════════════════════════════════════════════════════╣
║ Geplanter Umfang:       800 Story-Points                     ║
║ Aktueller Umfang:       1.200 Story-Points (+50%)            ║
║ Überschuss:             400 Story-Points (PROBLEM!)          ║
║ Verbleibende Zeit:      4 Wochen (von 12 geplant)            ║
║ Abgeleis. Zeit:         8 Wochen (67%)                       ║
║ Velocity des Teams:     ca. 50 SP/Woche                      ║
║ Verbleibende Kapazität: 4 Wochen × 50 SP = 200 SP           ║
║ SHORTFALL:              400 SP Umfang - 200 SP Kapazität      ║
║                         = 200 SP Deficit!!!                   ║
╠═══════════════════════════════════════════════════════════════╣
║ URSACHEN-ANALYSE                                             ║
╠═══════════════════════════════════════════════════════════════╣
║ • Social-Media-Integration:           +80 SP                 ║
║ • Mobile App (interne Idee):          +120 SP                ║
║ • Live-Chat Chatbot:                  +100 SP                ║
║ • Video-Hero-Element:                 +60 SP                 ║
║ • Verschiedenes (versteckte Arbeit):   +40 SP                ║
║ GESAMT:                               +400 SP                ║
║                                                                ║
║ ROOT CAUSES:                                                  ║
║ 1. Kein Change-Management → Anfragen nicht dokumentiert      ║
║ 2. Keine regelmäßigen Scope-Reviews → nicht bemerkt         ║
║ 3. Team hat schweigend dran gearbeitet → Hidden Work         ║
║ 4. Keine Kapazitäts-Planung → niemand stoppte das            ║
╠═══════════════════════════════════════════════════════════════╣
║ RECOVERY-OPTIONEN                                            ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║ OPTION 1: SCOPE REDUZIEREN (EMPFOHLEN)                      ║
║ ──────────────────────────────────────────────────────────   ║
║ Using MoSCoW-Priorisierung:                                  ║
║                                                                ║
║ MUST-HAVE Features (kritisch für Go-Live):  500 SP           ║
║  - Basis-Website mit Responsive Design                       ║
║  - News-Bereich                                              ║
║  - Kontaktformular                                           ║
║  - SEO-Grundlagen                                            ║
║  - Performance & Security                                    ║
║                                                                ║
║ SHOULD-HAVE Features (wichtig, aber nicht kritisch): 200 SP ║
║  - Social-Media-Integration (88 SP remaining von 80) → 80 SP ║
║  - Analytics-Dashboard (60 SP)                               ║
║  - Email-Newsletter (30 SP)                                  ║
║  - Backup-Automatisierung (30 SP)                            ║
║                                                                ║
║ COULD-HAVE Features (schön zu haben):      200 SP            ║
║  - Live-Chat Chatbot (100 SP) → STREICHEN                   ║
║  - Mobile App (120 SP) → STREICHEN                           ║
║  - Video-Hero (60 SP) → STREICHEN (oder Std-Hero)          ║
║  - A/B-Testing Framework (80 SP) → STREICHEN                ║
║                                                                ║
║ WON'T-HAVE (für Phase 2, 2026):           200+ SP            ║
║  - Komplexe Video-Streaming                                  ║
║  - E-Commerce-Integration                                    ║
║  - CRM-Anbindung                                             ║
║                                                                ║
║ Geplan nach Recovery:                      700 SP             ║
║ Verfügbare Kapazität:                      200 SP (4 Wochen) ║
║ → IMMER NOCH DEFICIT! → Zeitplan verlängern!                ║
║                                                                ║
║ ─────────────────────────────────────────────────────────── ║
║                                                                ║
║ OPTION 2: ZEITPLAN VERSCHIEBEN (KOMBINATION)                ║
║ ──────────────────────────────────────────────────────────   ║
║ Nach Scope-Reduktion auf 500 SP (Must-Have):               ║
║  - Alte Deadline: 2025-12-31 (4 Wochen)                    ║
║  - Neue Deadline: 2026-01-14 (6 Wochen)                    ║
║  - Verschiebung: 2 Wochen (14 Tage)                        ║
║                                                                ║
║ Oder: Mit gesamtem Scope (1.200 SP):                       ║
║  - Benötigte Zeit: 1.200 SP ÷ 50 SP/Woche = 24 Wochen    ║
║  - Neue Deadline: 2026-04-30                               ║
║  - Verschiebung: 4 Monate → UNREALISTISCH!                 ║
║                                                                ║
║ ─────────────────────────────────────────────────────────── ║
║                                                                ║
║ OPTION 3: TEAM/RESSOURCEN ERHÖHEN              ║
║ ──────────────────────────────────────────────────────────   ║
║ Aktuelle Velocity: 50 SP/Woche (5 Entwickler)              ║
║                                                                ║
║ Szenario A: +2 externe Entwickler                           ║
║  - Neue Velocity: ~70 SP/Woche (mit Onboarding-Overhead)   ║
║  - Zeit für 1.200 SP: 17 Wochen                             ║
║  - Neue Deadline: 2026-02-15                                ║
║  - Kosten: 2 Devs × 6 Wochen × 85 €/h × 40 h/Woche         ║
║           ≈ EUR 40.800                                       ║
║                                                                ║
║ Szenario B: Outsourcing eines Moduls (z.B. Chatbot)        ║
║  - Externe Partner: Chatbot (100 SP) + andere                ║
║  - Kosten: EUR 15.000–20.000                                ║
║  - Zeiteinsparung: 2 Wochen für Team                        ║
║                                                                ║
║ ACHTUNG: Ressourcen-Erhöhung hat Grenzen!                 ║
║ („Too many cooks spoil the broth")                          ║
║ → Maximum sinnvolle Erhöhung: +20%                          ║
╠═══════════════════════════════════════════════════════════════╣
║ EMPFEHLUNG: HYBRID-ANSATZ                                   ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║ SOFORT-MASSNAHMEN (diese Woche):                            ║
║  1. Emergency Change-Board Meeting mit Sponsor               ║
║  2. Scope-Cut: Chatbot + Mobile-App streichen                ║
║     → Neue Umfang: ~1.080 SP (von 1.200)                   ║
║  3. Video-Hero → einfaches Static-Hero-Element              ║
║     → Einsparung: 60 SP                                      ║
║  4. Social-Media reduzieren (nur Twitter, nicht alle)       ║
║     → Einsparung: 40 SP                                      ║
║  5. Neue Summe: ~980 SP                                      ║
║                                                                ║
║ MITTELFRISTIG (nächste 2 Wochen):                           ║
║  1. Neuer Zeitplan: Deadline → 2026-01-28 (+4 Wochen)     ║
║  2. 1 externen Freelancer hinzunehmen (2–3 Wochen):        ║
║     - Zusätzliche 15–20 SP/Woche                            ║
║     - Kosten: EUR 8.000                                      ║
║  3. MoSCoW-Priorisierung formal durchführen                 ║
║  4. Stakeholder-Kommunikation                               ║
║                                                                ║
║ FINAL SCOPE-RECOVERY:                                       ║
║  - Umfang: 980 SP (nach Cuts)                               ║
║  - Kapazität: 6 Wochen (neu) × 60 SP/Woche                 ║
║             = 360 SP mit Baseline-Team                       ║
║            + 2 Wochen Freelancer × 20 SP/Woche = 40 SP     ║
║             = 400 SP TOTAL                                   ║
║  - IMMER NOCH DEFICIT: 980 - 400 = 580 SP                  ║
║                                                                ║
║ → PHASE 2 für restliche Features! (Backlog-Ansatz)         ║
║  - MVP-Release (Scope-Cut): 2026-01-28                     ║
║  - Phase 2-Features (Should/Could): 2026-Q2                ║
║                                                                ║
╠═══════════════════════════════════════════════════════════════╣
║ MASSNAHMEN ZUR VERMEIDUNG IN ZUKUNFT                         ║
╠═══════════════════════════════════════════════════════════════╣
║  1. Change-Management etablieren (CR-Prozess)               ║
║  2. Wöchentliche Scope-Review-Meetings                      ║
║  3. Kein Feature ohne Aufwandsschätzung!                    ║
║  4. Team-Kapazität tracken (Velocity-Chart)                 ║
║  5. Klare Kommunikation an Stakeholder                      ║
║  6. Scope-Baselines mit Versionsnummern                     ║
║     (v1.0 = Initial, v2.0 = Nach Phase 1 CR, etc.)         ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

> **Kommentar zu Aufgabe 3:**
> 
> Scope-Creep-Bewältigung ist eine reale PM-Aufgabe. Schlüssel:
> - ✓ **Früh erkennen:** Regelmäßige Scope-Reviews
> - ✓ **Bewusst machen:** Zahlen zeigen (50% mehr!) → schock/Wachrüttlung
> - ✓ **Offene Kommunikation:** Sponsor muss Wahrheit wissen
> - ✓ **Reale Optionen:** Nicht nur „schwierig", sondern konkrete Wege (Scope reduzieren, Zeit verschieben, Kosten erhöhen)
> - ✓ **Priorisierung nutzen:** MoSCoW hilft zu priorisieren
> 
> **Häufige Fehler vermeiden:**
> - ❌ So tun als ob es nicht schlimm ist („werden wir schaffen")
> - ❌ Alle Features versprechen und dann Burnout
> - ❌ Nur Scope reduzieren ohne Kommunikation
> - ❌ Team-Überlastung ohne Konsequenzen akzeptieren

---

## Aufgabe 4: Lösungen – YOUTRACK Praktikum

### Aufgabe 4.1–4.4: YOUTRACK-Konfiguration – Muster-Lösung

> Da dies ein praktisches Hands-On-Szenario ist, kann dieses Modul nicht vollständig textlich gelöst werden. Hier ist eine exemplarische Dokumentation:

#### Custom Fields (Screenshot-Beschreibung):

```
In YOUTRACK Administration → Custom Fields:

1. Field: CR-Nummer
   Type: Text
   Visibility: Visible to all
   
2. Field: Impact-Typ
   Type: Enum
   Values: Scope, Schedule, Budget, Quality, Risk, Documentation
   
3. Field: Impact-Bewertung
   Type: Enum
   Values: Niedrig (1), Mittel (2), Hoch (3), Kritisch (4)
   Color-Coding: Green, Yellow, Orange, Red
   
4. Field: Schedule-Impact-Tage
   Type: Integer
   Display: Slider oder number input
   
5. Field: Budget-Impact-EUR
   Type: Integer
   Display: Currency formatter
   
6. Field: Change-Board-Entscheidung
   Type: Enum
   Values: Genehmigt, Abgelehnt, Aufgeschoben, Neu, In Analyse
```

#### Workflow-Definition:

```
Status:
- Neue CR (Initial state)
- In Analyse (PM analysiert Impact)
- Zur Entscheidung (Ready for CCB)
- Genehmigt (CCB decision → go ahead)
- Abgelehnt (CCB decision → not approved)
- Aufgeschoben (CCB decision → later)
- In Umsetzung (assigned to developer)
- Abgeschlossen (CR implemented & closed)

Transitions:
Neue CR → In Analyse
In Analyse → Zur Entscheidung
Zur Entscheidung → Genehmigt
Zur Entscheidung → Abgelehnt
Zur Entscheidung → Aufgeschoben
Aufgeschoben → Neue CR (when reconsidered)
Genehmigt → In Umsetzung
In Umsetzung → Abgeschlossen
Abgelehnt → [Terminal]
Abgeschlossen → [Terminal]
```

#### Automation Rules:

```
Rule 1: Notify on CR approval
  Trigger: Status changes to "Genehmigt"
  Action: Send notification to fields:
    - Assignee
    - Watcher (Project Manager)
    - Custom field: Development Lead
  Subject: "CR approved: [CR-Number] - Ready for implementation"

Rule 2: Set Umsetzungs-Startdatum
  Trigger: Status changes to "In Umsetzung"
  Action: Set custom field "Umsetzungs-Startdatum" = today()

Rule 3: Escalate critical impact
  Trigger: Impact-Bewertung = "Kritisch"
  Action: Notify "Sponsor" user group
  Subject: "CRITICAL CR requires immediate attention"

Rule 4: Tag rejected CRs
  Trigger: Status changes to "Abgelehnt"
  Action: Add label "rejected-phase-" + current phase number

Rule 5: Suggest related issues
  Trigger: Issue created with type "Change Request"
  Action: Suggest linking to related issues with:
    - Same "Impact-Typ"
    - Related WBS components
```

#### JQL Queries für Reports/Dashboards:

```
Query 1: Offene CRs (zur Entscheidung)
project = WEBSHOP AND type = "Change Request" 
  AND status = "Zur Entscheidung"
ORDER BY "Impact-Bewertung" DESC

Query 2: Genehmigter Budget-Impact
project = WEBSHOP AND type = "Change Request" 
  AND status IN (Genehmigt, "In Umsetzung", Abgeschlossen)
  AND "Budget-Impact-EUR" > 0
ORDER BY "Budget-Impact-EUR" DESC

Query 3: Scope-Creep-Monitor (wöchentlich)
project = WEBSHOP AND type = "Change Request" 
  AND "Impact-Typ" = Scope 
  AND status IN (Genehmigt, "In Umsetzung", Abgeschlossen)
  AND created > -1w

Query 4: High-Risk CRs
project = WEBSHOP AND type = "Change Request" 
  AND ("Impact-Bewertung" = Hoch OR "Impact-Bewertung" = Kritisch)

Query 5: This month's CCB decisions
project = WEBSHOP AND type = "Change Request" 
  AND updated > startOfMonth()
  AND status IN (Genehmigt, Abgelehnt, Aufgeschoben)
```

#### Dashboard Example:

```
CHANGE MANAGEMENT DASHBOARD

[Widgets]

1. "Offene CRs" Gadget
   Display: Count of issues with status = "Zur Entscheidung"
   Alert: Red if count > 5

2. "Budget-Impact Chart"
   Display: Bar chart of Budget-Impact-EUR by status
   Shows: Total EUR for Genehmigt vs. Abgelehnt

3. "CR-Trend" Gadget
   Display: Line chart of CR-Count over time (last 12 weeks)
   Shows: Trend of Scope-Creep?

4. "Impact-Type Distribution"
   Display: Pie chart of Impact-Typ values
   Shows: 40% Scope, 30% Schedule, 20% Budget, 10% Risk

5. "Top 5 Budget-Heavy CRs"
   Display: Table of highest Budget-Impact CRs
   Sortable: By status, initiator, date

6. "CCB Meeting Preparation"
   Display: List of CRs in "Zur Entscheidung" status
   Export: Agenda template for next meeting
```

> **Kommentar zu Aufgabe 4:**
> 
> YOUTRACK (oder ähnliche Issue-Tracking-Systeme wie Jira, Azure DevOps) sind **essentiell** für Change-Management. Sie bieten:
> - ✓ **Centralized documentation** – Alle CRs an einem Ort
> - ✓ **Workflow automation** – Status-Übergänge, Benachrichtigungen
> - ✓ **Audit trail** – Wer hat was wann entschieden?
> - ✓ **Reporting** – Dashboards, Trends, Entscheidungs-Statistiken
> - ✓ **Traceability** – Verknüpfung von CR zu Anforderungen/Aktivitäten
> 
> **Best Practice:** Keine Excel-CRs! Alles im Tool.

---

## Aufgabe 5: Lösungen – Traceability-Matrix

### RTM Lösung – Passwort-Reset-Funktion:

```
╔═══════════════════════════════════════════════════════════════════════════════╗
║        REQUIREMENTS TRACEABILITY MATRIX – PASSWORT-RESET-FUNKTION          ║
╚═══════════════════════════════════════════════════════════════════════════════╝

┌───────────────────────────────────────────────────────────────────────────────┐
│ REQ-042: Passwort zurücksetzen via Passwort-Vergessen-Link                   │
├───────────────────────────────────────────────────────────────────────────────┤
│ Baseline:  In ursprünglichen Anforderungen (v1.0)                            │
│ Status:    Change-Request eingegangen                                         │
│ Link zu CR: CR-2025-089 (SMS-Bestätigung hinzufügen)                         │
└───────────────────────────────────────────────────────────────────────────────┘

┌──────────┬──────────┬─────────────────┬────────────────┬──────────┬──────────┐
│ REQ-ID   │ CR-ID    │ WBS-Element     │ Aktivität      │ Test-Case│ Status   │
├──────────┼──────────┼─────────────────┼────────────────┼──────────┼──────────┤
│ REQ-042  │ Baseline │ 3.5             │ GA-3.5.1       │ TC-088   │ ✓        │
│          │          │ Passwort-Reset  │ Email-Versand  │ Email    │ Fertig   │
│          │          │                 │ implementieren │ verschick│          │
│          │          │                 │                │ t        │          │
│          │          │                 │                │          │          │
│ REQ-042  │CR-025089 │ 3.5             │ GA-3.5.2       │ TC-089   │ In Dev   │
│ (erweit.)│          │ Passwort-Reset  │ SMS-Versand    │ SMS      │ (Neu)    │
│          │          │ (erweitert)     │ integrieren    │ Bestätig │          │
│          │          │                 │                │ ung      │          │
│          │          │                 │                │          │          │
│ REQ-042  │CR-025089 │ 3.5             │ GA-3.5.3       │ TC-090   │ Geplant  │
│ (Test)   │          │ Passwort-Reset  │ Integration-   │ SMS +    │ (Neu)    │
│          │          │                 │ Tests (E2E)    │ Email    │          │
│          │          │                 │                │ E2E      │          │
└──────────┴──────────┴─────────────────┴────────────────┴──────────┴──────────┘

DETAILS:

[REQ-042 Baseline]
- Beschreibung: User kann Passwort via Email-Link zurücksetzen
- Ursprüngliche Anforderung: Ja (v1.0 Spec)
- Akzeptanzkriterien:
  ✓ User klickt „Passwort vergessen"
  ✓ System sendet Reset-Email an registrierte Email-Adresse
  ✓ Link ist 24h gültig
  ✓ Neues Passwort wird nach Zurücksetzen aktiv

[Change Request CR-2025-089]
- Änderung: SMS-Bestätigung zusätzlich zu Email
- Grund: Höhere Sicherheit, Compliance-Anforderung
- Scope-Impact: +30 Story-Points
- Schedule-Impact: +3 Arbeitstage
- Neue Anforderungen:
  ✓ SMS wird nach Email versendet
  ✓ User muss 6-stelligen Code eingeben
  ✓ Code ist 10 Min gültig
  ✓ Max 3 Versuche, dann Blockade

[WBS-Struktur]
3.5 Passwort-Reset-Funktion
├── 3.5.1 Email-Versand (FERTIG – Baseline)
├── 3.5.2 SMS-Versand (NEU – CR-2025-089)
└── 3.5.3 Integration & Testing (NEU – CR-2025-089)

[Aktivitäten]
GA-3.5.1: Email-Versand
- Status: Abgeschlossen
- Team: Backend-Dev (Alice)
- Dauer: 5 Arbeitstage
- Abnahme: QA Test bestanden

GA-3.5.2: SMS-Integration
- Status: In Development
- Team: Backend-Dev (Bob)
- Dauer: geplant 4 Arbeitstage
- Abhängigkeit: SMS-Provider-Account (verfügbar)
- Risiken: API-Rate-Limiting des Providers

GA-3.5.3: Integration & E2E-Test
- Status: Geplant
- Team: QA (Charlie) + Frontend (Diana)
- Dauer: geplant 3 Arbeitstage
- Abhängigkeit: GA-3.5.2 muss fertig sein
- Testfälle: TC-089, TC-090

[Test-Cases]
TC-088: Email-Reset (Baseline)
- Szenario: User klickt „Passwort vergessen"
- Erwartung: Email mit Link wird versendet
- Status: ✓ PASSED

TC-089: SMS-Bestätigung (Neu – CR-2025-089)
- Szenario: User gibt SMS-Code ein
- Erwartung: Passwort wird geändert nach SMS-Verifizierung
- Status: [Noch zu schreiben – Teil von GA-3.5.3]

TC-090: E2E: Email + SMS (Neu – CR-2025-089)
- Szenario: Kompletter Ablauf Email → SMS → Passwort-Reset
- Erwartung: Alles funktioniert ohne Fehler
- Status: [Noch zu schreiben – Teil von GA-3.5.3]

[Rückverfolgbarkeit]
✓ REQ-042 ist dokumentiert in: Anforderungs-Spec v1.0
✓ Baseline-Anforderungen sind umgesetzt in: GA-3.5.1
✓ CR-2025-089 erweitert REQ-042 um SMS-Feature
✓ Erweiterung wird umgesetzt in: GA-3.5.2, GA-3.5.3
✓ Tests folgen in: TC-089, TC-090
✓ Abnahme erfolgt durch: Kunde + QA

[YOUTRACK-Struktur (beispiel)]
Issue: CR-2025-089 (Change Request)
  ├── Epic: REQ-042 (Link zu Anforderung)
  ├── Story 1: DEV-1234 (Backend: SMS-Integration)
  │   └── Subtask: QA-889 (Unit-Tests für SMS-Modul)
  ├── Story 2: DEV-1235 (Frontend: SMS-Code-Eingabe)
  │   └── Subtask: QA-890 (UI-Test SMS-Dialog)
  └── Story 3: DEV-1236 (Integration-Tests)
      ├── Test: TC-089 (SMS-Bestätigung)
      └── Test: TC-090 (E2E-Szenario)

[Confluence-Dokumentation]
Page: „Requirements Traceability – Release v2.1"
├── RTM-Table (obige Matrix)
├── Change-Impact-Analysis für CR-2025-089
├── Acceptance-Criteria pro Test-Case
└── Sign-Off von Customer/Sponsor
```

> **Kommentar zu Aufgabe 5:**
> 
> Traceability ist die **Rückverfolgbarkeit** – ein kritischer PM-Aspekt:
> - ✓ **Vollständigkeit:** Wurde jede Anforderung implementiert?
> - ✓ **Change-Impact:** Wenn eine Anforderung ändert, welche Tests müssen angepasst werden?
> - ✓ **Scope-Control:** Keine versteckte Arbeit – alles ist traceable
> - ✓ **Audit-Konformität:** Für regulierte Industrien essentiell
> 
> **Best Practice:**
> - Anforderung ↔ CR ↔ WBS ↔ Code ↔ Test ↔ Abnahme
> - Ein Element kann nicht ohne die anderen existieren

---

## Persönliche Notizen und Zusammenfassung – EXEMPLARISCHE ANTWORTEN

### Meine Key-Learnings aus Modul 16:

**1. Was habe ich gelernt?**
```
• Änderungsmanagement ist nicht optional – es ist der Kern von Project Control
• Scope-Creep passiert unbewusst durch kleine Entscheidungen
• Ein formaler Change-Request-Prozess schützt das Projekt vor Chaos
• Impact-Analyse macht „versteckte Kosten" sichtbar
• Das Change Control Board braucht Mumm, um auch „Nein" zu sagen
• YOUTRACK (oder ähnliche Tools) automtisiert 80% des administrativen Aufwands
• Traceability ist nicht „schön zu haben" – sie ist essentiell für Professionalisierung
```

**2. Welche Fehler möchte ich in meinen Projekten vermeiden?**
```
• Keine mündlichen Change-Requests mehr – alles dokumentiert
• Wöchentliche Scope-Reviews durchführen (nicht warten bis Ende)
• Nicht zu permissiv sein – „Nein" ist auch eine Antwort
• Team überlastung vermeiden – nicht einfach mehr Arbeit auf dem Haufen laden
• Scope-Baselines pflegen (v1.0, v1.1, v2.0) – Veränderungen nachvollziehbar
• Impact nicht unterschätzen – konservativ schätzen, nicht optimistisch
```

**3. Wie werde ich Scope-Creep in meinem nächsten Projekt vermeiden?**
```
• Zu Projektstart: Klare Anforderungen definieren (SMART-Kriterien)
• Weekly: Scope-Review-Meeting (30 Min) mit Team
• Jeder Kundenwunsch: „Bitte als CR einreichen" – kein Wort ohne Dokumentation
• Process: CR → Impact-Analyse → CCB-Entscheidung → Planung
• Tools: YOUTRACK-Workflow einrichten mit Automations-Rules
• Kommunikation: Stakeholder informieren über Entscheidungen + Begründung
• Priorisierung: MoSCoW-Modell nutzen (Must, Should, Could, Won't)
```

**4. Welche YOUTRACK-Features werde ich nutzen?**
```
• Custom Fields für: CR-Nummer, Impact-Typ, Budget-Impact, Schedule-Impact
• Workflow-Status: Neue CR → In Analyse → Zur Entscheidung → Genehmigt
• Automation-Rules: Benachrichtigungen bei Genehmigung, Escalation bei Kritisch
• JQL-Queries: „Offene CRs", „Budget-Impact-Übersicht", „Scope-Creep-Monitor"
• Dashboards: Trend-Charts, Impact-Verteilung, Top-5 Budget-Heavy CRs
• Linking: CR ↔ Anforderung ↔ WBS ↔ Task ↔ Test ↔ Abnahme
```

---

## Checkliste: Änderungsmanagement – Bin ich bereit?

| Kompetenz | Ja | Teilweise | Nein | Kommentar |
|-----------|----|-----------|----|-----------|
| Ich kann einen CR schreiben | ✓ | | | Inkl. Impact-Analyse und Begründung |
| Ich verstehe Impact-Analyse | ✓ | | | Scope, Schedule, Budget, Quality, Risk |
| Ich kann ein CCB-Meeting leiten | ✓ | | | Mit Scoring-Matrix und transparenten Entscheidungen |
| Ich erkenne Scope-Creep | ✓ | | | Früherkennung durch wöchentliche Reviews |
| Ich kann Traceability dokumentieren | ✓ | | | Anforderung → CR → WBS → Test → Abnahme |
| Ich kann YOUTRACK für Change-Mgmt nutzen | ✓ | | | Custom Fields, Workflows, JQL-Queries, Dashboards |

---

**Ende Modul 16 Lösungen**
