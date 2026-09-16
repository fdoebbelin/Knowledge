---
title: Yazi – Mermaid-Diagramme
tags:
  - yazi
  - terminal
  - markdown
  - mermaid
  - nushell
system: Fedora Sway Atomic
yazi_version: "26.9.1"
created: 2026-09-16
---

# Yazi – Mermaid-Diagramme

> [!abstract] Worum es geht
> Mermaid-Blöcke in Markdown-Dateien erscheinen in der Vorschau nur als Code. Mit der Taste `M` rendert das Skript `mermaid-view` alle Diagramme der Datei unter dem Cursor **lokal** mit `mmdc` als PNG und öffnet sie in einem **neuen Tab**. Die Notiz bleibt im bisherigen Tab offen. Die Bilder werden dann mit Yazis normaler Bildvorschau angezeigt.

> [!info] Geltungsbereich
> Fedora Sway Atomic, Yazi 26.9.1, mermaid-cli 11.17.0 über Homebrew, Terminal `foot` (Sixel), Befehle in Nushell-Syntax. Setzt die [[Yazi – Markdown-Vorschau]] voraus.

---

## 1. Entscheidungen

> [!question]- Warum nicht das Plugin `mermaid.yazi`?
> `passion0102/mermaid.yazi` ist das einzige ernsthafte Mermaid-Plugin (Stand September 2026). Gegen den Einsatz sprachen:
> - **Übernimmt alle `.md`-Dateien:** Das Plugin ersetzt den Markdown-Previewer vollständig und ruft glow fest mit `--style dark` auf. Solarized-Stil und Obsidian-Aufbereitung aus [[Yazi – Markdown-Vorschau]] gingen verloren. Anpassen hieße, `main.lua` zu ändern, dann bricht `ya pkg upgrade` mit Hash-Fehler ab.
> - **Online-Dienst als Standard:** Ohne `mmdc` schickt es den Diagramm-Code jeder angesehenen Notiz an `mermaid.ink`.
> - **Terminal:** Die README nennt nur Kitty-Protokoll und iTerm2, foot (Sixel) ist nicht aufgeführt.
> - **Reife:** kleines Projekt mit wenigen Nutzern.

> [!question]- Warum lokal mit `mmdc` statt `mermaid.ink`?
> Kursunterlagen und private Notizen verlassen den Rechner nicht, und es funktioniert offline. Der Preis: Node.js und ein Headless-Chromium (zusammen rund 770 MB), erstes Rendern dauert etwa 3 Sekunden.

> [!question]- Warum auf Tastendruck statt automatisch?
> Die Vorschau bleibt schnell (0,1 s statt mehrerer Sekunden pro Datei mit Diagramm), und es wird nur gerendert, was man wirklich sehen will.

---

## 2. Aufbau

```
Vorschau (ofm-preview) ──► zeigt Hinweis „mermaid · Taste M …" über jedem Block

Taste M ──► mermaid-view <datei>
              ├─ ```mermaid-Blöcke extrahieren
              ├─ je Block: mmdc ──► ~/.cache/mermaid-view/<notiz>/01-<hash>.png
              ├─ ya emit tab_create ──► neuer Tab im Bild-Ordner
              └─ ya emit reveal     ──► Cursor auf das erste Bild
```

| Baustein                                  | Aufgabe                                             |
| ----------------------------------------- | --------------------------------------------------- |
| `mmdc` (brew `mermaid-cli`)               | Rendert Mermaid-Code zu PNG                         |
| `~/.cache/puppeteer/`                     | Headless-Chromium, den `mmdc` intern verwendet      |
| `~/.config/mermaid/solarized-light.json`  | Farbschema der Diagramme                            |
| `~/.local/bin/mermaid-view`               | Nushell-Skript: extrahieren, rendern, anzeigen      |
| `~/.config/yazi/keymap.toml`              | Taste `M`                                           |
| `~/.local/bin/ofm-preview`                | Hinweis in der Markdown-Vorschau                    |

---

## 3. Einrichtung

### 3.1 mermaid-cli und Chromium installieren

```nu
brew install mermaid-cli
```

brew bringt Node.js mit, aber **keinen Browser**. Ohne ihn bricht `mmdc` ab mit `Could not find chrome-headless-shell`. Die passende Version installiert das mitgelieferte Puppeteer selbst nach `~/.cache/puppeteer`:

```nu
^node (brew --prefix mermaid-cli | str trim | path join "libexec/lib/node_modules/@mermaid-js/mermaid-cli/node_modules/puppeteer/lib/puppeteer/node/cli.js") browsers install chrome-headless-shell
```

> [!important] Nach `brew upgrade mermaid-cli` wiederholen
> Jede mermaid-cli-Version erwartet eine bestimmte Chromium-Version. Der Befehl oben liest sie aus dem installierten Puppeteer. Ist sie schon vorhanden, lädt er nichts herunter. Alte Versionen unter `~/.cache/puppeteer/chrome-headless-shell/` können danach gelöscht werden.

Prüfen:

```nu
"flowchart LR\n  A --> B" | save -f /tmp/test.mmd
^mmdc -q -i /tmp/test.mmd -o /tmp/test.png
file /tmp/test.png
```

### 3.2 Farbschema für Diagramme

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

Kommentar:

- **`"theme": "base"`** ist das einzige Mermaid-Theme, dessen Farben sich vollständig über `themeVariables` setzen lassen.
- **Knoten** `#eee8d5` (base2) mit Rand `#93a1a1` (base1), **Text** `#073642` (base02), **Linien** `#657b83` (base00).
- **Notizen** in Sequenzdiagrammen gelblich mit Rand `#b58900`.

### 3.3 Skript `mermaid-view`

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

```nu
chmod +x ~/.local/bin/mermaid-view
```

Kommentar zu den Details:

- **Cache mit Hash:** Der Dateiname enthält die ersten 8 Zeichen des SHA-256 über den Diagramm-Code. Unveränderte Diagramme werden beim nächsten `M` nicht neu gerendert, geänderte bekommen einen neuen Namen, veraltete Bilder werden gelöscht.
- **Ein Verzeichnis pro Notiz:** `~/.cache/mermaid-view/<Dateiname ohne .md>/`. Zwei gleichnamige Notizen in verschiedenen Ordnern teilen sich das Verzeichnis. Das ist unschön, schadet aber nicht, weil die Bilder beim Wechsel neu gerendert werden.
- **`| complete`** fängt Exit-Code und Fehlerausgabe von `mmdc` ab, statt das Skript abzubrechen. Fehlerhafte Diagramme werden gemeldet, die übrigen trotzdem gerendert.
- **Fehlermeldung gekürzt:** `mmdc` hängt an jeden Syntaxfehler einen JavaScript-Stacktrace. Angezeigt werden nur die Zeilen davor.
- **`^ya emit tab_create` + `reveal`** schicken Yazi zwei Befehle: neuen Tab im Bild-Ordner öffnen, dann den Cursor auf das erste Bild setzen. `ya emit` erreicht die Yazi-Instanz, aus der das Skript gestartet wurde.
- **Nicht `tab_create <datei.png>`:** Mit einer Datei als Ziel behandelt Yazi 26.9.1 den Pfad als Verzeichnis, der Tab bleibt leer (getestet). Deshalb Ordner und Datei getrennt.
- **`-b "#fdf6e3"`** setzt den Bildhintergrund auf Solarized base3, **`-s 2`** rendert in doppelter Auflösung.

### 3.4 Taste `M` in Yazi

`~/.config/yazi/keymap.toml` ergänzen:

```toml
[[mgr.prepend_keymap]]
on   = "M"
for  = "unix"
run  = 'shell "mermaid-view %h" --block'
desc = "Mermaid-Diagramme der Datei rendern und anzeigen"
```

- **`%h`** ist die Datei unter dem Cursor. Yazi setzt sie korrekt maskiert ein, Leerzeichen und Gedankenstriche im Namen sind kein Problem (getestet).
- **`--block`** übergibt das Terminal an das Skript: Fortschritt und Fehlermeldungen sind sichtbar, Yazi wartet.
- **`M`** ist in der Standardbelegung von Yazi 26.9.1 frei.

### 3.5 Hinweis in der Markdown-Vorschau

In `~/.local/bin/ofm-preview` vor der glow-Zeile (bereits in [[Yazi – Markdown-Vorschau#3.3 Vorverarbeitungs-Skript anlegen]] enthalten):

```nu
	# Mermaid-Blöcke: Hinweis auf die Taste M (mermaid-view) voranstellen
	| str replace --all --regex '(?m)^```mermaid' "> **mermaid · Taste M zeigt das Diagramm als Bild**\n\n```mermaid"
```

Die Ersetzung steht in **doppelten** Anführungszeichen, damit Nushell `\n` als Zeilenumbruch auswertet.

Anschließend Yazi neu starten.

---

## 4. Bedienung

1. Cursor auf eine Markdown-Datei. Enthält sie Diagramme, zeigt die Vorschau `▎ mermaid · Taste M zeigt das Diagramm als Bild`.
2. `M` drücken. Beim ersten Mal erscheint `Rendere Diagramm 1 von 2 …`.
3. Ein neuer Tab öffnet sich in `~/.cache/mermaid-view/<notiz>/`, der Cursor steht auf `01-….png`, die Vorschau zeigt das Bild.
4. `j`/`k` wechselt zwischen den Diagrammen.
5. Zurück zur Notiz:

| Taste    | Wirkung                                                   |
| -------- | --------------------------------------------------------- |
| `Ctrl+c` | Diagramm-Tab schließen, zurück zur Notiz                  |
| `1` / `2` | Zwischen Notiz-Tab und Diagramm-Tab wechseln, beide bleiben offen |
| `[` / `]` | Vorheriger / nächster Tab                                |

Cursor und Verzeichnis im Notiz-Tab bleiben dabei unverändert (getestet).

> [!note] Jedes `M` öffnet einen weiteren Tab
> Wer `M` im Notiz-Tab erneut drückt, bekommt einen zusätzlichen Tab. Nicht mehr benötigte Diagramm-Tabs mit `Ctrl+c` schließen.

> [!tip] Größer ansehen
> - `Enter` öffnet das PNG mit dem Standardprogramm für `image/png`. Auf dem Referenzsystem ist das Google Chrome. Umstellen auf `imv` (liegt im Basisimage): `^xdg-mime default imv.desktop image/png`
> - `T` maximiert den Vorschaubereich (Plugin toggle-pane, siehe [[Yazi – Installation und Plugins#5.1 toggle-pane – Vorschau maximieren]]).

---

## 5. Fehlersuche

> [!failure] `Could not find chrome-headless-shell`
> Chromium fehlt oder passt nach einem Update nicht mehr zur mermaid-cli-Version. Befehl aus [[#3.1 mermaid-cli und Chromium installieren]] ausführen.

> [!failure] `UnknownDiagramError: No diagram type detected`
> Der Diagrammtyp existiert in Mermaid nicht. Typischer Fall: `usecaseDiagram` ist PlantUML-Syntax, Mermaid kennt keine Anwendungsfalldiagramme. Nachbau als Flowchart mit Systemgrenze als `subgraph`: siehe [[99 Beispiele]] unter UML-Basics.

> [!failure] `Parse error on line …`
> Syntaxfehler im Diagramm. Die Zeilenangabe bezieht sich auf den Mermaid-Block, nicht auf die Markdown-Datei.

> [!failure] Taste `M` ohne Wirkung
> Yazi nach Änderung an `keymap.toml` nicht neu gestartet, oder `mermaid-view` nicht ausführbar bzw. nicht im `$PATH`.

> [!failure] Kein neuer Tab
> Alle Diagramme sind fehlgeschlagen, dann gibt es nichts anzuzeigen. Die Fehlermeldungen stehen vor der Aufforderung „Taste drücken“.

> [!failure] Bild wird nicht angezeigt, nur Dateiinfo
> Das Terminal meldet kein Bildprotokoll. foot kann Sixel; in anderen Terminals prüfen, ob Sixel oder Kitty-Grafik unterstützt wird.

---

## 6. Grenzen

> [!caution]
> - Diagramme erscheinen nicht **in** der Textvorschau, sondern als separate Bilder.
> - Nur Code-Blöcke mit drei Backticks und `mermaid` werden erkannt, nicht `~~~mermaid`.
> - Nur Markdown-Dateien. Einzelne `.mmd`-Dateien lassen sich direkt mit `mmdc` rendern.
> - Der Cache unter `~/.cache/mermaid-view/` wird nie automatisch geleert. Aufräumen: `rm -r ~/.cache/mermaid-view`

---

## Referenzen

- mermaid-cli: <https://github.com/mermaid-js/mermaid-cli>
- Mermaid-Themes und `themeVariables`: <https://mermaid.js.org/config/theming.html>
- Puppeteer-Browser-Installation: <https://pptr.dev/guides/configuration>
- Verworfen: mermaid.yazi: <https://github.com/passion0102/mermaid.yazi>

## Verwandt

- [[Yazi – Markdown-Vorschau]] – glow mit Solarized-Stil und Obsidian-Aufbereitung
- [[Yazi – Installation und Plugins]] – Installation mit brew, Hilfsprogramme, Übertragung auf andere Rechner
- [[Yazi – kommentierter Leitfaden]] – Bedienung und Konfiguration
