---
typ: anhang
titel: Nushell-Befehlsreferenz für den Kurs
tags: [tauri/kurs/anhang, nushell]
status: entwurf
---

# Anhang – Nushell-Befehlsreferenz für den Kurs

Ergänzt Abschnitt 24 des Leitfadens um die Befehle, die im Kurs neu hinzukommen.

## Umgebung feststellen

```nu
if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "auf dem Host" }
open /run/.containerenv | from toml | get name
$env.CARGO_HOME
which --all cargo node npm
```

## Entwicklungszyklus

```nu
cd ~/Projekte/noteflow

cargo tauri dev
cargo tauri build --no-bundle
cargo tauri info

# Umgebungsvariable nur für einen Lauf, kein Präfix wie in bash
with-env { WEBKIT_DISABLE_DMABUF_RENDERER: "1" } { cargo tauri dev }
with-env { RUST_LOG: "debug" } { cargo tauri dev }
```

## npm im Container

```nu
npm --prefix frontend install
npm --prefix frontend run build
npm --prefix frontend run test

# mehrere Pakete als Liste, Spread statt Zeilenfortsetzung
let pakete = ["pinia" "vue-router" "@tauri-apps/plugin-fs"]
npm --prefix frontend install ...$pakete
```

## Aufräumen vor dem Flatpak-Bau

```nu
cargo clean --manifest-path src-tauri/Cargo.toml
rm -rf frontend/node_modules      # nur nach Containerwechsel nötig
du -sh frontend/dist
```

## Flatpak auf dem Host

```nu
flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir de.metarow.NoteFlow.yml
flatpak run org.flatpak.Builder --build-shell=noteflow build-dir de.metarow.NoteFlow.yml
flatpak install --user metarow-lokal de.metarow.NoteFlow
flatpak update --user de.metarow.NoteFlow
flatpak run de.metarow.NoteFlow
flatpak run --command=sh de.metarow.NoteFlow
flatpak info --show-permissions de.metarow.NoteFlow
flatpak remote-info flathub -m org.gnome.Sdk//50 | lines | where $it =~ "freedesktop"
```

## Host prüfen

```nu
rpm-ostree status --json | from json | get deployments.0.requested-packages?
ls /usr/share/xdg-desktop-portal/portals | get name
pgrep -l mako
swaymsg -t get_tree | from json | to json --indent 2 | lines | where $it =~ "app_id" | uniq
```

## Vom Host in den Container hineinarbeiten

```nu
toolbox run -c tauri-dev nu -c "cd ~/Projekte/noteflow; cargo tauri dev"
toolbox run -c tauri-dev nu -c '$env.CARGO_HOME'
toolbox run -c tauri-dev nu -c "npm --prefix ~/Projekte/noteflow/frontend run build"
```

## Ergebnisse auswerten statt parsen

```nu
ls frontend/dist | where type == file | select name size | sort-by size --reverse
ls src-tauri/target/release/bundle/**/* | where type == file | select name size
open src-tauri/Cargo.toml | get package.name
open src-tauri/tauri.conf.json | get build
open frontend/package.json | get dependencies | columns
```

## Zwei wiederkehrende Fehlerquellen

> [!warning]
> Externe Befehle liefern einen String mit abschließendem Zeilenumbruch. Bei Vergleichen und Pfadbau `str trim` verwenden.
>
> Werden mehrere Zeilen zusammen abgeschickt, zeigt Nushell nur das Ergebnis der letzten. Diagnosebefehle einzeln ausführen.

## Verknüpfung

[[00 Kurskonzept Tauri]] · [[Von der leeren Toolbx zur installierten Flatpak-App]]
