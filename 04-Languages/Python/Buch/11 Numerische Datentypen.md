Python bietet verschiedene numerische Datentypen, die alle bestimmte Eigenschaften und Operationen unterstützen. Diese Datei zeigt Beispiele für die Verwendung und Eigenschaften der verschiedenen numerischen Datentypen in Python.

## Arithmetische Operatoren für numerische Datentypen

Alle numerischen Datentypen in Python unterstützen die gleichen grundlegenden arithmetischen Operatoren.

```python
def arithmetic_addition(x, y):
    """Addition zweier Zahlen."""
    return x + y

# Beispielaufruf: Addition von 10 und 3
arithmetic_addition(10, 3)  # ergibt 13
```

```python
def arithmetic_subtraction(x, y):
    """Subtraktion zweier Zahlen."""
    return x - y

# Beispielaufruf: Subtraktion von 3 von 10
arithmetic_subtraction(10, 3)  # ergibt 7
```

```python
def arithmetic_multiplication(x, y):
    """Multiplikation zweier Zahlen."""
    return x * y

# Beispielaufruf: Multiplikation von 10 mit 3
arithmetic_multiplication(10, 3)  # ergibt 30
```

```python
def arithmetic_division(x, y):
    """Division zweier Zahlen."""
    return x / y

# Beispielaufruf: Division von 10 durch 3
arithmetic_division(10, 3)  # ergibt 3.3333333333333335
```

```python
def arithmetic_modulo(x, y):
    """Modulo (Rest der Division) zweier Zahlen."""
    if isinstance(x, complex) or isinstance(y, complex):
        return "Modulo ist nicht für komplexe Zahlen definiert"
    return x % y

# Beispielaufruf: Rest bei Division von 10 durch 3
arithmetic_modulo(10, 3)  # ergibt 1
```

```python
def arithmetic_positive(x):
    """Positives Vorzeichen einer Zahl."""
    return +x

# Beispielaufruf: Positives Vorzeichen von 10
arithmetic_positive(10)  # ergibt 10
```

```python
def arithmetic_negative(x):
    """Negatives Vorzeichen einer Zahl."""
    return -x

# Beispielaufruf: Negatives Vorzeichen von 10
arithmetic_negative(10)  # ergibt -10
```

```python
def arithmetic_power(x, y):
    """Potenzierung: x hoch y."""
    return x ** y

# Beispielaufruf: 10 hoch 3
arithmetic_power(10, 3)  # ergibt 1000
```

```python
def arithmetic_floor_division(x, y):
    """Ganzzahlige Division zweier Zahlen."""
    if isinstance(x, complex) or isinstance(y, complex):
        return "Ganzzahlige Division ist nicht für komplexe Zahlen definiert"
    return x // y

# Beispielaufruf: Ganzzahlige Division von 10 durch 3
arithmetic_floor_division(10, 3)  # ergibt 3
```

## Erweiterte Zuweisungen

Python bietet abgekürzte Schreibweisen für Operationen mit anschließender Zuweisung.

```python
def augmented_addition_assignment():
    """Addition und Zuweisung (+=)."""
    x = 10
    x += 5  # entspricht x = x + 5
    return x

# Beispielaufruf: x += 5 mit x=10
augmented_addition_assignment()  # ergibt 15
```

```python
def augmented_subtraction_assignment():
    """Subtraktion und Zuweisung (-=)."""
    x = 10
    x -= 2  # entspricht x = x - 2
    return x

# Beispielaufruf: x -= 2 mit x=10
augmented_subtraction_assignment()  # ergibt 8
```

```python
def augmented_multiplication_assignment():
    """Multiplikation und Zuweisung (*=)."""
    x = 10
    x *= 3  # entspricht x = x * 3
    return x

# Beispielaufruf: x *= 3 mit x=10
augmented_multiplication_assignment()  # ergibt 30
```

```python
def augmented_division_assignment():
    """Division und Zuweisung (/=)."""
    x = 10
    x /= 4  # entspricht x = x / 4
    return x

# Beispielaufruf: x /= 4 mit x=10
augmented_division_assignment()  # ergibt 2.5
```

```python
def augmented_modulo_assignment():
    """Modulo und Zuweisung (%=)."""
    y = 10
    y %= 3  # entspricht y = y % 3
    return y

# Beispielaufruf: y %= 3 mit y=10
augmented_modulo_assignment()  # ergibt 1
```

```python
def augmented_power_assignment():
    """Potenzierung und Zuweisung (**=)."""
    z = 2
    z **= 3  # entspricht z = z ** 3
    return z

# Beispielaufruf: z **= 3 mit z=2
augmented_power_assignment()  # ergibt 8
```

```python
def augmented_floor_division_assignment():
    """Ganzzahlige Division und Zuweisung (//=)."""
    w = 10
    w //= 3  # entspricht w = w // 3
    return w

# Beispielaufruf: w //= 3 mit w=10
augmented_floor_division_assignment()  # ergibt 3
```

## Vergleichende Operatoren

Vergleichende Operatoren geben einen booleschen Wert (True oder False) zurück.

```python
def comparison_equal(x, y):
    """Gleichheit (==) zweier Werte."""
    return x == y

# Beispielaufruf: Prüfen ob 5 gleich 5 ist
comparison_equal(5, 5)  # ergibt True
```

```python
def comparison_not_equal(x, y):
    """Ungleichheit (!=) zweier Werte."""
    return x != y

# Beispielaufruf: Prüfen ob 5 ungleich 10 ist
comparison_not_equal(5, 10)  # ergibt True
```

```python
def comparison_less_than(x, y):
    """Kleiner als (<) Vergleich."""
    if isinstance(x, complex) or isinstance(y, complex):
        return "< ist nicht für komplexe Zahlen definiert"
    return x < y

# Beispielaufruf: Prüfen ob 5 kleiner als 10 ist
comparison_less_than(5, 10)  # ergibt True
```

```python
def comparison_less_equal(x, y):
    """Kleiner oder gleich (<=) Vergleich."""
    if isinstance(x, complex) or isinstance(y, complex):
        return "<= ist nicht für komplexe Zahlen definiert"
    return x <= y

# Beispielaufruf: Prüfen ob 5 kleiner oder gleich 5 ist
comparison_less_equal(5, 5)  # ergibt True
```

```python
def comparison_greater_than(x, y):
    """Größer als (>) Vergleich."""
    if isinstance(x, complex) or isinstance(y, complex):
        return "> ist nicht für komplexe Zahlen definiert"
    return x > y

# Beispielaufruf: Prüfen ob 10 größer als 5 ist
comparison_greater_than(10, 5)  # ergibt True
```

```python
def comparison_greater_equal(x, y):
    """Größer oder gleich (>=) Vergleich."""
    if isinstance(x, complex) or isinstance(y, complex):
        return ">= ist nicht für komplexe Zahlen definiert"
    return x >= y

# Beispielaufruf: Prüfen ob 10 größer oder gleich 10 ist
comparison_greater_equal(10, 10)  # ergibt True
```

## Verkettung von Vergleichen

Python erlaubt die Verkettung mehrerer Vergleichsoperatoren, was einer mathematischen Schreibweise entspricht.

```python
def chained_comparison_simple(x):
    """Einfacher Vergleich: x < 4."""
    return x < 4

# Beispielaufruf: Prüfen ob 3 kleiner als 4 ist
chained_comparison_simple(3)  # ergibt True
```

```python
def chained_comparison_range(x):
    """Vergleich eines Bereichs: 2 < x < 4."""
    return 2 < x < 4

# Beispielaufruf: Prüfen ob 3 zwischen 2 und 4 liegt
chained_comparison_range(3)  # ergibt True
```

```python
def chained_comparison_equivalent(x):
    """Äquivalent zu Bereichsvergleich: 2 < x and x < 4."""
    return 2 < x and x < 4

# Beispielaufruf: Äquivalent zu Bereichsvergleich für x=3
chained_comparison_equivalent(3)  # ergibt True
```

```python
def is_chained_comparison_equivalent(x):
    """Überprüft, ob beide Vergleichsmethoden identisch sind."""
    return chained_comparison_range(x) == chained_comparison_equivalent(x)

# Beispielaufruf: Überprüfen ob beide Vergleichsmethoden gleichwertig sind für x=3
is_chained_comparison_equivalent(3)  # ergibt True
```

## Konvertierung zwischen numerischen Datentypen

Python bietet eingebaute Funktionen zur Konvertierung zwischen den verschiedenen numerischen Datentypen.

```python
def convert_float_to_int(float_value):
    """Konvertiert eine Gleitkommazahl in eine ganze Zahl."""
    return int(float_value)  # Schneidet Nachkommastellen ab

# Beispielaufruf: Konvertiere 33.5 zu int
convert_float_to_int(33.5)  # ergibt 33
```

```python
def convert_int_to_float(int_value):
    """Konvertiert eine ganze Zahl in eine Gleitkommazahl."""
    return float(int_value)

# Beispielaufruf: Konvertiere 33 zu float
convert_int_to_float(33)  # ergibt 33.0
```

```python
def convert_number_to_bool(number):
    """Konvertiert eine Zahl in einen booleschen Wert."""
    return bool(number)  # 0 wird zu False, alles andere zu True

# Beispielaufruf: Konvertiere 12 zu bool
convert_number_to_bool(12)  # ergibt True
```

```python
convert_number_to_bool(0)   # ergibt False
```

```python
def convert_bool_to_complex(bool_value):
    """Konvertiert einen booleschen Wert in eine komplexe Zahl."""
    return complex(bool_value)  # True wird zu (1+0j), False zu (0+0j)

# Beispielaufruf: Konvertiere True zu complex
convert_bool_to_complex(True)  # ergibt (1+0j)
```

```python
def convert_variable_example():
    """Demonstriert Konvertierung mit Variablen."""
    var1 = 12.5
    int_result = int(var1)  # 12
    
    var2 = int(40.25)  # 40
    
    return {
        "int(12.5)": int_result,
        "var2 nach int(40.25)": var2
    }

# Beispielaufruf: Konvertierung mit Variablen
convert_variable_example()  # ergibt {'int(12.5)': 12, 'var2 nach int(40.25)': 40}
```

## Ganzzahlen (int)

Der `int`-Datentyp in Python kann Ganzzahlen beliebiger Größe speichern.

```python
def create_integers():
    """Demonstriert die Erstellung ganzer Zahlen auf verschiedene Weisen."""
    # Einfache Zuweisung
    i = 1234
    
    # Konvertierung
    p = int(5678)
    
    return {
        "Einfache Zuweisung (i)": i,
        "Konvertierung mit int() (p)": p
    }

# Beispielaufruf: Erstellen von Integer-Werten
create_integers()  # ergibt {'Einfache Zuweisung (i)': 1234, 'Konvertierung mit int() (p)': 5678}
```

```python
def use_integer_separator():
    """Demonstriert die Verwendung von Unterstrichen als Trennzeichen in Ganzzahlen."""
    # Seit Python 3.6: Unterstriche als Trennzeichen für bessere Lesbarkeit
    large_num = 1_000_000  # gleich wie 1000000
    small_group = 1_0_0    # gleich wie 100
    
    return {
        "Große Zahl mit Unterstrich": large_num,
        "Kleine Gruppierung": small_group
    }

# Beispielaufruf: Verwendung von Unterstrichen in Zahlen
use_integer_separator()  # ergibt {'Große Zahl mit Unterstrich': 1000000, 'Kleine Gruppierung': 100}
```

```python
def use_number_systems():
    """Demonstriert verschiedene Zahlensysteme in Python."""
    decimal = 42       # Dezimal (Basis 10)
    binary = 0b101010  # Binär (Basis 2): 42 in Dezimal
    octal = 0o52       # Oktal (Basis 8): 42 in Dezimal
    hexadecimal = 0x2A # Hexadezimal (Basis 16): 42 in Dezimal
    
    return {
        "Dezimal (42)": decimal,
        "Binär (0b101010)": binary,
        "Oktal (0o52)": octal,
        "Hexadezimal (0x2A)": hexadecimal,
        "Alle Werte sind gleich": decimal == binary == octal == hexadecimal
    }

# Beispielaufruf: Verschiedene Zahlensysteme für die Zahl 42
use_number_systems()  # ergibt {'Dezimal (42)': 42, 'Binär (0b101010)': 42, ...}
```

```python
def use_custom_base():
    """Demonstriert die Verwendung von benutzerdefinierten Zahlensystemen."""
    # Alternative Art für exotische Zahlensysteme (Basis 6)
    base_6 = int("54425", 6)  # Konvertiert "54425" im Basis-6-System zu Dezimal
    
    # Basis 36 (höchste unterstützte Basis, verwendet 0-9 und A-Z)
    base_36 = int("PYTHON", 36)
    
    return {
        "Basis 6 (54425)": base_6,
        "Basis 36 (PYTHON)": base_36
    }

# Beispielaufruf: Benutzerdefinierte Zahlensysteme
use_custom_base()  # ergibt {'Basis 6 (54425)': 7505, 'Basis 36 (PYTHON)': 1845128156}
```

## Bit-Operationen mit int

Für den `int`-Datentyp gibt es spezielle Bit-Operatoren für Binäroperationen.

```python
def bitwise_and(a, b):
    """Demonstriert das bitweise UND (&) zwischen zwei Zahlen."""
    result = a & b
    return {
        f"{a} & {b} (dezimal)": result,
        f"{a} & {b} (binär)": bin(result)
    }

# Beispielaufruf: Bitweises UND von 107 und 25
bitwise_and(107, 25)  # ergibt {'107 & 25 (dezimal)': 9, '107 & 25 (binär)': '0b1001'}
```

```python
def bitwise_or(a, b):
    """Demonstriert das bitweise ODER (|) zwischen zwei Zahlen."""
    result = a | b
    return {
        f"{a} | {b} (dezimal)": result,
        f"{a} | {b} (binär)": bin(result)
    }

# Beispielaufruf: Bitweises ODER von 107 und 25
bitwise_or(107, 25)  # ergibt {'107 | 25 (dezimal)': 123, '107 | 25 (binär)': '0b1111011'}
```

```python
def bitwise_xor(a, b):
    """Demonstriert das bitweise exklusive ODER (^) zwischen zwei Zahlen."""
    result = a ^ b
    return {
        f"{a} ^ {b} (dezimal)": result,
        f"{a} ^ {b} (binär)": bin(result)
    }

# Beispielaufruf: Bitweises XOR von 107 und 25
bitwise_xor(107, 25)  # ergibt {'107 ^ 25 (dezimal)': 114, '107 ^ 25 (binär)': '0b1110010'}
```

```python
def bitwise_complement(x):
    """Demonstriert das bitweise Komplement (~) einer Zahl."""
    result = ~x
    return {
        f"~{x} (dezimal)": result,
        f"~{x} (binär)": bin(result)
    }

# Beispielaufruf: Bitweises Komplement von 9
bitwise_complement(9)  # ergibt {'~9 (dezimal)': -10, '~9 (binär)': '-0b1010'}
```

```python
def bitwise_shift_left(x, n):
    """Demonstriert die Bit-Verschiebung nach links (<<)."""
    result = x << n
    return {
        f"{x} << {n} (dezimal)": result,
        f"{x} << {n} (binär)": bin(result),
        f"{x} * (2^{n})": x * (2 ** n),  # Äquivalent zur Verschiebung
        "Beide Ergebnisse sind gleich": result == x * (2 ** n)
    }

# Beispielaufruf: 2 Bit nach links verschieben bei 107
bitwise_shift_left(107, 2)  # ergibt {'107 << 2 (dezimal)': 428, ...}
```

```python
def bitwise_shift_right(x, n):
    """Demonstriert die Bit-Verschiebung nach rechts (>>)."""
    result = x >> n
    return {
        f"{x} >> {n} (dezimal)": result,
        f"{x} >> {n} (binär)": bin(result),
        f"{x} // (2^{n})": x // (2 ** n),  # Äquivalent zur Verschiebung
        "Beide Ergebnisse sind gleich": result == x // (2 ** n)
    }

# Beispielaufruf: 2 Bit nach rechts verschieben bei 107
bitwise_shift_right(107, 2)  # ergibt {'107 >> 2 (dezimal)': 26, ...}
```

```python
def use_bit_length(x):
    """Demonstriert die bit_length()-Methode für ganze Zahlen."""
    binary = bin(x)[2:]  # [2:] um '0b' am Anfang zu entfernen
    return {
        f"{x}.bit_length()": x.bit_length(),
        f"Binär von {x}": binary,
        "Länge der Binärdarstellung": len(binary),
        "bit_length() gibt die korrekte Länge an": x.bit_length() == len(binary)
    }

# Beispielaufruf: bit_length() von 36
use_bit_length(36)  # ergibt {'36.bit_length()': 6, 'Binär von 36': '100100', ...}
```

## Gleitkommazahlen (float)

Der `float`-Datentyp speichert Gleitkommazahlen mit begrenzter Genauigkeit.

```python
def create_float_basic():
    """Demonstriert die Grundlagen von Gleitkommazahlen."""
    # Einfache Zuweisung
    v = 3.141
    return v

# Beispielaufruf: Erstellen einer einfachen Gleitkommazahl
create_float_basic()  # ergibt 3.141
```

```python
def create_float_variants():
    """Demonstriert verschiedene Schreibweisen für Gleitkommazahlen."""
    # Verschiedene Schreibweisen
    standard = 3.141
    only_integer_part = -3.  # Entspricht -3.0
    only_fractional_part = .001  # Entspricht 0.001
    with_underscore = 3.000_000_1  # Bessere Lesbarkeit
    
    return {
        "Standard": standard,
        "Nur Vorkommateil": only_integer_part,
        "Nur Nachkommateil": only_fractional_part,
        "Mit Unterstrich": with_underscore
    }

# Beispielaufruf: Verschiedene Schreibweisen für Gleitkommazahlen
create_float_variants()  # ergibt {'Standard': 3.141, 'Nur Vorkommateil': -3.0, ...}
```

```python
def use_exponential_notation():
    """Demonstriert die Exponentialschreibweise für Gleitkommazahlen."""
    # Exponentialschreibweise
    v_exp = 3.141e-12  # Entspricht 3.141 * 10^-12
    v_exp_plus = 1.5e8  # Entspricht 1.5 * 10^8
    
    # Führende Nullen sind erlaubt
    v_zeros = 03.141e-0012  # Gleich wie 3.141e-12
    
    return {
        "Negative Potenz": v_exp,
        "Positive Potenz": v_exp_plus,
        "Mit führenden Nullen": v_zeros
    }

# Beispielaufruf: Exponentialschreibweise für Gleitkommazahlen
use_exponential_notation()  # ergibt {'Negative Potenz': 3.141e-12, 'Positive Potenz': 150000000.0, ...}
```

```python
def demonstrate_float_precision():
    """Demonstriert Genauigkeitsprobleme bei Gleitkommazahlen."""
    result = 1.1 + 2.2  # Ergibt nicht genau 3.3!
    
    return {
        "1.1 + 2.2": result,
        "Unterschied zu 3.3": result - 3.3,
        "Ist exakt 3.3?": result == 3.3
    }

# Beispielaufruf: Genauigkeitsprobleme bei Gleitkommazahlen
demonstrate_float_precision()  # ergibt {'1.1 + 2.2': 3.3000000000000003, 'Unterschied zu 3.3': 5.551115123125783e-17, ...}
```

## Unendlich und Not a Number (NaN)

Python kann spezielle Werte wie Unendlich (inf) und "Nicht-Zahl" (NaN) darstellen.

```python
def create_infinity():
    """Demonstriert die Darstellung von Unendlichkeit in Python."""
    # Übergroße Zahlen werden als inf (Unendlich) dargestellt
    pos_inf = 3.0e999
    neg_inf = -3.0e999
    
    # Explizite Erzeugung
    explicit_inf = float("inf")
    
    return {
        "Übergroße positive Zahl": pos_inf,
        "Übergroße negative Zahl": neg_inf,
        "Explizite Infinity": explicit_inf,
        "pos_inf == explicit_inf": pos_inf == explicit_inf
    }

# Beispielaufruf: Darstellung von Unendlichkeit
create_infinity()  # ergibt {'Übergroße positive Zahl': inf, 'Übergroße negative Zahl': -inf, ...}
```

```python
def compare_infinity():
    """Demonstriert Vergleiche mit Unendlichkeitswerten."""
    inf = float("inf")
    
    return {
        "inf > 1000000000": inf > 1000000000,  # True
        "inf < -1000000000": inf < -1000000000,  # False
        "inf == inf": inf == inf,  # True
        "-inf < -1000000000": -float("inf") < -1000000000  # True
    }

# Beispielaufruf: Vergleiche mit Unendlichkeit
compare_infinity()  # ergibt {'inf > 1000000000': True, 'inf < -1000000000': False, ...}
```

```python
def arithmetic_with_infinity():
    """Demonstriert arithmetische Operationen mit Unendlichkeitswerten."""
    inf = float("inf")
    
    return {
        "inf + 100": inf + 100,  # inf
        "inf * 2": inf * 2,  # inf
        "inf - inf": inf - inf,  # NaN (nicht berechenbar)
        "inf / inf": inf / inf,  # NaN
        "5 / inf": 5 / inf  # 0.0
    }

# Beispielaufruf: Arithmetische Operationen mit Unendlichkeit
arithmetic_with_infinity()  # ergibt {'inf + 100': inf, 'inf * 2': inf, 'inf - inf': nan, ...}
```

```python
def create_nan():
    """Demonstriert die Erzeugung von NaN (Not a Number)."""
    nan = float("nan")
    calculated_nan = float("inf") / float("inf")
    
    return {
        "Expliziter NaN": nan,
        "NaN durch Berechnung": calculated_nan
    }

# Beispielaufruf: Erzeugung von NaN-Werten
create_nan()  # ergibt {'Expliziter NaN': nan, 'NaN durch Berechnung': nan}
```

## Boolesche Werte (bool)

Der `bool`-Datentyp kann nur zwei Werte annehmen: `True` und `False`.

```python
def boolean_constants():
    """Demonstriert die booleschen Konstanten in Python."""
    t = True
    f = False
    
    return {
        "True als Konstante": t,
        "False als Konstante": f,
        "True als Integer": int(True),  # 1
        "False als Integer": int(False)  # 0
    }

# Beispielaufruf: Boolsche Konstanten
boolean_constants()  # ergibt {'True als Konstante': True, 'False als Konstante': False, ...}
```

```python
def logical_and_operations():
    """Demonstriert die logische AND-Operation."""
    return {
        "True and True": True and True,  # True
        "True and False": True and False,  # False
        "False and True": False and True,  # False
        "False and False": False and False  # False
    }

# Beispielaufruf: Logische AND-Operationen
logical_and_operations()  # ergibt {'True and True': True, 'True and False': False, ...}
```

```python
def logical_or_operations():
    """Demonstriert die logische OR-Operation."""
    return {
        "True or True": True or True,  # True
        "True or False": True or False,  # True
        "False or True": False or True,  # True
        "False or False": False or False  # False
    }

# Beispielaufruf: Logische OR-Operationen
logical_or_operations()  # ergibt {'True or True': True, 'True or False': True, ...}
```

```python
def logical_not_operation():
    """Demonstriert die logische NOT-Operation."""
    return {
        "not True": not True,  # False
        "not False": not False  # True
    }

# Beispielaufruf: Logische NOT-Operation
logical_not_operation()  # ergibt {'not True': False, 'not False': True}
```

```python
def complex_boolean_expression(x, y, z):
    """Demonstriert einen komplexen booleschen Ausdruck."""
    # Ausdruck: x and y or ((y and z) and not x)
    result = x and y or ((y and z) and not x)
    
    # Aufschlüsselung der Teile
    part1 = x and y
    part2 = y and z
    part3 = not x
    part4 = part2 and part3
    part5 = part1 or part4
    
    return {
        "x": x, "y": y, "z": z,
        "x and y": part1,
        "y and z": part2,
        "not x": part3,
        "(y and z) and not x": part4,
        "x and y or ((y and z) and not x)": result
    }

# Beispielaufruf: Komplexer boolescher Ausdruck mit x=True, y=True, z=False
complex_boolean_expression(True, True, False)  # ergibt {'x': True, 'y': True, 'z': False, 'x and y': True, ...}
```

## Wahrheitswerte nicht-boolescher Datentypen

Alle Python-Datentypen haben einen Wahrheitswert, der mit der `bool()`-Funktion abgefragt werden kann.

```python
def truth_values_of_various_types():
    """Demonstriert die Wahrheitswerte verschiedener Python-Objekte."""
    return {
        "bool(0)": bool(0),  # False
        "bool(1)": bool(1),  # True
        "bool(42)": bool(42),  # True
        "bool(-1)": bool(-1),  # True
        "bool(0.0)": bool(0.0),  # False
        "bool(0.1)": bool(0.1),  # True
        "bool('')": bool(""),  # False
        "bool('hello')": bool("hello"),  # True
        "bool([])": bool([]),  # False
        "bool([1, 2])": bool([1, 2]),  # True
        "bool({})": bool({}),  # False
        "bool({'a': 1})": bool({"a": 1}),  # True
        "bool(None)": bool(None)  # False
    }

# Beispielaufruf: Wahrheitswerte verschiedener Python-Objekte
truth_values_of_various_types()
```

```python
def lazy_evaluation():
    """Demonstriert die faule Auswertung (Lazy Evaluation) logischer Operatoren."""
    # Bei 'or' wird nur der erste Operand ausgewertet, wenn er True ist
    # Bei 'and' wird nur der erste Operand ausgewertet, wenn er False ist
    
    def side_effect():
        """Funktion mit Seiteneffekt, sollte nicht aufgerufen werden wenn lazy evaluation funktioniert."""
        return "Diese Funktion wurde aufgerufen!"
    
    # True or side_effect() würde side_effect() nicht aufrufen
    result1 = True or side_effect()
    
    # False and side_effect() würde side_effect() nicht aufrufen
    result2 = False and side_effect()
    
    return {
        "True or x": result1,  # True, side_effect() wird nicht aufgerufen
        "False and x": result2  # False, side_effect() wird nicht aufgerufen
    }

# Beispielaufruf: Faule Auswertung logischer Operatoren
lazy_evaluation()
```

```python
def operator_return_values():
    """Demonstriert, dass logische Operatoren die Operanden selbst zurückgeben, nicht nur True/False."""
    return {
        "0 or 1": 0 or 1,  # 1 (nicht True)
        "1 or 0": 1 or 0,  # 1 (nicht True)
        "'' or 'hello'": "" or "hello",  # 'hello'
        "'hello' or ''": "hello" or "",  # 'hello'
        
        "0 and 1": 0 and 1,  # 0 (nicht False)
        "1 and 0": 1 and 0,  # 0 (nicht False)
        "'' and 'hello'": "" and "hello",  # '' (leerer String)
        "'hello' and ''": "hello" and "",  # '' (leerer String)
        "'hello' and 'world'": "hello" and "world"  # 'world'
    }

# Beispielaufruf: Rückgabewerte logischer Operatoren
operator_return_values()
```

## Komplexe Zahlen (complex)

Der `complex`-Datentyp repräsentiert komplexe Zahlen mit Real- und Imaginärteil.

```python
def create_complex_number():
    """Demonstriert die Erstellung komplexer Zahlen."""
    # Nur Imaginärteil (Realteil ist 0)
    c1 = 4j
    
    # Realteil und Imaginärteil
    c2 = 3 + 4j
    
    # Alternative Schreibweise
    c3 = 4j + 3  # Gleich wie 3 + 4j
    
    # Mit großem J
    c4 = 4J
    
    # Mit Exponentialschreibweise
    c5 = 3.4 + 4e2j  # 3.4 + 400j
    
    return {
        "Nur Imaginärteil (4j)": c1,
        "Real + Imaginär (3 + 4j)": c2,
        "Imaginär + Real (4j + 3)": c3,
        "Mit großem J (4J)": c4,
        "Mit Exponentialschreibweise (3.4 + 4e2j)": c5
    }

# Beispielaufruf: Erstellung komplexer Zahlen
create_complex_number()
```

```python
def complex_number_attributes(c):
    """Demonstriert die Attribute komplexer Zahlen."""
    return {
        "Komplexe Zahl": c,
        "c.real (Realteil)": c.real,
        "c.imag (Imaginärteil)": c.imag
    }

# Beispielaufruf: Attribute einer komplexen Zahl
complex_number_attributes(23 + 4j)
```

```python
def complex_conjugate(c):
    """Demonstriert die conjugate()-Methode für komplexe Zahlen."""
    conj = c.conjugate()
    return {
        "Original": c,
        "Konjugiert": conj,
        "Doppelt konjugiert": conj.conjugate(),
        "Original == Doppelt konjugiert": c == conj.conjugate()
    }

# Beispielaufruf: Konjugation komplexer Zahlen
complex_conjugate(23 + 4j)
```
