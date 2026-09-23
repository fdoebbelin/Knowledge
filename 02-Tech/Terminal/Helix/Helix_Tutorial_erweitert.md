---
tags: [helix, editor, tutorial, terminal, vim]
aliases: ["Helix Tutorial", "Helix Stärken", "Helix erweitert"]
created: 2026-06-02
---

# Helix – Erweitertes Tutorial: die Stärken kennenlernen

Dieses Tutorial baut auf dem eingebauten `:tutor` auf und zeigt gezielt, *warum* Helix sich anders anfühlt als Vim – und wo es richtig stark ist: Mehrfach-Cursor, syntaxbewusstes Bearbeiten, eingebauter LSP, Pickers und durchdachte Defaults. Am Ende steht eine Reflex-Tabelle für Vim-Umsteiger und eine Start-Konfiguration.

> [!abstract] Der eine Denkfehler, den man ablegen muss
> In Vim sagst du erst, *was* du tun willst, dann *worauf* (`d` + `w` = lösche Wort). In Helix ist es umgekehrt: erst die **Auswahl**, dann die **Aktion** (`w` wählt das Wort, `d` löscht die Auswahl). Du siehst also *immer*, worauf eine Aktion wirkt, bevor sie passiert. Das ist die Grundlage für fast jede Stärke weiter unten.

## Inhalt

- [[#0 Vorbereitung (Windows / Scoop)]]
- [[#1 Die Kernschleife Auswahl → Aktion]]
- [[#2 Mehrfach-Cursor – die Superkraft]]
- [[#3 Syntaxbewusst bearbeiten (Tree-sitter)]]
- [[#4 Surround – ohne Plugin]]
- [[#5 Code-Intelligenz mit LSP]]
- [[#6 Pickers & das Space-Menü]]
- [[#7 Auswahlen verbiegen – die Profi-Rezepte]]
- [[#8 Shell-Integration]]
- [[#9 Vim → Helix Reflexe umtrainieren]]
- [[#10 Start-Konfiguration]]
- [[#Wohin als Nächstes]]

---

## 0 Vorbereitung (Windows / Scoop)

Helix bringt alles mit; für die LSP-Features brauchst du nur den jeweiligen Sprachserver.

```powershell
hx --health            # Runtime, Clipboard, allgemeiner Status
hx --health python     # zeigt, ob der Language-Server für Python gefunden wird
hx --tutor             # der eingebaute Grundkurs (Wiederholung schadet nie)
```

> [!tip] Übungsdatei anlegen
> Lege dir eine `uebung.txt` (oder `.py`, `.md`) an und öffne sie mit `hx uebung.txt`. Alle Übungen unten lassen sich darin gefahrlos durchspielen. Verwerfen mit `:q!`.

> [!info] Konfig- und Runtime-Pfad unter Windows
> Konfiguration liegt unter `%AppData%\helix\` (also `C:\Users\<Name>\AppData\Roaming\helix\`). Die Runtime von Scoop findest du unter `%USERPROFILE%\scoop\apps\helix\current\runtime`. Falls `hx --health` „Runtime directory does not exist" meldet, setze `HELIX_RUNTIME` auf diesen Pfad.

---

## 1 Die Kernschleife: Auswahl → Aktion

In Helix steht der Cursor nie „zwischen" Zeichen, sondern *auf* einer Auswahl (meist ein Zeichen breit). Jede Bewegung verschiebt – und oft *erweitert* – diese Auswahl.

| Du willst … | Tasten | Was passiert |
|---|---|---|
| ein Wort löschen | `w` `d` | `w` wählt bis zum nächsten Wortanfang, `d` löscht die Auswahl |
| ein Wort ändern | `w` `c` | wie oben, danach landest du direkt im Einfügemodus |
| eine Zeile löschen | `x` `d` | `x` wählt die ganze Zeile, `d` löscht sie |
| bis Zeilenende ändern | `t` `Enter`? | präziser: erst auswählen, dann handeln |

> [!example]- Übung 1 – Bewegung *ist* Auswahl
> Tippe in deine Übungsdatei:
> `der schnelle braune Fuchs springt`
> 1. Cursor auf `der`, drücke `w` – die Auswahl wandert über `schnelle ` (inkl. Leerzeichen).
> 2. Drücke nochmal `w` – nächste Auswahl.
> 3. Jetzt `d` – das ausgewählte Wort verschwindet.
>
> **Aha-Moment:** Du musstest nie raten, *was* gelöscht wird – es war markiert. Genau dieses Feedback fehlt in Vim.

> [!warning] Die drei klassischen Stolperfallen für Vim-Leute
> - `U` ist **Redo** (nicht `Strg-r`); `u` bleibt Undo.
> - `%` wählt die **ganze Datei** aus (in Vim springt es zur passenden Klammer – das ist hier `mm`).
> - Makros sind **vertauscht**: `Q` nimmt auf, `q` spielt ab.

---

## 2 Mehrfach-Cursor – die Superkraft

Das ist Helix' Aushängeschild. Statt Makros aufzunehmen oder `:%s/.../.../g` zu tippen, arbeitest du mit *mehreren Auswahlen gleichzeitig*. Jede Bearbeitung wirkt auf alle Cursor.

Die wichtigsten Befehle:

- `s` – innerhalb der aktuellen Auswahl alle Regex-Treffer auswählen (ein Cursor pro Treffer)
- `C` / `Alt-C` – Cursor in die Zeile darunter / darüber kopieren
- `,` – nur den Haupt-Cursor behalten (Notausgang)
- `;` – Auswahlen auf je einen Cursor zusammenklappen
- `Alt-s` – eine Auswahl an Zeilenumbrüchen in viele zerlegen (ein Cursor pro Zeile)

> [!example]- Übung 2 – Suchen & Ersetzen, der Helix-Weg
> Helix hat **kein** `:%s///`. Stattdessen:
> ```
> name = alice
> name = bob
> name = carol
> ```
> 1. `%` – ganze Datei auswählen.
> 2. `s`, dann `name` tippen, `Enter` – jetzt sitzt auf jedem `name` ein Cursor.
> 3. `c`, dann `user` tippen, `Esc` – alle drei sind ersetzt.
>
> Das Schöne: Du *siehst* alle Treffer markiert, bevor du änderst. Tippfehler im Muster fallen sofort auf.

> [!example]- Übung 3 – jede Zeile am Ende bearbeiten
> ```
> apfel
> birne
> kirsche
> ```
> 1. `%` ganze Datei wählen, dann `Alt-s` – ein Cursor pro Zeile.
> 2. `A` (Anfügen am Zeilenende), tippe `,`, `Esc`.
> 3. Jede Zeile endet jetzt mit einem Komma – ohne Makro.

> [!tip] Kombinierbar mit allem
> Mehrfach-Cursor + Surround (Teil 4) + LSP-Rename ergeben Bearbeitungen, für die man in Vim drei Plugins und ein Makro bräuchte.

---

## 3 Syntaxbewusst bearbeiten (Tree-sitter)

Helix versteht die *Struktur* deines Codes, nicht nur Zeichen. Auswahlen können sich an Syntaxknoten orientieren – verlässlicher als Vims regex-basierte Textobjekte.

- `Alt-o` / `Alt-i` – Auswahl zum umschließenden Syntaxknoten **erweitern** / **verkleinern**
- `Alt-n` / `Alt-p` – nächsten / vorigen Geschwisterknoten wählen
- `]f` / `[f` – zur nächsten / vorigen **Funktion** springen
- `]a` / `[a` – zum nächsten / vorigen **Argument**
- `mi` / `ma` + Objekt – **i**nnen / **a**ußen auswählen (`miw` Wort, `mi(` Klammerinhalt, `maf` ganze Funktion)

> [!example]- Übung 4 – vom Wort zur ganzen Funktion
> Öffne eine `.py`-Datei mit:
> ```python
> def gruss(name):
>     return f"Hallo {name}"
> ```
> 1. Cursor irgendwo in `name` setzen, `miw` – das Wort ist markiert.
> 2. `Alt-o` – Auswahl springt auf die umschließenden Klammern/den Ausdruck.
> 3. Nochmal `Alt-o`, `Alt-o` … – die Auswahl wächst Schritt für Schritt bis zur ganzen Funktion.
> 4. `Alt-i` macht den Schritt rückgängig.
>
> Das funktioniert sprachübergreifend, weil Helix den Syntaxbaum kennt.

---

## 4 Surround – ohne Plugin

Was bei Vim das Plugin `vim-surround` ist, kann Helix von Haus aus, im `m`-Modus:

- `ms` + Zeichen – aktuelle Auswahl umschließen (`ms"` → in Anführungszeichen)
- `mr` + alt + neu – Umschließung ersetzen (`mr([` macht `(…)` zu `[…]`)
- `md` + Zeichen – Umschließung entfernen (`md"`)
- `mm` – zur passenden Klammer springen

> [!example]- Übung 5 – Wörter in Anführungszeichen, alle auf einmal
> ```
> rot grün blau
> ```
> 1. `%` alles wählen, `s`, dann `\w+` tippen, `Enter` – ein Cursor pro Wort.
> 2. `ms"` – jedes Wort wird in `"` gesetzt: `"rot" "grün" "blau"`.
>
> Mehrfach-Cursor + Surround in zwei Schritten.

---

## 5 Code-Intelligenz mit LSP

Helix spricht ab Werk das Language Server Protocol – kein Plugin, keine Hunderte Zeilen Konfiguration. Du brauchst nur den passenden Server installiert (z. B. `pyright`/`ruff` für Python, `rust-analyzer` für Rust, `typescript-language-server` für JS/TS). Prüfen mit `hx --health <sprache>`.

- `gd` – zur **Definition** springen
- `gr` – alle **Referenzen** anzeigen
- `gy` / `gi` – Typdefinition / Implementierung
- `Space k` – **Doku** zum Symbol unter dem Cursor (Hover)
- `Space r` – **Symbol umbenennen** (projektweit, sauber)
- `Space a` – **Code-Aktion** anwenden (Quickfix, Import ergänzen …)
- `Space s` / `Space S` – Symbole im Dokument / Workspace durchsuchen
- `]d` / `[d` – zur nächsten / vorigen **Diagnose** (Fehler/Warnung)

> [!tip] `Space r` schlägt jedes Suchen-&-Ersetzen
> Umbenennen über den LSP versteht Geltungsbereiche und benennt nur das *echte* Symbol um – nicht zufällige Textgleichheit. Für sicheres Refactoring der bessere Weg als Mehrfach-Cursor.

---

## 6 Pickers & das Space-Menü

Der fuzzy Picker ersetzt Plugins wie fzf/Telescope – eingebaut und konsistent.

- `Space f` – **Datei-Picker** (fuzzy, im Projekt-Root)
- `Space b` – **Buffer-Picker** (offene Dateien)
- `Space /` – **globale Suche** im Projektordner
- `Space '` – zuletzt genutzten Picker erneut öffnen
- `Space ?` – **Befehlspalette** (alle Kommandos durchsuchbar)
- `gn` / `gp` – nächster / voriger Buffer

Tasten *innerhalb* eines Pickers:

| Taste | Funktion |
|---|---|
| `Tab` / `Shift-Tab` | nächster / voriger Eintrag |
| `Strg-s` | Auswahl waagerecht öffnen |
| `Strg-v` | Auswahl senkrecht öffnen |
| `Strg-t` | Vorschau ein/aus |
| `Enter` | öffnen · `Esc` schließen |

> [!note] Eingebaute Entdeckbarkeit
> Drückst du `g`, `m`, `Space`, `z` oder `Strg-w` und wartest kurz, blendet Helix ein Menü mit allen verfügbaren Folgetasten ein. Man muss die Keymap also nicht auswendig lernen – sie zeigt sich beim Tippen. Genau das macht den Einstieg schnell.

---

## 7 Auswahlen verbiegen – die Profi-Rezepte

Hier glänzt das Auswahlmodell. Alles wirkt auf *alle* aktuellen Auswahlen.

- `Alt-s` – an Zeilenumbrüchen splitten (eine Auswahl pro Zeile)
- `S` – Auswahl an Regex-Treffern in Teilauswahlen splitten
- `K` / `Alt-K` – nur Auswahlen behalten / entfernen, die ein Regex matchen
- `_` – Leerraum aus den Auswahlen trimmen
- `&` – Auswahlen spaltenbündig ausrichten
- `(` / `)` – zwischen den Cursorn rotieren

> [!example]- Übung 6 – Spalten ausrichten
> ```
> name = alice
> alter = 30
> stadt = magdeburg
> ```
> 1. `%` alles wählen, `Alt-s` – ein Cursor pro Zeile.
> 2. `s`, dann `=` tippen, `Enter` – Cursor auf jedem `=`.
> 3. `&` – die `=` stehen jetzt bündig untereinander.

> [!example]- Übung 7 – nur passende Zeilen behalten
> ```
> FEHLER: Platte voll
> INFO: alles ok
> FEHLER: Netzwerk weg
> INFO: Start
> ```
> 1. `%` alles, `Alt-s` (ein Cursor pro Zeile).
> 2. `K`, dann `FEHLER` tippen, `Enter` – nur die FEHLER-Zeilen bleiben ausgewählt.
> 3. Jetzt z. B. `d` zum Löschen oder `Space y` zum Kopieren der gefilterten Zeilen.

---

## 8 Shell-Integration

Auswahlen lassen sich direkt durch ein externes Programm schicken – ein unterschätztes Werkzeug.

- `|` – jede Auswahl durch ein Shell-Kommando leiten, Ausgabe **ersetzt** die Auswahl
- `!` – Kommando ausführen, Ausgabe **vor** der Auswahl einfügen
- `Alt-!` – Ausgabe **nach** der Auswahl einfügen
- `$` – Auswahlen behalten, bei denen das Kommando mit Code 0 endet (filtern)

> [!example]- Übung 8 – sortieren ohne den Editor zu verlassen
> Markiere ein paar Zeilen (`%` oder mehrfach `x`), dann `|`, tippe `sort`, `Enter` – die Zeilen kommen sortiert zurück.
>
> Das Kommando läuft über die System-Shell (unter Windows PowerShell/`cmd`, unter Linux deine Login-Shell). Passe es entsprechend an, z. B. `Sort-Object` in PowerShell.

---

## 9 Vim → Helix: Reflexe umtrainieren

Wenn die Finger Vim gewohnt sind, hilft diese Gegenüberstellung am meisten.

| Aufgabe | Vim | Helix |
|---|---|---|
| Wort löschen | `dw` | `wd` |
| Wort ändern | `cw` | `wc` (oder `miwc`) |
| Zeile löschen | `dd` | `xd` |
| Zeile kopieren | `yy` | `xy` |
| ans Zeilenende | `$` | `gl` |
| an den Zeilenanfang | `0` / `^` | `gh` / `gs` |
| Datei-Ende | `G` | `ge` |
| zu Zeile 10 | `10G` | `10G` *(gleich)* |
| Wiederherstellen | `Strg-r` | `U` |
| alles ersetzen | `:%s/a/b/g` | `%` `s` `a` ↵ `c` `b` `Esc` |
| passende Klammer | `%` | `mm` |
| ganze Datei wählen | `ggVG` | `%` |
| Visual-Modus | `v` | `v` *(erweitert statt ersetzt)* |
| umschließen | `ysiw"` *(Plugin)* | `miw` `ms"` |
| Makro | `qa … q` / `@a` | `Qa … Q` / `q` |

> [!tip] Lerntempo
> Die ersten Tage fühlen sich `wd` statt `dw` falsch an. Nach ein bis zwei Tagen kippt es – und das ständige *Sehen* der Auswahl fängt an, sich überlegen anzufühlen, gerade bei Mehrfach-Cursor.

---

## 10 Start-Konfiguration

Eine Datei genügt. Unter Windows: `%AppData%\helix\config.toml`.

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
> Formatter, Language-Server und Einrückung pro Sprache regelst du in `%AppData%\helix\languages.toml`. `hx --health <sprache>` sagt dir, was noch fehlt.

---

## Wohin als Nächstes

- `:tutor` noch einmal durchspielen – jetzt mit anderem Blick auf die Auswahl-Logik.
- `Space ?` (Befehlspalette) öffnen und einfach stöbern.
- Eigene Keymap in `config.toml` ergänzen, wenn ein Reflex partout nicht umlernen will.
- Den Spickzettel (PDF) daneben legen – dieses Tutorial vertieft genau dessen Blöcke.

> [!quote] Kerngedanke
> Helix' Stärke ist nicht eine einzelne Funktion, sondern dass Mehrfach-Cursor, Tree-sitter, LSP und Surround **alle dieselbe Auswahl-Sprache sprechen** – und ohne Plugin-Bauerei sofort zusammenspielen.

---

## Spickzettel (PDF)

| Blatt | Umfang |
| --- | --- |
| [[Helix_Spickzettel_A4.pdf]] | eine A4-Seite, Grundbefehle, gleiches Raster wie das Vim-Blatt |
| [[Helix_Spickzettel_A4_erweitert.pdf]] | zwei A4-Seiten, zusätzlich Mehrfach-Cursor, Match & Surround, LSP, Fenster, Picker, Register, Rezepte |
| [[Vim_Spickzettel_A4.pdf]] | eine A4-Seite, Vim zum Vergleich |

## Verwandt

- [[2026-09-22 Vim Helix Spickzettel Tutorial]] – Protokoll zur Entstehung der Blätter und dieses Tutorials
- [[helix-tutor-de]] – deutsche Fassung des eingebauten `:tutor`
- [[Migrating from Vim]]
- [[Nushell Editor setzen]] – Helix als `$EDITOR`
