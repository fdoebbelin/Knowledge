In PowerShell kannst du einem Benutzer eine Gruppe mit dem folgenden Befehl entziehen:

### **1. Lokalen Benutzer aus einer lokalen Gruppe entfernen**

Falls du z. B. einen Benutzer aus der `docker-users`-Gruppe entfernen möchtest:

```powershell
Remove-LocalGroupMember -Group "docker-users" -Member "Benutzername"
```

➡ Ersetzt `"Benutzername"` durch den tatsächlichen Namen des Benutzers.

---

### **2. Domänenbenutzer aus einer lokalen Gruppe entfernen (Active Directory)**

Falls der Benutzer aus einer lokalen Gruppe entfernt werden soll, aber ein Domänenkonto ist:

```powershell
Remove-LocalGroupMember -Group "Administrators" -Member "DOMAIN\Benutzername"
```

➡ Ersetzt `"DOMAIN\Benutzername"` entsprechend.

---

### **3. Domänenbenutzer aus einer AD-Gruppe entfernen**

Falls du mit Active Directory arbeitest und den Benutzer aus einer AD-Gruppe entfernen willst:

```powershell
Remove-ADGroupMember -Identity "Gruppenname" -Members "Benutzername" -Confirm:$false
```

➡ Erfordert das Active Directory PowerShell-Modul.

---

### **4. Prüfen, ob der Benutzer entfernt wurde**

Nach der Entfernung kannst du überprüfen, ob der Benutzer nicht mehr in der Gruppe ist:

```powershell
Get-LocalGroupMember -Group "docker-users"
```

oder für eine AD-Gruppe:

```powershell
Get-ADGroupMember -Identity "Gruppenname"
```
