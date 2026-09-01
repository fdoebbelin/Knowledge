
## 1. Normalform (1NF)

**Nicht normalisierte Tabelle "`Mitarbeiterbestellungen`":**

| MitarbeiterID | Name         | Abteilung | Bestellungen           |
| ------------- | ------------ | --------- | ---------------------- |
| M1            | Anna Schmidt | Vertrieb  | Laptop, Maus           |
| M2            | Peter Schulz | Marketing | Drucker, Papier, Toner |

**Tabelle in 1NF:**

| MitarbeiterID | BestellID | Vorname | Nachname | Abteilung | Bestellung |
| ------------- | --------- | ------- | -------- | --------- | ---------- |
| M1            | B1        | Anna    | Schmidt  | Vertrieb  | Laptop     |
| M1            | B2        | Anna    | Schmidt  | Vertrieb  | Maus       |
| M2            | B3        | Peter   | Schulz   | Marketing | Drucker    |
| M2            | B4        | Peter   | Schulz   | Marketing | Papier     |
| M2            | B5        | Peter   | Schulz   | Marketing | Toner      |

- **Erklärung:** 
	- In der 1NF werden die Bestellungen in separate Zeilen aufgeteilt, sodass jeder Wert atomar ist. 
	- Zusätzlich wird der Name in Vorname und Nachname aufgeteilt.
	- `MitarbeiterID` + `BestellID` bilden den **zusammengesetzen Primärschlüssel**

## 2. Normalform (2NF)

**Tabellen in 2NF:**

Mitarbeiter:

| MitarbeiterID | Vorname | Nachname | Abteilung |
|---------------|---------|----------|-----------|
| M1 | Anna | Schmidt | Vertrieb |
| M2 | Peter | Schulz | Marketing |

Bestellungen:

| BestellID | MitarbeiterID | Artikel |
|-----------|---------------|---------|
| B1 | M1 | Laptop |
| B2 | M1 | Maus |
| B3 | M2 | Drucker |
| B4 | M2 | Papier |
| B5 | M2 | Toner |

- **Erklärung:** 
	- In der 2NF werden die Informationen in separate Tabellen aufgeteilt, sodass keine Attribute von Teilschlüsseln abhängig sind. 
	- Die Mitarbeiterinformationen und Bestellungen werden getrennt.

## 3. Normalform (3NF)

**Tabellen in 3NF:**

Mitarbeiter:

| MitarbeiterID | Vorname | Nachname | AbteilungID |
| ------------- | ------- | -------- | ----------- |
| M1            | Anna    | Schmidt  | A1          |
| M2            | Peter   | Schulz   | A2          |

Abteilung:

| AbteilungID | Abteilung | Abteilungsleiter |
|-------------|-----------|-------------------|
| A1 | Vertrieb | Thomas Müller |
| A2 | Marketing | Lisa Wagner |

Bestellungen:

| BestellID | MitarbeiterID | ArtikelID |
|-----------|---------------|-----------|
| B1 | M1 | AR1 |
| B2 | M1 | AR2 |
| B3 | M2 | AR3 |
| B4 | M2 | AR4 |
| B5 | M2 | AR5 |

Artikel:

| ArtikelID | Artikelname | Preis |
|-----------|-------------|-------|
| AR1 | Laptop | 999.99 |
| AR2 | Maus | 29.99 |
| AR3 | Drucker | 199.99 |
| AR4 | Papier | 4.99 |
| AR5 | Toner | 49.99 |

- **Erklärung:** 
	- In der 3NF werden transitive Abhängigkeiten aufgelöst. 
	- Die Abteilungsinformationen und Artikeldetails werden in separate Tabellen ausgelagert.

Diese Normalisierung bietet mehrere Vorteile:

1. **Reduzierte Redundanz:** 
	- Informationen werden nur einmal gespeichert.
2. **Verbesserte Datenintegrität:** 
	- Änderungen müssen nur an einer Stelle vorgenommen werden.
3. **Flexibilität:** 
	- Neue Einträge können einfach hinzugefügt werden, ohne andere Tabellen zu beeinflussen.
4. **Effizienz:** 
	- Abfragen können gezielt auf die benötigten Daten zugreifen.

Die schrittweise Überführung in höhere Normalformen und die Zerlegung von Relationen bei Bedarf optimieren die Datenbankstruktur. 