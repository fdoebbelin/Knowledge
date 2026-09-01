Dieser Leitfaden zeigt die Installation und Konfiguration eines modernen Entwicklungsumfelds auf Windows mit **Nushell**, **Helix Editor**, **Starship Prompt** und **Solarized Dark Theme** für Windows Terminal – primär über `winget` und Nushell-Befehle.

## Voraussetzungen

- **Windows 10/11** mit aktuellem Windows Terminal
- **winget** (standardmäßig auf Windows 11 und modernen Windows 10-Versionen verfügbar)[^1][^2]
- Administrator-Rechte für einige Schritte

***

## Phase 1: Nushell Installation

### 1.1 Nushell mit winget installieren

Öffne PowerShell oder Windows Terminal und führe aus:

```powershell
# User-Scope Installation (Standard, keine Admin-Rechte)
winget install Nushell.Nushell

# ODER: Machine-Scope Installation (als Administrator, für alle Benutzer)
winget install Nushell.Nushell --override 'ALLUSERS=1'
```

**Installationspfade**:[^3]

- User-Scope: `%LOCALAPPDATA%\Programs\nu\`
- Machine-Scope: `C:\Program Files\nu\`


### 1.2 Nushell starten und konfigurieren

Nach der Installation starte Nushell:

```powershell
nu
```

Beim ersten Start erstellt Nushell automatisch die Konfigurationsdateien:[^4]

- `env.nu` - Umgebungsvariablen und Startskript
- `config.nu` - Nushell-Hauptkonfiguration

**Konfigurationspfade anzeigen**:

```nu
$nu.config-path    # Zeigt Pfad zu config.nu
$nu.env-path       # Zeigt Pfad zu env.nu
```

Typischer Pfad: `%APPDATA%\nushell\`

***

## Phase 2: Helix Editor Installation

### 2.1 Helix mit winget installieren

```nu
# In Nushell oder PowerShell
^winget install Helix.Helix
```

**Wichtig**: Nach der Installation muss der PATH möglicherweise manuell korrigiert werden, da winget den Pfad manchmal falsch setzt.[^5]

### 2.2 PATH-Korrektur (falls notwendig)

**Prüfen, ob Helix gefunden wird**:

```nu
which hx
```

Falls `command not found`, führe in PowerShell (als Administrator) aus:

```powershell
# Finde Helix-Installation
$helixPath = Get-ChildItem -Path "$env:LOCALAPPDATA\Microsoft\WinGet\Packages" -Recurse -Filter "hx.exe" | Select-Object -First 1 -ExpandProperty Directory

# Füge zum User-PATH hinzu
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
[Environment]::SetEnvironmentVariable("Path", "$currentPath;$helixPath", "User")

# PATH-Änderung sofort laden
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
```

**Neustart der Shell**, dann testen:

```nu
hx --version
```


### 2.3 Helix als Standard-Editor für Nushell setzen

Bearbeite `config.nu`:

```nu
config nu
```

Füge hinzu:

```nu
# Standard-Editor für Nushell
$env.EDITOR = "hx"
$env.VISUAL = "hx"
```


***

## Phase 3: Starship Prompt Installation

### 3.1 Starship mit winget installieren

```nu
^winget install --id Starship.Starship
```

Alternative über Cargo (falls Rust installiert ist):

```nu
cargo install starship --locked
```


### 3.2 Nerd Font installieren

Starship benötigt eine Nerd Font für Icons. Empfohlene Fonts:[^6][^2]

**Automatische Installation über winget**:

```nu
# JetBrains Mono Nerd Font
winget install --id=DEVCOM.JetBrainsMonoNerdFont -e
```

**Manuelle Installation FiraCode Nerd Font**:

1. Download von [nerdfonts.com](https://www.nerdfonts.com/)
2. Entpacke und installiere `.ttf`-Dateien (Rechtsklick → Installieren)
3. Empfohlene Fonts: FiraCode Nerd Font, Cascadia Code NF, JetBrains Mono NF

### 3.3 Starship für Nushell konfigurieren

**Methode 1: Automatische Konfiguration (empfohlen)**[^2][^7][^6]

In Nushell ausführen:

```nu
# Starship-Initialisierungsskript erstellen
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
```

Nushell lädt automatisch alle Skripte aus `vendor/autoload/`.[^7][^2]

**Methode 2: Manuelle Konfiguration**[^6]

Bearbeite `env.nu`:

```nu
config env
```

Füge am Ende hinzu:

```nu
# Starship-Shell-Variable setzen
$env.STARSHIP_SHELL = "nu"

# Starship-Cache-Verzeichnis (optional)
$env.STARSHIP_CACHE = ($nu.cache-dir | path join "starship")
```

Bearbeite `config.nu`:

```nu
config nu
```

Füge am Ende hinzu:

```nu
# Starship Prompt-Funktion
def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Prompt-Konfiguration
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "
```


### 3.4 Starship neu laden

```nu
# Konfiguration neu laden
source $nu.config-path

# ODER: Nushell neu starten
exit
nu
```


***

## Phase 4: Windows Terminal mit Nushell-Profil konfigurieren

### 4.1 Nushell-Profil erstellen

1. Öffne **Windows Terminal**
2. Drücke `Ctrl+,` für Settings
3. Klicke auf **"Neues Profil hinzufügen"** → **"Neues leeres Profil"**

**Profil-Einstellungen**:

```json
{
    "name": "Nushell",
    "commandline": "nu.exe",
    "icon": "https://www.nushell.sh/icon.png",
    "startingDirectory": "%USERPROFILE%",
    "fontFace": "FiraCode Nerd Font",
    "fontSize": 11,
    "colorScheme": "Solarized Dark"
}
```

**GUID automatisch generieren** oder manuell einfügen (z.B. `{2b372ca1-1ee2-403d-a839-6d63077ad871}`).[^8]

### 4.2 Nushell als Standard-Shell setzen

In den Terminal-Einstellungen:

- **Startup** → **Default profile** → **Nushell** auswählen

***

## Phase 5: Solarized Dark Theme installieren

### 5.1 Solarized-Schema zum Terminal hinzufügen

**Methode 1: Über Windows Terminal GUI**[^9][^10]

1. Öffne Windows Terminal Settings (`Ctrl+,`)
2. Linke Spalte: **Farbschemas** → **Hinzufügen**
3. Name: `Solarized Dark`
4. Farben konfigurieren (siehe unten)

**Methode 2: Über `settings.json` (schneller)**[^11][^10]

1. Öffne Settings (`Ctrl+,`) → Zahnrad-Icon unten links → **JSON-Datei öffnen**
2. Finde den `"schemes"` Array-Abschnitt
3. Füge das Solarized Dark Schema hinzu:
```json
{
    "schemes": [
        {
            "name": "Solarized Dark",
            "background": "#002b36",
            "foreground": "#839496",
            "cursorColor": "#93a1a1",
            "selectionBackground": "#073642",
            
            "black": "#073642",
            "red": "#dc322f",
            "green": "#859900",
            "yellow": "#b58900",
            "blue": "#268bd2",
            "purple": "#6c71c4",
            "cyan": "#2aa198",
            "white": "#eee8d5",
            
            "brightBlack": "#002b36",
            "brightRed": "#cb4b16",
            "brightGreen": "#586e75",
            "brightYellow": "#657b83",
            "brightBlue": "#839496",
            "brightPurple": "#d33682",
            "brightCyan": "#93a1a1",
            "brightWhite": "#fdf6e3"
        }
    ]
}
```

4. Speichern (`Ctrl+S`)

**Alternative: Vorgefertigte Themes**[^12]

Besuche [windowsterminalthemes.dev](https://windowsterminalthemes.dev/), suche nach "Solarized Dark", und kopiere das JSON direkt.

### 5.2 Solarized Dark auf Nushell-Profil anwenden

**Via GUI**:

1. Settings (`Ctrl+,`) → **Profile** → **Nushell**
2. **Darstellung** → **Farbschema** → **Solarized Dark**
3. Speichern

**Via JSON**:

Finde dein Nushell-Profil in `settings.json` und füge hinzu:

```json
{
    "commandline": "nu.exe",
    "name": "Nushell",
    "colorScheme": "Solarized Dark",
    "fontFace": "FiraCode Nerd Font"
}
```


***

## Phase 6: Nerd Font in Windows Terminal aktivieren

### 6.1 Font im Nushell-Profil setzen

**Via GUI**:

1. Settings → Profile → Nushell → **Darstellung**
2. **Schriftart** → `FiraCode Nerd Font` (oder installierte Nerd Font)
3. **Schriftgröße** → 11

**Via JSON**:

```json
{
    "fontFace": "FiraCode Nerd Font",
    "fontSize": 11,
    "fontWeight": "normal"
}
```


### 6.2 Font-Rendering optimieren (optional)

```json
{
    "fontFace": "FiraCode Nerd Font",
    "fontSize": 11,
    "antialiasingMode": "grayscale",
    "experimental.retroTerminalEffect": false
}
```


***

## Phase 7: Starship-Theme anpassen (optional)

### 7.1 Starship-Konfigurationsdatei erstellen

Starship verwendet `~/.config/starship.toml`. Erstelle die Datei in Nushell:[^13]

```nu
# Konfigurationsverzeichnis erstellen
mkdir ($nu.home-path | path join ".config")

# Starship-Config erstellen
"" | save ($nu.home-path | path join ".config" "starship.toml")

# Mit Helix öffnen
hx ($nu.home-path | path join ".config" "starship.toml")
```


### 7.2 Beispiel-Konfiguration für Solarized Dark

```toml
# Starship-Format
format = """
[╭─](bold green)$username$hostname$directory$all\
[╰─](bold green)$character"""

# Character-Symbol
[character]
success_symbol = "[➜](bold green)"
error_symbol = "[✗](bold red)"

# Verzeichnisanzeige
[directory]
style = "bold cyan"
truncation_length = 3
truncate_to_repo = true

# Git-Branch
[git_branch]
symbol = " "
style = "bold purple"

# Git-Status
[git_status]
style = "bold yellow"
conflicted = "⚔️ "
ahead = "⬆️ ${count}"
behind = "⬇️ ${count}"
diverged = "⬍ ⬆️ ${ahead_count} ⬇️ ${behind_count}"
untracked = "🤷 ${count}"
stashed = "📦 ${count}"
modified = "📝 ${count}"
staged = "✚ ${count}"
renamed = "👅 ${count}"
deleted = "🗑️ ${count}"
```

**Presets ausprobieren**:[^13]

```nu
# Liste verfügbarer Presets
starship preset --list

# Preset anwenden (z.B. Nerd Font Symbols)
starship preset nerd-font-symbols -o ($nu.home-path | path join ".config" "starship.toml")
```


***

## Phase 8: Helix-Konfiguration (optional)

### 8.1 Helix-Config-Verzeichnis erstellen

```nu
# Helix-Konfigurationsverzeichnis
mkdir ($env.APPDATA | path join "helix")

# Config-Datei erstellen
"" | save ($env.APPDATA | path join "helix" "config.toml")
```


### 8.2 Helix mit Solarized Dark konfigurieren

Bearbeite `config.toml`:

```nu
hx ($env.APPDATA | path join "helix" "config.toml")
```

Füge ein:

```toml
theme = "solarized_dark"

[editor]
line-number = "relative"
cursorline = true
auto-save = true
color-modes = true

[editor.cursor-shape]
insert = "bar"
normal = "block"
select = "underline"

[editor.file-picker]
hidden = false

[keys.normal]
C-s = ":w"
```


***

## Zusammenfassung: Komplette Installationssequenz

Hier die **komplette Befehlsfolge** für Copy-Paste:

```powershell
# PowerShell: Basis-Installation (als normaler Benutzer)
winget install Nushell.Nushell
winget install Helix.Helix
winget install --id Starship.Starship
winget install DEVCOM.FiraCodeNerdFont

# Starte Nushell
nu
```

```nu
# Nushell: Starship konfigurieren
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Helix als Editor setzen
echo '$env.EDITOR = "hx"' | save --append $nu.config-path
echo '$env.VISUAL = "hx"' | save --append $nu.config-path

# Konfiguration neu laden
source $nu.config-path

# Starship-Config erstellen
mkdir ($nu.home-path | path join ".config")
touch ($nu.home-path | path join ".config" "starship.toml")
```

**Windows Terminal**:

1. `Ctrl+,` → Neues Profil hinzufügen
2. Commandline: `nu.exe`
3. Font: `FiraCode Nerd Font`
4. Color Scheme: `Solarized Dark` (manuell in JSON hinzufügen, siehe Phase 5)
5. Als Standard-Shell setzen

***

## Verifizierung der Installation

```nu
# Versionen prüfen
nu --version
hx --version
starship --version

# Editoren testen
echo "test" | save test.txt
hx test.txt
rm test.txt

# Starship-Prompt sollte sichtbar sein
# Nerd Font Icons sollten korrekt angezeigt werden
```


***

## Troubleshooting

### Problem: Helix nicht im PATH

**Lösung** (PowerShell als Admin):[^5]

```powershell
$helixPath = (Get-ChildItem "$env:LOCALAPPDATA\Microsoft\WinGet\Packages" -Recurse -Filter "hx.exe").Directory.FullName
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$helixPath", "User")
```


### Problem: Starship-Icons nicht sichtbar

**Ursache**: Nerd Font nicht aktiviert[^2][^6]

**Lösung**:

1. Prüfe, ob Nerd Font installiert ist
2. Setze in Windows Terminal Settings: `"fontFace": "FiraCode Nerd Font"`
3. Terminal neu starten

### Problem: Nushell-Prompt zeigt keine Farben

**Ursache**: Solarized Dark nicht angewendet

**Lösung**: Prüfe in `settings.json`, ob `"colorScheme": "Solarized Dark"` gesetzt ist

### Problem: Starship zeigt keine Git-Informationen

**Ursache**: Git nicht installiert

**Lösung**:

```nu
^winget install Git.Git
```


***

## Zusätzliche Konfigurationen

### Nushell-Aliase für Helix

Füge zu `config.nu` hinzu:

```nu
# Helix-Aliase
alias vi = hx
alias vim = hx
alias edit = hx

# Schnellzugriff auf Konfigurationen
alias edit-config = hx $nu.config-path
alias edit-env = hx $nu.env-path
alias edit-starship = hx ($nu.home-path | path join ".config" "starship.toml")
```


### Starship-Module aktivieren/deaktivieren

In `starship.toml`:

```toml
# Python deaktivieren
[python]
disabled = true

# Docker anzeigen
[docker_context]
disabled = false
format = "via [🐋 $context](bold blue) "

# Rust immer anzeigen
[rust]
disabled = false
format = "via [🦀 $version](bold red) "
```


***

## Weiterführende Ressourcen

- **Nushell Dokumentation**: [nushell.sh/book](https://www.nushell.sh/book/)
- **Helix Dokumentation**: [docs.helix-editor.com](https://docs.helix-editor.com/)
- **Starship Konfiguration**: [starship.rs/config](https://starship.rs/config/)
- **Windows Terminal Themes**: [windowsterminalthemes.dev](https://windowsterminalthemes.dev/)
- **Nerd Fonts**: [nerdfonts.com](https://www.nerdfonts.com/)

**Installation erfolgreich!** Du hast jetzt ein modernes, farbcodiertes Terminal-Setup mit strukturierter Datenverarbeitung (Nushell), einem schnellen Editor (Helix), und einem anpassbaren Prompt (Starship) – alles im Solarized Dark Theme.
<span style="display:none">[^14][^15][^16][^17][^18][^19][^20][^21][^22][^23][^24][^25][^26][^27][^28][^29][^30][^31][^32][^33][^34][^35][^36][^37][^38]</span>

<div align="center">⁂</div>

[^1]: https://docs.helix-editor.com/package-managers.html

[^2]: https://starship.rs/guide/

[^3]: https://www.nushell.sh/blog/2025-05-23-nushell_0_104_1.html

[^4]: https://www.nushell.sh/book/configuration.html

[^5]: https://github.com/helix-editor/helix/issues/6705

[^6]: https://www.nushell.sh/book/3rdpartyprompts.html

[^7]: https://starship.rs

[^8]: https://www.nushell.sh/de/book/installation.html

[^9]: https://www.shankuehn.io/post/super-quick-custom-themes-for-windows-terminal

[^10]: https://zimmergren.net/install-custom-themes-in-windows-terminal/

[^11]: https://gist.github.com/mosioc/b9e28280df33ebdb42db2bd2abf9acb9

[^12]: https://windowsterminalthemes.dev

[^13]: https://starship.rs/config/

[^14]: https://www.nushell.sh/book/installation.html

[^15]: https://github.com/nushell/nushell/issues/13281

[^16]: https://www.nushell.sh

[^17]: https://github.com/nushell/nushell/issues/12748

[^18]: https://github.com/nushell/nushell/issues/12096

[^19]: https://qqq.ninja/blog/post/nushell-install-plugins/

[^20]: https://www.scribd.com/document/818237914/helix

[^21]: https://www.youtube.com/watch?v=rDcWNffYf88

[^22]: https://randomgeekery.org/post/2022/04/trying-nushell-on-windows/

[^23]: https://www.reddit.com/r/HelixEditor/comments/1d4ov5a/windows_setup/

[^24]: https://mvolkmann.github.io/blog/starship/?v=1.1.1

[^25]: https://www.cloudcomputing-insider.de/nushell-befehlszeile-fuer-entwickler-a-34591119272135da9989e9580d8ebe7c/

[^26]: https://www.x-cmd.com/install/helix/

[^27]: https://starship.rs/advanced-config/

[^28]: https://www.nushell.sh/de/

[^29]: https://github.com/Lucky-Loek/patched-solarized-dark-windows-terminal

[^30]: https://ethanschoonover.com/solarized/

[^31]: https://www.reddit.com/r/Windows10/comments/4jbguv/changing_linux_terminal_colors_to_solarized_theme/

[^32]: https://www.youtube.com/watch?v=84xRvk5LVeY

[^33]: https://www.nushell.sh/de/book/3rdpartyprompts.html

[^34]: https://learn.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes

[^35]: https://dev.to/thangchung/modern-windows-terminal-for-developer-in-a-few-steps-170

[^36]: https://www.nushell.sh/de/book/configuration.html

[^37]: https://www.nushell.sh/cookbook/setup.html

[^38]: https://gitlab.informatik.uni-halle.de/aqxga/dotfiles/-/blob/8a8b13c91812ccd1ec647045c72c0e0affebb76d/nushell/env.nu

