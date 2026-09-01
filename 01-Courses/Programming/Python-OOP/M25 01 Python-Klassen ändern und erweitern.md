- führt umfassend in die zentrale Praxis ein, bestehende Klassen in Python gezielt zu **erweitern**, Methoden zu überschreiben und eigene Funktionalitäten zu ergänzen.
- im Fokus stehen die Werkzeuge zum Anpassen und Ausbauen objektorientierter Programme

***
## Klassen erweitern – Motivation und Grundlagen

Das **Erweitern** von Klassen ist ein zentrales Konzept der objektorientierten Programmierung. 
Damit lassen sich bestehende Funktionalitäten gezielt auf neue Anforderungen anpassen, ohne den ursprünglichen Code grundlegend ändern zu müssen. 
Dies ist insbesondere bei großen, modular aufgebauten Projekten und in Teams essenziell.

- Vorteile:
    - Wiederverwendung von Code
    - Einfache Einführung neuer Features mit minimalen Änderungen
    - Klare Trennung zwischen Basisfunktionen (Elternklassen) und neuen Erweiterungen (Kindklassen)

**Beispiel:**
Angenommen, es gibt eine Basisklasse `Tier` und eine spezialisierte Klasse `Hund`, die zusätzliche Methoden oder Attribute erhält:

```python
class Tier:
    def sprich(self):
        print("Lautlos ...")

class Hund(Tier):
    def sprich(self):  # Methode wird überschrieben
        print("Wuff!")
```

Die Methode `sprich` in `Hund` überschreibt das Verhalten aus `Tier`. Ruft man `Hund().sprich()`, erzeugt dies "Wuff!".

***

## Methoden überschreiben (Override)

Das **Überschreiben** (Overriding) ist eine Technik, mit der abgeleitete Klassen Methoden ihrer Elternklasse an eigene Bedürfnisse anpassen. 
Dadurch können spezialisierte Objekte ihr Verhalten eigenständig bestimmen – ein Schlüsselelement für flexiblen, wartbaren Code.

- Die Methode muss in der abgeleiteten Klasse mit derselben Signatur erneut definiert werden.
- Das ursprüngliche Verhalten kann bei Bedarf weiterhin mit `super()` aufgerufen werden.

**Beispiel:**

```python
class Mitarbeiter:
    def info(self):
        print("Standard-Mitarbeiter")

class Manager(Mitarbeiter):
    def info(self):
        super().info()  # Optional: Basisfunktionalität einbeziehen
        print("Besonderer Status: Manager")
```

Dies erlaubt maßgeschneiderte Logik für jeweils spezialisierte Unterarten einer Klasse.

***

## Neue Funktionalitäten hinzufügen

Ergänzungen durch neue Methoden und Attribute machen Klassen **vielfältiger nutzbar**. 
So lassen sich bestehende Lösungen gezielt auf neue Anforderungen ausbauen, ohne Code-Duplikation oder Brüche im System-Design.

**Beispiel:**
Ausbau einer Klasse um zusätzliche Spezialmethode:

```python
class Mitarbeiter:
    def __init__(self, name):
        self.name = name

class Entwickler(Mitarbeiter):
    def programmiere(self, sprache):
        print(f"{self.name} programmiert in {sprache}.")
```

Diese Ergänzung macht die Klasse für neue Anwendungsfälle fit.

***

## Praxis: Anwendung der Erweiterung und Überschreibung

Das Zusammenspiel aus **Vererbung**, **Methodenüberschreibung** und **neuen Features** ist die Grundlage für wartbare, erweiterbare Software:

```python
class Fahrzeug:
    def beschreibung(self):
        print("Allgemeines Fahrzeug.")

class EAuto(Fahrzeug):
    def beschreibung(self):
        print("Elektrofahrzeug mit spezieller Batterie.")

    def lade_batterie(self):
        print("Batterie wird geladen.")
```

- Die Instanz von `EAuto` nutzt ein spezialisiertes Verhalten für `beschreibung` und bietet mit `lade_batterie` eine exklusive Methode.

***

## Schritt-für-Schritt-Beispiel: Methoden überschreiben und funktionale Ergänzungen

**1. Basisklasse definieren:**

```python
class Konto:
    def __init__(self, inhaber, stand=0):
        self.inhaber = inhaber
        self.stand = stand

    def einzahlen(self, betrag):
        self.stand += betrag

    def info(self):
        print(f"{self.inhaber}, Stand: {self.stand} EUR")
```

**2. Spezialisierte Klasse ableiten, Methode überschreiben und neue Methode hinzufügen:**

```python
class Sparkonto(Konto):
    def info(self):
        print(f"{self.inhaber}, Sparkonto: {self.stand} EUR, Zinsen: 0.5% p.a.")

    def zinsen_berechnen(self):
        return self.stand * 0.005
```

**3. Anwendung:**

```python
k = Sparkonto("Müller", 1000)
k.einzahlen(500)
k.info()                # "Müller, Sparkonto: 1500 EUR, Zinsen: 0.5% p.a."
print(k.zinsen_berechnen())  # 7.5
```

Diese Beispiele demonstrieren, wie mühelos Python-Klassen **erweitert** und individuell angepasst werden – ein Grundpfeiler moderner Softwareentwicklung.

***

## Zusammenfassung

- **Klassen erweitern, Methoden überschreiben und gezielt ergänzen** ist die Basis für flexible, langlebige Python-Anwendungsarchitekturen.
- Die Techniken garantieren eine professionelle **Wiederverwendbarkeit**, starke Erweiterbarkeit und bieten saubere Strukturen für eigene Projekte im Kurs.

```python

```
