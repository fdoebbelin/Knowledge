---
title: Helix Tutor (Deutsch)
tags: [helix, editor, tutorial, schulung]
sprache: de
quelle: Helix Editor – tutor
---

# Helix Tutor – deutsche Fassung

> [!info] Hinweis zur Übersetzung
> Alle Tastenbefehle, Modusnamen und die Übungstexte (Zeilen mit `-->` sowie die
> zugehörigen Vorlagezeilen) sind bewusst **im Original belassen**. Übersetzt sind
> nur die Erklärungen und Arbeitsanweisungen.

```
       .
       ###x.        .|
       d#####x,   ,v||
        '+#####v||||||
           ,v|||||+'.      _     _           _
        ,v|||||^'>####    | |   | |   ___   | | (_) __  __
       |||||^'  .v####    | |___| |  /   \  | |  _  \ \/ /
       ||||=..v#####P'    |  ___  | /  ^  | | | | |  \  /
       ''v'>#####P'       | |   | | |  ---  | | | |  /  \
       ,######/P||x.      |_|   |_|  \___/  |_| |_| /_/\_\
       ####P' "x|||||,
       |/'       'x|||    Ein postmoderner modaler Texteditor.
        '           '|


                 Willkommen beim Helix-Tutorial!
        Drücke die Taste j, bis du die Einführung erreichst.
```

---

## Einführung

Willkommen im Helix-Editor! Helix unterscheidet sich von Editoren, die du
vielleicht gewohnt bist: Er ist **modal**, das heißt, er kennt verschiedene Modi
für die Textbearbeitung. Die wichtigsten Modi, die du verwenden wirst, sind der
Normal-Modus und der Insert-Modus. Im Normal-Modus schreiben die Tasten, die du
tippst, keinen Text – stattdessen führen sie verschiedene Aktionen mit dem Text
aus. Das ermöglicht ein deutlich effizienteres Bearbeiten. Dieser Tutor zeigt
dir, wie du die modalen Bearbeitungsfunktionen von Helix nutzt.

Stelle zu Beginn sicher, dass die CapsLock-Taste nicht aktiv ist, und halte `j`
gedrückt, bis du die erste Lektion erreichst.

---

## 1.1 Grundlegende Cursorbewegung

```
          ↑
          k       * h liegt links
      ← h   l →   * l liegt rechts
          j       * j sieht aus wie ein Pfeil nach unten
          ↓
```

Der Cursor lässt sich mit den Tasten `h`, `j`, `k`, `l` bewegen, wie oben
gezeigt. Die Pfeiltasten funktionieren ebenfalls, aber `hjkl` ist schneller,
weil diese Tasten näher an den übrigen Tasten liegen, die du benutzen wirst.
Bewege dich ein wenig herum, um ein Gefühl für `hjkl` zu bekommen.

Wenn du so weit bist, halte `j` gedrückt, um zur nächsten Lektion zu gelangen.

---

## 1.2 Helix beenden

1. Tippe `:`, um in den Command-Modus zu wechseln. Der Cursor springt an den
   unteren Bildschirmrand.
2. Tippe `q` bzw. `quit` und drücke Enter, um Helix zu beenden.

> [!note] Hinweis
> Der quit-Befehl schlägt fehl, wenn es ungespeicherte Änderungen gibt. Um das
> Beenden zu erzwingen und diese Änderungen zu **VERWERFEN**, tippe `q!` bzw.
> `quit!`. Wie man Dateien speichert, lernst du später.

Um den Command-Modus zu verlassen, ohne einen Befehl auszuführen, drücke Escape.

Gehe nun weiter zur nächsten Lektion.

---

## 1.3 Löschen

Tippe `d`, um das Zeichen unter dem Cursor zu löschen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Bewege den Cursor auf jedes überflüssige Zeichen und tippe `d`, um es zu
   löschen.

```text
 --> Thhiss senttencee haass exxtra charracterss.
     This sentence has extra characters.
```

Sobald der Satz korrekt ist, geht es weiter mit der nächsten Lektion.

---

## 1.4 Insert-Modus

Tippe `i`, um in den Insert-Modus zu wechseln.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Gehe an eine Stelle in der Zeile, an der Text fehlt, und tippe `i`, um in den
   Insert-Modus zu wechseln. Getippte Tasten schreiben nun Text.
3. Ergänze den fehlenden Text.
4. Drücke Escape, um den Insert-Modus zu verlassen und in den Normal-Modus
   zurückzukehren.
5. Wiederhole das, bis die Zeile mit der darunterliegenden Zeile übereinstimmt.

```text
 --> Th stce misg so.
     This sentence is missing some text.
```

> [!note] Hinweis
> Die Statuszeile zeigt deinen aktuellen Modus an. Beachte, dass aus `NOR` ein
> `INS` wird, sobald du `i` tippst.

---

## 1.5 Eine Datei speichern

Tippe `:w` / `:write`, um eine Datei zu speichern.

1. Beende Helix mit `:q!` wie zuvor erklärt, oder öffne ein neues Terminal.
2. Öffne eine Datei in Helix mit: `hx DATEINAME`
3. Nimm ein paar Änderungen an der Datei vor.
4. Tippe `:`, um in den Command-Modus zu wechseln.
5. Tippe `w` bzw. `write` und drücke Enter, um die Datei zu speichern.

Du kannst auch `wq` bzw. `write-quit` tippen, um zu speichern und zu beenden.

> [!note] Hinweise
> Nach dem Befehl `w` / `write` kannst du optional einen Dateipfad angeben, um
> unter diesem Pfad zu speichern.
>
> Gibt es ungespeicherte Änderungen, erscheint in der Statuszeile ein Plus `[+]`
> neben dem Dateinamen.

---

## Kapitel 1 – Zusammenfassung

* Bewege den Cursor mit den Tasten `h`, `j`, `k`, `l`.

* Tippe `:`, um in den Command-Modus zu wechseln.
  * Die Befehle `q` / `quit` und `q!` / `quit!` beenden Helix. Der erste schlägt
    bei ungespeicherten Änderungen fehl, der zweite verwirft sie.
  * Der Befehl `w` / `write` speichert die Datei.
  * Der Befehl `wq` / `write-quit` macht beides.

* Tippe `d`, um das Zeichen am Cursor zu löschen.

* Tippe `i`, um in den Insert-Modus zu wechseln und Text zu schreiben. Drücke
  Escape, um in den Normal-Modus zurückzukehren.

---

## 2.1 Weitere Insert-Befehle

Wie du gesehen hast, kannst du mit `i` an der aktuellen Cursorposition in den
Insert-Modus wechseln. Es gibt noch einige weitere Möglichkeiten, an anderen
Stellen in den Insert-Modus zu gelangen.

Gängige Einfügebefehle sind:

```
   i - Einfügen vor der Auswahl.
   a - Einfügen nach der Auswahl. (a steht für 'append')
   I - Einfügen am Anfang der Zeile.
   A - Einfügen am Ende der Zeile.
```

1. Gehe an eine beliebige Stelle der unten mit `-->` markierten Zeile.
2. Tippe `A` (Shift-a); der Cursor springt ans Zeilenende und du kannst
   schreiben.
3. Ergänze den Text, damit die Zeile mit der darunter übereinstimmt.

```text
 --> This sentence is miss
     This sentence is missing some text.
```

---

## 2.2 Zeilen öffnen

Tippe `o`, um eine neue Zeile unterhalb des Cursors einzufügen und dort zu
schreiben. Tippe `O`, um eine neue Zeile oberhalb des Cursors einzufügen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Tippe `o`, um darunter eine Zeile zu öffnen, und schreibe deine Antwort.

```text
 --> What is the best editor?
```

---

## Kapitel 2 – Zusammenfassung

* Tippe `a`, um hinter der Auswahl einzufügen (append).

* Tippe `I`, um am ersten Zeichen, das kein Leerzeichen ist, in den Insert-Modus
  zu wechseln.

* Tippe `A`, um am Zeilenende in den Insert-Modus zu wechseln.

* Nutze `o` und `O`, um Zeilen unterhalb bzw. oberhalb des Cursors zu öffnen.

---

## 3.1 Motions und Auswahlen

Tippe `w`, um bis zum nächsten Wort nach vorne auszuwählen.

Die Taste `d` löscht genau genommen nicht das Zeichen unter dem Cursor, sondern
den gesamten ausgewählten Text. Dein Cursor ist dabei nichts anderes als eine
Auswahl von einem Zeichen Länge.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Gehe an den Anfang eines Wortes, das gelöscht werden muss.
3. Tippe `w`, um bis zum Anfang des nächsten Wortes auszuwählen.
4. Tippe `d`, um die Auswahl zu löschen.
5. Wiederhole das für alle überflüssigen Wörter in der Zeile.

```text
 --> This sentence pencil has vacuum extra words in the it.
     This sentence has extra words in it.
```

---

## 3.2 Weitere Motions

Wie du gesehen hast, bewegt `w` den Cursor vorwärts bis zum Anfang des nächsten
Wortes und wählt dabei den überstrichenen Text aus. Das ist praktisch, um sich
im Text zu bewegen und um Text für weitere Operationen auszuwählen.

Gängige Motions sind:

```
   w - Vorwärts bis vor den Anfang des nächsten Wortes.
   e - Vorwärts bis zum Ende des aktuellen Wortes.
   b - Rückwärts bis zum Anfang des aktuellen Wortes.
```

Um das Wort unter dem Cursor auszuwählen, kombiniere `e` und `b`.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Gehe auf ein `d`.
3. Tippe `e`, um die eine Hälfte des Wortes auszuwählen.
4. Tippe `b`, um den Rest auszuwählen.

```text
--> The Middle Kingdom.
```

---

## 3.3 WÖRTER und wörter

Zu den Motions `w`, `e`, `b` gibt es auch die Gegenstücke `W`, `E`, `B`, die
sich in WÖRTERN statt in Wörtern bewegen. WÖRTER werden ausschließlich durch
Leerraum getrennt, während Wörter zusätzlich durch andere Zeichen getrennt sein
können.

1. Bewege den Cursor an den Anfang der unten mit `-->` markierten Zeile.
2. Tippe wiederholt `w`, um einzelne Wörter auszuwählen, bis du das Zeilenende
   erreichst.
3. Beachte, dass für `one-of-a-kind` 7 Tastendrücke nötig waren, für `"modal"`
   dagegen 3.
4. Gehe zurück an den Anfang der mit `-->` markierten Zeile.
5. Tippe wiederholt `W`, um einzelne WÖRTER auszuwählen.
6. Beachte, dass `one-of-a-kind` und `"modal"` nun mit jeweils einem einzigen
   Tastendruck ausgewählt wurden.

```text
--> Helix is a one-of-a-kind "modal" text editor
```

---

## 3.4 Der change-Befehl

Tippe `c`, um die aktuelle Auswahl zu ändern.

Der change-Befehl löscht die aktuelle Auswahl und wechselt in den Insert-Modus –
er ist also eine sehr gebräuchliche Kurzform für `di`.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Gehe an den Anfang eines falschen Wortes und tippe `e`, um es auszuwählen.
3. Tippe `c`, um das Wort zu löschen und in den Insert-Modus zu wechseln.
4. Schreibe das richtige Wort.
5. Wiederhole das, bis die Zeile mit der darunter übereinstimmt.

```text
 --> This paper has heavy words behind it.
     This sentence has incorrect words in it.
```

---

## 3.5 Zähler bei Motions

Tippe eine Zahl vor eine Motion, um sie entsprechend oft zu wiederholen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Tippe `2w`, um 2 Wörter vorwärts zu gehen.
3. Tippe `3e`, um an das Ende des dritten Wortes vorwärts zu gehen.
4. Tippe `2b`, um 2 Wörter rückwärts zu gehen.
5. Probiere das Ganze mit verschiedenen Zahlen aus.

```text
 --> This is just a line with words you can move around in.
```

---

## 3.6 Select- / Extend-Modus

Tippe `v`, um in den Select-Modus zu wechseln. Tippe erneut `v` oder drücke
Escape, um in den Normal-Modus zurückzukehren. Im Select-Modus erweitert jede
Bewegung die Auswahl, statt sie zu ersetzen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Gehe auf das `F` von `FOO` und tippe `v2w`, um die beiden Wörter auszuwählen.
3. Tippe `d`, um die beiden Wörter zu entfernen. Beachte, dass `d` dich in den
   Normal-Modus zurückbringt.
4. Gehe auf das `B` von `BAZ` und wiederhole die Sequenz, um sie zu löschen.

```text
 --> Remove the FOO BAR distracting words BAZ BIZ from this line.
```

---

## 3.7 Zeilen auswählen

Tippe `x`, um eine ganze Zeile auszuwählen. Tippe erneut `x`, um die nächste
Zeile hinzuzunehmen.

1. Bewege den Cursor in die unten mit `-->` markierte **zweite** Zeile.
2. Tippe `x`, um die Zeile auszuwählen, und `d`, um sie zu löschen.
3. Gehe zur vierten Zeile.
4. Tippe zweimal `x` oder `2x`, um 2 Zeilen auszuwählen, und `d` zum Löschen.

```text
 --> 1) Roses are red,
 --> 2) Mud is fun,
 --> 3) Violets are blue,
 --> 4) I have a car,
 --> 5) Clocks tell time,
 --> 6) Sugar is sweet,
 --> 7) And so are you.
```

> [!note] Hinweis
> `X` funktioniert ähnlich wie `x`, erweitert die Auswahl aber nicht auf
> nachfolgende Zeilen. Auf einer leeren Zeile bewirkt `X` nichts.

---

## 3.8 Auswahlen auf den Cursor reduzieren

Tippe `;`, um Auswahlen auf einzelne Cursor zu reduzieren.

Manchmal möchtest du die Auswahl aufheben, ohne den bzw. die Cursor zu bewegen.
Das geht mit der Taste `;`.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Nutze die bisher gelernten Motions, um dich in der Zeile zu bewegen, und
   versuche, den durch die Motions ausgewählten Text mit `;` wieder abzuwählen.

```text
 --> This is an error-free line with words to move around in.
```

> [!note] Hinweise
> Im Select-Modus funktioniert das genauso.
>
> Ein verwandter Befehl ist `Alt-;`. Er dreht die Richtung der Auswahl um
> (vertauscht Cursor und Anker der Auswahl).

---

## Kapitel 3 – Zusammenfassung

* Tippe `w`, um vorwärts bis zum nächsten Wort auszuwählen.
  * Tippe `e`, um bis zum Ende des aktuellen Wortes auszuwählen.
  * Tippe `b`, um rückwärts bis zum Anfang des aktuellen Wortes auszuwählen.
  * Nutze die Großbuchstaben-Varianten `W`, `E`, `B` für WÖRTER.

* Tippe `d`, um die gesamte Auswahl zu löschen.
  * Tippe `c`, um die Auswahl zu löschen und in den Insert-Modus zu wechseln.

* Tippe eine Zahl vor eine Motion, um sie entsprechend oft zu wiederholen.

* Tippe `v`, um in den Select-Modus zu wechseln, in dem alle Motions die Auswahl
  erweitern.

* Tippe `x`, um die gesamte aktuelle Zeile auszuwählen. Tippe erneut `x`, um die
  nächste Zeile auszuwählen.

* Tippe das Semikolon (`;`), um die Auswahl zu reduzieren.

---

## 4.1 Rückgängig machen

Tippe `u` für „undo“ (rückgängig). Tippe `U` für „redo“ (wiederherstellen).

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Gehe zum ersten Fehler und tippe `d`, um ihn zu löschen.
3. Tippe `u`, um das Löschen rückgängig zu machen.
4. Korrigiere alle Fehler in der Zeile.
5. Tippe mehrmals `u`, um deine Korrekturen rückgängig zu machen.
6. Tippe mehrmals `U` (Shift-u), um sie wiederherzustellen.

```text
 --> Fiix the errors on thhis line and reeplace them witth undo.
```

---

## 4.2 Text kopieren und einfügen

Tippe `y`, um die Auswahl zu yanken (kopieren). Tippe `p`, um die geyankte
Auswahl hinter dem Cursor einzufügen. Tippe `P`, um sie vor dem Cursor
einzufügen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile. Achte darauf, dass
   der Cursor auf dem `b` von `banana` steht.
2. Tippe `w`, um `banana` auszuwählen, und `y`, um es zu yanken.
3. Gehe auf das Leerzeichen zwischen `2` und `3` und tippe `p` zum Einfügen.
4. Wiederhole das zwischen `3` und `4`.

```text
 --> 1 banana 2 3 4
     1 banana 2 banana 3 banana 4
```

> [!note] Hinweise
> Immer wenn du Text löschst oder änderst, kopiert Helix den betroffenen Text.
> Nutze stattdessen `Alt-d` / `Alt-c`, um das zu vermeiden.
>
> Helix nutzt standardmäßig nicht die Zwischenablage des Systems. Tippe
> `Space + y` / `Space + p`, um in die System-Zwischenablage zu yanken bzw. aus
> ihr einzufügen.

---

## 4.3 Suchen in der Datei

Tippe `/`, um in der Datei vorwärts zu suchen, und Enter, um die Suche zu
bestätigen. Tippe `n`, um zum nächsten Treffer zu springen. Tippe `N`, um zum
vorherigen Treffer zu springen.

1. Tippe `/` und gib ein häufiges Wort ein, zum Beispiel `banana`.
2. Drücke Enter, um die Suche zu bestätigen.
3. Springe mit `n` und `N` durch die Treffer.

Die Suche arbeitet mit regulären Ausdrücken. Damit kannst du auch komplexere
Muster treffen – mehr dazu in der Lektion zum select-Befehl.

> [!note] Hinweise
> Um rückwärts zu suchen, tippe `?` (Shift-/).
>
> Anders als in Vim ändert `?` die Suchrichtung nicht: `N` geht immer rückwärts
> und `n` immer vorwärts.

---

## Kapitel 4 – Zusammenfassung

* Tippe `u` für undo, `U` für redo.

* Tippe `y`, um Text zu yanken (kopieren), und `p`, um ihn einzufügen.
  * Nutze `Space + y` und `Space + p` für die System-Zwischenablage.

* Tippe `/`, um vorwärts in der Datei zu suchen, und `?`, um rückwärts zu suchen.
  * Springe mit `n` und `N` durch die Treffer.

---

## 5.1 Mehrere Cursor

Tippe `C`, um den Cursor auf die nächste passende Zeile zu duplizieren.

1. Bewege den Cursor in die unten mit `-->` markierte **erste** Zeile. Setze den
   Cursor irgendwo hinter das `-->`.
2. Tippe `C`, um den Cursor auf die nächste passende Zeile zu duplizieren.
   Beachte, dass die Zeile dazwischen übersprungen wird. Getippte Tasten wirken
   nun auf beide Cursor.
3. Korrigiere die Zeilen im Insert-Modus. Die beiden Cursor reparieren beide
   Zeilen gleichzeitig.
4. Tippe `,`, um den ersten Cursor zu entfernen.

```text
 --> Fix th two nes at same ime.
 -->
 --> Fix th two nes at same ime.
     Fix these two lines at the same time.
```

> [!note] Hinweis
> Drücke `Alt-C`, um dasselbe oberhalb des Cursors zu tun.

---

## 5.2 Der select-Befehl

Tippe `s`, um Treffer innerhalb der Auswahl auszuwählen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Tippe `x`, um die Zeile auszuwählen.
3. Tippe `s`. Es erscheint eine Eingabeaufforderung.
4. Tippe `apples` und drücke Enter. Beide Vorkommen von `apples` in der Zeile
   werden ausgewählt.
5. Du kannst nun `c` tippen und `apples` durch etwas anderes ersetzen, etwa
   `oranges`.
6. Drücke Escape, um den Insert-Modus zu verlassen.
7. Tippe `,`, um den zweiten Cursor zu entfernen.

```text
 --> I like to eat apples since my favorite fruit is apples.
     I like to eat oranges since my favorite fruit is oranges.
```

---

## 5.3 Auswählen per Regex

Wie beim Suchen wählt der select-Befehl reguläre Ausdrücke aus, nicht nur exakte
Übereinstimmungen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Wähle die Zeile mit `x` aus und tippe dann `s`.
3. Tippe `  +`, um beliebig viele aufeinanderfolgende Leerzeichen (>1)
   auszuwählen, und drücke Enter.
4. Tippe `c` und ersetze die Treffer durch einzelne Leerzeichen.

```text
 --> This  sentence has   some      extra spaces.
     This sentence has some extra spaces.
```

> [!note] Hinweis
> Wenn du Suchen und Ersetzen durchführen willst, ist der select-Befehl das
> Mittel der Wahl. Wähle den Text aus, in dem ersetzt werden soll – mit `%`
> wählst du die ganze Datei aus – und führe dann die oben beschriebenen Schritte
> aus.

---

## 5.4 Auswahlen ausrichten

Tippe `&`, um die Inhalte der Auswahlen aneinander auszurichten.

1. Bewege den Cursor in die unten mit `-->` markierte **erste** Zeile. Setze den
   Cursor auf den Leerraum direkt hinter dem Pfeil.
2. Tippe viermal `C` oder `4C`.
3. Tippe `W`, um die Zahlen und Klammern auszuwählen.
4. Tippe `&`, um die Wörter auszurichten.

```text
 --> 97) lorem
 --> 98) ipsum
 --> 99) dolor
 --> 100) sit
 --> 101) amet
```

> [!note] Hinweis
> `&` richtet sich nur nach dem „head“ der Auswahlen – dem Ende, das sich
> bewegt. Das andere Ende heißt „anchor“.

---

## 5.5 Auswahl in Zeilen aufteilen

Drücke `Alt-s`, um die Auswahl(en) an Zeilenumbrüchen aufzuteilen.

1. Bewege den Cursor in die erste Zeile der Tabelle unten.
2. Wähle die gesamte Tabelle mit `6x` aus.
3. Drücke `Alt-s`, um sie in eine Auswahl pro Zeile aufzuteilen.
4. Richte die Tabelle mit `&` aus.

```text
    | FRUIT   | AMOUNT |
    |---------|--------|
 | Apples  | 8      |
    | Bananas | 6      |
  | Oranges | 3      |
     | Donuts  | 4      |
```

---

## Kapitel 5 – Zusammenfassung

* Tippe `C`, um den Cursor auf die nächste passende Zeile zu duplizieren, und
  `Alt-C` für die vorherige passende Zeile.

* Tippe `s`, um alle Treffer eines Regex-Musters innerhalb der aktuellen Auswahl
  auszuwählen.

* Tippe `&`, um Auswahlen auszurichten.

* Drücke `Alt-s`, um die Auswahl in Zeilen aufzuteilen.

---

## 6.1 Bis zu einem Zeichen auswählen

Tippe `f<zeichen>`, um bis zu einem Zeichen **einschließlich** auszuwählen
(find). Tippe `t<zeichen>`, um dasselbe **ohne** das Zeichen zu tun (till).
Tippe die Großbuchstaben `F` / `T`, um rückwärts zu arbeiten.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile. Setze den Cursor
   auf den ersten Bindestrich.
2. Tippe `f[`, um bis zur eckigen Klammer auszuwählen.
3. Tippe `d`, um deine Auswahl zu löschen.
4. Gehe ans Zeilenende und wiederhole das mit `F]`.
5. Gehe in die zweite mit `-->` markierte Zeile, direkt hinter den Pfeil.
6. Entferne die Bindestriche rund um den Satz mit `t` und `T`.

```text
 --> -----[Free this sentence of its brackets!]-----
 --> ------Free this sentence of its dashes!------
```

> [!note] Hinweis
> Anders als Vim beschränkt Helix diese Befehle nicht auf die aktuelle Zeile –
> es wird in der gesamten Datei nach dem Zeichen gesucht.

---

## 6.2 Der replace-Befehl

Tippe `r<zeichen>`, um alle ausgewählten Zeichen durch `<zeichen>` zu ersetzen.

1. Gehe in die zweite Zeile der Tabelle und setze den Cursor auf das erste `=`.
2. Tippe `t|` (Shift-\), um den `=`-Trenner auszuwählen.
3. Tippe `r-`, um den Trenner durch Bindestriche zu ersetzen.

```text
 | Month | Days |
 |=======|------|
 | Jan   | 31   |
 | Feb   | 28   |
 | Mar   | 31   |
 | ...   | ...  |
```

---

## 6.3 Wiederholung

Tippe `.`, um den letzten Einfügebefehl zu wiederholen. Drücke `Alt-.`, um die
letzte `f`- / `t`-Auswahl zu wiederholen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Nimm eine Änderung, Einfügung oder Ergänzung vor und wiederhole sie mit `.`.
3. Probiere `Alt-.` zusammen mit `f` und `t` aus, um zum Beispiel mehrere Sätze
   auszuwählen.

```text
 --> This is some text for you to repeat things. You can repeat
     insertions like changing words, or repeat selections like
     f / t.
```

---

## Kapitel 6 – Zusammenfassung

* Tippe `f` / `F`, um die Auswahl bis zu einem Zeichen **einschließlich** zu
  erweitern.
  * Tippe `t` / `T`, um die Auswahl bis **vor** ein Zeichen zu erweitern.

* Tippe `r`, um ausgewählte Zeichen zu ersetzen.

* Tippe `.`, um die letzte Einfügung zu wiederholen.
  * Drücke `Alt-.`, um die letzte `f`- / `t`-Auswahl zu wiederholen.

---

## 7.1 Durch geyankten Text ersetzen

Tippe `R`, um die Auswahl durch zuvor geyankten Text zu ersetzen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Tippe `w`, um `watermelons` auszuwählen, und dann `y`, um es zu yanken.
3. Wähle `oranges` mit `w` aus.
4. Tippe `R`, um `oranges` durch `watermelons` zu ersetzen.

```text
 --> I like watermelons because oranges are refreshing.
     I like watermelons because watermelons are refreshing.
```

---

## 7.2 Zeilen zusammenfügen

Tippe `J`, um die Zeilen der Auswahl zusammenzufügen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Tippe viermal `x` oder `4x`, um alle vier Zeilen auszuwählen.
3. Tippe `J`, um die Zeilen zusammenzufügen.

```text
 --> This sentence
is spilling over
onto other
lines.

     This sentence is spilling over onto other lines.
```

---

## 7.3 Zeilen einrücken

Tippe `>`, um eine Zeile einzurücken, und `<`, um die Einrückung zu verringern.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Gehe in die zweite Zeile und tippe `>`, um sie einzurücken.
3. Gehe in die dritte Zeile und tippe `<`, um die Einrückung zu verringern.

```text
 --> These lines
    are indented
         very poorly.

     These lines
     are indented
     much better.
```

---

## 7.4 Hoch- und Herunterzählen

Drücke `Ctrl-a`, um die Zahl in der Auswahl zu erhöhen. Drücke `Ctrl-x`, um sie
zu verringern.

1. Bewege den Cursor in die unten mit `-->` markierte **dritte** Zeile.
2. Drücke `Ctrl-a`, um den zweiten mit `2` markierten Punkt zu erhöhen.
3. Wiederhole das für den mit `3` markierten Punkt.
4. Gehe zum letzten Punkt und drücke `Ctrl-x`, um die `6` zu verringern.

```text
 --> 1) First point.
 --> 2) Added point.
 --> 2) Next point.
 --> 3) Another point.
 --> 6) Last point.
```

---

## Kapitel 7 – Zusammenfassung

* Tippe `R`, um die Auswahl durch geyankten Text zu ersetzen.

* Tippe `J`, um die Zeilen der Auswahl zusammenzufügen.

* Tippe `>` und `<`, um Zeilen ein- bzw. auszurücken.

* Drücke `Ctrl-a`, um die ausgewählte Zahl zu erhöhen.
  * Drücke `Ctrl-x`, um die ausgewählte Zahl zu verringern.

---

## 8.1 Register

Register sind Container, die über ein Zeichen identifiziert werden und Dinge wie
geyankten Text speichern. Register halten außerdem den zuletzt verwendeten
Suchbegriff sowie Makros, um die es im nächsten Abschnitt geht.

Tippe `"<zeichen>`, um das Register `<zeichen>` auszuwählen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Tippe `w`, um `watermelons` auszuwählen, und yanke mit `y`.
3. Tippe `w`, um `bananas` auszuwählen.
4. Wechsle mit `"b` in das Register `b` und yanke mit `y`.
5. Wähle `mangoes` aus und tippe `R`, um es durch `watermelons` zu ersetzen.
6. Wähle `pineapples` aus und tippe dann `"b R`, um es durch `bananas` zu
   ersetzen.

```text
 --> I like watermelons and bananas because my favorite fruits
     are mangoes and pineapples.
```

---

## 8.2 Makros

Makros sind eine Möglichkeit, eine Folge von Aktionen aufzuzeichnen, die du
wiederholen möchtest. Du kannst Makros auch in ein bestimmtes Register
aufzeichnen (Standard ist `@`).

Tippe `Q`, um die Aufzeichnung zu starten – am unteren Bildschirmrand sollte ein
Hinweis erscheinen. Tippe erneut `Q`, um die Aufzeichnung zu beenden. Tippe `q`,
um das Makro aus dem Register `@` (Standard) abzuspielen.

1. Bewege den Cursor in die unten mit `-->` markierte **erste** Zeile. Achte
   darauf, dass der Cursor auf dem `>` des Pfeils steht.
2. Tippe `Q`, um die Aufzeichnung zu starten.
3. Bearbeite die Zeile so, dass sie der untersten entspricht.
4. Verlasse den Insert-Modus und tippe erneut `Q`, um die Aufzeichnung zu
   beenden.
5. Gehe in die Zeile darunter und setze den Cursor wieder auf `>`.
6. Tippe `q`, um das Makro abzuspielen.

```text
 --> ... sentence doesn't have its first and last ... .
 --> ... sentence doesn't have its first and last ... .
     This sentence doesn't have its first and last word.
```

---

## Kapitel 8 – Zusammenfassung

* Tippe `"`, um ein anderes Register auszuwählen.

* Tippe `Q`, um die Aufzeichnung eines Makros in ein Register zu starten und zu
  beenden; Standard ist `@`.

* Tippe `q`, um ein Makro aus `@` oder dem ausgewählten Register abzuspielen.

---

## 9.1 Nach der Auswahl suchen

Die zuletzt mit `/` durchgeführte Suche wird im Register `/` gespeichert. `n` und
`N` beziehen sich beide auf das Register `/` – das heißt, wir können dieses
Register setzen, ohne eine Suche eintippen zu müssen.

Tippe `*`, um die Auswahl in das Register `/` zu kopieren und damit den
Suchbegriff auf die Auswahl zu setzen. Kopiert wird die primäre Auswahl, um die
es im Abschnitt über das Durchlaufen von Auswahlen geht.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Wähle `horse` mit `e` aus und tippe `*`.
3. Springe mit `n` und `N` zwischen den Vorkommen von `horse`.

```text
 --> A horse is a horse, of course, of course,
 --> And no one can talk to a horse of course.
```

> [!note] Hinweis
> `*` ist eine Kurzform für `"/y`, denn genau das tut es: Es kopiert die Auswahl
> in das Register `/`.

---

## 9.2 Auswahl beim nächsten Suchtreffer hinzufügen

Eine Eigenschaft des Select-Modus (`v`) ist, dass `n` und `N` die Auswahl nicht
zum nächsten Treffer verschieben, sondern bei jedem Treffer eine neue Auswahl
hinzufügen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Wähle das erste `bat` aus und tippe `*`, um es als Suchbegriff zu setzen.
3. Tippe `v`, um in den Select-Modus zu wechseln.
4. Tippe `n`, um das andere `bat` auszuwählen.
5. Ändere die `bat`s mit `c` oder `r` zu `cat`.

```text
 --> Everybody wants to be a bat,
 --> because a cat's the only bat
 --> who knows where it's at.
```

---

## 9.3 Die Jumplist verwenden

Helix kann „Sprünge“ protokollieren – also große Bewegungen, etwa eine Suche
oder den Sprung zur Definition einer Funktion im Code. Diese werden in der
sogenannten Jumplist gespeichert.

Drücke `Ctrl-s`, um deine aktuelle Position manuell in der Jumplist zu sichern.

Drücke `Ctrl-i` („in“) und `Ctrl-o` („out“), um dich in der Jumplist vorwärts
bzw. rückwärts zu bewegen.

1. Drücke irgendwo `Ctrl-s`.
2. Bewege dich weit weg in der Datei.
3. Drücke `Ctrl-o` (nur einmal!), um zur gespeicherten Position zurückzukehren.

---

## 9.4 Springen mit Zwei-Zeichen-Labels

Tippe `gw`, um die 2-Zeichen-Labels zu aktivieren. Der Anfang jedes Wortes wird
durch 2 hervorgehobene Zeichen ersetzt. Tippe eine beliebige Folge aus 2
hervorgehobenen Zeichen, um zum entsprechenden Label zu springen, oder drücke
ESC, um die Labels zu verwerfen.

Mit den 2-Zeichen-Labels springst du blitzschnell an jede Stelle im sichtbaren
Bereich.

1. Bewege den Cursor an den Anfang der unten mit `-->` markierten Zeile.
2. Drücke `gw`, um die 2-Zeichen-Labels zu aktivieren, und dann die beiden
   Zeichen, die die Buchstaben `he` am Anfang von `here` ersetzen, um zum
   entsprechenden Wort zu springen.

```text
 --> This is just a simple line of text.
     There may be many such lines
     But you really want to jump here!
     This is fast with the 2-character labels.
```

---

## Kapitel 9 – Zusammenfassung

* Tippe `*`, um das Suchregister auf die primäre Auswahl zu setzen.

* Tippe `n` / `N` im Select-Modus, um bei jedem Suchtreffer eine Auswahl
  hinzuzufügen.

* Drücke `Ctrl-s`, um die Position in der Jumplist zu sichern.
  * Drücke `Ctrl-i` und `Ctrl-o`, um in der Jumplist vorwärts und rückwärts zu
    gehen.

* Tippe `gw`, um die 2-Zeichen-Labels zu aktivieren, dann 2 beliebige Zeichen,
  um zum entsprechenden Label zu springen – oder ESC, um die Labels zu
  verwerfen.

---

## 10.1 Auswahlen durchlaufen und entfernen

Tippe `)` und `(`, um die primäre Auswahl vorwärts bzw. rückwärts durch die
Auswahlen zu bewegen.

Drücke `Alt-,`, um die primäre Auswahl zu entfernen.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Wähle beide Zeilen mit `xx` oder `2x` aus.
3. Tippe `s` für select, tippe `would` und drücke Enter.
4. Durchlaufe die primäre Auswahl mit `(` und `)` und hebe die Auswahl des
   zweiten `would` mit `Alt-,` auf.
5. Tippe `c` und `wood`, um die verbleibenden `would` zu `wood` zu ändern.

```text
 --> How much would would a wouldchuck chuck
 --> if a wouldchuck could chuck would?
```

---

## 10.2 Den Inhalt der Auswahlen rotieren

Drücke `Alt-)` und `Alt-(`, um den Inhalt der Auswahlen vorwärts bzw. rückwärts
zu rotieren.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Wähle beide Zeilen mit `xx` oder `2x` aus.
3. Tippe `s` für select, tippe `through|water|know` und drücke Enter.
4. Rotiere den Inhalt der Auswahlen mit `Alt-(` und `Alt-)`.

```text
 --> Jumping through the water,
 --> daring to know.
```

---

## 10.3 Groß- und Kleinschreibung ändern

Tippe `~`, um die Groß-/Kleinschreibung aller ausgewählten Buchstaben
umzuschalten. Tippe `` ` ``, um alle ausgewählten Buchstaben klein zu schreiben.
Drücke ``Alt-` ``, um alle ausgewählten Buchstaben groß zu schreiben.

1. Bewege den Cursor in die unten mit `-->` markierte **erste** Zeile.
2. Wähle jeden falsch groß- oder kleingeschriebenen Buchstaben aus und tippe
   jeweils `~`.
3. Gehe in die zweite mit `-->` markierte Zeile.
4. Tippe `x`, um die Zeile auszuwählen.
5. Tippe `` ` ``, um die Zeile in Kleinbuchstaben umzuwandeln.
6. Gehe in die dritte mit `-->` markierte Zeile.
7. Tippe `x`, um die Zeile auszuwählen.
8. Drücke ``Alt-` ``, um die Zeile in Großbuchstaben umzuwandeln.

```text
 --> thIs sENtencE hAs MIS-cApitalIsed leTTerS.
 --> this SENTENCE SHOULD all be in LOWERCASE.
 --> THIS sentence should ALL BE IN uppercase!
```

---

## 10.4 Auswahlen aufteilen

Tippe `S`, um jede Auswahl anhand eines Regex-Musters aufzuteilen.

1. Bewege den Cursor in die Zeile unter `---`.
2. Tippe `xx` / `2x`, um die Zeilen auszuwählen.
3. Tippe `S`, dann `\. |! ` und Enter (beachte die Leerzeichen nach `.` und `!`).
   Damit wird die Auswahl an jedem Punkt bzw. Ausrufezeichen in Sätze
   aufgeteilt.
4. Drücke `Alt-;`, um die Auswahlen umzukehren.
5. Tippe `;`, um die Auswahlen auf ein einzelnes Zeichen zu reduzieren – den
   ersten Buchstaben jedes Satzes.
6. Drücke ``Alt-` ``, um alle ausgewählten Buchstaben groß zu schreiben.

```text
---
these are sentences. some sentences don't start with uppercase
letters! that is not good grammar. you can fix this.
```

---

## Kapitel 10 – Zusammenfassung

* Nutze `)` und `(`, um die primäre Auswahl vorwärts bzw. rückwärts durch die
  Auswahlen zu bewegen.
  * Drücke `Alt-,`, um die primäre Auswahl zu entfernen.
  * Drücke `Alt-)` und `Alt-(`, um den Inhalt der Auswahlen zu rotieren.

* Tippe `~`, um die Groß-/Kleinschreibung ausgewählter Buchstaben umzuschalten.
  * Nutze `` ` `` und ``Alt-` ``, um ausgewählte Buchstaben klein bzw. groß zu
    schreiben.

* Tippe `S`, um Auswahlen anhand eines Regex aufzuteilen.

---

## 11.1 Eine Zeile auskommentieren

Drücke `Ctrl-c`, um die Zeile unter deinem Cursor auszukommentieren. Um den
Kommentar wieder zu entfernen, drücke erneut `Ctrl-c`.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Kommentiere nun die mit `-->` markierte Zeile aus.
3. Entferne den Kommentar anschließend wieder.

```text
 --> Comment me please
```

---

## 11.2 Mehrere Zeilen auskommentieren

Mit Auswahlen und mehreren Cursorn kannst du mehrere Zeilen auf einmal
auskommentieren, solange sie von der Auswahl bzw. den Cursorn erfasst werden.

1. Bewege den Cursor in die unten mit `-->` markierte Zeile.
2. Versuche nun, die weiteren mit `-->` markierten Zeilen auszuwählen oder
   zusätzliche Cursor dort zu setzen.
3. Kommentiere diese Zeilen aus.

```text
 --> How many are you going to comment?
 --> Is this enough for a comment?
 --> What are you doing?!
 --> Stop commenting me!
 --> AAAAaargh!!!
```

> [!note] Hinweis
> Wenn unter den Auswahlen oder mehreren Cursorn bereits auskommentierte Zeilen
> liegen, wird deren Kommentar nicht entfernt, sondern sie werden erneut
> auskommentiert.

---

## Kapitel 11 – Zusammenfassung

* Nutze `Ctrl-c`, um die Zeile unter deinem Cursor auszukommentieren. Drücke
  erneut `Ctrl-c`, um den Kommentar zu entfernen.
* Um mehrere Zeilen auszukommentieren, nutze Auswahlen und mehrere Cursor,
  bevor du `Ctrl-c` tippst.
  * Bereits auskommentierte Zeilen werden dabei nicht entkommentiert, sondern
    erneut auskommentiert.

---

## 12.1 Springen im Match-Modus

Um vom Normal-Modus in den Match-Modus zu wechseln, tippe `m`. Diese Funktion
ist besonders nützlich im Umgang mit Klammerpaaren und deren Inhalt.

Im Match-Modus stehen mehrere Aktionen zur Verfügung, wie das Hilfe-Popup zeigt.
Um zur passenden Gegenklammer zu springen, drücke einfach `mm`. Bewege
beispielsweise in den Zeilen unten (die mit `-->` beginnen) den Cursor im
Normal-Modus auf `(` und drücke dann `mm`, um zur zugehörigen `)` zu springen.
In der Zeile darunter funktioniert das genauso: Gehe etwa auf `]` und drücke
`mm`, um zu `[` zu springen.

```text
 --> you can (jump between matching parentheses)
 --> or between matching [ square brackets ]
 --> now { you know the drill: this works with brackets too }
```

---

## 12.2 Select inside im Match-Modus

Im Match-Modus kannst du auch den Inhalt „innerhalb“ eines Klammerpaares oder
anderer Begrenzer auswählen. In den Zeilen unten:

* Gehe in die `-->`-Zeile, setze den Cursor im Normal-Modus an eine beliebige
  Stelle zwischen den Klammern, zum Beispiel auf das `x`, und drücke `mi(` oder
  `mi)`, um den gesamten Inhalt innerhalb der Klammern auszuwählen (ohne die
  Klammern selbst). Wie gewohnt kannst du anschließend alles Mögliche mit der
  Auswahl anstellen (zum Beispiel `c` drücken, um sie zu ändern).

```text
 --> outside and (inside x parentheses) - and outside again
```

Probiere unten aus, dass dasselbe mit `[]`, `{}` oder mit verschachtelten
Kombinationen davon funktioniert (es wirkt dann auf das unmittelbar umgebende
Paar). Auch mit `""` und Ähnlichem klappt es.

```text
 --> test [ with square brackets ] !
 --> try ( with nested [ pairs of ( parentheses) and "brackets" ])
```

---

## 12.3 Select around im Match-Modus

Du kannst auch den „umgebenden“ Inhalt auswählen, also den Inhalt **samt** der
Begrenzer, indem du `ma` verwendest. Gehe zum Beispiel in die Zeile unten, setze
den Cursor im Normal-Modus an eine beliebige Position zwischen den `()` und
wähle den Inhalt der `()` einschließlich der umgebenden `()` aus, indem du `ma(`
oder `ma)` tippst. Wie gewohnt kannst du mit der Auswahl alles Mögliche machen,
etwa alles löschen mit `ma(d`.

```text
 --> you ( select x around ) to include delimiters in the select
```

Das funktioniert natürlich auch mit anderen Begrenzern:

```text
 --> try [ with 'square' brackets ] too!
```

---

## 12.4 Surround im Match-Modus

Der Match-Modus kann auch dazu genutzt werden, die aktuelle Auswahl mit Zeichen
zu umschließen. Gehe zum Beispiel in die Zeile unten und dann:

* i) Wähle den Abschnitt `select all of this` aus (bewege dazu im Normal-Modus
  den Cursor an den Anfang von `select`, wechsle mit `v` in den Select-Modus und
  wähle mit `4e` die nächsten 4 Wörter aus).
* ii) Drücke `ms(` oder `ms)`, um die Auswahl mit einem Klammerpaar zu
  umschließen.

```text
 --> so, select all of this, and surround it with ()
```

Dasselbe geht mit anderen Begrenzern: zum Beispiel `ms'` auf `WORD` unten, um es
mit einem Paar `''` zu umschließen. Probiere es auch mit einem umschließenden
Paar `""`, `{}` oder `[]`.

```text
 --> surround this WORD !
```

---

## 12.5 Surround löschen im Match-Modus

Mit dem Befehl `md` kannst du ein umschließendes Paar von Begrenzern löschen.
Bewege den Cursor in der Zeile unten an eine beliebige Stelle innerhalb des
`()`-Paares, zum Beispiel auf das `x`, und drücke von dort aus im Normal-Modus
`md(` oder `md)`, um das umschließende Klammerpaar zu löschen.

```text
 --> delete (the x pair of parentheses) from within!
```

Natürlich kannst du auch andere Arten von Umschließungen löschen:

```text
 --> delete (nested [delimiters]): "this" will delete the nearest
matching surrounding pair.
 --> delete "layers "of" quote marks" too: this will delete the
nearest previous and following quote marks
```

Der Versuch, nicht vorhandene umschließende Begrenzer zu löschen, gibt in der
unteren Leiste einen Fehler aus und bewirkt sonst nichts.

---

## 12.6 Surround ersetzen im Match-Modus

Mit dem Befehl `mr` kannst du umschließende Begrenzerpaare ersetzen. Bewege den
Cursor in der Zeile unten an eine beliebige Stelle innerhalb des `()`-Paares,
zum Beispiel auf das `x`, und drücke dann im Normal-Modus `mr([`, um das
`()`-Paar durch ein `[]`-Paar zu ersetzen.

```text
 --> replace the (pair from x within), with something else
```

Dieser Befehl wirkt auf das nächstgelegene umschließende Paar; du kannst also in
den folgenden Zeilen verschiedene Umschließungen ersetzen:

```text
 --> some (nested surroundings [can be replaced])
 --> this "works with 'other surroundings' too"
```

Du kannst auch versuchen, ein nicht vorhandenes Paar zu ersetzen: Dann erscheint
in der unteren Leiste eine Fehlermeldung, und es passiert nichts.

---

## Kapitel 12 – Zusammenfassung

Mit der Taste `m` wechselst du in den Match-Modus; ein Popup zeigt die
verfügbaren Aktionen. Damit kannst du:

* mit `mm` zum passenden Begrenzerpaar springen (unter dem Cursor muss ein
  Begrenzer stehen, der zu einem Paar gehört)
* mit `mi(` und Ähnlichem den Inhalt innerhalb eines den Cursor umgebenden
  Begrenzerpaares auswählen (also den Inhalt ohne die Begrenzer)
* mit `ma(` und Ähnlichem um ein den Cursor umgebendes Begrenzerpaar herum
  auswählen (also Inhalt **und** Begrenzer)
* mit `md(` und Ähnlichem umschließende Begrenzer löschen
* mit `ms(` umschließende Begrenzer um die Auswahl herum hinzufügen
* mit `mr([` ein die Auswahl umschließendes Begrenzerpaar ersetzen, also
  beispielsweise umschließende `()` durch `[]`

---

## 13.1 Neuen Split erzeugen

Drücke im Normal-Modus `Ctrl-w`, um das Fenster-Menü zu öffnen, das eine Liste
der verfügbaren Befehle anzeigt.

Um einen neuen, leeren Buffer in einem vertikalen Split in der rechten Hälfte
deines aktuellen Fensters zu öffnen, nutze `Ctrl-w nv` (also gleichzeitig Ctrl
und w drücken, dann `n`, danach `v`). Dein aktuelles Fenster wird nun vertikal
in 2 Teile geteilt. In der rechten Hälfte erscheint ein neuer, leerer Buffer,
und dein Cursor springt in diesen neuen vertikalen Split.

Um einen neuen, leeren Buffer in einem horizontalen Split zu erzeugen, drücke
`Ctrl-w ns`. Damit wird dein aktuelles Fenster horizontal geteilt, ein neuer
Buffer angelegt und der Cursor in den neuen horizontalen Split bewegt.

---

## 13.2 Zwischen Splits wechseln

Nutze `Ctrl-w k`, um in den Split oberhalb des aktuellen zu wechseln, `Ctrl-w j`
für den Split darunter, `Ctrl-w h` für den Split links und `Ctrl-w l` für den
Split rechts. Um zum nächsten Split (in der Reihenfolge des Öffnens) zu
navigieren, drücke `Ctrl-w w`.

Du kannst nun in deinen neuen Buffern und Splits tun, was du möchtest. Wenn du
mit deinem neuen Buffer-Split fertig bist, schließe ihn mit `Ctrl-w q`. Wechsle
mit `Ctrl-w l` und dann `Ctrl-w j` in den Split unten rechts und drücke dann
`Ctrl-w q`, um genau diesen Split zu schließen.

Mit `Ctrl-w o` kannst du außerdem alle Splits außer dem aktuellen schließen.
Öffne einen dritten vertikalen Split mit `Ctrl-w nv`, wechsle dann mit zweimal
`Ctrl-w h` in den Split ganz links und drücke von dort aus `Ctrl-w o`, um alle
Splits außer diesem zu schließen.

---

## 13.3 Den aktuellen Buffer splitten

Nutze `Ctrl-w s`, um die Ansicht des aktuellen Buffers horizontal zu teilen, und
`Ctrl-w v`, um sie vertikal zu teilen – der Buffer ist dann in beiden Splits
geöffnet.

Schließe zusätzliche Splits mit `Ctrl-w o`, um zur Einzelfensteransicht
zurückzukehren.

---

## 13.4 Befehle zum Splitten verwenden

Auch mit den Befehlen `:vsplit` (kurz `:vs`) und `:hsplit` (kurz `:hs`) lässt
sich ein bestimmter Buffer vertikal oder horizontal splitten. Gib zum Beispiel
den Befehl

```
 :vs something
```

ein, um rechts einen neuen vertikalen Split namens `something` zu öffnen. Da
`something` hier keine existierende Datei ist, wird ein neuer Buffer mit diesem
Namen geöffnet; du kannst `something` aber durch einen beliebigen Dateinamen
ersetzen, um diese Datei in einem neuen Buffer zu öffnen. Genauso kannst du den
Befehl

```
 :hs some_more
```

eingeben, um in der unteren Hälfte einen neuen Buffer namens `some_more` zu
öffnen. `some_more` kann eine beliebige Datei oder ein Pfad sein, um statt eines
neuen leeren Buffers genau diese Datei bzw. diesen Pfad zu öffnen.

---

## 13.5 Splits tauschen

Öffne mit `:vs hello1` einen Split links und danach mit `:hs hello2` einen Split
darunter.

Drücke aus `hello2` heraus `Ctrl-w K`, um ihn mit dem Split darüber zu tauschen.
Nun liegt `hello2` oben und `hello1` unten.

Drücke weiterhin aus `hello2` heraus `Ctrl-w H`, um mit dem Split links zu
tauschen: Jetzt liegt `hello2` links und der Tutor oben rechts. Nach `Ctrl-w`
kannst du `HJKL` verwenden, um mit dem Buffer links / unten / oben / rechts zu
tauschen.

Wechsle zurück in den Tutor-Split und drücke `Ctrl-w o`, um nur diesen Split zu
behalten.

---

## 13.6 Splits transponieren

Öffne mit `:vs hello1` einen Split links und danach mit `:hs hello2` einen Split
darunter.

Wechsle in den Tutor-Split und drücke dann `Ctrl-w t`, um den aus diesem Fenster
geöffneten vertikalen Split zu transponieren: `hello1` und `hello2` liegen nun
unterhalb des Tutors statt rechts davon. Drücke erneut `Ctrl-w t`, um zurück zu
transponieren.

Wechsle in den `hello1`-Split und drücke `Ctrl-w t`, um den aus diesem Fenster
geöffneten horizontalen Split zu transponieren: `hello2` liegt nun rechts von
`hello1` statt darunter. Drücke `Ctrl-w t`, um zurück zu transponieren.

Wechsle zurück in den Tutor-Split und drücke `Ctrl-w o`, um alle Fenster außer
dem Tutor zu schließen.

---

## 13.7 Split aus dem File-Picker öffnen

Splits lassen sich auch direkt aus dem File-Picker öffnen. Drücke `space f`, um
den File-Picker zu öffnen. Dort kannst du Text eingeben, um Dateien per
Fuzzy-Matching zu suchen, und mit den Pfeiltasten nach oben und unten die
ausgewählte Datei wechseln (erkennbar am Symbol `>`). Wenn du den File-Picker
verlassen willst, drücke Escape.

Wähle im File-Picker eine beliebige Datei aus. Du könntest sie mit Enter in der
aktuellen Ansicht öffnen (tu das jetzt bitte nicht). Du kannst sie aber auch in
einem neuen Split öffnen: Drücke `Ctrl-v`, um die ausgewählte Datei in einem
neuen vertikalen Split zu öffnen. Drücke erneut `space f`, wähle eine beliebige
Datei aus und drücke `Ctrl-s`, um sie in einem horizontalen Split zu öffnen.

Wechsle zurück in den Tutor-Split und drücke `Ctrl-w o`, um alle Splits außer
diesem zu schließen.

---

## Kapitel 13 – Zusammenfassung

Mit Splits kannst du entweder denselben Buffer mehrfach oder mehrere Buffer
gleichzeitig anzeigen. Die wichtigsten Fenster- und Split-Befehle erreichst du
mit `Ctrl-w`. Zwischen Splits wechselst du mit `Ctrl-w hjkl`, einen Split
schließt du mit `Ctrl-w q`, und alle außer dem aktuellen Split schließt du mit
`Ctrl-w o`.

Splits lassen sich außerdem mit den Befehlen `:vs DATEINAME` und `:hs DATEINAME`
öffnen.

Ebenso kannst du Splits direkt aus dem File-Picker heraus nutzen: `Ctrl-v` öffnet
die ausgewählte Datei in einem neuen vertikalen Split, `Ctrl-s` in einem
horizontalen.

---

> [!info] Schlussbemerkung
> Dieses Tutorial ist noch in Arbeit. Weitere Abschnitte sind geplant.
