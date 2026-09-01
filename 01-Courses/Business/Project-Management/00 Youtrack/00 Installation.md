## Docker auf Ubuntu 24.04 installieren

1. **System aktualisieren:**

```bash
sudo apt update
sudo apt upgrade -y
```

Dies stellt sicher, dass alle Paketquellen und Systempakete aktuell sind.[^4][^7][^1]
2. **Abhängigkeiten installieren:**

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
```

Damit werden grundlegende Tools für die Installation vorbereitet.[^8][^1]
3. **GPG-Schlüssel von Docker hinzufügen:**

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc
```

4. **Docker-Repository hinzufügen:**

```nushell
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu noble stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

5. **Pakete aktualisieren und Docker installieren:**

```bash
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y
```

Damit wird die aktuelle Community Edition von Docker installiert.[^9][^1][^4]
6. **Docker-Dienst aktivieren und starten:**

```bash
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
```

Der letzte Befehl prüft, ob Docker läuft.[^9][^4]
7. **Eigenen Nutzer zur Docker-Gruppe hinzufügen (optional):**

```nushell
sudo usermod -aG docker $"($env.USER)"
su - $"($env.USER)"
```

Das ermöglicht die Verwendung von Docker ohne `sudo`.[^7][^4]
Die **sicherste Variante**: Terminal abmelden und wieder anmelden – oder das System neu starten.
## YouTrack Server mit Docker installieren

### 1. Verzeichnis für YouTrack-Daten vorbereiten
Empfehlenswert ist ein eigener Pfad für die YouTrack-Daten:

```bash
sudo mkdir -p /opt/youtrack/data /opt/youtrack/conf /opt/youtrack/logs /opt/youtrack/backups
sudo chown -R $"($env.USER):($env.USER)" /opt/youtrack
```

### 2. YouTrack-Container starten:

```nu
# Image laden
docker pull jetbrains/youtrack:2025.2.107084

# Container starten
{
	docker run -d --name youtrack
    -v /opt/youtrack/data:/var/youtrack/data
    -v /opt/youtrack/conf:/var/youtrack/conf
    -v /opt/youtrack/logs:/var/youtrack/logs
    -v /opt/youtrack/backups:/var/youtrack/backups
    -p 8080:8080
    jetbrains/youtrack:2025.2.107084
}

# Start eines vorhandenen Containers
docker start youtrack
```

Dieses Kommando startet den Container mit lokalen Verzeichnissen für persistente Daten und bindet den Webserver auf Port 8080.
### 3. YouTrack im Browser einrichten
Öffne im Browser:

```
JetBrains YouTrack 2025.2 Configuration Wizard will listen inside container on {0.0.0.0:8080}/ after start and can be accessed by URL
http://0.0.0.0:8080//?wizard_token=UQsBi0S1KJExB3O4Sr20
```

Die Erstkonfiguration geschieht über einen grafischen Wizard.[^2]

## Tipps für die Verwendung mit Nushell

- Du kannst die oben genannten Docker-Befehle direkt aus Nushell heraus ausführen.
- Skripte und Befehle, die als `.nu`-Dateien vorliegen, lassen sich bequem via Nushell steuern – auch im Docker-Betrieb.

Hiermit steht einem schnellen YouTrack-Einsatz auf Ubuntu 24.04 mit Docker nichts mehr im Weg und du kannst Befehle wahlweise mit Nushell ausführen! Alle relevanten Schritte sind direkt aus den offiziellen Quellen und aktuellen Linux-Praktiken zusammengestellt.