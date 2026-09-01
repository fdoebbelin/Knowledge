Perfekt 👍 — dann bekommst du jetzt den **vollständigen Leitfaden + alle Dateien**, um ein fertiges GitHub-Repository für deinen interaktiven **Python-Kurs mit Octave-Integration (anstelle MATLAB)** zu erstellen.  
Das Ganze läuft **direkt auf [mybinder.org](https://mybinder.org/)**, mit **interaktiven Diagrammen und Widgets**.

---

# 🧠 Projektname

**`python-octave-course-template`**

Ein interaktiver Online-Kurs für **Datenanalyse, Visualisierung und MATLAB-kompatibles Rechnen mit Octave**, lauffähig in JupyterLab über Binder.

---

## 📁 1. Verzeichnisstruktur

```
python-octave-course-template/
│
├── notebooks/
│   ├── 01_intro.ipynb
│   ├── 02_octave_bridge.ipynb
│   └── 03_interactive_plot.ipynb
│
├── requirements.txt
├── postBuild
├── README.md
└── runtime.txt
```

---

## 🧩 2. Inhalt der Dateien

### `requirements.txt`

Python-Abhängigkeiten für den Kurs:

```txt
numpy
matplotlib
plotly
ipywidgets
oct2py
```

---

### `runtime.txt`

Wählt die Python-Version für Binder:

```
python-3.11
```

---

### `postBuild`

Binder führt dieses Skript nach der Installation aus — wichtig für Widgets und Plotly:

```bash
# Aktiviert interaktive Widgets
jupyter nbextension enable --py widgetsnbextension --sys-prefix
```

---

### `README.md`

````markdown
# 🧠 Python + Octave Kurs (Binder-ready)

Dieses Repository enthält ein interaktives Kursbeispiel für den Einsatz von **Python** und **GNU Octave**
innerhalb von **Jupyter Notebooks** über [mybinder.org](https://mybinder.org).

## 🚀 Live starten
Klicke hier, um das Projekt direkt online zu öffnen:

[![[01-Courses/STEM/STEM-Intro/_resources/7d534c7a3e4aadaf6e06f4439b33f557_MD5.svg]]](https://mybinder.org/v2/gh/<YOUR_GITHUB_USERNAME>/python-octave-course-template/HEAD?labpath=notebooks/01_intro.ipynb)

## 📘 Inhalte
1. Einführung in Python und Notebooks  
2. MATLAB-kompatible Berechnungen mit Octave (`oct2py`)  
3. Interaktive Diagramme und Parametersteuerung

## 🔧 Voraussetzungen (optional lokal)
```bash
pip install -r requirements.txt
````

Starte dann:

```bash
jupyter lab
```

````

---

## 📗 3. Beispielnotebooks

### `01_intro.ipynb` – Einstieg in Python
```python
# Einführung in Python und NumPy

import numpy as np

x = np.linspace(0, 10, 5)
y = np.sin(x)

for i, val in enumerate(y):
    print(f"sin({x[i]:.1f}) = {val:.3f}")
````

---

### `02_octave_bridge.ipynb` – MATLAB/Octave Bridge

```python
import os  
import shutil  
import numpy as np  
import matplotlib.pyplot as plt  
from oct2py import Oct2Py  

def detect_octave_path():  
    for path in ["/usr/bin/octave", "/usr/local/bin/octave", "/snap/bin/octave", shutil.which("octave")]:  
        if path and os.path.exists(path):  
            return path  
    raise FileNotFoundError("Kein Octave-Interpreter gefunden.")  
  
octave_path = detect_octave_path()  
print(f"✅ Octave gefunden unter: {octave_path}")

if "/snap/" in octave_path:  
    temp_dir = os.path.expanduser("~/octave_tmp")  
    os.makedirs(temp_dir, exist_ok=True)  
    print(f"📁 Snap-Umgebung erkannt – verwende Arbeitsverzeichnis: {temp_dir}")  
else:  
    temp_dir = None  
    print("🧩 Klassische Umgebung erkannt – Standard-/tmp wird genutzt.")  
  
octave = Oct2Py()  
if temp_dir:  
    octave.temp_dir = temp_dir  

print("🎨 Initialisiere Octave-Graphics Toolkit...")  
try:  
    octave.eval("graphics_toolkit('qt');", verbose=False)  
    print("✅ Qt-Toolkit aktiviert.")  
except Exception:  
    octave.eval("graphics_toolkit('gnuplot');", verbose=False)  
    print("📊 Fallback: Gnuplot-Toolkit aktiviert (Ausgabe unterdrückt).")  
  
print("🚀 Oct2Py-Session gestartet.")  

# Beispiel 1 – Sinusfunktion berechnen  
x = np.linspace(0, 2*np.pi, 100)  
y = octave.feval("sin", x)  

y = np.array(y).squeeze()  
  
plt.figure(figsize=(7, 4))  
plt.plot(x, y)  
plt.title("Octave berechnet sin(x)")  
plt.xlabel("x")  
plt.ylabel("sin(x)")  
plt.grid(True)  
plt.show()  

# Beispiel 2 – Eigene Octave-Funktion definieren  
octave.eval("""  
function y = parabola(x)  
    y = x.^2 - 4*x + 3;end  
""")  
result = np.array(octave.feval("parabola", [0, 1, 2, 3, 4])).squeeze()  
print("Ergebnis der Octave-Funktion:", result)  

octave.exit()  
print("🧹 Oct2Py-Session beendet.")
```

---

### `03_interactive_plot.ipynb` – Interaktives Diagramm

```python
import numpy as np  
import plotly.graph_objects as go  
from ipywidgets import interact, FloatSlider  

def plot_function(a=1.0, b=1.0):  
    x = np.linspace(0, 10, 500)  
    y = a * np.sin(b * x)  
    fig = go.Figure()  
    fig.add_trace(go.Scatter(x=x, y=y, mode='lines',  
                             name=f'y={a:.2f}*sin({b:.2f}x)'))  
    fig.update_layout(title="Interaktives Diagramm",  
                      xaxis_title="x",  
                      yaxis_title="y")  
    fig.show()  

interact(  
    plot_function,  
    a=FloatSlider(value=1, min=0.1, max=5, step=0.1, description='Amplitude'),  
    b=FloatSlider(value=1, min=0.1, max=5, step=0.1, description='Frequenz')  
)
```

---

## 🔗 4. Binder-Integration

Wenn du das Repository auf GitHub hochgeladen hast (z. B. als  
`https://github.com/<DEIN_NAME>/python-octave-course-template`),  
erstelle deinen Binder-Link mit:

```
https://mybinder.org/v2/gh/<DEIN_NAME>/python-octave-course-template/HEAD?labpath=notebooks/01_intro.ipynb
```

👉 Diesen Link kannst du direkt an Studierende geben.  
Sie landen im JupyterLab-Interface mit laufender Umgebung.

---

## 🧑‍🏫 5. Anleitung für den Dozenten

|Phase|Ziel|Tipp|
|---|---|---|
|**Vorbereitung**|Repository auf GitHub hochladen, Binder-Link testen|Browser-Cache leeren, Startzeit prüfen (2–3 Min)|
|**Live-Unterricht**|Link austeilen oder QR-Code projizieren|Studierende arbeiten ohne Login|
|**Übung/Aufgaben**|Eigene Notebooks kopieren, bearbeiten, speichern|Über „File → Download → Notebook (.ipynb)“ sichern|
|**Nachbereitung**|Ergebnisse einsammeln|Upload via Moodle oder GitHub Classroom|

---

## 🧰 6. Optionale Erweiterungen

- `nbgrader` für automatische Bewertung
- `jupytext` für Notebooks als Markdown
- `voila` für Web-Apps ohne Code
- `jupyterlite` für Offline-Varianten im Browser

---

## ✅ 7. Kurzanleitung: Repository selbst erstellen

```bash
cd python-octave-course-template
git init
mkdir notebooks
touch requirements.txt postBuild runtime.txt README.md
# Dateien mit obigem Inhalt befüllen
git add .
git commit -m "Initial commit: Python + Octave Binder course"
git remote add origin https://github.com/fdoebbelin/python-octave-course-template.git
git push -u origin main
```

Dann auf **[mybinder.org](https://mybinder.org/)**:
- GitHub-URL einfügen
- „Launch“ klicken
- Fertig 🎉