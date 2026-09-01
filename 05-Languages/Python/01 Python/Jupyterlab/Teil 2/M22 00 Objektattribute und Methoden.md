## Modulübersicht M22

- **Konstruktoren und Objektinitialisierung**: Einführung in die `__init__`-Methode
- **Attributarten**: Instanz-, Klassen- und private Attribute
- **Methoden**: Von der Funktion zur Objektmethode
- **Getter/Setter und Properties**: Zugriffskontrolle auf Attribute
- **Praxisnahe Beispiele und schrittweise Demonstrationen**

***

## Konstruktoren in Python

Der *Konstruktor* wird durch die Methode `__init__` definiert. Er dient zur Initialisierung von Objektattributen unmittelbar bei der Objekterstellung.[^1]

```python
class Fahrzeug:
    def __init__(self, marke, geschwindigkeit):
        self.marke = marke
        self.geschwindigkeit = geschwindigkeit

auto = Fahrzeug("VW", 120)
print(auto.marke)           # Ausgabe: VW
print(auto.geschwindigkeit) # Ausgabe: 120
```

*Praxisrelevanz:* Konstruktoren sorgen dafür, dass jedes Objekt eigene, konsistente Startwerte erhält.[^1]

***

## Instanz-, Klassen- und private Attribute

**Instanzattribute** sind objektspezifisch, **Klassenattribute** gelten für alle Instanzen. **Private Attribute** (mit `_` oder `__` vor dem Namen) sind vor direktem Zugriff geschützt.[^1]

```python
class Hund:
    tierart = "Hund"              # Klassenattribut

    def __init__(self, name):
        self.name = name          # Instanzattribut
        self.__geheimnis = 42     # privates Attribut

h1 = Hund("Bello")
h2 = Hund("Wuffi")
print(h1.tierart, h2.tierart)     # Hund Hund
print(h1.name, h2.name)           # Bello Wuffi
print(h1._Hund__geheimnis)        # 42 (Namensmangling)
```

*Praxisrelevanz:* Mit privaten Attributen werden interne Zustände vor versehentlicher Änderung geschützt.[^1]

***

## Methoden: Von der Funktion zur Objektmethode

*Methoden* sind Funktionen, die innerhalb einer Klasse definiert sind und über `self` auf die Objekteigenschaften zugreifen.[^1]

```python
class BankKonto:
    def __init__(self, inhaber, saldo=0):
        self.inhaber = inhaber
        self.saldo = saldo

    def einzahlen(self, betrag):
        self.saldo += betrag
        print(f"{betrag} EUR eingezahlt. Neuer Saldo: {self.saldo}")

konto = BankKonto("Anna")
konto.einzahlen(100)    # 100 EUR eingezahlt. Neuer Saldo: 100
```

*Praxisrelevanz:* Methoden ermöglichen die Interaktion mit den Daten eines Objekts und bieten Funktionalität.[^1]

***

## Getter/Setter und Properties

**Getter** und **Setter** regeln den Zugriff auf Attribute. Mit `property` lässt sich eleganter kontrollieren, wie ein Attribut gelesen und geschrieben wird.[^1]

```python
class Temperatur:
    def __init__(self, wert):
        self._wert = wert

    @property
    def wert(self):
        return self._wert

    @wert.setter
    def wert(self, neuer_wert):
        if neuer_wert < -273.15:
            raise ValueError("Temperatur zu niedrig!")
        self._wert = neuer_wert

t = Temperatur(20)
print(t.wert)  # Ausgabe: 20
t.wert = 100   # Änderung möglich
# t.wert = -300 -> ValueError!
```

*Praxisrelevanz:* Properties sind wichtig für die Validierung von Daten und Kapselung von Logik beim Zugriff auf Attribute.[^1]

***

## Methoden vs. Funktionen: Vergleich



***

## Zusammenfassung Praxisrelevanz

- **Objektattribute und Methoden** sind Grundlage für eigene, robuste Klassen in realen Python-Projekten.[^1]
- **Properties** ermöglichen präzise Kontrolle über Datenzugriff und -änderung.
- **Konstruktoren und Methoden** sorgen für sinnvolle Initialisierung und Funktionalität von Objekten.
- Die Beispiele zeigen, wie diese Konzepte in produktiven Anwendungen direkt genutzt werden.

Diese Unterlage ermöglicht sowohl das schrittweise Live-Demonstrieren (Abwandlungen, Fehler provozieren usw.), als auch den direkten Bezug zur täglichen Programmierpraxis mit Python.