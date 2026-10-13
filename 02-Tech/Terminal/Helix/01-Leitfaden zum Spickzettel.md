---
title: "Helix – Leitfaden zum Spickzettel"
aliases:
  - Helix-Leitfaden
  - Helix Leitfaden
  - Helix Befehle erklärt
tags:
  - helix
  - editor
  - terminal
  - schulung
zielgruppe: Fachinformatiker FISI / FIAE
helix-version: "25.x"
begleitmaterial: "[[Helix_Spickzettel_A4_erweitert.pdf]]"
created: 2026-09-23
updated: 2026-10-13
status: active
type: leitfaden
---

# Helix – Leitfaden zum Spickzettel

Dieser Leitfaden erklärt die acht Grafiken des zweiseitigen Spickzettels im Zusammenhang, mit **„So liest du die Grafik“** und kurzen Übungen mit aufklappbaren Lösungen. Die allgemeine Befehlsreferenz – auch zu Themen ohne eigene Grafik – steht im [[02-Cookbook|Helix-Cookbook]].

> [!info] Begleitmaterial
> - Spickzettel: [[Helix_Spickzettel_A4_erweitert.pdf]] (Seite 1: Grundlagen, Seite 2: Fortgeschritten)
> - Die Grafiken liegen einzeln als SVG in `_resources/` neben dieser Notiz und werden hier eingebettet.
> - Schreibweise: `^` bzw. `Strg` = Ctrl, `Alt` = ⌥ (Option), `Space` = Leertaste, `⏎` = Enter.
> - ● hinter einem Befehl bedeutet: Language Server oder Tree-sitter-Grammatik nötig.

> [!tip] Vor dem Start
> - `hx --tutor` öffnet das eingebaute Tutorial – ideal als Einstieg vor diesem Leitfaden.
> - `hx --health` zeigt, welche Sprachen Syntax-Highlighting, Language Server und Textobjekte unterstützen. Fehlt dort ein ✓, funktionieren die mit ● markierten Befehle für diese Sprache nicht.

## Inhalt

1. [[#1 Das Grundprinzip Auswahl → Aktion]]
2. [[#2 Die Modi]]
3. [[#3 Bewegen ist Auswählen – der Kompass]]
4. [[#4 word vs. WORD]]
5. [[#5 Zeichen finden mit f und t]]
6. [[#6 Einfügen – wo landet der Cursor?]]
7. [[#7 Match & Surround]]
8. [[#8 Fenster und Ansicht]]

---

## 1 Das Grundprinzip Auswahl → Aktion

In Vim sagt man zuerst **was man tun will** und dann **worauf**: `d3w` = „lösche drei Wörter“.
In Helix ist es umgekehrt: Zuerst wird **ausgewählt**, dann **gehandelt**. Man sieht also vor dem Löschen, was gelöscht wird.

| Baustein | Beispiel | Bedeutung | Pflicht? |
|---|---|---|---|
| Modus | `v` | Auswahl erweitern statt ersetzen | optional |
| Anzahl | `3` | wie oft die Bewegung ausgeführt wird | optional |
| Auswahl | `w` | Bewegung oder Textobjekt | ja |
| Aktion | `d` | Operator, der auf die Auswahl wirkt | ja |

> [!example] Drei Wörter löschen
> `3w` wählt drei Wörter aus – sie werden farbig hervorgehoben. Erst `d` löscht sie.
> Ist die Auswahl falsch, drückt man einfach eine andere Bewegung; es ist noch nichts passiert.

> [!important] Die wichtigste Denkregel
> **Der Cursor ist immer eine Auswahl** – im einfachsten Fall ein einzelnes Zeichen. Jede Aktion wirkt auf die aktuelle Auswahl. Wer sich das merkt, versteht fast alle weiteren Befehle.

> [!warning] Falle für Vim-Umsteiger
> - `U` ist **Redo**, nicht „Zeile wiederherstellen“.
> - `x` wählt die **Zeile** aus, löscht aber kein Zeichen. Löschen ist immer `d`.
> - `f`/`t` wirken **über Zeilengrenzen** hinweg.

---

## 2 Die Modi

![[helix-modi.svg|620]]

> [!abstract] So liest du die Grafik
> - **Mitte (dunkel):** Der Normalmodus ist die Zentrale. Hier bewegt man sich, wählt aus und löst Aktionen aus.
> - **Die drei Kästen außen** sind Modi, in denen man bleibt, bis man sie verlässt. Die Beschriftung am Pfeil **zum** Kasten ist die Taste für den Einstieg, die am Pfeil **zurück** die Taste für den Ausstieg.
> - **Der gestrichelte Kasten** listet die *Untermodi*: Man drückt die Präfix-Taste, dann **eine** weitere Taste, und ist sofort wieder im Normalmodus. Nach dem Präfix zeigt Helix unten rechts ein Menü mit allen Möglichkeiten.

| Modus | Einstieg | Ausstieg | Wofür |
|---|---|---|---|
| Einfügemodus | `i` `a` `I` `A` `o` `O` `c` | `Esc` | Text tippen |
| Auswahlmodus | `v` | `v` oder `Esc` | Bewegungen **erweitern** die Auswahl |
| Befehlsmodus | `:` | `⏎` (ausführen) oder `Esc` | Kommandos wie `:w`, `:q`, `:set` |

> [!tip] Das Menü nach dem Präfix
> Wer eine Taste vergessen hat, drückt nur das Präfix – `g`, `m`, `z`, `Space` oder `Strg-w` – und liest im eingeblendeten Menü nach. `Space ?` öffnet zusätzlich die durchsuchbare **Befehlspalette** mit allen Kommandos.

> [!question]- Übung 2.1 – Welcher Modus?
> Du willst am Ende der aktuellen Zeile ein Semikolon anfügen und danach speichern. Welche Tastenfolge?
>
> > [!success]- Lösung
> > `A` `;` `Esc` `:w` `⏎` – `A` springt ans Zeilenende in den Einfügemodus, `Esc` zurück in den Normalmodus, `:w` speichert.

---

## 3 Bewegen ist Auswählen – der Kompass

![[helix-bewegung-kompass.svg|700]]

> [!abstract] So liest du die Grafik
> - **Der Punkt in der Mitte** ist die Cursorposition.
> - **Waagerechter Pfeil:** Bewegungen innerhalb der Zeile. Je weiter eine Taste vom Mittelpunkt entfernt ist, desto **größer der Sprung**: `h`/`l` ein Zeichen, `b`/`w`/`e` ein Wort, `B`/`W`/`E` ein WORD, `gh`/`gl` bis zum Zeilenrand.
> - **Senkrechter Pfeil:** Bewegungen durch die Datei, ebenfalls nach Reichweite sortiert: `k`/`j` eine Zeile, `^u`/`^d` eine halbe Seite, `^b`/`^f` eine Seite, `gg`/`ge` Anfang und Ende der Datei.
> - **Die vier Ecken** ergänzen Sprünge, die nicht in eine Richtung passen: Bildschirmposition (`gt` `gc` `gb`), „zuletzt …“-Sprünge (`g.` `ga` `gm` `gw`), Zähler und die Merkregel.

### Warum der Titel „Bewegen = Auswählen“?

Die Wort-Bewegungen `w` `b` `e` (und groß `W` `B` `E`) **wählen den überstrichenen Text aus**. Ein direkt folgendes `d` löscht genau diesen Text. Einzelzeichen-Bewegungen `h` `j` `k` `l` wählen dagegen nichts aus.

| Befehl | Wirkung |
|---|---|
| `w` | zum Anfang des nächsten Wortes, Wort wird ausgewählt |
| `e` | zum Ende des Wortes, Wort wird ausgewählt |
| `b` | zum Anfang des vorigen Wortes |
| `gs` | zum ersten Zeichen der Zeile, **ohne** Einrückung |
| `gh` / `gl` | Zeilenanfang / Zeilenende |
| `gg` / `ge` | erste / letzte Zeile |
| `10G` oder `:10` | zu Zeile 10 |
| `gw` | Sprungmarken: Helix blendet zweibuchstabige Marken ein, man tippt die Marke des Ziels |
| `g.` | zur letzten Änderung |
| `ga` / `gm` | zuletzt besuchte / zuletzt geänderte Datei |

> [!tip] Zähler
> Fast jede Bewegung nimmt eine Zahl davor: `5j` = fünf Zeilen runter, `3w` = drei Wörter auswählen.

### Auswahl-Grundlagen (Leiste unter dem Kompass)

| Befehl | Wirkung |
|---|---|
| `x` | aktuelle Zeile auswählen, jedes weitere `x` nimmt die nächste Zeile dazu |
| `X` | Auswahl auf ganze Zeilen erweitern |
| `%` | ganze Datei auswählen |
| `;` | Auswahl auf den Cursor zusammenziehen |
| `Alt-;` | Anker und Cursor tauschen (die Auswahl wächst dann am anderen Ende) |
| `,` | bei mehreren Auswahlen nur die Haupt-Auswahl behalten |
| `v` | Auswahlmodus ein/aus |

> [!question]- Übung 3.1 – Auswahl erweitern
> Der Cursor steht am Anfang von `alpha beta gamma delta`. Du willst `alpha beta gamma` löschen – aber **ohne Zähler**.
>
> > [!success]- Lösung
> > `v` `e` `e` `e` `d` – ohne `v` würde jedes `e` die Auswahl **ersetzen**, mit `v` wird sie **erweitert**.

---

## 4 word vs. WORD

![[helix-word-vs-WORD.svg|420]]

> [!abstract] So liest du die Grafik
> Dieselbe URL, zweimal gezählt:
> - **Unten** die kleinen Balken: Für `w` `b` `e` ist jede Folge aus Buchstaben, Ziffern und `_` ein eigenes *word*, und jede Satzzeichengruppe ebenfalls. Die URL besteht aus **9 words**.
> - **Oben** die Klammer: Für `W` `B` `E` zählt alles bis zum nächsten Leerzeichen als **ein WORD**.

> [!tip] Faustregel
> Kleinbuchstaben für Code **innerhalb** eines Bezeichners, Großbuchstaben, um Pfade, URLs oder Ausdrücke wie `foo.bar()` in einem Rutsch zu überspringen.

---

## 5 Zeichen finden mit f und t

![[helix-f-t-suchen.svg|420]]

> [!abstract] So liest du die Grafik
> - Der Cursor steht auf `c` (hell hinterlegt).
> - **Petrol-Balken `f,`**: wählt bis **einschließlich** des nächsten Kommas aus.
> - **Oranger Balken `t,`**: wählt bis **vor** das Komma aus („till“).
> - `F` und `T` suchen rückwärts. Anders als in Vim suchen alle vier auch über das Zeilenende hinaus.

| Befehl | Wirkung |
|---|---|
| `f` *z* | bis einschließlich Zeichen *z* |
| `t` *z* | bis vor Zeichen *z* |
| `F` *z* / `T` *z* | dasselbe rückwärts |
| `t⏎` | bis zum Zeilenende |
| `Alt-.` | letzte `f`/`t`-Bewegung wiederholen |

> [!question]- Übung 5.1
> In `call(foo, bar)` steht der Cursor auf `c`. Ersetze `call(foo` durch `run(foo`.
>
> > [!success]- Lösung
> > `t(` wählt `call`, dann `c` `run` `Esc`.

---

## 6 Einfügen – wo landet der Cursor?

![[helix-einfuegepositionen.svg|460]]

> [!abstract] So liest du die Grafik
> - Die Zeile ist eingerückt, das `x` ist die aktuelle Auswahl (hell hinterlegt).
> - Die Striche **über** der Zeile zeigen, wo der Einfügemodus beginnt: `I` am ersten Zeichen **nach** der Einrückung, `i` vor der Auswahl, `a` nach der Auswahl, `A` am Zeilenende.
> - `O` und `o` links öffnen eine neue Zeile darüber bzw. darunter.
> - `c` ist die Kombination aus „Auswahl löschen“ und `i`.

> [!note] Im Einfügemodus
> | Befehl | Wirkung |
> |---|---|
> | `Strg-x` | Autovervollständigung |
> | `Strg-r` *x* | Inhalt von Register *x* einfügen |
> | `Strg-s` | Undo-Checkpoint setzen (ein späteres `u` springt nur bis hierher zurück) |
> | `Strg-w` | Wort rückwärts löschen |

---

## 7 Match & Surround

![[helix-surround-textobjekte.svg|440]]

> [!abstract] So liest du die Grafik
> - Der Cursor steht auf dem `h` in `"hi there"`.
> - Jeder Balken zeigt, was die Befehlsfolge darunter auswählt. Je **tiefer** der Balken, desto **weiter außen** die Auswahl.
> - `mi"` = **inside** (innen, ohne Anführungszeichen), `ma"` = **around** (einschließlich Anführungszeichen).
> - `mi(` und `ma(` wirken genauso auf die runden Klammern – obwohl der Cursor gar nicht direkt an einer Klammer steht. Helix sucht das nächste umschließende Paar.

### Textobjekte nach `mi` bzw. `ma`

| Taste | Objekt | | Taste | Objekt |
|---|---|---|---|---|
| `w` | Wort | | `f` | Funktion ● |
| `W` | WORD | | `c` | Klasse / Typ ● |
| `p` | Absatz | | `a` | Argument / Parameter ● |
| `(` `[` `{` `"` `'` | das jeweilige Paar | | `o` | Kommentar ● |
| `m` | nächstes umschließendes Paar, egal welches | | `t` | Test ● |
| | | | `g` | Änderung (Git-Diff) |

### Surround-Befehle

| Befehl | Wirkung |
|---|---|
| `mm` | zur passenden Klammer springen ● |
| `ms(` | Auswahl mit `( )` umschließen |
| `mr([` | umschließendes `( )` durch `[ ]` ersetzen |
| `md"` | umschließende `" "` entfernen |

> [!question]- Übung 7.1
> Aus `print(name)` soll `print("name")` werden. Der Cursor steht irgendwo auf `name`.
>
> > [!success]- Lösung
> > `miw` wählt `name`, `ms"` umschließt es mit Anführungszeichen. Alternativ `mi(` statt `miw`, falls der Klammerinhalt länger ist.

> [!question]- Übung 7.2
> Lösche den kompletten Funktionsaufruf-Inhalt von `f(x, "hi there")`, also `x, "hi there"`, und tippe stattdessen `y`.
>
> > [!success]- Lösung
> > `mi(` `c` `y` `Esc`

> [!example] Surround kombiniert mit Mehrfachauswahl
> `rot grün blau` → `"rot" "grün" "blau"`: `%` alles wählen, `s` `\w+` `⏎` wählt jedes Wort einzeln (siehe [[05 Mehrfachauswahl]] im Cookbook), `ms"` umschließt **alle gleichzeitig** mit Anführungszeichen.

---

## 8 Fenster und Ansicht

### Fenster

![[helix-fenster.svg|380]]

> [!abstract] So liest du die Grafik
> - Das Rechteck in der Mitte ist der Bildschirm mit vier geteilten Fenstern, das hervorgehobene ist das aktive.
> - Die vier Beschriftungen zeigen, **in welche Richtung** man mit `Strg-w` + `h` `j` `k` `l` wechselt – dieselben Richtungen wie beim Cursor.
> - Mit **Großbuchstaben** `H` `J` `K` `L` wird das aktive Fenster in diese Richtung **verschoben**.
> - `Strg-w` und `Space w` sind gleichwertige Präfixe.

| Befehl | Wirkung |
|---|---|
| `Strg-w v` / `Strg-w s` | senkrecht / waagerecht teilen |
| `Strg-w q` | Fenster schließen |
| `Strg-w o` | alle anderen Fenster schließen |
| `:vs datei` / `:hs datei` | Datei in senkrechtem / waagerechtem Split öffnen |
| `:vnew` / `:hnew` | leeren Buffer im Split öffnen |

> [!example]- Tipp aus dem Spickzettel: Fenster wechseln ohne Präfix
> In `~/.config/helix/config.toml` (öffnen mit `:config-open`):
> ```toml
> [keys.normal]
> C-h = "jump_view_left"
> C-j = "jump_view_down"
> C-k = "jump_view_up"
> C-l = "jump_view_right"
> ```
> Danach `:config-reload`. Achtung: `Strg-l` ist damit nicht mehr frei für andere Belegungen.

### Ansicht mit `z` und `Z`

![[helix-ansicht-z.svg|420]]

> [!abstract] So liest du die Grafik
> Drei Mal derselbe Bildschirm. Die orange Zeile ist die Zeile mit dem Cursor. `zt` schiebt sie nach **oben**, `zz` in die **Mitte**, `zb` nach **unten**. Der Cursor bleibt dabei in derselben Textzeile – es bewegt sich nur der sichtbare Ausschnitt.

| Befehl | Wirkung |
|---|---|
| `zk` / `zj` | Ansicht zeilenweise scrollen, Cursor bleibt |
| `z ^f` / `z ^b` | eine Seite runter / hoch |
| `z ^d` / `z ^u` | halbe Seite runter / hoch |
| `Z` … | **Sticky**: bleibt im Ansichtsmodus, `z` muss nicht wiederholt werden; `Esc` beendet |

> [!example] Langen Code überfliegen
> `Z` `j` `j` `j` `j` `^f` `^f` `Esc` – ohne jedes Mal `z` zu tippen.

---

## Anhang: Grafiken in Obsidian verwenden

Die Grafiken liegen als SVG-Dateien vor und lassen sich überall im Vault einbetten.

| Datei | Thema |
|---|---|
| `helix-modi.svg` | Modi & Übergänge |
| `helix-bewegung-kompass.svg` | Bewegen = Auswählen |
| `helix-word-vs-WORD.svg` | word vs. WORD |
| `helix-f-t-suchen.svg` | Zeichen finden mit f / t |
| `helix-einfuegepositionen.svg` | Einfügepositionen |
| `helix-surround-textobjekte.svg` | Match & Surround |
| `helix-fenster.svg` | Fenster wechseln |
| `helix-ansicht-z.svg` | Ansicht zt / zz / zb |

**Einbetten:**

```markdown
![[helix-modi.svg]]          ← volle Breite
![[helix-modi.svg|400]]      ← 400 Pixel breit
```

**Einzelne PDF-Seite des Spickzettels einbetten:**

```markdown
![[Helix_Spickzettel_A4_erweitert.pdf#page=1]]
![[Helix_Spickzettel_A4_erweitert.pdf#page=2]]
```

> [!note] Dunkles Theme
> Die SVGs haben einen hellen Hintergrund eingebaut und bleiben deshalb auch im dunklen Obsidian-Theme lesbar. Die Schriften *IBM Plex Sans* und *JetBrains Mono* werden verwendet, wenn sie installiert sind, sonst eine Systemschrift.

> [!note] Ablage im Vault
> Die Links funktionieren unabhängig vom Ordner, solange die Dateinamen im Vault eindeutig sind. In diesem Vault liegen Leitfaden und die übrigen Helix-Notizen in `02-Tech/Terminal/Helix/`, alle Anhänge – SVGs und PDFs – im Unterordner `_resources/`, siehe [[Struktur-Übersicht]].

---

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – allgemeine Befehlsreferenz als Rezepte, auch zu Themen ohne eigene Grafik hier (Mehrfachauswahl, LSP, Shell, Register, Suchen & Ersetzen, Vim-Umstieg …)
- [[03-Installation]] – Installation und Startkonfiguration
- [[Helix_Spickzettel_A4_erweitert.pdf]] – der Spickzettel, den dieser Leitfaden erklärt
- [[Helix_Spickzettel_A4.pdf]] – einseitige Kurzfassung, [[Vim_Spickzettel_A4.pdf]] zum Vergleich
- [[helix-tutor-de]] – deutsche Fassung des eingebauten `:tutor`
- [[Nushell Editor setzen]] – Helix als `$EDITOR`
