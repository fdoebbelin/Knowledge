
```bash
#!/bin/bash  
set -e  
export PODMAN_SILENCE_WARNINGS=1  
echo "=== ProjeQtOr Installation für WSL2 ==="  
# CA-Zertifikate reparieren  
echo "Repariere CA-Zertifikate..."  
sudo apt update -q  
sudo apt install -y ca-certificates curl wget unzip  
sudo update-ca-certificates --fresh  
echo 'export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt' >> ~/.bashrc  
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt  
# DNS für WSL2 reparieren  
echo "Repariere DNS..."  
sudo tee /etc/resolv.conf > /dev/null << RESOLV  
nameserver 8.8.8.8  
nameserver 8.8.4.4  
nameserver 1.1.1.1  
RESOLV  
# Podman installieren  
echo "Installiere Podman..."  
sudo apt install -y podman  
mkdir -p ~/.config/containers  
# Registry-Konfiguration  
echo "Konfiguriere Container-Registry..."  
tee ~/.config/containers/registries.conf > /dev/null << REGISTRY  
unqualified-search-registries = ["docker.io", "quay.io"]  
[[registry]]  
location = "docker.io"  
insecure = false  
[[registry]]  
location = "quay.io"  
insecure = false  
REGISTRY  
# Podman-Konfiguration  
tee ~/.config/containers/containers.conf > /dev/null << CONTAINERS  
[containers]  
log_driver = "journald"  
[engine]  
cgroup_manager = "cgroupfs"  
events_logger = "journald"  
runtime = "crun"  
CONTAINERS  
# MariaDB starten  
echo "Starte MariaDB..."  
podman run -d --name projeqtor-db \  
  -e MYSQL_ROOT_PASSWORD=projeqtor123 \  
  -e MYSQL_DATABASE=projeqtor \  
  -e MYSQL_USER=projeqtor \  
  -e MYSQL_PASSWORD=projeqtor123 \  
  -p 3306:3306 \  
  mariadb:latest  
# Warte auf DB  
sleep 15  
# ProjeQtOr herunterladen  
echo "Lade ProjeQtOr herunter..."  
cd ~  
wget https://netcologne.dl.sourceforge.net/project/projectorria/projeqtorV12.1.2.zip?viasf=1 -O projeqtor.zip  
unzip projeqtor.zip  
# Apache/PHP Container starten  
echo "Starte Apache/PHP..."  
podman run -d --name projeqtor-web \  
  -p 8080:80 \  
  -v ~/projeqtor:/var/www/html:Z \  
  php:8.1-apache  
# PHP-Extensions installieren  
echo "Installiere PHP-Extensions (inkl. IMAP)..."  
podman exec projeqtor-web bash -c "  
apt update -q && apt install -y \  
  libpng-dev libjpeg-dev libfreetype6-dev \  
  libzip-dev libicu-dev libonig-dev \  
  libc-client-dev libkrb5-dev && \  
docker-php-ext-configure gd --with-freetype --with-jpeg && \  
docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \  
docker-php-ext-install gd mysqli pdo_mysql zip intl mbstring imap  
"  
# PHP für ProjeQtOr konfigurieren  
echo "Konfiguriere PHP..."  
podman exec projeqtor-web bash -c "  
# PHP-Konfiguration für ProjeQtOr optimieren  
cat >> /usr/local/etc/php/php.ini << PHPINI  
; ProjeQtOr optimierte Einstellungen  
max_input_vars = 4000  
memory_limit = 512M  
upload_max_filesize = 50M  
post_max_size = 50M  
max_execution_time = 300  
max_input_time = 300  
date.timezone = Europe/Berlin  
PHPINI  
"  
# Apache-Konfiguration (ohne service restart)  
echo "Konfiguriere Apache..."  
podman exec projeqtor-web bash -c "  
echo 'ServerName localhost' >> /etc/apache2/apache2.conf &&  
a2enmod rewrite  
"  
# Container neu starten für Apache-Konfiguration  
echo "Starte Apache-Container neu..."  
podman restart projeqtor-web  
# Berechtigungen setzen  
sleep 5  
podman exec projeqtor-web chown -R www-data:www-data /var/www/html  
echo ""  
echo "=== Installation abgeschlossen ==="  
echo "ProjeQtOr ist verfügbar unter: http://localhost:8080"
```
