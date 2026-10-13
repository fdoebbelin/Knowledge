---
title: "Helix-Cookbook – Kapitel 12: Eigene Belegungen"
aliases:
  - Helix Cookbook Eigene Belegungen
  - Helix Keybindings
tags:
  - helix
  - editor
  - cookbook
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel: [[02-Cookbook|Helix-Cookbook]]. Fundstelle und Grundaufbau der `config.toml`: [[03-Installation#Start-Konfiguration]]. Datei öffnen/neu laden: `:config-open` / `:config-reload`, siehe [[10 Dateien, Buffer und Fenster]].

Eigene Tastenbelegungen stehen in denselben `config.toml` wie die Editor-Optionen aus [[03-Installation]] – nur in eigenen `[keys.*]`-Abschnitten. Es gibt **höchstens je einen** Abschnitt `[keys.normal]`, `[keys.insert]` und `[keys.select]`; weitere Tasten kommen als zusätzliche Zeilen dazu, nicht als zweiter Abschnitt.

## Drei Arten von Befehlen

| Art | Schreibweise | Beispiel |
|---|---|---|
| Interner Befehl | `taste = "befehlsname"` | `a = "move_char_left"` |
| Befehlsmodus-Kommando | `taste = ":befehl"` | `C-s = ":w"` |
| Makro (Tastenfolge) | `taste = "@tasten"` | `"A-x" = "@x<A-d>"` (ganze Zeile auswählen und löschen) |

Interne Befehlsnamen (wie `move_char_left`) stehen nicht im Befehlsmodus zur Verfügung und lassen sich nicht über `Space ?` nachschlagen – die vollständige Liste steht in der [Helix-Keymap-Dokumentation](https://docs.helix-editor.com/keymap.html) bzw. im Quelltext (`static_commands!` in `helix-term`). Befehlsmodus-Kommandos (`:w`, `:sh` …) findet man dagegen direkt in Helix über `Space ?`.

```toml
[keys.normal]
C-s = ":w"                          # Ctrl-s speichert
C-o = ":open ~/.config/helix/config.toml"  # eigene Konfiguration schnell erreichbar
"C-S-esc" = "extend_line"           # Ctrl-Shift-Esc erweitert die Auswahl um eine Zeile
```

> [!tip] Modifikatoren und Sondertasten
> `C-`, `S-`, `A-` für Ctrl/Shift/Alt, `Meta-`/`Cmd-`/`Win-` für die Super-Taste (Windows-/Befehlstaste). Kombinationen mit Bindestrich, z. B. `C-S-esc`. Sondertasten wie `"ret"`, `"esc"`, `"tab"`, `"space"`, `"backspace"`, `"left"`/`"right"`/`"up"`/`"down"` stehen in Anführungszeichen. Innerhalb eines Makros (`@...`) werden Modifikatoren in spitze Klammern gesetzt: `<A-o>`, `<C-x>`.

## Mehrere Tasten hintereinander (Minor Modes)

Zwei gleichwertige Schreibweisen für Tastenfolgen wie `ga` oder `jk`:

```toml
# verschachtelt
[keys.normal.g]
a = "code_action"

# oder als Inline-Tabelle in einer Zeile
g = { a = "code_action" }
```

> [!example] `jk` zum Verlassen des Einfügemodus
> ```toml
> [keys.insert.j]
> k = "normal_mode"
> ```
> Nach `j` wartet Helix kurz auf eine zweite Taste. Folgt `k`, wechselt es in den Normalmodus, ohne `j` oder `k` einzufügen. Folgt eine andere Taste oder vergeht die kurze Wartezeit, wird `j` ganz normal eingefügt. Wer oft Wörter mit `jk` tippt, sollte das einkalkulieren.

> [!example] Eigener Minor Mode für Shell-Befehle
> ```toml
> [keys.normal."+"]
> m = ":sh make"
> c = ":sh cargo build"
> t = ":sh cargo test"
> ```
> `+m` baut, `+c` kompiliert, `+t` testet – `:sh` wie in [[08 Shell-Integration]]. `+` war vorher unbelegt, es wird also kein bestehender Befehl überschrieben.

## Tasten deaktivieren

`no_op` entfernt eine Belegung ersatzlos:

```toml
[keys.insert]
up = "no_op"
down = "no_op"
left = "no_op"
right = "no_op"
```

> [!tip] Pfeiltasten im Einfügemodus abgewöhnen
> Die vier Zeilen oben zwingen dazu, zum Navigieren immer erst `Esc` in den Normalmodus zu wechseln – näher am in diesem Leitfaden vermittelten Arbeitsstil (siehe [[01-Leitfaden zum Spickzettel#1 Das Grundprinzip Auswahl → Aktion]]) als gelegentliches Pfeiltasten-Tippen mitten im Einfügen.

## Grenzen

- Nach aktuellem Stand (Helix 25.x) gibt es **keine sprachspezifischen Belegungen** – nur eine globale Keymap pro Modus, unabhängig vom Dateityp.
- Remapping ist einseitig: Es ändert, was eine Taste auslöst, nicht die Anzeige in Menüs oder der Statuszeile.
- Alles Nicht-Umbelegte bleibt bei der Standardbelegung aus [[01-Leitfaden zum Spickzettel]] und dem restlichen Cookbook.

## Verwandt

- [[03-Installation]] – wo die `config.toml` liegt, restliche Editor-Optionen
- [[10 Dateien, Buffer und Fenster]] – `:config-open`, `:config-reload`
- [[08 Shell-Integration]] – `:sh` und weitere Befehlsmodus-Kommandos für eigene Minor Modes
- [[13 Für Vim-Umsteiger]] – wer aus Vim kommt und Muskelgedächtnis nachbilden will
