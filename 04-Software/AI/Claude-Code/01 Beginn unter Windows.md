Claude Code lässt sich nativ auf Linux installieren. Du brauchst nur Node.js ≥ 18:

  # Node.js installieren (falls noch nicht vorhanden)
  
```
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
  sudo apt install -y nodejs

```

  # Claude Code installieren
  
```
sudo npm install -g @anthropic-ai/claude-code
```


  # Starten
  
```
claude
```


  Das war's — funktioniert auf jeder gängigen Linux-Distribution (Ubuntu, Debian, Fedora, Arch, etc.).


● Der Code ist bereits Linux-kompatibel — die Shebang-Zeile (#!/usr/bin/env python3) ist schon drin. Ich passe nur noch
  die Anleitung an.

  Wenn du auf der Linux-Maschine bist, dann:

  # Projekt-Verzeichnis anlegen
  
```
mkdir -p /home/fritz/auto-filename
  cd /home/fritz/auto-filename

```

  # Dateien sind: auto_filename.py + requirements.txt

  # Abhängigkeiten installieren
 
```
 pip install -r requirements.txt
```


  # Skript ausführbar machen

```
  chmod +x auto_filename.py
```


  # Testen (Ollama muss laufen)
  
```
./auto_filename.py --dry-run test.pdf
```


  Melde dich, wenn die Linux-Maschine steht — dann machen wir weiter.

❯ so, ich bin jetzt auf der linux maschine, lass uns weitermachen