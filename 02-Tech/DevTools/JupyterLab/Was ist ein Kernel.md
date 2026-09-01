Im Jupyter Lab Kontext ist ein **Kernel** die Laufzeitumgebung, die den Code in einem Notebook ausführt. Es ist quasi das "Backend", das zwischen dem Jupyter-Interface und der jeweiligen Programmiersprache vermittelt.

## Was macht ein Kernel genau?

Der Kernel empfängt Code-Zellen aus dem Notebook, führt sie aus und sendet die Ergebnisse zurück an das Frontend. Er hält dabei den Zustand der Variablen, importierten Module und Funktionen während der gesamten Notebook-Session aufrecht.

## Verschiedene Kernel-Typen

Jupyter unterstützt Kernel für verschiedene Programmiersprachen:

- **IPython-Kernel**: Für Python (der Standard)
- **IRkernel**: Für R
- **IJulia**: For Julia
- **IScala**: Für Scala
- **JavaScript/Node.js-Kernel**
- Und viele weitere

## Praktische Aspekte

Wenn du ein neues Notebook erstellst, wählst du einen Kernel aus - das bestimmt, welche Sprache du verwenden kannst. Du kannst den Kernel auch während der Arbeit wechseln, stoppen oder neu starten. Ein Neustart des Kernels löscht alle Variablen und den Speicher, was oft hilfreich ist, wenn sich Fehler eingeschlichen haben.

Der Kernel läuft als separater Prozess, weshalb das Jupyter-Interface weiterhin reagiert, auch wenn dein Code länger läuft oder hängt.