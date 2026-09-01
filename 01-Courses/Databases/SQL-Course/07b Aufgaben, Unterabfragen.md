## Übersicht der SQL-Befehle für Unterabfragen

1. **SELECT**: Hauptbefehl für Abfragen, kann Unterabfragen in verschiedenen Klauseln enthalten.
2. **WHERE**: Filtert Ergebnisse basierend auf Bedingungen, oft mit Unterabfragen verwendet.
3. **FROM**: Kann Unterabfragen als Datenquelle verwenden.
4. **IN**: Prüft, ob ein Wert in einer Ergebnismenge enthalten ist.
5. **EXISTS**: Prüft, ob eine Unterabfrage Ergebnisse liefert.
6. **ANY/SOME**: Vergleicht einen Wert mit jeder Zeile in der Unterabfrage.
7. **ALL**: Vergleicht einen Wert mit allen Zeilen in der Unterabfrage.

## Aufgaben

### 1. Unterabfragen in WHERE-Klauseln

Gegeben sei eine Tabelle `employees` mit den Spalten `employee_id`, `name`, `department`, und `salary`.

Aufgabe: Finden Sie alle Mitarbeiter, deren Gehalt über dem Durchschnittsgehalt liegt.
### 2. Unterabfragen in FROM-Klauseln

Gegeben seien die Tabellen `orders` (Spalten: `order_id`, `customer_id`, `order_date`, `total_amount`) und `customers` (Spalten: `customer_id`, `name`, `city`).

Aufgabe: Erstellen Sie eine Liste der Städte und ihrer durchschnittlichen Bestellsumme, aber nur für Städte, deren Durchschnittsbestellsumme über 1000 liegt.

### 3. Korrelierte Unterabfragen

Verwenden Sie die Tabelle `employees` aus Aufgabe 1.

Aufgabe: Finden Sie alle Mitarbeiter, die mehr verdienen als der Durchschnitt in ihrer Abteilung.