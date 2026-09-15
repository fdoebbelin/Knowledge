## PowerShell

Falls du das Konto per **PowerShell** zum Admin machen willst:

```powershell
$User = "Benutzername"
Add-LocalGroupMember -Group "Administrators" -Member $User
```

💡 **Erklärung:**

- Ersetze `"Benutzername"` mit dem Namen des lokalen Benutzerkontos.
- `"Administrators"` ist die Standardgruppe für Admins unter Windows.

### **Prüfen, ob der Benutzer Admin-Rechte hat**

```powershell
Get-LocalGroupMember -Group "Administrators"
```

---

## **3. Über die Eingabeaufforderung (CMD)**

Falls du lieber die **Eingabeaufforderung (CMD) als Administrator** nutzt:

```cmd
net localgroup Administrators "Benutzername" /add
```

➡ Dadurch wird das **lokale Konto** zur Administratorgruppe hinzugefügt.

Falls du dem Benutzer die Adminrechte **wieder entziehen** möchtest:

```cmd
net localgroup Administrators "Benutzername" /delete
```

### **🛑 Wichtige Hinweise**

- **Ein Administrator-Konto kann alle Systemänderungen vornehmen** (Vorsicht bei Sicherheitsrisiken!).
- Falls du ein Konto **erstellen & direkt als Admin setzen** möchtest:
    
```powershell
New-LocalUser -Name "NeuerBenutzer" -Password (ConvertTo-SecureString "DeinPasswort" -AsPlainText -Force) -FullName "Max Mustermann" -Description "Admin-Konto"
Add-LocalGroupMember -Group "Administrators" -Member "NeuerBenutzer"
```
    
- Falls du keinen Zugriff hast, musst du dich als **Administrator** anmelden.