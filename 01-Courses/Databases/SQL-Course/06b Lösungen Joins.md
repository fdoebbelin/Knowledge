## Lösungen der Aufgaben

### 1. INNER JOIN

Erstellen Sie eine Liste aller Bestellungen mit den zugehörigen Kundennamen:

```sql
SELECT Bestellungen.BestellID, Kunden.Name
FROM Bestellungen
INNER JOIN Kunden ON Bestellungen.KundenID = Kunden.KundenID;
```

### 2. LEFT JOIN

Zeigen Sie alle Kunden an, auch wenn sie keine Bestellungen aufgegeben haben:

```sql
SELECT Kunden.Name, Bestellungen.BestellID
FROM Kunden
LEFT JOIN Bestellungen ON Kunden.KundenID = Bestellungen.KundenID;
```

### 3. RIGHT JOIN

Listen Sie alle Produkte auf, für die keine Bestellung vorliegt:

```sql
SELECT Produkte.Name AS Ladenhüter
FROM Bestellpositionen
RIGHT JOIN Produkte ON Bestellpositionen.ProduktID = Produkte.ProduktID
WHERE Bestellpositionen.Menge IS NULL;
```

### 4. Mehrfache Joins

Erstellen Sie eine Übersicht aller Bestellungen mit Kundenname, Produktname und bestellter Menge:

```sql
SELECT
	Bestellungen.BestellID, 
	Kunden.Name AS Kundenname, 
	Produkte.Name AS Produktname, 
	Bestellpositionen.Menge
FROM Bestellungen
JOIN Kunden 
	ON Bestellungen.KundenID = Kunden.KundenID
JOIN Bestellpositionen 
	ON Bestellungen.BestellID = Bestellpositionen.BestellID
JOIN Produkte 
	ON Bestellpositionen.ProduktID = Produkte.ProduktID;
```

### 5. Komplexe Joins

Zeigen Sie alle Kunden an, die Bestellungen mit einem Gesamtbetrag über 1000 aufgegeben haben:

```sql
SELECT
  Kunden.Name, Bestellungen.BestellID,
  SUM(Produkte.Preis * Bestellpositionen.Menge) AS Gesamtbetrag
FROM Bestellungen
JOIN Kunden ON Bestellungen.KundenID = Kunden.KundenID
JOIN Bestellpositionen ON Bestellungen.BestellID = Bestellpositionen.BestellID
JOIN Produkte ON Bestellpositionen.ProduktID = Produkte.ProduktID
GROUP BY Kunden.Name, Bestellungen.BestellID
HAVING SUM(Produkte.Preis * Bestellpositionen.Menge) > 1000;
```

### 6. Joins mit Sortierung

Listen Sie alle Produkte und die Anzahl ihrer Bestellungen auf, sortiert nach der Bestellhäufigkeit in absteigender Reihenfolge:

```sql
SELECT Produkte.Name AS Produktname, COUNT(Bestellpositionen.PositionID) AS Bestellanzahl
FROM Produkte
LEFT JOIN Bestellpositionen ON Produkte.ProduktID = Bestellpositionen.ProduktID
GROUP BY Produkte.Name
ORDER BY Bestellanzahl DESC;
```

### 7. Selbst-Join

Für diese Aufgabe müssen wir die Kunden-Tabelle um eine Spalte "EmpfohlenVon" erweitern. Da dies in der ursprünglichen Tabellenstruktur nicht vorgesehen war, zeigen wir hier nur ein Beispiel, wie die Abfrage aussehen würde:

```sql
SELECT K1.Name AS Kunde, K2.Name AS EmpfohlenVon
FROM Kunden K1
LEFT JOIN Kunden K2 ON K1.EmpfohlenVon = K2.KundenID;
```

Diese Abfrage würde jeden Kunden mit dem Namen des Kunden anzeigen, der ihn empfohlen hat. In unserem aktuellen Datensatz ist diese Information jedoch nicht vorhanden.