## 🧩 Voraussetzungen

Zuerst sicherstellen, dass du **uv** installiert hast:

```bash
pip install uv
```

Oder noch besser (wenn du `pipx` nutzt):

```bash
pipx install uv
```

Überprüfen:

```bash
uv --version
```

---

## 🚀 Neues Projekt anlegen

Mit einem einzigen Befehl kannst du ein neues Python-Projekt starten:

```bash
uv init mein_projekt
```

Das erstellt:

```
mein_projekt/
├── pyproject.toml
├── README.md
├── mein_projekt/
│   └── __init__.py
└── tests/
    └── __init__.py
```

---

## 🧱 Virtuelle Umgebung verwalten

`uv` benutzt eigene **isolierte Environments**, ähnlich wie `venv` oder `poetry`.

Um in das Projekt zu wechseln und Abhängigkeiten zu installieren:

```bash
cd mein_projekt
uv sync
```

Das legt automatisch eine `.venv` an und installiert alle Pakete aus `pyproject.toml`.

---

## 📦 Paket hinzufügen

Zum Beispiel `requests`:

```bash
uv add requests
```

Oder mit Versionsbeschränkung:

```bash
uv add "fastapi>=0.111,<0.112"
```

---

## 🧪 Tests ausführen

`uv` integriert **pytest** automatisch, falls du es installierst:

```bash
uv add pytest
uv run pytest
```

---

## 🏃 Projekt ausführen

Du kannst Skripte direkt starten, ohne manuell zu aktivieren:

```bash
uv run python mein_projekt/main.py
```

oder wenn du einen Eintrag im `[project.scripts]` Bereich hast:

```bash
uv run mein-script
```

---

## 🔧 Beispiel für `pyproject.toml`

```toml
[project]
name = "mein_projekt"
version = "0.1.0"
description = "Ein Beispielprojekt mit uv"
authors = [{ name = "Fritz-Rainer Döbbelin" }]
dependencies = ["requests"]

[tool.uv]
managed = true
```

---

Möchtest du, dass ich dir eine **konkrete Projektstruktur** (z. B. CLI-Tool, Web-App mit FastAPI, oder Datenanalyseprojekt) mit `uv` vorkonfiguriere?  
Dann kann ich dir gleich ein Startgerüst generieren, das du direkt initialisieren kannst.