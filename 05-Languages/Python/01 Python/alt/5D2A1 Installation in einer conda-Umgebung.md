---
aliases: 
tags:
  - Fachinformatiker/Module/Python
title: 5D2A1 Installation in einer conda-Umgebung
---

## Einrichtung und Start von JupyterLab

Diese Befehle dienen zur Einrichtung und zum Start von JupyterLab in einer Conda-Umgebung:

```powershell
conda init powershell  
conda create -n jupyterlab -c conda-forge jupytext ipywidgets jupyterlab-blockly jupyterlab  
conda activate jupyterlab  
mkdir $HOME\Documents\JupyterLab  
cd $HOME\Documents\JupyterLab  
jupyter lab
```

### Beschreibung:

1. Initialisiert Conda für PowerShell
2. Erstellt eine neue Conda-Umgebung namens "jupyterlab" mit den erforderlichen Paketen
3. Aktiviert die erstellte Conda-Umgebung
4. Wechselt in das Python-Dokumentenverzeichnis
5. Startet JupyterLab

## Automatisierter Start von JupyterLab (JupyterLab.bat)

Diese Befehle sollten in eine Datei namens "JupyterLab.bat" gespeichert werden:

```batch
@echo off
powershell -Command "& {Start-Process powershell -ArgumentList '-NoExit', '-Command', 'conda activate jupyterlab; cd $HOME\Documents\JupyterLab; jupyter lab'}"
```

### Beschreibung:

Diese Batch-Datei startet PowerShell und führt folgende Aktionen aus:

1. Aktiviert die Conda-Umgebung "`jupyterlab`"
2. Wechselt in das `JupyterLab`-Dokumentenverzeichnis
3. Startet `JupyterLab`

Die Batch-Datei ermöglicht einen schnellen und einfachen Start von `JupyterLab` mit einem Doppelklick.
