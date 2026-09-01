# M02a – Kontrolle des Programmflusses: Bedingte Anweisungen und Schleifen

## 🎯 Lernziel

In diesem Modul lernst du, wie du den Ablauf deines Programms steuern kannst. Mit **bedingten Anweisungen** (if, elif, else) triffst du Entscheidungen, und mit **Schleifen** (for, while) wiederholst du Anweisungen automatisch. Dies sind grundlegende Werkzeuge der Programmierung.

**Anwendungen im MINT-Bereich:**
- Fehlerbehandlung in wissenschaftlichen Simulationen
- Iterative Berechnungen (z. B. Approximationen)
- Automatische Datenverarbeitung

---

## 📚 Teil 1: Bedingte Anweisungen (`if`, `elif`, `else`)

### Was sind bedingte Anweisungen?

Stell dir vor, du hast einen Geldautomaten. Wenn genug Geld auf deinem Konto ist, gibt er Geld aus. Sonst bricht er ab. Das ist eine **Bedingung**.

In Python funktioniert das so:

```python
alter = 18

if alter >= 18:
    print("Du darfst wählen!")
else:
    print("Du musst noch ein paar Jahre warten.")
```

**Ausgabe:** `Du darfst wählen!`

### Syntax erklärt

```text
if <Bedingung>:
    # Code hier wird ausgeführt, wenn Bedingung WAHR ist
else:
    # Code hier wird ausgeführt, wenn Bedingung FALSCH ist
```

**Wichtig:** Der Code unter `if` muss **eingerückt** sein (4 Leerzeichen oder 1 Tab). Das ist keine optionale Formatierung – Python benötigt das!

### Beispiel: Temperaturkontrolle

```python
temperatur = 25

if temperatur > 30:
    print("Es ist sehr heiß!")
elif temperatur > 20:
    print("Angenehm warm")
elif temperatur > 10:
    print("Es ist kühl")
else:
    print("Es ist kalt")
```

**Ausgabe:** `Angenehm warm`

### Was ist `elif`?

`elif` bedeutet „else if" (sonst wenn). Mit `elif` kannst du mehrere Bedingungen hintereinander prüfen. Das Programm prüft sie der Reihe nach und stoppt, sobald es eine wahre Bedingung findet.

### Vergleichsoperatoren

Um Bedingungen zu schreiben, brauchst du diese Operatoren:

| Operator | Bedeutung | Beispiel |
|----------|-----------|----------|
| `==` | gleich | `5 == 5` → True |
| `!=` | nicht gleich | `5 != 3` → True |
| `>` | größer als | `10 > 5` → True |
| `<` | kleiner als | `3 < 5` → True |
| `>=` | größer oder gleich | `5 >= 5` → True |
| `<=` | kleiner oder gleich | `3 <= 5` → True |

### Vorsicht: `=` vs. `==`

- **`=`** ist ein Zuweisungsoperator (Variable setzen)
- **`==`** ist ein Vergleichsoperator (prüfen, ob zwei Werte gleich sind)

```python
x = 5      # x wird auf 5 gesetzt
x == 5     # prüft, ob x gleich 5 ist (True)
```

### Mehrere Bedingungen kombinieren

Mit `and` und `or` kannst du mehrere Bedingungen zusammenfassen:

```python
alter = 20
hat_flugschein = True

if alter >= 18 and hat_flugschein:
    print("Du darfst allein fliegen!")
else:
    print("Das ist leider nicht möglich.")
```

**Ausgabe:** `Du darfst allein fliegen!`

Oder mit `or`:

```python
tag = "Samstag"

if tag == "Samstag" or tag == "Sonntag":
    print("Wochenende!")
else:
    print("Arbeitstag")
```

**Ausgabe:** `Wochenende!`

---

## 🔄 Teil 2: Schleifen

### Was sind Schleifen?

Schleifen wiederholen Code automatisch, ohne dass du ihn mehrmals tippen musst.

**Beispiel:** Du willst die Zahlen 1 bis 5 ausdrucken.

Ohne Schleife:
```python
print(1)
print(2)
print(3)
print(4)
print(5)
```

Mit Schleife:
```python
for i in range(1, 6):
    print(i)
```

Viel kürzer, oder?

### `for`-Schleife – Wiederholung mit bekannter Anzahl

Die `for`-Schleife ist perfekt, wenn du weißt, wie oft du wiederholen möchtest.

```python
for i in range(5):
    print(f"Das ist Wiederholung Nummer {i}")
```

**Ausgabe:**
```
Das ist Wiederholung Nummer 0
Das ist Wiederholung Nummer 1
Das ist Wiederholung Nummer 2
Das ist Wiederholung Nummer 3
Das ist Wiederholung Nummer 4
```

### Verstehen: `range()`

`range()` erstellt eine Liste von Zahlen:

- `range(5)` → 0, 1, 2, 3, 4 (von 0 bis 4)
- `range(1, 6)` → 1, 2, 3, 4, 5 (von 1 bis 5)
- `range(0, 10, 2)` → 0, 2, 4, 6, 8 (von 0 bis 9, in Schritten von 2)

```python
# Alle geraden Zahlen von 0 bis 8
for zahl in range(0, 10, 2):
    print(zahl)
```

**Ausgabe:** `0 2 4 6 8`

### `for`-Schleife mit Listen

Du kannst auch direkt über eine Liste iterieren:

```python
früchte = ["Apfel", "Banane", "Kirsche"]

for frucht in früchte:
    print(f"Ich mag {frucht}")
```

**Ausgabe:**
```
Ich mag Apfel
Ich mag Banane
Ich mag Kirsche
```

### `while`-Schleife – Wiederholung mit Bedingung

Die `while`-Schleife wiederholt Code, **solange** eine Bedingung wahr ist. Sie ist perfekt, wenn du nicht weißt, wie oft wiederholt werden soll.

```python
zaehler = 0

while zaehler < 5:
    print(f"Zaehler: {zaehler}")
    zaehler = zaehler + 1  # oder: zaehler += 1
```

**Ausgabe:**
```
Zaehler: 0
Zaehler: 1
Zaehler: 2
Zaehler: 3
Zaehler: 4
```

### ⚠️ Vorsicht: Endlosschleife!

Wenn die Bedingung in einer `while`-Schleife nie falsch wird, läuft das Programm für immer. Das nennt man eine **Endlosschleife**:

```python
while True:  # Diese Bedingung ist IMMER wahr!
    print("Das geht für immer weiter...")
```

Diesen Code solltest du **nicht** ausführen, ohne einen Abbruch-Mechanismus einzubauen!

### `break` – Schleife beenden

Mit `break` kannst du eine Schleife vorzeitig beenden:

```python
for i in range(10):
    if i == 5:
        break  # Schleife stoppt hier
    print(i)
```

**Ausgabe:** `0 1 2 3 4`

### `continue` – Einen Durchlauf überspringen

Mit `continue` springst du zum nächsten Durchlauf:

```python
for i in range(5):
    if i == 2:
        continue  # Dieser Durchlauf wird übersprungen
    print(i)
```

**Ausgabe:** `0 1 3 4`

---

## 💡 Praxisbeispiel: Multiplikationstabelle

Hier kombinieren wir bedingte Anweisungen und Schleifen:

```python
# Multiplikationstabelle für das kleine 1x1
for i in range(1, 11):
    for j in range(1, 11):
        ergebnis = i * j
        print(f"{i} × {j} = {ergebnis}", end="  ")
    print()  # Neue Zeile nach jeder Reihe
```

Dieses Programm:
1. Nutzt zwei verschachtelte Schleifen
2. Berechnet Produkte
3. Gibt sie formatiert aus

---

## 🧠 Zusammenfassung

| Konzept | Syntax | Nutzen |
|---------|--------|--------|
| `if/elif/else` | `if x > 5: ... elif x > 0: ... else: ...` | Entscheidungen treffen |
| `for` | `for i in range(5): ...` | Bekannte Anzahl von Wiederholungen |
| `while` | `while x < 10: ...` | Unbekannte Anzahl, bis Bedingung falsch wird |
| `break` | In Schleife: `break` | Schleife beenden |
| `continue` | In Schleife: `continue` | Zum nächsten Durchlauf springen |

---

## ❓ Verständnisfragen

1. Was ist der Unterschied zwischen `=` und `==`?
2. Warum ist die Einrückung in Python wichtig?
3. Wann verwendest du `for`, wann `while`?
4. Was passiert, wenn du `break` in einer Schleife verwendest?

---

## 🔗 Weiterführende Links

- [Python-Dokumentation: if/elif/else](https://docs.python.org/3/tutorial/controlflow.html#if-statements)
- [Python-Dokumentation: for und while](https://docs.python.org/3/tutorial/controlflow.html#for-statements)
- [W3Schools: Python Conditionals](https://www.w3schools.com/python/python_conditions.asp)
- [W3Schools: Python Loops](https://www.w3schools.com/python/python_while_loops.asp)
- [GeeksforGeeks: Control Flow in Python](https://www.geeksforgeeks.org/python-control-flow-programs/)