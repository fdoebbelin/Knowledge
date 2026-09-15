1. Grundkonzepte der OOP verstehen:

    - Klassen als Blaupausen für Objekte

    - Objekte als Instanzen von Klassen

    - Attribute zur Speicherung von Daten

    - Methoden zur Definition von Verhalten

2. Eine einfache Klasse definieren:

    - Verwendung des Schlüsselworts "class"

    - Implementierung des Konstruktors (__init__)

    - Hinzufügen von Attributen

3. Objekte erstellen und verwenden:

    - Instanziierung von Klassen

    - Zugriff auf Attribute und Methoden mit der Punktnotation

4. Methoden implementieren:

    - Definition von Methoden innerhalb der Klasse

    - Verwendung des "self"-Parameters

5. Datenkapselung einführen:

    - Private Attribute mit doppeltem Unterstrich (__) kennzeichnen

    - Getter- und Setter-Methoden implementieren

6. Vererbung anwenden:

    - Erstellung von Unterklassen

    - Überschreiben von Methoden

    - Verwendung der super()-Funktion

7. Polymorphismus nutzen:

    - Implementierung gleicher Methoden in verschiedenen Klassen

    - Verwendung von abstrakten Basisklassen

8. Spezielle Methoden kennenlernen:

    - Magische Methoden wie __str__, __repr__, __len__ etc.

9. Klassenattribute und -methoden verwenden:

    - Unterscheidung zwischen Instanz- und Klassenattributen

    - Implementierung von Klassenmethoden mit @classmethod

10. Fortgeschrittene Konzepte erkunden:

    - Mehrfachvererbung

    - Abstrakte Klassen und Methoden

    - Properties und Dekoratoren

11. Best Practices anwenden:

    - Sinnvolle Benennung von Klassen, Methoden und Attributen

    - Einhaltung von PEP 8 (Python-Stilrichtlinien)

    - Dokumentation mit Docstrings

12. Praktische Übungen durchführen:

    - Entwicklung kleiner OOP-Projekte

    - Refaktorisierung von prozeduralem Code zu OOP

  

Diese Schritte bieten einen strukturierten Weg, um die objektorientierte Programmierung in Python zu erlernen und anzuwenden. Es ist wichtig, jeden Schritt gründlich zu üben und zu verstehen, bevor man zum nächsten übergeht.

  

<div>⁂</div>

  

[^1_1]: https://kinsta.com/de/blog/objektorientierten-programmierung-python/

  

[^1_2]: https://www.studysmarter.de/schule/informatik/programmiersprachen/objektorientierte-programmierung-python/

  

[^1_3]: https://codinghour.ai/python-tutorial/objektorientierte-programmierung-in-python/

  

[^1_4]: https://www.siemens-gymnasium-berlin.de/2-oop-mit-python-erste-schritte-v24

  

[^1_5]: https://datascientest.com/de/objektorientierte-programmierung-oop-der-ultimative-leitfaden

  

[^1_6]: https://www.python-lernen.de/oop-objektorientierte-programmierung-grundlagen.htm

  

[^1_7]: https://www.python-kurs.eu/klassen.php

  

---

  

# für die punkte 2 bis 5 dieser Liste möchte ich an einer konkreten Beispielklasse innerhalb der IDLE-Shell ein Modul mit einer Klassendeklaration schrittweise aufbauen, das Skript soll so aufgebaut werden, dass es als in Obsidian-Dokument gespeichert werden kann und immer im Wechsel den Python-Code und die entsprechenden Erklärungen enthält. Die Änderungen des Moduls mit der Klasse soll mit der importlib reload Funktion in der IDLE-Shell mit kurzen Befehlen getestet werden, wobei im Verlauf immer nur die Befehle aufgeführt werden sollen die bei einer gemeinsamen Sitzung für alle Veränderungen ausgeführt werden müssen, also nur einmal from importlib import reload, das skript sollte mit überschriften gegliedert werden

  

im punkt 5 soll mit property gearbeitet werden, ein Attribut sollte mit Name Mangling speziell geschützt werden, das auch testen, nur die jeweils geänderten oder hinzufügen Code Stücke angeben mit einfügestelle

  

Hier ist ein schrittweiser Aufbau einer Beispielklasse in Python, formatiert als Obsidian-Dokument mit Erklärungen und IDLE-Shell-Befehlen:

  

# Einführung in OOP mit Python: Schrittweiser Aufbau einer Klasse

  

## Vorbereitung

  

Erstellen Sie eine neue Python-Datei namens `fahrzeug.py` und öffnen Sie die IDLE-Shell.

  

In der IDLE-Shell:

  

```python

from importlib import reload

import fahrzeug

```

  
  

## 2. Eine einfache Klasse definieren

  

Fügen Sie folgenden Code in `fahrzeug.py` ein:

  

```python

class Fahrzeug:

    def __init__(self, marke, modell, baujahr):

        self.marke = marke

        self.modell = modell

        self.baujahr = baujahr

```

  

Diese Klasse definiert ein einfaches Fahrzeug mit den Attributen Marke, Modell und Baujahr. Der Konstruktor `__init__` wird aufgerufen, wenn ein neues Objekt erstellt wird.

  

In der IDLE-Shell:

  

```python

reload(fahrzeug)

mein_auto = fahrzeug.Fahrzeug("VW", "Golf", 2020)

print(mein_auto.marke, mein_auto.modell, mein_auto.baujahr)

```

  
  

## 3. Objekte erstellen und verwenden

  

Die Objekterstellung haben wir bereits im vorherigen Schritt durchgeführt. Lassen Sie uns ein weiteres Objekt erstellen und die Attribute vergleichen.

  

In der IDLE-Shell:

  

```python

anderes_auto = fahrzeug.Fahrzeug("BMW", "X3", 2022)

print(anderes_auto.marke, anderes_auto.modell, anderes_auto.baujahr)

print(mein_auto.marke == anderes_auto.marke)

```

  
  

## 4. Methoden implementieren

  

Fügen Sie folgende Methode zur `Fahrzeug`-Klasse in `fahrzeug.py` hinzu:

  

```python

def fahrzeug_info(self):

    return f"{self.marke} {self.modell} ({self.baujahr})"

```

  

Diese Methode gibt eine formatierte Zeichenkette mit den Fahrzeuginformationen zurück.

  

In der IDLE-Shell:

  

```python

reload(fahrzeug)

mein_auto = fahrzeug.Fahrzeug("VW", "Golf", 2020)

print(mein_auto.fahrzeug_info())

```

  
  

## 5. Datenkapselung einführen

  

Aktualisieren Sie die `Fahrzeug`-Klasse in `fahrzeug.py` wie folgt:

  

```python

class Fahrzeug:

    def __init__(self, marke, modell, baujahr):

        self.marke = marke

        self.modell = modell

        self.__baujahr = baujahr

        self.__kilometerstand = 0

  

    @property

    def baujahr(self):

        return self.__baujahr

  

    @property

    def kilometerstand(self):

        return self.__kilometerstand

  

    @kilometerstand.setter

    def kilometerstand(self, km):

        if km &gt;= 0:

            self.__kilometerstand = km

        else:

            print("Kilometerstand kann nicht negativ sein.")

  

    def fahrzeug_info(self):

        return f"{self.marke} {self.modell} ({self.baujahr}), Kilometerstand: {self.kilometerstand} km"

```

  

Hier haben wir `__baujahr` und `__kilometerstand` als private Attribute definiert. `baujahr` ist nur lesbar, während `kilometerstand` über eine Property mit Getter und Setter zugänglich ist. Der Setter verhindert negative Werte.

  

In der IDLE-Shell:

  

```python

reload(fahrzeug)

mein_auto = fahrzeug.Fahrzeug("VW", "Golf", 2020)

print(mein_auto.baujahr)

mein_auto.kilometerstand = 5000

print(mein_auto.fahrzeug_info())

mein_auto.kilometerstand = -100  # Dies sollte eine Warnung ausgeben

print(mein_auto.__baujahr)  # Dies sollte einen AttributeError verursachen

```

  

Diese Schritte demonstrieren die grundlegenden Konzepte der OOP in Python, einschließlich Klassendeklaration, Objekterstellung, Methodenimplementierung und Datenkapselung mit Properties und Name Mangling.

  

---

  

# jetzt das Skript im gleichen Stil für Punkt 6 bis 10 fortführen

  

Hier ist die Fortsetzung des Skripts für die Punkte 6 bis 10:

  

# Fortgeschrittene OOP-Konzepte in Python

  

## 6. Vererbung anwenden

  

Fügen Sie folgende Klasse am Ende von `fahrzeug.py` hinzu:

  

```python

class Elektroauto(Fahrzeug):

    def __init__(self, marke, modell, baujahr, batteriekapazitaet):

        super().__init__(marke, modell, baujahr)

        self.batteriekapazitaet = batteriekapazitaet

  

    def fahrzeug_info(self):

        return f"{super().fahrzeug_info()}, Batteriekapazität: {self.batteriekapazitaet} kWh"

```

  

Diese Klasse erbt von `Fahrzeug` und fügt ein spezifisches Attribut für Elektroautos hinzu.

  

In der IDLE-Shell:

  

```python

reload(fahrzeug)

mein_elektroauto = fahrzeug.Elektroauto("Tesla", "Model 3", 2023, 75)

print(mein_elektroauto.fahrzeug_info())

```

  
  

## 7. Polymorphismus nutzen

  

Fügen Sie eine neue Methode zur `Fahrzeug`-Klasse hinzu und überschreiben Sie sie in `Elektroauto`:

  

```python

class Fahrzeug:

    # ... (vorheriger Code bleibt unverändert)

  

    def tanken(self):

        return "Fahrzeug wird betankt."

  

class Elektroauto(Fahrzeug):

    # ... (vorheriger Code bleibt unverändert)

  

    def tanken(self):

        return "Elektroauto wird aufgeladen."

```

  

In der IDLE-Shell:

  

```python

reload(fahrzeug)

mein_auto = fahrzeug.Fahrzeug("VW", "Golf", 2020)

mein_elektroauto = fahrzeug.Elektroauto("Tesla", "Model 3", 2023, 75)

  

print(mein_auto.tanken())

print(mein_elektroauto.tanken())

```

  
  

## 8. Spezielle Methoden kennenlernen

  

Fügen Sie die `__str__`-Methode zur `Fahrzeug`-Klasse hinzu:

  

```python

class Fahrzeug:

    # ... (vorheriger Code bleibt unverändert)

  

    def __str__(self):

        return self.fahrzeug_info()

```

  

In der IDLE-Shell:

  

```python

reload(fahrzeug)

mein_auto = fahrzeug.Fahrzeug("VW", "Golf", 2020)

print(str(mein_auto))

```

  
  

## 9. Klassenattribute und -methoden verwenden

  

Fügen Sie ein Klassenattribut und eine Klassenmethode zur `Fahrzeug`-Klasse hinzu:

  

```python

class Fahrzeug:

    anzahl_fahrzeuge = 0

  

    def __init__(self, marke, modell, baujahr):

        self.marke = marke

        self.modell = modell

        self.__baujahr = baujahr

        self.__kilometerstand = 0

        Fahrzeug.anzahl_fahrzeuge += 1

  

    @classmethod

    def get_anzahl_fahrzeuge(cls):

        return cls.anzahl_fahrzeuge

  

    # ... (restlicher Code bleibt unverändert)

```

  

In der IDLE-Shell:

  

```python

reload(fahrzeug)

auto1 = fahrzeug.Fahrzeug("VW", "Golf", 2020)

auto2 = fahrzeug.Fahrzeug("BMW", "X3", 2022)

print(fahrzeug.Fahrzeug.get_anzahl_fahrzeuge())

```

  
  

## 10. Fortgeschrittene Konzepte erkunden

  

### Mehrfachvererbung

  

Fügen Sie eine neue Klasse hinzu, die Mehrfachvererbung demonstriert:

  

```python

class Fahrzeug:

    # ... (vorheriger Code bleibt unverändert)

  

class Elektroauto(Fahrzeug):

    # ... (vorheriger Code bleibt unverändert)

  

class Amphibienfahrzeug:

    def __init__(self, schwimmgeschwindigkeit):

        self.schwimmgeschwindigkeit = schwimmgeschwindigkeit

  

    def schwimmen(self):

        return f"Schwimmt mit {self.schwimmgeschwindigkeit} km/h"

  

class ElektrischesAmphibienfahrzeug(Elektroauto, Amphibienfahrzeug):

    def __init__(self, marke, modell, baujahr, batteriekapazitaet, schwimmgeschwindigkeit):

        Elektroauto.__init__(self, marke, modell, baujahr, batteriekapazitaet)

        Amphibienfahrzeug.__init__(self, schwimmgeschwindigkeit)

  

    def fahrzeug_info(self):

        return f"{super().fahrzeug_info()}, {self.schwimmen()}"

```

  
  

### Abstrakte Klassen und Methoden

  

Fügen Sie eine abstrakte Basisklasse hinzu:

  

```python

from abc import ABC, abstractmethod

  

class AbstractFahrzeug(ABC):

    @abstractmethod

    def fahren(self):

        pass

  

class Fahrzeug(AbstractFahrzeug):

    # ... (vorheriger Code bleibt unverändert)

  

    def fahren(self):

        return f"{self.marke} {self.modell} fährt."

```

  

In der IDLE-Shell:

  

```python

reload(fahrzeug)

amphibien_auto = fahrzeug.ElektrischesAmphibienfahrzeug("Amphi", "E-Swim", 2024, 100, 10)

print(amphibien_auto.fahrzeug_info())

  

normales_auto = fahrzeug.Fahrzeug("VW", "Golf", 2020)

print(normales_auto.fahren())

```

  

Diese Erweiterungen demonstrieren fortgeschrittene OOP-Konzepte wie Vererbung, Polymorphismus, spezielle Methoden, Klassenattribute und -methoden, Mehrfachvererbung und abstrakte Klassen in Python. Jeder Schritt baut auf dem vorherigen auf und erweitert die Funktionalität und Komplexität der `Fahrzeug`-Klasse und ihrer Ableitungen.

  

---

  

# Formuliere eine Aufgabe mit Lösungshinweisen und Lösung, die alle beschriebenen Themen 2 bis 10 noch einmal übt

  

Hier ist eine umfassende Aufgabe mit Lösungshinweisen und Lösung, die alle beschriebenen Themen von 2 bis 10 noch einmal übt:

  

## Aufgabe: Entwicklung eines Bibliotheksverwaltungssystems

  

Entwickeln Sie ein einfaches Bibliotheksverwaltungssystem unter Verwendung der OOP-Konzepte in Python. Das System soll folgende Anforderungen erfüllen:

  

1. Erstellen Sie eine abstrakte Basisklasse `Medientyp`.

2. Implementieren Sie Klassen für `Buch` und `DVD`, die von `Medientyp` erben.

3. Erstellen Sie eine Klasse `Bibliothek`, die eine Sammlung von Medien verwaltet.

4. Implementieren Sie eine Klasse `Benutzer` für Bibliotheksnutzer.

5. Verwenden Sie Datenkapselung, um sensible Daten zu schützen.

6. Implementieren Sie spezielle Methoden wie `__str__` und `__eq__`.

7. Verwenden Sie Klassenattribute und -methoden.

8. Demonstrieren Sie Polymorphismus bei der Verwaltung verschiedener Medientypen.

9. Implementieren Sie eine Mixin-Klasse `Ausleihbar` für ausleihbare Medien.

  

### Lösungshinweise:

  

1. Verwenden Sie `abc.ABC` und `@abstractmethod` für die abstrakte Basisklasse.

2. Implementieren Sie gemeinsame Attribute und Methoden in der Basisklasse.

3. Nutzen Sie Properties für kontrollierte Zugriffe auf Attribute.

4. Verwenden Sie Name Mangling für private Attribute.

5. Implementieren Sie `__str__`, `__repr__` und `__eq__` in relevanten Klassen.

6. Nutzen Sie ein Klassenattribut in `Bibliothek` zur Verfolgung der Gesamtanzahl der Medien.

7. Implementieren Sie eine Klassenmethode zur Abfrage der Gesamtanzahl der Medien.

8. Verwenden Sie Vererbung und überschreiben Sie Methoden, wo es sinnvoll ist.

9. Nutzen Sie Mehrfachvererbung für die `Ausleihbar`-Mixin-Klasse.

  

### Lösung:

  

```python

from abc import ABC, abstractmethod

from datetime import date, timedelta

  

class Medientyp(ABC):

    def __init__(self, titel, autor_oder_regisseur, jahr):

        self.titel = titel

        self.autor_oder_regisseur = autor_oder_regisseur

        self.jahr = jahr

        self.__ausgeliehen = False

  

    @abstractmethod

    def info(self):

        pass

  

    @property

    def ausgeliehen(self):

        return self.__ausgeliehen

  

    @ausgeliehen.setter

    def ausgeliehen(self, wert):

        self.__ausgeliehen = wert

  

    def __str__(self):

        return f"{self.titel} von {self.autor_oder_regisseur} ({self.jahr})"

  

    def __eq__(self, other):

        if isinstance(other, Medientyp):

            return (self.titel, self.autor_oder_regisseur, self.jahr) == (other.titel, other.autor_oder_regisseur, other.jahr)

        return False

  

class Ausleihbar:

    def ausleihen(self, benutzer):

        if not self.ausgeliehen:

            self.ausgeliehen = True

            return f"{self.titel} wurde an {benutzer.name} ausgeliehen."

        return f"{self.titel} ist bereits ausgeliehen."

  

    def zurückgeben(self):

        if self.ausgeliehen:

            self.ausgeliehen = False

            return f"{self.titel} wurde zurückgegeben."

        return f"{self.titel} war nicht ausgeliehen."

  

class Buch(Medientyp, Ausleihbar):

    def __init__(self, titel, autor, jahr, isbn):

        super().__init__(titel, autor, jahr)

        self.isbn = isbn

  

    def info(self):

        return f"Buch: {super().__str__()} - ISBN: {self.isbn}"

  

class DVD(Medientyp, Ausleihbar):

    def __init__(self, titel, regisseur, jahr, laufzeit):

        super().__init__(titel, regisseur, jahr)

        self.laufzeit = laufzeit

  

    def info(self):

        return f"DVD: {super().__str__()} - Laufzeit: {self.laufzeit} Minuten"

  

class Bibliothek:

    anzahl_medien = 0

  

    def __init__(self, name):

        self.name = name

        self.medien = []

  

    def medium_hinzufügen(self, medium):

        self.medien.append(medium)

        Bibliothek.anzahl_medien += 1

  

    def medium_entfernen(self, medium):

        if medium in self.medien:

            self.medien.remove(medium)

            Bibliothek.anzahl_medien -= 1

  

    def alle_medien_anzeigen(self):

        return [medium.info() for medium in self.medien]

  

    @classmethod

    def get_anzahl_medien(cls):

        return cls.anzahl_medien

  

class Benutzer:

    def __init__(self, name, ausweisnummer):

        self.name = name

        self.__ausweisnummer = ausweisnummer

  

    @property

    def ausweisnummer(self):

        return self.__ausweisnummer

  

    def __str__(self):

        return f"Benutzer: {self.name} (Ausweis: {self.__ausweisnummer})"

  

# Testen des Systems

if __name__ == "__main__":

    # Erstellen einer Bibliothek

    stadtbibliothek = Bibliothek("Stadtbibliothek Magdeburg")

  

    # Erstellen von Medien

    buch1 = Buch("Der Zauberberg", "Thomas Mann", 1924, "978-3596294336")

    buch2 = Buch("1984", "George Orwell", 1949, "978-3548234106")

    dvd1 = DVD("Inception", "Christopher Nolan", 2010, 148)

  

    # Hinzufügen von Medien zur Bibliothek

    stadtbibliothek.medium_hinzufügen(buch1)

    stadtbibliothek.medium_hinzufügen(buch2)

    stadtbibliothek.medium_hinzufügen(dvd1)

  

    # Anzeigen aller Medien

    print("Alle Medien in der Bibliothek:")

    for medium in stadtbibliothek.alle_medien_anzeigen():

        print(medium)

  

    # Erstellen eines Benutzers

    benutzer1 = Benutzer("Max Mustermann", "B12345")

  

    # Ausleihen und Zurückgeben von Medien

    print(buch1.ausleihen(benutzer1))

    print(buch1.ausleihen(benutzer1))  # Versuch, ein bereits ausgeliehenes Buch auszuleihen

    print(buch1.zurückgeben())

  

    # Überprüfen der Gleichheit von Medien

    buch3 = Buch("Der Zauberberg", "Thomas Mann", 1924, "978-3596294336")

    print(f"Sind buch1 und buch3 gleich? {buch1 == buch3}")

  

    # Anzeigen der Gesamtanzahl der Medien

    print(f"Gesamtanzahl der Medien: {Bibliothek.get_anzahl_medien()}")

  

    # Entfernen eines Mediums

    stadtbibliothek.medium_entfernen(dvd1)

    print(f"Gesamtanzahl der Medien nach Entfernen: {Bibliothek.get_anzahl_medien()}")

  

    # Demonstration des Polymorphismus

    for medium in stadtbibliothek.medien:

        print(medium.info())

```

  

Diese Lösung deckt alle besprochenen OOP-Konzepte ab:

  

2. Klassen definieren: `Medientyp`, `Buch`, `DVD`, `Bibliothek`, `Benutzer`

3. Objekte erstellen und verwenden: Instanziierung von Büchern, DVDs, Bibliothek und Benutzern

4. Methoden implementieren: `info()`, `ausleihen()`, `zurückgeben()`, etc.

5. Datenkapselung: Verwendung von Properties und Name Mangling

6. Vererbung: `Buch` und `DVD` erben von `Medientyp`

7. Polymorphismus: Verwendung der `info()`-Methode für verschiedene Medientypen

8. Spezielle Methoden: `__str__`, `__eq__`

9. Klassenattribute und -methoden: `anzahl_medien` und `get_anzahl_medien()`

10. Fortgeschrittene Konzepte: Abstrakte Basisklasse `Medientyp`, Mehrfachvererbung mit `Ausleihbar`-Mixin

  

Diese Aufgabe bietet eine praktische Anwendung aller diskutierten OOP-Konzepte in einem realistischen Szenario.

  

---

  

# jetzt noch eine Aufgabe im gleichen Stil die einem Stundenplan für die Fachinformatiker-Ausbildung verwaltet

  

Hier ist eine Aufgabe zur Verwaltung eines Stundenplans für die Fachinformatiker-Ausbildung, die die OOP-Konzepte in Python übt:

  

## Aufgabe: Entwicklung eines Stundenplan-Verwaltungssystems für Fachinformatiker

  

Entwickeln Sie ein Stundenplan-Verwaltungssystem für die Fachinformatiker-Ausbildung unter Verwendung der OOP-Konzepte in Python. Das System soll folgende Anforderungen erfüllen:

  

1. Erstellen Sie eine abstrakte Basisklasse `Unterrichtseinheit`.

2. Implementieren Sie Klassen für `Theoriefach` und `Praxisfach`, die von `Unterrichtseinheit` erben.

3. Erstellen Sie eine Klasse `Stundenplan`, die eine Sammlung von Unterrichtseinheiten verwaltet.

4. Implementieren Sie eine Klasse `Ausbilder` für die Lehrkräfte.

5. Verwenden Sie Datenkapselung, um sensible Daten zu schützen.

6. Implementieren Sie spezielle Methoden wie `__str__` und `__eq__`.

7. Verwenden Sie Klassenattribute und -methoden.

8. Demonstrieren Sie Polymorphismus bei der Verwaltung verschiedener Unterrichtseinheiten.

9. Implementieren Sie eine Mixin-Klasse `OnlineUnterricht` für Fächer, die auch online unterrichtet werden können.

  

### Lösungshinweise:

  

1. Verwenden Sie `abc.ABC` und `@abstractmethod` für die abstrakte Basisklasse `Unterrichtseinheit`.

2. Implementieren Sie gemeinsame Attribute und Methoden in der Basisklasse.

3. Nutzen Sie Properties für kontrollierte Zugriffe auf Attribute.

4. Verwenden Sie Name Mangling für private Attribute.

5. Implementieren Sie `__str__`, `__repr__` und `__eq__` in relevanten Klassen.

6. Nutzen Sie ein Klassenattribut in `Stundenplan` zur Verfolgung der Gesamtanzahl der Unterrichtseinheiten.

7. Implementieren Sie eine Klassenmethode zur Abfrage der Gesamtanzahl der Unterrichtseinheiten.

8. Verwenden Sie Vererbung und überschreiben Sie Methoden, wo es sinnvoll ist.

9. Nutzen Sie Mehrfachvererbung für die `OnlineUnterricht`-Mixin-Klasse.

  

### Lösung:

  

```python

from abc import ABC, abstractmethod

from datetime import datetime, timedelta

  

class Unterrichtseinheit(ABC):

    def __init__(self, name, dauer, ausbilder):

        self.name = name

        self.dauer = dauer

        self.ausbilder = ausbilder

        self.__raum = None

  

    @abstractmethod

    def beschreibung(self):

        pass

  

    @property

    def raum(self):

        return self.__raum

  

    @raum.setter

    def raum(self, wert):

        self.__raum = wert

  

    def __str__(self):

        return f"{self.name} ({self.dauer} Minuten) - Ausbilder: {self.ausbilder.name}"

  

    def __eq__(self, other):

        if isinstance(other, Unterrichtseinheit):

            return (self.name, self.dauer, self.ausbilder) == (other.name, other.dauer, other.ausbilder)

        return False

  

class OnlineUnterricht:

    def online_link(self):

        return f"https://meeting.ausbildung.de/{self.name.lower().replace(' ', '-')}"

  

class Theoriefach(Unterrichtseinheit, OnlineUnterricht):

    def __init__(self, name, dauer, ausbilder, themengebiet):

        super().__init__(name, dauer, ausbilder)

        self.themengebiet = themengebiet

  

    def beschreibung(self):

        return f"Theoriefach: {super().__str__()} - Themengebiet: {self.themengebiet}"

  

class Praxisfach(Unterrichtseinheit):

    def __init__(self, name, dauer, ausbilder, ausstattung):

        super().__init__(name, dauer, ausbilder)

        self.ausstattung = ausstattung

  

    def beschreibung(self):

        return f"Praxisfach: {super().__str__()} - Benötigte Ausstattung: {self.ausstattung}"

  

class Stundenplan:

    anzahl_einheiten = 0

  

    def __init__(self, bezeichnung):

        self.bezeichnung = bezeichnung

        self.einheiten = []

  

    def einheit_hinzufügen(self, einheit, tag, uhrzeit):

        self.einheiten.append((einheit, tag, uhrzeit))

        Stundenplan.anzahl_einheiten += 1

  

    def einheit_entfernen(self, einheit):

        for e in self.einheiten:

            if e[0] == einheit:

                self.einheiten.remove(e)

                Stundenplan.anzahl_einheiten -= 1

                break

  

    def wochenplan_anzeigen(self):

        wochenplan = {}

        for einheit, tag, uhrzeit in self.einheiten:

            if tag not in wochenplan:

                wochenplan[tag] = []

            wochenplan[tag].append(f"{uhrzeit.strftime('%H:%M')} - {einheit.beschreibung()}")

        return wochenplan

  

    @classmethod

    def get_anzahl_einheiten(cls):

        return cls.anzahl_einheiten

  

class Ausbilder:

    def __init__(self, name, fachgebiet):

        self.name = name

        self.__fachgebiet = fachgebiet

  

    @property

    def fachgebiet(self):

        return self.__fachgebiet

  

    def __str__(self):

        return f"Ausbilder: {self.name} (Fachgebiet: {self.__fachgebiet})"

  

# Testen des Systems

if __name__ == "__main__":

    # Erstellen von Ausbildern

    ausbilder1 = Ausbilder("Dr. Müller", "Programmierung")

    ausbilder2 = Ausbilder("Frau Schmidt", "Netzwerktechnik")

  

    # Erstellen von Unterrichtseinheiten

    theorie1 = Theoriefach("Grundlagen der Programmierung", 90, ausbilder1, "Algorithmen")

    theorie2 = Theoriefach("Netzwerkprotokolle", 90, ausbilder2, "TCP/IP")

    praxis1 = Praxisfach("Softwareentwicklungsprojekt", 180, ausbilder1, "Computerraum mit IDE")

  

    # Erstellen eines Stundenplans

    stundenplan = Stundenplan("Fachinformatiker 1. Lehrjahr")

  

    # Hinzufügen von Unterrichtseinheiten zum Stundenplan

    stundenplan.einheit_hinzufügen(theorie1, "Montag", datetime(2024, 1, 1, 9, 0))

    stundenplan.einheit_hinzufügen(theorie2, "Dienstag", datetime(2024, 1, 2, 11, 0))

    stundenplan.einheit_hinzufügen(praxis1, "Mittwoch", datetime(2024, 1, 3, 13, 30))

  

    # Anzeigen des Wochenplans

    print("Wochenplan:")

    for tag, einheiten in stundenplan.wochenplan_anzeigen().items():

        print(f"\n{tag}:")

        for einheit in einheiten:

            print(f"  {einheit}")

  

    # Demonstration des Online-Links für Theoriefächer

    print(f"\nOnline-Link für {theorie1.name}: {theorie1.online_link()}")

  

    # Entfernen einer Unterrichtseinheit

    stundenplan.einheit_entfernen(theorie2)

    print(f"\nAnzahl der Unterrichtseinheiten nach Entfernen: {Stundenplan.get_anzahl_einheiten()}")

  

    # Überprüfen der Gleichheit von Unterrichtseinheiten

    theorie3 = Theoriefach("Grundlagen der Programmierung", 90, ausbilder1, "Algorithmen")

    print(f"\nSind theorie1 und theorie3 gleich? {theorie1 == theorie3}")

  

    # Demonstration des Polymorphismus

    print("\nBeschreibungen aller Unterrichtseinheiten:")

    for einheit, _, _ in stundenplan.einheiten:

        print(einheit.beschreibung())

```

  

Diese Lösung deckt alle besprochenen OOP-Konzepte ab:

  

1. Abstrakte Basisklasse: `Unterrichtseinheit`

2. Vererbung: `Theoriefach` und `Praxisfach` erben von `Unterrichtseinheit`

3. Datenkapselung: Verwendung von Properties und Name Mangling

4. Spezielle Methoden: `__str__`, `__eq__`

5. Klassenattribute und -methoden: `anzahl_einheiten` und `get_anzahl_einheiten()`

6. Polymorphismus: Verwendung der `beschreibung()`-Methode für verschiedene Unterrichtseinheiten

7. Mixin-Klasse: `OnlineUnterricht` für Theoriefächer

  

Diese Aufgabe bietet eine praktische Anwendung aller diskutierten OOP-Konzepte in einem realistischen Szenario der Fachinformatiker-Ausbildung. Sie demonstriert, wie OOP verwendet werden kann, um ein flexibles und erweiterbares System zur Verwaltung von Stundenplänen zu erstellen.

  

---

  

# als Lösungshinweis für die letzten beiden Antworten jeweils  ein UML-Klassendiagramm in PlantUML

  

Gerne erstelle ich für Sie UML-Klassendiagramme in PlantUML für die beiden vorherigen Aufgaben. Hier sind die Lösungshinweise mit den entsprechenden PlantUML-Diagrammen:

  

1. Für das Bibliotheksverwaltungssystem:

```plantuml

@startuml

abstract class Medientyp {

  +titel: string

  +autor_oder_regisseur: string

  +jahr: int

  -ausgeliehen: bool

  +info(): string

  +ausgeliehen: bool

  +__str__(): string

  +__eq__(other: Medientyp): bool

}

  

class Ausleihbar {

  +ausleihen(benutzer: Benutzer): string

  +zurückgeben(): string

}

  

class Buch {

  +isbn: string

  +info(): string

}

  

class DVD {

  +laufzeit: int

  +info(): string

}

  

class Bibliothek {

  {static} anzahl_medien: int

  +name: string

  -medien: List[Medientyp]

  +medium_hinzufügen(medium: Medientyp)

  +medium_entfernen(medium: Medientyp)

  +alle_medien_anzeigen(): List[string]

  {static} +get_anzahl_medien(): int

}

  

class Benutzer {

  +name: string

  -ausweisnummer: string

  +ausweisnummer: string

  +__str__(): string

}

  

Medientyp &lt;|-- Buch

Medientyp &lt;|-- DVD

Ausleihbar &lt;|.. Buch

Ausleihbar &lt;|.. DVD

Bibliothek "1" o-- "*" Medientyp

@enduml

```

  

2. Für das Stundenplan-Verwaltungssystem:

```plantuml

@startuml

abstract class Unterrichtseinheit {

  +name: string

  +dauer: int

  +ausbilder: Ausbilder

  -raum: string

  +beschreibung(): string

  +raum: string

  +__str__(): string

  +__eq__(other: Unterrichtseinheit): bool

}

  

class OnlineUnterricht {

  +online_link(): string

}

  

class Theoriefach {

  +themengebiet: string

  +beschreibung(): string

}

  

class Praxisfach {

  +ausstattung: string

  +beschreibung(): string

}

  

class Stundenplan {

  {static} anzahl_einheiten: int

  +bezeichnung: string

  -einheiten: List[Tuple[Unterrichtseinheit, string, datetime]]

  +einheit_hinzufügen(einheit: Unterrichtseinheit, tag: string, uhrzeit: datetime)

  +einheit_entfernen(einheit: Unterrichtseinheit)

  +wochenplan_anzeigen(): Dict[string, List[string]]

  {static} +get_anzahl_einheiten(): int

}

  

class Ausbilder {

  +name: string

  -fachgebiet: string

  +fachgebiet: string

  +__str__(): string

}

  

Unterrichtseinheit &lt;|-- Theoriefach

Unterrichtseinheit &lt;|-- Praxisfach

OnlineUnterricht &lt;|.. Theoriefach

Stundenplan "1" o-- "*" Unterrichtseinheit

Unterrichtseinheit "*" -- "1" Ausbilder

@enduml

```

  

Diese PlantUML-Diagramme visualisieren die Klassenstrukturen und Beziehungen der beiden Systeme. Sie zeigen die Vererbungshierarchien, Assoziationen und die wichtigsten Attribute und Methoden jeder Klasse. Die Diagramme helfen dabei, die Gesamtstruktur der Systeme auf einen Blick zu erfassen und die Anwendung der OOP-Konzepte zu verdeutlichen.

  

Um diese Diagramme zu generieren, können Sie den PlantUML-Code in einem PlantUML-fähigen Editor oder Online-Tool einfügen und rendern lassen. Dies bietet eine visuelle Ergänzung zu den Code-Beispielen und erleichtert das Verständnis der Systemarchitektur.

  

<div>⁂</div>