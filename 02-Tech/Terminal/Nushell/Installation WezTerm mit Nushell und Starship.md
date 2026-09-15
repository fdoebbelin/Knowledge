Du bekommst:

- auf **Windows** und **CachyOS** dieselbe Terminal‑„Experience“
- mit **WezTerm** (Solarized Theme, Nerd Font),
- **Nushell** als Standardshell,
- **Starship** als zweizeiliger Prompt (mit Nerd Font Icons),
- Konfiguration so geschrieben, dass sie auf beiden Plattformen funktioniert, mit minimalen OS‑Branches.

***

## 1. Komponenten und Übersicht

**Komponenten**

- Terminal: **WezTerm** (GPU‑beschleunigt, Multiplexing, plattformübergreifend)[^1][^2]
- Shell: **Nushell**[^3]
- Prompt: **Starship** mit offizieller Nushell‑Integration[^4][^5]
- Theme: **Solarized** in WezTerm (eingebaute Schemes)[^6][^7][^8]
- Font: geeigneter **Nerd Font** (z.B. „FiraCode Nerd Font“)

***

## 2. Vorbereitung: Nerd Font installieren

### 2.1 Windows (ohne Admin, so weit wie möglich)

1. Lade einen Nerd Font, z.B. **FiraCode Nerd Font**, von
[https://www.nerdfonts.com](https://www.nerdfonts.com) (Browser, Download ins Benutzerprofil).
2. ZIP entpacken, TTF‑Dateien markieren, Rechtsklick **„Install for me“ / „Nur für diesen Benutzer installieren“**.

WezTerm greift automatisch auf installierte Fonts zu; du musst nur den Namen in `wezterm.lua` eintragen.[^7][^6]

### 2.2 CachyOS (Arch‑basiert)

Variante A (systemweit, einfachste Variante):

```bash
sudo pacman -S ttf-firacode-nerd
```

Variante B (strict Userspace): Nerd Font manuell wie unter Windows ins Home‑Verzeichnis laden und in `~/.local/share/fonts` legen, dann:

```bash
mkdir -p ~/.local/share/fonts
# TTF-Dateien dort ablegen
fc-cache -fv
```


***

## 3. Installation unter Windows (Userspace mit winget / scoop)

### 3.1 winget prüfen/aktivieren

- Prüfen:

```powershell
winget --version
```

Falls nicht vorhanden, siehe Microsoft‑Doku zur Installation von WinGet bzw. Bootstrapping via `Repair-WinGetPackageManager`.[^9][^10]

### 3.2 Nushell per winget (User‑Scope)

Nushell unterstützt explizit User‑Scope über winget:[^11][^3]

```powershell
winget install Nushell.Nushell --scope user
```


### 3.3 WezTerm und Starship mit scoop

Für konsequenten Userspace ist **scoop** sehr angenehm, da es standardmäßig im Benutzerprofil installiert.

1. Scoop installieren (einmalig, PowerShell *als Benutzer* mit ExecutionPolicy für CurrentUser anpassen).
2. Dann:
```powershell
scoop install wezterm starship
```

Beide landen im User‑Space, meist unter `~/scoop/apps/...`.

***

## 4. Installation unter CachyOS

### 4.1 Paketmanager (empfohlen, auch wenn nicht 100 % Userspace)

```bash
sudo pacman -S nushell starship wezterm
```


### 4.2 Strikter Userspace (optional)

Wenn du auf CachyOS auf Root verzichten willst:

- Rust‑Toolchain installieren, dann z.B.:

```bash
cargo install nu
cargo install starship
# WezTerm: am besten über Distribution-Paket, da eigene Abhängigkeiten[^70]
```

Für WezTerm würde ich auf Arch/CachyOS trotz „Userspace‑Philosophie“ den Paketmanager nehmen; das spart erheblich Wartungsaufwand und ist robust.[^2][^12]

***

## 5. Gemeinsame Starship‑Konfiguration (zweizeiliger Prompt, Nerd Font)

### 5.1 Starship Basis‑Setup (Nushell)

Offizieller Weg laut Starship‑Doku für Nushell:[^5][^4]

In **Nushell**, einmalig:

```nu
mkdir ($nu.data-dir | path join "vendor/autoload")

starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
```

Dadurch wird ein Autoload‑Script erzeugt, das bei jedem Start von Nushell geladen wird und den Prompt auf Starship umstellt.[^4][^5]

### 5.2 `starship.toml` für zweizeiligen Prompt

Datei: `~/.config/starship.toml` (gilt unter Windows und Linux gleichermaßen).[^13][^14][^5]

```toml
# ~/.config/starship.toml

"$schema" = 'https://starship.rs/config-schema.json'

# Leere Zeile zwischen Prompts => zweizeiliger Look
add_newline = true

# Globales Prompt-Format: erste Zeile Infos, zweite Zeile das Prompt-Symbol
format = """
$username$hostname$directory$git_branch$git_status
$character
"""

# Farben und Symbole (Nerd Font) für das Prompt-Symbol
[character]
success_symbol = "[](bold green)"   # Nerd Font Symbol
error_symbol   = "[](bold red)"

# Verzeichnis-Modul
[directory]
truncation_length = 3
style = "bold blue"

# Git Branch
[git_branch]
symbol = " "
style = "bold yellow"

[git_status]
style = "yellow"

# Optional: kleine Nu-Markierung
[custom.nu]
command = "echo 🦀"
when = "false"
```

- `add_newline = true` sorgt für eine Leerzeile zwischen zwei Prompts – visuell hast du dann zwei Zeilen pro Prompt.[^14][^13]
- Durch das `format`‑Template erzwingst du: **Zeile 1** Status/Infos, **Zeile 2** das Zeichen.

***

## 6. Nushell‑Konfig (Windows und CachyOS)

Aktuelle Nushell‑Doku empfiehlt `config.nu` und `env.nu` im Nushell‑Konfigverzeichnis.[^3][^4]

### 6.1 Pfade ermitteln

In Nushell:

```nu
$nu.config-path
$nu.env-path
$nu.data-dir
```

Dort liegen bzw. landen:

- `config.nu` (Hauptkonfiguration)
- `env.nu` (Umgebungsvariablen)
- `vendor/autoload/starship.nu` (von `starship init nu` erzeugt)[^5][^4]


### 6.2 Beispiel `env.nu`

```nu
# env.nu

# Beispiel: zusätzliche Programme in PATH aufnehmen, plattformabhängig
if $nu.os-info.name == "windows" {
    $env.PATH = ($env.PATH | append "C:\\Users\\$env.USERNAME\\scoop\\shims")
} else {
    $env.PATH = ($env.PATH | append "/usr/local/bin")
}

# Wichtig für Starship laut Nushell-Doku[^73]
$env.STARSHIP_SHELL = "nu"
```

Die offizielle Nushell‑Starship‑Integration setzt u.a. `STARSHIP_SHELL` und erzeugt passende Prompt‑Funktionen.[^4][^5]

### 6.3 Beispiel `config.nu`

Minimal, um Autoload‑Mechanismus sicherzustellen (falls nicht schon automatisch):

```nu
# config.nu

# Stelle sicher, dass vendor/autoload geladen wird (normalerweise ab Nu >= 0.90 Standard)
let autoload_dir = ($nu.data-dir | path join "vendor/autoload")

if ($autoload_dir | path exists) {
    for file in (ls $autoload_dir | where type == "file" | get name) {
        use $file
    }
}

# Weitere Nu-spezifische Einstellungen (History, Aliases, etc.)
$env.config = {
    history: {
        sync_on_enter: true
        max_size: 10000
    }
}
```

Durch das `use $file` wird auch `starship.nu` eingebunden, falls Nushell das nicht schon automatisch erledigt.[^4]

***

## 7. WezTerm‑Konfiguration (Solarized + Nerd Font + Nushell als Default)

### 7.1 Ort der Konfiguration

- Linux/CachyOS: `~/.config/wezterm/wezterm.lua`
- Windows: `%USERPROFILE%\.wezterm.lua` *oder* `%USERPROFILE%\AppData\Local\wezterm\wezterm.lua` (WezTerm akzeptiert mehrere Standardorte, siehe Doku/Diskussionen).[^15][^16][^17]


### 7.2 Solarized in WezTerm

WezTerm bringt diverse Solarized‑Varianten als eingebaute Color‑Schemes mit, z.B.:[^8][^6][^7]

- `'Builtin Solarized Dark'` / `'Builtin Solarized Light'`
- `'Solarized Dark (Gogh)'`
- `'Solarized (dark) (terminal.sexy)'`

Du kannst entweder hart ein Scheme wählen oder dynamisch nach System‑Appearance umschalten.[^7][^8]

### 7.3 Gemeinsame `wezterm.lua` (für Windows + CachyOS)

```lua
-- ~/.config/wezterm/wezterm.lua  (Linux)
-- %USERPROFILE%\.wezterm.lua     (Windows)
local wezterm = require 'wezterm'

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
  -- Neue Pane vertikal
  {
    key = "d",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  -- Neue Pane horizontal
  {
    key = "D",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
}

return config
```

- `default_prog` stellt sicher, dass **Nushell** beim Öffnen eines neuen WezTerm‑Fensters startet – sowohl unter Windows als auch auf CachyOS.[^18][^19][^2]
- `color_scheme` verwendet Solarized abhängig davon, ob dein System im Dark/Light‑Mode läuft, nach offiziellem Beispiel aus der WezTerm‑Doku.[^8][^7]

***

## 8. Cross‑Plattform‑Ablauf zum Einrichten

1. **Fonts**
    - Nerd Font auf beiden Systemen wie oben beschrieben installieren.
2. **Programme installieren**
    - Windows: `winget install Nushell.Nushell --scope user`, `scoop install wezterm starship`.[^20][^11][^9]
    - CachyOS: `sudo pacman -S nushell wezterm starship` (oder Userspace‑Installationen).
3. **Nushell starten**
    - In beiden Systemen einmal `nu` starten.
4. **Starship für Nushell aktivieren**
    - Im laufenden Nushell:

```nu
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
```


[^5][^4]
5. **`starship.toml` erstellen**

- `~/.config/starship.toml` mit dem oben gezeigten zweizeiligen Prompt anlegen.[^13][^14][^5]

6. **`config.nu` und `env.nu` anpassen**
    - Pfade via `$nu.config-path`, `$nu.env-path` auslesen.
    - Beispiele aus Abschnitt 6 eintragen, insbesondere `STARSHIP_SHELL = "nu"` im `env.nu`.[^3][^4]
7. **WezTerm konfigurieren**
    - `wezterm.lua` wie oben an einem passenden Ort ablegen.
    - WezTerm neu starten oder `CTRL+SHIFT+R` für Config‑Reload nutzen.[^7]

Danach solltest du auf **Windows** und **CachyOS**:

- beim Start von WezTerm direkt in **Nushell** landen,
- denselben **Solarized**‑Look,
- denselben **zweizeiligen Starship‑Prompt mit Nerd‑Font‑Symbolen** sehen.

Wenn du möchtest, kann als nächster Schritt eine „dotfiles‑Faltung“ kommen: also ein kleines Git‑Repo, das genau diese `wezterm.lua`, `starship.toml` sowie `config.nu`/`env.nu` strukturiert verwaltet und Cross‑Plattform‑Symlinks/Skripte bereitstellt.