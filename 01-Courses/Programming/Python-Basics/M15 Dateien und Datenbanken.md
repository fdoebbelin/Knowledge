## Lernziele
- Textdateien sicher lesen und schreiben
- Einfache CSV-Dateien für Datenaus- und -eingabe verwenden
- JSON-Dateien für strukturierte Daten verstehen
- Erste Schritte mit SQLite-Datenbanken machen
- Unterscheiden, wann Dateien oder Datenbanken besser geeignet sind
- Einfache Fehlerbehandlung bei Dateioperationen anwenden
## 1. Textdateien lesen und schreiben
### 1.1 Erste Schritte mit Dateien
- Einfache Datei erstellen und schreiben
- Datei wieder einlesen
- `with`-Statement für automatisches Schließen
- Unterschied zwischen Lesen und Schreiben
### 1.2 Mit Listen in Dateien arbeiten
- Liste von Strings in Datei speichern
- Zeilenweise Verarbeitung
- `strip()` für Zeilenendezeichen
- Listen aus Dateien rekonstruieren
### 1.3 Fehlerbehandlung bei Dateien
- `FileNotFoundError` abfangen
- Try-except für Dateioperationen
- Sichere Funktionen für Dateizugriff
- Fallback-Strategien implementieren
## 2. CSV-Dateien für Tabellendaten
### 2.1 CSV verstehen und erstellen
- CSV-Format Grundlagen
- `csv`-Modul importieren
- Tabellendaten als verschachtelte Listen
- `csv.writer()` für Dateierstellung
- `newline=""` Parameter verstehen
### 2.2 CSV-Dateien lesen
- `csv.reader()` für Zeilenverarbeitung
- Header-Zeile separat behandeln
- Daten in Variablen entpacken
- Iteration über CSV-Zeilen
### 2.3 Mit Dictionaries arbeiten
- `csv.DictReader()` für benannte Spalten
- Spaltennamen als Dictionary-Keys
- `csv.DictWriter()` für strukturierte Ausgabe
- Fieldnames definieren und Header schreiben
## 3. JSON für strukturierte Daten
### 3.1 JSON verstehen
- JSON-Format vs. Python-Dictionary
- Verschachtelte Datenstrukturen
- Unterstützte Datentypen
- `json`-Modul importieren
### 3.2 JSON lesen und schreiben
- `json.dump()` für Dateierstellung
- `indent`-Parameter für Formatierung
- `json.load()` für Dateien einlesen
- Zugriff auf verschachtelte Daten
### 3.3 JSON-Daten verarbeiten
- Listen von Dictionaries verwalten
- Daten sortieren und filtern
- JSON für Konfigurationsdateien
- Strukturierte Datenverarbeitung
## 4. Erste Schritte mit SQLite
### 4.1 Datenbank erstellen und Tabelle anlegen
- `sqlite3`-Modul verwenden
- Datenbankverbindung herstellen
- `CREATE TABLE` Statement
- Datentypen: INTEGER, TEXT, REAL
- Primary Key verstehen
### 4.2 Daten einfügen und lesen
- `INSERT INTO` für einzelne Datensätze
- Parametrisierte Queries mit `?`
- `executemany()` für mehrere Datensätze
- `SELECT` Statements
- `fetchall()` und `fetchone()`
### 4.3 Daten filtern und aktualisieren
- `WHERE`-Klauseln für Filterung
- `UPDATE` Statements
- Daten gezielt ändern
- Verbindung ordnungsgemäß schließen