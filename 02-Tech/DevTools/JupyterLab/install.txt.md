## Installation
```PowerShell
scoop install main/sudo
sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
scoop install extras/mambaforge
conda init powershell
conda create -n jupyterlab -c conda-forge jupytext ipywidgets jupyterlab-blockly jupyterlab jupyterlab-lsp python-lsp-server
conda activate jupyterlab
mkdir $HOME\Documents\JupyterLab
cd $HOME\Documents\JupyterLab
jupyter lab
```
## jupyterlab.bat

```Powershell
@echo off

powershell -Command "& {Start-Process powershell -ArgumentList '-NoExit', '-Command', 'conda activate jupyterlab; cd $HOME\Documents\JupyterLab; jupyter lab'}"
```
