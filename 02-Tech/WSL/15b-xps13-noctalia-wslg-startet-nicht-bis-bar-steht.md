---
title: XPS 13 — Noctalia unter WSLg zum Laufen bringen
aliases: [Noctalia-WSL, Quickshell-unter-Sway, Runde-2]
teil_von: "[[README]]"
tags: [wsl, wslg, sway, noctalia, quickshell, flatpak, obsidian, nushell, xps13]
zielgeraet: Dell XPS 13 9345 (Snapdragon X Elite, aarch64), FedoraLinux-44 WSL
created: 2026-08-02
verifiziert_am: 2026-08-02
status: verifiziert
---

# 15 — Noctalia unter WSLg: von „startet nicht" bis „Bar steht"

Schließt den offenen Punkt aus [[13-xps13-wsl-installation#Offene Punkte]] und
baut auf [[14-xps13-wslg-sway-nushell-runde1]] auf. Endzustand: **Noctalia
v4.7.7 läuft unter Sway unter WSLg**, mit Autostart, Flatpak-Unterbau und
Obsidian.

> [!info] Statuslegende
> **✅ verifiziert** — an diesem Gerät gemessen · **🟡 hergeleitet** ·
> **❌ widerlegt** — Annahme, die sich als falsch erwies
>
> Diese Notiz dokumentiert **auch die Irrwege**. Drei Annahmen sind unterwegs
> gefallen; sie stehen hier, damit sie nicht wiederkehren.

---

## Kurzfassung — der Weg, der funktioniert

```nu
# 1. Voraussetzung: genau eine Sway-Instanz, sauber gestartet
sway-stop
sway-start

# 2. Noctalia ALS KIND VON SWAY starten — nicht aus dem WSL-Einstiegsprompt
let sock = (glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | first)
with-env { SWAYSOCK: $sock } {
    swaymsg exec -- env LIBGL_ALWAYS_SOFTWARE=1 qs -c noctalia-shell
}

# 3. Kontrolle
ps | where name =~ '^(sway|qs|waybar)$' | select pid ppid name
```

Erwartet: genau ein `sway`, ein `qs` als dessen Kind, **kein** `waybar`.

Dauerhaft übernimmt das ein Drop-in (Abschnitt 6).

---

## 1 — Die zwei Fehler, die alles blockierten

### 1.1 Noctalia landet auf WSLg statt auf Sway ✅

Aus dem WSL-Einstiegsprompt gestartet, verbindet sich Quickshell mit **WSLgs
eigenem Weston**, nicht mit Sway. Vier Belege im Log, alle gleichzeitig:

| Logzeile | Bedeutung |
|---|---|
| `Wallpaper Starting scan for rdp-0` | `rdp-0` ist WSLgs Output; Sway heißt `WL-1` |
| `Using generic ext-workspace backend (no recognized compositor env)` | kein `SWAYSOCK` in der Umgebung |
| `WARN: Failed to initialize layershell integration` | Weston kennt `zwlr_layer_shell_v1` nicht |
| `Cannot create idle monitor as ext-idle-notify-v1 is not supported` | dito |

Und als Folgefehler:

```
WARN qt.qpa.wayland: eglSwapBuffers failed with 0x300d, surface: 0x0
```

`0x300d` ist `EGL_BAD_SURFACE` bei Surface `0x0` — **kein GL-Problem**. Die Bar
hat nie eine Fläche bekommen, weil die Layer-Shell-Anmeldung scheiterte.
Noctalias Panels sind Layer-Shell-Flächen; ohne das Protokoll gibt es
prinzipiell keine Bar.

> [!success] Lösung
> Über `swaymsg exec` starten. Der Prozess erbt dann `WAYLAND_DISPLAY` **und**
> `SWAYSOCK` von Sway. Ein foot-Fenster *innerhalb* der Sitzung tut es auch,
> aber `swaymsg exec` hat den Vorteil, dass die Ausgabe in Sways Log landet und
> man in der eigenen Nushell mit Historie bleibt.

Beweis, dass es geklappt hat — eine Zeile:

```nu
open --raw (glob ($nu.home-dir | path join ".local/state/sway-*.log") | sort | last)
| lines
| where {|z| $z =~ '(?i)layershell|eglSwapBuffers'}
| length
```

`0` → Anbindung steht. Und im Log steht dann `Starting scan for **WL-1**`.

### 1.2 `WLR_RENDERER=pixman` hilft Noctalia nicht ✅

> [!danger] Der teuerste Denkfehler dieser Runde
> `WLR_RENDERER` steuert **wlroots**, also Sway selbst. Quickshell ist ein
> gewöhnlicher Wayland-**Client** auf Qt6/QtQuick und ignoriert jedes `WLR_*`
> vollständig. QtQuick rendert über OpenGL — und auf diesem Gerät gibt es
> keinen Render-Node (`/dev/dri` fehlt, aus `/dev/dxg` entsteht ohne
> `d3d12`-Gallium-Treiber keiner, siehe [[01-erkenntnisse#Umgebungsbefunde WSL]]).

Zwei Wege, **nicht** gleichwertig:

| | A: llvmpipe ✅ | B: Qt-Quick-Software |
|---|---|---|
| Variable | `LIBGL_ALWAYS_SOFTWARE=1` | `QT_QUICK_BACKEND=software` |
| Was rendert | Mesas Software-GL, **voller** GL-Pfad | Qts 2D-Rasterizer |
| Shader / `ShaderEffect` | funktionieren | funktionieren **nicht** |
| Aussagekraft fürs Image | brauchbar | gering |

**Weg A genügt.** Bestätigt durch das Log:

```
DEBUG qt.qpa.wayland: Available client buffer integrations: QList("wayland-egl")
DEBUG qt.qpa.wayland: Using Wayland-EGL
```

Weg B wurde nie gebraucht und bleibt in der Schublade.

---

## 2 — Werkzeugkette härten

Die drei Funktionen aus [[14-xps13-wslg-sway-nushell-runde1#5.6]] brauchten
Nachbesserung. Ohne sie ist der Rest nicht reproduzierbar.

### 2.1 Was schiefging ✅

**Instanzenstau.** `setsid --fork` schützt Sway davor, dass das *Terminal* es
mitreißt — nicht davor, dass ein weiterer `sway-start` eine zweite Instanz
anlegt. Zeitweise liefen **fünf** parallel:

```
sway 1536 → waybar, swayidle
sway 1707 → waybar, swayidle
sway 1940 → qs
sway 2475, 2825 → (nichts)
```

Symptom im Log: `Another session found; refusing to overwrite the variables`.

**Sparse-Löcher im Log.** `out+err> $protokoll` kürzt die Datei bei jedem Start
auf null. Eine noch laufende Altinstanz hält aber ihren Dateideskriptor mit
altem Offset und schreibt bei Byte 40.000 weiter — der Kernel füllt den Bereich
davor mit Nullbytes. Ergebnis: 110 leere Zeilen im Log.

```nu
^du -h --apparent-size ~/.local/state/sway-*.log
^du -h ~/.local/state/sway-*.log
```

Stark abweichende Werte → Sparse-Datei bestätigt.

### 2.2 Die harte Lehre: `kill --force` verklemmt WSLg ✅

> [!danger] Fünf `SIGKILL`s später rendert WSLg gar nichts mehr
> Nach einer Serie erzwungener Abbrüche zeigte das WSLg-Fenster **keinen
> Inhalt** — kein Sway-Hintergrund, kein foot, nichts. `grim` blockierte
> endlos, weil kein Frame mehr kam. Im Log:
> `Didn't receive frame callback in time, window should now be inexposed`.
>
> Ursache: WSLgs Weston räumt nach `SIGKILL` nicht sauber ab und liefert Sways
> Fenster keine Frame-Callbacks mehr. Der Zustand lebt in der
> **WSLg-System-Distro** und überdauert jeden Neustart der Fedora-Distro.
>
> **Einziger Ausweg** — auf der Windows-Seite:
> ```nu
> wsl --shutdown
> ```
> Danach funktionierte alles auf Anhieb. Die Diagnose war eindeutig: `foot`
> erschien wieder, ohne dass an Sway oder Noctalia irgendetwas geändert wurde.

**Konsequenz:** `sway-stop` muss SIGTERM vor SIGKILL setzen.

### 2.3 Die aktuelle Fassung ✅

Gehört zwischen die Marker `# >>> noctarow:umgebung >>>` / `# <<<` in
`config.nu`:

```nu
def sway-protokolle [] {
    glob ($nu.home-dir | path join ".local/state/sway-*.log") | sort
}

# Startet Sway abgekoppelt. Verweigert den Start bei laufender Instanz --
# mehrere Instanzen teilen sich sonst Output und Logdatei (Sparse-Loecher).
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
    | where {|z| $alles or (($z !~ "Circular avatars|inputDirection|weather without coordinates") and (($z | str trim) != "")) }
    | last $zeilen
}

# SIGTERM zuerst: Sway meldet sich bei WSLg ab und gibt seine Flaeche frei.
# kill --force hinterlaesst Weston in einem Zustand, den nur 'wsl --shutdown' loest.
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
}
```

> [!important] Wayland-Sockets mit aufräumen
> Nach `SIGKILL` bleiben `wayland-1` … `wayland-5` liegen. Ein `glob … | first`
> greift dann **alphabetisch den ersten**, nicht den aktuellen — man spricht
> gegen eine Leiche. `wayland-0` bleibt bewusst ausgenommen: der gehört WSLg.
> Die `.lock`-Dateien müssen mit weg, sonst überspringt der nächste Compositor
> die Nummer.

Beweis nach dem Einbau:

```nu
exec nu
view source sway-start | lines | find "sway-"     # muss den Zeitstempel-Pfad zeigen
```

> [!warning] REPL-Definitionen überleben nichts
> Wird die Funktion nur in die laufende Shell getippt, ist sie beim nächsten
> Terminal weg — und der alte Stand aus `config.nu` greift wieder. Derselbe Fall
> wie in [[14-xps13-wslg-sway-nushell-runde1#6]]; hat hier mehrere Durchläufe
> gekostet.

---

## 3 — Xwayland und Polkit

### 3.1 Xwayland startet nicht ✅

```
[wlr] /tmp/.X11-unix is not a directory        (33×)
[wlr] No display available in the first 33
[sway/server.c:517] Failed to start Xwayland
```

Der Pfad **existiert schlicht nicht** — geprüft:

```nu
"/tmp/.X11-unix" | path exists      # false
```

wlroots meldet „is not a directory" auch bei `ENOENT` und probiert Display 0–32
durch. Für die Werkbank ist Xwayland verzichtbar (Sway und Noctalia sind reines
Wayland):

```nu
"\nxwayland disable\n" | sudo tee -a /etc/sway/config.d/20-wslg.conf | ignore
sway --validate --config /etc/sway/config
```

Spart 33 Fehlzeilen. **Preis:** X11-Anwendungen laufen nicht mehr — relevant für
Electron-Apps, siehe Abschnitt 8. Im Image bleibt Xwayland selbstverständlich an.

### 3.2 Polkit: der Preis von `setsid --fork` ✅

```
[Line 446] Failed to find session
CRITICAL: polkit_agent_listener_register_with_options: assertion 'POLKIT_IS_SUBJECT (subject)' failed
INFO:assign-cgroups:compositor:5117 /init.scope
```

`loginctl list-sessions` zeigt durchaus Sitzungen (`c1`, `c2`), aber die Spalte
`SEAT` ist leer — und entscheidend: Sway sitzt in **`/init.scope`**, nicht in
einem `session-c*.scope`. Das ist die direkte Folge von `setsid --fork`: die
neue Session koppelt den Compositor von der logind-Sitzung ab.

Ausgelöst wird die Meldung von
`/usr/share/sway/config.d/95-autostart-policykit-agent.conf`.

> [!note] Das ist ein echter Preis, kein Schönheitsfehler
> Neben dem bekannten Verlust des Exit-Codes ist damit **alles nicht testbar,
> was über die logind-Sitzung läuft**: Polkit-Dialoge, Bildschirmsperre,
> Inhibitoren. Der in 14 verworfene `systemd-run --user`-Weg würde das lösen.
> Auf dem Image stellt sich die Frage nicht — dort startet SDDM Sway innerhalb
> der Sitzung.

---

## 4 — `/etc` überschattet `/usr/share` ✅ — 09s offene Frage beantwortet

[[09-yoga-buildumgebung]] hielt fest, dass **nicht verifiziert** sei, ob
`/etc/sway/config.d/` eine gleichnamige Datei aus `/usr/share/sway/config.d/`
verdrängt — und wich deshalb im Image auf direktes Überschreiben in `/usr/share`
aus. Die Werkbank hat es in zwei Minuten geklärt.

Leere Overrides anlegen:

```nu
["90-bar.conf" "90-swayidle.conf"]
| each {|n| "" | sudo tee $"/etc/sway/config.d/($n)" | ignore }
```

Der Beweis steht in der generierten Include-Liste:

```nu
open --raw (glob $"($env.XDG_RUNTIME_DIR)/sway/*" | first) | lines
```

```
include '/etc/sway/config.d/10-systemd-cgroups.conf'
include '/etc/sway/config.d/10-systemd-session.conf'
include '/etc/sway/config.d/20-wslg.conf'
include '/usr/share/sway/config.d/50-rules-browser.conf'
include '/usr/share/sway/config.d/50-rules-pavucontrol.conf'
include '/usr/share/sway/config.d/50-rules-policykit-agent.conf'
include '/usr/share/sway/config.d/60-bindings-brightness.conf'
include '/usr/share/sway/config.d/60-bindings-media.conf'
include '/usr/share/sway/config.d/60-bindings-screenshot.conf'
include '/usr/share/sway/config.d/60-bindings-volume.conf'
include '/usr/share/sway/config.d/65-mode-passthrough.conf'
include '/etc/sway/config.d/90-bar.conf'          ← /etc, nicht /usr/share
include '/etc/sway/config.d/90-swayidle.conf'     ← /etc, nicht /usr/share
include '/usr/share/sway/config.d/95-autostart-policykit-agent.conf'
include '/usr/share/sway/config.d/95-xdg-desktop-autostart.conf'
include '/usr/share/sway/config.d/95-xdg-user-dirs.conf'
```

Gegenprobe am Verhalten: ab der Instanz, die nach dem Anlegen der Leerdateien
startete, taucht **kein `waybar` und kein `swayidle`** mehr als Kindprozess auf.

> [!important] Rückmeldung an [[09-yoga-buildumgebung]]
> Der `/usr/share`-Umweg im Image ist eine **Vorsichtsmaßnahme, keine
> Notwendigkeit**. Er bleibt trotzdem die richtige Wahl: `/etc` unterliegt auf
> bootc dem 3-Wege-Merge, `/usr/share` nicht. Die Begründung ändert sich von
> „geht vielleicht nicht anders" zu „ist der sauberere von zwei funktionierenden
> Wegen".

**Zwei Nebenbefunde aus derselben Liste:**

- Kein `50-keyboard.conf` — bestätigt den Kernbefund aus [[01-erkenntnisse]]
  auch hier: Fedora liefert nirgendwo einen `input`-Block.
- Fedoras Drop-ins nutzen ausschließlich `50-`, `60-`, `65-`, `95-`. Die
  Nummern `30-`, `70-`, `90-` sind frei.

---

## 5 — Output: 1920×1200, `scale 1` ✅

Beantwortet die offene Messung 2.4 aus [[14-xps13-wslg-sway-nushell-runde1]].
`grim` liest Sways Framebuffer und braucht keine sichtbare Fläche:

```nu
let wl = (ls $env.XDG_RUNTIME_DIR | get name | path basename
          | where {|n| $n =~ '^wayland-[1-9]\d*$'} | first)
let sock = (glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | first)
with-env { WAYLAND_DISPLAY: $wl, SWAYSOCK: $sock } { grim /tmp/probe.png }

let png = (open --raw /tmp/probe.png)
{
    breite: ($png | bytes at 16..19 | into int --endian big)
    hoehe:  ($png | bytes at 20..23 | into int --endian big)
}
```

Ergebnis: **1920 × 1200**.

> [!check] WSLg meldet vorskalierte Pixel
> `output WL-1 resolution 1920x1200 scale 1` im `20-wslg.conf` ist richtig. Zu
> klein wirkende Schrift ist eine **Anwendungsfrage**, keine Compositor-Frage —
> siehe Abschnitt 7.

Ansehen über den Windows-Explorer:

```nu
cp /tmp/probe.png ($nu.home-dir | path join "probe.png")
^explorer.exe (^wslpath -w ($nu.home-dir) | str trim)
```

---

## 6 — Autostart-Drop-in ✅

**Erst nach erfolgreichem Handstart.** Die Umgebungsvariablen gehören in die
`exec`-Zeile, nicht global.

```nu
[
    "# Noctalia unter WSLg: Software-GL, weil kein Render-Node existiert."
    "# LIBGL_ALWAYS_SOFTWARE gilt nur fuer diesen Prozess, nicht fuer die Session."
    "# QT_SCALE_FACTOR skaliert Text UND Tabler-Icons -- Noctalias eigene"
    "# fontScale-Werte greifen nur auf die Textfamilie."
    "exec env LIBGL_ALWAYS_SOFTWARE=1 QT_SCALE_FACTOR=1.3 qs -c noctalia-shell"
    ""
] | str join "\n" | save -f /tmp/95-noctalia.conf

sudo cp /tmp/95-noctalia.conf /etc/sway/config.d/95-noctalia.conf
sway --validate --config /etc/sway/config
```

> [!tip] `save` + `sudo cp` statt `sudo tee`
> Kein Quoting-Risiko, keine `secure_path`-Diskussion, keine Pipeline durch
> `sudo`. Der Raw-String `r#'…'#` blieb beim REPL-Paste im Fortsetzungsmodus
> (`:::`) hängen — Ursache ungeklärt, im Skript funktioniert er. Die
> Listen-Variante ist die robustere Konstruktion.

**`exec`, nicht `exec_always`** — sonst startet jeder `swaymsg reload` eine
weitere Instanz. `95-` liegt hinter den `90-`-Leerdateien: erst verdrängen, dann
starten.

Test nur über vollständigen Neustart, weil `reload` `exec` nicht auslöst:

```nu
sway-stop
sway-start
sleep 8sec
ps | where name =~ '^(sway|qs|waybar)$' | select pid ppid name
```

Verifiziertes Ergebnis: `sway 1284`, `qs 1293 (ppid 1284)`, kein `waybar`.

---

## 7 — Skalierung

### 7.1 Der Befund: Icons folgen `fontScale` nicht ✅

Die Bar-Schrift lässt sich über Noctalias Einstellungen vergrößern, **die
Symbole nicht**. Die Symbole sind Tabler-Icons — selbst Schriftzeichen, aber aus
einer anderen Familie, auf die `bar.fontScale` und `ui.fontDefaultScale`
offenbar nicht wirken. Kandidat für einen Upstream-Bug in 4.7.7.

### 7.2 Lösung: von außen skalieren ✅

```nu
# Zum Ausprobieren, ohne Konfigurationsaenderung:
ps | where name == "qs" | get pid | each {|p| kill $p } | ignore
with-env { SWAYSOCK: $sock } {
    swaymsg exec -- env LIBGL_ALWAYS_SOFTWARE=1 QT_SCALE_FACTOR=1.3 qs -c noctalia-shell
}
```

`QT_SCALE_FACTOR` multipliziert alles, was Qt zeichnet — Text, Icons, Abstände,
Rahmen. Es greift eine Ebene über den Schriftfamilien und trifft daher beide.

> [!check] Unter Pixman der günstigere Weg
> Der Client rendert direkt in der größeren Auflösung — **kein Resampling durch
> den Compositor**. Genau der Schritt, den
> [[14-xps13-wslg-sway-nushell-runde1#2.3]] bei fraktionalem `output scale` als
> teuer benennt, entfällt.

Noctalias eigene Werte vorher zurücksetzen, sonst multipliziert sich beides:

```nu
sway-stop
let cfg = ($nu.home-dir | path join ".config/noctalia/settings.json")
cp $cfg $"($cfg).bak-(date now | format date '%Y%m%d-%H%M')"
open $cfg | update bar.fontScale 1 | update ui.fontDefaultScale 1 | save -f $cfg
```

Der grobe Hebel für **alles** (auch foot, auch Obsidian):

```nu
with-env { SWAYSOCK: $sock } { swaymsg output WL-1 scale 1.5 }
```

Kosten: Resampling über die volle Fläche unter Pixman, und die logische
Arbeitsfläche schrumpft auf 1280×800. Rückweg: `scale 1`.

### 7.3 `settings.json` — Schlüsselbaum (v4.7.7, Schema 59) ✅

```nu
open $cfg | columns
```

```
appLauncher, audio, bar, brightness, calendar, colorSchemes, controlCenter,
desktopWidgets, dock, general, hooks, idle, location, network, nightLight,
noctaliaPerformance, notifications, osd, plugins, sessionMenu,
settingsVersion, systemMonitor, templates, ui, wallpaper
```

Die vier Schlüssel, die unter llvmpipe zählen — alle unter `general`:

| Schlüssel | Ist | Empfehlung WSL | Warum |
|---|---|---|---|
| `general.scaleRatio` | `1` | 1.25–1.5 | globaler UI-Maßstab; **im Panel nicht bedienbar**, nur per Hand |
| `general.enableBlurBehind` | `true` | `false` | Sway unterstützt `ext-background-effect-v1` nicht — wirkungslos, kostet Renderpfade |
| `general.enableShadows` | `true` | `false` | Schattenmasken sind unter Software-Rendering teuer |
| `general.animationSpeed` | `1` | `0.5` / `animationDisabled: true` | das „ruckelt vs. normal" aus 13 |

Bereits sinnvoll voreingestellt: `noctaliaPerformance.disableWallpaper: true`,
`disableDesktopWidgets: true`, `ui.translucentWidgets: false`,
`general.telemetryEnabled: false`.

> [!warning] `general.lockOnSuspend: true` unter WSL abschalten
> Das Log zeigt `Time jump detected (9s) - likely system resume`. WSL2 friert
> die VM-Uhr bei Inaktivität ein; Noctalia deutet das als Resume. Sperrt es
> daraufhin, sitzt man in einer Umgebung ohne funktionierendes Polkit und ohne
> `fprintd` fest.

Handeditieren **nur bei beendeter Shell** — Noctalia schreibt die Datei zurück:

```nu
sway-stop
open $cfg | update general.scaleRatio 1.3 | save -f $cfg
open $cfg | get general.scaleRatio      # zugleich JSON-Syntaxprobe
sway-start
```

---

## 8 — Flatpak und Obsidian ✅

Flatpak ist der Musterfall für die Zwei-Schichten-Regel aus
[[13-xps13-wsl-installation]]: setuid-`bwrap`, User-Namespaces,
systemd-User-Units, Polkit — kategorisch außerhalb von brews Reichweite.
**Also dnf.**

```nu
sudo dnf install flatpak xdg-desktop-portal xdg-desktop-portal-gtk
```

`xdg-desktop-portal-gtk` ist keine Kür: GTK-Anwendungen bekommen ohne diesen
Backend keine Dateidialoge; `-wlr` deckt nur Screenshot/Screencast ab.

Voraussetzung prüfen — der WSL2-Kernel ist ein Microsoft-Build:

```nu
open /proc/sys/user/max_user_namespaces | into int      # 63071 ✅
^bwrap --ro-bind / / --dev /dev true                    # muss ohne Fehler durchlaufen
```

Remote und Installation, durchgängig `--user` (kein Polkit nötig — und der
Agent ist hier ohnehin defekt):

```nu
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-info --user flathub md.obsidian.Obsidian    # Architekturpruefung
flatpak install --user flathub md.obsidian.Obsidian
```

> [!danger] Electron braucht Wayland — Xwayland ist ja abgeschaltet
> Obsidian ist Electron und startet standardmäßig über X11. Mit
> `xwayland disable` aus 3.1 erscheint sonst kein Fenster.
> ```nu
> flatpak override --user --env=ELECTRON_OZONE_PLATFORM_HINT=wayland md.obsidian.Obsidian
> flatpak override --user --env=LIBGL_ALWAYS_SOFTWARE=1 md.obsidian.Obsidian
> flatpak override --user --show md.obsidian.Obsidian
> ```

Start aus der Sway-Sitzung — dieselbe Lehre wie bei Noctalia:

```nu
with-env { SWAYSOCK: $sock } { swaymsg exec -- flatpak run md.obsidian.Obsidian }
```

Skalierung: intern `Strg++` bzw. *Darstellung → Zoom*, oder von außen
`ELECTRON_FORCE_DEVICE_SCALE_FACTOR=1.5` per `flatpak override`.

> [!warning] Vault nicht über `/mnt/c` öffnen
> Der 9p-Durchgriff aufs Windows-Dateisystem ist bei vielen kleinen Dateien sehr
> langsam — ein Obsidian-Vault ist genau das. Innerhalb der Distro (ext4) ist die
> Performance in Ordnung.

### 8.1 Launcher findet Flatpaks nicht ✅

```nu
$env.XDG_DATA_DIRS?
glob ($nu.home-dir | path join ".local/share/flatpak/exports/share/applications/*.desktop")
```

Die `.desktop`-Datei existiert, aber `XDG_DATA_DIRS` enthält den Exports-Pfad
nicht. Flatpak setzt ihn über `/etc/profile.d/flatpak.sh` — und **Nushell liest
kein `/etc/profile.d`**. Sway erbt die Nushell-Umgebung, Noctalia erbt Sways
Umgebung; die Kette endet hier. Bekannter Fall aus [[02-umgebung-wsl]].

In `env.nu`:

```nu
$env.XDG_DATA_DIRS = ([
    ($nu.home-dir | path join ".local/share/flatpak/exports/share")
    "/var/lib/flatpak/exports/share"
    "/usr/local/share"
    "/usr/share"
] | str join ":")
```

String mit Doppelpunkten, keine Liste — nur `PATH` behandelt Nushell als Liste.
Danach `exec nu`, dann `sway-start`.

> [!note] Reine Werkbank-Reparatur
> Auf Sway Atomic startet Sway aus SDDM; dort greift die POSIX-Login-Kette und
> `XDG_DATA_DIRS` stimmt von allein. Der `env.nu`-Eintrag gehört **nicht** ins
> Containerfile.

### 8.2 Bazaar und die Flotte 🟡

Bazaar (`io.github.kolunmi.Bazaar`, GTK4/libadwaita) installiert sich genauso.
Aber:

> [!warning] Flatpaks lassen sich nicht ins bootc-Image backen
> `flatpak install` im Containerfile schreibt nach `/var/lib/flatpak` — und
> `/var` wird beim Image-Commit herausgelöst. Der Inhalt ist nach dem Deployment
> weg. Der etablierte Weg (Bluefin, Bazzite) ist eine **First-Boot-systemd-Unit**,
> die eine Paketliste abarbeitet. Eigener Baustein, kein Einzeiler.
>
> Und die Vorfrage für den Schulungskontext: Ein Appstore auf Flottengeräten
> heißt, dass Teilnehmer installieren können, was sie wollen.

---

## 9 — Widerlegte Annahmen ❌

> [!failure] Drei Spuren, die nirgendwohin führten
> Sie stehen hier, damit sie nicht wiederkehren.

### 9.1 Die Schriften waren nie das Problem ❌

`fc-list | find -i "material"` lieferte `0` — daraus wurde geschlossen, dass
Material-Symbols fehlen. Zwei Fehler auf einmal:

1. **Noctalia nutzt Tabler Icons, nicht Material Symbols.**
   ```nu
   rpm -ql noctalia-shell | lines | where {|f| $f =~ '\.(ttf|otf)$'} | path basename
   # → noctalia-tabler-icons.ttf
   ```
2. **Die Schrift wird per QML-`FontLoader` geladen, nicht über fontconfig.**
   Deshalb sieht `fc-list` sie nicht — und das ist normal, kein Fehler.

Das Log sagte es die ganze Zeit: `Font Loaded 88 fonts, 8 monospace`, ohne eine
einzige Beschwerde. Die Diskussion um `material-icons-fonts` (Legacy, Familie
`Material Icons … Round`) versus den Google-Variable-Font
(`Material Symbols … Rounded`) war **vollständig gegenstandslos**.

Textschrift: `fc-match "Sans Serif"` → Noto Sans. Funktioniert.
`rsms-inter-fonts` plus `ui.fontDefault = "Inter"` ist Geschmack, keine
Notwendigkeit.

### 9.2 Das Platzhaltersymbol war kein fehlendes Wallpaper ❌

Das Symbol in der Bildmitte wurde auf `Wallpaper Scan completed found 0 files`
und ein leeres `~/Pictures/Wallpapers` zurückgeführt. Tatsächliche Ursache:

```
noctaliaPerformance.disableWallpaper: true
```

Die Anzeige war ohnehin abgeschaltet. Der Log-Eintrag führte in die Irre.

### 9.3 `Could not load icon` liegt nicht am Icon-Theme ❌

`adwaita-icon-theme` war bereits installiert. Die Warnung stammt von:

```
general.avatarImage: /home/fritz/.face
```

```nu
($nu.home-dir | path join ".face") | path exists     # false
```

---

## 10 — Was diese Umgebung nicht testen kann 🟡

Ergänzt [[01-erkenntnisse#Was der nested Container nicht testen kann]]:

| Bereich | Logbeleg | Grund |
|---|---|---|
| Bluetooth | `Failed to create DBusObjectManagerInterface for "org.bluez"` | kein bluez |
| Netzwerk-Widget | `Not authorized to recheck connectivity` | kein NetworkManager |
| Temperatur | `No supported temperature sensor found` | kein hwmon |
| Akku, Helligkeit | — | kein upower, kein `/sys/class/backlight` |
| Sperre, Idle, Polkit | `POLKIT_IS_SUBJECT failed`, `/init.scope` | keine logind-Sitzung (3.2) |
| Blur | `ext-background-effect-v1 is not supported` | **Sway generell**, nicht WSL-spezifisch |
| Multi-Monitor / `kanshi` | — | WSLg liefert genau einen Output |
| Alles Performative | — | llvmpipe |

Was sie **kann** — und in dieser Runde bewiesen hat: Paketauflösung,
Startfähigkeit, Layer-Shell-Anbindung, Konfigurationspfade, Drop-in-Reihenfolge,
Kollisionen, IPC, Flatpak-Sandbox, Portale.

> [!tip] Blur: ein Fund für das Image
> `ext-background-effect-v1` wird von Sway nicht implementiert — weder hier noch
> auf dem Yoga. Der teuerste Renderpfad ist damit ohnehin aus. Gehört nach
> [[09-yoga-buildumgebung]].

---

## 11 — Nushell-Idiome dieser Runde ✅

Alles unter 0.114.1 gemessen. Fehler, die `nu-check` nicht findet:

| Falsch | Richtig | Warum |
|---|---|---|
| `where waybar or idle` | `where {\|r\| $r.waybar or $r.idle}` | `where` nimmt einen Spaltenausdruck **oder** einen Block, keine Verknüpfung zweier Spalten in Kurzform |
| `ps \| select start_time` | `ls -l /proc/<pid> \| get modified` | `ps` hat nur `pid ppid name status cpu mem virtual` |
| `bytes at 16..24` | `bytes at 16..19` | Ranges sind **inklusiv** — `16..24` sind neun Bytes |
| `get -o -1` | `\| last` | `get` kennt kein `-1` |
| `sudo tee` + `r#'…'#` | `save` + `sudo cp` | Raw-String blieb im REPL-Paste im Fortsetzungsmodus hängen |
| `sudo open …` | `open` als User | `open` ist ein Nushell-Builtin, `sudo` startet einen externen Prozess |

> [!warning] Mehrzeiliger Einwurf druckt nur die letzte Pipeline
> Ein Block mit mehreren Befehlen ist für Nushell **eine** Eingabe. Diagnosen
> immer einzeln absetzen, sonst gehen genau die Ausgaben verloren, die man
> braucht.

Klammerersetzung mit einer PID-**Liste** spachtelt alle Werte in einen Pfad:

```
cat: '/proc/1536'$'\n''1707'$'\n''1940/cgroup': No such file
```

Nützlicher Zufallsbefund — er deckte den Instanzenstau auf.

---

## 12 — Prüfliste

```nu
# Genau eine Instanz, richtige Eltern-Kind-Beziehung
ps | where name =~ '^(sway|qs|waybar)$' | select pid ppid name

# Layer-Shell-Anbindung: muss 0 liefern
open --raw (glob ($nu.home-dir | path join ".local/state/sway-*.log") | sort | last)
| lines | where {|z| $z =~ '(?i)layershell|eglSwapBuffers'} | length

# Output
with-env { SWAYSOCK: (glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | first) } {
    swaymsg -t get_outputs | from json | select name current_mode scale
}

# Include-Kette
open --raw (glob $"($env.XDG_RUNTIME_DIR)/sway/*" | first) | lines

# Sockets: nur wayland-0 (WSLg) und genau ein wayland-N (Sway)
ls $env.XDG_RUNTIME_DIR | get name | path basename | where {|n| $n =~ '^wayland-'}

# Paketlage
["noctalia-shell" "noctalia-qs" "quickshell" "flatpak" "bubblewrap"
 "xdg-desktop-portal-gtk" "ImageMagick" "mesa-dri-drivers"]
| each {|p| {paket: $p, da: ((rpm -q $p | complete).exit_code == 0)} }

# Flatpak-Sichtbarkeit fuer den Launcher
$env.XDG_DATA_DIRS
```

---

## 13 — Offene Punkte

- [ ] `QT_SCALE_FACTOR`: passenden Wert festlegen und im Drop-in einfrieren
- [ ] Icons folgen `fontScale` nicht (7.1) — als Issue an
      `noctalia-dev/noctalia-shell` melden, mit v4.7.7 / Schema 59
- [ ] `general.scaleRatio` fehlt im Einstellungspanel — bewusst oder Lücke?
- [ ] Wetter-Koordinaten setzen oder Widget entfernen (19-Sekunden-Takt im Log)
- [ ] `general.lockOnSuspend` auf `false`
- [ ] `~/.face` anlegen oder `avatarImage` leeren
- [ ] Launcher-Tastenkürzel: `qs -c noctalia-shell ipc show` auswerten und
      `96-noctalia-keys.conf` anlegen
- [ ] Blur-Befund (`ext-background-effect-v1`) nach [[09-yoga-buildumgebung]]
- [ ] `/etc`-Überschattung als **verifiziert** in 09 nachtragen (Abschnitt 4)
- [ ] Projektverzeichnis: `~/projekte/noctarow` → `~/Projects/NoctaRow`;
      `NU_LIB_DIRS` in [[02-umgebung-wsl]] und die `use`-Pfade in `config.nu`
      zeigen noch auf den alten Ort
- [ ] Entscheidung v4 (`-legacy`) vs. v5-Track aus 09 — betrifft beide Umgebungen
- [ ] First-Boot-Unit für Flatpaks, falls die Flotte welche bekommen soll (8.2)

---

## Kernaussagen in fünf Sätzen

Quickshell ist ein Qt6-**Client** und braucht einen eigenen GL-Pfad — `WLR_*`
wirkt nur auf Sway, `LIBGL_ALWAYS_SOFTWARE=1` ist die Lösung, und sie trägt.
Noctalia muss **als Kind von Sway** starten (`swaymsg exec`), sonst verbindet es
sich mit WSLgs Weston, wo es keine Layer-Shell gibt und deshalb prinzipiell keine
Bar geben kann. `kill --force` auf einen Compositor unter WSLg hinterlässt Weston
in einem Zustand, den nur `wsl --shutdown` löst — SIGTERM zuerst, immer. Die
billigste Erkenntnis der Runde war keine Noctalia-Erkenntnis: `/etc/sway/config.d/`
überschattet `/usr/share/sway/config.d/` nachweislich, was den `/usr/share`-Umweg
im Image zur Vorsichtsmaßnahme statt zur Notwendigkeit macht. Und mehrere Stunden
gingen an Annahmen verloren, die das Log von Anfang an widerlegte — `Font Loaded
88 fonts` stand da, während nach fehlenden Schriften gesucht wurde.
