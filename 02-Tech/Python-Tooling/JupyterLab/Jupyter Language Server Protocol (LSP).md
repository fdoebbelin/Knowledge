JupyterLab nutzt standardmäßig den **Jupyter Language Server Protocol (LSP)** zur Bereitstellung von Codevervollständigungen, Syntaxprüfung und anderen sprachbezogenen Features. Für Python ist der **`jedi`-basierte LSP-Server** vorinstalliert und direkt nutzbar. Andere Sprachen können durch die Installation zusätzlicher Pakete und Erweiterungen integriert werden.

### **Standardmäßig installiert:**

- **Python:** `jedi` oder `pyright` (über `python-lsp-server` oder `pyright`).
- **Markdown:** einfache Unterstützung für Syntax und Formatierung.
- **JSON:** Unterstützung durch den in JupyterLab integrierten JSON-LSP.

### **Zusätzliche Sprachen und Erweiterungen:**

Um weitere Sprachen zu unterstützen, müssen oft zusätzliche LSP-Server und die passende JupyterLab-Erweiterung installiert werden. Hier einige Beispiele:

1. **JavaScript/TypeScript:**
    
    - **LSP-Server:** `typescript-language-server`
    - **Installation:**
        
        ```bash
        npm install -g typescript-language-server typescript
        ```
        
2. **R:**
    
    - **LSP-Server:** `languageserver` (R-Paket)
    - **Installation in R:**
        
        ```R
        install.packages("languageserver")
        ```
        
3. **Julia:**
    
    - **LSP-Server:** `LanguageServer.jl`
    - **Installation:**
        
        ```julia
        using Pkg
        Pkg.add("LanguageServer")
        ```
        
4. **C/C++:**
    
    - **LSP-Server:** `clangd`
    - **Installation:**
        
        ```bash
        sudo apt install clangd  # Linux
        brew install llvm        # macOS
        ```
        
5. **YAML:**
    
    - **LSP-Server:** `yaml-language-server`
    - **Installation:**
        
        ```bash
        npm install -g yaml-language-server
        ```
        

### **Aktivierung des Language Server Protocol (LSP):**

1. **JupyterLab LSP-Erweiterung installieren:**
    
    ```bash
    pip install jupyterlab-lsp
    jupyter labextension install @krassowski/jupyterlab-lsp
    ```
    
2. **Neustarten von JupyterLab:**  
    Damit die Änderungen wirksam werden, muss JupyterLab neu gestartet werden.
    

### **Konfiguration:**

Die Konfigurationsdatei `jupyter_lab_config.py` kann verwendet werden, um spezifische LSP-Server zu registrieren oder zu priorisieren.

Beispiel:

```python
c.LanguageServerManager.language_servers = {
    "python": {"argv": ["pylsp"], "languages": ["python"]},
    "javascript": {"argv": ["typescript-language-server", "--stdio"], "languages": ["javascript", "typescript"]},
}
```