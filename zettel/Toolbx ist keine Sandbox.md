---
id: 202611262018
title: Toolbx ist keine Sandbox
type: zettel
tags:
  - linux/toolbx
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Toolbx sieht nach Isolation aus, ist aber ein Werkzeug für Bequemlichkeit. Der Container läuft unter der Benutzerkennung des Hosts und teilt mit ihm das Home-Verzeichnis, die Sitzung und das Netz. Zusätzlich hängt Toolbx das ganze Wurzeldateisystem des Hosts unter `/run/host` ein:

```nu
ls /run/host/var/home    # Host-Dateien, aus dem Container heraus
```

Das hilft im Notfall, etwa um eine Host-Datei außerhalb des Homes zu lesen. Es zeigt aber auch, was Toolbx nicht leistet: Ein Programm im Container darf alles, was der Benutzer auf dem Host darf. Wer fremden oder unfertigen Code abschirmen will, braucht eine echte Sandbox, zum Beispiel Flatpak mit knapp gesetzten Rechten. `flatpak info --show-permissions` zeigt, was eine App sehen darf.

Toolbx trennt also Paketbestände, nicht Rechte. Genau dafür ist es gedacht: Build-Abhängigkeiten installieren, ohne das unveränderliche Basisimage anzufassen.

## Verbindungen

- [[Toolbx teilt mit dem Host nur das Home-Verzeichnis]] – was ohne Zutun geteilt wird
- [[Gebaut wird gegen dieselbe Umgebung, in der später gelaufen wird]] – warum die ausgelieferte App im Flatpak entsteht und nicht im Toolbx
- [[AppImages lassen sich in Toolbx nicht bauen]] – AppImage fehlt genau die Sandbox, die Flatpak mitbringt
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]
