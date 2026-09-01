Globaler `uv tool`-Setup mit Jupytext, damit Markdown-Dateien direkt im Vault wie Notebooks bearbeitet werden können — ohne den Umweg über `.ipynb`-Dateien, die Obsidian nicht lesen kann.

## Ziel

- **Eine** globale JupyterLab-Installation, deklarativ über `uv` gepflegt
- Notebooks werden als `.md` gespeichert → bleiben in Obsidian lesbar, durchsuchbar, mit Wikilinks verknüpfbar
- Optional gepaart mit `.ipynb`, falls Zell-Outputs erhalten bleiben sollen
- Start direkt im Vault-Verzeichnis per Nushell-Funktion

> [!info] Voraussetzungen
> - `uv` ist installiert
> - Obsidian-Vault liegt unter einem festen Pfad (im Folgenden `~/Obsidian/MyVault`)
> - Nushell als Shell

---

## 1. Tool-Environment einrichten

### 1.1 Requirements-Datei anlegen

Eine zentrale Liste mit allen Paketen für das globale Tool-Env. Damit bleibt der Setup reproduzierbar und nachvollziehbar — und du kannst nachträgliche Erweiterungen sauber dokumentieren.

`~/.config/jupyter/extras.txt`:

```text
# === Markdown-Notebook-Brücke ===
jupytext

# === LSP: Autocomplete, Go-to-Definition, Diagnostics ===
jupyterlab-lsp
python-lsp-server[all]

# === Code-Formatter (Black/isort) im Lab-Menü ===
jupyterlab-code-formatter
black
isort

# === Git-Integration im Lab ===
jupyterlab-git

# === Komfort ===
jupyterlab_execute_time     # Laufzeit pro Zelle
jupyterlab-spellchecker     # Rechtschreibung in Markdown-Zellen
ipywidgets                  # Interaktive Widgets (sliders, dropdowns)

# === Datenstack für den globalen Kernel ===
# Nur das, was du wirklich vault-weit brauchst.
# Spezifischere Pakete besser pro Projekt-Env installieren.
pandas
numpy
matplotlib
seaborn
```

### 1.2 Installation

```nu
uv tool install jupyterlab --with-requirements ~/.config/jupyter/extras.txt
```

> [!tip] Nachträglich Pakete ergänzen
> Einfach die Datei oben editieren und denselben Befehl erneut ausführen. `uv` synchronisiert das Tool-Env auf den neuen Stand. **Wichtig:** Der Befehl ist deklarativ — die Datei ist die einzige Quelle der Wahrheit. Niemals direkt mit `pip` ins Tool-Env greifen.

### 1.3 Deutsches Wörterbuch für den Spellchecker

Der Spellchecker liefert nur Englisch mit. Für Deutsch unter CachyOS:

```nu
sudo pacman -S hunspell hunspell-de
```

Im Lab dann unter **Settings → Spellchecker → Language**: `de_DE` wählen.

---

## 2. Jupytext konfigurieren

Jupytext registriert sich automatisch als Server-Extension, sobald installiert. Du musst nur noch festlegen, **wie** Markdown-Dateien behandelt werden.

### 2.1 Globale Defaults

`~/.config/jupytext/jupytext.toml` anlegen:

```toml
# Standardformate beim Pairen neuer Notebooks
formats = "ipynb,md"

# Welche Notebook-Metadaten in Markdown landen
notebook_metadata_filter = "kernelspec,jupytext"

# Zell-Metadaten weitgehend rauslassen — hält die .md im Obsidian-Reader sauber
cell_metadata_filter = "-all"
```

> [!info] Was das im Detail bewirkt
> - `formats = "ipynb,md"` → Beim Speichern werden automatisch beide Dateien parallel geschrieben.
> - `notebook_metadata_filter` → Begrenzt, was in den YAML-Header der `.md` aufgenommen wird. Nur Kernel-Info und Jupytext-Konfig, kein Versions- oder Tool-Krimskrams.
> - `cell_metadata_filter = "-all"` → Keine `tags`, `slideshow` oder andere Cell-Metadaten landen als hässliches Inline-YAML im Text.

### 2.2 Vault-spezifische Konfig (optional)

Wenn du im Vault andere Defaults willst — etwa nur `.md` ohne paariges `.ipynb`, weil du keine Outputs brauchst — lege eine eigene `jupytext.toml` direkt im Vault-Root ab:

```toml
# ~/Obsidian/MyVault/jupytext.toml
formats = "md"
```

Diese überschreibt die globale Konfig für alles im Vault.

---

## 3. JupyterLab im Vault starten

### 3.1 Direkt per Kommando

Mit dem modernen Server-Flag:

```nu
jupyter-lab --ServerApp.root_dir=("~/Obsidian/MyVault" | path expand)
```

### 3.2 Nushell-Funktion (empfohlen)

In `~/.config/nushell/config.nu` ergänzen:

```nu
# JupyterLab im Obsidian-Vault starten
def jlab [vault: path = ~/Obsidian/MyVault] {
    jupyter-lab --ServerApp.root_dir=($vault | path expand)
}
```

Aufruf:

```nu
jlab                          # Default-Vault
jlab ~/Obsidian/AnotherVault  # Anderer Vault
```

### 3.3 Variante ohne Auto-Browser

Falls du das Lab in einem festen Tab oder einer separaten App-Instanz behalten willst:

```nu
def jlab [vault: path = ~/Obsidian/MyVault] {
    jupyter-lab --ServerApp.root_dir=($vault | path expand) --no-browser
}
```

Die URL mit Token erscheint im Terminal — einmal in den Browser kopieren, fertig.

---

## 4. Workflow: Markdown-Datei als Notebook bearbeiten

### 4.1 Bestehende Obsidian-Note in ein Notebook umwandeln

1. Im Lab-File-Browser zur `.md`-Datei navigieren
2. **Rechtsklick → Open With → Notebook**
3. Kernel auswählen (default: Python 3)
4. Erste Codezelle einfügen, speichern → Jupytext schreibt YAML-Header mit Kernel-Info

Danach öffnet die Datei beim nächsten Doppelklick automatisch als Notebook.

### 4.2 Neues Notebook anlegen

- **File → New → Notebook** → Kernel wählen
- Über Command Palette (`Ctrl+Shift+C`) → **Pair Notebook with Markdown**
- Beim Speichern erscheinen `.ipynb` und `.md` parallel

### 4.3 Wie das in Obsidian aussieht

Code-Zellen sind ganz normale Fenced Code Blocks:

````markdown
```python
import pandas as pd
df = pd.read_csv("data.csv")
df.head()
```
````

Markdown-Zellen sind reines Obsidian-Markdown — inklusive **Wikilinks**, Embeds, Callouts, Tags. Volle Suchindexierung, volles Backlinking, alle Plugins funktionieren.

---

## 5. Obsidian-Einstellungen für reibungsloses Nebeneinander

### 5.1 Jupyter-Artefakte ausschließen

**Settings → Files & Links → Excluded files** → folgende Pattern hinzufügen:

```
.ipynb_checkpoints/
.jupyter/
__pycache__/
```

Diese Ordner legt Jupyter automatisch an. Ohne Ausschluss tauchen sie in Suche und Graph auf und stören.

### 5.2 `.ipynb` sichtbar machen (optional)

**Settings → Files & Links → Detect all file extensions** aktivieren. Dann erscheinen `.ipynb`-Dateien im Datei-Browser, auch wenn Obsidian sie nicht editieren kann — praktisch, um sie z. B. zu löschen oder umzubenennen.

### 5.3 YAML-Frontmatter

Jupytext-Metadaten landen im Frontmatter:

```yaml
---
jupyter:
  jupytext:
    formats: ipynb,md
    text_representation:
      extension: .md
      format_name: markdown
  kernelspec:
    display_name: Python 3
    language: python
    name: python3
---
```

Obsidian zeigt das im Properties-Panel als verschachtelte Eigenschaften an. Funktioniert, sieht aber etwas wuschig aus — bei Bedarf in den **Source Mode** wechseln (`Ctrl+E` zwischen Reading/Live-Preview, dann zusätzlich auf Source umstellen).

---

## 6. Kernel-Strategie

### 6.1 Globaler Kernel (Standardfall)

Der Kernel des Tool-Envs reicht für 90 % aller Vault-Inhalte. Was du dort brauchst, kommt in `~/.config/jupyter/extras.txt`. Pandas, NumPy, Matplotlib usw. — solides Fundament für Datenexploration und Notizen.

### 6.2 Projektspezifischer Kernel

Sobald eine Note Pakete braucht, die nicht global Sinn ergeben — `tensorflow`, `polars`, `pyspark`, irgendein Spezialwerkzeug — eigenes Projekt-Env aufsetzen und als Kernel registrieren:

```nu
cd ~/Projects/spezialprojekt
uv init
uv add ipykernel pandas tensorflow
uv run python -m ipykernel install --user --name=spezialprojekt --display-name "Spezialprojekt (TF)"
```

Im Notebook anschließend oben rechts den Kernel wechseln. Die Note bleibt im Vault, der Kernel zeigt aber auf das isolierte Projekt-Env.

> [!warning] Tool-Env schlank halten
> Wenn du anfängst, projektspezifische Pakete ins globale Tool-Env zu kippen, verlierst du den Reproduzierbarkeits-Vorteil. Lieber ein Projekt-Env mehr anlegen.

---

## 7. Pflege & Updates

### 7.1 JupyterLab und alle Pakete aktualisieren

```nu
uv tool upgrade jupyterlab
```

Aktualisiert das gesamte Tool-Env inklusive aller mitinstallierten Pakete auf die neuesten kompatiblen Versionen.

### 7.2 Komplett neu aufbauen

Bei kaputten Extensions oder vermurkstem State:

```nu
uv tool uninstall jupyterlab
uv tool install jupyterlab --with-requirements ~/.config/jupyter/extras.txt
```

### 7.3 Ad-hoc-Pakete testen ohne Tool-Env-Änderung

```nu
uvx --with plotly --with-requirements ~/.config/jupyter/extras.txt jupyter-lab --ServerApp.root_dir=~/Obsidian/MyVault
```

Temporäres Env wird nach Beenden weggeworfen — gut für „mal eben ausprobieren, ob das Paket das Richtige ist".

---

## 8. Stolperfallen

> [!warning] `.ipynb_checkpoints` im Vault
> Jupyter legt versteckte Backup-Ordner an. Wenn du sie nicht in Obsidians Excluded-Files-Setting blockierst, tauchen sie in der Suche und im Graph auf.

> [!warning] Output-Verlust bei reinem `.md`
> Die `.md` enthält **keine** Zell-Outputs (Plots, DataFrames als HTML, Bilder). Nur das gepaarte `.ipynb` hält sie fest. Wenn dir Outputs wichtig sind: Format `ipynb,md` verwenden (siehe globale Konfig).

> [!warning] Gleichzeitiges Editieren
> Niemals dieselbe Datei parallel in Obsidian **und** Jupyter offen haben und in beiden bearbeiten. Letzter Save gewinnt — der andere Stand ist weg. Im Zweifel vor dem Wechsel speichern und in der Gegenseite die Datei neu öffnen (Obsidian: `Ctrl+Shift+R` für Reload).

> [!warning] Sehr große Notebooks
> Obsidian ist auf Markdown-Notes ausgelegt, nicht auf 10.000-Zeilen-Datendumps. Wenn ein Notebook groß und output-lastig wird, gehört es eher in ein eigenes Projektverzeichnis außerhalb des Vaults — mit `.ipynb` als Hauptformat.

---

## 9. TL;DR

```nu
# === Einmalig ===
uv tool install jupyterlab --with-requirements ~/.config/jupyter/extras.txt

# Konfig anlegen: ~/.config/jupytext/jupytext.toml
#   formats = "ipynb,md"
#   cell_metadata_filter = "-all"

# Funktion in ~/.config/nushell/config.nu
def jlab [vault: path = ~/Obsidian/MyVault] {
    jupyter-lab --ServerApp.root_dir=($vault | path expand)
}

# === Tägliche Nutzung ===
jlab
```

Im Lab: Rechtsklick auf `.md` → **Open With → Notebook** → loscoden. Speichern schreibt zurück ins Markdown — Obsidian sieht beim nächsten Wechsel die Änderungen, inklusive aller Code-Blöcke und Outputs als Text.
