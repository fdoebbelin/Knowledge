---
title: "Leitfaden: Werkzeuge ins $HOME installieren – am Beispiel Helix"
shell: Nushell
zielgruppe: Fachinformatiker/-in (FISI/FIAE)
system: Fedora Sway Atomic (bootc/ostree) mit Toolbx
verwandt: "[[leitfaden-toolbx-tauri-flatpak]]"
tags: [linux, atomic, toolbx, nushell, helix, editor, scripting]
---
## Am Beispiel des Editors Helix

> [!abstract] Worum es geht
> Auf einem image-basierten System gibt es für ein Werkzeug drei mögliche Orte: das Basisimage, einen Container — oder das Home-Verzeichnis. Dieser Leitfaden erklärt den dritten Weg, weil er auf Fedora Atomic mit Toolbx der am meisten unterschätzte ist: Ein Binary in `~/.local/bin` ist **auf dem Host und in jedem Container gleichzeitig** verfügbar, ohne Layering, ohne Reboot, ohne Nachinstallation je Container.
>
> Nebenbei ist das Installationsskript ein vollständiges Nushell-Beispiel. Abschnitt 4 zerlegt es Zeile für Zeile.

---

## 1 Die Entscheidung: welcher Ort für welches Werkzeug

Toolbx reicht `$HOME` unverändert in den Container durch. Daraus folgt eine klare Regel:

| Art des Werkzeugs | Ort | Begründung |
|---|---|---|
| Muss beim Booten da sein | Basisimage | Kernel, Compositor, Treiber |
| Braucht Systembibliotheken zum Bauen | Toolbx | `-devel`-Pakete, Compiler, Sprachserver |
| Ist ein einzelnes, statisch gelinktes Binary | **`$HOME`** | Editor, Shell, CLI-Werkzeuge |
| Ist eine GUI für Endbenutzer | Flatpak | echte Sandbox, Updates über Repo |

> [!tip] Merksatz
> **Werkzeug ins `$HOME`, Abhängigkeiten in den Container.**
> Helix selbst ist ein einzelnes Binary — er gehört ins `$HOME`. `rust-analyzer` braucht Toolchain und Header — er gehört in den Container. Siehe Abschnitt 6.

### Was gegen die Alternativen spricht

> [!danger] Warum nicht Homebrew, `/usr/local` oder ein Paketmanager
> Homebrew installiert nach `/home/linuxbrew/.linuxbrew` — **außerhalb** von `$HOME`. Im Container existiert dieser Pfad nicht, obwohl er in `$PATH` steht. Auf Fedora Atomic kommt hinzu, dass `/home` ein Symlink auf `/var/home` ist, im Container-Image aber ein echtes, leeres Verzeichnis. Host-Pfade unter `/home/...` lösen dort ins Nichts auf.
>
> Ergebnis: `echo $PATH` zeigt den Pfad, `which nu` findet nichts. Das ist kein Konfigurationsfehler, sondern eine Eigenschaft des Mount-Modells.

---

## 2 Das Muster: Versionsverzeichnis plus Symlink

Dasselbe Muster, das auch Claude Code verwendet:

```
~/.local/share/helix/25.07/hx        ← das eigentliche Binary
~/.local/share/helix/25.07/runtime/  ← Syntaxdefinitionen, Themes
~/.local/bin/hx  ->  ../share/helix/25.07/hx
```

Vorteile:

- **Update** ist ein neues Verzeichnis plus ein `ln -sfn` — die alte Version bleibt bis zum Aufräumen liegen.
- **Rückrollen** ist derselbe Einzeiler mit der alten Versionsnummer.
- **Kein `sudo`**, kein Eingriff ins System, keine Spur in `rpm-ostree status`.

> [!info] Warum `~/.local/bin`
> Der Pfad ist nach der XDG-Spezifikation vorgesehen und auf Fedora bereits in `$PATH` — auch im Container, weil die Shell-Konfiguration aus dem geteilten `$HOME` kommt. Prüfen:
> ```nu
> $env.PATH | where $it =~ "local/bin"
> ```

---

## 3 Das Installationsskript

Speichern als `~/.local/bin/install-helix.nu`, ausführbar machen mit `chmod +x`.

```nu
#!/usr/bin/env nu

# Helix ins $HOME installieren – gilt auf dem Host und in jeder Toolbx
let json = (http get https://api.github.com/repos/helix-editor/helix/releases/latest)
let ver = $json.tag_name
let arch = (uname | get machine)

let kandidaten = ($json.assets
    | where name =~ $"($arch).*linux"
    | where name =~ '\.tar\.(xz|gz)$')

if ($kandidaten | is-empty) {
    print $"Kein passendes Asset für ($arch) gefunden. Verfügbar:"
    $json.assets | get name
    return
}

let asset = ($kandidaten | first)
print $"($ver) / ($arch) / ($asset.name)"

let ziel = ($env.HOME | path join ".local/share/helix" $ver)
let tmp = "/tmp/hx-install"
rm -rf $tmp
mkdir $ziel $tmp ($env.HOME | path join ".local/bin")

let archiv = ($tmp | path join $asset.name)
http get $asset.browser_download_url | save -f $archiv

if ($asset.name | str ends-with ".xz") {
    ^tar -xJf $archiv -C $tmp --strip-components=1
} else {
    ^tar -xzf $archiv -C $tmp --strip-components=1
}

cp ($tmp | path join "hx") $ziel
cp -r ($tmp | path join "runtime") $ziel
chmod +x ($ziel | path join "hx")
ln -sfn ($ziel | path join "hx") ($env.HOME | path join ".local/bin/hx")

rm -rf $tmp
print $"Installiert nach ($ziel)"
```

---

## 4 Das Skript im Detail

### 4.1 `http get` statt `curl`

```nu
let json = (http get https://api.github.com/repos/helix-editor/helix/releases/latest)
```

`http get` ist ein **Nushell-Builtin**. Es erkennt am `Content-Type` der Antwort, dass JSON kommt, und liefert direkt einen **Record** — keinen Text. Deshalb funktioniert gleich darauf:

```nu
$json.tag_name
```

In bash bräuchte es hier `curl | jq -r .tag_name` oder eine `grep`/`cut`-Kette.

> [!warning] Die `grep -m1`-Falle
> Der klassische bash-Einzeiler
> ```bash
> curl -sS ... | grep -m1 '"tag_name"' | cut -d'"' -f4
> ```
> endet mit `curl: (23) Failure writing output to destination`. `grep -m1` beendet sich nach dem ersten Treffer und schließt die Pipe, bevor curl fertig geschrieben hat. In Nushell kann das nicht passieren, weil die Antwort vollständig als Wert vorliegt, bevor gefiltert wird.

Was in dem Record steckt, zeigt:

```nu
$json | columns
$json.assets | select name size | first 5
```

### 4.2 `uname` — Builtin gegen externes Kommando

```nu
let arch = (uname | get machine)
```

> [!danger] Häufiger Stolperstein
> `uname -m` schlägt fehl:
> ```
> Error: nu::parser::unknown_flag
>   × The `uname` command doesn't have flag `-m`.
> ```
> Nushell hat ein **eigenes** `uname`, das das externe verdeckt. Es liefert einen Record, aus dem `get machine` die Architektur zieht — `x86_64` oder `aarch64`.
>
> Wer das externe Kommando braucht, erzwingt es mit dem Caret:
> ```nu
> let arch = (^uname -m | str trim)
> ```
> Das `str trim` ist dann nötig, weil externe Kommandos einen abschließenden Zeilenumbruch liefern. Dasselbe Muster betrifft `ls`, `which`, `du`, `sort` und `open`.

### 4.3 Filtern mit `where` — und die Interpolationsfalle

```nu
let kandidaten = ($json.assets
    | where name =~ $"($arch).*linux"
    | where name =~ '\.tar\.(xz|gz)$')
```

`$json.assets` ist eine **Tabelle**. `where` filtert Zeilen, `=~` ist der Regex-Vergleich. Warum aber zwei getrennte `where`?

> [!danger] Regex und String-Interpolation vertragen sich nicht
> In `$"..."` sind runde Klammern **Befehlsersetzung**. Der Ausdruck
> ```nu
> $json.assets | where name =~ $"($arch).*linux.*\.tar\.(xz|gz)$"
> ```
> lässt Nushell versuchen, `xz` auszuführen und dessen Ausgabe an `gz` zu pipen:
> ```
> command gz not found
> ```
> **Zwei Auswege:** die Bedingung in zwei `where` trennen, wobei nur das erste interpoliert — oder das Muster vorher zusammenbauen:
> ```nu
> let muster = ($arch + '.*linux.*\.tar\.(xz|gz)$')
> $json.assets | where name =~ $muster
> ```
> In einfachen Anführungszeichen `'...'` findet **keine** Interpolation statt; Klammern bleiben dort Regex.

Warum überhaupt filtern statt den Dateinamen zu bauen? Weil Projekte ihre Namensschemata ändern — Helix liefert je nach Release `x86_64-linux.tar.xz` oder `x86_64-unknown-linux-gnu.tar.xz`. Das Skript liest, was tatsächlich da ist.

### 4.4 Abbruch mit Diagnose

```nu
if ($kandidaten | is-empty) {
    print $"Kein passendes Asset für ($arch) gefunden. Verfügbar:"
    $json.assets | get name
    return
}
```

`is-empty` prüft leere Listen. Statt kommentarlos zu scheitern, gibt das Skript die tatsächlich vorhandenen Namen aus — dann sieht man in einer Zeile, welches Muster stattdessen passt. `return` beendet das Skript.

### 4.5 Pfade zusammensetzen mit `path join`

```nu
let ziel = ($env.HOME | path join ".local/share/helix" $ver)
```

`path join` nimmt beliebig viele Bestandteile und setzt sie mit dem korrekten Trennzeichen zusammen. Gegenüber `$"($env.HOME)/.local/share/helix/($ver)"` ist das robuster: keine doppelten Schrägstriche, kein vergessener Trenner.

> [!tip] Weitere `path`-Befehle
> ```nu
> "~/.cargo" | path expand        # Tilde auflösen, absoluten Pfad bilden
> "/pfad/datei.txt" | path exists # Existenzprüfung, ersetzt test -f
> "/pfad/datei.txt" | path parse  # Record mit parent, stem, extension
> "/pfad/datei.txt" | path dirname
> ```

### 4.6 Herunterladen und speichern

```nu
http get $asset.browser_download_url | save -f $archiv
```

`save -f` schreibt den Datenstrom in eine Datei, `-f` überschreibt vorhandene. Bei Binärdaten ist `--raw` nicht nötig, weil Nushell den Typ aus der Antwort erkennt. Bei Textdateien, die unverändert bleiben sollen, gehört `--raw` dazu:

```nu
http get https://sh.rustup.rs | save --raw --force rustup-init.sh
```

### 4.7 Externe Kommandos gezielt aufrufen

```nu
if ($asset.name | str ends-with ".xz") {
    ^tar -xJf $archiv -C $tmp --strip-components=1
} else {
    ^tar -xzf $archiv -C $tmp --strip-components=1
}
```

`^tar` erzwingt das externe Kommando — dieselbe Vorsicht wie bei `uname`. Der `if`-Zweig fängt beide Kompressionsformate ab, weil Projekte auch das gelegentlich wechseln.

`--strip-components=1` entfernt das oberste Verzeichnis aus dem Archiv, sodass `hx` und `runtime/` direkt in `$tmp` landen. Im Zweifel vorher prüfen:

```nu
^tar -tf $archiv | first 5
```

### 4.8 Der Symlink

```nu
ln -sfn ($ziel | path join "hx") ($env.HOME | path join ".local/bin/hx")
```

`-s` symbolisch, `-f` vorhandenen Link überschreiben, `-n` einen bestehenden Symlink **ersetzen** statt in ihn hineinzuschreiben. Ohne `-n` landet bei einem Update ein Link im Zielverzeichnis statt an seiner Stelle.

### 4.9 Was Nushell hier anders macht als bash

| Aufgabe | bash | Nushell |
|---|---|---|
| JSON von einer API | `curl \| jq -r .feld` | `http get URL \| get feld` |
| Liste filtern | `grep muster` | `where feld =~ "muster"` |
| Leere Liste prüfen | `[ -z "$var" ]` | `$liste \| is-empty` |
| Pfad bauen | `"$HOME/a/b"` | `$env.HOME \| path join "a" "b"` |
| Externes Kommando erzwingen | *(nicht nötig)* | `^befehl` |
| Zeilenumbruch entfernen | `$(cmd)` macht es selbst | `\| str trim` |
| Regex mit Variable | `"${var}.*muster"` | `$var + '.*muster'` |

---

## 5 Konfiguration

### 5.1 Runtime-Verzeichnis bekannt machen

> [!warning] Ohne diesen Schritt kein Syntax-Highlighting
> Helix sucht sein `runtime/`-Verzeichnis relativ zum Binary. Über den Symlink schlägt das fehl — der Editor startet, bleibt aber farblos.

Die Zuweisung gehört in die Datei, die `$nu.env-path` meldet — üblicherweise `~/.config/nushell/env.nu`:

```nu
$env.HELIX_RUNTIME = ($env.HOME | path join ".local/bin/hx"
    | path expand | path dirname | path join "runtime")
```

`path expand` löst den Symlink auf und liefert das Versionsverzeichnis; daraus wird das Runtime-Verzeichnis abgeleitet. Nach einem Update stimmt die Zeile automatisch weiter, weil sie den Symlink liest statt eine Versionsnummer zu enthalten.

> [!warning] Falls `env.nu` nicht existiert
> Neuere Nushell-Versionen legen die Datei nicht mehr automatisch an. Dann gehört der Eintrag nach `$nu.config-path`, also `~/.config/nushell/config.nu`. Prüfen:
> ```nu
> $nu.env-path
> $nu.env-path | path exists
> ```

### Wohin genau in der Datei

**Außerhalb** eines Toolbx-Riegels heißt: auf oberster Ebene, nicht innerhalb der geschweiften Klammern eines `if`-Blocks. Bewährter Aufbau:

```nu
# ─── gilt überall ───────────────────────────────────────────
$env.EDITOR = "hx"
$env.HELIX_RUNTIME = ($env.HOME | path join ".local/bin/hx"
    | path expand | path dirname | path join "runtime")

# ─── nur auf dem Host ───────────────────────────────────────
if not ("/run/.toolboxenv" | path exists) {
    # z. B. Homebrew-Umgebung
}

# ─── nur im Container ───────────────────────────────────────
if ("/run/.toolboxenv" | path exists) {
    let box = (open /run/.containerenv | from toml | get name)

    $env.CARGO_HOME = ($env.HOME | path join ".local/share/toolbox" $box "cargo")
    $env.RUSTUP_HOME = ($env.HOME | path join ".local/share/toolbox" $box "rustup")
    $env.PATH = ($env.PATH | prepend ($env.CARGO_HOME | path join "bin"))

    $env.PROMPT_COMMAND = {||
        let dir = ($env.PWD | str replace $env.HOME "~")
        $"(ansi { fg: '#ffffff', bg: '#8a4b12', attr: b }) ⬢ ($box) (ansi reset)(ansi yellow_bold) ($dir)(ansi reset)"
    }
    $env.PROMPT_INDICATOR = {|| $"(ansi yellow_bold) ❯ (ansi reset)" }
}
```

> [!tip] Reihenfolge innerhalb des Container-Blocks
> `CARGO_HOME` und `PATH` stehen bewusst **vor** dem Prompt. Läuft eine Zeile auf einen Fehler, überspringt Nushell alles Folgende — ein kosmetischer Fehler im Prompt würde sonst die Werkzeugkette mitreißen. Genau so verschwindet `cargo` scheinbar nach einem Container-Neustart.

Prüfen:

```nu
source $nu.env-path
$env.HELIX_RUNTIME
hx --version
hx --health | first 12
```

### 5.2 Konfiguration ist automatisch geteilt

`~/.config/helix/` liegt im `$HOME` — Konfiguration, Themes und Keybindings gelten sofort auf dem Host und in jedem Container.

> [!info] Ausnahmsweise erwünscht
> Bei `~/.cargo` ist das geteilte `$HOME` ein Problem, hier ein Vorteil: Es gibt nur einen Editor mit einer Konfiguration. Der Unterschied: Cargo-Artefakte sind an Systembibliotheken gebunden, eine Editor-Konfiguration ist es nicht.

`~/.config/helix/config.toml` als Ausgangspunkt:

```toml
theme = "base16_terminal"

[editor]
line-number = "relative"
bufferline = "multiple"
color-modes = true

[editor.cursor-shape]
insert = "bar"
normal = "block"

[editor.indent-guides]
render = true
```

---

## 6 Sprachserver gehören in den Container

Hier verläuft die Grenze. Der Editor kann ins `$HOME`, seine Sprachserver nicht: `rust-analyzer` braucht Toolchain **und** Systembibliotheken.

```nu
toolbox enter tauri-dev
rustup component add rust-analyzer
hx --health rust
```

Startest du Helix im Container, findet er `rust-analyzer` über das dort gesetzte `CARGO_HOME`. Auf dem Host bleibt Rust bewusst unbekannt — dort editierst du Konfigurationsdateien und Markdown, wofür kein Sprachserver nötig ist.

### Wrapper, wenn Helix auf dem Host bleiben soll

```nu
"#!/bin/sh
exec toolbox run -c tauri-dev rust-analyzer \"$@\"" | save -f ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
```

Das funktioniert, weil LSP über stdin/stdout kommuniziert und `$HOME` in beiden Welten identisch ist — die Pfade im Protokoll passen also auf beiden Seiten.

> [!tip] Abwägung für den Unterricht
> **Helix im Container starten** ist robuster und braucht keine Erklärung.
> **Der Wrapper** ist bequemer, wenn mehrere Projekte in verschiedenen Containern liegen — dann braucht es aber je Container einen eigenen Wrapper, und die Zuordnung Projekt→Container muss von Hand gepflegt werden.

---

## 7 Update und Deinstallation

```nu
# Update: Skript erneut laufen lassen
install-helix.nu

# Vorhandene Versionen ansehen
ls ~/.local/share/helix | select name modified

# Auf eine ältere Version zurück
ln -sfn ($env.HOME | path join ".local/share/helix/25.01/hx") ($env.HOME | path join ".local/bin/hx")

# Alte Version entfernen
rm -rf ~/.local/share/helix/25.01

# Vollständig deinstallieren
rm -rf ~/.local/share/helix ~/.local/bin/hx
```

Nichts davon berührt das Basisimage. `rpm-ostree status` bleibt unverändert, ein Reboot ist nie nötig.

---

## 8 Dasselbe Muster für andere Werkzeuge

Das Skript lässt sich mit drei Änderungen übertragen: Repository-URL, Asset-Muster und die Liste der zu kopierenden Dateien.

| Werkzeug | Besonderheit |
|---|---|
| **Nushell** | musl-Build wählen (statisch gelinkt, glibc-unabhängig); zusätzlich `nu_plugin_*` kopieren |
| **ripgrep, fd, bat, eza** | einzelnes Binary, kein Runtime-Verzeichnis — Skript wird kürzer |
| **zellij, lazygit** | wie oben, einzelnes Binary |
| **Node.js, Python** | ungeeignet — bringen Bibliotheksbäume mit, gehören in den Container |
| **Alles mit `-devel`-Bedarf** | gehört in den Container, nicht ins `$HOME` |

> [!note] musl gegen gnu
> Wo ein Projekt beide Varianten anbietet, ist der **musl-Build** für dieses Muster die bessere Wahl: Er ist statisch gelinkt und läuft dadurch unabhängig von der glibc-Version — auf dem Host, im heutigen Container und in einem künftigen mit anderer Fedora-Version. Der gnu-Build funktioniert nur, solange Host und Container dieselbe Basis haben.

---

## 9 Troubleshooting

| Symptom | Ursache | Abhilfe |
|---|---|---|
| `command gz not found` | Klammern in `$"..."` als Befehlsersetzung | Abschnitt 4.3 |
| `uname doesn't have flag -m` | Nushell-Builtin verdeckt externes Kommando | `uname \| get machine` oder `^uname -m` |
| `hx` startet ohne Farben | `HELIX_RUNTIME` nicht gesetzt | Abschnitt 5.1 |
| `cargo` nach Container-Neustart weg | `env.nu` bricht vor der `PATH`-Zeile ab | Reihenfolge, Abschnitt 5.1 |
| `Cannot find column 'home-path'` | `$nu`-Konstante je nach Version anders benannt | `$env.HOME` statt `$nu.home-path`; `$nu \| columns` |
| `hx: command not found` | `~/.local/bin` nicht in `$PATH` | `$env.PATH \| where $it =~ "local/bin"` |
| Symlink zeigt ins Leere | Zielverzeichnis gelöscht | Skript erneut ausführen |
| Symlink liegt im Zielverzeichnis | `ln` ohne `-n` aufgerufen | `ln -sfn`, Abschnitt 4.8 |
| Archiv lässt sich nicht entpacken | falsches Kompressionsformat | `^tar -tf ARCHIV \| first 5` |
| `curl: (23)` bei bash-Varianten | `grep -m1` schließt die Pipe | erst puffern, dann filtern |
| Kein Asset gefunden | Namensschema geändert | `$json.assets \| get name` ansehen |
| Binary läuft im Container nicht | gnu-Build, glibc passt nicht | musl-Variante verwenden |

---

## 10 Zusammenfassung

> [!success] Die drei Regeln
> 1. **Ein einzelnes Binary gehört ins `$HOME`** — nach `~/.local/share/PROGRAMM/VERSION`, verlinkt in `~/.local/bin`. Es ist damit auf dem Host und in jedem Container verfügbar.
> 2. **Abhängigkeiten gehören in den Container** — Sprachserver, Compiler, Header. Sie brauchen Systembibliotheken, die es nur dort gibt.
> 3. **Nichts davon gehört ins Basisimage** — kein Layering, kein Reboot, keine Drift vom Flotten-Image.

Verwandte Unterlagen: [[leitfaden-toolbx-tauri-flatpak]] für die vollständige Werkzeugkette, [[spickzettel-toolbx]] für die Abgrenzung zu Distrobox.
