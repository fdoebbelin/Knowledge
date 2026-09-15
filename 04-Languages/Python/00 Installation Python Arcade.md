## Neue Conda-Umgebung erstellen
```bash
conda create -n arcade-env python=3.13
```
## Aktivieren der Umgebung
```bash
conda activate arcade-env
```
## Arcade installieren

```bash
pip install arcade
```

## Funktionstest

Starte Python und gib ein:

```python
import arcade
arcade.open_window(600, 400, "Testfenster")
arcade.run()
```

Ein leeres Fenster sollte erscheinen.
## Beispiele herunterladen

Arcade bietet offizielle Beispielprojekte auf GitHub:

```bash
git clone https://github.com/pythonarcade/arcade.git
```
Beispiele befinden sich im Ordner:

```
arcade/examples/
```

## Beispiel starten

Wechsle in den Beispielordner:

```bash
cd arcade/examples
python start_arcade_example.py
```

Du kannst auch direkt ein bestimmtes Beispiel ausführen:

```bash
python drawing_primitives.py
```

## Jupyter Notebook in der Umgebung

Wenn du mit Jupyter arbeiten willst:

```bash
conda install jupyter
```

Oder:

```bash
pip install notebook
```

Dann kannst du Arcade-Notebooks ebenfalls erstellen oder in bestehende integrieren (funktioniert am besten mit `%gui tk` oder externem Fenster).