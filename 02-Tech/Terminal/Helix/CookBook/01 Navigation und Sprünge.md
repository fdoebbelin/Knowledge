---
title: "Helix-Cookbook – Kapitel 1: Navigation und Sprünge"
aliases:
  - Helix Cookbook Navigation
tags:
  - helix
  - editor
  - cookbook
created: 2026-09-23
updated: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel, Lernpfad und Übungsdatei: [[02-Cookbook|Helix-Cookbook]]. Konzept und Grafiken zu Bewegung/Auswahl: [[01-Leitfaden zum Spickzettel#3 Bewegen ist Auswählen – der Kompass]], [[01-Leitfaden zum Spickzettel#5 Zeichen finden mit f und t]].

## Vorbemerkung: Bewegen heißt in Helix auswählen

Helix arbeitet nach dem Prinzip *erst auswählen, dann handeln*. Viele Bewegungen setzen deshalb nicht nur den Cursor, sondern erzeugen gleichzeitig eine Auswahl. Drei Tasten braucht man ständig, um damit umzugehen:

| Taste   | Wirkung                                                        |
| ------- | -------------------------------------------------------------- |
| `;`     | Auswahl aufheben, Cursor bleibt am Kopf (Head) der Auswahl     |
| `Alt-;` | Auswahl umdrehen, Cursor springt ans andere Ende               |
| `v`     | Select-Modus: Bewegungen erweitern die Auswahl, statt sie neu zu setzen |

Die Pfeiltasten und `h` `j` `k` `l` heben eine Auswahl immer auf. Vor fast jede Bewegung lässt sich eine Zahl setzen, zum Beispiel `3w`.

**Schreibweise in den Beispielen:** Der Cursor steht in eckigen Klammern, also `hel[l]o`. Eine Auswahl ist mit `«` und `»` markiert.

---

## 1.1 Zum Anfang des nächsten Wortes

**Tasten:** `w` `l`

**Erklärung:**
1. `w` markiert bis direkt vor den nächsten Wortanfang. Der Cursor steht auf dem Leerzeichen davor.
2. `l` hebt die Auswahl auf und setzt den Cursor einen Schritt weiter, genau auf den ersten Buchstaben.

**Vorher:** `h[e]llo world`
**Nach `w`:** `h«ello »world` (Cursor auf dem Leerzeichen)
**Nach `l`:** `hello [w]orld`

**Varianten:** Wer anschließend das ganze nächste Wort bearbeiten will, drückt statt `l` einfach noch einmal `w`. Dann ist das Wort samt folgendem Leerzeichen ausgewählt.

---

## 1.2 Zum Anfang des vorherigen Wortes

**Tasten:** `b` `;`

**Erklärung:**
1. `b` markiert rückwärts bis zum Wortanfang. Der Cursor steht dabei bereits auf dem ersten Buchstaben.
2. `;` hebt die Auswahl auf.

**Vorher:** `hello wor[l]d`
**Nachher:** `hello [w]orld`

**Hinweis:** Steht der Cursor mitten in einem Wort, landet `b` zuerst am Anfang dieses Wortes. Erst ein weiteres `b` führt zum vorherigen Wort.

---

## 1.3 Zum Ende eines Wortes

**Tasten:** `e` `;`

**Erklärung:** `e` markiert bis zum letzten Zeichen des aktuellen oder nächsten Wortes, der Cursor steht auf diesem Zeichen. `;` hebt die Auswahl auf.

**Vorher:** `[h]ello world`
**Nachher:** `hell[o] world`

---

## 1.4 Über Pfade und Satzzeichen hinweg springen (WORD statt word)

**Tasten:** `W`, `B`, `E`

**Erklärung:** Die kleinen Varianten `w`, `b`, `e` halten an jedem Satzzeichen an. Die großen Varianten betrachten alles zwischen zwei Leerzeichen als ein einziges „WORD“. Das ist ideal für Pfade, URLs und Optionen.

**Beispiel:** Zeile `cp [/]etc/nginx/nginx.conf /tmp/`
- `w` hält nacheinander an `etc`, `/`, `nginx`, `/`, `nginx`, `.` …
- `W` springt in einem Schritt bis zum Leerzeichen vor `/tmp/`.

---

## 1.5 Zeilenanfang und Zeilenende

**Tasten:**

| Tasten | Ziel                                              |
| ------ | ------------------------------------------------- |
| `gh`   | allererste Spalte der Zeile                       |
| `gs`   | erstes Zeichen, das kein Leerraum ist             |
| `gl`   | letztes Zeichen der Zeile                         |

**Vorher:** `    return [x] + 1`
**Nach `gs`:** `    [r]eturn x + 1`
**Nach `gh`:** `[ ]   return x + 1`

**Merkhilfe:** `h` und `l` sind links und rechts, `s` steht für „start of text“. Bei eingerücktem Code ist `gs` fast immer die bessere Wahl als `gh`.

---

## 1.6 Dateianfang und Dateiende

**Tasten:** `gg` (Anfang), `ge` (letzte Zeile)

---

## 1.7 Zu einer bestimmten Zeile

**Tasten (drei gleichwertige Wege):**
- `42G`
- `42gg`
- `:42` und Enter

**Tipp:** Die Variante mit `:` ist praktisch, wenn man die Zeilennummer aus einer Fehlermeldung abschreibt. Für Fehlermeldungen des Compilers ist der LSP-Sprung aus [[09 Code und LSP]] aber meist bequemer.

---

## 1.8 Zu einem bestimmten Zeichen springen

**Tasten:**

| Tasten    | Wirkung                                      |
| --------- | --------------------------------------------- |
| `f` *x*   | vorwärts bis einschließlich Zeichen *x*      |
| `t` *x*   | vorwärts bis kurz vor Zeichen *x*            |
| `F` *x*   | rückwärts bis einschließlich *x*             |
| `T` *x*   | rückwärts bis kurz hinter *x*                |
| `Alt-.`   | letzte `f`/`t`-Bewegung wiederholen          |

**Beispiel:** Cursor am Anfang von `[n]ame = "Fritz", ort = "Magdeburg"`
- `f"` markiert bis zum ersten Anführungszeichen.
- `Alt-.` springt zum nächsten Anführungszeichen.
- `2f,` springt direkt zum zweiten Komma.

**Kombination zum Merken:** `t)` gefolgt von `d` löscht alles bis zur schließenden Klammer, die Klammer selbst bleibt stehen.

---

## 1.9 Zur passenden Klammer

**Tasten:** `mm`

**Erklärung:** Springt von einer öffnenden zur zugehörigen schließenden Klammer und umgekehrt. Funktioniert mit `()`, `[]`, `{}` und in vielen Sprachen auch mit Anführungszeichen.

**Vorher:** `print[(]len(liste))`
**Nachher:** `print(len(liste)[)]`

---

## 1.10 Mit Sprungmarken direkt zu einem sichtbaren Wort

**Tasten:** `gw`, dann zwei Buchstaben

**Erklärung:** Helix blendet vor jedem sichtbaren Wort eine Beschriftung aus zwei Buchstaben ein. Tippt man diese zwei Buchstaben, springt der Cursor dorthin und das Wort ist ausgewählt. Esc bricht ab.

**Wann sinnvoll:** Immer dann, wenn das Ziel auf dem Bildschirm sichtbar, aber mehrere Zeilen und Wörter entfernt ist. Das ist oft schneller als jede Kombination aus `j`, `w` und `f`.

---

## 1.11 Bildschirmweise bewegen und die Ansicht ausrichten

**Cursor innerhalb des sichtbaren Bereichs:**

| Tasten | Ziel                       |
| ------ | -------------------------- |
| `gt`   | oberste sichtbare Zeile    |
| `gc`   | mittlere sichtbare Zeile   |
| `gb`   | unterste sichtbare Zeile   |

**Blättern:**

| Tasten   | Wirkung               |
| -------- | --------------------- |
| `Ctrl-d` | halbe Seite runter    |
| `Ctrl-u` | halbe Seite hoch      |
| `Ctrl-f` | ganze Seite runter    |
| `Ctrl-b` | ganze Seite hoch      |

**Ansicht verschieben, ohne den Cursor zu bewegen** (View-Modus mit `z`, ausführlich mit Grafik: [[01-Leitfaden zum Spickzettel#Ansicht mit z und Z]]):

| Tasten | Wirkung                                  |
| ------ | ----------------------------------------- |
| `zz`   | aktuelle Zeile in die Bildschirmmitte    |
| `zt`   | aktuelle Zeile an den oberen Rand        |
| `zb`   | aktuelle Zeile an den unteren Rand       |

---

## 1.12 Zurück zu früheren Positionen (Sprungliste)

**Tasten:**

| Tasten    | Wirkung                                         |
| --------- | ------------------------------------------------ |
| `Ctrl-o`  | zurück zur vorherigen Sprungposition            |
| `Ctrl-i`  | wieder vorwärts                                 |
| `Ctrl-s`  | aktuelle Position von Hand in die Liste legen   |
| `Space j` | Picker mit allen gespeicherten Positionen       |

**Erklärung:** Große Sprünge wie `gg`, `42G`, Suchen oder `gd` landen automatisch in der Sprungliste, kleine Bewegungen wie `w` nicht. Mit `Ctrl-s` lässt sich vorher eine Stelle merken, zu der man später per `Ctrl-o` zurückkehren will.

**Typischer Ablauf:** Mit `gd` zur Definition einer Funktion springen, dort nachlesen, mit `Ctrl-o` zurück an die Aufrufstelle.

**Verwandt:**
- `g.` springt zur letzten Änderung in der aktuellen Datei.
- `ga` wechselt zur zuletzt besuchten Datei.

---

## 1.13 Strukturiert springen: Funktionen, Klassen, Absätze

**Tasten:** `]` für vorwärts, `[` für rückwärts, jeweils gefolgt von:

| Taste | Ziel                              |
| ----- | ---------------------------------- |
| `f`   | Funktion                          |
| `t`   | Typ / Klasse                      |
| `a`   | Argument oder Parameter           |
| `c`   | Kommentar                         |
| `T`   | Test                              |
| `p`   | Absatz                            |
| `d`   | Diagnose (Fehler, Warnung) – `D` springt zur ersten/letzten |
| `g`   | Änderung laut Git – `G` springt zur ersten/letzten |
| `Space` | Leerzeile darüber/darunter einfügen (keine Navigation, nutzt aber dasselbe Präfix) |

**Erklärung:** Diese Sprünge nutzen den Syntaxbaum (Tree-sitter) beziehungsweise die Diagnosen des Language Servers. Das Ziel ist danach komplett ausgewählt: `]f` wählt also die ganze nächste Funktion aus.

**Nur zum Anfang springen:** `]f` `Alt-;` `;` legt den Cursor an den Anfang der Funktion, ohne Auswahl.

**Voraussetzung prüfen:** `hx --health python` (bzw. die gewünschte Sprache) zeigt, ob Textobjekt-Queries und ein Language Server verfügbar sind. Absätze (`]p`) funktionieren in jeder Datei.

> [!note] Diagnosen ausführlich
> `]d`/`[d` gehören zum Fehler-Workflow mit dem Language Server – Picker, Hover und Code-Actions dazu stehen in [[09 Code und LSP]].

---

## Übersicht zum Ausdrucken

| Aufgabe                           | Tasten             |
| ---------------------------------- | ------------------- |
| nächster Wortanfang               | `w` `l`            |
| vorheriger Wortanfang             | `b` `;`            |
| Wortende                          | `e` `;`            |
| über Pfade/URLs springen          | `W` `B` `E`        |
| Zeilenanfang / Textanfang / Ende  | `gh` / `gs` / `gl` |
| Dateianfang / Dateiende           | `gg` / `ge`        |
| Zeile 42                          | `42G` oder `:42`   |
| bis zum Zeichen x                 | `fx` / `tx`        |
| Zeichensprung wiederholen         | `Alt-.`            |
| passende Klammer                  | `mm`               |
| sichtbares Wort per Label         | `gw`               |
| Bildschirm oben / Mitte / unten   | `gt` / `gc` / `gb` |
| Zeile zentrieren                  | `zz`               |
| halbe Seite runter / hoch         | `Ctrl-d` / `Ctrl-u`|
| Sprung zurück / vor               | `Ctrl-o` / `Ctrl-i`|
| Position merken                   | `Ctrl-s`           |
| letzte Änderung                   | `g.`               |
| nächste Funktion / Diagnose       | `]f` / `]d`        |
| Auswahl aufheben / umdrehen       | `;` / `Alt-;`      |

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[01-Leitfaden zum Spickzettel|Helix-Leitfaden]] – Grundprinzip, Kompass-Grafik, f/t-Grafik
- [[09 Code und LSP]] – Diagnosen-Sprünge, Symbol-Picker
