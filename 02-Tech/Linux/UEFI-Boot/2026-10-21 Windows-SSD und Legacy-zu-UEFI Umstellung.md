---
title: Windows-SSD reparieren und Fedora-Atomic-PCs von Legacy auf UEFI umstellen
created: 2026-10-21
type: chat-protokoll
source: claude.ai
model: Claude Opus 5.5
tags:
  - chat-protokoll
  - bootupd
  - btrfs
  - fedora-atomic
  - qemu
  - uefi
status: active
description: Windows-11-SSD per WinPE-VM untersucht, dann Schulungs-PCs mit Fedora Atomic von Legacy-BIOS auf UEFI umgestellt, inklusive Prüfskript, Arbeitsblättern und btrfs-/SMART-Diagnose.
system: Fedora Silverblue 44 / Fedora Sway Atomic auf ASUS P8B75-V und P8B75-M
---

# Windows-SSD reparieren und Fedora-Atomic-PCs von Legacy auf UEFI umstellen

> [!summary] Zusammenfassung
> Der Chat lief vom 19. bis 21.10.2026. Anlass war eine Windows-11-SSD, die nach einem Linux-Installationsversuch am Original-PC mit „kein bootfähiges Medium“ nicht mehr startete. Die Diagnose zeigte eine intakte SSD (GPT, ESP mit `EFI/Microsoft`, Windows bootet in einer QEMU-VM bis zur Anmeldung). Ursache ist die Firmware des Ziel-PCs, die im Legacy/CSM-Modus startet. Daraus entstand das eigentliche Projekt: Schulungs-PCs mit [[Fedora Sway Atomic|Fedora Atomic]], die im Legacy-Modus installiert sind, auf UEFI umstellen. Der Weg führt über eine nachträglich angelegte ESP, die signierten EFI-Dateien aus dem Image und die Übernahme durch bootupd. Entstanden sind ein Prüfskript, mehrere PC-spezifische PDF-Arbeitsblätter, ein Obsidian-Leitfaden und ein Nushell-Skript für eine WinPE-Rettungs-VM. Ein PC (P8B75-M) hat einen btrfs-Schaden in `/var` und wird neu installiert. Die Umbauten selbst sind noch nicht durchgeführt.

> [!info] Eingeordnet am 2026-10-21
> Dieses Protokoll ist die Quelle. Das verdichtete Wissen steht in:
> - [[01-UEFI-Booteinträge anlegen]] (Artefakt aus diesem Chat)
> - [[02-Legacy-zu-UEFI bei Fedora Atomic]] – Teil B, Probleme 8 und 9
> - [[03-btrfs und SMART im Live-System prüfen]] – Probleme 10 und 11
> - [[13-winpe-rettungs-vm]] – Teil A, Probleme 1–7, mit `winpe-vm.nu`
> - [[Schulungs-PCs – Stand der Umstellung]] – offene Punkte je PC
>
> Von den PDFs ist nur `Schritt-3-ESP-anlegen.pdf` als Beispiel erhalten; die übrigen PDFs und die reportlab-Generatoren wurden nicht übernommen, ihr Inhalt steckt in den Notizen 02 und 03.

> [!warning] Hinweise zur Vollständigkeit
> - Der Chat erstreckt sich über drei Tage. Den Ausgang der Windows-SSD-Reparatur am Original-PC kennt der Chat nicht.
> - Skripte und PDFs wurden mit Testplatten (Loop-Device) und Attrappen (QEMU, dmidecode, smartctl) geprüft, nicht auf echter Hardware.
> - Keine sensiblen Daten enthalten. Disk-IDs und UUIDs sind technische Kennungen der Schulungs-PCs.

## Ausgangslage

- Arbeitsrechner: Fedora Sway Atomic, Shell [[Nushell]], zeitweise ein zweiter Fedora-Rechner.
- Eine Windows-11-SSD (GPT: ESP 200M, MSR, NTFS 118,3G, WinRE; Disk-ID `98D4C679-…`) startet am Original-PC nicht mehr. Dort war versucht worden, im Restbereich Linux zu installieren. Die SSD hing per USB-Adapter („Tech“) am Arbeitsrechner.
- Später ging es um mehrere Schulungs-PCs mit ASUS P8B75-V (BIOS 1601, 09/2013) bzw. P8B75-M (BIOS 1701, 08/2014), jeweils Fedora Silverblue 44 bzw. Sway Atomic auf btrfs. Alle bis auf einen sind im Legacy-Modus installiert (GPT mit BIOS-boot-Partition 1M, `/boot` ext4 2G, Root btrfs `fedora_fedora`).

## Problemlösungen

### Teil A: Windows-SSD

#### 1. Windows-SSD bootet am Original-PC nicht

**Symptom**

```text
(am Original-PC, nur Windows-SSD angeschlossen) kein bootfähiges Medium gefunden
```

**Ursache:** Die SSD selbst ist intakt. Partitionstabelle unverändert, `EFI/Microsoft` und `EFI/Boot` vorhanden, in der VM bootet Windows bis zum Anmeldebildschirm. Die Meldung kommt von der Firmware, die im **Legacy/CSM-Modus** startet und auf einer GPT-Platte keinen MBR-Bootcode findet. Am Dozenten-PC bestätigt sich das: `'/sys/firmware/efi' | path exists` → `false`. Eine weitere mögliche Ursache (Schutz-MBR mit `pmbr_boot`-Flag nach einem Legacy-Installer) wurde genannt, aber nicht geprüft.

**Lösung:** Im Firmware-Setup UEFI erlauben, also Mischmodus oder „UEFI only“. ASUS P8B75-V mit BIOS 1601: Entf → F7 → Reiter Boot:

```text
CSM → Launch CSM:                 Enabled
CSM → Boot Devices Control:       UEFI and Legacy OpROM
CSM → Boot from Storage Devices:  Both, UEFI first
Secure Boot → OS Type:            Other OS
```

> [!failure]- Verworfene Ansätze
> - `efibootmgr` am Arbeitsrechner: NVRAM-Einträge liegen im Mainboard des Original-PCs, nicht auf der SSD.
> - Windows über den USB-Adapter am Original-PC booten: endet meist in `INACCESSIBLE_BOOT_DEVICE`, weil die Installation nicht als portables System eingerichtet ist.
> - Bootmanager mit `bcdboot` neu aufbauen: nicht nötig, die Bootdateien waren vollständig. Der Ablauf ist trotzdem dokumentiert (siehe Befehle).

**Verifikation:** Im Bootmenü (F8) erscheint „Windows Boot Manager“ bzw. „UEFI: <SSD>“. Ob das am Original-PC geklappt hat, ist offen.

#### 2. `efibootmgr`: EFI variables are not supported

**Symptom**

```text
EFI variables are not supported on this system.
```

**Ursache:** Das System läuft im Legacy-Modus (oder in einer Toolbox). Ohne UEFI-Boot gibt es keinen Zugriff auf das NVRAM.

**Lösung:** Prüfen mit `'/sys/firmware/efi' | path exists`. NVRAM-Einträge nur aus einem UEFI-gebooteten System anlegen (z. B. Live-Stick über „UEFI: <Stick>“).

#### 3. `rpm-ostree install` scheitert am Terra-Repo

**Symptom**

```text
error: Updating rpm-md repo 'terra': repodata terra was not complete: Incomplete repository - … primary.xml.zst is missing
```

**Ursache:** Unvollständige Metadaten auf dem Terra-Mirror, nichts mit QEMU zu tun.

**Lösung**

```bash
sudo rpm-ostree cleanup -m
sudo rpm-ostree install --apply-live qemu-kvm edk2-ovmf
# falls weiterhin: terra.repo kurzzeitig auf enabled=0, danach wieder auf 1
```

#### 4. QEMU startet nicht mit sudo

**Symptom**

```text
Authorization required, but no authorization protocol specified
gtk initialization failed
```

**Ursache:** QEMU als root darf nicht auf die Wayland-Sitzung (Sway) zugreifen.

**Lösung:** QEMU als normaler Benutzer starten, Zugriff auf die Platte per ACL:

```bash
sudo setfacl -m u:$USER:rw /dev/sdX
# nach Ende: sudo setfacl -x u:$USER /dev/sdX
```

#### 5. Falsche Platte im QEMU-Befehl

**Symptom:** Auf dem zweiten Rechner stand `/dev/sda` im Befehl, am ersten war die SSD `sdc`.

**Ursache:** Gerätenamen ändern sich zwischen Rechnern und Starts.

**Lösung:** Die Platte über den Disk identifier verifizieren (`sudo fdisk -l /dev/sdX` → `98D4C679-…`). Das Skript `winpe-vm.nu` prüft die Disk-ID vor dem Start.

#### 6. VM bootet installiertes Windows statt WinPE; Anzeige und Maus

**Symptom:** Statt der Reparaturkonsole erschien der Startbildschirm der Windows-Installation. Das Bild war abgeschnitten, und die Maus kam nicht aus dem Fenster.

**Ursache:** Die Abfrage „Press any key to boot from CD“ lief ohne Tastendruck ab, OVMF fiel auf den Fallback der SSD zurück. QEMU skaliert standardmäßig nicht und fängt die Maus.

**Lösung:** Feste Bootreihenfolge (`bootindex`), frisches NVRAM, automatischer Tastendruck über den QEMU-Monitor, `-display gtk,zoom-to-fit=on`, `-device qemu-xhci -device usb-tablet`, Maus freigeben mit Ctrl+Alt+G. Alles umgesetzt in `winpe-vm.nu`.

**Verifikation:** Windows kam in der VM bis zur Anmeldung, die Bootkette der SSD ist also intakt.

#### 7. Missverständnis: WinPE nur über das Windows ADK?

**Symptom:** Laut Microsoft-Seite zu `copype` und `MakeWinPEMedia` schien WinPE nicht über eine normale Windows-ISO startbar.

**Ursache:** Die Seite beschreibt den Bau eines eigenen WinPE. Die Windows-11-ISO bootet selbst ein WinPE (`sources\boot.wim`).

**Lösung:** Shift+F10 im Setup öffnet die Konsole. „Computerreparaturoptionen“ führte zu einem Neustart, die Konsole über Shift+F10 reicht aber für `diskpart`, `bcdboot`, `chkdsk`, `sfc`.

### Teil B: Schulungs-PCs von Legacy auf UEFI

#### 8. Machbarkeit der Umstellung bei Fedora Atomic

**Ursache / Befund:** Prüfung mit `uefi-pruefung.sh` auf drei Legacy-PCs: GPT mit BIOS-boot-Partition, keine ESP, kein freier Platz am Ende, bootupd 0.3.2 mit `Component BIOS` und `Detected: EFI: unknown` (übernehmbar), signierte EFI-Dateien unter `/usr/lib/efi/{shim,grub2}/…`, Vorlage `/usr/lib/bootupd/grub2-static/grub-static-efi.cfg`, `/boot/grub2/bootuuid.cfg` vorhanden. Eine Prüfung des Quellcodes von bootupd 0.3.2 ergab: `adopt-and-update` aktualisiert nur Dateien, die schon in der ESP liegen. `backend install` bricht ab, weil schon eine State-Datei existiert.

**Lösung (Weg A, Umbau ohne Neuinstallation)**

```bash
# Schritt 3 (Live-Stick, UEFI-gebootet): GParted, sdX3 (btrfs) am Ende um 1024 MiB verkleinern,
#   neue fat32-Partition "EFI" mit Flag esp → sdX4
# Schritt 4 (installiertes Fedora, Bash):
sudo mkdir -p /run/esp && sudo mount /dev/sdb4 /run/esp
sudo cp -r /usr/lib/efi/shim/*/EFI  /run/esp/
sudo cp -r /usr/lib/efi/grub2/*/EFI /run/esp/
sudo cp /usr/lib/bootupd/grub2-static/grub-static-efi.cfg /run/esp/EFI/fedora/grub.cfg
sudo cp /boot/grub2/bootuuid.cfg /run/esp/EFI/fedora/
sudo umount /run/esp
# Schritt 5: Bootmenü "UEFI: <SSD>" → shim-Fallback (fbx64.efi) legt NVRAM-Eintrag "Fedora" an
sudo bootupctl adopt-and-update
# Schritt 6: erst danach CSM aus ("UEFI only"), optional Secure Boot (OS Type: Windows UEFI mode)
```

> [!failure]- Verworfene Ansätze
> - `bootupctl backend install --component EFI` auf dem laufenden System: bricht ab („invalid re-install attempted“), weil der BIOS-State existiert.
> - BIOS-boot-Partition in eine ESP umwandeln: mit 1 MiB zu klein. Sie bleibt als Legacy-Rückfallebene (Hybrid).

**Verifikation**

```bash
[ -d /sys/firmware/efi ] && echo UEFI   # erwartet: UEFI
efibootmgr -v                           # erwartet: Fedora → \EFI\fedora\shimx64.efi
sudo bootupctl status                   # erwartet: Component EFI (zusätzlich BIOS)
```

Referenz-Soll-Zustand: Der dritte P8B75-V-PC (Intenso, `sda`) ist bereits im UEFI-Modus installiert (ESP 600M als `sda1`, `Component EFI`, Secure Boot aus). Dort steht nur ein Update-Neustart plus `sudo bootupctl update` an.

#### 9. `lsblk` zeigt keine Dateisystem-Typen; `parted` fehlt

**Symptom:** Leere FSTYPE- und UUID-Spalten. `sudo: parted: command not found` auf Silverblue.

**Ursache:** Toolbox bzw. fehlende udev-Daten. `parted` gehört nicht zum Silverblue-Image.

**Lösung:** `blkid` je Partition und `sfdisk -F` statt `parted` (beides util-linux). Ist im Skript umgesetzt.

#### 10. GParted kann btrfs nicht verkleinern (P8B75-M)

**Symptom** (Auszug aus 353.000 Zeilen `btrfs check --readonly`)

```text
parent transid verify failed on 37573132288 wanted 4090 found 3586
owner ref check failed [37573132288 16384]
ERROR: errors found in extent allocation tree or chunk allocation
Wrong generation of child node/leaf, wanted: 3586, have: 4090
ERROR: errors found in fs roots      (146.802 Meldungen, alle "root 256")
Exit-Code: 1
```

**Ursache:** Ein einzelner 16-KiB-Metadatenknoten steht auf einem veralteten Stand. Die SSD hat einen bestätigten Schreibvorgang verloren (typisch nach Stromausfall oder hartem Abschalten). Betroffen ist das Subvolume **`var`** (ID 256): Wurzel mit `adm`, `cache`, `lib` …; `/var/lib/flatpak` mit dem Flatpak-ostree-Repo (`.file`, `.dirtree`); `/var/roothome`. Das System-Image im Subvolume `root` und `home` tauchen nicht auf.

**Lösung (beschlossen):** Kein `--repair`, kein bootc-Rebase, denn das Image ist nicht defekt und der Fehler im Dateisystem bliebe. Stattdessen:
1. SMART beider Intenso-SSDs prüfen.
2. Home im Live-System sichern (`mount -o ro,subvol=home`, `tar`).
3. Zweite SSD abklemmen.
4. Silverblue bewusst im **Legacy-Modus** neu installieren.
5. Daten zurückspielen.
6. Anschließend regulär umbauen (Schritt 3–6), damit die Übung Legacy → UEFI erhalten bleibt.

> [!failure]- Verworfene Ansätze
> - Erste Auswertung ordnete die `.file`- und `.dirtree`-Objekte dem System-Image zu. Falsch: Es ist das Flatpak-Repo in `/var`. Wurde im Chat korrigiert.
> - `bootc switch`/`upgrade`: tauscht nur das (intakte) Image. Der Knoten in `var` und der Extent-Fehler blieben, `btrfs check` und das Verkleinern scheiterten weiter.
> - `btrfs check --repair`: nur als Experiment nach Sicherung denkbar, Teile von `/var/lib` landen vermutlich in `lost+found`.
> - Alternative ohne btrfs-Verkleinerung, gedacht für unbeschädigte Fälle: `/boot` (ext4 2G) um 1 GiB verkleinern und die ESP in die Lücke legen.

#### 11. Ergebnisdatei im Live-System sichern

**Symptom / Frage:** Kann die Datei auf den Live-Stick, und darf man den Live-Stick gegen einen Ergebnis-Stick tauschen?

**Ursache:** Ein mit Media Writer oder `dd` erstellter Stick ist schreibgeschützt (ISO). Das Live-Home liegt im RAM. Fedora Live liest laufend vom Stick.

**Lösung:** Zweiter Stick an einer **zweiten Buchse** oder einem Hub. Alternativ ablegen auf `/boot` (ext4) der geprüften Platte oder per Netz hochladen. Soll der Live-Stick abgezogen werden, mit `rd.live.ram=1` starten (GRUB: `e`, an die `linux`-Zeile anhängen, Ctrl+X).

## Artefakte & Prompts

### winpe-vm.nu

- **Typ:** Nushell-Skript
- **Beschreibung:** Startet eine KVM-VM mit Windows-ISO (WinPE) und reicht die Windows-SSD durch. Mit Vorab-Test, fester Bootreihenfolge, automatischem Tastendruck und Bildschirmanpassung.

**Original-Prompts** (chronologisch, wörtlich)

> bitte die komplette optionenauswahl für winpe und die windows 11 ssd in einem nushell script mit argumenten für winpe-iso und windows 11 lw, vorgaben sind die aktuellen, mit eingebautem test, immer in windows-py booten, feste bootreihenfolge, auch die bildschirmanpassung

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Schreibe ein Nushell-Skript winpe-vm.nu, das eine QEMU/KVM-VM (q35, OVMF/UEFI) startet, um eine
> Windows-11-SSD mit WinPE von der Windows-11-ISO zu reparieren. Argumente: --iso (Vorgabe
> ~/Downloads/Windows11_Client_x64_de-de_26300_9457.iso), --disk (Vorgabe /dev/sda, auch /dev/disk/by-id),
> --disk-id (erwartete GPT-Disk-ID 98D4C679-DF9E-4859-8B2D-DD26823AA3C2, "" = aus), --mem 4G,
> --port (Monitor-TCP-Port), --keys (Anzahl Enter-Drücke), --check (nur testen).
> Vor dem Start prüfen: qemu, OVMF, /dev/kvm, ISO, Blockgerät, GPT, Disk-ID, ESP + Microsoft basic data,
> nichts gemountet; bei Fehler abbrechen. Immer WinPE booten: bootindex ISO=0, SSD=1, NVRAM bei jedem Start
> frisch aus OVMF_VARS.fd, "Press any key" automatisch per QEMU-Monitor (sendkey ret) bestätigen.
> Anzeige: -display gtk,zoom-to-fit=on, qemu-xhci + usb-tablet. QEMU als normaler Benutzer (kein sudo,
> Wayland/Sway), Zugriff per setfacl, danach ACL und Temp-Datei aufräumen.
> ```

Eingebettet in [[13-winpe-rettungs-vm]].

### UEFI-Booteinträge anlegen.md

- **Typ:** Obsidian-Markdown-Leitfaden mit Mermaid-Diagramm
- **Beschreibung:** Booteinträge aus Linux (`efibootmgr`, abgegrenzt vom Legacy-Modus) und im BIOS-Setup bzw. per UEFI-Shell (`bcfg`), mit Spickzettel und Fallbeispiel.

**Original-Prompts** (chronologisch, wörtlich)

> erstelle bitte einen kommentierten Leitfaden zum Thema anlegen von Booteinträgen im BIOS:
>
> 1. aus einem aufenden LINUX im UEFI Modus, abgrenzen vom Legacy
> 2. eim BIOS selbst
>
> als Obsidian-Markdowndatei

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Erstelle einen kommentierten Leitfaden als Obsidian-Markdown-Datei (Frontmatter, Callouts, Mermaid) zum
> Anlegen von Booteinträgen: 0) Grundlagen UEFI vs. Legacy (NVRAM vs. MBR, Fallback \EFI\BOOT\BOOTX64.EFI,
> kein Moduswechsel per Chainloading); 1) aus einem laufenden Linux im UEFI-Modus mit efibootmgr
> (Modus prüfen, Ausgabe -v erklären, ESP/Loader ermitteln, anlegen/sortieren/BootNext/löschen,
> Fehlerbilder, Windows-Seitenblick bcdedit), klar abgegrenzt vom Legacy-Modus; 2) im BIOS-Setup
> (Tasten je Hersteller, CSM-Einstellungen, "Add Boot Option", UEFI-Shell bcfg). Spickzettel-Tabelle und
> Fallbeispiel "GPT-Windows-SSD meldet kein bootfähiges Medium, weil PC im Legacy-Modus startet".
> ```

Liegt im Vault als [[01-UEFI-Booteinträge anlegen]].

### Legacy-zu-UEFI-Vorpruefung.pdf

- **Typ:** PDF-Leitfaden (4 Seiten, reportlab)
- **Beschreibung:** Prüfbefehle vor der Umstellung, Aufruf des Prüfskripts, Bewertungstabellen je Prüfpunkt und Entscheidungshilfe Weg A/B.
- **Im Vault:** nicht als PDF, Inhalt in [[02-Legacy-zu-UEFI bei Fedora Atomic#1. Vorprüfung]].

**Original-Prompts** (chronologisch, wörtlich)

> bitte für die Befehle zum Test ein PDF-Leitfaden:
> Schick mir die Ausgaben der Punkte 2, 3, 6 und 7, dann schreibe ich dir den konkreten Ablauf für deinen Fall. Nach Punkt 6 und 7 richtet sich auch, ob Weg A bei dir wirklich sauber funktioniert.

> ja bitte in das Arbeitsblatt und in uefi-pruefung.sh einbauen, liefere bitte den letzten stand aller artefakte nochn einmal zum Download, ich möchte die sitzung hier an der stelle abschließen und mit claude code weiterführen

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Erstelle einen PDF-Prüfleitfaden (A4, deutsch) für die Vorprüfung, ob eine im Legacy-Modus installierte
> Fedora-Atomic-Version auf UEFI umgestellt werden kann. Inhalt: Rahmenbedingungen (auf dem Host, nicht in
> Toolbox; nur lesende Befehle), Systemplatte über /boot ermitteln (Bash und Nushell), Aufruf von
> uefi-pruefung.sh (auch --smart/--smart-long), je Pflichtpunkt (2 Partitionstabelle, 3 Partitionen/FS,
> 6 bootupctl status, 7 EFI-Dateien unter /usr/lib/efi) Befehl + Bewertungstabelle, Anhang mit Punkten
> 1, 4 (sfdisk -F, btrfs usage), 5, 8, 9, Entscheidungshilfe Weg A (Umbau) / Weg B (Neuinstallation).
> ```

### uefi-pruefung.sh

- **Typ:** Bash-Skript
- **Beschreibung:** Sammelt Hardware- und Firmware-Daten und die Prüfpunkte 1–10 (10 = SMART) in eine Datei `~/uefi-pruefung_<Mainboard>_<Host>_<Datum>.txt`. Nur lesend, bricht in einer Toolbox ab.

**Original-Prompts** (chronologisch, wörtlich)

> bitte den Befehl für Punkte 2 als skript zum ausführen

> kannst du die Befehle:
> sudo dmidecode -s system-manufacturer; sudo dmidecode -s baseboard-product-name
> [sudo] Passwort für fritz:
> System manufacturer
> P8B75-V
> fritz@fedora:~$ sudo dmidecode -s system-manufacturer
> System manufacturer
> fritz@fedora:~$ sudo dmidecode -s bios-version; sudo dmidecode -s bios-release-date
> 1601
> 09/19/2013
>
> und alle anderen wichtigen Befehle in  uefi-pruefung.sh einbauen und die Datei so benennen das der andere PC erkennbar ist

> ja bitte in das Arbeitsblatt und in uefi-pruefung.sh einbauen, liefere bitte den letzten stand aller artefakte nochn einmal zum Download, ich möchte die sitzung hier an der stelle abschließen und mit claude code weiterführen

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Schreibe ein Bash-Skript uefi-pruefung.sh (nur lesend) für die Vorprüfung Legacy → UEFI auf Fedora Atomic.
> Abbruch in Toolbox/Container; sudo einmal vorab. Systemplatte über /boot ermitteln oder als Argument.
> Ausgabe per tee in ~/uefi-pruefung_<Mainboard-Hersteller-Modell>_<hostname>_<YYYY-MM-DD_HHMM>.txt;
> dmidecode-Platzhalter ("System manufacturer", "To be filled by O.E.M." …) ignorieren, bei Eigenbau-PCs das
> Mainboard verwenden. Abschnitte: Hardware/BIOS (dmidecode, uname, CPU, lsblk -d), 1 Boot-Modus (bei UEFI
> efibootmgr -v, mokutil), 2 fdisk -l, 3 lsblk + blkid je Partition, 4 sfdisk -F + btrfs usage /sysroot,
> 5 crypt, 6 rpm -q bootupd, bootupctl status, grub2-static, bootuuid.cfg, 7 bootupd/updates, find /usr/lib/efi,
> rpm -q shim/grub2-efi, 8 fstab, 9 rpm-ostree status, flatpak list, ostree admin config-diff,
> 10 SMART aller Platten (smartctl lokal; mit --smart über Fedora-44-Container per podman; --smart-long
> startet Langtest und wartet) mit Kurzauswertung der Attribute 5,9,12,169,174,187,192,197,198,199,231,233.
> shellcheck-sauber.
> ```

Liegt im Vault unter [[_resources/uefi-pruefung.sh|_resources/uefi-pruefung.sh]], beschrieben in [[02-Legacy-zu-UEFI bei Fedora Atomic#1. Vorprüfung]].

### Schritt-3-ESP-anlegen.pdf (P8B75-V, INTENSO 476 GB, Dozenten-PC)

- **Typ:** PDF-Arbeitsblatt (4 Seiten, große Schrift, Kästchen zum Abhaken)
- **Beschreibung:** Schritt 0 Firmware prüfen (ASUS P8B75-V, BIOS 1601), Schritte 1–7: Live-Stick im UEFI-Modus, Platte identifizieren, GParted, sdX3 um 1 GiB verkleinern, ESP anlegen, prüfen, Neustart.
- **Im Vault:** ![[_resources/Schritt-3-ESP-anlegen.pdf]] (einziges erhaltenes PDF, als Beispiel)

**Original-Prompts** (chronologisch, wörtlich)

> bitte für Schritt 3 eine PDF anlegen, schön große Schrift

> kannst Du das in die PDF für schritt 3 mit aufnehmen, bei 4 Seiten bleiben

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Erstelle ein PDF-Arbeitsblatt (A4, max. 4 Seiten, Fließtext ca. 13,5 pt, Befehle 12,5 pt, Abhak-Kästchen,
> nummerierte Schrittköpfe) "Schritt 3: ESP anlegen" für einen PC mit ASUS P8B75-V (BIOS 1601) und
> INTENSO-SSD 476,94 GiB (1M BIOS boot · 2G /boot · 474,9G btrfs). Vorher-Checkliste (Backup /var/home,
> Fedora-Workstation-Live-Stick, Netzwerk). Schritt 0: F8-Test auf Mischmodus, sonst Entf/F7/Boot mit Tabelle
> CSM (Launch CSM Enabled, Boot Devices Control UEFI and Legacy OpROM, Boot from Storage Devices Both, UEFI
> first, Secure Boot OS Type Other OS), F10. Schritte 1–7: Live-Stick über "UEFI:" starten und prüfen, Platte
> an Modell/Größe identifizieren (Name im Live-System kann abweichen), GParted installieren, sdX3 nur am Ende um
> 1024 MiB verkleinern (Warnkasten: Anfang nie verschieben), fat32-Partition "EFI" mit Flag esp, fdisk-Kontrolle
> mit erwarteter Ausgabe, Neustart ohne Stick und lsblk-Kontrolle.
> ```

### Schritt-3-ESP-anlegen_ASUS-P8B75-M.pdf

- **Typ:** PDF-Arbeitsblatt (Variante)
- **Beschreibung:** Wie oben, für P8B75-M (BIOS 1701), Silverblue 44, mit Warnkasten „zwei gleiche Intenso-SSDs“ (Erkennung über Label `fedora_fedora` und Disk-ID `3386C0FB-…`). **Wegen btrfs-Schaden derzeit nicht anwendbar.** Erst nach der Neuinstallation nutzen, Disk-ID dann aktualisieren.
- **Im Vault:** nicht als PDF, PC-Daten in [[Schulungs-PCs – Stand der Umstellung]].

**Original-Prompts** (chronologisch, wörtlich)

> bitte folgende uefi-prüfung bewerten und die pdf schritt 3 entsprechend anpassen

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Bewerte die angehängte uefi-pruefung-Datei (P8B75-M, BIOS 1701, zwei Intenso SSD 111,8G, System sdb) und
> erstelle daraus eine PC-spezifische Fassung des Arbeitsblatts "Schritt 3: ESP anlegen" (4 Seiten, gleiche
> Gestaltung): PC in Kopf-/Fußzeile, Größen 111,79 GiB / 109,8 → 108,8 GiB, roter Warnkasten zu zwei
> identischen SSDs mit Erkennung über Label fedora_fedora und Disk identifier, Kontrolle in Schritt 7 über Label.
> ```

### Schritt-3-ESP-anlegen_ASUS-P8B75-V_CT120BX500.pdf

- **Typ:** PDF-Arbeitsblatt (Variante)
- **Beschreibung:** Für P8B75-V (BIOS 1601) mit Crucial CT120BX500 (`sda`, Disk-ID `42D2B644-…`), Hinweis auf den Namenswechsel `sda` → `sdb` im Live-System. Vorher den ausstehenden Update-Neustart abschließen.
- **Im Vault:** nicht als PDF, PC-Daten in [[Schulungs-PCs – Stand der Umstellung]].

**Original-Prompts** (chronologisch, wörtlich)

> jetzt das gleiche für diese prüfung

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Bewerte die angehängte uefi-pruefung-Datei (P8B75-V, BIOS 1601, eine Crucial CT120BX500SSD1 als sda) und
> erstelle eine eigene Fassung des Arbeitsblatts "Schritt 3: ESP anlegen" (4 Seiten): PC und SSD in Kopf-/
> Fußzeile, gelber Hinweis zur Platte (Label fedora_fedora, im Live-System oft sdb), Disk identifier 42D2B644-…,
> "bisher sda" in Schritt 7. Hinweis auf ausstehendes rpm-ostree-Update.
> ```

### btrfs-Pruefung-Live-System.pdf

- **Typ:** PDF-Arbeitsblatt (5 Seiten)
- **Beschreibung:** Nur lesender `btrfs check` vom Live-Stick, SMART-Langtest, Ergebnis sichern (zweiter Stick an zweiter Buchse, `/boot` oder Netz), `rd.live.ram=1`, Schnellbewertung, SMART-Bewertung, Entscheidung zum SSD-Tausch.
- **Im Vault:** nicht als PDF, Inhalt in [[03-btrfs und SMART im Live-System prüfen]].

**Original-Prompts** (chronologisch, wörtlich)

> bitte eine PDF für den check im live system, kann ich die btrfs-check.txt auf dem stick des  live systems sichern und zur analyse an einen anderen pc weitergeben

> erweitere die pdf um diese anweisungen für den usb stick

> ja bitte in das Arbeitsblatt und in uefi-pruefung.sh einbauen, liefere bitte den letzten stand aller artefakte nochn einmal zum Download, ich möchte die sitzung hier an der stelle abschließen und mit claude code weiterführen

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Erstelle ein PDF-Arbeitsblatt (A4, große Schrift, Abhak-Kästchen) "btrfs-Prüfung im Live-System" für
> Fedora-Atomic-PCs, deren btrfs-Root GParted nicht verkleinern kann. Mitnehmen: Fedora-44-Live-Stick,
> zweiter USB-Stick, Netzwerk. Schritte: 1 Live starten (Kasten: nur eine Buchse → rd.live.ram=1 per GRUB e/
> Ctrl+X), 2 Platte über Label fedora_fedora finden, 3 umount -A, 4 ein Block, der Datum, lsblk, Disk-ID,
> btrfs --version und btrfs check --readonly samt Exit-Code per tee in ~/btrfs-check_<Datum>.txt schreibt,
> 5 SMART (dnf install smartmontools, smartctl -t long, -x und -l selftest an dieselbe Datei anhängen, zweite
> SSD wiederholen), 6 Ergebnis sichern vor dem Herunterfahren (A zweiter Stick an zweiter Buchse/Hub, Warnung:
> Live-Stick nicht abziehen; B auf /boot ext4 der geprüften Platte; C per Firefox hochladen). Danach
> Schnellbewertungstabelle der btrfs-Meldungen, Warnung vor --repair, SMART-Bewertungstabelle und
> Entscheidungskasten (transid-Fehler + saubere SMART-Werte = Flush-Problem der SSD → trotzdem tauschen;
> Notlösung hdparm -W0).
> ```

### PDF-Generatoren (Python/reportlab)

- **Typ:** Python-Skripte `make_pdf.py`, `make_step3.py`, `make_step3_m.py`, `make_step3_v2.py`, `make_btrfs.py`, `pdfbase.py`
- **Beschreibung:** Erzeugen die PDFs oben. Schriften DejaVu Sans/Mono, gemeinsame Bausteine (Codebox, Kästchen, Schrittkopf) in `pdfbase.py`. Nicht in den Vault übernommen.

## Entscheidungen

- Weg A (Umbau) statt Neuinstallation, wo das Dateisystem gesund ist – bootupd 0.3.2 erkennt EFI als übernehmbar, alle signierten EFI-Dateien liegen im Image.
- BIOS-boot-Partition bleibt erhalten – Hybrid-Boot als Rückfallebene bis zur Umstellung auf „UEFI only“.
- ESP am Plattenende durch Verkleinern von btrfs um 1 GiB – genug Reserve auf allen PCs. Alternative: `/boot` verkleinern.
- Firmware erst nach erfolgreichem UEFI-Start auf „UEFI only“ – sonst startet das Legacy-Fedora nicht mehr.
- NVRAM-Eintrag über den shim-Fallback (`fbx64.efi` + `BOOTX64.CSV`) statt `efibootmgr` – funktioniert aus dem Legacy-System heraus vorbereitet.
- P8B75-M neu installieren, und zwar bewusst im Legacy-Modus – der btrfs-Schaden betrifft das Dateisystem, und die Übung Legacy → UEFI soll erhalten bleiben.
- Je PC ein eigenes Arbeitsblatt, Skript-Ausgabe mit Mainboard im Dateinamen – die PCs unterscheiden sich in SSD, Gerätenamen und Disk-ID.

## Nützliche Befehle & Snippets

```nu
'/sys/firmware/efi' | path exists                   # läuft das System im UEFI-Modus?
```

```bash
efibootmgr -v                                       # NVRAM-Booteinträge (nur UEFI)
sudo efibootmgr -c -d /dev/sdX -p 4 -L Fedora -l '\EFI\fedora\shimx64.efi'
sudo bootupctl status                               # BIOS/EFI-Komponenten, Adoptable
sudo bootupctl adopt-and-update                     # EFI-Dateien in der ESP übernehmen
sudo dmidecode -s baseboard-product-name            # Mainboard (Eigenbau-PCs)
sudo dmidecode -s bios-version; sudo dmidecode -s bios-release-date
sudo btrfs check --readonly /dev/sdX3               # nur ausgehängt (Live-System)
sudo btrfs scrub start -B /var                      # Online-Prüfsummen-Check im laufenden System
sudo btrfs device stats /var
sudo smartctl -t long /dev/sdX; sudo smartctl -l selftest /dev/sdX
sudo umount -A /dev/sdX3                            # alle Einhängepunkte einer Partition lösen
```

```bat
:: WinPE (Shift+F10): Windows-Bootmanager neu aufbauen
diskpart  → list vol → select vol <ESP> → assign letter=S → exit
bcdboot C:\Windows /s S: /f UEFI /l de-DE /v
bcdedit /store S:\EFI\Microsoft\Boot\BCD /enum
wpeutil shutdown
```

## Offene Punkte

- [ ] Windows-SSD: am Original-PC UEFI/Mischmodus einstellen und Start prüfen (Ergebnis unbekannt).
- [ ] Dozenten-PC (P8B75-V, INTENSO 476 GB, Sway Atomic): Schritte 3–6 durchführen.
- [ ] P8B75-V mit Crucial CT120BX500: Update-Neustart, dann Schritte 3–6.
- [ ] P8B75-V mit Intenso (schon UEFI): `systemctl reboot`, `sudo bootupctl update`, optional CSM aus und Secure Boot.
- [ ] P8B75-M: SMART beider Intenso-SSDs auswerten, Home sichern, SSD ggf. tauschen, Legacy-Neuinstallation (zweite SSD abklemmen), Rücksicherung (lokale RPMs `easyspeak`, RPM Fusion, COPR PyCharm, Flatpaks), danach Umbau. Disk-ID im Arbeitsblatt aktualisieren.
- [ ] Nach dem ersten Umbau prüfen, ob `bootupctl adopt-and-update` die EFI-Komponente wie erwartet übernimmt (Ausgabe von `bootupctl status`).
- [ ] Schritte 4 und 5 als eigene Arbeitsblätter (angeboten, nicht erstellt).
- [ ] Eindeutige Hostnamen für die Schulungs-PCs vergeben (`hostnamectl hostname …`).
- [ ] Ursache der verlorenen Schreibvorgänge klären: harte Abschaltungen (SMART 174/192) vs. SSD-Firmware.
