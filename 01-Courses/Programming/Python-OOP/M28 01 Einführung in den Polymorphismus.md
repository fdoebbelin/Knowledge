 - widmet sich dem fundamentalen OOP-Prinzip des **Polymorphismus**. 
 - Ziel ist es, zu zeigen, wie Python es ermöglicht, 
	 - dass verschiedene Objekte auf dieselbe Schnittstelle 
	 - unterschiedlich reagieren. 
 - dazu werden sowohl 
	 - die technische Umsetzung (Methodenüberschreibung, polymorphe Funktionen) 
	 - als auch die Anwendung in der Praxis mit anschaulichen Beispielen erläutert. 
 - bietet eine breite Palette an Demonstrationen, die die Bedeutung und Vielseitigkeit von Polymorphismus in modernen Python-Projekten unterstreichen.

***

## Was ist Polymorphismus?

Polymorphismus bezeichnet in der objektorientierten Programmierung die Fähigkeit, dass verschiedene Klassen Methoden mit identischem Namen, aber unterschiedlicher Funktionalität besitzen können. 
Dadurch kann derselbe Funktions- oder Methodenaufruf auf verschiedene Objekttypen passen und angemessen funktionieren.

Beispiel – Zwei Klassen „Hund“ und „Katze“ mit jeweils einer `sprich`-Methode:

```python
class Hund:
    def sprich(self):
        print("Wuff!")

class Katze:
    def sprich(self):
        print("Miau!")
        
def tier_spricht(tier):
    tier.sprich()

hund = Hund()
katze = Katze()

tier_spricht(hund)   # Ausgabe: Wuff!
tier_spricht(katze)  # Ausgabe: Miau!
```

Hier sorgt Polymorphismus dafür, dass `tier_spricht` beliebige „sprechende“ Tiere aufnehmen kann – ohne ihren genauen Typ zu kennen.

***

## Methodenüberschreibung (Overriding)

Eine Unterklasse kann Methoden ihrer Elternklasse überschreiben, um spezielles Verhalten zu definieren. Dies ist der Kern der polymorphen Verwendung in Python.

```python
class Tier:
    def sprich(self):
        print("Ein Tier macht Geräusche.")

class Hund(Tier):
    def sprich(self):
        print("Wuff!")

tier = Tier()
hund = Hund()

tier.sprich()  # Ausgabe: Ein Tier macht Geräusche.
hund.sprich()  # Ausgabe: Wuff!
```

Das Schlüsselwort ist, dass man Objekte der Klasse `Hund` als Typ `Tier` verwenden kann, sich aber das Verhalten im Detail unterscheidet.

***

## Einsatz von Polymorphismus mit Funktionen

Mit Polymorphismus lässt sich Code flexibler und allgemeiner schreiben. Oft begegnen wir solchen Konstruktionen, wenn Funktionen mit verschiedensten Objektarten zurechtkommen sollen.

### Beispiel: Verarbeitungsliste

```python
class Vogel:
    def sprich(self):
        print("Piep!")

tiere = [Hund(), Katze(), Vogel()]

for tier in tiere:
    tier.sprich()
# Ausgabe:
# Wuff!
# Miau!
# Piep!
```

Jedes Objekt in der Liste implementiert dieselbe Methode, aber auf seine eigene Art.

***

## Methodenüberschreibung vs. Überladung

Python erlaubt keine klassische Methodenüberladung (gleicher Methodenname, aber andere Parameter wie etwa in Java oder C++), sehr wohl aber Methodenüberschreibung. 
Polymorphismus bedeutet in Python stets die Interpretation eines Methodenaufrufs passend zum konkreten Objekttyp.

***

## Praxis: Polymorphe Funktionen

Polymorphe Funktionen nehmen Objekte verschiedener Typen an und behandeln sie auf Basis der gemeinsam unterstützten Methoden – unabhängig von deren konkreter Klasse.

```python
def probe_lautstaerke(tier):
    for _ in range(2):
        tier.sprich()
        
probe_lautstaerke(Hund())   # Wuff! Wuff!
probe_lautstaerke(Katze())  # Miau! Miau!
```

So kann der Funktionscode jederzeit erweitert werden, ohne angepasst werden zu müssen – neue Tierarten können einfach hinzugefügt werden, solange sie `sprich` implementieren.

***

## Duck Typing: Die Python-Denkweise

Python verlässt sich auf das Prinzip „Wenn es wie eine Ente läuft und quakt, ist es vermutlich eine Ente“ (Duck Typing). 
Das heißt: Es zählt das Vorhandensein einer Methode, nicht die Vererbung eines bestimmten Typs. Polymorphismus in Python ist somit besonders flexibel.

### Beispiel: „Schnittstellen“ durch Methoden

```python
class Ente:
    def laufe(self):
        print("Watschel, watschel.")

class Roboterente:
    def laufe(self):
        print("*mechanisches Watscheln*")

def lauf_ente(obj):
    obj.laufe()

lauf_ente(Ente())        # Watschel, watschel.
lauf_ente(Roboterente()) # *mechanisches Watscheln*
```

Duck Typing befreit uns von starren Typdefinitionen.

***

## Vorteile des Polymorphismus

- **Erweiterbarkeit:** Neue Klassen und Objekttypen lassen sich einführen, ohne den bestehenden Code anpassen zu müssen.
- **Wartbarkeit:** Weniger Abfragen und „Typprüfungen“ im Code.
- **Wiederverwendbarkeit:** Allgemeine Funktionen und Datenstrukturen funktionieren für viele Objekte.

***

## Zusammenführung mit Vererbung

Polymorphismus funktioniert besonders reibungslos mit Vererbungshierarchien. 
Über Basisklassen (oft als abstrakte Klassen) lassen sich Schnittstellen definieren, die in abgeleiteten Klassen individuell umgesetzt werden.

### Beispiel: Geometrische Formen

```python
class Form:
    def umfang(self):
        raise NotImplementedError

class Quadrat(Form):
    def __init__(self, seitenlaenge):
        self.seitenlaenge = seitenlaenge
    def umfang(self):
        return 4 * self.seitenlaenge

class Kreis(Form):
    def __init__(self, radius):
        self.radius = radius
    def umfang(self):
        import math
        return 2 * math.pi * self.radius

formen = [Quadrat(3), Kreis(2)]
for f in formen:
    print(f"Umfang: {f.umfang()}")
# Umfang: 12
# Umfang: 12.566...
```

Jede Form gestaltet die Methode individuell, der Funktionsaufruf bleibt identisch.

***

## Schritt-für-Schritt-Demonstrationen

### 1. Basisklasse und Ableitung

```python
class Fahrzeug:
    def bewegen(self):
        print("Fahrzeug fährt los.")

class Fahrrad(Fahrzeug):
    def bewegen(self):
        print("Das Fahrrad tritt in die Pedale.")

class Auto(Fahrzeug):
    def bewegen(self):
        print("Das Auto startet den Motor.")

flotte = [Fahrrad(), Auto(), Fahrzeug()]
for v in flotte:
    v.bewegen()
```


### 2. Offene Funktion für beliebige Klassen

```python
def mache_ausflug(obj):
    obj.bewegen()

mache_ausflug(Fahrrad())  # Das Fahrrad tritt in die Pedale.
mache_ausflug(Auto())     # Das Auto startet den Motor.
```


***

## Fazit und Praxistipps

Polymorphismus ist ein zentrales Werkzeug für guten, flexiblen und erweiterbaren Python-Code. 
Er verbindet Vererbung, Methodenüberschreibung und Duck Typing zu einer Grundlage moderner Python-Anwendungen.
