---
titel: XPS 13 — WSLg-Sway, Helix und Nushell-Konfiguration (Runde 1)
aliases: [WSLg-Tastaturproblem, Nushell-0.114-Migration, XPS-Runde-1]
teil_von: "[[README]]"
tags: [wsl, sway, wslg, nushell, helix, sudo, homebrew, xps13]
erstellt: 2026-07-29
system: Dell XPS 13 9345 (Snapdragon X Elite, aarch64), FedoraLinux-44 WSL, Nushell 0.114.1 (brew)
verifiziert_gegen: Nushell 0.114.1 (Konfigurationsteile), Sway-Session XPS (Symptomatik)
status: entwurf
---

# 14 — XPS 13: Erste Sway/Nushell-Runde unter WSLg

Protokoll der ersten Arbeitsrunde nach [[13-xps13-wsl-installation]]:
Sway startete, reagierte aber auf keine Taste; Helix lief in Schwarz-Weiß;
die Nushell-Konfiguration fiel beim Start mit zwei Fehlerklassen aus.
Alle drei Probleme sind diagnostiziert, zwei davon behoben und live
bestätigt.

> [!info] Statuslegende dieser Notiz
> Jeder Abschnitt trägt eine Kennzeichnung:
> - **✅ verifiziert** — auf dem XPS bzw. gegen Nushell 0.114.1 gemessen
> - **🟡 hergeleitet** — aus dokumentierter Semantik gefolgert, Symptom passt,
>   aber Wirkung der Korrektur noch nicht live bestätigt
> - **⬜ offen** — Messung steht aus

---

## 1 — Sway reagiert auf keine Taste

### 1.1 Mod-Tasten-Referenz ✅

`Mod1` ist die **linke Alt-Taste**. Vollständige Zuordnung:

| Sway-Name | Physische Taste | Alias |
|---|---|---|
| `Mod1` | Alt links | `Alt` |
| `Mod2` | NumLock | — |
| `Mod3` | frei (layoutabhängig) | — |
| `Mod4` | Super/Windows | `Super`, `Logo` |
| `Mod5` | AltGr (`ISO_Level3_Shift`) | — |

> [!warning] Unter `de`-Layout ist nur die *linke* Alt-Taste Mod1
> Die rechte ist AltGr → Mod5. Bindings funktionieren nur links.

### 1.2 Ursache: Parse-Reihenfolge, nicht Tastatur 🟡

`/etc/sway/config` enthält die Include-Direktive in **Zeile 228**
([[01-erkenntnisse#Das dreistufige Include-System]]). Alle Default-`bindsym`
der Hauptkonfiguration stehen davor, `set $mod Mod4` ganz oben.

**Sway expandiert Variablen zum Parse-Zeitpunkt.** Ein `set $mod Mod1` im
Drop-in `20-wslg.conf` wird erst bei Zeile 228 gelesen — da sind alle
Default-Bindings längst als `Mod4+…` festgeschrieben. Das Drop-in-`set`
wirkt nur auf `bindsym`-Zeilen, die *nach ihm* kommen.

Ergebnis: Sway lief, alle Bindings hingen an Super — und Super fängt
Windows ab, bevor WSLg es durchreicht. Exakt das beobachtete Symptom.

> [!important] Entscheidung: Bindings gehören ins Drop-in selbst
> `set $mod Mod1` allein ist prinzipbedingt wirkungslos. Das Drop-in muss
> die benötigten `bindsym`-Zeilen **selbst** setzen. Alternative wäre eine
> gepatchte Hauptkonfiguration gewesen — verworfen, weil `/etc/sway/config`
> aus `sway-config-fedora` stammt und bei jedem Paketupdate überschrieben
> würde. Das Drop-in bleibt updatefest.

### 1.3 Zweite Erkenntnis: Variablen der Hauptkonfiguration wiederverwenden 🟡

Dieselbe Parse-Zeit-Semantik in die andere Richtung: `$term`, `$menu`,
`$rofi_cmd`, `$left/$down/$up/$right` sind in `/etc/sway/config` **vor**
Zeile 228 definiert — im Drop-in also bereits verfügbar.

> [!important] Entscheidung: `$term`/`$menu` statt Hardcodierung
> Erste Fassung des Drop-ins setzte `exec foot` und `exec fuzzel` fest.
> Verworfen: der Fedora-Standard ist rofi (`$menu` mit combi-Modus), und
> die Hardcodierung zerreißt die Kopplung an `sway-config-fedora`. Die
> Variablen der Hauptkonfiguration sind der Vertrag, das Drop-in nutzt ihn.

Vorhandene Definitionen aus dem laufenden System lesen, statt sie
anzunehmen:

```nu
open /etc/sway/config
| lines
| enumerate
| where item =~ '^\s*set \$'
| each {|r| {zeile: ($r.index + 1), definition: ($r.item | str trim)} }
```

### 1.4 Das korrigierte Drop-in 🟡

```nu
r##'# WSLg-Host: Sway als Wayland-Client
output WL-1 resolution 1920x1200 scale 1.3

input type:keyboard {
    xkb_layout "de"
    xkb_variant "nodeadkeys"
}

# Windows faengt Super ab, bevor WSLg es durchreicht.
# set $mod wirkt nur auf bindsym-Zeilen UNTERHALB dieser Zeile — die
# Defaults aus /etc/sway/config (Zeilen < 228) bleiben auf Mod4.
# $term, $menu, $left ... stammen von dort und sind hier bereits definiert.
set $mod Mod1

bindsym --to-code $mod+Return       exec $term
bindsym --to-code $mod+d            exec $menu
bindsym --to-code $mod+Shift+q      kill
bindsym --to-code $mod+Shift+c      reload
bindsym --to-code $mod+Shift+e      exec swaynag -t warning -m "Sway beenden?" -B "Ja" "swaymsg exit"

bindsym --to-code $mod+$left        focus left
bindsym --to-code $mod+$down        focus down
bindsym --to-code $mod+$up          focus up
bindsym --to-code $mod+$right       focus right
bindsym --to-code $mod+Shift+$left  move left
bindsym --to-code $mod+Shift+$down  move down
bindsym --to-code $mod+Shift+$up    move up
bindsym --to-code $mod+Shift+$right move right

bindsym --to-code $mod+f            fullscreen
bindsym --to-code $mod+v            splitv
bindsym --to-code $mod+b            splith
bindsym --to-code $mod+Shift+space  floating toggle

bindsym --to-code $mod+1 workspace number 1
bindsym --to-code $mod+2 workspace number 2
bindsym --to-code $mod+3 workspace number 3
bindsym --to-code $mod+4 workspace number 4
bindsym --to-code $mod+Shift+1 move container to workspace number 1
bindsym --to-code $mod+Shift+2 move container to workspace number 2
bindsym --to-code $mod+Shift+3 move container to workspace number 3
bindsym --to-code $mod+Shift+4 move container to workspace number 4

bar mode invisible
'## | sudo tee /etc/sway/config.d/20-wslg.conf | ignore

swaymsg reload
```

> [!note] Warum `--to-code`
> Ohne `--to-code` bindet Sway auf Keysyms — unter `de` landen `-`, `+`,
> Umlaute und geshiftete Ziffern auf anderen Tasten als im US-Layout
> gedacht. `--to-code` bindet auf die physische Position.

> [!note] Voraussetzung prüfen: rofi
> `sway-config-fedora` zieht rofi als Abhängigkeit, aber die Paketliste in
> [[13-xps13-wsl-installation#Schritt 5]] nennt es nicht explizit:
> ```nu
> [rofi-wayland foot] | each {|p| {paket: $p, da: ((rpm -q $p | complete).exit_code == 0)} }
> ```

### 1.5 Diagnosewerkzeuge für die laufende Session ✅

```nu
# Wurde das Drop-in überhaupt geladen? (kein anderes Drop-in setzt input)
swaymsg -t get_inputs
| from json
| where type == "keyboard"
| select identifier xkb_active_layout_name

# Modifier live testen — bindsym per IPC wirkt sofort, ohne reload
swaymsg 'bindsym Mod1+Return exec foot'
swaymsg 'bindsym Mod4+Return exec foot'

# Syntax und generierte Include-Liste
sway --validate --config /etc/sway/config
glob $"($env.XDG_RUNTIME_DIR)/sway/*" | each {|f| {datei: $f, zeilen: (open $f | lines | length)} }
```

### 1.6 Verworfene Alternative: CapsLock als Modifier ⬜

`xkb_options "caps:super"` würde CapsLock zu Mod4 machen — Windows fängt
nur den physischen Win-Scancode ab, die Umbelegung passiert erst in Sways
XKB-Schicht. Damit blieben alle Default-Bindings unverändert nutzbar.

> [!warning] Entwurf, nicht Messung
> Ob WSLg den CapsLock-Keycode unverändert durchreicht, ist auf dem XPS
> nicht verifiziert. Gegenprüfen mit `wev` (`sudo dnf install wev`), erst
> dann umstellen. Der Alt-Weg ist der belastbare — mit dem bekannten
> Nebeneffekt, dass Alt+D in Anwendungen (Firefox-Adressleiste, Menüs)
> von Sway abgefangen wird.

---

## 2 — Fenstergröße und Skalierung

### 2.1 Zwei Stellschrauben, oft verwechselt ✅

| Was zu klein ist | Falscher Hebel | Richtiger Hebel |
|---|---|---|
| Arbeitsfläche (Platz) | `scale` | `resolution` hoch |
| Schrift/UI (Lesbarkeit) | `resolution` | `scale` hoch oder Schriftgrößen |

`resolution` = Fenstergröße in Gerätepixeln; `scale` teilt in logische
Pixel. Unter dem Wayland-Backend ist `resolution` nur die **Startgröße** —
maximiert man das Windows-Fenster, folgt der wlroots-Output.

### 2.2 Korrektur: 16:10 statt 16:9 ✅

Das XPS 13 9345 hat ein 16:10-Panel (1920×1200 IPS oder 2880×1800 OLED).
Die ursprüngliche Zeile `1920x1080` war 16:9 — Streifen verschenkt,
Fenster passt nicht. Korrigiert auf `1920x1200` (siehe Drop-in oben).

### 2.3 Entscheidung: ganzzahlige Skalierung unter Pixman 🟡

> [!important] Fraktionale Skalierung kostet unter Software-Rendering
> Ohne Render-Node ([[01-erkenntnisse#Umgebungsbefunde WSL]]) läuft alles
> über Pixman. `scale 1.5` erzwingt einen Resampling-Schritt über die
> volle Fläche — auf 2880×1800 spürbar. Regel: `scale` ganzzahlig halten
> (`1` oder `2`); liegt der Wunsch dazwischen, stattdessen Schriftgrößen
> anheben (foot `font=monospace:size=20`, `dpi-aware=no`;
> `gsettings … text-scaling-factor 1.25`).

### 2.4 Offene Messung: Was meldet WSLg wirklich? ⬜

Die Annahme „scale bleibt 1, weil Windows bereits skaliert" aus
[[13-xps13-wsl-installation]] ist unbelegt. Entscheidender Test:

```nu
grim /tmp/wslg-probe.png
open --raw /tmp/wslg-probe.png | bytes at 16..24 | into int --endian big
```

- Breite 2880 bei Windows-200 % → WSLg meldet **native** Pixel →
  `resolution 2880x1800 scale 2`
- Breite 1440 → Windows skaliert vor → `scale 1` korrekt, `resolution`
  auf die *logische* Größe

Der Befund gehört anschließend nach [[05-hidpi-und-monitore]].

---

## 3 — sudo und Homebrew: `secure_path`

### 3.1 Befund ✅

```
sudo hx …  →  sudo: hx: command not found
```

Nicht Helix, sondern `secure_path` in `/etc/sudoers`: sudo ersetzt `PATH`
durch eine feste Liste ohne `/home/linuxbrew/.linuxbrew/bin`. Direkte
Konsequenz der Zwei-Schichten-Regel aus
[[13-xps13-wsl-installation#Die Zwei-Schichten-Regel]].

### 3.2 Entscheidung: `sudoedit`, nicht Pfad-Umgehung 🟡

> [!important] Sicherheitsargument, kein Bequemlichkeitsargument
> `/home/linuxbrew/.linuxbrew` ist **für den User schreibbar**. Jede
> Binary dort per `sudo` auszuführen heißt: Account-Zugriff = trivialer
> Root-Zugriff. `sudoedit` dreht das um — Temp-Kopie, Editor läuft **als
> User** (deshalb greift `secure_path` gar nicht), Rückschreiben als root.
> `sudo /voller/pfad/hx` funktioniert, bleibt aber die Ausnahme.

```nu
$env.SUDO_EDITOR = "/home/linuxbrew/.linuxbrew/bin/hx"
sudoedit /etc/sway/config.d/20-wslg.conf
```

Dauerhaft via `config.nu`-Block (Abschnitt 5.6). Öffnet sich trotzdem
`vi`: `sudo sudo -V | lines | find -i editor` prüfen; ggf.
`Defaults env_editor` per `sudo visudo -f /etc/sudoers.d/10-editor`.

> [!note] Generierte Dateien nicht interaktiv editieren
> `20-wslg.conf` entsteht aus einem `r##'…'##`-Block. Änderungen gehören
> in den Block, der neu geschrieben wird — der Vault-Text bleibt Quelle,
> die Datei Artefakt. `sudoedit` ist der Weg für den Ausnahmefall.

> [!note] Auf dem bootc-Image stellt sich die Frage nicht
> Dort kommt `hx` aus dnf und liegt in `/usr/bin` — innerhalb von
> `secure_path`.

---

## 4 — Helix: Schwarz-Weiß

### 4.1 Diagnoseweg ✅

`hx --health` trennt die zwei möglichen Ursachen:

1. **Runtime fehlt** → Themes nicht ladbar, hartes Minimal-Fallback
2. **Terminal meldet keine Farben** → `COLORTERM` leer, Truecolor aus

Befund auf dem XPS: Runtime vorhanden
(`…/Cellar/helix/25.07.1/libexec/runtime`, Highlight-Spalte durchgehend ✓),
aber **`Config file: default`** — es gab keine `config.toml`. Helix'
eingebautes Default-Theme ist bewusst ein reines 16-Farben-ANSI-Theme.
Genau das gesehene Schwarz-Weiß.

### 4.2 Entscheidung: kein `HELIX_RUNTIME` setzen ✅

> [!important] Selbstheilung nicht kaputtkonfigurieren
> Der Cellar-Pfad enthält die Version (`25.07.1`). Helix findet die
> Runtime relativ zur eigenen Binary — nach `brew upgrade helix` zeigt
> das automatisch auf das neue Verzeichnis. Ein fest gesetztes
> `HELIX_RUNTIME` würde nach dem ersten Upgrade auf ein gelöschtes
> Verzeichnis zeigen. Deshalb: Umgebung **nicht** anfassen.

### 4.3 Konfiguration 🟡

```nu
mkdir ~/.config/helix
r#'theme = "onedark"

[editor]
true-color = true
line-number = "relative"
bufferline = "multiple"

[editor.cursor-shape]
insert = "bar"
normal = "block"

[editor.indent-guides]
render = true
'# | save -f ~/.config/helix/config.toml
```

> [!note] `true-color = true` ist Pflicht, nicht Kosmetik
> Im Windows Terminal über WSLg ist `COLORTERM` oft nicht gesetzt — dann
> rechnet Helix Truecolor-Themes auf 16 ANSI-Farben herunter. Die Zeile
> erzwingt 24 Bit unabhängig von der Umgebung.

Themes live durchsehen: `:theme` + Tab-Vervollständigung (leere Liste =
Runtime doch nicht gefunden). Eigene Anpassungen als **Ableitung**, nicht
als Kopie eines Cellar-Themes — überlebt jedes Upgrade:

```nu
mkdir ~/.config/helix/themes
r#'inherits = "onedark"

"ui.background" = {}
'# | save -f ~/.config/helix/themes/noctarow.toml
```

---

## 5 — Nushell: zwei Fehlerklassen, drei Fehler

Beim `nu`-Start fielen zwei Fehler; bei der Reparatur kam ein dritter ans
Licht, der in einem frisch geschriebenen Block steckte.

### 5.1 Fehler 1: veraltetes `do`-Flag in `env.nu` ✅ behoben

`do --ignore-shell-errors` existiert seit einigen Versionen nicht mehr;
heute heißt es `--ignore-errors`. Reparatur (live bestätigt, `nu-check`
→ `true`):

```nu
cp $nu.env-path $"($nu.env-path).bak"
open --raw $nu.env-path
| str replace --all "--ignore-shell-errors" "--ignore-errors"
| save -f $nu.env-path
```

### 5.2 Fehler 2: `use scripts/noctarow.nu *` in `config.nu` ✅ behoben

**Gemessen (0.107 und 0.114.1): relative `use`-Pfade werden gegen das
Verzeichnis der Datei aufgelöst, nicht gegen das Arbeitsverzeichnis.**
Die Zeile suchte also in `~/.config/nushell/scripts/` — sie hat nie
funktioniert, unabhängig davon, wo `nu` gestartet wurde.

> [!warning] Frühere Vault-Aussage ist damit widerlegt
> Die Regel „`use scripts/noctarow.nu *` muss *nach* dem Anlegen des
> Projektverzeichnisses stehen" ist falsch bzw. irrelevant: die Position
> in der Datei spielt keine Rolle, weil ein Parse-Fehler die **gesamte**
> `config.nu` verwirft (gemessen: gültige Zeilen *vor* der kaputten
> `use`-Zeile sind ebenfalls verloren). Ein
> `if ($pfad | path exists) { use … }` gibt es nicht — `use` ist
> parse-time, die Bedingung würde nie ausgewertet.

> [!important] Entscheidung: `const` + absoluter Pfad
> Sobald `~/projekte/noctarow` auf dem XPS existiert:
> ```nu
> const noctarow_modul = ($nu.home-dir | path join "projekte/noctarow/scripts/noctarow.nu")
> use $noctarow_modul *
> ```
> Gegen 0.114.1 verifiziert: `nu-check` → `true`, Modulbefehle verfügbar.
> Bis dahin ist die Zeile aus `config.nu` entfernt.

### 5.3 Fehler 3: `$nu.home-path` existiert seit 0.114 nicht mehr ✅ behoben

Gemessener Versionsvergleich:

| 0.107 | 0.114 |
|---|---|
| `$nu.home-path` | `$nu.home-dir` |
| `$nu.temp-path` | `$nu.temp-dir` |

Stille Umbenennung **ohne Deprecation-Warnung**. Betroffen waren
`env.nu` (Zeile 107, `REGISTRY_AUTH_FILE`), der frisch geschriebene
`sway-start`-Block sowie im Vault `08-verteilung` (1×) und
`02-umgebung-wsl` (3×). Sammelreparatur:

```nu
[$nu.env-path, $nu.config-path]
| each {|f|
    let vorher = (open --raw $f)
    let nachher = (
        $vorher
        | str replace --all '$nu.home-path' '$nu.home-dir'
        | str replace --all '$nu.temp-path' '$nu.temp-dir'
    )
    if $vorher != $nachher { $nachher | save -f $f }
    {datei: ($f | path basename), geaendert: ($vorher != $nachher)}
}
```

Analog über `glob ~/projekte/noctarow/docs/*.md` für den Vault.

### 5.4 Die zentrale Lehre: `nu-check` prüft Syntax, nicht Semantik ✅

Gemessen gegen 0.114.1 — zwei Fehlerklassen, zwei Schadensbilder:

| | Parse-Fehler (`use scripts/…`) | Laufzeitfehler (`$nu.home-path`) |
|---|---|---|
| `nu-check` | **erkennt ihn** | **erkennt ihn nicht** (`true`!) |
| Wirkung | ganze Datei verworfen | Abbruch ab der Fehlerzeile |
| Zeilen davor | wirkungslos | bereits angewendet |

Konsequenz: `nu-check` allein ist kein Freibrief. Zusätzlicher
Feldabgleich vor jedem `exec nu`:

```nu
let bekannt = ($nu | columns)
[$nu.env-path, $nu.config-path]
| each {|f|
    open --raw $f
    | parse --regex '\$nu\.(?<feld>[a-z0-9-]+)'
    | get feld | uniq
    | where {|x| $x not-in $bekannt}
    | each {|x| {datei: ($f | path basename), unbekannt: $x}}
}
| flatten
```

Leere Tabelle → sauber.

### 5.5 Nebenbefund: 899-Zeilen-`config.nu` ist eine Altlast ⬜

Die Datei ist die alte Default-Vorlage aus einer Nushell weit vor 0.101 —
seither liefert Nushell **leere** Konfigurationsdateien aus und hält
Defaults intern. Die Vorlage schleppt Syntax mit, die mit jedem Upgrade
weiter zerbricht (`--ignore-shell-errors` war nur der erste Treffer).

> [!important] Empfehlung: leerer Start plus eigener Block
> ```nu
> mv $nu.config-path $"($nu.config-path).alt"
> mv $nu.env-path $"($nu.env-path).alt"
> ```
> **Vorher prüfen**, ob eigene Zeilen zwischen der Vorlage stecken:
> ```nu
> open $nu.config-path | lines | where {|z| ($z | str trim) != "" and not ($z | str starts-with "#")} | length
> ```
> Noch nicht ausgeführt — erst durchsehen, dann entscheiden.

### 5.6 Der `config.nu`-Block: `sudoedit`, `sway-start`, `sway-log`, `ensure-block` ✅

Geschrieben per `ensure-block`, einem idempotenten, marker-geführten
Helfer (zwei Läufe → ein Markerpaar, gemessen). Gegen 0.114.1 geprüft;
`sway-start`/`sway-log` sind nach `exec nu` in `scope commands`
nachgewiesen.

```nu
def ensure-block [datei: path, marke: string, inhalt: string] {
    let start = $"# >>> ($marke) >>>"
    let ende  = $"# <<< ($marke) <<<"
    let zeilen = (if ($datei | path exists) { open --raw $datei | lines } else { [] })
    let a = ($zeilen | enumerate | where {|r| ($r.item | str trim) == $start} | get index)
    let b = ($zeilen | enumerate | where {|r| ($r.item | str trim) == $ende}  | get index)
    let ohne = (if (($a | is-empty) or ($b | is-empty)) { $zeilen } else {
        ($zeilen | first ($a | first)) ++ ($zeilen | skip (($b | last) + 1))
    })
    let rumpf = ($ohne | str join "\n" | str trim --right)
    let kopf = (if ($rumpf | is-empty) { [] } else { [$rumpf ""] })
    $kopf ++ [$start $inhalt $ende ""] | str join "\n" | save -f $datei
    print $"($datei): Block '($marke)' geschrieben"
}
```

Blockinhalt (Marke `noctarow:umgebung`):

```nu
$env.EDITOR = "/home/linuxbrew/.linuxbrew/bin/hx"
$env.VISUAL = $env.EDITOR
$env.SUDO_EDITOR = $env.EDITOR

# Sway unter WSLg starten und das Terminal sofort freigeben
def sway-start [] {
    let protokoll = ($nu.home-dir | path join ".local/state/sway.log")
    mkdir ($protokoll | path dirname)
    with-env {
        WLR_RENDERER: "pixman"
        WLR_NO_HARDWARE_CURSORS: "1"
        XDG_CURRENT_DESKTOP: "sway"
        XDG_SESSION_TYPE: "wayland"
        XDG_SESSION_DESKTOP: "sway"
    } {
        ^setsid --fork sway out+err> $protokoll
    }
    print $"sway abgekoppelt — Protokoll: ($protokoll)"
}

def sway-log [--zeilen: int = 40] {
    open ($nu.home-dir | path join ".local/state/sway.log") | lines | last $zeilen
}

# ensure-block: siehe oben — vorläufig hier, Ziel ist scripts/noctarow.nu
```

> [!important] Entscheidung: `setsid --fork` statt Hintergrund-Job oder systemd
> Gemessen: Shell nach **6 ms** wieder frei, Protokoll füllt sich über
> vererbte Dateideskriptoren weiter. `setsid --fork` legt eine neue
> Session an und koppelt vom Terminal ab; Terminal schließen reißt Sway
> nicht mehr mit.
>
> **Preis:** kein Exit-Code mehr. `sway-log` ist der einzige Rückkanal —
> nach jeder Config-Änderung beide Befehle nacheinander.
>
> **Verworfene Alternative** (`entwurf`): `systemd-run --user` mit
> Journal-Anbindung. Ungeprüft, ob der User-Manager unter WSL
> `WAYLAND_DISPLAY`/`XDG_RUNTIME_DIR` korrekt sieht — die Variablen
> kommen aus der Shell, nicht aus dem Manager. Erst
> `systemctl --user show-environment` messen.

> [!note] Entscheidung: `ensure-block` nur vorläufig in `config.nu`
> Es ist ein Werkzeug, kein Umgebungseintrag. Zielort:
> `scripts/noctarow.nu` als `export def` — dort auch für die
> Drop-in-Erzeugung unter `/etc/sway/config.d/` nutzbar. In `config.nu`
> steht es nur, bis das Projektverzeichnis auf dem XPS existiert.

---

## 6 — Prüfwerkzeuge (alle gegen 0.114.1 verifiziert) ✅

### Benutzerdefinierte Befehle auflisten

```nu
scope commands | where type == "custom" | select name description
```

> [!note] `banner` und `pwd` sind immer dabei
> Beide sind bei Nushell selbst `def`-Definitionen — eigene Befehle
> stehen also nie allein in der Liste.

### Nur die eigenen (Abgleich gegen `config.nu`/`env.nu`)

```nu
let meine = (
    [$nu.config-path, $nu.env-path]
    | each {|f| open --raw $f | parse --regex '(?m)^\s*(?:export\s+)?def\s+(?:--env\s+)?"?(?<name>[^"\s\[]+)' | get name}
    | flatten | uniq
)
scope commands | where type == "custom" and name in $meine | select name
```

### Gezielt prüfen, ob etwas geladen ist

```nu
["sway-start" "sway-log" "ensure-block"]
| each {|c| {befehl: $c, geladen: ($c in (scope commands | get name))} }
```

Live-Befund auf dem XPS: `sway-start`/`sway-log` `true`,
`ensure-block` zunächst `false` — REPL-Definitionen überleben `exec nu`
nicht. Genau dafür ist die Prüfung da.

### Geladenen Quelltext gegen die Datei halten

```nu
view source sway-start    # weicht er von config.nu ab → alte Session
scope modules | select name commands | where name =~ "noctarow"
```

---

## 7 — Offene Punkte

- [ ] `20-wslg.conf` mit `$term`/`$menu`-Bindings live testen: reagiert
      Alt+Enter, startet rofi auf Alt+D? (→ 1.4 von 🟡 auf ✅)
- [ ] `sway-start` erster echter Lauf + `sway-log` gegenlesen
- [ ] `grim`-Messung: meldet WSLg native oder vorskalierte Pixel? (→ 2.4;
      Ergebnis nach [[05-hidpi-und-monitore]])
- [ ] CapsLock-als-Super mit `wev` verifizieren (→ 1.6)
- [ ] `sudoedit`-Weg einmal durchspielen; falls `vi` startet:
      `env_editor` prüfen (→ 3.2)
- [ ] Helix-Theme sichtbar bestätigen; `COLORTERM`-Test im Windows
      Terminal (→ 4.3)
- [ ] Entscheidung 899-Zeilen-`config.nu`: durchsehen, dann leerer Start
      (→ 5.5)
- [ ] `~/projekte/noctarow` anlegen → `const`+`use`-Zeile zurück,
      `ensure-block` nach `scripts/noctarow.nu` umziehen
- [ ] `noctarow doc-check`: alle `nu`-Codeblöcke im Vault gegen die
      lokale Version durch `nu-check` + `$nu`-Feldabgleich schicken
- [ ] Versionsangabe (`verifiziert_gegen: nushell X.Y`) in allen
      Vault-Notizen mit `nu`-Blöcken nachtragen

---

## Kernaussagen in vier Sätzen

Sway expandiert Variablen beim Parsen — `set $mod` in einem Drop-in
hinter Zeile 228 ändert keine Default-Bindings, macht aber die dort
definierten `$term`/`$menu` nutzbar. `nu-check` beweist Parsebarkeit,
nicht Lauffähigkeit: `$nu.home-path` besteht die Prüfung und fällt beim
Start, weil 0.114 das Feld in `home-dir` umbenannt hat. Relative
`use`-Pfade gelten relativ zur Datei, nicht zum Arbeitsverzeichnis, und
ein Parse-Fehler verwirft die gesamte `config.nu` samt aller gültigen
Zeilen davor. Brew-Binaries sind unter `sudo` unsichtbar und müssen es
bleiben — `sudoedit` ist der Weg.
