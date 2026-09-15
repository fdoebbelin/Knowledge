---
aliases: 
tags:
  - Fachinformatiker/Module/Python
title: 5D1A0 Probleme mit der Version 4.0 beheben
---
Start von der Windows-Oberfläche

```
@echo off
cd %USERPROFILE%\Documents\Python\JupyterLab
wsl bash ./start_jupyter.sh
```

WSL-Seite

```
#!/bin/bash
source ~/miniforge3/bin/activate jupyterlab
jupyter lab --no-browser --ip="0.0.0.0" --allow-root --NotebookApp.token=''
```


Um die Jupyter Server-Konfiguration zu generieren, können Sie folgenden Befehl in Ihrem WSL-Terminal ausführen:

```
jupyter server --generate-config
```

Dieser Befehl erstellt eine Konfigurationsdatei namens `jupyter_server_config.py` im Verzeichnis `~/.jupyter/`.

Nachdem Sie die Konfigurationsdatei generiert haben, können Sie sie bearbeiten, um verschiedene Einstellungen anzupassen. Hier sind einige wichtige Schritte und Anpassungen:

1. Öffnen Sie die Konfigurationsdatei:

   ```
   nano ~/.jupyter/jupyter_server_config.py
   ```

2. Fügen Sie folgende Zeilen hinzu oder ändern Sie sie entsprechend:

   ```python
   import subprocess

   c.ServerApp.use_redirect_file = False
   c.ServerApp.ip = subprocess.check_output(['hostname', '-I'], text=True).strip()
   c.ServerApp.browser = 'wslview'
   ```

   Diese Einstellungen verhindern, dass Jupyter versucht, eine temporäre HTML-Datei zu öffnen, setzen die korrekte IP-Adresse und verwenden `wslview` als Browser.

3. Speichern Sie die Datei und schließen Sie den Editor.

4. Stellen Sie sicher, dass `wslu` installiert ist:

   ```
   sudo apt install wslu
   ```

5. Setzen Sie die BROWSER-Umgebungsvariable:

   ```
   echo 'export BROWSER=wslview' >> ~/.bashrc
   source ~/.bashrc
   ```

Mit diesen Anpassungen sollte Jupyter Server nun korrekt funktionieren und den Windows-Standardbrowser verwenden, wenn Sie Jupyter Notebook oder Jupyter Lab starten.

Beachten Sie, dass die Verwendung von `jupyter server --generate-config` die neuere Methode ist, die `jupyter notebook --generate-config` ersetzt. Sie bietet eine einheitlichere Konfiguration für verschiedene Jupyter-Anwendungen.

Der Hauptunterschied zwischen ServerApp und NotebookApp in der Jupyter-Konfiguration liegt in der Entwicklung und Aufteilung der Jupyter-Komponenten:

1. Historische Entwicklung:
   - NotebookApp war ursprünglich Teil des Jupyter Notebook-Pakets und enthielt sowohl Server- als auch Frontend-Funktionalitäten[1].
   - ServerApp wurde als Teil von Jupyter Server eingeführt, um die Server-Komponente von der Frontend-Komponente zu trennen[1].

2. Verwendungszweck:
   - ServerApp dient als Basis-Server für verschiedene Jupyter-Frontends wie Jupyter Notebook, JupyterLab und andere[1].
   - NotebookApp ist spezifisch für das klassische Jupyter Notebook-Interface[1].

3. Konfiguration:
   - Viele Optionen wurden von c.NotebookApp zu c.ServerApp umbenannt[3].
   - Die Konfigurationsdatei sollte von jupyter_notebook_config.py zu jupyter_server_config.py umbenannt werden[3].

4. Kompatibilität:
   - Neuere Versionen von Jupyter Notebook (ab Version 7.0) und JupyterLab verwenden ServerApp[1].
   - Ältere Versionen von Jupyter Notebook verwenden noch NotebookApp[1].

5. Erweiterungen:
   - ServerApp-basierte Konfigurationen verwenden jupyter server extension statt jupyter serverextension[1].

6. Startbefehle:
   - jupyter notebook verwendet in älteren Versionen noch NotebookApp[2].
   - jupyter lab und jupyter nbclassic verwenden ServerApp[2].

Um von NotebookApp zu ServerApp zu migrieren:
- Benennen Sie Ihre Konfigurationsdatei um[3].
- Ändern Sie alle c.NotebookApp-Einträge zu c.ServerApp[3].
- Aktualisieren Sie Ihre Erweiterungen und Konfigurationspfade entsprechend[1].

Diese Änderung wurde vorgenommen, um die Wartbarkeit zu verbessern und eine flexiblere Infrastruktur für verschiedene Jupyter-Frontends zu schaffen[1].

Citations:
[1] https://stackoverflow.com/questions/67797152/what-is-the-difference-between-jupyter-notebook-and-jupyter-server/67804732
[2] https://discourse.jupyter.org/t/difference-in-arguments-between-jupyter-notebook-and-jupyter-lab/11179
[3] https://jupyter-server.readthedocs.io/en/latest/operators/migrate-from-nbserver.html
[4] https://github.com/jupyter-server/jupyter_server/issues/434