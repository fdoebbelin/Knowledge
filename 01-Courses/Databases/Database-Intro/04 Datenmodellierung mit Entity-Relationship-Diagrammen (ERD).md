## 1. Einleitung
- Die Datenmodellierung ist ein essenzieller Schritt in der Entwicklung von Datenbanken. 
- Mithilfe von Entity-Relationship-Diagrammen (ERD) lassen sich reale Prozesse strukturiert abbilden, um eine logische und effiziente Datenbankstruktur zu erstellen.
## 2. Grundlagen der Datenmodellierung
- Datenmodellierung dient der strukturierten Darstellung von Datenbeziehungen.
- Ziel: Die reale Welt in einer Datenbank effizient abbilden.
- Unterschiedliche Modellierungsebenen:
    - **Konzeptionelles Modell:** Abstrakte Darstellung der Datenstrukturen.
    - **Logisches Modell:** Detaillierte Beschreibung mit Tabellenstruktur.
    - **Physisches Modell:** Technische Implementierung in einer Datenbank.
## 3. Entity-Relationship-Diagramme (ERD)
- Grafische Darstellung der Datenstrukturen.
- Bestandteile:
    - **Entitäten (Entities):** Objekte oder Konzepte (z. B. Kunde, Bestellung).
    - **Attribute:** Eigenschaften einer Entität (z. B. Name, Datum).
    - **Beziehungen (Relationships):** Verbindung zwischen Entitäten.
    - **Schlüssel (Keys):** Eindeutige Identifikatoren für Entitäten.
## 4. Kardinalitäten in Beziehungen
- **1:1 (One-to-One):** Eine Entität A kann genau einer Entität B zugeordnet sein.  
- **1:n (One-to-Many):** Eine Entität A kann mehreren Entitäten B zugeordnet sein.  
- **n:m (Many-to-Many):** Mehrere Entitäten A können mehreren Entitäten B zugeordnet sein.  
## 5. Von ERD zu relationalen Tabellen
- Entitäten werden zu Tabellen.  
- Attribute werden zu Spalten.  
- Beziehungen werden durch Fremdschlüssel dargestellt.  

**Beispiel:** Kunden und Bestellungen  
- **Kunde** (*Kunden-ID*, Name, Adresse)  
- **Bestellung** (*Bestell-ID*, Datum, *Kunden-ID*)  
- Beziehung: Ein Kunde kann mehrere Bestellungen haben (1:n).  
## 6. Praktische Anwendung: Erstellung eines ERD
1. Definition des Szenarios (z. B. Bibliotheksverwaltung, Onlineshop).  
2. Identifikation der relevanten Entitäten.  
3. Bestimmung der Attribute und Primärschlüssel.  
4. Festlegung der Beziehungen und Kardinalitäten.  
5. Umsetzung mit einem ERD-Tool (z. B. draw.io).  
## 7. Vorteile der Datenmodellierung mit ERD
- Klare Strukturierung von Daten.  
- Reduzierung von Redundanzen und Inkonsistenzen.  
- Verbesserung der Datenintegrität und Nachvollziehbarkeit.  
- Erleichterung der Kommunikation zwischen Entwicklern und Fachabteilungen.  
## 8. Fazit 
Die Datenmodellierung mit ERD ist ein entscheidender Schritt zur Entwicklung effizienter Datenbanken. Ein gut strukturiertes ERD erleichtert die Umsetzung in relationale Datenbanken und optimiert die spätere Datenverarbeitung. 
