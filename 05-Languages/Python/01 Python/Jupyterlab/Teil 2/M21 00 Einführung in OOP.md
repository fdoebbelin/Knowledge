## Überblick zu M21 – Einführung in OOP

- **Schwerpunkte:** Was sind Klassen, Objekte und Methoden, wann und warum werden sie eingesetzt.
- **Vergleich:** Funktionale (nur mit Funktionen) und objektorientierte (mit Klassen/Objekten) Strukturen.[^1]

***

## Zentrale OOP-Konzepte in Python

### Klasse und Objekt

```python
# Definition einer einfachen Klasse
class Hund:
    def __init__(self, name, alter):
        self.name = name
        self.alter = alter
        
    def bellen(self):
        print(f"{self.name} sagt: Wuff!")

# Erzeugen einer Objektinstanz und Methodenaufruf
mein_hund = Hund("Bello", 5)
mein_hund.bellen()  # Ausgabe: Bello sagt: Wuff!
```

- `__init__()` ist der Konstruktor und initialisiert das Objekt.
- `self` steht immer für das aktuelle Objekt.[^1]


### Datentypen sinnvoll gruppieren

```python
# Beispiel: Klasse für Mitarbeitende, wie im Projekt „PersonalPrinz“
class Mitarbeiter:
    def __init__(self, personalnummer, name):
        self.personalnummer = personalnummer
        self.name = name
        self.stundenkonto = 0
        
    def arbeite(self, stunden):
        self.stundenkonto += stunden

    def __repr__(self):
        return f"{self.name} (Nr. {self.personalnummer}): {self.stundenkonto} Std."

m1 = Mitarbeiter(101, "Anna Muster")
m2 = Mitarbeiter(102, "Max Beispiel")
m1.arbeite(3)
m2.arbeite(5)
print(m1)
print(m2)
```

Hier werden Eigenschaften und Verhalten eines Mitarbeiters gemeinsam betrachtet.[^3]

***

## OOP vs. Funktionale Programmierung im Vergleich

| Aspekt | Funktional (nur Funktionen) | OOP (mit Klassen/Objekten) |
| :-- | :-- | :-- |
| Organisation | wenig Struktur, oft globale Daten | klare Objektstruktur |
| Wiederverwendung | Funktionskopplung | mittels Vererbung/Erweiterung |
| Wartbarkeit | schwierig bei wachsendem Umfang | gute Skalierbarkeit und Übersicht |
| Praxisnutzen | kleine Aufgaben | mittlere bis große Programme |

**Beispiel:** Wetterdaten als nur Funktionsaufruf vs. als Klasse, die Methoden zur Analyse besitzt.[^4]

***

## Interaktive OOP-Demonstrationen

### Von Daten zu Objekten

```python
# a) Nur als Dictionary
hund = {"name": "Rex", "alter": 2}
print(hund["name"])

# b) Gleiches als Klasse
class Hund:
    def __init__(self, name, alter):
        self.name = name
        self.alter = alter

rex = Hund("Rex", 2)
print(rex.name)
```

OOP kapselt dabei beides: Daten und zugehöriges Verhalten.[^1]

### Methoden mit Wirkung – direkt sichtbar

```python
class Hund:
    def __init__(self, name, futter=100):
        self.name = name
        self.futter = futter
    def fressen(self, menge):
        self.futter += menge
    def __repr__(self):
        return f"{self.name} hat {self.futter}g Futter"

h = Hund("Luna", 100)
h.fressen(50)
print(h)  # Luna hat 150g Futter
```

Erweiterungen und Änderungen am Verhalten sind mit Methoden einfach umzusetzen.[^1]

***

## Fazit

- M21 liefert einen verständlichen und stark praxisorientierten Einstieg in die OOP mit Python.
- Die Beispiele zeigen Schritt für Schritt, wie Klassen und Objekte funktionieren, und verdeutlichen die Vorteile objektorientierter Lösungen gegenüber reinen Funktionsansätzen.
