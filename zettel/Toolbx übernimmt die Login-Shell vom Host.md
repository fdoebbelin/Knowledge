---
id: 202611262020
title: Toolbx übernimmt die Login-Shell vom Host
type: zettel
tags:
  - linux/toolbx
  - shell
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

`toolbox enter` startet die Shell, die in der `/etc/passwd` des **Hosts** steht. Toolbx erzeugt den Benutzereintrag im Container bei jedem Start neu aus den Host-Daten, ein `chsh` im Container hält deshalb nicht.

Wer im Container eine andere Shell möchte, ändert also die Login-Shell auf dem Host, und zwar mit einem Pfad, den es auf beiden Seiten gibt. Liegt die Shell im Home, etwa unter `~/.local/bin/nu`, ist das gegeben. Vorher lohnt ein Test, denn eine ungültige Login-Shell sperrt einen aus Host und Container zugleich aus:

```bash
toolbox run -c tauri-dev "$HOME/.local/bin/nu" -c "print ok"
echo "$HOME/.local/bin/nu" | sudo tee -a /etc/shells
chsh -s "$HOME/.local/bin/nu"
```

`/etc` ist auch auf Atomic-Systemen beschreibbar, dafür braucht es kein Layering.

Soll bash Login-Shell bleiben, kann die `.bashrc` im Container per `exec` zu Nushell wechseln. Dann braucht es drei Bedingungen – Markerdatei vorhanden, Binary ausführbar, eine Variable gegen das Zurückspringen – und die `.bashrc` muss nicht-interaktive Aufrufe vorher abfangen, sonst landet auch `toolbox run … bash -c` in Nushell.

## Verbindungen

- [[Eine Markerdatei zeigt an, dass die Shell im Toolbx-Container läuft]] – die Abfrage, mit der bash im Container gezielt wechselt
- [[Toolbx teilt mit dem Host nur das Home-Verzeichnis]] – warum die Shell im Home liegen muss, damit der Pfad auf beiden Seiten gilt
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
