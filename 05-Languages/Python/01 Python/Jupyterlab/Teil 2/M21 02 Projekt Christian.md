## Aufgabenstellungen für WetterWeiser (M21)

### 1. WetterMessung-Klasse erstellen

- Entwickle eine Klasse `WetterMessung` mit Attributen wie Datum, Temperatur und Niederschlag.
- Füge Methoden hinzu, um eine Messung zu präsentieren (z. B. als Text oder als Dictionary zurückzugeben).

```python
class WetterMessung:
    def __init__(self, datum, temperatur, niederschlag):
        self.datum = datum
        self.temperatur = temperatur
        self.niederschlag = niederschlag

    def anzeigen(self):
        return f"Datum: {self.datum}, Temperatur: {self.temperatur}°C, Niederschlag: {self.niederschlag} mm"
```


***

### 2. Sammlung und Analyse in einer OOP-Struktur

- Erstelle eine Klasse, die mehrere `WetterMessung`-Objekte verwalten kann (z. B. `WetterDaten`).
- Implementiere Methoden zur Berechnung des Temperaturmittels und des Gesamtniederschlags.

```python
class WetterDaten:
    def __init__(self):
        self.messungen = []

    def hinzufuegen(self, messung):
        self.messungen.append(messung)

    def durchschnittstemperatur(self):
        return sum(m.temperatur for m in self.messungen) / len(self.messungen)

    def gesamtniederschlag(self):
        return sum(m.niederschlag for m in self.messungen)
```


***

### 3. Erweiterung: Datenimport und -export

- Schreibe Methoden, um Wettermessungen aus einer Datei (z. B. CSV) einzulesen und zu speichern.
- Erweitere die Analyse-Klasse um eine Exportfunktion für Auswertungsdaten.

***

### 4. Visualisierung (optional, für Fortgeschrittene)

- Implementiere eine Methode, die Temperatur- oder Niederschlagsdaten grafisch darstellt (z. B. mit matplotlib).

***

### 5. Anwendung

- Lege ein paar Beispielmessungen an, führe die Analyse- und Visualisierungsfunktionen aus und präsentiere die Ergebnisse in einem kurzen Bericht.[^1]

***

Diese Aufgabenstellungen fördern ein tiefes Verständnis für Klassen, Methoden und deren Vorteile gegenüber rein funktionalen Ansätzen und bieten einen direkten Bezug zum WetterWeiser-Projekt.
