## Modul-Übersicht
- **Dauer:** 2 Unterrichtseinheiten (UE)
- **Zielgruppe:** Absolute Programmieranfänger
- **Voraussetzungen:** Grundlagen Python-Syntax, Funktionen, Module, sauberer Code
- **Lernziele:** Git-Grundlagen verstehen, lokale Repositories verwalten, erste Schritte mit Branching

## UE 1: Git-Grundlagen und lokales Repository (45 min)

### M19.1 - Git Installation und erste Commits

**Lernziele:**
- Verstehen was Versionskontrolle ist und warum sie wichtig ist
- Git installieren und konfigurieren
- Lokales Repository erstellen und verwalten
- Erste Commits mit add, commit und status durchführen
- Änderungen verfolgen und Projekthistorie verstehen

**Inhalte:**
1. **Was ist Versionskontrolle?**
   - Problem: Dateien wie "projekt_final_v2_wirklich_final.py"
   - Lösung: Systematische Verfolgung von Änderungen
   - Git als Standard-Tool für Versionskontrolle
   - Vorteile: Backup, Geschichte, Zusammenarbeit

2. **Git Installation und Konfiguration**
   - Git für Windows/Mac/Linux installieren
   - Erste Konfiguration: `git config --global user.name/email`
   - Git Bash vs. Terminal/Kommandozeile
   - Überprüfung der Installation mit `git --version`

3. **Erstes lokales Repository erstellen**
   - `git init` für neues Repository
   - `.git` Ordner verstehen (nicht anfassen!)
   - Working Directory vs. Repository
   - Einfaches Python-Projekt als Beispiel

4. **Grundlegende Git-Befehle verwenden**
   - `git status` - Was ist der aktuelle Zustand?
   - `git add datei.py` - Dateien für Commit vormerken
   - `git commit -m "Nachricht"` - Änderungen dauerhaft speichern
   - `git log` - Projektgeschichte anzeigen

**Praktisches Beispiel:**
- Taschenrechner-Projekt schrittweise entwickeln
- Jede neue Funktion als separater Commit
- Änderungen verfolgen und Historie durchgehen

---

## UE 2: Änderungen verwalten und erste Branches (45 min)

### M19.2 - Projekthistorie und einfaches Branching

**Lernziele:**
- Projekthistorie navigieren und verstehen
- Änderungen zwischen Commits vergleichen
- Concept von Branches für Anfänger verstehen
- Einfache Branches erstellen und wechseln
- Grundlagen des Zusammenführens (Merging)

**Inhalte:**
1. **Projekthistorie verstehen**
   - `git log --oneline` für übersichtliche Geschichte
   - Commit-Hashes und ihre Bedeutung
   - `git show` für Details eines Commits
   - Zeitreise: Alten Zustand ansehen (read-only)

2. **Änderungen vergleichen**
   - `git diff` für ungespeicherte Änderungen
   - `git diff --staged` für vorgemerkte Änderungen
   - Unterschiede zwischen Versionen verstehen
   - Praktische Anwendung bei Code-Änderungen

3. **Branches für Anfänger**
   - Was sind Branches? (Parallele Entwicklungsstränge)
   - `git branch` - Verfügbare Branches anzeigen
   - `git branch feature-name` - Neuen Branch erstellen
   - `git checkout branch-name` - Zwischen Branches wechseln
   - `git checkout -b new-branch` - Erstellen und wechseln

4. **Einfaches Merging**
   - Branches wieder zusammenführen
   - `git merge feature-branch` Grundlagen
   - Fast-Forward Merges verstehen
   - Branch nach Merge löschen

**Praktisches Beispiel:**
- Feature-Branch für neue Taschenrechner-Funktionen
- Separate Entwicklung von Addition und Multiplikation
- Branches zusammenführen zum Hauptprojekt

---

## Unterthemen-Struktur

### M19.1: Git Installation und erste Commits
- **M19.1.1** - Demonstration: Git-Grundlagen und lokales Repository
- **M19.1.2** - Aufgaben: Notiz-App mit Git verwalten
- **M19.1.3** - Musterlösung: Systematische Versionierung

### M19.2: Projekthistorie und einfaches Branching
- **M19.2.1** - Demonstration: Branches und Merging für Anfänger
- **M19.2.2** - Aufgaben: Feature-Entwicklung mit Branches
- **M19.2.3** - Musterlösung: Professioneller Git-Workflow

---

## Methodische Hinweise

### Für Programmieranfänger angepasst:
- **Lokaler Fokus:** Erst lokales Git, später Remote-Repositories
- **Konkrete Projekte:** Python-Code aus vorherigen Modulen verwenden
- **Schrittweise Einführung:** Ein Git-Konzept nach dem anderen
- **Praktische Übungen:** Echte Entwicklungsszenarien simulieren

### Technische Umsetzung:
- **Kommandozeilen-Fokus:** Git-Befehle direkt lernen statt GUI-Tools
- **Einfache Projekte:** Kleine Python-Skripte für Git-Übungen
- **Fehlerbehandlung:** Häufige Git-Probleme und deren Lösung
- **Best Practices:** Von Anfang an gute Git-Gewohnheiten

### Schwierigkeitsgrad:
- **Essenzielle Befehle:** Nur die wichtigsten Git-Kommandos
- **Keine komplexen Szenarien:** Merge-Konflikte erst später
- **Praktische Anwendung:** Git für echte Programmier-Projekte
- **Visuelle Hilfsmittel:** Einfache Diagramme für Git-Konzepte

---

## Praktische Git-Workflow Beispiele

### Typischer Anfänger-Workflow:
```bash
# 1. Neues Projekt starten
git init mein-projekt
cd mein-projekt

# 2. Erste Datei erstellen und committen
echo "print('Hallo Welt')" > main.py
git add main.py
git commit -m "Erstes Python-Programm hinzugefügt"

# 3. Änderungen machen
echo "print('Wie geht es dir?')" >> main.py
git add main.py
git commit -m "Begrüßung erweitert"

# 4. Status und Historie prüfen
git status
git log --oneline
```

### Einfacher Branch-Workflow:
```bash
# 1. Feature-Branch erstellen
git checkout -b rechner-addition

# 2. Neue Funktion entwickeln
echo "def addiere(a, b): return a + b" > rechner.py
git add rechner.py
git commit -m "Addition-Funktion hinzugefügt"

# 3. Zurück zu main und mergen
git checkout main
git merge rechner-addition

# 4. Feature-Branch löschen
git branch -d rechner-addition
```

---

## Erwartete Lernergebnisse

Nach Abschluss des Moduls können die Teilnehmer:
- ✅ Git installieren und grundlegend konfigurieren
- ✅ Lokale Repositories erstellen und verwalten
- ✅ Dateien mit add, commit und status verwalten
- ✅ Projekthistorie mit log und show durchsuchen
- ✅ Einfache Branches erstellen und zwischen ihnen wechseln
- ✅ Branches mit einfachen Merges zusammenführen
- ✅ Git-Workflow für eigene Python-Projekte anwenden
- ✅ Grundlegende Git-Terminologie verstehen und verwenden

## Integration in den Gesamtkurs

Das Modul baut auf auf:
- **M16:** Module (die jetzt versioniert werden)
- **M17-18:** Sauberer Code (der besser zu verwalten ist)
- **Alle vorherigen Module:** Python-Projekte die mit Git verwaltet werden

Das Modul bereitet vor auf:
- **M20:** Erweiterte Git-Operationen und Remote-Repositories
- **M33-35:** Unit Testing (Tests in Git verwalten)
- **M36:** Team-Workflows mit Git
- **Alle nachfolgenden Module:** Professionelle Versionskontrolle

## Häufige Anfänger-Probleme und Lösungen

### Typische Stolpersteine:
1. **Vergessene Git-Konfiguration**
   - Problem: Commits ohne Autor-Info
   - Lösung: `git config --global` Setup

2. **Vergessenes `git add`**
   - Problem: Leere Commits oder Verwirrung
   - Lösung: `git status` immer vor `git commit`

3. **Unklare Commit-Messages**
   - Problem: "fix", "update", "changes"
   - Lösung: Beschreibende Nachrichten wie "Add calculator function"

4. **Branch-Verwirrung**
   - Problem: Nicht wissen auf welchem Branch man ist
   - Lösung: `git branch` und `git status` regelmäßig nutzen

### Qualitätssicherung

### Git-Grundlagen Checkliste:
- [ ] Git ist installiert und konfiguriert
- [ ] Repository wurde mit `git init` erstellt
- [ ] Commits haben aussagekräftige Nachrichten
- [ ] `git status` wird vor jedem Commit geprüft
- [ ] Projekthistorie ist mit `git log` verständlich

### Branch-Workflow Checkliste:
- [ ] Feature-Branches haben beschreibende Namen
- [ ] Commits sind logisch auf Branches aufgeteilt
- [ ] Merges sind erfolgreich ohne Konflikte
- [ ] Alte Feature-Branches werden gelöscht
- [ ] Main-Branch bleibt stabil und funktional