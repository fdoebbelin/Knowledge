---
titel: Hibernate einrichten (Ruhezustand) — Fedora + Btrfs
aliases: [Hibernate einrichten, Ruhezustand, suspend-then-hibernate]
tags: [linux, fedora, hibernate, swap, btrfs, systemd, power, yoga]
erstellt: 2026-07-06
system: Lenovo Yoga 920-13IKB
status: anleitung
---

# Hibernate einrichten (Ruhezustand)

> [!abstract] Ziel
> Echten **Ruhezustand** (Suspend-to-Disk / Hibernate) auf dem frisch aufgesetzten [[Fedora + Hyprland + Noctalia auf dem Lenovo Yoga 920-13IKB|Fedora-Yoga]] aktivieren — bevorzugt als **suspend-then-hibernate** (erst RAM-Suspend, nach Timeout automatisch auf Platte). Fedoras Standard-**zram** reicht dafür **nicht**; es braucht Disk-Swap plus `resume`-Kernelparameter.

> [!note] Keine Extra-Pakete nötig
> `btrfs-progs`, `grubby`, `dracut` und `systemd` sind auf Fedora bereits vorhanden. Es ist reine Konfigurationsarbeit — kein `dnf install`.

---

## 0. Vorabcheck: mem_sleep (S3 vs. s2idle)

Bestimmt, **wie dringend** Hibernate ist. Bei echtem S3 (`deep`) zieht Suspend kaum Strom; bei `s2idle`-only läuft der Akku im Standby merklich leer → Hibernate als Sicherheitsnetz wird wichtiger.

```nu
open /sys/power/mem_sleep
```

- `s2idle [deep]` → S3 verfügbar und aktiv (ideal).
- `[s2idle]` → nur modern standby, kein echtes S3.

Und prüfen, dass Hibernate überhaupt unterstützt wird:

```nu
open /sys/power/state | str contains disk
```

> [!tip] Falls `open` bei /sys zickt
> Manche Kernel-Pseudodateien melden falsche Größen. Dann `cat /sys/power/mem_sleep` bzw. `cat /sys/power/state` nehmen.

> [!warning] Yoga 920 — s2idle wahrscheinlich
> Das 920-13IKB bietet je nach BIOS oft nur `s2idle`. Ergebnis hier notieren — es entscheidet, ob du den `HibernateDelaySec` (Abschnitt 4) kurz oder großzügig setzt.

---

## 1. Swap-Strategie: Partition oder Btrfs-Swapfile?

> [!info] Kurz: Eine eigene Partition ist **nicht** nötig — ein Btrfs-Swapfile reicht vollständig.

| Kriterium | Btrfs-Swapfile (Weg A) | Swap-Partition (Weg B) |
|---|---|---|
| Kernelparameter | `resume=UUID=…` **+** `resume_offset=…` | nur `resume=UUID=…` |
| Flexibel (Größe später ändern) | ja | nein (Partition fix) |
| „Set and forget" | Offset kann sich nach `balance`/defrag ändern | stabil, nie |
| Aufwand jetzt | gering (bei laufendem System) | beim Partitionieren mit einplanen |

**Faustregel:** Steht Hibernate schon beim Partitionieren fest → **Weg B** (robust). System läuft schon / du willst Flexibilität → **Weg A**.

**Größe:** mindestens **RAM-Größe**, etwas Reserve schadet nicht — sonst bricht Hibernate bei vollem RAM ab.

```nu
sys mem | get total
```

---

## 2a. Weg A — Btrfs-Swapfile

Eigenes Subvolume (bleibt aus Snapshots ausgeschlossen) und Swapfile anlegen (Beispiel 16 GiB — an RAM anpassen):

```nu
sudo btrfs subvolume create /swap
sudo btrfs filesystem mkswapfile --size 16g /swap/swapfile
sudo swapon /swap/swapfile
```

Dauerhaft in die `fstab`:

```nu
"/swap/swapfile none swap defaults 0 0" | sudo tee -a /etc/fstab | ignore
```

UUID (des tragenden Dateisystems) und **resume_offset** ermitteln:

```nu
let uuid = (findmnt --noheadings --output UUID --target /swap/swapfile | str trim)
let offset = (sudo btrfs inspect-internal map-swapfile -r /swap/swapfile | str trim)
```

> [!important] Offset nur mit btrfs-Tool bestimmen
> Auf Btrfs **immer** `btrfs inspect-internal map-swapfile -r` verwenden — `filefrag` liefert hier die falsche Blockzuordnung.

Weiter bei **Abschnitt 3** (mit `$uuid` **und** `$offset`).

---

## 2b. Weg B — Swap-Partition

Partition beim Installieren anlegen (~RAM-Größe, Typ „Linux swap"), dann formatieren und aktivieren (`/dev/nvme0n1pX` durch deine Partition ersetzen):

```nu
sudo mkswap /dev/nvme0n1pX
sudo swapon /dev/nvme0n1pX
let uuid = (blkid --match-tag UUID --output value /dev/nvme0n1pX | str trim)
```

In die `fstab`:

```nu
$"UUID=($uuid) none swap defaults 0 0" | sudo tee -a /etc/fstab | ignore
```

Weiter bei **Abschnitt 3** (nur `$uuid`, **kein** Offset).

---

## 3. resume-Parameter setzen (GRUB + dracut)

`resume`-String bauen und als Kernelparameter für **alle** Kernel eintragen:

```nu
# Weg A (Swapfile): mit Offset
let args = $"resume=UUID=($uuid) resume_offset=($offset)"

# Weg B (Partition): ohne Offset — stattdessen diese Zeile nehmen:
# let args = $"resume=UUID=($uuid)"

sudo grubby --update-kernel=ALL --args=$args
```

Initramfs neu bauen, damit das Resume-Modul und die UUID enthalten sind:

```nu
sudo dracut --force --regenerate-all
```

Kontrolle nach dem nächsten Reboot:

```nu
open /proc/cmdline | str contains resume
```

> [!warning] Verschlüsseltes Root (LUKS)
> Liegt `/` (und damit der Swap/das Swapfile) in einem LUKS-Container, muss das Initramfs den Container **vor** dem Resume entsperren. `dracut` nimmt das automatisch auf, wenn root LUKS ist — nach Änderungen an der Krypto-Einrichtung `dracut --force --regenerate-all` wiederholen.

---

## 4. suspend-then-hibernate einrichten

Erst RAM-Suspend, nach `HibernateDelaySec` automatisch Hibernate. Drop-in statt Editieren der Hauptdatei:

```nu
sudo mkdir /etc/systemd/sleep.conf.d
"[Sleep]
HibernateDelaySec=60min
" | sudo tee /etc/systemd/sleep.conf.d/10-hibernate.conf | ignore
```

> [!tip] Delay an mem_sleep koppeln
> Bei nur `s2idle` (Abschnitt 0) den Wert **kürzer** setzen (z. B. `20min`), damit der Akku im Standby nicht ausläuft, bevor Hibernate greift. Neuere systemd-Versionen können die Zeit auch dynamisch schätzen (`SuspendEstimationSec`) — dann ist ein fixer Wert optional.

Damit der Deckel den kombinierten Modus auslöst, das Deckel-Drop-in aus der [[Fedora + Hyprland + Noctalia auf dem Lenovo Yoga 920-13IKB|Haupt-Anleitung]] anpassen:

```nu
"[Login]
HandleLidSwitch=suspend-then-hibernate
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=ignore
" | sudo tee /etc/systemd/logind.conf.d/10-deckel.conf | ignore
```

> [!note] Wirksam nach Reboot
> `logind`-Änderungen greifen nach Neustart (oder `sudo systemctl restart systemd-logind`, das aber die aktuelle Session beenden kann → lieber rebooten). `sleep.conf` wird beim Schlafen frisch gelesen, kein Reload nötig.

---

## 5. Testen

```nu
# Swap aktiv?
swapon --show
sys mem | get swap_total

# Hibernate verfügbar?
open /sys/power/state | str contains disk

# Direkter Test (Sitzung sichern!):
systemctl hibernate

# Kombinierter Modus:
systemctl suspend-then-hibernate
```

Nach dem Aufwecken prüfen, ob die Sitzung tatsächlich wiederhergestellt wurde (nicht nur neu gebootet):

```nu
journalctl -b -1 --no-pager | find --ignore-case hibernate
```

---

## 6. Troubleshooting

| Symptom | Ursache / Fix |
|---|---|
| Hibernate bricht sofort ab | Swap kleiner als belegter RAM → größeren Swap anlegen |
| Kein „disk" in `/sys/power/state` | `resume`-Param fehlt oder Initramfs nicht neu gebaut → Abschnitt 3 wiederholen |
| Resume startet frisch statt fortzusetzen | falsche `UUID`/`resume_offset`; bei Swapfile Offset mit `map-swapfile -r` neu bestimmen |
| Nach `btrfs balance`/defrag kaputt | `resume_offset` hat sich verschoben → neu ermitteln, `grubby` aktualisieren, `dracut` neu bauen |
| Standby leert Akku schnell | nur `s2idle` (Abschnitt 0) → `HibernateDelaySec` kürzer setzen |
| `swapon` am File scheitert (SELinux) | selten; Datei-Context prüfen bzw. Swapfile über `mkswapfile` neu anlegen |
| zram „stört" | zram bleibt Laufzeit-Swap; Hibernate nutzt gezielt `resume=` auf Disk-Swap — kein Konflikt |

---

## Aufgaben

- [ ] `mem_sleep` geprüft (S3 vs. s2idle) und Ergebnis notiert
- [ ] Swap-Strategie gewählt (Swapfile A / Partition B)
- [ ] Swap angelegt, aktiviert, in `fstab` eingetragen
- [ ] `resume`(`+ resume_offset`) via `grubby` gesetzt
- [ ] `dracut --force --regenerate-all` ausgeführt
- [ ] `sleep.conf.d/10-hibernate.conf` + Deckel-Drop-in gesetzt
- [ ] `systemctl hibernate` **und** `suspend-then-hibernate` erfolgreich getestet
- [ ] (LUKS) Resume nach Entsperren verifiziert

---

## Referenzen

- Fedora – System-Wide Hibernation: <https://fedoraproject.org/wiki/Common_F41_bugs> (aktuelle Version prüfen)
- btrfs `mkswapfile` / `map-swapfile`: <https://btrfs.readthedocs.io/>
- systemd `sleep.conf`: <https://www.freedesktop.org/software/systemd/man/latest/systemd-sleep.conf.html>
- systemd `logind.conf`: <https://www.freedesktop.org/software/systemd/man/latest/logind.conf.html>

Siehe auch: [[Fedora + Hyprland + Noctalia auf dem Lenovo Yoga 920-13IKB]] · [[Fedora]] · [[Nushell]]
