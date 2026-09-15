## Zweck der Funktion

Die Funktion `validiere_eingabe()` ist der "Türsteher" des Spiels! Sie überprüft, ob die Eingabe des Spielers allen Spielregeln entspricht, bevor sie ins Spiel gelassen wird. Diese Funktion arbeitet Hand in Hand mit `lies_rateversuch()` zusammen.

## Funktionssignatur

```python
def validiere_eingabe(eingabe, farben, code_laenge):
    """
    Überprüft, ob die Eingabe gültig ist.
    
    Args:
        eingabe (str): Die zu validierende Eingabe des Spielers
        farben (list): Liste verfügbarer Farben (z.B. ['R', 'G', 'B', 'Y', 'W', 'S'])
        code_laenge (int): Erwartete Länge des Codes (normalerweise 4)
        
    Returns:
        bool: True wenn Eingabe gültig ist, False wenn nicht
    """
```

## Was die Funktion prüfen soll

Die Funktion führt eine **systematische Überprüfung** in folgender Reihenfolge durch:

### 1. **Basis-Checks**

- Ist die Eingabe überhaupt vorhanden? (nicht leer)
- Hat die Eingabe die richtige Länge?

### 2. **Inhalts-Checks**

- Sind alle eingegebenen Zeichen gültige Farbcodes?
- Kommen nur erlaubte Farben vor?

## Einfache Implementierung mit Python-Grundlagen

**Gute Nachricht**: Alle Prüfungen lassen sich mit einfachen Python-Befehlen umsetzen!

### Praktische Prüfungen:

```python
def validiere_eingabe(eingabe, farben, code_laenge):
    # 1. Leer-Check
    if not eingabe:
        return False
    
    # 2. Längen-Check  
    if len(eingabe) != code_laenge:
        return False
    
    # 3. Farben-Check
    for zeichen in eingabe:
        if zeichen not in farben:
            return False
    
    # Wenn alle Checks bestanden: Eingabe ist gültig
    return True
```

## Warum diese Funktion so wertvoll ist

### **Für `lies_rateversuch()`**

- Macht die Eingabefunktion sauberer und lesbarer
- Trennt Validierungslogik von Ein-/Ausgabe-Logik

### **Für das gesamte Spiel**

- **Zentrale Validierung**: Alle Regeln an einem Ort
- **Wiederverwendbar**: Kann auch in anderen Teilen des Programms genutzt werden
- **Testbar**: Einfach zu testen mit verschiedenen Eingaben

### **Für Dich als Programmierer**

- **Modularität**: Eine Funktion, eine Aufgabe
- **Debugging**: Fehler sind leichter zu finden
- **Erweiterbar**: Neue Validierungsregeln einfach hinzufügbar

## Verwendung in `lies_rateversuch()`

```python
def lies_rateversuch(farben, code_laenge):
    while True:
        eingabe = input(f"Geben Sie {code_laenge} Farben ein: ").strip().upper()
        
        if validiere_eingabe(eingabe, farben, code_laenge):
            return list(eingabe)  # Gültige Eingabe als Liste zurückgeben
        else:
            print("Ungültige Eingabe! Bitte versuchen Sie es erneut.")
```

**Tipp**: Diese Funktion ist ein perfektes Beispiel für das **Single Responsibility Principle** - eine Funktion, eine klare Aufgabe!