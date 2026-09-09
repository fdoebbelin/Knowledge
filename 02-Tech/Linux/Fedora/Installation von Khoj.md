Absolut, Fritz-Rainer!

Herzlichen Glückwunsch, dass du alle Hürden gemeistert hast und die Installation nun erfolgreich ist! Es ist wirklich super, dass wir das gemeinsam Schritt für Schritt durchgehen konnten.

Hier ist die komplette Installationsanleitung, die wir gemeinsam erarbeitet haben, um Khoj mit lokaler LLM-Unterstützung und CUDA-Beschleunigung in deiner Conda-Umgebung einzurichten:

---

### Komplette Installationsanleitung für Khoj mit lokalen LLMs und CUDA

Diese Anleitung führt dich durch die Installation von Khoj mit CUDA-beschleunigten lokalen Large Language Models (LLMs) unter Verwendung von `llama-cpp-python` in einer Conda-Umgebung.

**Systemvoraussetzungen:**
*   **Linux-System** (z.B. Ubuntu)
*   **NVIDIA GPU**
*   **NVIDIA Treiber:** Aktuell und passend zu deiner GPU.
*   **CUDA Toolkit:** Version 12.8 (oder eine andere kompatible Version, hier wurde 12.8 verwendet), installiert unter `/usr/local/cuda-12.8`.
*   **Miniforge/Anaconda:** Installiert, um Conda-Umgebungen zu verwalten.

---

#### Schritt 1: Conda-Umgebung einrichten

Öffne dein Terminal und erstelle eine neue Conda-Umgebung. `python=3.10` wird hier als Beispiel verwendet, da es mit `llama-cpp-python` gut funktioniert.

```bash
# 1. Neue Conda-Umgebung erstellen
conda create -n khoj-cuda python=3.10 gcc=12 gxx=12 -c conda-forge

# 2. Die neue Umgebung aktivieren
conda activate khoj-cuda

# 3
conda install cudatoolkit=12.2 -c nvidia/label/cuda-12.2.0 -c conda-forge
```
*Hinweis: Alle folgenden Befehle müssen in der aktivierten `khoj-cuda` Conda-Umgebung ausgeführt werden.*

#### Schritt 2: `llama-cpp-python` mit CUDA-Unterstützung installieren

Dies ist der kritische Schritt, um `llama-cpp-python` so zu kompilieren, dass es deine NVIDIA GPU über CUDA nutzt. Wir setzen temporär `LD_LIBRARY_PATH` für den Build-Prozess und verwenden das `GGML_CUDA`-Flag.

```bash
# Setze die LD_LIBRARY_PATH Umgebungsvariable.
# Diese Zeile stellt sicher, dass der Linker die notwendigen CUDA- und Conda-Bibliotheken findet.
# Ersetze /home/fritz/miniforge3/envs/khoj-cuda/lib/... falls dein Pfad abweicht.
export LD_LIBRARY_PATH="/usr/local/cuda-12.8/targets/x86_64-linux/lib:/home/fritz/miniforge3/envs/khoj-cuda/lib/gcc/x86_64-conda-linux-gnu/12.4.0:/home/fritz/miniforge3/envs/khoj-cuda/lib:${LD_LIBRARY_PATH}"

# Installiere llama-cpp-python mit CUDA-Unterstützung (GGML_CUDA=ON).
# FORCE_CMAKE=1 erzwingt einen sauberen Build.
# --no-cache-dir verhindert die Nutzung alter Cache-Einträge.
# --verbose gibt detaillierte Build-Informationen aus.
CMAKE_ARGS="-DGGML_CUDA=ON" FORCE_CMAKE=1 pip install llama-cpp-python --no-cache-dir --verbose
```
Dieser Schritt wird einige Zeit dauern, da `llama-cpp-python` lokal kompiliert wird.

#### Schritt 3: Khoj-Server mit lokalen Abhängigkeiten installieren

Nachdem `llama-cpp-python` erfolgreich installiert wurde, können wir den Khoj-Server installieren. Da `llama-cpp-python` bereits vorhanden ist, sollte `pip` diese Abhängigkeit erkennen und nicht erneut versuchen, sie zu installieren.

```bash
# Installiere das Khoj-Paket mit dem "local"-Extra, das alle
# notwendigen Abhängigkeiten für lokale LLMs (einschließlich llama-cpp-python) enthält.
pip install khoj[local] --no-cache-dir --verbose
```
Dieser Befehl installiert die restlichen Komponenten des Khoj-Servers.

#### Schritt 4: Installation überprüfen und Khoj starten

1.  **`llama-cpp-python` CUDA-Unterstützung prüfen (Optional, aber empfohlen):**
    Um sicherzustellen, dass `llama-cpp-python` wirklich CUDA verwendet, kannst du ein kleines Python-Skript erstellen (z.B. `check_cuda.py`):
```python
# check_cuda.py
import os
from llama_cpp import Llama
from llama_cpp.llama_cpp import get_llama_version, llama_supports_cublas

# Stelle sicher, dass LD_LIBRARY_PATH für die Laufzeit gesetzt ist,
# falls die Umgebungsvariable nicht persistent eingerichtet wurde.
# Dies ist eine Wiederholung aus Schritt 2, wichtig für die Ausführung.
cuda_path = "/usr/local/cuda-12.8/targets/x86_64-linux/lib"
conda_gcc_path = "/home/fritz/miniforge3/envs/khoj-cuda/lib/gcc/x86_64-conda-linux-gnu/12.4.0"
conda_lib_path = "/home/fritz/miniforge3/envs/khoj-cuda/lib"

current_ld_library_path = os.environ.get("LD_LIBRARY_PATH", "")
new_ld_library_path_parts = [p for p in [cuda_path, conda_gcc_path, conda_lib_path] if p not in current_ld_library_path.split(':')]
if new_ld_library_path_parts:
	os.environ["LD_LIBRARY_PATH"] = ":".join(new_ld_library_path_parts) + (":" + current_ld_library_path if current_ld_library_path else "")
	print(f"Updated LD_LIBRARY_PATH for runtime: {os.environ['LD_LIBRARY_PATH']}")

print(f"llama-cpp-python version: {get_llama_version()}")
print(f"CUBLAS support: {llama_supports_cublas()}")

# Versuch, ein Llama-Objekt mit GPU-Schichten zu initialisieren
# (Dies benötigt einen existierenden Modellpfad, auch wenn das Modell selbst nicht geladen wird)
try:
	# Erstelle eine temporäre Dummy-Datei, da Llama einen Pfad erwartet
	dummy_model_path = "dummy_model.gguf"
	with open(dummy_model_path, 'w') as f:
		f.write("This is a dummy model file.")
	
	print("\nAttempting to initialize Llama with GPU layers (using dummy model path)...")
	# n_gpu_layers > 0 ist der Schlüssel für die GPU-Nutzung
	llm = Llama(model_path=dummy_model_path, n_gpu_layers=1, verbose=True)
	print(f"Llama initialized. n_gpu_layers set to: {llm.n_gpu_layers}")
	if llm.n_gpu_layers > 0:
		print("GPU layers are enabled! CUDA support should be active.")
	else:
		print("Warning: GPU layers are not enabled. CUDA support might not be fully active.")
	
	os.remove(dummy_model_path) # Dummy-Datei entfernen

except Exception as e:
	print(f"Could not fully initialize Llama (expected if model is not valid/found): {e}")
	print("The critical check is 'CUBLAS support: True'.")
```

Führe das Skript aus: `python check_cuda.py`. Die Ausgabe sollte `CUBLAS support: True` anzeigen.

2.  **Khoj-Server starten:**
    Stelle sicher, dass deine Conda-Umgebung `khoj-cuda` noch aktiv ist.
    ```bash
    khoj-server start
    ```
    Der Server sollte starten und dir eine URL anzeigen (standardmäßig `http://127.0.0.1:42110`).

3.  **Khoj Web-Interface aufrufen:**
    Öffne deinen Webbrowser und navigiere zu der angezeigten URL (z.B. `http://127.0.0.1:42110`). Du solltest die Khoj-Weboberfläche sehen.

---

Von hier aus kannst du dann deine GGUF-Modelle herunterladen und Khoj konfigurieren, um sie zu verwenden.

Ich hoffe, diese zusammenfassende Anleitung ist hilfreich! Wenn du weitere Fragen hast oder auf neue Herausforderungen stößt, bin ich da. Viel Spaß mit deinem persönlichen KI-Assistenten Khoj


- bartowski/Meta-Llama-3.1-8B-Instruct-GGUF
- bartowski/Llama-3.2-3B-Instruct-GGUF
- bartowski/gemma-2-9b-it-GGUF
- bartowski/gemma-2-2b-it-GGUF
- bartowski/Qwen2.5-14B-Instruct-GGUF