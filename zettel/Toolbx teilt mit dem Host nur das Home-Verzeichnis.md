---
id: 202611262016
title: Toolbx teilt mit dem Host nur das Home-Verzeichnis
type: zettel
tags:
  - linux/toolbx
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Ein Toolbx-Container hat ein eigenes Wurzeldateisystem aus einem Fedora-Image. Vom Host hängt er das Home-Verzeichnis des Benutzers ein, eigene Bereiche darüber hinaus nicht. Alles im Home ist auf beiden Seiten dasselbe: Quellcode, Dotfiles, Shell-Konfiguration, Werkzeuge unter `~/.local/bin`.

Was der Host außerhalb des Homes installiert hat, gibt es im Container nicht: Pakete des Basisimages, Homebrew unter `/home/linuxbrew`, Programme in `/usr/bin`. Tückisch daran ist, dass die geteilte Shell-Konfiguration diese Pfade weiter in den `PATH` schreibt. `which` findet dann nichts, obwohl der Eintrag in der Liste steht.

Daraus folgt eine Faustregel: Ein Werkzeug, das auf dem Host und in jedem Container bereitstehen soll, gehört ins Home, etwa als statisches Binary unter `~/.local/bin`. Zusätzliche Mounts lassen sich nicht nachrüsten, `toolbox create` kennt weder `--volume` noch `--device`.

## Verbindungen

- [[Toolbx ist keine Sandbox]] – die Kehrseite: Abgeschottet ist der Container trotzdem kaum
- [[Auf Fedora Atomic ist das Verzeichnis home ein Symlink]] – die zweite Pfadfalle zwischen Host und Container
- [[Eine Markerdatei zeigt an, dass die Shell im Toolbx-Container läuft]] – wie die geteilte Konfiguration Host und Container auseinanderhält
- [[Statisch gelinkte musl-Binaries sind unabhängig von der glibc-Version]] – warum ein Werkzeug im Home auf beiden Seiten läuft
- [[Rust-Toolchains lassen sich je Container trennen]] – wenn das geteilte Home zum Problem wird
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
