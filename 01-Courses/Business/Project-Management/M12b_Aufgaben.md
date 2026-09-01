## Aufgabe 1: Qualitätskriterien definieren

### Szenario
Sie sind Projektmanager eines **Software-Entwicklungsprojekts** für ein E-Commerce-System. Der Kunde möchte ein stabiles, schnelles und benutzerfreundliches System.

### Aufgabenstellung

Definieren Sie **mindestens 5 konkrete Qualitätskriterien** für dieses Projekt. Nutzen Sie dabei folgende Vorlage:

| Nr. | Qualitäts-kriterium | Messbarer Indikator | Zielwert | Priorität | Inspektions-methode |
|-----|-------------------|-------------------|---------|-----------|-------------------|
| 1 | | | | ☐ High ☐ Medium ☐ Low | |
| 2 | | | | ☐ High ☐ Medium ☐ Low | |
| 3 | | | | ☐ High ☐ Medium ☐ Low | |
| 4 | | | | ☐ High ☐ Medium ☐ Low | |
| 5 | | | | ☐ High ☐ Medium ☐ Low | |

### Lösungshinweise
Denken Sie an:
- Funktionalität (das System funktioniert wie gewünscht)
- Performance (Reaktionszeit, Durchsatz)
- Sicherheit (Datenschutz, Authentifizierung)
- Usability (einfache Bedienung)
- Zuverlässigkeit (Verfügbarkeit, Fehlertoleranz)

---

## Aufgabe 2: Testplan für eine Projektphase entwickeln

### Szenario
Das E-Commerce-Projekt befindet sich in der **Entwicklungsphase**. Bevor die Entwicklung in die Testphase geht, sollen interne Inspektionen durchgeführt werden.

### Aufgabenstellung

Entwickeln Sie einen **Testplan für die Entwicklungsphase** mit folgenden Elementen:

**A) Testphasen und -arten** (Nutzen Sie die V-Modell-Logik)

| Test-Phase | Zeitpunkt | Umfang | Testverantwortung | Dauer (Tage) |
|-----------|-----------|--------|-------------------|-------------|
| | | | | |
| | | | | |
| | | | | |

**B) Inspektionspunkte** – Was und Wann überprüfen?

- [ ] Anforderungsspezifikation validieren (Wann?)
- [ ] Design-Review (Wann?)
- [ ] Code-Review (Wann?)
- [ ] Komponententest (Wann?)
- [ ] Weitere?

**C) Verantwortlichkeiten**

| Rolle | Aufgaben im Testplan |
|------|---------------------|
| Projektmanager | |
| Entwickler | |
| Tester / QA | |
| Kunde / Business Analyst | |

### Lösungshinweise
Arbeiten Sie nach dem V-Modell: Jede Planungsphase hat eine entsprechende Testphase. Denken Sie an:
- Wer prüft? (intern/extern?)
- Womit wird geprüft? (manuell/automatisiert?)
- Wie lange dauert jede Phase realistisch?

---

## Aufgabe 3: Fehlerklassifizierung und Priorisierung

### Szenario
Im Testing werden folgende **5 Fehler** gefunden:

1. **Fehler A**: Die Login-Funktion funktioniert nicht – Benutzer können sich nicht anmelden
2. **Fehler B**: Die Produktbilder werden mit falscher Größe angezeigt (zu klein)
3. **Fehler C**: Beim Speichern von Bestellungen wird eine Datenbank-Exception ausgegeben; Bestellung wird nicht gespeichert
4. **Fehler D**: Die Seite zeigt manchmal "Willkomen" statt "Willkommen" (Typo)
5. **Fehler E**: Die Systemanforderungen erwähnen Windows 7, aber die App startet dort nicht

### Aufgabenstellung

Klassifizieren Sie die Fehler nach **Severity** (Critical, High, Medium, Low) und **Priorität** (sofort beheben, baldmöglichst, später, optional) und begründen Sie Ihre Entscheidung.

| Fehler | Severity | Priorität | Begründung |
|--------|----------|-----------|-----------|
| A | | | |
| B | | | |
| C | | | |
| D | | | |
| E | | | |

### Zusatz-Frage
Welche dieser Fehler würden Sie **vor dem Go-Live** auf jeden Fall beheben müssen? Markieren Sie mit ✓.

---

## Aufgabe 4: YouTrack für Defect-Tracking nutzen

### Szenario
Sie verwenden **YouTrack**, um Fehler zu tracken. Ein Fehler wird als "High Severity Bug" klassifiziert und muss durch den Workflow navigiert werden.

### Aufgabenstellung

**A) Definieren Sie einen Defect-Workflow** für YouTrack mit folgenden Phasen:

```
Workflow für Bug-Management:

[Neu eingegeben] 
    ↓ (Triage durchgeführt)
[???]  ← Übernehmen Sie den Namen der Phase
    ↓ (Zugewiesen an Entwickler)
[???]  ← Übernehmen Sie den Namen der Phase
    ↓ (Implementiert und getestet)
[???]  ← Übernehmen Sie den Namen der Phase
    ↓ (Von QA validiert)
[Closed]
```

**B) Custom-Fields für Bugs** – Welche zusätzlichen Felder brauchen Sie?

| Custom-Field | Typ (Text/Liste/Zahl) | Mögliche Werte |
|-------------|----------------------|----------------|
| Severity | | ☐ Critical ☐ High ☐ Medium ☐ Low |
| | | |
| | | |

**C) Defect-Report-Template** – Wie soll ein Bug in YouTrack dokumentiert werden?

```
**Issue-Typ:** Bug
**Titel:** [Prägnante Zusammenfassung]
**Beschreibung:**
- Komponente:
- Schritte zum Reproduzieren:
- Aktuelles Verhalten:
- Erwartetes Verhalten:
- Umgebung (Browser, OS, Version):
- Screenshots/Logs (falls vorhanden):

**Severity:** [Critical | High | Medium | Low]
**Found In Phase:** [Test Phase]
**Assigned To:** [Entwickler]
**Root Cause:** [wird später gefüllt]
**Fix Verified:** [wird später gefüllt]
```

### Lösungshinweise
Denken Sie an:
- Welche Zustände durchläuft ein Bug durchschnittlich?
- Wer schließt einen Bug? (nur QA, nicht der Entwickler selbst)
- Welche Informationen helfen Entwicklern, Bugs schneller zu finden?

---

## Aufgabe 5: Qualitätsmetriken für ein Projekt ermitteln

### Szenario
Das E-Commerce-Projekt hat folgende Daten aus der Testphase erzeugt:

**Gesammelte Rohdaten:**
- Gesamter Code: 50.000 Zeilen
- Code mit Unit Tests abgedeckt: 45.000 Zeilen
- Gefundene Bugs insgesamt: 85
- Davon vor UAT gefunden: 80
- In Produktion gelangter Fehler: 5
- Durchschnittliche Zeit zur Fehlerbehebung: 2,5 Tage
- Abgelehnte Anforderungen in UAT: 2
- Akzeptierte Anforderungen in UAT: 48

### Aufgabenstellung

Berechnen Sie folgende **Qualitätsmetriken** und beurteilen Sie, ob das Projekt die erwartete Qualität erreicht:

| Metrik | Formel | Berechnung | Ergebnis | Bewertung (OK/kritisch) |
|--------|--------|-----------|---------|------------------------|
| **Test Coverage** | (Code mit Tests / Gesamtcode) × 100 | | **___%** | |
| **Defect Escape Rate** | (Bugs in Produktion / Gefundene Bugs) × 100 | | **___%** | |
| **Acceptance Rate** | (Akzeptierte Anforderungen / Gesamt-Anforderungen) × 100 | | **___%** | |
| **Mean Time To Fix (MTTF)** | Durchschn. Zeit zur Fehlerbehebung | | **__ Tage** | |

### Fragen zur Interpretation

1. Ist die Test Coverage ausreichend? (Zielwert: ≥ 80%)
2. Ist die Defect Escape Rate akzeptabel? (Zielwert: ≤ 1%)
3. Können Sie das Projekt freigeben? Begründen Sie.

---

## Aufgabe 6: Inspektionen durchführen – Code Review Checkliste

### Szenario
Ein Entwickler hat folgende Python-Funktion geschrieben. Sie führen einen **Code Review** durch.

```python
def calculate_order_total(items):
    total = 0
    for item in items:
        total = total + item['price'] * item['quantity']
    return total

def get_user_from_db(user_id):
    # This function queries the database for a user
    db_connection = connect_to_db()
    query = "SELECT * FROM users WHERE id = " + str(user_id)
    result = db_connection.execute(query)
    return result[0]
```

### Aufgabenstellung

Führen Sie anhand folgender **Code-Review-Checkliste** einen Inspektion durch:

| Kategorie | Kriterium | Status | Feedback / Fehler |
|-----------|-----------|--------|------------------|
| **Funktionalität** | Macht die Funktion das, was sie soll? | ☐ OK ☐ NOK | |
| **Fehlerbehandlung** | Sind Exception Handling vorhanden? | ☐ OK ☐ NOK | |
| **Sicherheit** | Gibt es SQL-Injection oder andere Sicherheitslücken? | ☐ OK ☐ NOK | |
| **Performance** | Ist der Code performant (keine unnötigen Schleifen)? | ☐ OK ☐ NOK | |
| **Readability** | Ist der Code leicht zu verstehen? | ☐ OK ☐ NOK | |
| **Standards** | Folgt der Code den Team-Coding-Standards? | ☐ OK ☐ NOK | |
| **Dokumentation** | Ist die Funktion dokumentiert (Docstring)? | ☐ OK ☐ NOK | |
| **Testing** | Gibt es Unit Tests für die Funktion? | ☐ OK ☐ NOK | |

### Lösungshinweise
Notieren Sie für jeden Fehler:
- Was ist das Problem?
- Warum ist es ein Problem?
- Wie könnte man es verbessern?

---

## Aufgabe 7: Fall-Szenario – Qualitätsplan erstellen

### Szenario – Bauprojekt
Sie leiten ein **Bauprojekt** zur Sanierung eines Bürogebäudes. Der Kunde hat hohe Erwartungen an die Qualität. Das Projekt dauert 12 Wochen.

**Projektphasen:**
1. Vorbereitung & Planung (Woche 1-2)
2. Abbruch & Vorbereitung (Woche 3-4)
3. Rohbau & Elektroinstallation (Woche 5-8)
4. Innenausbau (Woche 9-11)
5. Abnahme & Übergabe (Woche 12)

### Aufgabenstellung

Erstellen Sie einen **vollständigen Qualitätsplan** mit folgenden Abschnitten:

**1. Qualitätsziele** (mindestens 3)
- Z.B.: Alle Arbeiten entsprechen DIN-Normen
- Z.B.: Kundenzufriedenheit ≥ 9/10

**2. Qualitätskriterien pro Phase** (Tabelle)

| Phase | Qualitätskriterium | Inspektionsmethode | Zeitpunkt |
|-------|------------------|-------------------|-----------|
| Vorbereitung | z.B. Pläne korrekt? | Review durch Architekt | Woche 2 |
| | | | |
| Abbruch | | | |
| | | | |
| Rohbau | | | |
| | | | |
| | | | |
| Innenausbau | | | |
| | | | |
| Abnahme | | | |

**3. Inspektions- und Prüfpunkte** (detailliert)
- Wer inspiziert?
- Mit welchen Mitteln?
- Dokumentation wie?

**4. Qualitätsverantwortlichkeiten**

| Rolle | Verantwortung |
|------|---------------|
| Bauleiter | |
| Polier (Handwerker-Chef) | |
| Baugutachter (extern) | |
| Kunde / Auftraggeber | |

---

## Aufgabe 8: Qualitätsbegriffe – Zuordnung und Vertiefung

### Aufgabenstellung

Ordnen Sie die Begriffe den Definitionen zu:

| Begriff | Definition | Antwort |
|---------|-----------|--------|
| Qualitätssicherung | A: Die Überprüfung eines fertigen Produkts | |
| Qualitätsprüfung | B: Prozesse zur Vermeidung von Fehlern | |
| Qualität | C: Erfüllung der Anforderungen | |
| Inspektion | D: Überprüfung ohne Ausführung (statisch) | |

### Zusatz-Aufgabe: Unterscheidung klassisch vs. agil

Im klassischen Modell wird Qualität oft "am Ende" getestet. In agilen Projekten wird Qualität "durchgehend" verankert.

**Füllen Sie die Tabelle:**

| Aspekt | Klassisches Modell | Agiles Modell |
|--------|-------------------|--------------|
| Wann wird getestet? | | |
| Wer ist verantwortlich? | | |
| Fehlerkosten | | |
| Feedback-Häufigkeit | | |

---

## Persönliche Notizen und Reflexion

### Meine wichtigsten Erkenntnisse zu Qualitätsmanagement:

```
[Platz für Ihre Notizen]
```

### Fragen, die ich noch klären möchte:

```
[Platz für Ihre Fragen]
```

### Anwendung im eigenen Projekt:

Welche der Qualitätsmaßnahmen könnten Sie in Ihrem aktuellen Projekt sofort umsetzen?

```
[Platz für Ihre Überlegungen]
```

---

## Zusammenfassung – Checkliste zum Abhaken

Nach dieser Aufgabenserie sollten Sie:

- [ ] Qualitätskriterien konkret und messbar definieren können
- [ ] Testpläne nach dem V-Modell erstellen können
- [ ] Fehler korrekt klassifizieren und priorisieren können
- [ ] YouTrack für Qualitätsmanagement nutzen können
- [ ] Qualitätsmetriken berechnen und interpretieren können
- [ ] Code Reviews systematisch durchführen können
- [ ] Qualitätspläne für verschiedene Projekttypen entwickeln können
- [ ] Unterschiede zwischen klassischem und agilem QM verstehen