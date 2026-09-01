## ssh Zugang

```sh
sshpass -p '79xrwZP4TxzeVT2rA4Gd' ssh ssh-w017ef42@w017ef42.kasserver.com
```
Das SSH-Passwort entspricht immer dem Haupt-FTP-Passwort.
## Projekt anlegen

```sh
composer create-project drupal/cms t3md.de
cd t3md.de
composer require drush/drush
```
## Datenbank

```php
$databases['default']['default'] = array (
  'database' => 'd03bcdde',
  'username' => 'd03bcdde',
  'password' => 'fRaKaf5VTiVVzptkc2dm',
  'prefix' => '',
  'host' => 'localhost',
  'port' => '3306',
  'isolation_level' => 'READ COMMITTED',
  'namespace' => 'Drupal\\mysql\\Driver\\Database\\mysql',
  'driver' => 'mysql',
  'autoload' => 'core/modules/mysql/src/Driver/Database/mysql/',
);
```
## Composer für Drupal lokal verfügbar machen

phar-Datei herunterladen

```sh
cd /www/htdocs/w017ef42/t3md.de
php -r "copy('https://getcomposer.org/composer-stable.phar', 'composer.phar');"
```

in den Drupal Settings den Pfad einrichten, da der Webservserprozess keinen Zugriff auf die globale Instanz hat.
```sh
drush cset package_manager.settings executables.composer /www/htdocs/w017ef42/t3md.de/composer.phar
```
## Trusted Host Settings setzen

mit dem core:edit-Kommando kann ein Auswahlmenü zur direkten Änderung mit vi aufgerufen werden

```sh
drush core:edit
settings.php
```

Eintrag am Ende der Datei anfügen

```php
$settings['trusted_host_patterns'] = [
  '^www\.t3md\.de$',
  '^t3md\.de$',
];
```

