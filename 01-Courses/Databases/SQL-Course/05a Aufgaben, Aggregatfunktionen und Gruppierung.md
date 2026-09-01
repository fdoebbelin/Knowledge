## Übersicht der SQL-Befehle

- COUNT()
- SUM()
- AVG()
- MAX()
- MIN()
- GROUP BY
- HAVING

## Kurzbeschreibung der SQL-Befehle

- COUNT():
   - Zählt die Anzahl der Zeilen oder Nicht-NULL-Werte in einer Spalte.
   - Syntax: COUNT(*) oder COUNT(spaltenname)

- SUM():
   - Berechnet die Summe aller Werte in einer numerischen Spalte.
   - Syntax: SUM(spaltenname)

- AVG():
   - Berechnet den Durchschnitt der Werte in einer numerischen Spalte.
   - Syntax: AVG(spaltenname)

- MAX():
   - Findet den höchsten Wert in einer Spalte.
   - Syntax: MAX(spaltenname)

- MIN():
   - Findet den niedrigsten Wert in einer Spalte.
   - Syntax: MIN(spaltenname)

- GROUP BY:
   - Gruppiert Zeilen basierend auf einer oder mehreren Spalten.
   - Syntax: GROUP BY spalte1, spalte2, ...

- HAVING:
   - Filtert gruppierte Daten basierend auf einer Bedingung.
   - Syntax: HAVING bedingung

## Aufgaben

Verwenden Sie die folgende Beispiel-Datenbank für die Aufgaben:

```sql
CREATE TABLE verkaufe (
    id INT PRIMARY KEY,
    produkt VARCHAR(50),
    kategorie VARCHAR(50),
    preis DECIMAL(10, 2),
    menge INT,
    verkaufsdatum DATE
);

INSERT INTO verkaufe VALUES
(1, 'Laptop', 'Elektronik', 999.99, 5, '2023-01-15'),
(2, 'Smartphone', 'Elektronik', 599.99, 10, '2023-01-16'),
(3, 'Tisch', 'Möbel', 299.99, 3, '2023-01-17'),
(4, 'Stuhl', 'Möbel', 99.99, 8, '2023-01-18'),
(5, 'Tablet', 'Elektronik', 399.99, 6, '2023-01-19'),
(6, 'Sofa', 'Möbel', 799.99, 2, '2023-01-20'),
(7, 'Smartwatch', 'Elektronik', 249.99, 12, '2023-01-21'),
(8, 'Bücherregal', 'Möbel', 149.99, 4, '2023-01-22');
```

- Zählen Sie die Gesamtanzahl der Verkäufe.
- Berechnen Sie den Gesamtumsatz aller Verkäufe.
- Ermitteln Sie den durchschnittlichen Verkaufspreis pro Produkt.
- Finden Sie den teuersten und günstigsten Artikel.
- Gruppieren Sie die Verkäufe nach Kategorie und zählen Sie die Anzahl der Produkte in jeder Kategorie.
- Berechnen Sie den Gesamtumsatz pro Kategorie und zeigen Sie nur Kategorien mit einem Gesamtumsatz von mehr als 5000 an.
- Finden Sie die durchschnittliche Verkaufsmenge pro Kategorie für Produkte, die mehr als 200 kosten.

Hinweis: Verwenden Sie die entsprechenden SQL-Befehle aus der Übersicht, um diese Aufgaben zu lösen. Kombinieren Sie die Befehle, wo es nötig ist, um komplexere Abfragen zu erstellen.