# Projektwissen: Python-Lehrgang im Zeitalter generativer KI

*Dieses Dokument ist die Wissensgrundlage für alle Konversationen im Projekt. Es fasst Konzept, Architektur und Form-Konventionen so zusammen, dass jede neue Konversation ohne Wiederholung der Genese produktiv arbeiten kann.*

---

## 1. Kurzkontext

**Auftraggeber:** Fritz-Rainer, freiberuflicher IT-Dozent in Deutschland. Liefert u. a. an BFD (Berufsförderungsdienst der Bundeswehr), Agentur für Arbeit, BWSA. Sprache der Materialien: Deutsch. Stilpräferenz: gründlich, gut strukturiert, mit Tabellen und Codebeispielen, Markdown-/Artefakt-Auslieferung.

**Technisches Heimumfeld:** CachyOS (Arch-basiert), `uv` als Python-Paketmanager, Nushell als Shell, RTX 4070 Ti Super (16 GB VRAM, lokales LLM-fähig), Synology NAS, Apple-Geräte parallel, Obsidian für Notizen, PyCharm für eigene Entwicklung.

**Lehrgangsziel:** Python-Lehrgang auf Einsteiger-/Grundlagenniveau, allgemein gehalten (nicht für eine einzelne Zielgruppe), der die veränderte Rolle des Programmierers durch generative KI didaktisch fundiert berücksichtigt – ausgewogen mit zwei Aspekten: KI als Lernpartner für die Teilnehmenden **und** Vorbereitung auf die professionelle Rolle „Programmierer:in als KI-Dirigent:in".

---

## 2. Konzept-Kern

### 2.1 Drei-Phasen-Modell

| Phase | Name | Anteil | KI-Nutzung |
|---|---|---|---|
| 0 | Orientierung & Setup | ~3 % | eingerichtet, nicht genutzt |
| 1 | KI-freie Fundierung | ~12 % | bewusst keine |
| 2 | KI-augmentiertes Lernen | ~64 % | Browser-Tab parallel zum Notebook |
| 3 | Programmierer:in als KI-Dirigent:in | ~21 % | voll integriert, Mensch in Verantwortung |

Die KI-freie Phase 1 ist konzeptionell zentral, weil sie das mentale Modell aufbaut, auf dem alle Verifikationsroutinen ab Phase 2 basieren. Empirische Begründung: Prather et al. (ICER 2024, „The Widening Gap"), MIT Media Lab (Kosmyna et al. 2025, „Your Brain on ChatGPT"), SWK-Impulspapier (Januar 2024).

### 2.2 Drei-Ebenen-Lernziele

| Ebene | Inhalt | Kursanteil |
|---|---|---|
| A | Python-Kernkompetenzen | 40–50 % |
| B | KI-Nutzungskompetenzen | 25–35 % |
| C | Metakognition & kritisches Urteil | 20–25 % |

Klassische Python-Kurse fokussieren ~80 % auf Ebene A. Dieses Konzept verlagert ein Drittel der Lernzeit auf B und C.

### 2.3 Sechs Leitprinzipien

1. KI-freie Fundierung vor KI-Nutzung
2. Prompt-and-Verify als Standard-Workflow
3. Code-Reading vor Code-Writing
4. Open-AI-Assessment statt Plagiatskontrolle
5. Dozent:in als Sparringspartner:in
6. Datenschutz-by-Default

### 2.4 Begriffliche Zielfigur

Nicht Karpathys „Vibe Coding" (2.2.2025: „forget that the code even exists"), sondern Karpathys revidierter Begriff „Agentic Engineering" (4.2.2026) bzw. Kent Becks „Augmented Coding" / Simon Willisons „Vibe Engineering": disziplinierte KI-Nutzung mit Tests, Reviews und menschlicher Architekturverantwortung.

---

## 3. Modulstruktur

| # | Modul | Phase | Anteil | Schwerpunkt |
|---|---|---|---|---|
| M1 | Orientierung & KI-Vertrag | 0 | 3 % | Diagnostik, Datenschutz, Kontrakt |
| M2 | Python-Fundierung ohne KI | 1 | 12 % | Live-Coding, Tracing, Parsons-Puzzles |
| M3 | KI als Lernpartner | 2 | 8 % | Erklären-lassen, Code-Tracing mit LLM |
| M4 | Datenstrukturen & Prompt-Disziplin | 2 | 10 % | Prompt Problems (Promptly-Stil) |
| M5 | Code lesen vor Code schreiben | 2 | 8 % | Reverse Engineering, Annotation |
| M6 | Funktionen, Module, Dekomposition | 2 | 12 % | Spec-driven Prompting, Pair-Programming |
| M7 | Testen als Verifikationsstrategie | 2 | 10 % | Test-First, Debugging-Challenges |
| M8 | Halluzinationen, Lizenzen, Quellen | 2 | 6 % | Faktencheck, AI-Act/DSGVO |
| M9 | Datenarbeit (CSV, JSON, Visualisierung) | 2 | 10 % | Mini-Projekte |
| M10 | Projektphase „KI-Dirigent:in" | 3 | 15 % | Spec → Prompt → Review → Test → Doku |
| M11 | Reflexion & Transfer | 3 | 6 % | Lernjournal, Kompetenzkarte |

Skalierung auf 80 UE: M2 ≈ 10 UE in 5 Blöcken à 2 UE.

### Inhaltliche Abgrenzungen (was nicht wo gehört)

- Listen, Tupel, Dictionaries, Sets → erst M4 (nicht in M2)
- Tieferer Funktionsbegriff (Default-Args, *args/**kwargs) → M6 (in M2 nur einfache Funktionen)
- Module, Imports → M6
- Datei-I/O → M6/M9
- `try`/`except` → M7
- OOP, Klassen → außerhalb des Anfänger-Curriculums
- KI-Tools → ab M3, in M2 strikt nicht

---

## 4. Werkzeug-Stack

### 4.1 Drei-Schichten-Architektur

```
Obsidian        Lernjournal · Prompt-Bibliothek · Notizen   (lokal)
Jupyter         Code-Werkstatt · Übungen · Datenarbeit       (lokal, uv)
KI-Tool         Phase 1: keine                               (extern)
                Phase 2: Browser-Tab parallel
                Phase 3: optional Jupyter AI / Cursor
```

Nur die KI-Schicht ist extern. Obsidian und Jupyter laufen vollständig lokal. Das Browser-Tab-Pattern in Phase 2 ist konzeptionell **gewollt**, weil jeder KI-Wechsel ein bewusster Akt sein soll.

### 4.2 Setup-Konvention

Python-Umgebung via `uv`:

```bash
uv venv
uv pip install jupyterlab jupytext pandas matplotlib pytest
uv run jupyter lab
```

In M1 wird ein One-Shot-Installationsskript an TN verteilt (Bash für Linux/macOS, PowerShell für Windows).

### 4.3 KI-Andockung pro Phase

- **Phase 1 (M2):** keine KI-Tools genutzt, auch wenn aus M1 eingerichtet
- **Phase 2 (M3–M9):** externe KI im separaten Browser-Tab, manuelles Copy-Paste
- **Phase 3 (M10–M11):** optional Jupyter AI (`%%ai`-Magic) oder Cursor als Ausblick

### 4.4 DSGVO-Hierarchie für KI-Tool-Auswahl (Behördenkontext)

1. Enterprise-Konto mit AVV (OpenAI Enterprise/Team, Microsoft Copilot Enterprise) – Träger-bereitgestellt
2. Didaktisches Frontend (fobizz, schulKI) mit Pseudonym-Zugang
3. Lokales LLM via Ollama (DoLe-seitig demonstrierbar mit RTX 4070 Ti Super)
4. Europäische Anbieter (Mistral Le Chat Pro, Aleph Alpha)

Free-Tier-Tools sind im Kurs ausgeschlossen.

---

## 5. Form-Konventionen für Unterlagen

### 5.1 Zwei Materialklassen

**Klasse 1 – Konzept- und Planungsdokumente** (für DoLe und für interne Reflexion):
- Reine Markdown-Dateien (`.md`)
- Kein Jupytext-Frontmatter (werden nicht ausgeführt)
- Beispiele: didaktisches Konzept, Modulstruktur, Feinplanungen, Beobachtungsbögen, Bewertungsraster

**Klasse 2 – Lehr- und Übungsmaterialien** (für TN, ausführbar):
- Jupytext-kompatibles Markdown (`.md`), gepaart mit `.ipynb`
- Mit Jupytext-Frontmatter
- Beispiele: Übungs-Notebooks pro Block, Worked Examples, Mini-Projekte
- Werden bei Bedarf zu reinem `.ipynb` konvertiert oder direkt aus dem Markdown ausgeführt

### 5.2 Jupytext-Konvention für Klasse 2

**Frontmatter** (am Dateianfang, zwischen `---`):

```markdown
---
jupyter:
  jupytext:
    formats: ipynb,md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.16.0
  kernelspec:
    display_name: Python 3 (uv)
    language: python
    name: python3
---
```

**Code-Zellen** als Standard-Markdown-Codeblöcke mit Sprachangabe `python`:

````markdown
```python
name = "Anna"
alter = 30
print(name, "ist", alter)
```
````

**Markdown-Zellen** sind alles, was nicht in einem Code-Block steht. Strukturierung über Überschriften, Listen, Tabellen.

**Konvertierung:**

```bash
# Markdown → Notebook
jupytext --to notebook M02_BlockA_Variablen.md

# Notebook → Markdown
jupytext --to markdown M02_BlockA_Variablen.ipynb

# Paired sync (beide Formate parallel halten)
jupytext --set-formats ipynb,md M02_BlockA_Variablen.ipynb
jupytext --sync M02_BlockA_Variablen.ipynb
```

### 5.3 Vollständiges Beispiel eines Übungs-Notebooks

````markdown
---
jupyter:
  jupytext:
    formats: ipynb,md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.16.0
  kernelspec:
    display_name: Python 3 (uv)
    language: python
    name: python3
---

# M02 Block A – Variablen, Datentypen, Ein-/Ausgabe

**Modul:** M2 Python-Fundierung ohne KI
**Block:** A (Variablen)
**Hinweis:** In diesem Modul wird **ohne KI-Unterstützung** gearbeitet.

## Lernziele dieses Blocks

- L1: Variablen zuweisen und deren Wert ausgeben
- L2: Primitive Datentypen unterscheiden
- L3: Mit `int()`, `float()`, `str()` zwischen Typen konvertieren
- L4: `input()`-Werte korrekt für Berechnungen verwenden

## Imports

```python
# In diesem Block werden keine externen Bibliotheken benötigt.
```

## Worked Example: Temperaturkonvertierung

```python
celsius_str = input("Temperatur in °C: ")
celsius = float(celsius_str)
fahrenheit = celsius * 9/5 + 32
print(f"{celsius} °C entsprechen {fahrenheit} °F")
```

## Aufgabe MP-A1

Frage Vor- und Nachname ab und gib eine Begrüßung aus.

```python
# Dein Code hier:

```

## Reflexion

- Was war neu?
- Was ist mir noch unklar?
````

### 5.4 Naming-Konventionen

| Materialtyp | Schema | Beispiel |
|---|---|---|
| Übungs-Notebook | `M{NN}_Block{X}_{Thema}.md` | `M02_BlockA_Variablen.md` |
| Mini-Aufgabe | `MP-{Block}{Nr}_{Kurztitel}.md` | `MP-A1_Begruessung.md` |
| Worked Example | `WE-{Block}{Nr}_{Titel}.md` | `WE-A1_Temperatur.md` |
| Tracing-Aufgabe | `TR-{Block}{Nr}_{Titel}.md` | `TR-D4_Funktionsstack.md` |
| Parsons-Puzzle | `PP-{Block}{Nr}_{Titel}.md` | `PP-C2_Summe1bis10.md` |
| Beobachtungsbogen | `BB-M{NN}_{Kohorte}.md` | `BB-M02_2026Q3.md` |
| DoLe-Konzeptnotiz | `KN-{Thema}.md` | `KN-Pacing-M2.md` |

### 5.5 Obsidian-Tag-System

Drei Tag-Achsen:

- **Modul:** `#m02`, `#m03`, …
- **Querschnitt:** `#halluzination`, `#datenschutz`, `#metakognition`, `#prompt-and-verify`
- **Status:** `#todo`, `#offen`, `#verstanden`

In M11 ermöglicht Dataview eine selbst-Auswertung des Lernjournals entlang dieser Tags.

---

## 6. Querschnittsthemen

Drei Themen ziehen sich durch alle Module:

1. **Datenethik / Datenschutz / Lizenzen** (Schwerpunkt M1, M8)
2. **Halluzinationserkennung & Verifikation** (Schwerpunkt M5, M7, M8)
3. **Metakognition** (durchgängig; Schwerpunkt M1, M11)

---

## 7. Caveats und Pflegehinweise

- **Werkzeuglandschaft volatil:** Karpathys Begriffswandel innerhalb eines Jahres (Vibe Coding 2.2.2025 → Agentic Engineering 4.2.2026) zeigt, wie schnell das Vokabular veraltet. Konzeptkern stabil, Tool-Empfehlungen alle 12–18 Monate prüfen.
- **Empirische Evidenz uneindeutig:** METR 2025 misst −19 % Produktivität für erfahrene Entwickler:innen, Peng et al. 2023 misst +55,8 % für eine isolierte Aufgabe – das Konzept folgt dem methodischen Mainstream, nicht einer einzelnen Studie.
- **Skalierungswarnung:** Bei < 40 UE Kursdauer Module zusammenfassen (M3+M4, M8 als Querschnitt verteilen). Bei > 200 UE M9 und M10 ausbauen, ggf. M12 „APIs und Web-Daten" einschieben.
- **Trägerabhängigkeit:** UE-Länge (45 oder 60 Min) ist trägerabhängig. Konzeptanteile sind in Prozent angegeben, Module in UE-Anteilen.

---

## 8. Bestehende Hauptdokumente

Folgende Dokumente liegen im Projekt-Wissensbereich (Stand: April 2026):

| Stufe | Dokument | Status |
|---|---|---|
| 1 | Didaktisches Konzept | abgeschlossen |
| 2 | Modulstruktur (M1–M11) | abgeschlossen |
| 2-Anhang | Werkzeug-Stack Obsidian + Jupyter | abgeschlossen |
| 3 | Feinplanung M2 (für 80-UE-Kurs) | abgeschlossen |
| 3 | Feinplanung M3, M4, M5, M6, M7, M8, M9, M10, M11 | offen |

Die nächste Feinplanung ist M6 (Funktionen, Module, Dekomposition), weil dort das Spec-driven Prompting eingeführt wird, auf dem alles ab M6 aufbaut.

---

## 9. Stilrichtlinien für Konversationen im Projekt

- **Sprache:** durchgehend Deutsch (Materialien und Konversation), englische Fachbegriffe wo etabliert
- **Format:** Markdown bevorzugt, Tabellen für Vergleiche, Code-Blöcke mit Sprachangabe
- **Umfang:** lieber strukturiert und vollständig als knapp und unvollständig – das gilt für Konzeptarbeit, nicht für tagesgeschäftliche Konversation
- **Fachhaltung:** kritisch, mit Quellenbewusstsein, keine Hype-Sprache
- **Bildungskontext:** deutsche Bildungsträger-Realität (BFD, AZAV, BWSA, Agentur für Arbeit) immer mitdenken; DSGVO und EU AI Act sind kein Disclaimer, sondern Rahmenbedingung
- **Zielgruppe der Materialien:** erwachsene Lernende mit heterogenem Hintergrund, oft im beruflichen Übergang
- **Werkzeugkonsistenz:** Obsidian + Jupyter + uv ist gesetzt; Abweichungen sind zu begründen
- **Karpathy-Sensibilität:** „Vibe Coding" wird als Begriff nicht affirmativ verwendet; das Konzept zielt auf Augmented Coding / Agentic Engineering

Bei neuen Aufgaben im Projekt:

1. Prüfen, ob die Aufgabe einer der drei Konzeptstufen zuzuordnen ist (Konzept – Modulstruktur – Feinplanung)
2. Bestehende Dokumente konsultieren, nicht parallel neu beginnen
3. Form-Konventionen aus Abschnitt 5 anwenden
4. Bei Werkzeugfragen Abschnitt 4 als gesetzte Architektur verwenden

---

*Stand: April 2026. Dieses Projektwissen wird nach jeder größeren Konzeptergänzung (neue Feinplanung, neue Tool-Entscheidung, Empirie-Update) aktualisiert.*
