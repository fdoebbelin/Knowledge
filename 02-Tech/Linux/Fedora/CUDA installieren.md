Um CUDA in CatchyOS zu installieren, kannst du wie folgt vorgehen:

### 1. CUDA-Paket installieren

CatchyOS bietet CUDA direkt über die Paketquellen an. Installiere CUDA mit dem folgenden Befehl im Terminal:

`sudo pacman -S cuda`

Dies installiert das aktuelle CUDA-Toolkit, das in den CachyOS-Repositories verfügbar ist.

### 2. Umgebungsvariablen setzen

Damit CUDA korrekt funktioniert, musst du die Umgebungsvariablen setzen. Füge folgende Zeilen zu deiner `~/.bashrc` oder `~/.zshrc` hinzu (je nachdem, welche Shell du verwendest):

`echo 'export PATH=/opt/cuda/bin:$PATH' >> ~/.bashrc echo 'export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc`

Lade die Änderungen mit folgendem Befehl neu:

`source ~/.bashrc`

### 3. Installation überprüfen

- Prüfe, ob CUDA erkannt wird, mit:
    
    `nvcc --version`
    
    Dieser Befehl sollte die installierte CUDA-Version anzeigen.
    
- Überprüfe mit `nvidia-smi`, ob die CUDA-Version auch im NVIDIA-Systemmanagement-Interface angezeigt wird:
    
    `nvidia-smi`
    
    Hier sollte unter "CUDA Version" die installierte Version stehen.
    

### 4. Optional: cuDNN installieren (für KI-Frameworks)

Falls du cuDNN für TensorFlow, PyTorch oder andere KI-Frameworks benötigst, kannst du es ebenfalls über die Paketquellen installieren:

`sudo pacman -S cudnn`

### 5. Systemneustart

Starte dein System neu, um sicherzustellen, dass alle Änderungen übernommen werden.

### 6. Testen der Installation

Du kannst die Installation mit einem einfachen CUDA-Beispiel testen. Die CUDA-Beispiele findest du unter `/opt/cuda/samples`. Wechsle in das Verzeichnis und kompiliere eines der Beispiele, z.B.:

`cd /opt/cuda/samples/1_Utilities/deviceQuery sudo make ./deviceQuery`

Wenn die Ausgabe "Result = PASS" enthält, ist CUDA korrekt installiert und einsatzbereit.

### Wichtig

- Stelle sicher, dass der proprietäre NVIDIA-Treiber installiert ist, bevor du CUDA installierst. Falls nicht, installiere ihn mit:
    
    `sudo pacman -S linux-cachyos-nvidia`
    
- Falls du Probleme hast, prüfe, ob der NVIDIA-Treiber geladen ist und die Grafikkarte erkannt wird (`lspci | grep -i nvidia`).

Falls du weitere Fragen hast oder auf Probleme stößt, lass es mich wissen!