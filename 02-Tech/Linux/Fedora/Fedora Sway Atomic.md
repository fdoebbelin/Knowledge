---
title: Fedora Sway Atomic
aliases:
  - Sway Atomic
  - Fedora Atomic
tags:
  - fedora
  - atomic
  - sway
  - linux
system: Fedora Sway Atomic
created: 2026-09-22
updated: 2026-09-22
status: draft
---

# Fedora Sway Atomic

Image-basierte Fedora-Variante mit dem Wayland-Compositor Sway. Das System kommt als Ganzes aus einem Abbild, `/usr` ist im Betrieb schreibgeschützt, Updates werden als neues Abbild installiert und beim nächsten Start aktiv. Referenzsystem für die Leitfäden in diesem Vault.

> [!note] Stichwortnotiz
> Einstieg in das Thema, Details in den verlinkten Notizen.

## Wohin Software gehört

| Art | Weg | Anmerkung |
| --- | --- | --- |
| CLI-Werkzeuge | Homebrew | ohne Layering, ohne Neustart; nur auf dem Host, nicht in Toolbx |
| Einzelne Binaries | `~/.local/bin` | funktioniert auf Host **und** in jedem Container |
| Build-Abhängigkeiten, Systembibliotheken | [[Toolbx]] | eigenes beschreibbares `/usr` |
| GUI-Anwendungen | Flatpak | siehe [[00 Flathub einrichten]] |
| Muss beim Booten da sein | Basisimage / `rpm-ostree` | Treiber, Compositor; erfordert Neustart |

Ausführlich mit Begründung: [[00 Werkzeuge ins HOME-Verzeichnis installieren]].

## Typische Folgen im Alltag

- **Herstellertreiber mit eigenen Filtern** (Drucker, Scanner) bräuchten einen `rpm-ostree`-Layer. Treiberlose Wege sind vorzuziehen, siehe [[CUPS]] und [[2026-09-22 Netzwerkdrucker Fedora Sway Atomic]].
- **Eigene Sway-Overrides gehören nach `~/.config/sway/config.d/`**, nicht in `/usr/share/sway/config.d/` – das wird bei `rpm-ostree upgrade` durch die mitgelieferte Config ersetzt. Gilt z. B. für Monitor-Anordnung und `kanshi`-Autostart, siehe [[2026-09-23 Monitoranordnung unter Sway konfigurieren]].
- **`/home` ist ein Symlink auf `/var/home`.** Pfade unterscheiden sich je nach Blickwinkel, in Containern lösen Host-Pfade unter `/home/...` ins Leere auf.
- **Nichts am System vorbei installieren.** Was nicht ins Home, in einen Container oder ein Flatpak passt, gehört ins Image.

## Verwandt

- [[Bluefin]] – fertiges Atomic-Image auf derselben Grundlage
- [[00 container-bootc-flatpak]] – Container, bootc und Flatpak im Zusammenspiel
- [[Yazi – Installation und Plugins]] – Beispiel für den brew-Weg
