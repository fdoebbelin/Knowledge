---
title: Mehrere Bildschirme verwalten
tags: [hyprland, monitore, multimonitor, lua, fedora]
created: 2026-06-30
system: Fedora 44 · Hyprland 0.55+ · Lua-Config
status: draft
---

> [!info] Grundprinzip
> Seit Hyprland 0.55 werden Monitore über `hl.monitor{}` in der `hyprland.lua` definiert. Jeder Schirm bekommt eine Position im virtuellen Layout (Pixel, Ursprung oben-links, **inverse Y-Achse**: negatives Y = höher). `nwg-displays` dient nur als Ablese-Helfer – es schreibt klassische Syntax, nicht Lua.

## Outputs ermitteln

```nu
hyprctl monitors all -j | from json | select name description width height refreshRate scale transform
```

`hyprctl -j` liefert JSON – damit lässt sich das in Nushell direkt als Tabelle weiterverarbeiten.

## Layout definieren

```lua
-- Internes Yoga-Panel
hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1.5 })

-- Externer Schirm rechts daneben
hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "auto-right", scale = 1 })

-- Fallback für alles Unbekannte (Hotplug)
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
```

`position` akzeptiert exakte Koordinaten (`"1920x0"`) oder `auto` / `auto-right|left|up|down` / `auto-center-*`.

> [!tip] Stabile Zuordnung über `desc:`
> Port-Namen (`DP-1` …) können je nach Anschluss wechseln. Robuster ist die Beschreibung – den `(Portname)`-Suffix dabei entfernen:
>
> ```lua
> hl.monitor({ output = "desc:Dell Inc. DELL U2720Q", mode = "3840x2160@60", position = "auto-right", scale = 2 })
> ```

## Vor dem Festschreiben live testen

`hyprctl keyword` nutzt die klassische Syntax und ist formatunabhängig – ideal zum Ausprobieren, bevor du es in Lua gießt:

```nu
hyprctl keyword monitor "DP-1,1920x1080@60,1920x0,1"
```

## Internen Schirm deaktivieren (z. B. zugeklappt am Dock)

```lua
hl.monitor({ output = "eDP-1", disabled = true })
```

> [!warning] Key prüfen
> `disabled = true` ist die erwartete Lua-Form, aber 0.55 ist jung – gegen die [Monitors-Wiki-Seite](https://wiki.hypr.land/Configuring/Basics/Monitors/) gegenchecken. Geht es nur ums Zuklappen am Dock, ist das Deckel-Verhalten ohnehin in [[Deckel und Suspend konfigurieren]] sauberer gelöst.

> [!warning] Skalierung
> `scale` muss ganzzahlige Pixelmaße ergeben, sonst lehnt Hyprland die Regel ab. Sichere Werte: `1`, `1.5`, `2` oder `"auto"`. UHD-Panel des Yoga: `2` oder `1.5`; FHD-Variante: `1`.

## nwg-displays als Helfer

GUI zum Anordnen/Ablesen von Position, `scale` und `transform`. **Schreibt klassische `monitor=`-Syntax** → Werte ablesen und von Hand in die `hyprland.lua` übertragen, nicht sourcen. Installation siehe [[Grafische Systemeinstellungen unter Hyprland (KDE-Plasma-Äquivalente)]].

## Verifikation

```nu
hyprctl monitors all -j | from json | each {|m| {
    name: $m.name,
    aktiv: (not ($m.disabled? | default false)),
    aufloesung: $"($m.width)x($m.height)@($m.refreshRate)",
    scale: $m.scale,
    transform: $m.transform
} }
```

## Aufgaben

- [ ] Outputs ermittelt (Port + `desc:`)
- [ ] Layout live mit `hyprctl keyword` getestet
- [ ] `hl.monitor`-Regeln in `hyprland.lua` übertragen
- [ ] Fallback-Regel für Hotplug gesetzt
- [ ] Noctalia-Bar erscheint auf allen Schirmen (folgt der Output-Geometrie automatisch)

---

Verwandt: [[Bildschirmrotation mit iio-hyprland]] · [[Hyprland Konfiguration]] · [[Deckel und Suspend konfigurieren]] · [[02-nushell-konfigurieren]] · [[2026-09-23 Monitoranordnung unter Sway konfigurieren]] (dasselbe Thema unter Sway statt Hyprland, inkl. `kanshi` für wechselnde Profile)
