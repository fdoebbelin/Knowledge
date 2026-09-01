Der Fehler **„Unable to download wasm-bindgen for windows aarch64“** beim Start von `cargo tauri dev` deutet darauf hin, dass für deine Architektur keine vorgefertigten Binaries von `wasm-bindgen` gefunden werden konnten.

Die Standard-Binärdateien werden nicht für alle Plattformen bereitgestellt. Du kannst `wasm-bindgen-cli` selbst kompilieren:

```sh
cargo install wasm-bindgen-cli --force
```

Das installiert die CLI lokal aus dem Quellcode – funktioniert meist unabhängig von der Architektur.