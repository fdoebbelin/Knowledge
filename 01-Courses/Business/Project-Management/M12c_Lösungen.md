## Lösung Aufgabe 1: Qualitätskriterien definieren

### Muster-Lösung

| Nr. | Qualitäts-kriterium | Messbarer Indikator | Zielwert | Priorität | Inspektions-methode |
|-----|-------------------|-------------------|---------|-----------|-------------------|
| 1 | Funktionalität: Alle Anforderungen implementiert | Anforderungen erfolgreich getestet (%) | ≥ 100% | ☑ High | UAT, Testfall-Durchlauf |
| 2 | Performance: Responsivität | Seitenladezeit | ≤ 2 Sekunden | ☑ High | Load-Test, Monitoring |
| 3 | Sicherheit: Datenschutz | SQL-Injection Anfälligkeit | 0 Schwachstellen | ☑ High | Security-Test, Code-Analyse |
| 4 | Usability: Benutzerfreundlichkeit | Fehlerquote bei Benutzung | ≤ 2% | ☐ Medium | Usability-Test mit Benutzern |
| 5 | Verfügbarkeit: System Uptime | Verfügbarkeit | ≥ 99,5% | ☑ High | Monitoring, Verfügbarkeitsmessung |

### Kommentar

> **Kommentar:** Diese Qualitätskriterien folgen dem SMART-Prinzip:
> - **S**pezifisch: Jedes Kriterium ist klar definiert
> - **M**essbar: Mit konkreten Indikatoren und Zielwerten
> - **A**ttraktiv: Für den Kunden bedeutsam
> - **R**ealistisch: Mit modernen Tools erreichbar
> - **T**erminiert: Überprüfbar während Testphase
>
> **Häufige Fehler vermeiden:**
> - ❌ Vage Kriterien wie "es soll schnell sein" → ✓ konkrete Zeiten definieren
> - ❌ Zu viele Kriterien (> 10) → ✓ Fokus auf Wesentliches
> - ❌ Unmessbare Kriterien → ✓ Immer einen Indikator festlegen
> - ❌ Standards vergessen → ✓ DIN, ISO, Best Practices einbeziehen
>
> **Best Practice:** Arbeiten Sie diese Kriterien mit dem Kunden ab und dokumentieren Sie die Zustimmung schriftlich im Projektauftrag!

---

## Lösung Aufgabe 2: Testplan für Entwicklungsphase

### Muster-Lösung

**A) Testphasen und -arten**

| Test-Phase | Zeitpunkt | Umfang | Testverantwortung | Dauer (Tage) |
|-----------|-----------|--------|-------------------|-------------|
| **Unit Test** | Während Entwicklung (nach jeder Komponente) | Einzelne Funktionen/Klassen | Entwickler (eigenverantwortlich) | 1 pro Komponente |
| **Code Review** | Nach Unit-Entwicklung, vor Commit | Gesamter neu geschriebene Code | 2 Entwickler (Peer-Review) | 0,5 pro Review |
| **Komponenten/Integrations-Test** | Nach Integration mehrerer Module | Schnittstellenkompatibilität, Datenaustausch | QA-Team + Entwickler | 5 |
| **System-Test** | Nach Integration aller Module | Alle Anforderungen, End-to-End Flows | QA-Team | 7 |
| **Performance-Test** | Vor UAT | Last, Durchsatz, Speicherverbrauch | QA + Infrastruktur | 3 |

**B) Inspektionspunkte**

- [x] Anforderungsspezifikation validieren (**Wann?** → Am Ende der Anforderungsphase, vor Entwicklungsstart)
- [x] Design-Review (**Wann?** → Am Ende der Design-Phase, vor Coding)
- [x] Code-Review (**Wann?** → Täglich während Entwicklung, vor Code-Merge)
- [x] Komponententest (**Wann?** → Unmittelbar nach Komponenten-Fertigstellung)
- [x] Weitere? Integration-Test, Performance-Test, Security-Scan

**C) Verantwortlichkeiten**

| Rolle | Aufgaben im Testplan |
|------|---------------------|
| **Projektmanager** | Testplan genehmigt, Ressourcen bereitstellt, Zeitplan überwacht |
| **Entwickler** | Unit Tests schreiben, Code Reviews durchführen, Bugs beheben |
| **Tester / QA** | Testfälle entwickeln, Tests durchführen, Bugs dokumentieren, Abnahmefreigabe |
| **Kunde / Business Analyst** | UAT durchführen, funktionale Anforderungen validieren, finales OK geben |

### Kommentar

> **Kommentar:** Der Testplan folgt dem **V-Modell**: Für jede Entwicklungsphase gibt es eine entsprechende Testphase. Dies stellt sicher, dass:
> 1. Tests früh geplant werden (nicht erst am Ende)
> 2. Fehler früh erkannt werden (günstiger in der Behebung)
> 3. Qualität über den gesamten Prozess verankert ist
>
> **Typische Fehler vermeiden:**
> - ❌ Testing erst nach kompletter Entwicklung → ✓ Inspektionen von Anfang an
> - ❌ Keine vordefinierten Testphasen → ✓ Struktur gibt Sicherheit
> - ❌ Keine klare Rollenverteilung → ✓ Entwickler ≠ QA, beide sind wichtig
> - ❌ Zeitpuffer vergessen → ✓ 15-20% Buffer einplanen für Überraschungen
>
> **YouTrack-Integration:** Erstellen Sie für jede Test-Phase einen Issue-Type "Test Case" und verlinken Sie zu Requirements. So haben Sie volle Rückverfolgbarkeit!

---

## Lösung Aufgabe 3: Fehlerklassifizierung und Priorisierung

### Muster-Lösung

| Fehler | Severity | Priorität | Begründung |
|--------|----------|-----------|-----------|
| **A: Login funktioniert nicht** | **Critical** | **Sofort (P0)** | Kritischer Fehler – ohne Login kann niemand das System nutzen. Blockiert alle anderen Tests. |
| **B: Produktbilder falsche Größe** | **Low** | **Später (P3)** | Kosmetisches Problem. Funktionalität ist nicht beeinträchtigt, nur optische Darstellung. |
| **C: Bestellspeicherung crasht** | **Critical** | **Sofort (P0)** | Kritischer Fehler – Datenverlust, Geschäftsauswirkungen. Kernfunktion betroffen. |
| **D: Typo "Willkomen"** | **Low** | **Optional (P4)** | Sehr niedriger Impact. QA kann noch vor Go-Live gefunden werden, optional. |
| **E: Nicht auf Windows 7 lauffähig** | **High** | **Baldmöglichst (P1)** | High, da Anforderung verletzt wird. Wenn Windows 7 nicht unterstützt werden soll, ist es zu definieren. Hohe Priorität. |

### Zusatz-Frage

Welche Fehler **vor dem Go-Live** beheben? ✓
- ✓ **Fehler A** (Login)
- ❌ **Fehler B** (Bilder)
- ✓ **Fehler C** (Bestellspeicherung)
- ❌ **Fehler D** (Typo – kann nach Go-Live behoben werden)
- ✓ **Fehler E** (Windows 7) – nur wenn Support versprochen wurde

### Kommentar

> **Kommentar:** Die Klassifizierung folgt der **SEVERITY-PRIORITY-Unterscheidung**:
> - **Severity**: Wie schlecht ist der Fehler? (technische Auswirkung)
> - **Priority**: Wie dringend muss er behoben werden? (geschäftliche Auswirkung)
>
> Ein "High Severity" Bug kann "Low Priority" haben, wenn er eine selten genutzte Funktion betrifft!
>
> **Fehlerklassifizierung nach ITIL:**
> - **Critical**: System funktioniert nicht, Datenverlust, Sicherheitslücke
> - **High**: Wichtige Funktion beeinträchtigt, aber Workaround möglich
> - **Medium**: Nebenfunction gestört, normale Arbeit möglich
> - **Low**: Kosmetisch, keine Auswirkung auf Nutzung
>
> **Best Practice - Defect-Management:**
> - Alle Critical/High müssen VOR Go-Live behoben sein
> - Medium Bugs können in nächstem Release behoben werden
> - Low Bugs = Backlog, später bearbeiten
> - **YouTrack-Tipp:** Nutzen Sie einen Filter wie "Severity = Critical AND Status != Closed" als Go-Live Checklist!

---

## Lösung Aufgabe 4: YouTrack für Defect-Tracking nutzen

### Muster-Lösung

**A) Defect-Workflow**

```
[Neu eingegeben] 
    ↓ (Triage durchgeführt → Severity/Priority bestimmt)
[Triaged / Assigned]
    ↓ (Zugewiesen an Entwickler → Work beginnt)
[In Behebung / In Progress]
    ↓ (Fix implementiert → Code Review)
[Ready for Test / Pending QA]
    ↓ (Von QA validiert → Test erfolgreich)
[Closed / Done]

    ↓ (Alternative bei Ablehnung: zurück zu "In Behebung" oder "Duplicate/Won't Fix")
[Rejected / Reopened]
```

**B) Custom-Fields für Bugs**

| Custom-Field | Typ | Mögliche Werte |
|-------------|-----|----------------|
| **Severity** | List | Critical, High, Medium, Low |
| **Found In Phase** | List | Requirements, Design, Development, Testing, Production |
| **Component** | List | Login, Checkout, Reporting, Database, API, UI |
| **Root Cause** | List | Logic Error, Design Flaw, Missing Requirement, Integration Issue, Environment |
| **Effort to Fix** | Number | 1 (Stunde), 2 (2-4h), 3 (1 Tag), 4 (2-3 Tage), 5 (Woche+) |
| **QA Validation** | List | Pending, Passed, Failed |
| **Release Blocker** | Checkbox | Ja / Nein |

**C) Defect-Report-Template**

```markdown
**Issue-Typ:** Bug
**Titel:** [Prägnante Zusammenfassung in 5-10 Wörtern]
  Beispiel: "Login-Button funktioniert nicht auf Chrome"

**Beschreibung:**

### Komponente
E-Commerce System → Checkout → Payment Module

### Schritte zum Reproduzieren
1. Als nicht-angemeldeter Benutzer zur Seite gehen
2. Auf den "Login"-Button klicken
3. Beliebige Zugangsdaten eingeben
4. Enter drücken

### Aktuelles Verhalten
Fehler "Invalid Credentials" wird immer angezeigt, unabhängig von den Eingaben.

### Erwartetes Verhalten
Mit gültigen Credentials sollte der Benutzer angemeldet werden und zum Dashboard weitergeleitet werden.

### Umgebung
- Browser: Google Chrome 120.0.6099.110
- Betriebssystem: Windows 11
- URL: https://staging.ecommerce.example.com
- Benutzer-Account: test_user_01

### Häufigkeit
- Konsistent / Reproduzierbar (immer)
- Intermittierend (manchmal)

### Screenshots / Logs
[Anhang: Screenshot des Fehlers]
[Anhang: Browser Console Log]

---

### Tracking-Felder (werden später gefüllt):
**Severity:** ☑ Critical ☐ High ☐ Medium ☐ Low
**Found In Phase:** Testing / UAT
**Assigned To:** [Developer Name]
**Status:** New → Triaged → In Progress → Ready for Test → Closed
**Root Cause:** [wird vom Entwickler gefüllt nach Analyse]
**Fix Verified by QA:** [wird von QA gefüllt]
```

### Kommentar

> **Kommentar:** Ein gut strukturiertes Defect-Report ist essentiell für effizientes Bug-Management. Das Template stellt sicher, dass:
> 1. **Reproduzierbarkeit**: Der Entwickler kann den Bug sofort nachvollziehen
> 2. **Kontext**: Umgebungsinformationen helfen bei umgebungsspezifischen Bugs
> 3. **Rückverfolgbarkeit**: Verknüpfung zu Phase und Komponente
>
> **YouTrack Best Practices:**
> - **Custom Fields** nutzen für automatisierte Berichte und Filter
> - **Workflow** mit klaren Transitionen (keine unsichtbaren Status)
> - **Prioritäts-Filter** für Daily Standups: `Severity = Critical AND Status != Closed`
> - **Metriken-Dashboard**: Burn-Down-Chart für Bug-Reduktion
>
> **Häufige Fehler:**
> - ❌ Vage Bug-Beschreibungen → ✓ Template erzwingt Struktur
> - ❌ Keine Reproduktionsschritte → ✓ Entwickler sitzt dann fest
> - ❌ Keine Umgebungsinformationen → ✓ Browser-kompatibilität kann übersehen werden
> - ❌ Kein Workflow definiert → ✓ Bugs landen "stuck" irgendwo
>
> **YouTrack-Workflow-Regel:** Nur QA darf Bugs schließen, nicht der Entwickler selbst. So wird Qualitätskontrolle erzwungen.

---

## Lösung Aufgabe 5: Qualitätsmetriken ermitteln

### Muster-Lösung

| Metrik | Formel | Berechnung | Ergebnis | Bewertung |
|--------|--------|-----------|---------|----------|
| **Test Coverage** | (Code mit Tests / Gesamtcode) × 100 | (45.000 / 50.000) × 100 | **90%** | ✓ OK (≥ 80%) |
| **Defect Escape Rate** | (Bugs in Produktion / Gefundene Bugs) × 100 | (5 / 85) × 100 | **5,9%** | ⚠ Kritisch (Ziel ≤ 1%) |
| **Acceptance Rate** | (Akzeptierte Anforderungen / Gesamt-Anforderungen) × 100 | (48 / 50) × 100 | **96%** | ✓ OK (≥ 95%) |
| **Mean Time To Fix (MTTF)** | Durchschn. Zeit zur Fehlerbehebung | 2,5 Tage durchschnittlich | **2,5 Tage** | ✓ OK (Ziel ≤ 3 Tage) |

### Fragen zur Interpretation

#### 1. Ist die Test Coverage ausreichend?
**Ja, 90% ist ausreichend.** Das Ziel von 80% wird erreicht und übertroffen. 
- Allgemein wird 80-90% als gutes Verhältnis angesehen
- 100% Coverage ist oft unrealistisch (z. B. Exception Handling, Edge Cases)
- **Empfehlung:** Fehlende 10% = 5.000 Zeilen. Prüfen, ob diese kritische Code-Teile sind oder "tote" Äste.

#### 2. Ist die Defect Escape Rate akzeptabel?
**Nein, 5,9% ist zu hoch.** Das Ziel von ≤ 1% wird deutlich verfehlt.
- Das bedeutet: Von 85 Bugs sind 5 erst in Produktion gefunden worden
- Das ist besorgniserregend! Sollte nicht passieren.
- **Ursachen analysieren:**
  - Waren die Tests unzureichend?
  - Hat UAT nicht ausreichend getestet?
  - Waren die Testfälle nicht repräsentativ?
  - Fehlten Performance-Tests?

#### 3. Können Sie das Projekt freigeben?

**Bedingte Freigabe mit Reservierungen:**

**✓ Pro Freigabe:**
- Test Coverage ist gut (90%)
- Acceptance Rate ist sehr hoch (96%)
- MTTF ist akzeptabel (2,5 Tage)
- 80 von 85 Bugs wurden VOR Produktion gefunden (93,8% Erkennungsrate)

**✗ Gegen Freigabe:**
- Defect Escape Rate ist zu hoch (5,9% statt ≤ 1%)
- 5 Bugs sind bereits in Produktion – diese müssen sofort nach Go-Live gefixed werden
- Kunden werden Fehler entdecken – Reputationsrisiko

**Empfehlung:**
1. **Sofort Go-Live**, aber mit Risiko akzeptieren
2. **Hotline einrichten** für produktive Fehler
3. **Post-Go-Live-Monitoring** intensivieren
4. **Ursachenanalyse**: Warum war die Escape Rate so hoch? → Learnings für nächstes Projekt
5. **Für Zukunft**: Mehr Ressourcen in UAT investieren oder automatisierte Teststrategie verbessern

### Kommentar

> **Kommentar:** Qualitätsmetriken sind **datengestützte Entscheidungsgrundlagen**. Sie helfen, objektiv zu entscheiden, statt "Bauchgefühl" zu folgen.
>
> **Wichtig zu verstehen:**
> - **Defect Escape Rate ist der kritischste Indikator** – Fehler die in Produktion gehen, sind am teuersten
> - **Test Coverage allein sagt nichts aus** – 90% Coverage kann noch viele Bugs haben!
> - **Acceptance Rate ist der Kundensicht** – hier zeigt sich, ob Requirements klar waren
>
> **Metriken richtig interpretieren:**
> - ❌ Zu starr: "Alle KPIs müssen exakt erfüllt sein" → Go-Live verzögert sich zu lange
> - ✓ Risiko-basiert: "Welche Abweichungen sind akzeptabel?" → Business Impact beurteilen
>
> **YouTrack-Integration für Metriken:**
> ```
> Dashboard erstellen mit:
> 1. Bug Count nach Severity (offene vs. geschlossene)
> 2. Trend: Bugs gefunden pro Woche (sollte fallende Kurve sein)
> 3. Escape Rate: Bugs in Production / Gesamtbugs
> 4. MTTF: Durchschnittliche Tage von New → Closed
> 5. Test Coverage % (manuell erfasst oder aus CI/CD gezogen)
> ```

---

## Lösung Aufgabe 6: Code Review durchführen

### Muster-Lösung

| Kategorie | Kriterium | Status | Feedback / Fehler |
|-----------|-----------|--------|------------------|
| **Funktionalität** | Macht die Funktion das, was sie soll? | ☑ OK ☐ NOK | `calculate_order_total` ist funktional korrekt – multipliziert Preis × Menge, summiert auf. `get_user_from_db` funktioniert auch, aber mit Sicherheitsmängeln (siehe unten). |
| **Fehlerbehandlung** | Sind Exception Handling vorhanden? | ☐ OK ☑ NOK | ❌ **Fehler:** `get_user_from_db` hat kein Error Handling. Was passiert wenn: - Datenbank offline? - Benutzer nicht gefunden (Index [0] schlägt fehl)? - Leeres Ergebnis? → **Fix:** try/except Block, None-Check |
| **Sicherheit** | Gibt es SQL-Injection oder andere Sicherheitslücken? | ☐ OK ☑ NOK | ❌ **KRITISCHER FEHLER:** `get_user_from_db` verwendet String-Konkatenation in SQL Query! → **SQL-Injection anfällig** Beispiel: `user_id = "1 OR 1=1 --"` würde alle Benutzer zurückgeben! → **Fix:** Parametrisierte Query verwenden: `"SELECT * FROM users WHERE id = ?"` mit Parametern |
| **Performance** | Ist der Code performant? | ☑ OK ☐ NOK | `calculate_order_total` ist O(n) – optimal für Listenverarbeitung. `get_user_from_db` ist auch OK (single user lookup). Nur positiv: keine Schleifen in Datenbank-Query. |
| **Readability** | Ist der Code leicht zu verstehen? | ☐ OK ☑ NOK | ⚠️ **Minor:** Variablennamen sind OK, aber: - `calculate_order_total`: Gut lesbar - `get_user_from_db`: Der Kommentar ist redundant ("Queries the database") – sagt das nicht schon der Name? → **Fix:** Kommentar entfernen oder aussagekräftiger machen (z. B. "// Raises exception if user not found") |
| **Standards** | Folgt der Code den Team-Coding-Standards? | ☐ OK ☑ NOK | ⚠️ Annahme: Team-Standard ist "PEP 8" (Python) → ✓ Einrückung und Naming sind OK → ❌ Aber wo sind die **Type Hints**? Modern Python nutzt: `def calculate_order_total(items: List[Dict]) -> float:` |
| **Dokumentation** | Ist die Funktion dokumentiert? | ☐ OK ☑ NOK | ❌ **Fehler:** Keine Docstrings! → **Fix:** ```python def calculate_order_total(items): """ Calculate the total price of an order. Args: items (List[Dict]): List of items with 'price' and 'quantity' Returns: float: Total order amount """ ``` |
| **Testing** | Gibt es Unit Tests? | ☐ OK ☑ NOK | ❌ **Kritisch:** Keine Unit Tests erkennbar → **Notwendige Tests:** - `calculate_order_total([{'price': 10, 'quantity': 5}])` sollte 50 zurückgeben - Test mit leerer Liste - Test mit Dezimalzahlen - `get_user_from_db` mit gültiger/ungültiger ID |

### Zusammenfassung der Code-Review

**Fazit:** ❌ **REJECT** – Nicht freigeben

**Showstoppers (müssen vor Merge behoben werden):**
1. ❌ SQL-Injection in `get_user_from_db` – **SECURITY RISK**
2. ❌ Fehlendes Error Handling in `get_user_from_db`
3. ❌ Keine Unit Tests
4. ❌ Keine Docstrings

**Verbesserungen vor Resubmission:**

```python
from typing import List, Dict, Optional

def calculate_order_total(items: List[Dict[str, float]]) -> float:
    """
    Calculate total order amount.
    
    Args:
        items: List of dicts with 'price' and 'quantity' keys
    
    Returns:
        Total amount as float
    
    Raises:
        ValueError: If items is empty or invalid
    """
    if not items:
        raise ValueError("Items list cannot be empty")
    
    total = 0
    for item in items:
        if 'price' not in item or 'quantity' not in item:
            raise ValueError(f"Item missing price or quantity: {item}")
        total += item['price'] * item['quantity']
    return total

def get_user_from_db(user_id: int) -> Optional[Dict]:
    """
    Fetch user from database by ID.
    
    Args:
        user_id: User ID to fetch
    
    Returns:
        User dict or None if not found
    
    Raises:
        DatabaseError: If connection fails
    """
    try:
        db_connection = connect_to_db()
        # FIXED: Use parameterized query to prevent SQL injection
        query = "SELECT * FROM users WHERE id = ?"
        result = db_connection.execute(query, (user_id,))
        
        if not result:
            return None  # User not found
        return result[0]  # Return first (and only) result
    
    except Exception as e:
        raise DatabaseError(f"Failed to fetch user: {str(e)}")
```

**Unit Test Beispiel:**

```python
def test_calculate_order_total():
    # Happy path
    assert calculate_order_total([{'price': 10, 'quantity': 5}]) == 50
    assert calculate_order_total([{'price': 10, 'quantity': 2}, {'price': 20, 'quantity': 3}]) == 80
    
    # Edge cases
    with pytest.raises(ValueError):
        calculate_order_total([])  # Empty list
    
    with pytest.raises(ValueError):
        calculate_order_total([{'price': 10}])  # Missing quantity
```

### Kommentar

> **Kommentar:** Dieses Code-Review-Beispiel zeigt, wie wichtig **systematische Inspektionen** sind. Die Fehler hätten in Produktion zu Datenlecks und Crashes führen können!
>
> **Code-Review-Best Practices:**
> 1. **Immer auf Sicherheit prüfen** – SQL-Injection, Cross-Site-Scripting, Authentifizierung
> 2. **Error Handling ist Pflicht** – nicht optional
> 3. **Unit Tests oder keine Freigabe** – das ist nicht verhandelbar
> 4. **Type Hints nutzen** – hilft Fehler zu erkennen (auch IDE-Support)
> 5. **Docstrings schreiben** – nächster Entwickler dankt dir
>
> **Häufige Fehler bei Code Reviews:**
> - ❌ Nur auf Style achten (Einrückung, Naming) → ✓ auch Logik, Sicherheit, Tests
> - ❌ Code Reviews zu früh geben ("sieht OK aus") → ✓ kritisch bleiben, Fragen stellen
> - ❌ Persönlich werden ("Dieser Code ist schlecht") → ✓ sachlich bleiben, die Sache kritisieren, nicht die Person
>
> **YouTrack-Integration:** 
> - Issue-Type "Code Review" mit Custom Field "Review Status" (Approved / Changes Requested / Rejected)
> - Link zu Git Commit
> - Automatische Notification an Entwickler

---

## Lösung Aufgabe 7: Qualitätsplan Bauprojekt

### Muster-Lösung

**1. Qualitätsziele**

| Nr. | Qualitätsziel | Messbarkeit |
|-----|--------------|-----------|
| 1 | Alle Arbeiten entsprechen DIN/VDE-Normen und geltenden Baurichtlinien | Nachweis durch Baugutachter (Zertifikat am Ende jeder Phase) |
| 2 | Kundenzufriedenheit mit Ausführungsqualität | ≥ 9/10 Punkte in Abschlussbefragung |
| 3 | Null schwere Verletzungen bei Arbeitssicherheit | 0 Unfälle/schwere Verstöße |
| 4 | Termineinhaltung der Meilensteine | 100% der Meilensteine pünktlich (±1 Woche Puffer) |
| 5 | Budgettreue | Ausgaben ≤ Budget (±5% Toleranz) |

**2. Qualitätskriterien pro Phase**

| Phase | Qualitätskriterium | Inspektionsmethode | Zeitpunkt | Verantwortung |
|-------|------------------|-------------------|-----------|--------------|
| **Vorbereitung & Planung** | Pläne gemäß Architektur und Standards erstellt | Review durch Architekt | Woche 2 | Bauleiter + Architekt |
| | Sicherheitsplan vorhanden (Arbeitssicherheit) | Prüfung durch Sicherheitsbeauftragter | Woche 1 | Bauleiter |
| | Genehmigungen erhalten (Behörden) | Dokumentenprüfung | Woche 2 | Verwaltung |
| **Abbruch & Vorbereitung** | Altlasten sachgerecht entsorgt | Sichtkontrolle + Umweltprotokolle | Woche 4 | Polier + Umweltbeauf. |
| | Baustelle sicherhergestellt (Zäune, Warnschilder) | Sichtkontrolle | Woche 3 | Polier |
| **Rohbau** | Beton-Druckfestigkeit geprüft | Testbohrungen (Core Samples) | Nach jeder Phase | QA-Dienstleister |
| | Elektroinstallation nach DIN 0100 | Messungen durch Elektrofachkraft | Woche 7 | Elektromeister |
| | Maße und Höhen eingehalten | Vermessung mit Laser-Messung | Woche 8 | Vermesser |
| | Oberflächengüte akzeptabel | Sichtprüfung nach Merkmalsliste | Woche 8 | Baumeister |
| **Innenausbau** | Trockenestrich eben und fugenlos | Oberflächenmessung | Woche 10 | Handwerksmeister |
| | Farbanstriche deckend und fehlerfrei | Sichtprüfung unter Normlicht | Woche 10 | Malermeister |
| | Alle Installationen funktionsfähig | Funktionsprüfung (Strom, Wasser, Heizung) | Woche 11 | Techniker |
| **Abnahme & Übergabe** | Restarbeiten und Mängel vollständig behoben | Begehung mit Checkliste | Woche 12 | Bauleiter + Kunde |
| | Mängelbericht (Punch-list) unterschrieben | Übergabedokumentation | Woche 12 | Alle Parteien |
| | Gewährleistungsunterlagen übergeben | Dokumentenprüfung | Woche 12 | Bauleiter |

**3. Inspektions- und Prüfpunkte – Detailliert**

| Prüfschritt | Wer Inspiziert | Mit welchen Mitteln | Dokumentation | Häufigkeit |
|-----------|---------------|-------------------|--------------|-----------|
| **Beton-Festigkeit** | Externer QA-Dienstleister | Core Samples (Testbohrungen), Druckprüfmaschine | Zertifikat mit Ergebnissen | Nach jede 500 m³ Beton |
| **Elektro-Installation** | Zertifizierter Elektromeister | Multimeter, Isolationsprüfgerät | Prüfprotokoll DIN 0100 | Nach Installation, vor Energieversorgung |
| **Vermessung** | Vermesser (extern) | Laser-Messsystem, Nivelliergerät | Vermessungsbericht | Nach Rohbau |
| **Bauüberwachung täglich** | Polier (vor Ort) | Sichtprüfung, einfache Messungen | Täglich Baudiary | Täglich |
| **Materialieferungen** | Bauleiter | Lieferschein-Prüfung, Sichtprüfung Qualität | Eingangsprüfprotokoll | Bei jeder Lieferung |
| **Mängel-Begehung** | Kunde, Bauleiter, Architekt | Checkliste, Kamera (Fotodokumentation) | Mängelbericht (Punch-list) | Am Ende jeder Phase |

**4. Qualitätsverantwortlichkeiten**

| Rolle | Verantwortung | Beispiele |
|------|--------------|---------|
| **Bauleiter** | Gesamtverantwortung Qualität und Timing | Koordiniert alle Inspektionen, entscheidet über Freigaben, escaliert Mängel |
| **Polier (Handwerks-Chef vor Ort)** | Tägliche Qualitätskontrolle, Arbeitsvorbereitung | Überwacht Handwerker, führt täglich Baudiary, meldet Probleme an Bauleiter |
| **Baugutachter (extern)** | Unabhängige technische Qualitätsprüfung | Prüft Pläne, führt Messungen durch, zertifiziert Standards-Einhaltung |
| **Kunde / Auftraggeber** | Finale Abnahme und Akzeptanz | Bestätigt Anforderungen erfüllt, unterzeichnet Abnahmeprotokoll |

### Kommentar

> **Kommentar:** Im Bauprojekt ist Qualität **nicht nachbesserbar** wie in Software. Ein fehlerhaft gegossenes Fundament kann nicht einfach "gepatcht" werden – es muss rückgebaut und neu gemacht werden (sehr teuer!).
>
> **Spezialheiten von Bauprojekt-QM:**
> 1. **Externe Fachleute notwendig** – Zertifizierte Inspektoren (Elektromeister, Vermesser, Baugutachter)
> 2. **Dokumentation ist Beweis** – Zertifikate sind notwendig für Garantie und bei Konflikten
> 3. **Inspektionen müssen mit Fortschritt stattfinden** – Fehler in frühen Phasen wirken sich auf alle späteren aus
> 4. **Materialieferungen kontrollieren** – falsche Materialien können Projekte lahmlegen
>
> **Häufige Fehler bei Bauprojekt-QM:**
> - ❌ Inspektionen sparen (Zeit/Kosten) → ✓ Kostet am Ende 10x mehr
> - ❌ Keine unabhängigen Gutachter → ✓ Interessenskonflikte entstehen
> - ❌ Mängel "wegsehen" → ✓ Kunde akzeptiert Abnahme nicht
> - ❌ Dokumentation unvollständig → ✓ Bei Garantiefällen keine Beweise
>
> **Best Practice - Mängelbericht (Punch-List):**
> Am Ende des Projekts gibt es typischerweise noch kleine Mängel (fehlendes Schild, Kratzer, etc.). Diese werden in einer "Punch-List" gesammelt, die vom Kunden und Handwerker unterschrieben wird. So können die Handwerker nach Abnahme Nachbesserungen machen.

---

## Lösung Aufgabe 8: Qualitätsbegriffe Zuordnung

### Muster-Lösung

| Begriff | Definition | Antwort |
|---------|-----------|--------|
| **Qualitätssicherung** | A: Die Überprüfung eines fertigen Produkts | **B** |
| **Qualitätsprüfung** | B: Prozesse zur Vermeidung von Fehlern | **A** |
| **Qualität** | C: Erfüllung der Anforderungen | **C** |
| **Inspektion** | D: Überprüfung ohne Ausführung (statisch) | **D** |

**Erklärung der Begriffe:**

- **Qualität (C)**: Das Ergebnis – erfüllt das Produkt die Anforderungen?
- **Qualitätssicherung (B)**: Prozesse und Maßnahmen, um Qualität zu SICHERN (präventiv)
- **Qualitätsprüfung (A)**: Die Überprüfung, ob das Produkt die Standards erfüllt (reaktiv)
- **Inspektion (D)**: Eine Form der Prüfung, die ohne Ausführung stattfindet (z. B. Code-Review)

### Zusatz-Aufgabe: Klassisch vs. Agil

| Aspekt | Klassisches Modell | Agiles Modell |
|--------|-------------------|--------------|
| **Wann wird getestet?** | Am Ende der Entwicklung ("Big Bang Test") | Kontinuierlich während Sprints ("Continuous Testing") |
| **Wer ist verantwortlich?** | Separate QA-Abteilung (Test-Team) | Jedes Team-Mitglied (Entwickler selbst sind verantwortlich) |
| **Fehlerkosten** | Hoch – Fehler spät erkannt | Niedrig – Fehler früh erkannt und behoben |
| **Feedback-Häufigkeit** | Einmal pro Testphase | Täglich / nach jedem Sprint |

### Zusatz-Erklärung

**Klassisches Modell:**
- "Test-Phase" am Ende
- Wenn viele Fehler gefunden → Projekt verzögert sich massiv
- Kultur: "Entwicklung macht, QA prüft"
- Nachteil: Fehler spät erkannt = teuer

**Agiles Modell:**
- Tests während Entwicklung ("Definition of Done" beinhaltet Tests)
- Fehler werden sofort behoben
- Kultur: "Jeder trägt Verantwortung für Qualität"
- Vorteil: Fehler früh erkannt = günstig + kontinuierliches Feedback

### Kommentar

> **Kommentar:** Die Unterscheidung klassisch vs. agil ist fundamental:
>
> - **Klassisch**: Test als **Verifizierung** – "Macht das Produkt das, was wir geplant haben?"
> - **Agil**: Test als **kontinuierliches Qualitätssicherungs-Mittel** – "Funktioniert es jetzt? Funktioniert es immer noch?"
>
> **Moderne Praxis (Hybrid):**
> Viele Projekte kombinieren beide Ansätze:
> - Unit Tests und Code Reviews **während** Entwicklung (agil)
> - Vollständige Systemtests **am Ende einer Phase** (klassisch)
> - Automatisierte Regressionstests **kontinuierlich** (DevOps)
>
> **YouTrack-Integration:**
> - In agilen Teams: Jeder User Story hat einen "Acceptance Criteria" Feld
> - Test Cases sind mit User Stories verlinkt
> - Definition of Done checklist: "Unit Tests geschrieben + Code Reviewed + Akzeptanzkriterien erfüllt"

---

## Zusammenfassung – Wichtigste Learnings

### Die Top 5 Erkenntnisse zu Qualitätsmanagement:

1. **Qualität ist Prävention, nicht Reparatur** – Fehler früh erkennen ist günstiger
2. **Metriken treiben Entscheidungen** – Datengestützte Qualitätsentscheidungen, nicht Bauchgefühl
3. **Jeder ist verantwortlich** – Nicht nur QA, sondern Architekten, Entwickler, Management
4. **Standards und Prozesse geben Sicherheit** – Klare Richtlinien verhindern Chaos
5. **YouTrack (oder ähnliche Tools) dokumentiert Alles** – Für Compliance, Lernen und Verbesserung

### Häufigste Fehler im QM (zum Merken):

| Fehler | Folge | Lösung |
|--------|-------|--------|
| Qualitätsplanung zu spät | Zeitdruck, Fehler übersehen | Vom Projektstart an QM-Aktivitäten |
| Keine klaren Standards | Inkonsistente Qualität | Standards definieren und kommunizieren |
| QA & Entwicklung trennen | "Nicht mein Problem"-Mentalität | Gemeinsame Verantwortung etablieren |
| Keine Metriken | Qualität unkontrollierbar | KPIs definieren und tracken |
| Zu strenge Qualitätsziele | Projekt läuft über Zeit/Budget | Realistische, risiko-basierte Ziele |

---

## Checkliste zur Selbstkontrolle

Nach dem Lösen dieser Aufgaben sollten Sie:

- [x] **Aufgabe 1** – Konkrete Qualitätskriterien mit messbaren Indikatoren definieren können
- [x] **Aufgabe 2** – Testpläne nach dem V-Modell strukturieren können
- [x] **Aufgabe 3** – Fehler richtig klassifizieren (Severity vs. Priority)
- [x] **Aufgabe 4** – YouTrack Workflows für Defect-Management aufsetzen können
- [x] **Aufgabe 5** – Qualitätsmetriken berechnen und interpretieren können
- [x] **Aufgabe 6** – Systematische Code Reviews durchführen können
- [x] **Aufgabe 7** – Vollständige Qualitätspläne für verschiedene Projekttypen entwickeln
- [x] **Aufgabe 8** – Fachbegriffe korrekt unterscheiden und anwenden können
