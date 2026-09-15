Um eine **RDP-Verbindung** sowohl **lokal** als auch **remote** zu testen, solltest du folgende Schritte ausführen:

---

## **1. Lokale RDP-Verbindung testen (gleicher PC)**

Falls du RDP erst einmal ohne Netzwerk testen möchtest, kannst du eine **lokale Verbindung** auf demselben Computer ausprobieren.

### **Windows (lokal)**

1. **RDP-Loopback testen**:
    
    - Drücke `Win + R`, gib `mstsc` ein und klicke auf **OK**.
    - Gib als Computer-Adresse **127.0.0.1** oder **localhost** ein.
    - Falls du eine Fehlermeldung bekommst, bedeutet das, dass der RDP-Server nicht richtig aktiviert ist.
2. Falls **127.0.0.1 nicht funktioniert**, versuche es mit:
    
    ```powershell
    netstat -an | findstr "3389"
    ```
    
    Falls **keine** Ausgabe erscheint, läuft der RDP-Server nicht.
    

### **Manjaro (lokal)**

Falls du `xrdp` installiert hast, teste die Verbindung mit:

```bash
xfreerdp /v:localhost /u:DEIN_BENUTZERNAME
```

Falls die Verbindung nicht klappt, überprüfe mit:

```bash
sudo systemctl status xrdp
```

Falls der Service nicht läuft, starte ihn:

```bash
sudo systemctl restart xrdp
```

---

## **2. RDP im lokalen Netzwerk testen**

Um eine Verbindung im **internen Netzwerk (LAN)** zu testen:

### **Windows → Manjaro (RDP-Client auf Windows, RDP-Server auf Manjaro)**

1. Finde die IP-Adresse von Manjaro mit:
    
    ```bash
    ip a | grep inet
    ```
    
    Beispiel einer IP-Adresse: `192.168.1.100`
    
2. Öffne auf Windows `mstsc.exe` (`Win + R`, dann `mstsc` eingeben).
    
3. Gib die IP-Adresse von Manjaro ein:
    
    ```
    192.168.1.100
    ```
    
    Falls es nicht funktioniert:
    
    - Prüfe, ob `xrdp` läuft:
        
        ```bash
        sudo systemctl status xrdp
        ```
        
    - Prüfe, ob die Firewall den Port 3389 freigibt:
        
        ```bash
        sudo ufw allow 3389/tcp
        ```
        

### **Manjaro → Windows (RDP-Client auf Manjaro, RDP-Server auf Windows)**

1. Finde die **IP-Adresse des Windows-PCs** mit:
    
    ```powershell
    ipconfig
    ```
    
    Beispiel-IP: `192.168.1.50`
    
2. Verbinde dich von Manjaro aus mit:
    
    ```bash
    xfreerdp /v:192.168.1.50 /u:DEIN_WINDOWS_BENUTZERNAME
    ```
    
    Falls es nicht funktioniert:
    
    - Stelle sicher, dass RDP auf Windows aktiviert ist.
    - Überprüfe, ob die Windows-Firewall RDP blockiert.
    - Teste `telnet 192.168.1.50 3389` auf Manjaro, um zu sehen, ob der Port offen ist.

---

## **3. RDP-Verbindung über das Internet testen (Remote-Zugriff)**

Falls du eine RDP-Verbindung von außerhalb deines Netzwerks testen möchtest, brauchst du:

1. **Die öffentliche IP-Adresse deines Netzwerks**
    
    - Finde deine **öffentliche IP-Adresse** mit:
        
        ```bash
        curl ifconfig.me
        ```
        
        Beispiel: `80.100.200.150`
2. **Port-Weiterleitung im Router**
    
    - Logge dich in deinen Router ein (`192.168.1.1` oder `192.168.0.1`).
    - Weiterleitung für **Port 3389 (TCP)** zur **lokalen IP-Adresse** des Zielgeräts einrichten.
3. **Firewall öffnen (falls notwendig)**
    
    - Windows:
        
        ```powershell
        netsh advfirewall firewall add rule name="RDP Internet" protocol=TCP dir=in localport=3389 action=allow
        ```
        
    - Manjaro:
        
        ```bash
        sudo ufw allow 3389/tcp
        ```
        
4. **Verbindung testen**
    
    - **Windows RDP-Client (`mstsc`)**:
        
        ```text
        80.100.200.150
        ```
        
    - **Manjaro RDP-Client (`xfreerdp`)**:
        
        ```bash
        xfreerdp /v:80.100.200.150 /u:DEIN_BENUTZERNAME
        ```
        

---

## **4. Fehlerbehebung**

Falls RDP nicht funktioniert, überprüfe:

### **Auf dem Zielsystem (Windows oder Manjaro)**

- Ist der RDP-Dienst aktiv?
    
    ```bash
    sudo systemctl status xrdp
    ```
    
- Ist die Firewall korrekt konfiguriert?
    
    ```bash
    sudo ufw status
    ```
    
- Ist der RDP-Port offen?
    
    ```bash
    netstat -an | grep 3389
    ```
    

### **Falls Remote-Zugriff nicht klappt**

- Prüfe, ob dein ISP Port 3389 blockiert. Manche Provider sperren diesen Port.
- Falls Port 3389 blockiert ist, kannst du RDP über **VPN oder SSH-Tunnel** nutzen.

Möchtest du eine **sichere Alternative** wie **RDP über SSH-Tunnel** oder **VPN** einrichten?