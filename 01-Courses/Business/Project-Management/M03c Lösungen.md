## Aufgabe 1: Stakeholder-Identifikation und -Klassifizierung – LÖSUNGEN

### 1.1 Stakeholder identifizieren – LÖSUNGSVORSCHLAG

| **Stakeholder-Kategorie** | **Identifizierte Stakeholder** | **Rolle/Beschreibung** |
|---|---|---|
| **Management/Sponsor** | Geschäftsführung / Finanzvorstand | Finanziert Projekt, trägt Gesamtverantwortung |
| **Management/Sponsor** | Vorstand Personal/HR | Business Owner, Sponsor |
| **Kernteam** | Projektmanager | Operativer Leiter des Projekts |
| **Kernteam** | IT-Projektleiter | Verantwortlich für technische Umsetzung |
| **Kernteam** | HR-Fachverantwortlicher (Learning & Development) | Fachliche Anforderungen, Content-Strategie |
| **Fachabteilungen** | Leiter Schulung/Bildung | Betroffene Fachfunktion, Wissensträger |
| **Fachabteilungen** | Bereichsleiter Vertrieb | Endnutzer-Anforderungen (mobile Schulung, Filialzugang) |
| **Fachabteilungen** | Leiter Compliance/Audit | Regulatorische Anforderungen, Nachverfolgung |
| **IT & Technik** | IT-Leiter / CIO | Technische Richtlinie, Systemintegration, Security |
| **IT & Technik** | IT-Infrastruktur-/Betriebsteam | Hosting, Betrieb, Support |
| **IT & Technik** | IT-Sicherheits-/Datenschutz-Beauftragter | DSGVO-Compliance, Sicherheitsanforderungen |
| **Betroffene Mitarbeiter** | Schulungsteilnehmer (800 Mitarbeiter, Masse) | Endnutzer, Akzeptanz-Treiber |
| **Betroffene Mitarbeiter** | Trainer/Instruktoren | Umstellung ihrer Arbeit, ggf. Widerstand |
| **Betroffene Mitarbeiter** | Betriebsrat / Personalvertretung | Mitbestimmung, Arbeitsplatzsicherung |
| **Externe Partner** | E-Learning-Software-Anbieter | Lieferant, Integrations-Partner |
| **Externe Partner** | Systemintegrator / Implementierungs-Dienstleister | Umsetzungs-Partner |
| **Externe Partner** | Externe Trainer / Content-Entwickler | Support bei Kursentwicklung |
| **Sonstige** | Kunden (ggf.) | Wenn Kundentraining Teil des Projekts |

> **Kommentar:**  
> Eine vollständige Stakeholder-Liste ist essentiell. Der häufigste Fehler ist die **Vergessene des Betriebsrats** – dies führt zu erheblichen Verzögerungen in späteren Phasen. In Deutschland ist die Einbeziehung gesetzlich verankert. Auch **externe Dienstleister und Lieferanten** sollten nicht übersehen werden, da sie ggf. kritische Abhängigkeiten darstellen.  
> **Tipp:** Systematisches Durchgehen (nach Organisationshierarchie, nach Prozessschritten, nach Kompetenzbereichen) verhindert Lücken.

---

### 1.2 Stakeholder klassifizieren – LÖSUNGSVORSCHLAG

**Macht-Interesse-Matrix – Gefüllt:**

```
              ↑ HOHES INTERESSE
              |
       HOHE   |  [MANAGE CLOSELY]   |  [KEEP SATISFIED]
       MACHT  |  • Geschäftsführung | • Betriebsrat
              |  • CFO/Sponsor      | • HR-Vorstand
              |  • IT-Leiter        | • Compliance
              |  • Projektmanager   |
              |_____________________|____________________
              |  [MONITOR]          |  [KEEP INFORMED]
       NIEDRIG|  • Externe Trainer  | • Einzelne Nutzer
       MACHT  |  • Content-Partner  | • Filial-Leiter
              |                     | • Trainer/Instruktoren
              |_____________________|
              NIEDRIGES ← | → HOHES
               INTERESSE   INTERESSE
```

**Detaillierte Engagement-Strategien:**

| **Quadrant** | **Stakeholder (Beispiele)** | **Engagement-Strategie** |
|---|---|---|
| **Manage Closely** | Geschäftsführung, Projektmanager, IT-Leiter | ✓ Monatliche Jour Fixe, Steering Committee  <br/> ✓ Direkte Eskalationswege  <br/> ✓ Executive Dashboard wöchentlich  <br/> ✓ Frühzeitige Entscheidungseinforderung |
| **Keep Satisfied** | Betriebsrat, HR-Vorstand, Compliance | ✓ Regelmäßige (2-wöchentliche) Informationen  <br/> ✓ Arbeitsgruppen bei Themen (Datenschutz, Arbeitsrecht)  <br/> ✓ Mitgestaltungsrechte in kritischen Fragen  <br/> ✓ Zu-Lesen von Beschlüssen |
| **Keep Informed** | Filial-Leiter, Trainer, einzelne Nutzer-Vertreter | ✓ Monatlicher Projektbericht (verständlich)  <br/> ✓ Quartalsweise Informationsveranstaltungen  <br/> ✓ Intranet-Newsletter, FAQ  <br/> ✓ Vorab-Information vor öffentlicher Ankündigung |
| **Monitor** | Externe Trainer, Content-Partner, Kunden | ✓ 1x pro Quartal Status-Check  <br/> ✓ Bedarfs-orientierte Einbeziehung  <br/> ✓ Automatische Benachrichtigungen bei Relevanz  <br/> ✓ Auf Anfrage responsive Kommunikation |

> **Kommentar:**  
> Die **Macht-Interesse-Matrix ist ein dynamisches Dokument** – Stakeholder können ihre Position während des Projekts ändern. Beispiel: Ein „Keep Informed"-Stakeholder könnte zum „Manage Closely" werden, wenn sich die Anforderungen in seinem Bereich wesentlich ändern.  
> **Häufiger Fehler:** Zu viele Stakeholder in "Manage Closely" → Entscheidungsprozesse werden zu langsam. Zu wenige → Konflikte werden zu spät sichtbar.  
> **Best Practice:** Matrix regelmäßig (alle 4–6 Wochen) überprüfen und anpassen.

---

## Aufgabe 2: Anforderungsermittlung – LÖSUNGEN

### 2.1 Anforderungen nach Typ klassifizieren – LÖSUNGSVORSCHLAG

| **#** | **Anforderungs-Aussage** | **Typ** | **Begründung** |
|---|---|---|---|
| 1 | „Die Plattform muss innerhalb von 3 Sekunden laden" | **NF** | Nichtfunktionale Anforderung: Leistungs-Anforderung (Ladezeit) |
| 2 | „Wir müssen die Schulungskosten um mindestens 30% senken" | **G** | Geschäftsanforderung: Business-Ziel, Nutzen-Messgröße |
| 3 | „Alle Schulungen müssen dokumentierbar und archivierbar sein (Compliance)" | **R** | Regulatorische Anforderung: Nachverfolgung, Audit-Trail, gesetzlich verankert |
| 4 | „Das System muss für 800 gleichzeitige Nutzer auslegbar sein" | **NF** | Nichtfunktionale Anforderung: Kapazität/Skalierbarkeit |
| 5 | „Kurse müssen mit Video, Quizzen und interaktiven Elementen erstellbar sein" | **F** | Funktionale Anforderung: Spezifische Features der Plattform |
| 6 | „IT-Administratoren brauchen ein einfaches Verwaltungs-Dashboard" | **S** | Stakeholder-spezifische Anforderung: Besondere Bedürfnisse der IT-Admin-Rolle |
| 7 | „Die Plattform muss DSGVO-konform sein" | **R** | Regulatorische Anforderung: Datenschutzgesetze (verbindlich) |
| 8 | „Mitarbeiter in den Filialen wünschen sich Mobile-Zugriff (auch offline)" | **S** | Stakeholder-spezifische Anforderung: Besonderheit von Außendienstmitarbeitern |

> **Kommentar:**  
> **Häufige Fehler bei der Klassifizierung:**  
> - Anforderung #1 wird oft als „funktional" fehlklassifiziert, ist aber eine **Performance-Anforderung** (nichtfunktional)
> - Anforderung #2 ist **nicht selbst eine Anforderung**, sondern ein **Business-Outcome**. Die Anforderung dahinter ist: "System muss die Schulungsdauer um 40% reduzieren" oder "Automatische Kurserstellung ermöglichen"
> - Anforderung #8: Viele ordnen dies unter **funktional** ein. Aber es ist spezifisch für eine **Stakeholder-Gruppe** (Filialnetzwerk) und tangiert Business-Anforderungen (Mitarbeiterzufriedenheit). Daher: **Stakeholder-spezifisch**.  
> **Lernpunkt:** Gute Anforderungen haben einen klaren **Kontext** (Wer? Warum? Unter welchen Bedingungen?).

---

### 2.2 Anforderungs-Lückenanalyse – LÖSUNGSVORSCHLAG

**Häufig übersehene Anforderungen:**

| **Neu hinzugefügte Anforderung** | **Kategorie** | **Begründung** |
|---|---|---|
| 1. „Die Plattform muss mit bestehenden HR-Systemen (Personaldatenbank, Zeitwirtschaft) integrierbar sein" | **F** | Funktional: Integration ist zentral für Automatisierung und Datenqualität. Ohne Integrations-Anforderung → späte Discovery → Rework |
| 2. „Nutzer müssen verschiedene Sprachen wählen können (Deutsch/Englisch minimum)" | **F** | Funktional: Internationales Unternehmen, mehrsprachige Belegschaft. Oft vergessen, aber später teuer nachzurüsten |
| 3. „Das System muss Schulungsberichte automatisiert an Linienmanager liefern (wöchentlich)" | **F** | Funktional: Reporting-Features sind geschäftskritisch für ROI-Nachweise und Kontrolle. Wird oft vergessen |
| 4. „Die Implementierung muss mit <10% Ausfallzeit der HR-Systeme erfolgen" | **NF** | Nichtfunktional: Verfügbarkeits-Anforderung während Migration. Business-kritisch |
| 5. „Kursmaterialien müssen von Fachabteilungen selbst aktualisierbar sein (keine IT-Abhängigkeit)" | **S** | Stakeholder-spezifisch (HR/Fachexperten): User-Empowerment, Unabhängigkeit von IT ist oft eine versteckte, wichtige Anforderung |
| 6. „System muss auf Schutz vor Unbefugtem Zugriff geprüft sein (ISO 27001 / IT-Grundschutz)" | **R** | Regulatorisch: Informationssicherheit im Unternehmenskontext (oft vergessen, aber kritisch) |

> **Kommentar:**  
> **Die Lückenanalyse ist ein ESSENTIELLER Schritt in der Anforderungsermittlung.** Typische blinde Flecken:  
> - **Integrations-Anforderungen** (Konnektivität zu anderen Systemen)
> - **Reporting-Features** (was muss rauskommend, nicht nur rein?)
> - **Benutzer-Empowerment** (Self-Service vs. IT-Abhängigkeit?)
> - **Sicherheit und Compliance** (nicht exotisch, aber oft späte Entdeckung)
> - **Mehrsprachigkeit / Barrierefreiheit** (bis zum Schluss vergessen, nachher teuer)
> - **Migration / Transition** (wie kommt man vom Alten zum Neuen?)  
> **Best Practice:** Anforderungs-Checklisten verwenden (nach Modul, nach Standard wie PMBOK, nach Branche).

---

## Aufgabe 3: SMART-Ziele formulieren – LÖSUNGEN

### 3.1 SMART-Analyse – LÖSUNGSVORSCHLAG

| **Original-Ziel** | **S** | **M** | **A** | **R** | **T** | **Verbessertes Ziel (SMART)** |
|---|---|---|---|---|---|---|
| „System stabil machen" | ✗ | ✗ | ~ | ✓ | ✗ | **„Die E-Learning-Plattform mit 99,5% Verfügbarkeit (SLA) und <2 Sekunden durchschnittlicher Antwortzeit betreiben bis 31.12.2025"** |
| „Alle Mitarbeiter geschult" | ~ | ✗ | ✗ | ✓ | ✗ | **„Mindestens 90% der 800 Mitarbeiter absolvieren bis 31.10.2025 die Pflicht-Schulung ‚Plattform-Navigation' (2h online)"** |
| „Platform fertig" | ✗ | ✗ | ✗ | ~ | ~ | **„E-Learning-Plattform mit allen 5 geplanten Kernmodulen (Learning, Reporting, Admin, Mobile, Integration) bis 30.09.2025 produktiv gehen"** |

> **Kommentar zu Original 1 – „System stabil machen":**  
> - **S (Spezifisch):** ✗ → Was heißt „stabil"? Gemeint sind vermutlich Verfügbarkeit und Performance, aber nicht konkret.
> - **M (Messbar):** ✗ → Keine Zahl (99% vs. 95%?), keine Metrik (Uptime? Fehlerrate?).
> - **A (Attraktiv):** ~ → Technisch möglich, aber realistisch ist nicht klar (Kosten? Architektur?).
> - **R (Relevant):** ✓ → Stabilität ist natürlich relevant.
> - **T (Terminiert):** ✗ → Kein Zeitfenster ("bis wann?").  
> **Verbesserung:** Mit **99,5% SLA** → konkrete Messlatte. Mit **2 Sek. Response** → Performance-Ziel. Mit **31.12.2025** → Frist für Operation (ab 30.09. live).

> **Kommentar zu Original 2 – „Alle Mitarbeiter geschult":**  
> - **S (Spezifisch):** ~ → Was bedeutet „geschult"? Welche Inhalte? Wie tief?
> - **M (Messbar):** ✗ → „Alle" ist vage (800? Oder nur Kernteam?). Keine Quote definiert.
> - **A (Attraktive):** ✗ → 100% aller Mitarbeiter im Voraus zu schulen ist unrealistisch (Urlaub, Rotation, Fluktuation).
> - **R (Relevant):** ✓ → Adoption ist relevant.
> - **T (Terminiert):** ✗ → Kein Enddatum.  
> **Verbesserung:** Mit **„90% der 800"** → realistisch und messbar. Mit **„Pflicht-Schulung ‚Plattform-Navigation' (2h)"** → Konkretisierung. Mit **31.10.2025** → Umsetzungsfrist.

> **Kommentar zu Original 3 – „Platform fertig":**  
> - Das ist das **schlechteste Ziel** – praktisch keine SMART-Kriterien erfüllt.
> - **S (Spezifisch):** ✗ → Was ist „fertig"? Alpha? Beta? Produktiv? Mit welchen Features?
> - **M (Messbar):** ✗ → Keine Kriterien, keine Metriken.
> - **A (Attraktiv):** ✗ → Ist alles wirklich möglich bis 30.09.? Ressourcen? Risiken?
> - **R (Relevant):** ~ → Allgemein relevant, aber zu unkonkret.
> - **T (Terminiert):** ~ → 30.09. ist das Projekt-Enddatum (gegeben), aber „fertig" ist nicht zeitgebunden definiert.  
> **Verbesserung:** Mit **„5 Kernmodule"** → Scope konkretisiert. Mit **„produktiv gehen"** → Meilenstein (nicht nur „entwickelt", sondern „im Einsatz"). Mit **30.09.2025** → Go-Live-Datum.

---

### 3.2 Erfolgs-Kriterien definieren – LÖSUNGSVORSCHLAG

**Ziel:** „Das E-Learning-System bis 30.09.2025 einführen, sodass mindestens 500 Mitarbeiter täglich im Einsatz sind."

| **Erfolgskriterium** | **Messgröße** | **Akzeptanzgrenze** |
|---|---|---|
| 1. Systemverfügbarkeit | Uptime % | ≥ 99% (max. 7,2 h Ausfallzeit/Monat) |
| 2. Tägliche aktive Nutzer (Daily Active Users) | DAU-Zahl | ≥ 500 Nutzer/Tag (gemessen ab 01.10.2025 über 4 Wochen) |
| 3. Durchschnittliche Antwortzeit (Response Time) | Sekunden | ≤ 3 Sekunden (95% der Requests) |
| 4. Schulungsabschluss-Quote | % der Zielgruppe | ≥ 80% absolvieren Pflicht-Schulung bis 31.10.2025 |
| 5. Systemfehler / Bug-Rate | Anzahl kritischer Bugs in Live-Phase | ≤ 5 kritische Bugs in den ersten 4 Wochen (Aug-Okt) |
| 6. Nutzer-Zufriedenheit | Net Promoter Score (NPS) oder Befragung | ≥ 6,5/10 (Befragung nach 4 Wochen Betrieb) |
| 7. Integration mit HR-Systemen | Erfolgsquote Datensynchronisation | ≥ 99,5% fehlerfreie Datenübertragung von/zu HR-System |
| 8. Projektbudget-Einhaltung | Gesamtkosten | ≤ 200.000 EUR (Zielbudget) oder ≤ 210.000 EUR (mit 5% Puffer) |
| 9. Terminplanung (Go-Live) | Datum | 30.09.2025 ± 2 Wochen Puffer |
| 10. Dokumentation Vollständigkeit | % der Arbeitsartefakte | ≥ 95% der geplanten Dokumentation (Charter, WBS, Risks, Lessons Learned) abgeschlossen |

> **Kommentar:**  
> **Erfolgskriterien sollten:**  
> - **Messbar sein** (Zahl, Quote, ja/nein, nicht „zufrieden" oder „funktioniert")
> - **Realistisch** sein (nicht 100% auf alles; Puffer einplanen)
> - **Zeitlich gebunden** (wann gemessen? ab wann? über wie lange?)
> - **Stakeholder-validiert** sein (nicht nur PM-Wunsch, sondern mit Sponsor/Kunden abgestimmt)  
> **Häufige Fehler:**
> - Zu viele Kriterien (10–15 ist o.k., aber >20 macht Management unmöglich)
> - Zu hohe Anforderungen (99,99% Uptime ist teuer und oft unnötig)
> - Fehlende zeitliche Bindung („DAU ≥ 500" – aber wann? Ab Woche 1? Nach Ramp-Up?)  
> **Best Practice:** Kriterien in **Must-have** (Business-kritisch), **Should-have** (wünschenswert), **Could-have** (nice-to-have) gruppieren. Nur Must-haves sind echte Erfolgskriterien.

---

## Aufgabe 4: Project Charter erstellen – LÖSUNGSVORSCHLAG

### **PROJECT CHARTER – E-Learning-Plattform**

#### **1. Projektinformation**
- **Projekttitel:** Einführung E-Learning-Plattform für Unternehmensschulung
- **Projektcode:** ELP-2025-Q2-Q3
- **Projektmanager:** [Max Mustermann, PM-Erfahrung 8 Jahre]
- **Sponsor/Auftraggeber:** Vorstand HR / Geschäftsführung
- **Freigabedatum:** 15.01.2025

#### **2. Geschäftsbegründung**
Das Unternehmen verfügt derzeit über ein dezentrales, präsenzbasiertes Schulungssystem mit hohen Kosten (~250k EUR/Jahr), begrenzte Skalierbarkeit und mangelnde Dokumentation. Mit der Einführung einer modernen E-Learning-Plattform werden Schulungskosten um 30% reduziert (Ziel: ~175k EUR/Jahr), Mitarbeiter flexibel und ortsunabhängig trainiert, Compliance-Anforderungen durch zentrale Dokumentation erfüllt, und Lerninhalte schneller aktualisierbar. Dies unterstützt die Strategie „Digital First" und erhöht Mitarbeiterzufriedenheit (interne Umfrage: 68% befürworten E-Learning).

#### **3. Projektbeschreibung**
Umsetzung einer Cloud-basierten E-Learning-Plattform für ca. 800 Mitarbeiter mit integrierten Funktionen für Kurserstellung, Benutzerverwaltung, Leistungsanalytics und Berichterstellung. Die Plattform wird mit bestehenden HR-Systemen verknüpft, responsive Design für Mobile/Desktop, und Datenschutzkonformität (DSGVO, ISO 27001) gewährleistet. Go-Live bis 30.09.2025.

#### **4. Ziele (SMART)**
1. **Systembetrieb:** E-Learning-Plattform mit ≥99% Verfügbarkeit und ≤3 Sek. Ladezeit bis 30.09.2025 produktiv gehen lassen
2. **Nutzer-Adoption:** Mindestens 500 täglich aktive Nutzer (≥80% der Zielgruppe) innerhalb von 4 Wochen nach Go-Live erreichen
3. **Kosteneinsparung:** Schulungskosten um 30% reduzieren (von ~250k auf ~175k EUR/Jahr) nachweisbar ab Q1 2026
4. **Skalierbarkeit:** System ist für Wachstum auf 1.500+ Mitarbeiter (Akquisitionen) skaliert, ohne Redesign

#### **5. Erfolgskriterien / Akzeptanzkriterien**
| **Kriterium** | **Messbar** | **Zielwert** |
|---|---|---|
| Go-Live Datum | Produktivstart | 30.09.2025 ±7 Tage |
| Tägliche aktive Nutzer | DAU-Zahl | ≥ 500 (4 Wochen nach Go-Live) |
| System-Verfügbarkeit | Uptime % | ≥ 99% (SLA-Rahmen) |
| Ladezeit | Response Time | ≤ 3 Sekunden (95-Perzentil) |
| Nutzerzufriedenheit | NPS-Score | ≥ 6,5 / 10 |
| Budget-Einhaltung | Gesamtkosten | ≤ 210.000 EUR (5% Puffer auf 200k genehmigt) |
| Schulungsquote | % Teilnehmer Grundschulung | ≥ 80% bis 31.10.2025 |
| Integration Erfolgsquote | HR-Daten Sync | ≥ 99,5% fehlerfreie Datensynchronisation |

#### **6. Projektumfang (Scope) – Was gehört DAZU?**
- Auswahl und Lizenzierung einer E-Learning-Plattform (Buy, nicht Build)
- Systemkonfiguration und Anpassung an Unternehmensrichtlinien
- Integration mit SAP HR und Active Directory (SSO)
- Datenimport von 800+ Mitarbeiter-Stammdaten
- Erstellung von 5 Pflicht-Kursen (Grundlagen, Compliance, Compliance-Updates, Onboarding, Sicherheit)
- User-Training und Dokumentation (Admin, Trainer, Nutzer)
- Parallelbetrieb (alte + neue Plattform) für 2 Wochen
- Project Closeout und Lessons Learned

#### **7. Abgrenzungen – Was gehört NICHT dazu?**
- Content-Erstellung über diese 5 Kurse hinaus (separate HR-Initiative)
- Bestandssystem-Abbau (Legacy-Migration erfolgt später)
- Individuelle Kursentwicklung für jede Abteilung (Template-gestützt, nicht Custom)
- Anbindung von Kundenschulungen (Out of Scope, evtl. Phase 2)
- Zertifizierung oder Prüfungs-Module (nur Learning-Tracking)
- Langzeit-Betrieb (Support + Wartung ab 01.10. → IT-Betriebsteam)

#### **8. Budget**
- **Genehmigtes Gesamtbudget:** 200.000 EUR
- **Contingency / Puffer:** 5% (ca. 10.000 EUR) 
- **Verfügbar für Planung:** 190.000 EUR
- **Typische Aufteilung (Schätzung):**
  - Software-Lizenzen: 60.000 EUR
  - Implementierung (Integrator): 90.000 EUR
  - Training & Dokumentation: 25.000 EUR
  - Projektmanagement / Overhead: 15.000 EUR

#### **9. Zeitrahmen**
- **Projektstart:** 01.02.2025
- **Projektende (Go-Live):** 30.09.2025
- **Dauer (Tage):** 243 Tage (ca. 8 Kalenderwochen)
- **Wichtige Meilensteine:**
  - **M1 – Anforderungen finalisiert:** 28.02.2025 (Charter-Freigabe + Kick-off)
  - **M2 – Angebote evaluiert, Lieferant gewählt:** 31.03.2025 (Beschaffung abgeschlossen)
  - **M3 – System konfiguriert, Test-Umgebung:** 30.06.2025 (UAT start)
  - **M4 – User Acceptance Testing (UAT) abgeschlossen:** 31.08.2025
  - **M5 – Go-Live (Produktivstart):** 30.09.2025
  - **M6 – Optimierungen abgeschlossen, Support übergeben:** 31.10.2025

#### **10. Projektorganisation**
| **Rolle** | **Name / Titel** | **Verantwortung** |
|---|---|---|
| Sponsor | Vorstand HR | Strategische Ausrichtung, Budget, Geschäftsentscheidungen, Eskalation |
| Projektmanager | Max Mustermann (PM, PMO-Team) | Operative Projektführung, Planung, Risiken, Status, Qualität |
| Fachleitung / Product Owner | Sandra Schmidt (L&D Manager) | Fachliche Anforderungen, Abnahme, Kurse, User-Training |
| IT-Projektleiter | Thomas Köhler (IT-Projektmanagement) | Technische Umsetzung, System-Integration, Infrastructure |
| Steuerkreisvorsitz | CFO / CIO | Regelmäßige Überwachung (monatlich), Governance |

#### **11. Qualitätsanforderungen**
- **System-Performance:** Response Time ≤3 Sek., Verfügbarkeit ≥99%
- **Funktionale Vollständigkeit:** Alle in Anforderungsspezifikation definierten Funktionen vollständig implementiert
- **Testabdeckung:** Minimum 85% Unit-Test-Abdeckung; UAT mit 20+ Nutzern durchgeführt
- **Dokumentation:** Admin-Handbuch, User-Guide, Betriebshandbuch, Troubleshooting-Guide verfügbar
- **Sicherheit / Compliance:** DSGVO-Konformität geprüft, ISO 27001 Audit-Readiness, Datenschutz-Folgenabschätzung (DSFA) durchgeführt
- **Benutzerfreundlichkeit:** System durchläuft Usability-Test mit 10+ Nutzern, Feedback integriert

#### **12. Risiken und Annahmen**

**Bekannte Risiken:**
- **R1 – Scope Creep:** Stakeholder-Anforderungen Steigen während Umsetzung (Wahrscheinlichkeit: Mittel | Impact: Hoch) → Mitigation: Strikte Change Control ab M1
- **R2 – Integration Komplexität:** SAP HR Integration dauert länger als geplant (Wahrscheinlichkeit: Mittel | Impact: Hoch) → Mitigation: Frühe Proof-of-Concept (PoC) mit SAP-Partner
- **R3 – Trainer-Widerstand:** Personengruppe „Trainer" sieht E-Learning als Bedrohung (Wahrscheinlichkeit: Mittel | Impact: Mittel) → Mitigation: Frühzeitige Kommunikation, Rollendefinition (Trainer → Kursentwickler)
- **R4 – Ressourcen-Mangel:** Key-Stakeholder (IT, HR) haben parallel andere Prioritäten (Wahrscheinlichkeit: Hoch | Impact: Hoch) → Mitigation: Ressourcen-Reservierung ab Projektstart, ggf. externe Unterstützung

**Annahmen (Voraussetzungen):**
- Budget in Höhe von 200.000 EUR ist verfügbar und genehmigt (Geschäftsjahre 2025)
- SAP HR System ist stabil und für Integration verfügbar
- Mindestens 800 Mitarbeiter nutzen aktiv Corporate-E-Mail und haben Zugang zu PC/Mobile
- Betriebsrat erteilt Freigabe ohne grundlegende Einwände (Datenschutz, Arbeitsplatz)
- Go-Live bis 30.09.2025 ist für Geschäftsziele kritisch (Q3-Abschluss/Berichterstellung möglich)

#### **13. Stakeholder und Engagement-Strategie**
| **Stakeholder** | **Interesse/Macht** | **Kommunikationsstrategie** |
|---|---|---|
| Geschäftsführung (Sponsor) | Hoch/Hoch | Monatliche Steering-Committee-Treffen (1h), Executive-Dashboard wöchentlich per E-Mail, Eskalationswege klar definiert |
| Betriebsrat | Mittel/Mittel | Alle 2 Wochen Info-Termin, Mitgestaltung bei Datenschutz & Arbeitsplatzfragen, Vorabaustausch zu Mitarbeiterkommunikation |
| HR-Team (L&D) | Hoch/Hoch | Wöchentliche Jour Fixe, Detailinformationen zu Anforderungsfortschritt, Freigabe von Zwischenständen |
| IT-Betriebsteam | Mittel/Mittel | Alle 2 Wochen technisches Update, Frühzeitig in Infrastructure-Planning einbinden, Training vor Go-Live |
| Trainer / Instruktoren | Mittel/Niedrig | Monatliche Updates, Workshop zu „Zukunftsrolle Trainer → Content Developer", Involvierung in Pilot-Training |
| Endnutzer (Masse: 800 Mitarbeiter) | Hoch/Niedrig | Kampagne: „Was ist E-Learning und warum?", Monatl. Intranet-Newsletter, Testimonials von Early Adoptern, FAQ online, Support-Hotline |

#### **14. Freigaben und Unterschriften**

| **Rolle** | **Name** | **Unterschrift** | **Datum** |
|---|---|---|---|
| Auftraggeber / Sponsor | Dr. Eva Mueller (Vorstand HR) | ______________ | 15.01.2025 |
| Projektmanager | Max Mustermann | ______________ | 15.01.2025 |
| Fachlicher Leiter | Sandra Schmidt | ______________ | 15.01.2025 |

---

> **Kommentar zum Charter-Beispiel:**  
> Dieser Charter ist **realistisch und praxisorientiert** gestaltet:
> - **Konkrete Ziele:** SMART-Ziele statt Worthülsen
> - **Klare Abgrenzung:** Was ist raus (Content, Legacy, Phase 2) – verhindert später Diskussionen
> - **Risiken benannt:** Sponsor kennt die Kritikalität, kann früh mitsteuern
> - **Engagement-Strategie:** Je Stakeholder ein konkreter Plan, nicht generisch
> - **Budgets realistisch:** Typische Kostenkategorien aufgeschlüsselt, 5% Puffer (nicht 20%)  
> **Häufige Charter-Fehler (hier vermieden):**
> - ❌ Zu vage Ziele ("Projekt erfolgreich abschließen")
> - ✓ Stattdessen: KPIs mit Messgröße und Zeitrahmen
> - ❌ Charter zu lang (20+ Seiten) → ignoriert
> - ✓ Stattdessen: 2–3 Seiten (dieses Beispiel ist noch kompakt)
> - ❌ Keine Unterschriften / Freigabe → Charter nicht bindend
> - ✓ Stattdessen: Klare Approval-Sektion mit Daten

---

## Aufgabe 5: Praxisvignette – Stakeholder-Konflikt – LÖSUNGEN

### 5.1 Szenario und Konflikt-Erkennung

**Szenario (zur Erinnerung):**  
Im Initiierungsworkshop des E-Learning-Projekts offenbaren sich Konflikte:
- Der **IT-Leiter** verlangt ein individuell entwickeltes System
- Der **Geschäftsführer/Sponsor** fordert eine Fertiglösung
- Die **Fachverantwortliche HR** benötigt spezifische Reporting-Features
- Das **Projektteam** hat Ressourcenmangel für eine Individuallösung

---

### 5.1.1 Zugrundeliegende Interessens-Konflikte

**IT-Leiter – Motivationen & Ängste:**

```
Öffentliche Position: "Wir müssen eine Custom-Lösung entwickeln, um Full Control zu haben 
und mit unseren bestehenden Systemen perfekt zu integrieren."

Dahinter stecken wahrscheinlich:
- Fachliche Sorge: „Fertig-Plattformen sind oft zu generisch, 
  passen nicht zu unserer SAP-Landschaft"
- Macht-Sorge: „Wenn wir eine externe SaaS-Lösung nehmen, verlieren 
  wir Kontrolle über die Technologie"
- Ressourcen-Angst: „Wenn wir Custom entwickeln, sind meine Entwickler 
  beschäftigt + rechtfertigen ihre Positionen"
- Sicherheits-Bedenken: „Externe Cloud-Anbieter = Sicherheitsrisiko, 
  eigene Lösung on-prem ist sicherer"

Reale Motivation: Kontrolle, Jobsicherheit, Vermeidung externer Abhängigkeiten
```

**Sponsor / Geschäftsführer – Motivationen:**

```
Öffentliche Position: "Wir brauchen schnell eine wirtschaftliche Lösung. 
Fertiglösung in 6 Monaten, Custom-Entwicklung dauert 18+ Monate."

Dahinter stecken:
- Business-Druck: „Kostenreduktion ist strategisches Ziel (30% Einsparung), 
  brauche schnell ROI"
- Zeit-Druck: „Q3 2025 ist das Geschäftsjahr-Ende, muss zeigen, 
  dass Initiative vorangeht"
- Budget-Druck: „200k EUR ist bereits genehmigt, nicht 500k+ für Custom-Dev"
- Risiko-Aversion: „Custom = Überraschungskosten, Verzögerungen. 
  Fertiglösung = kalkulierbar"

Reale Motivation: Geschwindigkeit, Kostenoptimierung, berechenbare Risiken
```

**HR-Verantwortliche – Motivationen:**

```
Öffentliche Position: "Wir benötigen ein System, das spezifische HR-Analytics 
(Learning Outcome, Competency Mapping, Succession Planning) unterstützt."

Dahinter stecken:
- Fachliche Anforderung: „Ohne Learning Analytics kann ich nicht nachweisen, 
  dass Schulungen funktionieren"
- Kontrolle: „Ich brauche Daten, um HR-Effektivität zu zeigen"
- Fach-Autonomie: „HR braucht ein System, das HR-Anforderungen abbildet, 
  nicht was IT für gut hält"
- Befürchtung: „Wenn IT wählt, bekommen wir eine IT-getriebene, nicht 
  HR-getriebene Lösung"

Reale Motivation: Daten-Souveränität, Fachkompetenz-Anerkennung
```

**Projektteam – Realitäten:**

```
Öffentliche Position: „Wir haben keine Ressourcen für Custom-Entwicklung 
bei diesem Zeitrahmen."

Dahinter stecken:
- Ressourcen-Realität: 2 Entwickler verfügbar, 6-Monat-Frist → unmöglich
- Qualitäts-Sorge: „Wenn wir hetzen, wird Code schlecht, später Probleme"
- Fachkompetenz: „Unsere Entwickler kennen E-Learning-Spezifika nicht"
- Existenzielle Sorge: „Wenn das Projekt scheitert, sind wir schuld"

Reale Motivation: Realistische Machbarkeit, Qualitätsstandards, Jobsicherheit
```

---

### 5.1.2 Kompromissvorschlag – Trade-off-Analyse

```
LÖSUNGSVORSCHLAG – "Best of Both Worlds":

1. KAUF einer etablierten E-Learning-Plattform (Fertiglösung, schnell)
   Beispiele: Cornerstone OnDemand, SAP SuccessFactors Learning, Docebo
   → Erfüllt Sponsor-Anforderungen: schnell, kalkulierbar, wirtschaftlich

2. CUSTOM-INTEGRATION & ERWEITERUNG durch IT
   - Entwicklung von Custom Connectors zu SAP HR + bestehenden Systemen
   - Development von spezifischen HR-Analytics-Dashboards (API-basiert)
   - Automatisierung von Datenflüssen (Compliance-Reporting)
   → Erfüllt IT-Anforderung nach Integration + HR-Anforderung nach Analytics
   → Begrenzt (18–20% Budget), aber strategisch wichtig

3. IMPLEMENTATION mit Change Management
   - IT implementiert nicht allein, sondern mit HR-Fachabteilung
   - HR-Team wird "Business Owner" der Plattform
   → Erfüllt HR-Autonomie und IT-Kontrolle (Mitsprache)

4. PHASED APPROACH
   - Phase 1 (Sept 2025): Fertiglösung Go-Live mit 80% Anforderungen
   - Phase 2 (Dez 2025): Custom-Erweiterungen (Advanced Analytics)
   → Erfüllt Sponsor (schneller Quick Win) + IT (Zeit für Quality)
   → Erfüllt Projektteam (Ressourcenplanung realistisch)

BUDGET-AUFTEILUNG:
- Software + Base-Implementation: 130k EUR (Buy)
- Custom Connectors + Analytics: 40k EUR (Build)
- Training, Projektmanagement: 30k EUR
= 200k EUR (im Budget!)
```

**Begründung des Kompromisses:**

| **Stakeholder** | **Ursprüngliche Forderung** | **Im Kompromiss** | **Gewinn für Stakeholder** |
|---|---|---|---|
| **IT-Leiter** | Custom-Entwicklung 100% | Custom-Integration 20% + Architektur-Rolle | Hat IT-Kontrolle über Integrationen, Jobsicherheit, saubere Architektur |
| **Sponsor** | Fertiglösung 100%, 200k EUR | Fertiglösung 80% + Phasing | Go-Live 30.09. erreicht, ROI beginnt Q4 2025, Budget hält |
| **HR-Verantwortliche** | Custom-Analytics | Custom-Dashboards (API-basiert) + Reporting-Module | Bekommt Analytics, ist Business-Owner der Lösung, Autonomie gestärkt |
| **Projektteam** | Machbar vs. unmöglich | Phased: realistische Ressourcenplanung | Können mit verfügbaren Ressourcen liefern, Qualität sichern |

---

### 5.1.3 Dokumentation im Project Charter

```
CHARTER-ABSCHNITT: "Implementierungs-Ansatz & Konfliktlösung"

ENTSCHEIDUNG: Buy + Build Hybrid-Ansatz

Begründung:
Im Initiierungs-Workshop wurden Anforderungen aus IT (Systemintegration), 
HR (spezifische Analytics), Geschäft (Wirtschaftlichkeit) und Projektteam 
(Ressourcenrealisierbarkeit) abgewogen. Ein rein Custom-Ansatz war zeitlich 
und budgetär unrealistisch; eine reine Fertiglösung hätte Integrations-Lücken 
gelassen.

Konsens-Lösung:
- Lizenzierung einer Cloud-basierten E-Learning-Plattform (z.B. Cornerstone 
  OnDemand) als Basis-Lösung
- Entwicklung von Custom Connectors zu SAP HR und bestehenden Datenquellen
- Aufbau von Custom-Analytics-Dashboards für spezifische HR-Anforderungen 
  (Learning Outcome, Competency Mapping)
- Phasenweise Umsetzung: Phase 1 (Go-Live 30.09.2025 mit 80% Features), 
  Phase 2 (Dezember 2025: Advanced Analytics)

Verantwortung:
- Vendor-Selektion & Beschaffung: IT-Leiter + Procurement
- Base-Implementierung: System-Integrator (externer Partner) + IT
- Custom Development: IT-Entwicklung + HR-Anforderungs-Spezifikation
- Change Management & Training: HR-Team (Business Owner Rolle)

Eskalations-Pfad bei Konflikten:
Falls Scope/Budget-Abweichungen > 10%, Escalation an Sponsor-Team 
zur Neu-Priorisierung.
```

> **Kommentar zu Konfliktlösung:**  
> Dieses Beispiel zeigt eine **realistische Konfliktsituation**, die in fast jedem Projekt auftritt:  
> - **Nicht alle können 100% bekommen** – es geht um tragfähige Kompromisse
> - **Interesse vs. Position:** Die „Position" ist die laut geforderte Lösung (Custom vs. Fertig); das **Interesse dahinter** ist oft anders (Kontrolle, Jobsicherheit, Geschwindigkeit)
> - **Best-Practice-Konfliktlösung:**  
>   1. Interessen identifizieren (nicht nur auf Positionen fokussieren)
>   2. Kreative Dritte Lösungen finden (nicht nur A oder B, sondern C)
>   3. Trade-offs transparent machen (wer gibt was auf, wer gewinnt was)
>   4. Im Charter dokumentieren (damit es später verbindlich ist, nicht wieder neu verhandelt wird)

---

## Aufgabe 6: Reflexions- und Vertiefungsfragen – LÖSUNGEN

### 6.1 Verständnisfragen

#### 1. Warum ist die Stakeholder-Analyse so wichtig in der Initiierungsphase?

**Erwartete Antwort:**

Die Stakeholder-Analyse ist **essentiell**, weil:

- **Risiko minimieren:** Übersehene Stakeholder (z. B. Betriebsrat, Compliance) tauchen später auf und können das Projekt blockieren
- **Requirements sammeln:** Verschiedene Stakeholder haben verschiedene Anforderungen. Wer redet nicht mit, hat Anforderungen, die zu spät bekannt werden → Rework
- **Konflikte früh erkennen:** Konflikte zwischen Anforderungen (z. B. Geschwindigkeit vs. Custom-Anforderungen) sind leichter zu lösen, wenn Stakeholder zusammensitzen
- **Engagement & Akzeptanz:** Projekte scheitern oft nicht an Technik, sondern an **Mensch & Widerstand**. Frühe Einbindung reduziert Widerstand
- **Scope-Control:** Klare Stakeholder-Definition hilft, Scope-Creep zu bremsen (wer darf noch Anforderungen reinbringen? Wer nicht?)
- **Realistische Planung:** Stakeholder-Input hilft realistischere Zeitpläne, Budgets, Anforderungen zu planen

**Typisches Gegenbeispiel (was schiefgeht):**  
Projekt ohne gute Stakeholder-Analyse: IT entwickelt ein System, denkt, es ist super. Bei Abnahme durch Nutzer: "Das ist überhaupt nicht das, was wir brauchen!" → 6 Monate Rework, Budget überschritten.

---

#### 2. Welche Fehler entstehen häufig, wenn der Scope nicht klar definiert ist?

**Erwartete Antwort:**

Ohne klarer Scope-Definition entstehen typischerweise folgende Fehler:

| **Fehler** | **Folge** | **Beispiel** |
|---|---|---|
| **Scope Creep** (ständig neue Anforderungen) | Budget und Zeit explodieren | "Können wir nicht auch noch Kurse für Kunden einbauen?" (war nicht im Plan) → +30k EUR, +2 Monate |
| **Gold-Plating** (Mehr liefern als vereinbart) | Wasted Resources, späte Lieferung | Entwickler baut tolle Extra-Features, die keiner fragte → Zeit weg |
| **Missverständnisse bei Abnahme** | Kunde nimmt ab "aber das ist nicht das, was ich wollte" | "Kursmaterial erstellen" – PM dachte nur Strukturen, Kunde erwartet volle Inhalte |
| **Unklare Verantwortung** | Streit über „gehört zu meinem Projekt oder nicht?" | "Sollte die Support-Schulung in Modul 1 oder später sein?" – unbegrenzte Diskussion |
| **Überraschungen spät im Projekt** | Rework, Verzögerung, Budget-Überschreitung | Erst bei UAT: "Wir brauchen Mehrsprachigkeit!" (hätte geplant werden müssen) |
| **Unklare Abgrenzungen** | Projekt wird zum Fass ohne Boden | "Was gehört zum Projekt, was zum Business-as-usual?" – ständiges Grenzziehen |

**Worst-Case Szenario:**  
Projekt wird initiiert mit „Scope: E-Learning-Plattform einführen". Nach 2 Monaten ist unklar: gehört Content-Erstellung dazu? Gehört Betrieb dazu? Gehört Legacy-System-Abbau dazu? → Team verbringt Zeit mit Diskussionen statt mit Umsetzung.

---

#### 3. Wann ist ein Project Charter „gut" – welche Kriterien?

**Erwartete Antwort:**

Ein **guter Project Charter** ist:

| **Kriterium** | **Beschreibung** |
|---|---|
| **Klar & Konkret** | SMART-Ziele, nicht vage Ziele wie "erfolgreich durchführen". Messgröße und Zeitrahmen sind definiert |
| **Stakeholder-validiert** | Charter wurde mit wichtigen Stakeholdern abgestimmt (Sponsor, Key-Team, ggf. Betriebsrat). Nicht top-down ohne Feedback |
| **Realistisch** | Ziele, Budget, Zeit sind erreichbar mit verfügbaren Ressourcen. Nicht "Wir brauchen 10 Entwickler, haben aber 2" |
| **Autorisierend** | Sponsor / Auftraggeber hat unterschrieben. Charter ist nicht nur ein Dokument, sondern ein Vertrag |
| **Abgrenzungen klar** | Scope definiert nicht nur WAS rein, sondern auch klar WAS NICHT rein (Abgrenzungen) |
| **Risiken erkannt** | Bekannte Risiken sind benannt, nicht unter den Tisch gekehrt. Mitigation-Strategien skizziert |
| **Prägnant** | Charter ist 2–3 Seiten, nicht 20 Seiten. Daher auch lesbar und gelebt von Stakeholdern |
| **Erfolgskriterien messbar** | Nicht "System läuft gut", sondern "Verfügbarkeit ≥99%, Response Time ≤3 Sek., DAU ≥500" |
| **Engagement-Strategie konkret** | Nicht generisch "Regelmäßige Kommunikation", sondern spezifisch "Monatliche Jour Fixe mit Sponsor, Wöchentliche Status mit Team" |

**Selbsttest:** Nach Charter-Lesen sollte jeder Stakeholder diese Fragen klar beantworten können:
- ✓ Was ist das Projektziel? (SMART)
- ✓ Wann ist es fertig?
- ✓ Wie hoch ist das Budget?
- ✓ Was gehört rein, was nicht?
- ✓ Welche Risiken gibt es?
- ✓ Wer ist der Sponsor?  
Wenn ja → guter Charter.

---

### 6.2 Anwendungsfragen

#### 4. Stellen Sie sich vor, ein wichtiger Stakeholder (z. B. Personalrat) wird erst in Woche 3 aufmerksam auf das Projekt. Wie würde das die Initiierung gefährden, und wie können Sie das in Zukunft verhindern?

**Erwartete Antwort – Gefahr:**

Wenn der **Personalrat erst in Woche 3** mitbekommt:
- **Rechtliche Blockade:** Personalrat hat Mitbestimmungsrecht (Arbeitsgesetze). Falls nicht früh eingebunden, kann er Projekt stoppen oder verzögern (Einspruchsrecht)
- **Vertrauens-Erosion:** "Warum wurden wir nicht gefragt?" → Blockade-Haltung, Widerstand, Gegenforderungen
- **Anforderungs-Überraschungen:** "Wir brauchen Datenschutz-Audit" (hätte geplant werden müssen) → Verzögerung
- **Rework:** Wenn Design schon fertig und Personalrat sagt "nicht mit uns!", muss neu geplant werden
- **Vertrauensverlust** zwischen Management und Arbeitnehmern

**Typische Folge:**  
Charter steht, Umsetzung beginnt, Woche 3 taucht Personalrat auf: "Das geht nicht ohne uns!" → Projekt wird zu 4 Wochen verzögert, Anforderungen müssen überarbeitet werden.

**Prävention – Wie das vermeiden:**

1. **In der Stakeholder-Identifikation:** Checklist verwenden "Wer hat Mitbestimmungsrecht? Gewerkschaften, Betriebsrat, Personalrat?" – nicht vergessen!
2. **Frühe Einbindung (spätestens vor Charter-Freigabe):** Personalrat in Initiierungs-Workshop laden, seine Bedenken hören, Anforderungen sammeln
3. **Transparenz statt Überraschung:** Information vorab über Ziele, Zeitrahmen, Datenschutz, Auswirkungen auf Arbeitsbedingungen
4. **Mitgestaltungs-Gelegenheiten:** "Was sind Ihre Bedenken? Was brauchen Sie?" → nicht als Blockade-Falle, sondern echte Beteiligung
5. **Dokumentation:** Personalrat-Anforderungen in Charter aufnehmen, damit es bindend ist
6. **Regelmäßige Updates:** Nicht nur beim Start, sondern laufend informieren (verhindert böse Überraschungen später)

**Best Practice:**  
Im E-Learning-Beispiel: Personalrat frühzeitig einbinden, gemeinsam Anforderungen zu Datenschutz & Transparenz klären, dann im Charter festhalten ("Alle Lernaktivitäten werden nur mit Zustimmung der Arbeitnehmenden aufgezeichnet").

---

#### 5. Sie bemerken, dass mehrere Anforderungen unrealistisch sind (zu teuer, zu wenig Zeit). Wie handhaben Sie das im Charter?

**Erwartete Antwort – Strategie:**

Wenn Sie **unrealistische Anforderungen** erkennen:

**Option 1: Klar kommunizieren – Die Realität aufzeigen**
```
Beispiel: Sponsor sagt "Wir wollen ein Custom-System in 3 Monaten 
für 100k EUR entwickelt haben"

PM antwortet: 
"Das ist nicht realistisch. Custom-E-Learning-Projekte 
benötigen typischerweise 6-9 Monate und 300-500k EUR für Qualität. 
Wir könnten aber:
- Option A: Fertiglösung in 6 Monaten für 200k EUR
- Option B: Custom-MVP (minimal viable product) in 3 Monaten für 100k EUR, 
  mit Phase 2 für erweiterte Features
- Option C: Hybrid-Ansatz (Buy + kleine Custom-Teile) in 6 Monaten für 150k EUR

Was ist das Geschäfts-Ziel dahinter? Dann können wir realistische Lösung 
suchen."
```

**Option 2: Priorisierung mit MoSCoW**
- **Must-have:** Ohne diese Features ist das Projekt sinnlos (z. B. Basic Learning-Funktionen, Integration HR-System)
- **Should-have:** Wichtig, aber nicht kritisch (z. B. Mobile-App, Advanced Analytics)
- **Could-have:** Nett zu haben, aber weniger wichtig (z. B. Gamification, Multiple Languages)
- **Won't-have (diesmal):** Bewusst verschoben auf Phase 2 (z. B. Zertifikat-Modul, Kundentraining)

Ergebnis: Must + Should passt ins Budget, Could + Won't-have = Phase 2 oder gar nicht

**Option 3: Trade-Offs aufzeigen**
```
Geschäftsforderung: "Alles fertig bis 30.06.2025, alle Features, 150k EUR Budget"

Realität: Das geht nur mit einem Trade-Off. Wählen Sie:
1. Zeitrahmen verkürzen (bis 30.06.) + Scope reduzieren (nur Must-Haves)
2. Zeitrahmen verlängern (bis 30.09.) + vollständiger Scope + Budget 200k EUR
3. Budget erhöhen (200k EUR) + Scope reduzieren + alles bis 30.06.

Sie wählen: _______
```

**Im Charter dokumentieren:**
```
CHARTER-ABSCHNITT: "Aktualisierte Anforderungen & Trade-Offs"

Ursprüngliche Forderung:
- Fertig bis 30.06.2025
- Alle geplanten Features
- Budget 150k EUR

Realistische Bewertung (mit 3 Szenarien durchgesprochen):
Ergebnis: Projekt braucht entweder +2 Monate ODER +50k EUR Budget ODER -20% Features

Konsens-Entscheidung (mit Sponsor):
✓ Zeitrahmen verlängert bis 30.09.2025
✓ Budget erhöht auf 200k EUR (+ Scope-Risiken reduzieren)
✓ Mit diesem Budget & Zeitrahmen: 80% der ursprünglichen Features 
  in Phase 1 möglich, 20% in Phase 2 (Q4 2025)

Unterschrift Sponsor (akzeptiert die Realität):
Dr. Mueller: ________________ Datum: 15.01.2025
```

> **Kommentar:**  
> Dies ist die **wichtigste Fähigkeit eines guten PMs**: **Realistische Grounding vor optimistischem Wishing.** Ein guter PM sagt früh "Das geht nicht!" – nicht in Woche 10, wenn schon 6 Wochen Ressourcen gebrannt wurden.  
> **Häufiger PM-Fehler:** Sponsor möchte 100%, Budget 150k, Zeit 3 Monate. PM sagt "ok, wir versuchen es" – scheitert 2 Monate später. Stattdessen: **Früh klar sagen "Das kann nicht gut gehen, hier sind realistische Optionen".**