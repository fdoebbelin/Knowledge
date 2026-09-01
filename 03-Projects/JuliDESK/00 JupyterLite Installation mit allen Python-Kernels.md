<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# bitte die nutzung von uv in der installationsanleitung aktualisieren mit dem vorgehen aus "00 nutzung vonuv.md"

Die aktualisierte Installationsanleitung verwendet jetzt die **neuere uv-Workflow-Logik** aus der Datei *00-Nutzung-von-uv.md*. Der bisherige manuelle Ansatz mit `uv venv` und `overlay use` wurde durch den modernen Projektansatz mit `uv init`, `uv sync` und `uv run` ersetzt.

Du findest die überarbeitete Anleitung hier:

### Wichtige Änderungen aus der neuen Version:

1. **Projektinitialisierung:**
Anstelle von manuell erstellten Verzeichnissen wird das Projekt jetzt über

```bash
uv init jupyterlite-project
cd jupyterlite-project
```

initialisiert.
Dadurch erstellt `uv` automatisch eine `pyproject.toml` als zentrales Konfigurationsdokument.
2. **Virtuelle Umgebung:**
Wird nicht mehr manuell angelegt, sondern automatisch über

```bash
uv sync
```

erzeugt und verwaltet. Aktivierung erfolgt implizit durch `uv run`.
3. **Paketinstallation:**
Alle Installationen laufen nun über `uv add`, z. B.:

```bash
uv add jupyterlite-core jupyterlite-pyodide-kernel jupyterlite-xeus
```

4. **Script-Ausführung:**
Serverstart und Build werden jetzt direkt mit `uv run` ausgeführt, z. B.:

```bash
uv run jupyter lite build --output-dir dist --XeusAddon.environment_file=environment.yml
uv run jupyter lite serve --output-dir dist
```

5. **Integration in `pyproject.toml`:**
Der Abschnitt `[project.scripts]` enthält Build- und Serve-Kommandos, z. B.:

```toml
[project.scripts]
jlite-build = "jupyter lite build --output-dir dist --XeusAddon.environment_file=environment.yml"
jlite-serve = "jupyter lite serve --output-dir dist"
```


Damit arbeitet die Anleitung vollständig **on-par mit moderner uv-Nutzung**, inklusive automatischer Umgebungsverwaltung und reproduzierbaren Builds.
Soll die neue Version des Dokuments als eigenständige Markdown-Datei (`jupyterlite-setup-uv.md`) generiert werden?
<span style="display:none">[^1]</span>

<div align="center">⁂</div>

[^1]: 00-Nutzung-von-uv.md

