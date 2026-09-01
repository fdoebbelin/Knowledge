### .pylintrc – Klassische Konfiguration für pylint

```ini
# .pylintrc – Pylint-Konfiguration

[MASTER]
# Fügt das aktuelle Verzeichnis zum Pythonpath hinzu, hilfreich für lokale Imports.
init-hook='import sys; sys.path.append(".")'

[MESSAGES CONTROL]
# Deaktiviert bestimmte Fehlermeldungen:
# C0103: Ungültige Namenskonvention
# C0111: Fehlende Docstrings
# R0903: Zu viele einfache Klassen
disable=C0103,C0111,R0903

[FORMAT]
# Maximale Zeilenlänge für den Code wird auf 88 Zeichen gesetzt (wie bei Black).
max-line-length=88

[DESIGN]
# Grenzwerte für Komplexität:
# max-args: Maximale Anzahl von Argumenten pro Funktion/Methode
# max-locals: Maximale Anzahl von lokalen Variablen pro Funktion/Methode
max-args=7
max-locals=15
```
### pyproject.toml – Moderne und zentrale Tool-Konfiguration

```toml
# pyproject.toml – Konfigurationstabelle für Python-Projekttools

[tool.pylint]
# Zeilenlänge wie bei Black, beeinflusst Formatierungswarnungen.
max-line-length = 88
# Deaktiviert bestimmte Style-Checks.
disable = ["C0103", "C0111"]

[tool.mypy]
python_version = "3.9"            # Zielversion für Typprüfung
warn_return_any = true            # Warnung bei Rückgabe von Any-Typen
warn_unused_configs = true        # Warnung bei nicht verwendeten Konfigurationen

[tool.black]
line-length = 88                  # Zeilenlänge fürs automatische Formatieren
target-version = ['py39']         # Ziel-Python-Version

[tool.isort]
profile = "black"                 # Importsortierung nach Black-Richtlinien
multi_line_output = 3             # Importdarstellung auf mehrere Zeilen
```
### Beispiel: Gut dokumentierter und geprüfter Python-Code

```python
from typing import List, Dict, Optional
import logging

# Initialisiere den Logger für die Klasse
logger = logging.getLogger(__name__)

class WetterDatenAnalyzer:
    """
    Klasse zur Analyse und Auswertung von Wetterdaten.
    Bietet Methoden für statistische Berechnungen mit Fehlermanagement und Logging.
    """
    def __init__(self, daten_quelle: str) -> None:
        """
        Initialisiert mit Pfad zur CSV-Datenquelle.
        """
        self.daten_quelle = daten_quelle
        self.daten: Optional[Dict[str, List[float]]] = None
        logger.info(f"WetterDatenAnalyzer initialisiert mit {daten_quelle}")

    def lade_daten(self) -> bool:
        """
        Lädt Wetterdaten aus der Quelle. Gibt True bei Erfolg zurück.
        """
        try:
            self.daten = {
                'temperatur': [15.2, 18.7, 22.1, 19.8, 16.5],
                'niederschlag': [0.0, 2.3, 0.0, 5.1, 1.2]
            }
            logger.info("Daten erfolgreich geladen")
            return True
        except Exception as e:
            logger.error(f"Fehler beim Laden der Daten: {e}")
            return False

    def berechne_statistiken(self) -> Dict[str, float]:
        """
        Berechnet statistische Kennwerte der geladenen Daten.
        """
        if self.daten is None:
            raise ValueError("Keine Daten geladen. Rufen Sie zuerst lade_daten() auf.")

        temp_daten = self.daten['temperatur']
        niederschlag_daten = self.daten['niederschlag']

        statistiken = {
            'mittel_temperatur': sum(temp_daten) / len(temp_daten),
            'max_temperatur': max(temp_daten),
            'min_temperatur': min(temp_daten),
            'gesamt_niederschlag': sum(niederschlag_daten)
        }
        logger.info(f"Statistiken berechnet: {statistiken}")
        return statistiken
```
### So wird pylint aufgerufen

```bash
# Analysiere eine einzelne Python-Datei
pylint arbeitsblatt.py

# Analysiere das gesamte Projektverzeichnis
pylint .
```

- pylint sucht automatisch nach einer .pylintrc oder pyproject.toml und liest die Konfiguration aus.
- Die Optionen in .pylintrc (oder [tool.pylint] in pyproject.toml) steuern, welche Checks aktiviert/deaktiviert sind und wie streng Formatierung/Konventionen bewertet werden.
### Zusammengefasste Wirkung der Optionen

| Option | Wirkung |
| :-- | :-- |
| init-hook | Erweitert den Pythonpfad für lokale Imports |
| disable | Schaltet einzelne Fehlermeldungen aus (z.B. Namenskonventionen, fehlende Docstrings) |
| max-line-length | Legt das Limit für die Zeilenlänge fest (empfohlen: 88 für Kompatibilität mit Black) |
| max-args | Begrenzung der Argumentanzahl in Funktionen/Methoden |
| max-locals | Begrenzung der lokalen Variablen in Funktionen |

Jede Option kann – je nach Bedarf – in .pylintrc oder im pyproject.toml gesetzt werden.