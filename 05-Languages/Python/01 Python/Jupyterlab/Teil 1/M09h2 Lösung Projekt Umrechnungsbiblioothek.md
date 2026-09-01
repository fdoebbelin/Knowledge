## Schritt 1: Hilfsfunktion zur Validierung erstellen

Beginnen wir mit einer Hilfsfunktion, die uns die Validierung von Zahlenwerten erleichtert:

```python
def validiere_zahl(wert, min_wert=None, max_wert=None):
    """
    Validiert einen numerischen Wert.
    
    Args:
        wert: Der zu validierende Wert
        min_wert (optional): Der Mindestwert (inklusiv)
        max_wert (optional): Der Maximalwert (inklusiv)
        
    Returns:
        float: Der validierte Wert als Gleitkommazahl
    """
    # Einfaches Grundgerüst
    pass
```

Nun erweitern wir die Funktion um die Typprüfung:

```python
def validiere_zahl(wert, min_wert=None, max_wert=None):
    """
    Validiert einen numerischen Wert.
    
    Args:
        wert: Der zu validierende Wert
        min_wert (optional): Der Mindestwert (inklusiv)
        max_wert (optional): Der Maximalwert (inklusiv)
        
    Returns:
        float: Der validierte Wert als Gleitkommazahl
        
    Raises:
        TypeError: Wenn der Wert keine Zahl ist
    """
    # Prüfen, ob der Wert in eine Zahl umgewandelt werden kann
    try:
        wert = float(wert)
    except (TypeError, ValueError):
        raise TypeError("Der Wert muss eine Zahl sein")
    
    return wert
```

Fügen wir nun die Bereichsprüfung hinzu:

```python
def validiere_zahl(wert, min_wert=None, max_wert=None):
    """
    Validiert einen numerischen Wert.
    
    Args:
        wert: Der zu validierende Wert
        min_wert (optional): Der Mindestwert (inklusiv)
        max_wert (optional): Der Maximalwert (inklusiv)
        
    Returns:
        float: Der validierte Wert als Gleitkommazahl
        
    Raises:
        TypeError: Wenn der Wert keine Zahl ist
        ValueError: Wenn der Wert außerhalb des erlaubten Bereichs liegt
    """
    # Prüfen, ob der Wert in eine Zahl umgewandelt werden kann
    try:
        wert = float(wert)
    except (TypeError, ValueError):
        raise TypeError("Der Wert muss eine Zahl sein")
    
    # Bereichsprüfung
    if min_wert is not None and wert < min_wert:
        raise ValueError(f"Der Wert muss mindestens {min_wert} sein")
    
    if max_wert is not None and wert > max_wert:
        raise ValueError(f"Der Wert darf höchstens {max_wert} sein")
    
    return wert
```

Testen wir die Validierungsfunktion:

```python
# Testen der Validierungsfunktion
try:
    print("Test mit gültiger Zahl:", validiere_zahl(5))
    print("Test mit Minimum:", validiere_zahl(10, min_wert=5))
    print("Test mit Maximum:", validiere_zahl(5, max_wert=10))
    
    # Diese sollten Fehler auslösen
    print("Test mit ungültiger Zahl:", validiere_zahl("abc"))
except Exception as e:
    print(f"Erwarteter Fehler bei ungültiger Eingabe: {e}")

try:
    print("Test mit Wert unter Minimum:", validiere_zahl(3, min_wert=5))
except Exception as e:
    print(f"Erwarteter Fehler bei Wert unter Minimum: {e}")
```

## Schritt 2: Erstellen der ersten Umrechnungsfunktion für Längen

Beginnen wir mit einer einfachen Funktion zur Umrechnung von Metern in Fuß:

```python
def meter_zu_fuss(meter):
    """
    Rechnet Meter in Fuß um.
    
    Args:
        meter: Länge in Metern
        
    Returns:
        float: Länge in Fuß
    """
    return meter * 3.281
```

Verbessern wir die Funktion nun mit Validierung:

```python
def meter_zu_fuss(meter):
    """
    Rechnet Meter in Fuß um.
    
    Args:
        meter (float): Länge in Metern
        
    Returns:
        float: Länge in Fuß
        
    Raises:
        TypeError: Wenn der Wert keine Zahl ist
        ValueError: Wenn der Wert negativ ist
    """
    meter = validiere_zahl(meter, min_wert=0)
    return meter * 3.281
```

Testen wir diese erste Funktion:

```python
# Test der Meter-zu-Fuß-Umrechnung
try:
    print("1 Meter =", round(meter_zu_fuss(1), 3), "Fuß")
    print("5 Meter =", round(meter_zu_fuss(5), 3), "Fuß")
    print("10 Meter =", round(meter_zu_fuss(10), 3), "Fuß")
    
    # Test mit ungültigen Werten
    print("Negative Meter:", meter_zu_fuss(-5))
except Exception as e:
    print(f"Erwarteter Fehler: {e}")
```

Fügen wir eine weitere Längenumrechnungsfunktion hinzu:

```python
def kilometer_zu_meilen(kilometer):
    """
    Rechnet Kilometer in Meilen um.
    
    Args:
        kilometer (float): Länge in Kilometern
        
    Returns:
        float: Länge in Meilen
        
    Raises:
        TypeError: Wenn der Wert keine Zahl ist
        ValueError: Wenn der Wert negativ ist
    """
    kilometer = validiere_zahl(kilometer, min_wert=0)
    return kilometer * 0.621
```

## Schritt 3: Temperaturumrechnungsfunktionen hinzufügen

Als nächstes entwickeln wir Funktionen für Temperaturumrechnungen:

```python
def celsius_zu_fahrenheit(celsius):
    """
    Rechnet Celsius in Fahrenheit um.
    
    Args:
        celsius (float): Temperatur in Grad Celsius
        
    Returns:
        float: Temperatur in Grad Fahrenheit
    """
    return celsius * 9/5 + 32
```

Verbessern wir die Funktion mit Validierung und physikalischen Grenzen:

```python
def celsius_zu_fahrenheit(celsius):
    """
    Rechnet Celsius in Fahrenheit um.
    
    Args:
        celsius (float): Temperatur in Grad Celsius
        
    Returns:
        float: Temperatur in Grad Fahrenheit
        
    Raises:
        TypeError: Wenn der Wert keine Zahl ist
        ValueError: Wenn der Wert unter dem absoluten Nullpunkt liegt
    """
    # Der absolute Nullpunkt liegt bei -273,15°C
    celsius = validiere_zahl(celsius, min_wert=-273.15)
    return celsius * 9/5 + 32
```

Testen wir die Temperaturumrechnung:

```python
# Test der Celsius-zu-Fahrenheit-Umrechnung
try:
    print("0°C =", round(celsius_zu_fahrenheit(0), 2), "°F")
    print("100°C =", round(celsius_zu_fahrenheit(100), 2), "°F")
    print("-40°C =", round(celsius_zu_fahrenheit(-40), 2), "°F")
    
    # Test mit ungültigen Werten
    print("Unter absoluter Nullpunkt:", celsius_zu_fahrenheit(-300))
except Exception as e:
    print(f"Erwarteter Fehler: {e}")
```

Fügen wir eine zweite Temperaturumrechnungsfunktion hinzu:

```python
def celsius_zu_kelvin(celsius):
    """
    Rechnet Celsius in Kelvin um.
    
    Args:
        celsius (float): Temperatur in Grad Celsius
        
    Returns:
        float: Temperatur in Kelvin
        
    Raises:
        TypeError: Wenn der Wert keine Zahl ist
        ValueError: Wenn der Wert unter dem absoluten Nullpunkt liegt
    """
    celsius = validiere_zahl(celsius, min_wert=-273.15)
    return celsius + 273.15
```

## Schritt 4: Gewichtsumrechnungsfunktionen hinzufügen

Als nächstes implementieren wir Funktionen für Gewichtsumrechnungen:

```python
def kilogramm_zu_pfund(kilogramm):
    """
    Rechnet Kilogramm in Pfund um.
    
    Args:
        kilogramm (float): Gewicht in Kilogramm
        
    Returns:
        float: Gewicht in Pfund
        
    Raises:
        TypeError: Wenn der Wert keine Zahl ist
        ValueError: Wenn der Wert negativ ist
    """
    kilogramm = validiere_zahl(kilogramm, min_wert=0)
    return kilogramm * 2.205
```

Und die zweite Gewichtsumrechnungsfunktion:

```python
def gramm_zu_unzen(gramm):
    """
    Rechnet Gramm in Unzen um.
    
    Args:
        gramm (float): Gewicht in Gramm
        
    Returns:
        float: Gewicht in Unzen
        
    Raises:
        TypeError: Wenn der Wert keine Zahl ist
        ValueError: Wenn der Wert negativ ist
    """
    gramm = validiere_zahl(gramm, min_wert=0)
    return gramm * 0.035
```

## Schritt 5: Testfunktionen für jede Kategorie erstellen

Jetzt erstellen wir Testfunktionen für jede Kategorie von Umrechnungen:

```python
def teste_laengenumrechnungen():
    """Testet die Längenumrechnungsfunktionen."""
    print("=== Teste Längenumrechnungen ===")
    
    # Test: meter_zu_fuss
    print("1 Meter =", round(meter_zu_fuss(1), 3), "Fuß")
    print("10 Meter =", round(meter_zu_fuss(10), 3), "Fuß")
    
    # Test: kilometer_zu_meilen
    print("1 Kilometer =", round(kilometer_zu_meilen(1), 3), "Meilen")
    print("100 Kilometer =", round(kilometer_zu_meilen(100), 3), "Meilen")
    
    print()  # Leerzeile für bessere Lesbarkeit
```

```python
def teste_temperaturumrechnungen():
    """Testet die Temperaturumrechnungsfunktionen."""
    print("=== Teste Temperaturumrechnungen ===")
    
    # Test: celsius_zu_fahrenheit
    print("0°C =", round(celsius_zu_fahrenheit(0), 2), "°F")
    print("100°C =", round(celsius_zu_fahrenheit(100), 2), "°F")
    print("-40°C =", round(celsius_zu_fahrenheit(-40), 2), "°F")
    
    # Test: celsius_zu_kelvin
    print("0°C =", round(celsius_zu_kelvin(0), 2), "K")
    print("100°C =", round(celsius_zu_kelvin(100), 2), "K")
    print("-273.15°C =", round(celsius_zu_kelvin(-273.15), 2), "K")
    
    print()  # Leerzeile für bessere Lesbarkeit
```

```python
def teste_gewichtsumrechnungen():
    """Testet die Gewichtsumrechnungsfunktionen."""
    print("=== Teste Gewichtsumrechnungen ===")
    
    # Test: kilogramm_zu_pfund
    print("1 Kilogramm =", round(kilogramm_zu_pfund(1), 3), "Pfund")
    print("10 Kilogramm =", round(kilogramm_zu_pfund(10), 3), "Pfund")
    print("100 Kilogramm =", round(kilogramm_zu_pfund(100), 3), "Pfund")
    
    # Test: gramm_zu_unzen
    print("100 Gramm =", round(gramm_zu_unzen(100), 3), "Unzen")
    print("500 Gramm =", round(gramm_zu_unzen(500), 3), "Unzen")
    print("1000 Gramm =", round(gramm_zu_unzen(1000), 3), "Unzen")
    
    print()  # Leerzeile für bessere Lesbarkeit
```

## Schritt 6: Erweiterte Fehlerbehandlungstests

Erstellen wir eine Funktion, die speziell die Fehlerbehandlung testet:

```python
def teste_fehlerbehandlung():
    """Testet die Fehlerbehandlung der Umrechnungsfunktionen."""
    print("=== Teste Fehlerbehandlung ===")
    
    # Test: Negative Werte
    try:
        meter_zu_fuss(-5)
        print("FEHLER: Negative Meter wurden akzeptiert!")
    except ValueError as e:
        print("Erwarteter Fehler bei negativen Metern:", e)
    
    # Test: Nicht-numerische Werte
    try:
        meter_zu_fuss("abc")
        print("FEHLER: Nicht-numerische Meter wurden akzeptiert!")
    except TypeError as e:
        print("Erwarteter Fehler bei nicht-numerischen Metern:", e)
    
    # Test: Temperatur unter absolutem Nullpunkt
    try:
        celsius_zu_kelvin(-300)
        print("FEHLER: Temperatur unter absolutem Nullpunkt wurde akzeptiert!")
    except ValueError as e:
        print("Erwarteter Fehler bei Temperatur unter absolutem Nullpunkt:", e)
    
    print()  # Leerzeile für bessere Lesbarkeit
```

## Schritt 7: Haupttestfunktion erstellen, die alle Tests zusammenfasst

Zum Schluss erstellen wir eine Haupttestfunktion, die alle unsere Tests ausführt:

```python
def teste_alle_umrechnungen():
    """Führt alle Testfunktionen aus."""
    print("STARTE ALLE TESTS FÜR DIE UMRECHNUNGSBIBLIOTHEK\n")
    
    teste_laengenumrechnungen()
    teste_temperaturumrechnungen()
    teste_gewichtsumrechnungen()
    teste_fehlerbehandlung()
    
    print("ALLE TESTS ABGESCHLOSSEN")
```

Jetzt können wir die Haupttestfunktion ausführen:

```python
# Führe alle Tests aus
teste_alle_umrechnungen()
```

## Schritt 8: Anwendungsbeispiel mit benutzerdefinierten Eingaben

Schließlich erstellen wir ein interaktives Beispiel, wie man die Bibliothek verwenden könnte:

```python
def umrechnung_durchfuehren():
    """Führt eine benutzergesteuerte Umrechnung durch."""
    print("Einfaches Umrechnungsprogramm\n")
    
    print("Verfügbare Umrechnungen:")
    print("1. Meter zu Fuß")
    print("2. Kilometer zu Meilen")
    print("3. Celsius zu Fahrenheit")
    print("4. Celsius zu Kelvin")
    print("5. Kilogramm zu Pfund")
    print("6. Gramm zu Unzen")
    
    try:
        wahl = int(input("\nWählen Sie eine Umrechnung (1-6): "))
        
        if wahl < 1 or wahl > 6:
            print("Ungültige Auswahl!")
            return
        
        wert = input("Geben Sie den Wert ein: ")
        
        # Konvertiere den Eingabewert
        try:
            wert = float(wert)
        except ValueError:
            print("Ungültiger Wert! Bitte geben Sie eine Zahl ein.")
            return
        
        # Führe die gewählte Umrechnung durch
        if wahl == 1:
            ergebnis = meter_zu_fuss(wert)
            einheit_von = "Meter"
            einheit_zu = "Fuß"
        elif wahl == 2:
            ergebnis = kilometer_zu_meilen(wert)
            einheit_von = "Kilometer"
            einheit_zu = "Meilen"
        elif wahl == 3:
            ergebnis = celsius_zu_fahrenheit(wert)
            einheit_von = "°C"
            einheit_zu = "°F"
        elif wahl == 4:
            ergebnis = celsius_zu_kelvin(wert)
            einheit_von = "°C"
            einheit_zu = "K"
        elif wahl == 5:
            ergebnis = kilogramm_zu_pfund(wert)
            einheit_von = "Kilogramm"
            einheit_zu = "Pfund"
        elif wahl == 6:
            ergebnis = gramm_zu_unzen(wert)
            einheit_von = "Gramm"
            einheit_zu = "Unzen"
        
        print(f"\nErgebnis: {wert} {einheit_von} = {round(ergebnis, 3)} {einheit_zu}")
        
    except (ValueError, TypeError) as e:
        print(f"Fehler: {e}")

# In einem Jupyter Notebook würden wir die Funktion wie folgt aufrufen:
umrechnung_durchfuehren()
```

## Zusammenfassung

In diesem Tutorial haben wir schrittweise eine Umrechnungsbibliothek in JupyterLab entwickelt. Wir haben:

1. Eine robuste Validierungsfunktion erstellt
2. Verschiedene Umrechnungsfunktionen für Längen, Temperaturen und Gewichte implementiert
3. Jede Funktion mit umfassender Fehlerbehandlung und Dokumentation versehen
4. Testfunktionen für jede Kategorie erstellt
5. Eine Haupttestfunktion implementiert, die alle Tests zusammenfasst
6. Ein Anwendungsbeispiel für die Interaktion mit der Bibliothek gezeigt

Dieses inkrementelle Vorgehen ermöglicht es uns:
- Jede Komponente einzeln zu entwickeln und zu testen
- Fehler frühzeitig zu erkennen und zu beheben
- Die Funktionalität schrittweise zu erweitern
- Den Entwicklungsprozess zu dokumentieren

Die vollständige Bibliothek bietet nun eine solide Grundlage für Umrechnungen zwischen verschiedenen Einheiten und kann leicht um weitere Umrechnungsfunktionen erweitert werden.
