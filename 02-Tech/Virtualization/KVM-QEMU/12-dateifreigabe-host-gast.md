---
title: Nextcloud im Windows-Gast — virtiofs statt Samba
teil_von: "[[README]]"
tags: [kvm, qemu, libvirt, windows11, virtiofs, virtiofsd, winfsp, nextcloud, samba, atomic, nushell]
zielgeraet: privater KI-Arbeitsplatz, x86_64 Fedora Atomic
created: 2026-07-28
status: draft
verifiziert_gegen: —
---

# 12 — Nextcloud im Windows-Gast

Ergänzung zu [[11-kvm-windows11-vm]]. Ziel: Der **gesamte**
Nextcloud-Ordner des Benutzers, `/var/home/fritz/Nextcloud`, erscheint in der
Windows-11-VM als Laufwerk `N:` — ohne den Samba-Umweg, der auf CachyOS
gefahren wurde.

> [!warning] Status: Entwurf
> Der Weg ist gegen die virtio-win- und libvirt-Dokumentation belegt, aber
> noch nicht live durchgespielt. Erst nach erfolgreichem Durchlauf auf
> `verifiziert` heben.

## Kernaussage

Für „Gast greift auf Host-Ordner zu" ist **virtiofs** die richtige Wahl, nicht
Samba. Auf Atomic wiegt das doppelt: Samba ist kein `dnf install`, sondern
eine **Image-Änderung** — Paket ins Containerfile, `bootc switch`, Neustart,
dazu firewalld-Zone, SELinux-Booleans und eine zweite Benutzerverwaltung
(`smbpasswd`) in `/var`. virtiofs kostet ein Paket auf dem Host, zwei
XML-Elemente an der Domain und zwei Installationen im Gast — und läuft über
den Hypervisor, nicht über das Netz.

| | virtiofs | Samba (CachyOS-Weg) | SPICE/WebDAV |
|---|---|---|---|
| Host-Aufwand auf Atomic | `virtiofsd` ins Image | `samba` ins Image + Firewall + SELinux + `smbpasswd` | nichts |
| Authentifizierung | keine (Hypervisor-Ebene) | eigene Samba-Passwörter | keine |
| Performance | lokale FS-Semantik | Netzwerk-Overhead | langsam |
| Gast-Aufwand | WinFsp + `viofs`-Treiber | nichts, SMB ist eingebaut | `spice-webdavd` |
| Ohne offene Konsole | ja | ja | **nein** |
| Snapshots mit RAM | eingeschränkt (s. u.) | unberührt | unberührt |

Kurzfassung des Atomic-Samba-Wegs steht im Anhang, für den Fall, dass später
weitere Geräte auf denselben Ordner sollen.

## Topologie: ein Client, ein Verzeichnis

Synchronisiert wird **ausschließlich auf dem Linux-Host**. Im Gast läuft
weder ein Nextcloud-Client noch existiert dort eine zweite Kopie; Windows
sieht über `N:` denselben Verzeichnisbaum, den der Host-Client pflegt.

Das ist nicht nur bequem, sondern die technisch saubere Variante: Zwei
Clients auf demselben Verzeichnisbaum hieße zwei Sync-Datenbanken, die sich
gegenseitig Änderungen als Fremdänderungen melden — eine zuverlässige Quelle
für Konfliktdateien. Ein Client, ein Journal, eine Wahrheit.

Zwei Folgerungen daraus:

- **Selective Sync auf dem Host bestimmt, was der Gast sieht.** Ordner, die
  der Host-Client nicht herunterlädt, existieren unter `N:` schlicht nicht.
- **Ist der Gast an, ohne dass der Host-Client läuft, geht nichts in die
  Cloud.** Windows schreibt dann in einen unsynchronisierten Baum; der
  Abgleich holt das nach, sobald der Client wieder läuft.

> [!note] Restrisiko, bewusst getragen
> Über `accessmode='passthrough'` hat der Gast vollen Schreibzugriff auf den
> gesamten Baum, an den Linux-Dateirechten vorbei. Was in der VM zerstört
> wird, ist Minuten später auf allen Nextcloud-Clients zerstört. Auf einem
> privaten Arbeitsplatz mit vertrautem Gast ist das vertretbar — das
> Sicherheitsnetz ist die **serverseitige Versionierung und der Papierkorb**
> der Nextcloud-Instanz. Deren Aufbewahrungsfristen einmal nachsehen, bevor
> man sich darauf verlässt.

## 1 — Host: `virtiofsd` ins Image

Kein `rpm-ostree install`. Ins `kvm/win11`-Modul, mit Build-Guard — Exit 0 von
dnf beweist keine Installation:

```dockerfile
RUN dnf install -y virtiofsd \
    && rpm -q virtiofsd
```

Auf der laufenden Maschine prüfen, ob es über die Abhängigkeiten von
`qemu-kvm` ohnehin schon da ist:

```nu
rpm -q virtiofsd
/usr/libexec/virtiofsd --version
```

> [!tip] Version notieren
> Ab **virtiofsd 1.11** unterstützt libvirt an einer VM mit virtiofs-Device
> wieder `virsh save`, `managedsave` und Snapshots **mit** Speicherzustand.
> Darunter blockiert libvirt diese Operationen. Fedora 44 sollte deutlich
> darüber liegen — einmal ablesen und hier eintragen.

## 2 — Freigabepfad festlegen

Auf Atomic ist `/home` nur ein Symlink; ins XML gehört der **echte** Pfad
unter `/var/home`, sonst diskutiert man später mit virtiofsd über
Symlink-Auflösung.

```nu
let share = "/var/home/fritz/Nextcloud"

# Existenz, Eigentümer, Rechte, SELinux-Label
^ls -ldZ $share

# UID/GID merken — werden in Schritt 5 im Gast eingetragen
id -u
id -g

# Größenordnung, was der Gast zu sehen bekommt
bash -c "du -sh $share"
```

Erwartet: Eigentümer `fritz`, Label in Richtung `user_home_t`, UID/GID
typischerweise `1000`.

## 3 — Domain-XML erweitern

Die VM muss **ausgeschaltet** sein — das Memory-Backing lässt sich nicht im
Betrieb ändern.

```nu
let vm = "Windows 11 Pro"

virsh --connect qemu:///system shutdown $vm
virsh --connect qemu:///system list --all      # warten auf "ausgeschaltet"
```

Zwei Änderungen, beide zwingend:

```nu
# a) Shared Memory — ohne das startet die Domain mit virtiofs-Device nicht
virt-xml $vm --connect qemu:///system --edit --memorybacking access.mode=shared,source.type=memfd

# b) Das Filesystem-Device; "nextcloud" ist der Mount-Tag
virt-xml $vm --connect qemu:///system --add-device --filesystem $"driver.type=virtiofs,source.dir=($share),target.dir=nextcloud"
```

> [!note] `target.dir` ist kein Pfad
> Trotz des Namens beschreibt `<target dir="…"/>` **keinen** Ort im Gast,
> sondern einen frei wählbaren Mount-Tag, über den der Gast die Freigabe
> identifiziert. Der Laufwerksbuchstabe wird in Schritt 5 gesetzt.

Kontrolle — beide Blöcke müssen auftauchen:

```nu
virsh --connect qemu:///system dumpxml $vm
  | lines
  | find --regex 'memoryBacking|access mode|source type|<filesystem|virtiofs|source dir|target dir'
```

Erwartet: `<access mode='shared'/>` und `<source type='memfd'/>` im
`<memoryBacking>`, dazu ein `<filesystem type='mount'>` mit
`<driver type='virtiofs'/>`.

> [!caution] Plattformänderung an einer BitLocker-VM
> Neues PCI-Device plus geändertes Memory-Backing — Windows kann das
> bemerken. Recovery-Key bereitlegen, wie beim Restore in
> [[11-kvm-windows11-vm]].

> [!tip] Ein Wartungsfenster, drei Umstellungen
> Für Schritt 4 muss `virtio-win.iso` ohnehin eingelegt sein — dasselbe
> Fenster wie `viogpudo` (virtio-gpu) und `viostor` (SATA→virtio-blk) aus den
> offenen Punkten der Notiz 11.

## 4 — Windows-Gast: WinFsp und Treiber

virtiofs ist unter Windows ein **Usermode-Dateisystem auf WinFsp** — ohne
WinFsp kein Laufwerk.

1. **WinFsp** von winfsp.dev installieren, mindestens Feature „Core".
2. Von `virtio-win.iso` entweder `virtio-win-guest-tools.exe` ausführen
   (installiert Treiber *und* Dienst) oder manuell: Im Geräte-Manager
   erscheint das Gerät zunächst als **„Mass Storage Controller"** unter
   „Andere Geräte" → Treiber aktualisieren → Ordner `viofs\w11\amd64`.
3. Kontrolle: Geräte-Manager → Systemgeräte → **„VirtIO FS Device"**.
   Fehlt es, Gast einmal neu starten.

Dienst (nur nötig, wenn nicht schon durch die Guest-Tools angelegt),
Eingabeaufforderung als Administrator:

```bat
sc create VirtioFsSvc binPath="C:\Program Files\Virtio-Win\VioFS\virtiofs.exe" start=auto depend=VirtioFsDrv
sc start VirtioFsSvc
```

Ohne weitere Konfiguration nimmt virtiofs den ersten freien Buchstaben ab
`Z:`.

## 5 — Konfiguration im Gast: Eigentümer und Laufwerk

**Der Schritt, der über Erfolg oder Ärger entscheidet.** Der virtiofs-Dienst
kennt keine Linux-UIDs. Ohne Konfiguration landen aus der VM erzeugte Dateien
auf dem Host als `nobody:nobody` (65534) — der Nextcloud-Client kann sie dann
nicht mehr anfassen, und `fritz` auch nicht. Bei einer Freigabe des gesamten
Baums heißt das: irgendwann liegen `nobody`-Dateien quer über die ganze
Cloud verstreut.

Der Dienst liest seine Parameter aus `HKLM\Software\VirtIO-FS`. PowerShell als
Administrator:

```powershell
New-Item -Path "HKLM:\Software\VirtIO-FS" -Force

# Host-Eigentümer für neu erzeugte Dateien — UID:GID aus Schritt 2
New-ItemProperty -Path "HKLM:\Software\VirtIO-FS" -Name "Owner" `
  -Value "1000:1000" -PropertyType String -Force

# Fester Laufwerksbuchstabe statt "erster freier ab Z:"
New-ItemProperty -Path "HKLM:\Software\VirtIO-FS" -Name "MountPoint" `
  -Value "N:" -PropertyType String -Force

Restart-Service VirtioFsSvc
Get-PSDrive -PSProvider FileSystem
```

`N:` hält die Gewohnheit aus dem Samba-Setup aufrecht. Weitere Werte unter
demselben Schlüssel: `CaseInsensitive` (DWORD), `FileSystemName` (String),
`DebugFlags` (DWORD), `DebugLogFile` (String).

## 6 — Windows-Hygiene für einen Cloud-Baum

Weil hier nicht ein Austauschordner, sondern der **komplette** Cloud-Baum
unter `N:` hängt, wirkt sich alles, was Windows nebenbei anlegt oder anfasst,
auf sämtliche Geräte aus. Drei Maßnahmen, einmalig:

**Indizierung abschalten.** Die Windows-Suche würde den gesamten Baum
durchwandern und dabei Zugriffszeiten und Last erzeugen. Unter
*Indizierungsoptionen → Ändern* sicherstellen, dass `N:` nicht enthalten ist.

**Defender-Verhalten prüfen.** Echtzeit-Scans auf einem
Usermode-Dateisystem sind spürbar langsam. Eine Ausnahme für `N:` behebt das,
senkt aber den Schutz genau dort, wo die wertvollen Daten liegen — bewusste
Abwägung, keine Empfehlung nebenbei. Für einen privaten Arbeitsplatz mit
Host-seitiger Versionierung vertretbar.

**Nextcloud-Ignorierliste erweitern.** Im Client auf dem **Host** unter
*Einstellungen → Allgemein → Ignorierte Dateien bearbeiten* prüfen, ob
`Thumbs.db`, `desktop.ini`, `~$*` und `*.tmp` enthalten sind, und Fehlendes
ergänzen. Sonst wandert Windows-Beiwerk in die Cloud und auf alle anderen
Geräte. Welche Muster die Standardliste bereits mitbringt: vor Ort nachsehen,
nicht raten.

## 7 — Verifikation

Host, bei laufender VM:

```nu
# Läuft ein virtiofsd für diese Domain?
ps | where name =~ virtiofsd | select pid name

# QEMU-Log: vhost-user-fs-Device und Socket
sudo cat $"/var/log/libvirt/qemu/($vm).log" | lines | find --regex 'virtiofs|vhost-user-fs'
```

Der eigentliche Nachweis läuft über Kreuz — einmal in jede Richtung:

```nu
"Test vom Host" | save $"($share)/host.txt"
```

Im Gast muss `host.txt` unter `N:\` erscheinen. Dann im Gast eine Datei
anlegen und auf dem Host prüfen, **wem sie gehört**:

```nu
ls $share | where modified > ((date now) - 5min) | select name mode
^ls -l $share | lines | last 5
```

Erwartet: `fritz fritz` — **nicht** `nobody nobody`. Steht dort `nobody`,
greift der `Owner`-Registry-Wert aus Schritt 5 nicht.

Dritter Schritt, der die Topologie belegt: die im Gast erzeugte Datei muss
ohne weiteres Zutun in der Weboberfläche der Nextcloud auftauchen — dann hat
der Host-Client die Änderung über inotify mitbekommen und hochgeladen.

## 8 — Fallstricke

**Groß-/Kleinschreibung.** virtiofs ist case-sensitive wie das
Host-Dateisystem. Nextcloud kann `Rechnung.pdf` und `rechnung.pdf`
nebeneinander halten — Windows kommt damit nicht klar. `CaseInsensitive`
lindert das, löst es aber nicht: Eine der beiden Dateien bleibt aus Windows
heraus unerreichbar. Über einen ganzen Cloud-Baum ist die Wahrscheinlichkeit,
so ein Paar zu besitzen, nicht klein — einmal aktiv suchen:

```nu
ls **/* | get name | path basename | str downcase | uniq -d
```

**Punktdateien sind sichtbar.** `.nextcloudsync.log`, `._sync_*.db` und
Konsorten erscheinen im Explorer als normale Dateien. Nicht anfassen — die
Sync-Datenbank liegt im Wurzelverzeichnis und ist das Gedächtnis des
Clients. Ein Windows-Prozess, der sie sperrt, legt die Synchronisation lahm.

**Kein gleichzeitiges Bearbeiten.** Host-Anwendung und Gast-Anwendung
gleichzeitig auf derselben Datei erzeugt Konflikte — dieselbe Regel wie bei
zwei Menschen an einer Datei, nur dass beide Seiten hier dieselbe Person
sind.

**Große Erstsynchronisation.** Läuft der Host-Client gerade einen großen
Abgleich, sieht der Gast einen wandernden Zwischenzustand samt
`.~`-Fragmenten. Vor dem ersten Test abwarten, bis der Client „Alles
synchronisiert" meldet.

**SELinux.** Scheitert der Domain-Start mit `Permission denied` auf dem
Share: erst den AVC lesen, dann gezielt labeln — nicht vorbeugend relabeln.

```nu
sudo ausearch -m AVC -ts recent | lines | last 20
```

**Kein Hotplug.** Freigabe ändern oder nachrüsten heißt immer: VM
herunterfahren.

**Speicher.** `source.type=memfd` bedeutet, dass der komplette Gast-RAM als
gemeinsamer Speicher belegt wird — bei der Zuteilung einplanen.

## 9 — Rückbau

```nu
virsh --connect qemu:///system shutdown $vm
virt-xml $vm --connect qemu:///system --remove-device --filesystem all
```

Das `<memoryBacking>` bleibt dabei stehen; es stört nicht, kann aber per
`virsh edit` entfernt werden, wenn die Domain sauber sein soll.

## Anhang — Samba auf Atomic, falls doch nötig

Relevant, sobald **weitere** Geräte auf denselben Ordner sollen. Was sich
gegenüber dem CachyOS-Weg ([[00-Samba-Einrichtung]]) ändert:

| CachyOS | Fedora Atomic |
|---|---|
| `sudo pacman -S samba` | `RUN dnf install -y samba && rpm -q samba` im Containerfile, danach `bootc switch` + Neustart |
| `/etc/samba/smb.conf` von Hand | Datei via `COPY` ins Image, damit sie den `bootc upgrade` überlebt |
| UFW | `sudo firewall-cmd --zone=libvirt --add-service=samba --permanent` |
| — | SELinux: Freigaben unter `/var/home` brauchen `samba_enable_home_dirs` bzw. passendes Label |
| `systemctl enable smb nmb` | `systemctl enable smb` — `nmb` (NetBIOS) ist für SMB3 gegen einen einzelnen Gast entbehrlich |
| `hosts allow = 192.168.122.` | unverändert; `interfaces = lo virbr0` weiterhin sinnvoll |

Die Samba-Passwortdatenbank liegt unter `/var/lib/samba` und übersteht damit
`bootc switch` — `smbpasswd -a fritz` bleibt ein einmaliger Schritt pro Gerät
und muss nicht ins Image.

## Offene Punkte

- [ ] Kompletter Ablauf einmal live durchspielen, dann Notiz auf
      `verifiziert` heben
- [ ] `virtiofsd --version` ablesen und Save/Snapshot-Verhalten festhalten
- [ ] `virtiofsd` ins Containerfile des `kvm/win11`-Moduls aufnehmen
- [ ] `Owner`-Registry-Wert gegen die tatsächliche UID/GID prüfen
- [ ] Aufbewahrungsfristen von Papierkorb und Versionierung auf der
      Nextcloud-Instanz nachsehen — das ist das Sicherheitsnetz
- [ ] Namenskollisionen nach Groß-/Kleinschreibung einmal durchsuchen
- [ ] Standard-Ignorierliste des Nextcloud-Clients sichten und ergänzen
- [ ] Entscheiden, ob `CaseInsensitive` gesetzt wird
- [ ] README-Index um diese Notiz ergänzen (dort fehlen aktuell auch 09–11)

## Quellen

- virtio-win Knowledge Base — *Virtio-fs Quick start*: Host-XML, Gast-Setup,
  Registry-Parameter des `virtiofs`-Dienstes
- libvirt — *Sharing files with Virtiofs*: `memoryBacking`, Einschränkungen
  bei Migration, Save und Snapshots
