### 1. Erstellung der Konsolenanwendung

Zunächst erstellen wir eine einfache Taschenrechner-Anwendung:

```python
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def multiply(a, b):
    return a * b

def divide(a, b):
    if b != 0:
        return a / b
    else:
        return "Fehler: Division durch Null!"

def calculator():
    print("Einfacher Taschenrechner")
    while True:
        print("\nWählen Sie eine Operation:")
        print("1. Addition")
        print("2. Subtraktion")
        print("3. Multiplikation")
        print("4. Division")
        print("5. Beenden")
        
        choice = input("Geben Sie Ihre Wahl ein (1-5): ")
        
        if choice == '5':
            print("Auf Wiedersehen!")
            break
        
        if choice in ('1', '2', '3', '4'):
            num1 = float(input("Geben Sie die erste Zahl ein: "))
            num2 = float(input("Geben Sie die zweite Zahl ein: "))
            
            if choice == '1':
                print("Ergebnis:", add(num1, num2))
            elif choice == '2':
                print("Ergebnis:", subtract(num1, num2))
            elif choice == '3':
                print("Ergebnis:", multiply(num1, num2))
            elif choice == '4':
                print("Ergebnis:", divide(num1, num2))
        else:
            print("Ungültige Eingabe. Bitte versuchen Sie es erneut.")

if __name__ == "__main__":
    calculator()
```

Speichern Sie diesen Code in einer Datei namens `calculator.py`.

### 2. Konfiguration der Ausführungsumgebung

**Erstellung einer Run-Konfiguration:**

1. Klicken Sie oben rechts auf "Add Configuration" oder gehen Sie zu "Run" > "Edit Configurations".
2. Klicken Sie auf das "+"-Symbol und wählen Sie "Python".
3. Geben Sie der Konfiguration einen Namen, z.B. "Calculator".
4. Wählen Sie das Script-Pfad: Ihr `calculator.py` File.
5. Stellen Sie sicher, dass der korrekte Python-Interpreter ausgewählt ist.
6. Klicken Sie auf "Apply" und dann "OK".

**Konfiguration von Umgebungsvariablen (optional):**

1. In der Run-Konfiguration, gehen Sie zum Abschnitt "Environment variables".
2. Klicken Sie auf das Ordner-Symbol, um Variablen hinzuzufügen.
3. Fügen Sie z.B. `DEBUG_MODE=True` hinzu, wenn Sie Debugging-Informationen ausgeben möchten.

### 3. Ausführung der Anwendung

1. Wählen Sie die erstellte Run-Konfiguration aus dem Dropdown-Menü oben rechts.
2. Klicken Sie auf den grünen "Run"-Button oder drücken Sie Shift+F10.
3. Die Anwendung startet nun im PyCharm-Konsolenfenster.

### 4. Debugging

1. Setzen Sie Breakpoints, indem Sie links neben die Zeilennummern im Code klicken.
2. Starten Sie den Debugger mit dem "Debug"-Button (neben dem "Run"-Button) oder drücken Sie Shift+F9.
3. Verwenden Sie die Debug-Toolbar, um durch den Code zu navigieren (Step Over, Step Into, etc.).
4. Inspizieren Sie Variablen im "Variables"-Fenster während des Debugging-Prozesses.

### 5. Vorbereitung für das Deployment

**Erstellung einer ausführbaren Datei:**

1. Installieren Sie PyInstaller: `pip install pyinstaller`
2. Öffnen Sie das Terminal in PyCharm (View > Tool Windows > Terminal)
3. Navigieren Sie zum Projektverzeichnis
4. Führen Sie folgenden Befehl aus:
   ```
   pyinstaller --onefile calculator.py
   ```
5. PyInstaller erstellt eine ausführbare Datei im `dist`-Ordner.

### 6. Deployment auf einem anderen System

1. Kopieren Sie die erstellte ausführbare Datei aus dem `dist`-Ordner.
2. Übertragen Sie diese Datei auf das Zielsystem (z.B. via USB-Stick oder Netzwerkfreigabe).
3. Auf dem Zielsystem kann die Anwendung nun direkt ausgeführt werden, ohne dass Python installiert sein muss.

### 7. Remote Deployment (optional)

Für Remote-Deployment auf einem Server:

1. Gehen Sie zu "Tools" > "Deployment" > "Configuration"
2. Klicken Sie auf "+", um eine neue Konfiguration hinzuzufügen
3. Wählen Sie den Verbindungstyp (z.B. SFTP)
4. Geben Sie die Serverdetails ein (Host, Benutzername, Passwort/Schlüssel)
5. Konfigurieren Sie die Mappings zwischen lokalem Projekt und Remote-Server
6. Nutzen Sie "Tools" > "Deployment" > "Upload to [Ihr Server]", um die Anwendung hochzuladen