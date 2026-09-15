Diese Anleitung führt Sie durch die komplette Einrichtung einer professionellen Python-Entwicklungsumgebung mit JupyterLab unter openSUSE Leap. Am Ende haben Sie eine vollwertige IDE mit Debugging, IntelliSense, Variablen-Inspektor, Refactoring-Tools und Markdown-Notebook-Unterstützung.

## Inhaltsverzeichnis

1. [Mambaforge Installation](https://claude.ai/chat/a4df732f-d31f-4142-ab86-3e13ff6ab4a1#mambaforge-installation)
2. [Python-Umgebung einrichten](https://claude.ai/chat/a4df732f-d31f-4142-ab86-3e13ff6ab4a1#python-umgebung-einrichten)
3. [JupyterLab Basis-Installation](https://claude.ai/chat/a4df732f-d31f-4142-ab86-3e13ff6ab4a1#jupyterlab-basis-installation)
4. [IDE-Erweiterungen installieren](https://claude.ai/chat/a4df732f-d31f-4142-ab86-3e13ff6ab4a1#ide-erweiterungen-installieren)
5. [Python-Entwicklungspakete](https://claude.ai/chat/a4df732f-d31f-4142-ab86-3e13ff6ab4a1#python-entwicklungspakete)
6. [Markdown-Notebook-Unterstützung](https://claude.ai/chat/a4df732f-d31f-4142-ab86-3e13ff6ab4a1#markdown-notebook-unterst%C3%BCtzung)
7. [Konfiguration und Optimierung](https://claude.ai/chat/a4df732f-d31f-4142-ab86-3e13ff6ab4a1#konfiguration-und-optimierung)
8. [Verwendung und Features](https://claude.ai/chat/a4df732f-d31f-4142-ab86-3e13ff6ab4a1#verwendung-und-features)
9. [Troubleshooting](https://claude.ai/chat/a4df732f-d31f-4142-ab86-3e13ff6ab4a1#troubleshooting)

---

## Mambaforge Installation

Mambaforge ist ein schneller, conda-kompatibler Paketmanager, der conda-forge als Standard-Channel verwendet.

### Download und Installation

```bash
# Mambaforge für Linux x64 herunterladen
cd ~/Downloads
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh

# Installationsskript ausführbar machen
chmod +x Mambaforge-Linux-x86_64.sh

# Installation starten (folgen Sie den Anweisungen)
./Mambaforge-Linux-x86_64.sh

# Shell neustarten oder Umgebung laden
source ~/.bashrc
```

### Verification

```bash
# Installation überprüfen
mamba --version
conda --version
```

---

## Python-Umgebung einrichten

Erstellen Sie eine dedizierte Umgebung für Ihre JupyterLab-IDE.

### Umgebung erstellen

```bash
# Neue Umgebung mit Python 3.13 erstellen
mamba create -n jupyter-ide python=3.13 -y

# Umgebung aktivieren
mamba activate jupyter-ide

# Python-Version bestätigen
python --version
```

### Kernel für Jupyter registrieren

```bash
# IPython-Kernel installieren und registrieren
mamba install -c conda-forge ipykernel -y
python -m ipykernel install --user --name jupyter-ide --display-name "Python 3.13 (Jupyter IDE)"
```

---

## JupyterLab Basis-Installation

Installieren Sie JupyterLab mit grundlegenden Erweiterungen.

### Core JupyterLab

```bash
# JupyterLab mit wichtigen Basis-Extensions
mamba install -c conda-forge \
    jupyterlab \
    jupyter \
    jupyterlab-git \
    jupyterlab_widgets \
    ipywidgets \
    -y
```

### Node.js für Extensions (falls benötigt)

```bash
# Node.js für erweiterte Extensions
mamba install -c conda-forge nodejs -y
```

---

## IDE-Erweiterungen installieren

Diese Erweiterungen machen JupyterLab zu einer vollwertigen IDE.

### 1. Debugger

Der JupyterLab-Debugger ist seit Version 3.0 direkt integriert und ermöglicht visuelles Debugging mit Breakpoints.

```bash
# Xeus-Python für erweiterte Debugging-Features
mamba install -c conda-forge \
    xeus-python \
    -y

# Zusätzliche Debugging-Tools
mamba install -c conda-forge ipdb -y

# Erweiterte Debugger über pip
pip install \
    pdbpp \
    pudb \
    icecream
```

**Hinweis**: `jupyterlab-debugger` ist seit JupyterLab 3.0 bereits integriert und muss nicht separat installiert werden.

**Features:**

- Visuelle Breakpoints setzen
- Step-through Debugging
- Variable inspection während Debugging
- Call stack visualization

### 2. Language Server Protocol (IntelliSense)

LSP bietet intelligente Code-Vervollständigung und Fehleranalyse.

```bash
# JupyterLab LSP mit Python Language Server
mamba install -c conda-forge \
    jupyterlab-lsp \
    python-lsp-server \
    -y

# Zusätzliche LSP-Features
pip install \
    'python-lsp-server[all]' \
    python-lsp-ruff \
    pylsp-mypy \
    python-lsp-black
```

**Features:**

- Intelligente Autocompletion
- Real-time Syntax-Checking
- Go-to-Definition
- Find References
- Hover-Dokumentation

### 3. Variablen-Inspektor

Überwachen Sie Variablen in Echtzeit während der Entwicklung.

```bash
# Variable Inspector
pip install lckr-jupyterlab-variableinspector

# Alternative (falls die erste nicht funktioniert)
pip install jupyterlab-variableInspector
```

**Features:**

- Alle Variablen im aktuellen Namespace anzeigen
- Datentypen und Werte in Echtzeit
- Sortierung und Filterung
- DataFrame-Vorschau

### 4. Code-Formatter und Refactoring

Automatische Code-Formatierung und Refactoring-Tools.

```bash
# Code Formatter Extension
mamba install -c conda-forge jupyterlab_code_formatter -y

# Formatter-Tools
mamba install -c conda-forge \
    black \
    isort \
    autopep8 \
    yapf \
    -y

# Refactoring-Tools
mamba install -c conda-forge \
    rope \
    -y
```

**Features:**

- Automatische Code-Formatierung (Black, autopep8, YAPF)
- Import-Sortierung (isort)
- Code-Refactoring mit Rope
- Format-on-Save Option

### 5. Weitere nützliche Extensions

```bash
# Resource Usage Monitor (Alternative zu System Monitor)
mamba install -c conda-forge \
    jupyter-resource-usage \
    jupyterlab-topbar \
    -y

# Spellchecker für Markdown/Kommentare
pip install jupyterlab-spellchecker

# Table of Contents
pip install jupyterlab-toc

# DrawIO Integration
pip install jupyterlab-drawio

# LaTeX Support
mamba install -c conda-forge jupyterlab-latex -y

# Execute Time für Performance-Monitoring
pip install jupyterlab-execute-time
```

---

## Python-Entwicklungspakete

Installieren Sie alle wichtigen Python-Pakete für eine vollständige Entwicklungsumgebung.

### Data Science und Machine Learning

```bash
# Grundlegende Data Science Pakete
mamba install -c conda-forge \
    numpy \
    pandas \
    matplotlib \
    seaborn \
    plotly \
    bokeh \
    altair \
    -y

# Scientific Computing
mamba install -c conda-forge \
    scipy \
    scikit-learn \
    statsmodels \
    sympy \
    -y

# Machine Learning Frameworks
mamba install -c conda-forge \
    tensorflow \
    keras \
    -y

# PyTorch (separate Installation für bessere Kompatibilität)
mamba install -c pytorch -c conda-forge \
    pytorch \
    torchvision \
    torchaudio \
    -y

# Weitere ML-Tools
mamba install -c conda-forge \
    xgboost \
    lightgbm \
    catboost \
    -y
```

### Entwicklungstools

```bash
# Code-Qualität und Testing
mamba install -c conda-forge \
    pylint \
    flake8 \
    mypy \
    pytest \
    pytest-cov \
    pytest-xdist \
    -y

# Pre-commit Hooks
mamba install -c conda-forge \
    pre-commit \
    -y

# Profiling und Performance
mamba install -c conda-forge \
    line_profiler \
    memory_profiler \
    py-spy \
    -y
```

### Web Development und APIs

```bash
# HTTP und Web-Scraping
mamba install -c conda-forge \
    requests \
    beautifulsoup4 \
    scrapy \
    selenium \
    -y

# Web Frameworks
mamba install -c conda-forge \
    flask \
    fastapi \
    uvicorn \
    -y
```

### Datenbank und File I/O

```bash
# Datenbank-Konnektoren
mamba install -c conda-forge \
    sqlalchemy \
    psycopg2 \
    pymongo \
    -y

# File Format Support
mamba install -c conda-forge \
    openpyxl \
    xlsxwriter \
    h5py \
    pytables \
    -y

# Image Processing
mamba install -c conda-forge \
    pillow \
    opencv \
    scikit-image \
    -y
```

---

## Markdown-Notebook-Unterstützung

Ermöglicht die Verwendung von Markdown-Dateien als ausführbare Notebooks.

### Jupytext Installation

```bash
# Jupytext für Markdown-Notebooks (einzeln installieren bei Speicherproblemen)
pip install jupytext

# MyST-Parser für erweiterte Markdown-Features (optional)
pip install myst-parser

# Jupyter-Book für Publikationen (optional, nur falls benötigt)
# pip install jupyter-book
```

### Jupytext Konfiguration

```bash
# Jupytext-Konfiguration erstellen
mkdir -p ~/.jupyter
cat << 'EOF' > ~/.jupyter/jupytext.toml
# Jupytext Konfiguration
formats = "ipynb,md"

[tool.jupytext.formats]
"md" = {extension = ".md", format_name = "myst"}
"ipynb" = {extension = ".ipynb"}
EOF
```

**Verwendung:**

- `.md` Dateien werden automatisch als Notebooks erkannt
- Code-Blöcke mit ` ```python ` sind ausführbar
- Wechsel zwischen `.ipynb` und `.md` Format möglich

---

## Konfiguration und Optimierung

Optimieren Sie JupyterLab für die bestmögliche IDE-Erfahrung.

### JupyterLab Konfiguration

```bash
# Konfigurationsdatei generieren
jupyter lab --generate-config

# Erweiterte Konfiguration
cat << 'EOF' >> ~/.jupyter/jupyter_lab_config.py

# ============================================================================
# JupyterLab IDE Konfiguration
# ============================================================================

# Server Configuration
c.ServerApp.ip = '127.0.0.1'
c.ServerApp.port = 8888
c.ServerApp.open_browser = True
c.ServerApp.root_dir = '~/Development'

# LSP Configuration
c.LanguageServerManager.language_servers = {
    'python': {
        'command': ['pylsp'],
        'languages': ['python'],
        'version': 1
    }
}

# Content Manager für Jupytext
c.ContentsManager.default_jupytext_formats = "ipynb,md"

# Notebook Configuration
c.NotebookApp.contents_manager_class = 'jupytext.TextFileContentsManager'

# Code Formatter Settings
c.JupyterLabCodeFormatter.black = {
    'line_length': 88,
    'skip_string_normalization': True
}

c.JupyterLabCodeFormatter.isort = {
    'profile': 'black',
    'multi_line_output': 3
}

# Auto-save Intervall (in Sekunden)
c.FileContentsManager.save_script = True

EOF
```

### VS Code-ähnliche Keybindings (Optional)

```bash
# Benutzerdefinierte Keybindings
mkdir -p ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/
cat << 'EOF' > ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings
{
    "shortcuts": [
        {
            "command": "debugger:start",
            "keys": ["F5"],
            "selector": ".jp-Notebook"
        },
        {
            "command": "debugger:stop",
            "keys": ["Shift F5"],
            "selector": ".jp-Notebook"
        },
        {
            "command": "completer:invoke",
            "keys": ["Ctrl Space"],
            "selector": ".jp-CodeMirrorEditor"
        },
        {
            "command": "jupyterlab_code_formatter:black",
            "keys": ["Ctrl Shift I"],
            "selector": ".jp-Notebook"
        }
    ]
}
EOF
```

### Environment Setup Script

Erstellen Sie ein Skript für einfache Aktivierung der Umgebung:

```bash
# Setup-Skript erstellen
cat << 'EOF' > ~/start-jupyter-ide.sh
#!/bin/bash

# JupyterLab IDE Starter Script
echo "🚀 Starting JupyterLab IDE Environment..."

# Conda/Mamba initialisieren
source ~/mambaforge/etc/profile.d/conda.sh
source ~/mambaforge/etc/profile.d/mamba.sh

# Umgebung aktivieren
mamba activate jupyter-ide

# Entwicklungsverzeichnis erstellen falls nicht vorhanden
mkdir -p ~/Development

# JupyterLab mit explizitem Port starten
echo "📂 Opening JupyterLab in ~/Development"
cd ~/Development
jupyter lab --port=8888

EOF

# Skript ausführbar machen
chmod +x ~/start-jupyter-ide.sh
```

---

## Verwendung und Features

### JupyterLab starten

```bash
# Umgebung aktivieren
mamba activate jupyter-ide

# JupyterLab starten
jupyter lab

# Oder mit dem Setup-Skript
~/start-jupyter-ide.sh
```

### IDE-Features nutzen

#### Debugging

1. **Breakpoint setzen**: Klick auf Zeilennummer im Code-Editor
2. **Debug starten**: F5 oder Debug-Button in der Toolbar
3. **Step through**: F10 (Step Over), F11 (Step Into)
4. **Variable inspection**: Automatisch im Debug-Panel

#### IntelliSense

- **Autocompletion**: `Ctrl + Space` oder automatisch beim Tippen
- **Parameter hints**: Beim Funktionsaufruf automatisch
- **Go to definition**: `Ctrl + Click` auf Funktionsname
- **Find references**: `Shift + F12`

#### Variablen-Inspektor

1. **Öffnen**: View → Show Variable Inspector
2. **Dock**: Panel an gewünschte Position ziehen
3. **Refresh**: Automatisch nach Code-Ausführung
4. **Filter**: Suchfeld für spezifische Variablen

#### Code-Formatierung

- **Format Code**: `Ctrl + Shift + I`
- **Format on Save**: Automatisch aktiviert
- **Custom Formatter**: Black, autopep8, oder YAPF wählbar

#### Markdown-Notebooks

````markdown
# Beispiel Markdown-Notebook

Dies ist normaler Markdown-Text.

```python
# Dieser Code ist ausführbar
import pandas as pd
import numpy as np

data = np.random.randn(10, 3)
df = pd.DataFrame(data, columns=['A', 'B', 'C'])
print(df.head())
````

Mehr Text zwischen Code-Blöcken.

```python
# Weiterer ausführbarer Code
df.plot(kind='bar')
```

````

### Nützliche Tastenkombinationen

| Funktion | Tastenkombination |
|----------|-------------------|
| Neue Zelle | `A` (oberhalb), `B` (unterhalb) |
| Zelle ausführen | `Shift + Enter` |
| Debug starten | `F5` |
| Autocompletion | `Ctrl + Space` |
| Code formatieren | `Ctrl + Shift + I` |
| Command Palette | `Ctrl + Shift + C` |
| File Browser | `Ctrl + Shift + F` |
| Variable Inspector | `Ctrl + Shift + V` |

---

## Troubleshooting

### Häufige Probleme und Lösungen

#### Extensions nicht sichtbar
```bash
# Extensions neu installieren
jupyter labextension list
jupyter lab build
jupyter lab clean
````

#### LSP funktioniert nicht

```bash
# Language Server neu installieren
pip uninstall python-lsp-server
pip install 'python-lsp-server[all]'
jupyter lab restart
```

#### Variablen-Inspektor zeigt nichts

```bash
# Extension neu aktivieren
jupyter labextension disable lckr-jupyterlab-variableinspector
jupyter labextension enable lckr-jupyterlab-variableinspector
```

#### Speicher-Probleme

```bash
# JupyterLab Cache leeren
jupyter lab clean
rm -rf ~/.jupyter/lab/workspaces/
```

#### Python-Pakete nicht gefunden

```bash
# Kernel neu installieren
python -m ipykernel install --user --name jupyter-ide --display-name "Python 3.13 (Jupyter IDE)" --force
```

### Umgebung aktualisieren

```bash
# Alle Pakete aktualisieren
mamba activate jupyter-ide
mamba update --all

# Spezifische Pakete aktualisieren
mamba update jupyterlab
mamba update python-lsp-server
```

### Backup und Wiederherstellung

```bash
# Umgebung exportieren
mamba env export > jupyter-ide-environment.yml

# Umgebung aus Backup wiederherstellen
mamba env create -f jupyter-ide-environment.yml
```

---

## Weitere Ressourcen

- **JupyterLab Dokumentation**: https://jupyterlab.readthedocs.io/
- **Python LSP Server**: https://github.com/python-lsp/python-lsp-server
- **Jupytext Dokumentation**: https://jupytext.readthedocs.io/
- **Conda-Forge**: https://conda-forge.org/

## Fazit

Mit dieser Konfiguration haben Sie eine vollwertige Python-IDE basierend auf JupyterLab, die folgende Features bietet:

- ✅ **Professionelles Debugging** mit visuellen Breakpoints
- ✅ **Intelligente Code-Vervollständigung** durch LSP
- ✅ **Echtzeit-Variablen-Inspektion**
- ✅ **Automatische Code-Formatierung und Refactoring**
- ✅ **Markdown-Notebook-Unterstützung**
- ✅ **Vollständige Data Science und ML-Bibliotheken**
- ✅ **Git-Integration**
- ✅ **Erweiterbare Extension-Architektur**

Diese Setup konkurriert mit PyCharm Professional oder VS Code, behält aber die einzigartigen Vorteile von Jupyter-Notebooks bei.