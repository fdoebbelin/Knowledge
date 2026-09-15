Super, dann bauen wir jetzt eine kleine **interaktive CLI-Anwendung** in Rust,  
die auf **SurrealDB** basiert:  
✅ Benutzer anlegen  
✅ Benutzer auflisten  
✅ Benutzer aktualisieren  
✅ Benutzer löschen  
✅ Alles per Texteingabe im Terminal

---

# 🛠 Projekt: "User Manager CLI" mit SurrealDB

---

## 1. Projektstruktur

Terminal:

```bash
cargo new surrealdb_user_cli
cd surrealdb_user_cli
```

---

## 2. `Cargo.toml`

```toml
[package]
name = "surrealdb_user_cli"
version = "0.1.0"
edition = "2021"

[dependencies]
tokio = { version = "1", features = ["full"] }
surrealdb = "1.0.0"  # aktuelle Version
serde = { version = "1.0", features = ["derive"] }
dialoguer = "0.11"    # für hübsche Eingaben im Terminal
```

---

## 3. `src/main.rs`

```rust
use dialoguer::{Input, Select};
use serde::{Deserialize, Serialize};
use surrealdb::engine::local::File;
use surrealdb::Surreal;
use surrealdb::sql::Thing;

#[derive(Debug, Serialize, Deserialize)]
struct User {
    name: String,
    age: i32,
}

#[tokio::main]
async fn main() -> surrealdb::Result<()> {
    // Verbindung zur lokalen Datei
    let db = Surreal::new::<File>("users.surreal").await?;
    db.use_ns("app").use_db("users").await?;

    loop {
        println!("\n==== User Manager CLI ====");
        let selection = Select::new()
            .item("Benutzer hinzufügen")
            .item("Alle Benutzer auflisten")
            .item("Benutzer aktualisieren")
            .item("Benutzer löschen")
            .item("Beenden")
            .default(0)
            .interact()
            .unwrap();

        match selection {
            0 => add_user(&db).await?,
            1 => list_users(&db).await?,
            2 => update_user(&db).await?,
            3 => delete_user(&db).await?,
            4 => {
                println!("Tschüss!");
                break;
            }
            _ => unreachable!(),
        }
    }

    Ok(())
}

async fn add_user(db: &Surreal<File>) -> surrealdb::Result<()> {
    let name: String = Input::new().with_prompt("Name des Benutzers").interact_text().unwrap();
    let age: i32 = Input::new().with_prompt("Alter des Benutzers").interact_text().unwrap();

    let user = User { name, age };
    let created: User = db.create("user").content(user).await?;
    println!("✅ Benutzer erstellt: {:?}", created);
    Ok(())
}

async fn list_users(db: &Surreal<File>) -> surrealdb::Result<()> {
    let users: Vec<(Thing, User)> = db.select("user").await?;
    println!("\n== Alle Benutzer ==");
    for (thing, user) in users {
        println!("- ID: {}, Name: {}, Alter: {}", thing.id.to_raw(), user.name, user.age);
    }
    Ok(())
}

async fn update_user(db: &Surreal<File>) -> surrealdb::Result<()> {
    let id: String = Input::new().with_prompt("Benutzer-ID zum Aktualisieren").interact_text().unwrap();
    let name: String = Input::new().with_prompt("Neuer Name").interact_text().unwrap();
    let age: i32 = Input::new().with_prompt("Neues Alter").interact_text().unwrap();

    let updated = User { name, age };
    db.update(("user", id)).content(updated).await?;
    println!("✅ Benutzer aktualisiert.");
    Ok(())
}

async fn delete_user(db: &Surreal<File>) -> surrealdb::Result<()> {
    let id: String = Input::new().with_prompt("Benutzer-ID zum Löschen").interact_text().unwrap();
    db.delete(("user", id)).await?;
    println!("✅ Benutzer gelöscht.");
    Ok(())
}
```

---

# 📋 So funktioniert es:

- Beim Start wählst du eine Aktion aus (Menü mit Pfeiltasten)
    
- Für neue Benutzer wirst du Name und Alter abfragen
    
- Benutzer werden mit einer internen ID (`user:xxxx`) gespeichert
    
- Updates und Deletes funktionieren durch Eingabe der ID
    
- **Datei "users.surreal"** speichert alles dauerhaft auf der Platte
    

---

# 📷 Beispielsession im Terminal

```plaintext
==== User Manager CLI ====
> Benutzer hinzufügen
  Alle Benutzer auflisten
  Benutzer aktualisieren
  Benutzer löschen
  Beenden

Name des Benutzers: Alice
Alter des Benutzers: 29
✅ Benutzer erstellt: User { name: "Alice", age: 29 }

==== User Manager CLI ====
  Benutzer hinzufügen
> Alle Benutzer auflisten
  Benutzer aktualisieren
  Benutzer löschen
  Beenden

== Alle Benutzer ==
- ID: 1, Name: Alice, Alter: 29
```

---

# ⚡️ Noch besser:

Du kannst das Ganze natürlich später erweitern, z.B.:

- Suche nach Namen oder Altersbereich
    
- Unterstützung für mehrere Collection-Typen (User, Tasks, Projekte etc.)
    
- Authentifizierung über SurrealDB-Login
    
- Persistente Indizierung
    

---

# ✅ Zusammenfassung:

|Feature|Status|
|:--|:--|
|Eingabefeld|✔️ (mit `dialoguer`)|
|Lokale Dateispeicherung|✔️ (`users.surreal`)|
|CRUD-Operationen|✔️ (Create, Read, Update, Delete)|
|Vollständig in Rust|✔️|

---

# 🚀

Möchtest du noch eine **fortgeschrittene Version**, z.B. mit:

- Suchfunktion ("Suche Benutzer mit Name = 'Max'")?
    
- Mehrere Felder (Email, Adresse, etc.)?
    
- Automatische ID-Generierung wie `UUID` statt `1`, `2`, ...?
    

Ich könnte dir dafür gleich eine Erweiterung bauen, wenn du willst! 🔥  
(Kein Problem, dauert wenige Minuten!)

**→ Soll ich dir eine davon direkt ergänzen?**  
**(Wenn ja, welche?)** 🚀