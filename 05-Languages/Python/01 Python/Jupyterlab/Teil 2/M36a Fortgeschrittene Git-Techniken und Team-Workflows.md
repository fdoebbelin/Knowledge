- bringt Git-Kenntnisse auf ein professionelles Niveau für die Teamarbeit. 
- im Fokus stehen nicht mehr nur der Umgang mit Branches und einfache Merges, 
- sondern praxiserprobte Workflows, Konfliktmanagement, 
- Pull Requests, automatisierte Tests und moderne Teamprozesse, 
- wie sie in Softwareprojekten zum Alltag gehören.
## Git-Workflows: Von der Einzelarbeit zum Teamprozess

Ein Workflow beschreibt, wie Teams Branches, Commits und Merges organisieren. Standard-Workflows sind Git Flow (mit Feature-, Release- und Hotfix-Branches) und GitHub Flow (kontinuierliches Deployment mit Pull Requests).

**Beispiel:**

```bash
# Feature im Team starten
git checkout -b feature/login
# Nach Fertigstellung Pull Request oder Merge Request stellen
```


### Python als Workflow-Helfer

Mit Python-Skripten kann man Branch-Namen oder Regeln für Commits überprüfen lassen und so die Einhaltung von Teamstandards automatisieren:

```python
import subprocess

def check_branch():
    branch = subprocess.run(['git', 'branch', '--show-current'], capture_output=True, text=True)
    assert branch.stdout.startswith('feature/'), "Branch-Name entspricht nicht der Konvention!"
```


***

## Konfliktmanagement und Merges

Je mehr Personen am Code arbeiten, desto öfter entstehen Merge-Konflikte, z. B. bei Änderungen in denselben Dateien.

**Behandlung von Konflikten:**

- Nutzung von Git-Tools wie `git mergetool`
- Automatische und manuelle Prüfverfahren zum Suchen und Auflösen von Konfliktmarkierungen (`<<<<<<<`, `=======`, `>>>>>>>`)
- Python-Tools können Konflikte automatisiert erkennen, etwa:

```python
def find_conflicts(file):
    with open(file) as f:
        content = f.read()
    return "<<<<<<<" in content and ">>>>>>> " in content
```


***

## Pull Requests und Code Reviews

Pull Requests (z. B. auf GitHub) sind das Herz moderner Zusammenarbeit:

- Teammitglieder schlagen Änderungen vor (“Request”)
- Reviewer prüfen Code, kommentieren und geben per Review die Änderungen frei
- Automatische Checks (Tests, Linting) laufen vor dem Merge

**Python kann automatisiert Tests und Checks im Pull Request ablaufen lassen.**

***

## Integration von Tests in den Git-Workflow

Durch Continuous Integration (CI) kann jede Änderung automatisch getestet werden. Typische Systeme sind GitHub Actions oder GitLab CI. Entwickler profitieren, weil Probleme früh sichtbar werden:

```yaml
# Beispiel: GitHub Actions Workflow (ci.yml)
name: Test Suite
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: pip install -r requirements.txt
      - run: pytest
```


***

## Git Hooks: Automatisierung für Qualität im Team

Git Hooks sind automatische Prüfscripts, die bei Aktionen wie Commit oder Push ausgeführt werden:

- Pre-commit hook für Codestyle (`black`, `flake8`)
- Pre-push hook für automatisierte Tests
- Commit-msg hook für saubere Commit-Nachrichten

**Mini-Beispiel Pre-Commit-Hook:**

```python
import sys
import subprocess
files = subprocess.run(['git', 'diff', '--cached', '--name-only'], capture_output=True, text=True).stdout.split()
for f in files:
    if f.endswith('.py'):
        subprocess.run(['black', f])
```


***

## Best Practices im Team

- Einheitliche Branch-Namen und Commit-Nachrichten
- Code Reviews für jede Änderung
- Automatisierte Tests und Linter erzwingen
- Pull Requests als Pflicht etablieren

***

### Fazit

Dieses Modul verbindet die fortgeschrittene Nutzung von Git mit konkretem Teamworkflow, automatisierten Prüfmechanismen und Integrationsmöglichkeiten für die Softwareentwicklungspraxis. Schrittweise Python-Beispiele und praktische Tipps verankern die Inhalte für einen reibungslosen Entwicklungsprozess im Team.