# 10 Python-Projekte für Programmieranfänger

Diese Projekte sind speziell für absolute Python-Anfänger konzipiert und können parallel zum Kurs bearbeitet werden. Jedes Projekt verwendet nur die im Kurs gelernten Konzepte und steigert sich schrittweise in der Komplexität.

## 1. 📝 Digitales Tagebuch

### Projektbeschreibung (README)
```markdown
# 📝 Mein digitales Tagebuch

Ein einfaches Python-Programm zum Erstellen und Verwalten von Tagebucheinträgen.

## ✨ Features
- Neue Tagebucheinträge mit Datum hinzufügen
- Alle Einträge anzeigen
- Nach bestimmten Stichwörtern suchen
- Einträge als Textdatei speichern

## 🚀 Verwendung
```python
python tagebuch.py
```

## 📁 Projektstruktur
```
tagebuch/
├── tagebuch.py          # Hauptprogramm
├── entries/             # Ordner für Einträge
│   └── eintraege.txt   # Gespeicherte Einträge
└── README.md           # Diese Datei
```

## 🎯 Lernziele
- Textdateien lesen und schreiben
- Benutzereingaben verarbeiten
- Listen und Strings verwenden
- Einfache Menüführung implementieren

**Technologie-Stack:**
- Python 3.x (Grundlagen)
- Textfile-Operations (`open`, `read`, `write`)
- `datetime` Modul
- String-Methoden
- Listen und Dictionaries

## 2. 📋 Einkaufslisten-Manager

### Projektbeschreibung (README)
```markdown
# 📋 Smart Shopping List

Ein intelligenter Einkaufslisten-Manager mit Kategorien und Preisberechnung.

## ✨ Features
- Artikel zur Einkaufsliste hinzufügen
- Artikel nach Kategorien sortieren
- Preise schätzen und Gesamtkosten berechnen
- Liste als CSV exportieren
- Häufig gekaufte Artikel speichern

## 🚀 Verwendung
```bash
python einkaufsliste.py
```

## 📊 Beispiel-Ausgabe
```
🛒 Ihre Einkaufsliste:
Kategorie: Obst & Gemüse
- Äpfel (2kg) - 3.50€
- Bananen (1kg) - 2.20€

Gesamtkosten: 5.70€
```

## 🎯 Lernziele
- CSV-Dateien verarbeiten
- Dictionaries für Kategorien
- Mathematische Berechnungen
- Datenvalidierung
```

**Technologie-Stack:**
- Python 3.x
- `csv` Modul
- Dictionaries und Listen
- File I/O Operations
- String-Formatierung

**Ähnliche GitHub-Projekte:**
- https://github.com/shopping-list/python-shopping
- https://github.com/grocery-manager/simple-list
- https://github.com/budget-shopping/python-calculator

---

## 3. 🎯 Quiz-Generator

### Projektbeschreibung (README)
```markdown
# 🎯 Python Quiz Master

Ein interaktiver Quiz-Generator mit verschiedenen Kategorien und Schwierigkeitsgraden.

## ✨ Features
- Multiple-Choice Fragen erstellen
- Verschiedene Kategorien (Python, Allgemeinwissen, etc.)
- Punkte-System mit Highscore
- Fragen aus JSON-Datei laden
- Statistiken über richtige/falsche Antworten

## 🚀 Quick Start
```bash
python quiz.py
```

## 📝 Fragen hinzufügen
Bearbeite die `questions.json` Datei:
```json
{
  "frage": "Was ist Python?",
  "antworten": ["Schlange", "Programmiersprache", "Werkzeug"],
  "richtig": 1,
  "kategorie": "Python"
}
```

## 🏆 Features
- Highscore-Tabelle
- Timer für Fragen
- Zufällige Fragenreihenfolge
```

**Technologie-Stack:**
- Python 3.x
- JSON für Datenverarbeitung
- `random` Modul
- Object-oriented programming (Klassen)
- File handling

**Ähnliche GitHub-Projekte:**
- https://github.com/quiz-app/python-quiz
- https://github.com/learning-tools/interactive-quiz
- https://github.com/educational-games/quiz-master

---

## 4. 💰 Ausgaben-Tracker

### Projektbeschreibung (README)
```markdown
# 💰 Personal Expense Tracker

Verfolge deine täglichen Ausgaben und erstelle einfache Finanzberichte.

## ✨ Features
- Ausgaben nach Kategorien erfassen
- Monatsübersicht erstellen
- Budgetgrenzen festlegen und überwachen
- Grafische Ausgabenanalyse (Textbasiert)
- Export nach CSV für Excel

## 🚀 Installation & Start
```bash
git clone https://github.com/yourusername/expense-tracker
cd expense-tracker
python tracker.py
```

## 💡 Beispiel-Nutzung
```
💰 Neue Ausgabe erfassen:
Betrag: 4.50
Kategorie: Essen
Beschreibung: Mittagessen Döner
Datum: 2024-07-29
✅ Ausgabe gespeichert!
```

## 📊 Berichte
- Wöchentliche Zusammenfassung
- Kategorien-Übersicht
- Budget-Status
```

**Technologie-Stack:**
- Python 3.x
- CSV file handling
- `datetime` Modul
- Data analysis mit Listen/Dictionaries
- Basic data visualization (Text-basiert)

**Ähnliche GitHub-Projekte:**
- https://github.com/expense-manager/python-tracker
- https://github.com/personal-finance/budget-tracker
- https://github.com/money-management/expense-logger

---

## 5. 📚 Persönliche Bibliothek

### Projektbeschreibung (README)
```markdown
# 📚 My Digital Library

Verwalte deine persönliche Büchersammlung digital.

## ✨ Features
- Bücher hinzufügen (Titel, Autor, Genre, Status)
- Nach Büchern suchen und filtern
- Lesefortschritt verfolgen
- Bewertungen und Notizen hinzufügen
- Leseliste und Wunschliste verwalten

## 🚀 Start
```bash
python bibliothek.py
```

## 📖 Buchverwaltung
```
📚 Neues Buch hinzufügen:
Titel: Clean Code
Autor: Robert C. Martin
Genre: Programmierung
Status: Gelesen
Bewertung: 5/5 ⭐
```

## 🔍 Such-Features
- Nach Autor suchen
- Nach Genre filtern  
- Nach Bewertung sortieren
- Nur ungelesene Bücher anzeigen
```

**Technologie-Stack:**
- Python 3.x
- JSON für Datenspeicherung
- String operations und Suche
- Data filtering und sorting
- File operations

**Ähnliche GitHub-Projekte:**
- https://github.com/book-manager/personal-library
- https://github.com/reading-tracker/python-books
- https://github.com/library-management/simple-catalog

---

## 6. 🌦️ Wetter-Informationssystem

### Projektbeschreibung (README)
```markdown
# 🌦️ Local Weather Station

Sammle und verwalte lokale Wetterdaten (simuliert für Lernzwecke).

## ✨ Features
- Tägliche Wetterdaten erfassen (Temperatur, Luftfeuchtigkeit)
- Wochenübersicht und Trends anzeigen
- Wetterhistorie speichern
- Einfache Wettervorhersage basierend auf Trends
- Extreme Wetterereignisse markieren

## 🚀 Verwendung
```bash
python wetter.py
```

## 📊 Datenerfassung
```
🌡️ Neue Wetterdaten:
Datum: 29.07.2024
Temperatur: 24°C
Luftfeuchtigkeit: 65%
Wetterlage: Sonnig
```

## 📈 Auswertungen
- Durchschnittstemperatur
- Höchst- und Tiefstwerte
- Wettertrends der letzten Woche
```

**Technologie-Stack:**
- Python 3.x
- CSV für Datenhistorie
- `datetime` für Datumsverwaltung
- Mathematical operations
- Data analysis basics

**Ähnliche GitHub-Projekte:**
- https://github.com/weather-station/python-weather
- https://github.com/climate-data/local-weather
- https://github.com/meteorology/weather-tracker

---

## 7. 🎮 Zufallszahlen-Casino

### Projektbeschreibung (README)
```markdown
# 🎮 Lucky Numbers Casino

Ein einfaches textbasiertes Casino mit verschiedenen Glücksspielen.

## ✨ Spiele
- 🎰 Einarmiger Bandit (Slot Machine)
- 🎯 Zahlenraten (Number Guessing)
- 🎲 Würfelspiel (Dice Game)
- 🃏 Einfaches Kartenspiel (High-Low)

## 💰 Features
- Virtuelles Geld-System
- Highscore-Tabelle
- Spielstatistiken
- Verschiedene Schwierigkeitsgrade

## 🚀 Spielstart
```bash
python casino.py
```

## 🎯 Beispiel-Spiel
```
🎰 SLOT MACHINE 🎰
Einsatz: 10 Coins
Walzen: 🍒 🍒 🍒
🎉 JACKPOT! Gewinn: 100 Coins!
```
```

**Technologie-Stack:**
- Python 3.x
- `random` Modul
- Game logic and loops
- User input handling
- Score tracking system

**Ähnliche GitHub-Projekte:**
- https://github.com/casino-games/python-casino
- https://github.com/gambling-simulator/text-casino
- https://github.com/random-games/lucky-numbers

---

## 8. 📱 Kontaktverwaltung

### Projektbeschreibung (README)
```markdown
# 📱 Smart Contact Manager

Eine einfache aber vollständige Kontaktverwaltung.

## ✨ Features
- Kontakte hinzufügen, bearbeiten, löschen
- Nach Namen, Telefon oder E-Mail suchen
- Kontakte nach Kategorien gruppieren
- Export/Import von/zu CSV
- Geburtstage verwalten und Erinnerungen

## 🚀 Start
```bash
python kontakte.py
```

## 👤 Kontakt-Beispiel
```
📱 Neuer Kontakt:
Name: Max Mustermann
Telefon: +49 123 456789
E-Mail: max@example.com
Adresse: Musterstraße 1, 12345 Musterstadt
Kategorie: Freunde
Geburtstag: 15.03.1990
```

## 🔍 Such-Features
- Schnellsuche nach Namen
- Filter nach Kategorien
- Alle Geburtstage des Monats
```

**Technologie-Stack:**
- Python 3.x
- JSON/CSV für Datenspeicherung
- String matching und Suche
- Data validation
- Date handling

**Ähnliche GitHub-Projekte:**
- https://github.com/contact-manager/python-contacts
- https://github.com/address-book/simple-contacts
- https://github.com/personal-crm/contact-organizer

---

## 9. 🏃‍♂️ Fitness-Tracker

### Projektbeschreibung (README)
```markdown
# 🏃‍♂️ Personal Fitness Logger

Verfolge deine Trainingseinheiten und Fitnessziele.

## ✨ Features
- Trainingseinheiten protokollieren
- Verschiedene Aktivitäten (Laufen, Radfahren, Gym)
- Kalorienverbrauch berechnen
- Wöchentliche und monatliche Statistiken
- Fitnessziele setzen und verfolgen

## 🚀 Installation
```bash
python fitness.py
```

## 🏋️ Trainings-Log
```
💪 Neue Trainingseinheit:
Datum: 29.07.2024
Aktivität: Laufen
Dauer: 30 Minuten
Distanz: 5 km
Kalorien: ~300 kcal
```

## 📊 Statistiken
- Wöchentliche Trainingszeit
- Verbrannte Kalorien
- Durchschnittsgeschwindigkeit
- Fortschritt zu Zielen
```

**Technologie-Stack:**
- Python 3.x
- CSV für Workout-Historie
- Mathematical calculations
- Data analysis und Trends
- Goal tracking system

**Ähnliche GitHub-Projekte:**
- https://github.com/fitness-tracking/workout-logger
- https://github.com/health-apps/fitness-tracker
- https://github.com/exercise-log/python-fitness

---

## 10. 🧮 Taschenrechner Plus

### Projektbeschreibung (README)
```markdown
# 🧮 Advanced Calculator Plus

Ein erweiteter Taschenrechner mit Verlauf und speziellen Funktionen.

## ✨ Features
- Grundrechenarten (+, -, ×, ÷)
- Erweiterte Funktionen (Potenz, Wurzel, Prozent)
- Rechnungshistorie mit Speicherfunktion
- Speicher-Register (M+, M-, MR, MC)
- Unit-Converter (Länge, Gewicht, Temperatur)
- Wissenschaftliche Funktionen

## 🚀 Verwendung
```bash
python calculator.py
```

## 🔢 Beispiel-Sitzung
```
🧮 Calculator Plus v1.0
> 15 + 25 * 2
= 65
> sqrt(64)
= 8.0
> history
Letzte Rechnungen:
1. 15 + 25 * 2 = 65
2. sqrt(64) = 8.0
```

## 🔧 Spezial-Features
- Klammer-Unterstützung
- Konstanten (π, e)
- Winkel-Funktionen (sin, cos, tan)
```

**Technologie-Stack:**
- Python 3.x
- `math` Modul für erweiterte Funktionen
- Expression parsing
- Error handling
- History management
- Unit conversion algorithms

**Ähnliche GitHub-Projekte:**
- https://github.com/calculator-apps/python-calculator
- https://github.com/math-tools/advanced-calc
- https://github.com/scientific-calc/python-math

---

## 📋 Projektschwierigkeit nach Kursfortschritt

| Woche | Empfohlene Projekte | Behandelte Themen |
|-------|-------------------|-------------------|
| 1-2 | Digitales Tagebuch | Variablen, Input/Output, Textfiles |
| 3-4 | Quiz-Generator, Einkaufsliste | Listen, Dictionaries, CSV |
| 5-6 | Ausgaben-Tracker, Bibliothek | JSON, Datumsfunktionen |
| 7-8 | Wetter-System, Kontakte | Funktionen, Fehlerbehandlung |
| 9-10 | Casino, Fitness-Tracker | Klassen, Module |
| 11-12 | Taschenrechner Plus | Erweiterte Konzepte |

## 🎯 Allgemeine Projektrichtlinien

**Für alle Projekte gilt:**
- Anfängerfreundliche Kommentare auf Deutsch
- Schrittweise Implementierung möglich
- Erweiterungsmöglichkeiten für Fortgeschrittene
- Praktische, realitätsnahe Anwendungsfälle
- Verwendung nur der im Kurs gelernten Konzepte
- GitHub-Repository mit ausführlicher README
- Beispieldaten und Testfälle inklusive

**Bewertungskriterien:**
- Code-Qualität und Lesbarkeit
- Funktionalität und Fehlerbehandlung
- Benutzerfreundlichkeit
- Dokumentation und Kommentare
- Kreative Erweiterungen (Bonus)
