In JupyterLab können Sie Funktionen über mehrere Codeblöcke hinweg entwickeln, was besonders nützlich für schrittweise Entwicklung und Debugging ist. Dies ist eines der Hauptmerkmale interaktiver Notebooks.

## Grundlegendes Konzept

Wenn Sie in JupyterLab Code ausführen, wird er in einer einzigen Python-Sitzung ausgeführt. Das bedeutet, dass Variablen, Funktionen und Klassen, die in einem Codeblock definiert werden, in nachfolgenden Blöcken verfügbar sind.

## Beispiel: Schrittweise Funktionsentwicklung

Lassen Sie mich das anhand eines Beispiels aus den von Ihnen bereitgestellten Dokumenten demonstrieren:

### Schritt 1: Grundfunktion definieren

```python
def berechne_statistiken(*zahlen, runden_auf=2):
    """
    Berechnet verschiedene statistische Werte für eine beliebige Anzahl von Zahlen.
    
    Args:
        *zahlen: Variable Anzahl von Zahlen
        runden_auf: Anzahl der Nachkommastellen für die Rundung (Default: 2)
    """
    # Zunächst nur ein leerer Rahmen
    pass
```

### Schritt 2: Grundlegende Fehlerbehandlung hinzufügen

```python
def berechne_statistiken(*zahlen, runden_auf=2):
    """
    Berechnet verschiedene statistische Werte für eine beliebige Anzahl von Zahlen.
    
    Args:
        *zahlen: Variable Anzahl von Zahlen
        runden_auf: Anzahl der Nachkommastellen für die Rundung (Default: 2)
    """
    if not zahlen:
        return {"error": "Keine Zahlen angegeben"}
```

```python
berechne_statistiken()
```

### Schritt 3: Implementierung der Statistikberechnungen

```python
def berechne_statistiken(*zahlen, runden_auf=2):
    """
    Berechnet verschiedene statistische Werte für eine beliebige Anzahl von Zahlen.
    
    Args:
        *zahlen: Variable Anzahl von Zahlen
        runden_auf: Anzahl der Nachkommastellen für die Rundung (Default: 2)
        
    Returns:
        Dictionary mit statistischen Werten
    """
    if not zahlen:
        return {"error": "Keine Zahlen angegeben"}
    
    summe = sum(zahlen)
    anzahl = len(zahlen)
    mittelwert = summe / anzahl
    minimum = min(zahlen)
    maximum = max(zahlen)
    
    return {
        "anzahl": anzahl,
        "summe": round(summe, runden_auf),
        "mittelwert": round(mittelwert, runden_auf),
        "minimum": round(minimum, runden_auf),
        "maximum": round(maximum, runden_auf)
    }
```

### Schritt 4: Testen der Funktion

```python
# Test mit einigen Zahlen
berechne_statistiken(5, 12, 98, 42, 65, 31)
```

### Schritt 5: Optimieren oder erweitern der Funktion

```python
def berechne_statistiken(*zahlen, runden_auf=2, zusaetzlich=None):
    """
    Berechnet verschiedene statistische Werte für eine beliebige Anzahl von Zahlen.
    
    Args:
        *zahlen: Variable Anzahl von Zahlen
        runden_auf: Anzahl der Nachkommastellen für die Rundung (Default: 2)
        zusaetzlich: Liste zusätzlicher Statistiken ('median', 'varianz', etc.)
        
    Returns:
        Dictionary mit statistischen Werten
    """
    if not zahlen:
        return {"error": "Keine Zahlen angegeben"}
    
    summe = sum(zahlen)
    anzahl = len(zahlen)
    mittelwert = summe / anzahl
    minimum = min(zahlen)
    maximum = max(zahlen)
    
    ergebnis = {
        "anzahl": anzahl,
        "summe": round(summe, runden_auf),
        "mittelwert": round(mittelwert, runden_auf),
        "minimum": round(minimum, runden_auf),
        "maximum": round(maximum, runden_auf)
    }
    
    # Zusätzliche Statistiken berechnen, wenn angefordert
    if zusaetzlich:
        if 'median' in zusaetzlich:
            sortiert = sorted(zahlen)
            if anzahl % 2 == 0:
                median = (sortiert[anzahl//2 - 1] + sortiert[anzahl//2]) / 2
            else:
                median = sortiert[anzahl//2]
            ergebnis['median'] = round(median, runden_auf)
        
        if 'varianz' in zusaetzlich:
            varianz = sum((x - mittelwert) ** 2 for x in zahlen) / anzahl
            ergebnis['varianz'] = round(varianz, runden_auf)
    
    return ergebnis
```

## Vorteile dieser Methode

1. **Inkrementelle Entwicklung**: Sie können Ihre Funktion schrittweise entwickeln und testen.
2. **Sofortiges Feedback**: Nach jeder Änderung können Sie die Funktion testen.
3. **Beibehaltung des Kontexts**: Sie müssen nicht immer den gesamten Code erneut ausführen.
4. **Dokumentation des Entwicklungsprozesses**: Die Notebook-Struktur dokumentiert Ihren Entwicklungsprozess.

## Wichtige Hinweise

1. **Code-Reihenfolge**: Die Ausführungsreihenfolge der Zellen ist wichtig. Wenn Sie eine frühere Zelle ändern und ausführen, müssen Sie möglicherweise auch nachfolgende Zellen erneut ausführen.

2. **Zustandsmanagement**: Der Zustand bleibt zwischen den Zellen erhalten. Wenn Sie Variablen außerhalb Ihrer Funktion definieren, können diese den Funktionsbetrieb beeinflussen.

3. **Neu starten**: Manchmal ist es hilfreich, den Kernel neu zu starten und alles von Anfang an auszuführen, um sicherzustellen, dass die Funktion wie erwartet funktioniert.

4. **In Produktionscode überführen**: Wenn Sie Ihre Funktion in ein Python-Modul überführen möchten, müssen Sie sicherstellen, dass alle notwendigen Teile zusammen definiert sind.

Würden Sie gerne ein weiteres Beispiel sehen, wie man eine komplexere Funktion schrittweise aufbaut, oder haben Sie spezifische Fragen zu bestimmten Aspekten der Funktionsentwicklung in JupyterLab?​​​​​​​​​​​​​​​​
