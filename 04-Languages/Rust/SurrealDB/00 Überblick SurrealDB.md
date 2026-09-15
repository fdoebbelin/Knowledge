# 📚 **SurrealDB in Rust**

### Was ist SurrealDB?

- **Datenbanktyp:** **Multi-Modell** (primär dokumentenorientiert, aber auch graphenartig nutzbar!)
    
- **Speicherung:**
    
    - Läuft entweder **embedded** (lokale Datei, no server)
        
    - oder **Server-Client-Modus** (klassische Server-Datenbank, über HTTP oder WebSocket ansprechbar)
        
- **Sprache:** SurrealDB selbst ist in **Rust** geschrieben
    
- **Lizenz:** Open-Source (Apache 2.0)
    
- **Besonderheiten:**
    
    - Nutzt eine eigene Query-Sprache (**SurrealQL**, eine Mischung aus SQL und JSON)
        
    - Beziehungen zwischen Dokumenten möglich
        
    - Sehr flexible Schemas: **Schema-frei** oder **Schema-strikt** wählbar
        
    - Unterstützt automatische Versionierung, Berechtigungen, Authentifizierung
        

---

# 🚀 **Wie nutzt man SurrealDB mit Rust?**

## 1. Installation

In `Cargo.toml`:

```toml
[dependencies]
surrealdb = "1.0.0"  # (aktuelle Version prüfen, 2025 vielleicht 1.2.x)
tokio = { version = "1", features = ["full"] }
```

**Hinweis:**  
SurrealDB setzt **async/await** voraus → du brauchst ein Tokio-Runtime.

---

## 2. Rust Beispiel: Verbindung + Query

```rust
use surrealdb::engine::local::Db;
use surrealdb::Surreal;
use surrealdb::sql::Thing;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
struct User {
    name: String,
    age: i32,
}

#[tokio::main]
async fn main() -> surrealdb::Result<()> {
    // Verbindung zu einer lokalen embedded SurrealDB-Datei
    let db = Surreal::new::<Db>("memory").await?;

    // Namespace und Datenbank auswählen (SurrealDB benötigt das)
    db.use_ns("test_namespace").use_db("test_database").await?;

    // Dokument erstellen
    let created: User = db.create("user")
        .content(User {
            name: "Alice".to_string(),
            age: 30,
        })
        .await?;

    println!("Erstellt: {:?}", created);

    // Dokument abfragen
    let result: Option<User> = db.select(("user", "alice_id")).await?;
    println!("Gefunden: {:?}", result);

    Ok(())
}
```

---

## 3. Embedded-Modus vs. Server-Modus

|Modus|Verbindung|Anwendungsfall|
|:--|:--|:--|
|Embedded (lokal)|`surrealdb::engine::local::Db`|Einzeldatei, z.B. Desktop-App|
|Server (remote)|`surrealdb::engine::remote::ws` oder `http`|Serverbetrieb, verteilte Systeme|

- Embedded ist aktuell auf **Memory** oder **File** (`path/to/file.db`) möglich.
    
- **File Storage Beispiel:**
    

```rust
let db = Surreal::new::<surrealdb::engine::local::File>("mydb.surreal").await?;
```

---

## 4. SurrealQL: Eine sehr intuitive Query-Sprache

Beispiel-Querys:

```sql
CREATE user SET name = 'Alice', age = 30;
SELECT * FROM user WHERE age > 20;
UPDATE user:alice_id SET age = 31;
DELETE user:alice_id;
```

Diese kannst du **direkt aus Rust** senden, wenn du lieber SurrealQL-Strings nutzt:

```rust
let response = db.query("SELECT * FROM user WHERE age > 20").await?;
```

---

# ✨ Vorteile von SurrealDB:

- Moderne, JSON-ähnliche Dokumentenstruktur
    
- Extrem flexibel: Dokumente, Relationen, Graphstrukturen
    
- Einfache Migration von SQL- oder Mongo-artigen Projekten
    
- Lokale **Einzeldatei** möglich (embedded)
    
- Rust-native API
    
- Authentifizierung, Rollenmanagement, Echtzeitfunktionen eingebaut
    

---

# ⚠️ Mögliche Schwächen (Stand 2025):

- **Embedded-Modus** noch **nicht 100% stabil** (besonders bei vielen konkurrierenden Writes)
    
- Dokumentation ist gut, aber manche Details zur Embedded-Nutzung sind noch "Work in Progress"
    
- Noch relativ jung verglichen mit z.B. SQLite, aber sehr aktiver Fortschritt
    

---

# 📋 Zusammenfassung:

|Kriterium|PoloDB|SurrealDB|
|:--|:--|:--|
|Entwicklungsstand|reif, aber wenig aktiv|sehr aktiv|
|Embedded Mode|nativ, stabil|in Arbeit, fast stabil|
|Dokumentmodell|einfach (MongoDB-ähnlich)|sehr mächtig (auch Graphstrukturen)|
|Sprache/API|Rust (sehr einfach)|Rust (async, modernes API)|
|Dateibasierte Speicherung|Ja (1 Datei)|Ja (1 Datei möglich)|

➡️ **Wenn du zukunftssicher und feature-reich arbeiten willst:**  
→ **SurrealDB** ist langfristig die bessere Wahl.

➡️ **Wenn du jetzt sofort was extrem Leichtes und Einfachem brauchst:**  
→ **PoloDB** ist schneller produktiv.

---

# ❓ Möchtest du ein vollständiges kleines Beispielprojekt für Rust + SurrealDB von mir bekommen?

Zum Beispiel eine kleine Datenbank-App, die Benutzer speichert, aktualisiert und abfragt? 🚀  
(Dann bekommst du sofort eine lauffähige Grundlage!)