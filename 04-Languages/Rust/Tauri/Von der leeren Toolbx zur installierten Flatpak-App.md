---
title: "Leitfaden: Tauri-App in Toolbx entwickeln und als Flatpak ausliefern"
shell: Nushell
werkzeugkette: cargo (ohne Node/npm)
zielgruppe: Fachinformatiker/-in (FISI/FIAE)
system: Fedora Sway Atomic (bootc/ostree)
stand: "Überarbeitete Fassung – alle Praxisprobleme eingearbeitet"
tags: [linux, atomic, container, toolbx, podman, rust, cargo, tauri, flatpak, nushell]
---

# Leitfaden: Von der leeren Toolbx zur installierten Flatpak-App

**Alle Befehle sind Nushell**, mit einer Ausnahme: Phase 0 richtet Nushell erst ein und ist daher in bash geschrieben. Abschnitt 21 stellt beide Shells gegenüber.

**Die Werkzeugkette ist durchgängig `cargo`** — kein Node, kein npm, kein Bundler. Das Frontend besteht aus einer HTML-Datei.

---

## 1 Der komplette Durchlauf im Überblick

| Phase | Wo | Werkzeug | Ergebnis |
|---|---|---|---|
| 0. Shell | Host | `curl`, `chsh` | Nushell in `~/.local/bin`, überall gültig |
| 1. Umgebung | Host | `toolbox` | Container `tauri-dev` |
| 2. Entwickeln | Toolbx | `cargo tauri dev` | laufendes Fenster unter Sway |
| 3. Release bauen | Toolbx | `cargo tauri build` | Binary, `.deb`, `.rpm` |
| 4. Paketieren | Host | `org.flatpak.Builder` | `de.metarow.Notizblock` |
| 5. Verteilen | Flotte | `flatpak` | installierte App |
| 6. Aufräumen | Host | `toolbox rm` | reproduzierbar leerer Stand |

> [!important] Zentrale Aussage
> Der **Entwicklungscontainer** ist zum Bauen da, nicht zum Ausliefern. Das ausgelieferte Artefakt entsteht in einer **anderen** Umgebung — der Flatpak-SDK — weil nur dort dieselben Bibliotheksversionen gelten wie auf dem Zielgerät.

## 2 Die vier Ebenen

| Ebene | Werkzeug | In diesem Beispiel |
|---|---|---|
| Basisimage | `rpm-ostree` / `bootc` | Kernel, Sway, Grafiktreiber, `flatpak` |
| Entwicklung | **Toolbx** | `gcc`, `webkit2gtk4.1-devel`, `librsvg2-devel`, Rust, `cargo-tauri` |
| Auslieferung | **Flatpak-SDK** | Release-Build gegen `org.gnome.Sdk` |
| Anwendung | Flatpak | die fertige App auf den Flottengeräten |

---

# Phase 0 — Eine Shell für alle Umgebungen

## 3 Nushell nach `~/.local/bin`

> [!danger] Der häufigste Anfängerfehler
> Nushell per `dnf`, COPR oder Homebrew **außerhalb** von `$HOME` zu installieren. Toolbx reicht `$HOME` durch — alles andere nicht. Ein Binary unter `/home/linuxbrew/...` oder `/usr/bin/` existiert im Container schlicht nicht, obwohl der Pfad in `$PATH` steht.
>
> Auf Fedora Atomic kommt eine zweite Falle dazu: `/home` ist ein Symlink auf `/var/home`. Im Container-Image ist `/home` dagegen ein echtes, leeres Verzeichnis. Host-Pfade unter `/home/...` lösen dort also ins Nichts auf.

Die Lösung: ein statisch gelinktes Binary im `$HOME`, nach dem Muster, das auch Claude Code verwendet — Versionsverzeichnis plus Symlink. Das folgende Skript läuft in **bash**, weil Nushell zu diesem Zeitpunkt noch fehlt.

```bash
JSON=$(curl -sS https://api.github.com/repos/nushell/nushell/releases/latest)
VER=$(printf '%s' "$JSON" | grep '"tag_name"' | cut -d'"' -f4)
ARCH=$(uname -m)
ASSET="nu-${VER}-${ARCH}-unknown-linux-musl.tar.gz"
echo "$VER / $ARCH / $ASSET"

curl -sSL "https://github.com/nushell/nushell/releases/download/${VER}/${ASSET}" -o /tmp/nu.tgz
mkdir -p /tmp/nu "$HOME/.local/share/nushell/$VER" "$HOME/.local/bin"
tar -xzf /tmp/nu.tgz -C /tmp/nu --strip-components=1

install -m755 /tmp/nu/nu /tmp/nu/nu_plugin_* "$HOME/.local/share/nushell/$VER/"
ln -sfn "$HOME/.local/share/nushell/$VER/nu" "$HOME/.local/bin/nu"

hash -r && nu --version
```

> [!warning] `grep -m1` bricht curl ab
> `curl ... | grep -m1 '"tag_name"'` endet mit `curl: (23) Failure writing output to destination`. grep beendet sich nach dem ersten Treffer und schließt die Pipe, bevor curl fertig geschrieben hat. Deshalb oben erst in `$JSON` puffern, dann filtern.

Zwei Punkte zur Begründung:

- **musl statt gnu**: Der musl-Build ist statisch gelinkt und läuft dadurch unabhängig von der glibc-Version — auf dem Host, im heutigen Container und in einem künftigen mit anderer Fedora-Version.
- **Versionsverzeichnis plus Symlink**: Ein Versionswechsel ist ein `ln -sfn`, ein Rückroller ebenso.

Eine eventuell vorhandene Zweitinstallation entfernen, sonst teilen sich zwei Versionen **eine** `~/.config/nushell/` und die ältere bricht mit Parse-Fehlern ab:

```bash
brew uninstall nushell     # falls über Homebrew installiert
```

## 4 Login-Shell umstellen

Erst jetzt sinnvoll, da der Pfad in beiden Welten gültig ist. `toolbox enter` übernimmt die Login-Shell aus `/etc/passwd` **des Hosts** — ein `chsh` im Container hält nicht, weil Toolbx den Benutzereintrag bei jedem Start neu aus den Host-Daten erzeugt.

```bash
# vorher unbedingt testen, sonst sperrt man sich aus beiden Umgebungen aus
toolbox run -c tauri-dev "$HOME/.local/bin/nu" -c "print ok"

echo "$HOME/.local/bin/nu" | sudo tee -a /etc/shells
chsh -s "$HOME/.local/bin/nu"
```

`/etc` ist auch auf Atomic-Systemen beschreibbar, es braucht also kein Layering. Scheitert es an PAM: `sudo chsh -s "$HOME/.local/bin/nu" BENUTZER`.

**Alternative, wenn bash die Login-Shell bleiben soll** — ans Ende von `~/.bashrc`:

```bash
# Im Toolbx automatisch nach Nushell wechseln
if [ -f /run/.toolboxenv ] && [ -x "$HOME/.local/bin/nu" ] && [ -z "$NU_ACTIVE" ]; then
    export NU_ACTIVE=1
    exec "$HOME/.local/bin/nu"
fi
```

Alle drei Bedingungen sind nötig: `/run/.toolboxenv` beschränkt den Wechsel auf den Container, `-x` verhindert eine Endlosschleife bei fehlendem Binary, `NU_ACTIVE` schützt davor, dass ein aus Nushell gestartetes bash sofort zurückspringt. Zusätzlich muss die `.bashrc` nicht-interaktive Aufrufe abfangen, sonst landet auch `toolbox run -c NAME bash -c "…"` in Nushell:

```bash
case $- in *i*) ;; *) return ;; esac
```

## 5 Host-spezifisches abschirmen

Weil `$HOME` geteilt ist, läuft die gesamte Shell-Konfiguration im Container mit. Aufrufe von Host-Werkzeugen scheitern dort und melden bei jedem Start einen Fehler, etwa:

```
bash: /home/linuxbrew/.linuxbrew/bin/brew: Datei oder Verzeichnis nicht gefunden
```

Erst die Fundstellen suchen — meist steht der Aufruf doppelt:

```bash
grep -n brew ~/.bashrc ~/.bash_profile ~/.profile 2>/dev/null
```

Dann einen gemeinsamen Riegel setzen, statt jede Zeile einzeln zu prüfen:

```bash
if [ ! -f /run/.toolboxenv ]; then
    # alles, was nur auf dem Host gelten soll
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
```

Der Block muss **vor** dem `exec nu` aus Abschnitt 4 stehen, sonst wird er auf dem Host nie erreicht.

---

# Phase 1 — Umgebung

## 6 Container anlegen

```nu
toolbox create -c tauri-dev
toolbox enter tauri-dev
nu --version        # kommt aus ~/.local/bin, ohne Zutun
```

Dass Nushell hier ohne jede Installation im Container verfügbar ist, ist das Ergebnis von Phase 0.

```nu
if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "auf dem Host" }
```

> [!note] Wo Host-Pfade im Container liegen
> Toolbx hängt `$HOME` ein — also `/var/home/BENUTZER`, nicht das übergeordnete `/var/home`. Zusätzliche Mounts sind nicht möglich, `toolbox create` kennt weder `--volume` noch `--device`.
>
> Erreichbar ist der Host trotzdem: Das komplette Wurzeldateisystem liegt unter `/run/host`.
> ```nu
> ls /run/host/var/home
> ```
> Das ist praktisch für Notfälle — und zugleich der beste Beweis dafür, dass Toolbx **keine Sandbox** ist. Wer ein Host-Verzeichnis wirklich braucht, kann es sich verlinken (`sudo ln -s /run/host/var/home/xyz /var/home/xyz`), sollte aber wissen, dass er damit Binaries ausführt, die für den Host gebaut wurden.

## 7 Ist-Zustand des Hosts aufnehmen

Auf dem **Host**, bevor etwas verändert wird. Diese Aufnahme ist die Grundlage für Abschnitt 15:

```nu
let d = (rpm-ostree status --json | from json | get deployments.0)
$d | select packages? requested-packages? requested-local-packages? base-removals? base-local-replacements?
which --all cargo rustc rustup
["~/.cargo" "~/.rustup"] | each {|p| {pfad: $p, vorhanden: ($p | path expand | path exists)} }
```

Hintergrund: Die offizielle Tauri-Dokumentation empfiehlt für OSTree-Systeme, alle Build-Abhängigkeiten per `rpm-ostree install` zu layern. Wer dieser Empfehlung gefolgt ist, findet sie jetzt in `requested-packages` wieder — und räumt sie in Abschnitt 15 wieder weg.

## 8 Build-Abhängigkeiten installieren

Ab hier alles **im Container**.

```nu
let build_deps = [
    "webkit2gtk4.1-devel"
    "openssl-devel"
    "curl" "wget" "file"
    "libappindicator-gtk3-devel"
    "librsvg2-devel"
    "libxdo-devel"
]

sudo dnf install -y ...$build_deps
sudo dnf group install -y c-development
```

> [!tip] Nushell
> `...$liste` ist der Spread-Operator: Die Liste wird zu einzelnen Argumenten aufgelöst. Er ersetzt die Zeilenfortsetzung mit `\` aus bash und macht Paketlisten wiederverwendbar.

**Node.js fehlt hier bewusst.** Es wird erst gebraucht, wenn ein Frontend-Framework mit Bundler dazukommt.

Kontrolle — einmal im Container, einmal auf dem Host:

```nu
pkg-config --modversion webkit2gtk-4.1
```

Auf dem Host schlägt der Befehl fehl. Daraus folgt: **`cargo build` muss im Container laufen.**

## 9 Rust je Container trennen

> [!danger] Die `$HOME`-Falle
> Ein `rustup`-Standardinstall im Container schreibt nach `~/.cargo` und `~/.rustup` — dieselben Verzeichnisse, die auch der Host benutzt. Host und Container teilen sich dann Toolchain, `PATH` und Build-Cache bei völlig unterschiedlichen Systembibliotheken.

In `$nu.env-path` ergänzen — der Block gilt für jeden Container, der Name wird ausgelesen:

```nu
if ("/run/.toolboxenv" | path exists) {
    let box = (open /run/.containerenv | from toml | get name)

    $env.CARGO_HOME = ($env.HOME | path join ".local/share/toolbox" $box "cargo")
    $env.RUSTUP_HOME = ($env.HOME | path join ".local/share/toolbox" $box "rustup")
    $env.PATH = ($env.PATH | prepend ($env.CARGO_HOME | path join "bin"))
}
```

> [!warning] `$env.PATH` ist eine Liste
> In Nushell ist `PATH` nach der Standard-Konvertierung eine Liste, kein `:`-getrennter String. Deshalb `prepend`, nicht String-Verkettung.

Installation ohne Curl-Pipe-Shell:

```nu
http get https://sh.rustup.rs | save --raw --force rustup-init.sh
open rustup-init.sh | lines | first 30      # vor dem Ausführen ansehen
sh rustup-init.sh -y --no-modify-path
rm rustup-init.sh
```

Shell neu starten und prüfen:

```nu
exit
toolbox enter tauri-dev
$env.CARGO_HOME
which cargo        # → .local/share/toolbox/tauri-dev/cargo/bin/cargo
```

Auf dem Host bleibt `cargo` unbekannt. Genau so soll es sein.

## 10 Sichtbar machen, dass der Container aktiv ist

Auch das gehört hinter den Riegel, sonst färbt sich der Host-Prompt mit. In `$nu.env-path`, innerhalb desselben `if`-Blocks:

```nu
    $env.PROMPT_COMMAND = {||
        let dir = ($env.PWD | str replace $env.HOME "~")
        $"(ansi { fg: '#ffffff', bg: '#8a4b12', attr: b }) ⬢ ($box) (ansi reset)(ansi yellow_bold) ($dir)(ansi reset)"
    }
    $env.PROMPT_INDICATOR = {|| $"(ansi yellow_bold) ❯ (ansi reset)" }
    $env.PROMPT_COMMAND_RIGHT = {|| "" }
```

Das `⬢` ist dasselbe Zeichen, das Toolbx dem bash-Prompt voranstellt. Bei mehreren Containern lohnt eine Farbe je Name:

```nu
    let farbe = (match $box {
        "tauri-dev" => "#8a4b12",
        "embedded-dev" => "#0f5f6b",
        _ => "#5b6770"
    })
```

Wer Starship benutzt, nimmt stattdessen dessen `[container]`-Baustein — Starship erkennt Toolbx über `/run/.containerenv` selbst.

## 11 Tauri-CLI als Cargo-Subkommando

```nu
cargo install tauri-cli --version "^2" --locked
cargo tauri --version
```

Das dauert einige Minuten. Abkürzung: `cargo install cargo-binstall --locked`, danach `cargo binstall tauri-cli`.

Dank Abschnitt 9 landet `cargo-tauri` im Container-`CARGO_HOME`.

---

# Phase 2 — Entwickeln

## 12 Testanwendung anlegen

```nu
mkdir ~/Projekte/notizblock/src
cd ~/Projekte/notizblock
```

**`src/index.html`** — das komplette Frontend:

```html
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="UTF-8" />
    <title>Notizblock</title>
    <style>
      body { font-family: system-ui, sans-serif; margin: 2rem; }
      input, button { font-size: 1rem; padding: .4rem .6rem; }
      #ausgabe { margin-top: 1rem; font-weight: 600; }
    </style>
  </head>
  <body>
    <h1>Notizblock</h1>
    <input id="name" placeholder="Ihr Name" />
    <button id="senden">Grüßen</button>
    <p id="ausgabe"></p>

    <script>
      const { invoke } = window.__TAURI__.core;
      document.querySelector("#senden").addEventListener("click", async () => {
        const name = document.querySelector("#name").value;
        document.querySelector("#ausgabe").textContent = await invoke("greet", { name });
      });
    </script>
  </body>
</html>
```

Rust-Gerüst erzeugen:

```nu
cargo tauri init
```

| Frage | Antwort |
|---|---|
| App name | `notizblock` |
| Window title | `Notizblock` |
| Web assets relative to `src-tauri` | `../src` |
| Dev server url | `../src` |
| Frontend dev command | *(leer lassen)* |
| Frontend build command | *(leer lassen)* |

## 13 Konfiguration, Binärname, Rust-Kommando

> [!danger] `cargo tauri init` nennt das Cargo-Paket `app`
> Nicht nach dem App-Namen. Das Binary heißt dadurch `target/release/app`, während `productName`, das `command` im Flatpak-Manifest und das `Exec=` der Desktop-Datei `notizblock` erwarten. Der Fehler fällt erst beim Paketieren auf — nach einem fünfminütigen Build:
> ```
> install: cannot stat 'src-tauri/target/release/notizblock': No such file or directory
> ```
> Prüfen mit `open src-tauri/Cargo.toml | get package.name`.

**Deshalb den Binärnamen festschreiben** — in `src-tauri/Cargo.toml`, hinter dem `[package]`-Block:

```toml
[[bin]]
name = "notizblock"
path = "src/main.rs"
```

Der `[lib]`-Abschnitt bleibt unverändert. `main.rs` ruft weiterhin `app_lib::run()` auf, abgeleitet vom Paketnamen — Binär- und Bibliotheksname dürfen verschieden sein, sie müssen nur zueinander konsistent bleiben.

**`src-tauri/tauri.conf.json`** — vollständig:

```json
{
  "$schema": "https://schema.tauri.app/config/2",
  "productName": "notizblock",
  "version": "0.1.0",
  "identifier": "de.metarow.Notizblock",
  "build": {
    "frontendDist": "../src"
  },
  "app": {
    "withGlobalTauri": true,
    "windows": [
      { "title": "Notizblock", "width": 800, "height": 600 }
    ],
    "security": { "csp": null }
  },
  "bundle": {
    "active": true,
    "targets": ["deb", "rpm"],
    "icon": [
      "icons/32x32.png",
      "icons/128x128.png",
      "icons/128x128@2x.png",
      "icons/icon.icns",
      "icons/icon.ico"
    ]
  }
}
```

- **`withGlobalTauri: true`** stellt `window.__TAURI__` bereit. Ohne Bundler gibt es kein `import`.
- **`targets: ["deb", "rpm"]`** schaltet AppImage ab. Warum, steht in Abschnitt 14.

**`src-tauri/src/main.rs`**:

```rust
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hallo, {name}! Grüße aus Rust.")
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![greet])
        .run(tauri::generate_context!())
        .expect("Fehler beim Start der Anwendung");
}
```

Kontrolle, dass wirklich ein Binary entsteht — diese eine Zeile erspart später den fehlgeschlagenen Flatpak-Build:

```nu
cargo build --release --manifest-path src-tauri/Cargo.toml
ls src-tauri/target/release | where type == file | get name
```

Fehlt dort ein ausführbares `notizblock`, hat cargo nur die Bibliothek gebaut. Ursache ist dann eine fehlende `main.rs` oder ein `[lib] crate-type`, das kein Binärziel zulässt.

## 14 Entwicklungslauf

```nu
cargo tauri dev
```

### Weißes oder flackerndes Fenster

Umgebungsvariablen werden in Nushell **nicht** als Präfix gesetzt:

```nu
with-env { WEBKIT_DISABLE_DMABUF_RENDERER: "1" } { cargo tauri dev }
with-env { WEBKIT_DISABLE_COMPOSITING_MODE: "1" } { cargo tauri dev }
```

Die dauerhaft nötige Variante gehört in den `if`-Block aus Abschnitt 9.

### Start vom Host aus

```nu
toolbox run -c tauri-dev nu -c "cd ~/Projekte/notizblock; cargo tauri dev"
```

### Sway-Fensterregel

```nu
swaymsg -t get_tree | from json | to json --indent 2 | lines | where $it =~ "app_id" | uniq
```

```
for_window [app_id="notizblock"] move container to workspace number 2
```

---

# Phase 3 — Release-Build

## 15 Bauen — und warum kein AppImage

```nu
cargo tauri build
ls src-tauri/target/release/bundle/**/* | where type == file | select name size
```

### AppImage ist in Toolbx nicht baubar

Mit `appimage` in den Targets endet der Build mit:

```
Error failed to bundle project: `failed to run linuxdeploy`
```

**`linuxdeploy` ist selbst ein AppImage** und will sich per FUSE einhängen. Prüfen:

```nu
ls -l /dev/fuse
fusermount3 --version
```

Fehlt nur `fusermount3`: `sudo dnf install -y fuse3 fuse-libs`. Fehlt `/dev/fuse`, ist Schluss — `toolbox create` kennt keine `--device`-Option. Hier endet Toolbx' Bequemlichkeit; man bräuchte Distrobox (`--additional-flags "--device /dev/fuse"`) oder rohes Podman.

Zwei weitere Stolpersteine selbst mit FUSE: `linuxdeploy-plugin-gtk` ruft `glib-compile-schemas`, `gdk-pixbuf-query-loaders-64` und `gtk-update-icon-cache` auf, die im schlanken Container fehlen. Und `APPIMAGE_EXTRACT_AND_RUN=1` umgeht zwar FUSE, nicht aber diese Abhängigkeiten.

Die echte Fehlermeldung sieht man, indem man das von Tauri erzeugte Skript direkt ausführt:

```nu
bash src-tauri/target/release/bundle/appimage/build_appimage.sh
```

> [!tip] Für die Schulungsflotte irrelevant
> AppImage bringt auf einem Atomic-System keinen Vorteil: keine Signatur, keine Sandbox, kein Update-Mechanismus.

### Nur das Binary

```nu
cargo tauri build --no-bundle
./src-tauri/target/release/notizblock
```

## 16 Host aufräumen

Dieser Abschnitt entfernt den **Altbestand aus Abschnitt 7** — also das, was vor Beginn dieses Leitfadens per `rpm-ostree install` auf dem Host lag. Er hat nichts mit den Paketen aus Abschnitt 8 zu tun, die im Container liegen und dort bleiben. Dass beide Listen dieselben Namen enthalten, ist der Grund, warum diese Unterscheidung hier ausdrücklich steht.

```nu
exit    # zurück auf den Host

let gelayert = (rpm-ostree status --json | from json | get deployments.0.requested-packages?)
$gelayert

if ($gelayert | is-not-empty) {
    rpm-ostree uninstall ...$gelayert
    rpm-ostree status
    systemctl reboot
} else {
    print "Nichts gelayert – Abschnitt übersprungen."
}
```

> [!warning] Drei Fallstricke
> **`rpm-ostree uninstall` bricht ab**, wenn eines der genannten Pakete gar nicht gelayert war. Deshalb die Liste aus dem System auslesen statt sie fest einzutragen.
>
> **Basis-Pakete sind kein Layering.** `gcc`, `make` und Ähnliches sind je nach Image bereits Bestandteil der Basis. Dafür wäre `rpm-ostree override remove` zuständig — was man ohne Not nicht tut.
>
> **`rustup self uninstall` löscht `~/.cargo` und `~/.rustup`**, und die liegen im geteilten `$HOME`. Der Befehl ist nur sicher, wenn die Trennung aus Abschnitt 9 greift, weil `CARGO_HOME` im Container dann woanders hinzeigt. Vorher prüfen:
> ```nu
> toolbox run -c tauri-dev nu -c '$env.CARGO_HOME'
> ```

Der Reboot ist nötig, weil `/usr` Teil des Images ist und atomar getauscht wird. Im Container brauchte keine Installation einen Neustart.

Vollständiger wird die Bestandsaufnahme mit `rpm-ostree status -v`. Achte dort zusätzlich auf `LocalPackages`, `ReplacedBasePackages`, `RemovedBasePackages`, `Initramfs` und `Unlocked` — Letzteres bedeutet ein `usroverlay`, dessen Inhalt in **keiner** Liste auftaucht und beim nächsten Reboot spurlos verschwindet. Abweichungen in `/etc` findet `ostree admin config-diff`.

---

# Phase 4 — Flatpak

## 17 Warum nicht einfach das fertige Binary einpacken

Die Tauri-Dokumentation zeigt einen Weg, bei dem das erzeugte `.deb` im Manifest entpackt wird. Das ist schnell — und hier die falsche Wahl:

> [!danger] glibc-Falle
> Das Binary aus dem Toolbx ist gegen die Bibliotheken deiner Fedora-Version gelinkt. Im Flatpak läuft es gegen die der GNOME-Runtime, die älter sind. Ergebnis: `version 'GLIBC_2.xx' not found` — oder ein Start ohne Fehlermeldung mit subtilem Fehlverhalten.
>
> **Gebaut wird gegen dieselbe Umgebung, in der später gelaufen wird.**

Deshalb bauen wir den Release in der Flatpak-SDK, mit deren Rust-Erweiterung.

## 18 Vorbereitung auf dem Host

Der Builder kommt selbst als Flatpak, nichts wird gelayert:

```nu
flatpak install flathub org.flatpak.Builder
```

> [!warning] Aufrufform
> Als Flatpak heißt der Befehl `flatpak run org.flatpak.Builder`, nicht `flatpak-builder`. Wer die Dokumentation eins zu eins verwenden will, legt einen Wrapper an:
> ```nu
> "#!/bin/sh
> exec flatpak run org.flatpak.Builder \"$@\"" | save -f ~/.local/bin/flatpak-builder
> chmod +x ~/.local/bin/flatpak-builder
> ```

### Runtime-Version ermitteln

Die GNOME-Runtime trägt ihre Freedesktop-Basis nicht im Namen — anders als KDE (`5.15-24.08`). Die Erweiterungsversion muss aber zur Basis passen, sonst stimmt die ABI nicht. Nachschlagen statt raten:

```nu
flatpak remote-info flathub -m org.gnome.Sdk//50 | lines | where $it =~ "freedesktop"
```

Maßgeblich ist der `version=`-Eintrag im Abschnitt `[Extension org.freedesktop.Sdk.Extension.]`.

Stand dieser Fassung: **GNOME 50 baut auf Freedesktop 25.08**, GNOME 49 ebenfalls, GNOME 47 und 48 auf 24.08. Freedesktop veröffentlicht jeden August eine Hauptversion mit zwei Jahren Pflege; die GNOME-Runtime folgt den GNOME-Releases und läuft meist nach einem Jahr aus. Zwei GNOME-Versionen teilen sich daher in der Regel dieselbe Basis.

```nu
let gnome = "50"
let fdo = "25.08"

flatpak install flathub $"org.gnome.Platform//($gnome)" $"org.gnome.Sdk//($gnome)"
flatpak install flathub $"org.freedesktop.Sdk.Extension.rust-stable//($fdo)"
```

Robuster ist, die Auflösung dem Builder zu überlassen — dann bleibt die Unterlage auch bei GNOME 51 gültig:

```nu
flatpak run org.flatpak.Builder --install-deps-from=flathub ...
```

> [!note] Freedesktop 25.08
> Diese Version hat `ffmpeg-full` und `openh264` durch eine `codecs-extra`-Erweiterung ersetzt. Für die Testanwendung ohne Medienwiedergabe belanglos, bei WebKit mit Video relevant.

## 19 Manifest und Metadaten

Drei Dateien im Projektwurzelverzeichnis.

**`de.metarow.Notizblock.desktop`**

```ini
[Desktop Entry]
Name=Notizblock
Comment=Beispielanwendung der Schulungsflotte
Exec=notizblock
Icon=de.metarow.Notizblock
Terminal=false
Type=Application
Categories=Utility;
```

**`de.metarow.Notizblock.metainfo.xml`**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<component type="desktop-application">
  <id>de.metarow.Notizblock</id>
  <name>Notizblock</name>
  <summary>Beispielanwendung der Schulungsflotte</summary>
  <metadata_license>CC0-1.0</metadata_license>
  <project_license>MIT</project_license>
  <description>
    <p>Minimale Tauri-Anwendung zur Demonstration der Werkzeugkette.</p>
  </description>
  <launchable type="desktop-id">de.metarow.Notizblock.desktop</launchable>
  <releases>
    <release version="0.1.0" date="2026-08-25"/>
  </releases>
</component>
```

**`de.metarow.Notizblock.yml`**

```yaml
id: de.metarow.Notizblock
runtime: org.gnome.Platform
runtime-version: '50'
sdk: org.gnome.Sdk
sdk-extensions:
  - org.freedesktop.Sdk.Extension.rust-stable
command: notizblock

finish-args:
  - --socket=wayland
  - --socket=fallback-x11
  - --share=ipc
  - --device=dri
  # - --share=network          # nur wenn die App selbst ins Netz muss
  # - --env=WEBKIT_DISABLE_DMABUF_RENDERER=1

build-options:
  append-path: /usr/lib/sdk/rust-stable/bin
  build-args:
    - --share=network          # NUR lokal: cargo lädt Crates. Flathub verbietet das.
  env:
    CARGO_HOME: /run/build/notizblock/cargo

modules:
  # Nur nötig, falls der Build libxdo vermisst:
  # - name: xdotool
  #   buildsystem: simple
  #   build-commands:
  #     - make PREFIX=/app install
  #   sources:
  #     - type: git
  #       url: https://github.com/jordansissel/xdotool.git
  #       tag: v3.20211022.1

  - name: notizblock
    buildsystem: simple
    sources:
      - type: dir
        path: .
    build-commands:
      - cargo build --release --manifest-path src-tauri/Cargo.toml
      - install -Dm755 src-tauri/target/release/notizblock /app/bin/notizblock
      - install -Dm644 de.metarow.Notizblock.desktop /app/share/applications/de.metarow.Notizblock.desktop
      - install -Dm644 de.metarow.Notizblock.metainfo.xml /app/share/metainfo/de.metarow.Notizblock.metainfo.xml
      - install -Dm644 src-tauri/icons/128x128.png /app/share/icons/hicolor/128x128/apps/de.metarow.Notizblock.png
      - install -Dm644 src-tauri/icons/32x32.png /app/share/icons/hicolor/32x32/apps/de.metarow.Notizblock.png
```

Vier Punkte zum Verstehen:

- **`sdk-extensions` + `append-path`** bringen `cargo` und `rustc` in die Sandbox. Der Toolbx-Rust ist hier unerreichbar — und das ist gewollt.
- **`--share=network` in `build-args`** erlaubt cargo den Zugriff auf crates.io. Für Flathub müssten die Abhängigkeiten per `cargo vendor` vorab eingesammelt werden.
- **Der Binärname in der `install`-Zeile** setzt den `[[bin]]`-Block aus Abschnitt 13 voraus. Ohne ihn heißt die Datei `app`.
- **`type: dir` mit `path: .`** kopiert das Arbeitsverzeichnis in die Sandbox. Vorher aufräumen:

```nu
cargo clean --manifest-path src-tauri/Cargo.toml
```

## 20 Bauen, installieren, testen

Bau und Installation werden getrennt:

```nu
cd ~/Projekte/notizblock

# 1. Bauen, Ergebnis in ein lokales Repo legen
flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir de.metarow.Notizblock.yml

# 2. Repo einmalig bekannt machen
flatpak remote-add --no-gpg-verify --if-not-exists metarow-lokal $"($env.PWD)/repo"

# 3. Installieren
flatpak install metarow-lokal de.metarow.Notizblock
```

Jeder weitere Durchlauf:

```nu
flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir de.metarow.Notizblock.yml
flatpak update de.metarow.Notizblock
```

Starten und Rechte prüfen:

```nu
flatpak run de.metarow.Notizblock
flatpak info --show-permissions de.metarow.Notizblock
```

Vergleiche das mit den Rechten eines Toolbx-Prozesses: Die App sieht dein `$HOME` **nicht**. Das ist der eigentliche Gewinn gegenüber AppImage.

### Fehlersuche im Build

```nu
# Build-Verzeichnis aufheben und nachsehen, was cargo erzeugt hat
flatpak run org.flatpak.Builder --force-clean --keep-build-dirs --repo=repo build-dir de.metarow.Notizblock.yml
ls .flatpak-builder/build/notizblock-1/src-tauri/target/release/ | where type == file

# Interaktiv in die Sandbox, an der Stelle der build-commands
flatpak run org.flatpak.Builder --build-shell=notizblock build-dir de.metarow.Notizblock.yml
```

Bei Zugriffsfehlern auf das Projektverzeichnis:

```nu
flatpak override --filesystem=home org.flatpak.Builder
```

## 21 In die Flotte verteilen

**Einzeldatei-Bundle** — für wenige Geräte:

```nu
flatpak build-bundle repo notizblock.flatpak de.metarow.Notizblock --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo

# auf dem Zielgerät
flatpak install notizblock.flatpak
```

**Eigenes Repository** — für die ganze Flotte, mit Updates:

```nu
flatpak build-sign repo --gpg-sign=$KEY_ID
flatpak build-update-repo repo --gpg-sign=$KEY_ID

# auf den Zielgeräten einmalig
sudo flatpak remote-add metarow https://repo.metarow.de/flatpak/metarow.flatpakrepo
flatpak install metarow de.metarow.Notizblock
```

Danach genügt `flatpak update` — dieselbe Mechanik wie bei Flathub.

---

# Phase 5 — Reproduzierbarkeit

## 22 Wegwerfen und neu aufbauen

```nu
toolbox rm -f tauri-dev
ls ~/Projekte/notizblock | get name
```

Quellcode und Nushell bleiben unberührt — Letzteres, weil es seit Phase 0 im `$HOME` liegt.

> [!warning] Reste im `$HOME`
> `src-tauri/target/` überlebt das Löschen des Containers und enthält Artefakte der alten Umgebung:
> ```nu
> cargo clean --manifest-path src-tauri/Cargo.toml
> ```

## 23 Setup-Skript

`~/.local/bin/setup-tauri-toolbox.nu`, idempotent. Nushell fehlt hier bewusst — es kommt aus Phase 0:

```nu
#!/usr/bin/env nu

const CONTAINER = "tauri-dev"

def container-exists []: nothing -> bool {
    podman ps -a --format "{{.Names}}" | lines | any {|n| $n == $CONTAINER }
}

def main [] {
    if not (container-exists) {
        print $"Lege Container ($CONTAINER) an ..."
        toolbox create -c $CONTAINER
    } else {
        print $"Container ($CONTAINER) existiert bereits."
    }

    let pakete = [
        "webkit2gtk4.1-devel" "openssl-devel"
        "curl" "wget" "file"
        "libappindicator-gtk3-devel" "librsvg2-devel" "libxdo-devel"
    ]

    toolbox run -c $CONTAINER sudo dnf install -y ...$pakete
    toolbox run -c $CONTAINER sudo dnf group install -y c-development

    let cargo_home = ($env.HOME | path join ".local/share/toolbox" $CONTAINER "cargo")

    if ($cargo_home | path join "bin/rustup" | path exists) {
        print "Rust-Toolchain bereits vorhanden."
    } else {
        print "Installiere Rust im Container ..."
        toolbox run -c $CONTAINER nu -c "http get https://sh.rustup.rs | save --raw --force /tmp/rustup-init.sh; sh /tmp/rustup-init.sh -y --no-modify-path"
    }

    if ($cargo_home | path join "bin/cargo-tauri" | path exists) {
        print "tauri-cli bereits vorhanden."
    } else {
        print "Installiere tauri-cli (dauert einige Minuten) ..."
        toolbox run -c $CONTAINER nu -c "cargo install tauri-cli --version '^2' --locked"
    }

    print $"Fertig. Mit 'toolbox enter ($CONTAINER)' betreten."
}
```

---

## 24 Nushell gegenüber bash

| Aufgabe | bash | Nushell |
|---|---|---|
| Variable für einen Befehl | `FOO=1 befehl` | `with-env { FOO: "1" } { befehl }` |
| Variable dauerhaft | `export FOO=1` | `$env.FOO = "1"` |
| PATH erweitern | `PATH="$neu:$PATH"` | `$env.PATH = ($env.PATH \| prepend $neu)` |
| String zusammensetzen | `"pfad/$var"` | `$"pfad/($var)"` |
| Datei existiert? | `test -f datei` | `"datei" \| path exists` |
| Pfad zusammensetzen | `"$HOME/a/b"` | `$env.HOME \| path join "a" "b"` |
| Zeilenfortsetzung | `\` am Zeilenende | Liste + Spread `...$liste` |
| Befehlsersetzung | `$(befehl)` | `(befehl)`, oft mit `str trim` |
| JSON auswerten | `\| jq ...` | `\| from json \| get ...` |
| Zeilen filtern | `\| grep muster` | `\| lines \| where $it =~ "muster"` |
| Spaltentext parsen | `\| awk '{print $2}'` | `\| detect columns \| get SPALTE` |
| Konfigurationsdatei | `~/.bashrc` | `$nu.env-path` / `$nu.config-path` |

> [!warning] Zwei häufige Fehler
> Externe Befehle geben einen String mit abschließendem Zeilenumbruch zurück — bei Vergleichen und Pfadbau `str trim` verwenden.
>
> Nushell zeigt nur das Ergebnis des **letzten** Befehls, wenn mehrere Zeilen zusammen abgeschickt werden. Diagnosebefehle einzeln ausführen.

---

## 25 Troubleshooting

| Symptom                                          | Ursache                                     | Abhilfe                                            |
| ------------------------------------------------ | ------------------------------------------- | -------------------------------------------------- |
| `toolbox enter` startet bash statt nu            | Shell-Pfad im Container ungültig            | Phase 0: Binary nach `~/.local/bin`                |
| `which nu` findet nichts, obwohl Pfad in `$PATH` | Pfad zeigt außerhalb von `$HOME`            | Abschnitt 3                                        |
| `/home/...` leer, `/var/home/...` auch           | `/home` im Container kein Symlink           | `/run/host/...` nutzen, Abschnitt 6                |
| `brew: Datei nicht gefunden` beim Start          | Host-Aufruf in geteilter `.bashrc`          | Riegel aus Abschnitt 5                             |
| `curl: (23) Failure writing output`              | `grep -m1` schließt die Pipe                | erst puffern, dann filtern                         |
| `cargo` auch auf dem Host im `PATH`              | `if`-Block in `env.nu` greift nicht         | `/run/.toolboxenv`-Abfrage prüfen                  |
| `webkit2gtk-4.1 not found`                       | Build läuft auf dem Host                    | `toolbox enter` bzw. `toolbox run`                 |
| Linkerfehler nach Containerwechsel               | `target/` enthält alte Artefakte            | `cargo clean`                                      |
| Weißes App-Fenster                               | DMA-BUF-Renderer                            | `with-env { WEBKIT_DISABLE_DMABUF_RENDERER: "1" }` |
| `failed to run linuxdeploy`                      | AppImage-Bundling ohne FUSE                 | AppImage aus `targets` entfernen                   |
| `window.__TAURI__ is undefined`                  | `withGlobalTauri` fehlt                     | `app.withGlobalTauri: true`                        |
| `install: cannot stat .../notizblock`            | Cargo-Paket heißt `app`                     | `[[bin]]`-Block, Abschnitt 13                      |
| `cargo build` erzeugt kein Binary                | `main.rs` fehlt oder `[lib]` ohne Binärziel | Abschnitt 13                                       |
| `rpm-ostree uninstall` bricht ab                 | Paket war nicht gelayert                    | Liste auslesen, Abschnitt 16                       |
| `flatpak-builder: command not found`             | als Flatpak installiert                     | `flatpak run org.flatpak.Builder`                  |
| `GLIBC_2.xx not found` im Flatpak                | Binary im Toolbx statt im SDK gebaut        | Abschnitt 17                                       |
| `xdo.h: No such file` im Flatpak-Build           | libxdo fehlt im SDK                         | xdotool-Modul aktivieren                           |
| Flatpak-Build lädt keine Crates                  | Netzwerk in der Sandbox gesperrt            | `build-args: --share=network`                      |
| Flatpak-Build riesig / langsam                   | `target/` wurde mitkopiert                  | `cargo clean` vor dem Build                        |
| Rust-Erweiterung passt nicht                     | falsche Freedesktop-Version                 | Abschnitt 18, `remote-info -m`                     |

---

## 26 Spickzettel

```nu
# Shell (einmalig, Host)
ln -sfn ~/.local/share/nushell/VER/nu ~/.local/bin/nu
chsh -s $"($env.HOME)/.local/bin/nu"

# Umgebung
toolbox create -c NAME
toolbox enter NAME
toolbox run -c NAME nu -c "BEFEHL"
toolbox rm -f NAME
if ("/run/.toolboxenv" | path exists) { print "im Container" }
ls /run/host/var/home                       # Host-Dateisystem im Container

# Entwickeln (im Container)
cargo tauri dev
cargo tauri build --no-bundle
cargo tauri info
cargo clean --manifest-path src-tauri/Cargo.toml

# Ausliefern (auf dem Host)
flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir MANIFEST.yml
flatpak run org.flatpak.Builder --build-shell=MODUL build-dir MANIFEST.yml
flatpak install metarow-lokal ID
flatpak run ID
flatpak info --show-permissions ID
flatpak build-bundle repo app.flatpak ID --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo

# Host prüfen
rpm-ostree status --json | from json | get deployments.0.requested-packages?
rpm-ostree status -v
ostree admin config-diff
```
