Anstatt die `requirements.txt` von Hand zu bearbeiten, lassen Sie `uv` die Verwaltung übernehmen. Dies nutzt die Datei `pyproject.toml`, was der moderne Standard für Python-Projekte ist.

**So wechseln Sie zu diesem Workflow:**

1. **Projekt initialisieren:**
Wandeln Sie Ihr aktuelles Verzeichnis in ein verwaltetes Projekt um (falls noch nicht geschehen):

```bash
uv init
```

2. **Existierende Requirements importieren:**
Sie müssen nicht alles neu installieren. Importieren Sie Ihre alte Liste einfach in das neue System:

```bash
uv add -r requirements.txt
```

*(Danach können Sie die `requirements.txt` eigentlich löschen, da nun alles in `pyproject.toml` steht.)*

**Ihr neuer, einfacherer Workflow:**

* **Neues Paket hinzufügen:**
Nie wieder Dateien manuell editieren. Ein Befehl installiert das Paket UND trägt es in die Konfiguration ein:

```bash
uv add pandas
```

* **Paket entfernen:**

```bash
uv remove pandas
```

* **Alles aktualisieren und synchronisieren:**
Wenn Sie `git pull` gemacht haben oder sicherstellen wollen, dass Ihre Umgebung exakt der Definition entspricht:

```bash
uv sync
```

* **Script ausführen:**

```bash
uv run python mein_skript.py
```


**Falls Sie zwingend eine `requirements.txt` brauchen (z.B. für Kollegen):**
Sie können diese jederzeit aus Ihrem modernen Projekt generieren:

```bash
uv export --format requirements-txt > requirements.txt
```
