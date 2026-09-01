
### **1. Grundlegende Treiber und Software:**

- **NVIDIA-Treiber**: 
	- Installieren Sie den Studio-Treiber von der NVIDIA-Website, die speziell für die RTX 4090 optimiert sind.
    - [NVIDIA Treiber herunterladen](https://www.nvidia.com/Download/index.aspx)
- **NVIDIA CUDA Toolkit**: 
	- Dieses Toolkit ist erforderlich, um die GPU für KI- und Deep-Learning-Anwendungen zu nutzen.
    - vorher muss Microsoft Visual Studio installiert werden
      siehe Punkt 4
    - [CUDA Toolkit herunterladen](https://developer.nvidia.com/cuda-downloads)
- **cuDNN (CUDA Deep Neural Network Library)**: Eine Bibliothek, die für Deep-Learning-Frameworks wie TensorFlow oder PyTorch erforderlich ist.
    
    - [cuDNN herunterladen](https://developer.nvidia.com/cudnn)

---

### **2. Python und Entwicklungsumgebung:**

- **Python installieren**: Die meisten KI-Frameworks basieren auf Python. Laden Sie Python (am besten Version 3.8 oder höher) von der [offiziellen Website](https://www.python.org/) herunter.
- **Virtual Environment einrichten**: Verwenden Sie `conda`, um saubere und isolierte Entwicklungsumgebungen zu erstellen.
        
```bash
scoop install extras/mambaforge
conda init powershell
conda create -n tensorflow
conda activate tensorflow
```
        

---

### **3. KI-Frameworks und Bibliotheken installieren:**

Installieren Sie beliebte KI-Bibliotheken, die GPU-Beschleunigung unterstützen:```
- **TensorFlow**:
	- https://www.tensorflow.org/install/pip
    
```bash
conda create --name tf-env python=3.11
conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0
# Anything above 2.10 is not supported on the GPU on Windows Native
python -m pip install "tensorflow<2.11"
# Verify the installation:
python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

```
    
- **PyTorch**: Installieren Sie PyTorch mit GPU-Unterstützung. Nutzen Sie den Installationsassistenten auf der [offiziellen PyTorch-Seite](https://pytorch.org/).
```powershell
conda deactivate
pip install torch torchvision topythonrchaudio --index-url https://download.pytorch.org/whl/cu126
```

- **PyTorch GPU-Test**:
```python
import torch
print("CUDA verfügbar:", torch.cuda.is_available())
print("CUDA Gerät:", torch.cuda.get_device_name(0))
```
    

- **Weitere nützliche Bibliotheken**:
    
    ```bash
    pip install numpy pandas matplotlib scikit-learn jupyterlab
    ```
    

---

### **4. Zusätzliche Tools und Software:**

- **Docker** (optional): Ermöglicht Ihnen, KI-Anwendungen in Containern auszuführen. NVIDIA bietet den **NVIDIA Container Toolkit** für GPU-Unterstützung an.
    
    - [NVIDIA Container Toolkit](https://developer.nvidia.com/nvidia-container-runtime)
- **Visual Studio**: Einige NVIDIA-Bibliotheken und CUDA-Tools erfordern eine funktionierende Installation von Visual Studio (Community Edition ist ausreichend).
    
    - [Visual Studio herunterladen](https://visualstudio.microsoft.com/)
- **Jupyter Notebook**: Ideal für interaktive KI-Entwicklung.
    
    ```bash
    pip install notebook
    ```
    

---

### **5. Testen der Installation:**

Nach der Einrichtung können Sie die GPU-Leistung testen:

- **CUDA-Installation prüfen**:
    
    ```bash
    nvcc --version
    ```
    
- **TensorFlow GPU-Test**:
    
    ```python
    import tensorflow as tf
    print("GPU verfügbar:", tf.config.list_physical_devices('GPU'))
    ```
    

---

### **6. Optional: KI-Spezifische Software**

Wenn Sie spezielle Anwendungen nutzen wollen, wie Stable Diffusion, AutoGPT oder andere KI-Modelle, benötigen Sie zusätzliche Python-Pakete oder Anwendungen (z. B. Stable Diffusion WebUI).