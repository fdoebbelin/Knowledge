## Kursbegleitende Aufgaben: Projekt "01 Py2Rust – Migration \& Teamworkflow"

### Aufgabe 1: Team-Workflow mit Git Flow in Py2Rust

**Stellen Sie das Migrationsteam auf Git Flow um, und automatisieren Sie den Branch-Prozess per Python.**

- Entwickeln Sie ein Python-Skript, das automatisch die Branch-Konvention überprüft und Git-Flow-Standard-Branches (feature/, release/, hotfix/) anlegt.
- Ergänzen Sie Hooks, sodass vor jedem Commit bei Feature-Branches automatisch Tests ausgeführt werden.

**Lösung (voll kommentiert):**

```python
import subprocess

def check_gitflow_branch(branch):
    """Branch-Konvention prüfen (feature/, release/, hotfix/)"""
    return branch.startswith(('feature/', 'release/', 'hotfix/'))

def create_branch(branch_type, branch_name):
    """Git-Branch gemäß Git-Flow anlegen"""
    branch_full = f"{branch_type}/{branch_name}"
    subprocess.run(['git', 'checkout', '-b', branch_full])

def pre_commit_tests():
    """Tests vor Commit ausführen (Hook-Demo)"""
    result = subprocess.run(['pytest'], capture_output=True)
    if result.returncode == 0:
        print("Tests erfolgreich!")
        return True
    else:
        print("Fehler bei Tests:", result.stdout.decode())
        return False

# Demo: Branch anlegen und Tests ausführen
branch = 'feature/migration'
create_branch('feature', 'migration')
assert check_gitflow_branch(branch), "Branch-Konvention verletzt!"
pre_commit_tests()
```

- Das Skript kann als .pre-commit-Hook integriert werden, um den Workflow zu erzwingen.[^1]

***

### Aufgabe 2: Pull Requests und Review automatisieren

**Schreiben Sie ein Python-Skript zur automatischen Prüfung, ob ein Pull Request bereit für den Merge ist. Es soll checken:**

- sind alle Tests erfolgreich?
- entspricht die Commit-Nachricht der Konvention?
- sind alle Dateien formatiert (z. B. mit black)?

**Lösung (voll kommentiert):**

```python
import subprocess
import re

def check_commit_message():
    """Commit-Konvention überprüfen"""
    msg = subprocess.run(['git', 'log', '-1', '--pretty=%B'], capture_output=True, text=True).stdout
    pattern = r"^(feat|fix|docs|chore): .+"
    return re.match(pattern, msg) is not None

def check_black_format():
    """Codeformatierung prüfen"""
    result = subprocess.run(['black', '--check', '.'], capture_output=True)
    return result.returncode == 0

def ready_for_merge():
    """Alle Checks für den Pull Request zusammenfassen"""
    tests = subprocess.run(['pytest'], capture_output=True)
    return tests.returncode == 0 and check_commit_message() and check_black_format()

assert ready_for_merge(), "PR nicht mergebereit!"
```

- Kann direkt als Pre-Merge-Check in den Workflow eingebunden werden.[^1]

***

## Projektaufgaben für Teilnehmer "WetterWeiser", "PersonalPrinz" und "KeyRecognition"

### Projekt 1: "WetterWeiser"

1. Entwickeln Sie ein Python-Skript, das bei jedem neuen Branch automatisch prüft, ob die Branch-Konvention ("feature/", "bugfix/", "hotfix/") eingehalten wird.
*Hinweis: Nutzen Sie subprocess und eine Namensliste.*
2. Integrieren Sie einen Hook, der vor jedem Commit prüft, ob alle neuen Dateien einen Docstring enthalten.
*Lösungshinweis: Mit os und Dateiinspektion.*

***

### Projekt 2: "PersonalPrinz"

1. Schreiben Sie ein Skript, das einen Pre-Push-Hook für die automatisierte Testausführung installiert und einen Commit abbricht, wenn Tests fehlschlagen.
*Lösungshinweis: subprocess-Check, Hook im .git/hooks-Ordner.*
2. Entwickeln Sie ein Werkzeug, das prüft, ob alle Änderungen an Mitarbeiterdaten protokolliert wurden (CSV-Log erstellen).
*Lösungshinweis: Überwachen Sie nach jedem Commit die geänderten Datensätze in users.csv und schreiben Sie ein Log-File.*

***

### Projekt 3: "KeyRecognition"

1. Erstellen Sie eine Hook-Lösung, die sicherstellt, dass jede commitierte Datei das korrekte Encoding und Format besitzt (z. B. UTF-8, Zeilenende LF).
*Lösungshinweis: Mit Python-Dateiinspektion und Fehlerausgabe bei Nichteinhaltung.*
2. Bauen Sie eine automatisierte Report-Generierung, die nach jedem Push eine Übersicht der geänderten Signalklassen im Projekt erstellt (Modul-Scan als Statistik).
*Lösungshinweis: Python-Scan nach signal.py-Änderungen, Ausgabe in Markdown als Statistik.*

***

Alle Aufgaben führen die Teilnehmer durch praxisnahe Automation, Teamstandards und die Überprüfung von Code-Qualität in echten Python-Projekten. Die Lösungen und Hinweise sind so gestaltet, dass sie live im Kurs demonstriert und einfach nachgebaut werden können.[^2][^3][^4][^1]

<div style="text-align: center">⁂</div>

[^1]: 01-Projekt-Fritz-Py2Rust.md

[^2]: 03-Projekt-Christopher-PersonalPrinz.md

[^3]: 04-Projekt-Tristan-KeyRegognition.md

[^4]: 02-Projekt-Christian-WetterWeiser.md

