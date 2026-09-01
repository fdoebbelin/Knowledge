

# **Reproduzierbare und Interaktive Lehrmodule in der Cloud: Ein Implementierungsleitfaden für Dozenten mittels mybinder.org, Python und Octave**

## **I. Architektonische Grundlagen und der Mehrwert von mybinder.org**

### **I.1 Definition und Kontext im Ökosystem der Open Science**

Binder ist ein bedeutender Open-Source-Webdienst, der es Nutzern ermöglicht, teilbare, interaktive und reproduzierbare Umgebungen in der Cloud zu erstellen.1 Diese Funktionalität adressiert direkt die wissenschaftliche Reproduzierbarkeitskrise, da geschätzt 90 Prozent der Forscher im Jahr 2016 über Schwierigkeiten bei der Reproduktion der Arbeit von Kollegen berichteten.1 Binder gewährleistet hierbei sowohl die *technische Reproduzierbarkeit* (die Ermöglichung wissenschaftlicher Ergebnisse an sich) als auch die *praktische Reproduzierbarkeit* (die Fähigkeit Dritter, Ergebnisse ohne Schwierigkeiten nachzuvollziehen), indem es Code und die exakte Laufzeitumgebung fest miteinander verknüpft.1

Die öffentliche Implementierung, bekannt als mybinder.org, ist ein kostenloser, öffentlich zugänglicher Dienst, der die technologische Basis des BinderHub-Projekts demonstriert.1 Der technologische Stack, der Binder antreibt, ist robust und skaliert Cloud-Ressourcen effizient. Er basiert auf Kernprojekten des Open-Source-Ökosystems, insbesondere **JupyterHub** zur Verwaltung von Multi-User-Instanzen und **Kubernetes** zur Orchestrierung der Cloud-Infrastruktur.1 Das Ergebnis dieses Prozesses ist die Erstellung eines Docker-Images auf Basis der Repository-Konfiguration, welches dann auf einem JupyterHub-Server gehostet wird, um interaktive Sitzungen bereitzustellen.2

### **I.2 Vorteile und Pädagogische Implikationen für die Lehre**

Für Lehrende stellt mybinder.org einen entscheidenden didaktischen Vorteil dar, insbesondere bei Kursen, die auf datenwissenschaftlichen Methoden basieren. Der Hauptvorteil liegt in der **Eliminierung der "Installations-Nachtmare"**.4 Traditionell verbringen Dozenten oft einen Großteil der ersten Kurssitzungen damit, Installationsprobleme auf den individuellen Rechnern der Studierenden zu beheben. Binder umgeht dieses Problem vollständig, indem es eine vorkonfigurierte, funktionierende Umgebung direkt im Browser bereitstellt.4

Darüber hinaus unterstützt Binder die Erstellung von **Open Educational Resources (OER)**, indem es öffentlich zugängliche Bildungsressourcen interaktiv gestaltet und den Lernenden somit eine reichhaltigere und unmittelbar anwendbare Erfahrung ermöglicht.4

Die Nutzung von mybinder.org als kostenlosem, öffentlichem Dienst 3 impliziert jedoch zwingende strukturelle Anforderungen und Einschränkungen, die Dozenten beachten müssen. Ein Binder-Repository muss auf einer **öffentlichen Plattform** wie GitHub oder GitLab gehostet werden und darf zu keiner Zeit sensible Informationen oder Passwörter erfordern.3 Ferner ist die Architektur nicht für proprietäre oder ressourcenintensive Anwendungen wie dedizierte **GPU-Nutzung** oder hochspezialisierte, kommerzielle Software (wie die kommerzielle MATLAB-Installation) ausgelegt.5 Diese Einschränkungen führen zu der strategischen Notwendigkeit, auf Open-Source-Alternativen wie GNU Octave zurückzugreifen, um die Funktionalität von MATLAB-ähnlichen Code in der Kursumgebung zu gewährleisten.

Die Reproduzierbarkeit, die Binder bietet 1, ist für den Kursleiter gleichbedeutend mit der Pflicht zur **strengen Versionskontrolle**. Soll der Kurs über mehrere Semester hinweg genutzt werden, ist es zwingend erforderlich, dass in der Abhängigkeitsdatei (environment.yml) alle Softwarepakete und deren exakte Versionen explizit fixiert werden. Nur so lässt sich verhindern, dass zukünftige Binder-Builds aufgrund von Paket-Updates (sogenannter Dependency-Drift) fehlschlagen und die Kursfunktionalität beeinträchtigt wird.

## **II. Design des Kurs-Repositorys und Umgebungsmanagement**

### **II.1 Struktur des Binder-Ready Repositorys für Kurse**

Ein "Binder-Ready Repository" ist ein Code-Repository, das mindestens zwei Komponenten enthalten muss: den auszuführenden Code (z. B. Jupyter Notebooks) und die Konfigurationsdateien, die BinderHub zur Erstellung der Umgebung benötigt.3

Für die Strukturierung eines Kurses wird Dozenten empfohlen, die Konfigurationsdateien in einem dedizierten binder/-Unterordner zu platzieren, anstatt diese im Root-Verzeichnis abzulegen.3 Dies sorgt für ein aufgeräumtes Hauptverzeichnis, das die Kursmaterialien in den Vordergrund stellt.

Eine typische, empfohlene Struktur für einen interaktiven Kurs sieht folgendermaßen aus:

/My\_Python\_Course/  
├── README.md               \# Mit Beschreibung und Binder-Badge  
├── binder/                 \# Spezifische Konfigurationsdateien für BinderHub  
│   ├── environment.yml     \# Conda-Umgebung (Python, Kernel)  
│   ├── apt.txt             \# Betriebssystem-Abhängigkeiten (Octave)  
│   ├── postBuild           \# Anpassungen nach dem Build (z.B. Workspace-Import)  
│   └── workspace.jupyterlab-workspace \# Optional: Benutzerdefiniertes JupyterLab Layout  
├── data/                   \# Kleine, statische Kursdaten  
└── Module\_1\_Intro\_Python/  \# Kursinhalte  
    ├── 01\_Basics.ipynb  
    └── Octave\_Example.ipynb

Die Startseite für Studierende sollte nicht notwendigerweise der Dateimanager sein. Dozenten können Deep-Links verwenden, um Studierende direkt zu einem spezifischen Notebook zu leiten. Dies geschieht durch die Angabe eines filepath (für JupyterLab) oder einer urlpath (für die klassische Jupyter Notebook-Ansicht) im generierten Binder-Link.3

### **II.2 Basis-Konfigurationsdateien: Python-Umgebung**

Die Definition der Laufzeitumgebung erfolgt primär über die Datei environment.yml im Conda-Format.3 Für wissenschaftliche Python-Kurse ist Conda die bevorzugte Wahl gegenüber requirements.txt (Pip), da es eine robustere Handhabung von Binärabhängigkeiten (wie sie in Paketen wie NumPy und SciPy vorkommen) ermöglicht.3

Die environment.yml muss alle notwendigen Pakete für den Kurs, einschließlich Interaktivität und Kernel-Integration, auflisten:

YAML

name: interactive\_course\_env  
channels:  
  \- conda-forge  
dependencies:  
  \# Kern-Python-Pakete für wissenschaftliche Berechnungen  
  \- python=3.10  
  \- numpy  
  \- scipy  
  \- matplotlib  
  \- pandas  
  \- jupyterlab  
  \# Interaktivität und Plotting  
  \- ipywidgets  
  \- bokeh  
  \# Octave-Integration  
  \- octave\_kernel  
  \- pip  
  \- pip:  
    \- plotly  
    \- voila

Die explizite Angabe von Versionsnummern (z.B. python=3.10 und numpy=1.24) ist, wie bereits erwähnt, für die langfristige Reproduzierbarkeit des Kurses unerlässlich.

### **II.3 Implementierung der MATLAB-Integration über GNU Octave**

Um der Anforderung der MATLAB-Integration im Rahmen der Einschränkungen von mybinder.org gerecht zu werden, muss die Open-Source-Alternative **GNU Octave** verwendet werden.7 Octave ist mit der MATLAB-ähnlichen Syntax kompatibel, wobei Dozenten darauf achten müssen, dass nur die gemeinsamen Befehle und Funktionen genutzt werden, da keine 100-prozentige Kompatibilität gewährleistet ist.7

Die Einrichtung der Octave-Umgebung erfordert ein **Dual-Layer-Setup** 7:

1. **Betriebssystem-Ebene (APT):** Zunächst muss die Basis-Software GNU Octave auf dem zugrundeliegenden Linux-System des Binder-Containers installiert werden. Dies wird durch die Konfigurationsdatei apt.txt erreicht, die Ubuntu APT-Pakete installiert.7  
   binder/apt.txt  
   octave

2. **Kernel-Ebene (Conda):** Danach muss der **octave\_kernel** installiert werden. Dieser ist ein Python-Paket, das als Brücke fungiert, um die Kommunikation zwischen der Jupyter-Schnittstelle und dem installierten Octave-Programm zu ermöglichen. Dieses Paket muss daher in der environment.yml unter den Abhängigkeiten gelistet werden.7

Die Funktionalität der MATLAB-Integration bildet somit eine dreigliedrige Abhängigkeitskette: Die Installation von Octave über apt.txt, die Installation des octave\_kernel über environment.yml, und die erfolgreiche Kommunikation zwischen dem Kernel und der Octave-Installation. Der Dozent muss diesen kritischen Prozess intensiv testen, da ein Fehler in einem Glied die gesamte Funktionalität des Octave-Notebooks unterbricht.

## **III. Entwicklung Interaktiver Kursinhalte**

### **III.1 Grundlagen Interaktiver Diagramme und Visualisierung**

Interaktive Kursinhalte sind das Herzstück eines modernen Python-Kurses auf Binder. Während Matplotlib für statische Grafiken ausreicht, bieten Bibliotheken wie **Bokeh** und **Plotly** erweiterte Funktionalitäten wie Zoomen, Schwenken und Tooltips, welche im PyViz-Ökosystem verankert sind.9 Beide Bibliotheken sollten in der environment.yml installiert werden, um sie in den Notebooks verfügbar zu machen.

Das primäre Werkzeug zur Schaffung benutzerdefinierter Interaktivität sind jedoch **Jupyter Widgets** (ipywidgets).9 Diese ermöglichen die Implementierung von UI-Steuerelementen wie Schiebereglern und Textfeldern, die Parameter des Python-Codes zur Laufzeit dynamisch verändern.

### **III.2 Tiefe Integration mittels ipywidgets**

Die Bibliothek ipywidgets interagiert sowohl mit dem laufenden Python-Kernel als auch mit dem JavaScript im Browser des Benutzers.9 Die Kernfunktion ist interact(), die automatisch Steuerelemente (Widgets) basierend auf den Standardwerten oder den definierten numerischen Bereichen einer Python-Funktion generiert.10

Ein Beispiel zur Steuerung der Amplitude und des Offsets einer Sinuswelle demonstriert die Einfachheit der Anwendung:

Python

from ipywidgets import interact  
import numpy as np  
import matplotlib.pyplot as plt

def update\_plot(A=1.0, B=0.0):  
    \# A und B werden automatisch durch Schieberegler gesteuert  
    x \= np.linspace(-10, 10, 100)  
    y \= A \* np.sin(x) \+ B  
    plt.figure(figsize=(8, 4))  
    plt.plot(x, y)  
    plt.ylim(-5, 5)  
    plt.show()

\# interact erzeugt Schieberegler für A und B basierend auf den Bereichen  
interact(update\_plot, A=(-4, 4, 0.1), B=(-4, 4, 0.1));

Für die Installation in modernen Umgebungen (JupyterLab 3.x und höher) muss die ipywidgets-Installation in der environment.yml erfolgen. Sollten der Jupyter Notebook Server und der IPython Kernel in separaten Umgebungen laufen, ist eine zweistufige Installation erforderlich: jupyterlab\_widgets im Server-Environment und ipywidgets in jedem Kernel-Environment.11

Es ist didaktisch wichtig zu verstehen, dass Widgets einen **laufenden Kernel** benötigen.9 Dies untermauert die Notwendigkeit der Binder-Architektur, da BinderHub eine dedizierte Live-Sitzung mit laufendem Kernel für jeden Studierenden bereitstellt.

### **III.3 Der Einsatz von Voilà für Dashboard-Ansichten**

Voilà dient als nächste Stufe der Interaktivität und Reproduzierbarkeit, indem es Jupyter Notebooks in reine, interaktive Dashboards umwandelt.8 Dabei wird der gesamte Code des Notebooks ausgeblendet, während nur die Markdown-Dokumentation, die Ausgaben und die Widgets sichtbar bleiben. Dies optimiert die User Experience (UX), indem es die Studierenden auf die parametrische Interaktion fokussiert, anstatt sie mit dem Quellcode abzulenken. Dies ist besonders nützlich für Übungen, bei denen Ergebnisse manipuliert werden sollen, ohne den dahinterliegenden Mechanismus offenzulegen.

Um Studierende direkt in die Dashboard-Ansicht zu leiten, muss der Dozent den Binder-Start-Link so konfigurieren, dass er den Voilà-Endpunkt nutzt 7:

https://mybinder.org/v2/gh/user/repo\_name/branch/?urlpath=voila/render/path/to/notebook.ipynb

Die Installation von Voilà kann über die environment.yml erfolgen.3

## **IV. Der Dozenten-Workflow: Bereitstellung, Wartung und Pädagogik**

### **IV.1 Der Build-Prozess und die Startzeitoptimierung**

Wenn ein Binder-Link zum ersten Mal angeklickt wird, sucht mybinder.org nach Konfigurationsdateien, baut ein Docker-Image und startet einen JupyterHub-Server.2 Ein neuer Build wird nur dann ausgelöst, wenn ein neuer Commit im Repository vorliegt oder das Image noch nicht existiert.2

Die Build-Zeit ist ein kritischer Faktor für den Kursstart. Dozenten sollten folgende Strategien zur Optimierung der Startgeschwindigkeit anwenden:

1. **Präzision in der Konfiguration:** Jede nicht benötigte Abhängigkeit in environment.yml verlängert die Build-Zeit und erhöht den Ressourcenverbrauch. Die Liste muss auf das absolute Minimum beschränkt werden.  
2. **Präzise Versionsfixierung:** Wie in Abschnitt I.2 dargelegt, minimiert die explizite Fixierung von Versionen (z. B. numpy=1.24) das Risiko von Build-Fehlern und stellt sicher, dass Studierende stets dieselbe Umgebung erhalten.  
3. **Pre-Building:** Vor einem kritischen Workshop oder Kursstart sollte der Dozent das Binder-Image manuell starten. Dies stellt sicher, dass das Image im Cache des BinderHubs gespeichert ist und die nachfolgenden Starts für die Studierenden nur wenige Sekunden dauern.

### **IV.2 Anpassung des Benutzer-Interfaces (UX-Kontrolle)**

Um eine konsistente und professionelle Benutzererfahrung (UX) zu gewährleisten, ist die Anpassung des JupyterLab-Layouts für die Studierenden essenziell. Dozenten können ihr bevorzugtes Layout (z. B. welche Dateien geöffnet sind, thematische Einstellungen) in JupyterLab definieren und dieses als workspace.jupyterlab-workspace exportieren.12

Dieses benutzerdefinierte Layout kann während des Build-Prozesses durch das Skript postBuild im binder/-Ordner importiert werden.12 Das postBuild-Skript ist ein Bash-Skript, das nach der Installation aller Abhängigkeiten ausgeführt wird:

binder/postBuild (Beispiel)

Bash

\#\!/usr/bin/env bash  
set \-eux  
\# Importiert das benutzerdefinierte Layout als Standard-Workspace  
conda run \-n notebook jupyter lab workspaces import \--name default binder/workspace.jupyterlab-workspace  
\# Beispiel: Deaktivierung von Benachrichtigungen über eine overrides.json Datei  
mkdir \-p ${NB\_PYTHON\_PREFIX}/share/jupyter/lab/settings  
cp binder/overrides.json ${NB\_PYTHON\_PREFIX}/share/jupyter/lab/settings

Die Verwendung des Pfades ${NB\_PYTHON\_PREFIX} gewährleistet die korrekte Ausführung der Befehle innerhalb der Conda-Umgebung.12

### **IV.3 Generierung und Management von Zugangs-Links**

Die Zugänglichkeit zum Kursmaterial wird durch die Verwendung von Binder-Badges (klickbare Buttons) im README.md des Repositorys maximiert.2 Die mybinder.org-Website bietet hierfür einen Generator.2

Der Dozent sollte unterschiedliche Links generieren, um verschiedene Einstiegspunkte zu bieten:

1. **Standard-Launch:** Öffnet JupyterLab im Dateimanager.  
2. **Direkter Notebook-Launch:** Öffnet ein spezifisches Kursmodul sofort, nützlich für gezielte Übungen.  
3. **Voilà-Dashboard-Launch:** Startet das Notebook direkt als interaktives Dashboard (siehe Abschnitt III.3).

### **IV.4 Pädagogische Best Practices und Umgang mit Einschränkungen**

Die wichtigste pädagogische Information, die Dozenten an ihre Studierenden weitergeben müssen, ist die **Non-Persistenz** der Umgebung.5 Da mybinder.org ein temporärer Dienst ist, gehen alle Änderungen (Code, Daten, neue Dateien), die ein Studierender im laufenden Container vornimmt, verloren, sobald die Sitzung inaktiv wird.5

**Speicherstrategie für Studierende:** Um den Verlust von Arbeit zu verhindern, müssen Studierende angewiesen werden, die integrierte Download-Funktion in Jupyter zu nutzen, die durch die Erweiterung jupyter-offlinenotebook unterstützt wird.5 Dies ermöglicht das lokale Speichern des aktuellen Notebooks, selbst wenn die Verbindung zum Cloud-Server unterbrochen wird.

**Umgang mit Daten und Ressourcen:** Die architektonischen Grenzen des öffentlichen Dienstes diktieren die Handhabung von Ressourcen:

1. **Keine Exzessiven Ressourcen:** Da mybinder.org ein öffentlicher, durch die Community unterstützter Dienst ist 2, dürfen Dozenten keine exzessiven oder unnötigen Rechenressourcen verbrauchen.5 Dies schließt langlaufende Modelltrainings oder Simulationen aus, welche die Studierenden lokal durchführen oder mit vorab trainierten Modellen ersetzen sollten.5  
2. **Datenmanagement:** Große Datenmengen sollten nicht direkt im Git-Repository gespeichert werden. Stattdessen können sie während des postBuild-Prozesses von einem externen Hoster abgerufen oder über spezialisierte Tools wie Quilt geladen werden.3

Die Non-Persistenz verschiebt den didaktischen Fokus des Kurses: Anstatt auf die Entwicklung umfangreicher, langfristiger Codebasen zu setzen, eignen sich Binder-Kurse ideal für **experimentelles Lernen**, das **Verstehen von Konzepten** durch interaktive Visualisierungen und die **Demonstration von Analysen** in einer sofort verfügbaren Umgebung.

## **V. Zusammenfassende Tabellen für den Dozenten (Referenz)**

Die folgenden Tabellen fassen die kritischen technischen Anforderungen und Pfade zusammen, die für die erfolgreiche Kursimplementierung notwendig sind.

Tabelle 1: Übersicht der Binder-Konfigurationsdateien für den Kurs

| Dateiname | Pfad (Empfehlung) | Zweck | Technologie/System |
| :---- | :---- | :---- | :---- |
| environment.yml | binder/ | Definiert die Conda-Umgebung (Python, Octave-Kernel, ipywidgets) und deren Versionsfixierung. | Conda/Python \[6, 7\] |
| apt.txt | binder/ | Installiert die Basis-Software GNU Octave auf dem Betriebssystem-Image. | Ubuntu APT 7 |
| postBuild | binder/ | Bash-Skript zur Ausführung einmaliger Befehle nach der Installation, z. B. Import des benutzerdefinierten JupyterLab-Layouts. | Bash 12 |
| workspace.jupyterlab-workspace | binder/ | (Optional) Definiert ein benutzerdefiniertes Layout für JupyterLab. | JupyterLab 12 |

Tabelle 2: Interaktive Komponenten und Kern-Abhängigkeiten

| Funktion | Notwendige Umgebungskonfiguration | Zweck im Kurs | Installationspfad |
| :---- | :---- | :---- | :---- |
| MATLAB-Äquivalent | octave | Basis-Software für Code-Ausführung (via Octave-Kernel). | apt.txt 7 |
| MATLAB-Kernel-Brücke | octave-kernel | Ermöglicht die Ausführung von Octave-Code in einem Jupyter Notebook. | environment.yml 7 |
| Interaktive Steuerung | ipywidgets | Erstellung von UI-Elementen (Schieberegler) zur Laufzeitmanipulation von Code-Parametern. | environment.yml 10 |
| Interaktive Plots | bokeh, plotly | Erstellung von Web-basierten, zoombaren und interaktiven Diagrammen. | environment.yml 9 |
| Dashboard-Präsentation | voila | Konvertiert Notebooks in interaktive, reine Web-Anwendungen. | environment.yml 7 |

## **VI. Fazit und Handlungsempfehlungen für Dozenten**

Die erfolgreiche Bereitstellung eines interaktiven Python-Kurses mit MATLAB-Integration über mybinder.org hängt von der akribischen Einhaltung der Dual-Layer-Konfiguration und der optimalen Gestaltung der Benutzererfahrung ab.

Die Analyse verdeutlicht, dass die technische Herausforderung der **MATLAB-Integration** durch die strategische Nutzung von GNU Octave gelöst werden muss, wobei die Kombination aus apt.txt (für die Systemsoftware) und environment.yml (für den octave\_kernel) die kritische technische Kette bildet, die intensiv getestet werden muss.

Didaktisch bieten ipywidgets und Voilà die notwendigen Werkzeuge, um den Lernenden über einfache statische Visualisierungen hinausgehende, parametrisch steuerbare Erfahrungen zu ermöglichen. Die Verwendung von postBuild-Skripten zur Implementierung eines benutzerdefinierten JupyterLab-Workspaces stellt sicher, dass die Studierenden sofort in eine vertraute und konsistente Lernumgebung eintreten.

Zusammenfassend lassen sich folgende Handlungsempfehlungen ableiten:

1. **Priorisierung der Reproduzierbarkeit:** Strikte Versionsfixierung in der environment.yml ist nicht optional, sondern zwingend notwendig, um die langfristige Funktionalität des Kurses über die Semester hinweg zu gewährleisten.  
2. **Einhaltung der Ressourcengrenzen:** Der Dozent muss das Kursdesign an die Beschränkungen des kostenlosen, öffentlichen mybinder.org-Dienstes anpassen (keine GPUs, Vermeidung von Langläufern) und externe Daten effizient handhaben, um die kollektiven Ressourcen nicht zu überlasten.5  
3. **Klare Kommunikation der Non-Persistenz:** Studierende müssen explizit über die temporäre Natur der Sitzungen aufgeklärt und zur regelmäßigen Nutzung der Download-Funktion angehalten werden, um Arbeitsverlust zu vermeiden.  
4. **Optimierung der Startzeit:** Durch das Pre-Building und die Beschränkung der Abhängigkeiten auf das Minimum wird die Wartezeit der Studierenden minimiert, was die Akzeptanz und den Fluss des Kurses signifikant verbessert.

#### **Referenzen**

1. Binder 2.0 \- Reproducible, interactive, sharable environments for science at scale \- SciPy Proceedings, Zugriff am November 3, 2025, [https://proceedings.scipy.org/articles/Majora-4af1f417-011.pdf](https://proceedings.scipy.org/articles/Majora-4af1f417-011.pdf)  
2. MyBinder.org, Zugriff am November 3, 2025, [https://mybinder.org/](https://mybinder.org/)  
3. Get started with Binder — Binder 0.1b documentation, Zugriff am November 3, 2025, [https://mybinder.readthedocs.io/en/latest/introduction.html](https://mybinder.readthedocs.io/en/latest/introduction.html)  
4. The Binder Project \- Jupyter Notebook, Zugriff am November 3, 2025, [https://jupyter.org/binder](https://jupyter.org/binder)  
5. Binder \- The Turing Way, Zugriff am November 3, 2025, [https://book.the-turing-way.org/communication/binder/](https://book.the-turing-way.org/communication/binder/)  
6. Binder for Reproducible Research — Earth and Environmental Data Science, Zugriff am November 3, 2025, [https://earth-env-data-science.github.io/lectures/environment/binder.html](https://earth-env-data-science.github.io/lectures/environment/binder.html)  
7. Sample Binder Repositories — Binder 0.1b documentation, Zugriff am November 3, 2025, [https://mybinder.readthedocs.io/en/latest/examples/sample\_repos.html](https://mybinder.readthedocs.io/en/latest/examples/sample_repos.html)  
8. Project Jupyter | Try Jupyter, Zugriff am November 3, 2025, [https://jupyter.org/try](https://jupyter.org/try)  
9. Interactive data visualizations \- Jupyter Book, Zugriff am November 3, 2025, [https://jupyterbook.org/interactive/interactive.html](https://jupyterbook.org/interactive/interactive.html)  
10. Jupyter Notebook: interactive plot with widgets \- Stack Overflow, Zugriff am November 3, 2025, [https://stackoverflow.com/questions/44329068/jupyter-notebook-interactive-plot-with-widgets](https://stackoverflow.com/questions/44329068/jupyter-notebook-interactive-plot-with-widgets)  
11. Installation — Jupyter Widgets 8.1.7 documentation \- IPyWidgets, Zugriff am November 3, 2025, [https://ipywidgets.readthedocs.io/en/latest/user\_install.html](https://ipywidgets.readthedocs.io/en/latest/user_install.html)  
12. JupyterLab on Binder, Zugriff am November 3, 2025, [https://jupyterlab.readthedocs.io/en/stable/user/binder.html](https://jupyterlab.readthedocs.io/en/stable/user/binder.html)  
13. ian-r-rose/binder-workspace-demo: A demonstration repository showing how to open JupyterLab with a custom layout on mybinder.org \- GitHub, Zugriff am November 3, 2025, [https://github.com/ian-r-rose/binder-workspace-demo](https://github.com/ian-r-rose/binder-workspace-demo)  
14. Generate custom launch badges — Binder 0.1b documentation, Zugriff am November 3, 2025, [https://mybinder.readthedocs.io/en/latest/howto/badges.html](https://mybinder.readthedocs.io/en/latest/howto/badges.html)