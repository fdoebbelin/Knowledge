---
title: Pandoc
tags:
  - pandoc
  - markdown
  - pdf
  - konvertierung
created: 2026-09-23
updated: 2026-09-23
status: draft
---

# Pandoc

Konverter zwischen Dokumentformaten, vor allem Markdown nach PDF, DOCX, HTML und zurück. Arbeitet auf der Kommandozeile und ist damit skriptfähig und wiederholbar.

> [!note] Stichwortnotiz
> Auf dem Referenzsystem (Fedora Sway Atomic) ist Pandoc nicht installiert; `brew install pandoc` wäre der Weg. PDF-Ausgabe braucht zusätzlich eine TeX-Engine wie `xelatex`.

## Typische Aufrufe

```bash
# Ganzen Ordner zu einer PDF mit Inhaltsverzeichnis
pandoc Ordner/*.md -o ordner.pdf --pdf-engine=xelatex --toc -V lang=de

# Markdown nach Word
pandoc datei.md -o datei.docx --from markdown+tex_math_dollars --to docx
```

Die Reihenfolge folgt der alphabetischen Sortierung, deshalb Nummernpräfixe (`01_`, `02_` …) verwenden.

> [!warning] Obsidian-Syntax kennt Pandoc nicht
> `[[Wikilinks]]`, `![[Einbettungen]]` und Callouts werden nicht aufgelöst. Entweder vorher umwandeln oder aus Obsidian heraus ein Plugin nutzen, das Pandoc mit passender Vorverarbeitung aufruft.

## Verwandt

- [[2026-09-22 Obsidian Ordner als PDF exportieren]] – Vergleich der Exportwege
- [[pandoc-Wrapper]] – Nushell-Funktion `md2docx` für Stapelkonvertierung
- [[00 Markdown zu Word]] – Kursnotiz zum selben Thema
- [[Obsidian]]
