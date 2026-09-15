# Tauri 2.0 App mit Rust Frontend in Zed - Entwicklungsguide

## 1. Projekt-Setup mit Tauri 2.0 und Rust Frontend

**Neues Tauri 2.0-Projekt mit Rust Frontend erstellen:**

```bash
# Neues Projekt erstellen
cargo create-tauri-app tauri-app
✔ Identifier · com.fritz.tauri-app
✔ Choose which language to use for your frontend · Rust - (cargo)
✔ Choose your UI template · Leptos - (https://leptos.dev/)

Template created!

Your system is missing dependencies (or they do not exist in $PATH):
╭───────────────┬────────────────────────────────────────────────╮
│ Trunk         │ Run `cargo install trunk --locked`             │
├───────────────┼────────────────────────────────────────────────┤
│ wasm32 target │ Run `rustup target add wasm32-unknown-unknown` │
╰───────────────┴────────────────────────────────────────────────╯

Make sure you have installed the prerequisites for your OS: https://tauri.app/start/prerequisites/, then run:
  cd tauri-app
  cargo tauri android init

For Desktop development, run:
  cargo tauri dev

For Android development, run:
  cargo tauri android dev
```

**Cargo.toml für Rust Frontend (Leptos - empfohlen für Tauri 2.0):**

```toml
[dependencies]
leptos = { version = "0.6", features = ["csr"] }
leptos_dom = "0.6"
wasm-bindgen = "0.2"
web-sys = "0.3"
console_error_panic_hook = "0.1"
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"

[dependencies.tauri]
version = "2.0"
features = ["rustls-tls"]
```

## 2. Zed-Konfiguration für Tauri 2.0

Erstelle eine `.zed/settings.json` in deinem Projekt-Root:

```bash
# Verzeichnis erstellen
mkdir -p .zed

# JSON-Datei erstellen
cat > .zed/settings.json << 'EOF'
{
  "languages": {
    "Rust": {
      "tab_size": 4,
      "format_on_save": "on",
      "formatter": "language_server",
      "hard_tabs": false
    }
  },
  "lsp": {
    "rust-analyzer": {
      "initialization_options": {
        "cargo": {
          "buildScripts": {
            "enable": true
          },
          "features": "all",
          "allTargets": true
        },
        "procMacro": {
          "enable": true,
          "attributes": {
            "enable": true
          }
        },
        "diagnostics": {
          "enable": true,
          "enableExperimental": true
        },
        "checkOnSave": {
          "command": "cargo",
          "args": ["check", "--workspace", "--message-format=json", "--all-targets"]
        },
        "rustfmt": {
          "overrideCommand": ["cargo", "fmt", "--"]
        }
      }
    }
  },
  "terminal": {
    "working_directory": "current_project_directory"
  },
  "project_panel": {
    "button": true,
    "default_width": 280
  }
}
EOF
```

## 3. Projekt-Struktur für Tauri 2.0

```
my-tauri-app/
├── src-tauri/              # Tauri 2.0 Backend
│   ├── src/
│   │   ├── main.rs
│   │   ├── commands.rs
│   │   └── lib.rs
│   ├── Cargo.toml
│   ├── tauri.conf.json
│   └── capabilities/       # Neu in Tauri 2.0
│       └── default.json
├── frontend/               # Rust Frontend (Leptos)
│   ├── src/
│   │   ├── main.rs
│   │   ├── app.rs
│   │   └── components/
│   ├── Cargo.toml
│   ├── index.html
│   └── Trunk.toml
├── shared/                 # Geteilte Rust-Typen
│   ├── src/
│   │   ├── lib.rs
│   │   └── types.rs
│   └── Cargo.toml
└── Cargo.toml             # Workspace
```

## 4. Workspace Cargo.toml für Tauri 2.0

```toml
[workspace]
members = [
    "src-tauri",
    "frontend", 
    "shared"
]
resolver = "2"

[workspace.dependencies]
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
tokio = { version = "1.0", features = ["full"] }
tauri = { version = "2.0", features = ["rustls-tls"] }
leptos = { version = "0.6", features = ["csr"] }
```

## 5. Tauri 2.0 Entwicklungs-Workflow

**Alle Befehle über Cargo:**

```bash
# Frontend entwickeln (mit Trunk)
rustup target add wasm32-unknown-unknown
cargo install trunk
cargo trunk serve --config frontend/Trunk.toml

# Tauri 2.0 App entwickeln
cargo tauri dev

# Mit spezifischen Features
cargo tauri dev --features "custom-protocol"

# Vollständiger Build
cargo tauri build

# Release Build
cargo tauri build --release

# Frontend separat builden
cargo trunk build --config frontend/Trunk.toml --release

# Tauri 2.0 spezifische Befehle
cargo tauri info
cargo tauri icon
cargo tauri signer generate

# Tests ausführen
cargo test --workspace

# Workspace prüfen
cargo check --workspace --all-targets

# Formatierung und Linting
cargo fmt --all
cargo clippy --workspace --all-targets -- -D warnings
```

## 6. Tauri 2.0 Konfiguration

**tauri.conf.json:**

```json
{
  "$schema": "https://schema.tauri.app/config/2.0.0",
  "productName": "my-tauri-app",
  "version": "0.1.0",
  "build": {
    "frontendDist": "../frontend/dist",
    "beforeBuildCommand": "cargo trunk build --config frontend/Trunk.toml --release",
    "beforeDevCommand": "cargo trunk serve --config frontend/Trunk.toml"
  },
  "app": {
    "withGlobalTauri": false,
    "windows": [
      {
        "title": "My Tauri 2.0 App",
        "width": 800,
        "height": 600,
        "resizable": true,
        "fullscreen": false
      }
    ],
    "security": {
      "csp": "default-src 'self' 'unsafe-inline' 'unsafe-eval'; img-src 'self' data: https:;"
    }
  },
  "bundle": {
    "active": true,
    "targets": "all",
    "identifier": "com.example.my-tauri-app",
    "publisher": "Your Name",
    "icon": [
      "icons/32x32.png",
      "icons/128x128.png",
      "icons/128x128@2x.png",
      "icons/icon.icns",
      "icons/icon.ico"
    ]
  },
  "plugins": {
    "updater": {
      "active": true
    }
  }
}
```

**Capabilities (Neu in Tauri 2.0) - src-tauri/capabilities/default.json:**

```json
{
  "$schema": "https://schema.tauri.app/config/2.0.0/capability.json",
  "identifier": "default",
  "description": "Default capabilities for the app",
  "windows": ["main"],
  "permissions": [
    "core:default",
    "shell:allow-open",
    "dialog:allow-open",
    "dialog:allow-save",
    "fs:allow-read-file",
    "fs:allow-write-file",
    "fs:allow-read-dir",
    "fs:allow-create-dir"
  ]
}
```

## 7. Leptos Frontend Beispiel für Tauri 2.0

**frontend/src/main.rs:**

```rust
use leptos::*;
use wasm_bindgen::prelude::*;

#[component]
fn App() -> impl IntoView {
    let (count, set_count) = create_signal(0);
    let (name, set_name) = create_signal(String::new());
    let (greet_message, set_greet_message) = create_signal(String::new());

    let on_click = move |_| set_count.update(|count| *count += 1);
    
    let greet = move |_| {
        spawn_local(async move {
            let result = invoke_greet(name.get()).await;
            set_greet_message.set(result);
        });
    };

    view! {
        <main class="container">
            <h1>"Tauri 2.0 + Leptos App"</h1>
            
            <div class="row">
                <button on:click=on_click>
                    "Clicked " {count} " times"
                </button>
            </div>

            <div class="row">
                <input
                    type="text"
                    placeholder="Enter your name..."
                    on:input=move |ev| {
                        set_name.set(event_target_value(&ev));
                    }
                />
                <button on:click=greet>"Greet"</button>
            </div>

            <p class="greet-message">{greet_message}</p>
        </main>
    }
}

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = ["window", "__TAURI__", "core"])]
    async fn invoke(cmd: &str, args: JsValue) -> JsValue;
}

async fn invoke_greet(name: String) -> String {
    let args = serde_wasm_bindgen::to_value(&serde_json::json!({ "name": name })).unwrap();
    let result = invoke("greet", args).await;
    serde_wasm_bindgen::from_value(result).unwrap_or_else(|_| "Error".to_string())
}

fn main() {
    console_error_panic_hook::set_once();
    mount_to_body(|| view! { <App/> })
}
```

## 8. Tauri 2.0 Commands

**src-tauri/src/lib.rs:**

```rust
use serde::{Deserialize, Serialize};
use shared::types::AppData;

#[derive(Debug, Serialize, Deserialize)]
pub struct GreetResponse {
    pub message: String,
    pub timestamp: u64,
}

#[tauri::command]
pub async fn greet(name: String) -> Result<String, String> {
    if name.is_empty() {
        return Err("Name cannot be empty".to_string());
    }
    
    Ok(format!("Hello {}! Greetings from Tauri 2.0 backend!", name))
}

#[tauri::command]
pub async fn get_app_data() -> Result<AppData, String> {
    Ok(AppData::new())
}

#[tauri::command]
pub async fn save_data(data: AppData) -> Result<bool, String> {
    // Implementiere Datenspeicherung
    println!("Saving data: {:?}", data);
    Ok(true)
}
```

**src-tauri/src/main.rs:**

```rust
// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use my_tauri_app::{greet, get_app_data, save_data};

fn main() {
    tauri::Builder::default()
        .plugin(tauri_plugin_shell::init())
        .plugin(tauri_plugin_dialog::init())
        .plugin(tauri_plugin_fs::init())
        .invoke_handler(tauri::generate_handler![greet, get_app_data, save_data])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
```

## 9. Zed Tasks für Tauri 2.0

**Erstelle `.zed/tasks.json`:**

```json
{
  "tasks": [
    {
      "label": "Tauri Dev",
      "command": "cargo",
      "args": ["tauri", "dev"],
      "group": "build",
      "use_new_terminal": true
    },
    {
      "label": "Tauri Build Release",
      "command": "cargo", 
      "args": ["tauri", "build", "--release"],
      "group": "build"
    },
    {
      "label": "Frontend Dev",
      "command": "cargo",
      "args": ["trunk", "serve", "--config", "frontend/Trunk.toml", "--port", "3000"],
      "group": "build",
      "use_new_terminal": true
    },
    {
      "label": "Test Workspace",
      "command": "cargo",
      "args": ["test", "--workspace", "--all-targets"],
      "group": "test"
    },
    {
      "label": "Check All",
      "command": "cargo",
      "args": ["check", "--workspace", "--all-targets"],
      "group": "build"
    },
    {
      "label": "Clippy All",
      "command": "cargo",
      "args": ["clippy", "--workspace", "--all-targets", "--", "-D", "warnings"],
      "group": "build"
    }
  ]
}
```

## 10. Trunk.toml für Frontend

**frontend/Trunk.toml:**

```toml
[build]
target = "index.html"
dist = "dist"
public_url = "/"

[watch]
ignore = [
    "dist",
    "target"
]

[serve]
address = "127.0.0.1"
port = 3000
open = false
```

## 11. Shared Types

**shared/src/types.rs:**

```rust
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AppData {
    pub id: String,
    pub name: String,
    pub created_at: u64,
    pub data: Vec<DataItem>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DataItem {
    pub key: String,
    pub value: String,
}

impl AppData {
    pub fn new() -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
            name: "Default App".to_string(),
            created_at: chrono::Utc::now().timestamp() as u64,
            data: vec![],
        }
    }
}
```

## 12. Debugging und Logging in Tauri 2.0

**Cargo.toml Abhängigkeiten für Logging:**

```toml
[dependencies]
tracing = "0.1"
tracing-subscriber = "0.3"
```

**Logging Setup:**

```rust
// In main.rs
use tracing_subscriber;

fn main() {
    tracing_subscriber::fmt::init();
    
    tauri::Builder::default()
        // ... rest of setup
}
```

**Browser DevTools für Frontend:**

```rust
// In frontend/src/main.rs für Debug-Logs
#[cfg(debug_assertions)]
web_sys::console::log_1(&"Debug mode enabled".into());
```

Diese Konfiguration ist speziell für Tauri 2.0 optimiert und nutzt die neuen Features wie das Capabilities-System und verbesserte Plugin-Architektur.