---
aliases: 
tags: 
title: 5D4G Refactoring-Übung
---

## Ausgangscode

Hier ist unser Beispiel für schlecht strukturierten Code:

```python
def do_stuff(x, y, z):
    result = 0
    if x > 0:
        if y > 0:
            for i in range(z):
                result += x * y
        else:
            for i in range(z):
                result += x
    else:
        if y > 0:
            for i in range(z):
                result -= y
        else:
            result = z
    print("Das Ergebnis ist:", result)
    return result

# Benutzung der Funktion
a = int(input("Geben Sie x ein: "))
b = int(input("Geben Sie y ein: "))
c = int(input("Geben Sie z ein: "))
do_stuff(a, b, c)
```

Nun werden wir verschiedene Refactoring-Techniken anwenden, um diesen Code zu verbessern.

## 1. Umbenennen (Rename)

Zuerst benennen wir die Funktion und Variablen sinnvoller:

1. Platzieren Sie den Cursor auf `do_stuff`
2. Rechtsklick > Refactor > Rename
3. Geben Sie den neuen Namen `calculate_result` ein
4. Wiederholen Sie den Vorgang für `x`, `y`, und `z`, um sie in `factor1`, `factor2` und `iterations` umzubenennen

```python
def calculate_result(factor1, factor2, iterations):
    result = 0
    if factor1 > 0:
        if factor2 > 0:
            for i in range(iterations):
                result += factor1 * factor2
        else:
            for i in range(iterations):
                result += factor1
    else:
        if factor2 > 0:
            for i in range(iterations):
                result -= factor2
        else:
            result = iterations
    print("Das Ergebnis ist:", result)
    return result

# Benutzung der Funktion
a = int(input("Geben Sie factor1 ein: "))
b = int(input("Geben Sie factor2 ein: "))
c = int(input("Geben Sie iterations ein: "))
calculate_result(a, b, c)
```

## 2. Methode extrahieren (Extract Method)

Extrahieren wir nun die Berechnungslogik in separate Methoden:

1. Markieren Sie den Code innerhalb der ersten if-Bedingung
2. Rechtsklick > Refactor > Extract > Method
3. Benennen Sie die neue Methode `calculate_positive_factor1`
4. Wiederholen Sie den Vorgang für den else-Block und nennen Sie die Methode `calculate_negative_factor1`

```python
def calculate_result(factor1, factor2, iterations):
    if factor1 > 0:
        result = calculate_positive_factor1(factor1, factor2, iterations)
    else:
        result = calculate_negative_factor1(factor2, iterations)
    print("Das Ergebnis ist:", result)
    return result

def calculate_positive_factor1(factor1, factor2, iterations):
    if factor2 > 0:
        return sum(factor1 * factor2 for _ in range(iterations))
    else:
        return sum(factor1 for _ in range(iterations))

def calculate_negative_factor1(factor2, iterations):
    if factor2 > 0:
        return sum(-factor2 for _ in range(iterations))
    else:
        return iterations

# Benutzung der Funktion
a = int(input("Geben Sie factor1 ein: "))
b = int(input("Geben Sie factor2 ein: "))
c = int(input("Geben Sie iterations ein: "))
calculate_result(a, b, c)
```

## 3. Inline Variable (Inline Variable)

Entfernen wir die überflüssige `result`-Variable in `calculate_result`:

1. Markieren Sie `result =` in der `calculate_result`-Funktion
2. Rechtsklick > Refactor > Inline
3. Wählen Sie "Inline all occurrences and remove the variable"

```python
def calculate_result(factor1, factor2, iterations):
    if factor1 > 0:
        result = calculate_positive_factor1(factor1, factor2, iterations)
    else:
        result = calculate_negative_factor1(factor2, iterations)
    print("Das Ergebnis ist:", result)
    return result
```

## 4. Parameter Object einführen (Introduce Parameter Object)

Fassen wir die Parameter in einem Objekt zusammen:

1. Markieren Sie die Parameter `factor1, factor2, iterations`
2. Rechtsklick > Refactor > Introduce Parameter Object
3. Benennen Sie die neue Klasse `CalculationParameters`
4. Wählen Sie "Update usages in the whole project" und "Replace parameters with object in the method call"

```python
from dataclasses import dataclass

@dataclass
class CalculationParameters:
    factor1: int
    factor2: int
    iterations: int

def calculate_result(params: CalculationParameters):
    if params.factor1 > 0:
        result = calculate_positive_factor1(params)
    else:
        result = calculate_negative_factor1(params)
    print("Das Ergebnis ist:", result)
    return result

def calculate_positive_factor1(params: CalculationParameters):
    if params.factor2 > 0:
        return sum(params.factor1 * params.factor2 for _ in range(params.iterations))
    else:
        return sum(params.factor1 for _ in range(params.iterations))

def calculate_negative_factor1(params: CalculationParameters):
    if params.factor2 > 0:
        return sum(-params.factor2 for _ in range(params.iterations))
    else:
        return params.iterations

# Benutzung der Funktion
a = int(input("Geben Sie factor1 ein: "))
b = int(input("Geben Sie factor2 ein: "))
c = int(input("Geben Sie iterations ein: "))
params = CalculationParameters(a, b, c)
calculate_result(params)
```

## 5. Methode verschieben (Move Method)

Verschieben wir die Berechnungsmethoden in die `CalculationParameters`-Klasse:

1. Markieren Sie die Methode `calculate_positive_factor1`
2. Rechtsklick > Refactor > Move
3. Wählen Sie die Zielklasse `CalculationParameters`
4. Wiederholen Sie den Vorgang für `calculate_negative_factor1`

```python
from dataclasses import dataclass

@dataclass
class CalculationParameters:
    factor1: int
    factor2: int
    iterations: int

    def calculate_positive_factor1(self):
        if self.factor2 > 0:
            return sum(self.factor1 * self.factor2 for _ in range(self.iterations))
        else:
            return sum(self.factor1 for _ in range(self.iterations))

    def calculate_negative_factor1(self):
        if self.factor2 > 0:
            return sum(-self.factor2 for _ in range(self.iterations))
        else:
            return self.iterations

def calculate_result(params: CalculationParameters):
    if params.factor1 > 0:
        result = params.calculate_positive_factor1()
    else:
        result = params.calculate_negative_factor1()
    print("Das Ergebnis ist:", result)
    return result

# Benutzung der Funktion
a = int(input("Geben Sie factor1 ein: "))
b = int(input("Geben Sie factor2 ein: "))
c = int(input("Geben Sie iterations ein: "))
params = CalculationParameters(a, b, c)
calculate_result(params)
```

## [5D4G1 Dataclass](5D4G1%20Dataclass.md)
