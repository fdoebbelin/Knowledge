---
title: Ventoy Multiboot-Stick einrichten
tags: [ventoy, multiboot, usb, nushell, secureboot]
created: 2026-07-01
system: Fedora 44 / CachyOS · Ventoy
status: Referenz
---

> [!info] Konzept & Abgrenzung zu GLIM
> Ventoy installiert einen eigenen Bootloader auf den Stick und legt eine **exFAT**-Datenpartition an. ISOs kopierst du einfach dorthin – Ventoy zeigt sie beim Booten als Menü und startet sie über eine eigene Boot-Kette (kein stumpfes GRUB-loopback). Dadurch fällt genau das weg, woran [[GLIM Multiboot-Stick einrichten]] scheitert: der Fedora-`out of memory`, der 4-GB-FAT32-Deckel (exFAT!) und der `grub2-install`-Kampf. Der Preis dafür steht unten unter **Diskussion der Probleme**.

> [!warning] Der ganze Stick wird gelöscht
> `Ventoy2Disk.sh -i` überschreibt das komplette Gerät. Willst du deinen dokumentierten GLIM-Stick behalten, **nimm einen zweiten Stick** – das passt auch zum Mittelweg (GLIM sauber, Ventoy nur für Problemfälle wie Fedora).

## Voraussetzungen

```nu
# Fedora
sudo dnf install -y exfatprogs
# CachyOS/Arch
sudo pacman -S --needed exfatprogs
```

`Ventoy2Disk.sh` bringt seine eigenen Binaries mit; nötig ist nur `exfatprogs`, damit die exFAT-Datenpartition erstellt/gelesen werden kann.

## Schritt 1 – Download + Prüfsumme

> [!warning] Prüfsumme ist hier Pflicht
> Ventoy liefert vorkompilierte Blobs (siehe Problemdiskussion). Nur von der offiziellen Quelle laden **und** die SHA256 gegen die Angabe auf https://www.ventoy.net/en/download.html abgleichen.

```nu
# neueste Version über die GitHub-API bestimmen
let ver = (http get https://api.github.com/repos/ventoy/Ventoy/releases/latest | get tag_name)   # z.B. "v1.1.16"
let v   = ($ver | str replace "v" "")

# Linux-Tarball laden
http get $"https://github.com/ventoy/Ventoy/releases/download/($ver)/ventoy-($v)-linux.tar.gz" | save $"ventoy-($v)-linux.tar.gz"

# SHA256 berechnen und mit ventoy.net vergleichen
open --raw $"ventoy-($v)-linux.tar.gz" | hash sha256
```

> [!note] Falls `http get` beim Binär-Download zickt
> Alternativ: `curl -L -o $"ventoy-($v)-linux.tar.gz" $"https://github.com/ventoy/Ventoy/releases/download/($ver)/ventoy-($v)-linux.tar.gz"`

## Schritt 2 – Entpacken

```nu
tar xzf $"ventoy-($v)-linux.tar.gz"
cd $"ventoy-($v)"
```

## Schritt 3 – Stick identifizieren

> [!warning] Gerät prüfen – wird komplett überschrieben
> `TRAN=usb`, Größe und Modell müssen zum Stick passen. Buchstaben können sich zwischen Einsteck-Vorgängen verschieben.

```nu
lsblk -J -o NAME,SIZE,TYPE,MODEL,TRAN | from json | get blockdevices
```

## Schritt 4 – Ventoy installieren

```nu
# Neuinstallation (löscht /dev/sdX komplett)
sudo sh Ventoy2Disk.sh -i /dev/sdX
```

Wichtige Optionen:

| Option | Wirkung |
|---|---|
| `-i /dev/sdX` | Erstinstallation (bricht ab, falls Ventoy schon vorhanden) |
| `-I /dev/sdX` | Neuinstallation erzwingen (überschreibt vorhandenes Ventoy) |
| `-u /dev/sdX` | **Update** des Bootloaders, ISOs bleiben erhalten |
| `-l /dev/sdX` | Ventoy-Version + Secure-Boot-Status anzeigen |
| `-g` | GPT statt MBR (Default MBR bootet auf BIOS **und** UEFI) |
| `-r <MB>` | Platz am Ende für eine zweite Partition reservieren |

Secure-Boot-Unterstützung ist seit 1.0.76 standardmäßig aktiv – kein Extra-Flag nötig. Die Datenpartition wird als **exFAT** angelegt (fasst ISOs > 4 GB). Willst du lieber ext4, formatierst du Partition 1 nach der Installation um; Ventoy liest ISOs auch von ext4/NTFS.

## Schritt 5 – Verifizieren

```nu
sudo sh Ventoy2Disk.sh -l /dev/sdX
```

Zeigt installierte Ventoy-Version und ob Secure Boot aktiv ist. Ventoy legt zwei Partitionen an: `Ventoy` (exFAT, Daten) und `VTOYEFI` (~32 MB, Bootloader).

## Schritt 6 – ISOs draufkopieren

```nu
# Datenpartition mounten
udisksctl mount -b /dev/sdX1

# ISO(s) einfach hineinkopieren – Ordner sind erlaubt
cp ~/Downloads/Fedora-Workstation-Live-44-1.7.x86_64.iso /run/media/fritz/Ventoy/
cp ~/Downloads/Fedora-KDE-Desktop-Live-44-1.7.x86_64.iso /run/media/fritz/Ventoy/
cp ~/Downloads/Fedora-Sway-Live-44-1.7.x86_64.iso /run/media/fritz/Ventoy/
cp ~/Downloads/debian-live-13.5.0-amd64-gnome.iso     /run/media/fritz/Ventoy/
cp ~/Downloads/gparted-live-1.8.1-3-amd64.iso     /run/media/fritz/Ventoy/
```

Kein Ordnerzwang, keine `inc-*.cfg`-Tweaks. Verzeichnisse lassen sich mit einer leeren Datei `.ventoyignore` vom Scan ausschließen.

## Schritt 7 – Booten, Boot-Modi & Fedora

Im Firmware-Bootmenü den `UEFI:`-Eintrag des Sticks wählen → Ventoy-Menü → ISO auswählen.

- **Fedora** bootet in Ventoys Normalmodus direkt – hier verschwindet der GLIM-`out of memory`.
- Hakt eine ISO ausnahmsweise, gibt es umschaltbare Boot-Modi über Funktionstasten im Ventoy-Menü (u. a. Memdisk-Modus / GRUB2-Modus). Erst Normalmodus, dann diese als Fallback.

## Secure Boot

- Beim **ersten** Boot auf einem System mit aktivem Secure Boot erscheint der **MOKManager** → *Enroll Key* → Neustart. Danach bootet Ventoy dort mit aktivem Secure Boot. Nur einmal pro Rechner.
- **CA-2023-Umstellung:** Neuere Ventoy-Versionen haben den signierten shim wegen der Microsoft-UEFI-CA-2023-Ablösung getauscht. Nach einem Ventoy-Update kann ein **erneutes** Key-Enrollment nötig sein.
- Startet die Firmware vor dem MOKManager ab, hilft es, `MokManager.efi` in die Datenpartition zu legen und aus dem Ventoy-Menü direkt zu starten (Ventoy kann EFI-Binaries booten).
- Notfalls: Secure Boot im UEFI abschalten – dann bootet Ventoy ohne Enrollment.

## Update & Wartung

```nu
# Bootloader aktualisieren, ISOs bleiben erhalten
sudo sh Ventoy2Disk.sh -u /dev/sdX
```

Wegen der Secure-Boot-/CA-Baustellen 2026 lohnt es, Ventoy aktuell zu halten – aber immer per `-u` (nicht `-I`), damit die ISOs erhalten bleiben.

---

## Diskussion der Probleme

> [!warning] Reproduzierbarkeit / Binär-Blobs (der Kernpunkt)
> Ventoy liefert im Quellbaum zahlreiche vorkompilierte Binärdateien (diverse EFI-Binaries u. a.), deren Build nicht reproduzierbar ist – man kann aus dem Quellcode nicht dasselbe Executable erzeugen. Das ist eine Lieferketten-/Vertrauensfrage (kein belegter Backdoor). Genau deshalb bist du ursprünglich zu GLIM. Daran hat sich nichts geändert; Komfort wird gegen Nachprüfbarkeit getauscht. **Minderung:** nur von offizieller Quelle, SHA256 prüfen, Stick physisch kontrollieren.

Weitere Punkte, ehrlich benannt:

- **Kein Integritätsschutz der ISOs:** Die Ventoy-Partition ist ein normales Dateisystem. Wer Schreibzugriff hat, kann ISOs hinzufügen oder ersetzen – es gibt keine Signaturprüfung der abgelegten Images. Sensible Tools (Passwort-Reset, Forensik) besser auf einen getrennten Stick.
- **Boot-Chain-Injection:** Ventoy klinkt sich in den Boot des Gast-OS ein (eigener Bootloader + Anpassungen zur Laufzeit). Das ist der Mechanismus, der es „alles booten" lässt – und exakt das, was die Reproduzierbarkeits-Kritiker stört. GLIM dagegen reicht per `loopback` nur durch.
- **Secure-Boot-Vertrauensmodell:** MOK-Enrollment heißt, du vertraust Ventoys Schlüssel dauerhaft in deiner Firmware. Auf verwalteten/Firmen-Geräten ist das oft per Policy blockiert.
- **CA-2023-Churn:** Die shim-/Zertifikatsumstellung 2026 hat zu Boot-Ausfällen und Neu-Enrollments geführt. Aktiv gepflegt, aber gerade eine bewegliche Baustelle.
- **exFAT-Default:** Löst zwar den 4-GB-Deckel, ist aber ein Microsoft-Dateisystem (`exfatprogs` nötig). Für eine rein freie Kette ext4 wählen.
- **Fedora-Edge-Cases:** Historisch gab es Fedora-Boot-Probleme; heute meist gelöst, im Zweifel über die Boot-Modi (Funktionstasten) abfangen.

> [!tip] Mittelweg, der zu deinem Workflow passt
> GLIM bleibt dein reproduzierbarer, im Vault dokumentierter Alltags-Stick. Ventoy nimmst du auf einem **zweiten** Stick pragmatisch nur für die Problemkinder (real: Fedora). So bleibt die „saubere" Kette intakt, und du hast trotzdem ein Werkzeug, das kompromisslos alles bootet.

---

## Aufgaben

- [ ] `exfatprogs` installiert
- [ ] Tarball geladen, SHA256 gegen ventoy.net geprüft
- [ ] Zielstick zweifelsfrei als USB verifiziert (nicht der GLIM-Stick, falls behalten)
- [ ] `Ventoy2Disk.sh -i` gelaufen, `-l` bestätigt Version + Secure Boot
- [ ] Fedora-ISO kopiert und getestet (Normalmodus)
- [ ] Secure Boot: MOK-Key enrolled (falls SB aktiv)
- [ ] Blob-/Integritäts-Trade-off bewusst akzeptiert

---

Verwandt: [[GLIM Multiboot-Stick einrichten]] · [[GLIM Multiboot-Stick einrichten (Debian)]] · [[Multiboot-USB Werkzeuge im Vergleich]]
