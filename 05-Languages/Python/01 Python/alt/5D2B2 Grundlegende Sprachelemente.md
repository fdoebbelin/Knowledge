---
aliases: 
tags:
  - Fachinformatiker/Module/Python
title: 5D2B2 Grundlegende Sprachelemente
---

## Variablen und Datentypen

In Python können wir verschiedene Datentypen in Variablen speichern. Hier sind einige Beispiele:

```python
# Ganzzahl (Integer)
alter = 25

# Gleitkommazahl (Float)
gewicht = 68.5

# Zeichenkette (String)
name = "Max Mustermann"

# Boolesche Werte (Boolean)
ist_student = True

# Liste
hobbys = ["Lesen", "Schwimmen", "Kochen"]

# Ausgabe der Variablen
print(f"Name: {name}, Alter: {alter}, Gewicht: {gewicht} kg")
print(f"Student: {ist_student}, Hobbys: {hobbys}")
```

## Kontrollstrukturen

### Bedingte Anweisungen (if-elif-else)

Mit bedingten Anweisungen können wir den Programmablauf steuern:

```python
alter = 17

if alter >= 18:
    print("Sie sind volljährig.")
elif alter >= 16:
    print("Sie dürfen Bier und Wein kaufen.")
else:
    print("Sie sind noch minderjährig.")
```

### Schleifen

#### For-Schleife

Die For-Schleife wird verwendet, um über eine Sequenz zu iterieren:

```python
# Iteration über eine Liste
früchte = ["Apfel", "Banane", "Kirsche"]
for frucht in früchte:
    print(f"Ich mag {frucht}.")

# Iteration über einen Zahlenbereich
for i in range(1, 6):
    print(f"Zahl: {i}")
```

#### While-Schleife

Die While-Schleife wird ausgeführt, solange eine Bedingung wahr ist:

```python
zähler = 0
while zähler < 5:
    print(f"Zähler: {zähler}")
    zähler += 1
```

## Funktionen

Funktionen ermöglichen uns, Code zu organisieren und wiederzuverwenden:

```python
def begrüßung(name):
    return f"Hallo, {name}!"

def addiere(a, b):
    return a + b

# Funktionsaufrufe
print(begrüßung("Anna"))
ergebnis = addiere(5, 3)
print(f"5 + 3 = {ergebnis}")
```

## Listen und Dictionaries

### Listen

Listen sind geordnete Sammlungen von Elementen:

```python
# Liste erstellen und manipulieren
zahlen = [1, 2, 3, 4, 5]
zahlen.append(6)
zahlen.remove(3)
print(zahlen)

# Listenkomprehension
quadrate = [x**2 for x in range(1, 6)]
print(quadrate)
```

### Dictionaries

Dictionaries sind Sammlungen von Schlüssel-Wert-Paaren:

```python
# Dictionary erstellen und verwenden
person = {
    "name": "Lisa",
    "alter": 28,
    "beruf": "Ingenieurin"
}

print(f"Name: {person['name']}")
person["hobby"] = "Tanzen"
print(person)
```

## Fehlerbehandlung

Mit try-except können wir Fehler abfangen und behandeln:

```python
try:
    zahl = int(input("Geben Sie eine Zahl ein: "))
    ergebnis = 10 / zahl
    print(f"10 geteilt durch {zahl} ist {ergebnis}")
except ValueError:
    print("Bitte geben Sie eine gültige Zahl ein.")
except ZeroDivisionError:
    print("Die Zahl darf nicht Null sein.")
except Exception as e:
    print(f"Ein Fehler ist aufgetreten: {e}")
```

Diese Übungen decken die grundlegenden Sprachelemente von Python ab. Probieren Sie den Code aus und experimentieren Sie damit, um Ihr Verständnis zu vertiefen.