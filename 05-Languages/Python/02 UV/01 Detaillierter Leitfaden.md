
> **uv** ist ein extrem schneller Python-Paket- und Projektmanager, geschrieben in Rust.  
> Er ersetzt `pip`, `pip-tools`, `pipx`, `pyenv`, `virtualenv` und `poetry` in einem einzigen Werkzeug.
## 1. Installation unter Nushell

### Empfohlene Methode – offizielles Installationsskript

uv liefert ein Shell-Skript, das direkt in Nushell ausgeführt werden kann:

```nushell
# Installationsskript herunterladen und ausführen
curl -LsSf https://astral.sh/uv/install.sh | sh
```

> Das Skript installiert uv nach `~/.local/bin/` (Linux/macOS) bzw. `%USERPROFILE%\.local\bin\` (Windows).

### Alternative: via cargo (Rust-Toolchain vorhanden)

```nushell
cargo install uv
```

### Alternative: via pip (in bestehender Python-Umgebung)

```nushell
pip install uv
```

### Alternative: via paru (CachyOS / Arch Linux)

```nushell
paru -S uv
```

### Installation prüfen

```nushell
uv --version
# Ausgabe z. B.: uv 0.5.x (...)
```

---

## 2. Shell-Integration in Nushell

uv kann Autovervollständigung für Nushell generieren. Diesen Block in `config.nu` eintragen:

```nushell
# In ~/.config/nushell/config.nu einfügen:
uv generate-shell-completion nushell | save --force ~/.config/nushell/completions/uv.nu
```

Dann die Completions in `config.nu` laden:

```nushell
# Oben in config.nu:
source ~/.config/nushell/completions/uv.nu
```

### PATH sicherstellen

Falls uv nach der Installation nicht gefunden wird:

```nushell
# In env.nu oder config.nu:
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.local/bin")
```

---

## 3. Python-Interpreter verwalten

uv kann Python-Versionen vollständig selbst verwalten – unabhängig von `pyenv`.

### Verfügbare Python-Versionen anzeigen

```nushell
uv python list
# Zeigt alle installierbaren und bereits installierten Versionen
```

### Alle installierten Versionen anzeigen

```nushell
uv python list --only-installed
```

### Spezifische Python-Version installieren

```nushell
uv python install 3.12
# Mehrere Versionen auf einmal:
uv python install 3.11 3.12 3.13
```

### Python-Version deinstallieren

```nushell
uv python uninstall 3.11
```

### Pfad zu einem installierten Interpreter ermitteln

```nushell
uv python find 3.12
# Gibt den vollständigen Pfad aus, z. B.:
# /home/user/.local/share/uv/python/cpython-3.12.../bin/python3.12
```

### Python-Implementierungen

uv unterstützt neben CPython auch PyPy:

```nushell
uv python install pypy@3.11
```

---

## 4. Standard-Python konfigurieren

### Globales Standard-Python festlegen

```nushell
uv python pin 3.12
# Schreibt die Version in ~/.python-version (globale Vorgabe)
```

### Projektspezifisches Python festlegen

Im Projektverzeichnis:

```nushell
uv python pin 3.11
# Schreibt eine lokale .python-version Datei im aktuellen Verzeichnis
```

### Standard in uv.toml (global) setzen

Datei `~/.config/uv/uv.toml` anlegen oder erweitern:

```toml
[python]
# Bevorzugte Python-Version, wenn keine andere Angabe vorliegt
python-preference = "managed"   # uv verwaltet Python selbst
# Standard-Version für neue Projekte:
# (wird über 'uv python pin' in der jeweiligen .python-version gesetzt)
```

Mögliche Werte für `python-preference`:

| Wert | Bedeutung |
|------|-----------|
| `managed` | uv-verwaltete Interpreter bevorzugen |
| `system` | System-Python bevorzugen |
| `only-managed` | Nur uv-verwaltete Interpreter verwenden |
| `only-system` | Nur System-Python verwenden |

### Umgebungsvariable für aktuelle Session

```nushell
$env.UV_PYTHON = "3.12"
```

---

## 5. Neues Projekt anlegen

### Einfaches Projekt (Anwendung)

```nushell
uv init mein-projekt
cd mein-projekt
```

Erstellt folgende Struktur:

```
mein-projekt/
├── .python-version   # pinned Python-Version
├── pyproject.toml    # Projektmetadaten & Abhängigkeiten
├── README.md
└── main.py           # Einstiegspunkt
```

### Bibliotheks-Projekt

```nushell
uv init --lib meine-bibliothek
```

Erstellt eine `src/`-Layout-Struktur, geeignet für PyPI-Pakete.

### Projekt ohne Einstiegspunkt (nur Abhängigkeitsverwaltung)

```nushell
uv init --no-package mein-skript-ordner
```

### Python-Version direkt bei init festlegen

```nushell
uv init --python 3.12 mein-projekt
```

### Virtuelle Umgebung erzeugen und Abhängigkeiten synchronisieren

```nushell
cd mein-projekt
uv sync
# Legt .venv/ an und installiert alle Abhängigkeiten aus pyproject.toml
```

### Skript ausführen

```nushell
uv run main.py
# Führt main.py im Kontext der Projektumgebung aus (kein manuelles activate nötig)
```

---

## 6. Bestehendes Projekt auf uv umstellen

### Schritt 1 – pyproject.toml prüfen / anlegen

Falls noch keine `pyproject.toml` vorhanden ist:

```nushell
uv init --no-package .
# Initialisiert uv im aktuellen Verzeichnis ohne neue Dateien zu überschreiben
```

### Schritt 2 – Abhängigkeiten aus requirements.txt importieren

```nushell
uv add $(open requirements.txt | lines | str join " ")
# Oder eleganter mit xargs-Äquivalent in Nushell:
open requirements.txt | lines | each { |pkg| uv add $pkg }
```

Oder direkt:

```nushell
uv pip install -r requirements.txt
# Installiert in die aktuelle .venv ohne pyproject.toml zu ändern
```

### Schritt 3 – requirements.txt durch uv-Lock ersetzen

```nushell
uv lock
# Erzeugt uv.lock – die reproduzierbare Sperrdatei (Versionskontrolle empfohlen)
```

### Schritt 4 – Alte Umgebung entfernen

```nushell
rm -rf venv/ .venv/ __pycache__/
uv sync
# Frische Umgebung auf Basis von pyproject.toml + uv.lock
```

### Schritt 5 – poetry/pipenv Migration

Von `poetry.lock` / `Pipfile.lock`:

```nushell
# uv liest pyproject.toml direkt (poetry-Format wird erkannt)
# Einfach ausführen:
uv sync
```

---

## 7. Virtuelle Umgebungen

### Umgebung manuell anlegen

```nushell
uv venv
# Legt .venv/ im aktuellen Verzeichnis an

uv venv --python 3.11
# Mit spezifischer Python-Version

uv venv pfad/zur/umgebung
# An einem benutzerdefinierten Pfad
```

### Umgebung aktivieren (Nushell)

```nushell
overlay use .venv/bin/activate.nu
# Oder für schnellen Zugriff ohne permanente Aktivierung:
uv run python   # startet Python direkt in der Projektumgebung
```

> **Hinweis:** Bei Verwendung von `uv run` ist ein manuelles Aktivieren der `.venv` in den meisten Fällen nicht notwendig.

### Umgebung deaktivieren

```nushell
deactivate
```

---

## 8. Pakete installieren und verwalten

### Paket zum Projekt hinzufügen

```nushell
uv add requests
# Fügt requests zu pyproject.toml hinzu und aktualisiert uv.lock
```

### Mit Versionsangabe

```nushell
uv add "django>=5.0,<6.0"
uv add "numpy==1.26.4"
```

### Entwicklungsabhängigkeit hinzufügen

```nushell
uv add --dev pytest ruff black
# Landet in [tool.uv.dev-dependencies] in pyproject.toml
```

### Optionale Abhängigkeitsgruppe

```nushell
uv add --optional docs sphinx sphinx-rtd-theme
```

### Paket entfernen

```nushell
uv remove requests
```

### Alle Abhängigkeiten synchronisieren

```nushell
uv sync
# Installiert / deinstalliert Pakete, bis die Umgebung exakt uv.lock entspricht

uv sync --dev
# Inkl. Entwicklungsabhängigkeiten

uv sync --frozen
# Strikte Synchronisation, kein Update von uv.lock erlaubt (CI-Einsatz)
```

### Lock-Datei aktualisieren

```nushell
uv lock --upgrade
# Aktualisiert alle Pakete auf neueste kompatible Versionen

uv lock --upgrade-package requests
# Nur ein einzelnes Paket aktualisieren
```

### Installierte Pakete auflisten

```nushell
uv pip list
```

### Paketinformationen anzeigen

```nushell
uv pip show requests
```

### Veraltete Pakete finden

```nushell
uv pip list --outdated
```

---

## 9. Skripte direkt ausführen

uv kann einzelne Skripte mit eingebetteten Abhängigkeiten ausführen – ohne Projekt:

### Skript mit Abhängigkeiten inline

```python
# hello.py
# /// script
# requires-python = ">=3.11"
# dependencies = ["requests", "rich"]
# ///

import requests
from rich import print
print(requests.get("https://httpbin.org/get").json())
```

```nushell
uv run hello.py
# uv installiert temporär requests + rich und führt das Skript aus
```

### Remote-Skript direkt ausführen

```nushell
uv run https://example.com/script.py
```

### Einmalig ein Tool ausführen (ohne Installation)

```nushell
uvx ruff check .
uvx black --check src/
# uvx ist ein Alias für: uv tool run
```

---

## 10. Tools global installieren (pipx-Ersatz)

### Tool installieren

```nushell
uv tool install ruff
uv tool install black
uv tool install httpie
```

### Tool mit spezifischer Python-Version

```nushell
uv tool install --python 3.12 ruff
```

### Alle installierten Tools auflisten

```nushell
uv tool list
```

### Tool aktualisieren

```nushell
uv tool upgrade ruff
uv tool upgrade --all
```

### Tool deinstallieren

```nushell
uv tool uninstall ruff
```

### Tool-Binärdateien im PATH

uv installiert Tool-Binärdateien standardmäßig nach `~/.local/bin/`.  
Sicherstellen, dass dieser Pfad im Nushell-PATH liegt:

```nushell
# In env.nu:
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.local/bin")
```

---

## 11. Konfigurationsdatei uv.toml

### Speicherorte (Priorität absteigend)

| Pfad | Geltungsbereich |
|------|-----------------|
| `<projekt>/.uv/uv.toml` oder `<projekt>/uv.toml` | Projektlokal |
| `~/.config/uv/uv.toml` | Benutzer (global) |
| `/etc/uv/uv.toml` | Systemweit |

### Beispiel: `~/.config/uv/uv.toml`

```toml
# Python-Verwaltung
[python]
python-preference = "managed"   # uv verwaltet Python-Versionen

# Standardverhalten beim Paketmanagement
[pip]
index-url = "https://pypi.org/simple"
# extra-index-url = ["https://pypi.example.com/simple"]  # privater Index

# Cache-Konfiguration
[cache]
# cache-dir = "~/.cache/uv"   # Standard; kann geändert werden

# Verhalten bei uv sync / install
[install]
compile-bytecode = true        # .pyc-Dateien vorab kompilieren (schnellere Starts)

# Verhalten bei neuen Projekten
[init]
# author-from = "git"          # Autorinfos aus Git-Konfiguration übernehmen
```

### Wichtige Umgebungsvariablen

| Variable | Bedeutung |
|----------|-----------|
| `UV_PYTHON` | Standard-Python-Version überschreiben |
| `UV_CACHE_DIR` | Cache-Verzeichnis ändern |
| `UV_INDEX_URL` | Alternativer PyPI-Index |
| `UV_NO_CACHE` | Cache deaktivieren (`1` = an) |
| `UV_FROZEN` | `uv sync --frozen` als Standard erzwingen |
| `UV_PROJECT_ENVIRONMENT` | Pfad zur `.venv` überschreiben |
| `UV_LINK_MODE` | `copy`, `hardlink`, `symlink`, `clone` |

---

## 12. Wichtige Befehle auf einen Blick

### Installation & Setup

| Befehl | Beschreibung |
|--------|--------------|
| `uv self update` | uv selbst auf die neueste Version aktualisieren |
| `uv self uninstall` | uv vollständig deinstallieren |
| `uv generate-shell-completion nushell` | Nushell-Completions generieren |

### Python-Verwaltung

| Befehl | Beschreibung |
|--------|--------------|
| `uv python list` | Alle verfügbaren Python-Versionen anzeigen |
| `uv python list --only-installed` | Nur installierte Versionen anzeigen |
| `uv python install 3.12` | Python 3.12 herunterladen und installieren |
| `uv python uninstall 3.11` | Python 3.11 entfernen |
| `uv python find` | Aktuell verwendeten Interpreter anzeigen |
| `uv python find 3.12` | Pfad zu Python 3.12 ausgeben |
| `uv python pin 3.12` | Python-Version in `.python-version` fixieren |

### Projektverwaltung

| Befehl | Beschreibung |
|--------|--------------|
| `uv init mein-projekt` | Neues Projekt anlegen |
| `uv init --lib mein-paket` | Bibliotheks-Projekt (src-Layout) anlegen |
| `uv init --python 3.12 .` | Projekt im aktuellen Verzeichnis initialisieren |
| `uv sync` | Umgebung mit `pyproject.toml` + `uv.lock` synchronisieren |
| `uv sync --frozen` | Synchronisieren ohne `uv.lock` zu aktualisieren (CI) |
| `uv lock` | `uv.lock` erzeugen / aktualisieren |
| `uv lock --upgrade` | Alle Pakete auf neueste Versionen upgraden |
| `uv run <skript>` | Skript im Projektkontext ausführen |
| `uv run --python 3.11 skript.py` | Skript mit spezifischer Python-Version ausführen |

### Paketverwaltung

| Befehl | Beschreibung |
|--------|--------------|
| `uv add requests` | Paket hinzufügen und `pyproject.toml` aktualisieren |
| `uv add --dev pytest` | Entwicklungsabhängigkeit hinzufügen |
| `uv remove requests` | Paket entfernen |
| `uv pip install requests` | Paket direkt in `.venv` installieren (ohne `pyproject.toml`) |
| `uv pip install -r requirements.txt` | Aus `requirements.txt` installieren |
| `uv pip uninstall requests` | Paket direkt deinstallieren |
| `uv pip list` | Installierte Pakete auflisten |
| `uv pip show requests` | Details zu einem Paket anzeigen |
| `uv pip freeze` | Installierte Pakete im `requirements.txt`-Format ausgeben |
| `uv pip compile requirements.in` | Abhängigkeiten auflösen (wie `pip-compile`) |

### Virtuelle Umgebungen

| Befehl | Beschreibung |
|--------|--------------|
| `uv venv` | `.venv` im aktuellen Verzeichnis anlegen |
| `uv venv --python 3.11` | `.venv` mit bestimmter Python-Version |
| `uv venv pfad/` | `.venv` an benutzerdefiniertem Pfad anlegen |

### Tools (global)

| Befehl | Beschreibung |
|--------|--------------|
| `uv tool install ruff` | Tool global installieren |
| `uv tool list` | Installierte Tools auflisten |
| `uv tool upgrade ruff` | Tool aktualisieren |
| `uv tool upgrade --all` | Alle Tools aktualisieren |
| `uv tool uninstall ruff` | Tool deinstallieren |
| `uvx ruff check .` | Tool einmalig ausführen ohne Installation |

### Diagnose & Cache

| Befehl | Beschreibung |
|--------|--------------|
| `uv cache dir` | Cache-Verzeichnis anzeigen |
| `uv cache clean` | Gesamten Cache leeren |
| `uv cache prune` | Veraltete Cache-Einträge entfernen |
| `uv tree` | Abhängigkeitsbaum des Projekts anzeigen |
| `uv version` | uv-Version anzeigen |

---

## 13. Tipps & Besonderheiten

### Geschwindigkeit

uv ist 10–100× schneller als pip, da es in Rust geschrieben ist, parallele Downloads nutzt und einen effizienten globalen Cache verwendet. Gleiche Pakete werden zwischen Projekten nur einmal heruntergeladen.

### uv.lock in Versionskontrolle

Die Datei `uv.lock` sollte **immer** in Git eingecheckt werden. Sie sichert reproduzierbare Builds – ähnlich wie `poetry.lock` oder `Cargo.lock`.

### Kein activate notwendig

Mit `uv run` wird die `.venv` automatisch erkannt und genutzt. Das manuelle Aktivieren entfällt für die meisten Workflows.

### pyproject.toml bleibt Standard

uv arbeitet vollständig mit dem PEP-517/518-Standard. `pyproject.toml` ist die einzige Konfigurationsdatei für das Projekt.

### Workspace-Projekte (Monorepo)

```toml
# Im Root-pyproject.toml:
[tool.uv.workspace]
members = ["packages/*"]
```

```nushell
uv sync --all-packages
# Synchronisiert alle Workspace-Member
```

### Abhängigkeiten aus Git-Repositories

```nushell
uv add "git+https://github.com/user/repo.git"
uv add "git+https://github.com/user/repo.git@main"
uv add "git+https://github.com/user/repo.git@v1.2.3"
```

### Lokale Pakete einbinden

```nushell
uv add --editable ../mein-lokales-paket
# Entspricht: pip install -e ../mein-lokales-paket
```

### Nushell-Workflow Kurzübersicht

```nushell
# Typischer Projektstart mit uv in Nushell:
uv init mein-projekt
cd mein-projekt
uv python pin 3.12
uv add requests rich
uv add --dev pytest ruff
uv sync
uv run main.py
```

---

*Letzte Aktualisierung: März 2026 · Dokumentation: [docs.astral.sh/uv](https://docs.astral.sh/uv)*
