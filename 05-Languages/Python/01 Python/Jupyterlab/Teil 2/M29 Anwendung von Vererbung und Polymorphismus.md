## Klassenhierarchien entwerfen

**Klassenhierarchien** bilden das Fundament für saubere und erweiterbare objektorientierte Software. 
Bei der Entwicklung von Hierarchien geht es darum, gemeinsame Eigenschaften und Methoden in Basisklassen zu abstrahieren und spezifische Funktionalitäten in abgeleiteten Klassen zu implementieren.

```python
# Beispiel einer durchdachten Klassenhierarchie für Fahrzeuge
from abc import ABC, abstractmethod

class Fahrzeug(ABC):
    """Abstrakte Basisklasse für alle Fahrzeuge"""
    
    def __init__(self, marke, modell, baujahr):
        self.marke = marke
        self.modell = modell
        self.baujahr = baujahr
        self._gefahrene_kilometer = 0
    
    @property
    def gefahrene_kilometer(self):
        return self._gefahrene_kilometer
    
    def fahren(self, kilometer):
        """Fahrzeug um bestimmte Kilometer bewegen"""
        if kilometer > 0:
            self._gefahrene_kilometer += kilometer
            print(f"{self.marke} {self.modell} ist {kilometer} km gefahren")
    
    @abstractmethod
    def verbrauch_pro_100km(self):
        """Abstrakte Methode für Verbrauchsberechnung"""
        pass
    
    @abstractmethod
    def tank_volumen(self):
        """Abstrakte Methode für Tankvolumen"""
        pass
    
    def reichweite(self):
        """Berechnet theoretische Reichweite"""
        return (self.tank_volumen() / self.verbrauch_pro_100km()) * 100
    
    def __str__(self):
        return f"{self.marke} {self.modell} ({self.baujahr})"

# Spezialisierte Unterklassen
class Pkw(Fahrzeug):
    """Personenkraftwagen mit spezifischen Eigenschaften"""
    
    def __init__(self, marke, modell, baujahr, anzahl_tuer):
        super().__init__(marke, modell, baujahr)
        self.anzahl_tuer = anzahl_tuer
        self._verbrauch = 7.5  # L/100km
        self._tankvolumen = 60  # Liter
    
    def verbrauch_pro_100km(self):
        return self._verbrauch
    
    def tank_volumen(self):
        return self._tankvolumen
    
    def parken(self, parkplatz_typ):
        """PKW-spezifische Parkmethode"""
        print(f"{self} parkt auf {parkplatz_typ}")

class Lkw(Fahrzeug):
    """Lastkraftwagen für den Gütertransport"""
    
    def __init__(self, marke, modell, baujahr, nutzlast):
        super().__init__(marke, modell, baujahr)
        self.nutzlast = nutzlast  # in Tonnen
        self._verbrauch = 25.0  # L/100km
        self._tankvolumen = 400  # Liter
        self._beladen = 0
    
    def verbrauch_pro_100km(self):
        # Verbrauch steigt mit Beladung
        zusatzverbrauch = (self._beladen / self.nutzlast) * 5
        return self._verbrauch + zusatzverbrauch
    
    def tank_volumen(self):
        return self._tankvolumen
    
    def beladen(self, gewicht):
        """LKW beladen"""
        if gewicht <= self.nutzlast:
            self._beladen = gewicht
            print(f"{self} wurde mit {gewicht}t beladen")
        else:
            print(f"Überlast! Maximal {self.nutzlast}t möglich")

# Demonstration der Hierarchie
def demonstriere_fahrzeughierarchie():
    # Verschiedene Fahrzeugtypen erstellen
    golf = Pkw("VW", "Golf", 2020, 4)
    actros = Lkw("Mercedes", "Actros", 2019, 25)
    
    fahrzeuge = [golf, actros]
    
    print("=== Fahrzeugflotte ===")
    for fahrzeug in fahrzeuge:
        print(f"{fahrzeug}")
        print(f"  Verbrauch: {fahrzeug.verbrauch_pro_100km():.1f} L/100km")
        print(f"  Reichweite: {fahrzeug.reichweite():.0f} km")
        print()
    
    # Fahrzeugspezifische Aktionen
    golf.parken("Tiefgarage")
    actros.beladen(20)
    
    # Gemeinsame Aktionen
    for fahrzeug in fahrzeuge:
        fahrzeug.fahren(150)
    
    print("\n=== Nach der Fahrt ===")
    for fahrzeug in fahrzeuge:
        print(f"{fahrzeug}: {fahrzeug.gefahrene_kilometer} km gefahren")

# Ausführung der Demonstration
demonstriere_fahrzeughierarchie()
```


## Best Practices für objektorientiertes Design

Effektive objektorientierte Programmierung folgt bewährten Designprinzipien, die zu wartbarem und erweiterbarem Code führen. Diese Best Practices sind essentiell für professionelle Softwareentwicklung.

```python
# SOLID-Prinzipien in der Praxis demonstriert

# 1. Single Responsibility Principle (SRP)
class DateiManager:
    """Kümmert sich nur um Dateiverwaltung"""
    
    def __init__(self, dateipfad):
        self.dateipfad = dateipfad
    
    def lese_datei(self):
        """Datei einlesen"""
        try:
            with open(self.dateipfad, 'r', encoding='utf-8') as datei:
                return datei.read()
        except FileNotFoundError:
            return None
    
    def schreibe_datei(self, inhalt):
        """Datei schreiben"""
        with open(self.dateipfad, 'w', encoding='utf-8') as datei:
            datei.write(inhalt)

class DatenValidator:
    """Kümmert sich nur um Datenvalidierung"""
    
    @staticmethod
    def validiere_email(email):
        """E-Mail-Format validieren"""
        return '@' in email and '.' in email.split('@')
    
    @staticmethod
    def validiere_alter(alter):
        """Alter validieren"""
        return isinstance(alter, int) and 0 <= alter <= 150

# 2. Open/Closed Principle (OCP) - offen für Erweiterungen, geschlossen für Änderungen
class Berichtsgenerator(ABC):
    """Abstrakte Basis für verschiedene Berichtstypen"""
    
    @abstractmethod
    def generiere_bericht(self, daten):
        pass
    
    def speichere_bericht(self, bericht, dateiname):
        """Gemeinsame Speicherfunktion"""
        with open(dateiname, 'w', encoding='utf-8') as datei:
            datei.write(bericht)

class HTMLBerichtsgenerator(Berichtsgenerator):
    """HTML-Berichte generieren"""
    
    def generiere_bericht(self, daten):
        html = "<html><body><h1>Bericht</h1><ul>"
        for eintrag in daten:
            html += f"<li>{eintrag}</li>"
        html += "</ul></body></html>"
        return html

class CSVBerichtsgenerator(Berichtsgenerator):
    """CSV-Berichte generieren"""
    
    def generiere_bericht(self, daten):
        csv = "Eintrag\n"
        for eintrag in daten:
            csv += f"{eintrag}\n"
        return csv

# 3. Liskov Substitution Principle (LSP)
class Rechteck:
    """Basis-Rechteck-Klasse"""
    
    def __init__(self, breite, hoehe):
        self._breite = breite
        self._hoehe = hoehe
    
    @property
    def breite(self):
        return self._breite
    
    @breite.setter
    def breite(self, wert):
        self._breite = wert
    
    @property
    def hoehe(self):
        return self._hoehe
    
    @hoehe.setter  
    def hoehe(self, wert):
        self._hoehe = wert
    
    def flaeche(self):
        return self._breite * self._hoehe

# Korrekte LSP-Implementierung
class Quadrat(Rechteck):
    """Quadrat als spezielles Rechteck"""
    
    def __init__(self, seitenlaenge):
        super().__init__(seitenlaenge, seitenlaenge)
    
    @property
    def breite(self):
        return self._breite
    
    @breite.setter
    def breite(self, wert):
        self._breite = self._hoehe = wert
    
    @property
    def hoehe(self):
        return self._hoehe
    
    @hoehe.setter
    def hoehe(self, wert):
        self._breite = self._hoehe = wert

# 4. Composition over Inheritance
class Motor:
    """Motor-Komponente"""
    
    def __init__(self, ps, typ):
        self.ps = ps
        self.typ = typ
        self.laeuft = False
    
    def starten(self):
        self.laeuft = True
        print(f"{self.typ}-Motor ({self.ps} PS) gestartet")
    
    def stoppen(self):
        self.laeuft = False
        print(f"{self.typ}-Motor gestoppt")

class Auto:
    """Auto verwendet Komposition statt Vererbung"""
    
    def __init__(self, marke, modell, motor):
        self.marke = marke
        self.modell = modell
        self.motor = motor  # Komposition: Auto "hat einen" Motor
    
    def starten(self):
        print(f"{self.marke} {self.modell} wird gestartet...")
        self.motor.starten()
    
    def stoppen(self):
        print(f"{self.marke} {self.modell} wird gestoppt...")
        self.motor.stoppen()

# Demonstration der Best Practices
def demonstriere_best_practices():
    print("=== SOLID-Prinzipien in Aktion ===")
    
    # SRP: Getrennte Verantwortlichkeiten
    datei_mgr = DateiManager("test.txt")
    validator = DatenValidator()
    
    print(f"Email valid: {validator.validiere_email('test@example.com')}")
    print(f"Alter valid: {validator.validiere_alter(25)}")
    
    # OCP: Erweiterbare Berichtsgenerierung
    daten = ["Eintrag 1", "Eintrag 2", "Eintrag 3"]
    
    html_generator = HTMLBerichtsgenerator()
    csv_generator = CSVBerichtsgenerator()
    
    html_bericht = html_generator.generiere_bericht(daten)
    csv_bericht = csv_generator.generiere_bericht(daten)
    
    print("\nHTML-Bericht erstellt")
    print("CSV-Bericht erstellt")
    
    # LSP: Quadrat als Rechteck verwenden
    formen = [
        Rechteck(4, 5),
        Quadrat(4)
    ]
    
    print(f"\nFormen-Flächen:")
    for form in formen:
        print(f"Fläche: {form.flaeche()}")
    
    # Composition over Inheritance
    benzinmotor = Motor(150, "Benzin")
    mein_auto = Auto("BMW", "320i", benzinmotor)
    
    print(f"\n=== Auto-Demo ===")
    mein_auto.starten()
    mein_auto.stoppen()

demonstriere_best_practices()
```


## Praktische OOP-Projekte umsetzen

Die praktische Anwendung von Vererbung und Polymorphismus zeigt sich am besten in vollständigen Projekten. 
Hier wird ein umfassendes Beispiel für ein Verwaltungssystem entwickelt, das alle erlernten Konzepte integriert.

```python
import json
from datetime import datetime
from typing import List, Dict, Any

# Projekt: Mitarbeiterverwaltungssystem mit OOP-Prinzipien
class Person:
    """Basisklasse für alle Personen im System"""
    
    def __init__(self, person_id: int, vorname: str, nachname: str, 
                 geburtsdatum: str, email: str):
        self.person_id = person_id
        self.vorname = vorname
        self.nachname = nachname
        self.geburtsdatum = datetime.strptime(geburtsdatum, "%Y-%m-%d")
        self.email = email
    
    @property
    def vollname(self):
        return f"{self.vorname} {self.nachname}"
    
    @property
    def alter(self):
        heute = datetime.now()
        alter = heute.year - self.geburtsdatum.year
        if heute.month < self.geburtsdatum.month or \
           (heute.month == self.geburtsdatum.month and heute.day < self.geburtsdatum.day):
            alter -= 1
        return alter
    
    def __str__(self):
        return f"{self.vollname} (ID: {self.person_id})"

class Mitarbeiter(Person):
    """Mitarbeiter mit berufsspezifischen Eigenschaften"""
    
    def __init__(self, person_id: int, vorname: str, nachname: str, 
                 geburtsdatum: str, email: str, personalnummer: str, 
                 abteilung: str, gehalt: float):
        super().__init__(person_id, vorname, nachname, geburtsdatum, email)
        self.personalnummer = personalnummer
        self.abteilung = abteilung
        self._gehalt = gehalt
        self.projekte = []
        self.urlaubstage_genommen = 0
        self.urlaubstage_verfuegbar = 30
    
    @property
    def gehalt(self):
        return self._gehalt
    
    @gehalt.setter
    def gehalt(self, neues_gehalt):
        if neues_gehalt > 0:
            self._gehalt = neues_gehalt
    
    def projekt_zuweisen(self, projekt_name: str):
        """Projekt zu Mitarbeiter hinzufügen"""
        if projekt_name not in self.projekte:
            self.projekte.append(projekt_name)
            print(f"Projekt '{projekt_name}' zu {self.vollname} hinzugefügt")
    
    def urlaub_beantragen(self, tage: int):
        """Urlaubsantrag bearbeiten"""
        verfuegbar = self.urlaubstage_verfuegbar - self.urlaubstage_genommen
        if tage <= verfuegbar:
            self.urlaubstage_genommen += tage
            print(f"Urlaub genehmigt: {tage} Tage für {self.vollname}")
            return True
        else:
            print(f"Urlaub abgelehnt: Nur {verfuegbar} Tage verfügbar")
            return False
    
    def to_dict(self):
        """Mitarbeiter als Dictionary für JSON-Export"""
        return {
            'person_id': self.person_id,
            'vorname': self.vorname,
            'nachname': self.nachname,
            'geburtsdatum': self.geburtsdatum.strftime("%Y-%m-%d"),
            'email': self.email,
            'personalnummer': self.personalnummer,
            'abteilung': self.abteilung,
            'gehalt': self._gehalt,
            'projekte': self.projekte,
            'urlaub_genommen': self.urlaubstage_genommen
        }

class Fuehrungskraft(Mitarbeiter):
    """Führungskraft mit erweiterten Befugnissen"""
    
    def __init__(self, person_id: int, vorname: str, nachname: str, 
                 geburtsdatum: str, email: str, personalnummer: str, 
                 abteilung: str, gehalt: float, team_groesse: int):
        super().__init__(person_id, vorname, nachname, geburtsdatum, 
                         email, personalnummer, abteilung, gehalt)
        self.team_groesse = team_groesse
        self.team_mitglieder = []
        self.urlaubstage_verfuegbar = 35  # Mehr Urlaubstage
    
    def mitarbeiter_hinzufuegen(self, mitarbeiter: Mitarbeiter):
        """Mitarbeiter zum Team hinzufügen"""
        if len(self.team_mitglieder) < self.team_groesse:
            self.team_mitglieder.append(mitarbeiter)
            print(f"{mitarbeiter.vollname} zum Team von {self.vollname} hinzugefügt")
        else:
            print("Team ist bereits voll")
    
    def team_bericht(self):
        """Bericht über das Team erstellen"""
        print(f"\n=== Team-Bericht für {self.vollname} ===")
        print(f"Teamgröße: {len(self.team_mitglieder)}/{self.team_groesse}")
        
        for mitarbeiter in self.team_mitglieder:
            print(f"  - {mitarbeiter.vollname} ({mitarbeiter.abteilung})")
            print(f"    Projekte: {len(mitarbeiter.projekte)}")
            print(f"    Resturlaub: {mitarbeiter.urlaubstage_verfuegbar - mitarbeiter.urlaubstage_genommen}")

class MitarbeiterVerwaltung:
    """Hauptverwaltungsklasse für alle Mitarbeiter"""
    
    def __init__(self):
        self.mitarbeiter: Dict[str, Mitarbeiter] = {}
        self.naechste_id = 1
    
    def mitarbeiter_hinzufuegen(self, mitarbeiter: Mitarbeiter):
        """Neuen Mitarbeiter hinzufügen"""
        self.mitarbeiter[mitarbeiter.personalnummer] = mitarbeiter
        print(f"Mitarbeiter {mitarbeiter.vollname} hinzugefügt")
    
    def mitarbeiter_suchen(self, personalnummer: str) -> Mitarbeiter:
        """Mitarbeiter anhand Personalnummer finden"""
        return self.mitarbeiter.get(personalnummer)
    
    def abteilung_auflisten(self, abteilung: str) -> List[Mitarbeiter]:
        """Alle Mitarbeiter einer Abteilung auflisten"""
        return [m for m in self.mitarbeiter.values() 
                if m.abteilung.lower() == abteilung.lower()]
    
    def gehalts_statistik(self):
        """Gehaltsstatistiken berechnen"""
        if not self.mitarbeiter:
            return "Keine Mitarbeiter vorhanden"
        
        gehaelter = [m.gehalt for m in self.mitarbeiter.values()]
        return {
            'anzahl_mitarbeiter': len(gehaelter),
            'durchschnittsgehalt': sum(gehaelter) / len(gehaelter),
            'min_gehalt': min(gehaelter),
            'max_gehalt': max(gehaelter)
        }
    
    def export_json(self, dateiname: str):
        """Mitarbeiterdaten als JSON exportieren"""
        daten = {
            'mitarbeiter': [m.to_dict() for m in self.mitarbeiter.values()],
            'export_datum': datetime.now().isoformat()
        }
        
        with open(dateiname, 'w', encoding='utf-8') as datei:
            json.dump(daten, datei, indent=2, ensure_ascii=False)
        print(f"Daten nach {dateiname} exportiert")

# Praktische Anwendung des Verwaltungssystems
def demonstriere_verwaltungssystem():
    # Verwaltung initialisieren
    verwaltung = MitarbeiterVerwaltung()
    
    # Verschiedene Mitarbeitertypen erstellen
    alice = Mitarbeiter(1, "Alice", "Schmidt", "1985-03-15", 
                       "alice.schmidt@firma.com", "M001", 
                       "Entwicklung", 55000)
    
    bob = Mitarbeiter(2, "Bob", "Mueller", "1990-07-22", 
                     "bob.mueller@firma.com", "M002", 
                     "Entwicklung", 48000)
    
    clara = Fuehrungskraft(3, "Clara", "Weber", "1980-11-08", 
                          "clara.weber@firma.com", "F001", 
                          "Entwicklung", 75000, 5)
    
    # Mitarbeiter zur Verwaltung hinzufügen
    verwaltung.mitarbeiter_hinzufuegen(alice)
    verwaltung.mitarbeiter_hinzufuegen(bob)
    verwaltung.mitarbeiter_hinzufuegen(clara)
    
    # Polymorphismus in Aktion - alle als Mitarbeiter behandeln
    print("\n=== Alle Mitarbeiter ===")
    for personalnummer, mitarbeiter in verwaltung.mitarbeiter.items():
        print(f"{mitarbeiter} - Alter: {mitarbeiter.alter} Jahre")
    
    # Spezifische Funktionen nutzen
    alice.projekt_zuweisen("Webshop-Redesign")
    alice.projekt_zuweisen("API-Integration")
    alice.urlaub_beantragen(5)
    
    bob.projekt_zuweisen("Mobile App")
    bob.urlaub_beantragen(10)
    
    # Führungskraft-spezifische Funktionen
    clara.mitarbeiter_hinzufuegen(alice)
    clara.mitarbeiter_hinzufuegen(bob)
    clara.team_bericht()
    
    # Abteilungsstatistiken
    print(f"\n=== Entwicklungsabteilung ===")
    entwickler = verwaltung.abteilung_auflisten("Entwicklung")
    for mitarbeiter in entwickler:
        print(f"{mitarbeiter.vollname}: {len(mitarbeiter.projekte)} Projekte")
    
    # Gehaltsstatistik
    print(f"\n=== Gehaltsstatistik ===")
    stats = verwaltung.gehalts_statistik()
    for key, value in stats.items():
        if isinstance(value, float):
            print(f"{key}: {value:.2f}€")
        else:
            print(f"{key}: {value}")
    
    # Export der Daten
    verwaltung.export_json("mitarbeiter_export.json")

# Ausführung des vollständigen Beispiels
demonstriere_verwaltungssystem()
```


## Entwurfsmuster und Architektur

Vererbung und Polymorphismus sind die Grundlage für wichtige Entwurfsmuster, die in professionellen Anwendungen weit verbreitet sind.

```python
# Entwurfsmuster mit Vererbung und Polymorphismus

# 1. Strategy Pattern - Verschiedene Algorithmen austauschbar machen
class SortierStrategie(ABC):
    """Abstrakte Basis für Sortieralgorithmen"""
    
    @abstractmethod
    def sortieren(self, daten):
        pass

class BubbleSortStrategie(SortierStrategie):
    """Bubble Sort Implementierung"""
    
    def sortieren(self, daten):
        n = len(daten)
        for i in range(n):
            for j in range(0, n - i - 1):
                if daten[j] > daten[j + 1]:
                    daten[j], daten[j + 1] = daten[j + 1], daten[j]
        return daten

class QuickSortStrategie(SortierStrategie):
    """Quick Sort Implementierung"""
    
    def sortieren(self, daten):
        if len(daten) <= 1:
            return daten
        
        pivot = daten[len(daten) // 2]
        links = [x for x in daten if x < pivot]
        mitte = [x for x in daten if x == pivot]
        rechts = [x for x in daten if x > pivot]
        
        return (self.sortieren(links) + mitte + self.sortieren(rechts))

class Sortierer:
    """Context-Klasse für Strategy Pattern"""
    
    def __init__(self, strategie: SortierStrategie):
        self.strategie = strategie
    
    def setze_strategie(self, strategie: SortierStrategie):
        self.strategie = strategie
    
    def sortieren(self, daten):
        return self.strategie.sortieren(daten.copy())

# 2. Template Method Pattern - Algorithmus-Skelett definieren
class DatenVerarbeitung(ABC):
    """Template für Datenverarbeitungsprozesse"""
    
    def verarbeiten(self, daten):
        """Template Method - definiert den Ablauf"""
        print("Starte Datenverarbeitung...")
        
        validierte_daten = self.validieren(daten)
        transformierte_daten = self.transformieren(validierte_daten)
        ergebnis = self.analysieren(transformierte_daten)
        self.ausgeben(ergebnis)
        
        print("Datenverarbeitung abgeschlossen.")
        return ergebnis
    
    @abstractmethod
    def validieren(self, daten):
        """Datenvalidierung - muss implementiert werden"""
        pass
    
    @abstractmethod
    def transformieren(self, daten):
        """Datentransformation - muss implementiert werden"""
        pass
    
    @abstractmethod
    def analysieren(self, daten):
        """Datenanalyse - muss implementiert werden"""
        pass
    
    def ausgeben(self, ergebnis):
        """Standardausgabe - kann überschrieben werden"""
        print(f"Ergebnis: {ergebnis}")

class NummerVerarbeitung(DatenVerarbeitung):
    """Konkrete Implementierung für Zahlenverarbeitung"""
    
    def validieren(self, daten):
        """Nur Zahlen zulassen"""
        return [x for x in daten if isinstance(x, (int, float))]
    
    def transformieren(self, daten):
        """Zahlen normalisieren"""
        if not daten:
            return []
        max_wert = max(daten)
        return [x / max_wert for x in daten] if max_wert > 0 else daten
    
    def analysieren(self, daten):
        """Mittelwert berechnen"""
        return sum(daten) / len(daten) if daten else 0

# 3. Observer Pattern - Beobachter-Muster
class Beobachtbar:
    """Basisklasse für beobachtbare Objekte"""
    
    def __init__(self):
        self._beobachter = []
    
    def beobachter_hinzufuegen(self, beobachter):
        if beobachter not in self._beobachter:
            self._beobachter.append(beobachter)
    
    def beobachter_entfernen(self, beobachter):
        if beobachter in self._beobachter:
            self._beobachter.remove(beobachter)
    
    def benachrichtigen(self, *args, **kwargs):
        for beobachter in self._beobachter:
            beobachter.aktualisieren(self, *args, **kwargs)

class Beobachter(ABC):
    """Abstrakte Beobachter-Klasse"""
    
    @abstractmethod
    def aktualisieren(self, subjekt, *args, **kwargs):
        pass

class Aktienkurs(Beobachtbar):
    """Beobachtbare Aktie"""
    
    def __init__(self, symbol, preis):
        super().__init__()
        self.symbol = symbol
        self._preis = preis
    
    @property
    def preis(self):
        return self._preis
    
    @preis.setter
    def preis(self, neuer_preis):
        alter_preis = self._preis
        self._preis = neuer_preis
        self.benachrichtigen(alter_preis=alter_preis, neuer_preis=neuer_preis)

class Portfolio(Beobachter):
    """Portfolio-Beobachter"""
    
    def __init__(self, name):
        self.name = name
    
    def aktualisieren(self, aktie, alter_preis, neuer_preis):
        aenderung = ((neuer_preis - alter_preis) / alter_preis) * 100
        print(f"Portfolio {self.name}: {aktie.symbol} "
              f"{alter_preis:.2f}€ → {neuer_preis:.2f}€ "
              f"({aenderung:+.1f}%)")

# Demonstration der Entwurfsmuster
def demonstriere_entwurfsmuster():
    print("=== Strategy Pattern ===")
    daten = [64, 34, 25, 12, 22, 11, 90]
    
    # Verschiedene Sortierstrategien testen
    sortierer = Sortierer(BubbleSortStrategie())
    bubble_ergebnis = sortierer.sortieren(daten)
    print(f"Bubble Sort: {bubble_ergebnis}")
    
    sortierer.setze_strategie(QuickSortStrategie())
    quick_ergebnis = sortierer.sortieren(daten)
    print(f"Quick Sort: {quick_ergebnis}")
    
    print("\n=== Template Method Pattern ===")
    verarbeiter = NummerVerarbeitung()
    test_daten = [10, 20, 30, "invalid", 40, 50]
    ergebnis = verarbeiter.verarbeiten(test_daten)
    
    print(f"\n=== Observer Pattern ===")
    apple_aktie = Aktienkurs("AAPL", 150.0)
    
    portfolio1 = Portfolio("Tech-Portfolio")
    portfolio2 = Portfolio("Diversified")
    
    apple_aktie.beobachter_hinzufuegen(portfolio1)
    apple_aktie.beobachter_hinzufuegen(portfolio2)
    
    # Kursänderungen simulieren
    apple_aktie.preis = 155.0
    apple_aktie.preis = 148.0

demonstriere_entwurfsmuster()
```


## Integration mit den Kursprojekten

Die erlernten Konzepte aus Modul 29 lassen sich direkt in die Kursprojekte integrieren und erweitern diese um professionelle OOP-Strukturen.

```python
# Erweiterte Klassenhierarchie für das Py2Rust-Projekt (Fritz)
class CodeTransformer(ABC):
    """Abstrakte Basis für alle Code-Transformationen"""
    
    def __init__(self, quell_sprache: str, ziel_sprache: str):
        self.quell_sprache = quell_sprache
        self.ziel_sprache = ziel_sprache
        self.transformations_log = []
    
    @abstractmethod
    def transformiere(self, quellcode: str) -> str:
        """Haupttransformationsmethode"""
        pass
    
    def log_transformation(self, nachricht: str):
        """Transformation protokollieren"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        self.transformations_log.append(f"[{timestamp}] {nachricht}")
    
    def zeige_log(self):
        """Transformationslog anzeigen"""
        for eintrag in self.transformations_log:
            print(eintrag)

class PythonZuRustTransformer(CodeTransformer):
    """Spezieller Transformer für Python zu Rust"""
    
    def __init__(self):
        super().__init__("Python", "Rust")
        self.typ_mapping = {
            "int": "i32",
            "float": "f64", 
            "str": "String",
            "bool": "bool",
            "list": "Vec"
        }
    
    def transformiere(self, python_code: str) -> str:
        self.log_transformation("Starte Python-zu-Rust Transformation")
        
        # Vereinfachte Transformation (in Realität viel komplexer)
        rust_code = python_code
        
        # Python-spezifische Syntax ersetzen
        rust_code = rust_code.replace("def ", "fn ")
        rust_code = rust_code.replace(":", " {")
        rust_code = rust_code.replace("True", "true")
        rust_code = rust_code.replace("False", "false")
        
        # Typ-Annotations hinzufügen (vereinfacht)
        for py_typ, rust_typ in self.typ_mapping.items():
            rust_code = rust_code.replace(f": {py_typ}", f": {rust_typ}")
        
        self.log_transformation("Transformation abgeschlossen")
        return rust_code

# Erweiterte Signalverarbeitung für KeyRecognition (Tristan)
class SignalProcessor(ABC):
    """Abstrakte Basis für alle Signalprozessoren"""
    
    @abstractmethod
    def verarbeite(self, signal_data):
        pass

class FilterProcessor(SignalProcessor):
    """Signalfilter-Prozessor"""
    
    def __init__(self, filter_typ: str, grenzfrequenz: float):
        self.filter_typ = filter_typ
        self.grenzfrequenz = grenzfrequenz
    
    def verarbeite(self, signal_data):
        # Vereinfachte Filterung
        print(f"Anwenden von {self.filter_typ}-Filter bei {self.grenzfrequenz} Hz")
        return signal_data  # In Realität würde hier gefiltert

class DemodulatorProcessor(SignalProcessor):
    """Demodulator für verschiedene Modulationsarten"""
    
    def __init__(self, modulation_typ: str):
        self.modulation_typ = modulation_typ
    
    def verarbeite(self, signal_data):
        print(f"Demodulation: {self.modulation_typ}")
        return signal_data

# Erweiterte PersonalPrinz-Architektur (Christopher) mit Berechtigungen
class Berechtigung(ABC):
    """Abstrakte Berechtigung"""
    
    @abstractmethod
    def hat_berechtigung(self, benutzer, aktion: str) -> bool:
        pass

class AdminBerechtigung(Berechtigung):
    """Administrator-Berechtigung - alle Aktionen erlaubt"""
    
    def hat_berechtigung(self, benutzer, aktion: str) -> bool:
        return True  # Admin darf alles

class MitarbeiterBerechtigung(Berechtigung):
    """Standard-Mitarbeiter-Berechtigung"""
    
    erlaubte_aktionen = ["eigene_daten_lesen", "urlaub_beantragen"]
    
    def hat_berechtigung(self, benutzer, aktion: str) -> bool:
        return aktion in self.erlaubte_aktionen

class BenutzerMitBerechtigung:
    """Benutzer mit Berechtigungssystem"""
    
    def __init__(self, name: str, berechtigung: Berechtigung):
        self.name = name
        self.berechtigung = berechtigung
    
    def kann_aktion_ausfuehren(self, aktion: str) -> bool:
        return self.berechtigung.hat_berechtigung(self, aktion)

def demonstriere_projekt_integration():
    print("=== Projekt-Integration: OOP-Erweiterungen ===")
    
    # Py2Rust Transformer Demo
    transformer = PythonZuRustTransformer()
    python_code = """
def berechne_summe(a: int, b: int) -> int:
    return a + b
    """
    
    rust_code = transformer.transformiere(python_code)
    print("Python Code:")
    print(python_code)
    print("\nGenerierter Rust Code:")
    print(rust_code)
    print("\nTransformationslog:")
    transformer.zeige_log()
    
    # PersonalPrinz Berechtigungen Demo
    print(f"\n=== Berechtigungssystem Demo ===")
    admin = BenutzerMitBerechtigung("Admin", AdminBerechtigung())
    mitarbeiter = BenutzerMitBerechtigung("Alice", MitarbeiterBerechtigung())
    
    aktionen = ["alle_daten_lesen", "eigene_daten_lesen", "gehalt_aendern"]
    
    for aktion in aktionen:
        admin_kann = admin.kann_aktion_ausfuehren(aktion)
        mitarbeiter_kann = mitarbeiter.kann_aktion_ausfuehren(aktion)
        
        print(f"Aktion '{aktion}':")
        print(f"  Admin: {'✓' if admin_kann else '✗'}")
        print(f"  Mitarbeiter: {'✓' if mitarbeiter_kann else '✗'}")

demonstriere_projekt_integration()
```
