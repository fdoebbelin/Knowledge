# Funktionsdefinition und -aufruf

Funktionen sind wiederverwendbare Codeblöcke, die spezifische Aufgaben ausführen. Sie ermöglichen es, Code zu strukturieren und Wiederholungen zu vermeiden.

## Grundlegende Funktionsdefinition

Eine Funktion wird mit dem Schlüsselwort `def` gefolgt vom Funktionsnamen und Klammern definiert. Der Funktionsblock beginnt nach einem Doppelpunkt und ist eingerückt.

```python
def demonstriere_einfache_funktion():
    """Demonstriert die grundlegende Funktionsdefinition und -aufruf."""
    ergebnis = "Dies ist eine einfache Funktion ohne Parameter"
    return ergebnis
```

## Funktionsaufruf

Funktionen werden durch Angabe ihres Namens gefolgt von Klammern aufgerufen.

```python
# Aufruf der einfachen Funktion
demonstriere_einfache_funktion()
```

## Funktionen mit Parametern

Parameter sind Variablen, die beim Funktionsaufruf übergeben werden können. Sie stehen in den Klammern der Funktionsdefinition.

```python
def berechne_summe(a, b):
    """Berechnet die Summe zweier Zahlen."""
    summe = a + b
    return summe
```

```python
# Aufruf mit konkreten Werten: a=5, b=7
berechne_summe(5, 7)
```

## Benannte Parameter

Bei der Übergabe von Parametern kann der Parametername explizit angegeben werden. Dies erhöht die Lesbarkeit, besonders bei Funktionen mit vielen Parametern.

```python
def formatiere_name(vorname, nachname):
    """Formatiert Vor- und Nachname in einem standardisierten Format."""
    formatierter_name = f"{nachname}, {vorname}"
    return formatierter_name
```

```python
# Aufruf ohne benannten Parametern
formatiere_name("Max", "Mustermann")
```

```python
# Aufruf mit benannten Parametern
formatiere_name(vorname="Max", nachname="Mustermann")
```

```python
# Aufruf mit benannten Parametern, Reihenfolge umgekehrt
formatiere_name(nachname="Mustermann", vorname="Max")
```

## Rückgabewerte mit return

Die `return`-Anweisung gibt einen Wert zurück und beendet die Funktion sofort. Ohne `return` oder mit `return` ohne Wert gibt die Funktion `None` zurück.

```python
def gib_wert_zurueck():
    """Demonstriert die Rückgabe eines Wertes."""
    return "Dieser Wert wird zurückgegeben"
```

```python
# Aufruf und Ausgabe des Rückgabewerts
gib_wert_zurueck()
```

## Funktionen ohne Rückgabewert

Eine Funktion muss nicht unbedingt einen Wert zurückgeben. In diesem Fall ist der Rückgabewert `None`.

```python
def zeige_nachricht(nachricht):
    """Zeigt eine Nachricht an, gibt aber keinen Wert zurück."""
    print(f"Nachricht: {nachricht}")
    # Kein return-Statement
```

```python
# Aufruf einer Funktion ohne expliziten Rückgabewert
ergebnis = zeige_nachricht("Hallo Welt")
print(f"Rückgabewert: {ergebnis}")  # Wird 'None' ausgeben
```

## Weitere Informationen

Für detaillierte Informationen zu Funktionen in Python können Sie die [offizielle Python-Dokumentation zu Funktionen](https://docs.python.org/3/tutorial/controlflow.html#defining-functions) konsultieren.

```python

```
