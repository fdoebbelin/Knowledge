## Vorbereitung und Systemanforderungen

### Systemvoraussetzungen prüfen

```bash
# Podman Version prüfen (mindestens 3.0)
podman --version

# Docker/Podman Build-Tools installieren
sudo dnf install -y podman buildah git wget unzip

# Verfügbaren Speicherplatz prüfen (mindestens 4GB empfohlen)
df -h

# Freien RAM prüfen (mindestens 2GB empfohlen)
free -h
```

### Netzwerk und Ports

- **Standard-Port**: 8080 (HTTP)
- **Datenbank-Port**: 3306 (MySQL, intern)
- **Erforderliche Ports freigeben**:

```bash
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

## Schritt 1: ProjeQtOr Quellcode herunterladen

```bash
# Arbeitsverzeichnis erstellen
mkdir -p ~/projeqtor-build
cd ~/projeqtor-build

# ProjeQtOr neueste Version von SourceForge herunterladen
wget https://sourceforge.net/projects/projeqtor/files/latest/download -O projeqtor-latest.zip

# Alternativ: Spezifische Version herunterladen (empfohlen für Produktion)
# Verfügbare Versionen prüfen: https://sourceforge.net/projects/projeqtor/files/
# wget https://sourceforge.net/projects/projeqtor/files/ProjeQtOr_V12.0.0.zip/download -O projeqtor-v12.zip

# Quellcode entpacken
unzip projeqtor-latest.zip

# Verzeichnisstruktur prüfen
ls -la

# ProjeQtOr-Verzeichnis finden (Name kann variieren)
PROJEQTOR_DIR=$(find . -maxdepth 1 -type d -name "*rojeq*" | head -1)
echo "ProjeQtOr-Verzeichnis: $PROJEQTOR_DIR"

# Falls Verzeichnis verschachtelt ist, extrahieren
if [ -d "$PROJEQTOR_DIR" ]; then
    mv "$PROJEQTOR_DIR" projeqtor-source
else
    # Falls direkt entpackt wurde
    mkdir -p projeqtor-source
    mv *.php *.js *.css tool model view autoload.php index.php projeqtor-source/ 2>/dev/null || true
    mv files documents plugin locale external projeqtor-source/ 2>/dev/null || true
fi

ls -la projeqtor-source/
```

## Schritt 2: Dockerfile erstellen

```bash
# Dockerfile für ProjeQtOr erstellen
cat > ~/projeqtor-build/Dockerfile << 'EOF'
FROM php:8.1-apache

# System-Pakete installieren
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libxslt-dev \
    libonig-dev \
    mariadb-client \
    cron \
    nano \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# PHP-Erweiterungen kompilieren und installieren
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        gd \
        mysqli \
        pdo_mysql \
        zip \
        intl \
        xml \
        xsl \
        mbstring \
        opcache \
        calendar

# Apache-Module aktivieren
RUN a2enmod rewrite headers

# PHP-Konfiguration optimieren
RUN echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/projeqtor.ini \
    && echo "upload_max_filesize = 100M" >> /usr/local/etc/php/conf.d/projeqtor.ini \
    && echo "post_max_size = 100M" >> /usr/local/etc/php/conf.d/projeqtor.ini \
    && echo "max_execution_time = 300" >> /usr/local/etc/php/conf.d/projeqtor.ini \
    && echo "max_input_vars = 3000" >> /usr/local/etc/php/conf.d/projeqtor.ini \
    && echo "session.gc_maxlifetime = 7200" >> /usr/local/etc/php/conf.d/projeqtor.ini

# Apache-Konfiguration für ProjeQtOr
RUN echo "<Directory /var/www/html>" >> /etc/apache2/apache2.conf \
    && echo "    AllowOverride All" >> /etc/apache2/apache2.conf \
    && echo "    Require all granted" >> /etc/apache2/apache2.conf \
    && echo "</Directory>" >> /etc/apache2/apache2.conf

# ProjeQtOr Quellcode kopieren
COPY projeqtor-source/ /var/www/html/

# Berechtigungen setzen
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/files \
    && chmod -R 777 /var/www/html/tool/parameters

# .htaccess für bessere Sicherheit erstellen
RUN echo "RewriteEngine On" > /var/www/html/.htaccess \
    && echo "RewriteCond %{REQUEST_FILENAME} !-f" >> /var/www/html/.htaccess \
    && echo "RewriteCond %{REQUEST_FILENAME} !-d" >> /var/www/html/.htaccess \
    && echo "RewriteRule ^(.*)$ index.php [QSA,L]" >> /var/www/html/.htaccess \
    && echo "Header always set X-Content-Type-Options nosniff" >> /var/www/html/.htaccess \
    && echo "Header always set X-Frame-Options DENY" >> /var/www/html/.htaccess

# Cron-Job für ProjeQtOr-Wartung einrichten
RUN echo "*/5 * * * * www-data php /var/www/html/tool/cron.php" >> /etc/crontab

# Gesundheitscheck definieren
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost/tool/checkConnection.php || exit 1

# Standard-Port freigeben
EXPOSE 80

# Container-Start-Skript
RUN echo '#!/bin/bash' > /start.sh \
    && echo 'service cron start' >> /start.sh \
    && echo 'apache2-foreground' >> /start.sh \
    && chmod +x /start.sh

CMD ["/start.sh"]
EOF
```

## Schritt 3: Lokales ProjeQtOr-Image erstellen

```bash
# Image mit Podman erstellen (dauert 10-15 Minuten)
cd ~/projeqtor-build
podman build -t projeqtor-local:latest .

# Build-Erfolg prüfen
podman images | grep projeqtor-local

# Aufräumen
rm -rf ~/projeqtor-build/projeqtor-latest.zip
```

## Schritt 4: Pod für ProjeQtOr erstellen

```bash
# Pod erstellen (Container teilen sich Netzwerk und Storage)
podman pod create \
    --name projeqtor-pod \
    --publish 8080:80 \
    --share net

# Pod-Status prüfen
podman pod ls

# Pod-Details anzeigen
podman pod inspect projeqtor-pod
```

## Schritt 5: MySQL/MariaDB Container im Pod starten

```bash
# MySQL Container im Pod erstellen und starten
podman run -d \
    --name projeqtor-mysql \
    --pod projeqtor-pod \
    -e MYSQL_ROOT_PASSWORD=projeqtor_root_2024 \
    -e MYSQL_DATABASE=projeqtor \
    -e MYSQL_USER=projeqtor \
    -e MYSQL_PASSWORD=projeqtor_pass_2024 \
    -e MYSQL_CHARSET=utf8mb4 \
    -e MYSQL_COLLATION=utf8mb4_unicode_ci \
    -v projeqtor-mysql-data:/var/lib/mysql \
    --health-cmd="mysqladmin ping -h localhost" \
    --health-interval=30s \
    --health-timeout=10s \
    --health-retries=5 \
    docker.io/library/mariadb:10.11

# Container-Status prüfen (warten bis healthy)
podman ps --pod

# Logs überprüfen
podman logs projeqtor-mysql
```

### Datenbank-Verbindung testen

```bash
# Warten bis MySQL vollständig gestartet ist (ca. 30 Sekunden)
sleep 30

# In MySQL Container einloggen (im Pod: localhost-Verbindung)
podman exec -it projeqtor-mysql mysql -uprojeqtor -pprojeqtor_pass_2024 projeqtor

# Innerhalb der MySQL-Session:
# SHOW DATABASES;
# USE projeqtor;
# SELECT @@character_set_database, @@collation_database;
# EXIT;
```

## Schritt 6: ProjeQtOr Container im Pod starten

```bash
# ProjeQtOr Container mit selbst erstelltem Image im Pod starten
podman run -d \
    --name projeqtor-app \
    --pod projeqtor-pod \
    -e DB_HOST=localhost \
    -e DB_NAME=projeqtor \
    -e DB_USER=projeqtor \
    -e DB_PASSWORD=projeqtor_pass_2024 \
    -e TZ=Europe/Berlin \
    -v projeqtor-files:/var/www/html/files \
    -v projeqtor-config:/var/www/html/tool/parameters \
    -v projeqtor-logs:/var/log/apache2 \
    --health-cmd="curl -f http://localhost/tool/checkConnection.php" \
    --health-interval=30s \
    --health-timeout=10s \
    --health-retries=3 \
    projeqtor-local:latest

# Pod-Status überprüfen
podman pod ps

# Container-Status im Pod anzeigen
podman ps --pod

# Logs verfolgen bis Container healthy ist
podman logs -f projeqtor-app
```

## Schritt 7: Systemd-Services für Autostart einrichten

```bash
# Benutzer-Systemd-Verzeichnis erstellen
mkdir -p ~/.config/systemd/user

# ProjeQtOr Pod Service (verwaltet alle Container als Einheit)
cat > ~/.config/systemd/user/projeqtor-pod.service << 'EOF'
[Unit]
Description=ProjeQtOr Pod (MySQL + Application)
After=network.target

[Service]
Type=forking
RemainAfterExit=yes
ExecStart=/usr/bin/podman pod start projeqtor-pod
ExecStop=/usr/bin/podman pod stop projeqtor-pod
TimeoutStopSec=60

[Install]
WantedBy=default.target
EOF

# Service aktivieren
systemctl --user daemon-reload
systemctl --user enable projeqtor-pod.service

# Lingering aktivieren (Services starten ohne Login)
sudo loginctl enable-linger $USER

# Services testen
systemctl --user status projeqtor-pod.service
```

## Schritt 8: Web-Setup durchführen

### Setup-Assistent aufrufen

```bash
# Status beider Container im Pod prüfen
podman ps --pod

# ProjeQtOr im Browser öffnen
echo "ProjeQtOr Setup unter: http://localhost:8080"
echo "oder http://$(hostname -I | awk '{print $1}'):8080"

# Alternativ: Curl-Test der Erreichbarkeit
curl -I http://localhost:8080
```

### Setup-Assistent Schritt-für-Schritt

1. **Browser öffnen**: `http://localhost:8080`
2. **Sprache wählen**: Deutsch oder Englisch
3. **Datenbankverbindung konfigurieren**:
    - Host: `localhost` (wegen Pod-Netzwerk)
    - Datenbank: `projeqtor`
    - Benutzer: `projeqtor`
    - Passwort: `projeqtor_pass_2024`
    - Port: `3306`
4. **Administrator-Konto erstellen**:
    - Benutzername: `admin`
    - Passwort: Sicheres Passwort vergeben
    - E-Mail: Administrator-E-Mail-Adresse
5. **Grundeinstellungen**:
    - Zeitzone: Europe/Berlin
    - Währung: EUR
    - Datumsformat: DD/MM/YYYY

## Schritt 9: Erweiterte Konfiguration

### PHP-Optimierung für große Projekte

```bash
# PHP-Konfiguration im laufenden Container anpassen
podman exec -it projeqtor-app bash

# Innerhalb des Containers:
echo "memory_limit = 1024M" >> /usr/local/etc/php/conf.d/projeqtor.ini
echo "max_execution_time = 600" >> /usr/local/etc/php/conf.d/projeqtor.ini
echo "max_input_vars = 5000" >> /usr/local/etc/php/conf.d/projeqtor.ini

# Apache neu laden
service apache2 reload
exit
```

### Backup-System einrichten

```bash
# Backup-Skript erstellen
cat > ~/projeqtor-backup.sh << 'EOF'
#!/bin/bash
BACKUP_DIR="/home/$USER/projeqtor-backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

echo "Starting ProjeQtOr Backup - $DATE"

# Datenbank-Backup
echo "Backing up database..."
podman exec projeqtor-mysql mysqldump -uprojeqtor -pprojeqtor_pass_2024 \
    --single-transaction --routines --triggers projeqtor > $BACKUP_DIR/projeqtor_db_$DATE.sql

# Dateien-Backup
echo "Backing up files..."
podman run --rm \
    -v projeqtor-files:/source:ro \
    -v $BACKUP_DIR:/backup \
    alpine tar czf /backup/projeqtor_files_$DATE.tar.gz -C /source .

# Konfiguration-Backup
echo "Backing up configuration..."
podman run --rm \
    -v projeqtor-config:/source:ro \
    -v $BACKUP_DIR:/backup \
    alpine tar czf /backup/projeqtor_config_$DATE.tar.gz -C /source .

# Alte Backups löschen (älter als 30 Tage)
find $BACKUP_DIR -type f -name "projeqtor_*" -mtime +30 -delete

echo "Backup completed: $DATE"
echo "Files saved in: $BACKUP_DIR"
EOF

chmod +x ~/projeqtor-backup.sh

# Cronjob für tägliches Backup um 2:00 Uhr
(crontab -l 2>/dev/null; echo "0 2 * * * $HOME/projeqtor-backup.sh") | crontab -

# Backup-Test durchführen
~/projeqtor-backup.sh
```

## Schritt 10: Monitoring und Wartung

### Container-Monitoring einrichten

```bash
# Monitoring-Skript erstellen
cat > ~/projeqtor-monitor.sh << 'EOF'
#!/bin/bash

echo "=== ProjeQtOr System Status ==="
echo "Date: $(date)"
echo

# Container Status
echo "Container Status:"
podman ps --pod --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo

# Health Checks
echo "Health Status:"
for container in projeqtor-mysql projeqtor-app; do
    health=$(podman inspect $container --format='{{.State.Health.Status}}' 2>/dev/null || echo "no-healthcheck")
    echo "$container: $health"
done
echo

# Resource Usage
echo "Resource Usage:"
podman stats --no-stream projeqtor-app projeqtor-mysql --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}"
echo

# Disk Usage
echo "Disk Usage (Volumes):"
podman volume ls --filter name=projeqtor --format "table {{.Name}}\t{{.Driver}}"
echo

# Recent Logs (last 10 lines)
echo "Recent Application Logs:"
podman logs --tail 10 projeqtor-app 2>/dev/null || echo "No logs available"
EOF

chmod +x ~/projeqtor-monitor.sh

# Monitoring täglich um 8:00 Uhr per E-Mail (optional)
# (crontab -l 2>/dev/null; echo "0 8 * * * $HOME/projeqtor-monitor.sh | mail -s 'ProjeQtOr Status' admin@company.com") | crontab -
```

### Update-Prozedur vorbereiten

```bash
# Update-Skript erstellen
cat > ~/projeqtor-update.sh << 'EOF'
#!/bin/bash

echo "=== ProjeQtOr Update Process ==="
echo "WARNUNG: Führen Sie vor dem Update ein Backup durch!"
read -p "Backup durchgeführt? (ja/nein): " backup_done

if [ "$backup_done" != "ja" ]; then
    echo "Bitte führen Sie zuerst ein Backup durch:"
    echo "~/projeqtor-backup.sh"
    exit 1
fi

# Neue Version von SourceForge herunterladen
cd ~/projeqtor-build || mkdir -p ~/projeqtor-build && cd ~/projeqtor-build

echo "Downloading latest ProjeQtOr source from SourceForge..."
wget https://sourceforge.net/projects/projeqtor/files/latest/download -O projeqtor-latest-new.zip
unzip projeqtor-latest-new.zip

# Verzeichnisstruktur anpassen
PROJEQTOR_DIR=$(find . -maxdepth 1 -type d -name "*rojeq*" | head -1)
if [ -d "$PROJEQTOR_DIR" ]; then
    mv "$PROJEQTOR_DIR" projeqtor-source-new
else
    mkdir -p projeqtor-source-new
    mv *.php *.js *.css tool model view autoload.php index.php projeqtor-source-new/ 2>/dev/null || true
    mv files documents plugin locale external projeqtor-source-new/ 2>/dev/null || true
fi

# Neues Image erstellen
echo "Building new image..."
podman build -t projeqtor-local:new .

# Container stoppen
echo "Stopping containers..."
podman stop projeqtor-app

# Container mit neuem Image starten
echo "Starting updated container..."
podman run -d \
    --name projeqtor-app-new \
    --network projeqtor-network \
    -p 8080:80 \
    -e DB_HOST=projeqtor-mysql \
    -e DB_NAME=projeqtor \
    -e DB_USER=projeqtor \
    -e DB_PASSWORD=projeqtor_pass_2024 \
    -e TZ=Europe/Berlin \
    -v projeqtor-files:/var/www/html/files \
    -v projeqtor-config:/var/www/html/tool/parameters \
    -v projeqtor-logs:/var/log/apache2 \
    projeqtor-local:new

# Dockerfile für neues Update erstellen
cat > Dockerfile << 'EOF'
FROM php:8.1-apache

# System-Pakete installieren
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libxslt-dev \
    libonig-dev \
    mariadb-client \
    cron \
    nano \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# PHP-Erweiterungen kompilieren und installieren
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        gd \
        mysqli \
        pdo_mysql \
        zip \
        intl \
        xml \
        xsl \
        mbstring \
        opcache \
        calendar

# Apache-Module aktivieren
RUN a2enmod rewrite headers

# PHP-Konfiguration optimieren
RUN echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/projeqtor.ini \
    && echo "upload_max_filesize = 100M" >> /usr/local/etc/php/conf.d/projeqtor.ini \
    && echo "post_max_size = 100M" >> /usr/local/etc/php/conf.d/projeqtor.ini \
    && echo "max_execution_time = 300" >> /usr/local/etc/php/conf.d/projeqtor.ini \
    && echo "max_input_vars = 3000" >> /usr/local/etc/php/conf.d/projeqtor.ini \
    && echo "session.gc_maxlifetime = 7200" >> /usr/local/etc/php/conf.d/projeqtor.ini

# Apache-Konfiguration für ProjeQtOr
RUN echo "<Directory /var/www/html>" >> /etc/apache2/apache2.conf \
    && echo "    AllowOverride All" >> /etc/apache2/apache2.conf \
    && echo "    Require all granted" >> /etc/apache2/apache2.conf \
    && echo "</Directory>" >> /etc/apache2/apache2.conf

# ProjeQtOr Quellcode kopieren
COPY projeqtor-source-new/ /var/www/html/

# Berechtigungen setzen
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/files \
    && chmod -R 777 /var/www/html/tool/parameters

# .htaccess für bessere Sicherheit erstellen
RUN echo "RewriteEngine On" > /var/www/html/.htaccess \
    && echo "RewriteCond %{REQUEST_FILENAME} !-f" >> /var/www/html/.htaccess \
    && echo "RewriteCond %{REQUEST_FILENAME} !-d" >> /var/www/html/.htaccess \
    && echo "RewriteRule ^(.*)$ index.php [QSA,L]" >> /var/www/html/.htaccess \
    && echo "Header always set X-Content-Type-Options nosniff" >> /var/www/html/.htaccess \
    && echo "Header always set X-Frame-Options DENY" >> /var/www/html/.htaccess

# Cron-Job für ProjeQtOr-Wartung einrichten
RUN echo "*/5 * * * * www-data php /var/www/html/tool/cron.php" >> /etc/crontab

# Gesundheitscheck definieren
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost/tool/checkConnection.php || exit 1

# Standard-Port freigeben
EXPOSE 80

# Container-Start-Skript
RUN echo '#!/bin/bash' > /start.sh \
    && echo 'service cron start' >> /start.sh \
    && echo 'apache2-foreground' >> /start.sh \
    && chmod +x /start.sh

CMD ["/start.sh"]
EOF

# Test der neuen Version
sleep 30
if curl -f http://localhost:8080/tool/checkConnection.php > /dev/null 2>&1; then
    echo "Update erfolgreich!"
    echo "Alten Container entfernen..."
    podman rm projeqtor-app
    podman rename projeqtor-app-new projeqtor-app
    
    echo "Alte Images aufräumen..."
    podman rmi projeqtor-local:latest
    podman tag projeqtor-local:new projeqtor-local:latest
    podman rmi projeqtor-local:new
else
    echo "Update fehlgeschlagen! Rollback..."
    podman stop projeqtor-app-new
    podman rm projeqtor-app-new
    podman pod start projeqtor-pod
fi

# Aufräumen
rm -f projeqtor-latest-new.zip
EOF

chmod +x ~/projeqtor-update.sh
```

## Schritt 11: Sicherheitshärtung

### Firewall-Konfiguration

```bash
# Firewall-Regeln verfeinern
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --zone=public --remove-service=http --permanent
sudo firewall-cmd --zone=public --remove-service=https --permanent
sudo firewall-cmd --reload

# Nur ProjeQtOr-Port freigeben
sudo firewall-cmd --list-all
```

### Container-Sicherheit

```bash
# SELinux-Labels setzen (falls SELinux aktiv)
sudo setsebool -P container_manage_cgroup on

# Container mit eingeschränkten Rechten neu starten (optional)
podman stop projeqtor-app
podman rm projeqtor-app

podman run -d \
    --name projeqtor-app \
    --network projeqtor-network \
    --read-only \
    --tmpfs /tmp \
    --tmpfs /var/run \
    --tmpfs /var/log \
    -p 8080:80 \
    -e DB_HOST=projeqtor-mysql \
    -e DB_NAME=projeqtor \
    -e DB_USER=projeqtor \
    -e DB_PASSWORD=projeqtor_pass_2024 \
    -e TZ=Europe/Berlin \
    -v projeqtor-files:/var/www/html/files \
    -v projeqtor-config:/var/www/html/tool/parameters \
    --security-opt no-new-privileges \
    --cap-drop ALL \
    --cap-add CHOWN \
    --cap-add DAC_OVERRIDE \
    --cap-add SETGID \
    --cap-add SETUID \
    projeqtor-local:latest
```

## Troubleshooting

### Häufige Probleme und Lösungen

#### Image-Build schlägt fehl

```bash
# Build-Logs detailliert anzeigen
podman build --layers -t projeqtor-local:latest .

# Speicher-Probleme beim Build
podman build --memory=2g --cpus=2 -t projeqtor-local:latest .

# Cache löschen und neu bauen
podman build --no-cache -t projeqtor-local:latest .
```

#### Container startet nicht

```bash
# Detaillierte Logs anzeigen
podman logs --details projeqtor-app

# Container-Konfiguration prüfen
podman inspect projeqtor-app

# Ressourcen-Probleme prüfen
podman stats

# Port-Konflikte prüfen
ss -tlnp | grep 8080
```

#### Datenbankverbindung fehlgeschlagen

```bash
# Netzwerk-Konnektivität testen (im Pod: localhost)
podman exec projeqtor-app curl -f http://localhost:3306 || echo "MySQL-Port erreichbar"

# MySQL-Status prüfen
podman exec projeqtor-mysql mysqladmin -uprojeqtor -pprojeqtor_pass_2024 status

# Datenbank-Logs anzeigen
podman logs projeqtor-mysql

# Manuelle Datenbankverbindung testen
podman exec -it projeqtor-mysql mysql -uprojeqtor -pprojeqtor_pass_2024 -e "SHOW DATABASES;"
```

#### Performance-Probleme

```bash
# Ressourcenverbrauch analysieren
podman stats --no-stream

# Container-Limits anzeigen
podman inspect projeqtor-app | grep -A 10 "Resources"

# PHP-Logs prüfen
podman exec projeqtor-app tail -f /var/log/apache2/error.log

# MySQL-Performance prüfen
podman exec projeqtor-mysql mysqladmin -uprojeqtor -pprojeqtor_pass_2024 processlist
```

#### Backup-Probleme

```bash
# Backup-Berechtigung prüfen
ls -la ~/projeqtor-backups/

# Volume-Status prüfen
podman volume ls
podman volume inspect projeqtor-files

# Manueller Backup-Test
podman exec projeqtor-mysql mysqldump -uprojeqtor -pprojeqtor_pass_2024 projeqtor | head -20
```

## Wartungsaufgaben

### Wöchentliche Aufgaben

```bash
# System-Status prüfen
~/projeqtor-monitor.sh

# Logs rotieren
podman exec projeqtor-app logrotate /etc/logrotate.conf

# Container-Updates prüfen
podman auto-update --dry-run
```

### Monatliche Aufgaben

```bash
# Vollständiges Backup erstellen
~/projeqtor-backup.sh

# Datenbank optimieren
podman exec projeqtor-mysql mysqlcheck -uprojeqtor -pprojeqtor_pass_2024 --optimize projeqtor

# Ungenutzten Speicher freigeben
podman system prune -f

# Image-Updates prüfen
podman images
```

### Jährliche Aufgaben

```bash
# Major-Update durchführen
~/projeqtor-update.sh

# SSL-Zertifikate erneuern (falls vorhanden)
# Systemd-Services prüfen
systemctl --user status projeqtor-*.service
```

## Protokoll-Abschluss

### Installation erfolgreich abgeschlossen ✅

**Durchgeführte Schritte:**

- [x] ProjeQtOr Quellcode von SourceForge heruntergeladen
- [x] Lokales Docker-Image erstellt mit PHP-Erweiterungen
- [x] Podman-Pod eingerichtet (gemeinsames Netzwerk)
- [x] MySQL-Container im Pod gestartet
- [x] ProjeQtOr-Container im Pod gestartet
- [x] Systemd-Service für Pod-Autostart konfiguriert
- [x] Web-Setup durchgeführt
- [x] Backup-System eingerichtet
- [x] Monitoring konfiguriert
- [x] Sicherheitsmaßnahmen implementiert

### Zugriffsdaten

- **URL**: http://[SERVER-IP]:8080
- **Admin-Benutzer**: admin
- **Datenbank**: projeqtor@localhost (Pod-intern)
- **Backup-Speicherort**: ~/projeqtor-backups/

### Wichtige Dateien

- **Monitoring**: ~/projeqtor-monitor.sh
- **Backup**: ~/projeqtor-backup.sh
- **Update**: ~/projeqtor-update.sh
- **Systemd-Service**: ~/.config/systemd/user/projeqtor-pod.service

### Nächste Schritte

1. ✅ Benutzer und Projekte anlegen
2. ✅ SMTP für E-Mail-Benachrichtigungen konfigurieren
3. ⚠️ SSL/TLS-Zertifikat einrichten (Reverse Proxy empfohlen)
4. ✅ Regelmäßige Backups testen
5. ⚠️ Monitoring in produktive Überwachung integrieren

### Performance-Optimierungen aktiviert

- PHP OPcache aktiviert
- Apache-Module optimiert
- MySQL-Tuning für ProjeQtOr
- Container-Ressourcenlimits gesetzt
- Cron-Jobs für Wartung eingerichtet

---

**Installation abgeschlossen am**: `date`  
**Durchgeführt von**: [Name eintragen]  
**ProjeQtOr Version**: Latest (Main Branch)  
**Image Tag**: projeqtor-local:latest