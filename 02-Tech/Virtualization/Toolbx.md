---
title: Toolbx
aliases:
  - toolbox
tags:
  - container
  - atomic
  - fedora
  - toolbx
created: 2026-09-22
updated: 2026-09-22
status: draft
---

# Toolbx

Werkzeug für veränderbare Entwicklungs-Container auf image-basierten Systemen wie [[Fedora Sway Atomic]] oder [[Bluefin]]. Der Container teilt sich `$HOME` mit dem Host, hat aber ein eigenes, beschreibbares `/usr`. Damit lässt sich alles installieren, was sonst einen `rpm-ostree`-Layer und einen Neustart bräuchte.

> [!note] Stichwortnotiz
> Einstieg in das Thema, Details in den verlinkten Notizen.

## Grundbefehle

```nu
toolbox create <name>     # Container anlegen
toolbox enter <name>      # hineinwechseln
toolbox list              # vorhandene Container
toolbox run -c <name> <befehl>
toolbox rm <name>         # entfernen (Container vorher stoppen)
```

## Was dabei zu beachten ist

- **`$HOME` ist geteilt**, `/usr` nicht. Werkzeuge im Container, Daten im Home.
- **Homebrew funktioniert im Container nicht**: `/home/linuxbrew` liegt außerhalb von `$HOME` und ist dort nicht eingehängt, siehe [[00 Werkzeuge ins HOME-Verzeichnis installieren]].
- **`toolbox enter` startet eine neue Shell.** Mehrzeilige Blöcke, die man am Stück einfügt, brechen an dieser Stelle ab; Variablen gelten nur in der jeweiligen Sitzung.
- **Wegwerf-Container** sind ein gutes Muster: Container für eine Aufgabe anlegen, danach mit `toolbox rm` entfernen, wie im Protokoll [[2026-09-21 Lexikothek CD-Archivierung]].

## Verwandt

- [[00 Einrichtung einer Container-Umgebung]]
- [[00 container-bootc-flatpak]] – Einordnung Container, bootc, Flatpak
- [[Von der leeren Toolbx zur installierten Flatpak-App]]
- [[2026-09-22 Netzwerkdrucker Fedora Sway Atomic]] – Netzwerk-Werkzeuge im Container statt im Image
