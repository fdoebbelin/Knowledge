### 1. Einfaches CUDA-Testprogramm selbst schreiben

Erstelle eine Datei namens `test.cu` mit folgendem Inhalt:


```cpp
#include <stdio.h>
__global__ void helloFromGPU(void) {
     printf("Hello World from GPU!\n");
} 
int main(void) {
	printf("Hello World from CPU!\n");
	helloFromGPU<<<1, 1>>>();
	cudaDeviceSynchronize();
    return 0;
}
```


Kompiliere das Programm mit `nvcc`:

`nvcc test.cu -o test`

Führe das Programm aus:

`./test`

**Erwartete Ausgabe:**

`Hello World from CPU! Hello World from GPU!`

Falls du diese Ausgabe siehst, funktioniert CUDA korrekt auf deinem System.

---

### 2. CUDA-Beispiele von NVIDIA herunterladen

Falls du die offiziellen CUDA-Beispiele nutzen möchtest, kannst du sie direkt von der NVIDIA-Website herunterladen:

1. Lade die CUDA-Samples von der [NVIDIA-Website](https://developer.nvidia.com/cuda-downloads) herunter (unter "CUDA Toolkit Documentation" findest du die Samples).
2. Entpacke das Archiv und wechsle in das Verzeichnis `1_Utilities/deviceQuery`.
3. Führe `make` aus und starte das Programm mit `./deviceQuery`.

---

### 3. Alternative: `deviceQuery` aus dem CUDA-SDK manuell kompilieren

Falls du den Quellcode von `deviceQuery` nicht herunterladen möchtest, kannst du auch direkt ein anderes Beispiel aus dem Netz verwenden oder auf die offizielle NVIDIA-Dokumentation zurückgreifen.

---

### Zusammenfassung

- **Einfaches Testprogramm:** Schreibe und kompiliere ein kleines CUDA-Programm, um die Installation zu prüfen.
- **Offizielle Beispiele:** Lade die CUDA-Samples von NVIDIA herunter und kompiliere sie manuell.

Falls du weitere Fragen hast oder auf Fehler stößt, lass es mich wissen!