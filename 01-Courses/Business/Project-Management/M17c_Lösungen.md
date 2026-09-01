## Aufgabe 1: Agile Werte und Prinzipien anwenden

### 1.1 Werte-Zuordnung – Lösung

**Szenario Recap**: Stakeholder verlangt wöchentlich 50-Seiten-Statusbericht, Team verbringt täglich 1–2 Stunden dafür.

**Lösung**:

| Agiler Wert | Wird verletzt? | Handlung im agilen Projekt |
|-------------|---|---|
| **Individuen und Interaktionen** | ✓ **ja** | Statt Bericht: Wöchentliches Jour Fixe (15 Min) mit Stakeholder |
| **Funktionierende Software** | ✓ **ja** | Team-Kapazität für echte Arbeit statt Reporterei freigeben |
| **Kundenzusammenarbeit** | ✗ nein | (Kunde ist präsent, aber falsches Format) |
| **Reagieren auf Veränderung** | ✗ nein | (Nicht direkt verletzt, aber unflexibel) |

**Handlungsvorschlag im agilen Projekt**:

Das agile Team würde sagen: "Wir brauchen **20 Stunden pro Sprint für einen Report, die Ihnen weniger bringt als direkte Gespräche**. Alternative: Wir treffen uns **freitags 10:00 Uhr 20 Minuten**, Sie sehen das **Agile Board live** und wir demonstrieren die **fertiggestellten Features**. Sie haben sofort Einsicht und können Feedback geben. Das spart Zeit und wir code schneller."

> **Kommentar**: Das ist ein klassischer Fehler in traditionellen Projekten – **Overhead-Dokumentation**, die wenig Wert schafft. Agile Methoden reduzieren solche Verschwendung. Der **Wert liegt in funktionieller Software und direktem Feedback**, nicht in Berichten.

---

### 1.2 Prinzipien-Matching – Lösung

**Situation A**: Kunde möchte nach Woche 8 von 12 neue Features.

**Anwendbares Prinzip**: **"Änderungen sind willkommen, auch spät in der Entwicklung"**

**Begründung**: Das ist genau der Kerngedanke agiler Methoden. Klassische Projekte sagen "Nein, das ist außerhalb des Scope." Agil sagen wir: "Ok, lass mich die Prioritäten neu ordnen und einplanen." Durch regelmäßige Sprints und Product-Backlog-Verwaltung ist das möglich.

> **Kommentar**: Wichtig ist allerdings zu unterscheiden: Sind die neuen Features **echte neue Anforderungen** oder **versteckte ursprüngliche Anforderungen**? Im zweiten Fall liegt eventuell eine Anforderungs-Mängel vor. Trotzdem bleibt das Agile Manifest flexibel.

---

**Situation B**: Daily Standups dauern 45 Minuten, wenig Fokus.

**Anwendbares Prinzip**: **"Technische Exzellenz und guter Design verbessert die Agilität"** / oder **"Einfachheit – maximiere die Menge nicht geleisteter Arbeit"**

**Begründung**: Eine 45-minütige Koordinationssitzung ist **Verschwendung** (Muda in Lean-Sprache). Der Standup soll 15 Minuten sein und nur Synchronisierung, nicht Problemlösung. Der Scrum Master muss eingreifen: "Wir halten uns an 15 Minuten, höchstens 3 Sätze pro Person."

> **Kommentar**: Das ist ein häufiger Fehler – Standups degenerieren zu "Status-Meetings". Wenn es länger als 15 Min dauert, ist das ein **Symptom eines größeren Problems** (zu große User Stories, zu viele Abhängigkeiten, schlechte Kommunikation). Der SM sollte das adressieren.

---

## Aufgabe 2: Scrum-Rollen und Verantwortlichkeiten

### 2.1 Rollen-Zuordnung – Lösung

| Aufgabe | Verantwortlich | Begründung |
|---|---|---|
| **Sprint Planning durchführen** | **Scrum Master** (Moderation) mit **PO + Dev Team** (Inhalte) | Der SM moderiert, PO bringt Anforderungen, Team verhandelt Machbarkeit |
| **Impedimente (Blockaden) eskalieren** | **Scrum Master** (primär) | Der SM ist dafür da, Blockaden zu erkennen und zu beseitigen oder zu eskalieren |
| **Product Backlog priorisieren** | **Product Owner** (allein verantwortlich) | PO entscheidet, was wann entwickelt wird (Geschäftswert) |
| **Selbstorganisation des Teams unterstützen** | **Scrum Master** (Coach) | Der SM befähigt das Team, selbst Entscheidungen zu treffen, statt sie zu treffen |
| **Akzeptanzkriterien definieren** | **Product Owner** | Der PO definiert, wann eine Story "fertig" ist (Qualitätsanspruch) |
| **Sprint Review mit Stakeholdern durchführen** | **Product Owner** (primär), **Team** präsentiert | Der PO lädt ein, moderiert; Team zeigt die Arbeit |
| **Code-Quality sichern** | **Development Team** (gemeinsam verantwortlich) | Das Team ist autonom für Qualität; Codereviews, Tests, Standards sind Team-Verantwortung |

> **Kommentar**: Häufiger Fehler: Der **Scrum Master wird als "Projektleiter" interpretiert**, der Aufgaben verteilt. Falsch! Der SM ist ein **Coach und Prozess-Guardian**. Die Entscheidungsgewalt liegt bei PO (Was?) und Team (Wie?).

---

### 2.2 Fallstudie: Ein Rollen-Konflikt – Lösung

**Szenario**: Scrum Master (= auch Entwickler) sitzt beim Sprint Planning. PO sagt kategorisch: "Diese Story muss ins Sprint." SM widerspricht: "Zu viel Arbeit."

**Was läuft hier falsch?**

1. **Rollen-Vermischung**: Der SM sitzt "im Team", kann aber auch nicht neutral moderieren. Er hat eine persönliche Meinung ("zu viel Arbeit").
2. **PO-Übergriff**: Der PO darf nicht einseitig entscheiden; das ist kein Diktat, sondern ein **Verhandlung**.
3. **Falsche Eskalation**: Statt zu debattieren, sollte der SM einen strukturierten Dialog führen.

**Wer sollte die Entscheidung treffen?**

**Das Team als Ganzes** zusammen mit dem PO:
- PO: "Diese Story hat höchsten Geschäftswert."
- Team: "Wenn wir diese Story machen, müssen wir Story X verschieben. Ok?"
- PO: "Ja" oder "Nein, dann verschieben Sie Story Y stattdessen."

**Was hätte der Scrum Master besser machen sollen?**

> **Besserer Dialog**:
> - SM: "Ich höre einen Konflikt. Lass mich moderieren. PO: Warum ist diese Story so kritisch? Team: Warum seht ihr die Kapazität angespannt?"
> - (Nach Diskussion): "Wir haben 20 Story Points Kapazität. Diese Story ist 8 SP. Wenn wir sie nehmen, müssen wir Story X (5 SP) verschieben. Passt das für euch beide?"
> - Alignment durch Transparenz, nicht durch Machtspiele.

> **Kommentar**: Der SM ist der **Hüter des Prozesses**, nicht der Hüter der Workload. Er sorgt dafür, dass **alle Parteien transparent** miteinander reden.

---

## Aufgabe 3: Sprint Planning durchführen – Lösung

### 3.1 Szenario: Online-Shop, Sprint 1

**Gegeben**: Team-Velocity = 20 Story Points/Sprint

**Optimale Auswahl für Sprint 1**:

| Priorität | User Story | SP | Summe | Auswahl? |
|----------|-----------|----|----|---|
| 1 | Produkte durchsuchen | 8 | 8 | ✓ Ja |
| 2 | Warenkorb | 5 | 13 | ✓ Ja |
| 5 | Passwort zurücksetzen | 3 | 16 | ✓ Ja |
| 8 | Passwort-Verschlüsselung (Tech) | 5 | 21 | ✗ Nein (zu viel) |

**Sprint 1 Backlog** (insgesamt 16 SP, passt in Kapazität von 20):

```
✓ Story 1: Produkte durchsuchen (8 SP)
✓ Story 2: Warenkorb (5 SP)
✓ Story 5: Passwort zurücksetzen (3 SP)
```

**Alternative**: Wenn die Tech-Schuld (Verschlüsselung) kritisch für Sicherheit ist:

```
✓ Story 1: Produkte durchsuchen (8 SP)
✓ Story 2: Warenkorb (5 SP)
✓ Story 8: Passwort-Verschlüsselung (5 SP)
= 18 SP (noch im Rahmen)
```

Dann wird Story 5 verschoben oder zusammen mit Story 3 (Bezahlen) gemacht, da Passwort für Bezahlen nötig ist.

**Sprint Goal (Sprintziel)**:

> **Option 1** (Feature-fokussiert):
> "Benutzer können Produkte suchen, in den Warenkorb legen und Passwörter verwalten – erste Grundfunktion des Shops nutzbar."

> **Option 2** (Sicherheits-fokussiert):
> "Sichere und funktionsfähige Basis aufbauen: Produktsuche + Warenkorb + sichere Passwort-Verwaltung."

> **Kommentar**: Das Sprintziel sollte **inspirierend** sein und dem Team eine **Richtung** geben, nicht nur eine Ansammlung von Features sein.

**Definition of Done (DoD)** für diese Stories:

```
✓ Code geschrieben und in Code-Review freigegeben
✓ Unit Tests geschrieben, >80% Code-Coverage
✓ Integration Tests durchgeführt
✓ In Staging-Umgebung deployiert und getestet
✓ Keine kritischen Security-Issues
✓ Passwort-Verschlüsselung mit bcrypt oder Äquivalent
✓ User Story dokumentiert (README/Wiki)
✓ Akzeptanzkriterien erfüllt und von PO signiert
```

> **Kommentar**: DoD muss **realistisch** sein. "100% Coverage + Dokumentation + Performance-Tests" ist zu viel für Sprint 1. DoD wächst mit Team-Reife.

---

## Aufgabe 4: Daily Standup – Ein Skript – Lösung

**Szenario Recap**: Tom berichtet ausschweifend von einem DB-Bug, ist komplett blockiert, weiß nicht, was tun, Architektur-Fragen.

### 4.1 Dauer und Format

**Wie lang sollte Toms Antwort sein?**

**Zu lang!** Tom sollte **maximal 90 Sekunden sprechen** (3 Sätze):

> **Besser so**:
> 
> "Gestern habe ich die Anmeldungs-Validierung fertig gemacht. Heute arbeite ich am Passwort-Hash. Ich bin aktuell blockiert auf das DB-Encryption-Feature, das der DBA in 2 Tagen liefert – ich warte drauf."

**Bessere Antwort des SM**: "Danke Tom. Ich kümmere mich um den DBA-Status und frage, ob Du einen workaround starten kannst. Nach dem Standup besprechen wir das."

### 4.2 Was sollte der Scrum Master tun?

Der SM sollte **nach dem Standup** (nicht im Standup):
1. Mit dem DBA klären, wann die Lösung kommt
2. Mit Tom alternative Aufgaben finden (andere Story vorziehen, andere Teams helfen, Tech-Schuld bearbeiten)
3. Im nächsten Standup: "Blockade gelöst: DBA liefert heute 14 Uhr"

### 4.3 Was sollte Tom besser formulieren?

**Korrekte Standup-Antwort**:

| Frage | Tom sollte sagen | NICHT sagen |
|---|---|---|
| **Was habe ich gestern getan?** | "Anmeldungs-Validierung fertiggestellt" | "Ich habe viel an der Anmeldung gearbeitet, bin aber auf Probleme gestoßen..." |
| **Was arbeite ich heute daran?** | "Passwort-Hashing" | "Ich weiß nicht, was ich tun soll, weil ich blockiert bin..." |
| **Bin ich blockiert?** | "JA – warte auf DB-Fix vom DBA, ~2 Tage" | "Der DBA ist langsam, und ich weiß nicht, ob unsere Architektur skaliert..." |

> **Kommentar**: Der Standup ist **nicht der Ort für Problemlösung oder Architektur-Diskussionen**. Das macht den Standup ineffizient. Probleme werden danach mit Beteiligten geklärt.

---

## Aufgabe 5: Definition of Done (DoD) für Ihr Team – Lösung

**Szenario**: Web-Entwicklung (React, Node.js, PostgreSQL)

### Definition of Done – Musterlösung

| # | Checkpoint | Details |
|---|-----------|---------|
| 1 | **Code geschrieben** | Alle akzeptierten Anforderungen implementiert |
| 2 | **Code Review** | Mindestens eine andere Person hat Code reviewed und genehmigt |
| 3 | **Linting & Format** | ESLint/Prettier-Checks bestanden, keine Warnungen |
| 4 | **Unit Tests** | Tests geschrieben für neue Funktionen, >80% Code-Coverage |
| 5 | **Integration Tests** | Wenn APIs/DB betroffen, Integration-Tests vorhanden |
| 6 | **Manuelles Testing** | In Staging-Umgebung getestet, Akzeptanzkriterien erfüllt |
| 7 | **Datenbank-Migration** | Wenn DB-Änderungen: Migrations-Scripts vorhanden und getestet |
| 8 | **Sicherheit** | Kein hardcodiertes Secrets, Input-Validierung, CORS-Check |
| 9 | **Dokumentation** | README/API-Doku aktualisiert, Code-Kommentare wo nötig |
| 10 | **Performance** | Keine neuen N+1-Queries, Response-Zeit <500ms |
| 11 | **Deploy-Readiness** | Feature-Flag gesetzt (wenn nötig), Rollback-Plan vorhanden |
| 12 | **PO Signoff** | Product Owner hat die Story im Staging akzeptiert |

> **Kommentar**: Diese DoD ist für ein **reifes Team** mit etablierter Qualitäts-Kultur. Im ersten Sprint könnte die DoD einfacher sein:
> - [ ] Code geschrieben
> - [ ] Unit Tests vorhanden
> - [ ] In Staging, funktioniert
> - [ ] PO akzeptiert
> 
> Die DoD **wächst mit dem Team** über mehrere Sprints.

---

## Aufgabe 6: Kanban Board und WIP-Limits – Lösung

### 6.1 Board-Design für Support-Team

**Szenario**: 50–100 Support-Tickets/Woche, Tickets kommen jederzeit herein (Kanban bessser als Scrum)

**Kanban Board-Design**:

| Spalte | WIP-Limit | Begründung |
|--------|-----------|-----------|
| **Backlog** | ∞ (unbegrenzt) | Alle eingehenden Tickets sammeln, noch nicht priorisiert |
| **To Do** (Priorisiert) | 20 | Tickets die in die nächsten 1–2 Tage gehen, Redakteur hat priorisiert |
| **In Progress** | 5 | Maximal 5 Supporter arbeiten gleichzeitig an Tickets (5 Personen im Team) |
| **In Review** | 3 | Support-Lead checkt Lösung vor Abschluss (wenn komplex) |
| **Done** | ∞ | Tickets sind geschlossen, abgelegt |

**Workflow-Regeln**:
- Ticket geht von Backlog → To Do, wenn ein Supporter verfügbar ist
- Von To Do → In Progress, wenn Supporter aktuelles Ticket abholt
- Von In Progress → In Review, wenn Lösung getestet
- Von In Review → Done, wenn Lead genehmigt

**Engpass-Vermeidung**:
Wenn "In Progress" voll ist (5), darf kein neuer Ticket gestartet werden – Support-Team muss Tickets schneller beenden.

> **Kommentar**: Das ist eine **"Pull-System"**, nicht "Push". Supporter holt sich Tickets, statt ihnen Tickets zuzuweisen. Das reduziert Verwaltungs-Overhead.

---

### 6.2 Engpass-Analyse – Lösung

**Szenario**:
```
To Do: 5 Tickets
In Progress: 3 Tickets
In Review: 15 Tickets  ← ENGPASS!
Done: 12/Woche
```

**Der Engpass ist klar: IN REVIEW mit 15 Tickets**

**Ursachen**:
1. **Zu wenige Reviewer** (Lead ist überlastet)
2. **Zu lange Review-Zeit pro Ticket**
3. **Support-Lead sitzt in zu vielen Meetings**
4. **Komplexe Lösungen, die lange Review brauchen**

**Maßnahmen zur Beseitigung**:

1. **WIP-Limit für "In Review" senken** auf z. B. 3, so merkt man schneller das Problem
2. **Zweiten Reviewer trainieren** oder den Lead delegation mehr
3. **Review-Zeit optimieren**: Schnelle Checks für einfache Tickets, komplexe separat
4. **Ticket-Komplexität reduzieren**: Wenn viele Tickets in Review stecken, sind sie wahrscheinlich zu groß
5. **Lead-Zeit-Ziel setzen**: z. B. "Durchschnittliche Review-Zeit maximal 2 Stunden"

> **Kommentar**: Dies ist ein **typisches Kanban-Szenario**. Die Visualisierung offenbart Engpässe automatisch. Mit klassischem PM würde man das nicht merken, bis der Backlog explodiert.

---

## Aufgabe 7: YouTrack Praktikum – Lösung

### 7.1 Issue-Erstellung in YouTrack

**User Story**: "Als Einkäufer möchte ich Filter nach Lieferanten, um schneller Lieferanten zu vergleichen."

**Lösung**:

```
Titel: 
  Filter für Lieferanten-Vergleich

Beschreibung:
  Als Einkäufer möchte ich Lieferanten nach Kriterien filtern,
  um schneller Lieferanten zu vergleichen und auszuwählen.
  
  Kontext: Derzeit habe ich eine lange Liste (500+ Lieferanten),
  kann aber nicht nach Branche, Standort oder Bewertung filtern.
  Das kostet täglich 1–2 Stunden bei der Lieferanten-Vorauswahl.

Akzeptanzkriterien:
  - [ ] Filter-Widget auf der Lieferanten-Liste angezeigt
  - [ ] Filterbar nach: Branche, Standort, Bewertung (3–5 Sterne)
  - [ ] Multiple Auswahl möglich (z. B. mehrere Branchen)
  - [ ] Filter-Ergebnis zeigt Anzahl der Lieferanten
  - [ ] Filter persistent (bleibt beim Neuladen)
  - [ ] Mobile: Filter im Hamburger-Menu sichtbar

Story Points: 5 (Schätzung)

Labels: Feature, UI, Einkauf, Performance

Assignee: [Frontend-Entwickler Name]

Priority: High

Sprint: Sprint 5 (z.B.)

Linked Issues: (z.B. Related: "Export Lieferanten-Liste")
```

> **Kommentar**: Eine gute User Story in YouTrack sollte **INVEST-Kriterien** erfüllen:
> - **I**ndependent: Kann einzeln entwickelt werden
> - **N**egotiable: Details können diskutiert werden
> - **V**aluable: Hat echten Geschäftswert
> - **E**stimable: Team kann schätzen
> - **S**mall: In einen Sprint passbar
> - **T**estable: Akzeptanzkriterien klar

---

### 7.2 Sprint-Board in YouTrack – Lösung

**Schritte, um einen Sprint zu erstellen und Issues hinzuzufügen**:

1. **Sprint erstellen**:
   - Geh zu "Sprints" (Menü oben)
   - Klick "New Sprint"
   - Gib Namen ein: "Sprint 5"
   - Setze Start-Datum und Enddatum (z. B. 2-Wochen)
   - Sprint-Goal hinzufügen (z. B. "Lieferanten-Verwaltung optimieren")
   - Speichern

2. **Issues zum Sprint hinzufügen**:
   - Öffne die Issue (z. B. "Filter für Lieferanten")
   - In der Detailansicht: Feld "Sprint" = "Sprint 5" wählen
   - (Oder: Im Backlog das Issue auswählen, rechts "Move to Sprint 5")
   - Wiederhole für alle Issues des Sprints

3. **Board anschauen**:
   - Geh zu "Agile Board"
   - Wähle "Sprint 5" aus der Dropdown
   - Sieh das Kanban-Board: To Do | In Progress | In Review | Done
   - Zieh Issues zwischen Spalten (Drag & Drop)

4. **Burndown anschauen**:
   - Im Sprint: Klick auf "Burndown"
   - Chart zeigt verbleibende Story Points pro Tag
   - Falls unter der Ideal-Linie: Sprint ist im Plan
   - Falls darüber: Sprint ist verzögert

> **Kommentar**: YouTrack ist **sehr visuell und intuitiv**. Nach 5 Minuten Verwendung versteht man die Bedienung.

---

## Aufgabe 8: Kanban-Metriken berechnen – Lösung

### 8.1 Lead Time und Cycle Time

**Ticket-Daten**:

| Ticket | Erstellt | Start | Fertig | Lead Time | Cycle Time |
|--------|----------|-------|--------|-----------|-----------|
| T-101 | Mo 08:00 | Mo 10:00 | Mi 14:00 | 58h | 52h |
| T-102 | Di 09:00 | Mi 11:00 | Do 16:00 | 55h | 29h |
| T-103 | Mi 08:00 | Do 09:00 | Fr 11:00 | 51h | 26h |
| T-104 | Do 12:00 | Do 14:00 | Fr 10:00 | 46h | 20h |

**Berechnungen**:

**1. Lead Time für T-101**:
- Erstellt: Montag 08:00
- Fertig: Mittwoch 14:00
- **Lead Time = 2 Tage 6 Stunden = 54 Stunden** (oder knapp 2,25 Tage)

Exakte Rechnung: Von Montag 08:00 bis Mittwoch 14:00 = 58 Stunden

**2. Cycle Time für T-102**:
- Start: Mittwoch 11:00
- Fertig: Donnerstag 16:00
- **Cycle Time = 1 Tag 5 Stunden = 29 Stunden**

**3. Durchschnittliche Cycle Time** (4 fertige Tickets):
- T-101: 52 Stunden = 2,17 Tage
- T-102: 29 Stunden = 1,21 Tage
- T-103: 26 Stunden = 1,08 Tage
- T-104: 20 Stunden = 0,83 Tage

**Ø Cycle Time = (52 + 29 + 26 + 20) / 4 = 127 / 4 = 31,75 Stunden ≈ 1,3 Tage**

**4. Durchsatz pro Tag**:
- Fertiggestellte Tickets diese Woche: 4
- Arbeitstage: 5 (Mo–Fr)
- **Durchsatz = 4 / 5 = 0,8 Tickets pro Tag** (oder 4 Tickets pro Woche)

> **Kommentar**: 
> - **Lead Time (58h)** ist lang, weil das Ticket lange im Backlog saß, bevor es bearbeitet wurde.
> - **Cycle Time (52h)** ist die reine Bearbeitungszeit – das sollte man verkürzen.
> - Der **Durchsatz von 0,8 / Tag** kann man für Forecasts nutzen: "Wenn 50 Tickets im Backlog, brauchen wir 50 / 0,8 ≈ 63 Tage"

---

### 8.2 Burndown-Chart – Lösung

**Gegeben**: 40 Story Points, 10 Arbeitstage (2 Wochen Sprint)

| Tag | Verbleibend | Plan (Ideal) | Ist Trend | Status |
|-----|-----------|------------|---------|---------|
| 1 | 40 | 40 | 40 | Start |
| 2 | 38 | 36 | 38 | Ok |
| 3 | 38 | 32 | 38 | ⚠️ Leicht hinter Plan |
| 4 | 32 | 28 | 32 | ⚠️ Hinter Plan |
| 5 | 30 | 24 | 30 | ⚠️ Hinter Plan |
| 6 | 25 | 20 | 25 | ⚠️ Hinter Plan (aber besser) |
| 7 | 20 | 16 | 20 | ⚠️ Hinter Plan |
| 8 | 18 | 12 | 18 | ⚠️ Hinter Plan |
| 9 | 15 | 8 | 15 | ⚠️ Kritisch hinter Plan |
| 10 | ? | 0 | ? | ?? |

**Burndown-Kurve (Text-Diagramm)**:

```
Story Points
50 |
   |  * ideal
40 |  *---*
   |      \
30 |       *---*
   |           \---*  (Ist-Trend)
20 |               *---*
   |                   \
10 |                    *---*
   |                         \
 0 +---+---+---+---+---+---+---+---+---+---+
   1   2   3   4   5   6   7   8   9  10
       Tage im Sprint
```

**Frage 1: Zeichnung / Verlauf**:
Das Team liegt **konsistent hinter der idealen Linie**. Der Ist-Trend ist eine parallele, aber flachere Kurve. Das bedeutet: Das Team ist **langsamer als geplant**.

**Frage 2: Liegt das Team im Plan?**

**NEIN, das Team ist HINTER PLAN.**
- Tag 1–5: Zu wenig wurde erledigt
- Tag 6–9: Der Trend verbessert sich, aber immer noch Verzögerung
- Bei diesem Tempo wird das Team am Tag 10 nicht alles fertigstellen

**Frage 3: Was sollte am Ende von Tag 10 der Wert sein?**

**Ideal: 0 Story Points** (alle fertig)

Bei aktuellem Trend: Basierend auf Tagen 6–9 scheint das Team ~3–5 SP/Tag zu schaffen. Mit 15 SP übrig und ~3 SP/Tag brauchen sie noch ~5 Tage. Das bedeutet: Am Ende von Tag 10 werden **noch ~0–3 Story Points übrig sein**.

> **Kommentar**:
> - Der SM sollte **spätestens Tag 5** intervenieren: "Wir sind hinter Plan. Braucht das Team Hilfe? Sind die Stories zu groß?"
> - Mögliche Gründe für Verzögerung: Unerwartete Bugs, schlechte Schätzung, zu viele Unterbrechungen, unklare Anforderungen
> - **Reaktion**: Stories vereinfachen, Team unterstützen, oder realistisch kommunizieren: "Wir schaffen nur 30 von 40 SP"

---

## Aufgabe 9: Scrum vs. Kanban – Wahl der Methode – Lösung

| Szenario | Scrum? | Kanban? | Begründung |
|----------|-------|--------|-----------|
| **IT Support 100 Tickets/Woche** | ✗ nein | ✓ ja | Tickets kommen unvorhersehbar, kontinuierlicher Fluss, keine zeitfestgelegten Iterationen nötig |
| **Produktentwicklung neues Feature** | ✓ ja | ✗ nein | Neues Feature = großes Projekt, braucht Planung, Sprint-Struktur, klare Definition of Done, Team-Commitment |
| **Content-Redaktion variable Menge** | ✗ teils / ✓ teils | ✓ ja | Artikel kommen jederzeit, variabel, kontinuierliche Publikation besser als 2-Wochen-Sprints, aber könnte auch Scrum sein mit kurzen Sprints |
| **Firmware Medizingerät** | ✓ ja | ✗ nein | Streng reguliert, braucht umfangreiche Planung, Qualitätskontrolle, umfassende Dokumentation, lange Zyklen – klassische Scrum oder sogar Waterfall besser |

**Begründungen ausführlich**:

**Support** → Kanban:
- Tickets sind **atomare, unabhängige Aufgaben**
- Kommen jederzeit, Menge ist variabel
- "Sprints" machen keinen Sinn, weil man nicht planen kann
- **Durchsatz- und Lead-Time-Optimierung** im Fokus
- **WIP-Limits** halten System stabil

**Produktentwicklung** → Scrum:
- Feature hat **klares Anfangsdatum und Ziel**
- Team kann zusammen planen ("Was machen wir in 2 Wochen?")
- **Sprint Reviews mit Stakeholder** für Feedback
- **Retrospektiven** zum Verbessern des Prozesses
- Braucht **Definition of Done** und **Akzeptanzkriterien**

**Content-Redaktion** → Kanban (könnte aber auch Scrum):
- **Kanban**: Artikel werden kontinuierlich geschrieben/publisht, variabel
- **Scrum**: Könnte auch mit 1-Wochen-Sprints funktionieren, würde mehr Struktur bringen
- **Hybrid**: Nachrichtenraum folgt Kanban, großere Recherche-Projekte Scrum

**Firmware Medizingerät** → Scrum (oder klassisch):
- **Hohe Sicherheitsanforderungen** = viel Dokumentation, Reviews
- **Regulatory Compliance** = formale Gates und Signoffs
- Langfristig → längere Sprints (3–4 Wochen) oder klassisch
- Kanban nicht ausreichend, da die "Definition of Done" zu komplex

---

## Aufgabe 10: Retrospektive durchführen – Lösung

### 10.1 Sprint Retrospektive – Start-Stop-Continue Format

**Szenario Recap**:
- Daily Standups: 30+ Min (zu lang)
- Developer krank, Arbeit stapelte sich
- PO nicht erreichbar, neue Anforderung mid-Sprint
- "Payment Integration" nicht fertig (Tech-Schuld)
- Andere Stories fertig ✓

**Retrospektive – Start-Stop-Continue**:

| **START** (Neu anfangen) | **STOP** (Stoppen) | **CONTINUE** (Weitermachen) |
|---------|--------|----------|
| Täglich 15-Min-Check mit PO-Verfügbarkeit | 30+ Min Standups (viel zu lang) | Sprint Planning ist strukturiert |
| Backup-Person für jede Story benennen | Fehlende Dokumentation (führt zu Fragen) | Daily Standups (aber KÜRZER) |
| Regelmäßige Code Reviews (auch Pair Prog.) | Tech-Schuld aufbau (Payment-Bug) | Daily Pair Programming für komplexe Features |
| Tech-Schuld im Backlog tracken | Mid-Sprint Anforderungs-Änderungen (unklar) | Team-Zusammenhalt und Hilfsbereitschaft |

**Konkrete Verbesserungsmaßnahmen für Sprint 4**:

1. **Daily Standup: Maximal 15 Minuten** – SM sorgt für Einhaltung, Probleme offline lösen
   - Metrik: Standup-Dauer tracken, Ziel <15 Min in Sprint 4

2. **PO Verfügbarkeit priorisieren** – "Office Hours" setzen (z. B. Montags 10–12 Uhr) für Questions
   - Metrik: Mid-Sprint-Change-Requests reduzieren auf 0–1 pro Sprint

3. **Tech-Schuld-Task "Payment Integration Fix" ins Sprint 4 Backlog** – 5 SP reservieren
   - Metrik: Nach Sprint 4 sollte das Zahlung-Feature stabil sein

4. **Buddy-System für Fehltage** – Wenn Person ausfällt, hat jemand anders die Aufgaben übernommen
   - Metrik: Story-Stalls durch Abwesenheit auf <1 pro Sprint senken

> **Kommentar**: Eine **gute Retrospektive ist konkret und actionable**, nicht nur allgemein. Nicht "Kommunikation verbessern", sondern "PO hat Verfügbarkeits-Slot Montags 10–12 Uhr." Das ist messbar.

---

## Aufgabe 11: Hybrid-Projekt – Klassisch + Agil – Lösung

**Szenario**: Großprojekt, 3 Phasen:
- **Phase 1 (Mo 1–2)**: Anforderungsanalyse & Architektur (eher klassisch)
- **Phase 2 (Mo 3–9)**: Entwicklung (agil, Sprints)
- **Phase 3 (Mo 10)**: Rollout & Schulung (eher klassisch)

**Hybrid-Struktur**:

| Aspekt | Phase 1 (Klassisch) | Phase 2 (Agil) | Phase 3 (Klassisch) |
|--------|------|------|-----|
| **Planung** | Wasserfallmässig: Anforderungsdok., Designdok., Architektur-Review | Sprint-basiert: 2-Wk Sprints, Rolling Wave (Backlog verfeinert sich) | Gates: Rollout-Plan, Schulungs-Material, Checklisten |
| **Meetings** | Wöchentl. Steering Comm., Kickoff, Design-Reviews (formal) | Daily Standups, Sprint Planning (Mi), Sprint Review (Fr), Retro (Fr) | Rollout-Board (täglich), Schulungs-Sync, UAT-Reviews |
| **Dokumentation** | Ausführliches Anforderungsdok., Architektur, Tech. Design Spec | Minimal: User Stories, DoD, Sprint Backlog (Wikis reichen) | Rollout-Guide, Benutzerhandbuch, Training-Unterlagen, Release Notes |
| **Stakeholder-Engagement** | Anfang: Requirements-Workshops, Steering Committee Approval | Kontinuierlich: Sprint Reviews mit Key Stakeholders (1x/Woche) | UAT-Team, Change-Management, Benutzer-Trainings |
| **Risiken** | Klassisch gemanagt (Risk Register) | Im Scrum adressiert (Sprint Retro) | Rollout-Risiken (Supportplan, Rollback) |
| **Metriken** | Meilenstein-Einhaltung (gates), Qualität am Ende | Velocity, Burndown, Cycle Time | UAT-Defekt-Dichte, Go-Live-Erfolg |

**Beispiel-Gantt (vereinfacht)**:

```
M1  [Req & Design Phase]
M2  [Architecture Review] ───────────
                        ┌──────────────────────────────────────┐
M3                      [Sprint 1] [Sprint 2] [Sprint 3]...
M4–9                    (Agil, iterativ)
                                                              ┌──────────────┐
M10                                                          [Rollout & UAT]
```

**Key Principles für Hybrid**:
1. **Transition-Punkte sind kritisch**: Am Ende Phase 1 → Phase 2 übergabe von Dokumenten zu Sprint Backlog
2. **Klassische Gates bleiben**: Anfang (Requirements) + Ende (Release), aber Phase 2 ist agil
3. **PO ist verbindend**: Muss sicherstellen, dass Phase 1 Anforderungen in Phase 2 Backlog landen
4. **Dokumentation**: Phase 1 ausführlich, Phase 2 minimal, Phase 3 wieder ausführlich

> **Kommentar**: Das ist ein **realistisches Szenario**. Große Organisationen nutzen oft "Water-Scrum-Fall": Wasserfallmässige Anforderungen, agile Entwicklung, klassischer Rollout.

---

## Aufgabe 12: Skalierung – SAFe oder LeSS – Lösung

**Szenario**: 200 Entwickler, hierarchisch, prozessorientiert, monatliche Reports verlangt.

### 12.1 Empfehlung: **SAFe (Scaled Agile Framework)**

**Begründung**:

| Kriterium | SAFe | LeSS |
|-----------|------|------|
| **Hierarchie-freundlich** | ✓ Ja (explicit governance, layers) | ✗ Nein (flach, selbstorganisiert) |
| **Governance-Struktur** | ✓ Ja (Steering Board, PIs, Gates) | ✗ Nein (minimal, dezentral) |
| **Komplexität** | ⚠️ Komplex (aber entspricht org. Komplexität) | ✓ Einfacher (bleibt nah am Scrum) |
| **Reporting** | ✓ Ja (Program Increments, Dashboards) | ✗ Nein (einfache Metriken) |
| **Skalierung 200 Personen** | ✓ Ja (explizit designt) | ⚠️ Möglich, aber schwierig |
| **Beste Wahl hier?** | **✓ JA** | ✗ Nein |

### Detaillierte Begründung:

**Warum SAFe?**

1. **Hierarchie-Kompatibilität**: SAFe hat explizite Strukturen für klassische Org-Hierarchien. Es sagt: "Hier sind deine Manager-Rollen" (Portfolio Manager, Program Manager). LeSS sagt: "Alle sind selbstorganisiert" – passt nicht zu 200 Personen in hierarchischer Org.

2. **Governance**: Die Geschäftsführung verlangt "monatliche Status-Reports". SAFe bietet dafür **Program Increment (PI) Planning** und **PI Reviews** – formale, regelmäßige Gates. Das befriedigt das Kontrollebedürfnis.

3. **Skalierung von 200 Personen**: SAFe funktioniert mit **Agile Release Trains (ARTs)**. Jeder ART = 50–125 Personen. Bei 200 Personen = 1–2 ARTs. LeSS würde sagen: "Eine Liste von Product Backlog für alle 200" – unpraktisch.

4. **Prozess-Orientierung**: Das Unternehmen mag Prozesse. SAFe ist explizit prozessorientiert (Ceremonies, Workflows, Rollen sind klar definiert). Das passt zur Kultur. LeSS würde Prozess-Reduktion fordern – kultureller Schock.

### Empfohlene Struktur mit SAFe:

```
Portfolio
  ├─ Program 1 (ART 1) – 80 Personen
  │   ├ Team A (8 Personen, Scrum)
  │   ├ Team B (8 Personen, Scrum)
  │   └ ... (10 Teams total)
  │
  └─ Program 2 (ART 2) – 80 Personen
      ├ Team X (8 Personen, Scrum)
      ├ Team Y (8 Personen, Scrum)
      └ ... (10 Teams total)

Zusammen: 200 Personen, 20 Scrum Teams, 2 ARTs
```

**Cadence**: 
- **2-Wochen-Sprints** (wie klassisches Scrum)
- **8–10 Wochen-PI** (Program Increment) = Planungs-Zyklus
- **PI Planning** = großes Kickoff-Meeting aller Teams (Governance!)
- **PI Review** = Stakeholder-Demo und Reporting

> **Kommentar**: SAFe ist **"Heavy"**, aber für große, hierarchische Organisationen ist es oft der **pragmatische Kompromiss** zwischen agilen Werten und organisationalen Realität.
> 
> **Warum nicht LeSS?** LeSS wäre ideal **wenn die Org flach ist** (Startups, kleine Teams). Aber bei 200 Personen + hierarchisch = LeSS-Umsetzung wäre frustrierend für beide Seiten.

---

## Zusammenfassung – Kerneinsichten

| Thema | Kernpunkt |
|-------|-----------|
| **Agile Werte** | Menschen > Prozesse, Arbeitsergebnis > Dokumentation, Kundenzusammenarbeit > Verträge, Flexibilität > Plan |
| **Scrum** | Rollen (PO, SM, Team), Events (Daily, Planning, Review, Retro), Artefakte (Backlog, Sprint Backlog, Inkrement) |
| **Kanban** | Visualisierung, WIP-Limits, kontinuierlicher Fluss, Metriken (Lead Time, Cycle Time) |
| **Definition of Done** | Qualitäts-Standards, die wachsen mit Team-Reife |
| **Daily Standup** | 15 Minuten, 3 Fragen, keine Problemlösung |
| **Retrospektive** | Prozess-Verbesserung, psychologisch sicher, konkrete Maßnahmen |
| **Wahl: Scrum vs. Kanban** | Scrum = Feature-Entwicklung; Kanban = kontinuierliche Workflows/Support |
| **Hybrid** | Klassisch für Anfang/Ende, agil für Kern |
| **Skalierung** | SAFe für große, hierarchische Orgs; LeSS für flache Orgs |