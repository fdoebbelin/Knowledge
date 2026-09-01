## Einführung

Ein **Set** (Menge) in Python ist eine Sammlung von **einzigartigen** und **ungeordneten** Elementen. Sets eignen sich hervorragend, wenn es darum geht, Duplikate zu vermeiden oder mathematische Mengenoperationen wie Vereinigung, Schnittmenge und Differenz durchzuführen.

## 1. Anlegen eines Sets

### Erklärung

Ein Set wird mit geschweiften Klammern `{}` oder der `set()`-Funktion erstellt. Elemente eines Sets müssen **unveränderlich** sein (z. B. Zahlen, Strings oder Tupel).

### Codebeispiel: Erstellen eines Sets

```python
# Ein einfaches Set erstellen
mein_set = {1, 2, 3, 4, 5}
print("Mein Set:", mein_set)

# Ein Set mit der set()-Funktion
leeres_set = set()
print("Leeres Set:", leeres_set)
```
## 2. Eigenschaften von Sets

### Erklärung

- Ein Set enthält nur **einzigartige** Elemente. Doppelte Einträge werden automatisch entfernt.
- Die Reihenfolge der Elemente in einem Set ist **ungeordnet**.

### Codebeispiel: Einzigartigkeit und Unordnung

```python
# Duplikate werden automatisch entfernt
duplikate_set = {1, 2, 2, 3, 4, 4, 5}
print("Set ohne Duplikate:", duplikate_set)  # {1, 2, 3, 4, 5}

# Die Reihenfolge ist nicht garantiert
mein_set = {5, 3, 1, 4, 2}
print("Ungeordnetes Set:", mein_set)
```
## 3. Hinzufügen und Entfernen von Elementen

### Erklärung

- **Hinzufügen:** Mit `add()` können Sie ein neues Element hinzufügen.
- **Entfernen:** Mit `remove()` oder `discard()` können Sie ein Element entfernen.

### Codebeispiel: Elemente hinzufügen

```python
# Ein Element hinzufügen
mein_set.add(6)
print("Nach Hinzufügen:", mein_set)
```

### Codebeispiel: Elemente entfernen

```python
# Ein Element entfernen
mein_set.remove(3)  # Löst einen Fehler aus, wenn das Element nicht existiert
print("Nach Entfernen von 3:", mein_set)

# Sicheres Entfernen mit discard()
mein_set.discard(10)  # Löst keinen Fehler aus, wenn das Element nicht existiert
print("Nach discard:", mein_set)
```
## 4. Mengenoperationen

### Erklärung

Sets unterstützen mathematische Mengenoperationen wie:

- **Vereinigung:** `|` oder `union()`
- **Schnittmenge:** `&` oder `intersection()`
- **Differenz:** `-` oder `difference()`
- **Symmetrische Differenz:** `^` oder `symmetric_difference()`

### Codebeispiel: Mengenoperationen

```python
set_a = {1, 2, 3, 4}
set_b = {3, 4, 5, 6}

# Vereinigung
print("Vereinigung:", set_a | set_b)  # {1, 2, 3, 4, 5, 6}

# Schnittmenge
print("Schnittmenge:", set_a & set_b)  # {3, 4}

# Differenz
print("Differenz (A - B):", set_a - set_b)  # {1, 2}
print("Differenz (B - A):", set_b - set_a)  # {5, 6}

# Symmetrische Differenz
print("Symmetrische Differenz:", set_a ^ set_b)  # {1, 2, 5, 6}
```
## 5. Iteration über ein Set

### Erklärung

Obwohl Sets ungeordnet sind, können Sie mit einer Schleife über die Elemente iterieren.

### Codebeispiel: Iteration über ein Set

```python
# Iteration über ein Set
mein_set = {1, 2, 3, 4, 5}
for element in mein_set:
    print("Element:", element)
```
## 6. Einsatzmöglichkeiten von Sets

### Erklärung

Sets sind nützlich, um:

- Duplikate aus einer Sammlung zu entfernen.
- Elemente schnell auf ihre Existenz zu überprüfen.
- Mengenoperationen auszuführen.

### Codebeispiel: Duplikate entfernen

```python
# Eine Liste mit Duplikaten
liste = [1, 2, 2, 3, 4, 4, 5]
einzigartige_elemente = set(liste)
print("Ohne Duplikate:", einzigartige_elemente)
```
## 7. Übungen

### Übung 1: Grundlegende Arbeit mit Sets

1. Erstellen Sie ein Set mit den Zahlen 1 bis 5.
2. Fügen Sie die Zahl 6 hinzu.
3. Entfernen Sie die Zahl 3 aus dem Set.
4. Überprüfen Sie, ob die Zahl 4 im Set enthalten ist.
### Übung 2: Mengenoperationen

1. Erstellen Sie zwei Sets: `set_a = {1, 2, 3}` und `set_b = {3, 4, 5}`.
2. Führen Sie die Vereinigung, Schnittmenge und Differenz der beiden Sets aus.
3. Berechnen Sie die symmetrische Differenz der Sets.
## 8. Fazit

Sets sind eine einfache und leistungsstarke Datenstruktur in Python, die sich ideal für Aufgaben eignet, bei denen es auf **Einzigartigkeit** und **Mengenoperationen** ankommt. Sie ermöglichen es, Daten effizient zu verarbeiten und mathematische Konzepte direkt umzusetzen.