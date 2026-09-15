## 1. Projekt initialisieren

```bash
mkdir jupyterlab-env
cd jupyterlab-env
pixi init
```

---

## 2. pixi.toml konfigurieren

Das ist die fertige Konfiguration – entweder manuell anlegen oder schrittweise per `pixi add`:

```toml
[project]
name = "jupyterlab-env"
version = "0.1.0"
description = "JupyterLab Arbeitsumgebung"
channels = ["conda-forge"]
platforms = ["win-64", "linux-64", "osx-arm64"]

# ── Kern ──────────────────────────────────────────────
[dependencies]
python = "3.11.*"
jupyterlab = ">=4.0"
ipykernel = "*"
notebook = "*"

# ── Data Science ──────────────────────────────────────
numpy = "*"
pandas = "*"
matplotlib = "*"
scipy = "*"
scikit-learn = "*"
seaborn = "*"
plotly = "*"

# ── Jupyter-Erweiterungen ─────────────────────────────
ipywidgets = "*"
jupyterlab-git = "*"          # Git-Integration im Lab
jupytext = "*"                # .py ↔ .ipynb Konvertierung

# ── Dev-Tools ─────────────────────────────────────────
[dependencies]
black = "*"                   # Code-Formatierung
ruff = "*"                    # Linter

# ── PyPI-Pakete (was nicht auf conda-forge ist) ───────
[pypi-dependencies]
jupyterlab-code-formatter = "*"

# ── Tasks ─────────────────────────────────────────────
[tasks]
lab       = "jupyter lab --no-browser --port 8888"
lab-open  = "jupyter lab --port 8888"
lab-stop  = "jupyter lab stop 8888"
nb-list   = "jupyter notebook list"

# Kernel registrieren (einmalig nach Installation)
kernel-install = "python -m ipykernel install --user --name jupyterlab-env --display-name 'Pixi JupyterLab'"
```

---

## 3. Pakete installieren

```bash
# Alles aus pixi.toml installieren
pixi install

# Oder einzeln hinzufügen:
pixi add numpy pandas matplotlib
pixi add --pypi jupyterlab-code-formatter
```

---

## 4. Kernel registrieren & Lab starten

```bash
# Einmalig: Kernel für dieses Environment registrieren
pixi run kernel-install

# JupyterLab starten
pixi run lab         # ohne Browser-Öffnung
pixi run lab-open    # mit automatischem Browser
```

---

## 5. pixi-gui installieren (für WoA mit x64-Emulation)

Da du auf WoA bist, mit dem Workaround von vorhin:

```bash
pixi global install --platform win-64 \
  --channel https://prefix.dev/pixi-gui \
  --channel conda-forge \
  pixi-gui
```

Dann kannst du die Umgebung grafisch in pixi-gui verwalten – Pakete hinzufügen, Tasks starten, Environment-Status sehen – ohne Terminal.

---

## Nützliche Befehle im Alltag

```bash
pixi list                    # installierte Pakete anzeigen
pixi add polars              # neues Paket hinzufügen
pixi remove seaborn          # Paket entfernen
pixi update                  # alle Pakete aktualisieren
pixi run lab                 # JupyterLab starten
pixi shell                   # Shell im Environment öffnen
```

---

## Projektstruktur danach

```
jupyterlab-env/
├── pixi.toml       # ← in Git einchecken
├── pixi.lock       # ← in Git einchecken (Reproduzierbarkeit)
├── .pixi/          # ← NICHT in Git (.gitignore)
└── notebooks/      # deine Jupyter-Notebooks
```

Die `pixi.lock` sichert, dass auf jedem Rechner exakt dieselbe Umgebung entsteht – ideal wenn du zwischen deinem Dell XPS (WoA) und anderen Systemen wechselst.