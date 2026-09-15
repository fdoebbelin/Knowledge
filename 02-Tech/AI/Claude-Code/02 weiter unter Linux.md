Der Code ist bereits Linux-kompatibel — die Shebang-Zeile (#!/usr/bin/env python3) ist schon drin. Ich passe nur noch
  die Anleitung an.

  Wenn du auf der Linux-Maschine bist, dann:

  # Projekt-Verzeichnis anlegen
 
```nu
mkdir ~/projects/auto-filename
cd ~/projects/auto-filename
python -m venv venv
sh -c "source venv/bin/activate && nu" 
```

  # Dateien sind: `auto_filename.py` + `requirements.txt`

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

---
## Ollama einrichten
### 1. Prüfen, ob der Ollama-Dienst läuft

Im Terminal:

```bash
systemctl status ollama
```

Wenn alles korrekt ist, siehst du etwas wie:

> Active: active (running)

Falls nicht:

```bash
sudo systemctl enable --now ollama
```
### 2. Prüfen, ob Ollama erreichbar ist

```bash
ollama --version
```

und:

```bash
ollama list
```

Wenn keine Fehlermeldung kommt, läuft Ollama grundsätzlich.
### 3. Modell llama3.1:8b herunterladen

Falls noch nicht vorhanden:

```bash
ollama pull llama3.1:8b
```

Das kann je nach Internet/GPU etwas dauern.

Danach prüfen:

```bash
ollama list
```

Du solltest sehen:

```
llama3.1:8b
```
### 4. Modell testen (interaktiv)

Starte das Modell:

```bash
ollama run llama3.1:8b
```

Wenn alles klappt, erscheint z.B.:

```
>>> 
```

Dann kannst du schreiben:

```text
Hallo, kannst du mich hören?
```

Antwortet das Modell → ✅ funktioniert.

Beenden mit:

```
/bye
```

oder `Ctrl+D`
### 5. Test per Einzeiler (ohne Chat)

Zum schnellen Test:

```bash
ollama run llama3.1:8b "Erkläre mir kurz, was Linux ist."
```

Wenn eine Antwort kommt → alles korrekt eingerichtet.
### 6. Prüfen, ob GPU genutzt wird (optional, wichtig für Performance)

### NVIDIA:

```bash
nvidia-smi
nvitop
```

Während `Ollama` läuft, sollte dort Aktivität sichtbar sein.

---
## Vibe-Coding Session fortsetzen
  Melde dich, wenn die Linux-Maschine steht — dann machen wir weiter.

Resume this session with:

```
claude --resume e6384b5e-f458-4cb5-8fe9-e33b20ca56ce
```
