## Einführung in Unterabfragen

Unterabfragen, auch als verschachtelte Abfragen oder Subqueries bekannt, sind SQL-Anweisungen, die in andere SQL-Anweisungen eingebettet sind. Sie ermöglichen komplexe Abfragen und können die Leistungsfähigkeit von SQL-Anweisungen erheblich steigern.

## Arten von Unterabfragen

### 1. Unterabfragen in WHERE-Klauseln

Unterabfragen in WHERE-Klauseln werden verwendet, um die Ergebnismenge der Hauptabfrage basierend auf den Ergebnissen der Unterabfrage zu filtern.

Beispiel:
```sql
SELECT produktname
FROM produkte
WHERE preis > (SELECT AVG(preis) FROM produkte);
```

Diese Abfrage gibt alle Produkte zurück, deren Preis über dem Durchschnittspreis liegt.

### 2. Unterabfragen in FROM-Klauseln

Unterabfragen in FROM-Klauseln werden verwendet, um eine temporäre Tabelle zu erstellen, die dann in der Hauptabfrage verwendet wird.

Beispiel:
```sql
SELECT abteilung, durchschnittsgehalt
FROM (SELECT abteilung, AVG(gehalt) AS durchschnittsgehalt
      FROM mitarbeiter
      GROUP BY abteilung) AS abteilungsdurchschnitte
WHERE durchschnittsgehalt > 50000;
```

Diese Abfrage zeigt Abteilungen mit einem durchschnittlichen Gehalt über 50.000.

### 3. Korrelierte Unterabfragen

Korrelierte Unterabfragen sind Unterabfragen, die von der äußeren Abfrage abhängen und für jede Zeile der äußeren Abfrage ausgeführt werden.

Beispiel:
```sql
SELECT mitarbeitername
FROM mitarbeiter m
WHERE gehalt > (SELECT AVG(gehalt)
                FROM mitarbeiter
                WHERE abteilung = m.abteilung);
```

Diese Abfrage findet Mitarbeiter, die mehr als der Durchschnitt ihrer Abteilung verdienen.

## Verwendung von EXISTS und NOT EXISTS

EXISTS und NOT EXISTS werden verwendet, um zu prüfen, ob eine Unterabfrage Ergebnisse zurückgibt.

Beispiel mit EXISTS:
```sql
SELECT kundenname
FROM kunden
WHERE EXISTS (SELECT 1
              FROM bestellungen
              WHERE bestellungen.kundennummer = kunden.kundennummer);
```

Diese Abfrage findet alle Kunden, die mindestens eine Bestellung aufgegeben haben.

Beispiel mit NOT EXISTS:
```sql
SELECT produktname
FROM produkte
WHERE NOT EXISTS (SELECT 1
                  FROM bestellpositionen
                  WHERE bestellpositionen.produktid = produkte.produktid);
```

Diese Abfrage findet alle Produkte, die noch nie bestellt wurden.

## Vergleichsoperatoren mit Unterabfragen

Unterabfragen können mit verschiedenen Vergleichsoperatoren verwendet werden:

- IN: Prüft, ob ein Wert in der Ergebnismenge der Unterabfrage enthalten ist.
- ANY/SOME: Vergleicht einen Wert mit jeder Zeile in der Unterabfrage.
- ALL: Vergleicht einen Wert mit allen Zeilen in der Unterabfrage.

Beispiel mit IN:
```sql
SELECT mitarbeitername
FROM mitarbeiter
WHERE abteilung IN (SELECT abteilung
                    FROM abteilungen
                    WHERE standort = 'New York');
```

Diese Abfrage findet alle Mitarbeiter, die in einer Abteilung in New York arbeiten.

## Leistungsaspekte von Unterabfragen

- Unterabfragen können die Lesbarkeit und Wartbarkeit von SQL-Code verbessern.
- In einigen Fällen können Joins effizienter sein als korrelierte Unterabfragen.
- Die Leistung von Unterabfragen kann durch geeignete Indexierung verbessert werden.
- Komplexe Unterabfragen sollten auf ihre Ausführungszeit getestet und gegebenenfalls optimiert werden.

## Übungen zu Unterabfragen

1. Schreiben Sie eine Abfrage, die alle Produkte findet, deren Preis höher ist als der Durchschnittspreis aller Produkte.

2. Finden Sie alle Kunden, die in diesem Jahr mehr ausgegeben haben als der Durchschnittskunde.

3. Erstellen Sie eine Liste aller Mitarbeiter, die keine Verkäufe getätigt haben.

4. Finden Sie die Abteilung mit dem höchsten durchschnittlichen Gehalt.

5. Identifizieren Sie alle Produkte, die in allen Filialen verfügbar sind.

Diese Übungen sollen den Teilnehmern helfen, ihr Verständnis für Unterabfragen zu vertiefen und praktische Erfahrungen zu sammeln.