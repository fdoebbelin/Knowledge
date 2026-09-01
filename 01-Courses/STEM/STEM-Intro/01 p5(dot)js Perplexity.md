# Nutzung der p5.js Bibliothek für interaktive Lernumgebungen in einem MINT-Kurs:

- für das Mathematik-Modul
- für das Informatik-Modul
- für das Physik-Modul
- für das CAD-Modul
es soll ein interessanter Unterricht mit Quizfragen, Experimenten, Animationen und erklärenden Texten sowie Verweisen zu externen Quellen möglich sein.
Übersicht aller externen Ressourcen zu diesem Thema als Abschluss der Betrachtung

Ich habe umfassende Recherchen zu `p5.js` für interaktive MINT-Lernumgebungen durchgeführt. Lassen Sie mich nun eine strukturierte Übersicht für Sie erstellen.

# p5.js für interaktive MINT-Lernumgebungen

## Übersicht und Potenzial

p5.js ist eine JavaScript-Bibliothek für kreatives Programmieren, die sich hervorragend für interaktive Lernumgebungen in MINT-Kursen eignet. Die Bibliothek ermöglicht es, Animationen, Visualisierungen, Experimente und interaktive Inhalte direkt im Browser zu erstellen – ohne komplizierte Installation.[^1][^2][^3][^4]

## Mathematik-Modul

### Visualisierung mathematischer Konzepte

p5.js eignet sich ideal für die Visualisierung mathematischer Funktionen und Konzepte:[^5][^1]

**Funktionsgraphen**: Mit p5.js können Schüler mathematische Funktionen grafisch darstellen und in Echtzeit manipulieren. Die `map()`-Funktion ermöglicht die Umwandlung mathematischer Koordinatensysteme in Bildschirmkoordinaten.[^6][^7]

**Trigonometrie**: Sinus- und Kosinusfunktionen lassen sich animieren, um Wellenformen, Kreisbewegungen und Oszillationen zu visualisieren. Die Bibliothek bietet eingebaute Funktionen wie `sin()`, `cos()`, `tan()`, `asin()`, `acos()` und `atan()`.[^8][^9][^10]

**Geometrie**: Schüler können interaktive Konstruktionen erstellen, Transformationen (Translation, Rotation, Skalierung) visualisieren und geometrische Muster generieren.[^11][^12]

### Praktische Anwendungen

- **Graphing-Tool**: Erstellen eines interaktiven Funktionsplotters, bei dem Schüler Parameter verändern und sofort Ergebnisse sehen[^13][^6]
- **Parametrische Kurven**: Visualisierung von Lissajous-Figuren, Spiralen und anderen parametrischen Formen
- **Fraktale**: Rekursive Strukturen wie der Mandelbrot-Set oder rekursive Bäume[^14]
- **Vektorrechnung**: Darstellung von Vektoren, Vektoraddition und -multiplikation[^15]


## Informatik-Modul

### Programmierkonzepte

p5.js eignet sich perfekt für den Einstieg in die Programmierung:[^16][^17][^4]

**Grundlegende Konzepte**:

- Variablen und Datentypen
- Schleifen (`for`, `while`)
- Bedingungen (`if`, `else`)
- Funktionen und Parameter
- Arrays und Objekte
- Objektorientierte Programmierung (Klassen)[^18][^16]


### Algorithmisches Denken

Mit p5.js können klassische Algorithmen visualisiert werden:[^18]

- **Sortieralgorithmen**: Bubble Sort, Quick Sort mit visueller Animation
- **Suchalgorithmen**: Binäre Suche, A*-Pathfinding
- **Rekursion**: Visualisierung rekursiver Algorithmen wie dem Tower of Hanoi[^14]
- **Datenstrukturen**: Arrays, verkettete Listen, Bäume, Graphen[^18]


### Interaktive Projekte

Schüler können eigene interaktive Anwendungen entwickeln:[^19][^14]

- Spiele (Pong, Snake, Space Invaders)[^20]
- Simulationen (Conway's Game of Life, zelluläre Automaten)[^14]
- Datenvisualisierungen
- Interaktive Kunst und generatives Design[^21][^22]


### Quizfragen und Assessment

p5.js ermöglicht die Integration von Quiz-Elementen:[^23][^24]

- Multiple-Choice-Fragen mit visuellen Komponenten
- Drag-and-Drop-Aufgaben
- Code-Rätsel und Debugging-Übungen
- Interaktive Bewertungen mit sofortiger Rückmeldung[^23]


## Physik-Modul

### Physikalische Simulationen

p5.js bietet ausgezeichnete Möglichkeiten für physikalische Simulationen:[^25][^26][^27][^15]

**Grundlegende Mechanik**:

- **Kräfte und Bewegung**: Visualisierung von Newton'schen Gesetzen, Kraft = Masse × Beschleunigung[^28][^15]
- **Gravitation**: Simulation planetarischer Bewegungen und Gravitationsfelder[^27][^29][^30]
- **Kollisionen**: Elastische und inelastische Stöße zwischen Objekten[^31]
- **Reibung und Luftwiderstand**: Realistische Bewegungsmodellierung[^32][^28]

**Fortgeschrittene Konzepte**:

- **Pendel**: Einfache und doppelte Pendel, chaotische Systeme
- **Federschwingungen**: Harmonische Oszillatoren
- **Wellen**: Transversal- und Longitudinalwellen[^9][^33]
- **Optik**: Lichtbrechung, Reflexion, Interferenz


### Integration von Physics-Engines

Für komplexere Simulationen kann p5.js mit Physics-Libraries kombiniert werden:[^26][^15]

- **matter.js**: Realistische 2D-Physik mit Rigid-Body-Dynamik[^26]
- Kollisionserkennung
- Constraints und Verbindungen
- Weiche Körper (Soft Bodies)[^14]


### Interaktive Experimente

Schüler können Parameter in Echtzeit ändern und Experimente durchführen:[^34][^25]

- Gravitation an-/ausschalten
- Reibungskoeffizienten verändern
- Massen und Geschwindigkeiten anpassen
- Trajektorien beobachten und analysieren[^35][^34]


## CAD-Modul

### 3D-Visualisierung mit WebGL

p5.js unterstützt 3D-Grafik durch WebGL-Modus:[^36][^37][^38]

**3D-Grundformen**:

- `box()`, `sphere()`, `cylinder()`, `cone()`, `torus()`, `plane()`
- Benutzerdefinierte 3D-Geometrien mit `beginShape()` und `vertex()`[^39][^36][^11]

**3D-Transformationen**:

- `translate()`: Verschiebung im 3D-Raum
- `rotateX()`, `rotateY()`, `rotateZ()`: Rotation um Achsen[^37][^38][^40]
- `scale()`: Skalierung von Objekten[^38]

**3D-Modelle laden**:

- Import von OBJ- und STL-Dateien aus CAD-Software wie Blender[^41][^36]
- Texturierung und Material-Eigenschaften
- Beleuchtung mit `ambientLight()`, `directionalLight()`, `pointLight()`[^36]


### Interaktive 3D-Exploration

Mit `orbitControl()` können Schüler 3D-Modelle frei drehen und erkunden:[^41]

- Maus-basierte Kamerasteuerung
- Zoom-Funktionalität
- Perspektivische und orthografische Projektionen[^37]


### Parametrisches Design

p5.js eignet sich für prozedurales Modellieren:[^12][^36]

- Algorithmische Erzeugung von 3D-Formen
- Parametrische Oberflächen
- Geometrie-Generierung mit mathematischen Funktionen
- Export für 3D-Druck (STL-Format)


### CAD-ähnliche Funktionen

- **Technische Zeichnungen**: 2D-Darstellungen mit präzisen Maßen
- **Isometrische Ansichten**: Visualisierung von 3D-Objekten in 2D
- **Schnittstellen**: Darstellung von Querschnitten durch 3D-Modelle[^36]


## Didaktische Integration

### Kursstruktur

Ein erfolgreicher MINT-Kurs mit p5.js sollte folgende Elemente kombinieren:[^17][^42][^1]

**1. Erklärende Texte**:

- Theoretische Grundlagen in Markdown oder direkt im Code als Kommentare
- Schritt-für-Schritt-Anleitungen
- Referenzen zu externen Quellen[^2][^17]

**2. Animationen und Visualisierungen**:

- Dynamische Darstellungen komplexer Konzepte
- Interaktive Diagramme
- Zeitbasierte Simulationen[^1][^8]

**3. Experimente**:

- Manipulierbare Parameter (Slider, Buttons, Input-Felder)[^22][^43]
- Real-time Feedback
- Hypothesen testen und Ergebnisse beobachten[^44][^25]

**4. Quizfragen**:

- Interaktive Multiple-Choice-Fragen[^24][^23]
- Code-Vervollständigung
- Fehlersuche und Debugging-Aufgaben[^42]

**5. Externe Ressourcen**:

- Links zu Dokumentation und Tutorials
- Video-Tutorials einbetten
- Weiterführende Literatur[^45][^17]


### Plattformen für Unterricht

**p5.js Web Editor** (https://editor.p5js.org):[^3][^46]

- Keine Installation erforderlich
- Online-Speicherung von Projekten
- Einfaches Teilen von Sketches
- Integrierte Konsole und Debugger[^17][^2]

**OpenProcessing** (https://openprocessing.org):[^47][^48]

- Community-Plattform für kreatives Coding
- Kursverwaltung für Lehrer
- Kollektionen und Galerien
- Kommentar- und Feedback-Funktionen[^49][^2]

**CodeGuppy** (https://codeguppy.com):[^1]

- Speziell für Bildungszwecke entwickelt
- Integrierte Lernpfade
- Vereinfachte Syntax für Anfänger[^42][^1]


## Externe Ressourcen

### Offizielle Dokumentation und Referenzen

**p5.js Website** (https://p5js.org):[^4][^3]

- Vollständige Referenzdokumentation
- Tutorials für Anfänger und Fortgeschrittene
- Beispielgalerie mit Code[^50][^14]
- Community-Forum[^51][^52]

**p5.js Reference** (https://p5js.org/reference):[^53]

- Detaillierte Beschreibung aller Funktionen
- Code-Beispiele für jede Funktion
- Suchfunktion[^45]


### Video-Tutorials

**The Coding Train** von Daniel Shiffman (https://thecodingtrain.com):[^54][^55][^56]

- Umfassende Playlist für Anfänger "Code! Programming with p5.js"[^55][^57]
- Coding Challenges mit kreativen Projekten[^58][^31]
- Nature of Code - Physik-Simulationen[^15][^28][^54]
- Machine Learning mit ml5.js[^59][^60][^61]

**YouTube-Plattform**:

- Hunderte kostenloser Tutorials
- Schritt-für-Schritt-Anleitungen
- Live-Coding-Sessions[^62][^56]


### Bücher und Lernmaterialien

**"The Nature of Code"** von Daniel Shiffman (https://natureofcode.com):[^63][^64][^15]

- Physik-Simulationen und natürliche Systeme
- Partikel-Systeme, Kräfte, autonome Agenten
- Fraktale und zelluläre Automaten
- Komplett online verfügbar und open-source[^65][^15]

**"Generative Design"** von Benedikt Groß et al. (http://www.generative-gestaltung.de):[^66][^67][^68]

- Visualisierung, Programmierung und Kreation mit p5.js
- Kapitel zu Farbe, Form, Typografie und Bildern
- Kommerziell und künstlerisch orientierte Projekte
- Alle Code-Beispiele online verfügbar[^69][^68][^70]

**"Learning Processing"** von Daniel Shiffman:[^71][^17]

- Grundlagen der Programmierung
- Von einfachen Shapes bis zu komplexen Animationen
- Gut für Selbststudium geeignet[^2]

**"Getting Started with p5.js"** von Lauren McCarthy, Casey Reas und Ben Fry:[^17]

- Offizielle Einführung von den p5.js-Entwicklern
- Praktische Übungen und Projekte
- Kurzgefasst und anfängerfreundlich[^4]


### Online-Kurse und Lehrpläne

**NYC Dept of Education - CS4All** (https://nycdoe-cs4all.github.io):[^17]

- Kompletter Lehrplan für Computational Media
- Strukturierte Lernaktivitäten
- Projektbasierte Abschlüsse mit verschiedenen Schwierigkeitsgraden[^17]

**CodeHS - Digital Art with p5.js** (https://codehs.com):[^22]

- Strukturierter 20-stündiger Kurs
- Animationen und Interaktivität
- Quizze und Projekte[^22]

**Codecademy - Learn p5.js** (https://codecademy.com):[^21]

- Interaktive Lernplattform
- 9 Stunden Kursmaterial
- Zertifikat nach Abschluss[^21]


### Community und Support

**Processing Forum** (https://discourse.processing.org):[^51]

- Aktive Community für Fragen und Antworten
- Diskussionen über p5.js, Processing und verwandte Technologien
- Code-Sharing und Feedback[^72][^47]

**p5.js GitHub** (https://github.com/processing/p5.js):[^46][^73]

- Source Code und Entwicklung
- Issue-Tracking und Feature-Requests
- Contributions und Pull Requests[^74]

**Reddit Communities**:

- r/p5js - Spezifisch für p5.js-Projekte und Fragen[^47][^42]
- r/creativecoding - Breiter Fokus auf kreatives Coding[^75][^76]
- r/processing - Processing und p5.js Community[^47]


### Zusätzliche Bibliotheken und Erweiterungen

**p5.sound** (https://p5js.org/reference/\#/libraries/p5.sound):[^77][^78][^79]

- Audio-Eingabe, -Wiedergabe und -Analyse
- Sound-Synthese mit Oszillatoren
- FFT-Analyse für Visualisierungen[^80][^81]

**ml5.js** (https://ml5js.org):[^82][^83][^84][^59]

- Machine Learning für den Browser
- Bildklassifikation, Pose-Erkennung, Objekterkennung
- Neuronale Netze trainieren
- Integration mit p5.js[^60][^61]

**p5.play** (https://p5play.org):[^85]

- Sprite-basierte Spielentwicklung
- Physik-Kollisionen
- Animations-Management
- Speziell für Bildungszwecke entwickelt[^85]

**Matter.js** (https://brm.io/matter-js):[^26]

- 2D-Physik-Engine
- Realistische Körpersimulation
- Integration mit p5.js möglich[^26]


### Beispiel-Ressourcen und Inspiration

**OpenProcessing Galleries** (https://openprocessing.org):[^48][^47]

- Tausende Sketches zum Erkunden
- Filter nach Themen und Schwierigkeit
- Fork-Funktionalität zum Lernen durch Anpassen[^86][^2]

**p5.js Examples** (https://p5js.org/examples):[^14]

- Offizielle Beispiel-Galerie
- Kategorisiert nach Themen
- Von einfach bis fortgeschritten[^50]

**GitHub Repositories**:

- Viele Entwickler teilen ihre p5.js-Projekte
- Lernmaterialien für Kurse
- Spezifische Themen wie Physik-Simulationen[^87][^34][^35]


### Wissenschaftliche und didaktische Ressourcen

**Forschungspapiere**:

- Studien zur Effektivität von p5.js im Unterricht[^5]
- Vergleiche verschiedener Lernumgebungen
- Didaktische Konzepte für kreatives Coding[^44]

**Dynamic Learning** (https://dynamicland.org):[^44]

- Open-Source-Projekt für interaktive Visualisierungen im Unterricht
- Integration von Theorie und Praxis
- Community-getriebene Entwicklung[^44]


### Praktische Tools

**Map Explorer** (https://notes.osteele.com/p5js):[^88][^45]

- Interaktive Visualisierung der `map()`-Funktion
- Hilfreich für Anfänger zum Verständnis von Koordinatentransformationen[^45]

**p5.js Cheat Sheet**:

- Schnellreferenz für häufig verwendete Funktionen
- PDF zum Ausdrucken für den Unterricht[^45]


### Blogs und Artikel

**Happy Coding** (https://happycoding.io):[^2]

- Tutorials speziell für Lehrer
- Semesterplanung mit p5.js
- Tipps für den Unterricht[^2]

**Medium und Dev.to**:

- Artikel über spezifische Techniken
- Best Practices
- Projekt-Showcases[^89][^44]


## Zusammenfassung

p5.js bietet eine umfassende, zugängliche Plattform für interaktive MINT-Lernumgebungen. Die Kombination aus visuellen Outputs, sofortigem Feedback und der Möglichkeit, komplexe Konzepte spielerisch zu erkunden, macht es zu einem idealen Werkzeug für moderne MINT-Bildung.[^3][^4][^1]

Durch die Verbindung von erklärenden Texten, Animationen, interaktiven Experimenten und Quizfragen können Schüler mathematische, informatische, physikalische und CAD-bezogene Konzepte nicht nur verstehen, sondern auch praktisch anwenden und experimentell erforschen. Die große Anzahl verfügbarer Ressourcen – von offizieller Dokumentation über Video-Tutorials bis hin zu kompletten Kursmaterialien – ermöglicht es Lehrern, maßgeschneiderte Lernumgebungen zu schaffen, die den individuellen Bedürfnissen ihrer Schüler entsprechen.[^57][^54][^42][^4][^44][^17]
<span style="display:none">[^100][^101][^102][^103][^104][^105][^106][^107][^108][^109][^110][^111][^112][^113][^114][^115][^90][^91][^92][^93][^94][^95][^96][^97][^98][^99]</span>

<div align="center">⁂</div>

[^1]: https://codeguppy.com/blog/p5.js-in-the-classroom/index.html

[^2]: https://happycoding.io/teaching/guides/semester

[^3]: https://p5js.org

[^4]: https://www.tynker.com/blog/exploring-the-power-of-p5-js-a-beginners-guide/

[^5]: https://www.diva-portal.org/smash/get/diva2:1779198/FULLTEXT01.pdf

[^6]: https://www.youtube.com/watch?v=Q9Gje2vh22Q

[^7]: https://editor.p5js.org/EspritOrgue/sketches/B-yx9jbfY

[^8]: https://blog.logrocket.com/creating-animations-p5-js/

[^9]: https://www.geeksforgeeks.org/javascript/how-to-create-animation-of-sine-wave-pattern-using-p5-js/

[^10]: https://p5js.org/examples/angles-and-motion-sine-cosine/

[^11]: https://p5js.org/examples/3d-geometries/

[^12]: https://www.youtube.com/playlist?list=PLRD0f8kJKduISKaiBZzWsMqsAzw9qzSNE

[^13]: https://stackoverflow.com/questions/60126095/mathematical-functions-in-p5-js

[^14]: https://p5js.org/examples/

[^15]: https://natureofcode.com/introduction/

[^16]: https://codetolearn.tiged.org/principles/assignments/folder/4119

[^17]: https://nycdoe-cs4all.github.io

[^18]: https://codeguppy.com/blog/8-computer-science-algorithms-you-can-implement-in-javascript/index.html

[^19]: https://eli.thegreenplace.net/2025/teaching-coding-with-javascript-and-p5js/

[^20]: https://www.youtube.com/watch?v=biN3v3ef-Y0

[^21]: https://www.codecademy.com/learn/learn-p5js

[^22]: https://codehs.com/course/p5-js/overview

[^23]: https://www.youtube.com/watch?v=3pI3SQjfVyA

[^24]: https://take.quiz-maker.com/QJIT3Z17U

[^25]: https://www.reddit.com/r/p5js/comments/o7zlku/i_created_a_website_with_physics_simulations_done/

[^26]: https://www.youtube.com/watch?v=cLXNxn5N-2Y

[^27]: https://grapheo12.in/tech/gravity-simulation

[^28]: https://natureofcode.com/forces/

[^29]: https://conicsectionsare.cool/researchPages/14lilliaSimulationP5js.html

[^30]: https://brychanthomas.home.blog/2019/12/02/creating-a-javascript-gravity-simulator-using-p5-js/

[^31]: https://thecodingtrain.com/challenges/

[^32]: https://p5js.org/examples/math-and-physics-forces/

[^33]: https://www.youtube.com/watch?v=JLAc9hMtcxk

[^34]: https://editor.p5js.org/saigattupalli/collections/p8RTKTcdx

[^35]: https://github.com/vislupus/p5-simulations

[^36]: https://p5js.org/tutorials/custom-geometry/

[^37]: https://p5js.jp/learn/getting-started-in-webgl-coords-and-transform

[^38]: https://p5js.org/tutorials/coordinates-and-transformations/

[^39]: https://www.youtube.com/watch?v=DZlw-IS5OkI

[^40]: https://p5js.org/reference/p5/rotate/

[^41]: https://parth3d.co.uk/interactive-3d-models-in-a-web-page-using-p5-js

[^42]: https://www.reddit.com/r/p5js/comments/za8sze/is_anybody_using_p5js_in_the_classroom/

[^43]: https://www.codecademy.com/learn/learn-p5js-interaction

[^44]: https://dev.to/jithinks/dynamic-learning-an-open-source-tool-to-teach-effectively-using-interactive-visualisations-450n

[^45]: https://notes.osteele.com/p5js

[^46]: https://github.com/processing/p5.js/wiki/p5.js-overview

[^47]: https://www.reddit.com/r/processing/comments/svrp86/new_what_do_i_learn_processing_or_p5js/

[^48]: https://openprocessing.org

[^49]: https://openprocessing.org/class/56049/

[^50]: https://p5js.org/tutorials/

[^51]: https://discourse.processing.org

[^52]: https://p5js.org/community/

[^53]: https://p5js.org/reference/

[^54]: https://thecodingtrain.com

[^55]: https://www.youtube.com/watch?v=HerCR8bw_GE

[^56]: https://www.youtube.com/thecodingtrain

[^57]: https://thecodingtrain.com/tracks/code-programming-with-p5-js/

[^58]: https://www.youtube.com/watch?v=E4RyStef-gY

[^59]: https://github.com/ml5js/ml5-friendly-intro-to-ml-2019f

[^60]: https://www.youtube.com/watch?v=26uABexmOX4

[^61]: https://thecodingtrain.com/tracks/ml5js-beginners-guide/

[^62]: https://www.youtube.com/watch?v=mrAeK43YDgw

[^63]: https://natureofcode.com

[^64]: https://nostarch.com/nature-code

[^65]: https://thecodingtrain.com/tracks/the-nature-of-code-2/

[^66]: https://www.barnesandnoble.com/w/generative-design-benedikt-gross/1127934156

[^67]: https://books.google.com/books/about/Generative_Design.html?id=GuyVswEACAAJ

[^68]: https://benedikt-gross.de/projects/generative-design-visualize-program-create-with-javascript-in-p5-js/

[^69]: https://bronxriverbooks.com/book/9781616897581

[^70]: https://www.goodreads.com/book/show/38743103-generative-design

[^71]: https://www.cs.cmu.edu/~15104/resources/resource1.html

[^72]: https://forum.processing.org/two/discussion/27695/looking-for-help-p5-js.html

[^73]: https://github.com/processing/p5.js/wiki

[^74]: https://github.com/processing/p5.js-web-editor/discussions

[^75]: https://www.reddit.com/r/creativecoding/comments/zimpqx/simple_and_interesting_examples_with_p5js_to/

[^76]: https://www.reddit.com/r/creativecoding/comments/134ooog/i_made_an_app_that_turns_text_into_p5js_code/

[^77]: https://www.youtube.com/watch?v=Pn1g1wjxl_0

[^78]: https://medium.spatialpixel.com/sounds-bd05429aba38

[^79]: https://p5js.org/reference/p5.sound/

[^80]: https://www.youtube.com/watch?v=Bk8rLzzSink

[^81]: https://www.youtube.com/watch?v=-VcypODGBUc

[^82]: https://www.w3.org/2020/Talks/mlws/ys_ml5.pdf

[^83]: https://ml5js.org/learn/

[^84]: https://ml5js.org

[^85]: https://p5play.org

[^86]: https://www.youtube.com/watch?v=vNjobQiQZns

[^87]: https://github.com/shiffman/The-Nature-of-Code-Examples-p5.js/

[^88]: https://notes.osteele.com/p5js-resources

[^89]: https://dev.to/christiankastner/p5-js-when-styling-and-math-meets-art-f6j

[^90]: https://p5js.org/education-resources/

[^91]: https://www.youtube.com/watch?v=zmWDzJWmmUY

[^92]: https://www.youtube.com/watch?v=B3Xe3VGxYy0

[^93]: https://www.youtube.com/playlist?list=PLueqWd9Qy25h33uzNYtDbWeKP-c50tlkg

[^94]: https://www.youtube.com/watch?v=o5t7PxRJSXk

[^95]: https://www.youtube.com/watch?v=6TPVoB4uQCU

[^96]: https://www.reddit.com/r/CSEducation/comments/128s9x3/a_free_p5jsbased_environment_for_middle_and_high/

[^97]: https://wayground.com/admin/quiz/625f10010683c3001deb393b/p5js-intermediate

[^98]: https://www.youtube.com/watch?v=HJ7D0ysUL74

[^99]: https://wayground.com/admin/quiz/65e6f7d5286571a57e2a18a6/p5js-test-1-review

[^100]: https://editor.p5js.org/jeon11/sketches/Y_nPA3X8w

[^101]: https://www.youtube.com/watch?v=D1ELEeIs0j8

[^102]: https://www.youtube.com/watch?v=W0L3gGNZbPw

[^103]: https://www.gorillasun.de/blog/continuous-oscillating-motion-in-p5js-with-sine-functions/

[^104]: https://www.youtube.com/watch?v=qWIcAWYm-aU

[^105]: https://www.geeksforgeeks.org/javascript/p5-js-shape-complete-reference/

[^106]: https://beta.p5js.org/examples/angles-and-motion-sine-cosine/

[^107]: https://www.youtube.com/watch?v=OkkjlHTdLGI

[^108]: https://computethought.blog/2020/11/15/coding-with-p5js/

[^109]: http://makeyourownalgorithmicart.blogspot.com/2018/03/p5-simplejs.html

[^110]: https://www.youtube.com/watch?v=-UX74Oe72zU

[^111]: https://news.ycombinator.com/item?id=33176026

[^112]: https://codehs.com/tutorial/8914

[^113]: https://editor.p5js.org/joel.janson.johansen/sketches/hfitm52uq

[^114]: https://www.reddit.com/r/p5js/comments/1e7yunw/an_easy_way_to_host_sketches_and_interactive/

[^115]: https://www.youtube.com/watch?v=Fbzqfsy5GnM

