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
    # Unpacking mit Strings
    a, b, c = "abc"
    
    return f"Unpacking eines Strings 'abc': a={a}, b={b}, c={c}"
```

```python
# Demonstration: Sequence Unpacking mit verschiedenen Sequenztypen
demonstrate_sequence_unpacking()
```

```python
def demonstrate_advanced_unpacking():
    """Demonstriert erweitertes Unpacking mit *."""
    zahlen = [11, 18, 12, 15, 10]
    elf, *andere, zehn = zahlen
    
    return f"Erweitertes Unpacking von {zahlen}:\nelf={elf}, andere={andere}, zehn={zehn}"
```

```python
# Demonstration: Erweitertes Unpacking mit *
demonstrate_advanced_unpacking()
```

```python
def demonstrate_more_advanced_unpacking():
    """Demonstriert weitere Varianten des erweiterten Unpackings."""
    zahlen = [11, 17, 17, 19, 10]
    
    # * am Anfang
    *irgendwas, neunzehn, zehn = zahlen
    result = f"Unpacking mit * am Anfang: *irgendwas, neunzehn, zehn = {zahlen}\nirgendwas={irgendwas}, neunzehn={neunzehn}, zehn={zehn}"
    
    # * am Ende
    elf, *blablabla = zahlen
    result += f"\n\nUnpacking mit * am Ende: elf, *blablabla = {zahlen}\nelf={elf}, blablabla={blablabla}"
    
    return result
```

```python
# Demonstration: Weitere Varianten des erweiterten Unpackings
demonstrate_more_advanced_unpacking()
```

### Veränderung von Tupel-Elementen

```python
def demonstrate_tuple_immutability():
    """Demonstriert, dass immutable nicht immer unveränderlich bedeutet."""
    a = ([],)
    a[0].append("Und sie dreht sich doch!")
    
    return f"Tupel nach a[0].append(...): {a}\nDas Tupel selbst ist immutable, aber seine Elemente können mutable sein."
```

```python
# Demonstration: Veränderung von Tupel-Elementen
demonstrate_tuple_immutability()
```

## Strings – `str`, `bytes`, `bytearray`

- Strings sind Folgen von Zeichen (Buchstaben, Leerzeichen, Satzzeichen)
- `str`: Für Text, immutable
- `bytes`: Für Binärdaten, immutable
- `bytearray`: Für Binärdaten, mutable

```python
def demonstrate_string_creation():
    """Demonstriert die Erzeugung von Strings."""
    string1 = "Ich wurde mit doppelten Hochkommata definiert"
    string2 = 'Ich wurde mit einfachen Hochkommata definiert'
    string3 = """Erste Zeile!
Ui, noch eine Zeile"""
    
    # Direkte Verkettung von String-Literalen
    string4 = "Erster Teil" "Zweiter Teil"
    
    # Aufteilung langer Strings auf mehrere Zeilen
    string5 = ("Stellen Sie sich einen schrecklich "
             "komplizierten String vor, den man "
             "auf keinen Fall in eine Zeile schreiben "
             "kann.")
    
    return f"String mit doppelten Hochkommata: {string1}\nString mit einfachen Hochkommata: {string2}\nMehrzeiliger String: {string3}\nVerkettete Literale: {string4}\nAufgeteilter String: {string5}"
```

```python
# Demonstration: Erzeugung von Strings
demonstrate_string_creation()
```

```python
def demonstrate_bytes_creation():
    """Demonstriert die Erzeugung von bytes und bytearray."""
    string1 = b"Ich bin bytes!"
    
    # bytearray aus bytes
    string2 = bytearray(string1)
    
    # bytearray mit Länge
    bytes_zeros = bytearray(7)
    
    return f"bytes: {string1}\nbytearray aus bytes: {string2}\nbytearray mit 7 Nullbytes: {bytes_zeros}"
```

```python
# Demonstration: Erzeugung von bytes und bytearray
demonstrate_bytes_creation()
```

### Steuerzeichen

```python
def demonstrate_escape_sequences():
    """Demonstriert Escape-Sequenzen in Strings."""
    # Zeilenumbruch
    a = "Erste Zeile\nZweite Zeile"
    result = f"String mit Zeilenumbruch: {a}"
    
    # Verschiedene Escape-Sequenzen
    b = "Tab:\t| Backslash:\\ | Anführungszeichen:\" | Alarm:\a"
    result += f"\n\nVerschiedene Escape-Sequenzen: {b}"
    
    # Escape-Sequenzen für Hochkommata
    c = "Das folgende Hochkomma muss nicht codiert werden ' "
    d = "Dieses doppelte Hochkomma schon \" "
    e = 'Das gilt auch in Strings mit einfachen Hochkommata " '
    f = 'Hier muss eine Escape-Sequenz benutzt werden \' '
    result += f"\n\nHochkommata in Strings: {c}, {d}, {e}, {f}"
    
    return result
```

```python
# Demonstration: Escape-Sequenzen in Strings
demonstrate_escape_sequences()
```

```python
def demonstrate_raw_strings():
    """Demonstriert Raw-Strings mit r-Präfix."""
    normal = "Ein \tString mit \\ vielen \nEscape-Sequenzen\t"
    raw = r"Ein \tString mit \\ vielen \nEscape-Sequenzen\t"
    
    return f"Normaler String: {normal}\nRaw-String: {raw}"
```

```python
# Demonstration: Raw-Strings mit r-Präfix
demonstrate_raw_strings()
```

### String-Methoden

#### Trennen von Strings

```python
def demonstrate_string_split():
    """Demonstriert die split()-Methode von Strings."""
    s = "1-2-3-4-5-6-7-8-9-10"
    result = f"s.split(\"-\"): {s.split('-')}"
    result += f"\ns.split(\"-\", 5): {s.split('-', 5)}"
    result += f"\ns.rsplit(\"-\", 5): {s.rsplit('-', 5)}"
    
    # Aufeinanderfolgende Trennzeichen
    s2 = "1---2-3"
    result += f"\n\ns2.split(\"-\"): {s2.split('-')}"
    
    # split ohne Parameter
    s3 = " Irgendein \t\t Satz mit \n\r\t Whitespaces"
    result += f"\n\ns3.split(): {s3.split()}"
    
    return result
```

```python
# Demonstration: split()-Methode von Strings
demonstrate_string_split()
```

```python
def demonstrate_string_splitlines():
    """Demonstriert die splitlines()-Methode von Strings."""
    s = "Unix\nWindows\r\nMac\rLetzte Zeile"
    result = f"s.splitlines(): {s.splitlines()}"
    
    return result
```

```python
# Demonstration: splitlines()-Methode von Strings
demonstrate_string_splitlines()
```

```python
def demonstrate_string_partition():
    """Demonstriert die partition()-Methode von Strings."""
    s = "www.rheinwerk-verlag.de"
    result = f"s.partition(\".\"): {s.partition('.')}"
    result += f"\ns.rpartition(\".\"): {s.rpartition('.')}"
    
    return result
```

```python
# Demonstration: partition()-Methode von Strings
demonstrate_string_partition()
```

#### Suchen von Teil-Strings

```python
def demonstrate_string_find_methods():
    """Demonstriert die Suchmethoden für Strings."""
    s = "Mal sehen, wo das 'e' in diesem String vorkommt"
    result = f"s.find(\"e\"): {s.find('e')}"
    result += f"\ns.rfind(\"e\"): {s.rfind('e')}"
    
    s2 = "Dieser String wird gleich durchsucht"
    result += f"\n\ns2.index(\"wird\"): {s2.index('wird')}"
    
    # ValueError bei nicht gefundenem Substring
    # s2.index("nicht vorhanden")  # ValueError: substring not found
    
    # count-Methode
    result += f"\n\n\"Fischers Fritze fischt frische Fische\".count(\"sch\"): {'Fischers Fritze fischt frische Fische'.count('sch')}"
    
    return result
```

```python
# Demonstration: Suchmethoden für Strings
demonstrate_string_find_methods()
```

#### Ersetzen von Teil-Strings

```python
def demonstrate_string_replace():
    """Demonstriert die replace()-Methode von Strings."""
    falsch = "Python ist nicht toll!"
    richtig = falsch.replace("nicht", "richtig")
    
    result = f"Original: {falsch}\nErsetzt: {richtig}"
    
    # Begrenzte Anzahl von Ersetzungen
    s = "Bitte nur die ersten vier e ersetzen"
    result += f"\n\nOriginal: {s}\nMit begrenzten Ersetzungen: {s.replace('e', 'E', 4)}"
    
    # Leerer String als Erstes Argument
    s2 = "abcdefg"
    result += f"\n\nMit leerem Suchstring: s2.replace(\"\", \"--\"): {s2.replace('', '--')}"
    
    return result
```

```python
# Demonstration: replace()-Methode von Strings
demonstrate_string_replace()
```

```python
def demonstrate_string_case_methods():
    """Demonstriert Methoden zum Ändern der Groß- und Kleinschreibung."""
    s1 = "ERST GANZ GROSS UND DANN GANZ KLEIN!"
    result = f"Original: {s1}\ns1.lower(): {s1.lower()}"
    
    s2 = "wENN MAN IM dEUTSCHEN ALLE wORTE SO SCHRIEBE ..."
    result += f"\n\nOriginal: {s2}\ns2.swapcase(): {s2.swapcase()}"
    
    s3 = "alles klein ... noch ;)"
    result += f"\n\nOriginal: {s3}\ns3.capitalize(): {s3.capitalize()}"
    
    s4 = "nOch BIn iCH eheR weNiGEr alS TITeL gEeiGNEt"
    result += f"\n\nOriginal: {s4}\ns4.title(): {s4.title()}"
    
    return result
```

```python
# Demonstration: Methoden zum Ändern der Groß- und Kleinschreibung
demonstrate_string_case_methods()
```

```python
def demonstrate_string_expandtabs():
    """Demonstriert die expandtabs()-Methode von Strings."""
    s = ("\tHier kann Quellcode stehen\n" +
         "\t\tEine Ebene weiter unten")
    
    result = f"Original:\n{s}\n\nMit expandtabs(4):\n{s.expandtabs(4)}"
    
    return result
```

```python
# Demonstration: expandtabs()-Methode von Strings
demonstrate_string_expandtabs()
```

#### Entfernen bestimmter Zeichen

```python
def demonstrate_string_strip_methods():
    """Demonstriert die strip()-Methoden von Strings."""
    s = " \t\n \rUmgeben von Whitespaces \t\t\r"
    result = f"Original: '{s}'"
    result += f"\ns.strip(): '{s.strip()}'"
    result += f"\ns.lstrip(): '{s.lstrip()}'"
    result += f"\ns.rstrip(): '{s.rstrip()}'"
    
    # Entfernen bestimmter Zeichen
    ziffern = "0123456789"
    s2 = "3674784673546Versteckt zwischen Zahlen3425923935"
    result += f"\n\nOriginal: {s2}\ns2.strip(ziffern): '{s2.strip(ziffern)}'"
    
    # removeprefix und removesuffix (ab Python 3.9)
    s3 = "PRÄFIX: Dies ist meine Botschaft (SUFFIX)"
    result += f"\n\nOriginal: {s3}\ns3.removeprefix(\"PRÄFIX: \"): '{s3.removeprefix('PRÄFIX: ')}'"
    result += f"\ns3.removesuffix(\" (SUFFIX)\"): '{s3.removesuffix(' (SUFFIX)')}'"
    result += f"\ns3.removesuffix(\"KOMMTNICHTVOR\"): '{s3.removesuffix('KOMMTNICHTVOR')}'"
    
    return result
```

```python
# Demonstration: strip()-Methoden von Strings
demonstrate_string_strip_methods()
```

#### Ausrichten von Strings

```python
def demonstrate_string_alignment_methods():
    """Demonstriert die Ausrichtungsmethoden von Strings."""
    s = "Richte mich aus"
    result = f"Original: '{s}'"
    result += f"\ns.center(50): '{s.center(50)}'"
    result += f"\ns.ljust(50): '{s.ljust(50)}'"
    result += f"\ns.rjust(50, \"-\"): '{s.rjust(50, '-')}'"
    
    # zfill für numerische Strings
    result += f"\n\n\"13.37\".zfill(20): '{'13.37'.zfill(20)}'"
    
    return result
```

```python
# Demonstration: Ausrichtungsmethoden von Strings
demonstrate_string_alignment_methods()
```

#### String-Tests

```python
def demonstrate_string_test_methods():
    """Demonstriert die Test-Methoden von Strings."""
    s = "1234abcd"
    result = f"s.isdigit(): {s.isdigit()}"
    result += f"\ns.isalpha(): {s.isalpha()}"
    result += f"\ns.isalnum(): {s.isalnum()}"
    
    # startswith und endswith
    s2 = "www.rheinwerk-verlag.de"
    result += f"\n\ns2.startswith(\"www.\"): {s2.startswith('www.')}"
    result += f"\ns2.endswith(\".de\"): {s2.endswith('.de')}"
    result += f"\ns2.startswith(\"rheinwerk\", 4): {s2.startswith('rheinwerk', 4)}"
    
    return result
```

```python
# Demonstration: Test-Methoden von Strings
demonstrate_string_test_methods()
```

#### Verkettung von Elementen

```python
def demonstrate_string_join():
    """Demonstriert die join()-Methode von Strings."""
    kontaktliste = ["Fix", "Foxy", "Lupo", "Dr. Knox"]
    result = f"\", \".join({kontaktliste}): '{', '.join(kontaktliste)}'"
    
    # join mit einem String
    satz = "Stoiber-Satz"
    result += f"\n\n\"...ehm...\".join(\"{satz}\"): '{'...ehm...'.join(satz)}'"
    
    # join mit leerem String
    result += f"\n\n\"\".join([\"www\", \".\", \"rheinwerk-verlag\", \".\", \"de\"]): '{''.join(['www', '.', 'rheinwerk-verlag', '.', 'de'])}'"
    
    return result
```

```python
# Demonstration: join()-Methode von Strings
demonstrate_string_join()
```

### Formatierung von Strings

```python
def demonstrate_string_format_basic():
    """Demonstriert die grundlegende String-Formatierung mit format()."""
    # Nummerierte Platzhalter
    result = f"\"Es ist {0}:{1} Uhr\".format(13, 37): '{\"Es ist {0}:{1} Uhr\".format(13, 37)}'"
    
    # Implizite Nummerierung
    result += f"\n\n\"Es ist {}:{} Uhr\".format(13, 37): '{\"Es ist {}:{} Uhr\".format(13, 37)}'"
    
    # Benannte Platzhalter
    result += f"\n\n\"Es ist {stunde}:{minute} Uhr\".format(stunde=13, minute=37): '{\"Es ist {stunde}:{minute} Uhr\".format(stunde=13, minute=37)}'"
    
    # Gemischte Platzhalter
    result += f"\n\n\"Es ist {stunde}:{0} Uhr\".format(37, stunde=13): '{\"Es ist {stunde}:{0} Uhr\".format(37, stunde=13)}'"
    
    # Komplexes Beispiel
    result += f"\n\n\"{{h}}g Hefe, {{}}g Mehl, {{w}}ml Wasser, {{}}g Salz\".format(50, 400, h=5, w=100): '{\"{{h}}g Hefe, {{}}g Mehl, {{w}}ml Wasser, {{}}g Salz\".format(50, 400, h=5, w=100)}'"
    
    return result
```

```python
# Demonstration: Grundlegende String-Formatierung mit format()
demonstrate_string_format_basic()
```

```python
def demonstrate_f_strings():
    """Demonstriert f-Strings (Formatted String Literals)."""
    stunde = 13
    minute = 37
    
    # Verschiedene Formatierungsmöglichkeiten
    result = f"f\"Es ist {stunde}:{minute} Uhr\": '{f'Es ist {stunde}:{minute} Uhr'}'"
    
    # Mit Ausdrücken
    result += f"\n\nf\"Bald ist es {stunde + 1}:{minute + 1} Uhr\": '{f'Bald ist es {stunde + 1}:{minute + 1} Uhr'}'"
    result += f"\n\nf\"Es sind schon {60 * stunde + minute} Minuten des Tages vergangen\": '{f'Es sind schon {60 * stunde + minute} Minuten des Tages vergangen'}'"
    result += f"\n\nf\"Es ist fast {stunde if minute < 30 else stunde + 1}:00 Uhr\": '{f'Es ist fast {stunde if minute < 30 else stunde + 1}:00 Uhr'}'"
    result += f"\n\nf\"Es ist {bin(stunde)}:{bin(minute)} Uhr\": '{f'Es ist {bin(stunde)}:{bin(minute)} Uhr'}'"
    
    return result
```

```python
# Demonstration: f-Strings (Formatted String Literals)
demonstrate_f_strings()
```

```python
def demonstrate_format_attribute_access():
    """Demonstriert den Zugriff auf Attribute und Elemente bei der Formatierung."""
    c = 15 + 20j
    result = f"\"Realteil: {0.real}, Imaginaerteil: {0.imag}\".format(c): '{\"Realteil: {0.real}, Imaginaerteil: {0.imag}\".format(c)}'"
    
    # Zugriff auf Listenelemente
    l = ["Ich bin der Erste!", "Nein, ich bin der Erste!"]
    result += f"\n\n\"{{liste[1]}}. {{liste[0]}}\".format(liste=l): '{\"{{liste[1]}}. {{liste[0]}}\".format(liste=l)}'"
    
    # Zugriff bei impliziter Nummerierung
    result += f"\n\n\"Attribut: {{.imag}}, Listenelement: {{[1]}}\".format(1+4j, [1,2,3]): '{\"Attribut: {{.imag}}, Listenelement: {{[1]}}\".format(1+4j, [1,2,3])}'"
    
    return result
```

```python
# Demonstration: Zugriff auf Attribute und Elemente bei der Formatierung
demonstrate_format_attribute_access()
```

```python
def demonstrate_format_specification():
    """Demonstriert verschiedene Formatspezifikationen."""
    # Formatierung von Gleitkommazahlen
    result = f"\"Betrag: {{:.2f}} Euro\".format(13.37690): '{\"Betrag: {:.2f} Euro\".format(13.37690)}'"
    
    # Minimale Breite
    result += f"\n\n\"{{:15}}|{{:15}}\".format(\"Vorname\", \"Nachname\"): '{\"{{:15}}|{{:15}}\".format(\"Vorname\", \"Nachname\")}'"
    result += f"\n\"{{:15}}|{{:15}}\".format(\"Florian\", \"Kroll\"): '{\"{{:15}}|{{:15}}\".format(\"Florian\", \"Kroll\")}'"
    
    # Ausrichtung
    result += f"\n\n\"Endpreis: {{sum:>5}} Euro\".format(sum=443): '{\"Endpreis: {{sum:>5}} Euro\".format(sum=443)}'"
    
    # Füllzeichen
    result += f"\n\n\"{{text:-^25}}\".format(text=\"Hallo Welt\"): '{\"{{text:-^25}}\".format(text=\"Hallo Welt\")}'"
    
    # Behandlung von Vorzeichen
    result += f"\n\n\"Kosten: {{:+}}\".format(135): '{\"Kosten: {{:+}}\".format(135)}'"
    result += f"\n\"Kosten: {{:+}}\".format(-135): '{\"Kosten: {{:+}}\".format(-135)}'"
    
    # Zahlendarstellungstypen
    result += f"\n\n\"Lustige Bits: {{:b}}\".format(109): '{\"Lustige Bits: {{:b}}\".format(109)}'"
    result += f"\n\"{{:#b}} vs. {{:b}}\".format(109, 109): '{\"{{:#b}} vs. {{:b}}\".format(109, 109)}'"
    
    # Gleitkommazahlen-Formate
    result += f"\n\n\"{{zahl:e}}\".format(zahl=123.456): '{\"{{zahl:e}}\".format(zahl=123.456)}'"
    result += f"\n\"{{zahl:f}}\".format(zahl=123.456): '{\"{{zahl:f}}\".format(zahl=123.456)}'"
    result += f"\n\"{{zahl:%}}\".format(zahl=0.75): '{\"{{zahl:%}}\".format(zahl=0.75)}'"
    
    # Tausendertrennung
    result += f"\n\n\"Viel Geld: {{:,d}}\".format(12345678900): '{\"Viel Geld: {{:,d}}\".format(12345678900)}'"
    result += f"\n\"Viel Geld: {{:_d}}\".format(12345678900): '{\"Viel Geld: {{:_d}}\".format(12345678900)}'"
    
    return result
```

```python
# Demonstration: Verschiedene Formatspezifikationen
demonstrate_format_specification()
```

```python
def demonstrate_self_documenting_f_strings():
    """Demonstriert selbstdokumentierende Ausdrücke in f-Strings (ab Python 3.8)."""
    variable_1 = 12
    variable_2 = 17
    
    # Normaler f-String vs. selbstdokumentierender f-String
    result = f"Normal: f\"variable_1={{variable_1}}, variable_2={{variable_2}}\": '{f'variable_1={variable_1}, variable_2={variable_2}'}'"
    result += f"\n\nSelbstdokumentierend: f\"{{variable_1=}}, {{variable_2=}}\": '{f'{variable_1=}, {variable_2=}'}'"
    
    # Komplexere Ausdrücke
    import math
    result += f"\n\nKomplexer Ausdruck: f\"{{math.cos(math.pi)=}}\": '{f'{math.cos(math.pi)=}'}'"
    
    return result
```

```python
# Demonstration: Selbstdokumentierende Ausdrücke in f-Strings (ab Python 3.8)
demonstrate_self_documenting_f_strings()
```

### Zeichensätze und Sonderzeichen

```python
def demonstrate_encoding_basics():
    """Demonstriert die Grundlagen der Zeichencodierung."""
    # ASCII-Zeichen in str und bytes
    ascii_str = "Python"
    ascii_bytes = b"Python"
    
    result = f"ASCII als str: {ascii_str}, Typ: {type(ascii_str)}"
    result += f"\nASCII als bytes: {ascii_bytes}, Typ: {type(ascii_bytes)}"
    
    # Sonderzeichen in str, aber nicht in bytes-Literal
    special_str = "Püthøn"
    result += f"\n\nMit Sonderzeichen als str: {special_str}"
    result += f"\nDirekte Verwendung von Sonderzeichen in bytes-Literalen ist nicht möglich (SyntaxError)"
    
    # Fehler bei Verkettung verschiedener Typen
    result += f"\n\nFehler bei Verkettung: \"P\" + b\"ython\" würde TypeError verursachen"
    
    return result
```

```python
# Demonstration: Grundlagen der Zeichencodierung
demonstrate_encoding_basics()
```

```python
def demonstrate_encode_decode():
    """Demonstriert das Codieren und Decodieren von Strings."""
    str_string = "Püthøn"
    
    # Codieren mit verschiedenen Zeichensätzen
    bytes_iso = str_string.encode("iso-8859-15")
    bytes_utf8 = str_string.encode("utf-8")
    
    result = f"Original str: {str_string}"
    result += f"\nCodeiert (iso-8859-15): {bytes_iso}"
    result += f"\nCodeiert (utf-8): {bytes_utf8}"
    
    # Decodieren
    str_iso = bytes_iso.decode("iso-8859-15")
    str_utf8 = bytes_utf8.decode("utf-8")
    
    result += f"\n\nDecodiert (iso-8859-15): {str_iso}"
    result += f"\nDecodiert (utf-8): {str_utf8}"
    
    return result
```

```python
# Demonstration: Codieren und Decodieren von Strings
demonstrate_encode_decode()
```

```python
def demonstrate_error_handling_encode_decode():
    """Demonstriert die Fehlerbehandlung beim Codieren/Decodieren."""
    str_string = "Püthøn"
    bytes_utf8 = str_string.encode("utf-8")
    
    # Falscher Zeichensatz beim Decodieren
    try:
        bytes_utf8.decode("ascii")
    except UnicodeDecodeError:
        decode_error = "UnicodeDecodeError: 'ascii' codec can't decode byte..."
    
    # Fehlerbehandlung mit errors-Parameter
    result = f"Original bytes (utf-8): {bytes_utf8}"
    result += f"\n\nFehler bei falscher Decodierung: {decode_error}"
    result += f"\n\nMit errors='ignore': {bytes_utf8.decode('ascii', 'ignore')}"
    result += f"\nMit errors='replace': {bytes_utf8.decode('ascii', 'replace')}"
    result += f"\nMit errors='backslashreplace': {bytes_utf8.decode('ascii', 'backslashreplace')}"
    
    return result
```

```python
# Demonstration: Fehlerbehandlung beim Codieren/Decodieren
demonstrate_error_handling_encode_decode()
```

```python
def demonstrate_unicode_escape_sequences():
    """Demonstriert Unicode-Escape-Sequenzen in Strings."""
    # Euro-Symbol mit Unicode-Codepoint
    euro_with_u = "\u20ac"
    
    # Euro-Symbol mit Unicode-Namen
    euro_with_name = "\N{euro sign}"
    
    # Konvertierung zwischen Zeichen und Codepoints
    euro_code = ord("€")
    euro_char = chr(8364)
    
    result = f"Euro mit \\u: {euro_with_u}"
    result += f"\nEuro mit \\N: {euro_with_name}"
    result += f"\nCodepoint von €: {euro_code}"
    result += f"\nZeichen für Codepoint 8364: {euro_char}"
    
    # Emoji-Beispiel
    snake = "\N{Snake}"
    result += f"\n\nPython-Emoji: {snake}"
    
    return result
```

```python
# Demonstration: Unicode-Escape-Sequenzen in Strings
demonstrate_unicode_escape_sequences()
```