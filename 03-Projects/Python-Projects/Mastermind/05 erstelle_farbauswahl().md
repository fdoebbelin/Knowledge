Diese Funktion:
1. Nimmt eine Liste mit Farbcodes entgegen
2. Enthält ein Dictionary mit Zuordnungen von Farbcodes zu lesbaren Farbnamen
3. Erstellt eine formatierte Übersicht als String
4. Gibt die formatierte Übersicht zurück, ohne sie auszugeben

```python
def erstelle_farbauswahl(farben):
    """
    Erstellt eine formatierte Übersicht der verfügbaren Farben.
    
    Args:
        farben (list): Liste mit den verfügbaren Farbcodes (z.B. ['R', 'G', 'B', 'Y', 'W', 'S'])
    
    Returns:
        str: Formatierte Übersicht der verfügbaren Farben
    """
    farbnamen = {
        'R': 'Rot',
        'G': 'Grün',
        'B': 'Blau',
        'Y': 'Gelb',
        'W': 'Weiß',
        'S': 'Schwarz',
        'O': 'Orange',
        'P': 'Pink',
        'V': 'Violett',
        'C': 'Cyan'
        # Bei Bedarf weitere Farben hinzufügen
    }
    
    header = "VERFÜGBARE FARBEN:"
    trennlinie = "-" * 30
    
    farbliste = []
    for code in farben:
        name = farbnamen.get(code, f"Unbekannt ({code})")
        farbliste.append(f"  {code} = {name}")
    
    ausgabe = [
        "\n" + header,
        trennlinie
    ] + farbliste + [
        trennlinie,
        f"Bitte wählen Sie {len(farben)} Farben aus dieser Liste für Ihren Rateversuch.\n"
    ]
    
    return "\n".join(ausgabe)
```

```python
farben = ['R', 'G', 'B', 'Y', 'W', 'M']
print(erstelle_farbauswahl(farben))
```

In der Hauptfunktion würdest du sie so verwenden:

```python
def spiele_mastermind():
    # ...
    farben = ['R', 'G', 'B', 'Y', 'W', 'S']
    farbauswahl_text = erstelle_farbauswahl(farben)
    print(farbauswahl_text)  # Hier entscheidet der Aufrufer über die Ausgabe
    # ...
```

Diese Funktion ist jetzt:
- Wiederverwendbar in verschiedenen Kontexten
- Leichter zu testen
- Flexibler (kann in GUI, Terminal, Web, etc. verwendet werden)
- Klar in ihrer Verantwortlichkeit (erzeugt Text, entscheidet nicht über Ausgabe)