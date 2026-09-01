## Überblick

Dieses Handout beschreibt die Einrichtung eines LAMP-Stacks (Linux, Apache, MySQL, PHP) als Pod mit Podman. Ein Pod ermöglicht es, mehrere Container zu gruppieren und gemeinsam zu verwalten.

## Voraussetzungen

- Podman installiert (Version 3.0 oder höher)
- Root-Rechte oder rootless Podman konfiguriert
- Grundkenntnisse in der Kommandozeile

## Schritt 1: Pod erstellen

Erstellen Sie zunächst einen Pod mit dem Namen `lamp-pod` und definieren Sie die Port-Weiterleitungen:

```PowerShell
podman pod create --name lamp-pod -p 8080:80 -p 3306:3306
```

**Erklärung:**
- `--name lamp-pod`: Name des Pods
- `-p 8080:80`: Weiterleitung von Host-Port 8080 auf Container-Port 80 (Apache)
- `-p 3306:3306`: Weiterleitung von Port 3306 für MySQL

## Schritt 2: MySQL-Container starten

Starten Sie den MySQL-Container im Pod:

```PowerShell
podman run -d `
  --pod lamp-pod `
  --name mariadb-container `
  -e "MYSQL_ROOT_PASSWORD=rootpassword" `
  -e "MYSQL_DATABASE=webapp" `
  -e "MYSQL_USER=webuser" `
  -e "MYSQL_PASSWORD=webpassword" `
  -v mariadb-data:/var/lib/mysql `
  mariadb:10.11
```

**Erklärung der Parameter:**
- `--pod lamp-pod`: Container dem Pod hinzufügen
- `-e MYSQL_ROOT_PASSWORD`: Root-Passwort für MySQL
- `-e MYSQL_DATABASE`: Automatisch erstellte Datenbank
- `-e MYSQL_USER/MYSQL_PASSWORD`: Zusätzlicher Benutzer mit Passwort
- `-v mysql-data:/var/lib/mysql`: Persistente Datenspeicherung

## Schritt 3: Web-Verzeichnis vorbereiten

Erstellen Sie das lokale Web-Verzeichnis und eine Test-PHP-Datei:

```PowerShell
mkdir -p web
@'
<?php
echo "<h1>LAMP Stack Test</h1>";
echo "<p>PHP Version: " . phpversion() . "</p>";
// MySQL-Verbindungstest
$host = 'mariadb-container';
$dbname = 'webapp';
$username = 'webuser';
$password = 'webpassword';
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    echo "<p style='color: green;'>MySQL-Verbindung erfolgreich!</p>";
} catch(PDOException $e) {
    echo "<p style='color: red;'>MySQL-Verbindung fehlgeschlagen: " . $e->getMessage() . "</p>";
}
?>
'@ | Out-File -FilePath "web/index.php" -Encoding UTF8
```
## Schritt 4: Apache/PHP-Container starten

Starten Sie den Apache-Container mit PHP-Unterstützung:

```PowerShell
podman run -d `
  --pod lamp-pod `
  --name apache-php-container `
  -v ./web:/var/www/html `
  php:8.1-apache
```

**Erklärung:**
- `-v ./web:/var/www/html`: Bindet lokales Verzeichnis an Apache Document Root

## Schritt 5: PHP-Erweiterungen installieren (falls nötig)

Wenn MySQL-Erweiterungen für PHP fehlen, erstellen Sie ein Dockerfile:

```PowerShell
@'
FROM php:8.1-apache
RUN docker-php-ext-install pdo pdo_mysql mysqli
'@ | Out-File -FilePath "Dockerfile" -Encoding UTF8
```

Erstellen Sie das Image und starten Sie den Container neu:

```PowerShell
podman build -t lamp-php .

# Stoppen und entfernen des alten Containers
podman stop apache-php-container
podman rm apache-php-container

# Neuen Container mit MySQL-Erweiterungen starten
podman run -d `
  --pod lamp-pod `
  --name apache-php-container `
  -v ./web:/var/www/html `
  lamp-php
```

## Schritt 6: Pod-Status überprüfen

Überprüfen Sie den Status Ihres Pods und der Container:

```PowerShell
# Pod-Informationen anzeigen
podman pod ps

# Container im Pod anzeigen
podman ps --pod

# Logs anzeigen
podman logs mariadb-container
podman logs apache-php-container
```

## Schritt 7: Anwendung testen

Öffnen Sie Ihren Browser und navigieren Sie zu:
```
http://localhost:8080
```

Sie sollten die PHP-Testseite mit Verbindungsstatus zur MySQL-Datenbank sehen.

## Schritt 8: Datenbank-Zugriff testen

Verbinden Sie sich mit der MySQL-Datenbank:

```PowerShell
podman exec -it mariadb-container mysql -u webuser -pwebpassword webapp
```

Geben Sie das Passwort `webpassword` ein und testen Sie SQL-Befehle:

```sql
SHOW TABLES;
CREATE TABLE test (id INT AUTO_INCREMENT PRIMARY KEY, message VARCHAR(255));
INSERT INTO test (message) VALUES ('Hello LAMP Stack!');
SELECT * FROM test;
```

## Verwaltungsbefehle

### Pod stoppen
```PowerShell
podman pod stop lamp-pod
```

### Pod starten
```PowerShell
podman pod start lamp-pod
```

### Pod und Container entfernen
```PowerShell
podman pod rm -f lamp-pod
```

### Volume anzeigen
```PowerShell
podman volume ls
```

### Volume entfernen (Achtung: Daten gehen verloren!)
```PowerShell
podman volume rm mysql-data
```

## Troubleshooting

### Häufige Probleme:

1. **Port bereits belegt**: Ändern Sie die Port-Weiterleitung (`-p 8081:80`)
2. **MySQL-Verbindung fehlgeschlagen**: Warten Sie einige Sekunden nach dem Start
3. **PHP-Fehler**: Überprüfen Sie die Logs mit `podman logs apache-php-container`
4. **Berechtigungsprobleme**: Stellen Sie sicher, dass das web-Verzeichnis beschreibbar ist

### Logs analysieren:
```PowerShell
# Alle Container-Logs anzeigen
podman logs -f apache-php-container
podman logs -f mysql-container
```

## Sicherheitshinweise

- Ändern Sie die Standard-Passwörter in einer Produktionsumgebung
- Verwenden Sie sichere Passwörter
- Beschränken Sie den Netzwerkzugriff bei Bedarf
- Aktualisieren Sie regelmäßig die Container-Images

## Nützliche Befehle

```PowerShell
# Pod-Details anzeigen
podman pod inspect lamp-pod

# In Container einsteigen
podman exec -it apache-php-container bash
podman exec -it mysql-container bash

# Container-Ressourcen überwachen
podman stats

# Images aktualisieren
podman pull mariadb:10.11
podman pull php:8.1-apache
```

---

**Hinweis:** Dieses Setup ist für Entwicklungs- und Testzwecke optimiert. Für Produktionsumgebungen sollten zusätzliche Sicherheits- und Performance-Konfigurationen vorgenommen werden.