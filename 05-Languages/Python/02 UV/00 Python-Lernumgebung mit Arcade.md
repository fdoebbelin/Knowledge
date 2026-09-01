## 1. Nushell installieren (empfohlen)

Nushell ist eine moderne, plattformübergreifende Shell, die auf Windows, Linux und
macOS identisch funktioniert. Sie vereinheitlicht die Kommandozeilen-Erfahrung und
macht die folgenden Schritte weitgehend betriebssystemunabhängig.

### Windows

```powershell
winget install nushell
```

### CachyOS / Arch Linux

```sh
sudo pacman -S nushell
```

### Nushell starten

```sh
nu
```

> **Hinweis:** Alle nachfolgenden Befehle funktionieren in Nushell auf beiden
> Plattformen gleich, sofern kein plattformspezifischer Hinweis angegeben ist.

---

## 2. `uv` installieren

`uv` ist ein extrem schneller Python-Paket- und Projektmanager, der `pip` und
`venv` in einem Werkzeug vereint. Er wird einmalig systemweit installiert.

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Anschließend die Shell-Integration aktivieren, damit `uv` im PATH bekannt ist:

```sh
uv python update-shell
```

---

## 3. Python installieren und verwalten

`uv` kann Python-Versionen eigenständig herunterladen und verwalten – unabhängig
von einer systemweiten Python-Installation.

```sh
# Verfügbare und installierte Python-Versionen anzeigen
uv python list

# Neueste stabile Python-Version installieren
uv python install

# Eine bestimmte Version installieren (hier: 3.13)
uv python install 3.13
```

---

## 4. Projektordner und virtuelle Umgebung einrichten

Eine virtuelle Umgebung (`venv`) isoliert die installierten Pakete vom Rest des
Systems. Jedes Projekt bekommt seine eigene Umgebung – so entstehen keine
Versionskonflikte zwischen verschiedenen Projekten.

```sh
# Projektordner anlegen und hineinwechseln
mkdir learn-arcade
cd learn-arcade

# Virtuelle Umgebung mit Python 3.13 erstellen
uv venv --python 3.13
```

---

## 5. Pakete installieren

Pakete werden innerhalb der Projektumgebung installiert. `uv pip` funktioniert wie
das bekannte `pip`, arbeitet aber deutlich schneller und nutzt automatisch die
aktive `uv`-Umgebung.

```sh
uv pip install arcade
```

---

## 6. Python ausführen mit `uv run`

`uv run` erkennt die virtuelle Umgebung im Projektordner automatisch und startet
Python darin – ohne vorherige Aktivierung. Das funktioniert in Nushell, PowerShell,
Bash und jeder anderen Shell gleich, da `uv run` selbst für die Umgebung zuständig
ist.

```sh
# Interaktiven Python-Interpreter starten
uv run python

# IDLE starten (grafische Entwicklungsumgebung)
uv run python -m idlelib
```

> **Wichtig:** Die Befehle müssen im Projektordner (`learn-arcade`) ausgeführt
> werden, damit `uv` die zugehörige `.venv` findet.

---

## 7. `python` vs. `python -m idlelib` – was ist der Unterschied?

| Befehl | Was passiert |
|---|---|
| `uv run python` | Startet den **interaktiven Interpreter** in der Konsole. Befehle werden Zeile für Zeile eingegeben und sofort ausgeführt. Gut zum schnellen Ausprobieren. |
| `uv run python -m idlelib` | Startet **IDLE**, die grafische Entwicklungsumgebung, die mit Python mitgeliefert wird. Sie bietet einen Editor mit Syntaxhervorhebung, einen integrierten Debugger und eine interaktive Shell – alles in einem Fenster. |

IDLE eignet sich besonders für Einsteiger, da Code geschrieben, gespeichert und
direkt ausgeführt werden kann, ohne die Konsole verlassen zu müssen.

> **Voraussetzung für IDLE auf CachyOS:** Das Paket `tk` muss installiert sein,
> da IDLE auf der grafischen Bibliothek `tkinter` basiert:
>
> ```sh
> sudo pacman -S tk
> ```
