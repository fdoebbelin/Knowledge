---
titel: Login-Manager (SDDM) und Ruhezustand einrichten
tags: [fedora, hyprland, sddm, ruhezustand, hibernate, power-management, nushell]
erstellt: 2026-06-29
system: Fedora · Hyprland · Lenovo Yoga
status: in-bearbeitung
---

# Login-Manager (SDDM) und Ruhezustand einrichten

Ziel: Über einen grafischen Login-Manager die Hyprland-Sitzung starten und beenden, sowie den echten **Ruhezustand** (Hibernate, Suspend-to-Disk) einrichten.

> [!info] Bereitschaft vs. Ruhezustand
> - **Bereitschaft** (`systemctl suspend`, Suspend-to-RAM) läuft auf Fedora ohne Konfiguration.
> - **Ruhezustand** (`systemctl hibernate`, Suspend-to-Disk) schreibt das RAM auf die Platte und schaltet komplett ab → braucht Datenträger-Swap (Abschnitt 2).

---

## 1. Login-Manager: SDDM

SDDM ist die robusteste Wahl für Wayland/Hyprland.

```nu
sudo dnf install sddm
sudo systemctl set-default graphical.target
sudo systemctl enable sddm
```

> [!warning] Anderen Display-Manager deaktivieren
> Falls noch GDM o.ä. aktiv ist, sonst Konflikt beim Boot:
> ```nu
> sudo systemctl disable gdm
> ```

Prüfen, ob Hyprland als Sitzung erkannt wird (native `ls`-Tabelle):

```nu
ls /usr/share/wayland-sessions/
```

Liegt dort keine `hyprland.desktop`, anlegen:

```nu
"[Desktop Entry]
Name=Hyprland
Exec=Hyprland
Type=Application" | sudo tee /usr/share/wayland-sessions/hyprland.desktop | ignore
```

### Sitzung beenden

Der `exit`-Dispatcher beendet Hyprland und kehrt zu SDDM zurück. Als Keybind in der [[Hyprland Konfiguration]]:

```
bind = SUPER SHIFT, M, exit
```

Im Skript / Power-Menü entsprechend:

```nu
hyprctl dispatch exit
```

### Energie- und Sitzungsbefehle

Laufen dank polkit aus der Sitzung **ohne** `sudo`:

```nu
systemctl poweroff      # Herunterfahren
systemctl reboot        # Neustart
systemctl suspend       # Bereitschaft (sofort einsatzbereit)
systemctl hibernate     # Ruhezustand (Abschnitt 2 nötig)
```

---

## 2. Ruhezustand (Hibernate) einrichten

> [!warning] Warum nicht out-of-the-box?
> Fedora nutzt standardmäßig **zram** (komprimierter Swap im RAM). Das ist flüchtig und für Hibernate ungeeignet. Es wird zusätzlich Swap auf dem Datenträger benötigt. zram darf aktiv bleiben — der Kernel wählt für Hibernate automatisch den Datenträger-Swap.

### a) Aktuellen Swap prüfen

```nu
swapon --show
```

Zeigt typischerweise nur `/dev/zram0`. zram ist bei Fedora min(RAM/2, 4 GiB).

> [!tip] Swapfile-Größe
> Sicher = **RAM + zram**. Beispiel: 16 GB RAM + 4 GB zram → ~20 GB Swapfile. Unten als `--size 20g` — an dein System anpassen.

### b) Swapfile auf btrfs anlegen

`mkswapfile` deaktiviert CoW und allokiert korrekt — kein manuelles `chattr +C` mehr nötig.

```nu
sudo btrfs subvolume create /var/swap
sudo btrfs filesystem mkswapfile --size 20g --uuid clear /var/swap/swapfile
sudo swapon /var/swap/swapfile
```

### c) In fstab eintragen

```nu
"/var/swap/swapfile none swap defaults 0 0" | sudo tee -a /etc/fstab | ignore
```

### d) Resume-Parameter ermitteln und setzen

UUID und Offset in nushell-Variablen erfassen, dann per String-Interpolation an `grubby` übergeben:

```nu
let fs_uuid = (findmnt -no UUID -T /var/swap/swapfile | str trim)
let offset = (sudo btrfs inspect-internal map-swapfile -r /var/swap/swapfile | str trim)
print $"UUID=($fs_uuid)  Offset=($offset)"

let resume_args = $"resume=UUID=($fs_uuid) resume_offset=($offset)"
sudo grubby --update-kernel=ALL --args=$resume_args
```

### e) Dracut resume-Modul

```nu
'add_dracutmodules+=" resume "' | sudo tee /etc/dracut.conf.d/resume.conf | ignore
sudo dracut -f
```

### f) Hibernate in systemd erlauben (Drop-in)

Sauberer als die Haupt-`sleep.conf` zu editieren:

```nu
sudo mkdir -p /etc/systemd/sleep.conf.d
"[Sleep]
AllowHibernation=yes" | sudo tee /etc/systemd/sleep.conf.d/hibernate.conf | ignore
```

### g) SELinux-Kontext für das Swapfile

```nu
sudo semanage fcontext -a -t swapfile_t "/var/swap/swapfile"
sudo restorecon -v /var/swap/swapfile
```

> [!tip] semanage fehlt?
> ```nu
> sudo dnf install policycoreutils-python-utils
> ```

### h) Testen

```nu
systemctl hibernate
```

Nach dem Wieder-Einschalten sollte die Sitzung exakt zurückkehren.

> [!warning] Secure Boot
> Der Kernel-Lockdown unter Secure Boot blockierte Hibernate historisch. Neuere Fedora-Versionen (ab F41, nach Updates) funktionieren auch mit aktiviertem Secure Boot. Bei Fehlschlag prüfen:
> ```nu
> journalctl -b | find lockdown
> open /sys/power/disk
> ```

---

## 3. Hibernate ins Power-Menü

Im wofi-Power-Menü einen Eintrag analog zu poweroff/reboot ergänzen, der `systemctl hibernate` aufruft.

```nu
systemctl hibernate
```

---

## Checkliste

> [!check] Login-Manager
> - [ ] `sddm` installiert und aktiviert
> - [ ] `graphical.target` als Default gesetzt
> - [ ] alter Display-Manager deaktiviert
> - [ ] `hyprland.desktop` unter `wayland-sessions` vorhanden
> - [ ] `exit`-Keybind in [[Hyprland Konfiguration]] gesetzt

> [!check] Ruhezustand
> - [ ] Swapfile (≥ RAM + zram) angelegt und in fstab
> - [ ] `resume` + `resume_offset` per grubby gesetzt
> - [ ] dracut resume-Modul + `dracut -f`
> - [ ] `AllowHibernation=yes` (Drop-in)
> - [ ] SELinux-Kontext `swapfile_t` gesetzt
> - [ ] `systemctl hibernate` zweimal erfolgreich getestet

---

## Hardware-Hinweis (Lenovo Yoga)

> [!tip] Nach dem ersten Hibernate zweiten Durchlauf testen
> Gelegentlich kommen WLAN oder Display nach dem Resume nicht sauber hoch — das hängt am Treiber, nicht an der Konfiguration. Ein zweiter Test zeigt, ob es reproduzierbar ist.

## Verwandte Notizen

- [[Hyprland Konfiguration]]
- [[02-nushell-konfigurieren]]
- [[Flatpak einrichten]]
