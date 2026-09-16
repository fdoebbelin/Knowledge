---
title: Yazi – Installation und Plugins
tags:
  - yazi
  - terminal
  - homebrew
  - atomic
system: Fedora Sway Atomic
yazi_version: "26.9.1"
created: 2026-07-15
updated: 2026-09-16
---

# Yazi – Installation und Plugins

> [!abstract] Worum es geht
> Yazi ist ein Terminal-Dateimanager in Rust mit asynchroner I/O, Vim-artiger Bedienung und einem Lua-Plugin-System. Diese Notiz beschreibt die Installation über **Homebrew** auf **Fedora Sway Atomic**, die Hilfsprogramme, das Plugin-System mit `ya pkg` und wie man ein fertiges Setup auf weitere Rechner überträgt.

> [!info] Geltungsbereich
> - **System:** ausschließlich Fedora Sway Atomic
> - **Installation:** ausschließlich über Homebrew (`brew`)
> - **Version:** abgeglichen mit Yazi 26.9.1
> - **Befehle:** Nushell-Syntax
>
> Bedienung und Konfiguration stehen in [[Yazi – kommentierter Leitfaden]], die Markdown-Vorschau in [[Yazi – Markdown-Vorschau]].

---

## 1. Einordnung

Nachfolger im Geiste von `ranger` und `lf`, aber:

- **Vollständig asynchron** – Vorschau-Generierung blockiert die UI nie
- **Lua-Plugin-System** mit eigenem Paketmanager (`ya pkg`)
- **Bildprotokolle nativ** – Kitty Graphics, Sixel (z. B. `foot`), iTerm2
- **Vim-artige Tastenbelegung**

> [!warning] Beta-Status
> Yazi ist offiziell Public Beta. Breaking Changes in der Konfiguration kommen vor, siehe [[Yazi – kommentierter Leitfaden#Versionsunterschiede und Stolpersteine]]. Ältere Blogposts zeigen oft noch veraltete Syntax. Bei Fehlern zuerst `yazi --version` prüfen.

---

## 2. Installation mit Homebrew

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

## 3. Hilfsprogramme

Yazi selbst braucht nur `file(1)`, das im Basisimage liegt. Alles Weitere schaltet Funktionen frei. Einige Programme bringt das Basisimage bereits mit. Fehlende werden über `brew` nachinstalliert.

| Programm   | brew-Formel   | Wofür                                              | Auf dem Referenzsystem |
| ---------- | ------------- | -------------------------------------------------- | ---------------------- |
| `glow`     | `glow`        | Markdown-Vorschau                                  | brew                   |
| `mmdc`     | `mermaid-cli` | Mermaid-Diagramme (+ Chromium, siehe [[Yazi – Mermaid-Diagramme]]) | brew   |
| `rich`     | `rich-cli`    | Vorschau für CSV, Jupyter-Notebooks, reStructuredText | brew                |
| `eza`      | `eza`         | Verzeichnisvorschau als Baum                       | brew                   |
| `mediainfo`| `media-info`  | Menüeintrag „Show media info“ für Audio/Video (`O`) | brew                  |
| `fd`       | `fd`          | Dateisuche nach Namen (Taste `s`)                  | brew                   |
| `rg`       | `ripgrep`     | Inhaltssuche (Taste `S`)                           | brew                   |
| `fzf`      | `fzf`         | Springen per fzf (Taste `z`)                       | brew                   |
| `zoxide`   | `zoxide`      | Verzeichnishistorie (Taste `Z`), braucht Shell-Hook | brew                  |
| `resvg`    | `resvg`       | SVG-Vorschau                                       | brew                   |
| `jq`       | `jq`          | JSON-Vorschau                                      | Basisimage             |
| `7z`       | `sevenzip`    | Archiv-Vorschau und -Extraktion                    | Basisimage             |
| `pdftoppm` | `poppler`     | PDF-Vorschau                                       | Basisimage             |
| `ffmpeg`   | `ffmpeg`      | Video-Thumbnails                                   | Basisimage             |
| `magick`   | `imagemagick` | Font-, HEIC-, JPEG-XL-Vorschau                     | Basisimage             |
| `wl-copy`  | –             | Zwischenablage unter Wayland/Sway                  | Basisimage             |

Vorhandene Programme prüfen:

```nu
[glow mmdc rich eza mediainfo fd rg fzf zoxide resvg jq 7z pdftoppm ffmpeg magick wl-copy]
| each {|p| {programm: $p, pfad: (which $p | get path.0? | default "–")} }
```

Alles aus brew in einem Schritt:

```nu
brew install glow mermaid-cli rich-cli eza media-info fd ripgrep fzf zoxide resvg
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

## 4. Das Plugin-System

### Vier Plugin-Typen

| Typ            | Aufgabe                                         |
| -------------- | ----------------------------------------------- |
| **Previewer**  | Rendert den Inhalt im Vorschaubereich           |
| **Preloader**  | Bereitet Vorschauen im Voraus auf               |
| **Fetcher**    | Holt Metadaten (z. B. Git-Status pro Datei)     |
| **Funktional** | Reagiert auf Tastendrücke, ändert die Oberfläche |

Plugins liegen als `<name>.yazi/`-Verzeichnis mit `main.lua` als Einstiegspunkt in `~/.config/yazi/plugins/`.

### `ya pkg add` – was dabei passiert

```nu
ya pkg add yazi-rs/plugins:piper
```

| Teil                    | Bedeutung                                                        |
| ----------------------- | ---------------------------------------------------------------- |
| `ya`                    | Yazis CLI-Programm, wird von brew zusammen mit `yazi` installiert |
| `pkg`                   | Paketverwaltung (hieß früher `pack`)                             |
| `add`                   | Installieren und in `package.toml` eintragen                     |
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

## 5. Eingerichtete Plugins

| Plugin                        | Zweck                                           | Taste      | Dokumentation |
| ----------------------------- | ----------------------------------------------- | ---------- | ------------- |
| `yazi-rs/plugins:piper`       | Shell-Kommando als Vorschau (Markdown, CSV, Notebooks) | –   | [[Yazi – Markdown-Vorschau]], [[#5.3 Vorschau für CSV, Notebooks und reStructuredText]] |
| `yazi-rs/plugins:toggle-pane` | Vorschau maximieren / wiederherstellen          | `T`        | [[#5.1 toggle-pane – Vorschau maximieren]] |
| `yazi-rs/plugins:git`         | Git-Status pro Datei in der Liste               | –          | [[#5.2 git – Status pro Datei]] |
| `ahkohd/eza-preview`           | Verzeichnisvorschau als Baum                    | `e t`, `e +`, `e -` | [[#5.4 eza-preview – Verzeichnisse als Baum]] |

Ohne Plugin, als eigenes Skript mit Taste `M`: Mermaid-Diagramme, siehe [[Yazi – Mermaid-Diagramme]].

### 5.1 toggle-pane – Vorschau maximieren

```nu
ya pkg add yazi-rs/plugins:toggle-pane
```

`keymap.toml`:

```toml
[[mgr.prepend_keymap]]
on   = "T"
run  = "plugin toggle-pane max-preview"
desc = "Vorschau maximieren / wiederherstellen"
```

`yazi.toml`:

```toml
[preview]
# Bildvorschau bis Monitorauflösung (1920×1080), damit maximierte Vorschau (Taste T) scharf bleibt
max_width  = 1920
max_height = 1080
```

- **`T`** schaltet zwischen normaler und maximierter Vorschau um. Text-Previewer wie glow rendern dabei neu auf die volle Breite (getestet).
- **`max_width`/`max_height`:** Standard sind 600×900 Pixel. Bilder werden auf diese Größe verkleinert zwischengespeichert und wirken maximiert sonst unscharf. Werte an den Monitor anpassen.
- **Nach Änderung** einmal `ya cache clear`, damit bereits verkleinerte Bilder neu erzeugt werden.
- Weitere Varianten laut README: `min-preview` (Vorschau aus-/einblenden), `max-current`, `reset`.

### 5.2 git – Status pro Datei

```nu
ya pkg add yazi-rs/plugins:git
```

`init.lua`:

```lua
require("git"):setup {
	order = 1500,
}
```

`yazi.toml`:

```toml
[[plugin.prepend_fetchers]]
url   = "*"
run   = "git"
group = "git"

[[plugin.prepend_fetchers]]
url   = "*/"
run   = "git"
group = "git"
```

- **Fetcher** für Dateien (`*`) und Verzeichnisse (`*/`). Ohne beide Einträge fehlt der Status bei Ordnern.
- **Zeichen:** neue Dateien `?`, geänderte, hinzugefügte, gelöschte und ignorierte Dateien Nerd-Font-Symbole. Farben kommen aus der Terminal-Palette; anpassbar im Abschnitt `[git]` der `theme.toml` (siehe README).
- **Getestet** in einem Beispiel-Repository: `?` bei neuer Datei, Symbol bei geänderter, nichts bei unveränderter.

### 5.3 Vorschau für CSV, Notebooks und reStructuredText

Kein eigenes Plugin: `AnirudhG07/rich-preview` empfiehlt selbst den Weg über piper. Voraussetzung `brew install rich-cli`.

`yazi.toml`, im Array `prepend_previewers`:

```toml
  { url = "*.{csv,ipynb,rst}", run = 'piper -- rich --force-terminal --left --theme solarized-light -w $w "$1" </dev/null' },
```

| Option               | Wirkung                                                      |
| -------------------- | ------------------------------------------------------------ |
| `--force-terminal`   | Farben trotz fehlendem Terminal (wie `CLICOLOR_FORCE` bei glow) |
| `--left`             | Linksbündig statt zentriert                                  |
| `--theme solarized-light` | Syntaxfarben in Notebook-Codezellen, passend zum Flavor |
| `-w $w`              | Breite des Vorschaubereichs                                  |

- **CSV** erscheint als Tabelle mit Kopfzeile, **Notebooks** mit Markdown-Zellen, Codezellen im Rahmen und Ausgaben (getestet).
- **JSON und Markdown bleiben** bei `jq` bzw. `ofm-preview`.

### 5.4 eza-preview – Verzeichnisse als Baum

```nu
brew install eza
ya pkg add ahkohd/eza-preview
```

`yazi.toml`, im Array `prepend_previewers`:

```toml
  { url = "*/", run = "eza-preview" },
```

`init.lua`:

```lua
require("eza-preview"):setup {
	default_tree = true,
	level = 2,
	icons = true,
	all = true,
	git_ignore = true,
	ignore_glob = { ".git" },
}
```

`keymap.toml`:

```toml
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
```

- **`level = 2`** statt Standard 3: Vault-Ordner sind tief verschachtelt, drei Ebenen füllen den Vorschaubereich sofort.
- **`git_ignore`** blendet Dateien aus `.gitignore` aus, **`ignore_glob`** zusätzlich das `.git`-Verzeichnis, das `all = true` sonst zeigen würde.
- **Präfix `e`** ist im Dateimanager-Modus von Yazi 26.9.1 frei (`e` ist nur im Eingabefeld belegt).

### 5.5 Medien-Metadaten

Das Plugin `boydaihungst/mediainfo` ist **nicht** eingerichtet:
- Das Repository ist als *deprecated* markiert (September 2026).
- Es ersetzt die eingebaute Bildvorschau für alle Bilder, auch für die Mermaid-PNGs.

Stattdessen genügt `brew install media-info`: Yazis Standardkonfiguration enthält für Audio und Video bereits einen Opener „Show media info“. Aufruf: Cursor auf die Datei, `O`, Eintrag auswählen.

### Kandidaten (noch nicht eingerichtet)

| Plugin                            | Zweck                                                   |
| --------------------------------- | ------------------------------------------------------- |
| `yazi-rs/plugins:smart-enter`     | `Enter` öffnet Dateien oder betritt Verzeichnisse       |
| `yazi-rs/plugins:chmod`           | Rechte der Auswahl ändern                               |
| `ndtoan96/ouch`                   | Archive                                                 |

> [!note] Aktivierung laut README
> Die Konfigurationsschlüssel ändern sich zwischen Yazi-Versionen. Die Aktivierung wird deshalb erst beim Einrichten aus der README des Plugins übernommen, getestet und dann hier dokumentiert.

---

## 6. Setup auf einen weiteren Rechner übertragen

Die Konfiguration besteht aus Dateien, die kopiert werden, und Teilen, die sich aus diesen Dateien wiederherstellen lassen.

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

Die vollständigen, aktuellen Inhalte von `yazi.toml`, `keymap.toml` und `init.lua` stehen in [[Yazi – kommentierter Leitfaden#10. Vollständige Beispielkonfiguration]].

**Nicht kopieren:** `plugins/` – stellt `ya pkg install` aus `package.toml` wieder her.

> [!warning] Flavor `solarized-light` ist kein Paket
> Der helle Flavor wurde selbst abgeleitet und steht nicht in `package.toml`. `flavors/solarized-light.yazi` muss aus dem ZIP im Vault entpackt werden, siehe [[Yazi – kommentierter Leitfaden#8.3 Installation]].

Ablauf auf dem neuen Rechner:

```nu
# 1. Yazi und Hilfsprogramme
brew install yazi glow mermaid-cli rich-cli eza media-info fd ripgrep fzf zoxide resvg

# 1b. Chromium für mmdc (passende Version wird automatisch ermittelt)
^node (brew --prefix mermaid-cli | str trim | path join "libexec/lib/node_modules/@mermaid-js/mermaid-cli/node_modules/puppeteer/lib/puppeteer/node/cli.js") browsers install chrome-headless-shell

# 1c. zoxide-Hook für Nushell
zoxide init nushell | save -f ($nu.data-dir | path join "vendor" "autoload" "zoxide.nu")

# 2. Konfigurationsdateien an ihren Ort kopieren (siehe oben)

# 3. Plugins aus package.toml wiederherstellen
ya pkg install

# 4. Skripte ausführbar machen
chmod +x ~/.local/bin/ofm-preview ~/.local/bin/mermaid-view

# 5. Prüfen
ya pkg list
```

`ya pkg list` muss vier Plugins zeigen: `piper`, `toggle-pane`, `git`, `eza-preview`.

Anschließend Yazi neu starten.

---

## 7. Fallstricke

> [!failure] Was regelmäßig schiefgeht
> - **Plugin installiert, aber nichts passiert** – `ya pkg add` aktiviert nicht, der Eintrag in `yazi.toml` fehlt
> - **Konfiguration geändert, keine Wirkung** – Yazi läuft noch mit der alten Konfiguration; alle Instanzen beenden und neu starten
> - **Plugin modifiziert, dann `upgrade`** – bricht mit Hash-Fehler ab; Plugin mit `ya pkg delete` entfernen und neu installieren
> - **Yazi-Update ohne `ya pkg upgrade`** – Plugins und Yazi müssen zueinander passen
> - **Yazi in Toolbx nicht gefunden** – brew-Pfad existiert im Container nicht, Yazi auf dem Host starten
> - **Symbole als Kästchen** – keine Nerd Font im Terminal
> - **`Z` findet nichts** – zoxide-Hook für Nushell fehlt oder es wurde noch nicht mit `cd` gewechselt
> - **Maximierte Bilder unscharf** – `[preview] max_width/max_height` zu klein oder Cache nicht geleert (`ya cache clear`)

---

## Referenzen

- Offizielle Dokumentation: <https://yazi-rs.github.io/docs/>
- Plugin-Monorepo: <https://github.com/yazi-rs/plugins>
- Plugin-Sammlung: <https://github.com/AnirudhG07/awesome-yazi>
- Homebrew-Formel: <https://formulae.brew.sh/formula/yazi>

## Verwandt

- [[Yazi – kommentierter Leitfaden]] – Bedienung, Helix als Editor, Theme, Solarized Light, Shell-Wrapper
- [[Yazi – Markdown-Vorschau]] – glow mit Solarized-Stil und Obsidian-Aufbereitung
- [[Yazi – Mermaid-Diagramme]] – Diagramme auf Tastendruck lokal rendern
- [[00 Werkzeuge ins HOME-Verzeichnis installieren]] – warum brew-Programme in Toolbx fehlen
