# Kapitel 03 – Softwareentwicklung & DevOps mit KI-Agenten
## Code-Generierung, autonomes Testing und selbstheilende Pipelines

---

## Lernziele dieses Kapitels

- Das Konzept "Vibe Coding" und agentische Entwicklung einordnen
- Drei DevOps-Szenarien mit KI-Agenten kennen und vergleichen
- Die wichtigsten KI-Coding-Tools gegenüberstellen und situationsgerecht wählen
- Prompt-Vorlagen für Code-Review, Debugging und Pipeline-Analyse anwenden

---

## 3.1 Die neue Rolle des Entwicklers

### Vorher: Entwickler als Handwerker

```
Anforderung → Entwickler schreibt Code → Entwickler testet → 
Entwickler reviewed → Entwickler dokumentiert → Deployment
```

Jeder dieser Schritte: Stunden bis Tage. Jeder Schritt: manuell.

### Nachher: Entwickler als Regisseur

```
Anforderung → Entwickler formuliert Ziel → Agent implementiert →
Entwickler prüft und freigibt → Agent testet und deployed
```

Der Entwickler gibt **Richtung, Kontext und Qualitätskriterien** vor.
Der Agent übernimmt **Implementierung, Testing und Dokumentation**.

Das nennt sich **"Vibe Coding"** – der Begriff, den Andrej Karpathy (OpenAI-Mitgründer) 2025 geprägt hat: Man beschreibt, wie der Code sich "anfühlen" soll, und der Agent liefert.

> **Wichtig:** Das bedeutet nicht, dass Programmierkenntnisse wertlos werden. Im Gegenteil: Wer Codeergebnisse nicht bewerten kann, ist blind. Der Entwickler muss den Output verstehen, Fehler erkennen und Sicherheitsrisiken identifizieren.

---

## 3.2 Szenario A: Der autonome Code-Entwickler

### Realitätscheck: Was Agenten heute wirklich leisten

**Kann ein Agent alleine ein komplettes Produkt bauen?**
Nein – zuverlässig für: einzelne Features, Bugfixes, Refactoring, Tests, Dokumentation.
Nein – noch nicht für: Architekturentscheidungen, Anforderungsanalyse, UX-Design, Business-Logik ohne klare Spezifikation.

### Praxisbeispiel: Feature-Implementierung mit Claude Code

**Eingabe des Entwicklers:**
```
Implementiere in unserem bestehenden FastAPI-Projekt (Python 3.11) einen 
neuen Endpoint: POST /api/v1/users/{user_id}/api-keys

Anforderungen:
- JWT-Authentifizierung (wir nutzen python-jose)
- Rate-Limiting: max 5 API-Keys pro User
- API-Key: 32 Zeichen, alphanumerisch, sha256-gehashed in DB gespeichert
- Unit-Tests mit pytest, Coverage > 90%
- OpenAPI-Dokumentation (docstrings)
- Fehlerbehandlung: 401, 403, 409 (Limit erreicht), 422
```

**Was der Agent dann macht (beobachtbar in Claude Code):**

```
[Agent liest Projektstruktur]
Reading: ./main.py, ./models/user.py, ./routers/auth.py, ./tests/

[Agent analysiert bestehende Muster]
Ich sehe, dass das Projekt Pydantic v2, SQLAlchemy 2.0 und pytest-asyncio verwendet.
Ich passe meinen Code an diese Muster an.

[Agent schreibt Implementierung]
Creating: ./models/api_key.py
Creating: ./routers/api_keys.py  
Modifying: ./main.py (Router registrieren)

[Agent führt Tests aus]
$ pytest tests/test_api_keys.py -v
FAILED: test_create_api_key_unauthorized (401 nicht korrekt gemappt)

[Agent analysiert Fehler und korrigiert]
Fehler gefunden: JWT-Dependency falsch importiert. Korrigiere...

[Agent führt Tests erneut aus]
$ pytest tests/test_api_keys.py -v --cov=routers/api_keys
PASSED: 12 tests
Coverage: 94%

[Agent erstellt Zusammenfassung]
```

**Gesamtdauer:** 4–8 Minuten für ein Feature, das ein Junior-Entwickler 3–5 Stunden benötigt hätte.

---

## 3.3 Szenario B: Selbstheilende CI/CD-Pipeline

### Das klassische Pipeline-Problem

```
Entwickler pusht Code
       ↓
Pipeline schlägt fehl (Fehlermeldung: 847 Zeilen Stacktrace)
       ↓
Entwickler liest Fehlermeldung (15-30 Minuten)
       ↓
Entwickler sucht auf Stack Overflow / Dokumentation
       ↓
Fix versuchen → oft wieder fehlschlagen
       ↓
Eskalation → Senior-Entwickler blockiert (1-2 Stunden)
```

### Die KI-gestützte Pipeline

```
Entwickler pusht Code
       ↓
Pipeline schlägt fehl
       ↓
KI-Agent analysiert Fehler (30 Sekunden)
       ↓
Agent identifiziert: Dependency-Konflikt (requests 2.28 vs. 2.31)
       ↓
Agent erstellt Fix-Commit automatisch
       ↓
Agent kommentiert im PR: "Fixed: requests version pinned to >=2.28,<3.0 
                          (Kompatibel mit urllib3 2.x)"
       ↓
Pipeline erneut ausgeführt: PASS ✓
```

### Pipeline-Phasen und KI-Einsatz

| Pipeline-Phase | KI-Aufgabe | Automatisierungsgrad |
|---|---|---|
| **Code-Push** | Syntax-Check, Linting, Style-Enforcement | Vollautomatisch |
| **PR-Erstellung** | Code-Review: Bugs, Security, Performance | Vollautomatisch (Kommentar) |
| **Unit-Tests** | Test-Fehler analysieren, Fix vorschlagen | Halbautomatisch |
| **Integration-Tests** | Flaky-Test-Erkennung, Diagnose | Vollautomatisch |
| **Build** | Build-Fehler analysieren, Dependencies fixen | Halbautomatisch |
| **Security-Scan** | CVE-Bewertung, Patch-Vorschlag | Halbautomatisch |
| **Staging-Deploy** | Smoke-Tests, Performance-Baseline | Vollautomatisch |
| **Prod-Deploy** | Canary-Rollout, Anomalie-Erkennung, Rollback | Vollautomatisch mit Alert |

### Screenshot-Beschreibung: GitHub Copilot im PR-Review

> **Was Sie in einem GitHub-Repository mit Copilot sehen:**
>
> Nach einem PR-Push erscheint automatisch ein Kommentar von "github-actions[bot]" oder
> direkt von Copilot. Dieser enthält:
> - Eine Zusammenfassung der Änderungen (2-3 Sätze)
> - Identifizierte potenzielle Issues (z.B. "Diese Funktion hat keine Fehlerbehandlung für den Fall, dass user_id None ist")
> - Konkrete Verbesserungsvorschläge als Code-Snippets
> - Security-Hinweise falls vorhanden
>
> Der Entwickler kann direkt im PR-Kommentar mit "Fix this" antworten und Copilot
> erstellt automatisch einen neuen Commit mit der Korrektur.

### Prompt-Vorlage: Pipeline-Fehler analysieren

```markdown
## Pipeline-Fehler-Analyse

Ich habe folgenden CI/CD-Fehler in unserer GitHub Actions Pipeline:

PIPELINE-KONFIGURATION (.github/workflows/ci.yml):
[Hier den relevanten Workflow-Abschnitt einfügen]

FEHLERMELDUNG (vollständig):
[Hier den kompletten Fehler-Output einfügen]

KONTEXT:
- Was wurde geändert: [kurze Beschreibung des letzten Commits]
- Letzte erfolgreiche Pipeline: [vor X Tagen/Commits]
- Umgebung: [z.B. Ubuntu 22.04, Python 3.11, Node 20]

Bitte:
1. Identifiziere die Root-Cause (nicht nur das Symptom)
2. Erkläre, warum dieser Fehler jetzt auftritt (was hat sich geändert?)
3. Gib 2-3 Lösungsoptionen mit Vor-/Nachteilen
4. Zeige den konkreten Fix (fertiger Code/Konfiguration)
5. Erkläre, wie wir ähnliche Fehler in Zukunft verhindern
```

---

## 3.4 Szenario C: Code-Modernisierung mit KI-Agenten

### Realwelt-Aufgabe: Python 2 → Python 3 Migration

**Typische Ausgangssituation:**
- 50.000 Zeilen Legacy-Code in Python 2.7
- Keine vollständige Dokumentation
- Tests: 20% Coverage
- Letzter Python-2-Support: 2020 abgelaufen
- Sicherheits-Patches nicht mehr verfügbar

**Manueller Aufwand:** 3-6 Monate für ein mittelgroßes Team.

**Mit KI-Agenten:** 2-4 Wochen, davon 80% Review statt Schreiben.

**Was der Agent übernimmt:**
```
Phase 1 – Analyse (Agent vollautomatisch):
  - Alle print-Statements → print() Funktionsaufrufe
  - unicode/str-Typen → str/bytes-Typen  
  - Division: 5/2=2 (Python 2) → 5/2=2.5 (Python 3) → Identifikation
  - Deprecated Libraries → Moderne Äquivalente

Phase 2 – Transformation (Agent, mit Review):
  - Code transformieren, Test-Suite anlegen
  - Edge-Cases markieren für menschlichen Review
  - Changelog generieren

Phase 3 – Validation (Agent vollautomatisch):
  - Test-Suite ausführen
  - Coverage-Report
  - Regressions-Bericht
```

### Prompt-Vorlage: Legacy-Code-Analyse

```markdown
## Legacy-Code-Modernisierung – Analyse-Phase

Analysiere das folgende Python 2-Modul und erstelle einen vollständigen
Migrationsplan nach Python 3.11.

CODE:
[Code hier einfügen oder Datei hochladen]

Liefere:

1. KOMPATIBILITÄTS-ANALYSE
   - Liste aller Python-2-spezifischen Konstrukte
   - Für jeden Punkt: Python-3-Äquivalent + Risiko (niedrig/mittel/hoch)

2. AUTOMATISCH MIGRIERBARES (>90% sicher)
   - Zeige den transformierten Code direkt
   - Erläutere jede Änderung

3. MANUELLER REVIEW ERFORDERLICH
   - Welche Stellen sind mehrdeutig oder riskant?
   - Warum brauchen sie menschliche Entscheidung?

4. TEST-STRATEGIE
   - Welche Testfälle brauchen wir, um die Migration zu verifizieren?
   - Schreibe die kritischsten 5 Unit-Tests direkt

5. RISIKOBEWERTUNG
   - Was kann bei der Migration schiefgehen?
   - Rollback-Strategie
```

---

## 3.5 Tool-Vergleich: KI-Coding-Assistenten im Detail

### Überblick

| Tool | Typ | Autonomiegrad | Sprachen | Preis/Monat | Einsatz |
|---|---|---|---|---|---|
| **GitHub Copilot** | IDE-Plugin + Chat | Mittel | Alle gängigen | 10$ (Ind.) / 19$ (Bus.) | Tägliche Entwicklung |
| **Cursor** | KI-nativer Editor | Hoch | Alle | 20$ (Pro) | Große Refactorings |
| **Claude Code** | Terminal-Agent | Sehr hoch | Alle | Im Claude-Abo | Komplexe Aufgaben |
| **Devin** | Autonomer Agent | Sehr hoch | Alle | 500$ | Enterprise, komplexe Projekte |
| **Aider** | CLI-Agent | Hoch | Alle | Kostenlos (eigener API-Key) | Open-Source-Fans |
| **Codeium** | IDE-Plugin | Niedrig | Alle | Kostenlos (Basic) | Budget-Alternative |
| **Tabnine** | IDE-Plugin | Niedrig | Alle | 12$ | Enterprise-Datenschutz |

### Detailvergleich: Die Top 4

#### GitHub Copilot
**Stärken:**
- Nahtlose GitHub-Integration (PRs, Issues, Actions)
- Copilot Workspace: Ganze Features von Issue bis PR-Merge
- Sehr breite IDE-Unterstützung (VS Code, JetBrains, Neovim, ...)
- Copilot Chat direkt im Editor für schnelle Fragen

**Schwächen:**
- Kein echter Agent-Loop (kein autonomes Fehler-Korrigieren)
- Kontextfenster begrenzt (versteht nicht die gesamte Codebasis)
- Microsoft/GitHub-Lock-in

**Ideal für:** Täglich nutzender Entwickler der bereits GitHub nutzt

---

#### Cursor
**Stärken:**
- Versteht die gesamte Codebasis (Codebase-Index)
- Composer-Modus: mehrere Dateien gleichzeitig bearbeiten
- Agent-Modus: Führt Befehle aus, korrigiert Fehler autonom
- Tab-Completion die ganze Code-Blöcke vorhersagt

**Schwächen:**
- Eigener Editor = Wechselaufwand von VS Code
- Kostenlos-Plan sehr limitiert
- Datenschutz: Code wird an Cursor-Server gesendet (Enterprise-Plan für On-Premise)

**Ideal für:** Entwickler die einen KI-nativen Workflow wollen

---

#### Claude Code
**Stärken:**
- Versteht komplexe, mehrstufige Aufgaben ohne wiederholte Anweisungen
- Liest und modifiziert Dateien, führt Shell-Kommandos aus
- Fragt nach bei unklaren oder riskanten Aktionen
- Sehr starkes Reasoning: erklärt warum, nicht nur was

**Schwächen:**
- Terminal-only (kein GUI)
- Kein persistentes Gedächtnis zwischen Sessions
- Erfordert Verständnis der Ausgabe (kein "Autopilot")

**Ideal für:** Komplexe Analysen, Debugging tiefer Bugs, Architektur-Reviews

---

#### Aider (Open Source)
**Stärken:**
- 100% kostenlos (eigener API-Key von OpenAI, Anthropic, etc.)
- Git-native: Alle Änderungen als Commits
- Unterstützt jedes LLM (auch lokale Modelle via Ollama)
- Multi-File-Editing, versteht Repository-Struktur

**Schwächen:**
- CLI-only, steile Lernkurve
- Qualität abhängig vom gewählten Modell
- Kein kommerzieller Support

**Ideal für:** Technisch versierte Entwickler die Kontrolle und Kosteneffizienz priorisieren

---

## 3.6 Sicherheit in der KI-gestützten Entwicklung

### Das "Sleeper Agent" Problem

KI-generierter Code kann unbeabsichtigte Sicherheitslücken einführen:

```python
# KI generiert diesen Code (sieht harmlos aus):
def get_user(user_id: str):
    query = f"SELECT * FROM users WHERE id = {user_id}"
    return db.execute(query)

# Problem: SQL-Injection möglich!
# Korrekt (mit Parameter-Binding):
def get_user(user_id: str):
    query = "SELECT * FROM users WHERE id = :user_id"
    return db.execute(query, {"user_id": user_id})
```

### Prompt-Vorlage: Sicherheits-Review

```markdown
## Security-Code-Review

Führe ein vollständiges Security-Review des folgenden Codes durch.

CODE:
[Code hier]

Prüfe auf (mindestens, nicht abschließend):
1. Injection-Angriffe (SQL, LDAP, XPath, OS-Command)
2. Authentifizierungs-/Autorisierungs-Fehler
3. Sensitive Daten in Logs oder Fehlermeldungen
4. Unsichere Deserialisierung
5. Unsichere Kryptographie (schwache Algorithmen, hardcodierte Keys)
6. Race Conditions / Time-of-check-time-of-use
7. Pfad-Traversal
8. Fehlende Input-Validierung

Für jeden Fund:
- Zeile(n) im Code
- Schwere (kritisch/hoch/mittel/niedrig)
- Angriffsszenario (wie würde ein Angreifer das ausnutzen?)
- Korrekter Code als Fix

Format: OWASP-konformer Bericht, markdown-ready für Confluence
```

---

## Zusammenfassung

| Aspekt | Stand heute | Mit KI-Agenten |
|---|---|---|
| Feature-Entwicklung | 1-5 Tage | 2-8 Stunden |
| Bug-Diagnose | 30 Min - 4h | 5-20 Minuten |
| Code-Review | 1-4h manuell | Sofort + automatisch |
| Dokumentation | Oft vergessen | Immer automatisch |
| Legacy-Migration | Monate | Wochen |
| Security-Review | Quartalsweise | Bei jedem Commit |

> **Die ehrliche Einschätzung:** KI-Agenten beschleunigen Softwareentwicklung erheblich. Sie ersetzen keine erfahrenen Entwickler – aber sie verschieben deren Aufgabe von "Code schreiben" zu "Code dirigieren, prüfen und verantworten".

---

*→ Weiter mit Kapitel 04: Workshop-Übungen*
