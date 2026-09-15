Der Warn-Log kommt von Starship, weil es versucht, die Fehlermeldung eines **externen Kommandos** als UTF‑8 zu dekodieren und dabei an einem nicht‑UTF‑8‑Byte (\xfc in „ausführen“ usw.) scheitert. Inhaltlich ist die eigentliche Fehlermeldung schlicht: **„Python wurde nicht gefunden; … Microsoft Store …“** – also dein Windows‑„Python“-Stub meckert, weil kein nutzbares Python installiert/auffindbar ist.[^1][^2][^3][^4][^5]

## Was passiert hier?

- Starship ruft im Hintergrund verschiedene Programme auf (u.a. `python`, `node`, `git`), um Versions‑Infos für die Prompt‑Module anzuzeigen.[^6][^7]
- Unter Windows gibt es oft nur den Store‑Stub `python.exe` in `C:\Users\<Name>\AppData\Local\Microsoft\WindowsApps\`, der bei Aufruf die bekannte Meldung „Python wurde nicht gefunden; …“ ausgibt.[^2][^8][^9]
- Diese Meldung enthält Umlaute mit Windows‑Codepage‑Encoding; Starship erwartet aber UTF‑8 → `FromUtf8Error`‑Warnung.[^10][^1]

Die Warnung ist kosmetisch, zeigt dir aber nebenbei, dass dein `python` im PATH nicht korrekt konfiguriert ist.

## Schritt 1: Python „richtig“ installieren / fixen

Wenn du Python brauchst (Starship‑Python‑Modul nutzen willst):

1. Python installieren (am einfachsten per winget):

```powershell
winget install Python.Python.3.12
```

Das setzt in der Regel auch den PATH sauber.[^3][^2]
2. Terminal komplett neu starten und prüfen:

```nu
^python --version
```

Wenn eine Version kommt → ok, Starship sollte beim nächsten Start keine Store‑Fehlermeldung mehr erzeugen.

Falls du Python aktuell gar nicht brauchst, kannst du es auch weglassen und nur das Starship‑Modul deaktivieren (siehe unten).

## Schritt 2: Starship‑Warnung „entschärfen“

### Variante A: Python‑Modul in Starship deaktivieren

Starship‑Config `~/.config/starship.toml` anlegen/öffnen (unter Nushell/Windows):

```nu
mkdir ($nu.home-path | path join ".config")
hx ($nu.home-path | path join ".config" "starship.toml")
```

Mindestens:

```toml
[python]
disabled = true
```

Damit ruft Starship `python` gar nicht mehr auf → keine Fehlermeldung → kein `FromUtf8Error` beim Dekodieren.[^11][^7]

### Variante B: Andere „fehlende“ Interpreter prüfen

Wenn der Warn‑Log weiterhin bei **jedem** Prompt‑Refresh auftaucht, könnten auch andere Module schuld sein (z.B. `elixir`, `node` o.ä.).[^4][^12]

In `starship.toml` kannst du solche Module ebenfalls abschalten, z.B.:

```toml
[nodejs]
disabled = true

[elixir]
disabled = true
```

Zur Fehlersuche kannst du in `starship.toml` testweise fast alles ausknipsen und dich hocharbeiten:

```toml
add_newline = true

[python]
disabled = true

[elixir]
disabled = true

[nodejs]
disabled = true

# etc.
```


## Schritt 3: Prüfen, ob noch echte Fehler auftreten

- Wenn nach Fix/Deaktivierung das Prompt normal kommt und `nu`‑Kommandos funktionieren, ist das Problem im Wesentlichen gelöst.
- Bleibt nur noch ein **einmaliger** Warn‑Log direkt nach Start, ist das kein funktionaler Fehler, sondern ein (unschöner) Hinweis auf die nicht‑UTF‑8‑konforme Windows‑Fehlermeldung.[^1][^4]

Wenn du magst, kannst du die exakte Ausgabe von

```nu
^python --version
```

und `echo $env.PATH` posten – dann lässt sich sehr gezielt sagen, welcher Eintrag im PATH bei dir den Store‑Stub triggert.
<span style="display:none">[^13][^14][^15][^16][^17][^18][^19][^20]</span>

<div align="center">⁂</div>

[^1]: https://www.nushell.sh/book/stdout_stderr_exit_codes.html

[^2]: https://www.python-forum.de/viewtopic.php?t=57251

[^3]: https://www.reddit.com/r/learnpython/comments/1jfr1w8/python_was_not_found_run_without_arguments_to/

[^4]: https://elixirforum.com/t/starship-cross-shell-prompt-error-starship-utils-executing-command-elixir-timed-out/37723

[^5]: https://www.reddit.com/r/learnpython/comments/1h8jorp/please_help_python_was_not_found_run_without/

[^6]: https://starship.rs/faq/

[^7]: https://starship.rs/config/

[^8]: https://www.reddit.com/r/learnpython/comments/qzwdda/python_was_not_found_run_without_arguments_to/

[^9]: https://www.reddit.com/r/learnpython/comments/176e3zh/how_do_i_fix_the_python_was_not_found_run_without/

[^10]: https://users.rust-lang.org/t/string-from-utf8-error-after-some-update/92888

[^11]: https://starship.rs/de-de/config/

[^12]: https://github.com/msys2/MINGW-packages/issues/10465

[^13]: https://github.com/starship/starship/issues/6698

[^14]: https://github.com/Supervisor/supervisor/issues/638

[^15]: https://stackoverflow.com/questions/69065915/error-adding-starship-command-line-in-windows-powershell-profile

[^16]: https://github.com/starship/starship/issues/6336

[^17]: https://forum.endeavouros.com/t/faced-a-problem-when-installing-starship-in-my-bash/19492

[^18]: https://github.com/nushell/engine-q/issues/575

[^19]: https://github.com/nushell/nushell/issues/10805

[^20]: https://isamert.net/.emacs.d/init.el.html

