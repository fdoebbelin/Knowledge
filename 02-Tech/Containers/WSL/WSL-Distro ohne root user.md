Unter WSL (Windows Subsystem for Linux) wird standardmäßig ein Benutzerkonto eingerichtet, das bei der ersten Installation mit root-Rechten versehen ist. Es gibt allerdings keine direkte Möglichkeit, die Einrichtung des Root-Benutzers vollständig zu umgehen, da root für die Systemadministration notwendig ist. Du kannst jedoch sicherstellen, dass nach der Installation kein direkter Root-Zugang verwendet wird, indem du folgende Schritte ausführst:

### 1. **Benutzer ohne Root-Rechte standardmäßig nutzen**

Nach der Installation kannst du den Standardbenutzer ändern, sodass `root` nicht automatisch verwendet wird:

```bash
wsl -d Ubuntu-24.04 --user <dein-benutzername>
```

Oder setze einen Standardbenutzer global:

```bash
wsl -d Ubuntu-24.04
sudo nano /etc/wsl.conf
```

Füge folgendes hinzu:

```ini
[user]
default=<dein-benutzername>
```

Speichere die Datei und starte WSL neu:

```bash
wsl --shutdown
```

### 2. **Root-Zugang einschränken**

Du kannst das Root-Passwort setzen und den direkten Root-Zugang einschränken:

```bash
sudo passwd root
```

Zusätzlich könntest du in der `/etc/ssh/sshd_config` (falls SSH verwendet wird) den Root-Zugang deaktivieren:

```ini
PermitRootLogin no
```

Danach den SSH-Dienst neu starten:

```bash
sudo service ssh restart
```

### 3. **Nutzer bei Installation überspringen**

Aktuell erfordert jede WSL-Distro eine erste Benutzerinitialisierung. Falls du jedoch ein vorkonfiguriertes Image erstellen möchtest, könntest du ein benutzerdefiniertes WSL-Tarball mit deinem eigenen Benutzer importieren:

1. Exportiere eine existierende Installation:
    
    ```bash
    wsl --export Ubuntu-24.04 ubuntu24.04.tar
    ```
    
2. Importiere sie erneut:
    
    ```bash
    wsl --import Ubuntu-24.04 <pfad> ubuntu24.04.tar --version 2
    ```
    

Das neue Image verwendet dann nur den konfigurierten Benutzer.