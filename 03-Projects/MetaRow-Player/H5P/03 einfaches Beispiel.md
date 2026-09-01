Perfekt! Beginnen wir mit einem einfachen Beispiel. Ich erstelle eine grundlegende Rust-Anwendung, die H5P-Inhalte offline verarbeiten kann:

`Cargo.toml`
```toml
[package]
name = "markdown-h5p-renderer"
version = "0.1.0"
edition = "2021"

[dependencies]
pulldown-cmark = "0.9"
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
zip = "0.6"
handlebars = "4.0"
tokio = { version = "1.0", features = ["full"] }
warp = "0.3"
```


H5P Content Struktur
```rust
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::io::Read;
use zip::ZipArchive;

#[derive(Debug, Deserialize, Serialize)]
pub struct H5PContent {
    pub title: String,
    pub content_type: String,
    pub content_data: serde_json::Value,
    pub assets: HashMap<String, Vec<u8>>,
}

#[derive(Debug, Deserialize)]
pub struct H5PLibrary {
    pub name: String,
    pub version: String,
    pub js: Option<Vec<String>>,
    pub css: Option<Vec<String>>,
}

impl H5PContent {
    /// Lade H5P-Inhalt aus einer .h5p-Datei (ZIP-Archive)
    pub fn from_h5p_file(path: &str) -> Result<Self, Box<dyn std::error::Error>> {
        println!("Lade H5P-Datei: {}", path);
        let file = std::fs::File::open(path)?;
        let mut archive = ZipArchive::new(file)?;
        
        // content/content.json lesen
        let mut content_file = archive.by_name("content/content.json")?;
        let mut content_string = String::new();
        content_file.read_to_string(&mut content_string)?;
        let content_data: serde_json::Value = serde_json::from_str(&content_string)?;
        println!("Content-Daten geladen: {}", content_data);
        
        // h5p.json für Metadaten lesen
        let mut h5p_file = archive.by_name("h5p.json")?;
        let mut h5p_string = String::new();
        h5p_file.read_to_string(&mut h5p_string)?;
        let h5p_meta: serde_json::Value = serde_json::from_str(&h5p_string)?;
        println!("H5P-Metadaten: {}", h5p_meta);
        
        // Alle Dateien im Archiv auflisten
        println!("Dateien im H5P-Archiv:");
        for i in 0..archive.len() {
            let file = archive.by_index(i)?;
            println!("  - {}", file.name());
        }
        
        // Assets extrahieren
        let mut assets = HashMap::new();
        for i in 0..archive.len() {
            let mut file = archive.by_index(i)?;
            let name = file.name().to_string();
            
            // Alle relevanten Assets laden
            if name.starts_with("content/") || name.starts_with("images/") {
                if name.ends_with(".png") || name.ends_with(".jpg") || name.ends_with(".jpeg") ||
                   name.ends_with(".gif") || name.ends_with(".css") || name.ends_with(".js") ||
                   name.ends_with(".mp4") || name.ends_with(".mp3") || name.ends_with(".svg") {
                    let mut buffer = Vec::new();
                    file.read_to_end(&mut buffer)?;
                    assets.insert(name.clone(), buffer);
                    println!("Asset geladen: {} ({} bytes)", name, buffer.len());
                }
            }
        }
        
        Ok(H5PContent {
            title: h5p_meta["title"].as_str().unwrap_or("Unbekannt").to_string(),
            content_type: h5p_meta["mainLibrary"].as_str().unwrap_or("Unknown").to_string(),
            content_data,
            assets,
        })
    }
    
    /// Erstelle einen einfachen H5P-Inhalt für Tests
    pub fn create_simple_text() -> Self {
        let content_data = serde_json::json!({
            "text": "<p>Hallo Welt! Dies ist ein einfacher H5P-Textinhalt.</p>",
            "library": "H5P.Text 1.1"
        });
        
        H5PContent {
            title: "Einfacher Text".to_string(),
            content_type: "H5P.Text".to_string(),
            content_data,
            assets: HashMap::new(),
        }
    }
    
    /// Erstelle einen einfachen H5P-Quiz-Inhalt
    pub fn create_simple_quiz() -> Self {
        let content_data = serde_json::json!({
            "question": "Was ist 2 + 2?",
            "answers": [
                {"text": "3", "correct": false},
                {"text": "4", "correct": true},
                {"text": "5", "correct": false}
            ],
            "library": "H5P.MultiChoice 1.16"
        });
        
        H5PContent {
            title: "Einfaches Quiz".to_string(),
            content_type: "H5P.MultiChoice".to_string(),
            content_data,
            assets: HashMap::new(),
        }
    }
}
```

H5P Renderer
```rust
use crate::h5p_content::H5PContent;
use handlebars::Handlebars;
use serde_json::json;

pub struct H5PRenderer {
    handlebars: Handlebars<'static>,
}

impl H5PRenderer {
    pub fn new() -> Self {
        let mut handlebars = Handlebars::new();
        
        // HTML-Template für H5P-Inhalte
        let h5p_template = r#"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>{{title}}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .h5p-container { 
            border: 2px solid #ddd; 
            border-radius: 8px; 
            padding: 20px; 
            margin: 20px 0;
            background: #f9f9f9;
        }
        .h5p-title { 
            color: #333; 
            margin-bottom: 15px; 
            font-size: 1.2em; 
            font-weight: bold;
        }
        .h5p-text { 
            line-height: 1.6; 
            color: #555; 
        }
        .h5p-quiz { 
            background: white; 
            padding: 15px; 
            border-radius: 5px; 
        }
        .h5p-question { 
            font-weight: bold; 
            margin-bottom: 10px; 
            color: #333;
        }
        .h5p-answer { 
            margin: 8px 0; 
            padding: 8px; 
            border: 1px solid #ccc; 
            border-radius: 4px; 
            cursor: pointer; 
            background: #f8f8f8;
        }
        .h5p-answer:hover { 
            background: #e8e8e8; 
        }
        .h5p-answer.correct { 
            background: #d4edda; 
            border-color: #c3e6cb; 
        }
        .h5p-answer.incorrect { 
            background: #f8d7da; 
            border-color: #f5c6cb; 
        }
    </style>
    <script>
        function checkAnswer(element, isCorrect) {
            const answers = element.parentElement.querySelectorAll('.h5p-answer');
            answers.forEach(answer => {
                answer.style.pointerEvents = 'none';
                if (answer.dataset.correct === 'true') {
                    answer.classList.add('correct');
                } else {
                    answer.classList.add('incorrect');
                }
            });
        }
    </script>
</head>
<body>
    <div class="h5p-container">
        <div class="h5p-title">{{title}}</div>
        {{#if is_text}}
        <div class="h5p-text">
            {{{content_data.text}}}
        </div>
        {{/if}}
        {{#if is_quiz}}
        <div class="h5p-quiz">
            <div class="h5p-question">{{content_data.question}}</div>
            {{#each content_data.answers}}
            <div class="h5p-answer" data-correct="{{this.correct}}" onclick="checkAnswer(this, {{this.correct}})">
                {{this.text}}
            </div>
            {{/each}}
        </div>
        {{/if}}
    </div>
</body>
</html>
        "#;
        
        handlebars.register_template_string("h5p", h5p_template).unwrap();
        
        Self { handlebars }
    }
    
    pub fn render_to_html(&self, content: &H5PContent) -> String {
        let is_text = content.content_type.contains("Text");
        let is_quiz = content.content_type.contains("MultiChoice");
        
        self.handlebars.render("h5p", &json!({
            "title": content.title,
            "content_data": content.content_data,
            "is_text": is_text,
            "is_quiz": is_quiz
        })).unwrap_or_else(|e| format!("Fehler beim Rendern: {}", e))
    }
}
```

Markdown Prozessor mit H5P
```rust
use crate::h5p_content::H5PContent;
use crate::h5p_renderer::H5PRenderer;
use pulldown_cmark::{Parser, html, Event, Tag, CodeBlockKind};
use std::collections::HashMap;

pub struct MarkdownProcessor {
    h5p_renderer: H5PRenderer,
    h5p_contents: HashMap<String, H5PContent>,
}

impl MarkdownProcessor {
    pub fn new() -> Self {
        let mut processor = Self {
            h5p_renderer: H5PRenderer::new(),
            h5p_contents: HashMap::new(),
        };
        
        // Beispiel-Inhalte hinzufügen
        processor.h5p_contents.insert(
            "simple-text".to_string(), 
            H5PContent::create_simple_text()
        );
        processor.h5p_contents.insert(
            "simple-quiz".to_string(), 
            H5PContent::create_simple_quiz()
        );
        
        processor
    }
    
    pub fn add_h5p_content(&mut self, id: String, content: H5PContent) {
        self.h5p_contents.insert(id, content);
    }
    
    pub fn process_markdown(&self, markdown: &str) -> String {
        let parser = Parser::new(markdown);
        let mut events = Vec::new();
        let mut in_h5p_block = false;
        let mut h5p_block_content = String::new();
        
        for event in parser {
            match event {
                Event::Start(Tag::CodeBlock(CodeBlockKind::Fenced(lang))) if lang.as_ref() == "h5p" => {
                    in_h5p_block = true;
                    h5p_block_content.clear();
                }
                Event::End(Tag::CodeBlock(CodeBlockKind::Fenced(lang))) if lang.as_ref() == "h5p" => {
                    in_h5p_block = false;
                    let h5p_html = self.process_h5p_block(&h5p_block_content);
                    events.push(Event::Html(h5p_html.into()));
                }
                Event::Text(text) if in_h5p_block => {
                    h5p_block_content.push_str(&text);
                }
                _ if !in_h5p_block => {
                    events.push(event);
                }
                _ => {} // Ignoriere andere Events in H5P-Blöcken
            }
        }
        
        let mut html_output = String::new();
        html::push_html(&mut html_output, events.into_iter());
        html_output
    }
    
    fn process_h5p_block(&self, block_content: &str) -> String {
        // Einfaches Parsing der H5P-Block-Parameter
        let mut content_id = None;
        
        for line in block_content.lines() {
            let line = line.trim();
            if line.starts_with("id:") {
                content_id = Some(line[3..].trim().to_string());
            }
        }
        
        match content_id {
            Some(id) => {
                if let Some(content) = self.h5p_contents.get(&id) {
                    // Erstelle einen vereinfachten HTML-Block für die Markdown-Ausgabe
                    format!(
                        r#"<div class="h5p-embed" data-content-id="{}">
                            <h3>{}</h3>
                            <p><em>H5P-Inhalt: {} (Klick für Details)</em></p>
                            <details>
                                <summary>Inhalt anzeigen</summary>
                                {}
                            </details>
                        </div>"#,
                        id,
                        content.title,
                        content.content_type,
                        self.render_h5p_preview(content)
                    )
                } else {
                    format!(r#"<div class="h5p-error">H5P-Inhalt "{}" nicht gefunden</div>"#, id)
                }
            }
            None => {
                r#"<div class="h5p-error">H5P-Block: Keine ID angegeben</div>"#.to_string()
            }
        }
    }
    
    fn render_h5p_preview(&self, content: &H5PContent) -> String {
        match content.content_type.as_str() {
            ct if ct.contains("Text") => {
                content.content_data["text"].as_str().unwrap_or("Kein Text").to_string()
            }
            ct if ct.contains("MultiChoice") => {
                let question = content.content_data["question"].as_str().unwrap_or("Keine Frage");
                let answers = content.content_data["answers"].as_array().unwrap_or(&vec![]);
                
                let mut preview = format!("<strong>{}</strong><br>", question);
                for (i, answer) in answers.iter().enumerate() {
                    let text = answer["text"].as_str().unwrap_or("Keine Antwort");
                    let correct = answer["correct"].as_bool().unwrap_or(false);
                    let marker = if correct { "✓" } else { "○" };
                    preview.push_str(&format!("{} {}<br>", marker, text));
                }
                preview
            }
            _ => "Unbekannter H5P-Inhaltstyp".to_string()
        }
    }
    
    pub fn render_h5p_standalone(&self, content_id: &str) -> Option<String> {
        self.h5p_contents.get(content_id)
            .map(|content| self.h5p_renderer.render_to_html(content))
    }
}
```

main.rs

```rust

```



Hier ist ein vollständiges Beispiel für eine Rust-Anwendung, die H5P-Inhalte offline in Markdown-Dokumenten verarbeitet:

## Funktionen des Beispiels:

**1. H5P-Struktur:**

- Grundlegende H5P-Datenstrukturen
- Unterstützung für Text- und Quiz-Inhalte
- Möglichkeit, echte .h5p-Dateien zu laden

**2. Markdown-Integration:**

- Spezielle `h5p`-Code-Blöcke im Markdown
- Einfache Syntax: `id: content-name`
- Nahtlose Integration mit normalem Markdown

**3. Offline-Rendering:**

- Vollständig in Rust implementiert
- Keine externe JavaScript-Abhängigkeiten
- HTML-Templates für verschiedene H5P-Typen

**4. Web-Server für Tests:**

- Lokaler Server auf Port 3030
- Separate Routen für Markdown und H5P-Inhalte
- Live-Vorschau der gerenderten Inhalte

## Verwendung:

1. **Projekt erstellen:**

```bash
cargo new markdown-h5p-renderer
cd markdown-h5p-renderer
# Cargo.toml ersetzen
```

2. **Ausführen:**

```bash
cargo run
```

3. **Im Browser öffnen:**

- `http://localhost:3030/markdown` - Markdown mit H5P
- `http://localhost:3030/h5p/simple-quiz` - Eigenständiges Quiz

## Markdown-Syntax:

````markdown
# Mein Dokument

```h5p
id: simple-quiz
````
## Erweiterungsmöglichkeiten:

- **Mehr H5P-Typen:** Image Hotspots, Interactive Videos, etc.
- **Echte .h5p-Dateien:** Laden von ZIP-Archiven
- **Styling:** Bessere CSS-Themes
- **JavaScript:** Für komplexere Interaktionen

Möchten Sie einen bestimmten Aspekt vertiefen oder haben Sie Fragen zur Implementierung?