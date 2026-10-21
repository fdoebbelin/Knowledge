---
title: "Helix mit sudoedit als root-Datei bearbeiten"
aliases:
  - sudoedit
tags:
  - helix
  - linux
  - terminal
created: 2026-10-13
status: active
type: anleitung
---

`sudoedit` kopiert die Datei in eine temporäre, dir gehörende Kopie, lässt dich als normaler User editieren und schreibt sie danach zurück. Vorteil: Helix läuft **nicht** als root, lädt also deine eigene Config/Plugins statt root's – und das gefürchtete „Editor mit vollen Rechten"-Problem entfällt.

In Bash:

```bash
SUDO_EDITOR=hx sudoedit /etc/hosts
```

In Nushell geht das Inline-`VAR=val` nicht (wie bei deinem `LANG=C`-Fall), daher mit `with-env`:

```nu
with-env {SUDO_EDITOR: "hx"} { sudoedit /etc/hosts }
```

Oder du setzt es dauerhaft in deiner Nushell-Config, dann reicht später einfach `sudoedit /etc/hosts`:

```nu
# in ~/.config/nushell/env.nu
$env.SUDO_EDITOR = "hx"
$env.EDITOR = "hx"
```

`sudoedit` wertet `SUDO_EDITOR` → `VISUAL` → `EDITOR` aus, in dieser Reihenfolge.

**Quick & dirty (nicht ideal):**

```bash
sudo hx /etc/hosts
```

Funktioniert nur, wenn `sudo` das Programm findet: Es sucht über seinen eigenen `secure_path` (anzeigen mit `sudo -l | grep secure_path`), und der enthält bei Fedora standardmäßig nur Systempfade – weder `/home/linuxbrew/.linuxbrew/bin` noch `~/.local/bin`. Bei beiden Linux-Wegen aus [[03-Installation]] heißt es dann `command not found`; in Nushell hilft `sudo (which hx | get path.0) /etc/hosts`. Außerdem läuft Helix komplett als root und liest `/root/.config/helix/` statt deiner Konfiguration. Für eine schnelle Einzelzeile okay, dauerhaft aber `sudoedit` vorziehen.

## Verwandt

- [[03-Installation]] – Helix installieren und als `$EDITOR` setzen
- [[Nushell Editor setzen]] – `$EDITOR`/`$VISUAL` dauerhaft in Nushell setzen