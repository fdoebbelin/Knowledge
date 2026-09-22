---
title: XPS 13 — Fedora-WSL mit Sway und Noctalia (Installationsanleitung)
aliases:
  - Sway-Noctalia-Installation
  - WSL-Werkbank-Kurzweg
teil_von: "[[README]]"
tags:
  - wsl
  - wslg
  - fedora
  - sway
  - noctalia
  - quickshell
  - terra
  - homebrew
  - nushell
  - installation
zielgeraet: Dell XPS 13 9345 (Snapdragon X Elite, aarch64), FedoraLinux-44 WSL
hintergrund: "[[00 xps13-fedora-wsl-sway-noctalia]]"
created: 2026-08-17
verifiziert_gegen: Nushell 0.114.1, Noctalia v4.7.7 (Schema 59)
status: active
type: anleitung
---

# XPS 13 — Fedora-WSL mit Sway und Noctalia: Installation

Der lineare Weg vom leeren WSL-Import bis zur laufenden Noctalia-Bar.
Elf Schritte, jeder mit einer Kontrolle am Ende.

Begründungen, Fehlergeschichte, verworfene Alternativen und
Problemdiskussion stehen im Langdokument
[[00 xps13-fedora-wsl-sway-noctalia]]. Hier steht nur, was zu tun ist — und
in genau der Reihenfolge, in der es funktioniert.

> [!important] Zwei Reihenfolgen-Fallen, an denen der erste Durchlauf scheiterte
> 1. **Nushell existiert erst ab Schritt 4.** Die Schritte 1–3 sind
>    zwingend Bash; `nu` wird in Schritt 3 von brew installiert.
> 2. **Die Session-Funktionen müssen *vor* dem ersten Sway-Start
>    dauerhaft in `config.nu` stehen** (Schritt 6). Nur ins REPL getippt
>    sind sie nach dem nächsten Terminal weg — und dann fehlt genau das
>    Werkzeug, mit dem man eine hängende Sitzung wieder loswird.
>
> Codeblöcke sind Nushell, außer sie sind als ```` ```bash ````
> gekennzeichnet.

> [!note] Was bis Schritt 9 sichtbar ist — und was nicht
> Das WSLg-Fenster bleibt bis zum ersten Terminal **schwarz und leer**,
> und die Leiste erscheint erst mit dem Autostart in Schritt 9. Das ist
> kein Fehler, sondern die Folge von `bar mode invisible` und einer
> Sitzung ohne Client. Ab Schritt 7 gibt es mit `Alt+Return` ein
> foot-Fenster — das ist die erste sichtbare Ausgabe. Vorher wird
> ausschließlich über `swaymsg` und die Protokolldatei geprüft, nicht
> mit dem Auge.

---

## Schritt 0 — WSL-Import und Benutzerpasswort *(Windows / Bash)*

```powershell
wsl --list --online
wsl --install FedoraLinux-44
```

Die Distro legt beim ersten Start einen Benutzer an, **vergibt aber kein
Passwort**. Ohne Passwort scheitert jedes `sudo` ab Schritt 1:

```bash
sudo passwd $USER
```

Verweigert `sudo` bereits das, ist das Konto gesperrt — dann über den
Root-Einstieg auf der Windows-Seite, der ohne Authentifizierung
funktioniert:

```powershell
wsl -d FedoraLinux-44 --user root
```

Darin `passwd <benutzername>`, dann `exit`.

**Kontrolle:**

```bash
sudo -v && echo "sudo funktioniert"
```

---

## Schritt 1 — dnf-Systemschicht *(Bash)*

Alles, was setuid-Helfer, User-Namespaces, systemd-Units oder udev-Regeln
braucht, kommt aus dnf — Homebrew kann diese Schichten nicht bedienen.

```bash
system=(
    @development-tools procps-ng curl file git-core
    containers-common podman buildah skopeo
    wl-clipboard
)
sudo dnf install -y "${system[@]}"
```

**Kontrolle** — dem Exit-Code von `dnf` nicht glauben, `rpm -q` pro Paket:

```bash
for p in podman buildah skopeo containers-common git-core; do
    if rpm -q "$p" >/dev/null 2>&1; then echo "ok    $p"; else echo "FEHLT $p"; fi
done
```

---

## Schritt 2 — Homebrew *(Bash)*

```bash
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew-install.sh
head -3 /tmp/brew-install.sh
/bin/bash /tmp/brew-install.sh
```

PATH für Bash eintragen und sofort aktivieren:

```bash
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

**Kontrolle:**

```bash
command -v brew && brew --version
```

---

## Schritt 3 — brew-Userland *(Bash)*

```bash
brew install --dry-run nushell helix jq    # auf aarch64: Bottle oder Quelltext-Bau?
brew install nushell helix jq
```

**Kontrolle:**

```bash
command -v nu hx jq
nu --version
```

Ab hier ist `nu` verfügbar; alles Weitere ist Nushell.

---

## Schritt 4 — Nushell einrichten

Erster Start (legt `env.nu` und `config.nu` an):

```bash
nu
```

### 4a — `ensure-block` verankern

Jede weitere Konfigurationsänderung läuft über diesen Helfer: Er ersetzt
den Block zwischen seinen Markern, statt anzuhängen. Zwei Läufe erzeugen
ein Markerpaar. Er selbst muss einmal von Hand hinein:

```nu
if not (open --raw $nu.config-path | str contains "def ensure-block") {
    r##'# >>> noctarow:werkzeuge >>>
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
# <<< noctarow:werkzeuge <<<
'## | save -a $nu.config-path
} else {
    print "ensure-block ist bereits in config.nu"
}

nu-check $nu.config-path
exec nu
```

### 4b — brew-Umgebung für Nushell

Nushell liest weder `~/.bashrc` noch `/etc/profile.d/*.sh`; der Eintrag
aus Schritt 2 hilft ihm nicht.

```nu
ensure-block $nu.env-path "noctarow:brew" (
    r##'$env.PATH = ($env.PATH | prepend [
    "/home/linuxbrew/.linuxbrew/bin"
    "/home/linuxbrew/.linuxbrew/sbin"
])
$env.HOMEBREW_PREFIX = "/home/linuxbrew/.linuxbrew"
$env.HOMEBREW_CELLAR = "/home/linuxbrew/.linuxbrew/Cellar"
$env.HOMEBREW_REPOSITORY = "/home/linuxbrew/.linuxbrew/Homebrew"'##
)

nu-check $nu.env-path
exec nu
```

### 4c — Terminal-Zuordnung

Die Login-Shell bleibt Bash (Interop, VS-Code-Remote); Nushell wird dem
Terminal zugeordnet:

```nu
mkdir ~/.config/foot
r#'[main]
shell=/home/linuxbrew/.linuxbrew/bin/nu
font=monospace:size=11
'# | save -f ~/.config/foot/foot.ini
```

**Kontrolle:**

```nu
"ensure-block" in (scope commands | get name)      # → true
which brew nu hx
$env.PATH | where {|p| $p =~ "linuxbrew"}          # genau zwei Eintraege
```

---

## Schritt 5 — Sway-Pakete

```nu
let sway_pakete = [
    sway sway-config-fedora sway-systemd foot
    grim slurp mako brightnessctl playerctl
    pipewire wireplumber xdg-desktop-portal-wlr
    google-noto-sans-fonts fontawesome-fonts
]
sudo dnf install -y ...$sway_pakete
```

**Kontrolle** — rofi kommt als Abhängigkeit von `sway-config-fedora`:

```nu
[sway rofi-wayland foot] | each {|p| {paket: $p, da: ((rpm -q $p | complete).exit_code == 0)} }
ls /usr/share/sway/config.d/ | get name
```

---

## Schritt 6 — Session-Funktionen dauerhaft machen

**Vor** dem ersten Sway-Start, nicht danach. Ohne `sway-stop` in der
Konfiguration steht man bei der ersten hängenden Sitzung ohne Werkzeug da.

```nu
ensure-block $nu.config-path "noctarow:umgebung" (
    r##'$env.EDITOR = "/home/linuxbrew/.linuxbrew/bin/hx"
$env.VISUAL = $env.EDITOR
$env.SUDO_EDITOR = $env.EDITOR

def sway-protokolle [] {
    glob ($nu.home-dir | path join ".local/state/sway-*.log") | sort
}

# Startet Sway abgekoppelt. Verweigert den Start bei laufender Instanz --
# mehrere Instanzen teilen sich sonst Output und Logdatei.
def sway-start [] {
    let laufend = (ps | where name == "sway" | get pid)
    if ($laufend | is-not-empty) {
        error make {msg: $"sway laeuft bereits: ($laufend | str join ', ') — erst sway-stop"}
    }
    let ts = (date now | format date "%Y%m%d-%H%M%S")
    let protokoll = ($nu.home-dir | path join $".local/state/sway-($ts).log")
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

def sway-log [--zeilen: int = 40, --alles] {
    let dateien = (sway-protokolle)
    if ($dateien | is-empty) { error make {msg: "kein Protokoll gefunden"} }
    open --raw ($dateien | last)
    | lines
    | where {|z| $alles or ((($z | str trim) != "") and ($z !~ "Circular avatars|inputDirection|weather without coordinates")) }
    | last $zeilen
}

# SIGTERM zuerst: Sway meldet sich bei WSLg ab und gibt seine Flaeche frei.
# kill --force hinterlaesst Weston in einem Zustand, den nur wsl --shutdown loest.
def sway-stop [] {
    let pids = (ps | where name =~ "^(sway|qs|waybar|swayidle|mako|kanshi)$" | get pid)
    if ($pids | is-empty) { print "nichts zu beenden"; return }
    $pids | each {|p| kill $p } | ignore
    sleep 3sec
    let uebrig = (ps | where pid in $pids | get pid)
    if ($uebrig | is-not-empty) {
        print $"unwillig, SIGKILL: ($uebrig | str join ', ')"
        $uebrig | each {|p| kill --force $p } | ignore
        sleep 1sec
    }
    glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | each {|s| rm $s } | ignore
    ls $env.XDG_RUNTIME_DIR
    | where {|f| ($f.name | path basename) =~ '^wayland-[1-9]\d*(\.lock)?$'}
    | each {|f| rm $f.name } | ignore
    print $"beendet: ($pids | str join ', ')"
}'##
)

nu-check $nu.config-path
exec nu
```

**Kontrolle** — geladen *und* dauerhaft, das sind zwei Dinge:

```nu
["sway-start" "sway-stop" "sway-log"] | each {|c| {befehl: $c, geladen: ($c in (scope commands | get name))} }
view source sway-start | lines | find "sway-"                        # Zeitstempel-Pfad
open --raw $nu.config-path | lines | where {|z| $z =~ "noctarow:umgebung"} | length   # → 2
```

---

## Schritt 7 — Sway-Drop-in und erster Start

Das Drop-in nach `/etc/sway/config.d/` — dieselbe Kette wie im Image.

```nu
r##'# WSLg-Host: Sway als Wayland-Client
output WL-1 resolution 1920x1200 scale 1

input type:keyboard {
    xkb_layout "de"
    xkb_variant "nodeadkeys"
}

# Windows faengt Super ab. set $mod wirkt nur auf bindsym-Zeilen UNTERHALB
# dieser Zeile — die Defaults aus /etc/sway/config bleiben auf Mod4,
# deshalb stehen alle benoetigten Bindings hier vollstaendig.
# $term, $menu, $left ... stammen aus /etc/sway/config und sind hier da.
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

xwayland disable
'## | save -f /tmp/20-wslg.conf

sudo cp /tmp/20-wslg.conf /etc/sway/config.d/20-wslg.conf
sway --validate --config /etc/sway/config
```

Erster Start:

```nu
sway-start
sleep 3sec
sway-log
```

> [!important] Das Fenster ist jetzt schwarz — das ist richtig so
> `bar mode invisible` schaltet die Sway-Bar ab, Noctalia läuft noch
> nicht, und es ist kein Client offen. Es gibt nichts zu sehen. Die
> Sitzung beweist man an dieser Stelle über `swaymsg`, nicht mit dem
> Auge. **Die erste sichtbare Ausgabe holt man sich selbst:** WSLg-Fenster
> anklicken, dann `Alt+Return` — es öffnet ein foot-Fenster mit Nushell.
> (Alt, nicht Super: Windows fängt die Super-Taste ab.)

**Kontrolle:**

```nu
swaymsg -t get_outputs | from json | select name current_mode scale
swaymsg -t get_inputs  | from json | where type == "keyboard" | select identifier xkb_active_layout_name
ps | where name =~ '^(sway|waybar)$' | select pid ppid name
```

Erwartet: Output `WL-1` mit 1920×1200 und `scale 1`, Layout `German`,
genau **eine** Sway-Instanz. Reagiert `Alt+Return` nicht, das Binding
live gegenprüfen — das umgeht die ganze Konfigurationskette:

```nu
swaymsg 'bindsym Mod1+Return exec foot'
```

---

## Schritt 8 — Noctalia installieren

### 8a — Terra-Repo, defensiv eingetragen

`enabled=0` und `excludepkgs=terra-obsolete`: Terra soll nur dann
mitreden, wenn es ausdrücklich gefragt wird.

```nu
r#'[terra]
name=Terra $releasever
baseurl=https://repos.fyralabs.com/terra$releasever
type=rpm
skip_if_unavailable=False
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://repos.fyralabs.com/terra$releasever/key.asc
enabled=0
enabled_metadata=1
metadata_expire=4h
excludepkgs=terra-obsolete
'# | save -f /tmp/terra.repo

sudo cp /tmp/terra.repo /etc/yum.repos.d/terra.repo
sudo dnf --enable-repo=terra makecache
```

**Vorprüfung aarch64** — leere Ausgabe heißt: hier abbrechen.

```nu
dnf --enable-repo=terra repoquery --queryformat '%{name}-%{version} %{arch} %{reponame}\n' noctalia-shell noctalia-qs
```

### 8b — Installation

`quickshell` **nicht** zusätzlich installieren; es kollidiert mit
`noctalia-qs`.

```nu
sudo dnf --enable-repo=terra install --assumeno noctalia-shell    # Vorschau
```

In der Vorschau prüfen: Wie viele Pakete kommen aus `terra`? Stehen
`qt6-*` unter „upgrading"? Die Zeile „replacing/obsoleting" muss leer
sein. Erst dann:

```nu
sudo dnf --enable-repo=terra install noctalia-shell
sudo dnf install matugen cliphist wl-clipboard        # Laufzeit-Nachbarn, aus Fedora
```

**Kontrolle:**

```nu
["noctalia-shell" "noctalia-qs" "quickshell" "mesa-dri-drivers"]
| each {|p| {paket: $p, da: ((rpm -q $p | complete).exit_code == 0)} }
which -a qs
glob /usr/lib64/dri/*.so | path basename | where {|n| $n =~ "swrast"}   # llvmpipe muss da sein
```

---

## Schritt 9 — Noctalia zum Laufen bringen

### 9a — Handstart zur Prüfung

Noctalia muss **als Kind von Sway** starten, sonst landet es auf WSLgs
eigenem Compositor und bekommt keine Layer-Shell — also keine Bar.
`LIBGL_ALWAYS_SOFTWARE=1`, weil Quickshell ein Qt-Client ist und ohne
Render-Node über llvmpipe rendern muss.

```nu
let sock = (glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | first)
with-env { SWAYSOCK: $sock } {
    swaymsg exec -- env LIBGL_ALWAYS_SOFTWARE=1 qs -c noctalia-shell
}

sleep 5sec
ps | where name =~ '^(sway|qs|waybar)$' | select pid ppid name
```

Erwartet: ein `sway`, ein `qs` als dessen Kind, **kein** `waybar`. Die
Bar ist jetzt sichtbar.

**Kontrolle, dass die Anbindung wirklich steht** — muss `0` liefern:

```nu
open --raw (sway-protokolle | last)
| lines | where {|z| $z =~ '(?i)layershell|eglSwapBuffers'} | length
```

Steht dort etwas, hat sich Noctalia mit dem falschen Compositor
verbunden. Im Protokoll steht dann `Starting scan for rdp-0` statt
`WL-1`.

### 9b — Kollisionen abschalten

Fedora startet über eigene Drop-ins `waybar` und `swayidle`; beide
streiten mit Noctalia. Eine **leere** gleichnamige Datei in `/etc`
verdrängt die aus `/usr/share`.

```nu
["90-bar.conf" "90-swayidle.conf"] | each {|n| "" | sudo tee $"/etc/sway/config.d/($n)" | ignore }
```

`mako` bleibt installiert, darf aber nicht starten — beide greifen nach
`org.freedesktop.Notifications`, der Erste gewinnt.

### 9c — Autostart-Drop-in

`exec`, nicht `exec_always`: Letzteres startet bei jedem `swaymsg
reload` eine weitere Instanz.

```nu
[
    "# Noctalia unter WSLg: Software-GL, weil kein Render-Node existiert."
    "# QT_SCALE_FACTOR skaliert Text UND Tabler-Icons -- Noctalias eigene"
    "# fontScale-Werte greifen nur auf die Textfamilie."
    "exec env LIBGL_ALWAYS_SOFTWARE=1 QT_SCALE_FACTOR=1.3 qs -c noctalia-shell"
    ""
] | str join "\n" | save -f /tmp/95-noctalia.conf

sudo cp /tmp/95-noctalia.conf /etc/sway/config.d/95-noctalia.conf
sway --validate --config /etc/sway/config
```

**Kontrolle** — vollständiger Neustart, weil `reload` kein `exec`
auslöst:

```nu
sway-stop
sway-start
sleep 8sec
ps | where name =~ '^(sway|qs|waybar)$' | select pid ppid name
```

Erwartet: `sway`, `qs` als dessen Kind, kein `waybar`, kein `swayidle`.
Die Leiste steht jetzt ohne Handstart.

---

## Schritt 10 — Noctalia abstimmen

Handeditieren nur bei **beendeter** Shell — Noctalia schreibt die Datei
sonst zurück.

```nu
sway-stop
let cfg = ($nu.home-dir | path join ".config/noctalia/settings.json")
cp $cfg $"($cfg).bak-(date now | format date '%Y%m%d-%H%M')"

open $cfg
| update general.enableBlurBehind false     # Sway kann ext-background-effect-v1 nicht
| update general.enableShadows false        # unter Software-Rendering teuer
| update general.animationSpeed 0.5
| update general.lockOnSuspend false        # WSL meldet falsche Resumes; Polkit fehlt
| update general.scaleRatio 1.3             # im Einstellungspanel nicht bedienbar
| update bar.fontScale 1                    # sonst multipliziert sich das mit QT_SCALE_FACTOR
| update ui.fontDefaultScale 1
| save -f $cfg

open $cfg | get general.scaleRatio          # zugleich JSON-Syntaxprobe
sway-start
```

Bereits sinnvoll voreingestellt und nicht anzufassen:
`noctaliaPerformance.disableWallpaper`, `disableDesktopWidgets`,
`ui.translucentWidgets`, `general.telemetryEnabled`.

Optional, falls `Could not load icon` im Protokoll steht:

```nu
touch ($nu.home-dir | path join ".face")
```

---

## Schritt 11 — Abschlussprüfung

```nu
# Genau eine Instanz, richtige Eltern-Kind-Beziehung
ps | where name =~ '^(sway|qs|waybar)$' | select pid ppid name

# Layer-Shell-Anbindung: muss 0 liefern
open --raw (sway-protokolle | last) | lines
| where {|z| $z =~ '(?i)layershell|eglSwapBuffers'} | length

# Output
with-env { SWAYSOCK: (glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | first) } {
    swaymsg -t get_outputs | from json | select name current_mode scale
}

# Include-Kette: /etc muss 90-bar und 90-swayidle stellen, nicht /usr/share
open --raw (glob $"($env.XDG_RUNTIME_DIR)/sway/*" | first) | lines

# Sockets: nur wayland-0 (WSLg) und genau ein wayland-N (Sway)
ls $env.XDG_RUNTIME_DIR | get name | path basename | where {|n| $n =~ '^wayland-'}

# Terra darf im Alltag nicht mitreden
open /etc/yum.repos.d/terra.repo | lines | where {|z| $z =~ '^enabled='}

# IPC der Shell
qs -c noctalia-shell ipc show
```

---

## Wenn etwas hängt

| Symptom | Ursache | Vorgehen |
|---|---|---|
| Fenster bleibt leer, `grim` blockiert, `Didn't receive frame callback` | WSLgs Weston ist nach `SIGKILL` verklemmt | auf der Windows-Seite `wsl --shutdown` — nur das hilft |
| „sway laeuft bereits" | Altinstanz | `sway-stop`, dann neu |
| Keine Taste reagiert | Bindings hängen noch an Super | `swaymsg 'bindsym Mod1+Return exec foot'` gegenprüfen |
| Bar erscheint nicht, `eglSwapBuffers failed` im Protokoll | Noctalia hängt an WSLg statt an Sway | über `swaymsg exec` starten (9a) |
| `sudo hx` → command not found | `secure_path` kennt den brew-Pfad nicht | `sudoedit` statt `sudo hx` |
| Flatpaks fehlen im Launcher | `XDG_DATA_DIRS` ohne Exports-Pfad | Nushell liest kein `/etc/profile.d` → Eintrag in `env.nu` |

`sway-stop` ist immer der erste Griff, `wsl --shutdown` der zweite. Nie
mit `kill --force` von Hand nachhelfen.

---

## Was hier bewusst fehlt

Begründungen und Alternativen, die Fehlergeschichte der sieben Blocker,
die widerlegten Annahmen (Schriften, Wallpaper, Icon-Theme), die Grenzen
der Umgebung, Nushell-Syntaxfallen, Helix-Konfiguration, Flatpak/Obsidian
und Bazaar: alles in [[00 xps13-fedora-wsl-sway-noctalia]].
