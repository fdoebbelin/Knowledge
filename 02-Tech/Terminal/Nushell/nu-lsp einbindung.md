Nushell bringt seit einiger Zeit einen eigenen Language Server mit, der über `nu --lsp` gestartet wird und sich wie andere LSPs in Helix einbinden lässt.[^1][^2]

## Voraussetzungen

- Aktuelle Nushell-Version, in der `nu --lsp` verfügbar ist (ab ca. 0.79, sinnvoller mit deutlich neuerer Version wie 0.9x+).[^3][^2]
- Helix ≥ 23.x mit LSP-Unterstützung und eigener `languages.toml` unter `~/.config/helix/languages.toml`.[^4][^5]


## Language-Server in Helix definieren

In `~/.config/helix/languages.toml` einen Server-Eintrag für Nushell anlegen, z.B.:

```toml
[language-server.nushell-lsp]
command = "nu"
args = ["--lsp"]
```

Dieser Block sagt Helix, dass der Server über `nu --lsp` gestartet werden soll.[^1][^4]

## Nushell-Sprache in Helix konfigurieren

Ebenfalls in `languages.toml` eine `language`-Sektion hinzufügen oder erweitern:

```toml
[[language]]
name = "nushell"
language-servers = ["nushell-lsp"]
file-types = ["nu"]
auto-format = true
```

- `file-types` legt fest, dass Dateien mit Endung `.nu` die Nushell-Sprache verwenden.[^4]
- `auto-format = true` aktiviert Formatierung beim Speichern, sofern der LSP das unterstützt (Nushell arbeitet genau daran, Formatierung und Tests direkt im LSP bereitzustellen).[^2]


## Nutzung in Helix

- Eine `.nu`‑Datei öffnen, mit `:lsp-log` bzw. `:lsp-restart` prüfen, ob der Server läuft.[^5][^4]
- Du solltest jetzt u.a. Diagnostics, Hover‑Infos und (sofern schon implementiert) Formatierung über LSP-Funktionen von `nu --lsp` bekommen.[^2][^1]
<span style="display:none">[^10][^11][^12][^13][^14][^15][^16][^17][^18][^19][^20][^6][^7][^8][^9]</span>

<div align="center">⁂</div>

[^1]: https://github.com/nushell/nushell/issues/11439

[^2]: https://www.nushell.sh/blog/2023-11-14-nushell_0_87_0.html

[^3]: https://www.nushell.sh/blog/2023-04-25-nushell_0_79.html

[^4]: https://docs.helix-editor.com/lang-support.html

[^5]: https://github.com/helix-editor/helix/discussions/8078

[^6]: https://crates.io/crates/nu-lsp

[^7]: https://lib.rs/crates/nu-lsp

[^8]: https://docs.rs/nu-lsp

[^9]: https://plugins.lapce.dev/plugins/timon-schelling/nushell-lsp

[^10]: https://stackoverflow.com/questions/79659669/how-to-properly-set-up-ruby-gem-environment-to-use-ruby-lsp-for-helix

[^11]: https://www.reddit.com/r/HelixEditor/comments/1gqqw67/introducing_zellix_a_nushell_script_utilizing/

[^12]: https://github.com/zioroboco/nu-ls.nvim

[^13]: https://github.com/nushell/awesome-nu

[^14]: https://www.reddit.com/r/HelixEditor/comments/17ere2q/how_to_add_helix_lsp_to_path/

[^15]: https://stackoverflow.com/questions/79519127/how-to-execute-nushell-commands-inside-nvim-command-line

[^16]: https://www.nushell.sh

[^17]: https://crates.io/crates/nu-lsp/0.94.1/dependencies

[^18]: https://elixirforum.com/t/helix-editor-for-elixir-development/54964?page=3

[^19]: https://news.ycombinator.com/item?id=45746478

[^20]: https://marketplace.visualstudio.com/items?itemName=TheNuProjectContributors.vscode-nushell-lang

