---
title: Yazi – Markdown-Vorschau
tags:
  - yazi
  - terminal
  - markdown
  - obsidian
  - glow
  - nushell
system: Fedora Sway Atomic
yazi_version: "26.9.1"
created: 2026-09-16
---

# Yazi – Markdown-Vorschau

> [!abstract] Worum es geht
> Markdown-Dateien sollen im Vorschaubereich von Yazi gerendert erscheinen: farbige Überschriften im Solarized-Light-Stil, Tabellen als Spalten, Obsidian-Syntax lesbar aufbereitet. Diese Notiz ist die Schritt-für-Schritt-Anleitung, um das Setup auf einem weiteren Rechner nachzuziehen.

> [!info] Geltungsbereich
> Fedora Sway Atomic, Yazi 26.9.1 und glow 3.0.0 über Homebrew, Terminal `foot`, Befehle in Nushell-Syntax. Installation von Yazi: [[Yazi – Installation und Plugins]].

---

## 1. Aufbau

```
Yazi ──► piper.yazi ──► sh -c "ofm-preview <datei> <breite>"
                              │
                              ├─ Obsidian-Syntax umschreiben (Nushell)
                              └─ glow -s solarized-light.json  ──► farbige Ausgabe
```

| Baustein                                  | Aufgabe                                                        |
| ----------------------------------------- | -------------------------------------------------------------- |
| `piper.yazi`                              | Offizielles Plugin: Ausgabe eines Shell-Kommandos wird zur Vorschau |
| `~/.local/bin/ofm-preview`                | Nushell-Skript: bereitet Obsidian-Markdown auf, ruft glow auf  |
| `~/.config/glow/solarized-light.json`     | glow-Stil in Solarized-Light-Farben                            |
| `~/.config/yazi/yazi.toml`                | Verknüpft `*.md` mit dem Previewer                             |

> [!question]- Warum nicht das Plugin `glow.yazi`?
> `Reledia/glow` bricht Zeilen fest bei 55 Zeichen um. piper übergibt dagegen mit `$w` die tatsächliche Breite des Vorschaubereichs und erlaubt eine Vorverarbeitung vor glow. Die Upstream-README von piper nennt glow ausdrücklich als Beispiel.

---

## 2. Voraussetzungen

```nu
# glow (Markdown-Renderer)
brew install glow

# Nushell muss als `nu` im $PATH liegen (Referenzsystem: ~/.local/bin/nu)
which nu glow
```

---

## 3. Einrichtung

### 3.1 Plugin piper installieren

```nu
ya pkg add yazi-rs/plugins:piper
```

Liegt bereits eine `package.toml` mit piper vor (übertragenes Setup), genügt `ya pkg install`.

### 3.2 glow-Stil anlegen

Datei `~/.config/glow/solarized-light.json`:

```json
{
  "document": {
    "block_prefix": "\n",
    "block_suffix": "\n",
    "color": "#586e75",
    "margin": 1
  },
  "block_quote": {
    "color": "#657b83",
    "indent": 1,
    "indent_token": "▎ "
  },
  "paragraph": {},
  "list": {
    "level_indent": 2
  },
  "heading": {
    "block_suffix": "\n",
    "bold": true
  },
  "h1": {
    "prefix": " ",
    "suffix": " ",
    "color": "#fdf6e3",
    "background_color": "#268bd2",
    "bold": true
  },
  "h2": {
    "prefix": "▌ ",
    "color": "#cb4b16"
  },
  "h3": {
    "prefix": "◆ ",
    "color": "#b58900"
  },
  "h4": {
    "prefix": "◇ ",
    "color": "#2aa198"
  },
  "h5": {
    "prefix": "· ",
    "color": "#2aa198"
  },
  "h6": {
    "prefix": "· ",
    "color": "#93a1a1",
    "bold": false
  },
  "text": {},
  "strikethrough": {
    "crossed_out": true
  },
  "emph": {
    "italic": true
  },
  "strong": {
    "bold": true,
    "color": "#073642"
  },
  "hr": {
    "color": "#93a1a1",
    "format": "\n────────────────────\n"
  },
  "item": {
    "block_prefix": "• "
  },
  "enumeration": {
    "block_prefix": ". "
  },
  "task": {
    "ticked": "[✓] ",
    "unticked": "[ ] "
  },
  "link": {
    "color": "#268bd2",
    "underline": true
  },
  "link_text": {
    "color": "#268bd2",
    "bold": true
  },
  "image": {
    "color": "#d33682",
    "underline": true
  },
  "image_text": {
    "color": "#93a1a1",
    "format": "Bild: {{.text}} →"
  },
  "code": {
    "prefix": " ",
    "suffix": " ",
    "color": "#d33682",
    "background_color": "#eee8d5"
  },
  "code_block": {
    "color": "#586e75",
    "margin": 2,
    "theme": "solarized-light"
  },
  "table": {
    "color": "#586e75"
  },
  "definition_list": {},
  "definition_term": {},
  "definition_description": {
    "block_prefix": "\n🠶 "
  },
  "html_block": {},
  "html_span": {}
}
```

Kommentar:

- **Basis** ist der mitgelieferte glow-Stil `light` (glamour `styles/light.json`), mit Solarized-Farben ersetzt.
- **Überschriften** sind an Farbe und Symbol unterscheidbar: H1 blau hinterlegt, H2 orange `▌`, H3 gelb `◆`, H4 türkis `◇`.
- **Codeblöcke** nutzen das eingebaute Chroma-Theme `solarized-light` für die Syntaxhervorhebung.
- **Eigener Stil ersetzt vollständig:** Eine JSON-Datei erbt nichts von `light`. Fehlt ein Element, wird es ungestylt ausgegeben.

> [!tip] Farbwerte Solarized Light
> Text `#586e75` (base01) · Zitate `#657b83` (base00) · Hervorhebung `#073642` (base02) · Hintergrund Code `#eee8d5` (base2) · Akzente: blau `#268bd2`, orange `#cb4b16`, gelb `#b58900`, türkis `#2aa198`, magenta `#d33682`

### 3.3 Vorverarbeitungs-Skript anlegen

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

Ausführbar machen:

```nu
chmod +x ~/.local/bin/ofm-preview
```

Was das Skript umschreibt:

| Obsidian                  | Vorschau                  |
| ------------------------- | ------------------------- |
| `[[Notiz]]`               | *Notiz*                   |
| `[[Notiz\|Alias]]`        | *Alias*                   |
| `[[Notiz#Abschnitt]]`     | *Notiz › Abschnitt*       |
| `[[#Abschnitt]]`          | *Abschnitt*               |
| `![[bild.png]]`           | 📎 *bild.png*             |
| `> [!info]- Titel`        | ▎ **info · Titel**        |
| `==markiert==`            | **markiert**              |
| `%%Kommentar%%`           | *(entfällt)*              |
| ` ```mermaid `            | Hinweis **mermaid · Taste M zeigt das Diagramm als Bild** vor dem Block |

Kommentar zu den Details:

- **`${1}` statt `$1`:** In der Regex-Ersetzung würde `$1*` als Gruppenname `1*` gelesen. Die geschweiften Klammern trennen die Gruppennummer eindeutig ab.
- **Reihenfolge:** Einbettungen vor Wikilinks, Links mit Alias vor Links ohne. Sonst greift das allgemeinere Muster zuerst.
- **`(?m)` / `(?s)`:** `(?m)` lässt `^` und `$` auf jede Zeile wirken, `(?s)` lässt `.` auch Zeilenumbrüche erfassen (mehrzeilige Kommentare).
- **`^glow … -`:** Der Bindestrich liest aus der Pipeline. Frontmatter blendet glow auch dann aus.

### 3.4 Previewer in Yazi eintragen

`~/.config/yazi/yazi.toml` ergänzen:

```toml
[plugin]
prepend_previewers = [
  # Markdown: Obsidian-Syntax aufbereiten, dann glow mit Solarized-Stil
  # (~/.local/bin/ofm-preview, ~/.config/glow/solarized-light.json); $w = Breite der Vorschau
  { url = "*.md", run = 'piper -- CLICOLOR_FORCE=1 ofm-preview "$1" $w </dev/null' },
]
```

| Teil               | Bedeutung                                                                 |
| ------------------ | ------------------------------------------------------------------------- |
| `prepend_previewers` | Vor die eingebauten Previewer stellen, sonst greift der Text-Previewer `text/*` zuerst |
| `url = "*.md"`     | Gilt für alle Markdown-Dateien                                            |
| `piper --`         | Alles nach `--` läuft als `sh -c` (POSIX-Shell, nicht Nushell)            |
| `CLICOLOR_FORCE=1` | glow erkennt kein Terminal und würde sonst ohne Farben ausgeben           |
| `"$1"`, `$w`       | Dateipfad und Breite des Vorschaubereichs, von piper gesetzt              |
| `</dev/null`       | Schließt die Standardeingabe, siehe [[#5. Fehlersuche]]                   |

> [!note]
> Die Zeile steht in POSIX-Shell-Syntax, weil piper `sh` aufruft. Das Skript selbst ist Nushell.

Anschließend **alle** Yazi-Instanzen beenden und Yazi neu starten.

---

## 4. Prüfen

### 4.1 Ohne Yazi

```nu
# Farbige Ausgabe bei 60 Zeichen Breite
CLICOLOR_FORCE=1 ofm-preview "Yazi – kommentierter Leitfaden.md" 60

# Konfiguration syntaktisch prüfen
open ~/.config/yazi/yazi.toml | get plugin
open ~/.config/glow/solarized-light.json | columns | length
ya pkg list
```

### 4.2 In Yazi

Cursor auf eine `.md`-Datei setzen, mit `J`/`K` durch die Vorschau blättern. Die Vorschau ist aktiv, wenn:

- **kein Frontmatter** (`---`, `title:`, `tags:`) oben steht,
- Absätze auf die Breite des Vorschaubereichs **umgebrochen** statt abgeschnitten werden,
- Überschriften **farbig mit Symbol** (`▌`, `◆`) statt mit `##` erscheinen,
- Callouts als `▎ info · Titel` dargestellt werden.

> [!tip] Vorschau maximieren
> Bei schmalem Vorschaubereich lohnt das Plugin `toggle-pane` (Kandidat in [[Yazi – Installation und Plugins#5. Eingerichtete Plugins]]).

---

## 5. Fehlersuche

> [!failure] Vorschau zeigt rohes Markdown mit Frontmatter
> - Yazi wurde nach der Änderung nicht neu gestartet. Oft laufen mehrere Instanzen, z. B. in verschiedenen Terminals: `ps | where name == yazi`
> - `ya pkg list` zeigt kein `piper`
> - Tippfehler in `yazi.toml`: `open ~/.config/yazi/yazi.toml` meldet Syntaxfehler mit Zeile

> [!failure] Vorschau bleibt leer oder hängt
> Ohne `</dev/null` wartet glow unter Umständen auf die Standardeingabe statt die Datei zu lesen. Beim Test außerhalb von Yazi ist genau das aufgetreten. Die Umleitung ist eine billige Absicherung.

> [!failure] Fehlermeldung `sh: ofm-preview: not found`
> `~/.local/bin` fehlt im `$PATH` der Shell, aus der Yazi gestartet wurde, oder das Skript ist nicht ausführbar (`chmod +x`). Gleiches gilt für `nu` in der Shebang-Zeile.

> [!failure] Vorschau ohne Farben
> `CLICOLOR_FORCE=1` fehlt im `run`-Eintrag.

> [!failure] Fehlermeldung `specified style does not exist`
> Die Datei `~/.config/glow/solarized-light.json` fehlt oder der Pfad im Skript stimmt nicht.

> [!failure] Gerendert, aber farblich unauffällig
> Es läuft noch ein eingebauter Stil (`-s light` / `auto`), z. B. weil `yazi.toml` noch glow direkt statt `ofm-preview` aufruft.

---

## 6. Grenzen

> [!caution] Kein Obsidian-Renderer
> - Callout-Typen erscheinen kleingeschrieben und ohne Symbol, Einklappen (`-`/`+`) wird ignoriert.
> - Wikilinks sind nur Text, nicht anklickbar.
> - Eingebettete Bilder und Notizen werden nicht angezeigt, nur ihr Name.
> - Mermaid-Diagramme bleiben in der Vorschau Code. Taste `M` zeigt sie als Bild, siehe [[Yazi – Mermaid-Diagramme]].
> - Mathe (`$…$`), Dataview und Tags werden nicht aufbereitet.
>
> Für „was steht drin" reicht das. Für „sieht das im Vault richtig aus" bleibt Obsidian.

---

## Referenzen

- piper.yazi: <https://github.com/yazi-rs/plugins/tree/main/piper.yazi>
- glow: <https://github.com/charmbracelet/glow>
- glamour-Stile (Vorlage `light.json`): <https://github.com/charmbracelet/glamour/tree/master/styles>
- Solarized-Farbwerte: <https://ethanschoonover.com/solarized/>

## Verwandt

- [[Yazi – Installation und Plugins]] – Installation mit brew, Plugin-System, Übertragung auf andere Rechner
- [[Yazi – Mermaid-Diagramme]] – Diagramme auf Tastendruck lokal rendern
- [[Yazi – kommentierter Leitfaden]] – Bedienung, Konfiguration, Flavor Solarized Light
