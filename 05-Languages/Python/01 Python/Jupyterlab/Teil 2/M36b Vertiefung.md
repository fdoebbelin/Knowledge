## Überblick und Lernziele

In diesem Modul erweitern Sie Ihre Git-Kenntnisse von den Grundlagen hin zu professionellen Team-Workflows. Sie lernen, wie moderne Softwareentwicklungsteams Git in komplexen Projekten einsetzen, wie Code-Reviews funktionieren und wie Sie Tests nahtlos in Ihren Git-Workflow integrieren können. Das Modul verbindet technische Git-Fertigkeiten mit praktischen Arbeitsweisen aus der Industrie.

**Lernziele:**

- Verstehen und Anwenden verschiedener Git-Workflows (Git Flow, GitHub Flow, etc.)
- Beherrschung der Konfliktlösung bei Merge-Konflikten
- Durchführung von Code-Reviews und Pull Requests
- Integration von automatisierten Tests in Git-Workflows
- Arbeiten mit Git-Hooks für automatisierte Checks
- Best Practices für die Zusammenarbeit in Entwicklungsteams


## Git-Workflows für Teams

### Git Flow Workflow

Git Flow ist ein etabliertes Branching-Modell, das sich besonders für Projekte mit regelmäßigen Releases eignet:

```bash
# Git Flow initialisieren
git flow init

# Feature-Branch erstellen und starten
git flow feature start neue-funktion

# Während der Entwicklung normale Git-Commits
git add .
git commit -m "Implementiere neue Funktion"

# Feature abschließen (merged automatisch in develop)
git flow feature finish neue-funktion

# Release vorbereiten
git flow release start 1.0.0

# Nach Tests und Bugfixes: Release abschließen
git flow release finish 1.0.0
```

**Python-Beispiel für Git Flow Integration:**

```python
import subprocess
import sys
from datetime import datetime

class GitFlowManager:
    """Vereinfacht Git Flow Operationen für Python-Projekte."""
    
    def __init__(self, project_name):
        self.project_name = project_name
        self.current_branch = self.get_current_branch()
    
    def get_current_branch(self):
        """Ermittelt den aktuellen Git-Branch."""
        try:
            result = subprocess.run(
                ['git', 'branch', '--show-current'], 
                capture_output=True, 
                text=True, 
                check=True
            )
            return result.stdout.strip()
        except subprocess.CalledProcessError:
            return "unknown"
    
    def start_feature(self, feature_name):
        """Startet einen neuen Feature-Branch."""
        try:
            subprocess.run(['git', 'flow', 'feature', 'start', feature_name], check=True)
            print(f"✅ Feature-Branch '{feature_name}' gestartet")
            return True
        except subprocess.CalledProcessError as e:
            print(f"❌ Fehler beim Starten des Features: {e}")
            return False
    
    def finish_feature(self, feature_name):
        """Schließt einen Feature-Branch ab."""
        try:
            # Automatische Tests vor dem Merge
            if self.run_tests():
                subprocess.run(['git', 'flow', 'feature', 'finish', feature_name], check=True)
                print(f"✅ Feature '{feature_name}' erfolgreich abgeschlossen")
                return True
            else:
                print("❌ Tests fehlgeschlagen - Feature nicht abgeschlossen")
                return False
        except subprocess.CalledProcessError as e:
            print(f"❌ Fehler beim Abschließen des Features: {e}")
            return False
    
    def run_tests(self):
        """Führt automatische Tests aus."""
        try:
            result = subprocess.run(['python', '-m', 'pytest', '-v'], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                print("✅ Alle Tests erfolgreich")
                return True
            else:
                print(f"❌ Tests fehlgeschlagen:\n{result.stdout}")
                return False
        except Exception as e:
            print(f"⚠️  Tests konnten nicht ausgeführt werden: {e}")
            return True  # Bei Test-Problemen trotzdem fortfahren

# Verwendungsbeispiel
if __name__ == "__main__":
    git_manager = GitFlowManager("mein-python-projekt")
    print(f"Aktueller Branch: {git_manager.current_branch}")
    
    # Feature starten
    git_manager.start_feature("user-authentication")
```


### GitHub Flow (vereinfachter Workflow)

GitHub Flow ist ein schlanker Workflow für kontinuierliche Entwicklung:

```python
class GitHubFlowManager:
    """Implementiert GitHub Flow für Python-Projekte."""
    
    def __init__(self):
        self.main_branch = "main"
    
    def create_feature_branch(self, feature_name):
        """Erstellt einen Feature-Branch vom main-Branch."""
        commands = [
            ['git', 'checkout', self.main_branch],
            ['git', 'pull', 'origin', self.main_branch],
            ['git', 'checkout', '-b', f'feature/{feature_name}']
        ]
        
        for cmd in commands:
            try:
                subprocess.run(cmd, check=True)
            except subprocess.CalledProcessError as e:
                print(f"❌ Fehler bei Befehl {' '.join(cmd)}: {e}")
                return False
        
        print(f"✅ Feature-Branch 'feature/{feature_name}' erstellt")
        return True
    
    def prepare_pull_request(self, feature_name, description=""):
        """Bereitet einen Pull Request vor."""
        # Code committen und pushen
        try:
            subprocess.run(['git', 'add', '.'], check=True)
            subprocess.run(['git', 'commit', '-m', f'feat: {feature_name}'], check=True)
            subprocess.run(['git', 'push', 'origin', f'feature/{feature_name}'], check=True)
            
            print("✅ Änderungen gepusht - bereit für Pull Request")
            print(f"📝 Beschreibung: {description}")
            return True
        except subprocess.CalledProcessError as e:
            print(f"❌ Fehler beim Vorbereiten des Pull Requests: {e}")
            return False

# Verwendungsbeispiel
github_flow = GitHubFlowManager()
github_flow.create_feature_branch("api-endpoints")
github_flow.prepare_pull_request("api-endpoints", "Neue REST API Endpunkte hinzugefügt")
```


## Konfliktlösung und Merge-Strategien

### Automatische Konfliktlösung

```python
import re
from pathlib import Path

class MergeConflictResolver:
    """Hilft bei der Analyse und Lösung von Merge-Konflikten."""
    
    def __init__(self):
        self.conflict_markers = {
            'start': '<<<<<<< ',
            'separator': '=======',
            'end': '>>>>>>> '
        }
    
    def find_conflicts(self, file_path):
        """Findet alle Konflikte in einer Datei."""
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                content = file.read()
            
            conflicts = []
            lines = content.split('\n')
            
            for i, line in enumerate(lines):
                if line.startswith(self.conflict_markers['start']):
                    conflict_start = i
                    # Finde das Ende des Konflikts
                    for j in range(i + 1, len(lines)):
                        if lines[j].startswith(self.conflict_markers['end']):
                            conflicts.append({
                                'start_line': conflict_start + 1,
                                'end_line': j + 1,
                                'file': file_path
                            })
                            break
            
            return conflicts
        except Exception as e:
            print(f"❌ Fehler beim Analysieren der Datei {file_path}: {e}")
            return []
    
    def analyze_conflict(self, file_path, conflict):
        """Analysiert einen spezifischen Konflikt."""
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                lines = file.readlines()
            
            start_idx = conflict['start_line'] - 1
            end_idx = conflict['end_line'] - 1
            
            conflict_block = lines[start_idx:end_idx + 1]
            
            # Trennung der Versionen
            current_version = []
            incoming_version = []
            separator_found = False
            
            for line in conflict_block[1:-1]:  # Ohne Marker
                if line.startswith(self.conflict_markers['separator']):
                    separator_found = True
                    continue
                
                if not separator_found:
                    current_version.append(line.rstrip())
                else:
                    incoming_version.append(line.rstrip())
            
            return {
                'current': current_version,
                'incoming': incoming_version,
                'context': f"Zeilen {conflict['start_line']}-{conflict['end_line']}"
            }
        except Exception as e:
            print(f"❌ Fehler bei der Konfliktanalyse: {e}")
            return None
    
    def suggest_resolution(self, conflict_analysis):
        """Schlägt eine Lösung für den Konflikt vor."""
        current = conflict_analysis['current']
        incoming = conflict_analysis['incoming']
        
        suggestions = []
        
        # Einfache Heuristiken für automatische Auflösung
        if not current:  # Nur incoming version
            suggestions.append(("Incoming Version übernehmen", incoming))
        elif not incoming:  # Nur current version
            suggestions.append(("Current Version behalten", current))
        elif current == incoming:  # Identisch
            suggestions.append(("Identische Versionen - beliebige wählen", current))
        else:
            # Versuche intelligente Zusammenführung
            merged = self.smart_merge(current, incoming)
            suggestions.append(("Smart Merge", merged))
            suggestions.append(("Current Version", current))
            suggestions.append(("Incoming Version", incoming))
        
        return suggestions
    
    def smart_merge(self, current, incoming):
        """Versucht intelligente Zusammenführung."""
        # Einfache Logik: beide Versionen kombinieren wenn möglich
        if len(current) == 1 and len(incoming) == 1:
            # Bei einzelnen Zeilen: längere Version bevorzugen
            return [max(current[^0], incoming[^0], key=len)]
        
        # Bei mehreren Zeilen: beide Versionen behalten
        result = []
        result.extend(current)
        result.append("# --- Merged from incoming ---")
        result.extend(incoming)
        return result

# Verwendungsbeispiel
def resolve_conflicts_in_project():
    """Findet und hilft bei der Lösung aller Konflikte im Projekt."""
    resolver = MergeConflictResolver()
    
    # Finde alle Python-Dateien mit Konflikten
    for py_file in Path('.').rglob('*.py'):
        conflicts = resolver.find_conflicts(py_file)
        
        if conflicts:
            print(f"\n🔍 Konflikte gefunden in {py_file}:")
            
            for i, conflict in enumerate(conflicts, 1):
                print(f"\n  Konflikt #{i}:")
                analysis = resolver.analyze_conflict(py_file, conflict)
                
                if analysis:
                    print(f"    Kontext: {analysis['context']}")
                    print(f"    Current Version ({len(analysis['current'])} Zeilen):")
                    for line in analysis['current']:
                        print(f"      {line}")
                    
                    print(f"    Incoming Version ({len(analysis['incoming'])} Zeilen):")
                    for line in analysis['incoming']:
                        print(f"      {line}")
                    
                    suggestions = resolver.suggest_resolution(analysis)
                    print(f"\n    💡 Lösungsvorschläge:")
                    for j, (description, solution) in enumerate(suggestions, 1):
                        print(f"      {j}. {description}")

# Ausführen der Konfliktanalyse
if __name__ == "__main__":
    resolve_conflicts_in_project()
```


## Pull Requests und Code Reviews

### Automatisierte Pull Request Checks

```python
import json
import subprocess
from typing import List, Dict, Any

class PullRequestChecker:
    """Automatisierte Checks für Pull Requests."""
    
    def __init__(self, config_file="pr_config.json"):
        self.config = self.load_config(config_file)
        self.results = {}
    
    def load_config(self, config_file):
        """Lädt die Konfiguration für PR-Checks."""
        default_config = {
            "required_checks": [
                "syntax_check",
                "test_execution", 
                "code_style",
                "documentation_check"
            ],
            "test_command": ["python", "-m", "pytest", "-v"],
            "style_checker": ["flake8", "--max-line-length=88"],
            "min_test_coverage": 80
        }
        
        try:
            with open(config_file, 'r') as f:
                user_config = json.load(f)
                default_config.update(user_config)
        except FileNotFoundError:
            print(f"⚠️  Konfigurationsdatei {config_file} nicht gefunden - verwende Standardwerte")
        
        return default_config
    
    def run_syntax_check(self) -> bool:
        """Überprüft die Python-Syntax aller geänderten Dateien."""
        try:
            # Finde geänderte Python-Dateien
            result = subprocess.run(
                ['git', 'diff', '--name-only', 'HEAD~1', '--', '*.py'],
                capture_output=True, text=True
            )
            
            changed_files = result.stdout.strip().split('\n')
            syntax_errors = []
            
            for file_path in changed_files:
                if file_path and file_path.endswith('.py'):
                    try:
                        # Kompiliere Python-Datei ohne Ausführung
                        with open(file_path, 'r') as f:
                            compile(f.read(), file_path, 'exec')
                    except SyntaxError as e:
                        syntax_errors.append(f"{file_path}: {e}")
            
            if syntax_errors:
                self.results['syntax_check'] = {
                    'passed': False,
                    'errors': syntax_errors
                }
                return False
            else:
                self.results['syntax_check'] = {
                    'passed': True,
                    'message': f"Syntax OK für {len(changed_files)} Dateien"
                }
                return True
                
        except Exception as e:
            self.results['syntax_check'] = {
                'passed': False,
                'error': str(e)
            }
            return False
    
    def run_tests(self) -> bool:
        """Führt alle Tests aus."""
        try:
            result = subprocess.run(
                self.config['test_command'],
                capture_output=True, text=True, timeout=300
            )
            
            success = result.returncode == 0
            self.results['test_execution'] = {
                'passed': success,
                'output': result.stdout,
                'errors': result.stderr if not success else None
            }
            
            return success
            
        except subprocess.TimeoutExpired:
            self.results['test_execution'] = {
                'passed': False,
                'error': "Tests haben das Zeitlimit überschritten"
            }
            return False
        except Exception as e:
            self.results['test_execution'] = {
                'passed': False,
                'error': str(e)
            }
            return False
    
    def check_code_style(self) -> bool:
        """Überprüft den Code-Stil."""
        try:
            result = subprocess.run(
                self.config['style_checker'],
                capture_output=True, text=True
            )
            
            success = result.returncode == 0
            self.results['code_style'] = {
                'passed': success,
                'issues': result.stdout if not success else "Keine Stil-Probleme gefunden"
            }
            
            return success
            
        except Exception as e:
            self.results['code_style'] = {
                'passed': False,
                'error': str(e)
            }
            return False
    
    def check_documentation(self) -> bool:
        """Überprüft die Dokumentation."""
        try:
            # Finde Python-Dateien ohne Docstrings
            missing_docs = []
            
            for py_file in Path('.').rglob('*.py'):
                if 'test' in str(py_file) or '__pycache__' in str(py_file):
                    continue
                    
                with open(py_file, 'r') as f:
                    content = f.read()
                
                # Einfache Prüfung auf Docstrings
                if 'def ' in content and '"""' not in content:
                    missing_docs.append(str(py_file))
            
            if missing_docs:
                self.results['documentation_check'] = {
                    'passed': False,
                    'missing_docs': missing_docs
                }
                return False
            else:
                self.results['documentation_check'] = {
                    'passed': True,
                    'message': "Dokumentation vollständig"
                }
                return True
                
        except Exception as e:
            self.results['documentation_check'] = {
                'passed': False,
                'error': str(e)
            }
            return False
    
    def run_all_checks(self) -> Dict[str, Any]:
        """Führt alle konfigurierten Checks aus."""
        print("🔍 Starte Pull Request Checks...")
        
        all_passed = True
        
        for check_name in self.config['required_checks']:
            print(f"\n⚙️  Führe {check_name} aus...")
            
            if check_name == 'syntax_check':
                passed = self.run_syntax_check()
            elif check_name == 'test_execution':
                passed = self.run_tests()
            elif check_name == 'code_style':
                passed = self.check_code_style()
            elif check_name == 'documentation_check':
                passed = self.check_documentation()
            else:
                print(f"⚠️  Unbekannter Check: {check_name}")
                continue
            
            if passed:
                print(f"✅ {check_name} erfolgreich")
            else:
                print(f"❌ {check_name} fehlgeschlagen")
                all_passed = False
        
        # Zusammenfassung
        summary = {
            'all_checks_passed': all_passed,
            'individual_results': self.results,
            'timestamp': datetime.now().isoformat()
        }
        
        return summary
    
    def generate_report(self, summary: Dict[str, Any]) -> str:
        """Generiert einen detaillierten Bericht."""
        report = ["# Pull Request Check Report", ""]
        
        if summary['all_checks_passed']:
            report.append("## ✅ Alle Checks erfolgreich!")
        else:
            report.append("## ❌ Einige Checks sind fehlgeschlagen")
        
        report.append(f"\n**Zeitpunkt:** {summary['timestamp']}")
        report.append("\n## Detaillierte Ergebnisse\n")
        
        for check_name, result in summary['individual_results'].items():
            status = "✅" if result['passed'] else "❌"
            report.append(f"### {status} {check_name.replace('_', ' ').title()}")
            
            if result['passed']:
                if 'message' in result:
                    report.append(f"- {result['message']}")
            else:
                if 'errors' in result:
                    report.append("**Fehler:**")
                    for error in result['errors']:
                        report.append(f"- {error}")
                if 'error' in result:
                    report.append(f"**Fehler:** {result['error']}")
                if 'issues' in result:
                    report.append(f"**Probleme:**\n``````")
            
            report.append("")
        
        return "\n".join(report)

# Verwendungsbeispiel
def main():
    checker = PullRequestChecker()
    summary = checker.run_all_checks()
    
    # Bericht generieren und ausgeben
    report = checker.generate_report(summary)
    print("\n" + "="*50)
    print(report)
    
    # Bericht in Datei speichern
    with open('pr_check_report.md', 'w') as f:
        f.write(report)
    
    # Exit-Code für CI/CD
    exit_code = 0 if summary['all_checks_passed'] else 1
    sys.exit(exit_code)

if __name__ == "__main__":
    main()
```


## Git Hooks und Automatisierung

### Pre-Commit Hook für Python-Projekte

```python
#!/usr/bin/env python3
"""
Pre-Commit Hook für Python-Projekte.
Speichern als .git/hooks/pre-commit und ausführbar machen.
"""

import sys
import subprocess
from pathlib import Path

class PreCommitHook:
    """Pre-Commit Hook für automatische Code-Qualitätschecks."""
    
    def __init__(self):
        self.errors = []
        self.warnings = []
    
    def check_python_syntax(self):
        """Überprüft Python-Syntax in staged Dateien."""
        try:
            # Finde staged Python-Dateien
            result = subprocess.run(
                ['git', 'diff', '--cached', '--name-only', '--diff-filter=ACM'],
                capture_output=True, text=True, check=True
            )
            
            python_files = [f for f in result.stdout.strip().split('\n') 
                          if f.endswith('.py') and f]
            
            for file_path in python_files:
                try:
                    with open(file_path, 'r') as f:
                        compile(f.read(), file_path, 'exec')
                except SyntaxError as e:
                    self.errors.append(f"Syntax-Fehler in {file_path}: {e}")
            
            return len(self.errors) == 0
            
        except Exception as e:
            self.errors.append(f"Fehler bei Syntax-Check: {e}")
            return False
    
    def run_black_formatter(self):
        """Führt automatische Code-Formatierung aus."""
        try:
            result = subprocess.run(
                ['black', '--check', '--diff', '.'],
                capture_output=True, text=True
            )
            
            if result.returncode != 0:
                self.warnings.append("Code ist nicht mit black formatiert")
                
                # Automatische Formatierung anbieten
                response = input("Code automatisch formatieren? (y/N): ")
                if response.lower() == 'y':
                    subprocess.run(['black', '.'], check=True)
                    print("✅ Code automatisch formatiert")
                    return True
                else:
                    self.errors.append("Code muss formatiert werden: black .")
                    return False
            
            return True
            
        except FileNotFoundError:
            self.warnings.append("black nicht installiert - überspringe Formatierung")
            return True
        except Exception as e:
            self.warnings.append(f"Fehler bei black: {e}")
            return True
    
    def check_imports(self):
        """Überprüft Import-Reihenfolge mit isort."""
        try:
            result = subprocess.run(
                ['isort', '--check-only', '--diff', '.'],
                capture_output=True, text=True
            )
            
            if result.returncode != 0:
                self.warnings.append("Import-Reihenfolge nicht korrekt")
                
                response = input("Imports automatisch sortieren? (y/N): ")
                if response.lower() == 'y':
                    subprocess.run(['isort', '.'], check=True)
                    print("✅ Imports automatisch sortiert")
                    return True
                else:
                    self.errors.append("Imports müssen sortiert werden: isort .")
                    return False
            
            return True
            
        except FileNotFoundError:
            self.warnings.append("isort nicht installiert - überspringe Import-Check")
            return True
        except Exception as e:
            self.warnings.append(f"Fehler bei isort: {e}")
            return True
    
    def run_quick_tests(self):
        """Führt schnelle Tests aus."""
        try:
            # Nur Unit-Tests, keine Integrationstests
            result = subprocess.run(
                ['python', '-m', 'pytest', 'tests/', '-v', '--tb=short', '-x'],
                capture_output=True, text=True, timeout=60
            )
            
            if result.returncode != 0:
                self.errors.append(f"Tests fehlgeschlagen:\n{result.stdout}")
                return False
            
            print("✅ Schnelle Tests erfolgreich")
            return True
            
        except subprocess.TimeoutExpired:
            self.warnings.append("Tests zu langsam - überspringe für Commit")
            return True
        except FileNotFoundError:
            self.warnings.append("pytest nicht gefunden - überspringe Tests")
            return True
        except Exception as e:
            self.warnings.append(f"Fehler bei Tests: {e}")
            return True
    
    def check_commit_message_file(self):
        """Überprüft die Commit-Nachricht."""
        try:
            # Commit-Nachricht aus COMMIT_EDITMSG lesen
            commit_msg_file = Path('.git/COMMIT_EDITMSG')
            if commit_msg_file.exists():
                with open(commit_msg_file, 'r') as f:
                    message = f.read().strip()
                
                # Einfache Validierung
                if len(message) < 10:
                    self.errors.append("Commit-Nachricht zu kurz (mindestens 10 Zeichen)")
                    return False
                
                if not message[^0].isupper():
                    self.warnings.append("Commit-Nachricht sollte mit Großbuchstaben beginnen")
            
            return True
            
        except Exception as e:
            self.warnings.append(f"Fehler bei Commit-Nachricht-Check: {e}")
            return True
    
    def run_all_checks(self):
        """Führt alle Pre-Commit-Checks aus."""
        print("🔍 Führe Pre-Commit-Checks aus...")
        
        checks = [
            ("Python-Syntax", self.check_python_syntax),
            ("Code-Formatierung", self.run_black_formatter),
            ("Import-Sortierung", self.check_imports),
            ("Schnelle Tests", self.run_quick_tests),
            ("Commit-Nachricht", self.check_commit_message_file)
        ]
        
        all_passed = True
        
        for check_name, check_func in checks:
            print(f"⚙️  {check_name}...")
            if not check_func():
                all_passed = False
                print(f"❌ {check_name} fehlgeschlagen")
            else:
                print(f"✅ {check_name}")
        
        # Ausgabe der Warnungen
        if self.warnings:
            print("\n⚠️  Warnungen:")
            for warning in self.warnings:
                print(f"  - {warning}")
        
        # Ausgabe der Fehler
        if self.errors:
            print("\n❌ Fehler:")
            for error in self.errors:
                print(f"  - {error}")
            print("\nCommit abgebrochen. Bitte behebe die Fehler und versuche es erneut.")
        
        return all_passed

def main():
    """Hauptfunktion für Pre-Commit-Hook."""
    hook = PreCommitHook()
    
    if hook.run_all_checks():
        print("\n✅ Alle Pre-Commit-Checks erfolgreich!")
        sys.exit(0)
    else:
        print("\n❌ Pre-Commit-Checks fehlgeschlagen!")
        sys.exit(1)

if __name__ == "__main__":
    main()
```


### Git Hook Installation Script

```python
import os
import stat
from pathlib import Path
import shutil

class GitHookInstaller:
    """Installiert und verwaltet Git-Hooks für Python-Projekte."""
    
    def __init__(self, project_root="."):
        self.project_root = Path(project_root)
        self.git_hooks_dir = self.project_root / ".git" / "hooks"
        self.hooks_template_dir = self.project_root / "scripts" / "git-hooks"
    
    def install_pre_commit_hook(self):
        """Installiert den Pre-Commit-Hook."""
        hook_content = '''#!/usr/bin/env python3
"""Pre-Commit Hook - automatische Code-Qualitätschecks."""

import sys
import os

# Füge Projekt-Root zum Python-Path hinzu
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, project_root)

try:
    from scripts.pre_commit_hook import main
    main()
except ImportError as e:
    print(f"❌ Fehler beim Laden des Pre-Commit-Hooks: {e}")
    print("Stelle sicher, dass scripts/pre_commit_hook.py existiert")
    sys.exit(1)
'''
        
        hook_path = self.git_hooks_dir / "pre-commit"
        
        try:
            with open(hook_path, 'w') as f:
                f.write(hook_content)
            
            # Hook ausführbar machen
            os.chmod(hook_path, stat.S_IRWXU | stat.S_IRGRP | stat.S_IROTH)
            print(f"✅ Pre-Commit-Hook installiert: {hook_path}")
            return True
            
        except Exception as e:
            print(f"❌ Fehler beim Installieren des Pre-Commit-Hooks: {e}")
            return False
    
    def install_commit_msg_hook(self):
        """Installiert einen Hook für Commit-Nachrichten."""
        hook_content = '''#!/usr/bin/env python3
"""Commit-Msg Hook - validiert Commit-Nachrichten."""

import sys
import re

def validate_commit_message(msg_file):
    """Validiert die Commit-Nachricht."""
    with open(msg_file, 'r') as f:
        message = f.read().strip()
    
    # Regeln für Commit-Nachrichten
    rules = [
        (len(message) >= 10, "Commit-Nachricht muss mindestens 10 Zeichen haben"),
        (len(message.split('\\n')[^0]) <= 72, "Erste Zeile darf maximal 72 Zeichen haben"),
        (not message.startswith('#'), "Commit-Nachricht darf nicht mit # beginnen"),
    ]
    
    # Optionale Conventional Commits Prüfung
    conventional_pattern = r'^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .+'
    if not re.match(conventional_pattern, message):
        print("💡 Tipp: Verwende Conventional Commits (feat:, fix:, docs:, etc.)")
    
    errors = []
    for rule_passed, error_msg in rules:
        if not rule_passed:
            errors.append(error_msg)
    
    if errors:
        print("❌ Commit-Nachricht ungültig:")
        for error in errors:
            print(f"  - {error}")
        print(f"\\nAktuelle Nachricht:\\n{message}")
        return False
    
    return True

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: commit-msg <msg-file>")
        sys.exit(1)
    
    msg_file = sys.argv[^1]
    if not validate_commit_message(msg_file):
        sys.exit(1)
    
    print("✅ Commit-Nachricht ist gültig")
'''
        
        hook_path = self.git_hooks_dir / "commit-msg"
        
        try:
            with open(hook_path, 'w') as f:
                f.write(hook_content)
            
            os.chmod(hook_path, stat.S_IRWXU | stat.S_IRGRP | stat.S_IROTH)
            print(f"✅ Commit-Msg-Hook installiert: {hook_path}")
            return True
            
        except Exception as e:
            print(f"❌ Fehler beim Installieren des Commit-Msg-Hooks: {e}")
            return False
    
    def create_hook_config(self):
        """Erstellt eine Konfigurationsdatei für Hooks."""
        config = {
            "pre_commit": {
                "enabled": True,
                "checks": ["syntax", "formatting", "imports", "tests"],
                "auto_fix": True
            },
            "commit_msg": {
                "enabled": True,
                "conventional_commits": True,
                "max_line_length": 72
            }
        }
        
        config_path = self.project_root / ".githooks.json"
        
        try:
            import json
            with open(config_path, 'w') as f:
                json.dump(config, f, indent=2)
            
            print(f"✅ Hook-Konfiguration erstellt: {config_path}")
            return True
            
        except Exception as e:
            print(f"❌ Fehler beim Erstellen der Hook-Konfiguration: {e}")
            return False
    
    def install_all_hooks(self):
        """Installiert alle verfügbaren Hooks."""
        print("🔧 Installiere Git-Hooks für Python-Projekt...")
        
        # Prüfe ob .git Verzeichnis existiert
        if not self.git_hooks_dir.exists():
            print("❌ Kein Git-Repository gefunden (.git/hooks fehlt)")
            return False
        
        success = True
        
        # Installiere Hooks
        hooks = [
            ("Pre-Commit", self.install_pre_commit_hook),
            ("Commit-Msg", self.install_commit_msg_hook),
            ("Konfiguration", self.create_hook_config)
        ]
        
        for hook_name, install_func in hooks:
            print(f"\n⚙️  Installiere {hook_name}-Hook...")
            if not install_func():
                success = False
        
        if success:
            print("\n✅ Alle Git-Hooks erfolgreich installiert!")
            print("\n💡 Die Hooks werden automatisch bei Git-Operationen ausgeführt:")
            print("  - pre-commit: Vor jedem Commit")
            print("  - commit-msg: Bei der Commit-Nachricht")
        else:
            print("\n❌ Einige Hooks konnten nicht installiert werden")
        
        return success

# Verwendungsbeispiel
def main():
    installer = GitHookInstaller()
    installer.install_all_hooks()

if __name__ == "__main__":
    main()
```


## Integration von Tests in Git-Workflows

### Kontinuierliche Integration mit GitHub Actions

```python
# .github/workflows/ci.yml Generator
import yaml
from pathlib import Path

class CIConfigGenerator:
    """Generiert CI/CD-Konfigurationen für Python-Projekte."""
    
    def __init__(self, project_name="python-project"):
        self.project_name = project_name
    
    def generate_github_actions_config(self):
        """Generiert GitHub Actions Workflow."""
        config = {
            'name': 'CI/CD Pipeline',
            'on': {
                'push': {'branches': ['main', 'develop']},
                'pull_request': {'branches': ['main']}
            },
            'jobs': {
                'test': {
                    'runs-on': 'ubuntu-latest',
                    'strategy': {
                        'matrix': {
                            'python-version': ['3.8', '3.9', '3.10', '3.11']
                        }
                    },
                    'steps': [
                        {
                            'uses': 'actions/checkout@v3'
                        },
                        {
                            'name': 'Set up Python ${{ matrix.python-version }}',
                            'uses': 'actions/setup-python@v4',
                            'with': {
                                'python-version': '${{ matrix.python-version }}'
                            }
                        },
                        {
                            'name': 'Install dependencies',
                            'run': '''
                                python -m pip install --upgrade pip
                                pip install -r requirements.txt
                                pip install -r requirements-dev.txt
                            '''.strip()
                        },
                        {
                            'name': 'Lint with flake8',
                            'run': '''
                                flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
                                flake8 . --count --exit-zero --max-complexity=10 --max-line-length=88 --statistics
                            '''.strip()
                        },
                        {
                            'name': 'Test with pytest',
                            'run': 'pytest --cov=. --cov-report=xml'
                        },
                        {
                            'name': 'Upload coverage to Codecov',
                            'uses': 'codecov/codecov-action@v3',
                            'with': {
                                'file': './coverage.xml',
                                'flags': 'unittests',
                                'name': 'codecov-umbrella'
                            }
                        }
                    ]
                },
                'security': {
                    'runs-on': 'ubuntu-latest',
                    'steps': [
                        {'uses': 'actions/checkout@v3'},
                        {
                            'name': 'Run Bandit Security Linter',
                            'run': '''
                                pip install bandit
                                bandit -r . -f json -o bandit-report.json || true
                            '''.strip()
                        },
                        {
                            'name': 'Run Safety Check',
                            'run': '''
                                pip install safety
                                safety check --json --output safety-report.json || true
                            '''.strip()
                        }
                    ]
                }
            }
        }
        
        return config
    
    def save_github_actions_config(self):
        """Speichert die GitHub Actions Konfiguration."""
        config = self.generate_github_actions_config()
        
        # Erstelle .github/workflows Verzeichnis
        workflows_dir = Path('.github/workflows')
        workflows_dir.mkdir(parents=True, exist_ok=True)
        
        # Speichere Konfiguration
        config_path = workflows_dir / 'ci.yml'
        with open(config_path, 'w') as f:
            yaml.dump(config, f, default_flow_style=False, sort_keys=False)
        
        print(f"✅ GitHub Actions Konfiguration gespeichert: {config_path}")
        return config_path

# Git-Integration für automatische Tests
class GitTestIntegration:
    """Integriert Tests in Git-Workflows."""
    
    def __init__(self):
        self.test_results = {}
    
    def run_tests_for_commit(self, commit_hash="HEAD"):
        """Führt Tests für einen spezifischen Commit aus."""
        try:
            # Checkout des spezifischen Commits
            subprocess.run(['git', 'checkout', commit_hash], check=True)
            
            # Tests ausführen
            result = subprocess.run(
                ['python', '-m', 'pytest', '--tb=short', '-v'],
                capture_output=True, text=True
            )
            
            self.test_results[commit_hash] = {
                'passed': result.returncode == 0,
                'output': result.stdout,
                'errors': result.stderr,
                'timestamp': datetime.now().isoformat()
            }
            
            return result.returncode == 0
            
        except Exception as e:
            self.test_results[commit_hash] = {
                'passed': False,
                'error': str(e),
                'timestamp': datetime.now().isoformat()
            }
            return False
    
    def test_branch_commits(self, branch_name="main"):
        """Testet alle Commits in einem Branch."""
        try:
            # Alle Commits im Branch abrufen
            result = subprocess.run(
                ['git', 'log', '--format=%H', branch_name],
                capture_output=True, text=True, check=True
            )
            
            commits = result.stdout.strip().split('\n')
            
            print(f"🔍 Teste {len(commits)} Commits in Branch '{branch_name}'...")
            
            failed_commits = []
            
            for i, commit in enumerate(commits[:10]):  # Nur letzte 10 Commits
                print(f"⚙️  Teste Commit {i+1}/10: {commit[:8]}...")
                
                if not self.run_tests_for_commit(commit):
                    failed_commits.append(commit)
                    print(f"❌ Tests fehlgeschlagen für {commit[:8]}")
                else:
                    print(f"✅ Tests erfolgreich für {commit[:8]}")
            
            # Zurück zum ursprünglichen Branch
            subprocess.run(['git', 'checkout', branch_name], check=True)
            
            return failed_commits
            
        except Exception as e:
            print(f"❌ Fehler beim Testen der Branch-Commits: {e}")
            return []
    
    def generate_test_report(self, output_file="test_report.md"):
        """Generiert einen Test-Bericht."""
        report = ["# Git Test Report", ""]
        
        if not self.test_results:
            report.append("Keine Test-Ergebnisse verfügbar.")
            return "\n".join(report)
        
        passed_count = sum(1 for r in self.test_results.values() if r['passed'])
        total_count = len(self.test_results)
        
        report.extend([
            f"**Gesamt:** {total_count} Commits getestet",
            f"**Erfolgreich:** {passed_count}",
            f"**Fehlgeschlagen:** {total_count - passed_count}",
            "",
            "## Detaillierte Ergebnisse",
            ""
        ])
        
        for commit, result in self.test_results.items():
            status = "✅" if result['passed'] else "❌"
            report.extend([
                f"### {status} Commit {commit[:8]}",
                f"**Zeit:** {result['timestamp']}",
                ""
            ])
            
            if not result['passed']:
                if 'error' in result:
                    report.append(f"**Fehler:** {result['error']}")
                if 'errors' in result and result['errors']:
                    report.extend([
                        "**Test-Fehler:**",
                        "```
                        result['errors'],
                        "```"
                    ])
            
            report.append("")
        
        report_content = "\n".join(report)
        
        # Bericht speichern
        with open(output_file, 'w') as f:
            f.write(report_content)
        
        print(f"📊 Test-Bericht gespeichert: {output_file}")
        return report_content

# Verwendungsbeispiel
def setup_git_test_integration():
    """Richtet vollständige Git-Test-Integration ein."""
    print("🔧 Richte Git-Test-Integration ein...")
    
    # CI/CD Konfiguration generieren
    ci_generator = CIConfigGenerator("mein-python-projekt")
    ci_generator.save_github_actions_config()
    
    # Git-Hooks installieren
    hook_installer = GitHookInstaller()
    hook_installer.install_all_hooks()
    
    # Test-Integration einrichten
    test_integration = GitTestIntegration()
    failed_commits = test_integration.test_branch_commits()
    
    if failed_commits:
        print(f"⚠️  {len(failed_commits)} Commits mit fehlgeschlagenen Tests gefunden")
        test_integration.generate_test_report()
    else:
        print("✅ Alle getesteten Commits haben bestanden")
    
    print("\n🎉 Git-Test-Integration vollständig eingerichtet!")

if __name__ == "__main__":
    setup_git_test_integration()
```


## Best Practices für Team-Workflows

### Team-Workflow-Manager

```python
class TeamWorkflowManager:
    """Verwaltet und durchsetzt Team-Workflow-Standards."""
    
    def __init__(self, team_config="team_config.json"):
        self.config = self.load_team_config(team_config)
        self.workflow_rules = self.setup_workflow_rules()
    
    def load_team_config(self, config_file):
        """Lädt Team-spezifische Konfiguration."""
        default_config = {
            "workflow_type": "github_flow",
            "branch_protection": {
                "main": {
                    "require_pr": True,
                    "require_reviews": 2,
                    "require_tests": True
                }
            },
            "naming_conventions": {
                "feature_branches": "feature/",
                "bugfix_branches": "bugfix/",
                "hotfix_branches": "hotfix/"
            },
            "commit_conventions": "conventional_commits",
            "auto_merge": False
        }
        
        try:
            with open(config_file, 'r') as f:
                user_config = json.load(f)
                default_config.update(user_config)
        except FileNotFoundError:
            print(f"⚠️  Team-Konfiguration {config_file} nicht gefunden - verwende Standardwerte")
        
        return default_config
    
    def setup_workflow_rules(self):
        """Definiert Workflow-Regeln basierend auf Konfiguration."""
        rules = []
        
        if self.config['workflow_type'] == 'git_flow':
            rules.extend([
                self.check_git_flow_branches,
                self.check_git_flow_merges
            ])
        elif self.config['workflow_type'] == 'github_flow':
            rules.extend([
                self.check_github_flow_branches,
                self.check_pull_request_requirements
            ])
        
        if self.config['commit_conventions'] == 'conventional_commits':
            rules.append(self.check_conventional_commits)
        
        return rules
    
    def check_github_flow_branches(self):
        """Überprüft GitHub Flow Branch-Konventionen."""
        try:
            # Aktueller Branch
            current_branch = subprocess.run(
                ['git', 'branch', '--show-current'],
                capture_output=True, text=True, check=True
            ).stdout.strip()
            
            # Branch-Naming prüfen
            if current_branch != 'main':
                prefixes = list(self.config['naming_conventions'].values())
                if not any(current_branch.startswith(prefix) for prefix in prefixes):
                    return False, f"Branch '{current_branch}' folgt nicht den Naming-Konventionen: {prefixes}"
            
            return True, f"Branch '{current_branch}' ist korrekt benannt"
            
        except Exception as e:
            return False, f"Fehler bei Branch-Check: {e}"
    
    def check_pull_request_requirements(self):
        """Überprüft Pull Request Anforderungen."""
        # Dies würde normalerweise über GitHub API gemacht
        # Hier eine vereinfachte lokale Prüfung
        
        try:
            # Prüfe ob Branch ahead of main ist
            result = subprocess.run(
                ['git', 'rev-list', '--count', 'main..HEAD'],
                capture_output=True, text=True, check=True
            )
            
            commits_ahead = int(result.stdout.strip())
            
            if commits_ahead == 0:
                return False, "Keine neuen Commits für Pull Request"
            
            # Prüfe Commit-Nachrichten
            result = subprocess.run(
                ['git', 'log', '--format=%s', f'main..HEAD'],
                capture_output=True, text=True, check=True
            )
            
            commit_messages = result.stdout.strip().split('\n')
            
            for msg in commit_messages:
                if len(msg.strip()) < 10:
                    return False, f"Commit-Nachricht zu kurz: '{msg}'"
            
            return True, f"Bereit für Pull Request mit {commits_ahead} Commits"
            
        except Exception as e:
            return False, f"Fehler bei PR-Requirements-Check: {e}"
    
    def check_conventional_commits(self):
        """Überprüft Conventional Commits Format."""
        try:
            result = subprocess.run(
                ['git', 'log', '--format=%s', 'main..HEAD'],
                capture_output=True, text=True, check=True
            )
            
            commit_messages = result.stdout.strip().split('\n')
            conventional_pattern = r'^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .+'
            
            invalid_commits = []
            for msg in commit_messages:
                if msg.strip() and not re.match(conventional_pattern, msg):
                    invalid_commits.append(msg)
            
            if invalid_commits:
                return False, f"Commits folgen nicht Conventional Commits: {invalid_commits}"
            
            return True, "Alle Commits folgen Conventional Commits"
            
        except Exception as e:
            return False, f"Fehler bei Conventional Commits Check: {e}"
    
    def validate_workflow(self):
        """Validiert den aktuellen Workflow-Status."""
        print("🔍 Validiere Team-Workflow...")
        
        all_passed = True
        results = []
        
        for rule in self.workflow_rules:
            rule_name = rule.__name__.replace('check_', '').replace('_', ' ').title()
            print(f"⚙️  Prüfe {rule_name}...")
            
            passed, message = rule()
            results.append((rule_name, passed, message))
            
            if passed:
                print(f"✅ {rule_name}: {message}")
            else:
                print(f"❌ {rule_name}: {message}")
                all_passed = False
        
        return all_passed, results
    
    def generate_workflow_guide(self):
        """Generiert eine Anleitung für den Team-Workflow."""
        guide = [
            f"# {self.config['workflow_type'].title()} Team-Workflow Guide",
            "",
            "## Branch-Strategie",
            ""
        ]
        
        if self.config['workflow_type'] == 'github_flow':
            guide.extend([
                "### GitHub Flow",
                "1. Erstelle einen Feature-Branch von main",
                "2. Arbeite an deinem Feature und committe regelmäßig",
                "3. Öffne einen Pull Request",
                "4. Diskussion und Code Review",
                "5. Merge in main nach erfolgreichem Review",
                ""
            ])
        
        guide.extend([
            "## Branch-Naming-Konventionen",
            ""
        ])
        
        for branch_type, prefix in self.config['naming_conventions'].items():
            guide.append(f"- **{branch_type.replace('_', ' ').title()}**: `{prefix}beschreibung`")
        
        if self.config['commit_conventions'] == 'conventional_commits':
            guide.extend([
                "",
                "## Commit-Konventionen (Conventional Commits)",
                "",
                "- `feat:` Neue Features",
                "- `fix:` Bugfixes", 
                "- `docs:` Dokumentation",
                "- `style:` Code-Formatierung",
                "- `refactor:` Code-Refactoring",
                "- `test:` Tests hinzufügen/ändern",
                "- `chore:` Build/Tools/Dependencies",
                "",
                "**Beispiel:** `feat(auth): add user authentication`"
            ])
        
        guide.extend([
            "",
            "## Pull Request Prozess",
            "",
            f"- Mindestens {self.config['branch_protection']['main']['require_reviews']} Reviews erforderlich",
            "- Alle Tests müssen bestehen",
            "- Branch muss up-to-date mit main sein",
            ""
        ])
        
        return "\n".join(guide)

# Verwendungsbeispiel
def setup_team_workflow():
    """Richtet Team-Workflow-Management ein."""
    workflow_manager = TeamWorkflowManager()
    
    # Workflow validieren
    passed, results = workflow_manager.validate_workflow()
    
    if passed:
        print("\n✅ Team-Workflow ist korrekt konfiguriert!")
    else:
        print("\n❌ Team-Workflow hat Probleme:")
        for rule_name, rule_passed, message in results:
            if not rule_passed:
                print(f"  - {rule_name}: {message}")
    
    # Workflow-Guide generieren
    guide = workflow_manager.generate_workflow_guide()
    with open('WORKFLOW_GUIDE.md', 'w') as f:
        f.write(guide)
    
    print(f"\n📖 Workflow-Guide erstellt: WORKFLOW_GUIDE.md")

if __name__ == "__main__":
    setup_team_workflow()
```

Dieses Modul vermittelt fortgeschrittene Git-Techniken und moderne Team-Workflows. Die Beispiele zeigen, wie Sie Git in professionellen Entwicklungsumgebungen einsetzen, automatisierte Qualitätschecks implementieren und effektive Zusammenarbeit in Entwicklungsteams ermöglichen. Die praktischen Python-Skripte können direkt in realen Projekten verwendet werden, um Entwicklungsworkflows zu verbessern und Code-Qualität sicherzustellen.