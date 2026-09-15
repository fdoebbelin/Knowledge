### 1. Installation von Scoop

#### Schritt 1: PowerShell als lokaler Benutzer öffnen

1. Öffne PowerShell, indem du `Windows + R` drückst, `powershell` eingibst und auf `OK` klickst.

#### Schritt 2: Ausführungsrichtlinie ändern

1. Führe den folgenden Befehl in PowerShell aus, um die Ausführungsrichtlinie temporär zu ändern, damit das Skript ausgeführt werden kann:

```powershell
    Set-ExecutionPolicy RemoteSigned -scope CurrentUse
```

#### Schritt 3: Scoop installieren

1. Führe den folgenden Befehl aus, um Scoop zu installieren:

```PowerShell
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

Dieser Befehl lädt das Installationsskript herunter und führt es aus.

### 2. Nutzung von Scoop

#### Grundlegende Befehle

1. **Paket installieren**:
    ```powershell
    scoop install <paketname>
    ```
    Beispiel:
    ```powershell
    scoop install git
    ```

2. **Paket deinstallieren**:
    ```powershell
    scoop uninstall <paketname>
    ```
    Beispiel:
    ```powershell
    scoop uninstall git
    ```

3. **Liste der installierten Pakete anzeigen**:
    ```powershell
    scoop list
    ```

4. **Pakete aktualisieren**:
    ```powershell
    scoop update
    ```
    Um ein bestimmtes Paket zu aktualisieren, benutze:
    ```powershell
    scoop update <paketname>
    ```

5. **Informationen zu einem Paket anzeigen**:
    ```powershell
    scoop info <paketname>
    ```
    Beispiel:
    ```powershell
    scoop info git
    ```

6. **Verfügbare Pakete durchsuchen**:
    ```powershell
    scoop search <paketname>
    ```
    Beispiel:
    ```powershell
    scoop search vscode
    ```

#### Zusätzliche Repositories hinzufügen

Scoop verwendet Buckets, die zusätzliche Softwarepakete enthalten. Der Haupt-Bucket ist `main`, es gibt jedoch viele andere Buckets, die du hinzufügen kannst.

1. **Bucket hinzufügen**:
    ```powershell
    scoop bucket add <bucketname>
    ```
    Beispiel:
    ```powershell
    scoop bucket add extras
    ```

2. **Bucket entfernen**:
    ```powershell
    scoop bucket rm <bucketname>
    ```

### 3. Fehlerbehebung

- **Fehlende Administratorrechte**:
    - Stelle sicher, dass du PowerShell ohne Administratorrechte öffnest.

- **Probleme bei der Installation von Scoop**:
    - Überprüfe, ob du die Ausführungsrichtlinie korrekt gesetzt hast.

- **Netzwerkprobleme**:
    - Stelle sicher, dass du eine funktionierende Internetverbindung hast, da Scoop Pakete aus dem Internet herunterlädt.

### Zusammenfassung

Mit diesen Schritten solltest du in der Lage sein, Scoop auf deinem Windows-System als lokaler Benutzer ohne Administratorrechte zu installieren und zu verwenden. Scoop erleichtert die Verwaltung von Softwarepaketen erheblich und bietet eine einfache Möglichkeit, Software zu installieren, zu aktualisieren und zu verwalten.