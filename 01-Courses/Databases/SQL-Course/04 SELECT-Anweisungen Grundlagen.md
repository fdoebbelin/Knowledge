## Einführung in SELECT-Anweisungen

Die SELECT-Anweisung ist der grundlegende Befehl in SQL, um Daten aus einer Datenbank abzufragen. Sie ermöglicht es uns, spezifische Daten aus einer oder mehreren Tabellen zu extrahieren, zu filtern und zu sortieren.

Die grundlegende Syntax einer SELECT-Anweisung lautet:

```sql
SELECT spalte1, spalte2, ...
FROM tabelle
WHERE bedingung;
```

## Auswählen von Spalten

- Um alle Spalten einer Tabelle auszuwählen, verwenden wir den Asterisk (*):

```sql
SELECT * FROM mitarbeiter;
```

- Um spezifische Spalten auszuwählen, listen wir diese nach dem SELECT-Keyword auf:

```sql
SELECT vorname, nachname, gehalt FROM mitarbeiter;
```

- Wir können auch Berechnungen oder Funktionen in der SELECT-Anweisung verwenden:

```sql
SELECT vorname, nachname, gehalt * 1.1 AS erhoehtes_gehalt FROM mitarbeiter;
```

## Filtern mit WHERE

Die WHERE-Klausel ermöglicht es uns, die Ergebnisse basierend auf bestimmten Bedingungen zu filtern.

- Einfache Vergleiche:

```sql
SELECT * FROM mitarbeiter WHERE abteilung = 'Verkauf';
```

- Numerische Vergleiche:

```sql
SELECT * FROM mitarbeiter WHERE gehalt > 50000;
```

- Verwendung von logischen Operatoren (AND, OR, NOT):

```sql
SELECT * FROM mitarbeiter WHERE abteilung = 'Verkauf' AND gehalt > 50000;
```

- Verwendung von IN für mehrere mögliche Werte:

```sql
SELECT * FROM mitarbeiter WHERE abteilung IN ('Verkauf', 'Marketing');
```

- Verwendung von BETWEEN für Wertebereiche:

```sql
SELECT * FROM mitarbeiter WHERE gehalt BETWEEN 40000 AND 60000;
```

## Sortieren mit ORDER BY

Die ORDER BY-Klausel wird verwendet, um die Ergebnisse nach einer oder mehreren Spalten zu sortieren.

- Aufsteigende Sortierung (Standard):

```sql
SELECT * FROM mitarbeiter ORDER BY nachname;
```

- Absteigende Sortierung:

```sql
SELECT * FROM mitarbeiter ORDER BY gehalt DESC;
```

- Sortierung nach mehreren Spalten:

```sql
SELECT * FROM mitarbeiter ORDER BY abteilung, gehalt DESC;
```

## Entfernen von Duplikaten mit DISTINCT

Das DISTINCT-Keyword wird verwendet, um doppelte Zeilen aus dem Ergebnis zu entfernen.

```sql
SELECT DISTINCT abteilung FROM mitarbeiter;
```

## Begrenzung der Ergebnismenge

Je nach verwendetem DBMS können wir die Anzahl der zurückgegebenen Zeilen begrenzen:

- In MySQL und PostgreSQL:

```sql
SELECT * FROM mitarbeiter LIMIT 10;
```

- In SQL Server:

```sql
SELECT TOP 10 * FROM mitarbeiter;
```

## Verwendung von Platzhaltern

Platzhalter können in Verbindung mit dem LIKE-Operator verwendet werden, um nach Mustern in Zeichenketten zu suchen.

- % steht für beliebig viele Zeichen:

```sql
SELECT * FROM mitarbeiter WHERE nachname LIKE 'Mü%';
```

- _ steht für genau ein Zeichen:

```sql
SELECT * FROM mitarbeiter WHERE vorname LIKE 'Ann_';
```

## Zusammenfassung

Die SELECT-Anweisung ist das Fundament für das Abfragen von Daten in SQL. Mit den Klauseln WHERE, ORDER BY und den Konzepten wie DISTINCT und LIMIT können wir präzise und effizient die gewünschten Daten aus unserer Datenbank extrahieren. Die Beherrschung dieser Grundlagen ist entscheidend für die effektive Arbeit mit Datenbanken und bildet die Basis für fortgeschrittenere SQL-Konzepte.