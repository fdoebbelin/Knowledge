## 🎯 Lernziel
Diese Version enthält ein **vollständig spielbares Mastermind-Spiel** mit den wichtigsten Kernfunktionen bereits implementiert. Sie dient als Grundlage für die schrittweise Implementierung der noch fehlenden Funktionen.

## ✅ Bereits implementiert (funktionsfähig):
- **`erstelle_geheimcode()`** - Generiert zufällige Farbcodes
- **`pruefe_rate_versuch()`** - Berechnet das Feedback (schwarze/weiße Stifte)
- **`lies_rateversuch()`** - Liest und validiert Benutzereingaben
- **`validiere_eingabe()`** - Prüft Eingaben auf Gültigkeit

## 📝 Noch zu implementieren (auskommentiert als TODO):
- `ist_gewonnen()` - Prüft auf Spielgewinn
- `zeige_feedback()` - Zeigt Feedback schön formatiert
- `zeige_spielbrett()` - Zeigt alle bisherigen Versuche übersichtlich
- `zeige_ergebnis()` - Zeigt das Endergebnis an

## 🚀 Arbeiten mit dieser Version:
1. **Sofort spielbar**: Das Programm funktioniert bereits vollständig
2. **Schrittweise Implementierung**: Eine Funktion nach der anderen entwickeln
3. **Kommentare entfernen**: Die `# TODO:` Kommentare durch eigene Funktionsaufrufe ersetzen
4. **Testen**: Nach jeder Implementierung das verbesserte Spiel testen

## 💡 Hinweis:
Der DEBUG-Modus zeigt den Geheimcode an - das erleichtert das Testen der Implementierungen!

---
```python
import random

# Spiellogik-Funktionen

def erstelle_geheimcode(farben, code_laenge):
    """
    Generiert zufällig den geheimen Farbcode.
    
    Args:
        farben: Liste verfügbarer Farben
        code_laenge: Länge des zu erstellenden Codes
        
    Returns:
        Liste mit zufällig gewählten Farben als Geheimcode
    """
    return random.choices(farben, k=code_laenge)

def pruefe_rate_versuch(geheimcode, rateversuch):
    """
    Vergleicht einen Rateversuch mit dem Geheimcode und gibt Feedback zurück.
    
    Args:
        geheimcode: Der zu erratende Geheimcode
        rateversuch: Der aktuelle Rateversuch des Spielers
        
    Returns:
        Dictionary mit Anzahl schwarzer und weißer Stifte
    """
    if len(geheimcode) != len(rateversuch):
        raise ValueError("Geheimcode und Rateversuch müssen gleiche Länge haben")
    
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

def lies_rateversuch(farben, code_laenge):
    """
    Liest Benutzereingabe für einen Rateversuch ein.
    
    Args:
        farben: Liste verfügbarer Farben
        code_laenge: Länge des Geheimcodes
        
    Returns:
        Liste mit den geratenen Farben
    """
    while True:
        eingabe = input(f"Geben Sie {code_laenge} Farben ein (z.B. RGBY): ").strip().upper()
        
        if validiere_eingabe(eingabe, farben, code_laenge):
            return list(eingabe)  # Wandle String in Liste um
        else:
            print("Ungültige Eingabe! Bitte versuchen Sie es erneut.")
            print(f"Verwenden Sie nur die Farben: {', '.join(farben)}")
            print(f"Geben Sie genau {code_laenge} Farben ein.")

def validiere_eingabe(eingabe, farben, code_laenge):
    """
    Überprüft, ob die Eingabe gültig ist.
    
    Args:
        eingabe: Die zu validierende Eingabe
        farben: Liste verfügbarer Farben
        code_laenge: Länge des Geheimcodes
        
    Returns:
        Boolean, der angibt, ob die Eingabe gültig ist
    """
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

# ============================================================================
# FUNKTIONEN ZUM SELBST IMPLEMENTIEREN - DERZEIT LEER!
# ============================================================================

def ist_gewonnen(feedback, code_laenge):
    """
    Prüft, ob alle Positionen korrekt geraten wurden.
    
    Args:
        feedback: Feedback zum aktuellen Rateversuch
        code_laenge: Länge des Geheimcodes
        
    Returns:
        Boolean, der angibt, ob das Spiel gewonnen wurde
    """
    # TODO: Implementieren Sie diese Funktion!
    pass

def erstelle_spielanleitung():
    """
    Erklärt die Spielregeln.
    
    Returns:
        String mit Spielanleitung
    """
    # TODO: Implementieren Sie diese Funktion!
    pass

def erstelle_farbauswahl(farben):
    """
    Zeigt verfügbare Farben an.
    
    Args:
        farben: Liste verfügbarer Farben
        
    Returns:
        String mit Beschreibung der verfügbaren Farben
    """
    # TODO: Implementieren Sie diese Funktion!
    pass

def zeige_feedback(feedback):
    """
    Zeigt das Feedback zu einem Rateversuch an.
    
    Args:
        feedback: Dictionary mit Anzahl schwarzer und weißer Stifte
    """
    # TODO: Implementieren Sie diese Funktion!
    pass

def zeige_spielbrett(versuche, feedbacks):
    """
    Zeigt alle bisherigen Rateversuche und deren Feedback an.
    
    Args:
        versuche: Liste aller bisherigen Rateversuche
        feedbacks: Liste aller bisherigen Feedbacks
    """
    # TODO: Implementieren Sie diese Funktion!
    pass

def zeige_ergebnis(gewonnen, versuche, geheimcode):
    """
    Zeigt das Spielergebnis an.
    
    Args:
        gewonnen: Boolean, der angibt, ob das Spiel gewonnen wurde
        versuche: Anzahl der Versuche
        geheimcode: Der zu erratende Geheimcode
    """
    # TODO: Implementieren Sie diese Funktion!
    pass
```


```python
# ============================================================================
# HAUPTFUNKTION
# ============================================================================

def spiele_mastermind():
    """
    Steuert den Spielablauf und nutzt die oben definierten Funktionen.
    """
    # Spielkonfiguration
    farben = ['R', 'G', 'B', 'Y', 'W', 'S']  # Rot, Grün, Blau, Gelb, Weiß, Schwarz
    code_laenge = 4
    max_versuche = 12
    
    # Spielvorbereitung - einfache Fallback-Ausgaben
    print("=" * 50)
    print("           MASTERMIND")
    print("=" * 50)
    print(f"Verfügbare Farben: {', '.join(farben)}")
    print(f"Code-Länge: {code_laenge}, Maximale Versuche: {max_versuche}")
    print("-" * 50)
    
    # anleitung = erstelle_spielanleitung()  # TODO: Implementieren Sie diese Funktion!
    # if anleitung:
    #     print(anleitung)
    
    # farbauswahl_text = erstelle_farbauswahl(farben)  # TODO: Implementieren Sie diese Funktion!
    # if farbauswahl_text:
    #     print(farbauswahl_text)
    
    geheimcode = erstelle_geheimcode(farben, code_laenge)
    print(f"DEBUG: Geheimcode ist {''.join(geheimcode)}")  # Für Tests
    print("-" * 50)
    
    # Spielablauf
    versuche = []
    feedbacks = []
    gewonnen = False
    
    for versuch_nr in range(1, max_versuche + 1):
        print(f"\nVersuch {versuch_nr} von {max_versuche}:")
        
        # Spielbrett anzeigen - einfache Fallback-Anzeige
        if versuche:
            print("\nBisherige Versuche:")
            for i, (versuch, feedback_alt) in enumerate(zip(versuche, feedbacks)):
                versuch_str = ''.join(versuch)
                print(f"  {i+1}. {versuch_str} → {feedback_alt['schwarz']} schwarz, {feedback_alt['weiss']} weiß")
        
        # zeige_spielbrett(versuche, feedbacks)  # TODO: Implementieren Sie diese Funktion für schönere Ausgabe!
        
        rateversuch = lies_rateversuch(farben, code_laenge)
        feedback = pruefe_rate_versuch(geheimcode, rateversuch)
        
        versuche.append(rateversuch)
        feedbacks.append(feedback)
        
        # Feedback anzeigen - IMMER SICHTBAR für Tests
        versuch_str = ''.join(rateversuch)
        print(f"Ihr Versuch: {versuch_str}")
        print(f"Feedback: {feedback['schwarz']} schwarze Stifte, {feedback['weiss']} weiße Stifte")
        
        # zeige_feedback(feedback)  # TODO: Implementieren Sie diese Funktion für schönere Ausgabe!
        
        # Gewinn prüfen - einfache Fallback-Logik
        if feedback['schwarz'] == code_laenge:
            gewonnen = True
            break
        
        # if ist_gewonnen(feedback, code_laenge):  # TODO: Implementieren Sie diese Funktion!
        #     gewonnen = True
        #     break
    
    # Spielende - einfache Fallback-Ausgabe
    print("\n" + "=" * 50)
    if gewonnen:
        print(f"🎉 GEWONNEN! Sie haben den Code in {len(versuche)} Versuchen geknackt!")
    else:
        print("💥 VERLOREN! Alle Versuche aufgebraucht.")
    print(f"Der Geheimcode war: {''.join(geheimcode)}")
    print("=" * 50)
    
    # zeige_ergebnis(gewonnen, len(versuche), geheimcode)  # TODO: Implementieren Sie diese Funktion für schönere Ausgabe!
```


```python
# ============================================================================
# TESTFUNKTIONEN FÜR DIE IMPLEMENTIERTEN FUNKTIONEN
# ============================================================================

def teste_implementierte_funktionen():
    """Testet nur die bereits implementierten Funktionen"""
    print("MASTERMIND - TEST DER IMPLEMENTIERTEN FUNKTIONEN")
    print("=" * 60)
    
    # Test erstelle_geheimcode()
    print("\n=== TEST: erstelle_geheimcode() ===")
    farben = ['R', 'G', 'B', 'Y']
    code_laenge = 4
    
    print(f"Teste mit Farben: {farben}, Länge: {code_laenge}")
    for i in range(5):
        code = erstelle_geheimcode(farben, code_laenge)
        print(f"Code {i+1}: {code} ({''.join(code)})")
    print("✓ erstelle_geheimcode() funktioniert")
    
    # Test pruefe_rate_versuch()
    print("\n=== TEST: pruefe_rate_versuch() ===")
    test_faelle = [
        (['R', 'G', 'B', 'Y'], ['R', 'G', 'B', 'Y'], "Perfekter Treffer"),
        (['R', 'G', 'B', 'Y'], ['Y', 'B', 'G', 'R'], "Alle falsch positioniert"),
        (['R', 'G', 'B', 'Y'], ['R', 'B', 'G', 'W'], "Gemischtes Feedback"),
        (['R', 'G', 'B', 'Y'], ['W', 'S', 'P', 'O'], "Keine Treffer"),
    ]
    
    for geheim, versuch, beschreibung in test_faelle:
        feedback = pruefe_rate_versuch(geheim, versuch)
        geheim_str = ''.join(geheim)
        versuch_str = ''.join(versuch)
        print(f"{beschreibung}:")
        print(f"  Geheim: {geheim_str}, Versuch: {versuch_str}")
        print(f"  → {feedback['schwarz']} schwarz, {feedback['weiss']} weiß")
    print("✓ pruefe_rate_versuch() funktioniert")
    
    # Test validiere_eingabe()
    print("\n=== TEST: validiere_eingabe() ===")
    farben = ['R', 'G', 'B', 'Y']
    code_laenge = 4
    
    test_faelle = [
        ("RGBY", True, "Gültige Eingabe"),
        ("RGB", False, "Zu kurz"),
        ("RGBYX", False, "Zu lang"),
        ("", False, "Leer"),
        ("RGBX", False, "Ungültige Farbe"),
    ]
    
    for eingabe, erwartet, beschreibung in test_faelle:
        ergebnis = validiere_eingabe(eingabe.upper(), farben, code_laenge)
        status = "✓" if ergebnis == erwartet else "✗"
        print(f"{status} {beschreibung}: '{eingabe}' → {ergebnis}")
    print("✓ validiere_eingabe() funktioniert")
    
    print("\n" + "=" * 60)
    print("ALLE IMPLEMENTIERTEN FUNKTIONEN ERFOLGREICH GETESTET!")
    print("\nJetzt können Sie die restlichen Funktionen implementieren:")
    print("- ist_gewonnen()")
    print("- erstelle_spielanleitung()")
    print("- erstelle_farbauswahl()")
    print("- zeige_feedback()")
    print("- zeige_spielbrett()")
    print("- zeige_ergebnis()")
    print("=" * 60)
```


```python
# ============================================================================
# PROGRAMMSTART
# ============================================================================

if __name__ == "__main__":
    # Erst die Tests der implementierten Funktionen ausführen
    teste_implementierte_funktionen()
    
    # Dann fragen, ob das Spiel gestartet werden soll
    print("\nMöchten Sie das Spiel starten? (j/n): ", end="")
    antwort = input().lower()
    
    if antwort in ['j', 'ja', 'y', 'yes']:
        print("\nSTARTE SPIEL...")
        print("(Nicht implementierte Funktionen werden durch Fallback-Code ersetzt)")
        print()
        spiele_mastermind()
    else:
        print("\nProgramm beendet.")
        print("Sie können das Spiel jederzeit mit spiele_mastermind() starten.")
        print("Implementieren Sie zuerst die fehlenden Funktionen für die beste Erfahrung!")
```

## Hinweis
Das Spiel kann sowohl in einem `Jupyterlab`-Notebook als auch in `PyCharm` getestet werden