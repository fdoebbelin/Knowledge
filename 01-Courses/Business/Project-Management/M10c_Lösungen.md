## Aufgabe 1: Risikodefinition und Grundverständnis

### 1.1 Unterscheidung Risiko – Problem – Unsicherheit

**Lösung:**

| Nr. | Aussage | Klassifizierung | Begründung |
| --- | --- | --- | --- |
| a) | Der Datenbankserver fällt regelmäßig aus, wenn die Last über 80 % steigt | **P** (Problem) + **U** (Unsicherheit) | Es ist ein bekanntes Problem (wurde beobachtet), zugleich aber auch eine Unsicherheit, ob dies im Projekt eintritt. Im PM könnte man von einem „latenten Risiko" sprechen. |
| b) | Es könnte sein, dass die neuen Anforderungen nicht in den Zeitplan passen | **R** (Risiko) | Klassisches Risiko: zukünftig, unsicher, potentiell negativ. |
| c) | Der Projektmanager hat kein Erlebnis mit Web-Services-Integrationen | **U** (Unsicherheit) oder **R** (Risiko) | Dies ist eher eine Unsicherheit über vorhandenes Wissen. Nur wenn daraus ein Risiko für das Projekt entsteht (z. B. Fehler durch Inkompetenz), wäre es ein Risiko. Die Grenze ist fließend. |
| d) | Die Personalkosten könnten um 15 % steigen, wenn externe Berater hinzugezogen werden | **R** (Risiko) | Klassisches Risiko mit bedingtem Trigger: IF externes Personal THEN Kostenrisiko. |
| e) | Der Server ist am 15.05. ausgefallen und zwei Tage Down | **P** (Problem) | Vergangenes Ereignis, bereits eingetreten, erfordert Reaktion/Lösung, nicht Prävention. |
| f) | Wir kennen nicht genau, wie viele User die neue App simultan nutzen werden | **U** (Unsicherheit) | Eine Unsicherheit über ein Parameter. Dies kann zu Risiken führen (z. B. Performance-Risiko), ist aber selbst noch keine Risiko-Definition. |

> **Kommentar:** 
> 
> Diese Aufgabe zielt darauf ab, die **Grenzen zwischen Konzepten zu schärfen**:
> - **Probleme** sind eingetretene, gegenwärtige Ereignisse → Reaktives Management
> - **Risiken** sind potentielle, zukünftige Ereignisse → Proaktives Management
> - **Unsicherheiten** sind Wissenslücken, die zu Risiken werden können
> 
> **Typische Fehler vermeiden:**
> 1. Alle „könnte passieren" als Risiko klassifizieren → zu viele, weniger handlungsorientiert
> 2. Schwierigkeiten von heute ignorieren → müssen als Probleme gemanagt werden, nicht als Risiken
> 3. Kompetenzlücken nicht als Risiken erkennen → können zu echten Problemen führen
> 
> **Merksatz:** Wenn es *noch nicht passiert ist* und *nicht vollständig unter Ihrer Kontrolle* liegt, ist es ein Risiko.

---

### 1.2 Risiko vs. Chance

**Lösung – Beispiele:**

**a) Bedrohungen (Negative Risiken) im Cloud-Modernisierungsprojekt:**

1. **Datensicherheit & Compliance**: Cloud-Provider wird gehackt → Datenverlust, Compliance-Verstoß
2. **Performance & Latenz**: Cloud-Infrastruktur langsamer als erwartet → Benutzerakzeptanz sinkt
3. **Vendor Lock-in**: Proprietäre Technologien des Providers → Schwer ausstiegbar später
4. **Fachkompetenz fehlt**: Team hat keine Cloud-Erfahrung → Fehlkonfiguration, Sicherheitslücken
5. **Cost Overruns**: Cloud-Kosten höher als kalkuliert → Budgetüberschreitung

**b) Chancen (Positive Risiken):**

1. **Performance-Verbesserung**: Cloud-Auto-Scaling bringt bessere Performance → Höhere Benuterzufriedenheit
2. **Kostenreduktion**: Pay-as-you-go Modell kann günstiger sein → Budget sparen
3. **Schnellere Time-to-Market**: Cloud ermöglicht schnellere Deployment → Wettbewerbsvorteil
4. **Skalierbarkeit**: Leichte Skalierbarkeit → Wachstum ohne große Investment
5. **Innovation**: Einfacherer Zugang zu neuen Services (AI, Analytics) → Neue Features, neuer Nutzen

**c) Chancen proaktiv nutzen:**

- **Skalen-Ziele setzen**: Frühzeitig planen, wie Auto-Scaling genutzt wird
- **Startup-Modelle**: Cloud-Features für schnelle MVP-Iterationen einsetzen
- **Schulung forcieren**: Team gezielt in Cloud-Best-Practices trainieren → Kompetenz wird zum Wettbewerbsvorteil
- **Partnership mit Provider**: Enge Zusammenarbeit mit Provider für Zugang zu Beta-Features
- **Monitoring & Optimierung**: Laufendes Cost-Optimization → Tatsächliche Kostenersparnisse realisieren

> **Kommentar:**
> 
> Ein häufiger Fehler ist, **Chancen zu ignorieren und nur Bedrohungen zu managen**. Modernes Risikomanagement sollte:
> - **Symmetrisch** sein (Chancen = positive Risiken, auch als Management-Aufgabe)
> - **Aktiv** Chancen identifizieren und nutzen, nicht nur reaktiv Bedrohungen abwehren
> - **Gewinn-potentiale** erkennen und aktivieren
> 
> Im IT-Projekt werden Chancen oft übersehen, weil das Team zu sehr auf Risiken fokussiert. Cloud bietet real Chancen – diese zu managen ist ebenso wichtig wie Bedrohungen zu managen.

---

## Aufgabe 2: Risikoquellen und Kategorisierung

### 2.1 Risikoquellen zuordnen

**Lösung – Beispiele:**

| Risiko-Bereich | Beispiel-Frage | Identifiziertes Risiko |
| --- | --- | --- |
| **Externe Risiken** | Welche Marktfaktoren könnten uns treffen? | Konkurriert anderes Unternehmen mit ähnlicher Cloud-Lösung, senkt Markteintrittsbarrier → Projekt-Nutzen sinkt |
| **Externe Risiken** | Welche regulatorischen Änderungen sind möglich? | GDPR-Auslegung verändert sich → Cloud-Standorte werden unzulässig, Migration nötig |
| **Interne Risiken** | Könnte Personal fehlen oder gehen? | Cloud-Architect wird von Konkurrenz abgeworben → Know-how-Verlust, Verzögerung |
| **Interne Risiken** | Könnten Anforderungen unklar sein? | Anforderungen zu Datenspeicherung widersprüchlich (Performance vs. Compliance) → Rework |
| **PM-Risiken** | Könnte die Zeit nicht ausreichen? | Integrationstests dauern länger als geplant → Termine nicht haltbar |
| **PM-Risiken** | Könnten Stakeholder nicht aligned sein? | CIO und CFO haben unterschiedliche Prioritäten (Sicherheit vs. Kosten) → Deadlock |

> **Kommentar:**
> 
> Diese Übung schärft die **Analysefähigkeit**. Risiken entstehen nicht zufällig, sondern aus **identifizierbaren Quellen**. Ein guter Projektmanager:
> - Kennt die **Risikoquellen** in seinem Kontext
> - Stellt **proaktiv Fragen**, anstatt zu warten, bis Probleme entstehen
> - Nutzt **Kategorien**, um systematisch nichts zu übersehen
> 
> **Häufiger Fehler:** Zu generisch bleiben („Es könnte schief gehen") statt konkrete Quellen zu identifizieren.

### 2.2 Kategorisierungsmatrix – Lösung

**Zuordnung der 8 Risiken:**

|  | **Technisch** | **Terminlich** | **Kostenlich** | **Anforderungen** | **Extern** |
| --- | --- | --- | --- | --- | --- |
| **Früh** (Planung) | 2 (DB-Performance) | | 6 (Budget-Kürzung) | 5 (Anforderungswechsel) | 1 (Cloud-Sicherheit) |
| **Laufend** (Ausführung) | 3 (Integration) | 8 (Testing-Zeit) | | | |
| **Spät** (Post-Go-Live) | | 4 (Schlüssel-Fluktuation) | 7 (Datenschutz-Zertif.) | | |

*Alternative Zuordnungen sind teilweise möglich, da Risiken mehrere Kategorien betreffen können.*

> **Kommentar:**
> 
> **Clustering-Analyse zeigt**:
> - In der **Planungsphase** liegen viele Risiken → wichtig, früh zu identifizieren
> - **Technische Risiken** sind häufig → erfordert technisches Verständnis im Team
> - **Personalrisiken** (4) sind oft unterschätzt, aber hoch-impactful
> 
> **Praktischer Nutzen:**
> - Zeitlich distribuierte Risiken → verschiedene Phasen-Workshops nötig
> - Kategorien-Balance → zeigt, wo Planung oder Erfahrung fehlt

---

## Aufgabe 3: Risikoidentifikation – Praktische Techniken

### 3.1 Brainstorming-Session – Lösung (Beispiele)

**Für Webshop-Relaunch-Projekt, typische Risiken:**

```
1. Datenverlust beim Umzug von Alt- zu Neuplattform
2. Kundenbestellung fallen zwischen Systemen durch
3. Zahlungsgateway inkompatibel mit neuer Plattform
4. Legacy-Daten-Format nicht lesbar im neuen System
5. Alte Kundenadressen sind fehlerhaft, Versand schlägt fehl
6. Integrations-API nicht dokumentiert, Integration scheitert
7. Performance der neuen Plattform unter Last unklar
8. Benutzeroberfläche ist nicht Mobilgeräte-optimiert
9. Team hat zu wenig Zeit für Testing
10. Supplier (Hosting) hat Ausfallrisiko
11. Konkurrenz startet ähnliche Relaunch zeitgleich (Markt-Risiko)
12. Kundenkommunikation zur Umstellung scheitert → Verwirrung
```

> **Kommentar:**
> 
> In echten Brainstormings:
> - Wird es oft **wilde und absurde Ideen** geben → das ist erwünscht (Kreativität)
> - **Dominante Personen** prägen oft die Ergebnisse → Moderator muss ausgleichen
> - **Erste 30 Minuten** bringen 80 % der Ideen, danach wird es schwächer
> 
> **Häufige Fehler:**
> 1. Ideen sofort bewerten/kritisieren → verstummt kreative Prozess
> 2. Zu formal/strukturiert → keine neuen Perspektiven
> 3. Nur Entwickler im Raum → Operationelle/Marketing-Risiken übersehen
> 
> **Besser machen:**
> - Wildheit erlauben, später sortieren
> - Diverse Teilnehmer (Tech, Business, Ops, Customer)
> - Moderation mit Leitfragen, nicht Vorgaben

### 3.2 Checklisten-basierte Identifikation – Lösung

**Ausgefüllte Checkliste (Beispiele):**

| Risikobereich | Kontrollfrage | Antwort | Risiko ableiten? | **Spezifisches Risiko** |
| --- | --- | --- | --- | --- |
| **Anforderungen** | Sind alle Anforderungen verschriftlicht und signiert? | Teilweise | **Ja** | Anforderungs-Lücken führen zu Rework in Phase X |
| **Anforderungen** | Gibt es Konflikte zwischen den Anforderungen? | Ja | **Ja** | Performance-Anforderung vs. Datenschutz-Anforderung widersprüchlich |
| **Anforderungen** | Sind NFRs definiert? | Nein | **Ja** | NFRs (Performance, Security) unklar → falsche technische Entscheidungen |
| **Technologie** | Wird neue Technologie verwendet? | Ja | **Ja** | Neue Message Queue wird erstmals genutzt → Integrationsprobleme möglich |
| **Technologie** | Sind Schnittstellen dokumentiert? | Teilweise | **Ja** | 3rd-Party-API nur teilweise dokumentiert → zeitraubende Reverse-Engineering |
| **Personal** | Sind alle Kompetenzen im Team? | Nein | **Ja** | DevOps-Expertise fehlt → Deployment-Probleme wahrscheinlich |
| **Personal** | Fluktuation-Risiko? | Ja (1 Senior plant Abgang) | **Ja** | Gründer/Mentor verlässt Team → Mentoring-Ausfallrisiko |
| **Zeitplan** | Zeitplan validiert? | Nein | **Ja** | Aggressive Timeline nicht überprüft → unrealistisch |
| **Budget** | Budget mit Puffer? | Nein (0 %) | **Ja** | Null-Puffer → erste Abweichung führt zu Überschuss |
| **Kommunikation** | Kommunikationsplan? | Nein | **Ja** | Stakeholder uninformiert → Wrong Scope, Überraschungen |

**Abgeleitete Risiken konkretisiert:**

```
1. Anforderungs-Lücken → Unerwarteter Rework in UAT-Phase → 2 Wochen Verzögerung
2. Datenschutz-Performance-Konflikt → Design-Entscheidung blockiert → 1 Woche Analyse nötig
3. NFRs unklar → Falsche Architektur-Entscheidung → Umdesign nötig (kostspiellig)
4. Message Queue neu → Integrationsfehler wahrscheinlich → 1–2 Wochen Debugging
5. API-Dokumentation lückenhaft → 3rd-Party-Integration dauert 50 % länger
6. DevOps-Expertise fehlt → Deployment-Probleme, fehlende Automatisierung → Betriebsrisiko
7. Senior geht → Know-how-Verlust, Mentoring ausfall → Juniors demoralisiert/langsamer
8. Timeline nicht validiert → Risiko der Überschreitung steigt von 10 % auf 50 %
9. Budget ohne Puffer → Erste Abweichung führt zu Budgetüberschuss von 15–20 %
10. Keine Kommunikation → Stakeholder überrascht, Vertrauensverlust, Scope-Konflikte
```

> **Kommentar:**
> 
> **Stärken von Checklisten:**
> - Systematisch, nichts wird vergessen
> - Schnell einsetzbar
> - Basiert auf Erfahrung (Best Practice)
> - Standardisierbar für Wiederverwendung
> 
> **Schwächen:**
> - Kann Schema-denken fördern
> - Projekt-spezifische Risiken können übersehen werden
> - Erfordert Interpretation (ein „Nein" ist nicht automatisch ein Risiko)
> 
> **Best Practice:** Checklisten + Brainstorming kombinieren

---

## Aufgabe 4: Risikobewertung – Wahrscheinlichkeit und Auswirkung

### 4.1 Wahrscheinlichkeitsschätzung – Lösung

| Risiko | Begründung | Wahrscheinlichkeit (1–5) | Erklärung |
| --- | --- | --- | --- |
| Anforderung ändert sich | Historisch: 80 % der Projekte | **5** | Sehr wahrscheinlich; Change-Management wird wenig ernst genommen |
| Hauptarchitekt fällt 3 Wo aus | Krankenstand durchschn. 5 % p. a. | **1–2** | Unwahrscheinlich; 3 Wochen ist relativ lang. Könnte aber vorkommen (Unfall, schwere Krankheit). Mit Absicherung (Doku, Backup) minderbar. |
| Integrationsschnittstelle nicht erreichbar | 99 % Verfügbarkeit | **2** | Unwahrscheinlich; aber: 1 % = 3.6 h/Monat → in 4-Monaten-Projekt ca. 14 h Ausfallrisiko. |
| Regierungsrichtlinie ändert sich | Aktuelle Diskussionen, ungewiss | **3** | Möglich; Datenschutz-Landschaft ändertsich, aber nicht garantiert. 50/50 Chance. |
| Testing findet kritische Fehler | Frühere Projekte: 40 % hatten das | **3** | Möglich; Basierend auf Historik sind kritische Fehler in ~40 % der Fälle wahrscheinlich. |

> **Kommentar:**
> 
> **Schätzherausforderungen:**
> 1. **Kogn. Bias**: Menschen tendierten zu Über/Unterschätzung (Overconfidence, Pessimism)
> 2. **Datenlücken**: Oft gibt es keine historischen Daten → Experten-Judgment erforderlich
> 3. **Kontextabhängigkeit**: Gleiche Risiko hat andere P in verschiedenen Projekten
> 
> **Verbesserungstaktiken:**
> - **Mehrere Schätzer**: Average reduziert individuelle Bias
> - **Historische Kalibrierung**: Abgleich mit früheren Projekten
> - **Szenario-Denken**: „Best/Likely/Worst" Case durchdenken
> - **Granulare Skale**: 5er statt 3er Skala bessere Auflösung
> 
> **Häufige Fehler:**
> - Alle hohen Wahrscheinlichkeiten geben (zu pessimistisch)
> - Alle als 3er klassifizieren (lazy, keine Differenzierung)
> - Mit den Schätzungen zu sehr schwanken (keine Konsistenz)

### 4.2 Impact-Bewertung – Lösung (Beispiele)

| Risiko | Zeit | Kosten | Qualität | Geschäftlich | Begründung |
| --- | --- | --- | --- | --- | --- |
| Key Resource fällt 4 Wochen aus | **5** | **4** | **3** | **4** | 4 Wochen ist 10–20 % des Projekts → kritisch. Kosten steigen durch Verzögerung. Qualität leidet wegen weniger Tests. Geschäftlich: Verzögerung der Markteinführung → Wettbewerbs-Nachteil. |
| Hauptanforderung ändert sich | **4** | **5** | **4** | **3** | Terminlich: 2–4 Wochen Rework. Kostenlich: Höchst-Impact (Architektur-Änderungen). Qualität: Stress, weniger Gründlichkeit. Geschäftlich: Kunde unzufrieden, aber noch managebar. |
| Server-Infrastruktur nicht verfügbar | **5** | **4** | **5** | **5** | Zeitlich: Kompletter Stopp. Kostenlich: Notfall-Beschaffung teuer. Qualität: Totales Versagen. Geschäftlich: Reputationsschaden, Vertrauensverlust. |
| Supplier liefert Komponente verspätet | **3** | **3** | **2** | **2** | Terminlich: 1–2 Wochen Verzögerung (kritischer Pfad abhängig). Kostenlich: Expediting-Gebühren oder Interim-Lösung. Qualität: Minimal. Geschäftlich: Je nach Kritikalität unterschiedlich. |

> **Kommentar:**
> 
> **Impact-Dimensionen sind nicht unabhängig**:
> - Zeitverzögerung führt oft zu Kostenüberschreitung
> - Zeitdruck führt zu Qualitätsmängeln
> - Qualitätsmängel führen zu geschäftlichem Schaden
> 
> **Skalierungsherausforderung:**
> - Eine einzige Impact-Zahl zu vergeben ist zu simpel
> - Multi-dimensionale Bewertung realistischer
> - Aber: Mehr Dimensionen = Komplexität steigt
> 
> **Praktischer Tipp:**
> - Für kritische Projekte: Multi-dimensional bewerten
> - Für einfachere Projekte: Eine Haupt-Dimension (z. B. Zeit)
> - Immer mit **konkreten Zahlen** arbeiten (nicht „schlecht", sondern „2 Wochen" oder „20 % Budget")

---

## Aufgabe 5: Risikowertberechnung und Priorisierung

### 5.1 Risikowertberechnung – Lösung

| Risiko-ID | Risikobeschreibung | P | I | Risikowert (P × I) | Klassifizierung |
| --- | --- | --- | --- | --- | --- |
| R1 | Datenmigration scheitert | 3 | 5 | **15** | **Hoch** |
| R2 | Compliance-Anforderung ändert | 2 | 4 | **8** | **Hoch** |
| R3 | Entwickler-Ausfall | 3 | 3 | **9** | **Hoch** |
| R4 | Performance unter Last unzureichend | 4 | 4 | **16** | **Kritisch** |
| R5 | Externe API nicht verfügbar | 2 | 2 | **4** | **Mittel** |
| R6 | Testing-Zeit überschritten | 4 | 3 | **12** | **Hoch** |
| R7 | Budget gekürzt | 2 | 3 | **6** | **Mittel** |
| R8 | Kundenanforderung unklar | 5 | 3 | **15** | **Hoch** |

> **Kommentar zu Interpretationen:**
> 
> - **R4 (Performance, Wert 16)**: Kritisch, weil hohe W. (4) und hohe I (4). Typisch in komplizierten Tech-Projekten.
> - **R8 (Anforderungen unklar, Wert 15)**: Hoch, weil sehr wahrscheinlich (5), aber Impact etwas geringer (3). Trotzdem kritisch → sollte Aufmerksamkeit bekommen.
> - **R1 (Migration, Wert 15)**: Hoch, klassisches Risiko für Datensysteme-Projekte.
> - **R5, R7 (niedrig)**: Können akzeptiert oder mit Monitoring verwaltet werden.

### 5.2 Priorisierungsliste – Lösung

| Rang | Risiko-ID | Risikobeschreibung | Wert | Klassif. | Handling |
| --- | --- | --- | --- | --- | --- |
| 1 | **R4** | Performance unter Last unzureichend | **16** | **Kritisch** | Sofort eskalieren & Maßnahmen definieren (z. B. Last-Tests early) |
| 2 | **R1** | Datenmigration scheitert | **15** | **Hoch** | Aktiv managen, Migrations-Dry-Run, Rollback-Pläne |
| 3 | **R8** | Kundenanforderung unklar | **15** | **Hoch** | Aktiv managen, Requirement-Klärung forcieren, Stakeholder-Alignment |
| 4 | **R6** | Testing-Zeit überschritten | **12** | **Hoch** | Aktiv managen, Testing-Ressourcen erhöhen, Test-Automatisierung |
| 5 | **R3** | Entwickler-Ausfall | **9** | **Hoch** | Monitor, ggf. Backup-Ressource definieren |

> **Reflexion:**
> 
> **Fragen zu Priorisierung:**
> 
> 1. **Welche Risiken beanspruchen die meisten Ressourcen?**
>    - R4, R1, R8 sind die top 3 und brauchen intensive Maßnahmen
>    - R4 (Performance) braucht technische Tests und Architektur-Review
>    - R1 (Migration) braucht Planung und Test-Umgebungen
>    - R8 (Anforderungen) braucht Stakeholder-Engagement
> 
> 2. **Gibt es kombinierte Maßnahmen?**
>    - R1 + R4 könnten zusammenhängen (Migration kann Performance beeinflussen)
>    - R6 + R4 könnten kombiniert angegangen werden (Perormance-Tests früh und gründlich)
>    - R3 + R8 können parallel angegangen werden (verschiedene Fähigkeiten)
> 
> 3. **Welche Risiken könnten akzeptiert werden?**
>    - R5 (Externe API, Wert 4) könnte mit Monitoring akzeptiert werden (häufig stabil)
>    - R7 (Budget gekürzt, Wert 6) könnte akzeptiert werden, wenn Notfall-Pläne existieren
>    - R2 (Compliance, Wert 8) braucht Monitoring, aber Compliance-Team sollte dafür verantwortlich sein

---

## Aufgabe 6: Risikomatrix

### 6.1 Risikomatrix – Lösung (visualisiert)

```
        Auswirkung (Impact) →
         1    2    3    4    5
       5 [ ]  [ ]  [ ]  [ ] [R8]
       4 [ ]  [R5] [R7] [ ] [R4]
       3 [ ]  [ ] [R3] [R1] [ ]
   L   2 [ ]  [ ]  [ ]  [ ] [ ]
   i   1 [ ]  [ ]  [ ]  [ ] [ ]
   k ↓
   e
   l
   i
   h
   o
   o
   d
```

**Mit Risikowerten:**

```
           Auswirkung (Impact) →
          1    2    3    4    5
       5 [ ]  [ ]  [ ]  [ ]  [R8=15]
       4 [ ]  [R5=4] [R7=6] [ ]  [R4=16]
       3 [ ]  [ ]  [R3=9]  [R1=15] [ ]
   L   2 [ ]  [ ]  [ ]  [R2=8] [ ]
   i   1 [ ]  [ ]  [ ]  [ ]  [ ]
   k ↓
   e
   l
   i
   h
   o
   o
   d
```

**Farbzonen:**

- **Rot (Kritisch, 16–25)**: R4 (allein)
- **Orange (Hoch, 8–15)**: R1, R2, R3, R6 (nicht alle in dieser Übung gezeigt), R8
- **Gelb (Mittel, 4–7)**: R5, R7
- **Grün (Niedrig, 1–3)**: (keine in dieser Übung)

> **Kommentar zur Visualisierung:**
> 
> Die Matrix macht **schnell sichtbar**:
> - **Cluster in rechts-oben**: Mehrere hohe/kritische Risiken
> - **Diagonale Verteilung**: Normales Muster (nicht alle oben-links/unten-rechts)
> - **Outlier**: R4 (allein) könnte Aufmerksamkeit brauchen

### 6.2 Interpretation und Muster – Lösung

**a) Risiken in der Kritisch-Zone:**

```
Nur R4 (Performance unter Last): 
- Hoch wahrscheinlich (4/5) UND hoch impact (4/5)
- Begründung: Neue Technologie/Architektur, Last-Testing noch nicht durchgeführt
- → Sofortmaßnahme: Early Load-Testing, Architektur-Review, evtl. Prototype
```

**b) Cluster oder Muster:**

```
Muster:
- Hauptcluster im Bereich P=3–5 × I=3–4 (mittelhoch bis kritisch)
- Das deutet auf ein **komplexes, mittelhoch-riskantes Projekt** hin
- Branchen/Typ: Migrations- oder Modernisierungsprojekt (Migration, neuer Stack, Performance-kritisch)

Beobachtung:
- Wenig Risiken in der Niedrig-Zone → Projekt insgesamt riskant
- Wenn Verteilung normal ist, hätte man mehr "Grün" erwartet
- → Projektteam sollte insgesamt vorsichtig/aktiv sein
```

**c) Risiken, die akzeptiert werden könnten:**

```
Kandidaten für Akzeptanz:
1. R5 (Externe API, Wert 4): 
   - Wahrscheinlichkeit niedrig (2), Impact niedrig (2)
   - Lösung: Mit Default-Behavior/Offline-Mode akzeptieren
   - Monitoring: Ausfall überwachen, schnelle Reaktion bereit

2. R7 (Budget gekürzt, Wert 6):
   - Schwer zu kontrollieren, extern bedingt
   - Lösung: Notfall-Plans definieren (was tun bei Kürzung?)
   - Für Management transparent halten

3. R2 (Compliance, Wert 8):
   - Wahrscheinlichkeit niedrig (2), aber Impact hoch (4)
   - Eigentlich sollte das nicht akzeptiert werden
   - Besser: Auf Compliance-Team abwälzen (Transfer-Strategie)
```

**d) Veränderung der Matrix durch Maßnahmen:**

```
Beispiel-Szenario nach Maßnahmen:

Maßnahmen & Wirkung:
- R4 (Performance): Load-Testing + Cache-Strategie implementiert
  → P sinkt von 4 auf 2 (zu 2×4=8, von kritisch auf hoch)
  
- R8 (Anforderungen): Klare Requirements-Workshops durchgeführt
  → I sinkt von 3 auf 2 (zu 5×2=10, noch immer hoch)
  
- R1 (Migration): Dry-Run durchgeführt, Risiken verstanden
  → P sinkt von 3 auf 2 (zu 2×5=10, von hoch auf hoch, aber stabiler)

Neue Matrix würde weniger „Rot" und mehr „Gelb/Orange" zeigen → Projekt riskokontrollierter
```

> **Kommentar:**
> 
> Eine Risikomatrix bietet:
> - **Schnelle Visualisierung** für Meetings und Entscheidungsträger
> - **Trend-Verfolgung** über Zeit (Januar Matrix vs. März Matrix)
> - **Priorisierungs-Klarheit** (sofort sichtbar, was kritisch ist)
> 
> Aber: Matrix hat Grenzen:
> - Wert 15 (3×5) und 15 (5×3) werden gleich gewichtet, haben aber unterschiedliche Strategien
> - Bei vielen Risiken wird die Matrix unübersichtlich
> - Abhängigkeiten zwischen Risiken sind nicht sichtbar

---

## Aufgabe 7: Risikokategorisierung

### 7.1 Kategorisierung nach Risikoart – Lösung

| Risikoart | Risiken (IDs) | Anzahl | Besonderheiten |
| --- | --- | --- | --- |
| **Technisch** | R1, R4 | 2 | Migration + Performance = Kern-Tech-Risiken |
| **Terminlich** | R6 | 1 | Testing ist auf Pfad, kann sich verzögern |
| **Kostenlich** | R7 | 1 | Externe Faktor (Budget-Kürzung) |
| **Anforderungen** | R2, R8 | 2 | Änderung + Unklar = hohe Anforderungs-Risiken |
| **Personal** | R3 | 1 | Ausfall eines Entwicklers |
| **Organisatorisch** | – | 0 | (Keine expliziten in dieser Übung) |
| **Extern** | R5 | 1 | Abhängigkeit von externer API |

**Analyse:**

```
Distribution:
- Technisch dominiert (40 % = 2 von 5 Kategorien)
- Anforderungen zweiter Schwerpunkt (40 %)
- Personal, Termin, Kosten, Extern je 10–20 %

Implikationen:
- → Team muss technisch sehr versiert sein
- → Anforderungsklärung ist kritischer Erfolgsfaktor
- → Personalstabilität ist wichtig (nur 1 R3)
- → Extern-Abhängigkeiten sind managebar

Für Steuerung: Technische und fachliche Expertise = größte Investments
```

### 7.2 Kategorisierung nach Zeitpunkt – Lösung

| Zeitpunkt | Risiken (IDs) | Beispiele | Handlungs-Implikationen |
| --- | --- | --- | --- |
| **Initiierung / Planung** | R8, R2 | Anforderungs-Klarheit, Compliance-Anforderungen | Sofort Clarifications durchführen, nicht verzögern |
| **Ausführung / Development** | R4, R3, R5 | Performance-Architektur, Entwickler-Ausfall, API-Integration | Aktive Überwachung, Backup-Ressourcen, Integration-Tests |
| **Test / UAT** | R1, R6 | Datenmigration, Testing-Zeit | Go/No-Go-Gating auf Basis dieser Risiken |
| **Go-Live / Rollout** | – | (abhängig von Umsetzung der obigen) | Kritisch abhängig davon, ob frühere Phasen gut liefen |
| **Betrieb / Post-Go-Live** | – | – | Monitoring & Support-Readiness |

**Interpretation:**

```
Fazit:
- Die meisten Risiken sind in **Planung und Ausführung** (früh)
- → Projekt braucht starke Planung und frühe Validierung
- → Wenige späte Risiken → später relativ sicher (wenn früh gut gelaufen)

Handlungs-Priorität nach Zeit:
1. JETZT (Planung): R8 + R2 klären → Foundation
2. SOON (Early Exec): R4 + R3 + R5 managen → Kernrisiken
3. MITTEL (Testing): R1 + R6 validieren → Go/No-Go
4. SPÄTER: Nur Monitoring
```

---

## Aufgabe 8: YouTrack Integration – Risiko-Tracking

### 8.1 Risiko-Register in YouTrack – Lösung (Beispiele)

**Risiko 1 – Datenmigration scheitert (R1, höchste Priorität):**

```
Issue Type:       Risk
Title:            Datenmigration scheitert oder Datenverlust tritt auf
Description:      Bei der Migration von 10 Mio. Datensätzen von Altsystem zu 
                  neuer Cloud können Datenverluste oder Formatfehler auftreten.
                  Betrifft kritische Kundenmaster-Daten.
Category:         Technisch
Likelihood:       3 (möglich)
Impact:           5 (kritisch – Produktunfähigkeit)
Risk Score:       15 (hoch)
Status:           Open
Owner:            @TechLead_Mustermann
Mitigation Plan:  [wird in Modul 11 definiert]
Target Resolution:2026-02-28
Comments:         - First migration dry-run planned for Jan 2026
                  - Need data validation scripts
```

**Risiko 4 – Performance unter Last (R4, kritisch):**

```
Issue Type:       Risk
Title:            Performance-Probleme unter Last (>1000 concurrent users)
Description:      Die neue Cloud-Architektur wurde nicht für >1000 concurrent
                  user getestet. Performance-Anforderungen (< 2 sec response)
                  könnten verfehlt werden, besonders bei Peak-Load.
Category:         Technisch
Likelihood:       4 (wahrscheinlich)
Impact:           4 (hoch – benutzer-facing)
Risk Score:       16 (kritisch)
Status:           Open
Owner:            @ArchitectM
Mitigation Plan:  [wird in Modul 11 definiert]
Target Resolution:2026-03-15
Comments:         - Load-test infrastructure setup needed
                  - Consider horizontal scaling options
                  - Database query optimization critical
```

**Risiko 8 – Anforderungen unklar (R8, hoch/häufig):**

```
Issue Type:       Risk
Title:            Kundenanforderungen unklar oder unvollständig
Description:      5 von 25 kritischen Anforderungen sind noch nicht final
                  abgestimmt mit Kunden. Unklar bleiben Details zu:
                  - Datenablauf & Compliance-Handling
                  - API-Schnittstelle zu Legacy-System
                  - UI-Spezifikationen in 3 Modulen
Category:         Anforderungen
Likelihood:       5 (sehr wahrscheinlich – historisch: 80% der Projekte)
Impact:           3 (mittel – führt zu Rework)
Risk Score:       15 (hoch)
Status:           Open
Owner:            @ProductOwner_Schmidt
Mitigation Plan:  [wird in Modul 11 definiert]
Target Resolution:2026-01-31
Comments:         - Schedule weekly Req-Workshops
                  - Customer sign-off required by Jan 31
                  - Prototype for UI feedback loop
```

> **Kommentar zu YouTrack:**
> 
> **Vorteile dieser Integration:**
> 1. **Zentral**: Alle Risiken an einem Ort (statt Excel-Sheets)
> 2. **Trackbar**: Status-Übergänge, Kommentare sind loggbar
> 3. **Dashboard**: Überblick über alle Risiken möglich
> 4. **Workflow**: Automatische Eskalation bei hohen Scores
> 5. **Reporting**: Reports für Management/Governance möglich
> 
> **Setup-Anforderungen in YouTrack:**
> - Custom Issue Type "Risk"
> - Custom Fields: Likelihood, Impact, Risk Score (Formula), Category
> - Workflow States: Open → In-Review → Mitigating → Monitoring → Closed
> - Dashboard mit Queries (z. B. "Risk Score >= 12 AND Status = Open")

### 8.2 YouTrack-Dashboard Skizze – Lösung

**Mögliches Dashboard-Layout:**

```
┌──────────────────────────────────────────────────────────────────┐
│           RISIKOMANAGEMENT DASHBOARD (Projekt XYZ)               │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Status: [●●●● Open (8) │ In-Review (2) │ Monitoring (1)]        │
│  Avg Risk Score: 11.5 / 25                                       │
│  Last Updated: 2026-01-20                                        │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │ TOP 5 RISIKEN NACH PRIORITÄT                               │  │
│  ├────────────────────────────────────────────────────────────┤  │
│  │ 1. [●●●●●] R4: Performance unter Last            (16)  →   │  │
│  │ 2. [●●●●○] R1: Datenmigration scheitert          (15)  →   │  │
│  │ 3. [●●●●○] R8: Anforderungen unklar              (15)  →   │  │
│  │ 4. [●●●○○] R6: Testing-Zeit überschritten        (12)  →   │  │
│  │ 5. [●●●○○] R3: Entwickler-Ausfall                (9)   →   │  │
│  └────────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌────────────────────┐  ┌──────────────────────┐                │
│  │ NACH KATEGORIE     │  │ NACH LIKELIHOOD      │                │
│  ├────────────────────┤  ├──────────────────────┤                │
│  │ Technisch:  3 [●●●]│  │ Sicher (5):    2 [●●]│                │
│  │ Anforderung 2 [●●] │  │ Wahrsch. (4):  2 [●●]│                │
│  │ Termin:     1 [●]  │  │ Möglich (3):   3 [●●●]│               │
│  │ Kosten:     1 [●]  │  │ Unwahr. (2):   1 [●]│                 │
│  │ Personal:   1 [●]  │  │ Sehr u. (1):   0 [ ]│                 │
│  │ Extern:     1 [●]  │  │                      │                │
│  └────────────────────┘  └──────────────────────┘                │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐    │
│  │ TREND (letzte 3 Monate)                                  │    │
│  │ Jan: Avg 11.0  Feb: Avg 10.5  Mär: Avg 9.8    ↘          │    │
│  │ → Trend: Risiken sinken durch Maßnahmen (POSITIV)        │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
│  NEXT REVIEW: 2026-01-27                                         │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

**Alternative: Heatmap-Dashboard:**

```
┌─────────────────────────────────────┐
│ RISIKO-MATRIX (aktueller Stand)     │
│                                     │
│        1    2    3    4    5        │
│    5 [ ]  [ ]  [ ]  [ ] [R8]        │
│    4 [ ] [R5] [R7] [ ] [R4]        │
│ I  3 [ ]  [ ] [R3] [R1] [ ]        │
│ m  2 [ ]  [ ]  [ ] [R2] [ ]        │
│ p  1 [ ]  [ ]  [ ]  [ ] [ ]        │
│ a  ├─────────────────────────────┤  │
│ c  │ FARBCODE:                    │  │
│ t  │ ● Rot:    16–25 (kritisch)  │  │
│    │ ● Orange: 8–15 (hoch)       │  │
│    │ ● Gelb:   4–7 (mittel)      │  │
│    │ ● Grün:   1–3 (niedrig)     │  │
│    │     Likelihood →             │  │
│    └─────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
```

> **Kommentar zu Dashboards:**
> 
> **Zweck:**
> - Quick-View für Daily Standups
> - Trend-Verfolgung über Projektdauer
> - Eskalations-Basis für Governance
> - Kommunikation mit Stakeholdern
> 
> **Best Practice:**
> - Regelmäßige Updates (wöchentlich)
> - Trend-Anzeigen (sind Risiken gestiegen oder gesunken?)
> - Eigenraum für "Closed Risks" (Lernen, nicht nur offene zeigen)
> - Link-Funktion zu Details (klick R4 → zeige alle Infos zu R4)

---

## Aufgabe 9: Fallstudie – Komplettes Risikomanagement-Projekt

### 9.1 & 9.2 – Risikoidentifikation und Bewertung (Beispiel-Lösung)

**Mobile-App-Entwicklung Fitness-Tracker (15 Risiken):**

| ID | Risikobeschreibung | Kategorie | P | I | Wert | Klassif. |
| --- | --- | --- | --- | --- | --- | --- |
| R1 | Anforderungen nicht final mit Kunden abgestimmt | Anforderungen | 5 | 4 | **20** | **Kritisch** |
| R2 | Team-Erweiterung verzögert oder scheitert | Personal | 3 | 4 | **12** | **Hoch** |
| R3 | API-Integration zu Fitness-Devices (3rd Party) nicht dokumentiert | Technisch | 4 | 3 | **12** | **Hoch** |
| R4 | Server-Infrastruktur Capacity-Probleme | Technisch | 3 | 4 | **12** | **Hoch** |
| R5 | Push-Notification-Service-Fehler | Technisch | 2 | 3 | **6** | **Mittel** |
| R6 | iOS App-Store-Zertifizierung verzögert | Extern | 3 | 3 | **9** | **Hoch** |
| R7 | Android Kompatibilitätsprobleme (viele Devices) | Technisch | 4 | 3 | **12** | **Hoch** |
| R8 | Datensicherheit/Sicherheitslücken in Wearable-Integration | Technisch | 2 | 5 | **10** | **Hoch** |
| R9 | Budget-Überrun wegen Scope Creep | Kosten | 4 | 4 | **16** | **Kritisch** |
| R10 | Beta-Tester gewinnen schwierig (Markteing) | Organisatorisch | 2 | 2 | **4** | **Mittel** |
| R11 | Performance auf älteren Smartphones schlecht | Technisch | 4 | 3 | **12** | **Hoch** |
| R12 | Cloud-Provider Kostenschock (unerwartet teuer) | Extern | 2 | 3 | **6** | **Mittel** |
| R13 | Konkurrenzprodukt launched zeitgleich | Extern | 2 | 3 | **6** | **Mittel** |
| R14 | Testing-Umgebung nicht ausreichend für alle Devices | Technisch | 3 | 3 | **9** | **Hoch** |
| R15 | Startup-Team-Burnout / Burnout von Key Developers | Personal | 2 | 4 | **8** | **Hoch** |

**Priorisierungsliste (sortiert):**

| Rank | ID | Wert | Risiko |
| --- | --- | --- | --- |
| 1 | **R1** | **20** | Anforderungen nicht final |
| 2 | **R9** | **16** | Budget-Overrun / Scope Creep |
| 3 | **R2** | **12** | Team-Erweiterung verzögert |
| 4 | **R3** | **12** | API-Integration unklar |
| 5 | **R4** | **12** | Server-Capacity-Probleme |
| 6 | **R7** | **12** | Android-Kompatibilität |
| 7 | **R11** | **12** | Performance auf älteren Smartphones |
| 8 | **R8** | **10** | Datensicherheit/Sicherheitslücken |
| 9 | **R6** | **9** | App-Store-Zertifizierung |
| 10 | **R14** | **9** | Testing-Umgebung |
| 11 | **R15** | **8** | Burnout/Key Resource Burnout |
| 12 | **R5** | **6** | Push-Notification-Fehler |
| 13 | **R12** | **6** | Cloud-Kostenschock |
| 14 | **R13** | **6** | Konkurrenz-Launch |
| 15 | **R10** | **4** | Beta-Tester schwierig |

### 9.3 – Risikomatrix

```
           Auswirkung (Impact) →
             1    2    3    4    5
       5 [ ]  [ ]  [ ]  [ ] [ ]
       4 [ ] [R10] [R12,R13] [R2,R9] [R8]
       3 [ ]  [ ] [R5,R6,R14] [R3,R4,R7,R11] [ ]
   L   2 [ ]  [ ]  [ ]  [R15] [ ]
   i   1 [ ]  [ ]  [ ]  [ ]  [ ]
   k ↓
   e
   l
   i
   h
   o
   o
   d
```

**Oder detaillierter (mit Werten):**

```
R1 (20): P=5, I=4 nicht gezeigt (über 5er-Skala hinaus würde bei 5x5 Matrix sein)
Alternative: Maßstab auf 6-Skala erweitern oder R1 als "Off-Scale" markieren
```

### 9.4 – Kategorie-Analyse

| Kategorie | Anzahl | % | Kritisch | Beobachtung |
| --- | --- | --- | --- | --- |
| **Technisch** | 6 | 40 % | 0 | Dominiert, aber keine einzeln kritisch (kombiniert problematisch) |
| **Anforderungen** | 1 | 7 % | 1 | R1 ist kritisch – zentrale Priorität |
| **Kosten** | 1 | 7 % | 1 | R9 ist kritisch – Scope-Creep-Kontrolle essentiell |
| **Personal** | 2 | 13 % | 0 | Burnout-Risiko ist unterschätzt in Startups |
| **Extern** | 3 | 20 % | 0 | App-Store, Konkurrenz, Cloud-Kosten |
| **Organisatorisch** | 1 | 7 % | 0 | Marketing/Tester sind Nebenrisiken |

**Interpretation:**

```
→ Technisch dominiert (40 %), aber VERTEILT auf viele Device/Platform-Risiken
  → Könnte mit Quality Assurance, Testing, Optimization parallel gelöst werden

→ 2 Kritische (R1 + R9) außerhalb Technisch
  → Anforderungs- und Scope-Discipline sind FOUNDATION

→ Personal (13 %) ist hoch in Startups, aber hier wenig explizit
  → Burnout-Prävention sollte Kultur-Maßnahme sein

→ Extern (20 %) ist teilweise unkontrollierbar
  → Fokus auf eigene Leistung, nicht Konkurrenz jagen

STRATEGIC PRIORITÄT:
1. R1 & R9: Discipline für Anforderungen und Scope → Foundation
2. Tech-Cluster (R3,R4,R7,R11): Parallele Optimierung → QA-Strategy
3. Personal (R2, R15): Culture, Prozesse, Belastungsmanagement
4. Extern: Monitor, aber nicht controllable → Accept with Contingency
```

### 9.5 – Empfehlungen für Steuerung

**1. Sofortmaßnahmen (Woche 1):**

```
R1 (Anforderungen):
- Requirement-Klärung Workshop mit Kunden durchführen (3 Tage)
- Sign-off-Prozess etablieren (bis 31.01.)
- Anforderungs-Lücken-Analyse: fehlende Spezifikationen?
- Prototype für visuelles Feedback (2 Wochen Effort)

R9 (Scope Creep):
- Change-Control-Prozess einführen (ab sofort)
- Scope-Baseline definieren und freezen (bis 28.02.)
- Feature-Priorisierung (Must-Have, Should-Have, Could-Have, Won't-Have)
- Contingency-Budget 20 % reservieren (nicht antasten außer Notfall)
```

**2. Monitoring-Frequency:**

```
WEEKLY (jeden Montag Standup):
- R1, R9 (Kritisch): Status-Update, Blocker, Maßnahmen

BI-WEEKLY (alle 2 Wochen Technical Review):
- R2, R3, R4, R7, R8, R11 (Technisch/Hoch): Deep Dive in technischen Fortschritt
- R6 (App-Store Zertifizierung): Status-Update

MONTHLY (Governance Meeting):
- Alle Risiken: Update für Sponsor/Investor
- Trend-Analyse: Sind Risiken gestiegen/gesunken?
- Eskalations-Entscheidungen
```

**3. Beteiligung von Stakeholdern:**

```
R1 (Anforderungen):
- Owner: Product Manager
- Stakeholder: Kunden (mind. 2–3 Key-User), UX-Designer, Tech Lead

R9 (Scope):
- Owner: Project Manager
- Stakeholder: Product Manager, Finance, Sponsor/Investor

Tech Risiken (R3, R4, R7, R8, R11):
- Owner: Tech Lead / CTO (falls vorhanden)
- Team: Entwickler, QA, DevOps

R2 (Personelle):
- Owner: HR/Gründer
- Maßnahmen: Rekrutierung beschleunigen, Interim-Support, Externe Berater

R15 (Burnout):
- Owner: Gründer/Team-Lead
- Maßnahmen: Workload-Management, Pausen, Überstunden-Limits, Culture-Gespräche
```

**4. Tools & Prozesse:**

```
YouTrack-Setup:
a) Custom Issue Type "Risk" mit Fields:
   - Category (Dropdown): Technisch, Anforderungen, Kosten, Personal, Extern, Org
   - Likelihood (1–5)
   - Impact (1–5)
   - Risk Score (Formula: Likelihood × Impact)
   - Owner (User-Dropdown)
   - Target Resolution Date
   - Mitigation Strategy (wird in Modul 11 gefüllt)

b) Dashboard:
   - Query: Status = Open AND RiskScore >= 12
   - View: Sortiert nach Wert, mit Farb-Coding

c) Workflows:
   - Open → In-Review → Mitigating → Closed
   - Labels für Monitoring-Frequency: "Weekly", "BiWeekly", "Monthly"

d) Regelmäßige Reports:
   - Weekly Risk Report (für Dev-Team)
   - Monthly Risk Summary (für Management)
   - Trend-Analyse (offene Risiken im Zeitverlauf)

Prozesse:
- Weekly Risk-Stand-Up (30 min): Review Top 5 Risiken
- Monthly Risk-Review (1–2 h): Alle Risiken, Neu-Bewertung, Trends
- Incident-Logging: Unerwartete Probleme → Risiko-Register überprüfen (Was haben wir übersehen?)
```

> **Kommentar zu diesem Fallbeispiel:**
> 
> Typisch für **Startup-Projekte**:
> - Aggressive Timeline + mageres Budget → automatisch hohes Risiko
> - **Menschen-Risiken** (Burnout) sind oft unterschätzt
> - **Technische Komplexität** (viele Devices, APIs) erzeugt Verteilte Risiken
> - **Externe Faktoren** (Konkurrenz, App-Store) außerhalb Kontrolle
> - **Scope Creep** ist Klassiker bei Startups (immer noch eine Idee mehr)
> 
> **Success-Faktoren für dieses Projekt:**
> 1. **Discipline bei Anforderungen** (R1) – nicht zu viel, nicht zu wenig
> 2. **Scope-Kontrolle** (R9) – Feature-Priorisierung, MVP-Denken
> 3. **Parallel-Engineering** (Tech-Cluster) – Nicht sequentiell, sondern parallel
> 4. **Team-Gesundheit** (R15) – Burnout-Prävention ist ROI-positiv
> 5. **Kommunikation** – Häufiges Stakeholder-Sync, keine Überraschungen

---

## Aufgabe 10: Reflexion und Transfer

### 10.1 – Selbstbewertung (Beispiel-Antworten)

| Kompetenz | Vorher | Nachher | Fragen/Unsicherheiten |
| --- | --- | --- | --- |
| Risiken identifizieren | 2 | 4 | Wann hört man auf? Wie sichert man Vollständigkeit? |
| Wahrscheinlichkeit schätzen | 1 | 3 | Welche Daten nutzen, wenn historisch keine verfügbar? |
| Auswirkungen bewerten | 2 | 4 | Multi-dimensional oder eine Zahl? Wie aggregieren? |
| Risikowert berechnen | 3 | 5 | Verstanden, aber: P×I oder andere Formeln? |
| Risikomatrix interpretieren | 1 | 4 | Gut, aber: Diagonale Shift ist normal? |
| Kategorisieren | 2 | 3 | Sind Kategorien Universal oder Projekt-spezifisch? |
| YouTrack nutzen | 1 | 3 | Braucht Custom-Field-Setup, kenne die noch nicht |

> **Kommentar zur Selbstbewertung:**
> 
> **Häufige Fragen, die aus dieser Übung entstehen:**
> 
> 1. **Wie sichert man Vollständigkeit der Identifikation?**
>    → Mehrere Techniken kombinieren (Brainstorm + Checklisten)
>    → Mehrere Runden (nicht alles in einer Session)
>    → Retrospektiv überprüfen: Was haben wir übersehen? Lessons Learned
> 
> 2. **Wahrscheinlichkeit schätzen ohne historische Daten?**
>    → Expertenurteil (mehrere Experten mitteln)
>    → Analoge Projekte heranziehen
>    → Szenario-Denken: Best/Likely/Worst
>    → Akzeptieren, dass Unsicherheit bleibt (ist ok!)
> 
> 3. **Multi-dimensional oder eine Zahl?**
>    → Für komplexe Projekte: Multi-dimensional (Zeit, Kosten, Qualität)
>    → Für einfache Projekte: Eine Haupt-Dimension
>    → Finaler Score: Mit Gewichtung kombieren
> 
> 4. **YouTrack Custom Fields:**
>    → Setup erfordert Admin-Zugriff
>    → Oder: Einfach Kommentar-Felder nutzen (weniger Automation, aber machbar)
>    → Alternativen: Excel (einfach, aber nicht kollaborativ) oder Jira (ähnlich YouTrack)

### 10.2 – Transfer auf eigenes Projekt (Muster-Dokumentation)

**Beispiel-Ausfüllung:**

```
Projekt: Webshop-Relaunch (E-Commerce-Plattform)

Identifizierungsmethoden: 
- [X] Brainstorming (3-h-Session mit Dev, QA, Ops)
- [X] Checkliste (PM-Standard-Katalog für Relaunch-Projekte)
- [ ] Delphi 
- [X] Interviews (mit 3 Key-Stakeholder)
- [X] Lessons Learned (aus letztem Relaunch vor 3 Jahren)

Top-5 Risiken:
1. Datenverlust/Korruption beim Umzug → Migration schlägt fehl oder Daten inkonsistent
2. Performance unter Last am Go-Live-Tag → > 10 sec Antwortzeiten, Kundenkritik
3. Zahlungs-Integration nicht funktionsfähig → Bestellungen nicht abschließbar
4. Alte Plattform kann nicht abgeschaltet werden (Abhängigkeiten) → Extended Hybrid-Mode nötig
5. Team nicht trainiert auf neue Betriebsprozesse → Post-Go-Live Support-Chaos

Kritische Erkenntnisse:
- Migration ist größtes Einzelrisiko → Deserves 2-3 Wochen Vorbereitung/Testing
- Performance ist User-Facing → Höchste Kundenimpact
- Integration (Zahlungen, Fulfillment) kritischer als Features
- Alte Plattform ist Dependency – Migration ist NICHT binary (kann nicht einfach abschalten)

Nächste Schritte für Modul 11 (Reaktionsplanung):
- Migration Dry-Run Mitte Jan. durchführen (Test aller Szenarien)
- Load-Test durchführen, Bottlenecks identifizieren
- Zahlungs-Integration früh validieren (nicht bis Go-Live warten)
- Hybrid-Mode Strategie klären (wie lange alte + neue Plattform parallel?)
- Support-Team für Go-Live-Day vorbereiten (Eskalations-Szenarien üben)
```

### 10.3 – Häufig gestellte Fragen (typische Fragen aus Trainingserfahrung)

```
1. Q: Wie viele Risiken sollte ein Projekt haben?
   A: Kein Standard. Typisch: 10–30 Risiken für mittlere Projekte (bei jährlicher 
      Duration). Weniger als 5 = wahrscheinlich unvollständig. Mehr als 50 = 
      wahrscheinlich zu detailliert oder zu pessimistisch.

2. Q: Was tun mit Risiken mit niedriger Wahrscheinlichkeit, aber hohem Impact?
   A: Diese sind oft UNTERSCHÄTZT, weil sie selten sind. Aber wenn sie eintreten, 
      sind sie katastrophal. Beispiel: Datencenter-Brand (P=1, I=5). Trotz niedriger 
      P sollten diese managed werden (Versicherung, Backup-Standort).

3. Q: Ist Risiko-Register lebendig oder statisch?
   A: LEBENDIG! Sollte mindestens monatlich überprüft werden. Neue Risiken können 
      auftauchen, alte können sich verringern (durch erfolgreiche Maßnahmen) oder 
      realisieren (werden zu Problemen).

4. Q: Wie unterscheidet sich Risiko-Management von Change Management?
   A: Risiko = potentiell, proaktiv. Change Mgmt = eingetretene Änderung, reaktiv. 
      Aber: Gutes Risiko-Mgmt kann viele Changes verhindern (z.B. durch frühe 
      Anforderungs-Klärung).

5. Q: Können wir das Risiko-Management übertreiben (zu viel dokumentieren)?
   A: Ja! Klassisches Overengineering: 50 Felder, 3-stufige Approval, wöchentliche 
      Berichte. Am Ende: Niemand nutzt es. Besser: Lean Approach mit den 
      essentiellen Feldern und monatlicher Cadence.

6. Q: Wer ist für Risiko-Owner verantwortlich?
   A: Die Person, die am besten in der Position ist, das Risiko zu *detektieren* 
      und *auf* *Maßnahmen hinzuarbeiten*. Nicht unbedingt der PM. Technische Risiken 
      → Tech-Lead, Personal-Risiken → HR, Kosten-Risiken → Finance.

7. Q: Was ist die Differenz zwischen Risiko-Analyse und Risiko-Bewertung?
   A: Risiko-Analyse = Verstehen des Risikos (What? Why? How?). 
      Risiko-Bewertung = Quantifizierung (P? I? Score?). Analysis ≠ Bewertung.
      Manche Risiken sind schwer zu bewerten, obwohl klar analysiert.

8. Q: Sollen wir auch positive Risiken (Chancen) gleich wie negative tracken?
   A: Idealerweise ja (symmetrisch). Aber in der Praxis: 80 % Fokus auf Threats, 
      20 % auf Opportunities. Beide sollten Maßnahmen-Plans haben, um Chancen 
      nicht zu verschlafen.
```

---

## Checkliste zum Abschluss

Überprüfen Sie, ob Sie diese Punkte verstanden haben und durchgeführt haben:

- [X] Ich verstehe die Definition von Risiken und kann sie von Problemen unterscheiden
- [X] Ich kenne mindestens 4 Techniken zur Risikoidentifikation (Brainstorm, Checklisten, Delphi, Interviews, etc.)
- [X] Ich kann Risiken nach Wahrscheinlichkeit (1–5 Skala) und Auswirkung (1–5 Skala) bewerten
- [X] Ich kann Risikowerte berechnen (P × I) und Risiken nach Priorität sortieren
- [X] Ich kann eine Risikomatrix interpretieren und Cluster identifizieren
- [X] Ich habe Risiken kategorisiert (Technisch, Terminlich, Kosten, Anforderungen, Personal, Org, Extern)
- [X] Ich weiß, wie ich Risiken in YouTrack erfassen kann (Custom Issue Type, Fields, Workflows)
- [X] Ich bin bereit, ein Reaktionskonzept (Modul 11) für meine Top-Risiken zu entwickeln (Vermeiden, Mindern, Abwälzen, Akzeptieren)
