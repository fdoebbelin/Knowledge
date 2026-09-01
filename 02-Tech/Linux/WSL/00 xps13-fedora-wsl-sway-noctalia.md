---
titel: XPS 13 — Fedora-WSL mit Sway und Noctalia (Gesamtleitfaden)
aliases: [WSL-Sway-Noctalia-Leitfaden, XPS-Werkbank-Gesamt]
teil_von: "[[README]]"
tags: [wsl, wslg, fedora, sway, noctalia, quickshell, terra, homebrew, nushell, helix, flatpak, obsidian, xps13]
zielgeraet: Dell XPS 13 9345 (Snapdragon X Elite, aarch64), FedoraLinux-44 WSL
konsolidiert_aus: ["[[13-xps13-wsl-installation]]", "[[14-xps13-wslg-sway-nushell-runde1]]", "[[15-xps13-noctalia-wslg]]", "[[15-xps13-noctalia-wslg_2]]"]
erstellt: 2026-08-17
verifiziert_gegen: Nushell 0.114.1, Noctalia v4.7.7 (Schema 59), Sway-Session auf dem XPS
status: konsolidiert
---

# XPS 13 — Fedora-WSL mit Sway und Noctalia: Gesamtleitfaden

Dieses Dokument fasst die vier Einzelnotizen 13, 14, 15 und 15_2 zu einem
durchgehenden Leitfaden zusammen: vom bereinigten Fedora-WSL-Basisimage bis
zur laufenden Noctalia-Bar mit Autostart, Flatpak und Obsidian. Wo die
Einzelnotizen sich widersprachen, gilt die **verifizierte** Fassung; wo eine
Annahme unterwegs widerlegt wurde, steht das Ergebnis im Fließtext und der
Irrweg dokumentiert in [[#11 — Widerlegte Annahmen ❌|Abschnitt 11]].

> [!info] Konsolidierungsregeln
> - Notiz 15 (Plan, 🟡/⬜) und 15_2 (Protokoll, ✅) beschrieben dasselbe
>   Thema. Maßgeblich ist 15_2; aus 15 bleibt nur, was dort exklusiv steht
>   (Terra-Risikoanalyse, Installationsvorschau).
> - Das Sway-Drop-in existierte in 13 (16:9, unkommentiert) und 14
>   (16:10, mit Parse-Reihenfolgen-Begründung). Hier steht nur die
>   korrigierte Fassung aus 14.
> - Statuskennzeichnung wie gehabt: **✅ verifiziert** (auf dem XPS bzw.
>   gegen Nushell 0.114.1 gemessen) · **🟡 hergeleitet** · **⬜ offen** ·
>   **❌ widerlegt**.
> - **Codeblöcke sind Nushell**, außer sie sind ausdrücklich als
>   ```` ```bash ```` gekennzeichnet. Das betrifft nur die Bootstrap-Phase
>   2.1–2.3, in der Nushell noch gar nicht installiert ist.

> [!warning] Abgrenzung — das hier ist die Werkbank
> Dieses Dokument beschreibt die **mutable Bastelumgebung** auf dem XPS.
> Nichts hieraus wandert 1:1 ins bootc-Image — dort gilt
> [[docs/03-bauen-und-testen]] bzw. [[09-yoga-buildumgebung]]: Pakete
> deklarativ im Containerfile, Drop-ins nach `/usr/share/sway/config.d/`,
> `rpm -q`-Guard. Die WSL-Distro ist **Werkbank und Scout**, nicht Vorbild.
> Hier wird *erkundet*, was dort *festgeschrieben* wird.

---

## 1 — Architekturentscheidungen

Bevor ein einziges Paket installiert wird, stehen drei Grundsatzentscheidungen.
Sie prägen jeden späteren Schritt, deshalb zuerst die Begründungen.

### 1.1 Warum die offizielle Fedora-WSL-Distro, nicht Sway Atomic

Naheliegend wäre gewesen, Sway Atomic — das Zielsystem der Schulungsflotte —
direkt unter WSL zu importieren. Das scheitert konzeptionell: Sway Atomic ist
ein bootc/ostree-Image, WSL importiert aber nur ein **flaches Rootfs**, bringt
den eigenen (Microsoft-)Kernel mit und kennt keine Deployment-Kette. `bootc
upgrade`, Rollback und das `/etc`-3-Wege-Merge — also genau die Mechanismen,
die das Image ausmachen — fielen ersatzlos weg. Ein Import wäre technisch
möglich, testet aber nichts von dem, was getestet werden soll. Fedora liefert
zudem **kein** Sway-WSL-Image; es gibt genau ein minimales Basis-Rootfs, auf
dem alles Weitere aufsetzt.

> [!note] Kein Microsoft Store
> Fedora verteilt bewusst nicht über den Store (Store-Richtlinien und
> Entwicklervertrag). Installation ausschließlich über
> `wsl --install FedoraLinux-44`; der exakte Distributionsname kommt aus
> `wsl --list --online`. Die aarch64-Images sind als BETA markiert.

**Erster Pflichtschritt nach dem Import: Benutzerpasswort setzen.** Die
Fedora-WSL-Distro legt beim ersten Start einen Benutzer im `wheel`-Verzeichnis
an, **vergibt aber kein Passwort**. Das fällt nicht sofort auf, sondern erst
beim ersten `sudo` — und dann sitzt man vor einer Passwortabfrage, auf die es
keine Antwort gibt. Da praktisch jeder Schritt ab 2.1 mit `sudo` beginnt, ist
das der eigentliche erste Handgriff:

```bash
sudo passwd $USER
```

Verweigert `sudo` schon das, ist das Konto ohne Passwort gesperrt und die
Kette beißt sich in den Schwanz. Ausweg über den Root-Einstieg auf der
**Windows**-Seite — WSL erlaubt das ohne Authentifizierung, weil die
Distro dem Windows-Benutzer gehört:

```powershell
wsl -d FedoraLinux-44 --user root
```

Darin dann `passwd <benutzername>`, `exit`, und der normale Einstieg
funktioniert.

> [!tip] Gegenprobe, bevor es weitergeht
> ```bash
> sudo -v && echo "sudo funktioniert"
> ```
> `sudo -v` erneuert nur den Zeitstempel und ändert nichts — der billigste
> Test dafür, dass die Authentifizierung steht. Erst danach lohnt sich 2.1.

> [!note] Weshalb hier kein `NOPASSWD`
> Die Versuchung, sich per `/etc/sudoers.d/` eine passwortlose Regel zu
> schreiben, ist auf einer Wegwerf-Werkbank groß. Sie kollidiert aber mit
> der Begründung in 10.7: Der brew-Präfix ist für den Benutzer schreibbar;
> je bequemer `sudo` wird, desto billiger wird der Weg von
> Benutzerzugriff zu Root. Ein Passwort ist der Preis dafür, dass diese
> Werkbank dieselben Reflexe trainiert wie das Flottensystem.

### 1.2 Die Zwei-Schichten-Regel: dnf unten, brew oben

Die zentrale Ordnungsidee der ganzen Umgebung: **zwei Paketschichten mit
klarer Zuständigkeit.**

**Homebrew ist für blattständige Userland-Tools.** Es installiert nach
`/home/linuxbrew/.linuxbrew`, bewusst isoliert vom System, und *kann* dort
nicht hineinregieren. Alles, was setuid-Helfer, `binfmt_misc`,
User-Namespaces, systemd-Units oder udev-Regeln braucht, muss deshalb aus
Prinzip per dnf kommen — brew hat auf diese Systemschichten schlicht keinen
Zugriff. Homebrew selbst nutzt vom Host nur glibc und gcc (beide auf
Fedora 44 neu genug) und erwartet die üblichen Entwicklungswerkzeuge als
Bootstrap-Basis.

| Paket | Schicht | Begründung |
|---|---|---|
| podman, buildah | **dnf, zwingend** | rootless braucht setuid `newuidmap`/`newgidmap`, `/etc/subuid`, System-`crun`/`conmon`/`netavark` |
| skopeo | dnf, empfohlen | liest `containers-common`-Konfiguration; als kohärenter Stack bei podman |
| containers-common | **dnf, zwingend** | `policy.json`, `registries.conf`, `storage.conf` — harte Abhängigkeit des Stacks |
| qemu-user-static | **dnf, zwingend** | registriert `binfmt_misc`-Handler — kategorisch außerhalb von brews Reichweite. Nur nötig für lokale Cross-Builds; die CI ([[docs/10-github-repository]]) macht das inzwischen nativ |
| flatpak | **dnf, zwingend** | setuid-`bwrap`, User-Namespaces, systemd-User-Units, Polkit (→ Abschnitt 8) |
| @development-tools, git-core, curl, file, procps-ng | **dnf** | brews eigene Bootstrap-Abhängigkeiten |
| wl-clipboard | dnf | Wayland-Systemschicht, von Helix genutzt |
| nushell, helix, jq, gawk | **brew** | reine CLI-Tools, aktueller als Fedora 44 |
| qemu-img (`brew install qemu`) | brew möglich | reine Userland-Konvertierung |

*Warum diese Trennung mehr ist als Ordnungsliebe:* Sie zahlt sich später
zweimal konkret aus. Erstens beim Terra-Repo (→ 6.1): dessen
`terra-obsolete`-Mechanik kann Fedora-Pakete still gegen Terra-Varianten
tauschen — `nu` und `hx` aus brew sind davon strukturell nicht betroffen.
Zweitens bei `sudo` (→ 10.7): brew-Binaries liegen außerhalb von
`secure_path`, und das ist ein Sicherheitsfeature, kein Fehler.

> [!warning] aarch64-Vorbehalt bei brew
> Linux-arm64-Bottles sind vorhanden, die Abdeckung ist aber dünner als bei
> x86_64. Fehlt ein Bottle, kompiliert brew aus dem Quelltext — dann greift
> die volle Toolchain. Vorher prüfen: `brew install --dry-run <paket>`.

> [!warning] Fürs bootc-Image gilt das Gegenteil
> Auf der Schulungsflotte müssen alle exakt dieselben Versionen vorfinden:
> dnf im Containerfile, gepinnt, mit Guard. brew zöge „latest zum
> Installationszeitpunkt" — auf zehn Maschinen an zehn Tagen zehn Versionen.
> Ist eine Fedora-Version wirklich zu alt, ist der saubere Weg COPR oder
> ein eigenes RPM, nicht brew im Image.

### 1.3 Login-Shell Bash, Nushell im Terminal

Die Login-Shell bleibt `/bin/bash`: stabiler Pfad, die POSIX-Kette
(`/etc/profile`) läuft durch, VS-Code-Remote und die Windows-Interop
funktionieren. Nushell wird stattdessen dem Terminal-Emulator zugeordnet und
ist damit reine *interaktive* Shell.

Diese Aufteilung löst nebenbei einen Konflikt: Nushell aus brew als
**Login**-Shell wäre riskant — der brew-Pfad ist beim WSL-Start nicht
garantiert, im schlimmsten Fall sperrt man sich aus. Als Terminal-Shell ist
der brew-Pfad unkritisch: Schlägt er fehl, öffnet man `bash` und repariert.
Der frühere Rat „Nushell für die Login-Shell aus dnf" ist damit
**gegenstandslos**, weil es keine Nushell-Login-Shell mehr gibt.

> [!important] Konsequenz für Konfigurationen — die Ursache mehrerer Fehler
> foot/kitty starten Nushell als *Nicht*-Login-Shell. Die Login-Kette hat
> Bash beim WSL-Einstieg bereits abgearbeitet; Nushell erbt die Umgebung.
> Alles, was Nushell selbst braucht — brew-PATH, `NU_LIB_DIRS`,
> `XDG_DATA_DIRS` — gehört deshalb zwingend in `env.nu`/`config.nu`, nie in
> Login-Dateien. **Nushell liest kein `/etc/profile.d/*.sh`** (siehe
> [[02-umgebung-wsl]]). Genau daran scheiterte später die
> Flatpak-Sichtbarkeit im Launcher (→ 8.2): `flatpak.sh` setzt
> `XDG_DATA_DIRS` in `/etc/profile.d`, und die Kette
> Nushell → Sway → Noctalia sieht davon nichts.

---

## 2 — Basisinstallation

> [!important] Reihenfolge beachten — bis einschließlich 2.3 gibt es kein Nushell
> Eine frisch importierte Fedora-WSL-Distro bringt **Bash** mit und sonst
> nichts. Nushell kommt in dieser Umgebung aus Homebrew (→ 1.2), und
> Homebrew wird erst in 2.2 installiert. Die Schritte 2.1 bis 2.3 sind
> deshalb zwingend **Bash**; ab 2.4 ist Nushell verfügbar und alles
> Weitere in diesem Dokument ist Nushell.
>
> | Schritt | Shell | Warum |
> |---|---|---|
> | 2.1 dnf-Systemschicht | Bash | einzige vorhandene Shell |
> | 2.2 Homebrew | Bash | Installer ist ein Bash-Skript |
> | 2.3 brew-Userland | Bash | installiert `nu` erst |
> | 2.4 `ensure-block` verankern | **Nushell** | ab hier vorhanden |
> | 2.5 brew-Umgebung für Nushell | Nushell | nutzt `ensure-block` |
> | 2.6 Shells zuordnen | Nushell | — |
> | ab Abschnitt 3 | Nushell | — |
>
> Wer diese Reihenfolge übergeht und die späteren `nu`-Blöcke früh
> einwirft, bekommt `nu: command not found` — kein Konfigurationsfehler,
> sondern schlicht ein noch nicht existierendes Programm.

### 2.1 Schritt 1: dnf-Systemschicht ✅ *(Bash)*

> [!warning] Voraussetzung: `sudo` muss funktionieren
> Ohne gesetztes Benutzerpasswort bleibt schon die erste Zeile stecken.
> Falls noch nicht geschehen: → 1.1, Abschnitt „Erster Pflichtschritt".

```bash
system=(
    @development-tools procps-ng curl file git-core
    containers-common podman buildah skopeo
    wl-clipboard
)
sudo dnf install -y "${system[@]}"

# Guard — Exit-Code prüfen, nicht der Ausgabe glauben:
for p in podman buildah skopeo containers-common git-core; do
    if rpm -q "$p" >/dev/null 2>&1; then echo "ok    $p"; else echo "FEHLT $p"; fi
done
```

*Erklärung der Konstruktion:* Das Bash-Array `system=( … )` plus die
Expansion `"${system[@]}"` gibt dnf dieselben Argumente wie eine lange
Einzelzeile, hält die Liste aber lesbar und kommentierbar. Die Quotes um
`${system[@]}` sind Pflicht — ohne sie zerlegt Bash Einträge mit
Leerzeichen erneut. Der Guard danach folgt einer Grunddisziplin aus
[[01-erkenntnisse]]: Ein erfolgreicher Exit-Code von `dnf` ist **kein**
Beweis, dass ein bestimmtes Paket wirklich installiert wurde — `rpm -q`
pro Paket ist der Beweis.

> [!note] Dieselbe Aufgabe später in Nushell
> Ab 2.4 lautet das Idiom für denselben Aufruf Liste plus
> **Spread-Operator**, weil Nushell weder Arrays in Bash-Syntax noch
> Backslash-Fortsetzung für externe Befehle kennt (→ 13.1):
> ```nu
> let system = [podman buildah skopeo]
> sudo dnf install -y ...$system
>
> $system | each {|p| {paket: $p, ok: ((rpm -q $p | complete).exit_code == 0)} }
> ```
> `(… | complete).exit_code` ist dabei das Nushell-Gegenstück zum
> `if rpm -q …` oben: Es fängt den Exit-Code strukturiert ab, statt
> Ausgabetext zu parsen. Diese Form wird im Rest des Dokuments
> durchgängig als Guard verwendet.

*Diskussion:* `containers-common` steht explizit in der Liste, obwohl dnf es
ohnehin als Abhängigkeit zöge — so wird die Absicht sichtbar und das Paket
überlebt ein späteres Autoremove der Nachbarn. Eigene Registry-Anpassungen
(z. B. Signaturpolicy für `quay.io/metarow`) gehören nach
`/etc/containers/`, nicht nach `/usr/share/containers/` — dasselbe
Drop-in-Prinzip, das später bei Sway trägt (→ 7.3). `qemu-user-static`
bleibt draußen, bis lokale Cross-Builds wieder nötig werden; die CI baut
inzwischen nativ.

### 2.2 Schritt 2: Homebrew ✅ *(Bash)*

**Installation.** Das Installer-Skript ist Bash und wird hier auch aus Bash
heraus ausgeführt — der bekannte Einzeiler funktioniert also unverändert:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Robuster ist trotzdem der Umweg über die Datei — herunterladen, gegenlesen,
ausführen. stdin bleibt am Terminal, die interaktiven Abfragen des
Installers funktionieren, und man sieht vor dem Ausführen, was man
ausführt:

```bash
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew-install.sh
head -3 /tmp/brew-install.sh
/bin/bash /tmp/brew-install.sh
```

*Erklärung:* `/bin/bash` ist unproblematisch — `/bin` ist seit dem UsrMerge
ein Symlink auf `/usr/bin` (`readlink -f /bin` bestätigt das). Der
Installer legt den Präfix `/home/linuxbrew/.linuxbrew` an und braucht dafür
einmalig `sudo`.

> [!warning] Denselben Einzeiler später **nicht** in Nushell wiederholen
> Der macOS-Einzeiler `/bin/bash -c "$(curl …)"` scheitert in Nushell,
> weil `"$(…)"` Bash-Syntax ist: Nushell konsumiert die Anführungszeichen,
> Bash erhält eine *unquotierte* Substitution und versucht, `#!/bin/bash`
> als Programm auszuführen. Wer den Installer aus Nushell heraus erneut
> aufrufen muss (Reparatur, zweites Gerät), nimmt die Interpolation —
> Nushell führt das Externe aus und übergibt die Ausgabe als **ein**
> Argument:
> ```nu
> /bin/bash -c $"(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
> ```

**PATH für Bash.** Der Installer schreibt den Eintrag nicht zuverlässig
selbst; er gehört nach `~/.bashrc`, und für die laufende Sitzung wird er
zusätzlich sofort ausgewertet:

```bash
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

command -v brew
brew --version
```

Der PATH-Eintrag für **Nushell** folgt in 2.4 — `brew shellenv` gibt
Bash-Code aus und hat kein Nushell-Äquivalent, die Variablen müssen dort
von Hand gesetzt werden.

### 2.3 Schritt 3: brew-Userland ✅ *(Bash)*

```bash
brew install --dry-run nushell helix jq    # Bottle oder Quelltext-Bau?
brew install nushell helix jq

command -v nu hx jq
nu --version
```

*Diskussion:* Helix und Nushell bewegen sich schneller als Fedoras
Release-Zyklus; brew liefert oft Wochen früher (dnf hatte 0.99.1, brew lag
zum Zeitpunkt der Einrichtung bei 0.114.1). Beides sind blattständige Tools
ohne Systemabhängigkeiten — exakt die Kategorie, für die brew gedacht ist.
Das Helix-Bottle bringt die Tree-sitter-Grammatiken gleich mit; die
30-Pakete-Kette (gcc, git, kernel-headers …), die das Fedora-RPM zöge,
entfällt — `@development-tools` steht ohnehin als brew-Basis bereit. Der
`--dry-run` vorab ist auf aarch64 keine Formalie (→ 1.2, Bottle-Abdeckung).

**Ab hier existiert `nu`.** Alle folgenden Codeblöcke dieses Dokuments sind
Nushell, sofern nicht anders gekennzeichnet.

### 2.4 Schritt 4: Nushell starten und `ensure-block` verankern ✅

Erster Start — Nushell legt dabei `~/.config/nushell/env.nu` und
`config.nu` an, falls sie noch nicht existieren:

```bash
nu
```

> [!note] Seit 0.101 sind die Vorlagen leer
> Eine frische Installation schreibt **leere** Konfigurationsdateien und
> hält die Defaults intern. Findet sich stattdessen eine mehrere hundert
> Zeilen lange `config.nu`, stammt sie aus einer übernommenen
> Konfiguration einer älteren Version — dann zuerst Abschnitt 3
> abarbeiten, insbesondere 3.5.

**Warum dieser Helfer ganz am Anfang steht.** Jede folgende Änderung an
`config.nu` und `env.nu` — brew-Pfad, `XDG_DATA_DIRS`, die
Session-Funktionen aus Abschnitt 4 — ist eine *wiederholte* Änderung: Man
korrigiert einen Wert, probiert, korrigiert erneut. Mit `save -a` wächst
die Datei bei jedem Durchlauf um eine weitere Kopie, und irgendwann setzt
der dritte Block zurück, was der zweite gesetzt hatte. `ensure-block`
kapselt genau das weg: Es entfernt den alten Block zwischen seinen Markern
und setzt den neuen ein, **zwei Läufe erzeugen ein Markerpaar** (gemessen).
Deshalb kommt er vor der ersten Konfigurationsänderung, nicht danach.

Der Helfer selbst muss einmal von Hand hinein — er kann sich nicht mit sich
selbst schreiben, solange er nicht geladen ist. Die `if`-Bedingung macht
auch diesen einen Schritt wiederholbar:

```nu
if not (open --raw $nu.config-path | str contains "def ensure-block") {
    r##'# >>> noctarow:werkzeuge >>>
def ensure-block [datei: path, marke: string, inhalt: string] {
    let start = $"# >>> ($marke) >>>"
    let ende  = $"# <<< ($marke) <<<"
    let zeilen = (if ($datei | path exists) { open --raw $datei | lines } else { [] })
    let a = ($zeilen | enumerate | where {|r| ($r.item | str trim) == $start} | get index)
    let b = ($zeilen | enumerate | where {|r| ($r.item | str trim) == $ende}  | get index)
    let ohne = (if (($a | is-empty) or ($b | is-empty)) { $zeilen } else {
        ($zeilen | first ($a | first)) ++ ($zeilen | skip (($b | last) + 1))
    })
    let rumpf = ($ohne | str join "\n" | str trim --right)
    let kopf = (if ($rumpf | is-empty) { [] } else { [$rumpf ""] })
    $kopf ++ [$start $inhalt $ende ""] | str join "\n" | save -f $datei
    print $"($datei): Block '($marke)' geschrieben"
}
# <<< noctarow:werkzeuge <<<
'## | save -a $nu.config-path
} else {
    print "ensure-block ist bereits in config.nu"
}

nu-check $nu.config-path
exec nu
```

*Erklärung der Konstruktion:*

- **`r##'…'##` statt `r#'…'#`** — der Block beginnt mit einer
  Kommentarzeile, und die Folge `r#'#` wird falsch gelext (→ 13.1). Der
  Helfer demonstriert die Falle also gleich am eigenen Beispiel.
- **`nu-check` vor `exec nu`** — ein Parse-Fehler in `config.nu` verwirft
  die **gesamte** Datei; ohne Vorabprüfung startet die nächste Shell ohne
  jede eigene Definition. Was `nu-check` dabei *nicht* findet, steht in 3.4.
- **`exec nu` ist nötig**, weil `config.nu` nur beim Start gelesen wird.
  Ohne den Neustart existiert `ensure-block` in dieser Sitzung nicht.
- **Der Helfer steht selbst zwischen Markern** — damit kann er sich später
  mit sich selbst aktualisieren oder nach `scripts/noctarow.nu` umziehen
  (→ 4.1), ohne dass man die Datei von Hand aufräumen muss.

Gegenprobe, dass er wirklich geladen ist und nicht nur in der Datei steht:

```nu
"ensure-block" in (scope commands | get name)      # → true
view source ensure-block | lines | length
```

### 2.5 Schritt 5: brew-Umgebung für Nushell ✅

Nushell liest weder `~/.bashrc` noch `/etc/profile.d/*.sh` (→ 1.3); der
Eintrag aus 2.2 hilft ihm also nichts. Zwar erbt ein aus Bash gestartetes
`nu` den PATH über die Prozessumgebung — darauf darf man sich aber nicht
verlassen, sobald `nu` von foot, kitty oder Sway gestartet wird. Nushell
muss selbstversorgend sein.

Erste Anwendung von `ensure-block`, und zugleich das Muster für alles
Folgende:

```nu
ensure-block $nu.env-path "noctarow:brew" (
    r##'$env.PATH = ($env.PATH | prepend [
    "/home/linuxbrew/.linuxbrew/bin"
    "/home/linuxbrew/.linuxbrew/sbin"
])
$env.HOMEBREW_PREFIX = "/home/linuxbrew/.linuxbrew"
$env.HOMEBREW_CELLAR = "/home/linuxbrew/.linuxbrew/Cellar"
$env.HOMEBREW_REPOSITORY = "/home/linuxbrew/.linuxbrew/Homebrew"'##
)

nu-check $nu.env-path
exec nu
```

*Erklärung:* `$env.PATH` ist in Nushell eine **Liste**, kein
Doppelpunkt-String; die Übersetzung zum PATH-String für Kindprozesse
übernimmt Nushell selbst. (Achtung: Diese Sonderbehandlung gilt **nur** für
`PATH` — `XDG_DATA_DIRS` etwa muss als String mit Doppelpunkten gesetzt
werden, → 8.2.) Die `HOMEBREW_*`-Variablen sind optional, ersparen `brew`
aber den `shellenv`-Aufruf bei jedem Start. Die Marker setzt `ensure-block`
selbst — im Inhalt stehen sie deshalb nicht.

> [!tip] `prepend` ist idempotent, `ensure-block` macht es wiederholbar
> Zwei verschiedene Dinge, die gern verwechselt werden. Ohne
> `ensure-block` stünde nach dem dritten Korrekturlauf dreimal dasselbe
> `prepend` in `env.nu` — jeder Start hängte den Pfad erneut vorn an. Der
> PATH funktionierte weiterhin (nur mit Dubletten), aber die Datei wäre
> nicht mehr das, was man beim Lesen erwartet. Mit `ensure-block` ist der
> Zustand der Datei nach jedem Lauf **derselbe**, unabhängig davon, wie oft
> man ihn ausführt.

Prüfen, nach dem Neustart der Shell:

```nu
which brew nu hx
$env.PATH | where {|p| $p =~ "linuxbrew"}      # genau zwei Eintraege
```

Von hier an gilt für den Rest des Dokuments: **Eigene Zeilen in `config.nu`
und `env.nu` werden über `ensure-block` geschrieben**, nie über `save -a`.

### 2.6 Schritt 6: Shells zuordnen ✅

Login-Shell **muss** Bash sein (→ 1.3). Auf einer frisch importierten
Distro ist sie es bereits; der folgende Schritt ist eine Reparatur für den
Fall, dass sie früher auf Nushell umgestellt wurde:

```nu
chsh -s /bin/bash
getent passwd $env.USER | split row ":" | last    # → /bin/bash
```

*Erklärung:* `getent … | split row ":" | last` liefert das letzte Feld des
passwd-Eintrags — die Login-Shell. Nushell trimmt beim Capture die
Trailing-Newline, der Vergleich funktioniert direkt. Meldet `chsh` eine
ungültige Shell, fehlt der `/etc/shells`-Eintrag:

```nu
"/bin/bash" | sudo tee -a /etc/shells | ignore
```

Danach auf der Windows-Seite `wsl --shutdown`, damit der Login-Pfad neu
aufgebaut wird.

**Terminal-Zuordnung** — auf den brew-Pfad, da Nushell nicht aus dnf kommt:

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

*Diskussion:* Der `wsl`-Einstieg von Windows landet weiterhin in Bash —
gewollt, wegen Interop und VS-Code-Remote. foot/kitty existieren nur
innerhalb der grafischen Sway-Session; die Zuordnung betrifft also genau den
GUI-Zweig. Rückweg im Fehlerfall: `wsl -d FedoraLinux-44 -e /bin/bash`.


---

## 3 — Nushell-Konfiguration in Ordnung bringen

Bevor Sway sinnvoll betrieben werden kann, muss die Shell-Grundlage stimmen —
beim ersten `nu`-Start fielen zwei Fehler, bei der Reparatur kam ein dritter
ans Licht. Alle drei sind behoben und gemessen; die Lehren daraus prägen den
Rest des Dokuments.

> [!note] Betrifft nur übernommene Konfigurationen
> Die drei Fehler stammen aus einer `config.nu`/`env.nu`, die von einem
> anderen Gerät mitgebracht wurde. Wer in 2.4 wirklich leere Vorlagen
> vorgefunden hat, kann 3.1–3.3 überspringen — **nicht** aber 3.4: Der
> dort beschriebene Unterschied zwischen Parse- und Laufzeitfehlern gilt
> für jede selbst geschriebene Zeile.

Zur Einordnung der drei Fälle: 3.1 und 3.3 sind **Laufzeit**fehler
(umbenannte Bezeichner), 3.2 ist ein **Parse**fehler — und genau diese
Unterscheidung entscheidet darüber, ob `nu-check` das Problem findet
(→ 3.4).

### 3.1 Fehler 1: veraltetes `do`-Flag in `env.nu` ✅ behoben

`do --ignore-shell-errors` existiert seit einigen Versionen nicht mehr; heute
heißt es `--ignore-errors`. Reparatur (live bestätigt, `nu-check` → `true`):

```nu
cp $nu.env-path $"($nu.env-path).bak"
open --raw $nu.env-path
| str replace --all "--ignore-shell-errors" "--ignore-errors"
| save -f $nu.env-path
```

*Erklärung:* `open --raw` liefert den Dateiinhalt als String, ohne dass
Nushell versucht, die Datei als strukturierte Daten zu interpretieren — für
Text-Ersetzungen die richtige Form. Das Backup vorher ist Pflichtprogramm,
weil `save -f` überschreibt.

### 3.2 Fehler 2: relativer `use`-Pfad in `config.nu` ✅ behoben

**Gemessen (0.107 und 0.114.1): relative `use`-Pfade werden gegen das
Verzeichnis der Datei aufgelöst, nicht gegen das Arbeitsverzeichnis.** Die
Zeile `use scripts/noctarow.nu *` suchte also in
`~/.config/nushell/scripts/` — sie hat **nie** funktioniert, unabhängig
davon, wo `nu` gestartet wurde.

> [!warning] Frühere Vault-Aussage ist damit widerlegt
> Die Regel „`use scripts/noctarow.nu *` muss *nach* dem Anlegen des
> Projektverzeichnisses stehen" ist falsch bzw. irrelevant: Die Position in
> der Datei spielt keine Rolle, weil ein Parse-Fehler die **gesamte**
> `config.nu` verwirft (gemessen: gültige Zeilen *vor* der kaputten
> `use`-Zeile sind ebenfalls verloren). Ein
> `if ($pfad | path exists) { use … }` gibt es nicht — `use` ist
> parse-time, die Bedingung würde nie ausgewertet.

> [!important] Entscheidung: `const` + absoluter Pfad
> Sobald das Projektverzeichnis auf dem XPS existiert:
> ```nu
> const noctarow_modul = ($nu.home-dir | path join "projekte/noctarow/scripts/noctarow.nu")
> use $noctarow_modul *
> ```
> Gegen 0.114.1 verifiziert: `nu-check` → `true`, Modulbefehle verfügbar.
> Der Trick: `const` wird zur Parse-Zeit ausgewertet und ist damit für das
> ebenfalls parse-zeitige `use` sichtbar — eine `let`-Variable wäre es
> nicht. Bis dahin ist die Zeile aus `config.nu` entfernt.

### 3.3 Fehler 3: `$nu.home-path` existiert seit 0.114 nicht mehr ✅ behoben

Gemessener Versionsvergleich — eine **stille** Umbenennung ohne
Deprecation-Warnung:

| 0.107 | 0.114 |
|---|---|
| `$nu.home-path` | `$nu.home-dir` |
| `$nu.temp-path` | `$nu.temp-dir` |

Betroffen waren `env.nu` (`REGISTRY_AUTH_FILE`), der frisch geschriebene
`sway-start`-Block sowie mehrere Vault-Notizen. Sammelreparatur über beide
Konfigurationsdateien, mit Änderungsnachweis pro Datei:

```nu
[$nu.env-path, $nu.config-path]
| each {|f|
    let vorher = (open --raw $f)
    let nachher = (
        $vorher
        | str replace --all '$nu.home-path' '$nu.home-dir'
        | str replace --all '$nu.temp-path' '$nu.temp-dir'
    )
    if $vorher != $nachher { $nachher | save -f $f }
    {datei: ($f | path basename), geaendert: ($vorher != $nachher)}
}
```

Analog über `glob ~/projekte/noctarow/docs/*.md` für den Vault.

### 3.4 Die zentrale Lehre: `nu-check` prüft Syntax, nicht Semantik ✅

Die beiden Fehlerklassen aus 3.2 und 3.3 verhalten sich diametral — das ist
die wichtigste Nushell-Erkenntnis der ganzen Serie:

| | Parse-Fehler (`use scripts/…`) | Laufzeitfehler (`$nu.home-path`) |
|---|---|---|
| `nu-check` | **erkennt ihn** | **erkennt ihn nicht** (`true`!) |
| Wirkung | ganze Datei verworfen | Abbruch ab der Fehlerzeile |
| Zeilen davor | wirkungslos | bereits angewendet |

Konsequenz: `nu-check` allein ist kein Freibrief. Zusätzlicher Feldabgleich
vor jedem `exec nu` — er extrahiert alle `$nu.<feld>`-Referenzen aus den
Konfigurationsdateien und prüft sie gegen die tatsächlich existierenden
Felder der laufenden Version:

```nu
let bekannt = ($nu | columns)
[$nu.env-path, $nu.config-path]
| each {|f|
    open --raw $f
    | parse --regex '\$nu\.(?<feld>[a-z0-9-]+)'
    | get feld | uniq
    | where {|x| $x not-in $bekannt}
    | each {|x| {datei: ($f | path basename), unbekannt: $x}}
}
| flatten
```

Leere Tabelle → sauber.

### 3.5 Nebenbefund: 899-Zeilen-`config.nu` ist eine Altlast ⬜

Die Datei ist die alte Default-Vorlage aus einer Nushell weit vor 0.101 —
seither liefert Nushell **leere** Konfigurationsdateien aus und hält die
Defaults intern. Die Vorlage schleppt Syntax mit, die mit jedem Upgrade
weiter zerbricht; `--ignore-shell-errors` (3.1) war nur der erste Treffer.

> [!important] Empfehlung: leerer Start plus eigener Block
> ```nu
> mv $nu.config-path $"($nu.config-path).alt"
> mv $nu.env-path $"($nu.env-path).alt"
> ```
> **Vorher prüfen**, ob eigene Zeilen zwischen der Vorlage stecken:
> ```nu
> open $nu.config-path | lines | where {|z| ($z | str trim) != "" and not ($z | str starts-with "#")} | length
> ```
> Noch nicht ausgeführt — erst durchsehen, dann entscheiden.

---

## 4 — Werkzeugkette: `sway-start`, `sway-stop`, `sway-log` ✅

Diese Funktionen entstanden in Runde 1, versagten in Runde 2 auf lehrreiche
Weise und liegen jetzt in gehärteter Fassung vor. Ohne sie ist nichts an den
späteren Abschnitten reproduzierbar — deshalb stehen sie im Ablauf **vor**
dem ersten Sway-Start. Die Fehlergeschichte dahinter ist in
[[#10.2 Instanzenstau und Sparse-Logs: die Grenzen von `setsid --fork` ✅|10.2]] diskutiert.

### 4.1 Marker-Konvention — `ensure-block` ist bereits verankert

Der Helfer steht seit 2.4 in `config.nu`; hier wird er nur noch benutzt.
Zur Erinnerung die Aufrufform und die Konvention:

```nu
ensure-block $nu.config-path "noctarow:umgebung" $inhalt
```

Alle eigenen Einträge leben zwischen Markern
(`# >>> noctarow:umgebung >>>` … `# <<< noctarow:umgebung <<<`). Der
Vault-Text bleibt Quelle, die Datei ist Artefakt — dieselbe Philosophie wie
bei den Sway-Drop-ins (→ 5.4). Wer den Block dieses Abschnitts korrigiert,
führt schlicht denselben Aufruf erneut aus; die Datei sieht danach aus wie
nach dem ersten Mal.

Bereits vergebene Marken in diesem Dokument:

| Marke | Datei | Inhalt | Abschnitt |
|---|---|---|---|
| `noctarow:werkzeuge` | `config.nu` | `ensure-block` selbst | 2.4 |
| `noctarow:brew` | `env.nu` | PATH und `HOMEBREW_*` | 2.5 |
| `noctarow:umgebung` | `config.nu` | Editor-Variablen, Session-Funktionen | 4.2 |
| `noctarow:xdg` | `env.nu` | `XDG_DATA_DIRS` für Flatpak | 8.2 |

> [!note] Zielort ist auf Dauer nicht `config.nu`
> Sobald das Projektverzeichnis existiert, ziehen `ensure-block` und die
> Session-Funktionen als `export def` nach `scripts/noctarow.nu` um und
> werden per `const`+`use` eingebunden (→ 3.2). `config.nu` behält dann nur
> noch die `use`-Zeile. Steht als offener Punkt in Abschnitt 15.

### 4.2 Die gehärtete Fassung der drei Session-Funktionen

Der folgende Inhalt gehört unter die Marke `noctarow:umgebung` in
`config.nu` — also nicht ins REPL tippen, sondern als
`ensure-block $nu.config-path "noctarow:umgebung" (r##'…'##)` schreiben und
danach `nu-check $nu.config-path` sowie `exec nu`. Jede der
Design-Entscheidungen hier ist die Antwort auf einen konkreten Fehlschlag:

```nu
$env.EDITOR = "/home/linuxbrew/.linuxbrew/bin/hx"
$env.VISUAL = $env.EDITOR
$env.SUDO_EDITOR = $env.EDITOR

def sway-protokolle [] {
    glob ($nu.home-dir | path join ".local/state/sway-*.log") | sort
}

# Startet Sway abgekoppelt. Verweigert den Start bei laufender Instanz --
# mehrere Instanzen teilen sich sonst Output und Logdatei (Sparse-Loecher).
def sway-start [] {
    let laufend = (ps | where name == "sway" | get pid)
    if ($laufend | is-not-empty) {
        error make {msg: $"sway laeuft bereits: ($laufend | str join ', ') — erst sway-stop"}
    }
    let ts = (date now | format date "%Y%m%d-%H%M%S")
    let protokoll = ($nu.home-dir | path join $".local/state/sway-($ts).log")
    mkdir ($protokoll | path dirname)
    with-env {
        WLR_RENDERER: "pixman"
        WLR_NO_HARDWARE_CURSORS: "1"
        XDG_CURRENT_DESKTOP: "sway"
        XDG_SESSION_TYPE: "wayland"
        XDG_SESSION_DESKTOP: "sway"
    } {
        ^setsid --fork sway out+err> $protokoll
    }
    print $"sway abgekoppelt — Protokoll: ($protokoll)"
}

def sway-log [--zeilen: int = 40, --alles] {
    let dateien = (sway-protokolle)
    if ($dateien | is-empty) { error make {msg: "kein Protokoll gefunden"} }
    open --raw ($dateien | last)
    | lines
    | where {|z| $alles or (($z !~ "Circular avatars|inputDirection|weather without coordinates") and (($z | str trim) != "")) }
    | last $zeilen
}

# SIGTERM zuerst: Sway meldet sich bei WSLg ab und gibt seine Flaeche frei.
# kill --force hinterlaesst Weston in einem Zustand, den nur 'wsl --shutdown' loest.
def sway-stop [] {
    let pids = (ps | where name =~ "^(sway|qs|waybar|swayidle|mako|kanshi)$" | get pid)
    if ($pids | is-empty) { print "nichts zu beenden"; return }
    $pids | each {|p| kill $p } | ignore
    sleep 3sec
    let uebrig = (ps | where pid in $pids | get pid)
    if ($uebrig | is-not-empty) {
        print $"unwillig, SIGKILL: ($uebrig | str join ', ')"
        $uebrig | each {|p| kill --force $p } | ignore
        sleep 1sec
    }
    glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | each {|s| rm $s } | ignore
    ls $env.XDG_RUNTIME_DIR
    | where {|f| ($f.name | path basename) =~ '^wayland-[1-9]\d*(\.lock)?$'}
    | each {|f| rm $f.name } | ignore
    print $"beendet: ($pids | str join ', ')"
}
```

*Die Entscheidungen im Einzelnen:*

- **`setsid --fork` statt Hintergrund-Job oder systemd.** Gemessen: Die
  Shell ist nach **6 ms** wieder frei; das Protokoll füllt sich über
  vererbte Dateideskriptoren weiter. Die neue Session koppelt Sway vom
  Terminal ab — Terminal schließen reißt Sway nicht mehr mit. **Preis 1:**
  kein Exit-Code mehr; `sway-log` ist der einzige Rückkanal. **Preis 2**
  (erst in Runde 2 sichtbar geworden): Der Compositor sitzt in
  `/init.scope` statt in einer logind-Sitzung — Polkit, Sperre und
  Inhibitoren sind damit tot (→ 10.6). Die verworfene Alternative
  `systemd-run --user` würde genau das lösen, ist aber ungeprüft, ob der
  User-Manager unter WSL `WAYLAND_DISPLAY`/`XDG_RUNTIME_DIR` korrekt sieht.
- **Start-Verweigerung bei laufender Instanz.** `setsid --fork` schützt
  nicht vor einem zweiten `sway-start` — zeitweise liefen fünf Instanzen
  parallel (→ 10.2). Die Prüfung vorab ist billiger als jede Aufräumaktion.
- **Zeitstempel-Logs statt einer festen Datei.** `out+err> $protokoll` auf
  eine feste Datei kürzt sie bei jedem Start auf null; hält eine Altinstanz
  ihren Deskriptor mit altem Offset, entstehen Sparse-Löcher — 110 leere
  Zeilen im Log (→ 10.2). Pro Start eine eigene Datei löst das strukturell.
- **SIGTERM vor SIGKILL, mit Wartezeit.** Fünf `SIGKILL`s hintereinander
  verklemmten WSLgs Weston so, dass nur `wsl --shutdown` half (→ 10.3).
- **Socket-Aufräumen, `wayland-0` ausgenommen.** Nach `SIGKILL` bleiben
  `wayland-1` … `wayland-5` liegen. Ein `glob … | first` greift dann
  **alphabetisch den ersten**, nicht den aktuellen — man spricht gegen eine
  Leiche. `wayland-0` gehört WSLg und bleibt unangetastet. Die
  `.lock`-Dateien müssen mit weg, sonst überspringt der nächste Compositor
  die Nummer.

Beweis nach dem Einbau:

```nu
nu-check $nu.config-path
exec nu
view source sway-start | lines | find "sway-"     # muss den Zeitstempel-Pfad zeigen
open --raw $nu.config-path | lines | where {|z| $z =~ 'noctarow:umgebung'} | length   # → 2
```

Die letzte Zeile ist die Idempotenz-Probe: **genau zwei** Markerzeilen,
egal wie oft der `ensure-block`-Aufruf gelaufen ist.

> [!warning] REPL-Definitionen überleben nichts
> Wird eine Funktion nur in die laufende Shell getippt, ist sie beim
> nächsten Terminal weg — und der alte Stand aus `config.nu` greift wieder.
> Das hat mehrere Durchläufe gekostet. `view source <name>` gegen die Datei
> halten ist die Gegenprobe; die Prüfwerkzeuge dazu stehen in 13.2.

---

## 5 — Sway unter WSLg

### 5.1 Das Betriebsmodell verstehen 🟡

Es gibt keinen Session-Modus und keinen Display-Manager: **WSLg ist selbst
ein Wayland-Compositor** (ein angepasster Weston in der WSLg-System-Distro).
Sway startet als dessen *Client* und liefert den gesamten Desktop in
**einem** Windows-Fenster — maximieren ergibt den Desktop. Anders als im
nested Container läuft hier echtes systemd mit User-Session: D-Bus,
PipeWire und Portals sind vorhanden. Diese Verschachtelung
(Weston → Sway → Clients) ist der Schlüssel zu drei der später
diskutierten Probleme: dem Mod-Tasten-Problem (Windows fängt Super ab,
→ 10.1), dem „Noctalia landet auf Weston"-Fehler (→ 10.4) und dem
Weston-Hänger nach `SIGKILL` (→ 10.3).

### 5.2 Paketinstallation ✅

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

> [!note] Voraussetzung rofi
> `sway-config-fedora` zieht rofi als Abhängigkeit; es steht deshalb nicht
> explizit in der Liste. Gegenprüfen schadet nicht:
> ```nu
> [rofi-wayland foot] | each {|p| {paket: $p, da: ((rpm -q $p | complete).exit_code == 0)} }
> ```

> [!warning] `mako` im Rückblick
> `mako` steht hier noch in der Liste — mit Noctalia kollidiert es später
> als zweiter Notification-Daemon um `org.freedesktop.Notifications`
> (→ 7.1). Es bleibt installiert (nützlich, solange Noctalia nicht läuft),
> darf aber in der Noctalia-Sitzung nicht starten.

### 5.3 Erst lesen, dann konfigurieren ✅

Die Hauptkonfiguration `/etc/sway/config` stammt aus `sway-config-fedora`
und definiert Variablen (`$term`, `$menu`, `$rofi_cmd`,
`$left/$down/$up/$right`, ggf. `$lock`), die im eigenen Drop-in
wiederverwendet werden sollen. Vor jeder Annahme die tatsächlichen
Definitionen aus dem laufenden System lesen:

```nu
open /etc/sway/config
| lines
| enumerate
| where item =~ '^\s*set \$'
| each {|r| {zeile: ($r.index + 1), definition: ($r.item | str trim)} }
```

*Warum die Zeilennummer mitkommt:* Die Include-Direktive für
`config.d`-Drop-ins steht in **Zeile 228**. Nur Variablen, die *davor*
definiert sind (`zeile < 228`), sind im Drop-in bereits verfügbar — die
vollständige Begründung liefert die Parse-Reihenfolgen-Analyse in 10.1.

### 5.4 Das Drop-in `20-wslg.conf` ✅

Host-Drop-in nach `/etc/sway/config.d/` — dieselbe Drop-in-Kette wie im
Image, Erkenntnisse bleiben übertragbar. Dies ist die korrigierte Fassung
(16:10-Panel, Mod1, Variablen der Hauptkonfiguration wiederverwendet,
Xwayland deaktiviert):

```nu
r##'# WSLg-Host: Sway als Wayland-Client
output WL-1 resolution 1920x1200 scale 1

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

xwayland disable
'## | sudo tee /etc/sway/config.d/20-wslg.conf | ignore

sway --validate --config /etc/sway/config
```

*Erklärung der einzelnen Bausteine:*

- **`output WL-1 resolution 1920x1200 scale 1`** — `WL-1` ist der Name,
  den der wlroots-Wayland-Backend-Output unter WSLg trägt. `1920x1200`
  ist 16:10, passend zum Panel des XPS 13 9345 (die erste Fassung hatte
  fälschlich 16:9, → 10.5). `resolution` ist unter dem Wayland-Backend nur
  die **Startgröße** des Fensters — maximiert man es, folgt der Output.
  `scale 1` ist gemessen korrekt: WSLg meldet vorskalierte Pixel (→ 10.5).
- **`input type:keyboard`** — Fedora liefert **nirgendwo** einen
  `input`-Block (kein `50-keyboard.conf` in der Include-Kette, → 7.3);
  ohne diese Zeilen bleibt das Layout US.
- **`set $mod Mod1`** — Alt statt Super, weil Windows die Super-Taste
  abfängt, bevor WSLg sie durchreicht. Warum das `set` allein nicht
  reicht und die Bindings deshalb vollständig im Drop-in stehen, ist der
  Kern von 10.1.
- **`--to-code`** — ohne dieses Flag bindet Sway auf Keysyms; unter
  `de`-Layout landen `-`, `+`, Umlaute und geshiftete Ziffern auf anderen
  Tasten als im US-Layout gedacht. `--to-code` bindet auf die physische
  Position.
- **`bar mode invisible`** — die Sway-eigene Bar tritt ab; die Leiste
  liefert später Noctalia.
- **`xwayland disable`** — der X11-Socket-Pfad `/tmp/.X11-unix` existiert
  unter dieser WSL-Distro nicht; wlroots probiert Display 0–32 durch und
  produziert 33 Fehlzeilen pro Start (→ 10.6). Für die Werkbank ist
  Xwayland verzichtbar (Sway und Noctalia sind reines Wayland).
  **Preis:** X11-Anwendungen laufen nicht — Electron-Apps brauchen deshalb
  explizit Wayland (→ 8.1). Im Image bleibt Xwayland selbstverständlich an.

### 5.5 Erster Start und Diagnose in der Session ✅

Start über `sway-start` (→ 4.2). Kontrolle innerhalb der Session:

```nu
swaymsg -t get_inputs | from json | where type == "keyboard" | select identifier xkb_active_layout_name
swaymsg -t get_outputs | from json | select name current_mode scale
systemctl --user status sway-session.target    # hier AKTIV, anders als im Container

# Modifier live testen — bindsym per IPC wirkt sofort, ohne reload:
swaymsg 'bindsym Mod1+Return exec foot'

# Syntax und generierte Include-Liste:
sway --validate --config /etc/sway/config
glob $"($env.XDG_RUNTIME_DIR)/sway/*" | each {|f| {datei: $f, zeilen: (open $f | lines | length)} }
```

*Erklärung:* Das IPC-`bindsym` ist das schnellste Diagnosewerkzeug für
Tastaturprobleme — es umgeht die gesamte Konfigurationskette und zeigt
sofort, ob ein Modifier überhaupt bei Sway ankommt. Die generierte
Include-Liste im Laufzeitverzeichnis ist das Beweisstück für alle
Drop-in-Fragen (→ 7.3).

### 5.6 Mod-Tasten-Referenz ✅

| Sway-Name | Physische Taste | Alias |
|---|---|---|
| `Mod1` | Alt links | `Alt` |
| `Mod2` | NumLock | — |
| `Mod3` | frei (layoutabhängig) | — |
| `Mod4` | Super/Windows | `Super`, `Logo` |
| `Mod5` | AltGr (`ISO_Level3_Shift`) | — |

> [!warning] Unter `de`-Layout ist nur die *linke* Alt-Taste Mod1
> Die rechte ist AltGr → Mod5. Bindings funktionieren nur links. Bekannter
> Nebeneffekt des Alt-Wegs: Alt+D in Anwendungen (Firefox-Adressleiste,
> Menüs) wird von Sway abgefangen.

> [!note] Verworfene Alternative: CapsLock als Modifier ⬜
> `xkb_options "caps:super"` würde CapsLock zu Mod4 machen — Windows fängt
> nur den physischen Win-Scancode ab, die Umbelegung passiert erst in Sways
> XKB-Schicht. Alle Default-Bindings blieben nutzbar. Ob WSLg den
> CapsLock-Keycode unverändert durchreicht, ist aber nicht verifiziert —
> erst mit `wev` gegenprüfen, dann umstellen.

---

## 6 — Noctalia: Quelle, Installation, Start

### 6.1 Architekturentscheidung: Terra-RPM, nicht Git-Klon 🟡

Zwei Wege stehen zur Wahl, [[07-referenz-quellen]] nennt beide:

| | Terra-RPM (`noctalia-shell`) | `dnf install quickshell` + Git-Klon |
|---|---|---|
| Deckungsgleich mit dem Image | **ja** — identischer Pfad wie [[09-yoga-buildumgebung]] | nein |
| Quickshell-Variante | `noctalia-qs` (Fork, von Terra) | Fedora-`quickshell` (Upstream) |
| Version | Terra, ungepinnt, aktuell | Git-HEAD, beliebig aktuell |
| Fremdquelle im System | **ja — und zwar tief** (s. u.) | nein |
| Rückbau | `dnf remove` + Repo raus | `rm -rf` des Klons |
| Was es über das Image lehrt | **alles** | wenig |

**Entscheidung: Terra.** Die WSL-Distro ist Scout für das Image, nicht
Selbstzweck. Ein Git-Klon würde eine andere Quickshell-Binärvariante testen
als das Image ausliefert — gefundene Fehler wären nicht übertragbar, und
genau für die Übertragbarkeit existiert die Werkbank.

> [!important] `quickshell` **nicht** zusätzlich installieren
> `noctalia-qs` und `quickshell` liefern dieselben Provides und kollidieren.
> Das ist in [[09-yoga-buildumgebung]] bereits entschieden und korrigiert
> die ältere Annahme in [[07-referenz-quellen]]. Vorher prüfen:
> ```nu
> ["quickshell" "noctalia-qs" "noctalia-shell"]
> | each {|p| {paket: $p, installiert: ((rpm -q $p | complete).exit_code == 0)} }
> ```

**Die zwei Risiken von Terra auf einem *mutablen* System.** Im Containerfile
ist Terra harmlos: ein Build, ein Ergebnis, `rpm -q`-Guard. Auf einer
laufenden Distro mit regelmäßigem `dnf upgrade` ist die Lage anders:

> [!danger] Risiko 1 — Terra übernimmt den Qt-Stack
> `noctalia-qs` verlangt Qt 6.11. Bringt Fedora 44 weniger mit, hebt dnf
> `qt6-qtbase` **aus Terra** an — und damit hängt der gesamte Qt-Unterbau
> des Systems an einer Drittquelle. Im Image ist das ein bewusster,
> eingefrorener Zustand; auf der Werkbank zieht jedes `dnf upgrade` daran.

> [!danger] Risiko 2 — `terra-obsolete` verdrängt Fedora-Pakete still
> Terra liefert ein Paket, dessen einziger Zweck `Obsoletes`-Direktiven
> sind. Es kann Fedora-Pakete (beobachtet: `nushell`) stillschweigend gegen
> Terra-Varianten tauschen — ohne Fehler, ohne Rückfrage. Auf diesem Gerät
> kommen `nu` und `hx` aus **brew** und sind strukturell nicht betroffen
> (→ 1.2), aber die Mechanik greift für jedes andere Paket genauso.

**Konsequenz — Repo defensiv eintragen:** `enabled=0`, gezielt pro Befehl
aktivieren, `terra-obsolete` per `excludepkgs` ausschließen. Das kostet
einen Schalter pro Update und nimmt Terra die Möglichkeit, das System hinter
dem Rücken umzubauen. Bewusste Abweichung von der Image-Fassung
(`enabled=1`): dort ist der Build das Ziel, hier die Stabilität der
Werkbank.

### 6.2 Terra-Repo eintragen 🟡

```nu
r#'[terra]
name=Terra $releasever
baseurl=https://repos.fyralabs.com/terra$releasever
type=rpm
skip_if_unavailable=False
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://repos.fyralabs.com/terra$releasever/key.asc
enabled=0
enabled_metadata=1
metadata_expire=4h
excludepkgs=terra-obsolete
'# | sudo tee /etc/yum.repos.d/terra.repo | ignore

open /etc/yum.repos.d/terra.repo | lines | where {|z| $z =~ '^(enabled|exclude|gpg)'}
sudo dnf --enable-repo=terra makecache
```

> [!note] dnf5-Schreibweise
> Auf Fedora 44 (dnf5) heißt der Schalter `--enable-repo=terra`. Die
> dnf4-Form `--enablerepo=terra` wird noch als Alias akzeptiert — hier
> durchgängig die dnf5-Form.

Verfügbarkeit für **aarch64** prüfen, bevor irgendetwas installiert wird —
„Terra baut für beide Architekturen" und „Terra hat für fc44/aarch64 etwas
im Repo" sind zwei verschiedene Aussagen:

```nu
dnf --enable-repo=terra repoquery --queryformat '%{name}-%{version} %{arch} %{reponame}\n' noctalia-shell noctalia-qs
```

Leere Ausgabe → hier abbrechen und den Git-Weg aus 6.1 nehmen, statt an dnf
zu drehen.

### 6.3 Installation mit Vorschau ✅

Erst ansehen, was der Auflöser vorhat. `--assumeno` rechnet die Transaktion
vollständig durch und bricht vor dem Download ab — eine kostenlose
Generalprobe:

```nu
sudo dnf --enable-repo=terra install --assumeno noctalia-shell
```

> [!important] Worauf in der Vorschautabelle zu achten ist
> 1. **Spalte „Repository":** Wie viele Pakete kommen aus `terra` statt
>    `fedora`/`updates`? Alles jenseits von `noctalia-*` und einer Handvoll
>    Qt-Bibliotheken verdient eine Rückfrage.
> 2. **`qt6-*`-Zeilen unter „upgrading":** Das ist Risiko 1 in Aktion.
> 3. **Zeilen unter „replacing"/„obsoleting":** Muss leer sein. Ist sie es
>    nicht, greift `excludepkgs` nicht wie gedacht.
> 4. **Gesamtgröße:** Der Qt6-Unterbau ist kein Leichtgewicht; die
>    WSL-`vhdx` wächst und schrumpft nicht von allein.

Erst wenn die Vorschau sauber ist:

```nu
sudo dnf --enable-repo=terra install noctalia-shell

["noctalia-shell" "noctalia-qs"]
| each {|p| {paket: $p, ok: ((rpm -q $p | complete).exit_code == 0)} }
```

Was das Paket tatsächlich mitbringt — Binärnamen und Schriften nicht raten:

```nu
rpm -ql noctalia-shell | lines | where {|f| $f =~ '/(bin|share/fonts)/'}
rpm -ql noctalia-qs    | lines | where {|f| $f =~ '/bin/'}
which -a qs quickshell noctalia-shell
```

Diese `rpm -ql`-Abfrage hätte übrigens von Anfang an gezeigt, dass Noctalia
seine Icon-Schrift (`noctalia-tabler-icons.ttf`) selbst mitbringt — die
gesamte Material-Symbols-Suche war ein Irrweg (→ 11.1).

**Laufzeit-Nachbarn.** Noctalia ruft externe Werkzeuge auf; was fehlt, fällt
nicht laut aus, sondern äußert sich als leeres Widget:

```nu
["matugen" "cliphist" "wl-clipboard" "brightnessctl" "swww" "cava" "libnotify"]
| each {|p| {paket: $p, da: ((rpm -q $p | complete).exit_code == 0)} }

sudo dnf install matugen cliphist wl-clipboard    # aus Fedora, nicht aus Terra
```

### 6.4 Rendering: Warum `WLR_RENDERER=pixman` Noctalia nicht hilft ✅

Das ist die Stelle, an der sich diese Umgebung von jeder allgemeinen
Noctalia-Anleitung unterscheidet — und der teuerste Denkfehler der Serie
(ausführlich in 10.4).

> [!danger] Zwei getrennte Renderpfade
> `WLR_RENDERER` steuert **wlroots**, also Sway selbst. Quickshell ist ein
> gewöhnlicher Wayland-**Client** auf Qt6/QtQuick und ignoriert jedes
> `WLR_*` vollständig. QtQuick rendert über OpenGL — und auf diesem Gerät
> gibt es keinen Render-Node: `/dev/dri` fehlt, aus `/dev/dxg` entsteht
> ohne `d3d12`-Gallium-Treiber keiner ([[01-erkenntnisse#Umgebungsbefunde WSL]]).

Es bleiben zwei Wege, und sie sind **nicht** gleichwertig:

| | A: llvmpipe ✅ | B: Qt-Quick-Software-Backend |
|---|---|---|
| Variable | `LIBGL_ALWAYS_SOFTWARE=1` | `QT_QUICK_BACKEND=software` |
| Was rendert | Mesas Software-GL, **voller** GL-Pfad | Qts eigener 2D-Rasterizer |
| Shader / `ShaderEffect` | funktionieren | funktionieren **nicht** |
| Erwartetes Fehlerbild | langsam | fehlende oder schwarze Flächen |
| Aussagekraft fürs Image | brauchbar | gering |

**Weg A genügt** — bestätigt durch das Log:

```
DEBUG qt.qpa.wayland: Available client buffer integrations: QList("wayland-egl")
DEBUG qt.qpa.wayland: Using Wayland-EGL
```

Weg B wurde nie gebraucht und bleibt in der Schublade. Voraussetzung für A
prüfen — llvmpipe steckt in `mesa-dri-drivers`:

```nu
rpm -q mesa-dri-drivers
glob /usr/lib64/dri/*.so | path basename       # swrast_dri.so muss dabei sein
```

### 6.5 Der Start, der funktioniert ✅

Noctalia muss **als Kind von Sway** starten — nicht aus dem
WSL-Einstiegsprompt. Warum das entscheidend ist (Layer-Shell, `SWAYSOCK`,
Weston vs. Sway), steht ausführlich in 10.4; hier der verifizierte Ablauf:

```nu
# 1. Voraussetzung: genau eine Sway-Instanz, sauber gestartet
sway-stop
sway-start

# 2. Noctalia ALS KIND VON SWAY starten
let sock = (glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | first)
with-env { SWAYSOCK: $sock } {
    swaymsg exec -- env LIBGL_ALWAYS_SOFTWARE=1 qs -c noctalia-shell
}

# 3. Kontrolle
ps | where name =~ '^(sway|qs|waybar)$' | select pid ppid name
```

Erwartet: genau ein `sway`, ein `qs` als dessen Kind, **kein** `waybar`.

*Erklärung:* `swaymsg exec` lässt **Sway selbst** den Prozess starten; der
erbt damit `WAYLAND_DISPLAY` **und** `SWAYSOCK` von Sway statt von WSLgs
Weston. Ein foot-Fenster *innerhalb* der Sitzung täte es auch, aber
`swaymsg exec` hat zwei Vorteile: Die Ausgabe landet in Sways Log, und man
bleibt in der eigenen Nushell mit Historie.

Beweis, dass die Anbindung steht — eine Zeile:

```nu
open --raw (glob ($nu.home-dir | path join ".local/state/sway-*.log") | sort | last)
| lines
| where {|z| $z =~ '(?i)layershell|eglSwapBuffers'}
| length
```

`0` → sauber. Und im Log steht dann `Starting scan for WL-1` (nicht
`rdp-0`).

> [!tip] Erwartungsmanagement
> **Keine Performance-Schlüsse ziehen.** Ruckelnde Animationen unter
> llvmpipe sind das *erwartete* Ergebnis und kein Befund über das Image.
> Was diese Umgebung beweisen kann: startet die Shell, findet sie ihre
> Konfiguration, lädt sie ihre Schriften, kollidiert sie mit etwas — genau
> die Fehlerklassen, die sonst erst nach einem 30-minütigen Image-Bau
> auffallen.

---

## 7 — Noctalia integrieren: Kollisionen, Autostart, Skalierung, Konfiguration

### 7.1 Kollisionen auflösen ✅

Drei Gegenspieler streiten mit Noctalia um dieselben Rollen:

| Gegenspieler | Konflikt | Lösung |
|---|---|---|
| `waybar` (via `90-bar.conf`) | zweite Leiste | gleichnamige Leerdatei in `/etc/sway/config.d/` |
| `swayidle` (via `90-swayidle.conf`) | zweiter Idle-Daemon, streitet um die Sperre | gleichnamige Leerdatei |
| `mako` | zweiter Notification-Daemon; beide greifen nach `org.freedesktop.Notifications`, der Erste gewinnt | `mako` nicht starten |

Erst messen, welche Drop-in-Dateien es auf diesem System überhaupt gibt —
die Dateinamen hängen an der `sway-config-fedora`-Version:

```nu
(glob /usr/share/sway/config.d/*.conf) ++ (glob /etc/sway/config.d/*.conf)
| each {|f| {datei: $f, waybar: (open --raw $f | str contains "waybar"), idle: (open --raw $f | str contains "swayidle"), mako: (open --raw $f | str contains "mako")} }
| where {|r| $r.waybar or $r.idle or $r.mako}
```

Dann die leeren Overrides anlegen:

```nu
["90-bar.conf" "90-swayidle.conf"]
| each {|n| "" | sudo tee $"/etc/sway/config.d/($n)" | ignore }
```

*Erklärung des Mechanismus:* Eine **leere** Datei gleichen Namens in `/etc`
verdrängt die gleichnamige Datei aus `/usr/share` — die Include-Kette lädt
pro Namen genau eine Datei, und `/etc` gewinnt. Dass das wirklich so ist,
war bis zu dieser Runde unbewiesen; der Nachweis steht in 7.3 und ist einer
der wertvollsten Nebenerträge der ganzen Werkbank.

### 7.2 Autostart-Drop-in `95-noctalia.conf` ✅

**Erst nach erfolgreichem Handstart** (6.5). Die Umgebungsvariablen gehören
in die `exec`-Zeile, nicht global — global gesetzt sucht man Monate später,
warum nichts beschleunigt läuft (dieselbe Begründung wie die
`WLR_RENDERER`-Warnung in [[02-umgebung-wsl]]).

```nu
[
    "# Noctalia unter WSLg: Software-GL, weil kein Render-Node existiert."
    "# LIBGL_ALWAYS_SOFTWARE gilt nur fuer diesen Prozess, nicht fuer die Session."
    "# QT_SCALE_FACTOR skaliert Text UND Tabler-Icons -- Noctalias eigene"
    "# fontScale-Werte greifen nur auf die Textfamilie."
    "exec env LIBGL_ALWAYS_SOFTWARE=1 QT_SCALE_FACTOR=1.3 qs -c noctalia-shell"
    ""
] | str join "\n" | save -f /tmp/95-noctalia.conf

sudo cp /tmp/95-noctalia.conf /etc/sway/config.d/95-noctalia.conf
sway --validate --config /etc/sway/config
```

*Erklärung der Entscheidungen:*

- **`save` + `sudo cp` statt `sudo tee`:** Kein Quoting-Risiko, keine
  `secure_path`-Diskussion, keine Pipeline durch `sudo`. Hintergrund: Der
  Raw-String `r#'…'#` blieb beim REPL-Paste im Fortsetzungsmodus (`:::`)
  hängen — Ursache ungeklärt, im Skript funktioniert er. Die
  Listen-Variante ist die robustere Konstruktion (→ 13.1).
- **`exec`, nicht `exec_always`:** `exec_always` würde bei jedem
  `swaymsg reload` eine weitere Noctalia-Instanz starten. Kehrseite:
  `reload` löst `exec` **nicht** aus — getestet wird nur über vollständigen
  Neustart (`sway-stop` → `sway-start`). Im Image ist `exec` trotzdem
  richtig; dort gibt es keinen Reload-Zyklus.
- **Nummer `95-`:** liegt hinter den `90-`-Leerdateien — erst verdrängen,
  dann starten. Die Nummerierung entspricht bewusst dem Image.

Test:

```nu
sway-stop
sway-start
sleep 8sec
ps | where name =~ '^(sway|qs|waybar)$' | select pid ppid name
```

Verifiziertes Ergebnis: `sway 1284`, `qs 1293 (ppid 1284)`, kein `waybar`.

### 7.3 Nachweis: `/etc` überschattet `/usr/share` ✅

[[09-yoga-buildumgebung]] hielt fest, dass **nicht verifiziert** sei, ob
`/etc/sway/config.d/` eine gleichnamige Datei aus
`/usr/share/sway/config.d/` verdrängt — und wich deshalb im Image auf
direktes Überschreiben in `/usr/share` aus. Die Werkbank hat die Frage in
zwei Minuten geklärt, ohne einen Image-Bau. Der Beweis steht in der
generierten Include-Liste im Laufzeitverzeichnis:

```nu
open --raw (glob $"($env.XDG_RUNTIME_DIR)/sway/*" | first) | lines
```

```
include '/etc/sway/config.d/10-systemd-cgroups.conf'
include '/etc/sway/config.d/10-systemd-session.conf'
include '/etc/sway/config.d/20-wslg.conf'
include '/usr/share/sway/config.d/50-rules-browser.conf'
include '/usr/share/sway/config.d/50-rules-pavucontrol.conf'
include '/usr/share/sway/config.d/50-rules-policykit-agent.conf'
include '/usr/share/sway/config.d/60-bindings-brightness.conf'
include '/usr/share/sway/config.d/60-bindings-media.conf'
include '/usr/share/sway/config.d/60-bindings-screenshot.conf'
include '/usr/share/sway/config.d/60-bindings-volume.conf'
include '/usr/share/sway/config.d/65-mode-passthrough.conf'
include '/etc/sway/config.d/90-bar.conf'          ← /etc, nicht /usr/share
include '/etc/sway/config.d/90-swayidle.conf'     ← /etc, nicht /usr/share
include '/usr/share/sway/config.d/95-autostart-policykit-agent.conf'
include '/usr/share/sway/config.d/95-xdg-desktop-autostart.conf'
include '/usr/share/sway/config.d/95-xdg-user-dirs.conf'
```

Gegenprobe am Verhalten: Ab der Instanz, die nach dem Anlegen der
Leerdateien startete, taucht **kein `waybar` und kein `swayidle`** mehr als
Kindprozess auf.

> [!important] Rückmeldung an [[09-yoga-buildumgebung]]
> Der `/usr/share`-Umweg im Image ist eine **Vorsichtsmaßnahme, keine
> Notwendigkeit**. Er bleibt trotzdem die richtige Wahl: `/etc` unterliegt
> auf bootc dem 3-Wege-Merge, `/usr/share` nicht. Die Begründung ändert
> sich von „geht vielleicht nicht anders" zu „ist der sauberere von zwei
> funktionierenden Wegen" — und `/etc` bleibt für maschinenspezifische
> Abweichungen frei.

**Zwei Nebenbefunde aus derselben Liste:**

- Kein `50-keyboard.conf` — bestätigt auch hier den Kernbefund aus
  [[01-erkenntnisse]]: Fedora liefert nirgendwo einen `input`-Block.
- Fedoras Drop-ins nutzen ausschließlich `50-`, `60-`, `65-`, `95-`. Die
  Nummern `30-`, `70-`, `90-` sind frei.

### 7.4 Skalierung ✅

**Zwei Stellschrauben, oft verwechselt:**

| Was zu klein ist | Falscher Hebel | Richtiger Hebel |
|---|---|---|
| Arbeitsfläche (Platz) | `scale` | `resolution` hoch |
| Schrift/UI (Lesbarkeit) | `resolution` | `scale` hoch oder Schriftgrößen |

`resolution` = Fenstergröße in Gerätepixeln; `scale` teilt in logische
Pixel. Die `grim`-Messung (→ 10.5) ergab: WSLg meldet **vorskalierte**
Pixel (1920×1200), also ist `scale 1` korrekt und zu kleine Schrift eine
**Anwendungsfrage**, keine Compositor-Frage.

> [!important] Fraktionale Skalierung kostet unter Software-Rendering
> Ohne Render-Node läuft alles über Pixman. `output scale 1.5` erzwingt
> einen Resampling-Schritt über die volle Fläche — spürbar. Regel: `scale`
> ganzzahlig halten; liegt der Wunsch dazwischen, stattdessen auf
> Anwendungsebene skalieren. Genau deshalb ist `QT_SCALE_FACTOR` der
> bessere Hebel: Der Client rendert direkt in der größeren Auflösung,
> **kein Resampling durch den Compositor**.

**Der Noctalia-Befund:** Die Bar-Schrift lässt sich über Noctalias
Einstellungen vergrößern, **die Symbole nicht**. Die Symbole sind
Tabler-Icons — selbst Schriftzeichen, aber aus einer anderen Familie, auf
die `bar.fontScale` und `ui.fontDefaultScale` nicht wirken (Kandidat für
einen Upstream-Bug in 4.7.7). Lösung von außen: `QT_SCALE_FACTOR=1.3`
multipliziert **alles**, was Qt zeichnet — Text, Icons, Abstände, Rahmen —
und steht deshalb in der `exec`-Zeile des Drop-ins (7.2).

Noctalias eigene Werte vorher zurücksetzen, sonst multipliziert sich beides:

```nu
sway-stop
let cfg = ($nu.home-dir | path join ".config/noctalia/settings.json")
cp $cfg $"($cfg).bak-(date now | format date '%Y%m%d-%H%M')"
open $cfg | update bar.fontScale 1 | update ui.fontDefaultScale 1 | save -f $cfg
```

Der grobe Hebel für **alles** (auch foot, auch Obsidian) bleibt
`swaymsg output WL-1 scale 1.5` — Kosten: Resampling über die volle Fläche
unter Pixman, und die logische Arbeitsfläche schrumpft auf 1280×800.
Rückweg: `scale 1`.

### 7.5 `settings.json` konfigurieren (v4.7.7, Schema 59) ✅

> [!warning] Grundregel: Handeditieren nur bei beendeter Shell
> Noctalia schreibt die Datei selbst zurück — wer parallel von Hand
> editiert, verliert. Bevorzugt über das eingebaute Einstellungspanel
> ändern; Handeingriffe nur bei gestoppter Shell, danach
> `open $cfg | get <schlüssel>` als kombinierte Syntax- und Werteprobe
> (ungültiges JSON fällt hier auf, nicht erst beim nächsten Start).

Der Schlüsselbaum auf oberster Ebene:

```
appLauncher, audio, bar, brightness, calendar, colorSchemes, controlCenter,
desktopWidgets, dock, general, hooks, idle, location, network, nightLight,
noctaliaPerformance, notifications, osd, plugins, sessionMenu,
settingsVersion, systemMonitor, templates, ui, wallpaper
```

Die vier Schlüssel, die unter llvmpipe zählen — alle unter `general`:

| Schlüssel | Ist | Empfehlung WSL | Warum |
|---|---|---|---|
| `general.scaleRatio` | `1` | 1.25–1.5 | globaler UI-Maßstab; **im Panel nicht bedienbar**, nur per Hand |
| `general.enableBlurBehind` | `true` | `false` | Sway unterstützt `ext-background-effect-v1` nicht — wirkungslos, kostet Renderpfade |
| `general.enableShadows` | `true` | `false` | Schattenmasken sind unter Software-Rendering teuer |
| `general.animationSpeed` | `1` | `0.5` / `animationDisabled: true` | der Unterschied zwischen „ruckelt" und „normal" |

Bereits sinnvoll voreingestellt: `noctaliaPerformance.disableWallpaper:
true`, `disableDesktopWidgets: true`, `ui.translucentWidgets: false`,
`general.telemetryEnabled: false`.

> [!warning] `general.lockOnSuspend: true` unter WSL abschalten
> Das Log zeigt `Time jump detected (9s) - likely system resume`. WSL2
> friert die VM-Uhr bei Inaktivität ein; Noctalia deutet das als Resume.
> Sperrt es daraufhin, sitzt man in einer Umgebung ohne funktionierendes
> Polkit (→ 10.6) und ohne `fprintd` fest.

Änderungsablauf:

```nu
sway-stop
open $cfg | update general.scaleRatio 1.3 | save -f $cfg
open $cfg | get general.scaleRatio      # zugleich JSON-Syntaxprobe
sway-start
```

> [!tip] Blur: ein Fund für das Image
> `ext-background-effect-v1` wird von Sway generell nicht implementiert —
> weder hier noch auf dem Yoga. Der teuerste Renderpfad ist damit ohnehin
> aus. Der Befund gehört nach [[09-yoga-buildumgebung]].

---

## 8 — Flatpak und Obsidian ✅

### 8.1 Installation

Flatpak ist der Musterfall für die Zwei-Schichten-Regel (1.2):
setuid-`bwrap`, User-Namespaces, systemd-User-Units, Polkit — kategorisch
außerhalb von brews Reichweite. **Also dnf:**

```nu
sudo dnf install flatpak xdg-desktop-portal xdg-desktop-portal-gtk
```

*Erklärung:* `xdg-desktop-portal-gtk` ist keine Kür — GTK-Anwendungen
bekommen ohne dieses Backend keine Dateidialoge; das bereits installierte
`-wlr` deckt nur Screenshot/Screencast ab.

Voraussetzung prüfen — der WSL2-Kernel ist ein Microsoft-Build, User-
Namespaces sind nicht selbstverständlich:

```nu
open /proc/sys/user/max_user_namespaces | into int      # 63071 ✅
^bwrap --ro-bind / / --dev /dev true                    # muss ohne Fehler durchlaufen
```

Remote und Installation, durchgängig `--user` — kein Polkit nötig, und der
Polkit-Agent ist hier ohnehin defekt (→ 10.6):

```nu
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-info --user flathub md.obsidian.Obsidian    # Architekturpruefung
flatpak install --user flathub md.obsidian.Obsidian
```

> [!danger] Electron braucht Wayland — Xwayland ist ja abgeschaltet
> Obsidian ist Electron und startet standardmäßig über X11. Mit
> `xwayland disable` (5.4) erscheint sonst schlicht kein Fenster:
> ```nu
> flatpak override --user --env=ELECTRON_OZONE_PLATFORM_HINT=wayland md.obsidian.Obsidian
> flatpak override --user --env=LIBGL_ALWAYS_SOFTWARE=1 md.obsidian.Obsidian
> flatpak override --user --show md.obsidian.Obsidian
> ```

Start aus der Sway-Sitzung — dieselbe Lehre wie bei Noctalia (→ 10.4).
`$sock` ist keine dauerhafte Variable, sondern muss in der aktuellen Shell
gesetzt sein (wie in 6.5):

```nu
let sock = (glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | first)
with-env { SWAYSOCK: $sock } { swaymsg exec -- flatpak run md.obsidian.Obsidian }
```

Skalierung: intern `Strg++` bzw. *Darstellung → Zoom*, oder von außen
`ELECTRON_FORCE_DEVICE_SCALE_FACTOR=1.5` per `flatpak override`.

> [!warning] Vault nicht über `/mnt/c` öffnen
> Der 9p-Durchgriff aufs Windows-Dateisystem ist bei vielen kleinen Dateien
> sehr langsam — ein Obsidian-Vault ist genau das. Innerhalb der Distro
> (ext4) ist die Performance in Ordnung.

### 8.2 Launcher findet Flatpaks nicht ✅

Die `.desktop`-Datei existiert, aber `XDG_DATA_DIRS` enthält den
Exports-Pfad nicht:

```nu
$env.XDG_DATA_DIRS?
glob ($nu.home-dir | path join ".local/share/flatpak/exports/share/applications/*.desktop")
```

*Ursachenkette:* Flatpak setzt `XDG_DATA_DIRS` über
`/etc/profile.d/flatpak.sh` — und **Nushell liest kein `/etc/profile.d`**
(1.3). Sway erbt die Nushell-Umgebung, Noctalia erbt Sways Umgebung; die
Kette endet also bei Nushell. Reparatur in `env.nu`:

```nu
ensure-block $nu.env-path "noctarow:xdg" (
    r##'$env.XDG_DATA_DIRS = ([
    ($nu.home-dir | path join ".local/share/flatpak/exports/share")
    "/var/lib/flatpak/exports/share"
    "/usr/local/share"
    "/usr/share"
] | str join ":")'##
)

nu-check $nu.env-path
exec nu
```

**String mit Doppelpunkten, keine Liste** — nur `PATH` behandelt Nushell
als Liste (→ 2.5). Danach `sway-start`.

> [!note] Reine Werkbank-Reparatur
> Auf Sway Atomic startet Sway aus SDDM; dort greift die
> POSIX-Login-Kette und `XDG_DATA_DIRS` stimmt von allein. Der
> `env.nu`-Eintrag gehört **nicht** ins Containerfile.

### 8.3 Bazaar — grafischer Flathub-Client 🟡

Für bekannte App-IDs genügt die Kommandozeile (→ 8.5). Bazaar
(`io.github.kolunmi.Bazaar`, GTK4/libadwaita) ist der Schritt darüber:
Stöbern, Screenshots, Kategorien — und vor allem der Store, den Bluefin und
Aurora ausliefern. Damit ist er für die Schulungsflotte die naheliegende
Referenz, und die Werkbank ist der richtige Ort, ihn vorher zu prüfen.

Anders als GNOME Software ist Bazaar ausschließlich ein Flatpak-Client:
kein PackageKit, keine System- oder Firmware-Updates. Er läuft als
**Dienst**, hält seinen Zustand also auch bei geschlossenen Fenstern, und
kann Transaktionen in eine Warteschlange legen, während man weiterblättert.

> [!note] Projekt umgezogen
> Das Repository heißt inzwischen `bazaar-org/bazaar` (früher
> `kolunmi/bazaar`); die App-ID `io.github.kolunmi.Bazaar` blieb
> unverändert. Wer ältere Anleitungen liest, landet auf dem alten Pfad.

**Vorprüfung aarch64** — dieselbe Disziplin wie beim Terra-Repo (→ 6.2):
Flathubs arm64-Abdeckung ist dünner als die für x86_64, und „gibt es" ist
nicht „gibt es für diese Architektur":

```nu
flatpak remote-ls --user flathub --columns=application,arch,version
| lines
| where {|z| $z =~ '(?i)bazaar'}
```

Leere Ausgabe → hier abbrechen, statt an `flatpak` zu drehen.

**Installation:**

```nu
flatpak install --user flathub io.github.kolunmi.Bazaar

flatpak list --user --app | lines | where {|z| $z =~ '(?i)bazaar'}
```

> [!warning] Die Runtime ist der eigentliche Download
> Bazaar selbst ist ein Zehn-Megabyte-Paket; die GNOME-Platform-Runtime
> dahinter liegt im Gigabyte-Bereich. Sie wird von allen GTK-Flatpaks
> geteilt — aber die WSL-`vhdx` wächst dadurch und schrumpft nicht von
> allein (→ 8.5, Aufräumen).

**Start — als Kind von Sway**, dieselbe Lehre wie bei Noctalia (→ 10.4)
und Obsidian:

```nu
let sock = (glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | first)
with-env { SWAYSOCK: $sock } {
    swaymsg exec -- env LIBGL_ALWAYS_SOFTWARE=1 flatpak run io.github.kolunmi.Bazaar
}
```

Zum Diagnostizieren des ersten Starts ist der Vordergrundlauf in einem
foot-Fenster *innerhalb* der Sitzung besser — dann sieht man die
GTK-Meldungen:

```nu
with-env { LIBGL_ALWAYS_SOFTWARE: "1" } { flatpak run io.github.kolunmi.Bazaar }
```

> [!note] Der Suchanbieter läuft hier ins Leere
> Bazaar implementiert `org.gnome.Shell.SearchProvider2`, damit die
> Desktop-Suche Anwendungen findet. Unter Sway gibt es keine
> GNOME-Shell — der Dienst antwortet, aber niemand fragt. Für KDE gibt es
> ein KRunner-Plugin, für rofi/fuzzel nichts Fertiges. In dieser Umgebung
> ist das kein Fehler, sondern eine Funktion ohne Abnehmer.

### 8.4 Das dritte Rendering-Regime: GSK 🟡

Hier wiederholt sich das Muster aus 6.4 ein zweites Mal — und es lohnt
sich, die drei Schichten einmal nebeneinander zu sehen, weil jede ihre
eigene Variable liest und keine auf die der anderen reagiert:

| Schicht | Variable | wirkt auf | in diesem Dokument |
|---|---|---|---|
| wlroots (Compositor) | `WLR_RENDERER=pixman` | Sway selbst | 4.2, 5.4 |
| Qt / QtQuick | `QT_QUICK_BACKEND` | Quickshell, Noctalia | 6.4 |
| GTK4 / GSK | `GSK_RENDERER` | Bazaar, GTK-Flatpaks | hier |
| Mesa (darunter) | `LIBGL_ALWAYS_SOFTWARE=1` | **alle GL-Clients** | 6.4, hier |

`LIBGL_ALWAYS_SOFTWARE=1` ist die einzige Variable, die *quer* durch alle
Client-Toolkits wirkt, weil sie eine Ebene tiefer ansetzt: bei Mesa. Genau
deshalb ist sie auch für GTK der richtige erste Hebel.

`GSK_RENDERER` kennt die Werte `broadway`, `cairo`, `opengl`, `gl`, `ngl`,
`vulkan` und `help` (`GSK_RENDERER=help` listet sie). Seit GTK 4.14 ist
`ngl` der Standard; ohne Render-Node fällt GSK auf llvmpipe zurück, und
GTK erkennt llvmpipe und meidet dann von sich aus die neueren
GPU-Renderpfade.

> [!important] `GSK_RENDERER=cairo` ist die Notfallkrücke, nicht die Lösung
> Die Versuchung liegt nahe, bei einem Software-Renderer gleich auf den
> Software-Renderer der Anwendung zu schalten. GTK-Upstream hat dagegen
> ausdrücklich entschieden, für Software-Rendering **nicht** auf Cairo
> zurückzufallen — die Begründung im Changelog ist knapp und eindeutig:
> GL plus llvmpipe ist besser. Dazu kommt, dass der Cairo-Renderer
> unvollständig ist: 3D-transformierte Inhalte kann er nicht zeichnen und
> setzt stattdessen eine Fehlermarkierung.
>
> Das ist exakt dieselbe Lage wie Weg A / Weg B bei Qt (→ 6.4): Der
> Software-**GL**-Pfad ist langsam, aber vollständig und damit
> aussagekräftig fürs Image; der Toolkit-eigene 2D-Rasterizer ist schnell
> zu aktivieren und beweist nichts. Reihenfolge deshalb:
> ```nu
> # A — Regelfall
> with-env { LIBGL_ALWAYS_SOFTWARE: "1" } { flatpak run io.github.kolunmi.Bazaar }
>
> # B — nur wenn A gar nicht startet, und dann als Befund notieren
> with-env { LIBGL_ALWAYS_SOFTWARE: "1", GSK_RENDERER: "cairo" } {
>     flatpak run io.github.kolunmi.Bazaar
> }
> ```

**Der WebKit-Sonderfall.** Bazaar bindet `webkitgtk-6.0` für Web-Ansichten
ein — ein weiterer eigener Renderpfad im selben Prozess. Bleiben Bereiche
schwarz oder hängt das Fenster beim Öffnen einer Web-Ansicht, ist der
DMABuf-Renderer der übliche Verdächtige, weil er ohne Render-Node keine
Puffer bekommt:

```nu
flatpak override --user --env=WEBKIT_DISABLE_DMABUF_RENDERER=1 io.github.kolunmi.Bazaar
```

⬜ Auf diesem Gerät nicht gemessen — erst auslösen lassen, dann setzen. Die
kuratierten Artikel selbst sind übrigens **keine** Web-Ansicht: Bazaar
rendert deren Markdown mit GTK-Widgets.

**Persistente Umgebung statt Tipparbeit.** Was sich bewährt hat, gehört in
die Flatpak-Overrides, nicht in jede Startzeile:

```nu
flatpak override --user --env=LIBGL_ALWAYS_SOFTWARE=1 io.github.kolunmi.Bazaar
flatpak override --user --show io.github.kolunmi.Bazaar
```

> [!note] Anmeldung bei Flathub funktioniert hier nicht ⬜
> Bazaar speichert Flathub-Kontodaten über `libsecret` — das setzt einen
> laufenden Secret-Service (üblicherweise `gnome-keyring`) voraus, den
> diese Sitzung nicht hat. Favoriten und Lesezeichen sind damit kein
> testbarer Teil der Werkbank. Gehört in die Liste in Abschnitt 12.

### 8.5 Weitere Pakete über Flathub 🟡

Bazaar ersetzt die Kommandozeile nicht, es ergänzt sie. Für alles
Reproduzierbare — und alles, was in eine Notiz oder eine First-Boot-Liste
wandern soll — bleibt `flatpak` das Werkzeug. Durchgängig `--user`, aus
demselben Grund wie in 8.1: Ohne funktionierendes Polkit (→ 10.6)
scheitert jede systemweite Transaktion an der Rechteabfrage.

```nu
# Suchen
flatpak search gimp

# Genau ansehen, bevor installiert wird: Größe, Runtime, Architektur
flatpak remote-info --user flathub org.gimp.GIMP

# Installieren
flatpak install --user flathub org.gimp.GIMP

# Was ist da, und was kostet es?
flatpak list --user --app --columns=application,version,size

# Aktualisieren und aufräumen
flatpak update --user
flatpak uninstall --user --unused
```

> [!tip] `flatpak uninstall --unused` ist auf WSL kein Kosmetikbefehl
> Verwaiste Runtimes summieren sich schnell auf mehrere Gigabyte, und die
> `vhdx` gibt freigewordenen Platz nicht von selbst an Windows zurück.
> Nach größeren Aufräumaktionen ist auf der Windows-Seite
> `Optimize-VHD` bzw. `wsl --manage <distro> --set-sparse true` das
> Gegenstück — beides ⬜ auf diesem Gerät nicht durchgespielt.

> [!warning] Ausgabeformat nicht blind weiterverarbeiten ⬜
> `flatpak list --columns=…` liefert tabulargetrennte Zeilen, aber ob eine
> Kopfzeile mitkommt, hängt davon ab, ob die Ausgabe an ein Terminal geht.
> Vor `| from tsv` oder `| split column "\t"` also einmal roh ansehen:
> ```nu
> flatpak list --user --app --columns=application,version | lines | first 3
> ```
> Erst wenn das Format bekannt ist, lohnt sich eine strukturierte
> Auswertung — sonst baut man eine Pipeline auf eine Annahme.

**Wo Bazaar installiert.** Ein Punkt, den die Werkbank klären sollte,
bevor Bazaar auf die Flotte kommt: Legt Bazaar systemweit oder benutzerweit
an? Systemweite Transaktionen brauchen Polkit, und der ist hier defekt —
das Fehlerbild wäre dann ein Dialog, der nie erscheint, oder eine
Transaktion, die ohne Meldung stehen bleibt. Gegenprobe nach der ersten
Installation aus der Oberfläche:

```nu
flatpak list --user --app | lines | length
flatpak list --system --app | lines | length
```

### 8.6 Bazaar für die Flotte kuratieren ⬜

Der eigentliche Grund, Bazaar überhaupt anzusehen: Er ist für Distributoren
konfigurierbar, und zwar über YAML — Blocklisten, eine kuratierte Seite,
Suchgewichtungen und Hooks. Für den Schulungskontext ist das der
Unterschied zwischen „Appstore auf dem Flottengerät" und „kuratierter
Werkzeugkasten".

| Mechanismus | Was er tut | Nutzen für die Schulungsflotte |
|---|---|---|
| **Blocklist** (YAML oder TXT) | verbirgt App-IDs in Suche und Browsing | Ablenkung reduzieren, kaputte Pakete verstecken |
| **Curated-Seite** (YAML) | eigener Reiter mit Empfehlungen, Markdown-Artikeln, App-Kacheln | die Kurswerkzeuge nach vorn holen |
| **Search Biases** | Suchbegriffe umschreiben, Ergebnisse gewichten | „Editor" soll die Kurs-IDE finden |
| **Hooks** (`before-transaction`) | Shell-Snippet vor/nach Transaktionen, mit Dialog und Abbruchmöglichkeit | Warnung statt Verbot, wenn ein RPM der bessere Weg wäre |

Blocklisten sind erwartungsgemäß mächtig: Sie kennen `priority`,
`block`/`allow` mit und ohne Regex sowie Bedingungen wie `match-envvar` —
damit ließe sich etwa desktopabhängig unterscheiden.

> [!danger] Eine Blocklist ist keine Sicherheitsmaßnahme
> Das steht so in Bazaars eigener Dokumentation, und es ist der wichtigste
> Satz des ganzen Abschnitts: Bazaar fasst die zugrunde liegende
> Flatpak-Konfiguration **nicht** an. Blockierte Anwendungen verschwinden
> aus der Oberfläche — über das `flatpak`-Kommandozeilenwerkzeug bleiben
> sie vollständig installierbar. Für Fachinformatiker-Azubis, die ohnehin
> im Terminal arbeiten, ist eine Blocklist also Kuratierung, nicht
> Kontrolle. Wer wirklich begrenzen will, braucht andere Mittel
> (Repo-Auswahl, Polkit-Regeln, Image-Politik).

**Der praktische Haken bei der Konfiguration.** Bazaar sucht seine
Hauptkonfiguration in `/etc/bazaar` bzw. — aus der Sandbox gesehen — in
`/run/host/etc/bazaar`. Der Zugriff darauf braucht die Berechtigung
`filesystem=host-etc`, und **der Flathub-Build bringt sie nicht mit**.
Flatpak kann Berechtigungen für `/etc` und `/usr` derzeit nicht per
Override nachreichen; Bluefin und Aurora lösen das über
`systemd-tmpfiles`, die eine Override-Datei nach
`/var/lib/flatpak/overrides/io.github.kolunmi.Bazaar` legen. Ein eigener
Baustein also, kein Einzeiler — und auf dieser Werkbank mit `--user`-
Installation zusätzlich verschoben, weil die Overrides dann unter
`~/.local/share/flatpak/overrides/` liegen.

Zum Gegenlesen der Sandbox-Sicht, wenn eine Konfiguration nicht greift:

```nu
flatpak run --command=bash io.github.kolunmi.Bazaar
# darin: ls /run/host/etc/bazaar
```

> [!warning] Flatpaks lassen sich nicht ins bootc-Image backen
> `flatpak install` im Containerfile schreibt nach `/var/lib/flatpak` —
> und `/var` wird beim Image-Commit herausgelöst; der Inhalt ist nach dem
> Deployment weg. Der etablierte Weg (Bluefin, Bazzite) ist eine
> **First-Boot-systemd-Unit**, die eine Paketliste abarbeitet — eigener
> Baustein, kein Einzeiler. Die Werkbank kann dafür immerhin die
> Paketliste liefern: Was hier per `--user` erprobt wurde, ist genau die
> Liste, die die Unit später abarbeitet.

---

## 9 — Helix: von Schwarz-Weiß zu Farbe ✅

### 9.1 Diagnoseweg

`hx --health` trennt die zwei möglichen Ursachen für ein farbloses Helix:

1. **Runtime fehlt** → Themes nicht ladbar, hartes Minimal-Fallback
2. **Terminal meldet keine Farben** → `COLORTERM` leer, Truecolor aus

Befund auf dem XPS: Runtime vorhanden
(`…/Cellar/helix/25.07.1/libexec/runtime`, Highlight-Spalte durchgehend ✓),
aber **`Config file: default`** — es gab schlicht keine `config.toml`.
Helix' eingebautes Default-Theme ist bewusst ein reines
16-Farben-ANSI-Theme. Genau das gesehene Schwarz-Weiß: kein Fehler,
sondern fehlende Konfiguration.

> [!important] Entscheidung: kein `HELIX_RUNTIME` setzen
> Der Cellar-Pfad enthält die Version (`25.07.1`). Helix findet die Runtime
> relativ zur eigenen Binary — nach `brew upgrade helix` zeigt das
> automatisch auf das neue Verzeichnis. Ein fest gesetztes `HELIX_RUNTIME`
> würde nach dem ersten Upgrade auf ein gelöschtes Verzeichnis zeigen.
> Selbstheilung nicht kaputtkonfigurieren: Umgebung **nicht** anfassen.

### 9.2 Konfiguration

```nu
mkdir ~/.config/helix
r#'theme = "onedark"

[editor]
true-color = true
line-number = "relative"
bufferline = "multiple"

[editor.cursor-shape]
insert = "bar"
normal = "block"

[editor.indent-guides]
render = true
'# | save -f ~/.config/helix/config.toml
```

> [!note] `true-color = true` ist Pflicht, nicht Kosmetik
> Im Windows Terminal über WSLg ist `COLORTERM` oft nicht gesetzt — dann
> rechnet Helix Truecolor-Themes auf 16 ANSI-Farben herunter. Die Zeile
> erzwingt 24 Bit unabhängig von der Umgebung.

Themes live durchsehen: `:theme` + Tab-Vervollständigung (leere Liste =
Runtime doch nicht gefunden). Eigene Anpassungen als **Ableitung**, nicht
als Kopie eines Cellar-Themes — überlebt jedes Upgrade:

```nu
mkdir ~/.config/helix/themes
r#'inherits = "onedark"

"ui.background" = {}
'# | save -f ~/.config/helix/themes/noctarow.toml
```

---

## 10 — Problemdiskussion: die sieben Blocker und ihre Anatomie

Dieser Abschnitt versammelt die Probleme aller vier Runden in analytischer
Tiefe — jeweils Symptom, Diagnoseweg, Ursache, Lösung und was die Episode
über das System lehrt. Die Lösungen selbst sind bereits in die
Anleitungsabschnitte oben eingearbeitet; hier steht das *Warum*.

### 10.1 Sway reagiert auf keine Taste: Parse-Reihenfolge, nicht Tastatur ✅

**Symptom.** Sway startete, das Fenster stand — aber keine einzige
Tastenkombination tat etwas.

**Naheliegende (falsche) Verdächtige.** Tastaturlayout, WSLg-Eingabekette,
kaputte Bindings. Alle drei waren es nicht.

**Ursache — zwei Fakten, die zusammen das Symptom ergeben:**

1. **Sway expandiert Variablen zum Parse-Zeitpunkt.** `/etc/sway/config`
   enthält die Include-Direktive für `config.d`-Drop-ins in **Zeile 228**.
   Alle Default-`bindsym` der Hauptkonfiguration stehen *davor*,
   `set $mod Mod4` ganz oben. Ein `set $mod Mod1` im Drop-in wird erst bei
   Zeile 228 gelesen — da sind alle Default-Bindings längst als `Mod4+…`
   festgeschrieben. Das Drop-in-`set` wirkt nur auf `bindsym`-Zeilen, die
   *nach ihm* kommen.
2. **Windows fängt die Super-Taste ab**, bevor WSLg sie durchreicht.

Ergebnis: Alle Bindings hingen weiterhin an Super, und Super kam nie an —
exakt das beobachtete „reagiert auf nichts".

**Lösung.** Das Drop-in muss die benötigten `bindsym`-Zeilen **selbst**
setzen (mit `$mod = Mod1`); `set $mod` allein ist prinzipbedingt
wirkungslos. Die Alternative — die Hauptkonfiguration patchen — wurde
verworfen: `/etc/sway/config` stammt aus `sway-config-fedora` und würde bei
jedem Paketupdate überschrieben. Das Drop-in bleibt updatefest.

**Der produktive Umkehrschluss.** Dieselbe Parse-Zeit-Semantik wirkt auch in
die andere Richtung: `$term`, `$menu`, `$rofi_cmd`, `$left/$down/$up/$right`
sind *vor* Zeile 228 definiert — im Drop-in also bereits verfügbar. Die
erste Drop-in-Fassung hatte `exec foot` und `exec fuzzel` hartkodiert;
verworfen, weil der Fedora-Standard rofi ist und die Hardcodierung die
Kopplung an `sway-config-fedora` zerreißt. **Die Variablen der
Hauptkonfiguration sind der Vertrag, das Drop-in nutzt ihn.**

**Diagnosewerkzeug, das den Fall knackte:** `swaymsg 'bindsym Mod1+Return
exec foot'` — ein IPC-Binding wirkt sofort, ohne Konfigurationskette. Wenn
das funktioniert, die Konfigurationsdatei aber nicht, liegt das Problem im
Parsen, nicht in der Eingabe.

### 10.2 Instanzenstau und Sparse-Logs: die Grenzen von `setsid --fork` ✅

**Symptom.** Diffuses Fehlverhalten, im Log
`Another session found; refusing to overwrite the variables` — und 110 leere
Zeilen mitten in der Logdatei.

**Ursache 1 — Instanzenstau.** `setsid --fork` schützt Sway davor, dass das
*Terminal* es mitreißt — nicht davor, dass ein weiterer `sway-start` eine
zweite Instanz anlegt. Zeitweise liefen **fünf** parallel:

```
sway 1536 → waybar, swayidle
sway 1707 → waybar, swayidle
sway 1940 → qs
sway 2475, 2825 → (nichts)
```

**Ursache 2 — Sparse-Löcher im Log.** `out+err> $protokoll` auf eine feste
Datei kürzt sie bei jedem Start auf null (Truncate). Eine noch laufende
Altinstanz hält aber ihren Dateideskriptor **mit altem Offset** und schreibt
z. B. bei Byte 40.000 weiter — der Kernel füllt den Bereich davor mit
Nullbytes. Nachweis über die Differenz von scheinbarer und tatsächlicher
Größe:

```nu
^du -h --apparent-size ~/.local/state/sway-*.log
^du -h ~/.local/state/sway-*.log
```

**Lösung** (beide in `sway-start` eingebaut, → 4.2): Start-Verweigerung bei
laufender Instanz und pro Start eine eigene, zeitgestempelte Logdatei.

**Lehre.** Prozess-Lebenszyklus-Probleme tarnen sich als
Anwendungsprobleme. Der Instanzenstau wurde erst durch einen
Nushell-Zufallsbefund entdeckt (→ 13.1, PID-Liste in Klammerersetzung) —
die eigentliche Diagnose war `ps | select pid ppid name`, also die
Eltern-Kind-Beziehungen, nicht irgendein Log.

### 10.3 `kill --force` verklemmt WSLg: der Weston-Hänger ✅

**Symptom.** Nach einer Serie erzwungener Abbrüche zeigte das WSLg-Fenster
**keinen Inhalt** mehr — kein Sway-Hintergrund, kein foot, nichts. `grim`
blockierte endlos. Im Log:
`Didn't receive frame callback in time, window should now be inexposed`.

**Ursache.** WSLgs Weston räumt nach `SIGKILL` eines Compositor-Clients
nicht sauber ab und liefert Sways Fenster keine Frame-Callbacks mehr. Der
Zustand lebt in der **WSLg-System-Distro** — er überdauert jeden Neustart
der Fedora-Distro, weil die System-Distro davon unberührt bleibt.

**Einziger Ausweg** — auf der Windows-Seite:

```
wsl --shutdown
```

Danach funktionierte alles auf Anhieb, ohne dass an Sway oder Noctalia
irgendetwas geändert wurde — die sauberste Diagnose-Bestätigung, die man
sich wünschen kann.

**Lehre und Konsequenz.** Ein Compositor ist kein gewöhnlicher Prozess: Er
hält Protokollzustand beim übergeordneten Compositor. `sway-stop` setzt
deshalb SIGTERM zuerst (Sway meldet sich bei WSLg ab und gibt seine Fläche
frei), wartet drei Sekunden und eskaliert nur für die Unwilligen. Zusätzlich
müssen die verwaisten `wayland-N`-Sockets samt `.lock`-Dateien weg —
`wayland-0` (WSLg) ausgenommen —, sonst greift der nächste
`glob … | first` alphabetisch eine Leiche.

### 10.4 Noctalia landet auf Weston statt Sway — und der `WLR_RENDERER`-Denkfehler ✅

Das war der teuerste Komplex der Serie: zwei unabhängige Fehler, die sich
gegenseitig maskierten.

**Fehler A: falscher Compositor.** Aus dem WSL-Einstiegsprompt gestartet,
verbindet sich Quickshell mit **WSLgs eigenem Weston**, nicht mit Sway.
Vier Belege im Log, alle gleichzeitig:

| Logzeile | Bedeutung |
|---|---|
| `Wallpaper Starting scan for rdp-0` | `rdp-0` ist WSLgs Output; Sway heißt `WL-1` |
| `Using generic ext-workspace backend (no recognized compositor env)` | kein `SWAYSOCK` in der Umgebung |
| `WARN: Failed to initialize layershell integration` | Weston kennt `zwlr_layer_shell_v1` nicht |
| `Cannot create idle monitor as ext-idle-notify-v1 is not supported` | dito |

Und als Folgefehler:
`WARN qt.qpa.wayland: eglSwapBuffers failed with 0x300d, surface: 0x0`.
`0x300d` ist `EGL_BAD_SURFACE` bei Surface `0x0` — **kein GL-Problem**,
obwohl es exakt so aussieht. Die Bar hat nie eine Fläche bekommen, weil die
Layer-Shell-Anmeldung scheiterte: Noctalias Panels sind
Layer-Shell-Flächen, und ohne das Protokoll gibt es *prinzipiell* keine
Bar. Die Lösung (`swaymsg exec`, damit `WAYLAND_DISPLAY` und `SWAYSOCK` von
Sway geerbt werden) steht in 6.5.

**Fehler B: die falsche Rendering-Variable.** Parallel wurde versucht, das
vermeintliche GL-Problem mit `WLR_RENDERER=pixman` zu lösen — der
Denkfehler: Diese Variable steuert **wlroots**, also Sway selbst.
Quickshell ist ein gewöhnlicher Wayland-**Client** auf Qt6/QtQuick und
ignoriert jedes `WLR_*` vollständig. `sway-start` vererbt die Variable zwar
an alle Kindprozesse — für Qt ist das ein wirkungsloser String. QtQuick
rendert über OpenGL, und ohne Render-Node bleibt nur Mesas llvmpipe:
`LIBGL_ALWAYS_SOFTWARE=1` (Weg A in 6.4). Das Qt-eigene Software-Backend
(`QT_QUICK_BACKEND=software`) wäre die Notfallkrücke gewesen — ohne
Shader-Pfad und damit ohne Aussagekraft fürs Image — und wurde nie
gebraucht.

**Warum sich die Fehler maskierten.** Solange Noctalia auf Weston landete
(A), sah jedes Symptom nach einem GL-Problem aus (B) — `eglSwapBuffers
failed` klingt nach Renderer, nicht nach Compositor-Anbindung. Erst die
Trennung der beiden Fragen („*wo* verbindet sich der Client?" vs. „*womit*
rendert er?") löste den Knoten.

**Lehre.** Bei geschachtelten Compositoren ist die erste Diagnosefrage
immer: **Mit wem spricht der Client?** Der Output-Name im Log (`rdp-0` vs.
`WL-1`) beantwortet sie in einer Zeile. Und: Umgebungsvariablen wirken auf
den Prozess, dessen Bibliothek sie liest — `WLR_*` auf wlroots, `QT_*` auf
Qt, `LIBGL_*` auf Mesa. Wer die Schichten nicht auseinanderhält, kuriert am
falschen Patienten.

### 10.5 Skalierung: die `grim`-Messung beendet das Raten ✅

**Offene Frage.** Meldet WSLg dem Sway-Output *native* Panelpixel
(2880×1800 beim OLED) oder von Windows *vorskalierte* logische Pixel? Davon
hängt ab, ob `scale 1` oder `scale 2`+native `resolution` richtig ist. Die
Annahme „scale bleibt 1, weil Windows bereits skaliert" stand seit Runde 0
unbelegt im Raum.

**Messung.** `grim` liest Sways Framebuffer und braucht keine sichtbare
Fläche; die PNG-Dimensionen stehen im IHDR-Header ab Byte 16:

```nu
let wl = (ls $env.XDG_RUNTIME_DIR | get name | path basename
          | where {|n| $n =~ '^wayland-[1-9]\d*$'} | first)
let sock = (glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | first)
with-env { WAYLAND_DISPLAY: $wl, SWAYSOCK: $sock } { grim /tmp/probe.png }

let png = (open --raw /tmp/probe.png)
{
    breite: ($png | bytes at 16..19 | into int --endian big)
    hoehe:  ($png | bytes at 20..23 | into int --endian big)
}
```

**Ergebnis: 1920 × 1200.** WSLg meldet vorskalierte Pixel;
`resolution 1920x1200 scale 1` ist korrekt, zu kleine Schrift ist eine
Anwendungsfrage (→ 7.4). Nebenbei fiel bei der Messung ein Nushell-Fehler
auf: `bytes at 16..24` wären **neun** Bytes — Ranges sind inklusiv
(→ 13.1).

**Warum die Messung dem Augenmaß vorzuziehen war:** Die zwei Hypothesen
(native vs. vorskaliert) erzeugen *dasselbe* Bild auf dem Schirm, wenn
`scale` jeweils passend gewählt wird — nur die Performance unterscheidet
sich (Resampling unter Pixman). Ohne Messung hätte man womöglich dauerhaft
den teureren Pfad konfiguriert.

### 10.6 Xwayland-Fehlschlag und der Polkit-Preis von `setsid --fork` ✅

**Xwayland.** 33 identische Fehlzeilen pro Start:

```
[wlr] /tmp/.X11-unix is not a directory        (33×)
[wlr] No display available in the first 33
[sway/server.c:517] Failed to start Xwayland
```

Der Pfad **existiert schlicht nicht** (`"/tmp/.X11-unix" | path exists` →
`false`); wlroots meldet irreführend „is not a directory" auch bei `ENOENT`
und probiert Display 0–32 durch. Entscheidung: `xwayland disable` im
Drop-in — Sway und Noctalia sind reines Wayland, die 33 Zeilen verschwinden.
**Preis:** X11-Anwendungen laufen nicht mehr; Electron-Apps wie Obsidian
brauchen deshalb explizit `ELECTRON_OZONE_PLATFORM_HINT=wayland` (→ 8.1).
Im Image bleibt Xwayland selbstverständlich an.

**Polkit.** Beim Start meldet der Policykit-Agent:

```
[Line 446] Failed to find session
CRITICAL: polkit_agent_listener_register_with_options: assertion 'POLKIT_IS_SUBJECT (subject)' failed
INFO:assign-cgroups:compositor:5117 /init.scope
```

`loginctl list-sessions` zeigt durchaus Sitzungen, aber die Spalte `SEAT`
ist leer — und entscheidend: Sway sitzt in **`/init.scope`**, nicht in
einem `session-c*.scope`. Das ist die direkte Folge von `setsid --fork`
(→ 4.2): Die neue Prozess-Session koppelt den Compositor von der
logind-Sitzung ab. Ausgelöst wird die Meldung von
`95-autostart-policykit-agent.conf` aus dem Fedora-Paket.

> [!note] Das ist ein echter Preis, kein Schönheitsfehler
> Neben dem bekannten Verlust des Exit-Codes ist damit **alles nicht
> testbar, was über die logind-Sitzung läuft**: Polkit-Dialoge,
> Bildschirmsperre, Inhibitoren. Der in Runde 1 verworfene
> `systemd-run --user`-Weg würde das lösen — offen bleibt, ob der
> User-Manager unter WSL `WAYLAND_DISPLAY`/`XDG_RUNTIME_DIR` korrekt sieht
> (`systemctl --user show-environment` messen). Auf dem Image stellt sich
> die Frage nicht: Dort startet SDDM Sway innerhalb der Sitzung.
> Praktische Konsequenz auf der Werkbank: Flatpak konsequent `--user`
> (→ 8.1) und `general.lockOnSuspend: false` (→ 7.5) — eine Sperre ohne
> funktionierendes Polkit wäre ein Aussperren.

### 10.7 `sudo hx: command not found` — `secure_path` als Feature ✅

**Symptom.** `sudo hx …` → `sudo: hx: command not found`, obwohl `hx`
im Terminal funktioniert.

**Ursache.** Nicht Helix, sondern `secure_path` in `/etc/sudoers`: sudo
ersetzt `PATH` durch eine feste Liste ohne
`/home/linuxbrew/.linuxbrew/bin`. Direkte Konsequenz der
Zwei-Schichten-Regel (1.2).

**Entscheidung: `sudoedit`, nicht Pfad-Umgehung.** Und zwar aus einem
Sicherheits-, nicht einem Bequemlichkeitsargument:
`/home/linuxbrew/.linuxbrew` ist **für den User schreibbar**. Jede Binary
dort per `sudo` auszuführen hieße: Account-Zugriff = trivialer Root-Zugriff
(Binary austauschen, auf `sudo` warten). `sudoedit` dreht das um —
Temp-Kopie, der Editor läuft **als User** (deshalb greift `secure_path` gar
nicht erst), Rückschreiben als root:

```nu
$env.SUDO_EDITOR = "/home/linuxbrew/.linuxbrew/bin/hx"
sudoedit /etc/sway/config.d/20-wslg.conf
```

Dauerhaft über den `config.nu`-Block (4.2). Öffnet sich trotzdem `vi`:
`sudo sudo -V | lines | find -i editor` prüfen; ggf. `Defaults env_editor`
per `sudo visudo -f /etc/sudoers.d/10-editor`. `sudo /voller/pfad/hx`
funktioniert, bleibt aber die Ausnahme.

> [!note] Generierte Dateien nicht interaktiv editieren
> Die Drop-ins entstehen aus Vault-Codeblöcken. Änderungen gehören in den
> Block, der neu geschrieben wird — der Vault-Text bleibt Quelle, die Datei
> Artefakt. `sudoedit` ist der Weg für den Ausnahmefall. Auf dem
> bootc-Image stellt sich die Frage ohnehin nicht: Dort kommt `hx` aus dnf
> und liegt in `/usr/bin`, innerhalb von `secure_path`.

---

## 11 — Widerlegte Annahmen ❌

> [!failure] Drei Spuren, die nirgendwohin führten
> Sie stehen hier, damit sie nicht wiederkehren — und weil das Muster
> dahinter lehrreicher ist als jeder Einzelfall: **Alle drei Male stand die
> Antwort bereits im Log oder in `rpm -ql`, während anderswo gesucht
> wurde.**

### 11.1 Die Schriften waren nie das Problem ❌

`fc-list | find -i "material"` lieferte `0` — daraus wurde geschlossen,
dass Material-Symbols-Icons fehlen, und eine Diskussion um
`material-icons-fonts` (Legacy) versus den Google-Variable-Font geführt.
Zwei Fehler auf einmal:

1. **Noctalia nutzt Tabler Icons, nicht Material Symbols:**
   ```nu
   rpm -ql noctalia-shell | lines | where {|f| $f =~ '\.(ttf|otf)$'} | path basename
   # → noctalia-tabler-icons.ttf
   ```
2. **Die Schrift wird per QML-`FontLoader` geladen, nicht über
   fontconfig.** Deshalb sieht `fc-list` sie nicht — und das ist normal,
   kein Fehler.

Das Log sagte es die ganze Zeit: `Font Loaded 88 fonts, 8 monospace`, ohne
eine einzige Beschwerde. Textschrift: `fc-match "Sans Serif"` → Noto Sans,
funktioniert; `rsms-inter-fonts` plus `ui.fontDefault = "Inter"` ist
Geschmack, keine Notwendigkeit.

### 11.2 Das Platzhaltersymbol war kein fehlendes Wallpaper ❌

Das Symbol in der Bildmitte wurde auf `Wallpaper Scan completed found 0
files` und ein leeres `~/Pictures/Wallpapers` zurückgeführt. Tatsächliche
Ursache: `noctaliaPerformance.disableWallpaper: true` — die Anzeige war
ohnehin abgeschaltet. Der Log-Eintrag über den leeren Scan war korrekt,
führte aber in die Irre, weil er eine Kausalität suggerierte, die nicht
bestand.

### 11.3 `Could not load icon` liegt nicht am Icon-Theme ❌

`adwaita-icon-theme` war bereits installiert; die Warnung stammt von
`general.avatarImage: /home/fritz/.face` — und
`($nu.home-dir | path join ".face") | path exists` → `false`. Ein fehlendes
Avatar-Bild, kein Theme-Problem. Lösung: `~/.face` anlegen oder
`avatarImage` leeren.

---

## 12 — Was diese Umgebung nicht testen kann 🟡

Die Werkbank ist bewusst begrenzt. Ergänzt
[[01-erkenntnisse#Was der nested Container nicht testen kann]]:

| Bereich | Logbeleg | Grund |
|---|---|---|
| Bluetooth | `Failed to create DBusObjectManagerInterface for "org.bluez"` | kein bluez-Stack |
| Netzwerk-Widget | `Not authorized to recheck connectivity` | kein NetworkManager in der WSL-Distro |
| Temperatur | `No supported temperature sensor found` | kein hwmon |
| Akku, Helligkeit | — | kein upower, kein `/sys/class/backlight` |
| Sperre, Idle, Polkit | `POLKIT_IS_SUBJECT failed`, `/init.scope` | keine logind-Sitzung (→ 10.6) |
| Blur | `ext-background-effect-v1 is not supported` | **Sway generell**, nicht WSL-spezifisch |
| Multi-Monitor / `kanshi` | — | WSLg liefert genau einen Output (`WL-1`) |
| Screen-Recording | — | braucht den Render-Node, den es nicht gibt |
| Flathub-Anmeldung in Bazaar | — | kein Secret-Service (`libsecret`/gnome-keyring) (→ 8.4) |
| Desktop-Suchanbieter | — | kein gnome-shell, kein KRunner (→ 8.3) |
| Alles Performative | — | llvmpipe |

Was sie **kann** — und in diesen Runden bewiesen hat: Paketauflösung,
Startfähigkeit, Layer-Shell-Anbindung, Konfigurationspfade,
Drop-in-Reihenfolge, Kollisionen mit `waybar`/`swayidle`/`mako`, IPC,
Flatpak-Sandbox, Portale, Schriften — und seit dieser Runde auch:
Flathub-Verfügbarkeit für aarch64, Startfähigkeit von GTK4-Anwendungen
unter llvmpipe, Sandbox-Pfade für Bazaars Konfiguration. Genau die Fehlerklassen, die sonst
erst nach einem 30-minütigen Image-Bau auffallen.

---

## 13 — Nushell: Idiome, Fallen und Prüfwerkzeuge

### 13.1 Syntaxfallen dieser Serie ✅

Gemessen gegen 0.107 bzw. 0.114.1. Die obere Gruppe sind Parse-Fehler, die
untere Gruppe findet `nu-check` **nicht** (→ 3.4):

| Falsch | Richtig | Warum |
|---|---|---|
| Backtick/Backslash als Zeilenfortsetzung | Liste + Spread: `sudo dnf install -y ...$pakete` | Nushell kennt keine Fortsetzungszeichen für externe Befehle (`unexpected_eof`) |
| `r#'# Kommentar …'#` | `r##'# …'##` oder Leerzeile nach `r#'` | die Folge `r#'#` wird falsch gelext |
| `ls -l /bin \| get target` | `ls -lD /bin \| get target.0` | ohne `-D` wird der **Inhalt** des Linkziels gelistet, nicht der Link |
| `where waybar or idle` | `where {\|r\| $r.waybar or $r.idle}` | `where` nimmt einen Spaltenausdruck **oder** einen Block, keine Kurzform-Verknüpfung zweier Spalten |
| `ps \| select start_time` | `ls -l /proc/<pid> \| get modified` | `ps` hat nur `pid ppid name status cpu mem virtual` |
| `bytes at 16..24` (für 8 Bytes) | `bytes at 16..19` + `20..23` | Ranges sind **inklusiv** — `16..24` sind neun Bytes |
| `get -o -1` | `\| last` | `get` kennt kein `-1` |
| `sudo tee` + `r#'…'#` im REPL | `save` + `sudo cp` | Raw-String blieb im REPL-Paste im Fortsetzungsmodus (`:::`) hängen |
| `sudo open …` | `open` als User | `open` ist ein Builtin; `sudo` startet einen externen Prozess |

Verifiziert korrekt und im Dokument durchgängig genutzt:
`(extern | complete).exit_code`, `$"(curl …)"`-Interpolation,
`with-env {K: "v"} {…}` in Record-Form, `save -a` (legt fehlende Dateien
an), `prepend` mit Liste, `split row ":" | last` (Trailing-Newline wird
beim Capture getrimmt), Raw-Strings `r#'…'#` in Skripten und Regex-Filter
`where {|z| $z =~ '…'}`.

> [!warning] Mehrzeiliger Einwurf druckt nur die letzte Pipeline
> Ein Block mit mehreren Befehlen ist für Nushell **eine** Eingabe.
> Diagnosen immer einzeln absetzen, sonst gehen genau die Ausgaben
> verloren, die man braucht.

Nützlicher Zufallsbefund: Klammerersetzung mit einer PID-**Liste**
spachtelt alle Werte in einen einzigen Pfad —

```
cat: '/proc/1536'$'\n''1707'$'\n''1940/cgroup': No such file
```

— und deckte damit ungewollt den Instanzenstau auf (→ 10.2).

### 13.2 Prüfwerkzeuge für geladene Definitionen ✅

Benutzerdefinierte Befehle auflisten (`banner` und `pwd` sind bei Nushell
selbst `def`-Definitionen und immer dabei):

```nu
scope commands | where type == "custom" | select name description
```

Nur die eigenen — Abgleich gegen `config.nu`/`env.nu`:

```nu
let meine = (
    [$nu.config-path, $nu.env-path]
    | each {|f| open --raw $f | parse --regex '(?m)^\s*(?:export\s+)?def\s+(?:--env\s+)?"?(?<name>[^"\s\[]+)' | get name}
    | flatten | uniq
)
scope commands | where type == "custom" and name in $meine | select name
```

Gezielt prüfen, ob etwas geladen ist:

```nu
["sway-start" "sway-log" "sway-stop" "ensure-block"]
| each {|c| {befehl: $c, geladen: ($c in (scope commands | get name))} }
```

Live-Befund aus Runde 2, der die Prüfung rechtfertigt:
`sway-start`/`sway-log` meldeten `true`, `ensure-block` dagegen `false` —
er war damals nur ins REPL getippt worden, und REPL-Definitionen überleben
`exec nu` nicht. Genau diese Episode ist der Grund, warum er heute in 2.4
fest in `config.nu` verankert wird, bevor irgendetwas anderes geschrieben
wird. Geladenen Quelltext gegen die Datei halten:

```nu
view source sway-start    # weicht er von config.nu ab → alte Session
scope modules | select name commands | where name =~ "noctarow"
```

### 13.3 Referenz: dnf-Transaktionen lesen und zurücknehmen ✅

Verifiziert am Rücknahme-Protokoll (dnf5, Fedora 44) — das Verfahren, mit
dem die Distro vor Schritt 1 auf den Basiszustand gebracht wurde:

- `sudo dnf history list` — ID 1/2 sind der Image-Bau, nicht anfassen.
- `sudo dnf history info <id>` — vollständige Paketliste **vor** dem Undo.
- `dnf repoquery --userinstalled` ist die **falsche** Liste: Sie enthält
  auch, was der Image-Builder als userinstalled markiert hat (bash,
  filesystem, NetworkManager …).
- **`upgrade`-Transaktionen nicht zurücknehmen** — das wäre ein Downgrade
  von ~200 Paketen, kein Aufräumen.
- Undo **neueste zuerst**, ohne `-y` — die Bestätigungsliste ist der
  Kontrollpunkt und die ehrlichste Ansicht der Abhängigkeitslage:

```nu
sudo dnf history undo 8
sudo dnf history undo 7    # aus einer BASH ausführen, wenn nushell selbst fällt
sudo dnf history undo 6
```

> [!tip] Nicht die eigene Shell entfernen
> `undo` der nushell-Transaktion aus Nushell heraus lässt den laufenden
> Prozess intakt, aber jeder neue `nu`-Aufruf (foot, kitty) scheitert.
> Vorher `bash` öffnen.

Abschlusskontrolle:

```nu
[sway foot pipewire] | each {|p|
    {paket: $p, weg: ((rpm -q $p | complete).exit_code != 0)}
}
```

---

## 14 — Prüfliste

Der Gesamtzustand in einem Durchlauf:

```nu
# Genau eine Instanz, richtige Eltern-Kind-Beziehung
ps | where name =~ '^(sway|qs|waybar)$' | select pid ppid name

# Layer-Shell-Anbindung: muss 0 liefern
open --raw (glob ($nu.home-dir | path join ".local/state/sway-*.log") | sort | last)
| lines | where {|z| $z =~ '(?i)layershell|eglSwapBuffers'} | length

# Output
with-env { SWAYSOCK: (glob $"($env.XDG_RUNTIME_DIR)/sway-ipc.*.sock" | first) } {
    swaymsg -t get_outputs | from json | select name current_mode scale
}

# Include-Kette (Drop-in-Reihenfolge, /etc-Überschattung)
open --raw (glob $"($env.XDG_RUNTIME_DIR)/sway/*" | first) | lines

# Sockets: nur wayland-0 (WSLg) und genau ein wayland-N (Sway)
ls $env.XDG_RUNTIME_DIR | get name | path basename | where {|n| $n =~ '^wayland-'}

# Paketlage
["noctalia-shell" "noctalia-qs" "quickshell" "terra-obsolete" "matugen" "cliphist"
 "flatpak" "bubblewrap" "xdg-desktop-portal-gtk" "mesa-dri-drivers" "qt6-qtwayland"]
| each {|p| {paket: $p, da: ((rpm -q $p | complete).exit_code == 0)} }

# Woher kommt der Qt-Unterbau wirklich?
rpm -qa --queryformat '%{name} %{vendor}\n' | lines | find -i "qt6" | first 10

# Terra darf im Alltag nicht mitreden
open /etc/yum.repos.d/terra.repo | lines | where {|z| $z =~ '^enabled='}

# Läuft die Shell und antwortet ihre IPC?
qs -c noctalia-shell ipc show

# Flatpak-Sichtbarkeit fuer den Launcher
$env.XDG_DATA_DIRS

# Flatpak-Lage: Installationsumfang und Scope
flatpak list --user --app --columns=application,version
flatpak list --system --app | lines | length     # sollte 0 sein (kein Polkit)

# Gesetzte Overrides je Anwendung
["md.obsidian.Obsidian" "io.github.kolunmi.Bazaar"]
| each {|id| {app: $id, override: (flatpak override --user --show $id | complete | get stdout)} }
```

---

## 15 — Offene Punkte

Konsolidiert aus allen vier Notizen; erledigte Punkte (Handstart,
`grim`-Messung, `/etc`-Überschattung, Kollisionsauflösung, Drop-in-Test,
`settings.json`-Schlüsselbaum) sind gestrichen.

**Noctalia / Sitzung**

- [ ] `QT_SCALE_FACTOR`: endgültigen Wert festlegen und im Drop-in
      einfrieren (aktuell 1.3)
- [ ] Icons folgen `fontScale` nicht (→ 7.4) — als Issue an
      `noctalia-dev/noctalia-shell` melden, mit v4.7.7 / Schema 59
- [ ] `general.scaleRatio` fehlt im Einstellungspanel — bewusst oder Lücke?
- [ ] Wetter-Koordinaten setzen oder Widget entfernen (19-Sekunden-Takt im
      Log)
- [ ] `general.lockOnSuspend` auf `false` (→ 7.5)
- [ ] `~/.face` anlegen oder `avatarImage` leeren (→ 11.3)
- [ ] Launcher-Tastenkürzel: `qs -c noctalia-shell ipc show` auswerten und
      `96-noctalia-keys.conf` anlegen
- [ ] `mako`-Gegenprobe: Wer hält `org.freedesktop.Notifications`?
      (`busctl --user list | find -i notif`)
- [ ] CapsLock-als-Super mit `wev` verifizieren (→ 5.6)
- [ ] `systemd-run --user`-Weg prüfen (`systemctl --user
      show-environment`) — würde den Polkit-Preis aus 10.6 auflösen

**Nushell / Werkzeuge**

- [ ] Entscheidung 899-Zeilen-`config.nu`: durchsehen, dann leerer Start
      (→ 3.5)
- [ ] Projektverzeichnis anlegen (`~/projekte/noctarow` →
      `~/Projects/NoctaRow` — Namensfrage klären); danach
      `const`+`use`-Zeile zurück, `ensure-block` (Marke
      `noctarow:werkzeuge`, → 2.4) und die Session-Funktionen als
      `export def` nach `scripts/noctarow.nu` umziehen, `NU_LIB_DIRS` in
      [[02-umgebung-wsl]] anpassen
- [ ] `noctarow doc-check`: alle `nu`-Codeblöcke im Vault durch `nu-check`
      + `$nu`-Feldabgleich schicken (→ 3.4)
- [ ] `verifiziert_gegen:` in allen Vault-Notizen mit `nu`-Blöcken
      nachtragen
- [ ] `sudoedit`-Weg einmal durchspielen; falls `vi` startet:
      `env_editor` prüfen (→ 10.7)

**Rückmeldungen an andere Notizen**

- [ ] `/etc`-Überschattung als **verifiziert** in
      [[09-yoga-buildumgebung]] nachtragen (→ 7.3)
- [ ] Blur-Befund (`ext-background-effect-v1` fehlt Sway generell) nach
      [[09-yoga-buildumgebung]] (→ 7.5)
- [ ] Entscheidung v4 (`-legacy`) vs. v5-Track — steht in
      [[09-yoga-buildumgebung]] offen und betrifft beide Umgebungen
- [ ] `terra-obsolete`-Verhalten als Upstream-Bug an Fyra Labs melden
- [ ] First-Boot-Unit für Flatpaks, falls die Flotte welche bekommen soll
      (→ 8.6)

**Bazaar / Flathub**

- [ ] `remote-ls`-Vorprüfung: Gibt es `io.github.kolunmi.Bazaar` für
      **aarch64** auf Flathub? (→ 8.3)
- [ ] Erster Handstart unter `LIBGL_ALWAYS_SOFTWARE=1` — Ausgabe
      vollständig in diese Notiz übernehmen (→ 8.4 auf ✅ oder ❌)
- [ ] Web-Ansichten: tritt das DMABuf-Problem auf? Erst dann
      `WEBKIT_DISABLE_DMABUF_RENDERER=1` setzen (→ 8.4)
- [ ] Installiert Bazaar per `--user` oder `--system`? Systemweit hieße
      Polkit — und der ist hier defekt (→ 8.5)
- [ ] Ausgabeformat von `flatpak list --columns=…` messen, bevor eine
      Nushell-Pipeline darauf gebaut wird (→ 8.5)
- [ ] Kuratierung: Blocklist- und Curated-YAML für den Kurskontext
      entwerfen; Zugriffsweg auf `/etc/bazaar` unter `--user`-Installation
      klären (→ 8.6)
- [ ] `vhdx`-Rückgabe nach `uninstall --unused` prüfen
      (`wsl --manage … --set-sparse`) (→ 8.5)

**Basisschicht**

- [ ] `skopeo inspect` gegen quay.io mit der neuen Paketbasis
- [ ] `brew install --dry-run` auf aarch64 protokollieren: Bottles
      vorhanden oder Quelltext-Bau?

---

## 16 — Kernaussagen

1. **Parse-Zeit ist die Leitwährung dieser Umgebung.** Sway expandiert
   Variablen beim Parsen (`set $mod` im Drop-in ändert keine
   Default-Bindings, macht aber `$term`/`$menu` nutzbar), Nushells `use`
   und `const` sind parse-time (relative Pfade gelten relativ zur Datei,
   ein Parse-Fehler verwirft die ganze `config.nu`) — wer die Reihenfolge
   von Parsen und Ausführen nicht kennt, jagt Phantome.
2. **Umgebungsvariablen wirken auf die Bibliothek, die sie liest.**
   `WLR_RENDERER=pixman` rettet Sway, aber nicht Noctalia: Quickshell ist
   ein Qt6-Client und braucht seinen eigenen GL-Pfad —
   `LIBGL_ALWAYS_SOFTWARE=1`, und sie trägt.
3. **Bei geschachtelten Compositoren zuerst fragen: Mit wem spricht der
   Client?** Noctalia muss als Kind von Sway starten (`swaymsg exec`),
   sonst landet es auf WSLgs Weston, wo es keine Layer-Shell und deshalb
   prinzipiell keine Bar gibt — und der Folgefehler sieht täuschend nach
   einem GL-Problem aus.
4. **Ein Compositor ist kein gewöhnlicher Prozess.** `kill --force`
   hinterlässt Weston in einem Zustand, den nur `wsl --shutdown` löst —
   SIGTERM zuerst, immer; und `setsid --fork` kostet neben dem Exit-Code
   auch die logind-Sitzung samt Polkit.
5. **Messen schlägt Vermuten — die Antwort steht oft schon im Log.**
   `/etc` überschattet `/usr/share` nachweislich (zwei Minuten Werkbank
   statt eines Image-Builds), WSLg meldet vorskalierte Pixel (eine
   `grim`-Messung statt Augenmaß) — und mehrere Stunden gingen an
   Annahmen verloren, die `Font Loaded 88 fonts` von Anfang an widerlegte.

