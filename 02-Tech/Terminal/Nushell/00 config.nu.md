
```

╭─AppData\Roaming\nushell
╰─➜ : cat config.nu
# config.nu
#
# Installed by:
# version = "0.108.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config = ($env.config?
    | default {}
    | merge {
        show_banner: false
        buffer_editor: "hx"
        edit_mode: vi
        cursor_shape: {
            emacs: inherit
            vi_insert: blink_line
            vi_normal: block
        }
    }
)
# Workaround: Manuelles Aktivieren des venv, um Parse-Fehler zu vermeiden
def --env venv [] {
    let venv_dir = ($env.PWD | path join ".venv")
    let activate_script = ($venv_dir | path join "Scripts" "activate.nu")

    if ($activate_script | path exists) {
        # 1. Alten PATH sichern (für deactivate)
        if "OLD_VIRTUAL_PATH" not-in $env {
            $env.OLD_VIRTUAL_PATH = $env.PATH
        }

        # 2. VIRTUAL_ENV Variable setzen
        $env.VIRTUAL_ENV = $venv_dir

        # 3. PATH erweitern (Scripts Verzeichnis an den Anfang)
        # Windows nutzt 'Scripts', Linux 'bin' - wir nehmen hier Windows an wie im Prompt
        let venv_bin = ($venv_dir | path join "Scripts")
        $env.PATH = ($env.PATH | prepend $venv_bin)

        # 4. Prompt markieren (optional, aber hilfreich)
        if "OLD_PROMPT" not-in $env {
            # Wir speichern den alten Prompt nicht, da Nushell Prompts anders handhabt,
            # aber wir kÃ¶nnten hier Custom Prompts setzen.
            print $"Virtuelle Umgebung aktiviert: ($venv_dir)"
        }
    } else {
        print -e $"Kein venv gefunden unter: ($activate_script)"
    }
}

# Deaktivierungs-Befehl
def --env deactivate [] {
    if "VIRTUAL_ENV" in $env {
        # Pfad zurÃ¼cksetzen
        if "OLD_VIRTUAL_PATH" in $env {
            $env.PATH = $env.OLD_VIRTUAL_PATH
            hide-env OLD_VIRTUAL_PATH
        }

        # Venv Variable entfernen
        hide-env VIRTUAL_ENV

        print "Virtuelle Umgebung deaktiviert."
    } else {
        print "Keine virtuelle Umgebung aktiv."
    }
}
```
