## Einführung in die Schnittstellen-Dokumentation

Die professionelle Dokumentation von Code-Schnittstellen ist ein entscheidender Baustein für nachhaltige Softwareentwicklung. Modul 40 behandelt zwei zentrale Aspekte der Code-Qualitätssicherung: **Docstrings** als primäres Dokumentationswerkzeug und **statische Codeanalyse** zur automatischen Qualitätskontrolle. Diese Themen bilden den Übergang zwischen praktischer Entwicklung und professionellem Qualitätsmanagement in Python-Projekten.

## Docstrings: Dokumentation als Code

### Grundlagen und Konventionen

Docstrings sind Python-interne Dokumentationsstrings, die direkt im Code stehen und zur Laufzeit verfügbar sind. Sie folgen etablierten Konventionen und ermöglichen sowohl maschinelle als auch menschliche Lesbarkeit:

```python
def berechne_zinseszins(kapital: float, zinssatz: float, jahre: int) -> float:
    """
    Berechnet den Zinseszins für eine gegebene Investition.
    
    Args:
        kapital (float): Anfangskapital in Euro
        zinssatz (float): Jährlicher Zinssatz als Dezimalzahl (z.B. 0.05 für 5%)
        jahre (int): Anzahl der Jahre
        
    Returns:
        float: Endkapital nach Zinseszinsberechnung
        
    Raises:
        ValueError: Wenn negative Werte übergeben werden
        
    Examples:
        >>> berechne_zinseszins(1000, 0.05, 10)
        1628.8946267744195
        >>> berechne_zinseszins(5000, 0.03, 5)
        5796.371084187581
    """
    if kapital < 0 or zinssatz < 0 or jahre < 0:
        raise ValueError("Alle Werte müssen positiv sein")
    
    return kapital * (1 + zinssatz) ** jahre

class Mitarbeiter:
    """
    Repräsentiert einen Mitarbeiter mit persönlichen und arbeitsrelevanten Daten.
    
    Diese Klasse kapselt alle Informationen und Operationen, die für die
    Verwaltung eines Mitarbeiters erforderlich sind, einschließlich
    Urlaubsverwaltung und Stundenkonto.
    
    Attributes:
        personalnummer (str): Eindeutige Identifikation des Mitarbeiters
        name (str): Nachname des Mitarbeiters
        vorname (str): Vorname des Mitarbeiters
        arbeitsmodell (str): Arbeitszeit-Klassifikation (Vollzeit, Teilzeit, etc.)
        urlaub_total (int): Gesamter Jahresurlaub in Tagen
        urlaub_genommen (int): Bereits genommene Urlaubstage
        stundenkonto (float): Saldo der Mehr-/Minderstunden
    """
    
    def __init__(self, personalnummer: str, name: str, vorname: str, 
                 arbeitsmodell: str = "Vollzeit"):
        """
        Initialisiert einen neuen Mitarbeiter.
        
        Args:
            personalnummer: Eindeutige Mitarbeiter-ID
            name: Nachname des Mitarbeiters
            vorname: Vorname des Mitarbeiters
            arbeitsmodell: Arbeitszeit-Klassifikation
        """
        self.personalnummer = personalnummer
        self.name = name
        self.vorname = vorname
        self.arbeitsmodell = arbeitsmodell
        self.urlaub_total = 30  # Standard-Urlaubsanspruch
        self.urlaub_genommen = 0
        self.stundenkonto = 0.0

    def urlaub_buchen(self, tage: int) -> bool:
        """
        Bucht Urlaubstage für den Mitarbeiter.
        
        Args:
            tage: Anzahl der zu buchenden Urlaubstage
            
        Returns:
            True wenn Buchung erfolgreich, False wenn nicht genug Urlaub verfügbar
            
        Examples:
            >>> mitarbeiter = Mitarbeiter("1001", "Müller", "Anna")
            >>> mitarbeiter.urlaub_buchen(5)
            True
            >>> mitarbeiter.rest_urlaub()
            25
        """
        if self.urlaub_genommen + tage <= self.urlaub_total:
            self.urlaub_genommen += tage
            return True
        return False

    def rest_urlaub(self) -> int:
        """
        Gibt die Anzahl der verbleibenden Urlaubstage zurück.
        
        Returns:
            Anzahl der noch verfügbaren Urlaubstage
        """
        return self.urlaub_total - self.urlaub_genommen
```


### Docstring-Stile und -Standards

Python unterstützt verschiedene Docstring-Konventionen, die je nach Projekt und Team gewählt werden können:

```python
# Google-Style Docstrings
def analysiere_wetterdaten(temperaturen: list, niederschlag: list) -> dict:
    """Analysiert Wetterdaten und erstellt statistische Auswertungen.
    
    Args:
        temperaturen (list): Liste der Tagestemperaturen in Celsius
        niederschlag (list): Liste der täglichen Niederschlagsmengen in mm
        
    Returns:
        dict: Dictionary mit statistischen Kennwerten:
            - mittel_temp: Durchschnittstemperatur
            - max_temp: Höchsttemperatur  
            - min_temp: Tiefsttemperatur
            - gesamt_niederschlag: Summe des Niederschlags
            
    Raises:
        ValueError: Wenn Listen unterschiedliche Längen haben
    """
    if len(temperaturen) != len(niederschlag):
        raise ValueError("Listen müssen gleiche Länge haben")
    
    return {
        'mittel_temp': sum(temperaturen) / len(temperaturen),
        'max_temp': max(temperaturen),
        'min_temp': min(temperaturen),
        'gesamt_niederschlag': sum(niederschlag)
    }

# NumPy/SciPy-Style Docstrings  
def berechne_signalfeatures(iq_daten, abtastrate):
    """
    Extrahiert charakteristische Merkmale aus IQ-Signaldaten.
    
    Parameters
    ----------
    iq_daten : numpy.ndarray
        Komplexwertige IQ-Samples des Signals
    abtastrate : float
        Abtastrate in Hz
        
    Returns
    -------
    features : dict
        Dictionary mit extrahierten Features:
        - mittlere_amplitude : float
            Durchschnittliche Signalamplitude  
        - std_amplitude : float
            Standardabweichung der Amplitude
        - mittlere_phase : float
            Durchschnittliche Phasenlage
        - bandbreite : float
            Geschätzte Signalbandbreite in Hz
            
    Examples
    --------
    >>> import numpy as np
    >>> signal = np.random.complex128(1000) 
    >>> features = berechne_signalfeatures(signal, 48000)
    >>> print(features['mittlere_amplitude'])
    """
    import numpy as np
    
    amplituden = np.abs(iq_daten)
    phasen = np.angle(iq_daten)
    
    return {
        'mittlere_amplitude': np.mean(amplituden),
        'std_amplitude': np.std(amplituden),
        'mittlere_phase': np.mean(phasen),
        'bandbreite': abtastrate / 2  # Vereinfachte Berechnung
    }
```


### Doctest-Integration

Python ermöglicht die Integration von Tests direkt in Docstrings über das `doctest`-Modul:

```python
def konvertiere_temperatur(celsius: float, ziel_einheit: str = "fahrenheit") -> float:
    """
    Konvertiert Celsius in andere Temperatureinheiten.
    
    Args:
        celsius: Temperatur in Grad Celsius
        ziel_einheit: Zieleinheit ("fahrenheit", "kelvin")
        
    Returns:
        Konvertierte Temperatur
        
    Examples:
        >>> konvertiere_temperatur(0)
        32.0
        >>> konvertiere_temperatur(100)
        212.0  
        >>> konvertiere_temperatur(0, "kelvin")
        273.15
        >>> konvertiere_temperatur(-40)  
        -40.0
    """
    if ziel_einheit.lower() == "fahrenheit":
        return celsius * 9/5 + 32
    elif ziel_einheit.lower() == "kelvin":
        return celsius + 273.15
    else:
        raise ValueError(f"Unbekannte Einheit: {ziel_einheit}")

# Doctests ausführen
if __name__ == "__main__":
    import doctest
    doctest.testmod(verbose=True)
```


## Statische Codeanalyse und Linting

### Einführung in Linting-Tools

Statische Codeanalyse überprüft Code ohne Ausführung auf Fehler, Stilprobleme und potentielle Issues:

```python
# Installation der wichtigsten Tools
# pip install pylint flake8 mypy black isort bandit

# pylint - Umfassende Codeanalyse
# pylint mein_modul.py

# flake8 - PEP 8 Compliance und einfache Fehler  
# flake8 mein_modul.py

# mypy - Statische Typprüfung
# mypy mein_modul.py

# black - Code-Formatierung
# black mein_modul.py

# isort - Import-Sortierung
# isort mein_modul.py

# bandit - Sicherheitsanalyse
# bandit -r mein_projekt/
```


### Konfiguration und Integration
#### .pylintrc – Klassische Konfiguration für pylint

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
#### pyproject.toml – Moderne und zentrale Tool-Konfiguration

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
#### Beispiel: Gut dokumentierter und geprüfter Python-Code

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
#### So wird pylint aufgerufen

```bash
# Analysiere eine einzelne Python-Datei
pylint beispiel.py

# Analysiere das gesamte Projektverzeichnis
pylint .
```

- pylint sucht automatisch nach einer .pylintrc oder pyproject.toml und liest die Konfiguration aus.
- Die Optionen in .pylintrc (oder [tool.pylint] in pyproject.toml) steuern, welche Checks aktiviert/deaktiviert sind und wie streng Formatierung/Konventionen bewertet werden.
#### Zusammengefasste Wirkung der Optionen

| Option | Wirkung |
| :-- | :-- |
| init-hook | Erweitert den Pythonpfad für lokale Imports |
| disable | Schaltet einzelne Fehlermeldungen aus (z.B. Namenskonventionen, fehlende Docstrings) |
| max-line-length | Legt das Limit für die Zeilenlänge fest (empfohlen: 88 für Kompatibilität mit Black) |
| max-args | Begrenzung der Argumentanzahl in Funktionen/Methoden |
| max-locals | Begrenzung der lokalen Variablen in Funktionen |
Jede Option kann – je nach Bedarf – in .pylintrc oder im pyproject.toml gesetzt werden.
### Automatisierung in CI/CD-Pipelines

```yaml
# .github/workflows/quality-check.yml
name: Code Quality Check

on: [push, pull_request]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: 3.9
        
    - name: Install dependencies
      run: |
        pip install pylint flake8 mypy black isort bandit
        pip install -r requirements.txt
        
    - name: Run Black
      run: black --check .
      
    - name: Run isort  
      run: isort --check-only .
      
    - name: Run Flake8
      run: flake8 .
      
    - name: Run MyPy
      run: mypy .
      
    - name: Run Pylint
      run: pylint src/
      
    - name: Run Bandit
      run: bandit -r src/
      
    - name: Run Doctests
      run: python -m doctest src/*.py
```


## Integration mit Entwicklungstools

### IDE-Integration und Live-Feedback

```python
# VS Code settings.json für automatische Code-Qualität
"""
{
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "python.linting.flake8Enabled": true,
    "python.linting.mypyEnabled": true,
    "python.formatting.provider": "black",
    "python.sortImports.args": ["--profile", "black"],
    "editor.formatOnSave": true,
    "python.linting.lintOnSave": true
}
"""

# Pre-commit Hooks für automatische Prüfungen
"""
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/psf/black
    rev: 22.3.0
    hooks:
      - id: black
        
  - repo: https://github.com/pycqa/isort
    rev: 5.10.1
    hooks:
      - id: isort
        args: ["--profile", "black"]
        
  - repo: https://github.com/pycqa/flake8
    rev: 4.0.1
    hooks:
      - id: flake8
      
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v0.942
    hooks:
      - id: mypy
"""
```


### Metriken und Qualitätsbewertung

```python
def berechne_code_qualitaet(projekt_pfad: str) -> Dict[str, float]:
    """
    Berechnet verschiedene Code-Qualitätsmetriken für ein Projekt.
    
    Args:
        projekt_pfad: Pfad zum Python-Projekt
        
    Returns:
        Dictionary mit Qualitätsmetriken:
        - pylint_score: Pylint-Bewertung (0-10)
        - test_coverage: Testabdeckung in Prozent  
        - docstring_coverage: Docstring-Abdeckung in Prozent
        - complexity_score: Durchschnittliche zyklomatische Komplexität
    """
    import subprocess
    import json
    
    metriken = {}
    
    # Pylint Score
    try:
        result = subprocess.run(
            ['pylint', projekt_pfad, '--output-format=json'], 
            capture_output=True, text=True
        )
        # Vereinfachte Auswertung - in der Praxis würde man JSON parsen
        metriken['pylint_score'] = 8.5  # Demo-Wert
    except:
        metriken['pylint_score'] = 0.0
    
    # Coverage (würde pytest-cov verwenden)
    metriken['test_coverage'] = 85.2  # Demo-Wert
    
    # Docstring Coverage (würde docstring-coverage verwenden) 
    metriken['docstring_coverage'] = 92.1  # Demo-Wert
    
    # Komplexität (würde radon verwenden)
    metriken['complexity_score'] = 3.2  # Demo-Wert
    
    return metriken

# Beispiel für Qualitätsbericht
def erstelle_qualitaetsbericht(projekt_pfad: str) -> None:
    """
    Erstellt einen umfassenden Qualitätsbericht für ein Projekt.
    
    Args:
        projekt_pfad: Pfad zum zu analysierenden Projekt
    """
    metriken = berechne_code_qualitaet(projekt_pfad)
    
    bericht = f"""
    === Code-Qualitätsbericht ===
    
    Projekt: {projekt_pfad}
    Datum: {import datetime; datetime.datetime.now().strftime('%Y-%m-%d %H:%M')}
    
    Metriken:
    - Pylint Score: {metriken['pylint_score']}/10
    - Testabdeckung: {metriken['test_coverage']:.1f}%
    - Docstring-Abdeckung: {metriken['docstring_coverage']:.1f}%
    - Ø Komplexität: {metriken['complexity_score']:.1f}
    
    Empfehlungen:
    """
    
    if metriken['pylint_score'] < 7.0:
        bericht += "\n  ⚠️  Pylint-Score niedrig - Code-Stil verbessern"
    if metriken['test_coverage'] < 80.0:
        bericht += "\n  ⚠️  Testabdeckung niedrig - mehr Tests schreiben"
    if metriken['docstring_coverage'] < 90.0:
        bericht += "\n  ⚠️  Docstring-Abdeckung niedrig - Dokumentation ergänzen"
    if metriken['complexity_score'] > 5.0:
        bericht += "\n  ⚠️  Hohe Komplexität - Code refactoring erwägen"
    
    print(bericht)
```


## Fortgeschrittene Dokumentationsstrategien

### Automatische API-Dokumentation

```python
# Sphinx-Integration für automatische Dokumentation
"""
# docs/conf.py - Sphinx-Konfiguration
import os
import sys
sys.path.insert(0, os.path.abspath('..'))

extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.viewcode', 
    'sphinx.ext.napoleon',  # Für Google/NumPy-Style Docstrings
    'sphinx.ext.doctest'
]

autodoc_default_options = {
    'members': True,
    'undoc-members': True,
    'show-inheritance': True,
}
"""

class SignalProcessor:
    """
    Erweiterte Signalverarbeitung mit umfassender Dokumentation.
    
    Diese Klasse demonstriert Best Practices für Dokumentation
    in wissenschaftlichen Python-Anwendungen mit automatischer
    API-Generierung.
    
    .. note::
       Diese Klasse erfordert NumPy und SciPy für mathematische Operationen.
       
    .. warning::
       Große Signaldaten können zu hohem Speicherverbrauch führen.
    """
    
    def __init__(self, abtastrate: float = 48000.0) -> None:
        """
        Initialisiert den SignalProcessor.
        
        Parameters
        ---------- 
        abtastrate : float, optional
            Abtastrate in Hz (Standard: 48000.0)
        """
        self.abtastrate = abtastrate
        self._signal_cache = {}
    
    def filter_signal(self, signal: 'numpy.ndarray', 
                     cutoff_freq: float) -> 'numpy.ndarray':
        """
        Wendet Tiefpassfilter auf Signal an.
        
        Parameters
        ----------
        signal : numpy.ndarray
            Eingangssignal
        cutoff_freq : float  
            Grenzfrequenz des Filters in Hz
            
        Returns
        -------
        numpy.ndarray
            Gefiltertes Signal
            
        Examples
        --------
        >>> import numpy as np
        >>> processor = SignalProcessor()
        >>> signal = np.random.randn(1000)
        >>> filtered = processor.filter_signal(signal, 1000)  # doctest: +SKIP
        """
        # Implementierung würde scipy.signal verwenden
        return signal  # Vereinfacht für Demo
```


### Wartbare Dokumentationsworkflows

```python
from typing import Protocol, runtime_checkable

@runtime_checkable  
class DocumentationProvider(Protocol):
    """
    Protokoll für Klassen, die Dokumentation bereitstellen.
    
    Dieses Protokoll definiert eine einheitliche Schnittstelle
    für automatische Dokumentationsgenerierung.
    """
    
    def get_documentation(self) -> Dict[str, str]:
        """Gibt strukturierte Dokumentation zurück."""
        ...
        
    def validate_examples(self) -> bool:
        """Validiert Code-Beispiele in der Dokumentation."""
        ...

class AutoDocumentedClass:
    """
    Basisklasse mit automatischer Dokumentationsvalidierung.
    
    Diese Klasse demonstriert, wie Dokumentation als integraler
    Bestandteil der Softwarearchitektur behandelt werden kann.
    """
    
    def __init__(self):
        self._doc_metadata = {
            'last_updated': None,
            'examples_validated': False,
            'coverage_score': 0.0
        }
    
    def get_documentation(self) -> Dict[str, str]:
        """
        Extrahiert und strukturiert die Klassendokumentation.
        
        Returns:
            Dictionary mit Dokumentationsabschnitten
        """
        import inspect
        
        doc = inspect.getdoc(self.__class__) or ""
        methods_doc = {}
        
        for name, method in inspect.getmembers(self, inspect.ismethod):
            if not name.startswith('_'):
                methods_doc[name] = inspect.getdoc(method) or ""
        
        return {
            'class_doc': doc,
            'methods': methods_doc,
            'metadata': self._doc_metadata
        }
    
    def validate_examples(self) -> bool:
        """
        Validiert alle Doctest-Beispiele in der Klasse.
        
        Returns:
            True wenn alle Beispiele erfolgreich validiert wurden
        """
        import doctest
        import sys
        from io import StringIO
        
        # Capture doctest output
        old_stdout = sys.stdout
        sys.stdout = mystdout = StringIO()
        
        try:
            # Würde normalerweise doctest auf Klassenmethoden anwenden
            failures = 0  # Demo-Implementierung
            self._doc_metadata['examples_validated'] = failures == 0
            return failures == 0
        finally:
            sys.stdout = old_stdout

# Praktische Anwendung in den Kursprojekten
class WeatherAnalysisToolkit(AutoDocumentedClass):
    """
    Umfassendes Toolkit für Wetterdatenanalyse mit vollständiger Dokumentation.
    
    Dieses Toolkit vereint alle Aspekte der Wetterdatenverarbeitung
    in einer gut dokumentierten und getesteten Schnittstelle.
    
    Examples:
        >>> toolkit = WeatherAnalysisToolkit()
        >>> data = {'temp': [20, 25, 18], 'rain': [0, 5, 2]}
        >>> stats = toolkit.analyze_weather_data(data)  # doctest: +SKIP
        >>> print(f"Average temp: {stats['avg_temp']:.1f}°C")  # doctest: +SKIP
        Average temp: 21.0°C
    """
    
    def analyze_weather_data(self, data: Dict[str, List[float]]) -> Dict[str, float]:
        """
        Analysiert Wetterdaten und berechnet Statistiken.
        
        Args:
            data: Dictionary mit 'temp' und 'rain' Listen
            
        Returns:
            Dictionary mit berechneten Statistiken
            
        Raises:
            ValueError: Wenn Datenformat ungültig ist
        """
        if 'temp' not in data or 'rain' not in data:
            raise ValueError("Daten müssen 'temp' und 'rain' Schlüssel enthalten")
        
        temperatures = data['temp']
        rainfall = data['rain']
        
        return {
            'avg_temp': sum(temperatures) / len(temperatures),
            'max_temp': max(temperatures),
            'min_temp': min(temperatures),
            'total_rain': sum(rainfall)
        }
```