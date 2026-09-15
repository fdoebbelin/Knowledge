`sudoedit` kopiert die Datei in eine temporäre, dir gehörende Kopie, lässt dich als normaler User editieren und schreibt sie danach zurück. Vorteil: Helix läuft **nicht** als root, lädt also deine eigene Config/Plugins statt root's – und das gefürchtete „Editor mit vollen Rechten"-Problem entfällt.

In Bash:

```bash
SUDO_EDITOR=hx sudoedit /etc/hosts
```

In Nushell geht das Inline-`VAR=val` nicht (wie bei deinem `LANG=C`-Fall), daher mit `with-env`:

```nu
with-env {SUDO_EDITOR: "hx"} { sudoedit /etc/hosts }
```

Oder du setzt es dauerhaft in deiner Nushell-Config, dann reicht später einfach `sudoedit /etc/hosts`:

```nu
# in ~/.config/nushell/env.nu
$env.SUDO_EDITOR = "hx"
$env.EDITOR = "hx"
```

`sudoedit` wertet `SUDO_EDITOR` → `VISUAL` → `EDITOR` aus, in dieser Reihenfolge.

**Quick & dirty (nicht ideal):**

```bash
sudo hx /etc/hosts
```

Funktioniert, aber Helix läuft komplett als root und liest `/root/.config/helix/` statt deiner Konfiguration. Für eine schnelle Einzelzeile okay, dauerhaft aber `sudoedit` vorziehen.