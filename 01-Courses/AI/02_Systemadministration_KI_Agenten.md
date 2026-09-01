# Kapitel 02 – Systemadministration mit KI-Agenten
## Autonome Infrastrukturüberwachung, Diagnose und Selbstheilung

---

## Lernziele dieses Kapitels

- Drei konkrete Sysadmin-Szenarien für KI-Agenten kennen und erklären
- Tool-Landschaft für agentische Systemadministration überblicken
- Prompt-Strategien für Diagnose, Monitoring und Patch-Management anwenden
- Risiken und Kontrollmechanismen beim Agenten-Einsatz in der Infrastruktur benennen

---

## 2.1 Warum Systemadministration ideal für Agenten ist

Systemadministration besteht zu einem großen Teil aus Aufgaben, die strukturiert und wiederholbar sind:

- **Log-Analyse:** Täglich gleiche Muster suchen, Anomalien identifizieren
- **Patch-Management:** CVE prüfen → testen → rollout → dokumentieren
- **Performance-Monitoring:** Metriken sammeln → schwellwertbasiert reagieren
- **Backup-Checks:** Status prüfen → Fehlermeldungen eskalieren
- **Kapazitätsplanung:** Trends erkennen → Prognosen erstellen

Das sind genau die Aufgaben, für die KI-Agenten gemacht sind: **klare Ziele, bekannte Werkzeuge, viele Zwischenschritte, aber kein kreativer Sprung nötig**.

Gleichzeitig können Fehler teuer sein. Deshalb gilt: **Je höher das Risiko der Aktion, desto mehr Aufsicht braucht der Agent.**

---

## 2.2 Szenario A: Autonome Log-Analyse mit automatischer Ticket-Erstellung

### Das Problem ohne KI-Agenten

Ein erfahrener Sysadmin verbringt täglich 1–3 Stunden damit, Logs zu sichten:
- `grep "ERROR" /var/log/syslog | tail -100` → 847 Treffer
- Manuell filtern, was relevant ist
- Root-Cause raten
- Ticket anlegen – oft ohne vollständigen Kontext

**Ergebnis:** Wichtige Fehler werden übersehen, Tickets sind unvollständig, der Admin ist erschöpft.

### Das Problem mit KI-Agenten

```
Kontinuierliches Monitoring (24/7)
         ↓
Anomalie erkannt (Häufung, neues Muster, kritischer Schwellwert)
         ↓
Agent korreliert Logs (Syslog + App-Log + DB-Log + Metriken)
         ↓
Root-Cause-Hypothese mit Konfidenzniveau
         ↓
Ticket erstellt (priorisiert, mit Kontext, mit Vorschlag)
         ↓
Benachrichtigung nur bei: kritisch, neu, uneindeutig
```

### Praxisbeispiel: Fehler-Kaskade erkennen

**Logdaten aus drei Quellen (simuliert):**

```
# /var/log/syslog
Mar 01 14:00:03 prod-db-01 kernel: [12345.678] Out of memory: Kill process 8821
Mar 01 14:00:04 prod-db-01 mysqld[8821]: Killed

# /var/log/nginx/error.log  
Mar 01 14:00:05 prod-web-01 [error] 8822#8822: *14234 connect() to 
  127.0.0.1:3306 failed (111: Connection refused) while connecting to upstream

# /var/log/app/application.log
Mar 01 14:00:06 prod-app-01 ERROR [DatabasePool] All connections failed after 3 retries
Mar 01 14:00:06 prod-app-01 WARN  [HealthCheck] Database unreachable - circuit breaker OPEN
Mar 01 14:00:09 prod-app-01 ERROR [RequestHandler] 503 Service Unavailable: 2847 requests queued
```

**Was ein Chatbot sagt:** "Das klingt nach einem Datenbankproblem."

**Was ein KI-Agent tut:**
1. Korreliert alle drei Log-Quellen anhand der Zeitstempel
2. Erkennt die Kausalkette: OOM → MySQL-Kill → Connection refused → App-Fehler → Nutzer-Impact
3. Berechnet: 2.847 wartende Anfragen × Ø 200ms = geschätzter Impact
4. Erstellt Ticket mit: Root-Cause, betroffene Systeme, Timeline, empfohlene Sofortmaßnahme, Präventionsempfehlung

### Screenshot-Beschreibung: Log-Analyse in der Praxis

> **Was Sie in einer Demo sehen:**
>
> Sie laden drei Log-Dateien in Claude.ai hoch (oder nutzen Claude Code im Terminal).
> Der Agent öffnet alle Dateien, schreibt intern ein Python-Skript zur Zeitstempel-Normalisierung,
> korreliert die Ereignisse und gibt eine sortierte Fehler-Timeline aus.
> Im Hintergrund (sichtbar im "Thinking"-Panel bei Claude) sehen Sie den Analyseprozess:
> erst breite Suche, dann Eingrenzung auf das kritische 5-Minuten-Fenster.

### Prompt-Vorlage: Log-Analyse-Agent

```markdown
## SYSTEM-PROMPT (einmalig setzen)
Du bist ein Senior-SRE (Site Reliability Engineer) mit 10 Jahren Erfahrung
in Linux-Infrastruktur, MySQL und Nginx.

Dein Auftrag: Analysiere Produktions-Logs und identifiziere kritische Ereignisse.

PRIORISIERUNG:
- KRITISCH: Datenverlust, kompletter Service-Ausfall, Sicherheitsvorfälle
- HOCH: Degraded Service, >10% Fehlerrate, Speicherengpass >90%
- MITTEL: Einzelne Fehler, Performance-Degradation <20%
- INFO: Normale Warnungen, planbare Wartung

AUSGABEFORMAT für jedes identifizierte Problem:
[PRIORITÄT] Zeitraum: XX:XX - XX:XX
Root-Cause: [1 Satz]
Betroffene Systeme: [Liste]  
Empfohlene Sofortmaßnahme: [konkreter Befehl oder Aktion]
Ticket-Text: [fertig formuliert, Jira-ready]

---

## USER-PROMPT (für jede Analyse)
Analysiere die folgenden Log-Dateien vom [DATUM], Zeitraum [VON] bis [BIS].

[LOG-DATEI 1: syslog]
[hier Loginhalt einfügen oder Datei hochladen]

[LOG-DATEI 2: nginx/error.log]
[hier Loginhalt einfügen]

[LOG-DATEI 3: application.log]  
[hier Loginhalt einfügen]

Gehe systematisch vor:
1. Erstelle zuerst eine Zeitlinie aller Fehler-Ereignisse
2. Identifiziere Korrelationen (zeitlich und kausal)
3. Priorisiere nach obigem Schema
4. Erstelle für jeden KRITISCH/HOCH-Befund einen Ticket-Draft
```

---

## 2.3 Szenario B: KI-gesteuertes Patch-Management

### Der traditionelle Patch-Zyklus (Schmerzpunkte)

| Phase | Ohne KI | Zeitaufwand |
|---|---|---|
| CVE-Monitoring | Manuell RSS-Feeds, E-Mails | 30-60 Min/Tag |
| Relevanz-Check | Manuell: Betrifft uns das? | 15 Min/CVE |
| Risikobewertung | Bauchgefühl + Spreadsheet | 30 Min/CVE |
| Test-Rollout | Manuell, oft übersprungen | 2-4h |
| Prod-Rollout | Manuell, außerhalb Geschäftszeiten | 4-8h |
| Dokumentation | Oft nachträglich oder gar nicht | 30 Min |
| **Gesamt pro Patch** | | **8-15 Stunden** |

### Mit KI-Agenten: Halbautomatisches Patch-Management

```
TÄGLICH (automatisch):
─────────────────────────────────────────────────────────
Agent scannt:  NVD (nvd.nist.gov), GitHub Security Advisories,
               vendor-spezifische Feeds (Debian, Ubuntu, Red Hat)
               
Agent vergleicht: CVE-Daten mit installierter Software
                  (via Ansible-Inventory oder CMDB-API)

Agent bewertet:
  CVSS-Score ≥ 9.0   → KRITISCH  → sofortige Benachrichtigung
  CVSS-Score 7.0-8.9 → HOCH      → Patch innerhalb 7 Tage
  CVSS-Score < 7.0   → MITTEL    → nächster Patch-Zyklus

─────────────────────────────────────────────────────────
PATCH-AUSFÜHRUNG (halbautomatisch):

  Staging:    Vollautomatisch
              → Patch einspielen
              → Smoke-Tests ausführen  
              → Rollback bei Fehler
              → Ergebnis protokollieren

  Produktion: Menschliche Freigabe erforderlich
              → Agent erstellt Change-Request-Dokument
              → Rollout nach Freigabe
              → Automatisches Rollback wenn Fehlerrate steigt
```

### Prompt-Vorlage: Patch-Analyse-Agent

```markdown
## USER-PROMPT: CVE-Bewertung

Ich habe eine neue Sicherheitsmeldung erhalten: CVE-[NUMMER]

Meine Umgebung:
- Betriebssystem: Ubuntu 22.04 LTS
- Betroffene Software: OpenSSL 3.0.2
- Installiert auf: 47 Produktionsservern (Web-Tier + DB-Tier)
- Externe Erreichbarkeit: Web-Tier ja, DB-Tier nein

Bitte analysiere:
1. Schwere und Ausnutzbarkeit dieser CVE (CVSS-Score + Vektor)
2. Ist unsere spezifische Version betroffen? (Version-Check)
3. Gibt es bereits bekannte Exploits in freier Wildbahn?
4. Empfohlene Patch-Version und Quelle
5. Risiko für unsere Umgebung (extern vs. intern getrennt bewerten)
6. Rollout-Empfehlung: Wie vorgehen bei 47 Servern?
7. Teste-Befehl, mit dem ich nach dem Patch die Behebung verifiziere

Erstelle am Ende einen fertigen Change-Request-Text für unser ITSM-System.
```

---

## 2.4 Szenario C: Intelligente Kapazitätsplanung (Cloud)

### Das Problem: Reaktiv statt proaktiv

Ohne KI: Der Admin bemerkt den Speicherengpass, wenn der Alarm ausgelöst wird – und der Dienst schon langsam ist.

Mit KI-Agent: Der Agent erkennt den **Trend** 2 Wochen vorher und handelt.

### Praxis-Beispiel: Speicher-Wachstumsprognose

```python
# Was der Agent im Hintergrund ausführt (vereinfacht):

# Metriken der letzten 90 Tage abrufen
disk_usage = prometheus_query('node_filesystem_avail_bytes{mountpoint="/data"}', 
                               range='90d')

# Linearer Trend berechnen
slope = calculate_trend(disk_usage)  # GB pro Tag

# Projektion
days_until_full = current_free_space / slope
# Ergebnis: "In 23 Tagen wird /data voll sein"

# Alert erstellen, wenn < 30 Tage
if days_until_full < 30:
    create_ticket(
        priority="HOCH",
        title=f"Speicherengpass /data in {days_until_full:.0f} Tagen",
        description=f"""
        Aktueller Füllstand: {current_used:.1f}% 
        Wachstumsrate: {slope:.2f} GB/Tag
        Projektion: Voll am {projected_date}
        
        Empfehlung: 
        Option A: Volume-Erweiterung um 500 GB (Kosten: ~45€/Monat)
        Option B: Log-Rotation verschärfen (geschätzte Einsparung: 120 GB)
        Option C: Archivierung alter Daten auf S3 Glacier
        """
    )
```

### Tool-Integration für Kapazitätsplanung

| Tool | Rolle des Agenten | Vorteil |
|---|---|---|
| **Prometheus + Grafana** | Metriken abrufen und analysieren | Echtzeit-Daten, historische Trends |
| **AWS Cost Explorer API** | Kostenoptimierung analysieren | Automatische Spotinstance-Empfehlungen |
| **Ansible** | Konfigurationsänderungen ausrollen | Idempotent, auditierbar |
| **Terraform** | Infrastruktur skalieren | Infrastructure-as-Code, Rollback möglich |
| **PagerDuty / Opsgenie** | Eskalationen auslösen | Qualifizierte Alerts statt Rauschen |

---

## 2.5 Tool-Vergleich: Agentische Werkzeuge für Sysadmins

| Tool | Typ | Stärken | Schwächen | Kosten |
|---|---|---|---|---|
| **Claude Code** | Terminal-Agent | Versteht komplexe Systemzustände, erklärt jeden Schritt, sehr sicher | Kein persistentes Gedächtnis out-of-the-box | Claude Pro: ~20$/Monat |
| **GitHub Copilot CLI** | Shell-Assistent | Direkt im Terminal, Befehle erklären, korrigieren | Kein echter Agent-Loop, keine mehrstufigen Tasks | 10$/Monat |
| **n8n + LLM** | Workflow-Automatisierung | Visuelle Pipeline, viele Integrationen (Jira, Slack, PagerDuty) | Setup-Aufwand, kein Free-Tier für Self-Hosted + API | Self-hosted kostenlos |
| **Ansible + AI** | Konfigurationsmanagement | Bestehende Ansible-Rollen KI-gestützt erweitern | Kein nativer KI-Agent, Promptengineering nötig | Open Source |
| **Datadog Watchdog** | Monitoring-Agent | Automatische Anomalieerkennung, kein Prompt nötig | Proprietär, teuer, wenig erklärbar | Ab 15$/Host/Monat |
| **Elastic SIEM + ML** | Security-Monitoring | Verhaltensbasierte Anomalieerkennung | Sehr komplex, hohe Lernkurve | Aufwändig |

### Empfehlung für Einsteiger

Starten Sie mit **Claude Code oder Claude.ai** für Diagnose-Aufgaben – kein Setup, sofort nutzbar.
Für Automatisierung: **n8n** als Orchestrierungsschicht, die KI-Calls mit bestehenden Tools verbindet.

---

## 2.6 Prompt-Vorlagen: Sysadmin-Schnellreferenz

### Server-Diagnose (allgemein)
```
Du bist ein erfahrener Linux-Sysadmin. Führe eine vollständige Diagnose von
[SERVERNAME] durch. Das gemeldete Problem: [PROBLEM-BESCHREIBUNG].

Untersuche systematisch:
1. System-Ressourcen (CPU, RAM, Disk, Network)
2. Laufende Prozesse und Services
3. Logs der letzten 2 Stunden (syslog, journald, app-spezifisch)
4. Netzwerk-Verbindungen und offene Ports
5. Cron-Jobs und geplante Tasks

Für jeden Schritt: Befehl → Erwartetes Ergebnis → Tatsächliches Ergebnis → Interpretation
Stoppe und frage mich, bevor du etwas ändert.
```

### Automatisiertes Reporting
```
Erstelle einen wöchentlichen Infrastruktur-Report für unser Management-Dashboard.

Eingabe-Daten: [Metriken der letzten 7 Tage als CSV oder JSON]

Report-Struktur:
1. Executive Summary (3 Sätze, für nicht-technische Führungskräfte)
2. Verfügbarkeit: SLA-Einhaltung pro Service
3. Performance-Trends: Was hat sich verbessert/verschlechtert?
4. Top-5-Incidents: Ursache + Behebungszeit + Lessons Learned
5. Kommende Risiken: Was braucht Aufmerksamkeit in den nächsten 14 Tagen?
6. Empfehlungen: 3 konkrete Maßnahmen mit Aufwand (S/M/L)

Format: Markdown, geeignet für Confluence-Import
```

---

## Zusammenfassung

KI-Agenten transformieren Systemadministration von reaktiver Problemlösung zu proaktiver Infrastrukturpflege. Die drei Schlüssel-Szenarien:

1. **Log-Analyse:** Von stundenlangem manuellem Durchsuchen zu qualifizierten, kontextreichen Alerts
2. **Patch-Management:** Von reaktivem 15-Wochen-Zyklus zu kontinuierlichem, risikobasiertem Patching
3. **Kapazitätsplanung:** Von monatlichen Überprüfungen zu tagesaktuellem Trend-Monitoring

**Goldene Regel:** Agenten für Diagnose und Empfehlung = maximal autonom. Agenten für Produktions-Änderungen = immer Human-in-the-Loop.

---

*→ Weiter mit Kapitel 03: Softwareentwicklung & DevOps mit KI-Agenten*
