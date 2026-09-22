---
typ: anhang
title: Container-Setup-Skript für den Kurs
tags: [tauri/kurs/anhang, nushell, toolbx]
status: draft
---

# Anhang – Container-Setup-Skript für den Kurs

Erweiterung des Skripts aus Leitfaden-Abschnitt 23 um Node.js und einen Kontrollteil. Ablage unter `~/.local/bin/setup-tauri-toolbox.nu`, idempotent.

```nu
#!/usr/bin/env nu

const CONTAINER = "tauri-dev"

def container-exists []: nothing -> bool {
    podman ps -a --format "{{.Names}}" | lines | any {|n| $n == $CONTAINER }
}

def main [--name: string = "tauri-dev"] {
    if not (container-exists) {
        print $"Lege Container ($CONTAINER) an ..."
        toolbox create -c $CONTAINER
    } else {
        print $"Container ($CONTAINER) existiert bereits."
    }

    let pakete = [
        "webkit2gtk4.1-devel" "openssl-devel"
        "curl" "wget" "file"
        "libappindicator-gtk3-devel" "librsvg2-devel" "libxdo-devel"
        "nodejs" "npm"                      # NEU gegenüber dem Leitfaden
    ]

    toolbox run -c $CONTAINER sudo dnf install -y ...$pakete
    toolbox run -c $CONTAINER sudo dnf group install -y c-development

    let cargo_home = ($env.HOME | path join ".local/share/toolbox" $CONTAINER "cargo")

    if ($cargo_home | path join "bin/rustup" | path exists) {
        print "Rust-Toolchain bereits vorhanden."
    } else {
        print "Installiere Rust im Container ..."
        toolbox run -c $CONTAINER nu -c "http get https://sh.rustup.rs | save --raw --force /tmp/rustup-init.sh; sh /tmp/rustup-init.sh -y --no-modify-path"
    }

    if ($cargo_home | path join "bin/cargo-tauri" | path exists) {
        print "tauri-cli bereits vorhanden."
    } else {
        print "Installiere tauri-cli (dauert einige Minuten) ..."
        toolbox run -c $CONTAINER nu -c "cargo install tauri-cli --version '^2' --locked"
    }

    print ""
    print "--- Kontrolle ---"
    toolbox run -c $CONTAINER nu -c "cargo tauri --version; node --version; npm --version"
    print $"Fertig. Mit 'toolbox enter ($CONTAINER)' betreten."
}
```

## Prüfung des Hosts vor Kursbeginn

Getrenntes Skript, läuft auf dem **Host**. Deckt die offenen Punkte aus [[00 Kurskonzept Tauri]] ab.

```nu
#!/usr/bin/env nu

def main [] {
    print "--- Host darf nichts Gelayertes enthalten ---"
    rpm-ostree status --json | from json | get deployments.0.requested-packages?

    print "--- cargo und node dürfen hier fehlen ---"
    which --all cargo node npm

    print "--- Portals (nötig für Modul 06) ---"
    ls /usr/share/xdg-desktop-portal/portals | get name

    print "--- Benachrichtigungsdienst (nötig für Modul 06) ---"
    pgrep -l mako

    print "--- Flatpak-Builder und Runtimes ---"
    flatpak list --columns=application | lines | where $it =~ "flatpak.Builder|gnome.Sdk|gnome.Platform|rust-stable"

    print "--- Tray-Anbieter (bestimmt Umfang von Modul 09) ---"
    pgrep -l waybar
}
```

> [!tip] Einsatz
> Vor dem ersten Kurstag auf allen Geräten laufen lassen und die Ausgaben sammeln. Fehlt ein Portal oder ein Benachrichtigungsdienst, scheitern Modul 06 und 09 stumm, was im Unterricht schwer zu diagnostizieren ist.

## Verknüpfung

[[M00 Umgebung erweitern und Vue-Projekt anlegen]] · [[M13 Abschlussprojekt]] · [[00 Kurskonzept Tauri]]
