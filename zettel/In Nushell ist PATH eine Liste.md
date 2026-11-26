---
id: 202611262031
title: In Nushell ist PATH eine Liste
type: zettel
tags:
  - shell/nushell
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

In bash ist `PATH` ein Text, dessen Einträge durch Doppelpunkte getrennt sind. Erweitert wird er durch Zusammensetzen: `PATH="$neu:$PATH"`. Nushell wandelt `PATH` beim Start in eine Liste um. Dort erweitert man ihn mit Listenbefehlen:

```nu
$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local/bin"))
$env.PATH | where $it =~ "cargo"      # Einträge durchsuchen
```

`prepend` stellt den Eintrag an den Anfang, `append` ans Ende. Eine String-Verkettung wie in bash führt hier zu einem Fehler oder einem kaputten Eintrag. Doppelte Einträge entfernt `uniq`.

Externe Programme sehen davon nichts: Beim Aufruf setzt Nushell die Liste wieder zum üblichen Text zusammen. Die Umwandlung übernimmt `$env.ENV_CONVERSIONS`. Dauerhaft gehört die Erweiterung in `$nu.env-path`.

## Verbindungen

- [[Rust-Toolchains lassen sich je Container trennen]] – ein Anwendungsfall: das `bin`-Verzeichnis je Container voranstellen
- [[grep -m1 am Ende einer Pipe lässt curl abbrechen]] – noch ein Fall, in dem Nushell strukturierte Daten statt Text liefert
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
