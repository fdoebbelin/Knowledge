In diesem Dokument finden Sie praktische Übungen zum Thema Funktionen in Python. Die Übungen bauen auf den Grundlagen zu Funktionsdefinition, Parametern, Variablen-Scopes, Dokumentation und testbaren Funktionen auf.

Versuchen Sie, die Aufgaben selbstständig zu lösen. Zu jeder Aufgabe gibt es Hinweise, die Ihnen helfen können, falls Sie nicht weiterkommen. Die vollständigen Lösungen finden Sie am Ende des Dokuments.

## Übung 1: Funktionsdefinition und -aufruf

1. Definiere eine Funktion `begrüße_person`, die einen Namen als Parameter akzeptiert und einen Begrüßungstext zurückgibt.

   **Hinweis**: Verwenden Sie f-Strings oder die `.format()`-Methode, um den Namen in den Begrüßungstext einzufügen.

2. Definiere eine Funktion `berechne_mehrwertsteuer`, die einen Nettobetrag als Parameter akzeptiert und den Bruttobetrag (mit 19% MwSt.) zurückgibt.

   **Hinweis**: Die Formel für die Berechnung des Bruttobetrags lautet: Nettobetrag × (1 + Mehrwertsteuersatz).

## Übung 2: Parameter und Rückgabewerte

1. Schreibe eine Funktion `erstelle_personendaten`, die Vor- und Nachname als Pflichtparameter sowie Alter und Stadt als optionale Parameter mit Standardwerten akzeptiert und ein Dictionary mit diesen Daten zurückgibt.

   **Hinweis**: Definieren Sie die Funktion mit Standardwerten für die optionalen Parameter, zum Beispiel `alter=30` und `stadt="Berlin"`.

2. Schreibe eine Funktion `berechne_statistik`, die eine Liste von Zahlen entgegennimmt und ein Dictionary mit Minimum, Maximum, Durchschnitt und Summe zurückgibt.

   **Hinweis**: Nutzen Sie die eingebauten Funktionen `min()`, `max()` und `sum()`. Für den Durchschnitt teilen Sie die Summe durch die Anzahl der Elemente (mit `len()`).

## Übung 3: Lokale vs. globale Variablen

1. Schreibe eine Funktion, die einen Zähler demonstriert, der bei jedem Aufruf um eins erhöht wird (mit globaler Variable).

   **Hinweis**: Verwenden Sie das Schlüsselwort `global`, um auf eine Variable außerhalb der Funktion zuzugreifen und sie zu ändern.

2. Schreibe eine verbesserte Version, die den Zähler als Funktion zurückgibt, die den internen Zustand kapselt (Closure).

   **Hinweis**: Definieren Sie eine äußere Funktion, die eine lokale Variable erstellt und eine innere Funktion zurückgibt, die diese Variable verwendet und verändert (mit `nonlocal`).

## Übung 4: Dokumentation von Funktionen

1. Wähle eine der zuvor erstellten Funktionen und dokumentiere sie ausführlich mit einem Google-Style Docstring.

   **Hinweis**: Der Google-Style Docstring sollte eine kurze Beschreibung, detaillierte Beschreibung, Parameter (mit `Args:`), Rückgabewerte (mit `Returns:`) und optional Beispiele (mit `Examples:`) enthalten.

2. Füge Beispiele für die Verwendung der Funktion hinzu.

   **Hinweis**: Geben Sie in den Beispielen sowohl den Funktionsaufruf als auch das erwartete Ergebnis an.

## Übung 5: Testbare Funktionen

1. Schreibe eine Funktion `validiere_email`, die prüft, ob eine E-Mail-Adresse gültig ist (enthält @-Zeichen und einen Punkt im Domain-Teil).

   **Hinweis**: Nutzen Sie die Methoden `.find()` oder `.index()`, um nach bestimmten Zeichen zu suchen, oder verwenden Sie reguläre Ausdrücke (mit dem `re`-Modul).

2. Schreibe mindestens 5 Testfälle, um die Funktion zu validieren.

   **Hinweis**: Erstellen Sie eine Liste von gültigen und ungültigen E-Mail-Adressen und überprüfen Sie, ob Ihre Funktion die erwarteten Ergebnisse liefert.

## Projekt: Umrechnungsbibliothek

Entwickle eine kleine Bibliothek mit testbaren Funktionen für verschiedene Umrechnungen:

1. Funktionen für Längenumrechnungen (z.B. Meter zu Fuß, Kilometer zu Meilen)
2. Funktionen für Temperaturumrechnungen (Celsius zu Fahrenheit, Kelvin)
3. Funktionen für Gewichtsumrechnungen (Kilogramm zu Pfund, Gramm zu Unzen)
4. Jede Funktion sollte ordentlich dokumentiert sein
5. Jede Funktion sollte Eingaben validieren
6. Erstelle einfache Testfunktionen, die die Umrechnungsfunktionen mit verschiedenen Werten aufrufen und das Ergebnis ausgeben

**Hinweise**:
- Für die Längenumrechnungen: 1 Meter = 3.281 Fuß, 1 Kilometer = 0.621 Meilen
- Für die Temperaturumrechnungen: °F = °C × 9/5 + 32, K = °C + 273.15
- Für die Gewichtsumrechnungen: 1 Kilogramm = 2.205 Pfund, 1 Gramm = 0.035 Unzen
- Erstelle eine Hilfsfunktion zur Validierung der Eingabewerte
- Die Testfunktionen sollten nacheinander jede Umrechnungsfunktion mit sinnvollen Werten aufrufen und das Ergebnis formatiert ausgeben
- Verwende einfache print-Anweisungen zum Anzeigen der Testergebnisse
