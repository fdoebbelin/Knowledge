Der einfachste Weg, dies mit `uv` zu tun, ist, eine virtuelle Umgebung zu erstellen, die Abhängigkeiten über eine `requirements.txt`-Datei zu installieren und dann JupyterLab zu starten. `uv` macht diesen Prozess extrem schnell und unkompliziert.

Hier ist der komplette Workflow Schritt für Schritt, den Sie direkt in Ihrem heruntergeladenen GitHub-Repository ausführen können.

### Zusammenfassung: Der schnellste Weg (3 Befehle)

1. **Virtuelle Umgebung erstellen:**

```bash
uv venv
```

2. **Abhängigkeiten installieren:** Erstellen Sie eine `requirements.txt`-Datei und führen Sie dann aus:

```bash
uv pip install -r requirements.txt
```

3. **JupyterLab starten:**

```bash
uv run jupyter lab
```


***

### Detaillierte Anleitung

#### Schritt 1: Navigieren Sie in Ihr Repository

Öffnen Sie Ihre Nushell (oder eine andere Shell) und wechseln Sie in das Verzeichnis des GitHub-Repositorys, das Sie heruntergeladen haben.

```bash
cd /pfad/zu/ihrem/repository
```


#### Schritt 2: Virtuelle Umgebung erstellen

`uv` kann eine Python-Umgebung in einem `.venv`-Ordner erstellen. Dieser Befehl findet automatisch eine Python-Version auf Ihrem System oder lädt eine herunter, falls keine gefunden wird.

```bash
uv venv
```

Dies erstellt ein Verzeichnis namens `.venv` in Ihrem Projektordner. `uv` wird dieses Verzeichnis automatisch erkennen und für alle weiteren Befehle verwenden.

#### Schritt 3: Erstellen Sie eine `requirements.txt`-Datei

Erstellen Sie im Hauptverzeichnis Ihres Projekts eine neue Datei mit dem Namen `requirements.txt`. Diese Datei listet alle Pakete auf, die Sie installieren möchten.

Hier ist eine empfohlene Liste für eine umfassende Python-Entwicklungsumgebung mit JupyterLab, Jupytext und wichtigen Erweiterungen:

```
# requirements.txt

# Jupyter Kernkomponenten
jupyterlab
ipywidgets

# Jupytext für die Synchronisierung von Notebooks mit Textdateien
jupytext

# Language Server Protocol (LSP) für Code-Vervollständigung, Analyse und Navigation
jupyterlab-lsp
python-lsp-server[all]

# Ruff für extrem schnelles Linting und Formatieren direkt in Jupyter
ruff
```

**Was machen diese Pakete?**

* **`jupyterlab`**: Die moderne Jupyter-Oberfläche.
* **`ipywidgets`**: Ermöglicht interaktive Elemente und Steuerelemente in Ihren Notebooks.
* **`jupytext`**: Wie von Ihnen gewünscht, ermöglicht dies die beidseitige Synchronisierung von `.ipynb`-Notebooks mit einfachen Textdateien (z.B. `.py` oder `.md`). Dies ist fantastisch für die Versionskontrolle mit Git.
* **`jupyterlab-lsp`** und **`python-lsp-server`**: Diese beiden Pakete bringen IDE-Funktionen wie Autovervollständigung, "Gehe zu Definition" und Inline-Fehleranzeige in Ihr JupyterLab.
* **`ruff`**: Ein extrem schneller Linter und Code-Formatierer, der `flake8`, `isort`, `black` und viele andere Tools ersetzen kann. `jupyterlab-lsp` kann `ruff` als Backend verwenden, um Ihnen sofortiges Feedback zu Ihrem Code zu geben.


#### Schritt 4: Installieren Sie die Pakete mit `uv`

Jetzt, da Ihre virtuelle Umgebung und die `requirements.txt`-Datei bereit sind, installieren Sie alles mit einem einzigen, schnellen Befehl:

```bash
uv pip install -r requirements.txt
```

`uv` wird die Abhängigkeiten auflösen und alle Pakete parallel herunterladen und installieren, was deutlich schneller ist als herkömmliche Tools.

#### Schritt 5: JupyterLab starten

Nachdem die Installation abgeschlossen ist, können Sie JupyterLab direkt mit `uv run` starten. Dieser Befehl führt den `jupyter lab`-Befehl innerhalb der `.venv`-Umgebung aus, ohne dass Sie diese manuell aktivieren müssen.

```bash
uv run jupyter lab
```

Ihr Browser sollte sich nun mit einer voll funktionsfähigen JupyterLab-Instanz öffnen, in der alle Erweiterungen bereits aktiv sind.

### Vorteile dieses Ansatzes mit `uv`

* **Geschwindigkeit**: `uv` löst Abhängigkeiten und installiert Pakete extrem schnell.
* **Einfachheit**: Sie benötigen nur wenige, intuitive Befehle. `uv` findet und verwaltet die virtuelle Umgebung automatisch.
* **Reproduzierbarkeit**: Durch die `requirements.txt`-Datei kann jeder mit `uv` genau dieselbe Umgebung in Sekunden einrichten.
* **Plattformunabhängig**: Diese Befehle funktionieren auf Windows, macOS und Linux identisch.


### Manuelles Editieren der `requirements.txt`

Sie haben die `requirements.txt` manuell editiert
Um Ihre virtuelle Umgebung an die geänderte Datei anzupassen, nutzen Sie am besten `sync` statt `install`.

* `install`: Fügt nur Neues hinzu, lässt alte (gelöschte) Pakete aber als "Müll" liegen.
* `sync`: Macht die Umgebung zu einem exakten Spiegelbild der Datei (installiert Neues, **löscht** Altes).

```bash
uv pip sync requirements.txt
```