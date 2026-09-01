Das Modul umfasst Instanzmethoden, Klassenmethoden, statische Methoden und die wichtigsten Magic Methods wie `__str__`, `__repr__` oder `__eq__`. Die Python-Beispiele sind ausführbar und demonstrieren mehrere Varianten mit Erklärungen und Anwendungsbezügen für reale Projekte.

***

## Überblick zu M24: Schwerpunkte und Lernziele

Das Modul M24 behandelt die **verschiedenen Arten von Methoden in Python-Klassen** sowie deren Einsatzmöglichkeiten. Es legt den Fokus auf:

- Instanzmethoden
- Klassenmethoden (`@classmethod`)
- Statische Methoden (`@staticmethod`)
- Magic Methods (`__str__`, `__repr__`, `__eq__`)

Diese Techniken sind für alle Teilnehmerprojekte essentiell – insbesondere zur **Datenhaltung**, **Objektverwaltung** und beim Zugriff auf exemplarische oder globale Kontexte in OOP.

***

## Instanzmethoden: Das Standardwerkzeug jeder Klasse

Instanzmethoden operieren auf dem aktuellen Objekt (`self`) und dürfen auf alle Instanzattribute zugreifen. Typische Beispiele:

```python
class Mitarbeiter:
    def __init__(self, vorname, nachname):
        self.vorname = vorname
        self.nachname = nachname
        self.gehalt = 0

    def set_gehalt(self, betrag):
        self.gehalt = betrag

    def get_info(self):
        return f"{self.vorname} {self.nachname}: {self.gehalt} €"

# Demonstration (PersonalPrinz/Projekt 03)
anna = Mitarbeiter("Anna", "Müller")
anna.set_gehalt(3200)
print(anna.get_info())  # Ausgabe: Anna Müller: 3200 €
```

Mit Instanzmethoden wird die logische Kapselung von Daten und Verhalten umgesetzt. Für Aufgaben wie **Urlaubsbuchung**, **Stundenerfassung** oder Ähnliches (PersonalPrinz) sind sie zentral.

***

## Klassenmethoden: `@classmethod` und gemeinsamer Kontext

Klassenmethoden werden mit der Dekorator-Syntax ausgezeichnet und arbeiten mit dem Klassentyp (`cls`), nicht mit einzelnen Objekten:

```python
class Mitarbeiter:
    mitarbeiter_liste = []

    def __init__(self, vorname, nachname):
        self.vorname = vorname
        self.nachname = nachname
        Mitarbeiter.mitarbeiter_liste.append(self)

    @classmethod
    def anzahl_mitarbeiter(cls):
        return len(cls.mitarbeiter_liste)

# Demonstration
a = Mitarbeiter("Anna", "Müller")
b = Mitarbeiter("Ben", "Meier")
print(Mitarbeiter.anzahl_mitarbeiter())  # Ausgabe: 2
```

Praktisch: Klassenmethoden ermöglichen **globale Auswertungen** oder das Anlegen von sog. *Factory-Methoden* (z. B. zum Laden von Objekten aus CSV für PersonalPrinz oder als alternative Objekt-Initialisierung).

***

## Statische Methoden: `@staticmethod` – reine Hilfsfunktionen

Statische Methoden benötigen weder Objekt noch Klasse als Kontext und sind ausgelagerte Hilfsfunktionen, die logisch zur Klasse gehören:

```python
class Mathematik:
    @staticmethod
    def ist_primzahl(n):
        if n < 2: return False
        for i in range(2, int(n ** 0.5) + 1):
            if n % i == 0:
                return False
        return True

print(Mathematik.ist_primzahl(7))  # True
print(Mathematik.ist_primzahl(10)) # False
```

In praxisnahen Projekten wie **Signalverarbeitung** (KeyRecognition) können statische Methoden zur Validierung oder schnellen Berechnung eingesetzt werden – ohne Objektstatus.

***

## Magic Methods: `__str__`, `__repr__`, `__eq__` und Co.

Magic Methods werden vom Python-Interpreter automatisch aufgerufen und bieten Eleganz und Komfort für Objektdarstellung und Vergleiche:

```python
class Mitarbeiter:
    def __init__(self, vorname, nachname):
        self.vorname = vorname
        self.nachname = nachname

    def __repr__(self):
        return f"Mitarbeiter({self.vorname!r}, {self.nachname!r})"

    def __str__(self):
        return f"{self.vorname} {self.nachname}"

    def __eq__(self, other):
        return (self.vorname, self.nachname) == (other.vorname, other.nachname)

# Demonstration
a = Mitarbeiter("Anna", "Müller")
b = Mitarbeiter("Anna", "Müller")
print(repr(a))   # Mitarbeiter('Anna', 'Müller')
print(str(a))    # Anna Müller
print(a)         # im Kontext on print wird str() automastisch aufgerufen
print(a == b)    # True
```

Diese Methoden sind unerlässlich für **Logging**, **Vergleiche in Auswertungen** und die **Testautomatisierung** in allen Kursprojekten.

***

## Kombinierte Demonstrationen mit Bezug zu Kursprojekten

### Beispiel 1: Signal-Klassen mit Methodenvielfalt (KeyRecognition)

```python
import numpy as np

class KeySignal:
    def __init__(self, iqdata, samplingrate, desc=None):
        self.iqdata = iqdata
        self.samplingrate = samplingrate
        self.desc = desc
        self.modulation = None
        self.features = {}

    def set_modulation(self, modulationtype):
        self.modulation = modulationtype

    def demodulate(self):
        if self.modulation == "ASK":
            return np.abs(self.iqdata)
        elif self.modulation == "PSK":
            return np.angle(self.iqdata)
        else:
            raise NotImplementedError("Modulation nicht unterstützt")

    def extract_features(self):
        self.features = {
            "mean_ampl": np.mean(np.abs(self.iqdata)),
            "std_ampl": np.std(np.abs(self.iqdata)),
            "mean_phase": np.mean(np.angle(self.iqdata)),
            "std_phase": np.std(np.angle(self.iqdata)),
        }
        return self.features

    def __repr__(self):
        return f"KeySignal({self.desc}, Modulation={self.modulation})"

# Simulation und Featureberechnung
fs = 10000
t = np.arange(0, 0.01, 1/fs)
bits = np.random.choice([0, 1], size=len(t))
carrier = np.exp(1j * 2 * np.pi * 2000 * t)
iqask = bits * carrier

signal = KeySignal(iqask, fs, desc="Demo ASK")
signal.set_modulation("ASK")
demod = signal.demodulate()
print(f"Extrahierte Features: {signal.extract_features()}")
print(signal)
```

Dieses Beispiel zeigt die Nutzung aller Methodentypen in einer realitätsnahen Klasse. Anpassbar für Projektthemen wie automatisierte Signalzuordnung oder zeitbasierte Analytik.

***

## Typische Aufgabenstellungen und Transfer auf eigene Projekte

- **PersonalPrinz:** Unterschied zwischen Instanz-/Klassenmethoden klären (z.B. Objekt speichern vs. Abfrage aller Benutzer).
- **WetterWeiser:** Statistische Analysen als Instanzmethoden, Importfunktionen als Klassenmethoden.
- **KeyRecognition:** Signalverarbeitung, Feature-Berechnung als Instanzmethoden, Validierungen als statische Methoden.
- **Py2Rust:** Factory-Methoden für Import/Export, Magic Methods für bessere Code-Analyse-Ausgaben.

**Lösungshinweise und Musterlösungen** werden für Dozenten jeweils projektbezogen als separate Dateien bereitgestellt.

***

## Fazit \& Praxistipps

- Instanzmethoden für operationale Logik!
- Klassendaten und alternative Konstruktoren via `@classmethod`.
- Statische Methoden für Hilfswerkzeuge ohne Objektbezug.
- Magic Methods für bessere Integration, Logging und funktionale Tests im OOP-Kontext.
- Vielfältig anpassbar für kleine und große Projekte.

Diese Unterlage deckt alle **Kernaspekte von M24 mit voll lauffähigen Python-Beispielen** ab, die direkt im Kurs und in den Projekten vertieft werden können.