# Knowledge – Wissensbasis für Linux & Softwareentwicklung

Meine Wissensbasis als **Zettelkasten**: viele kleine, eigenständige Notizen, die über Links zu Themen zusammenwachsen. Sie bündelt Wissen aus vielen Jahren als IT-Trainer – zu Linux, Softwareentwicklung, Virtualisierung und Containern.

**Lesen:** <https://fdoebbelin.github.io/Knowledge/> – mit Suche, Rückverweisen und Graph-Ansicht.

## Für wen?

Für alle, die sich für IT interessieren, besonders für

- **Linux** und Serveradministration
- **Softwareentwicklung** (u. a. Python, Rust, SQL, Desktop-Apps)
- **Virtualisierung und Container** (KVM, Podman, Incus, bootc)
- Auszubildende zum **Fachinformatiker** (FISI/FIAE) und alle, die sie begleiten

Kursmaterial liegt in eigenen Repositorys; die Wissensbasis verweist darauf.

## Aufbau

| Ordner | Inhalt |
|---|---|
| `zettel/` | Dauernotizen – je Notiz genau ein Gedanke |
| `struktur/` | Strukturzettel – Einstiege und Lesepfade zu Themen |
| `quellen/` | Literaturnotizen zu Büchern, Artikeln, Dokumentationen, Kursen |
| `inbox/` | Eingang, noch nicht verarbeitet (wird nicht veröffentlicht) |
| `_resources/` | Bilder und Anhänge |

Einstieg ist [index.md](index.md). Die Regeln für die Pflege – auch durch KI-Agenten – stehen in [AGENTS.md](AGENTS.md).

## In Obsidian öffnen

```bash
git clone https://github.com/fdoebbelin/Knowledge.git
git config core.hooksPath .githooks   # Prüfung vor jedem Commit (braucht Nushell)
```

Den Ordner in Obsidian als Vault öffnen – dann funktionieren Links, Rückverweise und Graph-Ansicht.

Website lokal ansehen (braucht Node.js 22 und Nushell): `nu scripts/website.nu --serve`, dann <http://localhost:8080>.

## Mitmachen

Fehler gefunden oder eine Anregung? Gern über [Issues](https://github.com/fdoebbelin/Knowledge/issues).

## Lizenz

Inhalte stehen unter [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/deed.de) – frei nutzbar mit Namensnennung und Weitergabe unter gleichen Bedingungen. Skripte unter `scripts/` stehen unter der MIT-Lizenz.
