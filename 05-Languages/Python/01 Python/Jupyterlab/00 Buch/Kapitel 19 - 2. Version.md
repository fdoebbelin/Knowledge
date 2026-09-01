Absolut, Fritz-Rainer! Gerne erstelle ich Ihnen die Erklärung so, dass sie optimal in einem Jupyter Notebook verwendet werden kann. Ich werde den Text mit Markdown-Überschriften strukturieren und Code-Blöcke für die Beispiele bereitstellen, die Sie direkt ausführen können.

---

# Kapitel 19: Objektorientierte Programmierung in Python

Dieses Dokument erklärt die Grundlagen der Objektorientierten Programmierung (OOP) in Python, basierend auf dem bereitgestellten Text "00 Kapitel 19.pdf". Es ist so strukturiert, dass es gut in einem Jupyter Notebook verwendet werden kann, mit erklärendem Text und direkt ausführbaren Code-Beispielen.

---

## 1. Einführung in die Objektorientierte Programmierung

Bisher haben wir in Python mit vordefinierten Objekten wie `Strings`, `Listen` oder `Dictionaries` gearbeitet. Die Objektorientierte Programmierung zeigt, wie wir eigene, an spezifische Anforderungen angepasste Objekte definieren können.

**Objektorientierung** ist ein Programmierparadigma, das Datenstrukturen (**Attribute**) und die dazugehörigen Operationen (**Methoden**) zu einer Einheit, einem **Objekt**, zusammenfasst. Dies verbessert die Konsistenz von Datenobjekten und die Wiederverwendbarkeit von Quellcode.

---

## 2. Beispiel: Ein nicht objektorientiertes Konto

Zuerst betrachten wir einen traditionellen, nicht-objektorientierten Ansatz zur Verwaltung von Bankkonten. Jedes Konto wird hierbei durch ein Python-Dictionary dargestellt. Operationen wie Überweisungen oder Einzahlungen werden durch separate Funktionen realisiert, die diese Dictionaries manipulieren.

### 2.1 Konto-Datenstruktur (Dictionary)

Ein vereinfachtes Konto könnte so aussehen. Führen Sie diesen Code-Block aus, um ein Beispiel-Konto zu erstellen:

```python
# Ein Dictionary zur Repräsentation eines Kontos
konto = {
    "inhaber": "Hans Meier",
    "kontonummer": 567123,
    "kontostand": 12350.0,
    "max_tagesumsatz": 1500,
    "umsatz_heute": 10.0
}

print(konto)
```

### 2.2 Funktionen zur Kontoverwaltung

Hier sind die Funktionen, die die Operationen auf diesen Konto-Dictionaries durchführen. Sie können diese Blöcke ebenfalls ausführen, um die Funktionen zu definieren.

#### 2.2.1 Neues Konto anlegen

```python
def neues_konto(inhaber, kontonummer, kontostand, max_tagesumsatz=1500):
    return {
        "inhaber": inhaber,
        "kontonummer": kontonummer,
        "kontostand": kontostand,
        "max_tagesumsatz": max_tagesumsatz,
        "umsatz_heute": 0.0
    }

print("Funktion 'neues_konto' definiert.")
```

#### 2.2.2 Geld überweisen

Die Funktion `geldtransfer` prüft auf negative Beträge und Tageslimits, bevor die Überweisung durchgeführt wird.

```python
def geldtransfer(quelle, ziel, betrag):
    if (betrag < 0 or
        quelle["umsatz_heute"] + betrag > quelle["max_tagesumsatz"] or
        ziel["umsatz_heute"] + betrag > ziel["max_tagesumsatz"]):
        # Transfer unmöglich
        return False
    else:
        # Alles OK - Auf geht's
        quelle["kontostand"] -= betrag
        quelle["umsatz_heute"] += betrag
        ziel["kontostand"] += betrag
        ziel["umsatz_heute"] += betrag
        return True

print("Funktion 'geldtransfer' definiert.")
```

#### 2.2.3 Geld ein- und auszahlen

```python
def einzahlen(konto, betrag):
    if betrag < 0 or konto["umsatz_heute"] + betrag > konto["max_tagesumsatz"]:
        # Tageslimit überschritten oder ungültiger Betrag
        return False
    else:
        konto["kontostand"] += betrag
        konto["umsatz_heute"] += betrag
        return True

def auszahlen(konto, betrag):
    if betrag < 0 or konto["umsatz_heute"] + betrag > konto["max_tagesumsatz"]:
        # Tageslimit überschritten oder ungültiger Betrag
        return False
    else:
        konto["kontostand"] -= betrag
        konto["umsatz_heute"] += betrag
        return True

print("Funktionen 'einzahlen' und 'auszahlen' definiert.")
```

#### 2.2.4 Kontostand anzeigen

```python
def zeige_konto(konto):
    print("Konto von {}".format(konto["inhaber"]))
    print("Aktueller Kontostand: {:.2f} Euro".format(konto["kontostand"]))
    print("(Heute schon {:.2f} von {} Euro umgesetzt)".format(
        konto["umsatz_heute"], konto["max_tagesumsatz"]))

print("Funktion 'zeige_konto' definiert.")
```

### 2.3 Simulation mit nicht-objektorientiertem Ansatz

Führen Sie diesen Block aus, um die Bankoperationen zu simulieren:

```python
# Simulation der Bankoperationen
k1 = neues_konto("Heinz Meier", 567123, 12350.0)
k2 = neues_konto("Erwin Schmidt", 396754, 15000.0)

print("Konten vor den Transaktionen:")
zeige_konto(k1)
zeige_konto(k2)
print("-" * 30)

print(f"Überweisung k1 an k2 (160 Euro): {geldtransfer(k1, k2, 160)}")
print(f"Überweisung k2 an k1 (1000 Euro): {geldtransfer(k2, k1, 1000)}")
print(f"Überweisung k2 an k1 (500 Euro): {geldtransfer(k2, k1, 500)} (Fehlgeschlagen wegen Tageslimit)")
print(f"Einzahlen auf k2 (500 Euro): {einzahlen(k2, 500)} (Fehlgeschlagen wegen Tageslimit)")
print("-" * 30)

print("Konten nach den Transaktionen:")
zeige_konto(k1)
zeige_konto(k2)
```

### 2.4 Fazit des nicht-objektorientierten Ansatzes

Der Nachteil dieses Ansatzes ist die Trennung von Daten (Dictionaries) und den Funktionen, die sie manipulieren. Das Konto-Dictionary muss bei jedem Funktionsaufruf explizit als Parameter übergeben werden, was den Code unübersichtlich machen kann.

---

## 3. Klassen: Der objektorientierte Weg

**Klassen** dienen als Blaupausen oder Baupläne zur Erzeugung von Objekten. Eine Klasse definiert, welche **Attribute** (Daten) und **Methoden** (Funktionen) ein Objekt dieses Typs haben wird. Ein aus einer Klasse erzeugtes Element wird **Objekt** oder **Instanz** genannt.

### 3.1 Eine einfache Klasse definieren

Eine Klasse wird mit dem Schlüsselwort `class` definiert. Eine Instanz wird durch Aufruf der Klasse wie einer Funktion erzeugt.

```python
class Konto:
    pass # Eine leere Klasse

# Eine Instanz der Klasse Konto erzeugen
mein_konto = Konto()
print(mein_konto)
print(type(mein_konto))
```

### 3.2 Methoden definieren (`self`)

Methoden werden innerhalb der Klasse definiert und erhalten immer `self` als ersten Parameter. `self` ist eine Referenz auf die Instanz (das Objekt), über die die Methode aufgerufen wurde.

```python
class Konto:
    def einzahlen(self, betrag):
        print(f"Methode 'einzahlen' aufgerufen für die Instanz: {self}")
        print(f"Betrag: {betrag} Euro")

# Eine Instanz erzeugen
k = Konto()

# Methode aufrufen
k.einzahlen(500)
```

### 3.3 Der Konstruktor (`__init__`) und Attribute

Der **Konstruktor** ist eine spezielle Methode namens `__init__`, die automatisch beim Erzeugen einer neuen Instanz aufgerufen wird. Hier werden die initialen **Attribute** des Objekts gesetzt.

```python
class Konto:
    def __init__(self, inhaber, kontonummer, kontostand):
        print("Konstruktor aufgerufen!")
        self.inhaber = inhaber        # Attribut definieren
        self.kontonummer = kontonummer # Attribut definieren
        self.kontostand = kontostand  # Attribut definieren
        self.umsatz_heute = 0.0      # Standardwert für Attribut

    def zeige_inhaber(self):
        print(f"Konto-Inhaber: {self.inhaber}") # Zugriff auf Attribute über self

# Eine Instanz mit dem Konstruktor erzeugen
k_neu = Konto("Petra Müller", 98765, 5000.0)

# Attribute und Methoden verwenden
k_neu.zeige_inhaber()
print(f"Kontostand von {k_neu.inhaber}: {k_neu.kontostand} Euro")
```

### 3.4 Das objektorientierte Konto: Die `Konto`-Klasse

Nun implementieren wir die vollständige `Konto`-Klasse, die alle vorherigen Funktionen als Methoden enthält. Die Daten und Operationen sind nun untrennbar miteinander verbunden.

```python
class Konto:
    def __init__(self, inhaber, kontonummer, kontostand, max_tagesumsatz=1500):
        self.inhaber = inhaber
        self.kontonummer = kontonummer
        self.kontostand = kontostand
        self.max_tagesumsatz = max_tagesumsatz
        self.umsatz_heute = 0.0

    def geldtransfer(self, ziel, betrag):
        # self ist das Quellkonto, ziel ist das Zielkonto
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
        print(f"Konto von {self.inhaber}")
        print(f"Aktueller Kontostand: {self.kontostand:.2f} Euro")
        print(f"(Heute schon {self.umsatz_heute:.2f} von {self.max_tagesumsatz} Euro umgesetzt)")

print("Klasse 'Konto' (objektorientiert) definiert.")
```

### 3.5 Simulation mit objektorientiertem Ansatz

Führen Sie diesen Code-Block aus, um die Simulation mit der neuen `Konto`-Klasse zu starten:

```python
# Simulation der Bankoperationen mit objektorientiertem Ansatz
k1_obj = Konto("Heinz Meier", 567123, 12350.0)
k2_obj = Konto("Erwin Schmidt", 396754, 15000.0)

print("Konten vor den Transaktionen:")
k1_obj.zeige()
k2_obj.zeige()
print("-" * 30)

print(f"Überweisung k1 an k2 (160 Euro): {k1_obj.geldtransfer(k2_obj, 160)}")
print(f"Überweisung k2 an k1 (1000 Euro): {k2_obj.geldtransfer(k1_obj, 1000)}")
print(f"Überweisung k2 an k1 (500 Euro): {k2_obj.geldtransfer(k1_obj, 500)} (Fehlgeschlagen wegen Tageslimit)")
print(f"Einzahlen auf k2 (500 Euro): {k2_obj.einzahlen(500)} (Fehlgeschlagen wegen Tageslimit)")
print("-" * 30)

print("Konten nach den Transaktionen:")
k1_obj.zeige()
k2_obj.zeige()
```

---

## 4. Vererbung: Code-Wiederverwendbarkeit

**Vererbung** erlaubt es uns, neue Klassen (Tochterklassen oder Subklassen) aus bestehenden Klassen (Basisklassen oder Superklassen) abzuleiten. Die Tochterklasse erbt dabei Attribute und Methoden der Basisklasse und kann diese erweitern oder anpassen (überschreiben).

### 4.1 Eine einfache Vererbungs-Hierarchie

```python
class A:
    def __init__(self):
        print("Konstruktor von A")
        self.x = 1337
    def m(self):
        print(f"Methode m von A. Es ist self.x = {self.x}")

class B(A): # Klasse B erbt von Klasse A
    def n(self):
        print("Methode n von B")

# Instanz von B erzeugen
b_inst = B()

# Methoden von B und A aufrufen
b_inst.n() # Methode aus Klasse B
b_inst.m() # Geerbte Methode aus Klasse A
```

### 4.2 Überschreiben von Methoden und `super()`

Wenn eine Tochterklasse eine Methode mit dem gleichen Namen wie die Basisklasse definiert, wird die Methode der Tochterklasse verwendet (Überschreiben). Mit `super()` kann man explizit Methoden der Basisklasse aufrufen, was besonders wichtig für den Konstruktor `__init__` ist.

```python
class A:
    def __init__(self):
        print("Konstruktor von A")
        self.x = 1337
    def m(self):
        print(f"Methode m von A. Es ist self.x = {self.x}")

class B(A):
    def __init__(self): # Überschreibt A.__init__
        print("Konstruktor von B")
        super().__init__() # Expliziter Aufruf des Konstruktors von A
        self.y = 10000

    def n(self):
        print(f"Methode n von B. Es ist self.y = {self.y}")

    def m(self): # Überschreibt A.m
        print("Methode m von B.")
        super().m() # Expliziter Aufruf der Methode m von A

# Instanz von B erzeugen
b_inst = B()

# Methoden aufrufen
b_inst.n()
b_inst.m() # Ruft erst B.m auf, welches dann A.m aufruft
```

### 4.3 Beispiel: Girokonto mit Tagesumsatz (Vererbungs-Hierarchie)

Der Text schlägt eine detaillierte Vererbungshierarchie vor, um das Konto-Beispiel flexibler zu gestalten.

#### 4.3.1 `VerwalteterGeldbetrag` (Basisklasse)

Dies ist die unterste Ebene, die lediglich einen Geldbetrag verwaltet und grundlegende Ein-/Auszahlungsmechanismen bietet. Die `_moeglich`-Methoden sind hier immer `True` und können in Unterklassen überschrieben werden.

```python
class VerwalteterGeldbetrag:
    def __init__(self, anfangsbetrag):
        self.betrag = anfangsbetrag

    def einzahlen_moeglich(self, betrag):
        return True

    def auszahlen_moeglich(self, betrag):
        return True

    def einzahlen(self, betrag):
        if betrag < 0 or not self.einzahlen_moeglich(betrag):
            return False
        else:
            self.betrag += betrag
            return True

    def auszahlen(self, betrag):
        if betrag < 0 or not self.auszahlen_moeglich(betrag):
            return False
        else:
            self.betrag -= betrag
            return True

    def zeige(self):
        print(f"Betrag: {self.betrag:.2f}")

print("Klasse 'VerwalteterGeldbetrag' definiert.")
```

#### 4.3.2 `AllgemeinesKonto`

Erweitert `VerwalteterGeldbetrag` um Kundendaten und die Fähigkeit zum Geldtransfer zwischen Konten. Es wird eine generische `kundendaten` Instanz erwartet.

```python
class AllgemeinesKonto(VerwalteterGeldbetrag):
    def __init__(self, kundendaten, kontostand):
        super().__init__(kontostand) # Ruft den Konstruktor von VerwalteterGeldbetrag auf
        self.kundendaten = kundendaten

    def geldtransfer(self, ziel, betrag):
        # Prüft, ob der Transfer für beide Seiten möglich ist
        if self.auszahlen_moeglich(betrag) and ziel.einzahlen_moeglich(betrag):
            # Führt die tatsächlichen Ein-/Auszahlungen durch
            self.auszahlen(betrag)
            ziel.einzahlen(betrag)
            return True
        else:
            return False

    def zeige(self):
        # Gibt zuerst die Kundendaten und dann den Geldbetrag aus
        self.kundendaten.zeige()
        super().zeige() # Ruft die zeige-Methode der Basisklasse auf

print("Klasse 'AllgemeinesKonto' definiert.")
```

#### 4.3.3 `AllgemeinesKontoMitTagesumsatz`

Fügt die Logik für den maximalen Tagesumsatz hinzu, indem es die `_moeglich`-Methoden überschreibt und `umsatz_heute` verwaltet.

```python
class AllgemeinesKontoMitTagesumsatz(AllgemeinesKonto):
    def __init__(self, kundendaten, kontostand, max_tagesumsatz=1500):
        super().__init__(kundendaten, kontostand)
        self.max_tagesumsatz = max_tagesumsatz
        self.umsatz_heute = 0.0

    def transfer_moeglich(self, betrag):
        return (self.umsatz_heute + betrag <= self.max_tagesumsatz)

    def auszahlen_moeglich(self, betrag):
        # Prüft zusätzlich das Tageslimit
        return super().auszahlen_moeglich(betrag) and self.transfer_moeglich(betrag)

    def einzahlen_moeglich(self, betrag):
        # Prüft zusätzlich das Tageslimit
        return super().einzahlen_moeglich(betrag) and self.transfer_moeglich(betrag)

    def einzahlen(self, betrag):
        # Aktualisiert den Tagesumsatz, wenn die Einzahlung erfolgreich war
        if super().einzahlen(betrag):
            self.umsatz_heute += betrag
            return True
        else:
            return False

    def auszahlen(self, betrag):
        # Aktualisiert den Tagesumsatz, wenn die Auszahlung erfolgreich war
        if super().auszahlen(betrag):
            self.umsatz_heute += betrag
            return True
        else:
            return False

    def zeige(self):
        super().zeige() # Ruft die zeige-Methode der Basisklasse auf
        print(f"Heute schon {self.umsatz_heute:.2f} von {self.max_tagesumsatz:.2f} Euro umgesetzt")

print("Klasse 'AllgemeinesKontoMitTagesumsatz' definiert.")
```

#### 4.3.4 `GirokontoKundendaten`

Dies ist eine separate Klasse zur Verwaltung spezifischer Kundendaten für ein Girokonto (`inhaber`, `kontonummer`) mit einer eigenen `zeige`-Methode.

```python
class GirokontoKundendaten:
    def __init__(self, inhaber, kontonummer):
        self.inhaber = inhaber
        self.kontonummer = kontonummer

    def zeige(self):
        print(f"Inhaber: {self.inhaber}")
        print(f"Kontonummer: {self.kontonummer}")

print("Klasse 'GirokontoKundendaten' definiert.")
```

#### 4.3.5 `GirokontoMitTagesumsatz`

Diese endgültige Klasse erbt von `AllgemeinesKontoMitTagesumsatz` und integriert die `GirokontoKundendaten`. Sie bildet den gesamten Funktionsumfang der ursprünglichen `Konto`-Klasse ab.

```python
class GirokontoMitTagesumsatz(AllgemeinesKontoMitTagesumsatz):
    def __init__(self, inhaber, kontonummer, kontostand, max_tagesumsatz=1500):
        # Erstellt eine Instanz von GirokontoKundendaten und übergibt sie an die Basisklasse
        kundendaten = GirokontoKundendaten(inhaber, kontonummer)
        super().__init__(kundendaten, kontostand, max_tagesumsatz)

print("Klasse 'GirokontoMitTagesumsatz' definiert.")
```

#### 4.3.6 Simulation mit der Vererbungs-Hierarchie

Führen Sie diesen Code-Block aus, um die Simulation mit der neu strukturierten Klassenhierarchie zu starten:

```python
# Simulation der Bankoperationen mit der Vererbungs-Hierarchie
k1_hier = GirokontoMitTagesumsatz("Heinz Meier", 567123, 12350.0)
k2_hier = GirokontoMitTagesumsatz("Erwin Schmidt", 396754, 15000.0)

print("Konten vor den Transaktionen (Hierarchie-Version):")
k1_hier.zeige()
k2_hier.zeige()
print("-" * 30)

print(f"Überweisung k1 an k2 (160 Euro): {k1_hier.geldtransfer(k2_hier, 160)}")
print(f"Überweisung k2 an k1 (1000 Euro): {k2_hier.geldtransfer(k1_hier, 1000)}")
print(f"Überweisung k2 an k1 (500 Euro): {k2_hier.geldtransfer(k1_hier, 500)} (Fehlgeschlagen wegen Tageslimit)")
print(f"Einzahlen auf k2 (500 Euro): {k2_hier.einzahlen(500)} (Fehlgeschlagen wegen Tageslimit)")
print("-" * 30)

print("Konten nach den Transaktionen (Hierarchie-Version):")
k1_hier.zeige()
k2_hier.zeige()
```

#### 4.3.7 Erweiterungen durch Vererbung (Weitere Beispielklassen)

Hier sind weitere Beispielklassen, die die Erweiterbarkeit der Struktur demonstrieren.

```python
# -- Klassen für Bargeldbeträge --
class VerwalteterBargeldbetrag(VerwalteterGeldbetrag):
    def __init__(self, bargeldbetrag):
        if bargeldbetrag < 0:
            bargeldbetrag = 0
        super().__init__(bargeldbetrag)

    def auszahlen_moeglich(self, betrag):
        return (self.betrag >= betrag)

class Geldboerse(VerwalteterBargeldbetrag):
    # TODO: Spezielle Methoden für eine Geldbörse
    pass

class Tresor(VerwalteterBargeldbetrag):
    # TODO: Spezielle Methoden für einen Tresor
    pass

# -- Klassen für Nummernkonten --
class NummernkontoKundendaten:
    def __init__(self, identifikationsnummer):
        self.identifikationsnummer = identifikationsnummer
    def zeige(self):
        print(f"Identifikationsnummer: {self.identifikationsnummer}")

class Nummernkonto(AllgemeinesKonto):
    def __init__(self, identifikationsnummer, kontostand):
        kundendaten = NummernkontoKundendaten(identifikationsnummer)
        super().__init__(kundendaten, kontostand)

class NummernkontoMitTagesumsatz(AllgemeinesKontoMitTagesumsatz):
    def __init__(self, identifikationsnummer, kontostand, max_tagesumsatz):
        kundendaten = NummernkontoKundendaten(identifikationsnummer)
        super().__init__(kundendaten, kontostand, max_tagesumsatz)

# -- Girokonto ohne Tageslimit --
class Girokonto(AllgemeinesKonto):
    def __init__(self, inhaber, kontonummer, kontostand):
        kundendaten = GirokontoKundendaten(inhaber, kontonummer)
        super().__init__(kundendaten, kontostand)

print("Weitere Beispielklassen definiert.")
```

#### 4.3.8 Simulation mit Nummernkonten

```python
# Beispiel mit Nummernkonten
nk1 = Nummernkonto(113427613185, 5000)
nk2 = NummernkontoMitTagesumsatz(45657364234, 12000, 3000)

print("Nummernkonten vor Transaktionen:")
nk1.zeige()
nk2.zeige()
print("-" * 30)

print(f"nk1 Auszahlen 1000: {nk1.auszahlen(1000)}")
print(f"nk2 Einzahlen 1500: {nk2.einzahlen(1500)}")
print(f"nk1 Geldtransfer 2000 an nk2: {nk1.geldtransfer(nk2, 2000)} (Fehlgeschlagen wegen Tageslimit von nk2)")
print("-" * 30)

print("Nummernkonten nach Transaktionen:")
nk1.zeige()
nk2.zeige()
```

---

## 5. Mehrfachvererbung

**Mehrfachvererbung** erlaubt es einer Klasse, von mehreren Basisklassen zu erben. Man listet die Basisklassen, durch Kommata getrennt, in den Klammern hinter dem Klassennamen auf.

```python
class Basisklasse1:
    def methode1(self):
        print("Methode aus Basisklasse 1")

class Basisklasse2:
    def methode2(self):
        print("Methode aus Basisklasse 2")

class NeueKlasse(Basisklasse1, Basisklasse2):
    pass # Erbt Methoden von beiden Basisklassen

obj = NeueKlasse()
obj.methode1()
obj.methode2()
```

### 5.1 Mögliche Probleme der Mehrfachvererbung

Mehrfachvererbung kann komplex sein und zu Problemen wie Namenskonflikten führen. Wenn mehrere Basisklassen eine Methode mit dem gleichen Namen haben, erbt die Tochterklasse die Methode von der Basisklasse, die am weitesten links in der Liste der Basisklassen steht. In der Praxis wird Mehrfachvererbung oft umgangen, um Komplexität zu vermeiden.

---

## 6. Property-Attribute

Property-Attribute bieten eine elegante Möglichkeit, den Zugriff auf Attribute einer Klasse zu steuern, indem sie Setter- und Getter-Methoden implizit aufrufen.

### 6.1 Setter und Getter (Manuell)

Ein klassischer Ansatz ist die Verwendung von expliziten Setter- und Getter-Methoden, oft mit einem internen Attribut, das mit einem Unterstrich beginnt (`_x`), um anzuzeigen, dass es nicht direkt manipuliert werden sollte.

```python
class Auto:
    def __init__(self):
        self._geschwindigkeit = 0 # Internes Attribut

    def get_geschwindigkeit(self):
        return self._geschwindigkeit

    def set_geschwindigkeit(self, wert):
        if 0 <= wert <= 200: # Validierung
            self._geschwindigkeit = wert
        else:
            print("Ungültige Geschwindigkeit!")

mein_auto = Auto()
mein_auto.set_geschwindigkeit(100)
print(f"Aktuelle Geschwindigkeit: {mein_auto.get_geschwindigkeit()} km/h")
mein_auto.set_geschwindigkeit(250) # Wird abgelehnt
print(f"Aktuelle Geschwindigkeit: {mein_auto.get_geschwindigkeit()} km/h")
```

### 6.2 Property-Attribute definieren mit `@property`

Python bietet den `@property`-Decorator, um Getter, Setter und Delter für Attribute auf eine "pythonischere" Weise zu definieren.

```python
class Auto:
    def __init__(self):
        self._geschwindigkeit = 0 # Internes Attribut

    @property # Der Getter für 'geschwindigkeit'
    def geschwindigkeit(self):
        print("Getter für geschwindigkeit aufgerufen")
        return self._geschwindigkeit

    @geschwindigkeit.setter # Der Setter für 'geschwindigkeit'
    def geschwindigkeit(self, wert):
        print("Setter für geschwindigkeit aufgerufen")
        if 0 <= wert <= 200:
            self._geschwindigkeit = wert
        else:
            print(f"Ungültige Geschwindigkeit: {wert}. Wert nicht geändert.")

    @geschwindigkeit.deleter # Der Deleter für 'geschwindigkeit'
    def geschwindigkeit(self):
        print("Deleter für geschwindigkeit aufgerufen. Geschwindigkeit wird auf 0 gesetzt.")
        del self._geschwindigkeit
        self._geschwindigkeit = 0 # Oder Attribut entfernen

mein_auto = Auto()

# Zugriff und Zuweisung über das Property-Attribut 'geschwindigkeit'
mein_auto.geschwindigkeit = 120 # Ruft den Setter auf
print(f"Auto fährt: {mein_auto.geschwindigkeit} km/h") # Ruft den Getter auf

mein_auto.geschwindigkeit = 300 # Ruft den Setter auf, Validierung schlägt fehl
print(f"Auto fährt (nach ungültigem Versuch): {mein_auto.geschwindigkeit} km/h")

del mein_auto.geschwindigkeit # Ruft den Deleter auf
print(f"Auto fährt (nach deleter): {mein_auto.geschwindigkeit} km/h")
```

---

## 7. Statische und Klassenmethoden

Neben instanzbezogenen Methoden gibt es Methoden, die sich auf die Klasse selbst beziehen.

### 7.1 Statische Methoden (`@staticmethod`)

Statische Methoden gehören zur Klasse, benötigen aber keine Instanz, um aufgerufen zu werden, und haben keinen `self`-Parameter. Sie sind nützlich für Hilfsfunktionen, die logisch zur Klasse gehören, aber nicht auf Instanzdaten zugreifen müssen.

```python
class Taschenrechner:
    def addieren(self, a, b): # Normale Instanzmethode
        return a + b

    @staticmethod
    def multiplizieren(a, b): # Statische Methode
        return a * b

    @staticmethod
    def beschreibung():
        return "Dies ist ein Taschenrechner, der grundlegende Operationen ausführen kann."

# Aufruf einer statischen Methode über die Klasse
print(f"Multiplikation (statisch): {Taschenrechner.multiplizieren(5, 3)}")

# Eine Instanz ist nicht zwingend für statische Methoden
# t = Taschenrechner()
# print(t.multiplizieren(5,3)) # Geht auch

print(Taschenrechner.beschreibung())

# Eine Instanzmethode benötigt eine Instanz
t_inst = Taschenrechner()
print(f"Addition (instanz): {t_inst.addieren(5, 3)}")
```

### 7.2 Klassenmethoden (`@classmethod`)

Klassenmethoden erhalten als ersten Parameter eine Referenz auf die Klasse selbst (`cls`). Sie können über die Klasse oder eine Instanz aufgerufen werden und sind nützlich für alternative Konstruktoren oder Methoden, die auf Klassenattribute zugreifen.

```python
class Auto:
    anzahl_autos = 0 # Klassenattribut

    def __init__(self, marke):
        self.marke = marke
        Auto.anzahl_autos += 1

    @classmethod
    def get_anzahl_autos(cls): # cls ist die Klasse Auto
        return cls.anzahl_autos

    @classmethod
    def von_string(cls, auto_string): # Alternativer Konstruktor (Factory Method)
        marke, modell = auto_string.split('-')
        return cls(f"{marke} {modell}") # Erstellt eine Instanz der aufrufenden Klasse

# Aufruf der Klassenmethode über die Klasse
auto1 = Auto("Mercedes")
auto2 = Auto("BMW")
print(f"Anzahl der erstellten Autos: {Auto.get_anzahl_autos()}")

# Aufruf über eine Instanz (geht auch)
print(f"Anzahl der erstellten Autos (über Instanz): {auto1.get_anzahl_autos()}")

# Alternativer Konstruktor verwenden
auto3 = Auto.von_string("Audi-A4")
print(f"Neues Auto erstellt: {auto3.marke}")
print(f"Anzahl der erstellten Autos: {Auto.get_anzahl_autos()}")
```

---

## 8. Klassenattribute

Klassenattribute sind Attribute, die allen Instanzen einer Klasse gemeinsam sind. Sie werden direkt im Klassenkörper definiert und können sowohl über die Klasse als auch über ihre Instanzen zugegriffen werden.

```python
class Planet:
    # Klassenattribute
    galaxie = "Milchstraße"
    ist_rund = True

    def __init__(self, name, groesse):
        self.name = name     # Instanzattribut
        self.groesse = groesse # Instanzattribut

# Zugriff über die Klasse
print(f"Alle Planeten sind in der {Planet.galaxie}.")

# Zugriff über Instanzen
erde = Planet("Erde", 12742)
mars = Planet("Mars", 6779)

print(f"{erde.name} ist in der {erde.galaxie}.") # Greift auf Klassenattribut zu
print(f"{mars.name} ist rund: {mars.ist_rund}.") # Greift auf Klassenattribut zu

# Klassenattribut ändern (wirkt sich auf alle Instanzen aus)
Planet.galaxie = "Andromeda"
print(f"Neue Galaxie für {erde.name}: {erde.galaxie}")
```

---

## 9. Built-in Functions für die objektorientierte Programmierung

Python bietet nützliche Built-in Functions zur Inspektion und Manipulation von Objekten und Klassen.

### 9.1 Funktionen für die Verwaltung von Attributen

*   `getattr(object, name, [default])`: Holt den Wert eines Attributs.
*   `setattr(object, name, value)`: Setzt den Wert eines Attributs.
*   `hasattr(object, name)`: Prüft, ob ein Attribut existiert.
*   `delattr(object, name)`: Löscht ein Attribut.

```python
class Person:
    def __init__(self, name, alter):
        self.name = name
        self.alter = alter

p = Person("Anna", 30)

# hasattr
print(f"Hat 'p' das Attribut 'name'? {hasattr(p, 'name')}")
print(f"Hat 'p' das Attribut 'stadt'? {hasattr(p, 'stadt')}")

# getattr
print(f"Name von 'p': {getattr(p, 'name')}")
print(f"Stadt von 'p' (mit Default): {getattr(p, 'stadt', 'Unbekannt')}")

# setattr
setattr(p, 'alter', 31)
print(f"Neues Alter von 'p': {p.alter}")

setattr(p, 'stadt', 'Berlin') # Attribut dynamisch hinzufügen
print(f"Stadt von 'p': {p.stadt}")

# delattr
delattr(p, 'stadt')
print(f"Hat 'p' jetzt das Attribut 'stadt'? {hasattr(p, 'stadt')}")
```

### 9.2 Funktionen für Informationen über die Klassenhierarchie

*   `isinstance(object, classinfo)`: Prüft, ob ein Objekt eine Instanz einer bestimmten Klasse oder ihrer Unterklassen ist.
*   `issubclass(class_, classinfo)`: Prüft, ob eine Klasse eine Unterklasse einer anderen Klasse ist.

```python
class Basis: pass
class Mittel(Basis): pass
class Ende(Mittel): pass
class Andere: pass

obj_basis = Basis()
obj_mittel = Mittel()
obj_ende = Ende()
obj_andere = Andere()

# isinstance Beispiele
print(f"obj_ende ist eine Instanz von Ende: {isinstance(obj_ende, Ende)}")
print(f"obj_ende ist eine Instanz von Mittel: {isinstance(obj_ende, Mittel)}")
print(f"obj_ende ist eine Instanz von Basis: {isinstance(obj_ende, Basis)}")
print(f"obj_ende ist eine Instanz von Andere: {isinstance(obj_ende, Andere)}")
print(f"obj_basis ist eine Instanz von (Mittel, Andere): {isinstance(obj_basis, (Mittel, Andere))}")

print("-" * 30)

# issubclass Beispiele
print(f"Ende ist eine Subklasse von Mittel: {issubclass(Ende, Mittel)}")
print(f"Mittel ist eine Subklasse von Basis: {issubclass(Mittel, Basis)}")
print(f"Ende ist eine Subklasse von Basis: {issubclass(Ende, Basis)}")
print(f"Basis ist eine Subklasse von Ende: {issubclass(Basis, Ende)}") # Falschherum
print(f"Ende ist eine Subklasse von (Andere, Mittel): {issubclass(Ende, (Andere, Mittel))}")
```

---

## 10. Erben von eingebauten Datentypen

Python ist von Grund auf objektorientiert, und man kann sogar von eingebauten Datentypen wie `list` oder `dict` erben, um deren Verhalten anzupassen.

```python
class SortierteListe(list):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.sort() # Beim Initialisieren sortieren

    def __setitem__(self, key, value):
        super().__setitem__(key, value)
        self.sort() # Nach dem Setzen eines Elements sortieren

    def append(self, value):
        super().append(value)
        self.sort() # Nach dem Anhängen sortieren

    def extend(self, sequence):
        super().extend(sequence)
        self.sort() # Nach dem Erweitern sortieren
    
    def insert(self, index, value):
        super().insert(index, value)
        self.sort() # Nach dem Einfügen sortieren

    def reverse(self):
        # Wir überschreiben reverse, um es zu deaktivieren oder ein anderes Verhalten zu erzwingen.
        # Eine sortierte Liste sollte nicht einfach umgedreht werden.
        print("Reverse-Operation nicht erlaubt für SortierteListe.")
        pass

    def __iadd__(self, s): # Für += Operator
        result = super().__iadd__(s)
        self.sort()
        return result
    
    def __imul__(self, n): # Für *= Operator
        result = super().__imul__(n)
        self.sort()
        return result

print("Klasse 'SortierteListe' definiert.")
```

#### Simulation mit `SortierteListe`

```python
my_list = SortierteListe([6, 4, 3])
print(f"Initial: {my_list}")

my_list.append(2)
print(f"Nach append(2): {my_list}")

my_list.extend([67, 0, -56])
print(f"Nach extend([67, 0, -56]): {my_list}")

my_list += [100, 5] # Verwendet __iadd__
print(f"Nach += [100, 5]: {my_list}")

my_list *= 2 # Verwendet __imul__
print(f"Nach *= 2: {my_list}")

my_list.reverse() # Sollte die Nachricht ausgeben und nichts tun
print(f"Nach reverse(): {my_list}")

my_list[0] = 70 # Verwendet __setitem__
print(f"Nach my_list[0] = 70: {my_list}")
```

---

## 11. Magic Methods und Magic Attributes (`__dunder__`)

**Magic Methods** (oder Dunder Methods, für "double underscore") und **Magic Attributes** sind spezielle Methoden und Attribute in Python, deren Namen mit zwei Unterstrichen beginnen und enden (z.B. `__init__`). Sie werden in der Regel nicht direkt aufgerufen, sondern implizit im Hintergrund von Python verwendet, um das Verhalten von Klassen anzupassen.

### 11.1 Allgemeine Magic Methods

*   `__init__(self, ...)`: Der Konstruktor.
*   `__del__(self)`: Der Finalizer (Aufräumen, wenn keine Referenzen mehr existieren). **Achtung: Nicht immer zuverlässig für kritische Aufräumarbeiten!**
*   `__repr__(self)`: String-Darstellung für Entwickler (`repr()`). Sollte idealerweise Code zurückgeben, der das Objekt reproduziert.
*   `__str__(self)`: String-Darstellung für Benutzer (`str()` oder `print()`).
*   `__bool__(self)`: Definiert den Wahrheitswert eines Objekts (`bool()`, `if`-Statements).
*   `__call__(self, ...)`: Macht Instanzen wie Funktionen aufrufbar.
*   `__hash__(self)`: Definiert den Hash-Wert (für `dict`-Schlüssel, `set`-Elemente). Erfordert Unveränderlichkeit und `__eq__`.

#### Beispiel: `__str__`, `__repr__`, `__bool__`, `__call__`

```python
class Rechteck:
    def __init__(self, breite, hoehe):
        self.breite = breite
        self.hoehe = hoehe

    def __str__(self):
        return f"Rechteck({self.breite}x{self.hoehe})"

    def __repr__(self):
        return f"Rechteck(breite={self.breite}, hoehe={self.hoehe})"
    
    def __bool__(self):
        return self.breite > 0 and self.hoehe > 0 # Ein Rechteck ist "wahr", wenn es eine positive Fläche hat

    def __call__(self, skala):
        return Rechteck(self.breite * skala, self.hoehe * skala)

r = Rechteck(10, 5)
print(r)           # Ruft __str__ auf
print(repr(r))     # Ruft __repr__ auf

if r: # Ruft __bool__ auf
    print("Rechteck 'r' hat eine Fläche.")

leeres_r = Rechteck(0, 5)
if not leeres_r:
    print("Rechteck 'leeres_r' hat keine Fläche.")

# Instanz wie eine Funktion aufrufen
grosses_r = r(2) # Ruft __call__ auf
print(f"Vergrößertes Rechteck: {grosses_r}")
```

### 11.2 Zugriff auf Attribute anpassen

*   `__dict__`: Enthält die Attribute der Instanz als Dictionary.
*   `__getattr__(self, name)`: Wird aufgerufen, wenn ein **nicht existierendes** Attribut gelesen wird.
*   `__getattribute__(self, name)`: Wird **immer** aufgerufen, wenn ein Attribut gelesen wird. **Vorsicht vor Rekursion!**
*   `__setattr__(self, name, value)`: Wird **immer** aufgerufen, wenn ein Attribut gesetzt wird. **Vorsicht vor Rekursion!**
*   `__delattr__(self, name)`: Wird aufgerufen, wenn ein Attribut gelöscht wird.
*   `__slots__`: Optimiert den Speicherverbrauch, indem es die Attributnamen festlegt und `__dict__` deaktiviert. Schränkt die Flexibilität ein.

#### Beispiel: `__getattribute__` und `__setattr__`

```python
class DebugAttributZugriff:
    def __init__(self, initial_wert):
        # WICHTIG: Vermeiden Sie self.attribut = wert hier, da es __setattr__ aufrufen würde!
        object.__setattr__(self, 'wert', initial_wert)
        object.__setattr__(self, 'zugriffe', 0)

    def __getattribute__(self, name):
        # WICHTIG: Verwenden Sie object.__getattribute__ hier, um Rekursion zu vermeiden!
        if name == 'zugriffe':
            return object.__getattribute__(self, name)
        
        object.__setattr__(self, 'zugriffe', object.__getattribute__(self, 'zugriffe') + 1)
        print(f"DEBUG: Attribut '{name}' gelesen. Gesamtzugriffe: {self.zugriffe}")
        return object.__getattribute__(self, name)

    def __setattr__(self, name, value):
        print(f"DEBUG: Attribut '{name}' auf '{value}' gesetzt.")
        # WICHTIG: Verwenden Sie object.__setattr__ hier, um Rekursion zu vermeiden!
        object.__setattr__(self, name, value)

obj = DebugAttributZugriff(10)
print(f"Initialwert: {obj.wert}") # Ruft __getattribute__ auf
obj.wert = 20                   # Ruft __setattr__ auf
print(f"Neuer Wert: {obj.wert}")  # Ruft __getattribute__ auf
print(f"Anzahl der Zugriffe (auf 'wert'): {obj.zugriffe}") # Greift direkt auf 'zugriffe' zu, um keine Endlosschleife zu verursachen
```

#### Beispiel: `__slots__`

```python
class PointWithoutSlots:
    def __init__(self, x, y):
        self.x = x
        self.y = y

class PointWithSlots:
    __slots__ = ('x', 'y') # Definiert nur diese Attribute sind erlaubt
    def __init__(self, x, y):
        self.x = x
        self.y = y

# Instanzen erstellen
p_no_slots = PointWithoutSlots(1, 2)
p_with_slots = PointWithSlots(1, 2)

# Dynamisches Attribut hinzufügen (geht bei PointWithoutSlots)
p_no_slots.z = 3
print(f"PointWithoutSlots: x={p_no_slots.x}, y={p_no_slots.y}, z={p_no_slots.z}")

# Dynamisches Attribut hinzufügen (führt bei PointWithSlots zu Fehler)
try:
    p_with_slots.z = 3
except AttributeError as e:
    print(f"Fehler bei PointWithSlots.z = 3: {e}")

# Speicherverbrauch vergleichen (nur eine grobe Schätzung, kann variieren)
import sys
print(f"Größe von PointWithoutSlots Instanz: {sys.getsizeof(p_no_slots)} Bytes")
print(f"Größe von PointWithSlots Instanz: {sys.getsizeof(p_with_slots)} Bytes")
# PointWithSlots ist in der Regel kleiner, da kein __dict__ für jede Instanz benötigt wird.
```

### 11.3 Operatoren überladen

Sie können das Verhalten von Python-Operatoren (`+`, `-`, `==`, etc.) für Ihre eigenen Klassen anpassen, indem Sie die entsprechenden Magic Methods implementieren.

#### Beispiel: `Laenge` Klasse mit `__add__` und `__sub__`

```python
class Laenge:
    umrechnung = {
        "m": 1, "dm": 0.1, "cm": 0.01,
        "mm": 0.001, "km" : 1000,
        "ft": 0.3048,   # Fuß
        "in": 0.0254,   # Zoll
        "mi": 1609.344  # Meilen
    }

    def __init__(self, zahlenwert, einheit):
        if einheit not in Laenge.umrechnung:
            raise ValueError(f"Unbekannte Einheit: {einheit}")
        self.zahlenwert = zahlenwert
        self.einheit = einheit

    def __str__(self):
        return f"{self.zahlenwert:.6f} {self.einheit}"

    def in_meter(self):
        return self.zahlenwert * Laenge.umrechnung[self.einheit]

    def __add__(self, other):
        if not isinstance(other, Laenge):
            return NotImplemented # Informiert Python, dass diese Operation für den Typ 'other' nicht geht
        
        # Beide Längen in Meter umwandeln, addieren
        summe_meter = self.in_meter() + other.in_meter()
        
        # Ergebnis in die Einheit des linken Operanden (self) zurückumwandeln
        ergebnis_zahlenwert = summe_meter / Laenge.umrechnung[self.einheit]
        return Laenge(ergebnis_zahlenwert, self.einheit)

    def __sub__(self, other):
        if not isinstance(other, Laenge):
            return NotImplemented

        diff_meter = self.in_meter() - other.in_meter()
        ergebnis_zahlenwert = diff_meter / Laenge.umrechnung[self.einheit]
        return Laenge(ergebnis_zahlenwert, self.einheit)

    def __eq__(self, other): # Vergleichsoperator ==
        if not isinstance(other, Laenge):
            return NotImplemented
        return abs(self.in_meter() - other.in_meter()) < 1e-9 # Vergleich mit Toleranz

# Anwendungen der Klasse Laenge
l1 = Laenge(5, "cm")
l2 = Laenge(3, "dm") # 0.3 Meter
l3 = Laenge(0.35, "m") # 0.35 Meter

print(f"{l1} + {l2} = {l1 + l2}") # Ergebnis in cm
print(f"{l2} + {l1} = {l2 + l1}") # Ergebnis in dm

print(f"{l3} - {l1} = {l3 - l1}")

print(f"Ist {l1 + l2} gleich {l3}? {l1 + l2 == l3}") # Ruft __eq__ auf
print(f"Ist {l1} gleich {l2}? {l1 == l2}")
```

#### Wichtige Magic Methods für Operatoren

*   **Vergleichsoperatoren**: `__lt__` (`<`), `__le__` (`<=`), `__eq__` (`==`), `__ne__` (`!=`), `__gt__` (`>`), `__ge__` (`>=`).
*   **Binäre arithmetische Operatoren**: `__add__` (`+`), `__sub__` (`-`), `__mul__` (`*`), `__truediv__` (`/`), `__floordiv__` (`//`), `__mod__` (`%`), `__pow__` (`**`), etc.
*   **Binäre Operatoren mit umgekehrter Operandenreihenfolge**: `__radd__`, `__rsub__`, etc. Werden aufgerufen, wenn der *linke* Operand die Operation nicht unterstützt.
*   **Erweiterte Zuweisungen**: `__iadd__` (`+=`), `__isub__` (`-=`), `__imul__` (`*=`), etc. Ermöglichen In-place-Operationen.
*   **Unäre Operatoren**: `__pos__` (`+obj`), `__neg__` (`-obj`), `__abs__` (`abs()`), `__invert__` (`~`).

### 11.4 Datentypen emulieren – Duck-Typing

**Duck-Typing** besagt: "Wenn ich einen Vogel sehe, der wie eine Ente läuft, schwimmt und quakt, so nenne ich diesen Vogel eine Ente." In Python bedeutet das, dass der "Typ" eines Objekts durch die Methoden bestimmt wird, die es implementiert, und nicht durch seine explizite Klassenzugehörigkeit.

*   **Numerische Datentypen emulieren**: Durch Implementierung der arithmetischen Operatoren und Methoden wie `__int__`, `__float__`, `__complex__`.
*   **Kontext-Manager implementieren**: Für die Nutzung mit der `with`-Anweisung (`with obj as var:`). Benötigt `__enter__` und `__exit__`.
*   **Container emulieren**: Durch Methoden wie `__len__`, `__getitem__`, `__setitem__`, `__delitem__`, `__iter__`, `__contains__`.

---

## 12. Datenklassen (`dataclasses`)

**Datenklassen** (eingeführt in Python 3.7) sind ein praktisches Werkzeug, um Klassen zu erstellen, die hauptsächlich Daten speichern. Sie reduzieren den Boilerplate-Code, den man normalerweise für Methoden wie `__init__`, `__repr__`, `__eq__` usw. schreiben müsste.

### 12.1 Veränderliche Datenklassen

```python
import dataclasses

@dataclasses.dataclass
class Adresse:
    straße: str
    hausnummer: int
    plz: int
    stadt: str

# Instanz erzeugen
adresse1 = Adresse("Domkloster", 4, 50667, "Köln")
print(adresse1)

# Attribute zugreifen
print(f"Straße: {adresse1.straße}, Stadt: {adresse1.stadt}")

# Vergleich
adresse2 = Adresse("Domkloster", 4, 50667, "Köln")
print(f"adresse1 == adresse2: {adresse1 == adresse2}")

adresse3 = Adresse("Hauptstraße", 1, 10115, "Berlin")
print(f"adresse1 == adresse3: {adresse1 == adresse3}")

# Veränderbar
adresse1.hausnummer = 5
print(f"Geänderte Adresse: {adresse1}")
```

### 12.2 Unveränderliche Datenklassen (`frozen=True`)

Mit `frozen=True` werden Datenklassen unveränderlich und sind somit auch hashable (können als Dictionary-Schlüssel oder Set-Elemente verwendet werden).

```python
@dataclasses.dataclass(frozen=True)
class FrozenAdresse:
    straße: str
    hausnummer: int
    plz: int
    stadt: str

frozen_adresse = FrozenAdresse("Kaiserplatz", 10, 53113, "Bonn")
print(frozen_adresse)

try:
    frozen_adresse.hausnummer = 11 # Versuch, Attribut zu ändern
except dataclasses.FrozenInstanceError as e:
    print(f"Fehler beim Versuch, eine FrozenAdresse zu ändern: {e}")

# FrozenAdressen können als Dictionary-Schlüssel verwendet werden
adress_cache = {frozen_adresse: "Informationen zu dieser Adresse"}
print(adress_cache[frozen_adresse])
```

### 12.3 Defaultwerte und `__post_init__`

Datenklassen können Defaultwerte für Attribute haben. Die Methode `__post_init__` wird nach dem automatischen Konstruktor aufgerufen und ist ideal für Validierungen oder die automatische Ergänzung von Werten.

```python
@dataclasses.dataclass
class AdresseMitDefault:
    straße: str
    hausnummer: int
    plz: int
    stadt: str = "" # Defaultwert

    def __post_init__(self):
        # Wenn keine Stadt angegeben ist und die PLZ 50667 ist, setze Stadt auf "Köln"
        if not self.stadt and self.plz == 50667:
            self.stadt = "Köln"
        # Beispiel für Validierung
        if self.hausnummer <= 0:
            raise ValueError("Hausnummer muss positiv sein.")

# Instanz mit Defaultwert
adresse_koeln_auto = AdresseMitDefault("Domkloster", 4, 50667)
print(adresse_koeln_auto)

# Instanz mit expliziter Stadt
adresse_koeln_exp = AdresseMitDefault("Domkloster", 4, 50667, "Koeln")
print(adresse_koeln_exp)

# Instanz mit ungültiger Hausnummer (wird Fehler werfen)
try:
    AdresseMitDefault("Testweg", 0, 12345, "Teststadt")
except ValueError as e:
    print(f"Fehler bei ungültiger Hausnummer: {e}")
```

---

Ich hoffe, diese formatierte Version ist hervorragend für Ihr Jupyter Notebook geeignet! Lassen Sie mich wissen, wenn Sie weitere Anpassungen oder Erklärungen wünschen.
