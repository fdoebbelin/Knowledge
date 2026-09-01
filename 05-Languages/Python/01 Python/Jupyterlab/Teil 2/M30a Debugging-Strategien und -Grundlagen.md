## Was ist Debugging?

Debugging bedeutet das gezielte Auffinden und Entfernen von Fehlern im Quellcode eines Programms. Fehler können sich auf Syntax (Schreibfehler), Logik (falsche Abläufe) oder Laufzeit (unerwartetes Verhalten durch falsche Eingabewerte, Ressourcenprobleme etc.) beziehen. Ziel eines guten Debuggings ist es, Programme zuverlässiger und nachvollziehbar zu machen.

## Fehlerarten: Übersicht

Typische Fehlerarten sind:

- **Syntaxfehler**: z.B. vergessene Einrückung, falsche Schreibweise von Variablen
- **Logikfehler**: z.B. fehlerhafte Berechnung, falsche Reihenfolge von Anweisungen
- **Laufzeitfehler**: z.B. Division durch Null, Zugriff auf nicht vorhandene Datei
Jeder dieser Fehler erfordert unterschiedliche Debugging-Techniken.


## Print-Debugging: Der einfachste Einstieg

Print-Debugging ist die Methode, gezielt print-Anweisungen zu platzieren, um Werte oder Status-Informationen zur Programmausführung auszugeben. So lässt sich Schritt für Schritt verfolgen, an welchem Punkt etwas nicht wie erwartet funktioniert.

```python
def fehlerhafte_summe(liste):
    summe = 0
    for wert in liste:
        print("Aktueller Wert:", wert)  # Debug-Ausgabe
        summe += wert
    print("Endergebnis:", summe)
    return summe

fehlerhafte_summe([1, 2, "3", 4])  # Typfehler: "3" ist ein String!
```

Wird ein Fehler erkannt, zeigt der letzte Print oft schon die Problemstelle.

## Funktionen und Klassen als Debug-Einheiten

Modularisierung hilft beim Debugging: Einzelne Funktionen oder Klassen lassen sich separat testen und analysieren. Fehler werden so schneller lokalisiert.

```python
def ist_positive_zahl(x):
    print(f"Teste x={x} ...")  # Debug-Ausgabe
    return x > 0

class Checker:
    def __init__(self, liste):
        self.liste = liste

    def check(self):
        for w in self.liste:
            print("Prüfe:", w)  # Debug-Ausgabe
            if not ist_positive_zahl(w):
                print("Fehler entdeckt:", w)
```


## Typische Debugging-Strategien in Python

- **Testdaten** erstellen, um Grenzfälle oder seltene Fehler zu provozieren
- **Mehrere Prints/Logs** setzen: Vorher, nachher, bedingte Ausgaben
- **Einfache Fehlermeldungen** erfassen und analysieren: Python zeigt oft Zeile und Art des Fehlers an

Beispiel:

```python
def division(a, b):
    print(f"Dividiere {a} durch {b}")
    if b == 0:
        print("Fehler: Division durch Null")
        return None
    return a / b

result = division(10, 0)
```

Hier kann mit Print-Anweisungen sauber geprüft werden, wann und wo der Fehler entsteht.

## Praxisbeispiel: Schritt-für-Schritt-Debugging

Angenommen, eine Funktion liefert nicht das erwartete Ergebnis:

```python
def liste_summe(liste):
    # Erwartet: Addiert alle Zahlen der Liste
    summe = 0
    for i in range(len(liste)):
        print(f"Index {i}, Wert {liste[i]}")  # Debug-Ausgabe
        summe += liste[i]
    print("Gesamtsumme:", summe)
    return summe

werte = [1, 2, 3, 4]
liste_summe(werte)  # Ergebnis soll 10 sein
```

Durch gezielte Prints erkennt man direkt, ob der Zähler und die Werte wie gewünscht verarbeitet werden.

## Weiterführende Methoden

Das Modul bereitet auf fortgeschrittene Debugging-Techniken vor:

- Nutzung von Tracebacks und Fehlermeldungen
- Einsatz von try-except zum sicheren Umgang mit Fehlern
- Debugging in Funktionen und Klassen, um gezielt Fehler zu isolieren[^1].


## Beispiel für systematische Fehlersuche

```python
def fehler_typ_test(liste):
    try:
        for wert in liste:
            print("Prüfe Wert:", wert)
            print("Quadrat:", wert**2)
    except Exception as e:
        print("Fehler erkannt:", e)

fehler_typ_test([2, "zwei", 4])
```

Hier wird nicht nur ein Fehler erkannt, sondern auch dessen Art angezeigt.
