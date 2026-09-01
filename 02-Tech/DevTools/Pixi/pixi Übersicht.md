## Was ist Pixi?

Pixi ist ein moderner Package Manager und Workflow-Tool, entwickelt von [prefix.dev](https://prefix.dev/) – dem Team hinter **Mamba**. Es ist komplett in **Rust** geschrieben und baut auf dem **Conda-Ökosystem** auf. Inspiriert wurde es von Cargo (Rust), PNPM (Node.js) und Poetry.

---

## Die wichtigsten Eigenschaften

**Geschwindigkeit** Pixi ist bis zu 10x schneller als klassisches Conda/Mamba, da es Pakete parallel herunterlädt und installiert und einen modernen SAT-Solver nutzt.

**Deklarativ & Reproducible** Das Herz eines Pixi-Projekts ist eine `pixi.toml` (oder `pyproject.toml`) plus eine automatisch generierte `pixi.lock`-Datei. Das Lockfile friert alle transitiven Abhängigkeiten exakt ein – inklusive genauer Versionen und Hashes. Auf jedem Rechner, in CI/CD, im Container: exakt dasselbe Ergebnis.

**Plattformübergreifend** Unterstützt `linux-64`, `linux-aarch64`, `win-64`, `osx-64`, `osx-arm64` – wobei `win-arm64` (WoA) noch lückenhaft ist, wie du gerade erlebt hast.

**Zwei Paketquellen vereint** Pixi kann gleichzeitig aus **conda-forge** (25.000+ Pakete, auch Binaries wie CUDA, FFmpeg, OpenCV) und **PyPI** installieren – was weder pip/uv noch conda allein so elegant lösen.

**Integrierter Task-Runner** Ähnlich wie `make` oder `npm scripts`, aber cross-platform:

```toml
[tasks]
test = "pytest -s"
train = "python train.py --epochs 10"
start = { cmd = "jupyter lab", depends-on = ["install"] }
```

Dann einfach: `pixi run test`

**Projekt-zentriert statt Umgebungs-zentriert** Conda denkt in _Environments_, Pixi denkt in _Projekten_. Das `.pixi/`-Verzeichnis liegt direkt im Projektordner. `git clone` + `pixi run start` – fertig.

**Global Tools** Wie `pipx` oder `brew`, aber über conda-forge:

```bash
pixi global install ripgrep fd-find bat
```

---

## Kernkonzepte: Dateistruktur

```
mein-projekt/
├── pixi.toml        # Manifest: Dependencies, Tasks, Environments
├── pixi.lock        # Lockfile (auto-generiert, in git einchecken!)
└── .pixi/           # Installierte Environments (NICHT in git)
```

**Beispiel `pixi.toml`:**

```toml
[project]
name = "mein-projekt"
channels = ["conda-forge"]
platforms = ["win-64", "linux-64", "osx-arm64"]

[dependencies]
python = "3.11.*"
numpy = ">=1.26"
pandas = "*"

[pypi-dependencies]
requests = "*"

[tasks]
start = "python main.py"
test  = "pytest"
```

---

## Wichtigste Befehle

```bash
# Projekt initialisieren
pixi init

# Paket hinzufügen
pixi add numpy pandas
pixi add --pypi httpx          # von PyPI
pixi add --dev pytest ruff     # nur Dev-Dependencies

# Ausführen
pixi run start
pixi shell                     # Shell im Environment öffnen

# Global installieren (system-weit)
pixi global install bat ripgrep

# Infos
pixi info
pixi list
```

---

## Pixi vs. uv vs. conda – kurzer Vergleich

|Merkmal|Pixi|uv|conda/mamba|
|---|---|---|---|
|Geschwindigkeit|⚡ sehr schnell|⚡ sehr schnell|🐢 langsam|
|conda-forge-Pakete|✅|❌|✅|
|PyPI-Pakete|✅|✅|eingeschränkt|
|Lockfile|✅|✅|❌|
|Task-Runner|✅|❌|❌|
|Sprachunabhängig|✅ (R, C++, …)|❌ (nur Python)|teilweise|
|WoA (win-arm64)|⚠️ lückenhaft|✅|⚠️|

---

## Wann lohnt sich Pixi besonders?

Es ist ideal wenn du CUDA, OpenCV, FFmpeg oder andere Binaries brauchst (nicht auf PyPI verfügbar), wenn du plattformübergreifend arbeitest (Linux + Windows + Mac), wenn du Reproduzierbarkeit ernst nimmst (Science, ML, Bildung – dein BWSA-Kontext), oder wenn du Docker-Overhead vermeiden willst. Pixi kann Docker in vielen Fällen ersetzen.

---

## Schwachstellen (Stand 2025)

- **win-arm64** (WoA) noch kein vollständiger Support → dein aktuelles Problem
- Jüngeres Ökosystem als conda, manche Tools noch nicht portiert
- Lockfile-Konzept ist Umgewöhnung für conda-Veteranen

Das Projekt ist aktiv, BSD-3-lizenziert und unter [pixi.sh](https://pixi.sh/) dokumentiert. Für deinen Use Case (Bildungsmaterialien, ML/AI-Tools, plattformübergreifend) ist Pixi langfristig eine sehr gute Wahl.