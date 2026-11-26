---
id: 202611262019
title: Eine Markerdatei zeigt an, dass die Shell im Toolbx-Container läuft
type: zettel
tags:
  - linux/toolbx
  - shell
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Toolbx legt in jedem Container die Datei `/run/.toolboxenv` an, auf dem Host fehlt sie. Daran erkennt eine Shell-Konfiguration, wo sie gerade läuft. Nötig ist das, weil Host und Container dieselben Dotfiles im geteilten Home lesen.

```nu
if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "auf dem Host" }
```

Mit dieser Abfrage als Riegel lässt sich die Konfiguration in zwei Richtungen trennen. Host-Werkzeuge wie Homebrew werden nur außerhalb eingebunden, sonst meldet jede neue Shell im Container einen Fehler. Umgekehrt gilt Container-Spezifisches nur innerhalb: ein eigenes `CARGO_HOME`, ein auffälliger Prompt, Umgebungsvariablen für den Build. Ein gemeinsamer Block ist dabei übersichtlicher, als jede Zeile einzeln abzufragen.

Den Namen des Containers liefert eine zweite Datei, die Podman anlegt:

```nu
open /run/.containerenv | from toml | get name
```

## Verbindungen

- [[Toolbx teilt mit dem Host nur das Home-Verzeichnis]] – der Grund, warum die Konfiguration überhaupt unterscheiden muss
- [[Rust-Toolchains lassen sich je Container trennen]] – die wichtigste Anwendung dieser Abfrage
- [[Toolbx übernimmt die Login-Shell vom Host]] – dieselbe Abfrage entscheidet, ob bash im Container zu Nushell wechselt
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
