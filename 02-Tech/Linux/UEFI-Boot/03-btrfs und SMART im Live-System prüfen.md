---
title: btrfs und SMART im Live-System prüfen
aliases:
  - btrfs check im Live-System
  - transid verify failed
  - SSD-Zustand mit SMART prüfen
tags:
  - linux
  - btrfs
  - smart
  - live-system
  - fedora-atomic
  - runbook
type: runbook
description: Root-btrfs einer Fedora-Atomic-Installation vom Live-Stick nur lesend prüfen, SMART-Langtest, Ergebnis aus dem Live-System retten und auswerten – mit Fallbeispiel eines verlorenen Schreibvorgangs.
system: Fedora 44 Live, Fedora Silverblue/Sway Atomic auf btrfs
created: 2026-10-21
status: active
---

# btrfs und SMART im Live-System prüfen

Anlass: GParted kann die btrfs-Root-Partition nicht verkleinern (siehe [[02-Legacy-zu-UEFI bei Fedora Atomic#Schritt 3: ESP anlegen (Live-Stick, GParted)|Schritt 3]]). Ziel ist, das Dateisystem **nur lesend** zu prüfen, den Zustand der SSD festzustellen und das Ergebnis auf einem anderen PC auszuwerten.

Mitnehmen: Fedora-**44**-Live-Stick (ältere kennen nicht alle btrfs-Funktionen), zweiter USB-Stick für das Ergebnis, Netzwerkkabel.

> [!tip] Im laufenden System geht schon einiges
> `sudo btrfs scrub start -B /var` prüft alle Prüfsummen online, `sudo btrfs device stats /var` zeigt gezählte Lese-/Schreibfehler. `btrfs check` dagegen nur ausgehängt, also vom Live-Stick.

## 1. Prüfen

Live-System starten (F8, „Fedora ausprobieren“, Terminal). Platte suchen, deren 3. Partition btrfs mit Label `fedora_fedora` ist – bei zwei gleichen SSDs hilft nur das Label:

```bash
lsblk -o NAME,SIZE,FSTYPE,LABEL,MODEL,MOUNTPOINTS
sudo umount -A /dev/sdX3            # GNOME hängt Platten oft automatisch ein; "not mounted" ist ok
```

Prüfung samt Kontext in eine Datei schreiben (`sdX` in der ersten Zeile ersetzen):

```bash
D=/dev/sdX
F=~/btrfs-check_$(date +%F_%H%M).txt
{
  echo "=== btrfs-Prüfung $(date '+%F %T')"
  lsblk -o NAME,SIZE,FSTYPE,LABEL,MODEL "$D"
  sudo fdisk -l "$D" | grep -i identifier
  btrfs --version
  echo; echo "=== btrfs check --readonly ${D}3"
  sudo btrfs check --readonly "${D}3"
  echo "Exit-Code: $?"
} 2>&1 | tee "$F"
```

`Exit-Code: 0` = keine Fehler, `1` = Fehler gefunden. Bei 110 GB dauert es einige Minuten.

SMART im selben Terminal anhängen (braucht Netzwerk):

```bash
sudo dnf install -y smartmontools
sudo smartctl -t long "$D"
sudo smartctl -c "$D" | grep -A1 -i extended     # Dauer des Langtests
# nach Ablauf:
{ echo; echo "=== SMART $D"; sudo smartctl -x "$D"; sudo smartctl -l selftest "$D"; } 2>&1 | tee -a "$F"
```

Steht bei `-l selftest` noch „in progress“, warten und wiederholen. Eine zweite SSD im PC mit `D=/dev/sdY` ebenso prüfen. Im installierten Silverblue erledigt das `bash uefi-pruefung.sh --smart` (siehe [[02-Legacy-zu-UEFI bei Fedora Atomic#1. Vorprüfung|Vorprüfung]]).

## 2. Ergebnis aus dem Live-System retten

> [!warning] Vor dem Herunterfahren sichern
> Ein mit Media Writer oder `dd` geschriebener Stick ist ein schreibgeschütztes ISO, das Live-Home liegt im RAM. Fedora Live liest außerdem laufend vom Stick – **Live-Stick nicht abziehen**, sonst hängt das System und die Datei ist weg.

| Variante | Vorgehen |
|---|---|
| A: zweiter Stick | in eine **zweite Buchse** oder einen Hub stecken; `cp "$F" /run/media/liveuser/<STICK>/ && sync`, dann im Dateimanager auswerfen |
| B: `/boot` der geprüften Platte | ext4, nicht das geprüfte btrfs: `sudo mount "${D}2" /mnt && sudo cp "$F" /mnt/ && sudo umount /mnt`; später `cat /boot/btrfs-check_*.txt`, danach löschen |
| C: Netz | Firefox im Live-System, per Webmail oder eigener Cloud hochladen |

Nur eine USB-Buchse frei? Mit `rd.live.ram=1` starten: im GRUB des Sticks `e`, an die `linux`-Zeile anhängen, Ctrl+X. Dann darf der Live-Stick gegen den Ergebnis-Stick getauscht werden.

## 3. Auswerten

### btrfs-Meldungen

| Ausgabe enthält | Bedeutung |
|---|---|
| `device busy` / `is mounted` | Partition noch eingehängt → `umount -A` wiederholen |
| `free space cache` / `cache and super generation don't match` | veralteter Freiplatz-Cache, harmlos; behebbar mit `--clear-space-cache v2` |
| `unsupported feature` / `couldn't open` | Live-System zu alt → Fedora-44-Stick |
| `csum mismatch`, `errors found in fs roots`, `ref mismatch`, `parent transid verify failed` | echte Fehler → Daten sichern, SMART prüfen, Datei auswerten lassen |

> [!danger] Niemals auf Verdacht `btrfs check --repair`
> Es kann ein beschädigtes Dateisystem verschlimmern. Allenfalls als Experiment nach vollständiger Sicherung; Teile landen dann typischerweise in `lost+found`.

Welches Subvolume betroffen ist, verrät die `root <ID>`-Angabe der Meldungen; die Zuordnung ID → Name zeigt `sudo btrfs subvolume list <Einhängepunkt>`. Bei Fedora Atomic liegen typischerweise drei Subvolumes vor: `root` (System-Image), `home` und `var` (u. a. `/var/lib/flatpak`, `/var/roothome`). Objekte mit Endung `.file`/`.dirtree` gehören zu einem **ostree-Repo** – bei Fehlern in `var` ist das das Flatpak-Repo, nicht das System-Image.

### SMART-Werte (RAW)

| Attribut | Gut | Tauschen, wenn … |
|---|---|---|
| 5 Reallocated_Sector_Ct | 0 | > 0 und steigend |
| 187 Reported_Uncorrect · 197 Current_Pending_Sector · 198 Offline_Uncorrectable | 0 | > 0 |
| Langtest (`-l selftest`) | Completed without error | read failure / abgebrochen |
| Error Log (in `-x`) | No Errors Logged | Einträge vorhanden |
| Restlebensdauer 169 · 231 · 233 (herstellerabhängig) | > 20 % | < 10 % |
| 199 UDMA_CRC_Error_Count | 0 | > 0: **Kabel/Port** tauschen, nicht die SSD |
| 174 Unexpect_Power_Loss_Ct · 192 Power-Off_Retract_Count | klein gegenüber 12 Power_Cycle_Count | hoch: Rechner werden hart ausgeschaltet |

> [!important] Entscheidung
> Fehlerwerte oder Langtest-Fehler: SSD tauschen. SMART sauber, aber `parent transid verify failed` und viele unerwartete Stromverluste: Die SSD hat **bestätigte Schreibvorgänge verloren** (Flush-Verhalten der Firmware) – das passiert beim nächsten harten Ausschalten wieder. Für Schulungsrechner trotzdem gegen ein Markenmodell tauschen. Notlösung: Schreibcache abschalten mit `sudo hdparm -W0 /dev/sdX` (langsamer, bei jedem Start neu setzen).

## Fallbeispiel: P8B75-M, Oktober 2026

```text
parent transid verify failed on 37573132288 wanted 4090 found 3586
owner ref check failed [37573132288 16384]
ERROR: errors found in extent allocation tree or chunk allocation
Wrong generation of child node/leaf, wanted: 3586, have: 4090
ERROR: errors found in fs roots      (146.802 Meldungen, alle "root 256")
Exit-Code: 1
```

- **Befund:** Ein einzelner 16-KiB-Metadatenknoten steht auf einem veralteten Stand (Generation 3586 statt 4090) – ein verlorener Schreibvorgang. Betroffen ist nur das Subvolume `var` (ID 256); `root` (Image) und `home` tauchen nicht auf.
- **Folge:** GParted kann das Dateisystem nicht verkleinern.
- **Entschieden:** kein `--repair`, kein `bootc`-Rebase (das Image ist intakt, der Fehler bliebe). Stattdessen Home sichern (`mount -o ro,subvol=home`, `tar`), neu installieren, zurückspielen. Stand: [[Schulungs-PCs – Stand der Umstellung]].

> [!failure]- Korrigierte Fehldeutung
> Die erste Auswertung ordnete die `.file`-/`.dirtree`-Objekte dem System-Image zu. Falsch: Sie gehören zum Flatpak-ostree-Repo unter `/var/lib/flatpak`.

## Verwandt

- [[02-Legacy-zu-UEFI bei Fedora Atomic]]
- [[ddrescue]] – Daten von einer sterbenden Platte retten
- [[LINUX Live-ISOs]]
