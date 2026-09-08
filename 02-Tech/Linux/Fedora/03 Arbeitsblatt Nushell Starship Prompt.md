---
title: "Arbeitsblatt: Zweizeiliger Starship-Prompt unter Nushell"
tags:
  - schulung
  - linux
  - shell
  - nushell
  - starship
  - arbeitsblatt
zielgruppe: FISI/FIAE
dauer: 90 min
voraussetzungen:
  - Grundlagen Kommandozeile
  - Umgang mit TOML
erstellt: 2026-09-08
---
## Lernziele

Nach der Bearbeitung dieses Arbeitsblattes können Sie

- Starship in Nushell über den Vendor-Autoload-Mechanismus einbinden,
- den Aufbau der `starship.toml` und die Format-Syntax erklären,
- einen zweizeiligen Prompt mit abgerundeter Rahmenverbindung konfigurieren,
- einzelne Module gezielt aktivieren, deaktivieren und umgestalten,
- Fehler im Prompt systematisch eingrenzen.

---

## 1 Starship installieren und Voraussetzungen prüfen

### 1.1 Installation nach `~/.local/bin`

> [!info] Warum ins Home und nicht nach `/usr/local/bin`
> Auf einem unveränderlichen System (Fedora Atomic, bootc) ist `/usr/local` zwar beschreibbar, weil es ein Symlink auf `/var/usrlocal` ist und damit Updates übersteht. Toolbx- und Distrobox-Container bringen aber ihr eigenes `/usr/local` mit und sehen das Binary dort nicht. Das Home-Verzeichnis wird dagegen zwischen Host und Containern geteilt. Eine Installation nach `~/.local/bin` steht deshalb überall zur Verfügung — bei einer Neuinstallation des Systems allerdings nur, wenn das Home erhalten bleibt.

Beide Kommandos laufen unverändert in Nushell:

```nu
mkdir ~/.local/bin
curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin
```

| Bestandteil | Bedeutung |
|---|---|
| `mkdir ~/.local/bin` | Nushells eigenes `mkdir` legt fehlende Elternverzeichnisse immer mit an, ein `-p` gibt es hier nicht und wäre ein Fehler |
| `curl -sS` | still arbeiten, Fehlermeldungen aber ausgeben |
| `\| sh -s` | die Ausgabe von `curl` wird an `sh` weitergereicht, `-s` weist `sh` an, das Skript von der Standardeingabe zu lesen |
| `--` | trennt die Optionen von `sh` von denen des Installationsskripts |
| `-b ~/.local/bin` | Zielverzeichnis des Skripts; Nushell expandiert die Tilde im Argument selbst |

> [!note] Nicht-interaktive Ausführung
> Das Skript fragt vor dem Schreiben nach einer Bestätigung. Da es selbst über die Standardeingabe hereinkommt, lässt sich diese Rückfrage in Skripten und Image-Builds nicht beantworten. Dort hängen Sie `-y` an:
>
> ```nu
> curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin
> ```

Eine bereits vorhandene systemweite Installation entfernen Sie vorher:

```nu
which starship
sudo rm /usr/local/bin/starship
```

> [!tip] Kein `hash -r` nötig
> In Bash müssten Sie nach dem Verschieben eines Binaries den Kommando-Cache mit `hash -r` leeren. Nushell führt keinen solchen Cache, `which starship` zeigt sofort den neuen Pfad.

### 1.2 `~/.local/bin` in den PATH von Nushell aufnehmen

> [!warning] Nushell liest kein `/etc/profile`
> Die Fedora-Automatik, die `~/.local/bin` an den PATH hängt, liegt in `/etc/profile.d/` und wird nur von POSIX-Shells ausgewertet. Nushell erbt den PATH ausschließlich von dem Prozess, der es gestartet hat. Je nachdem, wie Ihre Sitzung startet, fehlt der Eintrag also.

Prüfen:

```nu
$env.PATH | where ($it | str contains ".local/bin")
```

Liefert das nichts, ergänzen Sie den Pfad dauerhaft in der `env.nu`:

```nu
# env.nu
use std/util "path add"
path add ($nu.home-path | path join ".local" "bin")
```

Ohne Standardbibliothek geht es auch direkt über die Liste:

```nu
# env.nu
$env.PATH = ($env.PATH | prepend ($nu.home-path | path join ".local" "bin") | uniq)
```

- [ ] Starship nach `~/.local/bin` installiert
- [ ] alte Installation unter `/usr/local/bin` entfernt, falls vorhanden
- [ ] `~/.local/bin` liegt im PATH von Nushell

### 1.3 Versionen prüfen

Nushell muss mindestens in Version 0.96 vorliegen, weil erst ab dieser Version die Anbindung in der hier gezeigten Form unterstützt wird.

```nu
starship --version
version
$nu.config-path
$nu.data-dir
```

- [ ] `starship --version` liefert eine Versionsnummer
- [ ] Nushell-Version ist ≥ 0.96
- [ ] Pfad der `config.nu` notiert: ________________________

### 1.4 Schriftart

> [!warning] Nerd Font
> Ein großer Teil der Starship-Symbole (Ordner-, Git- und Sprachsymbole) stammt aus dem Private-Use-Bereich von Unicode und wird nur mit einer gepatchten **Nerd Font** dargestellt. Ohne Nerd Font erscheinen leere Kästchen. Auf einem Atomic-System installieren Sie die Schrift benutzerbezogen:
>
> ```nu
> mkdir ~/.local/share/fonts
> # Schriftdateien dorthin entpacken, anschließend:
> fc-cache -f
> ```
>
> Danach im Terminal-Emulator die Nerd-Font-Variante als Schriftart auswählen.

---

## 2 Starship in Nushell einbinden

Nushell lädt beim Start automatisch alle `.nu`-Dateien aus den Vendor-Autoload-Verzeichnissen. Genau dorthin schreiben wir den generierten Initialisierungscode. Der Vorteil gegenüber einem `source`-Eintrag: die Datei wird geladen, **bevor** Ihre `config.nu` ausgewertet wird, Sie können also anschließend gezielt überschreiben.

Einmalig ausführen:

```nu
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
```

Kontrolle:

```nu
$nu.vendor-autoload-dirs
open ($nu.data-dir | path join "vendor/autoload/starship.nu") | lines | first 20
```

> [!tip] Aktualisieren nach einem Starship-Update
> Die generierte Datei ist versionsgebunden. Nach jedem Starship-Update denselben `starship init nu`-Aufruf wiederholen. Legen Sie sich dafür einen Alias an:
>
> ```nu
> # config.nu
> def starship-refresh [] {
>     starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
>     print "starship.nu neu erzeugt – neue Shell starten"
> }
> ```

Neue Shell öffnen. Es erscheint der Standard-Prompt von Starship.

---

## 3 Wie Nushell den Prompt zusammensetzt

Anders als Bash oder Zsh baut Nushell den Prompt aus mehreren getrennten Umgebungsvariablen auf. Das Init-Skript von Starship belegt sie für Sie:

| Variable | Bedeutung |
|---|---|
| `PROMPT_COMMAND` | Closure, die den linken Prompt liefert (hier: `starship prompt`) |
| `PROMPT_COMMAND_RIGHT` | Closure für den rechtsbündigen Prompt (`right_format`) |
| `PROMPT_INDICATOR` | Zeichen direkt vor der Eingabe; wird von Starship auf leer gesetzt, weil das `character`-Modul diese Aufgabe übernimmt |
| `PROMPT_INDICATOR_VI_INSERT` / `_VI_NORMAL` | dasselbe für den Vi-Modus |
| `PROMPT_MULTILINE_INDICATOR` | Kennzeichnung von Fortsetzungszeilen bei unvollständiger Eingabe |

Prüfen lässt sich der aktuelle Zustand jederzeit mit:

```nu
$env.PROMPT_INDICATOR
$env.PROMPT_MULTILINE_INDICATOR
```

Zwei Nushell-Einstellungen sind für einen zweizeiligen Prompt relevant:

```nu
# config.nu
$env.config.render_right_prompt_on_last_line = false
$env.PROMPT_MULTILINE_INDICATOR = "│  "
```

- `render_right_prompt_on_last_line = false` (Voreinstellung) setzt den rechten Prompt an das Ende der **ersten** Zeile. Das passt zu unserem Rahmen. Auf `true` wandert er in die Eingabezeile.
- Der Multiline-Indikator `│` setzt den Rahmen optisch fort, wenn eine Eingabe über mehrere Zeilen geht.

> [!note] Reihenfolge beachten
> Diese Zuweisungen müssen in der `config.nu` stehen, also nach dem Vendor-Autoload. Prüfen Sie nach dem Neustart der Shell mit `$env.PROMPT_MULTILINE_INDICATOR`, ob Ihr Wert tatsächlich gewonnen hat.

---

## 4 Die Format-Syntax verstehen

Die zentrale Einstellung ist `format`. Sie ist eine einzige Zeichenkette, in die Module als `$modulname` eingesetzt werden.

Drei Bausteine:

1. **Modulplatzhalter** – `$directory`, `$git_branch`, `$character` …
2. **Textblöcke mit Stil** – `[Text](stilangabe)`, zum Beispiel `[╭─](bold green)`
3. **Zeilenumbruch** – das Modul `$line_break`

> [!warning] Anführungszeichen richtig wählen
> In TOML unterscheiden sich die beiden Formen mehrzeiliger Zeichenketten:
>
> - `'''…'''` ist eine **literale** Zeichenkette. Escape-Sequenzen werden nicht ausgewertet, ein `\` am Zeilenende erzeugt einen echten Backslash.
> - `"""…"""` ist eine **basic**-Zeichenkette. Hier wirkt ein `\` am Zeilenende als Fortsetzungszeichen: Zeilenumbruch und Einrückung werden entfernt.
>
> Für ein gut lesbares, untereinander geschriebenes `format` brauchen Sie deshalb `"""` mit `\` am Zeilenende. Andernfalls landen unerwünschte Umbrüche im Prompt.

Der Platzhalter `$all` steht für sämtliche Module in der Standardreihenfolge. `$all` ohne bestimmte Module schreibt man als Differenz, etwa `${all}` minus explizit vorgezogene Einträge — praktischer ist die ausdrückliche Aufzählung, weil die Reihenfolge dann dokumentiert im Konfigurationsfile steht.

---

## 5 Grundgerüst: zwei Zeilen mit abgerundeter Verbindung

Die Verbindung der beiden Zeilen besteht aus zwei Zeichen des Unicode-Blocks *Box Drawing*:

| Variante | Öffnend | Schließend | Codepoints |
|---|---|---|---|
| abgerundet | `╭─` | `╰─` | U+256D, U+2570, U+2500 |
| eckig | `┌─` | `└─` | U+250C, U+2514, U+2500 |
| doppelt | `╔═` | `╚═` | U+2554, U+255A, U+2550 |
| ASCII-Rückfall | `.-` | `'-` | reine ASCII-Zeichen |

Minimalbeispiel zum Ausprobieren:

```toml
# ~/.config/starship.toml
format = """
[╭─](bold green)$directory$git_branch
[╰─](bold green)$character"""
```

Beachten Sie: Der Zeilenumbruch innerhalb der `"""`-Zeichenkette ist hier bewusst **nicht** mit `\` maskiert, er erzeugt den Umbruch zwischen den beiden Prompt-Zeilen. Alternativ und expliziter schreibt man dafür `$line_break`.

- [ ] Minimalbeispiel eingetragen, neue Shell geöffnet, zwei Zeilen sichtbar

---

## 6 Vollständige Konfiguration

Die folgende Datei ist die Arbeitsgrundlage für den Rest des Arbeitsblattes. Speichern Sie sie unter `~/.config/starship.toml`.

```toml
# ~/.config/starship.toml
"$schema" = 'https://starship.rs/config-schema.json'

# ── Globale Einstellungen ────────────────────────────────────────────
add_newline = true       # Leerzeile vor jedem Prompt
command_timeout = 1000   # ms, großzügig für langsame Git-Repos
scan_timeout = 30        # ms für das Scannen des Arbeitsverzeichnisses
palette = 'werkstatt'

# ── Farbpalette ──────────────────────────────────────────────────────
# Farben werden einmal benannt und überall über den Namen verwendet.
[palettes.werkstatt]
rahmen  = '#7aa2f7'
ok      = '#9ece6a'
warnung = '#e0af68'
fehler  = '#f7768e'
info    = '#7dcfff'
gedeckt = '#565f89'

# ── Layout ───────────────────────────────────────────────────────────
format = """
[╭─](rahmen)\
$os\
$username\
$hostname\
$localip\
$shlvl\
$container\
$directory\
$git_branch\
$git_commit\
$git_state\
$git_status\
$git_metrics\
$package\
$c\
$golang\
$java\
$kotlin\
$lua\
$nodejs\
$php\
$python\
$ruby\
$rust\
$zig\
$conda\
$nix_shell\
$docker_context\
$kubernetes\
$aws\
$azure\
$gcloud\
$terraform\
$direnv\
$memory_usage\
$line_break\
[╰─](rahmen)\
$sudo\
$jobs\
$status\
$character"""

right_format = """$cmd_duration$battery$time"""

# ── Erste Zeile: System und Kontext ──────────────────────────────────
[os]
disabled = false
format = '[$symbol]($style) '
style = 'fg:rahmen'

[username]
show_always = true
format = '[$user]($style)'
style_user = 'fg:info'
style_root = 'bold fg:fehler'

[hostname]
ssh_only = false
format = '[@$hostname]($style) '
style = 'fg:gedeckt'

[localip]
disabled = true          # bei Bedarf auf false setzen
ssh_only = true
format = '[$localipv4]($style) '
style = 'fg:gedeckt'

[shlvl]
disabled = false
threshold = 2            # erst ab verschachtelter Shell anzeigen
symbol = '↕ '
format = '[$symbol$shlvl]($style) '
style = 'fg:warnung'

[container]
format = '[⬢ $name]($style) '
style = 'fg:warnung'

[directory]
truncation_length = 3
truncate_to_repo = true
truncation_symbol = '…/'
home_symbol = '~'
read_only = ' '
format = '[$path]($style)[$read_only]($read_only_style) '
style = 'bold fg:info'

[directory.substitutions]
'Dokumente' = ' '
'Schreibtisch' = ' '
'Downloads' = ' '

# ── Erste Zeile: Versionskontrolle ───────────────────────────────────
[git_branch]
symbol = ' '
format = '[$symbol$branch]($style) '
style = 'fg:ok'

[git_commit]
commit_hash_length = 7
tag_disabled = false
format = '[($hash$tag)]($style) '
style = 'fg:gedeckt'

[git_state]
format = '[\($state( $progress_current/$progress_total)\)]($style) '
style = 'fg:warnung'

[git_status]
conflicted = '='
ahead = '⇡${count}'
behind = '⇣${count}'
diverged = '⇕⇡${ahead_count}⇣${behind_count}'
untracked = '?${count}'
stashed = '\$${count}'
modified = '!${count}'
staged = '+${count}'
renamed = '»${count}'
deleted = '✘${count}'
format = '([$all_status$ahead_behind]($style) )'
style = 'fg:warnung'

[git_metrics]
disabled = false
added_style = 'fg:ok'
deleted_style = 'fg:fehler'
format = '([+$added]($added_style) )([-$deleted]($deleted_style) )'

# ── Erste Zeile: Sprachen und Werkzeuge ──────────────────────────────
# Alle Sprachmodule sind kontextabhängig: sie erscheinen nur, wenn im
# Verzeichnis passende Dateien liegen.

[package]
symbol = '󰏗 '
format = '[$symbol$version]($style) '
style = 'fg:gedeckt'

[python]
symbol = ' '
python_binary = ['python3', 'python']
format = '[$symbol$version( \($virtualenv\))]($style) '
style = 'fg:warnung'

[rust]
symbol = ' '
format = '[$symbol$version]($style) '
style = 'fg:fehler'

[nodejs]
symbol = ' '
format = '[$symbol$version]($style) '
style = 'fg:ok'

[golang]
symbol = ' '
format = '[$symbol$version]($style) '
style = 'fg:info'

[java]
symbol = ' '
format = '[$symbol$version]($style) '
style = 'fg:fehler'

[c]
symbol = ' '
format = '[$symbol$version]($style) '
style = 'fg:info'

[lua]
symbol = ' '
format = '[$symbol$version]($style) '
style = 'fg:info'

[php]
symbol = ' '
format = '[$symbol$version]($style) '
style = 'fg:gedeckt'

[ruby]
symbol = ' '
format = '[$symbol$version]($style) '
style = 'fg:fehler'

[kotlin]
format = '[$symbol$version]($style) '
style = 'fg:warnung'

[zig]
format = '[$symbol$version]($style) '
style = 'fg:warnung'

[conda]
symbol = ' '
format = '[$symbol$environment]($style) '
style = 'fg:ok'

[nix_shell]
symbol = ' '
format = '[$symbol$state( \($name\))]($style) '
style = 'fg:info'

[docker_context]
symbol = ' '
only_with_files = true
format = '[$symbol$context]($style) '
style = 'fg:info'

[kubernetes]
disabled = false
symbol = '☸ '
detect_files = ['k8s', 'kustomization.yaml']
format = '[$symbol$context( \($namespace\))]($style) '
style = 'fg:info'

[aws]
symbol = ' '
format = '[$symbol($profile )(\($region\) )]($style)'
style = 'fg:warnung'

[azure]
disabled = true
format = '[$symbol($subscription)]($style) '

[gcloud]
disabled = true
format = '[$symbol$account(@$domain)(\($region\))]($style) '

[terraform]
symbol = '󱁢 '
format = '[$symbol$workspace]($style) '
style = 'fg:warnung'

[direnv]
disabled = false
symbol = '󱚟 '
format = '[$symbol$loaded/$allowed]($style) '
style = 'fg:gedeckt'

[memory_usage]
disabled = true          # auf false setzen für Speicheranzeige
threshold = 80
symbol = '󰍛 '
format = '[$symbol$ram_pct]($style) '
style = 'fg:fehler'

# ── Rechter Prompt ───────────────────────────────────────────────────
[cmd_duration]
min_time = 2000
show_milliseconds = false
format = '[took $duration]($style) '
style = 'fg:gedeckt'

[battery]
disabled = false
format = '[$symbol$percentage]($style) '
[[battery.display]]
threshold = 20
style = 'bold fg:fehler'
[[battery.display]]
threshold = 50
style = 'fg:warnung'

[time]
disabled = false
time_format = '%H:%M'
format = '[$time]($style)'
style = 'fg:gedeckt'

# ── Zweite Zeile: Statuszeile ────────────────────────────────────────
[sudo]
disabled = false
symbol = '󰞀 '
format = '[$symbol]($style)'
style = 'bold fg:fehler'

[jobs]
symbol = ' '
number_threshold = 1
format = '[$symbol$number]($style) '
style = 'fg:warnung'

[status]
disabled = false
symbol = '✖'
success_symbol = ''
not_executable_symbol = '󰅘'
not_found_symbol = '󰍉'
sigint_symbol = '󰂭'
signal_symbol = '󱐋'
map_symbol = true
pipestatus = true
format = '[$symbol$common_meaning$signal_name$maybe_int]($style) '
style = 'bold fg:fehler'

[character]
success_symbol = '[▶](bold fg:ok)'
error_symbol = '[▶](bold fg:fehler)'
vimcmd_symbol = '[◀](bold fg:warnung)'
```

Nach dem Speichern reicht ein neuer Prompt, ein Neustart der Shell ist nicht nötig — Starship liest die Konfiguration bei jedem Prompt-Aufbau neu ein.

## meine Konfiguration

```
# ~/.config/starship.toml
"$schema" = 'https://starship.rs/config-schema.json'

format = """
[╭─](bold green)\
$directory\
$git_branch\
$git_commit\
$git_state\
$git_status
[╰─](bold green)$character"""

[git_branch]
symbol = ' '
format = '[$symbol$branch]($style) '
style = 'fg:green'

[git_commit]
commit_hash_length = 7
tag_disabled = false
format = '[($hash$tag)]($style) '
style = 'fg:green'

[git_state]
format = '[\($state( $progress_current/$progress_total)\)]($style) '
style = 'fg:red'

[git_status]
conflicted = '='
ahead = '⇡${count}'
behind = '⇣${count}'
diverged = '⇕⇡${ahead_count}⇣${behind_count}'
untracked = '?${count}'
stashed = '\$${count}'
modified = '!${count}'
staged = '+${count}'
renamed = '»${count}'
deleted = '✘${count}'
format = '([$all_status$ahead_behind]($style) )'
style = 'fg:red'

[directory]
truncation_length = 3
truncate_to_repo = true
truncation_symbol = '…/'
home_symbol = '~'
read_only = ' '
format = '[$path]($style)[$read_only]($read_only_style) '
style = 'bold'

[character]
success_symbol = '[❯](bold fg:green)'
error_symbol = '[❯](bold fg:red)'
```

---

## 7 Aufbau der zweiten Zeile im Detail

```
╭─  fritz@werkbank ~/projekte/juli  main !2 +1  1.79.0        took 3s 14:22
╰─▶
```

Die zweite Zeile enthält bewusst nur wenige Module:

- `$sudo` – zeigt an, dass ein gültiges Sudo-Ticket vorliegt
- `$jobs` – Anzahl der Hintergrundprozesse
- `$status` – Exitcode des letzten Kommandos, sofern ungleich 0
- `$character` – die eigentliche Eingabeaufforderung, grün bei Erfolg, rot bei Fehler

Alles, was hier steht, verschiebt die Cursorposition nach rechts. Halten Sie die Zeile deshalb kurz: der Sinn eines zweizeiligen Prompts ist, dass die Eingabe immer an derselben, weit links liegenden Spalte beginnt.

> [!tip] ASCII-Rückfall
> Für Terminals ohne Nerd Font oder für Fernwartungssitzungen über einfache Konsolen legen Sie eine zweite Konfiguration an und schalten per Umgebungsvariable um:
>
> ```nu
> $env.STARSHIP_CONFIG = ($nu.home-path | path join ".config" "starship-ascii.toml")
> ```
>
> Darin ersetzen Sie `╭─`/`╰─` durch `.-`/`'-` und `▶` durch `>`.

---

## 8 Erweiterung: geschlossener Rahmen

Mit dem Modul `fill` lässt sich die erste Zeile bis zum rechten Rand auffüllen und der Rahmen sauber schließen. `right_format` entfällt dann, weil die Uhrzeit direkt in `format` wandert.

```toml
[fill]
symbol = '─'
style = 'fg:rahmen'

format = """
[╭─](rahmen)\
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$fill\
$cmd_duration\
$time\
[─╮](rahmen)\
$line_break\
[╰─](rahmen)\
$character"""
```

Ergebnis:

```
╭─ fritz@werkbank ~/projekte ──────────────────── took 3s 14:22 ─╮
╰─▶
```

- [ ] Variante mit `fill` ausprobiert
- [ ] Entschieden, welche Variante im eigenen Setup bleibt

---

## 9 Optional: Transient Prompt

Bei einem zweizeiligen Prompt füllt sich der Bildschirmverlauf schnell. Nushell kann alte Prompts nachträglich durch eine kürzere Fassung ersetzen.

```nu
# config.nu, nach dem Vendor-Autoload
$env.TRANSIENT_PROMPT_COMMAND = {|| starship module character }
$env.TRANSIENT_PROMPT_INDICATOR = ""
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }
```

Der aktive Prompt bleibt zweizeilig, alle vorherigen schrumpfen auf das reine Eingabezeichen zusammen.

---

## 10 Diagnose

| Aufgabe | Kommando |
|---|---|
| Welches Modul liefert welchen Teil? | `starship explain` |
| Welches Modul ist langsam? | `starship timings` |
| Einzelnes Modul isoliert testen | `starship module git_status` |
| Wirksame Gesamtkonfiguration ansehen | `starship print-config` |
| Konfiguration inklusive Standardwerten | `starship print-config --default` |
| Konfigurationsdatei im Editor öffnen | `starship config` |
| Fertigen Fehlerbericht erzeugen | `starship bug-report` |
| Vorgefertigte Themes ansehen | `starship preset --list` |

> [!warning] Häufige Stolpersteine
> - **Leere Kästchen statt Symbolen** → keine Nerd Font im Terminal aktiv.
> - **Prompt bleibt einzeilig** → `format` mit `'''` statt `"""` geschrieben, dadurch wurden `\` als Zeichen ausgegeben und der Umbruch verschluckt, oder umgekehrt der beabsichtigte Umbruch wegmaskiert.
> - **Meldung über zu lange Ausführung** → `command_timeout` erhöhen; die Ursache findet `starship timings`.
> - **Änderung wirkt nicht** → `$env.STARSHIP_CONFIG` zeigt auf eine andere Datei als erwartet. Mit `starship print-config` gegenprüfen.
> - **Prompt sieht in Toolbx anders aus** → dort greift eine andere `starship.toml` oder die Nerd Font fehlt im Container-Terminal. Das `container`-Modul macht solche Umgebungen sichtbar.

---

## 11 Aufgaben

- [ ] **A0** Installieren Sie Starship nach `~/.local/bin` und erklären Sie, wozu die beiden Bindestriche in `sh -s -- -b ~/.local/bin` dienen. Weisen Sie anschließend mit `which starship` nach, welches Binary verwendet wird.
- [ ] **A1** Binden Sie Starship über den Vendor-Autoload in Nushell ein und weisen Sie mit `$nu.vendor-autoload-dirs` nach, aus welchem Verzeichnis die Datei geladen wird.
- [ ] **A2** Übernehmen Sie die Konfiguration aus Abschnitt 6. Wechseln Sie in ein Git-Repository mit ungespeicherten Änderungen und beschreiben Sie, welche Module zusätzlich erscheinen.
- [ ] **A3** Ändern Sie den Rahmen von der abgerundeten auf die doppelte Variante und die Farbe auf `warnung`. Notieren Sie die geänderten Zeilen.
- [ ] **A4** Aktivieren Sie das Modul `memory_usage` und setzen Sie den Schwellwert so, dass es auf Ihrem Rechner tatsächlich erscheint.
- [ ] **A5** Führen Sie `exit 3` in einer Subshell aus, sodass das `status`-Modul anspringt. Welche Farbe hat `$character` danach, und warum?
- [ ] **A6** Bestimmen Sie mit `starship timings` das langsamste Modul in einem großen Git-Repository. Deaktivieren Sie es und messen Sie erneut.
- [ ] **A7** Erstellen Sie eine zweite Konfigurationsdatei ohne Nerd-Font-Symbole und schalten Sie über `$env.STARSHIP_CONFIG` zwischen beiden um.

> [!tip]- Lösungshinweis zu A5
> `$character` färbt sich rot, weil das Modul den Exitcode des zuletzt ausgeführten Kommandos auswertet. `$status` und `$character` greifen auf dieselbe Information zu, stellen sie aber unterschiedlich dar: `$status` nennt den numerischen Code beziehungsweise dessen Bedeutung, `$character` signalisiert nur Erfolg oder Misserfolg über die Farbe.

---

## 12 Weiterführend

- [[Nushell Grundlagen]]
- [[Starship Module Referenz]]
- [[Nerd Fonts einrichten]]
- Offizielle Konfigurationsreferenz: `https://starship.rs/config/`
- JSON-Schema für Autovervollständigung im Editor: `https://starship.rs/config-schema.json`
