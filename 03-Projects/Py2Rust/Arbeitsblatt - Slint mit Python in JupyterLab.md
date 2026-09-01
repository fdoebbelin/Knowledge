## Überblick

Dieses Arbeitsblatt zeigt, wie Sie **Slint** - ein modernes, deklaratives GUI-Toolkit - zusammen mit **Python** in **JupyterLab** verwenden können. Slint ermöglicht die Erstellung nativer Benutzeroberflächen mit einer einfachen, deklarativen Syntax.

## Lernziele

Nach diesem Arbeitsblatt können Sie:
- Slint mit Python installieren und einrichten
- Einfache GUI-Komponenten mit Slint erstellen
- Slint-Code in Markdown-Code-Blöcken dokumentieren
- Python-Code zur Steuerung von Slint-Widgets schreiben
- Callbacks und Event-Handling implementieren

## Voraussetzungen

```bash
# Installation von Slint für Python
uv add slint
# oder mit pip
pip install slint
```

## 1. Grundlagen der Slint-Syntax

### 1.1 Erste Slint-Komponente

Erstellen Sie eine Datei `hello-world.slint` mit folgendem Inhalt:

```slint
import { Button, VerticalBox } from "std-widgets.slint";

export component HelloWorld inherits Window {
    in-out property<int> counter: 0;
    callback button-clicked();
    
    width: 400px;
    height: 300px;
    title: "Slint Demo";
    
    VerticalBox {
        Text {
            text: "Counter: \{root.counter}";
            font-size: 20px;
        }
        
        Button {
            text: "Klick mich!";
            clicked => {
                root.button-clicked();
            }
        }
    }
}
```

### 1.2 Python-Integration

```python
import slint

# Slint-Komponente laden
ui = slint.load_file("hello-world.slint")

class HelloWorldApp:
    def __init__(self):
        self.window = ui.HelloWorld()
        self.setup_callbacks()
    
    def setup_callbacks(self):
        @self.window.callback("button-clicked")
        def on_button_clicked():
            current = self.window.get_counter()
            self.window.set_counter(current + 1)
    
    def run(self):
        self.window.run()

# App starten
app = HelloWorldApp()
app.run()
```

## 2. Erweiterte Komponenten

### 2.1 Input-Komponenten

```slint
import { LineEdit, Button, VerticalBox, HorizontalBox } from "std-widgets.slint";

export component InputDemo inherits Window {
    in-out property<string> user-input: "";
    in-out property<string> output-text: "Geben Sie Text ein...";
    
    callback process-input(string);
    
    width: 500px;
    height: 250px;
    title: "Input Demo";
    
    VerticalBox {
        spacing: 10px;
        padding: 20px;
        
        Text {
            text: "Eingabebeispiel:";
            font-weight: 600;
        }
        
        HorizontalBox {
            spacing: 10px;
            
            LineEdit {
                text <=> root.user-input;
                placeholder-text: "Hier eingeben...";
            }
            
            Button {
                text: "Verarbeiten";
                clicked => {
                    root.process-input(root.user-input);
                }
            }
        }
        
        Text {
            text: root.output-text;
            color: #0066cc;
        }
    }
}
```

### 2.2 Python-Controller für Input

```python
import slint

class InputDemoApp:
    def __init__(self):
        # Slint-Datei automatisch aus sys.path laden
        self.window = slint.loader.input_demo.InputDemo()
        self.setup_callbacks()
    
    def setup_callbacks(self):
        @slint.callback
        def process_input(self, text: str):
            # Text verarbeitung
            processed = f"Verarbeitet: '{text}' (Länge: {len(text)})"
            self.window.set_output_text(processed)
    
    def run(self):
        self.window.show()

# In JupyterLab verwenden
app = InputDemoApp()
app.run()  # Fenster wird in separatem Prozess geöffnet
```

## 3. Datenmodelle und Listen

### 3.1 Liste mit Slint

```slint
import { ListView, StandardListView, VerticalBox } from "std-widgets.slint";

export struct TodoItem {
    text: string,
    completed: bool,
}

export component TodoList inherits Window {
    in-out property<[TodoItem]> items: [
        { text: "Erstes Todo", completed: false },
        { text: "Zweites Todo", completed: true },
    ];
    
    callback item-selected(int);
    callback toggle-item(int);
    
    width: 400px;
    height: 500px;
    title: "Todo Liste";
    
    VerticalBox {
        StandardListView {
            for item[index] in root.items: Rectangle {
                height: 40px;
                background: item.completed ? #e8f5e8 : #f8f8f8;
                
                HorizontalBox {
                    padding: 10px;
                    
                    Text {
                        text: item.text;
                        color: item.completed ? #666 : #000;
                    }
                    
                    TouchArea {
                        clicked => {
                            root.toggle-item(index);
                        }
                    }
                }
            }
        }
    }
}
```

### 3.2 Python-Datenmodell

```python
import slint
from dataclasses import dataclass
from typing import List

@dataclass
class TodoItem:
    text: str
    completed: bool = False

class TodoApp:
    def __init__(self):
        self.todos = [
            TodoItem("Python lernen"),
            TodoItem("Slint ausprobieren"),
            TodoItem("GUI erstellen")
        ]
        
        self.window = slint.loader.todo_list.TodoList()
        self.update_slint_model()
        self.setup_callbacks()
    
    def update_slint_model(self):
        # Python-Liste zu Slint-Modell konvertieren
        slint_items = []
        for todo in self.todos:
            # Slint-Struct erstellen
            item = slint.loader.todo_list.TodoItem()
            item.text = todo.text
            item.completed = todo.completed
            slint_items.append(item)
        
        self.window.set_items(slint.ListModel(slint_items))
    
    @slint.callback
    def toggle_item(self, index: int):
        if 0 <= index < len(self.todos):
            self.todos[index].completed = not self.todos[index].completed
            self.update_slint_model()
    
    def add_todo(self, text: str):
        self.todos.append(TodoItem(text))
        self.update_slint_model()
    
    def run(self):
        self.window.show()
```

## 4. Styling und Themes

### 4.1 Custom Styles

```slint
import { Button, VerticalBox } from "std-widgets.slint";

export component StyledDemo inherits Window {
    width: 350px;
    height: 200px;
    background: @linear-gradient(45deg, #667eea 0%, #764ba2 100%);
    
    VerticalBox {
        padding: 20px;
        spacing: 15px;
        
        Rectangle {
            background: white;
            border-radius: 10px;
            drop-shadow-blur: 10px;
            drop-shadow-color: #00000030;
            height: 60px;
            
            Text {
                text: "Gestylte Komponente";
                color: #333;
                font-size: 18px;
                font-weight: 600;
            }
        }
        
        Button {
            text: "Stylischer Button";
            font-size: 14px;
            
            background: @linear-gradient(0deg, #ff6b6b 0%, #ff8e8e 100%);
            border-color: #ff4757;
            border-width: 2px;
            border-radius: 8px;
            
            clicked => {
                // Animation bei Klick
            }
        }
    }
}
```

## 5. JupyterLab Integration

### 5.1 Ausführbare Markdown-Zellen

Sie können Slint-Code direkt in JupyterLab Markdown-Zellen dokumentieren:

````markdown
## Slint Beispiel

Hier ist ein einfaches Slint-Widget:

```slint
export component SimpleButton inherits Window {
    Button {
        text: "Klick mich";
        clicked => { debug("Button geklickt!"); }
    }
}
```

Der entsprechende Python-Code:

```python
import slint
window = slint.loader.simple_button.SimpleButton()
window.show()
```
````

### 5.2 Code-Cell Directive (MyST Markdown)

Für ausführbare Code-Zellen in Markdown:

````markdown
```{code-cell} python
import slint
import os

# Slint-Style setzen
os.environ['SLINT_STYLE'] = 'material'

# Komponente laden
class DemoApp:
    def __init__(self):
        self.window = slint.loader.demo.DemoWindow()
    
    def show(self):
        self.window.show()

app = DemoApp()
app.show()
```
````

## 6. Praktische Übungen

### Übung 1: Taschenrechner
Erstellen Sie einen einfachen Taschenrechner mit:
- Numerische Eingabefelder
- Operationsbuttons (+, -, *, /)
- Ergebnisanzeige
- Reset-Funktion

### Übung 2: Datei-Explorer
Implementieren Sie einen einfachen Datei-Explorer:
- Verzeichnis-Navigation
- Dateiliste
- Datei-Details anzeigen

### Übung 3: Settings-Dialog
Erstellen Sie einen Einstellungsdialog mit:
- Verschiedene Input-Typen (Text, Checkbox, Slider)
- Speichern/Laden von Konfigurationen
- Apply/Cancel Buttons

## 7. Debugging und Entwicklung

### 7.1 Slint-Viewer

```bash
# Slint-Datei in separatem Viewer öffnen
slint-viewer my-component.slint

# Mit bestimmtem Style
slint-viewer --style material my-component.slint
```

### 7.2 VS Code Integration

Installieren Sie die Slint-Extension für VS Code für:
- Syntax-Highlighting
- Live-Preview
- Auto-Completion
- Design-Modus

### 7.3 Error-Handling

```python
import slint

try:
    window = slint.load_file("non-existent.slint")
except FileNotFoundError as e:
    print(f"Slint-Datei nicht gefunden: {e}")
except slint.CompilationError as e:
    print(f"Slint-Kompilierungsfehler: {e}")
```

## 8. Performance-Tipps

1. **Lazy Loading**: Laden Sie Slint-Komponenten nur bei Bedarf
2. **Model Updates**: Verwenden Sie `ListModel` für große Datenmengen
3. **Property Bindings**: Minimieren Sie komplexe Berechnungen in Bindings
4. **Memory Management**: Schließen Sie Windows explizit

## Zusätzliche Ressourcen

- [Slint Documentation](https://docs.slint.dev/)
- [Python-spezifische API](https://docs.slint.dev/latest/docs/python/slint/)
- [GitHub Repository](https://github.com/slint-ui/slint)
- [Beispiele und Templates](https://github.com/slint-ui/slint-python-template)

## Zusammenfassung

Slint bietet eine moderne, deklarative Möglichkeit zur GUI-Entwicklung mit Python. Die Integration in JupyterLab ermöglicht:
- Interaktive Entwicklung und Dokumentation
- Einfache Prototyping-Workflows
- Kombination von Datenanalyse und GUI-Entwicklung
- Plattformübergreifende Desktop-Anwendungen

Die Markdown-Integration macht es besonders geeignet für Lehrumgebungen und dokumentationsgetriebene Entwicklung.