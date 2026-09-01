> Einführung in moderne Python-GUI-Entwicklung
## 1. Grundlagen und Setup

### Installation und Import
```python
# Installation über pip
pip install customtkinter

# Import in Python-Code
import customtkinter as ctk

# Grundkonfiguration
ctk.set_appearance_mode("System")  # "System", "Light", "Dark"
ctk.set_default_color_theme("blue")  # "blue", "dark-blue", "green"
```

### Erstes CustomTkinter-Programm
```python
import customtkinter as ctk

# Konfiguration
ctk.set_appearance_mode("System")
ctk.set_default_color_theme("blue")

# Hauptfenster erstellen
app = ctk.CTk()
app.title("Meine erste CustomTkinter App")
app.geometry("400x300")

# Ein einfaches Label
label = ctk.CTkLabel(app, text="Willkommen zu CustomTkinter!", 
                     font=("Arial", 20))
label.pack(pady=20)

# Ein Button
def button_callback():
    print("Button wurde geklickt!")

button = ctk.CTkButton(app, text="Klick mich!", 
                       command=button_callback)
button.pack(pady=10)

# App starten
app.mainloop()
```

**Ausführung**: Speichere den Code als `hello_ctk.py` und führe ihn aus.

---

## 2. Widget-Übersicht

### 2.1 Grundlegende Widgets

#### CTkLabel - Textanzeige
```python
# Einfaches Label
label1 = ctk.CTkLabel(app, text="Standard Label")

# Gestyltes Label
label2 = ctk.CTkLabel(app, 
                      text="Gestyltes Label",
                      font=("Helvetica", 18),
                      text_color="blue",
                      fg_color="lightgray",
                      corner_radius=10)

label1.pack(pady=5)
label2.pack(pady=5)
```

#### CTkButton - Buttons
```python
# Standard Button
button1 = ctk.CTkButton(app, text="Standard Button")

# Gestylter Button
def my_callback():
    print("Custom Button geklickt!")

button2 = ctk.CTkButton(app,
                        text="Custom Button",
                        command=my_callback,
                        fg_color="green",
                        hover_color="darkgreen",
                        corner_radius=20,
                        width=200,
                        height=40)

button1.pack(pady=5)
button2.pack(pady=5)
```

#### CTkEntry - Eingabefelder
```python
# Standard Entry
entry1 = ctk.CTkEntry(app, placeholder_text="Geben Sie Text ein...")

# Passwort Entry
entry2 = ctk.CTkEntry(app, 
                      placeholder_text="Passwort eingeben",
                      show="*")

# Entry mit Event-Handler
def entry_callback(event=None):
    text = entry1.get()
    print(f"Eingabe: {text}")

entry1.bind("<Return>", entry_callback)

entry1.pack(pady=5)
entry2.pack(pady=5)
```

### 2.2 Container-Widgets

#### CTkFrame - Container
```python
# Hauptframe
main_frame = ctk.CTkFrame(app, corner_radius=15)
main_frame.pack(pady=20, padx=20, fill="both", expand=True)

# Widgets im Frame
frame_label = ctk.CTkLabel(main_frame, text="Inhalt im Frame")
frame_button = ctk.CTkButton(main_frame, text="Frame Button")

frame_label.pack(pady=10)
frame_button.pack(pady=5)
```

#### CTkScrollableFrame - Scrollbarer Container
```python
# Scrollbarer Frame
scrollable_frame = ctk.CTkScrollableFrame(app, width=300, height=200)
scrollable_frame.pack(pady=10, padx=10)

# Viele Widgets hinzufügen
for i in range(20):
    label = ctk.CTkLabel(scrollable_frame, text=f"Label {i+1}")
    label.pack(pady=2)
```

### 2.3 Interaktive Widgets

#### CTkCheckBox - Checkboxen
```python
# Checkbox mit Variable
checkbox_var = ctk.StringVar()

def checkbox_event():
    print(f"Checkbox Status: {checkbox_var.get()}")

checkbox = ctk.CTkCheckBox(app,
                          text="Zustimmen",
                          variable=checkbox_var,
                          onvalue="Ja",
                          offvalue="Nein",
                          command=checkbox_event)
checkbox.pack(pady=5)
```

#### CTkRadioButton - Radio Buttons
```python
# Radio Button Gruppe
radio_var = ctk.StringVar(value="Option1")

def radio_event():
    print(f"Gewählt: {radio_var.get()}")

radio1 = ctk.CTkRadioButton(app, text="Option 1", 
                           variable=radio_var, value="Option1",
                           command=radio_event)
radio2 = ctk.CTkRadioButton(app, text="Option 2",
                           variable=radio_var, value="Option2", 
                           command=radio_event)

radio1.pack(pady=5)
radio2.pack(pady=5)
```

#### CTkSlider - Schieberegler
```python
def slider_event(value):
    print(f"Slider Wert: {value}")

slider = ctk.CTkSlider(app,
                       from_=0,
                       to=100,
                       command=slider_event)
slider.set(50)  # Startwert setzen
slider.pack(pady=10)
```

#### CTkComboBox - Dropdown mit Eingabe
```python
def combobox_callback(choice):
    print(f"Auswahl: {choice}")

combobox = ctk.CTkComboBox(app,
                          values=["Python", "Java", "C++", "JavaScript"],
                          command=combobox_callback)
combobox.set("Python")  # Standardwert
combobox.pack(pady=10)
```

---

## 3. Layout-Management

### 3.1 Pack Layout
```python
# Pack mit verschiedenen Optionen
widget1.pack(side="top", fill="x", padx=10, pady=5)
widget2.pack(side="left", fill="y", padx=5)
widget3.pack(side="bottom", fill="both", expand=True)
```

### 3.2 Grid Layout
```python
# Grid Layout - strukturierter
app.grid_columnconfigure(0, weight=1)
app.grid_rowconfigure(0, weight=1)

label.grid(row=0, column=0, padx=10, pady=5, sticky="ew")
entry.grid(row=0, column=1, padx=10, pady=5, sticky="ew")
button.grid(row=1, column=0, columnspan=2, pady=10)
```

---

## 4. Themes und Styling

### 4.1 Appearance Modes
```python
# Appearance Mode wechseln
def change_appearance():
    current_mode = ctk.get_appearance_mode()
    if current_mode == "Light":
        ctk.set_appearance_mode("Dark")
    else:
        ctk.set_appearance_mode("Light")

mode_button = ctk.CTkButton(app, text="Mode wechseln", 
                           command=change_appearance)
mode_button.pack(pady=10)
```

### 4.2 Benutzerdefinierte Farben
```python
# Widget mit benutzerdefinierten Farben
custom_button = ctk.CTkButton(app,
                             text="Custom Colors",
                             fg_color="#FF6B6B",        # Vordergrundfarbe
                             hover_color="#FF5252",      # Hover-Farbe
                             text_color="white",         # Textfarbe
                             corner_radius=25)           # Eckenradius
custom_button.pack(pady=10)
```

### 4.3 Eigenes Color Theme (JSON)
```python
# Erstelle eine Datei: custom_theme.json
custom_theme = {
    "CTk": {
        "fg_color": ["gray92", "gray14"]
    },
    "CTkButton": {
        "fg_color": ["#3B8ED0", "#1F6AA5"],
        "hover_color": ["#36719F", "#144870"],
        "text_color": ["gray98", "#DCE4EE"]
    },
    "CTkLabel": {
        "text_color": ["gray10", "#DCE4EE"]
    },
    "CTkEntry": {
        "fg_color": ["#F9F9FA", "#343638"],
        "border_color": ["#979DA2", "#565B5E"],
        "text_color": ["gray10", "#DCE4EE"]
    }
}

# Theme laden
ctk.set_default_color_theme("path/to/custom_theme.json")
```

---

## 5. Erweiterte Funktionen

### 5.1 CTkTabview - Tabs
```python
# Tab-Ansicht erstellen
tabview = ctk.CTkTabview(app, width=400, height=300)
tabview.pack(padx=20, pady=20)

# Tabs hinzufügen
tab1 = tabview.add("Tab 1")
tab2 = tabview.add("Tab 2")

# Widgets in Tabs
label1 = ctk.CTkLabel(tab1, text="Inhalt von Tab 1")
label1.pack(pady=20)

label2 = ctk.CTkLabel(tab2, text="Inhalt von Tab 2") 
label2.pack(pady=20)
```

### 5.2 CTkTextbox - Mehrzeiliger Text
```python
# Textbox mit Scrollbar
textbox = ctk.CTkTextbox(app, width=300, height=150)
textbox.pack(pady=10, padx=10)

# Text einfügen
textbox.insert("1.0", "Dies ist ein mehrzeiliger Text...\n")
textbox.insert("end", "Weitere Zeile hinzugefügt.")

# Text auslesen
def get_text():
    content = textbox.get("1.0", "end")
    print(content)
```

### 5.3 CTkToplevel - Zusätzliche Fenster
```python
def open_new_window():
    # Neues Fenster erstellen
    new_window = ctk.CTkToplevel(app)
    new_window.title("Neues Fenster")
    new_window.geometry("300x200")
    
    # Inhalt hinzufügen
    label = ctk.CTkLabel(new_window, text="Dies ist ein neues Fenster")
    label.pack(pady=20)
    
    close_button = ctk.CTkButton(new_window, text="Schließen",
                                command=new_window.destroy)
    close_button.pack(pady=10)

# Button im Hauptfenster
open_button = ctk.CTkButton(app, text="Neues Fenster öffnen",
                           command=open_new_window)
open_button.pack(pady=10)
```

---

## 6. Praktische Beispiele

### 6.1 Login-Formular
```python
import customtkinter as ctk

class LoginApp(ctk.CTk):
    def __init__(self):
        super().__init__()
        
        self.title("Login System")
        self.geometry("350x400")
        self.resizable(False, False)
        
        # Zentrierte Anordnung
        self.grid_columnconfigure(0, weight=1)
        
        # Titel
        title = ctk.CTkLabel(self, text="Anmeldung", 
                            font=ctk.CTkFont(size=24, weight="bold"))
        title.grid(row=0, column=0, pady=30)
        
        # Eingabeframe
        self.frame = ctk.CTkFrame(self, corner_radius=15)
        self.frame.grid(row=1, column=0, padx=30, pady=20, sticky="ew")
        
        # Benutzername
        self.username_label = ctk.CTkLabel(self.frame, text="Benutzername:")
        self.username_label.grid(row=0, column=0, padx=20, pady=(20,5), sticky="w")
        
        self.username_entry = ctk.CTkEntry(self.frame, width=200,
                                          placeholder_text="Benutzername eingeben")
        self.username_entry.grid(row=1, column=0, padx=20, pady=(0,15))
        
        # Passwort
        self.password_label = ctk.CTkLabel(self.frame, text="Passwort:")
        self.password_label.grid(row=2, column=0, padx=20, pady=(5,5), sticky="w")
        
        self.password_entry = ctk.CTkEntry(self.frame, width=200, show="*",
                                          placeholder_text="Passwort eingeben")
        self.password_entry.grid(row=3, column=0, padx=20, pady=(0,20))
        
        # Login Button
        self.login_button = ctk.CTkButton(self, text="Anmelden", 
                                         command=self.login_event,
                                         width=200, height=40)
        self.login_button.grid(row=2, column=0, pady=20)
        
    def login_event(self):
        username = self.username_entry.get()
        password = self.password_entry.get()
        
        if username == "admin" and password == "12345":
            print("Login erfolgreich!")
        else:
            print("Falsche Anmeldedaten!")

if __name__ == "__main__":
    ctk.set_appearance_mode("dark")
    ctk.set_default_color_theme("blue")
    
    app = LoginApp()
    app.mainloop()
```

### 6.2 Einfacher Rechner
```python
import customtkinter as ctk

class CalculatorApp(ctk.CTk):
    def __init__(self):
        super().__init__()
        
        self.title("CustomTkinter Rechner")
        self.geometry("300x400")
        self.resizable(False, False)
        
        # Display
        self.result_var = ctk.StringVar()
        self.result_var.set("0")
        
        self.display = ctk.CTkLabel(self, textvariable=self.result_var,
                                   font=ctk.CTkFont(size=24),
                                   height=60, corner_radius=10,
                                   fg_color="gray20")
        self.display.pack(fill="x", padx=10, pady=10)
        
        # Button Frame
        button_frame = ctk.CTkFrame(self)
        button_frame.pack(fill="both", expand=True, padx=10, pady=10)
        
        # Buttons erstellen
        buttons = [
            ['C', '±', '%', '÷'],
            ['7', '8', '9', '×'],
            ['4', '5', '6', '-'],
            ['1', '2', '3', '+'],
            ['0', '', '.', '=']
        ]
        
        for row_idx, row in enumerate(buttons):
            for col_idx, text in enumerate(row):
                if text:
                    btn = ctk.CTkButton(button_frame, text=text,
                                       command=lambda t=text: self.button_click(t),
                                       width=60, height=50)
                    btn.grid(row=row_idx, column=col_idx, 
                            padx=5, pady=5, sticky="nsew")
        
        # Grid konfigurieren
        for i in range(4):
            button_frame.grid_columnconfigure(i, weight=1)
        for i in range(5):
            button_frame.grid_rowconfigure(i, weight=1)
    
    def button_click(self, value):
        current = self.result_var.get()
        
        if value == 'C':
            self.result_var.set("0")
        elif value == '=':
            try:
                # Einfache Berechnung (nur für Demo)
                result = eval(current.replace('×', '*').replace('÷', '/'))
                self.result_var.set(str(result))
            except:
                self.result_var.set("Error")
        else:
            if current == "0" and value not in ['×', '÷', '-', '+', '.']:
                self.result_var.set(value)
            else:
                self.result_var.set(current + value)

if __name__ == "__main__":
    ctk.set_appearance_mode("dark")
    ctk.set_default_color_theme("blue")
    
    app = CalculatorApp()
    app.mainloop()
```

---

## 7. Best Practices

### 7.1 Code-Struktur
```python
# Klassen-basierte Struktur verwenden
class MyApp(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.setup_ui()
        self.setup_bindings()
    
    def setup_ui(self):
        # UI-Elemente erstellen
        pass
    
    def setup_bindings(self):
        # Event-Handler verbinden
        pass
```

### 7.2 Responsives Design
```python
# Grid weights für responsive Layouts
self.grid_columnconfigure(0, weight=1)
self.grid_rowconfigure(0, weight=1)

# Sticky für Anpassung an Größenänderungen
widget.grid(sticky="nsew")
```

### 7.3 Fehlerbehandlung
```python
def safe_operation(self):
    try:
        # Potentiell fehleranfällige Operation
        result = self.entry.get()
        # Verarbeitung...
    except Exception as e:
        print(f"Fehler: {e}")
        # Benutzerfreundliche Fehlermeldung
```

---

## 8. Deployment mit PyInstaller

### CustomTkinter Apps verpacken
```bash
# Basis-Installation
pip install pyinstaller

# Einfache Ausführbare Datei
pyinstaller --onefile --windowed main.py

# Mit Icon und verbesserter Performance
pyinstaller --onefile --windowed --icon=app_icon.ico --add-data "assets;assets" main.py
```

### Spezifische CustomTkinter Überlegungen
- CustomTkinter Dateien werden automatisch erkannt
- Themes und Assets müssen explizit hinzugefügt werden
- Dark/Light Mode funktioniert in gepackten Apps

---

## 9. Ressourcen und Weiterführendes

### Offizielle Dokumentation
- Website: https://customtkinter.tomschimansky.com/
- GitHub: https://github.com/TomSchimansky/CustomTkinter
- Wiki: Umfangreiche Beispiele und Tutorials

### Community-Ressourcen
- YouTube Tutorials
- Stack Overflow für spezifische Probleme
- GitHub Discussions für Feature-Requests

### Erweiterungsmöglichkeiten
- Integration mit Datenbanken
- Web-APIs einbinden
- Multimedia-Unterstützung
- Komplexe Datenvisualisierung
