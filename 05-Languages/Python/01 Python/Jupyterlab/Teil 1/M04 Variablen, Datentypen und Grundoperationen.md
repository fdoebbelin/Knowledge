---
jupyter:
  jupytext:
    cell_metadata_filter: -all
    formats: ipynb,md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.19.1
  kernelspec:
    display_name: Python 3
    language: python
    name: python3
---

## Variablen und Zuweisungen

- Variablen sind Speicherplätze für Daten im Arbeitsspeicher
- Zuweisung erfolgt mit dem Gleichheitszeichen `=`
- Python ist dynamisch typisiert: Der Datentyp wird automatisch erkannt
- Variablen können jederzeit neue Werte und andere Datentypen zugewiesen bekommen

```python
# Einfache Variablenzuweisung
def zeige_variable(wert):
    """Zeigt den übergebenen Wert an."""
    return wert

# Beispiel mit einem Integer
mein_alter = 25
zeige_variable(mein_alter)
```

```python
# Beispiel mit einem String
mein_name = "Max Mustermann"
zeige_variable(mein_name)
```

```python
# Beispiel mit einem Boolean
ist_student = True
zeige_variable(ist_student)
```

```python
# Beispiel mit einem Float
mein_gewicht = 70.5
zeige_variable(mein_gewicht)
```

```python
# Variablen können jederzeit neue Werte erhalten
def zeige_geaenderte_variable(wert, neuer_wert):
    """Zeigt den ursprünglichen und geänderten Wert an."""
    return {"ursprünglicher_wert": wert, "neuer_wert": neuer_wert}

mein_alter = 25
neues_alter = 26
zeige_geaenderte_variable(mein_alter, neues_alter)
```

```python
# Eine Variable kann auch einen anderen Datentyp annehmen
def zeige_typwechsel(zahl_wert, text_wert):
    """Demonstriert den Wechsel des Datentyps einer Variable."""
    return {"ursprünglich_typ": type(zahl_wert).__name__, 
            "neuer_typ": type(text_wert).__name__}

alter_als_zahl = 26
alter_als_text = "sechsundzwanzig"
zeige_typwechsel(alter_als_zahl, alter_als_text)
```

```python
# Mehrfachzuweisung
def zeige_mehrfachzuweisung(x, y, z):
    """Zeigt mehrere zugewiesene Werte an."""
    return {"x": x, "y": y, "z": z}

x, y, z = 10, 20, 30
zeige_mehrfachzuweisung(x, y, z)
```

```python
# Gleicher Wert für mehrere Variablen
def zeige_gleiche_zuweisung(a, b, c):
    """Zeigt identisch zugewiesene Werte an."""
    return {"a": a, "b": b, "c": c, "sind_gleich": a == b == c}

a = b = c = 100
zeige_gleiche_zuweisung(a, b, c)
```

## Grundlegende Datentypen

### Integer (int)
- Ganze Zahlen ohne Nachkommastellen
- Beliebig große Zahlen möglich (keine Begrenzung durch Bitbreite)

```python
# Grundlegender Integer
def zeige_ganzzahl(zahl):
    """Zeigt eine Ganzzahl und ihren Typ an."""
    return {"wert": zahl, "typ": type(zahl).__name__}

ganzzahl = 42
zeige_ganzzahl(ganzzahl)
```

```python
# Negative Ganzzahl
negative_zahl = -17
zeige_ganzzahl(negative_zahl)
```

```python
# Großer Integer-Wert
def zeige_grosse_zahl(zahl):
    """Zeigt eine sehr große Zahl an."""
    return {"wert": zahl, "anzahl_stellen": len(str(zahl))}

sehr_gross = 10**20  # 10 hoch 20
zeige_grosse_zahl(sehr_gross)
```

```python
# Binäre Darstellung
def zeige_binaer(binaer_zahl):
    """Zeigt eine binäre Zahl und ihren Dezimalwert an."""
    return {"binärwert": bin(binaer_zahl), "dezimalwert": binaer_zahl}

binaer = 0b1010  # Binär (entspricht 10 dezimal)
zeige_binaer(binaer)
```

```python
# Oktale Darstellung
def zeige_oktal(oktal_zahl):
    """Zeigt eine oktale Zahl und ihren Dezimalwert an."""
    return {"oktalwert": oct(oktal_zahl), "dezimalwert": oktal_zahl}

oktal = 0o74  # Oktal (entspricht 60 dezimal)
zeige_oktal(oktal)
```

```python
# Hexadezimale Darstellung
def zeige_hexadezimal(hex_zahl):
    """Zeigt eine hexadezimale Zahl und ihren Dezimalwert an."""
    return {"hexwert": hex(hex_zahl), "dezimalwert": hex_zahl}

hexadezimal = 0xFF  # Hexadezimal (entspricht 255 dezimal)
zeige_hexadezimal(hexadezimal)
```

### Float
- Gleitkommazahlen mit Nachkommastellen
- Begrenzte Genauigkeit (ca. 15-17 signifikante Dezimalstellen)

```python
# Grundlegender Float
def zeige_kommazahl(zahl):
    """Zeigt eine Kommazahl und ihren Typ an."""
    return {"wert": zahl, "typ": type(zahl).__name__}

kommazahl = 3.14
zeige_kommazahl(kommazahl)
```

```python
# Negative Kommazahl
negative_kommazahl = -2.718
zeige_kommazahl(negative_kommazahl)
```

```python
# Wissenschaftliche Notation
def zeige_wissenschaftliche_notation(zahl):
    """Zeigt eine Zahl in wissenschaftlicher Notation an."""
    return {"standardform": zahl, "wissenschaftliche_notation": f"{zahl:.4e}"}

wissenschaftlich = 6.022e23  # 6.022 * 10^23
zeige_wissenschaftliche_notation(wissenschaftlich)
```

```python
# Spezielle Float-Werte: Unendlich
def zeige_unendlich(wert):
    """Zeigt den Wert für Unendlich an."""
    return {"wert": str(wert), "ist_unendlich": wert == float('inf')}

unendlich = float('inf')
zeige_unendlich(unendlich)
```

```python
# Nicht-Zahl (NaN)
def zeige_nan(wert):
    """Zeigt den Wert für 'Nicht eine Zahl' (NaN) an."""
    import math
    return {"wert": str(wert), "ist_nan": math.isnan(wert)}

nicht_zahl = float('nan')
zeige_nan(nicht_zahl)
```

```python
# Genauigkeitsprobleme bei Floats
def zeige_float_genauigkeit(ergebnis):
    """Zeigt Genauigkeitsprobleme bei Floats."""
    return {"berechnung": "0.1 + 0.2", 
            "ergebnis": ergebnis, 
            "erwartet": 0.3, 
            "ist_gleich_0.3": ergebnis == 0.3}

genauigkeit = 0.1 + 0.2  # Ergibt nicht exakt 0.3
zeige_float_genauigkeit(genauigkeit)
```

### String (str)
- Textdaten, Zeichenketten
- In einfachen (`'`) oder doppelten (`"`) Anführungszeichen
- Mehrzeilige Strings mit dreifachen Anführungszeichen (`'''` oder `"""`)

```python
# String mit einfachen Anführungszeichen
def zeige_string(text):
    """Zeigt einen String und seine Länge an."""
    return {"text": text, "länge": len(text)}

einfach = 'Text in einfachen Anführungszeichen'
zeige_string(einfach)
```

```python
# String mit doppelten Anführungszeichen
doppelt = "Text in doppelten Anführungszeichen"
zeige_string(doppelt)
```

```python
# String mit Escape-Sequenzen
def zeige_string_mit_escapes(text):
    """Zeigt einen String mit Escape-Sequenzen an."""
    return {"text": text, "länge": len(text)}

mit_anfuehrungszeichen = "Er sagte: \"Hallo Welt!\""
zeige_string_mit_escapes(mit_anfuehrungszeichen)
```

```python
# String mit Zeilenumbruch
mit_zeilenumbruch = "Erste Zeile\nZweite Zeile"
zeige_string_mit_escapes(mit_zeilenumbruch)
```

```python
# Mehrzeiliger String
def zeige_mehrzeiligen_string(text):
    """Zeigt einen mehrzeiligen String an."""
    zeilen = text.split('\n')
    return {"text": text, "anzahl_zeilen": len(zeilen)}

mehrzeilig = """Dies ist ein
mehrzeiliger String,
der über mehrere Zeilen geht."""
zeige_mehrzeiligen_string(mehrzeilig)
```

```python
# String-Verkettung
def zeige_string_verkettung(string1, string2):
    """Zeigt das Ergebnis einer String-Verkettung an."""
    ergebnis = string1 + string2
    return {"string1": string1, "string2": string2, "verkettet": ergebnis}

string1 = "Hallo"
string2 = " Welt"
zeige_string_verkettung(string1, string2)
```

```python
# String-Wiederholung
def zeige_string_wiederholung(text, anzahl):
    """Zeigt das Ergebnis einer String-Wiederholung an."""
    ergebnis = text * anzahl
    return {"text": text, "wiederholungen": anzahl, "ergebnis": ergebnis}

text = "Python "
anzahl = 3
zeige_string_wiederholung(text, anzahl)
```

```python
# Zugriff auf einzelne Zeichen
def zeige_zeichen_zugriff(text, index):
    """Zeigt den Zugriff auf ein einzelnes Zeichen an."""
    return {"text": text, "index": index, "zeichen": text[index]}

text = "Python"
index = 0  # Erstes Zeichen
zeige_zeichen_zugriff(text, index)
```

```python
# Zugriff auf letztes Zeichen
index = -1  # Letztes Zeichen
zeige_zeichen_zugriff(text, index)
```

```python
# Substring (Slice)
def zeige_substring(text, start, ende):
    """Zeigt einen Teilstring (Slice) an."""
    return {"text": text, "start": start, "ende": ende, "teilstring": text[start:ende]}

text = "Python"
start = 1
ende = 4
zeige_substring(text, start, ende)
```

### Boolean (bool)
- Wahrheitswerte: `True` oder `False`
- Werden für logische Operationen verwendet

```python
# Grundlegende Booleans
def zeige_boolean(wert):
    """Zeigt einen Boolean-Wert an."""
    return {"wert": wert, "typ": type(wert).__name__}

wahr = True
zeige_boolean(wahr)
```

```python
falsch = False
zeige_boolean(falsch)
```

```python
# Vergleichsoperatoren erzeugen Booleans
def zeige_vergleich(a, b, operator_text):
    """Zeigt das Ergebnis eines Vergleichs an."""
    if operator_text == ">":
        ergebnis = a > b
    elif operator_text == "<":
        ergebnis = a < b
    elif operator_text == "==":
        ergebnis = a == b
    elif operator_text == "!=":
        ergebnis = a != b
    elif operator_text == ">=":
        ergebnis = a >= b
    elif operator_text == "<=":
        ergebnis = a <= b
    else:
        ergebnis = None
    
    return {"a": a, "b": b, "operator": operator_text, "ergebnis": ergebnis}

a = 5
b = 3
operator_text = ">"
zeige_vergleich(a, b, operator_text)
```

```python
# Gleich-Vergleich
a = 10
b = 9
operator_text = "=="
zeige_vergleich(a, b, operator_text)
```

```python
# Logische UND-Verknüpfung
def zeige_logisches_und(a, b):
    """Zeigt das Ergebnis einer logischen UND-Verknüpfung an."""
    ergebnis = a and b
    return {"a": a, "b": b, "a_and_b": ergebnis}

a = True
b = False
zeige_logisches_und(a, b)
```

```python
# Logische ODER-Verknüpfung
def zeige_logisches_oder(a, b):
    """Zeigt das Ergebnis einer logischen ODER-Verknüpfung an."""
    ergebnis = a or b
    return {"a": a, "b": b, "a_or_b": ergebnis}

a = True
b = False
zeige_logisches_oder(a, b)
```

```python
# Logische Negation
def zeige_logische_negation(wert):
    """Zeigt das Ergebnis einer logischen Negation an."""
    ergebnis = not wert
    return {"wert": wert, "not_wert": ergebnis}

wert = True
zeige_logische_negation(wert)
```

```python
# Konvertierung zu Boolean
def zeige_boolean_konvertierung(wert):
    """Zeigt die Konvertierung eines Werts zu Boolean an."""
    ergebnis = bool(wert)
    return {"wert": wert, "als_boolean": ergebnis}

leerer_string = ""
zeige_boolean_konvertierung(leerer_string)
```

```python
zahl_null = 0
zeige_boolean_konvertierung(zahl_null)
```

```python
zahl_eins = 1
zeige_boolean_konvertierung(zahl_eins)
```

```python
nicht_leer = "Python"
zeige_boolean_konvertierung(nicht_leer)
```

## Grundlegende Operatoren

### Arithmetische Operatoren

```python
# Addition
def zeige_addition(a, b):
    """Zeigt das Ergebnis einer Addition an."""
    ergebnis = a + b
    return {"a": a, "b": b, "a + b": ergebnis}

a = 15
b = 4
zeige_addition(a, b)
```

```python
# Subtraktion
def zeige_subtraktion(a, b):
    """Zeigt das Ergebnis einer Subtraktion an."""
    ergebnis = a - b
    return {"a": a, "b": b, "a - b": ergebnis}

a = 15
b = 4
zeige_subtraktion(a, b)
```

```python
# Multiplikation
def zeige_multiplikation(a, b):
    """Zeigt das Ergebnis einer Multiplikation an."""
    ergebnis = a * b
    return {"a": a, "b": b, "a * b": ergebnis}

a = 15
b = 4
zeige_multiplikation(a, b)
```

```python
# Division
def zeige_division(a, b):
    """Zeigt das Ergebnis einer Division an."""
    ergebnis = a / b
    return {"a": a, "b": b, "a / b": ergebnis, "ergebnis_typ": type(ergebnis).__name__}

a = 15
b = 4
zeige_division(a, b)
```

```python
# Ganzzahldivision
def zeige_ganzzahldivision(a, b):
    """Zeigt das Ergebnis einer Ganzzahldivision an."""
    ergebnis = a // b
    return {"a": a, "b": b, "a // b": ergebnis, "ergebnis_typ": type(ergebnis).__name__}

a = 15
b = 4
zeige_ganzzahldivision(a, b)
```

```python
# Modulo (Rest)
def zeige_modulo(a, b):
    """Zeigt das Ergebnis einer Modulo-Operation an."""
    ergebnis = a % b
    return {"a": a, "b": b, "a % b": ergebnis}

a = 15
b = 4
zeige_modulo(a, b)
```

```python
# Potenzierung
def zeige_potenzierung(a, b):
    """Zeigt das Ergebnis einer Potenzierung an."""
    ergebnis = a ** b
    return {"a": a, "b": b, "a ** b": ergebnis}

a = 15
b = 4
zeige_potenzierung(a, b)
```

```python
# Modulo mit negativen Zahlen
def zeige_modulo_negativ(a, b):
    """Zeigt das Ergebnis einer Modulo-Operation mit negativen Zahlen an."""
    ergebnis = a % b
    return {"a": a, "b": b, "a % b": ergebnis, 
            "hinweis": "In Python ist das Ergebnis stets das gleiche Vorzeichen wie der Divisor."}

a = -15
b = 4
zeige_modulo_negativ(a, b)
```

### Verkürzte Operatoren (Zuweisungsoperatoren)

```python
# Additions-Zuweisung
def zeige_zuweisungsoperator(original, operator, wert):
    """Demonstriert einen Zuweisungsoperator."""
    x = original
    
    if operator == "+=":
        x += wert  # x = x + wert
    elif operator == "-=":
        x -= wert  # x = x - wert
    elif operator == "*=":
        x *= wert  # x = x * wert
    elif operator == "/=":
        x /= wert  # x = x / wert
    elif operator == "//=":
        x //= wert  # x = x // wert
    elif operator == "%=":
        x %= wert  # x = x % wert
    elif operator == "**=":
        x **= wert  # x = x ** wert
    
    return {"original": original, "operator": operator, "wert": wert, "ergebnis": x}

x = 10
operator = "+="
wert = 5
zeige_zuweisungsoperator(x, operator, wert)
```

```python
# Subtraktions-Zuweisung
x = 10
operator = "-="
wert = 3
zeige_zuweisungsoperator(x, operator, wert)
```

```python
# Multiplikations-Zuweisung
x = 10
operator = "*="
wert = 2
zeige_zuweisungsoperator(x, operator, wert)
```

```python
# Divisions-Zuweisung
x = 10
operator = "/="
wert = 2
zeige_zuweisungsoperator(x, operator, wert)
```

```python
# Ganzzahldivisions-Zuweisung
x = 10
operator = "//="
wert = 3
zeige_zuweisungsoperator(x, operator, wert)
```

```python
# Modulo-Zuweisung
x = 10
operator = "%="
wert = 3
zeige_zuweisungsoperator(x, operator, wert)
```

```python
# Potenzierungs-Zuweisung
x = 10
operator = "**="
wert = 2
zeige_zuweisungsoperator(x, operator, wert)
```

### Vergleichsoperatoren

```python
# Ist gleich
def zeige_gleich(a, b):
    """Zeigt das Ergebnis eines Gleich-Vergleichs an."""
    ergebnis = a == b
    return {"a": a, "b": b, "a == b": ergebnis}

a = 5
b = 5
zeige_gleich(a, b)
```

```python
# Ist ungleich
def zeige_ungleich(a, b):
    """Zeigt das Ergebnis eines Ungleich-Vergleichs an."""
    ergebnis = a != b
    return {"a": a, "b": b, "a != b": ergebnis}

a = 5
b = 10
zeige_ungleich(a, b)
```

```python
# Ist größer als
def zeige_groesser(a, b):
    """Zeigt das Ergebnis eines Größer-Vergleichs an."""
    ergebnis = a > b
    return {"a": a, "b": b, "a > b": ergebnis}

a = 10
b = 5
zeige_groesser(a, b)
```

```python
# Ist kleiner als
def zeige_kleiner(a, b):
    """Zeigt das Ergebnis eines Kleiner-Vergleichs an."""
    ergebnis = a < b
    return {"a": a, "b": b, "a < b": ergebnis}

a = 5
b = 10
zeige_kleiner(a, b)
```

```python
# Ist größer oder gleich
def zeige_groesser_gleich(a, b):
    """Zeigt das Ergebnis eines Größer-oder-gleich-Vergleichs an."""
    ergebnis = a >= b
    return {"a": a, "b": b, "a >= b": ergebnis}

a = 5
b = 5
zeige_groesser_gleich(a, b)
```

```python
# Ist kleiner oder gleich
def zeige_kleiner_gleich(a, b):
    """Zeigt das Ergebnis eines Kleiner-oder-gleich-Vergleichs an."""
    ergebnis = a <= b
    return {"a": a, "b": b, "a <= b": ergebnis}

a = 10
b = 10
zeige_kleiner_gleich(a, b)
```

```python
# Identitätsoperator (is)
def zeige_identisch(a, b):
    """Zeigt das Ergebnis eines Identitätsvergleichs an."""
    ergebnis = a is b
    return {"a": a, "b": b, "a is b": ergebnis, 
            "hinweis": "Prüft auf Objektidentität, nicht Wertgleichheit"}

a = 5
b = 5
zeige_identisch(a, b)
```

```python
# Nicht identisch (is not)
def zeige_nicht_identisch(a, b):
    """Zeigt das Ergebnis eines Nicht-Identitätsvergleichs an."""
    ergebnis = a is not b
    return {"a": a, "b": b, "a is not b": ergebnis}

a = 5
b = 10
zeige_nicht_identisch(a, b)
```

## Typumwandlung

- Explizite Typumwandlung (Casting) zwischen den Datentypen
- Grundfunktionen: `int()`, `float()`, `str()`, `bool()`

```python
# String zu Integer
def zeige_string_zu_int(text):
    """Zeigt die Umwandlung eines Strings zu einem Integer an."""
    zahl = int(text)
    return {"text": text, "als_int": zahl, "neuer_typ": type(zahl).__name__}

text_zahl = "42"
zeige_string_zu_int(text_zahl)
```

```python
# String zu Float
def zeige_string_zu_float(text):
    """Zeigt die Umwandlung eines Strings zu einem Float an."""
    zahl = float(text)
    return {"text": text, "als_float": zahl, "neuer_typ": type(zahl).__name__}

text_zahl = "42"
zeige_string_zu_float(text_zahl)
```

```python
# Zahl zu String
def zeige_zahl_zu_string(zahl):
    """Zeigt die Umwandlung einer Zahl zu einem String an."""
    text = str(zahl)
    return {"zahl": zahl, "als_string": text, "neuer_typ": type(text).__name__}

zahl = 3.14159
zeige_zahl_zu_string(zahl)
```

```python
# Float zu Integer
def zeige_float_zu_int(zahl):
    """Zeigt die Umwandlung eines Floats zu einem Integer an."""
    int_wert = int(zahl)
    return {"float": zahl, "als_int": int_wert, 
            "hinweis": "Nachkommastellen werden abgeschnitten, nicht gerundet"}

float_wert = 9.99
zeige_float_zu_int(float_wert)
```

```python
# String zu Boolean
def zeige_string_zu_bool(text):
    """Zeigt die Umwandlung eines Strings zu einem Boolean an."""
    bool_wert = bool(text)
    return {"text": repr(text), "als_bool": bool_wert, 
            "hinweis": "Leere Strings sind False, nicht-leere sind True"}

leerer_string = ""
zeige_string_zu_bool(leerer_string)
```

```python
nicht_leer = "Python"
zeige_string_zu_bool(nicht_leer)
```

```python
# Fehlerhafte Konvertierung abfangen
def zeige_fehlerhafte_konvertierung(text):
    """Zeigt den Umgang mit fehlerhaften Konvertierungen."""
    try:
        # Würde einen Fehler verursachen
        zahl = int(text)
        return {"text": text, "als_int": zahl, "erfolgreich": True}
    except ValueError:
        return {"text": text, "fehler": f"ValueError: '{text}' kann nicht direkt zu int konvertiert werden", 
                "erfolgreich": False}

ungueltig = "42.5"
zeige_fehlerhafte_konvertierung(ungueltig)
```

```python
# Korrekte Herangehensweise für Strings mit Dezimalpunkt
def zeige_korrekte_konvertierung(text):
    """Zeigt die korrekte Konvertierung eines Strings mit Dezimalpunkt zu int."""
    zahl = int(float(text))
    return {"text": text, "als_int": zahl, "methode": "int(float(text))"}

dezimal_text = "42.5"
zeige_korrekte_konvertierung(dezimal_text)
```

## Namenskonventionen für Variablen

- Python verwendet die Snake-Case-Notation für Variablen
- Variablennamen sollten beschreibend und aussagekräftig sein

```python
# Gute Variablennamen (Snake Case)
def zeige_gute_namen(name, wert, aktiv):
    """Zeigt Beispiele für gute Variablennamen in Python."""
    return {"user_name": name, "account_balance": wert, "is_active": aktiv,
            "hinweis": "Gute Namen sind beschreibend und nutzen snake_case."}

user_name = "Max Mustermann"
account_balance = 1000.50
is_active = True
zeige_gute_namen(user_name, account_balance, is_active)
```

```python
# Konstanten (nur Konvention, nicht erzwungen)
def zeige_konstanten(max_wert, pi_wert):
    """Zeigt Beispiele für Konstanten in Python."""
    return {"MAX_VERSUCHE": max_wert, "PI": pi_wert,
            "hinweis": "Konstanten werden in GROSSBUCHSTABEN geschrieben (Konvention)."}

MAX_VERSUCHE = 3
PI = 3.14159
zeige_konstanten(MAX_VERSUCHE, PI)
```

```python
# Ungünstige Namen
def zeige_unguenstige_namen(kurzer_name, camel_case):
    """Zeigt Beispiele für ungünstige Variablennamen in Python."""
    return {"a": kurzer_name, "diesIstEineLangeVariable": camel_case,
            "hinweis": "Diese Namen entsprechen nicht den Python-Konventionen."}

a = 42                     # zu kurz, nicht beschreibend
diesIstEineLangeVariable = "Test"  # CamelCase (nicht Python-typisch)
zeige_unguenstige_namen(a, diesIstEineLangeVariable)
```

```python
# Private Variablen (Konvention)
def zeige_private_variable(interner_wert):
    """Zeigt ein Beispiel für eine private Variable in Python."""
    return {"_interner_zaehler": interner_wert,
            "hinweis": "Vorangestellter Unterstrich zeigt an, dass die Variable privat ist (Konvention)."}

_interner_zaehler = 0
zeige_private_variable(_interner_zaehler)
```

```python
# Sehr private Variablen (Konvention)
def zeige_sehr_private_variable(geheim_wert):
    """Zeigt ein Beispiel für eine sehr private Variable in Python."""
    return {"__sehr_privat": geheim_wert,
            "hinweis": "Zwei vorangestellte Unterstriche führen zu Name Mangling."}

__sehr_privat = "geheim"
zeige_sehr_private_variable(__sehr_privat)
```

## Parameterübergabe und Rückgabewerte in Funktionen

- Parameter sind Variablen, die an eine Funktion übergeben werden
- Rückgabewerte werden mit `return` zurückgegeben
- Python unterstützt Positionsparameter, Schlüsselwortparameter und Standardwerte

```python
# Einfache Parameterübergabe
def begrüße_person(name, alter, ort="Berlin"):
    """
    Begrüßt eine Person mit Namen, Alter und Wohnort.
    
    Args:
        name (str): Name der Person
        alter (int): Alter der Person
        ort (str, optional): Wohnort, Standardwert ist "Berlin"
    
    Returns:
        dict: Begrüßungstext und Statusinformationen
    """
    begruessung = f"Hallo {name}!"
    status = f"{alter} Jahre alt, wohnhaft in {ort}."
    
    return {
        "begruessung": begruessung,
        "status": status,
        "ist_volljaehrig": alter >= 18
    }

# Aufruf mit erforderlichen Parametern
name = "Anna"
alter = 28
begrüße_person(name, alter)
```

```python
# Aufruf mit allen Parametern
name = "Max"
alter = 22
ort = "München"
begrüße_person(name, alter, ort)
```

```python
# Aufruf mit benannten Parametern
def zeige_benannte_parameter(name, alter, ort):
    """Demonstriert benannte Parameter mit veränderter Reihenfolge."""
    return begrüße_person(name=name, alter=alter, ort=ort)

name = "Lisa"
alter = 35
ort = "Hamburg"
zeige_benannte_parameter(name, alter, ort)
```

```python
# Funktion mit einem Rückgabewert
def berechne_quadrat(zahl):
    """
    Berechnet das Quadrat einer Zahl.
    
    Args:
        zahl (int/float): Die zu quadrierende Zahl
    
    Returns:
        int/float: Das Quadrat der Zahl
    """
    quadrat = zahl ** 2
    return quadrat

zahl = 7
berechne_quadrat(zahl)
```

```python
# Funktion mit mehreren Rückgabewerten
def berechne_verschiedenes(zahl):
    """
    Berechnet verschiedene Werte für eine Zahl.
    
    Args:
        zahl (int/float): Eine Zahl für verschiedene Berechnungen
    
    Returns:
        tuple: Quadrat, Wurzel und Verdopplung der Zahl
    """
    quadrat = zahl ** 2
    wurzel = zahl ** 0.5  # Quadratwurzel
    verdoppelt = zahl * 2
    
    # Mehrere Werte werden als Tupel zurückgegeben
    return quadrat, wurzel, verdoppelt

zahl = 9
berechne_verschiedenes(zahl)
```

```python
# Rückgabewerte in separate Variablen entpacken
def zeige_entpacken(zahl):
    """Demonstriert das Entpacken von mehreren Rückgabewerten."""
    q, w, v = berechne_verschiedenes(zahl)
    return {"quadrat": q, "wurzel": w, "verdoppelt": v}

zahl = 9
zeige_entpacken(zahl)
```

```python
# Funktion mit variabler Anzahl von Positionsargumenten
def summiere_zahlen(*args):
    """
    Summiert eine variable Anzahl von Zahlen.
    
    Args:
        *args: Variable Anzahl von Zahlen
    
    Returns:
        float/int: Summe aller übergebenen Zahlen
    """
    return sum(args)

summiere_zahlen(1, 2, 3, 4, 5)
```

```python
# Funktion mit variabler Anzahl von Schlüsselwortargumenten
def erstelle_person(**kwargs):
    """
    Erstellt ein Personenobjekt aus beliebigen Attributen.
    
    Args:
        **kwargs: Schlüsselwort-Argumente für Personenattribute
    
    Returns:
        dict: Personenobjekt mit allen übergebenen Attributen
    """
    return kwargs

erstelle_person(name="Max", alter=30, beruf="Entwickler", stadt="Berlin")
```

```python
# Kombination von verschiedenen Parameterarten
def zeige_parameter_typen(*args, **kwargs):
    """
    Demonstriert verschiedene Arten von Parametern.
    
    Args:
        *args: Variable Anzahl von Positionsargumenten
        **kwargs: Variable Anzahl von Schlüsselwortargumenten
    
    Returns:
        dict: Informationen über die übergebenen Parameter
    """
    return {
        "positionale_argumente": args,
        "schlüsselwort_argumente": kwargs,
        "anzahl_args": len(args),
        "anzahl_kwargs": len(kwargs)
    }

zeige_parameter_typen(1, 2, 3, name="Python", version=3.9)
```

## Übungsaufgaben

### Übung 1: Grundlegende Operationen

Erstellen Sie eine Funktion, die:
1. Zwei Zahlen als Parameter annimmt
2. Alle grundlegenden arithmetischen Operationen ausführt
3. Die Ergebnisse als Dictionary zurückgibt

```python
def grundoperationen(a, b):
    """
    Führt alle grundlegenden arithmetischen Operationen mit zwei Zahlen durch.
    
    Args:
        a (int/float): Erste Zahl
        b (int/float): Zweite Zahl
    
    Returns:
        dict: Ergebnisse aller Operationen
    """
    # Hier den Code implementieren
    ergebnisse = {
        "summe": a + b,
        "differenz": a - b,
        "produkt": a * b,
        "quotient": a / b if b != 0 else "Division durch Null nicht möglich",
        "ganzzahl_division": a // b if b != 0 else "Division durch Null nicht möglich",
        "rest": a % b if b != 0 else "Division durch Null nicht möglich",
        "potenz": a ** b
    }
    
    return ergebnisse

# Testen der Funktion
a = 10
b = 3
grundoperationen(a, b)
```

### Übung 2: Typumwandlung und Manipulation

Erstellen Sie eine Funktion, die:
1. Einen beliebigen Wert akzeptiert
2. Den Typ dieses Wertes bestimmt
3. Versucht, diesen Wert in andere Datentypen umzuwandeln
4. Die Ergebnisse zurückgibt

```python
def typkonverter(wert):
    """
    Wandelt einen Wert in verschiedene Datentypen um.
    
    Args:
        wert: Ein beliebiger Wert
    
    Returns:
        dict: Ergebnisse der Typumwandlungen
    """
    # Hier den Code implementieren
    original_typ = type(wert).__name__
    
    # Versuche verschiedene Umwandlungen
    try:
        als_int = int(wert)
        int_erfolg = True
    except (ValueError, TypeError):
        als_int = "Konvertierung nicht möglich"
        int_erfolg = False
        
    try:
        als_float = float(wert)
        float_erfolg = True
    except (ValueError, TypeError):
        als_float = "Konvertierung nicht möglich"
        float_erfolg = False
        
    try:
        als_str = str(wert)
        str_erfolg = True
    except (ValueError, TypeError):
        als_str = "Konvertierung nicht möglich"
        str_erfolg = False
        
    als_bool = bool(wert)
    
    return {
        "original_wert": wert,
        "original_typ": original_typ,
        "als_int": als_int,
        "int_erfolg": int_erfolg,
        "als_float": als_float,
        "float_erfolg": float_erfolg,
        "als_str": als_str,
        "str_erfolg": str_erfolg,
        "als_bool": als_bool
    }

# Testen mit einem String-Wert
wert = "42"
typkonverter(wert)
```

```python
# Testen mit einem Float-Wert
wert = 3.14
typkonverter(wert)
```

```python
# Testen mit einem nicht-konvertierbaren Wert
wert = "Python"
typkonverter(wert)
```

### Übung 3: Kreditratenberechnung

Erstellen Sie eine Funktion zur Berechnung der monatlichen Kreditrate, die:
1. Das Kreditvolumen, den Zinssatz und die Laufzeit in Jahren als Parameter akzeptiert
2. Die monatliche Rate berechnet (Annuitätendarlehen)
3. Ein Dictionary mit relevanten Informationen zurückgibt

```python
def berechne_kreditrate(kreditbetrag, jahreszins, laufzeit_jahre):
    """
    Berechnet die monatliche Kreditrate für ein Annuitätendarlehen.
    
    Args:
        kreditbetrag (float): Kreditsumme in Euro
        jahreszins (float): Jahreszins in Prozent (z.B. 3.5 für 3,5%)
        laufzeit_jahre (int): Laufzeit in Jahren
    
    Returns:
        dict: Informationen zur Kreditberechnung
    """
    # Monatszins berechnen (Jahresszins / 12 / 100)
    monatszins = jahreszins / 12 / 100
    
    # Anzahl der Monatsraten
    anzahl_raten = laufzeit_jahre * 12
    
    # Berechnung der monatlichen Rate
    # Formel: K * q^n * (q-1) / (q^n - 1) mit q = 1 + p/100
    if monatszins > 0:
        rate = kreditbetrag * monatszins * (1 + monatszins)**anzahl_raten / ((1 + monatszins)**anzahl_raten - 1)
    else:
        # Bei Zinssatz 0 ist es einfach Kreditbetrag / Anzahl Raten
        rate = kreditbetrag / anzahl_raten
    
    # Gesamtkosten berechnen
    gesamtkosten = rate * anzahl_raten
    gesamtzinsen = gesamtkosten - kreditbetrag
    
    return {
        "kreditbetrag": kreditbetrag,
        "jahreszins": jahreszins,
        "laufzeit_jahre": laufzeit_jahre,
        "monatliche_rate": rate,
        "anzahl_raten": anzahl_raten,
        "gesamtkosten": gesamtkosten,
        "gesamtzinsen": gesamtzinsen
    }

# Berechnen der Rate für einen Kredit
kreditbetrag = 100000
jahreszins = 3.5
laufzeit_jahre = 20
berechne_kreditrate(kreditbetrag, jahreszins, laufzeit_jahre)
```

```python
# Berechnen der Rate für einen kleineren Kredit
kreditbetrag = 25000
jahreszins = 2.1
laufzeit_jahre = 5
berechne_kreditrate(kreditbetrag, jahreszins, laufzeit_jahre)
```

```python
# Berechnen der Rate für einen zinslosen Kredit
kreditbetrag = 50000
jahreszins = 0
laufzeit_jahre = 10
berechne_kreditrate(kreditbetrag, jahreszins, laufzeit_jahre)
```

### Übung 4: Temperaturumrechnung

Erstellen Sie eine Funktion zur Temperaturumrechnung, die:
1. Eine Temperatur und deren Einheit (C, F oder K) als Parameter akzeptiert
2. Diese Temperatur in die beiden anderen Einheiten umrechnet
3. Ein Dictionary mit allen drei Temperaturwerten zurückgibt

```python
def temperatur_umrechnen(temperatur, einheit):
    """
    Rechnet eine Temperatur zwischen Celsius, Fahrenheit und Kelvin um.
    
    Args:
        temperatur (float): Der Temperaturwert
        einheit (str): Die Einheit des Temperaturwerts ('C', 'F' oder 'K')
    
    Returns:
        dict: Die Temperatur in allen drei Einheiten
    """
    # Normalisiere die Einheit (Großbuchstabe)
    einheit = einheit.upper()
    
    # Umrechnung auf Basis der Ausgangseinheit
    if einheit == 'C':
        celsius = temperatur
        fahrenheit = celsius * 9/5 + 32
        kelvin = celsius + 273.15
    elif einheit == 'F':
        fahrenheit = temperatur
        celsius = (fahrenheit - 32) * 5/9
        kelvin = celsius + 273.15
    elif einheit == 'K':
        kelvin = temperatur
        celsius = kelvin - 273.15
        fahrenheit = celsius * 9/5 + 32
    else:
        return {
            "fehler": f"Ungültige Einheit: {einheit}. Erlaubt sind 'C', 'F' oder 'K'."
        }
    
    return {
        "celsius": celsius,
        "fahrenheit": fahrenheit,
        "kelvin": kelvin,
        "original": f"{temperatur} {einheit}"
    }

# Umrechnung von Celsius
temp_wert = 25
einheit = 'C'
temperatur_umrechnen(temp_wert, einheit)
```

```python
# Umrechnung von Fahrenheit
temp_wert = 98.6
einheit = 'F'
temperatur_umrechnen(temp_wert, einheit)
```

```python
# Umrechnung von Kelvin
temp_wert = 0
einheit = 'K'
temperatur_umrechnen(temp_wert, einheit)
```

### Übung 5: Datentypen-Analyse

Erstellen Sie eine Funktion, die:
1. Eine Liste von verschiedenen Werten als Parameter akzeptiert
2. Jeden Wert klassifiziert und analysiert
3. Eine Zusammenfassung der Liste zurückgibt

```python
def analysiere_datentypen(werte_liste):
    """
    Analysiert eine Liste von Werten nach Datentypen.
    
    Args:
        werte_liste (list): Eine Liste mit verschiedenen Werten
    
    Returns:
        dict: Analyse der Datentypen in der Liste
    """
    # Zähler für verschiedene Datentypen
    typ_zaehler = {
        "int": 0,
        "float": 0,
        "str": 0,
        "bool": 0,
        "andere": 0
    }
    
    # Spezifische Informationen
    numerische_summe = 0
    string_laengen = []
    wahrheitswerte = []
    
    # Jeden Wert analysieren
    for wert in werte_liste:
        if isinstance(wert, int):
            typ_zaehler["int"] += 1
            numerische_summe += wert
        elif isinstance(wert, float):
            typ_zaehler["float"] += 1
            numerische_summe += wert
        elif isinstance(wert, str):
            typ_zaehler["str"] += 1
            string_laengen.append(len(wert))
        elif isinstance(wert, bool):
            typ_zaehler["bool"] += 1
            wahrheitswerte.append(wert)
            # Bool-Werte nicht zur numerischen Summe hinzufügen
        else:
            typ_zaehler["andere"] += 1
    
    # Zusammenfassung erstellen
    anzahl_werte = len(werte_liste)
    durchschnittliche_string_laenge = (
        sum(string_laengen) / len(string_laengen) 
        if string_laengen else 0
    )
    
    return {
        "anzahl_werte": anzahl_werte,
        "typ_verteilung": typ_zaehler,
        "numerische_summe": numerische_summe,
        "durchschnittliche_string_laenge": durchschnittliche_string_laenge,
        "anzahl_true": wahrheitswerte.count(True),
        "anzahl_false": wahrheitswerte.count(False),
        "haeufigster_typ": max(typ_zaehler, key=typ_zaehler.get)
    }

# Analyse einer gemischten Liste
gemischte_liste = [42, 3.14, "Python", True, 100, "Programmierung", False, 2.718]
analysiere_datentypen(gemischte_liste)
```

## Zusammenfassung

- **Variablen** sind Speicherbereiche für Daten, die in Python dynamisch typisiert sind
- **Grundlegende Datentypen** in Python:
  - `int`: Ganze Zahlen ohne Nachkommastellen
  - `float`: Gleitkommazahlen mit Nachkommastellen
  - `str`: Zeichenketten/Text
  - `bool`: Wahrheitswerte (True/False)
- **Grundlegende Operatoren**:
  - Arithmetische Operatoren: `+`, `-`, `*`, `/`, `//`, `%`, `**`
  - Zuweisungsoperatoren: `=`, `+=`, `-=`, etc.
  - Vergleichsoperatoren: `==`, `!=`, `>`, `<`, `>=`, `<=`
- **Typumwandlung** erfolgt mit speziellen Funktionen:
  - `int()`, `float()`, `str()`, `bool()`
- **Namenskonventionen** für Variablen:
  - Snake_case für Variablen und Funktionen
  - Beschreibende Namen verwenden
  - Spezielle Regeln für Konstanten und private Variablen
- **Parameterübergabe und Rückgabewerte** in Funktionen:
  - Positionsparameter und Schlüsselwortparameter
  - Standardwerte für optionale Parameter
  - Rückgabe mit `return`
  - Mehrere Rückgabewerte als Tupel
  - Variable Parameteranzahl mit `*args` und `**kwargs`

## Weiterführende Ressourcen

- [Python Dokumentation - Datenmodell](https://docs.python.org/3/reference/datamodel.html)
- [Python Dokumentation - Standardtypen](https://docs.python.org/3/library/stdtypes.html)
- [Python Dokumentation - Numerische Typen](https://docs.python.org/3/library/stdtypes.html#numeric-types-int-float-complex)
- [Python Dokumentation - Funktionen](https://docs.python.org/3/tutorial/controlflow.html#defining-functions)
- [Python Cookbook](https://python-cookbook.readthedocs.io/en/latest/) - Praktische Rezepte für häufige Programmieraufgaben
- [Real Python - Python Basics](https://realpython.com/tutorials/basics/) - Viele praxisnahe Tutorials
