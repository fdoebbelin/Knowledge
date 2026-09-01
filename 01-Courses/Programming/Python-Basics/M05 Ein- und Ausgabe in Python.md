## Einfache Ein- und Ausgabe mit input() und print()

### Grundlagen der Eingabe mit input()

- Die `input()`-Funktion ermöglicht die Eingabe von Daten über die Tastatur
- Der optionale Parameter ist der Eingabeaufforderungstext (Prompt)
- Der Rückgabewert ist immer ein String

```python
def benutzereingabe_abfragen(prompt_text):
    """
    Fragt den Benutzer nach einer Eingabe und gibt diese zurück.
    
    Args:
        prompt_text: Text, der als Eingabeaufforderung angezeigt wird
        
    Returns:
        Die Benutzereingabe als String
    """
    eingabe = input(prompt_text)
    return eingabe
```

```python
# Funktion mit Eingabeaufforderung aufrufen
benutzereingabe_abfragen("Bitte Namen eingeben: ")
```

### Typkonvertierung bei Eingaben

- Da `input()` immer einen String zurückgibt, muss für numerische Werte eine Typkonvertierung erfolgen
- Häufig verwendete Typkonvertierungen: `int()`, `float()`

```python
def numerische_eingabe_verarbeiten(prompt_text):
    """
    Fragt den Benutzer nach einer numerischen Eingabe, konvertiert diese zu int
    und gibt das Ergebnis zurück.
    
    Args:
        prompt_text: Text, der als Eingabeaufforderung angezeigt wird
        
    Returns:
        Die konvertierte Benutzereingabe als Integer
    """
    eingabe_string = input(prompt_text)
    return int(eingabe_string)
```

```python
# Funktion für numerische Eingabe aufrufen
numerische_eingabe_verarbeiten("Bitte Alter eingeben: ")
```

### Grundlagen der Ausgabe mit print()

- Die `print()`-Funktion gibt Daten auf der Standardausgabe aus
- Mehrere Argumente werden durch Leerzeichen getrennt ausgegeben
- Parameter `sep` definiert das Trennzeichen (Standard: Leerzeichen)
- Parameter `end` definiert das Zeilenende (Standard: Zeilenumbruch `\n`)

```python
def mehrere_werte_ausgeben(wert1, wert2, wert3, trennzeichen=" ", zeilenende="\n"):
    """
    Gibt mehrere Werte mit anpassbarem Trennzeichen und Zeilenende aus.
    
    Args:
        wert1, wert2, wert3: Auszugebende Werte
        trennzeichen: Zeichen zwischen den Werten (Standard: Leerzeichen)
        zeilenende: Zeichen am Ende der Ausgabe (Standard: Zeilenumbruch)
        
    Returns:
        Die formatierte Ausgabe als String
    """
    ausgabe = f"{wert1}{trennzeichen}{wert2}{trennzeichen}{wert3}{zeilenende}"
    return ausgabe
```

```python
# Funktion mit verschiedenen Trennzeichen aufrufen
mehrere_werte_ausgeben("Python", "ist", "großartig", trennzeichen=" - ", zeilenende="!")
```

## Formatierte Ausgabe und f-Strings

### Grundlagen der f-Strings (ab Python 3.6)

- f-Strings ermöglichen einfache Formatierung durch Einbetten von Ausdrücken in geschweifte Klammern
- Syntax: `f"Text {ausdruck}"`
- Sehr lesbar und effizient

```python
def personendaten_formatieren(name, alter, größe):
    """
    Formatiert Personendaten mit f-Strings.
    
    Args:
        name: Name der Person
        alter: Alter der Person
        größe: Körpergröße in Metern
        
    Returns:
        Formatierte Personendaten als String
    """
    formatierte_daten = f"Name: {name}, Alter: {alter} Jahre, Größe: {größe:.2f} m"
    return formatierte_daten
```

```python
# Funktion für Personendaten mit f-Strings aufrufen
personendaten_formatieren("Max Mustermann", 30, 1.75)
```

### Zahlenformatierung in f-Strings

- Zahlenformatierung durch Angabe von `:formatierungsangabe` innerhalb der geschweiften Klammern
- Beispiele: `:d` für Ganzzahlen, `:.2f` für Gleitkommazahlen mit 2 Nachkommastellen

```python
def zahlen_formatieren(ganzzahl, gleitkommazahl, prozentsatz):
    """
    Formatiert verschiedene Zahlentypen mit f-Strings.
    
    Args:
        ganzzahl: Eine Ganzzahl
        gleitkommazahl: Eine Gleitkommazahl
        prozentsatz: Ein Prozentwert (als Dezimalzahl)
        
    Returns:
        Formatierte Zahlen als String
    """
    formatierung = (
        f"Ganzzahl: {ganzzahl:d}\n"
        f"Gleitkommazahl mit 3 Nachkommastellen: {gleitkommazahl:.3f}\n"
        f"Prozentsatz: {prozentsatz:.1%}"
    )
    return formatierung
```

```python
# Funktion für Zahlenformatierung aufrufen
zahlen_formatieren(42, 3.14159, 0.756)
```

### Ausrichtung und Breite in f-Strings

- Textausrichtung durch Angabe von `:<`, `:>` oder `:^` für links-, rechts- oder zentrierte Ausrichtung
- Feldbreite durch Angabe einer Zahl vor dem Ausrichtungszeichen festlegen

```python
def tabellendaten_formatieren(spalte1, spalte2, spalte3):
    """
    Formatiert Tabellendaten mit fester Breite und Ausrichtung.
    
    Args:
        spalte1, spalte2, spalte3: Inhalte der Tabellenspalten
        
    Returns:
        Formatierte Tabellendaten als String
    """
    header = f"{'PRODUKT':<15}{'PREIS':^10}{'MENGE':>8}"
    trennlinie = "-" * 33
    zeile = f"{spalte1:<15}{spalte2:^10.2f}{spalte3:>8d}"
    
    tabelle = f"{header}\n{trennlinie}\n{zeile}"
    return tabelle
```

```python
# Funktion für Tabellenformatierung aufrufen
tabellendaten_formatieren("Laptop", 899.99, 5)
```

### Ältere Formatierungsmethoden

- String-Methode `format()`: `"Name: {}, Alter: {}".format(name, alter)`
- %-Formatierung (veraltet): `"Name: %s, Alter: %d" % (name, alter)`

```python
def alternative_formatierungen(name, alter):
    """
    Demonstriert alternative Formatierungsmethoden.
    
    Args:
        name: Name der Person
        alter: Alter der Person
        
    Returns:
        Verschiedene Formatierungen als String
    """
    format_methode = "Name: {}, Alter: {}".format(name, alter)
    format_benannt = "Name: {n}, Alter: {a}".format(n=name, a=alter)
    prozent_formatierung = "Name: %s, Alter: %d" % (name, alter)
    
    ergebnis = (
        f"format()-Methode: {format_methode}\n"
        f"Benannte Parameter: {format_benannt}\n"
        f"%-Formatierung: {prozent_formatierung}"
    )
    return ergebnis
```

```python
# Funktion für alternative Formatierungen aufrufen
alternative_formatierungen("Anna Schmidt", 25)
```

## Funktionen für Ein- und Ausgabeoperationen

### Wiederverwendbare Eingabefunktionen

- Funktionen für Eingaben erhöhen die Wiederverwendbarkeit und Wartbarkeit
- Eingabevalidierung kann direkt in die Funktion integriert werden

```python
def zahl_einlesen(prompt, min_wert=None, max_wert=None):
    """
    Liest eine Zahl ein und validiert, ob sie im angegebenen Bereich liegt.
    
    Args:
        prompt: Eingabeaufforderung
        min_wert: Minimaler gültiger Wert (optional)
        max_wert: Maximaler gültiger Wert (optional)
        
    Returns:
        Eingelesene und validierte Zahl
    """
    while True:
        try:
            eingabe = input(prompt)
            zahl = float(eingabe)
            
            if min_wert is not None and zahl < min_wert:
                raise ValueError(f"Eingabe muss mindestens {min_wert} sein.")
            if max_wert is not None and zahl > max_wert:
                raise ValueError(f"Eingabe darf höchstens {max_wert} sein.")
                
            return zahl
        except ValueError as e:
            fehler_text = f"Ungültige Eingabe: {str(e)}"
            return f"Diese Funktion würde normalerweise erneut nachfragen. Für dieses Beispiel wird nur der Fehler zurückgegeben: {fehler_text}"
```

```python
# Funktion für validierte Zahleneingabe aufrufen
# Hier wird ein Wert außerhalb des gültigen Bereichs übergeben, um den Fehlerfall zu demonstrieren
zahl_einlesen("Bitte Wert zwischen 1 und 10 eingeben: ", min_wert=1, max_wert=10)
```

### Generische Ausgabefunktionen

- Wiederverwendbare Funktionen für konsistente Formatierung
- Nützlich für häufig wiederkehrende Ausgabeformate

```python
def fehler_ausgeben(fehlermeldung):
    """
    Gibt eine Fehlermeldung in einheitlichem Format aus.
    
    Args:
        fehlermeldung: Die auszugebende Fehlermeldung
        
    Returns:
        Formatierte Fehlermeldung als String
    """
    return f"FEHLER: {fehlermeldung}"
```

```python
# Funktion für Fehlerausgabe aufrufen
fehler_ausgeben("Datei konnte nicht geöffnet werden")
```

```python
def ergebnis_ausgeben(titel, wert, einheit=""):
    """
    Gibt ein Ergebnis in einheitlichem Format aus.
    
    Args:
        titel: Beschreibung des Ergebnisses
        wert: Der auszugebende Wert
        einheit: Optionale Einheit (z.B. kg, m, €)
        
    Returns:
        Formatiertes Ergebnis als String
    """
    if einheit:
        return f"{titel}: {wert} {einheit}"
    else:
        return f"{titel}: {wert}"
```

```python
# Funktion für Ergebnisausgabe mit verschiedenen Parametern aufrufen
ergebnis_ausgeben("Gesamtpreis", 42.75, "€")
```

## Parameterübergabe und Rückgabewerte für Ein-/Ausgabefunktionen

### Parameter für Ein-/Ausgabefunktionen

- Eingabeparameter: Prompt-Text, Standardwerte, Validierungsgrenzen
- Ausgabeparameter: Daten, Formatierungsoptionen, Ausgabeziel

```python
def daten_eingabe_und_validierung(prompt, datentyp, validierungsfunktion=None, fehler_nachricht=None):
    """
    Generische Funktion für Dateneingabe mit Typkonvertierung und benutzerdefinierter Validierung.
    
    Args:
        prompt: Eingabeaufforderung
        datentyp: Zielfunktion für Typkonvertierung (int, float, str, etc.)
        validierungsfunktion: Optionale Funktion zur Datenvalidierung
        fehler_nachricht: Benutzerdefinierte Fehlermeldung
        
    Returns:
        Konvertierte und validierte Eingabe oder Fehlermeldung
    """
    try:
        # In einem realen Szenario würde hier ein input() stehen
        # Für dieses Beispiel wird ein simulierter Wert verwendet
        eingabe = "42"  # Simulierte Eingabe
        
        konvertierter_wert = datentyp(eingabe)
        
        if validierungsfunktion and not validierungsfunktion(konvertierter_wert):
            if fehler_nachricht:
                return f"Validierungsfehler: {fehler_nachricht}"
            else:
                return "Validierungsfehler: Eingabe entspricht nicht den Anforderungen"
        
        return konvertierter_wert
    except Exception as e:
        return f"Fehler bei der Eingabe: {str(e)}"
```

```python
# Funktion mit benutzerdefinierter Validierungsfunktion aufrufen
# Die Lambda-Funktion prüft, ob der Wert gerade ist
daten_eingabe_und_validierung("Bitte gerade Zahl eingeben: ", int, lambda x: x % 2 == 0, "Bitte nur gerade Zahlen eingeben")
```

### Komplexe Rückgabewerte

- Rückgabe von Tupeln oder Dictionaries für mehrere Informationen
- Ermöglicht die Rückgabe von sowohl Daten als auch Status-/Fehlerinformationen

```python
def formular_eingabe():
    """
    Simuliert die Eingabe eines Formulars und gibt die Daten als Dictionary zurück.
    
    Returns:
        Dictionary mit Formulardaten und Statuscode
    """
    # In einem realen Szenario würden hier mehrere input()-Aufrufe stehen
    # Für dieses Beispiel werden simulierte Werte verwendet
    
    # Simulierte Eingaben
    name = "Max Mustermann"
    email = "max@example.com"
    alter = 30
    
    # Validierung (vereinfacht)
    fehler = []
    if "@" not in email:
        fehler.append("E-Mail muss ein @-Zeichen enthalten")
    if alter < 18:
        fehler.append("Mindestalter ist 18 Jahre")
    
    # Ergebnis zusammenstellen
    ergebnis = {
        "daten": {
            "name": name,
            "email": email,
            "alter": alter
        },
        "status": "fehler" if fehler else "erfolg",
        "fehler": fehler
    }
    
    return ergebnis
```

```python
# Funktion für Formulareingabe aufrufen
formular_eingabe()
```

### Callback-Funktionen für Ein-/Ausgabe

- Übergabe von Callback-Funktionen für flexible Formatierung
- Ermöglicht anpassbare Darstellung ohne Änderung der Hauptfunktion

```python
def daten_verarbeiten_und_ausgeben(daten, format_funktion):
    """
    Verarbeitet Daten und gibt sie mit einer benutzerdefinierten Formatierungsfunktion aus.
    
    Args:
        daten: Zu verarbeitende Daten (Liste oder Dictionary)
        format_funktion: Callback-Funktion zur Formatierung der Daten
        
    Returns:
        Formatierte Ausgabe als String
    """
    ergebnis = []
    
    if isinstance(daten, list):
        for element in daten:
            ergebnis.append(format_funktion(element))
    elif isinstance(daten, dict):
        for schlüssel, wert in daten.items():
            ergebnis.append(format_funktion(schlüssel, wert))
    
    return "\n".join(ergebnis)
```

```python
# Funktion mit einer einfachen Formatierungsfunktion für Listen aufrufen
produkte = ["Laptop", "Smartphone", "Tablet"]
daten_verarbeiten_und_ausgeben(produkte, lambda x: f"Produkt: {x}")
```

```python
# Funktion mit einer Formatierungsfunktion für ein Dictionary aufrufen
preise = {"Laptop": 899.99, "Smartphone": 499.99, "Tablet": 299.99}
daten_verarbeiten_und_ausgeben(preise, lambda k, v: f"{k}: {v:.2f} €")
```

## Übungen und Aufgaben

### Übung 1: Temperaturumrechner

Erstellen Sie eine Funktion, die Temperaturen zwischen Celsius und Fahrenheit umrechnet. Die Funktion soll:
- Eine Temperatur und die Ausgangseinheit als Parameter akzeptieren
- Die Temperatur in die jeweils andere Einheit umrechnen
- Das Ergebnis formatiert zurückgeben

```python
def temperatur_umrechnen(temperatur, einheit):
    """
    Rechnet Temperaturen zwischen Celsius und Fahrenheit um.
    
    Args:
        temperatur: Temperaturwert als Zahl
        einheit: 'C' für Celsius oder 'F' für Fahrenheit
        
    Returns:
        Dictionary mit umgerechneter Temperatur und Formel
    """
    if einheit.upper() == 'C':
        # Celsius zu Fahrenheit
        ergebnis = temperatur * 9/5 + 32
        formel = f"{temperatur}°C * 9/5 + 32 = {ergebnis:.2f}°F"
        return {"wert": ergebnis, "einheit": "°F", "formel": formel}
    
    elif einheit.upper() == 'F':
        # Fahrenheit zu Celsius
        ergebnis = (temperatur - 32) * 5/9
        formel = f"({temperatur}°F - 32) * 5/9 = {ergebnis:.2f}°C"
        return {"wert": ergebnis, "einheit": "°C", "formel": formel}
    
    else:
        return {"fehler": f"Ungültige Einheit: {einheit}. Bitte 'C' oder 'F' verwenden."}
```

### Aufgabe 1: Temperaturumrechner implementieren

Implementieren Sie die obige Funktion und testen Sie sie mit verschiedenen Werten.

```python
# Temperaturumrechner mit Celsius als Eingabe testen
temperatur_umrechnen(20, 'C')
```

```python
# Temperaturumrechner mit Fahrenheit als Eingabe testen
temperatur_umrechnen(68, 'F')
```

### Übung 2: Textanalysator

Erstellen Sie eine Funktion, die einen Text analysiert und verschiedene Statistiken zurückgibt.

```python
def text_analysieren(text):
    """
    Analysiert einen Text und gibt Statistiken zurück.
    
    Args:
        text: Zu analysierender Text
        
    Returns:
        Dictionary mit Textstatistiken
    """
    if not text:
        return {"fehler": "Kein Text zur Analyse übergeben"}
    
    # Anzahl der Zeichen
    zeichen_anzahl = len(text)
    
    # Anzahl der Wörter (vereinfacht)
    wörter = text.split()
    wörter_anzahl = len(wörter)
    
    # Anzahl der Sätze (vereinfacht)
    sätze = text.replace('!', '.').replace('?', '.').split('.')
    sätze_anzahl = len([s for s in sätze if s.strip()])
    
    # Durchschnittliche Wortlänge
    durchschnittliche_wortlänge = sum(len(wort) for wort in wörter) / wörter_anzahl if wörter_anzahl > 0 else 0
    
    # Häufigste Wörter (Top 3)
    wort_häufigkeit = {}
    for wort in wörter:
        wort_normalisiert = wort.lower().strip('.,!?;:()"\'')
        if wort_normalisiert and len(wort_normalisiert) > 2:  # Ignoriere kurze Wörter
            wort_häufigkeit[wort_normalisiert] = wort_häufigkeit.get(wort_normalisiert, 0) + 1
    
    häufigste_wörter = sorted(wort_häufigkeit.items(), key=lambda x: x[1], reverse=True)[:3]
    
    return {
        "zeichen": zeichen_anzahl,
        "wörter": wörter_anzahl,
        "sätze": sätze_anzahl,
        "durchschnittliche_wortlänge": f"{durchschnittliche_wortlänge:.2f}",
        "häufigste_wörter": häufigste_wörter
    }
```

### Aufgabe 2: Textanalysator implementieren

Implementieren Sie die obige Funktion und testen Sie sie mit einem Beispieltext.

```python
# Textanalysator mit einem Beispieltext testen
beispieltext = "Python ist eine vielseitige Programmiersprache. Sie ist einfach zu erlernen und dennoch sehr mächtig. Python wird in vielen Bereichen eingesetzt, von Webentwicklung bis hin zu Datenanalyse und künstlicher Intelligenz."
text_analysieren(beispieltext)
```

### Übung 3: Interaktiver Taschenrechner

Erstellen Sie eine Funktion für einen einfachen Taschenrechner, der zwei Zahlen und eine Operation entgegennimmt.

```python
def taschenrechner(zahl1, zahl2, operation):
    """
    Führt eine mathematische Operation mit zwei Zahlen durch.
    
    Args:
        zahl1: Erste Zahl
        zahl2: Zweite Zahl
        operation: '+', '-', '*', '/' oder '%'
        
    Returns:
        Dictionary mit Ergebnis und ausgeführter Operation
    """
    operationen = {
        '+': lambda x, y: x + y,
        '-': lambda x, y: x - y,
        '*': lambda x, y: x * y,
        '/': lambda x, y: x / y if y != 0 else "Division durch Null nicht möglich",
        '%': lambda x, y: x % y if y != 0 else "Modulo durch Null nicht möglich"
    }
    
    if operation not in operationen:
        return {
            "fehler": f"Ungültige Operation: {operation}",
            "gültige_operationen": list(operationen.keys())
        }
    
    try:
        ergebnis = operationen[operation](zahl1, zahl2)
        return {
            "operation": f"{zahl1} {operation} {zahl2}",
            "ergebnis": ergebnis
        }
    except Exception as e:
        return {"fehler": str(e)}
```

### Aufgabe 3: Taschenrechner implementieren

Implementieren Sie den Taschenrechner und testen Sie ihn mit verschiedenen Operationen.

```python
# Taschenrechner mit Addition testen
taschenrechner(10, 5, '+')
```

```python
# Taschenrechner mit Division testen
taschenrechner(10, 5, '/')
```

```python
# Taschenrechner mit Division durch Null testen
taschenrechner(10, 0, '/')
```

### Übung 4: Dateiexport-Simulator

Erstellen Sie eine Funktion, die Daten in verschiedenen Formaten "exportieren" kann.

```python
def daten_exportieren(daten, format_typ):
    """
    Simuliert den Export von Daten in verschiedene Formate.
    
    Args:
        daten: Zu exportierende Daten (Liste oder Dictionary)
        format_typ: 'csv', 'json' oder 'text'
        
    Returns:
        Formatierte Daten als String im gewünschten Format
    """
    if format_typ.lower() == 'csv':
        if isinstance(daten, list) and all(isinstance(item, dict) for item in daten):
            # Liste von Dictionaries in CSV umwandeln
            if not daten:
                return "Keine Daten zum Exportieren"
            
            headers = daten[0].keys()
            csv_zeilen = [','.join(headers)]
            
            for eintrag in daten:
                zeile = ','.join(str(eintrag.get(header, '')) for header in headers)
                csv_zeilen.append(zeile)
            
            return '\n'.join(csv_zeilen)
        else:
            return "Fehler: Für CSV-Export wird eine Liste von Dictionaries benötigt"
    
    elif format_typ.lower() == 'json':
        # Vereinfachte JSON-Darstellung
        if isinstance(daten, dict):
            json_einträge = [f'  "{k}": "{v}"' for k, v in daten.items()]
            return "{\n" + ",\n".join(json_einträge) + "\n}"
        elif isinstance(daten, list):
            json_einträge = [f'  {str(item).replace("\'", "\"")}' for item in daten]
            return "[\n" + ",\n".join(json_einträge) + "\n]"
        else:
            return f'"{daten}"'
    
    elif format_typ.lower() == 'text':
        if isinstance(daten, dict):
            return '\n'.join([f"{k}: {v}" for k, v in daten.items()])
        elif isinstance(daten, list):
            return '\n'.join([str(item) for item in daten])
        else:
            return str(daten)
    
    else:
        return f"Fehler: Unbekanntes Format '{format_typ}'. Unterstützte Formate: csv, json, text"
```

### Aufgabe 4: Dateiexport implementieren

Implementieren Sie die Exportfunktion und testen Sie sie mit verschiedenen Datentypen und Formaten.

```python
# Dateiexport mit einer Liste von Dictionaries im CSV-Format testen
personen = [
    {"name": "Max", "alter": 30, "stadt": "Berlin"},
    {"name": "Anna", "alter": 25, "stadt": "München"},
    {"name": "Tom", "alter": 35, "stadt": "Hamburg"}
]
daten_exportieren(personen, 'csv')
```

```python
# Dateiexport mit einem Dictionary im JSON-Format testen
person = {"name": "Max", "alter": 30, "stadt": "Berlin"}
daten_exportieren(person, 'json')
```

---

## Weiterführende Informationen

- [Python Dokumentation: input() und print()](https://docs.python.org/3/library/functions.html#input)
- [Python Dokumentation: f-Strings](https://docs.python.org/3/reference/lexical_analysis.html#f-strings)
- [PEP 498 – Literal String Interpolation](https://peps.python.org/pep-0498/)
- [RealPython: Python 3's f-Strings](https://realpython.com/python-f-strings/)
- [Python Dokumentation: String-Formatierung](https://docs.python.org/3/library/string.html#formatstrings)
