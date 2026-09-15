## 1. Projektordner und virtuelle Umgebung einrichten

Sofern noch kein Projektordner mit einer virtuellen Umgebung vorhanden ist, wird
dieser zuerst angelegt. Wer bereits eine Umgebung aus einem vorherigen Schritt
hat (z. B. `learn-arcade`), wechselt einfach in diesen Ordner und überspringt
die ersten beiden Befehle.

```sh
# Projektordner anlegen und hineinwechseln
mkdir learn_jupyter
cd learn_jupyter

# Virtuelle Umgebung mit Python 3.13 erstellen
uv venv --python 3.13
```

---

## 2. JupyterLab und den Python-Kernel installieren

JupyterLab ist die eigentliche Oberfläche, die im Browser läuft. `ipykernel`
verbindet JupyterLab mit der virtuellen Python-Umgebung, sodass Code aus dem
Projekt heraus ausgeführt wird.

```sh
uv pip install jupyterlab ipykernel
```

---

## 3. Sprachserver für Syntaxprüfung und Vorschläge installieren

Der Language Server Protocol-Stack (LSP) bringt Funktionen, die man aus modernen
Code-Editoren kennt: Syntaxfehler werden direkt unterstrichen, Variablen- und
Funktionsnamen werden vorgeschlagen, und Dokumentation erscheint beim Überfahren
mit der Maus.

```sh
# JupyterLab-Erweiterung und LSP-Backend installieren
uv pip install jupyter-lsp jupyterlab-lsp python-lsp-server

# Optionale LSP-Plugins für erweiterte Analyse
uv pip install python-lsp-ruff   # schnelle Syntaxprüfung und Linting
uv pip install pylsp-rope        # intelligente Refactoring-Vorschläge
```

> **Was die einzelnen Pakete tun:**
>
> | Paket | Aufgabe |
> |---|---|
> | `jupyter-lsp` | Verbindungsschicht zwischen JupyterLab und dem Sprachserver |
> | `jupyterlab-lsp` | Zeigt Fehler, Vorschläge und Hover-Doku direkt im Editor an |
> | `python-lsp-server` | Der eigentliche Sprachserver, analysiert Python-Code |
> | `python-lsp-ruff` | Schnelles Linting (Stilfehler, Logikprobleme) via `ruff` |
> | `pylsp-rope` | Umbenennen von Variablen, Importe aufräumen u. a. |

---

## 4. Code-Formatter installieren

Ein Formatter bringt Code automatisch in eine einheitliche Form – korrekte
Einrückung, Leerzeilen, Zeilenlänge. Das spart Zeit und macht Code lesbarer.

```sh
uv pip install jupyterlab-code-formatter black isort
```

> **Was die einzelnen Pakete tun:**
>
> | Paket | Aufgabe |
> |---|---|
> | `jupyterlab-code-formatter` | Fügt einen „Format"-Button in JupyterLab ein |
> | `black` | Formatiert Python-Code nach einem einheitlichen Standard |
> | `isort` | Sortiert Import-Anweisungen automatisch |

Nach dem Start von JupyterLab erscheint in der Toolbar ein neues Symbol zum
Formatieren der aktuellen Zelle oder des gesamten Notebooks.

---

## 5. Markdown-Dokumente direkt nutzen mit Jupytext

Jupytext ermöglicht es, gewöhnliche `.md`-Dateien als ausführbare Notebooks zu
öffnen und zu bearbeiten. Code-Blöcke in Markdown werden dabei als ausführbare
Zellen behandelt – ideal, um Dokumentation und Code in einer einzigen Datei zu
halten.

```sh
uv pip install jupytext
```

In JupyterLab kann danach jede `.md`-Datei per Rechtsklick → *Open With* →
*Jupytext Notebook* als Notebook geöffnet werden. Änderungen werden direkt in
der Markdown-Datei gespeichert – kein separates `.ipynb` nötig.

---

## 6. JupyterLab starten

```sh
uv run jupyter lab
```

JupyterLab öffnet sich automatisch im Standardbrowser. Die Adresse lautet in der
Regel `http://localhost:8888`. Zum Beenden in der Nushell-Sitzung `Ctrl+C` drücken.

> **Wichtig:** Der Befehl muss im Projektordner ausgeführt werden, damit `uv` die
> zugehörige `.venv` findet und alle installierten Pakete verfügbar sind.

---

## 7. Übersicht: Alle Installationsbefehle auf einen Blick

```sh
# Einmalige Einrichtung
uv venv --python 3.13

# Kernpakete
uv pip install jupyterlab ipykernel

# Sprachserver (Syntaxprüfung & Vorschläge)
uv pip install jupyter-lsp jupyterlab-lsp python-lsp-server python-lsp-ruff pylsp-rope

# Formatter
uv pip install jupyterlab-code-formatter black isort

# Markdown als Notebook
uv pip install jupytext

# Starten
uv run jupyter lab
```

---

## 8. `uv run jupyter lab` vs. `uv run python -m idlelib` – was ist der Unterschied?

| Befehl | Was passiert |
|---|---|
| `uv run jupyter lab` | Startet **JupyterLab** im Browser. Notebooks, Markdown-Dateien und ein Terminal sind in einer Oberfläche vereint. Gut für längere Entwicklungssessions und Dokumentation. |
| `uv run python -m idlelib` | Startet **IDLE**, die einfache Python-eigene Entwicklungsumgebung. Gut für schnelle Einzelskripte ohne Browser. |
| `uv run python` | Startet den **interaktiven Interpreter** direkt in der Konsole. Gut zum schnellen Testen einzelner Ausdrücke. |
