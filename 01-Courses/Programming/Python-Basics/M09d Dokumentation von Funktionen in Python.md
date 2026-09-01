Docstrings sind mehrzeilige Strings, die eine Funktion dokumentieren. Sie werden direkt nach der Funktionsdefinition platziert und sind durch dreifache Anführungszeichen begrenzt. Eine gute Funktion ist eine gut dokumentierte Funktion!

## Grundlegende Verwendung von Docstrings

Docstrings beschreiben den Zweck einer Funktion, ihre Parameter und Rückgabewerte. Sie unterstützen das Verständnis des Codes und verbessern die Zusammenarbeit im Team.

```python
def quadriere_zahl(x):
    """
    Berechnet das Quadrat einer Zahl.
    
    Args:
        x (int or float): Die zu quadrierende Zahl
        
    Returns:
        int or float: Das Quadrat der Eingabe
        
    Examples:
        >>> quadriere_zahl(4)
        16
        >>> quadriere_zahl(-2)
        4
    """
    return x ** 2
```

```python
# Testen der Funktion mit x=5
quadriere_zahl(x=5)
```

## Docstring-Stile

Es gibt verschiedene standardisierte Formate für Docstrings. Die drei gängigsten sind Google-Style, NumPy-Style und reStructuredText.

### Google-Style Docstring

Der Google-Style ist bekannt für seine Klarheit und Lesbarkeit:

```python
def google_style(param1, param2):
    """Kurze Beschreibung der Funktion.
    
    Längere Beschreibung der Funktion, die mehrere Zeilen
    umfassen kann und weitere Details gibt.
    
    Args:
        param1 (int): Beschreibung des ersten Parameters
        param2 (str): Beschreibung des zweiten Parameters
            
    Returns:
        bool: Beschreibung des Rückgabewerts
            
    Raises:
        ValueError: Wenn param1 negativ ist
            
    Examples:
        >>> google_style(1, 'test')
        True
    """
    return True
```

```python
# Docstring der Funktion abrufen
print(google_style.__doc__)
```

### NumPy-Style Docstring

Der NumPy-Style wird häufig in wissenschaftlichen Python-Bibliotheken verwendet:

```python
def numpy_style(param1, param2):
    """Kurze Beschreibung der Funktion.
    
    Längere Beschreibung der Funktion, die mehrere Zeilen
    umfassen kann und weitere Details gibt.
    
    Parameters
    ----------
    param1 : int
        Beschreibung des ersten Parameters
    param2 : str
        Beschreibung des zweiten Parameters
        
    Returns
    -------
    bool
        Beschreibung des Rückgabewerts
        
    Raises
    ------
    ValueError
        Wenn param1 negativ ist
        
    Examples
    --------
    >>> numpy_style(1, 'test')
    True
    """
    return True
```

```python
# Docstring der Funktion abrufen
print(numpy_style.__doc__)
```

### reStructuredText (Sphinx) Style

Dieser Stil wird von Sphinx, einem populären Dokumentationsgenerator, verwendet:

```python
def rest_style(param1, param2):
    """Kurze Beschreibung der Funktion.
    
    Längere Beschreibung der Funktion, die mehrere Zeilen
    umfassen kann und weitere Details gibt.
    
    :param param1: Beschreibung des ersten Parameters
    :type param1: int
    :param param2: Beschreibung des zweiten Parameters
    :type param2: str
    :returns: Beschreibung des Rückgabewerts
    :rtype: bool
    :raises ValueError: Wenn param1 negativ ist
    
    .. code-block:: python
    
        >>> rest_style(1, 'test')
        True
    """
    return True
```

```python
# Docstring der Funktion abrufen
print(rest_style.__doc__)
```

## Abrufen von Dokumentation

Python bietet verschiedene Möglichkeiten, die Dokumentation von Funktionen abzurufen:

### Zugriff auf den Docstring

Der direkte Zugriff auf das `__doc__`-Attribut einer Funktion gibt ihren Docstring zurück:

```python
def einfache_addition(a, b):
    """Addiert zwei Zahlen und gibt das Ergebnis zurück."""
    return a + b
```

```python
# Docstring abrufen
einfache_addition.__doc__
```

### Verwendung der help()-Funktion

Die `help()`-Funktion bietet eine formatierte Anzeige der Dokumentation:

```python
def temperatur_umrechnen(celsius):
    """
    Rechnet Temperatur von Celsius in Fahrenheit um.
    
    Args:
        celsius (float): Temperatur in Grad Celsius
        
    Returns:
        float: Temperatur in Grad Fahrenheit
        
    Examples:
        >>> temperatur_umrechnen(0)
        32.0
        >>> temperatur_umrechnen(100)
        212.0
    """
    return (celsius * 9/5) + 32
```

```python
# In einem Terminal oder Jupyter Notebook führt dies den folgenden Code aus:
help(temperatur_umrechnen)
```

```python
# Hier geben wir den Docstring direkt zurück, um das Beispiel zu demonstrieren
print(temperatur_umrechnen.__doc__)
```

## Komponenten eines guten Docstrings

Ein guter Docstring sollte folgende Elemente enthalten:

1. Eine kurze, prägnante Zusammenfassung (erste Zeile)
2. Eine ausführlichere Beschreibung (optional)
3. Parameter-Beschreibungen mit Typ-Informationen
4. Rückgabewert-Beschreibung mit Typ-Informationen
5. Ausnahmen, die geworfen werden könnten
6. Beispiele für die Verwendung

```python
def berechne_rabatt(preis, rabatt_prozent=10, mindestpreis=None):
    """
    Berechnet den rabattierten Preis eines Produkts.
    
    Diese Funktion nimmt einen Originalpreis und wendet einen Rabattprozentsatz an.
    Optional kann ein Mindestpreis angegeben werden, unter den der rabattierte
    Preis nicht fallen darf.
    
    Args:
        preis (float): Der Originalpreis des Produkts
        rabatt_prozent (float, optional): Der Rabattprozentsatz. Defaults to 10.
        mindestpreis (float, optional): Der Mindestpreis. Defaults to None.
        
    Returns:
        float: Der rabattierte Preis
        
    Raises:
        ValueError: Wenn der Preis oder Rabatt negativ ist
        
    Examples:
        >>> berechne_rabatt(100, 20)
        80.0
        >>> berechne_rabatt(100, 50, 60)
        60.0
    """
    if preis < 0 or rabatt_prozent < 0:
        raise ValueError("Preis und Rabatt müssen positiv sein")
        
    rabattierter_preis = preis * (1 - rabatt_prozent / 100)
    
    if mindestpreis is not None and rabattierter_preis < mindestpreis:
        return mindestpreis
        
    return rabattierter_preis
```

```python
# Funktion mit verschiedenen Parametern aufrufen
print(f"20% Rabatt auf 100€: {berechne_rabatt(100, 20)}€")
print(f"50% Rabatt auf 100€ mit Mindestpreis 60€: {berechne_rabatt(100, 50, 60)}€")
```

## Automatische Dokumentationsgeneratoren

Aus gut geschriebenen Docstrings kann automatisch eine Dokumentation generiert werden. Beliebte Tools sind:

- **Sphinx**: Standard für Python-Dokumentation
- **pydoc**: Im Python-Standardpaket enthalten
- **MkDocs**: Moderne Dokumentation mit Markdown
- **pdoc**: Automatische API-Dokumentation

Die Dokumentationsgeneratoren extrahieren Informationen aus den Docstrings und erstellen daraus eine strukturierte, lesbare Dokumentation.

## Beste Praktiken für Docstrings

1. **Konsistent bleiben**: Wähle einen Docstring-Stil und verwende ihn im gesamten Projekt.
2. **Aktuell halten**: Aktualisiere die Dokumentation, wenn sich der Code ändert.
3. **Prägnant sein**: Schreibe klar, aber nicht unnötig ausführlich.
4. **Nutzerperspektive einnehmen**: Dokumentiere für Personen, die deinen Code zum ersten Mal sehen.
5. **Beispiele hinzufügen**: Konkrete Beispiele helfen beim Verständnis.

## Weitere Ressourcen

- [PEP 257 - Docstring Conventions](https://peps.python.org/pep-0257/)
- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)
- [NumPy Style Guide](https://numpydoc.readthedocs.io/en/latest/format.html)
- [Sphinx Documentation](https://www.sphinx-doc.org/)
