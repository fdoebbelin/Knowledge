## Schritt 1: WSL und Ubuntu installieren
Stelle sicher, dass WSL installiert und eine Ubuntu-Distribution eingerichtet ist. Du kannst Ubuntu aus dem Microsoft Store installieren.

## Schritt 2: Aktualisiere dein System
Öffne ein WSL-Terminal und aktualisiere dein System:
```bash
sudo apt update
sudo apt upgrade -y
```

## Schritt 3: Installiere Apache
Installiere Apache und starte den Dienst:
```bash
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
```

## Schritt 4: Installiere PHP
Installiere PHP und die notwendigen Erweiterungen:
```bash
sudo apt install php libapache2-mod-php php-bcmath php-mysql php-xml php-mbstring php-curl php-gd php-zip -y
```

## Schritt 5: Installiere MySQL
Installiere MySQL und sichere die Installation:
```bash
sudo apt install mysql-server -y
sudo mysql_secure_installation
```

## Schritt 6: Installiere Composer
Lade Composer herunter und installiere ihn:
```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
```

## Schritt 7: Erstelle ein Projektverzeichnis
Erstelle ein Verzeichnis für dein Drupal-Projekt und navigiere dorthin:
```bash
mkdir ~/drupal-project
cd ~/drupal-project
```

## Schritt 8: Installiere Drupal mit Composer
Verwende Composer, um Drupal zu installieren:
```bash
composer create-project drupal/recommended-project my_drupal_site
cd my_drupal_site
```

## Schritt 9: Konfiguriere Apache
Erstelle eine neue Apache-Konfigurationsdatei für dein Drupal-Projekt:
```bash
sudo vi /etc/apache2/sites-available/my_drupal_site.conf
```
Füge folgende Konfiguration hinzu:
```apache
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /home/fritz/drupal-project/my_drupal_site/web
    ServerName my_drupal_site.local
    
    <Directory /home/fritz/drupal-project/my_drupal_site/web>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/my_drupal_site_error.log
    CustomLog ${APACHE_LOG_DIR}/my_drupal_site_access.log combined
</VirtualHost>
```

Aktiviere die neue Site und deaktiviere die Standard-Site:
```bash
sudo a2ensite my_drupal_site.conf
sudo a2dissite 000-default.conf
sudo systemctl reload apache2
```

## Schritt 10: Hosts-Datei bearbeiten
Füge einen Eintrag in deiner `hosts`-Datei hinzu, um auf die lokale Site zugreifen zu können. Öffne die Datei mit einem Texteditor:
```bash
sudo vi /etc/hosts
```
Füge folgende Zeile hinzu:
```
127.0.0.1   my_drupal_site.local
```

## Schritt 11: Datenbank erstellen
Erstelle eine Datenbank für Drupal:
```bash
sudo mysql -u root -p
```
Führe die folgenden SQL-Befehle aus:
```sql
CREATE DATABASE drupal;
CREATE USER 'drupaluser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON drupal.* TO 'drupaluser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## Schritt 12: Drupal-Installation abschließen
Öffne deinen Browser und navigiere zu `http://my_drupal_site.local`. Folge den Anweisungen auf dem Bildschirm, um die Drupal-Installation abzuschließen. Verwende die Datenbankinformationen, die du im vorherigen Schritt erstellt hast.

## Protecting against HTTP HOST Header attacks

Drupal 8 and later versions can be configured to use Symfony's trusted host mechanism to prevent HTTP Host header spoofing. To enable the trusted host mechanism, you enable the allowed hosts setting `$settings['trusted_host_patterns']` in the _settings.php_ file (the _sites/default/settings.php_ file inside the _webroot_ directory). This should be an array of regular expression patterns, without delimiters, representing the hosts you would like to allow. If the Host header of the HTTP request does not match the defined patterns, Drupal will respond with HTTP 400 with a message _The provided host name is not valid for this server._

```php
$settings['trusted_host_patterns'] = [
  '^my_drupal_site\.local$',
];
```

Um **APCu** (Alternative PHP Cache) zu deiner bestehenden Installation hinzuzufügen, musst du das APCu-Modul installieren und aktivieren. Hier ist eine Erweiterung der Anleitung, um APCu zu integrieren:

---

## Schritt 14: Installiere APCu

Installiere das APCu-Modul für PHP:
```bash
sudo apt install php-apcu -y
```

## Schritt 15: Aktiviere APCu in PHP

Öffne die PHP-Konfigurationsdatei, um sicherzustellen, dass APCu aktiviert ist:
```bash
sudo vi /etc/php/8.3/apache2/php.ini
```
(Ersetze `7.x` durch die PHP-Version, die du verwendest, z. B. `7.4` oder `8.1`.)

Füge die folgende Zeile hinzu, falls sie noch nicht vorhanden ist:
```ini
extension=apcu.so
```

Starte Apache neu, um die Änderungen zu übernehmen:
```bash
sudo systemctl restart apache2
```

