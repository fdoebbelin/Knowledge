Mit Helix kannst du Nu‑Skripte aktuell am besten über den externen Formatter „topiary“ formatieren, der Nu unterstützt.[^1]

## Schritt 1: topiary + topiary‑nushell installieren

1. Topiary installieren (z.B. via Cargo):
`cargo install --git https://github.com/tweag/topiary topiary-cli`.[^1]
2. Repo für Nu‑Unterstützung klonen, z.B.:
`git clone https://github.com/blindFS/topiary-nushell ~/.config/topiary`.[^1]

(Aus dem Repo stammt u.a. die `languages.ncl`, die Nu‑Syntax kennt.)[^1]

## Schritt 2: Helix konfigurieren

In `~/.config/helix/languages.toml` folgendes ergänzen:

```toml
[[language]]
name = "nu"
auto-format = true
formatter = { command = "topiary", args = ["format", "--language", "nu"] }
```

Damit ruft Helix für `.nu`‑Dateien beim Formatieren (und auf Wunsch beim Speichern) `topiary format --language nu` auf.[^2][^1]

## Schritt 3: Formatierung nutzen

- Manuell formatieren: `:format` in Helix im Nu‑File aufrufen.[^2]
- Mit `auto-format = true` wird beim Speichern automatisch formatiert, sofern kein Fehler im Formatter auftritt.[^2][^1]

Wenn du magst, kann als nächstes noch das Nu‑LSP (`nu --lsp`) eingebunden werden, das ist aber für reines Formatieren nicht zwingend nötig.[^3]
<span style="display:none">[^10][^11][^12][^13][^14][^15][^16][^17][^18][^19][^20][^4][^5][^6][^7][^8][^9]</span>

<div align="center">⁂</div>

[^1]: https://github.com/blindFS/topiary-nushell

[^2]: https://docs.helix-editor.com/languages.html

[^3]: https://github.com/nushell/nushell/issues/11439

[^4]: https://www.reddit.com/r/HelixEditor/comments/1d59br3/file_tree_setup_using_yazi_zellij_helix_and/

[^5]: https://github.com/luccahuguet/yazelix

[^6]: https://community.tmpdir.org/t/helix-editor/1244

[^7]: https://ftp.perforce.com/perforce/r16.2/doc/manuals/p4guide/appendix.filetypes.html

[^8]: https://www.nushell.sh/commands/docs/format.html

[^9]: https://tha.de/homes/hhoegl/blog/helix/

[^10]: https://docs.helix-editor.com/lang-support.html

[^11]: https://www.nushell.sh/commands/docs/format_pattern.html

[^12]: https://www.reddit.com/r/HelixEditor/comments/12cic0q/language_server_installation/

[^13]: https://www.x-cmd.com/pkg/helix/

[^14]: https://github.com/helix-editor/helix/issues/5940

[^15]: https://www.nushell.sh/commands/docs/format_number.html

[^16]: https://discourse.nixos.org/t/helix-lsp-servers/34833

[^17]: https://kapeli.com/cheat_sheets/Helix.docset/Contents/Resources/Documents/index

[^18]: https://help.perforce.com/helix-core/server-apps/p4guide/current/Content/P4Guide/appendix.filetypes.html

[^19]: https://www.nushell.sh/commands/

[^20]: https://elixirforum.com/t/helix-editor-for-elixir-development/54964?page=3

