In Sway ist der Fenstertitel Teil des Rahmens — `border` steuert beides zusammen. Zwei Zeilen in dein Drop-in:

```
default_border pixel 2
default_floating_border pixel 2
```

`pixel 2` behält einen dünnen Rahmen (praktisch, um den Fokus zu sehen), lässt die Titelleiste aber weg. Wenn du gar keinen Rahmen willst: `none` statt `pixel 2`.

Die zweite Zeile ist bei dir wichtig — Floating-Fenster haben eine eigene Border-Einstellung und behalten sonst ihre Titelleiste. Genau das würde bei deiner Obsidian-Regel auffallen.

**Als Drop-in anlegen:**

```bash
cat > ~/.config/sway/config.d/10-borders.conf <<'EOF'
default_border pixel 2
default_floating_border pixel 2
hide_edge_borders smart
EOF

swaymsg reload
```

`hide_edge_borders smart` blendet zusätzlich den Rahmen aus, wenn nur ein Fenster auf dem Workspace liegt — reine Geschmacksfrage, kannst du weglassen.

Beachte: Fedora Sway Atomic setzt in `/etc/sway/config` bzw. den mitgelieferten Snippets teilweise eigene Border-Werte. Da dein `~/.config/sway/config` die Systemkonfig per `include` **zuerst** einbindet und die Drop-ins danach, gewinnen deine Werte. Prüfen kannst du das mit:

```bash
grep -rn "default_border\|default_floating_border" /etc/sway/ ~/.config/sway/
```

**Einzelne Fenster steuern**

Falls du nur bei bestimmten Programmen die Leiste loswerden willst:

```
for_window [app_id="obsidian"] border pixel 2
```

Oder umgekehrt zur Laufzeit umschalten — `Mod+B` ist auf vielen Konfigs schon mit `border toggle` belegt.

**Was davon unberührt bleibt**

In `tabbed`- und `stacked`-Layouts bleiben die Titelleisten sichtbar, da sie dort die Tab-Beschriftung sind. Kleiner bekommst du sie über:

```
titlebar_padding 1
title_format "%title"
```

Ganz ausblenden geht dort nur über den Umweg einer sehr kleinen Schrift (`font pango:monospace 1`), was aber die Beschriftung unlesbar macht.