> Von der Einrichtung bis zum professionellen Repository
> Ein umfassender Leitfaden für Python-Entwickler*

---
## 1. GitHub-Account einrichten und nutzen

### 1.1 Web-Interface (github.com)

**Schritt-für-Schritt Anleitung:**

1. **Registrierung**
   - Besuche [github.com](https://github.com)
   - Klicke auf "Sign up"
   - Wähle einen aussagekräftigen Benutzernamen (Tipp: Verwende deinen echten Namen oder eine professionelle Variante)
   - Verwende eine starke, eindeutige E-Mail-Adresse
   - Erstelle ein sicheres Passwort

2. **Account-Konfiguration**
   - E-Mail-Adresse verifizieren
   - **Zwei-Faktor-Authentifizierung (2FA) einrichten** (dringend empfohlen!)
   - Profil vervollständigen mit Foto und Bio
   - SSH-Schlüssel hinzufügen für sichere Authentifizierung

**GitHub-Hilfe:** [Getting started with your GitHub account](https://docs.github.com/en/get-started/onboarding/getting-started-with-your-github-account)

### 1.2 GitHub Desktop App

**Installation:**

**Windows:**
1. Besuche [desktop.github.com](https://desktop.github.com)
2. Lade "Download for Windows" herunter
3. Führe die .exe-Datei aus
4. Melde dich mit deinem GitHub-Account an

**macOS:**
1. Besuche [desktop.github.com](https://desktop.github.com)
2. Lade "Download for macOS" herunter
3. Entpacke die .zip-Datei und verschiebe GitHub Desktop in den Anwendungsordner
4. Starte die App und melde dich an

**Vorteile von GitHub Desktop:**
- Grafische Benutzeroberfläche für Git-Operationen
- Einfache Visualisierung von Changes und Branches
- Integrierte Konfliktlösung
- Perfekt für Einsteiger geeignet

**GitHub-Hilfe:** [Installing GitHub Desktop](https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop/installing-github-desktop)

### 1.3 GitHub CLI (Kommandozeile)

**Installation:**

**Windows (mit Winget):**
```bash
winget install --id GitHub.cli
```

**macOS (mit Homebrew):**
```bash
brew install gh
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install gh
```

**Authentifizierung:**
```bash
gh auth login
```

**Nützliche CLI-Befehle:**
```bash
# Repository klonen
gh repo clone username/repository-name

# Neues Repository erstellen
gh repo create my-python-project --public

# Repository anzeigen
gh repo view

# Issues auflisten
gh issue list

# Pull Request erstellen
gh pr create --title "Feature: Add new functionality"
```

**GitHub-Hilfe:** [GitHub CLI quickstart](https://docs.github.com/en/github-cli/github-cli/quickstart)

---

## 2. Repositories erstellen und verwalten

### 2.1 Repository über Web-Interface erstellen

**Schritt-für-Schritt:**

1. Klicke auf das **"+"** Symbol oben rechts → "New repository"
2. **Repository-Name:** Wähle einen beschreibenden Namen (z.B. `weather-forecast-app`)
3. **Beschreibung:** Kurze Erklärung des Projekts
4. **Sichtbarkeit:** 
   - **Public:** Für Open-Source-Projekte
   - **Private:** Für persönliche/kommerzielle Projekte
5. **Initialisierung:**
   - ✅ "Add a README file"
   - ✅ "Add .gitignore" → Python auswählen
   - ✅ "Choose a license" → siehe Abschnitt 3

### 2.2 Python-spezifische Repository-Struktur

**Beispiel-Struktur für Python-Projekte:**
```
my-python-project/
├── README.md
├── LICENSE
├── .gitignore
├── requirements.txt
├── setup.py
├── src/
│   └── my_package/
│       ├── __init__.py
│       └── main.py
├── tests/
│   └── test_main.py
├── docs/
└── examples/
```

### 2.3 Repository-Management Best Practices

**Branching-Strategien:**
- `main` oder `master` für Produktionscode
- `develop` für Entwicklung
- `feature/feature-name` für neue Features
- `bugfix/issue-number` für Fehlerbehebungen

**Commit-Nachrichten (Deutsch):**
```bash
# Gut
git commit -m "Feat: Wettervorhersage-API hinzufügen"
git commit -m "Fix: Behebe Fehler in Datenvalidierung"
git commit -m "Docs: README mit Installationsanweisungen aktualisieren"

# Schlecht
git commit -m "changes"
git commit -m "fix"
```

**GitHub-Hilfe:** [Creating a new repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository)

---

## 3. Die richtige Lizenz auswählen

### 3.1 Wichtige Lizenz-Typen für Python-Projekte

| Lizenz | Verwendung | Bedingungen | Python-Beispiele |
|--------|------------|-------------|-------------------|
| **MIT** | Maximal permissiv | Nur Attribution erforderlich | Django, Flask, Requests |
| **Apache 2.0** | Patentschutz inklusive | Attribution + Änderungslog | TensorFlow, Airflow |
| **GPL v3** | Copyleft | Derivatives müssen GPL sein | - |
| **BSD 3-Clause** | Akademisch freundlich | Attribution + Endorsement-Verbot | NumPy, SciPy |
| **Creative Commons 0** | Public Domain | Keine Bedingungen | Daten-Repositories |

### 3.2 Lizenz auswählen - Entscheidungsbaum

**Für Python-Open-Source-Projekte:**

1. **Willst du maximale Verbreitung?** → MIT License
2. **Brauchst du Patentschutz?** → Apache 2.0
3. **Sollen Derivatives auch Open Source sein?** → GPL v3
4. **Ist es ein wissenschaftliches Projekt?** → BSD 3-Clause
5. **Sind es nur Daten/Beispiele?** → CC0

### 3.3 Lizenz hinzufügen

**Über GitHub Web-Interface:**
1. Erstelle eine neue Datei namens "LICENSE"
2. GitHub zeigt automatisch "Choose a license template"
3. Wähle die passende Lizenz aus
4. GitHub fügt automatisch deine Daten ein

**Python-spezifischer Tipp:** 
Für pip-installierbare Pakete sollte die Lizenz auch in `setup.py` definiert werden:

```python
setup(
    name="my-package",
    license="MIT",
    # ...
)
```

**GitHub-Hilfe:** [Licensing a repository](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository)

---

## 4. Eine professionelle README strukturieren

### 4.1 README-Template für Python-Projekte

````markdown
# Projektname

[![[52d7c8a8c47838a1a4fd65212f48bacb_MD5.svg]]](https://www.python.org)
[![[0d356e72fcfaae41be0d7adf6fad1c69_MD5.svg]]](https://opensource.org/licenses/MIT)
[![Tests](https://github.com/username/project/workflows/tests/badge.svg)](https://github.com/username/project/actions)

Eine kurze, prägnante Beschreibung deines Python-Projekts.

## Inhaltsverzeichnis

- [Installation](#installation)
- [Verwendung](#verwendung)
- [Beispiele](#beispiele)
- [API-Dokumentation](#api-dokumentation)
- [Mitwirken](#mitwirken)
- [Tests](#tests)
- [Lizenz](#lizenz)

## Installation

### Voraussetzungen

- Python 3.8 oder höher
- pip (Python Package Installer)

### Via pip installieren

```bash
pip install dein-paket-name
```
### Aus den Quellen installieren

```bash
git clone https://github.com/username/projekt-name.git
cd projekt-name
pip install -r requirements.txt
pip install -e .
```
## Verwendung

### Grundlegende Verwendung

```python
from dein_paket import HauptKlasse

# Beispiel-Code
app = HauptKlasse()
result = app.process_data("beispiel.txt")
print(result)
```

### Kommandozeile

```bash
python -m dein_paket --help
python -m dein_paket --input data.csv --output results.json
```

## Beispiele

### Beispiel 1: Datenverarbeitung

```python
import pandas as pd
from dein_paket import DataProcessor

# CSV-Datei einlesen und verarbeiten
processor = DataProcessor()
df = pd.read_csv('daten.csv')
cleaned_data = processor.clean(df)
```

### Beispiel 2: API-Integration

```python
from dein_paket import APIClient

client = APIClient(api_key="dein-api-schlüssel")
response = client.fetch_data(query="Python")
```

## API-Dokumentation

### Klassen

#### `HauptKlasse`

**Parameter:**
- `config_file` (str, optional): Pfad zur Konfigurationsdatei
- `debug` (bool): Debug-Modus aktivieren

**Methoden:**

##### `process_data(input_data)`
Verarbeitet die Eingabedaten und gibt das Ergebnis zurück.

**Parameter:**
- `input_data` (str|list): Zu verarbeitende Daten

**Rückgabe:**
- `dict`: Verarbeitete Daten

**Beispiel:**
```python
result = app.process_data(["item1", "item2"])
```

## Mitwirken

Beiträge sind willkommen! Bitte lies unsere [Mitwirkungsrichtlinien](../../../02-Tech/Terminal/Nushell/nu-scripts/CONTRIBUTING.md).

### Entwicklung

```bash
# Repository klonen
git clone https://github.com/username/projekt.git
cd projekt

# Virtuelle Umgebung erstellen
python -m venv venv
source venv/bin/activate  # Linux/Mac
# venv\Scripts\activate   # Windows

# Abhängigkeiten installieren
pip install -r requirements-dev.txt
pip install -e .

# Pre-commit hooks installieren
pre-commit install
```

### Code-Stil

Wir verwenden:
- [Black](https://black.readthedocs.io/) für Code-Formatierung
- [isort](https://pycqa.github.io/isort/) für Import-Sortierung
- [flake8](https://flake8.pycqa.org/) für Linting
- [mypy](http://mypy-lang.org/) für Typ-Überprüfung

## Tests

```bash
# Alle Tests ausführen
pytest

# Tests mit Coverage
pytest --cov=dein_paket

# Spezifischen Test ausführen
pytest tests/test_main.py::TestHauptKlasse::test_process_data
```

## Roadmap

- [ ] Feature A implementieren
- [ ] Performance-Optimierungen
- [ ] Dokumentation erweitern
- [ ] Docker-Support hinzufügen

## Häufig gestellte Fragen (FAQ)

### Wie installiere ich zusätzliche Abhängigkeiten?

```bash
pip install dein-paket[extra]
```

### Welche Python-Versionen werden unterstützt?

Dieses Projekt unterstützt Python 3.8 und höher.

## Lizenz

Dieses Projekt steht unter der MIT-Lizenz - siehe [LICENSE](LICENSE) für Details.

## Danksagungen

- [Contributor 1](https://github.com/contributor1) - Initiale Arbeit
- [Contributor 2](https://github.com/contributor2) - Bug-Fixes
- Inspiration von [ähnlichem Projekt](https://github.com/inspiration)

## Kontakt

**Autor:** Dein Name  
**E-Mail:** deine.email@example.com  
**GitHub:** [@dein-username](https://github.com/dein-username)

---

**⭐ Star dieses Repository, wenn es hilfreich war!**
````
### 4.2 README Best Practices

**Strukturelle Elemente:**
1. **Aussagekräftiger Titel** mit kurzer Beschreibung
2. **Badges** für Status, Version, Lizenz
3. **Inhaltsverzeichnis** für längere READMEs
4. **Schnelleinstieg** in wenigen Zeilen
5. **Detaillierte Installation** mit Voraussetzungen
6. **Verwendungsbeispiele** mit funktionierendem Code
7. **Dokumentation** oder Links zur API-Docs
8. **Mitwirkungshinweise**
9. **Lizenzinformationen**
10. **Kontaktdaten**

**Python-spezifische Tipps:**
- Immer Python-Version-Requirements angeben
- Virtuelle Umgebungen erwähnen
- `requirements.txt` vs `setup.py` erklären
- Code-Beispiele mit Syntax-Highlighting
- Import-Statements zeigen

**GitHub-Hilfe:** [About READMEs](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes)

---

## 5. Weitere wichtige Repository-Dateien

### 5.1 .gitignore für Python-Projekte

**Grundlegende .gitignore für Python:**

```gitignore
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
.python-version

# pipenv
Pipfile.lock

# PEP 582
__pypackages__/

# Celery stuff
celerybeat-schedule
celerybeat.pid

# SageMath parsed files
*.sage.py

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/

# IDE-spezifisch
.vscode/
.idea/
*.swp
*.swo

# OS-spezifisch
.DS_Store
Thumbs.db

# Projektspezifisch
config/secrets.json
data/raw/
logs/
```

**GitHub-Templates:** [github/gitignore - Python](https://github.com/github/gitignore/blob/main/Python.gitignore)

### 5.2 CONTRIBUTING.md

**Template für Python-Projekte:**

```markdown
# Mitwirkungsrichtlinien

Danke für dein Interesse, zu diesem Projekt beizutragen! 

## Entwicklungsumgebung einrichten

1. Repository forken und klonen
2. Virtuelle Umgebung erstellen:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Linux/Mac
   venv\Scripts\activate     # Windows
   ```
3. Entwicklungsabhängigkeiten installieren:
   ```bash
   pip install -r requirements-dev.txt
   pip install -e .
   ```

## Code-Standards

- **PEP 8** für Code-Stil
- **Type Hints** verwenden
- **Docstrings** für alle öffentlichen Funktionen
- **Tests schreiben** für neue Features

## Pull Request Prozess

1. Feature-Branch erstellen: `git checkout -b feature/mein-feature`
2. Änderungen commiten mit aussagekräftigen Nachrichten
3. Tests ausführen: `pytest`
4. Code formatieren: `black .` und `isort .`
5. Pull Request erstellen mit detaillierter Beschreibung

## Probleme melden

Verwende die [Issue-Templates](.github/ISSUE_TEMPLATE/) für:
- Bug-Reports
- Feature-Requests
- Fragen

## Verhaltenskodex

Bitte lies unseren [Code of Conduct](CODE_OF_CONDUCT.md).
```

### 5.3 requirements.txt und setup.py

**requirements.txt (für Entwicklung):**
```txt
# Produktionsabhängigkeiten
requests>=2.28.0
numpy>=1.21.0
pandas>=1.4.0

# Entwicklungsabhängigkeiten (requirements-dev.txt)
pytest>=6.0
pytest-cov>=3.0
black>=22.0
isort>=5.10
flake8>=4.0
mypy>=0.950
pre-commit>=2.17
```

**setup.py (für pip-Installation):**
```python
from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

with open("requirements.txt", "r") as fh:
    requirements = [line.strip() for line in fh if line.strip() and not line.startswith("#")]

setup(
    name="mein-python-paket",
    version="0.1.0",
    author="Dein Name",
    author_email="deine.email@example.com",
    description="Eine kurze Beschreibung des Pakets",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/username/mein-python-paket",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
    python_requires=">=3.8",
    install_requires=requirements,
    extras_require={
        "dev": ["pytest>=6.0", "black>=22.0", "isort>=5.10"],
        "docs": ["sphinx>=4.0", "sphinx-rtd-theme>=1.0"],
    },
    entry_points={
        "console_scripts": [
            "mein-tool=mein_paket.cli:main",
        ],
    },
)
```

### 5.4 .github/workflows/ (GitHub Actions)

**Python CI/CD Workflow (.github/workflows/ci.yml):**

```yaml
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8, 3.9, '3.10', 3.11]

    steps:
    - uses: actions/checkout@v3
    
    - name: Python ${{ matrix.python-version }} einrichten
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    
    - name: Abhängigkeiten installieren
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements-dev.txt
        pip install -e .
    
    - name: Code-Stil prüfen
      run: |
        black --check .
        isort --check-only .
        flake8 .
    
    - name: Type-Checking
      run: mypy src/
    
    - name: Tests ausführen
      run: pytest --cov=src/ --cov-report=xml
    
    - name: Coverage hochladen
      uses: codecov/codecov-action@v3
```

### 5.5 Weitere wichtige Dateien

**CHANGELOG.md:**
```markdown
# Changelog

Alle wichtigen Änderungen an diesem Projekt werden in dieser Datei dokumentiert.

## [Unveröffentlicht]
- Neue API für Datenexport

## [1.0.0] - 2024-01-15
### Hinzugefügt
- Erste stabile Version
- Vollständige API-Dokumentation
- Beispiele für häufige Anwendungsfälle

### Geändert
- Performance-Verbesserungen bei großen Datensätzen

### Behoben
- Bug bei Unicode-Zeichen in Dateinamen
```

**CODE_OF_CONDUCT.md:**
```markdown
# Verhaltenskodex

## Unser Versprechen

Wir verpflichten uns, die Teilnahme an unserem Projekt zu einer belästigungsfreien Erfahrung für alle zu machen.

## Unsere Standards

Beispiele für Verhalten, das zu einem positiven Umfeld beiträgt:
- Verwendung einer einladenden und inklusiven Sprache
- Respektvoller Umgang mit unterschiedlichen Standpunkten
- Konstruktive Kritik geben und annehmen

## Durchsetzung

Verstöße können an [email@example.com] gemeldet werden.
```

**GitHub-Hilfe:** [Creating a default community health file](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file)

---

## 6. GitHub-eigene Hilfe und Ressourcen

### 6.1 Offizielle GitHub-Dokumentation

**Hauptressourcen:**

1. **GitHub Docs** - [docs.github.com](https://docs.github.com)
   - Umfassende Dokumentation aller GitHub-Features
   - Schritt-für-Schritt-Anleitungen
   - Regelmäßig aktualisiert

2. **GitHub Skills** - [skills.github.com](https://skills.github.com)
   - Interaktive Kurse mit echten Repositories
   - Lernen durch praktische Übungen
   - Von Grundlagen bis zu fortgeschrittenen Themen

3. **GitHub Learning Pathways** - [resources.github.com/learn/pathways](https://resources.github.com/learn/pathways)
   - Strukturierte Lernpfade
   - Expertengeführte Tutorials
   - Business-fokussierte Inhalte

### 6.2 Empfohlene GitHub Skills Kurse

**Für Einsteiger:**
- **Introduction to GitHub** - Grundlagen in unter einer Stunde
- **Communicate using Markdown** - Markdown-Formatierung lernen
- **GitHub Pages** - Website direkt aus Repository erstellen

**Für Fortgeschrittene:**
- **Review pull requests** - Kollaborative Workflows
- **Resolve merge conflicts** - Konflikte lösen
- **Hello GitHub Actions** - Automatisierung einführen

**Für Python-Entwickler relevant:**
- **Code with Codespaces** - Cloud-Entwicklungsumgebung
- **Code with Copilot** - AI-gestützte Programmierung
- **Secure code game** - Sicherheit in der Softwareentwicklung

### 6.3 GitHub CLI Dokumentation

**Offizielle Quellen:**
- **GitHub CLI Manual** - [cli.github.com/manual](https://cli.github.com/manual)
- **Installation Guide** - Plattformspezifische Anleitungen
- **Command Reference** - Vollständige Befehlsübersicht

**Nützliche gh-Befehle für Python-Entwickler:**

```bash
# Repository-Management
gh repo create my-python-project --public --clone
gh repo view --web

# Issues und Pull Requests
gh issue create --title "Bug: Import-Fehler in main.py"
gh pr create --title "Feature: Add data validation"
gh pr review --approve

# Releases
gh release create v1.0.0 --notes "Erste stabile Version"
gh release upload v1.0.0 dist/*.whl

# Gists (Code-Snippets)
gh gist create script.py --desc "Python utility script"
```

### 6.4 Community und Support

**GitHub Community:**
- **GitHub Community Forum** - [github.community](https://github.community)
- **GitHub Support** - Direkter Kontakt bei Problemen
- **GitHub Status** - [githubstatus.com](https://githubstatus.com) für Service-Updates

**Externe Lernressourcen:**
- **Git Cheat Sheet** - [education.github.com/git-cheat-sheet-education.pdf](https://education.github.com/git-cheat-sheet-education.pdf)
- **Git Handbook** - [guides.github.com/introduction/git-handbook](https://guides.github.com/introduction/git-handbook)
- **Markdown Guide** - [guides.github.com/features/mastering-markdown](https://guides.github.com/features/mastering-markdown)

### 6.5 Python-spezifische GitHub-Features

**GitHub Actions für Python:**
- **Python Package Publishing** - Automatisches PyPI-Deployment
- **Testing Matrix** - Tests auf mehreren Python-Versionen
- **Dependency Updates** - Dependabot für requirements.txt

**GitHub Codespaces:**
- **devcontainer.json** für Python-Entwicklungsumgebung
- **Vorkonfigurierte Python-Templates**
- **Integration mit VS Code**

**GitHub Packages:**
- **Python-Pakete hosten** - Alternative zu PyPI
- **Private Package Registries** - Für Unternehmen

---

## Zusammenfassung und Checkliste

### ✅ Account-Setup Checkliste

- [ ] GitHub-Account mit starkem Passwort erstellt
- [ ] E-Mail-Adresse verifiziert
- [ ] Zwei-Faktor-Authentifizierung aktiviert
- [ ] SSH-Schlüssel hinzugefügt
- [ ] Profil mit Foto und Bio vervollständigt
- [ ] GitHub Desktop installiert (optional)
- [ ] GitHub CLI installiert und authentifiziert

### ✅ Repository-Setup Checkliste

- [ ] Repository mit beschreibendem Namen erstellt
- [ ] README.md mit vollständiger Dokumentation
- [ ] Passende Lizenz ausgewählt und hinzugefügt
- [ ] Python-spezifische .gitignore erstellt
- [ ] requirements.txt und setup.py (falls Paket)
- [ ] CONTRIBUTING.md für Mitwirkende
- [ ] GitHub Actions Workflow für CI/CD
- [ ] Issue- und PR-Templates erstellt

### ✅ Best Practices befolgen

- [ ] Aussagekräftige Commit-Nachrichten
- [ ] Branch-Strategie definiert
- [ ] Code-Stil-Standards dokumentiert
- [ ] Tests für neuen Code geschrieben
- [ ] Dokumentation aktuell gehalten
- [ ] Sicherheits-Best-Practices befolgt

---

**💡 Tipp:** Beginne mit einem einfachen Python-Projekt und erweitere schrittweise die Repository-Struktur. GitHub bietet viele Templates und Automatisierungen, die dir den Einstieg erleichtern.

**🔗 Weitere Ressourcen:**
- [GitHub Education](https://education.github.com) - Kostenlose Ressourcen für Studierende
- [GitHub Sponsors](https://github.com/sponsors) - Open-Source-Projekte unterstützen
- [GitHub Marketplace](https://github.com/marketplace) - Apps und Actions erweitern

---

*Erstellt für den Python-Kurs | Stand: September 2024*
