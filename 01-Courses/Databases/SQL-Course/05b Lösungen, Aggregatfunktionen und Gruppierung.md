## Aufgabe 1: Zählen Sie die Gesamtanzahl der Verkäufe

SQL-Befehl:
```sql
SELECT COUNT(*) AS gesamtanzahl_verkaeufe FROM verkaufe;
```

Ergebnis: 8 Verkäufe

Erklärung: Die COUNT(*)-Funktion zählt alle Zeilen in der Tabelle "verkaufe", unabhängig von den Werten in den Spalten.

## Aufgabe 2: Berechnen Sie den Gesamtumsatz aller Verkäufe

SQL-Befehl:
```sql
SELECT SUM(preis * menge) AS gesamtumsatz FROM verkaufe;
```

Ergebnis: 20299.5

Erklärung: Die SUM()-Funktion addiert die Produkte aus Preis und Menge für jeden Verkauf, um den Gesamtumsatz zu berechnen.

## Aufgabe 3: Ermitteln Sie den durchschnittlichen Verkaufspreis pro Produkt

SQL-Befehl:
```sql
SELECT AVG(preis) AS durchschnittlicher_preis FROM verkaufe;
```

Ergebnis: 449.99

Erklärung: Die AVG()-Funktion berechnet den Durchschnitt aller Preise in der Tabelle "verkaufe".

## Aufgabe 4: Finden Sie den teuersten und günstigsten Artikel

SQL-Befehl:
```sql
SELECT MAX(preis) AS teuerster_artikel, MIN(preis) AS guenstigster_artikel FROM verkaufe;
```

Ergebnis:
- Teuerster Artikel: 999.99
- Günstigster Artikel: 99.99

Erklärung: Die MAX()-Funktion findet den höchsten Preis, während die MIN()-Funktion den niedrigsten Preis ermittelt.

## Aufgabe 5: Gruppieren Sie die Verkäufe nach Kategorie und zählen Sie die Anzahl der Produkte in jeder Kategorie

SQL-Befehl:
```sql
SELECT kategorie, COUNT(*) AS anzahl_produkte FROM verkaufe GROUP BY kategorie;
```

Ergebnis:
- Elektronik: 4 Produkte
- Möbel: 4 Produkte

Erklärung: Die GROUP BY-Klausel gruppiert die Verkäufe nach Kategorie, und COUNT(*) zählt die Anzahl der Produkte in jeder Gruppe.

## Aufgabe 6: Berechnen Sie den Gesamtumsatz pro Kategorie und zeigen Sie nur Kategorien mit einem Gesamtumsatz von mehr als 5000 an

SQL-Befehl:
```sql
SELECT kategorie, SUM(preis * menge) AS gesamtumsatz 
FROM verkaufe 
GROUP BY kategorie 
HAVING gesamtumsatz > 5000;
```

Ergebnis:
- Elektronik: 16399.67

Erklärung: Die Abfrage gruppiert nach Kategorie, berechnet den Gesamtumsatz pro Kategorie und verwendet HAVING, um nur Kategorien mit einem Umsatz über 5000 anzuzeigen.

## Aufgabe 7: Finden Sie die durchschnittliche Verkaufsmenge pro Kategorie für Produkte, die mehr als 200 kosten

SQL-Befehl:
```sql
SELECT kategorie, AVG(menge) AS durchschnittliche_menge 
FROM verkaufe 
WHERE preis > 200 
GROUP BY kategorie;
```

Ergebnis:
- Elektronik: 8.25
- Möbel: 2.50

Erklärung: Die Abfrage filtert zunächst Produkte mit einem Preis über 200, gruppiert dann nach Kategorie und berechnet die durchschnittliche Verkaufsmenge für jede Kategorie.

Diese Lösungen demonstrieren die Verwendung verschiedener Aggregatfunktionen (COUNT, SUM, AVG, MAX, MIN) in Kombination mit GROUP BY und HAVING-Klauseln, um komplexe Analysen der Verkaufsdaten durchzuführen.