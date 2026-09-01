# Obsidian + GenieX – Lokales KI-Setup auf dem Dell XPS 13 (Snapdragon)

> **System:** Dell XPS 13, Snapdragon X Elite, 32 GB RAM, 1 TB SSD, Windows on ARM
> **Ziel:** Vollständig lokale KI im Knowledge-Vault – Chat, RAG über ~1.600 Notizen, Inline-Bearbeitung – ohne Cloud-Abhängigkeit
> **Architektur:** GenieX (NPU, Chat) + Ollama ARM64 (CPU, Embeddings) + Local LLM Hub & Editing Toolbar in Obsidian

---

## Architektur-Überblick

```
┌─────────────────────────────────────────────────┐
│ Obsidian (Windows Desktop, Vault auf NTFS)      │
│                                                 │
│  ┌──────────────────┐   ┌────────────────────┐  │
│  │ Local LLM Hub    │   │ Editing Toolbar    │  │
│  │ Chat · RAG ·     │   │ AI Tools           │  │
│  │ Workflows        │   │ (Inline-Rewrite)   │  │
│  └───────┬──────────┘   └─────────┬──────────┘  │
└──────────┼────────────────────────┼─────────────┘
           │ Chat                   │ Chat
           ▼                        ▼
   GenieX serve  ◄──── Qwen3-4B (NPU via QAIRT)
   http://127.0.0.1:18181/v1
           
           │ Embeddings (nur Local LLM Hub / RAG)
           ▼
   Ollama ARM64  ◄──── nomic-embed-text (CPU)
   http://localhost:11434
```

**Warum zwei Server?** `geniex serve` liefert nur Chat Completions (OpenAI-kompatibel), keinen Embeddings-Endpoint. Für die semantische Vault-Suche (RAG) braucht Local LLM Hub aber ein Embedding-Modell. Ollama übernimmt das als schlanker Nebendienst – Embedding-Modelle sind klein (~270 MB) und laufen problemlos auf der CPU.

**Warum kein WSL?** Anders als beim Claude-Code-Setup läuft hier alles Windows-nativ (ARM64). GenieX, Ollama und Obsidian greifen direkt auf NTFS zu – keine `/mnt/c/`-Umwege nötig.

---

## Teil 1: GenieX installieren und Modell bereitstellen

### 1.1 GenieX installieren

Windows-ARM64-Installer von der GenieX-Seite herunterladen und ausführen, danach ein **neues** Terminal öffnen:

```powershell
geniex --version
```

### 1.2 Modell laden

Empfehlung für 32 GB RAM – zwei Optionen, mit Option A starten:

**Option A – Qwen3-4B als AI-Hub-Bundle (NPU, empfohlen):**

```powershell
geniex pull ai-hub-models/Qwen3-4B-Instruct-2507
```

Vorkompiliert für die Hexagon-NPU (QAIRT-Runtime). Schnellste Inferenz, geringste CPU-/Akku-Last, zuverlässiges Tool-Calling (wichtig für die Vault-Tools von Local LLM Hub).

**Option B – Qwen3-8B als GGUF (llama.cpp, mehr Qualität):**

```powershell
geniex pull Qwen/Qwen3-8B-GGUF
```

Läuft über die llama.cpp-Runtime im Hybrid-Modus (CPU/GPU/NPU). Mit 32 GB RAM problemlos, spürbar bessere Antwortqualität bei längeren Kontexten, aber langsamer als das NPU-Bundle. Hinweis: `--device hybrid` ist der Standard und der schnellste Pfad – `--device npu` nur zum Debuggen erzwingen.

### 1.3 Testen und Server starten

```powershell
# Kurzer Funktionstest
geniex infer ai-hub-models/Qwen3-4B-Instruct-2507

# Server starten → http://127.0.0.1:18181/v1
geniex serve
```

Gegenprobe in einem zweiten Terminal:

```powershell
curl http://127.0.0.1:18181/v1/chat/completions `
  -H "Content-Type: application/json" `
  -d '{"model": "ai-hub-models/Qwen3-4B-Instruct-2507", "messages": [{"role": "user", "content": "Hallo!"}]}'
```

### 1.4 Autostart (optional)

Damit der Server beim Anmelden mitstartet, eine Verknüpfung in den Autostart-Ordner legen (`Win+R` → `shell:startup`):

```
Ziel: powershell.exe -WindowStyle Hidden -Command "geniex serve"
```

Alternativ per Aufgabenplanung als Task „Bei Anmeldung" – sauberer, da ohne sichtbares Fenster.

---

## Teil 2: Ollama ARM64 für Embeddings

### 2.1 Installieren

Ollama für Windows ARM64 von ollama.com herunterladen und installieren. Ollama startet standardmäßig als Hintergrunddienst auf `localhost:11434`.

### 2.2 Embedding-Modell laden

```powershell
ollama pull nomic-embed-text
```

Mehr braucht Ollama in diesem Setup nicht zu tun. Kein Chat-Modell laden – Chat läuft über GenieX. So bleiben RAM und NPU frei.

**RAM-Bilanz bei laufendem Vollbetrieb (grobe Richtwerte):**

| Komponente | RAM |
|---|---|
| Qwen3-4B (NPU) | ~4–5 GB |
| nomic-embed-text (Ollama) | ~0,5 GB |
| Obsidian + Windows | ~6–8 GB |
| **Frei für alles andere** | **~18 GB** |

Auch mit Qwen3-8B (Option B, ~8–10 GB) bleibt komfortabel Luft.

---

## Teil 3: Local LLM Hub konfigurieren

### 3.1 Installation

Das Plugin ist über BRAT oder manuell installierbar (je nach aktuellem Community-Store-Status):

1. **BRAT** installieren (Community Plugins → „BRAT")
2. BRAT-Settings → „Add Beta plugin" → `https://github.com/takeshy/obsidian-local-llm-hub`
3. Plugin unter Community Plugins aktivieren

### 3.2 Chat-Backend: GenieX anbinden

Settings → **Local LLM Hub** → Framework: **„LM Studio (OpenAI compatible)"** wählen – dieses Framework akzeptiert jeden OpenAI-kompatiblen Endpoint:

| Einstellung | Wert |
|---|---|
| Base URL | `http://127.0.0.1:18181` |
| API Key | leer lassen (oder Platzhalter wie `not-needed`) |
| Modell | `ai-hub-models/Qwen3-4B-Instruct-2507` |

> **Wichtig:** Bewusst *nicht* das Ollama-Framework wählen – darüber liefe nur der eingeschränkte Marker-Modus. Über das OpenAI-kompatible Framework nutzt das Plugin echtes Function Calling für die Vault-Tools (Notizen lesen, schreiben, durchsuchen). Falls das Modell die erste Tool-Anfrage ablehnt, fällt das Plugin automatisch auf Marker-Modus zurück; unter Settings → Local LLM → „Re-enable tools" lässt sich das zurücksetzen.

### 3.3 RAG einrichten

Settings → **RAG**:

| Einstellung | Wert |
|---|---|
| Embedding server URL | `http://localhost:11434` |
| Embedding-Modell | `nomic-embed-text` |
| Index-Ordner | zunächst leer = ganzer Vault |

Danach den **Index einmalig aufbauen** (Befehl im Plugin bzw. RAG-Settings). Bei ~1.600 Dateien dauert der Erstlauf einige Minuten – die CPU arbeitet dabei sichtbar, das ist normal. Der Index wird danach inkrementell aktualisiert.

**Tipp für den Knowledge-Vault:** Falls der Index zu viel Rauschen liefert, per Index-Ordner-Filter auf die inhaltsstarken Kategorien beschränken (z. B. `02-Tech`, `05-Languages`, `06-Notes`) und Anhang-/Vorlagenordner auslassen.

### 3.4 Vault-Tools absichern

Settings → **Workspace → LLM vault tool folders**: Hier lässt sich einschränken, auf welche Ordner die KI schreibend zugreifen darf. Empfehlung für den Anfang: auf `06-Notes` (oder einen Sandbox-Ordner) begrenzen und erst nach ein paar Wochen Vertrauensaufbau öffnen. Das Plugin führt zusätzlich eine Edit-History mit Diff-Ansicht und One-Click-Restore – trotzdem gilt wie immer: **Backup vor größeren automatisierten Eingriffen.**

---

## Teil 4: Editing Toolbar AI Tools anbinden

Da die Editing Toolbar bereits installiert ist, fehlt nur die Endpoint-Konfiguration.

Settings → **Editing Toolbar** → AI-Bereich → **Custom Model**:

| Einstellung | Wert |
|---|---|
| API-URL | `http://127.0.0.1:18181/v1` |
| API Key | leer (seit 4.0.11 optional) |
| Modell | per Dropdown wählen – das Plugin erkennt verfügbare Modelle am Endpoint automatisch |

Die URL-Logik ist tolerant: sowohl `.../v1` (wird automatisch zu `/chat/completions` ergänzt) als auch die volle `/chat/completions`-Adresse funktionieren.

Damit verfügbar: Smart Rewrite (Grammatik, Zusammenfassen, Erklären), Formatkonvertierung (Liste/Tabelle/Canvas), Frontmatter-Generierung und die Inline-Autovervollständigung (Tab zum Übernehmen). Die Inline-Completion feuert bei jedem Tippen Anfragen ab – falls das auf dem NPU-Modell zu Latenz führt oder stört, lässt sie sich separat deaktivieren und nur der AI-Werkzeugkasten nutzen.

---

## Teil 5: Betrieb und Wartung

### Tägliche Reihenfolge

1. `geniex serve` läuft (Autostart) – prüfbar per `curl http://127.0.0.1:18181/v1/models`
2. Ollama läuft als Dienst (Standard nach Installation)
3. Obsidian starten – fertig

### Rollenverteilung im Alltag

| Aufgabe | Werkzeug |
|---|---|
| „Was steht in meinen Notizen zu X?" | Local LLM Hub Chat (RAG) |
| Notizen automatisiert anlegen/ändern | Local LLM Hub Vault-Tools / Workflows |
| Markierten Text umschreiben, zusammenfassen | Editing Toolbar AI Tools |
| Frontmatter aus Inhalt generieren | Editing Toolbar AI Tools |
| Wiederkehrende Abläufe (z. B. Wochenreview) | Local LLM Hub Workflow-Builder |

### Troubleshooting

| Symptom | Prüfen |
|---|---|
| Plugin meldet Verbindungsfehler | Läuft `geniex serve`? Port 18181 frei? `curl`-Test aus 1.3 |
| RAG findet nichts / Indexfehler | Läuft Ollama? `curl http://localhost:11434/api/embeddings -d '{"model":"nomic-embed-text","prompt":"test"}'` |
| Tool-Calling funktioniert nicht | Framework auf „LM Studio (OpenAI compatible)"? „Re-enable tools" in den Settings |
| Antworten langsam / Lüfter laut | Läuft das Modell versehentlich über CPU statt NPU? AI-Hub-Bundle (Option A) statt GGUF nutzen |
| Editing Toolbar erkennt Modell nicht | URL mit `/v1` angegeben? GenieX-Server neu gestartet nach Modellwechsel? |

### Updates

- **GenieX ist Developer Preview** – Releases erscheinen häufig; vor Updates kurz die Release Notes auf Breaking Changes prüfen (`geniex serve` meldet neue Versionen selbst).
- **Local LLM Hub** über BRAT aktuell halten.
- Nach größeren Plugin-Updates den RAG-Index prüfen, ggf. neu aufbauen.

---

## Nächste Schritte (optional)

- [ ] Qwen3-8B (Option B) testen und Qualität vs. Geschwindigkeit vergleichen
- [ ] RAG-Index-Ordner auf die relevanten Vault-Kategorien eintunen
- [ ] Ersten Workflow im Local LLM Hub bauen (z. B. „neue Notiz → Frontmatter + Tags generieren")
- [ ] Vault-Tool-Ordnerfreigabe schrittweise erweitern
- [ ] Setup-Erfahrungen in `06-Notes` dokumentieren
