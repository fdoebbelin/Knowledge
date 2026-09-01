Schritt 1-6 wurde schon durch Drupal realisiert
## Schritt 7: Erstelle ein Projektverzeichnis
Erstelle ein Verzeichnis für dein Drupal-Projekt und navigiere dorthin:
```bash
mkdir ~/drupal-projects && cd ~/drupal-projects
```

## Schritt 8: Installiere Drupal mit Composer
Verwende Composer, um Drupal zu installieren:
```bash
composer create-project opigno/opigno-composer my_opigno_site && cd my_opigno_site
```

## Schritt 9: Konfiguriere Apache
Erstelle eine neue Apache-Konfigurationsdatei für dein Drupal-Projekt:
```bash
sudo vi /etc/apache2/sites-available/my_opigno_site.conf
```
Füge folgende Konfiguration hinzu:
```apache
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /home/fritz/drupal-projects/my_opigno_site/web
    ServerName my_opgino_site.local
    
    <Directory /home/fritz/drupal-projects/my_opigno_site/web>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/my_opigno_site_error.log
    CustomLog ${APACHE_LOG_DIR}/my_opigno_site_access.log combined
</VirtualHost>
```

Aktiviere die neue Site und deaktiviere die Standard-Site:
```bash
sudo a2ensite my_opigno_site.conf
sudo systemctl reload apache2
```

## Schritt 10: Hosts-Datei bearbeiten
Füge einen Eintrag in deiner `hosts`-Datei hinzu, um auf die lokale Site zugreifen zu können. Öffne die Datei mit einem Texteditor:
```bash
sudo vi /etc/hosts
```
Füge folgende Zeile hinzu:
```
127.0.0.1   my_opigno_site.local
```
## Schritt 11: Datenbank erstellen
Erstelle eine Datenbank für Drupal:
```bash
sudo mysql -u root -p
```
Führe die folgenden SQL-Befehle aus:
```sql
CREATE DATABASE opigno;
CREATE USER 'opigno'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON opigno.* TO 'opigno'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## Schritt 12: Drupal-Installation abschließen
- Öffne deinen Browser und navigiere zu `http://my_opigno_site.local`. 
- Folge den Anweisungen auf dem Bildschirm, um die Drupal-Installation abzuschließen. 
- Verwende die Datenbankinformationen, die du im vorherigen Schritt erstellt hast.

## Schritt 13: Protecting against HTTP HOST Header attacks

Drupal 8 and later versions can be configured to use Symfony's trusted host mechanism to prevent HTTP Host header spoofing. To enable the trusted host mechanism, you enable the allowed hosts setting `$settings['trusted_host_patterns']` in the _settings.php_ file (the _sites/default/settings.php_ file inside the _webroot_ directory). This should be an array of regular expression patterns, without delimiters, representing the hosts you would like to allow. If the Host header of the HTTP request does not match the defined patterns, Drupal will respond with HTTP 400 with a message _The provided host name is not valid for this server._

```php
$settings['trusted_host_patterns'] = [
  '^my_opigno_site\.local$',
];
```