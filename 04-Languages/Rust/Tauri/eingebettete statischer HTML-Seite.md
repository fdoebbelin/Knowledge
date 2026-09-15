Perfekt, ich zeige dir jetzt **wie du ein reines Rust + Tauri-Projekt erstellst**, **ohne Node.js** und **mit eingebetteter statischer HTML-Seite**.  
➡️ **Kein npm, kein Webpack, kein Vite** – einfach nur Rust, Tauri und deine HTML-Datei.

---

# 🏗️ Schritt-für-Schritt Anleitung (reines Tauri-Projekt)

---

### 1. Neues Rust-Projekt erstellen

```sh
cargo new static-html
cd static-html
```

---

### 2. Tauri in dein Projekt integrieren

**Tauri-Abhängigkeiten hinzufügen:**

Öffne die `Cargo.toml` und ergänze:

```toml
[dependencies]
tauri = { version = "2.5.1" }
```

---

### 3. Tauri-Projekt initialisieren

Jetzt:

```bash
cargo tauri init
```

- Wenn gefragt: **Frontend-Path** → einfach **"dist"** eintragen (du erstellst gleich einen Ordner dafür).
    

---

### 4. Deine HTML-Seite hinzufügen

Erstelle einen neuen Ordner im Projekt:

```bash
mkdir dist
```

Dort hinein legst du z.B. eine sehr einfache `index.html`:

```html
<!-- dist/index.html -->
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>Meine Tauri-App</title>
</head>
<body>
    <h1>Hallo Welt!</h1>
    <p>Das ist eine reine Tauri-App ohne Node.js.</p>
</body>
</html>
```

---

### 5. `tauri.conf.json` anpassen

In `src-tauri/tauri.conf.json` musst du Tauri sagen, dass es deine statischen HTML-Dateien laden soll.

Ändere:

```json
"build": {
  "beforeBuildCommand": "",
  "beforeDevCommand": "",
  "devPath": "../dist",
  "distDir": "../dist"
},
```

**Wichtig:**

- `devPath`: Wo die Dateien im "dev"-Modus liegen.
- `distDir`: Wo sie beim "build" gefunden werden.
    

---

Zusätzlich sollte in deiner Konfiguration `"embeddedServer.active": true` stehen:

```json
"embeddedServer": {
  "active": true
}
```

👉 Dadurch werden HTML/CSS/JS direkt **in die Binärdatei eingebettet**!

---

### 6. App starten oder bauen

**Zum Entwickeln:**

```bash
cargo tauri dev
```

**Für die fertige Einzeldatei:**

```bash
cargo tauri build
```

- Danach findest du die fertige Einzeldatei (z.B. `meine-tauri-app.exe`) unter:
    
    ```
    src-tauri/target/release/bundle/
    ```
    

---

# ✅ Zusammengefasst:

|Schritt|Beschreibung|
|:--|:--|
|Rust-Projekt erstellen|`cargo new`|
|Tauri initialisieren|`cargo tauri init`|
|HTML-Seite in `dist/` ablegen|manuell|
|`tauri.conf.json` anpassen|`dist` verwenden|
|App bauen oder entwickeln|`cargo tauri build` oder `cargo tauri dev`|

---

# 💡 Warum das geil ist:
- Keine Abhängigkeit von Node.js / npm / package.json.
- Keine unnötigen Tools wie Vite/Webpack.
- Sehr kleine Apps (~3–10 MB).
- Blitzschneller Build, weil Rust extrem schnell kompiliert.
- Komplett offlinefähig (keine externen Ressourcen).