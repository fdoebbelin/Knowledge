## Exception-Hierarchie in Python-Klassen

In Python gibt es eine eingebaute Hierarchie von Exceptions. Eigene Fehlerklassen basieren meist auf der `Exception`-Basisklasse.

```python
# Eigene Exception ableiten
class CustomError(Exception):
    pass

try:
    raise CustomError("Ein benutzerdefinierter Fehler")
except CustomError as e:
    print("Fehler abgefangen:", e)
```

*In der Praxis erlaubt dies, spezifische Fehler abzufangen und gezielt darauf zu reagieren.*[^1]

### Exception-Hierarchie visualisieren

Eigene Fehler können weiter unterteilt werden:

```python
class ValidationError(CustomError):
    pass

class DatabaseError(CustomError):
    pass

try:
    raise DatabaseError("Datenbank ist nicht erreichbar!")
except ValidationError:
    print("Validierungsfehler behandelt")
except DatabaseError as e:
    print("Datenbankfehler behandelt:", e)
except CustomError:
    print("Allgemeiner CustomError behandelt")
```

*So bleibt der Code modular und erweiterbar – jeder Fehler ist klar differenzierbar und logisch kategorisiert.*[^1]

## Verwendung von `else` und `finally` in try-except

Mit `else` und `finally` kann die Fehlerbehandlung präzisiert werden:

```python
def divide(a, b):
    try:
        result = a / b
    except ZeroDivisionError:
        print("Division durch Null!")
    else:
        print("Ergebnis:", result)
    finally:
        print("Funktion abgeschlossen.")

divide(10, 2)
divide(10, 0)
```

- `else` wird nur ausgeführt, wenn kein Fehler auftritt.
- `finally` läuft immer, egal ob ein Fehler geworfen wurde oder nicht.

*Dies hilft, Codeblöcke für Nacharbeiten und Aufräumprozesse sauber zu organisieren.*[^1]

## Eigene Exceptions für robuste Klassen

Eigene Exceptions sorgen dafür, dass Klassen selbstständig prüfen und bei Fehlern informative Hinweise liefern.

```python
class NegativeValueError(Exception):
    pass

class Account:
    def __init__(self, balance):
        self.balance = balance

    def withdraw(self, amount):
        if amount < 0:
            raise NegativeValueError("Nur positive Beträge erlaubt!")
        if amount > self.balance:
            raise CustomError("Nicht genug Guthaben!")
        self.balance -= amount

# Ablauf demonstrieren
konto = Account(100)
try:
    konto.withdraw(-20)
except NegativeValueError as e:
    print("Fehler:", e)
```

*Eigene Fehlerklassen machen Fehlerquellen nachvollziehbar und erleichtern die Fehlersuche sowie das Testen von Methoden.

## Robuste Klassenstruktur durch Exception-Handling

Exception-Handling ist zentral, um Klassen robust und fehlertolerant zu gestalten:

```python
class Temperature:
    def __init__(self, celsius):
        if not isinstance(celsius, (int, float)):
            raise TypeError("Der Wert muss numerisch sein!")
        self._celsius = celsius

    def to_fahrenheit(self):
        return 9/5 * self._celsius + 32

# Praxis-Test
try:
    t = Temperature("zehn")
except TypeError as e:
    print("Fehlertyp:", e)

try:
    t = Temperature(25)
    print("Fahrenheit:", t.to_fahrenheit())
except Exception as e:
    print("Allgemeiner Fehler:", e)
```

*Robuste Klassen validieren Eingaben und erzeugen konkrete, gut dokumentierte Fehler – das erhöht die Sicherheit und Wartbarkeit.

## Bedeutung und Praxisbezug

- Exception-Hierarchien ermöglichen präzises Fehler-Handling bei komplexeren Projekten.
- Eigene Exceptions machen den Code lesbarer und verständlicher, speziell bei domänenspezifischen Fehlern.
- Die richtige Nutzung von `else`/`finally` sorgt für klare Abläufe und strukturierte Bereinigungsaktionen.
- Robuste Klassen strukturieren Fehlerfälle und helfen, Programme zuverlässig zu entwickeln.

Diese Techniken sind essenziell, um die Qualität, Wartbarkeit und Transparenz von objektorientiertem Python-Code zu erhöhen – insbesondere in der praktischen Softwareentwicklung und bei größeren Anwendungen.
