Sehr gut 👍  
Dann erweitere ich die Codezellen mit **sinnvollen Kommentaren**, damit du die Funktionsweise direkt beim Ausführen im Jupyter Notebook nachvollziehen kannst.  
Die Texte (Erklärungen) bleiben für dich als **Markdown-Zellen** gedacht – die Codezellen sind jetzt vollständig kommentiert.

---

# Kapitel 19 – Objektorientierte Programmierung in Python

## Beispiel: Kontoverwaltung

---

## 1. Nicht objektorientierte Lösung (Dictionary + Funktionen)

```python
# Konto wird hier nur als Dictionary gespeichert.
# Jede Operation ist eine Funktion, die das Dictionary manipuliert.

def neues_konto(inhaber, kontonummer, kontostand, max_tagesumsatz=1500):
    """Erzeugt ein neues Konto als Dictionary"""
    return {
        "inhaber": inhaber,
        "kontonummer": kontonummer,
        "kontostand": kontostand,
        "max_tagesumsatz": max_tagesumsatz,
        "umsatz_heute": 0
    }

def geldtransfer(quelle, ziel, betrag):
    """Überträgt Geld zwischen zwei Dictionary-Konten"""
    # Prüfen, ob der Betrag erlaubt ist
    if (betrag < 0 or
        quelle["umsatz_heute"] + betrag > quelle["max_tagesumsatz"] or
        ziel["umsatz_heute"] + betrag > ziel["max_tagesumsatz"]):
        return False
    else:
        # Geld umbuchen
        quelle["kontostand"] -= betrag
        quelle["umsatz_heute"] += betrag
        ziel["kontostand"] += betrag
        ziel["umsatz_heute"] += betrag
        return True

def einzahlen(konto, betrag):
    """Zahlt Geld auf ein Konto ein"""
    if betrag < 0 or konto["umsatz_heute"] + betrag > konto["max_tagesumsatz"]:
        return False
    else:
        konto["kontostand"] += betrag
        konto["umsatz_heute"] += betrag
        return True

def auszahlen(konto, betrag):
    """Hebt Geld vom Konto ab"""
    if betrag < 0 or konto["umsatz_heute"] + betrag > konto["max_tagesumsatz"]:
        return False
    else:
        konto["kontostand"] -= betrag
        konto["umsatz_heute"] += betrag
        return True

def zeige_konto(konto):
    """Zeigt den aktuellen Stand eines Dictionary-Kontos an"""
    print(f"Konto von {konto['inhaber']}")
    print(f"Aktueller Kontostand: {konto['kontostand']:.2f} Euro")
    print(f"(Heute schon {konto['umsatz_heute']:.2f} von {konto['max_tagesumsatz']} Euro umgesetzt)")
```

### Beispielaufruf (prozedural)

```python
k1 = neues_konto("Heinz Meier", 123, 1000)
k2 = neues_konto("Erwin Schmidt", 456, 500)

# Heinz überweist 200 Euro an Erwin
geldtransfer(k1, k2, 200)

zeige_konto(k1)
zeige_konto(k2)
```

---

## 2. Objektorientierte Lösung mit einer `Konto`-Klasse

```python
# Konto wird jetzt als Klasse modelliert.
# Attribute (Daten) und Methoden (Funktionen) sind zusammengefasst.

class Konto:
    """Ein Konto-Objekt mit Methoden für Ein-/Auszahlungen und Transfers"""
    
    def __init__(self, inhaber, kontonummer, kontostand, max_tagesumsatz=1500):
        # Initialisierung (Konstruktor)
        self.inhaber = inhaber
        self.kontonummer = kontonummer
        self.kontostand = kontostand
        self.max_tagesumsatz = max_tagesumsatz
        self.umsatz_heute = 0

    def geldtransfer(self, ziel, betrag):
        """Überträgt Geld zu einem anderen Konto"""
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
        """Zahlt Geld auf das Konto ein"""
        if betrag < 0 or self.umsatz_heute + betrag > self.max_tagesumsatz:
            return False
        else:
            self.kontostand += betrag
            self.umsatz_heute += betrag
            return True

    def auszahlen(self, betrag):
        """Hebt Geld vom Konto ab"""
        if betrag < 0 or self.umsatz_heute + betrag > self.max_tagesumsatz:
            return False
        else:
            self.kontostand -= betrag
            self.umsatz_heute += betrag
            return True

    def zeige(self):
        """Zeigt die Kontodaten auf der Konsole an"""
        print(f"Konto von {self.inhaber}")
        print(f"Aktueller Kontostand: {self.kontostand:.2f} Euro")
        print(f"(Heute schon {self.umsatz_heute:.2f} von {self.max_tagesumsatz} Euro umgesetzt)")
```

### Beispielaufruf (objektorientiert)

```python
k1 = Konto("Heinz Meier", 123, 1000)
k2 = Konto("Erwin Schmidt", 456, 500)

# Überweisung direkt über Methoden
k1.geldtransfer(k2, 200)

k1.zeige()
k2.zeige()
```

---

## 3. Vererbung: Girokonto und Sparkonto

```python
# Neue Kontoarten durch Vererbung:
# - Girokonto mit Überziehungslimit
# - Sparkonto mit Zinsen

class Girokonto(Konto):
    """Ein Girokonto mit Überziehungslimit"""
    def __init__(self, inhaber, kontonummer, kontostand, limit=1000):
        super().__init__(inhaber, kontonummer, kontostand)
        self.limit = limit

    def auszahlen(self, betrag):
        """Hebt Geld ab, berücksichtigt das Überziehungslimit"""
        if betrag <= self.kontostand + self.limit:
            self.kontostand -= betrag
            self.umsatz_heute += betrag
            return True
        else:
            print("Limit überschritten!")
            return False

class Sparkonto(Konto):
    """Ein Sparkonto mit Zinssatz"""
    def __init__(self, inhaber, kontonummer, kontostand, zinssatz=0.02):
        super().__init__(inhaber, kontonummer, kontostand)
        self.zinssatz = zinssatz

    def verzinsen(self):
        """Verzinst den Kontostand"""
        self.kontostand += self.kontostand * self.zinssatz
```

### Beispielaufruf mit Girokonto und Sparkonto

```python
# Girokonto: erlaubt Überziehung
gk = Girokonto("Anna Müller", 789, 100, limit=500)
gk.auszahlen(400)  # erlaubt, da 100 Guthaben + 500 Limit = 600 verfügbar
gk.zeige()

# Sparkonto: Guthaben wird verzinst
sk = Sparkonto("Peter Schulz", 999, 2000, zinssatz=0.05)
sk.verzinsen()
sk.zeige()
```

---

## 4. Properties: Sicherer Zugriff auf Attribute

```python
# Mit Properties können wir Zugriffe kontrollieren,
# z. B. dass der Kontostand nie negativ wird.

class KontoMitProperty:
    """Ein Konto, das Properties für sichere Zugriffe nutzt"""
    def __init__(self, inhaber, stand=0):
        self._inhaber = inhaber
        self._stand = stand  # intern: Attribut mit _ (geschützt)

    @property
    def stand(self):
        """Getter: gibt den Stand zurück"""
        return self._stand

    @stand.setter
    def stand(self, wert):
        """Setter: verhindert negative Stände"""
        if wert < 0:
            print("Kontostand darf nicht negativ sein!")
        else:
            self._stand = wert
```

### Beispielaufruf mit Property

```python
kp = KontoMitProperty("Testkunde", 300)
print("Stand vor Änderung:", kp.stand)

# Versuch ins Minus zu gehen -> wird blockiert
kp.stand = -50   

print("Stand nach Änderung:", kp.stand)
```

---

✅ Damit ist jede Zelle **kommentiert** und du kannst die Beispiele **direkt in JupyterLab** ausprobieren.

Soll ich dir das jetzt als fertiges `.ipynb`-Notebook generieren, damit du es sofort in JupyterLab öffnen kannst?
