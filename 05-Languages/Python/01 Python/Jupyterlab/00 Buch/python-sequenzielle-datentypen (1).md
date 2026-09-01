```python
def demonstrate_bytearray_modification():
    """Demonstriert die Veränderbarkeit von bytearray-Objekten."""
    b = bytearray(b"Hallo Welt")
    b[:5] = b"Bye"
    b.append(ord(b"!"))
    b.extend(b"!!!")
    return b
```

```python
# Demonstration: Veränderbarkeit von bytearray-Objekten
demonstrate_bytearray_modification()
```

### Steuerzeichen

```python
def demonstrate_escape_sequences():
    """Demonstriert die Verwendung von Escape-Sequenzen in Strings."""
    a = "Erste Zeile\nZweite Zeile"
    return a
```

```python
# Demonstration: Verwendung von Escape-Sequenzen in Strings
demonstrate_escape_sequences()
```

```python
def demonstrate_quotation_escaping():
    """Demonstriert das Escapen von Anführungszeichen."""
    a = "Das folgende Hochkomma muss nicht codiert werden ' "
    b = "Dieses doppelte Hochkomma schon \" "
    c = 'Das gilt auch in Strings mit einfachen Hochkommata " '
    d = 'Hier muss eine Escape-Sequenz benutzt werden \' '
    return (a, b, c, d)
```

```python
# Demonstration: Escapen von Anführungszeichen
demonstrate_quotation_escaping()
```

```python
def demonstrate_raw_strings():
    """Demonstriert die Verwendung von Raw-Strings."""
    normal = "Ein \tString mit \\ vielen \nEscape-Sequenzen\t"
    raw = r"Ein \tString mit \\ vielen \nEscape-Sequenzen\t"
    return (normal, raw)
```

```python
# Demonstration: Verwendung von Raw-Strings
demonstrate_raw_strings()
```

### String-Methoden

#### Trennen von Strings

```python
def demonstrate_split():
    """Demonstriert die split()-Methode für Strings."""
    s = "1-2-3-4-5-6-7-8-9-10"
    return (s.split("-"), s.split("-", 5), s.rsplit("-", 5))
```

```python
# Demonstration: split()-Methode für Strings
demonstrate_split()
```

```python
def demonstrate_split_with_multiple_separators():
    """Demonstriert split() mit mehreren aufeinanderfolgenden Trennzeichen."""
    s = "1---2-3"
    return s.split("-")
```

```python
# Demonstration: split() mit mehreren aufeinanderfolgenden Trennzeichen
demonstrate_split_with_multiple_separators()
```

```python
def demonstrate_split_whitespace():
    """Demonstriert split() ohne Parameter (Whitespace-Trennung)."""
    s = " Irgendein \t\t Satz mit \n\r\t Whitespaces"
    return s.split()
```

```python
# Demonstration: split() ohne Parameter (Whitespace-Trennung)
demonstrate_split_whitespace()
```

```python
def demonstrate_splitlines():
    """Demonstriert die splitlines()-Methode für Strings."""
    s = "Unix\nWindows\r\nMac\rLetzte Zeile"
    return s.splitlines()
```

```python
# Demonstration: splitlines()-Methode für Strings
demonstrate_splitlines()
```

```python
def demonstrate_partition():
    """Demonstriert die partition()-Methode für Strings."""
    s = "www.rheinwerk-verlag.de"
    return (s.partition("."), s.rpartition("."))
```

```python
# Demonstration: partition()-Methode für Strings
demonstrate_partition()
```

#### Suchen in Strings

```python
def demonstrate_find_and_rfind():
    """Demonstriert die find()- und rfind()-Methoden für Strings."""
    s = "Mal sehen, wo das 'e' in diesem String vorkommt"
    return (s.find("e"), s.rfind("e"))
```

```python
# Demonstration: find()- und rfind()-Methoden für Strings
demonstrate_find_and_rfind()
```

```python
def demonstrate_index_and_rindex():
    """Demonstriert die index()- und rindex()-Methoden für Strings."""
    s = "Dieser String wird gleich durchsucht"
    
    try:
        pos = s.index("wird")
        error = s.index("nicht vorhanden")
        return (pos, error)
    except ValueError as e:
        return (pos, f"Fehler: {e}")
```

```python
# Demonstration: index()- und rindex()-Methoden für Strings
demonstrate_index_and_rindex()
```

```python
def demonstrate_string_count():
    """Demonstriert die count()-Methode für Strings."""
    return "Fischers Fritze fischt frische Fische".count("sch")
```

```python
# Demonstration: count()-Methode für Strings
demonstrate_string_count()
```

#### Ersetzen in Strings

```python
def demonstrate_replace():
    """Demonstriert die replace()-Methode für Strings."""
    falsch = "Python ist nicht toll!"
    richtig = falsch.replace("nicht", "richtig")
    return (falsch, richtig)
```

```python
# Demonstration: replace()-Methode für Strings
demonstrate_replace()
```

```python
def demonstrate_replace_with_count():
    """Demonstriert replace() mit Begrenzung der Ersetzungen."""
    s = "Bitte nur die ersten vier e ersetzen"
    return s.replace("e", "E", 4)
```

```python
# Demonstration: replace() mit Begrenzung der Ersetzungen
demonstrate_replace_with_count()
```

```python
def demonstrate_replace_empty_string():
    """Demonstriert replace() mit leerem Suchstring."""
    s = "abcdefg"
    return s.replace("", "--")
```

```python
# Demonstration: replace() mit leerem Suchstring
demonstrate_replace_empty_string()
```

```python
def demonstrate_lower():
    """Demonstriert die lower()-Methode für Strings."""
    s = "ERST GANZ GROSS UND DANN GANZ KLEIN!"
    return s.lower()
```

```python
# Demonstration: lower()-Methode für Strings
demonstrate_lower()
```

```python
def demonstrate_swapcase():
    """Demonstriert die swapcase()-Methode für Strings."""
    s = "wENN MAN IM dEUTSCHEN ALLE wORTE SO SCHRIEBE ..."
    return s.swapcase()
```

```python
# Demonstration: swapcase()-Methode für Strings
demonstrate_swapcase()
```

```python
def demonstrate_capitalize():
    """Demonstriert die capitalize()-Methode für Strings."""
    s = "alles klein ... noch ;)"
    return s.capitalize()
```

```python
# Demonstration: capitalize()-Methode für Strings
demonstrate_capitalize()
```

```python
def demonstrate_title():
    """Demonstriert die title()-Methode für Strings."""
    s = "nOch BIn iCH eheR weNiGEr alS TITeL gEeiGNEt"
    return s.title()
```

```python
# Demonstration: title()-Methode für Strings
demonstrate_title()
```

```python
def demonstrate_expandtabs():
    """Demonstriert die expandtabs()-Methode für Strings."""
    s = ("\tHier kann Quellcode stehen\n" +
         "\t\tEine Ebene weiter unten")
    return s.expandtabs(4)
```

```python
# Demonstration: expandtabs()-Methode für Strings
demonstrate_expandtabs()
```

#### Entfernen von Zeichen am Anfang oder Ende von Strings

```python
def demonstrate_strip():
    """Demonstriert die strip()-Methode für Strings."""
    s = " \t\n \rUmgeben von Whitespaces \t\t\r"
    return (s.strip(), s.lstrip(), s.rstrip())
```

```python
# Demonstration: strip()-Methode für Strings
demonstrate_strip()
```

```python
def demonstrate_strip_with_chars():
    """Demonstriert strip() mit spezifischen zu entfernenden Zeichen."""
    ziffern = "0123456789"
    s = "3674784673546Versteckt zwischen Zahlen3425923935"
    return s.strip(ziffern)
```

```python
# Demonstration: strip() mit spezifischen zu entfernenden Zeichen
demonstrate_strip_with_chars()
```

```python
def demonstrate_removeprefix_removesuffix():
    """Demonstriert die removeprefix()- und removesuffix()-Methoden für Strings."""
    s = "PRÄFIX: Dies ist meine Botschaft (SUFFIX)"
    return (s.removeprefix("PRÄFIX: "), 
            s.removesuffix(" (SUFFIX)"), 
            s.removesuffix("KOMMTNICHTVOR"))
```

```python
# Demonstration: removeprefix()- und removesuffix()-Methoden für Strings
demonstrate_removeprefix_removesuffix()
```

#### Ausrichten von Strings

```python
def demonstrate_center_ljust_rjust():
    """Demonstriert center(), ljust() und rjust() für Strings."""
    s = "Richte mich aus"
    return (s.center(50), s.ljust(50), s.rjust(50, "-"))
```

```python
# Demonstration: center(), ljust() und rjust() für Strings
demonstrate_center_ljust_rjust()
```

```python
def demonstrate_zfill():
    """Demonstriert die zfill()-Methode für Strings."""
    return "13.37".zfill(20)
```

```python
# Demonstration: zfill()-Methode für Strings
demonstrate_zfill()
```

#### String-Tests

```python
def demonstrate_string_tests():
    """Demonstriert verschiedene String-Test-Methoden."""
    s = "1234abcd"
    return (s.isdigit(), s.isalpha(), s.isalnum())
```

```python
# Demonstration: Verschiedene String-Test-Methoden
demonstrate_string_tests()
```

```python
def demonstrate_startswith_endswith():
    """Demonstriert die startswith()- und endswith()-Methoden für Strings."""
    s = "www.rheinwerk-verlag.de"
    return (s.startswith("www."), s.endswith(".de"), s.startswith("rheinwerk", 4))
```

```python
# Demonstration: startswith()- und endswith()-Methoden für Strings
demonstrate_startswith_endswith()
```

#### Verkettung mit join()

```python
def demonstrate_join():
    """Demonstriert die join()-Methode für Strings."""
    kontaktliste = ["Fix", "Foxy", "Lupo", "Dr. Knox"]
    return ", ".join(kontaktliste)
```

```python
# Demonstration: join()-Methode für Strings
demonstrate_join()
```

```python
def demonstrate_join_characters():
    """Demonstriert join() mit einzelnen Zeichen."""
    satz = "Stoiber-Satz"
    return "...ehm...".join(satz)
```

```python
# Demonstration: join() mit einzelnen Zeichen
demonstrate_join_characters()
```

```python
def demonstrate_empty_join():
    """Demonstriert join() mit leerem Trennzeichen."""
    return "".join(["www", ".", "rheinwerk-verlag", ".", "de"])
```

```python
# Demonstration: join() mit leerem Trennzeichen
demonstrate_empty_join()
```

### String-Formatierung

```python
def demonstrate_format_numbered_placeholders():
    """Demonstriert die format()-Methode mit nummerierten Platzhaltern."""
    return "Es ist {0}:{1} Uhr".format(13, 37)
```

```python
# Demonstration: format() mit nummerierten Platzhaltern
demonstrate_format_numbered_placeholders()
```

```python
def demonstrate_format_implicit_placeholders():
    """Demonstriert die format()-Methode mit impliziten Platzhaltern."""
    return "Es ist {}:{} Uhr".format(13, 37)
```

```python
# Demonstration: format() mit impliziten Platzhaltern
demonstrate_format_implicit_placeholders()
```

```python
def demonstrate_format_named_placeholders():
    """Demonstriert die format()-Methode mit benannten Platzhaltern."""
    return "Es ist {stunde}:{minute} Uhr".format(stunde=13, minute=37)
```

```python
# Demonstration: format() mit benannten Platzhaltern
demonstrate_format_named_placeholders()
```

```python
def demonstrate_format_mixed_placeholders():
    """Demonstriert die format()-Methode mit gemischten Platzhaltern."""
    return "Es ist {stunde}:{0} Uhr".format(37, stunde=13)
```

```python
# Demonstration: format() mit gemischten Platzhaltern
demonstrate_format_mixed_placeholders()
```

```python
def demonstrate_format_mixed_with_implicit():
    """Demonstriert die format()-Methode mit gemischten und impliziten Platzhaltern."""
    return "{h}g Hefe, {}g Mehl, {w}ml Wasser, {}g Salz".format(
        50, 400, h=5, w=100)
```

```python
# Demonstration: format() mit gemischten und impliziten Platzhaltern
demonstrate_format_mixed_with_implicit()
```

```python
def demonstrate_format_different_types():
    """Demonstriert die format()-Methode mit verschiedenen Datentypen."""
    return "Liste: {0}, String: {string}, Komplexe Zahl: {1}".format(
        [1, 2], 13 + 37j, string="Hallo Welt")
```

```python
# Demonstration: format() mit verschiedenen Datentypen
demonstrate_format_different_types()
```

```python
def demonstrate_format_same_value_multiple_times():
    """Demonstriert die Verwendung desselben Wertes mehrfach in format()."""
    return "{h}{em} Hefe, {}{em} Mehl, {w}{ev} Wasser, {}{em} Salz".format(
        50, 400, h=5, w=100, em='g', ev='ml')
```

```python
# Demonstration: Verwendung desselben Wertes mehrfach in format()
demonstrate_format_same_value_multiple_times()
```

```python
def demonstrate_format_escape_braces():
    """Demonstriert das Escapen von geschweiften Klammern in format()."""
    return "Unformatiert: {{KeinPlatzhalter}}. Formatiert: {v}.".format(
        v="nur ein Test")
```

```python
# Demonstration: Escapen von geschweiften Klammern in format()
demonstrate_format_escape_braces()
```

#### f-Strings

```python
def demonstrate_f_strings():
    """Demonstriert die Verwendung von f-Strings."""
    stunde = 13
    minute = 37
    return f"Es ist {stunde}:{minute} Uhr"
```

```python
# Demonstration: Verwendung von f-Strings
demonstrate_f_strings()
```

```python
def demonstrate_f_strings_with_expressions():
    """Demonstriert f-Strings mit Ausdrücken."""
    stunde = 13
    minute = 37
    return (
        f"Bald ist es {stunde + 1}:{minute + 1} Uhr",
        f"Es sind schon {60 * stunde + minute} Minuten des Tages vergangen",
        f"Es ist fast {stunde if minute < 30 else stunde + 1}:00 Uhr",
        f"Es ist {bin(stunde)}:{bin(minute)} Uhr"
    )
```

```python
# Demonstration: f-Strings mit Ausdrücken
demonstrate_f_strings_with_expressions()
```

#### Formatierung der Ausgabe

```python
def demonstrate_attribute_access_in_format():
    """Demonstriert den Zugriff auf Attribute in format()."""
    c = 15 + 20j
    return "Realteil: {0.real}, Imaginaerteil: {0.imag}".format(c)
```

```python
# Demonstration: Zugriff auf Attribute in format()
demonstrate_attribute_access_in_format()
```

```python
def demonstrate_item_access_in_format():
    """Demonstriert den Zugriff auf Elemente in format()."""
    l = ["Ich bin der Erste!", "Nein, ich bin der Erste!"]
    return "{liste[1]}. {liste[0]}".format(liste=l)
```

```python
# Demonstration: Zugriff auf Elemente in format()
demonstrate_item_access_in_format()
```

```python
def demonstrate_formatting_specifiers():
    """Demonstriert Formatierungsangaben in format()."""
    return "Betrag: {:.2f} Euro".format(13.37690)
```

```python
# Demonstration: Formatierungsangaben in format()
demonstrate_formatting_specifiers()
```

```python
def demonstrate_width_formatting():
    """Demonstriert die Breitenanpassung in format()."""
    f = "{:15}|{:15}"
    result = (
        f.format("Vorname", "Nachname") + "\n" +
        f.format("Florian", "Kroll") + "\n" +
        f.format("Lina", "Ostermann") + "\n" +
        f.format("Sven", "Bisdorff") + "\n" +
        f.format("Kaddah", "Hotzenplotz")
    )
    return result
```

```python
# Demonstration: Breitenanpassung in format()
demonstrate_width_formatting()
```

```python
def demonstrate_exceeding_width():
    """Demonstriert, dass die Breite bei Bedarf überschritten wird."""
    return "{lang:2}".format(lang="Ich bin laenger als zwei Zeichen!")
```

```python
# Demonstration: Überschreitung der angegebenen Breite bei Bedarf
demonstrate_exceeding_width()
```

```python
def demonstrate_alignment():
    """Demonstriert die Ausrichtung in format()."""
    return "Endpreis: {sum:>5} Euro".format(sum=443)
```

```python
# Demonstration: Ausrichtung in format()
demonstrate_alignment()
```

```python
def demonstrate_sign_alignment():
    """Demonstriert die =-Ausrichtung für Vorzeichen."""
    return (
        "Temperatur: {:10}".format(-12.5),
        "Temperatur: {:=10}".format(-12.5)
    )
```

```python
# Demonstration: =-Ausrichtung für Vorzeichen
demonstrate_sign_alignment()
```

```python
def demonstrate_fill_character():
    """Demonstriert das Füllzeichen in format()."""
    return "{text:-^25}".format(text="Hallo Welt")
```

```python
# Demonstration: Füllzeichen in format()
demonstrate_fill_character()
```

```python
def demonstrate_sign_handling():
    """Demonstriert die Behandlung von Vorzeichen in format()."""
    return (
        "Kosten: {:+}".format(135),
        "Kosten: {:+}".format(-135),
        "Kosten: {:-}".format(135),
        "Kosten: {: }".format(135),
        "Kosten: {: }".format(-135)
    )
```

```python
# Demonstration: Behandlung von Vorzeichen in format()
demonstrate_sign_handling()
```

```python
def demonstrate_sign_with_alignment():
    """Demonstriert die Kombination von Vorzeichen und Ausrichtung in format()."""
    return "Kosten: {:=+10}".format(-135)
```

```python
# Demonstration: Kombination von Vorzeichen und Ausrichtung in format()
demonstrate_sign_with_alignment()
```

```python
def demonstrate_number_type_formatting():
    """Demonstriert die Typformatierung für Zahlen in format()."""
    return "Lustige Bits: {:b}".format(109)
```

```python
# Demonstration: Typformatierung für Zahlen in format()
demonstrate_number_type_formatting()
```

```python
def demonstrate_alternate_form():
    """Demonstriert die alternative Form in format()."""
    return (
        "{:#b} vs. {:b}".format(109, 109),
        "{:#o} vs. {:o}".format(109, 109),
        "{:#x} vs. {:x}".format(109, 109)
    )
```

```python
# Demonstration: Alternative Form in format()
demonstrate_alternate_form()
```

```python
def demonstrate_float_formatting():
    """Demonstriert die Formatierung von Gleitkommazahlen in format()."""
    return (
        "{zahl:e}".format(zahl=123.456),
        "{zahl:f}".format(zahl=123.456),
        "{zahl:n}".format(zahl=123.456),
        "{zahl:%}".format(zahl=0.75)
    )
```

```python
# Demonstration: Formatierung von Gleitkommazahlen in format()
demonstrate_float_formatting()
```

```python
def demonstrate_precision():
    """Demonstriert die Genauigkeit bei Gleitkommazahlen in format()."""
    return "Betrag: {:.2f} Euro".format(13.37690)
```

```python
# Demonstration: Genauigkeit bei Gleitkommazahlen in format()
demonstrate_precision()
```

```python
def demonstrate_zero_padding():
    """Demonstriert das Auffüllen mit Nullen in format()."""
    return "Es gilt {z1:05} = {z2:0=5}.".format(z1=23, z2=23)
```

```python
# Demonstration: Auffüllen mit Nullen in format()
demonstrate_zero_padding()
```

```python
def demonstrate_thousand_separator():
    """Demonstriert die Tausendertrennung in format()."""
    return (
        "Viel Geld: {:,d}".format(12345678900),
        "Viel Geld: {:_d}".format(12345678900)
    )
```

```python
# Demonstration: Tausendertrennung in format()
demonstrate_thousand_separator()
```

```python
def demonstrate_self_documenting_expressions():
    """Demonstriert selbstdokumentierende Ausdrücke in f-Strings."""
    variable_1 = 12
    variable_2 = 17
    return f"{variable_1=}, {variable_2=}"
```

```python
# Demonstration: Selbstdokumentierende Ausdrücke in f-Strings
demonstrate_self_documenting_expressions()
```

```python
def demonstrate_complex_self_documenting():
    """Demonstriert komplexe selbstdokumentierende Ausdrücke in f-Strings."""
    import math
    return f"{math.cos(math.pi)=}"
```

```python
# Demonstration: Komplexe selbstdokumentierende Ausdrücke in f-Strings
demonstrate_complex_self_documenting()
```

### Zeichensätze und Sonderzeichen

```python
def demonstrate_bytes_vs_str():
    """Demonstriert den Unterschied zwischen bytes und str bei Sonderzeichen."""
    return (
        "Püthøn",  # funktioniert
        "SyntaxError: bytes can only contain ASCII literal characters"  # statt b"Püthøn"
    )
```

```python
# Demonstration: Unterschied zwischen bytes und str bei Sonderzeichen
demonstrate_bytes_vs_str()
```

```python
def demonstrate_str_bytes_concatenation_error():
    """Demonstriert den Fehler bei der Verkettung von str und bytes."""
    return "TypeError: can only concatenate str (not \"bytes\") to str"  # statt "P" + b"ython"
```

```python
# Demonstration: Fehler bei der Verkettung von str und bytes
demonstrate_str_bytes_concatenation_error()
```

```python
def demonstrate_encoding_decoding():
    """Demonstriert die Codierung und Decodierung von Strings."""
    str_string = "Püthøn"
    bytes_string = str_string.encode("iso-8859-15")
    decoded = bytes_string.decode("iso-8859-15")
    return (str_string, bytes_string, decoded)
```

```python
# Demonstration: Codierung und Decodierung von Strings
demonstrate_encoding_decoding()
```

```python
def demonstrate_unicode_escapes():
    """Demonstriert Unicode-Escape-Sequenzen in Strings."""
    s = "\u20ac"  # Euro-Symbol
    return s
```

```python
# Demonstration: Unicode-Escape-Sequenzen in Strings
demonstrate_unicode_escapes()
```

```python
def demonstrate_unicode_names():
    """Demonstriert Unicode-Namen in Strings."""
    return "\N{euro sign}"
```

```python
# Demonstration: Unicode-Namen in Strings
demonstrate_unicode_names()
```

```python
def demonstrate_chr_ord():
    """Demonstriert die Funktionen chr() und ord()."""
    return (chr(8364), ord("€"))
```

```python
# Demonstration: Funktionen chr() und ord()
demonstrate_chr_ord()
```

```python
def demonstrate_utf8_encoding():
    """Demonstriert die Codierung und Decodierung mit UTF-8."""
    str_string = "Püthøn"
    bytes_string = str_string.encode("utf-8")
    decoded = bytes_string.decode("utf-8")
    return (str_string, bytes_string, decoded)
```

```python
# Demonstration: Codierung und Decodierung mit UTF-8
demonstrate_utf8_encoding()
```

```python
def demonstrate_wrong_decoding():
    """Demonstriert die Decodierung mit falschem Zeichensatz."""
    bytes_string = "Püthøn".encode("utf-8")
    
    try:
        wrong_decode1 = bytes_string.decode("iso-8859-15")
        wrong_decode2 = bytes_string.decode("ascii")
        return (wrong_decode1, wrong_decode2)
    except UnicodeDecodeError as e:
        return (wrong_decode1, f"Fehler: {e}")
```

```python
# Demonstration: Decodierung mit falschem Zeichensatz
demonstrate_wrong_decoding()
```

```python
def demonstrate_error_handling():
    """Demonstriert die Fehlerbehandlung bei der Decodierung."""
    bytes_string = "Püthøn".encode("utf-8")
    return (
        bytes_string.decode("ascii", "ignore"),
        bytes_string.decode("ascii", "replace"),
        bytes_string.decode("ascii", "backslashreplace")
    )
```

```python
# Demonstration: Fehlerbehandlung bei der Decodierung
demonstrate_error_handling()
```