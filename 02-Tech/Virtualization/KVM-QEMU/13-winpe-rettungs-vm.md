---
title: WinPE-Rettungs-VM für eine Windows-SSD
aliases:
  - winpe-vm.nu
  - Windows-SSD in QEMU prüfen
  - WinPE in KVM
tags:
  - kvm
  - qemu
  - ovmf
  - windows11
  - winpe
  - nushell
  - fedora-atomic
type: anleitung
description: Eine ausgebaute Windows-11-SSD per USB-Adapter in einer QEMU/KVM-VM mit WinPE von der Windows-ISO starten, um Bootkette und Dateisystem zu prüfen oder zu reparieren – Nushell-Skript mit Vorab-Test.
system: Fedora Sway Atomic, Nushell, QEMU/KVM, edk2-ovmf
created: 2026-10-21
status: active
---

# 13 — WinPE-Rettungs-VM für eine Windows-SSD

Startet eine Windows-SSD, die am USB-Adapter hängt, in einer UEFI-VM – entweder ins WinPE der Windows-ISO (Reparaturkonsole) oder, wenn man die CD-Abfrage verstreichen lässt, ins installierte Windows. Damit lässt sich klären, ob die SSD selbst intakt ist oder der Fehler beim PC liegt.

> [!example] Anlass (Oktober 2026)
> Eine Windows-11-SSD meldete am Original-PC „kein bootfähiges Medium“. In der VM startete Windows bis zur Anmeldung – die Bootkette war intakt, der PC startete im Legacy-Modus. Diagnose und Lösung: [[01-UEFI-Booteinträge anlegen#4. Fallbeispiel: Windows-SSD meldet „kein bootfähiges Medium“]].

> [!info] Kein Windows ADK nötig
> Die Microsoft-Seiten zu `copype`/`MakeWinPEMedia` beschreiben den Bau eines eigenen WinPE. Die normale Windows-11-ISO bootet selbst ein WinPE (`sources\boot.wim`): Im Setup öffnet **Shift+F10** eine Konsole mit `diskpart`, `bcdboot`, `chkdsk`, `sfc`. „Computerreparaturoptionen“ führte dagegen zu einem Neustart.

## Voraussetzungen

```nu
sudo rpm-ostree install --apply-live qemu-kvm edk2-ovmf
```

Scheitert das am Terra-Repo (`repodata terra was not complete … primary.xml.zst is missing`): unvollständiger Mirror, nicht QEMU. `sudo rpm-ostree cleanup -m` und erneut; notfalls `terra.repo` kurz auf `enabled=0`.

## Aufruf

```nu
nu winpe-vm.nu --check                               # nur prüfen, QEMU-Befehl anzeigen
nu winpe-vm.nu                                       # Vorgaben verwenden
nu winpe-vm.nu -i ~/Downloads/x.iso -d /dev/sdb
nu winpe-vm.nu -d /dev/disk/by-id/usb-… --disk-id ""  # Disk-ID-Prüfung aus
```

Vorher die richtige Platte bestimmen – `sdX` wechselt zwischen Rechnern und Starts. Maßgeblich ist der GPT-Disk-Identifier (`sudo fdisk -l /dev/sdX`), den das Skript mit `--disk-id` abgleicht.

Bedienung: Ctrl+Alt+G gibt die Maus frei, Ctrl+Alt+2 öffnet den QEMU-Monitor, Ctrl+Alt+1 zurück zur Anzeige. WinPE sauber beenden mit `wpeutil shutdown`.

## Was das Skript löst

| Problem ohne Skript | Ursache | Lösung im Skript |
|---|---|---|
| `Authorization required … gtk initialization failed` mit `sudo qemu…` | root darf nicht auf die Wayland-Sitzung (Sway) | QEMU als Benutzer, Plattenzugriff per `setfacl -m u:$USER:rw`, danach `setfacl -x` |
| VM startet installiertes Windows statt WinPE | „Press any key to boot from CD“ läuft ab, OVMF fällt auf die SSD zurück; alte NVRAM-Einträge | `bootindex` ISO=0/SSD=1, NVRAM bei jedem Start frisch aus `OVMF_VARS.fd`, automatisches `sendkey ret` über den Monitor |
| Bild abgeschnitten, Maus gefangen | QEMU skaliert nicht, PS/2-Maus | `-display gtk,zoom-to-fit=on`, `qemu-xhci` + `usb-tablet` |
| falsche Platte durchgereicht | Gerätenamen wechseln | Vorab-Test: Blockgerät, GPT, Disk-ID, ESP + Microsoft basic data, nichts gemountet |

> [!failure]- Was nicht hilft
> - `efibootmgr` am Arbeitsrechner: Die NVRAM-Einträge liegen im Mainboard des Original-PCs, nicht auf der SSD.
> - Windows per USB-Adapter am Original-PC booten: endet meist in `INACCESSIBLE_BOOT_DEVICE`, weil die Installation nicht als portables System eingerichtet ist.

## Bootmanager in WinPE neu aufbauen

Nur nötig, wenn `EFI/Microsoft` auf der ESP fehlt oder beschädigt ist (Shift+F10):

```bat
diskpart
  list vol
  select vol <ESP>
  assign letter=S
  exit
bcdboot C:\Windows /s S: /f UEFI /l de-DE /v
bcdedit /store S:\EFI\Microsoft\Boot\BCD /enum
wpeutil shutdown
```

## Skript `winpe-vm.nu`

Die Vorgaben (ISO-Pfad, Disk-ID) gehören zur SSD vom Oktober 2026 und sind für andere Fälle anzupassen.

```nu
#!/usr/bin/env nu
# winpe-vm.nu
#
# Bootet ein WinPE-/Windows-ISO in einer KVM-VM und reicht die Windows-11-SSD
# als zweiten Datenträger durch.
#
# - Feste Bootreihenfolge: ISO (bootindex 0) → SSD (bootindex 1)
# - Frische OVMF-NVRAM bei jedem Start (keine alten "Windows Boot Manager"-Einträge)
# - "Press any key to boot from CD or DVD" wird automatisch bestätigt
# - Bild skaliert aufs Fenster, Maus ohne Einfangen (usb-tablet)
# - Eingebauter Test vor jedem Start; mit --check nur testen
#
# Aufruf:
#   nu winpe-vm.nu                         # Vorgaben verwenden
#   nu winpe-vm.nu --check                 # nur prüfen, Befehl anzeigen
#   nu winpe-vm.nu -i ~/Downloads/x.iso -d /dev/sdb
#   nu winpe-vm.nu -d /dev/disk/by-id/usb-… --disk-id ""   # ID-Prüfung aus

const OVMF_CODE   = "/usr/share/edk2/ovmf/OVMF_CODE.fd"
const OVMF_VARS   = "/usr/share/edk2/ovmf/OVMF_VARS.fd"
const GUID_ESP    = "C12A7328-F81F-11D2-BA4B-00A0C93EC93B"   # EFI System
const GUID_MSDATA = "EBD0A0A2-B9E5-4433-87C0-68B6B72699C7"   # Microsoft basic data

# Prüfergebnis ausgeben und als bool zurückgeben
def check [ok: bool, label: string, hint: string = ""]: nothing -> bool {
    if $ok {
        print $"  (ansi green)✓(ansi reset) ($label)"
    } else {
        print $"  (ansi red)✗(ansi reset) ($label)"
        if $hint != "" { print $"      → ($hint)" }
    }
    $ok
}

# WinPE-Rettungs-VM für die Windows-11-SSD starten
def main [
    --iso (-i): string = "~/Downloads/Windows11_Client_x64_de-de_26300_9457.iso"  # WinPE-/Windows-ISO
    --disk (-d): string = "/dev/sda"                         # Windows-11-Laufwerk (auch /dev/disk/by-id/…)
    --disk-id: string = "98D4C679-DF9E-4859-8B2D-DD26823AA3C2"  # erwartete GPT-Disk-ID ("" = nicht prüfen)
    --mem (-m): string = "4G"                                # Arbeitsspeicher der VM
    --port (-p): int = 55555                                 # TCP-Port des QEMU-Monitors (nur 127.0.0.1)
    --keys (-k): int = 30                                    # Enter-Drücke im 0,5-s-Takt für die CD-Abfrage
    --check (-c)                                             # nur testen, VM nicht starten
] {
    let iso  = ($iso | path expand)
    let disk = ($disk | path expand)   # löst by-id-Symlinks auf

    # ── Test ──────────────────────────────────────────────────────────────
    print $"(ansi attr_bold)Prüfungen(ansi reset)"
    mut ok = true

    $ok = (check (which qemu-system-x86_64 | is-not-empty) "qemu-system-x86_64 vorhanden" "sudo rpm-ostree install --apply-live qemu-kvm edk2-ovmf") and $ok
    $ok = (check (($OVMF_CODE | path exists) and ($OVMF_VARS | path exists)) "OVMF-Firmware vorhanden" "Paket edk2-ovmf installieren") and $ok
    $ok = (check ("/dev/kvm" | path exists) "KVM verfügbar" "Virtualisierung (VT-x/AMD-V) im BIOS aktivieren") and $ok
    $ok = (check (which bash | is-not-empty) "bash vorhanden (für die Tastenautomatik)") and $ok

    let iso_ok = if ($iso | path exists) { ($iso | path type) == "file" } else { false }
    $ok = (check $iso_ok $"ISO: ($iso)" "Pfad mit --iso angeben") and $ok

    let is_block = if ($disk | path exists) { ($disk | path type) == "block device" } else { false }
    $ok = (check $is_block $"Blockgerät: ($disk)" "Laufwerk mit --disk angeben, Übersicht: lsblk -o NAME,SIZE,MODEL,TRAN") and $ok

    if $is_block {
        let pt = try { ^sudo sfdisk --json $disk | from json | get partitiontable } catch { null }
        let gpt = ($pt != null) and ($pt.label? == "gpt")
        $ok = (check $gpt "GPT-Partitionstabelle lesbar") and $ok

        if $gpt {
            if $disk_id != "" {
                let id = ($pt.id? | default "" | str upcase)
                $ok = (check ($id == ($disk_id | str upcase)) $"Disk-ID ($id)" $"erwartet ($disk_id) – falsches Laufwerk? Prüfung mit --disk-id \"\" abschalten") and $ok
            }
            let types = ($pt.partitions? | default [] | each {|p| $p.type? | default "" | str upcase })
            $ok = (check (($GUID_ESP in $types) and ($GUID_MSDATA in $types)) "Windows-Layout (EFI + Microsoft basic data)") and $ok
        }

        let mounts = (^lsblk -nr -o MOUNTPOINTS $disk | lines | where {|l| ($l | str trim) != "" })
        $ok = (check ($mounts | is-empty) "Nichts vom Laufwerk gemountet" $"erst aushängen: ($mounts | str join ', ')") and $ok
    }

    # ── QEMU-Optionen ─────────────────────────────────────────────────────
    let vars_placeholder = "<temporäre Kopie von OVMF_VARS.fd>"
    let qemu_args = {|vars: string|
        [
            "-name" "WinPE-Rettung"
            "-enable-kvm" "-machine" "q35" "-cpu" "host" "-smp" "2" "-m" $mem
            "-rtc" "base=localtime"                       # Windows erwartet RTC in Ortszeit
            "-nic" "none"                                 # kein Netz nötig
            # UEFI-Firmware, NVRAM bei jedem Start frisch
            "-drive" $"if=pflash,format=raw,readonly=on,file=($OVMF_CODE)"
            "-drive" $"if=pflash,format=raw,file=($vars)"
            # Datenträger mit fester Bootreihenfolge: ISO → SSD
            "-device" "ahci,id=ahci"
            "-drive" $"file=($iso),format=raw,media=cdrom,readonly=on,if=none,id=cd"
            "-device" "ide-cd,drive=cd,bus=ahci.0,bootindex=0"
            "-drive" $"file=($disk),format=raw,cache=none,if=none,id=win"
            "-device" "ide-hd,drive=win,bus=ahci.1,bootindex=1"
            # Anzeige und Eingabe
            "-display" "gtk,zoom-to-fit=on"
            "-device" "qemu-xhci" "-device" "usb-tablet"
            # Monitor im GTK-Fenster (Ctrl+Alt+2) und lokal per TCP für die Tastenautomatik
            "-monitor" "vc"
            "-monitor" $"tcp:127.0.0.1:($port),server=on,wait=off"
        ]
    }

    if not $ok {
        print $"\n(ansi red)Prüfung fehlgeschlagen – VM wird nicht gestartet.(ansi reset)"
        exit 1
    }

    if $check {
        print $"\n(ansi green)Alle Prüfungen bestanden.(ansi reset) Befehl:\n"
        print $"qemu-system-x86_64 (do $qemu_args $vars_placeholder | str join ' ')"
        return
    }

    # ── Start ─────────────────────────────────────────────────────────────
    let vars = (mktemp -t "winpe-vars.XXXXXX")
    open --raw $OVMF_VARS | save --force $vars
    let user = (^id -un | str trim)
    ^sudo setfacl -m $"u:($user):rw" $disk

    # "Press any key to boot from CD or DVD" automatisch bestätigen:
    # Hintergrundprozess schickt im 0,5-s-Takt "sendkey ret" an den Monitor.
    let keysender = '{ for i in $(seq "$2"); do echo "sendkey ret" > "/dev/tcp/127.0.0.1/$1"; sleep 0.5; done; } >/dev/null 2>&1 &'
    ^bash -c $keysender keysender $port $keys

    print $"\n(ansi attr_bold)VM läuft.(ansi reset) Ctrl+Alt+G Maus freigeben · Ctrl+Alt+2 Monitor · Ctrl+Alt+1 Anzeige"
    print "In WinPE sauber beenden mit:  wpeutil shutdown"

    try {
        ^qemu-system-x86_64 ...(do $qemu_args $vars)
    } catch {
        print $"(ansi yellow)QEMU wurde mit Fehler beendet.(ansi reset)"
    }

    # ── Aufräumen ─────────────────────────────────────────────────────────
    ^sudo setfacl -x $"u:($user)" $disk
    rm -f $vars
    print $"Aufgeräumt. SSD auswerfen mit:  udisksctl power-off -b ($disk)"
}
```

## Verwandt

- [[11-kvm-windows11-vm]] – dauerhafte Windows-11-VM mit libvirt
- [[KVM-QEMU Leitfaden]]
- [[01-UEFI-Booteinträge anlegen]]
- Quelle: [[2026-10-21 Windows-SSD und Legacy-zu-UEFI Umstellung]]
