# Modul 1 – Kinematik: Bewegung beschreiben
## Übungsaufgaben mit Hinweisen für Lernende

---

## 🎯 Lernziele

Nach diesem Modul kannst du:
- Die **Grundbegriffe der Kinematik** anwenden: Ort, Weg, Geschwindigkeit und Beschleunigung
- Den **Unterschied zwischen Geschwindigkeit und Beschleunigung** verstehen und erklären
- **Bewegungsgleichungen** berechnen und visualisieren
- **Diagramme interpretieren**, um Bewegungen zu analysieren
- Eine **interaktive Simulation** mit p5.js oder Python erstellen

---

## 📚 Einleitung

Die Kinematik beschreibt, wie sich Objekte bewegen. Überall um dich herum gibt es Bewegungen:
- Ein Auto beschleunigt beim Anfahren
- Ein Zug bremst in den Bahnhof ein
- Ein Tennisball fliegt über das Netz
- Dein Fahrrad wird immer schneller, wenn du den Berg hinunter fährst

In diesem Modul lernst du, diese Bewegungen mathematisch zu beschreiben und mit Code zu visualisieren.

---

## 🔍 Aufgabe 1: Grundbegriffe verstehen

### Aufgabe 1.1: Ort und Weg unterscheiden

Ein Auto startet um 8:00 Uhr in Berlin und fährt nach Dresden. Nach 2 Stunden ist es in Leipzig (ca. 190 km von Berlin). Nach weiteren 1,5 Stunden erreicht es Dresden (ca. 190 km von Leipzig).

**Frage 1:** Wie groß ist die Verschiebung vom Start zum Endziel?

**Frage 2:** Wie groß ist der Weg, den das Auto gefahren ist?

**Frage 3:** Sind Verschiebung und Weg in diesem Fall gleich? Warum oder warum nicht?

*Hinweis:* Denk daran: Verschiebung ist der direkte Abstand vom Start zum Ende, Weg ist die gesamte Strecke, die das Auto gefahren ist.

---

## 🔍 Aufgabe 2: Geschwindigkeit berechnen

### Aufgabe 2.1: Durchschnittsgeschwindigkeit

Ein Läufer läuft eine 10 km lange Strecke in 1 Stunde.

**Aufgabe:** Berechne die Durchschnittsgeschwindigkeit des Läufers in km/h und in m/s.

```python
# TODO: Berechne die Durchschnittsgeschwindigkeit
strecke = ???  # in Metern
zeit = ???     # in Sekunden

durchschnitts_geschwindigkeit = strecke / zeit
print(f"Die Durchschnittsgeschwindigkeit beträgt {durchschnitts_geschwindigkeit} m/s")
```

*Hinweis:* Denk daran, die Einheiten umzurechnen!
- 1 km = 1000 m
- 1 h = 3600 s

**Reflexionsfrage:** Ist die Durchschnittsgeschwindigkeit die gleiche wie die momentane Geschwindigkeit? Wann könnten diese unterschiedlich sein?

---

### Aufgabe 2.2: Aus einem Diagramm ablesen

Schau dir das folgende Zeit-Ort-Diagramm an:

```python
import matplotlib.pyplot as plt

# Beispieldaten
zeit = [0, 1, 2, 3, 4, 5]
ort = [0, 10, 20, 30, 40, 50]

plt.plot(zeit, ort, 'b-o', linewidth=2, markersize=8)
plt.xlabel('Zeit (s)')
plt.ylabel('Ort (m)')
plt.title('Zeit-Ort-Diagramm eines Objekts')
plt.grid(True, alpha=0.3)
plt.show()
```

**Aufgaben:**
1. Was kannst du über die Bewegung aussagen? Ist sie gleichförmig oder beschleunigt?
2. Berechne die Geschwindigkeit zwischen t = 0s und t = 5s.
3. Was würde es bedeuten, wenn die Linie gekrümmt (parabelförmig) statt gerade wäre?

---

## 🔍 Aufgabe 3: Beschleunigung verstehen

### Aufgabe 3.1: Beschleunigung berechnen

Ein Auto startet von 0 km/h und erreicht nach 8 Sekunden eine Geschwindigkeit von 40 m/s. (Das ist eine sehr schnelle Beschleunigung – wie bei einem Sportwagen!)

**Aufgabe:** Berechne die durchschnittliche Beschleunigung des Autos.

```python
# TODO: Berechne die Beschleunigung
v_anfang = ???  # Anfangsgeschwindigkeit in m/s
v_ende = ???    # Endgeschwindigkeit in m/s
delta_v = v_ende - v_anfang

t_anfang = ???  # Anfangszeit in s
t_ende = ???    # Endzeit in s
delta_t = t_ende - t_anfang

beschleunigung = delta_v / delta_t
print(f"Die Beschleunigung beträgt {beschleunigung} m/s²")
```

**Reflexionsfrage:** Was bedeutet es, wenn die Beschleunigung negativ ist? Wie heißt dieser Fall?

---

### Aufgabe 3.2: Geschwindigkeit über Zeit berechnen

Ein Objekt wird mit einer konstanten Beschleunigung von 2 m/s² beschleunigt. Die Anfangsgeschwindigkeit ist 0 m/s.

**Aufgabe:** Berechne die Geschwindigkeit nach 1s, 2s, 3s, 4s und 5s.

```python
# Gegeben
v0 = ???  # Anfangsgeschwindigkeit in m/s
a = ???   # Beschleunigung in m/s²

# Berechne die Geschwindigkeit nach verschiedenen Zeiten
zeiten = [1, 2, 3, 4, 5]

for t in zeiten:
    v = v0 + a * t
    print(f"Nach t = {t} s ist die Geschwindigkeit v = {v} m/s")
```

**Reflexionsfrage:** Wie würde ein Zeit-Geschwindigkeit-Diagramm für dieses Objekt aussehen?

---

## 🎬 Aufgabe 4: Bewegungsgleichungen visualisieren

### Aufgabe 4.1: Gleichförmige Bewegung zeichnen

Ein Fahrrad fährt mit konstanter Geschwindigkeit von 5 m/s. Die Startposition ist 0 m.

**Aufgabe:** Erstelle ein Zeit-Ort-Diagramm für die ersten 10 Sekunden.

```python
import matplotlib.pyplot as plt
import numpy as np

# Gegeben
s0 = ???  # Anfangsort in m
v = ???   # Geschwindigkeit in m/s

# Zeit von 0 bis 10 Sekunden
t = ???

# Berechne den Ort für jeden Zeitpunkt: s(t) = s0 + v*t
s = ???

# Zeichne das Diagramm
plt.plot(t, s, 'b-', linewidth=2)
plt.xlabel('Zeit (s)')
plt.ylabel('Ort (m)')
plt.title('Gleichförmige Bewegung: Zeit-Ort-Diagramm')
plt.grid(True, alpha=0.3)
plt.show()
```

*Hinweis:* Nutze `np.linspace()` um ein Array von Zeitwerten zu erstellen.

**Reflexionsfrage:** Wie sieht das Zeit-Geschwindigkeit-Diagramm für eine gleichförmige Bewegung aus?

---

### Aufgabe 4.2: Beschleunigte Bewegung zeichnen

Ein Auto startet von Position 0 m mit Anfangsgeschwindigkeit 0 m/s und wird mit konstanter Beschleunigung von 1 m/s² beschleunigt.

**Aufgabe:** Erstelle ein Zeit-Ort-Diagramm für die ersten 10 Sekunden.

```python
import matplotlib.pyplot as plt
import numpy as np

# Gegeben
s0 = ???  # Anfangsort in m
v0 = ???  # Anfangsgeschwindigkeit in m/s
a = ???   # Beschleunigung in m/s²

# Zeit von 0 bis 10 Sekunden
t = ???

# Berechne den Ort für jeden Zeitpunkt: s(t) = s0 + v0*t + 0.5*a*t²
s = ???

# Zeichne das Diagramm
plt.plot(t, s, 'r-', linewidth=2)
plt.xlabel('Zeit (s)')
plt.ylabel('Ort (m)')
plt.title('Beschleunigte Bewegung: Zeit-Ort-Diagramm')
plt.grid(True, alpha=0.3)
plt.show()
```

**Reflexionsfrage:** Warum ist das Zeit-Ort-Diagramm für beschleunigte Bewegung eine Parabel?

---

## 🎨 Aufgabe 5: Vergleich gleichförmige vs. beschleunigte Bewegung

**Aufgabe:** Zeichne beide Bewegungstypen in einem Diagramm, um sie zu vergleichen.

```python
import matplotlib.pyplot as plt
import numpy as np

# Zeit von 0 bis 10 Sekunden
t = np.linspace(0, 10, 100)

# Gleichförmige Bewegung: s = 2*t
s_gleichfoermig = 2 * t

# Beschleunigte Bewegung: s = 0.5 * 0.5 * t²
s_beschleunigt = 0.5 * 0.5 * t**2

# Zeichne beide in einem Diagramm
plt.plot(t, s_gleichfoermig, 'b-', linewidth=2, label='Gleichförmige Bewegung (v=2 m/s)')
plt.plot(t, s_beschleunigt, 'r-', linewidth=2, label='Beschleunigte Bewegung (a=0.5 m/s²)')
plt.xlabel('Zeit (s)')
plt.ylabel('Ort (m)')
plt.title('Vergleich: Gleichförmige vs. Beschleunigte Bewegung')
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()
```

**Reflexionsfragen:**
1. Welche Bewegung wird schneller?
2. Nach welcher Zeit überholt die beschleunigte Bewegung die gleichförmige Bewegung?
3. Wie würden die Kurven aussehen, wenn die Beschleunigung größer wäre?

---

## 🎬 Aufgabe 6: Realistische Szenarien

### Aufgabe 6.1: Auto beschleunigt beim Ampelstart

Ein Auto startet bei Grün an der Ampel. Die Beschleunigung beträgt 4 m/s². Nach 5 Sekunden hat das Auto eine rote Ampel erreicht und bremst mit einer Beschleunigung von -3 m/s² (negative Beschleunigung bedeutet Bremsvorgang).

**Aufgabe:** 
1. Berechne die Geschwindigkeit des Autos nach 5 Sekunden (beim Erreichen der roten Ampel).
2. Wie lange dauert es, bis das Auto bei der roten Ampel zum Stehen kommt?
3. Wie weit ist das Auto in dieser Zeit gefahren?

```python
# Phase 1: Beschleunigung
v0 = ???  # Anfangsgeschwindigkeit in m/s (0, da das Auto startet)
a1 = ???  # Beschleunigung in m/s²
t1 = ???  # Zeit der Beschleunigung in s

# Geschwindigkeit nach 5 Sekunden
v_nach_5s = v0 + a1 * t1

# Weg während der Beschleunigung
s1 = v0 * t1 + 0.5 * a1 * t1**2

print(f"Geschwindigkeit nach 5s: {v_nach_5s} m/s")
print(f"Weg während der Beschleunigung: {s1} m")

# Phase 2: Bremsen
v_start_bremsvorgang = ???  # Anfangsgeschwindigkeit beim Bremsvorgang
a2 = ???  # Beschleunigung beim Bremsvorgang (negativ!)
v_end = 0  # Endgeschwindigkeit (Auto steht still)

# Zeit zum Bremsen: v_end = v_start_bremsvorgang + a2 * t
# 0 = v_start_bremsvorgang + a2 * t
# t = -v_start_bremsvorgang / a2
t2 = ???

print(f"Zeit zum Bremsen: {t2} s")

# Weg während des Bremsens
s2 = v_start_bremsvorgang * t2 + 0.5 * a2 * t2**2

print(f"Weg während des Bremsens: {s2} m")
print(f"Gesamtweg: {s1 + s2} m")
```

---

### Aufgabe 6.2: Dein eigenes Szenario

**Aufgabe:** Wähle ein realistisches Szenario aus deinem Alltag (z. B. ein Zug, ein Flugzeug beim Starten, dein Fahrrad, etc.) und:

1. Schätze die Anfangsgeschwindigkeit, Endgeschwindigkeit und Beschleunigung
2. Berechne die Zeit und den Weg
3. Visualisiere die Bewegung in einem Diagramm

```python
# Dein Szenario: ___________________________________________

# Gegeben (Schätzungen):
v0 = ???  # Anfangsgeschwindigkeit in m/s
v_end = ???  # Endgeschwindigkeit in m/s
a = ???  # Beschleunigung in m/s²

# Berechne die Zeit
t = (v_end - v0) / a

# Berechne den Weg
s = v0 * t + 0.5 * a * t**2

print(f"Zeit: {t} s")
print(f"Weg: {s} m")

# Visualisiere die Bewegung
import matplotlib.pyplot as plt
import numpy as np

# TODO: Erstelle ein Zeit-Ort-Diagramm oder Zeit-Geschwindigkeit-Diagramm
```

---

## 🔗 Weiterführende Links

- **Python-Dokumentation NumPy:** https://numpy.org/doc/stable/
- **Matplotlib Dokumentation:** https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.plot.html
- **p5.js Dokumentation:** https://p5js.org/reference/
- **PhET Interaktive Simulationen:** https://phet.colorado.edu/de/simulations/filter?subjects=physics&types=html,prototype
- **Khan Academy – Kinematik:** https://de.khanacademy.org/science/physics-archive

---

## 💡 Tipps zum Lösen der Aufgaben

1. **Lies die Aufgabe sorgfältig:** Unterstreiche die Gegeben-Größen und die gesuchten Größen.
2. **Schreibe die Formel auf:** Bevor du programmierst, schreibe die Bewegungsgleichung hin.
3. **Achte auf Einheiten:** Prüfe, ob alle Größen in den gleichen Einheiten sind (m/s, nicht km/h).
4. **Teste deine Code:** Führe den Code aus und prüfe, ob die Ergebnisse sinnvoll sind.
5. **Visualisiere:** Zeichne immer ein Diagramm, um deine Ergebnisse zu überprüfen.

---

## 🎯 Lernziele überprüfen

Am Ende dieser Übung solltest du folgende Fragen beantworten können:

- [ ] Was ist der Unterschied zwischen Geschwindigkeit und Beschleunigung?
- [ ] Wie lautet die Formel für die durchschnittliche Geschwindigkeit?
- [ ] Wie lautet die Formel für die durchschnittliche Beschleunigung?
- [ ] Wie sieht ein Zeit-Ort-Diagramm für gleichförmige Bewegung aus?
- [ ] Wie sieht ein Zeit-Ort-Diagramm für beschleunigte Bewegung aus?
- [ ] Kannst du die Bewegung eines realistischen Objekts mit Gleichungen modellieren?
