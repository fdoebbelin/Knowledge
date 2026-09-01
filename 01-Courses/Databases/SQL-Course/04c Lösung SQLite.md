
```sql
-- Löschen der Tabelle, falls sie existiert
DROP TABLE IF EXISTS Mitarbeiter;

-- Erstellen der Tabelle "Mitarbeiter"
CREATE TABLE Mitarbeiter (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vorname VARCHAR(50) NOT NULL,
    nachname VARCHAR(50) NOT NULL,
    abteilung VARCHAR(50) NOT NULL,
    gehalt DECIMAL(10,2) NOT NULL,
    einstellungsdatum DATE NOT NULL
);

-- Einfügen von Beispieldaten
INSERT INTO Mitarbeiter (vorname, nachname, abteilung, gehalt, einstellungsdatum) VALUES
('Anna', 'Müller', 'Verkauf', 48000, '2015-06-15'),
('Bernd', 'Schmidt', 'IT', 55000, '2012-09-10'),
('Clara', 'Meier', 'Marketing', 52000, '2018-03-23'),
('David', 'Müller', 'Verkauf', 47000, '2019-07-01'),
('Elena', 'Fischer', 'Personal', 60000, '2010-05-11'),
('Frank', 'Schneider', 'IT', 75000, '2008-11-21'),
('Gabi', 'Weber', 'Finanzen', 65000, '2014-02-14'),
('Hannes', 'Maier', 'Marketing', 49000, '2016-08-30'),
('Isabel', 'Krüger', 'Verkauf', 51000, '2013-12-05'),
('Jürgen', 'Meyer', 'IT', 72000, '2005-04-25');

-- 1. Alle Spalten und Zeilen anzeigen
SELECT * FROM Mitarbeiter;

-- 2. Nur Vornamen und Nachnamen aller Mitarbeiter
SELECT vorname, nachname FROM Mitarbeiter;

-- 3. Alle Mitarbeiter in der Abteilung "Verkauf"
SELECT * FROM Mitarbeiter WHERE abteilung = 'Verkauf';

-- 4. Namen und Gehälter aller Mitarbeiter mit Gehalt über 50.000, absteigend sortiert
SELECT vorname, nachname, gehalt FROM Mitarbeiter WHERE gehalt > 50000 ORDER BY gehalt DESC;

-- 5. Unterschiedliche Abteilungen (ohne Duplikate)
SELECT DISTINCT abteilung FROM Mitarbeiter;

-- 6. Die 5 am längsten beschäftigten Mitarbeiter
SELECT * FROM Mitarbeiter ORDER BY einstellungsdatum ASC LIMIT 5;

-- 7. Mitarbeiter, deren Nachname mit "M" beginnt
SELECT * FROM Mitarbeiter WHERE nachname LIKE 'M%';

-- 8. Alle Mitarbeiter, sortiert nach Abteilung (aufsteigend) und innerhalb der Abteilung nach Gehalt (absteigend)
SELECT * FROM Mitarbeiter ORDER BY abteilung ASC, gehalt DESC;
```
