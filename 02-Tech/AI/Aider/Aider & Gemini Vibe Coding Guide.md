Dieses Dokument enthält die optimale Konfiguration für die Arbeit mit `aider` und der Gemini API im **Paid Tier**, um Kosten zu kontrollieren und die Rate-Limits zu umgehen.

## 1. Modell-Wechsel Befehle

Je nach Komplexität der Aufgabe solltest du das passende Modell wählen, um Token zu sparen.

### Standard: Gemini 2.5 Flash (Beste Balance)

Ideal für die meisten Coding-Aufgaben.

```
aider --model gemini/gemini-2.5-flash
```

### Sparsam: Gemini 2.5 Flash-Lite (Low Cost)

Für einfache Refactorings, CSS-Änderungen oder Dokumentation.

```
aider --model gemini/gemini-2.5-flash-lite
```

### High-End: Gemini 2.5 Pro (Komplexe Logik)

Wenn Flash bei schwierigen Bugs scheitert. Achtung: Teurer!

```
aider --model gemini/gemini-2.5-pro
```

## 2. Optimale `.aider.conf.yml`

Erstelle diese Datei in deinem Projektverzeichnis oder global in deinem Home-Verzeichnis, um `aider` effizient einzustellen. Diese Einstellungen aktivieren das **Context Caching**, was deine Kosten bei langen Sessions massiv senkt.

```
# Modell-Einstellungen
model: gemini/gemini-2.5-flash

# Kosten- und Kontext-Optimierung
cache-prompts: true
map-tokens: 1024

# UI & Workflow
stream: true
architect: true
dark-mode: true

# Auto-Commit (optional)
commit: true
```

## 3. Kosten-Checkliste für Obsidian

- [ ] **Billing Cap gesetzt?** (In Google AI Studio auf 10-20$ limitiert)
    
- [ ] **.aiderignore vorhanden?** Stelle sicher, dass `node_modules`, `.git` und Build-Ordner ignoriert werden.
    
- [ ] **Context Caching aktiv?** Mit `--cache-prompts` (in der Config oben enthalten) zahlst du für den Projekt-Kontext nach dem ersten Request deutlich weniger.
    
- [ ] **Session-Management:** Starte `aider` neu, wenn du das Thema komplett wechselst, um den Cache für relevante Dateien frisch zu halten.
    

## 4. Hilfreiche Aider Chat-Befehle

|   |   |
|---|---|
|**Befehl**|**Zweck**|
|`/tokens`|Zeigt an, wie viele Token die aktuelle Session verbraucht (wichtig für Kostenkontrolle).|
|`/add <file>`|Fügt Dateien zum Kontext hinzu (nur was nötig ist!).|
|`/drop <file>`|Entfernt Dateien aus dem Kontext, um Token zu sparen.|
|`/clear`|Leert den Chat-Verlauf, um den Prompt wieder kurz und günstig zu machen.|

_Erstellt am: 04. Mai 2026 für Vibe Coding mit Gemini 2.5_