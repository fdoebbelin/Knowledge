---
title: chat-protokoll – Skill einbinden
tags:
  - claude
  - skill
  - obsidian
  - chat-protokoll
created: 2026-09-22
updated: 2026-09-22
status: active
---

# chat-protokoll – Skill einbinden

Wie die Frontmatter-Vorgabe [[chat-protokoll – frontmatter]] in den Skill `chat-protokoll` kommt. Die Datei ist bewusst ohne Wikilinks und ohne Vault-Bezug geschrieben, sie funktioniert also unverändert innerhalb des Skills.

## Aufbau eines Skills

Ein Skill ist ein Ordner mit einer `SKILL.md` und optionalen Begleitdateien:

```
chat-protokoll/
├── SKILL.md              # Anweisungen, wird immer geladen
└── references/
    └── frontmatter.md    # diese Vorgabe, wird bei Bedarf gelesen
```

`SKILL.md` beginnt mit YAML-Frontmatter (`name`, `description`), danach folgen die Anweisungen in Markdown. Begleitdateien werden **nicht** automatisch mitgeladen; sie werden erst gelesen, wenn die `SKILL.md` ausdrücklich darauf verweist. Das hält den Kontext klein und ist bei einer Detailvorgabe wie dieser genau richtig.

## Einbinden – Weg A: als Begleitdatei (empfohlen)

1. [[chat-protokoll – frontmatter]] als `references/frontmatter.md` in den Skill-Ordner legen.
2. In `SKILL.md` an der Stelle, an der das Protokoll erzeugt wird, einen Verweis ergänzen:

```markdown
## Frontmatter

Jedes Protokoll beginnt mit YAML-Frontmatter. Die verbindliche Vorgabe für
Schlüssel, Reihenfolge und Werte steht in `references/frontmatter.md` –
diese Datei vor dem Schreiben des Protokolls lesen und genau befolgen.
```

3. Skill hochladen bzw. den Ordner ersetzen und an einem alten Chat testen.

**Vorteil:** Die Vorgabe lässt sich ändern, ohne die Anweisungen des Skills anzufassen, und kostet nur dann Kontext, wenn sie gebraucht wird.

## Einbinden – Weg B: direkt in die SKILL.md

Wenn der Skill aus einer einzigen Datei bestehen soll: den Abschnitt „Vorlage", die Schlüssel-Tabelle und die `status`-Werte aus [[chat-protokoll – frontmatter]] in die `SKILL.md` kopieren, unter eine Überschrift `## Frontmatter`. Der Rest (Dateiname, Tags, alte Schlüssel) kann entfallen.

**Nachteil:** Der ganze Text wird bei jedem Aufruf geladen, und die Vorgabe liegt an zwei Orten.

## Was sonst noch in die SKILL.md gehört

Diese Punkte haben sich an den ersten beiden Protokollen gezeigt:

- **Dateiname** `YYYY-MM-TT Thema.md`, eindeutig im ganzen Vault.
- **Ablage:** Neue Protokolle nach `00-Inbox/`, nicht in die Wurzel. Einsortiert wird später, siehe [[Eingang]].
- **Platzhalter statt echter Daten:** IP-Adressen, Hostnamen, Seriennummern und Zugangsdaten ersetzen und im Abschnitt „Hinweise zur Vollständigkeit" auflisten. Der Vault ist ein Git-Repository.
- **Falsches als falsch kennzeichnen:** Irrtümer aus dem Chat nicht stillschweigend korrigieren, sondern als Irrtum benennen. Das ist in beiden Protokollen bereits so gelöst und hat sich bewährt.
- **Wikilinks sparsam:** Nur auf Themen verweisen, zu denen es eine Notiz gibt oder geben soll. Jeder Verweis ins Leere ist Nacharbeit – nach den ersten beiden Protokollen waren sieben Stichwortnotizen nachzutragen.
- **Abschnitte:** Zusammenfassung, Hinweise zur Vollständigkeit, Ausgangslage, Problemlösungen, Artefakte & Prompts, Entscheidungen, Nützliche Befehle & Snippets, Offene Punkte.

## Prüfen nach der Umstellung

```nu
# Frontmatter aller Protokolle im Vault anzeigen
rg -l '^type: chat-protokoll' --glob '*.md'
| lines
| each {|f| {datei: ($f | path basename), text: (open --raw $f)} }
| where {|r| $r.text | str starts-with '---' }
| each {|r| $r.text | split row --number 3 '---' | get 1 | from yaml
            | select title created source model status | insert datei $r.datei }
| flatten
| select datei created source model status
```

Der Anker `^` und die Prüfung auf `---` am Dateianfang sind nötig, sonst zählen Beispielblöcke in dieser Dokumentation mit.

## Verwandt

- [[chat-protokoll – frontmatter]] – die Vorgabe selbst
- [[Struktur-Übersicht#Chat-Protokolle (Skill chat-protokoll)]] – Einordnung im Vault
- [[Eingang]] – Ablauf vom Protokoll bis zur eingeordneten Notiz
