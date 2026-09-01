## 1. Neues Projekt mit uv anlegen

```powershell
uv init jupyterlite-p5-demo
cd jupyterlite-p5-demo
```


## 2. p5-Kernel und JupyterLite installieren

```powershell
uv add jupyterlite
uv add jupyterlite-p5-kernel
```

### 3. JupyterLite-Seite bauen

```powershell
uv run jupyter lite build
```

Dadurch wird im lokalen Projektordner eine JupyterLite-Site generiert, die alle installierten Kernels enthält.

### 4. Lokale Instanz starten

```powershell
uv run jupyter lite serve
```

Öffne danach im Browser `http://localhost:8000`. Du kannst dort im Notebook-Interface den p5-Kernel als Kernel auswählen und direkt nutzen.