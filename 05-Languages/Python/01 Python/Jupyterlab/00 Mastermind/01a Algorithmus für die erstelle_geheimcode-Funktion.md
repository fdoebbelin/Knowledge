## Übungsziel

Implementierung einer Funktion, die einen zufälligen Geheimcode für das MindMaster-Spiel generiert.

## Funktionssignatur

```python
def erstelle_geheimcode(farben, code_laenge):
    """
    Erstellt einen zufälligen Geheimcode aus den gegebenen Farben.
    
    Args:
        farben (list): Liste der verfügbaren Farbcodes (z.B. ['R', 'G', 'B', 'Y', 'W', 'S'])
        code_laenge (int): Länge des zu erstellenden Codes
    
    Returns:
        list: Der generierte Geheimcode als Liste von Farbcodes
    """
    # Hier kommt Ihre Implementierung
```

## Algorithmus-Beschreibung

1. **Eingabevalidierung**:
    - Überprüfe, ob `farben` eine Liste ist und nicht leer ist
    - Überprüfe, ob `code_laenge` eine positive Ganzzahl ist
    - Werfe eine aussagekräftige Fehlermeldung, falls eine der Bedingungen nicht erfüllt ist
2. **Code-Generierung**:
    - Initialisiere eine leere Liste für den Geheimcode
    - Führe die folgenden Schritte `code_laenge`-mal durch:
        - Wähle zufällig ein Element aus der Liste `farben` aus
        - Füge das ausgewählte Element zur Geheimcode-Liste hinzu
    - Hinweis: Das Ziehen erfolgt "mit Zurücklegen", d.h. die gleiche Farbe kann mehrfach vorkommen
3. **Rückgabe**:
    - Gib die erstellte Geheimcode-Liste zurück

## Hinweise für die Implementierung
- Nutze das `random`-Modul aus der Python-Standardbibliothek für die Zufallsauswahl
- Speziell die Funktion `random.choice(seq)` ist hilfreich, um ein zufälliges Element aus einer Sequenz zu wählen
- Liste den benötigten Import am Anfang der Datei: `import random`
- Die Funktion sollte keine Ausgabe machen, sondern nur den generierten Code zurückgeben
- Bei der List Comprehension-Variante kann der Geheimcode in einer einzigen Zeile generiert werden

## Beispiel für erwartete Ergebnisse

- Aufruf: `erstelle_geheimcode(['R', 'G', 'B'], 4)`
- Mögliches Ergebnis: `['G', 'B', 'R', 'G']`
- Anderes mögliches Ergebnis: `['B', 'B', 'B', 'R']`

## Erweiterungsmöglichkeiten (für fortgeschrittene Übung)

- Implementiere eine Option, die festlegt, ob Wiederholungen erlaubt sind
- Füge eine Überprüfung hinzu, ob `code_laenge` größer als die Anzahl der verfügbaren Farben ist, falls keine Wiederholungen erlaubt sind
- Implementiere verschiedene Schwierigkeitsstufen, die automatisch die Anzahl der Farben und die Codelänge anpassen