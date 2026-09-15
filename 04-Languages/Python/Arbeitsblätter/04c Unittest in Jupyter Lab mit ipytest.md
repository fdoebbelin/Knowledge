```python
# Installation (nur beim ersten Mal nötig)
!pip install ipytest
```

Mit diesem Befehl wird ipytest installiert, sodass pytest-Tests direkt im Notebook ausgeführt werden können.

```python
import ipytest
import pytest

ipytest.autoconfig()
```

ipytest und pytest werden importiert und konfiguriert.
Mit autoconfig() erkennt ipytest automatisch die aktuelle Notebook-Umgebung und richtet alles für pytest ein.

```python
def quadriere(x):
    return x * x
```

Hier wird die zentrale Funktion quadriere definiert, die getestet werden soll.

```python
def test_quadriere():
    assert quadriere(3) == 9
    assert quadriere(0) == 0
    assert quadriere(-2) == 4
```

Testfunktion für quadriere: Verschiedene Werte werden geprüft.
Jede Assertion überprüft, ob das Ergebnis wie erwartet ausfällt.

```python
ipytest.run()
```

Mit ipytest.run() werden alle im Notebook definierten Tests ausgeführt.
Das Ergebnis wird als strukturierter pytest-Testreport angezeigt.

```python
@pytest.mark.parametrize(
    "eingabe, erwartet",
    [
        (3, 9),
        (0, 0),
        (-2, 4),
        (5, 25),
        (-7, 49),
    ]
)
def test_quadriere(eingabe, erwartet):
    assert quadriere(eingabe) == erwartet
```

Mit pytest.mark.parametrize können mehrere Wertepaare getestet werden.
Jeder Satz (eingabe, erwartet) wird einzeln geprüft; bei Fehler wird genau angezeigt, welches Paar betroffen ist.

```python
ipytest.run()
```

Alle parametrisierten Tests werden erneut ausgeführt und die Ergebnisse direkt angezeigt.
