Unter Windows erfordert Docker normalerweise Administratorrechte, um Container auszuführen, da es auf der Virtualisierungstechnologie von Windows basiert. Es gibt jedoch einige Möglichkeiten, Docker als nicht privilegierter Benutzer zu nutzen:

---

## Den Benutzer zur "docker-users"-Gruppe hinzufügen

Docker für Windows erstellt eine Gruppe namens `docker-users`, die es erlaubt, Docker-Befehle ohne Administratorrechte auszuführen.

1. **Öffne die Eingabeaufforderung als Administrator** (Win + S → "cmd" → Rechtsklick → "Als Administrator ausführen").
2. Füge deinen Benutzer zur `docker-users`-Gruppe hinzu:
    
    ```powershell
    net localgroup docker-users DeinBenutzername /add
    ```
    
    Ersetze `DeinBenutzername` durch deinen tatsächlichen Windows-Benutzernamen.
3. **Melde dich ab und wieder an**, damit die Änderungen wirksam werden.
4. Prüfe, ob es funktioniert, indem du in einer normalen Eingabeaufforderung `docker version` eingibst.

In PowerShell kannst du den Namen des aktuell angemeldeten Benutzers mit folgenden Befehlen abrufen:

### **1. Mit `$env:USERNAME` (schnellster Weg)**

```powershell
$env:USERNAME
```

➡ Gibt nur den Benutzernamen zurück (z. B. `MaxMustermann`).

---

### **2. Mit `[System.Security.Principal.WindowsIdentity]::GetCurrent().Name`**

```powershell
[System.Security.Principal.WindowsIdentity]::GetCurrent().Name
```

➡ Gibt den vollständigen Benutzer inklusive Domäne zurück (z. B. `DOMAIN\MaxMustermann` oder `PC-NAME\MaxMustermann`).

---

### **3. Mit `whoami` (CMD-Befehl in PowerShell)**

```powershell
whoami
```

➡ Gibt ebenfalls `DOMAIN\Benutzername` zurück.

## Alle Gruppenmitgliedschaften des Benutzers abrufen
    
```powershell
whoami /groups
```

oder in PowerShell:

```powershell
([System.Security.Principal.WindowsIdentity]::GetCurrent()).Groups | ForEach-Object { $_.Translate([System.Security.Principal.NTAccount]).Value }
```
    