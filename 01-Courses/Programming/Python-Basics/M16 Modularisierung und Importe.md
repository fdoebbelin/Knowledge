## Modul-Übersicht
- **Dauer:** 2 Unterrichtseinheiten (UE)
- **Zielgruppe:** Absolute Programmieranfänger
- **Voraussetzungen:** Grundlagen Python-Syntax, Funktionen, Listen, Dictionaries, Dateien
- **Lernziele:** Code in Module strukturieren, externe Bibliotheken verwenden, eigene Module erstellen

## UE 1: Eigene Module erstellen und verwenden (45 min)

### M16.1 - Eigene Module erstellen und importieren

**Lernziele:**
- Verstehen was Module sind und warum sie nützlich sind
- Eigene Python-Dateien als Module erstellen
- Module mit `import` und `from ... import` verwenden
- Funktionen aus eigenen Modulen aufrufen
- Code-Wiederverwendung praktisch anwenden

**Inhalte:**
1. **Was sind Module?**
   - Module als separate .py-Dateien verstehen
   - Vorteile der Code-Aufteilung (Übersichtlichkeit, Wiederverwendung)
   - Unterschied zwischen Skript und Modul

2. **Erstes eigenes Modul erstellen**
   - Einfache .py-Datei mit Funktionen erstellen
   - Mathematik-Modul mit Grundrechenarten als Beispiel
   - Text-Verarbeitungsmodul für Strings

3. **Module importieren und verwenden**
   - `import modulname` Syntax
   - `modulname.funktion()` Aufruf
   - `from modulname import funktion` Syntax
   - `from modulname import *` (mit Warnung vor Überbelegung)

4. **Praktische Anwendung**
   - Taschenrechner-Modul erstellen
   - Namens-Verarbeitung-Modul für Formatierung
   - Module in Hauptprogramm verwenden

**Praktisches Beispiel:**
- Erstelle `rechner.py` mit Grundrechenarten
- Erstelle `namen.py` mit Name-Formatierung
- Hauptprogramm nutzt beide Module für Benutzerinteraktion

---

## UE 2: Externe Bibliotheken und Paket-Management (45 min)

### M16.2 - Externe Bibliotheken mit pip verwenden

**Lernziele:**
- Verstehen was externe Bibliotheken sind
- pip als Paket-Manager kennenlernen
- Einfache externe Bibliotheken installieren und verwenden
- Zwischen Standard-Bibliothek und externen Paketen unterscheiden
- Praktische Anwendung mit beliebten Anfänger-Bibliotheken

**Inhalte:**
1. **Standard-Bibliothek vs. externe Pakete**
   - Was ist bereits in Python enthalten (`math`, `random`, `datetime`)
   - Was muss installiert werden (externe Pakete)
   - PyPI (Python Package Index) als Quelle

2. **pip Grundlagen**
   - `pip install paketname` Befehl
   - `pip list` für installierte Pakete
   - `pip show paketname` für Paket-Informationen
   - Einfache pip-Befehle in der Kommandozeile

3. **Beliebte Anfänger-Bibliotheken verwenden**
   - `requests` für einfache Web-Anfragen (API-Aufrufe)
   - `colorama` für farbige Terminal-Ausgabe
   - `pillow` für einfache Bildbearbeitung (optional)

4. **Praktische Anwendung**
   - Wetter-API mit `requests` abfragen
   - Bunte Ausgaben mit `colorama` erstellen
   - Einfache Programme mit externen Bibliotheken

**Praktisches Beispiel:**
- Wetter-Abfrage mit `requests` von einer kostenlosen API
- Farbige Benutzeroberfläche mit `colorama`
- Kombination eigener Module mit externen Bibliotheken

---

## Unterthemen-Struktur

### M16.1: Eigene Module erstellen und importieren
- **M16.1.1** - Demonstration: Erste eigene Module
- **M16.1.2** - Aufgaben: Taschenrechner-Module-System  
- **M16.1.3** - Musterlösung: Kommentierte Lösungen

### M16.2: Externe Bibliotheken mit pip verwenden
- **M16.2.1** - Demonstration: pip und externe Pakete
- **M16.2.2** - Aufgaben: Wetter-App mit externer API
- **M16.2.3** - Musterlösung: Kommentierte Lösungen

---

## Methodische Hinweise

### Für Programmieranfänger angepasst:
- **Konkrete Beispiele:** Taschenrechner, Namen-Formatierung, Wetter-App
- **Schrittweise Einführung:** Erst eigene Module, dann externe Bibliotheken
- **Praktische Anwendung:** Direkt verwendbare Mini-Programme
- **Fehlerbehandlung:** Häufige Import-Fehler thematisieren

### Technische Umsetzung:
- **Alle Funktionen gekapselt** mit eindeutigen Namen
- **Print-Statements außerhalb** der Funktionen
- **Eine Codezelle pro logische Einheit**
- **Deutsche Kommentare und Erklärungen**

### Schwierigkeitsgrad:
- **Einfache Module** mit 2-3 Funktionen beginnen
- **Klare Struktur:** Eine Funktionalität pro Modul
- **Bekannte APIs:** Nur kostenlose, einfache APIs verwenden
- **Schritt-für-Schritt:** Jeder Import-Schritt einzeln erklärt

---

## Erwartete Lernergebnisse

Nach Abschluss des Moduls können die Teilnehmer:
- ✅ Eigene .py-Dateien als Module erstellen
- ✅ Funktionen aus eigenen Modulen importieren und verwenden
- ✅ `import` und `from ... import` korrekt anwenden
- ✅ pip verwenden um externe Bibliotheken zu installieren
- ✅ Einfache externe Bibliotheken in eigenen Programmen nutzen
- ✅ Code sinnvoll in Module aufteilen für bessere Struktur
- ✅ Unterschied zwischen Standard-Bibliothek und externen Paketen verstehen

## Vorbereitung für nachfolgende Module

Das Modul bereitet vor auf:
- **M17:** PEP 8 und Code-Dokumentation (Modul-Dokumentation)
- **M18:** Best Practices für sauberen Code (Modularisierung)
- **M21-29:** OOP (Module vs. Klassen-basierte Strukturierung)
- **M33-35:** Unit Testing (Module testen)