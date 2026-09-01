# Entwicklung und Testung der `erstelle_geheimcode()` Funktion

In diesem Jupyter Notebook entwickeln wir schrittweise die Funktion `erstelle_geheimcode()` für das Mastermind-Spiel und testen sie ausführlich.

## 1. Anforderungsanalyse

Bevor wir mit der Implementierung beginnen, definieren wir die Anforderungen an unsere Funktion:

### Funktionsanforderungen:
- **Name**: `erstelle_geheimcode(farben, code_laenge)`
- **Parameter**: 
  - `farben`: Liste verfügbarer Farben (z.B. ['R', 'G', 'B', 'Y', 'W', 'S'])
  - `code_laenge`: Anzahl der Positionen im Geheimcode (z.B. 4)
- **Rückgabe**: Liste mit zufällig gewählten Farben
- **Verhalten**: Jede Position kann jede verfügbare Farbe haben (Wiederholungen erlaubt)

```python
# Beispiel für erwartetes Verhalten:
# Input: farben=['R', 'G', 'B'], code_laenge=4
# Output: ['R', 'B', 'R', 'G'] oder ähnlich
```

## 2. Erste einfache Implementierung

Beginnen wir mit einer sehr einfachen Version der Funktion:

```python
def erstelle_geheimcode_v1(farben, code_laenge):
    """
    Erste Version: Erstellt einen Geheimcode durch wiederholte zufällige Auswahl.
    
    Args:
        farben: Liste verfügbarer Farben
        code_laenge: Länge des zu erstellenden Codes
        
    Returns:
        Liste mit zufällig gewählten Farben
    """
    import random
    
    geheimcode = []
    for i in range(code_laenge):
        zufaellige_farbe = random.choice(farben)
        geheimcode.append(zufaellige_farbe)
    
    return geheimcode

# Test der ersten Version
print("=== Test der ersten Version ===")
farben_test = ['R', 'G', 'B', 'Y']
code_laenge_test = 4

for i in range(5):
    code = erstelle_geheimcode_v1(farben_test, code_laenge_test)
    print(f"Geheimcode {i+1}: {code}")
```

## 3. Verbesserung mit List Comprehension

Die erste Version funktioniert, kann aber eleganter geschrieben werden:

```python
def erstelle_geheimcode_v2(farben, code_laenge):
    """
    Zweite Version: Verwendung einer List Comprehension für kompakteren Code.
    
    Args:
        farben: Liste verfügbarer Farben
        code_laenge: Länge des zu erstellenden Codes
        
    Returns:
        Liste mit zufällig gewählten Farben
    """
    import random
    
    return [random.choice(farben) for _ in range(code_laenge)]

# Test der zweiten Version
print("=== Test der zweiten Version ===")
for i in range(5):
    code = erstelle_geheimcode_v2(farben_test, code_laenge_test)
    print(f"Geheimcode {i+1}: {code}")
```

## 4. Optimierte Version mit random.choices()

Python bietet mit `random.choices()` eine noch effizientere Methode:

```python
def erstelle_geheimcode_v3(farben, code_laenge):
    """
    Dritte Version: Verwendung von random.choices() für bessere Performance.
    
    Args:
        farben: Liste verfügbarer Farben
        code_laenge: Länge des zu erstellenden Codes
        
    Returns:
        Liste mit zufällig gewählten Farben
    """
    import random
    
    return random.choices(farben, k=code_laenge)

# Test der dritten Version
print("=== Test der dritten Version ===")
for i in range(5):
    code = erstelle_geheimcode_v3(farben_test, code_laenge_test)
    print(f"Geheimcode {i+1}: {code}")
```

## 5. Robuste Version mit Eingabevalidierung

Für produktiven Code sollten wir Eingabefehler abfangen:

```python
def erstelle_geheimcode_v4(farben, code_laenge):
    """
    Vierte Version: Mit Eingabevalidierung für robusten Code.
    
    Args:
        farben: Liste verfügbarer Farben
        code_laenge: Länge des zu erstellenden Codes
        
    Returns:
        Liste mit zufällig gewählten Farben
        
    Raises:
        ValueError: Bei ungültigen Eingabeparametern
        TypeError: Bei falschen Datentypen
    """
    import random
    
    # Eingabevalidierung
    if not isinstance(farben, list):
        raise TypeError("Parameter 'farben' muss eine Liste sein")
    
    if not farben:
        raise ValueError("Die Farbenliste darf nicht leer sein")
    
    if not isinstance(code_laenge, int):
        raise TypeError("Parameter 'code_laenge' muss eine Ganzzahl sein")
    
    if code_laenge <= 0:
        raise ValueError("Die Codelänge muss größer als 0 sein")
    
    if code_laenge > 20:  # Sinnvolle Obergrenze
        raise ValueError("Die Codelänge sollte nicht größer als 20 sein")
    
    return random.choices(farben, k=code_laenge)

# Test der vierten Version mit gültigen Eingaben
print("=== Test der vierten Version (gültige Eingaben) ===")
for i in range(3):
    code = erstelle_geheimcode_v4(farben_test, code_laenge_test)
    print(f"Geheimcode {i+1}: {code}")
```

## 6. Umfassendes Testen der Eingabevalidierung

Testen wir verschiedene Fehlerfälle:

```python
print("=== Test der Eingabevalidierung ===")

# Test 1: Leere Farbenliste
try:
    code = erstelle_geheimcode_v4([], 4)
    print("FEHLER: Leere Liste sollte einen Fehler verursachen")
except ValueError as e:
    print(f"✓ Korrekt abgefangen: {e}")

# Test 2: Ungültiger Datentyp für Farben
try:
    code = erstelle_geheimcode_v4("RGBY", 4)
    print("FEHLER: String statt Liste sollte einen Fehler verursachen")
except TypeError as e:
    print(f"✓ Korrekt abgefangen: {e}")

# Test 3: Negative Codelänge
try:
    code = erstelle_geheimcode_v4(['R', 'G'], -1)
    print("FEHLER: Negative Codelänge sollte einen Fehler verursachen")
except ValueError as e:
    print(f"✓ Korrekt abgefangen: {e}")

# Test 4: Codelänge als Float
try:
    code = erstelle_geheimcode_v4(['R', 'G'], 3.5)
    print("FEHLER: Float-Codelänge sollte einen Fehler verursachen")
except TypeError as e:
    print(f"✓ Korrekt abgefangen: {e}")

# Test 5: Zu große Codelänge
try:
    code = erstelle_geheimcode_v4(['R', 'G'], 25)
    print("FEHLER: Zu große Codelänge sollte einen Fehler verursachen")
except ValueError as e:
    print(f"✓ Korrekt abgefangen: {e}")
```

## 7. Statistische Tests der Zufälligkeit

Überprüfen wir, ob unsere Funktion wirklich zufällige Codes generiert:

```python
def teste_zufaelligkeit(farben, code_laenge, anzahl_tests=1000):
    """
    Testet die Zufälligkeit der generierten Codes durch statistische Analyse.
    
    Args:
        farben: Liste verfügbarer Farben
        code_laenge: Länge des Codes
        anzahl_tests: Anzahl der zu generierenden Testcodes
    """
    print(f"=== Zufälligkeitstest mit {anzahl_tests} Codes ===")
    
    # Zähle Häufigkeit jeder Farbe an jeder Position
    positions_statistik = [{farbe: 0 for farbe in farben} for _ in range(code_laenge)]
    
    # Generiere viele Codes und sammle Statistiken
    for _ in range(anzahl_tests):
        code = erstelle_geheimcode_v4(farben, code_laenge)
        for position, farbe in enumerate(code):
            positions_statistik[position][farbe] += 1
    
    # Erwartete Häufigkeit für gleichmäßige Verteilung
    erwartete_haeufigkeit = anzahl_tests / len(farben)
    toleranz = erwartete_haeufigkeit * 0.1  # 10% Toleranz
    
    print(f"Erwartete Häufigkeit pro Farbe: {erwartete_haeufigkeit:.1f}")
    print(f"Toleranzbereich: ±{toleranz:.1f}")
    print()
    
    # Analysiere jede Position
    for position in range(code_laenge):
        print(f"Position {position + 1}:")
        for farbe in farben:
            haeufigkeit = positions_statistik[position][farbe]
            abweichung = abs(haeufigkeit - erwartete_haeufigkeit)
            status = "✓" if abweichung <= toleranz else "⚠"
            print(f"  {farbe}: {haeufigkeit:4d} ({haeufigkeit/anzahl_tests*100:5.1f}%) {status}")
        print()

# Führe den Zufälligkeitstest durch
teste_zufaelligkeit(['R', 'G', 'B', 'Y'], 4, 1000)
```

## 8. Performance-Test

Vergleichen wir die Performance unserer verschiedenen Implementierungen:

```python
import time

def performance_test():
    """
    Vergleicht die Performance der verschiedenen Implementierungen.
    """
    print("=== Performance-Test ===")
    farben = ['R', 'G', 'B', 'Y', 'W', 'S']
    code_laenge = 4
    anzahl_aufrufe = 100000
    
    funktionen = [
        ("Version 1 (for-loop)", erstelle_geheimcode_v1),
        ("Version 2 (list comprehension)", erstelle_geheimcode_v2),
        ("Version 3 (random.choices)", erstelle_geheimcode_v3),
        ("Version 4 (mit Validierung)", erstelle_geheimcode_v4)
    ]
    
    for name, funktion in funktionen:
        start_zeit = time.time()
        
        for _ in range(anzahl_aufrufe):
            funktion(farben, code_laenge)
        
        end_zeit = time.time()
        dauer = end_zeit - start_zeit
        aufrufe_pro_sekunde = anzahl_aufrufe / dauer
        
        print(f"{name:30s}: {dauer:.4f}s ({aufrufe_pro_sekunde:,.0f} Aufrufe/s)")

# Führe den Performance-Test durch
performance_test()
```

## 9. Finale Version mit Dokumentation

Hier ist unsere finale, gut dokumentierte Version:

```python
def erstelle_geheimcode(farben, code_laenge):
    """
    Erstellt einen zufälligen Geheimcode für das Mastermind-Spiel.
    
    Diese Funktion generiert einen Geheimcode der angegebenen Länge,
    wobei jede Position eine zufällig ausgewählte Farbe aus der
    verfügbaren Farbpalette erhält. Wiederholungen sind erlaubt.
    
    Args:
        farben (list): Liste der verfügbaren Farben (z.B. ['R', 'G', 'B', 'Y'])
        code_laenge (int): Gewünschte Länge des Geheimcodes (1-20)
        
    Returns:
        list: Liste mit zufällig gewählten Farben der Länge code_laenge
        
    Raises:
        TypeError: Wenn farben keine Liste ist oder code_laenge keine Ganzzahl
        ValueError: Wenn farben leer ist oder code_laenge außerhalb des gültigen Bereichs
        
    Examples:
        >>> farben = ['R', 'G', 'B', 'Y']
        >>> code = erstelle_geheimcode(farben, 4)
        >>> len(code)
        4
        >>> all(farbe in farben for farbe in code)
        True
        
        >>> # Verschiedene Codes sollten unterschiedlich sein (bei mehrfachen Aufrufen)
        >>> codes = [erstelle_geheimcode(farben, 4) for _ in range(10)]
        >>> len(set(tuple(code) for code in codes)) > 1  # Mindestens 2 verschiedene
        True
    """
    import random
    
    # Eingabevalidierung
    if not isinstance(farben, list):
        raise TypeError(f"Parameter 'farben' muss eine Liste sein, erhalten: {type(farben).__name__}")
    
    if not farben:
        raise ValueError("Die Farbenliste darf nicht leer sein")
    
    if not isinstance(code_laenge, int):
        raise TypeError(f"Parameter 'code_laenge' muss eine Ganzzahl sein, erhalten: {type(code_laenge).__name__}")
    
    if code_laenge <= 0:
        raise ValueError(f"Die Codelänge muss größer als 0 sein, erhalten: {code_laenge}")
    
    if code_laenge > 20:
        raise ValueError(f"Die Codelänge sollte nicht größer als 20 sein, erhalten: {code_laenge}")
    
    # Generiere zufälligen Code
    return random.choices(farben, k=code_laenge)

# Abschließender Test der finalen Version
print("=== Test der finalen Version ===")
farben_mastermind = ['R', 'G', 'B', 'Y', 'W', 'S']

print("Beispielcodes:")
for i in range(5):
    code = erstelle_geheimcode(farben_mastermind, 4)
    print(f"  {i+1}. {' '.join(code)}")

print("\nVerschiedene Codelängen:")
for laenge in [2, 3, 4, 5, 6]:
    code = erstelle_geheimcode(farben_mastermind, laenge)
    print(f"  Länge {laenge}: {' '.join(code)}")
```

## 10. Zusammenfassung

Wir haben die `erstelle_geheimcode()` Funktion schrittweise entwickelt und dabei folgende Aspekte berücksichtigt:

### Entwicklungsschritte:
1. **Einfache Implementierung** mit for-Schleife
2. **Elegantere Version** mit List Comprehension
3. **Optimierte Version** mit `random.choices()`
4. **Robuste Version** mit Eingabevalidierung
5. **Finale Version** mit ausführlicher Dokumentation

### Durchgeführte Tests:
- ✅ **Funktionalitätstests**: Verschiedene Eingabeparameter
- ✅ **Eingabevalidierung**: Fehlerbehandlung für ungültige Eingaben
- ✅ **Zufälligkeitstests**: Statistische Analyse der generierten Codes
- ✅ **Performance-Tests**: Vergleich verschiedener Implementierungen

### Wichtige Erkenntnisse:
- `random.choices()` ist effizienter als wiederholte `random.choice()` Aufrufe
- Eingabevalidierung macht Code robuster, kostet aber Performance
- Statistische Tests helfen bei der Verifikation der Zufälligkeit
- Gute Dokumentation erleichtert die Wartung und Nutzung

Die finale Version ist bereit für den produktiven Einsatz im Mastermind-Spiel!
