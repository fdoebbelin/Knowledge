---
titel: Akkustatus anzeigen
tags:
  - hyprland
  - nushell
  - hardware
  - akku
erstellt: 2026-06-29
system: Fedora 44 / Hyprland / Lenovo Yoga
status: fertig
---

# Akkustatus anzeigen

Akkustand und Ladezustand auslesen – **ohne zusätzliche Pakete** und **ohne Statusleiste**. Nützlich im Zustand vor [[Noctalia Shell]], wenn noch kein Bar- oder Notification-Daemon läuft.

> [!info] Prinzip
> Der Akku liegt vollständig im sysfs unter `/sys/class/power_supply/`. Für eine Einblendung *in* Hyprland reicht der eingebaute Dispatcher `hyprctl notify` – der braucht **keinen** Notification-Daemon (mako/swaync).

> [!note] Akku-Pfad auf diesem Gerät
> Das Lenovo Yoga meldet den Akku als **`BAT1`**. Prüfen lässt sich das jederzeit mit:
> ```nu
> ls /sys/class/power_supply/
> ```

## Methode 1 – Direkt aus sysfs

Schneller Blick im Terminal:

```nu
open /sys/class/power_supply/BAT1/capacity | str trim | into int
open /sys/class/power_supply/BAT1/status | str trim
```

`status` liefert `Charging`, `Discharging`, `Full` oder `Not charging`.

## Methode 2 – Wiederverwendbare nushell-Funktion

In die `config.nu` aufnehmen. Der Akku wird per Glob dynamisch gefunden – damit funktioniert die Funktion auch, falls sich der Name später ändert.

```nu
def akku [] {
    let pfad = (ls /sys/class/power_supply/BAT* | first | get name)
    {
        prozent: (open $"($pfad)/capacity" | str trim | into int)
        status: (open $"($pfad)/status" | str trim)
    }
}
```

> [!example] Aufruf
> ```nu
> akku
> # ╭─────────┬─────────────╮
> # │ prozent │ 73          │
> # │ status  │ Discharging │
> # ╰─────────┴─────────────╯
> ```

> [!tip] Warum `BAT*` statt `BAT1`?
> Der Glob `BAT*` löst auf diesem Gerät automatisch auf `BAT1` auf, übersteht aber einen Hardware- oder Kernel-bedingten Namenswechsel ohne Anpassung.

## Methode 3 – Tastenkürzel in Hyprland

On-Screen-Einblendung über `hyprctl notify`, ausgelöst per Keybind. Die gesamte Logik bleibt in nushell, der Lua-Keybind ruft nur das Skript auf.

### Skript `~/.config/hypr/scripts/akku.nu`

```nu
#!/usr/bin/env nu

let pfad = (ls /sys/class/power_supply/BAT* | first | get name)
let prozent = (open $"($pfad)/capacity" | str trim | into int)
let status = (open $"($pfad)/status" | str trim)

let status_de = match $status {
    "Charging" => "lädt",
    "Discharging" => "entlädt",
    "Full" => "voll",
    "Not charging" => "lädt nicht",
    _ => $status
}

# Farben passend zum Solarized-Theme
let farbe = if $prozent <= 20 {
    "rgb(dc322f)"   # Rot
} else if $prozent <= 50 {
    "rgb(b58900)"   # Gelb
} else {
    "rgb(859900)"   # Grün
}

hyprctl notify -1 5000 $farbe $"Akku: ($prozent)% – ($status_de)"
```

Ausführbar machen:

```nu
chmod +x ~/.config/hypr/scripts/akku.nu
```

### Keybind in `hyprland.lua`

```lua
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("nu ~/.config/hypr/scripts/akku.nu"))

```

Danach neu laden:

```nu
hyprctl reload
```

`SUPER + A` zeigt jetzt den Akkustand als farbige Einblendung.

> [!warning] `exec_cmd` läuft über `/bin/sh`
> Der Dispatcher `hl.dsp.exec_cmd(...)` startet den Befehl über `/bin/sh`, **nicht** über nushell. Deshalb wird hier nur das Skript aufgerufen (`nu …`) – die nushell-Logik steckt komplett im `.nu`-Skript. Direkte nushell-Interpolation in der Keybind-Zeile würde nicht funktionieren.

> [!note] Argumente von `hyprctl notify`
> Reihenfolge: `<ICON> <DAUER_MS> <FARBE> <TEXT>`. `-1` bedeutet „kein Icon“. Farbe als `rgb(RRGGBB)`.

## Alternativen (mit Paketen)

Nur falls ein fertiges Tool gewünscht ist – für den minimalistischen Pre-Noctalia-Zustand ist der sysfs-Weg vorzuziehen, da paketfrei.

```nu
# upower (meist bereits installiert)
upower -i /org/freedesktop/UPower/devices/battery_BAT1

# acpi (vorher: dnf install acpi)
acpi -b
```

## Erledigt

- [x] Akku-Pfad bestätigt (`BAT1`)
- [x] nushell-Funktion `akku` in `config.nu`
- [x] Skript `~/.config/hypr/scripts/akku.nu` angelegt und ausführbar gemacht
- [x] Keybind `SUPER + A` in `hyprland.lua` eingetragen
- [ ] Später ersetzbar durch native Akku-Anzeige in [[Noctalia Shell]]

## Verwandte Notizen

- [[Hyprland Konfiguration]]
- [[02-nushell-konfigurieren]]
- [[Noctalia Shell]]
