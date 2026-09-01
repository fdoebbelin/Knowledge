Es gibt **keinen direkten Weg**, `overlay use` mit einem dynamischen Pfad in der `config.nu` zu nutzen, weil Overlays strikt zur Parse-Zeit aufgelöst werden müssen.

Hier ist der funktionierende Workaround, der das Problem umgeht, indem wir die Umgebungsvariablen **manuell setzen**, anstatt `activate.nu` zu laden. Das simuliert genau das, was `activate.nu` tut, ist aber dynamisch und sicher für die Config.

Füge diesen Block in deine `config.nu` ein (ersetze den alten Versuch):

```nushell
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
            # aber wir könnten hier Custom Prompts setzen.
            print $"Virtuelle Umgebung aktiviert: ($venv_dir)"
        }
    } else {
        print -e $"Kein venv gefunden unter: ($activate_script)"
    }
}

# Deaktivierungs-Befehl
def --env deactivate [] {
    if "VIRTUAL_ENV" in $env {
        # Pfad zurücksetzen
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


### Warum funktioniert das?

1. **Kein `overlay use`**: Wir nutzen das Overlay-Feature nicht, daher versucht der Parser auch nicht, eine Datei zu finden, die es (noch) nicht gibt.
2. **Manuelle Pfad-Manipulation**: Wir machen exakt das, was `activate` tun würde (VIRTUAL_ENV setzen, PATH anpassen), aber zur Laufzeit (`def --env`).
3. **Universell**: Es funktioniert in jedem Ordner, da `$env.PWD` erst beim Ausführen des Befehls ausgewertet wird.

Füge das in deine Config ein, lade sie neu (`source $nu.config-path`), und dann kannst du einfach `venv` tippen.
<span style="display:none">[^1][^10][^11][^12][^13][^14][^15][^16][^17][^18][^19][^2][^20][^3][^4][^5][^6][^7][^8][^9]</span>

<div align="center">⁂</div>

[^1]: https://www.nushell.sh/book/overlays.html

[^2]: https://stackoverflow.com/questions/76796990/module-not-found-error-in-virtual-environment

[^3]: https://stackoverflow.com/questions/7369145/activating-a-virtualenv-using-a-shell-script-doesnt-seem-to-work

[^4]: https://www.nushell.sh/book/environment.html

[^5]: https://www.nushell.sh/blog/2022-09-06-nushell-0_68.html

[^6]: https://github.com/nushell/nushell/issues/15269

[^7]: https://stackoverflow.com/questions/48039847/activate-virtualenv-using-alias

[^8]: https://stackoverflow.com/questions/45216663/how-to-automatically-activate-virtualenvs-when-cding-into-a-directory

[^9]: https://github.com/nushell/nushell/issues/8214

[^10]: https://github.com/nushell/nushell/issues/9980

[^11]: https://virtualenv.pypa.io/en/legacy/userguide.html

[^12]: https://github.com/nushell/nushell/issues/10505

[^13]: https://www.nushell.sh/blog/2022-09-27-nushell-0_69.html

[^14]: https://www.nushell.sh/commands/docs/overlay_use.html

[^15]: https://github.com/nushell/nushell/issues/852

[^16]: https://www.nushell.sh/book/configuration.html

[^17]: https://github.com/nushell/nushell/issues/11918

[^18]: https://github.com/nushell/nushell/issues/7247

[^19]: https://github.com/pypa/virtualenv/blob/main/src/virtualenv/activation/nushell/activate.nu

[^20]: https://www.nushell.sh/blog/2025-03-18-nushell_0_103_0.html

