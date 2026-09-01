## Überblick und Lernziele

Dieses Modul vertieft die Konzepte aus Modul 6 und führt Sie in fortgeschrittene Planungs- und Steuerungstechniken ein. Nach Abschluss dieses Moduls werden Sie in der Lage sein:

- **Gantt-Diagramme** professionell zu erstellen und zu interpretieren
- Den **kritischen Pfad (Critical Path Method, CPM)** zu berechnen und zu visualisieren
- **Ressourcenabhängige Umplanungen** durchzuführen (Ressourcen-Leveling)
- Zeitpuffer richtig einzusetzen und zu verwalten
- Terminverzögerungen zu erkennen und Maßnahmen einzuleiten
- Den Zusammenhang zwischen Zeit-, Ressourcen- und Kostenplanung zu verstehen

Dieses Modul baut direkt auf Modul 6 auf und konzentriert sich auf die **praktische Umsetzung** sowie die **Optimierung** von Projektplänen.

---

## Thematische Schwerpunkte

### 1. Gantt-Diagramme – Visualisierung und Verwaltung von Projektzeitplänen

#### Was ist ein Gantt-Diagramm?

Ein **Gantt-Diagramm** (auch Balkenplan genannt) ist eine grafische Darstellungsmethode, die Aktivitäten (Aufgaben) als horizontale Balken auf einer Zeitachse darstellt. Es wird verwendet, um:

- Den zeitlichen Ablauf von Aktivitäten zu visualisieren
- Abhängigkeiten zwischen Aufgaben zu zeigen
- Termine und Meilensteine zu kennzeichnen
- Den Projektfortschritt zu überwachen
- Kapazitäten und Ressourcen abzubilden

#### Aufbau eines Gantt-Diagramms

| Element | Erklärung |
|---------|-----------|
| **Aktivitätsname** | Auflistung aller Projektaufgaben (linke Spalte) |
| **Zeitachse** | Horizontale Achse mit Zeiteinheiten (Tage, Wochen, Monate) |
| **Balken** | Länge und Position zeigen Start, Dauer und Ende einer Aktivität |
| **Abhängigkeitslinien** | Verbindungslinien zwischen Balken zeigen logische Abhängigkeiten |
| **Meilensteine** | Symbole (Rauten, Diamanten) kennzeichnen wichtige Ereignisse |
| **Heute-Linie** | Vertikale Linie markiert das aktuelle Datum für Fortschrittsverfolgung |

#### Typen von Abhängigkeiten im Gantt-Diagramm

| Abhängigkeitstyp | Symbol/Bezeichnung | Erklärung | Beispiel |
|---|---|---|---|
| **Ende-Anfang (EA)** | Häufigste Form | Aktivität B kann erst starten, wenn Aktivität A beendet ist | Fundament fertig → Mauern beginnen |
| **Anfang-Anfang (AA)** | Parallele Start | Aktivität B startet zeitgleich mit A (oder mit Verzögerung) | Planung und Budgetierung parallel |
| **Ende-Ende (EE)** | Zeitliche Kopplung | Aktivität B muss zeitgleich mit A enden | Dokumentation und Tests parallel |
| **Anfang-Ende (AE)** | Seltene Form | Aktivität B endet, wenn A beginnt | Gültig z.B. bei Maschinenstilllegungen |

#### Zeitpuffer (Slack/Float) im Gantt-Diagramm

**Zeitpuffer** sind verfügbare Zeitreserven, die zeigen, wie viel Spielraum eine Aktivität hat, ohne den Gesamtprojekttermin zu gefährden.

**Arten von Zeitpuffern:**

- **Freier Puffer (Free Float)**: Die Zeitreserve einer Aktivität ohne Auswirkung auf nachfolgende Aktivitäten
- **Gesamter Puffer (Total Float)**: Die Zeitreserve einer Aktivität ohne Auswirkung auf den Projektendtermin
- **Kritischer Puffer**: Aktivitäten ohne Puffer (Puffer = 0) liegen auf dem kritischen Pfad

**Praktische Bedeutung:**
- Aktivitäten mit Puffer können flexibel geplant werden
- Aktivitäten ohne Puffer sind kritisch und erfordern ständige Überwachung
- Bei Terminverzögerungen auf dem kritischen Pfad verzögert sich das gesamte Projekt

#### Gantt-Diagramme in YouTrack

**YouTrack** bietet integrierte Planungstools:
- **Gantt-View**: Visualisierung von Issues und Meilensteinen auf einer Zeitachse
- **Abhängigkeitsmanagement**: Markieren von Abhängigkeiten zwischen Issues (Blocker, wird blockiert von)
- **Ressourcenzuordnung**: Anzeige, welche Teamangehörigen an welchen Aufgaben arbeiten
- **Fortschrittsanzeige**: Prozentuale Fertigstellung einzelner Aktivitäten
- **Filter und Gruppierung**: Nach Phase, Team, Priorität oder Verantwortlichkeit

---

### 2. Der kritische Pfad (Critical Path Method – CPM)

#### Definition und Bedeutung

Der **kritische Pfad** ist die längste Abfolge von abhängigen Aktivitäten von Projektstart bis -ende. Sein Umfang bestimmt die **kürzestmögliche Projektdauer**. 

**Kernprinzipien:**
- Der kritische Pfad hat einen Gesamtzeitpuffer von **Null** (oder minimal)
- Jede Verzögerung auf dem kritischen Pfad verzögert das gesamte Projekt
- Aktivitäten außerhalb des kritischen Pfads haben Zeitpuffer und bieten Optimierungsspielraum

#### Berechnung des kritischen Pfades

**Schritt 1: Vorwärtsrechnung (Forward Pass)**
Bestimme den frühesten Start- und Endzeitpunkt jeder Aktivität.

| Symbol | Bedeutung |
|--------|-----------|
| **FAS** (Früher Anfangstermin) | Frühestmöglicher Startzeitpunkt einer Aktivität |
| **FES** (Früher Endtermin) | Frühestmöglicher Endzeitpunkt einer Aktivität |
| **Formel** | FES = FAS + Dauer |

**Schritt 2: Rückwärtsrechnung (Backward Pass)**
Bestimme den spätesten Start- und Endzeitpunkt jeder Aktivität ohne Verzögerung des Projekts.

| Symbol | Bedeutung |
|--------|-----------|
| **SAS** (Später Anfangstermin) | Spätestmöglicher Startzeitpunkt ohne Projektverzögerung |
| **SES** (Später Endtermin) | Spätestmöglicher Endzeitpunkt ohne Projektverzögerung |
| **Formel** | SAS = SES − Dauer |

**Schritt 3: Pufferberechnung**
Berechne den Gesamtzeitpuffer für jede Aktivität.

$$ \text{Gesamtzeitpuffer} = \text{SAS} - \text{FAS} = \text{SES} - \text{FES} $$

**Schritt 4: Kritischen Pfad identifizieren**
Alle Aktivitäten mit einem Gesamtzeitpuffer von **Null** oder **minimal** bilden den kritischen Pfad.

#### Praktisches Beispiel: CPM-Berechnung

Nehmen Sie folgende vereinfachte Projektstruktur an:

| Aktivität | Dauer (Tage) | Abhängigkeit | FAS | FES | SAS | SES | Puffer |
|-----------|---|---|---|---|---|---|---|
| A (Planung) | 5 | — | 0 | 5 | 0 | 5 | 0 |
| B (Beschaffung) | 10 | Nach A | 5 | 15 | 5 | 15 | 0 |
| C (Vorbereitung) | 3 | Nach A | 5 | 8 | 12 | 15 | 7 |
| D (Umsetzung) | 8 | Nach B, C | 15 | 23 | 15 | 23 | 0 |

**Kritischer Pfad:** A → B → D (Gesamtdauer: 23 Tage)

**Aktivität C** hat einen Puffer von 7 Tagen und kann verzögert werden, ohne das Projekt zu gefährden.

#### Visualisierung des kritischen Pfades

Der kritische Pfad wird in Gantt-Diagrammen typischerweise durch:
- **Rote oder dunkelgraue Färbung** hervorgehoben
- **Dickere Balken** oder spezielle Symbole gekennzeichnet
- **Pfeillinien** zur Kennzeichnung der Abhängigkeitskette

---

### 3. Ressourcen-Leveling (Ressourcenabhängige Umplanung)

#### Problemstellung: Ressourcenkonflikte

In realen Projekten entstehen oft **Ressourcenkonflikte**, wenn:
- Mehrere Aktivitäten gleichzeitig dieselbe Person benötigen
- Spezialisierte Fähigkeiten begrenzt verfügbar sind
- Maschinen oder Geräte überlastet sind
- Budgetgrenzen überschritten würden

**Folgen:**
- Verzögerungen durch sequenzielle Umdisposition
- Qualitätsprobleme durch Multitasking
- Kostensteigerungen durch Überstunden

#### Definition: Ressourcen-Leveling

**Ressourcen-Leveling** (auch Ressourcenausgleich oder Ressourcenglättung genannt) ist eine Technik, um Ressourcenkonflikte zu lösen, ohne den Gesamtprojekttermin zu überschreiten.

**Ziele:**
- Ressourcenauslastung **gleichmäßiger verteilen**
- Ressourcenspitzen **reduzieren**
- **Kostenschwankungen** glätten
- Ressourcenkonflikte **auflösen**

#### Strategien des Ressourcen-Levelings

| Strategie | Beschreibung | Einsatz |
|-----------|---|---|
| **Verschiebung von Aktivitäten mit Puffer** | Aktivitäten mit freiem Puffer werden verschoben, um Konflikte zu vermeiden | Bevorzugt, da kein Risiko für Gesamttermin |
| **Parallelisierung reduzieren** | Geplant parallele Aktivitäten werden sequenzialisiert | Erhöht Projektdauer; nur bei extremem Engpass |
| **Ressourcenumverteilung** | Ressourcen werden zwischen Aktivitäten umgelagert | Erfordert Flexibilität und Qualifikation |
| **Externe Ressourcen hinzufügen** | Leiharbeiter, Subunternehmer, zusätzliche Tools | Kostenintensiv; wird nur bei kritischem Engpass gewählt |
| **Aktivitätssplitting** | Aktivität wird unterbrochen und später fortgesetzt | Oft ineffizient wegen Kontextwechsel |

#### Ressourcen-Leveling in der Praxis

**Schritte beim manuellen Ressourcen-Leveling:**

1. **Ressourcenauslastung analysieren**: Erstelle ein Ressourcenhistogramm oder eine Kapazitätsmatrix
2. **Konflikte identifizieren**: Markiere Zeiträume mit Überauslastung
3. **Prioritäten setzen**: Welche Aktivitäten sind kritisch? Welche haben Puffer?
4. **Verschiebungsoptionen prüfen**: Welche Aktivitäten können ohne Risiko verschoben werden?
5. **Umplan durchführen**: Passe Start- und Enddaten an
6. **Auswirkungen bewerten**: Ändert sich der kritische Pfad? Entstehen neue Konflikte?
7. **Plan kommunizieren**: Informiere das Team über Änderungen

#### Ressourcen-Leveling in YouTrack

**Praktische Anwendung:**
- **Ressourcenansicht**: Zeigt Auslastung einzelner Teamangehöriger
- **Issue-Zuordnung**: Weise Issues zu Personen mit Aufwandsschätzung zu
- **Kapazitätsplanung**: Nutze Zeiterfassung zur Überwachung verfügbarer Kapazität
- **Abhängigkeiten**: Nutze Abhängigkeiten zwischen Issues, um Sequenzierungen zu erzwingen
- **Automatische Anpassung**: Bei Änderungen (z.B. Verzögerung) können abhängige Issues automatisch neu geplant werden

---

### 4. Terminverzögerungen erkennen und managen

#### Arten von Terminverzögerungen

| Typ | Ursachen | Auswirkungen | Gegenmaßnahmen |
|---|---|---|---|
| **Aktivitätsverzögerung** | Ressourcenmangel, Qualitätsprobleme, externe Faktoren | Lokale Verzögerung, ggf. auf kritischen Pfad übertragbar | Ressourcenoptimierung, Priorisierung |
| **Kritische Pfadverzögerung** | Verzögerung auf dem kritischen Pfad | Direkte Projektverzögerung | Beschleunigung (Crashing, Fast-Tracking) |
| **Kaskadierende Verzögerung** | Verzögerung in Vorgängern blockiert mehrere Nachfolger | Mehrfachverzögerung | Abhängigkeiten auflösen, Parallelisierung |
| **Ressourcenengpass** | Beschaffung von Ressourcen verzögert sich | Gesamtprojekt verzögert | Frühzeitige Beschaffung, Alternative suchen |

#### Früherkennung von Terminrisiken

**Indikatoren für potenzielle Verzögerungen:**
- Aktivitäten, deren Fortschritt unter 50% liegt, aber 50% der geplanten Dauer vorbei ist
- Aktivitäten auf dem kritischen Pfad mit Ressourcenkonflikten
- Unvorhergesehene Abhängigkeiten, die während der Durchführung entdeckt werden
- Externe Lieferverzögerungen
- Qualitätsprobleme, die zu Rework führen

**Monitoring-Methoden in YouTrack:**
- **Regelmäßige Issue-Status-Updates**: Team markiert Fortschritt und Blocker
- **Burn-Down-Charts** (bei Sprints): Visualisierung des Fortschritts gegen Plan
- **Milestone-Tracking**: Überwachung von Meilenstein-Terminen
- **Alert-Regeln**: Automatische Benachrichtigung bei überfälligen Issues

#### Beschleunigungsmaßnahmen (Crashing & Fast-Tracking)

**Crashing (Ressourcenintensivierung)**
- Zusätzliche Ressourcen einsetzen (Überstunden, externe Kraft)
- Kürzeste Dauer: Verkürzt den kritischen Pfad um wenige Tage
- **Kosten:** Erheblich; nur bei kritischen Verzögerungen sinnvoll

**Fast-Tracking (Parallelisierung)**
- Normalerweise sequenzialisierte Aktivitäten werden teilweise parallel durchgeführt
- **Voraussetzung:** Abhängigkeiten müssen geklärt werden
- **Risiko:** Erhöhte Fehlerquote durch unvollständige vorherige Aktivitäten
- **Beispiel:** Design und Prototypentwicklung teilweise parallel statt hintereinander

---

### 5. Zusammenhang: Zeit-, Ressourcen- und Kostenplanung

#### Das Magische Dreieck (Triple Constraint)

Im Projektmanagement sind **Zeit, Kosten und Qualität** eng miteinander verflochten:

```
        Qualität
           /\
          /  \
         /    \
        /      \
       /________\
      Zeit   Kosten
```

**Auswirkungen:**
- **Zeit reduzieren** → Ressourcen und Kosten erhöhen (Überstunden, externe Kraft)
- **Kosten reduzieren** → Zeit erhöht sich oder Qualität sinkt (weniger Ressourcen)
- **Qualität erhöhen** → Zeit und Kosten steigen (intensivere Prüfung, bessere Ressourcen)

#### Zeit-Kosten-Funktion

Für viele Aktivitäten gibt es eine **nicht-lineare Beziehung** zwischen Dauer und Kosten:

- **Normalplan**: Geplante Dauer mit normalen Ressourcen und Kosten
- **Crashplan**: Minimale Dauer mit maximalen Kosten
- **Optimale Lösung**: Oft liegt ein Punkt zwischen Normal und Crash, der beste Kosten-Zeit-Effizienz bietet

**Praktische Auswirkung:**
- Ressourcen-Leveling kann Projektkosten senken (weniger Parallelisierung = weniger Overhead)
- Aber: Längeres Projekt = höhere Fixkosten (Projektleitung, Infrastruktur)

---
### Empfehlung für Software-Einsatz

**Gantt-Diagramme erstellen:**
- **MS Project**: Professionell, komplexe Funktionen
- **Open Project**: Kostenlose Open-Source-Alternative
- **Excel/Sheets**: Einfache Gantt-Diagramme per Hand möglich
- **YouTrack**: Integrierte Gantt-View für agile und klassische Projekte

**CPM-Berechnung:**
- **Excel-Tabelle**: Transparent, für Schulung ideal
- **Spezialisierte Tools**: Microsoft Project, SmartSheet
- **Papier-Netzwerk (PDM)**: Für tiefes Verständnis

**Ressourcen-Leveling:**
- **Microsoft Project**: Automatische Algorithmen
- **Asana, Monday.com**: Vereinfachte Ressourcenoptimierung
- **YouTrack**: Integrierte Ressourcenansicht

---
## Wichtige Begriffserklärungen (Glossar)

| Begriff | Definition | Kontext |
|---------|-----------|---------|
| **Gantt-Diagramm** | Balkendiagramm zur Visualisierung von Projektzeitplänen | Zeitplanung, Kommunikation |
| **Kritischer Pfad** | Längste Abfolge abhängiger Aktivitäten; bestimmt Projektdauer | CPM, Risikoanalyse |
| **Zeitpuffer / Slack** | Zeitreserve einer Aktivität ohne Projektverzögerung | Planung, Flexibilität |
| **CPM (Critical Path Method)** | Netzplantechnik zur Berechnung des kritischen Pfades | Zeitmanagement |
| **Ressourcen-Leveling** | Optimierung der Ressourcenverteilung zur Konfliktlösung | Ressourcenmanagement |
| **Vorwärtsrechnung** | Berechnung frühester Start- und Endtermine | CPM |
| **Rückwärtsrechnung** | Berechnung spätester Start- und Endtermine | CPM |
| **Crashing** | Verkürzung der Projektdauer durch zusätzliche Ressourcen | Beschleunigung |
| **Fast-Tracking** | Parallelisierung normalerweise sequenzieller Aktivitäten | Beschleunigung, Risikoerhöhung |
| **Abhängigkeit (Predecessor)** | Logische oder ressourcenbezogene Beziehung zwischen Aktivitäten | Projektstrukturierung |
| **Meilenstein (Milestone)** | Markante Punkte im Projektablauf mit hoher Sichtbarkeit | Kontrolle, Kommunikation |

## Lernzielkontrollen

Am Ende des Moduls sollten die Teilnehmer diese Fragen beantworten können:

1. Wie unterscheiden sich Gantt-Diagramme von Netzplänen?
2. Wie berechne ich den kritischen Pfad einer Projektstruktur?
3. Was ist der Unterschied zwischen freiem Puffer und Gesamtzeitpuffer?
4. Welche Strategien gibt es für Ressourcen-Leveling?
5. Was sind die Auswirkungen von Crashing und Fast-Tracking auf Kosten und Qualität?
6. Wie erkenne ich frühzeitig Terminverzögerungen?
7. Wie nutze ich YouTrack zur Gantt-Planung und Ressourcenverwaltung?
8. Wie wirken sich Zeit-, Ressourcen- und Kostenplanung gegenseitig aus?

---
## Verknüpfung zu anderen Modulen

- **Modul 5 (WBS)**: Grundlage für Zeitmanagement – ohne klare Struktur kein sauberer Zeitplan
- **Modul 6 (Zeitmanagement I)**: Meilensteine, Abhängigkeiten und Basis-Netzpläne
- **Modul 8 (Ressourcenplanung)**: Vertiefung des Ressourcen-Levelings
- **Modul 9 (Kostenplanung)**: Zeit-Kosten-Optimierung und Budgetierung
- **Modul 15 (Controlling)**: Überwachung und Steuerung des Zeitplans während Durchführung
- **Modul 17 (Agile)**: Alternative Zeitmanagemnt-Ansätze (Sprints statt ganzzeitliche CPM)