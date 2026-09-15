# Python Sequenzielle Datentypen

## Sequenzielle Datentypen - Grundlagen

- Sequenzielle Datentypen verwalten Folgen von Elementen
- Die Elemente haben eine definierte Reihenfolge
- Man kann über eindeutige Indizes auf die Elemente zugreifen
- Python bietet diese sequenziellen Typen: `str`, `bytes`, `bytearray`, `list` und `tuple`

## Text und Binärdaten

- `str`: Für Text (Buchstaben, Leerzeichen, Interpunktionszeichen, Zeilenvorschübe)
- `bytes` und `bytearray`: Für Binärdaten (Folge von Bytes)
- Hauptunterschied: `bytearray` ist veränderlich, `bytes` nicht
- Python 3 trennt klar zwischen Text und Binärdaten (anders als Python 2)

```python
def demonstrate_immutability():
    """Demonstriert die Unveränderlichkeit von str und bytes."""
    s = "Dieser String ist immutabel"
    # Versuch, den String zu ändern, würde einen Fehler verursachen
    # s[0] = "d"  # TypeError: 'str' object does not support item assignment
    
    b = b"Diese Bytes sind immutabel"
    # Versuch, die Bytes zu ändern, würde einen Fehler verursachen
    # b[0] = 100  # TypeError: 'bytes' object does not support item assignment
    
    # bytearray ist jedoch veränderlich
    ba = bytearray(b"Diese Bytearray ist mutabel")
    ba[0] = 100  # Ersetzt 'D' durch 'd'
    
    return f"Original bytearray: b'Diese Bytearray ist mutabel'\nGeänderte bytearray: {ba}"
```

```python
# Demonstration: Unveränderlichkeit von str und bytes vs. Veränderlichkeit von bytearray
demonstrate_immutability()
```

## Operationen auf sequenziellen Datentypen

### Auf Elemente prüfen mit `in` und `not in`

```python
def demonstrate_in_operator_list():
    """Demonstriert den in-Operator mit Listen."""
    lst = ["eins", 2, 3.0, "vier", 5, "sechs", "sieben"]
    contains_3 = 3.0 in lst
    contains_vier = "vier" in lst
    contains_10 = 10 in lst
    
    return f"3.0 in lst: {contains_3}\n\"vier\" in lst: {contains_vier}\n10 in lst: {contains_10}"
```

```python
# Demonstration: in-Operator mit Listen
demonstrate_in_operator_list()
```

```python
def demonstrate_in_operator_string():
    """Demonstriert den in-Operator mit Strings."""
    s = "Dies ist unser Test-String"
    contains_u = "u" in s
    contains_j = "j" in s
    
    result = f"\"u\" in s: {contains_u}\n\"j\" in s: {contains_j}"
    
    # Prüfen auf Teilstrings
    contains_ist = "ist" in s
    contains_hallo = "Hallo" in s
    
    result += f"\n\n\"ist\" in s: {contains_ist}\n\"Hallo\" in s: {contains_hallo}"
    
    return result
```

```python
# Demonstration: in-Operator mit Strings
demonstrate_in_operator_string()
```

```python
def demonstrate_not_in_operator():
    """Demonstriert den not in-Operator."""
    text = "Besuch beim Zahnarzt"
    a_not_in_text = "a" not in text
    a_in_text = "a" in text
    not_a_in_text = not "a" in text
    
    return f"\"a\" not in \"{text}\": {a_not_in_text}\n\"a\" in \"{text}\": {a_in_text}\nnot \"a\" in \"{text}\": {not_a_in_text}"
```

```python
# Demonstration: not in-Operator
demonstrate_not_in_operator()
```

### Verkettung mit `+` und `+=`

```python
def demonstrate_string_concatenation():
    """Demonstriert die Verkettung von Strings mit +."""
    vorname = "Heinz"
    nachname = "Meier"
    name = vorname + " " + nachname
    
    return f"vorname: {vorname}\nnachname: {nachname}\nname: {name}"
```

```python
# Demonstration: Verkettung von Strings mit +
demonstrate_string_concatenation()
```

```python
def demonstrate_plusequals_operator_str():
    """Demonstriert den += Operator mit Strings."""
    s = "Musik"
    t = "lautsprecher"
    s += t
    
    return f"s nach s += t: {s}"
```

```python
# Demonstration: += Operator mit Strings
demonstrate_plusequals_operator_str()
```

```python
def demonstrate_plusequals_immutable_vs_mutable():
    """Demonstriert den Unterschied von += bei immutablen und mutablen Typen."""
    # Bei immutablen Typen (str)
    s = "Musik"
    t = "lautsprecher"
    temp = s
    s += t
    
    result = f"Nach s += t (immutable str):\ns: {s}\nt: {t}\ntemp: {temp}\ntemp is s: {temp is s}"
    
    # Bei mutablen Typen (list)
    s_list = [1, 2]
    t_list = [3, 4]
    temp_list = s_list
    s_list += t_list
    
    result += f"\n\nNach s_list += t_list (mutable list):\ns_list: {s_list}\nt_list: {t_list}\ntemp_list: {temp_list}\ntemp_list is s_list: {temp_list is s_list}"
    
    return result
```

```python
# Demonstration: += Operator bei immutablen vs. mutablen Typen
demonstrate_plusequals_immutable_vs_mutable()
```

### Wiederholung mit `*` und `*=`

```python
def demonstrate_repetition_operators():
    """Demonstriert die Wiederholungsoperatoren * und *=."""
    # Strings mit * wiederholen
    result = f"3 * \"abc\": {3 * 'abc'}"
    result += f"\n\"xyz\" * 5: {'xyz' * 5}"
    
    # Strings mit *= wiederholen
    weihnachtsmann = "ho"
    weihnachtsmann *= 3
    result += f"\nweihnachtsmann nach weihnachtsmann *= 3: {weihnachtsmann}"
    
    # Listen mit * wiederholen
    numbers = [1, 2] * 3
    result += f"\n[1, 2] * 3: {numbers}"
    
    return result
```

```python
# Demonstration: Wiederholungsoperatoren * und *=
demonstrate_repetition_operators()
```

```python
def demonstrate_list_repetition_side_effect():
    """Demonstriert Seiteneffekte bei der Listenwiederholung."""
    # Listen mit verschachtelten Listen multiplizieren
    x = [["Schöne"], ["Liste"]] * 3
    result = f"x nach [['Schöne'], ['Liste']] * 3: {x}"
    
    # Seiteneffekt: Änderung eines Elements ändert alle Referenzen
    x[1][0] = "Hä?"
    result += f"\nx nach x[1][0] = \"Hä?\": {x}"
    
    return result
```

```python
# Demonstration: Seiteneffekte bei der Listenwiederholung
demonstrate_list_repetition_side_effect()
```

### Indizierung mit []

```python
def demonstrate_indexing():
    """Demonstriert die Indizierung von Sequenzen."""
    # Indizierung bei Strings
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    result = f"alphabet[9]: {alphabet[9]}"
    result += f"\nalphabet[1]: {alphabet[1]}"
    
    # Indizierung bei Listen
    l = [1, 2, 3, 4, 5, 6]
    result += f"\nl[3]: {l[3]}"
    
    # Negative Indizierung
    name = "Python"
    result += f"\nname[-2]: {name[-2]}"
    result += f"\nl[-1]: {l[-1]}"
    
    return result
```

```python
# Demonstration: Indizierung von Sequenzen
demonstrate_indexing()
```

### Slicing

```python
def demonstrate_basic_slicing():
    """Demonstriert grundlegendes Slicing."""
    s = "schrottWICHTIGschrott"
    result = f"s[7]: {s[7]}"
    result += f"\ns[14]: {s[14]}"
    result += f"\ns[7:14]: {s[7:14]}"
    
    # Slicing bei Listen
    l = ["Ich", "bin", "eine", "Liste", "von", "Strings"]
    result += f"\nl[2:5]: {l[2:5]}"
    
    # Mischen von positiven und negativen Indizes
    string = "ameisen"
    result += f"\nstring[1:-1]: {string[1:-1]}"
    result += f"\nl[1:-1]: {l[1:-1]}"
    
    return result
```

```python
# Demonstration: Grundlegendes Slicing
demonstrate_basic_slicing()
```

```python
def demonstrate_slicing_with_omitted_indices():
    """Demonstriert Slicing mit ausgelassenen Indizes."""
    s = "abcdefghijklmnopqrstuvwxyz"
    result = f"s[:5]: {s[:5]}"
    result += f"\ns[5:]: {s[5:]}"
    
    return result
```

```python
# Demonstration: Slicing mit ausgelassenen Indizes
demonstrate_slicing_with_omitted_indices()
```

```python
def demonstrate_slicing_for_copying():
    """Demonstriert Slicing zum Kopieren von Sequenzen."""
    # Bei mutablen Typen (list)
    s1 = ["Doktorarbeit"]
    s2 = s1[:]
    
    result = f"s1: {s1}"
    result += f"\ns2: {s2}"
    result += f"\ns1 == s2: {s1 == s2}"
    result += f"\ns1 is s2: {s1 is s2}"
    
    # Bei immutablen Typen (str)
    str1 = "Kopiere mich"
    str2 = str1[:]
    
    result += f"\n\nstr1: {str1}"
    result += f"\nstr2: {str2}"
    result += f"\nstr1 == str2: {str1 == str2}"
    result += f"\nstr1 is str2: {str1 is str2}"
    
    return result
```

```python
# Demonstration: Slicing zum Kopieren von Sequenzen
demonstrate_slicing_for_copying()
```

```python
def demonstrate_slicing_with_step():
    """Demonstriert Slicing mit Schrittweite."""
    ziffern = "0123456789"
    result = f"ziffern[1:10:2]: {ziffern[1:10:2]}"
    
    # Mit ausgelassenen Indizes
    result += f"\nziffern[1::2]: {ziffern[1::2]}"
    
    # Mit negativer Schrittweite
    name = "ytnoM Python"
    result += f"\nname[4::-1]: {name[4::-1]}"
    result += f"\nname[::-1]: {name[::-1]}"
    
    return result
```

```python
# Demonstration: Slicing mit Schrittweite
demonstrate_slicing_with_step()
```

```python
def demonstrate_slicing_edge_cases():
    """Demonstriert Grenzfälle beim Slicing."""
    s = "Viel weniger als 1337 Zeichen"
    result = f"s[5:1337]: {s[5:1337]}"
    result += f"\ns[-100:100]: {s[-100:100]}"
    result += f"\ns[1337:2674]: {s[1337:2674]}"
    result += f"\ns[10:4]: {s[10:4]}"
    
    return result
```

```python
# Demonstration: Grenzfälle beim Slicing
demonstrate_slicing_edge_cases()
```

### Länge einer Sequenz - `len()`

```python
def demonstrate_len_function():
    """Demonstriert die len()-Funktion für Sequenzen."""
    string = "Wie lang bin ich wohl?"
    result = f"len(\"{string}\"): {len(string)}"
    
    lst = ["Hallo", 5, 2, 3, "Welt"]
    result += f"\nlen({lst}): {len(lst)}"
    
    return result
```

```python
# Demonstration: len()-Funktion für Sequenzen
demonstrate_len_function()
```

### Das kleinste und größte Element - `min()` und `max()`

```python
def demonstrate_min_max_functions():
    """Demonstriert die min()- und max()-Funktionen für Sequenzen."""
    l = [5, 1, 10, -9.5, 12, -5]
    result = f"max({l}): {max(l)}"
    result += f"\nmin({l}): {min(l)}"
    
    # Fehler bei nicht vergleichbaren Typen
    # l = [1, 2, "welt"]
    # min(l)  # TypeError: '<' not supported between instances of 'str' and 'int'
    
    # min und max mit Strings
    result += f"\nmax(\"wer gewinnt wohl\"): {max('wer gewinnt wohl')}"
    result += f"\nmin(\"zeichenkette\"): {min('zeichenkette')}"
    
    return result
```

```python
# Demonstration: min()- und max()-Funktionen für Sequenzen
demonstrate_min_max_functions()
```

### Ein Element suchen - `index()`

```python
def demonstrate_index_method():
    """Demonstriert die index()-Methode für Sequenzen."""
    ziffern = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    result = f"ziffern.index(3): {ziffern.index(3)}"
    
    s = "Hallo Welt"
    result += f"\ns.index(\"l\"): {s.index('l')}"
    
    # index mit optionalen Parametern
    folge = [0, 11, 222, 3333, 44444, 3333, 222, 11, 0]
    result += f"\nfolge.index(222): {folge.index(222)}"
    result += f"\nfolge.index(222, 3): {folge.index(222, 3)}"
    result += f"\nfolge.index(222, -5): {folge.index(222, -5)}"
    result += f"\n\"Hallo Welt\".index(\"l\", 5, 100): {'Hallo Welt'.index('l', 5, 100)}"
    
    return result
```

```python
# Demonstration: index()-Methode für Sequenzen
demonstrate_index_method()
```

### Elemente zählen - `count()`

```python
def demonstrate_count_method():
    """Demonstriert die count()-Methode für Sequenzen."""
    s = [1, 2, 2, 3, 2]
    result = f"s.count(2): {s.count(2)}"
    
    result += f"\n\"Hallo Welt\".count(\"l\"): {'Hallo Welt'.count('l')}"
    
    return result
```

```python
# Demonstration: count()-Methode für Sequenzen
demonstrate_count_method()
```

## Listen – `list`

- Listen sind veränderbare (mutable) Sequenzen
- Können beliebige Instanzen auch unterschiedlicher Datentypen enthalten
- Durch eckige Klammern `[]` definiert

```python
def demonstrate_list_creation():
    """Demonstriert die Erzeugung von Listen."""
    # Einfache Liste mit verschiedenen Datentypen
    l = [1, 0.5, "String", 2]
    
    # List Comprehension
    squares = [i*i for i in range(10)]
    
    # Unpacking
    with_unpacking = [1, 2, *[3, 4]]
    
    return f"Einfache Liste: {l}\nQuadratzahlen mit List Comprehension: {squares}\nMit Unpacking: {with_unpacking}"
```

```python
# Demonstration: Erzeugung von Listen
demonstrate_list_creation()
```

### Verändern von Listen

```python
def demonstrate_list_modification():
    """Demonstriert das Verändern von Listenelementen."""
    s = [1, 2, 3, 4, 5, 6, 7]
    s[3] = 1337
    
    return f"Liste nach s[3] = 1337: {s}"
```

```python
# Demonstration: Verändern von Listenelementen
demonstrate_list_modification()
```

```python
def demonstrate_list_replace_sublist():
    """Demonstriert das Ersetzen von Teillisten."""
    einkaufen = ["Brot", "Eier", "Milch", "Fisch", "Mehl"]
    einkaufen[1:3] = ["Wasser", "Wurst"]
    
    return f"Einkaufsliste nach Ersetzung: {einkaufen}"
```

```python
# Demonstration: Ersetzen von Teillisten
demonstrate_list_replace_sublist()
```

```python
def demonstrate_list_replace_with_step():
    """Demonstriert das Ersetzen mit Schrittweite."""
    s = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    s[2:9:3] = ["A", "B", "C"]
    
    return f"Liste nach s[2:9:3] = [\"A\", \"B\", \"C\"]: {s}"
```

```python
# Demonstration: Ersetzen mit Schrittweite
demonstrate_list_replace_with_step()
```

```python
def demonstrate_list_delete_elements():
    """Demonstriert das Löschen von Listenelementen mit del."""
    s = [26, 7, 1987]
    del s[0]
    result = f"Liste nach del s[0]: {s}"
    
    s = [9, 8, 7, 6, 5, 4, 3, 2, 1]
    del s[3:6]
    result += f"\nListe nach del s[3:6]: {s}"
    
    s = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]
    del s[::2]
    result += f"\nListe nach del s[::2]: {s}"
    
    return result
```

```python
# Demonstration: Löschen von Listenelementen mit del
demonstrate_list_delete_elements()
```

### Methoden von `list`-Instanzen

```python
def demonstrate_list_append_method():
    """Demonstriert die append()-Methode für Listen."""
    s = ["Nach mir soll noch ein String stehen"]
    s.append("Hier ist er")
    
    return f"Liste nach s.append(\"Hier ist er\"): {s}"
```

```python
# Demonstration: append()-Methode für Listen
demonstrate_list_append_method()
```

```python
def demonstrate_list_extend_method():
    """Demonstriert die extend()-Methode für Listen."""
    s = [1, 2, 3]
    s.extend([4, 5, 6])
    
    return f"Liste nach s.extend([4, 5, 6]): {s}"
```

```python
# Demonstration: extend()-Methode für Listen
demonstrate_list_extend_method()
```

```python
def demonstrate_list_insert_method():
    """Demonstriert die insert()-Methode für Listen."""
    erst_mit_luecke = [1, 2, 3, 5, 6, 7, 8]
    erst_mit_luecke.insert(3, 4)
    
    return f"Liste nach erst_mit_luecke.insert(3, 4): {erst_mit_luecke}"
```

```python
# Demonstration: insert()-Methode für Listen
demonstrate_list_insert_method()
```

```python
def demonstrate_list_pop_method():
    """Demonstriert die pop()-Methode für Listen."""
    s = ["H", "a", "l", "l", "o"]
    last = s.pop()
    first = s.pop(0)
    
    return f"Entferntes letztes Element mit s.pop(): {last}\nEntferntes erstes Element mit s.pop(0): {first}\nVerbleibende Liste: {s}"
```

```python
# Demonstration: pop()-Methode für Listen
demonstrate_list_pop_method()
```

```python
def demonstrate_list_remove_method():
    """Demonstriert die remove()-Methode für Listen."""
    s = ["H", "u", "h", "u"]
    s.remove("u")
    
    return f"Liste nach s.remove(\"u\"): {s}"
```

```python
# Demonstration: remove()-Methode für Listen
demonstrate_list_remove_method()
```

```python
def demonstrate_list_reverse_method():
    """Demonstriert die reverse()-Methode für Listen."""
    s = [1, 2, 3]
    s.reverse()
    
    return f"Liste nach s.reverse(): {s}"
```

```python
# Demonstration: reverse()-Methode für Listen
demonstrate_list_reverse_method()
```

```python
def demonstrate_list_sort_method():
    """Demonstriert die sort()-Methode für Listen."""
    l = [4, 2, 7, 3, 6, 1, 9, 5, 8]
    l.sort()
    result = f"Liste nach l.sort(): {l}"
    
    # Sortieren nach Länge mit key-Parameter
    names = ["Katharina", "Peter", "Jan", "Florian", "Paula", "Ben"]
    names.sort(key=len)
    result += f"\nListe nach names.sort(key=len): {names}"
    
    # Sortieren in absteigender Reihenfolge
    numbers = [4, 2, 7, 3, 6, 1, 9, 5, 8]
    numbers.sort(reverse=True)
    result += f"\nListe nach numbers.sort(reverse=True): {numbers}"
    
    return result
```

```python
# Demonstration: sort()-Methode für Listen
demonstrate_list_sort_method()
```

### Seiteneffekte bei Listen

```python
def demonstrate_list_side_effects():
    """Demonstriert Seiteneffekte bei Listen."""
    # Bei immutablen Typen (str)
    a = "Hallo "
    b = a
    b += "Welt"
    result = f"Nach b += \"Welt\" (immutable str):\na: {a}\nb: {b}"
    
    # Bei mutablen Typen (list)
    a_list = [1337]
    b_list = a_list
    b_list += [2674]
    result += f"\n\nNach b_list += [2674] (mutable list):\na_list: {a_list}\nb_list: {b_list}\na_list is b_list: {a_list is b_list}"
    
    # Vermeiden von Seiteneffekten durch Kopieren
    a_copy = [1337]
    b_copy = a_copy[:]
    b_copy += [2674]
    result += f"\n\nNach b_copy += [2674] (mit Slice-Kopie):\na_copy: {a_copy}\nb_copy: {b_copy}\na_copy is b_copy: {a_copy is b_copy}"
    
    return result
```

```python
# Demonstration: Seiteneffekte bei Listen
demonstrate_list_side_effects()
```

```python
def demonstrate_list_self_reference():
    """Demonstriert Selbstreferenzen in Listen."""
    a = []
    a.append(a)
    
    # Direktes print(a) würde [[...]] ausgeben
    # Wir geben hier eine Beschreibung zurück
    return "Liste a enthält sich selbst als Element: a = [a]"
```

```python
# Demonstration: Selbstreferenzen in Listen
demonstrate_list_self_reference()
```

### List Comprehensions

```python
def demonstrate_list_comprehension_basics():
    """Demonstriert grundlegende List Comprehensions."""
    # Traditioneller Ansatz mit Schleife
    lst = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    squares_traditional = []
    for x in lst:
        squares_traditional.append(x**2)
    
    # Mit List Comprehension
    squares_comprehension = [x**2 for x in lst]
    
    return f"Quadratzahlen mit traditioneller Schleife: {squares_traditional}\nQuadratzahlen mit List Comprehension: {squares_comprehension}"
```

```python
# Demonstration: Grundlegende List Comprehensions
demonstrate_list_comprehension_basics()
```

```python
def demonstrate_list_comprehension_with_condition():
    """Demonstriert List Comprehensions mit Bedingungen."""
    lst = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    even_squares = [x**2 for x in lst if x % 2 == 0]
    
    return f"Quadratzahlen der geraden Zahlen aus {lst}: {even_squares}"
```

```python
# Demonstration: List Comprehensions mit Bedingungen
demonstrate_list_comprehension_with_condition()
```

```python
def demonstrate_list_comprehension_vector_addition():
    """Demonstriert List Comprehensions für Vektoraddition."""
    v1 = [1, 7, -5]
    v2 = [-9, 3, 12]
    vector_sum = [v1[i] + v2[i] for i in range(3)]
    
    return f"Vektoraddition von {v1} und {v2}: {vector_sum}"
```

```python
# Demonstration: List Comprehensions für Vektoraddition
demonstrate_list_comprehension_vector_addition()
```

```python
def demonstrate_list_comprehension_nested():
    """Demonstriert verschachtelte List Comprehensions."""
    lst1 = ["A", "B", "C"]
    lst2 = ["D", "E", "F"]
    combinations = [(a, b) for a in lst1 for b in lst2]
    
    return f"Alle Kombinationen aus {lst1} und {lst2}: {combinations}"
```

```python
# Demonstration: Verschachtelte List Comprehensions
demonstrate_list_comprehension_nested()
```

## Unveränderliche Listen – `tuple`

- Tupel sind unveränderliche (immutable) Sequenzen
- Können wie Listen beliebige Instanzen auch unterschiedlicher Datentypen enthalten
- Durch runde Klammern `()` definiert

```python
def demonstrate_tuple_creation():
    """Demonstriert die Erzeugung von Tupeln."""
    a = (1, 2, 3, 4, 5)
    empty_tuple = ()
    single_element_tuple = (2,)  # Komma ist wichtig!
    
    # Was passiert ohne Komma?
    not_a_tuple = (2)
    
    return f"Tupel: {a}\nLeeres Tupel: {empty_tuple}\nTupel mit einem Element: {single_element_tuple}\nKein Tupel (sondern int): {not_a_tuple}, Typ: {type(not_a_tuple)}"
```

```python
# Demonstration: Erzeugung von Tupeln
demonstrate_tuple_creation()
```

### Packing und Unpacking

```python
def demonstrate_tuple_packing():
    """Demonstriert Tuple Packing."""
    # Packing (ohne Klammern)
    datum = 26, 7, 1987
    
    return f"Durch Packing erzeugtes Tupel: {datum}"
```

```python
# Demonstration: Tuple Packing
demonstrate_tuple_packing()
```

```python
def demonstrate_tuple_unpacking():
    """Demonstriert Tuple Unpacking."""
    datum = 26, 7, 1987
    tag, monat, jahr = datum
    
    return f"Durch Unpacking extrahierte Werte: tag={tag}, monat={monat}, jahr={jahr}"
```

```python
# Demonstration: Tuple Unpacking
demonstrate_tuple_unpacking()
```

```python
def demonstrate_variable_swap():
    """Demonstriert das Tauschen von Variablen mit Packing und Unpacking."""
    a, b = 10, 20
    result = f"Vor dem Tausch: a={a}, b={b}"
    
    a, b = b, a
    result += f"\nNach dem Tausch: a={a}, b={b}"
    
    return result
```

```python
# Demonstration: Tauschen von Variablen mit Packing und Unpacking
demonstrate_variable_swap()
```

```python
def demonstrate_sequence_unpacking():
    """Demonstriert Sequence Unpacking mit verschiedenen Sequenztypen."""
    # Unp