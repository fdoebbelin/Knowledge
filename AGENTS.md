---
title: AGENTS
type: meta
---

# Knowledge – Regeln für KI-Agenten

Dieses Repository ist die öffentliche Wissensbasis `fdoebbelin/Knowledge`, aufgebaut als **Zettelkasten** in Obsidian. Inhalte auf Deutsch, Zielgruppe IT-Interessierte, besonders Linux und Softwareentwicklung.

Diese Datei ist die **einzige Quelle** für die Regeln. Claude Code liest sie über `CLAUDE.md` (`@AGENTS.md`), OpenCode liest sie direkt. Wer eine Regel ändert, ändert sie hier.

## Arbeitsweise

1. **Erst lesen, dann schreiben.** Vor jedem neuen Zettel `index.md`, den passenden Strukturzettel und die Nachbarzettel lesen. Mit `nu scripts/neu.nu suchen <stichwort>` prüfen, ob es den Gedanken schon gibt.
2. **Nichts erfinden.** Keine Links ins Leere, keine erfundenen Quellen, keine erfundenen Frontmatter-Schlüssel.
3. **Nachfragen statt raten.** Zerlegung, Titel und Einordnung vorschlagen und bestätigen lassen, bevor geschrieben wird.
4. **Nicht löschen.** Dateien nur mit ausdrücklicher Freigabe entfernen.
5. **Kleine Schritte.** Ein Commit je abgeschlossener Einheit (ein neuer Gedanke, eine übernommene Altnotiz). Vor jedem Commit `nu scripts/pruefen.nu` – Fehler werden behoben, nicht übergangen.
6. **Kein Push** ohne Freigabe.

## Die vier Notiztypen

Ordner richten sich nach dem **Typ** der Notiz, nicht nach dem Thema. Themen entstehen über Links und Strukturzettel.

| Ordner | `type` | Inhalt | veröffentlicht |
|---|---|---|---|
| `inbox/` | `inbox` | Flüchtiges: Einfälle, Clippings, Chat-Protokolle, unfertige Notizen. Keine Dauerablage. | nein |
| `quellen/` | `quelle` | Literaturnotiz: eine Quelle (Buch, Artikel, Doku, Kurs, Altnotiz) – Kernaussagen **in eigenen Worten** | ja |
| `zettel/` | `zettel` | Dauernotiz: **genau ein Gedanke**, eigenständig verständlich, flach in einem Ordner | ja |
| `struktur/` | `struktur` | Strukturzettel: Einstieg in ein Thema, geordnete Linkliste mit kurzem Kommentar je Link | ja |
| `_resources/` | – | Anhänge (Bilder, PDF) | nur wenn verlinkt |
| `index.md` | `struktur` | Startseite, verlinkt alle Strukturzettel | ja |

`vorlagen/`, `scripts/`, `_meta/` und die Dateien im Hauptverzeichnis werden nicht veröffentlicht.

## Was ein guter Zettel ist

- **Ein Gedanke.** Lässt sich der Titel nicht als eine Aussage oder eine klare Frage formulieren, ist es mehr als ein Zettel.
- **Titel als Aussage**, nicht als Schlagwort: „Hardlinks teilen sich eine Inode“ statt „Hardlinks“. Ausnahme: Begriffszettel, die einen Fachbegriff definieren („Inode“).
- **Keine H1-Überschrift.** Der Titel kommt aus Dateiname und `title`; Obsidian und die Website zeigen ihn selbst an. Gliederung mit `##`.
- **Eigenständig.** Der Zettel ist ohne seine Quelle verständlich. 5–30 Zeilen Fließtext, Code- und Befehlsbeispiele erlaubt.
- **Vernetzt.** Jeder Zettel hat mindestens einen Link auf einen anderen Zettel und steht in mindestens einem Strukturzettel. Links im Abschnitt „Verbindungen“ bekommen einen Halbsatz, *warum* sie verbunden sind.
- **Mit Herkunft.** Stammt der Gedanke aus einer Quelle, verweist „Quellen“ auf die Literaturnotiz.

## Dateinamen und Links

- **Dateiname = Titel**, vault-weit eindeutig, ohne `/ \ : * ? " < > | # ^ [ ]`. Keine „Unbenannt“, keine „(1)“-Kopien.
- **Wikilinks** `[[Titel]]` oder `[[Titel|Anzeigetext]]` – nie Markdown-Links auf eigene Notizen.
- **Schreibweise exakt wie der Dateiname.** Obsidian ist bei Links tolerant, die veröffentlichte Seite (Quartz) unterscheidet Groß- und Kleinschreibung. `pruefen.nu` meldet Abweichungen.
- **Umbenennen** nur über Obsidian oder mit Nachziehen aller Links. Der alte Titel kommt in `aliases` – Quartz legt dafür eine Weiterleitung an, alte Adressen bleiben gültig.
- **Anhänge** liegen in `_resources/`, eingebunden mit `![[datei.png]]`.

## Frontmatter

Schlüssel englisch und kleingeschrieben, Werte deutsch. Pflicht für `zettel`, `quelle`, `struktur`:

```yaml
---
id: 202611190712          # Zeitstempel JJJJMMTThhmm, eindeutig, ändert sich nie
title: Hardlinks teilen sich eine Inode
type: zettel              # zettel | quelle | struktur | inbox
tags:
  - linux/dateisystem
created: 2026-11-19
---
```

Optional: `aliases` (frühere Titel), `herkunft` (Pfad der Altnotiz im Archiv, siehe Migration), `status: entwurf` (noch nicht fertig), `draft: true` (nicht veröffentlichen). Bei `quelle` zusätzlich `autor`, `url`, `art` (buch | artikel | doku | video | kurs | archiv).

Die `id` ist die Identität des Zettels. Sie bleibt beim Umbenennen gleich und verknüpft Zettel mit dem Migrationsprotokoll.

**Tags** sparsam und hierarchisch (`linux/dateisystem`, `python/tooling`). Tags ersetzen keine Strukturzettel.

## Befehle

Die Logik steckt in Nushell-Skripten unter `scripts/`. Die Befehle für Claude Code (`.claude/commands/`) und OpenCode (`.opencode/commands/`) sind gleich und rufen nur diese Verfahren auf.

| Befehl | Verfahren |
|---|---|
| `/zettel-neu <gedanke>` | Neuer Zettel |
| `/migrieren <altpfad>` | Altnotiz übernehmen |
| `/verlinken <titel>` | Verbindungen vorschlagen |
| `/struktur <thema>` | Strukturzettel anlegen oder nachführen |
| `/pruefen` | Prüfung und Bericht |

Weitere Skripte: `nu scripts/migration.nu offen|uebersicht` (Stand der Übernahme), `nu scripts/website.nu --serve` (Website lokal ansehen unter http://localhost:8080). Alle Skripte brauchen Nushell ab 0.114.

### Verfahren: Neuer Zettel

1. `nu scripts/neu.nu suchen <stichwort>` – gibt es den Gedanken schon? Dann ergänzen statt doppeln.
2. Titel als Aussage vorschlagen, bestätigen lassen.
3. `nu scripts/neu.nu zettel "<Titel>"` legt die Datei mit `id` und Vorlage an.
4. Text schreiben, mindestens einen Link setzen, in einen Strukturzettel eintragen.
5. `nu scripts/pruefen.nu`, dann Commit `zettel: <Titel>`.

### Verfahren: Altnotiz übernehmen (Migration)

Quelle ist das archivierte alte Repository. Sein Pfad steht in der Umgebungsvariable `KNOWLEDGE_ARCHIV` – keine hartcodierten Pfade.

1. `nu scripts/migration.nu status <altpfad>` – schon übernommen? Dann abbrechen und melden.
2. Altnotiz und ihre Nachbarn im Archiv lesen.
3. **Zerlegung vorschlagen:** Liste der Zettel (Titel + ein Satz), dazu eine `quelle`, wenn die Altnotiz selbst eine Quelle zusammenfasst. Bestätigen lassen.
4. Zettel anlegen (`neu.nu`), `herkunft: <altpfad>` setzen, Inhalt **neu formulieren**, nicht kopieren. Veraltetes weglassen und im Bericht nennen.
5. Benötigte Anhänge nach `_resources/` kopieren.
6. Verlinken und Strukturzettel nachführen.
7. `nu scripts/migration.nu eintragen <altpfad> <ergebnis> [notiz]` – Ergebnis `uebernommen`, `teilweise` oder `verworfen`.
8. `nu scripts/pruefen.nu`, dann Commit `migration: <altpfad>`.

**Kursmaterial** wird nicht als Ganzes übernommen: Kurse werden eigene Repositorys. Aus Kursen wandert nur wiederverwendbares Wissen als Zettel herüber; der Kurs selbst bekommt eine `quelle` mit Link auf sein Repository.

### Verfahren: Verbindungen vorschlagen

Zettel lesen, mit `neu.nu suchen` verwandte Zettel finden, 3–5 Verbindungen mit Begründung vorschlagen. Erst nach Bestätigung eintragen – in beide Richtungen, wenn es inhaltlich trägt.

### Verfahren: Strukturzettel

Ein Strukturzettel ist kein Inhaltsverzeichnis, sondern ein **Lesepfad**: Links in sinnvoller Reihenfolge, je Link ein Halbsatz Kommentar, Zwischenüberschriften für Abschnitte. Neue Strukturzettel werden in `index.md` eingetragen. `pruefen.nu` listet verwaiste Zettel, die noch in keinen Strukturzettel gehören.

## Inbox

Die Inbox wird geleert, nicht gepflegt: Jede Notiz wird zu Zetteln/Quellen verarbeitet oder verworfen. Zettel und Strukturzettel verlinken nie auf Inbox-Notizen.

## Sitzungsübergabe

Am Ende einer Sitzung `_meta/handoff.md` nachführen: Stand, Erledigtes, nächster Schritt, offene Entscheidungen. Kurz halten – die Details stehen in den Commits.
