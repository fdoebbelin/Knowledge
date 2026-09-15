---
title: OnlyOffice – Schriftdarstellung verbessern
tags: [fedora, onlyoffice, hyprland, xwayland, fonts, hidpi, skalierung]
created: 2026-07-06
system: Fedora 44
status: entwurf
---

# OnlyOffice – Schriftdarstellung verbessern

> [!warning] Unterschied zu Obsidian – kein Wayland-Umweg
> Bei Obsidian haben wir die Unschärfe gelöst, indem wir den Flatpak auf **natives Wayland** gezwungen haben. Bei OnlyOffice geht das **nicht**: Der mitgelieferte Qt-Build enthält **kein** Wayland-Plattform-Plugin (nur `xcb`, `minimal`, `offscreen`, `vnc`). `QT_QPA_PLATFORM=wayland` führt zu `could not find or load the Qt platform plugin "wayland"` bzw. `Could not connect to any X display`. Der Flatpak erzwingt intern `QT_QPA_PLATFORM=xcb`. Stand v9.x (Ende 2025) ist native Wayland-Unterstützung noch offen (Issue #2105).
> → **OnlyOffice läuft zwangsweise über XWayland.** Die Verbesserung setzt genau dort an.

## Ursache der unscharfen Schrift

Unter Hyprland skaliert der Compositor XWayland-Fenster bei **fraktionaler** Skalierung (z. B. 1,25 oder 1,5) per Bitmap hoch → Schrift wird unscharf. Bei **ganzzahliger** Skalierung (2,0) tritt das Problem nicht auf.

> [!info] Kernprinzip der Lösung
> 1. Hyprland das Hochskalieren von XWayland **verbieten** (`force_zero_scaling`) → OnlyOffice rendert pixelgenau, ist danach aber zu klein.
> 2. OnlyOffice **selbst** um den Monitor-Faktor vergrößern (In-App-Skalierung oder `QT_SCALE_FACTOR`) → scharf **und** richtig groß.
>
> Beide Schritte gehören zusammen. Schritt 1 allein macht die UI winzig, Schritt 2 allein bleibt unscharf.

## Teil 1 – Hyprland nicht mehr hochskalieren lassen

Der zuständige Schlüssel heißt `xwayland:force_zero_scaling`.

> [!warning] Lua-Syntax gegen die eigene `hyprland.lua` prüfen
> Klassische hyprlang-Schreibweise (**nicht** in die Lua-Config mischen):
> ```ini
> xwayland {
>     force_zero_scaling = true
> }
> ```
> Wahrscheinliche Lua-Entsprechung – bitte gegen die bestehende Struktur deiner `hyprland.lua` und via lua-language-server validieren:
> ```lua
>hl.config({
 >	xwayland = {
 >		force_zero_scaling = true
 >	}
>})
>```
> Falls deine Config Schlüssel flach über eine `keyword`-Hilfsfunktion setzt, ist die Variante `keyword("xwayland:force_zero_scaling", true)` zu prüfen.

> [!note] Nebenwirkung beachten
> `force_zero_scaling` gilt **global** für alle XWayland-Fenster – die erscheinen dann bis zur eigenen Skalierung zu klein. In diesem Setup laufen die meisten Apps ohnehin nativ auf Wayland (Obsidian erzwungen, Kitty/Dolphin/Vivaldi nativ), sodass kaum XWayland-Apps betroffen sind. Bei **ganzzahliger** Skalierung (2,0) ist der Schritt nicht nötig.

Nach der Änderung Hyprland neu laden:

```nu
hyprctl reload
```

## Teil 2 – OnlyOffice selbst skalieren

Zwei Wege – **einer** genügt. Der Faktor muss zur Monitor-Skalierung passen (Skalierung 1,5 → 150 %).

### Weg A (empfohlen): In-App-Skalierung

Kein Dateieditieren nötig:

- OnlyOffice öffnen → Menü oben links (Hamburger) → **Einstellungen**
- Abschnitt **Darstellung** → **Skalierung der Benutzeroberfläche** auf den passenden Wert (z. B. **150 %**) setzen
- Anwendung neu starten

### Weg B: Über `QT_SCALE_FACTOR`

Zuerst die tatsächliche `Exec`-Zeile der installierten `.desktop`-Datei ansehen:

```nu
open --raw /usr/share/applications/onlyoffice-desktopeditors.desktop | lines | find Exec
```

Benutzer-Override anlegen und Faktor voranstellen:

```nu
mkdir ~/.local/share/applications
cp /usr/share/applications/onlyoffice-desktopeditors.desktop ~/.local/share/applications/

# Exec-Zeile um den Skalierungsfaktor ergänzen (String an die reale Exec-Zeile anpassen)
open --raw ~/.local/share/applications/onlyoffice-desktopeditors.desktop
| str replace "Exec=onlyoffice-desktopeditors" "Exec=env QT_SCALE_FACTOR=1.5 onlyoffice-desktopeditors"
| save --force ~/.local/share/applications/onlyoffice-desktopeditors.desktop
```

Für die Flatpak-Variante stattdessen:

```nu
flatpak override --user --env=QT_SCALE_FACTOR=1.5 org.onlyoffice.desktopeditors
```

> [!tip] Diagnose – belegen, dass Wayland wirklich nicht geht
> In Nushell wird eine einmalige Umgebungsvariable **nicht** per `VAR=wert cmd` gesetzt, sondern mit `with-env`:
> ```nu
> with-env { QT_QPA_PLATFORM: wayland } { onlyoffice-desktopeditors }
> # → Fehler: could not find or load the Qt platform plugin "wayland"
> ```

## Teil 3 – Schriftglättung (fontconfig)

Unabhängig von der Skalierung schärft ein Benutzer-fontconfig die Glyphen (Hinting, Subpixel):

```nu
mkdir ~/.config/fontconfig

r#'<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match target="font">
    <edit name="antialias" mode="assign"><bool>true</bool></edit>
    <edit name="hinting"   mode="assign"><bool>true</bool></edit>
    <edit name="hintstyle" mode="assign"><const>hintslight</const></edit>
    <edit name="rgba"      mode="assign"><const>rgb</const></edit>
    <edit name="lcdfilter" mode="assign"><const>lcddefault</const></edit>
  </match>
</fontconfig>
'# | save --force ~/.config/fontconfig/fonts.conf

fc-cache -f
```

> [!note] Subpixel
> `rgb` passt zu Standard-LCDs. Falls die Schrift farbig „franst", auf Graustufen-AA umstellen: `<const>none</const>` bei `rgba`.

## Teil 4 – Dokumenttreue Schriften

Damit `.docx`/`.xlsx` mit den erwarteten Schriften statt Ersatzschriften anzeigen, die metrisch kompatiblen FOSS-Fonts installieren (kein proprietäres msttcorefonts nötig):

```nu
# Calibri→Carlito, Cambria→Caladea, Arial/Times/Courier→Liberation, plus DejaVu
sudo dnf install google-carlito-fonts google-caladea-fonts liberation-fonts dejavu-fonts-all
fc-cache -f
```

## Verifizieren

```nu
# Ersatzschriften greifen?
fc-match Calibri
fc-match "Times New Roman"
```

```nu
# Carlito/Caladea vorhanden?
fc-list | find -i carlito
fc-list | find -i caladea
```

Danach OnlyOffice starten und ein skaliertes Dokument öffnen – Text sollte scharf und in korrekter Größe stehen.

## Aufgaben

- [ ] Monitor-Skalierung ermitteln: `hyprctl monitors | find scale`
- [ ] `xwayland:force_zero_scaling` in `hyprland.lua` setzen (Lua-Syntax validieren) und `hyprctl reload`
- [ ] OnlyOffice-Skalierung passend setzen (Weg A **oder** B)
- [ ] fontconfig-Datei anlegen und `fc-cache -f`
- [ ] Metrik-kompatible Schriften installieren
- [ ] `fc-match`/`fc-list` gegenprüfen und in OnlyOffice visuell kontrollieren
- [ ] Falls ganzzahlige Skalierung (2,0): prüfen, ob `force_zero_scaling` überhaupt nötig ist

## Verwandte Notizen

- [[OnlyOffice installieren]]
- [[Obsidian unter Hyprland – Wayland erzwingen]]  <!-- ggf. Dateinamen anpassen -->
- [[Hyprland Lua-Konfiguration]]  <!-- ggf. Dateinamen anpassen -->
- [[Qt-Kvantum-Theming einrichten]]  <!-- ggf. Dateinamen anpassen -->
