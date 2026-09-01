In Python brauchst du das Schlüsselwort `global`, **wenn du innerhalb einer Funktion eine globale Variable neu zuweisen möchtest.** Wenn du sie nur **lesen** oder den **Inhalt eines veränderbaren Objekts** (z. B. Liste oder Dictionary) änderst, ist `global` nicht nötig.

## Grundregeln

### 1. Lesen erlaubt – kein `global` nötig:

Wenn du eine globale Variable nur verwenden (also lesen) willst, kannst du das direkt tun:


```python
x = 10

def zeige_x():
    print(x)  # funktioniert ohne 'global'
    
zeige_x()  # Ausgabe: 10
```

### 2. Verändern = `global` nötig:

Wenn du eine globale Variable innerhalb einer Funktion **neu zuweist**, musst du sie mit `global` deklarieren:


```python
x = 10

def setze_x():
    global x
    x = 20  # neue Zuweisung, daher 'global' nötig
    
print(f"Vor dem Funktionsaufruf: x = {x}")
setze_x()
print(f"Nach dem Funktionsaufruf: x = {x}")
```

## Was passiert ohne `global`?

Probieren wir aus, was ohne das `global` Schlüsselwort passiert:


```python
y = 10

def setze_y():
    # Ohne global
    try:
        y = 20  # Wird das funktionieren?
    except UnboundLocalError as e:
        print(f"Fehler: {e}")
    
setze_y()
print(f"y = {y}")  # y bleibt unverändert
```

## Warum das so ist

Ohne `global` denkt Python bei einer Zuweisung, dass du **eine neue lokale Variable** erzeugen willst – das führt zu einem Fehler, wenn vorher noch kein Wert definiert wurde.


```python
z = 10

def fehlerhafte_funktion():
    try:
        print(z)  # Das funktioniert noch (nur lesen)
        z = 20    # Aber hier kommt ein Fehler!
    except UnboundLocalError as e:
        print(f"Fehler: {e}")
        
fehlerhafte_funktion()
```

## Spezialfall: Mutable Objekte (Listen, Dictionaries)

Wenn du den **Inhalt** eines veränderbaren Objekts änderst (z.B. `.append()` bei einer Liste), brauchst du kein `global`, weil du nicht die Variable selbst, sondern **nur deren Inhalt** änderst:


```python
liste = []

def fuege_hinzu(wert):
    liste.append(wert)  # kein 'global' nötig
    
fuege_hinzu(42)
print(liste)  # Ausgabe: [42]
```

Aber wenn du die Liste komplett neu zuweisen willst:


```python
def ersetze_liste():
    global liste
    liste = [1, 2, 3]  # neue Zuweisung, daher 'global' nötig
    
ersetze_liste()
print(liste)  # Ausgabe: [1, 2, 3]
```

## Besser ohne `global`?

Ja, oft! Besser ist es meist, Werte über **Parameter und Rückgabewerte** zu übergeben:


```python
def inkrementiere(wert):
    return wert + 1

zähler = 0
zähler = inkrementiere(zähler)
print(zähler)  # Ausgabe: 1
```

## Zusammenfassung

- `global` nur verwenden, wenn du eine globale Variable neu zuweisen musst
- Für lesbaren und wartbaren Code besser Parameter und Rückgabewerte nutzen
- Bei veränderbaren Objekten (Listen, Dicts) kein `global` nötig, wenn nur der Inhalt geändert wird

```python

```
