## Systemcontainer mit Alpine Linux

> **Zielgruppe:** CachyOS-Nutzer, die ressourcenschonende Systemcontainer für Schulungs- oder Entwicklungsumgebungen aufsetzen möchten.  
> **Stand:** April 2026 | Incus ≥ 6.x | CachyOS (Arch-basiert)

---

## 1. Hintergrund: LXD vs. Incus

**LXD** war ursprünglich ein Open-Source-Projekt von Canonical (Ubuntu-Hersteller). Im Jahr 2023 stellte Canonical das Projekt unter eine restriktivere Lizenz (AGPL + CLA), was bedeutete, dass Beitragende ein Contributor License Agreement unterzeichnen mussten – für viele Community-Mitglieder ein Ausschlusskriterium.

Daraufhin hat **Stéphane Graber**, der ursprüngliche Hauptentwickler von LXD, das Projekt als **Incus** unter der Apache-2.0-Lizenz weitergeführt. Das Ergebnis:

| | LXD | Incus |
|---|---|---|
| Lizenz | AGPL + Canonical CLA | Apache 2.0 |
| Träger | Canonical | Linux Containers (Community) |
| Arch/CachyOS | Aus offiziellen Repos entfernt | Offiziell in den Repos |
| API-Kompatibilität | — | Weitgehend identisch mit LXD |
| CLI | `lxc` | `incus` |

**Fazit für CachyOS-Nutzer:** Incus ist die richtige und einzige empfohlene Wahl. Die Bedienung ist nahezu identisch zu LXD – wer LXD-Anleitungen liest, ersetzt einfach `lxc` durch `incus`.

Ein weiterer Vorteil: Incus kann neben Systemcontainern (LXC) auch **QEMU-VMs** verwalten – du hast also ein einheitliches Tool, falls du später doch eine vollständige VM brauchst.

---

## 2. Warum Alpine Linux als Gast?

Alpine Linux ist eine minimalistisch gestaltete Distribution, die ursprünglich für Sicherheitsanwendungen entwickelt wurde und heute vor allem in Containern sehr verbreitet ist.

### Vergleich: Ressourcenverbrauch

| Distribution | Image-Größe | RAM-Basis (leer) | Init-System |
|---|---|---|---|
| Alpine 3.x | ~4 MB | ~8–15 MB | OpenRC |
| Debian 12 | ~80 MB | ~50–80 MB | systemd |
| Ubuntu 24.04 | ~120 MB | ~80–120 MB | systemd |

### Vorteile von Alpine in diesem Kontext

- **Minimal:** Nur das Nötigste ist installiert – weniger Angriffsfläche, weniger RAM-Verbrauch.
- **Schnell:** Container starten in unter einer Sekunde.
- **apk:** Der Paketmanager ist extrem schnell und hat umfangreiche Repos.
- **Ideal für Schulungen:** Kurze Boot-Zeit, klare Ausgaben, gut für SQL- und Python-Übungen geeignet.
- **Viele Container parallel:** Auf einem Notebook mit 8 GB RAM lassen sich locker 10–15 Alpine-Container gleichzeitig betreiben.

### Einschränkung

Alpine nutzt **musl libc** statt glibc. Manche Software (bestimmte Python-Binaries, proprietäre Tools) läuft deshalb nicht oder braucht Anpassungen. Für Standard-Schulungsszenarien (SQL, Python, Bash) ist das kein Problem.

---

## 3. Installation von Incus

### 3.1 Paketinstallation

```bash
sudo pacman -S incus incus-tools
```

- **`incus`** – das Hauptpaket mit Daemon und CLI
- **`incus-tools`** – Hilfswerkzeuge, u. a. für unprivilegierte Benutzer-Namespaces (wird für rootless-Container benötigt)

CachyOS bringt im Kernel alle nötigen Komponenten bereits mit:
- `cgroups v2` (Ressourcenkontrolle)
- User Namespaces (unprivilegierte Container)
- OverlayFS (effizienter Dateisystem-Layer für Container)
- Btrfs-Support

### 3.2 Dienste aktivieren

Das Arch/CachyOS-Paket liefert zwei systemd-Units:

```bash
sudo systemctl enable --now incus.service
```

- **`incus.service`** – der eigentliche Daemon; übernimmt in dieser Version auch den Autostart von Containern beim Booten
- **`incus-user.service`** – optionaler Dienst für unprivilegierte User-Instanzen (nur nötig, wenn mehrere Benutzer auf dem System eigene Incus-Umgebungen betreiben sollen)

> **Hinweis:** Ältere Anleitungen erwähnen einen separaten `incus-startup.service` – dieser existiert im aktuellen Arch-Paket nicht mehr. Der Container-Autostart ist direkt in `incus.service` integriert.

### 3.3 Benutzer zur Admin-Gruppe hinzufügen

Damit du Incus ohne `sudo` bedienen kannst:

```bash
sudo usermod -aG incus-admin $USER
```

> **Wichtig:** Die Gruppenänderung greift erst nach einem erneuten Einloggen. Entweder ausloggen und wieder einloggen, oder eine neue Shell öffnen:
> ```bash
> newgrp incus-admin
> ```

### 3.4 Installation prüfen

```bash
incus version
```

Erwartete Ausgabe (Versionen können abweichen):
```
Client version: 6.x.x
Server version: 6.x.x
```

---

## 4. Erstkonfiguration mit `incus admin init`

Dieser interaktive Assistent richtet Netzwerk, Storage und weitere Grundeinstellungen ein. Er muss nur einmal nach der Installation ausgeführt werden.

```bash
sudo incus admin init
```

### 4.1 Schritt-für-Schritt durch den Assistenten

**Clustered setup?**
```
Would you like to use LXD/Incus clustering? (yes/no) [default=no]: no
```
Für ein einzelnes Notebook: `no`.

---

**Storage backend:**
```
Do you want to configure a new storage pool? (yes/no) [default=yes]: yes
Name of the new storage pool [default=default]: default
Name of the storage backend to use (btrfs, dir, lvm, zfs) [default=btrfs]: btrfs
```

Wähle **`btrfs`** – CachyOS nutzt standardmäßig Btrfs, und Incus kann dann Container als Btrfs-Subvolumes anlegen. Das bedeutet:
- Snapshots sind Copy-on-Write (verbrauchen nur den Unterschied zum Original)
- Klonen von Containern geht in Millisekunden
- Kein separates Block-Device nötig

```
Would you like to create a new btrfs subvolume under /var/lib/incus? (yes/no) [default=yes]: yes
```

---

**Netzwerk-Bridge:**
```
Would you like to connect to a MAAS server? (yes/no) [default=no]: no
Would you like to create a new local network bridge? (yes/no) [default=yes]: yes
What should the new bridge be called? [default=incusbr0]: incusbr0
What IPv4 address should be used? [default=auto]: auto
What IPv6 address should be used? [default=auto]: auto
```

Incus erstellt eine virtuelle Netzwerkbrücke `incusbr0` mit:
- Eigenem IP-Bereich (z. B. `10.123.x.x/24`)
- NAT zum Host-Netzwerk (Container können ins Internet)
- Integriertem DHCP-Server (Container bekommen automatisch eine IP)

---

**Weitere Fragen:**
```
Would you like the Incus server to be available over the network? (yes/no) [default=no]: no
Would you like stale cached images to be updated automatically? (yes/no) [default=yes]: yes
Would you like a YAML "init" preseed to be printed? (yes/no) [default=no]: no
```

### 4.2 Konfiguration prüfen

```bash
incus network list
incus storage list
```

### 4.3 User-ID-Mapping-Tabellen einrichten
Incus braucht für unprivilegierte Container eingetragene Subuid/Subgid-Bereiche für den `root`-User (nicht deinen persönlichen User, sondern den Systembenutzer `root`).

Prüfen, was aktuell drin steht:

```bash
cat /etc/subuid
cat /etc/subgid
```

Wahrscheinlich leer oder kein Eintrag für `root`. Beheben:

```bash
sudo usermod --add-subuids 1000000-1065535 --add-subgids 1000000-1065535 root
```

Danach prüfen ob es gesetzt ist:

```bash
cat /etc/subuid
# Erwartete Ausgabe: root:1000000:65536
```

Dann Incus neu starten, damit er die neue Konfiguration einliest:

```bash
sudo systemctl restart incus.service
```

## 5. Erster Alpine-Container

### 5.1 Image herunterladen und Container starten

```bash
incus launch images:alpine/3.21 mein-alpine
```

Erklärung des Befehls:
- **`incus launch`** – Image herunterladen (falls nötig) und Container direkt starten
- **`images:`** – offizielle Image-Quelle (linuxcontainers.org)
- **`alpine/3.21`** – Alpine Linux Version 3.21 (aktuell stabil; `alpine/edge` für Testing)
- **`mein-alpine`** – beliebiger Name für den Container

Beim ersten Mal wird das Image (~4 MB) heruntergeladen und gecacht. Weitere Container aus demselben Image starten ohne Download.

### 5.2 Container-Status überprüfen

```bash
incus list
```

Beispielausgabe:
```
+-------------+---------+---------------------+------+-----------+-----------+
|    NAME     |  STATE  |        IPV4         | IPV6 |   TYPE    | SNAPSHOTS |
+-------------+---------+---------------------+------+-----------+-----------+
| mein-alpine | RUNNING | 10.123.45.67 (eth0) |      | CONTAINER |     0     |
+-------------+---------+---------------------+------+-----------+-----------+
```

### 5.3 Shell im Container öffnen

```bash
incus exec mein-alpine -- ash
```

Hinweis: Alpine nutzt `ash` (BusyBox-Shell), nicht `bash`. Nach der Installation von `bash` ist auch `bash` möglich:
```bash
apk add bash
```

Du befindest dich jetzt als `root` im Container. Das Alpine-Prompt sieht so aus:
```
/ #
```

Mit `exit` oder `Ctrl+D` verlässt du die Shell.

### 5.4 Container stoppen, starten, löschen

```bash
incus stop mein-alpine       # Graceful shutdown
incus start mein-alpine      # Starten
incus restart mein-alpine    # Neustart
incus delete mein-alpine     # Löschen (muss gestoppt sein)
incus delete mein-alpine --force  # Löschen auch wenn laufend
```

---

## 6. Arbeit im Container – Grundbefehle

### 6.1 Einzelbefehle ohne interaktive Shell

```bash
incus exec mein-alpine -- uname -a
incus exec mein-alpine -- cat /etc/alpine-release
incus exec mein-alpine -- ip addr
```

Das `--` trennt den `incus exec`-Befehl vom Befehl, der im Container ausgeführt werden soll.

### 6.2 Als anderer Benutzer ausführen

```bash
# Als Benutzer 'nobody' ausführen
incus exec mein-alpine --user 1000 -- ash
```

### 6.3 Umgebungsvariablen setzen

```bash
incus exec mein-alpine --env MEINE_VAR=wert -- ash
```

### 6.4 Containerdetails anzeigen

```bash
incus info mein-alpine
```

Zeigt: Status, IP-Adressen, laufende Prozesse, Ressourcenverbrauch, Snapshots.

### 6.5 Logs anzeigen

```bash
incus console mein-alpine --show-log
```

---

## 7. Pakete installieren in Alpine

Alpine nutzt **apk** als Paketmanager. Die Syntax ist kompakt und schnell.

### 7.1 Grundlegende apk-Befehle

```bash
# Paketliste aktualisieren
apk update

# Paket installieren
apk add paketname

# Mehrere Pakete auf einmal
apk add bash curl wget git nano

# Paket entfernen
apk del paketname

# Installierte Pakete auflisten
apk list --installed

# Nach Paket suchen
apk search python3
```

### 7.2 Nützliche Pakete für Schulungsumgebungen

#### Basis-Tools

```bash
apk add bash curl wget git nano vim sudo shadow
```

- `shadow` – wird für `useradd`, `passwd` etc. benötigt
- `sudo` – für sudo-Konfiguration

#### Python-Umgebung

```bash
apk add python3 py3-pip
pip3 install --break-system-packages pandas matplotlib
```

#### SQL / Datenbanken

```bash
# SQLite (bereits in Alpine enthalten, aber CLI-Tool separat)
apk add sqlite

# PostgreSQL Client
apk add postgresql-client

# MariaDB/MySQL Client
apk add mariadb-client
```

#### Entwicklungswerkzeuge

```bash
apk add build-base gcc musl-dev linux-headers
```

### 7.3 Alpine Repositories

Alpine hat mehrere Repository-Zweige. In `/etc/apk/repositories` stehen standardmäßig `main` und `community`. Für mehr Pakete `edge/testing` einbinden:

```bash
# Aktuelle Repos anzeigen
cat /etc/apk/repositories

# Community-Repo ist i.d.R. bereits aktiv
# Testing-Repo hinzufügen (Vorsicht: weniger stabil)
echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk update
```

---

## 8. Ressourcen begrenzen

Ressourcenlimits sind auf einem Notebook **unbedingt empfehlenswert**. Ohne Limits darf ein Container theoretisch alle verfügbaren Ressourcen beanspruchen.

### 8.1 CPU begrenzen

```bash
# Maximal 2 CPU-Kerne
incus config set mein-alpine limits.cpu 2

# CPU-Anteil (relativ zu anderen Containern, Standard: 1024)
incus config set mein-alpine limits.cpu.priority 50
```

### 8.2 RAM begrenzen

```bash
# Maximal 512 MB RAM
incus config set mein-alpine limits.memory 512MiB

# Swap deaktivieren (verhindert, dass Container auf langsamem Swap landet)
incus config set mein-alpine limits.memory.swap false

# Soft-Limit (Container kann kurzzeitig mehr nehmen)
incus config set mein-alpine limits.memory.enforce soft
```

### 8.3 Disk I/O begrenzen

```bash
# Maximale Lese-/Schreibrate auf dem Storage-Pool
incus config device set mein-alpine root limits.read 50MB
incus config device set mein-alpine root limits.write 30MB
```

### 8.4 Netzwerkbandbreite begrenzen

```bash
# Maximale Ein-/Ausgangsbandbreite
incus config device set mein-alpine eth0 limits.ingress 10Mbit
incus config device set mein-alpine eth0 limits.egress 10Mbit
```

### 8.5 Aktuelle Konfiguration prüfen

```bash
incus config show mein-alpine
```

### 8.6 Ressourcenverbrauch live anzeigen

```bash
incus top
```

Zeigt CPU, RAM und Netzwerk aller laufenden Container in Echtzeit.

---

## 9. Profile für Schulungsumgebungen

Profile sind gespeicherte Konfigurationsvorlagen, die beim Erstellen neuer Container angewendet werden. Damit lassen sich identische Umgebungen für alle Kursteilnehmer in Sekunden erstellen.

### 9.1 Profil anlegen

```bash
incus profile create kurs-python
```

### 9.2 Profil bearbeiten

```bash
incus profile edit kurs-python
```

Dies öffnet den Standard-Editor mit einer YAML-Struktur. Ein vollständiges Beispiel-Profil für einen Python-Kurs:

```yaml
name: kurs-python
description: "Profil für Python-Schulungscontainer"
config:
  limits.cpu: "2"
  limits.memory: 1GiB
  limits.memory.swap: "false"
  boot.autostart: "false"
  security.nesting: "false"
devices:
  eth0:
    name: eth0
    network: incusbr0
    type: nic
    limits.ingress: 20Mbit
    limits.egress: 20Mbit
  root:
    path: /
    pool: default
    size: 5GiB
    type: disk
```

### 9.3 Container mit Profil erstellen

```bash
# Standard-Profil + eigenes Profil kombinieren
incus launch images:alpine/3.21 teilnehmer-01 --profile default --profile kurs-python
incus launch images:alpine/3.21 teilnehmer-02 --profile default --profile kurs-python
incus launch images:alpine/3.21 teilnehmer-03 --profile default --profile kurs-python
```

Das `default`-Profil enthält die Grundkonfiguration (Netzwerk, Disk), das eigene Profil überschreibt und ergänzt.

### 9.4 Profile auflisten und prüfen

```bash
incus profile list
incus profile show kurs-python
```

### 9.5 Profil einem laufenden Container zuweisen

```bash
incus profile assign mein-alpine default,kurs-python
```

---

## 10. Snapshots und eigene Basisimages

### 10.1 Snapshot erstellen

Ein Snapshot friert den aktuellen Zustand des Containers ein. Dank Btrfs ist das ein Copy-on-Write-Vorgang – er dauert Millisekunden und verbraucht zunächst keinen zusätzlichen Speicher.

```bash
incus snapshot create mein-alpine vor-installation
incus snapshot create mein-alpine nach-python-setup
```

### 10.2 Snapshots auflisten

```bash
incus info mein-alpine
# oder nur Snapshots:
incus snapshot list mein-alpine
```

### 10.3 Snapshot wiederherstellen

```bash
incus snapshot restore mein-alpine vor-installation
```

Der Container wird auf den Zeitpunkt des Snapshots zurückgesetzt.

### 10.4 Aus Snapshot neuen Container erstellen

```bash
incus copy mein-alpine/vor-installation neuer-container
```

### 10.5 Eigenes Basisimage erstellen und publishen

Damit kannst du einen vorbereiteten Container (mit installierten Paketen, Konfiguration etc.) als wiederverwendbares Image speichern:

```bash
# Container vorbereiten und stoppen
incus stop mein-alpine

# Snapshot als Image veröffentlichen
incus publish mein-alpine/nach-python-setup --alias kurs-alpine-python

# Das Image ist jetzt lokal verfügbar
incus image list
```

Ab jetzt lassen sich Kurse-Container blitzschnell aus diesem Image starten:

```bash
incus launch kurs-alpine-python teilnehmer-04
```

### 10.6 Image exportieren und importieren

```bash
# Exportieren (z. B. für USB-Stick oder andere Maschine)
incus image export kurs-alpine-python /tmp/kurs-alpine-python.tar.gz

# Auf einem anderen Rechner importieren
incus image import /tmp/kurs-alpine-python.tar.gz --alias kurs-alpine-python
```

---

## 11. Dateien und Verzeichnisse austauschen

### 11.1 Einzelne Datei in Container kopieren

```bash
incus file push ./uebung.py mein-alpine/root/uebung.py
```

### 11.2 Datei aus Container holen

```bash
incus file pull mein-alpine/root/loesung.py ./loesung.py
```

### 11.3 Verzeichnis rekursiv kopieren

```bash
incus file push --recursive ./kursmaterial/ mein-alpine/root/kursmaterial/
incus file pull --recursive mein-alpine/root/ergebnisse/ ./ergebnisse/
```

### 11.4 Host-Verzeichnis dauerhaft einbinden (Shared Folder)

Dies ist die eleganteste Methode für Schulungen: Ein Verzeichnis auf dem Host ist direkt im Container sichtbar – Änderungen sind sofort auf beiden Seiten sichtbar.

```bash
incus config device add mein-alpine kursdaten disk \
  source=/home/fritz/kurse \
  path=/mnt/kurse
```

- **`source`** – Pfad auf dem Host
- **`path`** – Pfad im Container
- Der Container kann den Inhalt lesen und schreiben.

Einbindung wieder entfernen:

```bash
incus config device remove mein-alpine kursdaten
```

---

## 12. Netzwerk im Detail

### 12.1 Standardkonfiguration verstehen

Nach der Einrichtung hat Incus eine Bridge `incusbr0` erstellt:

```
Host-Netzwerk
      |
  [incusbr0]  ← virtuelle Bridge (z. B. 10.123.45.1)
      |
  Container (bekommen IPs aus dem Bridge-Subnetz via DHCP)
```

Container können ins Internet (NAT), können aber nicht direkt vom externen Netzwerk erreicht werden – gut für Schulungen.

### 12.2 Netzwerkinformationen anzeigen

```bash
# Bridge-Details
incus network info incusbr0

# IPs aller Container
incus list
```

### 12.3 Container untereinander kommunizieren

Container im selben Netzwerk können sich direkt über IP ansprechen. Alternativ über den Container-Namen (DNS ist integriert):

```bash
# Aus Container A nach Container B pingen
incus exec container-a -- ping container-b
```

### 12.4 Port vom Host zum Container weiterleiten

Wenn du z. B. einen Webserver im Container von außen erreichbar machen willst:

```bash
# Port 8080 auf dem Host → Port 80 im Container
incus config device add mein-alpine webport proxy \
  listen=tcp:0.0.0.0:8080 \
  connect=tcp:127.0.0.1:80
```

### 12.5 Container direkt ins LAN einbinden (macvlan)

Wenn ein Container eine eigene IP im Heimnetzwerk bekommen soll (fortgeschritten):

```bash
incus network create lan-bridge --type=macvlan parent=eth0
incus config device add mein-alpine eth0 nic network=lan-bridge
```

---

## 13. Autostart beim Systemstart

Wenn Container beim Booten des Notebooks automatisch gestartet werden sollen:

```bash
# Autostart aktivieren
incus config set mein-alpine boot.autostart true

# Start-Verzögerung (in Sekunden, verhindert gleichzeitigen Start vieler Container)
incus config set mein-alpine boot.autostart.delay 5

# Priorität (höhere Zahl = früher gestartet)
incus config set mein-alpine boot.autostart.priority 10
```

Autostart funktioniert, sobald `incus.service` läuft – kein separater Dienst nötig. Sicherstellen, dass er beim Booten aktiv ist:

```bash
sudo systemctl enable incus.service
```

---

## 14. Web-UI (optional)

Incus bringt eine eingebaute Web-Oberfläche mit, die du lokal aktivieren kannst – nützlich, um in Schulungen den Container-Zustand zu zeigen.

### 14.1 Aktivieren

```bash
sudo incus config set core.https_address :8443
```

### 14.2 Client-Zertifikat einrichten

```bash
# Zertifikat generieren
incus remote generate-certificate

# Fingerprint anzeigen (für die Web-UI-Authentifizierung)
incus config trust list
```

### 14.3 Zugriff

Browser öffnen: `https://localhost:8443`

Beim ersten Aufruf Zertifikat akzeptieren (selbst signiert). Die Web-UI erlaubt:
- Container erstellen, starten, stoppen
- Konsolen-Zugriff im Browser
- Ressourcenübersicht

---

## 15. Typische Fehler und Lösungen

### Fehler: `Error: Failed to connect to the LXD socket`

**Ursache:** Dienst nicht gestartet oder Benutzer nicht in der richtigen Gruppe.

```bash
sudo systemctl status incus.service
groups $USER  # muss 'incus-admin' enthalten
# Falls nicht: erneut einloggen nach 'sudo usermod -aG incus-admin $USER'
```

### Fehler: `Error: Permission denied`

**Ursache:** Benutzer ist noch nicht in `incus-admin`. Lösung: Ausloggen und neu einloggen, oder `newgrp incus-admin`.

### Fehler: Container startet nicht – `Failed to mount overlay`

**Ursache:** OverlayFS nicht aktiv oder Kernel-Modul fehlt.

```bash
sudo modprobe overlay
lsmod | grep overlay
```

### Fehler: Alpine-Container hat kein Internet

```bash
# Im Container prüfen
incus exec mein-alpine -- ping -c2 8.8.8.8

# DNS prüfen
incus exec mein-alpine -- cat /etc/resolv.conf

# Netzwerk-Bridge prüfen
incus network info incusbr0
```

Häufige Ursache: `nftables` oder `iptables` blockiert NAT. CachyOS nutzt nftables; sicherstellen, dass forwarding aktiv ist:

```bash
sudo sysctl -w net.ipv4.ip_forward=1
# Dauerhaft in /etc/sysctl.d/99-incus.conf:
echo "net.ipv4.ip_forward = 1" | sudo tee /etc/sysctl.d/99-incus.conf
```

### Fehler: `Error: No storage pool found`

**Ursache:** `incus admin init` wurde noch nicht ausgeführt.

```bash
sudo incus admin init
```

### Alpine: `apk: not found` oder leeres System

Das `images:alpine/3.21`-Image ist sehr minimal. Basis-Repos sind vorhanden, aber manche Tools fehlen bewusst.

```bash
incus exec mein-alpine -- apk update
incus exec mein-alpine -- apk add bash curl
```

---

## 16. Kurzreferenz aller Befehle

### Container-Lifecycle

| Befehl | Beschreibung |
|---|---|
| `incus launch images:alpine/3.21 NAME` | Container erstellen und starten |
| `incus start NAME` | Container starten |
| `incus stop NAME` | Container stoppen |
| `incus restart NAME` | Container neu starten |
| `incus delete NAME` | Container löschen (gestoppt) |
| `incus delete NAME --force` | Container löschen (auch laufend) |
| `incus rename NAME NEUER-NAME` | Container umbenennen |
| `incus copy QUELLE ZIEL` | Container klonen |
| `incus list` | Alle Container auflisten |
| `incus info NAME` | Detailinfo zu einem Container |

### Shell und Befehle

| Befehl | Beschreibung |
|---|---|
| `incus exec NAME -- ash` | Shell öffnen (Alpine) |
| `incus exec NAME -- bash` | Bash-Shell (wenn installiert) |
| `incus exec NAME -- BEFEHL` | Einzelnen Befehl ausführen |
| `incus console NAME` | Konsolenzugriff (inkl. Boot-Output) |
| `incus top` | Ressourcenverbrauch live |

### Konfiguration

| Befehl | Beschreibung |
|---|---|
| `incus config show NAME` | Konfiguration anzeigen |
| `incus config edit NAME` | Konfiguration im Editor bearbeiten |
| `incus config set NAME KEY WERT` | Einzelnen Wert setzen |
| `incus config get NAME KEY` | Einzelnen Wert lesen |
| `incus config unset NAME KEY` | Wert zurücksetzen |

### Snapshots

| Befehl | Beschreibung |
|---|---|
| `incus snapshot create NAME SNAP` | Snapshot erstellen |
| `incus snapshot list NAME` | Snapshots auflisten |
| `incus snapshot restore NAME SNAP` | Snapshot wiederherstellen |
| `incus snapshot delete NAME SNAP` | Snapshot löschen |

### Images

| Befehl | Beschreibung |
|---|---|
| `incus image list` | Lokale Images auflisten |
| `incus image list images:` | Verfügbare Remote-Images auflisten |
| `incus publish NAME/SNAP --alias ALIAS` | Container als Image speichern |
| `incus image export ALIAS PFAD` | Image exportieren |
| `incus image import PFAD --alias ALIAS` | Image importieren |
| `incus image delete ALIAS` | Image löschen |

### Profile

| Befehl | Beschreibung |
|---|---|
| `incus profile list` | Profile auflisten |
| `incus profile create NAME` | Profil erstellen |
| `incus profile edit NAME` | Profil bearbeiten |
| `incus profile show NAME` | Profil anzeigen |
| `incus profile assign CONTAINER P1,P2` | Profile einem Container zuweisen |

### Dateien und Netzwerk

| Befehl | Beschreibung |
|---|---|
| `incus file push QUELLE CONTAINER/PFAD` | Datei in Container kopieren |
| `incus file pull CONTAINER/PFAD ZIEL` | Datei aus Container holen |
| `incus network list` | Netzwerke auflisten |
| `incus network info BRIDGE` | Netzwerkdetails anzeigen |

---

## Anhang: Schnell-Setup für Schulung

Dieses Skript richtet in wenigen Minuten eine vollständige Alpine-Kursumgebung ein:

```bash
#!/usr/bin/env bash
# kurs-setup.sh – Incus-Schulungsumgebung einrichten

set -e

PROFIL="kurs-basis"
IMAGE="images:alpine/3.21"
ALIAS="kurs-alpine-basis"
ANZAHL=5  # Anzahl der Teilnehmer-Container

echo "=== Profil erstellen ==="
incus profile create $PROFIL 2>/dev/null || true
incus profile set $PROFIL limits.cpu 2
incus profile set $PROFIL limits.memory 512MiB
incus profile set $PROFIL limits.memory.swap false

echo "=== Basis-Container erstellen und konfigurieren ==="
incus launch $IMAGE kurs-base --profile default --profile $PROFIL
sleep 3

echo "=== Pakete installieren ==="
incus exec kurs-base -- apk update
incus exec kurs-base -- apk add bash python3 py3-pip sqlite git curl nano sudo shadow

echo "=== Snapshot und Image erstellen ==="
incus snapshot create kurs-base fertig
incus publish kurs-base/fertig --alias $ALIAS
incus delete kurs-base --force

echo "=== Teilnehmer-Container starten ==="
for i in $(seq 1 $ANZAHL); do
  NAME=$(printf "teilnehmer-%02d" $i)
  incus launch $ALIAS $NAME --profile default --profile $PROFIL
  echo "  → $NAME gestartet"
done

echo ""
echo "=== Fertig! Laufende Container: ==="
incus list
```

Skript ausführbar machen und starten:

```bash
chmod +x kurs-setup.sh
./kurs-setup.sh
```

---

*Leitfaden erstellt für BWSA – Bildung, Weiterbildung, Service | CachyOS / Arch Linux*
