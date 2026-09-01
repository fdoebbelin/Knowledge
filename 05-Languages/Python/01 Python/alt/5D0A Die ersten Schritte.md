---
aliases: 
tags: 
title: 5D0A Die ersten Schritte
---

A little girl goes into a pet show and asks for a wabbit. The shop keeper looks down at her, smiles
and says:
„Would you like a lovely fluffy little white rabbit, or a cutesy wootesly little brown rabbit?“
„Actually“, says the little girl, „I don’t think my python would notice.“
Nick Leaton

In diesem Abschnitt wollen wir unsere Arbeitsumgebung kennen lernen. Zu diesem Zweck werden wir ein
sogenanntes Hello World schreiben, d. h. ein Programm, das lediglich den Text Hello World! auf dem
Bildschirm ausgibt. Im Weiteren werden wir Python dazu benutzen, einfache Rechnungen umzusetzen.

## 1.1. Der Kommandozeilen-Interpreter

Wenn Sie eine Kommandozeilen-Umgebung starten, können Sie Textkommandos an das Betriebssystem
senden. Überwiegend handelt es sich dabei um die Anweisung, andere Programme auszuführen. Die
Anweisung python31 ist ein solcher Befehl. Tippen Sie dies ein und drücken Sie [ENTER] um den
Python-Interpreter zu starten.
Sie werden nun einen kurzen Versionstext sehen und hinter drei Pfeilen (>>>) einen blinkenden Cursor.
Obwohl Sie noch immer dasselbe Fenster angezeigt bekommen, sind sie nun in der Interpreter-Umgebung.
Die Befehle, die Sie hier eingeben können, gehören zum Sprachumfang von Python!

### 1.1.1. Hello World

Ein solcher Befehl ist print. Er dient dazu, Informationen auf dem Bildschirm auszudrucken–also genau
das, was wir für unser Hello-World-Programm brauchen. Natürlich muss dazu auch angegeben werden,
was gedruckt werden soll. Wir müssen also einen Text als Argument übergeben. Dies tun wir, indem wir
den Text in Klammern () und Anführungszeichen ”” einrahmen. Die Klammern dienen dazu, klar zu
machen, was Argument ist, und was zum restlichen Code gehört. Die Anführungszeichen brauchen wir,
um Text, der buchstäblich zu behandeln ist, von anderem Code abzutrennen. (Stellen Sie sich vor, sie
wollten den Text print auf dem Bildschirm ausgeben. Der Computer versteht ohne Anführungszeichen
den Unterschied zwischen dem Text print und dem Befehl print nicht. Vielleicht verstehen Sie nun
den Anfang des Vorworts.) Geben Sie also ein:
print("Hello World!")

1 Die Programmiersprache Python wurde seit ihrer Veröffentlichung im Jahre 1991 beständig weiterentwickelt. Manche

Konzepte mussten komplett überarbeitet werden, so dass die einzelnen Versionen der Sprache nicht zwingend kompatibel
miteinander sind. Wir arbeiten in der derzeit aktuellen Version 3.8. Auf einem Rechner können mehrere PythonInterpreter nebeneinander installiert sein. Daher müssen wir beim Aufruf die Versionsnummer 3 mit nennen.

1

Der Interpreter reagiert prompt, und auf dem Bildschirm finden Sie exakt das, was Sie erwarten: Die
Zeile Hello World!.
Nach den letzten Schritten sollten Sie also folgendes auf dem Bildschirm sehen:
Starten des Python-Interpreters und Hello-World

```
blue-chameleon@blue-chameleon:~$ python3
Python 3.8.2 (default, Apr 27 2020, 15:53:34)
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> print("hello world!")
hello world!
Sollten Sie sich vertippen, wird ihnen dies in Form einer (anfangs etwas kryptischen) Fehlermeldung
mitgeteilt:
Eingabe mit Fehlern
>>> pirnt("hello world!")
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
NameError: name 'pirnt' is not defined
```

Die letzte Zeile dieser Fehlermeldung teilt Ihnen mit, dass der Befehl pirnt nicht existiert. Sie werden
diese Fehlermeldung sehr häufig bei Tippfehlern sehen, wie dies in diesem Beispiel der Fall war. Da
Programme zum Teil sehr lang werden können, unterstützt Sie der Interpreter beim Debuggen, indem in
der vorletzten Zeile der Ausgabe die Stelle genannt wird, an der die fehlerhafte Eingabe stattfand: line
1 sagt, dass die erste Zeile dieses Codes fehlerhaft war.
Vergessen wir beispielsweise, die Anführungszeichen abzuschließen, erhalten wir eine ähnliche Fehlermeldung:
Eingabe mit Fehlern

```
>>> print("hello world)
File "<stdin>", line 1
print("hello world)
^
SyntaxError: EOL while scanning string literal
```

EOL steht für end of line: Bevor der string literal (also unser Text) durch ein abschließendes Anführungszeichen beendet wurde, endete die Zeile.
Ein interessantes Verhalten erzielen Sie, wenn Sie die abschließende Klammer vergessen: Argumente
in Python dürfen sich über mehrere Zeilen erstrecken. Anstatt eine Fehlermeldung zu zeigen, wird der
Interpreter Sie über drei Punkte (...) auffordern, die Zeile fortzusetzen. Wenn Sie hier die Klammer
nachträglich schließen, erhalten Sie die erwartete Ausgabe:
Eingabe über mehrere Zeilen

```
>>> print("hello world"
... )
hello world
```

Mit dem Befehl

```
quit()
```

beenden Sie den Kommandozeilen-Interpreter wieder; sie sind nun wieder in der Umgebung Ihres
Betriebssystems, wo Sie also keine Python-Befehle mehr eingeben können.

## 1.2. Script-Dateien

Mit dem letzten Abschnitt haben Sie den ersten Python-Befehl print kennen gelernt! In den KommandozeilenInterpreter eingegeben bewirkt er eine direkte Ausgabe auf dem Bildschirm. Sie werden sehr bald weitaus
komplexere Programme schreiben, für die es umständlich wäre, sie Zeile für Zeile für jede Ausführung
neu einzugeben.
Stattdessen können Sie ein Textdokument anlegen, in dem Sie alle Anweisungen nacheinander eingeben
und speichern, und den Interpreter anschließend dazu auffordern, diese Datei zu lesen und den Code darin
auszuführen. Wichtig hierbei ist, dass es sich wirklich um eine reine Textdatei handelt, dass also keine
Formatierungen oder sonstigen Inhalte enthält, die über den reinen Code hinaus gehen. Verwenden Sie
also zum Schreiben von Code nicht Programme wie Word, LibreOffice o. ä., sondern Code/Text-Editoren.
Ich empfehle:

- für Linux
–kate (KDE-Editor): auf die Arbeit mit vielen Programmiersprachen ausgelegt, sehr lightweight
–gedit: oft vorinstalliert, minimale Features aber alles notwendige gegeben
–geany: auf größere Projekte ausgelegt, aber immer noch hinreichend Ressourcen schonend
- für Windows
–Notepad++: Bietet alle Funktionalitäten, die das Programmieren angenehm machen, ohne
dabei zu viele Systemressourcen zu verbrauchen.
Siehe https://notepad-plus-plus.org/
–Notepad: Immer vorinstalliert. Die Arbeit mit diesem Programm ist oft mühselig, da Features
wie Syntax Highlighting oder Automatische Einrückung nicht gegeben sind; dafür muss nichts
installiert werden
In diesen (und etwa einer Million weiteren) Editoren können Sie Code verfassen und als *.py-Datei
abspeichern. Aus der Kommandozeile können Sie diesen Code an den Interpreter weitergeben, indem Sie
eingeben:
python3 [myCode].py
Wobei [myCode] selbstverständlich durch den von Ihnen vergebenen Dateinamen ersetzt werden muss.

3

1.2.1. Beispiel
Schreiben Sie den folgenden Code in eine Textdatei, und speichern Sie diese als HelloWorld.py ab.
(Achten Sie auch auf Groß/Kleinschreibung).
Datei HelloWorld.py
1

print("Hello World!")

Starten Sie eine Kommandozeilen-Umgebung, und wechseln in dieser in das Verzeichnis, unter dem Sie
die Datei abgespeichert haben2 . In diesem Fall sei der Code unter ~/Codes abgelegt. Zum Ausführen
dieses Codes geben Sie also ein:
Starten des Python-Interpreters und Hello-World
blue-chameleon@blue-chameleon:~$ cd Codes/
blue-chameleon@blue-chameleon:~/Codes$ python3 HelloWorld.py
Hello World!

### 1.3. IDEs

Neben der Arbeit mit Texteditoren, die vom Interpreter abgegrenzt stehen, existieren auch IDEs, also
Integrated Development Environments. Es handelt sich dabei um Programme, die eine direkte Anbindung
an den Interpreter haben und somit Code-Schreiben und Ausführen im selben Fenster erlauben.
Viele empfinden es als bequemer, mit IDEs zu arbeiten. Diese Programme sind oft aber auch etwas
aufwändiger gebaut, und brauchen länger, bis sie geladen sind. Experimentieren Sie hier selbst, welcher
Modus Ihnen am besten zusagt; für den Kurs sind beide Wege–Text-Editor und IDE–gangbare
Wege.
Ich empfehle die IDE spyder3. Linux-User können diese einfach aus dem Paketverwaltungssystem
heraus installieren; Windows-User mögen von https://www.spyder-ide.org/ die Installationspakete
herunterladen.
In Abbildung 1.1 sehen Sie die Arbeitsumgebung des Programms Spyder. Insbesondere finden Sie links
einen größeren Bereich, in dem sie komplexere Codes schreiben können, wie schon in Abschnitt 1.2
angedeutet. In der rechten Fensterhälfte sehen Sie den Interpreter-Bereich, in den Sie direkt PythonKommandos eingeben können. Genauso, wie in Abschnitt 1.1 gezeigt, werden die Befehle, die Sie hier
eintippen, sofort ausgeführt.

1.4. Rechnen
Wie erwähnt können wir Python dazu benutzen, einfache Berechnungen ausführen zu lassen. Dazu
tippen wir diese einfach direkt in die Interpreter-Umgebung ein:

```
Python als „Taschenrechner“
>>> 1 + 2
3
```

Diese Rechnungen dürfen aus beliebig vielen Operationen bestehen, halten sich an die Regel „Punkt vor
Strich“ und können auch Klammern enthalten:

```
Python als „Taschenrechner“
>>> ((1 - 5) * 3) / (4 + 1) ** 2
-0.48
```

Dabei werden folgende Zeichen als Operatoren verstanden:

|              Zeichen              | Funktion                                                                                                                 | Beispiel                                                                         |
|:---------------------------------:| ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------- |
| +<br>-<br>*<br>/<br>//<br>%<br>** | Addition<br>Subtraktion<br>Multiplikation<br>Division<br>Ganzzahl-Division<br>Modulo (Rest der Division)<br>Potenzierung | 1+2=3<br>5 - 7 = -2<br>2*4=8<br>7 / 5 = 1.4<br>7 // 5 = 1<br>7%5=2<br>3 ** 2 = 9 |

```
Komplexe Zahlen
>>> (1j)**2
(-1+0j)
```

Wie Sie sehen, wird das Ergebnis von Rechnungen mit komplexen Zahlen als komplexe Zahl ausgegeben,
selbst wenn die Zahl rein reell ist. Mehr dazu im Abschnitt 1.4.2.

### 1.4.1. Variablen

Die Ergebnisse einer Rechnung können in Variablen gespeichert werden. Es handelt sich hierbei um Speicherstellen, denen Sie einen mehr oder minder beliebigen Namen geben können:

```
Variable für Zwischenergebnisse
>>> x = 3 + 7
>>> x ** 2
100
```

Variablen können einzelne Buchstaben sein, dürfen aber auch ganze Worte zum Namen haben. Im
Variablennamen dürfen auch der Unterstrich (`_`) und die Ziffern 0-9 vorkommen; jedoch muss das erste
Zeichen ein Buchstabe sein. Python ist case sensitive, d. h. zwischen Groß- und Kleinschreibung wird
unterschieden.
Name
x
counter
CounTer
number_of_elements
list4
5th_list
list 4
Best_List_Ever!
print

Erlaubt
ja
ja
ja
ja
ja
nein
nein
nein
Problematisch

Begründung

Ziffer als erstes Zeichen
Leerzeichen
Rufezeichen
überschreibt den Befehl print

Tabelle 1.2.: Beispiele für Variablen in python3
Sprechende Variablennamen
Ihre Programme werden sehr bald einige Komplexität annehmen. Sie sollten daher Variablen so
benennen, dass auf den ersten Blick erkennbar wird, welche Art Information gespeichert wird.
Der Name ListLength ist in jedem Fall dem Namen l vorzuziehen.

6

Schlüsselworte
Die Liste oben nennt das Symbol print als erlaubten, aber problematischen Namen. Tatsächlich
können Sie in Python die Sprachelemente umdefinieren, und so etwa print als Variable benutzen
oder eine andere Routine unter diesem Namen aufrufen. Im Sinne von Lesbarkeit und Kompatiblität mit anderen Programmen sollten Sie hiervon aber Abstand nehmen! Wenn Sie print
überschreiben, können Sie zunächst nichts mehr auf dem Bildschirm ausgeben.
Da Sie gerade erst beginnen, die Sprache Python zu erlernen, können Sie natürlich noch nicht
alle Symbole kennen, die bereits vergeben sind. Wenn Sie einen Editor mit Syntax-Highlighting
verwenden, können Sie aber i. d. R. diese farblichen Markierungen zur Hilfe nehmen: Wenn der
Editor ihr Symbol wie einen Befehl markiert, sollten Sie es umbenennen. Wird keine besondere
Farbe zugewiesen, so ist der Name vermutlich noch frei. Einige Schlüsselworte sind besonders
geschützt, und können nicht überschrieben werden. Sie erhalten die Fehlermeldung SyntaxError:
invalid syntax, falls Sie versuchen, ein solches Schlüsselwort als Variablenname zu verwenden.
Unterstriche in Variablennamen
Variablennamen dürfen prinzipiell an jeder Stelle Unterstriche enthalten, auch als erstes Zeichen.
Es ist aber Konvention, dies nur in bestimmten Situationen zu tun, auf die ich an gegebener
Stelle erst eingehen werde. Vermeiden Sie daher vorerst Namen wie `_var`.
Non-ASCII-Variablennamen (Umlaute, Sonderzeichen, . . . )
Python 3 erlaubt es prinzipiell, Variablennamen aus dem UTF-8-Zeichenvorrat zu wählen. Das
bedeutet, dass neben den lateinischen Klein- und Großbuchstaben (a-z, A-Z) auch Umlaute,
Zeichen mit Akzenten, griechische, japanische, . . . Zeichen für Variablennamen erlaubt sind. Dies
führt aber schnell zu Kompatibilitätsproblemen. Neben den offensichtlichen Problemen–Kollegen
in anderen Ländern könnten die Schriftzeichen, die zur Bedienung Ihres Codes nötig sind, nicht
eingeben können–ist manchmal schon das Versenden und Ausführen von Code auf einem anderen
Rechner in derselben Arbeitsgruppe schwierig.
Während Python also Variablennamen wie äußerstWichtig durchaus erlaubt, sollten Sie also
dennoch nur auf den englischen Zeichenvorrat zurückgreifen, und eine Variable beispielsweise
exceptionallyImportant benennen.
Variablen können aktualisiert (d. h. überschrieben werden). Dies kann auch mit Bezug auf den alten
Wert derselben Variable geschehen:

```
Variable für Zwischenergebnisse
>>> x = 1
>>> x
1
>>> x = 2
>>> x
2
>>> x = x + 1
>>> x
3
```

7

Python ist kein Gleichungslöser
Für mathematisch denkende KursteilnehmerInnen mag die Zeile x = x + 1 unsinnig wirken.
Offensichtlich gibt es keine Zahl x, die diese Gleichung erfüllt. In Python beschreiben wir auf
diese Art aber auch keine Gleichung, sondern einen Arbeitsauftrag: Speichere in der Variable x
den Wert der Summe des aktuellen Werts von x plus 1!
Denken Sie an das Vorwort bei der Arbeit mit Computern: Maschinen verstehen komplexe
Aufgaben wie das Lösen eines Gleichungssystems nicht.
Shorthands
Das Aktualisieren eines Werts unter Bezug auf den alten Wert ist ein häufiger Arbeitsschritt beim
Programmieren. Daher wurden Abkürzungen (Shorthands) eingeführt. So steht zum Beispiel der
Ausdruck
x += 1
für den Code
x = x + 1
Ähnlich sind auch x -= y, x *= y, usw. erlaubt.
Die Werte von Variablen können in einem Schritt getauscht werden, indem wir ein Komma zur Hilfe
nehmen:
Variable für Zwischenergebnisse

>>> x = 1
>>> y = 2
>>> x, y = y, x
>>> x
2
>>> y
1
Ein Dreieckstausch (d. h. die Zuhilfe-Nahme einer dritten Variable) ist nicht nötig. (Intern führt Python
einen Dreieckstausch aus; dies wird aber automatisch für Sie erledigt, ohne weiteres zutun Ihrerseits).

1.4.2. Datentypen
In diesem Abschnitt arbeiten wir mit Zahlen. Für Sie als Mensch ist eine Zahl eindeutig durch ihren
Wert bestimmt: 1 = 1.0 = 1 + 0j = eins. Ein Computer „kennt“ aber zunächst keine Werte, sondern nur
binäre Information. Einer Folge von Einsen und Nullen kann nicht angesehen werden, ob diese jetzt eine
ganze Zahl, eine komplexe Zahl, einen Teil eines Bildes oder eine Anweisung eines Computerprogramms
darstellen. Daher wird jeder Information ein Datentyp zugeordnet, also eine Anweisung, wie die Folge
von Einsen und Nullen zu interpretieren ist.
Vorerst beschäftigen wir uns mit vier Datentypen:
- int–Ganzzahlen, also 0, 1, 2, 3, . . . , sowie negative Ganzzahlen
- float–Fließkommazahlen, also 3.14 oder 1.0. (Beachten Sie: als Dezimaltrennzeichen verwenden
wir einen Punkt, kein Komma.)

8

- complex–Komplexe Zahlen, also (1+2.7j)
- str–Strings, also Zeichenketten wie "Hallo Welt"
Der Datentyp eines Werts wird bei seiner „Berechnung“ festgelegt und zusammen mit der Variablen
gespeichert, über die der Wert Verfügbar gehalten wird. Dabei gilt die Grundregel, dass keine Information
verloren gehen darf. Bei der Addition einer Ganzzahl (int) und einer Fließkommazahl (float) darf
beispielsweise die Information über die Nachkomma-Anteil nicht verloren gehen (selbst, wenn dieser .0
ist). Betrachten Sie hierzu folgendes Beispiel:
Datentypen bei Addition

>>> 1 + 1
2
>>> 1.0 + 1
2.0
>>> 1 + 1.0
2.0
>>> 1.0 + 1.0
2.0
In der ersten Zeile (1 + 1) sind nur Ganzzahlen beteiligt. Somit ist das Ergebnis auch eine Ganzzahl,
und wird folgerichtig als solche (d. h. ohne Nachkommastelle) ausgegeben. In allen anderen Fällen ist
immer mindestens eine Fließkommazahl beteiligt; das Ergebnis ist daher immer 2.0 (nicht nur 2).
Bei der Division wird immer eine Fließkommazahl berechnet, egal ob die Argumente vom Typ int oder
float sind.
Ähnlich verhält es sich bei komplexen Zahlen: Sobald eine komplexe Zahl an der Rechnung beteiligt ist,
wird auch das Ergebnis vom Typ complex sein. Da complex-Werte auch Nachkomma-Werte speichern
können, übertrifft diese Regel die bzgl. floats.
Wenn Sie sich nicht sicher sind, welchen Datentyp eine Variable hat, können Sie den Befehl
type(Ausdruck)
benutzen. Dabei steht Ausdruck für eine Variable, eine Zahl oder eine komplette Rechnung.
Beispiele zu type (1)
>>> type(1)
<class 'int'>
>>> type(1.0)
<class 'float'>
>>> type(1j)
<class 'complex'>
>>> type(1+1.0)
<class 'float'>
>>> a=1j**2
>>> type(a)
<class 'complex'>
>>> a
(-1+0j)

9

Wollen Sie erzwingen, dass das Ergebnis in einen bestimmten Typ umgewandelt wird, so können Sie den
Datentyp vor einen Ausdruck setzen, und diesen einklammern:
Datentyp(Ausdruck)
Dabei können Informationen verloren gehen:
Beispiele zu type (2)

>>> a = int(1 + 1.9)
>>> type(a)
<class 'int'>
>>> a
2
in diesem Beispiel etwa wird der Nachkommaanteil abgeschnitten.
Wie bereits erwähnt, sind Strings (Zeichenketten) dadurch erkennbar, dass ihr Inhalt durch doppelte
Anführungszeichen (”. . . ”) vom restlichen Code abgegrenzt wird. Alternativ können auch einfache
Anführungszeichen (’. . . ’) verwendet werden. Dies hat den Zweck, es Programmierern einfach zu machen,
Strings zu Erzeugen, in denen auch selbst wieder Anführungszeichen vorkommen.
Beispiele zu Strings (1)
>>> 'abc'
'abc'
>>> "abc"
'abc'
>>> "abc'def'ghi"
"abc'def'ghi"
>>> 'abc"def'
'abc"def'
Auch mit Strings kann „gerechnet“ werden; hier sind jedoch nur die Addition (+) und die Multiplikation
(*) mit Ganzzahlen definiert. Die Addition verkettet zwei Strings; die Multiplikation wiederholt einen
String mehrere Male:
Beispiele zu Strings (2)
>>> "ab" + 'cd'
'abcd'
>>> 3 * "ab"
'ababab'
>>> 0 * "ab"
''
>>> "ab" + "'c'def"
"ab'c'def"
Die Befehle int, float, complex können–in begrenztem Maße–auch auf Strings angewandt werden:

10

Konversion von Strings zu Zahlentypen

>>> int("1")
1
>>> int("1.3")
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
ValueError: invalid literal for int() with base 10: '1.3'
>>> float("1.3")
1.3
>>> float("1,3")
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
ValueError: could not convert string to float: '1,3'
>>> complex("1j")
1j
>>> int("one")
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
ValueError: invalid literal for int() with base 10: 'one'
Wie Sie sehen, wird die Darstellung als Text in Zahlen zurückverwandelt, sofern das für den gewünschten
Zieltyp möglich ist; andernfalls erhalten Sie eine Fehlermeldung.
Machen Sie sich klar: Für den Computer sind Text und Zahlen unterschiedliche Informationen! Eine
semantische Interpretation ist nicht möglich. Machen Sie sich daher auch klar, was der Unterschied
zwischen diesen drei Additionen ist:
Strings und ints (1)
>>> x = "1"
>>> y = "2"
>>> x + y
'12'
>>> int(x + y)
12
>>> int(x) + int(y)
3
Wir beginnen mit den String-Variablen x und y. Die Addition von Strings ist gleichbedeutend mit der
Verkettung; daher ist das Ergebnis von x + y auch folgerichtig der String "12".
Der Aufruf von int in int(x + y) erhält als Argument den Wert x + y, also den String "12". Folgerichtig
wird die Zahl 12 berechnet.
Im dritten Teilbeispiel int(x) + int(y) dagegen werden separat die Zahlen 1 und 2 aus den Variablen
x und y berechnet, und diese dann addiert. Entsprechend kann erst hier das Ergebnis die Zahl 3 sein.
Natürlich können Sie auch beliebige Zahlen in Strings umwandeln; dazu verwenden Sie einfach den
Befehl str:

11

Strings und ints (2)

>>> x = 1
>>> y = 2
>>> str(x + y)
'3'
>>> str(x) + str(y)
'12'
Sprechweise: dynamische Typisierung und duck-typing
In vielen Programmiersprachen wird der Datentyp von Variablen einmal festgelegt und darf
sich dann für das weitere Programm nicht mehr ändern. Python dagegen erlaubt dynamische
Typisierung: Eine Variable x kann an einer Stelle des Programms Ganzzahlen speichern und
an späterer Stelle Strings. Damit einher geht eine gewisse Ambivalenz; es ist nicht zwingend
sofort einsichtig, welchen Datentyp ein Ausdruck hat. Der Python-Interpreter versucht dann, den
geeignetsten Datentyp zu „erraten“. Gemäß dem Zitat von James Whitcomb Riley:
Zitat
When I see a bird that walks like a duck and swims like a duck and quacks like a duck, I
call that bird a duck.
wird Python daher als duck typed language bezeichnet.

1.4.3. Ausgabe von Variablen mit print
Um den in einer Variablen gespeicherten Wert zu erfahren, haben wir bisher in der Interpreter-Umgebung
den Namen der Variable eingegeben. In längeren Codes, wie wir sie im Code-Eingabe-Bereich schreiben,
funktioniert dies aus technischen Gründen leider nicht. Stattdessen können wir aber den print benutzen.
Betrachten Sie das folgende Beispiel:
Beispiel: Ausgabe von Werten mit print
1
2
3

a = 2
b = a * 7.5 + 2
print(a, b, "konstanter Text", a * "x")
Ausgabe: Ausgabe von Werten mit print
2 17.0 konstanter Text xx

Sie erkennen hieraus, dass Sie der Befehl print die Werte der Ausdrücke, die als Argumente übergeben
werden, ausgibt. Das bedeutet, dass a eben durch seinen Wert (hier also durch 2) ersetzt wird. Ich
erinnere Sie nochmals daran, dass dies der Grund ist, warum Strings in Anführungszeichen eingefasst
werden müssen–sonst könnte der Interpreter die Anweisung drucke den Buchstaben a und die Anweisung
drucke den Wert der Variablen a nicht auseinander halten.
Weiter sehen Sie, dass print nicht nur einen einziges Argument verarbeiten kann, sondern auch mit
einer ganzen Parameterliste zurecht kommt. Die einzelnen Ausdrücke werden durch Kommata gelistet
aufgelistet und der Reihe nach ausgewertet, bevor sie auf dem Bildschirm erscheinen. Diese Ausdrücke

12

dürfen einzelne Variablen (a, b), Konstanten (3.14, "konstanter Text") oder komplette „Rechnungen“
(a * "x") sein.

1.5. Kommentare und mehrzeilige Kommandos
Wie Sie bald sehen werden, können Codes lang und komplex werden. Es wird Ihnen helfen, schwer
erfassbare Abschnitte durch Fließtext-Kommentare zu ergänzen. Solche Kommentare markieren Sie
durch ein Raute-Zeichen (#). Der Interpreter wird alle Zeichen hinter dem Kommentar-Zeichen bis zum
Zeilenende ignorieren.
Beispiel: Kommentare
1
2

print("Normaler Code, der ausgeführt wird")("auch dies wird nicht ausgeführt")

## Dies wird nicht mehr ausgeführt

Normalerweise enden Python-Anweisungen mit dem Zeilenumbruch. An manchen Stellen kann es Ihren
Code übersichtlicher machen, Anweisungen auf mehrere Zeilen zu verteilen. Dass eine Anweisung trotz
Zeilenumbruch über das Zeilenende gelesen werden soll, erreichen Sie, indem Sie einen Backslash (\)
setzen:
Beispiel: Mehrzeilige Anweisungen
1
2
3
4
5

x = 1
a = 2 +
3 * x +
4 * x**2 +
7 * x**3

1.6. Formatierte Strings
Wir können Strings erzeugen, in denen die Werte von Variablen als Text dargestellt werden. Zu diesem
Zweck haben wir bereits die Funktion str kennengelernt. Wir wissen auch, dass wir Strings durch die
Addition verketten können. Ein bequemerer Weg kann über Format-Strings erreicht werden:
Syntax: Format-String
f"normaler Text {Ausdruck} mehr normaler Text {weiterer Ausdruck:Format} ..."
Ein Format-String beginnt also mit einem vorangestellten f, und wird ebenso von doppelten Anführungszeichen "" eingeschlossen, wie ein normaler String. Er kann–muss aber nicht–beliebig lange
Blocks von Text enthalten, die 1:1 in das Endergebnis übernommen werden. Neu gegenüber normalen
Strings sind Blöcke der Form {Ausdruck} und {Ausdruck : Format}.
Wie schon zuvor auch steht Ausdruck für eine Variable, eine Zahl oder eine komplette Rechnung. Der
Ausdruck wird zuerst evaluiert („ausgerechnet“), und dann in den String eingebaut. Die {geschweiften
Klammern} sind nicht Teil des Endprodukts, sondern zeigen dem Interpreter an, dass hier eine Ersetzung
gemacht werden muss.

13

Beispiel: Formatstrings
1
2
3
4

a = 1
b = 2
s = f"a + b = {a + b}"
print(s)
Ausgabe: Formatstrings
a + b = 3

Dieser Code ist im Ergebnis gleichwertig zu
Beispiel: Gleichwertiger Code ohne Formatstrings
1
2
3
4

a = 1
b = 2
s = "a + b = " + str(a + b)
print(s)

Wenn Sie tatsächlich {geschweifte Klammern} im Ergebnis brauchen, so erreichen sie dies, indem Sie im
Formatstring ein doppeltes Klammerpaar setzen:
Beispiel: Formatstrings mit Escape-Sequenz
1
2
3
4

a = 1
b = 2
s = f"{{a + b}} = {{{a + b}}}"
print(s)
Ausgabe: Formatstrings mit Escape-Sequenz
{a + b} = {3}

Im Syntax-Kasten wurde bereits angedeutet, dass abgetrennt durch einen Doppelpunkt noch weitere
Angaben zur Formatierung folgen dürfen. In Abschnitt B.2 finden Sie eine Übersicht der unterstützten
Formatzeichen. Hier seien nur einige besonders nützliche Beispiele gezeigt:
Die einfachste Formatvorgabe, die sie setzen können, ist eine Zahl. Diese Zahl gibt dann an, wie viele
Zeichen zur Darstellung des Ausdrucks verwendet werden sollen. Auf diese Weise können Sie bequem
tabellarische Ansichten erstellen:
Beispiel: Formatstrings mit Vorgabe der Zeichenlänge
1
2
3
4

name1 = "Dusky"
score1 = 9001
name2 = "Joe"
score2 = 666

5
6
7

print(f"{name1:20} : {score1:5} ")
print(f"{name2:20} : {score2:5} ")

14

Ausgabe: Formatstrings mit Vorgabe der Zeichenlänge
Dusky
Joe

:
:

9001
666

Beachten Sie, dass zwischen dem Doppelpunkt und dem Format kein Leerzeichen stehen darf (bzw. dass
ein solches eine besondere Funktion hat–siehe weiter unten)
Wie Sie sehen, werden Strings linksbündig ausgegeben, während Zahlen rechtsbündig formatiert werden.
Diese Standard-Einstellung kann durch ein vorangestelltes <, > oder ^ überschrieben werden:
Beispiel: Formatstrings und Alignment
1
2
3
4
5
6

text = "sample"
value = 123
print( f"|{text:15} | |{value:15} |" )
print(f"|{text:<15} | |{value:<15} |")
print(f"|{text:>15} | |{value:>15} |")
print(f"|{text:^15} | |{value:^15} |")
Ausgabe: Formatstrings mit Vorgabe der Zeichenlänge
|sample
| |
|sample
| |123
|
sample| |
|
sample
| |

123

123|
|
123|
|

Ist der Ausdruck zu lang, um mit der vorgegebenen Zeichenzahl gedruckt zu werden, so ignoriert Python
die Zeichenzahl und druckt den vollen Text. Durch einen Punkt vor der Zahl bringen Sie Python dazu,
stattdesen die Ausgabe abzuschneiden. Dies funktioniert jedoch nur bei Strings, und kann nicht mit den
Zeichen <, > oder ^ kombiniert werden:
Beispiel: Formatstrings und String-Truncation
1
2

text = "very long sample text"
print( f"|{text:.4} |" )
Ausgabe: Formatstrings und String-Truncation
|very|

Natürlich können die Effekte durch Hilfsvariablen dennoch kombiniert werden:
Beispiel: Kombination von Formatierungen über Hilfsvariablen
1
2
3
4
5

value = 1234567890
step1 = f"{value} "
step2 = f"{step1:.5} "
final = f"|{step2:^10} |"
print(final)

## zu String

## Länge beschränken

## zentrieren

15

Ausgabe: Formatstrings und String-Truncation
|

12345

|

Bei Zahlen dient ein vorangestelltes Leerzeichen im Formatstring als Platzhalter für ein eventuelles
Vorzeichen. Alternativ kann auch ein Pluszeichen (+) gesetzt werden, um anzudeuten, dass das Vorzeichen
immer Teil des Ergebnisses sein soll, selbst wenn die Zahl positiv ist:
Beispiel: Formatstrings und Vorzeichen
pos = 10
neg = -10
print(f"|{pos: 15} | |{neg: 15} |")
print(f"|{pos:+15} | |{neg:+15} |")

1
2
3
4

Ausgabe: Formatstrings und Vorzeichen
|
|

10| |
+10| |

-10|
-10|

Eine vorangestellte 0 füllt den zur Verfügung gestellten Platz mit Nullen auf. Dies ist mit Leerzeichen
und Pluszeichen kombinierbar:
Beispiel: Formatstrings und führende Nullen
1
2
3
4

pos = 10
neg = -10
print(f"|{pos: 015} | |{neg: 015} |")
print(f"|{pos:+015} | |{neg:+015} |")
Ausgabe: Formatstrings und führende Nullen
| 00000000000010| |-00000000000010|
|+00000000000010| |-00000000000010|

Speziell für Fließkommazahlen gibt es das Zeichen f, das eine Steuerung der Anzeige von Nachkommastellen ermöglicht:
Beispiel: Formatstrings und Fließkommazahlen
1
2
3
4
5
6
7
8

num = 1.2
print(f"|{num} |")
print(f"|{num:f} |")
print(f"|{num:6.2f} |")
print(f"|{num:<6.1f} |")
print(f"|{num:06.2f} |")
print(f"|{num:+06.2f} |")
print(f"|{num: 06.2f} |")

16

Ausgabe: Formatstrings und Fließkommazahlen
|1.2|
|1.200000|
| 1.20|
|1.2
|
|001.20|
|+01.20|
| 01.20|
Ein einzelnes f stellt die Zahl mit 6 Nachkommastellen dar, und füllt gegebenenfalls mit Nullen auf, falls
weniger Dezimalstellen zur Zahl gehören. In der Form x.yf werden insgesamt x Zeichen zur Darstellung
der Zahl bereitgestellt (Komma und Vorzeichen mitgezählt). Die Zahl wird mit y Nachkommastellen
ausgegeben und gegebenenfalls mit Nullen aufgefüllt. Dies ist kombinierbar mit den Alignment-Zeichen
<, > und ^. Auch führende Nullen, Leerzeichen oder erzwungenes Vorzeichen funktionieren wie oben
beschrieben.

1.7. Obfuscated Code
Sie werden feststellen, dass es zu einer Aufgabe sehr viele funktionierende Lösungen gibt. Dass Code
funktioniert, reicht uns aber nicht. Code soll auch leicht lesbar und verständlich sein. Bedenken Sie: die
Aufgaben, die Sie hier lösen, sind in der Regel kein Selbstzweck, sondern Bausteine für größere Projekte.
Wenn die einzelnen Teillösungen schwer zu verstehen sind, werden sie auch umso beschwerlicher als
Lösung in andere Probleme einbaubar sein.
Das folgende Beispiel:
Beispiel: Unlesbarer Code
1
2
3
4
5

p = lambda x: int(( -13214 * x**11 + 956318 * x**10 - 30516585 * x**9 +
564961485 * x**8 - 6717043212 * x**7 + 53614486464 * x**6
-291627605005 * x**5 + 1074222731065 * x**4
-2606048429424 * x**3 + 3927289106268 * x**2
-3265905357360 * x + 1116073728000 ) / 19958400)

6
7

print (bytearray(map(p, range(1, 13))).decode())

(Quelle: https://codegolf.stackexchange.com/questions/22533/weirdest-obfuscated-hello-world)
gibt ebenso den Text Hello World! auf dem Bildschirm aus, ist aber (auch für Profis) kaum so zu
verstehen. Nehmen Sie sich daher die Hinweise zu Best Pratice zu Herzen, die Ihnen in diesem Script
mitgegeben werden.

17
