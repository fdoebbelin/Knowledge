Dieses Dokument fasst das Setup für dein Workout-Video-Projekt zusammen. Ziel ist es, nur relevante Code-Dateien zu tracken und Probleme beim Wechsel zwischen Windows und Linux (via Obsidian Sync) zu vermeiden.

## 1. Die Whitelist-Strategie (.gitignore)

Anstatt jede Datei einzeln auszuschließen, verwenden wir einen "Whitelist"-Ansatz. Wir ignorieren erst alles und definieren dann die Ausnahmen.

**Vorteil:** Neue Videos oder Notizen in deinem Obsidian-Ordner landen niemals versehentlich im Git-Repository.

### Inhalt der `.gitignore`

```
# Alles im Hauptverzeichnis ignorieren
/*

# Ausnahmen (Diese Dateien werden getrackt)
!workout_video.py
!.gitignore
!.gitattributes
!README.md
```

## 2. Zeilenumbrüche beherrschen (.gitattributes)

Da du zwischen **Windows (CRLF)** und **Linux (LF)** wechselst (via Obsidian Sync), könnten "Ghost Changes" auftreten. Git würde Zeilenänderungen anzeigen, die nur auf unsichtbaren Zeilenumbrüchen basieren.

### Warum `.gitattributes`?

Sie erzwingt Regeln direkt im Repository, unabhängig von deinen lokalen Git-Einstellungen.

### Inhalt der `.gitattributes`

```
# Automatische Erkennung für alle Textdateien
* text=auto

# Python-Dateien explizit auf Linux-Zeilenumbrüche (LF) festlegen
# Das verhindert Probleme, wenn das Skript auf Linux ausgeführt wird
*.py text eol=lf
```

## 3. Workflow-Befehle

Hier ist die Reihenfolge der Befehle, um dein System sauber zu halten:

### Einmalige Konfiguration (Lokal)

Empfohlen für Windows-Nutzer, um die Konvertierung beim Auschecken zu automatisieren:

```
git config --global core.autocrlf true
```

### Änderungen speichern

Wenn du an `workout_video.py` gearbeitet hast oder die Config-Dateien erstellt hast:

1. **Status prüfen:**
    
    ```
    git status
    ```
    
    _Es sollten nur die Dateien in der Whitelist erscheinen._
    
2. **Dateien stagen:**
    
    ```
    git add .
    ```
    
3. **Commit erstellen:**
    
    ```
    git commit -m "Whitelist konfiguriert und Zeilenumbrüche fixiert"
    ```
    

## 4. Tipps für Obsidian Sync + Git

- **Keine Konflikte:** Obsidian Sync kümmert sich um die Dateiinhalte. Git kümmert sich um die Versionierung des Codes.
    
- **Git-Verzeichnis:** Der Ordner `.git` wird von Obsidian Sync normalerweise ignoriert. Das ist gut so! Jedes Gerät sollte sein eigenes lokales Git-Management behalten oder du nutzt Git nur auf einem Hauptgerät zur Archivierung.
    
- **LF-Warnung:** Die Warnung `LF will be replaced by CRLF` beim `git add` kannst du jetzt ignorieren. Git teilt dir lediglich mit, dass es die Datei intern auf den Standard (LF) korrigiert, damit sie auf Linux funktioniert.
    

_Dokumentation erstellt für das Workout-Video-Projekt._