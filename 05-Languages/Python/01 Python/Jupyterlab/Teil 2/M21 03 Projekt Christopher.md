## Aufgabenstellungen für PersonalPrinz (M21)

### 1. Entwicklung einer Mitarbeiter-Klasse

- Implementiere eine Klasse `Mitarbeiter` mit Attributen wie Personalnummer, Name, Arbeitsmodell, Urlaubstage und Stundenkonto.
- Schreibe Methoden, um Urlaub zu buchen und Arbeitsstunden zu erfassen.

```python
class Mitarbeiter:
    def __init__(self, personalnummer, name, arbeitsmodell, urlaubtotal=30):
        self.personalnummer = personalnummer
        self.name = name
        self.arbeitsmodell = arbeitsmodell
        self.urlaubtotal = urlaubtotal
        self.urlaubgenommen = 0
        self.stundenkonto = 0.0

    def urlaubbuchen(self, tage):
        if self.urlaubgenommen + tage <= self.urlaubtotal:
            self.urlaubgenommen += tage
            return True
        return False

    def stundenbuchen(self, stunden):
        self.stundenkonto += stunden
```


***

### 2. Verwaltung mehrerer Mitarbeitender

- Entwickle eine Klasse `Personalverwaltung`, die mehrere Mitarbeiter:innen verwalten kann.
- Füge Methoden hinzu, um Mitarbeiter zu suchen, hinzuzufügen und eine Übersicht aller Mitarbeitenden anzuzeigen.

```python
class Personalverwaltung:
    def __init__(self):
        self.mitarbeitende = []

    def add_mitarbeiter(self, mitarbeiter):
        self.mitarbeitende.append(mitarbeiter)

    def suche_mitarbeiter(self, personalnummer):
        return next((m for m in self.mitarbeitende if m.personalnummer == personalnummer), None)
```


***

### 3. Datenschutz und individuelle Abfrage

- Stelle sicher, dass nur die eigenen Daten abgefragt und angezeigt werden können (z. B. durch ein entsprechendes Methoden- oder Rollenmodell).

***

### 4. Datenimport/-export

- Baue Methoden, um Mitarbeitendendaten aus einer CSV-Datei zu laden und wieder zu speichern.

***

### 5. Erweiterungen (optional)

- Implementiere weitere Arbeitsmodelle oder Methoden – etwa für Arbeitszeitmodelle, Sonderurlaube oder Kontostände am Monatsende.
- Nutze eine einfache grafische Oberfläche (z. B. tkinter) für die Darstellung.

***

Diese Aufgaben vertiefen zentrale OOP-Bausteine anhand eines praxisnahen Verwaltungsszenarios und zeigen anschaulich, wie Objekte, Attribute und Methoden strukturierend und wiederverwendbar eingesetzt werden können.
