## 1. Grundlagen: Objektattribute & Konstruktoren

Der **Konstruktor** ist eine spezielle Methode (`__init__`), die aufgerufen wird, wenn ein Objekt angelegt wird. Objektattribute speichern den internen Zustand eines Objekts.

```python
class Hund:
    def __init__(self, name, alter):  # Konstruktor
        self.name = name              # Instanzattribute
        self.alter = alter

hund1 = Hund("Fritz", 3)
print(hund1.name)  # Fritz
print(hund1.alter) # 3
```

**Praktische Bedeutung:** Ohne Konstruktor bleiben Objekte leer; erst beim Erstellen werden die Parameter „gebunden“. Die Instanzattribute gehören jedem einzelnen Objekt und können individuell gesetzt werden.

***

## 2. Instanzattribute vs. Klassenattribute

**Instanzattribute** sind an einzelne Objekte gebunden, **Klassenattribute** teilen sich alle Instanzen.

```python
class Katze:
    art = "Hauskatze"  # Klassenattribut

    def __init__(self, name):
        self.name = name

katze1 = Katze("Minka")
katze2 = Katze("Moritz")

print(katze1.art)   # Hauskatze (über die Klasse)
print(katze2.art)   # Hauskatze
print(katze1.name)  # Minka

Katze.art = "Wildkatze"     # Änderung wirkt auf alle Instanzen!
print(katze1.art)           # Wildkatze
```

**Demonstration:** Das Attribut „art“ ist für ALLE Katzen gleich. Die Namen sind jeweils anders, da sie Instanzattribute sind.

***

## 3. Getter \& Setter – kontrollierte Zugriffe

Im Praxisalltag sollen Attribute manchmal „geschützt“ sein. **Getter- und Setter-Methoden** kontrollieren, wie gelesen und gesetzt wird.

```python
class Auto:
    def __init__(self):
        self._kilometerstand = 0   # führendes _ für "geschützt"

    def get_kilometerstand(self):
        return self._kilometerstand

    def set_kilometerstand(self, wert):
        if wert >= self._kilometerstand:
            self._kilometerstand = wert
        else:
            print("Kilometerstand kann nicht zurückgesetzt werden.")

mein_auto = Auto()
mein_auto.set_kilometerstand(500)
print(mein_auto.get_kilometerstand())  # 500
mein_auto.set_kilometerstand(300)      # Meldung: Rücksetzen nicht erlaubt
```

**Praxisbezug:** In professionellen Anwendungen sollen Werte nur unter bestimmten Bedingungen geändert werden können.

***

## 4. Properties – Pythonische Getter/Setter

Mit `@property` und dem zugehörigen Dekorator kann eleganter und pythonesker programmiert werden.

```python
class Kreis:
    def __init__(self, radius):
        self._radius = radius

    @property
    def radius(self):
        return self._radius

    @radius.setter
    def radius(self, r):
        if r > 0:
            self._radius = r
        else:
            raise ValueError("Radius muss positiv sein.")

k = Kreis(5)
print(k.radius)    # 5
k.radius = 10      # Setter, legal
try:
    k.radius = -2  # Unzulässig
except ValueError as e:
    print(e)       # Radius muss positiv sein.
```

**Erklärung:** So können Attribute wie Variablen behandelt werden (k.radius), bleiben aber validierbar.

***

## 5. Methoden: Vom Funktionsbaustein zur Objektaktion

**Methoden** sind Funktionen, die an die Klasse gebunden sind und auf deren Attribute zugreifen können.

```python
class Konto:
    def __init__(self, inhaber):
        self.inhaber = inhaber
        self.saldo = 0

    def einzahlen(self, betrag):
        self.saldo += betrag

    def auszahlen(self, betrag):
        if betrag <= self.saldo:
            self.saldo -= betrag
        else:
            print("Nicht genug Guthaben.")

meinkonto = Konto("Christian")
meinkonto.einzahlen(100)
meinkonto.auszahlen(30)
print(meinkonto.saldo)  # 70
```

**Praxis:** Methoden greifen auf Attribute zu und verändern den Zustand des Objekts.

***

## 6. Demonstrationsaufgaben für Kursprojekte

### Projekt Fritz - Py2Rust

- **Aufgabe:** Implementiere in einer Klasse Attribute für Dateiname, Status und Konvertierungslogik mit Property-Dekoratoren (Validierung des Dateinamens).
- **Lösungshinweis:** Getter/Setter für den Dateinamen, Methode zur Statusaktualisierung.


### Projekt Christian - WetterWeiser

- **Aufgabe:** Erstelle eine Wetterdatenklasse mit Instanzattributen für Temperatur, Niederschlag etc., nutze Properties zum Validieren der Temperaturwerte.
- **Lösungshinweis:** Methoden für Monats- und Jahresauswertung; Setter verhindert negative Werte.


### Projekt Christopher - PersonalPrinz

- **Aufgabe:** Implementiere Instanzattribute für Mitarbeiterdaten mit Methode zur Urlaubsbuchung und Property zur Validierung der Arbeitszeitmodelle.
- **Lösungshinweis:** geschützte Attribute, Property für Arbeitszeitmodell, Getter für Resturlaub.


### Projekt Tristan - KeyRecognition

- **Aufgabe:** Signalobjekt mit Instanzattributen für IQ-Daten und Samplingrate, Property zur Modulationsart, Methode zur Feature-Extraktion.
- **Lösungshinweis:** Über Property lässt sich Modulationsart nur auf bekannte Werte setzen.

***

## 7. Lösungen Projekt Fritz - Py2Rusts

Ein vollständiges Beispiel inkl. Property, Getter/Setter und Methoden, kommentiert zur Migrationsvorbereitung (ausführlich und kompatibel für eine spätere Übertragung nach Rust):

```python
class DateiTranspiler:
    def __init__(self, filename):
        self._filename = filename
        self.status = "init"
    
    @property
    def filename(self):
        return self._filename
    
    @filename.setter
    def filename(self, value):
        if value.endswith(".py"):
            self._filename = value
        else:
            raise ValueError("Nur .py-Dateien werden akzeptiert!")

    def convert(self):
        self.status = "converting"
        # Hier folgt die Umwandlungslogik
        self.status = "done"

# Migration nach Rust: Führe Property als get/set Methoden, status als struct-Feld, Logik als Methoden aus.
```


***

## 8. Bedeutung in der Praxis

Objektattribute und deren Methoden sind **das Herzstück der OOP**. Sie ermöglichen:

- Strukturierte, sichere Datenverwaltung
- Wiederverwendbare, erweiterbare Programme
- Validierung und Überwachung relevanter Zustände
