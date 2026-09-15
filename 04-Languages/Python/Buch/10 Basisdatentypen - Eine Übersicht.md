
## Datentypen in Python

Python hat verschiedene eingebaute Datentypen, die in mutable (veränderliche) und immutable (unveränderliche) Typen unterteilt werden können. Diese Datei zeigt Beispiele zu den grundlegenden Datentypen und ihren Eigenschaften.

## Den Datentyp einer Variable ermitteln

- Mit der Funktion `type()` kann der Datentyp einer Variable bestimmt werden

```python
def get_variable_type(x):
    """Gibt den Typ einer Variable zurück"""
    return type(x)

# Beispiel: Den Typ eines Strings ermitteln
get_variable_type("Hallo")
```

## Das Nichts - NoneType

- Python hat einen speziellen Datentyp für "nichts": `NoneType`
- Es gibt nur eine einzige Instanz dieses Typs: `None`
- `None` ist nützlich, wenn eine Funktion in bestimmten Fällen kein Ergebnis liefern kann

```python
def demonstrate_none():
    """Demonstriert die Verwendung von None"""
    ref = None
    return ref

# Beispiel: None-Wert zuweisen und zurückgeben
demonstrate_none()
```

## None überprüfen

- Zum Überprüfen, ob eine Variable den Wert `None` hat, sollte der `is`-Operator verwendet werden
- `is` prüft die Identität, nicht den Wert (effizienter für `None`-Vergleiche)

```python
def check_none(ref):
    """Überprüft, ob ein Wert None ist"""
    if ref is None:
        return "ref ist None"
    else:
        return "ref ist nicht None"

# Beispiel: None-Wert überprüfen
check_none(None)
```

## Operatoren in Python

- Operatoren verbinden Werte zu arithmetischen oder logischen Ausdrücken
- Die Bedeutung eines Operators hängt vom Datentyp der Operanden ab

### Arithmetische Operatoren

```python
def demonstrate_arithmetic():
    """Zeigt arithmetische Operationen"""
    # Addition mit Zahlen
    num_result = 1 + 2
    
    # Addition (Verkettung) mit Strings
    str_result = "A" + "B"
    
    return {
        "Zahlenaddition": num_result,
        "Stringverkettung": str_result
    }

# Beispiel: Arithmetische Operatoren
demonstrate_arithmetic()
```

## Bindigkeit von Operatoren

- Operatoren haben eine bestimmte Rangfolge (Bindigkeit)
- Operatoren mit höherer Priorität werden zuerst ausgewertet (z.B. Multiplikation vor Addition)

```python
def operator_precedence(a, b, c):
    """Zeigt die Bindigkeit von Operatoren"""
    # Mit Klammern
    result1 = (a * b) + c
    result2 = a * (b + c)
    
    # Ohne Klammern - Multiplikation hat Vorrang vor Addition
    result3 = a * b + c
    
    return {
        "(a * b) + c": result1,
        "a * (b + c)": result2,
        "a * b + c": result3
    }

# Beispiel: Operatorenbindigkeit mit a=2, b=3, c=4
operator_precedence(2, 3, 4)
```

## Auswertungsreihenfolge

- Bei Ausdrücken mit Operatoren gleicher Bindigkeit erfolgt die Auswertung von links nach rechts

```python
def evaluation_order(a, b, c):
    """Zeigt die Auswertungsreihenfolge bei gleichen Operatoren"""
    # Addition
    add_result = a + b + c  # entspricht ((a + b) + c)
    
    # Subtraktion
    sub_result = a - b - c  # entspricht ((a - b) - c)
    
    return {
        "a + b + c": add_result,
        "a - b - c": sub_result
    }

# Beispiel: Auswertungsreihenfolge mit a=5, b=3, c=1
evaluation_order(5, 3, 1)
```

## Verkettung von Vergleichen

- Python ermöglicht die Verkettung von Vergleichsoperatoren
- Der Ausdruck `a < b < c` wird ausgewertet als `a < b and b < c`

```python
def chained_comparisons(a, b, c, d, e):
    """Demonstriert verkettete Vergleiche"""
    # Einfache Verkettung
    simple_result = a < b < c
    
    # Komplexere Verkettung
    complex_result = a < b <= c != d > e
    
    # Äquivalente Schreibweise mit and
    equivalent_simple = a < b and b < c
    equivalent_complex = a < b and b <= c and c != d and d > e
    
    return {
        "a < b < c": simple_result,
        "Äquivalent (and)": equivalent_simple,
        "a < b <= c != d > e": complex_result,
        "Äquivalent komplex": equivalent_complex
    }

# Beispiel: Verkettete Vergleiche mit a=1, b=2, c=3, d=4, e=0
chained_comparisons(1, 2, 3, 4, 0)
```

## Übersicht der Operatoren nach Bindigkeit (von stark nach schwach)

1. `x ** y` - Potenzierung
2. `+x`, `-x`, `~x` - Positives/Negatives Vorzeichen, Bitweise Negation
3. `x * y`, `x / y`, `x // y`, `x % y`, `x @ y` - Multiplikation, Division, Ganzzahldivision, Modulo, Matrixmultiplikation
4. `x + y`, `x - y` - Addition, Subtraktion
5. `x << y`, `x >> y` - Bitweise Verschiebung
6. `x & y` - Bitweises AND
7. `x ^ y` - Bitweises XOR
8. `x | y` - Bitweises OR
9. Vergleichsoperatoren: `<`, `<=`, `>`, `>=`, `!=`, `==`, `is`, `is not`, `in`, `not in`
10. `not x` - Logische Negation
11. `x and y` - Logisches AND
12. `x or y` - Logisches OR

## Weitere wichtige Datentypen

### Numerische Datentypen (alle unveränderlich)
- `int` - Ganze Zahlen
- `float` - Gleitkommazahlen
- `bool` - Boolesche Werte (True/False)
- `complex` - Komplexe Zahlen

### Sequenzielle Datentypen
- `list` - Listen beliebiger Objekte (veränderlich)
- `tuple` - Tupel beliebiger Objekte (unveränderlich)
- `str` - Text als Sequenz von Zeichen (unveränderlich)
- `bytes` - Binärdaten als Sequenz von Bytes (unveränderlich)
- `bytearray` - Binärdaten als Sequenz von Bytes (veränderlich)

### Zuordnungen und Mengen
- `dict` - Schlüssel-Wert-Zuordnungen (veränderlich)
- `set` - Mengen beliebiger Objekte (veränderlich)
- `frozenset` - Mengen beliebiger Objekte (unveränderlich)
