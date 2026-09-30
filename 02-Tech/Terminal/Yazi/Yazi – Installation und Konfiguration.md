---
title: Yazi – Installation und Konfiguration
aliases:
  - Yazi Installation
  - Yazi Setup
  - Yazi Plugins
tags:
  - yazi
  - terminal
  - homebrew
  - atomic
  - konfiguration
system: Fedora Sway Atomic
yazi_version: "26.9.1"
created: 2026-07-15
updated: 2026-09-30
status: active
type: anleitung
---

# Yazi – Installation und Konfiguration

> [!abstract] Worum es geht
> Diese Notiz ist die vollständige Setup-Referenz für Yazi: Installation über **Homebrew** auf **Fedora Sway Atomic**, Hilfsprogramme, das Plugin-System mit `ya pkg`, alle eingerichteten Plugins samt Markdown- und Mermaid-Vorschau, das Solarized-Light-Farbschema, die vollständige Beispielkonfiguration und die Übertragung auf einen weiteren Rechner.
>
> Was Yazi überhaupt ist und wie die Bedienung grundsätzlich funktioniert: [[Yazi – Einführung]]. Befehlsreferenz mit Grafiken: [[Yazi-Leitfaden]].

> [!info] Geltungsbereich
> - **System:** ausschließlich Fedora Sway Atomic
> - **Installation:** ausschließlich über Homebrew (`brew`)
> - **Version:** abgeglichen mit Yazi 26.9.1
> - **Befehle:** Nushell-Syntax, Konfigurationsschlüssel in TOML/Lua

## Inhalt

0. [[#0 Schnellstart: alle Befehle in Reihenfolge]]
1. [[#1 Einordnung]]
2. [[#2 Installation mit Homebrew]]
3. [[#3 Hilfsprogramme]]
4. [[#4 Konfigurationsdateien – Übersicht]]
5. [[#5 Das Plugin-System]]
6. [[#6 Eingerichtete Plugins]]
7. [[#7 Solarized Light Flavor]]
8. [[#8 Setup auf einen weiteren Rechner übertragen]]
9. [[#9 Fallstricke und Versionsunterschiede]]
10. [[#10 Referenzen]]

---

## 0 Schnellstart: alle Befehle in Reihenfolge

> [!tip] Zweck dieses Abschnitts
> Der komplette Ablauf von der leeren Installation bis zur fertigen Konfiguration, Schritt für Schritt, ohne Erklärung dazwischen – zum Abarbeiten auf einem neuen Rechner. Die Begründung zu jedem Schritt steht in den Abschnitten [[#1 Einordnung]] bis [[#7 Solarized Light Flavor]] darunter.

### Schritt 1 – Yazi und Hilfsprogramme installieren

```nu
brew install yazi glow mermaid-cli rich-cli eza media-info fd ripgrep fzf zoxide resvg ouch

yazi --version
ya --version
```

### Schritt 2 – Chromium für Mermaid und zoxide-Hook für Nushell

```nu
# Chromium für mmdc (passende Version wird automatisch ermittelt)
^node (brew --prefix mermaid-cli | str trim | path join "libexec/lib/node_modules/@mermaid-js/mermaid-cli/node_modules/puppeteer/lib/puppeteer/node/cli.js") browsers install chrome-headless-shell

# zoxide meldet cd-Wechsel nur mit Hook
zoxide init nushell | save -f ($nu.data-dir | path join "vendor" "autoload" "zoxide.nu")
```

### Schritt 3 – Verzeichnisse anlegen

```nu
mkdir ~/.config/yazi
mkdir ~/.config/yazi/flavors
mkdir ~/.config/glow
mkdir ~/.config/mermaid
```

### Schritt 4 – Plugins installieren

```nu
ya pkg add yazi-rs/plugins:piper
ya pkg add yazi-rs/plugins:toggle-pane
ya pkg add yazi-rs/plugins:git
ya pkg add ahkohd/eza-preview
ya pkg add yazi-rs/plugins:smart-enter
ya pkg add yazi-rs/plugins:chmod
ya pkg add ndtoan96/ouch
```

### Schritt 5 – Solarized-Light-Flavor entpacken

```nu
# Das ZIP liegt im Vault unter _resources: [[solarized-light.yazi.zip]]
^unzip solarized-light.yazi.zip -d ~/.config/yazi/flavors/
```

### Schritt 6 – Konfigurationsdateien anlegen

Datei `~/.config/yazi/yazi.toml`:

```toml
[mgr]
show_hidden = true


[preview]
# Bildvorschau bis Monitorauflösung (1920×1080), damit maximierte Vorschau (Taste T) scharf bleibt
max_width  = 1920
max_height = 1080

[opener]
edit = [
  { run = "hx %s", block = true, for = "unix" },
]

[plugin]
prepend_previewers = [
  # Markdown: Obsidian-Syntax aufbereiten, dann glow mit Solarized-Stil
  # (~/.local/bin/ofm-preview, ~/.config/glow/solarized-light.json); $w = Breite der Vorschau
  { url = "*.md", run = 'piper -- CLICOLOR_FORCE=1 ofm-preview "$1" $w </dev/null' },
  # CSV als Tabelle, Jupyter-Notebooks und reStructuredText mit rich (brew rich-cli)
  { url = "*.{csv,ipynb,rst}", run = 'piper -- rich --force-terminal --left --theme solarized-light -w $w "$1" </dev/null' },
  # Verzeichnisse als Baum mit eza (Plugin ahkohd/eza-preview, Setup in init.lua)
  { url = "*/", run = "eza-preview" },
  # Archive: Inhalt als Baum mit ouch (Plugin ndtoan96/ouch, brew ouch)
  { mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}", run = "ouch" },
]

# Git-Status für Dateien (*) und Verzeichnisse (*/), Setup in init.lua
[[plugin.prepend_fetchers]]
url   = "*"
run   = "git"
group = "git"

[[plugin.prepend_fetchers]]
url   = "*/"
run   = "git"
group = "git"
```

Datei `~/.config/yazi/keymap.toml`:

```toml
[[mgr.prepend_keymap]]
on   = "!"
for  = "unix"
run  = 'shell "nu" --block'
desc = "Nushell im aktuellen Verzeichnis öffnen"

[[mgr.prepend_keymap]]
on   = "M"
for  = "unix"
run  = 'shell "mermaid-view %h" --block'
desc = "Mermaid-Diagramme der Datei rendern und anzeigen"

[[mgr.prepend_keymap]]
on   = "T"
run  = "plugin toggle-pane max-preview"
desc = "Vorschau maximieren / wiederherstellen"

# eza-preview: Verzeichnisvorschau umschalten (Präfix e)
[[mgr.prepend_keymap]]
on   = ["e", "t"]
run  = "plugin eza-preview"
desc = "Verzeichnisvorschau: Baum / Liste"

[[mgr.prepend_keymap]]
on   = ["e", "+"]
run  = "plugin eza-preview inc-level"
desc = "Verzeichnisvorschau: eine Ebene tiefer"

[[mgr.prepend_keymap]]
on   = ["e", "-"]
run  = "plugin eza-preview dec-level"
desc = "Verzeichnisvorschau: eine Ebene weniger"

# smart-enter: l betritt Verzeichnisse oder öffnet Dateien
[[mgr.prepend_keymap]]
on   = "l"
run  = "plugin smart-enter"
desc = "Verzeichnis betreten oder Datei öffnen"

# chmod: Rechte der Auswahl ändern (c m)
[[mgr.prepend_keymap]]
on   = ["c", "m"]
run  = "plugin chmod"
desc = "Rechte der Auswahl ändern (chmod)"

# ouch: Auswahl komprimieren, Format aus dem Dateinamen (Standard zip)
[[mgr.prepend_keymap]]
on   = "C"
run  = "plugin ouch"
desc = "Auswahl komprimieren (ouch)"
```

Datei `~/.config/yazi/theme.toml`:

```toml
[flavor]
dark  = "solarized-light"
light = "solarized-light"

[indicator]
padding = { open = "", close = "" }

[tabs]
sep_inner = { open = "", close = "" }
sep_outer = { open = "", close = "" }

[status]
sep_left  = { open = "", close = "" }
sep_right = { open = "", close = "" }
```

Datei `~/.config/yazi/init.lua`:

```lua
-- Git-Status pro Datei in der Dateiliste (Plugin yazi-rs/plugins:git)
require("git"):setup {
	-- Position des Statuszeichens in der Linemode-Spalte
	order = 1500,
}

-- Verzeichnisvorschau mit eza (Plugin ahkohd/eza-preview)
require("eza-preview"):setup {
	-- Baumansicht statt Liste, 2 Ebenen tief
	default_tree = true,
	level = 2,
	icons = true,
	-- Versteckte Dateien zeigen, .gitignore beachten, .git-Verzeichnis ausblenden
	all = true,
	git_ignore = true,
	ignore_glob = { ".git" },
}
```

### Schritt 7 – Vorschau-Stile und Skripte anlegen

Datei `~/.config/glow/solarized-light.json`:

```json
{
  "document": { "block_prefix": "\n", "block_suffix": "\n", "color": "#586e75", "margin": 1 },
  "block_quote": { "color": "#657b83", "indent": 1, "indent_token": "▎ " },
  "paragraph": {},
  "list": { "level_indent": 2 },
  "heading": { "block_suffix": "\n", "bold": true },
  "h1": { "prefix": " ", "suffix": " ", "color": "#fdf6e3", "background_color": "#268bd2", "bold": true },
  "h2": { "prefix": "▌ ", "color": "#cb4b16" },
  "h3": { "prefix": "◆ ", "color": "#b58900" },
  "h4": { "prefix": "◇ ", "color": "#2aa198" },
  "h5": { "prefix": "· ", "color": "#2aa198" },
  "h6": { "prefix": "· ", "color": "#93a1a1", "bold": false },
  "text": {},
  "strikethrough": { "crossed_out": true },
  "emph": { "italic": true },
  "strong": { "bold": true, "color": "#073642" },
  "hr": { "color": "#93a1a1", "format": "\n────────────────────\n" },
  "item": { "block_prefix": "• " },
  "enumeration": { "block_prefix": ". " },
  "task": { "ticked": "[✓] ", "unticked": "[ ] " },
  "link": { "color": "#268bd2", "underline": true },
  "link_text": { "color": "#268bd2", "bold": true },
  "image": { "color": "#d33682", "underline": true },
  "image_text": { "color": "#93a1a1", "format": "Bild: {{.text}} →" },
  "code": { "prefix": " ", "suffix": " ", "color": "#d33682", "background_color": "#eee8d5" },
  "code_block": { "color": "#586e75", "margin": 2, "theme": "solarized-light" },
  "table": { "color": "#586e75" },
  "definition_list": {},
  "definition_term": {},
  "definition_description": { "block_prefix": "\n🠶 " },
  "html_block": {},
  "html_span": {}
}
```

Datei `~/.local/bin/ofm-preview`:

```nu
#!/usr/bin/env nu
# Obsidian-Markdown für die Terminal-Vorschau aufbereiten und mit glow rendern.
# Aufruf aus Yazi (piper): ofm-preview <datei> <breite>

def main [file: string, width: int = 80] {
	open --raw $file
	| decode utf-8
	# Kommentare %% … %% entfernen (auch mehrzeilig)
	| str replace --all --regex '(?s)%%.*?%%' ''
	# Einbettungen ![[datei]] → 📎 datei
	| str replace --all --regex '!\[\[([^\]|]+)(?:\|[^\]]*)?\]\]' '📎 *${1}*'
	# Wikilinks: [[ziel|alias]] → alias, [[#abschnitt]] → abschnitt, [[notiz#abschnitt]] → notiz › abschnitt
	| str replace --all --regex '\[\[[^\]|]+\|([^\]]+)\]\]' '*${1}*'
	| str replace --all --regex '\[\[#([^\]]+)\]\]' '*${1}*'
	| str replace --all --regex '\[\[([^\]#]+)#([^\]]+)\]\]' '*${1} › ${2}*'
	| str replace --all --regex '\[\[([^\]]+)\]\]' '*${1}*'
	# Hervorhebungen ==text== → fett
	| str replace --all --regex '==([^=\n]+)==' '**${1}**'
	# Callouts: > [!typ]- Titel → > **TYP · Titel**
	| str replace --all --regex '(?m)^((?:> ?)+)\[!(\w+)\][-+]?[ \t]+(\S.*)$' '${1}**${2} · ${3}**'
	| str replace --all --regex '(?m)^((?:> ?)+)\[!(\w+)\][-+]?[ \t]*$' '${1}**${2}**'
	# Mermaid-Blöcke: Hinweis auf die Taste M (mermaid-view) voranstellen
	| str replace --all --regex '(?m)^```mermaid' "> **mermaid · Taste M zeigt das Diagramm als Bild**\n\n```mermaid"
	| ^glow -w $width -s ~/.config/glow/solarized-light.json -
}
```

Datei `~/.config/mermaid/solarized-light.json`:

```json
{
  "theme": "base",
  "themeVariables": {
    "background": "#fdf6e3",
    "fontFamily": "sans-serif",
    "primaryColor": "#eee8d5",
    "primaryBorderColor": "#93a1a1",
    "primaryTextColor": "#073642",
    "secondaryColor": "#e4ecd0",
    "secondaryBorderColor": "#859900",
    "secondaryTextColor": "#073642",
    "tertiaryColor": "#dde9ef",
    "tertiaryBorderColor": "#268bd2",
    "tertiaryTextColor": "#073642",
    "lineColor": "#657b83",
    "textColor": "#586e75",
    "edgeLabelBackground": "#fdf6e3",
    "clusterBkg": "#f5efdc",
    "clusterBorder": "#93a1a1",
    "noteBkgColor": "#f7e7b4",
    "noteBorderColor": "#b58900",
    "noteTextColor": "#073642",
    "actorBkg": "#eee8d5",
    "actorBorder": "#93a1a1",
    "actorTextColor": "#073642",
    "signalColor": "#586e75",
    "signalTextColor": "#586e75"
  }
}
```

Datei `~/.local/bin/mermaid-view`:

```nu
#!/usr/bin/env nu
# Mermaid-Diagramme einer Markdown-Datei lokal mit mmdc rendern und in Yazi anzeigen.
# Aufruf aus Yazi (keymap.toml): mermaid-view <datei>
# Die Bilder landen in ~/.cache/mermaid-view/<notiz>/, Yazi öffnet sie in einem neuen Tab.

const THEME = "~/.config/mermaid/solarized-light.json"

def main [file: string] {
	let blocks = (
		open --raw $file
		| decode utf-8
		| parse --regex '(?s)```mermaid[^\n]*\n(?<code>.*?)\n```'
		| get code
	)

	if ($blocks | is-empty) {
		print $"Keine Mermaid-Blöcke in ($file | path basename)."
		input --numchar 1 "Taste drücken …" | ignore
		return
	}

	let out_dir = ($nu.home-dir | path join ".cache" "mermaid-view" ($file | path parse | get stem))
	mkdir $out_dir

	# Dateiname enthält einen Hash des Diagramm-Codes: unverändertes wird nicht neu gerendert
	let targets = ($blocks | enumerate | each {|b|
		let hash = ($b.item | hash sha256 | str substring 0..7)
		{code: $b.item, png: ($out_dir | path join $"($b.index + 1 | fill -a r -w 2 -c '0')-($hash).png")}
	})

	# Veraltete Bilder dieser Notiz entfernen
	ls $out_dir | where name not-in $targets.png | each {|f| rm $f.name } | ignore

	let todo = ($targets | where {|t| not ($t.png | path exists) })
	let errors = ($todo | enumerate | each {|t|
		print $"Rendere Diagramm ($t.index + 1) von ($todo | length) …"
		let src = (mktemp -t "mermaid-view.XXXXXX.mmd")
		$t.item.code | save -f $src
		let result = (^mmdc -q -i $src -o $t.item.png -c ($THEME | path expand) -b "#fdf6e3" -s 2 | complete)
		rm -f $src
		# Nur die Mermaid-Meldung zeigen, nicht den JavaScript-Stacktrace
		let message = ($result.stderr | lines | take while {|l| not ($l =~ '^\s+at |^\w+ \((https?|file):') } | first 8 | str join "\n    ")
		if $result.exit_code != 0 { $"Diagramm ($t.item.png | path basename | str substring 0..1): ($message)" }
	} | compact)

	if ($errors | is-not-empty) {
		print "Fehler beim Rendern:"
		$errors | each {|e| print $"  ($e)" } | ignore
		input --numchar 1 "Taste drücken …" | ignore
	}

	let first = ($targets | where {|t| $t.png | path exists } | get png.0?)
	if $first != null {
		# Neuer Tab im Diagramm-Ordner, die Notiz bleibt im bisherigen Tab offen
		^ya emit tab_create $out_dir
		^ya emit reveal $first
	}
}
```

Beide Skripte ausführbar machen:

```nu
chmod +x ~/.local/bin/ofm-preview ~/.local/bin/mermaid-view
```

### Schritt 8 – Shell-Wrapper `y` und Editor einrichten

Nushell (`config nu`):

```nu
$env.EDITOR = "hx"
$env.VISUAL = "hx"
$env.config.buffer_editor = "hx"

def --env y [...args] {
  let tmp = (mktemp -t "yazi-cwd.XXXXXX")
  ^yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != $env.PWD and ($cwd | path exists) {
    cd $cwd
  }
  rm -fp $tmp
}
```

Bash/Zsh (`~/.bashrc`, `~/.zshrc`), nur falls diese Shells ebenfalls Yazi starten sollen:

```bash
function y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] \
    && builtin cd -- "$cwd" || builtin true
  command rm -f -- "$tmp"
}
```

### Schritt 9 – Prüfen

```nu
ya pkg list                                              # sieben Plugins erwartet
ls ~/.config/yazi/*.toml | each {|f| {datei: ($f.name | path basename), ok: (try { open $f.name; true } catch { false })} }
open ~/.config/yazi/theme.toml | get flavor
[glow mmdc rich eza mediainfo fd rg fzf zoxide resvg ouch] | each {|p| {programm: $p, gefunden: (which $p | is-not-empty)} }
```

Anschließend Yazi (neu) starten. Wenn `ya pkg list` sieben Plugins zeigt (`piper`, `toggle-pane`, `git`, `eza-preview`, `smart-enter`, `chmod`, `ouch`) und keine der TOML-Dateien einen Syntaxfehler meldet, ist die Installation vollständig.

---

## 1 Einordnung

Nachfolger im Geiste von `ranger` und `lf`, aber:

- **Vollständig asynchron** – Vorschau-Generierung blockiert die UI nie
- **Lua-Plugin-System** mit eigenem Paketmanager (`ya pkg`)
- **Bildprotokolle nativ** – Kitty Graphics, Sixel (z. B. `foot`), iTerm2
- **Vim-artige Tastenbelegung**

> [!warning] Beta-Status
> Yazi ist offiziell Public Beta. Breaking Changes in der Konfiguration kommen vor, siehe [[#9 Fallstricke und Versionsunterschiede]]. Ältere Blogposts zeigen oft noch veraltete Syntax. Bei Fehlern zuerst `yazi --version` prüfen.

---

## 2 Installation mit Homebrew

Auf Fedora Atomic ist das Basisimage schreibgeschützt. Homebrew installiert ohne Layering und ohne Neustart nach `/home/linuxbrew/.linuxbrew` und bringt stets die aktuelle Yazi-Version.

```nu
brew install yazi

# yazi (Oberfläche) und ya (CLI, u. a. Paketverwaltung) kommen gemeinsam
yazi --version
ya --version
```

> [!warning] Nur auf dem Host, nicht in Toolbx
> Der Homebrew-Pfad liegt außerhalb von `$HOME` und existiert in Toolbx-Containern nicht. Yazi und alle per `brew` installierten Hilfsprogramme stehen deshalb nur auf dem Host zur Verfügung. Hintergrund: [[00 Werkzeuge ins HOME-Verzeichnis installieren]].

Update:

```nu
brew upgrade yazi
ya pkg upgrade     # Plugins nach jedem Yazi-Update mitziehen
```

---

## 3 Hilfsprogramme

Yazi selbst braucht nur `file(1)`, das im Basisimage liegt. Alles Weitere schaltet Funktionen frei. Einige Programme bringt das Basisimage bereits mit. Fehlende werden über `brew` nachinstalliert.

| Programm   | brew-Formel   | Wofür                                              | Auf dem Referenzsystem |
| ---------- | ------------- | --------------------------------------------------- | ----------------------- |
| `glow`     | `glow`        | Markdown-Vorschau                                    | brew                    |
| `mmdc`     | `mermaid-cli` | Mermaid-Diagramme (+ Chromium, siehe [[#6.10 Mermaid-Diagramme rendern (eigenes Skript)]]) | brew |
| `rich`     | `rich-cli`    | Vorschau für CSV, Jupyter-Notebooks, reStructuredText | brew                   |
| `eza`      | `eza`         | Verzeichnisvorschau als Baum                         | brew                    |
| `mediainfo`| `media-info`  | Menüeintrag „Show media info“ für Audio/Video (`O`)  | brew                    |
| `fd`       | `fd`          | Dateisuche nach Namen (Taste `s`)                    | brew                    |
| `rg`       | `ripgrep`     | Inhaltssuche (Taste `S`)                             | brew                    |
| `fzf`      | `fzf`         | Springen per fzf (Taste `z`)                         | brew                    |
| `zoxide`   | `zoxide`      | Verzeichnishistorie (Taste `Z`), braucht Shell-Hook  | brew                    |
| `resvg`    | `resvg`       | SVG-Vorschau                                         | brew                    |
| `ouch`     | `ouch`        | Archiv-Vorschau als Baum, Komprimieren (Taste `C`)   | brew                    |
| `jq`       | `jq`          | JSON-Vorschau                                        | Basisimage               |
| `7z`       | `sevenzip`    | Archiv-Vorschau und -Extraktion                      | Basisimage               |
| `pdftoppm` | `poppler`     | PDF-Vorschau                                         | Basisimage               |
| `ffmpeg`   | `ffmpeg`      | Video-Thumbnails                                     | Basisimage               |
| `magick`   | `imagemagick` | Font-, HEIC-, JPEG-XL-Vorschau                       | Basisimage               |
| `wl-copy`  | –             | Zwischenablage unter Wayland/Sway                    | Basisimage               |

Vorhandene Programme prüfen:

```nu
[glow mmdc rich eza mediainfo fd rg fzf zoxide resvg ouch jq 7z pdftoppm ffmpeg magick wl-copy]
| each {|p| {programm: $p, pfad: (which $p | get path.0? | default "–")} }
```

Alles aus brew in einem Schritt:

```nu
brew install glow mermaid-cli rich-cli eza media-info fd ripgrep fzf zoxide resvg ouch
```

### zoxide: Hook für Nushell

`zoxide` merkt sich nur Verzeichnisse, die eine Shell mit Hook meldet. Ohne Hook bleibt die Datenbank leer, und `Z` in Yazi findet nichts (`zoxide: no match found`). Die Integration kommt wie Starship in den Autoload-Ordner von Nushell:

```nu
zoxide init nushell | save -f ($nu.data-dir | path join "vendor" "autoload" "zoxide.nu")
```

- **Autoload:** Dateien in `~/.local/share/nushell/vendor/autoload/` lädt Nushell bei jedem Start automatisch, `config.nu` bleibt unverändert.
- **Hook:** Bei jedem `cd` ruft Nushell `zoxide add` auf. Hooks laufen nur in interaktiven Sitzungen, nicht bei `nu -c`.
- **Nebenbei:** `z <stichwort>` und `zi` (interaktiv) springen direkt in der Shell.
- **Nach `brew upgrade zoxide`** den Befehl wiederholen, die Datei wird generiert.

Prüfen: neues Terminal öffnen, ein paar Mal mit `cd` wechseln, dann `zoxide query`.

> [!tip] Basisimage vor brew
> Was schon unter `/usr/bin` liegt, nicht zusätzlich per brew installieren. Sonst liegen zwei Versionen im `$PATH`, und welche gewinnt, hängt von der Reihenfolge ab.

> [!note] Nerd Font
> Dateisymbole und Trennzeichen brauchen eine Nerd Font im Terminal (`foot`). Fehlt sie, erscheinen Kästchen.

---

## 4 Konfigurationsdateien – Übersicht

Yazi liest seine Konfiguration aus `~/.config/yazi/`. Keine dieser Dateien ist Pflicht. Es genügt, nur die Werte einzutragen, die von der Standardkonfiguration abweichen sollen. Yazi ergänzt den Rest selbst.

| Datei          | Zweck                                                        |
| -------------- | ------------------------------------------------------------ |
| `yazi.toml`    | Verhalten: versteckte Dateien, Opener, Vorschau, Sortierung  |
| `keymap.toml`  | Eigene Tastenbelegungen                                      |
| `theme.toml`   | Farben, Symbole, Trennzeichen, Auswahl des Flavors            |
| `init.lua`     | Initialisierung und Anpassung von Lua-Plugins                |
| `package.toml` | Von `ya pkg` verwaltete Plugins und Flavors, nicht von Hand bearbeiten |

Verzeichnis anlegen und installierte Version prüfen:

```nu
mkdir ~/.config/yazi
yazi --version
```

> [!tip] TOML-Dateien mit Nushell prüfen
> Nushell kann TOML nativ lesen. `open` wandelt die Datei in eine Tabelle um und meldet Syntaxfehler mit Zeilenangabe.
>
> ```nu
> open ~/.config/yazi/theme.toml
> open ~/.config/yazi/yazi.toml | get mgr.show_hidden
> ```

> [!note]
> Änderungen an den Konfigurationsdateien wirken erst nach einem **Neustart von Yazi**. Oft laufen mehrere Instanzen in verschiedenen Terminals – alle beenden (`ps | where name == yazi`).

---

## 5 Das Plugin-System

### Vier Plugin-Typen

| Typ            | Aufgabe                                          |
| -------------- | ------------------------------------------------- |
| **Previewer**  | Rendert den Inhalt im Vorschaubereich              |
| **Preloader**  | Bereitet Vorschauen im Voraus auf                  |
| **Fetcher**    | Holt Metadaten (z. B. Git-Status pro Datei)        |
| **Funktional** | Reagiert auf Tastendrücke, ändert die Oberfläche   |

Plugins liegen als `<name>.yazi/`-Verzeichnis mit `main.lua` als Einstiegspunkt in `~/.config/yazi/plugins/`.

### `ya pkg add` – was dabei passiert

```nu
ya pkg add yazi-rs/plugins:piper
```

| Teil                    | Bedeutung                                                         |
| ----------------------- | ------------------------------------------------------------------ |
| `ya`                    | Yazis CLI-Programm, wird von brew zusammen mit `yazi` installiert  |
| `pkg`                   | Paketverwaltung (hieß früher `pack`)                               |
| `add`                   | Installieren und in `package.toml` eintragen                       |
| `yazi-rs/plugins:piper` | GitHub `<owner>/<repo>`, nach dem Doppelpunkt ein Unterverzeichnis |

**Kurzform:** Yazi hängt `.yazi` automatisch an. `Reledia/glow` klont `https://github.com/Reledia/glow.yazi`. Bei Monorepos wie `yazi-rs/plugins` adressiert `:piper` das Unterverzeichnis `piper.yazi`.

Das Ergebnis in `package.toml` (Stand Referenzsystem):

```toml
# ~/.config/yazi/package.toml
[[plugin.deps]]
use = "yazi-rs/plugins:piper"
rev = "58c4f4e"
hash = "45a533508a9840cc5a10cf6129f63e6a"

[[plugin.deps]]
use = "yazi-rs/plugins:toggle-pane"
rev = "58c4f4e"
hash = "5b2fbef7d1513ce38ff72623a071a5e"

[[plugin.deps]]
use = "yazi-rs/plugins:git"
rev = "58c4f4e"
hash = "5bb0bfab901d3601c370eafdd66edd31"

[[plugin.deps]]
use = "ahkohd/eza-preview"
rev = "e8fb6c8"
hash = "c238595c801caa4f28553b9af8cf8804"

[[plugin.deps]]
use = "yazi-rs/plugins:smart-enter"
rev = "58c4f4e"
hash = "187cc58ba7ac3befd49c342129e6f1b6"

[[plugin.deps]]
use = "yazi-rs/plugins:chmod"
rev = "58c4f4e"
hash = "87472b05a8c420100f6a2b9cde1e7746"

[[plugin.deps]]
use = "ndtoan96/ouch"
rev = "596b666"
hash = "c2f4f4aca257dcceafa9e3b828dbf1c9"

[flavor]
deps = []
```

- **`rev`** – Der Commit wird beim Installieren festgeschrieben. `ya pkg install` nutzt genau diese Revision, `ya pkg upgrade` hebt sie an. Ein Lockfile, im Prinzip.
- **`hash`** – Prüfsumme über alle Plugin-Dateien. Hat man am Plugin geschraubt, bricht der Paketmanager ab, statt die Änderungen zu überschreiben.

> [!important] `ya pkg add` **aktiviert** nichts
> Der Befehl kopiert nur Dateien und schreibt einen Eintrag. Ohne zusätzlichen Eintrag in `yazi.toml` (Previewer, Fetcher) oder `keymap.toml`/`init.lua` (funktionale Plugins) passiert gar nichts. Das ist die häufigste Verwirrung.

### Alle Kommandos

```nu
ya pkg add <pkg>       # Installieren
ya pkg list            # Auflisten
ya pkg upgrade         # Alle auf neuen Stand heben
ya pkg delete <pkg>    # Entfernen
ya pkg install         # Alles aus package.toml installieren
```

> [!warning] Nur GitHub
> `ya pkg` installiert ausschließlich von GitHub. Plugins von anderen Git-Hosts müssen manuell nach `~/.config/yazi/plugins/` geklont werden und tauchen dann nicht in `package.toml` auf.

---

## 6 Eingerichtete Plugins

| Plugin                         | Zweck                                                  | Taste                | Details |
| ------------------------------- | -------------------------------------------------------- | --------------------- | ------- |
| `yazi-rs/plugins:piper`         | Shell-Kommando als Vorschau (Markdown, CSV, Notebooks)    | –                      | [[#6.1 piper – Markdown-Vorschau]], [[#6.2 piper – CSV Notebooks und reStructuredText]] |
| `yazi-rs/plugins:toggle-pane`   | Vorschau maximieren / wiederherstellen                    | `T`                    | [[#6.3 toggle-pane – Vorschau maximieren]] |
| `yazi-rs/plugins:git`           | Git-Status pro Datei in der Liste                          | –                      | [[#6.4 git – Status pro Datei]] |
| `ahkohd/eza-preview`            | Verzeichnisvorschau als Baum                                | `e t`, `e +`, `e -`   | [[#6.5 eza-preview – Verzeichnisse als Baum]] |
| `yazi-rs/plugins:smart-enter`   | `l` betritt Verzeichnisse oder öffnet Dateien             | `l`                    | [[#6.7 smart-enter – eine Taste für Öffnen und Betreten]] |
| `yazi-rs/plugins:chmod`         | Rechte der Auswahl ändern                                   | `c m`                  | [[#6.8 chmod – Rechte ändern]] |
| `ndtoan96/ouch`                 | Archiv-Vorschau, Komprimieren                               | `C`                    | [[#6.9 ouch – Archive]] |

Ohne Plugin, als eigenes Skript mit Taste `M`: Mermaid-Diagramme, siehe [[#6.10 Mermaid-Diagramme rendern (eigenes Skript)]].

### 6.1 piper – Markdown-Vorschau

> [!abstract] Worum es geht
> Markdown-Dateien sollen im Vorschaubereich von Yazi gerendert erscheinen: farbige Überschriften im Solarized-Light-Stil, Tabellen als Spalten, Obsidian-Syntax lesbar aufbereitet.

```
Yazi ──► piper.yazi ──► sh -c "ofm-preview <datei> <breite>"
                              │
                              ├─ Obsidian-Syntax umschreiben (Nushell)
                              └─ glow -s solarized-light.json  ──► farbige Ausgabe
```

| Baustein                                  | Aufgabe                                                             |
| ------------------------------------------- | ---------------------------------------------------------------------- |
| `piper.yazi`                                | Offizielles Plugin: Ausgabe eines Shell-Kommandos wird zur Vorschau    |
| `~/.local/bin/ofm-preview`                  | Nushell-Skript: bereitet Obsidian-Markdown auf, ruft glow auf          |
| `~/.config/glow/solarized-light.json`       | glow-Stil in Solarized-Light-Farben                                    |
| `~/.config/yazi/yazi.toml`                  | Verknüpft `*.md` mit dem Previewer                                     |

> [!question]- Warum nicht das Plugin `glow.yazi`?
> `Reledia/glow` bricht Zeilen fest bei 55 Zeichen um. piper übergibt dagegen mit `$w` die tatsächliche Breite des Vorschaubereichs und erlaubt eine Vorverarbeitung vor glow. Die Upstream-README von piper nennt glow ausdrücklich als Beispiel.

> [!note] Installation und vollständiger Inhalt
> `brew install glow`, `ya pkg add yazi-rs/plugins:piper`, der glow-Stil `solarized-light.json`, das Skript `ofm-preview` und der Previewer-Eintrag in `yazi.toml` stehen vollständig in [[#0 Schnellstart: alle Befehle in Reihenfolge]] (Schritt 1, 4, 6 und 7). Farbwerte: Text `#586e75` (base01) · Zitate `#657b83` (base00) · Hervorhebung `#073642` (base02) · Hintergrund Code `#eee8d5` (base2) · Akzente blau `#268bd2`, orange `#cb4b16`, gelb `#b58900`, türkis `#2aa198`, magenta `#d33682`.

`ofm-preview` schreibt Obsidian-Syntax für die Terminal-Vorschau um:

| Obsidian                  | Vorschau                                                                  |
| -------------------------- | --------------------------------------------------------------------------- |
| `[[Notiz]]`                 | *Notiz*                                                                     |
| `[[Notiz\|Alias]]`          | *Alias*                                                                     |
| `[[Notiz#Abschnitt]]`       | *Notiz › Abschnitt*                                                         |
| `[[#Abschnitt]]`            | *Abschnitt*                                                                 |
| `![[bild.png]]`             | 📎 *bild.png*                                                               |
| `> [!info]- Titel`          | ▎ **info · Titel**                                                         |
| `==markiert==`              | **markiert**                                                                |
| `%%Kommentar%%`             | *(entfällt)*                                                                |
| ` ```mermaid `               | Hinweis **mermaid · Taste M zeigt das Diagramm als Bild** vor dem Block   |

- **`${1}` statt `$1`:** In der Regex-Ersetzung würde `$1*` als Gruppenname `1*` gelesen. Die geschweiften Klammern trennen die Gruppennummer eindeutig ab.
- **Reihenfolge:** Einbettungen vor Wikilinks, Links mit Alias vor Links ohne. Sonst greift das allgemeinere Muster zuerst.
- **`(?m)` / `(?s)`:** `(?m)` lässt `^` und `$` auf jede Zeile wirken, `(?s)` lässt `.` auch Zeilenumbrüche erfassen (mehrzeilige Kommentare).
- **`^glow … -`:** Der Bindestrich liest aus der Pipeline. Frontmatter blendet glow auch dann aus.

Der Previewer-Eintrag in `yazi.toml` steht `piper --` (läuft als POSIX-`sh`, nicht Nushell) davor, setzt `CLICOLOR_FORCE=1` (glow erkennt sonst kein Terminal) und übergibt `"$1"`/`$w` (Dateipfad/Breite) sowie `</dev/null` – Details siehe [[#0 Schnellstart: alle Befehle in Reihenfolge|Schnellstart, Schritt 6]]. Anschließend **alle** Yazi-Instanzen beenden und neu starten.

**Prüfen:**

```nu
CLICOLOR_FORCE=1 ofm-preview "Yazi – Einführung.md" 60
open ~/.config/yazi/yazi.toml | get plugin
open ~/.config/glow/solarized-light.json | columns | length
ya pkg list
```

In Yazi: Cursor auf eine `.md`-Datei, mit `J`/`K` blättern. Aktiv, wenn kein Frontmatter oben steht, Absätze auf die Vorschaubreite umbrechen, Überschriften farbig mit Symbol erscheinen und Callouts als `▎ info · Titel` dargestellt werden.

> [!failure]- Fehlersuche
> - **Rohes Markdown mit Frontmatter:** Yazi nicht neu gestartet (`ps | where name == yazi`), `ya pkg list` zeigt kein `piper`, oder Tippfehler in `yazi.toml`.
> - **Vorschau bleibt leer oder hängt:** Ohne `</dev/null` wartet glow unter Umständen auf die Standardeingabe statt die Datei zu lesen.
> - **`sh: ofm-preview: not found`:** `~/.local/bin` fehlt im `$PATH` der Shell, aus der Yazi gestartet wurde, oder das Skript ist nicht ausführbar.
> - **Ohne Farben:** `CLICOLOR_FORCE=1` fehlt im `run`-Eintrag.
> - **`specified style does not exist`:** `~/.config/glow/solarized-light.json` fehlt oder der Pfad stimmt nicht.
> - **Gerendert, aber farblich unauffällig:** Es läuft noch ein eingebauter Stil (`-s light`/`auto`).

> [!caution] Grenzen – kein Obsidian-Renderer
> Callout-Typen erscheinen kleingeschrieben und ohne Symbol, Einklappen wird ignoriert. Wikilinks sind nur Text, nicht anklickbar. Eingebettete Bilder und Notizen zeigen nur ihren Namen. Mermaid-Diagramme bleiben Code – Taste `M` zeigt sie als Bild, siehe [[#6.10 Mermaid-Diagramme rendern (eigenes Skript)]]. Mathe, Dataview und Tags werden nicht aufbereitet. Für „was steht drin“ reicht das, für „sieht das im Vault richtig aus“ bleibt Obsidian.

### 6.2 piper – CSV, Notebooks und reStructuredText

Kein eigenes Plugin: `AnirudhG07/rich-preview` empfiehlt selbst den Weg über piper. Voraussetzung `brew install rich-cli`. Previewer-Eintrag: [[#0 Schnellstart: alle Befehle in Reihenfolge|Schnellstart, Schritt 6]] (`yazi.toml`, Array `prepend_previewers`).

| Option                     | Wirkung                                                          |
| ---------------------------- | ------------------------------------------------------------------- |
| `--force-terminal`             | Farben trotz fehlendem Terminal (wie `CLICOLOR_FORCE` bei glow)    |
| `--left`                       | Linksbündig statt zentriert                                        |
| `--theme solarized-light`      | Syntaxfarben in Notebook-Codezellen, passend zum Flavor            |
| `-w $w`                        | Breite des Vorschaubereichs                                        |

CSV erscheint als Tabelle mit Kopfzeile, Notebooks mit Markdown-Zellen, Codezellen im Rahmen und Ausgaben. JSON und Markdown bleiben bei `jq` bzw. `ofm-preview`.

### 6.3 toggle-pane – Vorschau maximieren

`ya pkg add yazi-rs/plugins:toggle-pane`, Taste `T` in `keymap.toml`, `[preview] max_width/max_height` in `yazi.toml` – vollständig in [[#0 Schnellstart: alle Befehle in Reihenfolge|Schnellstart, Schritt 4 und 6]].

- **`T`** schaltet zwischen normaler und maximierter Vorschau um. Text-Previewer wie glow rendern dabei neu auf die volle Breite.
- **`max_width`/`max_height`:** Standard sind 600×900 Pixel. Bilder werden auf diese Größe verkleinert zwischengespeichert. Werte an den Monitor anpassen, nach Änderung einmal `ya cache clear`.
- Weitere Varianten laut README: `min-preview` (Vorschau aus-/einblenden), `max-current`, `reset`.

### 6.4 git – Status pro Datei

`ya pkg add yazi-rs/plugins:git`, Fetcher-Einträge in `yazi.toml`, `init.lua`-Setup – vollständig in [[#0 Schnellstart: alle Befehle in Reihenfolge|Schnellstart, Schritt 4 und 6]].

Fetcher für Dateien (`*`) und Verzeichnisse (`*/`) – ohne beide Einträge fehlt der Status bei Ordnern. Zeichen: neue Dateien `?`, geänderte/hinzugefügte/gelöschte/ignorierte Dateien als Nerd-Font-Symbole, Farben anpassbar im Abschnitt `[git]` der `theme.toml`.

### 6.5 eza-preview – Verzeichnisse als Baum

`brew install eza`, `ya pkg add ahkohd/eza-preview`, Previewer-Eintrag und `init.lua`-Setup sowie die drei `e`-Tasten in `keymap.toml` – vollständig in [[#0 Schnellstart: alle Befehle in Reihenfolge|Schnellstart, Schritt 1, 4 und 6]].

- **`level = 2`** statt Standard 3: Vault-Ordner sind tief verschachtelt, drei Ebenen füllen den Vorschaubereich sofort.
- **`git_ignore`** blendet Dateien aus `.gitignore` aus, **`ignore_glob`** zusätzlich das `.git`-Verzeichnis, das `all = true` sonst zeigen würde.
- **Präfix `e`** ist im Dateimanager-Modus von Yazi 26.9.1 frei.

### 6.6 Medien-Metadaten

Das Plugin `boydaihungst/mediainfo` ist **nicht** eingerichtet: Das Repository ist als *deprecated* markiert (September 2026) und ersetzt die eingebaute Bildvorschau für alle Bilder, auch für Mermaid-PNGs. Stattdessen genügt `brew install media-info`: Yazis Standardkonfiguration enthält für Audio und Video bereits einen Opener „Show media info“. Aufruf: Cursor auf die Datei, `O`, Eintrag auswählen.

### 6.7 smart-enter – eine Taste für Öffnen und Betreten

`ya pkg add yazi-rs/plugins:smart-enter`, Taste `l` in `keymap.toml` – vollständig in [[#0 Schnellstart: alle Befehle in Reihenfolge|Schnellstart, Schritt 4 und 6]].

- **Standard:** `l` betritt nur Verzeichnisse, auf Dateien passiert nichts; geöffnet wird mit `Enter`.
- **Mit Plugin:** `l` auf einem Verzeichnis betritt es, auf einer Datei öffnet es sie mit dem Standard-Opener, bei Text also Helix. Navigation mit `h`/`l` wird damit durchgängig.
- **Nur die Datei unter dem Cursor** wird geöffnet, auch wenn mehrere ausgewählt sind. Mehrere öffnen: `require("smart-enter"):setup { open_multi = true }` in `init.lua` (nicht eingerichtet).

### 6.8 chmod – Rechte ändern

`ya pkg add yazi-rs/plugins:chmod`, Tastenfolge `c m` in `keymap.toml` – vollständig in [[#0 Schnellstart: alle Befehle in Reihenfolge|Schnellstart, Schritt 4 und 6]].

Bedienung: Dateien auswählen (oder nur Cursor), `c m`, Modus oktal eingeben, z. B. `600` oder `755`, `Enter`. Präfix `c` teilt sich die Belegung mit den Kopierbefehlen (`c c`, `c f` …); `c m` ist dort frei.

### 6.9 ouch – Archive

`brew install ouch`, `ya pkg add ndtoan96/ouch`, Previewer-Eintrag und Taste `C` – vollständig in [[#0 Schnellstart: alle Befehle in Reihenfolge|Schnellstart, Schritt 1, 4 und 6]].

- **Vorschau:** Archivinhalt als Baum mit Verzeichnisstruktur. Blättern mit `J`/`K`.
- **Komprimieren:** Auswahl treffen, `C`, Dateinamen bestätigen oder ändern. Das Format ergibt sich aus der Endung (`.zip`, `.tar.gz`, `.7z` …).
- **Entpacken bleibt bei Yazi:** Der eingebaute Opener „Extract here“ (`O`) nutzt `7z` aus dem Basisimage. Den Opener-Vorschlag aus der README (`ouch d -y "$@"`) nicht übernehmen, er nutzt die alte Platzhalter-Syntax.
- **`C` ist im Dateimanager frei**, in Eingabefeldern bedeutet es etwas anderes (bis Zeilenende ausschneiden) – dort greift die Belegung nicht.

### 6.10 Mermaid-Diagramme rendern (eigenes Skript)

> [!abstract] Worum es geht
> Mermaid-Blöcke in Markdown-Dateien erscheinen in der Vorschau nur als Code. Mit der Taste `M` rendert das Skript `mermaid-view` alle Diagramme der Datei unter dem Cursor **lokal** mit `mmdc` als PNG und öffnet sie in einem **neuen Tab**. Die Notiz bleibt im bisherigen Tab offen.

> [!question]- Warum nicht das Plugin `mermaid.yazi`?
> `passion0102/mermaid.yazi` ist das einzige ernsthafte Mermaid-Plugin (Stand September 2026). Dagegen sprachen: Es übernimmt alle `.md`-Dateien und ersetzt den Markdown-Previewer vollständig (ruft glow fest mit `--style dark` auf, Solarized-Stil und Obsidian-Aufbereitung gingen verloren); ohne `mmdc` schickt es den Diagramm-Code jeder Notiz an `mermaid.ink`; die README nennt nur Kitty-Protokoll und iTerm2, foot (Sixel) nicht; kleines Projekt mit wenigen Nutzern.

> [!question]- Warum lokal mit `mmdc` statt `mermaid.ink`?
> Kursunterlagen und private Notizen verlassen den Rechner nicht, und es funktioniert offline. Der Preis: Node.js und ein Headless-Chromium (zusammen rund 770 MB), erstes Rendern dauert etwa 3 Sekunden.

> [!question]- Warum auf Tastendruck statt automatisch?
> Die Vorschau bleibt schnell (0,1 s statt mehrerer Sekunden pro Datei mit Diagramm), und es wird nur gerendert, was man wirklich sehen will.

```
Vorschau (ofm-preview) ──► zeigt Hinweis „mermaid · Taste M …" über jedem Block

Taste M ──► mermaid-view <datei>
              ├─ ```mermaid-Blöcke extrahieren
              ├─ je Block: mmdc ──► ~/.cache/mermaid-view/<notiz>/01-<hash>.png
              ├─ ya emit tab_create ──► neuer Tab im Bild-Ordner
              └─ ya emit reveal     ──► Cursor auf das erste Bild
```

> [!note] Installation und vollständiger Inhalt
> `brew install mermaid-cli`, die Chromium-Installation für `mmdc`, das Farbschema `~/.config/mermaid/solarized-light.json`, das Skript `mermaid-view` und die Taste `M` in `keymap.toml` stehen vollständig in [[#0 Schnellstart: alle Befehle in Reihenfolge]] (Schritt 2, 6 und 7).

> [!important] Nach `brew upgrade mermaid-cli` wiederholen
> Jede mermaid-cli-Version erwartet eine bestimmte Chromium-Version. Der Chromium-Befehl aus Schritt 2 liest sie aus dem installierten Puppeteer. Alte Versionen unter `~/.cache/puppeteer/chrome-headless-shell/` können danach gelöscht werden.

Kurzer Test ohne Yazi:

```nu
"flowchart LR\n  A --> B" | save -f /tmp/test.mmd
^mmdc -q -i /tmp/test.mmd -o /tmp/test.png
file /tmp/test.png
```

`"theme": "base"` ist im Farbschema das einzige Mermaid-Theme, dessen Farben sich vollständig über `themeVariables` setzen lassen. Knoten `#eee8d5` (base2) mit Rand `#93a1a1` (base1), Text `#073642` (base02), Linien `#657b83` (base00), Notizen in Sequenzdiagrammen gelblich mit Rand `#b58900`.

- **Cache mit Hash:** Der Dateiname enthält die ersten 8 Zeichen des SHA-256 über den Diagramm-Code. Unveränderte Diagramme werden nicht neu gerendert, geänderte bekommen einen neuen Namen, veraltete Bilder werden gelöscht.
- **Ein Verzeichnis pro Notiz:** `~/.cache/mermaid-view/<Dateiname ohne .md>/`.
- **`| complete`** fängt Exit-Code und Fehlerausgabe von `mmdc` ab, statt das Skript abzubrechen.
- **`^ya emit tab_create` + `reveal`** schicken Yazi zwei Befehle: neuen Tab im Bild-Ordner öffnen, dann Cursor auf das erste Bild setzen.
- **`-b "#fdf6e3"`** setzt den Bildhintergrund auf Solarized base3, **`-s 2`** rendert in doppelter Auflösung.

Taste `M` (siehe Schnellstart, Schritt 6): `%h` ist die Datei unter dem Cursor (auch bei Leerzeichen/Sonderzeichen im Namen), `--block` übergibt das Terminal ans Skript.

**Hinweis in der Markdown-Vorschau:** bereits im `ofm-preview`-Skript in [[#6.1 piper – Markdown-Vorschau]] enthalten (Zeile mit `str replace ... mermaid`).

**Bedienung:** Cursor auf eine Markdown-Datei mit Diagrammen, `M` drücken, neuer Tab öffnet sich in `~/.cache/mermaid-view/<notiz>/`, `j`/`k` wechselt zwischen den Diagrammen.

| Taste     | Wirkung                                                            |
| ----------- | --------------------------------------------------------------------- |
| `Ctrl+c`      | Diagramm-Tab schließen, zurück zur Notiz                              |
| `1` / `2`     | Zwischen Notiz-Tab und Diagramm-Tab wechseln, beide bleiben offen      |
| `[` / `]`     | Vorheriger / nächster Tab                                              |

> [!tip] Größer ansehen
> `Enter` öffnet das PNG mit dem Standardprogramm für `image/png` (Referenzsystem: Google Chrome; umstellen auf `imv`: `^xdg-mime default imv.desktop image/png`). `T` maximiert den Vorschaubereich (Plugin toggle-pane, [[#6.3 toggle-pane – Vorschau maximieren]]).

> [!failure]- Fehlersuche
> - **`Could not find chrome-headless-shell`:** Chromium fehlt oder passt nicht mehr zur mermaid-cli-Version – Befehl oben erneut ausführen.
> - **`UnknownDiagramError: No diagram type detected`:** Der Diagrammtyp existiert in Mermaid nicht, z. B. `usecaseDiagram` ist PlantUML-Syntax. Nachbau als Flowchart mit Systemgrenze als `subgraph`, siehe [[99 Beispiele]] unter UML-Basics.
> - **`Parse error on line …`:** Syntaxfehler im Diagramm, die Zeilenangabe bezieht sich auf den Mermaid-Block, nicht auf die Markdown-Datei.
> - **Taste `M` ohne Wirkung:** Yazi nach Änderung an `keymap.toml` nicht neu gestartet, oder `mermaid-view` nicht ausführbar bzw. nicht im `$PATH`.
> - **Kein neuer Tab:** Alle Diagramme fehlgeschlagen, Fehlermeldungen stehen vor „Taste drücken“.
> - **Bild wird nicht angezeigt, nur Dateiinfo:** Terminal meldet kein Bildprotokoll (Sixel/Kitty-Grafik prüfen).

> [!caution] Grenzen
> Diagramme erscheinen als separate Bilder, nicht in der Textvorschau. Nur drei Backticks mit `mermaid` werden erkannt, nicht `~~~mermaid`. Nur Markdown-Dateien – einzelne `.mmd`-Dateien direkt mit `mmdc` rendern. Der Cache unter `~/.cache/mermaid-view/` wird nie automatisch geleert: `rm -r ~/.cache/mermaid-view`.

---

## 7 Solarized Light Flavor

Ein **Flavor** ist ein fertiges Theme-Paket. Er liegt als Verzeichnis mit der Endung `.yazi` in `~/.config/yazi/flavors/` und enthält mindestens `flavor.toml` (Farben der Oberfläche) und `tmtheme.xml` (Syntaxhervorhebung in der Dateivorschau). Die eigene `theme.toml` wählt den Flavor aus und kann einzelne Werte überschreiben.

> [!note] Kein offizieller Solarized-Light-Flavor
> Im Repository `yazi-rs/flavors` ist der Wunsch nach Solarized Dark und Light seit Januar 2024 offen. Der einzige gepflegte Community-Flavor, `peterfication/solarized.yazi`, gibt es nur als **Dark**-Variante. Die helle Variante `solarized-light.yazi` wurde deshalb daraus abgeleitet.

Solarized ist so entworfen, dass die helle Variante die Grundtöne der dunklen spiegelt, die acht Akzentfarben bleiben gleich:

| Rolle in Dark | Dark      | Light     | Rolle in Light |
| --------------- | ----------- | ----------- | ----------------- |
| base03            | `#002b36`     | `#fdf6e3`     | base3              |
| base02            | `#073642`     | `#eee8d5`     | base2              |
| base01            | `#586e75`     | `#93a1a1`     | base1              |
| base00            | `#657b83`     | `#839496`     | base0              |

Dieser Tausch wurde in `flavor.toml` und `tmtheme.xml` durchgeführt. Der Original-Flavor steht unter MIT-Lizenz, die Lizenzdateien liegen dem Paket bei.

> [!note] Installation und vollständiger Inhalt
> Entpacken des ZIP und der komplette `[flavor]`-Block in `theme.toml` stehen in [[#0 Schnellstart: alle Befehle in Reihenfolge]] (Schritt 5 und 6).

- **`dark` und `light`:** Yazi erkennt am Terminal-Hintergrund, ob der dunkle oder helle Flavor gilt. Stehen beide auf `solarized-light`, wird die Erkennung umgangen und immer Solarized Light verwendet.
- **Überschreibungen:** Der Flavor bringt eigene abgerundete Trennzeichen mit. Werte in der eigenen `theme.toml` haben Vorrang, deshalb bleiben die Rundungen trotzdem ausgeblendet.

Prüfen: `open ~/.config/yazi/theme.toml | get flavor`

> [!warning] Terminal-Hintergrund
> Yazi färbt nur seine eigenen Elemente. Den Hintergrund liefert das Terminal – stimmig wird das Ergebnis erst, wenn das Terminal selbst auf Solarized Light eingestellt ist.

> [!todo] Offen
> Das abgeleitete Farbschema wurde auf gültige Syntax geprüft, aber nicht live in Yazi begutachtet. Schlecht lesbare Elemente, z. B. die farbigen Zähler für kopierte/ausgeschnittene Dateien, gegebenenfalls in der eigenen `theme.toml` nachfärben.

> [!info] Solarized Dark per Paketmanager
> Die dunkle Originalvariante lässt sich direkt installieren: `ya pkg add peterfication/solarized`

Die abgerundeten Trennzeichen an Cursor-Indikator, Tabs und Statusleiste sind Nerd-Font-Symbole und werden in `theme.toml` festgelegt, **nicht** in `yazi.toml` (voller `theme.toml`-Inhalt: Schnellstart, Schritt 6). Laut Dokumentation erzeugt `padding = { open = "▐", close = "▌" }` statt leerer Strings einen eckigen statt runden Indikator.

---

## 8 Setup auf einen weiteren Rechner übertragen

Die Konfiguration besteht aus Dateien, die kopiert werden, und Teilen, die sich aus diesen Dateien wiederherstellen lassen. Der Ablauf selbst ist identisch mit [[#0 Schnellstart: alle Befehle in Reihenfolge]] – dieser Abschnitt ergänzt nur, **was** dabei mitgenommen werden muss.

**Kopieren bzw. versionieren:**

```
~/.config/yazi/
├── yazi.toml
├── keymap.toml
├── theme.toml
├── init.lua          ← Setup für git und eza-preview
└── package.toml      ← Lockfile für Plugins
~/.config/glow/solarized-light.json     ← Markdown-Vorschau
~/.local/bin/ofm-preview                ← Markdown-Vorschau
~/.config/mermaid/solarized-light.json  ← Mermaid-Diagramme
~/.local/bin/mermaid-view               ← Mermaid-Diagramme
```

**Nicht kopieren:** `plugins/` – stellt `ya pkg install` aus `package.toml` wieder her (Schnellstart, Schritt 4 wird dadurch überflüssig, `ya pkg install` genügt).

> [!warning] Flavor `solarized-light` ist kein Paket
> Der helle Flavor wurde selbst abgeleitet und steht nicht in `package.toml`. `flavors/solarized-light.yazi` muss weiterhin aus dem ZIP im Vault entpackt werden, siehe [[#7 Solarized Light Flavor]].

Abschließend prüfen: `ya pkg list` muss sieben Plugins zeigen (`piper`, `toggle-pane`, `git`, `eza-preview`, `smart-enter`, `chmod`, `ouch`), dann Yazi neu starten.

---

## 9 Fallstricke und Versionsunterschiede

> [!failure] Was regelmäßig schiefgeht
> - **Plugin installiert, aber nichts passiert** – `ya pkg add` aktiviert nicht, der Eintrag in `yazi.toml` fehlt
> - **Konfiguration geändert, keine Wirkung** – Yazi läuft noch mit der alten Konfiguration; alle Instanzen beenden und neu starten
> - **Plugin modifiziert, dann `upgrade`** – bricht mit Hash-Fehler ab; Plugin mit `ya pkg delete` entfernen und neu installieren
> - **Yazi-Update ohne `ya pkg upgrade`** – Plugins und Yazi müssen zueinander passen
> - **Yazi in Toolbx nicht gefunden** – brew-Pfad existiert im Container nicht, Yazi auf dem Host starten
> - **Symbole als Kästchen** – keine Nerd Font im Terminal
> - **`Z` findet nichts** – zoxide-Hook für Nushell fehlt oder es wurde noch nicht mit `cd` gewechselt
> - **Maximierte Bilder unscharf** – `[preview] max_width/max_height` zu klein oder Cache nicht geleert (`ya cache clear`)

| Thema                   | Yazi 26.x                    | Ältere Versionen           |
| -------------------------- | ------------------------------- | ------------------------------ |
| Neuer Tab                   | `t t`                             | `t`                              |
| Platzhalter im Opener        | `%s`                              | `"$@"`                          |
| Hauptabschnitt in `yazi.toml` | `[mgr]`                          | `[manager]` (vor 25.x)          |
| Paketverwaltung               | `ya pkg add autor/repo`           | `ya pack -a autor/repo`         |

```nu
# Prüfen, welche Hilfsprogramme vorhanden sind
[fd rg fzf zoxide hx] | each {|p| {programm: $p, gefunden: (which $p | is-not-empty)} }
```

---

## 10 Referenzen

- Yazi-Dokumentation: <https://yazi-rs.github.io/docs/>
- Standard-Tastenbelegung: <https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/keymap-default.toml>
- Flavor-Übersicht: <https://yazi-rs.github.io/docs/flavors/overview/>
- Plugin-Monorepo: <https://github.com/yazi-rs/plugins>
- Plugin-Sammlung: <https://github.com/AnirudhG07/awesome-yazi>
- Homebrew-Formel: <https://formulae.brew.sh/formula/yazi>
- piper.yazi: <https://github.com/yazi-rs/plugins/tree/main/piper.yazi>
- glow: <https://github.com/charmbracelet/glow>, glamour-Stile: <https://github.com/charmbracelet/glamour/tree/master/styles>
- mermaid-cli: <https://github.com/mermaid-js/mermaid-cli>, Themes: <https://mermaid.js.org/config/theming.html>
- Puppeteer-Browser-Installation: <https://pptr.dev/guides/configuration>
- Verworfen: mermaid.yazi <https://github.com/passion0102/mermaid.yazi>
- Solarized-Dark-Flavor (Basis der hellen Variante): <https://github.com/peterfication/solarized.yazi>
- Solarized von Ethan Schoonover: <https://ethanschoonover.com/solarized/>

## Verwandt

- [[Yazi – Einführung]] – was Yazi ist und wie das Bedienkonzept funktioniert
- [[Yazi-Leitfaden]] – Befehlsreferenz mit Grafiken zum Spickzettel
- [[00 Werkzeuge ins HOME-Verzeichnis installieren]] – warum brew-Programme in Toolbx fehlen
- [[Nushell Editor setzen]] – Helix als `$EDITOR`
