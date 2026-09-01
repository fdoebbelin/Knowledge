---
title: Die Syntax des chmod-Befehls verstehen
tags:
  - linux
  - shell
  - dateirechte
  - chmod
aliases:
  - chmod
  - Dateirechte
created: 2026-06-10
---
Wenn man die offizielle Dokumentation des Linux-Befehls `chmod` aufruft, stößt man auf folgenden regulären Ausdruck (Regex), welcher die erlaubten Eingabeformate beschreibt:

```regex
[ugoa]*([-+=]([rwxXst]*|[ugo]))+|[-+=]?[0-7]+
```

Diese Zeile definiert präzise die beiden grundlegenden Methoden, mit denen Dateirechte unter Linux geändert werden können: die **symbolische Methode** (mit Buchstaben) und die **numerische Methode** (mit Oktalzahlen). Das Oder-Zeichen (`|`) in der Mitte trennt diese beiden Welten.

---

## 1. Die symbolische Methode (Buchstaben)

> [!info] Struktur
> `[ugoa]*([-+=]([rwxXst]*|[ugo]))+`

Diese Methode wird verwendet, um gezielt einzelne Rechte hinzuzufügen, zu entfernen oder absolut zu setzen, **ohne** andere bestehende Rechte der Datei zu beeinflussen.

### Teil A: Die Zielgruppe `[ugoa]*`

Bestimmt, für wen die Rechteänderung gelten soll:

| Zeichen | Bedeutung | Beschreibung                                |
| :-----: | --------- | ------------------------------------------- |
| `u`     | User      | Der Besitzer der Datei.                     |
| `g`     | Group     | Die Gruppe, der die Datei gehört.           |
| `o`     | Others    | Alle anderen Benutzer im System.            |
| `a`     | All       | Alle zusammen (entspricht `ugo`).           |

> [!note] Die Rolle des Sternchens (`*`)
> Das `*` ist ein Quantifizierer in regulären Ausdrücken und bedeutet: *„keinmal, einmal oder beliebig oft"*.
>
> - **Keinmal:** Die Zielgruppe kann komplett weggelassen werden (z. B. `chmod +x`). Das System wendet die Änderung dann standardmäßig auf alle (`a`) an.
> - **Einmal/Mehrfach:** Eine oder mehrere Gruppen lassen sich kombinieren (z. B. `chmod u+w` oder `chmod ug+rx`).

### Teil B: Der Operator `[-+=]`

Bestimmt, was mit den Rechten passieren soll:

| Operator | Name         | Wirkung                                                                 |
| :------: | ------------ | ----------------------------------------------------------------------- |
| `+`      | Hinzufügen   | Fügt die angegebenen Rechte hinzu.                                      |
| `-`      | Entziehen    | Entfernt die angegebenen Rechte.                                        |
| `=`      | Exakt setzen | Überschreibt die bisherigen Rechte genau (alles andere wird gelöscht). |

### Teil C: Die Rechte `([rwxXst]*|[ugo])`

Hier wird definiert, **welche** Rechte vergeben werden. Es gibt zwei Wege.

#### Weg 1: Rechte explizit angeben `[rwxXst]*`

| Zeichen | Name           | Bedeutung                                                                                         |
| :-----: | -------------- | ------------------------------------------------------------------------------------------------- |
| `r`     | Read           | Leserecht.                                                                                        |
| `w`     | Write          | Schreibrecht.                                                                                      |
| `x`     | Execute        | Ausführungsrecht.                                                                                  |
| `X`     | Spezial-Execute| Ausführen nur, wenn es sich um einen Ordner handelt oder bereits eine andere Gruppe `x`-Rechte hat. |
| `s`     | Setuid/Setgid  | Ausführung mit den Rechten des Besitzers / der Gruppe.                                             |
| `t`     | Sticky Bit     | Verhindert das Löschen von Dateien durch Nicht-Besitzer (oft in `/tmp` genutzt).                  |

> [!note] Die Rolle des Sternchens (`*`)
> Auch hier erlaubt das `*` Flexibilität:
>
> - **Keinmal:** Nach einem `=` kann man nichts angeben, um alle Rechte dieser Gruppe zu entziehen (z. B. `chmod g= datei.txt` setzt die Gruppenrechte auf `---`).
> - **Mehrfach:** Mehrere Rechte können direkt hintereinander geschrieben werden (z. B. `chmod u+rwx`).

#### Weg 2: Rechte kopieren `[ugo]`

Kopiert die Rechte einer anderen Gruppe.

> [!example]
> `chmod g=u datei.txt` gibt der Gruppe (`g`) exakt dieselben Rechte, die der Besitzer (`u`) aktuell hat.

---

## 2. Die numerische Methode (Oktalwerte)

> [!info] Struktur
> `[-+=]?[0-7]+`

Diese Methode überschreibt **immer die gesamten Rechte** einer Datei auf einmal mit Hilfe von Zahlenwerten.

### Teil A: Der optionale Operator `[-+=]?`

Das Fragezeichen `?` bedeutet in der Regex, dass dieser Teil **einmal oder keinmal** vorkommen darf (optional). In der Praxis nutzt man bei Zahlen meist gar keinen Operator. Ein `+` oder `-` vor den Zahlen erlaubt jedoch relative numerische Änderungen (z. B. Rechte bitweise hinzufügen).

### Teil B: Die Oktalwerte `[0-7]+`

Das `+` bedeutet *„einmal oder beliebig oft"* (mindestens jedoch eine Ziffer). Standardmäßig werden drei Ziffern (z. B. `755`) oder vier Ziffern (z. B. `1777` für Spezialrechte) verwendet.

Jede Ziffer steht für eine Benutzerklasse (erste Stelle = Besitzer, zweite = Gruppe, dritte = Andere) und berechnet sich als Summe der gewünschten Rechte:

| Wert | Recht           | Symbol |
| :--: | --------------- | :----: |
| `4`  | Leserecht       | `r--`  |
| `2`  | Schreibrecht    | `-w-`  |
| `1`  | Ausführungsrecht| `--x`  |
| `0`  | Keine Rechte    | `---`  |

> [!example] Rechenbeispiel: `chmod 755`
> | Ziffer | Klasse   | Summe       | Rechte | Symbol |
> | :----: | -------- | ----------- | :----: | :----: |
> | **7**  | Besitzer | `4 + 2 + 1` | rwx    | `rwx`  |
> | **5**  | Gruppe   | `4 + 0 + 1` | r-x    | `r-x`  |
> | **5**  | Andere   | `4 + 0 + 1` | r-x    | `r-x`  |

---

## Praktische Anwendungsbeispiele

| Befehl                  | Methode    | Bedeutung                                                                                       |
| ----------------------- | ---------- | ----------------------------------------------------------------------------------------------- |
| `chmod +x skript.sh`    | Symbolisch | Gibt allen (`a` implizit durch `*`) das Recht, die Datei auszuführen (`x`).                      |
| `chmod u=rwx,g=rx,o=`   | Symbolisch | Besitzer darf alles, Gruppe darf lesen/ausführen, Andere haben gar keine Rechte mehr.           |
| `chmod 644 index.html`  | Numerisch  | Besitzer darf lesen/schreiben (`rw-`); Gruppe und Andere dürfen nur lesen (`r--`).              |
| `chmod ug+w daten.csv`  | Symbolisch | Fügt Besitzer und Gruppe Schreibrechte hinzu, lässt andere Rechte unangetastet.                 |

---

> [!tip] Merkhilfe
> - **Symbolisch** = chirurgisch: einzelne Rechte gezielt verändern.
> - **Numerisch** = pauschal: setzt immer den kompletten Rechtesatz neu.
