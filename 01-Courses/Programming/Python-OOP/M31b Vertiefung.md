## Was ist fortgeschrittenes Debugging?

Fortgeschrittenes Debugging geht über das einfache Verwenden von `print()`-Anweisungen hinaus und nutzt professionelle Debugging-Werkzeuge und -Techniken. Diese Methoden ermöglichen es Entwicklern, Code systematisch zu analysieren, Fehlerquellen präzise zu lokalisieren und komplexe Programmabläufe zu verstehen. Das Modul 31 behandelt insbesondere den Python-Debugger `pdb`, Breakpoints und die schrittweise Code-Durchführung.

## Der Python Debugger (pdb)

### Grundlagen von pdb

Der Python Debugger (`pdb`) ist ein interaktives Debugging-Tool, das standardmäßig in Python verfügbar ist. Es ermöglicht die Untersuchung des Programmzustands während der Ausführung und bietet vollständige Kontrolle über den Programmfluss.

```python
import pdb

def fibonacci(n):
    """Berechnet die n-te Fibonacci-Zahl"""
    if n <= 1:
        return n
    
    # Debugger-Breakpoint setzen
    pdb.set_trace()
    
    return fibonacci(n-1) + fibonacci(n-2)

# Beispielaufruf
def main():
    print("Fibonacci-Berechnung mit Debugging")
    result = fibonacci(5)
    print(f"Ergebnis: {result}")

if __name__ == "__main__":
    main()
```


### pdb-Kommandos im Detail

Die wichtigsten pdb-Kommandos für die interaktive Debugging-Session:

```python
import pdb

class BankKonto:
    def __init__(self, inhaber, startguthaben=0):
        self.inhaber = inhaber
        self.guthaben = startguthaben
        self.transaktionen = []
    
    def einzahlen(self, betrag):
        pdb.set_trace()  # Debugging-Punkt
        if betrag > 0:
            self.guthaben += betrag
            self.transaktionen.append(f"Einzahlung: +{betrag}")
            return True
        return False
    
    def abheben(self, betrag):
        pdb.set_trace()  # Debugging-Punkt
        if betrag > 0 and betrag <= self.guthaben:
            self.guthaben -= betrag
            self.transaktionen.append(f"Abhebung: -{betrag}")
            return True
        return False
    
    def kontostand_anzeigen(self):
        print(f"Kontoinhaber: {self.inhaber}")
        print(f"Aktueller Kontostand: {self.guthaben:.2f}€")
        
        # Alle Transaktionen anzeigen
        if self.transaktionen:
            print("Letzte Transaktionen:")
            for transaktion in self.transaktionen[-5:]:  # Nur die letzten 5
                print(f"  - {transaktion}")

# Debugging-Demo
def banking_demo():
    konto = BankKonto("Max Mustermann", 100)
    
    print("=== Banking Demo mit Debugging ===")
    konto.kontostand_anzeigen()
    
    # Diese Operationen werden durch pdb unterbrochen
    konto.einzahlen(50)
    konto.abheben(25)
    konto.abheben(200)  # Sollte fehlschlagen
    
    konto.kontostand_anzeigen()

if __name__ == "__main__":
    banking_demo()
```

**Wichtige pdb-Kommandos:**

- `n` (next): Nächste Zeile ausführen
- `s` (step): In Funktionsaufrufe hineinspringen
- `c` (continue): Bis zum nächsten Breakpoint fortfahren
- `l` (list): Code um die aktuelle Position anzeigen
- `p <variable>`: Variablenwert ausgeben
- `pp <variable>`: Variablenwert schön formatiert ausgeben
- `w` (where): Aktuellen Call-Stack anzeigen
- `u` (up): Eine Ebene im Call-Stack nach oben
- `d` (down): Eine Ebene im Call-Stack nach unten
- `q` (quit): Debugger beenden


## Breakpoints setzen und verwalten

### Statische Breakpoints mit set_trace()

```python
import pdb

def komplexe_berechnung(daten):
    """Beispiel für komplexe Datenverarbeitung mit Debugging"""
    ergebnisse = []
    
    for i, wert in enumerate(daten):
        # Breakpoint vor kritischer Berechnung
        if i == 3:  # Nur beim 4. Element pausieren
            pdb.set_trace()
        
        # Komplexe Berechnungslogik
        if isinstance(wert, (int, float)):
            quadrat = wert ** 2
            wurzel = quadrat ** 0.5 if quadrat >= 0 else 0
            resultat = (quadrat + wurzel) / 2
            ergebnisse.append(resultat)
        else:
            ergebnisse.append(0)
    
    return ergebnisse

# Test mit verschiedenen Datentypen
test_daten = [1, 2.5, -3, 4, "invalid", 6.7, None, 8]
ergebnis = komplexe_berechnung(test_daten)
print(f"Endergebnis: {ergebnis}")
```


### Bedingte Breakpoints

```python
import pdb

def daten_verarbeitung(datenliste):
    """Demonstriert bedingte Breakpoints"""
    verarbeitete_daten = []
    fehlerhafte_eintraege = 0
    
    for index, eintrag in enumerate(datenliste):
        # Bedingter Breakpoint - nur bei problematischen Daten
        if eintrag is None or (isinstance(eintrag, str) and len(eintrag) == 0):
            pdb.set_trace()  # Pausiere bei None oder leeren Strings
        
        try:
            # Versuche Datenkonvertierung
            if isinstance(eintrag, str):
                numerischer_wert = float(eintrag)
            elif isinstance(eintrag, (int, float)):
                numerischer_wert = float(eintrag)
            else:
                raise ValueError(f"Unbekannter Datentyp: {type(eintrag)}")
            
            verarbeitete_daten.append(numerischer_wert * 2)
            
        except (ValueError, TypeError) as e:
            print(f"Fehler bei Index {index}: {e}")
            fehlerhafte_eintraege += 1
            verarbeitete_daten.append(0)  # Standardwert
    
    return verarbeitete_daten, fehlerhafte_eintraege

# Test mit problematischen Daten
test_daten = [1, "2.5", None, 4.0, "", "abc", 7, None]
result, errors = daten_verarbeitung(test_daten)
print(f"Verarbeitete Daten: {result}")
print(f"Anzahl Fehler: {errors}")
```


## Code schrittweise durchlaufen

### Debugging mit Step-by-Step Analyse

```python
import pdb

class WetterStation:
    def __init__(self, name, standort):
        self.name = name
        self.standort = standort
        self.messungen = []
        self.status = "aktiv"
    
    def messung_hinzufuegen(self, temperatur, luftfeuchtigkeit, luftdruck):
        """Fügt eine neue Wettermessung hinzu"""
        pdb.set_trace()  # Debugging-Punkt
        
        # Validierung der Eingangsdaten
        if not isinstance(temperatur, (int, float)):
            raise ValueError("Temperatur muss eine Zahl sein")
        
        if not (0 <= luftfeuchtigkeit <= 100):
            raise ValueError("Luftfeuchtigkeit muss zwischen 0 und 100 liegen")
        
        if luftdruck < 900 or luftdruck > 1100:
            print(f"Warnung: Ungewöhnlicher Luftdruck: {luftdruck} hPa")
        
        # Messung erstellen
        messung = {
            'temperatur': temperatur,
            'luftfeuchtigkeit': luftfeuchtigkeit,
            'luftdruck': luftdruck,
            'zeitstempel': len(self.messungen) + 1  # Vereinfacht
        }
        
        self.messungen.append(messung)
        return messung
    
    def durchschnittstemperatur(self):
        """Berechnet die Durchschnittstemperatur"""
        pdb.set_trace()  # Debugging-Punkt
        
        if not self.messungen:
            return None
        
        temperaturen = [m['temperatur'] for m in self.messungen]
        durchschnitt = sum(temperaturen) / len(temperaturen)
        return round(durchschnitt, 2)
    
    def extreme_werte_finden(self):
        """Findet Extremwerte in den Messungen"""
        pdb.set_trace()  # Debugging-Punkt
        
        if not self.messungen:
            return {}
        
        temperaturen = [m['temperatur'] for m in self.messungen]
        luftfeuchtigkeiten = [m['luftfeuchtigkeit'] for m in self.messungen]
        
        extreme = {
            'min_temp': min(temperaturen),
            'max_temp': max(temperaturen),
            'min_luftfeuchtigkeit': min(luftfeuchtigkeiten),
            'max_luftfeuchtigkeit': max(luftfeuchtigkeiten)
        }
        
        return extreme

# Debugging-Demo mit schrittweiser Ausführung
def wetterstation_demo():
    station = WetterStation("Hauptstation", "München")
    
    print("=== Wetterstation Debugging Demo ===")
    
    # Mehrere Messungen hinzufügen (jede wird durch pdb unterbrochen)
    try:
        station.messung_hinzufuegen(22.5, 65, 1013)
        station.messung_hinzufuegen(18.0, 80, 1008)
        station.messung_hinzufuegen(25.3, 45, 1020)
        station.messung_hinzufuegen(19.8, 70, 1015)
    except ValueError as e:
        print(f"Fehler beim Hinzufügen der Messung: {e}")
    
    # Berechnungen durchführen
    durchschnitt = station.durchschnittstemperatur()
    extreme = station.extreme_werte_finden()
    
    print(f"Durchschnittstemperatur: {durchschnitt}°C")
    print(f"Extreme Werte: {extreme}")

if __name__ == "__main__":
    wetterstation_demo()
```


## Funktionen und Methoden debuggen

### Debugging objektorientierter Strukturen

```python
import pdb

class Student:
    def __init__(self, name, matrikelnummer):
        self.name = name
        self.matrikelnummer = matrikelnummer
        self.noten = {}
        self.kurse = []
    
    def kurs_belegen(self, kursname):
        """Belegt einen neuen Kurs"""
        pdb.set_trace()
        
        if kursname not in self.kurse:
            self.kurse.append(kursname)
            self.noten[kursname] = []
            return True
        return False
    
    def note_hinzufuegen(self, kursname, note):
        """Fügt eine Note für einen Kurs hinzu"""
        pdb.set_trace()
        
        if kursname not in self.kurse:
            raise ValueError(f"Kurs {kursname} nicht belegt")
        
        if not (1.0 <= note <= 5.0):
            raise ValueError("Note muss zwischen 1.0 und 5.0 liegen")
        
        self.noten[kursname].append(note)
    
    def durchschnittsnote_berechnen(self, kursname=None):
        """Berechnet Durchschnittsnote für einen Kurs oder alle Kurse"""
        pdb.set_trace()
        
        if kursname:
            # Durchschnitt für einen spezifischen Kurs
            if kursname not in self.noten or not self.noten[kursname]:
                return None
            return sum(self.noten[kursname]) / len(self.noten[kursname])
        else:
            # Gesamtdurchschnitt
            alle_noten = []
            for kurs_noten in self.noten.values():
                alle_noten.extend(kurs_noten)
            
            if not alle_noten:
                return None
            
            return sum(alle_noten) / len(alle_noten)

class Notenverwaltung:
    def __init__(self):
        self.studenten = {}
    
    def student_hinzufuegen(self, student):
        """Fügt einen Studenten hinzu"""
        pdb.set_trace()
        
        if student.matrikelnummer in self.studenten:
            raise ValueError(f"Student mit Matrikelnummer {student.matrikelnummer} bereits vorhanden")
        
        self.studenten[student.matrikelnummer] = student
    
    def notenstatistik_erstellen(self):
        """Erstellt eine Statistik aller Studenten"""
        pdb.set_trace()
        
        statistik = {
            'anzahl_studenten': len(self.studenten),
            'studenten_details': []
        }
        
        for matrikelnummer, student in self.studenten.items():
            student_stats = {
                'name': student.name,
                'matrikelnummer': matrikelnummer,
                'kurse_anzahl': len(student.kurse),
                'durchschnittsnote': student.durchschnittsnote_berechnen()
            }
            statistik['studenten_details'].append(student_stats)
        
        return statistik

# Debugging-Demo für objektorientierte Strukturen
def notenverwaltung_demo():
    verwaltung = Notenverwaltung()
    
    # Studenten erstellen
    student1 = Student("Anna Müller", "12345")
    student2 = Student("Max Schmidt", "67890")
    
    try:
        # Studenten hinzufügen
        verwaltung.student_hinzufuegen(student1)
        verwaltung.student_hinzufuegen(student2)
        
        # Kurse belegen
        student1.kurs_belegen("Mathematik")
        student1.kurs_belegen("Physik")
        student2.kurs_belegen("Informatik")
        
        # Noten hinzufügen
        student1.note_hinzufuegen("Mathematik", 2.0)
        student1.note_hinzufuegen("Mathematik", 1.5)
        student1.note_hinzufuegen("Physik", 2.3)
        
        student2.note_hinzufuegen("Informatik", 1.8)
        student2.note_hinzufuegen("Informatik", 2.1)
        
        # Statistik erstellen
        statistik = verwaltung.notenstatistik_erstellen()
        
        print("=== Notenstatistik ===")
        print(f"Anzahl Studenten: {statistik['anzahl_studenten']}")
        for student_data in statistik['studenten_details']:
            print(f"Student: {student_data['name']}")
            print(f"  Durchschnittsnote: {student_data['durchschnittsnote']:.2f}")
            print(f"  Kurse: {student_data['kurse_anzahl']}")
    
    except ValueError as e:
        print(f"Fehler: {e}")

if __name__ == "__main__":
    notenverwaltung_demo()
```


## Debugging mit dem debugger-Modul

### Erweiterte Debugging-Funktionen

```python
import pdb
import traceback
import sys

class DebugHelper:
    """Hilfklasse für erweiterte Debugging-Funktionen"""
    
    @staticmethod
    def debug_funktion(func):
        """Decorator für automatisches Debugging von Funktionen"""
        def wrapper(*args, **kwargs):
            print(f"\n=== Debugging: {func.__name__} ===")
            print(f"Argumente: {args}")
            print(f"Keyword-Argumente: {kwargs}")
            
            # Automatischer Breakpoint
            pdb.set_trace()
            
            try:
                result = func(*args, **kwargs)
                print(f"Rückgabewert: {result}")
                return result
            except Exception as e:
                print(f"Fehler in {func.__name__}: {e}")
                traceback.print_exc()
                raise
        
        return wrapper
    
    @staticmethod
    def debug_auf_fehler(func):
        """Decorator der bei Fehlern automatisch den Debugger startet"""
        def wrapper(*args, **kwargs):
            try:
                return func(*args, **kwargs)
            except Exception:
                print(f"Fehler in {func.__name__} - Starte Debugger...")
                pdb.post_mortem()
                raise
        return wrapper

# Anwendungsbeispiele
@DebugHelper.debug_funktion
def mathematische_operation(a, b, operation="add"):
    """Führt mathematische Operationen durch"""
    if operation == "add":
        return a + b
    elif operation == "subtract":
        return a - b
    elif operation == "multiply":
        return a * b
    elif operation == "divide":
        if b == 0:
            raise ZeroDivisionError("Division durch Null nicht möglich")
        return a / b
    else:
        raise ValueError(f"Unbekannte Operation: {operation}")

@DebugHelper.debug_auf_fehler
def riskante_berechnung(werte):
    """Beispiel für eine Funktion die Fehler produzieren kann"""
    resultat = 0
    for i, wert in enumerate(werte):
        # Potentielle Fehlerquelle
        resultat += wert / (i - 2)  # Division durch Null bei i=2
    return resultat

def debugging_demo():
    print("=== Erweiterte Debugging-Demo ===")
    
    # Test der mathematischen Operationen
    print("\n1. Mathematische Operationen:")
    try:
        ergebnis1 = mathematische_operation(10, 5, "add")
        ergebnis2 = mathematische_operation(10, 0, "divide")  # Fehler
    except ZeroDivisionError as e:
        print(f"Abgefangen: {e}")
    
    # Test der riskanten Berechnung
    print("\n2. Riskante Berechnung:")
    try:
        test_werte = [1, 2, 3, 4, 5]
        ergebnis = riskante_berechnung(test_werte)
    except ZeroDivisionError:
        print("Division durch Null abgefangen")

if __name__ == "__main__":
    debugging_demo()
```


## Debugging in der Praxis

### Komplexes Debugging-Szenario

```python
import pdb
import json
from typing import List, Dict, Any

class DataProcessor:
    """Komplexe Datenverarbeitungsklasse für Debugging-Demonstrationen"""
    
    def __init__(self):
        self.processed_items = 0
        self.errors = []
        self.results = []
    
    def process_data_batch(self, data_batch: List[Dict[str, Any]]) -> Dict[str, Any]:
        """Verarbeitet einen Batch von Daten"""
        pdb.set_trace()  # Haupteinstiegspunkt
        
        batch_results = {
            'successful': 0,
            'failed': 0,
            'items': []
        }
        
        for index, item in enumerate(data_batch):
            try:
                processed_item = self._process_single_item(item, index)
                batch_results['items'].append(processed_item)
                batch_results['successful'] += 1
                
            except Exception as e:
                error_info = {
                    'index': index,
                    'item': item,
                    'error': str(e),
                    'error_type': type(e).__name__
                }
                self.errors.append(error_info)
                batch_results['failed'] += 1
                
                # Debugger bei Fehlern
                print(f"Fehler bei Item {index}: {e}")
                pdb.set_trace()
        
        return batch_results
    
    def _process_single_item(self, item: Dict[str, Any], index: int) -> Dict[str, Any]:
        """Verarbeitet ein einzelnes Datenitem"""
        # Bedingte Breakpoints für spezifische Indizes
        if index in [2, 7, 12]:  # Debugging bei bestimmten Items
            pdb.set_trace()
        
        # Datenvalidierung
        required_fields = ['id', 'value', 'category']
        for field in required_fields:
            if field not in item:
                raise ValueError(f"Pflichtfeld '{field}' fehlt")
        
        # Datenkonvertierung
        processed = {
            'original_id': item['id'],
            'processed_value': self._convert_value(item['value']),
            'category_code': self._encode_category(item['category']),
            'metadata': self._extract_metadata(item)
        }
        
        self.processed_items += 1
        return processed
    
    def _convert_value(self, value: Any) -> float:
        """Konvertiert Werte zu Gleitkommazahlen"""
        if isinstance(value, (int, float)):
            return float(value)
        elif isinstance(value, str):
            # Versuche String-Konvertierung
            try:
                return float(value.replace(',', '.'))
            except ValueError:
                raise ValueError(f"Kann '{value}' nicht zu Zahl konvertieren")
        else:
            raise TypeError(f"Unbekannter Wertetyp: {type(value)}")
    
    def _encode_category(self, category: str) -> int:
        """Kodiert Kategorien zu numerischen Codes"""
        category_mapping = {
            'A': 1, 'B': 2, 'C': 3,
            'high': 10, 'medium': 5, 'low': 1,
            'urgent': 100, 'normal': 50, 'deferred': 10
        }
        
        if category.lower() in [k.lower() for k in category_mapping.keys()]:
            # Finde den matching Key (case-insensitive)
            for key, value in category_mapping.items():
                if key.lower() == category.lower():
                    return value
        
        # Unbekannte Kategorie
        raise ValueError(f"Unbekannte Kategorie: {category}")
    
    def _extract_metadata(self, item: Dict[str, Any]) -> Dict[str, Any]:
        """Extrahiert Metadaten aus dem Item"""
        metadata = {}
        
        # Optionale Felder
        optional_fields = ['timestamp', 'source', 'priority', 'tags']
        for field in optional_fields:
            if field in item:
                metadata[field] = item[field]
        
        # Zusätzliche berechnete Metadaten
        metadata['processing_order'] = self.processed_items + 1
        metadata['has_optional_data'] = len(metadata) > 1
        
        return metadata

def debugging_praxis_demo():
    """Praktische Debugging-Demonstration"""
    processor = DataProcessor()
    
    # Testdaten mit verschiedenen Problemen
    test_data = [
        {'id': 1, 'value': 100, 'category': 'A', 'timestamp': '2023-01-01'},
        {'id': 2, 'value': '150.5', 'category': 'high', 'source': 'api'},
        {'id': 3, 'value': 'invalid', 'category': 'B'},  # Fehler: invalid value
        {'id': 4, 'value': 200, 'category': 'unknown'},  # Fehler: unknown category
        {'value': 75, 'category': 'C'},  # Fehler: missing id
        {'id': 6, 'value': 300, 'category': 'urgent', 'tags': ['important']},
        {'id': 7, 'value': '99,9', 'category': 'medium'},  # Komma-Dezimalzahl
        {'id': 8, 'value': None, 'category': 'low'},  # Fehler: None value
    ]
    
    print("=== Debugging-Praxis Demo ===")
    print(f"Verarbeite {len(test_data)} Items...")
    
    # Hauptverarbeitung mit Debugging
    results = processor.process_data_batch(test_data)
    
    # Ergebnisse anzeigen
    print("\n=== Verarbeitungsergebnisse ===")
    print(f"Erfolgreich: {results['successful']}")
    print(f"Fehlgeschlagen: {results['failed']}")
    print(f"Verarbeitete Items insgesamt: {processor.processed_items}")
    
    if processor.errors:
        print("\n=== Fehlerdetails ===")
        for error in processor.errors:
            print(f"Index {error['index']}: {error['error_type']} - {error['error']}")

if __name__ == "__main__":
    debugging_praxis_demo()
```


## Post-Mortem Debugging

### Debugging nach Programmabsturz

```python
import pdb
import traceback
import sys

def aktiviere_post_mortem_debugging():
    """Aktiviert automatisches Post-Mortem-Debugging"""
    def ausnahmebehandler(typ, wert, tb):
        # Zeige normale Traceback-Information
        traceback.print_exception(typ, wert, tb)
        
        # Starte Post-Mortem-Debugger
        print("\n=== Post-Mortem-Debugging aktiviert ===")
        print("Verwende 'u' und 'd' um im Call-Stack zu navigieren")
        print("Verwende 'p variable_name' um Variablenwerte zu sehen")
        print("Verwende 'q' um den Debugger zu beenden")
        pdb.post_mortem(tb)
    
    # Setze den Exception-Handler
    sys.excepthook = ausnahmebehandler

def fehlerhafte_funktion():
    """Beispiel einer Funktion die Fehler produziert"""
    daten = [1, 2, 3, 4, 5]
    ergebnis = []
    
    for i in range(len(daten) + 2):  # Absichtlicher Index-Fehler
        wert = daten[i]  # IndexError bei i >= len(daten)
        verarbeitet = wert * 2 + i
        ergebnis.append(verarbeitet)
    
    return ergebnis

def post_mortem_demo():
    """Demonstriert Post-Mortem-Debugging"""
    print("=== Post-Mortem-Debugging Demo ===")
    
    # Aktiviere Post-Mortem-Debugging
    aktiviere_post_mortem_debugging()
    
    try:
        print("Führe fehlerhafte Funktion aus...")
        resultat = fehlerhafte_funktion()
        print(f"Resultat: {resultat}")
    except:
        # Exception wird vom Handler abgefangen
        pass

if __name__ == "__main__":
    post_mortem_demo()
```


## Debugging Best Practices

### Strukturiertes Debugging-Vorgehen

```python
import pdb
import logging
from datetime import datetime

# Logging für Debugging konfigurieren
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

class DebugManager:
    """Manager für strukturiertes Debugging"""
    
    def __init__(self, enable_debugging=True):
        self.enable_debugging = enable_debugging
        self.debug_points = []
        self.logger = logging.getLogger(__name__)
    
    def debug_point(self, name, condition=True):
        """Setzt einen benannten Debugging-Punkt"""
        if self.enable_debugging and condition:
            point_info = {
                'name': name,
                'timestamp': datetime.now(),
                'call_count': len([p for p in self.debug_points if p['name'] == name]) + 1
            }
            self.debug_points.append(point_info)
            
            self.logger.debug(f"Debug-Punkt '{name}' erreicht (#{point_info['call_count']})")
            print(f"\n=== Debug-Punkt: {name} (#{point_info['call_count']}) ===")
            pdb.set_trace()
    
    def debug_info(self):
        """Zeigt Debugging-Statistiken"""
        print("\n=== Debugging-Statistiken ===")
        print(f"Anzahl Debug-Punkte: {len(self.debug_points)}")
        
        # Gruppiere nach Namen
        point_counts = {}
        for point in self.debug_points:
            name = point['name']
            point_counts[name] = point_counts.get(name, 0) + 1
        
        for name, count in point_counts.items():
            print(f"  {name}: {count}x erreicht")

# Globaler Debug-Manager
debug_mgr = DebugManager()

class SmartCalculator:
    """Intelligenter Rechner mit strukturiertem Debugging"""
    
    def __init__(self):
        self.history = []
        self.variables = {}
    
    def berechne_ausdruck(self, ausdruck):
        """Berechnet mathematische Ausdrücke"""
        debug_mgr.debug_point("ausdruck_start")
        
        try:
            # Preprocessing
            bereinigter_ausdruck = self._bereinige_ausdruck(ausdruck)
            debug_mgr.debug_point("nach_bereinigung", 
                                condition=len(bereinigter_ausdruck) != len(ausdruck))
            
            # Variablen ersetzen
            aufgeloester_ausdruck = self._ersetze_variablen(bereinigter_ausdruck)
            debug_mgr.debug_point("nach_variablen_ersetzung",
                                condition=aufgeloester_ausdruck != bereinigter_ausdruck)
            
            # Berechnung
            ergebnis = eval(aufgeloester_ausdruck)
            debug_mgr.debug_point("nach_berechnung")
            
            # Historie aktualisieren
            self.history.append({
                'original': ausdruck,
                'bereinigt': bereinigter_ausdruck,
                'aufgeloest': aufgeloester_ausdruck,
                'ergebnis': ergebnis
            })
            
            return ergebnis
            
        except Exception as e:
            debug_mgr.debug_point("fehler_aufgetreten")
            raise ValueError(f"Fehler bei Berechnung von '{ausdruck}': {e}")
    
    def _bereinige_ausdruck(self, ausdruck):
        """Bereinigt den Eingabeausdruck"""
        # Entferne Leerzeichen
        bereinigt = ausdruck.replace(" ", "")
        
        # Ersetze häufige Schreibweisen
        ersetzungen = {
            'x': '*',
            '^': '**',
            'sqrt': 'math.sqrt',
            'sin': 'math.sin',
            'cos': 'math.cos'
        }
        
        for alt, neu in ersetzungen.items():
            bereinigt = bereinigt.replace(alt, neu)
        
        return bereinigt
    
    def _ersetze_variablen(self, ausdruck):
        """Ersetzt Variablen durch ihre Werte"""
        debug_mgr.debug_point("variablen_ersetzung_start", 
                            condition=bool(self.variables))
        
        aufgeloest = ausdruck
        for var_name, var_wert in self.variables.items():
            aufgeloest = aufgeloest.replace(var_name, str(var_wert))
        
        return aufgeloest
    
    def setze_variable(self, name, wert):
        """Setzt eine Variable"""
        debug_mgr.debug_point("variable_setzen")
        self.variables[name] = wert

def calculator_debugging_demo():
    """Demonstriert strukturiertes Debugging"""
    calc = SmartCalculator()
    
    print("=== Smart Calculator Debugging Demo ===")
    
    # Testberechnungen
    testfaelle = [
        "2 + 3 * 4",
        "10 / 2 + 5",
        "a + b * 2",  # Fehler: Unbekannte Variablen
        "sqrt(16) + sin(0)"  # Komplexer Ausdruck
    ]
    
    # Setze Variablen
    calc.setze_variable('a', 5)
    calc.setze_variable('b', 3)
    
    for ausdruck in testfaelle:
        try:
            print(f"\nBerechne: {ausdruck}")
            ergebnis = calc.berechne_ausdruck(ausdruck)
            print(f"Ergebnis: {ergebnis}")
        except Exception as e:
            print(f"Fehler: {e}")
    
    # Debugging-Statistiken anzeigen
    debug_mgr.debug_info()
    
    # Historie anzeigen
    print("\n=== Berechnungshistorie ===")
    for i, eintrag in enumerate(calc.history, 1):
        print(f"{i}. {eintrag['original']} = {eintrag['ergebnis']}")

if __name__ == "__main__":
    calculator_debugging_demo()
```


## Zusammenfassung

Das Modul 31 "Fortgeschrittene Debugging-Techniken" vermittelt professionelle Methoden zur Fehlersuche und Codeanalyse in Python. Die wichtigsten Konzepte umfassen:

**Kernkonzepte:**

- **Python Debugger (pdb)**: Interaktives Debugging-Tool für schrittweise Codeausführung
- **Breakpoints**: Gezielte Unterbrechungspunkte im Code für detaillierte Analyse
- **Schrittweise Ausführung**: Kontrolle über Programmfluss mit `next`, `step`, und `continue`
- **Call-Stack-Navigation**: Untersuchung der Aufrufhierarchie mit `up`, `down`, und `where`

**Praktische Anwendungen:**

- Bedingte Breakpoints für spezifische Debugging-Szenarien
- Post-Mortem Debugging zur Analyse nach Programmabsturz
- Debugging von objektorientierten Strukturen und komplexen Datenverarbeitungen
- Integration von Logging und strukturierten Debugging-Ansätzen

**Best Practices:**

- Verwendung von Debugging-Decorators für wiederverwendbare Debugging-Logik
- Strukturierte Debug-Punkte mit Bedingungen und Statistiken
- Kombination von pdb mit Logging für umfassende Fehleranalyse
- Systematische Herangehensweise bei der Fehlersuche in komplexen Anwendungen

Diese fortgeschrittenen Debugging-Techniken sind essentiell für die professionelle Softwareentwicklung und ermöglichen es Entwicklern, auch komplexe Fehler effizient zu identifizieren und zu beheben.
