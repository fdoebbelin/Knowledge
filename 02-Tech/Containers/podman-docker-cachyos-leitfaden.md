# Podman und Docker auf CachyOS – Detaillierter Leitfaden
## Anwendungscontainer für Entwicklung und Schulung

> **Zielgruppe:** CachyOS-Nutzer, die mit Anwendungscontainern arbeiten möchten – als Ergänzung zu Systemcontainern (Incus/LXC).
> **Stand:** April 2026 | Podman ≥ 5.x | Docker ≥ 27.x | CachyOS (Arch-basiert)

---

## Inhaltsverzeichnis

1. [Anwendungs- vs. Systemcontainer](#1-anwendungs--vs-systemcontainer)
2. [Docker und Podman im Vergleich](#2-docker-und-podman-im-vergleich)
3. [Empfehlung für CachyOS](#3-empfehlung-für-cachyos)
4. [Installation von Podman auf CachyOS](#4-installation-von-podman-auf-cachyos)
5. [Erste Schritte mit Podman](#5-erste-schritte-mit-podman)
6. [Container-Lifecycle im Alltag](#6-container-lifecycle-im-alltag)
7. [Volumes und persistente Daten](#7-volumes-und-persistente-daten)
8. [Netzwerk und Port-Forwarding](#8-netzwerk-und-port-forwarding)
9. [Eigene Images bauen mit Containerfile](#9-eigene-images-bauen-mit-containerfile)
10. [Multi-Container mit Compose](#10-multi-container-mit-compose)
11. [Quadlets – die systemd-Integration](#11-quadlets--die-systemd-integration)
12. [Pods – mehrere Container als Einheit](#12-pods--mehrere-container-als-einheit)
13. [Rootless-Container im Detail](#13-rootless-container-im-detail)
14. [Distrobox auf Podman-Basis](#14-distrobox-auf-podman-basis)
15. [Docker auf CachyOS (falls doch nötig)](#15-docker-auf-cachyos-falls-doch-nötig)
16. [Typische Fehler und Lösungen](#16-typische-fehler-und-lösungen)
17. [Befehlsreferenz Docker ↔ Podman](#17-befehlsreferenz-docker--podman)

---

## 1. Anwendungs- vs. Systemcontainer

Bevor wir in die Werkzeuge einsteigen, ist das konzeptionelle Verständnis entscheidend. Container sind nicht gleich Container – es gibt zwei grundlegend verschiedene Philosophien.

### Systemcontainer (Incus/LXC)

Ein Systemcontainer verhält sich wie eine vollwertige Linux-Maschine im Kleinen:

- Eigenes Init-System (systemd, OpenRC)
- Mehrere Prozesse parallel
- Vollständiges Userland (von Shell bis Cron-Daemon)
- Lebt unabhängig vom Host – Container wird gestartet und läuft
- Anmeldung wie auf einem Server

**Analogie:** Ein Systemcontainer ist eine "Mini-Distribution".

### Anwendungscontainer (Docker/Podman)

Ein Anwendungscontainer hat eine fundamental andere Logik:

- **Ein Container = ein Prozess** (im Idealfall)
- Kein Init-System, kein Cron, kein SSH-Daemon
- Container existiert nur, solange dieser Prozess läuft
- Stirbt der Hauptprozess → Container ist beendet
- Konfiguration über Umgebungsvariablen, Volumes, Netzwerk-Mappings

**Analogie:** Ein Anwendungscontainer ist eine "verpackte Anwendung mit allen Abhängigkeiten".

### Wann was?

| Aufgabe | Geeignet |
|---|---|
| "Ich brauche eine PostgreSQL-Instanz für eine Übung" | Anwendungscontainer (Podman) |
| "Ich brauche eine Linux-Umgebung zum Experimentieren" | Systemcontainer (Incus) |
| "Ich will eine Web-App mit Datenbank und Cache testen" | Anwendungscontainer + Compose |
| "Ich will Teilnehmern Shell-Zugang zu Übungsmaschinen geben" | Systemcontainer (Incus) |
| "Ich will eine isolierte Build-Umgebung" | Beides möglich, oft Anwendungscontainer |
| "Ich will Ubuntu-Userland neben CachyOS" | Distrobox (auf Podman) |

In der Praxis hat ein Linux-Profi meist **beides** auf dem System.

---

## 2. Docker und Podman im Vergleich

Beide verfolgen die Anwendungscontainer-Philosophie und sind im CLI weitgehend kompatibel. Die Architektur dahinter unterscheidet sich grundlegend.

### Docker – die Client-Server-Architektur

```
┌───────────────────────────────────────┐
│  docker (CLI)                         │
└──────────────┬────────────────────────┘
               │ REST-API
               ▼
┌───────────────────────────────────────┐
│  dockerd (Daemon, läuft als root)     │
│   ├── containerd                      │
│   └── runc                            │
└──────────────┬────────────────────────┘
               ▼
       Container-Prozesse
```

- **`dockerd`** läuft permanent als root-Daemon im Hintergrund
- **`docker`** als CLI spricht über eine REST-API mit dem Daemon
- Der Daemon verwaltet Images, Container, Netzwerke
- Wer in der `docker`-Gruppe ist, hat de facto Root-Rechte (kann beliebige Verzeichnisse mounten)

**Folgen:**
- Daemon-Absturz → alle Container weg
- Single Point of Failure
- Sicherheitsmodell veraltet (root-by-default)
- Rootless-Modus existiert, ist aber nachträglich angeflanscht
- RAM-Verbrauch im Idle: ~100 MB

### Podman – Daemonless-Architektur

```
┌───────────────────────────────────────┐
│  podman (CLI)                         │
│   ├── fork()                          │
│   └── runc / crun                     │
└──────────────┬────────────────────────┘
               ▼
       Container-Prozesse
   (als Kindprozesse der Shell)
```

- **Kein Daemon** – `podman run` startet Container direkt als Kindprozess
- Container laufen unter dem aufrufenden User (rootless by default)
- Nutzt User-Namespaces für Isolation ohne Root-Rechte
- Wenn Persistenz gewünscht: systemd übernimmt (Quadlets)

**Folgen:**
- Kein Single Point of Failure
- Sicherheitsmodell modern (rootless-first)
- Saubere systemd-Integration
- RAM-Verbrauch im Idle: 0 MB

### Direkter Vergleich

| Aspekt | Docker | Podman |
|---|---|---|
| **Architektur** | Client-Server (Daemon) | Daemonless (fork/exec) |
| **Standardmodus** | Root | Rootless |
| **Sicherheit** | docker-Gruppe = Root | User-Namespaces, kein Root nötig |
| **Daemon-Absturz** | Alle Container weg | Nicht möglich (kein Daemon) |
| **systemd-Integration** | Manuell | Nativ (Quadlets) |
| **Compose** | `docker compose` (offiziell) | `podman-compose` / Quadlets |
| **Pods (K8s-Stil)** | Nein | Ja |
| **CLI-Kompatibilität** | — | `alias docker=podman` |
| **Image-Format** | OCI | OCI (identisch) |
| **Registry-Support** | Docker Hub + andere | Docker Hub + andere |
| **Lizenz** | Apache 2.0 | Apache 2.0 |
| **RAM-Footprint Idle** | ~100 MB | 0 MB |
| **Performance** | Identisch (gleiche Runtime) | Identisch |

### Was beide gemeinsam haben

- **OCI-konformes Image-Format** (Open Container Initiative)
- **Dieselben Runtimes** (`runc`, `crun`)
- **Dieselben Kernel-Features** (cgroups, Namespaces, seccomp)
- **Dieselben Registries** (Docker Hub, quay.io, ghcr.io)
- **Dasselbe Containerfile-/Dockerfile-Format**

Ein Image, das mit Docker gebaut wurde, läuft 1:1 unter Podman und umgekehrt.

---

## 3. Empfehlung für CachyOS

Für CachyOS ist **Podman die klar bessere Wahl**. Die Gründe im Detail:

### 3.1 Linux-Hygiene

CachyOS ist ein modernes, systemd-basiertes Arch-Derivat. Podman fügt sich nahtlos ein:
- Container werden zu systemd-User-Services
- Logs landen im Journal (`journalctl --user`)
- Quadlets funktionieren wie alle anderen systemd-Units

Docker bleibt mit seinem Daemon ein Fremdkörper, der parallel zu systemd ein eigenes Universum betreibt.

### 3.2 Ressourcen

Auf einem Notebook mit wenig RAM zählt jeder Megabyte. Der Docker-Daemon belegt im Idle dauerhaft RAM, auch wenn kein Container läuft. Podman belegt nichts – es startet nur, wenn du es aufrufst.

### 3.3 Sicherheit ohne Aufwand

Rootless-Container sind bei Podman der Default, nicht ein nachträglich aktivierter Modus. Für Schulungsumgebungen, in denen Teilnehmer experimentieren, ist das Gold wert.

### 3.4 Distrobox-Basis

Das beliebte Tool **Distrobox** (für nahtlose Multi-Distribution-Workflows) baut standardmäßig auf Podman auf. Wer Podman hat, hat Distrobox quasi gratis.

### 3.5 CachyOS-Repo-Pflege

Beide Pakete sind in den offiziellen Repos, aber Podman wird auf Arch-basierten Systemen reibungsloser unterstützt. Docker erfordert gelegentlich manuelle Eingriffe (Daemon-Konfiguration, Storage-Driver bei Btrfs).

### 3.6 Wann doch Docker?

Es gibt legitime Gründe für Docker:
- **Kompatibilität mit Schulungsmaterial:** Wenn Kursteilnehmer Docker explizit lernen sollen
- **Kunden-Setup 1:1:** Wenn ein bestehendes `docker-compose.yml` ohne Anpassung laufen muss
- **Spezifische Tools:** Einige Tools (Portainer, manche Compose-Plugins) sind primär für Docker entwickelt

> **Pragmatisch:** Du kannst Podman und Docker parallel installieren. Sie kollidieren nicht, solange du nicht denselben Container-Namen vergibst.

Im Folgenden konzentrieren wir uns auf **Podman**. Ein eigenes Kapitel beschäftigt sich am Ende mit Docker für die Fälle, in denen es doch nötig wird.

---

## 4. Installation von Podman auf CachyOS

### 4.1 Paketinstallation

```bash
sudo pacman -S podman podman-compose podman-docker
```

- **`podman`** – das Hauptpaket mit CLI und Werkzeugen
- **`podman-compose`** – Compose-Implementation für Podman (Python-basiert)
- **`podman-docker`** – stellt einen `docker`-Befehl bereit, der auf Podman umlenkt (transparenter Drop-in-Replacement)

Empfohlen für rootless-Container:

```bash
sudo pacman -S fuse-overlayfs slirp4netns
```

- **`fuse-overlayfs`** – OverlayFS-Implementation, die ohne Root-Rechte funktioniert
- **`slirp4netns`** – Netzwerk-Stack für rootless-Container

### 4.2 Subuid und Subgid einrichten

Rootless Podman braucht **User-Namespace-Mapping**: Eine Sammlung von UIDs/GIDs, die deinem User-Account zugeordnet werden, damit Prozesse im Container "andere" User sehen, ohne dass es echte Systembenutzer sind.

CachyOS richtet das oft schon automatisch ein. Prüfen:

```bash
cat /etc/subuid
cat /etc/subgid
```

Erwartete Ausgabe (mit deinem Username):
```
fritz:100000:65536
```

Falls der Eintrag fehlt:

```bash
sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $USER
```

Nach Änderungen einmal Podman-Migration anstoßen:

```bash
podman system migrate
```

### 4.3 Installation prüfen

```bash
podman version
podman info
```

`podman info` zeigt unter anderem:
- Storage-Treiber (sollte `overlay` mit `fuse-overlayfs` als Mount sein bei rootless)
- Cgroup-Manager (idealerweise `systemd`)
- Network-Backend (`netavark` ab Podman 4.x, vorher `cni`)

### 4.4 Test mit "Hello World"

```bash
podman run --rm hello-world
```

Erwartete Ausgabe enthält "Hello from Docker!" – das Image stammt von Docker Hub, läuft aber unverändert.

---

## 5. Erste Schritte mit Podman

### 5.1 Ein Image suchen und herunterladen

```bash
# Suchen
podman search alpine

# Herunterladen
podman pull alpine:3.21

# Lokale Images anzeigen
podman images
```

> **Hinweis:** Podman fragt beim ersten Pull, welche Registry verwendet werden soll, wenn der Image-Name kein Präfix hat. Setze für Komfort einen Default in `/etc/containers/registries.conf` oder gib immer die volle URL an: `docker.io/library/alpine:3.21`.

### 5.2 Container starten – die Grundbefehle

```bash
# Einmalig ausführen, danach löschen
podman run --rm alpine:3.21 echo "Hallo aus Alpine"

# Interaktiv mit Shell
podman run --rm -it alpine:3.21 ash

# Im Hintergrund ('detached')
podman run -d --name webserver -p 8080:80 nginx:alpine
```

Erklärung der Flags:
- **`--rm`** – Container nach Beenden automatisch löschen
- **`-i`** – Interaktiv (STDIN offen halten)
- **`-t`** – Pseudo-TTY zuweisen (für Shell)
- **`-d`** – Detached, Container läuft im Hintergrund
- **`--name`** – Eigener Name (statt zufällig generiertem)
- **`-p HOST:CONTAINER`** – Port vom Host auf Container mappen
- **`-v HOST:CONTAINER`** – Volume mounten

### 5.3 Container auflisten

```bash
podman ps          # Nur laufende
podman ps -a       # Alle, auch beendete
```

### 5.4 In einen laufenden Container hineingehen

```bash
podman exec -it webserver ash
```

### 5.5 Container stoppen und löschen

```bash
podman stop webserver
podman rm webserver

# Alle gestoppten Container auf einmal löschen
podman container prune
```

---

## 6. Container-Lifecycle im Alltag

### 6.1 Logs anzeigen

```bash
# Einmalig anzeigen
podman logs webserver

# Live mitverfolgen (wie tail -f)
podman logs -f webserver

# Letzte 50 Zeilen
podman logs --tail 50 webserver

# Mit Zeitstempeln
podman logs -t webserver
```

### 6.2 Prozesse im Container anzeigen

```bash
podman top webserver
```

### 6.3 Ressourcenverbrauch live

```bash
podman stats               # Alle Container
podman stats webserver     # Nur einer
```

### 6.4 Container inspizieren

```bash
# Komplette JSON-Konfiguration
podman inspect webserver

# Gezielt einzelne Felder per jq
podman inspect webserver | jq '.[0].NetworkSettings.IPAddress'
```

### 6.5 Dateien ein- und auspacken

```bash
podman cp ./datei.txt webserver:/tmp/datei.txt
podman cp webserver:/var/log/nginx/access.log ./access.log
```

### 6.6 Container neu starten / pausieren

```bash
podman restart webserver
podman pause webserver
podman unpause webserver
```

---

## 7. Volumes und persistente Daten

Container sind per Definition flüchtig – wenn sie gelöscht werden, sind alle Daten weg. Für persistente Daten gibt es zwei Mechanismen.

### 7.1 Bind Mounts (Host-Verzeichnis)

Ein Verzeichnis vom Host wird direkt in den Container eingehängt:

```bash
mkdir -p ~/podman-data/webroot
echo "<h1>Hallo!</h1>" > ~/podman-data/webroot/index.html

podman run -d --name web \
  -p 8080:80 \
  -v ~/podman-data/webroot:/usr/share/nginx/html:Z \
  nginx:alpine
```

Erklärung:
- **`:Z`** – wichtig auf Systemen mit SELinux (CachyOS nutzt es zwar nicht, aber das Flag schadet nicht und ist portabel)
- **`:ro`** – würde Read-Only mounten

### 7.2 Named Volumes (von Podman verwaltet)

```bash
# Volume erstellen
podman volume create kursdaten

# Volume verwenden
podman run -d --name pg \
  -e POSTGRES_PASSWORD=geheim \
  -v kursdaten:/var/lib/postgresql/data \
  docker.io/library/postgres:16-alpine

# Volumes auflisten
podman volume ls

# Volume inspizieren
podman volume inspect kursdaten

# Volume löschen
podman volume rm kursdaten
```

**Wann was?**
- **Bind Mount:** Wenn du den Inhalt vom Host aus direkt sehen/bearbeiten willst (Schulungsmaterial, Webroot)
- **Named Volume:** Für reine Daten-Persistenz, die nur der Container braucht (Datenbank-Files)

### 7.3 tmpfs (RAM-basiert)

Für temporäre Daten, die schnell sein sollen und nicht persistieren:

```bash
podman run --tmpfs /tmp -it alpine:3.21 ash
```

---

## 8. Netzwerk und Port-Forwarding

### 8.1 Standardnetzwerk

Rootless Podman nutzt standardmäßig **slirp4netns**. Das ist ein User-Mode-Netzwerk, das ohne Root-Rechte funktioniert. Container haben dadurch **keine eigenen IP-Adressen vom LAN aus** – sie können nur über Port-Forwarding erreicht werden.

### 8.2 Port-Forwarding

```bash
# Host-Port 8080 → Container-Port 80
podman run -d -p 8080:80 nginx:alpine

# Spezifische Host-IP
podman run -d -p 127.0.0.1:8080:80 nginx:alpine

# Mehrere Ports
podman run -d -p 8080:80 -p 8443:443 nginx:alpine

# UDP
podman run -d -p 53:53/udp meindns
```

### 8.3 Eigene Netzwerke für Container-Kommunikation

Für mehrere Container, die miteinander reden sollen, ist ein eigenes Netzwerk besser als Port-Forwarding:

```bash
# Netzwerk erstellen
podman network create kursnet

# Container ins Netzwerk hängen
podman run -d --name db --network kursnet \
  -e POSTGRES_PASSWORD=geheim \
  postgres:16-alpine

podman run -d --name app --network kursnet \
  -e DATABASE_URL=postgres://postgres:geheim@db:5432/postgres \
  meine-app:latest
```

Container im selben Netzwerk können sich über ihren Namen (`db`, `app`) per DNS ansprechen.

### 8.4 Netzwerke auflisten und inspizieren

```bash
podman network ls
podman network inspect kursnet
```

### 8.5 Pasta statt slirp4netns (modern)

Ab Podman 5.x ist **pasta** der neue Default für rootless-Networking. Schneller als slirp4netns und mit besserer IPv6-Unterstützung. Sicherstellen, dass es installiert ist:

```bash
sudo pacman -S passt
```

---

## 9. Eigene Images bauen mit Containerfile

Podman nutzt **Containerfile** (oder klassisch `Dockerfile` – beide funktionieren). Das ist eine Textdatei mit Anweisungen zum Bau eines Images.

### 9.1 Beispiel: Python-Schulungsumgebung

`Containerfile`:

```dockerfile
FROM alpine:3.21

# Pakete installieren
RUN apk add --no-cache python3 py3-pip sqlite bash

# Python-Bibliotheken
RUN pip3 install --break-system-packages pandas matplotlib jupyter

# Arbeitsverzeichnis
WORKDIR /workspace

# Standardbefehl
CMD ["bash"]
```

Image bauen:

```bash
podman build -t kurs-python:latest .
```

Erklärung der Flags:
- **`-t`** – Tag (Name:Version) für das Image
- **`.`** – Build-Kontext (das aktuelle Verzeichnis)

### 9.2 Image testen

```bash
podman run --rm -it kurs-python:latest
```

### 9.3 Häufige Containerfile-Anweisungen

| Anweisung | Bedeutung |
|---|---|
| `FROM image:tag` | Basis-Image |
| `RUN befehl` | Befehl beim Build ausführen |
| `COPY src dst` | Datei in Image kopieren |
| `ADD src dst` | Wie COPY, kann auch URLs/tar.gz |
| `WORKDIR /path` | Arbeitsverzeichnis setzen |
| `ENV VAR=wert` | Umgebungsvariable |
| `EXPOSE 8080` | Dokumentiert Port (öffnet ihn nicht) |
| `VOLUME /pfad` | Volume-Mountpoint |
| `USER name` | Wechsel zu nicht-Root-User |
| `CMD ["x", "y"]` | Standardbefehl |
| `ENTRYPOINT ["x"]` | Wrapper-Befehl |

### 9.4 Multi-Stage-Builds

Für kleinere Images: In einer Stage bauen, in der nächsten nur das Ergebnis übernehmen.

```dockerfile
# Stage 1: Build
FROM rust:1.80-alpine AS builder
WORKDIR /src
COPY . .
RUN cargo build --release

# Stage 2: Runtime
FROM alpine:3.21
COPY --from=builder /src/target/release/meine-app /usr/local/bin/
CMD ["meine-app"]
```

Das finale Image enthält nur das Binary, nicht die Rust-Toolchain.

### 9.5 Image taggen und an Registry pushen

```bash
# Lokal taggen
podman tag kurs-python:latest registry.beispiel.de/bwsa/kurs-python:v1

# An Registry pushen (Login vorher mit podman login)
podman push registry.beispiel.de/bwsa/kurs-python:v1
```

---

## 10. Multi-Container mit Compose

Für Setups mit mehreren Containern (z. B. Webapp + Datenbank + Cache) gibt es Compose. Eine YAML-Datei beschreibt das gesamte Setup.

### 10.1 Beispiel: Webserver + PostgreSQL

`compose.yml`:

```yaml
services:
  db:
    image: docker.io/library/postgres:16-alpine
    environment:
      POSTGRES_PASSWORD: geheim
      POSTGRES_DB: kursdb
    volumes:
      - dbdata:/var/lib/postgresql/data
    restart: unless-stopped

  app:
    image: docker.io/library/nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html:Z
    depends_on:
      - db
    restart: unless-stopped

volumes:
  dbdata:
```

### 10.2 Stack starten

```bash
podman-compose up -d
```

### 10.3 Stack-Befehle

```bash
podman-compose ps              # Status
podman-compose logs -f         # Logs aller Services
podman-compose logs -f app     # Logs eines Services
podman-compose stop            # Stoppen
podman-compose down            # Stoppen und löschen
podman-compose down -v         # Inklusive Volumes
```

### 10.4 Alternative: `docker compose` mit Podman

Mit `podman-docker` und einem aktivierten Podman-Socket kannst du auch das offizielle `docker compose` benutzen:

```bash
systemctl --user enable --now podman.socket

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock

# Dann läuft 'docker compose' transparent gegen Podman
docker compose up -d
```

> **Hinweis:** `podman-compose` ist eine eigenständige Python-Implementation und kann bei komplexen Compose-Files leichte Abweichungen haben. Für maximale Kompatibilität ist der Socket-Weg mit `docker compose` der robustere.

---

## 11. Quadlets – die systemd-Integration

Quadlets sind die eleganteste Lösung, um Container dauerhaft als systemd-Services zu betreiben. Statt eigene `.service`-Dateien zu schreiben, deklarierst du den Container direkt.

### 11.1 Quadlet-Datei anlegen

Datei: `~/.config/containers/systemd/webserver.container`

```ini
[Unit]
Description=Nginx Webserver für BWSA-Kurs
After=network-online.target

[Container]
Image=docker.io/library/nginx:alpine
ContainerName=webserver
PublishPort=8080:80
Volume=%h/podman-data/webroot:/usr/share/nginx/html:Z
AutoUpdate=registry

[Service]
Restart=always

[Install]
WantedBy=default.target
```

Erklärung wichtiger Felder:
- **`%h`** – Home-Verzeichnis des Users
- **`AutoUpdate=registry`** – ermöglicht `podman auto-update` für automatisches Image-Update
- **`Restart=always`** – Neustart bei Absturz

### 11.2 Aktivieren und starten

```bash
# systemd neue Quadlets erkennen lassen
systemctl --user daemon-reload

# Service starten
systemctl --user start webserver.service

# Status prüfen
systemctl --user status webserver.service

# Beim Login automatisch starten
systemctl --user enable webserver.service
```

### 11.3 Auch ohne aktive Login-Session

Damit User-Services beim Booten ohne Login laufen:

```bash
sudo loginctl enable-linger $USER
```

### 11.4 Logs

```bash
journalctl --user -u webserver.service -f
```

### 11.5 Quadlet-Typen

| Datei | Erstellt |
|---|---|
| `.container` | Einzelnen Container |
| `.pod` | Pod (siehe nächstes Kapitel) |
| `.network` | Netzwerk |
| `.volume` | Volume |
| `.kube` | Kubernetes-YAML |
| `.image` | Image-Pull-Automatik |
| `.build` | Image-Build aus Containerfile |

### 11.6 Auto-Update aktivieren

Damit Container automatisch neue Image-Versionen ziehen:

```bash
systemctl --user enable --now podman-auto-update.timer
```

Läuft täglich und aktualisiert alle Container mit `AutoUpdate=registry`.

---

## 12. Pods – mehrere Container als Einheit

Ein **Pod** ist ein Konzept aus Kubernetes: Eine Gruppe von Containern, die sich denselben Netzwerk-Namespace und ggf. Volumes teilen. Sie kommunizieren über `localhost`. Podman ist die einzige der gängigen Container-Engines, die Pods nativ kann.

### 12.1 Pod erstellen

```bash
podman pod create --name kurs-pod -p 8080:80
```

### 12.2 Container in den Pod hängen

```bash
podman run -d --pod kurs-pod --name web nginx:alpine
podman run -d --pod kurs-pod --name cache redis:alpine
```

`web` und `cache` sehen sich gegenseitig auf `localhost`. Der Port 8080 vom Host geht an Port 80 im Pod (= zum nginx).

### 12.3 Pods verwalten

```bash
podman pod ls
podman pod stop kurs-pod
podman pod start kurs-pod
podman pod rm kurs-pod
```

### 12.4 Pod aus Kubernetes-YAML

Podman kann Pods auch direkt aus Kubernetes-Manifesten erzeugen:

```bash
podman play kube meine-pod.yaml
```

Umgekehrt kann man laufende Pods als Kubernetes-YAML exportieren:

```bash
podman generate kube kurs-pod > kurs-pod.yaml
```

Damit ist Podman ein gutes Lehrwerkzeug für Kubernetes-Konzepte, ohne dass man tatsächlich einen Cluster aufsetzen muss.

---

## 13. Rootless-Container im Detail

Das Sicherheitsmodell von Podman im Rootless-Modus ist einer seiner wichtigsten Vorteile. Hier die Details, wie es funktioniert.

### 13.1 User-Namespaces

Wenn du als User `fritz` (UID 1000) `podman run` aufrufst, passiert Folgendes:

1. Podman erstellt einen neuen User-Namespace
2. **UID 0 (root) im Container** wird auf **UID 1000 (fritz) auf dem Host** gemappt
3. Weitere UIDs im Container (1, 2, ...) werden auf den Subuid-Bereich gemappt (100000, 100001, ...)

Das bedeutet:
- Im Container sieht es so aus, als wäre man root
- Auf dem Host ist man aber nur ein normaler User
- Bricht jemand aus dem Container aus, hat er nur die Rechte von `fritz`, nicht root

### 13.2 Was rootless **kann**

- Praktisch alle gängigen Container-Workloads
- Volumes mit eigenen Daten mounten
- Eigene Netzwerke und Port-Forwarding
- Compose und Quadlets

### 13.3 Was rootless **nicht** kann

- Privilegierte Ports (< 1024) ohne Zusatzkonfiguration
- Bestimmte Kernel-Module laden
- Direkten Zugriff auf physische Hardware (z. B. `/dev/kvm` ohne Vorbereitung)

### 13.4 Privilegierte Ports erlauben

Standardmäßig sind Ports < 1024 für Root reserviert. Für rootless Podman:

```bash
# In /etc/sysctl.d/99-rootless-ports.conf
echo "net.ipv4.ip_unprivileged_port_start=80" | \
  sudo tee /etc/sysctl.d/99-rootless-ports.conf
sudo sysctl --system
```

### 13.5 Wann doch root?

Für sehr seltene Spezialfälle gibt es `sudo podman ...`. Beispiele:
- Direkter Zugriff auf physische Netzwerk-Interfaces (macvlan)
- Bestimmte Storage-Setups

In 95% der Fälle reicht rootless völlig aus.

### 13.6 Storage-Trennung

Rootless und Rootful Podman haben getrennten Storage:
- Rootless: `~/.local/share/containers/`
- Rootful: `/var/lib/containers/`

Ein Image, das du als `fritz` gepullt hast, ist nicht für `sudo podman` verfügbar – und umgekehrt.

---

## 14. Distrobox auf Podman-Basis

Distrobox ist ein extrem nützliches Werkzeug, das Podman als Backend nutzt: Es startet einen Container einer beliebigen Distribution und integriert ihn nahtlos in deinen Host. Du kannst dort `apt install` oder `dnf install` benutzen, während CachyOS unangetastet bleibt.

### 14.1 Installation

```bash
sudo pacman -S distrobox
```

### 14.2 Container erstellen

```bash
# Ubuntu LTS für Schulungsmaterialien
distrobox create --name ubuntu-kurs --image docker.io/library/ubuntu:24.04

# Fedora für rpm-basierte Tests
distrobox create --name fedora-test --image docker.io/library/fedora:40

# Container betreten
distrobox enter ubuntu-kurs
```

Im Container:
- Dein Home-Verzeichnis ist gemountet (`~/`)
- X11/Wayland funktionieren (GUI-Programme starten)
- USB-Geräte sind durchgereicht
- `apt install` etc. funktionieren wie gewohnt

### 14.3 Programme aus Distrobox auf den Host exportieren

```bash
# Im Distrobox: ein Programm installieren und auf den Host "exportieren"
distrobox-export --app firefox
distrobox-export --bin /usr/bin/code --export-path ~/.local/bin
```

Das exportierte Programm ist dann im Host-Menü oder PATH verfügbar – läuft aber im Container.

### 14.4 Container-Übersicht

```bash
distrobox list
distrobox stop ubuntu-kurs
distrobox rm ubuntu-kurs
```

### 14.5 Anwendungsfälle für Schulungen

- **Ubuntu-spezifisches Material:** Wenn dein Kurs auf Ubuntu LTS basiert
- **Reproduzierbare Build-Umgebungen:** Ein Container pro Projekt
- **Alte Software:** CachyOS rolling vs. älteres LTS-Userland
- **`apt`-Befehle für Lernzwecke:** Teilnehmer üben Debian/Ubuntu-Verwaltung

---

## 15. Docker auf CachyOS (falls doch nötig)

Wenn du Docker brauchst – etwa weil ein Kunden-Setup es voraussetzt – hier die saubere Installation.

### 15.1 Installation

```bash
sudo pacman -S docker docker-compose docker-buildx
```

### 15.2 Daemon aktivieren

```bash
sudo systemctl enable --now docker.service
```

### 15.3 User zur docker-Gruppe

```bash
sudo usermod -aG docker $USER
```

> **Sicherheitshinweis:** Mitglieder der `docker`-Gruppe haben de facto Root-Rechte. Wer diese Gruppe ablehnt, muss `sudo docker ...` verwenden.

### 15.4 Test

```bash
docker run --rm hello-world
```

### 15.5 Konflikt mit Podman vermeiden

Wenn du `podman-docker` installiert hast (das einen `docker`-Wrapper für Podman bereitstellt), wird beim Installieren von echtem Docker ein Konflikt entstehen. Lösung: einen der beiden auswählen.

Wenn beide parallel sein sollen, kannst du Docker behalten und Podman ohne `podman-docker` betreiben – Podman funktioniert ja auch ohne den Wrapper.

### 15.6 Rootless Docker

Für mehr Sicherheit lässt sich auch Docker rootless betreiben:

```bash
sudo pacman -S docker-rootless-extras
dockerd-rootless-setuptool.sh install
```

Das richtet einen User-Daemon ein. Ist machbar, aber spürbar komplizierter als Podman, das das ohnehin als Standard hat.

---

## 16. Typische Fehler und Lösungen

### Fehler: `Error: short-name resolution enforced`

**Ursache:** Podman verlangt, dass du explizit angibst, von welcher Registry ein Image kommt.

**Lösung 1 (interaktiv):** Beim ersten Pull fragt Podman und merkt sich die Wahl.

**Lösung 2 (Registry-Default setzen):** In `/etc/containers/registries.conf`:
```toml
unqualified-search-registries = ["docker.io"]
```

**Lösung 3 (immer voll qualifizieren):**
```bash
podman pull docker.io/library/alpine:3.21
```

### Fehler: `unable to find user X: no matching entries in passwd file`

**Ursache:** Subuid/Subgid sind nicht eingerichtet.

```bash
sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $USER
podman system migrate
```

### Fehler: Container kann nicht auf Port 80 binden

**Ursache:** Rootless Podman darf keine Ports < 1024.

**Lösung:** Höheren Port nehmen (`-p 8080:80`) oder privilegierte Ports erlauben (siehe Kapitel 13.4).

### Fehler: Compose findet Image nicht

**Ursache:** Compose-Files mit Image-Namen ohne Registry (`image: postgres`).

**Lösung:** Voll qualifizieren in der YAML:
```yaml
image: docker.io/library/postgres:16-alpine
```

### Fehler: `cannot set up namespace using "/proc/...uid_map"`

**Ursache:** User-Namespace-Limit erreicht.

```bash
sudo sysctl -w user.max_user_namespaces=15000
echo "user.max_user_namespaces=15000" | \
  sudo tee /etc/sysctl.d/99-podman-namespaces.conf
```

### Fehler: Podman-Container nach Reboot weg

**Ursache:** Du hast keinen Quadlet/systemd-Service eingerichtet.

**Lösung:** Container als Quadlet definieren (siehe Kapitel 11) oder mit `podman generate systemd` einen klassischen Service generieren.

### Fehler: Distrobox findet GPU nicht

```bash
distrobox create --name kurs --image fedora:40 --nvidia
```

Das Flag `--nvidia` reicht NVIDIA-Treiber durch (sehr nützlich mit deiner RTX 4070 Ti Super).

---

## 17. Befehlsreferenz Docker ↔ Podman

Die meisten Befehle sind 1:1 austauschbar. Hier die wichtigsten in einer Tabelle.

### Container-Lifecycle

| Aufgabe | Docker | Podman |
|---|---|---|
| Image pullen | `docker pull NAME` | `podman pull NAME` |
| Container starten | `docker run NAME` | `podman run NAME` |
| Im Hintergrund | `docker run -d NAME` | `podman run -d NAME` |
| Interaktiv | `docker run -it NAME` | `podman run -it NAME` |
| Liste laufende | `docker ps` | `podman ps` |
| Liste alle | `docker ps -a` | `podman ps -a` |
| Stoppen | `docker stop NAME` | `podman stop NAME` |
| Starten | `docker start NAME` | `podman start NAME` |
| Löschen | `docker rm NAME` | `podman rm NAME` |
| In Container | `docker exec -it NAME sh` | `podman exec -it NAME sh` |
| Logs | `docker logs -f NAME` | `podman logs -f NAME` |

### Images

| Aufgabe | Docker | Podman |
|---|---|---|
| Liste Images | `docker images` | `podman images` |
| Image bauen | `docker build -t NAME .` | `podman build -t NAME .` |
| Image taggen | `docker tag SRC DST` | `podman tag SRC DST` |
| Image pushen | `docker push NAME` | `podman push NAME` |
| Image löschen | `docker rmi NAME` | `podman rmi NAME` |
| Aufräumen | `docker image prune` | `podman image prune` |

### Volumes & Netzwerke

| Aufgabe | Docker | Podman |
|---|---|---|
| Volumes auflisten | `docker volume ls` | `podman volume ls` |
| Volume erstellen | `docker volume create NAME` | `podman volume create NAME` |
| Netzwerke auflisten | `docker network ls` | `podman network ls` |
| Netzwerk erstellen | `docker network create NAME` | `podman network create NAME` |

### Compose

| Aufgabe | Docker | Podman |
|---|---|---|
| Stack starten | `docker compose up -d` | `podman-compose up -d` |
| Stack stoppen | `docker compose down` | `podman-compose down` |
| Logs | `docker compose logs -f` | `podman-compose logs -f` |
| Status | `docker compose ps` | `podman-compose ps` |

### System

| Aufgabe | Docker | Podman |
|---|---|---|
| System-Info | `docker info` | `podman info` |
| Aufräumen (alles) | `docker system prune -a` | `podman system prune -a` |
| Disk-Usage | `docker system df` | `podman system df` |

### Podman-spezifisch (kein Docker-Äquivalent)

| Aufgabe | Befehl |
|---|---|
| Pod erstellen | `podman pod create --name NAME` |
| Kubernetes-YAML aus Pod | `podman generate kube NAME` |
| Quadlets neu laden | `systemctl --user daemon-reload` |
| Auto-Update aller AutoUpdate-Container | `podman auto-update` |

---

## Anhang: Schnell-Setup-Skript

Dieses Skript richtet Podman komplett für deinen Use Case ein:

```bash
#!/usr/bin/env bash
# podman-setup.sh – Podman-Erstkonfiguration auf CachyOS

set -e

echo "=== Pakete installieren ==="
sudo pacman -S --needed podman podman-compose podman-docker \
  fuse-overlayfs slirp4netns passt distrobox

echo "=== Subuid/Subgid einrichten ==="
if ! grep -q "^$USER:" /etc/subuid 2>/dev/null; then
  sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $USER
fi

echo "=== Registry-Default setzen ==="
if [ ! -f ~/.config/containers/registries.conf ]; then
  mkdir -p ~/.config/containers
  cat > ~/.config/containers/registries.conf <<EOF
unqualified-search-registries = ["docker.io", "quay.io", "ghcr.io"]
EOF
fi

echo "=== Privilegierte Ports ab 80 erlauben ==="
echo "net.ipv4.ip_unprivileged_port_start=80" | \
  sudo tee /etc/sysctl.d/99-rootless-ports.conf
sudo sysctl --system

echo "=== Linger aktivieren (User-Services ohne Login) ==="
sudo loginctl enable-linger $USER

echo "=== Podman-Socket aktivieren (für 'docker compose' Kompatibilität) ==="
systemctl --user enable --now podman.socket

echo "=== Auto-Update Timer aktivieren ==="
systemctl --user enable --now podman-auto-update.timer

echo "=== Migration anstoßen ==="
podman system migrate

echo "=== Test ==="
podman run --rm docker.io/library/hello-world

echo ""
echo "=== Fertig! ==="
echo "Podman ist eingerichtet."
echo "Optional: 'export DOCKER_HOST=unix://\$XDG_RUNTIME_DIR/podman/podman.sock'"
echo "         in ~/.bashrc, damit 'docker compose' transparent gegen Podman läuft."
```

Skript ausführbar machen und starten:

```bash
chmod +x podman-setup.sh
./podman-setup.sh
```

---

*Leitfaden erstellt für BWSA – Bildung, Weiterbildung, Service | CachyOS / Arch Linux*
