---
title: "Synology-Freigaben per SMB — Automount auf dem Host, S: im Windows-Gast"
teil_von: "[[README]]"
tags: [synology, smb, cifs, automount, systemd, windows11, kvm, libvirt, atomic, nushell]
zielgeraet: privater KI-Arbeitsplatz, x86_64 Fedora Atomic (bluefin)
created: 2026-08-12
status: draft
verifiziert_gegen: —
---

# 18 — Synology-Freigaben per SMB

Zweite Freigabe neben [[12-dateifreigabe-host-gast]], mit **bewusst
anderer Architektur**: Host und Gast greifen jeweils **direkt per SMB** auf
die NAS zu. Kein virtiofs, keine Verkettung.

- NAS: `192.168.178.39`
- Host: `.automount`-Units unter `/var/mnt/<freigabe>`
- Windows-Gast: Laufwerk `S:` per eigener SMB-Zuordnung

> [!warning] Status: Entwurf
> Die Freigabenamen sind live ermittelt (2026-08-12), der Automount-Aufbau
> ist noch nicht durchgespielt. Erst nach erfolgreichem Durchlauf inklusive
> Kaltstart auf `verifiziert` heben.

## Warum hier nicht virtiofs

Bei Nextcloud ist virtiofs alternativlos: Der Sync-Client läuft auf dem Host,
also **muss** der Gast auf dessen Verzeichnisbaum schauen. Hier liegt der
Fall anders — die Synology spricht nativ SMB, Windows spricht nativ SMB. Eine
Kette NAS → CIFS → virtiofs → WinFsp schiebt zwei zusätzliche Übersetzungen
zwischen zwei Endpunkte, die sich bereits verstehen.

| | Zwei direkte SMB-Verbindungen | virtiofs über Host-Mount |
|---|---|---|
| Schichten je Seite | eine | drei (CIFS, virtiofs, WinFsp) |
| Datei-Locking | native SMB-Semantik, auch für Office | über zwei Schichten, heikel |
| Ausfall der NAS | klare Netzfehler auf beiden Seiten | Gast sieht stillschweigend leeren Ordner |
| Zugangsdaten | auf **beiden** Seiten hinterlegt | nur auf dem Host |
| Abhängigkeit Gast ↔ Host | keine | Gast hängt an Host-Mount + virtiofsd |
| Gast braucht Netzzugang zur NAS | ja | nein |

Der Preis ist die doppelte Ablage der Zugangsdaten und ein Gast, der die NAS
im Netz sieht. Beides ist im heimischen LAN vertretbar; wäre die VM eine
Sandbox mit fremdem Code, wäre die Abwägung eine andere — dann steht die
virtiofs-Variante im Anhang.

Ein struktureller Vorteil, der leicht untergeht: Weil beide Seiten
gleichberechtigt am selben SMB-Server hängen, regelt **der Server** die
Sperren. Host und Gast können dieselbe Datei anfassen, ohne dass es zu den
Konflikten kommt, die eine durchgereichte Freigabe erzeugt.

## Zwei Zugriffsarten, bewusst getrennt

Auf dem Host gibt es zwei Wege zur NAS, und sie lösen verschiedene Aufgaben:

- **Stöbern → Nautilus/GVFS.** *Andere Orte → Mit Server verbinden →*
  `smb://192.168.178.39` zeigt alle Freigaben zum Durchklicken,
  Zugangsdaten landen im Schlüsselbund. Der Mount lebt in der Sitzung unter
  `/run/user/1000/gvfs/…`, ist für root und andere Prozesse unsichtbar und
  verschwindet beim Abmelden. Zum Nachsehen ideal, als Arbeitsgrundlage
  untauglich.
- **Arbeiten → systemd-Automount.** Nur für die Freigaben, die einen echten
  Pfad brauchen, den auch Skripte, Backups und `rsync` sehen.

Diese Notiz beschreibt den zweiten Weg. Der erste braucht keine
Dokumentation — er ist drei Klicks im Dateimanager.

> [!note] SMB kennt keinen „Server-Mount"
> Was der Windows-Explorer unter `\\192.168.178.39` zeigt, ist kein Mount des
> Servers, sondern der **Netzwerk-Browser**: Er fragt den Server nach seinen
> Freigaben und verbindet beim Anklicken genau eine davon. Ein Mount — unter
> Windows wie unter Linux — bezieht sich immer auf **eine** Freigabe.
> Deshalb braucht `mount -t cifs` zwingend einen Freigabenamen, `net view`
> und `smbclient -L` dagegen nicht.

## Warum Automount statt fester Mount

Ein fester Mount ist zur Boot-Zeit da oder gar nicht — bei einer NAS mit
schlafenden Platten oder wechselndem Netz heißt das Wartezeiten und
gescheiterte Units. Der Automount kommt dem Windows-Verhalten näher:

- Das Verzeichnis existiert **immer**, auch wenn die NAS aus ist.
- Die Verbindung entsteht beim **ersten Zugriff**.
- Nach Leerlauf (`TimeoutIdleSec`) löst sie sich wieder — die NAS darf
  einschlafen.
- Kein Boot-Hänger, keine „failed"-Unit im Statusbild.

> [!note] Der frühere Automount-Vorbehalt ist entfallen
> Solange die Freigabe per virtiofs an die VM gereicht werden sollte, war
> Automount gefährlich: `virtiofsd` öffnet das Exportverzeichnis einmal beim
> Domain-Start, löst dabei den Automount nicht aus und exportiert
> stillschweigend das leere Trigger-Verzeichnis. Da der Gast jetzt direkt per
> SMB zugreift, entfällt dieser Konflikt vollständig.

## Voraussetzungen auf der NAS

In DSM einmal prüfen — nicht annehmen:

- *Dateidienste → SMB*: aktiviert, **Maximales Protokoll SMB3**,
  **Minimales Protokoll SMB2** (SMB1 bleibt aus).
- *Gemeinsamer Ordner*: Zielordner existiert, verwendeter Benutzer hat
  Lese-/Schreibrecht.
- *Benutzer*: dediziertes Konto statt Admin — es landet gleich zweimal in
  Zugangsdaten-Speichern.

## 1 — Freigaben ermitteln

```nu
smbclient -L 192.168.178.39 -U nas-benutzer
rpm -q samba-client        # falls der Befehl fehlt
```

Alternativ aus dem Windows-Gast (`net view \\192.168.178.39`) oder in DSM
unter *Systemsteuerung → Gemeinsamer Ordner*.

Stand 2026-08-12 liefert der Server:

| Freigabe | Art | Für den Automount |
|---|---|---|
| `MetaRow` | Daten der MetaRow Software UG | **ja** |
| `_dms_` | Dokumentenverwaltung | nach Bedarf |
| `castor` | fremde Nutzerdaten | nein |
| `homes` | DSM-Benutzerverzeichnisse | nein |
| `web`, `web_packages` | DSM-Systemfreigaben | nein |

Faustregel: Was regelmäßig aus Skripten oder von Anwendungen gebraucht wird,
bekommt einen Automount. Alles andere über Nautilus.

## 2 — Paket im Containerfile

Kein `rpm-ostree install` — ins Image, mit `rpm -q` als Build-Guard:

```dockerfile
RUN dnf install -y cifs-utils \
    && rpm -q cifs-utils
```

Nachsehen, was schon da ist und ob nichts gelayert wurde:

```nu
rpm -q cifs-utils | complete | get exit_code | $in == 0
rpm-ostree status --json | from json | get deployments | where booted | get 0.packages
```

Die zweite Liste sollte leer sein — sonst hängt die Freigabe an einem Layer,
der beim nächsten `bootc switch` verschwindet.

> [!note] Was hier alles **nicht** nötig ist
> Kein `virtiofsd`, kein `setsebool virt_use_samba`, keine Änderung an der
> Domain-XML, kein WinFsp, keine Frage nach dem Benutzer, unter dem
> virtiofsd läuft. Die Kette fällt weg — und mit ihr ihre Fehlerquellen.

## 3 — Zugangsdaten

Nicht in die Unit, sondern in eine eigene Datei. `/etc` ist auf Atomic
beschreibbar und maschinenlokal — die Datei überlebt Image-Wechsel und
gehört bewusst **nicht** ins Containerfile.

```nu
sudo mkdir -p /etc/samba/credentials

"username=nas-benutzer\npassword=…\ndomain=WORKGROUP\n"
  | sudo tee /etc/samba/credentials/synology | ignore

sudo chmod 0600 /etc/samba/credentials/synology
sudo chown root:root /etc/samba/credentials/synology
sudo restorecon -v /etc/samba/credentials/synology
^ls -lZ /etc/samba/credentials/synology
```

## 4 — Erst manuell mounten, dann Units bauen

**Die Reihenfolge ist der eigentliche Trick.** Sie trennt „Name oder
Zugangsdaten falsch" von „Unit falsch gebaut" — zwei Fehlerquellen, die sich
sonst überlagern und beliebig lange Suche erzeugen.

Auf ostree ist `/mnt` ein Symlink nach `/var/mnt` — genau der richtige Ort:
maschinenlokal, überlebt `bootc upgrade`/`switch`.

```nu
^ls -ld /mnt                    # → Symlink auf /var/mnt

let server = "192.168.178.39"
let opts = "credentials=/etc/samba/credentials/synology,vers=3.1.1,uid=1000,gid=1000,file_mode=0664,dir_mode=0775,iocharset=utf8,nofail,_netdev,noserverino"

sudo mkdir -p /var/mnt/MetaRow
sudo mount -t cifs $"//($server)/MetaRow" /var/mnt/MetaRow -o $opts
ls /var/mnt/MetaRow
sudo umount /var/mnt/MetaRow
```

> [!caution] Fehlercodes von `mount.cifs` als Wegweiser
> `error(2) No such file or directory` → Freigabename falsch oder leer ·
> `error(13) Permission denied` → Name stimmt, Zugangsdaten nicht ·
> `error(22) Invalid argument` → Pfad unvollständig, meist eine leere
> Variable in `What=` · `unknown filesystem type 'cifs'` → `cifs-utils`
> fehlt im Image. Wer auf 13 landet, ist fast am Ziel.

## 5 — Units generieren

Bei mehreren Freigaben lohnt Generieren statt Tippen — und es verhindert die
Tippfehler, die den manuellen Weg teuer machen. Der ganze Block läuft in
**einem** Durchgang, damit die Variablen gesetzt sind, wenn interpoliert
wird:

```nu
let server = "192.168.178.39"
let opts = "credentials=/etc/samba/credentials/synology,vers=3.1.1,uid=1000,gid=1000,file_mode=0664,dir_mode=0775,iocharset=utf8,nofail,_netdev,noserverino"
let shares = ["MetaRow"]        # bei Bedarf erweitern, z. B. "_dms_"

for s in $shares {
  let punkt = $"/var/mnt/($s)"
  let unit  = (systemd-escape -p --suffix=mount $punkt | str trim)
  let auto  = ($unit | str replace ".mount" ".automount")

  sudo mkdir -p $punkt

  $"[Unit]
Description=Synology ($s)
After=network-online.target
Wants=network-online.target

[Mount]
What=//($server)/($s)
Where=($punkt)
Type=cifs
Options=($opts)
" | sudo tee $"/etc/systemd/system/($unit)" | ignore

  $"[Unit]
Description=Automount Synology ($s)

[Automount]
Where=($punkt)
TimeoutIdleSec=600

[Install]
WantedBy=multi-user.target
" | sudo tee $"/etc/systemd/system/($auto)" | ignore
}

# Kontrolle VOR dem Aktivieren: steht hinter dem Schrägstrich ein Name?
^grep -H "What=" /etc/systemd/system/var-mnt-*.mount
```

Erst wenn die `What=`-Zeilen vollständig sind, aktivieren:

```nu
sudo systemctl daemon-reload
for s in $shares { sudo systemctl enable --now (systemd-escape -p --suffix=automount $"/var/mnt/($s)" | str trim) }
```

> [!warning] Nur die `.automount` aktivieren, nie die `.mount`
> Ein `enable` der `.mount`-Unit erzeugt wieder einen festen Mount und hebelt
> den Automount aus. Die `.mount` existiert nur als Beschreibung dessen, was
> beim Zugriff passieren soll.

Der Unit-Name muss exakt zum Pfad passen, inklusive Groß-/Kleinschreibung —
`systemd-escape` erledigt das, deshalb wird er hier nicht getippt.

### Alte feste Unit entfernen

Falls aus einem früheren Anlauf noch `var-mnt-Synology.mount` existiert:

```nu
sudo systemctl disable --now var-mnt-Synology.mount
sudo rm -f /etc/systemd/system/var-mnt-Synology.mount
sudo rmdir /var/mnt/Synology
sudo systemctl daemon-reload
```

## 6 — Verifikation Host

```nu
# Automount-Trigger aktiv, Mount noch nicht
systemctl list-units "var-mnt-*"

# Zugriff löst den Mount aus
ls /var/mnt/MetaRow
^findmnt /var/mnt/MetaRow

# Schreibprobe
"probe host" | save /var/mnt/MetaRow/.probe-host
^ls -l /var/mnt/MetaRow/.probe-host
```

Der eigentliche Test des Automounts ist der **Leerlauf**: nach
`TimeoutIdleSec` (hier 10 Minuten) muss `findmnt` leer sein, das Verzeichnis
aber weiterhin existieren — und der nächste `ls` es wieder verbinden.

## 7 — Gast: Laufwerk S:

Windows bringt SMB mit — nichts zu installieren. Zwei Punkte sind anders als
im LAN gewohnt.

**IP statt Name.** Die VM hängt am `default`-NAT-Netz. Ausgehendes TCP/445
funktioniert dort, aber mDNS/NetBIOS-Erkennung überquert NAT nicht — die
Netzwerkumgebung bleibt leer. Also immer die IP.

```powershell
Test-NetConnection 192.168.178.39 -Port 445
```

`TcpTestSucceeded : True` ist Voraussetzung für alles Weitere. Dann die
dauerhafte Zuordnung; Zugangsdaten gehören in die
Anmeldeinformationsverwaltung, nicht in ein Skript:

```powershell
cmdkey /add:192.168.178.39 /user:nas-benutzer /pass
New-SmbMapping -LocalPath 'S:' -RemotePath '\\192.168.178.39\MetaRow' -Persistent $true
Get-SmbMapping
```

> [!warning] Laufwerksbuchstaben sind sitzungsgebunden
> `S:` existiert nur für den angemeldeten Benutzer. Dienste und geplante
> Aufgaben laufen in einer anderen Sitzung und sehen den Buchstaben **nicht**
> — dort immer den UNC-Pfad `\\192.168.178.39\MetaRow` verwenden. Das ist der
> häufigste Grund, warum „im Explorer geht's, im Programm nicht".

Scheitert `Test-NetConnection`, liegt es am Gastnetz:

```nu
virsh --connect qemu:///system net-info default
virsh --connect qemu:///system net-dumpxml default | lines | find --regex 'ip address|forward'
sudo firewall-cmd --list-all --zone=libvirt
```

Soll der Gast dauerhaft vollwertig im LAN stehen (eigene IP, Namensauflösung,
funktionierende Netzwerkumgebung), ist eine Bridge statt NAT der saubere Weg
— für SMB-auf-IP nicht nötig.

## 8 — Verifikation über Kreuz

Die auf dem Host erzeugte `.probe-host` muss im Gast unter `S:\` erscheinen.
Dann umgekehrt eine Datei im Gast anlegen und auf dem Host prüfen:

```nu
ls /var/mnt/MetaRow | where modified > ((date now) - 5min) | select name size modified
```

Beweis, dass beide wirklich auf die NAS schreiben: Beide Dateien müssen in
DSM (File Station) auftauchen.

Als Härtetest der Sperrsemantik — der eigentliche Grund für diese
Architektur: dieselbe Datei gleichzeitig auf Host und Gast öffnen. Erwartet
wird eine saubere Sperrmeldung der zweiten Seite, keine stille
Doppelbearbeitung.

## 9 — Fallstricke

**Zugangsdaten liegen doppelt.** Host
(`/etc/samba/credentials/synology`, `0600`) und Gast
(Anmeldeinformationsverwaltung). Bei Passwortwechsel auf der NAS sind
**beide** nachzuziehen — sonst scheitert eine Seite still und die andere
läuft weiter.

**Erster Zugriff nach Leerlauf dauert.** Automount plus schlafende Platten
heißt: der erste `ls` hängt einige Sekunden. Gewollter Handel gegen
Boot-Hänger und Dauerverbindung.

**Reconnect beim Anmelden im Gast.** Windows stellt persistente Zuordnungen
her, manchmal bevor das Gastnetz steht → rotes Kreuz an `S:`, das beim ersten
Zugriff verschwindet. Kosmetisch.

**Groß-/Kleinschreibung.** Der SMB-Server bestimmt das Verhalten;
Synology-Freigaben sind in der Regel case-insensitive. Damit entfällt das
Problem aus Notiz 12 — aber nachsehen statt annehmen.

**Kein Host-Gast-Kanal.** Diese Architektur koppelt beide Systeme bewusst
nicht. Dateien vom Host in den Gast ohne Umweg über die NAS gehen weiterhin
nur über die virtiofs-Freigabe `N:` aus Notiz 12.

## Anhang — virtiofs-Variante

Falls die Zugangsdaten den Gast doch nicht erreichen sollen oder die VM
keinen LAN-Kontakt haben darf: Host-Mount wie oben, dann weiterreichen statt
im Gast zu mappen. **Dann aber fester Mount statt Automount** — siehe den
Kasten oben.

```nu
let vm = "Windows 11 Pro"

# VM ausgeschaltet; <memoryBacking access.mode=shared> ist durch Notiz 12
# bereits gesetzt und darf NICHT erneut hinzugefügt werden
virt-xml $vm --connect qemu:///system --add-device \
  --filesystem "driver.type=virtiofs,source.dir=/var/mnt/MetaRow,target.dir=metarow"

sudo setsebool -P virt_use_samba 1

sudo mkdir -p /etc/systemd/system/virtqemud.service.d
r#'[Unit]
RequiresMountsFor=/var/mnt/MetaRow
'# | sudo tee /etc/systemd/system/virtqemud.service.d/10-metarow.conf | ignore
sudo systemctl daemon-reload
```

Im Gast braucht der zweite Tag eine eigene Dienstinstanz, da
`HKLM\Software\VirtIO-FS` nur **eine** Zuordnung trägt — Schalternamen von
`virtiofs.exe` vorher mit `--help` prüfen.

## Offene Punkte

- [ ] Entscheiden, ob `_dms_` ebenfalls einen Automount bekommt
- [ ] SMB-Protokollgrenzen in DSM prüfen
- [ ] Dedizierten NAS-Benutzer anlegen statt Admin-Konto
- [ ] `cifs-utils` ins Containerfile des `kvm/win11`-Moduls
- [ ] `TimeoutIdleSec` gegen das Spindown-Verhalten der NAS abstimmen
- [ ] Automount-Verhalten nach Kaltstart und nach Leerlauf messen
- [ ] Sperrverhalten bei gleichzeitigem Zugriff Host/Gast messen
- [ ] Nach Live-Durchlauf `status: verifiziert` und `verifiziert_am` setzen
- [ ] README-Index um diese Notiz ergänzen
