### **1. BIOS starten**

1. **Rechner neu starten**.
2. Während des Bootvorgangs drücken Sie die entsprechende Taste, um ins BIOS zu gelangen:
    - Meistens ist dies **Entf (Delete)**, **F2** oder **F10**. Die genaue Taste wird oft auf dem Bildschirm angezeigt (z. B. "Press DEL to enter BIOS").

---

### **2. Mainboard-Modell im BIOS anzeigen**

Sobald Sie im BIOS sind:

1. Suchen Sie auf der **Startseite** oder unter der **Systemübersicht** nach Informationen zum Mainboard.
2. Das Mainboard-Modell wird häufig unter folgenden Bezeichnungen angezeigt:
    - **Motherboard Model**
    - **Board Name**
    - **Product Name**
3. Auf ASUS ROG-Mainboards befindet sich diese Information oft in der rechten oberen Ecke oder im Abschnitt **"Main"**.

---

### **3. Alternative: ASUS UEFI BIOS (Erweiterter Modus)**

Falls Ihr BIOS eine erweiterte Benutzeroberfläche hat (UEFI):

1. Wechseln Sie in den **Erweiterten Modus** (meist durch Drücken von **F7**).
2. Navigieren Sie zum Abschnitt **Systeminformationen** oder **Information**.
3. Dort finden Sie:
    - **Mainboard-Modell**
    - **BIOS-Version**
    - **Seriennummer**

---

### **4. Windows-Alternative**

Falls Sie das BIOS nicht starten möchten, können Sie das Modell auch in Windows ermitteln:

1. Öffnen Sie die Eingabeaufforderung (CMD) oder PowerShell.
2. Geben Sie den folgenden Befehl ein:
    
    ```bash
    wmic baseboard get product,manufacturer
    ```
    
3. Sie erhalten Informationen über Hersteller und Modell Ihres Mainboards.

---

Mit diesen Methoden sollten Sie Ihr Mainboard-Modell leicht herausfinden können. Falls Sie weitere Hilfe benötigen, lassen Sie es mich wissen!