## 1. Installation
```python
# Zelle 1: Installation (nur beim ersten Mal nötig)
!pip install ipytest
```
## 2. Setup für ipytest \& pytest
```python
# Zelle 2: ipytest und pytest importieren, automatisch konfigurieren
import ipytest
import pytest
ipytest.autoconfig()
```
## 3. Gleichheits-Assertions
```python
# Zelle 3: klassisches assert
def quadriere(x):
    return x * x

def test_quadriere_einfach():
    assert quadriere(3) == 9
    assert quadriere(0) == 0
    assert quadriere(-2) == 4

ipytest.run()
```
## 4. Parametrisierte Tests (pytest.mark.parametrize)
```python
# Zelle 4: Parametrisierte Tests für quadriere
@pytest.mark.parametrize("eingabe, erwartet", [
    (3, 9),
    (0, 0),
    (-2, 4),
    (5, 25),
    (-7, 49),
])
def test_quadriere_param(eingabe, erwartet):
    assert quadriere(eingabe) == erwartet

ipytest.run()
```
## 5. Ungleichheit und Boolean
```python
# Zelle 5: Ungleichheit und Boolean Assertions
def test_ungleichheit_und_bool():
    assert 5 != 3
    assert not False
    assert True
    assert [1, 2, 3]
    assert not []
    assert "Test" != "Quiz"

ipytest.run()
```
## 6. Mitgliedschaft (in/not in) und Typen
```python
# Zelle 6: Mitgliedschaft und Typ-Checks
def test_mitgliedschaft_typen():
    assert "a" in "banana"
    assert "z" not in "hallo"
    assert 4 in [2, 3, 4]
    assert isinstance(42, int)
    assert isinstance([1,2], list)
    assert type("abc") == str

ipytest.run()
```
## 7. Näherung (pytest.approx)
```python
# Zelle 7: Näherungen mit pytest.approx
def test_float_approx():
    assert 0.1 + 0.2 == pytest.approx(0.3)
    assert [0.1 + 0.1, 0.2 + 0.1] == pytest.approx([0.2, 0.3])

ipytest.run()
```
## 8. Exception-Tests (pytest.raises)
```python
# Zelle 8: Ausnahmen testen
def division(a, b):
    if b == 0:
        raise ZeroDivisionError("Division durch Null")
    return a / b

def test_division_exception():
    with pytest.raises(ZeroDivisionError, match="Division durch Null"):
        division(5, 0)
    assert division(10, 2) == 5

ipytest.run()
```
## 9. Collection-Assertions
```python
# Zelle 9: Listen, Sets, Dicts prüfen
def test_collections():
    liste = [1, 2, 3, 4, 5]
    assert len(liste) == 5
    assert max(liste) == 5
    set1 = {1, 2, 3}
    set2 = {3, 4, 5}
    assert set1 & set2 == {3}
    daten = {'name': 'Max', 'alter': 30}
    assert 'name' in daten

ipytest.run()
```
## 10. Beispielklasse mit Tests (OOP)
```python
# Zelle 10: Beispielklasse und Tests
class BankKonto:
    def __init__(self, start=0):
        if start < 0:
            raise ValueError("Kein negativer Kontostand")
        self.betrag = start
        self.transaktionen = []
    def einzahlen(self, wert):
        if wert <= 0:
            raise ValueError("Betrag muss positiv sein")
        self.betrag += wert
        self.transaktionen.append(f"Einzahlung: +{wert}")
        return self.betrag
    def auszahlen(self, wert):
        if wert <= 0:
            raise ValueError("Betrag muss positiv sein")
        if wert > self.betrag:
            raise ValueError("Unzureichender Kontostand")
        self.betrag -= wert
        self.transaktionen.append(f"Auszahlung: -{wert}")
        return self.betrag

def test_bankkonto():
    k = BankKonto(100)
    assert k.einzahlen(50) == 150
    assert k.auszahlen(50) == 100
    with pytest.raises(ValueError):
        BankKonto(-20)
    with pytest.raises(ValueError):
        k.auszahlen(200)

ipytest.run()
```
## 11. TDD-Workflow mit ipytest: Fibonacci
```python
# Zelle 11: Test First (RED), dann Implementieren (GREEN), dann Refactoring
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

@pytest.mark.parametrize("n,erwartet", [
    (0, 0), (1, 1), (2, 1), (5, 5), (10, 55)
])
def test_fibonacci(n, erwartet):
    assert fibonacci(n) == erwartet

ipytest.run()
```
## 12. Best Practices Checkliste
```python
# Zelle 12: Kurz-Review der Best Practices als Test
def test_best_practices():
    # AAA-Pattern
    a, b = 3, 5
    result = a + b
    assert result == 8
    # Aussagekräftige Namen, Isolation
    assert isinstance(result, int)
    # Grenzfälle und Fehlerbehandlung
    with pytest.raises(TypeError):
        len(42)

ipytest.run()
```
