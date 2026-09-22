---
title: "Leitfaden: Eigenes bootc-Image mit Homebrew-Toolchain fürs Coaching"
date: 2026-07-20
tags:
  - linux
  - fedora-atomic
  - bootc
  - homebrew
  - coaching
  - nushell
aliases:
  - "Homebrew-Image bauen"
  - "Coaching bootc Leitfaden"
status: active
---

# Eigenes bootc-Image mit Homebrew-Toolchain

Kompletter Durchlauf vom leeren Verzeichnis bis zum aktivierten, getesteten und wieder zurückgerollten Image. Zielsystem ist [[Fedora Sway Atomic]], die Build-Toolchain wandert ins Image, [[Homebrew]] selbst zur Laufzeit nach `/var/home/linuxbrew`.

> [!abstract] Grundprinzip
> **Ins Image (`/usr`, read-only):** Compiler, `make`, Basis-Werkzeuge – alles, was Homebrew zum Bauen braucht.
> **Zur Laufzeit (`/var/home/linuxbrew`):** Homebrew selbst inkl. Cellar & Sources. Grund: `brew` läuft nicht als root, und Inhalte unter `/var` werden im Image-Build ohnehin nicht zuverlässig ins OSTree-Commit übernommen.

---

## 0. Voraussetzungen

Auf dem **Build-Rechner** (deine CachyOS-Workstation):

- `podman` (rootless genügt zum Bauen und Pushen)
- `git`
- Optional: `just` als Task-Runner, `cosign` zum Signieren
- Ein GitHub-Account mit aktiviertem **GitHub Container Registry (GHCR)**

Auf dem **Zielsystem** (Coaching-Rechner) ist bereits Fedora Sway Atomic (F41+) installiert, damit `bootc` verfügbar ist.

---

## 1. Projektverzeichnis anlegen

```nu
mkdir coaching-brew
cd coaching-brew
```

Wir bauen folgende Struktur auf:

```
coaching-brew/
├── Containerfile
├── README.md
├── .gitignore
├── Justfile
├── overlay/
│   ├── etc/
│   │   └── skel/
│   │       └── .config/
│   │           └── nushell/
│   │               └── env.nu
│   └── usr/
│       ├── share/
│       │   └── coaching/
│       │       └── homebrew.nu
│       └── lib/
│           └── systemd/
│               └── user/
│                   └── homebrew-bootstrap.service
└── .github/
    └── workflows/
        └── build.yml
```

```nu
mkdir overlay/etc/skel/.config/nushell
mkdir overlay/usr/share/coaching
mkdir overlay/usr/lib/systemd/user
mkdir .github/workflows
```

---

## 2. Git initialisieren

```nu
git init
git branch -m main
```

`.gitignore` – wir versionieren nur die Quellen, keine gebauten Artefakte:

```gitignore
# .gitignore
*.tar
*.qcow2
*.iso
.build/
image-out/
cosign.key
```

> [!warning] Signierschlüssel niemals committen
> `cosign.key` (privater Schlüssel) gehört in die GitHub-Secrets, nicht ins Repo. Deshalb steht er in der `.gitignore`.

---

## 3. Alle Dateien anlegen

### 3.1 `Containerfile`

Das Herzstück. Es zieht das Basisimage, legt die Toolchain in `/usr` ab und bringt die Nushell-Integration sowie den First-Boot-Bootstrap mit.

```dockerfile
# Containerfile
FROM quay.io/fedora-ostree-desktops/sway-atomic:44

# Manche Pakete verlangen ein vorhandenes /var/roothome, sonst bricht der Build ab.
RUN mkdir -p /var/roothome

# --- Build-Toolchain für Homebrew (bleibt read-only im Image) ---
RUN dnf -y install \
        @development-tools \
        gcc gcc-c++ make \
        procps-ng curl file git \
        libxcrypt-compat \
        nushell helix && \
    dnf clean all

# --- Overlay: Nushell-Env, /etc/skel, systemd-User-Unit ---
COPY overlay/ /

# --- bootc-Lint als Qualitätssicherung im Build ---
RUN bootc container lint

LABEL org.opencontainers.image.title="Coaching Brew" \
      org.opencontainers.image.description="Fedora Sway Atomic + Homebrew-Toolchain" \
      containers.bootc="1"
```

> [!note] Warum `nushell` und `helix` mit ins Image?
> Du nutzt beide durchgängig. Als reine CLI-Werkzeuge gehören sie sauber nach `/usr` und müssen nicht über Homebrew laufen. Homebrew bleibt damit frei für projektspezifische Formeln.

### 3.2 `overlay/usr/share/coaching/homebrew.nu`

Der zentrale Env-Baustein. `brew shellenv` unterstützt **kein** Nushell (offenes Upstream-Issue, weil Nu kein `eval` kennt), deshalb setzen wir die Variablen deterministisch selbst:

```nu
# /usr/share/coaching/homebrew.nu
# Homebrew-Umgebung für Nushell. Wird aus env.nu gesourct.

const brew_prefix = "/var/home/linuxbrew/.linuxbrew"

if ($brew_prefix | path exists) {
    $env.HOMEBREW_PREFIX = $brew_prefix
    $env.HOMEBREW_CELLAR = $"($brew_prefix)/Cellar"
    $env.HOMEBREW_REPOSITORY = $"($brew_prefix)/Homebrew"

    $env.PATH = ($env.PATH
        | split row (char esep)
        | prepend $"($brew_prefix)/sbin"
        | prepend $"($brew_prefix)/bin")

    $env.MANPATH = ([$"($brew_prefix)/share/man"] | append ($env.MANPATH? | default ""))
    $env.INFOPATH = ([$"($brew_prefix)/share/info"] | append ($env.INFOPATH? | default ""))
}
```

### 3.3 `overlay/etc/skel/.config/nushell/env.nu`

So bekommt jeder **neu** angelegte User die Integration automatisch:

```nu
# /etc/skel/.config/nushell/env.nu
source /usr/share/coaching/homebrew.nu
```

> [!tip] Bestehende User
> Bei bereits vorhandenen Home-Verzeichnissen greift `/etc/skel` nicht. Dort trägst du die eine `source`-Zeile einmalig in die verwaltete `env.nu` ein – passt gut zu deinem modularen Config-Ansatz (`hypr.nu` & Co.).

### 3.4 `overlay/usr/lib/systemd/user/homebrew-bootstrap.service`

Installiert Homebrew beim ersten Login in `/var/home/linuxbrew`, sofern noch nicht vorhanden. Läuft als **User**-Dienst (nicht root), was `brew` zwingend verlangt.

```ini
# /usr/lib/systemd/user/homebrew-bootstrap.service
[Unit]
Description=Homebrew Erstinstallation nach /var/home/linuxbrew
ConditionPathExists=!/var/home/linuxbrew/.linuxbrew/bin/brew
After=default.target

[Service]
Type=oneshot
Environment=NONINTERACTIVE=1
ExecStart=/usr/bin/bash -c "curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash"
RemainAfterExit=yes

[Install]
WantedBy=default.target
```

> [!info] Der `/home` → `/var/home`-Trick
> Homebrews Linux-Default `/home/linuxbrew/.linuxbrew` landet auf Atomic über den Symlink `/home` → `/var/home` automatisch in `/var/home/linuxbrew/.linuxbrew`. Du musst am Installer nichts umbiegen.

Damit die Unit bei jedem User aktiv ist, aktivieren wir sie global per Preset. Ergänze im `Containerfile` nach dem `COPY`:

```dockerfile
RUN systemctl --global enable homebrew-bootstrap.service
```

### 3.5 `Justfile` (optional, spart Tipparbeit)

```make
# Justfile
image := "ghcr.io/DEIN-GH-NAME/coaching-brew"
tag   := "latest"

build:
    podman build -t {{image}}:{{tag}} .

push:
    podman push {{image}}:{{tag}}

lint:
    podman run --rm {{image}}:{{tag}} bootc container lint

login:
    podman login ghcr.io
```

### 3.6 `README.md`

```markdown
# Coaching Brew

Fedora Sway Atomic + Homebrew-Toolchain als bootc-Image.

- Build-Toolchain im Image (`/usr`)
- Homebrew zur Laufzeit in `/var/home/linuxbrew`
- Nushell-Integration über `/usr/share/coaching/homebrew.nu`

## Aktivieren
    sudo bootc switch ghcr.io/DEIN-GH-NAME/coaching-brew:latest
    sudo systemctl reboot

## Zurückrollen
    sudo bootc rollback
    sudo systemctl reboot
```

### 3.7 `.github/workflows/build.yml`

Baut das Image bei jedem Push, lädt es nach GHCR und signiert es mit cosign.

```yaml
# .github/workflows/build.yml
name: build-image

on:
  push:
    branches: [main]
  schedule:
    - cron: "0 4 * * 1"   # wöchentlich, damit Basis-Updates einfließen
  workflow_dispatch:

env:
  IMAGE: ghcr.io/${{ github.repository_owner }}/coaching-brew

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - uses: actions/checkout@v4

      - name: Build
        run: podman build -t "${IMAGE}:latest" .

      - name: Login GHCR
        run: echo "${{ secrets.GITHUB_TOKEN }}" | podman login ghcr.io -u "${{ github.actor }}" --password-stdin

      - name: Push
        id: push
        run: |
          podman push "${IMAGE}:latest" --digestfile=/tmp/digest
          echo "digest=$(cat /tmp/digest)" >> "$GITHUB_OUTPUT"

      - name: Cosign install
        uses: sigstore/cosign-installer@v3

      - name: Sign
        env:
          COSIGN_PRIVATE_KEY: ${{ secrets.COSIGN_PRIVATE_KEY }}
          COSIGN_PASSWORD: ${{ secrets.COSIGN_PASSWORD }}
        run: cosign sign --yes --key env://COSIGN_PRIVATE_KEY "${IMAGE}@${{ steps.push.outputs.digest }}"
```

Cosign-Schlüsselpaar einmalig erzeugen und den privaten Teil als Secret hinterlegen:

```nu
cosign generate-key-pair
# erzeugt cosign.key (privat -> Secret COSIGN_PRIVATE_KEY) und cosign.pub (öffentlich -> ins Repo)
```

---

## 4. Auswahl eines Basisimages

| Basisimage | Einsatz |
|---|---|
| `quay.io/fedora-ostree-desktops/sway-atomic:44` | **Empfohlen.** Deine Sway-Basis, bereits mit `dnf5` und `bootc`, cosign-signiert. Ideal, weil dein Setup darauf läuft. |
| `quay.io/fedora/fedora-bootc:44` | Minimaler bootc-Unterbau ohne Desktop – nur wenn du den Sway-Stack komplett selbst zusammenstellst. |

> [!note] Version festnageln
> Es lohnt sich, den Tag (`:44`) statt eines gleitenden `:latest` zu pinnen, damit Basisupdates kontrolliert einfließen. Der wöchentliche Cron im Workflow zieht die Basis-Updates dann bewusst nach.

Die unoffiziellen `fedora-ostree-desktops`-Images nutzen dieselben Pakete und Quellen wie die offiziellen Atomic-Desktops und sind inzwischen cosign-signiert.

---

## 5. Bilden des Images

Lokal auf dem Build-Rechner:

```nu
# mit Just
just build
just lint

# oder direkt
podman build -t ghcr.io/DEIN-GH-NAME/coaching-brew:latest .
```

Der `RUN bootc container lint` im `Containerfile` prüft schon beim Build auf typische Fehler (falsche Pfade, kaputte Symlinks). Ein grüner Build heißt: das Image ist bootfähig aufgebaut.

Schnelltest des Dateisystems, ohne zu booten:

```nu
podman run --rm -it ghcr.io/DEIN-GH-NAME/coaching-brew:latest bash
# im Container:
which gcc make git nu hx
cat /usr/share/coaching/homebrew.nu
```

---

## 6. Hochladen der Dokumente und des Images auf GitHub

Hier laufen **zwei getrennte Ziele** zusammen: die Quellen/Doku ins Git-Repo auf `github.com`, das gebaute Image in die Registry `ghcr.io`.

### 6.1 Doku (Quelltexte) → github.com

```nu
git add .
git commit -m "Initiales bootc-Image mit Homebrew-Toolchain"

# Repo auf github.com anlegen, dann:
git remote add origin git@github.com:DEIN-GH-NAME/coaching-brew.git
git push -u origin main
```

Sobald der Workflow aus Abschnitt 3.7 durchläuft, baut GitHub das Image automatisch und pusht es. Für den **manuellen** Weg:

### 6.2 Image → ghcr.io

```nu
# Token mit Scope write:packages erzeugen (GitHub -> Settings -> Developer settings)
echo $env.GH_TOKEN | podman login ghcr.io -u DEIN-GH-NAME --password-stdin

just push
# oder
podman push ghcr.io/DEIN-GH-NAME/coaching-brew:latest
```

> [!warning] Paket-Sichtbarkeit auf „public" setzen
> Frisch gepushte GHCR-Pakete sind privat. Damit `bootc switch` das Image ohne Registry-Login ziehen kann, stellst du es unter **GitHub → Packages → Package settings → Change visibility → Public**. Für interne Nutzung alternativ die Zielgeräte per `podman login` authentifizieren.

---

## 7. Aktivieren des Images

Auf einem **Zielgerät**. Zuerst den aktuellen Stand sichern, dann umschalten.

```nu
# aktuellen Zustand ansehen und die laufende Bereitstellung anheften (Schutz vor GC)
sudo bootc status
sudo ostree admin pin 0

# auf das eigene Image umschalten
sudo bootc switch ghcr.io/DEIN-GH-NAME/coaching-brew:latest
sudo systemctl reboot
```

`bootc switch` legt das neue Image als nächste Bootbereitstellung an; das bisherige System bleibt als **Rollback**-Eintrag erhalten.

> [!note] Signaturprüfung
> Fedoras Standard-Policy akzeptiert das Image direkt. Für verifizierte Signaturen hinterlegst du `cosign.pub` und eine Policy unter `/etc/containers/policy.json` bzw. `/etc/containers/registries.d/` – sinnvoll, sobald das Setup produktiv läuft.

---

## 8. Testen

Nach dem Reboot:

```nu
# Läuft das eigene Image?
bootc status
# -> Booted image: ghcr.io/DEIN-GH-NAME/coaching-brew:latest

# Toolchain aus dem Image vorhanden?
which gcc; which make; which git; gcc --version

# Homebrew-Bootstrap gelaufen? (User-Unit, ggf. Login abwarten)
systemctl --user status homebrew-bootstrap.service
ls /var/home/linuxbrew/.linuxbrew/bin/brew

# Nushell-Integration greift?
brew --version
$env.HOMEBREW_PREFIX
```

Ist der Bootstrap noch nicht durch (z. B. weil der erste Login zu kurz war), einmal manuell anstoßen:

```nu
systemctl --user start homebrew-bootstrap.service
```

Kurzer Funktionstest von brew selbst:

```nu
brew install hello
hello
brew uninstall hello
```

> [!success] Erfolgskriterien
> `bootc status` zeigt dein Image · `gcc`/`make` liegen in `/usr` · `brew` liegt in `/var/home/linuxbrew` · `$env.HOMEBREW_PREFIX` ist gesetzt · eine Testformel baut/läuft.

---

## 9. Rückschalten auf das Ausgangsimage

Falls im Test etwas nicht passt – der transaktionale Kern von OSTree/bootc macht das gefahrlos.

### 9.1 Schneller Rückweg (vorheriges Deployment)

```nu
sudo bootc rollback
sudo systemctl reboot
```

Das tauscht die aktuelle und die Rollback-Bereitstellung: Nach dem Reboot läuft wieder das Ausgangssystem, dein Brew-Image bleibt als Rollback erhalten.

### 9.2 Vollständig zurück zum Stock-Image

Wenn du das eigene Image ganz verlassen willst:

```nu
sudo bootc switch quay.io/fedora-ostree-desktops/sway-atomic:44
sudo systemctl reboot
```

> [!info] `/var` bleibt erhalten
> `/var/home/linuxbrew` liegt in der beschreibbaren `/var`-Partition und übersteht sowohl Rollback als auch Image-Wechsel. Ein Rückschalten entfernt Homebrew also **nicht**. Zum sauberen Entfernen bei Bedarf:
> ```nu
> rm -rf /var/home/linuxbrew
> ```

---

## 10. Mehrere Image-Varianten für Geräterollen

Der Durchlauf oben baut **ein** Image. Sobald mehrere Geräterollen ins Spiel kommen, die sich zu großen Teilen überschneiden, dupliziert man aber keine Containerfiles – man zerlegt jedes Feature in ein **Modul** und komponiert die Rollen daraus. Das ersetzt die einfache `Containerfile`/`Justfile` aus [[#3.1 `Containerfile`]] und [[#3.5 `Justfile` (optional, spart Tipparbeit)]], sobald du skalierst.

> [!abstract] Drei Feature-Klassen auf Atomic
> **Kernelmodul** → muss ins Image *und* ist kernel-gekoppelt (baut bei jedem Kernel-Update neu, ggf. Secure-Boot-Signatur). Teuer und heikel.
> **Paket** → Image-Layer, reihenfolge-unkritisch, billig.
> **Laufzeit/State** → gehört nach `/var`, gar nicht ins Image (z. B. Homebrew selbst).

### 10.1 Rollen-Matrix

| Modul | Dozenten-PC (sway) | KI-Workstation (silverblue) | Entw. sway | Entw. silverblue |
|---|:---:|:---:|:---:|:---:|
| `10-core` (Brew-Toolchain, nu, hx) | ✅ | ✅ | ✅ | ✅ |
| `15-noctalia` (Sway-Shell) | ✅ | – | ✅ | – |
| `20-voice-io` (Sprach-IO) | – | ✅ | – | ✅ |
| `30-displaylink` (**akmod**) | ✅ | – | – | – |
| `40-kvm-win11` | ✅ | ✅ | – | – |
| `50-nvidia` (**akmod**) | – | ✅ | – | – |
| **Basis** | `sway-atomic:44` | `silverblue:44` | `sway-atomic:44` | `silverblue:44` |

> [!note] Module bleiben basisunabhängig
> Dass `voice-io` hier nur auf Silverblue und `noctalia` nur auf Sway landet, ist Zufall deiner Rollen, keine technische Kopplung. Die Module sind so geschrieben, dass eine künftige „Sway mit Sprach-IO"-Rolle nur eine Justfile-Zeile kostet.

### 10.2 Repo-Struktur

```
coaching-images/
├── Containerfile           # nimmt BASE_IMAGE + MODULES als ARG
├── modules/
│   ├── 10-core.sh          # Brew-Toolchain, nushell, helix, Bootstrap-Unit aktivieren
│   ├── 15-noctalia.sh      # Sway-Shell Noctalia/Quickshell
│   ├── 20-voice-io.sh      # Sprach-IO (TTS/STT-Basis)
│   ├── 30-displaylink.sh   # evdi-akmod + DisplayLinkManager (proprietär)
│   ├── 40-kvm-win11.sh     # qemu/libvirt/ovmf/swtpm
│   └── 50-nvidia.sh        # akmod-nvidia
├── overlay/                # gemeinsame Configs, systemd-Units, nu-env (wie Abschnitt 3.2–3.4)
└── Justfile
```

### 10.3 Parametrisiertes `Containerfile`

Ein einziges Containerfile führt die *ausgewählte* Modulliste aus:

```dockerfile
# Containerfile
ARG BASE_IMAGE=quay.io/fedora-ostree-desktops/sway-atomic:44
FROM ${BASE_IMAGE}
ARG MODULES="10-core.sh"

RUN mkdir -p /var/roothome
COPY modules/ /tmp/modules/
COPY overlay/  /
RUN set -euo pipefail; \
    for m in ${MODULES}; do echo "== $m =="; bash /tmp/modules/$m; done; \
    rm -rf /tmp/modules; \
    bootc container lint
```

### 10.4 Die vier Rollen im `Justfile`

```make
# Justfile
registry := "ghcr.io/DEIN-GH-NAME"
sway     := "quay.io/fedora-ostree-desktops/sway-atomic:44"
gnome    := "quay.io/fedora-ostree-desktops/silverblue:44"

_build base modules tag:
    podman build --build-arg BASE_IMAGE={{base}} \
                 --build-arg MODULES="{{modules}}" \
                 -t {{registry}}/coaching-{{tag}}:latest .

dozenten-pc:
    @just _build {{sway}}  "10-core.sh 15-noctalia.sh 30-displaylink.sh 40-kvm-win11.sh" dozenten-pc

ki-workstation:
    @just _build {{gnome}} "10-core.sh 20-voice-io.sh 40-kvm-win11.sh 50-nvidia.sh"      ki-workstation

dev-sway:
    @just _build {{sway}}  "10-core.sh 15-noctalia.sh"                                    dev-sway

dev-gnome:
    @just _build {{gnome}} "10-core.sh 20-voice-io.sh"                                    dev-gnome

build-all: dozenten-pc ki-workstation dev-sway dev-gnome
```

Jedes Feature steht damit genau einmal im Repo, jede Rolle ist eine deklarative Zeile. Push, `bootc switch`, Test und Rollback laufen pro Rolle exakt wie in den Abschnitten 6–9, nur mit dem jeweiligen Tag (`coaching-dozenten-pc:latest` usw.).

### 10.5 Die Module

Die unkritischen Paket-Module – sauber und vollständig:

```bash
# modules/10-core.sh  — auf allen Rollen
#!/usr/bin/env bash
set -euo pipefail
dnf -y install @development-tools gcc gcc-c++ make procps-ng curl file git \
               libxcrypt-compat nushell helix
dnf clean all
systemctl --global enable homebrew-bootstrap.service   # Unit + nu-env kommen aus overlay/
```

```bash
# modules/40-kvm-win11.sh  — Dozenten-PC, KI-Workstation
#!/usr/bin/env bash
set -euo pipefail
dnf -y install qemu-kvm libvirt virt-manager virt-install \
               edk2-ovmf swtpm swtpm-tools guestfs-tools
systemctl enable libvirtd.service
dnf clean all
# swtpm + edk2-ovmf sind der Win-11-Kern: UEFI + TPM 2.0. Ohne die beiden kein Win 11.
```

```bash
# modules/20-voice-io.sh  — KI-Workstation, Entw. silverblue
#!/usr/bin/env bash
set -euo pipefail
dnf -y install speech-dispatcher espeak-ng
dnf clean all
# STT/TTS-Engines (whisper.cpp, piper) laufen besser als Laufzeit über brew/pip/flatpak
# statt im Image — dann bleibt das Modul schlank und kernel-unabhängig.
```

Die drei heiklen Module – hier hängst du eigene Quellen ein; die Bezugsstellen musst du selbst prüfen und pinnen:

```bash
# modules/50-nvidia.sh  — KI-Workstation (KERNELMODUL)
#!/usr/bin/env bash
set -euo pipefail
F=$(rpm -E %fedora)
dnf -y install \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${F}.noarch.rpm" \
  "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${F}.noarch.rpm"
dnf -y install akmod-nvidia xorg-x11-drv-nvidia-cuda
dnf clean all
```

> [!warning] NVIDIA ist der aufwändigste Layer
> `akmod-nvidia` baut gegen den exakten Kernel – im Image willst du das **vorgebaut**, nicht erst beim Boot. Bei aktiviertem Secure Boot muss das Modul mit deinem MOK signiert sein. Der robusteste Weg ist, das ublue-akmods-Muster (prebuilt + Signierung) zu übernehmen, statt die Pipeline selbst zusammenzusetzen.

```bash
# modules/30-displaylink.sh  — Dozenten-PC (KERNELMODUL + proprietär)
#!/usr/bin/env bash
set -euo pipefail
# evdi (akmod, kernelgebunden) + proprietärer DisplayLinkManager von Synaptics.
# Beides NICHT in den Fedora-Repos:
#   - evdi: über eine gepflegte COPR beziehen (Slug selbst prüfen/pinnen)
#   - DisplayLinkManager: RPM-URL von Synaptics als Build-Arg reinreichen
dnf -y install "${DISPLAYLINK_RPM_URL:?DISPLAYLINK_RPM_URL setzen}"
dnf clean all
```

> [!warning] DisplayLink ist proprietär
> Der `DisplayLinkManager` liegt nicht in den Fedora-Repos und ist lizenzrechtlich proprietär – ein solches Image gehört **nicht** in ein öffentliches GHCR-Paket. Für interne Nutzung das Paket privat halten und die Zielgeräte per `podman login` authentifizieren.

```bash
# modules/15-noctalia.sh  — Sway-Rollen
#!/usr/bin/env bash
set -euo pipefail
# Noctalia/Quickshell liegen nicht in den Fedora-Repos. Hier deine bereits bewährte
# Methode einhängen (COPR/Build) — die Config selbst kommt über overlay/.
```

### 10.6 Zwei Konsequenzen für deine Geräterollen

Nur **zwei** der vier Images tragen Kernelmodule: der Dozenten-PC (`evdi`) und die KI-Workstation (`nvidia`). Nur diese beiden bauen bei jedem Kernel-Update neu und brauchen ggf. MOK-Signatur. Die beiden Entwickler-Images sind reine Paket-Layer – schnell, robust und öffentlich teilbar. Der Wartungsaufwand konzentriert sich damit auf zwei klar benannte Images.

Und weil Homebrew selbst Laufzeit ist (`/var/home/linuxbrew`), tragen alle vier nur die **Toolchain** im Image – die eigentliche Installation passiert überall gleich per First-Boot-Service. `10-core` und das `overlay/` sind über alle vier Rollen identisch.

> [!tip] Vor jedem neuen Modul: muss es überhaupt ins Image?
> Kann ein Feature Laufzeit sein (Flatpak, pip-venv, brew-Formel, First-Boot-Setup), schrumpft die Matrix weiter. Nur Kernelmodule (NVIDIA, DisplayLink) haben diese Wahl nicht – die müssen zwingend ins Image.

---

## Anhang: Der Lebenszyklus auf einen Blick

```
Quellen (github.com)  ──push──►  GitHub Actions  ──build+sign──►  Image (ghcr.io)
                                                                        │
                                                              bootc switch + reboot
                                                                        ▼
                                                                Zielgerät (aktiv)
                                                                        │
                                                     Test ok? ──ja──► produktiv
                                                          │
                                                         nein
                                                          ▼
                                              bootc rollback + reboot (Ausgangsimage)
```

## Verwandte Notizen

- [[Homebrew auf Fedora Atomic]]
- [[Nushell Env-Konfiguration]]
- [[bootc Grundlagen]]
- [[Coaching Fedora Sway Atomic]]
