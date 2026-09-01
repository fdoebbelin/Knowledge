Jetzt habe ich alle nötigen Infos zur API. Ich baue jetzt die zwei Hauptdateien (`README.md` mit Setup-Anleitung und `uebungen_demo.md` mit allen Beispielen) und teste sie anschließend.Fertig. Die Umgebung ist im Sandbox aufgesetzt, alle Pakete installiert, alle Helper-Funktionen und Aufgabenbeispiele per Smoke-Test verifiziert.

**Was du bekommst (im ZIP oder einzeln):**

- **`pyproject.toml`** – uv-Projekt mit allen Abhängigkeiten (jupyterlab 4.5, ipywidgets 8.1, anywidget 0.11, wigglystuff 0.4, jupytext 1.19, jupyterquiz 2.9, tutormagic 0.3)
- **`uv.lock`** – Versionssperre für reproduzierbare Installation
- **`uebungen_demo.md`** – die zentrale Demo-Datei (Jupytext-Markdown, in JupyterLab wie ein Notebook bedienbar)
- **`README.md`** – Setup-Anleitung mit Drei-Befehl-Schnellstart
- **`.gitignore`** – mit Jupytext-spezifischen Einträgen

**Schnellstart (drei Befehle):**

```bash
unzip m2-uebungen-demo.zip && cd m2-uebungen-demo
uv sync
uv run jupyter lab uebungen_demo.md
```

In JupyterLab dann Rechtsklick auf die `.md`-Datei → „Open With" → „Notebook". Das Jupytext-Lab-Plugin (auto-aktiv) macht aus der Markdown-Datei ein voll bedienbares Notebook.

**Was die Demo zeigt:** Jeweils ein bis drei Beispiele pro Übungsformat – Tracing (A1, B2, E5), Parsons (B1, C2, D3), Worked Examples (A1 mit optionalem Python-Tutor-Embed, C1) und Mini-Programmierung (MP-A2, MP-D2, MP-D3 mit Hidden-Test-Pattern). Drei Helper-Funktionen (`trace_uebung`, `parsons_puzzle`, `python_tutor`) im Setup-Block – damit kostet jede neue Übung nur noch wenige Zeilen Datendefinition.

**Verifizierte API-Korrektur gegenüber dem Bericht:** Die Bibliothek `wigglystuff` ist inzwischen bei 0.4.1 (nicht 0.3.5), `SortableList` nimmt den Parameter `value=` (nicht `items=`). Die Demo-Datei nutzt die aktuelle API.

**Eine Designentscheidung, die du noch kennen solltest:** Bei den Tracing-Aufgaben ist – wie konzeptionell vorgesehen – **kein** Auto-Vergleich eingebaut. Der „Lösung anzeigen"-Knopf zeigt die Musterlösung neben den TN-Eingaben an; der TN gleicht selbst ab. Das ist kein Feature-Mangel, sondern bewusst, weil sonst „Run-and-See" durch die Hintertür einkehrt.

Erledigt. Die Änderungen sind nur in `parsons_widget.py` (die Demo-Datei selbst musste nicht angefasst werden, weil sie `ParsonsList` schon korrekt importiert).

**Was sich geändert hat – im Vergleich zu vorher:**

|Element|Vorher|Jetzt|
|---|---|---|
|Mülleimer-SVG|22×22 px, Strichstärke 2|**28×28 px, Strichstärke 2.2**|
|Mülleimer-Button-Breite|40 px|**56 px**|
|Mülleimer-Hintergrund|transparent|**`#fef2f2` – dezent rosa** (sofort als Lösch-Bereich erkennbar)|
|Mülleimer-Icon-Farbe|`#90a4ae` (blassgrau)|**`#dc2626` (rot)** – schon ohne Hover sichtbar|
|Indent-Klickzone Breite|24 px|**36 px**|
|Indent-Pfeil-Größe|16 px|**20 px, fett**|
|Indent-Klickzone-Hintergrund|transparent|**`#eef2f7` – heller Grauton** (klar als interaktive Zone abgegrenzt)|
|Indent-Pfeil-Farbe|`#b0bec5` (sehr blass)|**`#334155` (dunkles Blaugrau)** – gut lesbar|
|Trennlinien zwischen Zonen|gestrichelt|**durchgehend** – wirkt mehr wie Buttons|
|Zeilen-Mindesthöhe|36 px|**44 px** – mehr Klick-Treffer-Fläche|

**Bedienung pro Parsons-Zeile (von links nach rechts):**

```
[⋮⋮] [ ◀ ] | code-zeile mit sichtbarer Einrückung |  [ ▶ ] [ 🗑 ]
 ↑    ↑        ↑                                       ↑    ↑
 Drag Indent   Codetext (Drag-Handle ist die ganze     Indent Mülleimer
 -ziel raus    Code-Zeile, nicht nur die Punkte)       rein   (Distraktor weg)
```