# JupyterLite Installation mit allen Python-Kernels

## Vollständige Installationsanleitung für Ubuntu mit uv und Nushell

Dieses Dokument beschreibt die komplette Einrichtung einer lokalen JupyterLite-Installation mit allen verfügbaren Python-Kernels (Pyodide und Xeus-Python) unter Ubuntu. Die Installation nutzt `uv` für Python-Paketverwaltung und Nushell als Shell-Umgebung.

### Voraussetzungen

- **Ubuntu System** (getestet auf Ubuntu 20.04+)
- **uv** (Python-Paketmanager) bereits installiert
- **cargo/Rust** bereits installiert
- **Nushell** installiert

---

## 1. Projektverzeichnis erstellen

```bash
mkdir -p ~/jupyterlite-project
cd ~/jupyterlite-project
```

---

## 2. Virtuelle Umgebung mit uv erstellen

```bash
uv venv .venv
```

---

## 3. Virtuelle Umgebung in Nushell aktivieren

In Nushell verwendet man `overlay` statt `source`:

```nu
overlay use .venv/bin/activate.nu
```

**Überprüfung der Aktivierung:**

```nu
which python
```

Die Ausgabe sollte den Pfad zur `.venv` zeigen.

---

## 4. JupyterLite Core und alle Python-Kernels installieren

### 4.1 Basis-Installation

```bash
uv pip install jupyterlite-core
```

### 4.2 Pyodide Kernel installieren

Der Pyodide-Kernel ermöglicht dynamisches Installieren von Paketen zur Laufzeit mit `piplite`:

```bash
uv pip install jupyterlite-pyodide-kernel
```

### 4.3 Xeus-Python Kernel installieren

Der Xeus-Kernel unterstützt das Vorinstallieren von Paketen und `time.sleep()`:

```bash
uv pip install jupyterlite-xeus
```

### 4.4 Zusätzliche nützliche Pakete (optional)

```bash
uv pip install jupyterlab jupyter-server
```

---

## 5. Projektstruktur einrichten

```bash
mkdir -p files
mkdir -p pypi
```

**Verzeichnisstruktur:**

```
~/jupyterlite-project/
├── .venv/
├── files/           # Hier werden Notebooks und Daten abgelegt
├── pypi/            # Hier können eigene Python-Wheels abgelegt werden
├── environment.yml  # Konfiguration für Xeus-Python
└── jupyter-lite.json # Optionale Konfiguration
```

---

## 6. Xeus-Python Kernel mit vorinstallierten Paketen konfigurieren

Erstelle eine `environment.yml` Datei im Projektverzeichnis:

```yaml
name: xeus-lite-wasm
channels:
  - https://repo.prefix.dev/emscripten-forge
  - https://repo.prefix.dev/conda-forge
dependencies:
  - xeus-python
  - numpy
  - pandas
  - matplotlib
  - scipy
  - scikit-learn
  - ipywidgets
  - plotly
```

**Datei erstellen:**

```bash
cat > environment.yml << 'EOF'
name: xeus-lite-wasm
channels:
  - https://repo.prefix.dev/emscripten-forge
  - https://repo.prefix.dev/conda-forge
dependencies:
  - xeus-python
  - numpy
  - pandas
  - matplotlib
  - scipy
  - scikit-learn
  - ipywidgets
  - plotly
EOF
```

---

## 7. JupyterLite Website bauen

### 7.1 Mit beiden Kernels (Pyodide + Xeus-Python)

```bash
jupyter lite build --output-dir dist --XeusAddon.environment_file=environment.yml
```

### 7.2 Nur mit Pyodide Kernel

Falls du nur Pyodide verwenden möchtest:

```bash
jupyter lite build --output-dir dist
```

**Build-Prozess:**
- Der Befehl erstellt alle statischen Assets im `dist/` Verzeichnis
- Xeus-Python lädt die Pakete aus `environment.yml` herunter
- Der Prozess kann 5-15 Minuten dauern (beim ersten Mal)

---

## 8. Lokalen Webserver starten

### 8.1 Mit JupyterLite's eingebautem Server

```bash
jupyter lite serve --output-dir dist
```

**Standard-URL:** `http://localhost:8000`

### 8.2 Mit Python's http.server (Alternative)

```bash
cd dist
python -m http.server 8080 --bind 127.0.0.1
```

Dann öffne im Browser: `http://localhost:8080`

### 8.3 Server-Zugriff im Netzwerk (optional)

Um JupyterLite im lokalen Netzwerk verfügbar zu machen:

```bash
# Eigene IP-Adresse ermitteln
ip addr show | grep "inet " | grep -v 127.0.0.1

# Server mit spezifischer IP starten
python -m http.server 8080 --bind 192.168.1.XXX
```

---

## 9. Beispiel-Notebook erstellen

Erstelle eine Datei `files/test_notebook.ipynb`:

```json
{
  "cells": [
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# Teste Pyodide Kernel mit piplite\n",
        "import sys\n",
        "print(f\"Python {sys.version}\")\n",
        "print(f\"Platform: {sys.platform}\")"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# Installiere Paket zur Laufzeit (nur Pyodide)\n",
        "import piplite\n",
        "await piplite.install('requests')\n",
        "import requests\n",
        "print(\"Requests erfolgreich installiert!\")"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "# Teste vorinstallierte Pakete (Xeus-Python)\n",
        "import numpy as np\n",
        "import pandas as pd\n",
        "import matplotlib.pyplot as plt\n",
        "\n",
        "data = np.random.randn(100)\n",
        "plt.hist(data, bins=20)\n",
        "plt.title('Histogram Test')\n",
        "plt.show()"
      ]
    }
  ],
  "metadata": {
    "kernelspec": {
      "display_name": "Python (Pyodide)",
      "language": "python",
      "name": "python"
    },
    "language_info": {
      "name": "python",
      "version": "3.11"
    }
  },
  "nbformat": 4,
  "nbformat_minor": 4
}
```

**Notebook erstellen:**

```bash
cat > files/test_notebook.ipynb << 'EOF'
{
  "cells": [
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": ["import sys\nprint(f'Python {sys.version}')\nprint(f'Platform: {sys.platform}')"]
    }
  ],
  "metadata": {
    "kernelspec": {
      "display_name": "Python (Pyodide)",
      "language": "python",
      "name": "python"
    }
  },
  "nbformat": 4,
  "nbformat_minor": 4
}
EOF
```

Nach dem Rebuild wird das Notebook in JupyterLite verfügbar sein.

---

## 10. JupyterLite neu bauen nach Änderungen

Nach Änderungen an `files/` oder `environment.yml`:

```bash
# Virtuelles Environment aktivieren (falls nicht aktiv)
overlay use .venv/bin/activate.nu

# Neu bauen
jupyter lite build --output-dir dist --XeusAddon.environment_file=environment.yml

# Server neu starten
jupyter lite serve --output-dir dist
```

---

## 11. Vollständiges Nushell-Installations-Skript

Speichere folgendes Skript als `setup_jupyterlite.nu`:

```nu
#!/usr/bin/env nu

# JupyterLite Setup-Skript für Nushell
def main [] {
    print "🚀 JupyterLite Installation startet..."
    
    # 1. Projektverzeichnis erstellen
    print "📁 Erstelle Projektverzeichnis..."
    mkdir ~/jupyterlite-project
    cd ~/jupyterlite-project
    
    # 2. Virtuelle Umgebung erstellen
    print "🐍 Erstelle virtuelle Umgebung mit uv..."
    uv venv .venv
    
    # 3. Aktiviere virtuelle Umgebung
    print "✅ Aktiviere virtuelle Umgebung..."
    overlay use .venv/bin/activate.nu
    
    # 4. Installiere JupyterLite und Kernels
    print "📦 Installiere JupyterLite Core..."
    uv pip install jupyterlite-core
    
    print "📦 Installiere Pyodide Kernel..."
    uv pip install jupyterlite-pyodide-kernel
    
    print "📦 Installiere Xeus-Python Kernel..."
    uv pip install jupyterlite-xeus
    
    # 5. Erstelle Verzeichnisstruktur
    print "📂 Erstelle Projektstruktur..."
    mkdir files
    mkdir pypi
    
    # 6. Erstelle environment.yml
    print "⚙️  Erstelle environment.yml..."
    "name: xeus-lite-wasm
channels:
  - https://repo.prefix.dev/emscripten-forge
  - https://repo.prefix.dev/conda-forge
dependencies:
  - xeus-python
  - numpy
  - pandas
  - matplotlib
  - scipy
  - scikit-learn
  - ipywidgets
  - plotly" | save environment.yml
    
    # 7. Baue JupyterLite
    print "🏗️  Baue JupyterLite Website (dies kann einige Minuten dauern)..."
    jupyter lite build --output-dir dist --XeusAddon.environment_file=environment.yml
    
    # 8. Erfolgreiche Installation
    print "✅ Installation abgeschlossen!"
    print ""
    print "🌐 Starte Server mit:"
    print "   jupyter lite serve --output-dir dist"
    print ""
    print "📝 Notebooks können in ./files/ abgelegt werden"
    print "🔄 Nach Änderungen: jupyter lite build --output-dir dist --XeusAddon.environment_file=environment.yml"
}

# Skript ausführen
main
```

**Skript ausführbar machen und ausführen:**

```bash
chmod +x setup_jupyterlite.nu
./setup_jupyterlite.nu
```

---

## 12. Verfügbare Kernels und Unterschiede

### Pyodide Kernel (`jupyterlite-pyodide-kernel`)

**Vorteile:**
- Dynamische Paketinstallation mit `piplite` zur Laufzeit
- Unterstützt IPython-Magics (`%pip install`, `%%time`, etc.)
- Matplotlib inline-Backend verfügbar
- Große Auswahl an vorcompilierten Paketen

**Einschränkungen:**
- `time.sleep()` funktioniert nicht
- Keine Vorinstallation von Paketen möglich
- Nur Pyodide-kompatible Pakete

**Verwendung im Notebook:**
```python
import piplite
await piplite.install('package-name')
```

### Xeus-Python Kernel (`jupyterlite-xeus`)

**Vorteile:**
- Vorinstallation von Paketen über `environment.yml`
- `time.sleep()` funktioniert
- Zugriff auf emscripten-forge und conda-forge Pakete
- Bessere Performance für numerische Operationen

**Einschränkungen:**
- Keine dynamische Paketinstallation zur Laufzeit (noch)
- Kleinere Paketauswahl als Pyodide

**Konfiguration:**
Pakete werden in `environment.yml` definiert und beim Build vorinstalliert.

---

## 13. Erweiterte Konfiguration

### 13.1 Eigene Python-Wheels hinzufügen

Platziere `.whl` Dateien im `pypi/` Verzeichnis:

```bash
# Beispiel: eigenes Paket
cp /pfad/zu/meinpaket-1.0-py3-none-any.whl pypi/
```

### 13.2 JupyterLite-Konfiguration (jupyter-lite.json)

Erstelle `jupyter-lite.json` für erweiterte Optionen:

```json
{
  "jupyter-lite-schema-version": 0,
  "jupyter-config-data": {
    "appName": "Mein JupyterLite",
    "appVersion": "1.0.0",
    "disabledExtensions": [],
    "settingsOverrides": {
      "@jupyterlab/apputils-extension:themes": {
        "theme": "JupyterLab Dark"
      }
    }
  }
}
```

### 13.3 Mehrere Xeus-Kernels

Füge weitere Xeus-Kernels in `environment.yml` hinzu:

```yaml
name: xeus-multi-kernel
channels:
  - https://repo.prefix.dev/emscripten-forge
  - https://repo.prefix.dev/conda-forge
dependencies:
  - xeus-python
  - xeus-lua
  - xeus-sqlite
  - numpy
  - pandas
```

---

## 14. Troubleshooting

### Problem: "No kernel available"

**Lösung:**
```bash
# Überprüfe installierte Kernels
jupyter kernelspec list

# Rebuild mit verbose output
jupyter lite build --output-dir dist --debug
```

### Problem: Xeus-Python Build schlägt fehl

**Lösung:**
```bash
# Überprüfe environment.yml Syntax
cat environment.yml

# Teste nur mit Basis-Paketen
jupyter lite build --output-dir dist --XeusAddon.environment_file=environment.yml --debug
```

### Problem: WASM-Fehler im Browser

**Lösung:**
- Stelle sicher, dass der Server WASM-Dateien mit korrektem MIME-Type `application/wasm` ausliefert
- Verwende `jupyter lite serve` statt Python's `http.server`
- Bei Firewall-Problemen: Überprüfe Browser-Konsole (F12)

### Problem: Nushell overlay nicht gefunden

**Lösung:**
```nu
# Prüfe, ob activate.nu existiert
ls .venv/bin/activate.nu

# Falls nicht, neu erstellen
uv venv .venv --clear
```

---

## 15. Wartung und Updates

### Pakete aktualisieren

```bash
# Virtuelle Umgebung aktivieren
overlay use .venv/bin/activate.nu

# Alle Pakete aktualisieren
uv pip install --upgrade jupyterlite-core jupyterlite-pyodide-kernel jupyterlite-xeus

# Rebuild
jupyter lite build --output-dir dist --XeusAddon.environment_file=environment.yml
```

### Cache leeren

```bash
rm -rf dist/
jupyter lite build --output-dir dist --XeusAddon.environment_file=environment.yml
```

---

## 16. Nützliche Befehle

```bash
# Status überprüfen
jupyter lite --version

# Alle verfügbaren Optionen anzeigen
jupyter lite build --help

# Spezifischen Port für Server
jupyter lite serve --output-dir dist --port 8888

# Build mit Log-Ausgabe
jupyter lite build --output-dir dist --log-level DEBUG
```

---

## Zusammenfassung

Diese Anleitung erstellt eine vollständige JupyterLite-Installation mit:

✅ **Pyodide Kernel** - für dynamische Paketinstallation  
✅ **Xeus-Python Kernel** - für vorinstallierte Pakete  
✅ **uv-verwaltete virtuelle Umgebung** - für saubere Paketverwaltung  
✅ **Nushell-kompatible Skripte** - für moderne Shell-Umgebung  
✅ **Lokaler Webserver** - für Entwicklung und Testing  

**Viel Erfolg mit JupyterLite! 🚀**