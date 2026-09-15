## 1. Vorbereitung und Installation

### Docker installieren (falls nicht vorhanden)

```bash
# Docker und Docker Compose installieren
sudo zypper install docker docker-compose

# Docker-Service starten und aktivieren
sudo systemctl start docker
sudo systemctl enable docker

# Benutzer zur docker-Gruppe hinzufügen
sudo usermod -aG docker $USER

# WICHTIG: Neu einloggen oder System neustarten
# damit die Gruppenmitgliedschaft wirksam wird
```

### DDEV installieren

```bash
# DDEV mit Installationsskript
curl -fsSL https://ddev.com/install.sh | bash

# Installation überprüfen
ddev version
```

## 2. Projekt erstellen und konfigurieren

### Projektverzeichnis erstellen

```bash
# Arbeitsverzeichnis erstellen
mkdir ~/drupal11-multisite
cd ~/drupal11-multisite

# DDEV für Drupal 11 mit PHP 8.3 konfigurieren (WICHTIG!)
ddev config --project-type=drupal11 --php-version=8.3 --webserver-type=nginx-fpm

# Zusätzliche Hostnames für Multi-Site
ddev config --additional-hostnames=blog1,blog2,api
ddev config --additional-fqdns=blog1.ddev.site,blog2.ddev.site,api.ddev.site
```

### DDEV-Container starten

```bash
# Container starten
ddev start

# Status und PHP-Version überprüfen
ddev describe
ddev exec php -v
```

## 3. Drupal 11.1 installieren

### Drupal 11.1 mit Composer installieren

```bash
# Drupal 11.1 erstellen (stabile Version)
ddev composer create drupal/recommended-project:^11.1

# Composer-Installation abschließen
ddev composer install

# Drush installieren (jetzt mit PHP 8.3 kompatibel)
ddev composer require drush/drush

# Installation überprüfen
ddev composer show drupal/core
ddev drush --version
```

## 4. Multi-Site-Struktur einrichten

### Sites-Verzeichnisse erstellen

```bash
# Multi-Site-Verzeichnisse erstellen
mkdir -p web/sites/blog1.ddev.site
mkdir -p web/sites/blog2.ddev.site
mkdir -p web/sites/api.ddev.site

# Verzeichnisstruktur anzeigen
ls -la web/sites/
```

### sites.php konfigurieren

```bash
# sites.php aus Beispieldatei erstellen
cp web/sites/example.sites.php web/sites/sites.php

# sites.php bearbeiten
nano web/sites/sites.php
```

**Inhalt für sites.php:**

```php
<?php
$sites['blog1.ddev.site'] = 'blog1.ddev.site';
$sites['blog2.ddev.site'] = 'blog2.ddev.site';
$sites['api.ddev.site'] = 'api.ddev.site';
```

### Settings-Dateien vorbereiten

```bash
# Settings-Dateien für jede Site erstellen
cp web/sites/default/default.settings.php web/sites/blog1.ddev.site/settings.php
cp web/sites/default/default.settings.php web/sites/blog2.ddev.site/settings.php
cp web/sites/default/default.settings.php web/sites/api.ddev.site/settings.php

# Schreibrechte setzen
chmod 666 web/sites/blog1.ddev.site/settings.php
chmod 666 web/sites/blog2.ddev.site/settings.php
chmod 666 web/sites/api.ddev.site/settings.php
```

## 5. Datenbanken erstellen

### Separate Datenbanken für jede Site

```bash
# Datenbanken erstellen
ddev mysql -e "CREATE DATABASE blog1;"
ddev mysql -e "GRANT ALL PRIVILEGES ON blog1.* TO 'db'@'%';"
ddev mysql -e "CREATE DATABASE blog2;"
ddev mysql -e "GRANT ALL PRIVILEGES ON blog2.* TO 'db'@'%';"
ddev mysql -e "CREATE DATABASE api;"
ddev mysql -e "GRANT ALL PRIVILEGES ON api.* TO 'db'@'%';"

# Datenbanken anzeigen
ddev mysql -e "SHOW DATABASES;"
```

## 6. Drupal-Installation für jede Site

### Hauptsite installieren

```bash
# Hauptsite (default) installieren
ddev drush site:install standard \
  --site-name="Hauptseite" \
  --account-name=admin \
  --account-pass=admin123 \
  --db-url=mysql://db:db@db:3306/db \
  -y

# Installation überprüfen
ddev drush status
```

### Blog1 installieren

```bash
# Blog1 installieren
ddev drush site:install standard \
  --sites-subdir=blog1.ddev.site \
  --site-name="Blog 1" \
  --account-name=admin \
  --account-pass=admin123 \
  --db-url=mysql://db:db@db:3306/blog1 \
  -y

# Status überprüfen
ddev drush --uri=blog1.ddev.site status
```

### Blog2 installieren

```bash
# Blog2 installieren
ddev drush site:install standard \
  --sites-subdir=blog2.ddev.site \
  --site-name="Blog 2" \
  --account-name=admin \
  --account-pass=admin123 \
  --db-url=mysql://db:db@db:3306/blog2 \
  -y

# Status überprüfen
ddev drush --uri=blog2.ddev.site status
```

### API-Site installieren (Headless)

```bash
# API-Site installieren
ddev drush site:install standard \
  --sites-subdir=api.ddev.site \
  --site-name="API Backend" \
  --account-name=admin \
  --account-pass=admin123 \
  --db-url=mysql://db:db@db:3306/api \
  -y

# Status überprüfen
ddev drush --uri=api.ddev.site status
```

## 7. Headless-Konfiguration für API-Site
### JSON:API und verfügbare Core-Module aktivieren

```bash
# Nur verfügbare Module aktivieren
ddev drush --uri=api.ddev.site en jsonapi rest serialization -y

# Module-Status überprüfen
ddev drush --uri=api.ddev.site pml | grep -E "(jsonapi|rest|serialization)"

# Verfügbare Module anzeigen
ddev drush --uri=api.ddev.site pml --status=available | grep -i api
```

### CORS-Konfiguration

```bash
# Schreibrechte für settings.php setzen
chmod 666 web/sites/api.ddev.site/settings.php

cat >> web/sites/api.ddev.site/settings.php << 'EOF'

/**
 * Database settings
 */
$databases['default']['default'] = array (
  'database' => 'api',
  'username' => 'db',
  'password' => 'db',
  'prefix' => '',
  'host' => 'db',
  'port' => '3306',
  'namespace' => 'Drupal\\mysql\\Driver\\Database\\mysql',
  'driver' => 'mysql',
  'autoload' => 'core/modules/mysql/src/Driver/Database/mysql/',
);

$settings['hash_salt'] = 'api-site-hash-salt';

/**
 * CORS Configuration
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
    'http://localhost:5173',
    'http://localhost:3000',
    'https://api.ddev.site',
    '*'
  ],
  'exposedHeaders' => FALSE,
  'maxAge' => FALSE,
  'supportsCredentials' => FALSE,
];

$settings['config_sync_directory'] = '../config/sync';
$settings['file_public_path'] = 'sites/api.ddev.site/files';

$settings['trusted_host_patterns'] = [
  '^api\.ddev\.site$',
  '^localhost$',
];
EOF

# Berechtigung wieder sicher setzen chmod 444 web/sites/api.ddev.site/settings.php
```

### Drupal 11 kompatible Module installieren

```bash
# JSON:API Extras für erweiterte Funktionen
ddev composer require drupal/jsonapi_extras

# OpenAPI für Dokumentation (falls verfügbar)
ddev composer require drupal/openapi

# Consumer und Simple OAuth für Authentifizierung
ddev composer require drupal/consumers drupal/simple_oauth

# Module aktivieren
ddev drush --uri=api.ddev.site en jsonapi_extras -y

# Überprüfen welche Module verfügbar sind
ddev composer show | grep drupal
```

### Alternative: REST-Endpunkte manuell konfigurieren

```bash
# REST-Konfiguration für Artikel
ddev drush --uri=api.ddev.site config:set rest.resource.entity.node method.GET true -y
ddev drush --uri=api.ddev.site config:set rest.resource.entity.node method.POST true -y
ddev drush --uri=api.ddev.site config:set rest.resource.entity.node formats.json true -y
ddev drush --uri=api.ddev.site config:set rest.resource.entity.node authentication.cookie true -y

# Cache leeren
ddev drush --uri=api.ddev.site cr
```

### API-Endpunkte testen

```bash
# JSON:API-Test (sollte funktionieren)
curl -H "Accept: application/vnd.api+json" \
  http://api.ddev.site/jsonapi/node/article

# CORS-Test
curl -I -H "Origin: http://localhost:5173" \
  -H "Access-Control-Request-Method: GET" \
  -X OPTIONS \
  http://api.ddev.site/jsonapi/node/article

# Verfügbare JSON:API-Endpunkte anzeigen
curl http://api.ddev.site/jsonapi | python3 -m json.tool | head -50
```

### Drupal 11 API-Endpunkte

```bash
# Test verschiedener Endpunkte
echo "=== JSON:API Endpunkte ==="
curl -s http://api.ddev.site/jsonapi/node/article | head -20

echo "=== Benutzer ==="
curl -s http://api.ddev.site/jsonapi/user/user | head -20

echo "=== Content-Types ==="
curl -s http://api.ddev.site/jsonapi/node_type/node_type | head -20
```

### services.yml für CORS (Alternative)

```bash
# services.yml erstellen falls settings.php nicht funktioniert
cat > web/sites/api.ddev.site/services.yml << 'EOF'
parameters:
  cors.config:
    enabled: true
    allowedHeaders: ['x-csrf-token', 'authorization', 'content-type', 'accept', 'origin', 'x-requested-with']
    allowedMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS', 'PATCH']
    allowedOrigins: ['http://localhost:5173', 'http://localhost:3000', '*']
    allowedOriginsPatterns: []
    allowedHeadersPatterns: []
    exposedHeaders: false
    maxAge: false
    supportsCredentials: false
EOF
```

### Überprüfung der Installation

```bash
# Aktive Module prüfen
ddev drush --uri=api.ddev.site pml --status=enabled | grep -E "(jsonapi|rest|serial)"

# API-Status prüfen
ddev drush --uri=api.ddev.site status

# Cache leeren
ddev drush --uri=api.ddev.site cr

# Finale Tests
curl -I http://api.ddev.site/jsonapi/node/article
```
## 8. Blog-spezifische Konfiguration

### Content-Types und Module für Blogs

```bash
# Nützliche Module für Blogs installieren
ddev composer require drupal/pathauto drupal/metatag drupal/token

# Module für Blog1 aktivieren
ddev drush --uri=blog1.ddev.site en pathauto metatag token -y

# Module für Blog2 aktivieren
ddev drush --uri=blog2.ddev.site en pathauto metatag token -y

# URL-Aliase konfigurieren
ddev drush --uri=blog1.ddev.site config:set pathauto.pattern.content_article_pattern pattern '/blog/[node:title]' -y
ddev drush --uri=blog2.ddev.site config:set pathauto.pattern.content_article_pattern pattern '/blog/[node:title]' -y
```

### Beispiel-Content erstellen

```bash
# Test-Artikel für Blog1 erstellen
ddev drush --uri=blog1.ddev.site generate:content 5

# Test-Artikel für Blog2 erstellen
ddev drush --uri=blog2.ddev.site generate:content 5

# Test-Artikel für API erstellen
ddev drush --uri=api.ddev.site generate:content 3
```

## 9. Svelte-Integration vorbereiten

### Node.js-Support für DDEV

```bash
# Node.js-Add-on für DDEV installieren
ddev get drud/ddev-nodejs

# Oder manuell konfigurieren
cat >> .ddev/config.yaml << 'EOF'

web_extra_exposed_ports:
  - name: "svelte-dev"
    port: 5173
    http_port: 5172
    https_port: 5173
  - name: "node-dev"
    port: 3000
    http_port: 3001
    https_port: 3000

nodejs_version: "20"
EOF

# DDEV neustarten
ddev restart
```

### Svelte-Projekt vorbereiten

```bash
# Svelte-Projekt-Verzeichnis erstellen
mkdir svelte-frontend
cd svelte-frontend

# Svelte-Projekt initialisieren (in DDEV-Container)
ddev exec npm create svelte@latest my-app
cd my-app

# Dependencies installieren
ddev exec npm install

# Axios für API-Calls installieren
ddev exec npm install axios

# Zurück ins Hauptverzeichnis
cd ../../
```

## 10. Testen und Überprüfung

### URLs überprüfen

```bash
# Alle URLs anzeigen
ddev describe
```

**Verfügbare URLs:**

- Hauptsite: `https://drupal11-multisite.ddev.site`
- Blog1: `https://blog1.ddev.site`
- Blog2: `https://blog2.ddev.site`
- API: `https://api.ddev.site`
- API-Endpoints: `https://api.ddev.site/jsonapi/node/article`

### Login-Daten

- **Benutzername:** admin
- **Passwort:** admin123

### Alle Sites testen

```bash
# Status aller Sites überprüfen
echo "=== Hauptsite ==="
ddev drush status

echo "=== Blog1 ==="
ddev drush --uri=blog1.ddev.site status

echo "=== Blog2 ==="
ddev drush --uri=blog2.ddev.site status

echo "=== API ==="
ddev drush --uri=api.ddev.site status

# JSON:API-Test
echo "=== API-Test ==="
curl -s -H "Accept: application/vnd.api+json" \
  http://api.ddev.site/jsonapi/node/article | head -20
```

## 11. Entwicklungs-Workflow

### Täglich verwendete Kommandos

```bash
# Projekt starten/stoppen
ddev start
ddev stop
ddev restart

# Cache leeren (alle Sites)
ddev drush cr
ddev drush --uri=blog1.ddev.site cr
ddev drush --uri=blog2.ddev.site cr
ddev drush --uri=api.ddev.site cr

# Datenbank-Export/Import
ddev export-db --file=backup.sql
ddev import-db --file=backup.sql

# SSH in Container
ddev ssh

# Logs anzeigen
ddev logs

# Module installieren/aktivieren
ddev composer require drupal/module_name
ddev drush --uri=SITE_URI en module_name -y
```

### Svelte-Entwicklung

```bash
# Svelte-Dev-Server starten
cd svelte-frontend/my-app
ddev exec npm run dev

# Build für Produktion
ddev exec npm run build
```

## 12. Backup und Wartung

### Automatisiertes Backup-Skript

```bash
# Backup-Skript erstellen
cat > backup.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M)
BACKUP_DIR="backups/$DATE"

mkdir -p $BACKUP_DIR

# Datenbank-Backups
ddev export-db --file="$BACKUP_DIR/main.sql"
ddev mysql -e "mysqldump blog1" > "$BACKUP_DIR/blog1.sql"
ddev mysql -e "mysqldump blog2" > "$BACKUP_DIR/blog2.sql"
ddev mysql -e "mysqldump api" > "$BACKUP_DIR/api.sql"

# Dateien-Backup
tar -czf "$BACKUP_DIR/files.tar.gz" web/sites/*/files

echo "Backup erstellt in: $BACKUP_DIR"
EOF

chmod +x backup.sh
```

### Update-Routine

```bash
# Drupal-Updates
ddev composer update drupal/core-recommended --with-dependencies
ddev drush updb -y
ddev drush cr

# Module-Updates
ddev composer update
ddev drush updb -y
ddev drush cr
```

## 13. Troubleshooting

### Häufige Probleme und Lösungen

```bash
# PHP-Version prüfen
ddev exec php -v

# Composer-Cache leeren
ddev composer clear-cache

# Permissions reparieren
ddev exec chmod 755 web/sites/default
ddev exec chmod 644 web/sites/default/settings.php

# Container komplett neu bauen
ddev delete -Oy
ddev start

# Drush-Rebuild
ddev drush rebuild

# Alle Caches leeren
ddev drush --uri=blog1.ddev.site cr
ddev drush --uri=blog2.ddev.site cr
ddev drush --uri=api.ddev.site cr
```

## 14. Nächste Schritte

Das Setup ist jetzt vollständig! Du hast:

- ✅ Drupal 11.1 Multi-Site Installation mit PHP 8.3
- ✅ Drush vollständig funktional
- ✅ 3 separate Sites (2 Blogs + 1 API)
- ✅ Headless-Backend für Svelte vorbereitet
- ✅ JSON:API und CORS konfiguriert
- ✅ Node.js-Support für Svelte-Entwicklung
- ✅ Lokale Entwicklungsumgebung mit DDEV

**Für Svelte-Integration:**

1. API-Endpoints testen: `https://api.ddev.site/jsonapi/node/article`
2. Svelte-App entwickeln mit Axios für API-Calls
3. CORS ist bereits für localhost:5173 konfiguriert