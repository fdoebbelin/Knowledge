## Beispieldaten

```sql
CREATE TABLE Bestellungen (
    BestellID INT PRIMARY KEY,
    Kunde VARCHAR(50),
    Produkt VARCHAR(50),
    Kategorie VARCHAR(50),
    Menge INT,
    PreisProEinheit DECIMAL(10, 2),
    Bestelldatum DATE
);
INSERT INTO Bestellungen (BestellID, Kunde, Produkt, Kategorie, Menge, PreisProEinheit, Bestelldatum) VALUES
(1, 'Max Mustermann', 'Laptop', 'Elektronik', 1, 1200.00, '2025-01-15'),
(2, 'Erika Musterfrau', 'Smartphone', 'Elektronik', 2, 800.00, '2025-01-17'),
(3, 'Hans Meier', 'Kaffeemaschine', 'Haushaltsgeräte', 1, 150.00, '2025-01-20'),
(4, 'Anna Schmidt', 'Bürostuhl', 'Möbel', 4, 85.00, '2025-01-22'),
(5, 'Max Mustermann', 'Monitor', 'Elektronik', 2, 300.00, '2025-01-25'),
(6, 'Erika Musterfrau', 'Schreibtisch', 'Möbel', 1, 450.00, '2025-01-28'),
(7, 'Hans Meier', 'Staubsauger', 'Haushaltsgeräte', 1, 200.00, '2025-02-02'),
(8, 'Anna Schmidt', 'Tablet', 'Elektronik', 3, 600.00, '2025-02-05'),
(9, 'Max Mustermann', 'Kopfhörer', 'Elektronik', 5, 150.00, '2025-02-10'),
(10, 'Erika Musterfrau', 'Mikrowelle', 'Haushaltsgeräte', 1, 120.00, '2025-02-12');
```

## Einführung in Aggregatfunktionen

Aggregatfunktionen in SQL ermöglichen es, Berechnungen über mehrere Zeilen durchzuführen und ein einzelnes Ergebnis zurückzugeben. Die am häufigsten verwendeten Aggregatfunktionen sind:

1. `COUNT()`: Zählt die Anzahl der Zeilen oder Nicht-NULL-Werte.
2. `SUM()`: Berechnet die Summe numerischer Werte.
3. `AVG()`: Berechnet den Durchschnitt numerischer Werte.
4. `MAX()`: Findet den höchsten Wert.
5. `MIN()`: Findet den niedrigsten Wert.

## COUNT()-Funktion

Die `COUNT()`-Funktion wird verwendet, um die Anzahl der Zeilen in einer Ergebnismenge zu zählen. Sie kann auf verschiedene Weisen eingesetzt werden:

- `COUNT(*)`: Zählt alle Zeilen, einschließlich NULL-Werte.
- `COUNT(spaltenname)`: Zählt alle Nicht-NULL-Werte in der angegebenen Spalte.
- `COUNT(DISTINCT spaltenname)`: Zählt die eindeutigen Nicht-NULL-Werte in der Spalte.

Beispiel:
```sql
-- Anzahl der Bestellungen insgesamt.
SELECT COUNT(*) AS AnzahlBestellungen FROM Bestellungen;
-- Anzahl der Kunden
SELECT COUNT(DISTINCT Kunde) FROM Bestellungen;
```

## SUM()-Funktion

Die `SUM()`-Funktion berechnet die Summe aller Werte in einer numerischen Spalte.

Beispiel:
```sql
-- Gesamterlös aller Bestellungen.
SELECT SUM(Menge * PreisProEinheit) AS Gesamterloes FROM Bestellungen;
```

## AVG()-Funktion

Die `AVG()`-Funktion berechnet den Durchschnitt der Werte in einer numerischen Spalte.

Beispiel:
```sql
-- Durchschnittlicher Bestellwert.
SELECT AVG(Menge * PreisProEinheit) AS DurchschnittlicherBestellwert FROM Bestellungen;
```

## MAX() und MIN()-Funktionen

Diese Funktionen finden den höchsten bzw. niedrigsten Wert in einer Spalte.

Beispiel:
```sql
-- Höchster Bestellwert.
SELECT MAX(Menge * PreisProEinheit) AS HoechsterBestellwert FROM Bestellungen;
-- Niedrigster Bestellwert.
SELECT MIN(Menge * PreisProEinheit) AS NiedrigsterBestellwert FROM Bestellungen;
```

## Gruppierung mit GROUP BY

Die `GROUP BY`-Klausel wird verwendet, um Zeilen in Gruppen zusammenzufassen. Sie wird oft in Verbindung mit Aggregatfunktionen eingesetzt, um Berechnungen für jede Gruppe durchzuführen.

Syntax:
```sql
SELECT spalte1, aggregatfunktion(spalte2)
FROM tabelle
GROUP BY spalte1;
```

Beispiel:
```sql
-- Aggregatfunktionen für jede Kategorie zu berechnen
SELECT Kategorie, SUM(Menge * PreisProEinheit) AS GesamterloesProKategorie
FROM Bestellungen
GROUP BY Kategorie;
```

Hinweis: Alle Spalten in der `SELECT`-Anweisung, die nicht Teil einer Aggregatfunktion sind, müssen in der `GROUP BY`-Klausel aufgeführt werden.

## Mehrfache Gruppierung

Es ist möglich, nach mehreren Spalten zu gruppieren:

```sql
SELECT abteilung, position, AVG(gehalt)
FROM mitarbeiter
GROUP BY abteilung, position;
```

## HAVING-Klausel

Die HAVING-Klausel wird verwendet, um Bedingungen auf gruppierte Daten anzuwenden. Sie ist ähnlich wie die WHERE-Klausel, wird aber nach der Gruppierung angewendet.

Syntax:
```sql
SELECT spalte1, aggregatfunktion(spalte2)
FROM tabelle
GROUP BY spalte1
HAVING bedingung;
```

Beispiel:
```sql
-- Gesamterlös für jede Produktkategorie
SELECT Kategorie, SUM(Menge * PreisProEinheit) AS GesamterloesProKategorie
FROM Bestellungen
GROUP BY Kategorie
HAVING SUM(Menge * PreisProEinheit) > 1000;
```
## Unterschied zwischen WHERE und HAVING

- `WHERE` wird vor der Gruppierung angewendet und filtert einzelne Zeilen.
- `HAVING` wird nach der Gruppierung angewendet und filtert Gruppen.

Beispiel für die Kombination von WHERE und HAVING:
```sql
SELECT abteilung, AVG(gehalt)
FROM mitarbeiter
WHERE einstellungsdatum > '2020-01-01'
GROUP BY abteilung
HAVING AVG(gehalt) > 50000;
```

## Praktische Anwendungen

- Verkaufsanalyse: Gesamtumsatz pro Produkt oder Kategorie.
- Kundenanalyse: Durchschnittlicher Bestellwert pro Kunde.
- Mitarbeiterleistung: Anzahl der abgeschlossenen Projekte pro Abteilung.
- Lagerbestand: Minimaler und maximaler Bestand pro Produktkategorie.