---
title: OneDrive auf dem Host statt in der Windows-VM
teil_von: "[[README]]"
tags: [onedrive, microsoft365, entra, oauth2, abraunegg, rclone, cifs, samba, virtiofs, atomic, bootc, nushell]
zielgeraet: x86_64 Fedora Atomic (Yoga 920, Dozenten-PC)
created: 2026-07-30
status: draft
verifiziert_gegen: —
---

# 15 — OneDrive auf dem Host

Ergänzung zu [[11-kvm-windows11-vm]] und [[12-dateifreigabe-host-gast]].
Ziel: OneDrive-Daten auf dem Fedora-Atomic-Host nutzen, **ohne** dass eine
laufende Windows-VM Voraussetzung dafür ist.

> [!warning] Status: Entwurf
> Recherchestand 2026-07-30. Weder der Vorabtest noch die Installation sind
> live durchgespielt. Erst nach vollständigem Durchlauf auf `verifiziert`
> heben.

## Kernaussage

Der Reflex — „OneDrive läuft in Windows, also hole ich es per SMB aus der VM" —
löst das falsche Problem. Er macht eine laufende VM zur Voraussetzung für den
Dateizugriff und baut eine zweite Netzwerkabhängigkeit auf einer Maschine auf,
die bei [[12-dateifreigabe-host-gast]] gerade bewusst vermieden wurde.

Richtig ist dieselbe Topologie wie bei Nextcloud: **Der Host synchronisiert,
der Gast konsumiert.** Der Sync-Client läuft auf Fedora, der Baum liegt in
`/var/home/fritz/OneDrive`, und die Windows-VM bekommt ihn — falls überhaupt
nötig — per virtiofs als weiteres Laufwerk.

Das Hindernis ist nicht die Synchronisation, sondern die **Autorisierung**.
Sie entscheidet, ob dieser Weg gangbar ist, und sie lässt sich in zehn Minuten
prüfen, bevor eine Zeile ins Containerfile wandert.

## Wegevergleich

| | Host-Client (`onedrive`) | `rclone mount` | SMB aus dem Gast | MS-Client im Gast auf virtiofs |
|---|---|---|---|---|
| VM muss laufen | nein | nein | **ja** | ja |
| Offline-Zugriff | vollständig | nur Cache | nein | ja |
| Plattenbedarf | voller Baum | gering | keiner | voller Baum |
| Host-Aufwand auf Atomic | 1 Paket ins Image | 1 Paket ins Image | `cifs-utils` + Automount + Credentials | virtiofsd |
| Scheitert an | Tenant-Consent / MSA-Auth | dito | Windows-Passwort, Files-On-Demand | **scheidet aus** |

Die letzte Spalte ist keine Option: Der OneDrive-Client von Microsoft verlangt
ein lokales NTFS-Volume und verweigert Netz- und Fremddateisysteme. WinFsp,
über das virtiofs im Gast läuft, ist beides nicht. Die bei Nextcloud
funktionierende Umkehrung — Host hält den Baum, Gast schreibt hinein — ist mit
dem offiziellen Client also nicht herstellbar.

## 0 — Entscheidungsknoten: Autorisierung

Microsoft hat den OAuth2-Ablauf seit Ende 2025 mehrfach geändert. Was das
konkret bedeutet, hängt am Kontotyp:

**Persönliches Microsoft-Konto (MSA).** Browser-OAuth funktioniert, aber das
Zeitfenster zum Zurückkopieren der Redirect-URI ist knapp, und die
JavaScript-Weiterleitung muss dafür abgeschaltet werden. Wegen einer
geänderten Antwort von Microsoft ist **mindestens v2.5.10** zwingend. Der
Device-Code-Flow ist hier *keine* Alternative — den blockt Microsoft für nicht
freigegebene Anwendungen.

**Geschäfts-/Entra-Konto.** Device-Code-Flow ist der bequeme Weg, aber wenn im
Tenant „Benutzer können Apps zustimmen" abgeschaltet ist, braucht die App-ID
des Clients einen **Admin-Consent**. Das liegt außerhalb der eigenen
Kontrolle und ist das einzige echte K.o.-Kriterium.

> [!tip] Konfigurationsschlüssel nachsehen, nicht raten
> Der Device-Code-Flow wird nicht per Kommandozeilenschalter aktiviert,
> sondern über einen Eintrag in `config`. Den exakten Schlüsselnamen in
> `docs/usage.md` des Projekts ablesen und hier eintragen.

## 1 — Vorabtest im Wegwerf-Container

Der Punkt, an dem sich Atomic auszahlt: Die Autorisierung ist reines
Copy/Paste einer URL. Dafür braucht es kein installiertes System und keinen
Build.

```nu
mkdir /var/home/fritz/onedrive-test

podman run --rm -it -v /var/home/fritz/onedrive-test:/root/.config/onedrive:Z fedora:44 bash
```

Im Container:

```bash
dnf install -y onedrive
onedrive --version          # muss >= 2.5.10 sein
onedrive                    # gibt die Auth-URL aus
```

**Erfolgskriterium:** Nach dem Durchlauf liegt ein `refresh_token` in
`/var/home/fritz/onedrive-test/`. Dann ist der Weg frei.

```nu
ls /var/home/fritz/onedrive-test
```

Scheitert es hier, ist es an dieser Stelle gescheitert — nicht nach einem
Build und einem `bootc switch`. Dann greift [[#Anhang A — SMB aus dem Gast]].

> [!note] Paketversion prüfen
> Hinkt das Fedora-Paket hinter 2.5.10 her, scheitert schon der Test bei
> Personal-Konten. Fallback: Upstream-COPR oder Eigenbau im Containerfile.
> Version aus dem Testcontainer notieren:
> ```bash
> dnf info onedrive
> ```

## 2 — Paket ins Image

Kein `rpm-ostree install`. Ins Basismodul, mit Guard — ein Exit 0 von `dnf`
beweist keine Installation (siehe [[docs/01-erkenntnisse]]).

```dockerfile
RUN dnf install -y onedrive \
    && rpm -q onedrive
```

Nach `bootc switch` und Neustart auf dem Zielgerät:

```nu
rpm -q onedrive
onedrive --version
```

## 3 — Sync-Ordner und Konfiguration

Der Baum gehört ins Home, also unter `/var` — damit überlebt er jeden
`bootc upgrade`, und das SELinux-Label passt von allein. Die Upstream-Doku
beschreibt eigene SELinux-Schritte nur für Sync-Ordner **außerhalb** des Home;
die entfallen hier.

```nu
mkdir ~/.config/onedrive

'sync_dir = "~/OneDrive"
monitor_interval = "300"
skip_file = "~*|.~*|*.tmp|*.swp|*.partial"
skip_dotfiles = "false"
' | save ~/.config/onedrive/config

onedrive --display-config
```

Einfache Anführungszeichen, damit Nushell die inneren doppelten unverändert
durchreicht.

Welche Ordner überhaupt herunterkommen, steuert `sync_list` — das Gegenstück
zu Selective Sync:

```nu
'Dokumente
Projekte/Noctarow
' | save ~/.config/onedrive/sync_list
```

Erster Lauf **trocken**, immer:

```nu
onedrive --sync --dry-run --verbose
```

Erst wenn die Ausgabe plausibel ist — richtige Ordner, keine Löschabsichten —
folgt der echte Lauf:

```nu
onedrive --sync --verbose
```

## 4 — Dienst

```nu
systemctl --user enable --now onedrive.service
systemctl --user status onedrive.service
journalctl --user -u onedrive -f
```

> [!note] Kein `enable-linger`
> Auf einem Desktop startet der User-Dienst mit der Sitzung. Soll der Sync
> auch ohne Anmeldung laufen (Dozenten-PC im Dauerbetrieb), zusätzlich:
> ```nu
> sudo loginctl enable-linger fritz
> ```

## 5 — Windows-Client in der VM abbauen

**Zwingend, nicht optional.** Sobald der Host synchronisiert, darf in der VM
kein zweiter Client auf dasselbe Konto laufen — dieselbe Konfliktmaschine wie
zwei Nextcloud-Clients auf einem Verzeichnisbaum, nur mit Microsofts
Konfliktbenennung obendrauf.

In der VM: OneDrive → Einstellungen → Konto → **Verknüpfung dieses PCs
aufheben**. Pausieren reicht nicht. Anschließend prüfen, dass der lokale
Ordner `C:\Users\fritz\OneDrive` nicht mehr synchronisiert wird, und ihn nach
einer Kontrollperiode entfernen.

## 6 — Weitergabe in den Gast (optional)

Braucht Windows die Dateien weiterhin, ist das ab hier ein gelöstes Problem:
ein zweites virtiofs-Device auf `/var/home/fritz/OneDrive`, Mount-Tag
`onedrive`, Laufwerksbuchstabe `O:`. Ablauf identisch zu
[[12-dateifreigabe-host-gast]], inklusive `Owner`-Registry-Wert.

```nu
let vm = "Windows 11 Pro"

virsh --connect qemu:///system shutdown $vm

virt-xml $vm --connect qemu:///system --add-device --filesystem "driver.type=virtiofs,source.dir=/var/home/fritz/OneDrive,target.dir=onedrive"
```

`<memoryBacking>` steht durch Notiz 12 bereits; ein zweites Device braucht
keine weitere Änderung daran.

> [!caution] Ein Mountpoint pro Registry-Schlüssel
> `HKLM\Software\VirtIO-FS\MountPoint` ist ein einzelner Wert. Bei zwei
> Freigaben vor Ort klären, wie der Dienst mehrere Tags auf feste Buchstaben
> abbildet — sonst nimmt die zweite Freigabe den ersten freien Buchstaben ab
> `Z:`. Nicht raten, nachsehen.

## 7 — Verifikation

```nu
# Dienst läuft, keine Fehler im Log
systemctl --user is-active onedrive.service
journalctl --user -u onedrive --since "10 minutes ago" | lines | find --regex 'ERROR|WARN'

# Baum existiert und gehört dem richtigen Benutzer
^ls -ldZ ~/OneDrive
du -sh ~/OneDrive
```

Nachweis über Kreuz:

```nu
"Test vom Host" | save ~/OneDrive/host.txt
```

Die Datei muss ohne weiteres Zutun in der OneDrive-Weboberfläche erscheinen.
Umgekehrt: eine im Web angelegte Datei muss innerhalb des
`monitor_interval` lokal auftauchen.

## 8 — Fallstricke

**Kein Files On-Demand.** Der Client kennt keine Platzhalter — was in
`sync_list` steht, liegt vollständig auf der Platte. Vor dem ersten Lauf gegen
die tatsächliche Cloud-Größe rechnen; das Yoga hat keine großzügige SSD. Wer
On-Demand braucht, siehe [[#Anhang B — rclone als On-Demand-Variante]].

**Speicherbedarf beim Erstlauf.** Bei `--resync` oder einem vollständigen
Online-Scan rechnet der Client mit rund **1 GB Arbeitsspeicher je 100.000
Objekten**. Auf einem Gerät, auf dem parallel eine Windows-VM läuft, ist das
ein echter Faktor — Erstsynchronisation bei ausgeschalteter VM fahren.

**Versionsdisziplin über Geräte hinweg.** 2.5.x ist nicht rückwärtskompatibel
zu 2.4.x; beide Zweige dürfen nicht gleichzeitig gegen dasselbe Konto laufen,
auch nicht auf verschiedenen Maschinen. Mit einem gemeinsamen Image ist das
für Yoga und Dozenten-PC automatisch gegeben — aber jedes Fremdgerät
(Telefon, Windows-Rechner Dritter) fällt nicht darunter.

**`--resync` ist kein Reparaturbefehl.** Er verwirft die lokale Datenbank und
validiert alles neu. Erst die Ursache verstehen, dann anfassen.

**Token-Ablauf.** Das `refresh_token` liegt in `~/.config/onedrive/`, also im
Home und damit außerhalb des Image. Es ist maschinenlokal und muss auf jedem
Gerät einmal erzeugt werden — es gehört **nicht** ins Repository und nicht ins
Containerfile.

**Konflikt mit dem Nextcloud-Client.** Beide Clients laufen als User-Dienste
auf demselben Rechner, aber auf verschiedenen Bäumen. Das ist unkritisch —
solange niemand auf die Idee kommt, `~/OneDrive` in die Nextcloud zu legen.

## 9 — Rückbau

```nu
systemctl --user disable --now onedrive.service

# Nur die Verknüpfung lösen, Daten behalten
rm ~/.config/onedrive/refresh_token

# Vollständig
rm -rf ~/.config/onedrive
rm -rf ~/.local/share/onedrive
```

Der Ordner `~/OneDrive` bleibt in allen Fällen stehen und muss von Hand
entfernt werden.

## Offene Punkte

- [ ] Vorabtest im Container durchführen und Ergebnis (Kontotyp, Auth-Weg,
      Paketversion) hier eintragen
- [ ] Konfigurationsschlüssel für den Device-Code-Flow aus `docs/usage.md`
      übernehmen
- [ ] `onedrive` ins Containerfile aufnehmen, Modul festlegen
- [ ] Cloud-Größe gegen freien Plattenplatz auf dem Yoga prüfen
- [ ] `sync_list` inhaltlich festlegen
- [ ] Windows-Client in der VM abmelden, lokalen Ordner nach Kontrollperiode
      entfernen
- [ ] Entscheiden, ob der Baum überhaupt in den Gast muss — wenn ja, Verhalten
      des virtiofs-Dienstes bei zwei Freigaben klären
- [ ] Nach erfolgreichem Durchlauf Notiz auf `verifiziert` heben und
      [[12-dateifreigabe-host-gast]] querverweisen
- [ ] README-Index ergänzen

## Quellen

- abraunegg/onedrive — Projekt-README und `docs/usage.md`: Auth-Verfahren,
  Konfigurationsschlüssel, Speicherbedarf
- abraunegg/onedrive Discussions #3558, #3617, #3680: geänderter
  OAuth2-Ablauf, Redirect-URI, MSA-Blockade des Device-Code-Flows
- abraunegg/onedrive Discussion #3561: Entra-Consent-Einstellungen im Tenant
- Release Notes v2.5.10 / v2.5.11

---

## Anhang A — SMB aus dem Gast

Relevant, wenn der Vorabtest aus Schritt 1 scheitert — typischerweise weil der
Tenant den Consent verweigert. Dann bleibt nur der Weg über die laufende VM.
Vorlage war der CachyOS-Leitfaden; was sich auf Atomic ändert:

| CachyOS | Fedora Atomic |
|---|---|
| `pacman -S cifs-utils` | `RUN dnf install -y cifs-utils && rpm -q cifs-utils` |
| `mkdir /mnt/OneDrive` | `/var/mnt/onedrive` — `/` ist read-only |
| `/root/.smbcredentials` | `/etc/cifs/onedrive.cred` (`/root` → `/var/roothome`) |
| harter fstab-Eintrag | Automount, weil die VM meistens aus ist |
| „IP notieren" | statischer DHCP-Lease in der libvirt-`default`-Domain |

**Stabile Adresse.** Statt notierter IP ein fester Lease:

```nu
let vm = "Windows 11 Pro"

virsh --connect qemu:///system domiflist $vm

sudo virsh net-update default add ip-dhcp-host "<host mac='52:54:00:AA:BB:CC' name='win11' ip='192.168.122.54'/>" --live --config

virsh --connect qemu:///system net-dumpxml default | lines | find dhcp-host
```

**Credentials.**

```nu
sudo mkdir -p /etc/cifs

"username=fritz
password=DEIN_PASSWORT
" | sudo tee /etc/cifs/onedrive.cred | ignore

sudo chmod 600 /etc/cifs/onedrive.cred
sudo chown root:root /etc/cifs/onedrive.cred
```

> [!warning] Microsoft-Konto als SMB-Passwort
> Meldet sich Windows per Microsoft-Konto an, ist das Freigabe-Passwort das
> Konto-Passwort — mit MFA und Rotation im Rücken. Sauberer ist ein lokales
> Windows-Zweitkonto nur für die Freigabe, dem der OneDrive-Ordner per
> NTFS-ACL zugewiesen wird.

**Testmount.** Nushell kennt keine Backslash-Fortsetzung, also die Optionen
als Variable:

```nu
let ip = "192.168.122.54"
let opts = "credentials=/etc/cifs/onedrive.cred,uid=1000,gid=1000,file_mode=0664,dir_mode=0775,noperm,vers=3.1.1,seal,iocharset=utf8,mfsymlinks,nobrl,noserverino,actimeo=5"

sudo mkdir -p /var/mnt/onedrive
sudo mount -t cifs $"//($ip)/OneDrive" /var/mnt/onedrive -o $opts

ls /var/mnt/onedrive
```

Abweichungen zum CachyOS-Original, jeweils mit Grund:

- `vers=3.1.1,seal` — SMB3 mit Verschlüsselung, auf virbr0 fast kostenlos
- `nobrl` — ohne das scheitert jede SQLite-Datei auf dem Share
- `mfsymlinks` — Symlinks als Minshall-French-Dateien statt Fehler
- `actimeo=5` statt `cache=none` — letzteres ist quälend langsam, bei einem
  einzigen Client unnötig
- `file_mode=0664` statt `0777` — `noperm` schaltet die Prüfung ohnehin ab

**Automount statt fstab-Zwang.** Der eigentliche Unterschied: Ein harter
Eintrag hängt bei ausgeschalteter VM im Boot.

```nu
let ip = "192.168.122.54"
let opts = "credentials=/etc/cifs/onedrive.cred,uid=1000,gid=1000,file_mode=0664,dir_mode=0775,noperm,vers=3.1.1,seal,iocharset=utf8,mfsymlinks,nobrl,noserverino,actimeo=5,_netdev,noauto,x-systemd.automount,x-systemd.idle-timeout=120,x-systemd.mount-timeout=10"

if (open /etc/fstab | str contains "/var/mnt/onedrive") {
    print "Eintrag existiert bereits"
} else {
    $"//($ip)/OneDrive /var/mnt/onedrive cifs ($opts) 0 0\n" | sudo tee -a /etc/fstab | ignore
}

sudo systemctl daemon-reload
sudo systemctl start var-mnt-onedrive.automount
```

Reihenfolge beachten: erst `daemon-reload`, dann mounten — der CachyOS-Text
hat das vertauscht.

Flatpaks sehen den Pfad nicht von allein:

```nu
flatpak override --user --filesystem=/var/mnt/onedrive
```

> [!warning] Files On-Demand
> Standardmäßig liegen OneDrive-Dateien in Windows als Platzhalter
> (Reparse Points) vor. Über SMB gelesen führt das zu langen Wartezeiten oder
> Fehlern. Für den freigegebenen Baum in Windows *„Immer auf diesem Gerät
> behalten"* setzen — und den Platzbedarf in der VM einplanen.

## Anhang B — rclone als On-Demand-Variante

Wenn der Auth-Weg funktioniert, der Plattenplatz aber nicht reicht:
`rclone mount` mit VFS-Cache stellt OneDrive als Dateisystem bereit, ohne den
Baum vollständig herunterzuladen. Preis: Latenz bei jedem Erstzugriff, kein
echter Offline-Betrieb, und die Konflikterkennung ist schwächer als bei einem
richtigen Sync-Client.

Sinnvoll für **Archivbestände**, nicht für Arbeitsdaten. Als Kombination
denkbar: `sync_list` hält den Arbeitsbereich lokal, rclone hängt den Rest
bei Bedarf ein. Ob das den Aufwand zweier Werkzeuge rechtfertigt, erst
entscheiden, wenn der Plattenplatz tatsächlich knapp wird.
