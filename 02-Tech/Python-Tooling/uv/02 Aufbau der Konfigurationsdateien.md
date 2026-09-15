## Grundprinzip: Zwei Dateien, eine Konfiguration

uv liest seine Konfiguration aus zwei möglichen Quellen:

| Datei | Schlüsselpfad | Anwendungsfall |
|-------|---------------|----------------|
| `uv.toml` | Schlüssel direkt auf oberster Ebene | Empfohlen für reine uv-Konfiguration |
| `pyproject.toml` | `[tool.uv]` und Untertabellen | Wenn alles in einer Datei bleiben soll |

In `uv.toml` entfällt der Präfix `[tool.uv]`. Was dort `[tool.uv.pip]` heißt,
heißt in `uv.toml` einfach `[pip]`.

> **Priorität bei Konflikt:** Wenn sowohl `uv.toml` als auch `[tool.uv]` in
> `pyproject.toml` vorhanden sind, **gewinnt** `uv.toml`. Die `pyproject.toml`-Sektion
> wird dann vollständig ignoriert.

---

## Speicherorte und Geltungsbereiche

uv sucht Konfigurationsdateien in folgender Reihenfolge (höhere Priorität zuerst):

```
1. Projektverzeichnis          →  ./uv.toml  oder  ./pyproject.toml [tool.uv]
2. Elternverzeichnisse         →  Suche nach oben bis Wurzel
3. Benutzer (global)           →  ~/.config/uv/uv.toml          (Linux/macOS)
                                  %APPDATA%\uv\uv.toml           (Windows)
4. System (alle Benutzer)      →  /etc/uv/uv.toml               (Linux/macOS)
                                  %PROGRAMDATA%\uv\uv.toml       (Windows)
```

Dabei werden alle gefundenen Konfigurationen **zusammengeführt (merged)**,
mit Projektebene als stärkstem Gewinner.

> **Wichtig für `uv tool`-Befehle:** Bei globalen Tool-Operationen werden
> lokale Projektdateien ignoriert — nur Benutzer- und Systemkonfiguration wirkt.

### Explizite Konfigurationsdatei angeben

```nushell
uv sync --config-file /pfad/zur/meine.toml
# oder per Umgebungsvariable:
$env.UV_CONFIG_FILE = "/pfad/zur/meine.toml"
```

### Konfiguration vollständig deaktivieren

```nushell
uv sync --no-config
# oder:
$env.UV_NO_CONFIG = "1"
```

---

## Gesamtstruktur im Überblick

```toml
# ─────────────────────────────────────────────
# uv.toml – Vollständige Strukturübersicht
# ─────────────────────────────────────────────

# ① Allgemeine Laufzeit-Einstellungen (Toplevel)
python-preference    = "managed"
python-downloads     = "automatic"
compile-bytecode     = true
link-mode            = "hardlink"
cache-dir            = "~/.cache/uv"
no-cache             = false
offline              = false
preview              = false
required-version     = ">=0.5.0"

# ② Netzwerk & Proxy
http-proxy           = "http://proxy.example.com:8080"
https-proxy          = "http://proxy.example.com:8080"
no-proxy             = ["localhost", "127.0.0.1"]
native-tls           = false
allow-insecure-host  = []

# ③ Paketindex-Konfiguration (Toplevel-Schlüssel)
index-url            = "https://pypi.org/simple"
extra-index-url      = []
index-strategy       = "first-index"
find-links           = []
no-index             = false

# ④ Index-Tabellen (moderner Stil)
[[index]]
url      = "https://pypi.org/simple"
default  = true

# ⑤ Auflösungsverhalten
resolution           = "highest"
prerelease           = "if-necessary-or-explicit"
upgrade              = false
upgrade-package      = []
reinstall            = false
reinstall-package    = []
exclude-newer        = "2025-01-01T00:00:00Z"

# ⑥ Build-Verhalten
no-build             = false
no-build-package     = []
no-binary            = false
no-binary-package    = []
no-build-isolation   = false
concurrent-builds    = 4
concurrent-downloads = 50
concurrent-installs  = 8

# ⑦ pip-Subinterface
[pip]
index-url            = "https://pypi.org/simple"
python               = "3.12"
system               = false
break-system-packages = false
compile-bytecode     = true
resolution           = "highest"
prerelease           = "if-necessary-or-explicit"
generate-hashes      = false
require-hashes       = false
strict               = false
universal            = false

# ⑧ Nur in pyproject.toml (NICHT in uv.toml verfügbar):
# [tool.uv]
# dev-dependencies     = [...]
# dependency-groups    = {...}
# sources              = {...}
# workspace            = {...}
```

---

## ① Allgemeine Laufzeit-Einstellungen

Diese Schlüssel stehen auf oberster Ebene der `uv.toml`.

### `python-preference`

Legt fest, welche Python-Interpreter uv bevorzugt.

```toml
python-preference = "managed"
```

| Wert | Bedeutung |
|------|-----------|
| `"managed"` | uv-verwaltete Interpreter bevorzugen, System als Fallback |
| `"system"` | System-Python bevorzugen, uv-managed als Fallback |
| `"only-managed"` | Ausschließlich uv-verwaltete Interpreter verwenden |
| `"only-system"` | Ausschließlich System-Python verwenden |

**Empfehlung für CachyOS/Linux:** `"managed"` – so verwaltet uv alle Versionen
selbst und kollidiert nicht mit dem System-Python.

---

### `python-downloads`

Steuert, ob uv Python-Versionen automatisch herunterlädt.

```toml
python-downloads = "automatic"
```

| Wert | Bedeutung |
|------|-----------|
| `"automatic"` | Bei Bedarf automatisch herunterladen (Standard) |
| `"manual"` | Nur manuell über `uv python install` |
| `"never"` | Nie herunterladen – Fehler, wenn Version fehlt |

---

### `compile-bytecode`

Wenn `true`, kompiliert uv nach der Installation alle `.py`-Dateien zu `.pyc`
(Python-Bytecode). Das kostet beim ersten `uv sync` etwas Zeit, beschleunigt
aber alle späteren Programmstarts.

```toml
compile-bytecode = true
```

---

### `link-mode`

Bestimmt, wie uv Pakete aus dem Cache in die `.venv` einbindet.

```toml
link-mode = "hardlink"
```

| Wert | Beschreibung | Vorteil |
|------|--------------|---------|
| `"hardlink"` | Hardlinks (Standard auf Linux) | Kein Speicherverbrauch |
| `"symlink"` | Symbolische Links | Ebenfalls platzsparend |
| `"copy"` | Echte Kopie der Dateien | Maximale Kompatibilität |
| `"clone"` | COW-Klone (macOS APFS, Btrfs) | Schnell + platzsparend |

Auf CachyOS mit Btrfs ist `"clone"` ideal.

---

### `cache-dir`

Pfad zum uv-Cache. Standard ist `~/.cache/uv` auf Linux.

```toml
cache-dir = "~/.cache/uv"
# Alternativ auf einer schnellen NVMe:
# cache-dir = "/mnt/fast-ssd/uv-cache"
```

---

### `no-cache`

Wenn `true`, wird der Cache vollständig ignoriert und nie geschrieben. Für
CI-Umgebungen ohne persistenten Cache oder zum Debuggen.

```toml
no-cache = false
```

---

### `offline`

Wenn `true`, deaktiviert uv alle Netzwerkzugriffe. Es werden nur lokal
gecachte Daten verwendet.

```toml
offline = false
```

---

### `preview`

Aktiviert experimentelle Features, die noch nicht stabil sind.

```toml
preview = false
```

---

### `required-version`

Erzwingt eine Mindest- oder exakte uv-Version. Schützt vor unbeabsichtigtem
Einsatz veralteter uv-Versionen im Team.

```toml
required-version = ">=0.5.0"
# Oder exakt:
required-version = "==0.5.3"
```

---

## ② Netzwerk & Proxy

### `http-proxy` / `https-proxy`

HTTP/HTTPS-Proxy für alle Netzwerkanfragen (Paket-Downloads, Python-Downloads).

```toml
http-proxy  = "http://proxy.firma.de:3128"
https-proxy = "http://proxy.firma.de:3128"
```

Alternativ per Umgebungsvariable: `$env.HTTP_PROXY`, `$env.HTTPS_PROXY`

---

### `no-proxy`

Liste von Hosts oder Domains, die den Proxy umgehen.

```toml
no-proxy = ["localhost", "127.0.0.1", "intern.firma.de"]
```

---

### `native-tls`

Wenn `true`, verwendet uv die TLS-Bibliothek des Betriebssystems statt der
integrierten `webpki-roots`. Erforderlich in Unternehmensumgebungen mit
eigenen CA-Zertifikaten.

```toml
native-tls = true
```

---

### `allow-insecure-host`

Liste von Hosts, für die TLS-Zertifikatsprüfungen deaktiviert werden.
**Nur für interne Entwicklungs- oder Testumgebungen verwenden.**

```toml
allow-insecure-host = ["intern-pypi.dev-server.local"]
```

---

## ③ Paketindex-Konfiguration

### Einfache Schlüssel (älterer Stil)

```toml
# Primärer Index (ersetzt PyPI als Standard)
index-url = "https://pypi.org/simple"

# Zusätzliche Indizes (werden nachrangig durchsucht)
extra-index-url = [
  "https://download.pytorch.org/whl/cu124",
]

# Lokale Verzeichnisse oder URLs mit Wheel-Dateien
find-links = [
  "/pfad/zu/lokalen/wheels",
  "https://intern.firma.de/wheels/"
]

# Kein externer Index – nur explizit angegebene Quellen
no-index = false
```

---

### `index-strategy`

Bestimmt, wie uv mit mehreren Indizes umgeht.

```toml
index-strategy = "first-index"
```

| Wert | Verhalten |
|------|-----------|
| `"first-index"` | Erstes Vorkommen eines Pakets gewinnt (Standard, sicherer) |
| `"unsafe-first-match"` | Niedrigste Version aus dem ersten Index mit Treffer |
| `"unsafe-best-match"` | Beste Version über alle Indizes hinweg |

---

### `[[index]]` – Moderner Tabellenstil (empfohlen)

Seit uv 0.5 ist das `[[index]]`-Array die bevorzugte Methode für Indizes,
da es mehr Kontrolle bietet.

```toml
# Standard-Index (ersetzt PyPI)
[[index]]
url     = "https://pypi.org/simple"
default = true

# Zusätzlicher Index (z. B. privater Firmen-PyPI)
[[index]]
url      = "https://pypi.firma.de/simple"
name     = "firma-intern"
priority = 10           # Höhere Zahl = höhere Priorität

# PyTorch-Wheels für CUDA
[[index]]
url      = "https://download.pytorch.org/whl/cu124"
name     = "pytorch-cu124"
explicit = true         # Wird nur für Pakete verwendet, die ihn explizit referenzieren
```

#### Index-Felder

| Feld | Typ | Bedeutung |
|------|-----|-----------|
| `url` | String | URL des Index (erforderlich) |
| `name` | String | Symbolischer Name (optional, für `[tool.uv.sources]` Referenzen) |
| `default` | bool | Macht diesen Index zum primären (ersetzt PyPI) |
| `explicit` | bool | Index wird nur genutzt, wenn Paket ihn explizit benennt |
| `priority` | int | Numerische Priorität bei mehreren nicht-default Indizes |

---

## ④ Auflösungsverhalten (Resolver)

### `resolution`

Strategie bei der Versionsauflösung.

```toml
resolution = "highest"
```

| Wert | Bedeutung |
|------|-----------|
| `"highest"` | Neueste kompatible Version (Standard) |
| `"lowest"` | Älteste kompatible Version (für Kompatibilitätstests) |
| `"lowest-direct"` | Lowest nur für direkte Abhängigkeiten |

---

### `prerelease`

Umgang mit Vorabversionen (alpha, beta, rc).

```toml
prerelease = "if-necessary-or-explicit"
```

| Wert | Bedeutung |
|------|-----------|
| `"disallow"` | Vorabversionen grundsätzlich ablehnen |
| `"allow"` | Vorabversionen immer erlauben |
| `"if-necessary"` | Nur wenn keine stabile Version verfügbar |
| `"explicit"` | Nur wenn in der Anforderung explizit angegeben |
| `"if-necessary-or-explicit"` | Kombination aus beiden (Standard) |

---

### `upgrade` / `upgrade-package`

Erzwingt das Upgrade auf neueste Versionen bei jedem `uv sync` oder `uv lock`.

```toml
upgrade = false

# Nur bestimmte Pakete immer upgraden:
upgrade-package = ["requests", "django"]
```

---

### `reinstall` / `reinstall-package`

Erzwingt Neuinstallation bereits installierter Pakete.

```toml
reinstall = false

# Nur ein spezifisches Paket immer neu installieren:
reinstall-package = ["my-own-package"]
```

---

### `exclude-newer`

Schließt alle Pakete aus, die nach einem bestimmten Zeitpunkt veröffentlicht wurden.
Ermöglicht vollständig reproduzierbare Builds auch ohne Lock-Datei.

```toml
exclude-newer = "2025-01-01T00:00:00Z"
```

Format: RFC 3339, Zeitzone erforderlich.

---

## ⑤ Build-Verhalten

### `no-build` / `no-build-package`

Verhindert das Bauen von Source-Distributions (`.tar.gz`, `.zip`).
Bei `true` werden nur vorab gebaute Wheels (`.whl`) akzeptiert.

```toml
no-build = false

# Nur für bestimmte Pakete kein Build:
no-build-package = ["numpy", "scipy"]
```

---

### `no-binary` / `no-binary-package`

Das Gegenteil: Verhindert die Verwendung von Wheels, erzwingt Build aus Source.
Selten sinnvoll, aber nützlich wenn Wheels für eine Plattform fehlen.

```toml
no-binary = false
no-binary-package = ["cryptography"]   # immer aus Quelle bauen
```

---

### `no-build-isolation`

Deaktiviert die Build-Isolation (PEP 517). Dann werden Build-Tools aus der
laufenden Umgebung genutzt statt einer temporären Umgebung. Für Pakete
wie `flash-attention`, die es erfordern.

```toml
no-build-isolation = false

# Besser: nur für spezifische Pakete:
no-build-isolation-package = ["flash-attn"]
```

---

### Parallelisierung

```toml
concurrent-downloads = 50   # Gleichzeitige HTTP-Downloads (Standard: 50)
concurrent-builds    = 4    # Gleichzeitige Source-Builds (Standard: CPU-Kerne)
concurrent-installs  = 8    # Gleichzeitige Paket-Installationen (Standard: 8)
```

Auf einem schnellen System mit viel Bandbreite können diese Werte erhöht werden.

---

## ⑥ Der `[pip]`-Abschnitt

Der `[pip]`-Abschnitt konfiguriert speziell das **pip-kompatible Interface**
von uv (`uv pip install`, `uv pip compile`, etc.) – unabhängig von den
Projektbefehlen (`uv sync`, `uv add`).

```toml
[pip]

# Welchen Python-Interpreter verwenden?
python   = "3.12"

# In System-Python installieren (außerhalb venv) – gefährlich!
system   = false

# Systemweite Pakete bei Konflikt überschreiben
break-system-packages = false

# Bytecode kompilieren nach Installation
compile-bytecode = true

# Versionsauflösung
resolution  = "highest"
prerelease  = "if-necessary-or-explicit"

# Hash-Verifizierung
generate-hashes = false   # SHA256-Hashes in requirements.txt ausgeben
require-hashes  = false   # Hashes zwingend voraussetzen (maximale Sicherheit)

# Paket-Index (unabhängig vom globalen Index)
index-url       = "https://pypi.org/simple"
extra-index-url = []

# Strikte Abhängigkeitsprüfung
strict = false    # Bei true: Warnung bei nicht deklarierten Abhängigkeiten

# Universal-Locks (plattformübergreifend)
universal = false

# Zielverzeichnis für Installation (pip install --target Äquivalent)
# target = "/pfad/zum/ziel"

# Prefix für Installation
# prefix = "/pfad/zum/prefix"
```

---

## ⑦ Projektkonfiguration – nur in `pyproject.toml`

Die folgenden Abschnitte existieren **ausschließlich** in `pyproject.toml`
unter `[tool.uv]` – sie sind in einer eigenständigen `uv.toml` **nicht**
verfügbar, da sie Projektmetadaten sind, keine Laufzeitkonfiguration.

### `[tool.uv.sources]` – Paketquellen überschreiben

Ermöglicht es, Pakete aus Git, lokalen Pfaden oder alternativen Indizes
zu beziehen, anstatt von PyPI.

```toml
[tool.uv.sources]
# Aus Git (Branch)
mein-paket = { git = "https://github.com/user/mein-paket", branch = "main" }

# Aus Git (Tag)
requests   = { git = "https://github.com/psf/requests", tag = "v2.32.0" }

# Lokal (editierbar)
mein-lib   = { path = "../mein-lib", editable = true }

# Von einem bestimmten Index (muss in [[index]] definiert sein)
torch      = { index = "pytorch-cu124" }
```

---

### `[tool.uv.dev-dependencies]` – Entwicklungsabhängigkeiten

```toml
[tool.uv.dev-dependencies]
# Liste von Paketen, die nur für die Entwicklung benötigt werden
# Werden mit 'uv sync --dev' oder 'uv sync' (Standard) installiert
# Erscheinen nicht in der verteilten Paketabhängigkeit
dev = [
  "pytest>=8.0",
  "pytest-cov",
  "ruff",
  "black",
  "mypy",
]
```

Seit uv 0.5 ist die modernere Form über `[dependency-groups]` bevorzugt
(PEP 735-konform):

```toml
[dependency-groups]
dev  = ["pytest>=8.0", "ruff", "mypy"]
docs = ["sphinx", "sphinx-rtd-theme"]
ci   = ["tox", "coverage"]
```

---

### `[tool.uv.workspace]` – Monorepo-Konfiguration

```toml
[tool.uv.workspace]
# Glob-Muster für Workspace-Member
members = [
  "packages/*",
  "apps/backend",
  "apps/frontend",
]

# Bestimmte Verzeichnisse explizit ausschließen
exclude = [
  "packages/archiv",
]
```

---

### `[tool.uv.constraint-dependencies]` – Versionen einschränken

Pakete, die nicht direkt benötigt, aber in bestimmten Versionen fixiert
werden sollen (z. B. um Sicherheitslücken zu vermeiden).

```toml
[tool.uv]
constraint-dependencies = [
  "certifi>=2024.1.0",
  "urllib3>=2.0",
]
```

---

### `[tool.uv.override-dependencies]` – Abhängigkeiten erzwingen

Überschreibt Versionsanforderungen transitiver Abhängigkeiten mit Gewalt.
**Mit Vorsicht verwenden** – kann die Kompatibilität brechen.

```toml
[tool.uv]
override-dependencies = [
  "numpy==1.26.4",   # Erzwingt exakt diese Version, egal was andere Pakete wollen
]
```

---

## Vollständiges Beispiel: `~/.config/uv/uv.toml`

Eine realistische globale Konfiguration für ein CachyOS-System mit RTX-GPU:

```toml
# ~/.config/uv/uv.toml
# Globale uv-Konfiguration für CachyOS / Linux

# ─── Python ────────────────────────────────────
python-preference = "managed"     # uv verwaltet Python-Versionen selbst
python-downloads  = "automatic"   # Automatisch herunterladen wenn nötig

# ─── Performance ───────────────────────────────
compile-bytecode     = true        # .pyc vorab kompilieren → schnellere Starts
link-mode            = "hardlink"  # Platzsparend via Hardlinks (auf ext4/btrfs)
concurrent-downloads = 50          # Parallele Downloads
concurrent-builds    = 8           # Parallele Builds (8-Kern-CPU)
concurrent-installs  = 8

# ─── Cache ─────────────────────────────────────
cache-dir  = "/home/user/.cache/uv"   # Expliziter Pfad
no-cache   = false
offline    = false

# ─── Auflösung ─────────────────────────────────
resolution   = "highest"
prerelease   = "if-necessary-or-explicit"
upgrade      = false               # Nicht automatisch upgraden

# ─── Sicherheit ────────────────────────────────
native-tls   = false               # webpki-roots verwenden (portabler)

# ─── Paketindex ────────────────────────────────
[[index]]
url     = "https://pypi.org/simple"
default = true

# PyTorch CUDA-Wheels (wird nur bei expliziter Referenz genutzt)
[[index]]
url      = "https://download.pytorch.org/whl/cu124"
name     = "pytorch-cuda"
explicit = true

# ─── pip-Interface ─────────────────────────────
[pip]
compile-bytecode = true
resolution       = "highest"
strict           = false
system           = false
```

---

## Vollständiges Beispiel: Projektlokale `uv.toml`

```toml
# ./uv.toml  (im Projektverzeichnis)
# Überschreibt globale Einstellungen nur für dieses Projekt

# Kein Upgrade ohne expliziten Befehl
upgrade = false

# Dieses Projekt braucht immer Bytecode
compile-bytecode = true

# Projektspezifischer privater Index (hat Vorrang vor globalem)
[[index]]
url      = "https://pypi.mein-projekt.de/simple"
name     = "projekt-intern"
default  = true

# Fallback auf PyPI
[[index]]
url  = "https://pypi.org/simple"
name = "pypi"
```

---

## Konfigurationsprioritäten – Komplette Hierarchie

```
Höchste Priorität
      │
      ▼
1.  Kommandozeilenargumente (z. B. --index-url)
2.  Umgebungsvariablen     (z. B. UV_INDEX_URL)
3.  Projektlokale uv.toml  (./uv.toml)
4.  Benutzer uv.toml       (~/.config/uv/uv.toml)
5.  System uv.toml         (/etc/uv/uv.toml)
      │
      ▼
Niedrigste Priorität (interne Standardwerte)
```

> **Merksatz:** Umgebungsvariablen schlagen immer alle Konfigurationsdateien –
> ideal für CI/CD-Pipelines, ohne Dateien ändern zu müssen.

---

## Wichtige Umgebungsvariablen als Alternative zur `uv.toml`

| Variable | Entspricht | Beispiel |
|----------|-----------|---------|
| `UV_PYTHON` | `python-preference` | `"3.12"` |
| `UV_PYTHON_PREFERENCE` | `python-preference` | `"managed"` |
| `UV_PYTHON_DOWNLOADS` | `python-downloads` | `"manual"` |
| `UV_CACHE_DIR` | `cache-dir` | `"/tmp/uv-cache"` |
| `UV_NO_CACHE` | `no-cache = true` | `"1"` |
| `UV_OFFLINE` | `offline = true` | `"1"` |
| `UV_INDEX_URL` | `index-url` | URL |
| `UV_EXTRA_INDEX_URL` | `extra-index-url` | URL |
| `UV_INDEX_STRATEGY` | `index-strategy` | `"first-index"` |
| `UV_LINK_MODE` | `link-mode` | `"copy"` |
| `UV_COMPILE_BYTECODE` | `compile-bytecode = true` | `"1"` |
| `UV_RESOLUTION` | `resolution` | `"lowest"` |
| `UV_PRERELEASE` | `prerelease` | `"allow"` |
| `UV_HTTP_PROXY` | `http-proxy` | URL |
| `UV_HTTPS_PROXY` | `https-proxy` | URL |
| `UV_NATIVE_TLS` | `native-tls = true` | `"1"` |
| `UV_CONFIG_FILE` | `--config-file` | Pfad |
| `UV_NO_CONFIG` | `--no-config` | `"1"` |
| `UV_FROZEN` | `--frozen` | `"1"` |
| `UV_LOCKED` | `--locked` | `"1"` |
| `UV_REQUIRED_VERSION` | `required-version` | `">=0.5"` |
| `UV_CONCURRENT_DOWNLOADS` | `concurrent-downloads` | `"30"` |

---

*Quelle: [docs.astral.sh/uv/reference/settings](https://docs.astral.sh/uv/reference/settings/) · Stand März 2026*
