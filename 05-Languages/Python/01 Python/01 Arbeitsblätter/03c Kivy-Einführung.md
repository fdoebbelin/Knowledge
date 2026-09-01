> Einführung in Multi-Platform Python-GUI-Entwicklung
## 1. Grundlagen und Setup

### Installation und Umgebung
```bash
# Kivy Installation (empfohlen in Virtual Environment)
python -m venv kivy_env
source kivy_env/bin/activate     # Linux/macOS
# kivy_env\Scripts\activate.ps1  # Windows

pip install kivy

# Prüfung der Installation
python -c "import kivy; print(kivy.__version__)"

# Zusätzliche Pakete für erweiterte Features
pip install kivy[media]  # Video/Audio Support
pip install buildozer   # Für Android Builds
```

### Erstes Kivy-Programm
```python
from kivy.app import App
from kivy.uix.label import Label

class MyApp(App):
    def build(self):
        return Label(text='Hello Kivy World!')

# App starten
MyApp().run()
```

**Ausführung**: Speichere als `hello_kivy.py` und führe aus.

---

## 2. Kivy App-Struktur

### 2.1 Grundlegende App-Klasse
```python
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
from kivy.uix.label import Label

class MainApp(App):
    def build(self):
        # Hauptlayout erstellen
        layout = BoxLayout(orientation='vertical')
        
        # Widgets hinzufügen
        layout.add_widget(Label(text='Kivy Multi-Platform App'))
        
        button = Button(text='Klick mich!')
        button.bind(on_press=self.on_button_press)
        layout.add_widget(button)
        
        return layout
    
    def on_button_press(self, instance):
        print('Button gedrückt!')
        instance.text = 'Danke!'

MainApp().run()
```

### 2.2 Multi-Touch Support
```python
from kivy.app import App
from kivy.uix.widget import Widget
from kivy.graphics import Color, Ellipse

class TouchPaintApp(Widget):
    def on_touch_down(self, touch):
        with self.canvas:
            # Zufällige Farbe für jeden Touch-Punkt
            Color(touch.x/self.width, touch.y/self.height, 1)
            d = 30.  # Durchmesser
            Ellipse(pos=(touch.x - d/2, touch.y - d/2), size=(d, d))
            touch.ud['line'] = [touch.x, touch.y]

    def on_touch_move(self, touch):
        if 'line' in touch.ud:
            touch.ud['line'].extend([touch.x, touch.y])

class PaintApp(App):
    def build(self):
        return TouchPaintApp()

PaintApp().run()
```

---

## 3. Widget-Übersicht

### 3.1 Grundlegende Widgets

#### Label - Textanzeige
```python
from kivy.uix.label import Label

# Einfaches Label
label1 = Label(text='Einfacher Text')

# Formatiertes Label
label2 = Label(
    text='[color=ff3333]Roter Text[/color] und [b]Fetter Text[/b]',
    markup=True,
    font_size=20
)

# Multi-line Label
label3 = Label(
    text='Zeile 1\nZeile 2\nZeile 3',
    text_size=(200, None),  # Textbreite begrenzen
    halign='center'
)
```

#### Button - Touch-optimierte Buttons
```python
from kivy.uix.button import Button

# Standard Button
button1 = Button(text='Standard Button')

# Gestylter Button
button2 = Button(
    text='Custom Button',
    size_hint=(0.5, 0.2),  # 50% Breite, 20% Höhe
    pos_hint={'center_x': 0.5, 'center_y': 0.5},
    background_color=(1, 0.5, 0.5, 1)  # RGBA
)

# Button mit Event
def button_callback(instance):
    print(f'Button "{instance.text}" wurde gedrückt!')

button2.bind(on_press=button_callback)
```

#### TextInput - Mobile-optimierte Eingabe
```python
from kivy.uix.textinput import TextInput

# Einzeiliges Eingabefeld
text_input1 = TextInput(
    text='Standardtext',
    multiline=False,
    size_hint=(1, None),
    height=40
)

# Mehrzeiliges Textfeld
text_input2 = TextInput(
    text='Mehrzeiliger\nText möglich',
    multiline=True
)

# Passwort-Eingabe
password_input = TextInput(
    password=True,
    multiline=False
)
```

### 3.2 Mobile-spezifische Widgets

#### Slider - Touch-Slider
```python
from kivy.uix.slider import Slider

def on_slider_value(instance, value):
    print(f'Slider Wert: {value}')

slider = Slider(
    min=0, 
    max=100, 
    value=50,
    step=1,
    orientation='horizontal'
)
slider.bind(value=on_slider_value)
```

#### Switch - Mobile Toggle
```python
from kivy.uix.switch import Switch

def on_switch_active(instance, value):
    print(f'Switch ist {"AN" if value else "AUS"}')

switch = Switch(active=True)
switch.bind(active=on_switch_active)
```

---

## 4. Layout Management

### 4.1 BoxLayout - Linear Layout
```python
from kivy.uix.boxlayout import BoxLayout

# Vertikales Layout
vertical_layout = BoxLayout(
    orientation='vertical',
    spacing=10,  # Abstand zwischen Widgets
    padding=20   # Innenabstand
)

# Horizontales Layout
horizontal_layout = BoxLayout(orientation='horizontal')

# Größenverhältnisse kontrollieren
button1 = Button(text='25%', size_hint_x=0.25)
button2 = Button(text='75%', size_hint_x=0.75)

horizontal_layout.add_widget(button1)
horizontal_layout.add_widget(button2)
```

### 4.2 GridLayout - Raster Layout
```python
from kivy.uix.gridlayout import GridLayout

# 3x3 Grid für Taschenrechner
grid = GridLayout(cols=3, rows=3, spacing=5)

# Buttons für Zahlen 1-9
for i in range(1, 10):
    button = Button(text=str(i))
    grid.add_widget(button)
```

### 4.3 FloatLayout - Freie Positionierung
```python
from kivy.uix.floatlayout import FloatLayout

# FloatLayout für freie Positionierung
float_layout = FloatLayout()

# Button mit absoluter Position
button = Button(
    text='Zentriert',
    size_hint=(0.3, 0.2),
    pos_hint={'center_x': 0.5, 'center_y': 0.5}
)

# Button in Ecke
corner_button = Button(
    text='Ecke',
    size_hint=(0.2, 0.1),
    pos_hint={'x': 0, 'y': 0}  # Unten links
)

float_layout.add_widget(button)
float_layout.add_widget(corner_button)
```

### 4.4 StackLayout - Responsive Anordnung
```python
from kivy.uix.stacklayout import StackLayout

# Responsive Button-Grid
stack = StackLayout(
    orientation='lr-tb',  # Links-rechts, dann oben-unten
    spacing=10
)

# Buttons mit fester Breite, variable Anzahl pro Zeile
for i in range(20):
    button = Button(
        text=f'Btn {i+1}',
        size_hint_x=None,
        width=100,
        height=50
    )
    stack.add_widget(button)
```

---

## 5. KV Language - Separating Design from Logic

### 5.1 Grundlagen der KV-Sprache
```python
# main.py
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout

class RootWidget(BoxLayout):
    pass

class MyKvApp(App):
    def build(self):
        return RootWidget()

MyKvApp().run()
```

```yaml
# mykvapp.kv (Name muss zur App-Klasse passen: MyKvApp -> mykvapp.kv)
#:kivy 2.0

<RootWidget>:
    orientation: 'vertical'
    padding: 20
    spacing: 10
    
    Label:
        text: 'KV Language Demo'
        font_size: 24
        color: 1, 0.5, 0, 1
        
    Button:
        text: 'KV Button'
        on_press: print('Button aus KV gedrückt!')
        
    TextInput:
        hint_text: 'Text eingeben...'
        multiline: False
```

### 5.2 Property Binding in KV
```python
# main.py
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import StringProperty

class RootWidget(BoxLayout):
    slider_value = StringProperty('50')

class BindingApp(App):
    def build(self):
        return RootWidget()

BindingApp().run()
```

```yaml
# bindingapp.kv
#:kivy 2.0

<RootWidget>:
    orientation: 'vertical'
    
    Label:
        text: 'Slider Wert: ' + root.slider_value
        font_size: 20
        
    Slider:
        min: 0
        max: 100
        value: 50
        on_value: root.slider_value = str(int(self.value))
```

### 5.3 Canvas Drawing in KV
```python
# canvas_app.py
from kivy.app import App
from kivy.uix.widget import Widget

class CanvasWidget(Widget):
    pass

class CanvasApp(App):
    def build(self):
        return CanvasWidget()

CanvasApp().run()
```

```yaml
# canvasapp.kv
#:kivy 2.0

<CanvasWidget>:
    canvas:
        # Hintergrund
        Color:
            rgba: 0.2, 0.3, 0.8, 1
        Rectangle:
            pos: self.pos
            size: self.size
            
        # Kreis in der Mitte
        Color:
            rgba: 1, 1, 0, 1
        Ellipse:
            pos: self.center_x - 50, self.center_y - 50
            size: 100, 100
            
        # Linie
        Color:
            rgba: 1, 0, 0, 1
        Line:
            points: [0, 0, self.width, self.height]
            width: 3
```

---

## 6. Screen Management - Navigation

### 6.1 Multi-Screen App
```python
from kivy.app import App
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout

class MenuScreen(Screen):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        layout = BoxLayout(orientation='vertical')
        
        btn1 = Button(text='Zu Settings')
        btn1.bind(on_press=lambda x: self.manager.current = 'settings')
        
        btn2 = Button(text='Zu About')
        btn2.bind(on_press=lambda x: self.manager.current = 'about')
        
        layout.add_widget(btn1)
        layout.add_widget(btn2)
        self.add_widget(layout)

class SettingsScreen(Screen):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        layout = BoxLayout(orientation='vertical')
        
        from kivy.uix.label import Label
        layout.add_widget(Label(text='Settings Bildschirm'))
        
        back_btn = Button(text='Zurück zum Menü')
        back_btn.bind(on_press=lambda x: self.manager.current = 'menu')
        layout.add_widget(back_btn)
        
        self.add_widget(layout)

class AboutScreen(Screen):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        layout = BoxLayout(orientation='vertical')
        
        from kivy.uix.label import Label
        layout.add_widget(Label(text='About Bildschirm'))
        
        back_btn = Button(text='Zurück zum Menü')
        back_btn.bind(on_press=lambda x: self.manager.current = 'menu')
        layout.add_widget(back_btn)
        
        self.add_widget(layout)

class NavigationApp(App):
    def build(self):
        sm = ScreenManager()
        
        sm.add_widget(MenuScreen(name='menu'))
        sm.add_widget(SettingsScreen(name='settings'))
        sm.add_widget(AboutScreen(name='about'))
        
        return sm

NavigationApp().run()
```

### 6.2 Screen Transitions
```python
from kivy.uix.screenmanager import SlideTransition, FadeTransition

# Verschiedene Übergangseffekte
sm.transition = SlideTransition(direction='left')
sm.transition = FadeTransition()
```

---

## 7. Mobile Features

### 7.1 Device APIs nutzen
```python
# Plattform-spezifische Features
from kivy.utils import platform

if platform == 'android':
    from jnius import autoclass
    # Android-spezifische Funktionen
    PythonActivity = autoclass('org.kivy.android.PythonActivity')
    
elif platform == 'ios':
    # iOS-spezifische Funktionen
    pass
```

### 7.2 Popup-Dialoge für Mobile
```python
from kivy.uix.popup import Popup
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.label import Label

def show_popup():
    content = BoxLayout(orientation='vertical')
    content.add_widget(Label(text='Dies ist ein Popup!'))
    
    close_btn = Button(text='Schließen', size_hint_y=None, height=50)
    content.add_widget(close_btn)
    
    popup = Popup(
        title='Popup Titel',
        content=content,
        size_hint=(0.8, 0.6)
    )
    
    close_btn.bind(on_press=popup.dismiss)
    popup.open()

# Button zum Popup öffnen
popup_btn = Button(text='Popup öffnen')
popup_btn.bind(on_press=lambda x: show_popup())
```

---

## 8. Praktische Beispiele

### 8.1 To-Do Liste für Mobile
```python
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
from kivy.uix.textinput import TextInput
from kivy.uix.label import Label
from kivy.uix.scrollview import ScrollView

class TodoApp(App):
    def __init__(self):
        super().__init__()
        self.todos = []
    
    def build(self):
        main_layout = BoxLayout(orientation='vertical', padding=10, spacing=10)
        
        # Eingabebereich
        input_layout = BoxLayout(orientation='horizontal', size_hint_y=None, height=50)
        
        self.todo_input = TextInput(
            hint_text='Neue Aufgabe eingeben...',
            multiline=False,
            size_hint_x=0.8
        )
        
        add_btn = Button(
            text='Hinzufügen',
            size_hint_x=0.2
        )
        add_btn.bind(on_press=self.add_todo)
        
        input_layout.add_widget(self.todo_input)
        input_layout.add_widget(add_btn)
        
        # Todo-Liste (scrollbar)
        scroll = ScrollView()
        self.todo_layout = BoxLayout(orientation='vertical', size_hint_y=None)
        self.todo_layout.bind(minimum_height=self.todo_layout.setter('height'))
        
        scroll.add_widget(self.todo_layout)
        
        # Layout zusammensetzen
        main_layout.add_widget(input_layout)
        main_layout.add_widget(scroll)
        
        return main_layout
    
    def add_todo(self, instance):
        todo_text = self.todo_input.text.strip()
        if todo_text:
            self.create_todo_item(todo_text)
            self.todo_input.text = ''
    
    def create_todo_item(self, text):
        item_layout = BoxLayout(
            orientation='horizontal', 
            size_hint_y=None, 
            height=60,
            spacing=10
        )
        
        # Todo Text
        todo_label = Label(
            text=text,
            size_hint_x=0.7,
            text_size=(None, None),
            halign='left'
        )
        
        # Erledigt Button
        done_btn = Button(
            text='✓',
            size_hint_x=0.15,
            background_color=(0.2, 0.8, 0.2, 1)
        )
        done_btn.bind(on_press=lambda x: self.mark_done(item_layout))
        
        # Löschen Button
        delete_btn = Button(
            text='✗',
            size_hint_x=0.15,
            background_color=(0.8, 0.2, 0.2, 1)
        )
        delete_btn.bind(on_press=lambda x: self.delete_todo(item_layout))
        
        item_layout.add_widget(todo_label)
        item_layout.add_widget(done_btn)
        item_layout.add_widget(delete_btn)
        
        self.todo_layout.add_widget(item_layout)
    
    def mark_done(self, item_layout):
        label = item_layout.children[2]  # Label ist das 3. Kind (reverse order)
        label.color = (0.5, 0.5, 0.5, 1)  # Grau für erledigt
        label.text = f'✓ {label.text}'
    
    def delete_todo(self, item_layout):
        self.todo_layout.remove_widget(item_layout)

TodoApp().run()
```

### 8.2 Touch-basiertes Zeichenprogramm
```python
from kivy.app import App
from kivy.uix.widget import Widget
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
from kivy.graphics import Color, Line, Rectangle
import random

class PaintWidget(Widget):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.line_width = 2
    
    def on_touch_down(self, touch):
        # Neue Linie beginnen
        with self.canvas:
            Color(random.random(), random.random(), random.random())
            self.line = Line(points=[touch.x, touch.y], width=self.line_width)
    
    def on_touch_move(self, touch):
        # Linie erweitern
        if hasattr(self, 'line'):
            self.line.points += [touch.x, touch.y]
    
    def clear_canvas(self):
        self.canvas.clear()

class PaintApp(App):
    def build(self):
        parent = BoxLayout(orientation='vertical')
        
        # Zeichenbereich
        self.painter = PaintWidget()
        parent.add_widget(self.painter)
        
        # Button-Leiste
        button_layout = BoxLayout(size_hint_y=None, height=50)
        
        clear_btn = Button(text='Löschen')
        clear_btn.bind(on_press=lambda x: self.painter.clear_canvas())
        
        thin_btn = Button(text='Dünn')
        thin_btn.bind(on_press=lambda x: setattr(self.painter, 'line_width', 1))
        
        thick_btn = Button(text='Dick')
        thick_btn.bind(on_press=lambda x: setattr(self.painter, 'line_width', 5))
        
        button_layout.add_widget(clear_btn)
        button_layout.add_widget(thin_btn)
        button_layout.add_widget(thick_btn)
        
        parent.add_widget(button_layout)
        
        return parent

PaintApp().run()
```

---

## 9. Mobile App Development

### 9.1 Buildozer für Android
```bash
# Buildozer installieren
pip install buildozer

# buildozer.spec Datei erstellen
buildozer init

# Android APK erstellen
buildozer android debug
```

**buildozer.spec Konfiguration**:
```ini
[app]
title = Meine Kivy App
package.name = mykivyapp
package.domain = org.example

version = 0.1
requirements = python3,kivy

[buildozer]
log_level = 2

android.permissions = INTERNET,WRITE_EXTERNAL_STORAGE,CAMERA
android.api = 30
android.minapi = 21
```

### 9.2 iOS Deployment (macOS erforderlich)
```bash
# kivy-ios installieren
pip install kivy-ios

# iOS Projekt erstellen
toolchain build python3 kivy

# Xcode Projekt generieren
toolchain create <title> <app_directory>
```

---

## 10. Performance und Optimization

### 10.1 Touch-Optimierungen
```python
# Touch-Events nur bei Bedarf verarbeiten
class OptimizedWidget(Widget):
    def on_touch_down(self, touch):
        if self.collide_point(*touch.pos):
            # Nur verarbeiten wenn Widget getroffen
            return True
        return False
```

### 10.2 Canvas-Optimierungen
```python
# Canvas-Updates minimieren
from kivy.graphics import PushMatrix, PopMatrix, Translate

with self.canvas:
    PushMatrix()
    Translate(x, y)
    # Zeichenoperationen
    PopMatrix()
```

### 10.3 Memory Management
```python
# Widgets ordnungsgemäß entfernen
def cleanup_widgets(self):
    for widget in self.children[:]:  # Kopie der Liste erstellen
        self.remove_widget(widget)
```

---

## 11. Testing und Debugging

### 11.1 Desktop Testing
```python
# Desktop-Simulation für Mobile
from kivy.config import Config

# Fenstergröße für Mobile simulieren
Config.set('graphics', 'width', '360')
Config.set('graphics', 'height', '640')

# Multi-Touch simulieren
Config.set('input', 'mouse', 'mouse,multitouch_on_demand')
```

### 11.2 Remote Debugging
```python
# Logging für Mobile Apps
import logging

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

def debug_touch(self, touch):
    logger.debug(f'Touch at: {touch.pos}')
```

---

## 12. Best Practices für Mobile

### 12.1 Touch-freundliches Design
- Mindestgröße für Buttons: 44dp x 44dp
- Ausreichend Abstand zwischen interaktiven Elementen
- Große, deutliche Symbole verwenden

### 12.2 Performance-Richtlinien
```python
# Clock für regelmäßige Updates verwenden
from kivy.clock import Clock

def update_ui(dt):
    # UI-Updates hier
    pass

Clock.schedule_interval(update_ui, 1/60.)  # 60 FPS
```

### 12.3 Responsive Layouts
```python
# Responsive Design mit size_hint
layout = BoxLayout(orientation='vertical')

# Header: Feste Höhe
header = Button(text='Header', size_hint_y=None, height='48dp')

# Content: Variable Höhe
content = ScrollView()

# Footer: Feste Höhe  
footer = Button(text='Footer', size_hint_y=None, height='48dp')

layout.add_widget(header)
layout.add_widget(content)
layout.add_widget(footer)
```

---

## 13. Ressourcen und Weiterführendes

### Offizielle Dokumentation
- Kivy Documentation: https://kivy.org/doc/stable/
- KV Language Guide: https://kivy.org/doc/stable/guide/lang.html
- Buildozer Documentation: https://buildozer.readthedocs.io/

### Mobile Development
- Android Permissions: https://developer.android.com/guide/topics/permissions
- iOS Human Interface Guidelines: https://developer.apple.com/design/

### Community und Support
- Kivy Discord: Aktive Community für Hilfe
- GitHub: https://github.com/kivy/kivy
- Stack Overflow: Tag [kivy]

### Erweiterte Themen
- OpenCV Integration für Computer Vision
- SQLite für lokale Datenbanken
- RESTful API Integration
- Push Notifications
- In-App Purchases