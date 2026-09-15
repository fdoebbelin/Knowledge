
### 1. PyCharm starten und neues Projekt anlegen

1. Öffnen Sie PyCharm
2. Klicken Sie auf "Create New Project" auf dem Willkommensbildschirm

### 2. Projektkonfiguration

1. Wählen Sie "Pure Python" als Projekttyp
2. Legen Sie den Projektnamen fest, z.B. "MeineKonsoleApp"
3. Wählen Sie den Speicherort für das Projekt
4. Unter "Python Interpreter" wählen Sie "New environment using Virtualenv"
5. Wählen Sie die gewünschte Python-Version (z.B. Python 3.9)
6. Klicken Sie auf "Create"

### 3. Projektstruktur einrichten

1. Im Projektfenster rechtsklicken Sie auf den Projektnamen
2. Wählen Sie "New" > "Python Package"
3. Nennen Sie das Paket "src" und bestätigen Sie mit Enter
4. Wiederholen Sie den Vorgang für ein "tests" Paket

### 4. Hauptdatei erstellen

1. Rechtsklicken Sie auf das "src" Verzeichnis
2. Wählen Sie "New" > "Python File"
3. Nennen Sie die Datei "main.py" und bestätigen Sie mit Enter

### 5. Code für die Konsolenanwendung schreiben

1. Öffnen Sie die "main.py" Datei
2. Fügen Sie folgenden Beispielcode ein:

```python
def main():
    print("Willkommen zu meiner Konsolenanwendung!")
    name = input("Wie ist dein Name? ")
    print(f"Hallo, {name}! Schön, dich kennenzulernen.")

if __name__ == "__main__":
    main()
```

### 6. Run-Konfiguration erstellen

1. Klicken Sie oben rechts auf "Add Configuration"
2. Klicken Sie auf das "+" und wählen Sie "Python"
3. Benennen Sie die Konfiguration, z.B. "Run Main"
4. Wählen Sie als Script path die "main.py" Datei
5. Stellen Sie sicher, dass der Python Interpreter korrekt eingestellt ist
6. Klicken Sie auf "Apply" und dann auf "OK"

### 7. Anwendung ausführen

1. Klicken Sie oben rechts auf den grünen "Run" Button oder drücken Sie Shift+F10
2. Die Anwendung startet in der PyCharm-Konsole

### 8. Versionskontrolle einrichten (optional)

1. Gehen Sie zu "VCS" > "Enable Version Control Integration"
2. Wählen Sie "Git" als Versionskontrollsystem
3. Bestätigen Sie mit "OK"

### 9. Erste Commit durchführen (optional)

1. Rechtsklicken Sie auf das Projektverzeichnis
2. Wählen Sie "Git" > "Add"
3. Gehen Sie zu "VCS" > "Commit"
4. Geben Sie eine Commit-Nachricht ein, z.B. "Initiales Projekt-Setup"
5. Klicken Sie auf "Commit"

### 10. .gitignore Datei erstellen (optional)

1. Rechtsklicken Sie auf das Projektverzeichnis
2. Wählen Sie "New" > "File"
3. Nennen Sie die Datei ".gitignore"
4. Fügen Sie typische Python-Einträge hinzu:

```
__pycache__/
*.pyc
.idea/
venv/
```

5. Speichern Sie die Datei

### 11. Projekteinstellungen anpassen

1. Gehen Sie zu "File" > "Settings" (auf macOS: "PyCharm" > "Preferences")
2. Unter "Project: MeineKonsoleApp" > "Project Structure" überprüfen Sie die Quellordner
3. Markieren Sie "src" als "Sources" Ordner (blau)
4. Markieren Sie "tests" als "Test Sources" Ordner (grün)
5. Klicken Sie auf "Apply" und dann auf "OK"