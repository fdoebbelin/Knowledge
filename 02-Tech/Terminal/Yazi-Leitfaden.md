---
title: "Yazi — Terminal-Dateimanager mit Plugin-System"
created: 2026-07-15
tags:
  - linux
  - terminal
  - yazi
  - nushell
  - markdown
version-referenz: "Yazi 26.5.6"
status: aktiv
---
> [!abstract] Worum es geht
> Yazi ist ein Terminal-Dateimanager in Rust mit asynchroner I/O. Für den hier relevanten Zweck — schneller Blick in Markdown-Dateien ohne GUI — ist die permanente Vorschau im rechten Pane der eigentliche Gewinn. Kein Tastendruck, kein Fenster, kein Sandbox-Gefummel.

## 1. Einordnung

Nachfolger im Geiste von `ranger` und `lf`, aber:

- **Vollständig asynchron** — Vorschau-Generierung blockiert die UI nie
- **Lua-Plugin-System** mit eigenem Paketmanager (`ya pkg`)
- **Bildprotokolle nativ** — Kitty Graphics, Sixel, iTerm2, Fallback über Überzug++/Chafa
- **Vim-artige Tastenbelegung**

> [!warning] Beta-Status
> Yazi ist offiziell Public Beta. Breaking Changes in der Konfiguration kommen vor — die Umbenennung `[manager]` → `[mgr]` ist das prominenteste Beispiel. Ältere Blogposts zeigen noch die alte Syntax. Bei Fehlern: erst Versionen prüfen.

---

## 2. Installation

### Fedora (klassisch)

Über ein inoffizielles COPR-Repository, gepflegt von Peter Li:

```sh
dnf copr enable lihaohong/yazi
dnf install yazi
```

`dnf` zieht die empfohlenen Abhängigkeiten automatisch mit. Nur Yazi ohne Beiwerk:

```sh
dnf install yazi --setopt=install_weak_deps=False
```

Falls `dnf` "No such command: copr" meldet: `dnf install dnf-plugins-core`.

### Fedora Atomic / bootc

> [!important] Für die Schulungsflotte
> COPR-Layering via `rpm-ostree` funktioniert, ist aber für ein Fleet-Image der falsche Weg — jeder Client rebuildet dann lokal. Besser: das COPR-Repo im `Containerfile` aktivieren und Yazi ins Image backen.
>
> ```dockerfile
> RUN dnf -y install dnf-plugins-core && \
>     dnf -y copr enable lihaohong/yazi && \
>     dnf -y install yazi && \
>     dnf clean all
> ```
>
> Alternative für schnelle Iteration ohne Image-Rebuild: offizielles Binary nach `~/.local/bin`. Yazi ist ein statisches Rust-Binary ohne nennenswerte Laufzeitabhängigkeiten.

### Flatpak — nicht empfohlen

Es gibt `io.github.sxyazi.yazi`, die Upstream-Doku warnt aber ausdrücklich: Die Flatpak-Edition hat wegen des Sandboxing viele Einschränkungen, und Power-User sollten auf eine alternative Installation umsteigen, um unerwartete Breakages zu vermeiden. Ein Dateimanager in einer Sandbox ist ein Widerspruch in sich.

### Optionale Abhängigkeiten

Yazi braucht zwingend nur `file(1)`. Alles Weitere schaltet Features frei:

| Paket | Wofür |
|---|---|
| `ffmpeg` | Video-Thumbnails |
| `7zip` | Archiv-Vorschau und -Extraktion |
| `jq` | JSON-Vorschau |
| `poppler` | PDF-Vorschau |
| `fd` | Dateisuche (Taste `s`) |
| `ripgrep` | Inhaltssuche (Taste `S`) |
| `fzf` | Subtree-Navigation (Taste `z`), ≥ 0.53.0 |
| `zoxide` | Verzeichnishistorie (Taste `Z`), braucht `fzf` |
| `resvg` | SVG-Vorschau |
| ImageMagick | Font-, HEIC-, JPEG-XL-Vorschau, ≥ 7.1.1 |
| `wl-clipboard` | Zwischenablage unter Wayland |
| Nerd Font | Icons |

---

## 3. Shell-Wrapper für Nushell

Beim Beenden mit `q` bleibt das CWD der Shell unverändert — ein Subprozess kann die Umgebung seines Elternprozesses nicht ändern. Der offizielle Wrapper löst das über eine Temp-Datei:

```nu
# ~/.config/nushell/config.nu
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

> [!tip] Die drei Details, die man leicht übersieht
> - `def --env` ist zwingend — ohne das Flag wirkt `cd` nur innerhalb der Funktion und verpufft.
> - `^yazi` mit Caret ruft explizit das externe Kommando auf, nicht die Funktion.
> - `q` beendet **mit** Verzeichniswechsel, `Q` **ohne**.

---

## 4. Grundbedienung

`F1` oder `~` öffnet die Hilfe. Die wichtigsten Tasten:

### Navigation

| Taste | Aktion |
|---|---|
| `h` `j` `k` `l` | links / runter / hoch / rechts (Verzeichnis betreten) |
| `K` / `J` | **Vorschau um 5 Einheiten hoch/runter scrollen** |
| `gg` / `G` | Anfang / Ende |
| `z` | Cd/Reveal via fzf |
| `Z` | Cd via zoxide |

> [!note] `K` und `J` sind der Schlüssel
> Die Vorschau ist scrollbar, ohne dass die Datei geöffnet wird. Genau das macht Yazi zum Quick-Look-Ersatz: Cursor auf die Datei, `J` zum Durchblättern, weiter zur nächsten.

### Auswahl und Dateioperationen

| Taste | Aktion |
|---|---|
| `Space` | Auswahl umschalten |
| `v` / `V` | Visual Mode (setzen / aufheben) |
| `y` / `x` / `p` | Kopieren / Ausschneiden / Einfügen |
| `d` / `D` | In den Papierkorb / endgültig löschen |
| `a` / `r` | Anlegen (mit `/` am Ende → Verzeichnis) / Umbenennen |
| `.` | Versteckte Dateien umschalten |
| `o` / `O` | Öffnen / interaktiv öffnen |
| `;` / `:` | Shell-Kommando (ohne / mit Blockieren) |

### Pfade kopieren

| Taste | Aktion |
|---|---|
| `c` ⇒ `c` | Vollständiger Pfad |
| `c` ⇒ `d` | Verzeichnispfad |
| `c` ⇒ `f` | Dateiname |
| `c` ⇒ `n` | Dateiname ohne Endung |

### Suchen und Filtern

| Taste | Aktion |
|---|---|
| `f` | Filtern (Live) |
| `/` `?` `n` `N` | Suchen im aktuellen Verzeichnis |
| `s` | Dateien nach Name suchen (fd) |
| `S` | Dateien nach Inhalt suchen (ripgrep) |

---

## 5. Konfiguration

Alles liegt unter `~/.config/yazi/`:

| Datei | Zweck |
|---|---|
| `yazi.toml` | Verhalten, Opener, Previewer, Plugin-Bindung |
| `keymap.toml` | Tastenbelegung |
| `theme.toml` | Farben (manuell) |
| `init.lua` | Lua-Initialisierung, `setup()`-Aufrufe |
| `package.toml` | **Von `ya pkg` verwaltet — nicht manuell editieren** |
| `plugins/` | Installierte Plugins |
| `flavors/` | Installierte Themes |

> [!danger] Syntax-Falle
> Die Sektion heißt seit Yazi 25.x **`[mgr]`**, nicht mehr `[manager]`. Gleiches gilt für `[[mgr.prepend_keymap]]`. Praktisch jeder Blogpost vor 2025 ist an dieser Stelle veraltet.

### Basis-Setup mit Helix als Editor

```toml
# ~/.config/yazi/yazi.toml
[mgr]
ratio = [1, 3, 4]        # Eltern : Aktuell : Vorschau
sort_by = "natural"
sort_dir_first = true
show_hidden = false

[opener]
edit = [{ run = 'hx "$@"', block = true }]
view = [{ run = 'glow -p "$@"', block = true }]

[open]
prepend_rules = [
  { name = "*.md", use = ["view", "edit"] },
]
```

Mit dieser Reihenfolge öffnet `o` bei Markdown zuerst glow (ansehen), `O` bietet die Liste zur Auswahl — dort dann Helix zum Bearbeiten.

---

## 6. Das Plugin-System

### Vier Plugin-Typen

| Typ | Aufgabe |
|---|---|
| **Previewer** | Rendert den Inhalt im Vorschau-Pane |
| **Preloader** | Bereitet Vorschauen im Voraus auf |
| **Fetcher** | Holt Metadaten (z.B. Git-Status pro Datei) |
| **Funktional** | Reagiert auf Tastendrücke, ändert die UI |

Plugins liegen als `<name>.yazi/`-Verzeichnis mit `main.lua` als Einstiegspunkt in `~/.config/yazi/plugins/`.

### `ya pkg add Reledia/glow` — was da passiert

> [!question]- Das war die Ausgangsfrage — hier die Auflösung
> Der Befehl zerfällt in vier Teile:
>
> | Teil | Bedeutung |
> |---|---|
> | `ya` | Yazis **CLI-Binary**. Ein eigenes Programm neben `yazi` (dem TUI). Wird bei Paket-Installationen mitgeliefert; beim Bauen aus Quellen muss man `yazi` **und** `ya` in den `$PATH` legen. |
> | `pkg` | Das Subkommando für Paketverwaltung. Hieß früher `pack` — deshalb steht in älteren Anleitungen `ya pack -a`. |
> | `add` | Installieren und in `package.toml` eintragen |
> | `Reledia/glow` | GitHub-Kurzform `<owner>/<repo>` |

**Der entscheidende Kniff bei der Kurzform:** Yazi hängt `.yazi` automatisch an. `Reledia/glow` klont also `https://github.com/Reledia/glow.yazi` und legt es unter `~/.config/yazi/plugins/glow.yazi/` ab.

Das Ergebnis in `package.toml`:

```toml
# ~/.config/yazi/package.toml
[[plugin.deps]]
use  = "Reledia/glow"
rev  = "0573024"
hash = "d81b64a39432fcd6224cd75d296e7510"
```

Was diese beiden Felder leisten:

- **`rev`** — Beim ersten Installieren wird der aktuelle HEAD-Commit-SHA festgeschrieben. Nachfolgende `install`-Operationen nutzen genau diese Revision. Ein Lockfile, im Prinzip. `ya pkg upgrade` hebt es an.
- **`hash`** — Ein XxHash3_128 über alle Quell- und Asset-Dateien. Vor jeder destruktiven Operation prüft der Paketmanager, ob die Dateien noch dem gespeicherten Hash entsprechen. Hast du am Plugin geschraubt, bricht er ab statt deine Änderungen zu überschreiben.

> [!important] `ya pkg add` **aktiviert** nichts
> Der Befehl kopiert nur Dateien und schreibt einen Eintrag. Ohne einen zusätzlichen Eintrag in `yazi.toml` (Previewer) oder `keymap.toml`/`init.lua` (funktionale Plugins) passiert exakt gar nichts. Das ist die häufigste Verwirrung.

### Monorepo-Syntax

Ein Doppelpunkt adressiert ein Unterverzeichnis:

```sh
ya pkg add yazi-rs/plugins:git      # → github.com/yazi-rs/plugins/tree/main/git.yazi
ya pkg add yazi-rs/plugins:piper
```

### Alle Kommandos

```sh
ya pkg add <pkg>       # Installieren
ya pkg list            # Auflisten
ya pkg upgrade         # Alle auf neuen HEAD heben
ya pkg delete <pkg>    # Entfernen
ya pkg install         # Alles aus package.toml installieren
```

> [!tip] `ya pkg install` ist das Fleet-Kommando
> `package.toml` ins Git, auf dem frischen Client `ya pkg install` — identischer Plugin-Satz auf identischen Revisionen. Das ist der Grund, warum `rev` gepinnt wird.

> [!warning] Nur GitHub
> `ya pkg` kann ausschließlich von GitHub installieren. Plugins aus anderen Git-Hosts (GitLab, Forgejo, dein selbstgehostetes Git) müssen manuell nach `~/.config/yazi/plugins/` geklont werden — und tauchen dann nicht in `package.toml` auf.

---

## 7. Markdown-Vorschau

### Variante A — `glow.yazi` (spezifisch)

```sh
ya pkg add Reledia/glow
```

Setzt voraus, dass `glow` im `$PATH` liegt.

```toml
# ~/.config/yazi/yazi.toml
[[plugin.prepend_previewers]]
url = "*.md"
run = "glow"
```

Der Zeilenumbruch ist im Plugin hart auf 55 Zeichen gesetzt und muss in `main.lua` geändert werden. Bei einem breiten Vorschau-Pane sieht das schnell krumm aus.

### Variante B — `piper.yazi` (generisch, flexibler)

Piper ist ein Allzweck-Previewer: Du gibst ihm ein Shell-Kommando, seine Ausgabe wird zur Vorschau.

```sh
ya pkg add yazi-rs/plugins:piper
```

```toml
[[plugin.prepend_previewers]]
url = "*.md"
run = 'piper -- glow -w $w "$1"'
```

`$w` ist die Breite des Vorschau-Panes — damit umgeht man das Umbruch-Problem aus Variante A elegant. Manche halten Piper deshalb inzwischen für den besseren Weg als das dedizierte glow-Plugin.

### Variante C — eigene Pipeline für Obsidian-Markdown

Hier wird es für deinen Anwendungsfall interessant. Piper nimmt *jedes* Kommando:

```toml
[[plugin.prepend_previewers]]
run = 'piper -- ofm-preview "$1"'
url = "*.md"
```

Dahinter ein Skript, das Wikilinks und Callouts vorverarbeitet, bevor glow rendert:

```nu
#!/usr/bin/env nu
# ~/.local/bin/ofm-preview
def main [file: string] {
	open --raw $file
	| str replace --all --regex '\[\[([^\|\]]+)\|([^\]]+)\]\]' '$2'
	| str replace --all --regex '\[\[([^\]]+)\]\]' '$1'
	| str replace --all --regex '(?m)^> \[!(\w+)\]' '> **$1**'
	| glow -s dark -
}
```

> [!caution] Erwartungsmanagement
> Das ist Kosmetik, kein Obsidian-Renderer. Wikilinks werden entklammert, Callout-Marker werden zu fettem Text. Für "was steht da drin" ist das ein spürbarer Gewinn. Für "sieht das im Vault korrekt aus" bleibt nur Obsidian selbst oder ein Pandoc-Export mit Lua-Filter.

### Weitere Markdown-Previewer

| Plugin | Ansatz |
|---|---|
| `AnirudhG07/rich-preview` | rich-cli, kann zusätzlich JSON, CSV, RST, Jupyter |
| `WhoSowSee/mdv-previewer` | Alternative mit eigenem Renderer |
| `passion0102/mermaid` | Rendert Mermaid-Diagramme **inline** in der Markdown-Vorschau; komponiert glow-Text mit Diagramm-Bild |

> [!tip] Mermaid ist für Kursmaterial relevant
> Wenn deine Unterlagen Mermaid-Diagramme enthalten, ist `mermaid.yazi` der einzige Weg, die im Terminal tatsächlich zu sehen. Standardmäßig über mermaid.ink, mit Fallback auf mermaid-cli für den Offline-Betrieb — im Schulungsnetz vermutlich der relevante Pfad.

---

## 8. Weitere lohnende Plugins

```sh
# Offizielles Monorepo
ya pkg add yazi-rs/plugins:git            # Git-Status pro Datei
ya pkg add yazi-rs/plugins:full-border    # Vollständiger Rahmen
ya pkg add yazi-rs/plugins:smart-enter    # Enter = öffnen ODER betreten
ya pkg add yazi-rs/plugins:toggle-pane    # Vorschau maximieren
ya pkg add yazi-rs/plugins:jump-to-char   # Vim-artiges f<char>
ya pkg add yazi-rs/plugins:chmod
ya pkg add yazi-rs/plugins:mount          # Mount-Manager

# Community
ya pkg add Reledia/glow
ya pkg add ahkohd/eza-preview             # Verzeichnisse via eza
ya pkg add boydaihungst/mediainfo         # Medien-Metadaten
ya pkg add ndtoan96/ouch                  # Archive
ya pkg add Lil-Dank/lazygit
```

Aktivierung in `init.lua`:

```lua
-- ~/.config/yazi/init.lua
require("full-border"):setup()
require("git"):setup()
```

Und für die Fetcher-Plugins zusätzlich in `yazi.toml`:

```toml
[[plugin.prepend_fetchers]]
id  = "git"
url = "*"
run = "git"

[[plugin.prepend_fetchers]]
id  = "git"
url = "*/"
run = "git"
```

Tastenbelegung in `keymap.toml`:

```toml
[[mgr.prepend_keymap]]
on   = "T"
run  = "plugin toggle-pane max-preview"
desc = "Vorschau maximieren"

[[mgr.prepend_keymap]]
on   = ["c", "m"]
run  = "plugin chmod"
desc = "Chmod auf Auswahl"
```

> [!note] Versionsdisziplin
> Das offizielle Plugin-Repo verlangt ausdrücklich, dass Yazi **und** Plugins auf HEAD sind. Ein `ya pkg upgrade` nach einem Yazi-Update ist keine Kür.

---

## 9. Reproduzierbares Setup

Für die Schulungsflotte gehören ins Git-Repo:

```
~/.config/yazi/
├── yazi.toml
├── keymap.toml
├── init.lua
├── package.toml     ← der Lockfile
└── theme.toml
```

**Nicht** ins Repo: `plugins/` und `flavors/` — die stellt `ya pkg install` aus `package.toml` wieder her.

Provisioning auf dem Client:

```nu
git clone <repo> ~/.config/yazi
ya pkg install
```

> [!important] Reihenfolge beachten
> `ya pkg install` liest `package.toml`. Wenn du im Containerfile Plugins vorinstallierst, landen sie unter `/root/.config` statt beim Nutzer — für Fedora Atomic also entweder ins Skeleton legen oder beim ersten Login per systemd-user-unit nachziehen.

---

## 10. Fallstricke

> [!failure] Was regelmäßig schiefgeht
> - **`[manager]` statt `[mgr]`** — Config wird stillschweigend ignoriert
> - **Plugin installiert, aber nichts passiert** — `ya pkg add` aktiviert nicht, der Previewer-Eintrag in `yazi.toml` fehlt
> - **`def y` statt `def --env y`** — der Verzeichniswechsel verpufft
> - **Kein Nerd Font im Terminal** — Icons werden zu Kästchen
> - **Plugin modifiziert, dann `upgrade`** — bricht mit Hash-Fehler ab; Plugin manuell löschen und neu installieren
> - **GitLab-Plugin** — `ya pkg` kann das nicht, nur manuelles Klonen
> - **Flatpak-Yazi** — die Sandbox-Einschränkungen sind kein Randproblem

---

## Referenzen

- Offizielle Dokumentation: https://yazi-rs.github.io/docs/installation
- Plugin-Monorepo: https://github.com/yazi-rs/plugins
- Plugin-Sammlung: https://github.com/AnirudhG07/awesome-yazi
- Flavors (Themes): https://github.com/yazi-rs/flavors
- Default-Keymap: https://github.com/sxyazi/yazi/blob/shipped/yazi-config/preset/keymap-default.toml

## Verwandt

- [[Markdown-Viewer unter Fedora]]
- [[Fedora Sway Atomic — Schulungsflotte]]
- [[Nushell — Konfiguration]]
- [[Helix — Konfiguration]]
