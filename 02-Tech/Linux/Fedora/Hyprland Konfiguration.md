---
title: Hyprland Konfiguration
tags: [hyprland, lua, wayland, fedora, konfiguration]
created: 2026-06-29
system: Fedora 44 / Hyprland
status: entwurf
---

# Hyprland Konfiguration

Zentrale Konfigurationsnotiz für Hyprland ab **0.55** im neuen **Lua**-Format. Die Datei liegt unter `~/.config/hypr/hyprland.lua` und wird beim Speichern automatisch neu geladen. Eingebettet sind die Anbindungen an [[Noctalia Shell installieren]] (Autostart, Launcher-Bind, Blur-Layerrule).

> [!info] Lua statt hyprlang
> Seit 0.55 ist hyprlang abgelöst. Existiert eine `hyprland.lua`, wird ausschließlich diese geladen (kein Fallback auf `hyprland.conf`). Konfiguriert wird über die globale `hl`-Tabelle: `hl.config({…})`, `hl.bind(…)`, `hl.monitor({…})` usw.

## Voraussetzungen

- [x] Hyprland ≥ 0.55 (COPR `solopasha/hyprland`)
- [x] Kitty, Dolphin, Vivaldi installiert
- [x] Noctalia → siehe [[Noctalia Shell installieren]]
- [ ] `hyprland.lua` produktiv (diese Notiz)

## Vollständige `hyprland.lua`

```lua
-- ~/.config/hypr/hyprland.lua
-- Hyprland 0.55 (Lua). Wiki: https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORE ----
------------------
-- Internes Display des Yoga. Outputs per `hyprctl monitors` ermitteln.
hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1 })
-- Externer Schirm (beim Docking), automatisch rechts daneben:
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local fileManager = "dolphin"
local browser     = "vivaldi"
-- Launcher kommt von Noctalia (per IPC), kein separater Menü-Prozess:
local menu        = "qs -c noctalia-shell ipc call launcher toggle"

-------------------
---- AUTOSTART ----
-------------------
-- Nur beim echten Start feuern -> keine Doppelstarts bei Reload.
hl.on("hyprland.start", function()
  -- Desktop-Shell (Bar, Notifications, Lockscreen, Wallpaper, Dock)
  hl.exec_cmd("qs -c noctalia-shell")
  -- Polkit-Agent (für Dolphin-Rechteabfragen) -> siehe [[Dolphin einrichten]]
  hl.exec_cmd("/usr/libexec/polkit-kde-authentication-agent-1")
  -- Zwischenablage-Verlauf (von Noctalia angezeigt)
  hl.exec_cmd("wl-paste --watch cliphist store")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
  general = {
    gaps_in     = 5,
    gaps_out    = 10,
    border_size = 2,
    col = {
      active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
    resize_on_border = true,
    allow_tearing    = false,
    layout           = "dwindle",
  },
  decoration = {
    rounding       = 10,
    rounding_power = 2,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    shadow = { enabled = true, range = 4, render_power = 3, color = 0xee1a1a1a },
    blur   = { enabled = true, size = 3, passes = 2, vibrancy = 0.1696 },
  },
  animations = { enabled = true },
  dwindle    = { preserve_split = true },
  misc       = { force_default_wallpaper = 0, disable_hyprland_logo = true },
})

-- Bezier-Kurven + Animationen (Hyprland-Defaults)
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 4.79, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "border",     enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "fade",       enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

---------------
---- INPUT ----
---------------
hl.config({
  input = {
    kb_layout    = "de",   -- ggf. auf "us" anpassen
    follow_mouse = 1,
    sensitivity  = 0,
    touchpad = {
      natural_scroll       = true,
      disable_while_typing = true,
    },
  },
})

-- 3-Finger-Wisch wechselt Workspaces (praktisch am Yoga)
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))               -- Noctalia-Launcher
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))         -- nur dwindle
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call sessionMenu toggle"))

-- Fokus per Pfeiltasten
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces 1-10 wechseln / aktives Fenster verschieben
for i = 1, 10 do
  local key = i % 10  -- 10 -> Taste 0
  hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Workspaces per Mausrad
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Fenster mit Maus verschieben/skalieren
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia-Tasten (PipeWire/WirePlumber + brightnessctl)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                    { locked = true, repeating = true })

-- Lid-Switch (Name per `hyprctl devices` ermitteln, dann einkommentieren):
-- hl.bind("switch:on:[switch name]",  hl.dsp.exec_cmd("qs -c noctalia-shell ipc call lockScreen lock"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- Maximize-Events unterdrücken
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })

-- XWayland-Drag-Fix
hl.window_rule({
  name = "fix-xwayland-drags",
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
})

-- Blur gezielt für die Noctalia-Layer -> siehe [[Noctalia Shell installieren]]
hl.layer_rule({
  name = "noctalia-blur",
  match = { namespace = "noctalia-background-.*$" },
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})
```

## Erläuterungen

### exec_cmd läuft über `/bin/sh`

> [!warning] Kein nushell in exec-Strings
> Strings in `hl.exec_cmd(…)` werden von **`/bin/sh`** ausgewertet, **nicht** von nushell. Also POSIX-Syntax verwenden: `$(...)`, `&&`, `||`, `>/dev/null`. Nushell-Konstrukte wie `$env.FOO` oder Pipelines im nushell-Stil funktionieren hier **nicht**.

### Monitore & Bildschirmrotation

Der erste `hl.monitor`-Eintrag setzt das interne `eDP-1`, der zweite fängt einen beliebigen externen Output beim Docking ab. Manuelle Rotation über `transform` (1 = 90°, 2 = 180°, 3 = 270°):

```lua
hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1, transform = 1 })
```

> [!tip] Auto-Rotation (Tablet-Modus)
> Hyprland rotiert **nicht** automatisch. Dafür liest ein Helfer die Sensordaten von `iio-sensor-proxy` und ruft bei Lageänderung `hyprctl keyword monitor …` mit passendem `transform`. Das gehört in eine eigene Notiz `[[Yoga Bildschirmrotation]]`, nicht in die `hyprland.lua`.

### Eingabe / Touchpad

> [!warning] Touchpad-Unterschlüssel verifizieren
> Bestätigt ist `natural_scroll`. Weitere Felder (`disable_while_typing`, ggf. `tap_to_click`) mappen aus der hyprlang-Schreibweise; bei einem Typfehler-Popup per LSP gegen die Stubs prüfen. Siehe LSP-Tipp unten.

### Autostart

Bewusst schlank: Noctalia übernimmt Bar, Notifications, Lockscreen, Idle und Wallpaper — daher **kein** Waybar/mako/swww/hypridle/hyprlock im Autostart. Ergänzt sind nur Polkit-Agent (für Dolphin) und der Clipboard-Watcher.

> [!tip] Polkit-Pfad prüfen
> Der KDE-Polkit-Agent liegt auf Fedora i. d. R. unter `/usr/libexec/polkit-kde-authentication-agent-1`. Pfad gegenprüfen:
> ```nu
> ls /usr/libexec/ | where name =~ polkit
> ```

## Validierung (nushell)

```nu
# Backup vor jeder größeren Änderung
cp ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.bak

# Speichern lädt automatisch; manuell:
hyprctl reload

# Kontrolle
hyprctl version
hyprctl monitors
hyprctl devices   # Switch-/Geräte-Namen (Lid, Touchpad)
```

> [!check] Fehlerverhalten
> Lua-Syntaxfehler **vor** deinen Binds verhindern, dass diese laden. Hyprland blendet dann Notfall-Binds ein: `SUPER+Q` (Terminal), `SUPER+R` (Run), `SUPER+M` (Exit).

## LSP für Autovervollständigung & Typprüfung

> [!tip] lua-language-server einrichten
> Hyprland liefert Stubs (meist `/usr/share/hypr/stubs/`). Eine `~/.config/hypr/.luarc.json` anlegen, damit das globale `hl` und die Typen erkannt werden — das beseitigt die oben markierten Feldnamen-Unsicherheiten:
> ```json
> {
>   "workspace": { "library": ["/usr/share/hypr/stubs"] },
>   "diagnostics": { "globals": ["hl"] }
> }
> ```

## Nächste Schritte

- [ ] Konfig wächst → in Module aufteilen via `require("module")` (z. B. `binds.lua`, `rules.lua`, `monitors.lua`)
- [ ] `[[Yoga Bildschirmrotation]]` anlegen (iio-sensor-proxy + hyprctl-Helfer)
- [ ] Lid-Switch-Bind nach `hyprctl devices` aktivieren
- [ ] Querverweis in [[Noctalia Shell installieren]] auf diese Notiz prüfen
