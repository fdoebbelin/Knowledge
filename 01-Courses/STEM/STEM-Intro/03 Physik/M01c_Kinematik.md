# Modul 1 – Kinematik: Bewegung beschreiben
## Ausführliche Lösungen für Dozenten

---

## 🎯 Hinweis zur Nutzung dieser Datei

Diese Datei enthält die **vollständigen Lösungen** aller Aufgaben aus der Übungsdatei (M01b_Kinematik.md). Sie ist für Dozenten oder zur Selbstkontrolle bestimmt. Zu jeder Lösung werden Erklärungen, mögliche Alternativlösungen und didaktische Hinweise gegeben.

---

## 🔍 Lösung Aufgabe 1: Grundbegriffe verstehen

### Lösung 1.1: Ort und Weg unterscheiden

**Gegeben:**
- Start: Berlin
- Zwischenstopp: Leipzig (190 km von Berlin)
- Ende: Dresden (190 km von Leipzig)

**Lösung:**

**Frage 1: Verschiebung vom Start zum Endziel**

Die Verschiebung ist der direkte Abstand vom Startpunkt zum Endpunkt (als Luftlinie). In diesem Fall:
- Berlin → Dresden: ca. 190 km (ungefähr, hängt vom genauen Pfad ab)
- **Verschiebung ≈ 190 km** (Anmerkung: Dieser Wert ist eine Annäherung; die exakte Luftlinienentfernung beträgt etwa 187 km)

**Frage 2: Weg, den das Auto gefahren ist**

Der Weg ist die tatsächliche Strecke auf der Straße:
- Berlin → Leipzig: 190 km
- Leipzig → Dresden: 190 km
- **Gesamtweg = 190 + 190 = 380 km**

**Frage 3: Sind Verschiebung und Weg gleich?**

**Antwort:** Nein, sie sind nicht gleich.
- **Verschiebung ≈ 190 km** (direkter Weg, Luftlinie)
- **Weg = 380 km** (tatsächliche gefahrene Strecke auf der Straße)

**Warum nicht?** Der Weg folgt der Straße und ist länger als die direkte Luftlinie. Verschiebung ist ein Vektor (Richtung und Betrag), während Weg immer die tatsächliche Länge der Bahn ist.

**Didaktischer Hinweis:** Dies ist ein wichtiges Konzept! Viele Lernende verwechseln diese Begriffe. Es hilft, darauf hinzuweisen, dass nur die Verschiebung null sein kann (wenn man am gleichen Ort endet), aber der Weg immer positiv ist.

---

## 🔍 Lösung Aufgabe 2: Geschwindigkeit berechnen

### Lösung 2.1: Durchschnittsgeschwindigkeit

**Gegeben:**
- Strecke: 10 km = 10.000 m
- Zeit: 1 Stunde = 3600 s

**Lösung:**

```python
# Gegeben
strecke = 10000  # in Metern (10 km = 10.000 m)
zeit = 3600      # in Sekunden (1 h = 3600 s)

# Berechne die Durchschnittsgeschwindigkeit
durchschnitts_geschwindigkeit = strecke / zeit
print(f"Die Durchschnittsgeschwindigkeit beträgt {durchschnitts_geschwindigkeit:.2f} m/s")

# Umrechnung in km/h
# Formel: m/s * 3.6 = km/h
durchschnitts_geschwindigkeit_kmh = durchschnitts_geschwindigkeit * 3.6
print(f"Die Durchschnittsgeschwindigkeit beträgt {durchschnitts_geschwindigkeit_kmh:.2f} km/h")
```

**Ergebnis:**
- **Durchschnittsgeschwindigkeit = 10.000 m / 3600 s ≈ 2,78 m/s**
- **Durchschnittsgeschwindigkeit = 10 km/h**

**Alternativlösung:** Wenn nur in km/h rechnen:
- Durchschnittsgeschwindigkeit = 10 km / 1 h = 10 km/h

**Reflexionsfrage – Antwort:** 
Die Durchschnittsgeschwindigkeit ist **nicht** die gleiche wie die momentane Geschwindigkeit. 
- **Durchschnittsgeschwindigkeit:** Gesamtweg / Gesamtzeit (gilt für die ganze Strecke)
- **Momentangeschwindigkeit:** Geschwindigkeit an einem bestimmten Augenblick

**Beispiel:** Der Läufer könnte langsamer starten, dann schneller werden, dann wieder langsamer werden. Die Durchschnittsgeschwindigkeit würde 10 km/h sein, aber die Geschwindigkeit im einzelnen Moment könnte 8 km/h oder 12 km/h sein.

---

### Lösung 2.2: Aus einem Diagramm ablesen

**Gegeben:** Zeit-Ort-Diagramm mit:
- Zeit: [0, 1, 2, 3, 4, 5] Sekunden
- Ort: [0, 10, 20, 30, 40, 50] Meter

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

**Lösungen:**

1. **Was kannst du über die Bewegung aussagen?**

**Antwort:** Die Bewegung ist **gleichförmig** (konstante Geschwindigkeit). 
- **Begründung:** Die Punkte liegen auf einer geraden Linie, was bedeutet, dass der Ort linear mit der Zeit zunimmt. Wenn die Bewegung beschleunigt wäre, würde die Kurve parabelförmig gekrümmt sein.

2. **Berechne die Geschwindigkeit zwischen t = 0s und t = 5s.**

```python
# Berechnung der Geschwindigkeit
delta_s = 50 - 0  # Ort ändert sich von 0 m auf 50 m
delta_t = 5 - 0   # Zeit ändert sich von 0 s auf 5 s

v = delta_s / delta_t
print(f"Geschwindigkeit = {v} m/s")
```

**Antwort:** v = 50 m / 5 s = **10 m/s**

**Alternativlösung:** Nutze zwei beliebige Punkte aus dem Diagramm (da die Geschwindigkeit konstant ist):
- Zwischen t = 1s und t = 2s: v = (20 - 10) / (2 - 1) = 10 m/s
- Zwischen t = 3s und t = 4s: v = (40 - 30) / (4 - 3) = 10 m/s

3. **Was würde es bedeuten, wenn die Linie gekrümmt (parabelförmig) statt gerade wäre?**

**Antwort:** Die Linie würde gekrümmt, wenn die Bewegung **beschleunigt** wäre. Das würde bedeuten:
- Die Geschwindigkeit ändert sich mit der Zeit
- Die Beschleunigung ist nicht null
- Im Zeit-Geschwindigkeit-Diagramm würde eine steigende Linie erscheinen

---

## 🔍 Lösung Aufgabe 3: Beschleunigung verstehen

### Lösung 3.1: Beschleunigung berechnen

**Gegeben:**
- Anfangsgeschwindigkeit: 0 km/h = 0 m/s
- Endgeschwindigkeit: 40 m/s
- Zeit: 8 Sekunden

**Lösung:**

```python
# Gegeben
v_anfang = 0     # Anfangsgeschwindigkeit in m/s
v_ende = 40      # Endgeschwindigkeit in m/s
delta_v = v_ende - v_anfang

t_anfang = 0     # Anfangszeit in s
t_ende = 8       # Endzeit in s
delta_t = t_ende - t_anfang

# Berechne die Beschleunigung
beschleunigung = delta_v / delta_t
print(f"Die Beschleunigung beträgt {beschleunigung} m/s²")
```

**Ergebnis:**
- **Beschleunigung = (40 - 0) m/s / 8 s = 5 m/s²**

**Interpretation:** Das Auto wird jede Sekunde um 5 m/s schneller.

**Reflexionsfrage – Antwort:**
Eine **negative Beschleunigung** bedeutet, dass die Geschwindigkeit abnimmt – das Objekt wird langsamer. Dies wird auch **Verzögerung** oder **Bremsvorgang** genannt.

**Beispiel:**
- Beschleunigung = +2 m/s² → Objekt wird schneller
- Beschleunigung = -2 m/s² → Objekt wird langsamer

---

### Lösung 3.2: Geschwindigkeit über Zeit berechnen

**Gegeben:**
- Anfangsgeschwindigkeit: v₀ = 0 m/s
- Beschleunigung: a = 2 m/s²

**Lösung:**

```python
# Gegeben
v0 = 0  # Anfangsgeschwindigkeit in m/s
a = 2   # Beschleunigung in m/s²

# Berechne die Geschwindigkeit nach verschiedenen Zeiten
zeiten = [1, 2, 3, 4, 5]

for t in zeiten:
    v = v0 + a * t
    print(f"Nach t = {t} s ist die Geschwindigkeit v = {v} m/s")
```

**Ergebnisse:**
- Nach t = 1 s: v = 0 + 2 × 1 = **2 m/s**
- Nach t = 2 s: v = 0 + 2 × 2 = **4 m/s**
- Nach t = 3 s: v = 0 + 2 × 3 = **6 m/s**
- Nach t = 4 s: v = 0 + 2 × 4 = **8 m/s**
- Nach t = 5 s: v = 0 + 2 × 5 = **10 m/s**

**Reflexionsfrage – Antwort:**
Das Zeit-Geschwindigkeit-Diagramm würde eine **steigende gerade Linie** sein, die bei (0, 0) startet und mit einer Steigung von 2 ansteigt. Mathematisch: v(t) = 2t

```python
import matplotlib.pyplot as plt
import numpy as np

t = np.linspace(0, 5, 100)
v = 0 + 2 * t

plt.plot(t, v, 'r-', linewidth=2)
plt.xlabel('Zeit (s)')
plt.ylabel('Geschwindigkeit (m/s)')
plt.title('Zeit-Geschwindigkeit-Diagramm')
plt.grid(True, alpha=0.3)
plt.show()
```

---

## 🎬 Lösung Aufgabe 4: Bewegungsgleichungen visualisieren

### Lösung 4.1: Gleichförmige Bewegung zeichnen

**Gegeben:**
- Anfangsort: s₀ = 0 m
- Geschwindigkeit: v = 5 m/s
- Zeit: 0 bis 10 Sekunden

**Lösung:**

```python
import matplotlib.pyplot as plt
import numpy as np

# Gegeben
s0 = 0      # Anfangsort in m
v = 5       # Geschwindigkeit in m/s

# Zeit von 0 bis 10 Sekunden
t = np.linspace(0, 10, 100)

# Berechne den Ort für jeden Zeitpunkt: s(t) = s0 + v*t
s = s0 + v * t

# Zeichne das Diagramm
plt.figure(figsize=(10, 6))
plt.plot(t, s, 'b-', linewidth=2, label='s(t) = 0 + 5·t')
plt.xlabel('Zeit (s)', fontsize=12)
plt.ylabel('Ort (m)', fontsize=12)
plt.title('Gleichförmige Bewegung: Zeit-Ort-Diagramm', fontsize=14)
plt.grid(True, alpha=0.3)
plt.legend(fontsize=10)
plt.show()

# Nach 10 Sekunden hat das Fahrrad folgende Position:
s_final = s0 + v * 10
print(f"Nach 10 Sekunden ist das Fahrrad bei s = {s_final} m")
```

**Ergebnis:** Eine gerade Linie vom Punkt (0, 0) zum Punkt (10, 50). Das Fahrrad ist nach 10 Sekunden 50 m weit gefahren.

**Reflexionsfrage – Antwort:**
Das Zeit-Geschwindigkeit-Diagramm würde eine **horizontale Linie** sein (konstant bei 5 m/s), da die Geschwindigkeit nicht ändert.

```python
# Zeit-Geschwindigkeit-Diagramm für gleichförmige Bewegung
v_konstant = np.ones_like(t) * v  # Konstante Geschwindigkeit

plt.figure(figsize=(10, 6))
plt.plot(t, v_konstant, 'r-', linewidth=2, label='v = 5 m/s (konstant)')
plt.xlabel('Zeit (s)', fontsize=12)
plt.ylabel('Geschwindigkeit (m/s)', fontsize=12)
plt.title('Gleichförmige Bewegung: Zeit-Geschwindigkeit-Diagramm', fontsize=14)
plt.grid(True, alpha=0.3)
plt.legend(fontsize=10)
plt.ylim([0, 6])
plt.show()
```

---

### Lösung 4.2: Beschleunigte Bewegung zeichnen

**Gegeben:**
- Anfangsort: s₀ = 0 m
- Anfangsgeschwindigkeit: v₀ = 0 m/s
- Beschleunigung: a = 1 m/s²
- Zeit: 0 bis 10 Sekunden

**Lösung:**

```python
import matplotlib.pyplot as plt
import numpy as np

# Gegeben
s0 = 0      # Anfangsort in m
v0 = 0      # Anfangsgeschwindigkeit in m/s
a = 1       # Beschleunigung in m/s²

# Zeit von 0 bis 10 Sekunden
t = np.linspace(0, 10, 100)

# Berechne den Ort für jeden Zeitpunkt: s(t) = s0 + v0*t + 0.5*a*t²
s = s0 + v0 * t + 0.5 * a * t**2

# Zeichne das Diagramm
plt.figure(figsize=(10, 6))
plt.plot(t, s, 'r-', linewidth=2, label='s(t) = 0 + 0·t + 0.5·1·t²')
plt.xlabel('Zeit (s)', fontsize=12)
plt.ylabel('Ort (m)', fontsize=12)
plt.title('Beschleunigte Bewegung: Zeit-Ort-Diagramm', fontsize=14)
plt.grid(True, alpha=0.3)
plt.legend(fontsize=10)
plt.show()

# Nach 10 Sekunden hat das Auto folgende Position:
s_final = s0 + v0 * 10 + 0.5 * a * 10**2
print(f"Nach 10 Sekunden ist das Auto bei s = {s_final} m")
```

**Ergebnis:** Eine Parabel (gekrümmte Kurve), die bei (0, 0) startet. Nach 10 Sekunden ist das Auto 50 m weit gefahren.

**Reflexionsfrage – Antwort:**
Das Zeit-Ort-Diagramm ist parabelförmig, weil die Funktion \(s(t) = 0.5 \cdot 1 \cdot t^2\) eine quadratische Funktion ist. Quadratische Funktionen haben immer eine parabelförmige Form. Diese nicht-lineare Form zeigt, dass die Geschwindigkeit sich ändert (das Objekt wird schneller).

**Zusätzliche Visualisierung: Zeit-Geschwindigkeit-Diagramm**

```python
# Zeit-Geschwindigkeit-Diagramm für beschleunigte Bewegung
v = v0 + a * t  # Geschwindigkeit über Zeit

plt.figure(figsize=(10, 6))
plt.plot(t, v, 'g-', linewidth=2, label='v(t) = 0 + 1·t')
plt.xlabel('Zeit (s)', fontsize=12)
plt.ylabel('Geschwindigkeit (m/s)', fontsize=12)
plt.title('Beschleunigte Bewegung: Zeit-Geschwindigkeit-Diagramm', fontsize=14)
plt.grid(True, alpha=0.3)
plt.legend(fontsize=10)
plt.show()

# Nach 10 Sekunden hat das Auto folgende Geschwindigkeit:
v_final = v0 + a * 10
print(f"Nach 10 Sekunden ist die Geschwindigkeit v = {v_final} m/s")
```

**Ergebnis:** Eine steigende gerade Linie, die bei (0, 0) startet und bei (10, 10) endet. Nach 10 Sekunden hat das Auto eine Geschwindigkeit von 10 m/s.

---

## 🎨 Lösung Aufgabe 5: Vergleich gleichförmige vs. beschleunigte Bewegung

**Lösung:**

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
plt.figure(figsize=(12, 6))
plt.plot(t, s_gleichfoermig, 'b-', linewidth=2, label='Gleichförmige Bewegung (v=2 m/s)')
plt.plot(t, s_beschleunigt, 'r-', linewidth=2, label='Beschleunigte Bewegung (a=0.5 m/s²)')
plt.xlabel('Zeit (s)', fontsize=12)
plt.ylabel('Ort (m)', fontsize=12)
plt.title('Vergleich: Gleichförmige vs. Beschleunigte Bewegung', fontsize=14)
plt.legend(fontsize=10)
plt.grid(True, alpha=0.3)
plt.show()
```

**Reflexionsfragen – Antworten:**

1. **Welche Bewegung wird schneller?**

**Antwort:** Die **beschleunigte Bewegung** wird schneller. 
- Anfangs (t = 0-2 s) ist die gleichförmige Bewegung schneller
- Ab ungefähr t ≈ 4 s überholt die beschleunigte Bewegung die gleichförmige Bewegung
- Nach t = 10 s hat die beschleunigte Bewegung die gleichförmige Bewegung weit überholt

**Begründung:** Bei der beschleunigten Bewegung nimmt die Geschwindigkeit kontinuierlich zu, während sie bei der gleichförmigen Bewegung konstant bleibt. Daher wird die beschleunigte Bewegung langfristig immer schneller.

2. **Nach welcher Zeit überholt die beschleunigte Bewegung die gleichförmige Bewegung?**

```python
# Finde den Schnittpunkt
# 2*t = 0.5 * 0.5 * t²
# 2*t = 0.25*t²
# 0 = 0.25*t² - 2*t
# 0 = t * (0.25*t - 2)
# t = 0 oder t = 2/0.25 = 8

t_schnittpunkt = 8

print(f"Die beschleunigte Bewegung überholt die gleichförmige Bewegung bei t = {t_schnittpunkt} s")
```

**Antwort:** Nach etwa **t = 8 Sekunden** überholt die beschleunigte Bewegung die gleichförmige Bewegung.

3. **Wie würden die Kurven aussehen, wenn die Beschleunigung größer wäre?**

**Antwort:** Wenn die Beschleunigung größer wäre (z. B. a = 1 m/s² statt a = 0.5 m/s²):
- Die rote Parabel würde **steiler** werden
- Die beschleunigte Bewegung würde die gleichförmige Bewegung **früher** überholen
- Der Unterschied zwischen den beiden Kurven würde **größer** werden

```python
# Beispiel mit größerer Beschleunigung
a_groesser = 1.0  # m/s²
s_beschleunigt_groesser = 0.5 * a_groesser * t**2

plt.figure(figsize=(12, 6))
plt.plot(t, s_gleichfoermig, 'b-', linewidth=2, label='Gleichförmige Bewegung (v=2 m/s)')
plt.plot(t, s_beschleunigt, 'r-', linewidth=2, label='Beschleunigte Bewegung (a=0.5 m/s²)')
plt.plot(t, s_beschleunigt_groesser, 'g--', linewidth=2, label='Beschleunigte Bewegung (a=1.0 m/s²)')
plt.xlabel('Zeit (s)', fontsize=12)
plt.ylabel('Ort (m)', fontsize=12)
plt.title('Einfluss der Beschleunigung', fontsize=14)
plt.legend(fontsize=10)
plt.grid(True, alpha=0.3)
plt.xlim([0, 10])
plt.ylim([0, 50])
plt.show()
```

---

## 🎬 Lösung Aufgabe 6: Realistische Szenarien

### Lösung 6.1: Auto beschleunigt beim Ampelstart

**Gegeben:**
- Phase 1 (Beschleunigung): a₁ = 4 m/s², t₁ = 5 s, v₀ = 0 m/s
- Phase 2 (Bremsvorgang): a₂ = -3 m/s² (negative Beschleunigung)

**Lösung:**

```python
# ========== PHASE 1: BESCHLEUNIGUNG ==========

v0 = 0      # Anfangsgeschwindigkeit in m/s (Auto startet)
a1 = 4      # Beschleunigung in m/s²
t1 = 5      # Zeit der Beschleunigung in s

# Geschwindigkeit nach 5 Sekunden (beim Erreichen der roten Ampel)
v_nach_5s = v0 + a1 * t1
print(f"Geschwindigkeit nach 5s (bei der Ampel): {v_nach_5s} m/s")
print(f"Das entspricht {v_nach_5s * 3.6} km/h")

# Weg während der Beschleunigung
s1 = v0 * t1 + 0.5 * a1 * t1**2
print(f"Weg während der Beschleunigung: {s1} m")

# ========== PHASE 2: BREMSVORGANG ==========

v_start_bremsvorgang = v_nach_5s  # Anfangsgeschwindigkeit beim Bremsvorgang
a2 = -3     # Beschleunigung beim Bremsvorgang (negativ = Bremsen)
v_end = 0   # Endgeschwindigkeit (Auto steht still)

# Zeit zum Bremsen
# v_end = v_start_bremsvorgang + a2 * t2
# 0 = v_start_bremsvorgang + a2 * t2
# t2 = -v_start_bremsvorgang / a2
t2 = -v_start_bremsvorgang / a2
print(f"Zeit zum Bremsen: {t2} s")

# Weg während des Bremsens
s2 = v_start_bremsvorgang * t2 + 0.5 * a2 * t2**2
print(f"Weg während des Bremsens: {s2} m")

# Gesamtweg
s_gesamt = s1 + s2
print(f"Gesamtweg: {s_gesamt} m")

# ========== VISUALISIERUNG ==========

import matplotlib.pyplot as plt
import numpy as np

# Phase 1: Beschleunigung
t_phase1 = np.linspace(0, 5, 100)
s_phase1 = v0 * t_phase1 + 0.5 * a1 * t_phase1**2
v_phase1 = v0 + a1 * t_phase1

# Phase 2: Bremsvorgang
t_phase2 = np.linspace(5, 5 + t2, 100)
s_phase2 = s1 + v_start_bremsvorgang * (t_phase2 - 5) + 0.5 * a2 * (t_phase2 - 5)**2
v_phase2 = v_start_bremsvorgang + a2 * (t_phase2 - 5)

# Kombiniere die Phasen
t_gesamt = np.concatenate([t_phase1, t_phase2])
s_gesamt_array = np.concatenate([s_phase1, s_phase2])
v_gesamt_array = np.concatenate([v_phase1, v_phase2])

# Diagramme
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 8))

# Zeit-Ort-Diagramm
ax1.plot(t_phase1, s_phase1, 'b-', linewidth=2, label='Beschleunigung')
ax1.plot(t_phase2, s_phase2, 'r-', linewidth=2, label='Bremsvorgang')
ax1.axvline(x=5, color='gray', linestyle='--', alpha=0.5, label='Ampel (t=5s)')
ax1.set_xlabel('Zeit (s)', fontsize=12)
ax1.set_ylabel('Ort (m)', fontsize=12)
ax1.set_title('Auto bei Ampel: Zeit-Ort-Diagramm', fontsize=14)
ax1.legend(fontsize=10)
ax1.grid(True, alpha=0.3)

# Zeit-Geschwindigkeit-Diagramm
ax2.plot(t_phase1, v_phase1, 'b-', linewidth=2, label='Beschleunigung')
ax2.plot(t_phase2, v_phase2, 'r-', linewidth=2, label='Bremsvorgang')
ax2.axvline(x=5, color='gray', linestyle='--', alpha=0.5, label='Ampel (t=5s)')
ax2.set_xlabel('Zeit (s)', fontsize=12)
ax2.set_ylabel('Geschwindigkeit (m/s)', fontsize=12)
ax2.set_title('Auto bei Ampel: Zeit-Geschwindigkeit-Diagramm', fontsize=14)
ax2.legend(fontsize=10)
ax2.grid(True, alpha=0.3)

plt.tight_layout()
plt.show()
```

**Antworten:**

1. **Geschwindigkeit bei der roten Ampel (nach 5 s):**
   - v = 0 + 4 × 5 = **20 m/s** (= 72 km/h)

2. **Zeit zum Bremsen:**
   - t₂ = -20 / (-3) = **6,67 s**

3. **Weg während des Bremsens:**
   - s₂ = 20 × 6,67 + 0,5 × (-3) × 6,67² = 133,33 - 66,67 = **66,67 m**

4. **Gesamtweg:**
   - s_gesamt = 50 + 66,67 = **116,67 m**

---

### Lösung 6.2: Dein eigenes Szenario

Diese Aufgabe ist offen und lässt Lernenden Raum für eigene Kreativität. Hier ist ein Beispiel mit einem **Flugzeug beim Starten:**

**Beispiel-Szenario: Flugzeug beim Starten**

```python
# ========== SZENARIO: FLUGZEUG BEIM STARTEN ==========

import matplotlib.pyplot as plt
import numpy as np

# Geschätzte Werte
v0 = 0          # Anfangsgeschwindigkeit in m/s (startet aus dem Stand)
v_end = 80      # Endgeschwindigkeit (Abhebegeschwindigkeit) in m/s
a = 5           # Beschleunigung in m/s² (Flugzeuge beschleunigen relativ langsam)

# ========== BERECHNUNGEN ==========

# Berechne die Zeit
t = (v_end - v0) / a
print(f"Zeit zum Abheben: {t} s")

# Berechne den Weg
s = v0 * t + 0.5 * a * t**2
print(f"Startweglänge: {s} m")

# ========== VISUALISIERUNG ==========

# Zeitarray
t_array = np.linspace(0, t, 100)

# Ort und Geschwindigkeit
s_array = v0 * t_array + 0.5 * a * t_array**2
v_array = v0 + a * t_array

# Diagramme
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))

# Zeit-Ort-Diagramm
ax1.plot(t_array, s_array, 'b-', linewidth=2)
ax1.set_xlabel('Zeit (s)', fontsize=12)
ax1.set_ylabel('Ort (m)', fontsize=12)
ax1.set_title('Flugzeug beim Starten: Zeit-Ort-Diagramm', fontsize=14)
ax1.grid(True, alpha=0.3)

# Zeit-Geschwindigkeit-Diagramm
ax2.plot(t_array, v_array, 'r-', linewidth=2)
ax2.set_xlabel('Zeit (s)', fontsize=12)
ax2.set_ylabel('Geschwindigkeit (m/s)', fontsize=12)
ax2.set_title('Flugzeug beim Starten: Zeit-Geschwindigkeit-Diagramm', fontsize=14)
ax2.grid(True, alpha=0.3)

plt.tight_layout()
plt.show()
```

**Ergebnisse für das Flugzeug-Beispiel:**
- **Zeit zum Abheben:** t = 80 / 5 = **16 Sekunden**
- **Startweglänge:** s = 0 + 0,5 × 5 × 16² = **640 Meter**

**Didaktischer Hinweis für Dozenten:**
- Ermutigen Sie Lernende, realistische Werte zu recherchieren
- Diskutieren Sie die Unterschiede zwischen verschiedenen Fahrzeugen (Auto, Zug, Flugzeug, Rakete)
- Nutzen Sie die Gelegenheit, über Sicherheit zu sprechen (z. B. Bremsweglängen im Straßenverkehr)

---

## 🔗 Weiterführende Literatur und Ressourcen

- **Halliday, Resnick, Walker:** Physik (Fundamentals of Physics) – Standardwerk für Klassische Mechanik
- **Python NumPy & Matplotlib Dokumentation:** https://numpy.org/ und https://matplotlib.org/
- **PhET Interaktive Simulationen:** https://phet.colorado.edu/ (kostenlose Physik-Simulationen)
- **Khan Academy:** https://de.khanacademy.org/ (Video-Tutorials zu Kinematik)
- **Nature of Code (Daniel Shiffman):** https://nature-of-code-deutsch.info/ (Programmierung von Physik-Simulationen)

---

## 💡 Zusätzliche Tipps für Dozenten

1. **Differenzierung:** Lernende mit unterschiedlichem Leistungsniveau können bei verschiedenen Aufgaben aussteigen oder weitermachen
2. **Projektideen:** Fördern Sie Lernende, ihre eigenen Szenarien zu programmieren (z. B. Videospiel-Charaktere mit Bewegung)
3. **Fehleranalyse:** Nutzen Sie häufige Fehler (z. B. Verwechslung von Geschwindigkeit und Beschleunigung) als Lehrgelegenheiten
4. **Verbindung zur Realität:** Zeigen Sie Anwendungen in Alltag, Technik und Industrie
