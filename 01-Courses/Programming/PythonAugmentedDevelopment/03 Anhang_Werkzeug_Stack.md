# Anhang: Werkzeug-Stack Obsidian + Jupyter

*Ergänzung zur Modulstruktur (Stufe 2) und zur M2-Feinplanung (Stufe 3).*
*Konkretisiert die Werkzeug-Architektur des Kurses und ersetzt die in der Modulstruktur als Default genannten Cloud-Notebooks (Colab, DataCamp DataLab).*

---

## 1. Architektur-Überblick

Drei Werkzeugschichten, lokal verankert, datensparsam:

```
┌─────────────────────────────────────────────────────────────┐
│  Obsidian        Lernjournal · Prompt-Bibliothek · Notizen  │
│  (lokal)         Wissensorganisation, Querverlinkung        │
├─────────────────────────────────────────────────────────────┤
│  Jupyter         Code-Werkstatt · Übungen · Datenarbeit     │
│  (lokal, uv)     Notebook-basiertes Lernen                  │
├─────────────────────────────────────────────────────────────┤
│  KI-Tool         Phase 1: keine                             │
│  (extern)        Phase 2: Browser-Tab parallel              │
│                  Phase 3: optional Jupyter AI / Cursor      │
└─────────────────────────────────────────────────────────────┘
```

Die untere Schicht ist die einzige, die externe Daten verlässt. Obsidian und Jupyter laufen vollständig lokal auf dem TN-Gerät. Das macht den Stack für Behördenkontexte (BFD, Agentur für Arbeit, BWSA) datenschutzrechtlich erheblich unkomplizierter als jede Cloud-Notebook-Lösung.

**Konzeptionelle Stimmigkeit zum Drei-Phasen-Modell:** Die Trennung „lokal arbeiten / extern KI fragen" ist in Phase 2 ein **didaktischer Vorteil** und kein Mangel. Jeder Wechsel ins KI-Tool ist ein bewusster Akt – das ist genau das Verhalten, das mit dem Prompt-and-Verify-Pattern eingeübt werden soll. Cloud-Notebooks mit eingebauter KI machen diese Schwelle unsichtbar und unterminieren die Verifikationsdisziplin.

---

## 2. Obsidian-Setup

### 2.1 Vault-Architektur

Im Kurs werden zwei Vaults unterschieden:

**DoLe-Master-Vault** (privat, nicht an TN ausgeliefert):
```
KursMaster/
├── 00_Konzept/              ← Stufe 1, 2, 3 dieser Konzeption
├── 01_Module/
│   ├── M01_Orientierung/
│   ├── M02_Fundierung/
│   │   ├── Block_A_Variablen.md
│   │   ├── Block_B_Bedingungen.md
│   │   ├── Tracing-Aufgaben.md
│   │   ├── Parsons-Puzzles.md
│   │   ├── MiniProgrammierung.md
│   │   └── Beobachtungsbogen.md
│   └── …
├── 02_Material/
│   ├── Worked_Examples/
│   ├── Datensätze/
│   └── Bewertungsraster/
├── 03_Diagnostik/           ← Klassen-Beobachtungen pro Kohorte
├── 04_Reflexion_DoLe/       ← Eigenes Lehrjournal
└── _Templates/              ← Templater-Vorlagen
```

**TN-Vault-Vorlage** (an alle TN als ZIP/Git-Snapshot ausgeliefert):
```
PythonKurs/
├── 00_Start_hier.md         ← Begrüßung, Vault-Erklärung
├── 01_Lernjournal/
│   ├── _Vorlage.md
│   └── (TN legt Daily Notes an)
├── 02_Module/
│   ├── M02_Fundierung/      ← inhaltliche Notizen, gefiltert auf TN-Inhalte
│   └── …
├── 03_PromptBibliothek/     ← ab M3 befüllt
├── 04_KI_Vertrag.md
└── 99_Archiv/
```

Der TN-Vault ist bewusst flacher und enthält keine DoLe-internen Materialien. Pro Modul wird ein Update ausgeliefert (entweder Git-Pull oder ZIP-Snapshot).

### 2.2 Empfohlene Plugins

| Plugin | Zweck | Ab Modul |
|---|---|---|
| **Templater** | Vorlagen für Lernjournal, Prompt-Einträge, Modul-Notizen | M1 |
| **Dataview** | Auswertung des Lernjournals in M11; Aggregation von Tags | M1 (vorbereitet), M11 (genutzt) |
| **Tasks** oder **Checklists** | Mini-Aufgaben-Tracking, Modulabschluss-Selbstcheck | M2 |
| **Advanced Tables** | Tracing-Tabellen direkt in Markdown | M2 |
| **Excalidraw** | Skizzen, Datenfluss-Diagramme, Funktions-Stacks | M5, M6 |
| **Git** | Synchronisation mit zentralem Repo (siehe Distribution) | M1 |
| **Code-Block Customizer** | Lesbare Python-Snippets in Notizen | M2 |
| **Annotator** (optional) | PDF-Annotation für Worked Examples | M2 |

Bewusst **nicht** Pflicht im Kurs: Obsidian Sync (kostenpflichtig), Webclipper (für M8 nice-to-have, aber kein Kerntool), Dataview JS (zu fortgeschritten für Anfänger:innen).

### 2.3 Tag-System (querschnittlich)

Drei Tag-Achsen, in M1 vorgestellt:

- **Modul:** `#m02`, `#m03`, …
- **Querschnitt:** `#halluzination`, `#datenschutz`, `#metakognition`, `#prompt-and-verify`
- **Status:** `#todo`, `#offen`, `#verstanden`

Das ermöglicht in M11 eine Dataview-basierte Auswertung des eigenen Lernjournals: „Zeige alle Einträge mit `#offen` aus M5 und M6".

---

## 3. Jupyter-Setup

### 3.1 Installation

Empfehlung für TN-Setup: lokal mit `uv`. Begründung: schneller als Conda, reproduzierbar über `pyproject.toml`, plattformübergreifend (Linux, macOS, Windows), entspricht dem aktuellen Stand der Python-Tooling-Empfehlungen.

```bash
# in M1, einmalig durch jeden TN
uv venv
uv pip install jupyterlab pandas matplotlib pytest
uv run jupyter lab
```

Für TN ohne CLI-Erfahrung wird in M1 ein **One-Shot-Installationsskript** verteilt (Bash für Linux/macOS, PowerShell für Windows), das die obigen Schritte ausführt. Das nimmt aus M1 die Setup-Zeit heraus, die in früheren Kursen erfahrungsgemäß der größte Zeitfresser war.

**Alternative für hoch heterogene Hardware:** JupyterLite im Browser (vollständig clientseitig, kein Server, kein Setup, aber begrenzter Bibliotheksumfang). Für M2–M5 ausreichend, ab M9 wird ein „echtes" Jupyter benötigt.

### 3.2 Notebook-Konventionen

Vier Hygieneregeln, in M1 eingeführt und durchgängig durchgehalten:

1. **„Restart Kernel & Run All" vor jedem Speichern.** Ein Notebook, das nur in einer bestimmten Zellen-Reihenfolge läuft, ist eine versteckte Falle. Die Regel macht das State-Problem sichtbar.
2. **Imports oben.** Eine Zelle ganz am Anfang mit allen Imports. Kein verstreutes Importieren.
3. **Markdown-Zellen für Aufgabenstellungen.** Keine Erklärung in Code-Kommentaren, wenn sie auch in einer Markdown-Zelle stehen kann. Das lehrt die Trennung von Erläuterung und Code.
4. **Notebook-Naming:** `M02_BlockA_Variablen.ipynb`. Strikte Modul-/Block-Logik, damit der TN-Vault auch nach Wochen navigierbar bleibt.

### 3.3 Notebook-Vorlagen pro Modul

Für jedes Modul eine **Übungs-Vorlage** mit:

- Kopfzelle (Markdown): Modul, Block, Lernziele
- Imports-Zelle
- Aufgabenblock 1: Markdown-Beschreibung + leere Code-Zelle
- Aufgabenblock 2, 3, …
- Schlussblock (Markdown): Reflexionsfragen

Die DoLe pflegt diese Vorlagen im Master-Vault; ausgeliefert wird pro Modul.

### 3.4 Tests in Jupyter

In M7 wird das Notebook für Tests verlassen. Empfehlung: Aufgaben von M7 an liegen als `.py`-Modul plus separates Test-Notebook oder direkt als `pytest`-Datei vor. Begründung: Berufsrelevanz (in echten Projekten liegen Tests nicht im Notebook), `pytest`-Integration ist außerhalb des Notebooks unkomplizierter, der Übergang ist didaktisch wertvoll („wann verlasse ich das Notebook?").

Für sehr einfache Tests in Phase 2 reicht `assert` direkt in einer Code-Zelle.

---

## 4. KI-Andockung pro Phase

### Phase 1 (M2) – KI-frei

Keine KI-Tools eingebunden. TN arbeiten ausschließlich in Jupyter und Obsidian. Die KI-Tools sind aus M1 zwar eingerichtet, werden aber bewusst nicht genutzt. Das ist die einzige Phase, in der diese Disziplin gilt.

### Phase 2 (M3–M9) – Browser-Tab-Pattern

**Standard-Workflow:** Notebook in JupyterLab, Notizen in Obsidian, KI-Tool im separaten Browser-Tab. Copy-Paste manuell. Jeder Prompt ist sichtbarer Akt.

Empfohlene Tools für den Browser-Tab (in Reihenfolge der DSGVO-Eignung für Behördenkontexte):

1. **Eigenes Enterprise-Konto** (OpenAI Enterprise/Team, Microsoft Copilot Enterprise) mit AVV, EU-Residency, deaktiviertem Modelltraining – falls Träger dies bereitstellt
2. **Didaktisches Frontend** (fobizz, schulKI) mit Pseudonym-Zugang – datenschutzfreundlich, aber Funktionsumfang eingeschränkt
3. **Lokales LLM via Ollama** (z. B. `qwen2.5-coder:14b`, `deepseek-coder-v2`) – bei TN mit ausreichender Hardware; bei der DoLe selbst mit RTX 4070 Ti Super gut umsetzbar, für TN-Geräte oft nicht praktikabel
4. **Europäische Anbieter** (Mistral Le Chat Pro, Aleph Alpha) – konzeptionell tragfähig, in der Praxis Tool-Integration weniger reif

Die finale Auswahl ist trägerabhängig und gehört in M1.

**Prompt-Bibliothek in Obsidian.** Erfolgreiche Prompts werden im TN-Vault unter `03_PromptBibliothek/` abgelegt – als Markdown-Datei pro Prompt-Pattern, mit Tags (`#prompt-und-verify`, `#erklaeren`, `#testfaelle-generieren`). In M11 steht damit eine persönliche Prompt-Bibliothek als Kursertrag bereit.

### Phase 3 (M10–M11) – Optional engere Integration

In M10 kann optional ein agentisches Tool wie Jupyter AI (`%%ai`-Magic) oder Cursor mit Jupyter-Plugin gezeigt werden, **um die Karpathy-2026-Zielfigur erlebbar zu machen** (Modulstruktur M10). Das ist explizit Ausblick, nicht Default. Ein TN, der in M2–M9 die Verifikationsdisziplin verinnerlicht hat, kann ab M10 mit engerer Kopplung umgehen, ohne in „Vibe Coding" zu kippen.

---

## 5. Modulweise Konkretisierung

| Modul | Obsidian-Aktivität | Jupyter-Aktivität | KI-Andockung |
|---|---|---|---|
| M1 | Vault-Setup, KI-Vertrag, Lernjournal anlegen | Installation, „Hello World" | Tools eingerichtet, nicht genutzt |
| M2 | Lernjournal-Einträge pro Block | Übungs-Notebooks für Block A–E | **keine** |
| M3 | Erste Prompt-Bibliothek-Einträge | KI-Erklärungen ins Notebook übernehmen, in Markdown-Zellen reflektieren | Browser-Tab parallel |
| M4 | Prompt-Patterns sammeln und taggen | Datenstruktur-Übungen mit KI-Spezifikationen | Browser-Tab |
| M5 | Annotationen zu KI-Code | „Lese-Notebooks" mit fertigen Snippets, TN annotiert | Browser-Tab |
| M6 | Spec-Templates in Obsidian, dann ins Notebook | Notebook-zu-Modul-Übergang erstmals demonstriert | Browser-Tab |
| M7 | Test-Patterns in Prompt-Bibliothek | Übergang zu `.py`-Modulen + `pytest`; Notebook nur noch zur Exploration | Browser-Tab, gezielt für Test-Generierung |
| M8 | Halluzinationen-Sammlung als Vault-Notiz | Prüfungs-Notebooks mit kuratierten KI-Outputs | Browser-Tab als Untersuchungsobjekt |
| M9 | Mini-Projekt-Dokumentation | Datenarbeit-Notebooks (CSV, JSON, Visualisierung) | Browser-Tab, Spec-driven |
| M10 | Projektdoku, Prompt-Log, Reflexionen | Projekt-Repository mit Notebooks + Modulen + Tests | Browser-Tab Standard, optional Jupyter AI/Cursor als Ausblick |
| M11 | Dataview-Auswertung des Lernjournals, Kompetenzkarte | Aufräumen, Auslieferung als HTML/PDF | wenig genutzt |

---

## 6. Distribution & Synchronisation

### 6.1 Distribution der Materialien an TN

Drei Optionen, in Reihenfolge der Empfehlung:

**Option A: Git-Repository** (empfohlen für Online-/Hybrid-Kurse).
DoLe pflegt ein zentrales Repo (GitLab, GitHub, oder selbstgehostet auf Synology mit Gitea). TN klonen einmal in M1, ziehen pro Modul. Vorteile: Versionsverlauf, Konflikte explizit, Übung in Berufstool. Nachteile: Git-Lernkurve in M1, nicht alle TN haben CLI-Erfahrung.

**Option B: ZIP-Snapshots pro Modul** (empfohlen für Anfänger:innen-Kurse ohne IT-Vorerfahrung).
DoLe verteilt pro Modul ein ZIP über das Trägerportal (BFD-Lernplattform, BWSA-Portal o. ä.). TN entpacken in den Vault. Vorteile: niedrigschwellig. Nachteile: keine Versionierung, manuelle Mergerei wenn TN parallel arbeitet.

**Option C: NAS-basierter Download** (für DoLe-eigene Trägerkontexte).
Synology mit Cloud Station oder einfachem Web-Share. Funktioniert, hat aber DSGVO- und Bandbreitenfragen. Praktikabel als Zweitkanal, nicht als Primärlösung.

### 6.2 Sync der TN-Vaults

Die TN-Vaults bleiben **lokal**. Obsidian Sync wird nicht zur Pflicht gemacht. Wer Obsidian zwischen mehreren Geräten nutzen möchte, wählt selbst zwischen Obsidian Sync (kostenpflichtig, datenschutzfreundlich), Self-Hosted (z. B. via Syncthing) oder Git.

In M1 wird das Thema einmal angesprochen, danach ist es TN-Verantwortung.

---

## 7. DSGVO und Behördenkontext

Zusammengefasst die Stack-Position aus DSGVO-Sicht:

| Komponente | Daten verlassen Gerät? | DSGVO-Status |
|---|---|---|
| Obsidian (lokal) | nein | unproblematisch |
| Jupyter (lokal) | nein | unproblematisch |
| Git-Repo (DoLe-gehostet) | ja, nur Kursmaterial | unproblematisch (kein Personenbezug) |
| Externe KI (Enterprise mit AVV) | ja, nur Prompts | mit AVV nach Art. 28 DSGVO konform |
| Externe KI (Free-Tier) | ja | **nicht** für personenbezogene Daten zulässig |
| Lokales LLM via Ollama | nein | unproblematisch |

In M1 wird das in der Datenschutzbelehrung explizit aufgeschlüsselt. In M8 wird daraus eine TN-Kompetenz entwickelt.

**Konkrete Empfehlung für Behördenkontexte:** Stack-Variante mit Obsidian + Jupyter lokal + entweder Enterprise-KI mit AVV **oder** lokalem LLM via Ollama (auf DoLe-Hardware demonstriert, in der TN-Praxis als Option vorgestellt). Free-Tier-Tools sind im Kurs ausgeschlossen.

---

## 8. Stolpersteine und Pflegehinweise

**Setup-Heterogenität in M1.** Die größte Erfahrungsgefahr. Empfehlung: in M1 einen **Setup-Sprint** (1 UE Pufferzeit) einplanen, in dem die DoLe Bildschirme freigeben lässt und durchgeht. Das One-Shot-Installationsskript löst die meisten Fälle, aber nicht alle (Windows-Pfade mit Umlauten, Antivirus-Software, Konzern-Laptops mit gesperrtem PowerShell).

**Cell-State-out-of-order.** In M2 als Hygieneregel etabliert (Restart & Run All), erscheint in der Beobachtungsbogen-Liste als Indikator. Erfahrungsgemäß tritt das Problem ab M3 wieder auf, sobald TN längere Notebooks haben. Empfehlung: kurze Wiederholungs-Klärung am Anfang von M4.

**Obsidian-Lernkurve für TN ohne Markdown-Erfahrung.** Erfahrungsgemäß weniger schlimm als befürchtet (Markdown ist intuitiv), aber die Wiki-Verlinkung (`[[…]]`) ist neu. In M1 werden vier Konzepte erklärt: Notiz erstellen, Notiz verlinken, Tag setzen, Daily Note. Mehr nicht – Plugins kommen modulweise dazu.

**Versionsfragmentierung.** Zwischen DoLe-Master und TN-Vault verzweigt das Material – nach drei Kohorten gibt es ggf. drei TN-Vaults und einen Master, der nicht mehr ganz konsistent ist. Empfehlung: pro Kohorte einen Git-Branch im DoLe-Repo, Master-Vault wird zwischen Kohorten konsolidiert.

**Notebook-zu-Markdown-Synchronisation.** Wenn TN aus Notebooks Erkenntnisse in den Vault übertragen, entsteht Doppelarbeit. Empfehlung: `nbconvert --to markdown` als Utility zeigen (in M5 oder M6), aber kein Pflichtworkflow. Wer einen vollwertigen Notebook-zu-Vault-Workflow möchte, kann Tools wie `Jupytext` ausprobieren (DoLe-Niveau, nicht Anfänger:innen-Pflicht).

---

## 9. Aktualisierung der Modulstruktur und der M2-Feinplanung

Mit diesem Anhang ändern sich an den vorgelagerten Konzeptstufen folgende Punkte:

**In der Modulstruktur (Stufe 2):**
- M1 „Werkzeugauswahl-Kriterien": Default-Empfehlung wechselt von Cloud-Notebooks zu **Obsidian + lokales Jupyter via uv**.
- M9 und M10 bleiben Notebook-getrieben, aber mit lokalem Stack statt DataLab/Colab.

**In der M2-Feinplanung (Stufe 3):**
- Abschnitt 12 „Was die DoLe vor dem Kursstart konkret vorbereitet" erhält drei Ergänzungen:
  - One-Shot-Installationsskript für `uv` + Jupyter (Bash + PowerShell)
  - TN-Vault-Vorlage (ZIP oder Git-Repo)
  - Notebook-Vorlagen für Block A–E gemäß Konvention 3.3
- Abschnitt 6.1 „Beobachtungsindikatoren" erhält den Punkt: „TN führt Zellen außerhalb der Reihenfolge aus / klagt über Variablen, die plötzlich verschwunden sind" → deutet auf fehlende Restart-Disziplin.

Diese Änderungen sind klein und können in den nächsten Iterationen der Dokumente nachgezogen werden. Die Feinplanung von M6 setzt direkt auf dieser angepassten Architektur auf.

---

*Stand: April 2026. Dieser Anhang ist als lebendes Dokument gedacht – nach jedem Kursdurchlauf werden Plugin-Listen, Skripte und Vault-Strukturen angepasst. Die Architektur (drei Schichten, lokal, datensparsam) ist stabil und sollte über mehrere Werkzeug-Generationen hinweg tragen.*
