---
title: "Helix – Installation und Konfiguration"
aliases:
  - Helix Installation
tags:
  - helix
  - editor
  - terminal
  - homebrew
  - atomic
  - toolbx
created: 2026-10-13
updated: 2026-10-21
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Bedienkonzept und Befehle: [[01-Leitfaden zum Spickzettel|Helix-Leitfaden]], [[02-Cookbook|Helix-Cookbook]].

## Windows (Scoop)

```powershell
scoop install helix
hx --health            # Runtime, Clipboard, allgemeiner Status
hx --health python     # zeigt, ob der Language-Server für Python gefunden wird
hx --tutor             # eingebautes Grundkurs-Tutorial
```

> [!tip] Übungsdatei anlegen
> Lege dir eine `uebung.txt` (oder `.py`, `.md`) an und öffne sie mit `hx uebung.txt`. Die Cookbook-Übungsdatei dafür steht in [[02-Cookbook|Helix-Cookbook]]. Verwerfen mit `:q!`.

> [!info] Konfig- und Runtime-Pfad unter Windows
> Konfiguration liegt unter `%AppData%\helix\` (also `C:\Users\<Name>\AppData\Roaming\helix\`). Die Runtime von Scoop findest du unter `%USERPROFILE%\scoop\apps\helix\current\runtime`. Falls `hx --health` „Runtime directory does not exist“ meldet, setze `HELIX_RUNTIME` auf diesen Pfad.

## Windows aus dem Quelltext bauen

Für Windows on ARM oder wenn Scoop kein aktuelles Paket hat: [[Helix aus Quelltext bauen (Windows on ARM, PowerShell)]].

## Linux (Fedora Sway Atomic)

Das Basisimage von Fedora Atomic ist schreibgeschützt. Ohne Layering gibt es zwei Wege, die sich in einem Punkt unterscheiden: ob `hx` auch **in Toolbx-Containern** verfügbar ist.

| | Weg 1: Homebrew | Weg 2: lokales Binary im `$HOME` |
|---|---|---|
| Ort | `/home/linuxbrew/.linuxbrew/bin/hx` | `~/.local/share/helix/<Version>/hx`, Symlink `~/.local/bin/hx` |
| Auf dem Host | ✓ | ✓ |
| In Toolbx/Distrobox | ✗ – der Pfad liegt außerhalb von `$HOME` und existiert im Container nicht | ✓ – `$HOME` wird durchgereicht |
| Update | `brew upgrade helix` | Installationsskript erneut ausführen |
| Runtime | findet Homebrew selbst | `HELIX_RUNTIME` in `env.nu` setzen |
| Geeignet, wenn | Helix nur auf dem Host gebraucht wird | Helix auch im Container laufen soll, z. B. mit `rust-analyzer` aus einer Toolbx |

Auf dem Referenzsystem ist seit dem 21.10.2026 **Weg 2** installiert (Helix 25.07.1, Homebrew-Fassung entfernt). Weg 1 bleibt als Alternative beschrieben.

### Weg 1: Homebrew

Gleicher Weg wie bei Yazi (siehe [[03-Installation und Konfiguration|Yazi-Installation]] Abschnitt 2): Homebrew installiert ohne Layering und ohne Neustart nach `/home/linuxbrew/.linuxbrew`.

```nu
brew install helix

hx --version
hx --health             # Runtime, Clipboard, Sprachübersicht
hx --health python       # Language-Server für eine bestimmte Sprache prüfen
```

Update:

```nu
brew upgrade helix
```

Helix als `$EDITOR` unter Nushell eintragen: [[Nushell Editor setzen]].

> [!warning] „Runtime directory does not exist“ in `hx --health`
> Auf dem Referenzsystem meldet `hx --health` zwei fehlende Runtime-Pfade (`~/.config/helix/runtime` und einen Cellar-Unterpfad). Harmlos, solange mindestens einer der gelisteten Pfade existiert – Tree-sitter-Highlighting, Textobjekte und Einrückung funktionieren trotz der Warnung (geprüft mit `hx --health rust`/`hx --health markdown`: Parser, Highlight- und Textobjekt-Queries stehen auf ✓). Nur falls **gar keine** Sprache mehr markiert wird, `HELIX_RUNTIME` wie im Windows-Abschnitt oben setzen.

### Weg 2: lokales Binary im `$HOME`

Ausführlich mit Skript und Erklärung jeder Zeile: [[00 Werkzeuge ins HOME-Verzeichnis installieren]]. Kurzfassung:

1. Installationsskript aus [[00 Werkzeuge ins HOME-Verzeichnis installieren#3 Das Installationsskript|Abschnitt 3]] als `~/.local/bin/install-helix.nu` speichern, `chmod +x`, ausführen. Es holt das aktuelle Release von GitHub, legt es versioniert unter `~/.local/share/helix/` ab und setzt den Symlink `~/.local/bin/hx`.
2. `HELIX_RUNTIME` auf oberster Ebene von `env.nu` setzen (sonst startet Helix über den Symlink ohne Syntax-Highlighting), siehe [[00 Werkzeuge ins HOME-Verzeichnis installieren#5.1 Runtime-Verzeichnis bekannt machen|Abschnitt 5.1]]:

```nu
$env.HELIX_RUNTIME = ($env.HOME | path join ".local/bin/hx"
    | path expand | path dirname | path join "runtime")
```

3. Prüfen – auf dem Host und einmal im Container:

```nu
which -a hx              # erwartet: nur ~/.local/bin/hx
hx --version
hx --health | first 12   # "Runtime directories" muss ~/.local/share/helix/<Version>/runtime enthalten

toolbox enter tauri-dev
which hx                 # derselbe Pfad wie auf dem Host
hx --health rust         # rust-analyzer aus dem CARGO_HOME der Toolbox: ✓
```

Auf dem Referenzsystem so geprüft (21.10.2026): Host und `tauri-dev` finden `/var/home/fritz/.local/bin/hx`, Tree-sitter-Parser und Queries stehen auf ✓, im Container zusätzlich `rust-analyzer`. Die Meldung `Runtime directory does not exist: ~/.config/helix/runtime` erscheint auch hier und ist harmlos (siehe Weg 1).

Update, Rückrollen und Deinstallation: [[00 Werkzeuge ins HOME-Verzeichnis installieren#7 Update und Deinstallation|Abschnitt 7]]. Sprachserver gehören weiterhin in den Container ([[00 Werkzeuge ins HOME-Verzeichnis installieren#6 Sprachserver gehören in den Container|Abschnitt 6]]).

> [!warning] Beide Wege gleichzeitig
> Sind Homebrew-Helix und lokales Binary installiert, gewinnt auf dem Host der Eintrag, der in `$env.PATH` zuerst steht – im Container gibt es nur das lokale Binary. `which -a hx` zeigt alle Fundstellen in Suchreihenfolge. Beim Wechsel auf Weg 2 die Homebrew-Fassung mit `brew uninstall helix` entfernen, damit Host und Container dieselbe Version nutzen.

> [!info] Andere Distributionen (ungeprüft)
> Außerhalb von Fedora Atomic bringen viele Distributionen Helix direkt mit: `dnf install helix` (klassisches Fedora), `apt install helix` (Debian/Ubuntu ab einer gewissen Version), oder `cargo install helix-term` überall dort, wo kein Paket existiert. Vor Übernahme ins Vault auf dem jeweiligen System mit `hx --version` verifizieren – hier nicht nachgeprüft, da das Referenzsystem Fedora Atomic mit Homebrew ist.

> [!tip] Markdown-Language-Server
> Für die LSP-Befehle in [[11 Markdown-Rezepte]] (Gliederung über `Space s`, Diagnosen für kaputte Links) braucht es einen Server: `brew install marksman` – Helix findet ihn automatisch (`hx --health markdown` → `✓ marksman`). Auf dem Referenzsystem so installiert (21.10.2026, Version 2026-02-08). Ein per Homebrew installierter `marksman` ist im Container nicht sichtbar; das ist gewollt, weil Markdown (der Vault) nur auf dem Host bearbeitet wird. Nur nötig für die LSP-Befehle – Highlighting und Textobjekte kommen von Tree-sitter.

## Start-Konfiguration

Eine Datei genügt. Unter Windows: `%AppData%\helix\config.toml`; unter Linux: `~/.config/helix/config.toml` (öffnen mit `:config-open`, siehe [[10 Dateien, Buffer und Fenster]]).

```toml
theme = "default"

[editor]
line-number = "relative"   # gut zum Springen mit z. B. 5j / 7k
cursorline = true
bufferline = "multiple"    # offene Buffer als Leiste oben
color-modes = true         # Modus per Farbe erkennbar
true-color = true

[editor.statusline]
left  = ["mode", "spinner", "file-name", "file-modification-indicator"]
right = ["diagnostics", "position", "file-encoding"]

[editor.cursor-shape]
insert = "bar"
normal = "block"
select = "underline"

[editor.lsp]
display-messages = true
display-inlay-hints = true

[editor.file-picker]
hidden = false             # versteckte Dateien im Picker zeigen
```

> [!info] Sprachspezifisches
> Formatter, Language-Server und Einrückung pro Sprache regelst du in `languages.toml` (gleicher Ordner wie `config.toml`). `hx --health <sprache>` sagt dir, was noch fehlt.

> [!note] Cursor-Form
> Anders als Vim zeigt Helix standardmäßig im Einfüge- **und** im Normalmodus denselben Block-Cursor. `[editor.cursor-shape]` wie oben stellt das um.

## Verwandt

- [[01-Leitfaden zum Spickzettel|Helix-Leitfaden]] – Bedienkonzept an den Spickzettel-Grafiken
- [[02-Cookbook|Helix-Cookbook]] – Befehlsreferenz als Rezepte
- [[Helix aus Quelltext bauen (Windows on ARM, PowerShell)]] – Build-Anleitung im Detail
- [[sudoedit]] – Helix als `$SUDO_EDITOR`
- [[Nushell Editor setzen]] – Helix als `$EDITOR` unter Nushell
- [[00 Werkzeuge ins HOME-Verzeichnis installieren]] – Weg 2 im Detail, Muster auch für andere Werkzeuge
