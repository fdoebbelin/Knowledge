Um den Rust Playground lokal unter openSUSE Tumbleweed zu betreiben, gibt es mehrere Ansätze:

## Option 1: Offizielles rust-playground Repository

Das offizielle Repository von Mozilla findest du auf GitHub: https://github.com/rust-lang/rust-playground

### Installation:

```bash
# Abhängigkeiten installieren
sudo zypper install rust cargo nodejs npm docker

# Repository klonen
git clone https://github.com/rust-lang/rust-playground.git
cd rust-playground

# Frontend Dependencies installieren
cd ui/frontend
npm install
cd ../..

# Backend bauen
cargo build --release

# Docker Images für verschiedene Rust-Versionen bauen
cd compiler/base
docker build -t rust-playground-base --build-arg channel=stable .
cd ../..
```

### Konfiguration:

```bash
# Konfigurationsdatei erstellen
cp playground.toml.example playground.toml
# Anpassungen in playground.toml vornehmen
```

### Starten:

```bash
# Backend starten
cargo run --release

# In einem anderen Terminal das Frontend starten
cd ui/frontend
npm start
```

## Option 2: Alternative - Evcxr (Jupyter-ähnlich)

Für eine einfachere lokale Rust-Umgebung:

```bash
# Evcxr installieren
cargo install evcxr_repl evcxr_jupyter

# REPL starten
evcxr
```