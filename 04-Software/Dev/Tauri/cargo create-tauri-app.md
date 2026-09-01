(base) PS C:\Users\f.doebbelin\Documents\Tauri> cargo create-tauri-app
✔ Project name · tauri-app
✔ Identifier · com.tauri-app.app
✔ Choose which language to use for your frontend · Rust - (cargo)
✔ Choose your UI template · Leptos - (https://leptos.dev/)

Template created!

Your system is missing dependencies (or they do not exist in $PATH):

```
╭───────────────┬───────────────────────────────────────────────────────────╮
│ Tauri CLI     │ Run `cargo install tauri-cli --version '^2.0.0' --locked` │
├───────────────┼───────────────────────────────────────────────────────────┤
│ Trunk         │ Run `cargo install trunk --locked`                        │
├───────────────┼───────────────────────────────────────────────────────────┤
│ wasm32 target │ Run `rustup target add wasm32-unknown-unknown`            │
╰───────────────┴───────────────────────────────────────────────────────────╯
```


Make sure you have installed the prerequisites for your OS: https://tauri.app/start/prerequisites/, then run:
  
```
cd tauri-app
cargo tauri android init
```


For Desktop development, run:

```
cargo tauri dev
```


For Android development, run:

```
cargo tauri android dev
```
