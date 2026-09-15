Dieses Dokument enthält Beispiele für die Verwendung des interaktiven Modus in Python, basierend auf Kapitel 3 der Quellmaterialien. Jedes Beispiel ist als eigenständige Funktion implementiert.

## 1. Grundlagen zu Ganzen Zahlen

- Demonstration von ganzen Zahlen mit Vorzeichen
- Beispiele für einfache arithmetische Operationen mit ganzen Zahlen

```python
def vorzeichen_ganzzahl():
    # Ganze Zahlen mit negativem Vorzeichen
    return -9

# Aufruf der Funktion vorzeichen_ganzzahl()
vorzeichen_ganzzahl()
```
```python
def positive_ganzzahl():
    # Größere positive Ganzzahl
    return 1139

# Aufruf der Funktion positive_ganzzahl()
positive_ganzzahl()
```
```python
def explizit_positive_ganzzahl():
    # Ganze Zahl mit explizit positivem Vorzeichen
    return +12

# Aufruf der Funktion explizit_positive_ganzzahl()
explizit_positive_ganzzahl()
```
```python
def einfache_addition():
    # Einfache Addition zweier Zahlen
    return 5 + 9

# Aufruf der Funktion einfache_addition()
einfache_addition()
```
```python
def komplexer_ausdruck():
    # Komplexerer Ausdruck mit Klammerung und verschiedenen Operatoren
    return (21 - 3) * 9 + 6

# Aufruf der Funktion komplexer_ausdruck()
komplexer_ausdruck()
```

## 2. Division von ganzen Zahlen

- Die Division (/) von ganzen Zahlen ergibt in Python 3 immer eine Gleitkommazahl
- Unterschied zur ganzzahligen Division (//) erklärt

```python
def division_drei_durch_zwei():
    # Normale Division ergibt eine Gleitkommazahl
    return 3/2

# Aufruf der Funktion division_drei_durch_zwei()
division_drei_durch_zwei()
```
```python
def division_zwei_durch_drei():
    # Division ergibt periodische Gleitkommazahl
    return 2/3

# Aufruf der Funktion division_zwei_durch_drei()
division_zwei_durch_drei()
```
```python
def division_vier_durch_vier():
    # Division ergibt ganzzahlige Gleitkommazahl
    return 4/4

# Aufruf der Funktion division_vier_durch_vier()
division_vier_durch_vier()
```
```python
def ganzzahlige_division_drei_durch_zwei():
    # Ganzzahlige Division mit //
    return 3//2

# Aufruf der Funktion ganzzahlige_division_drei_durch_zwei()
ganzzahlige_division_drei_durch_zwei()
```
```python
def ganzzahlige_division_zwei_durch_drei():
    # Ganzzahlige Division mit // ergibt 0
    return 2//3

# Aufruf der Funktion ganzzahlige_division_zwei_durch_drei()
ganzzahlige_division_zwei_durch_drei()
```

## 3. Gleitkommazahlen

- Literale für Gleitkommazahlen verwenden einen Punkt als Dezimaltrennzeichen
- Wissenschaftliche Notation mit e oder E

```python
def positive_gleitkommazahl():
    # Einfache positive Gleitkommazahl
    return 0.5

# Aufruf der Funktion positive_gleitkommazahl()
positive_gleitkommazahl()
```
```python
def negative_gleitkommazahl():
    # Negative Gleitkommazahl mit drei Nachkommastellen
    return -123.456

# Aufruf der Funktion negative_gleitkommazahl()
negative_gleitkommazahl()
```
```python
def explizit_positive_gleitkommazahl():
    # Gleitkommazahl mit explizitem Plusvorzeichen
    return +1.337

# Aufruf der Funktion explizit_positive_gleitkommazahl()
explizit_positive_gleitkommazahl()
```
```python
def gleitkomma_division():
    # Division zweier Gleitkommazahlen
    return 1.5 / 2.1

# Aufruf der Funktion gleitkomma_division()
gleitkomma_division()
```
```python
def wissenschaftliche_notation_klein_e():
    # Wissenschaftliche Notation mit kleinem e
    return 12.345e3  # entspricht 12.345 * 10^3

# Aufruf der Funktion wissenschaftliche_notation_klein_e()
wissenschaftliche_notation_klein_e()
```
```python
def wissenschaftliche_notation_gross_e():
    # Wissenschaftliche Notation mit großem E
    return 12.345E3  # entspricht 12.345 * 10^3

# Aufruf der Funktion wissenschaftliche_notation_gross_e()
wissenschaftliche_notation_gross_e()
```

## 4. Zeichenketten (Strings)

- Strings in einfachen oder doppelten Anführungszeichen
- Konkatenation von Strings mit dem +-Operator

```python
def string_doppelte_anfuehrungszeichen():
    # String in doppelten Anführungszeichen
    return "Hallo Welt"

# Aufruf der Funktion string_doppelte_anfuehrungszeichen()
string_doppelte_anfuehrungszeichen()
```
```python
def string_mit_zahlen():
    # String mit Buchstaben und Zahlen
    return "abc123"

# Aufruf der Funktion string_mit_zahlen()
string_mit_zahlen()
```
```python
def string_einfache_anfuehrungszeichen():
    # String in einfachen Anführungszeichen
    return 'Hallo Welt'

# Aufruf der Funktion string_einfache_anfuehrungszeichen()
string_einfache_anfuehrungszeichen()
```
```python
def string_konkatenation():
    # Verkettung mehrerer Strings mit dem +-Operator
    return "Hallo" + " " + "Welt"

# Aufruf der Funktion string_konkatenation()
string_konkatenation()
```
```python
def doppelte_anfuehrungszeichen_im_string():
    # String mit doppelten Anführungszeichen im Inhalt
    return 'Er sagt "Hallo"'

# Aufruf der Funktion doppelte_anfuehrungszeichen_im_string()
doppelte_anfuehrungszeichen_im_string()
```
```python
def einfache_anfuehrungszeichen_im_string():
    # String mit einfachen Anführungszeichen im Inhalt
    return "Er sagt 'Hallo'"

# Aufruf der Funktion einfache_anfuehrungszeichen_im_string()
einfache_anfuehrungszeichen_im_string()
```

## 5. Listen

- Listen sind geordnete Sammlungen von Elementen
- Elemente können verschiedene Datentypen haben
- Listen können ineinander verschachtelt werden
- Zugriff auf Elemente über Indizes (beginnend bei 0)

```python
def einfache_liste():
    # Einfache Liste mit drei ganzen Zahlen
    return [1, 2, 3]

# Aufruf der Funktion einfache_liste()
einfache_liste()
```
```python
def liste_mit_strings():
    # Liste aus Strings
    return ["Dies", "ist", "eine", "Liste"]

# Aufruf der Funktion liste_mit_strings()
liste_mit_strings()
```
```python
def liste_mit_ausdruecken():
    # Liste mit berechneten Werten
    return [-7 / 4, 5 * 3]

# Aufruf der Funktion liste_mit_ausdruecken()
liste_mit_ausdruecken()
```
```python
def gemischte_liste():
    # Liste mit verschiedenen Datentypen, inkl. verschachtelter Liste
    return ["Python", 1, 2, -7 / 4, [1, 2, 3]]

# Aufruf der Funktion gemischte_liste()
gemischte_liste()
```
```python
def listen_verketten():
    # Verkettung zweier Listen mit dem +-Operator
    return [1, 2, 3] + ["Python", "ist", "super"]

# Aufruf der Funktion listen_verketten()
listen_verketten()
```
```python
def listenelement_zugriff():
    # Zugriff auf Elemente einer Liste über Indizes
    x = ["Python", "ist", "super"]
    return {
        "erstes_element": x[0],  # Index 0
        "zweites_element": x[1],  # Index 1
        "drittes_element": x[2]   # Index 2
    }

# Aufruf der Funktion listenelement_zugriff()
listenelement_zugriff()
```

## 6. Dictionaries

- Dictionaries speichern Schlüssel-Wert-Paare
- Werte können über ihre Schlüssel abgerufen werden
- Neue Werte können hinzugefügt oder bestehende geändert werden

```python
def dictionary_erstellen():
    # Ein einfaches Dictionary mit zwei Schlüssel-Wert-Paaren
    return {"schlüssel1": "wert1", "schlüssel2": "wert2"}

# Aufruf der Funktion dictionary_erstellen()
dictionary_erstellen()
```
```python
def dictionary_wert_abrufen():
    # Zugriff auf Werte eines Dictionary über Schlüssel
    d = {"schlüssel1": "wert1", "schlüssel2": "wert2"}
    return d["schlüssel1"]

# Aufruf der Funktion dictionary_wert_abrufen()
dictionary_wert_abrufen()
```
```python
def dictionary_wert_aendern():
    # Ändern eines Werts in einem Dictionary
    d = {"schlüssel1": "wert1", "schlüssel2": "wert2"}
    d["schlüssel2"] = "wert2.1"
    return d

# Aufruf der Funktion dictionary_wert_aendern()
dictionary_wert_aendern()
```
```python
def dictionary_wert_hinzufuegen():
    # Hinzufügen eines neuen Schlüssel-Wert-Paars
    d = {"schlüssel1": "wert1", "schlüssel2": "wert2"}
    d["schlüssel3"] = "wert3"
    return d

# Aufruf der Funktion dictionary_wert_hinzufuegen()
dictionary_wert_hinzufuegen()
```

## 7. Variablen

- Variablen sind Namen, die mit Werten verknüpft werden
- Zuweisung erfolgt mit dem =-Operator
- Variablen können in Berechnungen verwendet werden

```python
def variablen_zuweisen():
    # Verschiedene Werte Variablen zuweisen
    name = 0.5
    var123 = 12
    string = "Hallo Welt!"
    liste = [1, 2, 3]
    
    return {
        "name": name,
        "var123": var123,
        "string": string,
        "liste": liste
    }

# Aufruf der Funktion variablen_zuweisen()
variablen_zuweisen()
```
```python
def variable_in_berechnung():
    # Variable in einer Berechnung verwenden
    name = 0.5
    return 2 * name

# Aufruf der Funktion variable_in_berechnung()
variable_in_berechnung()
```
```python
def komplexe_berechnung_mit_variablen():
    # Komplexere Berechnung mit Variablen
    var123 = 12
    return (var123 + var123) / 3

# Aufruf der Funktion komplexe_berechnung_mit_variablen()
komplexe_berechnung_mit_variablen()
```
```python
def variablen_unterschiedlicher_typen_addieren():
    # Addition einer Ganzzahl mit einer Gleitkommazahl
    var123 = 12
    name = 0.5
    return var123 + name

# Aufruf der Funktion variablen_unterschiedlicher_typen_addieren()
variablen_unterschiedlicher_typen_addieren()
```
```python
def variable_aus_ausdruck():
    # Zuweisung des Ergebnisses eines Ausdrucks an eine Variable
    a = 1 + 2
    return a

# Aufruf der Funktion variable_aus_ausdruck()
variable_aus_ausdruck()
```
```python
def variable_aus_berechnung():
    # Zuweisung des Ergebnisses einer Berechnung mit Variable
    var123 = 12
    b = var123 / 4
    return b

# Aufruf der Funktion variable_aus_berechnung()
variable_aus_berechnung()
```

## 8. Der Unterstrich im interaktiven Modus

- Im interaktiven Modus kann mit dem Unterstrich (`_`) auf den zuletzt ausgegebenen Wert zugegriffen werden
- Nur im interaktiven Modus verfügbar, nicht in regulären Programmen

```python
def unterstrich():
    # Simulation der Unterstrich-Funktionalität
    ergebnis1 = 1 + 7     # Im interaktiven Modus: 8
    _ = ergebnis1  # Im interaktiven Modus: _ ist hier 8
    ergebnis2 = _ * 3  # Im interaktiven Modus: _ * 3 wird 24 ergeben
    
    return {
        "ergebnis1": ergebnis1,
        "unterstrich1 (stellt _ dar)": _,
        "ergebnis2 (entspricht _ * 3)": ergebnis2,
        "hinweis": "Der Unterstrich funktioniert nur im echten interaktiven Modus"
    }

# Aufruf der Funktion unterstrich_simulation()
unterstrich()
```

## 9. Logische Ausdrücke

- Vergleichsoperatoren: `==, !=, <, >, <=, >=`
- Logische Operatoren: `not`, `and`, `or`

```python
def kleiner_vergleich():
    # Vergleich mit dem <-Operator
    return 3 < 4

# Aufruf der Funktion kleiner_vergleich()
kleiner_vergleich()
```
```python
def gleichheit_vergleich():
    # Vergleich mit dem ==-Operator
    return 3 == 4

# Aufruf der Funktion gleichheit_vergleich()
gleichheit_vergleich()
```
```python
def ungleichheit_vergleich():
    # Vergleich mit dem !=-Operator
    return 3 != 4

# Aufruf der Funktion ungleichheit_vergleich()
ungleichheit_vergleich()
```
```python
def groesser_vergleich():
    # Vergleich mit dem >-Operator
    return 3 > 4

# Aufruf der Funktion groesser_vergleich()
groesser_vergleich()
```
```python
def kleiner_gleich_vergleich():
    # Vergleich mit dem <=-Operator
    return 3 <= 4

# Aufruf der Funktion kleiner_gleich_vergleich()
kleiner_gleich_vergleich()
```
```python
def groesser_gleich_vergleich():
    # Vergleich mit dem >=-Operator
    return 3 >= 4

# Aufruf der Funktion groesser_gleich_vergleich()
groesser_gleich_vergleich()
```
```python
def not_operator_anwendung1():
    # Verwendung des not-Operators auf einen wahren Vergleich
    return not (3 < 4)

# Aufruf der Funktion not_operator_anwendung1()
not_operator_anwendung1()
```
```python
def not_operator_anwendung2():
    # Verwendung des not-Operators auf einen falschen Vergleich
    return not (4 < 3)

# Aufruf der Funktion not_operator_anwendung2()
not_operator_anwendung2()
```
```python
def and_operator_wahr_wahr():
    # Verwendung des and-Operators mit zwei wahren Ausdrücken
    return (3 < 4) and (5 < 6)

# Aufruf der Funktion and_operator_wahr_wahr()
and_operator_wahr_wahr()
```
```python
def and_operator_wahr_falsch():
    # Verwendung des and-Operators mit einem wahren und einem falschen Ausdruck
    return (3 < 4) and (4 < 3)

# Aufruf der Funktion and_operator_wahr_falsch()
and_operator_wahr_falsch()
```
```python
def or_operator_wahr_wahr():
    # Verwendung des or-Operators mit zwei wahren Ausdrücken
    return (3 < 4) or (5 < 6)

# Aufruf der Funktion or_operator_wahr_wahr()
or_operator_wahr_wahr()
```
```python
def or_operator_wahr_falsch():
    # Verwendung des or-Operators mit einem wahren und einem falschen Ausdruck
    return (3 < 4) or (4 < 3)

# Aufruf der Funktion or_operator_wahr_falsch()
or_operator_wahr_falsch()
```
```python
def or_operator_falsch_falsch():
    # Verwendung des or-Operators mit zwei falschen Ausdrücken
    return (5 > 6) or (4 < 3)

# Aufruf der Funktion or_operator_falsch_falsch()
or_operator_falsch_falsch()
```

## 10. Funktionen

- Python hat eingebaute Funktionen (built-in functions)
- Beispiel: die max()-Funktion zur Bestimmung des größten Elements

```python
def max_funktion_liste():
    # Verwendung der max()-Funktion mit einer Liste
    return max([1, 5, 2, 7, 9, 3])

# Aufruf der Funktion max_funktion_liste()
max_funktion_liste()
```
```python
def max_funktion_einzelwerte():
    # Verwendung der max()-Funktion mit einzelnen Werten
    return max(1, 5, 3)

# Aufruf der Funktion max_funktion_einzelwerte()
max_funktion_einzelwerte()
```

## 11. Methoden

- Methoden sind Funktionen, die auf Instanzen von Datentypen operieren
- Beispiele: `sort(`) für Listen, `count()` für Strings

```python
def listen_sort_methode():
    # Verwendung der sort()-Methode für Listen
    liste = [2, 7, 3, 2, 7, 8, 4, 2, 5]
    liste_kopie = liste.copy()  # Kopie erstellen, da sort() die Liste in-place ändert
    liste_kopie.sort()
    
    return {
        "ursprüngliche_liste": liste,
        "sortierte_liste": liste_kopie
    }

# Aufruf der Funktion listen_sort_methode()
listen_sort_methode()
```
```python
def string_count_methode():
    # Verwendung der count()-Methode für Strings
    return "Hallo Welt".count("l")

# Aufruf der Funktion string_count_methode()
string_count_methode()
```

## 12. Module

- Module sind Sammlungen von zusätzlicher Funktionalität
- Sie werden mit dem import-Schlüsselwort eingebunden
- Beispiel: das pprint-Modul für schön formatierte Ausgaben

```python
def modul_pprint_demo():
    import pprint
    
    # Komplexes Dictionary
    d = {
        "Python ist": ["super toll", "große Klasse", "mega abgefahren", "einfach und spannend"],
        "Python hat": ["viele Module", "einfach recht", "eine schön formatierte Bildschirmausgabe"]
    }
    
    # Im echten interaktiven Modus würde pprint.pprint(d) eine formatierte Ausgabe erzeugen
    # Hier geben wir nur das Dictionary zurück
    return {
        "komplexes_dictionary": d,
        "hinweis": "Im interaktiven Modus würde pprint.pprint(d) eine formatierte Ausgabe erzeugen"
    }

# Aufruf der Funktion modul_pprint_demo()
modul_pprint_demo()
```
