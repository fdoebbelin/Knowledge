---
title: Obsidian-Ordner als PDF exportieren
created: 2026-09-22
type: chat-protokoll
source: claude.ai
model: Claude Opus 5
tags:
  - chat-protokoll
  - obsidian
  - pandoc
  - pdf-export
status: active
---

# Obsidian-Ordner als PDF exportieren

> [!summary] Zusammenfassung
> Frage war, ob sich in [[Obsidian]] ein kompletter Ordner als eine PDF-Datei exportieren lässt. Der eingebaute Export arbeitet nur mit der jeweils geöffneten Notiz. Als Wege wurden drei Varianten genannt: eine Sammelnotiz mit Einbettungen, das Community-Plugin „Better Export PDF“ und [[Pandoc]] über die Kommandozeile. Empfehlung: Sammelnotiz für schnelle Ergebnisse, Pandoc für wiederholbare, automatisierte Exporte.

## Ausgangslage

Reine Wissensfrage ohne konkreten Vault, Fehler oder Umgebungsangaben: „kann ich in Obsidian einen kompletten Ordner als PDF-Datei exportieren“.

## Problemlösungen

### 1. Mehrere Notizen in eine PDF bringen

**Symptom**

```text
Obsidians „Als PDF exportieren“ erfasst nur die aktuell geöffnete Notiz, nicht einen ganzen Ordner.
```

**Ursache:** Der eingebaute PDF-Export ist notizbezogen; eine Ordnerfunktion gibt es in Obsidian selbst nicht.

**Lösung** – drei Varianten:

**a) Sammelnotiz mit Einbettungen (ohne Plugin).** Eingebettete Notizen werden beim PDF-Export mitgerendert; die Reihenfolge ist frei wählbar.

```markdown
# Kapitel Linux-Grundlagen

![[01 Einführung]]
![[02 Dateisystem]]
![[03 Benutzer und Rechte]]
```

Nachteil: Die Liste muss von Hand gepflegt werden.

**b) Community-Plugin „Better Export PDF“.** Ergänzt Inhaltsverzeichnis, Seitenzahlen, Kopf-/Fußzeilen und Lesezeichen. Ordnerexport per Rechtsklick auf den Ordner im Dateiexplorer – im Chat nur „soweit bekannt“ angegeben, nicht verifiziert.

**c) Pandoc auf der Kommandozeile.** Reproduzierbar und skriptfähig:

```bash
pandoc Ordner/*.md -o ordner.pdf --pdf-engine=xelatex --toc -V lang=de
```

Reihenfolge folgt der alphabetischen Sortierung, daher Nummernpräfixe (`01_`, `02_` …) verwenden. Pandoc löst `[[Wikilinks]]`, `![[Einbettungen]]` und Callouts **nicht** auf; diese vorher umwandeln, z. B. mit dem Plugin „Enhancing Export“, das Pandoc aus Obsidian heraus aufruft und die Obsidian-Syntax berücksichtigt.

**Verifikation:** Im Chat nicht durchgeführt.

## Artefakte & Prompts

Keine Artefakte erzeugt.

## Entscheidungen

- Sammelnotiz für schnelle Einzelexporte – kein Plugin nötig, Reihenfolge frei steuerbar.
- Pandoc für regelmäßige, automatisierte Exporte – reproduzierbar und in Build-Skripte einbindbar.

## Nützliche Befehle & Snippets

```bash
pandoc Ordner/*.md -o ordner.pdf --pdf-engine=xelatex --toc -V lang=de  # Ordner zu einer PDF mit Inhaltsverzeichnis
```

## Offene Punkte

- [x] Prüfen, ob „Better Export PDF“ in der aktuellen Version den Ordnerexport per Rechtsklick noch unter diesem Namen anbietet. — Version 2.0.3 ist seit 22.09.2026 im Vault installiert und enthält den Menüeintrag „Export folder to PDF“. Belegt im Plugin-Code, in Obsidian selbst noch nicht ausprobiert.
