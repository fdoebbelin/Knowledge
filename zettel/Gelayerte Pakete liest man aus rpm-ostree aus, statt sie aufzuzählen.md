---
id: 202611262022
title: Gelayerte Pakete liest man aus rpm-ostree aus, statt sie aufzuzählen
type: zettel
tags:
  - linux/atomic
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Auf Fedora Atomic legt `rpm-ostree install` Pakete über das Basisimage (Layering). Um sie wieder loszuwerden, liegt es nahe, dieselbe Liste an `rpm-ostree uninstall` zu geben. Das scheitert, sobald ein Name darin gar nicht gelayert ist, etwa weil das Paket schon zum Basisimage gehört – dann bricht der ganze Aufruf ab.

Zuverlässiger ist, die Liste aus dem System zu lesen:

```nu
let gelayert = (rpm-ostree status --json | from json | get deployments.0.requested-packages?)
if ($gelayert | is-not-empty) { rpm-ostree uninstall ...$gelayert }
```

Pakete des Basisimages sind kein Layering. Sie zu entfernen wäre Sache von `rpm-ostree override remove`, und das tut man ohne Not nicht. Nach dem Entfernen ist ein Neustart fällig, weil `/usr` als Ganzes getauscht wird.

Vollständiger zeigt `rpm-ostree status -v` den Zustand, mit lokalen, ersetzten und entfernten Paketen. Steht dort `Unlocked`, ist ein `usroverlay` aktiv: Dessen Änderungen tauchen in keiner Liste auf und verschwinden beim nächsten Neustart. Abweichungen in `/etc` findet `ostree admin config-diff`.

## Verbindungen

- [[Auf Fedora Atomic ist das Verzeichnis home ein Symlink]] – derselbe Grund: `/usr` gehört zum unveränderlichen Image
- [[Toolbx teilt mit dem Host nur das Home-Verzeichnis]] – Build-Abhängigkeiten gehören in den Container statt ins Basisimage
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
