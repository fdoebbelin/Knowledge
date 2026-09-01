Im Modul 34 des Python-Kurses steht die Anwendung fortgeschrittener Techniken des Unit Testings im Fokus. 
Aufbauend auf den Grundlagen von Tests und pytest werden alle wichtigen Werkzeuge beleuchtet, um robuste Teststrategien für reale Python-Projekte zu entwickeln. 
Die Themen reichen von erweiterten Assertions über Fixtures, Mocking und Patching bis zur Parametrisierung und zum Testen komplexer Klassenhierarchien.

## Assertions: Mehr als nur Vergleiche

Assertions sind das Herzstück jeder Testfunktion. Mit pytest lässt sich nicht nur auf Gleichheit prüfen, sondern auch auf Ausnahmen, komplexe Datenstrukturen und präzise numerische Werte.

```python
import pytest

def addiere(a, b):
    return a + b

def test_addiere():
    assert addiere(2, 2) == 4
    assert addiere(-1, 1) == 0
    assert addiere(0.1, 0.2) == pytest.approx(0.3)

def test_exception():
    with pytest.raises(ZeroDivisionError):
        1 / 0
```

Hier werden Standard-Assertions mit Werte-Prüfung, Approximation und Exception-Matching demonstriert.

## Fixtures: Testdaten und Setup/Teardown

Fixtures bieten elegantes Setup für Datenbanken, Dateien oder komplexe Objekte und stellen sicher, dass Tests reproduzierbar und unabhängig bleiben.

```python
import pytest

@pytest.fixture
def beispiel_liste():
    return [1, 2, 3, 4]

def test_liste(beispiel_liste):
    assert len(beispiel_liste) == 4
    beispiel_liste.append(5)
    assert beispiel_liste[-1] == 5
```

Mit `scope` lassen sich Fixtures für einzelne Funktionen, das gesamte Modul oder die Testsitzung erstellen.

## Mocking und Patching

Um externe API-Aufrufe, Netzwerkzugriffe oder Dateisystem-Eingriffe zu simulieren, ist Mocking unerlässlich. Das Modul `unittest.mock` und die Patch-Methoden von pytest helfen, Seiteneffekte zu vermeiden.

```python
from unittest.mock import patch

def fetch_data():
    import requests
    response = requests.get("https://example.com")
    return response.text

@patch("requests.get")
def test_fetch_data(mock_get):
    mock_get.return_value.text = "Erfolg!"
    result = fetch_data()
    assert result == "Erfolg!"
```

Hier wird ein echter Netzwerkanruf vollständig durch ein Mock-Objekt ersetzt.

## Parametrisierte Tests

Mit `@pytest.mark.parametrize` können Tests systematisch mit unterschiedlichen Werten ausgeführt werden – ohne Redundanz.

```python
import pytest

@pytest.mark.parametrize("zahl1,zahl2,erwartet", [
    (2, 3, 5),
    (0, 0, 0),
    (-1, 1, 0),
])
def test_addiere_param(zahl1, zahl2, erwartet):
    assert addiere(zahl1, zahl2) == erwartet
```

So wird Testabdeckung maximiert und Fehlerquellen werden effizient erkannt.

## Testen von Klassenhierarchien

Testen von OOP-Strukturen verlangt eigene Strategien: Die Methoden und das Verhalten von Basisklasse, abgeleiteter Klasse und Polymorphismus werden gezielt geprüft.

```python
class Fahrzeug:
    def start(self):
        return "gestartet"

class Auto(Fahrzeug):
    def hupen(self):
        return "huup"

def test_klassenhierarchie():
    f = Fahrzeug()
    a = Auto()
    assert f.start() == "gestartet"
    assert a.start() == "gestartet"
    assert a.hupen() == "huup"
```

Durch getrennte Testfälle und spezialisierte Fixtures bleibt das Testset übersichtlich – auch bei tiefen Vererbungshierarchien.
