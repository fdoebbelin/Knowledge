---
id: 202611262026
title: Versionsverzeichnis und Symlink machen Updates umkehrbar
type: zettel
tags:
  - linux
  - shell
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Ein Werkzeug ohne Paketmanager lässt sich so installieren, dass jede Version ein eigenes Verzeichnis bekommt und ein Symlink auf die aktive zeigt:

```
~/.local/share/nushell/0.114.0/nu
~/.local/share/nushell/0.115.0/nu
~/.local/bin/nu  →  ~/.local/share/nushell/0.115.0/nu
```

Ein Update entpackt die neue Version daneben und biegt den Symlink um, ein Rückrollen biegt ihn zurück. Beides ist ein einziger Befehl:

```bash
ln -sfn "$HOME/.local/share/nushell/$VER/nu" "$HOME/.local/bin/nu"
```

`-f` ersetzt einen vorhandenen Link, `-n` verhindert, dass `ln` einem Link auf ein Verzeichnis folgt. Alte Versionen löscht man erst, wenn sich die neue bewährt hat. Dasselbe Muster verwenden auch manche Installer, etwa der von Claude Code.

Daneben darf keine zweite Installation desselben Werkzeugs über einen Paketmanager liegen. Beide würden dieselbe Konfiguration lesen, und die ältere bricht an Neuerungen, die sie nicht kennt.

## Verbindungen

- [[Statisch gelinkte musl-Binaries sind unabhängig von der glibc-Version]] – die Art Binary, die man typischerweise so installiert
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
