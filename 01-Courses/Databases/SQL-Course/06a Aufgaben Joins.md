## Übersicht der SQL-Befehle

1. `INNER JOIN`: Verknüpft zwei Tabellen basierend auf einer Bedingung und gibt nur übereinstimmende Zeilen zurück.
2. `LEFT JOIN`: Gibt alle Zeilen der linken Tabelle und die übereinstimmenden Zeilen der rechten Tabelle zurück.
3. `RIGHT JOIN`: Gibt alle Zeilen der rechten Tabelle und die übereinstimmenden Zeilen der linken Tabelle zurück.
4. `ON`: Spezifiziert die Bedingung für den Join.
5. `WHERE`: Filtert die Ergebnisse nach dem Join.
6. `ORDER BY`: Sortiert die Ergebnisse.

## Tabellendeklarationen

```sql
CREATE TABLE Kunden (
    KundenID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100)
);

CREATE TABLE Bestellungen (
    BestellID INT PRIMARY KEY,
    KundenID INT,
    Datum DATE
    FOREIGN KEY (KundenID) REFERENCES Kunden(KundenID)
);

CREATE TABLE Produkte (
    ProduktID INT PRIMARY KEY,
    Name VARCHAR(100),
    Preis DECIMAL(10, 2)
);

CREATE TABLE Bestellpositionen (
    PositionID INT PRIMARY KEY,
    BestellID INT,
    ProduktID INT,
    Menge INT,
    FOREIGN KEY (BestellID) REFERENCES Bestellungen(BestellID),
    FOREIGN KEY (ProduktID) REFERENCES Produkte(ProduktID)
);
```
## Beispieldaten

```sql
-- Kunden Tabelle
INSERT INTO Kunden (KundenID, Name, Email) VALUES
(1, 'Max Mustermann', 'max.mustermann@example.com'),
(2, 'Erika Musterfrau', 'erika.musterfrau@example.com'),
(3, 'Hans Meier', 'hans.meier@example.com'),
(4, 'Anna Schmidt', 'anna.schmidt@example.com');

-- Bestellungen Tabelle
INSERT INTO Bestellungen (BestellID, KundenID, Datum) VALUES
(1, 1, '2025-02-01'),
(2, 2, '2025-02-02'),
(3, 1, '2025-02-03'),
(4, 3, '2025-02-04');

-- Produkte Tabelle
INSERT INTO Produkte (ProduktID, Name, Preis) VALUES
(1, 'Laptop', 1000.00),
(2, 'Maus', 25.00),
(3, 'Tastatur', 45.00),
(4, 'Monitor', 200.00)
(5, 'USB-Stick', 10.00);

-- Bestellpositionen Tabelle
INSERT INTO Bestellpositionen (PositionID, BestellID, ProduktID, Menge) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 3, 4, 1),
(5, 4, 1, 2),
(6, 4, 2, 1);
```
## Aufgaben

### 1. INNER JOIN:
   Erstellen Sie eine Liste aller Bestellungen mit den zugehörigen Kundennamen. Verwenden Sie einen INNER JOIN zwischen den Tabellen Kunden und Bestellungen.

### 2. LEFT JOIN:
   Zeigen Sie alle Kunden an, auch wenn sie keine Bestellungen aufgegeben haben. Verwenden Sie einen LEFT JOIN zwischen Kunden und Bestellungen.

### 3. RIGHT JOIN:
   Listen Sie alle Produkte auf, auch wenn sie nicht bestellt wurden. Verwenden Sie einen RIGHT JOIN zwischen Bestellpositionen und Produkte.

### 4. Mehrfache Joins:
   Erstellen Sie eine Übersicht aller Bestellungen mit Kundenname, Produktname und bestellter Menge. Verwenden Sie Joins zwischen Kunden, Bestellungen, Bestellpositionen und Produkte.

### 5. Joins mit Filterung:
   Zeigen Sie alle Kunden an, die Bestellungen mit einem Gesamtbetrag von über 1000 aufgegeben haben. Verwenden Sie einen `JOIN` und eine `WHERE`-Klausel.

### 6. Joins mit Sortierung:
   Listen Sie alle Produkte und die Anzahl ihrer Bestellungen auf, sortiert nach der Bestellhäufigkeit in absteigender Reihenfolge. Verwenden Sie einen `LEFT JOIN` und `GROUP BY`.

### 7. Selbst-Join:
   Erweitern Sie die Kunden-Tabelle um eine zusätzliche Spalte "`EmpfohlenVon`", die auf die KundenID eines anderen Kunden verweist. Erstellen Sie eine Abfrage, die jeden Kunden mit dem Namen des Kunden anzeigt, der ihn empfohlen hat.

```sql
-- Hinzufügen der Spalte "EmpfohlenVon" zur Tabelle "Kunden"
ALTER TABLE Kunden
ADD COLUMN EmpfohlenVon INTEGER;
  
-- Erika Musterfrau wurde von Max Mustermann empfohlen
UPDATE Kunden
SET EmpfohlenVon = 1
WHERE KundenID = 2;

-- Hans Meier wurde von Max Mustermann empfohlen
UPDATE Kunden
SET EmpfohlenVon = 1
WHERE KundenID = 3;

-- Anna Schmidt wurde von Erika Musterfrau empfohlen
UPDATE Kunden
SET EmpfohlenVon = 2
WHERE KundenID = 4;
```
