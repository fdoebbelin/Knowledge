## Modul-Übersicht
- **Dauer:** 2 Unterrichtseinheiten (UE)
- **Zielgruppe:** Absolute Programmieranfänger
- **Voraussetzungen:** Git-Grundlagen (M19), lokale Repositories, erste Commits und Branches
- **Lernziele:** Erweiterte Git-Operationen beherrschen, Remote-Repositories verwenden, Kollaborations-Grundlagen

## UE 1: Erweiterte lokale Git-Operationen (45 min)

### M20.1 - Fortgeschrittene Branch-Workflows und Änderungsverwaltung

**Lernziele:**
- Komplexere Branch-Strategien verstehen und anwenden
- Änderungen rückgängig machen und korrigieren
- Git-Workflow für größere Projekte optimieren
- Merge-Konflikte erkennen und einfache Fälle lösen
- Projekthistorie gezielt manipulieren

**Inhalte:**
1. **Erweiterte Branch-Operationen**
   - Feature-Branches für größere Entwicklungen
   - `git checkout -b` für schnelle Branch-Erstellung
   - Branch-Strategien: feature/, bugfix/, hotfix/
   - Mehrere parallele Features entwickeln

2. **Änderungen rückgängig machen**
   - `git checkout -- datei.py` für einzelne Dateien
   - `git reset HEAD datei.py` für Staging rückgängig
   - `git commit --amend` für letzte Commit-Nachricht ändern
   - Vorsicht bei destructiven Operationen

3. **Einfache Merge-Konflikte lösen**
   - Was sind Merge-Konflikte und warum entstehen sie?
   - Konflikt-Marker verstehen: `<<<<<<<`, `=======`, `>>>>>>>`
   - Konflikte manuell in Editor lösen
   - `git add` und `git commit` nach Konfliktlösung

4. **Projekthistorie verstehen**
   - `git log --graph --oneline` für visuelle Darstellung
   - `git show commit-hash` für Details
   - `git diff commit1..commit2` für Vergleiche
   - Historie als Projektdokumentation nutzen

**Praktisches Beispiel:**
- Studentenverwaltung mit mehreren parallel entwickelten Features
- Bewusst Merge-Konflikte erzeugen und lösen
- Branch-Strategie für strukturierte Entwicklung

---

## UE 2: Remote-Repositories und GitHub-Grundlagen (45 min)

### M20.2 - Erste Schritte mit Remote-Repositories

**Lernziele:**
- Unterschied zwischen lokalem und Remote-Repository verstehen
- GitHub-Account erstellen und Repository anlegen
- Code mit push/pull/clone zwischen lokal und remote synchronisieren
- Grundlagen der Kollaboration mit anderen Entwicklern
- README und Projektdokumentation auf GitHub

**Inhalte:**
1. **Remote-Repository Konzept**
   - Lokales vs. Remote Repository
   - GitHub als Git-Hosting-Service
   - Andere Alternativen: GitLab, Bitbucket
   - Warum Remote-Repositories wichtig sind

2. **GitHub-Setup für Anfänger**
   - GitHub-Account erstellen
   - Erstes Repository auf GitHub anlegen
   - SSH-Keys vs. HTTPS (einfacher für Anfänger)
   - Repository-Einstellungen verstehen

3. **Push, Pull und Clone**
   - `git remote add origin` für Verbindung
   - `git push -u origin main` für ersten Upload
   - `git pull origin main` für Updates holen
   - `git clone url` für Repository kopieren

4. **Grundlegende Kollaboration**
   - Repository forken (Copy erstellen)
   - Änderungen in eigenem Fork machen
   - Pull Request Konzept verstehen
   - README.md für Projektdokumentation

**Praktisches Beispiel:**
- Lokales Python-Projekt auf GitHub veröffentlichen
- README mit Projektbeschreibung erstellen
- Änderungen zwischen lokal und GitHub synchronisieren
- Einfachen Kollaborations-Workflow simulieren

---

## Unterthemen-Struktur

### M20.1: Fortgeschrittene Branch-Workflows und Änderungsverwaltung
- **M20.1.1** - Demonstration: Erweiterte Git-Operationen und Konfliktlösung
- **M20.1.2** - Aufgaben: Multi-Feature-Entwicklung mit Branch-Management
- **M20.1.3** - Musterlösung: Professioneller lokaler Git-Workflow

### M20.2: Erste Schritte mit Remote-Repositories
- **M20.2.1** - Demonstration: GitHub-Integration und Remote-Operationen
- **M20.2.2** - Aufgaben: Python-Projekt auf GitHub veröffentlichen
- **M20.2.3** - Musterlösung: Vollständiger Remote-Workflow

---

## Methodische Hinweise

### Für Programmieranfänger angepasst:
- **Aufbau auf M19:** Erweitert bekannte Konzepte statt neue Grundlagen
- **Praktische Konflikte:** Realistische aber lösbare Merge-Konflikte
- **GitHub-Fokus:** Populärste Plattform für Anfänger-freundlichen Einstieg
- **Schrittweise Remote-Einführung:** Erst verstehen, dann anwenden

### Technische Umsetzung:
- **Reale Projekte:** Python-Code aus vorherigen Modulen verwenden
- **Strukturierte Workflows:** Klare Branch-Strategien für Anfänger
- **Fehlerbehandlung:** Häufige Remote-Probleme und deren Lösung
- **Visual Learning:** GitHub-Interface und Git-Graphs zeigen

### Schwierigkeitsgrad:
- **Einfache Konflikte:** Nur grundlegende Merge-Konflikte behandeln
- **HTTPS statt SSH:** Weniger Konfigurationsaufwand für Anfänger
- **Ein Remote:** Komplexe Multi-Remote-Setups vermeiden
- **Grundlegende Kollaboration:** Fork/PR-Konzept verstehen, nicht komplex anwenden

---

## Praktische Workflow-Beispiele

### Erweiterte lokale Entwicklung:
```bash
# Feature-Branch für neue Funktion
git checkout -b feature/calculator-division
echo "def divide(a, b): return a / b" >> calculator.py
git add calculator.py
git commit -m "Add division function"

# Zurück zu main für Bugfix
git checkout main
git checkout -b hotfix/fix-typo
# Bugfix machen
git add .
git commit -m "Fix typo in main function"

# Hotfix mergen
git checkout main
git merge hotfix/fix-typo

# Feature mergen (möglicherweise mit Konflikt)
git merge feature/calculator-division
# Konflikt lösen falls nötig
git branch -d feature/calculator-division
git branch -d hotfix/fix-typo
```

### GitHub-Integration:
```bash
# Lokales Repository mit GitHub verbinden
git remote add origin https://github.com/username/my-project.git

# Ersten Push
git push -u origin main

# Änderungen machen und hochladen
echo "# My Calculator Project" > README.md
git add README.md
git commit -m "Add project documentation"
git push origin main

# Updates von GitHub holen
git pull origin main
```

---

## Erwartete Lernergebnisse

Nach Abschluss des Moduls können die Teilnehmer:
- ✅ Komplexere Branch-Strategien für Feature-Entwicklung anwenden
- ✅ Einfache Merge-Konflikte erkennen und manuell lösen
- ✅ Änderungen mit checkout, reset und amend korrigieren
- ✅ GitHub-Account erstellen und Repository anlegen
- ✅ Code zwischen lokalem und Remote-Repository synchronisieren
- ✅ Push, pull und clone Operationen durchführen
- ✅ README-Datei für Projektdokumentation erstellen
- ✅ Grundlegende Kollaborations-Konzepte verstehen

## Integration in den Gesamtkurs

Das Modul baut auf auf:
- **M19:** Git-Grundlagen und erste Branches (direkte Fortsetzung)
- **M16-18:** Module und sauberer Code (wird jetzt professionell verwaltet)
- **Alle Python-Module:** Projekte die jetzt auf GitHub veröffentlicht werden

Das Modul bereitet vor auf:
- **M36:** Fortgeschrittene Git-Techniken und Team-Workflows
- **M33-35:** Unit Testing (Tests in Git und GitHub verwalten)
- **Alle nachfolgenden Module:** Professionelle Open-Source-Entwicklung
- **Karriere:** Portfolio auf GitHub für Bewerbungen

## Häufige Probleme und Lösungen

### Typische Stolpersteine:
1. **Merge-Konflikte-Angst**
   - Problem: Panik bei ersten Konflikten
   - Lösung: Schritt-für-Schritt Anleitung und Übung

2. **GitHub-Authentifizierung**
   - Problem: Push-Probleme wegen fehlender Berechtigung
   - Lösung: HTTPS mit Personal Access Token

3. **Remote-Verwirrung**
   - Problem: Unklarheit über lokale vs. remote Änderungen
   - Lösung: `git status` und `git remote -v` regelmäßig nutzen

4. **Branch-Chaos**
   - Problem: Zu viele Branches, unklare Namen
   - Lösung: Klare Naming-Conventions und Branch-Cleanup

### Qualitätssicherung

### Erweiterte Git-Operationen Checkliste:
- [ ] Feature-Branches haben beschreibende Namen
- [ ] Merge-Konflikte werden systematisch gelöst
- [ ] Historie ist sauber und nachvollziehbar
- [ ] Destructive Operationen werden vermieden
- [ ] Branch-Cleanup wird regelmäßig durchgeführt

### Remote-Repository Checkliste:
- [ ] GitHub-Repository ist korrekt konfiguriert
- [ ] README.md beschreibt das Projekt verständlich
- [ ] Push/Pull funktioniert zuverlässig
- [ ] Lokale und remote Branches sind synchron
- [ ] Commit-Messages sind auch remote verständlich