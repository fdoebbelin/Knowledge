## Vorbereitung und Systemanforderungen

### Windows-Voraussetzungen prüfen
```powershell
# PowerShell als Administrator öffnen
# Podman Version prüfen
podman --version

# WSL2 Status prüfen (falls verwendet)
wsl --status

# Verfügbaren Speicherplatz prüfen (mindestens 2GB empfohlen)
Get-Volume C | Select-Object @{Name="Frei (GB)";Expression={[math]::Round($_.SizeRemaining/1GB,2)}}, @{Name="Gesamt (GB)";Expression={[math]::Round($_.Size/1GB,2)}}

# Verfügbaren RAM prüfen (mindestens 2GB empfohlen)
(Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1GB
```

### Windows-spezifische Netzwerk-Konfiguration
- **Standard-Port**: 8080 (HTTP)
- **Datenbank-Port**: 3306 (MySQL, Container-intern)
- **Windows Firewall**: Ports automatisch durch Podman Desktop geöffnet
- **Lokaler Zugriff**: http://localhost:8080

## Schritt 1: Podman Pod erstellen (Windows-optimiert)

```powershell
# Pod für ProjeQtOr erstellen (Windows PowerShell)
podman pod create `
  --name projeqtor-pod `
  --publish 8080:80 `
  --share net

# Pod-Status überprüfen
podman pod ls

# Pod-Details anzeigen
podman pod inspect projeqtor-pod
```

## Schritt 2: MySQL/MariaDB Container im Pod

```powershell
# MySQL Container im Pod erstellen

# Container-Status prüfen
podman ps --pod

# Logs überprüfen (wichtig für Troubleshooting)
podman logs projeqtor-mysql
```

### Datenbank-Initialisierung warten und testen
```powershell
# 60 Sekunden warten bis MySQL vollständig gestartet ist
Start-Sleep -Seconds 60

# Datenbankverbindung testen
podman exec -it projeqtor-mysql mysql -uprojeqtor -pProjeQtOr_User_2024! -e "SHOW DATABASES;"
```

## Schritt 3: ProjeQtOr Container im Pod

### Erstellen eines Custom PHP-Image:
```Dockerfile
# ProjeQtOr Container für Windows Podman
# Optimiert für Docker Layer Caching und minimale Rebuilds
FROM php:8.1-apache

# Metadata für Windows Podman (früh im Dockerfile für besseres Caching)
LABEL maintainer="ProjeQtOr Custom Build"
LABEL description="ProjeQtOr with embedded source code for Windows Podman"
LABEL vendor="Custom Build"
LABEL org.opencontainers.image.title="ProjeQtOr"
LABEL org.opencontainers.image.description="Complete ProjeQtOr installation"
LABEL org.opencontainers.image.vendor="Custom"

# Build-Argumente (früh definieren für bessere Cache-Nutzung)
ARG DEBIAN_FRONTEND=noninteractive
ARG BUILD_DATE
ARG VCS_REF

# Labels für bessere Podman Desktop Integration
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.revision=${VCS_REF}

# System-Pakete installieren (separater Layer, cached solange sich Pakete nicht ändern)
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Download-Tools
    wget \
    curl \
    unzip \
    # Grafik-Bibliotheken für GD Extension
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    # ZIP-Unterstützung
    libzip-dev \
    # MySQL/MariaDB Client
    default-mysql-client \
    # Zusätzliche nützliche Tools
    nano \
    less \
    # SSL/TLS Unterstützung
    ca-certificates \
    # Cleanup in derselben Layer
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get autoremove -y

# PHP Extensions installieren (separater Layer, cached solange sich Extensions nicht ändern)
RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        # Grafik-Unterstützung
        gd \
        # Datenbank-Unterstützung
        mysqli \
        pdo \
        pdo_mysql \
        # Archive-Unterstützung
        zip \
        # Performance-Optimierung
        opcache \
        # Weitere nützliche Extensions
        exif \
        gettext

# ProjeQtOr-optimierte PHP-Konfiguration (cached, ändert sich selten)
RUN { \
        echo '# ProjeQtOr PHP Configuration'; \
        echo 'max_input_vars = 4000'; \
        echo 'memory_limit = 512M'; \
        echo 'upload_max_filesize = 100M'; \
        echo 'post_max_size = 100M'; \
        echo 'max_execution_time = 300'; \
        echo 'max_input_time = 300'; \
        echo 'session.gc_maxlifetime = 3600'; \
        echo 'date.timezone = Europe/Berlin'; \
        echo 'log_errors = On'; \
        echo 'error_log = /var/log/apache2/php_errors.log'; \
        echo 'display_errors = Off'; \
        echo 'display_startup_errors = Off'; \
    } > /usr/local/etc/php/conf.d/projeqtor.ini

# OPcache-Konfiguration für bessere Performance (cached, ändert sich selten)
RUN { \
        echo '# OPcache Configuration for ProjeQtOr'; \
        echo 'opcache.enable = 1'; \
        echo 'opcache.memory_consumption = 128'; \
        echo 'opcache.interned_strings_buffer = 8'; \
        echo 'opcache.max_accelerated_files = 4000'; \
        echo 'opcache.revalidate_freq = 2'; \
        echo 'opcache.fast_shutdown = 1'; \
        echo 'opcache.enable_cli = 0'; \
        echo 'opcache.validate_timestamps = 1'; \
    } > /usr/local/etc/php/conf.d/opcache.ini

# Apache-Module aktivieren (cached, ändert sich selten)
RUN a2enmod rewrite headers expires deflate

# Apache-Konfiguration für ProjeQtOr (cached, ändert sich selten)
RUN { \
        echo '<VirtualHost *:80>'; \
        echo '    DocumentRoot /var/www/html'; \
        echo '    ServerName localhost'; \
        echo '    ServerAlias projeqtor.local'; \
        echo ''; \
        echo '    # Hauptverzeichnis-Konfiguration'; \
        echo '    <Directory /var/www/html>'; \
        echo '        AllowOverride All'; \
        echo '        Require all granted'; \
        echo '        Options -Indexes +FollowSymLinks'; \
        echo '        DirectoryIndex index.php index.html'; \
        echo '    </Directory>'; \
        echo ''; \
        echo '    # Sicherheits-Header'; \
        echo '    Header always set X-Content-Type-Options nosniff'; \
        echo '    Header always set X-Frame-Options SAMEORIGIN'; \
        echo '    Header always set X-XSS-Protection "1; mode=block"'; \
        echo '    Header always set Referrer-Policy "strict-origin-when-cross-origin"'; \
        echo ''; \
        echo '    # Kompression für bessere Performance'; \
        echo '    <Location />'; \
        echo '        SetOutputFilter DEFLATE'; \
        echo '        SetEnvIfNoCase Request_URI \\.(?:gif|jpe?g|png)$ no-gzip dont-vary'; \
        echo '        SetEnvIfNoCase Request_URI \\.(?:exe|t?gz|zip|bz2|sit|rar)$ no-gzip dont-vary'; \
        echo '    </Location>'; \
        echo ''; \
        echo '    # Cache-Control für statische Dateien'; \
        echo '    <LocationMatch "\\.(css|js|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$">'; \
        echo '        ExpiresActive On'; \
        echo '        ExpiresDefault "access plus 1 month"'; \
        echo '        Header set Cache-Control "public, immutable"'; \
        echo '    </LocationMatch>'; \
        echo ''; \
        echo '    # Sicherheit für sensible Dateien'; \
        echo '    <FilesMatch "\\.(env|ini|log|conf)$">'; \
        echo '        Require all denied'; \
        echo '    </FilesMatch>'; \
        echo ''; \
        echo '    # Logs'; \
        echo '    ErrorLog /var/log/apache2/projeqtor_error.log'; \
        echo '    CustomLog /var/log/apache2/projeqtor_access.log combined'; \
        echo '    LogLevel warn'; \
        echo '</VirtualHost>'; \
    } > /etc/apache2/sites-available/projeqtor.conf \
    && a2ensite projeqtor \
    && a2dissite 000-default

# Log-Verzeichnisse für Apache erstellen (cached, ändert sich selten)
RUN mkdir -p /var/log/apache2 \
    && chown -R www-data:www-data /var/log/apache2

# Basis-Verzeichnisstruktur erstellen (cached, ändert sich selten)
RUN mkdir -p /var/www/html \
    && mkdir -p \
        /var/www/html/files/logs \
        /var/www/html/files/thumbs \
        /var/www/html/files/config \
        /var/www/html/files/tmp \
        /var/www/html/files/import \
        /var/www/html/files/export \
        /var/www/html/attachments \
        /var/www/html/tool/parameters \
        /var/www/html/report \
        /var/www/html/plugin

# Standard .htaccess für ProjeQtOr erstellen (cached, ändert sich selten)
RUN { \
        echo '# ProjeQtOr .htaccess Configuration'; \
        echo 'RewriteEngine On'; \
        echo ''; \
        echo '# Security - Deny access to sensitive files'; \
        echo '<Files ~ "\\.(env|ini|log|conf|sql|bak|tmp)$">'; \
        echo '    Require all denied'; \
        echo '</Files>'; \
        echo ''; \
        echo '# Security - Deny access to dot files/directories'; \
        echo '<Files ~ "^\\.">'; \
        echo '    Require all denied'; \
        echo '</Files>'; \
        echo ''; \
        echo '# Main rewrite rules'; \
        echo 'RewriteCond %{REQUEST_FILENAME} !-f'; \
        echo 'RewriteCond %{REQUEST_FILENAME} !-d'; \
        echo 'RewriteRule ^(.*)$ index.php [QSA,L]'; \
        echo ''; \
        echo '# Compression'; \
        echo '<IfModule mod_deflate.c>'; \
        echo '    AddOutputFilterByType DEFLATE text/plain text/html text/xml text/css text/javascript application/javascript application/json'; \
        echo '</IfModule>'; \
        echo ''; \
        echo '# Browser Caching'; \
        echo '<IfModule mod_expires.c>'; \
        echo '    ExpiresActive On'; \
        echo '    ExpiresByType image/png "access plus 1 month"'; \
        echo '    ExpiresByType image/jpg "access plus 1 month"'; \
        echo '    ExpiresByType image/jpeg "access plus 1 month"'; \
        echo '    ExpiresByType image/gif "access plus 1 month"'; \
        echo '    ExpiresByType text/css "access plus 1 week"'; \
        echo '    ExpiresByType application/javascript "access plus 1 week"'; \
        echo '</IfModule>'; \
    } > /var/www/html/.htaccess

# Startup-Script erstellen (cached, ändert sich selten)
RUN { \
        echo '#!/bin/bash'; \
        echo 'set -e'; \
        echo ''; \
        echo 'echo "Starting ProjeQtOr Container..."'; \
        echo ''; \
        echo '# Berechtigungen bei jedem Start prüfen und korrigieren'; \
        echo 'echo "Checking permissions..."'; \
        echo 'chown -R www-data:www-data /var/www/html/files || true'; \
        echo 'chown -R www-data:www-data /var/www/html/attachments || true'; \
        echo 'chown -R www-data:www-data /var/www/html/tool/parameters || true'; \
        echo 'chmod -R 775 /var/www/html/files || true'; \
        echo 'chmod -R 775 /var/www/html/attachments || true'; \
        echo 'chmod -R 775 /var/www/html/tool/parameters || true'; \
        echo ''; \
        echo '# Überprüfen ob wichtige Verzeichnisse existieren'; \
        echo 'mkdir -p /var/www/html/files/logs'; \
        echo 'mkdir -p /var/www/html/files/tmp'; \
        echo 'touch /var/www/html/files/logs/projeqtor.log'; \
        echo 'touch /var/www/html/tool/parameters/parameters.php'; \
        echo ''; \
        echo 'echo "ProjeQtOr Container ready!"'; \
        echo 'echo "Access ProjeQtOr at: http://localhost/"'; \
        echo ''; \
        echo '# Apache im Vordergrund starten'; \
        echo 'exec apache2-foreground'; \
    } > /usr/local/bin/projeqtor-entrypoint.sh \
    && chmod +x /usr/local/bin/projeqtor-entrypoint.sh

# Health Check für Container-Überwachung (cached, ändert sich selten)
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost/ -H "Host: localhost" || exit 1

# Umgebungsvariablen für Container (cached, ändert sich selten)
ENV APACHE_DOCUMENT_ROOT=/var/www/html
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_PID_FILE=/var/run/apache2.pid
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV PHP_INI_DIR=/usr/local/etc/php

# Volume-Definitionen für Windows Podman (cached, ändert sich selten)
VOLUME ["/var/www/html/files", "/var/www/html/attachments", "/var/www/html/tool/parameters"]

# Port freigeben (cached, ändert sich selten)
EXPOSE 80

# KRITISCH: ProjeQtOr Version als spätes ARG definieren
# Nur dieser Layer und nachfolgende werden bei Versionsänderung neu erstellt
ARG PROJEQTOR_VERSION=12.1.2

# Version-spezifische Labels (werden bei Versionsänderung neu erstellt)
LABEL version=${PROJEQTOR_VERSION}
LABEL org.opencontainers.image.version=${PROJEQTOR_VERSION}

# ProjeQtOr Quellcode herunterladen (NUR dieser Layer wird bei neuer Version neu erstellt)
WORKDIR /tmp
RUN echo "Downloading ProjeQtOr version ${PROJEQTOR_VERSION}..." \
    && for i in {1..3}; do \
        wget -O projeqtor.zip "https://master.dl.sourceforge.net/project/projectorria/projeqtorV${PROJEQTOR_VERSION}.zip" \
        && break || sleep 5; \
    done \
    && if [ ! -f projeqtor.zip ]; then \
        echo "Download failed, trying alternative URL..."; \
        wget -O projeqtor.zip "https://sourceforge.net/projects/projectorria/files/projeqtorV${PROJEQTOR_VERSION}.zip/download"; \
    fi \
    && echo "Verifying download..." \
    && [ -f projeqtor.zip ] && [ $(stat -c%s projeqtor.zip) -gt 1000000 ] \
    && echo "Download successful, size: $(stat -c%s projeqtor.zip) bytes"

# ProjeQtOr-Dateien extrahieren und installieren (wird bei neuer Version neu erstellt)
RUN echo "Extracting ProjeQtOr ${PROJEQTOR_VERSION}..." \
    && unzip -q projeqtor.zip \
    && rm projeqtor.zip \
    && echo "Installing ProjeQtOr files..." \
    && if [ -d "projeqtor" ]; then \
        echo "Found projeqtor directory"; \
        cp -r projeqtor/* /var/www/html/; \
    elif [ -d "projeqtorV${PROJEQTOR_VERSION}" ]; then \
        echo "Found versioned directory"; \
        cp -r projeqtorV${PROJEQTOR_VERSION}/* /var/www/html/; \
    else \
        echo "Searching for ProjeQtOr files..."; \
        SOURCE_DIR=$(find . -name "index.php" -path "*/view/*" | head -1 | xargs dirname | xargs dirname); \
        if [ -n "$SOURCE_DIR" ]; then \
            echo "Found ProjeQtOr in: $SOURCE_DIR"; \
            cp -r $SOURCE_DIR/* /var/www/html/; \
        else \
            echo "ERROR: Could not find ProjeQtOr files"; \
            exit 1; \
        fi; \
    fi \
    && echo "Cleaning up..." \
    && rm -rf /tmp/* \
    && echo "ProjeQtOr ${PROJEQTOR_VERSION} installation completed"

# Finale Berechtigungen setzen (wird bei neuer Version neu erstellt, aber schnell)
WORKDIR /var/www/html
RUN echo "Setting final permissions..." \
    && touch files/logs/projeqtor.log \
    && touch tool/parameters/parameters.php \
    && chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \; \
    && chmod -R 775 files attachments tool/parameters \
    && chmod 664 tool/parameters/parameters.php \
    && chmod 644 .htaccess \
    && echo "Permissions set successfully for ProjeQtOr ${PROJEQTOR_VERSION}"

# Container-Start mit custom entrypoint
ENTRYPOINT ["/usr/local/bin/projeqtor-entrypoint.sh"]
```

#### Image mit Dockerfile bilden

```PowerShell
podman build -t "localhost/projeqtor:latest" --build-arg "PROJEQTOR_VERSION=12.1.2" .
```

#### Container mit dem Custom Image starten:

```PowerShell
podman run -d `
  --name projeqtor-app `
  --pod projeqtor-pod `
  --env DB_HOST=localhost `
  --env DB_NAME=projeqtor `
  --env DB_USER=projeqtor `
  --env DB_PASSWORD=ProjeQtOr_User_2024! `
  --volume projeqtor-files:/var/www/html/files `
  --volume projeqtor-config:/var/www/html/tool/parameters `
  --volume projeqtor-attachments:/var/www/html/attachments `
  localhost/projeqtor:latest
```

#### Testen der PHP-Konfiguration:

```PowerShell
# PHP-Info im Container anzeigen
podman exec projeqtor-app php -m | Where-Object {$_ -match "pdo|gd|zip"}
podman exec projeqtor-app php -i | Where-Object {$_ -match "max_input_vars"}

# Oder eine phpinfo.php erstellen
echo "<?php phpinfo(); ?>" | podman exec -i projeqtor-app tee /var/www/html/phpinfo.php
```
### Abschluss

```PowerShell
# Alle Container im Pod prüfen
podman pod ps
podman ps --pod

# ProjeQtOr Logs verfolgen
podman logs -f projeqtor-app
```
