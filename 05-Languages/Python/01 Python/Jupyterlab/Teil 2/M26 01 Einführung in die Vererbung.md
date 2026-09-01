- ist ein zentraler Meilenstein für alle, die komplexe Software mit wiederverwendbaren, erweiterbaren Klassenstrukturen entwickeln und verstehen möchten.

***

## Was ist Vererbung?

Vererbung ist ein OOP-Prinzip, bei dem eine Klasse (die „Kindklasse“ oder „abgeleitete Klasse“) die Eigenschaften und Methoden einer anderen, sogenannten „Basisklasse“ übernimmt. 
Dies ermöglicht die Strukturierung von Code in Hierarchien und macht die Wiederverwendung und Erweiterung von Programmfunktionen besonders effizient.

**Beispiel:** Ein Basisklasse `Fahrzeug` kann Eigenschaften wie `anzahl_raeder` und Methoden wie `fahren()` definieren. Eine Kindklasse `Auto` erbt diese und kann eigene Attribute oder Methoden ergänzen.

```python
class Fahrzeug:
    def __init__(self, anzahl_raeder):
        self.anzahl_raeder = anzahl_raeder

    def fahren(self):
        print(f"Fährt auf {self.anzahl_raeder} Rädern.")

class Auto(Fahrzeug):
    def __init__(self, marke):
        super().__init__(4)
        self.marke = marke

auto = Auto("VW")
auto.fahren()       # Ausgabe: Fährt auf 4 Rädern.
print(auto.marke)   # Ausgabe: VW
```

Dieses Beispiel zeigt, wie die Methode `fahren()` und das Attribut `anzahl_raeder` der Basisklasse in der Kindklasse zur Verfügung stehen.

***

## Typen und Konzepte der Vererbung

- **Basisklassen \& Kindklassen:** 
	- Die Basisklasse definiert allgemeine Attribute/Methoden; 
	- die Kindklasse erweitert oder überschreibt sie.
- **super():** 
	- Mit der Funktion `super()` lassen sich Methoden der Basisklasse explizit aufrufen, 
		- z.B. zur Initialisierung.
- **Methoden überschreiben (Overriding):** 
	- Kindklassen können Methoden der Basisklasse mit eigener Logik überschreiben, 
		- um passendes Verhalten zu ermöglichen.

```python
class Tier:
    def geraeusch(self):
        return "Allgemeines Tiergeräusch"

class Hund(Tier):
    def geraeusch(self):
        return "Wau!"

tier = Tier()
hund = Hund()
print(tier.geraeusch())  # Allgemeines Tiergeräusch
print(hund.geraeusch())  # Wau!
```


***

## Praktische Vorteile von Vererbung

- **Code-Wiederverwendung:** 
	- Gemeinsame Logik kann zentral in Basisklassen definiert und in vielen Kindklassen genutzt werden.
- **Strukturierung \& Erweiterbarkeit:** 
	- Der Code wird übersichtlich, Änderbarkeit und Erweiterung durch zusätzliche Kindklassen wird vereinfacht.
- **Polymorphismus:** 
	- Durch Vererbung kann ein Objekt mehrere Formen annehmen – etwa indem Methoden überschrieben und kontextspezifisch angepasst werden.

***

## Typische Anwendungsbereiche

- Aufbau von Klassenhierarchien (z.B. `Fahrzeug → Auto → Elektroauto`)
- Entwicklung von flexiblen Schnittstellen und Frameworks, die durch Vererbung anpassbar sind
- Wiederverwendbare Basisklassen für Projekte, bei denen ähnliche Funktionalität oft benötigt wird

***

## Ausführliche Schritt-für-Schritt-Beispiele

### Beispiel 1: Konstruktor-Weitergabe

```python
class Mitarbeiter:
    def __init__(self, name):
        self.name = name

class Entwickler(Mitarbeiter):
    def __init__(self, name, sprache):
        super().__init__(name)
        self.sprache = sprache

dev = Entwickler("Anna", "Python")
print(dev.name, dev.sprache)  # Anna Python
```


### Beispiel 2: Mehrere Methoden und `super()`

```python
class Person:
    def begruessung(self):
        print("Guten Tag!")

class Kunde(Person):
    def begruessung(self):
        super().begruessung()
        print("Willkommen als Kunde!")

kunde = Kunde()
kunde.begruessung()
# Ausgabe:
# Guten Tag!
# Willkommen als Kunde!
```


### Beispiel 3: Erweiterung von Funktionalitäten

```python
class Konto:
    def __init__(self, kontostand):
        self.kontostand = kontostand

    def einzahlen(self, betrag):
        self.kontostand += betrag

class Sparkonto(Konto):
    def zinsen_gutschreiben(self, prozentsatz):
        self.kontostand *= (1 + prozentsatz/100)

skonto = Sparkonto(1000)
skonto.zinsen_gutschreiben(2)
print(skonto.kontostand)  # Ausgabe: 1020.0
```


***

## Fallstricke und Best Practices

- Die Initialisierung der Basisklasse sollte immer mit `super().__init__()` erfolgen, um Attribute korrekt zu übernehmen.
- Methoden sollten sinnvoll überschrieben und dokumentiert werden; ansonsten besteht die Gefahr von unerwünschtem Verhalten.
- Vererbung kann in mehrfachen Hierarchien und mit abstrakten Basisklassen komplex werden. Der sinnvolle Aufbau ist wesentlich für Wartbarkeit und Verständlichkeit.
