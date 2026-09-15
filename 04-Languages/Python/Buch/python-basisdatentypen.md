# Python Basisdatentypen - Übersicht

## Datentypen und deren Eigenschaften

- Python verwendet Datentypen als Bauplan für Instanzen
- Ein Datentyp spezifiziert, welche Werte eine Instanz annehmen kann
- Mit der Funktion `type()` kann der Datentyp einer Instanz ermittelt werden

```python
def get_type_of_string():
    """Ermittelt den Datentyp eines Strings."""
    x = "Hallo"
    return type(x)
```

```python
# Demonstration: Datentyp eines Strings ermitteln
get_type_of_string()
```

## Das Nichts – NoneType

- Der einfachste Datentyp in Python ist `NoneType`
- Es gibt nur eine einzige Instanz des "Nichts": `None`
- `None` repräsentiert das Konzept "nichts" oder "keine gültige Rückgabe"
- `None` ist nützlich, wenn ein Verfahren kein Ergebnis liefern kann

```python
def create_none_reference():
    """Demonstriert die Zuweisung von None zu einer Variablen."""
    ref = None
    return ref
```

```python
# Demonstration: Zuweisung von None zu einer Variablen
create_none_reference()
```

- Bei direkter Ausgabe im Interpreter wird nichts angezeigt, bei Verwendung von `print()` wird `None` ausgegeben
- `None` kann mit dem `is`-Operator überprüft werden

```python
def check_if_none():
    """Überprüft, ob ein Wert None ist."""
    ref = None
    if ref is None:
        return "ref ist None"
    else:
        return "ref ist nicht None"
```

```python
# Demonstration: Überprüfen, ob ein Wert None ist
check_if_none()
```

## Operatoren

- Operatoren verbinden Werte zu Ausdrücken
- Die Bedeutung eines Operators hängt vom Datentyp der Operanden ab
- Der `+`-Operator kann für Zahlen (Addition) und Strings (Verkettung) verwendet werden

```python
def add_numbers():
    """Demonstriert die Addition von Zahlen."""
    return 1 + 2
```

```python
# Demonstration: Addition von Zahlen
add_numbers()
```

```python
def concatenate_strings():
    """Demonstriert die Verkettung von Strings."""
    return "A" + "B"
```

```python
# Demonstration: Verkettung von Strings
concatenate_strings()
```

### Bindigkeit von Operatoren

- Operatoren in Python haben eine bestimmte Bindigkeit (Vorrangregeln)
- Die Bindigkeit bestimmt die Auswertungsreihenfolge in Ausdrücken ohne Klammern
- Beispiel: `*` bindet stärker als `+` (Punktrechnung vor Strichrechnung)

```python
def demonstrate_operator_precedence_with_parentheses():
    """Demonstriert die Bindigkeit von Operatoren mit Klammern."""
    a, b, c = 2, 3, 4
    result1 = (a * b) + c
    result2 = a * (b + c)
    return f"(a * b) + c = {result1}, a * (b + c) = {result2}"
```

```python
# Demonstration: Bindigkeit von Operatoren mit Klammern
demonstrate_operator_precedence_with_parentheses()
```

```python
def demonstrate_operator_precedence_without_parentheses():
    """Demonstriert die Bindigkeit von Operatoren ohne Klammern."""
    a, b, c = 2, 3, 4
    result = a * b + c
    return f"a * b + c = {result} (entspricht (a * b) + c)"
```

```python
# Demonstration: Bindigkeit von Operatoren ohne Klammern
demonstrate_operator_precedence_without_parentheses()
```

### Auswertungsreihenfolge

- Bei mehrfachem Vorkommen des gleichen Operators gilt die Regel der Auswertung von links nach rechts
- Besonders wichtig bei nicht-kommutativen Operationen wie Subtraktion

```python
def demonstrate_evaluation_order():
    """Demonstriert die Auswertungsreihenfolge bei gleichen Operatoren."""
    a, b, c = 10, 5, 2
    result_add = a + b + c
    result_sub = a - b - c
    return f"a + b + c = {result_add} (entspricht (a + b) + c), a - b - c = {result_sub} (entspricht (a - b) - c)"
```

```python
# Demonstration: Auswertungsreihenfolge bei gleichen Operatoren
demonstrate_evaluation_order()
```

### Verkettung von Vergleichen

- Vergleichsoperatoren geben unabhängig vom Datentyp einen Wahrheitswert zurück
- Verkettete Vergleiche werden in Python besonders behandelt
- Der Ausdruck `a < b < c` wird ausgewertet als `a < b and b < c`

```python
def demonstrate_simple_comparison():
    """Demonstriert einen einfachen Vergleich."""
    return 1 < 2.5
```

```python
# Demonstration: Einfacher Vergleich
demonstrate_simple_comparison()
```

```python
def demonstrate_comparison_chain():
    """Demonstriert die Verkettung von Vergleichen."""
    a, b, c = 1, 2, 3
    chained = a < b < c
    explicit = (a < b) and (b < c)
    return f"a < b < c = {chained}, (a < b) and (b < c) = {explicit}"
```

```python
# Demonstration: Verkettung von Vergleichen
demonstrate_comparison_chain()
```

```python
def demonstrate_complex_comparison_chain():
    """Demonstriert komplexe Verkettungen von Vergleichen."""
    a, b, c, d, e = 1, 2, 3, 4, 2
    complex_chain = a < b <= c != d > e
    explicit = (a < b) and (b <= c) and (c != d) and (d > e)
    return f"Komplex: {complex_chain}, Explizit: {explicit}"
```

```python
# Demonstration: Komplexe Verkettung von Vergleichen
demonstrate_complex_comparison_chain()
```
