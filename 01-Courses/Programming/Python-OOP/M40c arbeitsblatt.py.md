
```python
#!/usr/bin/env python3
"""
Arbeitsblatt für Modul 40 - Docstrings und statische Codeanalyse.

Dieses Modul demonstriert verschiedene Tools zur Code-Qualitätssicherung
und zeigt typische Probleme, die von Linting-Tools erkannt werden.

Author: Python-Kurs
Date: September 2025
"""

import os
import sys
import subprocess
from typing import List, Dict, Optional, Union


def quadrat(x: int) -> int:
    """
    Gibt das Quadrat einer Zahl zurück.

    Args:
        x: Eine ganze Zahl.

    Returns:
        Das Quadrat von x.

    Examples:
        >>> quadrat(4)
        16
        >>> quadrat(-3)
        9
        >>> quadrat(0)
        0
    """
    return x * x


def addiere(a: int, b: int) -> int:
    """
    Addiert zwei ganze Zahlen.

    Args:
        a: Erste Zahl
        b: Zweite Zahl

    Returns:
        Summe von a und b

    Examples:
        >>> addiere(3, 5)
        8
        >>> addiere(-1, 1)
        0
    """
    return a + b


def systembefehl(cmd: str) -> int:
    """
    Führt einen Systembefehl aus.

    WARNUNG: Diese Funktion ist potenziell unsicher und wird von
    Bandit als Sicherheitsrisiko erkannt!

    Args:
        cmd: Der auszuführende Systembefehl

    Returns:
        Return-Code des Befehls
    """
    # Dies wird von bandit als Sicherheitsrisiko erkannt
    return subprocess.call(cmd, shell=True)


def langes_beispiel(x: int) -> None:
    """
    Demonstriert eine Funktion mit höherer zyklomatischer Komplexität.

    Diese Funktion wird von radon als komplex eingestuft aufgrund
    der verschachtelten Bedingungen und Schleifen.

    Args:
        x: Eine ganze Zahl zur Verarbeitung
    """
    if x > 0:
        if x < 10:
            for i in range(x):
                if i % 2 == 0:
                    print(f"Gerade Zahl: {i}")
                else:
                    print(f"Ungerade Zahl: {i}")
        elif x < 100:
            print(f"Große Zahl: {x}")
        else:
            print("Sehr große Zahl!")
    elif x == 0:
        print("Null erkannt")
    else:
        print("Negative Zahl")


class BeispielKlasse:
    """
    Eine Beispielklasse zur Demonstration verschiedener Analysewerkzeuge.

    Diese Klasse zeigt typische Muster und Probleme, die von
    statischen Analysewerkzeugen erkannt werden.

    Attributes:
        wert: Ein numerischer Wert
        name: Ein optionaler Name
    """

    def __init__(self, wert: int, name: Optional[str] = None):
        """
        Initialisiert eine neue Instanz der BeispielKlasse.

        Args:
            wert: Der initiale Wert
            name: Optionaler Name für die Instanz
        """
        self.wert = wert
        self.name = name

    def berechne_etwas(self, faktor: float) -> float:
        """
        Führt eine Berechnung mit dem gespeicherten Wert durch.

        Args:
            faktor: Multiplikationsfaktor

        Returns:
            Das Ergebnis der Berechnung

        Examples:
            >>> obj = BeispielKlasse(10)
            >>> obj.berechne_etwas(2.5)
            25.0
        """
        return self.wert * faktor

    def ohne_docstring(self, parameter):
        # Diese Methode hat absichtlich keinen Docstring
        # um docstring-coverage zu demonstrieren
        return parameter * 2


def problematische_funktion():
    """Funktion mit verschiedenen Stil-Problemen für Linter-Demos."""
    # Absichtliche Stil-Probleme für Linter-Demonstration:
    
    # Ungenutzte Variable (wird von pylint/ruff erkannt)
    ungenutzte_variable = "wird nicht verwendet"
    
    # Zu lange Zeile (wird von flake8/ruff erkannt, wenn > 79/88 Zeichen)
    sehr_lange_variable_mit_unnoetig_langem_namen_der_die_zeilenlange_ueberschreitet = "problematisch"
    
    # Fehlende Leerzeilen um Funktionen (PEP 8)
    def interne_funktion():
        pass
    
    # Doppelte Leerzeilen wo nicht nötig
    
    
    result = 42
    return result


def analysiere_wetterdaten(temperaturen: List[float], 
                          niederschlag: List[float]) -> Dict[str, float]:
    """
    Analysiert Wetterdaten und erstellt statistische Auswertungen.

    Args:
        temperaturen: Liste der Tagestemperaturen in Celsius
        niederschlag: Liste der täglichen Niederschlagsmengen in mm

    Returns:
        Dictionary mit statistischen Kennwerten:
        - mittel_temp: Durchschnittstemperatur
        - max_temp: Höchsttemperatur
        - min_temp: Tiefsttemperatur
        - gesamt_niederschlag: Summe des Niederschlags

    Raises:
        ValueError: Wenn Listen unterschiedliche Längen haben

    Examples:
        >>> temps = [20.5, 22.1, 18.9, 25.3]
        >>> rain = [0.0, 2.3, 0.0, 5.1]
        >>> result = analysiere_wetterdaten(temps, rain)
        >>> round(result['mittel_temp'], 1)
        21.7
        >>> result['gesamt_niederschlag']
        7.4
    """
    if len(temperaturen) != len(niederschlag):
        raise ValueError("Listen müssen gleiche Länge haben")

    return {
        'mittel_temp': sum(temperaturen) / len(temperaturen),
        'max_temp': max(temperaturen),
        'min_temp': min(temperaturen),
        'gesamt_niederschlag': sum(niederschlag)
    }


def demo_type_hints(werte: Union[List[int], List[float]]) -> Optional[float]:
    """
    Demonstriert erweiterte Type Hints für MyPy-Analyse.

    Args:
        werte: Liste von Zahlen (int oder float)

    Returns:
        Durchschnittswert oder None bei leerer Liste
    """
    if not werte:
        return None
    return sum(werte) / len(werte)


# Absichtlicher Import-Durcheinander für isort-Demonstration
import json  # Sollte oben bei anderen Imports stehen
from datetime import datetime  # Auch dieser Import ist falsch platziert


if __name__ == "__main__":
    # Doctest-Ausführung
    import doctest
    print("Führe Doctests aus...")
    results = doctest.testmod(verbose=True)
    
    if results.failed == 0:
        print(f"\n✅ Alle {results.attempted} Doctests erfolgreich!")
    else:
        print(f"\n❌ {results.failed} von {results.attempted} Doctests fehlgeschlagen!")
    
    # Beispiel-Aufrufe zur Demonstration
    print(f"\nBeispiel-Aufrufe:")
    print(f"quadrat(5) = {quadrat(5)}")
    print(f"addiere(10, 15) = {addiere(10, 15)}")
    
    # Wetterdaten-Beispiel
    temp_daten = [18.5, 22.1, 25.3, 19.8, 21.7]
    regen_daten = [0.0, 2.3, 0.0, 5.1, 1.2]
    wetter_stats = analysiere_wetterdaten(temp_daten, regen_daten)
    print(f"Wetter-Statistiken: {wetter_stats}")
```

## Was die Datei demonstriert:

### Docstrings \& Doctests:
- Vollständige Google-Style Docstrings mit Examples
- Ausführbare Doctests in mehreren Funktionen
- Eine Methode ohne Docstring (für docstring-coverage Demo)
### Linting-Tool Beispiele:
- **Pylint**: Ungenutzte Variablen, Naming-Konventionen
- **Flake8**: Zu lange Zeilen, falsche Leerzeilen
- **MyPy**: Type Hints und Union-Types
- **Black**: Formatierungsprobleme
- **isort**: Falsch platzierte Imports
- **Bandit**: Sicherheitsrisiko mit `shell=True`
- **Ruff**: Kombiniert viele der obigen Probleme
### Radon (Komplexität):
- `langes_beispiel()` mit hoher zyklomatischer Komplexität
### Docstring-Coverage:
- Mix aus dokumentierten und undokumentierten Methoden
## Verwendung:

```bash
# Alle Tools testen:
python arbeitsblatt.py          # Doctests ausführen
pylint arbeitsblatt.py          # Code-Qualität
flake8 arbeitsblatt.py          # Stil-Probleme  
mypy arbeitsblatt.py            # Type-Checking
ruff arbeitsblatt.py            # Moderner All-in-One Linter
bandit arbeitsblatt.py          # Sicherheit
docstr-coverage arbeitsblatt.py # Dokumentationsgrad
radon cc arbeitsblatt.py        # Komplexität
```