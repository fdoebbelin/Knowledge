---
typ: anhang
titel: Flatpak-Manifest für NoteFlow
tags: [tauri/kurs/anhang, flatpak, manifest]
status: entwurf
---

# Anhang – Flatpak-Manifest für NoteFlow

Weiterentwicklung des Manifests aus Leitfaden-Abschnitt 19. Die Unterschiede zum dortigen `notizblock` sind markiert und im Unterricht zu besprechen.

## `de.metarow.NoteFlow.yml`

```yaml
id: de.metarow.NoteFlow
runtime: org.gnome.Platform
runtime-version: '50'
sdk: org.gnome.Sdk
sdk-extensions:
  - org.freedesktop.Sdk.Extension.rust-stable
command: noteflow

finish-args:
  - --socket=wayland
  - --socket=fallback-x11
  - --share=ipc
  - --device=dri
  # NEU gegenüber dem Leitfaden: Zugriff auf genau einen Notizordner.
  # Alternative wäre der reine Portal-Weg ganz ohne --filesystem.
  - --filesystem=xdg-documents/NoteFlow:create
  # - --share=network        # nur falls die App selbst ins Netz muss
  # - --env=WEBKIT_DISABLE_DMABUF_RENDERER=1

build-options:
  append-path: /usr/lib/sdk/rust-stable/bin
  build-args:
    - --share=network        # NUR lokal: cargo lädt Crates. Flathub verbietet das.
  env:
    CARGO_HOME: /run/build/noteflow/cargo

modules:
  - name: noteflow
    buildsystem: simple
    sources:
      - type: dir
        path: .
        # NEU: ohne skip wandern node_modules und target mit in den Sandkasten
        skip:
          - frontend/node_modules
          - src-tauri/target
          - .git
          - repo
          - build-dir
          - .flatpak-builder
    build-commands:
      # Nur der native Teil wird hier gebaut. frontend/dist ist bereits fertig
      # und wurde im Toolbx erzeugt, siehe M11.
      - cargo build --release --manifest-path src-tauri/Cargo.toml
      - install -Dm755 src-tauri/target/release/noteflow /app/bin/noteflow
      - install -Dm644 de.metarow.NoteFlow.desktop /app/share/applications/de.metarow.NoteFlow.desktop
      - install -Dm644 de.metarow.NoteFlow.metainfo.xml /app/share/metainfo/de.metarow.NoteFlow.metainfo.xml
      - install -Dm644 src-tauri/icons/128x128.png /app/share/icons/hicolor/128x128/apps/de.metarow.NoteFlow.png
      - install -Dm644 src-tauri/icons/32x32.png /app/share/icons/hicolor/32x32/apps/de.metarow.NoteFlow.png
```

## Zu besprechende Punkte

> [!important] `frontend/dist` muss vorhanden sein
> `cargo build` ruft `tauri::generate_context!` auf. Das bettet die Dateien aus `frontendDist` zum Kompilierzeitpunkt ein. Fehlt der Ordner, bricht der Build mit einem Pfadfehler ab. Deshalb steht `npm run build` vor dem Flatpak-Bau und `frontend/dist` **nicht** in der `skip`-Liste.

> [!important] Warum `cargo build` und nicht `cargo tauri build`
> `cargo tauri build` würde `beforeBuildCommand` ausführen und damit npm im Sandkasten suchen. Das gibt es dort nicht. Der direkte `cargo build` umgeht die Tauri-CLI vollständig.

> [!note] `[[bin]]`-Block bleibt Pflicht
> Ohne ihn heißt das Binary `app` und die `install`-Zeile scheitert nach mehreren Minuten Bauzeit. Vorher prüfen: `open src-tauri/Cargo.toml | get package.name`.

## Vertiefung: reproduzierbarer Build ohne Vorbau

Für Flathub reicht das obige Manifest nicht, weil es Netzwerk im Build braucht und ein vorgebautes `dist` mitbringt. Der vollständige Weg:

1. Node-Erweiterung in `sdk-extensions` aufnehmen
2. `append-path` um den Node-Pfad ergänzen
3. `flatpak-node-generator` erzeugt eine Quellenliste aus `package-lock.json`
4. `cargo vendor` erzeugt die Crate-Quellen vorab
5. `build-args: --share=network` entfällt
6. `npm ci --offline` und `npm run build` werden zu `build-commands`

Im Kurs als Vorführung in [[M11 Flatpak Build und Verteilung]], nicht als Pflichtübung.

## Verknüpfung

[[M11 Flatpak Build und Verteilung]] · [[00 Kurskonzept Tauri]]
