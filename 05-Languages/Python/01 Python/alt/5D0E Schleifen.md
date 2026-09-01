---
aliases: 
tags: 
title: 5D0E Schleifen
---
1. Schleifen
Insanity: doing the same thing over and over again and expecting different results
Albert Einstein

Computer können dazu benutzt werden, die immer gleichen (lästigen) Aufgaben wiederholt und in
schneller Folge auszuführen. Es ist möglich, bei jeder Wiederholung einen einzelnen Eingabewert zu
ändern und so z. B. Berechnungen für einen ganzen Wertebereich durchzuführen, oder Messwerte von
einem Gerät zu überwachen.
Zeichnet man ein Flussdiagramm eines solchen Programms (wie in Abbildung 5.1), so findet sich in der
Regel ein Programmteil, der zur Vorbereitung dient und in gewohnter Weise „von oben nach unten“
abgearbeitet wird. An diesen schließt sich ein Abschnitt an, der einige Male wiederholt werden soll, und
daher im Flussdiagramm als Bogen dargestellt wird. Nach diesem Teil könnte die Ausgabe der Ergebnisse
stattfinden, die wiederum in gewohnter linearer Weise (also von oben nach unten) bearbeitet wird.
Die Form dieses Flussdiagramms motiviert den Namen Schleife für eine solche Struktur.
Vorbereitung

Wiederholungen

Nachbereitung
Abbildung 5.1.: Programmflussdiagramm mit Schleife

In der Regel ist die Zahl der Schleifendurchläufe an eine Bedingung geknüpft; genauso sind aber
auch Endlosschleifen möglich. In diesem Kapitel werden wir verschiedene Schleifentypen und ihre
Anwendungsfelder kennen lernen.
Laufende Programme zum Beenden zwingen: STRG + C
Macht man einen Fehler bei der Formulierung der Bedingung, so kann man unbeabsichtigt eine
Endlosschleife erstellen. Ein solches Programm wird von sich selbst aus nie beendet. Wir können
zu jeder Zeit aber das Beenden erzwingen, indem wir in der Konsole die Tastenkombination STRG

+ C drücken.

51

5.1. while-Loops
5.1.1. Grundstruktur
Mit dem Schlüsselwort while wird ein Codeblock eingeleitet, der so lange wiederholt wird, bis eine
Bedingung nicht mehr erfüllt ist, d. h. bis ihr Wahrheitswert zu False ausgewertet wird. Die Syntax
lautet:
Syntax: while (1)
while Wahrheitswert :
Schleifenkoerper
Betrachten Sie hierzu folgendes Beispiel zum Zinseszins: „berechnet“ wird, nach wie vielen Jahren ein
Startkapital bei gegebenem Zinssatz über einen Grenzwert hinauswächst1 .
Beispiel: Zinseszins (1)
1
2
3

capital = float(input("Bitte geben Sie Ihr Startkapital ein: "))
interest = float(input("Bitte geben Sie den Zinssatz ein: "
))
limit
= float(input("Bitte geben Sie Ihr Zielkapital ein :" ))

4
5

years

= 0

6
7
8
9

while capital < limit :
capital *= 1 + interest
years
+= 1

10
11

print("Nach", years, "Jahren ist das Sparziel erreicht.")

Nachdem die Variablen capital, interest, limit und years ihre Werte zugewiesen bekommen
haben, wird überprüft, ob capital < limit. Wenn dies erfüllt ist, werden die Zeilen 8 und 9 ausgeführt.
Danach springt die Codeausführung zurück zu Zeile 7. Es wird solange der Schleifenkörper in Zeile 8
und 9 wiederholt, bis die Bedingung in Zeile 7 nicht mehr erfüllt ist. Erst dann wird mit der Ausführung
in Zeile 11 fortgesetzt. So erklärt sich folgendes Ausführungsbeispiel:
Ausführungsbeispiel: Zinseszins (1)
Bitte geben Sie Ihr Startkapital ein: 100
Bitte geben Sie den Zinssatz ein: .1
Bitte geben Sie Ihr Zielkapital ein :300
Nach 12 Jahren ist das Sparziel erreicht.
Der Schleifenkörper wird nie ausgeführt, wenn die Bedingung nicht bereits vor Beginn der Schleife erfüllt
war. Geben Sie im obigen Beispiel etwa ein Startkapital ein, das größer als das Zielkaptital ist, so folgt die
Ausgabe Nach 0 Jahren ist das Sparziel erreicht. Die Zeile years += 1 wird nie ausgeführt.

1 Natürlich ließe sich dies auch über die Logarithmus-Funktion realisieren; hier aber soll die Funktionsweise von Schleifen

gezeigt werden

52

Endlosschleifen
Manchmal möchte man, dass ein Programm auf unbestimmte Zeit läuft. Code, der die Messwerte
einer Wetterstation verarbeitet, soll dies vielleicth „für immer“ tun. In diesem Fall bietet sich
eine Endlosschleife an:
Code: Endlosschleife
1
2

while True:
Anweisungen

Da True eine Konstante ist, wird sich nichts daran ändern, dass sie immer eben zu True ausgewertet
wird. Das Programm läuft bis in alle Ewigkeiten (oder zumindest, bis es vom Betriebssystem
beendet wird). Üblicherweise enthält Anweisungen dann Code, der das Programm dennoch zu
einem Ende führt. Diese Anweisungen könnten aber an komplexe Bedingungen geknüpft sein, die
für die Form von while zu sperrig sind.

5.1.2. Eingriff in den Kontrollfluss
Es gibt Situtaionen, wo die Ausführung einer Schleife an mehrere, voneinander unabhängige Bedingungen
geknüpft sind. Dies lässt sich mit logischen Operatoren (Siehe Abschnitt 2.2.1) umsetzen. Häufig ist
es aber übersichtlicher, das Schlüsselwort break in einem eigenen if-Block zu benutzen. Mit break
wird der Schleifenkörper verlassen, die Ausführung wird hinter der Schleife fortgesetzt, ganz als ob die
Bedingung hinter while selbst nicht mehr erfüllt wäre. Zusätzlich zur Übersichtlichkeit bietet diese
break-Methode die Möglichkeit, an einem beliebigen Punkt innerhalb der Schleife zu prüfen, ob der
Schleifenkörper verlassen werden soll.
Beispiel: break
1
2

count = 0
value = 0

3
4
5
6
7

while count < 12 :
newValue = float(input("Bitte geben Sie einen weiteren Wert ein: "))
value += newValue
count += 1

8
9
10
11

if value > 9000 :
value = "over nine thousand!!"
break

12
13
14
15
16

print(
"Bisheriger Gesamtwert nach Eingabe von", count,
"Werten:", value
)

17
18

print("Gesamtwert:", value)

Das Einlesen von newValue sowie die Updates an value und count werden bei jedem Durchlauf der
Schleife durchgeführt. Die Ausgabe des Zwischenstandes (Zeilen 13-16) hingegen nur, wenn die Zweite
Bedingung (value > 9000) nicht erfüllt war. So erklärt sich folgendes Ausführungsbeispiel:

53

Ausführungsbeispiel: break
Bitte geben Sie einen weiteren Wert ein: 1
Bisheriger Gesamtwert nach Eingabe von 1 Werten: 1.0
Bitte geben Sie einen weiteren Wert ein: 50
Bisheriger Gesamtwert nach Eingabe von 2 Werten: 51.0
Bitte geben Sie einen weiteren Wert ein: 9000
Gesamtwert: over nine thousand!!
Ähnlich kann continue benutzt werden, um einen Teil des Schleifenkörpers zu überspringen, ohne die
Schleife selbst zu verlassen. Der Befehl continue springt also zur Überprüfung der while-Bedingung
zurück:
Beispiel: continue
1

container = []

2
3
4

while len(container) < 3 :
value = int(input("Bitte geben Sie eine gerade Zahl ein: "))

5

if value % 2 :
print(value, "ist ungerade und daher nicht zulässig.")
continue

6
7
8
9

container.append(value)
print("Bisher eingegeben: ", container)

10
11

Ausführungsbeispiel: continue
Bitte geben Sie eine gerade Zahl ein: 2
Bisher eingegeben: [2]
Bitte geben Sie eine gerade Zahl ein: 3
3 ist ungerade und daher nicht zulässig.
Bitte geben Sie eine gerade Zahl ein: 4
Bisher eingegeben: [2, 4]
Bitte geben Sie eine gerade Zahl ein: 6
Bisher eingegeben: [2, 4, 6]
Garantierte erste Ausführung
Wir können Endlosschleifen zusammen mit break nutzen, um zu garantieren, dass der Schleifenkörper mindestens einmal ausgeführt wird, unabhängig davon, ob die Schleifenbedingung zu
Anfang bereits erfüllt war:
Beispiel: continue
1
2
3
4

while True:
Schleifenkoerper
if Bedingung :
break

Die Überprüfung auf Bedingung wird so an das Schleifenende geschoben.

54

5.1.3. else bei while
Wie schon angesprochen wird der Schleifenkörper nicht ausgeführt, wenn die Bedingung schon vor
der ersten Durchführung nicht erfüllt war. In diesem Fall kann ein optionaler else-Block ausgeführt
werden:
Syntax: while (2)
while Wahrheitswert :
Schleifenkoerper
else :
AlternativCode
Betrachten wir dies an einem erweiterten Beispiel:
Beispiel: Zinseszins (2)
1
2
3

capital = float(input("Bitte geben Sie Ihr Startkapital ein: "))
interest = float(input("Bitte geben Sie den Zinssatz ein: "
))
limit
= float(input("Bitte geben Sie Ihr Zielkapital ein :" ))

4
5

years

= 0

6
7
8
9
10
11

while capital < limit :
capital *= 1 + interest
years
+= 1
else :
print("Das Startkapital ist bereits groß genug.")

12
13

print("Nach", years, "Jahren ist das Sparziel erreicht.")

Die Zeile Das Startkapital ist bereits groß genug. wird genau dann ausgegeben, wenn für capital
ein Wert größer oder gleich limit eingegeben wurde. Weiterhin wird für diesen Fall Nach 0 Jahren
ist das Sparziel erreicht. als zweite Zeile ausgegeben.
Garantierte erste Ausführung mit else
Statt der oben gezeigten Form mit break könnte auch mit else dafür gesorgt werden, dass der
Schleifenkörper mindestens einmal ausgeführt wird. Hierzu kopiert man einfach den kompletten
Code des Schleifenkörpers in den else-Block.
Dies erfüllt zwar seinen Zweck, ist aber eine Fehlerquelle und sollte vermieden werden. Wenn Sie
später Codestellen ändern, müssen Sie auch daran denken, dieselben Änderungen im else-Block
umzusetzen. Dies wird leicht vergessen.

5.2. for-Loops
5.2.1. Grundstruktur
Schleifen mit for führen Code für jedes Element aus einer Datenstruktur wie in Kapitel 4 beschrieben
aus. Nacheinander wird jedes Element des Containers über eine Hilfsvariable ansprechbar gemacht und

55

dann Code ausgeführt, der von dieser Hilfsvariablen abhängig sein kann.
Syntax: for
for Variable in Container :
Schleifenkoerper
Der Code lässt sich also fast wie englische Sprache lesen: „für jedes Objekt in Container mache
Schleifenkörper“.
Beispiel: for (1)
1

tasklist = ["write the script", "drink some coffee", "drink some more coffee"]

2
3
4
5

print("Your tasks today:")
for task in tasklist :
print("*", task)
Ausgabe: for (1)
Your tasks today:

+ write the script
+ drink some coffee
+ drink some more coffee"

Als Container dienen besonders häufig range-Objekte. Wann immer eine durchzählbare Menge von
Zahlen gebraucht wird, kann ein solches range-Objekt genutzt werden2 :
Beispiel: for (2)
1
2
3

print("the first 10 square numbers are:")
for i in range(10) :
print(f"{i} 2 = {i**2}")
Ausgabe: for (2)
the first 10 square numbers are:
02 = 0
12 = 1
22 = 4
32 = 9
42 = 16
52 = 25
62 = 36
72 = 49
82 = 64
92 = 81

2 Das folgende Beispiel und einige weitere enthalten die Option sep="". Damit wird der Funktion print mitgeteilt, dass

kein Leerzeichen zwischen den einzelnen Werten gedruckt werden soll. Vorerst können Sie diese Option ignorieren. In
Kapitel 6 wird diese Technik erklärt.

56

Falls Sie von einer anderen Sprache kommen: Keine Indices
Das Konzept einer for-Schleife existiert in fast allen Programmiersprachen. Häufig ist dort die
Funktionalität jedoch auf Zahlen eingeschränkt. Will man über die Elemente eines Containers
iterieren, muss man dort die Schleife über die Indices laufen lassen. Das sieht dann beispielsweise
so aus:
Beispiel: for mit Indices
1
2

tasklist = ["write the script", "drink some coffee", "drink more coffee"]
N = len(tasklist)

3
4
5
6

print("Your tasks today:")
for i in range(N) :
print("*", tasklist[i])

Dieses Beispiel funktioniert zwar, hat aber mehr Fehlerquellen. Man muss mindestens dafür
sorgen, dass der Wert N zu jeder Zeit die korrekte Anzahl von Elementen in tasklist enthält.
Sprachen wie C oder BASIC machen solche Strukturen leider nötig. In Python dagegen können
wir diese Aufgabe getrost dem Interpreter überlassen.
Falls sie bereits eine andere Sprache kennen, sind sie es vielleicht gewohnt, for-Schleifen über
Indices laufen zu lassen. Gewohnen Sie sich dies in Python ab. Nicht nur vermeiden Sie so eine
Fehlerquelle; Ihr Code wird tatsächlich auch performanter, wenn Sie die „Python-Hausmittel“
voll ausschöpfen.
In einem for-Befehl können auch Container entpackt werden:
Beispiel: for (3)
1
2
3
4
5
6
7
8

books = [
("Frank Herbert", "Dune"),
("Douglas Adams", "The Hitchhikers Guide To The Galaxy"),
("Randall Munroe", "What If"),
("Isaac Asimov", "Foundation"),
("Willy Russell", "Educating Rita"),
("Moving Pictures", "Terry Pratchett")
]

9
10
11
12

print("You should definitively read:")
for author, title in books :
print("*", title, "by", author)
Ausgabe: for (3)
You should definitively read:

+ Dune by Frank Herbert
+ The Hitchhikers Guide To The Galaxy by Douglas Adams
+ What If by Randall Munroe
+ Foundation by Isaac Asimov
+ Educating Rita by Willy Russell
+ Moving Pictures by Terry Pratchett

57

Natürlich müssen Tupel nicht enptackt werden:
Beispiel: for (4)
1
2

import math
vectors = [(1, 1), (4, 7), (-1, 2)]

3
4
5

for v in vectors :
print("vector", v, "has length", math.hypot(v[0], v[1]))
Ausgabe: for (4)
vector (1, 1) has length 1.4142135623730951
vector (4, 7) has length 8.06225774829855
vector (-1, 2) has length 2.23606797749979
Objekt und Index: enumerate
Manchmal wird sowohl das Objekt als auch seine Position in der Liste benötigt. Mit der Funktion
enumerate lässt sich ein Tupel aus genau diesen beiden Objekten erzeugen:
Beispiel: for mit enumerate
1

tasklist = ["write the script", "drink some coffee", "drink more coffee"]

2
3
4
5

print("Your tasks today:")
for i, task in enumerate(tasklist) :
print(f"{i + 1}. {task} ")
Ausgabe: for mit enumerate
Your tasks today:

1. write the script
2. drink some coffee
3. drink more coffee

Beachten Sie, dass die Zahlen, wie von enumerate erzeugt bei 0 beginnen.

58

Iteration über zwei Listen zugleich: zip
Nicht selten müssen die Daten in zwei Listen zueinander in Bezug gesetzt werden. Stellen Sie
sich beispielsweise vor, Sie haben zwei Messreihen aufgenommen, und wollen nun die Abweichungen dieser Messreihen berechnen. Hierzu können Sie den Ihnen bereits bekannten Befehl zip
benutzen:
Beispiel: for mit zip
1
2

data1 = [1.7, 2.2, -4.1]
data2 = [1.8, 2.0, -3.8]

3
4
5
6

print("Difference in datasets:")
for i, t in enumerate(zip(data1, data2)) :
print(f"Datapoint {i} : {t} differs by : {t[0] - t[1]}")
Ausgabe: for mit zip
Datapoint 0: (1.7, 1.8) differs by : -0.10000000000000009
Datapoint 1: (2.2, 2.0) differs by : 0.20000000000000018
Datapoint 2: (-4.1, -3.8) differs by : -0.2999999999999998

Wie erwähnt können alle Container für for-Schleifen verwendet werden, die wir aus Kapitel 4 kennen3 .
Als Beispiel sei die Ausgabe eines dicts gezeigt:
Beispiel: for mit dicts
1
2
3

houseStark = {"Sigil" : "A grey direwolf on a white field",
"Words" : "Winter Is Coming",
"Seat" : "Winterfell"}

4
5
6
7

print("Summary of House Stark:")
for key, value in houseStark.items() :
print(f"{key:5} : {value} ")
Ausgabe: for mit dicts
Summary of House Stark:
Sigil: A grey direwolf on a white field
Words: Winter Is Coming
Seat : Winterfell

5.2.2. Eingriffe in den Kontrollfluss, else
Auch bei for können die Befehle break und continue eingesetzt werden, und verhalten sich dort
genauso, wie bei while. Außerdem existiert auch bei for eine optionale else-Klausel. Der Code hierin
wird ausgeführt, wenn die for-Schleife normal zum Ende kam, also nicht durch break abgebrochen
wurde.
3 In Kapitel 7 werden wir noch Möglichkeiten kennen lernen, weitere iterierbare Objekte zu erstellen.

59

Beispiel: for mit break, continue und else
1
2
3
4
5
6

tasks = [
("hidden", "watch Fullmetal Alchemist"),
("open", "work very hard on Python"),
("open", "drink all the coffee")
]
search = ["watch", "work"]

7
8
9
10
11
12
13
14
15

for keyword in search :
for ID, (state, task) in enumerate(tasks) :
if state == "hidden" : continue
if keyword in task :
print(keyword, "was found in task ID", ID)
break
else :
print(keyword, "was not found in the tasks.")
Ausgabe: for mit break, continue und else
watch was not found in the tasks.
work was found in task ID 1

Machen Sie sich klar, was hier passiert: In der äußeren Schleife sorgen wir dafür, dass wir nacheinander
nach zwei Begriffen in der Aufgabenliste suchen. Diese Begriffe werden mit keyword „greifbar gemacht“.
Für die innere Schleife betrachten wir ein Tupel aus einer ID und einem weiteren Tupel, das die Elemente
von tasks umfasst. Hierfür verwenden wir die Symbole ID, state und task. Da state und task aus
den Elementen von tasks gebildet werden (also für sich eine eigene Einheit bilden), müssen diese in
Klammern gefasst werden.
Für jedes Element aus tasks wird zunächst der state betrachtet. Ist dieser gleich "hidden", so wird
das Element in der Analyse übersprungen (wir führen continue aus.) Andernfalls wird geprüft, ob
keyword in der Aufgabenbeschreibung task gefunden wurde. Ist dies der Fall, so ist die Analyse des
aktuellen Elements der Aufgabenliste tasks abgeschlossen (wir führen break aus), und das nächste
keyword kann betrachtet werden.
In dem Fall, wo das keyword gefunden werden kann (also z. B. für "work") wird also ein break ausgelöst
und folglich der Code bei else übersprungen. Dagegen löst das keyword "watch" den if-Block in Zeile
11 nicht aus (da die Prüfung mit Zeile 10 bereits übersprungen wird). Daher läuft die for-Schleife
vollständig durch, und der else-Block wird ausgeführt.

5.3. List Comprehension
Stellen Sie sich vor, Sie brauchen eine Liste mit den Quadraten aller geraden Ganzzahlen. Sie können
diese Aufgabe jetzt schon so lösen:

60

Beispiel: for zum Erstellen einer Liste
1
2

evenSquares = []
N = 20

3
4
5

for i in range(2, N, 2) :
evenSquares.append(i**2)

6
7

print(evenSquares)
Ausgabe: for zum Erstellen einer Liste
[4, 16, 36, 64, 100, 144, 196, 256, 324]

Dieselbe Konstruktion können Sie verkürzt auch schreiben als:
Beispiel: List Comprehension
1
2
3

N = 20
evenSquares = [ i**2 for i in range(2, N, 2) ]
print(evenSquares)

Die Abstrakte Syntax lautet also:
Syntax : List Comprehension (1)
1
2

variable = [ expression for element in iterable ]
print(evenSquares)

Dabei sind:

+ iterable ein beliebiger Datencontainer, wie in allen vorigen Beispielen
+ element eine Variable, über die nacheinander die einzelnen Elemente aus iterable durchgelesen
werden. Auch hier können Tupel entpackt werden. In diesem Fall müssen entsprechend mehrere
Variablen genannt werden.
+ expression ist ein beliebiger Ausdruck, der die zu erzeugenden Listenelemente beschreibt.
List Comprehension kann auch ineinander verschachtelt werden (wird dann aber schnell unübersichtlich).
Die folgende Zeile erzeugt die sogenannte „Telefonmatrix“:
Beispiel: Telefonmatrix
1
2
3
4

telephone = [
[3 * row + column + 1 for column in range(3)]
for row in range(3)
]

5
6
7

for line in telephone :
print(line)

8
9

print(telephone)

61

Der Code erzeugt also eine Liste von Listen:
Ausgabe: Telefonmatrix
[1, 2, 3]
[4, 5, 6]
[7, 8, 9]
[[1, 2, 3], [4, 5, 6], [7, 8, 9]]
Sprechende Variablennamen
Im obigen Beispiel Telefonmatrix taucht die Variable row zum ersten Mail in Zeile 2 auf, obwohl
erst in Zeile 3 erklärt wird, welche Werte row haben wird, oder um welche Art von Werten (Integer,
Fließkommazahlen, Strings, Container, ...) es sich überhaupt handelt. Strukturell kommen wir
also in die Gefahr von schwer lesbarem Code, und haben damit eine Fehlerquelle. Durch die
Benennung der Variablen ist aber dennoch schnell klar, was hier passiert. Die Variablen row und
column bezeichnen die Nummer von Zeile und Spalte einer Matrix, sind also Integers zwischen 0
und einer Obergrenze, die sich aus der Größe der Matrix ergibt.
Solche Überlegungen zur Benennung der Objekte sind extrem wichtig in auch nur mittelgroßen Projekten. Geben Sie nicht der Versuchung nach, Variablen aus Bequemlichkeit einfach a, b, c, ...
zu nennen, sondern überlegen Sie, welche Art von Information darin abgelegt werden soll, und
schreiben dies dann auch aus! Auch Abkürzungen sollten vermieden werden, da sich hierbei oft
Fehler einschleichen. Hieß die Variable nun numElmL oder nel oder nElements? Diese Frage stellt
sich nicht, wenn Sie sich die kleine Mühe machen, konsequent numberElementsList zu tippen;
Sie sparen sich dadurch die große Mühe, häufig zurück zu scrollen und Fehler auszumerzen, die
sich daraus ergeben, dass Sie mal numElmL und mal nel getippt haben.
Bei der List Comprehension können Sie auch die Aufnahme eines Wertes in die Ergebnis-Liste an eine
Bedingung knüpfen. Sie erreichen dies, indem Sie einfach eine if-Klausel anfügen:
Syntax : List Comprehension (2)
1
2

variable = [ expression for element in iterable if condition ]
print(evenSquares)

Als Beispiel soll eine Liste aller Primzahlen bis zu einer Obergrenze N berechnet werden. Wir nutzen
dazu aus, dass eine Primzahl exakt zwei Ganzzahl-Teiler hat. Wir erstellen also zuerst für jede Zahl
zwischen 2 und N alle Ganzzahl-Teiler, und akzeptieren nur solche Zahlen in unserem Ergebnis, bei dem
diese Liste der Teiler die Länge 2 hat4 .

4 Der gezeigte Code ist sowohl bezüglich Rechenzeit als auch bezüglich Speicherbedarf schlecht, illustriert aber schön die

Technik, um die es uns hier geht.

62

Beispiel: List Comprehension mit Bedingung
1
2
3
4
5
6
7
8

N = 100
primeNumbers = [
i for i in range (2, N)
if len (
[j for j in range (1, i+1)
if i % j == 0]
) == 2
]

## übernehme alle Zahlen i zwischen 2 und N ...

## ... für die die die Anzahl der Teiler ...

## ... (d.h. die Zahlen zwischen 1 und i ...

## ... die i ganzzahlig teilen) ...

## ... gleich 2 ist.

9
10

print(primeNumbers)
Ausgabe: List Comprehension mit Bedingung
[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73,
79, 83, 89, 97]

List Comprehension lässt sich auch für sets und dicts umsetzen. Die Synax verlangt dann nur eine
minimale Anpassung:
Syntax : List Comprehension (3)
1
2

setVariable = {
Ausdruck for Element in Container if Bedingung }
dictVariable = { key : Ausdruck for Element in Container if Bedingung }

Natürlich sind die if-Klauseln auch für sets und dicts optional.
Beispiel: List Comprehension für sets und dicts
1
2
3
4

## Die ersten 10 Quadratzahlen als set:

print( {i**2 for i in range (10)} )

## Die ersten 10 Quadratzahlen als dict

print( {i : i**2 for i in range (10)} )
Ausgabe: List Comprehension für sets und dicts
{0, 1, 64, 4, 36, 9, 16, 49, 81, 25}
{0: 0, 1: 1, 2: 4, 3: 9, 4: 16, 5: 25, 6: 36, 7: 49, 8: 64, 9: 81}
Aufwändige Berechnungen vorbereiten
In wissenschaftlichen Simulationen treten manche Ausdrücke wie ek gehäuft für die immer gleichen
Werte von k auf. Anstatt die Exponentialfunktion immer wieder neu auszuwerten lohnt es sich
oft, die Werte einmal in einer Liste vorzubereiten und so den Rechenaufwand zu minimieren. List
Comprehension bietet sich hierzu perfekt an.
Für besonders gleichmäßige Verteilungen (d. h. wenn k alle Ganzzahlen zwischen 0 und einer
Obergrenze sind) sollten lists verwendet werden, da diese leichter ausgelesen werden können.
Allgemeinere Lookup-Tables lassen sich gut in dicts abbilden.

63


