## 1. Installation von uv (PowerShell)

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

Damit ist uv als ausführbares CLI-Tool auf deinem System verfügbar.

## 2. Python direkt mit uv installieren

Um die neueste stabile Python-Version zu installieren:

```powershell
uv python install
```

Alternativ eine bestimmte Version (z.B. 3.12):

```powershell
uv python install 3.12
```

Prüfen der installierten Version(en):

```powershell
uv python list
```


## 3. Ein minimales Beispielprojekt mit uv

#### Projekt erstellen

```powershell
uv init hello-uv
cd hello-uv
```

Dies erstellt eine Projektstruktur mit einem Beispiel-Skript und Konfigurationsdateien.

### Paket hinzufügen

```powershell
uv add termcolor
```


### Script ausführen

Erstelle eine Datei `hx hello.py`:

```python
from termcolor import colored
print(colored("Hello World!", "green"))
```

Dann ausführen:

```powershell
uv run hello.py
```

Oder Projektabhängigkeiten synchronisieren und ausführen:

```powershell
uv sync
uv run hello.py
```
