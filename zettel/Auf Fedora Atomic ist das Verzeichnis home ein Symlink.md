---
id: 202611262017
title: Auf Fedora Atomic ist das Verzeichnis home ein Symlink
type: zettel
tags:
  - linux/atomic
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Auf Fedora Atomic (Silverblue, Kinoite, Sway Atomic) ist `/home` kein echtes Verzeichnis, sondern ein Symlink auf `/var/home`. Der Grund liegt im Aufbau: `/usr` ist schreibgeschützt und wird bei jedem Update als Ganzes getauscht. Veränderliche Daten liegen deshalb unter `/var`, und `/home` verweist dorthin.

Im Toolbx-Container gilt das nicht. Das Container-Image ist ein gewöhnliches Fedora, dort ist `/home` ein echtes, leeres Verzeichnis. Eingehängt wird nur das eigene Home, und zwar unter seinem echten Pfad `/var/home/BENUTZER`.

Ein Host-Pfad wie `/home/linuxbrew/.linuxbrew/bin/brew` führt im Container deshalb ins Leere, obwohl er auf dem Host funktioniert. In Konfigurationsdateien ist `$HOME` darum sicherer als ein fest eingetragenes `/home/...`.

```nu
ls -l /home    # Host: Symlink auf var/home – Container: leeres Verzeichnis
```

## Verbindungen

- [[Toolbx teilt mit dem Host nur das Home-Verzeichnis]] – nur das eigene Home kommt in den Container, nicht das Verzeichnis darüber
- [[Toolbx ist keine Sandbox]] – über `/run/host` ist der Host-Pfad im Notfall trotzdem erreichbar
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
