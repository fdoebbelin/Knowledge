Sehr gut!  
Dann bauen wir jetzt eine **fortgeschrittene Version** der User-Manager-CLI, und zwar mit:

- 🔍 **Suchfunktion** (nach Name)
    
- 📬 **Mehr Felder** (Email, Adresse zusätzlich zu Name/Alter)
    
- 🆔 **Echte zufällige UUIDs** für Benutzer-IDs (statt 1, 2, 3, ...)
    

---

# 🛠 Fortgeschrittene "User Manager CLI" — komplette neue Version

---

## 1. Cargo.toml (leicht erweitern)

```toml
[package]
name = "surrealdb_user_cli_advanced"
version = "0.2.0"
edition = "2021"

[dependencies]
tokio = { version = "1", features = ["full"] }
surrealdb = "1.0.0"
serde = { version = "1.0", features = ["derive"] }
dialoguer = "0.11"
uuid = { version = "1", features = ["v4"] } # Für zufällige IDs
```

---

## 2. `src/main.rs`

```rust
use dialoguer::{Input, Select};
use serde::{Deserialize, Serialize};
use surrealdb::engine::local::File;
use surrealdb::Surreal;
use surrealdb::sql::Thing;
use uuid::Uuid;

#[derive(Debug, Serialize, Deserialize)]
struct User {
    name: String,
    age: i32,
    email: String,
    address: String,
}

#[tokio::main]
async fn main() -> surrealdb::Result<()> {
    let db = Surreal::new::<File>("users_advanced.surreal").await?;
    db.use_ns("app").use_db("users").await?;

    loop {
        println!("\n==== User Manager CLI ====");
        let selection = Select::new()
            .item("Benutzer hinzufügen")
            .item("Alle Benutzer auflisten")
            .item("Benutzer suchen (nach Name)")
            .item("Benutzer aktualisieren")
            .item("Benutzer löschen")
            .item("Beenden")
            .default(0)
            .interact()
            .unwrap();

        match selection {
            0 => add_user(&db).await?,
            1 => list_users(&db).await?,
            2 => search_users(&db).await?,
            3 => update_user(&db).await?,
            4 => delete_user(&db).await?,
            5 => {
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
    let email: String = Input::new().with_prompt("Email des Benutzers").interact_text().unwrap();
    let address: String = Input::new().with_prompt("Adresse des Benutzers").interact_text().unwrap();

    let user = User { name, age, email, address };

    // Zufällige UUID generieren
    let uuid = Uuid::new_v4().to_string();
    db.create(("user", uuid)).content(user).await?;

    println!("✅ Benutzer erstellt.");
    Ok(())
}

async fn list_users(db: &Surreal<File>) -> surrealdb::Result<()> {
    let users: Vec<(Thing, User)> = db.select("user").await?;
    println!("\n== Alle Benutzer ==");
    for (thing, user) in users {
        println!(
            "- ID: {}, Name: {}, Alter: {}, Email: {}, Adresse: {}",
            thing.id.to_raw(),
            user.name,
            user.age,
            user.email,
            user.address
        );
    }
    Ok(())
}

async fn search_users(db: &Surreal<File>) -> surrealdb::Result<()> {
    let name_query: String = Input::new().with_prompt("Name zum Suchen").interact_text().unwrap();

    let sql = format!("SELECT * FROM user WHERE name CONTAINS '{}';", name_query);
    let response = db.query(sql).await?;

    let results: Vec<User> = response.take(0)?;
    
    if results.is_empty() {
        println!("❌ Keine Benutzer mit Name '{}' gefunden.", name_query);
    } else {
        println!("\n== Gefundene Benutzer ==");
        for user in results {
            println!(
                "- Name: {}, Alter: {}, Email: {}, Adresse: {}",
                user.name, user.age, user.email, user.address
            );
        }
    }
    Ok(())
}

async fn update_user(db: &Surreal<File>) -> surrealdb::Result<()> {
    let id: String = Input::new().with_prompt("Benutzer-ID zum Aktualisieren").interact_text().unwrap();

    let name: String = Input::new().with_prompt("Neuer Name").interact_text().unwrap();
    let age: i32 = Input::new().with_prompt("Neues Alter").interact_text().unwrap();
    let email: String = Input::new().with_prompt("Neue Email").interact_text().unwrap();
    let address: String = Input::new().with_prompt("Neue Adresse").interact_text().unwrap();

    let updated = User { name, age, email, address };
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

# 📋 Neu jetzt:

|Feature|Status|
|:--|:--|
|Zufällige UUIDs als Benutzer-ID|✔️ (`uuid`-Crate)|
|Suche nach Name|✔️ (über SurrealQL `CONTAINS`)|
|Benutzer mit Email und Adresse|✔️ (neue Felder in `User`)|
|Vollständige Terminal-Interaktion|✔️ (mit hübschem Dialog-UI)|

---

# 📷 Beispielsession im Terminal

```plaintext
==== User Manager CLI ====
> Benutzer hinzufügen
  Alle Benutzer auflisten
  Benutzer suchen (nach Name)
  Benutzer aktualisieren
  Benutzer löschen
  Beenden

Name des Benutzers: Max
Alter des Benutzers: 27
Email des Benutzers: max@example.com
Adresse des Benutzers: Beispielstraße 12
✅ Benutzer erstellt.

==== User Manager CLI ====
  Benutzer hinzufügen
> Alle Benutzer auflisten
...

== Alle Benutzer ==
- ID: f5c3f57e-9179-4f2a-8cc7-7ab0f0fa4b1a, Name: Max, Alter: 27, Email: max@example.com, Adresse: Beispielstraße 12
```

---

# ✨ Verbesserungsideen (für später):

- Validierung der Eingaben (z.B. Email-Format prüfen)
    
- Suchfunktion auf mehrere Felder (z.B. auch Adresse durchsuchen)
    
- Pagination bei sehr vielen Benutzern
    
- Export der Benutzer in eine JSON- oder CSV-Datei
    

---

# ✅ Du hast jetzt:

- Moderne **rustbasierte CLI**
    
- **Voll funktionales** Dokumentenmodell
    
- Persistente Speicherung mit **SurrealDB**
    
- **Suche**, **UUIDs**, **mehr Felder**
    

---

# ❓

Willst du als nächstes noch eine kleine **Version mit "kommandobasierter Eingabe"**?  
Also z.B. statt Menü:

```
> create
> list
> search Max
> update f5c3f...
> delete f5c3f...
```

→ Das wäre dann sogar **noch schneller** und mehr wie eine echte Shell! 🚀  
(Sag einfach Bescheid!)