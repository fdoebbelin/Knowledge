## 1. Installation und Setup

```python
# Installation (im Terminal)
pip install pyside6

# Mit virtueller Umgebung (empfohlen)
python -m venv venv
source venv/bin/activate    # Linux/macOS
venv\Scripts\activate       # Windows

pip install pyside6
```


***

## 2. Das erste Fenster („Hello World“)

```python
import sys
from PySide6.QtWidgets import QApplication, QLabel

app = QApplication(sys.argv)
label = QLabel("Hello World, PySide6!")
label.show()
sys.exit(app.exec())
```


***

## 3. QWidget \& MainWindow

```python
import sys
from PySide6.QtWidgets import QApplication, QWidget

app = QApplication(sys.argv)
window = QWidget()
window.setWindowTitle("Mein erstes Fenster")
window.resize(400, 200)
window.show()
app.exec()
```


***

## 4. QPushButton \& Signals/Slots

```python
import sys
from PySide6.QtWidgets import QApplication, QWidget, QPushButton, QVBoxLayout, QLabel

app = QApplication(sys.argv)

window = QWidget()
window.setWindowTitle("Schaltfläche und Signal/Slot")
layout = QVBoxLayout()

label = QLabel("Noch nicht geklickt")
button = QPushButton("Klick mich!")
button.clicked.connect(lambda: label.setText("Button wurde geklickt!"))

layout.addWidget(label)
layout.addWidget(button)
window.setLayout(layout)
window.show()
app.exec()
```


***

## 5. Weitere Basiselemente (QLineEdit, QCheckBox, QComboBox)

```python
import sys
from PySide6.QtWidgets import QApplication, QWidget, QLineEdit, QCheckBox, QComboBox, QVBoxLayout

app = QApplication(sys.argv)
window = QWidget()
layout = QVBoxLayout()

lineedit = QLineEdit()
checkbox = QCheckBox("Ich stimme zu")
combobox = QComboBox()
combobox.addItems(["Python", "C++", "JavaScript"])

layout.addWidget(lineedit)
layout.addWidget(checkbox)
layout.addWidget(combobox)
window.setLayout(layout)
window.show()
app.exec()
```


***

## 6. Layout-Management: Vertikal, Horizontal, Grid

```python
import sys
from PySide6.QtWidgets import QApplication, QWidget, QVBoxLayout, QHBoxLayout, QGridLayout, QLabel

app = QApplication(sys.argv)
window = QWidget()
main_layout = QVBoxLayout()

# Horizontaler Bereich
h_layout = QHBoxLayout()
h_layout.addWidget(QLabel("A"))
h_layout.addWidget(QLabel("B"))
main_layout.addLayout(h_layout)

# Grid-Bereich
grid = QGridLayout()
grid.addWidget(QLabel("1"), 0, 0)
grid.addWidget(QLabel("2"), 0, 1)
grid.addWidget(QLabel("3"), 1, 0)
grid.addWidget(QLabel("4"), 1, 1)
main_layout.addLayout(grid)

window.setLayout(main_layout)
window.show()
app.exec()
```


***

## 7. Eigene Slots und Signal/Slot Beispiel

```python
import sys
from PySide6.QtWidgets import QApplication, QWidget, QPushButton, QLabel, QVBoxLayout

class MyWidget(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle('Signal und Slot Demo')
        self.label = QLabel('Nicht geklickt')
        self.button = QPushButton('Klick mich!')
        self.button.clicked.connect(self.change_label)
        layout = QVBoxLayout()
        layout.addWidget(self.label)
        layout.addWidget(self.button)
        self.setLayout(layout)
    def change_label(self):
        self.label.setText('Signal ausgelöst!')

app = QApplication(sys.argv)
window = MyWidget()
window.show()
app.exec()
```


***

## 8. Styling mit QSS (Qt Style Sheets)

```python
import sys
from PySide6.QtWidgets import QApplication, QPushButton

app = QApplication(sys.argv)
button = QPushButton("QSS Style")
button.setStyleSheet("""
    QPushButton {
        background-color: #3498db;
        color: white;
        font-size: 18px;
        border-radius: 10px;
        padding: 10px 25px;
    }
    QPushButton:hover {
        background-color: #2980b9;
    }
""")
button.show()
app.exec()
```


***

## 9. Komplexes Beispiel: Tabs \& mehrspaltige Layouts

```python
import sys
from PySide6.QtWidgets import QApplication, QTabWidget, QWidget, QVBoxLayout, QLabel

app = QApplication(sys.argv)
tabs = QTabWidget()

for i in range(1, 4):
    tab = QWidget()
    layout = QVBoxLayout()
    layout.addWidget(QLabel(f"Inhalt von Tab {i}"))
    tab.setLayout(layout)
    tabs.addTab(tab, f"Tab {i}")

tabs.setWindowTitle("PySide6 Tabs Beispiel")
tabs.resize(400, 200)
tabs.show()
app.exec()
```


***

## 10. Eigene Klassen und Signal/Slot mit Parametern

```python
import sys
from PySide6.QtCore import Signal, Slot
from PySide6.QtWidgets import QApplication, QWidget, QPushButton, QLabel, QVBoxLayout

class Communicate(QWidget):
    my_signal = Signal(str)
    def __init__(self):
        super().__init__()
        self.setWindowTitle('Eigene Signale')
        self.button = QPushButton('Sende Signal')
        self.label = QLabel('Noch nichts empfangen')
        self.button.clicked.connect(lambda: self.my_signal.emit('Hallöchen'))
        self.my_signal.connect(self.receive_signal)
        layout = QVBoxLayout()
        layout.addWidget(self.button)
        layout.addWidget(self.label)
        self.setLayout(layout)
    @Slot(str)
    def receive_signal(self, value):
        self.label.setText(f"Empfangen: {value}")

app = QApplication(sys.argv)
window = Communicate()
window.show()
app.exec()
```