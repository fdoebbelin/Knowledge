---
title: Windows-Anwendungen unter Fedora Atomic — WinApps, WinBoat, Wine
teil_von: "[[README]]"
tags: [windows, winapps, winboat, freerdp, remoteapp, wine, bottles, proton, libvirt, atomic, flatpak, nushell]
zielgeraet: x86_64 Fedora Atomic (Yoga 920, Dozenten-PC)
created: 2026-08-13
status: draft
verifiziert_gegen: —
---

# 18 — Windows-Anwendungen unter Fedora Atomic

Fortsetzung von [[11-kvm-windows11-vm]] und [[12-dateifreigabe-host-gast]].
Die Windows-11-Pro-VM läuft, virtiofs ist in Arbeit — offen ist die letzte
Meile: **einzelne Windows-Programme als normale Sway-Fenster**, ohne
Vollbild-VM und ohne Kontextwechsel.

> [!warning] Status: Entwurf
> Nichts in dieser Notiz ist live durchgespielt. Die Aussagen sind gegen die
> WinApps-Dokumentation und die Fedora-Paketlage belegt, nicht gegen ein
> laufendes System. Erst nach dem Test in [Abschnitt A.3](#a3--der-eine-test-der-alles-entscheidet)
> auf `teilweise verifiziert` heben.

## Kernaussage

Für lizenzgebundene Windows-Software ist **WinApps** der richtige Weg: es
fügt der bestehenden VM nichts hinzu, was sie nicht schon hätte, sondern
holt per **FreeRDP im RemoteApp-Modus** einzelne Fenster aus dem laufenden
Gast heraus. Der Preis ist eine Windows-Lizenz und ein RDP-Stack — dafür
gibt es 100 % Kompatibilität, weil es echtes Windows ist.

Für alles **ohne** Lizenzbindung ist **Bottles** (Flatpak, Wine) der
richtige Weg: keine VM, kein Windows, kein Image-Eingriff. Beide Wege
schließen sich nicht aus und sollten nebeneinander bestehen.

## Entscheidungsmatrix

| | WinApps | WinBoat | Bottles (Wine) | Distrobox + Wine | Voller RDP-Desktop |
|---|---|---|---|---|---|
| Windows-Lizenz nötig | **ja** | ja | nein | nein | ja |
| Kompatibilität | 100 % | 100 % | anwendungsabhängig | anwendungsabhängig | 100 % |
| Einzelfenster auf dem Sway-Desktop | **ja** | ja | ja (Wine-Fenster) | ja | nein |
| Nutzt die **vorhandene** VM | **ja** | nein (bringt eigene) | — | — | ja |
| Eingriff ins bootc-Image | FreeRDP v3 | FreeRDP v3 + Podman | keiner (Flatpak) | keiner (`/var`) | virt-viewer/FreeRDP |
| Reifegrad | etabliert | jung (v0.9.x) | etabliert | etabliert | trivial |
| Aufwand Ersteinrichtung | mittel | gering | gering | mittel | null |

> [!note] Warum nicht einfach der volle Desktop
> Funktioniert, kostet nichts und ist als Rückfallebene immer da. Aber in
> einer Schulung ist der sichtbare Windows-Desktop genau die Ablenkung, die
> das Image vermeiden soll — und er kollidiert mit der Fenster-Policy
> (`workspace_layout tabbed`, Noctalia-Bar), weil ein Vollbild-Gast alles
> verdeckt.

---

# Weg A — WinApps (Empfehlung)

## A.1 — Wie es funktioniert

RDP kann seit Server 2008 **RemoteApp**: der Server überträgt nicht den
Desktop, sondern einzelne Top-Level-Fenster inklusive Alpha-Maske. FreeRDP
v3 zeichnet diese als eigenständige Wayland-Fenster. WinApps ist die
Klammer darum — es fragt den Gast einmalig nach installierten Programmen,
legt `.desktop`-Dateien an und startet pro Aufruf einen FreeRDP-Prozess mit
`/app:program-path:…`.

Wichtig für das Verständnis der Fehlerbilder: **es ist eine RDP-Sitzung.**
Alle RDP-Regeln gelten — eine Sitzung pro Benutzer, keine lokale Anmeldung
parallel, Zertifikatsvertrauen beim ersten Verbinden.

## A.2 — FreeRDP v3 auf Atomic beschaffen

Hier liegt die einzige echte Atomic-Frage. `sudo dnf install freerdp`
existiert auf dem laufenden System nicht — die Entscheidung ist also, in
welcher Schicht FreeRDP landet.

| Schicht | Bewertung |
|---|---|
| **Containerfile** | **Richtige Wahl.** Reproduzierbar, flottenweit gleich, kein Sandbox-Ärger. Ein Paket, keine tiefen Abhängigkeiten außerhalb dessen, was ein Desktop-Image ohnehin hat. |
| Homebrew | Möglich (`brew install freerdp`), aber FreeRDP ist **kein blattständiges Tool** — es will Audio (PipeWire), USB, Zwischenablage, Wayland. Verstößt gegen die Zwei-Schichten-Regel aus [[13-xps13-wsl-installation]]. |
| Flatpak | **Von WinApps upstream ausdrücklich nicht empfohlen** — die Sandbox bricht Pfad-Weitergabe (`\\tsclient\home`), Drucker- und Geräteumleitung. Als *Test*-Vehikel brauchbar, nicht als Dauerlösung. |
| `rpm-ostree install` | Nein. Bricht den `bootc upgrade`-Pfad ([[docs/01-erkenntnisse]]). |

Ins Containerfile des `kvm/win11`-Moduls, neben die Virtualisierungspakete
aus Notiz 11:

```dockerfile
RUN dnf install -y freerdp libnotify netcat iproute dialog \
    && rpm -q freerdp libnotify \
    && freerdp --version
```

Der `rpm -q`-Guard ist Pflicht — Exit 0 von dnf beweist keine Installation
(`Obsoletes`-Falle, [[docs/01-erkenntnisse]]).

Version prüfen, **bevor** irgendetwas anderes passiert:

```nu
let v = (^freerdp --version | lines | first)
print $v
if not ($v | str contains "3.") { print "→ v3 fehlt, WinApps läuft nicht" }
```

> [!important] v3 ist harte Voraussetzung
> WinApps verlangt FreeRDP ≥ 3. Das Binary heißt je nach Paketierung
> `freerdp`, `xfreerdp3` oder `sdl-freerdp3`. Der gefundene Pfad gehört
> später als `FREERDP_COMMAND` in die Konfiguration — dann ist es egal, wie
> es heißt.

## A.3 — Der eine Test, der alles entscheidet

**Vor** der WinApps-Installation. Er beweist in zwei Minuten, ob RemoteApp
auf dieser VM trägt. Fällt er durch, ist WinApps nicht das Problem und
jede weitere Minute in der Installation ist verschwendet.

Vorbereitung im Gast (einmalig, als Administrator):

1. *Einstellungen → System → Remotedesktop* aktivieren. Erfordert **Windows
   11 Pro** — bei Home fehlt der RDP-Server. (Vorhanden, siehe Notiz 11.)
2. `RDPApps.reg` aus dem WinApps-Repo ausführen. Ohne diese Registry-Werte
   erlaubt Windows RemoteApp nur für explizit *veröffentlichte* Programme,
   nicht für beliebige Pfade.
3. Konto-Typ klären: Bei einem **Microsoft-Konto** ist der RDP-Benutzername
   `MicrosoftAccount\mail@example.com`, nicht der Anzeigename. Häufigste
   Ursache für „Anmeldung fehlgeschlagen".
4. **Abmelden** — nicht herunterfahren, nicht angemeldet bleiben.

Host-seitig:

```nu
let vm = "Windows 11 Pro"

# IP aus dem default-NAT holen
let gast = (
  virsh --connect qemu:///system domifaddr $vm
  | lines | skip 2 | where ($it | str trim | is-not-empty)
  | first | split row -r '\s+' | last | split row "/" | first
)
print $"Gast: ($gast)"

# Port offen?
nc -z -w 3 $gast 3389
```

Der eigentliche Nachweis — Notepad als **einzelnes Fenster**, ohne
Windows-Desktop drumherum:

```nu
let user = "fritz"

^freerdp $"/v:($gast)" $"/u:($user)" /p:GEHEIM /cert:tofu `
  '/app:program-path:C:\Windows\System32\notepad.exe' `
  /dynamic-resolution +auto-reconnect /sound /clipboard
```

> [!check] Was Erfolg heißt
> Ein Notepad-Fenster, das sich in Sway wie jedes andere Fenster verhält:
> verschiebbar, in der Noctalia-Bar gelistet, per `swaymsg -t get_tree`
> sichtbar. Erscheint stattdessen ein Windows-Desktop, hat `/app` nicht
> gegriffen → `RDPApps.reg` fehlt.

> [!tip] Passwort nicht in die History
> `/p:` landet im Klartext in der Nushell-History. Sauberer:
> ```nu
> let pw = (input --suppress-output "Windows-Passwort: ")
> ^freerdp $"/v:($gast)" $"/u:($user)" $"/p:($pw)" /cert:tofu ...
> ```
> Für den Dauerbetrieb gehört das Passwort in `winapps.conf` mit
> `chmod 600` — oder, besser, in einen eigenen Windows-Benutzer, der nur
> für RDP existiert.

## A.4 — Konfiguration

```nu
mkdir ~/.config/winapps

r#'RDP_USER="fritz"
RDP_PASS="GEHEIM"
RDP_DOMAIN=""
RDP_IP=""
WAFLAVOR="libvirt"
VM_NAME="Windows 11 Pro"
RDP_SCALE=100
RDP_FLAGS="/cert:tofu /sound /clipboard"
MULTIMON="false"
DEBUG="true"
FREERDP_COMMAND="freerdp"
'# | save -f ~/.config/winapps/winapps.conf

chmod 600 ~/.config/winapps/winapps.conf
```

> [!warning] Zwei Werte, die fast immer falsch sind
> **`VM_NAME`** ist per Default `RDPWindows`. Unsere Domain heißt
> `Windows 11 Pro` — derselbe Stolperstein wie beim Restore in Notiz 11
> (Punkt 5 der gelösten Probleme): der Name kommt aus dem `<name>`-Element,
> nicht aus dem Dateinamen.
>
> **`WAFLAVOR`** ist per Default `docker`. Ohne Umstellung auf `libvirt`
> sucht WinApps nach einem Container und meldet einen irreführenden Fehler.

`RDP_IP` bleibt bei `libvirt` **leer** — WinApps ermittelt die Adresse
selbst über libvirt. Ein fest eingetragener Wert bricht, sobald dnsmasq
eine andere Lease vergibt.

## A.5 — Installation

WinApps ist ein Bash-Installer. Nicht blind aus der Pipe ausführen:

```nu
cd /tmp
http get https://raw.githubusercontent.com/winapps-org/winapps/main/setup.sh
| save -f setup.sh

# lesen, bevor es läuft
hx setup.sh

bash ./setup.sh --user
```

`--user` installiert nach `~/.local/bin` und `~/.local/share/applications` —
auf Atomic die einzig sinnvolle Variante, alles unterhalb von `/var/home`.

Der Installer startet die VM, verbindet sich per RDP, liest die installierten
Programme aus der Registry und legt pro Programm eine `.desktop`-Datei an.

Kontrolle:

```nu
ls ~/.local/share/applications | where name =~ "winapps" | select name size
open --raw ~/.local/share/applications/winapps-word.desktop | lines | find Exec
```

Fehlersuche bei `DEBUG="true"`:

```nu
open --raw ~/.local/share/winapps/winapps.log | lines | last 40
ls ~/.local/share/winapps/ | where name =~ "FreeRDP_Test" | sort-by modified | last
```

## A.6 — Integration in Sway und Noctalia

WinApps bewirbt Nautilus-Integration. Die ist hier **irrelevant** — es gibt
keinen GNOME-Dateimanager im Image. Was bleibt und trägt:

- **`.desktop`-Dateien** funktionieren compositor-unabhängig; Noctalias
  Launcher findet sie ohne Zutun.
- **MIME-Zuordnung** per `xdg-mime`, falls `.docx` in Word statt LibreOffice
  soll — bewusste Entscheidung, siehe [[office-paket-hyprland-vergleich]].
- **Fenster-Policy:** RemoteApp-Fenster tragen `app_id` von FreeRDP. Für
  `policy.nuon` erst messen, was tatsächlich ankommt:

```nu
swaymsg -t get_tree | from json
| get -i ..* | where ($it.app_id? != null)
| select app_id name
```

## A.7 — HiDPI: der wahrscheinlichste Stolperstein

Auf dem Yoga 920 läuft `scale 2` ([[docs/05-hidpi-und-monitore]]). Eine
RDP-Sitzung weiß davon nichts.

> [!caution] `RDP_SCALE` kennt nur drei Werte
> FreeRDP akzeptiert für die Skalierung im Gast **100, 140 oder 180** —
> keine freien Werte. Das ist die Windows-DPI-Seite. Ob die Kombination aus
> Sway-`scale 2` und `RDP_SCALE=180` lesbar ist oder doppelt skaliert
> aussieht, ist **nicht gemessen**.

Messung, sobald ein Fenster steht:

```nu
# Was meldet Sway für das RemoteApp-Fenster?
swaymsg -t get_tree | from json
| get -i ..* | where ($it.app_id? | default "" | str contains "freerdp")
| select app_id rect.width rect.height

# Vergleich: was denkt Windows?
#   Gast → Einstellungen → System → Anzeige → Skalierung
```

Erwartungsgerüst, gegen das gemessen wird:

- `RDP_SCALE=100` + Sway `scale 2` → Fenster wirkt winzig, gestochen scharf
- `RDP_SCALE=180` + Sway `scale 2` → vermutlich richtig
- Unschärfe deutet auf XWayland-Fallback → `/gdi:hw` und Wayland-Backend
  von FreeRDP prüfen

Am Beamer (`scale 1`, siehe Notiz 05) gilt jeweils das Gegenteil — was für
die Schulungsflotte heißt: **eine Skalierung wird nicht für beide passen.**
Entweder pro Host gesetzt (wie die `hosts/`-Drop-ins) oder bewusst auf
einen Kompromiss festgelegt.

## A.8 — Dateiaustausch: `\\tsclient\home` vs. virtiofs

WinApps reicht das Home-Verzeichnis automatisch als `\\tsclient\home` in die
Sitzung. Das ist **nicht** dasselbe wie der virtiofs-Weg aus
[[12-dateifreigabe-host-gast]]:

| | `\\tsclient\home` | virtiofs `N:` |
|---|---|---|
| Verfügbar | nur während einer RDP-Sitzung | immer, auch ohne Sitzung |
| Geschwindigkeit | RDP-Kanal, träge bei großen Dateien | lokale FS-Semantik |
| Eigentümer-Problem | keins (läuft über den RDP-Benutzer) | gelöst über Registry `Owner=1000:1000` |
| Einrichtung | automatisch | WinFsp + Treiber + Dienst |

Beide dürfen koexistieren. Für den Nextcloud-Baum bleibt virtiofs richtig;
`\\tsclient\home` ist der bequeme Weg für „diese eine Datei jetzt".

---

# Weg B — WinBoat

Jüngeres Projekt mit demselben Prinzip (RDP-RemoteApp), aber anderem
Zuschnitt: Electron-Oberfläche, eigenes Provisioning, Windows-Gast im
Container (`dockur/windows`) statt in libvirt, fertige RPM-/AppImage-Pakete.

**Wofür es sich lohnt:** wenn *keine* Windows-VM existiert und man in einer
Stunde ohne Handarbeit ans Ziel will. Die Automatik lädt Windows, richtet
RDP ein, aktiviert RemoteApp.

**Warum hier trotzdem WinApps:** Die VM existiert bereits, restauriert,
mit intakter TPM und BitLocker ([[11-kvm-windows11-vm]]). WinBoat würde
eine zweite Windows-Installation danebenstellen — zweite Lizenz, zweiter
Update-Pfad, doppelter Plattenverbrauch. Dazu kommt Podman-Windows-in-
Container als zusätzliche Schicht, die auf Atomic mehr Fragen aufwirft als
sie beantwortet.

> [!note] Im Auge behalten
> Für ein späteres, *eigenständiges* Windows-Modul der Schulungsflotte —
> ohne restaurierten Altbestand — ist WinBoat der ernsthaftere Kandidat.
> Version im Blick behalten, aber nicht in dieser Runde.

---

# Weg C — Bottles (Wine, ohne Windows)

Für alles ohne Lizenz- oder Hardwarebindung: Legacy-`.exe`, kleine
Fachanwendungen, Spiele. Flatpak, also auf Atomic **kostenlos** im Sinne
von „kein Image-Eingriff".

```nu
flatpak install -y flathub com.usebottles.bottles

# Eigenes Verzeichnis fuer Windows-Programme freigeben
let progdir = ($nu.home-path | path join "Programme")
mkdir $progdir
flatpak override --user com.usebottles.bottles $"--filesystem=($progdir)"

# Wayland-nativ, konsistent mit [[docs/05-hidpi-und-monitore]]
flatpak override --user com.usebottles.bottles --socket=wayland
```

Bottles kapselt Wine-Präfixe („Flaschen") mit Runner-Auswahl (Wine, Proton,
Soda), DXVK/VKD3D und Abhängigkeitsrezepten. Praktisch heißt das: Wine
konfigurieren, ohne `winetricks`-Folklore auswendig zu können.

> [!tip] Vorher prüfen, ob es überhaupt läuft
> Die ehrliche Reihenfolge ist: **erst** in der ProtonDB/WineHQ-Datenbank
> nachsehen, ob die Anwendung als lauffähig gemeldet ist, **dann** eine
> Flasche bauen. Andernfalls verbringt man einen Abend damit, ein
> Kompatibilitätsproblem für eine Anwendung zu lösen, die drei Klicks
> entfernt in der VM einfach funktioniert.

> [!warning] Grenzen, die nicht verhandelbar sind
> Anwendungen mit Kernel-Treibern, Hardware-Dongles, aktuellem
> Anti-Cheat oder tiefer Office-Automation (VBA, COM-Add-ins) laufen unter
> Wine nicht zuverlässig. Genau dafür existiert Weg A.

---

# Weg D — Distrobox + Wine

Wenn die Flatpak-Sandbox stört — etwa weil ein Programm auf ein
USB-Gerät, einen seriellen Port oder einen Netzwerkdienst zugreifen muss.

```nu
distrobox create --name wine --image registry.fedoraproject.org/fedora:44
distrobox enter wine

# im Container
sudo dnf install -y wine winetricks
distrobox-export --app <anwendung>
```

Der Container lebt in `/var/home`, überlebt also `bootc switch` — dieselbe
Logik wie beim VM-State in Notiz 11. `distrobox-export` legt eine
`.desktop`-Datei auf dem Host an, das Fenster erscheint regulär in Sway.

**Bewertung:** Mehr Kontrolle als Bottles, mehr Handarbeit. Als
Erkundungspfad legitim, als Standardweg nicht — Bottles zuerst.

---

# Weg E — Voller Desktop (Rückfallebene)

Immer verfügbar, kein Setup, für Administration im Gast ohnehin nötig:

```nu
virt-viewer --connect qemu:///system "Windows 11 Pro"

# oder per RDP, wenn Spice/QXL stört
^freerdp $"/v:($gast)" $"/u:fritz" /cert:tofu /dynamic-resolution /f
```

Wenn RemoteApp streikt, ist das der Beweis, dass Netz, Anmeldung und
Zertifikat in Ordnung sind — das Problem liegt dann bei `/app` und der
Registry, nicht darunter. **Diagnosekette wie in Notiz 11:** eine Schicht
nach der anderen ausschließen.

---

## Was bewusst nicht verfolgt wird

- **Cassowary** — Vorgänger-Idee derselben Bauart, faktisch eingeschlafen.
  WinApps ist der lebende Zweig.
- **PlayOnLinux / Lutris** — Lutris ist Spiel-fokussiert; für
  Anwendungssoftware ist Bottles der bessere Zuschnitt.
- **Wine direkt ins bootc-Image** — Wine zieht ein umfangreiches
  32-Bit-Multilib-Set nach. In ein Image, das auf allen Flottengeräten
  identisch ausgerollt wird, gehört das nur, wenn es alle brauchen. Sonst:
  Flatpak.
- **Windows-Programme per WSL** — auf dem XPS ist WSL die
  Scout-Umgebung ([[13-xps13-wsl-installation]]), nicht der
  Produktionsweg. Für Atomic irrelevant.

## Offene Punkte

- [ ] FreeRDP-Version in Fedora 44 prüfen — ist es v3?
- [ ] Manueller RemoteApp-Test (A.3) mit Notepad — der Gatekeeper
- [ ] `RDPApps.reg` im Gast anwenden und Registry-Änderung dokumentieren
- [ ] `freerdp` + Abhängigkeiten ins Containerfile des `kvm/win11`-Moduls,
      mit `rpm -q`-Guard
- [ ] `app_id` der RemoteApp-Fenster messen → Eingang in `policy.nuon`
- [ ] HiDPI: `RDP_SCALE` 100/140/180 gegen Sway `scale 2` messen (A.7)
- [ ] Skalierungsstrategie Yoga vs. Beamer entscheiden — pro Host oder
      Kompromiss
- [ ] Eigener Windows-Benutzer nur für RDP statt des Hauptkontos?
- [ ] Lizenzlage für die Schulungsflotte klären: eine VM pro Gerät heißt
      eine Windows-Lizenz pro Gerät
- [ ] Bottles-Test mit einer konkreten Anwendung — welche eigentlich?
- [ ] Nach erfolgreichem A.3: Notiz auf `teilweise verifiziert` heben

## Verwandte Notizen

- [[11-kvm-windows11-vm]] — die VM, auf der Weg A aufsetzt
- [[12-dateifreigabe-host-gast]] — virtiofs, Gegenstück zu `\\tsclient\home`
- [[docs/05-hidpi-und-monitore]] — Skalierungsgrundsätze, Basis für A.7
- [[office-paket-hyprland-vergleich]] — LibreOffice als Alternative zu
  Word-über-RDP
- [[docs/01-erkenntnisse]] — warum nichts per `rpm-ostree install` kommt
