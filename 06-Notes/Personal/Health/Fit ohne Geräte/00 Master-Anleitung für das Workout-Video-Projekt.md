## Phase 1: Die Installation (CachyOS & Windows)

Du nutzt auf beiden Systemen die jeweils nativen Paketmanager.

### Auf CachyOS (Linux):

Öffne dein aktuelles Terminal und tippe:
```bash
sudo pacman -S wezterm helix nushell ffmpeg
# 'uv' für das Python-Management:
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Auf Windows:

Öffne die PowerShell als Administrator:
```powershell
winget install wezterm.wezterm helix.helix nushell.nushell gyan.ffmpeg
# 'uv' für Windows:
powershell -c "irmo https://astral.sh/uv/install.ps1 | iex"
```
---

## Phase 2: Der "Treibstoff" (Gemini API Key)

Damit **aider** (dein KI-Programmierer) kostenlos mit Gemini sprechen kann:

1. Gehe auf **[Google AI Studio](https://aistudio.google.com/)**.
2. Klicke auf **"Get API key"** -> **"Create API key in new project"**.
3. Kopiere den Key (speichere ihn sicher).
	- `AIzaSyB0R82ujwPBiIhb53vBA9pCfWaVv1hp7tc`

---

## Phase 3: Die Konfiguration (Der "Vibe"-Faktor)

Jetzt verbinden wir die Tools, damit sie Hand in Hand arbeiten.

### 1. Nushell (Deine Schaltzentrale)

Wir hinterlegen den API-Key, damit du ihn nicht jedes Mal eintippen musst.
Tippe in deiner Nushell:
```nushell
config env # öffnet die Umgebungsdatei
```

Füge am Ende hinzu:
```nushell
$env.GEMINI_API_KEY = "AIzaSyB0R82ujwPBiIhb53vBA9pCfWaVv1hp7tc"
```
### 2. WezTerm (Dein Fenster zur Welt)

Erstelle/bearbeite die `wezterm.lua` (Pfad: `~/.config/wezterm/wezterm.lua` oder unter Windows im Home-Verzeichnis).
```lua
-- ~/.config/wezterm/wezterm.lua  (Linux)
-- %USERPROFILE%\.wezterm.lua     (Windows)
local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

-- Ziel: plattformübergreifend Nushell + Solarized + Nerd Font

-- OS-Erkennung
local target = wezterm.target_triple

-- Standard-Shell je nach OS
if target:find("windows") then
  -- Pfad wurde von winget/scoop in PATH gelegt; plain "nu" reicht meist
  config.default_prog = { "nu.exe" }
else
  -- Unter CachyOS via pacman installiert: Binary "nu"
  config.default_prog = { "nu" }
end

-- Nerd Font setzen
config.font = wezterm.font_with_fallback({
  { family = "FiraCode Nerd Font", weight = "Regular" },
  "Symbols Nerd Font",
})

config.font_size = 11.0
config.initial_cols = 120
config.initial_rows = 35

-- Solarized automatisch nach Dark/Light wählen
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find('Dark') then
    return 'Builtin Solarized Dark'
  else
    return 'Builtin Solarized Light'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())
-- Alternativ fest: config.color_scheme = 'Solarized Dark (Gogh)'
-- oder: config.color_scheme = 'Solarized (dark) (terminal.sexy)'[^77][^80][^83]

-- Qualitatives Terminal-Tuning
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

-- Keybindings-Beispiele (optional)
config.keys = {
-- Fenster horizontal teilen (Alt + d)
    { key = 'd', mods = 'ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    -- Fenster vertikal teilen (Alt + Shift + d)
    { key = 'D', mods = 'ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    -- Zwischen Fenstern springen (Alt + Pfeiltasten)
    { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
}

return config
```

### 3. Helix (Dein Editor)

Erstelle/bearbeite die `config.toml` (Pfad: `~/.config/helix/config.toml` oder `%AppData%\helix\config.toml`).
```toml
[editor]
line-number = "relative" # Hilft beim schnellen Navigieren im Code
cursor-shape.insert = "bar"
mouse = false # Wir bleiben auf der Tastatur!

[keys.normal]
"A-left" = "jump_view_left"
"A-right" = "jump_view_right"
"A-up" = "jump_view_up"
"A-down" = "jump_view_down"
```

---

## Phase 4: Aider installieren & Projekt starten

Jetzt installieren wir den KI-Partner und legen los.

1. **Aider installieren (via uv):**
```nushell
uv tool install --python 3.11 aider-chat
```
2. **Projektordner vorbereiten:**
    
    Gehe in deinen Workout-Ordner.
    
3. **Die Coding-Session starten:**
    - Öffne `WezTerm`.
    - Teile den Bildschirm mit `Alt + d`.
    - **Links (Helix):** Tippe `helix workout_video.py`.
    - **Rechts (Aider):** Tippe `aider --model gemini/gemini-2.5-flash`.
4.  **Verfügbare Modelle auflisten**
    - Wenn du sichergehen willst, was dein API-Key tatsächlich freischaltet:
```nushell
http get $"https://generativelanguage.googleapis.com/v1beta/models?key=($env.GEMINI_API_KEY)"
| get models
| where supportedGenerationMethods has "generateContent"
| where name =~ "gemini"
| select -i name displayName description
| sort-by name
```
---

## Phase 5: Der "Vibe Coding" Workflow

Jetzt arbeitest du **iterativ**:

1. **Aider eine Aufgabe geben:**
    
    Schreib im rechten Fenster (Aider):
    
    > "Füge dem Skript eine Funktion hinzu, die am Ende des Videos eine Zusammenfassung aller Übungen als Text-Overlay anzeigt."
    
2. **Zusehen:** Aider schreibt den Code, erstellt einen Git-Commit und speichert die Datei.
    
3. **Kontrollieren:** Helix (links) zeigt dir den neuen Code sofort an.
    
4. **Testen:** Tippe im rechten Fenster (einfach Aider mit `Strg+C` pausieren oder ein drittes Pane öffnen):
```nushell
uv run workout_video.py "Zirkel 1.md"
```


### Warum dieses Setup für dich als Beginner perfekt ist:

- **Kein "Copy-Paste":** Aider schreibt direkt in deine Datei.
- **Undo-Sicherheit:** Wenn Gemini Blödsinn macht, tippe in Aider `/undo`.
- **Nushell-Power:** Du kannst deine Videodateien mit `ls | where size > 10mb` sortieren – viel logischer als in der alten Bash.

**Bist du bereit für den ersten Testlauf?** Wenn du den API-Key hast, können wir aider zusammen deine erste Aufgabe geben!