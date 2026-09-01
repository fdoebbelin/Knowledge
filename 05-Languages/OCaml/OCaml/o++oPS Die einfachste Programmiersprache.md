---
title: "o++o Systeme"
source: "https://ottops.de/einf%C3%BChrung.html"
author:
published:
created: 2025-03-13
description:
tags:
  - "clippings"
---
## 1 Sechs einführende Beispiele
### durchschnitt.otto: Berechne den Durchschnitt mehrerer Noten!

`  1 3 5 2 3 1 3 ++:  `

**Resultat**  

`   2.57142857143    `

### summe.otto: Berechne die Summe der ersten hundert natürlichen Zahlen (Aufgabe von Gauß)!

`  1 .. 100 ++  `

**Resultat**  

`   5050         `

### tabmentmultiplikation.otto: Berechne die Bruttowerte mehrerer Nettopreise!

`  77 79 567 432 +% 19  `

**Resultat**  

`    91.63    94.01   674.73   514.08    `

### zuweisungen.otto: Berechne den Gesamtwert jeder Position und die Gesamtsumme!

```
<TAB!
ARTIKEL,    PREIS,ANZ   m
OttoRAMDB   500         20
OttoWiki     10        200
OttoCalc     20       4000
!TAB>
TOTAL:=PREIS*ANZ
SUM:=TOTALl ++
```


**Resultat**  

```
SUM, (ARTIKEL,  PREIS,ANZ, TOTAL  m)
92000 o++oCalc    20    4000 80000
      o++oRAMDB  500      20 10000
	  o++oWiki    10     200  2000
```
### tabellenfor.otto: Vergleiche die Wertentwicklung eines Betrages von 100 Euro innerhalb eines Zeitraumes von 10 Jahren bei Zinsen von 1% und 9% !


```
JAHRl:= 2022 .. 2032
BETR1,BETR9:= 100.,100. tabfor preds +% (1,9) at JAHR
rnd 2
```


**Resultat**


```
JAHR,BETR1, BETR9  l
2022 100.00	100.00
2023 101.00	109.00
2024 102.01	118.81
2025 103.03	129.50
2026 104.06	141.16
2027 105.10	153.86
2028 106.15	167.71
2029 107.21	182.80
2030 108.29	199.26
2031 109.37	217.19
2032 110.46	236.74    
```

### bestimmtesintegral.otto: Bestimme die Fläche unter dem Polynom vierten Grades X<sup>4</sup> + X + 2 von -1 bis 1 näherungsweise!


```
-1 ...1!0.000'1 poly [1 0 0 1 2] *0.000'1 ++
```

**Resultat**  

`  4.40030000667                   `

## 3 Wer kann multiplizieren?

#### Begebenheit 1

In einer Mathematikprüfung eines Pharmaziestudenten aus Bologna nach dem zweiten Studienjahr mußte der Student unter anderem 7 mal 8 berechnen:  
Der Phamarziestudent: 59  
Der Algebraprofessor: Aber 59 ist doch gar keine gerade Zahl.  
Der Phamarziestudent: 64  

#### Lehre

Es gibt junge Intellektuelle, die das kleine Einmaleins nicht "beherrschen". Ist das ein Problem für die Gesellschaft?

#### Begebenheit 2

Etwa in der siebenten Klasse schrieben wir in der "Heinrich Heine" POS Hadmersleben eine Mathearbeit bei einem guten aber nicht so strengen Lehrer, Papa Senf. Ich konnte meine Arbeit vorzeitig abgeben. Aus langer Weile habe ich auf den Zettel meines Banknachbarn geguckt. Er errechnete 32 als Zwischenergebnis für die Aufgabe 8 mal 4. Ich dachte "Der ist aber deppern". Kurz nachdem ich mit dann mit dem Rechnen begonnen hatte, dachte ich, dass ich doch der Depp sei, da ich 24 herausbekommen hatte. Ich durfte meine Arbeit noch einmal beim Lehrer abholen und konnte die Aufgabe noch korrigieren.  

#### Lehre

Ich war zu diesem Zeitpunkt bereits bei der Mathekreisolympiade erfolgreich. Wie konnte das passieren? Wer hat Schuld? Die Antwort ist einfach. Ich hatte so viel Westfernsehen konsumiert, dass die Werbung "8 mal 4 24 Stunden frisch" meinem Kinderhirn arg zugesetzt hatte.  

#### Begebenheit 3

Wallerie - ein Erfurter Kindergartenmädchen der großen Gruppe - ist heute bereits Studentin.  
Ich stellte ihr eine Aufgabe: Wie viele Brauseflaschen enthält ein Kasten mit 4 Reihen, wenn in jeder Reihe 5 Flaschen stehen?  
Wallerie benötigte eine gewisse Zeit: 19  
Ihr Vater - ein junger Ingenieur: Du rechnest nicht, Du rätst.  

#### Begebenheit 4

Ich frage Isabella, eine Schülerin der 2-ten Klasse aus Gerwisch: Wie viel ist 3 mal 4?  
Nach einer Weile: 12  
Der Vater: Das hat aber gedauert.  

#### Meine Vermutung

Kein Mensch kann 7 mal 8 im Kopf rechnen.  
Ältere Erwachsene haben das Einmaleins so oft in der Schule rechnen müssen, dass sie es nur noch auswendig können und nicht mehr wissen wie sie früher als Kind multipliziert haben.  
Die ursprünglichen Neuronenverbindungen wurden in den vielen Schuljahren "überschrieben" und sind nicht mehr vorhanden.  
  
7 mal 8 mit dem Stift rechnen, dürfte jedes Kind der zweiten Klasse beherrschen.  
7 Reihen mit jeweils 8 Strichen leserlich untereinander schreiben und dann alle Striche durchzählen oder - wenn man im Kopf addieren kann - jeweils 8 hinzufügen.  
  
Wenn man den Kindern jetzt noch die dezimale Zahlenrepräsentation mit der Bedeutung der Null (Multiplikation mit 10, ...) vermittelt,  
könnte man das als Multiplikation ansehen.  

#### These

Die schriftliche Dezimalzahlmultiplikation hat ihre Bedeutung verloren, da Computer viel schneller und zuverlässiger sind und auch fast immer zur Verfügung stehen.  
Wenn man "nur" noch das kleine Einmaleins mit der schriftlichen Dezimalzahlmultiplikation beherrscht,  
ist meiner Meinung nach nicht einmal garantiert, dass man das wichtigere Standardproblem der Multiplikation - die Berechnung einer Rechteckfläche - lösen kann.  
Der Algorithmus der schriftlichen Dezimalzahlmultiplikation scheint mir zu kompliziert zu sein, um hieraus die Berechnung einer Rechteckfläche herzuleiten.  

#### Meine Vermutung

Das Rechnen mit Strichen ist wichtiger als das schriftliches Rechnen mit Dezimalzahlen,  
obwohl Dezimalzahlen der Repräsentation von Zahlen in langen Strichlisten weit überlegen sind.

## 4 Probleme mit mathematischen Konventionen

In dieses Abschnitt soll deutlich gemacht werden, dass die heutigen mathematischen Konventionen zwar in der Schule vermittelt werden, aber von breiten Kreisen nicht aktiv beherrscht werden. Ich denke, dass die meisten Deutschen die Aufgabe 1+2\*3 nicht im Sinne der Schulmathematik lösen, wenn sie nicht in irgendeiner Weise auf das Problem aufmerksam gemacht werden. Man könnte meinen, dass sich Punkt-vor-Strich jeder merken könne. Aber wenn man ein Jahr oder länger in keiner Weise damit kontaktiert wurde, verflüchtigt dieses Wissen. Eine 20 jährige amerikanische Sängerin hatte noch nie davon gehört. Promovierte Informatiker ermitteln ebenfalls 9. Smalltalk, viele Taschenrechner und der Windowsrechner im Modus normal ermitteln ebenfalls 9. Noch problematischer ist es aber, dass Punkt-vor-Strich nur die Spitze vom Eisberg ist: 6. Die Regeln für Potenzen werden uneinheitlich in Computersystemen genutzt: 2^3^4 = (2^3)^4 = 4096 (EXCEL und Libre Office Calc und TexasInstrumentstaschenrechner) 2^3^4 = 2^(3^4) = 2.4178516e+24 (Mathematik und Google Search) 7. Die Regel für das unäre Minus wird uneinheitlich verwendet: - 3 ^ 2 = (-3)^2 = 9 (EXCEL und Libre Office Calc) - 3 ^ 2 = -(3^2) = - 9 (Programmiersprache basic calculator) 8. 10 - 3 +2 ist 9, nicht wie die PEMDAS-Abkürzung fälschlich folgern lässt 5 (Addition vor Subtraktion). Die mathematischen Konventionen schreiben demnach vor,  
dass man beim Potenzieren von rechts-nach-links rechnet,  
dass Potenzieren und Radizieren vor Punkt und damit auch vor Strichrechnung auszuführen ist,  
dass eine zweistellige Funktion plus in der Form plus(3,4) aber trotzdem 3+4 geschrieben werden soll, dass eine einstellige Funktion mit Klammern geschrieben werden muss, aber viele Rechner anstelle von sqrt(|sin(6)|) die bequemere Notation 6 sin abs sqrt zulassen, dass bei den vielen Konventionen die wichtigste Konvention nach der jedes Kind der zweiten Klasse rechnet vergessen wird: von links-nach-rechts  
Wer sich hier nicht sicher ist, weiss auch nicht sicher was das Ergebnis von  
10 - 3 - 2  
sein soll. Man kann einfach nicht davon ausgehen, dass sich alle Menschen so viel Zeit für die Aneigung und Wiederholung mathematischer Konventionen nehmen können wie beispielsweise Berufsmathematiker. Man muss berücksichtigen, dass auch die Leistungsfähigkeit eines menschlichen Gehirns beschränkt ist und dass in Westeuropa der IQ schon Jahrzehnte am sinken ist (In der Wikipedia wird vermutet, dass das Privatfernsehen die Hautursache ist. Neuerdings könnten noch weitere Faktoren diesen Negativtrend beeinflussen.

### 4.1 Punkt-vor-Strich

Die Gymnasiallehrererin Sabine B. war der Meinung, dass man auch auf dem Gymnasium noch Kopfrechnen üben muss, da die Schüler das Kleineeinmalens nicht flüssig genug beherrschen. Bei Kettenaufgaben der Gestalt  
13 plus 23 plus 44 mal 5 plus 12  
verzichtete sie auf die Punkt-vor-Strich-Regel, da man eine solche Aufgabe ansonsten nicht im Kopf rechnen könne. Damit verletzt die Gymnasiallehrerin bewußt die Rechenregeln der Mathematik.  
Stuttgarter Zeitung:  
www.stuttgarter-nachrichten.de/inhalt.rechenaufgabe-laesst-das-internet-verzweifeln-koennen-sie-dieses-mathematik-raetsel-loesen.0950a10c-09f4-4d0d-a085-6d4ecefc15b2.html  
8:2(2+2) \- so schwer sieht die Gleichung auf den ersten Blick gar nicht aus. Trotzdem bereitet das Mathe-Rätsel tausenden Menschen im Internet Kopfzerbrechen, denn sie können sich nicht auf die eine richtige Lösung einigen. Der Tweet mit der umstrittenen Rechenaufgabe ging um die Welt. ... Fast 15'000 Menschen gaben dem Bild auf Twitter ein **Gefällt mir**, über 16'000 Kommentare wurden abgegeben. Warum man bei der Aufgabe auf zwei verschiedene Lösungen kommen kann und was laut eines Mathematikers des Rätsels wahre Antwort ist, erfahren Sie im Video. ... Die Authorithät eines amerikanischen Mathematikers ausnutzend verkündet Bild, dass 16 die richtige Lösung ist. (Armes Deutschland) 1. Lösung: Wegen 2(2+2)=8 muss das Ergebnis 8:8 = 1 2. Lösung: Wegen 2+2=4 muss das Ergebnis 8:2\*4 = 16 sein.  
Merkur:  
www.merkur.de/leben/karriere/mathe-raetsel-aufgabe-fuenftklaessler-loesung-jeder-zweite-japaner-scheitert-zr-12266399.html  
Verrückt: Jeder zweite Japaner scheitert an dieser Mathe-Aufgabe für Fünftklässler Mal ehrlich: Wie schwer kann schon ein Mathe-Rätsel sein, das aus einem Aufgabenheft für Fünftklässler stammen könnte? Nun ja, in Japan ging das Rätsel viral, als bekannt wurde, dass fast die Hälfte aller jungen Erwachsenen beim ersten Versuch scheiterte. Doch bevor Sie vorschnell urteilen, sollten Sie sich lieber selbst an die Rechenaufgabe wagen.  
9-3÷1/3+1=? Vermutlich haben Sie so gerechnet: 9-3/1/3+1 = 9-3/3+1 = 9-1+1 = 9 (falsch!) Jetzt in o++o umschreiben: 9-(3:1/3)+1 ergibt 1/1 Die Klammer muss gesetzt werden, da für die Lösung vermutlich Punkt-vor-Strich vorausgesetzt wurde.  
Merkur:  
www.merkur.de/leben/karriere/raetsel-knacken-sie-diese-matheaufgabe-fuer-elfjaehrige-zr-90938962.html  
Um das Mathe-Rätsel zu lösen, muss man kein Superhirn sein, sondern sich einfach an zwei Mathe-Regeln halten: Punkt-vor-Strich und Klammern-zuerst rechnen. Dann kommen Sie auch auf das richtige Ergebnis: 3(5-1x2)= 3(5-1x2)= 3(5-2)= 3x3=9  
Welt:  
www.welt.de/kmpkt/article190620337/An-diesem-einfachen-Matheraetsel-scheitern-viele.html  
Ein Mann kauft ein Pferd für 60 Dollar. Er verkauft das Pferd für 70 Dollar. Er kauft das Pferd dann wieder für 80 Dollar. Und verkauft es wieder für 90 Dollar. Wie viel Geld hat der Mann zum Schluss gewonnen oder verloren? Oder kommt er mit plus/minus null aus dem Pferdehandel? Die Lösung -20 (mit o++o: -60 + 70 - 80 + 90) geben lediglich 55% der Nutzer an.

8+8 sqrt

ist zudem schneller zu tippen, da man keine zusätzlichen Klammern benötigt. Würde man

sqrt 8+8

zulassen, was Diese Probleme vermeidet o++o dadurch, dass die Operationen wie sqrt abs sin ... nach dem Inputwert (Argument) geschrieben werden. Diese bequeme Schreib- bzw. Tippweise verwenden auch viele Schultaschenrechner. Obwohl einstellige Operationen nach dem Inputwert positioniert werden, benutzt o++o nicht die polnische Notation rückwärts. Das haben einige Computersprachen in der Vergangenheit versucht, da damit Implementationsvorteile verbunden waren. Auch Hewlett Packard ist letztendlich damit gescheitert. Zu breite Nutzerklassen konnten die Gewohnheiten, die mit der Schreibweise 3+4 verbunden sind, nicht abstreifen.

3 4 +

kann man vielleicht noch schnell erfassen. Aber

3 4 + 1 2 - +

(entspricht 3+4 + (1-2)) bereitet schon einige Schwierigkeiten. o++o verwendet bei einstelligen Operationen also die postfixe (z.B.: 4 sqrt) und bei allen zweistelligen Operationen die infixe (z.B.: 3+4 oder 1 .. 100) Schreibweise. Beide Schreibweisen scheinen unterschiedlich zu sein. In beiden Fällen wird die Operation aber nach dem ersten Inputwert geschrieben. Dieser Gedanke wurde in o++o sogar generell verwirklicht. Für eine Funktion mit mehr als 2 Inputwerten wurde in der Mathematik dagegen eine weitere Notation eingeführt:

f(x,y,z)

Diese Notation widerspricht auch in einem anderen Punkt o++o. In o++o und vielen Programmiersprachen kann das Komma nicht als Trennzeichen benutzt werden, da es bereits für die Paar- oder allgemeiner Tupelbildung benutzt wird. Außerdem wird diese Funktionsnotation in vielen Programmiersprachen nicht konsequent durchgehalten. .. hat 2 Inputwerte aber ... drei. Durch

1 ... 10!0.1

werden alle Zahlen von 1 bis 10 mit der Schrittweite 0.1 generiert. Das ! als Trennzeichen zwischen dem zweiten und dritten Inputwert findet man in allen 3 stelligen Operationszeichen von o++o. Da man 9! in neueren o++o-Versionen durch 1 ..9 \*\* ausdrücken kann, konnte dieses Symbol der Fakultätsfunktion für andere Zwecke benutzt werden. Durch diese Konventionen kann man die folgende Näherung für die Fläche unter den 2 Sinusbögen ohne Klammern formulieren:

0 ... 2\*pi!0.000'01 sin abs \*0.000'01 ++

Hierbei wird von jeder der generierten Zahlen der Sinuswert berechnet, dann wird jede Zahl in eine positive umgewandelt. Diese Zahlen sind die jeweiligen Höhen unter in der Kurve. Durch die Multiplikation jeder Höhe mit der Schrittweite erhält man 628'319 sehr kleine Rechteckflächen. Die abschließende Summe dieser Flächen (4.00000000005) stellt eine Näherung für die exakte Lösung 4. dar. Diese und ähnliche Probleme kann ein Sekundarschüler der 8-ten Klasse selbstständig ohne Hilfestellung in 10 Minuten vollständig lösen, wenn er mit den Grundgedanken von o++o vertraut ist. Mit o++o kann er in der Zeit sogar eine Visualisierung des Funktionsgraphen generieren, um sich ein besseres Bild vom Problem zu erarbeiten. Die entscheidende Frage hierbei ist jedoch, ob sich Archimedes über die o++o-Notation seines Algorithmus gefreut hätte oder ob er ein Programm in JAVA- oder einer anderen Programmiersprachen vorgezogen hätte? Ich habe einen guten Draht zu Odin dem dem Göttervater von Walhalla und bin mir sicher, dass Zeus, der oberste Grieche unserem Germanenchef das ins Ohr flüstern wird. Jeder Schüler der zweiten oder dritten Klasse, der die Bedeutung der Symbole + \* - und : erfaßt hat, rechnet stets von links nach rechts. Das heißt diese o++o-Konvention muß in der Schule gar nicht vermittelt werden. Daher kann sie auch niemand vergessen. Sehr, sehr viele Erwachsene, viele Rechner und auch Programmiersprachen rechnen von links nach rechts. Nach dem größten deutschen Rechenmeister Adam Ries ist das Ergebnis von 1+2\*3 ebenfalls 9, da er die Regel "Punkt- vor Strich" nicht eingeführt hat. Viele denken, dass Punkt vor Strich für alle vermittelbar ist. Meine Erfahrung zeigt, dass sehr viele selbst promovierte Informatiker dies wieder vergessen, wenn sie mehrere Jahre nicht daran erinnert wurden. Die meisten Menschen halten Punkt vor Strich für Mathematik. Ich kennen bisher niemanden, der weiß, warum die Konvention eingeführt wurde. Ferner ist Punkt vor Strich nur die Spitze eines Eisbergs. Den meisten Menschen ist nicht bewußt, dass Potenzen vor Punkt, ... ebenfalls gefordert wird. Von links nach rechts ist auch heute die wichtigste Regel. Daran müßte aber in der Schule auch regelmäßig erinnert werden, damit jeder 10 - 3 - 2 richtig rechnet. Ferner denke ich, dass es nur wenige gibt, die beim Potenzieren von rechts nach links rechnen würden. Die Mathematiker fordern dies nur, damit sie ein kleines Gesetz etwas eleganter formulieren können. Dafür soll die gesamte Menschheit umständlicher rechnen? Durch die Vermittlung von Punkt vor Strich zerstört die Schule jungfräulich einfache und klare Denkweisen in den Kinderhirnen.

## 5 Was ist o++o?

o++o ist an erster Stelle ein mathematisches Datenmodell. Die wesentlichen Operationen wurden mit einer algebraischen Spezifikationssprache für abstrakte Datentypen von Heinz Kaphengst und Horst Reichel aus dem Kombinat Robotron Axiom für Axiom präzisiert. Diese Spezifikationssprache wurde auch von U. Hupbach und K. Benecke weiterentwickelt. K. Benecke versuchte nicht nur bekannte Typen, wie Mengen, Listen, Stacks, ... zu spezifizieren. Er wollte beweisen, dass eine formale Spezifikation neuer Datentypen viele Vorteile bietet. Die scheinbar belanglose Neuerung bestand darin, dass er alle Kollektionen (Listen, Mengen, Multimengen) sowie Tupel, ... in einer "Sorte" Table vereinigte. Hierhinter verbargen sich von Anfang an strukturierte Tabellen. Nach dem Aufkommen von XML konnte er strukturierte Dokumente mit in den Grundbegriff einschließen. Die Sorte hieß von da ab Tabment (TABelle+ dokuMENT). Er geht davon aus, dass einige Ideen von XML endnutzertauglich sind. Mit der funktionalen Programmiersprache OCaml kann man die Axiome relativ direkt nachempfinden. o++ops ist einen tabellenorientierte Programmiersprache, mit der man nicht nur strukturierte Tabellen sondern auch strukturierte Dokumente anfragen und analysieren kann. Durch die neue "tabellenorientierte" Sicht auf die Programmierung verzichtet o++ops sogar auf Schleifen und rekursive Funktionen, auf die aus unserer Sicht keine andere Programmiersprache verzichten kann. Durch Schleifen werden Programme leicht unübersichtlich. Rekursive Funktionen stellen eine relativ hohe Einstiegsbarriere für den Endnutzer dar. Daher sollte man aus unserer Sicht auf beide Prinzipien in Endnutzersprachen verzichten. Auf dieser Ebene muß Programmiermethodik an erster Stelle stehen. o++o verwendet Wiederholgruppen (Hierarchien) und verfügt über mächtige, jedoch einfach anwendbare Operatoren für Auswahl, Restrukturierung, Berechnung, Erweiterung und Kombination von Tabellen und Dokumenten. Die Bedeutung der mathematischen Fundierung der Operationen (des Datentyps Tabment) kann man kaum unterschätzen. Ein System, das in der modernsten Programmiersprache realisiert wurde, kann schnell wieder vom Markt verschwinden, sobald die Mehrheit eine andere Sprache favorisiert. Mathematische Operationen wie die Addition und Multiplikation überlebten die Römischen Zahlen, den Abakus, den Taschenrechner und viele andere Weisen sie auszuführen. In gleicher Weise denken wir, dass beispielsweise die Ideen der Strichlistenoperation unsere jetzigen Implementationen für Windows, Linux und das Handy überleben werden. Wenn man das Wesentliche eines Systems Schülern an einer Tafel vermitteln kann, hat man viel erreicht.

## 6 Ziele von o++o

Die Jünger von Merkel nehmen ihre These sehr ernst: Jeder soll neben Lesen, Schreiben und Rechnen auch Programmieren lernen. Dieses Ziel kann nur erreicht werden, wenn die Programmiersprache so schnell und leicht wie möglich zu erlernen und zu verstehen ist. In sehr vielen Fällen sind alte Ideen und Konzepte die einfacheren. Beispielsweise wurde die Strichliste bereits vor 30'000 Jahren mit Hilfe eines Kerbstocks dauerhaft lesbar. Die Schrift entstand dagegen erst vor 5'000 Jahren. Mit der gib-Anweisung versucht o++o diese mindestens 100'000 Jahre alten Vorstellungen zu verallgemeinern. Die dahinterstehende Strichlistenoperation beherrschen heutige Vorschulkinder bereits nach 5 minütiger Erklärung. Sie können beispielsweise nicht nur vorbeiziehende Tiere insgesamt zählen. Sie sind problemlos auch in der Lage mit Papier und Stift nach Tierarten differenziert zu zählen, indem sie hinter jedes Symbol für Reh, Sau oder Eber die entsprechenden Striche setzen. In ähnlicher Weise wird sicher jeder bestätigen, dass der mehr als 2'000 Jahre alte Algorithmus von Archimedes für die Berechnung von Flächen unter Kurven wesentlich leichter zu erfassen ist als die Flächenberechnungen, die die sehr anspruchsvollen Theorien der Genies Leibniz und Newton voraussetzen. Da heute jeder Schüler einer höheren Klasse über leistungsfähige Rechentechnik in Form eines Handys oder eines Laptops verfügt, kann man den Algorithmus von Archimedes nicht nur theoretisch an der Tafel durchexerzieren, sondern jeder Schüler kann auch problemlos die 10'000 oder 100'000 kleinen Rechteckflächen addieren. Das ist ein Vorteil unserer heutigen Schüler gegenüber Archimedes, der aber bislang in der Breite nicht genutzt wird. Hinter jedem Klick sollte ein lesbares Programm stehen. Das ist eine scheinbar unerfüllbare Forderung, die wir in unserem Leben nicht vollständig umsetzen können. Mit o++o könnten wir uns aber einen großen Schritt in diese Richtung bewegen. Falls der Endnutzer dann ein Problem mit einem Computerresultat hat, kann er das Programm solange selbst modifizieren bis er genau das von ihm gewünschte Ergebnis erzielt hat. o++o soll das Endnutzertool für die Verarbeitung von Daten werden. D.h., der Nutzer soll mit einheitlichen Mitteln beliebige Datenbanken, Dateien, Retrievalsysteme und die Wikipedia anfragen und analysieren können.

## 7 Eigenschaften von o++o (Selbsteinschätzung)

### 7.1 Bezeichnungen in o++o

Wie alle Programmiersprachen benutzt o++o nur Operationszeichen, die auf jeder Rechnertastatur zur Verfügung stehen. Als Notation für die Quadratwurzel wird daher die häufig benutzte Abkürzung sqrt (square root) verwendet. Auch auf die Betragsstriche mußte verzichtet werden, da auch ihre Schreibweise das Gesamtkonzept zerstören würde. Anstelle von || wird der ebenfalls bekannte Operationsname abs benutzt. Da o++o anders als die Taschenrechnern vielfältige Operationen zur Massendatenverarbeitung anbietet, findet man auch statistische Funktionen für die Summe, das Produkt, den Durchschnitt, die Anzahl usw.. Diese Funktionen besitzen nach o++o-Philosophie trotzdem nur einen Inputwert, da ein Tabment auch Massendaten repräsentieren kann. Der Durchschnitt mehrerer Noten wird in der Form

2 3 1 4 2 2 ++:

ausgedrückt. Die vorangehenden 6 Noten werden nämlich als eine Liste (von Zahlen) betrachtet. Deutlicher wird das in der äquivalenten Notation

\[2 3 1 4 2 2\] ++:

. Die erste Schreibweise, könnte auch vom methodischen Standpunkt Probleme bereiten, sie könnte sich in der Praxis dennoch durchsetzen, da die eckigen Klammern auf manchen Tastaturen unbequem zu tippen sind. Ferner hoffen wir, dass die Bezeichnungen ++ (für Summe) \*\* (für Produkt) .. (Mehrfachanwendung eines bekannten Operationssymbols) nicht so schnell vergessen werden wie die alten englischen oder griechischen Bezeichnungen (Σ bzw. Π).

### 7.2 Zur Syntax und Semantik von o++o

o++o rechnet konsequent von links nach rechts. Das ist unserer Meinung nach eine wichtige Voraussetzung dafür, dass die Programme leicht lesbar sind.

### 7.3 Operationen von o++o

Ein Tabment kann in Caml light - dem Vorgänger von OCaml- mit sehr wenigen Zeilen abstrakt repräsentiert werden. Alle Operationen von o++o werden auf Tabmente, die im Arbeitsspeicher residieren, angewandt.  
Für die Außendarstellung von Tabmenten existieren viele Repräsentationen. Strukturierte Tabellen können übersichtlich und kompakt in Form von tab, tabh, hsq, hsqh, xml, csv und json Ansichten bzw. Dateien dargestellt werden. Die Möglichkeiten der jetzigen Standardrepräsentationen sind vielfältig. Sie sind aber bei weitem noch nicht voll ausgeschöpft. o++o verfügt über leistungsfähige Operationen für die Auswahl (Selektion), Restrukturierung, Berechnung und das Verschmelzen von strukturierten Tabellen, die sogar auf Dokumente anwendbar sind. Das kartesisches Produkt (Kreuzprodukt) genau wie die bekannten mengentheoretischen Operationen Durchschnitt, Vereinigung, Differenz spielen in o++o eine untergeordnete Rolle. Beim Kreuzprodukt wird stets jedes Element der einen Tabelle mit jedem Element der anderen Tabelle verschmolzen. Dadurch entstehen auch im Kopf des Nutzer sehr große Zwischentabellen. Die Notwendigkeit hierfür ist unnatürlich und kaum einzusehen. Joinbedingungen sind fast immer erforderlich. Anwenderfunktionalität kann in o++o-Programme integriert werden, indem entsprechende neue Funktionen in OCaml implementiert werde. Dadurch verlieren Einbettungen von o++o in herkömmliche Programmiersprachen wie JAVA, C,... an Bedeutung. Für o++o steht Programmiermethodik und Pragmatik im Vordergrund. Es ist wichtiger, dass o++o-Programme elegant und lesbar sind, als die im Hintergrund arbeitenden OCaml-Programme. Diese kann man immer noch verbessern und effizienter machen, ohne dass das Auswirkungen auf den o++o-Nutzer hat. Wir schätzen ein, dass viele Grundoperationen von o++o, wie einfache Selektionen, die Realisierung einer Strichliste, ... leichter zu erlernen und zu verstehen sind als beispielsweise der in der Schule vermittelte Algorithmus der Dezimalzahlmultiplikation. o++o wurde in OCaml (INRIA Paris) implementiert und mit einer deutschen Sprache spezifiziert. Damit ist o++o ein europäisches Produkt

## 8 Ein Blick auf das Relationale Datenmodell durch die o++o-Brille

[Inhalt](https://ottops.de/#inhalt)  
Mit der Vielzahl der Softwareprodukte, die auf SQL und damit auf dem Relationalen Datenmodell basieren, haben Firmen wie ORALE, IBM, Microsoft, Robotron, Siemens, ... viele hundert Milliarden Dollar bzw. Euro, .. verdient. Das Modell hat der britische Mathematiker E. F. Codd entwickelt. Im Wesentlichen beschreiben seine Papiere mathematisch saubere Operationen für Anfragen wie die Selektion, Projektion, das Kartesisches Produkt (Join) und das Umbezeichnen von Spaltennamen (rename) zum einen in Form der Relationenalgebra und zum anderen in Form des Relationenkalküls. Der Relationenkalkülansatz konnte sich trotz anfänglicher Erfolge nicht etablieren (INGRES). Daneben hat Codd für seine Relationen zunächst 3 Normalformen beschrieben. Die dritte Normalform galt als die beste. Das wurde häufig mißverstanden. Man sollte eigentlich davon ausgehen, dass Codd dieser Normalform nur für die Speicherung von Relationen auf der Platte Bedeutung beigemessen hat. Wenn man das auch für die Ergebnisse von Anfragen fordern würde, würde man die Bedeutung des Relationalen Datenmodell zusätzlich schwächen. Eine Relation ist eine Menge, die man sich als Tabelle mit n-Spalten vorstellen kann, in der die Zeilen Tupel genannt werden und wo in jedem Kreuzungspunkt einer Zeile mit einer Spalte genau ein elementarer Wert (insbesondere keine Relation) stehen darf. Der Hauptvorteil des Relationalen Modells besteht in der sauberen Definition der Objekte und Operationen und der damit verbundenen Klarheit für zu schaffende Systeme und Schnittstellen. Der Nutzer braucht nichts von der Unmenge der Implementationsdetails zu wissen. Allein das Verständnis der algebraischen Operationen sollte den Endnutzer befähigen beliebige Informationswünsche selbst umzusetzen. Diese ursprüngliche Zielstellung, die in den ersten Papieren gesetzt wurden, haben sich nicht erfüllt. Obwohl SQL auch heute noch der Datenbankstandard ist, gibt es nur wenige Millionen Nutzer. Der überwiegende Teil sind Informatiker. Da diese neben Kenntnissen über SQL auch über vielfältige Kenntnisse von Programmiersprachen wie z.B. JAVA verfügen, können sie alle ihre Datenbankprobleme selbst lösen. Sie interessieren sich scheinbar gar nicht für die offensichtlichen großen Schwachstellen des Relationalen Datenmodells: Textdaten lassen sich praktisch nicht behandeln. Da Relationen als Mengen definiert sind, war Selektion nach der Position ursprünlich nicht vorgesehen. SQL kennt trotzdem beispielsweise eine top-Funktion, mit der man die ersten 10 Zeilen einer Tabelle selektieren kann. Sie kann aber nur an einer Stelle aber nicht im Rahmen der Selektionsklausel WHERE angewandt werden. Wenn beispielsweise mitarbeiter.tab eine flache relationale Tabelle mit den fünf Spalten NAME,SEX,ABTEILUNG,ORT,GEHALT ist, kann man die einfache Anfrage "Gesucht sind von den 10 Topverdienern aus Magdeburg nur die Frauen" in folgender Weise in o++o ausdrücken:

```
aus mitarbeiter.tab
sel ORT=Magdeburg       # Selektion aller Magdeburger
gib GEHALT,NAME,SEX m   # Sortierung nach GEHALT
sel GEHALT pos < 11     # Selektion der ersten 10
sel SEX=weiblich        # Selektion der Damen

```

SQL hat mit dieser und mit vielen anderen vom o++o-Standpunkt einfachen Anfragen große Probleme. Eine Repräsentation von Informationen in strukturierten Tabellen ist "natürlicher" als eine Repräsentation in flachen Relationen. Das erkennt man auch daran, dass bereits vor weit mehr als 60 Jahren in Magdeburg strukturierte Daten auf Magnetbändern verarbeitet wurden und die ersten Datenbankanwendungen (DBSR) auch keine erste Normalform-Relationen voraussetzten. Das erste Datenbankbetriebssystem von IBM IMS basierte ebenfalls auf strukturierten Tabellen. Allerdings lag allen drei Computersystemen kein mathematischen Datenmodell zugrunde. Das sehr alte hierarschische System von IBM wurde nach der Wende auch in Magdeburger Banken eingeführt. Da an DDR-Universitäten dieser hierarchische Ansatz nie vermittel wurde und in Westdeutschland auch kein Absolvent mehr Wissen über IMS hatte, mussten die westdeutschen Rentner diese Aufbau-Ost Aufgaben umsetzen. Läuft IMS heute noch in Magdeburg? In jungen Ansätzen wird der Boden des Relationalen Datenmodells für sehr grosse Anwendungen (bigdata) häufig aus Effizienzgründen völlig verlassen. Mir persönlich sind jedoch keine dahinter liegenden mathematischen Fundierungen bekannt. o++o Bedingungen im Gegensatz zu SQL müssen nicht unbedingt durch und (& SQL: and) oder oder (or) verknüpft werden. Sie können einfach nacheinander angewandt werden. Zwei aufeinanderfolgende Bedingungen sind nicht immer gleichbedeutend mit ihrer Konjunktion (und-Verbindung). Daraus folgt auch eine erhöhte Ausdruckskraft von einfachen Bedingungen im Rahmen von o++o. Die Repräsentation eines Klassenbuchs einer Schule in dritter Normalform würde nie ein Lehrer oder Schüler akzeptieren. Allein für die Daten der 4 Spalten NAME,ADRESSE,FACH,NOTE müßte man zwei Tabellen anlegen:  

```
NAME,ADRESSE  
NAME,FACH,NOTE  
```

Da die zweite Tabelle eine Relation sein müßte, könnte ein Schüler in einem Fach nicht zweimal die gleiche Note bekommen. Also müßte man irgend eine Zusatzspalte z.B. ZEIT einführen, die diese beiden Einträge unterscheidbar macht. Dann müssen aber die NAME, FACH und NOTE-Werte ständig wiederholt gespeichert werden. Einfache Anfragen nach der letzten Note eines Schülers in bestimmten Fächern sind trotzdem umständlich zu formulieren,... . Mit o++o könnte die zweite Tabelle eine Listenwiederholgruppe enthalten: NAME,FACH,NOTEl m Damit kann man jede Note bequem speichern, aber die Namen würden sich immer noch für jedes Fach wiederholen. Das Problem wird mit NAME,(FACH,NOTEl m) m gelöst. Will man noch zwischen Klausurnoten und anderen Noten unterscheiden hat das Relationale Datenmodell noch weit mehr Probleme. In o++o könnte man eine weitere Wiederholgruppe einfügen: NAME,(FACH,KLAUSURl,NOTEl m)m Die Hersteller Relationaler Datenbanksysteme haben den Boden des armen Relationalen Datenmodells schon früh verlassen müssen. Multimengen wurden benötigt, damit eine Zeile im Anfrageergebnis mehrfach erscheinen kann. Arrays (aber nur mit einfachen Werten) wurden in Zellen von Relationen zugelassen. Damit wird sogar die überall gelehrte Forderung nach erster Normalform umgangen. Dadurch waren weniger teure Joins erforderlich, womit die Performance gesteigert werden konnte. Diese Erweiterung gilt aber nicht für die interne Verarbeitung der Relationen, da die ganze Optimierung nur mit einfachen Relationen arbeiten kann. Die Array-Wiederholgruppen würden Anfrageergebnisse übersichtlicher aussehen lassen. Sind dort aber nicht erlaubt. o++o kennt Listen aber keine Arrays, da dem Architekten von o++o nicht klar ist, ob ein Array algebraisch spezifiziert werden kann? Ist ein Array überhaupt Objekt der Mathematik? GROUPBY unterteilt eine Relation in mehrere eine Teilrelationen. Damit erhält man beispielsweise eine Tabelle des Typs , bei der eine innere Menge alle Mitarbeiter einer Abteilung enthält. Diese Struktur wird klarer und einfacher zu handhaben, wenn man in SQL stattdessen das Schema  
ABTEILUNG,(NAME,ORT m) m wählen könnte. Nach dem GROUPBY ist nur eine spezielle Selektion (HAVING) erlaubt, die nur vollständige Gruppen entfernen kann. Relationale Datenbanken kennen beispielsweise den elementaren Typ INT, aber der einzeilige und einspaltige Wert  

```
GEHALT  
40'000  
```

ist keine Relation.  

```
GEHALTm  
40'000  
```

ist dagegen Objekt des Modells. Betrachtet man daher eine SQL Bedingung GEHALT = 40000 und nimmt an, dass die Zahl 40000 Ergebnis einer Unteranfrage ist - sie ist damit eine Relation - , so steht auf auf der linken Seite der Gleichung eine Zahl und auf der rechten eine Relation. Was soll das dann bedeuten?