## 📋 Projektbeschreibung

Ziel ist ein portables Python-Programm, mit dem sich Mitarbeiterdaten, Arbeitsmodelle, Urlaubsansprüche und Arbeitszeitkonten effizient verwalten lassen. Mitarbeiter:innen sollen ihre eigenen Daten prüfen können, ohne andere einsehen zu dürfen. Die Anwendung speichert Daten lokal (CSV) und erlaubt optional eine SharePoint-Anbindung.

***

## 🚀 Funktionsumfang

- Erfassen, Anzeigen und Bearbeiten von Mitarbeiterdaten
- Verwaltung von Urlaubsanspruch/-verbrauch
- Arbeitsmodelle zuweisen (Vollzeit, Teilzeit, Stundenbasis)
- Mehrarbeit und Stundenkonto führen
- Daten lokal als CSV speichern und laden
- GUI (tkinter) zur Bedienung
- SharePoint-Anbindung für zentrale Ablage
- Login/Authentifizierung: Mitarbeitende sehen nur die eigenen Daten

***

## 🛠️ Voraussetzungen

- Python 3.x
- Module: `tkinter`, `csv` oder `pandas`
- Optional: Pakete für SharePoint-Anbindung (`office365-rest-python-client` o.ä.)

***

## 📁 Projektstruktur (Vorschlag)

```text
personalprinz/
  ├── main.py         # Startpunkt, GUI-Initialisierung
  ├── model.py        # OOP-Klassen für Mitarbeiter und Verwaltung
  ├── storage.py      # csv/pandas und SharePoint-Anbindung
  └── users.csv       # Beispieldatenbank (lokal)
```


***

## 🧩 Praxis: Objektorientierte Struktur

### Klasse für Mitarbeitende mit Methoden

```python
class Mitarbeiter:
    def __init__(self, personalnummer, name, vorname, arbeitsmodell):
        self.personalnummer = personalnummer
        self.name = name
        self.vorname = vorname
        self.arbeitsmodell = arbeitsmodell  # z.B. 'Vollzeit', 'Teilzeit', 'Stundenbasis'
        self.urlaub_total = 30
        self.urlaub_genommen = 0
        self.stundenkonto = 0  # Plus-/Minusstunden

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


***

### Verwaltung und Zugriff (inkl. Datenschutz)

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
                    personalnummer=row['Personalnummer'],
                    name=row['Nachname'],
                    vorname=row['Vorname'],
                    arbeitsmodell=row['Arbeitsmodell']
                )
                m.urlaub_total = int(row.get('Urlaub_Gesamt', 30))
                m.urlaub_genommen = int(row.get('Urlaub_Genommen', 0))
                m.stundenkonto = float(row.get('Stundenkonto', 0))
                self.add_mitarbeiter(m)
```


***

## 🖥️ GUI: Eigenen Datensatz abrufen (tkinter-Demo)

```python
import tkinter as tk

def zeige_persoenliche_daten(verwalter, pn):
    m = verwalter.suche_mitarbeiter(pn)
    text = f"Name: {m.vorname} {m.name}\nUrlaub Rest: {m.resturlaub()} Tage\nStundenkonto: {m.stundenkonto} h"
    tk.messagebox.showinfo("Eigene Daten", text)

root = tk.Tk()
verwalter = Personalverwaltung()
verwalter.lade_aus_csv("users.csv")

# Nach Login erhält User seine Nummer (z. B. hier 1001)
personalnummer = "1001"
btn = tk.Button(root, text="Mein Konto ansehen", command=lambda: zeige_persoenliche_daten(verwalter, personalnummer))
btn.pack()
root.mainloop()
```


***

## 📑 Daten auf SharePoint speichern (Erweiterungsidee mit pandas)

Datei aus Pandas DataFrame auf SharePoint hochladen:[^3][^4]

```python
from office365.sharepoint.client_context import ClientContext
from io import BytesIO
import pandas as pd

site_url = "https://beispiel.sharepoint.com/sites/PERSONAL"
df = pd.read_csv("users.csv")
buffer = BytesIO()
df.to_csv(buffer, index=False)
buffer.seek(0)

ctx = ClientContext(site_url).with_credentials("USER", "PASSWORT")
target_folder = ctx.web.get_folder_by_server_relative_url("Shared Documents")
target_folder.upload_file("users.csv", buffer.read()).execute_query()
```


***

## 📌 Aufgabenstellungen

1. Implementiere ein neues Arbeitszeitmodell („Studentische Hilfskraft“ mit 20 Tagen Urlaub).
2. Schreibe eine Methode zur Berechnung des Stundenkonto-Saldos am Monatsende.
3. Entwickle simple Login/Authentifizierungsmechanismen, sodass nur die eigenen Daten nutzbar sind.
4. Diskutiere: Welche Vor- und Nachteile bietet die lokale Speicherung vs. zentrale Ablage auf SharePoint?

---
## 🌱 Ausblick

- **Erweiterung der Arbeitszeitmodelle:** Integration weiterer, flexibler Arbeitszeit- und Sonderregelungen (z.B. Schichtmodelle, Gleitzeit, Sabbaticals).
- **Abwesenheits- und Krankmeldungsverwaltung:** Automatisierte Workflow-Prozesse für Anträge, Genehmigungen und Vertretungsplanung.
- **Benutzerrollen & Rechte:** Fein granulierte Zugriffs- und Bearbeitungsrechte (z.B. für Teamleitungen, Verwaltung, Personalrat).
- **Import/Export-Schnittstellen:** Anbindung an externe Zeiterfassungssysteme, Lohnbuchhaltung oder HR-Plattformen für reibungslosen Datenaustausch.
- **Mobile Nutzung:** Optionale Web-Oberfläche oder mobile App für standort- und geräteunabhängige Bedienung.
- **Cloud- oder Serverintegration:** Speicherung und Verwaltung der Daten in zentralen, DSGVO-konformen Cloudlösungen oder auf Teamservern.
- **Automatisierte Auswertungen:** Monatliche Berichte, Trendanalysen und Warnungen bei Unregelmäßigkeiten im Stundenkonto oder Urlaubsverbrauch.
- **Machine Learning:** Analyse von Zeitreihen (z.B. Überstundenprognose, anomale Urlaubsmuster) als späteres Fortgeschrittenenprojekt.