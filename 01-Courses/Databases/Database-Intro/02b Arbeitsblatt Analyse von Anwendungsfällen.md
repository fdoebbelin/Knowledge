## Teil 1: Szenarien

- Betrachten Sie die folgenden Szenarien. 
- Für jedes Szenario ist eine Analyse erforderlich, um das am besten geeignete Datenbankmodell auszuwählen.

1. **Online-Shop mit Kunden- und Bestelldaten**  
    Ein Online-Shop verwaltet Kunden, Bestellungen, Produkte und Lagerbestände. Kunden haben oft mehrere Bestellungen, und jede Bestellung enthält verschiedene Produkte. Anforderungen:
    - Schnelle Abfragen zu Kundenbestellungen.
    - Sicherstellung der Konsistenz von Lagerbeständen.
    - Strukturierte Daten mit klaren Beziehungen zwischen Entitäten.
2. **Social-Media-Plattform, die Freundschaftsnetzwerke abbildet**  
    Eine Social-Media-Plattform speichert Benutzerprofile, Nachrichten und Freundschaftsnetzwerke. Anforderungen:
    - Speicherung und Abfrage komplexer Verbindungen zwischen Benutzern (Freundschaften).
    - Häufige Aktualisierung und Abfrage von Beziehungsdaten (z. B. gemeinsame Freunde).
    - Skalierbarkeit für Millionen von Nutzern.
3. **Blog-System mit Artikeln, Tags und Kategorien**  
    Ein Blog-System speichert Artikel, die von Autoren geschrieben werden, und ordnet jedem Artikel Tags und Kategorien zu. Anforderungen:
    - Flexible Suche nach Artikeln anhand von Tags und Kategorien.
    - Speicherung von Inhalten in Textform.
    - Möglichkeit, neue Tags und Kategorien dynamisch hinzuzufügen.
## Teil 2: Aufgaben

Führen Sie folgende Schritte für jedes Szenario aus:
1. Beschreibung der Datenstruktur:
    - Identifizieren Sie die Hauptentitäten und deren Beziehungen.
    - Beschreiben Sie, welche Daten gespeichert werden müssen.
2. Anforderungsanalyse:
    - Welche speziellen Anforderungen müssen erfüllt werden? Denken Sie an Skalierbarkeit, Konsistenz, Flexibilität und Abfrageleistung.
3. Auswahl des Datenbankmodells:
    - Wählen Sie ein geeignetes Datenbankmodell (z. B. relationale, dokumentenbasierte oder Graphdatenbank).
    - Begründen Sie Ihre Entscheidung mit den Vor- und Nachteilen des gewählten Modells.
## Beispiel: Online-Shop mit Kunden- und Bestelldaten

1. Datenstruktur:
    - Hauptentitäten: Kunde, Bestellung, Produkt, Lager.
    - Beziehungen: Ein Kunde kann mehrere Bestellungen haben; eine Bestellung enthält mehrere Produkte.
2. Anforderungen:
    - Konsistenz der Bestände bei gleichzeitigen Transaktionen.
    - Schnelle Abfragen für Berichte (z. B. Bestellungen pro Kunde).
3. Datenbankmodell:
    - Relationale Datenbank.
    - **Begründung:** Klare Beziehungen zwischen Entitäten, ACID-Transaktionen zur Sicherstellung der Konsistenz, strukturierte Daten.
4. Strukturskizze:
    - Tabellen: Kunde, Bestellung, Produkt, Bestellposition.

### Beispiel: Social-Media-Plattform, die Freundschaftsnetzwerke abbildet

1. Datenstruktur:
    - Hauptentitäten: Benutzer, Freundschaftsbeziehungen, Nachrichten.
    - Beziehungen: Ein Benutzer kann mit vielen anderen Benutzern befreundet sein (n:m-Beziehung).
2. Anforderungen:
    - Speicherung komplexer Beziehungen zwischen Benutzern (z. B. Freundschaften, gemeinsame Freunde).
    - Schnelle Abfragen zu Beziehungsdaten und Nachrichten.
    - Hohe Skalierbarkeit für ein wachsendes Netzwerk.
3. Datenbankmodell:
    - Graphdatenbank.
    - **Begründung:** Graphdatenbanken sind ideal für die Modellierung und Abfrage komplexer Netzwerke, da sie Beziehungen effizient speichern und abfragen können.
4. Strukturskizze:
    - Knoten: Benutzer, Nachrichten.
    - Kanten: Freundschaften, Nachrichtensender/-empfänger.
### Beispiel: Blog-System mit Artikeln, Tags und Kategorien

1. Datenstruktur:
    - Hauptentitäten: Artikel, Autor, Tag, Kategorie.
    - Beziehungen: Ein Artikel kann mehrere Tags haben (n:m-Beziehung); ein Artikel gehört zu einer Kategorie.
2. Anforderungen:
    - Flexible Abfragen nach Artikeln basierend auf Tags und Kategorien.
    - Speicherung von unstrukturierten Daten (z. B. Artikelinhalte).
    - Dynamische Erweiterung von Tags und Kategorien.
3. Datenbankmodell:
    - Dokumentenbasierte Datenbank.
    - **Begründung:** Dokumentenbasierte Datenbanken sind flexibel und eignen sich gut für unstrukturierte Inhalte wie Artikeltexte. Tags und Kategorien können leicht hinzugefügt werden.
4. Strukturskizze:
    - Dokumente: Artikel (mit Feldern für Titel, Inhalt, Tags, Kategorie).