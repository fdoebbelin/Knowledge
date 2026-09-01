## Einführung in das Debugging

**Debugging** ist eine der wichtigsten Fertigkeiten eines jeden Python-Entwicklers. Es bezeichnet den systematischen Prozess der Identifikation, Analyse und Behebung von Fehlern (Bugs) in Programmen. Das Wort "Debug" stammt aus den Anfängen der Computertechnik, als Grace Hopper tatsächlich einen Käfer (Bug) aus einem Computer entfernte, der Fehlfunktionen verursachte.

Debugging ist weit mehr als nur das Auffinden von Syntax-Fehlern - es umfasst das Verstehen des Programmflusses, die Analyse von Datenstrukturen und die systematische Eingrenzung problematischer Codestellen. Besonders in der objektorientierten Programmierung mit Funktionen und Klassen wird strukturiertes Debugging zu einer unverzichtbaren Kompetenz.

## Arten von Fehlern in Python

### Syntax-Fehler (SyntaxError)

Syntax-Fehler treten auf, wenn der Python-Parser den Code nicht interpretieren kann. Diese Fehler werden bereits vor der Ausführung erkannt:

```python
def gruesse_benutzer():
    print("Hallo Welt"  # Fehlende schließende Klammer
    
# SyntaxError: unexpected EOF while parsing
```

```python
def berechne_summe(a, b):
    if a > b
        return a + b  # Fehlender Doppelpunkt nach if
    return b + a

# SyntaxError: invalid syntax
```


### Laufzeit-Fehler (Runtime Errors)

Diese Fehler treten während der Programmausführung auf und führen zu Exceptions:

```python
def teile_zahlen(dividend, divisor):
    """Demonstriert ZeroDivisionError"""
    try:
        ergebnis = dividend / divisor
        return ergebnis
    except ZeroDivisionError as e:
        print(f"Fehler: Division durch Null - {e}")
        return None

# Demonstriere verschiedene Laufzeit-Fehler
def demonstriere_laufzeit_fehler():
    # ZeroDivisionError
    print("Test 1: Division durch Null")
    print(teile_zahlen(10, 0))
    
    # TypeError
    try:
        print("Test 2: Falsche Datentypen")
        ergebnis = "Text" + 5
    except TypeError as e:
        print(f"TypeError: {e}")
    
    # IndexError
    try:
        print("Test 3: Index außerhalb des Bereichs")
        liste = [1, 2, 3]
        print(liste)
    except IndexError as e:
        print(f"IndexError: {e}")
    
    # KeyError
    try:
        print("Test 4: Nicht existierender Dictionary-Schlüssel")
        person = {"name": "Anna", "alter": 25}
        print(person["beruf"])
    except KeyError as e:
        print(f"KeyError: {e}")

demonstriere_laufzeit_fehler()
```


### Logische Fehler

Diese Fehler sind am schwierigsten zu finden, da das Programm läuft, aber nicht das gewünschte Ergebnis liefert:

```python
def berechne_durchschnitt(zahlen_liste):
    """Beispiel eines logischen Fehlers"""
    summe = 0
    for zahl in zahlen_liste:
        summe += zahl
    # FEHLER: Division durch len(zahlen_liste) vergessen
    return summe  # Sollte: return summe / len(zahlen_liste)

def korrekte_durchschnitt_berechnung(zahlen_liste):
    """Korrigierte Version"""
    if not zahlen_liste:  # Zusätzliche Validierung
        return 0
    
    summe = sum(zahlen_liste)
    return summe / len(zahlen_liste)

# Test beider Funktionen
test_zahlen = [2, 4, 6, 8, 10]
print(f"Fehlerhafte Berechnung: {berechne_durchschnitt(test_zahlen)}")
print(f"Korrekte Berechnung: {korrekte_durchschnitt_berechnung(test_zahlen)}")
```


## Print-Debugging: Die Grundtechnik

Print-Debugging ist die einfachste und am häufigsten verwendete Debugging-Technik. Sie eignet sich besonders gut für Anfänger und bei einfachen Problemen:

### Grundlegendes Print-Debugging

```python
def fibonacci_mit_debug(n):
    """Fibonacci-Berechnung mit Print-Debug-Ausgaben"""
    print(f"DEBUG: fibonacci_mit_debug aufgerufen mit n={n}")
    
    if n <= 0:
        print("DEBUG: n <= 0, gebe 0 zurück")
        return 0
    elif n == 1:
        print("DEBUG: n == 1, gebe 1 zurück")
        return 1
    else:
        print(f"DEBUG: Berechne fibonacci({n-1}) + fibonacci({n-2})")
        fib_n1 = fibonacci_mit_debug(n-1)
        fib_n2 = fibonacci_mit_debug(n-2)
        ergebnis = fib_n1 + fib_n2
        print(f"DEBUG: fibonacci({n}) = {fib_n1} + {fib_n2} = {ergebnis}")
        return ergebnis

# Test der Debug-Version
print("=== Fibonacci mit Debug ===")
print(f"Ergebnis: {fibonacci_mit_debug(5)}")
```


### Erweiterte Print-Debug-Techniken

```python
import inspect
from datetime import datetime

def debug_print(*args, **kwargs):
    """Erweiterte Debug-Funktion mit Zeitstempel und Funktionskontext"""
    frame = inspect.currentframe().f_back
    function_name = frame.f_code.co_name
    line_number = frame.f_lineno
    timestamp = datetime.now().strftime("%H:%M:%S.%f")[:-3]
    
    print(f"[DEBUG {timestamp}] {function_name}:{line_number} -", *args, **kwargs)

def komplexe_berechnung(daten):
    """Beispiel für erweiterte Debug-Ausgaben"""
    debug_print(f"Starte Berechnung mit {len(daten)} Elementen")
    
    ergebnis = []
    for i, element in enumerate(daten):
        debug_print(f"Verarbeite Element {i}: {element}")
        
        if isinstance(element, (int, float)):
            verarbeitet = element ** 2
            debug_print(f"Quadrat von {element} = {verarbeitet}")
        else:
            verarbeitet = len(str(element))
            debug_print(f"Länge von '{element}' = {verarbeitet}")
            
        ergebnis.append(verarbeitet)
    
    debug_print(f"Berechnung abgeschlossen: {ergebnis}")
    return ergebnis

# Test der erweiterten Debug-Funktion
test_daten = [1, 2, "Hallo", 3.5, "Welt"]
komplexe_berechnung(test_daten)
```


## Funktionen als Debug-Einheiten

Funktionen bieten natürliche Debugging-Grenzen und erleichtern die Fehlereingrenzung erheblich:

### Debug-freundliche Funktionsgestaltung

```python
def validiere_eingabe(wert, datentyp=int, min_wert=None, max_wert=None):
    """Debug-freundliche Validierungsfunktion"""
    print(f"DEBUG: Validiere {wert} (Typ: {type(wert).__name__})")
    
    # Typ-Validierung
    try:
        konvertierter_wert = datentyp(wert)
        print(f"DEBUG: Erfolgreich zu {datentyp.__name__} konvertiert: {konvertierter_wert}")
    except (ValueError, TypeError) as e:
        print(f"DEBUG: Konvertierung fehlgeschlagen: {e}")
        return False, f"Kann nicht zu {datentyp.__name__} konvertiert werden"
    
    # Bereichs-Validierung
    if min_wert is not None and konvertierter_wert < min_wert:
        print(f"DEBUG: Wert {konvertierter_wert} < Minimum {min_wert}")
        return False, f"Wert muss >= {min_wert} sein"
    
    if max_wert is not None and konvertierter_wert > max_wert:
        print(f"DEBUG: Wert {konvertierter_wert} > Maximum {max_wert}")
        return False, f"Wert muss <= {max_wert} sein"
    
    print(f"DEBUG: Validierung erfolgreich")
    return True, konvertierter_wert

def sichere_division(dividend, divisor):
    """Demonstriert schrittweise Validierung und Debugging"""
    print(f"DEBUG: sichere_division({dividend}, {divisor})")
    
    # Validiere Dividend
    valid_dividend, dividend_wert = validiere_eingabe(dividend, float)
    if not valid_dividend:
        return None, f"Dividend ungültig: {dividend_wert}"
    
    # Validiere Divisor
    valid_divisor, divisor_wert = validiere_eingabe(divisor, float)
    if not valid_divisor:
        return None, f"Divisor ungültig: {divisor_wert}"
    
    # Prüfe Division durch Null
    if divisor_wert == 0:
        print("DEBUG: Division durch Null erkannt")
        return None, "Division durch Null nicht erlaubt"
    
    # Führe Division durch
    ergebnis = dividend_wert / divisor_wert
    print(f"DEBUG: {dividend_wert} / {divisor_wert} = {ergebnis}")
    
    return ergebnis, "Erfolg"

# Test der Debug-freundlichen Funktionen
print("=== Test sichere Division ===")
test_fälle = [
    (10, 2),
    ("15", "3"),
    (20, 0),
    ("abc", 5),
    (100, "xyz")
]

for dividend, divisor in test_fälle:
    print(f"\n--- Test: {dividend} / {divisor} ---")
    ergebnis, nachricht = sichere_division(dividend, divisor)
    if ergebnis is not None:
        print(f"Ergebnis: {ergebnis}")
    else:
        print(f"Fehler: {nachricht}")
```


### Funktions-Profiling für Debugging

```python
import time
import functools

def debug_timing(func):
    """Decorator für Ausführungszeitanalyse"""
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time.time()
        print(f"DEBUG: Starte {func.__name__} um {time.strftime('%H:%M:%S')}")
        
        try:
            ergebnis = func(*args, **kwargs)
            end_time = time.time()
            duration = end_time - start_time
            print(f"DEBUG: {func.__name__} erfolgreich in {duration:.4f}s")
            return ergebnis
        except Exception as e:
            end_time = time.time()
            duration = end_time - start_time
            print(f"DEBUG: {func.__name__} fehlgeschlagen nach {duration:.4f}s: {e}")
            raise
    
    return wrapper

def debug_arguments(func):
    """Decorator für Argument-Logging"""
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        print(f"DEBUG: {func.__name__} aufgerufen mit:")
        print(f"  args: {args}")
        print(f"  kwargs: {kwargs}")
        
        ergebnis = func(*args, **kwargs)
        print(f"DEBUG: {func.__name__} gibt zurück: {ergebnis}")
        return ergebnis
    
    return wrapper

@debug_timing
@debug_arguments
def langsame_berechnung(n, faktor=1):
    """Simuliert eine zeitaufwändige Berechnung"""
    time.sleep(0.1)  # Simuliere Verarbeitungszeit
    ergebnis = sum(i * faktor for i in range(n))
    return ergebnis

# Test der Debug-Decorators
print("=== Test Debug-Decorators ===")
ergebnis = langsame_berechnung(1000, faktor=2)
print(f"Endergebnis: {ergebnis}")
```


## Klassen als Debug-Einheiten

In der objektorientierten Programmierung bieten Klassen strukturierte Debugging-Möglichkeiten:

### Debug-fähige Klassengestaltung

```python
class DebugFahrzeug:
    """Beispielklasse mit integriertem Debugging"""
    
    def __init__(self, marke, modell, baujahr):
        self._debug_enabled = True
        self._debug_log = []
        
        self._debug(f"Erstelle Fahrzeug: {marke} {modell} ({baujahr})")
        
        self.marke = marke
        self.modell = modell
        self.baujahr = baujahr
        self.kilometerstand = 0
        self.tank_inhalt = 50  # Liter
        self.verbrauch_pro_100km = 7  # Liter/100km
        
        self._debug("Fahrzeug erfolgreich erstellt")
    
    def _debug(self, nachricht):
        """Interne Debug-Methode"""
        if self._debug_enabled:
            timestamp = datetime.now().strftime("%H:%M:%S")
            debug_msg = f"[{timestamp}] {self.__class__.__name__}: {nachricht}"
            print(debug_msg)
            self._debug_log.append(debug_msg)
    
    def fahren(self, kilometer):
        """Fahrzeug bewegen mit Debug-Informationen"""
        self._debug(f"Fahre {kilometer} km (aktueller Stand: {self.kilometerstand} km)")
        
        if kilometer < 0:
            self._debug("FEHLER: Negative Kilometer nicht erlaubt")
            raise ValueError("Kilometer müssen positiv sein")
        
        # Berechne Kraftstoffverbrauch
        verbrauch = (kilometer / 100) * self.verbrauch_pro_100km
        self._debug(f"Berechneter Verbrauch: {verbrauch:.2f} Liter")
        
        if verbrauch > self.tank_inhalt:
            self._debug(f"WARNUNG: Nicht genug Kraftstoff ({self.tank_inhalt:.2f}L verfügbar)")
            mögliche_km = (self.tank_inhalt / self.verbrauch_pro_100km) * 100
            self._debug(f"Maximale Reichweite: {mögliche_km:.1f} km")
            return False
        
        # Fahrt durchführen
        self.kilometerstand += kilometer
        self.tank_inhalt -= verbrauch
        
        self._debug(f"Fahrt erfolgreich - Neuer Stand: {self.kilometerstand} km, Tank: {self.tank_inhalt:.2f}L")
        return True
    
    def tanken(self, liter):
        """Fahrzeug tanken mit Debug-Informationen"""
        self._debug(f"Tanke {liter} Liter (aktueller Tankinhalt: {self.tank_inhalt:.2f}L)")
        
        if liter < 0:
            self._debug("FEHLER: Negative Literzahl nicht erlaubt")
            raise ValueError("Liter müssen positiv sein")
        
        max_tank = 60  # Maximale Tankkapazität
        if self.tank_inhalt + liter > max_tank:
            überschuss = (self.tank_inhalt + liter) - max_tank
            liter = max_tank - self.tank_inhalt
            self._debug(f"WARNUNG: Tank zu voll, tanke nur {liter:.2f}L ({überschuss:.2f}L Überschuss)")
        
        self.tank_inhalt += liter
        self._debug(f"Getankt - Neuer Tankinhalt: {self.tank_inhalt:.2f}L")
    
    def get_debug_log(self):
        """Gibt das komplette Debug-Log zurück"""
        return self._debug_log.copy()
    
    def set_debug(self, enabled):
        """Debug-Modus ein-/ausschalten"""
        self._debug_enabled = enabled
        if enabled:
            self._debug("Debug-Modus aktiviert")
    
    def __str__(self):
        return f"{self.marke} {self.modell} ({self.baujahr}) - {self.kilometerstand} km"

# Test der Debug-fähigen Klasse
print("=== Test DebugFahrzeug ===")
auto = DebugFahrzeug("BMW", "X5", 2020)

print("\n--- Fahrt 1 ---")
auto.fahren(150)

print("\n--- Fahrt 2 ---")
auto.fahren(200)

print("\n--- Tanken ---")
auto.tanken(30)

print("\n--- Fahrt 3 ---")
auto.fahren(500)  # Sollte fehlschlagen

print("\n--- Debug-Log anzeigen ---")
for log_entry in auto.get_debug_log():
    print(f"LOG: {log_entry}")
```


### Vererbung und Debugging

```python
class DebuggingMixin:
    """Mixin-Klasse für erweiterte Debugging-Funktionalität"""
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._debug_level = 1  # 0=aus, 1=info, 2=verbose
        self._debug_prefix = self.__class__.__name__
    
    def debug_info(self, nachricht):
        """Info-Level Debug-Nachricht"""
        if self._debug_level >= 1:
            print(f"[INFO] {self._debug_prefix}: {nachricht}")
    
    def debug_verbose(self, nachricht):
        """Verbose-Level Debug-Nachricht"""
        if self._debug_level >= 2:
            print(f"[VERBOSE] {self._debug_prefix}: {nachricht}")
    
    def set_debug_level(self, level):
        """Debug-Level setzen (0=aus, 1=info, 2=verbose)"""
        self._debug_level = level
        self.debug_info(f"Debug-Level auf {level} gesetzt")

class BankKonto(DebuggingMixin):
    """Bankkonto-Klasse mit Debugging"""
    
    def __init__(self, kontonummer, inhaber, anfangssaldo=0):
        super().__init__()
        self._debug_prefix = f"Konto-{kontonummer}"
        
        self.debug_info(f"Erstelle Konto für {inhaber}")
        
        self.kontonummer = kontonummer
        self.inhaber = inhaber
        self.saldo = anfangssaldo
        self.transaktionen = []
        
        self.debug_verbose(f"Konto erstellt - Saldo: {self.saldo}€")
    
    def einzahlen(self, betrag):
        """Geld einzahlen"""
        self.debug_info(f"Einzahlung: {betrag}€")
        
        if betrag <= 0:
            self.debug_info("FEHLER: Einzahlungsbetrag muss positiv sein")
            raise ValueError("Betrag muss positiv sein")
        
        alter_saldo = self.saldo
        self.saldo += betrag
        self.transaktionen.append(f"Einzahlung: +{betrag}€")
        
        self.debug_verbose(f"Saldo: {alter_saldo}€ -> {self.saldo}€")
        self.debug_info(f"Einzahlung erfolgreich - Neuer Saldo: {self.saldo}€")
    
    def auszahlen(self, betrag):
        """Geld auszahlen"""
        self.debug_info(f"Auszahlung: {betrag}€")
        
        if betrag <= 0:
            self.debug_info("FEHLER: Auszahlungsbetrag muss positiv sein")
            raise ValueError("Betrag muss positiv sein")
        
        if betrag > self.saldo:
            self.debug_info(f"FEHLER: Unzureichender Saldo ({self.saldo}€ verfügbar)")
            raise ValueError(f"Unzureichender Saldo. Verfügbar: {self.saldo}€")
        
        alter_saldo = self.saldo
        self.saldo -= betrag
        self.transaktionen.append(f"Auszahlung: -{betrag}€")
        
        self.debug_verbose(f"Saldo: {alter_saldo}€ -> {self.saldo}€")
        self.debug_info(f"Auszahlung erfolgreich - Neuer Saldo: {self.saldo}€")
    
    def kontostand_anzeigen(self):
        """Aktuellen Kontostand anzeigen"""
        self.debug_verbose("Kontostand abgerufen")
        return self.saldo

# Test der erweiterten Debug-Klasse
print("=== Test BankKonto mit Debugging ===")
konto = BankKonto("123456789", "Max Mustermann", 100)

print("\n--- Standard Debug-Level (1) ---")
konto.einzahlen(50)
konto.auszahlen(30)

print("\n--- Verbose Debug-Level (2) ---")
konto.set_debug_level(2)
konto.einzahlen(200)
konto.auszahlen(75)

print("\n--- Debug ausgeschaltet (0) ---")
konto.set_debug_level(0)
konto.einzahlen(25)
print(f"Finaler Kontostand: {konto.kontostand_anzeigen()}€")
```


## Systematische Fehlereingrenzung

Die systematische Herangehensweise an Debugging ist entscheidend für effizienten Code:

### Binary Search Debugging

```python
def binary_search_debug_demo():
    """Demonstriert systematische Fehlereingrenzung"""
    
    def komplexer_algorithmus(daten):
        """Algorithmus mit verstecktem Fehler"""
        print("DEBUG: Starte komplexen Algorithmus")
        
        # Schritt 1: Eingabevalidierung
        print(f"DEBUG: Schritt 1 - Validiere Eingabe: {len(daten)} Elemente")
        if not daten:
            return []
        
        # Schritt 2: Daten normalisieren
        print("DEBUG: Schritt 2 - Normalisiere Daten")
        normalisiert = []
        for i, wert in enumerate(daten):
            print(f"DEBUG: Normalisiere Element {i}: {wert}")
            if isinstance(wert, str):
                # FEHLER: Hier sollte len(wert) verwendet werden
                normalisiert.append(wert.count('a'))  # Fehlerhaft: zählt nur 'a'
            else:
                normalisiert.append(float(wert))
        
        print(f"DEBUG: Normalisierte Daten: {normalisiert}")
        
        # Schritt 3: Berechnungen
        print("DEBUG: Schritt 3 - Führe Berechnungen durch")
        ergebnisse = []
        for i, wert in enumerate(normalisiert):
            print(f"DEBUG: Berechne für Element {i}: {wert}")
            if wert > 0:
                berechnet = wert ** 2
            else:
                berechnet = 0
            ergebnisse.append(berechnet)
            print(f"DEBUG: Ergebnis für Element {i}: {berechnet}")
        
        print(f"DEBUG: Finale Ergebnisse: {ergebnisse}")
        return ergebnisse
    
    # Test mit problematischen Daten
    test_daten = ["hallo", "welt", "python", 5, 0, -3]
    print("=== Binary Search Debugging Demo ===")
    print(f"Eingabedaten: {test_daten}")
    
    ergebnis = komplexer_algorithmus(test_daten)
    print(f"Algorithmus-Ergebnis: {ergebnis}")
    
    # Erwartetes vs. tatsächliches Ergebnis analysieren
    print("\n=== Ergebnis-Analyse ===")
    expected = [25, 16, 36, 25, 0, 0]  # len(string)^2 für Strings
    actual = ergebnis
    
    print(f"Erwartet: {expected}")
    print(f"Tatsächlich: {actual}")
    
    for i, (exp, act) in enumerate(zip(expected, actual)):
        if exp != act:
            print(f"FEHLER bei Index {i}: erwartet {exp}, erhalten {act}")
            print(f"  Eingabe war: {test_daten[i]}")

binary_search_debug_demo()
```


### Debug-Hilfsfunktionen

```python
def debug_objektzustand(obj, titel="Objektzustand"):
    """Umfassende Debug-Ausgabe für Objekte"""
    print(f"\n=== {titel} ===")
    print(f"Typ: {type(obj).__name__}")
    print(f"String-Repräsentation: {str(obj)}")
    
    if hasattr(obj, '__dict__'):
        print("Attribute:")
        for attr, wert in obj.__dict__.items():
            print(f"  {attr}: {wert} ({type(wert).__name__})")
    
    print(f"Verfügbare Methoden: {[m for m in dir(obj) if not m.startswith('_')]}")

def debug_funktionsaufruf(func, *args, **kwargs):
    """Debug-Wrapper für Funktionsaufrufe"""
    print(f"\n=== Funktionsaufruf: {func.__name__} ===")
    print(f"Positionsargumente: {args}")
    print(f"Schlüsselwort-Argumente: {kwargs}")
    
    try:
        start_time = time.time()
        ergebnis = func(*args, **kwargs)
        end_time = time.time()
        
        print(f"Ausführungszeit: {end_time - start_time:.4f}s")
        print(f"Rückgabewert: {ergebnis} ({type(ergebnis).__name__})")
        return ergebnis
    
    except Exception as e:
        print(f"Exception aufgetreten: {type(e).__name__}: {e}")
        raise

# Beispiel für die Verwendung der Debug-Hilfsfunktionen
class TestKlasse:
    def __init__(self, name, wert):
        self.name = name
        self.wert = wert
        self.liste = [1, 2, 3]
    
    def verdopple_wert(self):
        return self.wert * 2

print("=== Test Debug-Hilfsfunktionen ===")
test_obj = TestKlasse("Testobjekt", 42)
debug_objektzustand(test_obj, "Neues Objekt")

ergebnis = debug_funktionsaufruf(test_obj.verdopple_wert)
print(f"Funktionsergebnis: {ergebnis}")
```


## Praxisbeispiele aus den Kursprojekten

### Debugging im Py2Rust-Projekt

```python
class ProjectLoaderDebug:
    """Debugging-Version des ProjectLoaders aus dem Py2Rust-Projekt"""
    
    def __init__(self, pfad):
        self.pfad = pfad
        self.files = []
        self.debug_enabled = True
    
    def _debug(self, nachricht):
        if self.debug_enabled:
            print(f"[ProjectLoader] {nachricht}")
    
    def load_files(self):
        """Lädt Python-Dateien mit detailliertem Debugging"""
        import os
        
        self._debug(f"Starte Laden von Dateien aus: {self.pfad}")
        
        if not os.path.exists(self.pfad):
            self._debug(f"FEHLER: Pfad existiert nicht: {self.pfad}")
            raise FileNotFoundError(f"Pfad nicht gefunden: {self.pfad}")
        
        if not os.path.isdir(self.pfad):
            self._debug(f"FEHLER: Pfad ist kein Verzeichnis: {self.pfad}")
            raise NotADirectoryError(f"Kein Verzeichnis: {self.pfad}")
        
        datei_count = 0
        for root, dirs, files in os.walk(self.pfad):
            self._debug(f"Durchsuche Verzeichnis: {root}")
            self._debug(f"  Unterverzeichnisse: {dirs}")
            self._debug(f"  Dateien gefunden: {len(files)}")
            
            for file in files:
                self._debug(f"  Prüfe Datei: {file}")
                if file.endswith('.py'):
                    vollständiger_pfad = os.path.join(root, file)
                    self.files.append(vollständiger_pfad)
                    datei_count += 1
                    self._debug(f"    ✓ Python-Datei hinzugefügt: {vollständiger_pfad}")
                else:
                    self._debug(f"    ✗ Übersprungen (keine .py-Datei): {file}")
        
        self._debug(f"Laden abgeschlossen: {datei_count} Python-Dateien gefunden")
        return self.files

# Test des Debug-ProjectLoaders
import tempfile
import os

# Erstelle temporäre Teststruktur
with tempfile.TemporaryDirectory() as temp_dir:
    # Erstelle Testdateien
    test_files = {
        "main.py": "print('Hello World')",
        "utils.py": "def helper(): pass",
        "data.txt": "Keine Python-Datei",
        "subdir/module.py": "class TestClass: pass"
    }
    
    for datei_pfad, inhalt in test_files.items():
        vollständiger_pfad = os.path.join(temp_dir, datei_pfad)
        os.makedirs(os.path.dirname(vollständiger_pfad), exist_ok=True)
        with open(vollständiger_pfad, 'w') as f:
            f.write(inhalt)
    
    # Test der Debug-Version
    print("=== Test ProjectLoaderDebug ===")
    loader = ProjectLoaderDebug(temp_dir)
    gefundene_dateien = loader.load_files()
    
    print(f"\nFazit: {len(gefundene_dateien)} Python-Dateien gefunden:")
    for datei in gefundene_dateien:
        print(f"  - {os.path.relpath(datei, temp_dir)}")
```
