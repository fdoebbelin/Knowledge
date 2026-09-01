Hallo Fritz-Rainer,

gerne erkläre ich Ihnen den Inhalt des Dokuments "00 Kapitel 19.pdf" auf Deutsch. Es handelt sich um eine Einführung in die Objektorientierte Programmierung (OOP) in Python, beginnend mit einem Vergleich von nicht-objektorientierten und objektorientierten Ansätzen am Beispiel einer Bankkontenverwaltung.

---

### Kapitel 19: Objektorientierte Programmierung

Das Kapitel führt in die objektorientierte Programmierung ein. Bisher haben wir in Python mit vordefinierten Objekten wie Strings, Listen oder Dictionaries gearbeitet. Dieses Kapitel zeigt, wie man eigene, an spezifische Anforderungen angepasste Objekte definieren kann.

**Objektorientierung** ist ein Programmierparadigma, das darauf abzielt, die Konsistenz von Datenobjekten zu sichern und die Wiederverwendbarkeit von Quellcode zu verbessern. Dies wird erreicht, indem Datenstrukturen und die dazugehörigen Operationen (Funktionen) zu einer Einheit, einem **Objekt**, zusammengefasst werden. Der Zugriff auf diese internen Strukturen erfolgt dabei nur über bestimmte Schnittstellen.

Das Konzept wird anhand eines Beispiels verdeutlicht: Zuerst wird eine Lösung auf dem bisher bekannten, nicht-objektorientierten Weg erstellt, und danach eine objektorientierte Implementierung vorgestellt.

---

### 19.1 Beispiel: Ein nicht objektorientiertes Konto

Stellen Sie sich vor, wir entwickeln ein System für eine Bank zur Kontoverwaltung. Ein naiver Ansatz wäre, jedes Bankkonto als ein Python-Dictionary zu repräsentieren, das alle Informationen zum Kunden und dessen Finanzstatus enthält. Operationen wie das Anlegen neuer Konten, Überweisungen, Ein- und Auszahlungen würden durch separate Funktionen realisiert, die dieses Dictionary als Parameter manipulieren.

Ein vereinfachtes Konto-Dictionary könnte so aussehen:
```python
konto = {
    "inhaber": "Hans Meier",
    "kontonummer": 567123,
    "kontostand": 12350.0,
    "max_tagesumsatz": 1500,
    "umsatz_heute": 10.0
}
```
Hierbei speichert `inhaber` den Namen, `kontonummer` die eindeutige Kontonummer, `kontostand` das aktuelle Guthaben und `max_tagesumsatz` sowie `umsatz_heute` dienen zur Begrenzung des täglichen Umsatzes zum Schutz des Kunden.

#### 19.1.1 Ein neues Konto anlegen
Eine Funktion zum Anlegen eines neuen Kontos würde die notwendigen Daten als Parameter entgegennehmen und ein entsprechendes Dictionary zurückgeben.
```python
def neues_konto(inhaber, kontonummer, kontostand, max_tagesumsatz=1500):
    return {
        "inhaber": inhaber,
        "kontonummer": kontonummer,
        "kontostand": kontostand,
        "max_tagesumsatz": max_tagesumsatz,
        "umsatz_heute": 0
    }
```

#### 19.1.2 Geld überweisen
Für eine Überweisung bräuchten wir eine Funktion, die Quell- und Zielkonto (als Dictionaries) sowie den Betrag als Parameter erhält. Die Funktion prüft Limits und führt die Transaktion durch, wobei sie `True` oder `False` zurückgibt, je nachdem, ob die Überweisung erfolgreich war.
```python
def geldtransfer(quelle, ziel, betrag):
    if (betrag < 0 or
        quelle["umsatz_heute"] + betrag > quelle["max_tagesumsatz"] or
        ziel["umsatz_heute"] + betrag > ziel["max_tagesumsatz"]):
        return False # Transfer unmöglich
    else:
        quelle["kontostand"] -= betrag
        quelle["umsatz_heute"] += betrag
        ziel["kontostand"] += betrag
        ziel["umsatz_heute"] += betrag
        return True # Transfer erfolgreich
```

#### 19.1.3 Geld ein- und auszahlen
Ähnliche Funktionen würden für Ein- und Auszahlungen existieren, die das betreffende Konto-Dictionary und den Betrag erhalten und ebenfalls Limits prüfen.
```python
def einzahlen(konto, betrag):
    # ... Logik wie oben, Aktualisierung von kontostand und umsatz_heute
    pass

def auszahlen(konto, betrag):
    # ... Logik wie oben, Aktualisierung von kontostand und umsatz_heute
    pass
```

#### 19.1.4 Den Kontostand anzeigen
Eine Ausgabefunktion würde die Details eines Kontos formatieren und anzeigen.
```python
def zeige_konto(konto):
    print("Konto von {}".format(konto["inhaber"]))
    print("Aktueller Kontostand: {:.2f} Euro".format(konto["kontostand"]))
    print("(Heute schon {:.2f} von {} Euro umgesetzt)".format(
        konto["umsatz_heute"], konto["max_tagesumsatz"]))
```
Der Text führt dann ein Simulationsbeispiel mit diesen Funktionen aus, um deren Funktionsweise zu demonstrieren.

**Problem des nicht objektorientierten Ansatzes:**
Die "unschöne Eigenheit" dieses Ansatzes ist, dass die Datenstruktur (das Dictionary) und die Funktionen für ihre Verarbeitung getrennt definiert sind. Das Konto-Dictionary muss bei jedem Funktionsaufruf als Parameter übergeben werden. Die Objektorientierung löst dies, indem sie Datenstrukturen (genannt **Attribute**) und die dazugehörigen Verarbeitungsfunktionen (genannt **Methoden**) zu einer einzigen Einheit, einem **Objekt**, zusammenfasst. Attribute und Methoden werden zusammen als **Member** einer Klasse bezeichnet [1, S. 369].

---

### 19.2 Klassen

**Objekte werden über Klassen erzeugt.** Eine **Klasse** ist eine formale Beschreibung oder ein **Bauplan** der Struktur eines Objekts. Sie definiert, welche Attribute (Daten) und Methoden (Operationen) ein Objekt besitzen wird. Allein eine Klasse ist noch kein Objekt; man kann es mit einem Backrezept vergleichen, das die Zutaten und den Herstellungsprozess eines Kuchens beschreibt. Der Kuchen selbst, der nach dem Rezept gebacken wird, ist das **Objekt** oder die **Instanz** der Klasse [1, S. 370-371]. Der Vorgang des Erzeugens eines Objekts aus einer Klasse wird als **Instanziieren** bezeichnet.

In Python wird eine Klasse mit dem Schlüsselwort `class` definiert:
```python
class Konto:
    pass
```
Um eine Instanz (ein Objekt) einer Klasse zu erzeugen, rufen Sie die Klasse wie eine Funktion auf:
```python
k = Konto() # k ist nun eine Instanz der Klasse Konto
```

#### 19.2.1 Definieren von Methoden
Methoden unterscheiden sich von normalen Funktionen hauptsächlich in zwei Punkten:
1.  Sie werden innerhalb eines `class`-Blocks definiert.
2.  Sie erhalten als ersten Parameter immer eine Referenz auf die Instanz, über die sie aufgerufen werden. Dieser Parameter wird üblicherweise `self` genannt (Deutsch: "selbst"). Er muss nur bei der Definition explizit genannt werden, wird aber beim Aufruf der Methode automatisch übergeben [1, S. 372].

Die Methoden aus dem nicht-objektorientierten Beispiel können nun so in der Klasse `Konto` definiert werden:
```python
class Konto:
    def geldtransfer(self, ziel, betrag):
        pass # Implementierung folgt später
    
    def einzahlen(self, betrag):
        pass

    def auszahlen(self, betrag):
        pass

    def zeige(self):
        pass
```
Ein Aufruf würde dann so aussehen: `k.einzahlen(500)`. Die Referenz auf das Objekt `k` wird dabei automatisch an den `self`-Parameter der Methode `einzahlen` übergeben.

#### 19.2.2 Der Konstruktor
Der **Konstruktor** ist eine spezielle Methode, die automatisch beim Instanziieren eines Objekts aufgerufen wird, um das Objekt in einen gültigen Initialzustand zu versetzen. In Python wird der Konstruktor durch die Methode `__init__` (umgeben von zwei Unterstrichen) definiert. Er kann keine Rückgabewerte haben [1, S. 372-373].
```python
class Beispielklasse:
    def __init__(self):
        print("Hier spricht der Konstruktor")

# Beim Erzeugen einer Instanz wird der Konstruktor aufgerufen:
instanz = Beispielklasse() # Ausgabe: "Hier spricht der Konstruktor"
```
**Hinweis zu Destruktoren:** Python hat keinen Destruktor, der garantiert am Ende der Lebenszeit einer Instanz aufgerufen wird. Ein ähnliches Verhalten kann mit `__del__` oder Kontext-Managern (Kapitel 22) erreicht werden, aber `__del__` ist nicht zuverlässig für Aufräumarbeiten, da Python die Speicherverwaltung selbst übernimmt [1, S. 373].

#### 19.2.3 Attribute
Da die Hauptaufgabe des Konstruktors die Herstellung eines konsistenten Initialzustands ist, sollten alle Attribute einer Klasse dort definiert werden. Die Definition erfolgt durch eine Wertezuweisung auf den `self`-Parameter [1, S. 373-374].
```python
class Konto:
    def __init__(self, inhaber, kontonummer, kontostand, max_tagesumsatz=1500):
        self.inhaber = inhaber
        self.kontonummer = kontonummer
        self.kontostand = kontostand
        self.max_tagesumsatz = max_tagesumsatz
        self.umsatz_heute = 0
    # ... restliche Methoden
```

#### 19.2.4 Beispiel: Ein objektorientiertes Konto
Die vollständige `Konto`-Klasse, die die Kontodaten und die dazugehörigen Verarbeitungsfunktionen zu einer Einheit verbindet, sieht dann so aus:
```python
class Konto:
    def __init__(self, inhaber, kontonummer, kontostand, max_tagesumsatz=1500):
        self.inhaber = inhaber
        self.kontonummer = kontonummer
        self.kontostand = kontostand
        self.max_tagesumsatz = max_tagesumsatz
        self.umsatz_heute = 0.0

    def geldtransfer(self, ziel, betrag):
        # Hier wird self für das Quellkonto und ziel für das Zielkonto verwendet
        if (betrag < 0 or
            self.umsatz_heute + betrag > self.max_tagesumsatz or
            ziel.umsatz_heute + betrag > ziel.max_tagesumsatz):
            return False
        else:
            self.kontostand -= betrag
            self.umsatz_heute += betrag
            ziel.kontostand += betrag
            ziel.umsatz_heute += betrag
            return True

    def einzahlen(self, betrag):
        if betrag < 0 or self.umsatz_heute + betrag > self.max_tagesumsatz:
            return False
        else:
            self.kontostand += betrag
            self.umsatz_heute += betrag
            return True

    def auszahlen(self, betrag):
        if betrag < 0 or self.umsatz_heute + betrag > self.max_tagesumsatz:
            return False
        else:
            self.kontostand -= betrag
            self.umsatz_heute += betrag
            return True

    def zeige(self):
        print("Konto von {}".format(self.inhaber))
        print("Aktueller Kontostand: {:.2f} Euro".format(self.kontostand))
        print("(Heute schon {:.2f} von {} Euro umgesetzt)".format(
            self.umsatz_heute, self.max_tagesumsatz))
```
Mit dieser neuen Klasse kann die Bankoperationen-Simulation viel intuitiver und "objektbezogener" ausgedrückt werden:
```python
k1 = Konto("Heinz Meier", 567123, 12350.0)
k2 = Konto("Erwin Schmidt", 396754, 15000.0)
k1.geldtransfer(k2, 160) # k1 ist jetzt self, k2 ist ziel
k1.zeige()
k2.zeige()
```
Das Hauptziel dieses Abschnitts, die Daten und ihre Verarbeitungsfunktionen zu einer Einheit zu verbinden, ist damit erreicht [1, S. 374-375].

---

### 19.3 Vererbung

**Vererbung** ist ein Kernkonzept der Objektorientierung, das die Wiederverwendbarkeit von Programmcode verbessert. Es ermöglicht, von bereits bestehenden Klassen (Basisklassen oder Superklassen) neue Klassen (Tochterklassen oder Subklassen) abzuleiten. Die abgeleitete Klasse erbt dabei alle Fähigkeiten (Attribute und Methoden) ihrer Basisklasse und kann dann um zusätzliche Funktionalität erweitert oder angepasst werden [1, S. 376].

#### 19.3.1 Ein einfaches Beispiel
Um eine Klasse von einer anderen erben zu lassen, wird der Name der Basisklasse in Klammern hinter dem Namen der Tochterklasse angegeben:
```python
class A:
    def __init__(self):
        print("Konstruktor von A")
        self.x = 1337
    def m(self):
        print("Methode m von A. Es ist self.x =", self.x)

class B(A): # Klasse B erbt von Klasse A
    def n(self):
        print("Methode n von B")

b = B() # Aufruf von B() ruft automatisch den Konstruktor von A auf
b.n()   # Methode n von B
b.m()   # Methode m von A (geerbt)
```
Die Ausgabe zeigt, dass der Konstruktor von `A` und die Methode `m` von `A` geerbt und korrekt aufgerufen wurden, inklusive des Attributs `x` [1, S. 376-377].

#### 19.3.2 Überschreiben von Methoden
Eine Tochterklasse kann geerbte Methoden neu implementieren, um ihr Verhalten anzupassen. Dies wird als **Überschreiben (Overriding)** einer Methode bezeichnet. Wenn eine Methode überschrieben wird, wird nur die Version in der Tochterklasse aufgerufen, nicht die der Basisklasse. Dies gilt auch für den Konstruktor `__init__`.
```python
class B(A):
    def __init__(self): # Überschreibt den Konstruktor von A
        print("Konstruktor von B")
        self.y = 10000
    def n(self):
        print("Methode n von B. Es ist self.y =", self.y)

b = B()
b.n()
b.m() # Dies führt zu einem AttributeError, da Attribut x nicht angelegt wurde
```
Der Fehler tritt auf, weil der Konstruktor von `A`, der `self.x` anlegen würde, nicht aufgerufen wurde. Um den Konstruktor der Basisklasse explizit aufzurufen, verwendet man `super()`:
```python
class B(A):
    def __init__(self):
        print("Konstruktor von B")
        super().__init__() # Ruft den Konstruktor der Basisklasse A auf
        self.y = 10000
    # ...

b = B()
b.n()
b.m() # Funktioniert nun, da super().__init__() self.x anlegt
```
`super().__init__()` findet automatisch die richtige Basisklasse (`A`) und ruft deren `__init__`-Methode auf. Dieses Prinzip kann für jede überschriebene Methode angewendet werden, um die Funktionalität der Basisklasse zu nutzen und zu erweitern [1, S. 377-379].

#### 19.3.3 Beispiel: Girokonto mit Tagesumsatz
Das Dokument strukturiert das `Konto`-Beispiel neu, um es universeller und erweiterbarer zu machen. Die ursprüngliche `Konto`-Klasse wird in mehrere Klassen zerlegt, die voneinander erben. Die Attribute der alten `Konto`-Klasse werden in zwei Kategorien aufgeteilt:
1.  Daten, die den Umgang mit Geld betreffen (`kontostand`, `max_tagesumsatz`, `umsatz_heute`).
2.  Daten, die den Kunden betreffen (`inhaber`, `kontonummer`).

**Die Klasse `VerwalteterGeldbetrag`**
Dies ist die abstrakteste Basisklasse, die einen Geldbetrag nach bestimmten Regeln verwaltet. Sie ist universell einsetzbar (z.B. für Geldbörsen, Tresore). Sie enthält Attribute für den `betrag` und Methoden wie `einzahlen`, `auszahlen`, `einzahlen_moeglich`, `auszahlen_moeglich` und `zeige`. Der "Clou" ist, dass `einzahlen_moeglich` und `auszahlen_moeglich` in dieser Basisklasse standardmäßig `True` zurückgeben, aber dazu gedacht sind, von abgeleiteten Klassen überschrieben zu werden, um spezifische Bedingungen (z.B. Tageslimits) zu implementieren [1, S. 380-381].
```python
class VerwalteterGeldbetrag:
    def __init__(self, anfangsbetrag):
        self.betrag = anfangsbetrag
    def einzahlen_moeglich(self, betrag):
        return True
    def auszahlen_moeglich(self, betrag):
        return True
    # ... einzahlen, auszahlen, zeige Methoden
```

**Die Klasse `AllgemeinesKonto`**
Diese Klasse erbt von `VerwalteterGeldbetrag` und fügt die Möglichkeit hinzu, Geld zwischen Instanzen zu transferieren. Sie speichert außerdem `kundendaten` und überschreibt die `zeige`-Methode, um zuerst die Kundendaten und dann den Geldbetrag anzuzeigen. Die `geldtransfer`-Methode nutzt die `_moeglich`-Methoden der Basisklasse, um die Durchführbarkeit zu prüfen [1, S. 382].
```python
class AllgemeinesKonto(VerwalteterGeldbetrag):
    def __init__(self, kundendaten, kontostand):
        super().__init__(kontostand)
        self.kundendaten = kundendaten
    def geldtransfer(self, ziel, betrag):
        if self.auszahlen_moeglich(betrag) and ziel.einzahlen_moeglich(betrag):
            self.auszahlen(betrag)
            ziel.einzahlen(betrag)
            return True
        else:
            return False
    # ... zeige Methode
```

**Die Klasse `AllgemeinesKontoMitTagesumsatz`**
Diese Klasse erbt von `AllgemeinesKonto` und erweitert die Funktionalität um die Begrenzung des Tagesumsatzes. Sie führt die Attribute `max_tagesumsatz` und `umsatz_heute` ein. Sie überschreibt `einzahlen_moeglich` und `auszahlen_moeglich`, um das Tageslimit zu berücksichtigen, und passt `einzahlen` und `auszahlen` an, um `umsatz_heute` zu aktualisieren. Eine neue Methode `transfer_moeglich` wird eingeführt, die von den `_moeglich`-Methoden verwendet wird [1, S. 382-383].
```python
class AllgemeinesKontoMitTagesumsatz(AllgemeinesKonto):
    def __init__(self, kundendaten, kontostand, max_tagesumsatz=1500):
        super().__init__(kundendaten, kontostand)
        self.max_tagesumsatz = max_tagesumsatz
        self.umsatz_heute = 0.0
    def transfer_moeglich(self, betrag):
        return (self.umsatz_heute + betrag <= self.max_tagesumsatz)
    def auszahlen_moeglich(self, betrag):
        return self.transfer_moeglich(betrag)
    # ... weitere überschriebene Methoden
```

**Die Klasse `GirokontoKundendaten`**
Dies ist eine separate Klasse zur Verwaltung spezifischer Kundendaten für ein Girokonto (`inhaber`, `kontonummer`) mit einer eigenen `zeige`-Methode [1, S. 384].
```python
class GirokontoKundendaten:
    def __init__(self, inhaber, kontonummer):
        self.inhaber = inhaber
        self.kontonummer = kontonummer
    def zeige(self):
        print("Inhaber:", self.inhaber)
        print("Kontonummer:", self.kontonummer)
```

**Die Klasse `GirokontoMitTagesumsatz`**
Diese endgültige Klasse erbt von `AllgemeinesKontoMitTagesumsatz`. Ihr Konstruktor erstellt eine Instanz von `GirokontoKundendaten` und übergibt diese an den Basisklassen-Konstruktor. Diese Klasse bildet den gesamten Funktionsumfang der ursprünglichen `Konto`-Klasse ab [1, S. 384].
```python
class GirokontoMitTagesumsatz(AllgemeinesKontoMitTagesumsatz):
    def __init__(self, inhaber, kontonummer, kontostand, max_tagesumsatz=1500):
        kundendaten = GirokontoKundendaten(inhaber, kontonummer)
        super().__init__(kundendaten, kontostand, max_tagesumsatz)
```
Ein erneutes Durchspielen des Beispiels von Herrn Meier und Herrn Schmidt zeigt, dass das System nun mit dieser fein granular strukturierten Klassenhierarchie funktioniert.

**Mögliche Erweiterungen der Klasse Konto**
Das Dokument zeigt, dass diese modulare Strukturierung durch Vererbung es ermöglicht, leicht neue Klassen einzuführen, die auf vorhandene Funktionalität zurückgreifen. Beispiele sind:
*   `VerwalteterBargeldbetrag`: Erbt von `VerwalteterGeldbetrag` und verhindert negative Beträge.
*   `Geldboerse` und `Tresor`: Erben von `VerwalteterBargeldbetrag`.
*   `Girokonto`: Ein Girokonto ohne Tageslimit, erbt direkt von `AllgemeinesKonto`.
*   `NummernkontoKundendaten`: Eine Klasse für Kundendaten, die nur eine Identifikationsnummer speichert.
*   `Nummernkonto` und `NummernkontoMitTagesumsatz`: Erben von `AllgemeinesKonto` bzw. `AllgemeinesKontoMitTagesumsatz` und verwenden `NummernkontoKundendaten`.

Dies demonstriert, wie die Vererbung dazu beiträgt, Code-Dopplungen zu vermeiden und die Wartung sowie Weiterentwicklung großer Projekte zu erleichtern [1, S. 385-388].

#### 19.3.4 Ausblick
Der große Vorteil der Vererbung liegt darin, dass man aus vorhandenen Klassen neue Klassen ableiten kann, um diese an neue Problemstellungen anzupassen. Dabei muss nur die Funktionalität implementiert oder überschrieben werden, die sich von der Basisklasse unterscheidet. Dies reduziert Code-Dopplungen erheblich, was Programme wartbarer und leichter erweiterbar macht [1, S. 388-389].

---

### 19.4 Mehrfachvererbung

**Mehrfachvererbung** erlaubt einer Klasse, die Fähigkeiten von zwei oder mehr Basisklassen zu erben. Man schreibt die Basisklassen durch Kommata getrennt in die Klammern hinter dem Klassennamen [1, S. 389].
```python
class NeueKlasse(Basisklasse1, Basisklasse2, Basisklasse3):
    pass
```
Ein Beispiel ist ein `Amphibienfahrzeug`, das von `Gelaendefahrzeug` und `Wasserfahrzeug` erben könnte.

#### 19.4.1 Mögliche Probleme der Mehrfachvererbung
Mehrfachvererbung ist komplex und wird von wenigen Sprachen unterstützt, da sie Probleme wie Namenskonflikte verursachen kann. Wenn mehrere Basisklassen eine Methode mit demselben Namen implementieren, erbt die Tochterklasse die Methode von der Basisklasse, die am weitesten links in der Liste der Basisklassen steht. Dies kann zu unerwartetem Verhalten führen. In der Praxis wird Mehrfachvererbung oft umgangen [1, S. 390].

---

### 19.5 Property-Attribute

Manchmal möchte man den Zugriff auf Attribute einer Klasse nach bestimmten Regeln beeinflussen, z.B. um sicherzustellen, dass ein Wert immer positiv ist.

#### 19.5.1 Setter und Getter
Ein klassisches Konzept sind **Setter-** und **Getter-Methoden**. Anstatt direkt auf ein Attribut zuzugreifen, wird der Zugriff über diese speziellen Methoden geregelt. Intern wird das Attribut oft mit einem führenden Unterstrich (`_x`) benannt, um zu signalisieren, dass es ein Implementierungsdetail ist und nicht direkt von außen verwendet werden sollte [1, S. 390-391].
```python
class A:
    def __init__(self):
        self._x = 100
    def get_x(self): # Getter-Methode
        return self._x
    def set_x(self, wert): # Setter-Methode
        if wert < 0:
            return # Negative Werte werden ignoriert
        self._x = wert

a = A()
a.set_x(300)
print(a.get_x()) # Ausgabe: 300
a.set_x(-20)
print(a.get_x()) # Ausgabe: 300 (Änderung wurde verhindert)
```

#### 19.5.2 Property-Attribute definieren
**Property-Attribute** lösen das Problem der expliziten Setter-/Getter-Aufrufe, indem sie beim Schreiben oder Lesen eines Attributs implizit aufgerufen werden. Man definiert ein Property-Attribut mithilfe der Built-in Function `property()` [1, S. 392].
```python
class A:
    def __init__(self):
        self.x = 100 # Ruft hier implizit den Setter auf!
    def get_x(self):
        print("Getter aufgerufen")
        return self._x
    def set_x(self, wert):
        print("Setter aufgerufen")
        if wert < 0:
            return
        self._x = wert
    x = property(get_x, set_x) # Definiert 'x' als Property-Attribut

a = A()
a.x = 300 # Ruft set_x auf
print(a.x) # Ruft get_x auf
a.x = -20 # Ruft set_x auf, ignoriert den Wert
print(a.x) # Ruft get_x auf
```
Die Ausgabe zeigt, dass Setter und Getter tatsächlich implizit beim Zugriff auf `a.x` aufgerufen werden. Property-Attribute bieten eine elegantere Syntax, können aber bei sehr vielen Zugriffen die Performance leicht beeinträchtigen [1, S. 392-393].

---

### 19.6 Statische Methoden

Bisher definierte Methoden beziehen sich auf konkrete Instanzen (`self`). **Statische Methoden** hingegen beziehen sich nicht auf eine Instanz, sondern werden von allen Instanzen einer Klasse geteilt (oder direkt von der Klasse aufgerufen). Sie benötigen daher keinen `self`-Parameter [1, S. 393].

#### 19.6.1 Statische Methoden definieren
Man definiert eine statische Methode mit der Built-in Function `staticmethod`.
```python
class A:
    def m(): # Keine self-Parameter
        print("Hallo statische Methode!")
    m = staticmethod(m) # Bindet 'm' als statische Methode an die Klasse

A.m() # Aufruf direkt über die Klasse
```
Statische Methoden werden oft als **Factory-Functions** verwendet, um alternative Konstruktoren anzubieten, z.B. eine Methode, die ein `Juniorkonto` mit voreingestellten Limits erstellt [1, S. 393-394].
```python
class Konto:
    # ... (Attribute und andere Methoden)
    def juniorkonto(inhaber, kontonummer, kontostand):
        return Konto(inhaber, kontonummer, kontostand, 20) # Ruft den normalen Konstruktor auf
    juniorkonto = staticmethod(juniorkonto)

jr = Konto.juniorkonto("Emil Peters", 436574, 67)
jr.zeige() # Zeigt ein Konto mit max_tagesumsatz 20 Euro
```

---

### 19.7 Klassenmethoden

**Klassenmethoden** sind eine weitere Art von Methoden, die sich nicht auf eine Instanz, sondern auf die Klasse selbst beziehen. Sie erwarten als ersten Parameter eine Referenz auf die Klasse (`cls`), für die sie aufgerufen werden. Sie werden mit der Built-in Function `classmethod` definiert [1, S. 394-395].
```python
class A:
    def m(cls):
        print("Ich bin", cls)
    m = classmethod(m)

class B(A):
    pass
class C(A):
    pass

A.m() # cls ist <class '__main__.A'>
b = B()
b.m() # cls ist <class '__main__.B'>
c = C()
c.m() # cls ist <class '__main__.C'>
```
Der `cls`-Parameter erlaubt es der Klassenmethode, auf die spezifische Klasse zuzugreifen, von der sie aufgerufen wurde, selbst wenn dies über eine Instanz einer Unterklasse geschieht [1, S. 395].
**Hinweis:** `staticmethod` und `classmethod` werden häufig als Function Decorators (`@staticmethod`, `@classmethod`) verwendet [1, S. 395].

---

### 19.8 Klassenattribute

Neben Klassenmethoden gibt es auch **Klassenattribute**. Dies sind Attribute, die nicht instanzspezifisch sind, sondern von allen Instanzen einer Klasse geteilt werden. Sie werden direkt im Klassenkörper definiert und können sowohl über die Klasse als auch über ihre Instanzen zugegriffen werden [1, S. 396].
```python
class D:
    x = 10 # Klassenattribut
    
print(D.x) # Zugriff über die Klasse: 10
d = D()
print(d.x) # Zugriff über die Instanz: 10
```

---

### 19.9 Built-in Functions für die objektorientierte Programmierung

Python bietet eine Reihe von Built-in Functions zur Verwaltung von Attributen und zur Abfrage der Klassenhierarchie [1, S. 396].

#### 19.9.1 Funktionen für die Verwaltung der Attribute einer Instanz
*   `getattr(object, name, [default])`: Liefert den Wert des Attributs `name` von `object`. `name` ist ein String. Wenn das Attribut nicht existiert, wird `default` zurückgegeben (falls angegeben), sonst wird ein `AttributeError` ausgelöst.
*   `setattr(object, name, value)`: Setzt den Wert des Attributs `name` von `object` auf `value`. Dies ist äquivalent zu `object.name = value`.
*   `hasattr(object, name)`: Prüft, ob `object` das Attribut `name` besitzt. Gibt `True` oder `False` zurück.
*   `delattr(object, name)`: Entfernt das Attribut `name` von `object`. Äquivalent zu `del object.name`.
[1, S. 397-398]

#### 19.9.2 Funktionen für Informationen über die Klassenhierarchie
Angenommen, wir haben folgende Klassenhierarchie:
```python
class A: pass
class B(A): pass
class C(B): pass
class D: pass
a, b, c, d = A(), B(), C(), D()
```
*   `isinstance(object, classinfo)`: Prüft, ob `object` eine Instanz der Klasse(n) `classinfo` ist. `classinfo` kann eine einzelne Klasse oder ein Tupel von Klassen sein. Die Funktion gibt auch `True` zurück, wenn `object` eine Instanz einer Unterklasse von `classinfo` ist.
    *   `isinstance(c, A)` ist `True` (C ist eine Instanz von A, da C von B und B von A erbt).
*   `issubclass(class_, classinfo)`: Prüft, ob `class_` eine Tochterklasse der Klasse(n) `classinfo` ist.
    *   `issubclass(B, A)` ist `True`.
    *   `issubclass(C, (B, D))` ist `True`.
[1, S. 398-399]

---

### 19.10 Erben von eingebauten Datentypen

Python ist grundlegend objektorientiert, und es ist möglich, von eingebauten Datentypen wie `list` oder `dict` zu erben [1, S. 400].
Das Dokument zeigt ein Beispiel einer Klasse `SortierteListe`, die von `list` erbt. Diese Liste sortiert ihre Elemente automatisch nach jeder Veränderung. Methoden wie `__setitem__` (für `[]`-Zugriffe), `append`, `extend`, `insert`, `__iadd__` (für `+=`) und `__imul__` (für `*=`) werden überschrieben, um nach der Operation `self.sort()` aufzurufen. Die Methode `reverse()` wird überschrieben, um nichts zu tun, da die Liste immer sortiert sein soll [1, S. 400-401].
```python
class SortierteListe(list):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.sort() # Beim Initialisieren sortieren
    
    def append(self, value):
        super().append(value)
        self.sort() # Nach dem Anhängen sortieren
    
    def reverse(self):
        pass # Funktionalität entfernen

# Beispiel:
l = SortierteListe([6,4,3]) # [3, 4, 6]
l.append(2)                # [2, 3, 4, 6]
```
Dies demonstriert die Anpassungsfähigkeit eingebauter Typen durch Vererbung.

---

### 19.11 Magic Methods und Magic Attributes

**Magic Methods** (oder Dunder Methods, für "double underscore") und **Magic Attributes** sind spezielle Methoden und Attribute in Python, deren Namen mit zwei Unterstrichen beginnen und enden (z.B. `__init__`). Sie werden in der Regel nicht direkt aufgerufen, sondern implizit im Hintergrund von Python verwendet, um das Verhalten von Klassen anzupassen (z.B. wie sie sich mit Operatoren verhalten oder wie sie in Strings umgewandelt werden) [1, S. 401-402].

#### 19.11.1 Allgemeine Magic Methods
*   `__init__(self, ...)`: Der Konstruktor (bereits besprochen).
*   `__del__(self)`: Der Finalizer. Wird aufgerufen, wenn keine Referenzen mehr auf die Instanz existieren und Python sie aus dem Speicher entfernt. Es ist jedoch nicht garantiert, dass dies zeitnah geschieht, insbesondere bei zyklischen Referenzen. Daher sind Kontext-Manager (`with`-Anweisung) für Aufräumarbeiten vorzuziehen [1, S. 402-404].
*   `__repr__(self)`: Legt fest, was `repr(obj)` zurückgibt (eine Entwickler-freundliche, oft reproduzierbare String-Darstellung).
*   `__str__(self)`: Legt fest, was `str(obj)` oder `print(obj)` zurückgibt (eine Benutzer-freundliche String-Darstellung).
*   `__bool__(self)`: Definiert, wie ein Objekt in einen Booleschen Wert umgewandelt wird (z.B. in einem `if`-Statement).
*   `__call__(self, ...)`: Macht Instanzen einer Klasse wie Funktionen aufrufbar.
    ```python
    class Potenz:
        def __init__(self, exponent):
            self.exponent = exponent
        def __call__(self, basis):
            return basis ** self.exponent
    
    hoch3 = Potenz(3)
    print(hoch3(2)) # Ausgabe: 8 (Instanz wird wie eine Funktion aufgerufen)
    ```
*   `__hash__(self)`: Definiert den Hash-Wert einer Instanz, wichtig für die Verwendung in Dictionaries oder Mengen. Hashbare Objekte müssen unveränderlich sein und `__eq__` implementieren [1, S. 402-405].

**Zugriff auf Attribute anpassen**
Diese Magic Methods ermöglichen eine feinkontrollierte Steuerung des Attributzugriffs [1, S. 406]:
*   `__dict__`: Jede Instanz besitzt dieses Attribut, das ihre Member in einem Dictionary speichert.
*   `__getattr__(self, name)`: Wird aufgerufen, wenn ein *nicht existierendes* Attribut gelesen wird.
*   `__getattribute__(self, name)`: Wird *immer* aufgerufen, wenn ein Attribut gelesen wird (existierend oder nicht). **Achtung vor endloser Rekursion!** Innerhalb von `__getattribute__` muss `object.__getattribute__(self, name)` verwendet werden, nicht `self.name`.
*   `__setattr__(self, name, value)`: Wird *immer* aufgerufen, wenn ein Attribut gesetzt oder neu erstellt wird. **Achtung vor endloser Rekursion!** Innerhalb von `__setattr__` muss `object.__setattr__(self, name, value)` verwendet werden.
*   `__delattr__(self, name)`: Wird aufgerufen, wenn ein Attribut mit `del` gelöscht wird.
*   `__slots__`: Ein Klassenattribut (Tupel von Attributnamen), das Python anweist, die Attribute einer Klasse speicherschonend zu verwalten. Dies spart Speicher, insbesondere bei vielen Instanzen mit wenigen Attributen, schränkt aber die dynamische Erstellung neuer Attribute ein und deaktiviert `__dict__` für Instanzen [1, S. 406-409].

#### 19.11.2 Operatoren überladen
Sie können das Verhalten von Operatoren für Ihre eigenen Klassen anpassen, indem Sie die entsprechenden Magic Methods überschreiben [1, S. 409].
Als Beispiel wird die Klasse `Laenge` implementiert, die Längenangaben mit Einheiten verwaltet und Addition (`__add__`) und Subtraktion (`__sub__`) unterstützt.
```python
class Laenge:
    umrechnung = {"m": 1, "cm": 0.01, "km": 1000, ...}
    def __init__(self, zahlenwert, einheit):
        self.zahlenwert = zahlenwert
        self.einheit = einheit
    def __str__(self):
        return "{:f} {}".format(self.zahlenwert, self.einheit)
    def __add__(self, other):
        # Umrechnung beider Operanden in Meter, Addition, Rückumrechnung in self.einheit
        # Rückgabe einer neuen Laenge-Instanz
        z = self.zahlenwert * Laenge.umrechnung[self.einheit]
        z += other.zahlenwert * Laenge.umrechnung[other.einheit]
        z /= Laenge.umrechnung[self.einheit]
        return Laenge(z, self.einheit)
    # ... __sub__ und andere Methoden

a1 = Laenge(5, "cm")
a2 = Laenge(3, "dm")
print(a1 + a2) # Ausgabe: 35.000000 cm (Ergebnis in Einheit des linken Operanden)
print(a2 + a1) # Ausgabe: 3.500000 dm (Ergebnis in Einheit des linken Operanden)
```
**Hinweis:** Wenn eine Operation nicht durchführbar ist (z.B. falscher Datentyp), sollte `NotImplemented` zurückgegeben werden. Python versucht dann alternative Wege, z.B. die umgekehrte Operandenreihenfolge (`__radd__`, etc.) [1, S. 411].

**Arten von Operatoren und zugehörige Magic Methods:**
*   **Vergleichsoperatoren:** `__lt__` (<), `__le__` (<=), `__eq__` (==), `__ne__` (!=), `__gt__` (>), `__ge__` (>=). Für `__eq__` werden zwei Konten anhand ihrer Kontonummer verglichen [1, S. 412-413].
*   **Binäre arithmetische Operatoren:** `__add__` (+), `__sub__` (-), `__mul__` (*), `__truediv__` (/), `__floordiv__` (//), `__mod__` (%), `__pow__` (**), `__lshift__` (<<), `__rshift__` (>>), `__and__` (&), `__or__` (|), `__xor__` (^), `__matmul__` (@) [1, S. 413-414].
*   **Binäre Operatoren mit umgekehrter Operandenreihenfolge:** `__radd__`, `__rsub__`, etc. Werden aufgerufen, wenn der erste Operand die Operation nicht unterstützt oder `NotImplemented` zurückgibt [1, S. 414-415].
*   **Erweiterte Zuweisungen:** `__iadd__` (+=), `__isub__` (-=), `__imul__` (*=), etc. Ermöglichen In-place-Operationen. Sie müssen eine Referenz auf das Ergebnis (typischerweise `self`) zurückgeben [1, S. 415-416].
*   **Unäre Operatoren:** `__pos__` (+), `__neg__` (-), `__abs__` (abs()), `__invert__` (~) [1, S. 416].

#### 19.11.3 Datentypen emulieren – Duck-Typing
In Python wird der Typ einer Instanz oft anhand der Methoden beurteilt, die sie implementiert, und nicht anhand ihrer expliziten Klassenzugehörigkeit. Dies wird als **Duck-Typing** bezeichnet ("Wenn es wie eine Ente läuft, schwimmt und quakt, nenne ich es eine Ente") [1, S. 417].
Das bedeutet, man kann eigene Klassen so gestalten, dass sie sich wie eingebauten Typen (z.B. Zahlen, Sequenzen, Mappings) verhalten, indem man die entsprechenden Magic Methods implementiert.

*   **Numerische Datentypen emulieren:** Implementierung arithmetischer Operatoren, `__complex__`, `__int__`, `__float__`, `__round__`, `__index__` [1, S. 417-418].
*   **Kontext-Manager implementieren:** Für die Verwendung mit der `with`-Anweisung (`with obj as var: ...`) müssen `__enter__(self)` und `__exit__(self, exc_type, exc_value, traceback)` implementiert werden. `__exit__` garantiert das Aufräumen, sobald der `with`-Block verlassen wird [1, S. 418].
*   **Container emulieren:**
    *   **Allgemeine Methoden für Container:** `__len__`, `__getitem__` (für `[]`-Lesezugriff), `__setitem__` (für `[]`-Schreibzugriff), `__delitem__` (für `del obj[]`), `__iter__` (für Iteratoren), `__contains__` (für `in`-Operator) [1, S. 419].
    *   **Methoden für sequenzielle Container:** Zusätzliche Methoden für Konkatenation (`__add__`, `__iadd__`) und Wiederholung (`__mul__`, `__imul__`), sowie mutable Methoden wie `append`, `extend`, `insert`, `pop`, `remove`, `reverse`, `sort` [1, S. 419-420].
    *   **Methoden für Mapping-Container:** Methoden wie `keys()`, `values()`, `items()`, `get()`, `clear()`, `update()`, `pop()` (ähnlich wie bei Dictionaries) [1, S. 421].

---

### 19.12 Datenklassen

**Datenklassen** (engl. data classes), eingeführt in Python 3.7, bieten eine umfassende und komfortable Möglichkeit zur Repräsentation strukturierter Daten. Sie verbessern die bisherigen Ansätze mit Tupeln, Listen oder Dictionaries [1, S. 421-424]:
*   **Tupel/Listen:** Zugriff über Indizes ist unübersichtlich (`adresse[1]`). Keine Typprüfung oder Konsistenzprüfung.
*   **Dictionarys:** Zugriff über Schlüssel ist lesbarer (`adresse["hausnummer"]`), aber keine inhärente Prüfung auf Vollständigkeit oder Konsistenz.
*   **Benannte Tupel (`collections.namedtuple`):** Ermöglichen Attributzugriff (`adresse.hausnummer`) und sind lesbarer, aber unveränderlich und erben alle Eigenschaften von Tupeln.

Datenklassen bieten eine saubere Alternative, indem sie viele der Boilerplate-Methoden (wie `__init__`, `__repr__`, `__eq__`) automatisch generieren.

#### 19.12.1 Veränderliche Datenklassen
Eine Datenklasse wird mit dem Decorator `@dataclasses.dataclass` definiert, gefolgt von der Klasse und ihren Attributen, die mit Typannotationen versehen sind [1, S. 424-425].
```python
import dataclasses

@dataclasses.dataclass
class Adresse:
    straße: str
    hausnummer: int
    plz: int
    stadt: str

adresse = Adresse("Domkloster", 4, 50667, "Köln")
print(adresse) # Ausgabe: Adresse(straße='Domkloster', hausnummer=4, plz=50667, stadt='Köln')
```
Standardmäßig sind Datenklassen veränderlich und erhalten automatisch Magic Methods für Vergleich, Repräsentation etc.

#### 19.12.2 Unveränderliche Datenklassen
Durch den Parameter `frozen=True` im Decorator wird die Datenklasse unveränderlich und gleichzeitig hashable, wodurch ihre Instanzen als Dictionary-Schlüssel oder Set-Elemente verwendet werden können [1, S. 425].
```python
@dataclasses.dataclass(frozen=True)
class FrozenAdresse:
    straße: str
    hausnummer: int
    plz: int
    stadt: str
```

#### 19.12.3 Defaultwerte in Datenklassen
Datenklassen erlauben es, Attribute mit Standardwerten zu versehen. Die Methode `__post_init__` wird nach dem automatischen Konstruktor aufgerufen und kann zur Validierung oder automatischen Ergänzung von Werten verwendet werden [1, S. 425-426].
```python
@dataclasses.dataclass()
class Adresse:
    straße: str
    hausnummer: int
    plz: int
    stadt: str = "" # Defaultwert
    
    def __post_init__(self):
        if not self.stadt and self.plz == 50667:
            self.stadt = "Köln" # Automatische Ergänzung

adresse = Adresse("Domkloster", 4, 50667)
print(adresse) # Ausgabe: Adresse(straße='Domkloster', hausnummer=4, plz=50667, stadt='Köln')
```
Datenklassen sind vollwertige Klassen, was bedeutet, dass man ihnen beliebige Methoden hinzufügen und Vererbungshierarchien mit ihnen realisieren kann [1, S. 426].

---

Ich hoffe, diese detaillierte Erklärung hilft Ihnen, das Kapitel zur Objektorientierten Programmierung gut zu verstehen! Lassen Sie mich wissen, wenn Sie noch Fragen haben.
