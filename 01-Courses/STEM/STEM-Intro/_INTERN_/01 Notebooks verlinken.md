## Vorgehensweise
- In einer `Markdown`-Zelle kannst du einen Link zum gewünschten Notebook einfügen:
```
[Titel des Notebooks](Pfad/zum/Notebook.ipynb)
```

Beispiel:
```
[MINTlab Einführung](./Einsteigerkurs.ipynb)
```

- Wenn du den Link anklickst, öffnet `JupyterLab` das verlinkte Notebook automatisch in einem neuen Tab.
### Hinweise
- Die Pfadangabe ist relativ zum jeweiligen Arbeitsverzeichnis des Notebooks.
- Das Notebook muss im gleichen Workspace verfügbar sein, damit der Link funktioniert.

Direktes „öffnen“ per Python-Befehl ist im Standard-Workflow nicht vorgesehen; der `Markdown`-Link ist die bewährte Methode für Kursnavigation und Inhaltsverweise zwischen Notebooks.