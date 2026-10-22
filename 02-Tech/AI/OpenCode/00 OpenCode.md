---
title: OpenCode
aliases:
  - OpenCode V2
tags:
  - ai
  - opencode
  - cli
  - workflow
type: anleitung
description: OpenCode als offenes KI-Coding-Agent im Terminal – Installation, Provider, AGENTS.md als Projektgedächtnis und der Einsatz im Knowledge-Vault.
created: 2026-10-22
updated: 2026-10-22
status: active
system: Fedora Sway Atomic
---

# OpenCode

**OpenCode ist ein quelloffenes KI-Coding-Agent im Terminal**, das zusätzlich als Desktop- und Web-App läuft. Anders als die meisten Konkurrenten ist es nicht an einen einzelnen Modellhersteller gebunden: Über `/connect` lassen sich fast alle gängigen Provider anbinden, von Anthropic und OpenAI über OpenRouter bis zu lokalen Laufzeiten wie Ollama, LM Studio und vLLM.

Seit dem 22.10.2026 wird dieser Vault mit OpenCode statt mit Claude Code verwaltet – siehe [[00 Claude Code|Claude Code]] für den Vorgänger. Die Projektregeln stehen in [[AGENTS]], die vollständige Anleitung in der offiziellen Dokumentation unter <https://opencode.ai/v2/docs/>.

> [!info] Version
> Grundlage ist **OpenCode V2** (Referenzsystem: v2.1.2). V1-Dokumentation unter `opencode.ai/docs` gilt für dieses Dokument nicht mehr; die V2-Dokumentation unter `opencode.ai/v2/docs/` ist die Quelle der Wahrheit.

---

## Installation

```bash
# curl (empfohlen, plattformunabhängig)
curl -fsSL https://opencode.ai/v2/install | bash

# Homebrew
brew install anomalyco/tap/opencode-v2

# Arch (AUR)
paru -S opencode-beta

# mise
mise use -g opencode
```

Alternativ über `npm install -g @opencode/cli`, `bun install -g --trust @opencode/cli` oder `pnpm add -g --allow-build=@opencode/cli @opencode/cli`. Windows-Paketmanager werden nicht unterstützt; unter Windows gibt es die Binärdatei als ZIP.

Auf dem Referenzsystem liegt das Binary unter `~/.opencode/bin/opencode`:

```bash
opencode --version
# opencode v2.1.2
```

> [!note] Warum die curl-Variante
> Das npm-Paket zieht über ein Postinstall-Skript die native Binärdatei nach – braucht also Node.js. Der curl-Installer ist die einzige Variante ohne Laufzeitabhängigkeit und aktualisiert sich selbst.

---

## Provider und Modelle

OpenCode bringt einen Katalog von [models.dev](https://models.dev) mit. Für die meisten Provider genügt der Login im TUI:

```text
/connect      # Anbieter wählen, Zugangsdaten eingeben
/models       # Modell auswählen
```

Weitere Wege:

| Weg | Wie |
|---|---|
| **OpenCode Console / Go** | Abo (10 $/Monat) mit geprüften Coding-Modellen; API-Key kopieren, als „OpenCode Go“ verbinden |
| **API-Key** | In der Provider-Doku erzeugen, als Umgebungsvariable setzen, dann `/connect` |
| **GitHub Copilot** | Geräte-OAuth, kein API-Key nötig; `/connect` → „Login with GitHub Copilot“ |
| **Lokal (Ollama)** | `ollama serve`, `ollama pull qwen3:8b`; OpenCode fragt `http://127.0.0.1:11434` automatisch ab |
| **Lokal (LM Studio / vLLM)** | voreingestellt `http://127.0.0.1:1234/v1` bzw. `:8000/v1` |

Eigene oder gesperrte Provider kommen über `providers` in die Konfiguration:

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "providers": {
    "acme": {
      "name": "Acme",
      "env": ["ACME_API_KEY"],
      "package": "@opencode/ai/providers/openai-compatible",
      "settings": { "baseURL": "https://llm.acme.example/v1" },
      "models": { "qwen3-coder": { "name": "Qwen 3 Coder" } }
    }
  }
}
```

---

## AGENTS.md als Projektgedächtnis

`AGENTS.md` ist das Gegenstück zu `CLAUDE.md`: eine Markdown-Datei im Projektstamm, die OpenCode **automatisch bei jedem Sitzungsstart liest** und als Projektregeln verarbeitet.

```md title="AGENTS.md"
# Projektregeln

- Verwende `nn-`-Präfixe, wenn ein Ordner eine Lesereihenfolge hat.
- Verlinke nur auf Notizen, die existieren.
- Lösche nie ohne Freigabe.
```

### Wichtige Unterschiede zu Claude Code

| | Claude Code | OpenCode |
|---|---|---|
| Dateiname | `CLAUDE.md` | `AGENTS.md` |
| Fallback auf das andere Format | – | **nein**, V2 liest ausschließlich `AGENTS.md` |
| Hierarchie | global → Projekt → lokal | global → Projekt (bis zum Projekt-Root) |
| Nachträgliches Ändern | neue Regel mit `#` im Chat | Datei im Lauf editieren, wird vor der nächsten Anfrage neu eingelesen |

Bei OpenCode wird die globale Datei `~/.config/opencode/AGENTS.md` geladen, danach alle `AGENTS.md` vom Arbeitsverzeichnis bis zur Projektwurzel. Verschachtelte Dateien werden erst geladen, wenn der Agent in den betreffenden Bereich liest – wer eine verschachtelte `AGENTS.md` ändert, braucht eine neue Sitzung, damit der neue Text greift.

> [!warning] Kein Ersatz für `CLAUDE.md`
> Wer zwischen Claude Code und OpenCode wechselt, braucht **beide** Dateien oder eine, die auf die andere verweist. In diesem Vault liegt das Projektwissen in [[AGENTS]].

Weitere Anweisungen lassen sich über die `instructions`-Liste in der Konfiguration nachladen (Dateien, Globs oder URLs):

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "instructions": ["Struktur-Übersicht.md", "docs/*.md"]
}
```

---

## Konfiguration

Zwei getrennte Dateien, die nicht vermischt werden dürfen:

| Datei | Ort | Inhalt |
|---|---|---|
| `opencode.json(c)` | global `~/.config/opencode/`, projektlokal im Wurzelordner oder `.opencode/` | Server und Projekt: Modell, Agenten, Rechte, MCP, Skills, Plugins |
| `cli.json` | global `~/.config/opencode/cli.json` | Terminal-Only: Theme, Tastenbindungen, Eingabe, Tabs, Diffs |

`cli.json` wird **nicht** projektlokal gelesen. Beim Start liest OpenCode alle `opencode.json(c)` vom Wurzelverzeichnis bis zum aktuellen Verzeichnis und führt sie zusammen – die weiter hinten gefundenen gewinnen.

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "model": "anthropic/claude-sonnet-4-5#high",
  "default_agent": "build"
}
```

Wichtige Felder: `model`, `default_agent`, `permissions`, `agents`, `commands`, `plugins`, `providers`, `mcp`, `skills`, `instructions`, `references`, `formatter`, `lsp`.

---

## Agenten, Befehle, Skills, MCP

| Baustein | Ablage | Aufruf |
|---|---|---|
| **Agent** (Subagent) | `.opencode/agents/<name>.md` | „Nutze den Subagenten `reviewer` für …“ |
| **Befehl** | `.opencode/commands/<name>.md` | `/review $ARGUMENTS` |
| **Skill** | `.opencode/skills/<name>/SKILL.md` | vom Modell selbst geladen oder `@name` |
| **MCP-Server** | `mcp.servers` in `opencode.json` | `opencode mcp add <name> --url <url>` |
| **Plugin** | `plugins` in `opencode.json` | TypeScript/JS, kann Toolaufrufe umhüllen |

Mitgelieferte Agenten: `build` (Hauptagent), `plan` (plant, ändert nichts), `general` und `explore` (Subagenten). Ein eigener Agent ist eine Markdown-Datei:

```md title=".opencode/agents/reviewer.md"
---
description: Prüft Änderungen auf Konsistenz mit den Vault-Regeln
mode: subagent
permissions:
  - action: edit
    resource: "*"
    effect: deny
---

Prüfe die aktuellen Änderungen gegen die Regeln in AGENTS.md.
```

Befehle sind Prompt-Vorlagen und können Shell-Ausgaben einsetzen:

```md title=".opencode/commands/handoff.md"
Erstelle die Übergabe für die nächste Sitzung.

!`git status --short && git log --oneline -10`
```

> [!warning] Shell-Blöcke
> Befehlsblöcke (Ausrufezeichen plus Backticks) laufen, **bevor** der Agent die Berechtigungsabfrage bekommt. Nur Befehle aus vertrauenswürdigen Quellen verwenden.

---

## Berechtigungen

OpenCode prüft jede Aktion gegen eine geordnete Liste; **die letzte passende Regel gewinnt**. Passt keine Regel, wird gefragt.

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "permissions": [
    { "action": "shell", "resource": "*", "effect": "ask" },
    { "action": "shell", "resource": "git status *", "effect": "allow" },
    { "action": "shell", "resource": "git push *", "effect": "deny" }
  ]
}
```

Wirkungen: `allow` (ohne Frage), `ask` (Rückfrage), `deny` (blockiert). Aktionen sind u. a. `read`, `edit`, `glob`, `grep`, `shell`, `subagent`, `skill`, `webfetch`, `external_directory`. Pfade und Befehle lassen sich mit `*` und `?` globben.

---

## Claude Code und OpenCode im Vergleich

| | Claude Code | OpenCode |
|---|---|---|
| Hersteller | Anthropic | offen (anomalyco) |
| Projektgedächtnis | `CLAUDE.md` | `AGENTS.md` |
| Modelle | nur Claude | frei wählbar über Provider |
| Preis | Pro-/Max-Abo oder API | Tool kostenlos, Modell je nach Provider; OpenCode Go 10 $/Monat |
| Oberfläche | Terminal, VS Code, JetBrains, Desktop, Browser | Terminal, Desktop, Web (`opencode pair`) |
| Agenten | Plan-Modus, Subagenten | `build`, `plan`, `general`, `explore`, eigene |
| Erweiterungen | Skills, Hooks, MCP | Skills, Plugins, MCP |
| Git-Integration | eingebaut | über Shell-Befehle |
| Architektur | Client | Client-Server, gemeinsamer Hintergrunddienst |

Der Wechsel ist unproblematisch, weil beide dieselben Werkzeuge (Terminal, Dateien, Git) bedienen. Umzuziehen heißt vor allem: `CLAUDE.md` nach `AGENTS.md` überführen und die Provider einrichten.

---

## OpenCode in diesem Vault

Der Arbeitsablauf ist derselbe wie unter Claude Code, nur mit anderem Werkzeug. Die vollständigen Regeln stehen in [[AGENTS]].

| Schritt | Was passiert |
|---|---|
| 1. Ablegen | Dokument nach `00-Inbox/` legen, Protokolle als `JJJJ-MM-TT Thema.md` |
| 2. Einordnen | OpenCode nennt Zielordner, Dateiname, Frontmatter, Verweise |
| 3. Verschieben | `git mv` erhält die Historie |
| 4. Verlinken | Ziel-Ordner und verwandte Notizen verbinden, [[Struktur-Übersicht]] und [[Eingang]] nachführen |

Beim Einordnen helfen zwei Karten:

- **[[AGENTS]]** – die Projektregeln, die OpenCode bei jedem Start liest: Ordnerlogik, Frontmatter, Wikilinks, Git-Workflow, Secrets-Regel.
- **[[HANDOFF]]** – die Übergabe zwischen den Sitzungen: Was war zuletzt offen, was ist entschieden, was kommt als Nächstes. Wird am Ende einer Arbeitsphase aktualisiert.

Der Tipp aus dem Claude-Code-Vergleich: OpenCode liest `CLAUDE.md` **nicht**. Ein Wechsel zurück bedeutet also, die Regeln aus `AGENTS.md` nach `CLAUDE.md` zu spiegeln.

### Praxisbefunde auf dem Referenzsystem

- `opencode service status` prüft den Hintergrunddienst; `opencode service restart` setzt ihn zurück, wenn Sessions oder Provider hängen.
- Das Log liegt unter `~/.local/share/opencode/log/opencode.log`; `role=cli` zeigt den Client-Start, `role=server` Sessions, Provider und Rechte.
- Für einen einmaligen Test ohne den gemeinsamen Dienst: `opencode --standalone`.
- Der Web-Zugang startet mit `opencode pair`; der Link läuft fünf Minuten und ist einmalig.

---

## Grenzen und offene Punkte

- **Kein Claude-Mitbringsel.** Anthropic-Modelle laufen zwar über den Anthropic-Provider, aber Claude-spezifische Funktionen wie `CLAUDE.md`, der Anthropic-Account-Login oder die Plan-Modus-Slash-Befehle gibt es nicht.
- **Windows-Paketmanager** werden nicht unterstützt (ZIP oder Scoop/Chocolatey selbst nutzen).
- **Skill-Kompatibilität:** OpenCode liest Skills aus `.opencode/skills/`, aber auch aus `.claude/skills/` und `.agents/skills/` – bestehende Claude-Skills bleiben also nutzbar.
- **Nicht verifiziert:** Verhalten von `opencode pair` und der Desktop-App auf diesem System; getestet wurde die Terminal-Variante unter Fedora.

---

## Verwandt

- [[AGENTS]] – Projektregeln im Vault, von OpenCode automatisch geladen
- [[00 Claude Code|Claude Code]] – der Vorgänger im Terminal
- [[chat-protokoll – Skill einbinden]] – Skill-Aufbau, übertragbar auf OpenCode
- [[Struktur-Übersicht]] – Aufbau des Vaults
- [[Eingang]] – Eingangsablauf
- [[HANDOFF]] – Übergabe zwischen Sitzungen
