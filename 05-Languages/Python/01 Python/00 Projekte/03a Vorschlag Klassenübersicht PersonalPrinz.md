## Übersicht aller zentralen Klassen

- **Mitarbeiter** – Repräsentiert eine einzelne Person mit allen persönlichen und arbeitsrelevanten Attributen.
- **Personalverwaltung** – Verwaltung aller Mitarbeiterobjekte, zentrale Schnittstelle für Suche, Import/Export und Rechtekontrolle.
- **Storage** – Zuständig für Laden und Speichern der Daten (CSV oder SharePoint).
- **LoginManager** – Regelt Anmeldung, Authentifizierung und Zugriffskontrolle auf Daten.

Weitere optionale Klassen können für Arbeitszeitmodelle, Abwesenheiten und Rollen-Rechte eingeführt werden.

***

## Beispielhafte Implementierung und Zusammenspiel

### Klasse Mitarbeiter

```python
class Mitarbeiter:
    def __init__(self, personalnummer, name, vorname, arbeitsmodell):
        self.personalnummer = personalnummer
        self.name = name
        self.vorname = vorname
        self.arbeitsmodell = arbeitsmodell  # z.B. "Vollzeit", "Teilzeit", "Studentisch"
        self.urlaub_total = 30
        self.urlaub_genommen = 0
        self.stundenkonto = 0.0
        
    def urlaub_buchen(self, tage):
        if self.urlaub_genommen + tage <= self.urlaub_total:
            self.urlaub_genommen += tage
            return True
        return False
    
    def stunden_buchen(self, stunden):
        self.stundenkonto += stunden
        
    def resturlaub(self):
        return self.urlaub_total - self.urlaub_genommen
        
    def __repr__(self):
        return f"{self.vorname} {self.name} ({self.personalnummer})"
```

**Praxisdemo**: Urlaub buchen und Resturlaub abrufen

```python
m = Mitarbeiter(1001, "Müller", "Anna", "Vollzeit")
print(m.resturlaub())      # Startwert: 30
m.urlaub_buchen(5)
print(m.resturlaub())      # Ergebnis: 25
m.stunden_buchen(3.5)
print(m.stundenkonto)      # Ergebnis: 3.5
```

*Dient im Kurs zur schrittweisen Erklärung der Methode-Bedeutungen.*

***

### Klasse Personalverwaltung

```python
class Personalverwaltung:
    def __init__(self):
        self.mitarbeitende = []
    
    def add_mitarbeiter(self, mitarbeiter):
        self.mitarbeitende.append(mitarbeiter)
    
    def suche_mitarbeiter(self, personalnummer):
        return next((m for m in self.mitarbeitende if m.personalnummer == personalnummer), None)
    
    def lade_aus_csv(self, dateiname):
        import csv
        with open(dateiname, newline='', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                m = Mitarbeiter(
                    personalnummer=row["Personalnummer"],
                    name=row["Nachname"],
                    vorname=row["Vorname"],
                    arbeitsmodell=row["Arbeitsmodell"]
                )
                m.urlaub_total = int(row.get("UrlaubGesamt", 30))
                m.urlaub_genommen = int(row.get("UrlaubGenommen", 0))
                m.stundenkonto = float(row.get("Stundenkonto", 0))
                self.add_mitarbeiter(m)
```

**Praxisdemo**: CSV-Import und Suche

```python
verwalter = Personalverwaltung()
verwalter.lade_aus_csv("users.csv")
m = verwalter.suche_mitarbeiter(1001)
print(m)
```

*Kurszweck*: Speicherung und Suche von Objekten, Vorbereitung für GUI oder Prüfungen im Datenschutz.

***

### Storage-Klasse

```python
class Storage:
    def __init__(self, pfad):
        self.pfad = pfad
    
    def speichern(self, mitarbeiter_liste):
        import csv
        with open(self.pfad, "w", newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(["Personalnummer", "Nachname", "Vorname", "Arbeitsmodell", "UrlaubGesamt", "UrlaubGenommen", "Stundenkonto"])
            for m in mitarbeiter_liste:
                writer.writerow([m.personalnummer, m.name, m.vorname, m.arbeitsmodell, m.urlaub_total, m.urlaub_genommen, m.stundenkonto])
                
    def laden(self):
        # analog zur Personalverwaltung.lade_aus_csv
        pass
```

**Praxisdemo**: Datensicherung

```python
storage = Storage("users_back.csv")
storage.speichern(verwalter.mitarbeitende)
```

*Wird im Kurs als Vorbereitung für Migration und Integrationsaufgaben eingesetzt.*

***

### LoginManager-Klasse (Beispiel)

```python
class LoginManager:
    def __init__(self, verwalter):
        self.verwalter = verwalter
        self.sessions = {}  # personalnummer -> logged-in status
    
    def login(self, personalnummer):
        mitarbeiter = self.verwalter.suche_mitarbeiter(personalnummer)
        if mitarbeiter:
            self.sessions[personalnummer] = True
            return mitarbeiter
        return None
```

**Praxisdemo**: Eigene Daten abrufen nach Login

```python
login = LoginManager(verwalter)
user_obj = login.login(1001)
if user_obj:
    print("Resturlaub:", user_obj.resturlaub())
```

*Im Kurs zur Demonstration von Rechteverwaltung und Zugriffskontrolle*.

***

## Zusammenspiel der Klassen

- **Mitarbeiter** wird als Objekt in der **Personalverwaltung** gespeichert und bearbeitet.
- **Storage** übernimmt Laden und Speichern der Datenobjekte (Datensicherheit).
- **LoginManager** sorgt dafür, dass Benutzer nur ihre eigenen Daten sehen und bearbeiten können – elementarer Aspekt des Datenschutzes.
- Erweiterungen für Arbeitszeitmodelle, Abwesenheitsverwaltung und Rollenrechte lassen sich konsistent in das bestehende Modell einbauen.