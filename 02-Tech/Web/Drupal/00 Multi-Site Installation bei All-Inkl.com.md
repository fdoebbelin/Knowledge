**Wichtige Punkte zur Anleitung:**

1. **Domain-Setup**: Alle Domains zeigen auf dasselbe Document Root (`/www/htdocs/`)
2. **Datenbanken**: Separate MySQL-Datenbanken für jede Site im KAS anlegen
3. **SSH-Installation**: Schritt-für-Schritt Installation über SSH-Zugang
4. **Multi-Site-Konfiguration**: Korrekte sites.php und settings.php für alle Domains
5. **Headless-API**: api.metarow.org mit JSON:API und CORS für Svelte-Integration
6. **Sicherheit**: SSL-Zertifikate, sichere Berechtigungen, .htaccess-Optimierungen

**Vor der Installation benötigen Sie:**

- SSH-Zugang bei All-Inkl aktiviert
- 4 MySQL-Datenbanken im KAS angelegt
- Ihre Datenbank-Zugangsdaten aus dem KAS
- Sichere Passwörter für die Admin-Accounts

**Besonderheiten für All-Inkl:**

- Document Root auf `/web` setzen oder Symlinks verwenden
- PHP-Version im KAS auf 8.2 oder 8.3 einstellen
- Let's Encrypt SSL-Zertifikate aktivieren
- Cron-Jobs für Drupal-Wartung einrichten

Die Anleitung führt Sie durch die komplette Installation und Konfiguration aller vier Sites mit der funktionsfähigen API für Ihre Svelte-Anwendungen.

## Übersicht der Sites

- **Hauptseite**: metarow.org
- **Site 2**: t3md.de
- **Site 3**: doebbelin.net
- **API**: api.metarow.org (Headless für Svelte)

## 1. Vorbereitung bei All-Inkl.com

### Domain-Konfiguration im KAS (Kunden-Admin-System)

1. **Hauptdomain**: metarow.org → `/www/htdocs/` (Document Root)
2. **Zusätzliche Domains**:
    - t3md.de → `/www/htdocs/` (gleicher Document Root)
    - doebbelin.net → `/www/htdocs/` (gleicher Document Root)
    - api.metarow.org → `/www/htdocs/` (Subdomain, gleicher Document Root)

### SSH-Zugang aktivieren

- Im KAS unter "SSH-Zugang" aktivieren
- SSH-Schlüssel hinterlegen (empfohlen)
- SSH-Daten notieren: `ssh sshuser@metarow.org`

### Datenbanken erstellen

Im KAS unter "MySQL-Datenbanken":

```
- Datenbank: metarow_main (für metarow.org)
- Datenbank: metarow_t3md (für t3md.de)  
- Datenbank: metarow_doebbelin (für doebbelin.net)
- Datenbank: metarow_api (für api.metarow.org)
```

## 2. SSH-Verbindung und Grundsetup

### SSH-Verbindung herstellen

```bash
# SSH-Verbindung zu All-Inkl
ssh sshuser@metarow.org

# Arbeitsverzeichnis wechseln
cd /www/htdocs/

# PHP-Version prüfen (All-Inkl unterstützt meist PHP 8.1-8.3)
php -v
```

### Composer installieren (falls nicht vorhanden)

```bash
# Composer lokal installieren
curl -sS https://getcomposer.org/installer | php
mv composer.phar composer
chmod +x composer

# Oder global verfügbaren Composer nutzen (meist bei All-Inkl verfügbar)
which composer
```

## 3. Drupal 11 Installation

### Drupal 11 herunterladen

```bash
# Backup des aktuellen Inhalts (falls vorhanden)
mkdir backup_$(date +%Y%m%d)
mv * backup_$(date +%Y%m%d)/ 2>/dev/null || true

# Drupal 11 mit Composer installieren
./composer create-project drupal/recommended-project:^11.1 temp_drupal
mv temp_drupal/* .
mv temp_drupal/.* . 2>/dev/null || true
rmdir temp_drupal

# Drush installieren
./composer require drush/drush
```

### Verzeichnisstruktur anpassen

```bash
# Document Root auf web/ setzen (All-Inkl spezifisch)
# In KAS: Document Root von "/" auf "/web" ändern
# Oder Symlink erstellen falls Document Root nicht änderbar:
ln -sf web/* .
ln -sf web/.htaccess .
```

## 4. Multi-Site-Struktur einrichten

### Sites-Verzeichnisse erstellen

```bash
# Multi-Site-Verzeichnisse
mkdir -p web/sites/metarow.org
mkdir -p web/sites/t3md.de  
mkdir -p web/sites/doebbelin.net
mkdir -p web/sites/api.metarow.org

# Berechtigungen setzen
chmod 755 web/sites/metarow.org
chmod 755 web/sites/t3md.de
chmod 755 web/sites/doebbelin.net
chmod 755 web/sites/api.metarow.org
```

### sites.php konfigurieren

```bash
# sites.php erstellen
cp web/sites/example.sites.php web/sites/sites.php

# Inhalt bearbeiten
cat > web/sites/sites.php << 'EOF'
<?php
$sites['metarow.org'] = 'metarow.org';
$sites['www.metarow.org'] = 'metarow.org';
$sites['t3md.de'] = 't3md.de';
$sites['www.t3md.de'] = 't3md.de';
$sites['doebbelin.net'] = 'doebbelin.net';
$sites['www.doebbelin.net'] = 'doebbelin.net';
$sites['api.metarow.org'] = 'api.metarow.org';
EOF
```

## 5. Settings-Dateien konfigurieren

### Hauptseite (metarow.org)

```bash
# settings.php für metarow.org
cp web/sites/default/default.settings.php web/sites/metarow.org/settings.php
chmod 666 web/sites/metarow.org/settings.php

cat >> web/sites/metarow.org/settings.php << 'EOF'

/**
 * Database configuration for metarow.org
 */
$databases['default']['default'] = [
  'database' => 'metarow_main',
  'username' => 'IHR_DB_USER',
  'password' => 'IHR_DB_PASSWORT',
  'prefix' => '',
  'host' => 'localhost',
  'port' => '3306',
  'namespace' => 'Drupal\\mysql\\Driver\\Database\\mysql',
  'driver' => 'mysql',
  'autoload' => 'core/modules/mysql/src/Driver/Database/mysql/',
];

$settings['hash_salt'] = 'EINDEUTIGER_HASH_SALT_METAROW';
$settings['config_sync_directory'] = '../config/sync';
$settings['file_public_path'] = 'sites/metarow.org/files';

$settings['trusted_host_patterns'] = [
  '^metarow\.org$',
  '^www\.metarow\.org$',
];
EOF

chmod 444 web/sites/metarow.org/settings.php
```

### Site 2 (t3md.de)

```bash
# settings.php für t3md.de
cp web/sites/default/default.settings.php web/sites/t3md.de/settings.php
chmod 666 web/sites/t3md.de/settings.php

cat >> web/sites/t3md.de/settings.php << 'EOF'

/**
 * Database configuration for t3md.de
 */
$databases['default']['default'] = [
  'database' => 'metarow_t3md',
  'username' => 'IHR_DB_USER',
  'password' => 'IHR_DB_PASSWORT',
  'prefix' => '',
  'host' => 'localhost',
  'port' => '3306',
  'namespace' => 'Drupal\\mysql\\Driver\\Database\\mysql',
  'driver' => 'mysql',
  'autoload' => 'core/modules/mysql/src/Driver/Database/mysql/',
];

$settings['hash_salt'] = 'EINDEUTIGER_HASH_SALT_T3MD';
$settings['config_sync_directory'] = '../config/sync';
$settings['file_public_path'] = 'sites/t3md.de/files';

$settings['trusted_host_patterns'] = [
  '^t3md\.de$',
  '^www\.t3md\.de$',
];
EOF

chmod 444 web/sites/t3md.de/settings.php
```

### Site 3 (doebbelin.net)

```bash
# settings.php für doebbelin.net
cp web/sites/default/default.settings.php web/sites/doebbelin.net/settings.php
chmod 666 web/sites/doebbelin.net/settings.php

cat >> web/sites/doebbelin.net/settings.php << 'EOF'

/**
 * Database configuration for doebbelin.net
 */
$databases['default']['default'] = [
  'database' => 'metarow_doebbelin',
  'username' => 'IHR_DB_USER',
  'password' => 'IHR_DB_PASSWORT',
  'prefix' => '',
  'host' => 'localhost',
  'port' => '3306',
  'namespace' => 'Drupal\\mysql\\Driver\\Database\\mysql',
  'driver' => 'mysql',
  'autoload' => 'core/modules/mysql/src/Driver/Database/mysql/',
];

$settings['hash_salt'] = 'EINDEUTIGER_HASH_SALT_DOEBBELIN';
$settings['config_sync_directory'] = '../config/sync';
$settings['file_public_path'] = 'sites/doebbelin.net/files';

$settings['trusted_host_patterns'] = [
  '^doebbelin\.net$',
  '^www\.doebbelin\.net$',
];
EOF

chmod 444 web/sites/doebbelin.net/settings.php
```

### API-Site (api.metarow.org)

```bash
# settings.php für API
cp web/sites/default/default.settings.php web/sites/api.metarow.org/settings.php
chmod 666 web/sites/api.metarow.org/settings.php

cat >> web/sites/api.metarow.org/settings.php << 'EOF'

/**
 * Database configuration for API
 */
$databases['default']['default'] = [
  'database' => 'metarow_api',
  'username' => 'IHR_DB_USER',
  'password' => 'IHR_DB_PASSWORT',
  'prefix' => '',
  'host' => 'localhost',
  'port' => '3306',
  'namespace' => 'Drupal\\mysql\\Driver\\Database\\mysql',
  'driver' => 'mysql',
  'autoload' => 'core/modules/mysql/src/Driver/Database/mysql/',
];

$settings['hash_salt'] = 'EINDEUTIGER_HASH_SALT_API';
$settings['config_sync_directory'] = '../config/sync';
$settings['file_public_path'] = 'sites/api.metarow.org/files';

/**
 * CORS-Konfiguration für Headless
 */
$settings['cors.config'] = [
  'enabled' => TRUE,
  'allowedHeaders' => [
    'x-csrf-token',
    'authorization', 
    'content-type',
    'accept',
    'origin',
    'x-requested-with'
  ],
  'allowedMethods' => [
    'GET',
    'POST', 
    'PUT',
    'DELETE',
    'OPTIONS',
    'PATCH'
  ],
  'allowedOrigins' => [
    'https://metarow.org',
    'https://t3md.de',
    'https://doebbelin.net',
    'http://localhost:5173',
    'http://localhost:3000'
  ],
  'exposedHeaders' => FALSE,
  'maxAge' => FALSE,
  'supportsCredentials' => FALSE,
];

$settings['trusted_host_patterns'] = [
  '^api\.metarow\.org$',
];
EOF

chmod 444 web/sites/api.metarow.org/settings.php
```

## 6. Drupal-Installation pro Site

### Hash-Salts generieren

```bash
# Eindeutige Hash-Salts erstellen
SALT_METAROW=$(openssl rand -base64 32)
SALT_T3MD=$(openssl rand -base64 32)
SALT_DOEBBELIN=$(openssl rand -base64 32)
SALT_API=$(openssl rand -base64 32)

echo "Metarow Salt: $SALT_METAROW"
echo "T3MD Salt: $SALT_T3MD"
echo "Doebbelin Salt: $SALT_DOEBBELIN"
echo "API Salt: $SALT_API"

# Diese in die jeweiligen settings.php einsetzen
```

### Sites installieren

```bash
# Hauptseite installieren
./vendor/bin/drush site:install standard \
  --sites-subdir=metarow.org \
  --site-name="Metarow" \
  --account-name=admin \
  --account-pass=SICHERES_PASSWORT \
  --db-url=mysql://IHR_DB_USER:IHR_DB_PASSWORT@localhost:3306/metarow_main \
  -y

# t3md.de installieren
./vendor/bin/drush site:install standard \
  --sites-subdir=t3md.de \
  --site-name="T3MD" \
  --account-name=admin \
  --account-pass=SICHERES_PASSWORT \
  --db-url=mysql://IHR_DB_USER:IHR_DB_PASSWORT@localhost:3306/metarow_t3md \
  -y

# doebbelin.net installieren
./vendor/bin/drush site:install standard \
  --sites-subdir=doebbelin.net \
  --site-name="Doebbelin" \
  --account-name=admin \
  --account-pass=SICHERES_PASSWORT \
  --db-url=mysql://IHR_DB_USER:IHR_DB_PASSWORT@localhost:3306/metarow_doebbelin \
  -y

# API-Site installieren
./vendor/bin/drush site:install standard \
  --sites-subdir=api.metarow.org \
  --site-name="API Backend" \
  --account-name=admin \
  --account-pass=SICHERES_PASSWORT \
  --db-url=mysql://IHR_DB_USER:IHR_DB_PASSWORT@localhost:3306/metarow_api \
  -y
```

## 7. Headless-Konfiguration für API

### JSON:API Module aktivieren

```bash
# JSON:API für API-Site aktivieren
./vendor/bin/drush --uri=api.metarow.org en jsonapi rest serialization -y

# Zusätzliche Module installieren
./composer require drupal/jsonapi_extras drupal/cors
./vendor/bin/drush --uri=api.metarow.org en jsonapi_extras -y

# Cache leeren
./vendor/bin/drush --uri=api.metarow.org cr
```

### API-Endpoints testen

```bash
# JSON:API testen
curl -H "Accept: application/vnd.api+json" \
  https://api.metarow.org/jsonapi/node/article

# Verfügbare Endpoints anzeigen
curl https://api.metarow.org/jsonapi
```

## 8. Sicherheitskonfiguration

### .htaccess Optimierungen

```bash
# .htaccess für zusätzliche Sicherheit bearbeiten
cp web/.htaccess web/.htaccess.backup

# Am Ende der web/.htaccess hinzufügen:
cat >> web/.htaccess << 'EOF'

# Multi-Site Security
<Files "sites.php">
  Require all denied
</Files>

# Block sensitive files
<FilesMatch "\.(engine|inc|install|make|module|profile|po|sh|.*sql|theme|twig|tpl(\.php)?|xtmpl|yml)(~|\.sw[op]|\.bak|\.orig|\.save)?$|^(\.(?!well-known).*|Entries.*|Repository|Root|Tag|Template|composer\.(json|lock)|web\.config)$|^#.*#$|\.php(~|\.sw[op]|\.bak|\.orig|\.save)$">
  Require all denied
</FilesMatch>
EOF
```

### Dateiberechtigungen

```bash
# Sichere Berechtigungen setzen
find web/sites -type d -exec chmod 755 {} \;
find web/sites -name "settings.php" -exec chmod 444 {} \;
find web/sites -name "services.yml" -exec chmod 444 {} \;
chmod 444 web/sites/sites.php

# Files-Verzeichnisse beschreibbar machen
find web/sites/*/files -type d -exec chmod 775 {} \;
find web/sites/*/files -type f -exec chmod 664 {} \;
```

## 9. SSL-Zertifikate (Let's Encrypt)

### SSL bei All-Inkl aktivieren

1. **KAS → SSL-Zertifikate**
2. **Let's Encrypt** für alle Domains aktivieren:
    - metarow.org
    - t3md.de
    - doebbelin.net
    - api.metarow.org

### HTTPS-Weiterleitung

```bash
# Zu web/.htaccess hinzufügen (am Anfang):
cat > web/.htaccess.ssl << 'EOF'
# HTTPS Redirect
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

EOF

# Am Anfang der bestehenden .htaccess einfügen
cat web/.htaccess.ssl web/.htaccess > web/.htaccess.tmp
mv web/.htaccess.tmp web/.htaccess
rm web/.htaccess.ssl
```

## 10. Wartung und Updates

### Backup-Skript erstellen

```bash
cat > backup.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M)
BACKUP_DIR="/www/htdocs/backups/$DATE"
mkdir -p $BACKUP_DIR

# Datenbank-Backups
./vendor/bin/drush --uri=metarow.org sql:dump > $BACKUP_DIR/metarow.sql
./vendor/bin/drush --uri=t3md.de sql:dump > $BACKUP_DIR/t3md.sql
./vendor/bin/drush --uri=doebbelin.net sql:dump > $BACKUP_DIR/doebbelin.sql
./vendor/bin/drush --uri=api.metarow.org sql:dump > $BACKUP_DIR/api.sql

# Files-Backup
tar -czf $BACKUP_DIR/files.tar.gz web/sites/*/files

# Code-Backup
tar -czf $BACKUP_DIR/code.tar.gz --exclude='web/sites/*/files' --exclude='vendor' .

echo "Backup erstellt: $BACKUP_DIR"
EOF

chmod +x backup.sh
```

### Update-Prozess

```bash
# Vor Updates immer Backup
./backup.sh

# Composer-Updates
./composer update drupal/core-recommended --with-dependencies

# Datenbank-Updates für alle Sites
./vendor/bin/drush --uri=metarow.org updb -y
./vendor/bin/drush --uri=t3md.de updb -y
./vendor/bin/drush --uri=doebbelin.net updb -y
./vendor/bin/drush --uri=api.metarow.org updb -y

# Cache leeren
./vendor/bin/drush --uri=metarow.org cr
./vendor/bin/drush --uri=t3md.de cr
./vendor/bin/drush --uri=doebbelin.net cr
./vendor/bin/drush --uri=api.metarow.org cr
```

## 11. Monitoring und Logs

### Log-Überwachung

```bash
# Drupal-Logs prüfen
./vendor/bin/drush --uri=metarow.org watchdog:show
./vendor/bin/drush --uri=api.metarow.org watchdog:show

# Apache-Logs (falls zugänglich)
tail -f /var/log/apache2/error.log
tail -f /var/log/apache2/access.log
```

### Performance-Optimierung

```bash
# Cache-Module aktivieren
./vendor/bin/drush --uri=metarow.org en page_cache dynamic_page_cache -y

# Aggregation aktivieren (per Drush)
./vendor/bin/drush --uri=metarow.org config:set system.performance css.preprocess 1 -y
./vendor/bin/drush --uri=metarow.org config:set system.performance js.preprocess 1 -y
```

## 12. Finaler Test

### Alle Sites testen

```bash
# Status aller Sites prüfen
echo "=== Metarow.org ==="
./vendor/bin/drush --uri=metarow.org status

echo "=== T3MD.de ==="
./vendor/bin/drush --uri=t3md.de status

echo "=== Doebbelin.net ==="
./vendor/bin/drush --uri=doebbelin.net status

echo "=== API ==="
./vendor/bin/drush --uri=api.metarow.org status

# API-Endpoints testen
curl -I https://api.metarow.org/jsonapi/node/article
```

## Wichtige Hinweise

### All-Inkl spezifische Einstellungen

- **PHP-Version**: Im KAS auf PHP 8.2 oder 8.3 einstellen
- **Memory Limit**: Meist 256MB, ggf. über .htaccess erhöhen
- **Execution Time**: Bei größeren Sites ggf. anpassen
- **Cron-Jobs**: Im KAS einrichten für `drush cron`

### Troubleshooting

- **Berechtigungsfehler**: `chmod 755` für Verzeichnisse, `chmod 644` für Dateien
- **Memory-Fehler**: `ini_set('memory_limit', '512M')` in settings.php
- **Timeout-Fehler**: `ini_set('max_execution_time', 300)` in settings.php

### Svelte-Integration

Die API unter `api.metarow.org` ist bereit für Svelte-Frontends:

```javascript
// Beispiel API-Call aus Svelte
fetch('https://api.metarow.org/jsonapi/node/article', {
  headers: {
    'Accept': 'application/vnd.api+json'
  }
})
.then(response => response.json())
.then(data => console.log(data));
```

## Erfolgskontrolle

Nach der Installation sollten verfügbar sein:

- ✅ https://metarow.org (Hauptseite)
- ✅ https://t3md.de (Site 2)
- ✅ https://doebbelin.net (Site 3)
- ✅ https://api.metarow.org (Headless API)
- ✅ https://api.metarow.org/jsonapi/node/article (JSON:API)

**Login-Daten für alle Sites:**

- Benutzername: admin
- Passwort: [Das von Ihnen gewählte sichere Passwort]