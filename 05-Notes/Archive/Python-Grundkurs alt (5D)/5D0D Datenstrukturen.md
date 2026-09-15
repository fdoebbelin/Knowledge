---
aliases: 
tags: 
title: 5D0D Datenstrukturen
---

Multimedia? As far as I’m concerned, it’s reading with the radio on!
Rory Bremmer

Bis hierhin haben wir sehr kleine Datenmengen behandelt. Unser bisheriges „Arbeitsmaterial“ waren
Variablen, die je einen einzelnen Wert repräsentieren. Eine Stärke von Computern ist es aber gerade,
große Datenmengen schnell zu verarbeiten. Hier werden wir Möglichkeiten kenenn lernen, nahezu beliebig
große Datenmengen im Speicher zu halten und zu manipulieren.

## 4.1. Speichermodell
Bevor wir das Verhalten der verschiedenen Speicherstrukturen verstehen können, die Python uns zur
Verfügung stellt, müssen wir uns mit der Art und Weise vertraut machen, in der Daten im Speicher
abgelegt werden.
Man kann sich den Arbeitsspeicher als langes Band von kleinen, nummerierten Speicherzellen vorstellen.
Jede Zelle fässt genau ein Byte. Um einen Wert zu lesen oder zu schreiben muss dem Prozessor die
Nummer der Zelle mitgeteilt werden, die verändert wird. Diese Nummer wird Adresse oder Pointer
genannt. Wenn wir im Code Variablen benutzen, übersetzt der Compiler diese in Adressen.
Speicherbild
Variable x
Variable y

Symbole im Code

99

1

255

0

80

...

0x27ff

0x2800

0x2801

0x2802

0x2803

0x2804

Werte im Speicher
Adressen

Adresse von x

Abbildung 4.1.: Speicherbild: nummerierte Zellen
Während wir der Einfachheit halber oft sagen, dass eine Variable einen Wert speichert, ist tatsächlich
die Information hinterlegt, wo der Wert selbst zu finden ist, also die Adresse des Wertes. Dies hat den
Vorteil, dass Aufgaben sehr effizient erledigt werden können, wenn große Datenmengen bewegt werden
müssen: anstatt viele Megabytes zu kopieren, muss nur eine Referenz an die Stelle gesetzt werden, wo
die zu kopierenden Daten bereits im Speicher liegen. Für uns als ProgrammiererInnen heißt dies aber
auch, dass wir diese Speicherstruktur im Hinterkopf behalten müssen.
Stellen Sie sich vor, Sie verwalten eine Liste. Diese soll über den Variablennamen originalList
ansprechbar sein. Nun wollen Sie eine Arbeitskopie dieser Liste anlegen und in dieser Kopie Werte
verändern. Sie wollen also folgendes Speicherbild erreichen:

31

Speicherbild
Originaldaten
...

1

2

3

0x2800

0x2801

0x2802

Adresse von originalList

Arbeitskopie
...

4
0x2803

1

2

3

4

0x2950

0x2951

0x2952

0x2953

...

Adresse von copyOfList

Abbildung 4.2.: Speicherbild: Arbeitskopie
Wenn Sie nun die Codezeile
copyOfList = originalList
tippen, werden Sie aufgrund dieser Arbeitsweise von Python aber folgendes Speicherbild erzeugen:
Speicherbild
Originaldaten
...

1

2

3

0x2800

0x2801

0x2802

Adresse von originalList

andere Daten
...

4
0x2803

19

89

3

29

0x2950

0x2951

0x2952

0x2953

...

Adresse von copyOfList

Abbildung 4.3.: Speicherbild: Zwei Referenzen auf dieselben Daten
Anstatt eine Kopie der Liste anzulegen, haben Sie nur eine Kopie der Referenz erzeugt. Ein Zugriff über
das Symbol copyOfList ändert also immer noch Ihr Original!
Um nun das gewünschte Ziel zu erreichen, müssen Sie stattdessen die Funktion copy aus dem Modul
copy benutzen:

```
Schema: Shallow Copy anlegen
import copy

## Code zum Aufbau der Liste originalList

copyOfList = copy.copy(originalList)
```


## 4.2. mutable und immutable objects
Python kennt zwei große Gruppen von Objekten: veränderbare Objekte (mutable objects) und unveränderliche Objekte (immutable objects).
Die Werte von immutable objects dürfen sich nicht mehr ändern, sobald sie einmal im Speicher abgelegt
wurden. Wenn eine Variable geändert wird, die ein immutable object speichert, so wird ein neues Objekt
im Speicher konstruiert, nicht aber die alte Stelle überschrieben.

32

Betrachten Sie dazu das folgende Beispiel:
Codebeispiel
1

Speicherbild

## int-Variablen sind immutable

...

100

2

3

4

200

intVar = 100

0x2800

0x2801

0x2802

0x2803

0x2804

intVar = 200

bis Zeile 3

2
3

...

4
5

Adresse von intVar

ab Zeile 5

In dem hier gezeigten Code ändern wir augenscheinlich den Wert von intVar. Der Typ int ist jedoch
immutable! Daher wird der Python-Interpreter dafür sorgen, dass mit Zeile 5 ein neues int-Objekt im
Speicher angelegt wird, das den neuen Wert speichert. Die Referenz von intVar geht nun auf diese neue
Speicherstelle. Der Wert 100, der in der alten Speicherstelle lag, wird hingegen nicht angerührt.
Bei mutable objects hingegen wird wirklich der Inhalt der Speicherzellen selbst überschrieben. Sie
erkennen, dass hier das Problem der vermeintlichen Arbeitskopie auftritt.
Im Moment haben wir nur immutable objects kennen gelernt. In diesem Kapitel werden die ersten
mutable objects eingeführt. Am Ende des Kapitels finden Sie eine Übersichtstabelle zu den Ihnen bis
dahin bekannten Speicherstrukturen.
Speicheradresse ausfindig machen mit id
Der Befehl id kann auf alle Datenobjekte angewandt werden, und gibt die Adresse im Speicher
aus, also die Nummer der Speicherzelle.
Neben Variablen (id(x)–Adresse der Variablen x) kann der Befehl auch auf Datentypen
(id(int)–Adresse der „Beschreibung des Typs“) und auf Konstanten (id(1)–Adresse des
Werts 1) angewandt werden.
Wenn Sie hier ein wenig experimentieren, werden Sie feststellen, dass „kleine“ Ganzzahlen in
relativer Nähe zueinander liegen, während „große Zahlen“ (> 256) signifikant andere Adressen
erhalten. Dies liegt daran, dass die Entwickler von Python erwartet haben, dass diese Zahlen sehr
häufig als (Zwischen-)Ergebnisse auftreten. Daher werden diese bereits „auf Verdacht vorbereitet“.
Größere Zahlen werden erst im Speicher angelegt, wenn dies wirklich nötig wird.
Vergleichsoperator is vs. ==
Wir haben bereits den Operator == kennengelernt, der uns mitteilt, ob zwei Objekte gleich sind.
Hierbei ist mit Gleichheit gemeint, dass sie denselben Wert speichern. Wie Sie gesehen haben,
können Kopien voneinander an verschiedenen Speicherorten abgelegt werden.
Der Operator is vergleicht nicht die Werte, sondern die Speicheradressen, und gibt folglich True
zurück, wenn zwei Variablen dasselbe Objekt referenzieren. Die folgenden beiden Codezeilen sind
also äquivalent:

```
Übersetzung von is
print( id(a) == id(b) )
print(
a is
b )
```


33

Beachten Sie, dass diese Bedeutung des Operators is manchmal unintuitives Verhalten erzeugt:

```
Unintuitives Verhalten von is
5 == 4 is not True
```

dieser Ausdruck wird zu True ausgewertet, obwohl offensichtlich 5 6= 4 gilt.
Dies lässt sich folgendermaßen begründen:
Python wertet zunächst den ersten Teil der Aussage (5 == 4) zu False aus. Dieser Wert ist ein
häufig gebrauchter, und wurde daher von Python bereits vorbereitet, hatte also schon vor diesem
ersten Rechenschritt eine Adresse. Diese Adresse wird dem Ausdruck 5 == 4 zugeordnet.
Als nächstes wird die zweite Teilaussage (not True) ebenfalls zu False ausgewertet. Wieder
erkennt Python den vorbereiteten Wert, und weist not True die Adresse von False zu.
Der Operator is vergleicht nun die Adressen von False und False, und kommt folgerichtig zu
dem Ergebnis, dass diese gleich sind. Mit anderen Worten, False is False ist True.

## 4.3. lists
Der Datentyp list repräsentiert–wie der Name vermuten lässt–Listen. Die aufgelisteten Werte können
dabei ganz verschiedener Natur sein: lists können ints, floats, . . . und sogar andere Listen enthalten.
Die Elemente derselben Liste müssen nicht vom selben Typ sein.

### 4.3.1. Anlegen und Auslesen
Erstellt werden Listen, indem man in [eckigen Klammern] die Elemente der Liste durch Kommata
getrennt aufzählt:
Syntax: Liste anlegen
listVariable = [listItem1, listItem2, ...]
Listen dürfen auch leer sein. Eine leere Liste wird als [] geschrieben.
Auf die Elemente einer Liste wird mittels ihres Index zugegriffen, d. h. der Nummer innerhalb der Liste.
Dabei hat das erste Element der Liste den Index 0! Der Index wird in [eckigen Klammern] dem Symbol
der Listenvariable nachgestellt, um anzugeben, dass man ein einzelnes Element der Liste ansprechen
will:

```
Syntax: Listenelement ansprechen
listVariable[listItems]
```

Indices können auch negativ sein! In diesem Falle wird „von hinten herein“ gezählt. -1 referenziert also
das letzte Element der Liste, -2 das vorletzte, usw.
Ist das referenzierte Listenelement selbst eine Liste, so kann auf dessen Elemente ebenfalls durch Nennung
des Index in einer eigenen Klammer zugegriffen werden.

34

lists können auch in normale Variablen „entpackt“ werden. Dazu verwendet man den Zuweisungsoperator
=, gibt aber auf der linken Seite so viele Elemente an, wie sie in der Liste sind:

```
Entpacken von Listen

>>> numbers = [1, 2, 3]
>>> a, b, c = numbers
>>> b
2
```


### 4.3.2. Slicing
Aus einer Liste kann auch ein Teil herausgegriffen werden. Man nennt dies 
```
slicing:
Syntax: Slicing
listVariable[start : end : stride]
```

Mit dieser Syntax wird eine neue Liste berechnet, die beim Index start beginnt, die Elemente bis
ausschließlich dem Index end beinhaltet, und deren Elemente in der Quell-Liste einen Abstand von
stride haben. Wird stride ausgelassen, werden alle Elemente zwischen start und end in die neue
Liste übernommen.
Wird start oder end ausgelassen, so versteht Python dies als: „vom Anfang“ bzw. als „bis zum Ende“.

### 4.3.3. Addition und Multiplikation bei Listen
Die Addition von Listen führt zur Verkettung, wie Sie das schon von Strings kennen. Genauso wie dort
führt die Multiplikation mit einer Ganzzahl zu einer Wiederholung der Listenelemente:

```
Multiplikation von Listen

>>> [1, 2] + [3]
[1, 2, 3]
>>> 3 * [1, 2]
[1, 2, 1, 2, 1, 2]
```


35

### 4.3.4. Beispiel

```
Beispiel: Listenzugriffe
1

myList = [1, 2, -5, 3.14, "some text", [3, 2], (1+1j)]

2
3
4
5
6
7
8
9

print(myList[0])
print(myList[-1])
print(myList[-2][0])
print(myList[1:3])
print(myList[-2:])
print(myList[:5:2])
print(myList[::2])
```


## erstes Element

## letztes Element

## erstes Element des vorletzten Elements

## slicing: Elemente 1 und 2 (ausschließlich 3)

## slicing: vorletztes Element bis Ende

## slicing: Elemente mit Indices 0 bis 4 in 2er-Schritten

## slicing: alle mit geradem Index

myList += [[]]
print(myList[-1])
print(myList)

## an die Liste eine leere Liste anhängen

## letztes Element

## gesamte Liste

10
11
12
13

Ausgabe
1
(1+1j)
3
[2, -5]
[[3, 2], (1+1j)]
[1, -5, 'some text']
[1, -5, 'some text', (1+1j)]
[]
[1, 2, -5, 3.14, "some text", [3, 2], (1+1j), []]
Beachten Sie besonders die Klammern in Zeile 11: myList += [[]]. Die äußeren Klammern geben an,
dass das Objekt, das addiert wird, eine Liste ist. Dies ist notwendig, da nur die Addition zwischen Listen
erklärt ist; myList += 3 würde (für den Python-Interpreter) keinen Sinn ergeben. Alles, was in diesen
Klammern steht, wird an die Liste angehängt. In diesem Fall ist dies [], also eine leere Liste. Machen
Sie sich klar, dass im Gegensatz zu myList += [[]] (anhängen einer leeren Liste) durch den Befehl
myList += [] nichts zu myList hinzugefügt wird.
lists sind mutable. Das heißt, für Kopien muss der copy-Befehl aus dem Modul copy verwendet werden,
oder mittels der Slicing-Syntax eine Kopie erstellt werden:

36


```
Beispiel: mutable list
1

import copy

2
3
4
5
6

originalList = [1, 2, 3]
refCopy = originalList
truCopy = copy.copy(originalList)
altCopy = originalList[:]

7
8
9
10

refCopy += [4]
truCopy += [5, 5]
altCopy += [6, 6]

11
12
13
14

print("original
: ", originalList)
print("copy.copy
: ", truCopy)
print("slicing copy: ", altCopy)
Ausgabe
original
: [1, 2, 3, 4]
copy.copy
: [1, 2, 3, 5, 5]
slicing copy: [1, 2, 3, 6, 6]
```


Wie Sie sehen, wird in Zeile 8 ein Element an refCopy angehängt. Da refCopy aber auf die Speicherstelle
von originalList verweist, ändert sich also die ursprüngliche Liste damit ebenfalls.
truCopy ist tatsächlich eine neue Liste, die eine Kopie der ursprünglichen Liste enthält. Sie wurde an
einer von originalList unabhängigen Speicherstelle angelegt, und spürt damit die Änderung durch
Zeile 8 nicht. Auf dieselbe Weise bleibt originalList von der Änderung durch Zeile 9 unbeeinflusst.
Dasselbe gilt für altCopy: der Slicing-Operator bewirkt dasselbe wie der Befehl copy.copy.
Achtung: lists werden intern als Abfolge von Adressen der Elemente in der Liste realisiert. Wenn das
referenzierte Objekt wiederum eine Liste ist, so kann selbst über eine „echte“ Kopie die Original-Liste
geändert werden. Die Funktion deepcopy aus dem Modul copy umgeht dies, indem wirklich rekursiv
Kopien von allen Ebenen der Liste angelegt werden:

```
Beispiel: Kopien mit deepcopy
1

import copy

2
3
4
5
6

originalList = [1, 2, [1, 2]]
normCopy = copy.copy(originalList)
deepCopy = copy.deepcopy(originalList)
normCopy[-1] += [3]

7
8
9

print("copy.copy
: ", originalList)
print("copy.deepcopy: ", deepCopy)
Ausgabe
copy.copy
: [1, 2, [1, 2, 3]]
copy.deepcopy: [1, 2, [1, 2]]
```


37

### 4.3.5. Methoden
Methoden sind Programmroutinen, die ein Datenobjekt verändern, oder auf Basis des Datenobjekts
Ergebnisse berechnen. lists sind solche Datenobjekte. Jede Klasse (d. h. „Art“ von Objekten) hat seine
eigenen Methoden. In Kapitel 7 wird dies im Detail behandelt. Hier sei zunächst vorausgeschickt, wie
wir mit solchen Methoden umgehen.
append
Eine solche Methode ist append. Sie wird verwendet, um Elemente zu einer Liste hinzuzufügen. Aufgerufen
wird eine Methode, indem man das zugrundeliegende Datenobjekt nennt, und, getrennt durch einen
Punkt, die Methode anhängt. Methoden sind Funktionen, also folgt wie üblich eine Parameterliste in
runden Klammern.

```
Beispiel: Methode append
1

numbers = [1, 2]

2
3
4

numbers.append(3)
numbers.append([4])

5
6

print(numbers)

7
8
9

numbers += [5]
numbers += [[6]]

10
11

print(numbers)
Ausgabe
[1, 2, 3, [4]]
[1, 2, 3, [4], 5, [6]]
```


Wie Sie sehen, wird in den Zeilen 3 und 4 jeweils ein Element zur Liste hinzgefügt (die Zahl 3 und
die Liste [4]). Denselben Effekt hat der Operator +=. Während im ersten Fall aber Elemente als
Argumente übergeben werden, muss beim Operator eine Liste genannt werden, mit der die Verknüpfung
stattfindet.
insert
Ähnlich funktioniert die Methode insert: Sie fügt einen Wert zur Liste hinzu. Im Gegensatz zu append
jedoch kann mit insert auch die Position innerhalb der Liste festgelegt werden: Beim Einfügen muss
dazu sowohl der Index (die Position in der Liste, an der eingefügt werden soll) als auch das Element
selbst genannt werden:

38


```
Beispiel: Methode insert
1

numbers = [1, 2]

2
3
4

numbers.insert(1, 99)
print(numbers)

5
6
7

numbers = numbers[:1] + [-99] + l[1:]
print(numbers)
Ausgabe
[1, 99, 2]
[1, -99, 99, 2]
```


Auch negative Indices können angegeben werden. l.append(x) und l.insert(-1, x) haben also
dieselbe Auswirkung.
Indices beginnen bei 0!
Beachten Sie, dass das erste Element einer Liste den Index 0 hat! Der Index 1 bezeichnet also
das zweite Element.

remove
Das Gegenstück zu insert ist remove: Es löscht einen bestimmten Wert aus der Liste. Als Parameter
wird der Wert selbst angegeben, nicht der Index. Taucht der Wert in der Liste mehrfach auf, so wird das
erste Element gelöscht, das dem Parameter gleicht. Ist der Parameter gar nicht in der Liste, so wird eine
Fehlermeldung ausgegeben.

```
Beispiel: Methode remove
1

numbers = [1, 2, 4, 3, 4, 4, 5]

2
3
4

numbers.remove(4)
print(numbers)

5
6

## numbers.remove(8)

-- Fehler: 8 nicht in numbers

Ausgabe
[1, 2, 3, 4, 4, 5]
```


sort und reverse
Wie der Name vermuten lässt, dienen diese Methoden dazu, lists zu sortieren bzw. in der Reihenfolge
umzudrehen. Es versteht sich von selbst, dass Sortieren nur dann möglich ist, wenn ein sinnvolles
Sortierkriterium gegeben ist. Zahlen werden aufsteigend nach Wert sortiert, Strings lexikographisch (also
alphabetisch mit bestimmten Regeln für Zahlen und Sonderzeichen). Listen aus gemischten Elementen
(also aus Zahlen und Strings) können nicht sortiert werden.

39

Wir werden in Kapitel 6 eine Möglichkeit kennen lernen, diese Funktionalität zu erweitern.

```
Beispiel: Methode sort und reverse
numbers = [5, -2, 3, 4, 4, 4, 5]

1
2

numbers.sort()
print(numbers)

3
4
5

numbers.reverse()
print(numbers)

6
7
8

numbers = [1, "broccoli"]

## l.sort()

-- Kann 1 nicht mit "broccoli" vergleichen

9
10

Ausgabe
[-2, 3, 4, 4, 4, 5, 5]
[5, 5, 4, 4, 4, 3, -2]
```


pop
Die Methode pop kombiniert die Aufgaben „lese das letzte Element der Liste“ und „entferne das letzte
Element der Liste“. Dies ist nützlich, um „Aufgabenstapel abzuarbeiten“.
Beispiel: Methode pop
1
2
3

jobs = ["go have a coffee",
"think of some nice examples",
"write the chapter"]

4
5
6

print( "next job : ", jobs.pop() )
print( "jobs to do: ", jobs)
Ausgabe
next job : write the chapter
jobs to do: ['go have a coffee', 'think of some nice examples']

Weitere Methoden
Neben den oben gezeigten Methoden existieren noch weitere, die hier nicht erschöpfend erklärt werden
können. Stattdessen möchte ich Sie dazu ermutigen, sich mit der offiziellen Dokumentation der Sprache
auseinander zu setzen.
Unter:
https://docs.python.org/3/tutorial/datastructures.html
finden Sie (knappe) Erklärungen zu allen Methoden, die sowohl die list als auch alle weiteren hier
besprochenen Speicherstrukturen zur Verfügung stellen.

40

4.4. tuples
tuples sind die immutable Cousins der list: auch sie repräsentieren Listen. Wie bei list spricht man
Syntaxelemente über einen Index in [eckigen Klammern] an. Angelegt werden sie ähnlich, jedoch mit
runden Klammern. Addition und Multiplikation funktionieren wie bei lists:
Beispiel: tuples
1
2
3
4

tup_numbers = (1, 2, 3)
print( tup_numbers + (4, 5) )
print( 2 * tup_numbers)
print( t[0] )

5
6
7

a, b, c = tup_numbers
print(b)
Ausgabe
(1, 2, 3, 4, 5)
(1, 2, 3, 1, 2, 3)
1
2

Viele Funktionen in Python geben tuples zurück. Ein Beispiel hierfür ist die Funktion divmod, die
sowohl Quotient als auch Rest einer Division in einem Schritt berechnet:
Beispiel: divmod
1

dm = divmod(11, 3)

2
3

print("11 / 3 = ", dm[0], " Rest ", dm[1])
Ausgabe
11 / 3 = 3 Rest 2

Da tuples immutable sind, existieren keine Funktionen, die diese verändern, wie z. B. sort oder append.
Es ist jedoch möglich, aus einem tuple eine list mit gleichen Inhalten zu generieren, und diese dann–
nach Bearbeitung–wieder in einen tuple zurückzuverwandeln:
Beispiel: Type conversion mit list und tuple
1

tup_numbers = (5, 2, 3)

2
3
4

lst_numbers = list(tup_numbers)
print(lst_numbers)

5
6

lst_numbers.sort()

7
8
9

tup_numbers = tuple(lst_numbers)
print(tup_numbers)

41

Ausgabe
[5, 2, 3]
(2, 3, 5)
Sie kennen diese Art der Typumwandlung bereits aus Abschnitt 1.4.2.
Klammer-Typen
Beachten Sie im letzten Beispiel genau die Ausgabe: tuples werden in (runden Klammern)
ausgegeben, lists dagegen in [eckigen Klammern].
Auch, wenn hier der Eindruck entsteht, der tuple tup_numbers wäre verändert worden, bleibt die
Aussage, dass tuples immutable sind. Das alte Objekt tup_numbers wurde in Zeile 8 verworfen. An
einer neuen Stelle im Speicher wird ein neuer tuple konstruiert, der mit dem alten tup_numbers nichts
zu tun hat.

4.5. sets und frozensets
sets sind eine Variante von lists. Der Unterschied besteht darin, dass es in sets keine Doubletten gibt.
Jedes Element eines sets ist einmalig; versucht man, dasselbe Element ein zweites Mal hinzuzufügen, so
passiert einfach gar nichts.
Man erstellt sets wie lists, jedoch mit {geschweiften Klammern}. Das Ansprechen einzelner Elemente
geschieht wieder wie bei lists durch Nennung des Index in [eckigen Klammern].
Beispiel: sets
1
2
3

basket = {'apple', 'orange', 'apple', 'pear', 'orange', 'banana'}
print(basket)
print(basket[0])
Ausgabe
{'orange', 'banana', 'pear', 'apple'}
orange

Ähnlich wie tuples können sets aus lists (oder allen anderen Datenstrukturen) konstruiert werden:
Beispiel: Type conversion mit sets
1
2
3
4
5

lst_numbers = [1, 2, 1, 3, 1, 4]
set_numbers = set(lst_numbers)
uniqueList = list(set_numbers)
print(set_numbers)
print(uniqueList)

42

Ausgabe
{1, 2, 3, 4}
[1, 2, 3, 4]
Wie schon zuvor funktioniert die Addition wie bei lists. Die Multiplikation ist nicht definiert, da ein set
nie doppelte Elemente enthalten darf. Auf sets können dieselben Operationen wie auf lists angewandt
werden. Hinzu kommen einige s
So, wie es zur list das immutable Analogon tuple gibt, hat das set im frozenset sein immutable
Gegenstück. frozensets haben keinen eigenen Typ von Klammern, und werden stattdessen über ihren
Typnamen aus Listen (beliebigen Typs) generiert:
Beispiel: Type conversion mit frozensets
1
2
3

lst_numbers = [1, 2, 1, 3, 1, 4]
fst_numbers = frozenset(lst_numbers)
uniqueList = list(fst_numbers)

4
5
6

print(fst_numbers)
print(uniqueList)
Ausgabe
frozenset({1, 2, 3, 4})
[1, 2, 3, 4]

4.6. Strings
Strings wurden bereits in Abschnitt 1.4.2 vorgestellt. Hier möchte ich Sie nur darauf hinweisen, dass
Strings eine besondere Art von tuples sind, nämlich immutable Listen von einzelnen Buchstaben.
Mit diesem Wissen ist es für Sie leicht, das folgende Verhalten nachzuvollziehen:
Beispiel: Strings als tuples
1
2

powerlevel = "over 9000"
tup_powerlevel = tuple(powerlevel)

3
4

print(tup_powerlevel)
Ausgabe
('o', 'v', 'e', 'r', ' ', '9', '0', '0', '0')

Strings lassen sich auch indizieren. stringVariable[i] gibt das Zeichen an der Stelle i zurück. Beachten
Sie, dass die Zählung auch hier bein 0 beginnt.

43

4.7. ranges
ranges werden in Kapitel 5 von Bedeutung sein. Sie repräsentieren Ganzzahlen zwischen bestimmten
Grenzen. Das Schlüsselwort range kann auf drei verschiedene Arten genutzt werden:
- range(N) erzeugt eine Liste der Zahlen von einschließlich 0 bis ausschließlich N. Beispielsweise
steht range(5) für die Zahlen 0, 1, 2, 3, 4.
- range(start, end) erzeugt eine Liste der Zahlen von einschließlich start bis ausschließlich end.
Beispielsweise steht range(2, 5) für die Zahlen 2, 3, 4.
- range(start, end, stride) erzeugt eine Liste der Zahlen von einschließlich start bis ausschließlich end mit Schritten der Größe stride. Beispielsweise steht range(2, 5, 2) für die Zahlen
2, 4.
Auf die einzelnen Elemente dieser ranges kann wieder mit Index in [eckigen Klammern] zugegriffen
werden:
Beispiel: ranges
1
2

rng_numbers = range(2, 5, 2)
print(rng_numbers[0], rng_numbers[1])
Ausgabe
2 4

ranges speichern nicht die Liste selbst, sondern nur die Daten, aus denen die Elemente generiert werden
können. Man nennt sie daher auch generator objects. Mehr dazu später. Wo die einzelnen Objekte explizit
gebraucht werden, kann wieder eine Type Conversion zu den bekannten Datenstrukturen eingesetzt
werden:
Beispiel: Type conversion mit ranges
1
2

rng_numbers = range(2, 5, 2)
lst_numbers = list(rng_numbers)

3
4
5

print(rng_numbers)
print(lst_numbers)
Ausgabe
range(2, 5, 2)
[2, 4]

4.8. dictionaries
dicts verhalten sich wie lists, werden aber nicht über Zahlen sondern über beliebige Schlüssel indiziert.
Beim Erstellen werden in {geschweiften Klammern} Schlüssel-Wert-Paare aufgeführt, die über einen
Doppelpunkt miteinander verbunden werden:

44

Beispiel: dicts
1
2
3

houseStark = {"Sigil" : "A grey direwolf on a white field",
"Words" : "Winter Is Coming",
"Seat" : "Winterfell"}

4
5
6

print(houseStark)
print(houseStark["Words"])
Ausgabe
{'Sigil': 'A grey direwolf on a white field', 'Words': 'Winter Is Coming',
'Seat': 'Winterfell'}
Winter Is Coming

Wird versucht, den Wert eines Schlüssels zu lesen, der noch nicht angelegt wurde, so bewirkt dies eine
Fehlermeldung. Schreibender Zugriff dagegen legt ein neues Schlüssel-Wert-Paar an:
Beispiel: dicts : neue Schlüssel
1
2

houseStark = {"Sigil" : "A grey direwolf on a white field",
"Words" : "Winter Is Coming", "Seat" : "Winterfell"}

3
4
5
6

## print(houseStark["Founder"]) -- Fehler: Schlüssel 'Founder' existiert nicht

houseStark["Founder"] = "Bran the Builder"
print(houseStark["Founder"])

## Kein Fehler: Schlüssel und Wert hinzugefügt

Ausgabe
Bran the Builder

Aus dicts lassen sich lists, sets, . . . generieren. Dabei wird per default die Menge der Schlüssel
übersetzt. Die Methoden values, keys und items erlauben aber auch, gezielt die Werte, Schlüssel oder
Wert-Schlüssel-Paare abzugreifen:
Beispiel: dicts : spezielle Methoden
1
2

houseStark = {"Sigil" : "A grey direwolf on a white field",
"Words" : "Winter Is Coming", "Seat" : "Winterfell"}

3
4
5
6
7

l_keys1 = list( houseStark
)
l_keys2 = list( houseStark.keys()
)
l_values = list( houseStark.values() )
l_items = list( houseStark.items() )

8
9
10
11
12

print("direct conversion: ", l_keys1 )
print("method keys()
: ", l_keys2 )
print("method values() : ", l_values)
print("method items()
: ", l_items )

45

Ausgabe
direct conversion: ['Sigil', 'Words', 'Seat']
method keys()
: ['Sigil', 'Words', 'Seat']
method values() : ['A grey direwolf on a white field', 'Winter Is Coming',
'Winterfell']
method items()
: [('Sigil', 'A grey direwolf on a white field'), ('Words',
'Winter Is Coming'), ('Seat', 'Winterfell')]
dicts sind nicht zwingend geordnet
Die Zuordnung von Schlüssel zu Wert ist eine nicht-triviale Aufgabe, die im Hintergrund eine
aufwändige Maschinerie betreibt. Damit diese schnell und effizient arbeiten kann, erlaubt der
Python-Interpreter, dass die Reihenfolge der Schlüssel-Wert-Paare geändert wird. Sie können
also leider nicht sicher sein, in welcher Reihenfolge Werte aus einem dict entnommen werden.
Wo dies wichtig wird, benutzen Sie z. B. die Type-Conversion zu lists und die Methode sort.

4.9. Spezielle Funktionen für Container
in
Mit dem Schlüsselwort in kann geprüft werden, ob ein Objekt Teil einer Datenstruktur ist. Zurück
gegeben wird ein boolean:
Beispiel: Operator in
1

myList = [1, 2, -5, 3.14, "some text", [3, 2], (1+1j)]

2
3
4

print(3.14 in myList)
print("meaning" in myList)

## True

## False

Insbesondere funktioniert das Schlüsselwort in auch mit dicts. Beachten Sie, auf welche Menge (Schlüssel,
Werte, oder Schlüssel-Wert-Paare) Sie sich beziehen:
Beispiel: dicts : Operator in
1
2

houseStark = {"Sigil" : "A grey direwolf on a white field",
"Words" : "Winter Is Coming", "Seat" : "Winterfell"}

3
4
5
6
7

print( "Words"
in houseStark )

## True

print( "words"
in houseStark )

## False -- Groß/Kleinschreibung

print( "Winterfell" in houseStark )

## False -- nur keys werden herangezogen

print( ("Seat", "Winterfell") in houseStark.items() )

## True

Vergleichsoperatoren
Alle Listen können miteinander verglichen werden. Dazu dienen die üblichen Operatoren <, ==, >. Der
Gleichheitsoperator == vergleicht alle Elemente der Listen miteinander, und gibt nur dann True zurück,

46

wenn alle Elemente übereinstimmen. Bei < und > wird–wie schon bei Strings–die lexikographische
Vergleichsmethode angelegt, also „wie im Telefonbuch“. Betrachten Sie hierzu folgende Aufstellung:
"Aaron" < "Bart" < "Bartolomäus" < "Cäsar"
[1, 5, 2] < [1, 4] < [1, 4, 1] < [2, 1, 1]
Denken Sie auch daran, dass ein String wie ein tuple aus Buchstaben behandelt wird; so können Sie
sich die Vergleichsregeln leicht ableiten.
len
Der Operator len gibt die Zahl der Elemente in einer Liste zurück. Das funktioniert für alle hier
besprochenen Listen-Typen, inclusive dicts:
Beispiel: dicts : operator len
1

myList = [5, 9, 2]

2
3
4

print( len(myList) )
print( len([]) )

## 3

## 0

reversed und sorted
Wie die Namen schon andeuten, geben diese Funktionen in der Reihenfolge umgedrehte bzw. sortierte
Listen zurück. Tatsächlich ist der Rückgabetyp beider Funktionen list. Im Gegensatz zu den Methoden
sort und reverse wird aber eine Kopie angelegt:
Beispiel: sort vs. sorted
1
2

myList = [5, 9, 2]
sortedList = sorted(myList)

3
4
5

print("myList after sorted: ", myList)
print("sortedList
: ", sortedList)

6
7
8
9

myList.sort()
print("reversed(myList)
print("myList after sort

: ", reversed(myList))
: ", myList)

Ausgabe: sort vs. sorted
myList after sorted: [5, 9, 2]
sortedList
: [2, 5, 9]
reversed(myList)
: [9, 5, 2]
myList after sort : [2, 5, 9]
Dies lässt sich auch auf dicts anwenden. Achten Sie darauf, dass ohne weitere Angaben nur die Schlüssel
des dicts herangezogen werden:

47

Beispiel: dicts und sorted
houseStark = {"Sigil" : "A grey direwolf on a white field",
"Words" : "Winter Is Coming", "Seat" : "Winterfell"}

1
2
3

print( sorted(houseStark) )
print( sorted(houseStark.items()) )

4
5

Ausgabe: dicts und sorted
['Seat', 'Sigil', 'Words']
[('Seat', 'Winterfell'), ('Sigil', 'A grey direwolf on a white field'),
('Words', 'Winter Is Coming')]
Wie schon angesprochen ist die Anordnung der Elemente in dicts nicht fest. Daher kann auch die
Funktion reversed nicht mit solchen aufgerufen werden.
zip
Mit dem Befehl zip können Listen zu Tabellen zusammengeschlossen werden. Jede einzelne Liste liefert
die Daten einer Spalte. Das Ergebnis ist eine Datensammlung, die man zum Beispiel wieder zu einer
Liste von Zeilen machen kann:
Beispiel: zip
1
2
3
4
5
6
7

categories
houseStark

= ["House", "Sigil", "Words", "Seat"]
= ["Stark", "A grey direwolf on a white field",
"Winter Is Coming", "Winterfell"]
houseLannister = ["Lannister", "A gold lion, on a crimson field",
"Hear Me Roar!", "Casterly Rock"]
houseTyrell
= ["Tyrell", "A golden rose on a green field",
"Growing Strong", "Highgarden"]

8
9
10
11

zipper = zip(categories, houseStark, houseLannister, houseTyrell)
houses = list(zipper)
print( houses )
Ausgabe: zip
[('House', 'Stark', 'Lannister', 'Tyrell'),
('Sigil', 'A grey direwolf on a white field', 'A gold lion,
on a crimson field', 'A golden rose on a green field'),
('Words', 'Winter Is Coming', 'Hear Me Roar!', 'Growing Strong'),
('Seat', 'Winterfell', 'Casterly Rock', 'Highgarden')]

min und max
Wie der Name vermuten lässt, durchsuchen diese beiden Befehle einen Container nach seinem kleinsten
bzw. größsten Element. Dabei werden dieselben Regeln angewandt, die schon für die Vergleichsoperatoren
(< und >) besprochen wurden:

48

Beispiel: min und max
1
2
3

dataNumbers = [4, 3.7, -2112]
dataStrings = ["Victoria", "Epsi", "Charlotte"]
dataLists
= [ [1], [1, 2], [2, 2]]

4
5
6
7

print( min(dataNumbers), max(dataNumbers) )
print( min(dataStrings), max(dataStrings) )
print( min(dataLists ), max(dataLists ) )
Ausgabe: min und max
-2112 4
Charlotte Victoria
[1] [2, 2]

4.10. Überblick
Datenstruktur
list
tuple
set
frozenset
String
range
dict

Klammern
[eckig]
(rund)
{geschweift}
{geschweift} mit Präfix
erstellt aus Type Conversion
’’Doppelte Anführungszeichen’’
–keine–
{geschweift}
Doppelpunkt trennt Schlüssel : Wert

Mutable
ja
nein
ja

nein
nein

Besonderer Nutzen
All-Purpose-Listentyp
Schreibgeschützte Listen
keine Doubletten
Schreibgeschützte Listen
ohne Doubletten
Texte
Bereiche von Ganzzahlen

ja

Zuordnungen

nein

Tabelle 4.1.: Überblick über die verschiedenen Container-Datentypen in Python

49

„colors.rgb(’’blue’’) yields ’’#0000FF’’. colors.rgb(’’yellowish blue’’) yields NaN.
colors.sort() yields ’’rainbow’’“
Abbildung 4.4.: Eingabeschemata in anderen Programmiersprachen
Quelle: https://xkcd.com/1537/

50
