Die Installation von **JupyterLab** hängt von deinem Umfeld und deinen Anforderungen ab. Hier ist eine Übersicht, wann du **conda** oder **pipx** verwenden solltest, einschließlich Vor- und Nachteile.

---

## 🐍 Installation mit conda (empfohlen für Datenwissenschaftler und Anaconda-User)

Wenn du **Anaconda** oder **Miniconda** verwendest, ist es besser, JupyterLab über `conda` zu installieren.

### Vorteile:

- **Paketabhängigkeiten**: `conda` verwaltet Python-Pakete und deren nicht-Python-Abhängigkeiten (z.B. C-Bibliotheken), was oft zuverlässiger ist als `pip`.
- **Isolierte Umgebungen**: `conda`-Umgebungen sind gut isoliert und erleichtern es, verschiedene Python-Versionen zu nutzen.
- **Einheitliche Verwaltung**: Alles (JupyterLab, Notebook-Erweiterungen, Kernels) bleibt innerhalb der conda-Umgebung.

### Installation:

```bash
conda create -n jupyterlab
conda activate jupyterlab
conda install -c conda-forge \
jupytext  \
ipywidgets  \
jupyterlab-blockly  \
jupyterlab-lsp  \
python-lsp-server  \
jupyterlab
```


```powershell
scoop install main/sudosudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
scoop install extras/mambaforge
conda init powershell
conda create -n jupyterlab -c conda-forge jupytext ipywidgets jupyterlab-blockly jupyterlab jupyterlab-lsp python-lsp-server
conda activate jupyterlab
mkdir $HOME\Documents\JupyterLab
cd $HOME\Documents\JupyterLab
jupyter lab
```

---

## 🚀 **Installation mit pipx** (empfohlen für globale, isolierte Installationen)

`pipx` ist ein Tool, das Python-Anwendungen **global** installiert, aber sie in einer eigenen virtuellen Umgebung isoliert.

### Vorteile:

- **Sauber & global**: Ideal, wenn du JupyterLab systemweit brauchst, ohne dein globales Python zu verschmutzen.
- **Schnelle Installation**: Kein großer Overhead wie bei `conda` oder Anaconda.
- **Unabhängig von Anaconda**: Wenn du Anaconda/Miniconda nicht nutzt, bleibt `pipx` einfach zu handhaben.

### Nachteile:

- **Python-Abhängigkeiten**: `pip` kann systemübergreifende Abhängigkeiten nicht so zuverlässig wie `conda` installieren.
- **Kompatibilität**: Du musst eventuell manuell aufpassen, dass alle Pakete kompatibel bleiben.

### Installation:

```bash
pipx install jupyterlab
```

---

## Vergleich: Wann welches Tool?

|**Kriterium**|**conda**|**pipx**|
|---|---|---|
|**Umgebung**|Datenanalyse- oder ML-Umgebungen|Allgemeine globale Nutzung|
|**Abhängigkeiten**|Besseres Handling (inkl. C-Bibs)|Nur Python-Abhängigkeiten|
|**Isolierung**|pro `conda`-Umgebung|Global, aber isoliert|
|**Einrichtung**|Schwerer (Anaconda nötig)|Einfach & schnell mit `pipx`|
|**Kompatibilität**|Mehr Kontrolle|Abhängigkeit von `pip`-Kompatibilität|

---

### 🧩 **Empfehlung**:

1. **Für Projekte und Entwicklungsumgebungen**: Nutze **conda**.
2. **Für einfache, globale Installationen**: Nutze **pipx**.

Falls du ohnehin schon **Anaconda/Miniconda** verwendest, bleib bei `conda`. Andernfalls ist `pipx` eine schlanke Alternative.