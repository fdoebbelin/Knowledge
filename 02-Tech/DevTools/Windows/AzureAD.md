**AzureAD (Azure Active Directory)** ist Microsofts cloudbasierter Identitäts- und Zugriffsverwaltungsdienst. Er dient als cloudbasierte Alternative (oder Ergänzung) zum klassischen lokalen **Active Directory (AD)** und wird für die Authentifizierung und Verwaltung von Benutzern, Gruppen und Anwendungen in **Microsoft 365 (früher Office 365), Azure und anderen Cloud-Diensten** verwendet.

---

## **1. Was macht Azure AD?**

AzureAD ermöglicht: ✅ **Single Sign-On (SSO)** → Einmal anmelden und auf alle Dienste (z. B. Microsoft 365, SharePoint, Teams) zugreifen  
✅ **Identitätsverwaltung** → Benutzer, Gruppen und Rollen in der Cloud verwalten  
✅ **Multifaktor-Authentifizierung (MFA)** → Sicherheitsmechanismen wie 2FA hinzufügen  
✅ **Geräteverwaltung** → Windows, macOS, iOS, Android in Azure AD registrieren oder beitreten  
✅ **Integration mit On-Premises AD** → Hybride Authentifizierung mit lokalem Active Directory  
✅ **Berechtigungssteuerung (RBAC)** → Zugriffsrechte für Ressourcen und Anwendungen verwalten

---

## **2. Unterschiede zwischen AzureAD und lokalem Active Directory**

|**Funktion**|**Active Directory (AD)**|**Azure Active Directory (AzureAD)**|
|---|---|---|
|**Standort**|Lokal (On-Premises)|Cloudbasiert|
|**Authentifizierung**|Kerberos, NTLM|OAuth 2.0, OpenID Connect, SAML|
|**SSO**|Ja, mit Domänenbeitritt|Ja, über Microsoft-Konten|
|**Geräteverwaltung**|GPO (Gruppenrichtlinien)|Intune (MDM für Geräte)|
|**Benutzerverwaltung**|AD-Benutzer & -Gruppen|Cloudbasierte Benutzerverwaltung|
|**Hybride Integration**|Mit **Azure AD Connect** möglich|Unterstützt lokale AD-Integration|

---

## **3. Wichtige AzureAD PowerShell-Befehle**

Falls du **Azure AD über PowerShell verwalten** möchtest, installiere zuerst das Modul:

```powershell
Install-Module AzureAD
Import-Module AzureAD
Connect-AzureAD
```

Dann kannst du z. B.:

- **Benutzer abrufen**:
    
    ```powershell
    Get-AzureADUser -ObjectId user@domain.com
    ```
    
- **Benutzer einer Gruppe hinzufügen**:
    
    ```powershell
    Add-AzureADGroupMember -ObjectId <GroupID> -RefObjectId <UserID>
    ```
    
- **Benutzer aus einer Gruppe entfernen**:
    
    ```powershell
    Remove-AzureADGroupMember -ObjectId <GroupID> -MemberId <UserID>
    ```
    

---

## **4. Wo wird AzureAD genutzt?**

- **Unternehmen mit Microsoft 365** nutzen AzureAD für Identitätsmanagement.
- **Cloud-Anwendungen** nutzen AzureAD für Authentifizierung via OAuth oder SAML.
- **Hybride Umgebungen** verbinden lokales AD mit AzureAD für zentrale Verwaltung.

---

## **5. Welche AzureAD-Versionen gibt es?**

|**Version**|**Funktionen**|
|---|---|
|**Azure AD Free**|Basisfunktionen, SSO für Microsoft 365|
|**Azure AD P1**|Conditional Access, hybride Identitäten|
|**Azure AD P2**|Identitätsschutz, risikobasierte Authentifizierung|

---

### **Fazit**

- **AzureAD ist die cloudbasierte Identitätslösung von Microsoft.**
- **Es ersetzt kein klassisches Active Directory, kann aber mit ihm kombiniert werden.**
- **Unternehmen nutzen es für sichere Authentifizierung in der Cloud.**

Hast du eine spezifische Frage zu AzureAD, z. B. Migration, Verwaltung oder SSO? 😊