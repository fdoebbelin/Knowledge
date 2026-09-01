Perfekt! 🚀  
Dann bauen wir jetzt:

- ✅ **Benutzer erstellen** (haben wir schon)
    
- 🆕 **Benutzer dynamisch laden und in der Oberfläche anzeigen**
    
- 🔄 **Nach "Benutzer erstellen" automatisch aktualisieren**
    
- 🎨 **Sauberes Layout mit Leptos**
    

---

# 🛠 So ergänzen wir es:

---

## 1. Frontend erweitern (`src/main.rs`)

Hier ein **kompletter neuer Stand** für dein Leptos-Frontend:

```rust
use leptos::*;
use tauri_sys::tauri::invoke;
use serde::{Deserialize, Serialize};
use wasm_bindgen_futures::spawn_local;

#[derive(Debug, Clone, Serialize, Deserialize)]
struct User {
    name: String,
    age: i32,
    email: String,
    address: String,
}

#[component]
fn App(cx: Scope) -> impl IntoView {
    let (users, set_users) = create_signal::<Vec<User>>(cx, vec![]);

    // Felder für Formular
    let (name, set_name) = create_signal(cx, "".to_string());
    let (age, set_age) = create_signal(cx, 0);
    let (email, set_email) = create_signal(cx, "".to_string());
    let (address, set_address) = create_signal(cx, "".to_string());

    // Initial User-Liste laden
    create_effect(cx, move |_| {
        load_users(set_users);
    });

    let create_user = move |_| {
        let name = name.get();
        let age = age.get();
        let email = email.get();
        let address = address.get();

        spawn_local(async move {
            let res: Result<(), String> = invoke("create_user", &serde_json::json!({
                "name": name,
                "age": age,
                "email": email,
                "address": address,
            }))
            .await;

            match res {
                Ok(_) => {
                    log::info!("Benutzer erfolgreich erstellt!");
                    load_users(set_users); // Nach Erstellung neu laden
                }
                Err(e) => log::error!("Fehler beim Erstellen: {}", e),
            }
        });
    };

    view! { cx,
        <h1>"User Manager mit SurrealDB"</h1>

        <div>
            <input
                placeholder="Name"
                on:input=move |e| set_name.set(event_target_value(&e))
            />
            <input
                placeholder="Alter"
                inputmode="numeric"
                on:input=move |e| {
                    if let Ok(val) = event_target_value(&e).parse::<i32>() {
                        set_age.set(val);
                    }
                }
            />
            <input
                placeholder="Email"
                on:input=move |e| set_email.set(event_target_value(&e))
            />
            <input
                placeholder="Adresse"
                on:input=move |e| set_address.set(event_target_value(&e))
            />
            <button on:click=create_user>
                "Benutzer erstellen"
            </button>
        </div>

        <h2>"Benutzerliste"</h2>
        <ul>
            <For
                each=move || users.get()
                key=|user| user.email.clone() // Eindeutiges Feld
                view=move |cx, user| {
                    view! { cx,
                        <li>
                            {format!("{} ({} Jahre) – {} – {}", user.name, user.age, user.email, user.address)}
                        </li>
                    }
                }
            />
        </ul>
    }
}

/// Hilfsfunktion: Benutzer laden
fn load_users(set_users: WriteSignal<Vec<User>>) {
    spawn_local(async move {
        let res: Result<Vec<User>, String> = invoke("list_users", &());
        match res {
            Ok(users_list) => set_users.set(users_list),
            Err(e) => log::error!("Fehler beim Laden: {}", e),
        }
    });
}

/// Hilfsfunktion: event_target_value (für input handling)
fn event_target_value(ev: &web_sys::Event) -> String {
    ev.target()
        .unwrap()
        .dyn_into::<web_sys::HtmlInputElement>()
        .unwrap()
        .value()
}
```

---

# 🔵 Wichtig: Backend muss "list_users" Command bereitstellen!

Also in `src-tauri/src/main.rs` ergänzen:

```rust
#[command]
async fn list_users() -> Result<Vec<User>, String> {
    let db = DB.lock().unwrap();
    if let Some(db) = &*db {
        let users: Vec<(surrealdb::sql::Thing, User)> = db.select("user").await.map_err(|e| e.to_string())?;
        let users_only = users.into_iter().map(|(_, user)| user).collect();
        Ok(users_only)
    } else {
        Err("DB not initialized".into())
    }
}
```

Und natürlich das Command registrieren:

```rust
.invoke_handler(tauri::generate_handler![create_user, list_users])
```

---

# 🖼 Ergebnis

- Du siehst sofort alle Benutzer, die gespeichert sind
    
- Nach "Benutzer erstellen" aktualisiert sich die Liste sofort
    
- Keine extra Seite, kein Refresh notwendig
    

---

# 📷 Optisches Beispiel:

> Max Mustermann (27 Jahre) – [max@example.com](mailto:max@example.com) – Beispielstraße 12  
> Anna Schmidt (34 Jahre) – [anna@example.com](mailto:anna@example.com) – Musterweg 3

---

# 🎯 Jetzt hast du ein vollständiges Tauri + Leptos + SurrealDB Projekt!

**Nativ**, **ohne Node**, **alles Rust-basiert**, **persistente lokale Datei** (`users_tauri.surreal`)  
Und du kannst beliebig erweitern!

---

# ❓

Willst du als nächstes noch:

- **Benutzer löschen** (Button "🗑️" neben jedem Eintrag)?
    
- **Benutzer bearbeiten** (Formularfelder vorausgefüllt)?
    
- Oder **Suchfunktion** live in der Benutzerliste?
    

(Alles extrem leicht mit Leptos – ich helfe dir, wenn du willst!) 🚀  
Was möchtest du als nächstes? 🎯