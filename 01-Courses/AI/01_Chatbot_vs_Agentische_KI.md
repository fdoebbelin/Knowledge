# Kapitel 01 – Chatbot vs. Agentische KI
## Von reaktiven Chatbots zu autonomen KI-Agenten

---

## Lernziele dieses Kapitels

Nach diesem Kapitel können Sie:
- den fundamentalen Unterschied zwischen Chatbot und KI-Agent präzise erklären
- das ReAct-Framework als Grundprinzip agentischer KI beschreiben
- einschätzen, welche Aufgaben sich für einen Agenten eignen – und welche nicht
- erste eigene Prompts für agentenähnliches Verhalten formulieren

---

## 1.1 Was ist ein Chatbot?

Ein klassischer Chatbot folgt einem einfachen Schema:

```
Mensch stellt Frage  →  KI generiert Antwort  →  Fertig.
```

Das war der Stand bis ca. 2022. Tools wie der erste ChatGPT (GPT-3.5) oder klassische Unternehmens-Chatbots arbeiteten ausschließlich nach diesem Muster. Die KI hat **kein Gedächtnis** über den aktuellen Chat hinaus, **keine Werkzeuge**, kann **nichts ausführen** und **keine mehrschrittigen Pläne** umsetzen.

### Typische Chatbot-Interaktion (Beispiel IT-Support)

> **Nutzer:** Wie finde ich heraus, welcher Prozess Port 8080 belegt?  
> **Chatbot:** Unter Linux können Sie den Befehl `lsof -i :8080` oder `ss -tlnp | grep 8080` verwenden. Unter Windows nutzen Sie `netstat -ano | findstr :8080`.

Das ist nützlich – aber der Chatbot **führt nichts aus**. Er gibt Wissen weiter. Der Mensch muss selbst aktiv werden.

---

## 1.2 Was ist ein KI-Agent?

Ein KI-Agent ist eine KI, die:

1. **Werkzeuge benutzt** (Terminal, APIs, Browser, Datenbanken)
2. **Mehrere Schritte plant und ausführt** ohne für jeden Schritt gefragt zu werden
3. **Ergebnisse bewertet** und bei Bedarf den Plan anpasst
4. **Persistentes Gedächtnis** über eine Sitzung hinaus aufbauen kann
5. **Autonom entscheidet**, welcher Schritt als nächstes sinnvoll ist

### Typische Agenten-Interaktion (gleicher IT-Support-Fall)

> **Nutzer:** Port 8080 ist auf Server prod-web-03 blockiert. Finde heraus warum und behebe das Problem, falls es sicher ist.

**Was der Agent dann tut (autonom, ohne weitere Fragen):**
```
[Schritt 1] SSH-Verbindung zu prod-web-03 herstellen
[Schritt 2] lsof -i :8080 ausführen → Ergebnis: Java-Prozess PID 14923 (Tomcat)
[Schritt 3] Prozess-Details prüfen: ps aux | grep 14923
[Schritt 4] Logs analysieren: tail -n 200 /var/log/tomcat/catalina.out
[Schritt 5] Erkenntnis: Out-of-Memory-Error → Heap-Size zu klein
[Schritt 6] Empfehlung formulieren: JVM-Parameter anpassen (-Xmx2g → -Xmx4g)
[Schritt 7] Änderung vorschlagen und auf menschliche Freigabe warten (HITL)
[Schritt 8] Nach Freigabe: Konfiguration ändern, Tomcat neu starten, Status prüfen
[Schritt 9] Bericht erstellen: Was war das Problem, was wurde geändert, Empfehlung für Monitoring
```

---

## 1.3 Der Vergleich im Detail

| Merkmal | Klassischer Chatbot | KI-Agent |
|---|---|---|
| **Interaktionsmodus** | Eine Frage → Eine Antwort | Aufgabe → Mehrstufige autonome Ausführung |
| **Werkzeuge** | Keines (nur Text) | Terminal, APIs, Browser, DB, E-Mail, ... |
| **Gedächtnis** | Nur aktueller Chat-Verlauf | Kurzzeit + Langzeitgedächtnis (Vektordatenbank) |
| **Planung** | Keine | Plant Teilschritte, priorisiert, adaptiert |
| **Fehlerbehandlung** | Keine – gibt Fehler als Text zurück | Erkennt Fehler, probiert Alternativen |
| **Autonomiegrad** | Reaktiv (wartet auf Eingabe) | Proaktiv (arbeitet bis Ziel erreicht) |
| **Typische Nutzung** | Wissensabfrage, Textgenerierung | Komplexe, mehrstufige IT-Aufgaben |
| **Beispiel-Eingabe** | "Erkläre mir RAID 5." | "Analysiere Disk-I/O aller Produktionsserver und erstelle einen Kapazitätsbericht." |
| **Mensch-Maschine-Verhältnis** | Mensch führt alles aus | Agent führt aus, Mensch gibt Ziele vor |
| **Risiko** | Gering (keine Aktionen) | Höher (führt echte Aktionen aus) |

---

## 1.4 Das ReAct-Framework – Das Herzstück agentischer KI

ReAct steht für **Re**asoning + **Act**ing. Es ist das meistgenutzte Paradigma für KI-Agenten und beschreibt den inneren Denkzyklus:

```
┌─────────────────────────────────────────────────────────────┐
│                    DER REACT-LOOP                           │
│                                                             │
│   AUFGABE EMPFANGEN                                         │
│         ↓                                                   │
│   ┌─── THINK ──────────────────────────────────────────┐   │
│   │ "Was ist das Ziel? Welcher Schritt ist sinnvoll?   │   │
│   │  Was weiß ich bereits? Was fehlt mir noch?"        │   │
│   └─────────────────────────────────────────────────────┘  │
│         ↓                                                   │
│   ┌─── ACT ────────────────────────────────────────────┐   │
│   │ Werkzeug aufrufen: Shell-Befehl, API-Request,      │   │
│   │ Datei lesen/schreiben, Web-Suche, Berechnung...    │   │
│   └─────────────────────────────────────────────────────┘  │
│         ↓                                                   │
│   ┌─── OBSERVE ────────────────────────────────────────┐   │
│   │ Ergebnis auswerten: Erfolgreich? Fehler?           │   │
│   │ Neue Informationen? Ziel erreicht?                 │   │
│   └─────────────────────────────────────────────────────┘  │
│         ↓                                                   │
│   Ziel erreicht? → JA → Ergebnis ausgeben                   │
│                 → NEIN → zurück zu THINK                    │
│                 → UNSICHER → Mensch fragen (HITL)           │
└─────────────────────────────────────────────────────────────┘
```

### Beispiel eines ReAct-Logs (Transparenz des Agenten)

Moderne Agenten wie Claude oder GPT-4 mit Tools zeigen diesen Denkprozess explizit:

```
Thought: Der Nutzer möchte wissen, ob der Nginx-Dienst auf server-01 läuft.
         Ich sollte den Dienststatus prüfen.
Action: bash_execute("ssh admin@server-01 'systemctl status nginx'")
Observation: Unit nginx.service - A high performance web server
             Active: failed (Result: exit-code) since 2026-03-01 14:23:11
             Process: ExecStart=/usr/sbin/nginx (code=exited, status=1/FAILURE)

Thought: Nginx ist ausgefallen und hat einen Exit-Code 1. Ich schaue ins Error-Log.
Action: bash_execute("ssh admin@server-01 'journalctl -u nginx -n 50 --no-pager'")
Observation: Mar 01 14:23:11 server-01 nginx[8821]: nginx: [emerg] bind() to 
             0.0.0.0:80 failed (98: Address already in use)

Thought: Port 80 ist bereits belegt. Ich prüfe, welcher Prozess das ist.
Action: bash_execute("ssh admin@server-01 'lsof -i :80'")
Observation: COMMAND   PID     USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
             apache2  3421     www-data  4u  IPv6  12345  0t0  TCP *:http

Thought: Apache2 blockiert Port 80. Das ist der Konflikt. Ich informiere den Nutzer
         und frage, ob ich Apache2 stoppen und Nginx starten soll.
Answer: Nginx ist ausgefallen, weil Apache2 bereits Port 80 belegt (PID 3421).
        Mögliche Lösung: Apache2 stoppen → `systemctl stop apache2` → Nginx starten.
        Soll ich das ausführen? [Menschliche Freigabe erforderlich]
```

---

## 1.5 Welche Aufgaben eignen sich für Agenten?

### ✅ Ideal für KI-Agenten

- Aufgaben mit **klarem Ziel, aber unbekanntem Weg** ("Finde und behebe das Performance-Problem")
- **Repetitive, regelbasierte Prozesse** die manuell zu aufwändig sind (Log-Rotation, Backup-Checks)
- **Informationsaggregation** aus vielen Quellen (mehrere Server, APIs, Dashboards)
- **Diagnose und Root-Cause-Analyse** bei komplexen Fehlerbildern
- **Code-Review und automatisches Testen** mit klaren Qualitätskriterien

### ⚠️ Bedingt geeignet (mit starker menschlicher Aufsicht)

- Konfigurationsänderungen in Produktionssystemen
- Sicherheitsrelevante Entscheidungen
- Datenbankoperationen (INSERT, UPDATE, DELETE)
- Kommunikation nach außen (E-Mails, Tickets, Kundenkommunikation)

### ❌ Nicht geeignet (heute)

- Aufgaben, die **kreative Strategie** und Unternehmenskontext erfordern
- **Ethische Entscheidungen** (Kündigung, Datenschutz-Ausnahmen)
- Aufgaben mit **extrem hohem Fehlerpotenzial** ohne einfaches Rollback
- **Novel-Situationen** ohne Präzedenzfall im Trainings- oder Kontextfenster

---

## 1.6 Screenshot-Walkthrough: Agentisches Verhalten in Claude.ai

> **Was Sie in der Demo sehen sollten:**

**Screenshot 1 – Tool-Aufruf sichtbar machen:**
In Claude.ai (Pro/Team) können Sie im linken Panel sehen, welche Tools der Agent aktiviert hat (Web-Suche, Code-Ausführung, Datei-Upload). Wenn der Agent eine Web-Suche durchführt, erscheint eine kleine Karte mit dem Suchergebnis.

**Screenshot 2 – Mehrstufige Ausführung:**
Geben Sie Claude die Aufgabe: *"Analysiere diese Log-Datei [Upload], identifiziere Fehler-Cluster und erstelle eine Zusammenfassung mit Häufigkeitsverteilung."*
Beobachten Sie, wie Claude: (1) die Datei liest, (2) Code zur Analyse schreibt und ausführt, (3) Ergebnisse interpretiert, (4) eine Zusammenfassung erstellt – alles ohne weiteren Input.

**Screenshot 3 – Human-in-the-Loop:**
Geben Sie eine Aufgabe mit möglichen Konsequenzen: *"Finde alle Dateien älter als 90 Tage im Verzeichnis /tmp und lösche sie."*
Ein guter Agent wird **nachfragen**, bevor er löscht.

---

## 1.7 Prompt-Vorlage: Den Agenten-Modus aktivieren

Der Unterschied zwischen Chatbot-Antwort und Agenten-Verhalten beginnt im Prompt:

### ❌ Chatbot-Prompt (bekommt Erklärung)
```
Was sind die häufigsten Ursachen für hohe CPU-Auslastung auf einem Linux-Server?
```

### ✅ Agenten-Prompt (initiiert mehrstufige Analyse)
```
Du bist ein erfahrener Linux-Systemadministrator mit Root-Zugang zu server-prod-01.

AUFGABE: Die CPU-Auslastung liegt seit 2 Stunden bei über 95%. Finde die Ursache
und empfehle konkrete Maßnahmen.

VERFÜGBARE TOOLS: SSH-Zugang, top, htop, ps, strace, perf, systemd-journal

VORGEHEN:
1. Führe eine systematische Diagnose durch (mindestens 5 verschiedene Checks)
2. Priorisiere Befehle vom Allgemeinen zum Spezifischen
3. Dokumentiere jeden Schritt mit Befehl + erwartetes/tatsächliches Ergebnis
4. Wenn du eine irreversible Aktion planst: Warte auf meine Freigabe
5. Am Ende: Root-Cause + 3 konkrete Maßnahmen mit Priorisierung

Beginne jetzt mit der Diagnose.
```

---

## Zusammenfassung

| | Chatbot | KI-Agent |
|---|---|---|
| **Kernfunktion** | Wissen abrufen | Probleme lösen |
| **Input** | Frage | Aufgabe / Ziel |
| **Output** | Text-Antwort | Ausgeführte Aktionen + Ergebnis |
| **Grundprinzip** | Antworten | Think → Act → Observe (ReAct) |
| **Autonomie** | Keine | Hoch (mit definierten Grenzen) |

> **Merksatz:** Ein Chatbot ist wie ein sehr kluger Kollege am Telefon, der Ihnen erklärt, was zu tun ist. Ein KI-Agent ist wie ein selbstständig arbeitender Spezialist, dem Sie ein Ergebnis beauftragen – und der Sie nur für wichtige Entscheidungen kontaktiert.

---

*→ Weiter mit Kapitel 02: Systemadministration mit KI-Agenten*
