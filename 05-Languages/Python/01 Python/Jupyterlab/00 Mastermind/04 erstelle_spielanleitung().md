Beschreibung der Funktion:
1. Die Funktion heißt nun `erstelle_spielanleitung()` statt `zeige_spielanleitung()`, um die Rückgabe statt der Ausgabe zu betonen
2. Sie gibt einen vollständig formatierten String zurück
3. Der Aufrufer entscheidet, ob und wie die Anleitung ausgegeben wird (z.B. `print(erstelle_spielanleitung())`)
```python
def erstelle_spielanleitung():
    """
    Erstellt die Spielanleitung für Mastermind als formatierten Text.
    
    Returns:
        str: Die komplette Spielanleitung als formatierter Text
    """
    trennlinie = "=" * 60
    titel = " " * 20 + "MASTERMIND - SPIELANLEITUNG"
    
    anleitung = [
        "\n" + trennlinie,
        titel,
        trennlinie,
        
        "\nSpielziel:",
        "  Erraten Sie den geheimen Farbcode in möglichst wenigen Versuchen!",
        
        "\nSpielverlauf:",
        "  1. Der Computer generiert einen geheimen Farbcode aus vier Farben.",
        "  2. Die Farben können sich wiederholen.",
        "  3. Sie haben 12 Versuche, um den Code zu knacken.",
        "  4. Nach jedem Versuch erhalten Sie ein Feedback:",
        
        "\nFeedback-Erklärung:",
        "  • Schwarzer Stift (●): Eine Farbe ist richtig UND an der richtigen Position.",
        "  • Weißer Stift (○): Eine Farbe ist richtig, aber an der FALSCHEN Position.",
        "  • Die Reihenfolge der Feedback-Stifte hat KEINE Bedeutung!",
        
        "\nBeispiel:",
        "  Geheimer Code: RGBY (Rot, Grün, Blau, Gelb)",
        "  Ihr Tipp:      RGYB (Rot, Grün, Gelb, Blau)",
        "  Feedback:      ●● ○○ (2 richtige Farben an richtiger Position,",
        "                     2 richtige Farben an falscher Position)",
        
        "\nEingabe-Format:",
        "  Geben Sie vier Buchstaben ein, die den Farben entsprechen.",
        "  z.B. 'RGBY' für Rot, Grün, Blau, Gelb",
        
        "\nViel Erfolg beim Knacken des Codes!",
        trennlinie + "\n"
    ]
    
    return "\n".join(anleitung)
```

```python
print(erstelle_spielanleitung())
```

In der Hauptfunktion würdest du sie so verwenden:

```python
def spiele_mastermind():
    # ...
    anleitung = erstelle_spielanleitung()
    print(anleitung)  # Hier entscheidet der Aufrufer über die Ausgabe
    # ...
```