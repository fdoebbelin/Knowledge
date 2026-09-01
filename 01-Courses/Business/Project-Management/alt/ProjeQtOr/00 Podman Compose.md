
```YAML
version: '3.8'

services:
  # MySQL/MariaDB Datenbank Service
  projeqtor-mysql:
    image: docker.io/library/mariadb:10.11
    container_name: projeqtor-mysql
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: "ProjeQtOr_Root_2024!"
      MYSQL_DATABASE: "projeqtor"
      MYSQL_USER: "projeqtor"
      MYSQL_PASSWORD: "ProjeQtOr_User_2024!"
      MYSQL_CHARSET: "utf8mb4"
      MYSQL_COLLATION: "utf8mb4_unicode_ci"
    volumes:
      - projeqtor-mysql-data:/var/lib/mysql
      - ./mysql-config:/etc/mysql/conf.d:ro
    ports:
      - "3306:3306"
    networks:
      - projeqtor-network
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-u", "projeqtor", "-pProjeQtOr_User_2024!"]
      start_period: 30s
      interval: 10s
      timeout: 5s
      retries: 3
    command: >
      --character-set-server=utf8mb4
      --collation-server=utf8mb4_unicode_ci
      --innodb-buffer-pool-size=256M
      --max-connections=100
      --query-cache-size=32M
      --query-cache-type=1

  # ProjeQtOr Anwendung Service
  projeqtor-app:
    image: localhost/projeqtor:latest
    container_name: projeqtor-app
    restart: unless-stopped
    environment:
      DB_HOST: "projeqtor-mysql"
      DB_NAME: "projeqtor"
      DB_USER: "projeqtor"
      DB_PASSWORD: "ProjeQtOr_User_2024!"
      DB_PORT: "3306"
      APACHE_DOCUMENT_ROOT: "/var/www/html"
      TZ: "Europe/Berlin"
    volumes:
      - projeqtor-files:/var/www/html/files
      - projeqtor-config:/var/www/html/tool/parameters
      - projeqtor-attachments:/var/www/html/attachments
      - projeqtor-logs:/var/log/apache2
    ports:
      - "8080:80"
    networks:
      - projeqtor-network
    depends_on:
      projeqtor-mysql:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/", "-H", "Host: localhost"]
      start_period: 60s
      interval: 30s
      timeout: 10s
      retries: 3
    labels:
      - "traefik.enable=false"
      - "org.opencontainers.image.title=ProjeQtOr Application"
      - "org.opencontainers.image.description=ProjeQtOr Project Management"

# Persistente Volumes für Daten
volumes:
  projeqtor-mysql-data:
    driver: local
    name: projeqtor-mysql-data
    
  projeqtor-files:
    driver: local
    name: projeqtor-files
    
  projeqtor-config:
    driver: local
    name: projeqtor-config
    
  projeqtor-attachments:
    driver: local
    name: projeqtor-attachments
    
  projeqtor-logs:
    driver: local
    name: projeqtor-logs

# Netzwerk für Container-Kommunikation
networks:
  projeqtor-network:
    driver: bridge
    name: projeqtor-network
```
