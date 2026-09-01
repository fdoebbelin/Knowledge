
```plantuml
@startuml
node "Client PC" {
  artifact "Webbrowser" as browser
}

node "Webserver" {
  node "Linux OS" as linux {
    node "Apache HTTP Server" as apache {
      artifact "PHP Interpreter" as php
      artifact "Webapplikation (PHP)" as phpapp
    }
  }
}

node "Datenbankserver" {
  node "Linux OS" as db_linux {
    node "MySQL Server" as mysql {
      artifact "Datenbanktabellen" as tables
    }
  }
}

browser --> apache : HTTP/HTTPS
apache --> php : interpretiert
php --> mysql : SQL
mysql --> php : Ergebnisse
php --> apache : HTML-Seite
apache --> browser : Antwort

@enduml
```

### Was wurde verbessert:

1. **Eindeutige Artefakte und Nodes**:
    - Artefakte wie `PHP Webapplikation` oder `Datenbanktabellen` sind explizit als Artefakte dargestellt.
    - Nodes wie `Linux OS` sind als physische Ausführungseinheiten für Server- und Datenbanksoftware dargestellt.
2. **Kommunikationspfade**:
    - Die Verbindungen sind konsistenter mit UML 2.5 (z. B. zwischen Artefakten und Nodes).
3. **Detaillierte Schachtelung**:
    - Die Hierarchie von OS → Software → Artefakte wurde genauer dargestellt.