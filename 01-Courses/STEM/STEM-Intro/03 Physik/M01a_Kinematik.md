# Modul 1 – Kinematik: Bewegung beschreiben
## Demonstration und Einführung für Dozenten

---

## 🎯 Lernziele

Nach diesem Modul verstehen Lernende:
- Die **Grundbegriffe der Kinematik**: Ort, Weg, Geschwindigkeit und Beschleunigung
- Den **Unterschied zwischen Geschwindigkeit und Beschleunigung**
- Wie man **Bewegungsgleichungen** im Zeit-Ort-Diagramm visualisiert
- Wie man **gleichförmige und beschleunigte Bewegungen** mit p5.js simuliert
- Die praktische Anwendung von Kinematik in realen Szenarien (Verkehr, Sport, Raumfahrt)

---

## 📚 Theoretische Einführung

### Was ist Kinematik?

Die **Kinematik** ist die Lehre von der Bewegung von Objekten, ohne die Kräfte zu berücksichtigen, die diese Bewegung verursachen. Sie beantwortet die Frage: „Wie bewegt sich ein Objekt?"

Im Alltag begegnen uns ständig kinematische Phänomene:
- Ein Auto beschleunigt auf der Autobahn
- Ein Fußball folgt einer gekrümmten Bahn beim Schuss
- Ein Zug bremst in den Bahnhof ein
- Ein Satellit umkreist die Erde

### Grundbegriffe der Kinematik

#### 1. **Ort (Position)**
Der **Ort** beschreibt, wo sich ein Objekt zu einem bestimmten Zeitpunkt befindet. Er wird oft mit \(x\), \(y\) oder \(s\) bezeichnet und wird in Metern (m) gemessen.

```python
# Beispiel: Ort eines Objekts zu verschiedenen Zeiten
zeiten = [0, 1, 2, 3, 4, 5]  # in Sekunden
orte = [0, 1, 4, 9, 16, 25]  # in Metern

# Visualisierung
for t, s in zip(zeiten, orte):
    print(f"Zur Zeit t = {t} s ist das Objekt bei s = {s} m")
```

#### 2. **Weg (Strecke)**
Der **Weg** ist die tatsächliche Länge der Bahn, die ein Objekt zurücklegt. Wenn ein Auto von Punkt A nach B fährt, ist der Weg die Länge der Straße, die es benutzt.

**Wichtig:** Weg ist nicht gleich Verschiebung! 
- *Verschiebung* = Anfangsposition - Endposition (kann null sein, wenn man zurückkommt)
- *Weg* = tatsächlich zurückgelegte Strecke (immer positiv)

#### 3. **Geschwindigkeit**
Die **Geschwindigkeit** beschreibt, wie schnell sich ein Objekt bewegt und in welche Richtung. Sie wird in Metern pro Sekunde (m/s) gemessen.

**Durchschnittsgeschwindigkeit:**
\[
v_{avg} = \frac{\Delta s}{\Delta t} = \frac{s_{end} - s_{start}}{t_{end} - t_{start}}
\]

**Momentangeschwindigkeit:** Die Geschwindigkeit an einem bestimmten Zeitpunkt (mathematisch: die Ableitung des Ortes nach der Zeit)

```python
# Beispiel: Berechnung der Durchschnittsgeschwindigkeit
start_ort = 0  # m
end_ort = 100  # m
delta_s = end_ort - start_ort

start_zeit = 0  # s
end_zeit = 10  # s
delta_t = end_zeit - start_zeit

durchschnitts_geschwindigkeit = delta_s / delta_t
print(f"Durchschnittsgeschwindigkeit: {durchschnitts_geschwindigkeit} m/s")
```

#### 4. **Beschleunigung**
Die **Beschleunigung** beschreibt, wie schnell sich die Geschwindigkeit ändert. Sie wird in Metern pro Sekunde zum Quadrat (m/s²) gemessen.

**Durchschnittsbeschleunigung:**
\[
a_{avg} = \frac{\Delta v}{\Delta t} = \frac{v_{end} - v_{start}}{t_{end} - t_{start}}
\]

```python
# Beispiel: Berechnung der Durchschnittsbeschleunigung
start_geschwindigkeit = 0  # m/s
end_geschwindigkeit = 20  # m/s
delta_v = end_geschwindigkeit - start_geschwindigkeit

start_zeit = 0  # s
end_zeit = 5  # s
delta_t = end_zeit - start_zeit

beschleunigung = delta_v / delta_t
print(f"Beschleunigung: {beschleunigung} m/s²")
```

---

## 🔍 Bewegungstypen

### 1. Gleichförmige Bewegung (konstante Geschwindigkeit)

Bei einer **gleichförmigen Bewegung** ist die Geschwindigkeit konstant – es findet keine Beschleunigung statt.

**Bewegungsgleichung:**
\[
s(t) = s_0 + v \cdot t
\]

wobei:
- \(s(t)\) = Ort zur Zeit \(t\)
- \(s_0\) = Anfangsort
- \(v\) = konstante Geschwindigkeit
- \(t\) = Zeit

**Charakteristik im Diagramm:**
- Zeit-Ort-Diagramm: **Gerade Linie**
- Zeit-Geschwindigkeit-Diagramm: **Waagerechte Linie**

```python
import matplotlib.pyplot as plt
import numpy as np

# Gleichförmige Bewegung simulieren
t = np.linspace(0, 10, 100)  # Zeit von 0 bis 10 Sekunden
s0 = 0  # Anfangsort in m
v = 2   # konstante Geschwindigkeit in m/s

s = s0 + v * t  # Bewegungsgleichung

# Visualisierung
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 4))

# Zeit-Ort-Diagramm
ax1.plot(t, s, 'b-', linewidth=2, label='s(t) = 0 + 2·t')
ax1.set_xlabel('Zeit (s)', fontsize=12)
ax1.set_ylabel('Ort (m)', fontsize=12)
ax1.set_title('Gleichförmige Bewegung: Zeit-Ort-Diagramm', fontsize=14)
ax1.grid(True, alpha=0.3)
ax1.legend()

# Zeit-Geschwindigkeit-Diagramm
v_konstant = np.ones_like(t) * v
ax2.plot(t, v_konstant, 'r-', linewidth=2, label='v = 2 m/s (konstant)')
ax2.set_xlabel('Zeit (s)', fontsize=12)
ax2.set_ylabel('Geschwindigkeit (m/s)', fontsize=12)
ax2.set_title('Gleichförmige Bewegung: Zeit-Geschwindigkeit-Diagramm', fontsize=14)
ax2.grid(True, alpha=0.3)
ax2.legend()
ax2.set_ylim([0, 3])

plt.tight_layout()
plt.show()
```

### 2. Gleichmäßig beschleunigte Bewegung (konstante Beschleunigung)

Bei einer **gleichmäßig beschleunigten Bewegung** ist die Beschleunigung konstant – die Geschwindigkeit ändert sich linear.

**Bewegungsgleichungen:**
\[
v(t) = v_0 + a \cdot t
\]
\[
s(t) = s_0 + v_0 \cdot t + \frac{1}{2} a \cdot t^2
\]

wobei:
- \(v_0\) = Anfangsgeschwindigkeit
- \(a\) = konstante Beschleunigung
- \(s_0\) = Anfangsort

**Charakteristik im Diagramm:**
- Zeit-Ort-Diagramm: **Parabel**
- Zeit-Geschwindigkeit-Diagramm: **Gerade Linie**

```python
# Gleichmäßig beschleunigte Bewegung simulieren
t = np.linspace(0, 10, 100)
s0 = 0      # Anfangsort in m
v0 = 1      # Anfangsgeschwindigkeit in m/s
a = 0.5     # konstante Beschleunigung in m/s²

v = v0 + a * t              # Geschwindigkeit
s = s0 + v0 * t + 0.5 * a * t**2  # Ort

# Visualisierung
fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(15, 4))

# Zeit-Ort-Diagramm (Parabel)
ax1.plot(t, s, 'b-', linewidth=2, label='s(t) = 0 + 1·t + 0.5·0.5·t²')
ax1.set_xlabel('Zeit (s)', fontsize=12)
ax1.set_ylabel('Ort (m)', fontsize=12)
ax1.set_title('Beschleunigte Bewegung: Zeit-Ort-Diagramm', fontsize=14)
ax1.grid(True, alpha=0.3)
ax1.legend()

# Zeit-Geschwindigkeit-Diagramm (Gerade)
ax2.plot(t, v, 'r-', linewidth=2, label='v(t) = 1 + 0.5·t')
ax2.set_xlabel('Zeit (s)', fontsize=12)
ax2.set_ylabel('Geschwindigkeit (m/s)', fontsize=12)
ax2.set_title('Beschleunigte Bewegung: Zeit-Geschwindigkeit-Diagramm', fontsize=14)
ax2.grid(True, alpha=0.3)
ax2.legend()

# Zeit-Beschleunigung-Diagramm (konstant)
a_konstant = np.ones_like(t) * a
ax3.plot(t, a_konstant, 'g-', linewidth=2, label='a = 0.5 m/s² (konstant)')
ax3.set_xlabel('Zeit (s)', fontsize=12)
ax3.set_ylabel('Beschleunigung (m/s²)', fontsize=12)
ax3.set_title('Beschleunigte Bewegung: Zeit-Beschleunigung-Diagramm', fontsize=14)
ax3.grid(True, alpha=0.3)
ax3.legend()
ax3.set_ylim([0, 1])

plt.tight_layout()
plt.show()
```

---

## 🎬 Interaktive Simulation mit p5.js

Die folgenden p5.js-Simulationen ermöglichen es den Lernenden, Parameter zu verändern und die Auswirkungen sofort zu beobachten.

### Simulation 1: Gleichförmige Bewegung

```javascript
// p5.js Sketch: Gleichförmige Bewegung
let x = 50;      // Startposition
let v = 2;       // Geschwindigkeit in Pixel pro Frame

function setup() {
  createCanvas(800, 200);
}

function draw() {
  background(255);
  
  // Bewegung
  x = x + v;
  
  // Wenn das Objekt den rechten Rand erreicht, zurücksetzen
  if (x > width) {
    x = 50;
  }
  
  // Objekt zeichnen
  fill(0, 0, 255);
  circle(x, height / 2, 20);
  
  // Text
  fill(0);
  textSize(16);
  text("Geschwindigkeit: " + v + " px/frame", 10, 30);
  text("Position: " + int(x) + " px", 10, 60);
}
```

### Simulation 2: Beschleunigte Bewegung

```javascript
// p5.js Sketch: Beschleunigte Bewegung
let x = 50;      // Startposition
let v = 0;       // Geschwindigkeit
let a = 0.1;     // Beschleunigung

function setup() {
  createCanvas(800, 200);
}

function draw() {
  background(255);
  
  // Bewegung mit Beschleunigung
  v = v + a;
  x = x + v;
  
  // Wenn das Objekt den rechten Rand erreicht, zurücksetzen
  if (x > width) {
    x = 50;
    v = 0;
  }
  
  // Objekt zeichnen
  fill(255, 0, 0);
  circle(x, height / 2, 20);
  
  // Text
  fill(0);
  textSize(16);
  text("Beschleunigung: " + a.toFixed(2) + " px/frame²", 10, 30);
  text("Geschwindigkeit: " + v.toFixed(2) + " px/frame", 10, 60);
  text("Position: " + int(x) + " px", 10, 90);
}
```

---

## 🧠 Verständnisfragen

1. **Was ist der Unterschied zwischen Weg und Verschiebung?**
2. **Wann ist die Geschwindigkeit konstant, und wann ändert sie sich?**
3. **Wie sieht ein Zeit-Ort-Diagramm für gleichförmige Bewegung aus?**
4. **Wie sieht ein Zeit-Ort-Diagramm für beschleunigte Bewegung aus?**
5. **Wenn ein Auto eine Beschleunigung von 5 m/s² hat, bedeutet das, dass es jede Sekunde um 5 m/s schneller wird – stimmt das?**

---

## 🔗 Weiterführende Links

- **Python & Matplotlib Dokumentation:** https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.plot.html
- **p5.js Dokumentation:** https://p5js.org/reference/
- **PhET Interaktive Simulationen (Kinematik):** https://phet.colorado.edu/de/simulations/filter?subjects=physics&types=html,prototype
- **Khan Academy – Kinematik:** https://de.khanacademy.org/science/physics-archive
- **NumPy für wissenschaftliche Berechnungen:** https://numpy.org/doc/stable/

---

## 📝 Hinweise für Dozenten

- Diese Demonstration sollte mit interaktiven Python-Plots und p5.js-Animationen gezeigt werden
- Lernende sollten ermutigt werden, die Parameter zu verändern und Hypothesen zu testen
- Die physikalischen Konzepte sollten mit alltäglichen Beispielen verbunden werden (z. B. Beschleunigung beim Auto fahren)
- Nutzen Sie die Visualisierungen, um die Unterschiede zwischen gleichförmiger und beschleunigter Bewegung zu verdeutlichen
