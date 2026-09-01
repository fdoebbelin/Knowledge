## M01: Kinematik – Bewegung beschreiben

**Beispiel:** Ein Fahrrad fährt mit konstanter Geschwindigkeit von 5 m/s. Wie weit kommt es in 10 Sekunden?

$$
v = \frac{s}{t} \Rightarrow s = v \cdot t
$$

```python
v = 5  # m/s
t = 10  # s
s = v * t
print(f"Weg: {s} m")
```

**Weitere Formeln:**  
- $$a = \frac{\Delta v}{\Delta t}$$  
- $$s = \frac{1}{2} a t^2$$

## M02: Newtonsche Mechanik – Kräfte

**Beispiel:** Ein Einkaufswagen (10 kg) wird mit 2 m/s² beschleunigt. Welche Kraft ist nötig?

$$
F = m \cdot a
$$

```python
m = 10  # kg
a = 2   # m/s²
F = m * a
print(f"Kraft: {F} N")
```

**Weitere Formeln:**  
- $$F_G = m \cdot g$$ (Gewichtskraft)

## M03: Impuls und Kollisionen

**Beispiel:** Ein Ball (0.5 kg) fliegt mit 10 m/s. Wie groß ist sein Impuls?

$$
p = m \cdot v
$$

```python
m = 0.5  # kg
v = 10   # m/s
p = m * v
print(f"Impuls: {p} kg·m/s")
```

**Weitere Anwendung:**  
Zwei Körper kollidieren elastisch: $$p_\text{vor} = p_\text{nach}$$

## M04: Energie und Arbeit

**Beispiel:** Wie viel Energie hat ein 2 kg schwerer Ball, der sich mit 3 m/s bewegt?

$$
E_{kin} = \frac{1}{2} m v^2
$$

```python
m = 2  # kg
v = 3  # m/s
E_kin = 0.5 * m * v**2
print(f"Kinetische Energie: {E_kin} J")
```

**Weitere Formeln:**  
- $$E_{pot} = m g h$$  
- $$W = F \cdot s$$

## M05: Schwingungen und Wellen

**Beispiel:** Eine Schwingung hat eine Frequenz von 2 Hz. Wie lange dauert eine Periode?

$$
T = \frac{1}{f}
$$

```python
f = 2  # Hz
T = 1 / f
print(f"Periodendauer: {T} s")
```

**Weitere Formeln:**  
- $$v = \lambda \cdot f$$ (Wellengeschwindigkeit)

## M06: Elektrizität

**Beispiel:** Ein Gerät mit 12 V Spannung und 4 Ohm Widerstand – wie viel Strom fließt?

$$
I = \frac{U}{R}
$$

```python
U = 12  # Volt
R = 4   # Ohm
I = U / R
print(f"Stromstärke: {I} A")
```

**Weitere Formeln:**  
- $$F = k \cdot \frac{q_1 q_2}{r^2}$$ (Coulomb-Kraft)

## M07: Optik – Lichtbrechung

**Beispiel:** Licht geht von Luft (n=1.0) in Glas (n=1.5) bei 30° Einfallswinkel. Brechungswinkel?

$$
n_1 \sin(\alpha_1) = n_2 \sin(\alpha_2)
$$

```python
import math
n1 = 1.0
n2 = 1.5
alpha1_deg = 30
alpha1 = math.radians(alpha1_deg)
sin_alpha2 = n1 * math.sin(alpha1) / n2
alpha2 = math.degrees(math.asin(sin_alpha2))
print(f"Brechungswinkel: {alpha2:.2f}°")
```

## M08: Wärmelehre

**Beispiel:** 1 Liter Wasser (1 kg) wird um 20 °C erwärmt. Wie viel Wärme wird benötigt?

$$
Q = m c \Delta T
$$

```python
m = 1     # kg
c = 4180  # J/(kg·K) für Wasser
dT = 20   # °C
Q = m * c * dT
print(f"Wärmemenge: {Q} J")
```

---

## Übersichtstabelle

| Modul | Formel | Python-Anwendung |
|-------|--------|------------------|
| M01 | $$s = v \cdot t$$ | `s = v * t` |
| M02 | $$F = m \cdot a$$ | `F = m * a` |
| M03 | $$p = m \cdot v$$ | `p = m * v` |
| M04 | $$E_{kin} = 0.5 m v^2$$ | `E_kin = 0.5 * m * v**2` |
| M05 | $$T = \frac{1}{f}$$ | `T = 1 / f` |
| M06 | $$I = \frac{U}{R}$$ | `I = U / R` |
| M07 | $$n_1 \sin\alpha_1 = n_2 \sin\alpha_2$$ | `alpha2 = asin(...)` |
| M08 | $$Q = mc \Delta T$$ | `Q = m * c * dT` |
