---
title: "Yazi – Leitfaden zum Spickzettel"
aliases:
  - Yazi Leitfaden
  - Yazi Befehle erklärt
tags:
  - yazi
  - terminal
  - dateimanager
  - schulung
system: Fedora Sway Atomic
yazi_version: "26.9.1"
begleitmaterial: "[[yazi-spickzettel.pdf]]"
created: 2026-09-23
updated: 2026-09-23
status: active
type: leitfaden
---

# Yazi – Leitfaden zum Spickzettel

Dieser Leitfaden erklärt die Grafiken und Befehlsblöcke des zweiseitigen Yazi-Spickzettels im Zusammenhang – analog zu [[Helix-Leitfaden]]. Wer Helix kennt, erkennt das Grundprinzip sofort wieder: **erst auswählen, dann handeln.**

> [!info] Begleitmaterial
> - Spickzettel: [[yazi-spickzettel.pdf]] (Seite 1: Grundlagen, Navigation & Dateien; Seite 2: Suchen, Tabs, Sortieren & Konfiguration)
> - Die beiden Seiten liegen zusätzlich einzeln als SVG in `_resources/` und werden unten eingebettet.
> - Schreibweise: `Strg` = Ctrl, **orange** Tasten/Kästen = eigene Belegung (Plugins/Skripte), nicht Yazi-Standard.
> - Ausführliche Erklärung von Konfiguration, Plugins und Setup: [[Yazi – kommentierter Leitfaden]], [[Yazi – Installation und Plugins]].

> [!tip] Vor dem Start
> `~` oder `F1` zeigt in Yazi selbst alle Tastenbelegungen der installierten Version – die verlässlichste Referenz, wenn etwas abweicht.

## Inhalt

1. [[#1 Das Grundprinzip Auswahl → Aktion]]
2. [[#2 Die Oberfläche Drei Spalten]]
3. [[#3 Navigation]]
4. [[#4 Auswählen und markieren]]
5. [[#5 Kopieren Verschieben Löschen]]
6. [[#6 Dateien anlegen und umbenennen]]
7. [[#7 Yazi starten und verlassen]]
8. [[#8 Suchen und Springen nach Reichweite]]
9. [[#9 Präfixtasten g m c t e]]
10. [[#10 Tabs]]
11. [[#11 Pfade in die Zwischenablage]]
12. [[#12 Zeilenmodus und Sortieren]]
13. [[#13 Konfiguration und Shell-Wrapper]]
14. [[#14 Plugins und Aufgaben-Fenster]]
15. [[#15 Rezepte]]

---

## 1 Das Grundprinzip: Auswahl → Aktion

![[yazi-spickzettel-seite1.svg|700]]

> [!abstract] So liest du Seite 1
> - **Oben rechts** steht das Modell in Worten: erst **Auswahl**, dann **Aktion** – wie bei Helix.
> - Der Block **„Erst Auswahl, dann Aktion“** zeigt es als Diagramm: `Space`/`v` (Auswahl, optional) fließt in `d r y x` (Aktion, wirkt auf die Auswahl).
> - Darunter **„Kopieren / Verschieben in 4 Schritten“**: markieren (`Space`) → vormerken (`y`/`x`) → Ziel öffnen (`l h z`) → einfügen (`p`/`P`).
> - Die vier großen Kacheln in der Mitte der Seite (Navigation, Auswählen, Dateien, Öffnen/Eingabefelder/Shell) sind das ausführliche Nachschlagewerk zu genau diesem Prinzip.

| Baustein | Beispiel | Bedeutung | Pflicht? |
|---|---|---|---|
| Auswahl | `Space` an mehreren Dateien | Dateien markieren | optional |
| Auswahl | *(keine)* | Cursor-Datei gilt als Auswahl | – |
| Aktion | `d` `r` `y` `x` | wirkt auf **alle** markierten Dateien | ja |

> [!important] Die wichtigste Denkregel
> **Ohne Markierung zählt die Datei unter dem Cursor.** Eine Aktion wie `y` (kopieren) oder `d` (löschen) betrifft entweder die Markierung oder – falls nichts markiert ist – nur diese eine Datei. Das ist dasselbe Prinzip wie Helix' „Cursor ist immer eine Auswahl“, siehe [[Helix-Leitfaden#1 Das Grundprinzip Auswahl → Aktion]].

> [!question]- Übung 1.1 – Markieren oder nicht?
> Du willst nur `bericht.md` löschen, `daten.csv` daneben soll bleiben. Musst du `bericht.md` erst mit `Space` markieren?
>
> > [!success]- Lösung
> > Nein. Steht der Cursor auf `bericht.md` und ist sonst nichts markiert, wirkt `d` nur auf diese eine Datei. `Space` braucht man erst, wenn **mehrere** Dateien auf einmal betroffen sein sollen.

---

## 2 Die Oberfläche: Drei Spalten

> [!abstract] So liest du die Grafik „Oberfläche · Drei Spalten (Miller Columns)“
> - **Links:** Elternverzeichnis, das aktuelle Verzeichnis (`kurs/`) ist darin hervorgehoben.
> - **Mitte:** Inhalt des aktuellen Verzeichnisses. Die markierte Zeile `daten.csv` und `skript.py` trägt einen orangen Strich – das ist die `Space`-Markierung, nicht die Cursor-Position.
> - **Rechts:** Vorschau der Cursor-Datei (`bericht.md`), bei Markdown gerendert.
> - **Unten:** Statuszeile – Modus (`NOR`), Dateiname und Größe links, Rechte in der Mitte, Position `3/6` rechts.
> - **Tabs** oben rechts im Kopf der Spalte (`1 kurs`, `2 Downloads`) zeigen, dass mehrere Verzeichnisse gleichzeitig offen sind, siehe [[#10 Tabs]].

Dieses Drei-Spalten-Layout (Miller Columns) ist die Grundlage für alles Weitere: **eine Aktion wirkt immer auf die mittlere Spalte**, `h`/`l` wandert zwischen den Spalten.

---

## 3 Navigation

> [!abstract] So liest du die Grafik „drei Spalten“ unter der Oberflächen-Grafik
> - Der Punkt in der Mitte ist der Cursor, die Pfeile zeigen die beiden Bewegungsrichtungen: **waagerecht** `h`/`l` zwischen den Spalten, **senkrecht** (Tabelle darunter) `j`/`k` innerhalb der aktuellen Spalte.
> - `l` hat eine Doppelrolle: Ordner **betreten** oder Datei **öffnen** – Yazi entscheidet anhand des Dateityps (Plugin `smart-enter`, orange markiert).

| Befehl | Wirkung |
|---|---|
| `j` / `k` | nächste / vorherige Datei (↓ ↑) |
| `l` / `h` | hinein bzw. Datei öffnen / eine Ebene höher (→ ←) |
| `H` / `L` | im Verlauf zurück / vor |
| `gg` / `G` | Anfang / Ende der Liste |
| `Ctrl+u` / `Ctrl+d` | halbe Seite hoch / runter |
| `Ctrl+b` / `Ctrl+f` | ganze Seite hoch / runter |
| `K` / `J` | Vorschau hoch / runter |
| `Tab` | Details (Spot), `h`/`l` wechselt zur Nachbardatei |
| `T` | Vorschau maximieren / zurück *(eigene Belegung)* |

> [!tip] Vim-Tasten mit Doppelrolle
> `h j k l` bewegen wie in Vim/Helix – mit dem Unterschied, dass `h`/`l` hier **Spalten** wechseln statt Zeichen. Wer `w`/`b`/`e` aus Helix erwartet: Die gibt es in Yazi nicht, dafür `f` zum Filtern (siehe [[#8 Suchen und Springen nach Reichweite]]).

### Feste Sprungziele (Präfix `g`)

| Befehl | Ziel |
|---|---|
| `g h` | Home `~` |
| `g c` | `~/.config` |
| `g d` | Papierkorb |
| `g f` | Symlink folgen |
| `g Space` | Pfad eintippen |

---

## 4 Auswählen und markieren

> [!abstract] So liest du den Block „Auswählen“
> `Space` ist die Grundtaste: markieren **und weiterspringen** – praktisch für mehrere Dateien hintereinander. `v` startet dagegen einen **Bereich**, der sich mit `j`/`k` aufzieht, wie Helix' Auswahlmodus.

| Befehl | Wirkung |
|---|---|
| `Space` | markieren / aufheben und weiter |
| `v` | Visuell: Bereich mit `j`/`k` markieren |
| `V` | Visuell **zum Abwählen** |
| `Ctrl+a` | alle Dateien auswählen |
| `Ctrl+r` | Auswahl umkehren |
| `Esc` | Auswahl, Visuell, Suche beenden |

> [!question]- Übung 4.1 – Alle außer einer
> Im aktuellen Verzeichnis liegen zehn Dateien. Du willst neun davon kopieren, nur `README.md` soll ausgenommen bleiben. Kürzester Weg?
>
> > [!success]- Lösung
> > `Ctrl+a` markiert alle zehn, Cursor auf `README.md`, `Space` hebt nur diese eine wieder auf. Dann `y` kopiert die restlichen neun.

---

## 5 Kopieren, Verschieben, Löschen

| Befehl | Wirkung |
|---|---|
| `y` / `x` | kopieren / ausschneiden (vormerken) |
| `p` / `P` | einfügen: mit Suffix bei Namenskonflikt / überschreiben |
| `Y` / `X` | Vormerken abbrechen |
| `d` / `D` | Papierkorb / **endgültig** löschen |
| `-` / `_` | Symlink anlegen: absolut / relativ |
| `Ctrl+-` | Hardlink anlegen |

> [!warning] `D` ist endgültig
> Der Spickzettel markiert `D` bewusst rot-umrandet: **kein Papierkorb, keine Rückfrage.** `d` ist der sichere Standardweg.

> [!tip] Verschieben geht auch über Tabs
> Vormerken mit `y`/`x` bleibt beim Tab-Wechsel erhalten (siehe [[#10 Tabs]]). So kopiert oder verschiebt man zwischen weit entfernten Verzeichnissen, ohne zurückzunavigieren – das Rezept dazu steht in [[#15 Rezepte]].

---

## 6 Dateien anlegen und umbenennen

| Befehl | Wirkung |
|---|---|
| `a` | Datei anlegen; `name/` legt einen Ordner an, `a/b/c.txt` legt fehlende Verzeichnisse mit an |
| `A` | mehrere Dateien auf einmal |
| `r` | umbenennen; bei mehreren markierten Dateien öffnet sich die Massenumbenennung im Editor |

### Im Eingabefeld (`r`, `a`, `f`, `s`)

| Befehl | Wirkung |
|---|---|
| `Enter` / `Esc` | bestätigen / Normalmodus (2 × `Esc` bricht ab) |
| `i` / `a` | vor / nach Cursor einfügen |
| `Ctrl+a` / `Ctrl+e` | Zeilenanfang / -ende |
| `Ctrl+w` | Wort davor löschen |
| `Ctrl+u` / `Ctrl+k` | bis Anfang / Ende löschen |

> [!note] Vim-artiges Eingabefeld
> Das Eingabefeld kennt zusätzlich den Normalmodus mit `w b e 0 $`. Wer sich beim Umbenennen vertippt, muss also nicht alles löschen und neu tippen.

---

## 7 Yazi starten und verlassen

> [!abstract] So liest du die Grafik „Starten & Verlassen“
> Zwei Kästen mit Doppelpfeil: **Shell** (`~ $`) und **Yazi**. `y` (klein) startet Yazi aus der Shell über den Wrapper – nicht zu verwechseln mit `y` (kopieren) *innerhalb* von Yazi. Der Spickzettel weist genau darauf mit „`y` in der Shell startet, `y` in Yazi kopiert!“ ausdrücklich hin.

| Befehl | Wirkung |
|---|---|
| `yazi` | im aktuellen Verzeichnis starten |
| `y` | Start über den Shell-Wrapper (siehe [[#13 Konfiguration und Shell-Wrapper]]) |
| `q` | beenden **+** ins zuletzt geöffnete Verzeichnis wechseln (nur mit dem `y`-Wrapper) |
| `Q` | beenden **ohne** Verzeichniswechsel |
| `Ctrl+c` | Tab schließen, beim letzten Tab: beenden |
| `Ctrl+z` | pausieren, zurück mit `fg` bzw. `job unfreeze` (Nushell) |

---

## 8 Suchen und Springen nach Reichweite

> [!abstract] So liest du die Grafik „Suchen & Springen · nach Reichweite“
> Der Pfeil unten sortiert alle Sprungbefehle nach Wirkbereich: **aktuelle Liste** (`f` filtert nur Passendes) → **rekursiv ab hier** (`s` Dateinamen mit `fd`, `S` Dateiinhalte mit `ripgrep`) → **überall** (`z`/`Z` springen mit `fzf`/`zoxide` zu beliebigen Dateien/Ordnern im System).

| Befehl | Wirkung |
|---|---|
| `f` | Liste filtern (nur Passende bleiben sichtbar) |
| `/` / `?` | nächste / vorherige Übereinstimmung finden |
| `n` / `N` | nächster / voriger Treffer |
| `Ctrl+s` | Suche abbrechen |
| `s` | Dateinamen rekursiv suchen (`fd`) |
| `S` | Dateiinhalte rekursiv durchsuchen (`ripgrep`) |
| `z` / `Z` | zu Datei/Ordner (`fzf`) / häufigem Ordner (`zoxide`) springen |

> [!warning] Voraussetzung
> `s`, `S`, `z`, `Z` brauchen die externen Programme `fd`, `ripgrep`, `fzf` bzw. `zoxide` – Installation in [[Yazi – Installation und Plugins#3. Hilfsprogramme]].

> [!question]- Übung 8.1 – Welcher Befehl?
> Du suchst in allen Unterordnern eine Datei, die den Text `TODO` enthält, weißt aber nicht, wie sie heißt.
>
> > [!success]- Lösung
> > `S` (Inhalte rekursiv, ripgrep) – nicht `s`, das durchsucht nur **Namen**. Siehe auch das Rezept „Text finden & öffnen“ in [[#15 Rezepte]].

---

## 9 Präfixtasten: `g` `,` `m` `c` `t` `e`

Sechs Tasten öffnen jeweils ein Menü mit Folgetasten – Yazi blendet die Möglichkeiten nach dem Druck der ersten Taste selbst ein.

| Präfix | Bedeutung | Folgetasten |
|---|---|---|
| `g` | Springen | `h c d t f Space` |
| `,` | Sortieren | `a n m b s e r` |
| `m` | Infospalte | `s p m b o n` |
| `c` | Zwischenablage | `c d f n` |
| `t` | Tabs | neuer Tab, `r` umbenennen |
| `e` | Ordnervorschau *(eigene Belegung)* | `t + -` |

Details zu jedem Präfix stehen in den folgenden Abschnitten.

---

## 10 Tabs

> [!abstract] So liest du die Grafik „Tabs · mehrere Verzeichnisse“
> Zwei Tab-Kästen nebeneinander: **Tab 1** (`~/Projekte/kurs`) mit zwei vorgemerkten (gestrichelt-orange umrandeten) Dateien `daten.csv` und `skript.py`, ein Pfeil `x → 2 → p` zeigt zu **Tab 2** (`~/Downloads`), wo dieselben zwei Dateien bereits fett erscheinen – dort eingefügt. Der Hinweis „Vorgemerktes bleibt beim Tabwechsel erhalten“ ist die Kernaussage.

| Befehl | Wirkung |
|---|---|
| `t t` | neuer Tab (bis Yazi 25.x genügte `t` allein) |
| `t r` | Tab umbenennen |
| `1` … `9` | zu Tab 1 bis 9 wechseln |
| `[` / `]` | vorheriger / nächster Tab |
| `{` / `}` | Tab nach links / rechts verschieben |
| `Ctrl+c` | Tab schließen |

---

## 11 Pfade in die Zwischenablage

> [!abstract] So liest du die Grafik „Pfade in die Zwischenablage · c“
> Vier Balken unter dem Beispielpfad `/home/fritz/kurs/bericht.md`, von lang nach kurz: `c c` der **vollständige Pfad**, `c d` nur das **Verzeichnis**, `c f` nur der **Dateiname**, `c n` der Dateiname **ohne Endung**. Je länger der Balken, desto mehr vom Pfad landet in der Zwischenablage.

| Befehl | Kopiert |
|---|---|
| `c c` | vollständiger Pfad |
| `c d` | Verzeichnis |
| `c f` | Dateiname |
| `c n` | Dateiname ohne Endung |

> [!warning] Unter Wayland
> Einfügen, z. B. im Terminal mit `Ctrl+Shift+v`. Yazi braucht dafür unter Wayland `wl-copy` (Paket `wl-clipboard`).

---

## 12 Zeilenmodus und Sortieren

### Infospalte (Präfix `m`)

> [!abstract] So liest du die Grafik „Zeilenmodus · Infospalte · m“
> Sechs Mal dieselbe Zeile `bericht.md`, jeweils mit einer anderen Information rechts: Größe, Rechte, geändert, erstellt, Besitzer oder keine. Das ist die Spalte, die in der Datei-Liste rechts neben jedem Namen steht.

| Befehl | Zeigt |
|---|---|
| `m s` | Größe |
| `m p` | Rechte |
| `m m` | zuletzt geändert |
| `m b` | erstellt |
| `m o` | Besitzer |
| `m n` | keine Zusatzinfo |

### Sortieren (Präfix `,`)

> [!abstract] So liest du die Vergleichstabelle
> `datei10.txt` steht bei **alphabetisch** vor `datei2.txt` (weil `1` < `2` als Zeichen), bei **natürlich** (`, n`) dagegen danach – Yazi zählt die Zahl im Namen wie ein Mensch: 2 vor 10.

| Befehl | Sortiert nach |
|---|---|
| `, a` | alphabetisch |
| `, n` | natürlich (Zahlen wie ein Mensch: 2 vor 10) |
| `, m` | letzter Änderung |
| `, b` | Erstellung |
| `, s` | Größe |
| `, e` | Endung |
| `, r` | zufällig |

> [!tip] Großbuchstabe kehrt um
> `, M`, `, S`, `, N` … sortieren jeweils in umgekehrter Reihenfolge. Die Wahl gilt nur bis zum Neustart – dauerhaft steht sie als `sort_by` unter `[mgr]` in `yazi.toml`.

---

## 13 Konfiguration und Shell-Wrapper

> [!abstract] So liest du den Konfigurationsblock
> Der Dateibaum links zeigt, **wo** eine Einstellung hingehört: Verhalten und Opener in `yazi.toml`, eigene Tasten in `keymap.toml`, Aussehen in `theme.toml`. Die drei Code-Kästen rechts zeigen je ein Minimalbeispiel – **nur geänderte Werte eintragen**, den Rest liefert die Standardkonfiguration.

| Datei | Zweck |
|---|---|
| `yazi.toml` | Verhalten: versteckte Dateien, Opener, Vorschau |
| `keymap.toml` | eigene Tastenbelegungen |
| `theme.toml` | Farben, Symbole, z. B. Rundungen am Cursor |
| `init.lua` | Plugins einrichten |
| `package.toml` | Plugins, verwaltet über `ya pkg` |

> [!example] Die drei Beispiele vom Spickzettel
> ```toml
> # yazi.toml
> [mgr]
> show_hidden = true          # versteckte zeigen
>
> [opener]                    # Helix als Editor
> edit = [{ run = "hx %s", block = true, for = "unix" }]
>
> [preview]
> max_width = 1200            # Bildvorschau
> ```
> ```toml
> # keymap.toml
> [[mgr.prepend_keymap]]
> on   = "!"
> run  = 'shell "$SHELL" --block'
> desc = "Shell hier öffnen"
> ```
> ```toml
> # theme.toml – Rundungen am Cursor weg
> [indicator]
> padding = { open = "", close = "" }
> ```

Ausführliche Fassung mit allen Optionen: [[Yazi – kommentierter Leitfaden#1. Konfigurationsdateien]].

### Shell-Wrapper `y`

Der Wrapper sorgt dafür, dass die aufrufende Shell nach dem Beenden von Yazi (`q`) ins zuletzt geöffnete Verzeichnis wechselt, siehe [[#7 Yazi starten und verlassen]].

```bash
# ~/.bashrc, ~/.zshrc
function y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] \
    && builtin cd -- "$cwd" || builtin true
  command rm -f -- "$tmp"
}
```

```nu
# config.nu
def --env y [...args] {
  let tmp = (mktemp -t "yazi-cwd.XXXXXX")
  ^yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != $env.PWD and ($cwd | path exists) {
    cd $cwd
  }
  rm -fp $tmp
}
```

Editor systemweit setzen: `export EDITOR=hx` (Bash/Zsh) bzw. `$env.EDITOR = "hx"` (Nushell) – siehe [[Nushell Editor setzen]].

---

## 14 Plugins und Aufgaben-Fenster

### Installierte Plugins *(eigene Einrichtung)*

| Plugin | Wirkung |
|---|---|
| `piper` | Vorschau: `glow`, `rich` |
| `toggle-pane` | Vorschau maximieren (`T`) |
| `git` | Git-Status in der Liste |
| `eza-preview` | Ordner als Baum (`e`) |
| `smart-enter` | `l` öffnet auch Dateien |
| `chmod` · `ouch` | `c m` Rechte ändern, `C` packen |

```nu
ya pkg add autor/repo   # neuer PC
ya pkg install           # installieren
ya pkg upgrade           # aktualisieren
ya pkg list               # anzeigen
```

Einrichtung im Detail: [[Yazi – Installation und Plugins#4. Das Plugin-System]].

### Aufgaben-Fenster (`w`)

| Befehl | Wirkung |
|---|---|
| `w` | Aufgaben-Fenster öffnen (Kopieren, Löschen …) |
| `j` / `k` | nächste / vorherige Aufgabe |
| `Enter` | Ausgabe ansehen |
| `x` | Aufgabe abbrechen |
| `Esc` / `w` | Fenster schließen |

> [!note] Große Kopien laufen im Hintergrund
> Yazi bleibt währenddessen bedienbar – anders als viele grafische Dateimanager.

---

## 15 Rezepte

Diese vier Kombinationen stehen unten auf Seite 2 des Spickzettels. Sie zeigen, wie sich einzelne Befehle zu Arbeitsabläufen zusammensetzen.

> [!example] Verschieben über Tabs: `Space Space x 2 p`
> Zwei Dateien markieren, ausschneiden (`x`), zu Tab 2 wechseln, einfügen (`p`). `y` statt `x` kopiert, statt zu verschieben. Siehe [[#10 Tabs]].

> [!example] Massenumbenennung: `Ctrl+a r → Helix`
> Alle Dateien auswählen, `r` öffnet die Namen im Editor. In Helix z. B. mit Mehrfach-Cursor: `%s jpeg` `Enter` `c jpg` `Esc` `:wq` benennt alle `.jpeg` auf `.jpg` um – siehe [[Helix-Leitfaden#9 Mehrfach-Cursor]].

> [!example] Text finden & öffnen: `S TODO Enter Enter`
> `S` durchsucht Inhalte rekursiv mit ripgrep, `TODO` eintippen, `Enter` springt zum Treffer, zweites `Enter` öffnet die Datei in Helix. `Esc` beendet die Suche.

> [!example] Entpacken & Packen: `O` → „Extract here“
> `O` (Öffnen mit …) bietet bei Archiven „Extract here“ an – ouch entpackt hierher. Packen: Dateien markieren, `C`, Namen mit `.zip`/`.tar.gz` versehen.

---

## Anhang: Grafiken in Obsidian verwenden

| Datei | Inhalt |
|---|---|
| `yazi-spickzettel-seite1.svg` | Seite 1 – Grundlagen, Navigation & Dateien |
| `yazi-spickzettel-seite2.svg` | Seite 2 – Suchen, Tabs, Sortieren & Konfiguration |
| `yazi-spickzettel.pdf` | beide Seiten als Druckvorlage |

```markdown
![[yazi-spickzettel-seite1.svg]]        ← volle Breite
![[yazi-spickzettel-seite1.svg|700]]    ← 700 Pixel breit
![[yazi-spickzettel.pdf#page=2]]        ← einzelne PDF-Seite
```

> [!note] Ablage im Vault
> Leitfaden und die übrigen Yazi-Notizen liegen in `02-Tech/Terminal/Yazi/`, alle Anhänge im Unterordner `_resources/`, siehe [[Struktur-Übersicht]].

---

## Verwandt

- [[yazi-spickzettel.pdf]] – der Spickzettel, den dieser Leitfaden erklärt
- [[Yazi – kommentierter Leitfaden]] – ausführliche Konfiguration, Solarized-Light-Theme, vollständige Beispielkonfiguration
- [[Yazi – Installation und Plugins]] – Installation mit brew, Hilfsprogramme, Plugin-System
- [[Yazi – Markdown-Vorschau]] · [[Yazi – Mermaid-Diagramme]] – Vorschau-Setup im Detail
- [[Helix-Leitfaden]] – dasselbe Auswahl-→-Aktion-Prinzip, für den Editor erklärt
