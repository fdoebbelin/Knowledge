---
id: 202611262029
title: AppImages lassen sich in Toolbx nicht bauen
type: zettel
tags:
  - rust/tauri
  - linux/toolbx
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

`cargo tauri build` erzeugt auf Linux standardmäßig auch ein AppImage. Im Toolbx-Container bricht das ab:

```
Error failed to bundle project: `failed to run linuxdeploy`
```

Der Grund: Das Hilfswerkzeug `linuxdeploy` ist selbst ein AppImage und will sich über FUSE einhängen. Fehlt im Container `/dev/fuse`, ist Schluss, denn `toolbox create` kann keine Geräte durchreichen. Selbst mit FUSE fehlen Werkzeuge, die das GTK-Plugin von `linuxdeploy` aufruft, etwa `glib-compile-schemas` und `gtk-update-icon-cache`. Die eigentliche Fehlermeldung zeigt erst das erzeugte Skript `src-tauri/target/release/bundle/appimage/build_appimage.sh`.

Abhilfe ist, AppImage aus den Bundle-Zielen zu nehmen – `"targets": ["deb", "rpm"]` unter `bundle` – oder nur das Binary zu bauen:

```nu
cargo tauri build --no-bundle
```

Auf einem Atomic-System ist das kein Verlust: Ein AppImage bringt dort weder Sandbox noch Signatur noch Updates, ein Flatpak schon. Wer es trotzdem braucht, nimmt Distrobox mit `--additional-flags "--device /dev/fuse"`.

## Verbindungen

- [[Toolbx teilt mit dem Host nur das Home-Verzeichnis]] – `toolbox create` kann keine Geräte durchreichen
- [[Toolbx ist keine Sandbox]] – Flatpak bringt die Abschottung mit, die AppImage fehlt
- [[withGlobalTauri macht Tauri ohne Bundler nutzbar]] – beide Einstellungen stehen in `tauri.conf.json`
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
