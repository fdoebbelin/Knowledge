---
title: Bildschirmrotation mit iio-hyprland
tags: [hyprland, rotation, iio, convertible, yoga, fedora]
created: 2026-06-30
system: Fedora 44 · Hyprland 0.55+ · Lenovo Yoga 920-13IKB
status: Entwurf
---

> [!info] Ziel & Kette
> Automatische Display- **und** Touch-Rotation beim Drehen des Convertibles. Signalkette: Beschleunigungssensor → `iio-sensor-proxy` (D-Bus) → `iio-hyprland` → `hyprctl keyword … transform`.

## Schritt 1 – iio-sensor-proxy

```nu
sudo dnf install -y iio-sensor-proxy
```

Der Dienst ist D-Bus-aktiviert, kein manuelles `enable` nötig. Sensor prüfen und live beobachten:

```nu
ls /sys/bus/iio/devices/ | get name
```

```nu
monitor-sensor   # blockiert; mit Strg+C beenden
```

> [!check] Beim Kippen sollte erscheinen: `Accelerometer orientation changed: normal | left-up | right-up | bottom-up`. Wenn ja, läuft der Sensor.

## Schritt 2 – iio-hyprland bauen

> [!warning] Nicht in den Fedora-Repos
> Vorher prüfen: `dnf search iio-hyprland` (evtl. in `solopasha/hyprland`). Andernfalls aus Quelle:

```nu
sudo dnf install -y git make gcc-c++
git clone https://github.com/JeanSchoeller/iio-hyprland
cd iio-hyprland
sudo make install
```

## Schritt 3 – Autostart in hyprland.lua

An derselben Stelle starten, an der du auch Noctalia startest:

```lua
-- im Autostart-Block, analog zu Noctalia
hl.exec_once("iio-hyprland eDP-1")
```

> [!warning] Autostart-Notation
> Der Funktionsname (`hl.exec_once`) ist hier exemplarisch – verwende dieselbe Autostart-Form wie für Noctalia in deiner Config. Das Tool ruft intern `hyprctl` auf, ist also config-format-unabhängig.

Argumente: zweites Positional = zu rotierender Monitor (Default `eDP-1`). Optional `--left-master` / `--right-master`, um bei Rotation auch die Master-Fensterposition mitzudrehen; weglassen = Layout bleibt. **Touch dreht automatisch mit** – `iio-hyprland` setzt `device:touchdevice:transform` für alle Touch-Geräte ohne eigene Vorgabe.

## Schritt 4 – Transform-Mapping (nur falls nötig)

Standard `0,1,2,3` = (Normal, LeftUp, BottomUp, RightUp). Auf dem Yoga 920 (Standard-Convertible, kein Sonderfall wie GPD) sollte das direkt passen. Falls Hoch-/Querformat oder Richtung verdreht ist:

```lua
hl.exec_once("iio-hyprland --transform 0,1,2,3 eDP-1")
```

Hyprland-`transform`-Werte:

| Wert | Wirkung |
|---|---|
| 0 | normal |
| 1 | 90° |
| 2 | 180° |
| 3 | 270° |
| 4–7 | gespiegelt (+ 0/90/180/270°) |

> [!warning] Tablet-Fold ≠ Deckel zu
> Beim Umklappen in den Tablet-Modus kann der Hall-Sensor ein „Deckel zu" auslösen → ungewollter Suspend. Maskierung in [[Deckel und Suspend konfigurieren]].

> [!tip] Manueller Fallback ohne Sensor
> Falls du Rotation lieber gezielt auslöst:
>
> ```lua
> hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl keyword monitor eDP-1,preferred,auto,1.5,transform,3"))
> ```
>
> (`exec_cmd` läuft über `/bin/sh`, nicht Nushell – daher POSIX. `SUPER+R` ist als Emergency-Run-Bind reserviert, deshalb `SUPER+SHIFT+R`.)

## Verifikation

```nu
hyprctl monitors all -j | from json | where name == "eDP-1" | get transform
```

## Aufgaben

- [ ] `iio-sensor-proxy` installiert, `monitor-sensor` meldet Orientierungen
- [ ] `iio-hyprland` gebaut/installiert
- [ ] Autostart-Zeile in `hyprland.lua` (analog Noctalia)
- [ ] Drehen testen: Display **und** Touch rotieren
- [ ] ggf. `--transform` angepasst
- [ ] Tablet-Fold löst keinen Suspend aus ([[Deckel und Suspend konfigurieren]])

---

Verwandt: [[Mehrere Bildschirme verwalten]] · [[Hyprland Konfiguration]] · [[Deckel und Suspend konfigurieren]]
