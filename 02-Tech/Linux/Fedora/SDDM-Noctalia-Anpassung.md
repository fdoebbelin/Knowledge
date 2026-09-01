---
title: SDDM Login an Hyprland & Noctalia anpassen
aliases:
  - SDDM Noctalia Theme
  - Login-Screen Anpassung
tags:
  - linux
  - cachyos
  - hyprland
  - noctalia
  - sddm
  - theming
created: 2026-07-07
cssclasses:
  - guide
---

# SDDM Login an Hyprland & Noctalia anpassen

> [!abstract] Ziel
> Den SDDM-Login-Screen optisch an [[Noctalia]] und [[Hyprland]] angleichen und den fehlenden Mauszeiger unter Wayland aktivieren. Als Cursor kommt **Bibata-Modern-Ice** zum Einsatz.

> [!info] Voraussetzungen
> - CachyOS mit Hyprland + Noctalia
> - SDDM mit **Qt6** kompiliert (auf aktuellem CachyOS gegeben)
> - AUR-Helper (`paru`, `yay` o. Ä.)

---

## 1 · Bibata-Modern-Ice installieren

Bibata ist ein material-basiertes Cursor-Theme. `Modern-Ice` ist die weiße Variante, die zum dunklen Noctalia-Look passt.

> [!tip] Prebuilt vs. Source
> `-bin` liefert vorkompilierte Cursor und ist deutlich schneller. Ohne `-bin` wird lokal aus SVGs gebaut (dauert, braucht `yarn`/`ctgen`).

```bash
# Empfohlen: vorgebaute Binaries
paru -S bibata-cursor-theme-bin

# Alternativ aus Quelle
# paru -S bibata-cursor-theme
```

Nach der Installation liegt das Theme system­weit bereit. Prüfen:

```bash
ls /usr/share/icons/Bibata-Modern-Ice/cursors/ 2>/dev/null && echo OK
```

> [!note] Verfügbare Varianten
> `Bibata-Modern-Ice` (weiß) · `Bibata-Modern-Classic` (schwarz) · `Bibata-Original-Ice` · `Bibata-Original-Classic`. Für den hellen Zeiger auf dunklem Grund ist **Modern-Ice** die richtige Wahl.

Damit Login-, Lock- und Desktop-Cursor identisch sind, denselben Namen auch in Hyprland setzen (z. B. in deinem `hypr.nu`-Modul):

```bash
hyprctl setcursor Bibata-Modern-Ice 24
```

---

## 2 · Noctalia-SDDM-Theme installieren

Statt ein generisches Theme nachzubauen, nutzt du das am Noctalia-Lockscreen orientierte `sddm-noctalia-theme`.

```bash
git clone https://github.com/ClementFombonne/sddm-noctalia-theme.git
cd sddm-noctalia-theme
sudo ./install.sh
```

> [!warning] Konkurrierende Configs
> CachyOS legt teils eigene Dateien unter `/etc/sddm.conf.d/` an. Es darf nur **ein** aktives `Current=` geben — alle anderen auskommentieren.

Theme aktivieren in `/etc/sddm.conf.d/theme.conf`:

```ini
[Theme]
Current=sddm-noctalia-theme
```

---

## 3 · Theme an Noctalia angleichen

Alle Optik-Optionen liegen in:

```
/usr/share/sddm/themes/sddm-noctalia-theme/Commons/Settings.conf
```

```ini
background=/home/fritz/Bilder/wallpaper/noctalia.png
fontFamily="JetBrains Mono"
colorScheme=Noctalia-default   # als Basis; Tokyo-Night, Catppuccin, Nord … möglich
darkMode=true
clockStyle="digital"
radiusRatio=1.0                # Container-Rundung an Noctalia angleichen
iRadiusRatio=1.0               # Rundung Eingabefelder/Buttons
scaleRatio=1.0                 # globaler UI-Skalierungsfaktor
```

> [!tip] Konsistenz mit Noctalia
> Dasselbe Wallpaper wie im Noctalia-Lockscreen verwenden und die `radiusRatio`-Werte an deine Panel-Rundungen anpassen — dann verschmelzen Login und Lockscreen optisch.

> [!note] Mitgelieferte Schemata
> Ayu · Catppuccin · Dracula · Eldritch · Gruvbox · Kanagawa · Noctalia-default · Nord · Rosepine · Tokyo-Night

---

## 4 · Maus aktivieren (Cursor-Fix)

Der fehlende Zeiger kommt fast immer daher, dass SDDM den Greeter unter **Wayland** startet und dabei kein Cursor-Theme rendert.

### 4.1 · Cursor-Theme explizit setzen

`/etc/sddm.conf.d/cursor.conf`:

```ini
[Theme]
CursorTheme=Bibata-Modern-Ice
CursorSize=24
```

### 4.2 · Prüfen: X11- oder Wayland-Greeter?

```bash
grep -r "DisplayServer" /etc/sddm.conf /etc/sddm.conf.d/ \
  /usr/lib/sddm/sddm.conf.d/ 2>/dev/null
```

> [!question] Ergebnis `DisplayServer=wayland`?
> Dann zusätzlich einen der beiden Wege gehen:

**Variante A — beim Wayland-Greeter bleiben** und Cursor über die Umgebung durchreichen:

```ini
[General]
GreeterEnvironment=XCURSOR_THEME=Bibata-Modern-Ice,XCURSOR_SIZE=24
```

**Variante B — testweise auf X11 zurück**, wo der Cursor zuverlässig gezeichnet wird:

```ini
[General]
DisplayServer=x11
```

---

## 5 · Anwenden & prüfen

> [!danger] Session-Verlust
> `systemctl restart sddm` beendet deine laufende Session sofort. Vorher alles speichern.

```bash
sudo systemctl restart sddm
```

Falls der Cursor weiterhin fehlt, direkt nach dem Restart ins Log schauen:

```bash
journalctl -u sddm -b 0 --no-pager | grep -iE "cursor|wayland|greeter"
```

---

## Checkliste

- [ ] `bibata-cursor-theme-bin` installiert, `/usr/share/icons/Bibata-Modern-Ice/` vorhanden
- [ ] `sddm-noctalia-theme` installiert & in `theme.conf` aktiviert
- [ ] Keine konkurrierende `Current=`-Zeile
- [ ] `Settings.conf`: Wallpaper, Font, Farbschema, Radius angepasst
- [ ] `cursor.conf` mit `CursorTheme` + `CursorSize`
- [ ] Bei Wayland-Greeter: `GreeterEnvironment` **oder** `DisplayServer=x11`
- [ ] SDDM neugestartet, Cursor sichtbar

---

> [!success] Ergebnis
> Login-Screen im Noctalia-Look mit identischem Bibata-Cursor über Login, Lock und Desktop hinweg.

## Siehe auch

- [[Hyprland Konfiguration]]
- [[Noctalia Shell]]
- [[CachyOS Setup]]
