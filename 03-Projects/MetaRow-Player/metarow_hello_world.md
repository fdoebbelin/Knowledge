# MetaRow Player - Hello World Setup mit Dioxus 🚀

## 🎯 Was wir bauen: Ein interaktives Notebook

- ✅ **Markdown-Zellen** mit Live-Rendering
- ✅ **Python-Code-Zellen** mit Execution
- ✅ **Interaktive Widgets** (Slider, Buttons)
- ✅ **Web + Desktop** aus einer Codebasis
- ✅ **Hot-Reload** für Live-Development

## 🛠 Schritt 1: System-Vorbereitung

### Python installieren (falls nicht vorhanden)
```bash
# Windows (über Chocolatey)
choco install python

# macOS (über Homebrew)
brew install python

# Linux (Ubuntu/Debian)
sudo apt update && sudo apt install python3 python3-pip

# Verifizieren
python --version  # oder python3 --version
```

### Rust installieren
```bash
# Rust Toolchain installieren
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Aktualisieren
rustup update stable

# Verifizieren
rustc --version
cargo --version
```

### Dioxus CLI installieren
```bash
# Optimierte Installation mit cargo-binstall
cargo install cargo-binstall
cargo binstall dioxus-cli

# Oder klassisch (dauert länger)
# cargo install dioxus-cli

# Verifizieren
dx --version
```

## 🚀 Schritt 2: Projekt erstellen

```bash
# Neues Dioxus-Projekt erstellen
dx new metarow-hello-world
cd metarow-hello-world

# Projekt-Struktur anzeigen
tree . -I target
```

## 📦 Schritt 3: Dependencies konfigurieren

### Cargo.toml erweitern
```toml
[package]
name = "metarow-hello-world"
version = "0.1.0"
edition = "2021"

[dependencies]
# Dioxus Core
dioxus = { version = "0.7", features = ["desktop", "web"] }
dioxus-logger = "0.5"

# Python Integration
pyo3 = { version = "0.22", features = ["auto-initialize"] }

# Markdown Processing
pulldown-cmark = "0.12"

# Utilities
serde = { version = "1.0", features = ["derive"] }
uuid = { version = "1.0", features = ["v4"] }
tokio = { version = "1.0", features = ["full"] }

# For syntax highlighting (optional)
syntect = "5.1"

[features]
default = ["desktop"]
desktop = ["dioxus/desktop"]
web = ["dioxus/web"]
```

### Dioxus.toml konfigurieren
```toml
[application]
name = "MetaRow Hello World"
default_platform = "desktop"

[web.app]
title = "MetaRow Hello World"

[desktop.app]
title = "MetaRow Hello World"

[web.watcher]
watch_path = ["src", "assets"]
reload_html = true

# Hot reload für bessere DX
[serve]
addr = "127.0.0.1:8080"
```

## 💻 Schritt 4: Haupt-Application Code

### src/main.rs
```rust
#![allow(non_snake_case)]

use dioxus::prelude::*;
use pyo3::prelude::*;
use pulldown_cmark::{Parser, Options, html};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use uuid::Uuid;

// ============================================================================
// Data Structures
// ============================================================================

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum CellType {
    Markdown,
    Python,
    Interactive,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct CellOutput {
    pub output: String,
    pub error: Option<String>,
    pub execution_time: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Cell {
    pub id: String,
    pub cell_type: CellType,
    pub content: String,
    pub output: Option<CellOutput>,
}

// ============================================================================
// Main Application
// ============================================================================

fn main() {
    // Logger für Debugging
    dioxus_logger::init(log::LevelFilter::Info).expect("failed to init logger");
    
    // Python-Interpreter initialisieren
    pyo3::prepare_freethreaded_python();
    
    console_error_panic_hook::set_once();
    
    dioxus::launch(App);
}

#[component]
fn App() -> Element {
    // Application State
    let mut cells = use_signal(|| create_initial_notebook());
    let mut selected_cell = use_signal(|| None::<String>);
    
    rsx! {
        div { class: "min-h-screen bg-slate-900 text-white font-mono",
            
            // Header
            Header {
                on_add_cell: move |cell_type: CellType| {
                    let new_cell = create_cell(cell_type);
                    let cell_id = new_cell.id.clone();
                    cells.write().push(new_cell);
                    selected_cell.set(Some(cell_id));
                },
                on_clear: move |_| {
                    cells.set(create_initial_notebook());
                    selected_cell.set(None);
                }
            }
            
            // Main Content Area
            main { class: "container mx-auto px-4 py-6",
                div { class: "max-w-4xl mx-auto space-y-6",
                    
                    // Welcome Message
                    if cells.read().len() <= 3 {
                        WelcomeCard {}
                    }
                    
                    // Notebook Cells
                    for (index, cell) in cells.read().iter().enumerate() {
                        NotebookCell {
                            key: "{cell.id}",
                            cell: cell.clone(),
                            is_selected: selected_cell() == Some(cell.id.clone()),
                            on_select: move |cell_id: String| selected_cell.set(Some(cell_id)),
                            on_update: move |updated_cell: Cell| {
                                cells.write()[index] = updated_cell;
                            },
                            on_delete: move |cell_id: String| {
                                cells.write().retain(|c| c.id != cell_id);
                                if selected_cell() == Some(cell_id) {
                                    selected_cell.set(None);
                                }
                            }
                        }
                    }
                    
                    // Add Cell Quick Actions
                    QuickAddPanel {
                        on_add: move |cell_type: CellType| {
                            let new_cell = create_cell(cell_type);
                            cells.write().push(new_cell);
                        }
                    }
                }
            }
        }
    }
}

// ============================================================================
// Components
// ============================================================================

#[component]
fn Header(
    on_add_cell: EventHandler<CellType>,
    on_clear: EventHandler<()>
) -> Element {
    rsx! {
        header { class: "bg-slate-800 border-b border-slate-700 sticky top-0 z-10",
            div { class: "container mx-auto px-4 py-4",
                div { class: "flex items-center justify-between",
                    // Logo & Title
                    div { class: "flex items-center space-x-3",
                        div { class: "text-2xl", "🐍" }
                        div {
                            h1 { class: "text-xl font-bold text-blue-400", "MetaRow Player" }
                            p { class: "text-sm text-slate-400", "Interactive Markdown + Python" }
                        }
                    }
                    
                    // Actions
                    div { class: "flex items-center space-x-3",
                        button {
                            class: "px-4 py-2 bg-blue-600 hover:bg-blue-700 rounded-lg text-sm transition-colors flex items-center space-x-2",
                            onclick: move |_| on_add_cell.call(CellType::Markdown),
                            span { "📝" }
                            span { "Markdown" }
                        }
                        
                        button {
                            class: "px-4 py-2 bg-green-600 hover:bg-green-700 rounded-lg text-sm transition-colors flex items-center space-x-2",
                            onclick: move |_| on_add_cell.call(CellType::Python),
                            span { "🐍" }
                            span { "Python" }
                        }
                        
                        button {
                            class: "px-4 py-2 bg-purple-600 hover:bg-purple-700 rounded-lg text-sm transition-colors flex items-center space-x-2",
                            onclick: move |_| on_add_cell.call(CellType::Interactive),
                            span { "🎛️" }
                            span { "Widget" }
                        }
                        
                        button {
                            class: "px-3 py-2 bg-slate-600 hover:bg-slate-700 rounded-lg text-sm transition-colors",
                            onclick: move |_| on_clear.call(()),
                            "🗑️"
                        }
                    }
                }
            }
        }
    }
}

#[component]
fn WelcomeCard() -> Element {
    rsx! {
        div { class: "bg-gradient-to-r from-blue-900/30 to-purple-900/30 rounded-xl p-8 border border-slate-700",
            div { class: "text-center",
                h2 { class: "text-3xl font-bold mb-4 bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent",
                    "Willkommen zum MetaRow Player! 🎉"
                }
                p { class: "text-slate-300 mb-6 max-w-2xl mx-auto leading-relaxed",
                    "Erstellen Sie interaktive Notebooks mit Markdown-Dokumentation, "
                    "ausführbarem Python-Code und interaktiven Widgets. "
                    "Perfekt für Datenanalyse, Prototyping und Documentation."
                }
                
                div { class: "grid grid-cols-1 md:grid-cols-3 gap-4 mt-8",
                    FeatureCard {
                        icon: "📝",
                        title: "Rich Markdown",
                        description: "Schreiben Sie dokumentation mit voller Markdown-Unterstützung"
                    }
                    FeatureCard {
                        icon: "🐍",
                        title: "Live Python",
                        description: "Führen Sie Python-Code direkt aus und sehen Sie Ergebnisse"
                    }
                    FeatureCard {
                        icon: "🎛️",
                        title: "Interaktive Widgets",
                        description: "Erstellen Sie Slider, Buttons und andere UI-Elemente"
                    }
                }
            }
        }
    }
}

#[component]
fn FeatureCard(icon: String, title: String, description: String) -> Element {
    rsx! {
        div { class: "bg-slate-800/50 rounded-lg p-4 border border-slate-600",
            div { class: "text-2xl mb-2", "{icon}" }
            h3 { class: "font-semibold text-blue-300 mb-1", "{title}" }
            p { class: "text-sm text-slate-400", "{description}" }
        }
    }
}

#[component]
fn NotebookCell(
    cell: Cell,
    is_selected: bool,
    on_select: EventHandler<String>,
    on_update: EventHandler<Cell>,
    on_delete: EventHandler<String>
) -> Element {
    let border_class = if is_selected {
        "border-blue-500 shadow-lg shadow-blue-500/20"
    } else {
        "border-slate-600 hover:border-slate-500"
    };
    
    rsx! {
        div { 
            class: "bg-slate-800 rounded-xl border-2 transition-all duration-200 {border_class}",
            onclick: move |_| on_select.call(cell.id.clone()),
            
            // Cell Header
            div { class: "flex items-center justify-between p-4 border-b border-slate-700",
                div { class: "flex items-center space-x-3",
                    span { class: "text-lg",
                        match cell.cell_type {
                            CellType::Markdown => "📝",
                            CellType::Python => "🐍", 
                            CellType::Interactive => "🎛️",
                        }
                    }
                    span { class: "text-sm font-medium text-slate-300",
                        match cell.cell_type {
                            CellType::Markdown => "Markdown Cell",
                            CellType::Python => "Python Cell",
                            CellType::Interactive => "Interactive Widget",
                        }
                    }
                    span { class: "text-xs text-slate-500", "ID: {&cell.id[..8]}..." }
                }
                
                button {
                    class: "text-slate-400 hover:text-red-400 transition-colors p-1",
                    onclick: move |evt| {
                        evt.stop_propagation();
                        on_delete.call(cell.id.clone());
                    },
                    "🗑️"
                }
            }
            
            // Cell Content
            match cell.cell_type {
                CellType::Markdown => rsx! {
                    MarkdownCell { cell: cell.clone(), on_update }
                },
                CellType::Python => rsx! {
                    PythonCell { cell: cell.clone(), on_update }
                },
                CellType::Interactive => rsx! {
                    InteractiveCell { cell: cell.clone(), on_update }
                }
            }
        }
    }
}

#[component]
fn MarkdownCell(cell: Cell, on_update: EventHandler<Cell>) -> Element {
    let mut is_editing = use_signal(|| cell.content.is_empty());
    let mut content = use_signal(|| cell.content.clone());
    
    let rendered_html = use_memo(move || {
        if content().is_empty() {
            return String::new();
        }
        
        let mut options = Options::empty();
        options.insert(Options::ENABLE_STRIKETHROUGH);
        options.insert(Options::ENABLE_TABLES);
        options.insert(Options::ENABLE_FOOTNOTES);
        
        let parser = Parser::new_ext(&content(), options);
        let mut html_output = String::new();
        html::push_html(&mut html_output, parser);
        html_output
    });
    
    let save_content = move || {
        let updated_cell = Cell {
            content: content(),
            ..cell.clone()
        };
        on_update.call(updated_cell);
        is_editing.set(false);
    };
    
    rsx! {
        div { class: "p-4",
            if is_editing() {
                div { class: "space-y-3",
                    textarea {
                        class: "w-full h-40 bg-slate-900 text-slate-100 border border-slate-600 rounded-lg p-3 resize-y focus:outline-none focus:border-blue-500",
                        placeholder: "# Hello World!\n\nSchreiben Sie hier Ihr **Markdown**:\n\n- Liste\n- Mit Items\n- Und mehr\n\n```python\nprint('Code-Blöcke werden auch unterstützt!')\n```",
                        value: "{content}",
                        oninput: move |evt| content.set(evt.value()),
                        onkeydown: move |evt| {
                            if evt.modifiers().ctrl() && evt.key() == Key::Enter {
                                save_content();
                            }
                        }
                    }
                    
                    div { class: "flex justify-between items-center",
                        span { class: "text-xs text-slate-400", "Strg+Enter zum Speichern" }
                        div { class: "space-x-2",
                            button {
                                class: "px-3 py-1 bg-blue-600 hover:bg-blue-700 rounded text-sm transition-colors",
                                onclick: move |_| save_content(),
                                "💾 Speichern"
                            }
                            button {
                                class: "px-3 py-1 bg-slate-600 hover:bg-slate-700 rounded text-sm transition-colors",
                                onclick: move |_| {
                                    is_editing.set(false);
                                    content.set(cell.content.clone());
                                },
                                "❌ Abbrechen"
                            }
                        }
                    }
                }
            } else {
                div { 
                    class: "min-h-20 cursor-pointer",
                    onclick: move |_| is_editing.set(true),
                    
                    if rendered_html().is_empty() {
                        div { class: "text-slate-400 italic p-8 text-center border-2 border-dashed border-slate-600 rounded-lg",
                            "Klicken Sie hier um Markdown hinzuzufügen..."
                        }
                    } else {
                        div { 
                            class: "prose prose-invert prose-blue max-w-none",
                            dangerous_inner_html: "{rendered_html}"
                        }
                    }
                }
            }
        }
    }
}

#[component]
fn PythonCell(cell: Cell, on_update: EventHandler<Cell>) -> Element {
    let mut code = use_signal(|| cell.content.clone());
    let mut output = use_signal(|| cell.output.clone());
    let mut is_executing = use_signal(|| false);
    
    let execute_code = move |_| {
        let current_code = code();
        if current_code.trim().is_empty() {
            return;
        }
        
        let cell_id = cell.id.clone();
        let mut is_executing_clone = is_executing.clone();
        let mut output_clone = output.clone();
        let on_update_clone = on_update.clone();
        let cell_clone = cell.clone();
        
        spawn(async move {
            is_executing_clone.set(true);
            
            let start_time = std::time::Instant::now();
            let result = execute_python_code(&current_code).await;
            let execution_time = start_time.elapsed().as_secs_f64();
            
            let cell_output = match result {
                Ok(output_text) => CellOutput {
                    output: output_text,
                    error: None,
                    execution_time,
                },
                Err(error) => CellOutput {
                    output: String::new(),
                    error: Some(error),
                    execution_time,
                }
            };
            
            output_clone.set(Some(cell_output.clone()));
            is_executing_clone.set(false);
            
            // Update parent
            let updated_cell = Cell {
                content: current_code,
                output: Some(cell_output),
                ..cell_clone
            };
            on_update_clone.call(updated_cell);
        });
    };
    
    rsx! {
        div { class: "space-y-4",
            // Code Input
            div { class: "p-4",
                textarea {
                    class: "w-full h-32 bg-slate-900 text-green-400 font-mono border border-slate-600 rounded-lg p-3 resize-y focus:outline-none focus:border-green-500",
                    placeholder: "# Python-Code hier eingeben...\nprint('Hallo MetaRow World! 🌍')\n\n# Beispiele:\nimport math\nresult = math.sqrt(42)\nprint(f'Wurzel aus 42 = {result:.2f}')\n\n# Matplotlib funktioniert auch!\n# import matplotlib.pyplot as plt\n# plt.plot([1,2,3], [1,4,9])\n# plt.show()",
                    value: "{code}",
                    oninput: move |evt| code.set(evt.value()),
                    onkeydown: move |evt| {
                        if evt.modifiers().ctrl() && evt.key() == Key::Enter {
                            execute_code.call(());
                        }
                    }
                }
            }
            
            // Controls
            div { class: "px-4 pb-4 flex items-center justify-between",
                div { class: "flex items-center space-x-3",
                    button {
                        class: if is_executing() {
                            "bg-slate-500 cursor-not-allowed"
                        } else {
                            "bg-green-600 hover:bg-green-700"
                        }.to_string() + " px-4 py-2 rounded-lg text-sm transition-colors flex items-center space-x-2",
                        disabled: is_executing(),
                        onclick: execute_code,
                        
                        span {
                            if is_executing() { "⏳" } else { "▶️" }
                        }
                        span {
                            if is_executing() { "Läuft..." } else { "Ausführen" }
                        }
                    }
                    
                    span { class: "text-xs text-slate-400", "Strg+Enter zum Ausführen" }
                }
                
                if let Some(cell_output) = output() {
                    span { class: "text-xs text-green-400",
                        "⚡ {cell_output.execution_time:.3}s"
                    }
                }
            }
            
            // Output
            if let Some(cell_output) = output() {
                div { class: "border-t border-slate-600",
                    div {
                        class: if cell_output.error.is_some() {
                            "bg-red-900/20 text-red-300 border-l-4 border-red-500"
                        } else {
                            "bg-slate-900/50 text-cyan-300 border-l-4 border-green-500"
                        },
                        class: "p-4 font-mono text-sm whitespace-pre-wrap",
                        
                        if let Some(error) = &cell_output.error {
                            div {
                                div { class: "font-semibold text-red-400 mb-2", "❌ Python Fehler:" }
                                "{error}"
                            }
                        } else if !cell_output.output.is_empty() {
                            div {
                                div { class: "font-semibold text-green-400 mb-2", "✅ Ausgabe:" }
                                "{cell_output.output}"
                            }
                        } else {
                            div { class: "text-slate-400 italic", "Keine Ausgabe (Code wurde erfolgreich ausgeführt)" }
                        }
                    }
                }
            }
        }
    }
}

#[component] 
fn InteractiveCell(cell: Cell, on_update: EventHandler<Cell>) -> Element {
    let mut slider_value = use_signal(|| 50.0);
    let mut counter = use_signal(|| 0);
    let mut text_input = use_signal(|| String::from("Hello World"));
    
    rsx! {
        div { class: "p-6 space-y-6",
            h3 { class: "text-lg font-semibold text-purple-400 mb-4", "🎛️ Interactive Widgets Demo" }
            
            // Slider Widget
            div { class: "bg-slate-900/50 rounded-lg p-4 border border-slate-600",
                h4 { class: "font-medium text-purple-300 mb-3", "Slider Control" }
                div { class: "space-y-3",
                    div { class: "flex items-center space-x-4",
                        input {
                            r#type: "range",
                            class: "flex-1 h-2 bg-slate-700 rounded-lg appearance-none cursor-pointer",
                            min: "0",
                            max: "100",
                            step: "1",
                            value: "{slider_value}",
                            oninput: move |evt| {
                                if let Ok(v) = evt.value().parse::<f64>() {
                                    slider_value.set(v);
                                }
                            }
                        }
                        span { class: "text-purple-300 font-mono min-w-16", "{slider_value:.0}" }
                    }
                    div { class: "text-sm text-slate-400",
                        "Aktueller Wert: {slider_value:.0} • Quadrat: {(slider_value() * slider_value()):.0}"
                    }
                }
            }
            
            // Counter Widget
            div { class: "bg-slate-900/50 rounded-lg p-4 border border-slate-600",
                h4 { class: "font-medium text-purple-300 mb-3", "Counter Control" }
                div { class: "flex items-center space-x-4",
                    button {
                        class: "bg-red-600 hover:bg-red-700 px-4 py-2 rounded-lg transition-colors",
                        onclick: move |_| counter.set(counter() - 1),
                        "➖"
                    }
                    span { class: "text-2xl font-mono text-purple-300 min-w-16 text-center", "{counter}" }
                    button {
                        class: "bg-green-600 hover:bg-green-700 px-4 py-2 rounded-lg transition-colors",
                        onclick: move |_| counter.set(counter() + 1),
                        "➕"
                    }
                }
            }
            
            // Text Input Widget
            div { class: "bg-slate-900/50 rounded-lg p-4 border border-slate-600",
                h4 { class: "font-medium text-purple-300 mb-3", "Text Input" }
                div { class: "space-y-3",
                    input {
                        r#type: "text",
                        class: "w-full bg-slate-800 text-white border border-slate-600 rounded-lg px-3 py-2 focus:outline-none focus:border-purple-500",
                        placeholder: "Geben Sie Text ein...",
                        value: "{text_input}",
                        oninput: move |evt| text_input.set(evt.value())
                    }
                    div { class: "text-sm text-slate-400",
                        "Zeichen: {text_input().len()} • Wörter: {text_input().split_whitespace().count()}"
                    }
                    if !text_input().is_empty() {
                        div { class: "bg-slate-800 p-3 rounded border border-slate-600",
                            span { class: "text-purple-300", "Echo: " }
                            span { class: "text-white", "{text_input()}" }
                        }
                    }
                }
            }
            
            // Combined Widget Demo
            div { class: "bg-gradient-to-r from-purple-900/30 to-blue-900/30 rounded-lg p-4 border border-purple-500/50",
                h4 { class: "font-medium text-purple-300 mb-3", "🎨 Live Visualization" }
                div { class: "text-center",
                    div {
                        class: "inline-block bg-purple-600 text-white px-6 py-3 rounded-lg transform transition-all duration-300",
                        style: "transform: scale({(slider_value() / 100.0) + 0.5})",
                        "Counter: {counter} | Scale: {slider_value:.0}%"
                    }
                    div { class: "mt-3 text-sm text-slate-400",
                        "Dieser Block skaliert mit dem Slider-Wert!"
                    }
                }
            }
        }
    }
}

#[component]
fn QuickAddPanel(on_add: EventHandler<CellType>) -> Element {
    rsx! {
        div { class: "bg-slate-800/50 rounded-xl border-2 border-dashed border-slate-600 p-8 text-center",
            h3 { class: "text-lg font-medium text-slate-300 mb-4", "Neue Zelle hinzufügen" }
            div { class: "flex justify-center space-x-4",
                button {
                    class: "flex flex-col items-center space-y-2 bg-blue-600/20 hover:bg-blue-600/40 border border-blue-600/50 rounded-lg p-4 transition-colors",
                    onclick: move |_| on_add.call(CellType::Markdown),
                    span { class: "text-2xl", "📝" }
                    span { class: "text-sm font-medium", "Markdown" }
                }
                button {
                    class: "flex flex-col items-center space-y-2 bg-green-600/20 hover:bg-green-600/40 border border-green-600/50 rounded-lg p-4 transition-colors",
                    onclick: move |_| on_add.call(CellType::Python),
                    span { class: "text-2xl", "🐍" }
                    span { class: "text-sm font-medium", "Python" }
                }
                button {
                    class: "flex flex-col items-center space-y-2 bg-purple-600/20 hover:bg-purple-600/40 border border-purple-600/50 rounded-lg p-4 transition-colors",
                    onclick: move |_| on_add.call(CellType::Interactive),
                    span { class: "text-2xl", "🎛️" }
                    span { class: "text-sm font-medium", "Widget" }
                }
            }
        }
    }
}

// ============================================================================
// Utility Functions
// ============================================================================

fn create_initial_notebook() -> Vec<Cell> {
    vec![
        Cell {
            id: Uuid::new_v4().to_string(),
            cell_type: CellType::Markdown,
            content: "# 🚀 Willkommen zum MetaRow Player!\n\nDies ist eine **interaktive Markdown-Zelle**. Sie können:\n\n- **Markdown** schreiben mit *allen* Features\n- `Code-Snippets` einbetten\n- Listen und Tabellen erstellen\n- Links zu [Dokumentation](https://dioxuslabs.com) hinzufügen\n\n> **Tipp:** Klicken Sie auf diese Zelle um sie zu bearbeiten!".to_string(),
            output: None,
        },
        Cell {
            id: Uuid::new_v4().to_string(),
            cell_type: CellType::Python,
            content: "# 🐍 Python Hello World\nprint('Hallo aus dem MetaRow Player! 🎉')\n\n# Mathematische Berechnungen\nimport math\nresult = math.sqrt(42)\nprint(f'Die Wurzel aus 42 ist: {result:.2f}')\n\n# Listen und Schleifen\nzahlen = [1, 2, 3, 4, 5]\nquadrate = [x**2 for x in zahlen]\nprint(f'Quadrate: {quadrate}')\n\n# Funktionen\ndef fibonacci(n):\n    if n <= 1:\n        return n\n    return fibonacci(n-1) + fibonacci(n-2)\n\nprint(f'Fibonacci(10) = {fibonacci(10)}')".to_string(),
            output: None,
        },
        Cell {
            id: Uuid::new_v4().to_string(),
            cell_type: CellType::Interactive,
            content: "Interactive Widget Demo".to_string(),
            output: None,
        }
    ]
}

fn create_cell(cell_type: CellType) -> Cell {
    let content = match cell_type {
        CellType::Markdown => "# Neue Markdown-Zelle\n\nSchreiben Sie hier Ihre **Dokumentation**...".to_string(),
        CellType::Python => "# Neuer Python-Code\nprint('Hello World!')\n\n# Ihr Code hier...".to_string(),
        CellType::Interactive => "Interactive Widgets".to_string(),
    };
    
    Cell {
        id: Uuid::new_v4().to_string(),
        cell_type,
        content,
        output: None,
    }
}

async fn execute_python_code(code: &str) -> Result<String, String> {
    let code = code.to_string();
    
    tokio::task::spawn_blocking(move || {
        Python::with_gil(|py| -> Result<String, String> {
            // Erstelle einen neuen Namespace für diese Ausführung
            let locals = pyo3::types::PyDict::new(py);
            
            // Capture stdout und stderr
            let sys = py.import("sys").map_err(|e| format!("Import Error: {}", e))?;
            let io = py.import("io").map_err(|e| format!("Import Error: {}", e))?;
            
            // Backup original stdout/stderr
            let original_stdout = sys.getattr("stdout").map_err(|e| format!("Stdout Error: {}", e))?;
            let original_stderr = sys.getattr("stderr").map_err(|e| format!("Stderr Error: {}", e))?;
            
            // Create StringIO objects to capture output
            let stdout_capture = io.call_method0("StringIO").map_err(|e| format!("StringIO Error: {}", e))?;
            let stderr_capture = io.call_method0("StringIO").map_err(|e| format!("StringIO Error: {}", e))?;
            
            // Redirect stdout/stderr
            sys.setattr("stdout", stdout_capture).map_err(|e| format!("Redirect Error: {}", e))?;
            sys.setattr("stderr", stderr_capture).map_err(|e| format!("Redirect Error: {}", e))?;
            
            let result = (|| -> Result<String, String> {
                // Try to execute as statements first
                match py.run(&code, None, Some(locals)) {
                    Ok(_) => {
                        // Get captured output
                        let stdout_str = stdout_capture
                            .call_method0("getvalue")
                            .map_err(|e| format!("Output Error: {}", e))?
                            .extract::<String>()
                            .map_err(|e| format!("Extract Error: {}", e))?;
                        
                        let stderr_str = stderr_capture
                            .call_method0("getvalue")
                            .map_err(|e| format!("Error Output Error: {}", e))?
                            .extract::<String>()
                            .map_err(|e| format!("Extract Error: {}", e))?;
                        
                        if !stderr_str.is_empty() {
                            return Err(stderr_str);
                        }
                        
                        if !stdout_str.is_empty() {
                            return Ok(stdout_str);
                        }
                        
                        // If no output, try to evaluate as expression
                        match py.eval(&code, None, Some(locals)) {
                            Ok(result) => {
                                let result_str = result.str()
                                    .map_err(|e| format!("String Conversion Error: {}", e))?
                                    .extract::<String>()
                                    .map_err(|e| format!("Extract Error: {}", e))?;
                                Ok(result_str)
                            },
                            Err(_) => Ok("Code erfolgreich ausgeführt (keine Ausgabe)".to_string())
                        }
                    },
                    Err(err) => {
                        let stderr_str = stderr_capture
                            .call_method0("getvalue")
                            .map_err(|e| format!("Error Output Error: {}", e))?
                            .extract::<String>()
                            .map_err(|e| format!("Extract Error: {}", e))?;
                        
                        if !stderr_str.is_empty() {
                            Err(stderr_str)
                        } else {
                            Err(format!("Python Error: {}", err))
                        }
                    }
                }
            })();
            
            // Restore original stdout/stderr
            let _ = sys.setattr("stdout", original_stdout);
            let _ = sys.setattr("stderr", original_stderr);
            
            result
        })
    })
    .await
    .map_err(|e| format!("Execution Error: {}", e))?
}
```

## 🎨 Schritt 5: Assets und Styling

### assets/tailwind.css (Optional für erweiterte Styles)
```css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Custom prose styles für Markdown */
.prose {
    @apply text-slate-100;
}

.prose h1 {
    @apply text-3xl font-bold text-blue-400 mb-4;
}

.prose h2 {
    @apply text-2xl font-bold text-blue-300 mb-3 mt-6;
}

.prose h3 {
    @apply text-xl font-bold text-blue-300 mb-2 mt-4;
}

.prose p {
    @apply mb-4 leading-relaxed text-slate-200;
}

.prose code {
    @apply bg-slate-800 text-green-400 px-2 py-1 rounded text-sm font-mono;
}

.prose pre {
    @apply bg-slate-900 p-4 rounded-lg overflow-x-auto border border-slate-600;
}

.prose pre code {
    @apply bg-transparent p-0;
}

.prose blockquote {
    @apply border-l-4 border-blue-500 pl-4 italic text-slate-300 my-4;
}

.prose ul {
    @apply list-disc list-inside space-y-1 ml-4;
}

.prose ol {
    @apply list-decimal list-inside space-y-1 ml-4;
}

.prose li {
    @apply text-slate-200;
}

.prose a {
    @apply text-blue-400 hover:text-blue-300 underline;
}

.prose table {
    @apply w-full border-collapse border border-slate-600 my-4;
}

.prose th {
    @apply border border-slate-600 bg-slate-800 px-4 py-2 font-bold text-blue-300;
}

.prose td {
    @apply border border-slate-600 px-4 py-2;
}

.prose strong {
    @apply font-bold text-white;
}

.prose em {
    @apply italic text-slate-300;
}

/* Custom scrollbar */
::-webkit-scrollbar {
    width: 8px;
}

::-webkit-scrollbar-track {
    @apply bg-slate-800;
}

::-webkit-scrollbar-thumb {
    @apply bg-slate-600 rounded-full;
}

::-webkit-scrollbar-thumb:hover {
    @apply bg-slate-500;
}
```

## 🚀 Schritt 6: Starten und Testen

### Development starten
```bash
# Desktop-Version (empfohlen für Entwicklung)
dx serve --platform desktop

# Oder Web-Version
dx serve --platform web

# Hot-reload funktioniert automatisch! 🔥
```

### Erste Tests durchführen

1. **Markdown-Zelle testen:**
   - Klicken Sie auf die erste Zelle
   - Bearbeiten Sie den Markdown-Text
   - Drücken Sie Strg+Enter zum Speichern

2. **Python-Code ausführen:**
   - Klicken Sie auf die Python-Zelle
   - Drücken Sie Strg+Enter oder "Ausführen"
   - Sehen Sie die Ausgabe im Output-Bereich

3. **Interaktive Widgets testen:**
   - Bewegen Sie die Slider
   - Klicken Sie auf Counter-Buttons
   - Geben Sie Text ein

## 📦 Schritt 7: Build für Production

### Desktop-App erstellen
```bash
# Desktop-Binary erstellen
dx build --platform desktop --release

# Binary findet sich in: target/release/metarow-hello-world
```

### Web-App erstellen
```bash
# Web-Build für Deployment
dx build --platform web --release

# Statische Dateien in: dist/
```

### Universal-Build (alle Plattformen)
```bash
# Alle Targets auf einmal
dx build --platform all --release
```

## 🔧 Schritt 8: Erweiterte Features hinzufügen

### 1. File I/O Support
```toml
# Cargo.toml - zusätzliche Dependencies
tokio = { version = "1.0", features = ["full"] }
rfd = "0.14"  # File dialogs
```

### 2. Chart-Integration
```toml
plotters = { version = "0.3", default-features = false, features = ["svg_backend"] }
```

### 3. LaTeX-Math Support  
```toml
katex = "0.4"  # Math rendering
```

## 🎯 Beispiel-Notebooks zum Testen

### Datenwissenschaft-Beispiel:
```python
# 📊 Datenwissenschaft Demo
import random
import statistics

# Zufällige Daten generieren
data = [random.gauss(50, 15) for _ in range(100)]

print(f"Anzahl Werte: {len(data)}")
print(f"Mittelwert: {statistics.mean(data):.2f}")
print(f"Standardabweichung: {statistics.stdev(data):.2f}")
print(f"Median: {statistics.median(data):.2f}")

# Histogramm-Daten (vereinfacht)
bins = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
hist = [sum(1 for x in data if bins[i] <= x < bins[i+1]) for i in range(len(bins)-1)]
print(f"Histogramm: {hist}")
```

### Mathematik-Beispiel:
```python
# 🧮 Mathematik Demo
import math

def primzahlen(n):
    """Finde alle Primzahlen bis n"""
    sieve = [True] * (n + 1)
    sieve[0] = sieve[1] = False
    
    for i in range(2, int(math.sqrt(n)) + 1):
        if sieve[i]:
            for j in range(i*i, n + 1, i):
                sieve[j] = False
    
    return [i for i in range(2, n + 1) if sieve[i]]

# Primzahlen bis 50 finden
primes = primzahlen(50)
print(f"Primzahlen bis 50: {primes}")
print(f"Anzahl Primzahlen: {len(primes)}")

# Fibonacci-Folge
def fibonacci_sequence(n):
    fib = [0, 1]
    for i in range(2, n):
        fib.append(fib[i-1] + fib[i-2])
    return fib

fib_seq = fibonacci_sequence(15)
print(f"Fibonacci-Folge: {fib_seq}")
```

## 🚨 Troubleshooting

### Häufige Probleme und Lösungen:

1. **Python-Import-Fehler:**
   ```bash
   # Python-Entwicklungsheader installieren
   # Ubuntu/Debian:
   sudo apt install python3-dev
   
   # macOS:
   xcode-select --install
   
   # Windows: Python über python.org installieren
   ```

2. **Dioxus CLI Fehler:**
   ```bash
   # CLI neu installieren
   cargo uninstall dioxus-cli
   cargo install dioxus-cli --force
   ```

3. **Build-Fehler:**
   ```bash
   # Cache leeren
   cargo clean
   rm -rf target/
   dx clean
   
   # Neu bauen
   dx build
   ```

4. **WebView-Probleme (Windows):**
   ```bash
   # WebView2 Runtime installieren
   # Download von: https://developer.microsoft.com/microsoft-edge/webview2/
   ```

## 🎯 Nächste Schritte

### Erweitungen die Sie implementieren können:

1. **📁 File Management:**
   - Notebooks speichern/laden
   - Import/Export (JSON, Jupyter)
   - Recent files

2. **🎨 Themes & Customization:**
   - Dark/Light Mode
   - Syntax-Highlighting Themes
   - Font-Auswahl

3. **🔗 Erweiterte Python-Integration:**
   - Package Manager (pip install)
   - Virtual Environments
   - Plotting mit matplotlib

4. **👥 Collaboration:**
   - WebSocket für Live-Editing
   - Comments & Annotations
   - Version Control

5. **📱 Mobile Support:**
   - Touch-optimierte UI
   - Mobile-spezifische Widgets

## 🎉 Fertig!

Sie haben jetzt einen vollständig funktionsfähigen MetaRow Player mit:

- ✅ **Dioxus 0.7** mit modernster Rust-UI-Technologie
- ✅ **Interactive Markdown** mit Live-Rendering
- ✅ **Python-Code-Execution** mit Output-Capture
- ✅ **Interaktive Widgets** für bessere UX
- ✅ **Cross-Platform** (Web + Desktop) aus einer Codebasis
- ✅ **Hot-Reload** für optimale Developer Experience

**Genießen Sie Ihren neuen Interactive Notebook Player! 🚀**