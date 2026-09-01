## Einführung in Tabellenverknüpfungen

Tabellenverknüpfungen, auch als `Joins` bezeichnet, sind ein fundamentales Konzept in relationalen Datenbanken. Sie ermöglichen es, Daten aus mehreren Tabellen in einer einzigen Abfrage zu kombinieren. Dies ist besonders wichtig in normalisierten Datenbanken, wo Informationen auf verschiedene Tabellen verteilt sind, um Redundanz zu vermeiden.

Erklären Sie den Teilnehmern, dass Joins auf der Basis von Beziehungen zwischen Tabellen durchgeführt werden, typischerweise über Primär- und Fremdschlüssel. Die grundlegende Syntax für einen Join lautet:

```sql
SELECT spalten
FROM tabelle1
JOIN tabelle2 
  ON tabelle1.schuessel = tabelle2.schuessel;
```

## INNER JOIN

- Der `INNER JOIN` ist der am häufigsten verwendete Join-Typ. 
- Er gibt nur die Zeilen zurück, für die in beiden verknüpften Tabellen übereinstimmende Werte existieren.

Syntax des INNER JOIN:

```sql
SELECT spalten
FROM tabelle1
INNER JOIN tabelle2 ON tabelle1.spalte = tabelle2.spalte;
```

Beispiel:
- Angenommen, wir haben eine Tabelle "`Bestellungen`" und eine Tabelle "`Kunden`". 
- Ein `INNER JOIN` könnte so aussehen:

```sql
SELECT Bestellungen.BestellID, Kunden.Name
FROM Bestellungen
INNER JOIN Kunden ON Bestellungen.KundenID = Kunden.KundenID;
```

Dieser `Join` gibt alle Bestellungen mit den zugehörigen Kundennamen zurück, aber nur für Kunden, die tatsächlich Bestellungen aufgegeben haben.

## LEFT JOIN

- Der `LEFT JOIN` (auch `LEFT OUTER JOIN` genannt) gibt alle Zeilen aus der linken Tabelle zurück, unabhängig davon, ob es übereinstimmende Zeilen in der rechten Tabelle gibt. 
- Wenn keine Übereinstimmung gefunden wird, werden `NULL`-Werte für die Spalten der rechten Tabelle zurückgegeben.

Syntax des `LEFT JOIN`:

```sql
SELECT spalten
FROM tabelle1
LEFT JOIN tabelle2 ON tabelle1.spalte = tabelle2.spalte;
```

Beispiel:

```sql
SELECT Kunden.Name, Bestellungen.BestellNr
FROM Kunden
LEFT JOIN Bestellungen ON Kunden.KundenID = Bestellungen.KundenID;
```

Dieser Join gibt alle Kunden zurück, auch solche ohne Bestellungen. Für Kunden ohne Bestellungen wird NULL in der BestellNr-Spalte angezeigt.

## RIGHT JOIN

- Der `RIGHT JOIN`(auch `RIGHT OUTER JOIN` genannt) funktioniert ähnlich wie der `LEFT JOIN`, aber in umgekehrter Richtung. 
- Er gibt alle Zeilen aus der rechten Tabelle zurück, unabhängig davon, ob es übereinstimmende Zeilen in der linken Tabelle gibt.

Syntax des RIGHT JOIN:

```sql
SELECT spalten
FROM tabelle1
RIGHT JOIN tabelle2 ON tabelle1.spalte = tabelle2.spalte;
```

Beispiel:

```sql
SELECT Bestellungen.BestellNr, Kunden.Name
FROM Bestellungen
RIGHT JOIN Kunden ON Bestellungen.KundenID = Kunden.KundenID;
```

Dieser Join gibt alle Kunden zurück, auch solche ohne Bestellungen. Das Ergebnis ist ähnlich dem des vorherigen LEFT JOIN-Beispiels, aber die Reihenfolge der Tabellen ist umgekehrt.

## Praktische Anwendungen von Joins

Erklären Sie den Teilnehmern, dass Joins in vielen realen Szenarien verwendet werden, zum Beispiel:

1. Verknüpfung von Transaktionsdaten mit Kundeninformationen
2. Zusammenführen von Produktdaten mit Lagerbestandsinformationen
3. Verbinden von Mitarbeiterdaten mit Abteilungsinformationen

## Hinweise zur Verwendung von Joins

4. Achten Sie auf die Leistung bei großen Datensätzen. Joins können ressourcenintensiv sein.
5. Verwenden Sie geeignete Indizes auf den Join-Spalten, um die Leistung zu verbessern.
6. Wählen Sie den richtigen Join-Typ basierend auf Ihren Anforderungen. Ein INNER JOIN kann Daten ausschließen, während OUTER JOINs alle Datensätze einer Seite beibehalten.
7. Vermeiden Sie unnötige Joins, da sie die Abfragekomplexität und -laufzeit erhöhen können.
8. Beachten Sie, dass einige Datenbanksysteme unterschiedliche Syntax oder Einschränkungen für bestimmte Join-Typen haben können.
