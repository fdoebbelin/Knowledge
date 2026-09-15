**OpenClaw ist real, existiert unter `github.com/openclaw/openclaw` und ist eines der schnellstwachsenden Open-Source-Projekte aller Zeiten** – ein MIT-lizenzierter, lokal laufender KI-Agent des PSPDFKit-Gründers Peter Steinberger (@steipete), der Messaging-Apps wie Telegram, WhatsApp oder Discord zur primären UI für einen persönlichen Assistenten macht. **Für einen CachyOS-Dozenten mit RTX 4070 Ti Super und existierendem Ollama-Setup ist OpenClaw technisch in 20–30 Minuten produktiv einsetzbar**, funktioniert mit `gpt-oss:20b` oder `qwen3:14b` stabil im Tool-Calling und lohnt sich besonders für Szenarien, in denen ein Assistent asynchron per Chat-App zugänglich sein soll. Die großen Einschränkungen sind reale Sicherheitsrisiken (dokumentiert 17 % native Defense-Rate gegen Prompt-Injection, mehrere 2026er CVEs, Shadow-IT-Vorfälle) und eine noch unreife Governance nach Steinbergers Wechsel zu OpenAI. Für reine Coding-Assistenz sind **Aider, Cline oder Claude Code praktisch überlegen**; als generalistischer Personal-Agent ist OpenClaw aktuell praktisch konkurrenzlos.

Wichtiger Hinweis zur Namensverwirrung vorab: Das ältere GitHub-Projekt *OpenClaw* von Monolith (Captain-Claw-Reimplementierung) ist – wie im Auftrag vermutet – nicht gemeint; Namenskollisionen wie *OpenClaude* oder *Open Crew* spielen keine Rolle. Der Slogan *"The AI that actually does things"* identifiziert eindeutig Steinbergers Projekt, das Ende Januar 2026 vom Vorgängernamen "Clawdbot" (angelehnt an Anthropics Claude) über eine Zwischenstation "Moltbot" zum finalen "OpenClaw" umbenannt wurde.

## Was OpenClaw eigentlich ist – und warum es viral ging

OpenClaw ist ein **Gateway-basierter Agent-Runtime in TypeScript/Node.js**, der drei Dinge neu kombiniert: einen persistenten lokalen Daemon auf Port `127.0.0.1:18789`, einen modell-agnostischen Agent-Loop mit echtem Tool-Calling und über **24 Messaging-Kanäle** (WhatsApp via Baileys, Telegram, Slack, Discord, Signal, iMessage via BlueBubbles, Matrix, Teams, IRC u. a.) als primäre Benutzeroberfläche. Statt eine weitere Chat-Web-App zu sein, klinkt sich der Agent in die Apps ein, die man ohnehin offen hat. Dazu kommt der **ClawHub** – ein Vektor-indexiertes Skill-Marketplace, das im April 2026 je nach Quelle zwischen **13.000 und über 40.000 Community-Skills** bereitstellt.

Steinberger veröffentlichte das Projekt als Wochenend-Hack im November 2025, es schlummerte zwei Monate, und explodierte Ende Januar 2026: **~60.000 GitHub-Stars in 72 Stunden**, was laut DigitalOcean und The New Stack das schnellste Wachstum der GitHub-Geschichte markiert. Im April 2026 liegt die belastbare Spanne bei **ca. 250.000 bis 350.000 Stars** (unterschiedliche Snapshots; Wikipedia dokumentierte am 3. März 2026 exakt 250.829 Stars – damit überholte OpenClaw React, das dafür zehn Jahre brauchte). Contributor-Zahl: **rund 1.075 bis 1.200**, Commit-Aktivität über 32.000 Commits und etwa 13 Releases allein im März 2026. Lizenz ist **MIT**.

Die Eigentumslage: Nach Steinbergers Wechsel zu OpenAI am **14. Februar 2026** wurde das Projekt an eine unabhängige **OpenClaw Foundation (501(c)(3))** übergeben, mit OpenAI, GitHub, NVIDIA, Vercel und Convex als Corporate-Sponsoren. DigitalOcean betreibt einen **1-Click-Deploy** im Marketplace.

## Technische Architektur und Tech-Stack

Der Kern ist ein **TypeScript-Monorepo** (pnpm-Workspaces, tsdown-Bundler, oxlint/oxfmt-Linter, Vitest). Das Gateway ist ein einziger persistenter Daemon-Prozess pro Host, gesteuert über **WebSocket** mit strukturiertem Protokoll (`connect`/`hello-ok`, `req/res`, Events für Presence, Health, Agent-Runs, Sessions, Pairing, Approvals). Für macOS und iOS existieren **Swift-Companion-Apps** (Menu-Bar-Control, Voice-Wake, Push-to-Talk-Overlay); Android-Nodes koppeln sich per WebSocket. **Windows läuft ausschließlich über WSL2**.

Die Architektur ist dreischichtig: **Gateway → Agents → Channels**. Jeder Agent hat ein eigenes Workspace-Verzeichnis, eigene Auth-Profile unter `~/.openclaw/agents/<id>/`, eigene Session-Stores. Das **Multi-Agent-Routing** erlaubt etwa, dass ein "work"-Agent auf Slack mit Claude Opus 4.6 läuft, während ein "personal"-Agent auf WhatsApp mit Haiku oder lokalem Ollama läuft. Routing-Matcher sind `channel`, `accountId`, `peer.kind`, `peer.id`.

**Bootstrap-Prompt-Dateien** prägen den Agent-Charakter: `SOUL.md` (Persona, 500–1500 Wörter), `IDENTITY.md` (Name, Version), `USER.md` (Nutzer-Kontext), `AGENTS.md` (harte Policies), `MEMORY.md`, `TOOLS.md`, `HEARTBEAT.md`, `BOOTSTRAP.md`. Alle werden in den System-Prompt injiziert und hot-reloaded. Eine Schwester-Registry **onlycrabs.ai** dient als reiner Persona-Marketplace.

**MCP (Model Context Protocol) wird voll unterstützt**, ausgeführt über den internen "MCPorter". Stdio- und HTTP/SSE-Transport funktionieren; MCP-Server können in TypeScript oder Python geschrieben sein. Darüber hinaus hat OpenClaw ein **eigenes Skill-Format** (Markdown-Bundles mit `SKILL.md`, YAML-Frontmatter, optionalen Scripts) – das ist teilweise parallel zu MCP, was zur Ökosystem-Fragmentierung beiträgt, die Skills aber massiv zugänglicher für Nicht-Entwickler macht.

Erwähnenswert sind die **Automation-Primitive**: Der **Heartbeat** triggert alle 30 Minuten autonom einen Main-Session-Turn, der `HEARTBEAT.md` liest ("schau in die Inbox, prüfe Kalender, fasse bei Bedarf zusammen"); **Cron** erlaubt präzise Schedules mit isolierten Sessions; **Hooks** reagieren auf Events (Tool-Calls, `/new`, startup); **Task Flow** stellt durable Multi-Step-Flows mit Revision-Tracking bereit. Das ist der Mechanismus, mit dem OpenClaw seinen Slogan einlöst – ein Agent, der auch dann arbeitet, wenn niemand aktiv mit ihm chattet.

## LLM-Support und Ollama-Integration

OpenClaw unterstützt **über 35 Provider** – von Anthropic, OpenAI, Google/Gemini, xAI, DeepSeek und Groq bis zu AWS Bedrock, Mistral, MiniMax, Moonshot (Kimi), Z.AI (GLM), HuggingFace, OpenRouter, LiteLLM, Vercel AI Gateway, NVIDIA, Fireworks, Together AI sowie lokalen Runtimes **Ollama, LM Studio, vLLM und SGLang**.

Für den beschriebenen Stack (RTX 4070 Ti Super, 16 GB VRAM, existierendes Ollama) sind **zwei kritische Konfigurationsdetails** entscheidend: Erstens muss Ollama über die **native `/api/chat`-Route** angesprochen werden, nicht über `/v1` (die OpenAI-kompatible URL droppt Tool-Calls silent im Streaming-Modus – Modelle produzieren dann rohes Tool-JSON als Prosa statt echter Funktionsaufrufe). Zweitens muss `num_ctx` explizit auf **mindestens 32.768, besser 65.536** erhöht werden, weil der Standard von 4.096 Tokens allein vom OpenClaw-System-Prompt plus Tool-Schemas und SOUL.md gesprengt wird.

Die empfohlene Modell-Hierarchie für 16 GB VRAM:

| Modell | VRAM | Geschwindigkeit | Tool-Calling | Rolle |
|---|---|---|---|---|
| **gpt-oss:20b** (MoE, 3.6B aktiv) | ~14 GB | **~140 tok/s** | nativ, BFCL-stark | **Primary** – bestes Gesamtpaket |
| qwen3:14b | ~11 GB | 55–65 tok/s | stark | Fallback, exzellente Instruction-Following |
| qwen2.5-coder:14b | ~12 GB | 55–60 tok/s | stark | Coding-Assistenz-Mode |
| mistral-small3.2:24b (Q4_K_M) | ~14 GB | ~40 tok/s | solide | Deutschsprachige Qualität |
| llama3.3:70b | **passt nicht** | – | – | selbst Q2_K sprengt 16 GB |

Der entscheidende Praxis-Config-Block in `~/.openclaw/openclaw.json` sieht so aus:

```json5
{
  "models": {
    "providers": {
      "ollama": {
        "baseUrl": "http://127.0.0.1:11434",
        "api": "ollama",
        "apiKey": "ollama-local",
        "models": [
          { "id": "gpt-oss:20b", "contextWindow": 65536,
            "options": { "num_ctx": 65536, "temperature": 0.6 } },
          { "id": "qwen3:14b", "contextWindow": 40960,
            "options": { "num_ctx": 40960 } }
        ]
      }
    }
  },
  "agents": { "defaults": { "model": {
    "primary": "ollama/gpt-oss:20b",
    "fallbacks": ["ollama/qwen3:14b", "ollama/qwen2.5-coder:14b"]
  }}}
}
```

Alternativ reicht das Setzen von `OLLAMA_API_KEY=ollama-local` als Env-Var – dann discovert OpenClaw Tool-capable Modelle per `/api/tags` und `/api/show` automatisch.

## Installation auf CachyOS – der pragmatische Pfad

Der offizielle `install.sh` unterstützt Arch-basierte Distributionen **nicht nativ** (GitHub Issue #8051); der saubere Weg ist deshalb npm global. AUR-Pakete existieren zwar (`openclaw-git`), sind aber aktuell instabil mit Build-Prepare-Fehlern. Ein einziges AUR-Paket `openclaw-bin` ist **nicht verfügbar**.

Der verifizierte Happy-Path auf CachyOS:

```bash
# System-Tooling + Playwright/Chromium-Abhängigkeiten
sudo pacman -Syu --needed base-devel git curl nodejs npm pnpm \
  ollama-cuda nvidia-open-dkms nvidia-utils \
  nspr nss alsa-lib atk at-spi2-core cups dbus fontconfig \
  gdk-pixbuf2 glib2 gtk3 libdrm libxcomposite libxdamage libxrandr pango mesa

sudo systemctl enable --now ollama

# Modelle laden (ca. 14 + 8 + 8 GB)
ollama pull gpt-oss:20b
ollama pull qwen3:14b
ollama pull qwen2.5-coder:14b

# Kontext-Window anheben und Variante speichern
printf "/set parameter num_ctx 65536\n/save gpt-oss:20b-64k\n/bye\n" | ollama run gpt-oss:20b

# OpenClaw global
npm install -g openclaw@latest
echo 'export PATH="$PATH:$(npm config get prefix)/bin"' >> ~/.bashrc

# Env-Basics
cat > ~/.openclaw/.env <<EOF
OLLAMA_API_KEY=ollama-local
OLLAMA_HOST=http://127.0.0.1:11434
NODE_OPTIONS=--max-old-space-size=4096
EOF

openclaw onboard --install-daemon  # interaktives Setup + systemd-User-Service
sudo loginctl enable-linger "$USER"  # Gateway läuft auch ohne Login
openclaw doctor --deep --yes
openclaw security audit --deep
openclaw agent --message "Sag hallo auf Deutsch und liste deine Tools auf."
```

**Drei Arch-spezifische Stolperfallen**, die praktisch alle neuen Nutzer erwischen: (1) **Version-Manager wie `nvm` oder `fnm` brechen systemd-User-Services und die WhatsApp/Telegram-Channels**, weil der `PATH` in non-login Shells fehlschlägt – entweder Systempaket `nodejs` nutzen oder in der Unit `Environment=PATH=...` hart setzen. (2) Der **BORE-Scheduler + LTO-Node** auf CachyOS kann gelegentlich Segfaults im TypeScript-JIT verursachen; Ausweg ist `nodejs-lts-jod` aus dem AUR. (3) Bei Docker-Betrieb ist `127.0.0.1:11434` **nicht der Host**, also entweder `--network=host` oder `baseUrl` auf `172.17.0.1:11434` umkonfigurieren.

## Praktische Workflows für einen IT-Dozenten

Die sinnvollsten Einsätze in einem deutschen Schulungskontext lassen sich in drei Kategorien gliedern. **Erstens Content-Produktion**: Eine eigene `SKILL.md` namens `schulungsdoc` kann aus Stichpunkten strukturierte Markdown-Unterlagen mit Lernzielen, Theorie, Übung und Quiz generieren und direkt `pandoc` zum PDF-Export anstoßen. **Zweitens Systempflege**: Ein `pacman_health`-Skill prüft via `paru -Qtdq`, `checkupdates`, `systemctl --failed` und `journalctl -p err` den Systemstatus und schlägt Fixes vor, führt aber nichts destruktives ohne Approval aus. **Drittens mobile Erreichbarkeit**: Über Telegram-Integration (`openclaw channels add --channel telegram --token ...`) ist der Assistent aus dem Klassenzimmer oder unterwegs zugänglich – mit zwingender `allowFrom`-Allowlist auf die eigene User-ID und `dmPolicy: "closed"`, sonst meldet `security audit` sofort kritisch.

Das **SOUL.md für diesen Kontext** sollte sich strikt auf deutsche Sie-/Du-Form-Regeln, SMART-Lernziele, konstruktivistische Didaktik und harte DSGVO-Grenzen (keine Schüler-Namen exfiltrieren) festlegen. Entscheidend ist, Bootstrap-Dateien zusammen unter 1.500 Tokens zu halten (`bootstrapTotalMaxChars` setzen), weil sonst jeder Request unnötig Kontext verbrennt.

Für Coding-Workflows lohnt der GitHub-Skill aus ClawHub (`npx clawhub@latest install github-manager`) plus `GITHUB_TOKEN` in `~/.openclaw/.env`; typische Befehle wie "Öffne PR mit aktuellen Änderungen, Titel: feat(kurs-42)" laufen dann autonom durch. Für MCP-basierte Integrationen (Postgres, Filesystem, GitHub) reicht der `mcp.servers`-Block in der Config, der npx-Server automatisch startet.

**Performance-Realität auf dem Stack**: Mit `gpt-oss:20b` fühlt sich OpenClaw flüssig an – Einzel-Task-Latenz 0,5–2 Sekunden, Tool-Call-Roundtrip 3–5 Sekunden, subjektive Tool-Call-Erfolgsrate etwa 90 %. Der Node-Gateway-Prozess belegt 400–700 MB RAM und steigt mit Session-History; bei parallelen Sessions empfiehlt sich die NODE_OPTIONS-Heap-Erweiterung. **Multi-Model-Setups gehen mit 16 GB VRAM nicht** – `OLLAMA_MAX_LOADED_MODELS=1` setzen, sonst Swap-Thrashing.

## Sicherheit ist die ernsteste Einschränkung

OpenClaw verschiebt "AI-Agent" von Chatbot zu **prozessdurchführender Runtime mit Shell-, Mail-, Kalender- und Messaging-Zugriff**. Das ist bewusst mächtig und bewusst gefährlich. Die relevanten Fakten:

Eine arXiv-Studie (*"Don't Let the Claw Grip Your Hand"*, März 2026) testete 47 adversariale Szenarien und fand eine **native Defense-Rate von nur 17 %** – 83 % der Prompt-Injection-Angriffe waren out-of-the-box erfolgreich. **Mehrere CVEs** (unter anderem CVE-2026-25593, -24763, -25475, -26319) wurden in Q1 2026 veröffentlicht, bewertet als moderate bis high. Die von Oasis Security gemeldete **ClawJacked-Schwachstelle** erlaubte malicious Websites, den lokalen WebSocket-Gateway zu hijacken (inzwischen gepatcht). Cisco-Security-Research zeigte, dass **Third-Party-Skills im ClawHub-Registry unzureichend gevettet** werden. Huntress dokumentierte, dass bösartige GitHub-Repos in Bing-AI-Suchergebnissen für "OpenClaw Windows" Top-Positionen belegten. Der Maintainer "Shadow" formulierte auf Discord deutlich: *"If you can't understand how to run a command line, this is far too dangerous a project for you to use safely."*

Die **praktischen Mitigationen**, die ein Dozent zwingend umsetzen sollte: `dmPolicy: "closed"` mit expliziten Allowlists auf Telegram/WhatsApp, Bash-Tool mit Allowlist und `approvalMode: "untrusted"`, `tools.filesystem.allowedRoots` eng gezogen, `denyPaths` für `/etc`, `~/.ssh`, `~/.gnupg`, nach jedem Upgrade `openclaw doctor --fix` und `openclaw security audit --deep --fix`, sandboxed Tools für non-main Sessions (`agents.defaults.sandbox.mode: "non-main"`) und Gateway strikt auf `127.0.0.1` binden. Für Produktivnutzung gilt: Docker-Sandbox (`Dockerfile.sandbox`) ist strukturell deutlich sicherer als Host-Mode.

## Vergleich zu den etablierten Alternativen

Die Wettbewerber-Landschaft differenziert sich deutlich – OpenClaw besetzt eine **fast einzigartige Nische als generalistischer Messaging-First-Personal-Agent**, während alle anderen Tools (außer dem in die Jahre gekommenen Open Interpreter) **entwickler-zentriert** sind.

| Tool | Stars (Apr 2026) | Lizenz | UI | Fokus | Lokale LLMs | MCP | Agent-Autonomie |
|---|---|---|---|---|---|---|---|
| **OpenClaw** | ~250K–350K | MIT | Messaging + CLI + macOS-App | Generalistischer Personal-Agent | ✅ Ollama/LM Studio/vLLM | ✅ + eigene Skills | sehr hoch, wenig Guardrails |
| **OpenHands** | ~65K–70K | MIT | Browser-Web-UI + CLI | Autonomer SW-Engineer | ✅ | ✅ | sehr hoch, Docker-gesandboxt |
| **Claude Code** | ~80K–115K | proprietär | Terminal + IDE | Professionelles Coding | ❌ nur Anthropic | ✅ tiefste Integration | hoch, Hooks/Permissions |
| **Cline** | ~58K–60K | Apache 2.0 | VS Code + JetBrains | IDE-Agent, permission-gated | ✅ Ollama/LM Studio | ✅ Marketplace | mittel, step-by-step |
| **Open Interpreter** | ~63K | AGPL-3.0 | CLI + Voice (01) | Computer-Use lokal | ✅ | schwach | hoch, Momentum verloren |
| **Aider** | ~43K | Apache 2.0 | reines CLI | Git-native Pair-Programmer | ✅ via LiteLLM | begrenzt | mittel, interaktiv |
| **Goose** | ~29K | Apache 2.0 | Desktop + CLI | General-Purpose Dev-Agent | ✅ 15+ Provider | ✅ nativ (erster MCP-Client!) | hoch, konfigurierbar |
| **Continue** | ~33K | Apache 2.0 | IDE + Headless/CI | Pivot zu CI-PR-Reviews | ✅ | ✅ | konfigurierbar |

**Konkrete Entscheidungshilfe für den Dozenten**: Wer primär Code-Assistenz in der IDE sucht, ist mit **Cline oder Continue** besser bedient – beides hat über fünf Millionen Installs, permission-gated Steps und ist für den Terminal-CLI-Workflow eines Arch-Users näher am Fluss. Wer lieber im Terminal lebt und Git-zentriert arbeitet, nimmt **Aider** (Repo-Map via tree-sitter, SWE-Bench-starkes Polyglot-Ergebnis mit 84,9 %). Wer **autonome Software-Engineering-Tasks** in Docker delegieren will, nimmt OpenHands (53 % SWE-bench Verified mit Claude 4.5, v1.6.0 seit März 2026 mit Kubernetes-Support). Wer einen **Allround-Personal-Assistenten mit Messaging-Zugriff** will, hat **nur OpenClaw** als ernsthafte Option.

Zwei bemerkenswerte 2026er Ereignisse am Rand: **Goose** wurde im November 2025 von Block zusammen mit der MCP-Referenzimplementierung an die **Agentic AI Foundation** unter der Linux Foundation gespendet – damit ist Goose der "institutionell belastbarste" Agent. Und **Claude Code** hat durch einen `.map`-File-Leak am 31. März 2026 eine Open-Source-Fork **"claw-code"** erzeugt, die in 24 Stunden 100.000 Stars sammelte (noch schneller als OpenClaw selbst) – mit zunehmenden DMCA-Konflikten. Der Markt für agentische Coding-Tools ist also gerade in extremer Bewegung.

## Fazit – Was ist OpenClaw wirklich wert?

**Für die geplanten Schulungsmaterialien ist OpenClaw primär als Lehrgegenstand interessant, weniger als Werkzeug zur Materialerstellung.** Das Projekt ist didaktisch herausragend, um 2026er Konzepte wie MCP, agentische Runtimes, Tool-Calling und Prompt-Injection konkret zu demonstrieren – es ist aktuell, viral genug, dass Lernende den Namen kennen, und die Architektur mit Gateway/Agents/Channels eignet sich für saubere Erklärungen. Die Installation auf CachyOS mit Ollama ist **in einer Unterrichtseinheit machbar** und zeigt exemplarisch die Herausforderungen lokaler LLM-Infrastruktur (Tool-Calling-Quirks, Kontext-Tuning, VRAM-Planung).

Als **produktives Werkzeug für einen Dozenten** sind die realistischeren Optionen anders gewichtet: Für Materialerstellung und Code-Reviews ist **Cline in VS Code oder Aider im Terminal** mit Ollama-Anbindung stabiler, besser dokumentiert und sicherheitsreifer. Für **asynchrone Aufgabenautomatisierung per Smartphone** (Inbox-Triage, Cron-Reminder, Telegram-Bot für Schnellanfragen an die eigene Wissensbasis) ist OpenClaw tatsächlich konkurrenzlos – aber nur mit strikt konfigurierter Sandbox, Messaging-Allowlist und regelmäßigen `security audit`-Läufen.

Die ehrlichste Empfehlung lautet deshalb: **OpenClaw auf einem dedizierten Test-Agent einrichten, nicht auf dem Arbeits-Laptop mit produktiven SSH-Keys und Lehrunterlagen.** Die 17-%-Defense-Rate und die dokumentierten Shadow-IT-Vorfälle sind kein Marketing-FUD, sondern reales Operationsrisiko. Wenn der Test nach einigen Wochen Heartbeat-Workflows und Skill-Experimenten überzeugend läuft, kann der Scope schrittweise erweitert werden. Bis dahin bleibt OpenClaw das faszinierendste Beispiel dafür, wie nah wir 2026 an "JARVIS für die Schreibtischschublade" herangekommen sind – und wie weit die Sicherheitslage noch davon entfernt ist, dass man das bedenkenlos jedem Lernenden empfehlen kann.