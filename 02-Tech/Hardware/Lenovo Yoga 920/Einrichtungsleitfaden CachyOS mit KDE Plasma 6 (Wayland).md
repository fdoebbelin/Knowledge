## TL;DR

- **Realistisches Ergebnis**: Auto-Rotation (inkl. 180°-Tent) ist mit `iio-sensor-proxy` und Plasma 6 nativ machbar; Maliit als OSK lässt sich sauber in Plasma 6 integrieren; das automatische **Sperren von Tastatur/Touchpad über `SW_TABLET_MODE` ist beim YOGA 920 hingegen nicht garantiert**, weil kein in-tree-Kernel-Modul (`lenovo-ymc`, `intel-hid`, `ideapad-laptop`) den 920er in seiner DMI-/WMI-Allowlist hat. Plan B über ein Accelerometer-getriggertes Skript funktioniert zuverlässig.
- **Kernfeststellung 920-spezifisch**: Auf dem YOGA 920 (Type 80Y7, 13IKB, Kaby‑Lake‑R) sollte `ideapad_laptop` blacklisted werden (sonst kein WLAN), wodurch ohnehin keine Tablet‑Mode‑Events von dort kommen. `yoga-usage-mode-dkms-git` aus dem AUR ist einen Versuch wert (WMI‑Binding über GUID `06129D99-6083-4164-81AD-F092F9D773A6`), aber laut README dort nur für IdeaPad Flex 14API, Yoga 6 13ALC6/7 und Yoga C940-14IIL als getestet bestätigt — kein Eintrag für das 920er.
- **Empfehlung**: Plasma‑natives Auto‑Rotation aktivieren, Maliit über `kwinrc` einrichten und einen kleinen Helfer (Nushell/Bash) bauen, der `monitor-sensor`-Output (`bottom-up`/`normal`) auf KWin‑DBus‑Properties (`enabled` für Touchpad, `VirtualKeyboard.active`) abbildet — das ist auf dem YOGA 920 die robusteste Variante.

---

## Key Findings

### A) Hardware-Erkennung (YOGA 920 spezifisch)

- **`SW_TABLET_MODE`-Quelle ist beim YOGA 920 nicht offiziell vorhanden.** Keiner der drei plausiblen Treiber listet den 920er explizit:
  - `lenovo-ymc` (Kernel ≥ 6.4) bindet per WMI‑GUID. Phoronix schreibt zur Einführung des Treibers wörtlich: *„Linux 6.4 is set to see the new ‚lenovo-ymc‘ driver added that is for tablet mode switching on Lenovo Yoga notebooks like the Yoga 7 14AIL7, Yoga C940, Ideapad Flex 14API, Yoga 9 14IAP7, Yoga 7 14ARB7, and other models."* — der Yoga 920 wird **nicht** genannt.
  - `intel-hid` hat eine harte DMI‑Allowlist `dmi_vgbs_allow_list`. Im Kernelquelltext `drivers/platform/x86/intel/hid.c` (v6.6.1) sind exakt drei Einträge enthalten: *„HP Spectre x360 Convertible 15-df0xxx"*, *„Microsoft Corporation Surface Go"* und *„HP Elite Dragonfly G2 Notebook PC"*. Ein einzelner Dell‑Eintrag (Dell 16 Plus 2-in-1) wurde erst per LKML‑Patch vom 13. Februar 2026 vorgeschlagen — Lenovo ist in der Liste **gar nicht** vertreten.
  - `ideapad-laptop` muss auf dem 920er ohnehin blacklisted werden, weil es WLAN blockiert (siehe gmpreussner Arch‑Guide: *„The ideapad_laptop kernel module … prevents the WiFi from being turned on. It is best to blacklist it."*).
- **`yoga-usage-mode-dkms-git` (AUR)** ist der vielversprechendste Workaround: Es bindet per WMI‑GUID. Im README sind nur *IdeaPad Flex 14API, Yoga 6 13ALC6/7 und Yoga C940-14IIL* als getestet aufgeführt. Für das 920er existiert keine bestätigte Erfolgsmeldung — Anlauf lohnt sich aber, da das Modul eher per WMI‑Methode als per DMI bindet.
- **Beschleunigungssensor (Accelerometer)** funktioniert auf dem 920er via `iio-sensor-proxy` zuverlässig. Damit sind Auto‑Rotation und Tent‑Erkennung in jedem Fall realisierbar.
- **Touchscreen** (Wacom HID, ID `WCOM5128:00 056A:5128`) und Active Pen 2 funktionieren mit aktuellen Kerneln out‑of‑the‑box.

### B) Auto-Rotation in Plasma 6 / Wayland

- Seit Plasma 5.20 / Wayland funktioniert Auto‑Rotation nativ über das Display‑KCM, sobald `iio-sensor-proxy` läuft. **In Plasma 6.6+ ist `qt6-sensors` (Paket `qt6-sensors`) zwingend nötig**, sonst bleiben die KCM‑Optionen ausgegraut. Diskussion und Bestätigung im KDE‑Discuss‑Thread „KDE Plasma 6.6, Convertible 2-in-1 laptop, screen rotation, touch mode not starting" (3. Mai 2026), in dem `qtsensors` ausdrücklich als *„newly required"* in Plasma 6.6 für funktionierende Auto‑Rotation und Touch‑Mode‑Optionen bezeichnet wird.
- Native Optionen unter **Systemeinstellungen → Anzeige & Monitor → (Display auswählen) → Ausrichtung → Automatisch** sowie **„Automatisch nur im Tablet‑Modus"**.
- Plasma 6 erkennt 90°‑, 180°‑ und 270°‑Rotationen, weil KWin im Wayland‑Compositor seit Plasma 5.18/5.19 echte Output‑Rotation als Post‑Processing‑Schritt unterstützt.
- **Tent‑Modus (180°)**: Plasma stützt sich auf die Accelerometer‑Orientierung (`bottom-up`). Wenn die Mount‑Matrix korrekt ist, dreht Plasma im Tent automatisch — sonst muss per `60-sensor.hwdb`/`61-sensor-local.hwdb`‑Eintrag korrigiert werden.
- Manuelle Steuerung per CLI: `kscreen-doctor output.eDP-1.rotation.{none|left|right|inverted}`. **`wlr-randr` funktioniert unter KWin nicht.**

### C) Maliit-OSK in Plasma 6

- Plasma 6 nutzt Maliit als nativen Wayland‑OSK. Pakete: `maliit-keyboard` (Repo `extra`). `qt6-virtualkeyboard` ist eine **Alternative**, jedoch nicht die Plasma‑native Wahl — sie wird primär in SDDM/Greeter eingesetzt.
- Konfiguration über **Systemeinstellungen → Tastatur → Virtuelle Tastatur → „Maliit Keyboard"**.
- Unterm Deck schreibt das in `~/.config/kwinrc`:
  ```ini
  [Wayland]
  InputMethod=/usr/share/applications/com.github.maliit.keyboard.desktop
  VirtualKeyboardEnabled=true
  ```
- Plasma blendet Maliit automatisch ein, sobald **Touch‑Modus** aktiv ist ODER ein Textfeld via Touch fokussiert wird. Steuerung des Verhaltens über `qdbus6 org.kde.KWin /VirtualKeyboard …`.
- **Bekannter Bug** (Mai 2026, offen): GitHub‑Issue `maliit/keyboard#210` *„kde plasma 6, all mouse input is blocked when maliit is activated"* (gemeldet auf Arch Linux): *„when the virtual keyboard activates, all mouse input is blocked and doesn't come back without a full restart of kwin."* Tritt nicht universell auf — am 920er testen; Workaround: `qt6-virtualkeyboard` als Backup.

### D) Tastatur/Touchpad im Tablet-Modus

- `libinput` deaktiviert automatisch interne Tastatur und Touchpad, **sobald** ein Gerät mit `SW_TABLET_MODE`-Switch existiert und auf 1 schaltet (siehe libinput‑Doku zu Switches).
- Auf dem YOGA 920 fehlt aber genau dieser Switch (siehe A). Daher entweder:
  1. `yoga-usage-mode-dkms-git` ausprobieren und auf einen funktionierenden `SW_TABLET_MODE` hoffen, oder
  2. ein eigenes Skript bauen, das `monitor-sensor`‑Events in KWin‑DBus‑Befehle übersetzt (Touchpad `enabled=false`, VirtualKeyboard `enabled=true`). Das ist Plan B mit der höchsten Erfolgsquote.
- Plasma 6 unterstützt seit 6.1 in den **Workspace‑Behaviour‑Einstellungen** den Schalter **„Touch‑Modus"** (Werte `auto`, `on`, `off`), abgelegt unter `kwinrc → [Input] TabletMode=`.

### E) Architektur-Entscheidungen am YOGA 920

| Komponente | Lösung | Verlässlichkeit am 920 |
|---|---|---|
| Auto-Rotation (alle Winkel) | `iio-sensor-proxy` + Plasma‑KCM | hoch |
| Mount-Matrix-Korrektur | `/etc/udev/hwdb.d/61-sensor-yoga920.hwdb` | bei Bedarf |
| OSK | Maliit über `kwinrc` | hoch |
| Tablet-Mode-Switch | `yoga-usage-mode-dkms-git` (Versuch) → fallback Skript | unsicher / mittel |
| Tastatur/Touchpad-Sperre | libinput automatisch IF SW_TABLET_MODE — sonst Skript via DBus | mittel |

---

## Details

### 1) Pakete installieren

Mit `pacman` (offizielle Repos):

```bash
sudo pacman -S iio-sensor-proxy maliit-keyboard qt6-sensors qt6-virtualkeyboard \
               libinput evtest acpid systemd
```

Aus dem AUR (mit `paru`) — den Tablet‑Mode‑Treiber probehalber:

```bash
paru -S yoga-usage-mode-dkms-git
```

Optional (falls `iio-sensor-proxy` aus den Repos nach Suspend Probleme macht — bei der Yoga‑9er‑Serie dokumentiert):

```bash
paru -S iio-sensor-proxy-git
```

`qt6-sensors` ist seit Plasma 6.6 zwingend nötig, damit der Touch‑Modus / die Auto‑Rotation überhaupt im KCM erscheinen.

### 2) ideapad-laptop blacklisten (920-spezifisch!)

```bash
echo 'blacklist ideapad_laptop' | sudo tee /etc/modprobe.d/blacklist-ideapad.conf
sudo mkinitcpio -P
```

Ohne dies: kein WLAN auf dem YOGA 920.

### 3) Sensor-Stack prüfen

Nach Reboot:

```bash
# Service starten und aktivieren
sudo systemctl enable --now iio-sensor-proxy.service
systemctl status iio-sensor-proxy.service

# Sensor-Events live beobachten — Gerät dabei drehen
monitor-sensor
```

Erwartete Ausgabe beim Drehen:
```
=== Has accelerometer (orientation: normal)
Accelerometer orientation changed: left-up
Accelerometer orientation changed: bottom-up   # = Tent / 180°
Accelerometer orientation changed: right-up
```

Tablet‑Mode‑Switch testen (falls `yoga-usage-mode` greift):

```bash
# alle Switches auflisten
libinput list-devices | grep -A3 -i switch

# Live-Events (Gerät auswählen, dann Klappe umlegen)
sudo evtest
# Erwartet: SW_TABLET_MODE 1/0
```

Wenn weder `evtest` noch `udevadm monitor` einen `SW_TABLET_MODE`-Event liefert, hat der 920er die WMI‑GUID `06129D99-…` schlicht nicht im DSDT verfügbar. Dann gilt Plan B (Skript via Accelerometer):

```bash
sudo modprobe yoga-usage-mode
dmesg | tail -n 30
ls /sys/bus/wmi/drivers/yoga-usage-mode/   # leer? -> Plan B
```

### 4) Mount-Matrix prüfen / korrigieren

Falls die Auto‑Rotation in Laptop‑Stellung verkehrt herum erscheint, ist die Mount‑Matrix falsch.

DMI‑ und Modalias‑Strings auslesen:

```bash
cat /sys/class/dmi/id/modalias
udevadm info -q all -p $(udevadm info -q path -n /dev/iio:device0) | grep MODALIAS
```

Beispieldatei `/etc/udev/hwdb.d/61-sensor-yoga920.hwdb` (Werte sind hardware‑spezifisch und müssen ggf. iterativ ermittelt werden):

```
# Lenovo YOGA 920-13IKB (Type 80Y7)
sensor:modalias:acpi:KIOX*:dmi:*svnLENOVO*:pn80Y7*
 ACCEL_MOUNT_MATRIX=-1, 0, 0; 0, 1, 0; 0, 0, 1
```

(Format und Vorgehen entsprechen `60-sensor.hwdb` in systemd; siehe systemd‑Issue #5160 als Referenz für die Erstellung eigener DMI‑Matches.) Aktivieren:

```bash
sudo systemd-hwdb update
sudo udevadm trigger -v -p DEVNAME=/dev/iio:device0
monitor-sensor   # erneut prüfen
```

Iterativ probieren: das Gerät flach hinlegen, Werte mit `cat /sys/bus/iio/devices/iio:device0/in_accel_*_raw` ablesen — die Z‑Achse sollte dabei in der Größenordnung von `1g` (positiv) ausschlagen, wenn die Matrix passt.

### 5) Auto-Rotation aktivieren (Plasma 6 KCM)

In **Systemeinstellungen → Anzeige & Monitor**:
1. Display `eDP-1` auswählen.
2. **Ausrichtung → Automatisch** wählen.
3. Optional: **„Nur im Tablet‑Modus drehen"** aktivieren — das setzt aber voraus, dass Plasma den Tablet‑Modus erkennt (siehe nächster Abschnitt). Ohne funktionierenden `SW_TABLET_MODE` diese Option **deaktiviert** lassen, sonst dreht das Display nie.

CLI‑Äquivalent (für Skripting / Test):

```bash
kscreen-doctor -o   # aktuelle Konfiguration zeigen
kscreen-doctor output.eDP-1.rotation.inverted   # 180°
kscreen-doctor output.eDP-1.rotation.none       # zurück
```

### 6) Maliit / Virtuelle Tastatur einrichten

In **Systemeinstellungen → Tastatur → Virtuelle Tastatur**: **„Maliit Keyboard"** auswählen.

Manuell prüfen / setzen:

```bash
kreadconfig6 --file kwinrc --group Wayland --key InputMethod
kwriteconfig6 --file kwinrc --group Wayland --key InputMethod \
    /usr/share/applications/com.github.maliit.keyboard.desktop
kwriteconfig6 --file kwinrc --group Wayland --key VirtualKeyboardEnabled true

qdbus6 org.kde.KWin /KWin reconfigure
```

**Maliit nur im Tablet‑/Tent‑Modus** automatisch zeigen: Plasma macht das von selbst, sobald **Touch‑Modus** aktiv ist. Mit funktionierendem `SW_TABLET_MODE`:

```bash
# Touch-Modus auf "auto" — schaltet basierend auf SW_TABLET_MODE
kwriteconfig6 --file kwinrc --group Input --key TabletMode auto
qdbus6 org.kde.KWin /KWin reconfigure
```

Werte: `auto` (Default — folgt SW_TABLET_MODE), `on` (immer Touch‑Modus), `off` (nie).

OSK manuell ein-/ausschalten (für Skripte):

```bash
# Aktivierung der virtuellen Tastatur ein/aus
qdbus6 org.kde.KWin /VirtualKeyboard \
       org.freedesktop.DBus.Properties.Set \
       org.kde.kwin.VirtualKeyboard enabled true

# Sichtbarkeit togglen (active = sichtbar/unsichtbar)
qdbus6 org.kde.KWin /VirtualKeyboard \
       org.freedesktop.DBus.Properties.Set \
       org.kde.kwin.VirtualKeyboard active true
```

### 7) Touch-Modus auf SW_TABLET_MODE binden

Wenn `yoga-usage-mode` greift (Switch sichtbar in `evtest`):

```bash
kwriteconfig6 --file kwinrc --group Input --key TabletMode auto
qdbus6 org.kde.KWin /KWin reconfigure
```

Plasma aktiviert dann automatisch:
- vergrößerte Taskleiste / größere Click‑Targets
- Maliit bei Touch auf Textfeld
- libinput sperrt parallel Tastatur und Touchpad (eingebauter Mechanismus)

### 8) Plan B — Helfer-Skript (Nushell), wenn kein SW_TABLET_MODE existiert

Datei `~/.local/bin/yoga920-tabletmode.nu`:

```nu
#!/usr/bin/env nu

# Welche Orientierungen gelten als "Tablet/Tent"?
const TABLET_ORIENTATIONS = ["bottom-up", "left-up", "right-up"]

def set-virtual-keyboard [enabled: bool] {
    let v = if $enabled { "true" } else { "false" }
    ^qdbus6 org.kde.KWin /VirtualKeyboard \
            org.freedesktop.DBus.Properties.Set \
            org.kde.kwin.VirtualKeyboard enabled $v
}

def set-touch-mode [on: bool] {
    let v = if $on { "on" } else { "off" }
    ^kwriteconfig6 --file kwinrc --group Input --key TabletMode $v
    ^qdbus6 org.kde.KWin /KWin reconfigure
}

def find-touchpad [] {
    let raw = (^qdbus6 org.kde.KWin /org/kde/KWin/InputDevice \
               org.freedesktop.DBus.Properties.Get \
               org.kde.KWin.InputDeviceManager devicesSysNames)
    let devs = ($raw | lines | each { str trim } | where {|x| $x != "" })
    $devs | each {|d|
        let name = (^qdbus6 org.kde.KWin $"/org/kde/KWin/InputDevice/($d)" \
                    org.freedesktop.DBus.Properties.Get \
                    org.kde.KWin.InputDevice name | str trim)
        {sysname: $d, name: $name}
    } | where {|x|
        ($x.name | str downcase | str contains "touchpad") or
        ($x.name | str contains "ELAN") or
        ($x.name | str contains "Synaptics")
    }
}

def set-touchpad [enabled: bool] {
    let v = if $enabled { "true" } else { "false" }
    for dev in (find-touchpad) {
        ^qdbus6 org.kde.KWin $"/org/kde/KWin/InputDevice/($dev.sysname)" \
                org.freedesktop.DBus.Properties.Set \
                org.kde.KWin.InputDevice enabled $v
    }
}

def main [] {
    # stdbuf -oL erzwingt zeilengepufferten Output
    ^stdbuf -oL monitor-sensor
        | lines
        | where {|l| ($l | str contains "Accelerometer orientation changed:") }
        | each {|l|
              let o = ($l | split row ":" | last | str trim)
              if ($TABLET_ORIENTATIONS | any {|x| $x == $o }) {
                  set-touch-mode true
                  set-virtual-keyboard true
                  set-touchpad false
              } else {
                  set-touch-mode false
                  set-virtual-keyboard false
                  set-touchpad true
              }
          }
        | ignore
}
```

systemd‑User‑Service `~/.config/systemd/user/yoga920-tabletmode.service`:

```ini
[Unit]
Description=YOGA 920 Tablet/Tent helper (accelerometer based)
After=graphical-session.target
PartOf=graphical-session.target

[Service]
Type=simple
ExecStart=%h/.local/bin/yoga920-tabletmode.nu
Restart=on-failure
RestartSec=3

[Install]
WantedBy=graphical-session.target
```

Aktivieren:

```bash
chmod +x ~/.local/bin/yoga920-tabletmode.nu
systemctl --user daemon-reload
systemctl --user enable --now yoga920-tabletmode.service
journalctl --user -u yoga920-tabletmode.service -f
```

Bash‑Variante (kompakt, funktional äquivalent für den Kern‑Loop):

```bash
#!/usr/bin/env bash
set -euo pipefail
TABLET=("bottom-up" "left-up" "right-up")
is_tablet() { local o=$1; for t in "${TABLET[@]}"; do [[ $o == "$t" ]] && return 0; done; return 1; }
stdbuf -oL monitor-sensor | while IFS= read -r line; do
    case "$line" in
        *"Accelerometer orientation changed: "*)
            o="${line##*: }"
            if is_tablet "$o"; then
                kwriteconfig6 --file kwinrc --group Input --key TabletMode on
                qdbus6 org.kde.KWin /KWin reconfigure
                qdbus6 org.kde.KWin /VirtualKeyboard \
                       org.freedesktop.DBus.Properties.Set \
                       org.kde.kwin.VirtualKeyboard enabled true
            else
                kwriteconfig6 --file kwinrc --group Input --key TabletMode off
                qdbus6 org.kde.KWin /KWin reconfigure
                qdbus6 org.kde.KWin /VirtualKeyboard \
                       org.freedesktop.DBus.Properties.Set \
                       org.kde.kwin.VirtualKeyboard enabled false
            fi
        ;;
    esac
done
```

### 9) Tent-Modus (180°) gezielt

Im Tent‑Modus liegt das Tastaturteil unten, der Bildschirm bildet das „Dach" — der Accelerometer meldet typischerweise **`bottom-up`**. Plasmas Auto‑Rotation rotiert dann auf `inverted` (180°). Falls Plasma das nicht selbständig tut, weil seine Heuristik den Wechsel zu `bottom-up` als unbestimmt einstuft, im Skript explizit setzen:

```bash
kscreen-doctor output.eDP-1.rotation.inverted
```

Wer im Tent‑Modus zusätzlich die internen Tasten **physisch** sperren will (Tasten klappen sonst auf der Tischfläche flach unten), kann zusätzlich das Touchpad mit obiger DBus‑Methode `enabled=false` setzen.

### 10) Login-Manager (SDDM) und OSK

Damit auch im Login‑Screen ein OSK erscheint:

```bash
sudo install -d /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/virtualkbd.conf <<'EOF'
[General]
InputMethod=qtvirtualkeyboard
EOF
```

SDDM kann Maliit nicht direkt nutzen — `qtvirtualkeyboard` ist die offiziell unterstützte Variante im Greeter; in der User‑Session bleibt es Maliit.

### 11) Troubleshooting

| Symptom | Ursache / Fix |
|---|---|
| KCM zeigt keine Auto‑Rotation‑Option | `qt6-sensors` und `iio-sensor-proxy` installieren, neu einloggen |
| `monitor-sensor` zeigt „No accelerometer" | Kernelmodul fehlt (`lsmod | grep -E 'kxcjk|bmi|bmc'`); Mount‑Matrix‑Eintrag in `/etc/udev/hwdb.d/61-sensor-yoga920.hwdb` ergänzen, `systemd-hwdb update` |
| Drehung verkehrt herum / 90° schief | Mount‑Matrix in `61-sensor-yoga920.hwdb` justieren — siehe §4. |
| Maliit erscheint nicht im KCM | `~/.config/kwinrc` per Hand setzen (siehe §6); Plasma neu starten (`kquitapp6 plasmashell && kstart6 plasmashell`) |
| Maus blockiert sobald Maliit auf | Maliit‑Issue #210; Workaround: `kwin_wayland --replace` oder vorerst `qt6-virtualkeyboard` verwenden |
| Keine `SW_TABLET_MODE`‑Events trotz `yoga-usage-mode` | `dmesg | grep -i wmi` prüfen; vermutlich kein passender WMI‑Endpunkt im DSDT — Plan B (Skript) nutzen |
| Tastatur dreht sich nicht zurück nach Suspend | `iio-sensor-proxy` aus AUR (`-git`) testen; Service neustarten via `systemctl restart iio-sensor-proxy` |
| Plasma friert beim Wechsel ein (vgl. KDE‑Discuss „plasma freezes when entering touch mode") | KWin neustarten (`kwin_wayland --replace` in TTY); Touch‑Modus erstmal auf `off` zurücksetzen, schrittweise testen |
| WLAN tot nach Erstinstallation | `ideapad_laptop` blacklisten (siehe §2) |

---

## Recommendations

**Stufe 1 — Solides Grundsetup (sicher, immer machbar):**
1. `iio-sensor-proxy`, `qt6-sensors`, `maliit-keyboard` installieren.
2. `ideapad_laptop` blacklisten.
3. Plasma‑KCM auf **Auto‑Rotation: Automatisch** (nicht „Nur im Tablet‑Modus") setzen.
4. Maliit als Virtuelle Tastatur auswählen.

Auf dem YOGA 920 funktioniert ab hier bereits 90°/180°/270°‑Rotation und das OSK über Touch‑auf‑Textfeld. Tastatur/Touchpad bleiben aktiv.

**Stufe 2 — Tablet-Mode-Switch suchen:**
5. `yoga-usage-mode-dkms-git` aus AUR installieren, `modprobe yoga-usage-mode`, mit `evtest` prüfen.
6. **Wenn `SW_TABLET_MODE`‑Events erscheinen:** `kwriteconfig6 --file kwinrc --group Input --key TabletMode auto`. Damit übernehmen libinput automatisch das Sperren von Tastatur/Touchpad und Plasma die Touch‑Mode‑Aktivierung. **Fertig.**

**Stufe 3 — Plan B mit Skript:**
7. Wenn Stufe 2 keinen Switch erzeugt: Nushell‑Skript aus §8 nutzen.

**Schwellenwerte für Re‑Evaluation:**
- Sobald in einem zukünftigen Kernel (`drivers/platform/x86/lenovo/`) ein Eintrag für 80Y7/13IKB auftaucht — Skript abschalten und auf libinput‑Mechanismus zurückgehen.
- Wenn Plasma 6.x in einem späteren Release Hinge‑Winkel‑Sensor‑Fusion bekommt (Changelog `kcm_kscreen` beobachten), kann auch Tent‑Erkennung ohne Skript automatisch klappen.
- Wenn `maliit/keyboard#210` geschlossen wird, ist auch das KWin‑Reconfigure‑Workaround obsolet.

---

## Caveats

- **Hardware‑Spezifika YOGA 920**: Der Yoga 920 (Type 80Y7) ist von Lenovo nicht als Linux‑Gerät zertifiziert. Es gibt keinen einzigen öffentlichen `evtest`‑Mitschnitt, der `SW_TABLET_MODE` auf dem 920er bestätigt. Erfolg von `yoga-usage-mode` ist nicht garantiert.
- **WLAN‑Falle**: `ideapad_laptop` blockiert WLAN auf dem 920er — daher blacklisten. Da derselbe Treiber bei neueren Yogas der primäre Tablet‑Mode‑Provider ist, ist der 920er hier doppelt benachteiligt.
- **Maliit‑Mausblock‑Bug** (`maliit/keyboard#210`, offen Stand Mai 2026): Auf manchen Plasma‑6‑Setups blockiert Maliit alle Maus‑Events, bis KWin neu gestartet wird. Wenn das zuverlässig reproduzierbar ist, auf `qt6-virtualkeyboard` als Notlösung zurückgehen.
- **`iio-sensor-proxy`‑Suspend‑Bug**: Auf der Yoga‑9er‑Serie dokumentiert (ArchWiki); im Bedarfsfall `iio-sensor-proxy-git` aus AUR. Beim 920er bisher nicht systematisch berichtet, aber derselbe Stack.
- **`wlr-randr` funktioniert unter KWin nicht** — alle CLI‑Display‑Befehle MÜSSEN über `kscreen-doctor` laufen.
- **`qdbus`‑Pfade**: Plasma 6 nutzt `qdbus6` (Paket `qt6-tools`). Auf Plasma‑5‑Systemen wäre es `qdbus`.
- **Mount‑Matrix** im 60‑sensor.hwdb‑Stack: Die genaue Matrix für das 920er ist nicht in mainline systemd hinterlegt. Wer korrekte Werte ermittelt, sollte sie als PR an `systemd/systemd` einreichen, damit andere profitieren.
- **DBus‑API‑Volatilität**: Die `org.kde.KWin.InputDevice`‑Hierarchie (`enabled`-Property pro Device) kann sich zwischen Plasma‑Minor‑Releases ändern — bei Updates Skript verifizieren mit `qdbus6 org.kde.KWin /org/kde/KWin/InputDevice`.
- **Empirisch validieren**: Der Stack hängt an `monitor-sensor`-Output und KWin‑DBus‑Properties. Beim ersten Setup mit offenem Terminal `journalctl --user -f` mitlaufen lassen, um zu sehen, welcher Übergang welche Aktion auslöst — und das Skript anpassen, falls beim 920er die Sensor‑Werte abweichen (z.B. wenn Tent als `top-up` statt `bottom-up` ankommt, was an einer falschen Mount‑Matrix liegt).