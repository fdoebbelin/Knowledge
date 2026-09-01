## Übersicht der SQL-Befehle

Für die folgenden Übungen werden Sie diese grundlegenden SQL-Befehle verwenden:

1. SELECT
2. FROM
3. WHERE
4. ORDER BY
5. DISTINCT
6. LIMIT (oder TOP in SQL Server)
7. LIKE

## Kurzbeschreibung der SQL-Befehle

- **SELECT**: Wählt Spalten aus einer Tabelle aus.
   ```sql
   SELECT spalte1, spalte2 FROM tabelle;
   ```

- **FROM**: Gibt an, aus welcher Tabelle die Daten abgerufen werden sollen.
   ```sql
   SELECT * FROM tabelle;
   ```

- **WHERE**: Filtert Zeilen basierend auf einer Bedingung.
   ```sql
   SELECT * FROM tabelle WHERE bedingung;
   ```

- **ORDER BY**: Sortiert die Ergebnisse nach einer oder mehreren Spalten.
   ```sql
   SELECT * FROM tabelle ORDER BY spalte1 ASC, spalte2 DESC;
   ```

- **DISTINCT**: Entfernt Duplikate aus den Ergebnissen.
   ```sql
   SELECT DISTINCT spalte FROM tabelle;
   ```

- **LIMIT** (MySQL, PostgreSQL) oder **TOP** (SQL Server): Begrenzt die Anzahl der zurückgegebenen Zeilen.
   ```sql
   SELECT * FROM tabelle LIMIT 10;  -- MySQL, PostgreSQL
   SELECT TOP 10 * FROM tabelle;    -- SQL Server
   ```

- **LIKE**: Wird für Mustervergleiche in Zeichenketten verwendet.
   ```sql
   SELECT * FROM tabelle WHERE spalte LIKE 'Muster%';
   ```

## Daten

```sql
-- Erstellen der Tabelle "Mitarbeiter"
CREATE TABLE Mitarbeiter (
    id INT PRIMARY KEY AUTO_INCREMENT,
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
```

```sql

```


## Aufgaben

Verwenden Sie die oben genannten SQL-Befehle, um die folgenden Aufgaben zu lösen. 
Nutzen Sie dazu die Tabelle "`Mitarbeiter`" mit den Spalten: id, vorname, nachname, abteilung, gehalt, einstellungsdatum.

1. Zeigen Sie alle Spalten und Zeilen der Tabelle "Mitarbeiter" an.
2. Listen Sie nur die Vornamen und Nachnamen aller Mitarbeiter auf.
3. Zeigen Sie alle Mitarbeiter an, die in der Abteilung "Verkauf" arbeiten.
4. Listen Sie die Namen und Gehälter aller Mitarbeiter auf, deren Gehalt über 50.000 liegt, sortiert nach Gehalt in absteigender Reihenfolge.
5. Zeigen Sie die unterschiedlichen Abteilungen in der Firma an (ohne Duplikate).
6. Finden Sie die 5 am längsten beschäftigten Mitarbeiter, basierend auf ihrem Einstellungsdatum.
7. Suchen Sie nach allen Mitarbeitern, deren Nachname mit "M" beginnt.
8. Listen Sie alle Mitarbeiter auf, sortiert nach Abteilung (aufsteigend) und innerhalb jeder Abteilung nach Gehalt (absteigend).