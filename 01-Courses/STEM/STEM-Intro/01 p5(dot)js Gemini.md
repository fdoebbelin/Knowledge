

# **Interaktive MINT-Lernumgebungen mit p5.js: Ein Implementierungs- und Didaktik-Framework für Visualisierung und Computational Thinking**

## **1\. Strategische Einleitung und Pädagogische Grundlegung**

### **1.1. Die Rolle von Creative Coding (CC) in der MINT-Bildung**

p5.js repräsentiert eine spezialisierte JavaScript-Bibliothek, die explizit als „friendly tool for learning to code and make art“ konzipiert wurde.1 Diese Positionierung an der Schnittstelle von Programmierung, Design und Interaktion macht p5.js zu einem didaktisch wertvollen Werkzeug, um MINT-Konzepte greifbar zu machen und die intrinsische Motivation der Lernenden durch kreative Ergebnisse zu steigern.2 Die Basis bildet die offene und inklusive Gemeinschaft, welche die Bibliothek unterstützt und stetig weiterentwickelt.1

Die Verfügbarkeit von umfassenden Ressourcen ist ein Schlüsselfaktor für die Implementierung im akademischen Bereich. Die p5.js-Plattform stellt nicht nur eine detaillierte Referenz aller Funktionen bereit 3, sondern pflegt auch einen umfangreichen Katalog an Bildungsmaterialien, Workshops und Kursen aus der internationalen Gemeinschaft.4 Für den deutschsprachigen Raum existieren spezifische Angebote, darunter Video-Seminare, die eine Einführung in JavaScript-Grundlagen und p5.js geben, wobei der Fokus auf Output für Web, Print und Rapid Prototyping liegt.4 Weitere didaktische Materialien bieten kommentierte Code-Listings, Übungsaufgaben und Musterlösungen, die den Einstieg für Lehrende und Anfänger signifikant erleichtern.5

### **1.2. Struktur der Interaktiven Lernumgebung (ILE)**

Für die Erstellung effektiver, interaktiver Lernumgebungen (ILEs) ist eine modulare und flexible Architektur notwendig. Die ILEs sollten als eigenständige p5.js-Skizzen entwickelt werden, die in übergeordnete Lernmanagementsysteme (LMS) wie Moodle oder ILIAS integriert werden können.

Ein fortgeschrittenes didaktisches Konzept besteht darin, die Möglichkeiten der p5.js-API zur Erstellung von Multi-Canvas-Erlebnissen zu nutzen. Durch die Übergabe von Funktionen an den p5-Konstruktor (new p5(sketch1)) ist es möglich, mehrere unabhängige p5.js-Instanzen auf einer einzigen HTML-Seite zu betreiben.6 Diese Technik ist besonders wertvoll für die Darstellung komplexer MINT-Konzepte: Beispielsweise kann ein Canvas die physikalische Simulation darstellen, während ein zweiter Canvas gleichzeitig einen Graphen der abhängigen Variablen anzeigt, ergänzt durch einen dritten Bereich für Quizfragen oder erklärende Texte. Darüber hinaus ermöglichen Techniken wie window.opener oder postMessage die synchrone Kommunikation zwischen mehreren Browserfenstern, was für anspruchsvolle, interaktive Visualisierungen oder kooperative Arbeitsumgebungen genutzt werden kann.7

Die Komponenten der ILE werden wie folgt in die p5.js-Struktur integriert:

* **Animation/Experiment:** Die kontinuierliche Aktualisierung des visuellen Zustands erfolgt in der draw()-Schleife.8  
* **Interaktion/Quiz:** Die Logik wird über Zustandsvariablen gesteuert (let state \= 0), wobei Eingaben (Mausklicks, Tastatur) zur Zustandsänderung und zur Überprüfung von Antworten verwendet werden.9  
* **Erklärender Text:** Kurze Erklärungen können direkt auf dem Canvas mit der Funktion text() dargestellt werden.10 Für umfangreiche, statische oder reich formatierte Erklärungen ist die Nutzung des umgebenden HTML/CSS/DOM-Bereichs über den p5.js Web Editor zu empfehlen.11  
* **Externe Links:** Hyperlinks zu vertiefenden Quellen werden mittels der Funktion createA(href, html, \[target\]) direkt in die Anwendung eingebettet.12

### **1.3. Überblick über technische Voraussetzungen und Entwicklungsumgebung**

Für den Einstieg in die Entwicklung interaktiver Lernumgebungen wird der p5.js Web Editor als ideale Umgebung empfohlen.8 Er ist webbasiert, erfordert keine lokale Installation und ermöglicht das Speichern, Testen und Teilen von Skizzen direkt über den Browser.8 Für Studierende oder Lehrende mit fortgeschrittenen Anforderungen, die externe Bibliotheken integrieren oder eine leistungsfähigere Entwicklungsumgebung benötigen, stellt Visual Studio Code (VS Code) eine empfohlene Alternative dar.8

Die p5.js-Bibliothek ist ein freies und quelloffenes Projekt (FOSS). Es ist zu beachten, dass alle vom Benutzer generierten Inhalte, die an die Processing Foundation übermittelt werden (z.B. über den Web Editor), standardmäßig unter der Creative Commons Attribution-ShareAlike 2.0-Lizenz stehen. Dies fördert die offene Verfügbarkeit und das Remixen von Lehrmaterialien innerhalb der Bildungsgemeinschaft.14

## **2\. p5.js im Mathematik-Modul: Visualisierung von Funktionen und Algebra**

### **2.1. Interaktive Graphen und Funktionsdarstellung**

Die mathematische Visualisierung beginnt mit den grundlegenden 2D-Primitiven von p5.js, zu denen line(), circle(), ellipse(), rect(), und triangle() gehören.3 Diese bilden die Grundlage für die Konstruktion von Koordinatensystemen, Achsen und die Plotterstellung.

Besondere Stärke liegt in der Animation mathematischer Phänomene, insbesondere im Bereich der Trigonometrie und Schwingungen. Die Bibliothek unterstützt dedizierte Funktionen zur Darstellung von Winkeln und Bewegung (Angles And Motion).15 Ein klassisches Beispiel ist die animierte Visualisierung der Sinus- und Kosinus-Werte auf dem Einheitskreis, um den Zusammenhang zwischen Kreisbewegung und Wellenfunktionen dynamisch zu veranschaulichen.15

### **2.2. Visualisierung von Geometrie und Transformationen**

Die grafische Veranschaulichung der Linearen Algebra, insbesondere der Matrizenoperationen, wird durch die p5.js-Transformationsfunktionen ermöglicht. Funktionen wie translate(), rotate(), und scale() erlauben die dynamische Steuerung des Koordinatensystems.15 Lernende können die Auswirkungen einer Rotation oder Skalierung in Echtzeit beobachten, indem sie Maus- oder Tastaturereignisse zur Steuerung dieser Transformationen nutzen. Diese Funktionalität bietet eine direkte Entsprechung zur grafischen Anwendung von Transformationsmatrizen.

Ein wichtiger didaktischer Übergang findet statt, wenn man die Ausführung von p5.js-Code mit mathematischer Syntax in Beziehung setzt. Jeder Befehl, der eine geometrische Figur definiert (z.B. rect(x, y, w, h)), kann als eine mathematische Funktion betrachtet werden, deren Argumente die geometrischen Parameter steuern. Durch die Manipulation dieser Parameter wenden Studierende intuitiv Funktionsdefinitionen und Parametersteuerung an, wodurch die Lernumgebung die Programmierung direkt mit der Anwendung mathematischer Syntax und Funktionslehre verschmilzt.

Ein tiefgreifendes Verständnis der numerischen Mathematik wird durch das Verhalten der rotate()-Funktion im draw()-Loop vermittelt. Die Dokumentation weist darauf hin, dass Transformationen in der Regel am Anfang jedes draw()-Loops zurückgesetzt werden.16 Um eine kontinuierliche Bewegung oder kumulative Drehung zu erzeugen, muss der Winkelwert in einer externen Variable gespeichert und in jedem Frame inkrementiert werden. Dieses technische Erfordernis führt die Lernenden direkt in die Kernkonzepte der **Iteration, des Zustandsmanagements und der Zeitdiskretisierung**, die für die Modellierung kontinuierlicher Prozesse in der numerischen Simulation grundlegend sind.

Für spezifische Anforderungen im Bereich mathematischer Animationen kann die Nutzung spezialisierter Ergänzungen in Betracht gezogen werden. Die Bibliothek p5.teach.js wurde beispielsweise entwickelt, um als anfängerfreundliche Lösung für mathematische Animationen in p5.js zu dienen.17

### **2.3. Integration von Quizfragen zur Überprüfung mathematischer Konzepte**

Quizfragen können nahtlos in die ILEs integriert werden, um das Verständnis mathematischer Konzepte zu überprüfen. Beispielsweise könnte ein animierter Graph angezeigt werden, gefolgt von einer Multiple-Choice-Frage zur korrekten Ableitung oder der Definition des Definitionsbereichs. Die technische Implementierung stützt sich auf die Zustandsverwaltung und die Interaktionserkennung von p5.js, um unmittelbares Feedback auf die Eingaben der Lernenden zu geben.9

| Konzept | p5.js Funktion(en) | Analyse des Lernmehrwerts |
| :---- | :---- | :---- |
| 2D Geometrie | rect(), ellipse(), triangle(), arc() 3 | Direkte Umsetzung von Formeln in visuelle Artefakte. |
| Koordinatensystem | translate(), push(), pop() 15 | Verständnis von Matrizen- und Koordinatentransformationen. |
| Trigonometrie | sin(), cos(), atan2(), angleMode() 15 | Interaktive Darstellung von Einheitskreis und Wellenfunktionen. |
| Zufall/Stochastik | random(), randomGaussian() 18 | Visualisierung von Verteilungen und statistischen Prozessen. |

## **3\. p5.js im Informatik-Modul: Veranschaulichung von Abstraktion und Prozessen**

### **3.1. Didaktische Nutzung der p5.js-Struktur**

Die feste Struktur von p5.js mit den Funktionen setup() und draw() bietet einen klaren didaktischen Rahmen zur Einführung in die Programmierung.8 setup() dient der Initialisierung (z.B. createCanvas()), während draw() die kontinuierliche Verarbeitung und das Event-Handling übernimmt. Diese Trennung ist fundamental für das Verständnis von Ereignissteuerung und Endlosschleifen. Funktionen zur Interaktion wie die Abfrage der Mausposition (mouseX, mouseY) oder Tastatureingaben 2 ermöglichen es Anfängern, unmittelbar dynamische, sichtbare Ergebnisse zu erzeugen, was die Attraktivität des Moduls Creative Coding für die Einführung in die Informatik steigert.

### **3.2. Dynamische Visualisierung von Algorithmen und Datenstrukturen**

P5.js hat sich als ein Standardwerkzeug für die Algorithmus-Visualisierung (AV) etabliert. Es existieren zahlreiche Beispiele, darunter Visualizer für Sortieralgorithmen.20

Die Visualisierung von Algorithmen wie Bubble Sort erfolgt typischerweise durch die Darstellung der Array-Elemente als vertikale Balken, wobei deren Höhe dem Wert des Elements entspricht.21 Für die didaktische Klarheit werden die gerade verglichenen oder getauschten Elemente durch Farbänderungen hervorgehoben (stroke(255, 0, 0)).21 Eine entscheidende technische Anforderung für die pädagogische AV ist die Kontrolle über die Ausführungsgeschwindigkeit. Die Funktion frameRate() ermöglicht die Anpassung der Visualisierungsgeschwindigkeit, wodurch Studierende die einzelnen Schritte des Algorithmus (Vergleich, Tausch) im Detail nachvollziehen können.21 Darüber hinaus kann p5.js auch für generische Datenvisualisierungen genutzt werden, um abstrakte Datenstrukturen und deren Verarbeitungslogik zu veranschaulichen.22

Die Wahl der Implementierungsmethode führt zu einer wichtigen pädagogischen Unterscheidung. Ein Blick in die offizielle Dokumentation zeigt, dass für erweiterte Projekte oder bei der Entwicklung von p5.js-Bibliotheken die Verwendung nativer JavaScript-Funktionen (z.B. Math.random(), Math.min()) anstelle der p5.js-Äquivalente empfohlen wird, um die Performance zu optimieren.18 Dies offenbart eine didaktische Progression: Anfänger profitieren von der p5.js-Abstraktion, die intuitiv und einfach ist, während fortgeschrittene Lektionen zur Leistungsanalyse und zur Bewertung der Zeitkomplexität von Algorithmen das Verständnis der zugrunde liegenden nativen JavaScript-Engine erfordern. Diese Dualität erlaubt es, sowohl das Konzept als auch die Effizienz der Implementierung zu lehren.

### **3.3. Erstellung interaktiver Anwendungen und Spiele**

Praktische Projekte sind ein zentraler Bestandteil des Informatik-Moduls. P5.js-Tutorials leiten die Lernenden an, einfache interaktive Anwendungen wie Pong zu erstellen.13 Ebenso werden Techniken zur Arbeit mit Arrays und Schleifen zur Erzeugung komplexer, generativer visueller Muster vermittelt.23

Die Nutzung von JavaScript als Basis von p5.js schafft einen wertvollen didaktischen "Sandkasten". Obwohl Studierende an Hochschulen parallel komplexere Programmiersprachen wie C++ lernen müssen 13, ermöglicht p5.js den schnellen Einstieg in fundamentale Programmierkonzepte (Logik, Datenstrukturen, Zustandsverwaltung) mit dem unmittelbaren Feedback visueller Ergebnisse. Dies erleichtert den Übergang von visuellen Programmierumgebungen hin zu textbasierter Entwicklung, da der Fokus zunächst auf dem kreativen Output liegt, bevor die komplexeren Syntaxen tiefergehender Sprachen verarbeitet werden müssen.

## **4\. p5.js im Physik-Modul: Aufbau von Simulationen und Experimenten**

### **4.1. Grundlagen der Physikalischen Modellierung mit Core p5.js**

P5.js ist hervorragend geeignet, um physikalische Grundprinzipien, insbesondere die Newtonsche Mechanik, zu modellieren. Die in p5.js integrierten Vektorfunktionen, wie createVector() sowie Funktionen für die Vektoraddition und \-skalierung, sind die direkten Werkzeuge zur Implementierung von Kräften, Beschleunigungen und Geschwindigkeiten.24

Ein klassisches Beispiel ist der Gravitationssimulator.25 Dieser demonstriert, wie die Kräfte zwischen mehreren Objekten (N-Körper-Problem) durch die iterative Berechnung der Gravitationsgesetze (F \= G \* (m1 \* m2) / r^2) innerhalb des draw()-Loops simuliert werden können.24 Die Lernenden können Parameter wie Masse oder Anfangsgeschwindigkeit interaktiv ändern, wodurch die Animation zu einem virtuellen, parametrisch steuerbaren Experiment wird.25

### **4.2. Anwendung der p5play-Bibliothek für erweiterte Simulationen**

Für Experimente, die eine hohe physikalische Präzision und Stabilität erfordern, ist die Nutzung spezialisierter Add-ons ratsam. Die p5play-Bibliothek integriert die leistungsstarke Box2D-Physik-Engine, die auch in kommerziellen Spielen Anwendung findet.26

Die Box2D-Integration ist entscheidend, da sie **deterministische** Simulationen ermöglicht.27 Determinismus bedeutet, dass identische Startbedingungen stets zu identischen Ergebnissen führen, was eine zwingende Voraussetzung für die Reproduzierbarkeit und Validierung wissenschaftlicher Experimente im Unterricht ist. P5play erlaubt die detaillierte Steuerung physikalischer Parameter, wie die Schwerkraft (world.gravity) und den Zeitmaßstab (timeScale). Die Fähigkeit, die Zeitlupen- oder Zeitraffer-Effekte zu erzeugen, ist didaktisch wertvoll, um schnelle physikalische Prozesse in Ruhe zu analysieren.27

Die Wahl zwischen der Implementierung in Core p5.js und der Nutzung von p5play definiert unterschiedliche Lernziele: Die Verwendung der Kernbibliothek zwingt die Lernenden, die mathematische Umsetzung der physikalischen Gesetze (Integration) selbst zu programmieren, wodurch ein tiefes Verständnis für die Modellierung entsteht. Im Gegensatz dazu ermöglicht p5play den Fokus auf die **Exploration des Systemverhaltens** und die Auswirkung von Parameteränderungen, da die komplexe numerische Integration von der Bibliothek übernommen wird.26

Es ist zu beachten, dass p5play, obwohl es auf dem Open-Source-Framework p5.js basiert, eine kommerzielle **Edu License** erfordert, um es im Rahmen des Schul- oder Hochschulbetriebs zu nutzen. Diese Lizenz wird mit einer Klassen-ID verwaltet 28, was bei der Ressourcenplanung berücksichtigt werden muss.

### **4.3. Fortgeschrittene und Quantenphänomene**

Die Vielseitigkeit von p5.js erlaubt auch die Visualisierung von Phänomenen, die im klassischen Klassenzimmer nicht beobachtbar sind. Community-Ressourcen zeigen Anwendungen für fortgeschrittene Konzepte der modernen Physik, wie Simulationen zur Quantentunnelung, Wellen-Teilchen-Dualität oder Thermodynamik.29 Diese ILEs dienen in erster Linie der **konzeptuellen Durchdringung** des Stoffes, indem sie komplexe und abstrakte physikalische Modelle visuell zugänglich machen.

## **5\. p5.js im CAD-Modul: Geometrische Konstruktion und 3D-Visualisierung**

### **5.1. Grundlagen der 2D-Zeichnung und Interaktives Drafting**

Für das CAD-Modul bietet p5.js eine Plattform zur Vermittlung grundlegender geometrischer Konstruktion und Interaktion. Mithilfe der 2D-Primitiven (arc(), line(), quad() etc.) 3 können Lernende interaktive 2D-Zeichnungen erstellen.30 Die sofortige visuelle Rückmeldung auf geänderte Parameter führt die Studierenden direkt in die Konzepte des **parametrischen Designs** ein, bei dem geometrische Formen durch Variablen und Funktionen gesteuert werden.4

### **5.2. 3D-Konstruktion und der WEBGL-Modus**

P5.js ist nicht auf 2D beschränkt, sondern unterstützt über den WEBGL-Renderer auch 3D-Grafiken. Der 3D-Modus wird durch den Aufruf von createCanvas(width, height, WEBGL) aktiviert.31

Die CAD-relevanten Konzepte der 3D-Transformationen (Translation, Rotation, Skalierung) werden durch entsprechende p5.js-Funktionen abgedeckt. Besonders relevant ist die Funktion rotate(angle, \[axis\]), die eine Rotation des Koordinatensystems um einen spezifisch definierten Vektor (Achse) im 3D-Raum ermöglicht.16 Dies ist fundamental für das Verständnis, wie Objekte im dreidimensionalen Raum ausgerichtet werden.

### **5.3. Techniken zur Performancesteigerung komplexer Geometrien**

Die Arbeit mit komplexen 3D-Geometrien kann schnell zu Leistungseinschränkungen führen. Für das CAD-Modul ist die Kenntnis von Optimierungstechniken daher unerlässlich. P5.js bietet hierfür spezialisierte Funktionen wie buildGeometry() und die Klasse p5.Geometry.19

Die Funktion buildGeometry() ermöglicht die einmalige Erzeugung eines statischen p5.Geometry-Objekts, das anschließend im draw()-Loop schnell über die Funktion model() gezeichnet werden kann.19 Dies ist wesentlich schneller, als die einzelnen geometrischen Komponenten in jedem Frame neu zu berechnen. Die Klasse p5.Geometry legt dabei die zugrunde liegenden Datenstrukturen der 3D-Modellierung offen, einschließlich vertices (Eckpunkte), faces (Flächen) und vertexNormals (Normalvektoren).32 Die Nutzung dieser Funktionen führt die Lernenden über die reine Werkzeugbedienung hinaus in die **Angewandte Computergrafik und das Algorithmusdesign**, indem sie direkt mit den Kern-Datenstrukturen von 3D-Modellen arbeiten.

Darüber hinaus wird p5.js in Lehrmaterialien als Mittel zur Generierung von Output für **Rapid Prototyping** (3D-Druck, Lasercutter) erwähnt.4 Dies schließt den pädagogischen Kreislauf vom abstrakten Code über die 3D-Geometrie zur physischen Fertigung ab.

| CAD-Ziel | p5.js Modus/Funktionen | Didaktischer Fokus |
| :---- | :---- | :---- |
| 3D-Raumdef. | createCanvas(..., WEBGL) 31 | Einführung in 3D-Koordinatensysteme. |
| Transformation | rotate(angle, axis), scale(x, y, z) 16 | Verständnis von Rotation um Vektoren und Skalierungsfaktoren. |
| Geometrieerzeugung | box(), sphere(), loadModel() 3 | Nutzung von Primitiven und Import von Standardformaten (OBJ/STL). |
| Performanz | buildGeometry(), p5.Geometry 19 | Optimierung der Rendering-Geschwindigkeit komplexer Modelle. |

## **6\. Technische und Didaktische Integration der ILE-Komponenten**

### **6.1. Detaillierte Implementierung von Quizfragen und Zustandsverwaltung**

Die Logik interaktiver Quizzes basiert auf dem Konzept einer Zustandsmaschine, die durch eine globale Variable (let state \= 0\) verwaltet wird.9 Diese Variable definiert, welcher Teil der Anwendung gerade angezeigt wird (z.B. Intro-Seite, Frage, Feedback-Seite).

Um eine einfache Wartung und Trennung von Inhalt und Logik zu gewährleisten, sollten die Fragen, Antworten und Erklärungen in einer externen Datei gespeichert werden, typischerweise als CSV- oder JSON-Format. Ein existierendes Beispiel demonstriert die Nutzung einer qa.csv Datei, die im setup()-Prozess geladen und zur Darstellung der Fragen verwendet wird.9 Die Interaktion erfolgt durch das Zeichnen von visuellen Elementen (z.B. Rechtecke) als Schaltflächen und die Auswertung der mouseClicked()-Events. Die Logik prüft dann die Mausposition gegen die Button-Koordinaten und vergleicht die ausgewählte Antwort mit den geladenen Daten, bevor der globale Zustand der Anwendung aktualisiert wird.

### **6.2. Strategien zur Einbindung von Erklärenden Texten und Formatierung**

Für die Bereitstellung erklärender Texte und Anweisungen können zwei unterschiedliche Methoden genutzt werden, abhängig von den Anforderungen an die Formatierung und Interaktion.

1. **Text auf dem Canvas:** Die Funktion text(str, x, y, maxWidth, maxHeight) 10 ermöglicht die direkte Darstellung von Text innerhalb des Zeichenbereichs. Besonders nützlich ist die Möglichkeit, eine maximale Breite und Höhe festzulegen, wodurch ein automatisches **Text-Wrapping** realisiert wird.10 Dies eignet sich gut für kontextbezogene Anmerkungen oder dynamisch generierte Erklärungen, deren Inhalt sich mit der Simulation ändert.  
2. **HTML/DOM-Integration:** Für die Darstellung umfangreicher, statischer Erklärungen, wie die detaillierte Herleitung einer physikalischen Formel, ist die Nutzung des nativen HTML/CSS/DOM-Bereichs außerhalb des Canvas didaktisch vorteilhafter.11 Dies gewährleistet eine bessere Lesbarkeit, ermöglicht reichhaltige Formatierung (fetter Text, Listen, komplexes Layout) und verbessert die Barrierefreiheit, da der Text durch Browserfunktionen besser verarbeitet werden kann.

### **6.3. Mechanismen zur Integration externer Ressourcen und Referenzen**

Die Einbindung von Verweisen zu externen, vertiefenden Quellen ist für die Vollständigkeit der ILE unerlässlich. Dies kann direkt innerhalb der p5.js-Umgebung realisiert werden, indem die Funktion createA(href, html, \[target\]) genutzt wird.12 Diese Funktion erzeugt ein standardmäßiges HTML-Anker-Element, das frei auf der Seite platziert werden kann.

Beispielsweise kann nach einer Simulation zur Gravitation ein Link direkt zur vertiefenden wissenschaftlichen Erklärung oder zu einem weiterführenden Video auf YouTube platziert werden. Es wird empfohlen, das optionale Parameter target auf '\_blank' zu setzen, um sicherzustellen, dass die externe Quelle in einem neuen Browser-Tab geöffnet wird und die Lernenden die aktuelle ILE nicht verlassen müssen.12

Die Gestaltung einer ILE als ein durchgehender didaktischer Prozess ist eng mit dem kontinuierlichen draw()-Loop verbunden. Da dieser Loop ständig die Animation, die Interaktion und den aktuellen Zustand des Quiz verarbeitet 8, modelliert er nicht nur visuelle Phänomene, sondern veranschaulicht auch, wie kontinuierliche reale Prozesse durch diskrete, sich wiederholende Rechenschritte (Iteration) angenähert werden.

Eine fortgeschrittene didaktische Anwendung ist die Schaffung von Lernpfaden durch Multifenster-Interaktion.7 Durch die Synchronisation mehrerer Browserfenster können komplexe didaktische Szenarien ermöglicht werden: Ein Fenster zeigt die Simulation (Physik/CAD), während ein zweites, separat geöffnete Fenster, die Kontrollparameter oder das zugehörige Quiz enthält. Dies fördert nicht nur die Interaktivität, sondern auch die **Multimodalität und den kooperativen Einsatz**, beispielsweise in Teamarbeit an zwei Monitoren.

| Komponente | p5.js Implementierung | Technische Details & Evidenz | ILE-Vorteil |
| :---- | :---- | :---- | :---- |
| Datenverwaltung | loadTable(), CSV/JSON-Objekt | Lädt externe Daten wie qa.csv 9, ermöglicht einfache Content-Updates ohne Codeänderung. | Hohe Wartbarkeit der Inhalte. |
| Zustandskontrolle | Globale Variable state | Steuert den Anzeigemodus (Intro, Frage, Feedback).9 Wichtig für klare UI-Wechsel. | Definierter, nachvollziehbarer Lernpfad. |
| Interaktion | mouseClicked(), keyPressed() | Erfasst Klicks auf Antwort-Buttons oder Tastatureingaben.2 | Direkte, unmittelbare Rückmeldung. |
| Textdarstellung | text(), DOM-Elemente | Text-Wrapping (maxWidth) 10 für Erklärungen; p5.dom für Links/Buttons.11 | Optimale Lesbarkeit und Verlinkung. |

## **7\. Zusammenfassung und Handlungsempfehlungen**

Die p5.js-Bibliothek bietet ein robustes und flexibles Framework zur Erstellung interaktiver Lernumgebungen, die die didaktischen Anforderungen der MINT-Fächer umfassend abdecken. Die Anwendung von p5.js schafft starke Synergien zwischen den Disziplinen, da Kernkonzepte wie Vektoren, Transformationen, Zustandsverwaltung und Iteration als gemeinsame didaktische Sprache für Mathematik, Informatik, Physik und CAD dienen.

Der Erfolg der Implementierung hängt von der präzisen Auswahl der Werkzeuge ab:

1. **Plattformwahl:** Der p5.js Web Editor sollte aufgrund seiner niedrigen Einstiegshürde und der einfachen Sharing-Funktionalität als primärer Einstiegspunkt für Lernende dienen.8  
2. **Differenzierte Simulationsstrategie:** Für das Physik-Modul muss eine Unterscheidung zwischen konzeptueller Visualisierung (mit Core p5.js Vektoren) und der Forderung nach realistischer, deterministischer Simulation getroffen werden. Für Letzteres ist die p5play-Bibliothek essenziell.27  
3. **Ressourcenmanagement und Lizenzierung:** Obwohl p5.js quelloffen und kostenlos ist, erfordert die Nutzung der didaktisch optimierten und stabilen Box2D-Integration von p5play eine separate Edu License.28 Dies ist bei der Budgetierung des Projekts zu berücksichtigen.  
4. **Content-Integration:** Erklärende Texte und komplexe Quiz-Layouts sollten das Zusammenspiel von p5.js-Canvas und DOM-Elementen (HTML/CSS) nutzen, um maximale Lesbarkeit, Formatierung und Zugänglichkeit zu gewährleisten.11

## **8\. Anhang: Umfassender Katalog externer Ressourcen**

Die folgende Übersicht fasst die identifizierten, für die Konzeption und Implementierung interaktiver MINT-Lernumgebungen relevanten externen Ressourcen zusammen.

### **8.1. Offizielle p5.js Dokumentation, Tutorials und Editoren**

| Ressource | Beschreibung | URL (Snippet ID) |
| :---- | :---- | :---- |
| p5.js Hauptseite | Offizielle Plattform, Startpunkt für Creative Coding. | https://p5js.org/ 1 |
| p5.js Web Editor | Online-Entwicklungsumgebung, ideal für Anfänger. | https://editor.p5js.org/ 8 |
| p5.js Referenz | Umfassende Dokumentation aller Funktionen (2D, 3D, Vektoren). | https://p5js.org/reference/ 3 |
| p5.js Tutorials | Schritt-für-Schritt-Anleitungen zu Kernkonzepten. | https://p5js.org/tutorials/ 23 |
| P5.js Beispiele | Kurze Code-Beispiele für Primitiven, Transformationen, Animation. | https://p5js.org/examples/ 15 |

### **8.2. MINT-spezifische Bibliotheken und Frameworks**

| Ressource | Disziplin | Funktionalität & Lizenzhinweis | URL (Snippet ID) |
| :---- | :---- | :---- | :---- |
| p5play | Physik (2D) | Box2D-basierte, deterministische Physik-Engine. Edu License erforderlich.27 | https://p5play.org/ 26 |
| p5.teach.js | Mathematik | Anfängerfreundliche Bibliothek für mathematische Animationen. | https://p5js.org/libraries/ 17 |
| WEBMIDI.js | Informatik | Bibliothek für MIDI-Interaktion in p5.js-Projekten. | https://p5js.org/libraries/ 17 |
| p5.sound | Allgemein | Add-on für Audio- und Klangvisualisierung. | (Erwähnt in 3) |

### **8.3. Pädagogische und Kursmaterialien (Deutsch/International)**

| Ressource | Fokus | Beschreibung | URL (Snippet ID) |  
|---|---|---|  
| p5.js Education Resources | Allgemein | Sammlung internationaler Workshops, Kurse und Lehrmaterialien. | https://p5js.org/education-resources/ 4 |  
| Parametric Design | CAD/Generativ | Deutsch/Englisch Video-Seminar zu JavaScript/p5.js, Fokus auf Rapid Prototyping. | (Erwähnt in 4\) |  
| maschinennah.de/p5js | Allgemein (DE) | Deutscher Kurs mit kommentiertem Code, Übungen und Musterlösungen. | https://www.maschinennah.de/p5js/ 5 |  
| Codecademy: Learn p5.js | Informatik | Strukturierter Online-Kurs zur Einführung in Creative Coding. | https://www.codecademy.com/learn/learn-p5js 2 |  
| Multi-Window Experiences | Informatik/Interaktion | Techniken zur synchronisierten Visualisierung über mehrere Browserfenster. | https://christiannoss.de/de/thoughts/multi-window-experiences-with-p5-js 7 |

### **8.4. Spezifische Simulationsbeispiele (p5.js Web Editor)**

| Ressource | Disziplin | Inhalt | URL (Snippet ID) |  
|---|---|---|  
| Interactive Physics Sims | Physik | Sammlung fortgeschrittener Simulationen (Quantentunnelung, Thermodynamik). | https://editor.p5js.org/saigattupalli/collections/p8RTKTcdx 29 |  
| Gravity Simulator | Physik | Codebeispiel für die Berechnung von Gravitationskräften. | https://editor.p5js.org/NC\_Productions/sketches/cccCwXioY 25 |  
| Algorithmus Visualizer | Informatik | Beispiel für die Visualisierung von Sortieralgorithmen. | https://editor.p5js.org/BHillard1717/sketches/gLStHGvly 20 |  
| Sorting Algorithm | Informatik | Bubble Sort Visualisierung mit einstellbarer Geschwindigkeit. | https://editor.p5js.org/valockhart/sketches/ayE5VLPV4 21 |  
| Trivia Game | Interaktion/Quiz | Beispiel für die Nutzung von CSV zur Speicherung von Quizdaten. | https://editor.p5js.org/mcfiorino624/sketches/5xJVhojj7 9 |  
| 3D Terrain Generation | CAD | Beispiel für die Erzeugung komplexer 3D-Geometrie. | (Erwähnt in 34\) |

#### **Referenzen**

1. p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/](https://p5js.org/)  
2. Learn p5.js \- Codecademy, Zugriff am Oktober 27, 2025, [https://www.codecademy.com/learn/learn-p5js](https://www.codecademy.com/learn/learn-p5js)  
3. Reference \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/reference/](https://p5js.org/reference/)  
4. Education Resources \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/education-resources/](https://p5js.org/education-resources/)  
5. p5.js \- maschinennah, Zugriff am Oktober 27, 2025, [https://www.maschinennah.de/p5js/](https://www.maschinennah.de/p5js/)  
6. Multiple Canvases \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/examples/advanced-canvas-rendering-multiple-canvases/](https://p5js.org/examples/advanced-canvas-rendering-multiple-canvases/)  
7. Multi-Window Experiences with p5.js \- Christian Noss, Zugriff am Oktober 27, 2025, [https://christiannoss.de/de/thoughts/multi-window-experiences-with-p5-js](https://christiannoss.de/de/thoughts/multi-window-experiences-with-p5-js)  
8. Setting Up Your Environment \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/tutorials/setting-up-your-environment/](https://p5js.org/tutorials/setting-up-your-environment/)  
9. trivia game \- p5.js Web Editor, Zugriff am Oktober 27, 2025, [https://editor.p5js.org/mcfiorino624/sketches/5xJVhojj7](https://editor.p5js.org/mcfiorino624/sketches/5xJVhojj7)  
10. text \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/reference/p5/text/](https://p5js.org/reference/p5/text/)  
11. Creating and Styling HTML \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/tutorials/creating-styling-html/](https://p5js.org/tutorials/creating-styling-html/)  
12. createA \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/reference/p5/createA/](https://p5js.org/reference/p5/createA/)  
13. GKM: P5JS, Zugriff am Oktober 27, 2025, [https://fbi.h-da.de/fileadmin/Personen/fbi1119/GKM/StationenP5js.pdf](https://fbi.h-da.de/fileadmin/Personen/fbi1119/GKM/StationenP5js.pdf)  
14. Terms of Use \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/terms-of-use/](https://p5js.org/terms-of-use/)  
15. Examples \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/examples/](https://p5js.org/examples/)  
16. rotate \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/reference/p5/rotate/](https://p5js.org/reference/p5/rotate/)  
17. Libraries \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/libraries/](https://p5js.org/libraries/)  
18. How to Optimize Your Sketches \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/tutorials/how-to-optimize-your-sketches/](https://p5js.org/tutorials/how-to-optimize-your-sketches/)  
19. buildGeometry \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/reference/p5/buildGeometry/](https://p5js.org/reference/p5/buildGeometry/)  
20. Algorithm Visualizer \- p5.js Web Editor, Zugriff am Oktober 27, 2025, [https://editor.p5js.org/BHillard1717/sketches/gLStHGvly](https://editor.p5js.org/BHillard1717/sketches/gLStHGvly)  
21. Sorting Algorithm \- p5.js Web Editor, Zugriff am Oktober 27, 2025, [https://editor.p5js.org/valockhart/sketches/ayE5VLPV4](https://editor.p5js.org/valockhart/sketches/ayE5VLPV4)  
22. Intro to Data Visualization with P5JS, Zugriff am Oktober 27, 2025, [https://editor.p5js.org/bernatferragut/collections/lrBvc-eGu](https://editor.p5js.org/bernatferragut/collections/lrBvc-eGu)  
23. Tutorials \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/tutorials/](https://p5js.org/tutorials/)  
24. Creating a JavaScript gravity simulator using p5.js \- Brychan Thomas' projects, Zugriff am Oktober 27, 2025, [https://brychanthomas.home.blog/2019/12/02/creating-a-javascript-gravity-simulator-using-p5-js/](https://brychanthomas.home.blog/2019/12/02/creating-a-javascript-gravity-simulator-using-p5-js/)  
25. Gravity simulation \- p5.js Web Editor, Zugriff am Oktober 27, 2025, [https://editor.p5js.org/NC\_Productions/sketches/cccCwXioY](https://editor.p5js.org/NC_Productions/sketches/cccCwXioY)  
26. p5play, Zugriff am Oktober 27, 2025, [https://p5play.org/](https://p5play.org/)  
27. World \- p5play, Zugriff am Oktober 27, 2025, [https://p5play.org/learn/world](https://p5play.org/learn/world)  
28. Teach \- p5play, Zugriff am Oktober 27, 2025, [https://p5play.org/teach/](https://p5play.org/teach/)  
29. Interactive Physics Explorations and Sims \- p5.js Web Editor, Zugriff am Oktober 27, 2025, [https://editor.p5js.org/saigattupalli/collections/p8RTKTcdx](https://editor.p5js.org/saigattupalli/collections/p8RTKTcdx)  
30. Get Started \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/tutorials/get-started/](https://p5js.org/tutorials/get-started/)  
31. Coordinates and Transformations \- learn | p5.js, Zugriff am Oktober 27, 2025, [https://archive.p5js.org/learn/getting-started-in-webgl-coords-and-transform.html](https://archive.p5js.org/learn/getting-started-in-webgl-coords-and-transform.html)  
32. p5.Geometry \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/reference/p5/p5.Geometry/](https://p5js.org/reference/p5/p5.Geometry/)  
33. Download \- p5.js, Zugriff am Oktober 27, 2025, [https://p5js.org/download/](https://p5js.org/download/)  
34. Physics Simulations \- p5.js Web Editor, Zugriff am Oktober 27, 2025, [https://editor.p5js.org/brytlao/collections/m\_lJYnI48](https://editor.p5js.org/brytlao/collections/m_lJYnI48)