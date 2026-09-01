**Claude Code ist Anthropics KI-gestütztes Coding-Tool, das direkt im Terminal läuft und auf natürliche Sprachbefehle reagiert** – ideal für „Vibe Coding", bei dem man beschreibt, *was* man will, statt selbst Code zu schreiben. Seit 2025 unterstützt Claude Code Windows 10/11 nativ. Die npm-Installation ist offiziell **veraltet (deprecated)**; stattdessen empfiehlt Anthropic den nativen Installer, der weder Node.js noch npm benötigt. Für die Nutzung braucht man mindestens ein Claude-Pro-Abo ($20/Monat) oder API-Guthaben über die Anthropic Console – ein kostenloses Konto reicht nicht aus. Dieses Tutorial führt Schritt für Schritt durch Installation, Einrichtung und die ersten eigenen Python-Projekte per Vibe Coding.

---

## Was genau ist Claude Code und was kann es?

Claude Code ist ein **agentisches Coding-Werkzeug**, das im Terminal lebt, die gesamte Projektstruktur versteht und über natürliche Sprache gesteuert wird. Man tippt eine Beschreibung ein – auf Deutsch oder Englisch – und Claude Code schreibt den Code, erstellt Dateien, führt Terminal-Befehle aus und behebt Fehler. Das Tool wurde von Anthropic entwickelt und basiert auf den Claude-Sprachmodellen (aktuell u.a. Sonnet 4.6 und Opus 4.6).

Die wichtigsten Fähigkeiten im Überblick: Claude Code **generiert Code** über mehrere Dateien hinweg, **bearbeitet bestehende Dateien** mit reversiblen Änderungen, **führt Terminal-Befehle** aus (Build-Tools, Git, Paketmanager), **erklärt Code** und Projektstrukturen, **schreibt und startet Tests**, und übernimmt komplette **Git-Workflows** inklusive Commits, Branches und Pull Requests. Zusätzlich bietet es erweiterte Features wie CLAUDE.md als Projektgedächtnis, einen Plan-Modus für durchdachtes Vorgehen bei komplexen Aufgaben, und Subagenten für parallele Teilaufgaben.

Die aktuelle Version liegt bei circa **2.1.x** (Stand März 2026; das Tool wird häufig aktualisiert). Die offizielle Dokumentation findet sich unter **code.claude.com/docs/en/overview**, das GitHub-Repository unter **github.com/anthropics/claude-code** mit über 65.000 Sternen. Claude Code lässt sich im Terminal, in VS Code, in JetBrains-IDEs, als Desktop-App und seit Kurzem auch im Browser unter claude.ai/code nutzen.

---

## Installation auf Windows 10/11 in drei Schritten

### Voraussetzungen

| Anforderung | Details |
|---|---|
| **Betriebssystem** | Windows 10 oder Windows 11 |
| **RAM** | Mindestens 4 GB |
| **Git for Windows** | Muss installiert sein (enthält Git Bash, das Claude Code intern nutzt) |
| **Internetverbindung** | Erforderlich für Authentifizierung und KI-Verarbeitung |
| **Node.js** | **Nicht nötig** bei nativer Installation (nur bei veralteter npm-Methode: Node.js 18+) |

### Schritt 1: Git for Windows installieren

Falls Git noch nicht installiert ist, laden Sie es von **git-scm.com/downloads/win** herunter und installieren es mit den Standardeinstellungen. Claude Code benötigt das enthaltene Git Bash, um intern Befehle auszuführen.

### Schritt 2: Claude Code installieren (empfohlene Methode)

Öffnen Sie **PowerShell** (nicht als Administrator nötig) und führen Sie diesen einen Befehl aus:

```powershell
irm https://claude.ai/install.ps1 | iex
```

Dieser Befehl lädt den offiziellen Anthropic-Installer herunter und installiert Claude Code als eigenständige Anwendung. Kein Node.js, kein npm, kein Scoop nötig. Die Installation ist von „Anthropic, PBC" signiert.

**Alternative über WinGet** (Windows-Paketmanager):
```powershell
winget install Anthropic.ClaudeCode
```

**Alternative über CMD** (Eingabeaufforderung):
```cmd
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

### Schritt 3: Terminal neu starten und testen

Schließen Sie das Terminal-Fenster und öffnen es neu (damit die PATH-Änderung wirkt). Dann testen:

```powershell
claude --version
```

Wenn die Versionsnummer erscheint, war die Installation erfolgreich. Falls stattdessen „claude wird nicht erkannt" erscheint, fügen Sie den Installationspfad manuell zum PATH hinzu:

```powershell
[Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$env:USERPROFILE\.local\bin", [EnvironmentVariableTarget]::User)
$env:PATH = "$env:PATH;$env:USERPROFILE\.local\bin"
```

Falls Claude Code Git Bash nicht findet, setzen Sie den Pfad explizit:
```powershell
$env:CLAUDE_CODE_GIT_BASH_PATH="C:\Program Files\Git\bin\bash.exe"
```

> **Hinweis zur veralteten npm-Methode:** Die Kombination `scoop install nodejs` → `npm install -g @anthropic-ai/claude-code` funktioniert technisch noch, ist aber **offiziell veraltet** (deprecated). Der native Installer ist schneller, hat keine Abhängigkeiten und aktualisiert sich automatisch im Hintergrund. Für dieses Tutorial verwenden wir ausschließlich die empfohlene native Installation.

**Updates** erfolgen bei der nativen Installation automatisch. Bei WinGet manuell: `winget upgrade Anthropic.ClaudeCode`. Den Installationsstatus können Sie jederzeit mit `claude doctor` prüfen.

---

## Authentifizierung und Kosten einrichten

### Methode A: Browser-Login (empfohlen für Einsteiger)

Beim ersten Start von `claude` öffnet sich automatisch ein Browserfenster zur Anmeldung. Sie können sich mit einem **Claude-Pro-** oder **Max-Konto** (claude.ai) oder einem **Console-Konto** (console.anthropic.com) einloggen. Falls der Browser sich nicht öffnet, drücken Sie `c`, um die Login-URL in die Zwischenablage zu kopieren.

### Methode B: API-Key als Umgebungsvariable

Für die Nutzung über die API erstellen Sie einen Schlüssel auf **console.anthropic.com** → Einstellungen → API Keys. Der Key beginnt mit `sk-ant-`.

**Temporär setzen** (nur aktuelle PowerShell-Sitzung):
```powershell
$env:ANTHROPIC_API_KEY = "sk-ant-ihr-key-hier"
```

**Dauerhaft setzen** (überlebt Neustarts, gilt ab dem nächsten Terminal-Fenster):
```powershell
[Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "sk-ant-ihr-key-hier", [EnvironmentVariableTarget]::User)
```

Oder per CMD:
```cmd
setx ANTHROPIC_API_KEY "sk-ant-ihr-key-hier"
```

> **Wichtig:** `setx` speichert dauerhaft, wirkt aber erst in **neu geöffneten** Terminal-Fenstern.

### Was kostet Claude Code?

**Das kostenlose Claude-Konto reicht nicht aus.** Für Claude Code brauchen Sie mindestens eine der folgenden Optionen:

| Plan | Preis | Claude-Code-Zugang |
|---|---|---|
| **Free** | $0/Monat | ❌ Kein Zugang |
| **Pro** | $20/Monat | ✅ Inklusive |
| **Max 5x** | $100/Monat | ✅ Inklusive, 5× mehr Nutzung |
| **Max 20x** | $200/Monat | ✅ Inklusive, 20× mehr Nutzung |
| **Console (API)** | Pay-per-Use | ✅ Per API-Key |

**Günstigster Einstieg:** Auf **console.anthropic.com** ein neues Konto erstellen – neue Nutzer erhalten dort **$5 Startguthaben** ohne Kreditkarte. Damit lassen sich erste Projekte testen.

Die aktuellen **API-Preise pro Million Tokens** (Stand 2026):

| Modell | Input | Output |
|---|---|---|
| **Claude Sonnet 4 / 4.5 / 4.6** | $3,00 | $15,00 |
| **Claude Haiku 4.5** | $1,00 | $5,00 |
| **Claude Opus 4.5 / 4.6** | $5,00 | $25,00 |

Für typisches Vibe Coding mit Sonnet rechnet Anthropic mit durchschnittlich **ca. $6 pro Tag**. Wer viel nutzt, fährt mit einem Max-Abo oft günstiger als mit API-Abrechnung.

---

## Der interaktive Modus: Befehle und Bedienung

### Claude Code starten

Navigieren Sie im Terminal zu Ihrem Projektordner und starten Sie Claude Code:

```powershell
mkdir MeinProjekt
cd MeinProjekt
claude
```

Claude Code arbeitet immer im aktuellen Verzeichnis – es kann Dateien dort lesen, erstellen und bearbeiten. Sie tippen Ihre Anweisungen einfach als normalen Text ein und drücken **Enter** zum Absenden. Für **mehrzeilige Eingaben** nutzen Sie `\` am Zeilenende und dann Enter, oder fügen mehrzeiligen Text direkt per Copy-Paste ein.

### Die wichtigsten Slash-Befehle

Tippen Sie `/` gefolgt vom Befehlsnamen. Die Befehle, die für Einsteiger am relevantesten sind:

| Befehl | Was er tut |
|---|---|
| `/help` | Zeigt alle verfügbaren Befehle mit kurzer Beschreibung |
| `/init` | Analysiert das Projekt und erstellt automatisch eine CLAUDE.md-Datei |
| `/clear` | Löscht den Gesprächsverlauf, startet eine frische Sitzung |
| `/compact` | Komprimiert die Konversation, um Kontext-Fenster zu sparen (50–70% Token-Reduktion) |
| `/cost` | Zeigt den bisherigen Token-Verbrauch und die Kosten der aktuellen Sitzung |
| `/doctor` | Diagnosetool – prüft Installation, Konfiguration und Authentifizierung |
| `/model` | Wechselt das KI-Modell (z.B. von Sonnet zu Haiku oder Opus) |
| `/rewind` | Setzt Code und Gespräch auf einen früheren Punkt zurück (auch per Esc+Esc) |
| `/exit` | Beendet Claude Code |
| `/login` | Wechselt das Konto oder authentifiziert neu |
| `/logout` | Meldet Sie ab |
| `/config` | Öffnet die Einstellungsoberfläche (Berechtigungen, Themes, Benachrichtigungen) |
| `/review` | Vollständiges Code-Review der letzten Git-Änderungen |
| `/memory` | CLAUDE.md im Editor öffnen und bearbeiten |
| `/permissions` | Berechtigungen verwalten (was Claude lesen/schreiben/ausführen darf) |
| `/context` | Zeigt, wie viel vom Kontext-Fenster belegt ist |

### Das Berechtigungssystem (y/n-Bestätigungen)

Claude Code fragt vor jeder potenziell verändernden Aktion um Erlaubnis. Wenn es eine Datei erstellen oder bearbeiten möchte, sehen Sie die geplante Änderung und können mit **y** (einmalig erlauben) oder **n** (ablehnen) reagieren. Mit **Shift+Tab** wechseln Sie zwischen drei Modi: **Normal** (fragt bei jeder Änderung), **Auto-Accept** (genehmigt Dateiänderungen automatisch) und **Plan-Modus** (Claude plant nur, ändert nichts).

### Dateien referenzieren mit @

Tippen Sie **@** gefolgt vom Dateinamen, um eine Datei direkt in den Kontext einzubinden. Beispiel: `Erkläre mir @src/main.py` – Claude liest die Datei und bezieht sie in die Antwort ein. Die @-Syntax bietet Autovervollständigung: Nach dem @ erscheinen Vorschläge aus der Projektstruktur.

### Nützliche Tastenkombinationen

**Ctrl+C** bricht die laufende Generierung ab, **Esc** stoppt die Antwort, **Esc+Esc** spult zum letzten Checkpoint zurück, **Tab** schaltet erweitertes Denken ein/aus. Mit dem Präfix **!** vor einem Befehl (z.B. `! python test.py`) führen Sie Shell-Befehle direkt aus, ohne dass Claude sie interpretiert.

---

## CLAUDE.md als Projektgedächtnis nutzen

CLAUDE.md ist eine Markdown-Datei im Projektstammverzeichnis, die Claude Code **automatisch bei jedem Sitzungsstart liest**. Sie funktioniert wie ein Briefing-Dokument: Hier hinterlegen Sie Projektregeln, Konventionen und Anweisungen, die Claude über alle Sitzungen hinweg beachtet.

**Erstellen per /init:** Der Befehl `/init` analysiert das vorhandene Projekt (Git-Historie, Dateistruktur, Abhängigkeiten) und generiert eine passende CLAUDE.md automatisch. Bei neuen, leeren Projekten können Sie die Datei auch manuell erstellen.

**Was gehört in die CLAUDE.md?** Projektbeschreibung und Tech-Stack, Build- und Test-Befehle (z.B. `python -m pytest`), Coding-Konventionen (z.B. „Variablen auf Deutsch benennen"), Verbote (z.B. „Lösche NIEMALS Dateien im Ordner /daten/"), und eine kurze Übersicht der Ordnerstruktur. Anthropic empfiehlt, die Datei **unter 200 Zeilen** zu halten – bei dieser Länge befolgt Claude **92%** der Anweisungen, verglichen mit nur 71% bei über 400 Zeilen. Verwenden Sie klare, **imperative Formulierungen** („Verwende 4 Leerzeichen für Einrückungen" statt „Das Projekt verwendet 4 Leerzeichen").

Es gibt eine vierstufige Hierarchie: Die Nutzer-CLAUDE.md unter `~/.claude/CLAUDE.md` gilt für alle Projekte, die Projekt-CLAUDE.md im Stammverzeichnis gilt fürs Team (per Git teilbar), und eine optionale `CLAUDE.local.md` gilt nur für Sie persönlich. Spezifischere Dateien überschreiben allgemeinere. Mit dem **#**-Präfix direkt im Chat (z.B. `# Immer beschreibende Variablennamen verwenden`) fügen Sie schnell neue Regeln zur CLAUDE.md hinzu.

---

## Vibe Coding: Der komplette Workflow für Anfänger

Vibe Coding bedeutet: **Sie beschreiben, was Sie wollen – Claude Code baut es.** Der Begriff stammt von KI-Forscher Andrej Karpathy und beschreibt einen Entwicklungsansatz, bei dem man keine Programmiersprache beherrschen muss. Sie sind der Produktmanager, Claude ist der Entwickler.

### Der typische Ablauf in fünf Phasen

**Phase 1 – Projekt vorbereiten:** Erstellen Sie einen leeren Ordner und starten Sie Claude Code darin.
```powershell
mkdir TaschenrechnerProjekt
cd TaschenrechnerProjekt
claude
```

**Phase 2 – Planen lassen:** Beschreiben Sie Ihr Vorhaben und bitten Sie Claude, **zuerst zu planen**. Das Wort „planen" oder „think" aktiviert den Planungsmodus, in dem Claude die Architektur durchdenkt, bevor es Code schreibt.
```
Ich möchte einen Taschenrechner als Python-Programm für die Kommandozeile.
Er soll die vier Grundrechenarten beherrschen und Fehler abfangen.
Bitte erst planen, dann umsetzen.
```

**Phase 3 – Generieren und bestätigen:** Claude zeigt seinen Plan und beginnt nach Ihrer Bestätigung mit dem Erstellen der Dateien. Bei jeder Dateiänderung werden Sie gefragt – bestätigen Sie mit `y`.

**Phase 4 – Testen:** Führen Sie den Code direkt aus der Claude-Code-Sitzung aus:
```
! python calculator.py
```
Oder melden Sie Probleme direkt: „Der Dividieren-Button gibt einen Fehler bei 0 – bitte beheben."

**Phase 5 – Iterieren:** Fordern Sie Änderungen an: „Füge eine Prozentrechnung hinzu" oder „Mach die Ausgabe übersichtlicher mit Farben". Nutzen Sie `/rewind`, falls etwas schiefgeht, und `/cost`, um die Kosten im Blick zu behalten.

### Tipps für gute Prompts

Seien Sie **konkret statt vage**: Nicht „Mach eine App", sondern „Erstelle ein Python-Programm für die Kommandozeile, das Temperaturen zwischen Celsius, Fahrenheit und Kelvin umrechnet." Beschreiben Sie den **gewünschten Endzustand**: „Der Nutzer soll eine Kategorie wählen, einen Wert eingeben und das Ergebnis in allen verfügbaren Einheiten sehen." Für komplexere Aufgaben fügen Sie **„think hard"** oder **„denk gründlich nach"** hinzu – das aktiviert tieferes Reasoning. Und nach der Code-Generierung: Sagen Sie **„Erkläre mir den Code"**, um zu verstehen, was gebaut wurde.

---

## Fünf Python-Projekte zum Ausprobieren

Die folgenden Projekte eignen sich perfekt für den Einstieg ins Vibe Coding. Kopieren Sie den jeweiligen Prompt einfach in Claude Code. Voraussetzung: Python muss auf dem System installiert sein (prüfen mit `python --version` in PowerShell). Falls Python nicht installiert ist, bitten Sie Claude einfach: „Wie installiere ich Python unter Windows?"

### Projekt 1: Taschenrechner

```
Erstelle einen Python-Taschenrechner für die Kommandozeile. Funktionen:
Addition, Subtraktion, Multiplikation, Division. Fehlerbehandlung für
Division durch Null und ungültige Eingaben. Der Benutzer soll beliebig
viele Rechnungen durchführen können, bis er "quit" eingibt. Zeige das
Ergebnis immer auf 2 Dezimalstellen gerundet.
```

### Projekt 2: To-Do-Liste mit Speicherfunktion

```
Erstelle eine Python To-Do-Liste für die Kommandozeile mit diesen
Funktionen: Aufgaben hinzufügen, als erledigt markieren, alle Aufgaben
anzeigen (mit Status), Aufgaben löschen. Speichere die Liste in einer
JSON-Datei, damit sie beim nächsten Start noch vorhanden ist. Zeige ein
nummeriertes Menü zur Bedienung.
```

### Projekt 3: Zahlenraten-Spiel

```
Erstelle ein Zahlenraten-Spiel in Python. Der Computer wählt eine
zufällige Zahl zwischen 1 und 100. Der Spieler rät und bekommt Hinweise
("zu hoch" / "zu niedrig"). Am Ende zeige die Anzahl der Versuche und
eine Bewertung (unter 5 = super, unter 8 = gut, sonst = naja). Füge
drei Schwierigkeitsgrade hinzu: leicht (1-50), mittel (1-100),
schwer (1-500).
```

### Projekt 4: Text-Adventure

```
Erstelle ein Text-Adventure-Spiel in Python. Setting: ein geheimnisvoller
Dungeon mit mindestens 6 Räumen. In jedem Raum gibt es eine Beschreibung
und 2-3 Entscheidungsmöglichkeiten. Füge hinzu: ein Inventar-System
(Gegenstände aufheben und benutzen), Lebenspunkte (starten bei 100),
und mindestens einen Endgegner. Das Spiel soll ein gutes und ein
schlechtes Ende haben.
```

### Projekt 5: Einheiten-Umrechner

```
Erstelle einen Einheiten-Umrechner in Python mit diesen Kategorien:
Länge (km, m, cm, mm, Meilen, Fuß, Zoll), Gewicht (kg, g, mg, Pfund,
Unzen), Temperatur (Celsius, Fahrenheit, Kelvin). Der Benutzer wählt
eine Kategorie, gibt den Wert und die Ausgangs-Einheit ein, und sieht
das Ergebnis in allen verfügbaren Ziel-Einheiten gleichzeitig.
```

Nach jeder Generierung können Sie den Code mit `! python dateiname.py` direkt testen. Tritt ein Fehler auf, kopieren Sie die Fehlermeldung einfach in den Chat: „Ich bekomme diesen Fehler: [Fehlermeldung]" – Claude diagnostiziert und behebt das Problem automatisch. Nutzen Sie `/clear` zwischen verschiedenen Projekten, um den Kontext freizugeben und Tokens zu sparen.

---

## Fazit: Schnellstart-Checkliste und nächste Schritte

Der schnellste Weg von null zu einem funktionierenden Python-Projekt auf Windows umfasst genau sechs Schritte: Git for Windows installieren, Claude Code per `irm https://claude.ai/install.ps1 | iex` installieren, Terminal neu starten, sich mit Pro-Abo oder Console-API-Key authentifizieren, einen Projektordner anlegen und mit `claude` starten, und dann in natürlicher Sprache beschreiben, was man bauen möchte.

Drei Erkenntnisse, die dieses Tutorial von veralteten Anleitungen unterscheidet: Erstens ist die **npm-Installation offiziell deprecated** – der native Installer ist in jeder Hinsicht besser und einfacher. Zweitens erfordert Claude Code **mindestens ein Pro-Abo oder API-Guthaben** – die kostenlose Stufe reicht nicht. Drittens unterstützt Claude Code **Windows seit 2025 nativ** über Git for Windows, ohne dass WSL eingerichtet werden muss. Wer sich das Startguthaben von $5 auf console.anthropic.com sichert, kann die ersten Projekte völlig kostenlos umsetzen und ausprobieren, ob Vibe Coding der richtige Einstieg in die Programmierung ist.

Weiterführende Ressourcen: Die offizielle Dokumentation unter **code.claude.com/docs/en/overview**, das GitHub-Repository unter **github.com/anthropics/claude-code**, und die Anthropic-Preisseite unter **anthropic.com/pricing**.