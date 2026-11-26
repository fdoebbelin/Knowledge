---
id: 202611262021
title: Rust-Toolchains lassen sich je Container trennen
type: zettel
tags:
  - linux/toolbx
  - rust
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

`rustup` installiert standardmäßig nach `~/.cargo` und `~/.rustup`. Im Toolbx-Container liegen diese Verzeichnisse im geteilten Home. Wer Rust im Container installiert, teilt sich mit dem Host also Toolchain, installierte Werkzeuge und Build-Cache, obwohl beide gegen ganz unterschiedliche Systembibliotheken linken.

Die Variablen `CARGO_HOME` und `RUSTUP_HOME` lösen das. In der Nushell-Umgebung (`$nu.env-path`) zeigen sie im Container auf ein eigenes Verzeichnis je Container:

```nu
if ("/run/.toolboxenv" | path exists) {
    let box = (open /run/.containerenv | from toml | get name)
    $env.CARGO_HOME = ($env.HOME | path join ".local/share/toolbox" $box "cargo")
    $env.RUSTUP_HOME = ($env.HOME | path join ".local/share/toolbox" $box "rustup")
    $env.PATH = ($env.PATH | prepend ($env.CARGO_HOME | path join "bin"))
}
```

Installiert wird danach mit `--no-modify-path`, damit `rustup` die Shell-Konfiguration nicht selbst umschreibt. Auf dem Host bleibt `cargo` dann unbekannt, und ein `rustup self uninstall` auf der einen Seite löscht nicht die Toolchain der anderen.

## Verbindungen

- [[Toolbx teilt mit dem Host nur das Home-Verzeichnis]] – die Ursache: `~/.cargo` liegt im geteilten Home
- [[Eine Markerdatei zeigt an, dass die Shell im Toolbx-Container läuft]] – die Abfrage, hinter der die Umlenkung steht
- [[In Nushell ist PATH eine Liste]] – warum im Beispiel `prepend` steht
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
