## TL;DR

- **JupyterLab ist die richtige Heimat** für alle vier Übungsformate. Die robusteste Toolchain für M2 (lokal via uv, offline, JupyterLab 4.x, ipywidgets 8.x) ist: **`anywidget` + SortableJS** (oder die fertige `wigglystuff.SortableList`) für Parsons, **reine ipywidgets-Tabellen + `Output`-Widget** für Tracing, **Markdown-Worked-Examples + `tutormagic`-Iframe** zu Python Tutor zur Visualisierung, und **`assert`-basierte Selbstkontrolle in versteckten Test-Zellen** für Mini-Programmieraufgaben. `nbgrader` und `otter-grader` werden für M2 ausdrücklich **nicht** empfohlen – ihr Aufwand-Nutzen-Verhältnis passt nicht zu einem Kurs ohne zentrale Bewertung.
- **Obsidian bleibt klar Sekundärrolle**: Es eignet sich für Worked Examples, statische Tracing-Tabellen und Markdown-basierte Mini-Aufgaben (mit `Execute Code`-Plugin als optionalem Live-Runner), ist aber für interaktive Parsons-Puzzles und stateful Widgets nicht geeignet. Die Kopplung Obsidian↔JupyterLab läuft pragmatisch über `JupyMD` oder schlicht über parallele `.md`/`.ipynb`-Dateien.
- **Ein zentraler didaktischer Trade-off** ist konkret lösbar: Tracing bekommt **bewusst KEINE Auto-Validierung** – stattdessen ein per `Button` enthüllbares „Lösung anzeigen"-Panel, das erst nach manueller Eingabe aller Zellen freigeschaltet wird (Reibung bleibt erhalten). Mini-Programmieraufgaben bekommen `assert`-Tests in einer separaten Test-Zelle (Selbstkontrolle, kein Grading).

---

## Key Findings

| Befund | Konsequenz für M2 |
|---|---|
| Es existiert **kein gepflegtes „jupyter-parsons"-PyPI-Paket**. js-parsons ist seit ca. 2022 effektiv inaktiv (96 GitHub-Stars, letztes ungelöstes Issue #36 vom 8. Juli 2022 ohne Maintainer-Antwort, jQuery 1.7-basiert). | Eigenbau auf `anywidget` + SortableJS oder Nutzung von `wigglystuff.SortableList` ist **die einzige produktionstaugliche Route** für Parsons in JupyterLab 4. |
| `IPython.display.HTML/Javascript` mit `<script>`-Tags wird in JupyterLab 4 vom Renderer-Sanitizing blockiert (Issue jupyterlab/jupyterlab#3118), funktioniert nur in „trusted" Notebooks und überlebt Reload schlecht. | js-parsons-Direkteinbettung **vermeiden**; stattdessen `anywidget` (saubere ESM-Pipeline, JupyterLab 4-kompatibel). |
| `ipywidgets` 8.x hat einen praxiserprobten **Widget-State-Save-Mechanismus** (`Save Widget State Automatically`), aber Persistenz ist fragil bei verschachtelten Widgets und nach Kernel-Restart bricht die Verbindung (rote Kette). | TN müssen Zellen ggf. neu ausführen; Tracing-Eingaben **nicht** als persistenten Zustand voraussetzen. |
| `nbgrader 0.9.5` ist auf JupyterLab 4.2+ explizit kompatibel (Backport-PR #1912 vom Nov 2024), hat aber **deutlichen Setup-Overhead** (Course-Directory, source/release/submitted-Workflow) und ist auf summative Bewertung ausgelegt. | Für M2 (formative Selbstlernphase, kein Notentransfer) **Overkill**; einfache `assert`-Patterns reichen. |
| `otter-grader` (UC Berkeley) ist leichtgewichtiger als nbgrader, aber primär für Gradescope/Docker-Workflows ausgelegt. | Wegen Docker-Abhängigkeit und Cloud-LMS-Bias **nicht** für lokal-only-Kurs ohne KI/Cloud. |
| `JupyterQuiz` (jmshea) ist offline-tauglich; laut README-Zitat des Autors: „A very hacky solution for Jupyter Lab has now been moved to the main branch starting with 2.8.0. This loads MathJax 3 on top of the JupyterLab MathJax version. Although this is not the ideal solution, the upstream problem has not been fixed after many months." | Brauchbar für Single/Multiple-Choice-Quizzes als Ergänzung zu Tracing-Aufgaben, **nicht** als primäres Tracing-Tool – LaTeX-Rendering bleibt fragil. |
| Python Tutor lässt sich offline über `IPython.display.IFrame` oder via `tutormagic`-Cell-Magic einbetten; läuft aber gegen `pythontutor.com` (Online-Anteil). | **Nur als Demo-Werkzeug** für Worked Examples vorsehen; Tracing-Aufgaben sollen ausdrücklich ohne Run-and-See passieren. |
| Obsidian-Plugin `Execute Code` (twibiral) und `JupyMD` (d-eniz) bieten Python-Codeausführung in Notes; Drag-and-Drop-Reordering von Listenelementen ist in Obsidian nicht nativ. | Obsidian = Lese-/Worked-Example-Schicht, **nicht** Übungs-Engine. |
| `wigglystuff` (Vincent D. Warmerdam / koaning) liefert eine fertige `SortableList`-Komponente (anywidget). Stand Mai 2026: **243 GitHub-Stars, 20 Forks, v0.3.5 vom 23. April 2026** (PyPI: 0.3.1 vom 25. März 2026), MIT-Lizenz, Python ≥ 3.10, kompatibel mit JupyterLab 4 + Colab + marimo + VS Code. | **Empfohlene Basis** für Parsons-Puzzles in M2. |

---

## Details

### A) JupyterLab/Notebook – Hauptfokus

#### 1. Tracing-Aufgaben

**Didaktische Anforderung:** TN protokolliert Werte pro Zeile in einer Tabelle (Spalten: Zeile, Variablen, Bedingung wahr?, Ausgabe). Bewusst **keine** Sofort-Validierung – „Run-and-See" würde das Lernziel „notional machine" untergraben.

**Empfohlene Primär-Lösung:** Reine `ipywidgets`-Tabelle aus `Text`-Feldern in einem `GridBox`. Lösung wird per `Button` und `Output`-Widget enthüllt, **nachdem** der TN seine Eingaben gemacht hat. Code-Skelett:

```python
import ipywidgets as widgets
from IPython.display import display

CODE = """\
x = 5
y = x + 3
print(y)
x = x * 2
print(x)
"""

HEADERS = ["Zeile", "Code", "x", "y", "Ausgabe"]
ROWS = [
    ("1", "x = 5",      "", "", ""),
    ("2", "y = x + 3",  "", "", ""),
    ("3", "print(y)",   "", "", ""),
    ("4", "x = x * 2",  "", "", ""),
    ("5", "print(x)",   "", "", ""),
]
SOLUTION = [
    ("1", "x = 5",     "5",  "-",  "-"),
    ("2", "y = x + 3", "5",  "8",  "-"),
    ("3", "print(y)",  "5",  "8",  "8"),
    ("4", "x = x * 2", "10", "8",  "-"),
    ("5", "print(x)",  "10", "8",  "10"),
]

def build_table(rows, editable=True):
    cells = [widgets.HTML(f"<b>{h}</b>") for h in HEADERS]
    inputs = []
    for r in rows:
        for i, val in enumerate(r):
            if i < 2 or not editable:
                cells.append(widgets.HTML(val))
            else:
                t = widgets.Text(value=val, layout=widgets.Layout(width="80px"))
                cells.append(t); inputs.append(t)
    grid = widgets.GridBox(cells, layout=widgets.Layout(
        grid_template_columns="60px 180px 80px 80px 100px"))
    return grid, inputs

display(widgets.HTML(f"<pre>{CODE}</pre>"))
table, _ = build_table(ROWS, editable=True)
display(table)

reveal_btn = widgets.Button(description="Lösung anzeigen", icon="eye")
out = widgets.Output()
def on_reveal(_):
    with out:
        out.clear_output()
        sol_table, _ = build_table(SOLUTION, editable=False)
        display(widgets.HTML("<b>Musterlösung:</b>"), sol_table)
reveal_btn.on_click(on_reveal)
display(reveal_btn, out)
```

**Aufwand pro Tracing-Aufgabe:** ca. 10–15 Min (Code, Lösung, Zeilen-Mapping). Bei 5 Aufgaben (A1–E5) → ~1 Stunde.

**Sekundär/Fallback:** Statische Markdown-Tabelle in einer Markdown-Zelle, die TN per Doppelklick editieren. Lösung in einer auskommentierten/eingeklappten Folge-Zelle. Null Tooling, aber UX-schlechter.

**Optional Python Tutor:** Für **eine** Demo pro Block ein `IPython.display.IFrame` auf `pythontutor.com/iframe-embed.html#code=...&py=3` einbetten; offline kann man Python Tutors v3 lokal ausliefern (geringer Wartungsaufwand, in M2 wahrscheinlich nicht lohnend).

**Stolpersteine:**
- Widget-State persistiert nur, wenn TN explizit `Save Widget State Automatically` aktiviert hat – sicherheitshalber im Kursleitfaden erwähnen.
- Nach `Restart Kernel` werden alle Eingaben verworfen → entspricht didaktisch sogar dem „Reibungs"-Ziel.

#### 2. Parsons-Puzzles

**Empfohlene Primär-Lösung: `wigglystuff.SortableList` (anywidget-basiert).** Aktive Maintenance durch Vincent D. Warmerdam, MIT-Lizenz, Python ≥ 3.10, kompatibel mit JupyterLab 4 + ipywidgets 8 + VS Code + Colab.

```python
from wigglystuff import SortableList   # pip install wigglystuff==0.3.5
import ipywidgets as widgets
from IPython.display import display
import random

DISTRAKTOREN = [
    "if zahl >= 0:",        # falsch: sollte > 0 sein
    "print('negativ')",     # in falschem Zweig
]
LINES = [
    "zahl = int(input('Zahl: '))",
    "if zahl > 0:",
    "    print('positiv')",
    "elif zahl == 0:",
    "    print('Null')",
    "else:",
    "    print('negativ')",
]
SOLUTION = LINES.copy()

mixed = LINES + DISTRAKTOREN
random.shuffle(mixed)

sortable = SortableList(items=mixed)
check_btn = widgets.Button(description="Lösung prüfen", icon="check")
out = widgets.Output()

def on_check(_):
    with out:
        out.clear_output()
        chosen = sortable.items
        if chosen == SOLUTION:
            print("✅ Korrekt!")
        else:
            print("❌ Noch nicht ganz. Hinweis:")
            for i, (a, b) in enumerate(zip(chosen, SOLUTION), 1):
                if a != b:
                    print(f"  Zeile {i}: erwartet '{b}', dort '{a}'")
                    break
check_btn.on_click(on_check)
display(sortable, check_btn, out)
```

**Sekundär-Lösung 1 (kein JS-Drag/Drop):** `ipywidgets.TagsInput` (ipywidgets 8.x) erlaubt natives Drag-and-Drop einer Tag-Liste. Limitierungen: kein Indentation, einzeilig, Distraktoren als zusätzliche Tags.

**Sekundär-Lösung 2 (Bordmittel):** `VBox` aus `HBox(Label, Up-Button, Down-Button)` pro Zeile + ein „Aus dem Pool entfernen"-Button. Funktioniert garantiert in jeder Jupyter-Umgebung, UX schlechter, aber **keine externen Abhängigkeiten**.

**Bewusst NICHT empfohlen:**
- **js-parsons direkt einbetten:** Repo seit 2022 effektiv unmaintained (96 Stars, jQuery-basiert), von JupyterLab-Sandbox blockiert.
- **Runestone `micro-parsons-element`:** an Sphinx-Build gekoppelt, nur über IFrame nutzbar, Overhead zu hoch.
- **Codio Parsons-Puzzle-UI:** SaaS, widerspricht „lokal/offline".

**Aufwand pro Parsons-Aufgabe:** ca. 5–10 Min, wenn ein Template-Notebook existiert. Pro Aufgabe nur die Listen `LINES`, `DISTRAKTOREN`, `SOLUTION` füllen.

#### 3. Worked Examples

**Empfohlene Primär-Lösung:** Markdown-Zelle mit Code-Block + nachfolgende Markdown-Tabelle „Zeile → Erklärung". Optional eine ausführbare Code-Zelle darunter, damit der TN den Beispielcode laufen lassen **kann**, aber nicht muss.

```markdown
## Worked Example: Temperaturkonvertierung Celsius → Fahrenheit

​```python
celsius = float(input("Temperatur in °C: "))
fahrenheit = celsius * 9/5 + 32
print(f"{celsius}°C = {fahrenheit}°F")
​```

| Zeile | Was passiert | Warum |
|------|--------------|-------|
| 1 | Lese String von der Konsole, wandle in Float um | `input()` liefert immer `str`; `float()` konvertiert |
| 2 | Wende die Formel an | Operator-Vorrang: `*` und `/` vor `+` |
| 3 | Formatierte Ausgabe mit f-String | f-Strings ab Python 3.6, lesbarer als `format()` |
```

**Optional: Python Tutor-Embed** für komplexere Beispiele (z. B. Funktions-Stack), via `tutormagic`-Cell-Magic:

```python
%load_ext tutormagic
```
```python
%%tutor --lang python3 --height 400
def add(a, b):
    return a + b

result = add(3, 5)
print(result)
```

**Aufwand pro Worked Example:** 15–25 Min Erstklassig-Erklärung pro Zeile. Bei ~5 Worked Examples in M2 → 1.5 h.

#### 4. Mini-Programmieraufgaben (MP-A1 bis MP-E1)

**Empfohlene Primär-Lösung: `assert`-Pattern in separater Test-Zelle.** Klare Trennung zwischen Aufgaben-Zelle (TN schreibt Code) und Test-Zelle (TN führt aus, sieht `AssertionError` oder `print("✅ MP-A1 OK")`).

```python
# === MP-B3: Schreibe eine Funktion is_even(n), die True liefert,
#            wenn n eine gerade ganze Zahl ist, sonst False. ===
def is_even(n):
    pass  # TODO: hier Code schreiben

# --- Zelle danach: Selbstkontrolle (NICHT bearbeiten) ---
assert is_even(2) is True,  "is_even(2) soll True sein"
assert is_even(3) is False, "is_even(3) soll False sein"
assert is_even(0) is True,  "is_even(0) soll True sein (0 ist gerade)"
assert is_even(-4) is True, "is_even(-4) soll True sein"
print("✅ MP-B3 OK")
```

**Vorteile gegenüber nbgrader/otter:**
- Null Setup, keine Course-Directory.
- TN sieht **eigene Fehlermeldung** beim ersten Fehlschlag → Lerneffekt.
- Custom-Hilfstext per `, "Hinweis"` an `assert`.
- Funktioniert in jedem Notebook, JupyterLite, VS Code.

**Hidden-Tests (für etwas anspruchsvollere Aufgaben):** Tests in einer eingeklappten Zelle (`"jupyter": {"source_hidden": true}` in Cell-Metadata) oder per Konvention in einer Datei `tests/mp_b3_test.py`, die per `%run` ausgeführt wird.

**Sekundär-Lösung:** `nbgrader` 0.9.5 lokal, **nur** wenn auch summativ bewertet werden soll. Versionscombo: `jupyterlab>=4.2,<4.4` + `notebook 7.x` + `ipywidgets 8.x`. Stolperstein bei JupyterHub ≥ 4.1: formgrader-Iframe wird durch CSP blockiert (kein Issue im lokalen Setup).

**Aufwand pro Mini-Aufgabe:** 5–10 Min Aufgabentext + 3–6 `assert`-Tests. Bei 13 Aufgaben → 1.5–2 h.

#### Toolübersicht (JupyterLab) – Vergleichstabelle

| Tool | Format | Offline | JLab 4 | Aufwand DoLe | Empfehlung |
|------|--------|---------|--------|---------------|------------|
| **ipywidgets 8** (Bordmittel) | Tracing, Mini | ✅ | ✅ | niedrig | **Primär** Tracing |
| **anywidget + SortableJS** | Parsons, Custom | ✅ | ✅ | mittel (einmalig) | **Primär** Parsons |
| **wigglystuff.SortableList** | Parsons | ✅ | ✅ | sehr niedrig | **Primär** Parsons (fertige Komponente) |
| **JupyterQuiz ≥ 2.8** | MC-Quizzes | ✅ | ⚠️ (LaTeX-Hack) | niedrig | Optional als Block-Abschluss |
| **tutormagic / Python Tutor IFrame** | Worked Example, Demo | ⚠️ (online) | ✅ | trivial | Optional für Funktions-Stack |
| **nbgrader 0.9.5** | Mini (Grading) | ✅ | ✅ | hoch (Setup) | **Nur** mit Bewertungspflicht |
| **otter-grader** | Mini (Grading) | ⚠️ (Docker) | ✅ | hoch | **Nicht** für M2 |
| **js-parsons direkt** | Parsons | ✅ | ❌ (Sandbox) | hoch | **Vermeiden** |
| **RISE / Slides** | Präsentation | ✅ | ⚠️ | niedrig | Out-of-scope für Übungen |
| **assert-Pattern** | Mini | ✅ | ✅ | trivial | **Primär** Mini |

### B) Obsidian – Ergänzung

| Plugin | Zweck | Eignung für M2 |
|--------|-------|----------------|
| **Execute Code** (twibiral) | Python in Code-Blocks ausführen | Brauchbar für **Worked Examples** mit Live-Run; Pfad zum uv-managed Python angeben |
| **JupyMD** (d-eniz) | `.md`↔`.ipynb`-Sync | Bridge zwischen Obsidian-Notes und JupyterLab; sinnvoll, wenn TN in Obsidian liest und in JupyterLab arbeitet |
| **obsidian-jupyter** (tillahoffmann) | Python-Code-Blöcke ausführen | Veraltet, durch JupyMD abgelöst |
| **Dataview** | Tabellen aus Frontmatter | Kann Tracing-Tabellen-Templates befüllen, aber **keine** interaktiven Eingaben |
| **Templater** | Snippet-Templates | Sinnvoll für DoLe zur Übungs-Erstellung, irrelevant für TN |
| **Sortable / Manual Sorting** | Datei-Drag-and-Drop | Sortiert nur Dateien, **nicht** Listenelemente in Markdown – für Parsons unbrauchbar |

**Konsequenz:** Obsidian eignet sich gut für **Worked Examples** (Markdown + ggf. Execute-Code), für **statische Tracing-Aufgaben** (TN trägt in Markdown-Tabellen oder in Bullet-Listen ein) und für die **Aufgaben-Vorlage selbst** (Lehr-Material). Es ist klar **ungeeignet** für Parsons-Puzzles und stateful, validierende Mini-Aufgaben.

**Bordmittel-Grenze:** Markdown-Tabellen + Checkboxen reichen für Tracing-Selbstprotokoll und Mini-Aufgaben-Checklisten. Sobald Validierung gefordert ist → JupyterLab.

### C) Best Practices und Stolpersteine

- **Reibung vs. Komfort:** Tracing braucht Reibung (kein Auto-Check). Lösung: „Lösung anzeigen"-Button als **letzte Aktion**, kein Live-Vergleich. Mini-Aufgaben dürfen Sofort-Feedback haben (`assert` schlägt fehl), weil dort der TN selbst Code schreibt – Feedback fördert Korrekturzyklen, ohne das Denken zu untergraben.
- **State-Persistenz von ipywidgets** ist im Lehrkontext fragil. Empfehlung: TN sollen Eingaben in eine begleitende `.md`-Notiz übertragen (z. B. in Obsidian) oder via `Save Widget State Automatically` einmal pro Sitzung speichern. **Keine** Aufgabe so designen, dass sie über Kernel-Restarts hinweg den State bewahren muss.
- **JupyterLab 4 vs. Notebook 7:** Beide unterstützen ipywidgets 8 nativ. Notebook 7 ist auf Jupyter-Lab-Komponenten umgestellt; viele alte Classic-Notebook-Tricks (z. B. Cell-Magic für JS-Injection) funktionieren nicht mehr.
- **`anywidget` als strategische Wahl:** Einmal eingerichtet, kann die DoLe damit **alle** zukünftigen Sonder-Widgets bauen (Code-Highlight-Quizze, Variable-Watcher etc.). 20 Zeilen Python + 10 Zeilen ESM-JS.
- **CS-Education-Konsens 2024–2025:** Parsons-Puzzles mit Distraktoren erhöhen Lerneffekt. Die einschlägige Studie zur LLM-Resilienz ist Hou, Wu, Wang & Ericson, „CodeTailor: LLM-Powered Personalized Parsons Puzzles for Engaging Support While Learning Programming" (ACM L@S '24, Atlanta, S. 51–62, doi:10.1145/3657604.3662032), mit Follow-up auf SIGCSE TS 2025 in Pittsburgh. Das deckt sich exakt mit der M2-These „ohne KI mentales Modell aufbauen". Distraktoren-Wirkung ist zudem in Kiesler et al., ICER 2024, „Distractors Make You Pay Attention" empirisch belegt.
- **Voilà** wird **nicht** empfohlen: erfordert Server-Komponente, widerspricht „lokal via uv".

### D) Konkrete Empfehlungen pro Übungsformat (kompakt)

| Format | Primär (JupyterLab) | Sekundär | Obsidian-Variante | DoLe-Aufwand pro Übung |
|--------|---------------------|----------|--------------------|------------------------|
| **Tracing** | ipywidgets `GridBox` mit `Text`-Feldern + `Output`-Reveal-Button | Markdown-Tabelle mit auskommentierter Lösung | Markdown-Tabelle ohne Validierung | 10–15 Min |
| **Parsons** | `wigglystuff.SortableList` + Distraktoren-Liste + `assert`-basierter Check | `ipywidgets.TagsInput` oder Up/Down-Buttons | – (nicht praktikabel) | 5–10 Min (mit Template) |
| **Worked Example** | Markdown + Code-Zelle + Tabelle „Zeile → Erklärung", optional `tutormagic` | Reines Markdown ohne Tabelle | Markdown-Note + `Execute Code`-Plugin | 15–25 Min |
| **Mini-Programmierung** | Aufgaben-Zelle (TODO) + Test-Zelle mit `assert ..., "Hinweis"` | nbgrader 0.9.5 (nur bei Grading-Bedarf) | Markdown-Aufgabe → in Jupyter lösen | 5–10 Min |

---

## Recommendations

1. **Sofort (Iteration M2.1):**
   - **Template-Notebook bauen** (`templates/uebung_typ_X.ipynb`) für jeden der vier Übungstypen, mit Platzhaltern für Code, Distraktoren, Lösung. Einmalaufwand ~4 h.
   - **`uv add`**: `ipywidgets>=8.1`, `anywidget>=0.9`, `wigglystuff==0.3.5` (per `uv pip install wigglystuff==0.3.5` direkt aus GitHub-Release, da PyPI noch auf 0.3.1 steht), optional `jupyterquiz>=2.8`, `tutormagic`. Keine `nbgrader` und kein `otter-grader` in der M2-Standardumgebung.
   - **Tracing-Notebook** als Erstes umsetzen (höchste didaktische Priorität laut M2-Feinplanung), mit „Lösung anzeigen"-Pattern ohne Live-Vergleich.

2. **Mittelfristig (M2.2):**
   - **Eigene anywidget-`ParsonsPuzzle`-Klasse** als dünner Wrapper um SortableJS bauen (zentralisiert Distraktoren-Logik, Indentation-Check, Hint-System). ~1 Tag Entwicklung, danach Aufwand pro Aufgabe < 5 Min.
   - **Hidden-Test-Konvention** definieren (z. B. Tests in `tests/mp_*.py`, ausgeführt via `%run`), damit Selbstkontroll-Logik wiederverwendbar ist.

3. **Langfristig (Stretch):**
   - **JupyterLite-Variante** (PyOdide) prüfen, falls TN ohne lokale Installation arbeiten sollen – `wigglystuff` und `anywidget` sind dort bereits getestet.
   - **Obsidian-Vault als Lese-Schicht** mit `JupyMD`-Sync zu den `.ipynb`-Übungsdateien etablieren, damit TN Notizen und Übungen verschränken.

**Schwellen, die Empfehlungen ändern würden:**
- Wenn aus formativem ein **summatives Setting** wird (Bewertung mit Note an Bildungsträger) → **dann** `nbgrader 0.9.5` einführen.
- Wenn TN **reproduzierbare Auto-Grading-Reports** brauchen (z. B. für die Agentur für Arbeit) → `otter-grader` mit lokalem Run (kein Docker) prüfen.
- Wenn die DoLe ≥ 50 Übungen pflegen muss → eigene `anywidget`-Komponente lohnt sich; bei < 20 Übungen reicht `wigglystuff` von der Stange.

---

## Caveats

- **`wigglystuff`** ist Open-Source, aber von einer Einzelperson gepflegt (Vincent D. Warmerdam) – Bus-Faktor 1. Empfehlung: Version pinnen (`wigglystuff==0.3.5`) und im Repo der Kursunterlagen vendoren.
- **anywidget-Sandbox-Verhalten in zukünftigen JupyterLab-Versionen** (5.x?) ist unbekannt; aktuell stabil in 4.x.
- **Python Tutor** ist standardmäßig ein **Online-Service**. Für komplette Offline-Nutzung müsste die DoLe Python Tutors v3-Code lokal hosten – Aufwand ca. 0.5 Tag, für M2 wahrscheinlich nicht nötig.
- **`assert`-basiertes Selbsttesten** zeigt Fehler nur für die erste fehlschlagende Bedingung. Für komplexere Aufgaben (z. B. `MP-E1 Passwort-Check`) sollte die DoLe stattdessen mehrere `assert` mit aussagekräftigen Hints verteilen oder eine Mini-Test-Funktion schreiben.
- **JupyterLab `Save Widget State`** speichert State **in das `.ipynb`-File**, was für versionierte Lehrmaterialien (Git) zu Diff-Rauschen führt – im DoLe-Repo deaktivieren, in TN-Vorlagen aktiviert lassen.
- **Drag-and-Drop in `wigglystuff.SortableList`** funktioniert auf Mobil-Geräten unzuverlässig; für TN, die nur per Tablet arbeiten, Up/Down-Buttons als Fallback bereitstellen.
- Die Aufwandsschätzungen pro Übung (5–25 Min) gelten **nach** Erstellung der Templates und nach einer Einarbeitungsphase von ~1 Tag in `anywidget`/`ipywidgets`.