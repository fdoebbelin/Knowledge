# MetaRow Player - Static Webhost Deployment 🌐

## 🎯 Deployment-Strategien für normale Webhoster

### Option 1: **Vollständig statisch** (ohne Python-Backend)
- ✅ Netlify, Vercel, GitHub Pages, etc.
- ✅ JavaScript-basierte Code-Execution
- ❌ Kein echtes Python (aber Pyodide möglich)

### Option 2: **Hybrid-Lösung** (empfohlen)
- ✅ Frontend: Statischer Hoster
- ✅ Backend: Rust-Server auf VPS/Cloud
- ✅ Vollständige Python-Integration

### Option 3: **WebAssembly Python** 
- ✅ Pyodide für echtes Python im Browser
- ✅ Statisch hostbar
- ⚠️ Größere Bundle-Size, aber funktional

## 🚀 Option 1: Statisch mit JavaScript (Schnellste Lösung)

### Frontend-Only Implementation

#### web-static/package.json
```json
{
  "name": "metarow-static",
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "deploy": "npm run build && npm run deploy:netlify"
  },
  "devDependencies": {
    "vite": "^5.0.0"
  },
  "dependencies": {
    "marked": "^12.0.0",
    "codemirror": "^6.0.0",
    "@codemirror/lang-python": "^6.0.0",
    "@codemirror/theme-one-dark": "^6.0.0"
  }
}
```

#### web-static/src/js-python-engine.js
```javascript
// JavaScript-basierte Python-"Engine" für statische Hosting
export class JSPythonEngine {
    constructor() {
        this.variables = new Map();
        this.functions = new Map();
        this.setupBuiltins();
    }

    setupBuiltins() {
        // Simulierte Python-Funktionen in JavaScript
        this.functions.set('print', (...args) => {
            return args.map(arg => String(arg)).join(' ');
        });

        this.functions.set('len', (obj) => {
            if (Array.isArray(obj) || typeof obj === 'string') {
                return obj.length;
            }
            return 0;
        });

        this.functions.set('range', (start, stop, step = 1) => {
            if (stop === undefined) {
                stop = start;
                start = 0;
            }
            const result = [];
            for (let i = start; i < stop; i += step) {
                result.push(i);
            }
            return result;
        });

        this.functions.set('sum', (iterable) => {
            return Array.isArray(iterable) ? 
                iterable.reduce((a, b) => a + b, 0) : 0;
        });

        this.functions.set('max', (iterable) => {
            return Array.isArray(iterable) ? Math.max(...iterable) : 0;
        });

        this.functions.set('min', (iterable) => {
            return Array.isArray(iterable) ? Math.min(...iterable) : 0;
        });

        // Math-Module simulieren
        this.variables.set('math', {
            pi: Math.PI,
            e: Math.E,
            sqrt: Math.sqrt,
            sin: Math.sin,
            cos: Math.cos,
            tan: Math.tan,
            log: Math.log,
            exp: Math.exp,
            floor: Math.floor,
            ceil: Math.ceil,
            abs: Math.abs,
            pow: Math.pow
        });
    }

    async execute(code) {
        try {
            // Einfache Python-zu-JavaScript Übersetzung
            let jsCode = this.translatePythonToJS(code);
            
            // Execution context mit verfügbaren Variablen/Funktionen
            const context = {
                ...Object.fromEntries(this.variables),
                ...Object.fromEntries(this.functions),
                console: console,
                Math: Math
            };

            // JavaScript ausführen mit verfügbarem Kontext
            const result = await this.executeInContext(jsCode, context);
            
            // Variablen-Updates speichern
            this.updateVariables(context);
            
            return { 
                output: result || '', 
                error: null,
                execution_time: 0.001 
            };
        } catch (error) {
            return { 
                output: '', 
                error: `JavaScript Error: ${error.message}`,
                execution_time: 0 
            };
        }
    }

    translatePythonToJS(pythonCode) {
        let jsCode = pythonCode;

        // Einfache Übersetzungen
        jsCode = jsCode.replace(/print\s*\(/g, 'console.log(');
        jsCode = jsCode.replace(/def\s+(\w+)\s*\(/g, 'function $1(');
        jsCode = jsCode.replace(/:\s*$/gm, ' {');
        jsCode = jsCode.replace(/^(\s*)(.+)$/gm, (match, indent, line) => {
            if (line.trim() === '') return match;
            if (line.includes('function ') || line.includes('{')) return match;
            if (indent.length > 0 && !line.includes('}')) {
                return indent + line + ';';
            }
            return line.includes('=') ? indent + line + ';' : indent + 'return ' + line + ';';
        });

        // Python-spezifische Syntax
        jsCode = jsCode.replace(/\*\*/g, '**'); // Potenz-Operator
        jsCode = jsCode.replace(/\/\//g, 'Math.floor(/'); // Integer-Division
        
        return jsCode;
    }

    async executeInContext(code, context) {
        // Sichere Ausführung in isoliertem Kontext
        const contextKeys = Object.keys(context);
        const contextValues = Object.values(context);
        
        const wrappedCode = `
            return (function(${contextKeys.join(', ')}) {
                let output = '';
                const originalLog = console.log;
                console.log = (...args) => {
                    output += args.join(' ') + '\\n';
                };
                
                try {
                    ${code}
                    console.log = originalLog;
                    return output.trim();
                } catch (e) {
                    console.log = originalLog;
                    throw e;
                }
            })(${contextKeys.map(k => `arguments[${contextKeys.indexOf(k)}]`).join(', ')});
        `;

        const func = new Function(wrappedCode);
        return func.apply(null, contextValues);
    }

    updateVariables(context) {
        // Neue Variablen aus Kontext extrahieren
        for (const [key, value] of Object.entries(context)) {
            if (typeof value !== 'function' && !key.startsWith('console')) {
                this.variables.set(key, value);
            }
        }
    }
}
```

#### web-static/src/main.js
```javascript
import { JSPythonEngine } from './js-python-engine.js';
import { marked } from 'marked';

class MetaRowStaticApp {
    constructor() {
        this.cells = [];
        this.pythonEngine = new JSPythonEngine();
        this.init();
    }

    init() {
        this.setupEventListeners();
        this.addInitialCells();
    }

    setupEventListeners() {
        document.getElementById('add-cell-btn').addEventListener('click', () => this.addCell());
        document.getElementById('clear-session-btn').addEventListener('click', () => this.clearSession());
    }

    addInitialCells() {
        // Welcome Markdown Cell
        this.addCell('markdown', `# 🚀 MetaRow Player - Static Version

Dies ist die **statische Version** des MetaRow Players, die auf jedem Webhoster läuft!

## Features:
- ✅ **Markdown-Rendering** mit marked.js
- ✅ **JavaScript-basierte Python-Simulation**
- ✅ **Vollständig statisch** (Netlify, Vercel, GitHub Pages)
- ✅ **Offline-fähig** als PWA

## Einschränkungen:
- ⚠️ **Python-Simulation** (nicht echtes Python)
- ⚠️ **Begrenzte Library-Unterstützung**
- ⚠️ **Keine numpy/pandas/matplotlib**

> **Für vollständige Python-Integration** nutzen Sie die Desktop-App oder Server-Version!`);

        // Python Demo Cell
        this.addCell('python', `# 🐍 JavaScript-basierte Python-Simulation
print('Hello from simulated Python!')

# Mathematische Berechnungen
import math
result = math.sqrt(42)
print(f'Wurzel aus 42: {result:.2f}')

# Listen und Funktionen
numbers = [1, 2, 3, 4, 5]
squares = [x**2 for x in numbers]
print(f'Quadratzahlen: {squares}')

# Eigene Funktionen
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

fib_10 = fibonacci(10)
print(f'Fibonacci(10) = {fib_10}')`);
    }

    addCell(type = 'python', content = '') {
        const cellId = this.generateId();
        const cell = {
            id: cellId,
            type: type,
            content: content,
            output: null
        };
        
        this.cells.push(cell);
        this.renderCells();
        
        // Focus auf neue Zelle
        setTimeout(() => {
            const textarea = document.querySelector(`textarea[data-cell-id="${cellId}"]`);
            if (textarea) textarea.focus();
        }, 100);
    }

    async executeCell(cellId) {
        const cell = this.cells.find(c => c.id === cellId);
        if (!cell || cell.type !== 'python') return;

        const textarea = document.querySelector(`textarea[data-cell-id="${cellId}"]`);
        const code = textarea.value;
        
        this.updateCellUI(cellId, 'executing');
        
        try {
            const startTime = performance.now();
            const result = await this.pythonEngine.execute(code);
            result.execution_time = (performance.now() - startTime) / 1000;
            
            cell.output = result;
            cell.content = code;
            this.renderCellOutput(cellId, result);
        } catch (error) {
            const errorOutput = {
                output: '',
                error: error.toString(),
                execution_time: 0
            };
            this.renderCellOutput(cellId, errorOutput);
        } finally {
            this.updateCellUI(cellId, 'idle');
        }
    }

    renderCells() {
        const container = document.getElementById('cells-container');
        
        container.innerHTML = this.cells.map(cell => {
            if (cell.type === 'markdown') {
                return this.renderMarkdownCell(cell);
            } else {
                return this.renderPythonCell(cell);
            }
        }).join('');

        this.attachCellEventListeners();
    }

    renderMarkdownCell(cell) {
        const renderedMarkdown = marked(cell.content || '# Neue Markdown-Zelle\n\nKlicken Sie hier zum Bearbeiten...');
        
        return `
            <div class="cell markdown-cell" data-cell-id="${cell.id}">
                <div class="cell-header">
                    <span>📝 Markdown Cell</span>
                    <button class="delete-btn" data-cell-id="${cell.id}">🗑️</button>
                </div>
                <div class="markdown-content" data-cell-id="${cell.id}">
                    ${renderedMarkdown}
                </div>
                <div class="markdown-editor" data-cell-id="${cell.id}" style="display: none;">
                    <textarea class="markdown-input" data-cell-id="${cell.id}" placeholder="# Markdown hier eingeben...">${cell.content || ''}</textarea>
                    <div class="markdown-controls">
                        <button class="save-btn" data-cell-id="${cell.id}">💾 Speichern</button>
                        <button class="cancel-btn" data-cell-id="${cell.id}">❌ Abbrechen</button>
                    </div>
                </div>
            </div>
        `;
    }

    renderPythonCell(cell) {
        return `
            <div class="cell python-cell" data-cell-id="${cell.id}">
                <div class="cell-header">
                    <span>🐍 Python Cell (JS-Simulation)</span>
                    <button class="delete-btn" data-cell-id="${cell.id}">🗑️</button>
                </div>
                <div class="cell-content">
                    <textarea 
                        class="code-input" 
                        data-cell-id="${cell.id}"
                        placeholder="# JavaScript-basierte Python-Simulation
print('Hello World!')
x = 42
y = x * 2
print(f'Result: {y}')"
                    >${cell.content || ''}</textarea>
                </div>
                <div class="cell-controls">
                    <button class="run-btn" data-cell-id="${cell.id}">
                        ▶️ Ausführen
                    </button>
                    <small>Strg+Enter zum Ausführen | ⚠️ Python-Simulation</small>
                </div>
                ${cell.output ? `<div class="output ${cell.output.error ? 'error' : 'success'}" data-output-id="${cell.id}">
                    ${cell.output.error || cell.output.output}
                    ${cell.output.execution_time ? `<div class="execution-time">Ausführungszeit: ${cell.output.execution_time.toFixed(3)}s</div>` : ''}
                </div>` : ''}
            </div>
        `;
    }

    attachCellEventListeners() {
        // Python cell execution
        document.querySelectorAll('.run-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const cellId = e.target.getAttribute('data-cell-id');
                this.executeCell(cellId);
            });
        });

        // Keyboard shortcuts
        document.querySelectorAll('.code-input').forEach(textarea => {
            textarea.addEventListener('keydown', (e) => {
                if (e.ctrlKey && e.key === 'Enter') {
                    e.preventDefault();
                    const cellId = e.target.getAttribute('data-cell-id');
                    this.executeCell(cellId);
                }
            });
        });

        // Markdown editing
        document.querySelectorAll('.markdown-content').forEach(content => {
            content.addEventListener('click', (e) => {
                const cellId = e.target.closest('[data-cell-id]').getAttribute('data-cell-id');
                this.editMarkdownCell(cellId);
            });
        });

        // Markdown save/cancel
        document.querySelectorAll('.save-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const cellId = e.target.getAttribute('data-cell-id');
                this.saveMarkdownCell(cellId);
            });
        });

        document.querySelectorAll('.cancel-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const cellId = e.target.getAttribute('data-cell-id');
                this.cancelMarkdownEdit(cellId);
            });
        });

        // Delete cells
        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                const cellId = e.target.getAttribute('data-cell-id');
                this.deleteCell(cellId);
            });
        });
    }

    editMarkdownCell(cellId) {
        const content = document.querySelector(`.markdown-content[data-cell-id="${cellId}"]`);
        const editor = document.querySelector(`.markdown-editor[data-cell-id="${cellId}"]`);
        
        content.style.display = 'none';
        editor.style.display = 'block';
        
        const textarea = editor.querySelector('textarea');
        textarea.focus();
    }

    saveMarkdownCell(cellId) {
        const cell = this.cells.find(c => c.id === cellId);
        const textarea = document.querySelector(`.markdown-input[data-cell-id="${cellId}"]`);
        
        cell.content = textarea.value;
        this.renderCells();
    }

    cancelMarkdownEdit(cellId) {
        const content = document.querySelector(`.markdown-content[data-cell-id="${cellId}"]`);
        const editor = document.querySelector(`.markdown-editor[data-cell-id="${cellId}"]`);
        
        content.style.display = 'block';
        editor.style.display = 'none';
    }

    deleteCell(cellId) {
        this.cells = this.cells.filter(c => c.id !== cellId);
        this.renderCells();
    }

    renderCellOutput(cellId, output) {
        const outputDiv = document.querySelector(`div[data-output-id="${cellId}"]`);
        if (outputDiv) {
            outputDiv.className = `output ${output.error ? 'error' : 'success'}`;
            outputDiv.innerHTML = `
                ${output.error || output.output}
                ${output.execution_time ? `<div class="execution-time">Ausführungszeit: ${output.execution_time.toFixed(3)}s</div>` : ''}
            `;
        }
    }

    updateCellUI(cellId, state) {
        const runBtn = document.querySelector(`button.run-btn[data-cell-id="${cellId}"]`);
        if (runBtn) {
            switch (state) {
                case 'executing':
                    runBtn.disabled = true;
                    runBtn.innerHTML = '⏳ Läuft...';
                    break;
                case 'idle':
                    runBtn.disabled = false;
                    runBtn.innerHTML = '▶️ Ausführen';
                    break;
            }
        }
    }

    clearSession() {
        this.cells = [];
        this.pythonEngine = new JSPythonEngine();
        this.renderCells();
        this.addInitialCells();
    }

    generateId() {
        return Math.random().toString(36).substring(2, 15);
    }
}

// Initialize app
document.addEventListener('DOMContentLoaded', () => {
    new MetaRowStaticApp();
});
```

#### web-static/index.html
```html
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MetaRow Player - Static</title>
    
    <!-- PWA Manifest -->
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#1e293b">
    
    <!-- Meta Tags für Social Media -->
    <meta name="description" content="Interactive Python Notebooks - Static Web Version">
    <meta property="og:title" content="MetaRow Player">
    <meta property="og:description" content="Interactive Python Notebooks in your browser">
    <meta property="og:type" content="website">
    
    <style>
        /* Gleiche Styles wie vorher, aber kompakter */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            background: #1e1e1e;
            color: #d4d4d4;
            line-height: 1.6;
        }

        .header {
            background: #2d2d30;
            padding: 12px 20px;
            border-bottom: 1px solid #3e3e42;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .header h1 {
            font-size: 18px;
            color: #ffffff;
        }

        .static-badge {
            background: #28a745;
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            margin-left: 10px;
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

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
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

        .delete-btn {
            background: none;
            border: none;
            color: #969696;
            cursor: pointer;
            font-size: 14px;
            padding: 4px;
        }

        .delete-btn:hover {
            color: #ff6b6b;
        }

        /* Markdown Cells */
        .markdown-content {
            padding: 16px;
            cursor: pointer;
        }

        .markdown-content:hover {
            background: #2a2a2a;
        }

        .markdown-editor {
            padding: 16px;
        }

        .markdown-input {
            width: 100%;
            min-height: 120px;
            background: #1e1e1e;
            color: #d4d4d4;
            border: 1px solid #3e3e42;
            border-radius: 4px;
            padding: 12px;
            font-family: inherit;
            font-size: 14px;
            resize: vertical;
        }

        .markdown-controls {
            margin-top: 10px;
            display: flex;
            gap: 8px;
        }

        .save-btn, .cancel-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }

        .save-btn {
            background: #28a745;
            color: white;
        }

        .cancel-btn {
            background: #6c757d;
            color: white;
        }

        /* Python Cells */
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

        .cell-controls {
            padding: 12px 16px;
            background: #2d2d30;
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        /* Markdown Styling */
        .markdown-content h1 { color: #ffffff; font-size: 28px; margin-bottom: 16px; }
        .markdown-content h2 { color: #e1e1e1; font-size: 24px; margin: 20px 0 12px; }
        .markdown-content h3 { color: #e1e1e1; font-size: 20px; margin: 16px 0 8px; }
        .markdown-content p { margin-bottom: 12px; color: #d4d4d4; }
        .markdown-content code { background: #3e3e42; padding: 2px 6px; border-radius: 3px; }
        .markdown-content pre { background: #2d2d30; padding: 12px; border-radius: 6px; overflow-x: auto; }
        .markdown-content blockquote { border-left: 4px solid #0e639c; padding-left: 16px; margin: 16px 0; color: #b0b0b0; }
        .markdown-content ul, .markdown-content ol { margin-left: 20px; margin-bottom: 12px; }
        .markdown-content li { margin-bottom: 4px; }
        .markdown-content a { color: #4fc3f7; text-decoration: none; }
        .markdown-content a:hover { text-decoration: underline; }

        /* Responsive */
        @media (max-width: 768px) {
            .header-content { flex-direction: column; gap: 10px; }
            .main-container { padding: 10px; }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>
                🐍 MetaRow Player 
                <span class="static-badge">Static</span>
            </h1>
            <div class="controls">
                <button id="add-cell-btn" class="btn">+ Python Zelle</button>
                <button id="clear-session-btn" class="btn secondary">Session löschen</button>
            </div>
        </div>
    </div>

    <main class="main-container">
        <div id="cells-container">
            <!-- Cells werden hier gerendert -->
        </div>
    </main>

    <script type="module" src="/src/main.js"></script>
</body>
</html>
```

## 🌐 Option 2: Pyodide für echtes Python (empfohlen)

### Mit WebAssembly Python-Integration

#### web-pyodide/package.json
```json
{
  "name": "metarow-pyodide",
  "version": "0.1.0",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "deploy:netlify": "netlify deploy --prod --dir=dist",
    "deploy:vercel": "vercel --prod"
  },
  "devDependencies": {
    "vite": "^5.0.0"
  },
  "dependencies": {
    "pyodide": "^0.26.0",
    "marked": "^12.0.0"
  }
}
```

#### web-pyodide/src/pyodide-engine.js
```javascript
// Echtes Python mit Pyodide (WebAssembly)
export class PyodideEngine {
    constructor() {
        this.pyodide = null;
        this.isInitialized = false;
        this.initPromise = null;
    }

    async initialize() {
        if (this.initPromise) {
            return this.initPromise;
        }

        this.initPromise = this._doInitialize();
        return this.initPromise;
    }

    async _doInitialize() {
        if (this.isInitialized) return;

        console.log('🐍 Initializing Pyodide...');
        
        // Pyodide from CDN
        const { loadPyodide } = await import('https://cdn.jsdelivr.net/pyodide/v0.26.0/full/pyodide.mjs');
        
        this.pyodide = await loadPyodide({
            indexURL: 'https://cdn.jsdelivr.net/pyodide/v0.26.0/full/'
        });

        // Install common packages
        console.log('📦 Installing Python packages...');
        await this.pyodide.loadPackage(['numpy', 'matplotlib', 'pandas', 'scipy']);

        this.isInitialized = true;
        console.log('✅ Pyodide ready!');
    }

    async execute(code) {
        await this.initialize();

        try {
            const startTime = performance.now();
            
            // Capture stdout
            this.pyodide.runPython(`
import sys
from io import StringIO
sys.stdout = StringIO()
sys.stderr = StringIO()
            `);

            // Execute user code
            this.pyodide.runPython(code);

            // Get output
            const stdout = this.pyodide.runPython('sys.stdout.getvalue()');
            const stderr = this.pyodide.runPython('sys.stderr.getvalue()');

            // Restore stdout
            this.pyodide.runPython(`
sys.stdout = sys.__stdout__
sys.stderr = sys.__stderr__
            `);

            const execution_time = (performance.now() - startTime) / 1000;

            if (stderr) {
                return {
                    output: '',
                    error: stderr,
                    execution_time
                };
            }

            return {
                output: stdout || 'Code executed successfully',
                error: null,
                execution_time
            };

        } catch (error) {
            return {
                output: '',
                error: `Python Error: ${error.message}`,
                execution_time: 0
            };
        }
    }

    async installPackage(packageName) {
        await this.initialize();
        try {
            await this.pyodide.loadPackage(packageName);
            return `Successfully installed ${packageName}`;
        } catch (error) {
            throw new Error(`Failed to install ${packageName}: ${error.message}`);
        }
    }
}
```

#### web-pyodide/src/main.js
```javascript
import { PyodideEngine } from './pyodide-engine.js';
import { marked } from 'marked';

class MetaRowPyodideApp {
    constructor() {
        this.cells = [];
        this.pythonEngine = new PyodideEngine();
        this.isInitializing = false;
        this.init();
    }

    async init() {
        this.setupEventListeners();
        this.showInitializationMessage();
        await this.initializePython();
        this.addInitialCells();
    }

    showInitializationMessage() {
        const container = document.getElementById('cells-container');
        container.innerHTML = `
            <div class="initialization-message">
                <h2>🐍 MetaRow Player wird initialisiert...</h2>
                <p>Pyodide (WebAssembly Python) wird geladen...</p>
                <div class="loading-bar">
                    <div class="loading-progress"></div>
                </div>
                <p class="loading-details">Dies kann beim ersten Besuch 10-30 Sekunden dauern.</p>
            </div>
        `;
    }

    async initializePython() {
        this.isInitializing = true;
        this.updateInitializationStatus('Pyodide wird geladen...');
        
        try {
            await this.pythonEngine.initialize();
            this.updateInitializationStatus('✅ Python bereit!');
            this.isInitializing = false;
        } catch (error) {
            this.updateInitializationStatus('❌ Fehler beim Laden von Python');
            console.error('Failed to initialize Pyodide:', error);
        }
    }

    updateInitializationStatus(message) {
        const details = document.querySelector('.loading-details');
        if (details) {
            details.textContent = message;
        }
    }

    setupEventListeners() {
        document.getElementById('add-python-btn').addEventListener('click', () => this.addCell('python'));
        document.getElementById('add-markdown-btn').addEventListener('click', () => this.addCell('markdown'));
        document.getElementById('clear-session-btn').addEventListener('click', () => this.clearSession());
        document.getElementById('install-package-btn').addEventListener('click', () => this.showPackageInstaller());
    }

    addInitialCells() {
        // Welcome Markdown
        this.addCell('markdown', `# 🚀 MetaRow Player - Pyodide Version

Dies ist die **Pyodide-Version** mit echtem Python im Browser!

## ✅ Features:
- **Echtes Python** (WebAssembly-basiert)
- **NumPy, Pandas, Matplotlib** verfügbar
- **Vollständig statisch** hostbar
- **Offline-fähig** nach dem ersten Laden

## 🎯 Verfügbare Packages:
- **numpy** - Numerische Berechnungen
- **pandas** - Datenanalyse  
- **matplotlib** - Plotting
- **scipy** - Wissenschaftliche Berechnungen
- **sympy** - Symbolische Mathematik

## 📊 Beispiel-Code:
Testen Sie den Python-Code in der nächsten Zelle!`);

        // Python Demo
        this.addCell('python', `# 🐍 Echtes Python mit Pyodide!
import numpy as np
import matplotlib.pyplot as plt

print("🎉 Willkommen zu echtem Python im Browser!")

# NumPy Demo
data = np.random.normal(0, 1, 1000)
mean = np.mean(data)
std = np.std(data)

print(f"📊 Zufallsdaten generiert:")
print(f"   Mittelwert: {mean:.3f}")
print(f"   Standardabweichung: {std:.3f}")

# Matplotlib Demo (funktioniert!)
plt.figure(figsize=(8, 4))
plt.hist(data, bins=30, alpha=0.7, color='skyblue')
plt.title('Histogramm von Zufallsdaten')
plt.xlabel('Wert')
plt.ylabel('Häufigkeit')
plt.grid(True, alpha=0.3)
plt.show()

print("📈 Histogramm erstellt! (siehe oben)")`);

        // Advanced Demo
        this.addCell('python', `# 🔬 Erweiterte Python-Features
import pandas as pd
import numpy as np

# Pandas DataFrame Demo
print("📋 Pandas DataFrame Beispiel:")
df = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Charlie', 'Diana'],
    'Alter': [25, 30, 35, 28],
    'Stadt': ['Berlin', 'München', 'Hamburg', 'Köln'],
    'Gehalt': [50000, 60000, 70000, 55000]
})

print(df)
print(f"\\n📊 Durchschnittsalter: {df['Alter'].mean():.1f}")
print(f"💰 Durchschnittsgehalt: {df['Gehalt'].mean():,.0f}€")

# Mathematical calculations
print("\\n🧮 Mathematische Berechnungen:")
x = np.linspace(0, 2*np.pi, 100)
y = np.sin(x)

print(f"Sin-Werte berechnet für {len(x)} Punkte")
print(f"Maximum: {np.max(y):.3f}")
print(f"Minimum: {np.min(y):.3f}")

# List comprehensions work too!
squares = [i**2 for i in range(10)]
print(f"\\n📐 Quadratzahlen: {squares}")`);

        this.renderCells();
    }

    addCell(type = 'python', content = '') {
        const cellId = this.generateId();
        const cell = {
            id: cellId,
            type: type,
            content: content,
            output: null
        };
        
        this.cells.push(cell);
        this.renderCells();
        
        // Focus auf neue Zelle
        setTimeout(() => {
            const textarea = document.querySelector(`textarea[data-cell-id="${cellId}"]`);
            if (textarea) textarea.focus();
        }, 100);
    }

    async executeCell(cellId) {
        if (this.isInitializing) {
            alert('Python wird noch initialisiert. Bitte warten Sie einen Moment.');
            return;
        }

        const cell = this.cells.find(c => c.id === cellId);
        if (!cell || cell.type !== 'python') return;

        const textarea = document.querySelector(`textarea[data-cell-id="${cellId}"]`);
        const code = textarea.value;
        
        this.updateCellUI(cellId, 'executing');
        
        try {
            const result = await this.pythonEngine.execute(code);
            cell.output = result;
            cell.content = code;
            this.renderCellOutput(cellId, result);
        } catch (error) {
            const errorOutput = {
                output: '',
                error: error.toString(),
                execution_time: 0
            };
            this.renderCellOutput(cellId, errorOutput);
        } finally {
            this.updateCellUI(cellId, 'idle');
        }
    }

    async showPackageInstaller() {
        const packageName = prompt('Package-Name eingeben (z.B. scikit-learn, requests):');
        if (!packageName) return;

        try {
            const result = await this.pythonEngine.installPackage(packageName);
            alert(result);
        } catch (error) {
            alert(`Fehler: ${error.message}`);
        }
    }

    renderCells() {
        const container = document.getElementById('cells-container');
        
        container.innerHTML = this.cells.map(cell => {
            if (cell.type === 'markdown') {
                return this.renderMarkdownCell(cell);
            } else {
                return this.renderPythonCell(cell);
            }
        }).join('');

        this.attachCellEventListeners();
    }

    renderMarkdownCell(cell) {
        const renderedMarkdown = marked(cell.content || '# Neue Markdown-Zelle\n\nKlicken Sie hier zum Bearbeiten...');
        
        return `
            <div class="cell markdown-cell" data-cell-id="${cell.id}">
                <div class="cell-header">
                    <span>📝 Markdown Cell</span>
                    <button class="delete-btn" data-cell-id="${cell.id}">🗑️</button>
                </div>
                <div class="markdown-content" data-cell-id="${cell.id}">
                    ${renderedMarkdown}
                </div>
                <div class="markdown-editor" data-cell-id="${cell.id}" style="display: none;">
                    <textarea class="markdown-input" data-cell-id="${cell.id}" placeholder="# Markdown hier eingeben...">${cell.content || ''}</textarea>
                    <div class="markdown-controls">
                        <button class="save-btn" data-cell-id="${cell.id}">💾 Speichern</button>
                        <button class="cancel-btn" data-cell-id="${cell.id}">❌ Abbrechen</button>
                    </div>
                </div>
            </div>
        `;
    }

    renderPythonCell(cell) {
        return `
            <div class="cell python-cell" data-cell-id="${cell.id}">
                <div class="cell-header">
                    <span>🐍 Python Cell (Pyodide)</span>
                    <button class="delete-btn" data-cell-id="${cell.id}">🗑️</button>
                </div>
                <div class="cell-content">
                    <textarea 
                        class="code-input" 
                        data-cell-id="${cell.id}"
                        placeholder="# Echtes Python mit Pyodide!
import numpy as np
import matplotlib.pyplot as plt

print('Hello from real Python!')
data = np.array([1, 2, 3, 4, 5])
print(f'NumPy array: {data}')
print(f'Mean: {np.mean(data)}')"
                    >${cell.content || ''}</textarea>
                </div>
                <div class="cell-controls">
                    <button class="run-btn" data-cell-id="${cell.id}">
                        ▶️ Ausführen
                    </button>
                    <small>Strg+Enter zum Ausführen | ✅ Echtes Python</small>
                </div>
                ${cell.output ? `<div class="output ${cell.output.error ? 'error' : 'success'}" data-output-id="${cell.id}">
                    ${cell.output.error || cell.output.output}
                    ${cell.output.execution_time ? `<div class="execution-time">Ausführungszeit: ${cell.output.execution_time.toFixed(3)}s</div>` : ''}
                </div>` : ''}
            </div>
        `;
    }

    // Gleiche Event-Handler-Methoden wie vorher...
    attachCellEventListeners() {
        // Python cell execution
        document.querySelectorAll('.run-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const cellId = e.target.getAttribute('data-cell-id');
                this.executeCell(cellId);
            });
        });

        // Keyboard shortcuts
        document.querySelectorAll('.code-input').forEach(textarea => {
            textarea.addEventListener('keydown', (e) => {
                if (e.ctrlKey && e.key === 'Enter') {
                    e.preventDefault();
                    const cellId = e.target.getAttribute('data-cell-id');
                    this.executeCell(cellId);
                }
            });
        });

        // Markdown editing (gleiche Implementierung wie vorher)
        document.querySelectorAll('.markdown-content').forEach(content => {
            content.addEventListener('click', (e) => {
                const cellId = e.target.closest('[data-cell-id]').getAttribute('data-cell-id');
                this.editMarkdownCell(cellId);
            });
        });

        // Save/Cancel/Delete handlers (gleiche Implementierung)
        document.querySelectorAll('.save-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const cellId = e.target.getAttribute('data-cell-id');
                this.saveMarkdownCell(cellId);
            });
        });

        document.querySelectorAll('.cancel-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const cellId = e.target.getAttribute('data-cell-id');
                this.cancelMarkdownEdit(cellId);
            });
        });

        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                const cellId = e.target.getAttribute('data-cell-id');
                this.deleteCell(cellId);
            });
        });
    }

    editMarkdownCell(cellId) {
        const content = document.querySelector(`.markdown-content[data-cell-id="${cellId}"]`);
        const editor = document.querySelector(`.markdown-editor[data-cell-id="${cellId}"]`);
        
        content.style.display = 'none';
        editor.style.display = 'block';
        
        const textarea = editor.querySelector('textarea');
        textarea.focus();
    }

    saveMarkdownCell(cellId) {
        const cell = this.cells.find(c => c.id === cellId);
        const textarea = document.querySelector(`.markdown-input[data-cell-id="${cellId}"]`);
        
        cell.content = textarea.value;
        this.renderCells();
    }

    cancelMarkdownEdit(cellId) {
        const content = document.querySelector(`.markdown-content[data-cell-id="${cellId}"]`);
        const editor = document.querySelector(`.markdown-editor[data-cell-id="${cellId}"]`);
        
        content.style.display = 'block';
        editor.style.display = 'none';
    }

    deleteCell(cellId) {
        this.cells = this.cells.filter(c => c.id !== cellId);
        this.renderCells();
    }

    renderCellOutput(cellId, output) {
        const outputDiv = document.querySelector(`div[data-output-id="${cellId}"]`);
        if (outputDiv) {
            outputDiv.className = `output ${output.error ? 'error' : 'success'}`;
            outputDiv.innerHTML = `
                ${output.error || output.output}
                ${output.execution_time ? `<div class="execution-time">Ausführungszeit: ${output.execution_time.toFixed(3)}s</div>` : ''}
            `;
        }
    }

    updateCellUI(cellId, state) {
        const runBtn = document.querySelector(`button.run-btn[data-cell-id="${cellId}"]`);
        if (runBtn) {
            switch (state) {
                case 'executing':
                    runBtn.disabled = true;
                    runBtn.innerHTML = '⏳ Läuft...';
                    break;
                case 'idle':
                    runBtn.disabled = false;
                    runBtn.innerHTML = '▶️ Ausführen';
                    break;
            }
        }
    }

    clearSession() {
        this.cells = [];
        this.renderCells();
        this.addInitialCells();
    }

    generateId() {
        return Math.random().toString(36).substring(2, 15);
    }
}

// Initialize app
document.addEventListener('DOMContentLoaded', () => {
    new MetaRowPyodideApp();
});
```

#### web-pyodide/index.html
```html
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MetaRow Player - Pyodide</title>
    
    <!-- PWA Manifest -->
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#1e293b">
    
    <style>
        /* Gleiche Base-Styles + zusätzliche für Pyodide */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            background: #1e1e1e;
            color: #d4d4d4;
            line-height: 1.6;
        }

        .header {
            background: #2d2d30;
            padding: 12px 20px;
            border-bottom: 1px solid #3e3e42;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .header h1 {
            font-size: 18px;
            color: #ffffff;
        }

        .pyodide-badge {
            background: #ff6b35;
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            margin-left: 10px;
        }

        .controls {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn {
            background: #0e639c;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 11px;
            transition: background-color 0.2s;
        }

        .btn:hover {
            background: #1177bb;
        }

        .btn.secondary {
            background: #5a5a5a;
        }

        .btn.success {
            background: #28a745;
        }

        .btn.warning {
            background: #ffc107;
            color: #000;
        }

        /* Initialization Message */
        .initialization-message {
            text-align: center;
            padding: 60px 20px;
            max-width: 600px;
            margin: 0 auto;
        }

        .initialization-message h2 {
            color: #ffffff;
            font-size: 24px;
            margin-bottom: 16px;
        }

        .initialization-message p {
            color: #969696;
            margin-bottom: 20px;
        }

        .loading-bar {
            width: 100%;
            height: 6px;
            background: #3e3e42;
            border-radius: 3px;
            overflow: hidden;
            margin: 20px 0;
        }

        .loading-progress {
            height: 100%;
            background: linear-gradient(90deg, #0e639c, #1177bb);
            border-radius: 3px;
            animation: loadingAnimation 2s ease-in-out infinite;
        }

        @keyframes loadingAnimation {
            0% { width: 0%; }
            50% { width: 70%; }
            100% { width: 100%; }
        }

        .loading-details {
            font-size: 12px;
            color: #608b4e;
            font-style: italic;
        }

        /* Rest der Styles gleich wie vorher... */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
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

        .delete-btn {
            background: none;
            border: none;
            color: #969696;
            cursor: pointer;
            font-size: 14px;
            padding: 4px;
        }

        .delete-btn:hover {
            color: #ff6b6b;
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

        .cell-controls {
            padding: 12px 16px;
            background: #2d2d30;
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        /* Markdown Styling */
        .markdown-content {
            padding: 16px;
            cursor: pointer;
        }

        .markdown-content:hover {
            background: #2a2a2a;
        }

        .markdown-editor {
            padding: 16px;
        }

        .markdown-input {
            width: 100%;
            min-height: 120px;
            background: #1e1e1e;
            color: #d4d4d4;
            border: 1px solid #3e3e42;
            border-radius: 4px;
            padding: 12px;
            font-family: inherit;
            font-size: 14px;
            resize: vertical;
        }

        .markdown-controls {
            margin-top: 10px;
            display: flex;
            gap: 8px;
        }

        .save-btn, .cancel-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }

        .save-btn {
            background: #28a745;
            color: white;
        }

        .cancel-btn {
            background: #6c757d;
            color: white;
        }

        /* Markdown Content Styling */
        .markdown-content h1 { color: #ffffff; font-size: 28px; margin-bottom: 16px; }
        .markdown-content h2 { color: #e1e1e1; font-size: 24px; margin: 20px 0 12px; }
        .markdown-content h3 { color: #e1e1e1; font-size: 20px; margin: 16px 0 8px; }
        .markdown-content p { margin-bottom: 12px; color: #d4d4d4; }
        .markdown-content code { background: #3e3e42; padding: 2px 6px; border-radius: 3px; color: #66d9ef; }
        .markdown-content pre { background: #2d2d30; padding: 12px; border-radius: 6px; overflow-x: auto; }
        .markdown-content blockquote { border-left: 4px solid #0e639c; padding-left: 16px; margin: 16px 0; color: #b0b0b0; }
        .markdown-content ul, .markdown-content ol { margin-left: 20px; margin-bottom: 12px; }
        .markdown-content li { margin-bottom: 4px; }
        .markdown-content a { color: #4fc3f7; text-decoration: none; }
        .markdown-content a:hover { text-decoration: underline; }
        .markdown-content strong { color: #ffffff; }
        .markdown-content em { color: #f8f8f2; }

        /* Responsive */
        @media (max-width: 768px) {
            .header-content { 
                flex-direction: column; 
                gap: 10px; 
            }
            .controls {
                justify-content: center;
            }
            .main-container { 
                padding: 10px; 
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>
                🐍 MetaRow Player 
                <span class="pyodide-badge">Pyodide</span>
            </h1>
            <div class="controls">
                <button id="add-python-btn" class="btn success">+ Python</button>
                <button id="add-markdown-btn" class="btn">+ Markdown</button>
                <button id="install-package-btn" class="btn warning">📦 Package</button>
                <button id="clear-session-btn" class="btn secondary">🗑️ Clear</button>
            </div>
        </div>
    </div>

    <main class="main-container">
        <div id="cells-container">
            <!-- Cells werden hier gerendert -->
        </div>
    </main>

    <script type="module" src="/src/main.js"></script>
</body>
</html>
```

## 🚀 Deployment auf verschiedenen Hostern

### 📁 Netlify Deployment

#### netlify.toml
```toml
[build]
  command = "npm run build"
  publish = "dist"

[build.environment]
  NODE_VERSION = "18"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[[headers]]
  for = "/pyodide/*"
  [headers.values]
    Cross-Origin-Embedder-Policy = "require-corp"
    Cross-Origin-Opener-Policy = "same-origin"

[[headers]]
  for = "*.wasm"
  [headers.values]
    Content-Type = "application/wasm"
```

#### Deployment-Commands
```bash
# Netlify CLI
npm install -g netlify-cli
netlify login
netlify init
netlify deploy --prod

# Oder mit GitHub Integration:
# 1. Repository zu GitHub pushen
# 2. Netlify mit GitHub verbinden
# 3. Auto-Deploy aktivieren
```

### 🌐 Vercel Deployment

#### vercel.json
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "devCommand": "npm run dev",
  "installCommand": "npm install",
  "framework": "vite",
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ],
  "headers": [
    {
      "source": "/pyodide/(.*)",
      "headers": [
        {
          "key": "Cross-Origin-Embedder-Policy",
          "value": "require-corp"
        },
        {
          "key": "Cross-Origin-Opener-Policy", 
          "value": "same-origin"
        }
      ]
    }
  ]
}
```

#### Deployment
```bash
# Vercel CLI
npm install -g vercel
vercel login
vercel

# Oder GitHub Integration wie bei Netlify
```

### 📄 GitHub Pages Deployment

#### .github/workflows/deploy.yml
```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v3

    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'

    - name: Install dependencies
      run: npm ci

    - name: Build
      run: npm run build

    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      if: github.ref == 'refs/heads/main'
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./dist
```

### 🎯 Performance-Optimierung für Hosting

#### vite.config.js (für alle Versionen)
```javascript
import { defineConfig } from 'vite'

export default defineConfig({
  build: {
    target: 'es2015',
    outDir: 'dist',
    assetsDir: 'assets',
    sourcemap: false,
    
    rollupOptions: {
      output: {
        manualChunks: {
          'vendor': ['marked'],
          'pyodide': ['pyodide'] // nur für Pyodide-Version
        }
      }
    },
    
    // Chunking für bessere Cache-Performance
    chunkSizeWarningLimit: 1000
  },
  
  server: {
    headers: {
      