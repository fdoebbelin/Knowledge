## Einführung

In der Programmierung sind **Felder** eine der grundlegendsten Datenstrukturen. In Python arbeiten wir dabei häufig mit **Listen** und **Arrays**. Diese Strukturen erlauben es uns, Daten geordnet zu speichern und effizient darauf zuzugreifen.
## 1. Anlegen von Feldern

### Erklärung

In Python wird eine Liste durch eckige Klammern `[]` definiert. Listen können Daten beliebiger Typen enthalten (z. B. Zahlen, Strings oder Objekte). Wenn numerische Berechnungen erforderlich sind, verwenden wir `numpy`-Arrays, die speziell für solche Aufgaben optimiert sind.

### Codebeispiel: Erstellen einer Liste

```python
# Eine einfache Liste erstellen
meine_liste = [10, 20, 30, 40, 50]
print("Meine Liste:", meine_liste)
```
### Codebeispiel: Erstellen eines `numpy`-Arrays

```python
import numpy as np

# Ein einfaches Array mit Zahlen
mein_array = np.array([10, 20, 30, 40, 50])
print("Mein Array:", mein_array)
```
## 2. Zugriff auf Elemente

### Erklärung

Die Elemente in Listen und Arrays werden über Indizes angesprochen. Der Index beginnt bei **0** für das erste Element, **1** für das zweite usw. Negative Indizes zählen von hinten (-1 ist das letzte Element).

### Codebeispiel: Zugriff auf Elemente in einer Liste

```python
# Zugriff auf einzelne Elemente
print("Erstes Element:", meine_liste[0])  # 10
print("Letztes Element:", meine_liste[-1])  # 50
```

### Codebeispiel: Zugriff auf Elemente in einem `numpy`-Array

```python
# Zugriff auf einzelne Elemente in einem Array
print("Erstes Element im Array:", mein_array[0])  # 10
print("Letztes Element im Array:", mein_array[-1])  # 50
```
## 3. Einsatzmöglichkeiten: Listen vs. Arrays

### Erklärung

- **Listen** eignen sich für allgemeine Datenspeicherung, da sie verschiedene Datentypen aufnehmen können.
- **Arrays** (z. B. aus der `numpy`-Bibliothek) sind effizient für numerische Berechnungen und erlauben Operationen auf allen Elementen gleichzeitig.
### Codebeispiel: Einsatz einer Liste (Mischen von Datentypen)

```python
# Liste mit verschiedenen Datentypen
gemischte_liste = [1, "Hallo", 3.14, True]
print("Gemischte Liste:", gemischte_liste)
```
### Codebeispiel: Numerische Berechnungen mit `numpy`

```python
# Elementweise Operationen in einem Array
verdoppelt = mein_array * 2
print("Verdoppelte Werte:", verdoppelt)

# Hinzufügen eines Wertes zu jedem Element
plus_fünf = mein_array + 5
print("Plus 5 zu jedem Element:", plus_fünf)
```
## 4. Übungen

### Übung 1: Arbeiten mit Listen

1. Erstellen Sie eine Liste mit den Zahlen von 1 bis 5.
2. Greifen Sie auf das zweite und das letzte Element der Liste zu.
3. Fügen Sie die Zahl 6 zur Liste hinzu.
4. Entfernen Sie die Zahl 3 aus der Liste.
### Übung 2: Arbeiten mit Arrays

1. Erstellen Sie ein `numpy`-Array mit den Zahlen von 1 bis 5.
2. Multiplizieren Sie jedes Element im Array mit 10.
3. Addieren Sie 5 zu jedem Element im Array.
4. Greifen Sie auf das dritte Element zu.
## 5. Fazit

Felder in Python sind vielseitig und leistungsfähig. **Listen** sind flexibel und universell einsetzbar, während **Arrays** speziell für numerische Berechnungen optimiert sind. Üben Sie den Umgang mit diesen Datenstrukturen, um sie in Ihren Projekten effizient einzusetzen.