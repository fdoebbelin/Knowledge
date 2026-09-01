### **`Set-WinUILanguageOverride -Language uk-UA` genau erklärt**

Der Befehl **`Set-WinUILanguageOverride`** ändert die Spracheinstellung für **alle UWP-Apps**, die sich auf die Windows UI-Sprache verlassen. Das betrifft nicht nur Microsoft Teams, sondern auch andere Windows-Apps.

---

### **🔹 1. Befehl ausführen**

Öffne **PowerShell als Administrator** (`Win + X` → **PowerShell (Admin)**) und gib ein:

```powershell
Set-WinUILanguageOverride -Language uk-UA
```

🔹 **Was passiert danach?**

- Windows und einige Apps (darunter UWP-Apps wie Microsoft Teams) verwenden **Ukrainisch** (`uk-UA`) als Sprache.
- **Erfordert Abmelden und erneutes Anmelden**.
- Falls das nicht sofort wirkt: Ein Neustart ist nötig.

---

### **🔹 2. Aktuelle Override-Sprache prüfen**

Falls du wissen willst, welche UI-Sprache aktuell erzwungen wird, nutze:

```powershell
Get-WinUILanguageOverride
```

- Falls **keine Sprache gesetzt ist**, nutzt Windows die Standardsprache des Systems.

---

### **🔹 3. Override zurücksetzen (Spracheinstellung von Windows übernehmen)**

Falls du das Sprach-Override wieder entfernen willst:

```powershell
Set-WinUILanguageOverride
```

Dadurch wird die Spracheinstellung auf die **Windows-Anzeigesprache zurückgesetzt**.

---

## **🔹 4. Verbindung mit Microsoft Teams**

Da **Microsoft Teams (UWP)** keine eigene Sprachoption mehr hat, könnte es durch diesen Befehl auf **Ukrainisch** wechseln, wenn es sich an die Windows-Sprache hält.

Falls Teams nicht sofort umschaltet:

1. **Abmelden & wieder anmelden**.
2. Falls das nicht reicht: **PC neustarten**.
3. Falls Teams **weiterhin auf Deutsch bleibt**, versuche einen **Cache-Reset** für Teams:

```powershell
Remove-Item -Path "$env:LOCALAPPDATA\Packages\MicrosoftTeams_*" -Recurse -Force
```

Danach **Teams erneut starten**.

---

## **🔹 5. Verbindung mit dem Teams-Paketnamen**

Falls du Microsoft Teams mit einer bestimmten Sprache starten möchtest und den Paketnamen kennst, kannst du diesen direkt aus PowerShell starten:

1. **Ermittle den vollständigen Paketnamen von Teams**:
    
    ```powershell
    Get-AppxPackage *Teams* | Select Name, PackageFullName
    ```
    
2. **Starte Teams mit expliziter Spracheinstellung (falls unterstützt):**
    
    ```powershell
    Start-Process "shell:AppsFolder\MicrosoftTeams_8wekyb3d8bbwe!Teams" -ArgumentList "--lang=uk-UA"
    ```
    

❗ **Wichtig:** Falls Teams diesen Parameter (`--lang=uk-UA`) nicht unterstützt, bleibt nur der **`Set-WinUILanguageOverride`**-Befehl oder eine **Änderung der gesamten Windows-Sprache**.

---

### **🛠 Fazit**

✅ **`Set-WinUILanguageOverride -Language uk-UA`** setzt die UI-Sprache für alle UWP-Apps auf Ukrainisch.  
✅ Falls Teams darauf reagiert, reicht ein **Neustart** oder **Abmelden & Anmelden**.  
✅ Falls Teams weiter auf Deutsch bleibt: **Cache löschen & Teams erneut starten**.  
✅ Falls du Admin bist, könnte eine **Gruppenrichtlinie (GPO)** für die Sprache nötig sein.

Lass mich wissen, ob es funktioniert oder ob du weitere Hilfe brauchst! 😊