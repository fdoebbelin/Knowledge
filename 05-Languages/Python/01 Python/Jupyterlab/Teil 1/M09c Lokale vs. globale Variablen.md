Variablen in Python haben unterschiedliche Sichtbarkeitsbereiche (Scopes), die bestimmen, von wo aus auf diese Variablen zugegriffen werden kann. Die beiden wichtigsten Konzepte sind:

- **Lokale Variablen**: Nur innerhalb der Funktion sichtbar, in der sie definiert wurden
- **Globale Variablen**: Im gesamten Modul/Programm sichtbar

## Grundlegender Unterschied zwischen lokalen und globalen Variablen

```python
def demonstriere_variablen_scopes():
    """Zeigt den Unterschied zwischen lokalen und globalen Variablen."""
    # Eine lokale Variable wird innerhalb der Funktion definiert
    lokale_var = "Ich bin lokal"
    
    # Output zusammenstellen
    resultat = [
        f"Innerhalb der Funktion:",
        f"Lokale Variable: {lokale_var}"
    ]
    
    # Versuchen, auf die globale Variable zuzugreifen
    try:
        resultat.append(f"Globale Variable: {globale_var}")
    except NameError:
        resultat.append("Globale Variable ist nicht definiert oder nicht sichtbar")
    
    return "\n".join(resultat)
```

```python
# Aufruf der Funktion (vor Definition einer globalen Variable)
print(demonstriere_variablen_scopes())
```

Nun definieren wir eine globale Variable und rufen die Funktion erneut auf:

```python
# Globale Variable definieren
globale_var = "Ich bin global"

# Aufruf der Funktion (nach Definition der globalen Variable)
print(demonstriere_variablen_scopes())
```

## Verwendung des `global`-Schlüsselworts

Das `global`-Schlüsselwort erlaubt es, innerhalb einer Funktion auf eine globale Variable zuzugreifen und diese zu ändern.

```python
def modifiziere_globale_variable():
    """Demonstriert die Verwendung des global-Schlüsselworts."""
    # Das global-Schlüsselwort teilt Python mit, dass wir die globale 
    # Variable verwenden möchten und nicht eine neue lokale Variable erstellen
    global globale_var
    
    # Wert vor der Änderung
    original_wert = globale_var
    
    # Wert ändern
    globale_var = "Ich wurde in der Funktion geändert"
    
    return f"Ursprünglicher Wert: {original_wert}\nNeuer Wert: {globale_var}"
```

```python
# Globale Variable definieren (oder zurücksetzen)
globale_var = "Ich bin global"

# Aufruf der Funktion, die die globale Variable modifiziert
print(modifiziere_globale_variable())
```

```python
# Überprüfen, ob die globale Variable tatsächlich geändert wurde
print(globale_var)
```

## Was passiert ohne das `global`-Schlüsselwort?

```python
def versuche_globale_variable_zu_ändern():
    """Zeigt, was passiert, wenn man das global-Schlüsselwort weglässt."""
    try:
        # Versuch, die globale Variable zu ändern ohne global-Schlüsselwort
        globale_var = "Neuer Wert ohne global-Schlüsselwort"
        return f"Wert innerhalb der Funktion: {globale_var}"
    except Exception as e:
        return f"Fehler: {e}"
```

```python
# Globale Variable definieren (oder zurücksetzen)
globale_var = "Ich bin global"

# Aufruf der Funktion ohne global-Schlüsselwort
versuche_globale_variable_zu_ändern()
```

```python
# Überprüfen, ob die globale Variable geändert wurde
print(globale_var)
```

Ohne das `global`-Schlüsselwort erstellt Python eine neue lokale Variable mit demselben Namen, anstatt die globale Variable zu ändern.

## Verschachtelte Funktionen und das `nonlocal`-Schlüsselwort

Bei verschachtelten Funktionen kann mit dem `nonlocal`-Schlüsselwort auf Variablen aus der umgebenden Funktion zugegriffen werden.

```python
def äußere_funktion():
    """Demonstriert verschachtelte Funktionen und das nonlocal-Schlüsselwort."""
    x = "Wert in der äußeren Funktion"
    
    def innere_funktion():
        """Eine verschachtelte Funktion, die auf die Variable der äußeren Funktion zugreift."""
        # Wir können auf x lesend zugreifen
        return f"Lesender Zugriff innerhalb der inneren Funktion: {x}"
    
    resultat = [
        f"Wert in der äußeren Funktion: {x}",
        innere_funktion()
    ]
    
    return "\n".join(resultat)
```

```python
# Aufruf der äußeren Funktion
print(äußere_funktion())
```

Nun versuchen wir, die Variable der äußeren Funktion zu ändern:

```python
def äußere_funktion_mit_modifikation():
    """Demonstriert das nonlocal-Schlüsselwort."""
    x = "Ursprünglicher Wert in der äußeren Funktion"
    
    def innere_funktion_mit_modifikation():
        """Eine verschachtelte Funktion, die die Variable der äußeren Funktion ändert."""
        nonlocal x
        x = "Geänderter Wert durch die innere Funktion"
        return f"Wert nach Änderung in der inneren Funktion: {x}"
    
    resultat = [
        f"Wert zu Beginn in der äußeren Funktion: {x}",
        innere_funktion_mit_modifikation(),
        f"Wert am Ende in der äußeren Funktion: {x}"
    ]
    
    return "\n".join(resultat)
```

```python
# Aufruf der äußeren Funktion mit Modifikation
print(äußere_funktion_mit_modifikation())
```

## Was passiert ohne das `nonlocal`-Schlüsselwort?

```python
def äußere_funktion_ohne_nonlocal():
    """Zeigt, was passiert, wenn man das nonlocal-Schlüsselwort weglässt."""
    x = "Ursprünglicher Wert in der äußeren Funktion"
    
    def innere_funktion_ohne_nonlocal():
        """Eine verschachtelte Funktion, die versucht, die Variable der äußeren Funktion zu ändern."""
        try:
            # Dies würde eine neue lokale Variable x erstellen
            x = "Versuchter neuer Wert"
            return f"Wert in der inneren Funktion: {x}"
        except UnboundLocalError as e:
            return f"Fehler: {e}"
    
    resultat = [
        f"Wert zu Beginn in der äußeren Funktion: {x}",
        innere_funktion_ohne_nonlocal(),
        f"Wert am Ende in der äußeren Funktion: {x}"
    ]
    
    return "\n".join(resultat)
```

```python
# Aufruf der äußeren Funktion ohne nonlocal
print(äußere_funktion_ohne_nonlocal())
```

Ohne das `nonlocal`-Schlüsselwort wird eine neue lokale Variable erstellt, anstatt die Variable der umgebenden Funktion zu ändern.

## Praktisches Beispiel: Einen Zähler mit einer Closure implementieren

Eine nützliche Anwendung des `nonlocal`-Schlüsselworts ist die Implementierung eines Zählers mit einer Closure (Abschlussfunktion).

```python
def erstelle_zähler(start_wert=0):
    """
    Erstellt einen Zähler, der bei jedem Aufruf inkrementiert wird.
    
    Args:
        start_wert: Der Anfangswert des Zählers (Standard: 0)
        
    Returns:
        Eine Funktion, die bei jedem Aufruf den Zähler inkrementiert und zurückgibt
    """
    zähler = start_wert
    
    def inkrementiere():
        """Erhöht den Zähler um 1 und gibt den neuen Wert zurück."""
        nonlocal zähler
        zähler += 1
        return zähler
    
    return inkrementiere
```

```python
# Einen Zähler erstellen
mein_zähler = erstelle_zähler(start_wert=5)

# Den Zähler mehrmals aufrufen
print(mein_zähler())  # Sollte 6 ausgeben
print(mein_zähler())  # Sollte 7 ausgeben
print(mein_zähler())  # Sollte 8 ausgeben
```

```python
# wichtig wenn einer Variablen ein Funktionswert zugewiesen wurde, kann sie wie eine normale Funktion benutzt werden
print(mein_zähler)
print(mein_zähler())
neuer_zähler = mein_zähler
print(neuer_zähler())
```

```python
# Einen zweiten Zähler erstellen (unabhängig vom ersten)
zweiter_zähler = erstelle_zähler()

# Den zweiten Zähler aufrufen
print(zweiter_zähler())  # Sollte 1 ausgeben
print(zweiter_zähler())  # Sollte 2 ausgeben

# Der erste Zähler ist davon nicht betroffen
print(mein_zähler())  # Sollte 9 ausgeben
```

## Empfehlungen zum Umgang mit Variablen

1. **Vermeiden Sie zu viele globale Variablen**:
   - Globale Variablen können zu schwer nachvollziehbarem Code führen
   - Sie erschweren das Testen von Funktionen
   - Sie können zu unerwarteten Seiteneffekten führen

2. **Bevorzugen Sie lokale Variablen**:
   - Der Gültigkeitsbereich ist klar definiert
   - Sie werden automatisch aufgeräumt, wenn die Funktion endet
   - Sie verhindern unbeabsichtigte Änderungen

3. **Verwenden Sie Parameter für die Eingabe und Rückgabewerte für die Ausgabe**:
   - Das macht Funktionen klarer und leichter zu testen
   - Es reduziert Abhängigkeiten und Seiteneffekte

4. **Nutzen Sie Closures für zustandsbehaftete Funktionen**:
   - Wie im Zähler-Beispiel gezeigt, können Closures einen internen Zustand kapseln
   - Dies ist eine sauberere Alternative zu globalen Variablen

## Weitere Ressourcen

- [Python Dokumentation: Scopes and Namespaces](https://docs.python.org/3/tutorial/classes.html#python-scopes-and-namespaces)
- [Python LEGB Rule - Lokale, Enclosing, Globale und Built-in Scopes](https://realpython.com/python-scope-legb-rule/)
