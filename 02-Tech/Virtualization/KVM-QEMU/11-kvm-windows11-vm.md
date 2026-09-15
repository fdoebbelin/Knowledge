---
titel: KVM/QEMU — Windows-11-VM unter Fedora Atomic
teil_von: "[[README]]"
tags: [kvm, qemu, libvirt, windows11, atomic, virt-install, vm-import, vm-restore, ovmf, swtpm, nushell]
zielgeraet: x86_64 Fedora Atomic (Yoga 920, Dozenten-PC)
erstellt: 2026-07-26
status: teilweise verifiziert
verifiziert_am: 2026-07-27
verifiziert_gegen: Fedora Atomic x86_64, edk2-ovmf-20260508-6.fc44, QEMU pc-q35-10.2
---

# 11 — Windows-11-VM unter Fedora Atomic

Gegenstück zum Hyper-V-Weg des XPS. Auf aarch64 gibt es kein `/dev/kvm`, dort
läuft Virtualisierung über Windows — siehe
[[docs/02-umgebung-wsl#Warum kein KVM auf diesem Gerät]]. Auf den x86_64-Kisten
(Yoga, Dozenten-PC) gibt es echtes KVM, also läuft die Windows-VM **nativ unter
libvirt**, nicht über einen Umweg.

> [!check] Restore-Abschnitt verifiziert am 2026-07-27
> Der Abschnitt „Vorhandene VM einbinden" wurde end-to-end live durchgespielt:
> Windows-11-VM aus einem Voll-Export (qcow2 + XML + NVRAM + swtpm-State)
> restauriert, gebootet, sauber heruntergefahren. Die übrigen Abschnitte
> (Neuanlage, Containerfile) sind weiterhin **Entwurf**.

## Kernaussage

Für eine Windows-11-VM ist die **System-Session** (`qemu:///system`) die
richtige Wahl, nicht die User-Session. Win11 braucht TPM 2.0, Secure Boot und
brauchbares Netz — alles Dinge, die in der System-Session auf dem
Standardpfad liegen. Der VM-Zustand landet in `/var/lib/libvirt/images`, also
unter `/var` — und bleibt damit von `bootc upgrade`/`switch` unangetastet.

## System- vs. User-Session

| Kriterium | `qemu:///system` | `qemu:///session` |
|---|---|---|
| Netzwerk | `default`-NAT (`virbr0`+dnsmasq), Bridging möglich | User-Mode (`passt`), Bridging nur über setuid-Helper |
| TPM 2.0 / Secure Boot | Standardpfad, alle Tools setzen es voraus | machbar, aber Handarbeit |
| SELinux/svirt | autom. Labels in `/var/lib/libvirt/images` | mehr Reibung |
| Rechte | `libvirt`-Gruppe nötig | rootless |
| Persistenz/Atomic | State in `/var`, überlebt bootc | State in `/var/home` |

> [!note] Warum nicht rootless
> Die Session-Session reizt aus Reproduzierbarkeits-Gründen — aber für einen
> Win11-Gast mit TPM, Secure Boot und echtem Netz ist das mehr Aufwand ohne
> Gegenwert. Rootless lohnt bei Wegwerf-Linux-VMs, nicht hier.

> [!warning] Tooling hängt an derselben Unterscheidung
> `virt-manager` **ohne** Parameter verbindet sich auf `qemu:///session` und
> meldet dann „kein Standard-Hypervisor erkannt", obwohl auf der
> System-Session VMs laufen. Immer explizit:
> ```nu
> virt-manager --connect qemu:///system
> ```
> Dauerhaft: Datei → Verbindung hinzufügen → QEMU/KVM. Gleiches Prinzip wie
> `LIBVIRT_DEFAULT_URI` für virsh. (Live beobachtet, 2026-07-27.)

## Pakete im Containerfile

Kein `rpm-ostree install` — die Pakete gehören ins Image, mit `rpm -q` als
Build-Guard (Exit 0 von dnf beweist keine Installation):

```dockerfile
RUN dnf install -y \
      libvirt-daemon-driver-qemu qemu-kvm \
      virt-install edk2-ovmf swtpm virt-viewer \
    && systemctl enable virtqemud.socket virtnetworkd.socket virtstoraged.socket \
    && rpm -q qemu-kvm swtpm edk2-ovmf virt-install \
    && printf 'd /var/lib/swtpm-localca 0750 tss root -\n' \
         > /usr/lib/tmpfiles.d/swtpm-localca.conf
```

Die modularen Daemons sind socket-aktiviert; `enable` der `.socket`-Units
reicht, kein `.service` von Hand starten.

> [!warning] Atomic-Lücke: `/var/lib/swtpm-localca` fehlt
> Beim ersten TPM-Manufacturing (jede **neue** VM mit vTPM) legt
> `swtpm_localca` als User `tss` das Verzeichnis `/var/lib/swtpm-localca` an.
> Auf ostree/bootc wird `/var` beim Image-Commit herausgelöst; das
> RPM-mitgelieferte Verzeichnis existiert nie, ein `tmpfiles.d`-Eintrag fehlt
> upstream. Folge (live beobachtet, 2026-07-27):
> ```
> Creating swtpm-localca dir '/var/lib/swtpm-localca'.
> Could not create directory for 'statedir': Permission denied
> An error occurred. Authoring the TPM state failed.
> ```
> → VM startet nicht. Der `tmpfiles.d`-Eintrag im Containerfile oben behebt
> das flottenweit. Hotfix auf laufender Maschine:
> ```nu
> sudo mkdir -p /var/lib/swtpm-localca
> sudo chown tss:root /var/lib/swtpm-localca
> sudo chmod 0750 /var/lib/swtpm-localca
> sudo restorecon -Rv /var/lib/swtpm-localca
> ```
> Beim **Restore** einer VM mit vorhandenem TPM-State wird gar nicht
> manufactured — der Bug wird dann umgangen (s. u.).

## Einrichtung und Prüfung

```nu
# KVM überhaupt verfügbar?
ls /dev/kvm

# In die libvirt-Gruppe (danach neu einloggen)
sudo usermod -aG libvirt $env.USER

# Modulare Daemons prüfen
systemctl is-active virtqemud.socket virtnetworkd.socket

# Default-Verbindung dauerhaft in env.nu
$env.LIBVIRT_DEFAULT_URI = "qemu:///system"

# Verbindung + Netz testen
virsh --connect qemu:///system list --all
virsh --connect qemu:///system net-list --all

# default-Netz starten + autostart, falls inaktiv
virsh --connect qemu:///system net-start default
virsh --connect qemu:///system net-autostart default
```

> [!tip] `sudo` und Nushell-Builtins
> `sudo open …` scheitert mit „Befehl nicht gefunden" — `open` ist ein
> Nushell-**Builtin**, `sudo` startet aber einen externen Prozess. Für
> root-Dateien immer das externe Pendant: `sudo cat <datei> | lines | last 10`.
> Gilt genauso für `ls` → `^ls` unter sudo. (Live beobachtet, 2026-07-27.)

## Neue VM anlegen

`--osinfo win11` konfiguriert bei virt-install ≥ 4.0 UEFI, Secure Boot und TPM
2.0 automatisch — die expliziten Flags sind Absicherung:

```nu
let flags = [
  "--connect"  "qemu:///system"
  "--name"     "win11"
  "--osinfo"   "win11"
  "--memory"   "8192"
  "--vcpus"    "4"
  "--cpu"      "host-passthrough"
  "--boot"     "uefi"
  "--features" "smm.state=on"
  "--tpm"      "backend.type=emulator,backend.version=2.0,model=tpm-crb"
  "--disk"     "size=64,bus=virtio"
  "--network"  "network=default,model=virtio"
  "--cdrom"    "/var/lib/libvirt/images/Win11.iso"
  "--disk"     "device=cdrom,path=/var/lib/libvirt/images/virtio-win.iso"
]
sudo virt-install ...$flags
```

Die zweite CD (`virtio-win.iso`) liefert im Setup die virtio-Storage- und
Netz-Treiber — ohne sie sieht der Windows-Installer die virtio-Disk nicht.

> [!tip] Flotte vs. Einzelgerät
> `--cpu host-passthrough` ist am schnellsten, aber nicht zwischen
> unterschiedlicher Hardware migrierbar. Für eine ortsfeste Coaching-VM egal.
> Soll dieselbe Definition auf Intel- **und** AMD-Kisten laufen, dann
> `--cpu host-model`.

## Vorhandene VM einbinden

> [!check] Verifiziert am 2026-07-27
> Kompletter Ablauf live durchgespielt: Windows-11-Pro-VM aus einem
> Voll-Export restauriert — mit intakter TPM (kein Re-Manufacturing, BitLocker
> unversehrt), Secure Boot aktiv, sauberer Shutdown. Die dabei gelösten
> Probleme sind unten unter „Gelöste Probleme" diskutiert.

**Zuerst klären, was vorliegt.** Davon hängt der gesamte Weg ab:

| Vorhanden | Weg |
|---|---|
| Nur Disk (qcow2/raw) | **B: Bare-Disk-Import** mit `virt-install --import` — TPM und NVRAM werden neu erzeugt |
| Voll-Export: Disk + XML + `*_VARS.fd` + `swtpm-state/` | **A: Restore** — Definition, NVRAM und TPM werden übernommen, nichts wird neu erzeugt |

> [!caution] Bei Windows mit BitLocker ist der Restore Pflicht, kein Komfort
> Die BitLocker-Schlüssel sind an **genau diese** vTPM versiegelt. Der
> Bare-Disk-Import lässt swtpm eine **neue** TPM manufacturen → Windows
> verlangt den Recovery-Key. Liegt der Export vollständig vor, immer den
> Restore-Weg gehen. Recovery-Key trotzdem bereithalten: Windows kann die
> geänderte virtuelle Plattform bemerken.

### Weg A — Restore aus Voll-Export (verifiziert)

Ausgangslage im verifizierten Durchlauf: `win11.qcow2` (137 GB), `win11.xml`,
`Windows 11 Pro_VARS.fd` (540,6 kB → 4M-Build),
`swtpm-state/tpm2/tpm2-00.permall`.

#### A.1 — Export inspizieren

Alles Folgende hängt an drei Fakten aus dem XML: **UUID**, **Domain-Name**
und die **erwarteten Pfade**.

```nu
# UUID — bestimmt den Zielordner des TPM-States
let uuid = (open --raw win11.xml | parse --regex '<uuid>(?<u>[0-9a-f-]+)</uuid>' | get u.0)

# Domain-Name — bestimmt alle virsh-Aufrufe und die Log-Dateinamen
open --raw win11.xml | lines | find --regex '<name>'

# Erwartete Pfade: Disk, NVRAM, Loader, TPM, Machine-Typ
open --raw win11.xml | lines | find --regex 'source file|nvram|loader|<tpm|machine='

# Struktur des TPM-States (entscheidet den Kopierbefehl in A.3)
ls swtpm-state/**/* | select name size
```

> [!warning] Der Domain-Name kommt aus dem XML — nicht raten
> libvirt benennt die Domain nach dem `<name>`-Element (hier:
> `Windows 11 Pro`, mit Leerzeichen), nicht nach dem XML-Dateinamen
> (`win11.xml`). Alle `virsh`-Aufrufe, der swtpm-Log-Name
> (`Windows 11 Pro-swtpm.log`) und das QEMU-Log
> (`/var/log/libvirt/qemu/Windows 11 Pro.log`) folgen dem XML-Namen.
> Wer `win11` rät, sucht Fehler in den falschen Logdateien.

#### A.2 — Firmware-Pfade auf Fedora übersetzen

Domain-XML von anderen Distros bringt fremde OVMF-Pfade mit
(`/usr/share/edk2/x64/OVMF_CODE.secboot.4m.fd` ist Debian/Ubuntu-Konvention).
Fedora hat andere Pfade **und** andere Bauarten. Die autoritative Quelle sind
die Firmware-Deskriptoren — nie aus dem Gedächtnis, nie raten:

```nu
# Welche Deskriptoren gibt es?
ls /usr/share/qemu/firmware/*.json | get name

# Pfade für 4M + Secure Boot auslesen (Records sind verschachtelt!)
let fw = (open /usr/share/qemu/firmware/40-edk2-ovmf-4m-qcow2-x64-sb.json | get mapping)
$fw.executable.filename        # CODE  → in <loader>
$fw.nvram-template.filename    # VARS-Template → in <nvram template=…>

# Existenz-Gegencheck
$fw.executable.filename | path exists
```

> [!caution] 2M-`.fd` vs. 4M-`.qcow2` — die Hauptfalle
> Fedoras `/usr/share/edk2/ovmf/*.fd`-Dateien sind die **2M**-Builds
> (`OVMF_CODE.secboot.fd` = 1,9 MB). Die **4M**-Builds liegen daneben als
> **qcow2**. Eine 4M-`VARS.fd` (~540 kB) zu einem 2M-CODE gemappt heißt: die
> Firmware startet nie — QEMU läuft, `virsh list` sagt „laufend", aber der
> Screenshot zeigt dauerhaft „Guest has not initialized the display (yet)".
> Erkennungsmerkmal per Größe: CODE 1,9 MB = 2M, ~3,5–4 MB = 4M; VARS
> 128 kB = 2M, ~540 kB = 4M. CODE und VARS **müssen** dieselbe Bauart haben;
> gemischte *Formate* (qcow2-CODE + raw-VARS) sind dagegen erlaubt, da pro
> Datei deklariert.

#### A.3 — Dateien an ihre Plätze

```nu
# Disk — reflink: auf derselben btrfs-Fläche sofort, Backup bleibt unangetastet
sudo cp --reflink=auto win11.qcow2 /var/lib/libvirt/images/win11.qcow2
sudo restorecon -v /var/lib/libvirt/images/win11.qcow2

# NVRAM — Zielname EXAKT wie im XML, inklusive Leerzeichen
sudo mkdir -p /var/lib/libvirt/qemu/nvram
sudo cp "Windows 11 Pro_VARS.fd" "/var/lib/libvirt/qemu/nvram/Windows 11 Pro_VARS.fd"
sudo restorecon -v "/var/lib/libvirt/qemu/nvram/Windows 11 Pro_VARS.fd"

# TPM-State by-UUID — tss:tss ist Pflicht, sonst findet swtpm den State nicht
sudo mkdir -p $"/var/lib/libvirt/swtpm/($uuid)"
sudo cp -r swtpm-state/tpm2 $"/var/lib/libvirt/swtpm/($uuid)/"
sudo chown -R tss:tss $"/var/lib/libvirt/swtpm/($uuid)"
sudo restorecon -Rv $"/var/lib/libvirt/swtpm/($uuid)"

# Kontrolle
^ls -l $"/var/lib/libvirt/swtpm/($uuid)/tpm2/tpm2-00.permall"
```

Zwei Detailfallen: Der NVRAM-Dateiname im XML kann **Leerzeichen** enthalten
(„Windows 11 Pro_VARS.fd") — nicht umbenennen, sondern exakt so ablegen, wie
das XML es nennt. Und den `tpm2/`-Ordner **als Ganzes** kopieren — wer den
*Inhalt* in einen selbst angelegten `tpm2/` kopiert, erzeugt `tpm2/tpm2/…`
und swtpm manufactured neu.

#### A.4 — XML anpassen: manuelle Firmware

Für einen Restore mit vorhandener VARS-Datei ist die
**Firmware-Autoselection abzuschalten** — libvirt soll nichts aus Templates
neu generieren, sondern exakt die restaurierten Dateien nutzen. Manuell
heißt **drei Dinge gleichzeitig**:

1. Attribut `firmware='efi'` am `<os>`-Element entfernen
2. Den kompletten `<firmware>…</firmware>`-Block (mit den
   `<feature>`-Zeilen) entfernen
3. `<loader>` und `<nvram>` auf die Deskriptor-Pfade aus A.2 setzen

```nu
open --raw win11.xml
  | str replace "<os firmware='efi'>" "<os>"
  | str replace --regex '(?s)\s*<firmware>.*?</firmware>' ''
  | str replace "/usr/share/edk2/x64/OVMF_CODE.secboot.4m.fd" $fw.executable.filename
  | str replace "format='raw'>/usr/share/edk2" "format='qcow2'>/usr/share/edk2"
  | str replace "/usr/share/edk2/x64/OVMF_VARS.4m.fd" $fw.nvram-template.filename
  | save -f win11.xml

# Kontrolle — alle fünf Bedingungen auf einen Blick
open --raw win11.xml | lines | find --regex '<os|<firmware|<loader|<nvram|<smm'
```

Erwartet: `<os>` ohne `firmware=`-Attribut · **kein** `<firmware>`-Block ·
`<loader … secure='yes' format='qcow2'>` auf die 4M-CODE · `<nvram>` weiterhin
`format='raw'` auf die eigene VARS-Datei · `<smm state='on'/>` unangetastet.
Im manuellen Modus tragen `secure='yes'` + `<smm>` die
Secure-Boot-Konfiguration — der entfernte Feature-Block wird nicht vermisst.

Die `str replace`-Quellpfade an das anpassen, was A.1 tatsächlich zeigte;
bei Unbehagen mit Regex auf 8 kB XML: `hx win11.xml` und die drei Änderungen
von Hand.

#### A.5 — Definieren, starten, verifizieren

```nu
virsh --connect qemu:///system define win11.xml
virsh --connect qemu:///system start "Windows 11 Pro"
sleep 15sec
virsh --connect qemu:///system screenshot "Windows 11 Pro" /tmp/win11.ppm
```

**Der entscheidende Nachweis** — es darf **kein** Re-Manufacturing gegeben
haben (sonst wäre die TPM neu und BitLocker gesperrt):

```nu
sudo cat "/var/log/swtpm/libvirt/qemu/Windows 11 Pro-swtpm.log" | lines | last 10
```

Sauber = nur die zwei SHA1-Profil-Warnungen, **keine** Zeile
`Starting vTPM manufacturing`. Achtung: Der Log-Dateiname folgt dem
Domain-Namen; Logs früherer Fehlversuche unter anderem Namen liegen daneben
und führen in die Irre.

Bei schwarzem Screenshot trotz korrekter Firmware: QEMU-Log lesen — es
zeigt die tatsächlich gemappten pflash-Dateien und Fehler, die `virsh list`
nicht sieht („laufend" heißt nur: der Prozess existiert):

```nu
sudo cat "/var/log/libvirt/qemu/Windows 11 Pro.log" | lines | last 40
```

### Weg B — Bare-Disk-Import (nur Disk vorhanden)

qcow2/raw muss nicht konvertiert werden — Definition um die Disk bauen und
mit `--import` booten, ohne Installer. TPM und NVRAM entstehen dabei **neu**
(→ swtpm-localca-Falle oben beachten; bei BitLocker Recovery-Key nötig).

```nu
sudo mv mein-image.qcow2 /var/lib/libvirt/images/win11.qcow2
sudo restorecon -v /var/lib/libvirt/images/win11.qcow2
qemu-img info /var/lib/libvirt/images/win11.qcow2

let flags = [
  "--connect"     "qemu:///system"
  "--name"        "win11"
  "--osinfo"      "win11"
  "--memory"      "8192"
  "--vcpus"       "4"
  "--cpu"         "host-passthrough"
  "--boot"        "uefi"
  "--features"    "smm.state=on"
  "--tpm"         "backend.type=emulator,backend.version=2.0,model=tpm-crb"
  "--disk"        "path=/var/lib/libvirt/images/win11.qcow2,format=qcow2,bus=sata"
  "--network"     "network=default,model=virtio"
  "--graphics"    "spice"
  "--import"
  "--noautoconsole"
]
sudo virt-install ...$flags
```

`bus=sata` ist beim Import die bootsichere Wahl: Windows ohne
virtio-Storage-Treiber bootet mit `bus=virtio` in
`INACCESSIBLE_BOOT_DEVICE`. Erst booten, virtio-Treiber von `virtio-win.iso`
installieren, dann umstellen. Bei einem **Linux-Gast** entfallen `--boot`,
`--features`, `--tpm`; `--osinfo` passend setzen (z. B. `fedora44`).

### Aufräumen fehlgeschlagener Versuche

```nu
virsh --connect qemu:///system destroy win11      # hart aus — löscht NICHTS
virsh --connect qemu:///system undefine win11 --nvram --tpm
```

`--nvram --tpm` räumt das automatisch erzeugte NVRAM und den (ggf. halb
manufactured) swtpm-State mit weg — sonst stolpert der nächste Versuch über
die Reste. `destroy` entspricht dem Netzstecker: Disk, NVRAM und TPM bleiben
unangetastet; der ACPI-„Herunterfahren"-Knopf greift ohnehin nur, wenn der
Gast weit genug gebootet ist, um ACPI zu hören.

## Gelöste Probleme (Sitzung 2026-07-27)

Der Restore lief nicht glatt durch — sechs Probleme, jedes mit
verallgemeinerbarer Lehre:

**1. swtpm-Manufacturing scheitert: `Permission denied` auf
`/var/lib/swtpm-localca`.** Erstes Symptom beim Bare-Disk-Import. Ursache ist
eine Atomic-Eigenheit: RPM-mitgelieferte `/var`-Verzeichnisse existieren auf
ostree/bootc nicht, und swtpm bringt keinen `tmpfiles.d`-Eintrag mit.
*Lösung:* eigener `tmpfiles.d`-Eintrag im Containerfile (flottenweit) bzw.
`mkdir` + `chown tss` als Hotfix. *Pointe:* Der Restore-Weg umgeht das
Problem vollständig, weil mit vorhandenem TPM-State gar nicht manufactured
wird — was für BitLocker ohnehin zwingend ist. In der Sitzung wurde der
Hotfix daher nie gebraucht; der Eintrag gehört trotzdem ins Image, für die
erste *neue* VM.

**2. `define` scheitert: „Unable to find 'efi' firmware…".** Das XML kam von
einer anderen Distro; `firmware='efi'` ließ libvirt die Loader-Pfade gegen
die lokalen Deskriptoren matchen — die Debian-Pfade
(`…/x64/OVMF_CODE.secboot.4m.fd`) existieren auf Fedora nicht. *Lösung:*
Autoselection abschalten, explizite Fedora-Pfade. *Lehre:* Distro-fremde
Domain-XML immer zuerst auf Firmware-Pfade prüfen; die
`/usr/share/qemu/firmware/*.json`-Deskriptoren sind die einzige verlässliche
Pfadquelle.

**3. Firmware startet nicht: Dauerschwarz trotz „laufend".** Der erste
Korrekturversuch mappte die 4M-VARS (540 kB) auf Fedoras
`OVMF_CODE.secboot.fd` — die sich als **2M**-Build (1,9 MB) herausstellte.
QEMU-Prozess lief, `virsh list` meldete „laufend", VGA war primäre Anzeige —
und trotzdem dauerhaft „Guest has not initialized the display (yet)".
*Lösung:* 4M-CODE als qcow2 aus dem Deskriptor (`$fw.executable.filename`).
*Lehre:* „laufend" in `virsh list` beweist nur die Existenz des Prozesses.
Ob die Firmware Code ausführt, zeigen nur `virsh screenshot` und das
QEMU-Log unter `/var/log/libvirt/qemu/<name>.log` — Letzteres listet die
pflash-Mappings wörtlich. Und: Größen vergleichen kostet zehn Sekunden und
hätte hier zwei Debug-Runden gespart.

**4. `define` scheitert erneut: „cannot use feature-based firmware
autoselection when firmware autoselection is disabled".** Das Attribut
`firmware='efi'` war entfernt, der `<firmware>`-Block mit den
`<feature>`-Zeilen aber noch da — für libvirt ein Widerspruch. *Lehre:*
Manuelle Firmware heißt Attribut **und** Block entfernen, immer beides.
`secure='yes'` am Loader plus `<smm state='on'/>` tragen Secure Boot allein.

**5. `start` scheitert: „Abruf der Domain 'win11' scheiterte".** Die Domain
hieß `Windows 11 Pro` — der Name kommt aus dem `<name>`-Element, nicht aus
dem Dateinamen `win11.xml`. Folgeeffekt: Das zunächst gelesene
`win11-swtpm.log` war die Leiche eines kaputten Erstversuchs; das echte Log
der laufenden Domain hieß `Windows 11 Pro-swtpm.log`. *Lehre:* Name und UUID
**zuerst** aus dem XML extrahieren, alle weiteren Befehle und Log-Pfade
daraus ableiten (Schritt A.1 existiert genau deshalb).

**6. virt-manager „erkennt keinen Hypervisor" trotz laufender VM.** Kein
Widerspruch: virt-manager verbindet ohne Parameter auf `qemu:///session`,
die VM lief auf `qemu:///system`. *Lehre:* Die
System-vs-Session-Entscheidung vom Anfang der Notiz gilt auch fürs Tooling —
jede Komponente (virsh, virt-manager, virt-viewer) braucht die Verbindung
explizit oder per `LIBVIRT_DEFAULT_URI`.

Quer durch alle sechs: **Die Diagnosekette ist wichtiger als jeder
Einzelfix.** `virsh list` → `virsh screenshot` → swtpm-Log → QEMU-Log
unterscheidet in zwei Minuten zwischen „Anzeigeproblem", „Firmware startet
nicht", „TPM kaputt" und „Gast bootet nicht" — vier Lagen, die sich am
schwarzen Bildschirm identisch anfühlen. Für die Diagnose war
zwischenzeitlich `vga` als primäre Anzeige nützlich: eine VGA zeichnet vom
ersten Firmware-Takt an — bleibt sie schwarz, liegt das Problem **vor** der
Grafik.

## Grafik: QXL jetzt, virtio später

Produktiv-Entscheidung nach dem Restore:

- **QXL**: klassischer Spice-Partner, Treiber im restaurierten Windows
  bereits installiert, nachweislich funktionsfähig → risikofreie Wahl jetzt.
  Aber Legacy: QXL und die Windows-Spice-Gasttreiber werden kaum noch
  weiterentwickelt.
- **virtio-gpu** (`viogpudo`-Treiber von `virtio-win.iso`): der moderne
  Pfad, konsistent mit virtio-NIC und künftiger virtio-Disk. Kein 3D unter
  Windows — das bietet QXL aber auch nicht.

```nu
# VM muss ausgeschaltet sein
virt-xml "Windows 11 Pro" --connect qemu:///system --edit --video model=qxl
```

> [!tip] Ein Wartungsfenster, zwei Umstellungen
> Der Wechsel auf virtio-gpu lohnt **zusammen** mit der Disk-Umstellung
> SATA→virtio-blk (die restaurierte VM hängt aktuell als `ide-hd` am
> SATA-Bus — bootsicher, aber langsamer): einmal `virtio-win.iso` einlegen,
> `viogpudo` + `viostor` installieren, beide Devices in einem Rutsch
> umstellen.

## Offene Punkte

- [ ] Grafik + Disk gemeinsam auf virtio umstellen (`viogpudo`, `viostor`)
- [ ] `tmpfiles.d/swtpm-localca.conf` ins Containerfile des `kvm/win11`-Moduls
- [ ] swtpm-localca-`/var`-Lücke als Bug upstream melden (Fedora/swtpm)
- [ ] Alt-Log `win11-swtpm.log` und verwaiste Erstversuch-Reste entfernen
- [ ] Klären, ob die Virtualisierungspakete auf der Build-Basis (Bluefin DX)
      schon vorhanden sind oder erst ins Noctarow-Containerfile müssen
- [ ] Entscheidung `host-passthrough` vs. `host-model` für die Schulungsflotte
- [ ] Neuanlage-Abschnitt („Neue VM anlegen") einmal live durchspielen, dann
      Notiz komplett auf `verifiziert` heben
