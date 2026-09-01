## Erstellung von Datenmodellen

- Identifizierung von Entitäten:
	- Relevante Objekte oder Konzepte aus dem Anwendungsbereich ermitteln
	- Beispiele: Kunde, Produkt, Bestellung
- Definition von Attributen:
	- Eigenschaften der Entitäten festlegen
	- Beispiele: Name, Preis, Datum
- Festlegung von Beziehungen:
	- Verbindungen zwischen Entitäten modellieren
	- Kardinalitäten bestimmen (1:1, 1:n, n:m)
- Schlüsselattribute:
	- Primärschlüssel zur eindeutigen Identifikation von Entitäten definieren
	- Fremdschlüssel für Beziehungen zwischen Entitäten festlegen

## Normalisierung von Datenstrukturen

- Ziel: Redundanzen vermeiden und Datenintegrität sicherstellen
- Normalformen:
	- 1. Normalform (1NF):
		- Atomare Werte, keine Wiederholungsgruppen
	- 2. Normalform (2NF):
		- 1NF + keine funktionalen Abhängigkeiten von Teilschlüsseln
	- 3. Normalform (3NF):
		- 2NF + keine transitiven Abhängigkeiten