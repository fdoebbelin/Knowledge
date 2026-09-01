## Installationsschritte mit uv Tools auch für andere Projekte verfügbar machen

uv ist ein schneller, projektweiter Paketmanager für Python, ideal zur gemeinsamen Installation aller Codeanalyse-Tools:

```bash
uv tool install ruff
uv tool install pylint
uv tool install flake8
uv tool install mypy
uv tool install black
uv tool install isort
uv tool install bandit
uv tool install docstr-coverage
uv tool install radon
```

***

## 1. Docstrings \& Doctest

```python
def quadrat(x: int) -> int:
    """
    Gibt das Quadrat einer Zahl zurück.

    Args:
        x: Eine ganze Zahl.

    Returns:
        Quadrat von x.

    Examples:
        >>> quadrat(4)
        16
        >>> quadrat(-3)
        9
    """
    return x * x

if __name__ == "__main__":
    import doctest
    doctest.testmod(verbose=True)
```

*Mit `doctest modulfname.py` werden die Beispiele automatisch getestet.*

***

## 2. Pylint – Codequalität prüfen

```bash
pylint arbeitsblatt.py
```

Ergebnis:

```
arbeitsblatt.py:1:0: C0114: Missing module docstring (missing-module-docstring)
arbeitsblatt.py:1:0: C0103: Variable name "x" doesn't conform to snake_case naming style (invalid-name)
```


***

## 3. Flake8 – Stil und kleine Fehler

```bash
flake8 arbeitsblatt.py
```

Typisches Flake8-Ergebnis:

```
arbeitsblatt.py:5:1: E302 expected 2 blank lines, found 1
arbeitsblatt.py:9:80: E501 line too long (88 > 79 characters)
```


***

## 4. MyPy – Typüberprüfung

```python
def addiere(a: int, b: int) -> int:
    return a + b
```

```bash
mypy arbeitsblatt.py
```

Ergebnis:

```
Success: no issues found in 1 source file
```


***

## 5. Black – Automatische Formatierung

```bash
black arbeitsblatt.py
```

*Black formatiert den Code nach modernen PEP-8-Regeln und zeigt Änderungen an.*

***

## 6. isort – Ordnung in den Imports

```python
import sys
import os
```

```bash
isort arbeitsblatt.py
```

*isort sortiert alle Imports direkt um.*

***

## 7. Bandit – Sicherheitsanalyse

```python
import subprocess

def systembefehl(cmd):
    return subprocess.call(cmd, shell=True)  # potenziell riskant!
```

```bash
bandit arbeitsblatt.py
```

Typisches Bandit-Beispiel:

```
issue: subprocess call with shell=True detected, security risk
```


***

## 8. Ruff – Moderner Python-Linter

```bash
ruff check arbeitsblatt.py
```

Beispielbefund:

```
arbeitsblatt.py:1:1: E402 Module level import not at top of file
arbeitsblatt.py:3:23: F401 `subprocess` imported but unused
```

**Ruff** bietet blitzschnelle Analyse und kann die allermeisten Flake8-, isort- und pylint-Regeln bereits abdecken.

***

## 9. Docstring-Coverage – Dokumentationsgrad prüfen

```bash
docstr-coverage arbeitsblatt.py
```

*Zeigt, wie viele Funktionen/Klassen mit Docstrings versehen sind.*

***

## 10. Radon – Komplexitätsanalyse

```python
def langes_beispiel(x):
    if x > 0:
        for i in range(x):
            print(i)
    else:
        print("negativ")
```

```bash
radon cc arbeitsblatt.py -a
```

Ergebnisbeispiel:

```
arbeitsblatt.py
    F langes_beispiel: A (3)
    Average complexity: A (3.0)
```


***

## Fazit \& Tipp

Am besten kombinierst du alle Tools direkt in CI/CD-Workflows oder Pre-Commit-Hooks, damit Code inkl. Docstrings, Stil und Qualität immer automatisch geprüft werden. Die Installation mit `uv` hält alle Tools und Libraries projektweit sauber synchronisiert.