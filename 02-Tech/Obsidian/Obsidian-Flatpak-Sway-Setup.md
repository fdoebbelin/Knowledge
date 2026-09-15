# Obsidian (Flatpak) unter Fedora Sway Atomic – Floating & natives Wayland

> **System:** Fedora Sway Atomic, Obsidian 1.13.7 als Flatpak (`md.obsidian.Obsidian`)
> **Ziel:** Alle Obsidian-Fenster öffnen automatisch als Floating-Fenster; Obsidian läuft nativ auf Wayland statt über XWayland
> **Status:** Verifiziert – `app_id: "obsidian"` unter nativem Wayland

---

## Überblick

Zwei getrennte Baustellen, die zusammenspielen:

1. **Sway-Regel** – legt fest, dass Obsidian-Fenster floating öffnen. Die Regel greift über einen Fenster-Identifier.
2. **Flatpak-Overrides** – sorgen dafür, dass Obsidian nativ auf Wayland läuft. Das ändert den Identifier von `class` (XWayland) zu `app_id` (Wayland).

Punkt 2 ist optional – die Floating-Regel funktioniert unter XWayland genauso. Nativer Wayland-Betrieb bringt schärfere Darstellung bei HiDPI und sauberes Fractional Scaling.

**Wichtig zur Reihenfolge:** Erst Wayland umstellen, dann Identifier prüfen, dann die Sway-Regel schreiben. Andernfalls zeigt der Fenster-Baum den falschen Identifier.

---

## Teil 1: Flatpak-Overrides (natives Wayland)

Alle Overrides sind persistent und gelten auch für den Start über das Anwendungsmenü.

### 1.1 Wayland-Socket freigeben

Ohne diesen Socket findet Electron in der Sandbox kein Wayland-Display:

```bash
flatpak override --user --socket=wayland md.obsidian.Obsidian
```

### 1.2 Wayland-Modus aktivieren

```bash
flatpak override --user \
  --env=ELECTRON_OZONE_PLATFORM_HINT=auto \
  md.obsidian.Obsidian
```

> **Warum `auto` und nicht `wayland`?** `auto` erkennt die Session selbst und fällt sauber auf X11 zurück, falls die Wayland-Session mal nicht verfügbar ist. Ein hartes `--ozone-platform=wayland` bringt Electron in dem Fall zum Absturz, bevor überhaupt ein Fenster entsteht – der Prozess verschwindet dann kommentarlos.

### 1.3 Vault-Pfad freigeben (falls nötig)

Die Sandbox sieht standardmäßig nur `~/.var/app/md.obsidian.Obsidian/`. Liegt der Vault woanders:

```bash
flatpak override --user --filesystem=/pfad/zu/den/Vaults md.obsidian.Obsidian
```

### 1.4 Overrides prüfen

```bash
flatpak info --show-permissions md.obsidian.Obsidian
```

Erwartet: `wayland` unter `[Context] sockets`, `ELECTRON_OZONE_PLATFORM_HINT=auto` unter `[Environment]`.

---

## Teil 2: Identifier ermitteln

Obsidian starten, dann bei laufendem Fenster:

```bash
swaymsg -t get_tree | grep -iE '"(app_id|class)":.*[Oo]bsidian'
```

| Ausgabe | Bedeutung |
|---|---|
| `"app_id": "obsidian"` | Natives Wayland – Overrides greifen |
| `"class": "obsidian"` | XWayland – Overrides greifen (noch) nicht |
| gar nichts | Kein Fenster vorhanden → siehe Troubleshooting |

> **Nicht auf `name`/`title` filtern.** Ein Browser-Tab mit „Obsidian" im Titel würde bei einer Titel-Regel mitfliegen und ebenfalls floating öffnen.

---

## Teil 3: Sway-Regel einrichten

### 3.1 Eigene Konfiguration anlegen

Auf einem atomaren System bleibt `/etc/sway/` unangetastet. Stattdessen eine eigene Konfiguration, die die Systemkonfig einbindet – falls `~/.config/sway/config` noch nicht existiert:

```bash
mkdir -p ~/.config/sway/config.d
printf 'include /etc/sway/config\ninclude ~/.config/sway/config.d/*\n' > ~/.config/sway/config
```

### 3.2 Floating-Regel als Drop-in

```bash
cat > ~/.config/sway/config.d/50-obsidian-floating.conf <<'EOF'
for_window [app_id="obsidian"] floating enable
for_window [class="obsidian"] floating enable
EOF
```

Beide Zeilen bewusst drin: `app_id` greift unter nativem Wayland, `class` als Fallback unter XWayland. So bleibt die Konfiguration robust, falls die Overrides mal nicht ziehen.

**Optional mit Größe und Position:**

```
for_window [app_id="obsidian"] floating enable, resize set 1400 900, move position center
```

### 3.3 Aktivieren

```bash
swaymsg reload
```

`for_window` erfasst nur **neu geöffnete** Fenster. Obsidian einmal komplett schließen und neu starten – oder ein bestehendes Fenster mit `Mod+Shift+Space` manuell umschalten.

---

## Teil 4: Verifikation

1. Abmelden und neu anmelden
2. Obsidian über das Anwendungsmenü starten (nicht über die Kommandozeile – nur so wird geprüft, ob die Overrides wirklich persistent greifen)
3. Fenster sollte floating aufgehen
4. Gegenprobe:

```bash
swaymsg -t get_tree | grep -iE '"(app_id|class)":.*[Oo]bsidian'
```

Erwartet: `"app_id": "obsidian"`

---

## Troubleshooting

| Symptom | Ursache / Lösung |
|---|---|
| `obsidian: The CLI is unable to find Obsidian` | `obsidian` im PATH ist das separate CLI-Tool, nicht die App. Start über `flatpak run md.obsidian.Obsidian` |
| Kein Fenster im Tree, keine Fehlermeldung | Vermutlich Absturz vor Fenstererstellung. Erst `flatpak ps` und `pgrep -af obsidian` prüfen, ggf. `flatpak kill md.obsidian.Obsidian`, dann ohne Flags gegentesten |
| Start scheitert nur mit `--ozone-platform=wayland` | Wayland-Socket fehlt → Teil 1.1. Grundsätzlich `ELECTRON_OZONE_PLATFORM_HINT=auto` bevorzugen |
| Regel greift nicht | Identifier stimmt nicht (Teil 2) oder Fenster lief schon vor `swaymsg reload` – Obsidian neu starten |
| Nach Login wieder `class` statt `app_id` | Env-Override greift nicht. Testweise hart auf `--env=ELECTRON_OZONE_PLATFORM_HINT=wayland` setzen |
| Vault nicht auffindbar | Pfad nicht in der Sandbox freigegeben → Teil 1.3 |

### Harmlose Startmeldungen

Diese drei Meldungen erscheinen regelmäßig und bedeuten keinen Fehler:

| Meldung | Erklärung |
|---|---|
| `Failed to connect to the bus: /run/dbus/system_bus_socket` | Sandbox hat keinen System-Bus-Zugriff. Obsidian braucht ihn nicht, Electron probiert es routinemäßig |
| `Updates disabled.` | Korrekt bei Flatpak – Updates laufen über `flatpak update` |
| `LaunchProcess: failed to execvp: xdg-settings` | Electron wollte sich als Handler registrieren; betrifft nur `obsidian://`-Links |

Solange danach `Loaded updated app package ...` erscheint, ist der Start erfolgreich.

### Debug-Ausgabe erzwingen

Bei stummem Absturz schluckt Flatpak oft die eigentliche Meldung:

```bash
flatpak run --env=ELECTRON_ENABLE_LOGGING=1 md.obsidian.Obsidian 2>&1 | tail -40
```

---

## Referenz: Alle Befehle am Stück

```bash
# Flatpak-Overrides
flatpak override --user --socket=wayland md.obsidian.Obsidian
flatpak override --user --env=ELECTRON_OZONE_PLATFORM_HINT=auto md.obsidian.Obsidian
# optional, falls Vault außerhalb der Sandbox liegt:
# flatpak override --user --filesystem=/pfad/zu/den/Vaults md.obsidian.Obsidian

# Sway-Konfiguration (nur falls ~/.config/sway/config noch nicht existiert)
mkdir -p ~/.config/sway/config.d
printf 'include /etc/sway/config\ninclude ~/.config/sway/config.d/*\n' > ~/.config/sway/config

# Floating-Regel
cat > ~/.config/sway/config.d/50-obsidian-floating.conf <<'EOF'
for_window [app_id="obsidian"] floating enable
for_window [class="obsidian"] floating enable
EOF

swaymsg reload
```

---

## Hinweis zu Git-Sync in der Sandbox

Läuft der Vault-Sync über Git, wird der Betrieb aus der Flatpak-Sandbox heraus fummelig – Git-Plugins finden dort oft weder `git` noch die SSH-Keys. Unkomplizierter ist ein Sync-Skript oder ein Timer auf dem Host, der außerhalb der Sandbox arbeitet.
