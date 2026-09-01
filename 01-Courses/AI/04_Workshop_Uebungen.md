# Kapitel 04 – Workshop-Übungen
## Halbtags-Workshop: Hands-on mit agentischer KI (3–4 Stunden)

---

## Vorbereitung: Was Sie brauchen

| Voraussetzung | Minimalanforderung | Ideal |
|---|---|---|
| **Account** | Claude.ai Free oder ChatGPT Free | Claude.ai Pro oder Claude Team |
| **Browser** | Aktueller Chrome, Firefox oder Edge | Chrome mit Devtools |
| **Dateien** | Bereitgestellte Übungsdateien (Log-Datei, Python-Projekt) | Eigene Produktions-Logs |
| **Gruppe** | 1-4 Personen | 2-3 Personen |

> **Hinweis für Trainer:** Alle Übungsdateien (simulierte Logs, kaputtes Python-Projekt) liegen im Kursverzeichnis. Claude.ai Free reicht für Übungen 1 und 3. Für Übung 2 (Code-Ausführung) empfiehlt sich Claude Pro oder ein kostenloser Aider-Test.

---

## Zeitplan

| Zeit | Phase | Inhalt |
|---|---|---|
| 00:00 – 00:30 | Einführung | Kapitel 01 live demonstrieren: ReAct-Loop sichtbar machen |
| 00:30 – 01:15 | **Übung 1** | Sysadmin: Log-Analyst (45 Min.) |
| 01:15 – 01:30 | Kurzpräsentation | Gruppen zeigen ihre Ergebnisse (5 Min./Gruppe) |
| 01:30 – 02:30 | **Übung 2** | DevOps: Selbstheilende Pipeline (60 Min.) |
| 02:30 – 02:45 | Pause | |
| 02:45 – 03:15 | **Übung 3** | Eigene Agenten-Idee: Canvas-Methode (30 Min.) |
| 03:15 – 03:45 | Pitch + Abschluss | Kurzpitches + kritische Reflexion: Grenzen und Risiken |

---

## Übung 1: Der Log-Analyst (45 Minuten)

### Aufgabenstellung

Sie sind das SRE-Team eines mittelständischen E-Commerce-Unternehmens.
Letzte Nacht gab es einen Produktionsausfall von 23 Minuten (02:14 – 02:37 Uhr).
Der Webshop war für ca. 12.000 Kunden nicht erreichbar.

Ihre Aufgabe: Analysieren Sie die bereitgestellten Log-Dateien mit Hilfe eines KI-Agenten.
Ziel ist ein vollständiger Incident-Report bis zum Ende der Übungszeit.

### Simulierte Log-Dateien

Verwenden Sie die bereitgestellten Dateien **oder** kopieren Sie diesen Inhalt direkt in den Chat:

```
=== /var/log/syslog (Auszug, 02:00-02:45 Uhr) ===

Mar 01 02:00:01 prod-db-01 mysqld: [Note] InnoDB: page_cleaner: 1000ms
                                   intended loop took 4550ms
Mar 01 02:08:33 prod-db-01 kernel: [234891.445] Out of memory: Kill process 18234
                                   (mysqld) score 892 or sacrifice child
Mar 01 02:08:33 prod-db-01 kernel: [234891.445] Killed process 18234 (mysqld)
                                   total-vm:16732948kB, anon-rss:14891032kB
Mar 01 02:08:34 prod-db-01 mysqld[18234]: /usr/sbin/mysqld: Shutdown complete

Mar 01 02:08:35 prod-web-01 nginx: 2026/03/01 02:08:35 [error] 8822#8822:
                 *14234 connect() to 127.0.0.1:3306 failed (111: Connection refused)
Mar 01 02:08:35 prod-web-01 nginx: 2026/03/01 02:08:35 [error] 8822#8822:
                 *14235 connect() to 127.0.0.1:3306 failed (111: Connection refused)
[... 847 weitere Connection-refused-Einträge in den nächsten 90 Sekunden ...]

Mar 01 02:08:36 prod-app-01 app[9012]: ERROR [Database] All 50 connections failed
Mar 01 02:08:36 prod-app-01 app[9012]: WARN  [CircuitBreaker] Database: OPEN
Mar 01 02:08:37 prod-app-01 app[9012]: ERROR [HTTP] 503 Service Unavailable returned
                                        to 2847 queued requests

Mar 01 02:14:22 prod-monitor nagios: SERVICE ALERT: prod-web-01;HTTP;CRITICAL;
                                      HARD;3;HTTP CRITICAL - Unable to open TCP socket

Mar 01 02:31:04 prod-db-01 mysqld: [Note] InnoDB: Starting recovery
Mar 01 02:33:18 prod-db-01 mysqld: [Note] InnoDB: Recovery complete
Mar 01 02:33:19 prod-db-01 mysqld: [Note] mysqld: ready for connections.
Mar 01 02:33:20 prod-app-01 app[9012]: INFO  [CircuitBreaker] Database: HALF-OPEN
Mar 01 02:33:21 prod-app-01 app[9012]: INFO  [CircuitBreaker] Database: CLOSED
Mar 01 02:37:44 prod-monitor nagios: SERVICE RECOVERY: prod-web-01;HTTP;OK;
                                      HTTP OK: 200 OK - 143ms response time

=== /var/log/mysql/slow-query.log (Auszug, 01:45-02:10 Uhr) ===

# Time: 2026-03-01T01:47:23.445891Z
# Query_time: 45.234891  Lock_time: 0.000234  Rows_examined: 18234891
SELECT o.*, p.*, c.* FROM orders o 
JOIN products p ON o.product_id = p.id 
JOIN customers c ON o.customer_id = c.id
WHERE o.created_at > '2020-01-01'
ORDER BY o.created_at DESC;

# Time: 2026-03-01T01:52:11.123456Z
# Query_time: 67.891234  Lock_time: 0.001234  Rows_examined: 21456789
[Gleiche Query, erneut]

# Time: 2026-03-01T01:58:44.789012Z
# Query_time: 89.234567  Lock_time: 45.234567  Rows_examined: 24567890
[Gleiche Query, erneut - Lock-Time steigt dramatisch]

=== /var/log/app/application.log (Auszug) ===

Mar 01 01:45:01 prod-app-01 INFO  [ReportScheduler] Starting monthly report generation
Mar 01 01:45:02 prod-app-01 INFO  [ReportQuery] Executing: SELECT o.*, p.*, c.* FROM...
Mar 01 02:08:33 prod-app-01 ERROR [ReportQuery] Query timeout after 1411 seconds
Mar 01 02:08:34 prod-app-01 ERROR [Database] Connection pool exhausted (50/50 connections in use)
Mar 01 02:08:35 prod-app-01 ERROR [Database] Cannot acquire connection: timeout after 30s
```

### Schritt-für-Schritt-Anleitung

**Schritt 1: Agenten-Setup (5 Minuten)**

Öffnen Sie Claude.ai und setzen Sie diesen System-Kontext zu Beginn des Chats:

```
Du bist ein erfahrener SRE (Site Reliability Engineer) mit Spezialisierung auf
MySQL, Nginx und Python-Applikationen. Du wirst Log-Dateien analysieren, um
einen Produktionsausfall zu untersuchen.

Deine Arbeitsweise:
- Analysiere systematisch, beginnend mit der Zeitlinie
- Ziehe Schlüsse aus mehreren Log-Quellen gemeinsam
- Quantifiziere Impact wo möglich (Anzahl Nutzer, Dauer, Requests)
- Unterscheide zwischen Ursache (Root-Cause) und Symptomen
- Formuliere konkrete, ausführbare Empfehlungen
```

**Schritt 2: Log-Upload und erste Analyse (10 Minuten)**

```
Ich gebe dir drei Log-Dateien von einem Produktionsausfall heute Nacht
(02:14 - 02:37 Uhr). Bitte erstelle zunächst eine vollständige Zeitlinie
aller Ereignisse in chronologischer Reihenfolge.

[Hier die Log-Inhalte von oben einfügen]
```

**Schritt 3: Root-Cause-Analyse vertiefen (10 Minuten)**

```
Auf Basis der Zeitlinie: Was war die ursprüngliche Ursache (Root-Cause)?
Erkläre die vollständige Fehler-Kaskade in einfacher Sprache,
so dass auch nicht-technische Stakeholder sie verstehen.
```

**Schritt 4: Incident-Report generieren (10 Minuten)**

```
Erstelle jetzt einen vollständigen Post-Incident-Report (PIR) mit folgenden Abschnitten:
1. Executive Summary (3 Sätze, nicht-technisch)
2. Impact (Dauer, betroffene Nutzer, geschätzter finanzieller Impact)
3. Timeline (tabellarisch)
4. Root-Cause-Analyse (technisch detailliert)
5. Sofortmaßnahmen (was wurde bereits getan?)
6. Langfristige Präventionsmaßnahmen (mindestens 4 konkrete Punkte)
7. Lessons Learned

Format: Markdown, für Confluence geeignet
```

**Schritt 5: Reflexion und Vertiefung (10 Minuten)**

```
Welche Monitoring-Alerts hätten diesen Ausfall verhindern oder früher erkennen können?
Erstelle eine Liste von 5 Prometheus-Alert-Regeln (als YAML) die wir implementieren sollten.
```

### Erwartete Ergebnisse

Am Ende der Übung sollte Ihre Gruppe:
- Eine vollständige Fehler-Kaskade erklärt haben (OOM → MySQL-Kill → Connection-Refused → App-Ausfall)
- Einen fertigen Post-Incident-Report haben (copy-paste-ready für Confluence)
- 5 konkrete Präventionsmaßnahmen identifiziert haben
- Prometheus Alert-Regeln als YAML-Code vorliegen haben

### Reflexionsfragen für die Kurzpräsentation

1. **Was hat der Agent erkannt, das Sie überrascht hat?** (Schlussfolgerungen die nicht offensichtlich waren)
2. **Wo lag der Agent falsch oder unvollständig?** (Jeder Fehler ist ein Lernmoment)
3. **Wie lange hätte dieser Report ohne KI-Unterstützung gedauert?**
4. **Welche Information fehlte, die den Bericht noch besser gemacht hätte?**

---

## Übung 2: Die selbstheilende Pipeline (60 Minuten)

### Aufgabenstellung

Sie haben ein Python-Projekt geerbt. Der Vorbesitzer ist nicht mehr erreichbar.
Die CI/CD-Pipeline schlägt fehl. Ihr Auftrag: Mit einem KI-Agenten das Projekt
analysieren, Fehler beheben und die Pipeline wieder zum Laufen bringen.

### Das kaputte Projekt

Erstellen Sie lokal eine Dateistruktur **oder** fügen Sie die Inhalte direkt in den Chat ein:

**requirements.txt:**
```
flask==2.0.0
requests==2.24.0
SQLAlchemy==1.3.0
pytest==6.2.0
cryptography==3.0.0
```

**app.py:**
```python
from flask import Flask, request, jsonify
import sqlite3
import hashlib

app = Flask(__name__)

# PROBLEM 1: Hardcoded credentials
DATABASE = "users.db"
SECRET_KEY = "super_secret_123"
ADMIN_PASSWORD = "admin123"

def get_db():
    conn = sqlite3.connect(DATABASE)
    return conn

@app.route('/login', methods=['POST'])
def login():
    username = request.json.get('username')
    password = request.json.get('password')
    
    # PROBLEM 2: SQL Injection vulnerability
    db = get_db()
    cursor = db.cursor()
    query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
    cursor.execute(query)
    user = cursor.fetchone()
    
    if user:
        return jsonify({"status": "success", "user": username})
    return jsonify({"status": "error"}), 401

@app.route('/users', methods=['GET'])  
def get_users():
    db = get_db()
    cursor = db.cursor()
    # PROBLEM 3: No authentication required
    cursor.execute("SELECT username, password FROM users")  # Returns passwords!
    users = cursor.fetchall()
    return jsonify(users)

@app.route('/calculate', methods=['POST'])
def calculate():
    # PROBLEM 4: eval() = Remote Code Execution vulnerability
    expression = request.json.get('expression')
    result = eval(expression)
    return jsonify({"result": result})

if __name__ == '__main__':
    # PROBLEM 5: Debug mode in production
    app.run(debug=True, host='0.0.0.0')
```

**test_app.py:**
```python
import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_login_success(client):
    # PROBLEM: Test uses SQL injection to always succeed
    response = client.post('/login', 
                           json={"username": "' OR '1'='1", "password": "anything"})
    # This test "passes" because SQL injection works - but that's wrong!
    assert response.status_code == 200

def test_get_users(client):
    response = client.get('/users')
    # Test passes even though unauthenticated access is a security hole
    assert response.status_code == 200

def test_calculate(client):
    response = client.post('/calculate', json={"expression": "2+2"})
    assert response.json()['result'] == 4
```

**.github/workflows/ci.yml:**
```yaml
name: CI Pipeline

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2  # Outdated version!
      
      - name: Set up Python
        uses: actions/setup-python@v2  # Outdated version!
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          # PROBLEM: flask 2.0.0 ist nicht kompatibel mit Python 3.11
          
      - name: Run tests
        run: pytest test_app.py -v
        
      - name: Security scan
        run: bandit -r app.py  # bandit ist nicht in requirements.txt!
```

### Schritt-für-Schritt-Anleitung

**Schritt 1: Vollständige Projektanalyse (15 Minuten)**

```
Ich habe ein Python-Flask-Projekt geerbt. Die CI-Pipeline schlägt fehl.
Bitte analysiere das gesamte Projekt vollständig.

[Füge alle Dateien hier ein: requirements.txt, app.py, test_app.py, ci.yml]

Liefere:
1. Eine strukturierte Übersicht des Projekts (Zweck, Architektur)
2. Alle gefundenen Probleme (technisch UND sicherheitsbezogen)
3. Priorisierung: Was muss sofort behoben werden?
4. Welche Pipeline-Fehler werden beim nächsten Run auftreten?
```

**Schritt 2: Sicherheitslücken beheben (20 Minuten)**

```
Fokus: Sicherheit.

Identifiziere und behebe ALLE Sicherheitslücken in app.py.
Für jede Lücke:
- Erkläre das Angriffsszenario (wie würde ein Angreifer das ausnutzen?)
- Zeige den korrekten, sicheren Code
- Erkläre, welches Sicherheitsprinzip verletzt wurde (OWASP Top 10 Referenz)

Beginne mit der kritischsten Lücke.
```

**Schritt 3: Tests korrigieren (10 Minuten)**

```
Die bestehenden Tests in test_app.py sind problematisch: Sie testen keine
korrekte Funktionalität, sondern testen (unbeabsichtigt) ob Sicherheitslücken
funktionieren.

Schreibe eine vollständige neue Test-Suite die:
1. Korrekte Authentifizierung testet (Erfolg UND Fehler)
2. SQL-Injection-Versuche korrekt ablehnt (Negativtest)
3. Unauthorized Access auf /users verhindert
4. Den /calculate-Endpoint mit sicherer Implementierung testet
5. Coverage > 80% erreicht

Nutze pytest und pytest-flask. Erkläre jeden Testfall kurz.
```

**Schritt 4: Pipeline reparieren (10 Minuten)**

```
Repariere die GitHub Actions Pipeline in ci.yml:
1. Aktualisiere alle outdated Actions auf aktuelle Versionen
2. Behebe den Python/Flask-Kompatibilitätsfehler in requirements.txt
3. Füge bandit zur Abhängigkeitsliste hinzu (Security Scanner)
4. Ergänze einen Dependency-Vulnerability-Check (z.B. pip-audit)
5. Füge einen Schritt hinzu der automatisch meldet wenn Tests fehlschlagen

Liefere die vollständige korrigierte ci.yml.
```

**Schritt 5: PR-Beschreibung generieren (5 Minuten)**

```
Erstelle eine vollständige Pull-Request-Beschreibung für alle unsere Änderungen.

Format:
## Zusammenfassung
[Was wurde geändert und warum?]

## Sicherheitsbehebungen
[Tabelle: Lücke / OWASP-Referenz / Fix]

## Breaking Changes
[Was könnte Nutzer dieser API betreffen?]

## Testing
[Wie wurden die Änderungen getestet?]

## Checklist
- [ ] Code reviewed
- [ ] Tests passing
- [ ] Security scan clean
- [ ] Dokumentation aktualisiert
```

### Reflexionsfragen

1. **Hätte eine normale Code-Review diese Lücken gefunden?** Wie lange hätte es gedauert?
2. **Welche Lücke war am gefährlichsten?** (eval()-RCE verdient besondere Diskussion)
3. **Wie verändert sich die Rolle des Entwicklers**, wenn ein Agent den Großteil des Sicherheits-Reviews übernimmt?
4. **Welche Lücken hat der Agent möglicherweise übersehen?** (Übungsaufgabe: Gibt es noch mehr?)

---

## Übung 3: Ihre eigene Agenten-Idee (30 Minuten)

### Das Agenten-Canvas

Entwickeln Sie in Kleingruppen ein konkretes Agenten-Konzept für Ihren IT-Bereich.
Nutzen Sie das folgende Canvas als Struktur (in 30 Minuten ausfüllbar).

```
┌──────────────────────────────────────────────────────────────┐
│                    AGENTEN-CANVAS                            │
├─────────────────────────┬────────────────────────────────────┤
│ AUFGABE                 │ TOOLS                              │
│                         │                                    │
│ Welches Problem löst    │ Welche Werkzeuge braucht           │
│ der Agent?              │ der Agent?                         │
│                         │ (APIs, Shell, DB, Browser, ...)    │
│                         │                                    │
├─────────────────────────┼────────────────────────────────────┤
│ INPUT (vom Menschen)    │ OUTPUT (vom Agenten)               │
│                         │                                    │
│ Was gibt der Mensch     │ Was liefert der Agent              │
│ vor?                    │ zurück?                            │
│                         │                                    │
├─────────────────────────┼────────────────────────────────────┤
│ AUTONOMIE               │ HUMAN-IN-THE-LOOP                  │
│                         │                                    │
│ Was entscheidet der     │ Bei welchen Aktionen MUSS          │
│ Agent selbst?           │ der Mensch freigeben?              │
│                         │                                    │
├─────────────────────────┼────────────────────────────────────┤
│ RISIKEN                 │ ERFOLGSMESSUNG                     │
│                         │                                    │
│ Was kann schiefgehen?   │ Woran messen Sie ob der            │
│ Welche Sicherheitsnetz? │ Agent erfolgreich ist?             │
│                         │                                    │
├─────────────────────────┴────────────────────────────────────┤
│ STARTPUNKT: Welchen ersten, kleinen Agenten könnten          │
│ Sie nächste Woche tatsächlich umsetzen?                      │
│                                                              │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### Ideen-Starter (falls Ihre Gruppe eine Inspiration braucht)

**Sysadmin-Bereich:**
- Agent der morgendlich Backup-Status aller Server prüft und einen strukturierten Report in Slack sendet
- Agent der bei neuem CVE-Alert automatisch prüft, ob unsere Systeme betroffen sind
- Agent der Monitoring-Alerts zusammenfasst und priorisiert (statt 200 E-Mails/Tag)

**DevOps-Bereich:**
- Agent der bei fehlgeschlagenem Deployment automatisch die letzten 3 Commits auf Rollback-Kandidaten prüft
- Agent der Code-Review-Kommentare klassifiziert (kritisch/nice-to-have) und zusammenfasst
- Agent der Dependency-Updates wöchentlich in einem Branch testet und bei Erfolg einen PR erstellt

**Eigene Idee (am besten!):**
- Gibt es eine Aufgabe in Ihrem Alltag, die Sie täglich nervt und repetitiv ist?
- Gibt es Informationen, die Sie regelmäßig aus mehreren Quellen zusammensuchen?

### Pitch-Format (3 Minuten pro Gruppe)

```
1. Das Problem (30 Sekunden): Was nervt/kostet Zeit ohne Agent?
2. Die Lösung (60 Sekunden): Canvas-Ergebnis vorstellen
3. Der erste Schritt (30 Sekunden): Was würden Sie nächste Woche umsetzen?
4. Das größte Risiko (30 Sekunden): Was kann schiefgehen?
5. Fragen (30 Sekunden): Eine offene Frage an die Gruppe
```

---

## Abschlussdiskussion: Kritische Reflexion (15 Minuten)

### Leitfragen für die Diskussion

**Zur Technik:**
- Welche Aufgabe aus den Übungen würden Sie als erstes in Ihrer realen Umgebung einführen?
- Welches Tool aus dem heutigen Tag werden Sie in der nächsten Woche ausprobieren?

**Zu den Grenzen:**
- Welche IT-Aufgabe sollte kein KI-Agent jemals vollautomatisch erledigen?
- Wie erklären Sie einem skeptischen Kollegen den Unterschied zwischen "KI macht meinen Job" und "KI verändert meinen Job"?

**Zu den Risiken:**
- Was passiert, wenn ein KI-Agent einen falschen Fix in Produktion deployed?
- Wer haftet: der Admin, das Unternehmen, der KI-Anbieter?

**Zur Zukunft:**
- Welche IT-Rolle wird in 5 Jahren durch agentische KI am stärksten verändert sein?
- Welche neuen Rollen entstehen durch KI-Agenten? (z.B. "Prompt Engineer für Sysadmin-Agenten")

---

*→ Weiter mit Kapitel 05: Wichtige Konzepte und Sicherheitsaspekte*
