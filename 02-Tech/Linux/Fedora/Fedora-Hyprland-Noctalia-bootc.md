---
title: "Fedora + Hyprland + Noctalia als bootc Custom Image"
aliases: ["bootc Hyprland Spin", "fedora-hyprland-noctalia"]
tags: [linux, fedora, bootc, hyprland, noctalia, wayland, devops, immutable]
created: 2026-07-07
status: draft
compositor: hyprland
shell: noctalia
base_image: quay.io/fedora/fedora-bootc:43
---

# Fedora + Hyprland + Noctalia als bootc Custom Image

> [!abstract] Ziel
> Ein **teilbares, reproduzierbares** Fedora-Image, das Hyprland (Compositor) und Noctalia (Wayland-Shell) mitbringt — deklarativ als OCI-Image gebaut, per GitHub Actions in eine Registry gepusht und als ISO/qcow2 installierbar. Das ist der moderne, GitOps-taugliche Ersatz für einen klassischen Kickstart-Spin. Weil Noctalia **nicht** in den Fedora-Repos liegt, ist das formal ein *Fedora Remix*, kein offizieller Spin — siehe [[#8 Rechtliches Remix statt Spin]].

> [!info] Mentale Modelle
> - **Base-Image** = das nackte bootable Fedora (kein Desktop).
> - **Containerfile** = deine Blaupause (wie ein Dockerfile, nur baut es ein OS).
> - `/usr` ist **read-only** zur Laufzeit. Alles Systemweite wird zur *Build-Zeit* ins Image gebacken.
> - Updates kommen als neues Image-Layer → `bootc upgrade` → Reboot → atomarer Wechsel, jederzeit per Rollback zurück.

---

## 0 Voraussetzungen

> [!note] Auf deinem CachyOS-Host
> Du brauchst nur `podman`. Kein Fedora nötig zum Bauen — der Build läuft im Container.
> ```nu
> # Nushell / CachyOS
> sudo pacman -S podman
> # Für ISO-Erzeugung zusätzlich qemu (zum Testen der VM)
> sudo pacman -S qemu-full
> ```

> [!warning] Kernel-Fallstrick
> Der Kernel im gebauten Image ist **nicht** der Host-Kernel. `podman build` teilt sich den Host-Kernel nur *während* des Builds. Deshalb keine `sysctl`-Live-Änderungen im Containerfile — immer als Konfig-Datei nach `/usr/lib/sysctl.d/` schreiben.

---

## 1 Projektstruktur

```
fedora-hyprland-noctalia/
├── Containerfile              # die OS-Definition
├── config.toml                # User/Installer-Customizing für bootc-image-builder
├── files/
│   ├── etc/
│   │   ├── skel/.config/hypr/         # Default-Hyprland-Config für neue User
│   │   └── greetd/config.toml         # Login-Manager
│   └── usr/
│       └── share/noctalia/            # Noctalia-Assets (Build-Zeit reingelegt)
└── .github/
    └── workflows/
        └── build.yml          # CI: baut + pusht nach ghcr.io
```

> [!tip] Obsidian-Workflow
> Leg das Repo als eigenen Vault-Ordner an. Deine Hyprland-Dotfiles (inkl. `hypr.nu`-Modulverwaltung) versionierst du direkt unter `files/etc/skel/.config/hypr/` — dann landen sie bei *jedem* frisch installierten Rechner konsistent. Siehe [[Hyprland Config Notizen]].

---

## 2 Das Containerfile (voll kommentiert)

> [!example] `Containerfile`
> ```dockerfile
> # ─────────────────────────────────────────────────────────────
> #  Fedora bootc Base-Image. :43 = aktuelle Fedora-Version.
> #  fedora-bootc bringt Kernel, systemd, dnf und bootc mit,
> #  aber KEINEN Desktop.
> # ─────────────────────────────────────────────────────────────
> FROM quay.io/fedora/fedora-bootc:43
>
> # COPR-Repos als Build-Argumente, damit sie leicht austauschbar sind.
> # Hyprland ist in F43 NICHT zuverlässig in den offiziellen Repos ->
> # deshalb ein COPR. Prüfe den aktuellen Anbieter, bevor du baust!
> ARG HYPR_COPR="solopasha/hyprland"
> # Quickshell (Runtime für Noctalia v4). Ebenfalls per COPR.
> ARG QS_COPR="errornointernet/quickshell"
> # Noctalia-Release, das ins Image gebacken wird (Tag anpassen).
> ARG NOCTALIA_REF="v4"
>
> # ─────────────────────────────────────────────────────────────
> #  Bekannte bootc-Vorbereitungen:
> #  - /var/roothome muss existieren, sonst scheitern manche
> #    Paketinstallationen.
> #  - /opt ist im laufenden System immutable; wer spaeter (Day-2)
> #    dorthin installiert, verlinkt es nach /var/opt.
> # ─────────────────────────────────────────────────────────────
> RUN mkdir -p /var/roothome && \
>     rm -rf /opt && ln -s /var/opt /opt
>
> # ─────────────────────────────────────────────────────────────
> #  Paketinstallation. Ein einziges RUN pro logischer Einheit
> #  haelt die Layer schlank. dnf clean am Ende spart Platz.
> # ─────────────────────────────────────────────────────────────
> RUN dnf -y install dnf-plugins-core && \
>     # COPRs aktivieren
>     dnf -y copr enable ${HYPR_COPR} && \
>     dnf -y copr enable ${QS_COPR} && \
>     dnf -y install \
>         # --- Compositor + Hyprland-Oekosystem ---
>         hyprland \
>         xdg-desktop-portal-hyprland \
>         hyprlock hypridle \
>         # --- Wayland-Grundausstattung ---
>         qt6-qtwayland \
>         qt6-qt5compat \
>         quickshell \
>         # --- Login-Manager (leichtgewichtig, tty-basiert) ---
>         greetd \
>         # --- Terminal, Audio, Portale, Fonts, Tools ---
>         kitty \
>         pipewire wireplumber pipewire-pulseaudio \
>         xdg-desktop-portal xdg-desktop-portal-gtk \
>         polkit \
>         NetworkManager \
>         brightnessctl playerctl \
>         google-noto-emoji-fonts jetbrains-mono-fonts \
>         # --- deine Shell + Editor-Praeferenzen ---
>         nushell helix git \
>     && dnf clean all
>
> # ─────────────────────────────────────────────────────────────
> #  Noctalia einbacken.
> #  Noctalia liegt NICHT in Fedora -> wir holen das Release-Tarball
> #  zur Build-Zeit und legen es systemweit unter /usr/share ab.
> #  Neue User bekommen es via /etc/skel (siehe COPY weiter unten).
> #
> #  HINWEIS v4 vs v5:
> #   - v4 = Quickshell-Config -> nach ~/.config/quickshell/noctalia-shell
> #          Start: qs -c noctalia-shell
> #   - v5 = eigenstaendige Wayland-Shell (Beta) -> eigenes Binary
> #  Passe den Block an die gewaehlte Version an.
> # ─────────────────────────────────────────────────────────────
> RUN curl -fsSL \
>       "https://github.com/noctalia-dev/noctalia-shell/archive/refs/tags/${NOCTALIA_REF}.tar.gz" \
>       -o /tmp/noctalia.tar.gz && \
>     mkdir -p /usr/share/noctalia && \
>     tar -xzf /tmp/noctalia.tar.gz --strip-components=1 -C /usr/share/noctalia && \
>     rm -f /tmp/noctalia.tar.gz
>
> # ─────────────────────────────────────────────────────────────
> #  Systemweite Konfig + Defaults fuer neue User einspielen.
> #  Alles unter files/ wird 1:1 ins Image kopiert.
> #   - /etc/skel/... : Vorlage, die beim User-Anlegen kopiert wird
> #   - /etc/greetd/  : Login-Manager-Konfig
> # ─────────────────────────────────────────────────────────────
> COPY files/ /
>
> # Noctalia-Config als Skel bereitstellen (v4-Beispiel):
> RUN mkdir -p /etc/skel/.config/quickshell && \
>     ln -sfn /usr/share/noctalia /etc/skel/.config/quickshell/noctalia-shell
>
> # ─────────────────────────────────────────────────────────────
> #  Dienste aktivieren. In der Container-Build-Umgebung laeuft
> #  kein systemd -> nur 'enable', kein 'start'.
> # ─────────────────────────────────────────────────────────────
> RUN systemctl enable greetd.service NetworkManager.service
>
> # ─────────────────────────────────────────────────────────────
> #  Pflicht-Abschluss: bootc-Lint. Prueft das Image auf typische
> #  Fehler (falsche /var-Nutzung, fehlende Bootloader-Bits ...).
> #  Bricht den Build bei Problemen ab.
> # ─────────────────────────────────────────────────────────────
> RUN bootc container lint
> ```

> [!warning] COPR-Namen sind Platzhalter
> `solopasha/hyprland` und `errornointernet/quickshell` sind gaengige, aber **community-gepflegte** COPRs. Prüfe vor dem produktiven Build unter `copr.fedorainfracloud.org`, ob sie aktuell und für Fedora 43 gebaut sind. Für maximale Kontrolle: eigenes COPR aus Upstream-Spec forken (dann hängst du nicht an Dritten).

---

## 3 Login-Manager (greetd) einrichten

> [!example] `files/etc/greetd/config.toml`
> ```toml
> # greetd startet nach Login direkt eine Hyprland-Session,
> # in deren Autostart wiederum Noctalia geladen wird.
> [terminal]
> vt = 1
>
> [default_session]
> # tuigreet = schlanker TUI-Login. Alternativ SDDM, wenn du GUI willst.
> command = "Hyprland"
> user = "greeter"
> ```

> [!tip] Noctalia-Autostart in Hyprland
> In deiner `hypr.nu`-generierten Config (bzw. `hyprland.conf`) die Shell starten:
> ```conf
> # v4 (Quickshell):
> exec-once = qs -c noctalia-shell
> # v5 (Beta, eigenes Binary):
> # exec-once = noctalia --daemon
> ```

---

## 4 Lokal bauen & testen

```nu
# Image bauen (Tag frei waehlbar)
sudo podman build -t localhost/fedora-hyprland-noctalia:latest .

# Schnell-Check: reinschauen ohne Installation
sudo podman run --rm -it localhost/fedora-hyprland-noctalia:latest /bin/bash
```

> [!note] Warum `sudo podman`?
> bootc-Images enthalten SELinux-Labels und System-Bits, die rootful sauberer verarbeitet werden. Für reine App-Container wäre rootless okay — hier nicht.

---

## 5 Installierbares Medium erzeugen (bootc-image-builder)

> [!info] Was `bootc-image-builder` kann
> Nimmt dein OCI-Image und gibt `iso`, `qcow2`, `raw`, `vmdk`, `ami` u. a. aus. Für „an Freunde/Kurs verteilen" willst du meist die **anaconda-iso**.

```nu
# Ausgabeordner anlegen
mkdir -p ./output

# ISO bauen. --type anaconda-iso erzeugt einen unattended-Installer.
sudo podman run --rm -it --privileged \
    --security-opt label=type:unconfined_t \
    -v ./output:/output \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    -v ./config.toml:/config.toml:ro \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type anaconda-iso \
    --local \
    localhost/fedora-hyprland-noctalia:latest
```

> [!warning] Architektur muss matchen
> Der `bootc-image-builder`-Tag und dein Base-Image müssen dieselbe Architektur haben (x86_64 ↔ x86_64). Für ARM64 den passenden BIB-Tag nehmen.

---

## 6 User & Installer vorkonfigurieren (`config.toml`)

> [!example] `config.toml`
> ```toml
> # Wird von bootc-image-builder gelesen. Legt einen Default-User an,
> # damit die frische Installation direkt nutzbar ist.
> [[customizations.user]]
> name = "fritz"
> # Passwort-Hash erzeugen: mkpasswd --method=SHA-512
> password = "$6$...HASH..."
> groups = ["wheel"]
>
> # Optional: Kickstart-Feinsteuerung fuer den Anaconda-Installer
> [customizations.installer.kickstart]
> contents = """
> # Automatische Partitionierung auf erster Platte
> clearpart --all --initlabel --disklabel=gpt
> reqpart --add-boot
> part / --grow --fstype xfs
> services --enabled=greetd,NetworkManager
> """
> ```

> [!note] bootc-Images haben keinen Default-User
> Anders als Fedora CoreOS (`core`) gibt es hier standardmäßig nur `root`. Ohne User in `config.toml` oder Kickstart landest du auf einem Login ohne Konto.

---

## 7 CI: Automatisch bauen & teilen (GitHub Actions)

> [!abstract] Der eigentliche „mit der Community teilen"-Schritt
> Push nach `ghcr.io`. Nutzer machen dann einfach `bootc switch ghcr.io/<user>/fedora-hyprland-noctalia:latest` und bekommen dein OS deklarativ. Updates zieht ihr System per Timer automatisch.

> [!example] `.github/workflows/build.yml`
> ```yaml
> name: build-bootc-image
>
> on:
>   push:
>     branches: [main]
>   schedule:
>     # woechentlich neu bauen -> zieht Fedora-Updates automatisch nach
>     - cron: "0 6 * * 1"
>   workflow_dispatch:   # manueller Trigger-Button
>
> env:
>   IMAGE: ghcr.io/${{ github.repository_owner }}/fedora-hyprland-noctalia
>
> jobs:
>   build:
>     runs-on: ubuntu-latest
>     permissions:
>       contents: read
>       packages: write   # noetig fuer ghcr.io-Push
>     steps:
>       - uses: actions/checkout@v4
>
>       - name: Build image
>         run: |
>           podman build -t ${IMAGE}:latest .
>
>       - name: Log in to ghcr.io
>         run: |
>           echo "${{ secrets.GITHUB_TOKEN }}" | \
>             podman login ghcr.io -u ${{ github.actor }} --password-stdin
>
>       - name: Push
>         run: |
>           podman push ${IMAGE}:latest
>           # optional: zusaetzlich mit Datum taggen
>           podman tag ${IMAGE}:latest ${IMAGE}:$(date +%Y%m%d)
>           podman push ${IMAGE}:$(date +%Y%m%d)
> ```

> [!tip] Signieren (uBlue-Stil, empfohlen)
> Für ein „echtes" verteilbares Image signierst du mit `cosign` und legst die Public Key + eine `containers-policy`-Ergänzung ins Image, damit `bootc upgrade` die Signatur prüft. So macht es Universal Blue / Bluefin. Details: [[bootc Image Signing mit cosign]].

---

## 8 Rechtliches: Remix statt Spin

> [!warning] Kein offizielles Fedora-Branding
> Weil Noctalia (und ggf. das Hyprland-COPR) **außerhalb** der offiziellen Fedora-Repos liegt, kann das kein offizieller *Spin* sein. Es ist ein **Fedora Remix**:
> - Fedora-Logo/-Wortmarke nicht wie beim offiziellen Spin verwenden.
> - Remix-Trademark-Richtlinien beachten (eigener Name, klare Kennzeichnung als „nicht offiziell").
> - Verteilen/Forken ist ausdrücklich erlaubt.
>
> Sobald Noctalia *in* Fedora paketiert wäre, stünde der Weg zum offiziellen Spin (Spins SIG, Council-Freigabe) offen.

---

## 9 Day-2: Als Nutzer installieren & updaten

```nu
# Von einem laufenden Fedora/Live-System auf Platte installieren:
sudo bootc install to-disk /dev/nvme0n1
# (oder ISO aus Schritt 5 booten und Anaconda folgen)

# Spaeter updaten -> holt neues Image-Layer, Reboot wechselt atomar:
sudo bootc upgrade
sudo systemctl reboot

# Bei Problemen: Rollback auf vorheriges Deployment
sudo bootc rollback
```

> [!tip] Pakete testen ohne Rebuild
> `bootc usr-overlay` legt ein transientes Overlay über das read-only `/usr`. Dort kannst du testweise `dnf install` machen; beim Reboot ist alles wieder weg. Was sich bewährt, wandert dann fest ins Containerfile.

---

## 10 Nächste Schritte / TODO

- [ ] COPR-Quellen final verifizieren (Hyprland, Quickshell für F43)
- [ ] Entscheidung Noctalia **v4 (Quickshell)** vs **v5 (Beta-Binary)**
- [ ] `files/etc/skel/.config/hypr/` mit `hypr.nu`-Setup befüllen
- [ ] `config.toml`: echten Passwort-Hash setzen
- [ ] cosign-Signierung ergänzen
- [ ] ISO in QEMU testbooten, Login → Hyprland → Noctalia prüfen

## Verwandte Notizen
- [[Hyprland Config Notizen]]
- [[CachyOS Setup]]
- [[bootc Image Signing mit cosign]]
- [[Fedora Spin vs Remix]]
