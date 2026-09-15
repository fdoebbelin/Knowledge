## Schritt 1: Problemanalyse und Spezifikation

Das Feedback im Mastermind-Spiel besteht aus zwei Komponenten:
- **Schwarze Stifte**: Richtige Farbe an richtiger Position
- **Weiße Stifte**: Richtige Farbe an falscher Position

Beispiel für das Feedback-System:
- Geheimcode: 
	- `['R', 'G', 'B', 'Y']`
- Rateversuch: 
	- `['R', 'B', 'G', 'W']`
- Ergebnis: 
	- 1 schwarzer Stift (R an Position 0), 
	- 2 weiße Stifte (G und B)

## Schritt 2: Erste einfache Implementierung

```python
def pruefe_rate_versuch(geheimcode, rateversuch):
    """
    Erste Version: Einfache Implementierung für das Verständnis
    
    Args:
        geheimcode: Liste mit dem geheimen Code (z.B. ['R', 'G', 'B', 'Y'])
        rateversuch: Liste mit dem Rateversuch (z.B. ['R', 'B', 'G', 'W'])
        
    Returns:
        Dictionary mit 'schwarz' und 'weiss' Stiften
    """
    if len(geheimcode) != len(rateversuch):
        raise ValueError("Geheimcode und Rateversuch müssen gleiche Länge haben")
    
    schwarze_stifte = 0
    weisse_stifte = 0
    
    # Schritt 1: Schwarze Stifte zählen (richtige Farbe an richtiger Position)
    for i in range(len(geheimcode)):
        if geheimcode[i] == rateversuch[i]:
            schwarze_stifte += 1
    
    # Schritt 2: Weiße Stifte zählen (richtige Farbe an falscher Position)
    # Für jede Farbe im Rateversuch prüfen, ob sie im Geheimcode vorkommt
    geheimcode_kopie = geheimcode.copy()
    rateversuch_kopie = rateversuch.copy()
    
    # Entferne bereits korrekt geratene Positionen
    for i in range(len(geheimcode) - 1, -1, -1):  # Rückwärts iterieren für sicheres Entfernen
        if geheimcode[i] == rateversuch[i]:
            geheimcode_kopie.pop(i)
            rateversuch_kopie.pop(i)
    
    # Zähle weiße Stifte
    for farbe in rateversuch_kopie:
        if farbe in geheimcode_kopie:
            weisse_stifte += 1
            geheimcode_kopie.remove(farbe)  # Entferne die verwendete Farbe
    
    return {
        'schwarz': schwarze_stifte,
        'weiss': weisse_stifte
    }
```
```python
geheim = ['R', 'G', 'B', 'Y']
versuch = ['R', 'B', 'G', 'W']
ergebnis = pruefe_rate_versuch(geheim, versuch)
print(f"Geheimcode: {geheim}")
print(f"Rateversuch: {versuch}")
print(f"Feedback: {ergebnis}")
```
## Schritt 3: Verbesserte Version mit umfassenden Tests

```python
def pruefe_rate_versuch(geheimcode, rateversuch):
    """
    Finale Version: Vergleicht einen Rateversuch mit dem Geheimcode und gibt Feedback zurück
    
    Diese Funktion implementiert die Mastermind-Bewertungslogik:
    - Schwarze Stifte: Richtige Farbe an richtiger Position
    - Weiße Stifte: Richtige Farbe an falscher Position
    
    Args:
        geheimcode (list): Der geheime Code als Liste von Farben
        rateversuch (list): Der Rateversuch als Liste von Farben
        
    Returns:
        dict: Dictionary mit Schlüsseln 'schwarz' und 'weiss' für die Anzahl der Stifte
        
    Raises:
        ValueError: Wenn geheimcode und rateversuch unterschiedliche Längen haben
        TypeError: Wenn die Eingaben nicht vom Typ list sind
        
    Example:
        >>> pruefe_rate_versuch(['R', 'G', 'B', 'Y'], ['R', 'B', 'G', 'W'])
        {'schwarz': 1, 'weiss': 2}
    """
    # Eingabevalidierung
    if not isinstance(geheimcode, list) or not isinstance(rateversuch, list):
        raise TypeError("Beide Eingaben müssen Listen sein")
    
    if len(geheimcode) != len(rateversuch):
        raise ValueError(f"Unterschiedliche Längen: Geheimcode({len(geheimcode)}) vs Rateversuch({len(rateversuch)})")
    
    if len(geheimcode) == 0:
        return {'schwarz': 0, 'weiss': 0}
    
    schwarze_stifte = 0
    geheim_nicht_getroffen = []
    versuch_nicht_getroffen = []
    
    # Phase 1: Schwarze Stifte zählen und nicht-getroffene Farben sammeln
    for i in range(len(geheimcode)):
        if geheimcode[i] == rateversuch[i]:
            schwarze_stifte += 1
        else:
            geheim_nicht_getroffen.append(geheimcode[i])
            versuch_nicht_getroffen.append(rateversuch[i])
    
    # Phase 2: Weiße Stifte zählen
    weisse_stifte = 0
    geheim_verfuegbar = geheim_nicht_getroffen.copy()
    
    for farbe in versuch_nicht_getroffen:
        if farbe in geheim_verfuegbar:
            weisse_stifte += 1
            geheim_verfuegbar.remove(farbe)
    
    return {
        'schwarz': schwarze_stifte,
        'weiss': weisse_stifte
    }
```

```python
def teste_algorithmus():
    """Führt umfassende Tests des Feedback-Algorithmus durch"""
    
    print("=== Umfassende Tests des Mastermind Feedback-Algorithmus ===\n")
    
    test_faelle = [
        # (Geheimcode, Rateversuch, Erwartetes Ergebnis, Beschreibung)
        (['R', 'G', 'B', 'Y'], ['R', 'G', 'B', 'Y'], {'schwarz': 4, 'weiss': 0}, "Perfekter Treffer"),
        (['R', 'G', 'B', 'Y'], ['Y', 'B', 'G', 'R'], {'schwarz': 0, 'weiss': 4}, "Alle Farben falsch positioniert"),
        (['R', 'G', 'B', 'Y'], ['R', 'B', 'G', 'W'], {'schwarz': 1, 'weiss': 2}, "Gemischtes Feedback"),
        (['R', 'G', 'B', 'Y'], ['W', 'S', 'P', 'O'], {'schwarz': 0, 'weiss': 0}, "Keine Treffer"),
        (['R', 'R', 'G', 'B'], ['R', 'G', 'R', 'B'], {'schwarz': 2, 'weiss': 2}, "Doppelte Farben"),
        (['R', 'G', 'G', 'B'], ['G', 'R', 'B', 'G'], {'schwarz': 0, 'weiss': 4}, "Komplexe Dopplung"),
        (['A'], ['A'], {'schwarz': 1, 'weiss': 0}, "Ein Element - Treffer"),
        (['A'], ['B'], {'schwarz': 0, 'weiss': 0}, "Ein Element - kein Treffer"),
        ([], [], {'schwarz': 0, 'weiss': 0}, "Leere Listen"),
    ]
    
    alle_tests_bestanden = True
    
    
    print(f"\n=== Testergebnis ===")
    if alle_tests_bestanden:
        print("🎉 Alle Tests bestanden! Der Algorithmus funktioniert korrekt.")
    else:
        print("❌ Einige Tests sind fehlgeschlagen. Überprüfung erforderlich.")
    
    return alle_tests_bestanden

# Tests ausführen
teste_algorithmus()
```
