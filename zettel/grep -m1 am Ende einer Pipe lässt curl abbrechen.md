---
id: 202611262030
title: grep -m1 am Ende einer Pipe lässt curl abbrechen
type: zettel
tags:
  - shell
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Dieser Aufruf findet zwar die gesuchte Zeile, meldet aber trotzdem einen Fehler:

```bash
curl -sS https://api.github.com/repos/nushell/nushell/releases/latest | grep -m1 '"tag_name"'
# curl: (23) Failure writing output to destination
```

`grep -m1` beendet sich nach dem ersten Treffer und schließt damit sein Ende der Pipe. curl schreibt weiter, bekommt einen Schreibfehler und bricht mit Code 23 ab. In einem Skript mit `set -o pipefail` ist das ein Fehlschlag der ganzen Pipeline. Ob es passiert, hängt von der Datenmenge ab: Hat curl schon alles in den Pipe-Puffer geschrieben, bevor grep aufhört, merkt es nichts. Der Fehler tritt also nicht zuverlässig auf.

Abhilfe: erst puffern, dann filtern.

```bash
JSON=$(curl -sS https://api.github.com/repos/nushell/nushell/releases/latest)
VER=$(printf '%s' "$JSON" | grep '"tag_name"' | cut -d'"' -f4)
```

Dasselbe gilt für `head` und alle anderen Befehle, die vorzeitig aufhören zu lesen.

## Verbindungen

- [[Statisch gelinkte musl-Binaries sind unabhängig von der glibc-Version]] – das Download-Skript, in dem der Fehler auffiel, holt ein solches Binary
- [[In Nushell ist PATH eine Liste]] – in Nushell liefert `http get` die Antwort gleich als Datensatz, ohne Pipe zu grep
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
