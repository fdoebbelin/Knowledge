---
title: GUI-Toolkit-Strategie
tags:
  - hyprland
  - wayland
  - qt
  - gtk
  - theming
created: 2026-06-29
system: Fedora 44 / Hyprland
status: active
---

# GUI-Toolkit-Strategie

> [!info] Kernaussage
> Unter Hyprland ist die entscheidende Frage **nicht** „KDE Plasma vs. GNOME", sondern **nativer Wayland-Modus vs. XWayland**. Wayland ist Toolkit-agnostisch — Qt- und GTK-Programme lassen sich problemlos mischen. Welches Toolkit eine App nutzt, ist zweitrangig; entscheidend ist, ob sie nativ auf Wayland läuft.

Vollwertige Desktop-Umgebungen (KDE Plasma, GNOME) werden **nicht** installiert. Es kommen nur einzelne GUI-Programme zum Einsatz, ausgewählt nach Toolkit-Eignung und Wayland-Unterstützung.

## Empfehlung: Qt/KDE bevorzugen

> [!check] Begründung für diesen Stack
> Über [[Dolphin einrichten|Dolphin]] und [[Noctalia Shell]] (Quickshell = QML = Qt) ist dieses System ohnehin tief im Qt-Ökosystem verankert. Eine Qt-Tendenz bei sonstigen GUI-Programmen bringt:
> - **Theming an einer Stelle** — nur Qt (`qt6ct` + Kvantum) pflegen statt zwei parallele Theming-Systeme.
> - **Server-Side Decorations** — Qt-Apps können die Fensterdekoration Hyprland überlassen. GTK erzwingt Client-Side Decorations (eigene Titelleisten).
> - **Weniger DE-Zwang** — KDE-Einzelprogramme ziehen meist nur KDE-Frameworks-Bibliotheken nach, nicht den halben Desktop.

### Konkrete Programmempfehlungen (Qt)

| Aufgabe        | Programm   |
| -------------- | ---------- |
| Dateimanager   | Dolphin    |
| Texteditor     | Kate / KWrite |
| PDF-Betrachter | Okular     |
| Bildbetrachter | Gwenview   |
| Archive        | Ark        |
| Screenshots    | Spectacle  |

## GTK/GNOME: brauchbar, aber mit Vorbehalten

> [!warning] Vorbehalte bei GTK/GNOME-Programmen
> - **libadwaita ignoriert das System-Theme** — viele moderne GNOME-Apps lassen sich kaum umfärben.
> - GNOME-Apps ziehen oft **viele Abhängigkeiten** nach (tracker, gvfs-Backends, Teile von gnome-control-center).
> - Daher GTK-Programme nur wählen, wenn sie schlicht das **beste Werkzeug** sind (z. B. GIMP, Inkscape) — nicht aus Prinzip.

## „Native Grafikbibliotheken"

Für vollwertige Anwendungen selten praktikabel — fast jede echte App ist Qt oder GTK. „Nativ" ist eher bei Desktop-**Komponenten** relevant (Bar, Launcher, Notifications), und genau dort wird mit Quickshell bereits QML/Qt genutzt. Hier muss nichts Drittes evaluiert werden.

## Faustregel

> [!tip] Entscheidungskette
> Qt-Programm bevorzugen → sonst das beste verfügbare Werkzeug → immer die **native-Wayland**-Variante → volle Desktop-Meta-Pakete (`@kde-desktop`, `@gnome-desktop`) niemals installieren, nur Einzelprogramme.

## Umgebungsvariablen

> [!warning] Syntax-Kontext
> Diese Variablen gehören in die `env =`-Zeilen der [[Hyprland Konfiguration]]. Diese werden über `/bin/sh` ausgewertet — also **POSIX-Syntax**, kein nushell. Dies sind Konfigurationszeilen, keine Konsolenbefehle.

```ini
# in hyprland.conf bzw. als env-Einträge in hyprland.lua
env = QT_QPA_PLATFORM,wayland
env = QT_QPA_PLATFORMTHEME,qt6ct
env = GDK_BACKEND,wayland,x11
env = ELECTRON_OZONE_PLATFORM_HINT,wayland
```

`ELECTRON_OZONE_PLATFORM_HINT` betrifft die Electron-/Chromium-Programme im Bestand — [[Obsidian einrichten|Obsidian]] und [[Vivaldi einrichten|Vivaldi]].

## Prüf- und Einrichtungsbefehle

Welche laufenden Fenster noch über XWayland laufen:

```nu
hyprctl clients -j | from json | where xwayland == true | select class title
```

Installierte Portals anzeigen (Hyprland braucht `xdg-desktop-portal-hyprland` plus ein GTK-Backend für Datei-Dialoge):

```nu
^rpm -qa | lines | find xdg-desktop-portal | sort
```

Qt-Theming-Werkzeuge installieren:

```nu
sudo dnf install -y qt6ct kvantum
```

Relevante Umgebungsvariablen im aktuellen Prozess gegenprüfen:

```nu
{
    QT_QPA_PLATFORM: $env.QT_QPA_PLATFORM?
    QT_QPA_PLATFORMTHEME: $env.QT_QPA_PLATFORMTHEME?
    GDK_BACKEND: $env.GDK_BACKEND?
    ELECTRON_OZONE_PLATFORM_HINT: $env.ELECTRON_OZONE_PLATFORM_HINT?
}
```

## Aufgaben

- [ ] `qt6ct` und `kvantum` installieren
- [ ] Umgebungsvariablen in [[Hyprland Konfiguration]] eintragen
- [ ] Nach Neustart mit `hyprctl clients` prüfen, dass keine GUI-App unnötig über XWayland läuft
- [ ] `xdg-desktop-portal-hyprland` und GTK-Backend-Portal verifizieren

## Verwandte Notizen

- [[Hyprland Konfiguration]]
- [[Dolphin einrichten]]
- [[Noctalia Shell]]
- [[Obsidian einrichten]]
- [[Vivaldi einrichten]]
