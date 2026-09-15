## Was ist EvCxR?

**EvCxR** (ausgesprochen "Evic-ser") ist ein Evaluation Context für Rust, der sowohl als REPL als auch als Jupyter Kernel funktioniert. Es ermöglicht die interaktive Ausführung von Rust-Code in Jupyter Notebooks.

## Voraussetzungen

### 1. Rust Installation

```bash
# Rust über rustup installieren
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Rust Standard Library Quellcode installieren (erforderlich)
rustup component add rust-src
```

### 2. Jupyter Installation

```bash
conda install -c conda-forge jupyterlab
```

## EvCxR Installation

### Methode 1: Stable Release (empfohlen)

```bash
# EvCxR Jupyter Kernel installieren
cargo install evcxr_jupyter

# Kernel bei Jupyter registrieren
evcxr_jupyter --install
```

### Methode 2: Neueste Version von GitHub

```bash
# Neueste Entwicklungsversion installieren
cargo install --force --git https://github.com/evcxr/evcxr.git evcxr_jupyter

# Kernel registrieren
evcxr_jupyter --install
```

### Methode 3: Spezifische Version (für Stabilität)

```bash
# Bestimmte Version installieren
cargo install evcxr_jupyter --version 0.17.0
evcxr_jupyter --install
```

## Zusätzliche Abhängigkeiten (je nach System)

### macOS

```bash
# ZeroMQ installieren (falls Probleme auftreten)
brew install zmq
```

### Ubuntu/Debian

```bash
# Build-Tools und ZeroMQ
sudo apt-get update
sudo apt-get install build-essential libzmq3-dev
```

### Windows

- Verwende die [rustup Windows installer](https://rustup.rs/)
- Visual Studio Build Tools können erforderlich sein

## Jupyter starten und verwenden

```bash
# Jupyter Lab starten (moderne Oberfläche)
jupyter lab

# Oder klassisches Notebook
jupyter notebook
```

### Neues Rust Notebook erstellen

1. In Jupyter: **New** → **Rust** (Kernel auswählen)
2. Oder in JupyterLab: **Launcher** → **Rust** unter Notebooks

## Grundlegende Verwendung

### Einfacher Code

```rust
println!("Hello, Rust in Jupyter!");
let x = 42;
x * 2
```

### Dependencies hinzufügen

```rust
// Externe Crates hinzufügen
:dep serde = { version = "1.0", features = ["derive"] }
:dep plotters = { version = "0.3", default_features = false, features = ["evcxr", "all_series"] }

// Dann verwenden
extern crate serde;
use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize, Debug)]
struct Person {
    name: String,
    age: u32,
}

let person = Person {
    name: "Alice".to_string(),
    age: 30,
};
person
```

### Visualisierung mit Plotters

```rust
:dep plotters = { version = "0.3", default_features = false, features = ["evcxr", "all_series"] }

extern crate plotters;
use plotters::prelude::*;

evcxr_figure((640, 480), |root| {
    let mut chart = ChartBuilder::on(&root)
        .caption("Sample Chart", ("Arial", 20))
        .build_cartesian_2d(0f32..10f32, 0f32..100f32)?;
    
    chart.draw_series(
        (0..10).map(|x| Circle::new((x as f32, (x*x) as f32), 3, &RED))
    )?;
    
    Ok(())
})
```

## Docker Alternative

Falls lokale Installation Probleme bereitet:

```bash
# Vorgefertigtes Docker Image verwenden
docker pull hgfdodo/evcxr
docker run -p 8888:8888 hgfdodo/evcxr

# Oder eigenes Image bauen
git clone https://github.com/hgfkeep/rust-jupyter
cd rust-jupyter
docker build -t rust-jupyter .
docker run -p 8888:8888 rust-jupyter
```

## Conda Environment Setup (empfohlen)

```bash
# Neue Conda-Umgebung erstellen
conda create -n rust-jupyter python=3.11
conda activate rust-jupyter

# Jupyter installieren
conda install -c conda-forge jupyterlab

# Rust installieren (falls nicht global vorhanden)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
rustup component add rust-src

# EvCxR installieren
cargo install evcxr_jupyter
evcxr_jupyter --install

# Starten
jupyter lab
```

## Troubleshooting

### Kernel wird nicht angezeigt

```bash
# Kernel manuell registrieren
jupyter kernelspec list
evcxr_jupyter --install

# Jupyter neustarten
```

### "No such file or directory" Fehler

```bash
# Sicherstellen, dass alle Pfade korrekt sind
which evcxr_jupyter
echo $PATH

# Rust Environment laden
source ~/.cargo/env
```

### ZeroMQ Probleme

```bash
# macOS
brew install zmq

# Ubuntu/Debian
sudo apt-get install libzmq3-dev

# Windows: rustup selbst installiert meist alles nötige
```

### Kernel startet nicht

```bash
# Debug-Informationen
jupyter --debug

# Kernel-Logs prüfen
jupyter kernelspec list
# Dann in den entsprechenden Ordner schauen
```

## Verfügbare Features

- **Interaktive Rust-Entwicklung** in Notebooks
- **Externe Crates** via `:dep` Kommando
- **HTML/SVG-Visualisierung** mit Plotters und anderen Libraries
- **Debugging** und Fehlerausgabe
- **Intellisense-ähnliche** Funktionen

## Einschränkungen

- **Performance**: Code wird nicht optimiert kompiliert (Debug-Modus)
- **Lange Programme**: Besser in echten Rust-Projekten entwickeln
- **Interrupt**: "Kernel interrupt" funktioniert nicht mit Rust
- **Memory**: Jede Zelle erstellt neuen Kontext

## Nützliche Ressourcen

- [EvCxR GitHub Repository](https://github.com/evcxr/evcxr)
- [Jupyter Tour Notebook](https://github.com/evcxr/evcxr/blob/main/evcxr_jupyter/samples/evcxr_jupyter_tour.ipynb)
- [Data Analysis with Rust Notebooks](https://datacrayon.com/data-analysis-with-rust-notebooks/) - Buch von Dr. Shahin Rostami
- [Plotters Jupyter Integration](https://plotters-rs.github.io/plotters-doc-data/evcxr-jupyter-integration.html)

## Beispiel-Notebooks

Das EvCxR Repository enthält verschiedene Beispiel-Notebooks, die zeigen, was möglich ist:

- Datenanalyse mit verschiedenen Crates
- Visualisierungen mit Plotters
- Machine Learning Beispiele
- Graph-Visualisierung mit Petgraph