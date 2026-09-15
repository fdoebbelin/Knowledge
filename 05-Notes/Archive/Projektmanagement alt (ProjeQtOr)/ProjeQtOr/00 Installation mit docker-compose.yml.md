## Vorbereitung und Systemanforderungen

### Windows-Voraussetzungen prüfen
```powershell
# PowerShell als Administrator öffnen
# Podman Version prüfen
podman --version

# WSL2 Status prüfen (falls verwendet)
wsl --status

# Verfügbaren Speicherplatz prüfen (mindestens 4GB empfohlen)
Get-Volume C | Select-Object @{Name="Frei (GB)";Expression={[math]::Round($_.SizeRemaining/1GB,2)}}, @{Name="Gesamt (GB)";Expression={[math]::Round($_.Size/1GB,2)}}

# Verfügbaren RAM prüfen (mindestens 4GB empfohlen)
[math]::Round((Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
```

### Projekt-Verzeichnis erstellen
```powershell
# ProjeQtOr-Projektverzeichnis erstellen
mkdir C:\projeqtor-podman
cd C:\projeqtor-podman

# Unterverzeichnisse erstellen
mkdir files
mkdir config
mkdir attachments
mkdir logs
mkdir database
```

## Schritt 1: Dockerfile für ProjeQtOr erstellen

```powershell
# Dockerfile für ProjeQtOr erstellen
@"
# ProjeQtOr Container für Windows Podman
FROM php:8.1-apache

# Metadata
LABEL maintainer="ProjeQtOr Custom Build"
LABEL description="ProjeQtOr with embedded source code for Windows Podman"
LABEL vendor="Custom Build"

# Build-Argumente
ARG DEBIAN_FRONTEND=noninteractive
ARG PROJEQTOR_VERSION=12.1.2

# System-Pakete installieren
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    unzip \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    default-mysql-client \
    nano \
    less \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get autoremove -y

# PHP Extensions installieren
RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-install -j`$(nproc) \
        gd \
        mysqli \
        pdo \
        pdo_mysql \
        zip \
        opcache \
        exif \
        gettext

# ProjeQtOr PHP-Konfiguration
RUN { \
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
    } > /usr/local/etc/php/conf.d/projeqtor.ini

# OPcache-Konfiguration
RUN { \
        echo 'opcache.enable = 1'; \
        echo 'opcache.memory_consumption = 128'; \
        echo 'opcache.interned_strings_buffer = 8'; \
        echo 'opcache.max_accelerated_files = 4000'; \
        echo 'opcache.revalidate_freq = 2'; \
        echo 'opcache.fast_shutdown = 1'; \
    } > /usr/local/etc/php/conf.d/opcache.ini

# Apache-Module aktivieren
RUN a2enmod rewrite headers expires deflate

# Apache-Konfiguration
RUN { \
        echo '<VirtualHost *:80>'; \
        echo '    DocumentRoot /var/www/html'; \
        echo '    ServerName localhost'; \
        echo '    <Directory /var/www/html>'; \
        echo '        AllowOverride All'; \
        echo '        Require all granted'; \
        echo '        Options -Indexes +FollowSymLinks'; \
        echo '        DirectoryIndex index.php'; \
        echo '    </Directory>'; \
        echo '    Header always set X-Content-Type-Options nosniff'; \
        echo '    Header always set X-Frame-Options SAMEORIGIN'; \
        echo '    Header always set X-XSS-Protection "1; mode=block"'; \
        echo '    ErrorLog /var/log/apache2/projeqtor_error.log'; \
        echo '    CustomLog /var/log/apache2/projeqtor_access.log combined'; \
        echo '</VirtualHost>'; \
    } > /etc/apache2/sites-available/projeqtor.conf \
    && a2ensite projeqtor \
    && a2dissite 000-default

# Verzeichnisstruktur erstellen
RUN mkdir -p /var/www/html \
    && mkdir -p \
        /var/www/html/files/logs \
        /var/www/html/files/thumbs \
        /var/www/html/files/config \
        /var/www/html/files/tmp \
        /var/www/html/files/import \
        /var/www/html/files/export \
        /var/www/html/attachments \
        /var/www/html/tool/parameters

# ProjeQtOr herunterladen und installieren
WORKDIR /tmp
RUN echo "Downloading ProjeQtOr version `${PROJEQTOR_VERSION}..." \
    && wget -O projeqtor.zip "https://master.dl.sourceforge.net/project/projectorria/projeqtorV`${PROJEQTOR_VERSION}.zip" \
    && unzip -q projeqtor.zip \
    && rm projeqtor.zip \
    && if [ -d "projeqtor" ]; then \
        cp -r projeqtor/* /var/www/html/; \
    elif [ -d "projeqtorV`${PROJEQTOR_VERSION}" ]; then \
        cp -r projeqtorV`${PROJEQTOR_VERSION}/* /var/www/html/; \
    fi \
    && rm -rf /tmp/*

# Berechtigungen setzen
WORKDIR /var/www/html
RUN touch files/logs/projeqtor.log \
    && touch tool/parameters/parameters.php \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 775 files attachments tool/parameters

# Startup-Script
RUN { \
        echo '#!/bin/bash'; \
        echo 'set -e'; \
        echo 'echo "Starting ProjeQtOr Container..."'; \
        echo 'chown -R www-data:www-data /var/www/html/files || true'; \
        echo 'chown -R www-data:www-data /var/www/html/attachments || true'; \
        echo 'chown -R www-data:www-data /var/www/html/tool/parameters || true'; \
        echo 'chmod -R 775 /var/www/html/files || true'; \
        echo 'chmod -R 775 /var/www/html/attachments || true'; \
        echo 'chmod -R 775 /var/www/html/tool/parameters || true'; \
        echo 'echo "ProjeQtOr ready at http://localhost:8080"'; \
        echo 'exec apache2-foreground'; \
    } > /usr/local/bin/projeqtor-entrypoint.sh \
    && chmod +x /usr/local/bin/projeqtor-entrypoint.sh

# Health Check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

VOLUME ["/var/www/html/files", "/var/www/html/attachments", "/var/www/html/tool/parameters"]
EXPOSE 80

ENTRYPOINT ["/usr/local/bin/projeqtor-entrypoint.sh"]
"@ | Out-File -FilePath "Dockerfile" -Encoding UTF8
```

## Schritt 2: docker-compose.yml erstellen

```powershell
# Haupt-Compose-Datei erstellen
@"
version: '3.8'

services:
  # MySQL Database für ProjeQtOr
  mysql:
    image: mysql:8.0
    container_name: projeqtor-mysql
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: ProjeQtOr_Root_2024!
      MYSQL_DATABASE: projeqtor
      MYSQL_USER: projeqtor
      MYSQL_PASSWORD: ProjeQtOr_User_2024!
      MYSQL_CHARACTER_SET_SERVER: utf8mb4
      MYSQL_COLLATION_SERVER: utf8mb4_unicode_ci
    volumes:
      - mysql-data:/var/lib/mysql
      - ./database:/docker-entrypoint-initdb.d:ro
      - ./logs/mysql:/var/log/mysql:z
    ports:
      - "3306:3306"
    networks:
      - projeqtor-network
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-u", "projeqtor", "-pProjeQtOr_User_2024!"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s
    command: >
      --default-authentication-plugin=mysql_native_password
      --character-set-server=utf8mb4
      --collation-server=utf8mb4_unicode_ci
      --innodb_buffer_pool_size=256M
      --max_connections=200

  # ProjeQtOr Anwendung
  projeqtor:
    build:
      context: .
      dockerfile: Dockerfile
      args:
        PROJEQTOR_VERSION: 12.1.2
    container_name: projeqtor-app
    restart: unless-stopped
    depends_on:
      mysql:
        condition: service_healthy
    environment:
      - DB_HOST=mysql
      - DB_NAME=projeqtor
      - DB_USER=projeqtor
      - DB_PASSWORD=ProjeQtOr_User_2024!
      - APACHE_DOCUMENT_ROOT=/var/www/html
    volumes:
      - ./files:/var/www/html/files:z
      - ./config:/var/www/html/tool/parameters:z
      - ./attachments:/var/www/html/attachments:z
      - ./logs/apache:/var/log/apache2:z
    ports:
      - "8080:80"
    networks:
      - projeqtor-network
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s

  # phpMyAdmin (optional)
  phpmyadmin:
    image: phpmyadmin:latest
    container_name: projeqtor-phpmyadmin
    restart: unless-stopped
    depends_on:
      mysql:
        condition: service_healthy
    environment:
      PMA_HOST: mysql
      PMA_PORT: 3306
      PMA_USER: root
      PMA_PASSWORD: ProjeQtOr_Root_2024!
      UPLOAD_LIMIT: 100M
    ports:
      - "8081:80"
    networks:
      - projeqtor-network

volumes:
  mysql-data:
    name: projeqtor-mysql-data

networks:
  projeqtor-network:
    name: projeqtor-network
    driver: bridge
"@ | Out-File -FilePath "docker-compose.yml" -Encoding UTF8
```

## Schritt 3: Konfigurationsdateien erstellen

### MySQL-Initialisierungsscript
```powershell
# MySQL-Init-Script für ProjeQtOr-optimierte Konfiguration
@"
-- ProjeQtOr MySQL Initialization Script
-- Erstellt optimierte Datenbank-Konfiguration

-- Datenbank-Einstellungen optimieren
SET GLOBAL innodb_buffer_pool_size = 268435456; -- 256MB
SET GLOBAL max_connections = 200;
SET GLOBAL wait_timeout = 28800;
SET GLOBAL interactive_timeout = 28800;

-- ProjeQtOr-spezifische Konfiguration
USE projeqtor;

-- Charset und Collation sicherstellen
ALTER DATABASE projeqtor CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Benutzer-Berechtigungen erweitern
GRANT ALL PRIVILEGES ON projeqtor.* TO 'projeqtor'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER ON projeqtor.* TO 'projeqtor'@'%';
FLUSH PRIVILEGES;

-- Log-Tabelle für ProjeQtOr vorbereiten (falls noch nicht vorhanden)
-- Diese wird normalerweise von ProjeQtOr selbst erstellt
"@ | Out-File -FilePath "database\01-init-projeqtor.sql" -Encoding UTF8
```

### ProjeQtOr-Konfigurationsdatei
```powershell
# ProjeQtOr-Parameter-Datei erstellen
@"
<?php
// ProjeQtOr Configuration File
// Auto-generated for Docker Compose Setup

// Database Configuration
`$paramDbType = 'mysql';
`$paramDbHost = 'mysql';
`$paramDbPort = '3306';
`$paramDbName = 'projeqtor';
`$paramDbUser = 'projeqtor';
`$paramDbPassword = 'ProjeQtOr_User_2024!';

// Application Configuration
`$paramDbPrefix = '';
`$paramAttachmentDirectory = '../attachments';
`$paramAttachmentMaxSize = 104857600; // 100MB
`$paramLogFile = '../files/logs/projeqtor.log';
`$paramLogLevel = 3; // INFO level

// Mail Configuration (optional - kann später über UI konfiguriert werden)
`$paramMailSendmailPath = '/usr/sbin/sendmail';
`$paramMailSmtpHost = '';
`$paramMailSmtpPort = 25;
`$paramMailSmtpUsername = '';
`$paramMailSmtpPassword = '';

// Security Configuration
`$paramSecurityPasswordMinLength = 8;
`$paramSecurityPasswordRequireDigit = true;
`$paramSecurityPasswordRequireSpecial = false;

// Performance Configuration
`$paramMaxBackupSize = 1073741824; // 1GB
`$paramMaxImportLines = 1000;

// Timezone
`$paramDefaultTimezone = 'Europe/Berlin';

// Session Configuration
`$paramSessionTimeout = 3600; // 1 hour

// Development/Production Mode
`$paramDebugMode = false;
`$paramShowSql = false;

// File Upload
`$paramFileMaxSize = 104857600; // 100MB

echo "ProjeQtOr configuration loaded successfully.\\n";
?>
"@ | Out-File -FilePath "config\parameters.php" -Encoding UTF8
```

### Apache-Log-Rotation
```powershell
# Log-Rotation-Konfiguration
@"
# Apache Log Rotation for ProjeQtOr
/var/log/apache2/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    sharedscripts
    postrotate
        /usr/sbin/apache2ctl graceful > /dev/null 2>&1 || true
    endscript
}
"@ | Out-File -FilePath "logs\apache-logrotate.conf" -Encoding UTF8
```

## Schritt 4: Startup-Script für Windows

```powershell
# Windows-Startup-Script für ProjeQtOr
@"
# ProjeQtOr Podman Compose Startup Script
`$projectPath = "C:\projeqtor-podman"
`$logPath = "`$projectPath\startup.log"

function Write-Log {
    param(`$Message)
    `$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "`$timestamp - `$Message" | Out-File -FilePath `$logPath -Append
    Write-Host "`$timestamp - `$Message"
}

try {
    Write-Log "Starting ProjeQtOr with Podman Compose..."
    Set-Location `$projectPath
    
    # Warten bis Podman verfügbar ist
    `$timeout = 120
    `$timer = 0
    do {
        Start-Sleep 5
        `$timer += 5
        `$podmanStatus = podman version 2>`$null
        Write-Log "Waiting for Podman... (`$timer/`$timeout)"
    } while (-not `$podmanStatus -and `$timer -lt `$timeout)
    
    if (`$podmanStatus) {
        Write-Log "Podman is ready, starting ProjeQtOr stack..."
        
        # Podman Machine starten falls nötig
        `$machineStatus = podman machine list --format json 2>`$null | ConvertFrom-Json
        if (`$machineStatus -and `$machineStatus[0].Running -eq `$false) {
            Write-Log "Starting Podman machine..."
            podman machine start
            Start-Sleep 15
        }
        
        # ProjeQtOr mit Compose starten
        Write-Log "Building and starting containers..."
        podman compose up -d --build
        
        if (`$LASTEXITCODE -eq 0) {
            Write-Log "ProjeQtOr started successfully!"
            
            # Kurz warten und Status anzeigen
            Start-Sleep 10
            `$status = podman compose ps --format table
            Write-Log "Container Status:`n`$status"
            
            # Health Check warten
            Write-Log "Waiting for services to be ready..."
            `$maxWait = 180
            `$waited = 0
            do {
                Start-Sleep 10
                `$waited += 10
                `$healthy = podman compose ps --format json | ConvertFrom-Json | Where-Object { `$_.Health -eq "healthy" } | Measure-Object | Select-Object -ExpandProperty Count
                Write-Log "Healthy containers: `$healthy/2 (waited `$waited/`$maxWait seconds)"
            } while (`$healthy -lt 2 -and `$waited -lt `$maxWait)
            
            if (`$healthy -eq 2) {
                Write-Log "All services are healthy!"
                Write-Log "ProjeQtOr is available at: http://localhost:8080"
                Write-Log "phpMyAdmin is available at: http://localhost:8081"
            } else {
                Write-Log "Warning: Not all services are healthy yet. Check logs with: podman compose logs"
            }
            
            # Kurze Logs anzeigen
            Write-Log "Recent logs:"
            podman compose logs --tail=10
        } else {
            Write-Log "Error starting containers with exit code: `$LASTEXITCODE"
            Write-Log "Error details:"
            podman compose logs --tail=20
        }
    } else {
        Write-Log "Podman not available after `$timeout seconds"
    }
} catch {
    Write-Log "Error occurred: `$_"
} finally {
    Write-Log "Startup script completed"
}
"@ | Out-File -FilePath "startup-projeqtor.ps1" -Encoding UTF8
```

## Schritt 5: Build und Start

### Image erstellen und Container starten
```powershell
# Im ProjeQtOr-Projektverzeichnis
cd C:\projeqtor-podman

# Berechtigungen für Log-Verzeichnisse setzen
mkdir logs\apache -Force
mkdir logs\mysql -Force

# ProjeQtOr-Stack mit Compose starten
Write-Host "Building ProjeQtOr image..."
podman compose build

Write-Host "Starting ProjeQtOr stack..."
podman compose up -d

# Status prüfen
podman compose ps

# Logs verfolgen
Write-Host "Following logs for 30 seconds..."
timeout 30 podman compose logs -f

Write-Host "`n✅ ProjeQtOr should be available at:"
Write-Host "   ProjeQtOr: http://localhost:8080"
Write-Host "   phpMyAdmin: http://localhost:8081"
```

### Installation testen
```powershell
# Service-Status prüfen
podman compose ps

# Health-Status prüfen
podman compose exec projeqtor curl -f http://localhost/ -I

# Datenbank-Verbindung testen
podman compose exec mysql mysql -u projeqtor -pProjeQtOr_User_2024! -e "SHOW DATABASES;"

# ProjeQtOr-Logs prüfen
podman compose logs projeqtor | Select-String -Pattern "ready\|error\|ProjeQtOr"

# Container-Details anzeigen
podman compose exec projeqtor php -m | Where-Object {$_ -match "pdo\|gd\|zip\|mysqli"}
```

## Schritt 6: Windows Auto-Start konfigurieren

### Task Scheduler einrichten
```powershell
# PowerShell als Administrator ausführen
$taskName = "ProjeQtOr-Podman-AutoStart"
$scriptPath = "C:\projeqtor-podman\startup-projeqtor.ps1"

# Task erstellen
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -File `"$scriptPath`""
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType Interactive -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 2)

# Task registrieren
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force

Write-Host "✅ Windows Auto-Start konfiguriert"
Write-Host "Task '$taskName' wurde erstellt"

# Task testen
Write-Host "Teste Auto-Start Task..."
Start-ScheduledTask -TaskName $taskName
```

## Schritt 7: Wartung und Management

### Häufige Befehle
```powershell
# Stack Management
podman compose up -d                    # Starten
podman compose down                     # Stoppen
podman compose restart                  # Neu starten
podman compose logs -f                  # Logs verfolgen

# Service Management
podman compose restart projeqtor        # ProjeQtOr neu starten
podman compose restart mysql            # MySQL neu starten
podman compose exec projeqtor bash      # In Container einloggen

# Backup und Updates
podman compose pull                     # Images aktualisieren
podman compose build --no-cache         # Image neu bauen
podman compose up -d --force-recreate   # Container neu erstellen
```

### Backup-Script
```powershell
# Backup-Script für ProjeQtOr
@"
# ProjeQtOr Backup Script
`$backupDir = "C:\projeqtor-backups\`$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss')"
New-Item -ItemType Directory -Path `$backupDir -Force

Write-Host "Creating ProjeQtOr backup in: `$backupDir"

# MySQL Dump
Write-Host "Backing up MySQL database..."
podman compose exec mysql mysqladump -u root -pProjeQtOr_Root_2024! --all-databases --routines --triggers > "`$backupDir\mysql-backup.sql"

# Application Files
Write-Host "Backing up application files..."
Copy-Item -Path "C:\projeqtor-podman\files" -Destination "`$backupDir\files" -Recurse
Copy-Item -Path "C:\projeqtor-podman\attachments" -Destination "`$backupDir\attachments" -Recurse
Copy-Item -Path "C:\projeqtor-podman\config" -Destination "`$backupDir\config" -Recurse

# Configuration
Copy-Item -Path "C:\projeqtor-podman\docker-compose.yml" -Destination `$backupDir
Copy-Item -Path "C:\projeqtor-podman\Dockerfile" -Destination `$backupDir

Write-Host "✅ Backup completed: `$backupDir"
"@ | Out-File -FilePath "backup-projeqtor.ps1" -Encoding UTF8

Write-Host "✅ Backup-Script erstellt"
```

## Abschluss und Zugriff

### ProjeQtOr-Zugriff
- **ProjeQtOr-Anwendung**: http://localhost:8080
- **phpMyAdmin**: http://localhost:8081
- **MySQL-Port**: localhost:3306

### Erste Anmeldung
1. Browser öffnen: http://localhost:8080
2. ProjeQtOr-Setup-Assistent durchlaufen
3. Datenbank-Verbindung ist bereits konfiguriert
4. Admin-Benutzer erstellen
5. ProjeQtOr ist einsatzbereit!

### Troubleshooting
```powershell
# Container-Status prüfen
podman compose ps

# Logs anzeigen
podman compose logs projeqtor
podman compose logs mysql

# In Container einloggen für Debug
podman compose exec projeqtor bash
podman compose exec mysql mysql -u root -p

# Netzwerk-Konnektivität testen
podman compose exec projeqtor ping mysql
```

Die ProjeQtOr-Installation ist jetzt mit docker-compose.yml und automatischem Windows-Start konfiguriert!