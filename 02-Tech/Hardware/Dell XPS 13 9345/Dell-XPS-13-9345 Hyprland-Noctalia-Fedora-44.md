---
title: "Hyprland + Noctalia auf Fedora 44 (aarch64) – Dell XPS 13 9345"
aliases: ["Hyprland Noctalia XPS 9345", "Noctalia aarch64 Fedora"]
tags:
  - linux
  - fedora
  - hyprland
  - noctalia
  - quickshell
  - wayland
  - aarch64
  - dell-xps-9345
device: "Dell XPS 13 9345 (X1E80100, 'tributo')"
basis: "Fedora Workstation 44 (aarch64), Hardware-Enablement abgeschlossen"
created: 2026-06-29
status: draft
verwandt: "[[Fedora-44-Dualboot-Dell-XPS-13-9345]]"
---
> [!info] Worum es hier geht
> Aufsetzen von **Hyprland** (Wayland-Compositor) + **Noctalia** (Desktop-Shell) auf der bereits funktionierenden Fedora-44-Basis aus [[Fedora-44-Dualboot-Dell-XPS-13-9345]]. Der Fokus liegt auf den **aarch64-Besonderheiten** – denn der bequeme x86-Weg funktioniert hier teilweise nicht.

> [!danger] aarch64-Realität – zuerst lesen
> 1. Die populäre **Noctalia-COPR `zhangyi6324/noctalia-shell` ist NICHT für aarch64** gebaut. Nicht verwenden. Wir nehmen Terra oder die manuelle Installation.
> 2. **Hyprland:** Die übliche `solopasha/hyprland`-COPR zielt auf x86. Für ARM gibt es eine dedizierte COPR (`technochip/Hyprland-aarch64`) oder den Quellbau.
> 3. **Noctalia braucht seinen eigenen Quickshell-Fork `noctalia-qs`**, der mit dem normalen `quickshell`-Paket **konfligiert**. Niemals beide gleichzeitig installieren.
> 4. **Noctalia-Version:** v4 ist stabil (Quickshell/Qt6). v5 ist Alpha (nativer Wayland-/OpenGL-ES-Rewrite, ohne Qt) – **noch nicht** für ein Produktiv-Zweitsystem.

> [!note] Die gute Nachricht
> Quickshell und Hyprland laufen auf Fedora-aarch64. Das von Noctalia/Quickshell benötigte **OpenGL-ES-Rendering** wird auf dem X1 Elite von **Turnip/Freedreno** beschleunigt – also genau die GPU-Schicht, die in der Basis bereits funktioniert.

---

## 0. Versionsentscheidung Noctalia

| | v4 (stabil) | v5 (Alpha) |
|---|---|---|
| Unterbau | Quickshell (Qt6/QtQuick) | nativer Wayland + OpenGL ES, **kein** Qt/GTK |
| Reife | produktiv nutzbar | „early/alpha", breaking changes erwartet |
| Empfehlung Zweitsystem | **Ja** | Nein (nur zum Spielen) |

> Dieser Guide nutzt **Noctalia v4**.

---

## 1. Voraussetzungen prüfen

Auf der laufenden Fedora-44-Basis im Terminal:

```bash
# Läuft Wayland?
echo $XDG_SESSION_TYPE          # sollte "wayland" zeigen (egal welche DE)
# GPU-Beschleunigung (Turnip) vorhanden?
sudo dnf install -y vulkan-tools mesa-demos
vulkaninfo | grep -i "deviceName"   # sollte Adreno / Turnip zeigen
glxinfo -B | grep -i "renderer"
```

COPR-Plugin + Basiswerkzeuge:

```bash
sudo dnf install -y dnf-plugins-core git cmake ninja-build gcc gcc-c++
```

---

## 2. Hyprland installieren (aarch64)

> [!warning] F43-Altlast im Blick behalten
> Auf Fedora 43 gab es einen Qt6-Konflikt um `hyprland-qtutils`. Auf F44 vor der Installation kurz gegenprüfen, ob `dnf` sauber auflöst; sonst `--allowerasing` mit Bedacht.

### Variante A – aarch64-COPR (schnellster Weg)

```bash
sudo dnf copr enable technochip/Hyprland-aarch64
sudo dnf install hyprland
```

> [!note] Was das ist
> `technochip/Hyprland-aarch64` ist ein **aarch64-Fork**, der versucht, mit dem Upstream Schritt zu halten, „bis eine offizielle Hyprland-auf-Fedora-Lösung existiert". Heißt: praktikabel, aber kein offizielles Paket – Versionsstand vor dem Einspielen einmal prüfen.

### Variante B – aus dem Quellcode bauen (Fallback)

Wenn die COPR veraltet/kaputt ist (oder du die volle Kontrolle willst):

```bash
# Build-Abhängigkeiten (Auswahl – fehlende per dnf nachziehen)
sudo dnf install -y \
  qt6-qtbase-devel qt6-qtdeclarative-devel \
  wayland-devel wayland-protocols-devel libxkbcommon-devel \
  pixman-devel cairo-devel pango-devel libdrm-devel libinput-devel \
  mesa-libgbm-devel mesa-libEGL-devel mesa-libGLES-devel \
  pkgconf cmake ninja-build gcc-c++ meson

# Hyprland samt Abhängigkeiten (hyprutils, hyprlang, hyprcursor, aquamarine, ...)
# am einfachsten per offizieller Anleitung / hyprwm-Repos bauen.
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install
```

> [!tip] Quellbau auf ARM
> Kompilierzeiten sind auf dem X1 Elite akzeptabel, aber nicht trivial. Plane die Sub-Projekte (`hyprutils`, `hyprlang`, `hyprcursor`, `aquamarine`, `hyprgraphics`) ein – die Reihenfolge steht in der offiziellen Hyprland-Build-Doku.

### Begleitwerkzeuge

```bash
sudo dnf install -y \
  xdg-desktop-portal-hyprland \
  hyprpaper hyprlock hypridle hyprpicker \
  polkit-gnome \
  wl-clipboard grim slurp brightnessctl playerctl pamixer
```

(Bei Variante A liefert die COPR die meisten `hypr*`-Tools mit.)

---

## 3. Quickshell-Runtime für Noctalia (aarch64)

> [!important] noctalia-qs statt quickshell
> Noctalia v4 nutzt den **eigenen Fork `noctalia-qs`**. Dieser **konfligiert** mit einem regulären `quickshell`-Paket. Falls bereits `quickshell`/`quickshell-git` installiert ist, **vorher entfernen**:

```bash
sudo dnf remove quickshell quickshell-git 2>/dev/null || true
```

Den Quickshell-Runtime (`noctalia-qs`) ziehst du am besten **zusammen mit Noctalia** über eine der Methoden in [[Dell-XPS-13-9345 Hyprland-Noctalia-Fedora-44#4. Noctalia installieren (aarch64)]] – `noctalia-shell` zieht `noctalia-qs` als Abhängigkeit nach.

> [!note] Wenn du Quickshell separat brauchst
> Reines Quickshell für aarch64 gibt es u. a. über die COPRs `avengemedia/quickshell` bzw. `errornointernet/quickshell` (beide mit aarch64-Builds nachgewiesen). Für Noctalia ist aber der `noctalia-qs`-Fork der richtige.

---

## 4. Noctalia installieren (aarch64)

> [!danger] Nicht die x86-COPR nehmen
> `sudo dnf copr enable zhangyi6324/noctalia-shell` → **kein aarch64**. Überspringen.

### Variante A – Terra (empfohlen)

Terras Infrastruktur baut für **x86_64 und arm64**.

```bash
# Terra-Repo hinzufügen
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://terra.fyralabs.com/terra.repo
sudo dnf install -y terra-release

# Noctalia (zieht noctalia-qs als Runtime nach)
sudo dnf install -y noctalia-shell
```

> [!warning] arm64-Verfügbarkeit verifizieren
> Terra *kann* arm64, aber nicht jedes Einzelpaket ist immer gebaut. Prüfe vor/nach der Installation:
> ```bash
> dnf info noctalia-shell | grep -i arch     # sollte aarch64 (oder noarch) zeigen
> rpm -q --qf '%{ARCH}\n' noctalia-shell noctalia-qs
> ```
> Liefert Terra kein aarch64 → **Variante B**.

### Variante B – Manuelle Installation (robust für aarch64)

Die Shell selbst ist QML (architekturunabhängig); sie braucht nur den laufenden Quickshell-Fork. Daher:

1. **`noctalia-qs` (Runtime) für aarch64 installieren** – via Terra (`sudo dnf install noctalia-qs`) oder selbst gebaut.
2. **Noctalia-Config einspielen:**

```bash
mkdir -p ~/.config/quickshell/noctalia-shell
curl -sL https://github.com/noctalia-dev/noctalia/releases/latest/download/noctalia-latest.tar.gz \
  | tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell
```

> [!tip] Exakte Entpack-Optionen prüfen
> Der `--strip-components`-Wert bzw. das Zielverzeichnis kann sich je nach Release ändern. Im Zweifel die offizielle Anleitung gegenlesen: <https://docs.noctalia.dev/v4/getting-started/installation/>

> [!warning] Kein Auto-Update
> Die manuelle Methode hat **keinen bequemen Upgrade-Pfad** – bei Updates Tarball neu ziehen.

---

## 5. Hyprland und Noctalia verdrahten

In `~/.config/hypr/hyprland.conf`:

```ini
# Polkit-Agent (für Authentifizierungsdialoge)
exec-once = /usr/libexec/polkit-gnome-authentication-agent-1

# Noctalia-Shell starten
exec-once = qs -c noctalia-shell

# Launcher auf SUPER+D (Noctalias eigener Launcher via IPC)
bind = SUPER, D, exec, qs -c noctalia-shell ipc call launcher toggle
```

> [!note] Aufrufform abhängig von der Installation
> - Paket-/Terra-Installation: `qs -c noctalia-shell` funktioniert i. d. R. direkt.
> - Reine manuelle Ablage unter `~/.config/quickshell/`: ggf. `qs -c noctalia-shell` bzw. `qs ipc ...` – siehe Noctalia-Doc „Running the shell".

> [!important] Redundante Tools abschalten
> Noctalia bringt **eigene** Leiste, Launcher, Notification-Daemon, OSDs, Wallpaper-Manager, Lock-Screen und Session-/Power-Panel mit. Entferne aus deiner bestehenden Hyprland-Config also Doppelungen wie eine separate **Waybar**, einen **wofi-Power-Menü**-Autostart oder einen **swww/hyprpaper**-Daemon, sonst überlagern sie sich.

---

## 6. Display-Manager / Session-Auswahl

> [!warning] Noctalia hat keinen Greeter
> Noctalia kann **GDM/SDDM/greetd nicht ersetzen** – es braucht eine bereits laufende Sitzung. Du behältst also einen Display-Manager.

- Bei Fedora Workstation ist **GDM** vorhanden. Nach der Hyprland-Installation taucht eine **Hyprland-Session** (`/usr/share/wayland-sessions/hyprland.desktop`) auf – beim Login oben rechts auswählen.
- Alternativ schlanker: `greetd` + `tuigreet` (TTY-Greeter).

```bash
# Beispiel: auf greetd umstellen (optional)
sudo dnf install -y greetd greetd-tuigreet
sudo systemctl disable gdm
sudo systemctl enable greetd
# /etc/greetd/config.toml: command = "tuigreet --cmd Hyprland"
```

---

## 7. Schriften & Theming

> [!note] Material Symbols nicht vergessen
> Noctalia/viele Quickshell-Shells nutzen **Material Symbols** als Icon-Font. Ohne die Schrift bleiben Icons leer/„Tofu".

```bash
sudo dnf install -y google-material-icons-fonts || true
# Fallback manuell, falls Paket fehlt:
mkdir -p ~/.local/share/fonts
# Material Symbols TTF in ~/.local/share/fonts/ ablegen, dann:
fc-cache -f
# Nerd Font für Terminal/Statusbar nach Geschmack:
sudo dnf install -y jetbrains-mono-nerd-fonts 2>/dev/null || true
```

Optionales Auto-Theming (Farben aus Wallpaper, falls du es willst):

```bash
sudo dnf copr enable -y heus-sueh/packages
sudo dnf install -y matugen
```

Noctalia bringt zusätzlich ein eigenes **TOML-Konfig + GUI-Settings** mit (Hot-Reload, Theme-/Palette-Templates) – die Feinkonfiguration läuft danach in der Shell selbst.

---

## 8. Integration deiner bestehenden Nushell-Konfiguration

> [!tip] Was du behältst, was Noctalia übernimmt
> - **Noctalia übernimmt:** Bar, Launcher, Notifications, Power-/Session-Menü, OSDs, Wallpaper, Lock-Screen, Clipboard-History, Tray.
> - **Dein `hypr.nu` bleibt sinnvoll für:** Modul-Toggles, Hyprland-spezifische Tweaks (Window-Rules, Workspaces, Keybind-Logik), die Noctalia *nicht* anfasst.
> - **Wahrscheinlich überflüssig:** dein bisheriges **wofi-Power-Menü** und eine separate Statusleiste – diese Funktionen liefert Noctalia.

So vermeidest du Doppelbelegungen: vor dem ersten Noctalia-Start in deiner modularen Config die entsprechenden Module (eigene Bar, Power-Menü) deaktivieren statt löschen, damit du sie bei Bedarf zurückholen kannst.

---

## 9. Bekannte Stolpersteine (aarch64-spezifisch)

> [!warning] Punkte, die erfahrungsgemäß haken
> - **COPR-Architektur:** Immer prüfen, ob ein Paket wirklich `aarch64` liefert (`rpm -q --qf '%{ARCH}\n' …`). Viele „Standard"-Hypr-/Quickshell-COPRs sind x86-only.
> - **Qt6-Konflikte:** `hyprland-qtutils` vs. Qt6 hatte auf F43 Ärger gemacht; bei `dnf`-Auflösungsproblemen genau lesen, bevor du `--allowerasing` nutzt.
> - **quickshell vs. noctalia-qs:** Nie beide installiert haben – sonst startet Noctalia mit der falschen Runtime.
> - **Noctalia v5 (Alpha):** Reizvoll (kein Qt), aber instabil – für das Zweitsystem bei **v4** bleiben.
> - **Rendering:** Läuft über OpenGL ES → hängt an Turnip. Falls die Shell schwarz/leer bleibt, zuerst GPU-Beschleunigung gegenprüfen (Abschnitt 1).

> [!note] Ehrliche Alternative, falls aarch64-Noctalia zickt
> **DankMaterialShell (DMS)** ist ebenfalls Quickshell-basiert, hat **arm64-Pakete** (COPRs `avengemedia/dms`, `avengemedia/quickshell`) **und** einen eigenen Greeter. Wenn die Noctalia-arm64-Pakete gerade nicht sauber bauen, ist DMS der reibungsärmere Quickshell-Shell auf ARM – optisch ähnlich (Material 3).

---

## 10. Reihenfolge zum Mitnehmen

1. Voraussetzungen prüfen (Wayland, Turnip).
2. Hyprland: COPR (aarch64) **oder** Quellbau + Begleittools.
3. Ggf. `quickshell` entfernen.
4. Noctalia: Terra (arm64 verifizieren) **oder** manuell + `noctalia-qs`.
5. `hyprland.conf`: Noctalia autostarten, Launcher-Bind, Doppel-Tools raus.
6. Session über GDM/greetd wählen.
7. Material-Symbols-Font + Theming.
8. `hypr.nu` entschlacken (Bar/Power-Menü an Noctalia abgeben).

---

# Quellen

- Noctalia – GitHub (Architektur, v5-Alpha-Hinweis): <https://github.com/noctalia-dev/noctalia>
- Noctalia v4 – Installation (Terra, manuell, noctalia-qs-Konflikt): <https://docs.noctalia.dev/v4/getting-started/installation/>
- Noctalia v4 – Running the shell (Aufrufformen): <https://docs.noctalia.dev/v4/getting-started/running-the-shell/>
- Terra / Fyra Wiki (x86_64 + arm64): <https://wiki.fyralabs.com/Terra>
- Hyprland aarch64 COPR: <https://copr.fedorainfracloud.org/coprs/technochip/Hyprland-aarch64/>
- solopasha/hyprland COPR (x86, Begleittool-Referenz): <https://copr.fedorainfracloud.org/coprs/solopasha/>
- Hyprland Build-Doku: <https://wiki.hypr.land/>
- DankMaterialShell / dankinstall (arm64-Alternative): <https://danklinux.com/docs/dankinstall>
