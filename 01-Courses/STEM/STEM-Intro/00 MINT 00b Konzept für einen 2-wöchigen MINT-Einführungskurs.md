## Überblick und pädagogische Philosophie

Der vorliegende Kurs verbindet alle vier MINT-Bereiche in einer **progressiv aufbauenden Struktur**, die Informatik als **integrierende Querschnittskompetenz** in den Mittelpunkt stellt. Die Lernenden durchlaufen eine Reise von mathematischen Grundlagen über informatische Werkzeuge zu naturwissenschaftlichen Anwendungen bis hin zur technischen Konstruktion – alles in einer **interaktiven, browserbasierten Lernumgebung** mit JupyterLab und p5.js.[^4_1][^4_2][^4_3][^4_4][^4_5]

Die Didaktik folgt dem **projektbasierten, interdisziplinären Ansatz** der modernen MINT-Bildung, wobei jeder Bereich auf dem vorherigen aufbaut und die praktische Anwendbarkeit durch virtuelle Experimente und interaktive Visualisierungen im Vordergrund steht.[^4_6][^4_7][^4_5][^4_8][^4_9][^4_10]

## Kursstruktur: 80 Unterrichtseinheiten (UE) über 2 Wochen

### Woche 1: Mathematische Grundlagen und Informatik als Werkzeug

#### Block 1: Mathematik (16 UE) – Tage 1-2

**Lernziele**: Vermittlung grundlegender mathematischer Konzepte mit starkem Fokus auf Visualisierung und praktischer Anwendbarkeit.

**Tag 1: Funktionen und ihre Visualisierung (8 UE)**

- **Einheit 1-2**: Einführung in mathematische Funktionen
    - Lineare, quadratische und trigonometrische Funktionen
    - Interaktive Visualisierung mit Python matplotlib in JupyterLab[^4_11][^4_12]
    - Schüler erstellen erste Plots von Funktionen mit variierbaren Parametern
    - **Material**: Video-Tutorials zur Funktionstheorie, eingebettete YouTube-Videos in Jupyter Notebooks[^4_13][^4_14]
- **Einheit 3-4**: Vektoren und geometrische Transformationen
    - 2D-Vektoren: Addition, Skalarmultiplikation
    - Geometrische Transformationen: Translation, Rotation, Skalierung
    - Visualisierung mit Python (NumPy + Matplotlib)[^4_15][^4_11]
    - **Interaktive Elemente**: Jupyter Widgets zum Experimentieren mit Transformationsparametern[^4_16][^4_17]
- **Einheit 5-6**: Koordinatensysteme und räumliches Denken
    - Kartesische, polare und parametrische Koordinaten
    - 3D-Koordinatensysteme und Projektionen
    - Interaktive 3D-Plots mit Python[^4_16]
- **Einheit 7-8**: Mathematik in Bewegung
    - Parametrisierte Kurven und Bewegungsgleichungen
    - Geschwindigkeit und Beschleunigung als Ableitungen
    - Vorbereitung für Physik-Simulationen[^4_18][^4_19]

**Tag 2: Algorithmisches Denken und diskrete Mathematik (8 UE)**

- **Einheit 9-10**: Sequenzen, Reihen und Rekursion
    - Fibonacci-Folge, geometrische Reihen
    - Visualisierung rekursiver Strukturen[^4_20]
    - Einführung in algorithmisches Denken
- **Einheit 11-12**: Wahrscheinlichkeit und Statistik
    - Grundlagen der Wahrscheinlichkeitsrechnung
    - Visualisierung von Verteilungen
    - Monte-Carlo-Simulationen als Brücke zur Informatik
- **Einheit 13-14**: Matrizen und lineare Transformationen
    - Matrixoperationen
    - Lineare Transformationen als Vorbereitung für 3D-Grafik
    - Anwendung in Computer-Grafik
- **Einheit 15-16**: Projektarbeit Mathematik
    - Schüler erstellen eigene interaktive mathematische Visualisierung
    - Präsentation und Diskussion


#### Block 2: Informatik (32 UE) – Tage 3-6

**Lernziele**: Aufbau von Programmierkompetenz und computational thinking als Grundlage für alle weiteren MINT-Bereiche.[^4_21][^4_22][^4_23]

**Tag 3: Python-Grundlagen in JupyterLab (8 UE)**

- **Einheit 17-18**: Einführung in JupyterLab und Python
    - Navigation in JupyterLab-Interface[^4_24][^4_3]
    - Variablen, Datentypen, Operatoren
    - Code-Zellen, Markdown-Zellen, Dokumentation
    - **Video-Tutorial**: "Getting Started with JupyterLab"[^4_25][^4_13]
- **Einheit 19-20**: Kontrollstrukturen
    - Bedingungen (if/elif/else)
    - Schleifen (for, while)
    - Praktische Übungen mit mathematischen Problemen
- **Einheit 21-22**: Funktionen und Modularität
    - Funktionsdefinition, Parameter, Rückgabewerte
    - Scope und Namespaces
    - Wiederverwendbarer Code
- **Einheit 23-24**: Datenstrukturen
    - Listen, Tupel, Dictionaries
    - List comprehensions
    - Anwendung auf mathematische Datensätze

**Tag 4: Visualisierung und interaktive Programmierung (8 UE)**

- **Einheit 25-26**: Matplotlib und Seaborn
    - Plotting-Grundlagen
    - Subplots, Achsenbeschriftung, Legenden
    - Styling und professionelle Visualisierungen[^4_12][^4_11]
- **Einheit 27-28**: Interaktive Widgets in Jupyter
    - ipywidgets: Slider, Buttons, Dropdown-Menüs[^4_17][^4_16]
    - Interactive plotting mit @interact decorator
    - Echtzeit-Parametervariation
- **Einheit 29-30**: NumPy für wissenschaftliches Rechnen
    - Arrays und Array-Operationen
    - Mathematische Funktionen
    - Broadcasting und Vektorisierung
- **Einheit 31-32**: Einführung in p5.js
    - p5.js-Grundlagen: setup() und draw()
    - Canvas und Koordinatensystem
    - Einfache Formen zeichnen[^4_26][^4_27]
    - **Integration**: p5.js in JupyterLab mit p5-kernel[^4_28][^4_29][^4_17]

**Tag 5: p5.js für Animation und Interaktion (8 UE)**

- **Einheit 33-34**: Animation in p5.js
    - Bewegung und Geschwindigkeit
    - frame-basierte Animation
    - Interaktive Beispiele[^4_19][^4_26]
- **Einheit 35-36**: Vektorrechnung in p5.js
    - p5.Vector-Klasse
    - Vektoroperationen visuell
    - Anwendung auf Bewegung
- **Einheit 37-38**: Interaktivität und Events
    - Mouse- und Keyboard-Events
    - Interaktive Sketches
    - User-Input verarbeiten
- **Einheit 39-40**: Objektorientierte Programmierung (OOP)
    - Klassen und Objekte in JavaScript
    - Partikel-Systeme als Beispiel
    - Vorbereitung für Physik-Simulationen[^4_19]

**Tag 6: Algorithmen und Problemlösung (8 UE)**

- **Einheit 41-42**: Algorithmisches Denken
    - Dekomposition, Mustererkennung, Abstraktion[^4_23][^4_30][^4_31]
    - Sortier- und Such-Algorithmen
    - Visualisierung von Algorithmen
- **Einheit 43-44**: Computational Thinking Projekt
    - Schüler lösen ein komplexes Problem schrittweise
    - Implementierung in Python oder p5.js
    - Peer-Review
- **Einheit 45-46**: Datenanalyse-Grundlagen
    - CSV-Dateien einlesen und verarbeiten
    - Einfache statistische Auswertungen
    - Visualisierung von Datensätzen
- **Einheit 47-48**: Mini-Projekt: Interaktive Datenvisualisierung
    - Schüler erstellen Dashboard mit interaktiven Plots
    - Kombination aller bisherigen Kenntnisse
    - Präsentation


### Woche 2: Naturwissenschaftliche Anwendungen und technische Konstruktion

#### Block 3: Physik (16 UE) – Tage 7-8

**Lernziele**: Physikalische Konzepte durch **virtuelle Experimente und Simulationen** erlebbar machen.[^4_7][^4_8][^4_10][^4_32]

**Tag 7: Mechanik und Bewegung (8 UE)**

- **Einheit 49-50**: Kinematik – Bewegung beschreiben
    - Position, Geschwindigkeit, Beschleunigung
    - Gleichförmige und beschleunigte Bewegung
    - **Virtuelles Experiment**: Interaktive Simulation in p5.js[^4_33][^4_26][^4_19]
    - **Video**: Animierte Erklärungen zur Kinematik
- **Einheit 51-52**: Newtonsche Mechanik
    - Kräfte und Masse
    - Newtons Bewegungsgesetze
    - **Simulation**: Ball-Wurf mit Schwerkraft und Luftwiderstand[^4_19]
    - Interaktive Parameter: Masse, Anfangsgeschwindigkeit, Winkel
- **Einheit 53-54**: Kollisionen und Impulserhaltung
    - Elastische und inelastische Stöße
    - Impulserhaltungssatz
    - **Virtuelle Experiment**: Kollisions-Simulator mit p5.js[^4_33][^4_19]
    - Schüler variieren Parameter und beobachten Auswirkungen
- **Einheit 55-56**: Energie und Energieerhaltung
    - Kinetische und potenzielle Energie
    - Energieerhaltungssatz
    - **Simulation**: Pendel und Achterbahn-Modelle
    - Visualisierung von Energieumwandlungen

**Tag 8: Wellen, Felder und fortgeschrittene Konzepte (8 UE)**

- **Einheit 57-58**: Schwingungen und Wellen
    - Harmonische Schwingungen
    - Wellenausbreitung
    - **Simulation**: Federpendel und Wellensimulator[^4_34]
    - **PhET-Integration**: Nutzung von PhET-Simulationen in Jupyter[^4_34]
- **Einheit 59-60**: Elektrische Felder
    - Ladungen und elektrische Feldlinien
    - **Virtuelles Experiment**: Elektronenablenkröhre[^4_10][^4_32][^4_35]
    - Interaktive Steuerung von Spannung und Magnetfeld
    - Plattform: virtuelle-experimente.de als Ressource[^4_32][^4_35]
- **Einheit 61-62**: Optik und Licht
    - Reflexion, Brechung, Beugung
    - **Simulation**: Strahlenoptik und Linsen
    - Ray-Tracing-Simulation in p5.js
- **Einheit 63-64**: Physik-Projekt
    - Schüler entwickeln eigene Physiksimulation
    - Kombination mehrerer physikalischer Konzepte
    - Dokumentation und Präsentation


#### Block 4: CAD – Konstruktion und Design (16 UE) – Tage 9-10

**Lernziele**: Einführung in **3D-Konstruktion als praktische Anwendung** von Mathematik und Informatik.[^4_2][^4_36][^4_1]

**Tag 9: JupyterCAD – 3D-Modellierung im Browser (8 UE)**

- **Einheit 65-66**: Einführung in JupyterCAD
    - Installation und Setup: jupytercad und jupytercad-freecad[^4_37][^4_1][^4_2]
    - JupyterCAD-Interface in JupyterLab
    - Grundformen: Würfel, Zylinder, Kugel[^4_1][^4_2]
    - **Video-Tutorial**: "Getting Started with JupyterCAD"
- **Einheit 67-68**: Transformationen und Boolean-Operationen
    - Position, Rotation, Skalierung von Objekten
    - Union, Difference, Intersection[^4_2][^4_1]
    - Praktische Übung: Einfache Objekte modellieren
- **Einheit 69-70**: Python API für CAD
    - Programmatische Erstellung von 3D-Objekten[^4_2]
    - Parametrisches Design mit Python
    - Generierung von Objektserien mit Schleifen
- **Einheit 71-72**: Projekt: Parametrisches Designobjekt
    - Schüler erstellen ein parametrisch kontrollierbares 3D-Objekt
    - Integration mit Jupyter Widgets für interaktive Parameter
    - Export als .FCStd (FreeCAD-Format)

**Tag 10: FreeCAD – Professionelle CAD-Software (8 UE)**

- **Einheit 73-74**: Einführung in FreeCAD
    - FreeCAD-Interface und Workbenches[^4_38][^4_39][^4_40]
    - Part Design Workbench
    - Sketcher: 2D-Skizzen als Basis für 3D-Körper
    - **Video-Tutorial**: FreeCAD-Grundlagen für Einsteiger
- **Einheit 75-76**: Von 2D zu 3D
    - Extrusion (Pad), Revolution
    - Pockets und Holes
    - Praktische Übung: Mechanisches Bauteil modellieren
- **Einheit 77-78**: Integration: JupyterCAD ↔ FreeCAD
    - Import/Export zwischen JupyterCAD und FreeCAD[^4_41][^4_42][^4_37][^4_1]
    - Workflow: Parametrisches Design in Jupyter, Feinbearbeitung in FreeCAD
    - Collaborative Editing-Features von JupyterCAD[^4_36][^4_2]
- **Einheit 79-80**: Abschlussprojekt: MINT-Gesamtprojekt
    - **Aufgabe**: Konstruktion eines physikalischen Objekts (z.B. einfacher Mechanismus)
    - Mathematische Berechnung der Dimensionen (Mathematik)
    - Simulation der Bewegung in p5.js (Informatik + Physik)
    - 3D-Konstruktion in JupyterCAD/FreeCAD (Technik)
    - Präsentation aller vier MINT-Bereiche integriert


## Technische Infrastruktur und Lernumgebung

### JupyterLab als zentrale Plattform

**Setup und Installation**:

- JupyterLab 4.x als Basis[^4_36][^4_1][^4_2]
- Python-Kernel mit wissenschaftlichen Bibliotheken: numpy, matplotlib, seaborn, scipy, ipywidgets[^4_3][^4_16]
- JupyterCAD Extension für 3D-Modellierung[^4_37][^4_1][^4_2]
- p5.js Kernel für JupyterLite[^4_29][^4_28][^4_17]

**Vorteile dieser Umgebung**:

- Alles im Browser, keine lokale Installation für Schüler nötig[^4_3][^4_17]
- Code, Dokumentation, Visualisierungen und 3D-Modelle in einem Dokument[^4_3]
- Kollaboratives Arbeiten möglich[^4_36][^4_2]
- Interaktive Widgets für explorative Lernansätze[^4_17][^4_16]


### Multimedia-Integration

**Video-Einbettung**:

- YouTube-Videos direkt in Jupyter Notebooks eingebettet[^4_14][^4_13]
- Video-Tutorials zu jedem Hauptthema
- Kurze Erklärvideos (5-10 Minuten) für Konzepte
- HTML-iframe-Integration für externe Ressourcen[^4_13]

**Schaubilder und Diagramme**:

- Statische Infografiken in Markdown-Zellen
- Animierte Diagramme mit matplotlib animations
- Interaktive Plots mit ipywidgets[^4_16]
- 3D-Visualisierungen mit pythreejs oder plotly


### Empfohlene externe Ressourcen

- **PhET Interactive Simulations**: Ergänzende Physik-Experimente[^4_34]
- **virtuelle-experimente.de**: Spezifische Experimente zu Elektronen in Feldern[^4_35][^4_10][^4_32]
- **p5.js Examples**: Community-Sketches als Inspiration[^4_27][^4_33]
- **FreeCAD Wiki**: Detaillierte Anleitungen für fortgeschrittene CAD-Techniken


## Didaktische Prinzipien

### Progressiver Aufbau und Scaffolding

Jeder Block baut systematisch auf dem vorherigen auf:

1. **Mathematik** liefert die konzeptionellen Grundlagen
2. **Informatik** stellt Werkzeuge zur Verfügung, um mathematische Konzepte zu implementieren
3. **Physik** wendet Mathematik und Informatik an, um reale Phänomene zu simulieren
4. **CAD/Technik** nutzt alle drei Bereiche zur Konstruktion realer Objekte

### Inquiry-Based Learning

Schüler experimentieren selbstständig mit virtuellen Experimenten:[^4_5][^4_7][^4_32]

- Parameter variieren und Auswirkungen beobachten
- Hypothesen aufstellen und testen
- Eigene Fragestellungen entwickeln


### Projektbasiertes Lernen

Jeder Block endet mit einem Projekt:[^4_9][^4_6]

- Anwendung aller gelernten Konzepte
- Kreative Problemlösung
- Präsentation und Peer-Feedback


### Interaktivität als Kern

Statisches Lernen wird durch interaktive Elemente ersetzt:[^4_17][^4_16]

- Jupyter Widgets für Echtzeit-Parametervariation
- p5.js Sketches für explorative Visualisierungen
- JupyterCAD für hands-on 3D-Modellierung


## Bewertung und Lernkontrolle

### Formative Assessment

- Tägliche Kurzaufgaben in Jupyter Notebooks
- Peer-Review von Code und Projekten
- Selbstreflexion durch Markdown-Dokumentation


### Summative Assessment

- Vier Blockprojekte (Mathematik, Informatik, Physik, CAD)
- Abschlussprojekt: Integration aller vier MINT-Bereiche
- Portfolio: Sammlung aller Jupyter Notebooks


### Kompetenzmessung

- **Computational Thinking**: Fähigkeit zur Problemzerlegung und algorithmischen Lösung[^4_31][^4_21][^4_23]
- **Mathematisches Modellieren**: Abstraktion realer Probleme in mathematische Modelle
- **Physikalisches Verständnis**: Anwendung von Konzepten auf virtuelle Experimente
- **Technisches Design**: Konstruktion funktionaler 3D-Objekte


## Differenzierung und Individualisierung

### Für fortgeschrittene Lernende

- Erweiterte Aufgaben in jedem Block
- Freie Projektarbeit mit höherem Komplexitätsgrad
- Mentoring-Rolle für Mitschüler


### Für Lernende mit Unterstützungsbedarf

- Zusätzliche Video-Tutorials mit Step-by-Step-Anleitungen
- Vorbereitete Code-Templates zum Ausfüllen
- Kleinschrittige Aufgaben mit mehr Feedback


### Adaptive Lernpfade

- JupyterLab ermöglicht individuelle Lerngeschwindigkeit
- Lernende können Bereiche wiederholen oder überspringen
- Selbstgesteuertes Lernen mit strukturierten Notebooks


## Lehrkräfte-Materialien

### Für jede Einheit bereitgestellt

- Vollständige Jupyter Notebooks mit Lösungen
- Video-Tutorial-Links (kuriert oder selbst erstellt)
- Didaktische Hinweise und typische Fehlerquellen
- Zeitmanagement-Empfehlungen


### Technische Dokumentation

- JupyterLab-Setup-Anleitung für Schulserver
- JupyterHub-Deployment für Multi-User-Umgebungen
- Troubleshooting-Guide


### Fortbildungsempfehlungen

- Online-Kurse zu JupyterLab und wissenschaftlichem Python
- p5.js-Tutorials für Lehrkräfte ohne JavaScript-Hintergrund
- FreeCAD/JupyterCAD-Einführungskurse


## Ausblick und Erweiterungsmöglichkeiten

### Nach dem Kurs

- Vertiefungskurse in einzelnen MINT-Bereichen
- Integration von maschinellem Lernen (scikit-learn)
- Erweiterte Physik-Simulationen (Matter.js Physics Engine)[^4_19]
- Komplexe CAD-Projekte mit Assemblies und Simulationen


### Community und Open Source

- Veröffentlichung der Jupyter Notebooks als Open Educational Resources
- GitHub-Repository für Materialien
- Austausch mit internationaler Jupyter-Education-Community[^4_24][^4_3]


## Zusammenfassung

Dieses Kurskonzept realisiert einen **interdisziplinären, projektbasierten MINT-Unterricht**, der Informatik als **integrierende Querschnittskompetenz** nutzt. Die Kombination aus JupyterLab als einheitlicher Lernplattform, p5.js für interaktive Visualisierungen und Simulationen sowie JupyterCAD/FreeCAD für 3D-Konstruktion schafft eine **moderne, browserbasierte Lernumgebung**, die alle vier MINT-Bereiche nahtlos verbindet.[^4_4][^4_6][^4_5][^4_1][^4_2][^4_3][^4_17]

Durch den starken Fokus auf **virtuelle Experimente**, **interaktive Widgets** und **multimediale Inhalte** wird selbstgesteuertes, exploratives Lernen ermöglicht. Die schrittweise Progression von mathematischen Grundlagen über informatische Werkzeuge zu naturwissenschaftlichen Anwendungen und technischer Konstruktion macht die **Vernetzung der MINT-Disziplinen** für Lernende konkret erfahrbar.[^4_43][^4_4][^4_7][^4_5][^4_10][^4_32][^4_13][^4_16][^4_17]
<span style="display:none">[^4_44][^4_45][^4_46][^4_47][^4_48][^4_49][^4_50][^4_51][^4_52][^4_53][^4_54][^4_55][^4_56][^4_57][^4_58][^4_59][^4_60][^4_61][^4_62][^4_63][^4_64][^4_65]</span>

<div align="center">⁂</div>

[^4_1]: https://jupytercad.readthedocs.io

[^4_2]: https://blog.jupyter.org/collaborative-cad-in-jupyterlab-8eb9e8f81f0

[^4_3]: https://datascience.101workbook.org/04-devel-environment/02f-python-jupyter-notebook/

[^4_4]: https://www.stifterverband.org/medien/interdisziplinaere-mint-formate-in-der-hochschule

[^4_5]: https://www.bbaw.de/files-bbaw/publikationen/stellungnahmen-empfehlungen/Stellungnahme_BBAW_MINT.pdf

[^4_6]: https://www.cornelsen.de/magazin/beitraege/lernstationen-mint-unterricht

[^4_7]: https://pro-physik.de/nachrichten/online-experimentieren

[^4_8]: https://lernen.digital/zukunftsraum-beitrag/sichtbar-wie-virtual-reality-im-physikunterricht-beim-verstehen-hilft/

[^4_9]: https://www.robotimeonline.com/de-de/blogs/all-blogs/what-is-stem-education-and-why-students-need-it-today

[^4_10]: https://www.didaktik.physik.uni-muenchen.de/multimedia/elektronenablenkroehre/index.html

[^4_11]: https://geniusjournals.org/index.php/erb/article/download/6040/5040/6037

[^4_12]: https://www.understandthemath.com/blog/math-modeling-python

[^4_13]: https://teachbooks.io/manual/basic-features/videos.html

[^4_14]: https://stackoverflow.com/questions/72007931/can-you-embed-a-youtube-video-in-a-jupyter-notebook

[^4_15]: https://www.reddit.com/r/learnmath/comments/10fav3p/easily_visualize_mathematical_concepts_with/

[^4_16]: https://www.geeksforgeeks.org/data-science/interactive-controls-in-jupyter-notebooks/

[^4_17]: https://blog.jupyter.org/jupyterlite-jupyter-️-webassembly-️-python-f6e2e41ab3fa

[^4_18]: https://www.diva-portal.org/smash/get/diva2:1779198/FULLTEXT01.pdf

[^4_19]: https://natureofcode.com/physics-libraries/

[^4_20]: https://jtp.io/blog/p5js-jupyter-notebook-widgets/

[^4_21]: https://digid.jff.de/digid_paper/computational-thinking-vermitteln-wie-problemloesekompetenz-als-bestandteil-digitaler-souveraenitaet-erworben-werden-kann/

[^4_22]: https://deutschdidaktik.germanistik.uni-halle.de/digitale-didaktik-computational-thinking/

[^4_23]: https://oinf.ch/konzept/computational-thinking/

[^4_24]: https://skills.network/lab-tools/jupyterlab

[^4_25]: https://www.youtube.com/watch?v=7wfPqAyYADY

[^4_26]: https://www.youtube.com/watch?v=Mg9Alcygelc

[^4_27]: https://p5js.org/education-resources/

[^4_28]: https://github.com/jtpio/p5-notebook

[^4_29]: https://pypi.org/project/jupyterlite-p5-kernel/

[^4_30]: https://ki-berufsausbildung.de/wp-content/uploads/2022/07/CT_Grundlagen_Anleitung.pdf

[^4_31]: https://edumedia.lu/computational-thinking-acht-kompetenzen/

[^4_32]: https://virtuelle-experimente.de/lehrer/ideen.php

[^4_33]: https://editor.p5js.org/saigattupalli/collections/p8RTKTcdx

[^4_34]: https://phet.colorado.edu/de/

[^4_35]: https://virtuelle-experimente.de/index.php

[^4_36]: https://blog.jupyter.org/announcing-jupytercad-3-0-d8f4b7b0a719

[^4_37]: https://pypi.org/project/jupytercad-freecad/

[^4_38]: https://www.ibb.com/weiterbildung/autocad-einfuehrung

[^4_39]: https://www.educadion.de/training/seminare/cad-kurs-cad-schulung-cad-lehrgang.html

[^4_40]: https://www.kursfinder.de/suche/cad-berlin/c1642-d85965

[^4_41]: https://github.com/jupytercad/JupyterCAD

[^4_42]: https://forum.freecad.org/viewtopic.php?style=10\&t=94903

[^4_43]: https://www.conceptk.org/mint/

[^4_44]: https://kryptokommun.ist/tech/2020/08/31/google-summer-of-code.html

[^4_45]: https://forum.makerforums.info/t/jupytercad/92083

[^4_46]: https://sites.temple.edu/vahid/2021/12/25/interactive-plots-in-jupyterlab/

[^4_47]: https://github.com/jupytercad

[^4_48]: https://www.reddit.com/r/javascript/comments/odbrfy/i_studied_for_physics_exams_by_programming/

[^4_49]: https://discourse.jupyter.org/t/jupyter-notebook-on-mint-22-1/35114

[^4_50]: https://www.siemens-stiftung.org/stiftung/bildung/

[^4_51]: https://technopolis-group.com/de/report/interdisziplinaere-mint-formate-in-der-hochschule-was-kann-deutschland-von-anderen-laendern-lernen/

[^4_52]: https://www.make-und-mint.de

[^4_53]: https://lernmint.org

[^4_54]: https://www.kebel.de/cad-kurse-online/

[^4_55]: https://www.wbstraining.de/weiterbildungen/cad/

[^4_56]: https://jupyterlite.readthedocs.io

[^4_57]: https://github.com/jtpio/ipyp5

[^4_58]: https://stackoverflow.com/questions/49870879/can-i-run-processing-org-python-sketch-from-a-jupyter-notebook-and-pass-data

[^4_59]: https://marketplace.visualstudio.com/items?itemName=garrit.p5js-notebook

[^4_60]: https://discourse.jupyter.org/t/embed-personal-video-player-inside-markdown-cell/24518

[^4_61]: https://github.com/jupyterlab/jupyterlab/issues/14186

[^4_62]: https://towardsdatascience.com/today-i-was-pouring-through-my-complex-variables-and-analytic-functions-book-written-by-the-e9205f71485d/

[^4_63]: https://jupyterlite-p5-kernel.readthedocs.io/en/latest/lite/lab/

[^4_64]: https://www.youtube.com/watch?v=qLCHTEpgfx4

[^4_65]: https://www.youtube.com/watch?v=lN_dSl4V1BI


---
