## 1. Tauri-Projekt mit Cargo anlegen

```bash
cargo install create-tauri-app --locked
cargo create-tauri-app
```

- Dadurch entstehen:
    - Das Haupt-Rustprojekt im Verzeichnis
    - Das Verzeichnis `src-tauri/` mit Tauri-Konfiguration und Ressourcen

***

### 2. JupyterLite/uv Buildumgebung einrichten

```bash
rm -rf src
mkdir src
cd src
uv init --bare
uv add --dev jupyterlite-core jupyterlite-pyodide-kernel
```

- Die Dateien `pyproject.toml`, `uv.lock` und `.venv/` entstehen
- Weitere Konfiguration für JupyterLite in `jupyterlite.json` anlegen

***

### 3. JupyterLite-Assets bauen

```bash
uv run jupyter lite build
```

- Es wird ein Verzeichnis `src/_output/` mit allen Web-Assets erzeugt

***
### 4. Tauri-Konfiguration anpassen

- In `src-tauri/tauri.conf.json` sicherstellen, dass als Einstiegspunkt im WebView auf
`src/_output/index.html` verwiesen wird.

```json
"build": {
    "frontendDist": "../src/_output
  },
```


***

### 5. Entwicklung und Starten der Desktop-App

```bash
cargo tauri dev
```

- Die App öffnet ein Desktop-Fenster mit eingebetteter JupyterLite-Oberfläche, Python läuft dort via Pyodide im Browser-Kontext.

***

### 6. Änderungen, Updates \& Build

- Bei Änderungen in JupyterLite:
    - Im `src` Verzeichnis neu bauen (`uv run jupyter lite build`)
- Für einen Release-Build:

```bash
cargo tauri build
```
***

### Zusammenfassung

- Zuerst mit Cargo das Rust/Tauri-Projekt anlegen und initialisieren.
- Dann in einem separaten Verzeichnis JupyterLite/uv-Setup durchführen und die Webassets erzeugen.
- Die fertigen JupyterLite-Dateien ins Tauri-Projekt kopieren.
- Alles weitere steuert Tauri/Rust ausschließlich über Cargo, und Python-Komponenten werden nur über uv verwaltet.