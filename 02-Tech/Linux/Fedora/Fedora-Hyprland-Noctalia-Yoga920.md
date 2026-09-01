---
titel: Fedora + Hyprland + Noctalia auf dem Lenovo Yoga 920-13IKB
aliases: [Fedora Hyprland Noctalia, Yoga 920 Neuaufsetzen]
tags: [linux, fedora, hyprland, noctalia, quickshell, nushell, convertible, yoga]
erstellt: 2026-06-26
system: Lenovo Yoga 920-13IKB
status: anleitung
---

# [[Fedora]] + [[Hyprland]] + [[Noctalia]] auf dem Lenovo Yoga 920-13IKB

> [!abstract] Ziel & Stack
> Das Yoga 920 wird **komplett neu** und als **Alleinsystem** mit Fedora aufgesetzt — **kein Dual-Boot** mehr:
> - **Fedora** als Distro (Anaconda, GRUB, schneller Wayland-Stack)
> - **Hyprland** als Compositor/Tiling-WM (0.55+, **Lua-Config**)
> - **Nushell** als Standard-Shell
> - **Noctalia** als Shell-Schicht (Bar, Launcher, Notifications, Lockscreen, Control-Center), gebaut auf **Quickshell**
>
> Hardware-Plus: Das 920 hat **Intel UHD 620** (keine NVIDIA) → idealer Wayland-Untergrund. Schwachpunkt: der Convertible-/Touch-/Pen-Teil ist bei Hyprland Handarbeit → eigener Abschnitt unten.

> [!note] CachyOS zieht um
> [[CachyOS]] (Limine) läuft ab jetzt **nur** noch auf dem Desktop mit der NVIDIA-Karte. Auf dem Yoga gibt es dadurch **keine gemeinsame ESP**, keine Limine-Chainload-Akrobatik und keine „CachyOS nicht anfassen"-Warnungen mehr. Die Desktop-Einrichtung ist separat dokumentiert (siehe [[CachyOS]] — Dateiname ggf. anpassen).

---

## 1. Vorbereitung

> [!warning] Das hier löscht das Yoga
> Diese Anleitung setzt das Yoga **vollständig neu** auf. Ein evtl. noch vorhandenes CachyOS/System auf dem Laptop wird **überschrieben**. Vorher **persönliche Daten sichern**.

### Live-Medium

- **Fedora Everything (netinstall)** von [fedoraproject.org](https://fedoraproject.org/) ziehen — minimaler Start ohne GNOME-Ballast. (Workstation ginge auch, aber dann GNOME hinterher abräumen.)
- Im Yoga-BIOS (`F2` / `Fn+F2`):
  - **Secure Boot → Off** (COPR-Pakete und unsignierte Kernelteile sonst lästig).
  - Boot per `F12`-Menü oder USB nach vorn.

### GPU prüfen (sollte nur Intel zeigen)

```nu
sudo dnf install pciutils  
lspci | lines | find --ignore-case vga 3d
```

> [!warning] Nushell erst ab Abschnitt 4
> Bis Nushell installiert und aktiv ist, tippst du die ersten Befehle in der **Bash** des Installers/Erststarts. Reine `sudo dnf install …`-Aufrufe sind in beiden Shells identisch; die Nushell-spezifische Syntax (`http get`, `| ignore`, `try/catch`, `$"…"`, `let`/`if`) greift erst, sobald du Nushell startest (Abschnitt 4). Die betroffenen Stellen sind markiert.

---

## 2. Fedora installieren (Alleinsystem, ganze Platte)

Da kein Dual-Boot mehr nötig ist, kannst du die **gesamte Platte** verwenden.

### Variante A — Automatisch (einfach)

Im Installer **„Automatic"** wählen und die vorhandenen Partitionen zum Zurückgewinnen freigeben. Anaconda legt dann sauber ESP + `/boot` + Btrfs-`/` an. Für ein Alleinsystem völlig ausreichend.

### Variante B — Manuell (reproduzierbar)

**Custom / Manuelle Partitionierung** → alte Partitionen entfernen, neu anlegen:

| Partition | Größe | Typ / FS | Mountpoint |
|---|---|---|---|
| **EFI System Partition** | ~1 GiB | EFI System Partition (FAT32) | `/boot/efi` |
| **Boot** | ~1 GiB | ext4 | `/boot` |
| **Root** | Rest | btrfs | `/` |

> [!tip] Swap für Hibernate mitdenken
> Fedoras Standard-zram reicht für **Suspend-then-Hibernate** nicht. Wenn du Hibernate willst, planst du einen **Btrfs-Swapfile** ein (Details in [[Hibernate einrichten]] — vorher `mem_sleep` prüfen: S3 vs. s2idle).

### Software-Auswahl

Bei „Software Selection" als Environment **Fedora Custom Operating System** wählen (kargste Basis, kein Desktop — Hyprland/Noctalia kommen danach gezielt). Nutzer mit `sudo`/`wheel` anlegen, Zeitzone `Europe/Berlin`.

> [!important] WLAN gleich mitnehmen (das Yoga hat kein Ethernet)
> Rechts bei „Additional Software" die Gruppe **Common NetworkManager Submodules** ankreuzen — sie enthält `NetworkManager-wifi` (plus Bluetooth/WWAN-Module). Ohne sie ist WLAN nach dem ersten Boot **unsichtbar**, obwohl der Treiber läuft. Die Firmware des Intel-WLAN-Chips steckt bereits in `linux-firmware` (`@core`); die auf „Custom" fehlende Gruppe „Hardware Support" wird dafür nicht benötigt.

> [!tip] WLAN schon im Installer verbinden
> Beim Schritt „Network & Hostname" das WLAN verbinden — der Netinstall braucht ohnehin Netz, und Anaconda übernimmt die Verbindung ins installierte System.

---

## 3. Basis & Netzwerk-Verifikation (noch Bash)

Nach Installation und erstem Reboot Basis aktualisieren:

```nu
sudo dnf upgrade --refresh
```

WLAN verifizieren (Gruppe „Common NetworkManager Submodules" aus Abschnitt 2 macht es sichtbar):

```nu
rpm -q NetworkManager-wifi
nmcli device status
```

Zeigt `nmcli` das Gerät als `wifi`/`connected`, ist alles gut. Falls nicht schon vom Installer übernommen:

```nu
nmcli device wifi connect "<SSID>" password "<passwort>"
```

> [!warning] Fallback: Gruppe im Installer vergessen
> Ohne die Gruppe fehlt `NetworkManager-wifi` — WLAN bleibt für `nmcli`/Noctalia unsichtbar, obwohl der Treiber läuft. Da das Yoga keinen Ethernet-Port hat: Netz per **USB-Tethering** vom Handy (läuft ohne WLAN-Plugin) oder USB-Ethernet-Adapter herstellen, dann:
> ```nu
> sudo dnf install NetworkManager-wifi
> sudo systemctl restart NetworkManager
> ```

---

## 4. Nushell installieren & als Shell setzen

Noch in Bash installieren (Binary heißt `nu`):

```nu
sudo dnf copr enable atim/nushell
sudo dnf install nushell
```

> [!warning] Paketquelle
> Der `atim/nushell`-COPR ist der übliche Fedora-Weg. Alternativ die offizielle Gemfury-Repo (`https://yum.fury.io/nushell/`) für die jeweils neueste Version. Build-Stand vor dem Festlegen kurz prüfen.

Jetzt **einmalig Nushell starten** und ab hier alles nativ in Nu:

```nu
nu
```

Nu in `/etc/shells` eintragen (falls nötig) und als Login-Shell setzen:

```nu
let nupath = (which nu | get path | first)
if ($nupath not-in (open /etc/shells | lines)) { $nupath | sudo tee -a /etc/shells | ignore }
sudo usermod --shell $nupath (whoami | str trim)
```

> [!note] Grafische Session unberührt
> Die Login-Shell betrifft TTY/Terminal. Die Wayland-Session wird über die `.desktop`-Datei gestartet, nicht über die Login-Shell — die Umstellung ist also unkritisch. Feinschliff der Nu-Konfiguration in [[02-nushell-konfigurieren]].

---

## 5. [[Hyprland]] + [[Noctalia]] installieren

Fedora liefert Hyprland **nicht** offiziell (F43/F44 haben es entfernt). Die [Hyprland-Wiki](https://wiki.hypr.land/Getting-Started/Installation/) verweist für Fedora inzwischen auf die COPR **`lionheartp/Hyprland`** — ein Fork von `solopasha/hyprland`, der **zusätzlich `noctalia-shell`** mitbaut (F43/F44, x86_64 **und** aarch64). Damit kommen Compositor **und** Shell aus **einer** Quelle — genau das „nur eine Quelle"-Prinzip.

> [!warning] Nur EINE Quelle je Baustein
> Mehrere Hyprland-COPRs mischen bricht `libdisplay-info`/ABI. Genau **einen** Hyprland-COPR wählen — und `noctalia-shell` nur aus **einer** Quelle ziehen (lionheartp **oder** Terra, nicht beide).

### Schritt 1 — lionheartp-COPR aktivieren

```nu
sudo dnf copr enable lionheartp/Hyprland
# Fallback-COPRs, falls kein Build für deine Fedora-Version (open /etc/fedora-release):
#   sudo dnf copr enable ashbuk/Hyprland-Fedora
#   sudo dnf copr enable nett00n/hyprland
#   sudo dnf copr enable solopasha/hyprland
```

### Schritt 2 — installieren (Hyprland + Noctalia aus einer Quelle)

```nu
sudo dnf install hyprland xdg-desktop-portal-hyprland noctalia-shell
```

> [!note] noctalia-qs
> `noctalia-shell` zieht **noctalia-qs** (Quickshell-Runtime) automatisch nach. Hast du bereits `quickshell`/`quickshell-git`, vorher entfernen — die Pakete **konfligieren**.

> [!tip] Alternative: Noctalia aus Terra
> Willst du Noctalia lieber von [Terra](https://terra.fyralabs.com/) (Fyra Labs) statt aus lionheartp, **vor** Schritt 2 das Repo einbinden und `noctalia-shell` dann **nur** von dort installieren:
> ```nu
> sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release terra-gpg-keys
> ```

> [!warning] Bleeding-Edge auf Fedora
> Hyprland garantiert offiziell nur Arch/NixOS; auf Fedora läuft es per COPR meist gut, ist aber sehr bleeding-edge. Build-Datum der gewählten COPR vorab auf copr.fedorainfracloud.org prüfen. `xdg-desktop-portal-hyprland` ist fürs Screensharing; Lockscreen/Idle/Wallpaper deckt Noctalia selbst ab.

### Login-Manager & Session

Noctalia bringt **keinen** Display-Manager mit (nur Lockscreen):

```nu
sudo dnf install sddm
sudo systemctl set-default graphical.target   # sonst bootet Custom-Install in multi-user.target → SDDM startet nie
sudo systemctl enable --now sddm
```

> [!warning] SDDM startet nach Reboot nicht?
> Häufigste Ursache beim Custom-/Minimal-Install: Default-Target ist `multi-user.target`, also wird `graphical.target` (und damit `display-manager.service`) nie erreicht — obwohl `sddm` „enabled" ist. Prüfen und fixen:
> ```nu
> systemctl get-default                          # zeigt dann multi-user.target
> sudo systemctl set-default graphical.target
> sudo systemctl enable --now sddm
> ```

Hyprland legt eine Wayland-Session (`hyprland.desktop`) an, die SDDM anzeigt. Aus der TTY startest du mit **`start-hyprland`** (Wrapper mit Crash-Recovery/Safe-Mode seit v0.55, Flags via `start-hyprland -- -h`). **Fehlt der Befehl** (`command not found`), bringt dein COPR-Build den Wrapper nicht mit → nimm das rohe Binary `Hyprland`. Version prüfen (Lua-Config braucht ≥ 0.55): `Hyprland --version`.

> [!tip] Ohne Display-Manager: Autostart auf tty1 (Nushell)
> SDDM weglassen und beim TTY-Login starten — da die Login-Shell Nushell ist, in `~/.config/nushell/login.nu` (wählt automatisch Wrapper **oder** rohes Binary):
> ```nu
> if (tty | str trim) == "/dev/tty1" and ("WAYLAND_DISPLAY" not-in $env) {
>     let hypr = (if (which start-hyprland | is-not-empty) { "start-hyprland" } else { "Hyprland" })
>     exec $hypr
> }
> ```
> `exec` ersetzt die Shell; beim Beenden bist du ausgeloggt. Für Portale/Screensharing ggf. `graphical-session.target` anstoßen oder **uwsm** nutzen (Hyprland-Wiki „Systemd startup").

### Fonts (Noctalia braucht Material Symbols)

```nu
sudo dnf install rsms-inter-fonts fira-code-fonts
mkdir ~/.local/share/fonts
# eckige Klammern MÜSSEN kodiert sein: [ → %5B , ] → %5D (sonst scheitern http get UND curl)
http get "https://github.com/google/material-design-icons/raw/master/variablefont/MaterialSymbolsRounded%5BFILL,GRAD,opsz,wght%5D.ttf" | save ~/.local/share/fonts/MaterialSymbolsRounded.ttf
fc-cache -f
ls ~/.local/share/fonts/MaterialSymbolsRounded.ttf   # ~15 MB → Download ok
```

> [!tip] Geprüft + Fallback
> Pfad verifiziert (Branch `master`, Ordner `variablefont`); der Download ist eine gültige TrueType-Datei (~15 MB). Die **kodierten** Klammern sind Pflicht — mit rohen `[ ]` bricht sowohl `http get` als auch `curl` ab. curl-Variante:
> ```nu
> curl -L "https://github.com/google/material-design-icons/raw/master/variablefont/MaterialSymbolsRounded%5BFILL,GRAD,opsz,wght%5D.ttf" -o ~/.local/share/fonts/MaterialSymbolsRounded.ttf
> ```

---

## 6. Hyprland-Config (Lua) & Noctalia-Autostart

> [!important] Seit Hyprland 0.55: Lua statt hyprlang
> Die Config liegt in `~/.config/hypr/hyprland.lua` und nutzt die `hl.*`-API. Die alte `hyprland.conf` (hyprlang) läuft noch ein bis zwei Releases, ist aber **deprecated** — **nicht mischen**. Tool-Ausgaben im alten Format also manuell nach Lua übersetzen. LSP-Stubs liegen unter `/usr/share/hypr/stubs/`.

Grundgerüst in `~/.config/hypr/hyprland.lua`:

```lua
-- Monitor (bei 4K-Panel: scale = 2, siehe Abschnitt 7)
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = "auto" })

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia-shell")   -- ersetzt Bar/Launcher/Notifications/Lock/Idle/Wallpaper
    hl.exec_cmd("iio-hyprland")     -- Auto-Rotation (Convertible, Abschnitt 7)
end)
-- Manuelle Noctalia-Installation stattdessen: hl.exec_cmd("qs -c noctalia-shell")

-- Tastatur / Touchpad / Gesten
hl.config({
    input = {
        kb_layout = "de",              -- sonst us! (Kitty & alles andere)
        kb_variant = "nodeadkeys",     -- optional: ^ ´ ` direkt statt Totasten
        touchpad = { natural_scroll = true },
    },
})
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Keybinds
local mainMod = "SUPER"
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))
```

> [!note] exec_cmd läuft über /bin/sh
> Von Hyprland gestartete Nu-Skripte müssen externe `.nu`-Dateien sein, keine inline-Nu-Ausdrücke. Genaues Compositor-Setup (Blur, Fensterregeln) stellt Noctalia komfortabel über *Settings → Compositor → Hyprland* ein.

---

## 7. Convertible-Tuning fürs Yoga 920 (der Handarbeits-Teil)

### Auto-Rotation (Sensor → Display dreht mit)

```nu
sudo dnf install iio-sensor-proxy git make gcc
monitor-sensor        # sollte Orientierungswechsel melden

git clone https://github.com/JeanSchoeller/iio-hyprland
cd iio-hyprland
sudo make install
```

`iio-hyprland` wird über den Autostart aus Abschnitt 6 gestartet und dreht Output **und** Touch-Geräte mit. Stimmt die Achse nicht, mit `--transform 0,1,2,3` justieren. Alternative: **rot8** (Rust).

### Deckel-Verhalten (Lid-Switch) per Drop-in

Statt `logind.conf` direkt zu editieren, ein Drop-in anlegen (Nushell mit `sudo tee`):

```nu
sudo mkdir /etc/systemd/logind.conf.d
"[Login]
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=ignore
" | sudo tee /etc/systemd/logind.conf.d/10-deckel.conf | ignore
```

> [!warning] „Flip to Boot" gibt es hier nicht
> Das Aufwecken aus S5 per Deckel-Öffnen existiert erst auf post-2019/2020-Yogas, **nicht** auf dem 920-13IKB — softwareseitig nicht nachrüstbar.

### On-Screen-Keyboard (Tablet-Modus)

```nu
try { sudo dnf install wvkbd } catch { print "wvkbd ggf. via COPR/Eigenbau" }
wvkbd-mobintl -L 280
```

Per Keybind oder Noctalia-Widget togglen. Alternative: `onboard`.

### Pen / Active Pen

Läuft über **libinput** out of the box (Bewegung, Klick). Druckstufen nutzt du in **Krita** oder **Xournal++**. Bei nur einem Display kein manuelles Tablet-Mapping nötig.

### 4K-Variante: Scaling

Hat dein 920 das UHD-Panel, in `hyprland.lua` statt der `preferred`-Zeile:

```lua
-- sauberes Integer-Scaling (effektiv 1920x1080):
hl.monitor({ output = "eDP-1", mode = "3840x2160@60", position = "0x0", scale = 2 })
-- oder mehr Fläche via fractional (Noctalia unterstützt das):
-- hl.monitor({ output = "eDP-1", mode = "3840x2160@60", position = "0x0", scale = 1.5 })
```

### TTY-Schrift für HiDPI (Text-Konsole)

> [!info] Auflösung bleibt nativ
> Die native 4K-Auflösung **nicht** senken (wird unscharf) — stattdessen den **Font** der Text-Konsole (Ctrl+Alt+F-TTYs, Boot-Meldungen) vergrößern. Der Kernel-Standardfont ist auf 4K mikroskopisch.

**Weg 1 — Kernel-Font erzwingen (kein Paket).** Der Fedora-Kernel bringt neben `VGA 8x16` den HiDPI-Font `TER16x32` (doppelt so groß) mit; die Auto-Erkennung greift nicht immer:

```nu
sudo grubby --update-kernel=ALL --args="fbcon=font:TER16x32"
```

Nach Reboot aktiv. Tut sich nichts, ist der Font im Kernel nicht kompiliert → Weg 2.

**Weg 2 — Terminus über `vconsole.conf` (zuverlässig, mehr Größen).**

```nu
sudo dnf install terminus-fonts-console
setfont ter-v32n          # sofort in aktueller TTY testen
```

Dauerhaft die `FONT=`-Zeile idempotent setzen (ersetzt eine evtl. vorhandene, statt zu doppeln) und in die initramfs backen (gilt dann ab den ersten Boot-Meldungen):

```nu
let lines = (if ("/etc/vconsole.conf" | path exists) { open /etc/vconsole.conf | lines } else { [] })
$lines | filter {|l| not ($l | str starts-with "FONT=") } | append "FONT=ter-v32n" | append "" | str join (char newline) | sudo tee /etc/vconsole.conf | ignore
sudo dracut --force --regenerate-all
```

`ter-v32n` (32 px) ist die größte übliche Stufe; falls zu wuchtig `ter-v28n`/`ter-v24n`/`ter-v22n`, fett `ter-v32b`. Kontrolle: `open /etc/vconsole.conf`.

> [!tip] GRUB-Menü ist ebenfalls winzig (optional)
> In `/etc/default/grub` `GRUB_GFXMODE=1920x1080` setzen (kleinerer gfxmode → größere Menüschrift), dann neu generieren:
> ```nu
> sudo grub2-mkconfig -o /boot/grub2/grub.cfg
> ```

> [!note] Getrennt von Hyprland
> Das betrifft nur die Text-Konsole. Die grafische Hyprland-Session skalierst du über `hl.monitor({ … scale = 2 })` (oben).

### Fingerprint (optional, hit or miss)

```nu
sudo dnf install fprintd fprintd-pam
fprintd-enroll
```

> [!warning] Unzuverlässig
> Der Reader im 920 funktioniert je nach Modell/Firmware nicht immer sauber — als „nice to have" behandeln.

---

## 8. Userland (empfohlen, aber optional)

Deinen gewohnten Stack nachziehen — Konfiguration jeweils in eigener Notiz:

```nu
sudo dnf install kitty starship helix dolphin
# Portals (KDE-Dateidialog) + Qt-Theming
sudo dnf install xdg-desktop-portal-kde qt6ct kvantum
```

### Vivaldi (offizielles Repo statt Versions-URL)

Vivaldi ist nicht in den Fedora-Repos. **Keine** feste Versions-URL nehmen (`downloads.vivaldi.com/.../vivaldi-stable-<version>.rpm` → 404, sobald eine neue Version erscheint), sondern das offizielle Repo einbinden — dann aktualisiert `dnf upgrade` Vivaldi mit:

```nu
sudo rpm --import https://repo.vivaldi.com/archive/linux_signing_key.pub
"[vivaldi]
name=Vivaldi
baseurl=https://repo.vivaldi.com/archive/rpm/$basearch
enabled=1
gpgcheck=1
gpgkey=https://repo.vivaldi.com/archive/linux_signing_key.pub
" | sudo tee /etc/yum.repos.d/vivaldi.repo | ignore

sudo dnf install vivaldi-stable
vivaldi --version
```

`$basearch` bleibt in Nu-Doublequotes literal (keine Interpolation) → als dnf-Variable erhalten; dieselbe Datei passt auch für aarch64.

> [!warning] Fedora 44 = dnf5: `--add-repo` ist weg
> Der offizielle Einzeiler `dnf config-manager --add-repo …` bricht auf F44 ab. dnf5-Syntax:
> ```nu
> sudo dnf config-manager addrepo --from-repofile=https://repo.vivaldi.com/stable/vivaldi-fedora.repo
> sudo dnf install vivaldi-stable
> ```

> [!note] Obsidian unter Hyprland
> Obsidian läuft per Default über XWayland. Fix per Flatpak-Wayland-Override:
> ```nu
> flatpak override --user --socket=wayland --unshare=ipc --nosocket=x11 md.obsidian.Obsidian
> ```

Config-Notizen: [[02-nushell-konfigurieren]] · Kitty/Solarized · Starship · Helix.

---

## 9. Erster Login

Reboot → SDDM → Session **Hyprland** wählen. Beim ersten Noctalia-Start werden ein paar Defaults abgefragt (u. a. Dock). Settings danach per Noctalia-UI. Optionale Features: `wlsunset` (Night Light), `cava` (Audio-Visualizer), `brightnessctl` (Helligkeit):

```nu
sudo dnf install wlsunset cava brightnessctl
```

---

## 10. Troubleshooting

| Symptom | Ursache / Fix |
|---|---|
| WLAN unsichtbar für `nmcli`/Noctalia | Gruppe „Common NetworkManager Submodules" im Installer vergessen → USB-Tethering + Fallback in Abschnitt 3 |
| Quickshell-Konflikt bei Noctalia-Install | `quickshell`/`quickshell-git` vorher entfernen — `noctalia-qs` ersetzt es |
| Leere/abgestürzte Bar | Material-Symbols-Font fehlt → Abschnitt 5 Fonts |
| `hyprland.lua` wird nicht geladen / Binds fehlen | Lua-Syntaxfehler vor den Binds → Notfall-Binds `SUPER+Q` (Terminal), `SUPER+R` (Run), `SUPER+M` (Exit); Fehlerpopup lesen |
| Alte `.conf`-Syntax greift nicht | 0.55+ nutzt `hyprland.lua`; nicht mit hyprlang mischen |
| Auto-Rotation träge/falsch herum | `--transform`-Werte in `iio-hyprland` anpassen; `monitor-sensor` zum Debuggen |
| Obsidian unscharf/XWayland | Flatpak-Wayland-Override → Abschnitt 8 |
| Hyprland zu alt / kein Build (COPR) | anderen Hyprland-COPR wählen (Build-Datum prüfen): lionheartp → ashbuk → nett00n → solopasha |
| SDDM startet nach Reboot nicht | Default-Target ist `multi-user` → `sudo systemctl set-default graphical.target`, dann `enable --now sddm` |
| `start-hyprland: command not found` | COPR-Build ohne Wrapper → `Hyprland` nutzen; Version mit `Hyprland --version` prüfen (Lua ≥ 0.55) |
| Tastatur ist US (auch in Kitty) | `kb_layout` fehlt → `input = { kb_layout = "de" }` in `hyprland.lua`; live: `hyprctl keyword input:kb_layout de` |

---

## 11. Aufgaben

- [ ] Fedora Everything (netinstall) gebootet, Secure Boot aus
- [ ] Ganze Platte partitioniert, Environment **Fedora Custom Operating System**
- [ ] Gruppe **Common NetworkManager Submodules** angekreuzt, WLAN im Installer verbunden
- [ ] Basis aktualisiert, WLAN nach erstem Boot verifiziert (`nmcli device status`)
- [ ] Nushell installiert, in `/etc/shells`, als Login-Shell gesetzt
- [ ] **lionheartp**-COPR aktiviert (o. Terra), `hyprland` + `noctalia-shell` installiert
- [ ] SDDM aktiviert, Material Symbols installiert
- [ ] `hyprland.lua` mit Noctalia-Autostart + Keybinds angelegt
- [ ] Convertible: `iio-hyprland`, `wvkbd`, Deckel-Drop-in
- [ ] (4K) TTY-Schrift vergrößert (`fbcon=font:TER16x32` oder `FONT=ter-v32n`)
- [ ] (optional) Kitty/Starship/Helix/Dolphin/Vivaldi + qt6ct/Kvantum
- [ ] Hibernate/Swap geprüft → [[Hibernate einrichten]]

---

## 12. Bewertung in einem Satz

Als **Alleinsystem** auf dem Intel-iGPU-Yoga ist die Kombination stimmig und wartbar — ohne Dual-Boot fällt der fehleranfälligste Teil (gemeinsame ESP, Bootloader-Chainload) weg; die **Convertible-Ergonomie** (Auto-Rotation, OSK, Pen) bleibt Bastelarbeit. Noctalia ist hübsch, aber jung → fürs Tinkering ideal, als alleiniges Produktivsystem mit Vorsicht.

---

## Referenzen

- Hyprland – Lua-Config (Start): <https://wiki.hypr.land/Configuring/Start/>
- Hyprland 0.55 „Lua-ification": <https://hypr.land/news/26_lua/>
- Noctalia (GitHub): <https://github.com/noctalia-dev/noctalia>
- Noctalia Docs – Installation: <https://docs.noctalia.dev/v4/getting-started/installation/>
- Noctalia Docs – Hyprland Compositor Settings: <https://docs.noctalia.dev/v4/getting-started/compositor-settings/hyprland/>
- Hyprland-COPR (lionheartp, Wiki-Empfehlung): <https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland/>
- Terra (Fyra Labs): <https://terra.fyralabs.com/>
- Nushell – Installation: <https://www.nushell.sh/book/installation.html>
- iio-hyprland (Auto-Rotation): <https://github.com/JeanSchoeller/iio-hyprland/>
- rot8 (Alternative): <https://github.com/efernau/rot8>

Siehe auch: [[Hyprland]] · [[Noctalia]] · [[Quickshell]] · [[Nushell]] · [[02-nushell-konfigurieren]] · [[Hibernate einrichten]] · [[iio-sensor-proxy einrichten]] · [[CachyOS]]
