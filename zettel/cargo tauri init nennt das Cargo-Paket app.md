---
id: 202611262027
title: cargo tauri init nennt das Cargo-Paket app
type: zettel
tags:
  - rust/tauri
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

`cargo tauri init` legt das Rust-Gerüst in `src-tauri/` an und nennt das Cargo-Paket `app`, nicht nach der Anwendung. Das Binary heißt deshalb `target/release/app`. Alles andere erwartet aber den App-Namen: `productName` in `tauri.conf.json`, das `command` im Flatpak-Manifest, die `Exec=`-Zeile der Desktop-Datei. Auffallen kann das erst beim Paketieren, nach einem langen Build:

```
install: cannot stat 'src-tauri/target/release/notizblock': No such file or directory
```

Abhilfe schafft ein ausdrücklicher Binärname in `src-tauri/Cargo.toml`, hinter dem `[package]`-Block:

```toml
[[bin]]
name = "notizblock"
path = "src/main.rs"
```

Den `[lib]`-Abschnitt lässt man, wie er ist. Binär- und Bibliotheksname dürfen verschieden sein. Ob wirklich ein Binary entsteht, zeigt ein Release-Build vor dem Paketieren:

```nu
cargo build --release --manifest-path src-tauri/Cargo.toml
ls src-tauri/target/release | where type == file | get name
```

## Verbindungen

- [[withGlobalTauri macht Tauri ohne Bundler nutzbar]] – die zweite Einstellung, die ein schlankes Tauri-Projekt braucht
- [[Gebaut wird gegen dieselbe Umgebung, in der später gelaufen wird]] – im Flatpak-Build fällt der falsche Name erst auf
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
