## Liste der eigenen Projekte ermitteln
- Web-UI: Linke Seitenleiste → „Projects" zeigt alle Projekte des aktiven Kontos.
- API-Weg (technisch): URL `https://claude.ai/api/organizations/{org_id}/projects` ist die interne Route, die die Browser-Extensions verwenden, um Projekt-IDs aufzulisten. Funktioniert mit dem Session-Cookie des eingeloggten Browsers — keine offizielle, aber stabile Methode (vorausgesetzt, man akzeptiert die Risiken inoffizieller Endpunkte).

## Seriöse Open-Source-Tools

| Tool | Typ | Zweck | Risikohinweis |
|---|---|---|---|
| `agoramachina/claude-exporter` | Browser-Extension (Chrome/Firefox; Fork des etablierten `socketteer/Claude-Conversation-Exporter`) | Bulk-Export aller Chats inkl. Artifact-Extraktion, Projektsortierung, Markdown/JSON/Plain Text | Liest aus claude.ai-API mit der vorhandenen Session — keine Cookies an Dritte. Code ist Open Source. |
| `socketteer/Claude-Conversation-Exporter` | Chrome-Extension | Stabiles Original-Tool, ähnlicher Funktionsumfang | wie oben |
| `agarwalvishal/claude-chat-exporter` | JS-Snippet für die Browser-Konsole | Einzelne Chats mit perfekter Markdown-Treue (nutzt Claudes nativen Copy-Button) | Konsole-Skript: nur ausführen, wenn Quelltext geprüft wurde. |
| `withLinda/claude-project-knowledge-exporter` | Bookmarklet | Project-Knowledge-Inhalte als MD/JSON sichern (Texte, **nicht** Original-PDFs) | Läuft 100 % client-side. |
| `osteele/claude-chat-viewer` | Lokale Web-App | Offiziell exportierte JSON/ZIP lesbar darstellen, Artifacts entpacken | Reine Statik, keine Server-Übertragung. |
| `sawinyh/claude-mcp-export` (Nick Sawinyh) | MCP-Server + SQLite-FTS5 | Lokales Such-/Recall-Backend für die exportierte JSON, das man im neuen Account in Claude Desktop als MCP-Connector einbinden kann | Vom Autor selbst beziffert: „The whole thing is ~300 lines of Python with no external dependencies beyond the MCP SDK and SQLite (which is built into Python)." (sawinyh.com/blog/claude-export-no-import) |

> **Allgemeines Sicherheitsthema:** Alle Drittanbieter-Tools nutzen das **Session-Cookie / Auth-Token** des angemeldeten Browsers. Sie umgehen keine Sicherheitsmaßnahme, aber jedes Tool, das Sie installieren, hat damit Lese-Zugriff auf Ihren gesamten Claude-Account. Daher ausschließlich Open-Source-Tools mit gut sichtbarem Repo, geprüfter Permission-Liste und idealerweise lokaler Verarbeitung verwenden. Browser-Store-Extensions ohne Repo-Link gehören nicht in einen Migrations-Workflow mit sensitiven Inhalten.

## Vollständige saubere Migration – Schritt für Schritt

**Phase A — Vorbereitung im alten Konto** (vor jeder Kündigung!):

1. **Projekt-Inventar erstellen:** In der Sidebar alle Projekte durchgehen, Namen + Beschreibungen notieren (CSV).
2. **Pro Projekt: „Migration Summary"-Prompt** im jeweiligen Projekt-Chat ausführen (ein bewährtes Vorgehen aus dem Erfahrungsbericht von Miguel Guhlin, mguhlin.org):
   ```
   You have access to this project's instructions, knowledge base, and our
   conversation history. Please produce a structured migration summary with
   these sections: Project Purpose, Custom Instructions (verbatim),
   Key Decisions and Outcomes, Work in Progress, Knowledge Base Contents,
   Recurring Context, Recommended Starting Prompt.
   ```
   Das produziert pro Projekt ein in sich abgeschlossenes Migrations-Dokument.
3. **Custom Instructions verbatim sichern** (Edit-Projekt → Instructions → kopieren in lokale `.md`).
4. **Project-Knowledge-Files lokalisieren:** Wenn lokale Originale existieren → diese sichern. Wenn nicht → `withLinda/claude-project-knowledge-exporter` Bookmarklet pro Projekt ausführen.
5. **Account-Level Custom Instructions / Profile Preferences** kopieren (Settings → Profile).
6. **Memory exportieren** (Settings → Capabilities → View and edit your memory → kopieren).
7. **Skills herunterladen** (Customize → Skills).
8. **Connectors-Liste dokumentieren** (Welche OAuth-Verbindungen, welche Custom-MCP-URLs?).
9. **Offiziellen Daten-Export** anstoßen (Settings → Privacy → Export data) → ZIP herunterladen, lokal extrahieren.
10. **Lesbare Markdown-Backups** der wichtigsten Chats mit `agoramachina/claude-exporter` (Bulk-Export → ZIP mit Markdown + Artifacts).

**Phase B — Aufbau im neuen Konto:**

11. Neues Konto mit der neuen E-Mail registrieren (Free reicht initial), 2FA/Telefon konfigurieren.
12. Profile Preferences und Account-Level Custom Instructions einsetzen.
13. **Memory-Import** unter Settings → Capabilities → „Start import" — Memory-Text einfügen.
14. Pro Projekt: neues Projekt anlegen, Custom Instructions einfügen, Knowledge-Files (lokale Originale, **nicht** die geparsten Markdown-Versionen, falls Originale verfügbar) hochladen, Migration Summary aus Phase A als ersten Chat-Kontext einfügen.
15. Connectors neu verbinden, Custom Skills neu hochladen.
16. Falls gewünscht: Pro/Max-Abo abschließen.
17. **Optional**: `sawinyh/claude-mcp-export` einrichten und als Custom MCP Connector einbinden — damit kann das neue Claude über den `search_history` / `get_conversation` Tool-Call lesend in die alten Chats blicken, ohne sie 1:1 zu importieren.

**Phase C — Altes Konto stilllegen:**

18. Pro/Max-Abo kündigen (Settings → Billing → Cancel) — **mindestens 24 h vor Renewal-Datum**, sonst greift erst die nächste Periode. Bei Apple/Google IAP **dort** kündigen.
19. Ende der laufenden Periode abwarten.
20. Bei Bedarf Telefonnummer-Unlink und Account-Löschung beim Support beantragen, **nachdem** alle lokalen Backups verifiziert sind.
21. Settings → Account → „Delete Account" — endgültig.
