---
title: XPS 13 — Fedora-WSL als Sway/Noctalia-Arbeitsumgebung
aliases: [WSL-Installationsleitfaden, XPS-Bastelumgebung]
teil_von: "[[README]]"
tags: [wsl, fedora, sway, homebrew, nushell, dnf, xps13]
created: 2026-07-29
system: Dell XPS 13 9345 (Snapdragon X Elite, aarch64), FedoraLinux-44 WSL
status: draft
---

# 13 — XPS 13: Fedora-WSL neu aufsetzen

Logischer Leitfaden vom bereinigten WSL-Basisimage zu einer nutzbaren
Sway-Oberfläche mit sauberer Paket-Zweiteilung. Zustand nach der Rücknahme
aller lokalen Transaktionen (Protokoll vom 2026-07-29): `dnf history` zeigt
nur noch ID 1–3 mit Aktionen — Image-Bau plus ein `dnf upgrade`.

> [!info] Abgrenzung
> Dieses Dokument beschreibt die **mutable Bastelumgebung** auf dem XPS.
> Nichts hieraus wandert ins bootc-Image — dort gilt weiterhin
> [[docs/03-bauen-und-testen]]: Pakete deklarativ im Containerfile, mit
> `rpm -q`-Guard. Die WSL-Distro ist Werkbank und Scout, nicht Vorbild.

## Architekturentscheidungen

### Warum die offizielle Fedora-WSL-Distro, nicht Sway Atomic

Sway Atomic ist ein bootc/ostree-Image. WSL importiert nur ein flaches
Rootfs, bringt den eigenen Kernel mit und kennt keine Deployment-Kette —
`bootc upgrade`, Rollback, das `/etc`-3-Wege-Merge fallen ersatzlos weg.
Ein Import wäre möglich, testet aber nichts von dem, was das Image ausmacht.
Fedora liefert **kein** Sway-WSL-Image; es gibt genau ein minimales
Basis-Rootfs.

> [!note] Kein Microsoft Store
> Fedora verteilt bewusst nicht über den Store (Store-Richtlinien und
> Entwicklervertrag). Installation ausschließlich über
> `wsl --install FedoraLinux-44`; der exakte Name kommt aus
> `wsl --list --online`. Die aarch64-Images sind als BETA markiert.

### Die Zwei-Schichten-Regel: dnf unten, brew oben

**Brew ist für blattständige Userland-Tools.** Alles mit setuid-Helfern,
`binfmt_misc`, User-Namespaces, systemd-Units oder udev-Regeln muss aus
Prinzip per dnf kommen — Homebrew installiert nach
`/home/linuxbrew/.linuxbrew`, bewusst isoliert vom System, und *kann* dort
nicht hineinregieren. Homebrew nutzt vom Host nur glibc und gcc (beide auf
Fedora 44 neu genug) und erwartet die üblichen Entwicklungswerkzeuge als
Bootstrap-Basis.

| Paket | Schicht | Begründung |
|---|---|---|
| podman, buildah | **dnf, zwingend** | rootless braucht setuid `newuidmap`/`newgidmap`, `/etc/subuid`, System-`crun`/`conmon`/`netavark` |
| skopeo | dnf, empfohlen | liest `containers-common`-Konfiguration; als kohärenter Stack bei podman |
| containers-common | **dnf, zwingend** | `policy.json`, `registries.conf`, `storage.conf` — harte Abhängigkeit des Stacks (im Rücknahme-Protokoll fiel es erst mit dem letzten der drei) |
| qemu-user-static | **dnf, zwingend** | registriert `binfmt_misc`-Handler — kategorisch außerhalb von brews Reichweite. Nur nötig für lokale Cross-Builds; die CI ([[docs/10-github-repository]]) macht das inzwischen nativ |
| @development-tools, git-core, curl, file, procps-ng | **dnf** | Brews eigene Bootstrap-Abhängigkeiten |
| wl-clipboard | dnf | Wayland-Systemschicht, von Helix genutzt |
| nushell, helix, jq, gawk | **brew** | reine CLI-Tools, aktueller als Fedora 44 |
| qemu-img (`brew install qemu`) | brew möglich | reine Userland-Konvertierung |

> [!warning] aarch64-Vorbehalt bei brew
> Linux-arm64-Bottles sind vorhanden, die Abdeckung ist aber dünner als bei
> x86_64. Fehlt ein Bottle, kompiliert brew aus dem Quelltext — dann greift
> die volle Toolchain. Vorher prüfen: `brew install --dry-run <paket>`.

### Login-Shell Bash, Nushell im Terminal

Login-Shell bleibt `/bin/bash`: stabiler Pfad, POSIX-Kette
(`/etc/profile`) läuft, VS-Code-Remote und Interop funktionieren. Nushell
wird dem Terminal-Emulator zugeordnet und ist damit reine
*interaktive* Shell.

Diese Entscheidung löst nebenbei einen Konflikt: Nushell aus brew als
**Login**-Shell wäre riskant (brew-Pfad beim WSL-Start nicht garantiert,
Aussperr-Gefahr). Als Terminal-Shell ist der brew-Pfad unkritisch — schlägt
er fehl, öffnet man `bash` und repariert. Der frühere Rat „Nushell für die
Login-Shell aus dnf" ist damit **gegenstandslos**, weil es keine
Nushell-Login-Shell mehr gibt.

> [!important] Konsequenz für Konfigurationen
> foot/kitty starten Nushell als *Nicht*-Login-Shell. Die Login-Kette hat
> Bash beim WSL-Einstieg bereits abgearbeitet; Nushell erbt die Umgebung.
> Alles, was Nushell selbst braucht — brew-PATH, `NU_LIB_DIRS` — gehört
> deshalb zwingend in `env.nu`/`config.nu`, nie in Login-Dateien.
> Nushell liest kein `/etc/profile.d/*.sh` (siehe [[docs/02-umgebung-wsl]]).

## Korrekturen aus der Syntaxprüfung

Alle Nushell-Beispiele dieses Dokuments wurden gegen Nushell 0.107
verifiziert. Zwei Konstrukte aus früheren Sitzungsnotizen waren **falsch**:

> [!danger] Kein Backtick als Zeilenfortsetzung
> ```nu
> # FALSCH — Parser-Fehler unexpected_eof:
> sudo dnf install -y sway foot `
>     wl-clipboard
> ```
> Nushell kennt weder Backtick- noch Backslash-Fortsetzung für externe
> Befehle. Idiomatisch: Liste + Spread-Operator (verifiziert):
> ```nu
> let pakete = [sway foot wl-clipboard]
> sudo dnf install -y ...$pakete
> ```
> Alternativ funktioniert ein geklammerter Aufruf über mehrere Zeilen:
> `(sudo dnf install -y↵ sway foot)` — der Spread ist lesbarer.

> [!danger] Symlink-Ziel: `-D` nicht vergessen
> `ls -l /bin | get target` listet den **Inhalt** von `/usr/bin` — nicht
> den Link. Korrekt (verifiziert, liefert `/usr/bin`):
> ```nu
> ls -lD /bin | get target.0
> ```

> [!danger] Raw-String darf nicht mit `#` beginnen
> `r#'# Kommentar …'#` bricht den Parser (verifiziert an 0.107:
> `unexpected_eof`) — die Folge `r#'#` wird falsch gelext. Betrifft alle
> Drop-in-Snippets, deren erste Zeile ein Kommentar ist. Zwei verifizierte
> Auswege: doppelte Raute `r##'# Kommentar …'##` (bevorzugt, keine
> Ausgabeänderung) oder eine Leerzeile direkt nach `r#'`.

Verifiziert korrekt sind dagegen: `(extern | complete).exit_code`,
`$"(curl …)"`-Interpolation (Nushell führt das Externe aus und übergibt die
Ausgabe als ein Argument), `with-env {K: "v"} {…}` in Record-Form,
`save -a` (legt fehlende Dateien an), `prepend` mit Liste,
`split row ":" | last` (Trailing-Newline wird beim Capture getrimmt,
Vergleiche wie `(realpath a) == (realpath b)` funktionieren), Raw-Strings
`r#'…'#` und Regex-Filter `where {|z| $z =~ '…'}`.

## Schritt 1 — dnf-Systemschicht

```nu
let system = [
    @development-tools procps-ng curl file git-core
    containers-common podman buildah skopeo
    wl-clipboard
]
sudo dnf install -y ...$system

# Guard — Exit-Code prüfen, nicht der Ausgabe glauben:
[podman buildah skopeo containers-common git-core] | each {|p|
    {paket: $p, ok: ((rpm -q $p | complete).exit_code == 0)}
}
```

*Diskussion.* `containers-common` steht explizit in der Liste, obwohl dnf
es ohnehin zöge — die Absicht wird sichtbar. Eigene Registry-Anpassungen
(z. B. Signaturpolicy für `quay.io/metarow`) gehören nach
`/etc/containers/`, nicht nach `/usr/share/containers/` — dasselbe
Drop-in-Prinzip wie bei den Sway-Configs. `qemu-user-static` bleibt
draußen, bis lokale Cross-Builds wieder nötig werden.

## Schritt 2 — Homebrew

### Installation

Das Installer-Skript ist Bash; der macOS-Einzeiler
`/bin/bash -c "$(curl …)"` scheitert in Nushell, weil `"$(…)"`
Bash-Syntax ist: Nushell konsumiert die Anführungszeichen, Bash erhält eine
*unquotierte* Substitution und versucht, `#!/bin/bash` als Programm
auszuführen. `/bin/bash` selbst ist kein Problem — `/bin` ist seit dem
UsrMerge ein Symlink auf `/usr/bin`.

Robuster Weg — herunterladen, gegenlesen, ausführen (stdin bleibt am
Terminal, die interaktiven Abfragen des Installers funktionieren):

```nu
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    | save -f /tmp/brew-install.sh
open /tmp/brew-install.sh | lines | first 3
/bin/bash /tmp/brew-install.sh
```

Oder als Einzeiler mit Nushell-Interpolation:

```nu
/bin/bash -c $"(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### PATH — beide Shells von Hand

Der Installer schreibt bestenfalls nach `~/.bashrc`; Nushell liest davon
nichts, und `brew shellenv` ist Bash-Code ohne Nushell-Äquivalent.

Bash (`~/.bashrc`):

```nu
'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' | save -a ~/.bashrc
```

Nushell (`~/.config/nushell/env.nu`):

```nu
$env.PATH = ($env.PATH | prepend [
    "/home/linuxbrew/.linuxbrew/bin"
    "/home/linuxbrew/.linuxbrew/sbin"
])
$env.HOMEBREW_PREFIX = "/home/linuxbrew/.linuxbrew"
$env.HOMEBREW_CELLAR = "/home/linuxbrew/.linuxbrew/Cellar"
$env.HOMEBREW_REPOSITORY = "/home/linuxbrew/.linuxbrew/Homebrew"
```

`$env.PATH` ist in Nushell eine Liste; die Übersetzung zum PATH-String für
Kindprozesse übernimmt Nushell selbst. Die `HOMEBREW_*`-Variablen sind
optional, ersparen `brew` aber den `shellenv`-Aufruf bei jedem Start.

Prüfen, in der laufenden Sitzung:

```nu
$env.PATH = ($env.PATH | prepend "/home/linuxbrew/.linuxbrew/bin")
which brew
brew --version
```

## Schritt 3 — brew-Userland

```nu
brew install --dry-run nushell helix jq    # Bottle oder Quelltext-Bau?
brew install nushell helix jq
which -a nu hx jq
```

*Diskussion.* Helix und Nushell bewegen sich schneller als Fedoras
Release-Zyklus; brew liefert oft Wochen früher (dnf hatte 0.99.1, brew
liegt deutlich darüber). Beides sind blattständige Tools ohne
Systemabhängigkeiten — die Kategorie, für die brew gedacht ist. Das
Helix-Bottle bringt die Tree-sitter-Grammatiken mit; die 30-Pakete-Kette
(gcc, git, kernel-headers …), die das Fedora-RPM zog, entfällt —
`@development-tools` steht ohnehin als brew-Basis bereit.

> [!warning] Fürs bootc-Image gilt das Gegenteil
> Auf der Schulungsflotte müssen alle exakt dieselben Versionen vorfinden:
> dnf im Containerfile, gepinnt, mit Guard. brew zöge „latest zum
> Installationszeitpunkt" — auf zehn Maschinen an zehn Tagen zehn Versionen.
> Ist eine Fedora-Version wirklich zu alt, ist der saubere Weg COPR oder
> ein eigenes RPM, nicht brew im Image.

## Schritt 4 — Shells zuordnen

Login-Shell zurück auf Bash (falls noch Nushell gesetzt):

```nu
chsh -s /bin/bash
getent passwd $env.USER | split row ":" | last    # → /bin/bash
```

Meldet `chsh` eine ungültige Shell, fehlt der Eintrag:

```nu
"/bin/bash" | sudo tee -a /etc/shells | ignore
```

Danach auf Windows `wsl --shutdown`.

Terminal-Zuordnung — **auf den brew-Pfad**, da Nushell nicht mehr aus dnf
kommt:

```nu
mkdir ~/.config/foot
r#'[main]
shell=/home/linuxbrew/.linuxbrew/bin/nu
font=monospace:size=11
'# | save -f ~/.config/foot/foot.ini
```

kitty analog:

```nu
mkdir ~/.config/kitty
"shell /home/linuxbrew/.linuxbrew/bin/nu" | save -a ~/.config/kitty/kitty.conf
```

*Diskussion.* Der `wsl`-Einstieg von Windows landet weiterhin in Bash —
gewollt, wegen Interop und VS-Code-Remote. foot/kitty existieren nur
innerhalb der grafischen Sway-Session; die Zuordnung betrifft also genau
den GUI-Zweig. Rückweg im Fehlerfall:
`wsl -d FedoraLinux-44 -e /bin/bash`.

## Schritt 5 — Sway unter WSLg

Es gibt keinen Session-Modus und keinen Display-Manager: WSLg ist selbst
ein Wayland-Compositor, Sway startet als dessen Client und liefert den
gesamten Desktop in **einem** Windows-Fenster (maximieren → Desktop).
Anders als im nested Container läuft hier echtes systemd mit User-Session:
D-Bus, PipeWire, Portals sind da.

```nu
let sway_pakete = [
    sway sway-config-fedora sway-systemd foot
    grim slurp mako brightnessctl playerctl
    pipewire wireplumber xdg-desktop-portal-wlr
    google-noto-sans-fonts fontawesome-fonts
]
sudo dnf install -y ...$sway_pakete

ls /usr/share/sway/config.d/ | get name    # die bekannte Drop-in-Kette
```

Erst die tatsächlichen Definitionen aus dem laufenden System lesen, statt sie anzunehmen:

```nu
open /etc/sway/config
| lines
| enumerate
| where item =~ '^\s*set \$'
| each {|r| {zeile: ($r.index + 1), definition: ($r.item | str trim)} }
```

Alle Treffer müssen `zeile < 228` haben — dann sind sie im Drop-in benutzbar. Interessant sind `$term`, `$menu`, `$rofi_cmd`, `$left/$down/$up/$right`, ggf. `$lock`.

Host-Drop-in nach `/etc/sway/config.d/` — dieselbe Kette wie im Image,
Erkenntnisse bleiben übertragbar:

```nu
r##'# WSLg-Host: Sway als Wayland-Client
output WL-1 resolution 1920x1080 scale 1

input type:keyboard {
    xkb_layout "de"
    xkb_variant "nodeadkeys"
}

# Windows faengt Super ab, bevor WSLg es durchreicht.
# set $mod wirkt nur auf bindsym-Zeilen UNTERHALB dieser Zeile — die
# Defaults aus /etc/sway/config (Zeilen < 228) bleiben auf Mod4.
# $term, $menu, $left ... stammen von dort und sind hier bereits definiert.
set $mod Mod1

bindsym --to-code $mod+Return       exec $term
bindsym --to-code $mod+d            exec $menu
bindsym --to-code $mod+Shift+q      kill
bindsym --to-code $mod+Shift+c      reload
bindsym --to-code $mod+Shift+e      exec swaynag -t warning -m "Sway beenden?" -B "Ja" "swaymsg exit"

bindsym --to-code $mod+$left        focus left
bindsym --to-code $mod+$down        focus down
bindsym --to-code $mod+$up          focus up
bindsym --to-code $mod+$right       focus right
bindsym --to-code $mod+Shift+$left  move left
bindsym --to-code $mod+Shift+$down  move down
bindsym --to-code $mod+Shift+$up    move up
bindsym --to-code $mod+Shift+$right move right

bindsym --to-code $mod+f            fullscreen
bindsym --to-code $mod+v            splitv
bindsym --to-code $mod+b            splith
bindsym --to-code $mod+Shift+space  floating toggle

bindsym --to-code $mod+1 workspace number 1
bindsym --to-code $mod+2 workspace number 2
bindsym --to-code $mod+3 workspace number 3
bindsym --to-code $mod+4 workspace number 4
bindsym --to-code $mod+Shift+1 move container to workspace number 1
bindsym --to-code $mod+Shift+2 move container to workspace number 2
bindsym --to-code $mod+Shift+3 move container to workspace number 3
bindsym --to-code $mod+Shift+4 move container to workspace number 4

bar mode invisible
'## | sudo tee /etc/sway/config.d/20-wslg.conf | ignore
```

Starter — Variablen im Aufruf, nicht global (vgl. die
`WLR_RENDERER`-Warnung in [[docs/02-umgebung-wsl]]):

```nu
def sway-start [] {
    with-env {
        WLR_RENDERER: "pixman"
        WLR_NO_HARDWARE_CURSORS: "1"
        XDG_CURRENT_DESKTOP: "sway"
        XDG_SESSION_TYPE: "wayland"
        XDG_SESSION_DESKTOP: "sway"
    } { sway }
}
```

*Diskussion.* `WLR_RENDERER=pixman` ist auf dem XPS Pflicht: Fedoras Mesa
bringt keinen `d3d12`-Gallium-Treiber, aus `/dev/dxg` entsteht kein
Render-Node ([[docs/01-erkenntnisse]]). `resolution` bestimmt die
Fenstergröße, nicht die Panel-Auflösung — 1920×1080 ist Startwert;
`scale` bleibt 1, weil Windows bereits skaliert (zu klein → 1.25/1.5,
Augenmaß). Für Noctalia obendrauf gilt: Blur/Transparenz aus, Animationen
auf 0 — unter Pixman der Unterschied zwischen „ruckelt" und „normal".

Kontrolle innerhalb der Session:

```nu
swaymsg -t get_inputs | from json | select identifier xkb_active_layout_name
swaymsg -t get_outputs | from json | select name current_mode scale
systemctl --user status sway-session.target    # hier AKTIV, anders als im Container
```

## Referenz — dnf-Transaktionen lesen und zurücknehmen

Verifiziert am Rücknahme-Protokoll vom 2026-07-29 (dnf5, Fedora 44):

- `sudo dnf history list` — ID 1/2 sind der Image-Bau, nicht anfassen.
- `sudo dnf history info <id>` — vollständige Paketliste **vor** dem Undo.
- `dnf repoquery --userinstalled` ist hier die **falsche** Liste: sie
  enthält auch, was der Image-Builder als userinstalled markiert hat
  (bash, filesystem, NetworkManager …).
- **`upgrade`-Transaktionen nicht zurücknehmen** — das wäre ein Downgrade
  von (hier) 197 Paketen, kein Aufräumen.
- Undo **neueste zuerst**, ohne `-y` — die Bestätigungsliste ist der
  Kontrollpunkt und die ehrlichste Ansicht der tatsächlichen
  Abhängigkeitslage:

```nu
sudo dnf history undo 8
sudo dnf history undo 7    # aus einer BASH ausführen, wenn nushell selbst fällt
sudo dnf history undo 6
```

> [!tip] Nicht die eigene Shell entfernen
> `undo` der nushell-Transaktion aus Nushell heraus lässt den laufenden
> Prozess intakt, aber jeder neue `nu`-Aufruf (foot, kitty) scheitert.
> Vorher `bash` öffnen.

Abschlusskontrolle nach einer Rücknahme:

```nu
[sway foot pipewire] | each {|p|
    {paket: $p, weg: ((rpm -q $p | complete).exit_code != 0)}
}
```

## Offene Punkte

- [ ] `skopeo inspect` gegen quay.io mit der neuen Paketbasis — dann
      Zeile „skopeo: dnf empfohlen" von `entwurf` auf verifiziert
- [ ] `brew install --dry-run` für nushell/helix/jq auf aarch64: Bottles
      vorhanden oder Quelltext-Bau?
- [ ] foot unter WSLg: startet die Session ohne
      `sway-session.target`-Sonderfälle sauber durch?
- [ ] Noctalia-Schicht (quickshell aus Fedora-Repos vs. Git-Klon nach
      `~/.config/quickshell/`) — separater Abschnitt, sobald Sway steht
