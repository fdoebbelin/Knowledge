## Aufgabe 1: Alle Spalten und Zeilen anzeigen
```sql
SELECT * FROM mitarbeiter;
```
Diese Abfrage zeigt alle Spalten und Zeilen der Tabelle "Mitarbeiter" an. Der Asterisk (*) ist ein Platzhalter für alle Spalten.

## Aufgabe 2: Vornamen und Nachnamen auflisten
```sql
SELECT vorname, nachname FROM mitarbeiter;
```
Hier werden nur die Spalten "vorname" und "nachname" aus der Tabelle ausgewählt.

## Aufgabe 3: Mitarbeiter der Verkaufsabteilung
```sql
SELECT * FROM mitarbeiter WHERE abteilung = 'Verkauf';
```
Diese Abfrage filtert die Mitarbeiter, die in der Verkaufsabteilung arbeiten, indem die WHERE-Klausel verwendet wird.

## Aufgabe 4: Mitarbeiter mit Gehalt über 50.000
```sql
SELECT vorname, nachname, gehalt FROM mitarbeiter WHERE gehalt > 50000 ORDER BY gehalt DESC;
```
Hier werden Mitarbeiter mit einem Gehalt über 50.000 ausgewählt und nach Gehalt absteigend sortiert.

## Aufgabe 5: Unterschiedliche Abteilungen
```sql
SELECT DISTINCT abteilung FROM mitarbeiter;
```
DISTINCT entfernt Duplikate und zeigt jede Abteilung nur einmal an.

## Aufgabe 6: Die 5 am längsten beschäftigten Mitarbeiter
```sql
SELECT * FROM mitarbeiter ORDER BY einstellungsdatum ASC LIMIT 5;
```
Diese Abfrage sortiert nach Einstellungsdatum aufsteigend und begrenzt das Ergebnis auf 5 Zeilen.

## Aufgabe 7: Mitarbeiter mit Nachnamen beginnend mit "M"
```sql
SELECT * FROM mitarbeiter WHERE nachname LIKE 'M%';
```
Der LIKE-Operator mit 'M%' findet alle Nachnamen, die mit "M" beginnen.

## Aufgabe 8: Sortierung nach Abteilung und Gehalt
```sql
SELECT * FROM mitarbeiter ORDER BY abteilung ASC, gehalt DESC;
```
Diese Abfrage sortiert primär nach Abteilung aufsteigend und sekundär nach Gehalt absteigend.
