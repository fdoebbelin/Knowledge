---
title: Fensterdekorationen ausblenden
tags:
  - hyprland
  - fensterdekoration
  - vivaldi
  - obsidian
  - css
created: 2026-06-29
system: Fedora 44 / Hyprland
status: active
---

# Fensterdekorationen ausblenden

Unter Hyprland werden Fenster-Schaltflächen (Minimieren / Maximieren / Schließen) **nicht vom Compositor gezeichnet**. Hyprland liefert keine serverseitigen Dekorationen (SSD), sondern nur den eigenen Rahmen (Border, Rundung, Schatten). Die Buttons stammen also immer aus den Anwendungen selbst als **Client-Side Decorations (CSD)** und müssen pro Toolkit bzw. pro App abgeschaltet werden.

> [!info] Merksatz
> Keine Buttons sichtbar = App malt **keine** eigenen CSD und verlässt sich auf den Compositor. Da Hyprland nichts liefert, bleibt die Titelzeile leer.

Siehe auch: [[Hyprland Konfiguration]] · [[Dolphin einrichten]] · [[Vivaldi installieren]] · [[Obsidian einrichten]]

---

## Dolphin / Qt-Apps

Erledigt sich von selbst. KDE-/Qt-Apps verlassen sich unter Hyprland (kein KWin) auf serverseitige Dekoration – die Hyprland nicht liefert. Ergebnis: **keine Buttons**, ohne Zutun.

> [!check] Status
> Dolphin zeigt bereits keine Fenster-Buttons. Kein Eingriff nötig.

---

## Obsidian

Obsidian (Electron) malt seine Buttons selbst. Der entscheidende Schalter ist der Fensterrahmen-Stil:

- **Einstellungen → Erscheinungsbild → Fensterrahmen-Stil → `Nativ`**

Bei `Nativ` überlässt Obsidian die Dekoration dem Compositor. Da Hyprland keine CSD zeichnet, verschwinden Titelleiste **und** Buttons.

> [!warning] Nicht „Obsidian-Rahmen" wählen
> Der Stil **`Obsidian-Rahmen`** zeichnet eine eigene Titelleiste **mit** Min/Max/Close-Buttons. Genau das willst du hier vermeiden. Nur `Nativ` blendet die Buttons unter Hyprland aus.

- [ ] Obsidian → Einstellungen → Erscheinungsbild öffnen
- [ ] Fensterrahmen-Stil auf `Nativ` setzen
- [ ] Prüfen: Titelzeile inkl. Buttons ist verschwunden

---

## Vivaldi

Vivaldi (Chromium) zeichnet Menü-, Minimieren-, Maximieren- und Schließen-Button als Teil seiner **eigenen** Oberfläche, verschmolzen mit Tab-/Adressleiste. Einen offiziellen „Buttons aus"-Schalter gibt es nicht. Sauberster vollständiger Weg: **CSS-Mod**.

### 1. Mod-Ordner und `custom.css` anlegen

```nu
mkdir ~/.config/vivaldi-mods
"/* Fenster-Buttons (Minimieren / Maximieren / Schließen) ausblenden */
.window-buttongroup { display: none !important; }
" | save -f ~/.config/vivaldi-mods/custom.css
```

Pfad prüfen:

```nu
open ~/.config/vivaldi-mods/custom.css
```

### 2. CSS-Mods in Vivaldi aktivieren

Diese Schritte laufen in der Vivaldi-GUI (das Experiments-Flag liegt in der `Preferences`-JSON und lässt sich nicht sinnvoll per CLI setzen):

- [ ] `vivaldi://experiments/` öffnen → **„Allow for using CSS modifications"** aktivieren
- [ ] `vivaldi://settings/appearance/` öffnen → unter **„Custom UI Modifications"** den Ordner `~/.config/vivaldi-mods` auswählen
- [ ] Vivaldi vollständig neu starten
- [ ] Prüfen: Min/Max/Close-Buttons sind weg

> [!tip] Reine CSS-Mods überleben Updates
> Über diesen Weg (Experiments-Flag + Ordner in den Einstellungen) muss **nichts** in `window.html` editiert werden. Das Editieren von `window.html` ist nur für **JavaScript**-Mods nötig – für reines CSS nicht. Der gewählte Ordner liegt außerhalb des Installationsverzeichnisses und wird bei Updates nicht überschrieben.

> [!warning] Inoffiziell & versionsabhängig
> UI-CSS-Mods sind von Vivaldi **nicht offiziell unterstützt** (User-für-User). In v7.7+ hat sich die Verortung der Experiments-Flags geändert. Falls der Eintrag unter `vivaldi://experiments/` fehlt, im Changelog der installierten Version nach dem aktuellen Ort suchen.

### Variante: Buttons nur beim Überfahren zeigen

Statt komplett ausblenden – beim Hovern wieder einblenden. Inhalt der `custom.css` ersetzen durch:

```css
button.window-close,
button.window-minimize,
button.window-maximize {
  opacity: 0;
}
button.window-close:hover,
button.window-minimize:hover,
button.window-maximize:hover {
  opacity: 1;
}
```

### Alternativen ohne CSS-Mod

Falls kein Mod gewünscht ist, gibt es zwei eingebaute Kompromisse:

- **Titelleiste abschalten:** Settings → Appearance → Window Appearance → **„Show Title Bar"** deaktivieren.
- **Tab-Leiste umziehen:** Tab-Leiste nach links/rechts/unten – die Buttons wandern in die Adressleiste, die separate Titelzeile entfällt.

---

## GTK-Apps (generisch)

Für GTK3/GTK4-Apps ist der nicht-destruktive Weg `gsettings`. Das Layout-Format ist `links:rechts`; ein einzelner Doppelpunkt heißt „nichts auf beiden Seiten":

```nu
gsettings set org.gnome.desktop.wm.preferences button-layout ":"
```

Wirkt sofort und persistent für alle GTK-Apps; die Headerbar bleibt, nur die Buttons verschwinden.

> [!example] Persistent in Config-Dateien (optional)
> Falls lieber dateibasiert statt über dconf:
> ```nu
> let conf = "[Settings]\ngtk-decoration-layout=:\n"
> mkdir ~/.config/gtk-3.0
> mkdir ~/.config/gtk-4.0
> $conf | save -f ~/.config/gtk-3.0/settings.ini
> $conf | save -f ~/.config/gtk-4.0/settings.ini
> ```

---

## Zusammenfassung

| App / Toolkit   | Methode                                                        | Aufwand          |
| --------------- | -------------------------------------------------------------- | ---------------- |
| Dolphin / Qt    | nichts (keine CSD unter Hyprland)                              | keiner           |
| Obsidian        | Fensterrahmen-Stil → `Nativ`                                   | 1 Klick          |
| Vivaldi         | CSS-Mod `.window-buttongroup { display: none }` + Experiments  | mittel           |
| GTK-Apps        | `gsettings ... button-layout ":"`                              | 1 Befehl         |
