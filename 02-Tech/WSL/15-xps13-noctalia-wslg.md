---
title: XPS 13 — Noctalia unter WSLg installieren und einrichten
aliases: [Noctalia-Schicht, Noctalia-WSL, Quickshell-unter-WSLg]
teil_von: "[[README]]"
tags: [wsl, wslg, sway, noctalia, quickshell, terra, qt6, nushell, xps13]
created: 2026-08-02
system: Dell XPS 13 9345 (Snapdragon X Elite, aarch64), FedoraLinux-44 WSL
verifiziert_gegen: Nushell 0.114.1 (Syntax); Laufzeit auf dem XPS noch offen
status: entwurf
---

# 15 — XPS 13: Noctalia unter WSLg

Schließt den offenen Punkt aus [[13-xps13-wsl-installation#Offene Punkte]]:
*„Noctalia-Schicht (quickshell aus Fedora-Repos vs. Git-Klon nach
`~/.config/quickshell/`) — separater Abschnitt, sobald Sway steht."*
Sway steht seit [[14-xps13-wslg-sway-nushell-runde1]].

> [!info] Statuslegende (wie in 14)
> **✅ verifiziert** — auf dem XPS gemessen · **🟡 hergeleitet** — aus
> dokumentierter Semantik gefolgert · **⬜ offen** — Messung steht aus
>
> Diese Notiz ist überwiegend 🟡/⬜. Sie ist ein **Plan mit Messpunkten**,
> keine Erfolgsmeldung.

> [!warning] Abgrenzung — das hier ist die Werkbank
> Nichts aus dieser Notiz wandert 1:1 ins bootc-Image. Dort gilt
> [[09-yoga-buildumgebung]]: Pakete deklarativ im Containerfile, Drop-ins
> nach `/usr/share/sway/config.d/`, `rpm -q`-Guard. Hier wird *erkundet*,
> was dort *festgeschrieben* wird.

---

## 1 — Architekturentscheidung: Terra-RPM, nicht Git-Klon 🟡

Zwei Wege stehen zur Wahl, [[07-referenz-quellen]] nennt beide:

| | Terra-RPM (`noctalia-shell`) | `dnf install quickshell` + Git-Klon |
|---|---|---|
| Deckungsgleich mit dem Image | **ja** — identischer Pfad wie [[09-yoga-buildumgebung]] | nein |
| Quickshell-Variante | `noctalia-qs` (Fork, von Terra) | Fedora-`quickshell` (Upstream) |
| Version | Terra, ungepinnt, aktuell | Git-HEAD, beliebig aktuell |
| Fremdquelle im System | **ja — und zwar tief** (s. u.) | nein |
| Rückbau | `dnf remove` + Repo raus | `rm -rf` des Klons |
| Was es über das Image lehrt | **alles** | wenig |

**Entscheidung: Terra.** Die WSL-Distro ist Scout für das Image, nicht
Selbstzweck. Ein Git-Klon würde eine andere Quickshell-Binärvariante testen
als das Image ausliefert — dann sind gefundene Fehler nicht übertragbar,
und genau dafür ist die Werkbank da.

> [!important] `quickshell` **nicht** zusätzlich installieren
> `noctalia-qs` und `quickshell` liefern dieselben Provides und kollidieren.
> Das ist in [[09-yoga-buildumgebung]] bereits entschieden und korrigiert die
> ältere Annahme in [[07-referenz-quellen]]. Vorher prüfen:
> ```nu
> ["quickshell" "noctalia-qs" "noctalia-shell"]
> | each {|p| {paket: $p, installiert: ((rpm -q $p | complete).exit_code == 0)} }
> ```

### 1.1 Die zwei Risiken von Terra auf einem *mutablen* System ⬜

Im Containerfile ist Terra harmlos: ein Build, ein Ergebnis, `rpm -q`-Guard.
Auf einer laufenden Distro mit `dnf upgrade` ist die Lage anders.

> [!danger] Risiko 1 — Terra übernimmt den Qt-Stack
> `noctalia-qs` verlangt Qt 6.11 ([[09-yoga-buildumgebung]]). Bringt Fedora 44
> weniger mit, hebt dnf `qt6-qtbase` **aus Terra** an — und damit hängt der
> gesamte Qt-Unterbau des Systems an einer Drittquelle. Im Image ist das ein
> bewusster, eingefrorener Zustand; hier zieht jedes `dnf upgrade` daran.

> [!danger] Risiko 2 — `terra-obsolete` verdrängt Fedora-Pakete still
> Terra liefert ein Paket, dessen einziger Zweck `Obsoletes`-Direktiven sind.
> Es kann Fedora-Pakete (beobachtet: `nushell`) stillschweigend gegen
> Terra-Varianten tauschen — ohne Fehler, ohne Rückfrage. Auf diesem Gerät
> kommen `nu` und `hx` aus **brew** und sind nicht betroffen
> ([[13-xps13-wsl-installation#Die Zwei-Schichten-Regel]]), aber die Mechanik
> greift für jedes andere Paket genauso.

**Konsequenz — Repo defensiv eintragen:** `enabled=0`, gezielt pro Befehl
aktivieren, `terra-obsolete` ausschließen. Das kostet einen Schalter pro
Update und nimmt Terra die Möglichkeit, das System hinter dem Rücken
umzubauen.

---

## 2 — Terra-Repo eintragen 🟡

Bewusste Abweichung von der Image-Fassung in [[09-yoga-buildumgebung]]
(`enabled=1`): dort ist der Build das Ziel, hier die Stabilität der Werkbank.

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
'# | sudo tee /etc/yum.repos.d/terra.repo | ignore
```

Gegenlesen und Metadaten holen:

```nu
open /etc/yum.repos.d/terra.repo | lines | where {|z| $z =~ '^(enabled|exclude|gpg)'}
sudo dnf --enable-repo=terra makecache
```

> [!note] dnf5-Schreibweise
> Auf Fedora 44 (dnf5) heißt der Schalter `--enable-repo=terra`. Die
> dnf4-Schreibweise `--enablerepo=terra` wird noch als Alias akzeptiert —
> in dieser Notiz durchgängig die dnf5-Form.

Verfügbarkeit für **aarch64** prüfen, bevor irgendetwas installiert wird —
Terra baut laut [[09-yoga-buildumgebung]] für beide Architekturen, aber
„baut für" und „hat für fc44 im Repo" sind zwei verschiedene Aussagen:

```nu
dnf --enable-repo=terra repoquery --queryformat '%{name}-%{version} %{arch} %{reponame}\n' noctalia-shell noctalia-qs
```

Leere Ausgabe → Terra hat für diese Release/Arch-Kombination nichts. Dann
**hier abbrechen** und den Git-Weg aus Abschnitt 1 nehmen, statt an dnf zu
drehen.

---

## 3 — Installation mit Vorschau ⬜

Erst ansehen, was der Auflöser vorhat. `--assumeno` rechnet die Transaktion
durch und bricht vor dem Download ab:

```nu
sudo dnf --enable-repo=terra install --assumeno noctalia-shell
```

> [!important] Worauf in der Vorschautabelle zu achten ist
> 1. **Spalte „Repository"**: Wie viele Pakete kommen aus `terra` statt
>    `fedora`/`updates`? Alles jenseits von `noctalia-*` und einer Handvoll
>    Qt-Bibliotheken verdient eine Rückfrage.
> 2. **`qt6-*`-Zeilen unter „upgrading"**: Das ist Risiko 1 in Aktion.
> 3. **Zeilen unter „replacing"/„obsoleting"**: Muss leer sein. Ist sie es
>    nicht, greift `excludepkgs` nicht wie gedacht.
> 4. **Gesamtgröße**: Der Qt6-Unterbau ist kein Leichtgewicht; die
>    WSL-`vhdx` wächst und schrumpft nicht von allein.

Erst wenn die Vorschau sauber ist:

```nu
sudo dnf --enable-repo=terra install noctalia-shell
```

Guard — dieselbe Disziplin wie im Containerfile
([[01-erkenntnisse]]: erfolgreicher Exit-Code ist **kein** Beweis):

```nu
["noctalia-shell" "noctalia-qs"]
| each {|p| {paket: $p, ok: ((rpm -q $p | complete).exit_code == 0)} }
```

Was das Paket tatsächlich mitbringt — Binärnamen und Schriften nicht raten:

```nu
rpm -ql noctalia-shell | lines | where {|f| $f =~ '/(bin|share/fonts)/'}
rpm -ql noctalia-qs    | lines | where {|f| $f =~ '/bin/'}
which -a qs quickshell noctalia-shell
```

### 3.1 Laufzeit-Nachbarn 🟡

Noctalia ruft externe Werkzeuge auf. Was fehlt, fällt nicht laut aus,
sondern äußert sich als leeres Widget:

```nu
["matugen" "cliphist" "wl-clipboard" "brightnessctl" "swww" "cava" "libnotify"]
| each {|p| {paket: $p, da: ((rpm -q $p | complete).exit_code == 0)} }
```

`matugen` und `cliphist` liegen laut [[01-erkenntnisse#Umgebungsbefunde WSL]]
offiziell für aarch64 vor — also aus **Fedora**, nicht aus Terra:

```nu
sudo dnf install matugen cliphist wl-clipboard
```

Schriften: Noctalia setzt auf Material-Symbols-Icons. Die sind in Fedora
**nicht** paketiert; entweder bringt das Terra-RPM sie mit (`rpm -ql` oben)
oder die Oberfläche zeigt leere Rechtecke statt Symbolen.

```nu
fc-list | lines | find -i "material" | length     # 0 → Symbole fehlen
fc-list | lines | find -i "inter" | length
```

---

## 4 — Der eigentliche Knackpunkt: Quickshell braucht OpenGL 🟡

Das ist die Stelle, an der diese Notiz sich von jeder allgemeinen
Noctalia-Anleitung unterscheidet.

> [!danger] `WLR_RENDERER=pixman` hilft Noctalia **nicht**
> Die Variable steuert **wlroots** — also Sway selbst. Quickshell ist ein
> gewöhnlicher Wayland-**Client** auf Qt6/QtQuick und ignoriert jedes
> `WLR_*` vollständig. QtQuick rendert über OpenGL. Auf diesem Gerät gibt es
> aber keinen Render-Node: `/dev/dri` fehlt, aus `/dev/dxg` entsteht ohne
> `d3d12`-Gallium-Treiber keiner
> ([[01-erkenntnisse#Umgebungsbefunde WSL]]).
>
> `sway-start` aus [[14-xps13-wslg-sway-nushell-runde1]] vererbt `WLR_RENDERER`
> zwar an alle Kindprozesse — für Qt ist das ein wirkungsloser String.

Es bleiben zwei Wege, und sie sind **nicht** gleichwertig:

| | A: llvmpipe | B: Qt-Quick-Software-Backend |
|---|---|---|
| Variable | `LIBGL_ALWAYS_SOFTWARE=1` | `QT_QUICK_BACKEND=software` |
| Was rendert | Mesas Software-GL, **voller** GL-Pfad | Qts eigener 2D-Rasterizer |
| Shader / Blur / `ShaderEffect` | funktionieren | **funktionieren nicht** |
| Erwartetes Fehlerbild | langsam | fehlende oder schwarze Flächen |
| Aussagekraft fürs Image | brauchbar | gering |

**Weg A ist der einzige, der etwas beweist.** Weg B ist die Notfallkrücke,
wenn A gar nicht startet — und dann ist die Erkenntnis „läuft hier nicht",
nicht „Noctalia ist kaputt".

Voraussetzung für A prüfen — llvmpipe steckt in `mesa-dri-drivers`:

```nu
rpm -q mesa-dri-drivers
glob /usr/lib64/dri/*.so | path basename       # swrast_dri.so muss dabei sein
```

### 4.1 Erster Start: von Hand, im Vordergrund ⬜

**Nicht** sofort als `exec` in die Sway-Konfiguration. In einer
foot-Sitzung *innerhalb* der Sway-Session:

```nu
with-env {
    QT_QPA_PLATFORM: "wayland"
    LIBGL_ALWAYS_SOFTWARE: "1"
    QT_LOGGING_RULES: "qt.qpa.*=true"
} { qs -c noctalia-shell }
```

Die Ausgabe ist der ganze Ertrag dieses Schritts. Erwartbare Fehlerbilder:

| Meldung | Bedeutung | Reaktion |
|---|---|---|
| `Could not find DRM device` / EGL-Initialisierung schlägt fehl | llvmpipe greift nicht | `mesa-dri-drivers` prüfen, dann Weg B |
| `could not connect to display` | `WAYLAND_DISPLAY` fehlt in dieser Shell | aus der Sway-Session heraus starten, nicht aus dem WSL-Einstieg |
| `qt.qpa.plugin: Could not load "wayland"` | `qt6-qtwayland` fehlt | `sudo dnf install qt6-qtwayland` |
| startet, Symbole sind leere Rechtecke | Material-Symbols fehlen (3.1) | Schrift nachlegen |
| startet, Bar bleibt schwarz | Shader-Pfad | mit Weg B gegenprüfen |

> [!tip] Erwartungsmanagement
> [[01-erkenntnisse]] sagt es bereits: **keine Performance-Schlüsse ziehen.**
> Ruckelnde Animationen unter llvmpipe sind hier das *erwartete* Ergebnis und
> kein Befund über das Image. Was diese Umgebung beweisen kann, ist:
> *startet die Shell, findet sie ihre Konfiguration, lädt sie ihre Schriften,
> kollidiert sie mit etwas.*

---

## 5 — Kollisionen auflösen 🟡

[[01-erkenntnisse#Kollisionen mit Noctalia]] nennt zwei; unter WSL kommt eine
dritte dazu, weil [[13-xps13-wsl-installation#Schritt 5]] `mako` mitinstalliert
hat.

| Gegenspieler | Konflikt | Lösung hier |
|---|---|---|
| `waybar` (via `90-bar.conf`) | zweite Leiste | gleichnamige Leerdatei in `/etc/sway/config.d/` |
| `swayidle` (via `90-swayidle.conf`) | zweiter Idle-Daemon, streitet um die Sperre | gleichnamige Leerdatei |
| **`mako`** | zweiter Notification-Daemon; beide greifen nach `org.freedesktop.Notifications`, der Erste gewinnt | `mako` nicht starten |

Erst messen, welche Dateien es auf diesem System überhaupt gibt — Dateinamen
hängen an der `sway-config-fedora`-Version:

```nu
(glob /usr/share/sway/config.d/*.conf) ++ (glob /etc/sway/config.d/*.conf)
| each {|f| {datei: $f, waybar: (open --raw $f | str contains "waybar"), idle: (open --raw $f | str contains "swayidle"), mako: (open --raw $f | str contains "mako")} }
| where waybar or idle or mako
```

### 5.1 Nebenertrag: Hier lässt sich 09s offene Frage billig klären ⬜

[[09-yoga-buildumgebung]] hält fest, dass **nicht verifiziert** ist, ob
`/etc/sway/config.d/` eine gleichnamige Datei aus `/usr/share/sway/config.d/`
überschattet — und weicht deshalb im Image auf direktes Überschreiben in
`/usr/share` aus. Diese Werkbank kann die Frage in zwei Minuten beantworten,
ohne ein Image zu bauen.

```nu
# leere Overrides in /etc
["90-bar.conf" "90-swayidle.conf"] | each {|n| "" | sudo tee $"/etc/sway/config.d/($n)" | ignore }
swaymsg reload

# Beweisstück: die generierte Include-Liste im Laufzeitverzeichnis
glob $"($env.XDG_RUNTIME_DIR)/sway/*"
| each {|f| {datei: ($f | path basename), zeilen: (open --raw $f | lines | length)} }

# Gegenprobe am Verhalten
ps | where name =~ "waybar" | length      # 0 → Override greift
```

> [!important] Der Befund gehört zurück nach [[09-yoga-buildumgebung]]
> Greift der `/etc`-Override, ist der `/usr/share`-Umweg im Image eine
> Vorsichtsmaßnahme und keine Notwendigkeit — und `/etc` bleibt für
> maschinenspezifische Abweichungen frei, wie in 09 ohnehin vorgesehen.
> Greift er nicht, ist die Entscheidung in 09 nachträglich belegt statt
> nur vermutet. Beide Ausgänge sind ein Gewinn.

---

## 6 — Autostart-Drop-in ⬜

**Erst nach erfolgreichem Handstart aus 4.1.** Die Umgebungsvariablen
gehören in die `exec`-Zeile, nicht global — dieselbe Begründung wie die
`WLR_RENDERER`-Warnung in [[02-umgebung-wsl]]: global gesetzt suchst du
Monate später, warum nichts beschleunigt läuft.

```nu
r#'# Noctalia unter WSLg — Software-GL, weil kein Render-Node existiert.
# LIBGL_ALWAYS_SOFTWARE gilt nur fuer diesen Prozess, nicht fuer die Session.
exec env QT_QPA_PLATFORM=wayland LIBGL_ALWAYS_SOFTWARE=1 qs -c noctalia-shell
'# | sudo tee /etc/sway/config.d/95-noctalia.conf | ignore

sway --validate --config /etc/sway/config
swaymsg reload
```

> [!note] `reload` startet `exec`-Zeilen nicht neu
> Sway führt `exec` nur beim Sitzungsstart aus; `exec_always` bei jedem
> Reload. Für den Test also entweder die Session neu starten
> (`sway-start` aus [[14-xps13-wslg-sway-nushell-runde1#5.6]]) oder
> Noctalia weiter von Hand starten. Im Image ist `exec` richtig — dort gibt
> es keinen Reload-Zyklus.

Nummerierung bewusst wie im Image (`95-`): nach den `90-`-Leerdateien, damit
die Verdränger vor dem Verdrängten gelesen werden.

---

## 7 — Noctalia konfigurieren ⬜

> [!warning] Hier wird nicht geraten
> Der Schlüsselbaum von `settings.json` ändert sich zwischen Noctalia-Versionen.
> Diese Notiz dokumentiert deshalb **wie man die Schlüssel findet**, nicht
> welche es angeblich gibt. Erst nach dem ersten erfolgreichen Start existiert
> die Datei überhaupt — die Shell schreibt sie selbst an.

```nu
glob ($nu.home-dir | path join ".config/noctalia/*")
glob ($nu.home-dir | path join ".cache/noctalia/*")
```

Kandidaten für die WSL-Anpassung suchen (Animationen aus, Blur aus — unter
llvmpipe der Unterschied zwischen „ruckelt" und „benutzbar",
vgl. [[13-xps13-wsl-installation#Schritt 5]]):

```nu
let cfg = ($nu.home-dir | path join ".config/noctalia/settings.json")
open $cfg | columns
open $cfg | transpose bereich inhalt | where bereich =~ '(?i)bar|general|ui'
```

Vor jeder Änderung sichern — die Shell schreibt die Datei selbst und kann sie
überschreiben:

```nu
let ts = (date now | format date "%Y%m%d-%H%M")
cp $cfg $"($cfg).bak-($ts)"
```

> [!tip] Bevorzugt über die eigene Oberfläche ändern
> Noctalia bringt ein Einstellungspanel mit und schreibt die Datei danach neu.
> Wer parallel von Hand editiert, verliert. Handeditieren nur bei beendeter
> Shell, danach `open $cfg | columns` als Syntaxprobe (ungültiges JSON fällt
> hier auf, nicht erst beim nächsten Start).

---

## 8 — Was diese Umgebung nicht testen kann 🟡

Ergänzt die Liste aus [[01-erkenntnisse#Was der nested Container nicht testen kann]]
um die Noctalia-spezifischen Punkte:

- **Akku- und Ladewidget** — WSL hat keine `upower`-Geräte
- **Helligkeit** — `brightnessctl` ohne `/sys/class/backlight` wirkungslos
- **Netzwerk-Widget** — kein NetworkManager in der WSL-Distro
- **Bluetooth** — kein `bluez`-Stack
- **Bildschirmsperre / Idle** — kein echter Sitzungslebenszyklus
- **Screen-Recording** — braucht den Render-Node, den es nicht gibt
- **Alles Performative** — llvmpipe, siehe 4.1
- **Multi-Monitor / `kanshi`** — WSLg liefert genau einen Output (`WL-1`)

Was sie **kann**: Paketauflösung, Startfähigkeit, Konfigurationspfade,
Schriften, Kollisionen mit `waybar`/`swayidle`/`mako`, IPC-Erreichbarkeit,
Drop-in-Reihenfolge. Genau die Fehlerklassen, die sonst erst nach einem
30-minütigen Image-Bau auffallen.

---

## 9 — Prüfliste

```nu
# Paketlage
["noctalia-shell" "noctalia-qs" "quickshell" "terra-obsolete" "matugen" "cliphist" "mesa-dri-drivers" "qt6-qtwayland"]
| each {|p| {paket: $p, da: ((rpm -q $p | complete).exit_code == 0)} }

# Woher kommt der Qt-Unterbau wirklich?
rpm -qa --queryformat '%{name} %{vendor}\n' | lines | find -i "qt6" | first 10

# Terra darf im Alltag nicht mitreden
open /etc/yum.repos.d/terra.repo | lines | where {|z| $z =~ '^enabled='}

# Session
swaymsg -t get_outputs | from json | select name current_mode scale
ps | where name =~ '(qs|waybar|mako|swayidle)' | select name pid

# Läuft die Shell und antwortet ihre IPC?
qs -c noctalia-shell ipc show
```

---

## 10 — Offene Punkte

- [ ] `repoquery`: Gibt es `noctalia-shell` für **fc44/aarch64** überhaupt? (→ 2)
- [ ] `--assumeno`-Vorschau protokollieren: wie viele Pakete kommen aus Terra,
      wird `qt6-qtbase` angehoben? (→ 3, Risiko 1)
- [ ] Handstart nach 4.1: startet die Shell unter `LIBGL_ALWAYS_SOFTWARE=1`?
      Ausgabe vollständig in diese Notiz übernehmen (→ 4.1 auf ✅ oder ❌)
- [ ] Material-Symbols: vom RPM mitgeliefert oder fehlend? (→ 3.1)
- [ ] **`/etc`-Override-Messung** und Rückmeldung nach
      [[09-yoga-buildumgebung]] (→ 5.1) — höchster Erkenntniswert pro Aufwand
- [ ] `mako` aus der Sitzung nehmen und gegenprüfen, wer
      `org.freedesktop.Notifications` hält (`busctl --user list | find -i notif`)
- [ ] `settings.json`-Schlüsselbaum dokumentieren, **nachdem** er existiert (→ 7)
- [ ] Entscheidung nachtragen: v4 (`-legacy`) oder v5-Track — steht in
      [[09-yoga-buildumgebung]] als offener Punkt und betrifft beide Umgebungen
- [ ] `terra-obsolete`-Versionsgrenze als Upstream-Bug an Fyra Labs melden
- [ ] `verifiziert_gegen:` im Frontmatter füllen, sobald Punkt 3 durch ist

---

## Kernaussagen in vier Sätzen

`WLR_RENDERER=pixman` rettet Sway, aber nicht Noctalia: Quickshell ist ein
Qt6-Client und braucht einen eigenen GL-Pfad, der auf diesem Gerät nur über
Mesas llvmpipe (`LIBGL_ALWAYS_SOFTWARE=1`) existiert. Terra ist im
Containerfile ein einmaliges Ereignis, auf einer mutablen Distro dagegen ein
dauerhafter Mitspieler — deshalb `enabled=0` und gezielte Aktivierung statt
der Image-Fassung. Der Terra-Weg ist trotzdem richtig, weil nur er dieselbe
Quickshell-Variante testet, die das Image ausliefert. Und die billigste
Erkenntnis dieser Runde ist keine Noctalia-Erkenntnis: ob `/etc` das
`/usr/share`-Drop-in überschattet, lässt sich hier in zwei Minuten klären —
im Image kostet dieselbe Frage einen Build.
