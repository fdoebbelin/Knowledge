---
title: SDDM Login an Hyprland & Noctalia anpassen (Fedora)
aliases:
  - SDDM Noctalia Theme Fedora
  - Login-Screen Anpassung Fedora
tags:
  - linux
  - fedora
  - hyprland
  - noctalia
  - sddm
  - theming
created: 2026-07-07
cssclasses:
  - guide
---

# SDDM Login an Hyprland & Noctalia anpassen (Fedora)

> [!abstract] Ziel
> Den SDDM-Login-Screen optisch an [[Noctalia]] und [[Hyprland]] angleichen und den fehlenden Mauszeiger unter Wayland aktivieren. Als Cursor kommt **Bibata-Modern-Ice** zum Einsatz. Fedora-Variante mit COPR.

> [!info] Voraussetzungen
> - Fedora mit Hyprland + Noctalia
> - SDDM als Display-Manager, mit **Qt6** (auf Fedora ≥ 40 gegeben)
> - `sudo`-Rechte; COPR-Repos erlaubt

---

## 1 · Bibata-Modern-Ice installieren

Bibata ist ein material-basiertes Cursor-Theme. `Modern-Ice` ist die weiße Variante, die zum dunklen Noctalia-Look passt.

### Variante A — COPR (empfohlen)

Vom Bibata-Maintainer empfohlenes COPR von `peterwu`. Enthält modern- und classic-Flavours:

```bash
sudo dnf copr enable peterwu/rendezvous
sudo dnf install bibata-cursor-themes
```

Die Cursor landen system­weit unter `/usr/share/icons/Bibata-...`.

### Variante B — Tarball vom GitHub-Release

Distro-unabhängige Alternative, falls du kein COPR aktivieren willst — das aktuelle `Bibata.tar.xz` von der [Releases-Seite](https://github.com/ful1e5/Bibata_Cursor/releases) laden, dann:

```bash
tar -xvf Bibata.tar.xz
sudo mv Bibata-* /usr/share/icons/     # systemweit
# oder: mv Bibata-* ~/.local/share/icons/   # nur für deinen User
```

> [!tip] Prüfen
> ```bash
> ls /usr/share/icons/Bibata-Modern-Ice/cursors/ 2>/dev/null && echo OK
> ```

> [!note] Verfügbare Varianten
> `Bibata-Modern-Ice` (weiß) · `Bibata-Modern-Classic` (schwarz) · `Bibata-Original-Ice` · `Bibata-Original-Classic` u. a. Für den hellen Zeiger auf dunklem Grund ist **Modern-Ice** die richtige Wahl.

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

> [!warning] SELinux-Kontext (Fedora-spezifisch)
> Manuell nach `/usr/share/sddm/themes/` kopierte Dateien können falsche SELinux-Labels haben. Falls das Theme nicht lädt, Kontext neu setzen:
> ```bash
> sudo restorecon -Rv /usr/share/sddm/themes/
> ```

> [!warning] Konkurrierende Configs
> Es darf nur **ein** aktives `Current=` geben — andere Einträge unter `/etc/sddm.conf.d/` auskommentieren.

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

- [ ] COPR `peterwu/rendezvous` aktiviert **oder** Tarball entpackt; `/usr/share/icons/Bibata-Modern-Ice/` vorhanden
- [ ] `sddm-noctalia-theme` installiert & in `theme.conf` aktiviert
- [ ] `restorecon` gelaufen (falls Theme nicht lud)
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
- [[Fedora Setup]]
- [[SDDM Noctalia Theme]] (CachyOS-Variante)
