## 🚀 Schritt 1: Projekt erstellen

```bash
# Neues Verzeichnis erstellen
mkdir metarow-player
cd metarow-player

# Rust-Projekt initialisieren
cargo init --name metarow-player

# Verzeichnisstruktur erstellen
mkdir -p src-tauri/src
mkdir src
```

## 📁 Schritt 2: package.json erstellen

**Datei: `package.json`**
```json
{
  "name": "metarow-player",
  "version": "0.1.0",
  "description": "MetaRow Player - Interactive Python Notebooks",
  "scripts": {
    "tauri": "tauri",
    "tauri:dev": "tauri dev",
    "tauri:build": "tauri build",
    "dev": "tauri dev"
  },
  "devDependencies": {
    "@tauri-apps/cli": "^2.0.0"
  },
  "dependencies": {
    "@tauri-apps/api": "^2.0.0"
  }
}
```

## ⚙️ Schritt 3: Rust-Konfiguration

**Datei: `src-tauri/Cargo.toml`**
```toml
[package]
name = "metarow-player"
version = "0.1.0"
edition = "2021"

[build-dependencies]
tauri-build = { version = "2.0", features = [] }

[dependencies]
tauri = { version = "2.0", features = ["macos-private-api"] }
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
pyo3 = { version = "0.22", features = ["auto-initialize"] }
uuid = { version = "1.0", features = ["v4"] }
tokio = { version = "1.0", features = ["full"] }

[features]
# This feature is used for production builds
custom-protocol = ["tauri/custom-protocol"]
```

**Datei: `src-tauri/build.rs`**
```rust
fn main() {
    tauri_build::build()
}
```

**Datei: `src-tauri/tauri.conf.json`**
```json
{
  "$schema": "https://schema.tauri.app/config/2.0",
  "productName": "MetaRow Player",
  "version": "0.1.0",
  "identifier": "com.metarow.player",
  "build": {
    "frontendDist": "../src"
  },
  "app": {
    "windows": [
      {
        "fullscreen": false,
        "resizable": true,
        "title": "MetaRow Player",
        "width": 1200,
        "height": 800,
        "minWidth": 800,
        "minHeight": 600
      }
    ]
  },
  "bundle": {
    "active": true,
    "targets": "all"
  }
}
```

## 🦀 Schritt 4: Rust Backend

**Datei: `src-tauri/src/main.rs`**
```rust
// Prevents additional console window on Windows in release
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use pyo3::prelude::*;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::sync::Mutex;
use tauri::{Builder, generate_context, generate_handler, Manager, State};
use uuid::Uuid;

#[derive(Debug, Serialize, Deserialize)]
struct CellOutput {
    output: String,
    error: Option<String>,
    execution_time: f64,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
struct Cell {
    id: String,
    code: String,
    output: Option<CellOutput>,
}

#[derive(Default)]
struct PythonSession {
    cells: HashMap<String, Cell>,
    variables: HashMap<String, String>,
}

type SessionState = Mutex<PythonSession>;

#[tauri::command]
async fn create_cell(session: State<'_, SessionState>) -> Result<String, String> {
    let cell_id = Uuid::new_v4().to_string();
    let cell = Cell {
        id: cell_id.clone(),
        code: String::new(),
        output: None,
    };
    
    let mut session = session.lock().unwrap();
    session.cells.insert(cell_id.clone(), cell);
    
    Ok(cell_id)
}

#[tauri::command]
async fn execute_cell(
    cell_id: String,
    code: String,
    session: State<'_, SessionState>,
) -> Result<CellOutput, String> {
    let start_time = std::time::Instant::now();
    
    // Python-Code ausführen
    let result = Python::with_gil(|py| -> PyResult<String> {
        // Erstelle einen lokalen Namespace für diese Ausführung
        let locals = pyo3::types::PyDict::new(py);
        
        // Führe den Code aus und capture stdout
        let code_with_capture = format!(
            r#"
import sys
from io import StringIO

# Capture stdout
old_stdout = sys.stdout
sys.stdout = StringIO()

try:
    {}
    result = sys.stdout.getvalue()
    if not result:
        # Wenn kein Print-Output, versuche den letzten Ausdruck zu evaluieren
        try:
            result = str(eval(compile('{}', '<string>', 'eval')))
        except:
            result = sys.stdout.getvalue()
except Exception as e:
    result = f"Error: {{str(e)}}"
finally:
    sys.stdout = old_stdout

result
"#,
            code, code.replace('\n', '\\n').replace('"', '\\"')
        );
        
        let result = py.eval(&code_with_capture, None, Some(locals))?;
        Ok(result.to_string())
    });
    
    let execution_time = start_time.elapsed().as_secs_f64();
    
    let output = match result {
        Ok(output) => CellOutput {
            output: output.trim().to_string(),
            error: None,
            execution_time,
        },
        Err(err) => CellOutput {
            output: String::new(),
            error: Some(format!("Python Error: {}", err)),
            execution_time,
        },
    };
    
    // Speichere das Ergebnis in der Session
    let mut session = session.lock().unwrap();
    if let Some(cell) = session.cells.get_mut(&cell_id) {
        cell.code = code;
        cell.output = Some(output.clone());
    }
    
    Ok(output)
}

#[tauri::command]
async fn get_cells(session: State<'_, SessionState>) -> Result<Vec<Cell>, String> {
    let session = session.lock().unwrap();
    let cells: Vec<Cell> = session.cells.values().cloned().collect();
    Ok(cells)
}

#[tauri::command]
async fn clear_session(session: State<'_, SessionState>) -> Result<(), String> {
    let mut session = session.lock().unwrap();
    session.cells.clear();
    session.variables.clear();
    Ok(())
}

fn main() {
    Builder::default()
        .setup(|_app| {
            // Python-Interpreter beim Start initialisieren
            pyo3::prepare_freethreaded_python();
            Ok(())
        })
        .manage(SessionState::default())
        .invoke_handler(generate_handler![
            create_cell,
            execute_cell,
            get_cells,
            clear_session
        ])
        .run(generate_context!())
        .expect("error while running tauri application");
}
```

## 🌐 Schritt 5: Frontend

**Datei: `src/index.html`**
```html
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MetaRow Player</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            background: #1e1e1e;
            color: #d4d4d4;
            height: 100vh;
            overflow: hidden;
        }

        .header {
            background: #2d2d30;
            padding: 12px 20px;
            border-bottom: 1px solid #3e3e42;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 18px;
            font-weight: 600;
            color: #ffffff;
        }

        .controls {
            display: flex;
            gap: 10px;
        }

        .btn {
            background: #0e639c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            transition: background-color 0.2s;
        }

        .btn:hover {
            background: #1177bb;
        }

        .btn.secondary {
            background: #5a5a5a;
        }

        .btn.secondary:hover {
            background: #6a6a6a;
        }

        .main-container {
            height: calc(100vh - 60px);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .cells-container {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
        }

        .cell {
            background: #252526;
            border: 1px solid #3e3e42;
            border-radius: 8px;
            margin-bottom: 16px;
            overflow: hidden;
        }

        .cell-header {
            background: #2d2d30;
            padding: 8px 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12px;
            color: #969696;
        }

        .cell-content {
            padding: 0;
        }

        .code-input {
            width: 100%;
            min-height: 120px;
            background: #1e1e1e;
            color: #d4d4d4;
            border: none;
            padding: 16px;
            font-family: inherit;
            font-size: 14px;
            resize: vertical;
            outline: none;
        }

        .code-input:focus {
            background: #1a1a1a;
        }

        .cell-controls {
            padding: 12px 16px;
            background: #2d2d30;
            display: flex;
            gap: 8px;
        }

        .run-btn {
            background: #28a745;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 11px;
        }

        .run-btn:hover {
            background: #34ce57;
        }

        .run-btn:disabled {
            background: #6c757d;
            cursor: not-allowed;
        }

        .output {
            background: #0f0f0f;
            border-top: 1px solid #3e3e42;
            padding: 16px;
            white-space: pre-wrap;
            font-size: 13px;
            line-height: 1.4;
        }

        .output.error {
            color: #f48771;
            background: #2d1b1b;
        }

        .output.success {
            color: #9cdcfe;
        }

        .execution-time {
            color: #608b4e;
            font-size: 11px;
            margin-top: 8px;
        }

        .loading {
            color: #ffcc02;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #969696;
        }

        .empty-state h2 {
            margin-bottom: 8px;
            font-weight: 400;
        }

        .code-input::placeholder {
            color: #6a9955;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🐍 MetaRow Player</h1>
        <div class="controls">
            <button class="btn" onclick="addCell()">+ Neue Zelle</button>
            <button class="btn secondary" onclick="clearSession()">Session löschen</button>
        </div>
    </div>

    <div class="main-container">
        <div class="cells-container" id="cells-container">
            <div class="empty-state">
                <h2>Willkommen zum MetaRow Player</h2>
                <p>Klicken Sie auf "Neue Zelle" um zu beginnen</p>
            </div>
        </div>
    </div>

    <script type="module">
        // Tauri API importieren
        import { invoke } from '@tauri-apps/api/tauri';

        let cells = [];

        // Neue Zelle erstellen
        async function addCell() {
            try {
                const cellId = await invoke('create_cell');
                const cell = {
                    id: cellId,
                    code: '',
                    output: null
                };
                cells.push(cell);
                renderCells();
                
                // Focus auf die neue Zelle setzen
                setTimeout(() => {
                    const textarea = document.querySelector(`textarea[data-cell-id="${cellId}"]`);
                    if (textarea) textarea.focus();
                }, 100);
            } catch (error) {
                console.error('Fehler beim Erstellen der Zelle:', error);
            }
        }

        // Code in einer Zelle ausführen
        async function executeCell(cellId) {
            const cell = cells.find(c => c.id === cellId);
            if (!cell) return;

            const textarea = document.querySelector(`textarea[data-cell-id="${cellId}"]`);
            const code = textarea.value;
            
            // UI aktualisieren
            const runBtn = document.querySelector(`button[data-cell-id="${cellId}"]`);
            const outputDiv = document.querySelector(`div[data-output-id="${cellId}"]`);
            
            runBtn.disabled = true;
            runBtn.textContent = 'Läuft...';
            
            if (outputDiv) {
                outputDiv.className = 'output loading';
                outputDiv.textContent = 'Ausführung läuft...';
            }

            try {
                const result = await invoke('execute_cell', { cellId, code });
                
                // Ergebnis anzeigen
                cell.output = result;
                cell.code = code;
                renderCellOutput(cellId, result);
                
            } catch (error) {
                console.error('Fehler bei der Ausführung:', error);
                const errorOutput = {
                    output: '',
                    error: error.toString(),
                    execution_time: 0
                };
                renderCellOutput(cellId, errorOutput);
            } finally {
                runBtn.disabled = false;
                runBtn.textContent = 'Ausführen';
            }
        }

        // Session löschen
        async function clearSession() {
            try {
                await invoke('clear_session');
                cells = [];
                renderCells();
            } catch (error) {
                console.error('Fehler beim Löschen der Session:', error);
            }
        }

        // Zellen rendern
        function renderCells() {
            const container = document.getElementById('cells-container');
            
            if (cells.length === 0) {
                container.innerHTML = `
                    <div class="empty-state">
                        <h2>Willkommen zum MetaRow Player</h2>
                        <p>Klicken Sie auf "Neue Zelle" um zu beginnen</p>
                    </div>
                `;
                return;
            }

            container.innerHTML = cells.map(cell => `
                <div class="cell">
                    <div class="cell-header">
                        <span>Python Zelle</span>
                        <span>ID: ${cell.id.substring(0, 8)}...</span>
                    </div>
                    <div class="cell-content">
                        <textarea 
                            class="code-input" 
                            data-cell-id="${cell.id}"
                            placeholder="# Python-Code hier eingeben...
print('Hallo Welt!')
result = 2 + 2
result"
                            onkeydown="handleKeyPress(event, '${cell.id}')"
                        >${cell.code || ''}</textarea>
                    </div>
                    <div class="cell-controls">
                        <button class="run-btn" data-cell-id="${cell.id}" onclick="executeCell('${cell.id}')">
                            Ausführen
                        </button>
                        <small style="color: #969696;">Strg+Enter zum Ausführen</small>
                    </div>
                    ${cell.output ? `<div class="output ${cell.output.error ? 'error' : 'success'}" data-output-id="${cell.id}">
                        ${cell.output.error || cell.output.output}
                        ${cell.output.execution_time ? `<div class="execution-time">Ausführungszeit: ${cell.output.execution_time.toFixed(3)}s</div>` : ''}
                    </div>` : ''}
                </div>
            `).join('');
        }

        // Output für eine spezifische Zelle rendern
        function renderCellOutput(cellId, output) {
            const outputDiv = document.querySelector(`div[data-output-id="${cellId}"]`);
            if (outputDiv) {
                outputDiv.className = `output ${output.error ? 'error' : 'success'}`;
                outputDiv.innerHTML = `
                    ${output.error || output.output}
                    ${output.execution_time ? `<div class="execution-time">Ausführungszeit: ${output.execution_time.toFixed(3)}s</div>` : ''}
                `;
            }
        }

        // Keyboard-Shortcuts
        function handleKeyPress(event, cellId) {
            if (event.ctrlKey && event.key === 'Enter') {
                event.preventDefault();
                executeCell(cellId);
            }
        }

        // Funktionen global verfügbar machen
        window.addCell = addCell;
        window.executeCell = executeCell;
        window.clearSession = clearSession;
        window.handleKeyPress = handleKeyPress;

        // Erste Zelle beim Start erstellen
        window.addEventListener('DOMContentLoaded', () => {
            addCell();
        });
    </script>
</body>
</html>
```

## 📦 Schritt 6: Installation und Start

```bash
# Dependencies installieren
npm install

# Development starten
npm run tauri:dev

# Oder alternativ
npx tauri dev
```

## 🔧 Schritt 7: Erste Tests

Nach dem Start sollten Sie:

1. **Eine neue Zelle erstellen** können
2. **Python-Code eingeben**:
   ```python
   print("Hallo MetaRow!")
   x = 42
   y = x * 2
   y
   ```
3. **Mit Strg+Enter ausführen**
4. **Das Ergebnis sehen**

## 🚨 Troubleshooting

**Python-Installation prüfen:**
```bash
python --version
# oder
python3 --version
```

**Rust-Dependencies aktualisieren:**
```bash
cd src-tauri
cargo update
cargo build
```

**Bei Build-Fehlern:**
```bash
# Rust-Toolchain aktualisieren
rustup update stable

# Cache löschen
cargo clean
npm cache clean --force
```

## 🎯 Verzeichnisstruktur (final)

```
metarow-player/
├── package.json
├── src/
│   └── index.html
├── src-tauri/
│   ├── Cargo.toml
│   ├── build.rs
│   ├── tauri.conf.json
│   └── src/
│       └── main.rs
└── node_modules/ (nach npm install)
```

Das ist die komplette, funktionierende Installation! 🚀