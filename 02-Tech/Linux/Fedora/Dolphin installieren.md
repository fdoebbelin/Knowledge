---
title: Dolphin installieren
tags:
  - fedora
  - installation
  - dolphin
  - dateimanager
  - hyprland
  - nushell
created: 2026-06-28
system: Fedora + Hyprland + Nushell
status: done
---

# Dolphin installieren

> [!abstract] TL;DR
> Dolphin ist der Dateimanager von KDE und liegt in den offiziellen Fedora-Repos (`dnf install dolphin`). Er läuft als **Qt6-App nativ unter Wayland** – die eigentliche Einrichtung unter Hyprland betrifft das Drumherum: **Vorschaubilder**, **Laufwerke einhängen** (Polkit-Agent), als **Standard-Dateimanager** setzen und optional als **Datei-Dialog** für andere Apps.

Siehe auch: [[00 Installations-Übersicht]] · [[Nushell installieren]] · [[Hyprland Konfiguration]]

> [!note] Kontext
> Alle Befehle hier laufen bereits in **Nushell** (`nu` ist installiert, siehe [[Nushell installieren]]). `dnf`, `flatpak`, `xdg-mime` usw. sind externe Programme und verhalten sich in jeder Shell gleich – die nu-typische Syntax zeigt sich beim Prüfen (`which`), beim Auslesen strukturierter Ausgaben und beim Schreiben von Konfig-Dateien mit `save`.

---

## 1 – Installation

```nu
sudo dnf install dolphin
```

Das zieht die KDE-Frameworks (KF6, KIO, Breeze-Icons) als Abhängigkeiten mit. Danach kurz prüfen:

```nu
which dolphin
```

```nu
dolphin --version
```

---

## 2 – Ergänzungspakete (empfohlen)

Dolphin selbst kann viel, aber ohne diese Pakete fehlen Vorschaubilder, Archiv-Aktionen und Netzwerk-Protokolle. Alles in einem Rutsch:

```nu
sudo dnf install dolphin-plugins ark kio-extras kde-cli-tools kdegraphics-thumbnailers ffmpegthumbs qt6-qtimageformats
```

> [!info] Wofür ist was?
> - **dolphin-plugins** → Git-/Versionskontroll-Aktionen im Kontextmenü
> - **ark** → „Hier entpacken" / „Komprimieren" im Kontextmenü
> - **kio-extras** → zusätzliche Protokolle (`sftp:/`, `mtp:/`, Samba-Freigaben) und mehr Thumbnailer
> - **kde-cli-tools** → `kioclient`, „Im Terminal öffnen", Standard-App-Handling
> - **kdegraphics-thumbnailers** → Vorschau für PDF, RAW, Blender u. a.
> - **ffmpegthumbs** → Vorschaubilder für Videos
> - **qt6-qtimageformats** → zusätzliche Bildformate (WebP, AVIF …)

---

## 3 – Hyprland-Integration

### 3.1 Polkit-Agent (Laufwerke einhängen)

USB-Sticks hängt `udisks2` meist ohne Nachfrage ein. Sobald aber eine Authentifizierung nötig ist (interne/verschlüsselte Datenträger), braucht Hyprland einen laufenden **Polkit-Agenten** – sonst scheitert das Einhängen kommentarlos.

```nu
sudo dnf install hyprpolkitagent
```

Als systemd-User-Service aktivieren (startet künftig automatisch mit der Session):

```nu
systemctl --user enable --now hyprpolkitagent.service
```

> [!tip] Alternative
> Wer den Start lieber direkt in der Hyprland-Konfig hat, nutzt statt des User-Service eine Zeile in `hyprland.conf`:
> ```conf
> exec-once = systemctl --user start hyprpolkitagent
> ```

### 3.2 Als Standard-Dateimanager setzen

Damit andere Programme (und `xdg-open` auf Ordnern) Dolphin verwenden:

```nu
xdg-mime default org.kde.dolphin.desktop inode/directory
```

Prüfen, ob es gesetzt ist:

```nu
xdg-mime query default inode/directory
```

> [!success] Erwartete Ausgabe
> `org.kde.dolphin.desktop`

### 3.3 Tastenkürzel in Hyprland

In `~/.config/hypr/hyprland.conf` (Super + E ist die übliche Belegung):

```conf
bind = $mainMod, E, exec, dolphin
```

Konfig neu laden, ohne die Session zu beenden:

```nu
hyprctl reload
```

---

## 4 – Vorschaubilder aktivieren

Die Backends aus Schritt 2 liefern nur die *Fähigkeit* – aktiviert werden die Vorschauen in Dolphin selbst:

**Einstellungen → Allgemein → Vorschauen** → die gewünschten Typen anhaken (Bilder, Videos via ffmpegthumbs, PDF usw.).

> [!warning] Vorschau für große/Netzwerk-Dateien
> Standardmäßig erzeugt Dolphin nur Vorschauen bis zu einer Größenschwelle und nicht über Netzwerkprotokolle. Beides lässt sich im selben Dialog hochsetzen, kostet bei Netzwerkfreigaben aber Ladezeit.

---

## 5 – Optional: Dolphin als Datei-Dialog (Portal)

Damit GTK-/Browser-Apps unter Hyprland den **KDE-Datei-Dialog** (statt des minimalen GTK-Pickers) mit Dolphin-Orten verwenden:

```nu
sudo dnf install xdg-desktop-portal-kde
```

Portal-Vorrang für Hyprland festlegen – die Konfig-Datei wird sauber mit `save` geschrieben:

```nu
mkdir ~/.config/xdg-desktop-portal
```

```nu
"[preferred]
default=hyprland;gtk
org.freedesktop.impl.portal.FileChooser=kde
" | save --force ~/.config/xdg-desktop-portal/hyprland-portals.conf
```

Danach ab- und wieder anmelden (oder neu starten), damit die Portale neu laden.

> [!caution] Nur bei Bedarf
> Diese Portal-Umleitung ist optional und kann je nach App zu gemischtem Verhalten führen. Wenn der Standard-Dialog reicht, diesen Schritt überspringen.

---

## 6 – Verifizieren

Dolphin starten:

```nu
dolphin
```

Prüfen, ob Dolphin **nativ unter Wayland** läuft (nicht über XWayland) – analog zum Obsidian-Check:

```nu
hyprctl clients -j | from json | where class =~ '(?i)dolphin' | select class title xwayland
```

> [!success] Erwartetes Ergebnis
> Spalte `xwayland` zeigt `false`. Dann rendert Dolphin nativ und scharf. Bei `true` müsste man die Qt-Plattform forcieren (`QT_QPA_PLATFORM=wayland`), was bei Dolphin normalerweise aber nicht nötig ist.

---

## 7 – Optional: Dunkles Design

Ohne laufendes KDE Plasma nutzt Dolphin das helle Breeze-Theme. Für Breeze Dark am einfachsten die Systemeinstellungen nachinstallieren und dort das Farbschema wählen:

```nu
sudo dnf install systemsettings
```

```nu
systemsettings
```

→ **Farben** bzw. **Erscheinungsbild** → *Breeze Dark*. Das schreibt nach `~/.config/kdeglobals` und gilt dann für alle KDE-Apps (Dolphin, Ark, Gwenview …).

---

## Befehlsübersicht

| Zweck | Befehl |
|---|---|
| Installation | `sudo dnf install dolphin` |
| Ergänzungspakete | `sudo dnf install dolphin-plugins ark kio-extras kde-cli-tools kdegraphics-thumbnailers ffmpegthumbs qt6-qtimageformats` |
| Polkit-Agent | `systemctl --user enable --now hyprpolkitagent.service` |
| Standard-Dateimanager | `xdg-mime default org.kde.dolphin.desktop inode/directory` |
| Wayland-Check | `hyprctl clients -j \| from json \| where class =~ '(?i)dolphin'` |
| Deinstallieren | `sudo dnf remove dolphin` |
