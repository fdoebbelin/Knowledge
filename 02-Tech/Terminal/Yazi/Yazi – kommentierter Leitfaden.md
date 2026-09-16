---
title: Yazi – kommentierter Leitfaden
aliases:
  - Yazi
  - Yazi Dateimanager
tags:
  - yazi
  - terminal
  - dateimanager
  - nushell
  - helix
system: Fedora Sway Atomic
yazi_version: "26.9.1"
created: 2026-09-16
updated: 2026-09-16
---

# Yazi – kommentierter Leitfaden

Yazi ist ein schneller Dateimanager für das Terminal, geschrieben in Rust, mit Vim-artiger Bedienung, Bildvorschau und einem Plugin-System in Lua. Dieser Leitfaden fasst Bedienung und Konfiguration zusammen: versteckte Dateien, Shell, Helix als Editor, Dateioperationen, Theme-Anpassungen und ein Solarized-Light-Farbschema.

> [!info] Geltungsbereich
> - **System:** Fedora Sway Atomic, Yazi über Homebrew installiert, siehe [[Yazi – Installation und Plugins]]
> - **Version:** Alle Tastenbelegungen und Konfigurationsschlüssel sind mit der Standardkonfiguration von **Yazi 26.9.1** abgeglichen. Ältere Versionen weichen an einigen Stellen ab, siehe [[#Versionsunterschiede und Stolpersteine]].
> - **Befehle:** Nushell-Syntax
> - **Markdown-Vorschau:** eigene Notiz [[Yazi – Markdown-Vorschau]]

> [!tip] Hilfe in Yazi selbst
> Mit `~` oder `F1` zeigt Yazi jederzeit alle Tastenbelegungen der installierten Version an. Das ist die verlässlichste Referenz, wenn etwas nicht wie beschrieben funktioniert.

---

## 1. Konfigurationsdateien

Yazi liest seine Konfiguration aus `~/.config/yazi/`. Keine dieser Dateien ist Pflicht. Es genügt, nur die Werte einzutragen, die von der Standardkonfiguration abweichen sollen. Yazi ergänzt den Rest selbst.

| Datei          | Zweck                                                      |
| -------------- | ---------------------------------------------------------- |
| `yazi.toml`    | Verhalten: versteckte Dateien, Opener, Vorschau, Sortierung |
| `keymap.toml`  | Eigene Tastenbelegungen                                    |
| `theme.toml`   | Farben, Symbole, Trennzeichen, Auswahl des Flavors         |
| `init.lua`     | Initialisierung und Anpassung von Lua-Plugins              |
| `package.toml` | Von `ya pkg` verwaltete Plugins und Flavors, nicht von Hand bearbeiten |

Plugins und `ya pkg` sind in [[Yazi – Installation und Plugins#4. Das Plugin-System]] beschrieben.

Verzeichnis anlegen und installierte Version prüfen:

```nu
# Nushells mkdir legt fehlende Elternverzeichnisse automatisch mit an
mkdir ~/.config/yazi

# Version prüfen – wichtig, weil sich Tastenbelegungen und Schlüssel zwischen Versionen ändern
yazi --version
```

> [!tip] TOML-Dateien mit Nushell prüfen
> Nushell kann TOML nativ lesen. `open` wandelt die Datei in eine Tabelle um und meldet Syntaxfehler mit Zeilenangabe. So findest du Tippfehler, bevor Yazi sie stillschweigend ignoriert.
>
> ```nu
> open ~/.config/yazi/theme.toml
>
> # Gezielt einen Wert auslesen
> open ~/.config/yazi/yazi.toml | get mgr.show_hidden
> ```

> [!note]
> Änderungen an den Konfigurationsdateien wirken erst nach einem **Neustart von Yazi**.

---

## 2. Versteckte Dateien anzeigen

Dateien und Verzeichnisse, deren Name mit einem Punkt beginnt, blendet Yazi standardmäßig aus.

**Temporär:** Taste `.` schaltet die Anzeige für die laufende Sitzung ein und aus.

**Dauerhaft** in `~/.config/yazi/yazi.toml`:

```toml
[mgr]
show_hidden = true
```

> [!warning] Abschnittsname
> Vor Yazi 25.x hieß der Abschnitt `[manager]` statt `[mgr]`. Wird die Einstellung ignoriert, lohnt ein Blick auf `yazi --version`.

---

## 3. Eine Shell aus Yazi heraus starten

Es gibt drei Wege, je nachdem, ob Yazi offen bleiben soll und ob du nur einen einzelnen Befehl brauchst.

### 3.1 Yazi pausieren mit `Ctrl+z`

`Ctrl+z` hält Yazi an und bringt dich zurück in die Shell, aus der Yazi gestartet wurde. Yazi läuft im Hintergrund weiter und behält Verzeichnis, Tabs und Auswahl.

```nu
# Zurück zu Yazi (Job-Steuerung gibt es in Nushell ab Version 0.103)
job unfreeze

# Angehaltene Jobs auflisten, falls mehrere pausiert sind
job list
```

### 3.2 Einzelne Befehle mit `;` und `:`

- `;` fragt nach einem Shell-Befehl und führt ihn aus.
- `:` führt ihn aus und wartet, bis er fertig ist. Das ist sinnvoll für Befehle mit Ausgabe, die du lesen willst.

### 3.3 Eigene Taste für eine vollwertige Shell

In `~/.config/yazi/keymap.toml` legst du eine Taste an, die im aktuellen Verzeichnis eine Shell öffnet. Mit `exit` kehrst du zu Yazi zurück.

```toml
[[mgr.prepend_keymap]]
on   = "!"
for  = "unix"
run  = 'shell "$SHELL" --block'
desc = "Shell im aktuellen Verzeichnis öffnen"
```

> [!note] Welche Shell startet?
> `$SHELL` enthält die **Login-Shell** des Benutzers, nicht zwingend Nushell. Ist deine Login-Shell z. B. Bash und du willst trotzdem Nushell, trägst du sie direkt ein:
>
> ```toml
> run = 'shell "nu" --block'
> ```
>
> `prepend_keymap` stellt die eigene Belegung vor die Standardbelegungen, sie hat also Vorrang.

---

## 4. Helix als Standardeditor

Yazi öffnet Textdateien über den Opener `edit`, und der verwendet standardmäßig die Umgebungsvariable `$EDITOR`. Es gibt zwei Wege.

### 4.1 Systemweit über `$env.EDITOR` (empfohlen)

Dann nutzen auch Git, `crontab` und viele andere Programme Helix. In der Nushell-Konfiguration (`config nu` öffnet sie):

```nu
# Editor für externe Programme wie Yazi, Git usw.
$env.EDITOR = "hx"
$env.VISUAL = "hx"

# Nushells eigener Editor, z. B. für `config nu`
$env.config.buffer_editor = "hx"
```

Vorher prüfen, ob Helix gefunden wird:

```nu
which hx
```

> [!warning] Helix fehlt
> Helix heißt als Programm `hx`. Findet `which hx` nichts, ist Helix nicht installiert oder `~/.local/bin` bzw. der brew-Pfad fehlt im `$PATH`. Installation z. B. mit `brew install helix` oder ins Home-Verzeichnis, siehe [[00 Werkzeuge ins HOME-Verzeichnis installieren]].

### 4.2 Nur für Yazi über einen eigenen Opener

Soll ausschließlich Yazi Helix verwenden, überschreibst du den Opener in `~/.config/yazi/yazi.toml`:

```toml
[opener]
edit = [
  { run = "hx %s", block = true, for = "unix" },
]
```

- `%s` steht für die ausgewählten Dateien.
- `block = true` sorgt dafür, dass Yazi wartet, bis Helix beendet ist. Ohne diese Option würden sich beide Programme das Terminal teilen.

> [!warning] Platzhalter-Syntax
> Ab Yazi 26.x lautet der Platzhalter `%s`. Ältere Anleitungen verwenden `"$@"`, das ist die frühere Schreibweise.

---

## 5. Dateien und Verzeichnisse anlegen

Beides erledigt die Taste `a`. Yazi fragt nach einem Namen:

| Eingabe             | Ergebnis                                               |
| ------------------- | ------------------------------------------------------ |
| `notizen.md`        | Datei                                                  |
| `projekte/`         | Verzeichnis, erkennbar am abschließenden `/`           |
| `docs/2026/info.md` | Datei, fehlende Verzeichnisse werden mit angelegt      |
| `a/b/c/`            | Komplette Verzeichniskette                             |

Weitere Tasten in diesem Zusammenhang:

- `A` legt mehrere Dateien auf einmal an.
- `r` benennt um. Bei mehreren ausgewählten Dateien öffnet sich die Massenumbenennung im Editor, also in Helix.
- `d` verschiebt in den Papierkorb, `D` löscht endgültig.

> [!tip] Eingabefelder
> Das Eingabefeld beim Anlegen und Umbenennen verhält sich Vim-artig: `Esc` wechselt in den Normalmodus, ein zweites `Esc` bricht ab. `Ctrl+a` und `Ctrl+e` springen an Zeilenanfang und -ende, `Ctrl+w` löscht das Wort vor dem Cursor.

---

## 6. Dateien verschieben und kopieren

Verschieben funktioniert in Yazi wie Ausschneiden und Einfügen in einem grafischen Dateimanager.

1. Dateien auswählen:
   - `Space` markiert die Datei unter dem Cursor und springt weiter.
   - `v` startet den visuellen Modus, dann mit `j`/`k` einen Bereich markieren.
   - `Ctrl+a` wählt alles aus, `Ctrl+r` kehrt die Auswahl um.
2. `x` schneidet aus, `y` kopiert.
3. Ins Zielverzeichnis navigieren (`h` hoch, `l` hinein).
4. `p` fügt ein.

| Taste     | Wirkung                                                          |
| --------- | ---------------------------------------------------------------- |
| `p`       | Einfügen; bei Namenskonflikt wird ein Suffix angehängt           |
| `P`       | Einfügen und vorhandene Dateien überschreiben                    |
| `Y` / `X` | Vorgemerktes Kopieren/Ausschneiden abbrechen                     |
| `-` / `_` | Symlink mit absolutem / relativem Pfad statt einer Kopie anlegen |

### Tabs für weit entfernte Verzeichnisse

Liegen Quelle und Ziel weit auseinander, spart ein zweiter Tab viel Navigation: im einen Tab ausschneiden, im anderen einfügen.

| Taste       | Wirkung                              |
| ----------- | ------------------------------------ |
| `t t`       | Neuer Tab im aktuellen Verzeichnis   |
| `1` … `9`   | Zu Tab 1 bis 9 wechseln              |
| `[` / `]`   | Vorheriger / nächster Tab            |
| `Ctrl+c`    | Tab schließen                        |

> [!warning] Tab-Taste geändert
> Bis Yazi 25.x öffnete `t` allein einen neuen Tab. Ab 26.x ist es die Tastenfolge `t t`, weil `t r` zum Umbenennen eines Tabs hinzugekommen ist.

Längere Kopiervorgänge laufen im Hintergrund weiter. Mit `w` öffnest du die Aufgabenübersicht, dort bricht `x` eine Aufgabe ab.

---

## 7. Theme: abgerundete Trennzeichen entfernen

Die Halbkreise an Cursor-Indikator, Tabs und Statusleiste sind Nerd-Font-Symbole. Sie werden in `~/.config/yazi/theme.toml` festgelegt, **nicht** in der `yazi.toml`. Leere Strings entfernen sie.

```toml
# Cursor-Indikator in der Dateiliste
[indicator]
padding = { open = "", close = "" }

# Tabs oben: sep_inner direkt am Tab-Namen, sep_outer am Rand der Tab-Leiste
[tabs]
sep_inner = { open = "", close = "" }
sep_outer = { open = "", close = "" }

# Statusleiste unten, z. B. um die Modus-Anzeige NOR
[status]
sep_left  = { open = "", close = "" }
sep_right = { open = "", close = "" }
```

> [!info] Eckige Variante
> Laut Dokumentation erzeugt `padding = { open = "▐", close = "▌" }` einen eckigen statt eines runden Indikators.

---

## 8. Farbschema Solarized Light

### 8.1 Hintergrund: Flavors

Ein **Flavor** ist ein fertiges Theme-Paket. Er liegt als Verzeichnis mit der Endung `.yazi` in `~/.config/yazi/flavors/` und enthält mindestens:

- `flavor.toml` mit den Farben der Oberfläche
- `tmtheme.xml` mit den Farben der Syntaxhervorhebung in der Dateivorschau

Die eigene `theme.toml` wählt den Flavor aus und kann einzelne Werte daraus überschreiben.

> [!note] Kein offizieller Solarized-Light-Flavor
> Im Repository `yazi-rs/flavors` ist der Wunsch nach Solarized Dark und Light seit Januar 2024 offen. Der einzige gepflegte Community-Flavor, `peterfication/solarized.yazi`, gibt es nur als **Dark**-Variante. Die helle Variante `solarized-light.yazi` wurde deshalb daraus abgeleitet.

### 8.2 Wie die helle Variante entstanden ist

Solarized ist so entworfen, dass die helle Variante die Grundtöne der dunklen spiegelt. Die acht Akzentfarben bleiben gleich.

| Rolle in Dark   | Dark      | Light     | Rolle in Light  |
| --------------- | --------- | --------- | --------------- |
| base03          | `#002b36` | `#fdf6e3` | base3           |
| base02          | `#073642` | `#eee8d5` | base2           |
| base01          | `#586e75` | `#93a1a1` | base1           |
| base00          | `#657b83` | `#839496` | base0           |

Dieser Tausch wurde in `flavor.toml` und `tmtheme.xml` durchgeführt. Der Original-Flavor steht unter MIT-Lizenz, die Lizenzdateien liegen deshalb dem Paket bei.

### 8.3 Installation

```nu
# Zielverzeichnis für Flavors anlegen
mkdir ~/.config/yazi/flavors

# ZIP entpacken (unzip ist ein externes Programm, daher das ^)
# Das ZIP liegt im Vault unter _resources: [[solarized-light.yazi.zip]]
^unzip solarized-light.yazi.zip -d ~/.config/yazi/flavors/

# Prüfen, ob die Dateien am richtigen Ort liegen
ls ~/.config/yazi/flavors/solarized-light.yazi
```

Anschließend `~/.config/yazi/theme.toml`:

```toml
[flavor]
dark  = "solarized-light"
light = "solarized-light"

# Eigene Überschreibungen: Rundungen entfernen
[indicator]
padding = { open = "", close = "" }

[tabs]
sep_inner = { open = "", close = "" }
sep_outer = { open = "", close = "" }
```

Kommentar zu dieser Konfiguration:

- **`dark` und `light`:** Yazi erkennt am Terminal-Hintergrund, ob der dunkle oder helle Flavor gilt. Stehen beide auf `solarized-light`, wird die Erkennung umgangen und immer Solarized Light verwendet.
- **Überschreibungen:** Der Flavor bringt eigene abgerundete Trennzeichen mit. Werte in der eigenen `theme.toml` haben Vorrang, deshalb bleiben die Rundungen trotzdem ausgeblendet.

Prüfen, ob die Datei korrekt gelesen wird:

```nu
open ~/.config/yazi/theme.toml | get flavor
```

> [!warning] Terminal-Hintergrund
> Yazi färbt nur seine eigenen Elemente. Den Hintergrund liefert das Terminal. Stimmig wird das Ergebnis erst, wenn das Terminal selbst auf Solarized Light eingestellt ist.

> [!todo] Offen
> Das abgeleitete Farbschema wurde auf gültige Syntax geprüft, aber nicht live in Yazi begutachtet. Schlecht lesbare Elemente, z. B. die farbigen Zähler für kopierte oder ausgeschnittene Dateien, gegebenenfalls in der eigenen `theme.toml` nachfärben.

> [!info] Solarized Dark per Paketmanager
> Die dunkle Originalvariante lässt sich direkt mit dem Yazi-Paketmanager installieren:
>
> ```nu
> ya pkg add peterfication/solarized
> ```

---

## 9. Shell-Wrapper `y`: beim Beenden das Verzeichnis wechseln

Ein Programm kann das Arbeitsverzeichnis der aufrufenden Shell nicht ändern. Beendet man Yazi, steht man also wieder dort, wo man es gestartet hat. Der offizielle Wrapper löst das: Yazi schreibt das letzte Verzeichnis in eine temporäre Datei, und die Shell wechselt anschließend dorthin.

In die Nushell-Konfiguration (`config nu`):

```nu
# --env erlaubt der Funktion, das Verzeichnis der aufrufenden Shell zu ändern
def --env y [...args] {
  # Temporäre Datei für das letzte Verzeichnis
  let tmp = (mktemp -t "yazi-cwd.XXXXXX")

  # ^ erzwingt das externe Programm yazi
  ^yazi ...$args --cwd-file $tmp

  let cwd = (open $tmp)
  if $cwd != $env.PWD and ($cwd | path exists) {
    cd $cwd
  }

  # -f ohne Nachfrage, -p endgültig statt Papierkorb
  rm -fp $tmp
}
```

Bedienung:

- `y` startet Yazi.
- `q` beendet Yazi und wechselt in das zuletzt geöffnete Verzeichnis.
- `Q` beendet Yazi, ohne das Verzeichnis zu wechseln.

---

## 10. Vollständige Beispielkonfiguration

Alle Ergebnisse dieses Leitfadens zusammengeführt.

### `~/.config/yazi/yazi.toml`

```toml
[mgr]
show_hidden = true

[opener]
edit = [
  { run = "hx %s", block = true, for = "unix" },
]

[plugin]
prepend_previewers = [
  # Markdown: Obsidian-Syntax aufbereiten, dann glow mit Solarized-Stil
  # (~/.local/bin/ofm-preview, ~/.config/glow/solarized-light.json); $w = Breite der Vorschau
  { url = "*.md", run = 'piper -- CLICOLOR_FORCE=1 ofm-preview "$1" $w </dev/null' },
]
```

> [!note] Abschnitt `[plugin]`
> Setzt das Plugin `piper`, das Skript `ofm-preview` und den glow-Stil voraus. Einrichtung: [[Yazi – Markdown-Vorschau]]. Ohne diese Teile den Abschnitt weglassen.

### `~/.config/yazi/keymap.toml`

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
```

> [!note] Taste `M`
> Setzt das Skript `mermaid-view` und `mmdc` voraus, siehe [[Yazi – Mermaid-Diagramme]].

### `~/.config/yazi/theme.toml`

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

### Nushell-Konfiguration (`config nu`)

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

Alle drei TOML-Dateien in einem Rutsch auf Syntaxfehler prüfen:

```nu
ls ~/.config/yazi/*.toml | each {|f| {datei: ($f.name | path basename), ok: (try { open $f.name; true } catch { false })} }
```

---

## 11. Die wichtigsten Tasten im Überblick

> [!tip] Druckversion
> Zweiseitiger Spickzettel mit allen Tastenkürzeln, Tabs, Sortierung und Konfigurationsbeispielen: [[yazi-spickzettel.pdf]]

> [!example]- Tastenkürzel ausklappen
>
> | Bereich       | Taste             | Wirkung                                  |
> | ------------- | ----------------- | ---------------------------------------- |
> | Navigation    | `j` / `k`         | Nächste / vorherige Datei                |
> |               | `h` / `l`         | Ebene höher / hinein                     |
> |               | `H` / `L`         | Verlauf zurück / vor                     |
> |               | `gg` / `G`        | Anfang / Ende der Liste                  |
> |               | `K` / `J`         | Vorschau scrollen                        |
> | Springen      | `g h` / `g c`     | Home / `~/.config`                       |
> |               | `g Space`         | Pfad eintippen                           |
> |               | `z` / `Z`         | Per fzf / zoxide springen                |
> | Auswahl       | `Space`, `v`      | Markieren, visueller Modus               |
> | Öffnen        | `Enter` / `O`     | Öffnen / Öffnen mit …                    |
> | Dateien       | `a`, `A`, `r`     | Anlegen, mehrere anlegen, umbenennen     |
> |               | `y`, `x`, `p`     | Kopieren, ausschneiden, einfügen         |
> |               | `d` / `D`         | Papierkorb / endgültig löschen           |
> | Suchen        | `f`               | Liste filtern                            |
> |               | `s` / `S`         | Namen (fd) / Inhalte (ripgrep) suchen    |
> | Sortieren     | `, a` `, m` `, s` | Alphabetisch, Datum, Größe               |
> | Anzeige       | `.`               | Versteckte Dateien ein/aus               |
> |               | `m s` / `m p`     | Infospalte: Größe / Rechte               |
> | Zwischenablage| `c c` / `c f`     | Pfad / Dateiname kopieren                |
> | Shell         | `;` / `:`         | Befehl ausführen / und warten            |
> |               | `Ctrl+z`          | Pausieren, zurück mit `job unfreeze`     |
> | Tabs          | `t t`, `1`–`9`    | Neuer Tab, Tab wechseln                  |
> | Sonstiges     | `w`               | Aufgabenübersicht                        |
> |               | `~` / `F1`        | Hilfe                                    |
> |               | `q` / `Q`         | Beenden mit / ohne Verzeichniswechsel    |

Der ausführliche zweiseitige Spickzettel als PDF, sofern er im Vault liegt:

![[yazi-spickzettel.pdf]]

---

## Versionsunterschiede und Stolpersteine

| Thema                  | Yazi 26.x                   | Ältere Versionen          |
| ---------------------- | --------------------------- | ------------------------- |
| Neuer Tab              | `t t`                       | `t`                       |
| Platzhalter im Opener  | `%s`                        | `"$@"`                    |
| Hauptabschnitt         | `[mgr]`                     | `[manager]` (vor 25.x)    |
| Paketverwaltung        | `ya pkg add autor/repo`     | `ya pack -a autor/repo`   |

Weitere typische Fehlerquellen:

- **Einstellung in der falschen Datei:** Farben und Trennzeichen gehören in `theme.toml`, Verhalten in `yazi.toml`.
- **Symbole als Kästchen:** Die Standard-Trennzeichen und Dateisymbole brauchen eine Nerd Font im Terminal.
- **Helix startet nicht:** `which hx` prüfen, siehe Abschnitt 4.1.
- **`$SHELL` startet nicht Nushell:** Die Variable enthält die Login-Shell, im Keymap-Eintrag daher `nu` direkt angeben.
- **Suche oder Sprung ohne Wirkung:** `s`, `S`, `z` und `Z` benötigen die Programme `fd`, `ripgrep`, `fzf` bzw. `zoxide`. Installation mit `brew install fd ripgrep fzf zoxide`, vollständige Liste in [[Yazi – Installation und Plugins#3. Hilfsprogramme]].
- **Konfiguration ohne Wirkung:** Yazi liest die Dateien nur beim Start. Oft laufen mehrere Instanzen in verschiedenen Terminals, alle beenden.

```nu
# Prüfen, welche Hilfsprogramme vorhanden sind
[fd rg fzf zoxide hx] | each {|p| {programm: $p, gefunden: (which $p | is-not-empty)} }
```

## Quellen

- Yazi-Dokumentation: <https://yazi-rs.github.io/docs/>
- Standard-Tastenbelegung: <https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/keymap-default.toml>
- Flavor-Übersicht: <https://yazi-rs.github.io/docs/flavors/overview/>
- Solarized-Dark-Flavor (Basis der hellen Variante): <https://github.com/peterfication/solarized.yazi>
- Solarized von Ethan Schoonover: <https://ethanschoonover.com/solarized/>

## Verwandt

- [[Yazi – Installation und Plugins]] – Installation mit brew, Hilfsprogramme, Plugin-System, Übertragung auf andere Rechner
- [[Yazi – Markdown-Vorschau]] – glow mit Solarized-Stil und Obsidian-Aufbereitung
- [[Yazi – Mermaid-Diagramme]] – Diagramme auf Tastendruck lokal rendern
- [[00 config.nu]]
- [[Nushell Editor setzen]]
