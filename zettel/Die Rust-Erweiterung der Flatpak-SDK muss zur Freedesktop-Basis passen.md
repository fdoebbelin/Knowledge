---
id: 202611262024
title: Die Rust-Erweiterung der Flatpak-SDK muss zur Freedesktop-Basis passen
type: zettel
tags:
  - linux/flatpak
  - rust
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Rust kommt im Flatpak-Build über eine SDK-Erweiterung, `org.freedesktop.Sdk.Extension.rust-stable`. Ihre Version richtet sich nicht nach der GNOME-Runtime, gegen die man baut, sondern nach deren Freedesktop-Basis. Passt sie nicht, stimmt die ABI nicht, und der Build scheitert.

Der Name der GNOME-Runtime verrät die Basis nicht (`org.gnome.Sdk//50`). Also nachschlagen statt raten:

```nu
flatpak remote-info flathub -m org.gnome.Sdk//50 | lines | where $it =~ "freedesktop"
```

Maßgeblich ist der `version=`-Eintrag im Abschnitt der Erweiterung. Freedesktop erscheint jährlich im August und wird zwei Jahre gepflegt, die GNOME-Runtime folgt den GNOME-Versionen. Meist teilen sich deshalb zwei GNOME-Versionen eine Basis.

Robuster ist es, die Auflösung dem Builder zu überlassen. Mit `--install-deps-from=flathub` installiert `flatpak run org.flatpak.Builder` Runtime, SDK und passende Erweiterung selbst – dann bleibt ein Manifest auch nach dem nächsten GNOME-Wechsel gültig.

## Verbindungen

- [[Gebaut wird gegen dieselbe Umgebung, in der später gelaufen wird]] – warum überhaupt im SDK gebaut wird
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
