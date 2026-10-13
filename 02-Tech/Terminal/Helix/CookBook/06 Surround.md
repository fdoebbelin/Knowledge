---
title: "Helix-Cookbook – Kapitel 6: Surround"
aliases:
  - Helix Cookbook Surround
tags:
  - helix
  - editor
  - cookbook
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel: [[02-Cookbook|Helix-Cookbook]]. Grafik und „So liest du die Grafik“: [[01-Leitfaden zum Spickzettel#7 Match & Surround]].

Alle Befehle hier beginnen mit `m` (für *match*). Sie brauchen keinen Cursor direkt an der Klammer – Helix sucht selbst das nächstgelegene umschließende Paar um die aktuelle Auswahl.

## Textobjekte: `mi` (innen) und `ma` (außen)

`mi` wählt **ohne** die umschließenden Zeichen, `ma` **mit**. Danach folgt ein Buchstabe für das Objekt:

| Taste | Objekt | Taste | Objekt |
|---|---|---|---|
| `w` / `W` | Wort / WORD | `(` `[` `{` `"` `'` | das jeweilige Paar |
| `p` | Absatz | `m` | nächstes umschließendes Paar, egal welches |
| `f` ● | Funktion | `c` ● | Klasse / Typ |
| `a` ● | Argument / Parameter | `o` ● | Kommentar |
| `t` ● | Test | `g` | Änderung (Git-Diff) |

Die mit ● markierten Objekte brauchen Tree-sitter oder einen Language Server, siehe [[09 Code und LSP]].

## Umschließen, ersetzen, entfernen

| Befehl | Wirkung |
|---|---|
| `mm` | zur passenden Klammer springen |
| `ms` *z* | Auswahl mit Zeichen *z* umschließen (z. B. `ms(` → `( Auswahl )`) |
| `mr` *a* *b* | umschließendes Paar *a* durch *b* ersetzen (z. B. `mr([` → `(` `)` wird zu `[` `]`) |
| `md` *z* | umschließendes Paar *z* entfernen |

> [!example] Variable in Anführungszeichen setzen
> `print(wert)`, Cursor auf `wert`: `miw` wählt `wert`, `ms"` macht daraus `print("wert")`.

> [!example] Klammerart austauschen
> `summe(a, b, c)`, Cursor irgendwo im Argumentbereich: `mi(` wählt `a, b, c`, `mr([` ersetzt die runden Klammern durch eckige → `summe[a, b, c]`.

> [!example] Anführungszeichen entfernen
> `"geheim"`, Cursor auf dem Wort: `mi"` wählt `geheim` aus, `md"` entfernt die Anführungszeichen drumherum → `geheim`.

> [!example] Surround kombiniert mit Mehrfachauswahl
> `apfel birne kirsche` → `(apfel) (birne) (kirsche)`: `%` wählt alles, `s` `\w+` `⏎` wählt jedes Wort einzeln (siehe [[05 Mehrfachauswahl]]), `ms(` umschließt **alle gleichzeitig**.

> [!question]- Übung 6.1 – Funktionsargument verpacken
> `zeichne(x, y)` soll zu `zeichne((x, y))` werden – die beiden Argumente bekommen eine zusätzliche Klammer.
>
> > [!success]- Lösung
> > `mi(` wählt `x, y`, `ms(` umschließt die Auswahl mit einem weiteren Klammerpaar.

> [!question]- Übung 6.2 – Alle Anführungszeichen umstellen
> `er sagte "hallo" und "tschüss"` soll zu `er sagte 'hallo' und 'tschüss'` werden – beide Zitate gleichzeitig.
>
> > [!success]- Lösung
> > `%` wählt alles, `s` `"[^"]*"` `⏎` wählt beide Zitate samt Anführungszeichen als zwei Auswahlen, `mr"'` ersetzt bei **beiden** gleichzeitig das umschließende `"` `"` durch `'` `'`.

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[01-Leitfaden zum Spickzettel#7 Match & Surround]] – Grafik und Einstieg
- [[05 Mehrfachauswahl]] – Surround auf viele Auswahlen gleichzeitig anwenden
- [[04 Suchen und Ersetzen]] – wenn das Muster mehr als ein Zeichen lang ist
- [[09 Code und LSP]] – Tree-sitter-Textobjekte (Funktion, Klasse, Argument, Kommentar)
