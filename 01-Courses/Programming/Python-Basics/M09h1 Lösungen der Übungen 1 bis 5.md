## Übung 1: Funktionsdefinition und -aufruf

### Aufgabe 1: Begrüßungsfunktion

#### Schritt 1: Grundlegendes Funktionsgerüst erstellen

```python
def begrüße_person(name):
    """Gibt einen personalisierten Begrüßungstext zurück."""
    # Hier kommt später der Code hin
    pass
```

#### Schritt 2: Implementierung hinzufügen

```python
def begrüße_person(name):
    """Gibt einen personalisierten Begrüßungstext zurück."""
    return "Hallo " + name + "! Schön, dich kennenzulernen."
```

```python
# Test mit einem einfachen Namen
begrüße_person("Max")
```

#### Schritt 3: Auf f-Strings umstellen (moderner Python-Stil)

```python
def begrüße_person(name):
    """Gibt einen personalisierten Begrüßungstext zurück."""
    return f"Hallo {name}! Schön, dich kennenzulernen."
```

#### Schritt 4: Testen der Funktion

```python
# Test mit einem einfachen Namen
begrüße_person("Max")
```

```python
# Test mit einem anderen Namen
begrüße_person("Anna")
```

### Aufgabe 2: Mehrwertsteuerberechnung

#### Schritt 1: Grundlegendes Funktionsgerüst erstellen

```python
def berechne_mehrwertsteuer(nettobetrag):
    """Berechnet den Bruttobetrag inklusive 19% Mehrwertsteuer."""
    # Hier kommt später der Code hin
    pass
```

#### Schritt 2: Implementierung hinzufügen

```python
def berechne_mehrwertsteuer(nettobetrag):
    """Berechnet den Bruttobetrag inklusive 19% Mehrwertsteuer."""
    return nettobetrag * 1.19
```

#### Schritt 3: Testen der Funktion

```python
# Test mit einem einfachen Betrag
berechne_mehrwertsteuer(100)
```

```python
# Test mit einem anderen Betrag
berechne_mehrwertsteuer(84.50)
```

#### Schritt 4: Erweiterung mit Rundung

```python
def berechne_mehrwertsteuer(nettobetrag, runden=True):
    """
    Berechnet den Bruttobetrag inklusive 19% Mehrwertsteuer.
    
    Args:
        nettobetrag: Der Nettobetrag ohne Mehrwertsteuer
        runden: Ob das Ergebnis auf 2 Nachkommastellen gerundet werden soll
    
    Returns:
        Der Bruttobetrag mit Mehrwertsteuer
    """
    bruttobetrag = nettobetrag * 1.19
    if runden:
        return round(bruttobetrag, 2)
    return bruttobetrag
```

```python
# Test mit Rundung
berechne_mehrwertsteuer(84.50)
```

## Übung 2: Parameter und Rückgabewerte

### Aufgabe 1: Personendaten erstellen

#### Schritt 1: Grundlegendes Funktionsgerüst

```python
def erstelle_personendaten(vorname, nachname):
    """Erstellt ein Personen-Dictionary mit den angegebenen Daten."""
    # Hier kommt später der Code hin
    pass
```

#### Schritt 2: Standardparameter hinzufügen

```python
def erstelle_personendaten(vorname, nachname, alter=30, stadt="Berlin"):
    """Erstellt ein Personen-Dictionary mit den angegebenen Daten."""
    # Hier kommt später der Code hin
    pass
```

#### Schritt 3: Implementierung hinzufügen

```python
def erstelle_personendaten(vorname, nachname, alter=30, stadt="Berlin"):
    """Erstellt ein Personen-Dictionary mit den angegebenen Daten."""
    return {
        "vorname": vorname,
        "nachname": nachname,
        "alter": alter,
        "stadt": stadt
    }
```

#### Schritt 4: Testen der Funktion

```python
# Test mit Pflichtparametern
erstelle_personendaten("Max", "Mustermann")
```

```python
# Test mit allen Parametern
erstelle_personendaten("Anna", "Schmidt", 25, "München")
```

```python
# Test mit benannten Parametern
erstelle_personendaten(vorname="Julia", nachname="Weber", stadt="Hamburg")
```
### Aufgabe 2: Statistik-Funktion

#### Schritt 1: Grundlegendes Funktionsgerüst

```python
def berechne_statistik(zahlen):
    """Berechnet statistische Werte für eine Liste von Zahlen."""
    # Hier kommt später der Code hin
    pass
```

#### Schritt 2: Fehlerbehebung für Randfälle

```python
def berechne_statistik(zahlen):
    """Berechnet statistische Werte für eine Liste von Zahlen."""
    if not zahlen:
        return {"fehler": "Die Liste darf nicht leer sein"}
    
    # Hier kommt später der restliche Code hin
    pass
```

#### Schritt 3: Implementierung der Berechnung

```python
def berechne_statistik(zahlen):
    """Berechnet statistische Werte für eine Liste von Zahlen."""
    if not zahlen:
        return {"fehler": "Die Liste darf nicht leer sein"}
    
    anzahl = len(zahlen)
    summe = sum(zahlen)
    
    return {
        "minimum": min(zahlen),
        "maximum": max(zahlen),
        "durchschnitt": summe / anzahl,
        "summe": summe
    }
```

#### Schritt 4: Testen der Funktion

```python
# Test mit normaler Zahlenliste
berechne_statistik([1, 2, 3, 4, 5])
```

```python
# Test mit leerer Liste
berechne_statistik([])
```

```python
# Test mit negativen Zahlen
berechne_statistik([-10, 0, 10, 20])
```

## Übung 3: Lokale vs. globale Variablen

### Aufgabe 1: Zähler mit globaler Variable

#### Schritt 1: Grundlegendes Funktionsgerüst

```python
# Globale Variable
zaehler = 0

def inkrementiere_zaehler():
    """Erhöht den globalen Zähler um 1 und gibt den neuen Wert zurück."""
    # Hier kommt später der Code hin
    pass
```

#### Schritt 2: Implementierung mit global-Schlüsselwort

```python
# Globale Variable
zaehler = 0

def inkrementiere_zaehler():
    """Erhöht den globalen Zähler um 1 und gibt den neuen Wert zurück."""
    global zaehler
    zaehler += 1
    return zaehler
```

#### Schritt 3: Testen des Zählers

```python
# Test des Zählers
inkrementiere_zaehler()
```

```python
inkrementiere_zaehler()
```

```python
inkrementiere_zaehler()
```

### Aufgabe 2: Zähler mit Closure

#### Schritt 1: Grundlegendes Funktionsgerüst

```python
def erstelle_zaehler():
    """Erstellt einen gekapselten Zähler als Closure."""
    # Hier kommt später der Code hin
    pass
```

#### Schritt 2: Innere Funktion hinzufügen

```python
def erstelle_zaehler():
    """Erstellt einen gekapselten Zähler als Closure."""
    count = 0
    
    def inkrementiere():
        """Erhöht den Zähler um 1 und gibt den neuen Wert zurück."""
        # Hier kommt später der Code hin
        pass
    
    return inkrementiere
```

#### Schritt 3: nonlocal-Schlüsselwort verwenden

```python
def erstelle_zaehler():
    """Erstellt einen gekapselten Zähler als Closure."""
    count = 0
    
    def inkrementiere():
        """Erhöht den Zähler um 1 und gibt den neuen Wert zurück."""
        nonlocal count
        count += 1
        return count
    
    return inkrementiere
```

#### Schritt 4: Testen des Closures

```python
# Erstellen eines Zählers
zaehler1 = erstelle_zaehler()

# Testen des ersten Zählers
zaehler1()
```

```python
zaehler1()
```

```python
# Erstellen eines zweiten, unabhängigen Zählers
zaehler2 = erstelle_zaehler()

# Testen des zweiten Zählers
zaehler2()
```

```python
# Der erste Zähler behält seinen eigenen Zustand
zaehler1()
```

## Übung 4: Dokumentation von Funktionen

### Aufgabe: Dokumentieren der Statistik-Funktion

#### Schritt 1: Grundlegende Dokumentation hinzufügen

```python
def berechne_statistik(zahlen):
    """
    Berechnet statistische Werte für eine Liste von Zahlen.
    """
    if not zahlen:
        return {"fehler": "Die Liste darf nicht leer sein"}
    
    anzahl = len(zahlen)
    summe = sum(zahlen)
    
    return {
        "minimum": min(zahlen),
        "maximum": max(zahlen),
        "durchschnitt": summe / anzahl,
        "summe": summe
    }
```

#### Schritt 2: Detaillierte Beschreibung hinzufügen

```python
def berechne_statistik(zahlen):
    """
    Berechnet statistische Werte für eine Liste von Zahlen.
    
    Diese Funktion nimmt eine Liste von Zahlen entgegen und berechnet
    verschiedene statistische Werte: Minimum, Maximum, Durchschnitt und Summe.
    """
    if not zahlen:
        return {"fehler": "Die Liste darf nicht leer sein"}
    
    anzahl = len(zahlen)
    summe = sum(zahlen)
    
    return {
        "minimum": min(zahlen),
        "maximum": max(zahlen),
        "durchschnitt": summe / anzahl,
        "summe": summe
    }
```

#### Schritt 3: Parameter und Rückgabewerte dokumentieren

```python
def berechne_statistik(zahlen):
    """
    Berechnet statistische Werte für eine Liste von Zahlen.
    
    Diese Funktion nimmt eine Liste von Zahlen entgegen und berechnet
    verschiedene statistische Werte: Minimum, Maximum, Durchschnitt und Summe.
    
    Args:
        zahlen (list): Eine Liste von Zahlen (int oder float)
        
    Returns:
        dict: Ein Dictionary mit den folgenden Schlüsseln:
            - minimum: Der kleinste Wert in der Liste
            - maximum: Der größte Wert in der Liste
            - durchschnitt: Der arithmetische Mittelwert der Liste
            - summe: Die Summe aller Werte in der Liste
    """
    if not zahlen:
        return {"fehler": "Die Liste darf nicht leer sein"}
    
    anzahl = len(zahlen)
    summe = sum(zahlen)
    
    return {
        "minimum": min(zahlen),
        "maximum": max(zahlen),
        "durchschnitt": summe / anzahl,
        "summe": summe
    }
```

#### Schritt 4: Ausnahmen und Beispiele hinzufügen

```python
def berechne_statistik(zahlen):
    """
    Berechnet statistische Werte für eine Liste von Zahlen.
    
    Diese Funktion nimmt eine Liste von Zahlen entgegen und berechnet
    verschiedene statistische Werte: Minimum, Maximum, Durchschnitt und Summe.
    
    Args:
        zahlen (list): Eine Liste von Zahlen (int oder float)
        
    Returns:
        dict: Ein Dictionary mit den folgenden Schlüsseln:
            - minimum: Der kleinste Wert in der Liste
            - maximum: Der größte Wert in der Liste
            - durchschnitt: Der arithmetische Mittelwert der Liste
            - summe: Die Summe aller Werte in der Liste
            
    Raises:
        ValueError: Wenn die Liste leer ist
        
    Examples:
        >>> berechne_statistik([1, 2, 3, 4, 5])
        {'minimum': 1, 'maximum': 5, 'durchschnitt': 3.0, 'summe': 15}
        
        >>> berechne_statistik([10, 20, 30])
        {'minimum': 10, 'maximum': 30, 'durchschnitt': 20.0, 'summe': 60}
    """
    if not zahlen:
        raise ValueError("Die Liste darf nicht leer sein")
    
    anzahl = len(zahlen)
    summe = sum(zahlen)
    
    return {
        "minimum": min(zahlen),
        "maximum": max(zahlen),
        "durchschnitt": summe / anzahl,
        "summe": summe
    }
```

#### Schritt 5: Testen der dokumentierten Funktion

```python
# Test mit normaler Zahlenliste
berechne_statistik([1, 2, 3, 4, 5])
```

```python
# Test mit Fehlerbehandlung
try:
    berechne_statistik([])
except ValueError as e:
    print(f"Fehler: {e}")
```

```python
# Anzeigen der Dokumentation
help(berechne_statistik)
```

## Übung 5: Testbare Funktionen

### E-Mail-Validierungsfunktion

#### Schritt 1: Grundlegendes Funktionsgerüst

```python
def validiere_email(email):
    """
    Prüft, ob eine E-Mail-Adresse gültig ist.
    """
    # Hier kommt später der Code hin
    pass
```

#### Schritt 2: Grundlegende Validierung implementieren

```python
def validiere_email(email):
    """
    Prüft, ob eine E-Mail-Adresse gültig ist.
    
    Eine E-Mail-Adresse wird als gültig betrachtet, wenn sie ein @-Zeichen enthält.
    """
    if not isinstance(email, str):
        return False
    
    # Prüfen, ob ein @-Zeichen vorhanden ist
    if "@" not in email:
        return False
    
    return True
```

#### Schritt 3: Domain-Validierung hinzufügen

```python
def validiere_email(email):
    """
    Prüft, ob eine E-Mail-Adresse gültig ist.
    
    Eine E-Mail-Adresse wird als gültig betrachtet, wenn sie:
    - Ein @-Zeichen enthält
    - Mindestens einen Punkt im Domain-Teil enthält
    """
    if not isinstance(email, str):
        return False
    
    # Prüfen, ob ein @-Zeichen vorhanden ist
    if "@" not in email:
        return False
    
    # Lokalen Teil und Domain-Teil aufteilen
    local_part, domain = email.split("@", 1)
    
    # Prüfen, ob ein Punkt im Domain-Teil vorkommt
    if "." not in domain:
        return False
    
    return True
```

#### Schritt 4: Weitere Validierungen hinzufügen

```python
def validiere_email(email):
    """
    Prüft, ob eine E-Mail-Adresse gültig ist.
    
    Eine E-Mail-Adresse wird als gültig betrachtet, wenn sie:
    - Ein @-Zeichen enthält
    - Mindestens einen Punkt im Domain-Teil enthält
    - Mindestens ein Zeichen vor dem @-Zeichen hat
    - Mindestens ein Zeichen zwischen @ und Punkt hat
    - Mindestens ein Zeichen nach dem letzten Punkt hat
    
    Args:
        email (str): Die zu prüfende E-Mail-Adresse
        
    Returns:
        bool: True, wenn die E-Mail-Adresse gültig ist, sonst False
    """
    if not isinstance(email, str):
        return False
    
    # Prüfen, ob ein @-Zeichen vorhanden ist
    if "@" not in email:
        return False
    
    # Lokalen Teil und Domain-Teil aufteilen
    local_part, domain = email.split("@", 1)
    
    # Prüfen, ob der lokale Teil nicht leer ist
    if not local_part:
        return False
    
    # Prüfen, ob ein Punkt im Domain-Teil vorkommt
    if "." not in domain:
        return False
    
    # Domain und TLD aufteilen
    domain_parts = domain.split(".")
    
    # Prüfen, ob alle Domain-Teile nicht leer sind
    if "" in domain_parts:
        return False
    
    return True
```

#### Schritt 5: Testfälle erstellen

```python
def teste_email_validierung():
    """Führt Testfälle für die E-Mail-Validierungsfunktion durch."""
    test_cases = [
        # Gültige E-Mails
        ("test@example.com", True),
        ("user.name@domain.com", True),
        ("user+tag@example.org", True),
        ("a@b.c", True),
        ("email@example-domain.com", True),
        
        # Ungültige E-Mails
        ("", False),
        ("no_at_sign.com", False),
        ("@missing-local.org", False),
        ("missing-domain@", False),
        ("missing.domain.tld@domain", False),
        ("two@@at.com", False),
        ("user@.com", False),
        ("user@domain.", False),
        (123, False)  # Keine Zeichenkette
    ]
    
    print("=== E-Mail-Validierungstests ===")
    for i, (email, expected) in enumerate(test_cases, 1):
        result = validiere_email(email)
        success = result == expected
        status = "✓" if success else "✗"
        print(f"Test {i}: {status} - '{email}' => {result} (erwartet: {expected})")
    
    # Zusammenfassung
    erfolge = sum(1 for email, expected in test_cases if validiere_email(email) == expected)
    print(f"\nErgebnis: {erfolge} von {len(test_cases)} Tests bestanden")
```

#### Schritt 6: Tests ausführen

```python
# Tests ausführen
teste_email_validierung()
```

#### Schritt 7: Dokumentation und Tests verbessern

```python
def validiere_email(email):
    """
    Prüft, ob eine E-Mail-Adresse gültig ist.
    
    Eine E-Mail-Adresse wird als gültig betrachtet, wenn sie:
    - Ein @-Zeichen enthält
    - Mindestens einen Punkt im Domain-Teil enthält
    - Mindestens ein Zeichen vor dem @-Zeichen hat
    - Mindestens ein Zeichen zwischen @ und Punkt hat
    - Mindestens ein Zeichen nach dem letzten Punkt hat
    
    Args:
        email (str): Die zu prüfende E-Mail-Adresse
        
    Returns:
        bool: True, wenn die E-Mail-Adresse gültig ist, sonst False
        
    Examples:
        >>> validiere_email("test@example.com")
        True
        >>> validiere_email("invalid@")
        False
    """
    if not isinstance(email, str):
        return False
    
    # Prüfen, ob ein @-Zeichen vorhanden ist
    if "@" not in email:
        return False
    
    # Lokalen Teil und Domain-Teil aufteilen
    local_part, domain = email.split("@", 1)
    
    # Prüfen, ob der lokale Teil nicht leer ist
    if not local_part:
        return False
    
    # Prüfen, ob ein Punkt im Domain-Teil vorkommt
    if "." not in domain:
        return False
    
    # Domain und TLD aufteilen
    domain_parts = domain.split(".")
    
    # Prüfen, ob alle Domain-Teile nicht leer sind
    if "" in domain_parts:
        return False
    
    return True
```

```python
# Erweiterte Testfunktion mit detaillierter Ausgabe
def teste_email_validierung():
    """
    Führt Testfälle für die E-Mail-Validierungsfunktion durch und gibt detaillierte Ergebnisse zurück.
    
    Returns:
        dict: Ein Dictionary mit Testergebnissen und einer Zusammenfassung
    """
    test_cases = [
        # Gültige E-Mails
        ("test@example.com", True),
        ("user.name@domain.com", True),
        ("user+tag@example.org", True),
        ("a@b.c", True),
        ("email@example-domain.com", True),
        
        # Ungültige E-Mails
        ("", False),
        ("no_at_sign.com", False),
        ("@missing-local.org", False),
        ("missing-domain@", False),
        ("missing.domain.tld@domain", False),
        ("two@@at.com", False),
        ("user@.com", False),
        ("user@domain.", False),
        (123, False)  # Keine Zeichenkette
    ]
    
    results = []
    for email, expected in test_cases:
        try:
            actual = validiere_email(email)
            success = actual == expected
            results.append({
                "email": email,
                "expected": expected,
                "actual": actual,
                "success": success
            })
        except Exception as e:
            results.append({
                "email": email,
                "expected": expected,
                "error": str(e),
                "success": False
            })
    
    success_count = sum(1 for result in results if result["success"])
    total_count = len(results)
    
    return {
        "results": results,
        "summary": f"{success_count} von {total_count} Tests bestanden"
    }
```

```python
# Tests ausführen und ergebnisse anzeigen
ergebnisse = teste_email_validierung()
print(ergebnisse["summary"])

# Einige Testergebnisse anzeigen
for i, result in enumerate(ergebnisse["results"][:5], 1):
    print(f"Test {i}: {result['email']} => {'Erfolgreich' if result['success'] else 'Fehlgeschlagen'}")
```

## Zusammenfassung der inkrementellen Entwicklung

Der inkrementelle Entwicklungsansatz in JupyterLab bietet mehrere Vorteile:

1. **Schrittweise Verbesserung**: Von einfachen Funktionsgerüsten bis zu vollständigen Implementierungen
2. **Sofortiges Feedback**: Testen nach jedem Entwicklungsschritt
3. **Fehlersuche**: Probleme können frühzeitig erkannt und behoben werden
4. **Dokumentation des Prozesses**: Der Entwicklungsprozess selbst wird dokumentiert
5. **Visuelle Überprüfung**: Ergebnisse werden direkt angezeigt

Diese Methode ist besonders nützlich für das Erlernen neuer Konzepte und das Prototyping komplexer Funktionen.
