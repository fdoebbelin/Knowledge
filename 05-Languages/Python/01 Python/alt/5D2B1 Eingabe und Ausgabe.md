---
aliases: 
tags: 
title: 5D2B1 Eingabe und Ausgabe
---

## Ein- und Ausgabe über die Konsole

Nutzung der eingebauten Python-Funktionen
  

```python
name = input('Wie heißen Sie? ')
print(f'Hallo, {name}!')
```

```markdown
Wie heißen Sie?  fritz
Hallo, fritz!
```

## Ein- und Ausgabe mit Widgets

Mit `ipywidgets` können Sie interaktive Eingabefelder erstellen

```python
import ipywidgets as widgets
from IPython.display import display

text_input = widgets.Text(description='Eingabe:')
output = widgets.Output()

def on_text_change(change):
    with output:
        output.clear_output()
        print(f"Sie haben eingegeben: {change['new']}")

text_input.observe(on_text_change, names='value')
display(text_input, output)
```

