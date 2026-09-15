OpenClaw's long-term memory is a sophisticated file-based system that uses local Markdown files as its source of truth, combined with a **hybrid search index** (semantic vectors + keyword search) for intelligent recall .

Here is a breakdown of its key technical components:

| Komponente | Technische Umsetzung & Speicherort |
| :--- | :--- |
| **Memory Files (Quelle)** | Klartext-Markdown-Dateien im Workspace-Verzeichnis . |
| **Vektor-Embeddings** | Texte werden in numerische Vektoren umgewandelt (via OpenAI, Gemini oder lokalem Modell) . |
| **Suchindex & Datenbank** | Ein **SQLite**-Datenbankfile mit Vektor- (`sqlite-vec`) und Volltextsuche (`FTS5`) . |
| **Einbettungs-Cache** | Separate SQLite-Tabelle zur Vermeidung wiederholter Einbettungs-API-Aufrufe für unveränderte Texte . |

### 💾 Die Kern-Architektur: Dateien und Index
Das System folgt einem Zwei-Schichten-Ansatz, der Benutzerfreundlichkeit mit leistungsfähiger Suche verbindet.

*   **Dateibasierte Speicherung**: Alle Erinnerungen werden als einfache Markdown-Dateien in einem definierten Workspace (standardmäßig `~/.openclaw/workspace/`) gespeichert .
    *   `memory/YYYY-MM-DD.md`: Tägliches, nur-anhängendes Protokoll für Kontext und Notizen.
    *   `MEMORY.md`: Kuratiertes, langfristiges Gedächtnis für dauerhafte Fakten, Entscheidungen und Präferenzen .
*   **Automatische Indizierung**: Ein Hintergrundprozess (**Watcher**) überwacht diese Dateien auf Änderungen . Geänderte oder neue Inhalte werden in **Chunks** (ca. 400 Token) aufgeteilt, in Vektoren umgewandelt und zusammen mit ihrem Pfad und Zeilennummern in der SQLite-Datenbank indexiert .

### 🔍 Der Hybrid-Suchmechanismus
Die eigentliche Intelligenz der Erinnerungssuche liegt in der Kombination zweier Suchmethoden:
1.  **Vektor-/Semantische Suche**: Findet Inhalte mit **ähnlicher Bedeutung**, auch wenn andere Worte verwendet werden (z.B. "Rechner für das Gateway" vs. "die Maschine, auf der OpenClaw läuft") .
2.  **BM25-/Keyword-Suche**: Findet exakte **Schlüsselwörter, IDs oder Code-Snippets** zuverlässig (z.B. Fehlermeldungen oder Commit-Hashes) .

Die Ergebnisse beider Methoden werden gewichtet kombiniert (`vectorWeight` + `textWeight = 1.0`), um eine endgültige, relevante Rangliste zu erstellen .

### ⚡ Auto-Recall: Zuverlässiger als Tool-Aufrufe
Ein entscheidendes Architekturmerkmal ist der **Auto-Recall**. Statt dem KI-Modell ein "search_memory"-Tool zur Verfügung zu stellen, das es vergessen könnte zu nutzen, injiziert OpenClaw vor der Verarbeitung einer Nutzeranfrage automatisch die relevantesten Erinnerungen aus dem Index in den Kontext der Anfrage . Dies stellt sicher, dass vorhandenes Wissen auch tatsächlich genutzt wird.

### ⚙️ Technische Konfiguration und Anpassung
Das System ist hochgradig konfigurierbar:
*   **Einbettungs-Provider**: Wahl zwischen Cloud-APIs (OpenAI, Gemini) oder lokalen Modellen (über `node-llama-cpp`), um Kosten und Privatsphäre zu kontrollieren .
*   **Automatische Speicher-Auffrischung**: Wenn eine Konversation den Kontextfenster-Grenzwert erreicht, löst OpenClaw automatisch einen internen Prompt aus, der das Modell auffordert, dauerhafte Erinnerungen in die Markdown-Dateien zu schreiben, bevor der Kontext gekürzt wird .

### 💡 Fazit zur Architektur
Zusammengefasst ist OpenClaws Gedächtnis ein durchdachtes **"Local-First"**-System. Es nutzt einfache, portable Dateien für maximale Kontrolle und Transparenz, während eine leistungsstarke, hybride SQLite-Indexierung im Hintergrund schnelle und intelligente semantische Abfragen ermöglicht. Der Auto-Recall-Mechanismus stellt die praktische Nutzbarkeit sicher.