
## Zweck der Funktion

Die Funktion `lies_rateversuch()` ist dafür zuständig, die Eingabe des Spielers einzulesen und in das richtige Format zu bringen. Sie nimmt die Benutzereingabe entgegen und wandelt sie in eine Liste von Farbcodes um, die das Spiel verwenden kann.rsuch()` - Anleitung für Teilnehmer
## Funktionssignatur

```python
def lies_rateversuch(farben, code_laenge):
    """
    Liest Benutzereingabe für einen Rateversuch ein.
    
    Args:
        farben (list): Liste verfügbarer Farben (z.B. ['R', 'G', 'B', 'Y', 'W', 'S'])
        code_laenge (int): Länge des Geheimcodes (normalerweise 4)
        
    Returns:
        list: Liste mit den geratenen Farben (z.B. ['R', 'G', 'B', 'Y'])
    """
```
## Was die Funktion leisten soll

1. **Eingabe anfordern**: Den Spieler nach seinem Rateversuch fragen
2. **Eingabe verarbeiten**: Text in Großbuchstaben umwandeln und in einzelne Zeichen aufteilen
3. **Eingabe validieren**: Prüfen, ob die Eingabe korrekt ist
4. **Bei Fehlern**: Fehlermeldung ausgeben und erneut nach Eingabe fragen
5. **Rückgabe**: Gültige Eingabe als Liste zurückgeben

### Typische Eingabefehler und ihre Behandlung:

- **Falsche Länge** → `len(eingabe) != code_laenge`
- **Ungültige Farben** → `farbe not in farben`
- **Leer-Eingabe** → `if not eingabe:`
- **Zu viele Leerzeichen** → `eingabe.strip()` und `eingabe.replace(' ', '')`

### Implementierungstipp:

```python
def lies_rateversuch(farben, code_laenge):
    while True:  # Wiederhole bis gültige Eingabe
        eingabe = input(f"Geben Sie {code_laenge} Farben ein: ").strip().upper()
        
        # Hier kommt Ihre Validierung...
        # Bei gültiger Eingabe: return [liste der farben]
        # Bei ungültiger Eingabe: print("Fehlermeldung") und weiter in der Schleife
```

## Warum diese Funktion wichtig ist

- **Robustheit**: Das Spiel stürzt nie wegen falscher Eingaben ab
- **Benutzerfreundlichkeit**: Klare Fehlermeldungen helfen dem Spieler
- **Lerneffekt**: Zeigt, wie wichtige Eingabevalidierung funktioniert

**Tipp**: Nutze  die bereits vorhandene Funktion `validiere_eingabe()` - sie kann bei der Überprüfung helfen!