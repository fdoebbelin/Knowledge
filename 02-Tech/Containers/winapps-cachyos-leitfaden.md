# WinApps auf CachyOS – Detaillierter Leitfaden
## Windows-Anwendungen nahtlos im Linux-Desktop

> **Zielgruppe:** CachyOS-Nutzer mit einer bereits funktionierenden Windows-VM in KVM/QEMU, die einzelne Windows-Anwendungen wie native Linux-Fenster nutzen möchten.
> **Stand:** April 2026 | WinApps (winapps-org Fork) | FreeRDP 3.x | CachyOS (Arch-basiert)

---

## Inhaltsverzeichnis

1. [Was WinApps ist – und was nicht](#1-was-winapps-ist--und-was-nicht)
2. [WinApps vs. WinBoat – warum diese Wahl](#2-winapps-vs-winboat--warum-diese-wahl)
3. [Voraussetzungen prüfen](#3-voraussetzungen-prüfen)
4. [Schritt 1: Bestehende VM für WinApps vorbereiten](#4-schritt-1-bestehende-vm-für-winapps-vorbereiten)
5. [Schritt 2: Windows-seitige Konfiguration](#5-schritt-2-windows-seitige-konfiguration)
6. [Schritt 3: Pakete auf CachyOS installieren](#6-schritt-3-pakete-auf-cachyos-installieren)
7. [Schritt 4: WinApps-Konfigurationsdatei erstellen](#7-schritt-4-winapps-konfigurationsdatei-erstellen)
8. [Schritt 5: FreeRDP-Verbindung testen](#8-schritt-5-freerdp-verbindung-testen)
9. [Schritt 6: WinApps-Installer ausführen](#9-schritt-6-winapps-installer-ausführen)
10. [Schritt 7: WinApps Launcher (optional)](#10-schritt-7-winapps-launcher-optional)
11. [Eigene Anwendungen hinzufügen](#11-eigene-anwendungen-hinzufügen)
12. [Typische Fehler und Lösungen](#12-typische-fehler-und-lösungen)
13. [Befehlsreferenz](#13-befehlsreferenz)
14. [Anhang: Konfigurationsdatei mit Erklärungen](#14-anhang-konfigurationsdatei-mit-erklärungen)

---

## 1. Was WinApps ist – und was nicht

WinApps ist **kein Hypervisor**, **kein Wine-Ersatz** und **keine Emulation**. Es ist ein cleveres Bash-Skript, das mehrere bewährte Komponenten verbindet:

```
Linux-Desktop                        Windows-VM
┌─────────────┐    FreeRDP +        ┌──────────────┐
│ winapps     │    RemoteApp        │ Windows 11   │
│ excel.exe   ├────────────────────►│ Excel läuft  │
│             │   (RDP-Protokoll)   │ als Fenster  │
└─────────────┘                     └──────────────┘
       │
       │ Anwendungs-Erkennung über RDP
       │ Icons in Linux-Menü (KDE/GNOME/XFCE)
       │ Home-Verzeichnis als \\tsclient\home gemountet
       ▼
  Native Linux-Fenster
```

### So funktioniert es

WinApps verbindet sich per RDP mit der Windows-VM, scannt installierte Anwendungen über die Registry, erstellt Linux-Desktop-Verknüpfungen für sie und nutzt Microsofts **RemoteApp**-Funktion (Teil von RDP), um einzelne Anwendungsfenster zu projizieren – nicht den ganzen Windows-Desktop.

Das Ergebnis: Excel öffnet sich als reguläres Fenster auf deinem KDE/GNOME-Desktop, mit eigenem Eintrag in der Taskleiste, eigenen Dateizuordnungen, und der Linux-Home-Ordner ist im Windows-Datei-Explorer als Netzlaufwerk sichtbar.

### Was WinApps **nicht** ist

- **Kein Wine-Ersatz** – Wine versucht, Windows-APIs auf Linux zu reimplementieren. WinApps führt echtes Windows aus. 100% Kompatibilität, aber ein laufendes Windows nötig.
- **Kein eigener Hypervisor** – die VM wird mit deinem bestehenden libvirt/Docker/Podman betrieben.
- **Keine Spiele-Lösung** – Spiele mit Kernel-Anti-Cheat (Vanguard etc.) blockieren Virtualisierung; WinApps hilft hier nicht.
- **Kein Wundermittel** – du brauchst eine gültige Windows-Lizenz und eine **Pro-, Enterprise- oder Server-Edition** (Windows Home unterstützt kein RDP).

---

## 2. WinApps vs. WinBoat – warum diese Wahl

| Aspekt | WinApps | WinBoat |
|---|---|---|
| **Reife** | Seit 2020 entwickelt, aktiver Hard-Fork (winapps-org) | Beta, Version 0.9.x, ca. 6 Monate alt |
| **Backend** | libvirt, Docker oder Podman – frei wählbar | Docker oder Podman (Container nötig) |
| **VM-Quelle** | Bestehende VM nutzbar | Eigener Container, eigene Windows-Installation |
| **Konfiguration** | Manuell (Bash-Config + Registry) | GUI-Wrapper |
| **Linux-Integration** | Echte Desktop-Einträge im Systemmenü | Apps in eigener WinBoat-GUI |
| **Performance** | Direkter KVM-Zugriff – keine Container-Schicht | Container-Overhead über KVM |
| **Anpassbarkeit** | Hoch (GPU-Passthrough, CPU-Pinning, eigene XML) | Begrenzt durch GUI |

**Für deinen Fall ist WinApps die richtige Wahl**, weil:
- Du hast bereits eine **stabile, optimierte libvirt-VM** – keine Notwendigkeit, sie zu duplizieren
- Du brauchst **keinen zweiten Windows-Install** und keine zusätzlichen Lizenzen
- Du behältst die **volle Kontrolle** über die VM (Snapshots, virt-manager, GPU-Passthrough)
- Die Anwendungen erscheinen **direkt im KDE-/GNOME-Menü**, nicht in einem extra Programmfenster

---

## 3. Voraussetzungen prüfen

### 3.1 Windows-Edition

WinApps benötigt **Windows 10/11 Pro, Enterprise oder Server** – Windows Home unterstützt kein eingehendes RDP und scheidet aus.

In der VM prüfen:

```powershell
# In PowerShell auf Windows
Get-ComputerInfo | Select-Object WindowsProductName
```

Mögliche Ausgabe: `Windows 11 Pro` ✓ – `Windows 11 Home` ✗

### 3.2 Bestehende VM-Konfiguration

Prüfen, ob deine VM die nötigen Voraussetzungen hat:

```bash
# VM-Liste anzeigen
virsh list --all

# XML-Konfiguration deiner VM ansehen (Name anpassen)
virsh dumpxml meine-windows-vm | less
```

Wichtige Punkte:
- VM läuft mit `<domain type="kvm">` ✓
- Netzwerk auf NAT (`<source network="default"/>`) ✓
- VirtIO-Treiber installiert (idealerweise) ✓

### 3.3 Benutzergruppen prüfen

```bash
groups $USER
```

Erwartete Gruppen: `kvm`, `libvirt`. Falls nicht enthalten:

```bash
sudo usermod -a -G kvm $USER
sudo usermod -a -G libvirt $USER
# Danach abmelden/anmelden oder Reboot
```

### 3.4 Libvirt-URI setzen

WinApps erwartet, dass libvirt im Systemmodus angesprochen wird:

```bash
echo 'export LIBVIRT_DEFAULT_URI="qemu:///system"' >> ~/.bashrc
```

Falls WinApps die VM trotzdem nicht erkennt, zusätzlich systemweit setzen:

```bash
echo 'LIBVIRT_DEFAULT_URI="qemu:///system"' | sudo tee -a /etc/environment
```

---

## 4. Schritt 1: Bestehende VM für WinApps vorbereiten

Da du bereits eine funktionierende Windows-VM hast, sind nur einige gezielte Anpassungen nötig.

### 4.1 VM-Name prüfen oder setzen

WinApps erwartet standardmäßig den VM-Namen `RDPWindows`. Du kannst entweder:

**Option A:** Den VM-Namen im Konfigurationsfile später setzen (empfohlen für bestehende VMs).

**Option B:** Die VM umbenennen (komplizierter, nur wenn du den Standard willst):

```bash
# VM stoppen
virsh shutdown meine-windows-vm

# Umbenennen über XML-Export
virsh dumpxml meine-windows-vm > /tmp/vm.xml
virsh undefine meine-windows-vm --keep-nvram
sed -i 's|<name>meine-windows-vm</name>|<name>RDPWindows</name>|' /tmp/vm.xml
virsh define /tmp/vm.xml
```

### 4.2 QEMU Guest Agent in der XML konfigurieren

Damit Linux mit Windows kommunizieren kann (z. B. um die VM-IP zu erfragen), braucht die VM einen Guest-Agent-Kanal. Prüfen:

```bash
virsh dumpxml meine-windows-vm | grep -A3 'guest_agent'
```

Wenn nichts ausgegeben wird, fehlt der Kanal. XML bearbeiten:

```bash
virsh edit meine-windows-vm
```

Im `<devices>`-Block folgenden Eintrag ergänzen:

```xml
<channel type='unix'>
  <source mode='bind'/>
  <target type='virtio' name='org.qemu.guest_agent.0'/>
  <address type='virtio-serial' controller='0' bus='0' port='2'/>
</channel>
```

### 4.3 Hyper-V-Enlightenments (Performance-Tuning)

Für die beste RDP-Performance unter Windows. Im `<features>`-Block ergänzen oder erweitern:

```xml
<hyperv mode="custom">
  <relaxed state="on"/>
  <vapic state="on"/>
  <spinlocks state="on" retries="8191"/>
  <vpindex state="on"/>
  <synic state="on"/>
  <stimer state="on">
    <direct state="on"/>
  </stimer>
  <reset state="on"/>
  <frequencies state="on"/>
  <reenlightenment state="on"/>
  <tlbflush state="on"/>
  <ipi state="on"/>
</hyperv>
```

Diese Einstellungen lassen Windows annehmen, es laufe auf einem Hyper-V-kompatiblen Hypervisor – KVM kann dann paravirtualisierte Schnittstellen nutzen, was die Performance spürbar verbessert.

### 4.4 Clock-Konfiguration (idle CPU)

Reduziert die Leerlauf-CPU-Last der VM erheblich:

```xml
<clock offset='localtime'>
  <timer name='rtc' present='no' tickpolicy='catchup'/>
  <timer name='pit' present='no' tickpolicy='delay'/>
  <timer name='hpet' present='no'/>
  <timer name='kvmclock' present='no'/>
  <timer name='hypervclock' present='yes'/>
</clock>
```

### 4.5 VM starten und prüfen

```bash
virsh start meine-windows-vm
virsh list  # Sollte 'running' zeigen
```

---

## 5. Schritt 2: Windows-seitige Konfiguration

Die VM muss innerhalb von Windows einige Vorbereitungen erhalten, damit WinApps funktioniert.

### 5.1 VirtIO-Treiber sicherstellen

Falls noch nicht geschehen, VirtIO-Treiber installieren. Im Browser der VM:

```
https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso
```

ISO mounten (über virt-manager als CD-ROM hinzufügen) und `virtio-win-guest-tools.exe` ausführen. Das installiert alle paravirtualisierten Treiber **plus** den QEMU Guest Agent.

### 5.2 QEMU Guest Agent prüfen

In Windows PowerShell (als Administrator):

```powershell
Get-Service QEMU-GA
```

Erwartete Ausgabe:
```
Status   Name               DisplayName
------   ----               -----------
Running  QEMU-GA            QEMU Guest Agent
```

Auf dem Linux-Host testen, ob die Kommunikation funktioniert:

```bash
virsh qemu-agent-command meine-windows-vm '{"execute":"guest-get-osinfo"}' --pretty
```

Erwartete Ausgabe (gekürzt):
```json
{
  "return": {
    "name": "Microsoft Windows",
    "version": "Microsoft Windows 11",
    "pretty-name": "Windows 11 Pro",
    "id": "mswindows"
  }
}
```

Funktioniert das nicht, ist der Guest-Agent-Kanal in der VM-XML nicht korrekt eingerichtet (siehe 4.2).

### 5.3 RDP aktivieren

In Windows: **Einstellungen → System → Remotedesktop → Aktivieren**.

Sicherstellen, dass dein Windows-Benutzer in der Gruppe **"Remotedesktopbenutzer"** ist (Administrator-Konten sind das automatisch).

### 5.4 RemoteApp-Registry-Tweaks anwenden

Damit Windows einzelne Anwendungen statt des kompletten Desktops über RDP ausgibt, sind Registry-Änderungen nötig. WinApps liefert die nötigen Dateien:

In der Windows-VM herunterladen:

1. **RDPApps.reg** – Registry-Einträge für RemoteApp:
   ```
   https://github.com/winapps-org/winapps/raw/main/oem/RDPApps.reg
   ```

2. **install.bat** – Hilfsskript, das alles einspielt:
   ```
   https://github.com/winapps-org/winapps/raw/main/oem/install.bat
   ```

3. **TimeSync.ps1** – Automatische Zeit-Synchronisation:
   ```
   https://github.com/winapps-org/winapps/raw/main/oem/TimeSync.ps1
   ```

4. **NetProfileCleanup.ps1** – Netzwerk-Profil-Bereinigung (vermeidet "öffentliche Netzwerk"-Probleme):
   ```
   https://github.com/winapps-org/winapps/raw/main/oem/NetProfileCleanup.ps1
   ```

> **Wichtig:** Lade die Dateien einzeln per Rechtsklick auf den `Raw`-Button → "Ziel speichern unter" herunter. Lade NICHT `Container.reg` herunter – das ist nur für Docker/Podman-Backends.

Alle vier Dateien in einen Ordner legen, dann **Rechtsklick auf `install.bat` → "Als Administrator ausführen"**.

### 5.5 Windows-VM neu starten

```powershell
Restart-Computer
```

Nach dem Neustart **NICHT einloggen** – die VM muss am Login-Screen stehen, wenn der WinApps-Installer sie scannt.

---

## 6. Schritt 3: Pakete auf CachyOS installieren

Auf der CachyOS-Seite die nötigen Werkzeuge installieren:

```bash
sudo pacman -Syu --needed curl dialog freerdp git iproute2 libnotify openbsd-netcat
```

Erklärung der Pakete:
- **`freerdp`** – das Herzstück, RDP-Client mit RemoteApp-Unterstützung (Version 3 erforderlich, in CachyOS aktuell)
- **`dialog`** – TUI für den WinApps-Installer
- **`libnotify`** – Desktop-Benachrichtigungen während der Installation
- **`openbsd-netcat`** – Port-Tests gegen die VM
- **`curl`, `git`, `iproute2`** – Standard-Werkzeuge

FreeRDP-Version prüfen:

```bash
xfreerdp3 --version
# oder älter:
xfreerdp --version
```

Erwartete Ausgabe: `FreeRDP 3.x.x` – Version 3 ist Pflicht.

---

## 7. Schritt 4: WinApps-Konfigurationsdatei erstellen

Die zentrale Konfiguration liegt in `~/.config/winapps/winapps.conf`.

```bash
mkdir -p ~/.config/winapps
nano ~/.config/winapps/winapps.conf
```

Minimal-Konfiguration für deinen libvirt-Fall:

```bash
##################################
#   WINAPPS CONFIGURATION FILE   #
##################################

# Windows-Anmeldedaten
RDP_USER="DeinWindowsBenutzer"
RDP_PASS="DeinWindowsPasswort"

# IP wird bei libvirt automatisch ermittelt – leer lassen
RDP_IP=""

# Name der VM in libvirt – muss zur tatsächlichen VM passen
VM_NAME="meine-windows-vm"

# Backend: libvirt (wichtig!)
WAFLAVOR="libvirt"

# Skalierung für hochauflösende Displays (100/140/180)
RDP_SCALE="100"

# FreeRDP-Standard-Flags (Sound, Mikrofon, Home-Verzeichnis)
RDP_FLAGS="/cert:tofu /sound /microphone +home-drive"

# Debug-Logs
DEBUG="true"

# Auto-Pause der VM bei Inaktivität (off/on)
AUTOPAUSE="off"
AUTOPAUSE_TIME="300"
```

> **Sicherheit:** Das Passwort steht im Klartext in der Datei. Berechtigungen einschränken:
> ```bash
> chmod 600 ~/.config/winapps/winapps.conf
> ```

### 7.1 Passwort über externes Kommando (KDE Wallet)

Wenn du das Passwort nicht im Klartext speichern willst, kannst du `RDP_ASKPASS` verwenden:

```bash
RDP_PASS=""
RDP_ASKPASS="bash -c 'kwallet-query --folder winapps --read-password rdp kdewallet'"
```

Vorher das Passwort in KWallet ablegen:

```bash
kwallet-query --folder winapps --write-password rdp kdewallet
# Eingabeaufforderung erscheint
```

Bei GNOME funktioniert analog `secret-tool`:

```bash
secret-tool store --label="WinApps" service winapps username rdp
RDP_ASKPASS="secret-tool lookup service winapps username rdp"
```

---

## 8. Schritt 5: FreeRDP-Verbindung testen

Bevor du WinApps installierst, sollte die manuelle RDP-Verbindung funktionieren. Erst die VM-IP ermitteln:

```bash
virsh domifaddr meine-windows-vm
```

Beispielausgabe:
```
 Name       MAC address          Protocol     Address
-------------------------------------------------------------
 vnet0      52:54:00:81:ff:44    ipv4         192.168.122.42/24
```

Dann FreeRDP-Verbindungstest:

```bash
xfreerdp3 /u:"DeinWindowsBenutzer" /p:"DeinWindowsPasswort" /v:192.168.122.42 /cert:tofu
```

**Erwartetes Ergebnis:** Ein Windows-Desktop-Fenster öffnet sich. Beim ersten Mal erscheint eine Zertifikatswarnung – mit "Y" akzeptieren.

Funktioniert das, ist die RDP-Schicht in Ordnung. Verbindung schließen und weitermachen.

> **Bei Zertifikatsproblemen:** Wenn FreeRDP über ein altes Zertifikat meckert, im Verzeichnis `~/.config/freerdp/server/` die Datei `IP_PORT.pem` löschen und neu versuchen.

---

## 9. Schritt 6: WinApps-Installer ausführen

Mit laufender (aber nicht eingeloggter) Windows-VM den Installer starten:

```bash
bash <(curl https://raw.githubusercontent.com/winapps-org/winapps/main/setup.sh)
```

Der Installer:
1. Verbindet sich per RDP mit der VM
2. Scannt die Windows-Registry nach installierten Anwendungen
3. Erkennt "Community Tested Applications" (Office, Adobe, etc.) automatisch
4. Erstellt für jede Anwendung einen Eintrag im Linux-Anwendungsmenü
5. Generiert MIME-Types für Dateizuordnungen (z. B. `.docx` öffnet Word)

Der Vorgang dauert je nach Anzahl installierter Windows-Apps 1–3 Minuten.

### 9.1 Installation prüfen

Nach erfolgreichem Lauf solltest du im Anwendungsmenü deines Desktop-Environments (KDE, GNOME, XFCE) Einträge wie:
- "Microsoft Word"
- "Microsoft Excel"
- "Adobe Acrobat Reader"
- "Windows" (volle RDP-Sitzung)

finden. Klick auf einen Eintrag öffnet die Anwendung als reguläres Linux-Fenster.

### 9.2 Hilfe und Optionen

```bash
winapps-setup --help
```

Zeigt zusätzliche Optionen, etwa zum Aktualisieren oder Deinstallieren der App-Verknüpfungen.

### 9.3 Manuelle App-Starts

Auch nicht erkannte Anwendungen lassen sich starten:

```bash
# Programme im Windows-PATH
winapps manual notepad.exe

# Mit vollem Pfad
winapps manual "C:\Program Files\MeineApp\app.exe"

# Volle Windows-Sitzung
winapps windows
```

---

## 10. Schritt 7: WinApps Launcher (optional)

Es gibt einen offiziellen Tray-Launcher, der die WinApps-Bedienung vereinfacht:

```bash
git clone https://github.com/winapps-org/winapps-launcher.git
cd winapps-launcher
./install.sh
```

Der Launcher bietet:
- System-Tray-Icon
- VM-Steuerung (Start, Stopp, Pause, Reboot)
- Schnellzugriff auf alle installierten Windows-Apps
- Direkt-Start einer vollen Windows-Sitzung

Auf Arch Linux ist auch ein AUR-Paket `winapps-launcher-git` verfügbar.

---

## 11. Eigene Anwendungen hinzufügen

Wenn eine Windows-Anwendung nicht automatisch erkannt wird (Custom Software, Branchentools), kannst du eine eigene Definition hinzufügen.

### 11.1 Vorlage anlegen

```bash
mkdir -p ~/.local/share/winapps/apps/meine-app
cd ~/.local/share/winapps/apps/meine-app
```

Datei `info` erstellen:

```bash
NAME="Mein Branchentool"
SHORT_NAME="meintool"
ICON="meintool.svg"
EXEC="C:\Program Files\Branchentool\tool.exe"
SUPPORTED_TYPES="application/x-meintool"
CATEGORIES="Office;"
```

### 11.2 Icon platzieren

`meintool.svg` in dasselbe Verzeichnis legen. SVG ist Pflicht – PNG funktioniert nicht.

### 11.3 WinApps-Installer erneut laufen lassen

```bash
winapps-setup
```

Die neue Anwendung erscheint danach im Linux-Menü.

---

## 12. Typische Fehler und Lösungen

### Fehler: "VM nicht gefunden" beim Installer

**Ursache:** WinApps liest die libvirt-URI nicht korrekt.

```bash
# Prüfen
echo $LIBVIRT_DEFAULT_URI

# Falls leer:
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Dauerhaft systemweit
echo 'LIBVIRT_DEFAULT_URI="qemu:///system"' | sudo tee -a /etc/environment
```

### Fehler: "REMOTE DESKTOP PROTOCOL FAILURE" (Exit 14)

**Ursache:** RDP nicht aktiviert, falsche Anmeldedaten oder Firewall blockiert.

Prüfschritte:
1. In Windows: Remotedesktop aktiv? (Einstellungen → System → Remotedesktop)
2. Benutzer in Gruppe "Remotedesktopbenutzer"?
3. Manueller `xfreerdp3`-Test funktioniert?
4. Bei Pin/PIN-Login: Vollständiges Passwort, nicht PIN, in der Config

### Fehler: "APPLICATION QUERY FAILURE" (Exit 15)

**Ursache:** Der Application-Scan im Windows hängt.

```bash
# Timeout in winapps.conf erhöhen
APP_SCAN_TIMEOUT="120"
```

Auch sicherstellen: Windows ist nach Reboot **nicht eingeloggt** – der Scan funktioniert nur an der Login-Anzeige.

### Fehler: Apps öffnen sich, aber als ganzer Desktop statt einzelnes Fenster

**Ursache:** RDPApps.reg wurde nicht oder fehlerhaft eingespielt.

```powershell
# In Windows prüfen, ob Registry-Werte gesetzt sind
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Terminal Server\TSAppAllowList"
```

`fDisabledAllowList` sollte `0` sein und `EnableRemoteApp` `1`. Falls nicht: `install.bat` als Administrator erneut ausführen.

### Fehler: "CERTIFICATE NAME MISMATCH"

**Ursache:** Altes RDP-TLS-Zertifikat im FreeRDP-Cache.

```bash
# Alte Zertifikate löschen
rm -f ~/.config/freerdp/server/*.pem

# Neuen Verbindungsversuch starten
```

### Fehler: Schwarzer Bildschirm bei Multi-Monitor

**Ursache:** Bekannter FreeRDP-Bug mit `/multimon`.

In `winapps.conf` `/multimon` aus `RDP_FLAGS` entfernen oder kommentieren.

### Fehler: Sound funktioniert nicht

```bash
# In winapps.conf prüfen – /sound muss aktiv sein
RDP_FLAGS="/cert:tofu /sound:sys:pulse /microphone +home-drive"

# CachyOS mit PipeWire:
RDP_FLAGS="/cert:tofu /sound:sys:pipewire /microphone +home-drive"
```

### Fehler: Home-Ordner nicht in Windows sichtbar

In Windows den Datei-Explorer öffnen und in der Adressleiste eingeben:

```
\\tsclient\home
```

Falls nichts erscheint: Sicherstellen, dass `+home-drive` in `RDP_FLAGS` steht.

### Fehler: Anwendung startet, aber langsam

```bash
# /network:lan in RDP_FLAGS hinzufügen
RDP_FLAGS="/cert:tofu /sound /microphone +home-drive /network:lan"

# Oder bei Bild-Performance-Problemen:
RDP_FLAGS="/cert:tofu /sound /microphone +home-drive /gfx /nsc"
```

---

## 13. Befehlsreferenz

### WinApps-Bedienung

| Befehl | Beschreibung |
|---|---|
| `winapps-setup` | Installer (App-Erkennung, Icons) |
| `winapps-setup --help` | Hilfe und Optionen |
| `winapps windows` | Volle Windows-RDP-Sitzung starten |
| `winapps manual <exe>` | Beliebige Windows-EXE starten |
| `winapps <appname>` | Erkannte App starten (z. B. `winapps word`) |

### libvirt-Hilfsbefehle

| Befehl | Beschreibung |
|---|---|
| `virsh list --all` | Alle VMs anzeigen |
| `virsh start NAME` | VM starten |
| `virsh shutdown NAME` | VM herunterfahren |
| `virsh suspend NAME` | VM pausieren (RAM bleibt aktiv) |
| `virsh resume NAME` | Pausierte VM fortsetzen |
| `virsh domifaddr NAME` | IP der VM anzeigen |
| `virsh edit NAME` | XML-Konfiguration bearbeiten |
| `virsh dumpxml NAME` | XML ausgeben |
| `virsh snapshot-create-as NAME SNAP` | Snapshot erstellen |
| `virsh snapshot-revert NAME SNAP` | Snapshot wiederherstellen |
| `virsh qemu-agent-command NAME '{"execute":"..."}'` | Guest-Agent-Befehl |

### FreeRDP-Tests

| Befehl | Beschreibung |
|---|---|
| `xfreerdp3 /u:USER /p:PASS /v:IP` | Manueller Verbindungstest |
| `xfreerdp3 --version` | FreeRDP-Version anzeigen |
| `xfreerdp3 /h` | Vollständige Hilfe |

### Logs und Debugging

| Datei | Inhalt |
|---|---|
| `~/.local/share/winapps/winapps.log` | WinApps-Aktivitäts-Log (wenn `DEBUG=true`) |
| `~/.config/freerdp/server/*.pem` | RDP-Zertifikat-Cache |
| `/var/log/libvirt/qemu/<NAME>.log` | libvirt-VM-Log |

---

## 14. Anhang: Konfigurationsdatei mit Erklärungen

Vollständige `~/.config/winapps/winapps.conf` mit kommentierten Optionen:

```bash
##################################
#   WINAPPS CONFIGURATION FILE   #
##################################

# === ANMELDEDATEN ===
# Windows-Benutzer (volle Konto-Anmeldung, KEIN PIN)
RDP_USER="DeinWindowsBenutzer"
RDP_PASS="DeinWindowsPasswort"

# Alternative: Passwort aus externer Quelle (z. B. KWallet)
# RDP_PASS=""
# RDP_ASKPASS="bash -c 'kwallet-query --folder winapps --read-password rdp kdewallet'"

# Windows-Domäne (leer für Standalone-VM)
RDP_DOMAIN=""

# === VM-VERBINDUNG ===
# Bei libvirt: leer lassen, IP wird automatisch ermittelt
RDP_IP=""

# Name der libvirt-VM (muss exakt mit virsh list übereinstimmen)
VM_NAME="meine-windows-vm"

# Backend: libvirt | docker | podman | manual
WAFLAVOR="libvirt"

# === DARSTELLUNG ===
# Skalierung für HiDPI: 100, 140, 180
RDP_SCALE="100"

# FreeRDP-Flags (siehe FreeRDP-Manual für alle Optionen)
# /cert:tofu        - Zertifikatsfehler ignorieren (Trust on First Use)
# /sound            - Audio-Forwarding aktivieren
# /microphone       - Mikrofon-Forwarding
# +home-drive       - Linux-Home als Netzlaufwerk in Windows
# /network:lan      - Optimierung für lokales Netzwerk
RDP_FLAGS="/cert:tofu /sound /microphone +home-drive"

# Spezifische Flags nur für Apps (nicht volle Sitzung)
RDP_FLAGS_NON_WINDOWS=""

# Spezifische Flags nur für volle Windows-Sitzung
RDP_FLAGS_WINDOWS=""

# === VERHALTEN ===
# Automatische Pause der VM bei Inaktivität
# off = nie pausieren | on = nach AUTOPAUSE_TIME pausieren
AUTOPAUSE="off"
AUTOPAUSE_TIME="300"  # Sekunden

# === DEBUGGING ===
# Erstellt Log unter ~/.local/share/winapps/winapps.log
DEBUG="true"

# === TIMEOUTS (nur anpassen bei Fehlern) ===
PORT_TIMEOUT="5"        # RDP-Port-Check
RDP_TIMEOUT="30"        # RDP-Verbindungsaufbau
APP_SCAN_TIMEOUT="60"   # App-Erkennung in Windows
BOOT_TIMEOUT="120"      # VM-Bootzeit, wenn Auto-Start aus

# === MOUNTING (nur ändern wenn nötig) ===
# Pfad für entfernbare Medien (Standard: /run/media unter modernen DEs)
REMOVABLE_MEDIA="/run/media"

# === FREERDP-BEFEHL ===
# WinApps versucht den Befehl automatisch zu ermitteln
# Bei Bedarf manuell setzen (xfreerdp, xfreerdp3, etc.)
FREERDP_COMMAND=""

# === SONSTIGES ===
# Setzt das hidef-Flag für RemoteApp (kann Fenster-Probleme beheben)
HIDEF="on"
```

---

## Anhang: Schnell-Setup-Skript

Skript, das die Linux-Seite weitgehend automatisch einrichtet (die Windows-Seite muss manuell vorbereitet werden):

```bash
#!/usr/bin/env bash
# winapps-setup.sh – WinApps-Vorbereitung auf CachyOS

set -e

VM_NAME="${1:-meine-windows-vm}"
WIN_USER="${2:-DeinWindowsBenutzer}"

echo "=== Pakete installieren ==="
sudo pacman -Syu --needed --noconfirm \
  curl dialog freerdp git iproute2 libnotify openbsd-netcat virt-manager

echo "=== Benutzergruppen prüfen ==="
sudo usermod -a -G kvm $USER || true
sudo usermod -a -G libvirt $USER || true

echo "=== libvirt-URI setzen ==="
if ! grep -q "LIBVIRT_DEFAULT_URI" /etc/environment; then
  echo 'LIBVIRT_DEFAULT_URI="qemu:///system"' | sudo tee -a /etc/environment
fi

echo "=== VM-Existenz prüfen ==="
if ! virsh list --all | grep -q "$VM_NAME"; then
  echo "FEHLER: VM '$VM_NAME' nicht gefunden!"
  echo "Verfügbare VMs:"
  virsh list --all
  exit 1
fi

echo "=== VM-IP ermitteln ==="
virsh start "$VM_NAME" 2>/dev/null || true
sleep 5
VM_IP=$(virsh domifaddr "$VM_NAME" | awk '/ipv4/ {print $4}' | cut -d/ -f1)
echo "  → IP: $VM_IP"

echo "=== WinApps-Konfiguration anlegen ==="
mkdir -p ~/.config/winapps
cat > ~/.config/winapps/winapps.conf <<EOF
RDP_USER="$WIN_USER"
RDP_PASS="BITTE_ANPASSEN"
RDP_IP=""
VM_NAME="$VM_NAME"
WAFLAVOR="libvirt"
RDP_SCALE="100"
RDP_FLAGS="/cert:tofu /sound /microphone +home-drive"
DEBUG="true"
AUTOPAUSE="off"
AUTOPAUSE_TIME="300"
EOF
chmod 600 ~/.config/winapps/winapps.conf

echo "=== FreeRDP-Verbindung testen (wird Passwort abfragen) ==="
echo "Manueller Test mit:"
echo "  xfreerdp3 /u:'$WIN_USER' /v:$VM_IP /cert:tofu"
echo ""
echo "=== Nächste Schritte ==="
echo "1. Passwort in ~/.config/winapps/winapps.conf eintragen"
echo "2. In der Windows-VM RDPApps.reg + install.bat ausführen"
echo "3. Windows neu starten (NICHT einloggen)"
echo "4. WinApps-Installer ausführen:"
echo "   bash <(curl https://raw.githubusercontent.com/winapps-org/winapps/main/setup.sh)"
echo ""
echo "Eventuell vorher abmelden/anmelden für Gruppenmitgliedschaften."
```

Aufruf:

```bash
chmod +x winapps-setup.sh
./winapps-setup.sh meine-windows-vm DeinBenutzer
```

---

*Leitfaden erstellt für BWSA – Bildung, Weiterbildung, Service | CachyOS / Arch Linux*
