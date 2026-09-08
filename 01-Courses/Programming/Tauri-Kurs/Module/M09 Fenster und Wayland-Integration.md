---
modul: M09
titel: Fenster und Wayland-Integration
ue: 4
phase: Desktop
ort: beide
tags: [tauri/kurs/modul, wayland, sway, window]
status: entwurf
---

# M09 – Fenster und Wayland-Integration

> [!abstract] Worum es geht
> Fenstersteuerung unter einem Tiling-Compositor. Dieses Modul weicht am stärksten von gängigen Tauri-Kursen ab, weil unter Wayland und Sway mehrere Standardrezepte nicht greifen. Das ehrlich zu benennen ist Teil des Lernziels.

## Lernziele

- Fenstereigenschaften konfigurieren und zur Laufzeit verändern
- Ein zweites Fenster öffnen und mit dem Hauptfenster kommunizieren
- Die `app_id` setzen und darüber Sway-Regeln greifen lassen
- Begründen, warum globale Tastenkürzel unter Wayland nicht funktionieren
- Einschätzen, welche Desktop-Integrationen auf dem Zielsystem realistisch sind

## Was hier nicht funktioniert

> [!danger] Ehrliche Bestandsaufnahme
> - **Globale Tastenkürzel.** `plugin-global-shortcut` setzt eine X11-artige Tastaturübernahme voraus. Wayland verweigert das aus Sicherheitsgründen. Ersatz: Sway-Keybinding, das die App per `flatpak run` oder D-Bus anspricht.
> - **Fensterposition und -größe.** Unter einem Tiling-Compositor entscheidet Sway. `center: true`, `x`, `y` und teilweise `width`/`height` werden ignoriert. Ersatz: `for_window`-Regeln in der Sway-Konfiguration.
> - **Tray.** Braucht einen StatusNotifierItem-Anbieter. Sway bringt keinen mit. Nur nutzbar, wenn Waybar mit `tray`-Baustein läuft. Vorab prüfen, sonst Abschnitt streichen.
> - **Anwendungsmenü.** Wird unter Linux als GTK-Menüleiste im Fenster gezeichnet, nicht global wie unter macOS. Unter Sway wirkt das oft fremd. Alternative: eigene Toolbar-Komponente aus Modul 04.

## Inhalte

1. **Statische Fensterkonfiguration** in `tauri.conf.json`: Titel, Mindestgröße, `resizable`, `decorations`
2. **`app_id` setzen** und in Sway prüfen

```nu
swaymsg -t get_tree | from json | to json --indent 2 | lines | where $it =~ "app_id" | uniq
```

```
for_window [app_id="noteflow"] move container to workspace number 2
for_window [app_id="noteflow"] floating enable, resize set 1000 700
```

3. **Fenster-API zur Laufzeit** – `getCurrentWindow`, Titel setzen, minimieren, Vollbild
4. **Mehrere Fenster** – `WebviewWindow` erzeugen, Kommunikation über Events aus [[M08 Eigene Commands und Events]]
5. **Kontextmenü** – im Frontend selbst gebaut, siehe Modul 04, statt über die Systemebene
6. **Fensterzustand erhalten** – `plugin-window-state`, unter Tiling nur eingeschränkt sinnvoll
7. **Schließverhalten** – Rückfrage bei ungespeicherten Änderungen
8. **Desktop-Datei** – `Exec`, `Icon`, `StartupWMClass` und ihr Zusammenspiel mit der `app_id`. Vorlage aus dem Leitfaden.

## Praxisteil

- [ ] `app_id` setzen und in `swaymsg -t get_tree` nachweisen
- [ ] Sway-Regel schreiben, die NoteFlow auf einen festen Workspace legt
- [ ] Zweites Fenster für die Notizvorschau öffnen, über Events synchron halten
- [ ] Rückfrage beim Schließen bei ungespeicherten Änderungen
- [ ] Prüfen, ob ein Tray-Anbieter läuft; falls ja, Tray-Symbol ergänzen, falls nein, das Ergebnis der Prüfung dokumentieren
- [ ] Desktop-Datei aus dem Leitfaden auf NoteFlow anpassen

## Typische Fallstricke

> [!warning]
> - `decorations: false` ohne eigene Titelleiste. Unter Sway weniger dramatisch als anderswo, weil der Compositor das Fenster ohnehin verwaltet, aber unter GNOME auf Zielgeräten fatal.
> - `app_id` und `StartupWMClass` weichen voneinander ab. Die Anwendung erscheint dann doppelt im Dock anderer Desktops.
> - Rezepte aus Tauri-Tutorials, die X11 voraussetzen, werden ungeprüft übernommen und scheitern stumm.

## Diskussionsimpuls

Wie viel Desktop-Integration gehört überhaupt in die Anwendung, wenn der Compositor das ohnehin besser kann? Argumente für beide Seiten.

## Verknüpfung

Weiter mit [[M10 Persistenz im Sandkasten]] · zurück zu [[00 Kurskonzept Tauri]]
