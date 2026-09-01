# 🧠 Python + Octave Kurs (Binder-ready)

Dieses Repository enthält ein interaktives Kursbeispiel für den Einsatz von **Python** und **GNU Octave**
innerhalb von **Jupyter Notebooks** über [mybinder.org](https://mybinder.org).

## 🚀 Live starten

Klicke hier, um das Projekt direkt im Browser (ohne Installation) zu öffnen:

[![](_resources/7d534c7a3e4aadaf6e06f4439b33f557_MD5.svg)](https://mybinder.org/v2/gh/fdoebbelin/python-octave-course-template/HEAD?labpath=notebooks/01_intro.ipynb)

## 📘 Kursinhalte

1. **Einführung in Python & NumPy**  
   Grundlagen der numerischen Berechnung mit Arrays.

2. **MATLAB-kompatibles Rechnen mit Octave (`oct2py`)**  
   Ausführen von Octave-Code direkt in Python-Notebooks.

3. **Interaktive Diagramme mit Plotly und Widgets**  
   Visualisierung und Parametersteuerung über Slider.

## 🧑‍🏫 Verwendung im Unterricht

| Phase | Ziel | Tipp |
|-------|------|------|
| **Vorbereitung** | Repository auf GitHub prüfen | Binder-Link öffnen und Start testen |
| **Live-Unterricht** | Link oder QR-Code teilen | Studierende benötigen nur einen Browser |
| **Übung/Aufgaben** | Notebooks individuell bearbeiten | Ergebnisse als `.ipynb` oder `.pdf` exportieren |
| **Nachbereitung** | Einsammeln der Arbeiten | z. B. über Moodle oder GitHub Classroom |

## 🔧 Lokale Installation (optional)

Wenn du das Projekt lokal ausführen möchtest:

```bash
git clone https://github.com/fdoebbelin/python-octave-course-template.git
cd python-octave-course-template
pip install -r requirements.txt
jupyter lab
````

## ⚙️ Technische Basis

- **Python 3.11**
- **oct2py** für Octave-Integration
- **plotly** & **ipywidgets** für Interaktivität
- Läuft vollständig auf **mybinder.org** (keine Installation nötig)

## 📄 Lizenz

Dieses Beispielprojekt steht unter der [MIT-Lizenz](https://opensource.org/licenses/MIT).  
Du darfst es frei anpassen und in eigenen Kursen verwenden.