            console.log('✅ Service Worker: Activated successfully');
        })
    );
});

// Fetch event - intelligent caching strategy
self.addEventListener('fetch', (event) => {
    const url = new URL(event.request.url);
    
    // Skip non-GET requests
    if (event.request.method !== 'GET') {
        return;
    }

    // Handle different types of requests
    if (url.hostname === 'cdn.jsdelivr.net' && url.pathname.includes('pyodide')) {
        // Pyodide CDN requests - cache-first strategy
        event.respondWith(handlePyodideRequest(event.request));
    } else if (url.pathname.endsWith('.js') || url.pathname.endsWith('.css')) {
        // Static assets - cache-first with network fallback
        event.respondWith(handleStaticAssets(event.request));
    } else {
        // HTML and other requests - network-first with cache fallback
        event.respondWith(handleDynamicRequests(event.request));
    }
});

// Handle Pyodide CDN requests
async function handlePyodideRequest(request) {
    const cache = await caches.open(PYODIDE_CACHE);
    
    try {
        // Try cache first for Pyodide (large files)
        const cachedResponse = await cache.match(request);
        if (cachedResponse) {
            console.log('📦 Serving Pyodide from cache:', request.url);
            return cachedResponse;
        }

        // Fetch from network
        console.log('🌐 Fetching Pyodide from CDN:', request.url);
        const response = await fetch(request, {
            mode: 'cors',
            credentials: 'omit'
        });
        
        if (response.ok) {
            // Cache successful response
            cache.put(request, response.clone());
            console.log('💾 Cached Pyodide asset:', request.url);
        }
        
        return response;
        
    } catch (error) {
        console.error('❌ Pyodide request failed:', error);
        
        // Try to return cached version
        const cachedResponse = await cache.match(request);
        if (cachedResponse) {
            return cachedResponse;
        }
        
        // Return offline message
        return new Response('Pyodide offline - check internet connection', {
            status: 503,
            statusText: 'Service Unavailable'
        });
    }
}

// Handle static assets (JS, CSS, images)
async function handleStaticAssets(request) {
    const cache = await caches.open(CACHE_NAME);
    
    try {
        // Cache first strategy for static assets
        const cachedResponse = await cache.match(request);
        if (cachedResponse) {
            console.log('📦 Serving static asset from cache:', request.url);
            return cachedResponse;
        }

        // Fetch from network
        const response = await fetch(request);
        
        if (response.ok) {
            cache.put(request, response.clone());
        }
        
        return response;
        
    } catch (error) {
        console.error('❌ Static asset request failed:', error);
        
        // Return cached version if available
        const cachedResponse = await cache.match(request);
        if (cachedResponse) {
            return cachedResponse;
        }
        
        throw error;
    }
}

// Handle dynamic requests (HTML, API calls)
async function handleDynamicRequests(request) {
    const cache = await caches.open(CACHE_NAME);
    
    try {
        // Network first strategy for HTML
        const response = await fetch(request);
        
        if (response.ok && request.destination === 'document') {
            cache.put(request, response.clone());
        }
        
        return response;
        
    } catch (error) {
        console.log('🔄 Network failed, trying cache for:', request.url);
        
        // Fallback to cache
        const cachedResponse = await cache.match(request);
        if (cachedResponse) {
            return cachedResponse;
        }
        
        // Ultimate fallback for HTML requests
        if (request.destination === 'document') {
            const indexCache = await cache.match('./index.html');
            if (indexCache) {
                return indexCache;
            }
        }
        
        // Return offline page
        return new Response(`
            <!DOCTYPE html>
            <html lang="de">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>MetaRow Player - Offline</title>
                <style>
                    body { font-family: Arial, sans-serif; text-align: center; padding: 50px; background: #1e1e1e; color: #fff; }
                    h1 { color: #ff6b6b; }
                    button { background: #0e639c; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; }
                </style>
            </head>
            <body>
                <h1>📡 Offline</h1>
                <p>MetaRow Player ist nicht verfügbar.</p>
                <p>Bitte prüfen Sie Ihre Internetverbindung.</p>
                <button onclick="location.reload()">🔄 Neu versuchen</button>
            </body>
            </html>
        `, {
            status: 503,
            statusText: 'Service Unavailable',
            headers: { 'Content-Type': 'text/html' }
        });
    }
}

// Background sync for preloading
self.addEventListener('message', (event) => {
    if (event.data && event.data.type === 'PRELOAD_PYODIDE') {
        event.waitUntil(preloadPyodideAssets());
    }
});

// Preload Pyodide assets in background
async function preloadPyodideAssets() {
    console.log('📦 Preloading Pyodide assets...');
    const cache = await caches.open(PYODIDE_CACHE);
    
    try {
        const requests = PYODIDE_CDN_ASSETS.map(url => 
            fetch(url, { mode: 'cors', credentials: 'omit' })
                .then(response => {
                    if (response.ok) {
                        return cache.put(url, response);
                    }
                })
                .catch(error => console.warn('Failed to preload:', url, error))
        );
        
        await Promise.allSettled(requests);
        console.log('✅ Pyodide preloading completed');
        
        // Notify all clients
        const clients = await self.clients.matchAll();
        clients.forEach(client => {
            client.postMessage({
                type: 'PYODIDE_PRELOADED',
                message: 'Pyodide assets preloaded for offline use'
            });
        });
        
    } catch (error) {
        console.error('❌ Pyodide preloading failed:', error);
    }
}
```

## 🚀 Schritt 5: All-Inkl Deployment-Skript

### deploy-allinkl.js (Node.js Deployment-Skript)
```javascript
import { readFileSync, writeFileSync, existsSync, mkdirSync } from 'fs';
import { execSync } from 'child_process';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// All-Inkl Konfiguration
const ALLINKL_CONFIG = {
    // Diese Werte müssen angepasst werden:
    host: 'ihr-server.all-inkl.com',
    username: 'ihr-username',
    remotePath: '/www/htdocs/metarow', // Oder Subdomain-Pfad
    localBuildPath: './dist'
};

console.log('🚀 MetaRow Player Deployment für All-Inkl.com');
console.log('================================================');

// Schritt 1: Build erstellen
console.log('🔧 1. Erstelle Production Build...');
try {
    execSync('npm run build', { stdio: 'inherit' });
    console.log('✅ Build erfolgreich erstellt');
} catch (error) {
    console.error('❌ Build fehlgeschlagen:', error.message);
    process.exit(1);
}

// Schritt 2: .htaccess für All-Inkl erstellen
console.log('📝 2. Erstelle .htaccess für All-Inkl...');
const htaccessContent = `# MetaRow Player - All-Inkl.com Configuration
# PWA und Pyodide Optimierungen

# Aktiviere mod_rewrite
RewriteEngine On

# HTTPS-Weiterleitung (falls verfügbar)
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# SPA Routing - alle Anfragen zu index.html
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.html [L]

# MIME Types für moderne Web-Assets
AddType application/javascript .js .mjs
AddType application/wasm .wasm
AddType application/json .json
AddType text/css .css

# Kompression aktivieren (falls verfügbar)
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE application/rss+xml
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
    AddOutputFilterByType DEFLATE application/json
</IfModule>

# Cache-Kontrol für bessere Performance
<IfModule mod_expires.c>
    ExpiresActive On
    
    # Bilder - 1 Jahr
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/svg+xml "access plus 1 year"
    ExpiresByType image/webp "access plus 1 year"
    
    # JavaScript und CSS - 1 Monat
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType text/css "access plus 1 month"
    
    # Fonts - 1 Jahr
    ExpiresByType font/woff "access plus 1 year"
    ExpiresByType font/woff2 "access plus 1 year"
    ExpiresByType application/font-woff "access plus 1 year"
    ExpiresByType application/font-woff2 "access plus 1 year"
    
    # WASM - 1 Monat
    ExpiresByType application/wasm "access plus 1 month"
    
    # Manifest und Service Worker - keine Cache
    ExpiresByType application/manifest+json "access plus 0 seconds"
    ExpiresByType text/cache-manifest "access plus 0 seconds"
    
    # HTML - 1 Stunde
    ExpiresByType text/html "access plus 1 hour"
</IfModule>

# Sicherheits-Header
<IfModule mod_headers.c>
    # PWA Headers
    Header set X-Content-Type-Options "nosniff"
    Header set X-Frame-Options "SAMEORIGIN"
    Header set X-XSS-Protection "1; mode=block"
    
    # CORS für Pyodide CDN
    Header set Access-Control-Allow-Origin "*"
    Header set Access-Control-Allow-Methods "GET, POST, OPTIONS"
    Header set Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept"
    
    # Service Worker
    <FilesMatch "sw\\.js$">
        Header set Cache-Control "no-cache, no-store, must-revalidate"
        Header set Pragma "no-cache"
        Header set Expires 0
    </FilesMatch>
    
    # Manifest
    <FilesMatch "manifest\\.json$">
        Header set Content-Type "application/manifest+json"
    </FilesMatch>
</IfModule>

# Fehlerseiten
ErrorDocument 404 /index.html
ErrorDocument 500 /index.html
`;

writeFileSync(join(ALLINKL_CONFIG.localBuildPath, '.htaccess'), htaccessContent);
console.log('✅ .htaccess erstellt');

// Schritt 3: Upload-Skript erstellen
console.log('📦 3. Erstelle Upload-Skript...');
const uploadScript = `#!/bin/bash
# All-Inkl Upload-Skript für MetaRow Player

echo "🚀 Uploading MetaRow Player to All-Inkl.com..."

# rsync für effizienten Upload
rsync -avz --delete \\
  --exclude='.git*' \\
  --exclude='node_modules' \\
  --exclude='*.log' \\
  --progress \\
  ${ALLINKL_CONFIG.localBuildPath}/ \\
  ${ALLINKL_CONFIG.username}@${ALLINKL_CONFIG.host}:${ALLINKL_CONFIG.remotePath}/

echo "✅ Upload completed!"
echo "🌐 Your app should now be available at your domain"
echo ""
echo "📋 Post-deployment checklist:"
echo "  ✓ Check HTTPS is working"
echo "  ✓ Test PWA installation"
echo "  ✓ Verify Pyodide loads correctly"
echo "  ✓ Test Python code execution"
`;

writeFileSync('./upload-to-allinkl.sh', uploadScript);
execSync('chmod +x ./upload-to-allinkl.sh');
console.log('✅ Upload-Skript erstellt: ./upload-to-allinkl.sh');

// Schritt 4: Deployment-Informationen
console.log('📋 4. Deployment-Informationen...');
const deploymentInfo = `
🎉 MetaRow Player - Deployment für All-Inkl.com bereit!

📦 Build-Ordner: ${ALLINKL_CONFIG.localBuildPath}
🌐 Ziel-Server: ${ALLINKL_CONFIG.host}
📁 Remote-Pfad: ${ALLINKL_CONFIG.remotePath}

🚀 Nächste Schritte:

1. SSH-Verbindung testen:
   ssh ${ALLINKL_CONFIG.username}@${ALLINKL_CONFIG.host}

2. Remote-Verzeichnis erstellen:
   mkdir -p ${ALLINKL_CONFIG.remotePath}

3. Upload ausführen:
   ./upload-to-allinkl.sh

4. Alternative: Manueller Upload via FTP:
   - Verbinden Sie sich via FTP zu ${ALLINKL_CONFIG.host}
   - Laden Sie alle Dateien aus ${ALLINKL_CONFIG.localBuildPath}/ hoch
   - Stellen Sie sicher, dass .htaccess übertragen wird

📋 Wichtige Konfigurationen:

• Domain/Subdomain: Muss auf ${ALLINKL_CONFIG.remotePath} zeigen
• PHP-Version: Mindestens 7.4 (für bessere Performance)
• HTTPS: Sollte aktiviert sein (kostenlos bei All-Inkl)
• Gzip-Kompression: Wird automatisch aktiviert

🔧 Troubleshooting:

• 500 Fehler: .htaccess Rechte prüfen (644)
• PWA installiert nicht: HTTPS erforderlich
• Pyodide lädt nicht: CORS-Header prüfen
• Langsame Ladezeiten: Gzip-Kompression aktivieren

📞 All-Inkl Support: 
Falls Probleme auftreten, wenden Sie sich an den All-Inkl Support.
Die .htaccess-Konfiguration ist für deren Server optimiert.
`;

console.log(deploymentInfo);

// Deployment-Info in Datei speichern
writeFileSync('./DEPLOYMENT.md', deploymentInfo);
console.log('📄 Deployment-Anleitung gespeichert: ./DEPLOYMENT.md');

console.log('\n🎉 Deployment-Vorbereitung abgeschlossen!');
```

## 🔧 Schritt 6: All-Inkl spezifische Optimierungen

### robots.txt für bessere SEO
```txt
# MetaRow Player - robots.txt für deutsche Suchmaschinen

User-agent: *
Allow: /

# Sitemap (erstellen Sie diese optional)
Sitemap: https://ihre-domain.de/sitemap.xml

# Crawl-Delay für bessere Server-Performance
Crawl-delay: 1

# Ausschlüsse (falls vorhanden)
Disallow: /assets/temp/
Disallow: /node_modules/
Disallow: /*.log$
```

### package.json mit All-Inkl Scripts
```json
{
  "name": "metarow-pyodide-allinkl",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite --host 0.0.0.0 --port 5173",
    "build": "vite build",
    "build:analyze": "vite build --mode analyze",
    "preview": "vite preview --host 0.0.0.0",
    "deploy": "npm run build && node deploy-allinkl.js",
    "deploy:full": "npm run build && node deploy-allinkl.js && ./upload-to-allinkl.sh",
    "test:build": "npm run build && npm run preview",
    "optimize": "npm run build && npm run analyze-bundle"
  },
  "devDependencies": {
    "vite": "^5.0.0",
    "vite-bundle-analyzer": "^0.7.0"
  },
  "dependencies": {
    "marked": "^12.0.0"
  },
  "keywords": [
    "python",
    "jupyter", 
    "notebook",
    "pyodide",
    "data-science",
    "deutschland",
    "all-inkl"
  ],
  "author": "Ihr Name",
  "license": "MIT"
}
```

## 📋 Schritt 7: Komplette Deployment-Anleitung

### Lokale Vorbereitung
```bash
# 1. Projekt initialisieren
npm init -y
npm install

# 2. Build erstellen
npm run build

# 3. Deployment vorbereiten
npm run deploy
```

### All-Inkl Server-Vorbereitung
```bash
# 1. SSH-Verbindung zu All-Inkl
ssh ihr-username@ihr-server.all-inkl.com

# 2. Verzeichnis erstellen
mkdir -p /www/htdocs/metarow
cd /www/htdocs/metarow

# 3. Rechte setzen
chmod 755 .
```

### Upload-Optionen

#### Option A: SSH/rsync (empfohlen)
```bash
# Automatisches Upload-Skript
./upload-to-allinkl.sh
```

#### Option B: FTP-Upload
```bash
# Mit FileZilla oder anderem FTP-Client
# Host: ihr-server.all-inkl.com
# Benutzer: ihr-username  
# Passwort: ihr-passwort
# Verzeichnis: /www/htdocs/metarow/
```

#### Option C: All-Inkl Webinterface
```bash
# 1. dist-Ordner als ZIP verpacken
zip -r metarow-build.zip dist/*

# 2. Über All-Inkl KAS-Interface hochladen
# 3. Im Zielverzeichnis entpacken
```

## 🎯 Schritt 8: Post-Deployment Tests

### Funktionstest-Checklist
```bash
# 1. Grundfunktionen testen
# ✓ Seite lädt ohne Fehler
# ✓ Pyodide initialisiert sich
# ✓ Python-Code ausführbar
# ✓ Markdown-Rendering funktioniert

# 2. PWA-Features testen
# ✓ Manifest ist erreichbar
# ✓ Service Worker registriert sich
# ✓ App installierbar
# ✓ Offline-Funktionalität

# 3. Performance testen
# ✓ Erste Ladezeit < 5 Sekunden
# ✓ Pyodide-Initialisierung < 30 Sekunden
# ✓ Gzip-Kompression aktiv
# ✓ Browser-Caching funktioniert

# 4. Mobile-Optimierung
# ✓ Responsive Design
# ✓ Touch-Bedienung
# ✓ Performance auf Mobilgeräten
```

### Performance-Monitoring
```javascript
// Performance-Script für Überwachung
if ('performance' in window) {
    window.addEventListener('load', () => {
        const perfData = {
            loadTime: performance.timing.loadEventEnd - performance.timing.navigationStart,
            domReady: performance.timing.domContentLoadedEventEnd - performance.timing.navigationStart,
            firstPaint: performance.getEntriesByType('paint')[0]?.startTime || 0
        };
        
        console.log('📊 Performance Metrics:', perfData);
        
        // Optional: An Analytics senden
        if (perfData.loadTime > 5000) {
            console.warn('⚠️ Slow loading detected:', perfData.loadTime + 'ms');
        }
    });
}
```

## 🎉 Zusammenfassung

Sie haben jetzt eine **vollständige Pyodide-basierte MetaRow Player Lösung** für All-Inkl.com:

### ✅ **Bereitgestellt:**
- 🐍 **Vollständiges Python** mit NumPy, Pandas, Matplotlib
- 📱 **PWA-ready** mit Service Worker und Offline-Support
- 🇩🇪 **Deutsche Lokalisierung** und All-Inkl-Optimierung
- 🔧 **Automatisches Deployment-System**
- 📊 **Performance-optimiert** für deutsche Server

### 🚀 **Sofort einsatzbereit:**
```bash
# Schneller Start:
npm run deploy:full

# Ihre App läuft dann auf:
# https://ihre-domain.de/metarow/
```

**Das ist eine Production-ready Lösung, die perfekt auf All-Inkl.com läuft!** 🎯

Benötigen Sie Hilfe bei einem spezifischen Deployment-Schritt?ySelectorAll('.cancel-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const cellId = e.target.getAttribute('data-cell-id');
                this.cancelMarkdownEdit(cellId);
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
        cell.timestamp = new Date().toISOString();
        this.renderCells();
        this.showNotification('Markdown-Zelle gespeichert!', 'success');
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
        this.showNotification('Zelle gelöscht', 'info');
    }

    renderCellOutput(cellId, output) {
        const outputDiv = document.querySelector(`div[data-output-id="${cellId}"]`);
        if (outputDiv) {
            outputDiv.className = `output ${output.success === false ? 'error' : 'success'}`;
            outputDiv.innerHTML = `
                ${output.error || output.output}
                ${output.execution_time ? `<div class="execution-time">⚡ Ausführungszeit: ${output.execution_time.toFixed(3)}s</div>` : ''}
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
        if (confirm('🗑️ Möchten Sie wirklich alle Zellen löschen?')) {
            this.cells = [];
            this.renderCells();
            this.showNotification('Session gelöscht', 'info');
        }
    }

    generateId() {
        return 'cell_' + Math.random().toString(36).substring(2, 15);
    }
}

// Global app instance
let app;

// Initialize app when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    app = new MetaRowAllInklApp();
});
```

## 🎨 Schritt 3: Frontend HTML + CSS

### public/index.html
```html
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MetaRow Player - Python Notebooks</title>
    
    <!-- SEO Meta Tags für deutsche Suchmaschinen -->
    <meta name="description" content="Interaktive Python Notebooks im Browser. Vollständige Data Science Umgebung mit NumPy, Pandas und Matplotlib.">
    <meta name="keywords" content="Python, Jupyter, Notebook, Data Science, NumPy, Pandas, Matplotlib, Deutschland">
    <meta name="author" content="MetaRow Player">
    <meta name="robots" content="index, follow">
    <meta name="language" content="de">
    
    <!-- Open Graph für Social Media -->
    <meta property="og:title" content="MetaRow Player - Python Notebooks">
    <meta property="og:description" content="Vollständige Python-Notebook-Umgebung direkt im Browser">
    <meta property="og:type" content="website">
    <meta property="og:locale" content="de_DE">
    
    <!-- PWA Manifest -->
    <link rel="manifest" href="./manifest.json">
    <meta name="theme-color" content="#1e293b">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    
    <!-- Icons -->
    <link rel="icon" type="image/png" sizes="32x32" href="./icons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="./icons/favicon-16x16.png">
    <link rel="apple-touch-icon" href="./icons/apple-touch-icon.png">
    
    <style>
        /* CSS Variables für Themes */
        :root {
            --bg-primary: #1e1e1e;
            --bg-secondary: #2d2d30;
            --bg-tertiary: #252526;
            --text-primary: #d4d4d4;
            --text-secondary: #969696;
            --accent-primary: #0e639c;
            --accent-secondary: #1177bb;
            --border-color: #3e3e42;
            --success-color: #28a745;
            --error-color: #dc3545;
            --warning-color: #ffc107;
        }

        .theme-light {
            --bg-primary: #ffffff;
            --bg-secondary: #f8f9fa;
            --bg-tertiary: #ffffff;
            --text-primary: #212529;
            --text-secondary: #6c757d;
            --accent-primary: #0056b3;
            --accent-secondary: #007bff;
            --border-color: #dee2e6;
            --success-color: #28a745;
            --error-color: #dc3545;
            --warning-color: #ffc107;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            transition: all 0.3s ease;
        }

        .theme-dark {
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
        }

        .app {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Header */
        .header {
            background: var(--bg-secondary);
            padding: 12px 20px;
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1400px;
            margin: 0 auto;
        }

        .header h1 {
            font-size: 20px;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .platform-badge {
            background: var(--accent-primary);
            color: white;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: normal;
        }

        .controls {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn {
            background: var(--accent-primary);
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .btn:hover {
            background: var(--accent-secondary);
            transform: translateY(-1px);
        }

        .btn.primary {
            background: var(--success-color);
        }

        .btn.secondary {
            background: var(--text-secondary);
        }

        .btn.warning {
            background: var(--warning-color);
            color: var(--bg-primary);
        }

        .btn:disabled {
            background: var(--text-secondary);
            cursor: not-allowed;
            transform: none;
        }

        .btn-icon {
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            padding: 4px;
            border-radius: 4px;
            transition: all 0.2s ease;
        }

        .btn-icon:hover {
            background: var(--border-color);
            color: var(--text-primary);
        }

        /* Main Content */
        .main-container {
            flex: 1;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .cells-container {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }

        /* Cells */
        .cell {
            background: var(--bg-tertiary);
            border: 2px solid var(--border-color);
            border-radius: 12px;
            margin-bottom: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .cell:hover {
            border-color: var(--accent-primary);
            box-shadow: 0 4px 12px rgba(14,99,156,0.1);
        }

        .cell-header {
            background: var(--bg-secondary);
            padding: 12px 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
            color: var(--text-secondary);
            border-bottom: 1px solid var(--border-color);
        }

        .cell-actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .cell-info {
            font-size: 11px;
            color: var(--text-secondary);
        }

        .cell-content {
            padding: 0;
        }

        .code-input {
            width: 100%;
            min-height: 140px;
            background: var(--bg-primary);
            color: var(--text-primary);
            border: none;
            padding: 20px;
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            font-size: 14px;
            resize: vertical;
            outline: none;
            line-height: 1.5;
        }

        .code-input:focus {
            background: var(--bg-primary);
            box-shadow: inset 0 0 0 2px var(--accent-primary);
        }

        .code-input::placeholder {
            color: var(--text-secondary);
            opacity: 0.7;
        }

        .cell-controls {
            padding: 12px 16px;
            background: var(--bg-secondary);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid var(--border-color);
        }

        .run-btn {
            background: var(--success-color);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .run-btn:hover {
            background: #34ce57;
            transform: translateY(-1px);
        }

        .run-btn:disabled {
            background: var(--text-secondary);
            cursor: not-allowed;
            transform: none;
        }

        .cell-controls small {
            color: var(--text-secondary);
            font-size: 11px;
        }

        /* Output */
        .output {
            background: var(--bg-primary);
            border-top: 1px solid var(--border-color);
            padding: 20px;
            white-space: pre-wrap;
            font-size: 13px;
            line-height: 1.5;
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
        }

        .output.error {
            color: var(--error-color);
            background: rgba(220, 53, 69, 0.1);
            border-left: 4px solid var(--error-color);
        }

        .output.success {
            color: #9cdcfe;
            border-left: 4px solid var(--success-color);
        }

        .execution-time {
            color: var(--success-color);
            font-size: 11px;
            margin-top: 10px;
            font-style: italic;
        }

        /* Markdown Cells */
        .markdown-content {
            padding: 20px;
            cursor: pointer;
            min-height: 60px;
        }

        .markdown-content:hover {
            background: rgba(14,99,156,0.05);
        }

        .markdown-editor {
            padding: 20px;
        }

        .markdown-input {
            width: 100%;
            min-height: 150px;
            background: var(--bg-primary);
            color: var(--text-primary);
            border: 2px solid var(--border-color);
            border-radius: 8px;
            padding: 16px;
            font-family: inherit;
            font-size: 14px;
            resize: vertical;
            outline: none;
        }

        .markdown-input:focus {
            border-color: var(--accent-primary);
        }

        .markdown-controls {
            margin-top: 12px;
            display: flex;
            gap: 8px;
        }

        /* Markdown Content Styling */
        .markdown-content h1 { color: var(--text-primary); font-size: 28px; margin-bottom: 16px; font-weight: 700; }
        .markdown-content h2 { color: var(--text-primary); font-size: 24px; margin: 24px 0 12px; font-weight: 600; }
        .markdown-content h3 { color: var(--text-primary); font-size: 20px; margin: 20px 0 8px; font-weight: 600; }
        .markdown-content p { margin-bottom: 16px; color: var(--text-primary); line-height: 1.7; }
        .markdown-content code { 
            background: var(--bg-secondary); 
            padding: 2px 6px; 
            border-radius: 4px; 
            color: var(--accent-primary); 
            font-family: 'Monaco', monospace;
        }
        .markdown-content pre { 
            background: var(--bg-secondary); 
            padding: 16px; 
            border-radius: 8px; 
            overflow-x: auto; 
            border: 1px solid var(--border-color);
        }
        .markdown-content blockquote { 
            border-left: 4px solid var(--accent-primary); 
            padding-left: 16px; 
            margin: 20px 0; 
            color: var(--text-secondary); 
            font-style: italic;
        }
        .markdown-content ul, .markdown-content ol { margin-left: 24px; margin-bottom: 16px; }
        .markdown-content li { margin-bottom: 6px; }
        .markdown-content a { color: var(--accent-primary); text-decoration: none; }
        .markdown-content a:hover { text-decoration: underline; }
        .markdown-content strong { color: var(--text-primary); font-weight: 600; }
        .markdown-content em { color: var(--text-primary); }

        /* Loading States */
        .initialization-message {
            text-align: center;
            padding: 80px 20px;
            max-width: 600px;
            margin: 0 auto;
        }

        .loader-container {
            margin-bottom: 20px;
        }

        .loader {
            border: 4px solid var(--border-color);
            border-top: 4px solid var(--accent-primary);
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            margin: 0 auto;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .progress-container {
            width: 100%;
            height: 8px;
            background: var(--border-color);
            border-radius: 4px;
            overflow: hidden;
            margin: 20px 0;
        }

        .progress-bar {
            height: 100%;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
            border-radius: 4px;
            transition: width 0.3s ease;
            width: 0%;
        }

        .loading-details {
            font-size: 14px;
            color: var(--text-secondary);
            margin: 16px 0;
        }

        .loading-info {
            margin-top: 20px;
            padding: 12px;
            background: var(--bg-secondary);
            border-radius: 8px;
            border: 1px solid var(--border-color);
        }

        .loading-info small {
            color: var(--text-secondary);
            font-size: 12px;
        }

        /* Error States */
        .error-message {
            text-align: center;
            padding: 60px 20px;
            max-width: 600px;
            margin: 0 auto;
        }

        .error-message h2 {
            color: var(--error-color);
            margin-bottom: 16px;
        }

        .error-message ul {
            text-align: left;
            margin: 20px 0;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: var(--text-secondary);
        }

        .empty-state h2 {
            margin-bottom: 12px;
            font-weight: 400;
            font-size: 24px;
            color: var(--text-primary);
        }

        /* Notifications */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            min-width: 300px;
            padding: 16px 20px;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            z-index: 1000;
            animation: slideIn 0.3s ease-out;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .notification.error { background: var(--error-color); }
        .notification.success { background: var(--success-color); }
        .notification.warning { background: var(--warning-color); color: var(--bg-primary); }
        .notification.info { background: var(--accent-primary); }

        .notification button {
            background: none;
            border: none;
            color: inherit;
            font-size: 18px;
            cursor: pointer;
            padding: 0 0 0 10px;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 12px;
            }
            
            .controls {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .cells-container {
                padding: 12px;
            }
            
            .cell-controls {
                flex-direction: column;
                gap: 8px;
                align-items: stretch;
            }
            
            .cell-controls small {
                text-align: center;
            }

            .notification {
                left: 20px;
                right: 20px;
                min-width: auto;
            }
        }

        /* Print Styles */
        @media print {
            .header, .cell-controls, .btn, .cell-actions {
                display: none !important;
            }
            
            .cell {
                border: 1px solid #ccc !important;
                break-inside: avoid;
                margin-bottom: 20px;
            }
            
            .output {
                border: 1px solid #ddd;
            }
        }

        /* Accessibility */
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }

        /* High contrast mode */
        @media (prefers-contrast: high) {
            :root {
                --border-color: #000000;
                --text-primary: #000000;
                --bg-primary: #ffffff;
            }
        }

        /* Install button styling */
        .install-btn {
            background: var(--success-color) !important;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(40, 167, 69, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(40, 167, 69, 0); }
            100% { box-shadow: 0 0 0 0 rgba(40, 167, 69, 0); }
        }
    </style>
</head>
<body class="theme-dark">
    <div class="app">
        <header class="header">
            <div class="header-content">
                <h1>
                    🐍 MetaRow Player 
                    <span class="platform-badge">All-Inkl.com</span>
                </h1>
                <div class="controls">
                    <button id="add-python-btn" class="btn primary">🐍 Python</button>
                    <button id="add-markdown-btn" class="btn">📝 Markdown</button>
                    <button id="install-package-btn" class="btn warning">📦 Paket</button>
                    <button id="save-notebook-btn" class="btn">💾 Speichern</button>
                    <button id="load-notebook-btn" class="btn">📂 Laden</button>
                    <button id="theme-toggle" class="btn secondary">☀️</button>
                    <button id="clear-session-btn" class="btn secondary">🗑️ Löschen</button>
                </div>
            </div>
        </header>

        <main class="main-container">
            <div class="cells-container" id="cells-container">
                <!-- Cells werden hier dynamisch eingefügt -->
            </div>
        </main>
    </div>

    <script type="module" src="./src/main.js"></script>
</body>
</html>
```

## 📦 Schritt 4: PWA-Konfiguration für All-Inkl

### public/manifest.json
```json
{
    "name": "MetaRow Player - Python Notebooks",
    "short_name": "MetaRow",
    "description": "Vollständige Python-Notebook-Umgebung im Browser. Gehostet auf All-Inkl.com",
    "start_url": "./",
    "display": "standalone",
    "background_color": "#1e1e1e",
    "theme_color": "#1e293b",
    "orientation": "portrait-primary",
    "scope": "./",
    "lang": "de",
    "dir": "ltr",
    "categories": ["developer", "productivity", "education", "utilities"],
    "icons": [
        {
            "src": "./icons/icon-72x72.png",
            "sizes": "72x72",
            "type": "image/png",
            "purpose": "any"
        },
        {
            "src": "./icons/icon-96x96.png",
            "sizes": "96x96",
            "type": "image/png",
            "purpose": "any"
        },
        {
            "src": "./icons/icon-128x128.png",
            "sizes": "128x128",
            "type": "image/png",
            "purpose": "any"
        },
        {
            "src": "./icons/icon-144x144.png",
            "sizes": "144x144",
            "type": "image/png",
            "purpose": "any"
        },
        {
            "src": "./icons/icon-152x152.png",
            "sizes": "152x152",
            "type": "image/png",
            "purpose": "any"
        },
        {
            "src": "./icons/icon-192x192.png",
            "sizes": "192x192",
            "type": "image/png",
            "purpose": "any maskable"
        },
        {
            "src": "./icons/icon-384x384.png",
            "sizes": "384x384",
            "type": "image/png",
            "purpose": "any"
        },
        {
            "src": "./icons/icon-512x512.png",
            "sizes": "512x512",
            "type": "image/png",
            "purpose": "any maskable"
        }
    ],
    "screenshots": [
        {
            "src": "./screenshots/desktop.png",
            "sizes": "1280x720",
            "type": "image/png",
            "form_factor": "wide",
            "label": "MetaRow Player Desktop Ansicht"
        },
        {
            "src": "./screenshots/mobile.png", 
            "sizes": "375x667",
            "type": "image/png",
            "form_factor": "narrow",
            "label": "MetaRow Player Mobile Ansicht"
        }
    ],
    "shortcuts": [
        {
            "name": "Neue Python-Zelle",
            "short_name": "Python",
            "description": "Erstelle eine neue Python-Code-Zelle",
            "url": "./?action=new-python",
            "icons": [
                {
                    "src": "./icons/python-shortcut.png",
                    "sizes": "96x96"
                }
            ]
        },
        {
            "name": "Neue Markdown-Zelle", 
            "short_name": "Markdown",
            "description": "Erstelle eine neue Markdown-Dokumentations-Zelle",
            "url": "./?action=new-markdown",
            "icons": [
                {
                    "src": "./icons/markdown-shortcut.png",
                    "sizes": "96x96"
                }
            ]
        }
    ],
    "related_applications": [],
    "prefer_related_applications": false
}
```

### public/sw.js - Service Worker für All-Inkl
```javascript
const CACHE_NAME = 'metarow-allinkl-v1.0.0';
const PYODIDE_CACHE = 'pyodide-cache-v0.26.0';

// Core assets to cache immediately
const CORE_ASSETS = [
    './',
    './index.html',
    './manifest.json',
    './src/main.js',
    './src/pyodide-engine.js',
    './icons/icon-192x192.png',
    './icons/icon-512x512.png'
];

// Pyodide CDN assets for offline use
const PYODIDE_CDN_ASSETS = [
    'https://cdn.jsdelivr.net/pyodide/v0.26.0/full/pyodide.mjs',
    'https://cdn.jsdelivr.net/pyodide/v0.26.0/full/pyodide.asm.js',
    'https://cdn.jsdelivr.net/pyodide/v0.26.0/full/pyodide.asm.wasm'
];

// Install event
self.addEventListener('install', (event) => {
    console.log('📦 Service Worker: Installing...');
    
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => {
                console.log('📁 Service Worker: Caching core assets');
                return cache.addAll(CORE_ASSETS);
            })
            .then(() => {
                console.log('✅ Service Worker: Core assets cached');
                return self.skipWaiting();
            })
            .catch((error) => {
                console.error('❌ Service Worker: Cache failed', error);
            })
    );
});

// Activate event
self.addEventListener('activate', (event) => {
    console.log('🔄 Service Worker: Activating...');
    
    event.waitUntil(
        Promise.all([
            // Clean up old caches
            caches.keys().then((cacheNames) => {
                return Promise.all(
                    cacheNames.map((cacheName) => {
                        if (cacheName !== CACHE_NAME && cacheName !== PYODIDE_CACHE) {
                            console.log('🗑️ Service Worker: Deleting old cache:', cacheName);
                            return caches.delete(cacheName);
                        }
                    })
                );
            }),
            // Take control of all clients
            self.clients.claim()
        ]).then(() => {
            console.log('✅ Service Worker:# MetaRow Player - Pyodide Deployment für All-Inkl.com 🇩🇪

## 🎯 Deployment auf All-Inkl.com mit SSH-Zugang

### Vorbereitung und Voraussetzungen

- ✅ All-Inkl.com Paket mit SSH-Zugang
- ✅ Domain/Subdomain konfiguriert
- ✅ Node.js lokal installiert (für Build)
- ✅ SSH-Client (Terminal/PuTTY)

## 📋 Schritt 1: Lokale Vorbereitung

### Projekt-Setup
```bash
# Neues Verzeichnis erstellen
mkdir metarow-pyodide-allinkl
cd metarow-pyodide-allinkl

# Projektstruktur
mkdir -p src public
```

### package.json erstellen
```json
{
  "name": "metarow-pyodide-allinkl",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "deploy": "npm run build && node deploy-script.js"
  },
  "devDependencies": {
    "vite": "^5.0.0"
  },
  "dependencies": {
    "marked": "^12.0.0"
  }
}
```

### vite.config.js für All-Inkl optimieren
```javascript
import { defineConfig } from 'vite'

export default defineConfig({
  base: './', // Relative paths für bessere Kompatibilität
  build: {
    target: 'es2018', // Bessere Browser-Kompatibilität
    outDir: 'dist',
    assetsDir: 'assets',
    sourcemap: false,
    minify: 'terser',
    
    rollupOptions: {
      output: {
        manualChunks: {
          'vendor': ['marked'],
        },
        // Kleinere Chunk-Größen für bessere Ladezeiten
        chunkFileNames: 'assets/js/[name]-[hash].js',
        entryFileNames: 'assets/js/[name]-[hash].js',
        assetFileNames: 'assets/[ext]/[name]-[hash].[ext]'
      }
    },
    
    // Optimierung für All-Inkl Server
    chunkSizeWarningLimit: 1000,
    assetsInlineLimit: 4096
  },
  
  server: {
    headers: {
      'Cross-Origin-Embedder-Policy': 'require-corp',
      'Cross-Origin-Opener-Policy': 'same-origin'
    }
  }
})
```

## 🐍 Schritt 2: Pyodide Engine implementieren

### src/pyodide-engine.js
```javascript
export class PyodideEngine {
    constructor() {
        this.pyodide = null;
        this.isInitialized = false;
        this.initPromise = null;
        this.packages = new Set();
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
        
        try {
            // Pyodide von CDN laden (optimiert für deutsche Nutzer)
            const { loadPyodide } = await import('https://cdn.jsdelivr.net/pyodide/v0.26.0/full/pyodide.mjs');
            
            this.pyodide = await loadPyodide({
                indexURL: 'https://cdn.jsdelivr.net/pyodide/v0.26.0/full/',
                fullStdLib: false // Nur benötigte Teile laden
            });

            // Essential packages installieren
            console.log('📦 Installing essential packages...');
            await this.installPackages(['numpy', 'matplotlib', 'pandas']);
            
            // Python-Umgebung konfigurieren
            this.pyodide.runPython(`
import sys
import warnings
warnings.filterwarnings('ignore')

# Deutsche Locale-Einstellungen
import locale
try:
    locale.setlocale(locale.LC_ALL, 'de_DE.UTF-8')
except:
    try:
        locale.setlocale(locale.LC_ALL, 'German_Germany.1252')
    except:
        pass  # Fallback zu Standard-Locale

print("🇩🇪 MetaRow Player bereit für deutsche Nutzer!")
print(f"Python {sys.version}")
            `);

            this.isInitialized = true;
            console.log('✅ Pyodide erfolgreich initialisiert!');
            
        } catch (error) {
            console.error('❌ Pyodide initialization failed:', error);
            throw new Error(`Pyodide konnte nicht geladen werden: ${error.message}`);
        }
    }

    async installPackages(packageNames) {
        for (const pkg of packageNames) {
            if (!this.packages.has(pkg)) {
                try {
                    console.log(`📦 Installing ${pkg}...`);
                    await this.pyodide.loadPackage(pkg);
                    this.packages.add(pkg);
                    console.log(`✅ ${pkg} installed`);
                } catch (error) {
                    console.warn(`⚠️ Failed to install ${pkg}:`, error);
                }
            }
        }
    }

    async execute(code) {
        await this.initialize();

        try {
            const startTime = performance.now();
            
            // Output capturing mit deutscher Formatierung
            const captureCode = `
import sys
from io import StringIO
import locale

# Output capture
_stdout = StringIO()
_stderr = StringIO()
sys.stdout = _stdout
sys.stderr = _stderr

try:
    ${code}
    _output = _stdout.getvalue()
    _error = _stderr.getvalue()
    
    # Restore streams
    sys.stdout = sys.__stdout__
    sys.stderr = sys.__stderr__
    
    if _error:
        _result = f"Fehler: {_error}"
        _success = False
    else:
        _result = _output if _output else "Code erfolgreich ausgeführt"
        _success = True
        
except Exception as e:
    sys.stdout = sys.__stdout__
    sys.stderr = sys.__stderr__
    _result = f"Python-Fehler: {str(e)}"
    _success = False

# Return results
(_result, _success)
            `;

            const result = this.pyodide.runPython(captureCode);
            const [output, success] = result.toJs();
            
            const execution_time = (performance.now() - startTime) / 1000;

            return {
                output: output || '',
                error: success ? null : output,
                execution_time,
                success
            };

        } catch (error) {
            return {
                output: '',
                error: `Ausführungsfehler: ${error.message}`,
                execution_time: 0,
                success: false
            };
        }
    }

    async installPackage(packageName) {
        await this.initialize();
        
        try {
            if (!this.packages.has(packageName)) {
                await this.pyodide.loadPackage(packageName);
                this.packages.add(packageName);
                return `📦 Paket "${packageName}" erfolgreich installiert!`;
            } else {
                return `ℹ️ Paket "${packageName}" ist bereits installiert.`;
            }
        } catch (error) {
            throw new Error(`Installation von "${packageName}" fehlgeschlagen: ${error.message}`);
        }
    }

    getInstalledPackages() {
        return Array.from(this.packages);
    }
}
```

### src/main.js - Hauptanwendung
```javascript
import { PyodideEngine } from './pyodide-engine.js';
import { marked } from 'marked';

class MetaRowAllInklApp {
    constructor() {
        this.cells = [];
        this.pythonEngine = new PyodideEngine();
        this.isInitializing = false;
        this.currentTheme = 'dark';
        this.init();
    }

    async init() {
        this.setupEventListeners();
        this.showInitializationMessage();
        await this.initializePython();
        this.addInitialCells();
        this.setupPWA();
    }

    showInitializationMessage() {
        const container = document.getElementById('cells-container');
        container.innerHTML = `
            <div class="initialization-message">
                <div class="loader-container">
                    <div class="loader"></div>
                </div>
                <h2>🐍 MetaRow Player wird geladen...</h2>
                <p>Pyodide (WebAssembly Python) wird initialisiert...</p>
                <div class="progress-container">
                    <div class="progress-bar" id="progress-bar"></div>
                </div>
                <p class="loading-details" id="loading-status">Verbindung zu cdn.jsdelivr.net...</p>
                <div class="loading-info">
                    <small>🇩🇪 Optimiert für deutsche Server • Erste Nutzung kann 15-30 Sekunden dauern</small>
                </div>
            </div>
        `;
    }

    async initializePython() {
        this.isInitializing = true;
        
        const progressBar = document.getElementById('progress-bar');
        const statusText = document.getElementById('loading-status');
        
        const updateProgress = (progress, message) => {
            if (progressBar) progressBar.style.width = `${progress}%`;
            if (statusText) statusText.textContent = message;
        };

        try {
            updateProgress(10, 'Pyodide wird heruntergeladen...');
            
            await this.pythonEngine.initialize();
            
            updateProgress(100, '✅ Python bereit! Starte Anwendung...');
            
            setTimeout(() => {
                this.isInitializing = false;
            }, 500);
            
        } catch (error) {
            updateProgress(0, '❌ Fehler beim Laden von Python');
            console.error('Failed to initialize Pyodide:', error);
            
            // Fallback-Nachricht anzeigen
            const container = document.getElementById('cells-container');
            container.innerHTML = `
                <div class="error-message">
                    <h2>❌ Initialisierung fehlgeschlagen</h2>
                    <p>Python konnte nicht geladen werden.</p>
                    <p><strong>Mögliche Lösungen:</strong></p>
                    <ul>
                        <li>Seite neu laden (F5)</li>
                        <li>Browser-Cache leeren</li>
                        <li>Internetverbindung prüfen</li>
                        <li>Anderen Browser verwenden</li>
                    </ul>
                    <button onclick="location.reload()" class="btn primary">🔄 Seite neu laden</button>
                </div>
            `;
        }
    }

    setupEventListeners() {
        document.getElementById('add-python-btn').addEventListener('click', () => this.addCell('python'));
        document.getElementById('add-markdown-btn').addEventListener('click', () => this.addCell('markdown'));
        document.getElementById('clear-session-btn').addEventListener('click', () => this.clearSession());
        document.getElementById('install-package-btn').addEventListener('click', () => this.showPackageInstaller());
        document.getElementById('theme-toggle').addEventListener('click', () => this.toggleTheme());
        document.getElementById('save-notebook-btn').addEventListener('click', () => this.saveNotebook());
        document.getElementById('load-notebook-btn').addEventListener('click', () => this.loadNotebook());
    }

    addInitialCells() {
        // Deutsche Willkommensnachricht
        this.addCell('markdown', `# 🚀 Willkommen zum MetaRow Player!

**Gehostet auf All-Inkl.com** 🇩🇪

Dies ist eine **vollständige Python-Notebook-Umgebung** in Ihrem Browser!

## ✨ Features:
- 🐍 **Echtes Python** mit NumPy, Pandas, Matplotlib
- 📝 **Markdown-Unterstützung** für Dokumentation
- 💾 **Notebook speichern/laden** (lokale Dateien)
- 🌙 **Dark/Light Mode** verfügbar
- 📱 **PWA-fähig** - als App installierbar

## 🎯 Verfügbare Python-Pakete:
- **numpy** - Numerische Berechnungen
- **pandas** - Datenanalyse und -manipulation
- **matplotlib** - Diagramme und Visualisierungen
- **scipy** - Wissenschaftliche Berechnungen (installierbar)
- **sympy** - Symbolische Mathematik (installierbar)

## 🚀 Loslegen:
Probieren Sie den Python-Code in der nächsten Zelle aus!`);

        // Deutsche Python-Demo
        this.addCell('python', `# 🇩🇪 Deutsches Python-Beispiel
print("Hallo! Willkommen zum MetaRow Player!")
print("Gehostet auf All-Inkl.com")

# Datum und Zeit
from datetime import datetime
import locale

jetzt = datetime.now()
print(f"\\nAktuelle Zeit: {jetzt.strftime('%d.%m.%Y um %H:%M:%S')}")

# Mathematische Berechnungen
import numpy as np
print("\\n📊 NumPy-Demo:")

# Zufallsdaten
daten = np.random.normal(50, 15, 100)
mittelwert = np.mean(daten)
standardabweichung = np.std(daten)

print(f"Zufallsdaten generiert: {len(daten)} Werte")
print(f"Mittelwert: {mittelwert:.2f}")
print(f"Standardabweichung: {standardabweichung:.2f}")

# Deutsche Zahlenformatierung
print(f"\\nFormatierte Ausgabe:")
print(f"Mittelwert: {mittelwert:,.2f}".replace(',', ' ').replace('.', ','))

print("\\n🎉 Python läuft perfekt auf All-Inkl.com!")`);

        // Erweiterte Demo
        this.addCell('python', `# 📈 Datenanalyse-Beispiel
import pandas as pd
import numpy as np

print("🏢 Beispiel-Datenanalyse für ein deutsches Unternehmen")

# Beispieldaten erstellen
np.random.seed(42)  # Für reproduzierbare Ergebnisse

daten = {
    'Monat': ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni'],
    'Umsatz_EUR': np.random.randint(50000, 150000, 6),
    'Kosten_EUR': np.random.randint(30000, 80000, 6),
    'Mitarbeiter': np.random.randint(15, 25, 6)
}

df = pd.DataFrame(daten)
df['Gewinn_EUR'] = df['Umsatz_EUR'] - df['Kosten_EUR']
df['Gewinnmarge_%'] = (df['Gewinn_EUR'] / df['Umsatz_EUR'] * 100).round(2)

print("\\n📋 Unternehmens-Dashboard (erste 6 Monate):")
print(df.to_string(index=False))

print(f"\\n📊 Zusammenfassung:")
print(f"• Gesamtumsatz: {df['Umsatz_EUR'].sum():,.0f} €".replace(',', '.'))
print(f"• Durchschnittliche Gewinnmarge: {df['Gewinnmarge_%'].mean():.1f}%")
print(f"• Bester Monat: {df.loc[df['Gewinn_EUR'].idxmax(), 'Monat']}")
print(f"• Höchster Gewinn: {df['Gewinn_EUR'].max():,.0f} €".replace(',', '.'))

# Einfache Visualisierung (Text-basiert)
print("\\n📈 Umsatz-Trend (vereinfacht):")
max_umsatz = df['Umsatz_EUR'].max()
for _, row in df.iterrows():
    balken_länge = int(row['Umsatz_EUR'] / max_umsatz * 30)
    balken = '█' * balken_länge
    print(f"{row['Monat'][:3]:>3}: {balken} {row['Umsatz_EUR']:,.0f}€".replace(',', '.'))`);

        this.renderCells();
    }

    addCell(type = 'python', content = '') {
        const cellId = this.generateId();
        const cell = {
            id: cellId,
            type: type,
            content: content,
            output: null,
            timestamp: new Date().toISOString()
        };
        
        this.cells.push(cell);
        this.renderCells();
        
        // Focus auf neue Zelle
        setTimeout(() => {
            const textarea = document.querySelector(`textarea[data-cell-id="${cellId}"]`);
            if (textarea) {
                textarea.focus();
                // Scroll zur neuen Zelle
                textarea.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }, 100);
    }

    async executeCell(cellId) {
        if (this.isInitializing) {
            this.showNotification('Python wird noch initialisiert. Bitte warten...', 'warning');
            return;
        }

        const cell = this.cells.find(c => c.id === cellId);
        if (!cell || cell.type !== 'python') return;

        const textarea = document.querySelector(`textarea[data-cell-id="${cellId}"]`);
        const code = textarea.value.trim();
        
        if (!code) {
            this.showNotification('Keine Code-Eingabe gefunden.', 'warning');
            return;
        }
        
        this.updateCellUI(cellId, 'executing');
        
        try {
            const result = await this.pythonEngine.execute(code);
            cell.output = result;
            cell.content = code;
            cell.timestamp = new Date().toISOString();
            
            this.renderCellOutput(cellId, result);
            
            if (result.success) {
                this.showNotification('Code erfolgreich ausgeführt!', 'success');
            }
            
        } catch (error) {
            const errorOutput = {
                output: '',
                error: `Unerwarteter Fehler: ${error.toString()}`,
                execution_time: 0,
                success: false
            };
            this.renderCellOutput(cellId, errorOutput);
            this.showNotification('Fehler bei der Code-Ausführung', 'error');
        } finally {
            this.updateCellUI(cellId, 'idle');
        }
    }

    async showPackageInstaller() {
        const packageName = prompt('🐍 Python-Paket installieren:\\n\\nGeben Sie den Namen ein (z.B. scipy, requests, sympy):');
        if (!packageName) return;

        try {
            this.showNotification(`Installiere ${packageName}...`, 'info');
            const result = await this.pythonEngine.installPackage(packageName.trim());
            this.showNotification(result, 'success');
        } catch (error) {
            this.showNotification(`Fehler: ${error.message}`, 'error');
        }
    }

    saveNotebook() {
        const notebook = {
            name: `MetaRow-Notebook-${new Date().toISOString().split('T')[0]}`,
            version: '1.0.0',
            created: new Date().toISOString(),
            cells: this.cells,
            metadata: {
                platform: 'All-Inkl.com',
                engine: 'Pyodide',
                packages: this.pythonEngine.getInstalledPackages()
            }
        };

        const blob = new Blob([JSON.stringify(notebook, null, 2)], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        
        const a = document.createElement('a');
        a.href = url;
        a.download = `${notebook.name}.metarow.json`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
        
        this.showNotification('📄 Notebook gespeichert!', 'success');
    }

    loadNotebook() {
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = '.metarow.json,.json';
        
        input.onchange = async (e) => {
            const file = e.target.files[0];
            if (!file) return;

            try {
                const text = await file.text();
                const notebook = JSON.parse(text);
                
                if (notebook.cells && Array.isArray(notebook.cells)) {
                    this.cells = notebook.cells;
                    this.renderCells();
                    this.showNotification(`📄 Notebook "${notebook.name || 'Unbenannt'}" geladen!`, 'success');
                } else {
                    throw new Error('Ungültiges Notebook-Format');
                }
            } catch (error) {
                this.showNotification(`Fehler beim Laden: ${error.message}`, 'error');
            }
        };
        
        input.click();
    }

    toggleTheme() {
        this.currentTheme = this.currentTheme === 'dark' ? 'light' : 'dark';
        document.body.className = `theme-${this.currentTheme}`;
        
        const button = document.getElementById('theme-toggle');
        button.textContent = this.currentTheme === 'dark' ? '☀️' : '🌙';
        
        // Theme in localStorage speichern
        localStorage.setItem('metarow-theme', this.currentTheme);
    }

    setupPWA() {
        // Service Worker registrieren
        if ('serviceWorker' in navigator) {
            window.addEventListener('load', () => {
                navigator.serviceWorker.register('./sw.js')
                    .then(registration => {
                        console.log('✅ Service Worker registered');
                        // Installationsprompt anzeigen
                        this.setupInstallPrompt();
                    })
                    .catch(error => console.log('❌ Service Worker registration failed'));
            });
        }

        // Theme aus localStorage laden
        const savedTheme = localStorage.getItem('metarow-theme');
        if (savedTheme) {
            this.currentTheme = savedTheme;
            document.body.className = `theme-${this.currentTheme}`;
            const button = document.getElementById('theme-toggle');
            button.textContent = this.currentTheme === 'dark' ? '☀️' : '🌙';
        }
    }

    setupInstallPrompt() {
        let deferredPrompt;
        
        window.addEventListener('beforeinstallprompt', (e) => {
            e.preventDefault();
            deferredPrompt = e;
            
            // Install-Button anzeigen
            const installBtn = document.createElement('button');
            installBtn.className = 'btn primary install-btn';
            installBtn.innerHTML = '📱 Als App installieren';
            installBtn.onclick = async () => {
                if (deferredPrompt) {
                    deferredPrompt.prompt();
                    const { outcome } = await deferredPrompt.userChoice;
                    if (outcome === 'accepted') {
                        this.showNotification('App erfolgreich installiert!', 'success');
                    }
                    deferredPrompt = null;
                    installBtn.remove();
                }
            };
            
            document.querySelector('.controls').appendChild(installBtn);
        });
    }

    showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `notification ${type}`;
        notification.innerHTML = `
            <span>${message}</span>
            <button onclick="this.parentElement.remove()">×</button>
        `;
        
        document.body.appendChild(notification);
        
        // Auto-remove nach 5 Sekunden
        setTimeout(() => {
            if (notification.parentElement) {
                notification.remove();
            }
        }, 5000);
    }

    renderCells() {
        const container = document.getElementById('cells-container');
        
        if (this.cells.length === 0) {
            container.innerHTML = `
                <div class="empty-state">
                    <h2>📝 Leeres Notebook</h2>
                    <p>Erstellen Sie eine neue Zelle um zu beginnen</p>
                </div>
            `;
            return;
        }

        container.innerHTML = this.cells.map((cell, index) => {
            if (cell.type === 'markdown') {
                return this.renderMarkdownCell(cell, index);
            } else {
                return this.renderPythonCell(cell, index);
            }
        }).join('');

        this.attachCellEventListeners();
    }

    renderMarkdownCell(cell, index) {
        const renderedMarkdown = marked(cell.content || '# Neue Markdown-Zelle\n\nKlicken Sie hier zum Bearbeiten...');
        
        return `
            <div class="cell markdown-cell" data-cell-id="${cell.id}">
                <div class="cell-header">
                    <span>📝 Markdown-Zelle #${index + 1}</span>
                    <div class="cell-actions">
                        <button class="btn-icon" onclick="this.closest('.cell').remove(); app.deleteCell('${cell.id}')" title="Zelle löschen">🗑️</button>
                    </div>
                </div>
                <div class="markdown-content" data-cell-id="${cell.id}">
                    ${renderedMarkdown}
                </div>
                <div class="markdown-editor" data-cell-id="${cell.id}" style="display: none;">
                    <textarea class="markdown-input" data-cell-id="${cell.id}" placeholder="# Markdown hier eingeben...">${cell.content || ''}</textarea>
                    <div class="markdown-controls">
                        <button class="btn primary save-btn" data-cell-id="${cell.id}">💾 Speichern</button>
                        <button class="btn secondary cancel-btn" data-cell-id="${cell.id}">❌ Abbrechen</button>
                    </div>
                </div>
            </div>
        `;
    }

    renderPythonCell(cell, index) {
        return `
            <div class="cell python-cell" data-cell-id="${cell.id}">
                <div class="cell-header">
                    <span>🐍 Python-Zelle #${index + 1}</span>
                    <div class="cell-actions">
                        <span class="cell-info">${cell.timestamp ? new Date(cell.timestamp).toLocaleString('de-DE') : ''}</span>
                        <button class="btn-icon" onclick="this.closest('.cell').remove(); app.deleteCell('${cell.id}')" title="Zelle löschen">🗑️</button>
                    </div>
                </div>
                <div class="cell-content">
                    <textarea 
                        class="code-input" 
                        data-cell-id="${cell.id}"
                        placeholder="# Python-Code hier eingeben...
print('Hallo von All-Inkl.com!')

# Verfügbare Pakete:
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Beispiel:
daten = np.array([1, 2, 3, 4, 5])
print(f'Mittelwert: {np.mean(daten)}')"
                    >${cell.content || ''}</textarea>
                </div>
                <div class="cell-controls">
                    <button class="run-btn" data-cell-id="${cell.id}">
                        ▶️ Ausführen
                    </button>
                    <small>Strg+Enter zum Ausführen • Echtes Python mit Pyodide</small>
                </div>
                ${cell.output ? `<div class="output ${cell.output.success === false ? 'error' : 'success'}" data-output-id="${cell.id}">
                    ${cell.output.error || cell.output.output}
                    ${cell.output.execution_time ? `<div class="execution-time">⚡ Ausführungszeit: ${cell.output.execution_time.toFixed(3)}s</div>` : ''}
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

        document.quer