## **Befehl für AzureAD-Benutzer in die lokale Administratorengruppe hinzufügen**

```powershell
$UserPrincipal = "AzureAD\User@domain.com"
Add-LocalGroupMember -Group "Administrators" -Member $UserPrincipal
```

✅ **Erklärung:**

- **`AzureAD\User@domain.com`** → Ersetze mit der tatsächlichen E-Mail-Adresse des AzureAD-Benutzers.
- **`Administrators`** → Fügt den Benutzer zur lokalen Admin-Gruppe hinzu.

## **Prüfen, ob der Benutzer Admin-Rechte hat**

```powershell
Get-LocalGroupMember -Group "Administrators"
```

Falls der Benutzer **nicht angezeigt wird**, stelle sicher, dass:

- Der PC **mit AzureAD verknüpft** ist (`dsregcmd /status` prüfen).
- Der Benutzer **lokal angemeldet** war, bevor du ihn hinzufügst.

---

## **3. Über die Eingabeaufforderung (CMD)**

Falls du lieber die Eingabeaufforderung nutzt:

```cmd
net localgroup Administrators "AzureAD\User@domain.com" /add
```

💡 **Hinweis:** `"AzureAD\User@domain.com"` muss mit `AzureAD\` davor geschrieben werden.

---

## **4. Über Gruppenrichtlinien (für viele PCs in Unternehmen)**

Falls du administrative Rechte für mehrere Benutzer **zentral** verwalten möchtest:

6. Öffne **Gruppenrichtlinienverwaltung (gpedit.msc)**.
7. Gehe zu:
    
```
Computerkonfiguration → Windows-Einstellungen → Sicherheitseinstellungen → Lokale Richtlinien → Zuweisen von Benutzerrechten
```
    
8. Bearbeite die Richtlinie **"Mitgliedschaft in Administratorengruppe"** und füge den AzureAD-Benutzer hinzu.

---

### **🛑 Wichtige Hinweise**

- **Standardmäßig hat der erste AzureAD-Benutzer, der sich an einem Windows-Gerät anmeldet, Admin-Rechte**.
- **Weitere Benutzer**, die sich anmelden, haben **nur Standardrechte** und müssen manuell hinzugefügt werden.
- Falls du ein Unternehmen verwaltest, empfiehlt sich **Intune (Endpoint Manager)** zur Verwaltung von Admin-Rechten.