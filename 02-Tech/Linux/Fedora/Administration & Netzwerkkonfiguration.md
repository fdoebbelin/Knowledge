---
tags:
  - ubuntu-server
  - cockpit
  - netplan
  - systemd
  - admin
---

## 1. Web-Administration mit Cockpit

**Cockpit** ist die moderne, offizielle Weboberfläche zur grafischen Verwaltung von Ubuntu Server (Ressourcen, Benutzer, Logs, Terminal).

### Installation & Aktivierung

```
# Installation über die Paketquellen
sudo apt update && sudo apt install cockpit -y

# Socket-Aktivierung starten und für Systemstart aktivieren
sudo systemctl enable --now cockpit.socket
```

### Status prüfen

```
sudo systemctl status cockpit.socket
```

> [!warning] Port-Konflikt beheben (`Address already in use`)
> 
> Wenn Cockpit nicht startet, weil Port `9090` belegt ist, ermittle den blockierenden Dienst:
> 
> ```
> sudo ss -tulpn | grep 9090
> ```
> 
> Weiche bei Bedarf auf einen anderen Port (z. B. `9095`) aus, indem du eine systemd-Override-Datei schreibst:
> 
> ```
> # 1. Override-Verzeichnis erstellen
> sudo mkdir -p /etc/systemd/system/cockpit.socket.d/
> 
> # 2. Neuen Port direkt in Konfiguration schreiben
> sudo tee /etc/systemd/system/cockpit.socket.d/override.conf <<EOF
> [Socket]
> ListenStream=
> ListenStream=9095
> EOF
> 
> # 3. Systemd neu laden und neu starten
> sudo systemctl daemon-reload
> sudo systemctl restart cockpit.socket
> ```

### Firewall anpassen

```
# Port freigeben (hier am Beispiel des ausgewichenen Ports 9095)
sudo ufw allow 9095/tcp
```

Aufruf im Browser über: `https://[SERVER-IP]:9095` (Zertifikatswarnung im Browser ignorieren).

## 2. Standard-Editor auf `vi` umstellen

Standardmäßig nutzt Ubuntu `nano`. Um `vi` (oder `vim`) systemweit oder benutzerspezifisch zu erzwingen, gibt es folgende Wege:

### Methode A: Einmalig erzwingen

```
sudo SYSTEMD_EDITOR=vi systemctl edit cockpit.socket
```

### Methode B: Systemweiter Standard (`update-alternatives`)

```
sudo update-alternatives --config editor
```

_Wähle die Nummer für `/usr/bin/vim.basic` oder `/usr/bin/nvi`._

### Methode C: Benutzerdefiniert in der `.bashrc`

Füge am Ende deiner `~/.bashrc` hinzu:

```
export EDITOR=vi
```

> [!tip] Sudo und Umgebungsvariablen
> 
> Damit `sudo`-Befehle deine persönliche `EDITOR`-Variable nicht verwerfen, nutze beim Aufruf das Flag `-E` (Preserve Environment):
> 
> `sudo -E systemctl edit <dienst>`

## 3. Monitoring vs. Administration: Prometheus & Grafana

Oft wird **Prometheus** fälschlicherweise als Administrations-Tool verstanden. Es dient jedoch rein dem **Monitoring**.

- **Cockpit:** Bidirektional (Lesen & Schreiben). Erlaubt das Verwalten des Systems (Updates, Terminal, User-Management).
    
- **Prometheus (+ Grafana):** Unidirektional (Nur Lesen). Sammelt via _Node Exporter_ historische Leistungsdaten und bereitet sie in Grafana-Dashboards grafisch auf. Keine Systemänderungen möglich.
    

## 4. Grafische Desktop-Oberfläche (GUI) verwalten

Auf einem Ubuntu Server sollte aus Performance-Gründen standardmäßig keine GUI laufen. Falls sie doch installiert wurde, lässt sie sich wie folgt steuern:

### Installation (Schlanke Variante)

```
sudo apt update
sudo apt install --no-install-recommends ubuntu-desktop -y
```

### Steuerung des Displaymanagers (gdm3)

```
# GUI starten
sudo systemctl start gdm3

# GUI beenden (Ressourcen freigeben)
sudo systemctl stop gdm3
```

### Bootverhalten steuern (Grafisch vs. Konsole)

```
# Standardmäßig in die grafische Oberfläche booten
sudo systemctl set-default graphical.target

# Standardmäßig in die reine Textkonsole booten (Empfohlen für Server!)
sudo systemctl set-default multi-user.target
```

> [!tip] In der GUI "gefangen"? (TTY-Wechsel)
> 
> Falls die GUI aktiv ist und du kein Terminal öffnen kannst, wechsle am physischen Server auf eine virtuelle Textkonsole:
> 
> 1. Drücke **`Strg` + `Alt` + `F3`** (oder F4, F5).
>     
> 2. Melde dich im Textmodus an.
>     
> 3. Beende die GUI mit `sudo systemctl stop gdm3`.
>     

## 5. Statische IP-Adresse konfigurieren (Netplan)

Um zu verhindern, dass der DHCP-Server die IP-Adresse des Servers ändert, wird eine feste IP-Konfiguration in Netplan hinterlegt.

### Konfiguration für Schnittstelle `enp3s0f0`

1. Öffne die zuständige YAML-Datei im Netplan-Ordner:
    
    ```
    sudo vi /etc/netplan/01-netcfg.yaml
    ```
    
2. Ersetze den Inhalt vollständig durch folgende Struktur:
    
    ```
    network:
      version: 2
      renderer: networkd
      ethernets:
        enp3s0f0:
          dhcp4: no
          addresses:
            - 10.10.105.15/24
          routes:
            - to: default
              via: 10.10.105.1
          nameservers:
            addresses:
              - 10.10.105.1
              - 1.1.1.1
    ```
    

> [!danger] YAML Formatierungsregel
> 
> YAML-Dateien erlauben **keine Tabulatoren**. Nutze zur Einrückung ausschließlich **Leerzeichen** (am besten im 2er-Schritt), da Netplan die Konfiguration sonst ablehnt.

### Konfiguration testen & anwenden

Verwende immer zuerst den Test-Befehl, um dich nicht dauerhaft auszusperren. Bestätigst du nicht innerhalb von 120 Sekunden, wird die Änderung automatisch rückgängig gemacht:

```
sudo netplan try
```

Wenn die Verbindung stabil bleibt, drücke `Enter`. Alternativ wende es direkt an:

```
sudo netplan apply
```