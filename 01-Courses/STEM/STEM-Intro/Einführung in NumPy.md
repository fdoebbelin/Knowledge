## Was ist NumPy?

NumPy (kurz für _Numerical Python_) ist eine Open-Source-Python-Bibliothek für effizientes numerisches Rechnen[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=NumPy%20,Learn). Sie wird in Wissenschaft und Technik weit verbreitet eingesetzt und bietet leistungsfähige Werkzeuge zur Verarbeitung und Analyse großer Datenmengen. Der Hauptbestandteil von NumPy ist ein mehrdimensionaler Array-Datentyp (`ndarray`), der zusammen mit einer Vielzahl von Routinen geliefert wird, um schnelle mathematische und logische Operationen auf diesen Arrays auszuführen[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=NumPy%20is%20the%20fundamental%20package,including%20mathematical%2C%20logical%2C%20shape%20manipulation). Typische Funktionen umfassen etwa mathematische Berechnungen, Statistik, Lineare Algebra, Zufallszahlen und vieles mehr, was NumPy zum _fundamentalen Paket für wissenschaftliches Rechnen in Python_ macht[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=NumPy%20is%20the%20fundamental%20package,including%20mathematical%2C%20logical%2C%20shape%20manipulation).

## NumPy-Arrays (`ndarray`) als Kernstück

Im Zentrum von NumPy steht das `ndarray`-Objekt, das N-dimensionalen Arrays homogener Datentypen entspricht[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=At%20the%20core%20of%20the,and%20the%20standard%20Python%20sequences). Ein NumPy-Array kann man sich als Gitter (ähnlich einer Liste oder Tabelle) vorstellen, in dem jedes Feld einen Wert gleichen Typs enthält. Dieses Array kann ein- oder mehrdimensional sein – von 1D-Vektoren über 2D-Matrizen bis hin zu höherdimensionalen „Tensoren“. Viele Operationen auf diesen Arrays sind in vor-kompiliertem C-Code implementiert, was eine sehr hohe Geschwindigkeit ermöglicht[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=At%20the%20core%20of%20the,and%20the%20standard%20Python%20sequences). Praktisch alle wissenschaftlichen Python-Bibliotheken (z. B. Pandas für Datenanalyse oder SciPy für weiterführende numerische Methoden) bauen auf NumPy-Arrays auf und nutzen deren Leistungsfähigkeit[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,how%20to%20use%20NumPy%20arrays).

 

Ein NumPy-Array ist **homogen**, d. h. alle Elemente haben den gleichen Datentyp (z. B. nur Zahlen, nur Integer oder nur Gleitkommazahlen)[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,arrays%20of%20different%20sized%20elements). Außerdem hat ein Array eine **feste Größe** – einmal erstellt, ändert sich die Anzahl der Elemente nicht ohne Weiteres[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,array%20and%20delete%20the%20original). NumPy-Arrays können zwar in beliebig vielen Dimensionen organisiert sein, aber ihre Form ist immer **rechtwinklig**: zum Beispiel müssen in einem 2D-Array alle Zeilen gleich viele Spalten haben[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=,the%20same%20number%20of%20columns). Diese Eigenschaften ermöglichen es NumPy, sehr effiziente Speicher- und Rechenverfahren zu nutzen[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=When%20these%20conditions%20are%20met%2C,than%20less%20restrictive%20data%20structures)[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Most%20NumPy%20arrays%20have%20some,For%20instance). Im nächsten Abschnitt betrachten wir diese Unterschiede genauer.

## Unterschiede zwischen NumPy-Arrays und Python-Listen

Obwohl NumPy-Arrays auf den ersten Blick ähnlich wie Python-Listen verwendet werden können, gibt es wichtige Unterschiede in Struktur und Verhalten[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=At%20the%20core%20of%20the,and%20the%20standard%20Python%20sequences). Insbesondere wurde NumPy entwickelt, um große Mengen numerischer Daten effizient zu verarbeiten. Im Folgenden die Hauptunterschiede zwischen einem NumPy-Array (`numpy.ndarray`) und einer nativen Python-Liste:

- **Homogener Datentyp:** In einem NumPy-Array müssen alle Elemente vom selben Typ sein (etwa alle `int64` oder alle `float`). Dies macht Arrays kompakter und speichereffizienter als Listen, die verschiedene Datentypen enthalten können[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,type%20information%20for%20each%20element). Eine Python-Liste kann heterogene Typen speichern, was zwar flexibel ist, aber zu höherem Speicherverbrauch und potenziell langsameren numerischen Operationen führt[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,due%20to%20Python%27s%20interpretation%20overhead).
    
- **Feste Größe:** NumPy-Arrays haben eine feste Größe bei der Erstellung. Man kann die Größe nachträglich nicht einfach verändern – stattdessen müsste ein neues Array mit der gewünschten Größe erzeugt werden[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,array%20and%20delete%20the%20original). Python-Listen dagegen können dynamisch wachsen oder schrumpfen (z. B. mit `append()` oder `pop()`), was jedoch mit Performance-Kosten verbunden ist.
    
- **Speicherlayout (kontiguierlicher Speicher):** Die Elemente eines NumPy-Arrays liegen zusammenhängend im Speicher, in einem einzigen Block[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,element). Dadurch wird **Fragmentierung** vermieden und der Zugriff auf die Elemente ist sehr effizient. Eine Python-Liste speichert hingegen Referenzen auf Python-Objekte, die irgendwo im Speicher liegen; die Listenelemente müssen nicht nebeneinander liegen, was zu Speicherfragmentierung und Ineffizienz führen kann[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,due%20to%20Python%27s%20interpretation%20overhead). Zudem muss für jedes Listenelement Verwaltungs-Overhead (Typinformation, Referenzzähler etc.) gespeichert werden[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,due%20to%20Python%27s%20interpretation%20overhead), während NumPy bei Arrays den Datentyp nur einmal für alle Elemente vorhält.
    
- **Leistung und vektorisiertes Rechnen:** NumPy ist auf Geschwindigkeit optimiert und deutlich schneller als reine Python-Listen bei numerischen Berechnungen[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,Arrays%20und%20werden%20elementweise%20interpretiert). Viele Array-Operationen sind in C implementiert und laufen _vektorisiert_, d. h. ohne explizite Python-Schleifen über die Elemente[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=NumPy%20gives%20us%20the%20best,compiled%20C%20code.%20In%20NumPy)[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=overhead%20in%20lists,than%20equivalent%20operations%20on%20lists). Python-Listen führen vergleichbare Operationen Element-für-Element in Python aus, was aufgrund des Interpreters deutlich langsamer ist[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,due%20to%20Python%27s%20interpretation%20overhead). In NumPy kann man z. B. zwei Arrays einfach mit `c = a * b` multiplizieren, und NumPy führt dies intern in optimiertem Maschinencode aus (ähnlich schnell wie eine C-Schleife)[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=NumPy%20gives%20us%20the%20best,compiled%20C%20code.%20In%20NumPy) – wohingegen man bei normalen Listen entweder eine Python-Schleife oder Listen-Komprehension bräuchte, was wesentlich mehr Zeit und Code erfordert.
    
- **Funktionsumfang für numerische Operationen:** NumPy stellt zahlreiche Funktionen und mathematische Operationen zur Verfügung, die auf Arrays als Ganzes wirken. Zum Beispiel können arithmetische Operatoren (`+`, `-`, `*`, `/` usw.) direkt auf Arrays angewendet werden und werden automatisch **elementweise** ausgeführt[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,mit%20diesem%20Skalar%20gef%C3%BCllt%20ist). Ebenso gibt es vordefinierte Funktionen wie `np.sqrt`, `np.log`, `np.sin` usw., die auf jedes Element eines Arrays angewendet werden können, ohne dass man explizit über die Elemente iterieren muss[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,log10%28a). Solche _vektorisierten_ Funktionen (auch _universelle Funktionen_ genannt) fehlen für Python-Listen – dort müsste man Schleifen schreiben oder auf Listen-Komprehension zurückgreifen, um ähnliche Berechnungen durchzuführen[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=have%20slower%20mathematical%20operations%20due,NumPy%20functions%20for%20numerical%20operations). Zusätzlich bietet NumPy so genannte **Reduktionsfunktionen** wie z. B. `np.sum` (Summe aller Elemente), `np.mean` (arithmetisches Mittel), `np.min`/`np.max` (Minimum/Maximum) u.v.m., die effiziente Berechnungen über ein Array oder entlang einer Achse des Arrays ermöglichen[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Reduktionsfunktionen%C2%B6). Solche Aggregationen sind mit Listen nur umständlich oder mit Hilfe von Funktionen wie `sum(list)` möglich, aber nicht so spezialisiert optimiert.
    
- **Mehrdimensionale Strukturen:** Ein weiterer Unterschied ist die native Unterstützung mehrdimensionaler Arrays. Während man in Python mit verschachtelten Listen ebenfalls so etwas wie Matrizen darstellen kann, fehlt Listen die stringente, rechteckige Struktur – z. B. könnten Listen von Listen „unregelmäßig“ sein (verschiedene Unterlisten unterschiedlicher Länge). NumPy-Arrays hingegen können echte Matrizen und höherdimensionale Datensätze darstellen, wobei alle Zeilen/Spalten konsistente Längen haben müssen[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=,the%20same%20number%20of%20columns). Diese strikte rechteckige Form erleichtert mathematische Operationen wie Matrixmultiplikation, da die Daten in einem konsistenten Layout vorliegen.
    

**Effizienzvorteil:** Durch die genannten Eigenschaften sind NumPy-Arrays in der Regel **speichereffizienter** und **schneller** als äquivalente Python-Listen. Zum Beispiel benötigt eine Python-Liste mit 1000 Zahlen in einem Test etwa 48.000 Bytes Speicher, während ein NumPy-Array mit 1000 Zahlen nur ca. 8.000 Bytes belegt[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Size%20of%20each%20element%20of,array%20in%20bytes%3A%20%208000). Ebenso ist die zeitliche Performance beeindruckend: die elementweise Multiplikation von je einer Million Elemente in zwei Arrays erfolgt mit NumPy rund **10-50x schneller** als mit Python-Listen in einer Schleife[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Output%3A). Kurz gesagt, NumPy tauscht etwas Flexibilität (heterogene Elemente, dynamische Größe) gegen massive Vorteile in Geschwindigkeit und Speicherverbrauch bei numerischen Daten.

 

_Abbildung 1: Schematische Darstellung einer Python-Liste im Speicher._ Eine Python-Liste speichert Referenzen (Zeiger) auf Python-Objekte, die irgendwo im Speicher liegen (angedeutet durch Pfeile). Dadurch liegen die eigentlichen Werte nicht notwendigerweise an zusammenhängenden Adressen, was zu Fragmentierung führen kann. Für jedes Element muss außerdem Metadaten (wie Typinformation und Referenzzählung) verwaltet werden[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,due%20to%20Python%27s%20interpretation%20overhead). Diese Flexibilität der Liste ist praktisch, hat aber Performance-Nachteile bei großen Datenmengen.

 

_Abbildung 2: Schematische Darstellung eines NumPy-Arrays im Speicher._ NumPy-Arrays speichern alle Elemente dicht aneinander in einem **kontiguierlichen Speicherblock**. Zusätzlich hält das Array einmalig Informationen über den Datentyp, die Abmessungen (Shape) und die Schrittweite (Strides) vor. Dieses kompakte, homogene Layout führt zu **geringerem Speicherbedarf** und **schnellerem Zugriff** auf die Daten[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,than%20equivalent%20operations%20on%20lists). Numerische Operationen können so in low-level Code auf dem ganzen Datenblock ausgeführt werden, ohne die Python-Objektverwaltung für jedes Element, was die große Geschwindigkeitssteigerung erklärt.

## Erzeugen von NumPy-Arrays

Bevor wir mit NumPy arbeiten können, muss die Bibliothek importiert werden (üblich ist `import numpy as np`). Ein NumPy-Array lässt sich auf verschiedene Arten erzeugen. Am einfachsten ist es, eine Python-Liste oder -Tupel in ein Array umzuwandeln:

`import numpy as np  # Array aus einer Python-Liste erzeugen daten = [1, 2, 3, 4] arr = np.array(daten) print(arr)        # Ausgabe: [1 2 3 4] print(type(arr))  # Ausgabe: <class 'numpy.ndarray'>`

Hier haben wir eine Liste `daten` mit vier Zahlen und mittels `np.array(...)` in ein NumPy-Array `arr` umgewandelt[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Die%20array%28%29,arrays%20um). Das Ergebnis `arr` ist vom Typ `numpy.ndarray`. NumPy zeigt bei der Ausgabe eines Arrays dessen Inhalt in eckigen Klammern an (`[1 2 3 4]`). Anders als Python-Listen ist dies jedoch kein eigenes Syntaxkonstrukt, sondern nur die Darstellungsform – der Typ von `arr` ist eindeutig ein NumPy-Array, wie der `type`-Aufruf bestätigt.

 

Neben der Umwandlung bestehender Sequenzen bietet NumPy viele Funktionen, um Arrays direkt zu erstellen. Häufig genutzte sind zum Beispiel:

- **`np.zeros(shape)`** – erzeugt ein Array gegebener Form (_shape_) und füllt es mit `0.0`[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Besides%20creating%20an%20array%20from,%E2%80%99s).
    
- **`np.ones(shape)`** – erzeugt ein Array gleicher Größe, gefüllt mit `1.0`[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=).
    
- **`np.full(shape, value)`** – erzeugt ein Array der gewünschten Form und füllt es mit einem angegebenen Wert.
    
- **`np.arange(start, stop, step)`** – ähnlich wie Pythons `range()`, erzeugt eine Folge von Zahlen als Array[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=numpy%20hat%20seine%20eigene%20range,Array%20erzeugt). Sehr nützlich, um schnell Testarrays zu bekommen.
    
- **`np.linspace(start, stop, num)`** – erzeugt `num` gleichmäßig verteilte Werte zwischen `start` und `stop` (inklusive), als Array.
    

Beispielsweise können wir ein Array mit 5 Elementen initialisieren, die alle den Wert 1.0 haben, und ein Array mit einer Zahlenfolge:

`a = np.ones(5) b = np.arange(0, 10, 2) print("Array a:", a)   # Array a: [1. 1. 1. 1. 1.] print("Array b:", b)   # Array b: [0 2 4 6 8]`

In diesem Beispiel ist `a = np.ones(5)` ein Array der Länge 5 mit lauter Einsen (`[1. 1. 1. 1. 1.]`), und `b = np.arange(0, 10, 2)` ergibt ein Array mit Start 0, Schrittweite 2, bis unter 10 (`[0 2 4 6 8]`). Man beachte, dass `np.ones` standardmäßig Gleitkommazahlen (`1.0`) erzeugt – der Datentyp lässt sich aber über das Argument `dtype` ändern, falls nötig.

 

Für mehrdimensionale Arrays kann man geschachtelte Listen verwenden oder eindimensionale Arrays nachträglich in die gewünschte Form **umformen**. Die Methode `reshape` des Array-Objekts (oder Funktion `np.reshape`) ermöglicht es, die _Shape_ eines Arrays anzupassen, solange die Gesamtzahl der Elemente gleich bleibt[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Die%20%60.reshape%28%29%60,wird%20eine%20Matrix%20zeilenweise%20gef%C3%BCllt). Beispielsweise:

`# 1D-Array mit 12 Elementen von 1 bis 12 c = np.arange(1, 13) print(c)        # [ 1  2  3  4  5  6  7  8  9 10 11 12]  # Umformen in ein 3x4-Array (2D) C = c.reshape(3, 4) print("3x4-Array:\n", C)`

Ausgabe:

`[ 1  2  3  4  5  6  7  8  9 10 11 12] 3x4-Array:  [[ 1  2  3  4]   [ 5  6  7  8]   [ 9 10 11 12]]`

Hier wurde das eindimensionale Array `c` mit 12 Einträgen in ein zweidimensionales Array `C` der Gestalt 3×4 umgewandelt. NumPy füllt die Matrix dabei zeilenweise mit den Werten 1 bis 12. Solche mehrdimensionalen Arrays können direkt als **Matrix** interpretiert werden. Die _Shape_ eines Arrays (also das Form-Tupel der Dimensionen) kann man über die Eigenschaft `arr.shape` abfragen[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=print%28a,Typ%20von%20a%20selbst). So hätte `C.shape` den Wert `(3, 4)`, was 3 Zeilen und 4 Spalten entspricht. Weitere nützliche Attribute sind `ndim` (Anzahl Dimensionen), `size` (Gesamtzahl Elemente) und `dtype` (Datentyp der Elemente)[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=The%20number%20of%20dimensions%20of,attribute)[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Arrays%20are%20typically%20%E2%80%9Chomogeneous%E2%80%9D%2C%20meaning,attribute).

## Indexierung und Slicing

Die Indexierung von NumPy-Arrays funktioniert ähnlich wie bei Python-Listen. Die Elemente eines eindimensionalen Arrays werden durch einen Null-basierten Index in eckigen Klammern `[]` angesprochen: `arr[0]` gibt das erste Element, `arr[1]` das zweite, usw.[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Note). Arrays sind _mutable_, d. h. veränderbar – man kann also einem Index einen neuen Wert zuweisen, wie bei Listen.

 

Bei **mehrdimensionalen Arrays** können Elemente bequem mit **kommagetrennter Indizierung** ausgewählt werden. Statt wie bei verschachtelten Listen `matrix[zeile][spalte]` zu schreiben, kann man direkt `matrix[zeile, spalte]` verwenden[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Another%20difference%20between%20an%20array,3). Beispiel:

`M = np.array([[10, 20, 30],               [40, 50, 60]]) print(M.shape)      # Ausgabe: (2, 3) print(M[0, 1])      # Element in Zeile 0, Spalte 1 -> 20 M[0, 1] = 99        # Wert ändern print(M)            # Ausgabe: [[10 99 30]                    #           [40 50 60]]`

In diesem 2×3-Array `M` (zwei Zeilen, drei Spalten) liefert `M[0, 1]` den Wert in der ersten Zeile, zweiter Spalte (hier `20`). Durch Zuweisung `M[0, 1] = 99` haben wir dieses Element auf 99 geändert, was im Array sichtbar ist.

 

Auch **Slices** (Ausschnitte) funktionieren analog zu Listen: Mit `:` kann man Teilbereiche auswählen. Zum Beispiel gibt `M[0, :]` die gesamte Zeile 0 zurück, und `M[:, 1:]` gibt für alle Zeilen die Spalten ab Index 1 bis Ende zurück:

`erste_zeile = M[0, :] print(erste_zeile)   # [10 99 30]  spalten_ab2 = M[:, 1:] print(spalten_ab2)   # [[99 30]                     #  [50 60]]`

Hier ist `erste_zeile` ein 1D-Array `[10 99 30]`, das der ersten Zeile von `M` entspricht. `spalten_ab2` enthält ein 2×2-Array, nämlich die Spalten 1 und 2 aus jeder Zeile von `M`. Beachte: Bei NumPy liefert ein Slicing nicht etwa eine Kopie der Daten, sondern **standardmäßig nur eine _View_** auf die selben Daten[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=One%20major%20difference%20is%20that,be%20mutated%20using%20the%20view). Das heißt, Änderungen in einem Slice wirken sich auf das ursprüngliche Array aus. (Bei Python-Listen ist das anders – `liste_a[1:3]` erzeugt eine neue Liste-Kopie.) Sollte man eine echte Kopie eines Array-Ausschnitts benötigen, kann man z. B. die `copy()`-Methode verwenden.

## Arithmetische Operationen auf Arrays

Eine der größten Stärken von NumPy ist die Möglichkeit, **elementweise Operationen** auf Arrays durchzuführen, ohne explizite Schleifen schreiben zu müssen. Wenn man zwei Arrays gleicher Form mit Operatoren verknüpft, wendet NumPy die Operation auf jedes Wertepaar an (dies nennt man _Vektorisierung_). Zum Beispiel:

`x = np.array([1, 2, 3]) y = np.array([10, 20, 30])  print(x + y)     # [11 22 33]  (Elementweises Summieren) print(x * y)     # [10 40 90]  (Elementweises Multiplizieren) print(x - 5)     # [-4 -3 -2]  (Subtraktion eines Skalars von jedem Element) print(2 * x)     # [2 4 6]     (Multiplikation: jedes Element mit 2)`

Hier werden `x` und `y` **positionsweise addiert** bzw. multipliziert; außerdem wird gezeigt, dass man auch Skalarwerte mit Arrays verrechnen kann. In `x - 5` wird von jedem Element des Arrays 5 subtrahiert, und `2 * x` verdoppelt jedes Element. Diese _Broadcasting_-Fähigkeit (Skalare oder kleinere Arrays werden auf die Größe des größeren Arrays ausgedehnt) macht das Rechnen sehr intuitiv[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,mit%20diesem%20Skalar%20gef%C3%BCllt%20ist). Wichtig: Die arithmetischen Operatoren `+`, `-`, `*`, `/` beziehen sich bei NumPy **nicht** auf lineare Algebra, sondern wirklich auf elementweises Rechnen[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,mit%20diesem%20Skalar%20gef%C3%BCllt%20ist). Insbesondere ist `A * B` (für Arrays `A` und `B`) **nicht** die Matrixmultiplikation, sondern multipliziert nur Element für Element. Für Matrixmultiplikation bietet NumPy entweder die Funktion `np.matmul(A, B)` oder den Operator `A @ B` (seit Python 3.5)[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Produkte%C2%B6).

 

Zum Vergleich sei erwähnt, dass solche direkten Array-Operationen mit Python-Listen nicht möglich sind. Versucht man z. B. `[1,2,3] + 3` in Python, erhält man einen Typfehler, da Listen die Addition mit einem Skalar nicht kennen[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=). Auch `[1,2,3] * [10,20,30]` würde nicht elementweise multiplizieren, sondern einen Fehler werfen. Mit Listen müsste man für solche Berechnungen eine Schleife oder List-Comprehension schreiben, z. B. `result = [a+b for a,b in zip(list1, list2)]`. NumPy übernimmt diesen „Boilerplate“-Code für uns und erledigt die Operation intern optimiert.

 

Neben den Grundrechenarten stellt NumPy wie erwähnt viele mathematische Funktionen bereit. Beispielsweise können wir den **Elementarbruch** (Kehrwert) eines jeden Array-Elements berechnen oder trigonometrische Funktionen anwenden:

`a = np.array([1, 2, 4, 10]) print(1 / a)         # [1.         0.5        0.25       0.1       ] print(np.log10(a))   # [0.         0.30103    0.60206    1.        ]`

Im ersten Fall ergibt `1 / a` ein Array mit den Kehrwerten von `a` (hier `1, 1/2, 1/4, 1/10`); im zweiten Fall wird `np.log10(a)` angewendet, was den Zehnerlogarithmus jedes Elements berechnet[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=In%C2%A0). NumPy-Funktionen wie `log10` sind _elementweise_ definiert, d. h. sie führen die Berechnung für jedes Element aus und liefern wieder ein Array zurück. Dies gilt für die meisten mathematischen Funktionen (`sin`, `cos`, `exp`, etc.).

 

Schließlich bietet NumPy auch umfangreiche **Statistik- und Aggregations-Methoden** direkt auf Arrays. So kann man z. B. `arr.sum()` oder `np.sum(arr)` verwenden, um die Summe aller Elemente zu erhalten, `arr.mean()` für den Durchschnitt, `arr.min()/arr.max()` für Minimum und Maximum, usw. Für mehrdimensionale Arrays kann mittels des Parameters `axis` angegeben werden, entlang welcher Achse aggregiert werden soll (etwa `np.sum(M, axis=0)` für Spaltensummen oder `axis=1` für Zeilensummen)[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,Beispiele%3A%20sum%2C%20prod%2C%20amin%2C%20amax)[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,amax%28A%2C%20axis%3D0%29). Diese Funktionen nutzen intern ebenfalls optimierte C-Routinen.

 

**Hinweis:** Für lineare Algebra (z. B. Matrix-Vektor- oder Matrix-Matrix-Multiplikation, Lösen von Gleichungssystemen, Inversionen usw.) stellt NumPy das Untermodul `numpy.linalg` bereit, das Funktionen wie `np.matmul` (bzw. den Operator `@`), `np.dot`, `np.inv` (Matrixinvertierung) u.v.m. enthält[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Produkte%C2%B6)[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Eigenwerte%2C%20Matrixinverses%2C%20L%C3%B6sen%20linearer%20Gleichungssyteme,und%20vieles%20mehr). In einfachen Fällen – wie bereits erwähnt – kann man den `@`-Operator auf NumPy-Arrays verwenden, um Matrixmultiplikation durchzuführen. Beispiel:

`A = np.array([[1, 2, 3],               [4, 5, 6]]) v = np.array([10, 20, 30]) print(A @ v)   # Ausgabe: [140 320]`

Hier multiplizieren wir eine 2×3-Matrix `A` mit einem 3-Elemente-Vektor `v` und erhalten den Ergebnisvektor `[140 320]`. Intern sorgt NumPy dafür, dass diese Rechnung effizient ausgeführt wird (ähnlich dem mathematischen Matrix-Vektor-Produkt). Damit zeigt sich, dass NumPy-Arrays nicht nur für einfache elementweise Operationen, sondern auch für komplexere Anwendungen in Algebra und Wissenschaft sehr nützlich sind.

## Fazit

NumPy ist ein essenzielles Werkzeug für alle, die in Python mit numerischen Daten arbeiten. Zusammengefasst bietet die Bibliothek:

- **Leistungsfähigkeit:** Durch die Nutzung homogener Arrays und internem C-Code können auch große Datenmengen schnell verarbeitet werden (hohe Rechengeschwindigkeit und geringer Speicherverbrauch)[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Size%20of%20each%20element%20of,array%20in%20bytes%3A%20%208000)[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Output%3A).
    
- **Funktionalität:** NumPy stellt ein reichhaltiges Repertoire an Funktionen für mathematische, logische und statistische Operationen bereit, die auf Arrays arbeiten, sowie Möglichkeiten für lineare Algebra und vieles mehr.
    
- **Benutzerfreundlichkeit:** Die Syntax bleibt dabei relativ einfach und _pythonic_ – viele Operationen lassen sich in wenigen Codezeilen ausdrücken, ohne explizite Schleifen, was den Code prägnant und gut lesbar macht[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,in%20sequences).
    

Gerade für Einsteiger lohnt es sich, das **zentrale Konzept der NumPy-Arrays** zu verstehen, da dieses in nahezu allen wissenschaftlichen Python-Libraries zum Einsatz kommt[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,how%20to%20use%20NumPy%20arrays). Mit NumPy lassen sich Programme schreiben, die nicht nur kürzer, sondern vor allem **schneller** und **skalierbarer** sind, wenn es um numerische Daten geht. So bildet NumPy die Grundlage für effizientes Data Science und numerische Simulationen in Python. Viel Spaß beim Ausprobieren der vorgestellten Beispiele und beim weiteren Erkunden der vielseitigen Möglichkeiten, die NumPy bietet![numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,in%20sequences)[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Advantages%20of%20using%20Numpy%20Arrays,Over%20Python%20Lists)

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

Quellen

ChatGPT kann Fehler machen. Überprüfe wichtige Informationen. Siehe Cookie-Voreinstellungen.

# Einführung in NumPy für Einsteiger

## Was ist NumPy?

NumPy (kurz für _Numerical Python_) ist eine Open-Source-Python-Bibliothek für effizientes numerisches Rechnen[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=NumPy%20,Learn). Sie wird in Wissenschaft und Technik weit verbreitet eingesetzt und bietet leistungsfähige Werkzeuge zur Verarbeitung und Analyse großer Datenmengen. Der Hauptbestandteil von NumPy ist ein mehrdimensionaler Array-Datentyp (`ndarray`), der zusammen mit einer Vielzahl von Routinen geliefert wird, um schnelle mathematische und logische Operationen auf diesen Arrays auszuführen[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=NumPy%20is%20the%20fundamental%20package,including%20mathematical%2C%20logical%2C%20shape%20manipulation). Typische Funktionen umfassen etwa mathematische Berechnungen, Statistik, Lineare Algebra, Zufallszahlen und vieles mehr, was NumPy zum _fundamentalen Paket für wissenschaftliches Rechnen in Python_ macht[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=NumPy%20is%20the%20fundamental%20package,including%20mathematical%2C%20logical%2C%20shape%20manipulation).

## NumPy-Arrays (`ndarray`) als Kernstück

Im Zentrum von NumPy steht das `ndarray`-Objekt, das N-dimensionalen Arrays homogener Datentypen entspricht[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=At%20the%20core%20of%20the,and%20the%20standard%20Python%20sequences). Ein NumPy-Array kann man sich als Gitter (ähnlich einer Liste oder Tabelle) vorstellen, in dem jedes Feld einen Wert gleichen Typs enthält. Dieses Array kann ein- oder mehrdimensional sein – von 1D-Vektoren über 2D-Matrizen bis hin zu höherdimensionalen „Tensoren“. Viele Operationen auf diesen Arrays sind in vor-kompiliertem C-Code implementiert, was eine sehr hohe Geschwindigkeit ermöglicht[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=At%20the%20core%20of%20the,and%20the%20standard%20Python%20sequences). Praktisch alle wissenschaftlichen Python-Bibliotheken (z. B. Pandas für Datenanalyse oder SciPy für weiterführende numerische Methoden) bauen auf NumPy-Arrays auf und nutzen deren Leistungsfähigkeit[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,how%20to%20use%20NumPy%20arrays).

 

Ein NumPy-Array ist **homogen**, d. h. alle Elemente haben den gleichen Datentyp (z. B. nur Zahlen, nur Integer oder nur Gleitkommazahlen)[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,arrays%20of%20different%20sized%20elements). Außerdem hat ein Array eine **feste Größe** – einmal erstellt, ändert sich die Anzahl der Elemente nicht ohne Weiteres[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,array%20and%20delete%20the%20original). NumPy-Arrays können zwar in beliebig vielen Dimensionen organisiert sein, aber ihre Form ist immer **rechtwinklig**: zum Beispiel müssen in einem 2D-Array alle Zeilen gleich viele Spalten haben[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=,the%20same%20number%20of%20columns). Diese Eigenschaften ermöglichen es NumPy, sehr effiziente Speicher- und Rechenverfahren zu nutzen[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=When%20these%20conditions%20are%20met%2C,than%20less%20restrictive%20data%20structures)[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Most%20NumPy%20arrays%20have%20some,For%20instance). Im nächsten Abschnitt betrachten wir diese Unterschiede genauer.

## Unterschiede zwischen NumPy-Arrays und Python-Listen

Obwohl NumPy-Arrays auf den ersten Blick ähnlich wie Python-Listen verwendet werden können, gibt es wichtige Unterschiede in Struktur und Verhalten[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=At%20the%20core%20of%20the,and%20the%20standard%20Python%20sequences). Insbesondere wurde NumPy entwickelt, um große Mengen numerischer Daten effizient zu verarbeiten. Im Folgenden die Hauptunterschiede zwischen einem NumPy-Array (`numpy.ndarray`) und einer nativen Python-Liste:

- **Homogener Datentyp:** In einem NumPy-Array müssen alle Elemente vom selben Typ sein (etwa alle `int64` oder alle `float`). Dies macht Arrays kompakter und speichereffizienter als Listen, die verschiedene Datentypen enthalten können[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,type%20information%20for%20each%20element). Eine Python-Liste kann heterogene Typen speichern, was zwar flexibel ist, aber zu höherem Speicherverbrauch und potenziell langsameren numerischen Operationen führt[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,due%20to%20Python%27s%20interpretation%20overhead).
    
- **Feste Größe:** NumPy-Arrays haben eine feste Größe bei der Erstellung. Man kann die Größe nachträglich nicht einfach verändern – stattdessen müsste ein neues Array mit der gewünschten Größe erzeugt werden[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,array%20and%20delete%20the%20original). Python-Listen dagegen können dynamisch wachsen oder schrumpfen (z. B. mit `append()` oder `pop()`), was jedoch mit Performance-Kosten verbunden ist.
    
- **Speicherlayout (kontiguierlicher Speicher):** Die Elemente eines NumPy-Arrays liegen zusammenhängend im Speicher, in einem einzigen Block[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,element). Dadurch wird **Fragmentierung** vermieden und der Zugriff auf die Elemente ist sehr effizient. Eine Python-Liste speichert hingegen Referenzen auf Python-Objekte, die irgendwo im Speicher liegen; die Listenelemente müssen nicht nebeneinander liegen, was zu Speicherfragmentierung und Ineffizienz führen kann[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,due%20to%20Python%27s%20interpretation%20overhead). Zudem muss für jedes Listenelement Verwaltungs-Overhead (Typinformation, Referenzzähler etc.) gespeichert werden[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,due%20to%20Python%27s%20interpretation%20overhead), während NumPy bei Arrays den Datentyp nur einmal für alle Elemente vorhält.
    
- **Leistung und vektorisiertes Rechnen:** NumPy ist auf Geschwindigkeit optimiert und deutlich schneller als reine Python-Listen bei numerischen Berechnungen[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,Arrays%20und%20werden%20elementweise%20interpretiert). Viele Array-Operationen sind in C implementiert und laufen _vektorisiert_, d. h. ohne explizite Python-Schleifen über die Elemente[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=NumPy%20gives%20us%20the%20best,compiled%20C%20code.%20In%20NumPy)[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=overhead%20in%20lists,than%20equivalent%20operations%20on%20lists). Python-Listen führen vergleichbare Operationen Element-für-Element in Python aus, was aufgrund des Interpreters deutlich langsamer ist[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,due%20to%20Python%27s%20interpretation%20overhead). In NumPy kann man z. B. zwei Arrays einfach mit `c = a * b` multiplizieren, und NumPy führt dies intern in optimiertem Maschinencode aus (ähnlich schnell wie eine C-Schleife)[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=NumPy%20gives%20us%20the%20best,compiled%20C%20code.%20In%20NumPy) – wohingegen man bei normalen Listen entweder eine Python-Schleife oder Listen-Komprehension bräuchte, was wesentlich mehr Zeit und Code erfordert.
    
- **Funktionsumfang für numerische Operationen:** NumPy stellt zahlreiche Funktionen und mathematische Operationen zur Verfügung, die auf Arrays als Ganzes wirken. Zum Beispiel können arithmetische Operatoren (`+`, `-`, `*`, `/` usw.) direkt auf Arrays angewendet werden und werden automatisch **elementweise** ausgeführt[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,mit%20diesem%20Skalar%20gef%C3%BCllt%20ist). Ebenso gibt es vordefinierte Funktionen wie `np.sqrt`, `np.log`, `np.sin` usw., die auf jedes Element eines Arrays angewendet werden können, ohne dass man explizit über die Elemente iterieren muss[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,log10%28a). Solche _vektorisierten_ Funktionen (auch _universelle Funktionen_ genannt) fehlen für Python-Listen – dort müsste man Schleifen schreiben oder auf Listen-Komprehension zurückgreifen, um ähnliche Berechnungen durchzuführen[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=have%20slower%20mathematical%20operations%20due,NumPy%20functions%20for%20numerical%20operations). Zusätzlich bietet NumPy so genannte **Reduktionsfunktionen** wie z. B. `np.sum` (Summe aller Elemente), `np.mean` (arithmetisches Mittel), `np.min`/`np.max` (Minimum/Maximum) u.v.m., die effiziente Berechnungen über ein Array oder entlang einer Achse des Arrays ermöglichen[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Reduktionsfunktionen%C2%B6). Solche Aggregationen sind mit Listen nur umständlich oder mit Hilfe von Funktionen wie `sum(list)` möglich, aber nicht so spezialisiert optimiert.
    
- **Mehrdimensionale Strukturen:** Ein weiterer Unterschied ist die native Unterstützung mehrdimensionaler Arrays. Während man in Python mit verschachtelten Listen ebenfalls so etwas wie Matrizen darstellen kann, fehlt Listen die stringente, rechteckige Struktur – z. B. könnten Listen von Listen „unregelmäßig“ sein (verschiedene Unterlisten unterschiedlicher Länge). NumPy-Arrays hingegen können echte Matrizen und höherdimensionale Datensätze darstellen, wobei alle Zeilen/Spalten konsistente Längen haben müssen[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=,the%20same%20number%20of%20columns). Diese strikte rechteckige Form erleichtert mathematische Operationen wie Matrixmultiplikation, da die Daten in einem konsistenten Layout vorliegen.
    

**Effizienzvorteil:** Durch die genannten Eigenschaften sind NumPy-Arrays in der Regel **speichereffizienter** und **schneller** als äquivalente Python-Listen. Zum Beispiel benötigt eine Python-Liste mit 1000 Zahlen in einem Test etwa 48.000 Bytes Speicher, während ein NumPy-Array mit 1000 Zahlen nur ca. 8.000 Bytes belegt[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Size%20of%20each%20element%20of,array%20in%20bytes%3A%20%208000). Ebenso ist die zeitliche Performance beeindruckend: die elementweise Multiplikation von je einer Million Elemente in zwei Arrays erfolgt mit NumPy rund **10-50x schneller** als mit Python-Listen in einer Schleife[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Output%3A). Kurz gesagt, NumPy tauscht etwas Flexibilität (heterogene Elemente, dynamische Größe) gegen massive Vorteile in Geschwindigkeit und Speicherverbrauch bei numerischen Daten.

 

_Abbildung 1: Schematische Darstellung einer Python-Liste im Speicher._ Eine Python-Liste speichert Referenzen (Zeiger) auf Python-Objekte, die irgendwo im Speicher liegen (angedeutet durch Pfeile). Dadurch liegen die eigentlichen Werte nicht notwendigerweise an zusammenhängenden Adressen, was zu Fragmentierung führen kann. Für jedes Element muss außerdem Metadaten (wie Typinformation und Referenzzählung) verwaltet werden[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,due%20to%20Python%27s%20interpretation%20overhead). Diese Flexibilität der Liste ist praktisch, hat aber Performance-Nachteile bei großen Datenmengen.

 

_Abbildung 2: Schematische Darstellung eines NumPy-Arrays im Speicher._ NumPy-Arrays speichern alle Elemente dicht aneinander in einem **kontiguierlichen Speicherblock**. Zusätzlich hält das Array einmalig Informationen über den Datentyp, die Abmessungen (Shape) und die Schrittweite (Strides) vor. Dieses kompakte, homogene Layout führt zu **geringerem Speicherbedarf** und **schnellerem Zugriff** auf die Daten[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,than%20equivalent%20operations%20on%20lists). Numerische Operationen können so in low-level Code auf dem ganzen Datenblock ausgeführt werden, ohne die Python-Objektverwaltung für jedes Element, was die große Geschwindigkeitssteigerung erklärt.

## Erzeugen von NumPy-Arrays

Bevor wir mit NumPy arbeiten können, muss die Bibliothek importiert werden (üblich ist `import numpy as np`). Ein NumPy-Array lässt sich auf verschiedene Arten erzeugen. Am einfachsten ist es, eine Python-Liste oder -Tupel in ein Array umzuwandeln:

`import numpy as np  # Array aus einer Python-Liste erzeugen daten = [1, 2, 3, 4] arr = np.array(daten) print(arr)        # Ausgabe: [1 2 3 4] print(type(arr))  # Ausgabe: <class 'numpy.ndarray'>`

Hier haben wir eine Liste `daten` mit vier Zahlen und mittels `np.array(...)` in ein NumPy-Array `arr` umgewandelt[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Die%20array%28%29,arrays%20um). Das Ergebnis `arr` ist vom Typ `numpy.ndarray`. NumPy zeigt bei der Ausgabe eines Arrays dessen Inhalt in eckigen Klammern an (`[1 2 3 4]`). Anders als Python-Listen ist dies jedoch kein eigenes Syntaxkonstrukt, sondern nur die Darstellungsform – der Typ von `arr` ist eindeutig ein NumPy-Array, wie der `type`-Aufruf bestätigt.

 

Neben der Umwandlung bestehender Sequenzen bietet NumPy viele Funktionen, um Arrays direkt zu erstellen. Häufig genutzte sind zum Beispiel:

- **`np.zeros(shape)`** – erzeugt ein Array gegebener Form (_shape_) und füllt es mit `0.0`[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Besides%20creating%20an%20array%20from,%E2%80%99s).
    
- **`np.ones(shape)`** – erzeugt ein Array gleicher Größe, gefüllt mit `1.0`[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=).
    
- **`np.full(shape, value)`** – erzeugt ein Array der gewünschten Form und füllt es mit einem angegebenen Wert.
    
- **`np.arange(start, stop, step)`** – ähnlich wie Pythons `range()`, erzeugt eine Folge von Zahlen als Array[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=numpy%20hat%20seine%20eigene%20range,Array%20erzeugt). Sehr nützlich, um schnell Testarrays zu bekommen.
    
- **`np.linspace(start, stop, num)`** – erzeugt `num` gleichmäßig verteilte Werte zwischen `start` und `stop` (inklusive), als Array.
    

Beispielsweise können wir ein Array mit 5 Elementen initialisieren, die alle den Wert 1.0 haben, und ein Array mit einer Zahlenfolge:

`a = np.ones(5) b = np.arange(0, 10, 2) print("Array a:", a)   # Array a: [1. 1. 1. 1. 1.] print("Array b:", b)   # Array b: [0 2 4 6 8]`

In diesem Beispiel ist `a = np.ones(5)` ein Array der Länge 5 mit lauter Einsen (`[1. 1. 1. 1. 1.]`), und `b = np.arange(0, 10, 2)` ergibt ein Array mit Start 0, Schrittweite 2, bis unter 10 (`[0 2 4 6 8]`). Man beachte, dass `np.ones` standardmäßig Gleitkommazahlen (`1.0`) erzeugt – der Datentyp lässt sich aber über das Argument `dtype` ändern, falls nötig.

 

Für mehrdimensionale Arrays kann man geschachtelte Listen verwenden oder eindimensionale Arrays nachträglich in die gewünschte Form **umformen**. Die Methode `reshape` des Array-Objekts (oder Funktion `np.reshape`) ermöglicht es, die _Shape_ eines Arrays anzupassen, solange die Gesamtzahl der Elemente gleich bleibt[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Die%20%60.reshape%28%29%60,wird%20eine%20Matrix%20zeilenweise%20gef%C3%BCllt). Beispielsweise:

`# 1D-Array mit 12 Elementen von 1 bis 12 c = np.arange(1, 13) print(c)        # [ 1  2  3  4  5  6  7  8  9 10 11 12]  # Umformen in ein 3x4-Array (2D) C = c.reshape(3, 4) print("3x4-Array:\n", C)`

Ausgabe:

`[ 1  2  3  4  5  6  7  8  9 10 11 12] 3x4-Array:  [[ 1  2  3  4]   [ 5  6  7  8]   [ 9 10 11 12]]`

Hier wurde das eindimensionale Array `c` mit 12 Einträgen in ein zweidimensionales Array `C` der Gestalt 3×4 umgewandelt. NumPy füllt die Matrix dabei zeilenweise mit den Werten 1 bis 12. Solche mehrdimensionalen Arrays können direkt als **Matrix** interpretiert werden. Die _Shape_ eines Arrays (also das Form-Tupel der Dimensionen) kann man über die Eigenschaft `arr.shape` abfragen[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=print%28a,Typ%20von%20a%20selbst). So hätte `C.shape` den Wert `(3, 4)`, was 3 Zeilen und 4 Spalten entspricht. Weitere nützliche Attribute sind `ndim` (Anzahl Dimensionen), `size` (Gesamtzahl Elemente) und `dtype` (Datentyp der Elemente)[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=The%20number%20of%20dimensions%20of,attribute)[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Arrays%20are%20typically%20%E2%80%9Chomogeneous%E2%80%9D%2C%20meaning,attribute).

## Indexierung und Slicing

Die Indexierung von NumPy-Arrays funktioniert ähnlich wie bei Python-Listen. Die Elemente eines eindimensionalen Arrays werden durch einen Null-basierten Index in eckigen Klammern `[]` angesprochen: `arr[0]` gibt das erste Element, `arr[1]` das zweite, usw.[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Note). Arrays sind _mutable_, d. h. veränderbar – man kann also einem Index einen neuen Wert zuweisen, wie bei Listen.

 

Bei **mehrdimensionalen Arrays** können Elemente bequem mit **kommagetrennter Indizierung** ausgewählt werden. Statt wie bei verschachtelten Listen `matrix[zeile][spalte]` zu schreiben, kann man direkt `matrix[zeile, spalte]` verwenden[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Another%20difference%20between%20an%20array,3). Beispiel:

`M = np.array([[10, 20, 30],               [40, 50, 60]]) print(M.shape)      # Ausgabe: (2, 3) print(M[0, 1])      # Element in Zeile 0, Spalte 1 -> 20 M[0, 1] = 99        # Wert ändern print(M)            # Ausgabe: [[10 99 30]                    #           [40 50 60]]`

In diesem 2×3-Array `M` (zwei Zeilen, drei Spalten) liefert `M[0, 1]` den Wert in der ersten Zeile, zweiter Spalte (hier `20`). Durch Zuweisung `M[0, 1] = 99` haben wir dieses Element auf 99 geändert, was im Array sichtbar ist.

 

Auch **Slices** (Ausschnitte) funktionieren analog zu Listen: Mit `:` kann man Teilbereiche auswählen. Zum Beispiel gibt `M[0, :]` die gesamte Zeile 0 zurück, und `M[:, 1:]` gibt für alle Zeilen die Spalten ab Index 1 bis Ende zurück:

`erste_zeile = M[0, :] print(erste_zeile)   # [10 99 30]  spalten_ab2 = M[:, 1:] print(spalten_ab2)   # [[99 30]                     #  [50 60]]`

Hier ist `erste_zeile` ein 1D-Array `[10 99 30]`, das der ersten Zeile von `M` entspricht. `spalten_ab2` enthält ein 2×2-Array, nämlich die Spalten 1 und 2 aus jeder Zeile von `M`. Beachte: Bei NumPy liefert ein Slicing nicht etwa eine Kopie der Daten, sondern **standardmäßig nur eine _View_** auf die selben Daten[numpy.org](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=One%20major%20difference%20is%20that,be%20mutated%20using%20the%20view). Das heißt, Änderungen in einem Slice wirken sich auf das ursprüngliche Array aus. (Bei Python-Listen ist das anders – `liste_a[1:3]` erzeugt eine neue Liste-Kopie.) Sollte man eine echte Kopie eines Array-Ausschnitts benötigen, kann man z. B. die `copy()`-Methode verwenden.

## Arithmetische Operationen auf Arrays

Eine der größten Stärken von NumPy ist die Möglichkeit, **elementweise Operationen** auf Arrays durchzuführen, ohne explizite Schleifen schreiben zu müssen. Wenn man zwei Arrays gleicher Form mit Operatoren verknüpft, wendet NumPy die Operation auf jedes Wertepaar an (dies nennt man _Vektorisierung_). Zum Beispiel:

`x = np.array([1, 2, 3]) y = np.array([10, 20, 30])  print(x + y)     # [11 22 33]  (Elementweises Summieren) print(x * y)     # [10 40 90]  (Elementweises Multiplizieren) print(x - 5)     # [-4 -3 -2]  (Subtraktion eines Skalars von jedem Element) print(2 * x)     # [2 4 6]     (Multiplikation: jedes Element mit 2)`

Hier werden `x` und `y` **positionsweise addiert** bzw. multipliziert; außerdem wird gezeigt, dass man auch Skalarwerte mit Arrays verrechnen kann. In `x - 5` wird von jedem Element des Arrays 5 subtrahiert, und `2 * x` verdoppelt jedes Element. Diese _Broadcasting_-Fähigkeit (Skalare oder kleinere Arrays werden auf die Größe des größeren Arrays ausgedehnt) macht das Rechnen sehr intuitiv[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,mit%20diesem%20Skalar%20gef%C3%BCllt%20ist). Wichtig: Die arithmetischen Operatoren `+`, `-`, `*`, `/` beziehen sich bei NumPy **nicht** auf lineare Algebra, sondern wirklich auf elementweises Rechnen[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,mit%20diesem%20Skalar%20gef%C3%BCllt%20ist). Insbesondere ist `A * B` (für Arrays `A` und `B`) **nicht** die Matrixmultiplikation, sondern multipliziert nur Element für Element. Für Matrixmultiplikation bietet NumPy entweder die Funktion `np.matmul(A, B)` oder den Operator `A @ B` (seit Python 3.5)[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Produkte%C2%B6).

 

Zum Vergleich sei erwähnt, dass solche direkten Array-Operationen mit Python-Listen nicht möglich sind. Versucht man z. B. `[1,2,3] + 3` in Python, erhält man einen Typfehler, da Listen die Addition mit einem Skalar nicht kennen[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=). Auch `[1,2,3] * [10,20,30]` würde nicht elementweise multiplizieren, sondern einen Fehler werfen. Mit Listen müsste man für solche Berechnungen eine Schleife oder List-Comprehension schreiben, z. B. `result = [a+b for a,b in zip(list1, list2)]`. NumPy übernimmt diesen „Boilerplate“-Code für uns und erledigt die Operation intern optimiert.

 

Neben den Grundrechenarten stellt NumPy wie erwähnt viele mathematische Funktionen bereit. Beispielsweise können wir den **Elementarbruch** (Kehrwert) eines jeden Array-Elements berechnen oder trigonometrische Funktionen anwenden:

`a = np.array([1, 2, 4, 10]) print(1 / a)         # [1.         0.5        0.25       0.1       ] print(np.log10(a))   # [0.         0.30103    0.60206    1.        ]`

Im ersten Fall ergibt `1 / a` ein Array mit den Kehrwerten von `a` (hier `1, 1/2, 1/4, 1/10`); im zweiten Fall wird `np.log10(a)` angewendet, was den Zehnerlogarithmus jedes Elements berechnet[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=In%C2%A0). NumPy-Funktionen wie `log10` sind _elementweise_ definiert, d. h. sie führen die Berechnung für jedes Element aus und liefern wieder ein Array zurück. Dies gilt für die meisten mathematischen Funktionen (`sin`, `cos`, `exp`, etc.).

 

Schließlich bietet NumPy auch umfangreiche **Statistik- und Aggregations-Methoden** direkt auf Arrays. So kann man z. B. `arr.sum()` oder `np.sum(arr)` verwenden, um die Summe aller Elemente zu erhalten, `arr.mean()` für den Durchschnitt, `arr.min()/arr.max()` für Minimum und Maximum, usw. Für mehrdimensionale Arrays kann mittels des Parameters `axis` angegeben werden, entlang welcher Achse aggregiert werden soll (etwa `np.sum(M, axis=0)` für Spaltensummen oder `axis=1` für Zeilensummen)[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,Beispiele%3A%20sum%2C%20prod%2C%20amin%2C%20amax)[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,amax%28A%2C%20axis%3D0%29). Diese Funktionen nutzen intern ebenfalls optimierte C-Routinen.

 

**Hinweis:** Für lineare Algebra (z. B. Matrix-Vektor- oder Matrix-Matrix-Multiplikation, Lösen von Gleichungssystemen, Inversionen usw.) stellt NumPy das Untermodul `numpy.linalg` bereit, das Funktionen wie `np.matmul` (bzw. den Operator `@`), `np.dot`, `np.inv` (Matrixinvertierung) u.v.m. enthält[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Produkte%C2%B6)[math.uni-leipzig.de](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Eigenwerte%2C%20Matrixinverses%2C%20L%C3%B6sen%20linearer%20Gleichungssyteme,und%20vieles%20mehr). In einfachen Fällen – wie bereits erwähnt – kann man den `@`-Operator auf NumPy-Arrays verwenden, um Matrixmultiplikation durchzuführen. Beispiel:

`A = np.array([[1, 2, 3],               [4, 5, 6]]) v = np.array([10, 20, 30]) print(A @ v)   # Ausgabe: [140 320]`

Hier multiplizieren wir eine 2×3-Matrix `A` mit einem 3-Elemente-Vektor `v` und erhalten den Ergebnisvektor `[140 320]`. Intern sorgt NumPy dafür, dass diese Rechnung effizient ausgeführt wird (ähnlich dem mathematischen Matrix-Vektor-Produkt). Damit zeigt sich, dass NumPy-Arrays nicht nur für einfache elementweise Operationen, sondern auch für komplexere Anwendungen in Algebra und Wissenschaft sehr nützlich sind.

## Fazit

NumPy ist ein essenzielles Werkzeug für alle, die in Python mit numerischen Daten arbeiten. Zusammengefasst bietet die Bibliothek:

- **Leistungsfähigkeit:** Durch die Nutzung homogener Arrays und internem C-Code können auch große Datenmengen schnell verarbeitet werden (hohe Rechengeschwindigkeit und geringer Speicherverbrauch)[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Size%20of%20each%20element%20of,array%20in%20bytes%3A%20%208000)[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Output%3A).
    
- **Funktionalität:** NumPy stellt ein reichhaltiges Repertoire an Funktionen für mathematische, logische und statistische Operationen bereit, die auf Arrays arbeiten, sowie Möglichkeiten für lineare Algebra und vieles mehr.
    
- **Benutzerfreundlichkeit:** Die Syntax bleibt dabei relativ einfach und _pythonic_ – viele Operationen lassen sich in wenigen Codezeilen ausdrücken, ohne explizite Schleifen, was den Code prägnant und gut lesbar macht[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,in%20sequences).
    

Gerade für Einsteiger lohnt es sich, das **zentrale Konzept der NumPy-Arrays** zu verstehen, da dieses in nahezu allen wissenschaftlichen Python-Libraries zum Einsatz kommt[numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,how%20to%20use%20NumPy%20arrays). Mit NumPy lassen sich Programme schreiben, die nicht nur kürzer, sondern vor allem **schneller** und **skalierbarer** sind, wenn es um numerische Daten geht. So bildet NumPy die Grundlage für effizientes Data Science und numerische Simulationen in Python. Viel Spaß beim Ausprobieren der vorgestellten Beispiele und beim weiteren Erkunden der vielseitigen Möglichkeiten, die NumPy bietet![numpy.org](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,in%20sequences)[geeksforgeeks.org](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Advantages%20of%20using%20Numpy%20Arrays,Over%20Python%20Lists)

Quellenangaben

[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=NumPy%20,Learn)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

What is NumPy? — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/whatisnumpy.html

](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=NumPy%20is%20the%20fundamental%20package,including%20mathematical%2C%20logical%2C%20shape%20manipulation)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

What is NumPy? — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/whatisnumpy.html

](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=At%20the%20core%20of%20the,and%20the%20standard%20Python%20sequences)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

What is NumPy? — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/whatisnumpy.html

](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,how%20to%20use%20NumPy%20arrays)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

What is NumPy? — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/whatisnumpy.html

](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,arrays%20of%20different%20sized%20elements)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

What is NumPy? — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/whatisnumpy.html

](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,array%20and%20delete%20the%20original)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=,the%20same%20number%20of%20columns)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=When%20these%20conditions%20are%20met%2C,than%20less%20restrictive%20data%20structures)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Most%20NumPy%20arrays%20have%20some,For%20instance)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

What is NumPy? — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/whatisnumpy.html

](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=At%20the%20core%20of%20the,and%20the%20standard%20Python%20sequences)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,type%20information%20for%20each%20element)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,due%20to%20Python%27s%20interpretation%20overhead)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,element)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,due%20to%20Python%27s%20interpretation%20overhead)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,Arrays%20und%20werden%20elementweise%20interpretiert)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

What is NumPy? — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/whatisnumpy.html

](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=NumPy%20gives%20us%20the%20best,compiled%20C%20code.%20In%20NumPy)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=overhead%20in%20lists,than%20equivalent%20operations%20on%20lists)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,due%20to%20Python%27s%20interpretation%20overhead)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,mit%20diesem%20Skalar%20gef%C3%BCllt%20ist)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,log10%28a)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=have%20slower%20mathematical%20operations%20due,NumPy%20functions%20for%20numerical%20operations)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Reduktionsfunktionen%C2%B6)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Size%20of%20each%20element%20of,array%20in%20bytes%3A%20%208000)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Output%3A)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=3,than%20equivalent%20operations%20on%20lists)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Die%20array%28%29,arrays%20um)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Besides%20creating%20an%20array%20from,%E2%80%99s)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=numpy%20hat%20seine%20eigene%20range,Array%20erzeugt)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Die%20%60.reshape%28%29%60,wird%20eine%20Matrix%20zeilenweise%20gef%C3%BCllt)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=print%28a,Typ%20von%20a%20selbst)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=The%20number%20of%20dimensions%20of,attribute)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Arrays%20are%20typically%20%E2%80%9Chomogeneous%E2%80%9D%2C%20meaning,attribute)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Note)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=Another%20difference%20between%20an%20array,3)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

NumPy: the absolute basics for beginners — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/absolute_beginners.html

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=One%20major%20difference%20is%20that,be%20mutated%20using%20the%20view)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,mit%20diesem%20Skalar%20gef%C3%BCllt%20ist)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Produkte%C2%B6)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=In%C2%A0)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,Beispiele%3A%20sum%2C%20prod%2C%20amin%2C%20amax)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,amax%28A%2C%20axis%3D0%29)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

numpy2

https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=Eigenwerte%2C%20Matrixinverses%2C%20L%C3%B6sen%20linearer%20Gleichungssyteme,und%20vieles%20mehr)[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

What is NumPy? — NumPy v2.4.dev0 Manual

https://numpy.org/devdocs/user/whatisnumpy.html

](https://numpy.org/devdocs/user/whatisnumpy.html#:~:text=,in%20sequences)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

Python Lists VS Numpy Arrays - GeeksforGeeks

https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=Advantages%20of%20using%20Numpy%20Arrays,Over%20Python%20Lists)

Alle Quellen

[

[Open: b83221f544e68d8f1456554cae0725bb_MD5.png](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)
![](_resources/b0e227911034ee55a014ecac8a2de2cf_MD5.jpg)

numpy

](https://numpy.org/devdocs/user/absolute_beginners.html#:~:text=NumPy%20,Learn)[

[Open: 163f9d8f38719ffe7ba715573006cbef_MD5.png](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)
![](_resources/2c28d8c3f515a182b16b4d075974c3c8_MD5.jpg)

geeksforgeeks

](https://www.geeksforgeeks.org/python/python-lists-vs-numpy-arrays/#:~:text=1,type%20information%20for%20each%20element)[

[Open: e031d0dbe3d889b237ef1e87ca3e3392_MD5.png](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)
![](_resources/7338dd5927ae32894e5491af78de7e4d_MD5.jpg)

math.uni-leipzig

](https://www.math.uni-leipzig.de/~hellmund/Vorlesung/numpy2.html#:~:text=,Arrays%20und%20werden%20elementweise%20interpretiert)