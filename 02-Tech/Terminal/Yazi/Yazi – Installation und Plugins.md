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

| Programm        | brew-Formel   | Wofür                                | Auf dem Referenzsystem |
| --------------- | ------------- | ------------------------------------ | ---------------------- |
| `glow`          | `glow`        | Markdown-Vorschau                    | brew                   |
| `fd`            | `fd`          | Dateisuche nach Namen (Taste `s`)    | fehlt                  |
| `rg`            | `ripgrep`     | Inhaltssuche (Taste `S`)             | fehlt                  |
| `fzf`           | `fzf`         | Springen per fzf (Taste `z`)         | fehlt                  |
| `zoxide`        | `zoxide`      | Verzeichnishistorie (Taste `Z`)      | fehlt                  |
| `resvg`         | `resvg`       | SVG-Vorschau                         | fehlt                  |
| `jq`            | `jq`          | JSON-Vorschau                        | Basisimage             |
| `7z`            | `sevenzip`    | Archiv-Vorschau und -Extraktion      | Basisimage             |
| `pdftoppm`      | `poppler`     | PDF-Vorschau                         | Basisimage             |
| `ffmpeg`        | `ffmpeg`      | Video-Thumbnails                     | Basisimage             |
| `magick`        | `imagemagick` | Font-, HEIC-, JPEG-XL-Vorschau       | Basisimage             |
| `wl-copy`       | –             | Zwischenablage unter Wayland/Sway    | Basisimage             |

Vorhandene Programme prüfen:

```nu
[glow fd rg fzf zoxide resvg jq 7z pdftoppm ffmpeg magick wl-copy]
| each {|p| {programm: $p, pfad: (which $p | get path.0? | default "–")} }
```

Fehlende nachinstallieren, z. B.:

```nu
brew install fd ripgrep fzf zoxide resvg
```

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

| Plugin                  | Zweck                                     | Dokumentation                  |
| ----------------------- | ----------------------------------------- | ------------------------------ |
| `yazi-rs/plugins:piper` | Beliebiges Shell-Kommando als Vorschau    | [[Yazi – Markdown-Vorschau]]   |

### Kandidaten (noch nicht eingerichtet)

| Plugin                            | Zweck                                                   |
| --------------------------------- | ------------------------------------------------------- |
| `passion0102/mermaid`             | Mermaid-Diagramme in der Markdown-Vorschau als Bild     |
| `AnirudhG07/rich-preview`         | Vorschau für CSV, JSON, Jupyter-Notebooks               |
| `ahkohd/eza-preview`              | Verzeichnisse als Baum                                  |
| `boydaihungst/mediainfo`          | Metadaten von Audio und Video                           |
| `yazi-rs/plugins:git`             | Git-Status pro Datei                                    |
| `yazi-rs/plugins:toggle-pane`     | Vorschau maximieren                                     |
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
├── init.lua          (falls vorhanden)
└── package.toml      ← Lockfile für Plugins
~/.config/glow/solarized-light.json   ← Markdown-Vorschau
~/.local/bin/ofm-preview              ← Markdown-Vorschau
```

**Nicht kopieren:** `plugins/` – stellt `ya pkg install` aus `package.toml` wieder her.

> [!warning] Flavor `solarized-light` ist kein Paket
> Der helle Flavor wurde selbst abgeleitet und steht nicht in `package.toml`. `flavors/solarized-light.yazi` muss aus dem ZIP im Vault entpackt werden, siehe [[Yazi – kommentierter Leitfaden#8.3 Installation]].

Ablauf auf dem neuen Rechner:

```nu
# 1. Yazi und Hilfsprogramme
brew install yazi glow

# 2. Konfigurationsdateien an ihren Ort kopieren (siehe oben)

# 3. Plugins aus package.toml wiederherstellen
ya pkg install

# 4. Vorschau-Skript ausführbar machen
chmod +x ~/.local/bin/ofm-preview

# 5. Prüfen
ya pkg list
```

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

---

## Referenzen

- Offizielle Dokumentation: <https://yazi-rs.github.io/docs/>
- Plugin-Monorepo: <https://github.com/yazi-rs/plugins>
- Plugin-Sammlung: <https://github.com/AnirudhG07/awesome-yazi>
- Homebrew-Formel: <https://formulae.brew.sh/formula/yazi>

## Verwandt

- [[Yazi – kommentierter Leitfaden]] – Bedienung, Helix als Editor, Theme, Solarized Light, Shell-Wrapper
- [[Yazi – Markdown-Vorschau]] – glow mit Solarized-Stil und Obsidian-Aufbereitung
- [[00 Werkzeuge ins HOME-Verzeichnis installieren]] – warum brew-Programme in Toolbx fehlen
