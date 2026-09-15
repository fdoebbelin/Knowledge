# Python Numerische Datentypen - Kapitel 11

## Numerische Datentypen - Überblick

- Python enthält verschiedene numerische Datentypen: `int`, `float`, `bool`, `complex`
- Alle numerischen Datentypen sind unveränderlich (immutable)
- Die Datentypen teilen gemeinsame Operatoren

## Arithmetische Operatoren

- Arithmetische Operatoren führen Berechnungen mit numerischen Werten durch
- Gemeinsame Operatoren: `+`, `-`, `*`, `/`, `%`, `**`, `//`

```python
def basic_arithmetic_operations():
    """Demonstriert grundlegende arithmetische Operationen."""
    addition = 5 + 3
    subtraction = 10 - 4
    multiplication = 3 * 6
    division = 8 / 2
    modulo = 7 % 3
    power = 2 ** 3
    floor_division = 7 // 2
    
    return f"""
    Addition (5 + 3): {addition}
    Subtraktion (10 - 4): {subtraction}
    Multiplikation (3 * 6): {multiplication}
    Division (8 / 2): {division}
    Modulo (7 % 3): {modulo}
    Potenz (2 ** 3): {power}
    Ganzzahldivision (7 // 2): {floor_division}
    """
```

```python
# Demonstration: Grundlegende arithmetische Operationen
basic_arithmetic_operations()
```

### Erweiterte Zuweisungen

- Erweiterte Zuweisungen kombinieren Operation und Zuweisung
- Beispiele: `+=`, `-=`, `*=`, `/=`, `%=`, `**=`, `//=`

```python
def augmented_assignments():
    """Demonstriert erweiterte Zuweisungen."""
    x = 10
    
    # x += y entspricht x = x + y
    x += 5
    result1 = x  # Jetzt ist x = 15
    
    # x -= y entspricht x = x - y
    x -= 3
    result2 = x  # Jetzt ist x = 12
    
    # x *= y entspricht x = x * y
    x *= 2
    result3 = x  # Jetzt ist x = 24
    
    # x /= y entspricht x = x / y
    x /= 4
    result4 = x  # Jetzt ist x = 6.0
    
    return f"""
    Ursprünglicher Wert: 10
    Nach x += 5: {result1}
    Nach x -= 3: {result2}
    Nach x *= 2: {result3}
    Nach x /= 4: {result4}
    """
```

```python
# Demonstration: Erweiterte Zuweisungen
augmented_assignments()
```

## Vergleichende Operatoren

- Vergleichende Operatoren liefern Wahrheitswerte
- Gemeinsame Operatoren: `==`, `!=`, `<`, `<=`, `>`, `>=`

```python
def comparison_operators():
    """Demonstriert vergleichende Operatoren."""
    equal = 5 == 5
    not_equal = 5 != 10
    less_than = 3 < 7
    less_equal = 3 <= 3
    greater_than = 8 > 5
    greater_equal = 8 >= 9
    
    return f"""
    Gleichheit (5 == 5): {equal}
    Ungleichheit (5 != 10): {not_equal}
    Kleiner als (3 < 7): {less_than}
    Kleiner gleich (3 <= 3): {less_equal}
    Größer als (8 > 5): {greater_than}
    Größer gleich (8 >= 9): {greater_equal}
    """
```

```python
# Demonstration: Vergleichende Operatoren
comparison_operators()
```

### Verkettung von Vergleichen

- Verkettung mehrerer Vergleichsoperatoren ist möglich
- Entspricht der mathematischen Notation

```python
def comparison_chaining():
    """Demonstriert die Verkettung von Vergleichen."""
    # Prüfen, ob x zwischen 2 und 4 liegt
    x = 3
    result = 2 < x < 4
    
    return f"2 < x < 4 (mit x = 3): {result}"
```

```python
# Demonstration: Verkettung von Vergleichen
comparison_chaining()
```

## Konvertierung zwischen numerischen Datentypen

- Numerische Datentypen können ineinander umgewandelt werden
- Konvertierungsfunktionen: `int()`, `float()`, `bool()`, `complex()`

```python
def numeric_type_conversion():
    """Demonstriert die Konvertierung zwischen numerischen Datentypen."""
    float_from_int = float(33)
    int_from_float = int(33.5)
    bool_from_int = bool(12)
    complex_from_bool = complex(True)
    
    return f"""
    float(33): {float_from_int}
    int(33.5): {int_from_float}
    bool(12): {bool_from_int}
    complex(True): {complex_from_bool}
    """
```

```python
# Demonstration: Konvertierung zwischen numerischen Datentypen
numeric_type_conversion()
```

```python
def conversion_with_variables():
    """Demonstriert die Konvertierung mit Variablen."""
    var1 = 12.5
    result1 = int(var1)
    
    var2 = int(40.25)
    result2 = var2
    
    return f"""
    var1 = 12.5
    int(var1): {result1}
    
    var2 = int(40.25)
    var2: {result2}
    """
```

```python
# Demonstration: Konvertierung mit Variablen
conversion_with_variables()
```

## Ganzzahlen - int

- Der Datentyp `int` repräsentiert ganze Zahlen ohne Nachkommastellen
- In Python haben ganze Zahlen keinen prinzipiellen Wertebereich

```python
def integer_basics():
    """Demonstriert grundlegende Verwendung von int."""
    i = 1234
    p = int(5678)
    
    return f"""
    i = 1234: {i}
    p = int(5678): {p}
    """
```

```python
# Demonstration: Grundlegende Verwendung von int
integer_basics()
```

### Unterstriche in Zahlen-Literalen

- Seit Python 3.6 können Unterstriche zur Gruppierung von Ziffern verwendet werden

```python
def numeric_underscores():
    """Demonstriert die Verwendung von Unterstrichen in Zahlenliteralen."""
    million = 1_000_000
    one_hundred = 1_0_0
    
    return f"""
    1_000_000: {million}
    1_0_0: {one_hundred}
    """
```

```python
# Demonstration: Unterstriche in Zahlenliteralen
numeric_underscores()
```

### Zahlensysteme

- Ganze Zahlen können in verschiedenen Zahlensystemen geschrieben werden
- Dezimalsystem (Basis 10): Ohne Präfix
- Oktalsystem (Basis 8): Präfix `0o`
- Hexadezimalsystem (Basis 16): Präfix `0x`
- Dualsystem/Binärsystem (Basis 2): Präfix `0b`

```python
def number_systems():
    """Demonstriert verschiedene Zahlensysteme."""
    v_dez = 1337
    v_okt = 0o2471
    v_hex = 0x5A3F
    v_bin = 0b1101
    
    return f"""
    Dezimal (1337): {v_dez}
    Oktal (0o2471): {v_okt}
    Hexadezimal (0x5A3F): {v_hex}
    Binär (0b1101): {v_bin}
    """
```

```python
# Demonstration: Verschiedene Zahlensysteme
number_systems()
```

```python
def custom_base_system():
    """Demonstriert die Verwendung eines benutzerdefinierten Zahlensystems."""
    # Sechsersystem (Basis 6)
    v_6 = int("54425", 6)
    
    return f"""
    int("54425", 6): {v_6} (Dezimal)
    """
```

```python
# Demonstration: Benutzerdefiniertes Zahlensystem (Basis 6)
custom_base_system()
```

```python
def negative_number_systems():
    """Demonstriert negative Zahlen in verschiedenen Zahlensystemen."""
    neg_dez = -1234
    neg_okt = -0o777
    neg_hex = -0xFF
    neg_bin = -0b1010101
    
    return f"""
    Negativ Dezimal (-1234): {neg_dez}
    Negativ Oktal (-0o777): {neg_okt}
    Negativ Hexadezimal (-0xFF): {neg_hex}
    Negativ Binär (-0b1010101): {neg_bin}
    """
```

```python
# Demonstration: Negative Zahlen in verschiedenen Zahlensystemen
negative_number_systems()
```

```python
def display_numeric_literals():
    """Demonstriert, dass Zahlensysteme nur alternative Schreibweisen sind."""
    v1 = 0xFF
    v2 = 0o777
    
    return f"""
    v1 = 0xFF: {v1}
    v2 = 0o777: {v2}
    """
```

```python
# Demonstration: Zahlensysteme als alternative Schreibweisen
display_numeric_literals()
```

### Bit-Operationen

- Der Datentyp `int` unterstützt Operationen auf Bit-Ebene
- Bit-Operatoren: `&`, `|`, `^`, `~`, `<<`, `>>`

```python
def bitwise_and():
    """Demonstriert das bitweise UND (&)."""
    result1 = 107 & 25
    result2 = 0b1101011 & 0b11001
    bin_result = bin(0b1101011 & 0b11001)
    
    return f"""
    107 & 25: {result1}
    0b1101011 & 0b11001: {result2}
    bin(0b1101011 & 0b11001): {bin_result}
    """
```

```python
# Demonstration: Bitweises UND (&)
bitwise_and()
```

```python
def bitwise_or():
    """Demonstriert das bitweise ODER (|)."""
    result1 = 107 | 25
    result2 = 0b1101011 | 0b11001
    bin_result = bin(0b1101011 | 0b11001)
    
    return f"""
    107 | 25: {result1}
    0b1101011 | 0b11001: {result2}
    bin(0b1101011 | 0b11001): {bin_result}
    """
```

```python
# Demonstration: Bitweises ODER (|)
bitwise_or()
```

```python
def bitwise_xor():
    """Demonstriert das bitweise ausschließende ODER (^)."""
    result1 = 107 ^ 25
    result2 = 0b1101011 ^ 0b11001
    bin_result = bin(0b1101011 ^ 0b11001)
    
    return f"""
    107 ^ 25: {result1}
    0b1101011 ^ 0b11001: {result2}
    bin(0b1101011 ^ 0b11001): {bin_result}
    """
```

```python
# Demonstration: Bitweises ausschließendes ODER (^)
bitwise_xor()
```

```python
def bitwise_complement():
    """Demonstriert das bitweise Komplement (~)."""
    result1 = ~9
    result2 = ~0b1001
    bin_result = bin(~0b1001)
    
    return f"""
    ~9: {result1}
    ~0b1001: {result2}
    bin(~0b1001): {bin_result}
    """
```

```python
# Demonstration: Bitweises Komplement (~)
bitwise_complement()
```

```python
def bitwise_shift():
    """Demonstriert Bit-Verschiebungen (<<, >>)."""
    left_shift = 107 << 2
    right_shift = 107 >> 2
    bin_left = bin(0b1101011 << 2)
    bin_right = bin(0b1101011 >> 2)
    
    return f"""
    107 << 2: {left_shift}
    107 >> 2: {right_shift}
    bin(0b1101011 << 2): {bin_left}
    bin(0b1101011 >> 2): {bin_right}
    """
```

```python
# Demonstration: Bit-Verschiebungen (<<, >>)
bitwise_shift()
```

### Die Methode bit_length

- Die Methode `bit_length()` berechnet die Anzahl der benötigten Stellen in der Binärdarstellung

```python
def bit_length_demo():
    """Demonstriert die bit_length()-Methode."""
    result1 = (36).bit_length()
    result2 = (4345).bit_length()
    
    return f"""
    (36).bit_length(): {result1}
    (4345).bit_length(): {result2}
    """
```

```python
# Demonstration: bit_length()-Methode
bit_length_demo()
```

## Gleitkommazahlen - float

- Der Datentyp `float` repräsentiert Gleitkommazahlen mit begrenzter Genauigkeit
- Wird für Zahlen mit Nachkommastellen verwendet

```python
def float_basics():
    """Demonstriert grundlegende Verwendung von float."""
    v = 3.141
    neg_three = -3.
    small_number = .001
    
    return f"""
    v = 3.141: {v}
    -3.: {neg_three}
    .001: {small_number}
    """
```

```python
# Demonstration: Grundlegende Verwendung von float
float_basics()
```

```python
def float_underscores():
    """Demonstriert die Verwendung von Unterstrichen in float-Literalen."""
    precise_number = 3.000_000_1
    
    return f"""
    3.000_000_1: {precise_number}
    """
```

```python
# Demonstration: Unterstriche in float-Literalen
float_underscores()
```

### Exponentialschreibweise

- Die Exponentialschreibweise nutzt `e` oder `E` zur Trennung von Mantisse und Exponent

```python
def scientific_notation():
    """Demonstriert die Exponentialschreibweise."""
    v1 = 3.141e-12
    v2 = 03.141e-0012
    
    return f"""
    3.141e-12: {v1}
    03.141e-0012: {v2}
    """
```

```python
# Demonstration: Exponentialschreibweise
scientific_notation()
```

### Genauigkeit

- Float-Werte können nicht immer exakt gespeichert werden

```python
def float_precision():
    """Demonstriert die begrenzte Genauigkeit von float."""
    result = 1.1 + 2.2
    
    return f"""
    1.1 + 2.2: {result}
    """
```

```python
# Demonstration: Begrenzte Genauigkeit von float
float_precision()
```

### Unendlich und Not a Number

- Float kann spezielle Werte wie `inf` (unendlich) und `nan` (nicht berechenbar) darstellen

```python
def infinity_and_nan():
    """Demonstriert die Werte inf und nan."""
    pos_inf = 3.0e999
    neg_inf = -3.0e999
    
    compare1 = 3.0e999 < 12.0
    compare2 = 3.0e999 > 12.0
    compare3 = 3.0e999 == 3.0e999999999999
    
    add_inf = 3.0e999 + 1.5e999999
    sub_inf = 3.0e999 - 1.5e999999
    mul_inf = 3.0e999 * 1.5e999999
    div_inf = 3.0e999 / 1.5e999999
    div_zero = 5 / 1e9999
    
    return f"""
    3.0e999: {pos_inf}
    -3.0e999: {neg_inf}
    
    3.0e999 < 12.0: {compare1}
    3.0e999 > 12.0: {compare2}
    3.0e999 == 3.0e999999999999: {compare3}
    
    3.0e999 + 1.5e999999: {add_inf}
    3.0e999 - 1.5e999999: {sub_inf}
    3.0e999 * 1.5e999999: {mul_inf}
    3.0e999 / 1.5e999999: {div_inf}
    5 / 1e9999: {div_zero}
    """
```

```python
# Demonstration: Infinity und NaN
infinity_and_nan()
```

```python
def create_inf_nan():
    """Demonstriert die Erzeugung von inf und nan."""
    inf_value = float("inf")
    nan_value = float("nan")
    nan_calc = float("inf") / float("inf")
    
    return f"""
    float("inf"): {inf_value}
    float("nan"): {nan_value}
    float("inf") / float("inf"): {nan_calc}
    """
```

```python
# Demonstration: Erzeugung von inf und nan
create_inf_nan()
```

## Boolesche Werte - bool

- Der Datentyp `bool` kann nur zwei Werte annehmen: `True` und `False`
- Entspricht numerisch 1 und 0

```python
def boolean_basics():
    """Demonstriert grundlegende Verwendung von bool."""
    v1 = True
    v2 = False
    
    return f"""
    v1 = True: {v1}
    v2 = False: {v2}
    """
```

```python
# Demonstration: Grundlegende Verwendung von bool
boolean_basics()
```

### Logische Operatoren

- Logische Operatoren: `not`, `and`, `or`

```python
def logical_not():
    """Demonstriert die logische Negierung."""
    x = False
    
    if not x:
        result = "x ist False"
    else:
        result = "x ist True"
    
    return f"""
    not {x}: {not x}
    Ergebnis: {result}
    """
```

```python
# Demonstration: Logische Negierung (not)
logical_not()
```

```python
def logical_and_truth_table():
    """Demonstriert das logische UND mit Wahrheitstabelle."""
    results = []
    for x in [True, False]:
        for y in [True, False]:
            results.append(f"{x} and {y} = {x and y}")
    
    return "\n".join(results)
```

```python
# Demonstration: Wahrheitstabelle für logisches UND
logical_and_truth_table()
```

```python
def logical_or_truth_table():
    """Demonstriert das logische ODER mit Wahrheitstabelle."""
    results = []
    for x in [True, False]:
        for y in [True, False]:
            results.append(f"{x} or {y} = {x or y}")
    
    return "\n".join(results)
```

```python
# Demonstration: Wahrheitstabelle für logisches ODER
logical_or_truth_table()
```

```python
def complex_logical_expression():
    """Demonstriert einen komplexen logischen Ausdruck."""
    results = []
    for x in [True, False]:
        for y in [True, False]:
            for z in [True, False]:
                result = x and y or ((y and z) and not x)
                conditions = f"x={x}, y={y}, z={z}"
                results.append(f"{conditions}: {result}")
    
    return "\n".join(results)
```

```python
# Demonstration: Komplexer logischer Ausdruck
complex_logical_expression()
```

### Wahrheitswerte nicht-boolescher Datentypen

- Instanzen aller Basisdatentypen können als Wahrheitswerte interpretiert werden

```python
def boolean_conversion():
    """Demonstriert die Konvertierung in boolesche Werte."""
    bool_list = bool([1, 2, 3])
    bool_empty_str = bool("")
    bool_negative = bool(-7)
    
    return f"""
    bool([1, 2, 3]): {bool_list}
    bool(""): {bool_empty_str}
    bool(-7): {bool_negative}
    """
```

```python
# Demonstration: Konvertierung in boolesche Werte
boolean_conversion()
```

```python
def using_not_with_objects():
    """Demonstriert die Verwendung von not mit verschiedenen Objekten."""
    not_empty_str = not ""
    not_non_empty_str = not "abc"
    
    return f"""
    not "": {not_empty_str}
    not "abc": {not_non_empty_str}
    """
```

```python
# Demonstration: not mit verschiedenen Objekten
using_not_with_objects()
```

### Auswertung logischer Operatoren

- Python wertet logische Ausdrücke von links nach rechts aus
- Die Auswertung wird abgebrochen, sobald das Ergebnis feststeht (Lazy Evaluation)

```python
def lazy_evaluation():
    """Demonstriert die Lazy Evaluation."""
    a = True
    
    # Wenn a True ist, wird der zweite Teil nicht ausgewertet
    # Hier wird ein Beispiel gezeigt, wie es im interaktiven Modus aussehen würde
    result = f"""
    >>> a = True
    >>> if a or print("Lazy "):
    ...     print("Evaluation")
    ...
    Evaluation
    """
    
    return result
```

```python
# Demonstration: Lazy Evaluation
lazy_evaluation()
```

```python
def operator_return_values():
    """Demonstriert die Rückgabewerte von logischen Operatoren."""
    result1 = 0 or 1
    result2 = "Python" or "Java"
    
    return f"""
    0 or 1: {result1}
    "Python" or "Java": {result2}
    """
```

```python
# Demonstration: Rückgabewerte von logischen Operatoren
operator_return_values()
```

## Komplexe Zahlen - complex

- Der Datentyp `complex` repräsentiert komplexe Zahlen
- Besteht aus Realteil und Imaginärteil, getrennt durch ein `j` oder `J`

```python
def complex_basics():
    """Demonstriert grundlegende Verwendung von complex."""
    v = 4j
    v1 = 3 + 4j
    v2 = 4j + 3
    v3 = 3.4 + 4e2j
    
    return f"""
    v = 4j: {v}
    v1 = 3 + 4j: {v1}
    v2 = 4j + 3: {v2}
    v3 = 3.4 + 4e2j: {v3}
    """
```

```python
# Demonstration: Grundlegende Verwendung von complex
complex_basics()
```

```python
def complex_attributes():
    """Demonstriert die Attribute von complex."""
    c = 23 + 4j
    
    return f"""
    c = 23 + 4j
    c.real: {c.real}
    c.imag: {c.imag}
    """
```

```python
# Demonstration: Attribute von complex
complex_attributes()
```

```python
def complex_conjugate():
    """Demonstriert die conjugate()-Methode."""
    c = 23 + 4j
    c2 = c.conjugate()
    c3 = c2.conjugate()
    
    return f"""
    c = 23 + 4j
    c.conjugate(): {c.conjugate()}
    c2 = c.conjugate(): {c2}
    c3 = c2.conjugate(): {c3}
    """
```

```python
# Demonstration: conjugate()-Methode
complex_conjugate()
```